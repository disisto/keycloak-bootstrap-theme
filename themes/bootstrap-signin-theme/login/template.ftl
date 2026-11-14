<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/template.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}" data-resource-path="${url.resourcesPath}" <#if realm.internationalizationEnabled!false>lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    
    <!-- Custom Favicon Support from theme.properties -->
    <#if properties.customFaviconUrl??>
        <link rel="icon" href="${properties.customFaviconUrl}">
    <#elseif properties.customFaviconPath??>
        <link rel="icon" href="${url.resourcesPath}/${properties.customFaviconPath}?v=${properties.assetVersion!"1"}">
    <#else>
        <!-- Default favicon fallback -->
        <link rel="icon" type="image/svg+xml" href="${url.resourcesPath}/img/favicon.svg?v=${properties.assetVersion!"1"}" />
    </#if>
    
    <!-- Colour mode before the first paint (no light flash in dark mode) -->
    <script src="${url.resourcesPath}/js/theme-init.js?v=${properties.assetVersion!"1"}"></script>
    <!-- Bootstrap CSS FIRST -->
    <link href="${url.resourcesPath}/css/bootstrap.min.css?v=${properties.assetVersion!"1"}" rel="stylesheet" />
    <link href="${url.resourcesPath}/css/sign-in.css?v=${properties.assetVersion!"1"}" rel="stylesheet" />
    
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>

    <#-- No import map (strict CSP): the WebAuthn/passkey modules are shipped in resources/js with a
         relative import of rfc4648.js, extracted from Keycloak at image build (see Dockerfile). -->
</head>

<body class="d-flex align-items-center py-4 bg-body-tertiary ${bodyClass}" data-bs-theme="auto">
<#include "sprite.ftl">

    <!-- Top Navigation Container - Language Switcher and Color Mode side by side -->
    <div class="position-fixed top-0 end-0 mt-3 me-3 d-flex gap-2 align-items-center">
        
        <!-- Language Switcher - only if Internationalization is enabled -->
        <#if realm.internationalizationEnabled!false && locale.supported?has_content>
            <div class="dropdown">
                <button class="btn btn-outline-secondary dropdown-toggle d-flex align-items-center top-nav-btn" type="button" id="languageDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <svg class="me-2" width="1em" height="1em" fill="currentColor">
                        <use href="#translate"></use>
                    </svg>
                    <span><#if locale??>${locale.currentLanguageDisplayName!locale.current?cap_first}<#else>${msg("languages")}</#if></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow" data-bs-popper="static">
                    <#list locale.supported as supportedLocale>
                        <li>
                            <a class="dropdown-item d-flex align-items-center text-decoration-none text-reset <#if locale.currentLanguageTag?? && supportedLocale.languageTag == locale.currentLanguageTag>active</#if>"
                               href="${supportedLocale.url}">
                                <span class="flex-grow-1">${supportedLocale.label!supportedLocale.languageTag?cap_first}</span>
                                <svg class="ms-2 <#if locale.currentLanguageTag?? && supportedLocale.languageTag == locale.currentLanguageTag>d-block<#else>d-none</#if> check-icon" width="1em" height="1em" fill="currentColor">
                                    <use href="#check2"></use>
                                </svg>
                            </a>
                        </li>
                    </#list>
                </ul>
            </div>
        </#if>

        <!-- Color Mode Switcher -->
        <div class="dropdown">
            <button class="btn btn-outline-secondary dropdown-toggle d-flex align-items-center top-nav-btn" type="button" id="themeDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <svg id="themeIcon" width="1em" height="1em" fill="currentColor">
                    <use href="#circle-half"></use>
                </svg>
                <span class="visually-hidden">${msg("theme.toggle")}</span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end shadow" data-bs-popper="static">
                <li>
                    <button type="button" class="dropdown-item d-flex align-items-center"
                            data-bs-theme-value="light" aria-pressed="false" id="lightThemeBtn">
                        <svg class="me-2 opacity-50 theme-icon" width="1em" height="1em" fill="currentColor">
                            <use href="#sun-fill"></use>
                        </svg>
                        <span class="flex-grow-1">${msg("theme.light")}</span>
                        <svg class="ms-2 d-none check-icon" width="1em" height="1em" fill="currentColor">
                            <use href="#check2"></use>
                        </svg>
                    </button>
                </li>
                <li>
                    <button type="button" class="dropdown-item d-flex align-items-center"
                            data-bs-theme-value="dark" aria-pressed="false" id="darkThemeBtn">
                        <svg class="me-2 opacity-50 theme-icon" width="1em" height="1em" fill="currentColor">
                            <use href="#moon-stars-fill"></use>
                        </svg>
                        <span class="flex-grow-1">${msg("theme.dark")}</span>
                        <svg class="ms-2 d-none check-icon" width="1em" height="1em" fill="currentColor">
                            <use href="#check2"></use>
                        </svg>
                    </button>
                </li>
                <li>
                    <button type="button" class="dropdown-item d-flex align-items-center active"
                            data-bs-theme-value="auto" aria-pressed="true" id="autoThemeBtn">
                        <svg class="me-2 opacity-50 theme-icon" width="1em" height="1em" fill="currentColor">
                            <use href="#circle-half"></use>
                        </svg>
                        <span class="flex-grow-1">${msg("theme.auto")}</span>
                        <svg class="ms-2 d-block check-icon" width="1em" height="1em" fill="currentColor">
                            <use href="#check2"></use>
                        </svg>
                    </button>
                </li>
            </ul>
        </div>
    </div>

    <main class="form-signin w-100 m-auto">
        <#-- Custom Logo Display from theme.properties -->
        <#if properties.customLogoIcon?? || properties.customLogoUrl?? || properties.customLogoPath??>
            <div class="text-center mb-4">
                <#if properties.customLogoIcon??>
                    <#-- Bootstrap Icon from the inline sprite (sprite.ftl); fill = currentColor, so it follows light/dark -->
                    <span class="kc-logo-badge mb-3">
                        <svg class="kc-logo-icon" width="40" height="40" fill="currentColor" viewBox="0 0 16 16" role="img" aria-label="${properties.customLogoAlt!"Logo"}">
                            <use href="#${properties.customLogoIcon}"></use>
                        </svg>
                    </span>
                <#elseif properties.customLogoUrl??>
                    <img src="${properties.customLogoUrl}" 
                         alt="${properties.customLogoAlt!"Logo"}" 
                         class="mb-3 kc-logo">
                <#elseif properties.customLogoPath??>
                    <img src="${url.resourcesPath}/${properties.customLogoPath}" 
                         alt="${properties.customLogoAlt!"Logo"}" 
                         class="mb-3 kc-logo">
                </#if>
            </div>
        </#if>
        
        <h1 class="h3 mb-3 fw-normal text-center">
            <#nested "header">
        </h1>

        <#-- Error Messages Display -->
        <#if displayMessage && message?has_content && message.type != 'warning'>
            <div class="alert alert-<#if message.type = 'error'>danger<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#elseif message.type = 'info'>info<#else>primary</#if> alert-dismissible fade show kc-alert" role="alert">
                <div class="d-flex align-items-start">
                    <#-- Error Icons -->
                    <#if message.type = 'error'>
                        <svg class="me-2 flex-shrink-0 kc-alert-icon" width="16" height="16" fill="currentColor" aria-hidden="true">
                            <use href="#exclamation-triangle-fill"></use>
                        </svg>
                    <#elseif message.type = 'warning'>
                        <svg class="me-2 flex-shrink-0 kc-alert-icon" width="16" height="16" fill="currentColor" aria-hidden="true">
                            <use href="#exclamation-triangle-fill"></use>
                        </svg>
                    <#elseif message.type = 'success'>
                        <svg class="me-2 flex-shrink-0 kc-alert-icon" width="16" height="16" fill="currentColor" aria-hidden="true">
                            <use href="#check-circle-fill"></use>
                        </svg>
                    <#elseif message.type = 'info'>
                        <svg class="me-2 flex-shrink-0 kc-alert-icon" width="16" height="16" fill="currentColor" aria-hidden="true">
                            <use href="#info-circle-fill"></use>
                        </svg>
                    </#if>
                    <div class="flex-grow-1">
                        <#if message.summary?has_content>
                            ${kcSanitize(message.summary)?no_esc}
                        </#if>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="${msg("alert.close")}"></button>
            </div>
        </#if>

        <#-- Main Form Content -->
        <#nested "form">

        <#-- Additional Info Section -->
        <#if displayInfo>
            <div class="text-center mt-3">
                <#nested "info">
            </div>
        </#if>
        
        <#-- Custom Copyright Footer with Flexible Configuration from theme.properties -->
        <#-- Generate copyright year based on properties settings -->
        <#assign copyrightyear = "">
        <#if properties.copyrightYearMode??>
            <#if properties.copyrightYearMode == "current">
                <#assign copyrightyear = .now?string("yyyy")>
            <#elseif properties.copyrightYearMode == "range" && properties.copyrightStartYear??>
                <#assign copyrightyear = properties.copyrightStartYear + "-" + .now?string("yyyy")>
            <#elseif properties.copyrightYearMode == "hardcoded" && properties.copyrightYear??>
                <#assign copyrightyear = properties.copyrightYear>
            <#elseif properties.copyrightYearMode == "none">
                <#assign copyrightyear = "">
            </#if>
        <#else>
            <#-- Default fallback to original template behavior -->
            <#assign copyrightyear = .now?string("yyyy")>
        </#if>
        
        <#-- Generate copyright signature based on properties settings -->
        <#assign copyrightsignature = "">
        <#if properties.copyrightSignatureMode??>
            <#if properties.copyrightSignatureMode == "realm">
                <#assign copyrightsignature = realm.displayName!"">
            <#elseif properties.copyrightSignatureMode == "custom" && properties.copyrightSignature??>
                <#assign copyrightsignature = properties.copyrightSignature>
            <#elseif properties.copyrightSignatureMode == "none">
                <#assign copyrightsignature = "">
            </#if>
        </#if>
        
        <#-- Display copyright if year or signature exists -->
        <#if copyrightyear?? || copyrightsignature??>
            <p class="mt-5 mb-3 text-body-secondary text-center">
                <#if copyrightyear?? && copyrightyear != "">&copy; ${copyrightyear}</#if><#if copyrightsignature?? && copyrightsignature != ""><#if copyrightyear?? && copyrightyear != ""> </#if>${copyrightsignature}</#if>
            </p>
        </#if>
    </main>

    <!-- Bootstrap JS -->
    <!-- Theme JS (CSP-compliant) -->
    <script src="${url.resourcesPath}/js/keycloak-theme.js?v=${properties.assetVersion!"1"}"></script>
    <!-- Auto-submit / redirect pages without inline script (SAML POST, front-channel logout) -->
    <script src="${url.resourcesPath}/js/auto-actions.js?v=${properties.assetVersion!"1"}"></script>

    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</body>
</html>
</#macro>
