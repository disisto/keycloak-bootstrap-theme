<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/info.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=false; section>
    <#if section = "header">
        <#if messageHeader??>
            ${messageHeader}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">

    <div id="kc-info-message" class="form-signin">
        <div class="alert alert-info" role="alert">
            <div class="d-flex align-items-start">
                <svg class="me-2 flex-shrink-0 mt-1" width="20" height="20" fill="currentColor">
                    <use href="#info-circle-fill"></use>
                </svg>
                <div>
                    <p class="mb-0">${kcSanitize(message.summary)?no_esc}</p>
                </div>
            </div>
        </div>

        <#if skipLink??>
        <#else>
            <#if pageRedirectUri?has_content>
                <p class="text-center mt-3">
                    <a href="${pageRedirectUri}" class="btn btn-primary">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                </p>
            <#elseif actionUri?has_content>
                <p class="text-center mt-3">
                    <a href="${actionUri}" class="btn btn-primary">${kcSanitize(msg("proceedWithAction"))?no_esc}</a>
                </p>
            <#elseif (client.baseUrl)?has_content>
                <p class="text-center mt-3">
                    <a href="${client.baseUrl}" class="btn btn-primary">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                </p>
            </#if>
        </#if>
    </div>

    </#if>
</@layout.registrationLayout>
