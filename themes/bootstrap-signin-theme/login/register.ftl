<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/register.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div id="kc-form-wrapper">
            <form id="kc-register-form" action="${url.registrationAction}" method="post">
                
                <!-- First Name and Last Name -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" id="firstName" name="firstName" 
                                   class="form-control <#if messagesPerField.existsError('firstName')>is-invalid</#if>" 
                                   value="${(register.formData.firstName!'')}" 
                                   placeholder="First name" 
                                   <#if realm.registrationEmailAsUsername>autofocus</#if> />
                            <label for="firstName">${msg("firstName")}</label>
                            <#if messagesPerField.existsError('firstName')>
                                <div class="invalid-feedback">
                                    ${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}
                                </div>
                            </#if>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" id="lastName" name="lastName" 
                                   class="form-control <#if messagesPerField.existsError('lastName')>is-invalid</#if>" 
                                   value="${(register.formData.lastName!'')}" 
                                   placeholder="Last name" />
                            <label for="lastName">${msg("lastName")}</label>
                            <#if messagesPerField.existsError('lastName')>
                                <div class="invalid-feedback">
                                    ${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>

                <!-- Email -->
                <div class="form-floating mt-3">
                    <input type="email" id="email" name="email" 
                           class="form-control <#if messagesPerField.existsError('email')>is-invalid</#if>" 
                           value="${(register.formData.email!'')}" 
                           placeholder="Email" 
                           autocomplete="email" />
                    <label for="email">${msg("email")}</label>
                    <#if messagesPerField.existsError('email')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}
                        </div>
                    </#if>
                </div>

                <!-- Username (if not email as username) -->
                <#if !realm.registrationEmailAsUsername>
                    <div class="form-floating mt-3">
                        <input type="text" id="username" name="username" 
                               class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>" 
                               value="${(register.formData.username!'')}" 
                               placeholder="Username" 
                               autocomplete="username"
                               <#if !realm.registrationEmailAsUsername>autofocus</#if> />
                        <label for="username">${msg("username")}</label>
                        <#if messagesPerField.existsError('username')>
                            <div class="invalid-feedback">
                                ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                            </div>
                        </#if>
                    </div>
                </#if>

                <!-- Password with toggle -->
                <div class="form-floating position-relative mt-3">
                    <input type="password" id="password" name="password" 
                           class="form-control password-input-with-toggle <#if messagesPerField.existsError('password')>is-invalid</#if>" 
                           placeholder="Password" 
                           autocomplete="new-password" />
                    <label for="password">${msg("password")}</label>
                    
                    <!-- Password toggle button -->
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
                    
                    <#if messagesPerField.existsError('password')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                        </div>
                    </#if>
                </div>

                <!-- Password Confirm with toggle -->
                <div class="form-floating position-relative mt-3">
                    <input type="password" id="password-confirm" name="password-confirm" 
                           class="form-control password-input-with-toggle <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>" 
                           placeholder="Password confirm" 
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

                <!-- Terms and Conditions (if enabled) -->
                <#if recaptchaRequired??>
                    <div class="form-group mt-3">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </#if>

                <div class="form-group form-actions">
                    <button class="btn btn-primary w-100 py-2 mt-3" type="submit">${msg("doRegister")}</button>
                </div>

                <div class="login-info-links">
                    <a href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>
            </form>
        </div>
    </div>

    <#elseif section = "info" >
        <div class="text-center mt-3">
            <small class="text-muted">
                ${msg("registerWithTitle")}
            </small>
        </div>
    </#if>

</@layout.registrationLayout>
