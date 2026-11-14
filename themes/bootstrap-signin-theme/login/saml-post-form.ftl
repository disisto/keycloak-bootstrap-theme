<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/saml-post-form.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<#-- SAML POST binding. Base theme submits with an inline script; here resources/js/auto-actions.js
     submits the form named saml-post-binding on load (strict CSP). -->
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("saml.post-form.title")}
    <#elseif section = "form">
    <div id="kc-form" class="form-signin text-center">
        <p class="text-muted">${msg("saml.post-form.message")}</p>
        <form name="saml-post-binding" method="post" action="${samlPost.url}">
            <#if samlPost.SAMLRequest??>
                <input type="hidden" name="SAMLRequest" value="${samlPost.SAMLRequest}"/>
            </#if>
            <#if samlPost.SAMLResponse??>
                <input type="hidden" name="SAMLResponse" value="${samlPost.SAMLResponse}"/>
            </#if>
            <#if samlPost.relayState??>
                <input type="hidden" name="RelayState" value="${samlPost.relayState}"/>
            </#if>
            <noscript>
                <p>${msg("saml.post-form.js-disabled")}</p>
                <button class="btn btn-primary w-100 py-2" type="submit">${msg("doContinue")}</button>
            </noscript>
        </form>
    </div>
    </#if>
</@layout.registrationLayout>
