<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
${msg("eventUpdatePasswordSubject", realmName)}

${msg("eventUpdatePasswordBody", event.date, event.ipAddress)}

${msg("eventDate")}: ${event.date}
${msg("eventIpAddress")}: ${event.ipAddress}
<#if event.client??>${msg("eventClient")}: ${event.client}</#if>

${msg("eventUpdatePasswordNotYou")}

--
${msg("emailFooter", realmName)}
