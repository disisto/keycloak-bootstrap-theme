<#--
    Keycloak Bootstrap Theme
    https://github.com/disisto/keycloak-bootstrap-theme

    SPDX-License-Identifier: MIT AND Apache-2.0
    Based on Keycloak's base theme (theme/base/login/login-config-totp.ftl),
    Copyright Red Hat, Inc. and/or its affiliates, Apache-2.0.
    Changes Copyright (c) 2025-2026 Roberto Di Sisto, MIT.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">

    <div id="kc-form" class="form-signin form-signin-wide">
        <div id="kc-form-wrapper">

            <#-- Instructions -->
            <ol class="list-group list-group-numbered mb-4">
                <li class="list-group-item">
                    <div class="w-100 text-break">
                        ${msg("loginTotpStep1")}
                        <ul class="mt-2 small">
                            <#list totp.supportedApplications as app>
                                <li>${msg(app)}</li>
                            </#list>
                        </ul>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="w-100">
                        ${msg("loginTotpStep2")}
                        <div class="text-center my-3">
                            <img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="QR Code" class="img-fluid border rounded qr-code-img">
                        </div>
                        <div class="text-center">
                            <small class="text-muted">${msg("loginTotpUnableToScan")}</small>
                            <br>
                            <code class="user-select-all text-break">${totp.totpSecretEncoded}</code>
                        </div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="w-100">
                        ${msg("loginTotpStep3")}
                        <#if mode?? && mode = "manual">
                            <div class="mt-2 small">
                                <p><strong>${msg("loginTotpManualStep2")}</strong></p>
                                <ul>
                                    <li>${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                                    <li>${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                                    <li>${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                                    <#if totp.policy.type = "totp">
                                        <li>${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                                    <#elseif totp.policy.type = "hotp">
                                        <li>${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                                    </#if>
                                </ul>
                            </div>
                        </#if>
                    </div>
                </li>
            </ol>

            <form id="kc-totp-settings-form" action="${url.loginAction}" method="post">
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}"/>
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>

                <#-- Device Name -->
                <div class="form-floating mb-3">
                    <input type="text" id="userLabel" name="userLabel"
                           class="form-control <#if messagesPerField.existsError('userLabel')>is-invalid</#if>"
                           placeholder="${msg("loginTotpDeviceName")}"
                           <#if totp.otpCredentials?size gte 1>required</#if> />
                    <label for="userLabel">${msg("loginTotpDeviceName")}</label>
                    <#if messagesPerField.existsError('userLabel')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('userLabel'))?no_esc}
                        </div>
                    </#if>
                </div>

                <#-- OTP Code -->
                <div class="form-floating mb-3">
                    <input type="text" id="totp" name="totp" autocomplete="one-time-code" inputmode="numeric" pattern="[0-9]*"
                           class="form-control <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                           placeholder="${msg("loginOtpOneTime")}"
                           autofocus required />
                    <label for="totp">${msg("loginOtpOneTime")}</label>
                    <#if messagesPerField.existsError('totp')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                        </div>
                    </#if>
                </div>

                <div class="form-group form-actions">
                    <#if isAppInitiatedAction??>
                        <button class="btn btn-primary w-100 py-2" type="submit">${msg("doSubmit")}</button>
                        <button class="btn btn-outline-secondary w-100 py-2 mt-2" type="submit" name="cancel-aia" value="true">${msg("doCancel")}</button>
                    <#else>
                        <button class="btn btn-primary w-100 py-2" type="submit">${msg("doSubmit")}</button>
                    </#if>
                </div>
            </form>
        </div>
    </div>

    </#if>
</@layout.registrationLayout>
