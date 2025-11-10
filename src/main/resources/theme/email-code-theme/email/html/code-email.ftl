<#import "template.ftl" as layout>
<@layout.emailLayout>
    <div style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; line-height: 1.6; color: #1b1f3a;">
        <p style="font-size: 16px;">Hello ${user.firstName!""},</p>

        <p style="font-size: 16px;">
            You requested to sign in or verify your account.  
            Please use the following access code to complete the process:
        </p>
        <div style="background-color: #f4f7fb; border-radius: 8px; padding: 16px; text-align: center; margin-bottom: 24px;">
            <p style="margin: 0 0 8px; font-size: 12px; letter-spacing: 1px; text-transform: uppercase; color: #3b82f6;">
                Your one-time password:
            </p>
            <p style="margin: 0; font-size: 28px; font-weight: bold; letter-spacing: 6px; color: #111827;">
                ${code}
            </p>
        </div>
        <p style="margin: 0 0 16px;">
            ${msg("emailOtpFooterText")} <br/>
            If you didn’t request this code, you can safely ignore this message.</p>
        <br/>
        <p style="margin: 0;">
            Best regards,<br/>
            <b>Enerview support team.</b>
        </p>
    </div>
</@layout.emailLayout>
