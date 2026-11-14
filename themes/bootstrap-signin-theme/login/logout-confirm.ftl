<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/logout-confirm.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div id="kc-logout-confirm" class="text-center">
            <p class="text-muted mb-4">${msg("logoutConfirmHeader")}</p>

            <form action="${url.logoutConfirmAction}" method="POST">
                <input type="hidden" name="session_code" value="${logoutConfirm.code}">

                <div class="d-grid gap-2">
                    <button class="btn btn-primary py-2" type="submit" name="confirmLogout" id="kc-logout" value="${msg("doLogout")}">${msg("doLogout")}</button>
                </div>
            </form>

            <#if !logoutConfirm.skipLink>
                <#if (client.baseUrl)?has_content>
                    <p class="mt-3">
                        <a href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                    </p>
                </#if>
            </#if>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
