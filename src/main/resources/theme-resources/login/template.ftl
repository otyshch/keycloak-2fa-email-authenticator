<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

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
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />

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

    <!-- Custom Email Code Theme Styles -->
    <style>
        /* Theme-specific enhancements */
        .email-code-theme-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .email-code-container {
            max-width: 480px;
            width: 100%;
        }

        .email-code-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .email-code-logo {
            max-width: 120px;
            height: auto;
            margin-bottom: 20px;
        }

        /* Animation for smooth transitions */
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Enhanced card styling */
        .email-code-card {
            background: var(--email-theme-card-bg, rgba(255, 255, 255, 0.05));
            backdrop-filter: blur(20px);
            border: 1px solid var(--email-theme-border-color, rgba(255, 255, 255, 0.1));
            border-radius: var(--email-theme-border-radius, 12px);
            box-shadow: var(--email-theme-shadow, 0 8px 32px rgba(0, 0, 0, 0.4));
            padding: 40px;
        }

        /* Progress indicator for multi-step authentication */
        .auth-progress {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .auth-step {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.3);
            margin: 0 4px;
            transition: background-color 0.3s ease;
        }

        .auth-step.active {
            background-color: var(--email-theme-primary-color, #c0bebe);
        }

        /* Enhanced accessibility */
        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }

        /* Loading state */
        .loading {
            position: relative;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid var(--email-theme-primary-color, #c0bebe);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>

<body class="${properties.kcBodyClass!} email-code-theme-wrapper ${bodyClass}">
    <div class="email-code-container fade-in">
        <div class="${properties.kcLoginClass!}">
            <div id="kc-header" class="${properties.kcHeaderClass!}">
                <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!} email-code-header">
                    <#if realm.displayName?has_content>
                        <div class="kc-logo-text">
                            <span class="sr-only">${msg("loginTitleHtml",(realm.displayNameHtml!''))}</span>
                            <#if properties.kcLogoIdP?has_content>
                                <img src="${url.resourcesPath}/${properties.kcLogoIdP}" class="email-code-logo" alt="${realm.displayName}" />
                            <#elseif url.resourcesPath?has_content>
                                <img src="${url.resourcesPath}/assets/enerview_icon.svg" class="email-code-logo" alt="${realm.displayName}" />
                            </#if>
                            ${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}
                        </div>
                    <#else>
                        <h1>${msg("loginTitle",(realm.displayName!''))}</h1>
                    </#if>

                    <!-- Authentication progress indicator -->
                    <div class="auth-progress">
                        <div class="auth-step"></div>
                        <div class="auth-step active"></div>
                        <div class="auth-step"></div>
                    </div>
                </div>
            </div>

            <div id="kc-content" class="${properties.kcContentClass!}">
                <div id="kc-content-wrapper" class="${properties.kcContentWrapperClass!}">
                    <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                    <#-- during login.                                                                               -->
                    <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                        <div class="alert alert-${message.type}">
                            <#if message.type = 'success'>
                                <span class="${properties.kcFeedbackSuccessIcon!}"></span>
                            <#elseif message.type = 'warning'>
                                <span class="${properties.kcFeedbackWarningIcon!}"></span>
                            <#elseif message.type = 'error'>
                                <span class="${properties.kcFeedbackErrorIcon!}"></span>
                            <#elseif message.type = 'info'>
                                <span class="${properties.kcFeedbackInfoIcon!}"></span>
                            </#if>
                            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                        </div>
                    </#if>

                    <div id="kc-form" class="${properties.kcFormAreaClass!}">
                        <div id="kc-form-wrapper" class="${properties.kcFormAreaWrapperClass!} email-code-card">
                            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                                <div class="${properties.kcLocaleWrapperClass!}">
                                    <div id="kc-locale">
                                        <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                                            <div id="kc-locale-dropdown" class="menu-button-links">
                                                <button type="button" id="kc-current-locale-link">${locale.current}</button>
                                                <ul>
                                                    <#list locale.supported as l>
                                                        <li class="kc-dropdown-item">
                                                            <a href="${l.url}">${l.label}</a>
                                                        </li>
                                                    </#list>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </#if>

                            <#nested "form">

                            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                                    <div class="${properties.kcFormGroupClass!}">
                                        <input type="hidden" name="tryAnotherWay" value="on"/>
                                        <a href="#" id="try-another-way"
                                           onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">
                                            ${msg("doTryAnotherWay")}
                                        </a>
                                    </div>
                                </form>
                            </#if>

                            <#if displayRequiredFields>
                                <div class="${properties.kcContentWrapperClass!}">
                                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                                        <span class="subtitle">
                                            <span class="required">*</span>
                                            ${msg("requiredFields")}
                                        </span>
                                    </div>
                                </div>
                            </#if>
                        </div>
                    </div>

                    <#if displayInfo>
                        <div id="kc-info" class="${properties.kcSignUpClass!}">
                            <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                <#nested "info">
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Enhanced JavaScript for better UX -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-focus on the email code input if present
            const emailCodeInput = document.getElementById('emailCode');
            if (emailCodeInput) {
                emailCodeInput.focus();

                // Auto-format code input (add spaces every 3 digits)
                emailCodeInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length > 6) value = value.substring(0, 6);
                    e.target.value = value;

                    // Auto-submit when 6 digits are entered
                    if (value.length === 6) {
                        // Add a slight delay to allow user to see the complete code
                        setTimeout(() => {
                            const form = document.getElementById('kc-otp-login-form');
                            if (form) {
                                const submitButton = form.querySelector('input[name="login"]');
                                if (submitButton) {
                                    submitButton.click();
                                }
                            }
                        }, 500);
                    }
                });

                // Handle paste events for codes
                emailCodeInput.addEventListener('paste', function(e) {
                    setTimeout(() => {
                        let value = e.target.value.replace(/\D/g, '');
                        if (value.length > 6) value = value.substring(0, 6);
                        e.target.value = value;

                        if (value.length === 6) {
                            setTimeout(() => {
                                const form = document.getElementById('kc-otp-login-form');
                                if (form) {
                                    const submitButton = form.querySelector('input[name="login"]');
                                    if (submitButton) {
                                        submitButton.click();
                                    }
                                }
                            }, 500);
                        }
                    }, 10);
                });
            }

            // Add loading state to buttons
            const buttons = document.querySelectorAll('input[type="submit"]');
            buttons.forEach(button => {
                button.addEventListener('click', function() {
                    this.classList.add('loading');
                    this.disabled = true;

                    // Re-enable after 5 seconds as fallback
                    setTimeout(() => {
                        this.classList.remove('loading');
                        this.disabled = false;
                    }, 5000);
                });
            });

            // Handle locale dropdown
            const localeButton = document.getElementById('kc-current-locale-link');
            if (localeButton) {
                localeButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    const dropdown = this.nextElementSibling;
                    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function(e) {
                    if (!e.target.closest('#kc-locale-dropdown')) {
                        const dropdowns = document.querySelectorAll('#kc-locale-dropdown ul');
                        dropdowns.forEach(dropdown => {
                            dropdown.style.display = 'none';
                        });
                    }
                });
            }
        });
    </script>
</body>
</html>
</#macro>
