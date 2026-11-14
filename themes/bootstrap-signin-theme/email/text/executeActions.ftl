<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT
    Copyright (c) 2025-2026 Roberto Di Sisto
-->
${msg("executeActionsSubject")}

${msg("executeActionsBody", linkExpiration, realmName)}

<#if requiredActions?has_content>
${msg("requiredActionsLabel")}
<#list requiredActions as action>
- ${msg("requiredAction.${action}")}
</#list>
</#if>

${msg("executeActionsButton")}:
${link}

${msg("executeActionsLinkInfo")}

--
${msg("emailFooter", realmName)}
