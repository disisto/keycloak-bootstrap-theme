/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
// Strict CSP replacements for the base theme's inline scripts:
// - saml-post-form.ftl: submit the SAML POST binding form on load.
// - frontchannel-logout.ftl: after the client logout iframes have loaded, go to the redirect URI.
(function () {
    var saml = document.forms["saml-post-binding"];
    if (saml) {
        window.addEventListener("load", function () { saml.submit(); });
    }
    var fc = document.getElementById("kc-frontchannel-logout");
    if (fc && fc.getAttribute("data-redirect")) {
        var go = function () { window.location.replace(fc.getAttribute("data-redirect")); };
        if (document.readyState === "complete") { go(); } else { window.addEventListener("load", go); }
    }
})();

// Keycloak appends an inline <script> after every form POST that calls history.replaceState() so a
// reload does not re-POST a used session_code. Strict CSP blocks it (dynamic URL, not hashable).
// Same effect here: after a POST (URL still carries session_code) take the current step's own form
// action (it has the CURRENT execution, the POST URL still has the previous one), drop
// session_code and replace the URL. Keycloak renders that step again on GET.
(function () {
    try {
        var here = new URL(window.location.href);
        if (here.pathname.indexOf("/login-actions/") === -1 || !here.searchParams.has("session_code")) return;
        var form = document.querySelector('form[action*="/login-actions/"]');
        var u = new URL(form ? form.getAttribute("action") : window.location.href, window.location.href);
        if (u.origin !== here.origin) return;
        u.searchParams.delete("session_code");
        window.history.replaceState({}, "", u.toString());
    } catch (e) { /* old browser: keep the URL */ }
})();
