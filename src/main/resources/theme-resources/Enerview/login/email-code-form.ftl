<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('emailCode'); section>
    <#if section="header">
        <style>
        .kc-otp-email {
                color: #ffffff !important;
                text-align: center !important;
            }
        </style>

        <h1 class="kc-form-title">${msg("emailOtpForm")}</h1>
        <#if userEmail??>
            <br/>
            <h3 class="kc-otp-email">${userEmail}</h3>
        </#if>

    <#elseif section="form">
        <style>
            /* Enerview Theme Styling for 2FA Email Code Page */
            body {
                background: url(${url.resourcesPath}/dist/assets/enerview_login_dark-Dn9mNpdt.svg) no-repeat center center fixed !important;
                background-size: cover !important;
                font-family: "Roboto", sans-serif !important;
                color: #c0bebe !important;
                margin: 0 !important;
                padding: 0 !important;
                min-height: 100vh !important;
            }

            /* Center the entire login container */
            .login-pf body {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            }

            #kc-header {
                position: absolute !important;
                top: 0 !important;
                left: 0 !important;
                right: 0 !important;
                padding: 20px !important;
                z-index: 10 !important;
            }

            .login-pf .container {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                min-height: 100vh !important;
                width: 100% !important;
                padding: 80px 20px 20px 20px !important;
            }

            #kc-info-wrapper {
                background-color: transparent !important;
            }

            .card-pf {
                background: transparent;
                backdrop-filter: blur(20px) !important;
                border: none;
                border-radius: transparent;
                padding: 40px !important;
                max-width: 450px !important;
                width: 100% !important;
                margin: 0 auto !important;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3) !important;
            }

            #kc-content-wrapper {
                color: #c0bebe !important;
            }

            /* Enerview logo at top */
            .kc-logo {
                text-align: center !important;
            }

            .kc-logo img {
                width: 50px !important;
                height: auto !important;
            }

            /* Center title */
            .kc-form-title {
                text-align: center !important;
                font-size: 16px !important;
                font-weight: 600 !important;
                color: #ffffff !important;
                margin-bottom: 8px !important;
            }

            .kc-otp-instructions,
            .kc-otp-help,
            .kc-otp-footer,
            label {
                color: #c0bebe !important;
            }

            .kc-otp-instructions {
                text-align: center !important;
            }

            .kc-otp-email {
                color: #ffffff !important;
                text-align: center !important;
            }

            label {
                display: block !important;
                text-align: center !important;
                margin-bottom: 8px !important;
            }

            /* Input field styling */
            #otp {
                background: rgba(255, 255, 255, 0.1) !important;
                border: 1px solid rgba(192, 190, 190, 0.3) !important;
                color: #ffffff !important;
                text-align: center !important;
                letter-spacing: 8px !important;
                font-family: 'Courier New', monospace !important;
                padding: 12px !important;
                border-radius: 8px !important;
                width: 100% !important;
                box-sizing: border-box !important;
            }

            #otp::placeholder {
                color: rgba(192, 190, 190, 0.5) !important;
                letter-spacing: normal !important;
            }

            #otp:focus {
                outline: none !important;
                border-color: #4a9eff !important;
                box-shadow: 0 0 0 3px rgba(74, 158, 255, 0.2) !important;
                background: rgba(255, 255, 255, 0.15) !important;
            }

            #otp.code-complete {
                border-color: #4ade80 !important;
                box-shadow: 0 0 0 3px rgba(74, 222, 128, 0.2) !important;
            }

            /* UX/UI Button Styling */
            input[type="submit"] {
                border: none !important;
                color: #ffffff !important;
                padding: 12px 32px !important;
                border-radius: 6px !important;
                font-weight: 500 !important;
                font-size: 14px !important;
                transition: all 0.2s ease !important;
                cursor: pointer !important;
                margin: 4px !important;
            }

            /* Primary button - Sign In */
            input[name="login"] {
                background-color: var(--pf-c-button--m-primary--BackgroundColor, #06c) !important;
            }

            input[name="login"]:hover {
                background-color: var(--pf-c-button--m-primary--hover--BackgroundColor, #004080) !important;
                box-shadow: 0 4px 12px rgba(0, 102, 204, 0.4) !important;
            }

            input[name="login"]:active {
                transform: translateY(1px) !important;
            }

            /* Secondary button - Resend Code */
            input[name="resend"] {
                background: rgba(192, 190, 190, 0.2) !important;
                border: 1px solid rgba(192, 190, 190, 0.4) !important;
            }

            input[name="resend"]:hover {
                background: rgba(192, 190, 190, 0.3) !important;
                border-color: rgba(192, 190, 190, 0.6) !important;
            }

            input[name="resend"]:active {
                transform: translateY(1px) !important;
            }

            /* Tertiary button - Cancel */
            input[name="cancel"] {
                background: transparent !important;
                border: 1px solid rgba(239, 68, 68, 0.5) !important;
                color: #f87171 !important;
            }

            input[name="cancel"]:hover {
                background: rgba(239, 68, 68, 0.1) !important;
                border-color: rgba(239, 68, 68, 0.7) !important;
            }

            input[name="cancel"]:active {
                transform: translateY(1px) !important;
            }

            input[type="submit"].loading {
                opacity: 0.6 !important;
                cursor: wait !important;
                pointer-events: none !important;
            }

            /* Alert styling */
            .alert-error {
                background: rgba(239, 68, 68, 0.15) !important;
                border: 1px solid rgba(239, 68, 68, 0.4) !important;
                color: #fca5a5 !important;
                border-radius: 8px !important;
                padding: 12px 16px !important;
            }

            .alert-success {
                background: rgba(74, 222, 128, 0.15) !important;
                border: 1px solid rgba(74, 222, 128, 0.4) !important;
                color: #86efac !important;
                border-radius: 8px !important;
                padding: 12px 16px !important;
            }

            #kc-header-wrapper {
                color: #c0bebe !important;
                font-weight: bold;
            }
            @media (max-width: 767px) {

                #kc-header-wrapper {
                    text-align: center !important;
                    color: #c0bebe !important;
                    font-weight: bold;
                    font-size: 18px !important;
                    padding: 40px 0px 0 0;
                }
            }

            /* Button container */
            #kc-form-buttons {
                display: flex !important;
                flex-direction: column !important;
                gap: 8px !important;
                margin-top: 24px !important;
            }

            #kc-form-buttons input {
                width: 100% !important;
            }

            /* Responsive mobile styles */
            @media (max-width: 768px) {
                .card-pf {
                    padding: 30px 20px !important;
                    max-width: 100% !important;
                    border-radius: 12px !important;
                }

                .login-pf .container {
                    padding: 60px 15px 15px 15px !important;
                }

                #kc-header {
                    padding: 15px !important;
                }

                .kc-form-title {
                    font-size: 18px !important;
                }

                #otp {
                    font-size: 20px !important;
                    letter-spacing: 6px !important;
                }

                input[type="submit"] {
                    padding: 14px 24px !important;
                    font-size: 16px !important;
                }
            }

            @media (max-width: 480px) {
                .card-pf {
                    padding: 24px 16px !important;
                }

                .kc-form-title {
                    font-size: 16px !important;
                }

                #otp {
                    font-size: 18px !important;
                    letter-spacing: 4px !important;
                }
            }
        </style>

        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <p class="kc-otp-instructions ${properties.kcLabelClass!}">
                        ${msg("emailOtpInstruction")}
                        <br/>
                    </p>
                </div>

                <div class="${properties.kcInputWrapperClass!}">
                    <input
                        id="otp"
                        name="otp"
                        autocomplete="one-time-code"
                        autocapitalize="off"
                        spellcheck="false"
                        inputmode="numeric"
                        maxlength="6"
                        type="text"
                        class="${properties.kcInputClass!}"
                        autofocus
                        aria-invalid="<#if messagesPerField.existsError('emailCode')>true</#if>"
                        aria-describedby="<#if messagesPerField.existsError('emailCode')>input-error-otp-code</#if>"
                        placeholder="${msg('emailOtpPlaceholder')}"
                    />

                    <#if messagesPerField.existsError('emailCode')>
                        <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('emailCode'))?no_esc}
                        </span>
                    </#if>

                    <input type="hidden" name="emailCode" id="emailCodeHidden" value=""/>

                    <div class="kc-otp-meta">
                        <#if codeTtlSeconds?? && (codeTtlSeconds?number > 0)>
                            <#assign remainingMinutes = ((codeTtlSeconds?number + 59) / 60)?floor>
                            <p class="kc-otp-ttl ${properties.kcLabelClass!}">
                                ${msg("emailOtpExpiresIn", remainingMinutes)}
                            </p>
                        </#if>
                    </div>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <p class="kc-otp-help">
                            ${msg("emailOtpHelp")}
                        </p>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <div class="${properties.kcFormButtonsWrapperClass!}">
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="resend" type="submit" value="${msg("resendCode")}"/>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="cancel" type="submit" value="${msg("doCancel")}" formnovalidate/>
                    </div>
                </div>
            </div>
        </form>
        <div id="kc-info" class="${properties.kcSignUpClass!}">
            <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                <p class="kc-otp-footer ${properties.kcLabelClass!}">${msg("emailOtpFooterText")}</p>
            </div>
        </div>
        <script nonce="${cspNonce!}">
            (function () {
                const input = document.getElementById("otp");
                const hidden = document.getElementById("emailCodeHidden");
                if (!input || !hidden) {
                    return;
                }
                const sync = () => {
                    hidden.value = input.value ?? "";
                };
                input.addEventListener("input", sync);
                input.addEventListener("change", sync);
                sync();
            })();
        </script>
    </#if>
</@layout.registrationLayout>
