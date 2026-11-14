<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
<#import "template.ftl" as layout>
<@layout.emailLayout>
    <h2 style="margin: 0 0 16px 0; font-size: 20px; font-weight: 600; color: #212529;">${msg("emailVerificationSubject")}</h2>

    <p style="margin: 0 0 16px 0; font-size: 15px; line-height: 1.6; color: #495057;">
        ${msg("emailVerificationBody", linkExpiration, realmName)}
    </p>

    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="margin: 24px 0;">
        <tr>
            <td align="center">
                <a href="${link}" target="_blank" style="display: inline-block; padding: 12px 32px; background-color: #0d6efd; color: #ffffff; text-decoration: none; font-size: 15px; font-weight: 500; border-radius: 6px; transition: background-color 0.15s;">
                    ${msg("emailVerificationButton")}
                </a>
            </td>
        </tr>
    </table>

    <p style="margin: 16px 0 0 0; font-size: 13px; line-height: 1.5; color: #6c757d;">
        ${msg("emailVerificationLinkInfo")}
    </p>

    <p style="margin: 8px 0 0 0; font-size: 12px; word-break: break-all; color: #6c757d;">
        <a href="${link}" style="color: #0d6efd; text-decoration: none;">${link}</a>
    </p>
</@layout.emailLayout>
