<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/frontchannel-logout.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<#-- Front-channel logout: loads each client's logout URL in a hidden iframe, then continues.
     Base theme redirects with an inline script and hides iframes with a style attribute; here
     resources/js/auto-actions.js reads data-redirect (strict CSP). The client logout origins
     must be allowed in the realm CSP's frame-src. -->
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("frontchannel-logout.title")}
    <#elseif section = "form">
    <div id="kc-frontchannel-logout" class="form-signin text-center"<#if logout.logoutRedirectUri?has_content> data-redirect="${logout.logoutRedirectUri}"</#if>>
        <p class="text-muted">${msg("frontchannel-logout.message")}</p>
        <ul class="list-unstyled">
        <#list logout.clients as client>
            <li>
                ${client.name}
                <iframe src="${client.frontChannelLogoutUrl}" class="d-none" title="${client.name}"></iframe>
            </li>
        </#list>
        </ul>
        <#if logout.logoutRedirectUri?has_content>
            <a id="continue" class="btn btn-primary w-100 py-2" href="${logout.logoutRedirectUri}">${msg("doContinue")}</a>
        </#if>
    </div>
    </#if>
</@layout.registrationLayout>
