# AI Governance Lab website

Static site for the AI Governance Lab (Stanford), modeled on the
[CS283 course site](https://cs283.stanford.edu).

## Structure

Content is kept separately from markup, so most edits mean changing a data file
rather than touching HTML.

**Edit these to change content:**

- `_data/people.yml` — everyone on the People page (name, role, group, photo, bio)
- `_data/courses.yml` — courses on the Teaching page
- `_data/nav.yml` — the top-nav tabs
- `_data/people_groups.yml` — the sections on the People page and their order
- `index.html`, `people.html`, `teaching.html`, `newsletter.html` — page prose

**Edit these to change how it looks:**

- `_layouts/default.html` — the page shell every page renders through
- `_includes/head.html` — `<head>`, fonts, the pre-paint theme script
- `_includes/nav.html` — nav bar and the light/dark toggle
- `_includes/footer.html` — footer
- `assets/css/style.css` — all styling (Stanford cardinal + cream, light/dark)
- `assets/js/theme.js` — light/dark toggle behavior
- `assets/img/` — member photos

The nav and footer exist in exactly one place each. Adding a tab is a one-line
change in `_data/nav.yml`, not an edit to every page.

## Filling in real content

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

### Adding a course

Copy a block in `_data/courses.yml`.

### Editing page prose

The About paragraph and contact block are in `index.html`; everything above the
`---` line at the top of each page is configuration, everything below is content.

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
