<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
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
</head>

<body class="${properties.kcBodyClass!} ${bodyClass}">
    <div class="${properties.kcLoginClass!}">
        <div id="kc-header" class="${properties.kcHeaderClass!}">
            <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">
                <div class="kc-logo">
                    <img src="${url.resourcesPath}/enerview_icon.svg" alt="Enerview" />
                </div>
                ${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}
            </div>
        </div>

        <div class="${properties.kcFormCardClass!}">
            <header class="${properties.kcFormHeaderClass!}">
                <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                    <div class="${properties.kcLocaleWrapperClass!}">
                        <div id="kc-locale">
                            <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                                <div id="kc-locale-dropdown" class="${properties.kcLocaleDropDownClass!}">
                                    <button type="button" id="kc-current-locale-link">${locale.current}</button>
                                    <ul id="language-switch1" class="${properties.kcLocaleListClass!}">
                                        <#list locale.supported as l>
                                            <li class="${properties.kcLocaleListItemClass!}">
                                                <a href="${l.url}">${l.label}</a>
                                            </li>
                                        </#list>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </header>

            <div id="kc-content">
                <div id="kc-content-wrapper">
                    <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                        <div class="alert alert-${message.type}">
                            <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                            <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                            <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                            <#--  <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>  -->
                            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                        </div>
                    </#if>

                    <#nested "header">

                    <div id="kc-form">
                        <div id="kc-form-wrapper">
                            <#nested "form">
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Look for OTP input (id="otp" in email-code-form.ftl)
            const otpInput = document.getElementById('otp');
            if (otpInput) {
                otpInput.focus();

                otpInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length > 6) value = value.substring(0, 6);
                    e.target.value = value;

                    if (value.length === 6) {
                        e.target.classList.add('code-complete');
                        setTimeout(() => {
                            // Click the login button instead of form.submit()
                            // This includes the button name/value and respects formnovalidate
                            const loginButton = document.getElementById('kc-login');
                            if (loginButton) {
                                loginButton.click();
                            }
                        }, 500);
                    } else {
                        e.target.classList.remove('code-complete');
                    }
                });

                otpInput.addEventListener('paste', function(e) {
                    setTimeout(() => {
                        let value = e.target.value.replace(/\D/g, '');
                        if (value.length > 6) value = value.substring(0, 6);
                        e.target.value = value;

                        if (value.length === 6) {
                            e.target.classList.add('code-complete');
                            setTimeout(() => {
                                const loginButton = document.getElementById('kc-login');
                                if (loginButton) {
                                    loginButton.click();
                                }
                            }, 500);
                        }
                    }, 10);
                });
            }

            // Fix button submission - use form submit event instead of button click
            const form = document.getElementById('kc-otp-login-form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    // Find which button was clicked
                    const submitButton = document.activeElement;
                    if (submitButton && submitButton.tagName === 'INPUT' && submitButton.type === 'submit') {
                        if (submitButton.name !== 'cancel') {
                            submitButton.classList.add('loading');
                            // Don't disable - let form submit happen
                            setTimeout(() => {
                                submitButton.disabled = true;
                            }, 100);
                        }
                    }
                });
            }

            // Handle locale dropdown
            const localeButton = document.getElementById('kc-current-locale-link');
            if (localeButton) {
                localeButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    const dropdown = this.nextElementSibling;
                    if (dropdown) {
                        dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
                    }
                });

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
