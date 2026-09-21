source "https://rubygems.org"

# Matches the build environment GitHub Pages uses, so local previews
# behave the same as the deployed site.
gem "github-pages", group: :jekyll_plugins

# Required for `jekyll serve` on Ruby 3.0+ (webrick was removed from stdlib).
gem "webrick"

# Libraries that used to ship with Ruby but were removed from default gems in
# recent Ruby versions. The GitHub Pages-pinned Jekyll (3.x) still expects them,
# so they must be declared explicitly for local builds on modern Ruby.
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"
