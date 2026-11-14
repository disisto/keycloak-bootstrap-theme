<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
<#macro emailLayout>
<!DOCTYPE html>
<html lang="${locale!'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${msg("emailTitle", realmName)}</title>
    <!--[if mso]>
    <noscript>
        <xml>
            <o:OfficeDocumentSettings>
                <o:PixelsPerInch>96</o:PixelsPerInch>
            </o:OfficeDocumentSettings>
        </xml>
    </noscript>
    <![endif]-->
    <style>
        @media (prefers-color-scheme: dark) {
            .email-body { background-color: #212529 !important; }
            .email-container { background-color: #2b3035 !important; }
            .email-header { background-color: #0d6efd !important; }
            .email-content { color: #dee2e6 !important; }
            .email-footer { color: #6c757d !important; }
        }
        @media only screen and (max-width: 600px) {
            .email-container { width: 100% !important; margin: 0 !important; border-radius: 0 !important; }
            .email-content { padding: 24px 16px !important; }
        }
    </style>
</head>
<body class="email-body" style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f8f9fa; -webkit-font-smoothing: antialiased;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color: #f8f9fa;">
        <tr>
            <td align="center" style="padding: 40px 20px;">
                <!-- Email Container -->
                <table role="presentation" class="email-container" width="560" cellspacing="0" cellpadding="0" border="0" style="background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden;">
                    <!-- Header -->
                    <tr>
                        <td class="email-header" style="background-color: #0d6efd; padding: 24px 32px; text-align: center;">
                            <h1 style="margin: 0; color: #ffffff; font-size: 24px; font-weight: 600;">${realmName}</h1>
                        </td>
                    </tr>
                    <!-- Content -->
                    <tr>
                        <td class="email-content" style="padding: 32px; color: #212529;">
                            <#nested>
                        </td>
                    </tr>
                    <!-- Footer -->
                    <tr>
                        <td class="email-footer" style="padding: 24px 32px; text-align: center; border-top: 1px solid #dee2e6; color: #6c757d; font-size: 13px;">
                            <p style="margin: 0;">${msg("emailFooter", realmName)}</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>
