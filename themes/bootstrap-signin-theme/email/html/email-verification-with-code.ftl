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
        ${msg("emailVerificationBodyCode", realmName)}
    </p>

    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="margin: 24px 0;">
        <tr>
            <td align="center">
                <div style="display: inline-block; padding: 16px 40px; background-color: #f8f9fa; border: 2px dashed #dee2e6; border-radius: 8px;">
                    <span style="font-size: 32px; font-weight: 700; font-family: 'Courier New', monospace; letter-spacing: 8px; color: #212529;">${code}</span>
                </div>
            </td>
        </tr>
    </table>

    <p style="margin: 16px 0 0 0; font-size: 13px; line-height: 1.5; color: #6c757d;">
        ${msg("emailVerificationCodeExpiry", linkExpiration)}
    </p>
</@layout.emailLayout>
