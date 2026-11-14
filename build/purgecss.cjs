/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
// PurgeCSS for bootstrap-signin-theme (run by the Dockerfile, stage "assets"; paths are inside that stage).
// Keeps every Bootstrap rule whose class/attribute appears in the theme's templates, messages,
// properties or scripts, in Keycloak's base login templates (parent=base renders pages this theme
// does not override) and in Keycloak's WebAuthn modules. Classes that only scripts set at runtime
// and that never appear as a literal token must be in the safelist below (the theme ships its own
// dropdown/alert code in keycloak-theme.js, no bootstrap.bundle.min.js).
// Run: NODE_PATH=$(npm root -g) node purgecss.cjs <out.css>
// (the purgecss CLI silently ignores a .cjs --config, so this calls the API directly)
const { PurgeCSS } = require('purgecss');
const fs = require('fs');
const config = {
  content: [
    '/b/*.ftl', '/b/theme.properties', '/b/messages/*.properties',
    '/b/resources/js/*.js', '/k/js/*.js', '/base/**/*.ftl',
  ],
  css: ['/b/resources/css/bootstrap.min.css'],
  safelist: {
    // set by color-modes logic / Popper at runtime, not always as a literal class token
    standard: ['show', 'fade', 'showing', 'hiding', 'collapsing', 'active', 'disabled'],
    greedy: [/data-bs-theme/, /data-bs-popper/],
  },
  fontFace: true,
  keyframes: true,
  variables: false,
};

(async () => {
  const [res] = await new PurgeCSS().purge(config);
  const before = fs.statSync(config.css[0]).size;
  if (!res || res.css.length < 20000 || !res.css.includes('[data-bs-theme=dark]')) throw new Error('purge result implausible');
  fs.writeFileSync(process.argv[2], res.css);
  console.log(`bootstrap.min.css: ${before} -> ${res.css.length} bytes`);
})().catch(e => { console.error(e); process.exit(1); });
