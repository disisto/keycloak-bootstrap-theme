<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/delete-credential.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<#-- Confirmation for removing a credential (passkey, security key, OTP) from the account console
     (required action delete_credential). Same form fields as the base theme. -->
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("deleteCredentialTitle", credentialLabel)}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div id="kc-delete-credential" class="text-center">
            <p class="text-muted mb-4" id="kc-delete-text">${msg("deleteCredentialMessage", credentialLabel)}</p>

            <form action="${url.loginAction}" method="POST">
                <div class="d-grid gap-2">
                    <button class="btn btn-danger py-2" type="submit" name="accept" id="kc-accept" value="${msg("doConfirmDelete")}">${msg("doConfirmDelete")}</button>
                    <button class="btn btn-outline-secondary py-2" type="submit" name="cancel-aia" id="kc-decline" value="${msg("doCancel")}">${msg("doCancel")}</button>
                </div>
            </form>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
