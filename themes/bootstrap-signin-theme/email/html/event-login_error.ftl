<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
<#import "template.ftl" as layout>
<@layout.emailLayout>
    <div style="margin-bottom: 16px; padding: 16px; background-color: #f8d7da; border-radius: 6px; border-left: 4px solid #dc3545;">
        <h2 style="margin: 0 0 8px 0; font-size: 18px; font-weight: 600; color: #842029;">${msg("eventLoginErrorSubject", realmName)}</h2>
    </div>

    <p style="margin: 0 0 16px 0; font-size: 15px; line-height: 1.6; color: #495057;">
        ${msg("eventLoginErrorBody", event.date?datetime, event.ipAddress)}
    </p>

    <div style="margin: 16px 0; padding: 16px; background-color: #f8f9fa; border-radius: 6px;">
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td style="padding: 8px 0; font-size: 14px; color: #6c757d; width: 120px;">${msg("eventDate")}</td>
                <td style="padding: 8px 0; font-size: 14px; color: #212529; font-weight: 500;">${event.date?datetime}</td>
            </tr>
            <tr>
                <td style="padding: 8px 0; font-size: 14px; color: #6c757d;">${msg("eventIpAddress")}</td>
                <td style="padding: 8px 0; font-size: 14px; color: #212529; font-weight: 500;">${event.ipAddress}</td>
            </tr>
            <#if event.client??>
            <tr>
                <td style="padding: 8px 0; font-size: 14px; color: #6c757d;">${msg("eventClient")}</td>
                <td style="padding: 8px 0; font-size: 14px; color: #212529; font-weight: 500;">${event.client}</td>
            </tr>
            </#if>
        </table>
    </div>

    <p style="margin: 16px 0 0 0; font-size: 13px; line-height: 1.5; color: #6c757d;">
        ${msg("eventLoginErrorAction")}
    </p>
</@layout.emailLayout>
