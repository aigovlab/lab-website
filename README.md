# AI Governance Lab website

Static site for the AI Governance Lab (Stanford), modeled on the
[CS283 course site](https://yasikhan.github.io/cs-283-website/).

## Structure

- `index.html` — home / About
- `people.html` — lab members
- `teaching.html` — links to related courses (currently CS283)
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

## Deploying to GitHub Pages (dazzap9.github.io)

1. Create a new GitHub repo, e.g. `ai-governance-lab`, under the `dazzap9` account.
2. From this folder:
   ```bash
   git init
   git add .
   git commit -m "Initial site"
   git branch -M main
   git remote add origin https://github.com/dazzap9/ai-governance-lab.git
   git push -u origin main
   ```
3. In the repo's Settings → Pages, set the source to the `main` branch, root folder.
4. The site will be live at `https://dazzap9.github.io/ai-governance-lab/`.
