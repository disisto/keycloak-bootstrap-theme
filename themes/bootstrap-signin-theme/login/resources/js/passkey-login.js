/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
// Passkey sign-in on the login page (strict CSP: no inline script). Values come from data-*
// attributes on #kc-passkey (login.ftl); the WebAuthn work is Keycloak's own modules.
import { authenticateByWebAuthn } from "./webauthnAuthenticate.js";
import { initAuthenticate } from "./passkeysConditionalAuth.js";

const el = document.getElementById("kc-passkey");
if (el) {
    const d = el.dataset;
    const args = {
        isUserIdentified: d.isUserIdentified === "true",
        challenge: d.challenge,
        userVerification: d.userVerification,
        rpId: d.rpId,
        createTimeout: Number(d.createTimeout),
        mediation: d.mediation || "conditional",
        authenticatorAttachment: d.authenticatorAttachment,
    };
    initAuthenticate({ errmsg: d.errmsgPasskey, ...args });
    document.getElementById("authenticateWebAuthnButton").addEventListener("click", (event) => {
        event.preventDefault();
        authenticateByWebAuthn({ errmsg: d.errmsgWebauthn, ...args });
    }, { once: true });
}
