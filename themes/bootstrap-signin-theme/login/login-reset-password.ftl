<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-reset-password.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=realm.duplicateEmailsAllowed; section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div id="kc-form-wrapper">
            <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
                <div class="form-floating">
                    <input type="text" id="username" name="username" class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>" autofocus value="${(auth.attemptedUsername!'')}" placeholder="Username" autocomplete="username" />
                    <label for="username" class="form-label">
                        <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                    </label>
                    <#if messagesPerField.existsError('username')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                        </div>
                    </#if>
                </div>

                <div class="form-group form-actions">
                    <button class="btn btn-primary w-100 py-2 mt-3" type="submit">${msg("doSubmit")}</button>
                </div>

                <div class="login-info-links">
                    <a href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>
            </form>
        </div>
    </div>

    <#elseif section = "info" >
        <#if realm.duplicateEmailsAllowed>
            ${msg("emailInstructionUsername")}
        <#else>
            ${msg("emailInstruction")}
        </#if>
    </#if>

</@layout.registrationLayout>
