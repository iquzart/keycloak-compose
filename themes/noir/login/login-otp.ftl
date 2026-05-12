<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>

  <#if section = "header">
    <h1 class="kc-page-title">${msg("loginTotpTitle")!"Two-Factor Auth"}</h1>
    <p class="kc-page-subtitle">Enter the code from your authenticator app.</p>
  </#if>

  <#if section = "form">
    <form id="kc-otp-login-form" action="${url.loginAction}" method="post">

      <div class="form-group kc-form-group">
        <label for="otp" class="kc-label">${msg("loginTotpOneTime")!"Verification Code"}</label>
        <input
          id="otp"
          name="otp"
          type="text"
          inputmode="numeric"
          pattern="[0-9]*"
          autocomplete="one-time-code"
          autofocus
          placeholder="000 000"
          style="font-family: 'SF Mono','Fira Code',monospace; letter-spacing: 0.3em; text-align: center; font-size: 1.25rem;"
          class="${messagesPerField.existsError('totp')?then('error','')}"
        />
        <#if messagesPerField.existsError('totp')>
          <span style="color:var(--error);font-size:0.8rem;">
            ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
          </span>
        </#if>
      </div>

      <div id="kc-form-buttons" class="kc-form-buttons">
        <input id="kc-login" type="submit" value="${msg("doLogIn")}" />
      </div>

    </form>

    <#if otpLogin.userOtpCredentials?size gt 1>
      <div class="separator"><span>${msg("loginTotpSelectApp")!"Select device"}</span></div>
      <form id="kc-otp-credential-form" action="${url.loginAction}" method="post">
        <#list otpLogin.userOtpCredentials as otpCredential>
          <div class="kc-checkbox" style="margin-bottom: 8px;">
            <input
              id="kc-otp-credential-${otpCredential?index}"
              type="radio"
              name="selectedCredentialId"
              value="${otpCredential.id}"
              <#if otpCredential.id = otpLogin.selectedCredentialId>checked</#if>
              onchange="this.form.submit()"
            />
            <label for="kc-otp-credential-${otpCredential?index}">
              ${otpCredential.userLabel}
            </label>
          </div>
        </#list>
      </form>
    </#if>
  </#if>

</@layout.registrationLayout>
