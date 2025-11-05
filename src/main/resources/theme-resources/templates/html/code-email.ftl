<html>
<body>
${kcSanitize(msg("emailCodeBody", code, ttl))?no_esc}
<br/>
<br/>
<p style="margin: 0; font-size: 14px; color: #333;">
    Best regards,<br>
    <strong>Enerview support team</strong>
</p>
<br/>
<table style="width: 100%; border-collapse: collapse;">
    <tr>
        <td style="width: 80px; vertical-align: top;">
            <img src="https://qa.enerview.site/public/img/grafana_icon.svg" alt="Enerview Logo" style="max-width: 70px; height: auto;"/>
        </td>
        <td style="vertical-align: top; padding-left: 10px;">
            <p style="margin: 0; font-size: 14px; color: #333;">
                1234 Enerview St.<br>
                City, State, ZIP<br>
                Tel: <a href="tel:+11234567890" style="color: #333; text-decoration: none;">(123) 456-7890</a><br>
                Email: <a href="mailto:info@enerview.com" style="color: #333; text-decoration: none;">info@enerview.com</a>
            </p>
        </td>
    </tr>
</table>
</body>
</html>
