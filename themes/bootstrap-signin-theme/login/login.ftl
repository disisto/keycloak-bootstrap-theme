<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <#-- Empty header - title handled by template -->
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
      <div id="kc-form-wrapper">

        <#if realm.password>
            <form id="kc-form-login" action="${url.loginAction}" method="post">
                <#if !usernameHidden??>
                    <div class="form-floating">
                        <#if usernameEditDisabled??>
                            <input id="username" name="username" value="${(login.username!'')}" type="text" disabled placeholder="Username" class="form-control"/>
                        <#else>
                            <input id="username" name="username" value="${(login.username!'')}" type="text" autofocus placeholder="Username" autocomplete="${(enableWebAuthnConditionalUI?has_content)?then('username webauthn', 'username')}"
                                   class="form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" />
                        </#if>
                        <label for="username" id="usernameLabel">
                            <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                        </label>
                    </div>
                </#if>

                <#-- Password field with integrated toggle button -->
                <div class="form-floating position-relative">
                    <input id="password" name="password" type="password" placeholder="Password" autocomplete="current-password"
                           class="form-control password-input-with-toggle <#if messagesPerField.existsError('username','password')>is-invalid</#if>" />
                    <label for="password" id="passwordLabel">${msg("password")}</label>

                    <#-- Password toggle button -->
                    <button type="button"
                            class="password-toggle-btn"
                            id="passwordToggle"
                            title="${msg("showPassword")}"
                            aria-label="${msg("showPassword")}"
                            data-toggle-password="password"
                            data-label-show="${msg("showPassword")}"
                            data-label-hide="${msg("hidePassword")}">
                        <span id="passwordToggleIcon">
                            <svg class="icon-eye" width="1em" height="1em" fill="currentColor">
                                <use href="#eye-fill"></use>
                            </svg>
                            <svg class="icon-eye-slash" width="1em" height="1em" fill="currentColor">
                                <use href="#eye-slash-fill"></use>
                            </svg>
                        </span>
                    </button>

                </div>
                <#-- one message under the stacked fields, as in Keycloak's base login.ftl -->
                <#if messagesPerField.existsError('username','password')>
                    <div class="invalid-feedback" role="alert">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                    </div>
                </#if>

                <#if realm.rememberMe && !usernameEditDisabled??>
                    <div class="form-check text-start my-3">
                        <#if login.rememberMe??>
                            <input id="rememberMe" name="rememberMe" type="checkbox" checked class="form-check-input" value="on">
                        <#else>
                            <input id="rememberMe" name="rememberMe" type="checkbox" class="form-check-input" value="on">
                        </#if>
                        <label class="form-check-label" for="rememberMe">${msg("rememberMe")}</label>
                    </div>
                </#if>

                <div class="form-group form-actions">
                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <button class="btn btn-primary w-100 py-2" type="submit" id="kc-login">${msg("doLogIn")}</button>
                </div>

                <#-- Info Links -->
                <div class="login-info-links">
                    <#if realm.resetPasswordAllowed>
                        <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                    </#if>

                    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <#if realm.resetPasswordAllowed><br></#if>
                        <a href="${url.registrationUrl}">${msg("noAccount")} ${msg("doRegister")}</a>
                    </#if>
                </div>
            </form>
        </#if>
        </div>

      <#-- Passkeys (realm: WebAuthn Passwordless Policy > passkeys enabled). Same element ids as the
           base theme's passkeys.ftl, because Keycloak's own webauthnAuthenticate.js /
           passkeysConditionalAuth.js fill and submit them. With conditional mediation Safari offers
           the passkey in the username field's AutoFill; the button opens the system sheet directly. -->
      <#if enableWebAuthnConditionalUI?has_content>
          <form id="webauth" action="${url.loginAction}" method="post">
              <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
              <input type="hidden" id="authenticatorData" name="authenticatorData"/>
              <input type="hidden" id="signature" name="signature"/>
              <input type="hidden" id="credentialId" name="credentialId"/>
              <input type="hidden" id="userHandle" name="userHandle"/>
              <input type="hidden" id="error" name="error"/>
          </form>
          <#if authenticators??>
              <form id="authn_select">
                  <#list authenticators.authenticators as authenticator>
                      <input type="hidden" name="authn_use_chk" value="${authenticator.credentialId}"/>
                  </#list>
              </form>
          </#if>
          <div class="d-grid" id="kc-passkey"
               data-is-user-identified="${isUserIdentified?is_boolean?then(isUserIdentified?c, isUserIdentified)}"
               data-challenge="${challenge}"
               data-user-verification="${userVerification}"
               data-rp-id="${rpId}"
               data-create-timeout="${createTimeout?c}"
               data-mediation="${mediation!'conditional'}"
               data-authenticator-attachment="${authenticatorAttachment}"
               data-errmsg-passkey="${msg("passkey-unsupported-browser-text")}"
               data-errmsg-webauthn="${msg("webauthn-unsupported-browser-text")}">
              <div class="kc-divider" role="separator"><span>${msg("passkey-or")}</span></div>
              <button type="button" id="authenticateWebAuthnButton" class="btn btn-outline-secondary kc-btn-passkey w-100 py-2">
                  <svg width="1em" height="1em" fill="currentColor" class="me-1" aria-hidden="true">
                      <use href="#fingerprint"></use>
                  </svg>
                  ${msg("passkey-doAuthenticate")}
              </button>
          </div>
          <script type="module" src="${url.resourcesPath}/js/passkey-login.js?v=${properties.assetVersion!"1"}"></script>
      </#if>

      <#-- Social Providers -->
      <#if realm.password && social.providers?? && social.providers?has_content>
          <div id="kc-social-providers">
              <hr/>
              <h4>${msg("socialLogin")}</h4>
              <ul class="list-unstyled">
                  <#list social.providers as p>
                      <li><a id="social-${p.alias}" class="btn btn-outline-secondary w-100 mb-2" type="button" href="${p.loginUrl}">
                              <#if p.iconClasses?has_content><i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i></#if>
                              <span>${p.displayName!}</span>
                          </a>
                      </li>
                  </#list>
              </ul>
          </div>
      </#if>

    </div>

    <#elseif section = "info" >
        <#-- Info section empty - links are in form section -->
    </#if>

</@layout.registrationLayout>
