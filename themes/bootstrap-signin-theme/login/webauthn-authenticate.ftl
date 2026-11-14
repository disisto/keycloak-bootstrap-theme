<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/webauthn-authenticate.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<#-- Security key / passkey sign-in step. The WebAuthn call is Keycloak's own
     resources/js/webauthnAuthenticate.js from the base theme (same element ids as base). -->
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("webauthn-login-title")}
    <#elseif section = "form">
    <div id="kc-form" class="form-signin">
        <div id="kc-form-wrapper">
            <div class="text-center mb-4">
                <svg width="64" height="64" fill="currentColor" class="text-primary mb-3">
                    <use href="#fingerprint"></use>
                </svg>
                <p class="text-muted">${msg("webauthn-login-instructions")}</p>
            </div>

            <form id="webauth" action="${url.loginAction}" method="post">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                <input type="hidden" id="authenticatorData" name="authenticatorData"/>
                <input type="hidden" id="signature" name="signature"/>
                <input type="hidden" id="credentialId" name="credentialId"/>
                <input type="hidden" id="userHandle" name="userHandle"/>
                <input type="hidden" id="error" name="error"/>
            </form>

            <#if authenticators??>
                <form id="authn_select">
                    <#list authenticators.authenticators as authenticator>
                        <input type="hidden" name="authn_use_chk" value="${authenticator.credentialId}"/>
                    </#list>
                </form>
                <#if shouldDisplayAuthenticators?? && shouldDisplayAuthenticators>
                    <ul class="list-group mb-3 text-start">
                        <#list authenticators.authenticators as authenticator>
                            <li class="list-group-item" id="kc-webauthn-authenticator-item-${authenticator?index}">
                                <div class="fw-semibold">${authenticator.label}</div>
                                <small class="text-muted">${msg('webauthn-createdAt-label')} ${authenticator.createdAt}</small>
                            </li>
                        </#list>
                    </ul>
                </#if>
            </#if>

            <div class="d-grid gap-2">
                <button id="authenticateWebAuthnButton" class="btn btn-primary py-2" type="button" autofocus>
                    ${msg("webauthn-doAuthenticate")}
                </button>
            </div>

            <#if auth.showTryAnotherWayLink()>
                <div class="login-info-links mt-3">
                    <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                        <input type="hidden" name="tryAnotherWay" value="on"/>
                        <a href="#" id="kc-try-another-way">${msg("doTryAnotherWay")}</a>
                    </form>
                </div>
            </#if>
        </div>
    </div>

    <div id="kc-webauthn-authenticate" hidden
         data-is-user-identified="${isUserIdentified?is_boolean?then(isUserIdentified?c, isUserIdentified)}"
         data-challenge="${challenge}"
         data-user-verification="${userVerification}"
         data-rp-id="${rpId}"
         data-create-timeout="${createTimeout?c}"
         data-errmsg="${msg("webauthn-unsupported-browser-text")}"></div>
    <script type="module" src="${url.resourcesPath}/js/webauthn-authenticate-page.js?v=${properties.assetVersion!"1"}"></script>
    </#if>
</@layout.registrationLayout>
