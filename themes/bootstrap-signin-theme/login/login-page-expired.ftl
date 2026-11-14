<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-page-expired.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("pageExpiredTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div class="alert alert-warning" role="alert">
            <div class="d-flex align-items-start">
                <svg class="me-2 flex-shrink-0 mt-1" width="20" height="20" fill="currentColor">
                    <use href="#exclamation-triangle-fill"></use>
                </svg>
                <div>
                    <p class="mb-0">${msg("pageExpiredMsg1")}</p>
                </div>
            </div>
        </div>

        <div class="text-center mt-3">
            <p>
                <a id="loginRestartLink" href="${url.loginRestartFlowUrl}" class="btn btn-primary">
                    ${msg("doClickHere")}
                </a>
                ${msg("pageExpiredMsg2")}
            </p>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
