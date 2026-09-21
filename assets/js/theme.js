// Nav light/dark toggle. By default the theme follows the OS (matched pre-paint by
// the inline script in _includes/head.html, and tracked live below). Flipping the
// switch stores an explicit choice that overrides the OS from then on. The knob's
// position is driven by data-theme in CSS; here we sync the checkbox to it and
// react to input. Loaded with `defer`, so the DOM is already parsed.
(function () {
  var box = document.getElementById('theme-switch');
  if (!box) return;

  var root = document.documentElement;

  function stored() {
    try {
      var t = localStorage.getItem('theme');
      return t === 'dark' || t === 'light' ? t : null;
    } catch (e) {
      return null;
    }
  }

  function apply(theme) {
    root.setAttribute('data-theme', theme);
    box.checked = theme === 'dark'; // checked = dark (knob toward the moon)
  }

  apply(root.getAttribute('data-theme') || 'light');

  // Flip: remember the choice as an explicit override.
  box.addEventListener('change', function () {
    var next = box.checked ? 'dark' : 'light';
    try { localStorage.setItem('theme', next); } catch (e) {}
    apply(next);
  });

  // Follow the OS live — but only while the user hasn't made an explicit choice.
  var mq = window.matchMedia('(prefers-color-scheme: dark)');
  mq.addEventListener('change', function (e) {
    if (stored()) return;
    apply(e.matches ? 'dark' : 'light');
  });
})();
