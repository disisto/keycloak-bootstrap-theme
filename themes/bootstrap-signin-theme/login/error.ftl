<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/error.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("errorTitle")}
    <#elseif section = "form">

    <div id="kc-error-message" class="form-signin">
        <div class="alert alert-danger" role="alert">
            <div class="d-flex align-items-start">
                <svg class="me-2 flex-shrink-0 mt-1" width="20" height="20" fill="currentColor">
                    <use href="#exclamation-triangle-fill"></use>
                </svg>
                <div>
                    <p class="mb-2">${kcSanitize(message.summary)?no_esc}</p>
                    <#if skipLink??>
                    <#else>
                        <#if client?? && client.baseUrl?has_content>
                            <p class="mb-0">
                                <a href="${client.baseUrl}" class="alert-link">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                            </p>
                        </#if>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
