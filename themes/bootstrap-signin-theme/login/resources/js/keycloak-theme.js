/*!
 * Keycloak Bootstrap Theme
 * https://github.com/disisto/keycloak-bootstrap-theme
 *
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025-2026 Roberto Di Sisto
 */
/**
 * Keycloak Bootstrap Theme - Event Handlers
 * CSP-compliant: No inline scripts or event handlers
 */

(function() {
    'use strict';


    // ===== THEME SWITCHER =====

    // localStorage throws in some private modes / with blocked site data
    function stored() { try { return localStorage.getItem('theme'); } catch (e) { return null; } }
    function store(v) { try { localStorage.setItem('theme', v); } catch (e) { /* not persisted */ } }

    function setTheme(theme) {
        var html = document.documentElement;
        var themeIcon = document.querySelector('#themeIcon use');

        // Reset all theme buttons and checkmarks
        var themeButtons = ['lightThemeBtn', 'darkThemeBtn', 'autoThemeBtn'];

        themeButtons.forEach(function(btnId) {
            var btn = document.getElementById(btnId);
            if (btn) {
                btn.classList.remove('active');
                btn.setAttribute('aria-pressed', 'false');
                // Hide checkmark
                var checkIcon = btn.querySelector('.check-icon');
                if (checkIcon) {
                    checkIcon.classList.add('d-none');
                    checkIcon.classList.remove('d-block');
                }
            }
        });

        var activeBtn;

        if (theme === 'dark') {
            html.setAttribute('data-bs-theme', 'dark');
            if (themeIcon) themeIcon.setAttribute('href', '#moon-stars-fill')  /* inline sprite, sprite.ftl */;
            store('dark');
            activeBtn = document.getElementById('darkThemeBtn');
        } else if (theme === 'light') {
            html.setAttribute('data-bs-theme', 'light');
            if (themeIcon) themeIcon.setAttribute('href', '#sun-fill')  /* inline sprite, sprite.ftl */;
            store('light');
            activeBtn = document.getElementById('lightThemeBtn');
        } else {
            // Auto mode
            var systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            html.setAttribute('data-bs-theme', systemDark ? 'dark' : 'light');
            if (themeIcon) themeIcon.setAttribute('href', '#circle-half')  /* inline sprite, sprite.ftl */;
            store('auto');
            activeBtn = document.getElementById('autoThemeBtn');
        }

        if (activeBtn) {
            activeBtn.classList.add('active');
            activeBtn.setAttribute('aria-pressed', 'true');
            // Show checkmark
            var checkIcon = activeBtn.querySelector('.check-icon');
            if (checkIcon) {
                checkIcon.classList.remove('d-none');
                checkIcon.classList.add('d-block');
            }
        }

        // Remove focus from theme button
        setTimeout(function() {
            var activeElement = document.activeElement;
            if (activeElement && activeElement.closest('#themeDropdown')) {
                activeElement.blur();
            }
        }, 150);
    }

    // Make setTheme globally available (for compatibility)
    window.setTheme = setTheme;

    // ===== PASSWORD VISIBILITY TOGGLE =====

    function togglePasswordVisibility(btn) {
        var inputId = btn.getAttribute('data-toggle-password');
        var input = document.getElementById(inputId);
        if (!input) return;

        var showLabel = btn.getAttribute('data-label-show') || 'Show password';
        var hideLabel = btn.getAttribute('data-label-hide') || 'Hide password';
        var iconEye = btn.querySelector('.icon-eye');
        var iconEyeSlash = btn.querySelector('.icon-eye-slash');

        if (input.type === 'password') {
            input.type = 'text';
            btn.title = hideLabel;
            btn.setAttribute('aria-label', hideLabel);
            if (iconEye) iconEye.style.display = 'block';
            if (iconEyeSlash) iconEyeSlash.style.display = 'none';
        } else {
            input.type = 'password';
            btn.title = showLabel;
            btn.setAttribute('aria-label', showLabel);
            if (iconEye) iconEye.style.display = 'none';
            if (iconEyeSlash) iconEyeSlash.style.display = 'block';
        }
    }

    // Make togglePasswordVisibility globally available (for compatibility)
    window.togglePasswordVisibility = function(inputId, iconId) {
        var btn = document.querySelector('[data-toggle-password="' + inputId + '"]');
        if (btn) togglePasswordVisibility(btn);
    };

    // ===== OTP 6-DIGIT INPUT HANDLING =====

    // Global flag: Auto-submit only enabled after page fully loaded
    var otpAutoSubmitEnabled = false;

    function initOtpInputs() {
        var otpDigits = document.querySelectorAll('.otp-digit');
        var otpHidden = document.getElementById('otp');

        if (otpDigits.length === 0 || !otpHidden) return;

        // Flags to prevent multiple submissions and handle iOS timing
        var isSubmitting = false;
        var submitTimer = null;

        // Combine all digit values into hidden field
        function updateOtpValue() {
            var value = '';
            otpDigits.forEach(function(input) {
                value += input.value;
            });
            otpHidden.value = value;
        }

        // Debounced auto-submit function to handle iOS Safari timing issues
        function scheduleAutoSubmit() {
            // Don't auto-submit until page is fully loaded (prevents iOS timing issues)
            if (!otpAutoSubmitEnabled) return;

            // Clear any pending submit
            if (submitTimer) {
                clearTimeout(submitTimer);
                submitTimer = null;
            }

            // Only submit if we have exactly 6 digits and not already submitting
            if (otpHidden.value.length === 6 && !isSubmitting) {
                submitTimer = setTimeout(function() {
                    // Double-check conditions before submitting
                    if (otpHidden.value.length === 6 && !isSubmitting && otpAutoSubmitEnabled) {
                        var form = document.getElementById('kc-otp-login-form');
                        if (form) {
                            isSubmitting = true;
                            // Disable all inputs to prevent further changes
                            otpDigits.forEach(function(input) {
                                input.disabled = true;
                            });
                            form.submit();
                        }
                    }
                }, 300); // 300ms delay for iOS Safari compatibility
            }
        }

        otpDigits.forEach(function(input, index) {
            // Only allow numbers
            input.addEventListener('input', function(e) {
                // Prevent input if already submitting
                if (isSubmitting) return;

                var value = this.value.replace(/[^0-9]/g, '');

                // iOS autofill with autocomplete="one-time-code" puts full code in first field
                if (value.length > 1) {
                    // Distribute digits across all fields
                    var digits = value.slice(0, 6);
                    for (var i = 0; i < digits.length && i < otpDigits.length; i++) {
                        otpDigits[i].value = digits[i];
                    }
                    updateOtpValue();
                    // Focus last filled field
                    var focusIndex = Math.min(digits.length - 1, otpDigits.length - 1);
                    otpDigits[focusIndex].focus();
                    return;
                }

                this.value = value.slice(0, 1);
                updateOtpValue();

                // Auto-advance to next field
                if (value.length === 1 && index < otpDigits.length - 1) {
                    otpDigits[index + 1].focus();
                }

                // Auto-submit disabled - user must click login button manually
                // scheduleAutoSubmit();
            });

            // Handle backspace
            input.addEventListener('keydown', function(e) {
                if (isSubmitting) return;

                if (e.key === 'Backspace') {
                    if (this.value === '' && index > 0) {
                        otpDigits[index - 1].focus();
                        otpDigits[index - 1].value = '';
                        updateOtpValue();
                        e.preventDefault();
                    }
                }
                // Handle left arrow
                if (e.key === 'ArrowLeft' && index > 0) {
                    otpDigits[index - 1].focus();
                    e.preventDefault();
                }
                // Handle right arrow
                if (e.key === 'ArrowRight' && index < otpDigits.length - 1) {
                    otpDigits[index + 1].focus();
                    e.preventDefault();
                }
            });

            // Handle paste
            input.addEventListener('paste', function(e) {
                if (isSubmitting) return;

                e.preventDefault();
                var pastedData = (e.clipboardData || window.clipboardData).getData('text');
                var digits = pastedData.replace(/[^0-9]/g, '').slice(0, 6);

                for (var i = 0; i < digits.length && i < otpDigits.length; i++) {
                    otpDigits[i].value = digits[i];
                }
                updateOtpValue();

                // Focus last filled field or next empty
                var focusIndex = Math.min(digits.length, otpDigits.length - 1);
                otpDigits[focusIndex].focus();

                // Auto-submit disabled - user must click login button manually
                // scheduleAutoSubmit();
            });

            // Select content on focus
            input.addEventListener('focus', function() {
                if (!isSubmitting) {
                    this.select();
                }
            });

            // Handle change event (fires after autofill on iOS)
            input.addEventListener('change', function() {
                if (isSubmitting) return;
                var value = this.value.replace(/[^0-9]/g, '');
                // Autofill may deliver the full code via change only: spread it like the input handler
                if (value.length > 1) {
                    var digits = value.slice(0, 6);
                    for (var i = 0; i < digits.length && i < otpDigits.length; i++) {
                        otpDigits[i].value = digits[i];
                    }
                    updateOtpValue();
                    return;
                }
                this.value = value.slice(0, 1);
                updateOtpValue();
            });
        });

        // IMPORTANT: Update hidden field before form submit
        // This ensures iOS autofill values are captured even if input events didn't fire
        var otpForm = document.getElementById('kc-otp-login-form');
        if (otpForm) {
            otpForm.addEventListener('submit', function(e) {
                // Collect all digit values right before submit
                updateOtpValue();

                // Validate that we have 6 digits
                if (otpHidden.value.length !== 6) {
                    // Don't prevent submit - let Keycloak handle the error message
                    return true;
                }

                isSubmitting = true;
                return true;
            });
        }
    }

    // Enable OTP auto-submit (called after page fully loaded)
    function enableOtpAutoSubmit() {
        otpAutoSubmitEnabled = true;
    }

    // Make globally available
    window.initOtpInputs = initOtpInputs;

    // ===== DOM READY =====

    function onDOMReady() {
        // Theme button click handlers
        document.querySelectorAll('[data-bs-theme-value]').forEach(function(btn) {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                setTheme(this.getAttribute('data-bs-theme-value'));
            });
        });

        // Password toggle button click handlers
        document.querySelectorAll('[data-toggle-password]').forEach(function(btn) {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                togglePasswordVisibility(this);
            });
        });

        // Login form submission handler
        var loginForm = document.getElementById('kc-form-login');
        if (loginForm) {
            loginForm.addEventListener('submit', function() {
                var loginBtn = document.getElementById('kc-login');
                if (loginBtn) {
                    loginBtn.disabled = true;
                }
                return true;
            });
        }

        // Try another way links
        document.querySelectorAll('[data-try-another-way]').forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                var formId = this.getAttribute('data-try-another-way');
                var form = document.getElementById(formId);
                if (form) form.submit();
            });
        });

        // WebAuthn buttons
        var webAuthnAuthBtn = document.getElementById('authenticateWebAuthnButton');
        if (webAuthnAuthBtn) {
            webAuthnAuthBtn.addEventListener('click', function() {
                if (typeof webAuthnAuthenticate === 'function') {
                    webAuthnAuthenticate();
                }
            });
        }

        var webAuthnRegBtn = document.getElementById('registerWebAuthnButton');
        if (webAuthnRegBtn) {
            webAuthnRegBtn.addEventListener('click', function() {
                if (typeof registerSecurityKey === 'function') {
                    registerSecurityKey();
                }
            });
        }

        var webAuthnCancelBtn = document.getElementById('cancelWebAuthnButton');
        if (webAuthnCancelBtn) {
            webAuthnCancelBtn.addEventListener('click', function() {
                if (typeof cancelRegister === 'function') {
                    cancelRegister();
                }
            });
        }

        // Initialize OTP 6-digit inputs
        initOtpInputs();
    }

    // ===== WINDOW LOAD =====

    function onWindowLoad() {
        // Set saved theme
        var savedTheme = stored() || 'auto';
        setTheme(savedTheme);

        // Enable OTP auto-submit only after page is fully loaded
        // This prevents timing issues on iOS Safari where autofill may trigger before page is ready
        setTimeout(function() {
            enableOtpAutoSubmit();
        }, 100);
    }

    // ===== INITIALIZATION =====

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', onDOMReady);
    } else {
        onDOMReady();
    }

    window.addEventListener('load', onWindowLoad);

    // System theme change listener
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function() {
        if ((stored() || 'auto') === 'auto') {
            setTheme('auto');
        }
    });

    // ===== DROPDOWNS + ALERT DISMISS (replaces bootstrap.bundle.min.js) =====
    // Only the two menus top right (language, colour mode) and the close button of messages need JS.
    // Positioning: the menus carry data-bs-popper="static", so Bootstrap's CSS places them below the
    // button (dropdown-menu-end: right-aligned) without Popper.

    function menuOf(toggle) { return toggle.parentElement.querySelector('.dropdown-menu'); }
    function menuItems(menu) {
        return Array.prototype.slice.call(menu.querySelectorAll('.dropdown-item:not(.disabled):not(:disabled)'));
    }
    function closeMenu(toggle, refocus) {
        var menu = menuOf(toggle);
        if (!menu || !menu.classList.contains('show')) return;
        menu.classList.remove('show');
        toggle.classList.remove('show');
        toggle.setAttribute('aria-expanded', 'false');
        if (refocus) toggle.focus();
    }
    function closeAllMenus(except) {
        document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(function(t) {
            if (t !== except) closeMenu(t, false);
        });
    }
    function openMenu(toggle, focusItem) {
        var menu = menuOf(toggle);
        if (!menu) return;
        closeAllMenus(toggle);
        menu.classList.add('show');
        toggle.classList.add('show');
        toggle.setAttribute('aria-expanded', 'true');
        if (focusItem) {
            var items = menuItems(menu);
            var active = menu.querySelector('.dropdown-item.active');
            (active || items[0] || toggle).focus();
        }
    }

    document.addEventListener('click', function(e) {
        var dismiss = e.target.closest('[data-bs-dismiss="alert"]');
        if (dismiss) {
            var alert = dismiss.closest('.alert');
            if (alert) alert.remove();
            return;
        }
        var toggle = e.target.closest('[data-bs-toggle="dropdown"]');
        if (toggle) {
            e.preventDefault();
            if (menuOf(toggle).classList.contains('show')) closeMenu(toggle, false); else openMenu(toggle, false);
            return;
        }
        // click on a menu entry or anywhere else closes open menus
        closeAllMenus(null);
    });

    document.addEventListener('keydown', function(e) {
        var toggle = e.target.closest('[data-bs-toggle="dropdown"]');
        var menu = e.target.closest('.dropdown-menu');
        if (!toggle && menu) toggle = menu.parentElement.querySelector('[data-bs-toggle="dropdown"]');
        if (!toggle) return;
        if (e.key === 'Escape') {
            closeMenu(toggle, true);
        } else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
            e.preventDefault();
            if (!menu) { openMenu(toggle, true); return; }
            var items = menuItems(menu), i = items.indexOf(document.activeElement);
            if (!items.length) return;
            i = e.key === 'ArrowDown' ? Math.min(i + 1, items.length - 1) : Math.max(i - 1, 0);
            items[i].focus();
        } else if (e.key === 'Tab' && menu) {
            closeMenu(toggle, false);
        }
    });

})();
