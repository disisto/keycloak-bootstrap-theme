<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
<#import "template.ftl" as layout>
<@layout.emailLayout>
    <h2 style="margin: 0 0 16px 0; font-size: 20px; font-weight: 600; color: #212529;">${msg("executeActionsSubject")}</h2>

    <p style="margin: 0 0 16px 0; font-size: 15px; line-height: 1.6; color: #495057;">
        ${msg("executeActionsBody", linkExpiration, realmName)}
    </p>

    <#if requiredActions?has_content>
        <div style="margin: 16px 0; padding: 16px; background-color: #e7f1ff; border-radius: 6px;">
            <p style="margin: 0 0 8px 0; font-size: 14px; font-weight: 600; color: #084298;">${msg("requiredActionsLabel")}</p>
            <ul style="margin: 0; padding-left: 20px; color: #084298;">
                <#list requiredActions as action>
                    <li style="margin: 4px 0; font-size: 14px;">${msg("requiredAction.${action}")}</li>
                </#list>
            </ul>
        </div>
    </#if>

    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="margin: 24px 0;">
        <tr>
            <td align="center">
                <a href="${link}" target="_blank" style="display: inline-block; padding: 12px 32px; background-color: #0d6efd; color: #ffffff; text-decoration: none; font-size: 15px; font-weight: 500; border-radius: 6px;">
                    ${msg("executeActionsButton")}
                </a>
            </td>
        </tr>
    </table>

    <p style="margin: 16px 0 0 0; font-size: 13px; line-height: 1.5; color: #6c757d;">
        ${msg("executeActionsLinkInfo")}
    </p>

    <p style="margin: 8px 0 0 0; font-size: 12px; word-break: break-all; color: #6c757d;">
        <a href="${link}" style="color: #0d6efd; text-decoration: none;">${link}</a>
    </p>
</@layout.emailLayout>
