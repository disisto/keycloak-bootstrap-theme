<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-update-password.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div id="kc-form-wrapper">
            <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">

                <!-- New Password with toggle -->
                <div class="form-floating position-relative">
                    <input type="password" id="password-new" name="password-new"
                           class="form-control password-input-with-toggle <#if messagesPerField.existsError('password')>is-invalid</#if>"
                           placeholder="${msg("passwordNew")}"
                           autocomplete="new-password"
                           autofocus />
                    <label for="password-new">${msg("passwordNew")}</label>

                    <!-- Password toggle button -->
                    <button type="button"
                            class="password-toggle-btn"
                            id="passwordNewToggle"
                            title="${msg("showPassword")}"
                            aria-label="${msg("showPassword")}"
                            data-toggle-password="password-new"
                            data-label-show="${msg("showPassword")}"
                            data-label-hide="${msg("hidePassword")}">
                            <span id="passwordNewToggleIcon">
                                <svg class="icon-eye" width="1em" height="1em" fill="currentColor">
                                    <use href="#eye-fill"></use>
                                </svg>
                                <svg class="icon-eye-slash" width="1em" height="1em" fill="currentColor">
                                    <use href="#eye-slash-fill"></use>
                                </svg>
                            </span>
                    </button>

                    <#if messagesPerField.existsError('password')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                        </div>
                    </#if>
                </div>

                <!-- Confirm Password with toggle -->
                <div class="form-floating position-relative mt-3">
                    <input type="password" id="password-confirm" name="password-confirm"
                           class="form-control password-input-with-toggle <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>"
                           placeholder="${msg("passwordConfirm")}"
                           autocomplete="new-password" />
                    <label for="password-confirm">${msg("passwordConfirm")}</label>

                    <!-- Password confirm toggle button -->
                    <button type="button"
                            class="password-toggle-btn"
                            id="passwordConfirmToggle"
                            title="${msg("showPassword")}"
                            aria-label="${msg("showPassword")}"
                            data-toggle-password="password-confirm"
                            data-label-show="${msg("showPassword")}"
                            data-label-hide="${msg("hidePassword")}">
                            <span id="passwordConfirmToggleIcon">
                                <svg class="icon-eye" width="1em" height="1em" fill="currentColor">
                                    <use href="#eye-fill"></use>
                                </svg>
                                <svg class="icon-eye-slash" width="1em" height="1em" fill="currentColor">
                                    <use href="#eye-slash-fill"></use>
                                </svg>
                            </span>
                    </button>

                    <#if messagesPerField.existsError('password-confirm')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
                        </div>
                    </#if>
                </div>

                <!-- Logout other sessions checkbox -->
                <div class="form-check text-start my-3">
                    <input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked class="form-check-input">
                    <label class="form-check-label" for="logout-sessions">${msg("logoutOtherSessions")}</label>
                </div>

                <div class="form-group form-actions">
                    <#if isAppInitiatedAction??>
                        <button class="btn btn-primary w-100 py-2" type="submit" value="${msg("doSubmit")}">${msg("doSubmit")}</button>
                        <button class="btn btn-outline-secondary w-100 py-2 mt-2" type="submit" name="cancel-aia" value="true">${msg("doCancel")}</button>
                    <#else>
                        <button class="btn btn-primary w-100 py-2" type="submit" value="${msg("doSubmit")}">${msg("doSubmit")}</button>
                    </#if>
                </div>
            </form>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
