<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
<#import "template.ftl" as layout>
<@layout.emailLayout>
    <div style="margin-bottom: 16px; padding: 16px; background-color: #d1e7dd; border-radius: 6px; border-left: 4px solid #198754;">
        <h2 style="margin: 0 0 8px 0; font-size: 18px; font-weight: 600; color: #0f5132;">${msg("eventUpdatePasswordSubject", realmName)}</h2>
    </div>

    <p style="margin: 0 0 16px 0; font-size: 15px; line-height: 1.6; color: #495057;">
        ${msg("eventUpdatePasswordBody", event.date?datetime, event.ipAddress)}
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
        </table>
    </div>

    <div style="margin-top: 24px; padding: 16px; background-color: #fff3cd; border-radius: 6px; border-left: 4px solid #ffc107;">
        <p style="margin: 0; font-size: 13px; color: #856404;">
            ${msg("eventUpdatePasswordNotYou")}
        </p>
    </div>
</@layout.emailLayout>
