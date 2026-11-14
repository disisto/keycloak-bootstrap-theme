/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
// Passkey / security key registration page (strict CSP: no inline script). Values come from
// data-* attributes on #kc-webauthn-register (webauthn-register.ftl).
import { registerByWebAuthn } from "./webauthnRegister.js";

const el = document.getElementById("kc-webauthn-register");
if (el) {
    const d = el.dataset;
    document.getElementById("registerWebAuthn").addEventListener("click", () => {
        // webauthnRegister.js asks for the label with window.prompt after the credential is
        // created; answer it from the label field on this page instead of a browser dialog.
        const typed = document.getElementById("registerLabel").value.trim();
        window.prompt = () => typed || d.initLabel;
        registerByWebAuthn({
            challenge: d.challenge,
            userid: d.userid,
            username: d.username,
            signatureAlgorithms: d.signatureAlgorithms ? d.signatureAlgorithms.split(",").map(Number) : [],
            rpEntityName: d.rpEntityName,
            rpId: d.rpId,
            attestationConveyancePreference: d.attestationConveyancePreference,
            authenticatorAttachment: d.authenticatorAttachment,
            requireResidentKey: d.requireResidentKey,
            residentKey: d.residentKey,
            userVerificationRequirement: d.userVerificationRequirement,
            createTimeout: Number(d.createTimeout),
            excludeCredentialIds: d.excludeCredentialIds || "",
            initLabel: d.initLabel,
            initLabelPrompt: "",
            errmsg: d.errmsg,
        });
    }, { once: true });
}
