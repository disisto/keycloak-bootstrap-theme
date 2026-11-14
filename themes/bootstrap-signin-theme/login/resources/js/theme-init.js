/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
// Runs blocking in <head>, before the first paint: sets <html data-bs-theme> from the stored choice
// (localStorage "theme": light | dark | auto, written by keycloak-theme.js) or the system setting,
// so dark-mode users never see a flash of the light page (FOUC). External file: strict CSP.
(function () {
  var t = null;
  try { t = localStorage.getItem('theme'); } catch (e) { /* storage blocked */ }
  if (t !== 'light' && t !== 'dark') {
    t = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }
  document.documentElement.setAttribute('data-bs-theme', t);
})();
