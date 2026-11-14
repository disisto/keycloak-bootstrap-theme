<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-verify-email.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div class="alert alert-info" role="alert">
            <div class="d-flex align-items-start">
                <svg class="me-2 flex-shrink-0 mt-1" width="20" height="20" fill="currentColor">
                    <use href="#envelope-fill"></use>
                </svg>
                <div>
                    <p class="mb-0">${msg("emailVerifyInstruction1",user.email)}</p>
                </div>
            </div>
        </div>

        <p class="text-center text-muted mt-3">
            ${msg("emailVerifyInstruction2")}
            <br/>
            <a href="${url.loginAction}" class="btn btn-link">${msg("doClickHere")}</a>
            ${msg("emailVerifyInstruction3")}
        </p>
    </div>

    <#elseif section = "info">
        <!-- Info section handled in form -->
    </#if>
</@layout.registrationLayout>
