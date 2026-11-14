<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-otp.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section = "header">
        ${msg("loginOtpTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin">
        <div id="kc-form-wrapper">
            <form id="kc-otp-login-form" action="${url.loginAction}" method="post">

                <#-- Hidden field for actual OTP value -->
                <input type="hidden" id="otp" name="otp" value="" />

                <#-- Account context for password managers (iOS/macOS Passwords): the OTP page is its own
                     page, so without a username field Safari cannot tie the verification code to the
                     entry chosen on the login page. Not submitted (no name attribute). -->
                <#if auth?has_content && (auth.attemptedUsername!'')?has_content>
                    <input type="text" id="otp-username" value="${auth.attemptedUsername}" autocomplete="username" readonly hidden />
                </#if>

                <#-- OTP 6-Digit Input -->
                <div class="otp-input-container d-flex justify-content-center gap-2 mb-3">
                    <input type="text" class="otp-digit form-control text-center <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           data-otp-index="0" maxlength="6" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code" autofocus />
                    <input type="text" class="otp-digit form-control text-center <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           data-otp-index="1" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off" />
                    <input type="text" class="otp-digit form-control text-center <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           data-otp-index="2" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off" />
                    <span class="otp-separator d-flex align-items-center text-muted">-</span>
                    <input type="text" class="otp-digit form-control text-center <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           data-otp-index="3" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off" />
                    <input type="text" class="otp-digit form-control text-center <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           data-otp-index="4" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off" />
                    <input type="text" class="otp-digit form-control text-center <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           data-otp-index="5" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off" />
                </div>

                <#if messagesPerField.existsError('totp')>
                    <div class="text-danger text-center small mb-3">
                        ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                    </div>
                </#if>

                <div class="form-group form-actions mt-3">
                    <button class="btn btn-primary w-100 py-2" type="submit" name="login" id="kc-login">${msg("doLogIn")}</button>
                </div>

                <#-- Alternative Methods -->
                <#if auth.showTryAnotherWayLink()>
                    <div class="login-info-links mt-3">
                        <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                            <input type="hidden" name="tryAnotherWay" value="on"/>
                            <a href="#" id="try-another-way" data-try-another-way="kc-select-try-another-way-form">
                                ${msg("doTryAnotherWay")}
                            </a>
                        </form>
                    </div>
                </#if>
            </form>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
