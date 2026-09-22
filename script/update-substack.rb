#!/usr/bin/env ruby
# frozen_string_literal: true

# Refreshes _data/substack.yml from the lab's Substack RSS feed.
#
#   ruby script/update-substack.rb
#
# The homepage renders whatever is in that file, so the posts it lists only
# change when someone runs this and commits the result. That is deliberate:
# GitHub Pages builds with a fixed plugin set and no network access, so the
# feed cannot be read at build time, and reading it from the browser would put
# a third-party request on every page load. Committing the data keeps the
# published page self-contained and reviewable.
#
# Only the standard library is used, so this runs with plain `ruby` — no
# bundle, no gems.

require "net/http"
require "uri"
require "rexml/document"
require "yaml"
require "cgi"
require "time"

ROOT = File.expand_path("..", __dir__)
CONFIG = File.join(ROOT, "_config.yml")
OUTPUT = File.join(ROOT, "_data", "substack.yml")

# How many posts the homepage lists. This is the only edit needed to show more
# or fewer; the template loops over whatever ends up in the file.
POST_COUNT = 3

# Substack serves the feed to a request that identifies itself; the bare
# default Ruby user agent gets turned away.
USER_AGENT = "aigovlab-website-feed-fetcher (+https://aigovlab.github.io/lab-website)"

# The newsletter URL lives in _config.yml so the site and this script cannot
# drift apart. YAML.load_file is enough — the config is plain scalars.
def feed_url
  base = YAML.load_file(CONFIG)["substack_url"]
  abort "No `substack_url` in _config.yml" if base.nil? || base.empty?

  URI.join(base, "feed")
end

def fetch(uri, redirects_left = 5)
  abort "Too many redirects fetching #{uri}" if redirects_left.zero?

  response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
    http.request(Net::HTTP::Get.new(uri, "User-Agent" => USER_AGENT))
  end

  case response
  when Net::HTTPSuccess then response.body
  when Net::HTTPRedirection then fetch(URI.join(uri, response["location"]), redirects_left - 1)
  else abort "Feed request failed: #{response.code} #{response.message}"
  end
end

# Feed fields arrive as CDATA and may carry HTML (Substack puts the post
# subtitle in <description>, sometimes wrapped in a tag). Strip the markup,
# unescape the entities, and collapse whitespace so each value stays a single
# readable line of YAML.
def plain_text(node)
  return nil if node.nil?

  text = node.texts.map(&:value).join
  CGI.unescape_html(text.gsub(%r{<[^>]+>}, " ")).gsub(/\s+/, " ").strip
end

# pubDate is RFC 822. Store it as a plain date so Liquid's `date` filter can
# format it the same way the news and events lists do.
def published_date(node)
  raw = plain_text(node)
  return nil if raw.nil? || raw.empty?

  Time.rfc2822(raw).strftime("%Y-%m-%d")
rescue ArgumentError
  abort "Could not read the publication date #{raw.inspect}"
end

def posts_from(xml)
  REXML::Document.new(xml).elements.to_a("rss/channel/item").first(POST_COUNT).map do |item|
    {
      # Keys are ordered the way the template reads them.
      "title" => plain_text(item.elements["title"]),
      "url" => plain_text(item.elements["link"]),
      "date" => published_date(item.elements["pubDate"]),
      "summary" => plain_text(item.elements["description"]),
      "author" => plain_text(item.elements["dc:creator"])
    }.reject { |_, value| value.nil? || value.empty? }
  end
end

posts = posts_from(fetch(feed_url))

# Better to keep the last good list on the page than to blank the section out
# because the feed came back empty.
abort "The feed returned no posts; leaving _data/substack.yml as it is." if posts.empty?

header = <<~YAML
  # The most recent posts from the lab's Substack, listed at the bottom of the
  # homepage. Generated — do not edit by hand. To refresh, run:
  #
  #   ruby script/update-substack.rb
  #
  # Last fetched #{Time.now.strftime('%Y-%m-%d')}.
YAML

File.write(OUTPUT, header + posts.to_yaml)

puts "Wrote #{posts.length} post#{"s" unless posts.length == 1} to _data/substack.yml:"
posts.each { |post| puts "  #{post["date"]}  #{post["title"]}" }
