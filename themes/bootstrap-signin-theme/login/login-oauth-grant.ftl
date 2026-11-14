<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-oauth-grant.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("oauthGrantTitle", client.name!client.clientId)}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin kc-w-480">
        <div id="kc-form-wrapper">

            <#-- Client Info -->
            <div class="text-center mb-4">
                <p class="lead">${msg("oauthGrantRequest")}</p>
                <h5 class="fw-bold">${client.name!client.clientId}</h5>
            </div>

            <#-- Permissions List -->
            <#if oauth.clientScopesRequested?has_content>
                <div class="card mb-4">
                    <div class="card-header">
                        <strong>${msg("oauthGrantPermissions")}</strong>
                    </div>
                    <ul class="list-group list-group-flush">
                        <#list oauth.clientScopesRequested as clientScope>
                            <li class="list-group-item">
                                <#if clientScope.consentScreenText??>
                                    ${clientScope.consentScreenText}
                                <#else>
                                    ${clientScope.name}
                                </#if>
                            </li>
                        </#list>
                    </ul>
                </div>
            </#if>

            <form action="${url.oauthAction}" method="POST">
                <input type="hidden" name="code" value="${oauth.code}">

                <div class="d-grid gap-2">
                    <button class="btn btn-primary py-2" type="submit" name="accept" id="kc-login" value="${msg("doYes")}">${msg("doYes")}</button>
                    <button class="btn btn-outline-secondary py-2" type="submit" name="cancel" id="kc-cancel" value="${msg("doNo")}">${msg("doNo")}</button>
                </div>
            </form>

        </div>
    </div>

    </#if>
</@layout.registrationLayout>
