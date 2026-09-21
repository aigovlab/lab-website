# AI Governance Lab website

Static site for the AI Governance Lab (Stanford), modeled on the
[CS283 course site](https://yasikhan.github.io/cs-283-website/).

## Structure

- `index.html` — home / About
- `people.html` — lab members
- `teaching.html` — links to related courses (currently CS283)
- `newsletter.html` — newsletter page
- `assets/css/style.css` — all styling (Stanford cardinal + cream palette, light/dark toggle)
- `assets/js/theme.js` — light/dark mode toggle logic
- `assets/img/` — put member photos here

No build step — plain HTML/CSS/JS, safe to open `index.html` directly or serve as-is.

## Filling in real content

- **About**: edit the placeholder paragraph in `index.html`.
- **People**: edit or duplicate the `.person` blocks in `people.html`. To add a
  photo, drop an image in `assets/img/` and replace the empty
  `<div class="avatar"></div>` with
  `<div class="avatar"><img src="assets/img/yourfile.jpg" alt="Name"></div>`.
- **Teaching**: duplicate the `.course-card` block in `teaching.html` to add more courses.

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

There is no build step — GitHub serves the HTML/CSS/JS exactly as committed,
so what you see opening `index.html` locally is what you get in production.
