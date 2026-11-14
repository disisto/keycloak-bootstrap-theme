<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/terms.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("termsTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin kc-w-600">
        <div id="kc-form-wrapper">

            <#-- Terms Text -->
            <div class="card mb-4">
                <div class="card-body kc-scroll-300">
                    ${kcSanitize(msg("termsText"))?no_esc}
                </div>
            </div>

            <form action="${url.loginAction}" method="POST">
                <div class="d-grid gap-2">
                    <button class="btn btn-primary py-2" type="submit" name="accept" id="kc-accept" value="${msg("doAccept")}">${msg("doAccept")}</button>
                    <button class="btn btn-outline-secondary py-2" type="submit" name="cancel" id="kc-decline" value="${msg("doDecline")}">${msg("doDecline")}</button>
                </div>
            </form>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
