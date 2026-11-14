<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/webauthn-register.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<#-- Security key / passkey registration (required actions webauthn-register and
     webauthn-register-passwordless). The WebAuthn call itself is Keycloak's own
     resources/js/webauthnRegister.js from the base theme, so options such as residentKey
     (needed for passkeys) follow the realm policy and stay in step with Keycloak upgrades. -->
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("webauthn-registration-title")}
    <#elseif section = "form">
    <div id="kc-form" class="form-signin kc-w-400">
        <div id="kc-form-wrapper">
            <div class="text-center mb-4">
                <svg width="64" height="64" fill="currentColor" class="text-primary mb-3">
                    <use href="#fingerprint"></use>
                </svg>
                <p class="text-muted">${msg("webauthn-registration-instructions")}</p>
            </div>

            <form id="register" action="${url.loginAction}" method="post">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                <input type="hidden" id="attestationObject" name="attestationObject"/>
                <input type="hidden" id="publicKeyCredentialId" name="publicKeyCredentialId"/>
                <input type="hidden" id="authenticatorLabel" name="authenticatorLabel"/>
                <input type="hidden" id="transports" name="transports"/>
                <input type="hidden" id="authenticatorAttachment" name="authenticatorAttachment"/>
                <input type="hidden" id="error" name="error"/>
            </form>

            <div class="form-floating mb-3">
                <input type="text" id="registerLabel" class="form-control" placeholder="${msg("webauthn-registration-label")}" />
                <label for="registerLabel">${msg("webauthn-registration-label")}</label>
                <div class="form-text">${msg("webauthn-registration-label-help")}</div>
            </div>

            <div class="d-grid gap-2">
                <button id="registerWebAuthn" class="btn btn-primary py-2" type="button">
                    ${msg("webauthn-doRegister")}
                </button>
            </div>
        </div>

        <#if !isSetRetry?has_content && isAppInitiatedAction?has_content>
            <form action="${url.loginAction}" id="kc-webauthn-settings-form" method="post" class="d-grid mt-2">
                <button type="submit" class="btn btn-outline-secondary py-2" id="cancelWebAuthnAIA" name="cancel-aia" value="true">
                    ${msg("doCancel")}
                </button>
            </form>
        </#if>
    </div>

    <div id="kc-webauthn-register" hidden
         data-challenge="${challenge}"
         data-userid="${userid}"
         data-username="${username}"
         data-signature-algorithms="<#list signatureAlgorithms as sigAlg>${sigAlg?c}<#sep>,</#sep></#list>"
         data-rp-entity-name="${rpEntityName}"
         data-rp-id="${rpId}"
         data-attestation-conveyance-preference="${attestationConveyancePreference}"
         data-authenticator-attachment="${authenticatorAttachment}"
         data-require-resident-key="${requireResidentKey}"
         data-resident-key="${residentKey}"
         data-user-verification-requirement="${userVerificationRequirement}"
         data-create-timeout="${createTimeout?c}"
         data-exclude-credential-ids="${excludeCredentialIds}"
         data-init-label="${msg("webauthn-registration-init-label")}"
         data-errmsg="${msg("webauthn-unsupported-browser-text")}"></div>
    <script type="module" src="${url.resourcesPath}/js/webauthn-register-page.js?v=${properties.assetVersion!"1"}"></script>
    </#if>
</@layout.registrationLayout>
