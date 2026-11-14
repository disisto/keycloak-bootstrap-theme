# Keycloak Bootstrap Theme
# https://github.com/disisto/keycloak-bootstrap-theme
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025-2026 Roberto Di Sisto

# Keycloak Bootstrap Theme: build
#
# Two targets:
#   docker build -t keycloak-bootstrap .
#       a Keycloak image with the finished theme in /opt/keycloak/themes/bootstrap-signin-theme
#   docker build --target theme --output type=local,dest=dist .
#       only the finished theme folder (dist/bootstrap-signin-theme), to copy into an existing
#       Keycloak's themes/ directory
#
# What the build adds to themes/bootstrap-signin-theme:
#   - Keycloak's own WebAuthn/passkey modules (webauthnAuthenticate.js, webauthnRegister.js,
#     passkeysConditionalAuth.js) plus the rfc4648.js they need, taken from the Keycloak version
#     below. Keycloak loads them through an inline import map, which a strict CSP
#     (script-src 'self') blocks; here their bare import "rfc4648" is rewritten to "./rfc4648.js",
#     so they work as plain same-origin modules. Without these files passkeys do not work.
#   - Bootstrap CSS reduced to the rules the theme uses (PurgeCSS, build/purgecss.cjs) and the
#     theme's own CSS/JS minified. Optional: the theme also works with the unprocessed files.
#
# Keycloak upgrade: change KC_VERSION; the build fails if Keycloak's module imports changed.
ARG KC_VERSION=26.8.2

FROM quay.io/keycloak/keycloak:${KC_VERSION} AS kcbase

FROM node:24.18.0-alpine@sha256:a0b9bf06e4e6193cf7a0f58816cc935ff8c2a908f81e6f1a95432d679c54fbfd AS assets
ARG KC_VERSION
RUN npm install -g --no-audit --no-fund terser@5.51.2 csso-cli@4.0.2 purgecss@7.0.2
COPY --from=kcbase /opt/keycloak/lib/lib/main/org.keycloak.keycloak-themes-${KC_VERSION}.jar /tmp/themes.jar
COPY --from=kcbase /opt/keycloak/lib/lib/main/org.keycloak.keycloak-themes-vendor-${KC_VERSION}.jar /tmp/themes-vendor.jar
# Keycloak's passkey modules, import rewritten for a strict CSP (see above)
RUN mkdir -p /k/js && cd /k \
 && unzip -q -j /tmp/themes.jar theme/base/login/resources/js/webauthnAuthenticate.js \
      theme/base/login/resources/js/webauthnRegister.js theme/base/login/resources/js/passkeysConditionalAuth.js -d js \
 && unzip -q -j /tmp/themes-vendor.jar theme/keycloak/common/resources/vendor/rfc4648/rfc4648.js -d js \
 && sed -i 's#^import { base64url } from "rfc4648";$#import { base64url } from "./rfc4648.js";#' js/webauthnAuthenticate.js js/webauthnRegister.js \
 && grep -qx 'import { base64url } from "./rfc4648.js";' js/webauthnAuthenticate.js \
 && grep -qx 'import { base64url } from "./rfc4648.js";' js/webauthnRegister.js \
 && ! grep -n '"rfc4648"' js/*.js
# Keycloak's base login templates: pages this theme does not override are rendered from them
# (parent=base), so PurgeCSS must keep the classes they use
RUN mkdir -p /base && cd /base && unzip -q /tmp/themes.jar 'theme/base/login/*.ftl'
COPY themes/bootstrap-signin-theme /theme
COPY build/purgecss.cjs /tmp/purgecss.cjs
RUN ln -s /theme/login /b && cd /b/resources \
 && NODE_PATH="$(npm root -g)" node /tmp/purgecss.cjs /tmp/bootstrap.purged.css \
 && csso /tmp/bootstrap.purged.css -o css/bootstrap.min.css \
 && csso css/sign-in.css -o css/sign-in.css.tmp && mv css/sign-in.css.tmp css/sign-in.css \
 && for f in js/*.js; do terser "$f" -c -m -o "$f.tmp" && mv "$f.tmp" "$f"; done \
 && cp /k/js/*.js js/

# --target theme: just the finished theme folder
FROM scratch AS theme
COPY --from=assets /theme /bootstrap-signin-theme

# default target: Keycloak with the theme (run "kc.sh build" with your own options as usual)
FROM quay.io/keycloak/keycloak:${KC_VERSION}
COPY --from=assets --chown=keycloak:keycloak /theme /opt/keycloak/themes/bootstrap-signin-theme
