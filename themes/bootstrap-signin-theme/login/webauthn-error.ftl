<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/webauthn-error.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<#-- Shown when passkey / security key registration or sign-in fails (e.g. the system sheet was
     cancelled). Same form fields as the base theme: "try again" re-runs the execution. -->
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "header">
        ${kcSanitize(msg("webauthn-error-title"))?no_esc}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div class="text-center">
            <svg width="64" height="64" fill="currentColor" class="text-primary mb-3" aria-hidden="true">
                <use href="#fingerprint"></use>
            </svg>

            <form id="kc-error-credential-form" action="${url.loginAction}" method="post">
                <input type="hidden" id="executionValue" name="authenticationExecution" value="${execution}"/>
                <input type="hidden" id="isSetRetry" name="isSetRetry" value="retry"/>
                <div class="d-grid gap-2">
                    <button class="btn btn-primary py-2" type="submit" name="try-again" id="kc-try-again">${kcSanitize(msg("doTryAgain"))?no_esc}</button>
                </div>
            </form>

            <#if isAppInitiatedAction??>
                <form action="${url.loginAction}" id="kc-webauthn-settings-form" method="post" class="d-grid mt-2">
                    <button type="submit" class="btn btn-outline-secondary py-2" id="cancelWebAuthnAIA" name="cancel-aia" value="true">${msg("doCancel")}</button>
                </form>
            </#if>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
