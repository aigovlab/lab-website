# AI Governance Lab website

Static site for the AI Governance Lab (Stanford). The structure follows
[stanforddpl.org](https://stanforddpl.org) — Stanford's Democracy and
Polarization Lab — with a full-bleed hero, a single scrolling homepage, and
publication and news lists driven by data files.

## How the six tabs are arranged

Four tabs are sections of the homepage that the nav scrolls to; two are their
own pages.

| Tab | Where it lives |
| --- | --- |
| Home | `index.html`, the `#home` hero |
| People | `index.html`, the `#people` section |
| Teaching | `teaching.html` |
| Substack | `index.html`, the `#substack` section |
| Lab Research | `research.html` |
| Recent News | `index.html`, the `#news` section |

The nav is generated from `_data/nav.yml`, so the tabs exist in exactly one
place. A tab with `section: true` scrolls to a homepage section whose HTML `id`
must match the tab's `id`; without it, the tab loads a page.

## Structure

Content is kept separately from markup, so most edits mean changing a data file
rather than touching HTML.

**Edit these to change content:**

- `_data/people.yml` — everyone in the People section (name, role, group, photo, bio)
- `_data/people_groups.yml` — the People subsections and their order
- `_data/research.yml` — publications on the Lab Research page
- `_data/news.yml` — items in the Recent News section
- `_data/courses.yml` — courses on the Teaching page
- `_data/nav.yml` — the top-nav tabs
- `index.html`, `research.html`, `teaching.html` — page prose

**Edit these to change how it looks:**

- `_layouts/default.html` — the page shell every page renders through
- `_includes/head.html` — `<head>`, fonts, the pre-paint theme script
- `_includes/nav.html` — nav bar, mobile menu, light/dark toggle
- `_includes/footer.html` — footer
- `assets/css/style.css` — all styling (Stanford cardinal, light/dark)
- `assets/js/theme.js` — light/dark toggle, mobile menu, scroll highlighting
- `assets/img/` — member photos and the hero image

## Filling in real content

### The hero photo

The photo behind the lab name is currently a generated placeholder
(`assets/img/hero-placeholder.svg`). To use a real one, drop a landscape image
at least 1600px wide into `assets/img/` and point `hero_image` in `_config.yml`
at it:

```yaml
hero_image: /assets/img/hero.jpg
```

A dark wash is applied over it automatically so the white lab name stays
readable, but a photo that is already busy or bright in the middle will fight
the text.

### Adding or editing a person

Open `_data/people.yml` and copy an existing block:

```yaml
- name: Jane Doe
  role: Postdoctoral Scholar
  group: members        # faculty | members | alumni
  photo: jane-doe.jpg   # file in assets/img/; omit for a blank circle
  bio: >-
    Plain prose. No HTML needed.
```

Set `photo_position: top` if centering crops the person's head awkwardly.
Moving someone to `group: alumni` moves them to a "Lab Alumni" section, which
stays hidden while it's empty.

### Adding a publication

Copy a block in `_data/research.yml`. Newest first — the file's order is the
page's order.

```yaml
- title: "The paper's title"
  authors: ["Jane Doe", "John Roe"]
  year: 2026
  venue: "Journal Name"      # or "Working paper"; omit if neither
  details: "12(3): 145–170"  # volume/issue/pages, or a status note
  links:
    pdf: "https://example.org/paper.pdf"
    doi: "https://doi.org/..."
```

`links` also accepts `url`, `code`, and `data`. Each one renders as a small
button; leave out the ones that don't apply.

### Adding a news item

Copy a block in `_data/news.yml`. Newest first.

```yaml
- date: 2026-08-14
  outlet: "The New York Times"
  title: "The headline of the story"
  url: "https://example.com/story"
```

### Clearing the example entries

`_data/research.yml` and `_data/news.yml` ship with sample rows marked
`placeholder: true`. Each list shows an "these are examples" note while any of
those rows survive, so deleting them removes the note too.

### Adding a course

Copy a block in `_data/courses.yml`.

### Editing page prose

The About paragraphs and the Substack blurb are in `index.html`; everything
above the `---` line at the top of each page is configuration, everything below
is content.

### Editing without a terminal

All of the above are plain text files. You can edit them directly on GitHub —
open the file, click the pencil icon, make the change, and click "Commit
changes." The site rebuilds and republishes itself within a minute or two.

## Working on it locally

One-time setup:

```bash
bundle install
```

Then, to preview with live reload on every save:

```bash
bundle exec jekyll serve
```

and open http://localhost:4000/lab-website/ (the `/lab-website/` path matters —
see the `baseurl` note in `_config.yml`).

## Design notes

- Type is **Public Sans** (the US Web Design System's typeface) for text and
  **Newsreader** for headings, both from Google Fonts and loaded in
  `_includes/head.html`.
- The accent is Stanford cardinal `#8c1515`, which is also DPL's.
- Sections alternate white and `#f7f5f2` instead of being boxed in cards.
- The hero uses a fixed-attachment parallax only on wide, non-touch screens and
  only when the visitor hasn't asked for reduced motion.
- Light/dark is set before first paint by an inline script in `head.html`, so
  the page never flashes the wrong theme.

## Repository

This site lives at [`aigovlab/lab-website`](https://github.com/aigovlab/lab-website)
under the AI Governance Lab GitHub organization.

It was seeded from `dazzap9/ai-governance-lab`, which is kept as an `upstream`
remote (fetch-only) in case we want to pull in changes from that copy:

```bash
git fetch upstream          # see what changed over there
git merge upstream/main     # only if you actually want those changes
```

Day-to-day, just push to `origin` as normal:

```bash
git add .
git commit -m "Describe your change"
git push
```

## Deployment

The site is deployed with GitHub Pages from the `main` branch, root folder
(Settings → Pages). Every push to `main` republishes it automatically; it
usually goes live within a minute or two.

Live URL: https://aigovlab.github.io/lab-website/

GitHub Pages builds the site with Jekyll natively — there is no GitHub Actions
workflow to maintain. The `Gemfile` pins the `github-pages` gem so a local
preview uses the same Jekyll version (3.10) that GitHub builds with, rather than
drifting from production.
