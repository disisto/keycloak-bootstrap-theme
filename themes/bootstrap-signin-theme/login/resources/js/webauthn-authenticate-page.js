/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
// Passkey / security key sign-in step (strict CSP: no inline script). Values come from data-*
// attributes on #kc-webauthn-authenticate (webauthn-authenticate.ftl).
import { authenticateByWebAuthn } from "./webauthnAuthenticate.js";

const el = document.getElementById("kc-webauthn-authenticate");
if (el) {
    const d = el.dataset;
    document.getElementById("authenticateWebAuthnButton").addEventListener("click", () => {
        authenticateByWebAuthn({
            isUserIdentified: d.isUserIdentified === "true",
            challenge: d.challenge,
            userVerification: d.userVerification,
            rpId: d.rpId,
            createTimeout: Number(d.createTimeout),
            errmsg: d.errmsg,
        });
    }, { once: true });
}
const another = document.getElementById("kc-try-another-way");
if (another) {
    another.addEventListener("click", (e) => {
        e.preventDefault();
        document.getElementById("kc-select-try-another-way-form").submit();
    });
}
