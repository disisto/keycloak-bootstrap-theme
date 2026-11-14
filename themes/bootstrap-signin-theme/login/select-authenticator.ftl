<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/select-authenticator.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("loginChooseAuthenticator")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin kc-w-400">
        <div id="kc-form-wrapper">

            <form id="kc-select-credential-form" action="${url.loginAction}" method="post">
                <div class="list-group">
                    <#list auth.authenticationSelections as authenticationSelection>
                        <button type="submit" class="list-group-item list-group-item-action d-flex align-items-center py-3"
                                name="authenticationExecution" value="${authenticationSelection.authExecId}">
                            <#-- Icon based on credential type -->
                            <span class="me-3">
                                <#if authenticationSelection.iconCssClass?has_content>
                                    <i class="${authenticationSelection.iconCssClass} fs-4"></i>
                                <#else>
                                    <svg width="24" height="24" fill="currentColor">
                                        <#if authenticationSelection.displayName?contains("assword")>
                                            <use href="#key-fill"></use>
                                        <#elseif authenticationSelection.displayName?contains("OTP") || authenticationSelection.displayName?contains("Authenticator")>
                                            <use href="#phone-fill"></use>
                                        <#else>
                                            <use href="#shield-fill"></use>
                                        </#if>
                                    </svg>
                                </#if>
                            </span>
                            <div>
                                <strong>${msg('${authenticationSelection.displayName}')}</strong>
                                <#if authenticationSelection.helpText?has_content>
                                    <br><small class="text-muted">${msg('${authenticationSelection.helpText}')}</small>
                                </#if>
                            </div>
                        </button>
                    </#list>
                </div>
            </form>

        </div>
    </div>

    </#if>
</@layout.registrationLayout>
