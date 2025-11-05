<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('emailCode'); section>
    <#if section="header">
        ${msg("emailOtpForm")}
    <#elseif section="form">
        <div class="alert alert-info">
            <span class="kc-feedback-text">${msg("emailOtpInstruction")}</span>
        </div>

        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="emailCode" class="${properties.kcLabelClass!}">${msg("emailOtpForm")}</label>
                </div>

                <div class="${properties.kcInputWrapperClass!}">
                    <input id="emailCode"
                           name="emailCode"
                           autocomplete="off"
                           type="text"
                           class="${properties.kcInputClass!}"
                           placeholder="${msg("emailOtpPlaceholder")}"
                           maxlength="6"
                           pattern="[0-9]{6}"
                           inputmode="numeric"
                           autofocus
                           aria-invalid="<#if messagesPerField.existsError('emailCode')>true</#if>"
                           aria-describedby="<#if messagesPerField.existsError('emailCode')>input-error-otp-code</#if>"/>

                    <#if messagesPerField.existsError('emailCode')>
                        <span id="input-error-otp-code"
                              class="${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                            ${kcSanitize(messagesPerField.get('emailCode'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span class="kc-email-code-help">${msg("emailOtpHelp")}</span>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <div class="${properties.kcFormButtonsWrapperClass!}">
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                               name="login"
                               type="submit"
                               value="${msg("doLogIn")}" />
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}"
                               name="resend"
                               type="submit"
                               value="${msg("resendCode")}"/>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}"
                               name="cancel"
                               type="submit"
                               value="${msg("doCancel")}"/>
                    </div>
                </div>
            </div>
        </form>

        <div id="kc-info" class="${properties.kcSignUpClass!}">
            <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                <p>${msg("emailOtpFooterText")}</p>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
