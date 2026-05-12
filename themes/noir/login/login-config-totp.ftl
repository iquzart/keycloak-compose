<#import "template.ftl" as layout>

<@layout.registrationLayout; section>

  <#if section = "header">
    <h1 class="kc-page-title">${msg("loginTotpTitle")!"Set Up Authenticator"}</h1>
    <p class="kc-page-subtitle">${msg("loginTotpStep1")!"Scan the QR code with your authenticator app."}</p>
  </#if>

  <#if section = "form">

    <div class="kc-totp">

      <!-- QR Code -->
      <div class="kc-totp-qr">
        <img src="data:image/png;base64,${totp.totpSecretQrCode}" alt="${msg("loginTotpScanBarcode")}" style="max-width:180px;" />
      </div>

      <!-- Manual entry key -->
      <div>
        <label class="kc-label" style="margin-bottom: 6px; display: block;">
          ${msg("loginTotpManualEntry")!"Can't scan? Enter this key manually:"}
        </label>
        <div class="kc-totp-secret-key">${totp.totpSecretEncoded}</div>
      </div>

      <!-- App type & digits info -->
      <div class="kc-totp-step">
        <#if totp.policy.type = "totp">
          ${msg("loginTotpType")!}: ${msg("loginTotpTypeTOTP")!"Time-based"}
        <#else>
          ${msg("loginTotpType")!}: ${msg("loginTotpTypeHOTP")!"Counter-based"}
        </#if>
        &nbsp;·&nbsp; ${msg("loginTotpAlgorithm")!}: ${totp.policy.getAlgorithmKey()}
        &nbsp;·&nbsp; ${msg("loginTotpDigits")!}: ${totp.policy.digits}
        <#if totp.policy.type = "totp">
          &nbsp;·&nbsp; ${msg("loginTotpInterval")!}: ${totp.policy.period}s
        <#else>
          &nbsp;·&nbsp; ${msg("loginTotpCounter")!}: ${totp.policy.initialCounter}
        </#if>
      </div>

      <!-- Form -->
      <form id="kc-totp-settings-form" action="${url.loginAction}" method="post">
        <#if totp.otpCredentials?size gte 1>
          <div class="form-group kc-form-group">
            <label for="userLabel" class="kc-label">${msg("loginTotpDeviceName")!"Device name"}</label>
            <input
              type="text"
              id="userLabel"
              name="userLabel"
              placeholder="${msg("loginTotpDeviceNamePlaceholder")!"e.g. My Phone"}"
              autocomplete="off"
            />
          </div>
        </#if>

        <div class="form-group kc-form-group">
          <label for="totp" class="kc-label">${msg("authenticatorCode")!"Code"}</label>
          <input
            type="text"
            id="totp"
            name="totp"
            inputmode="numeric"
            autocomplete="one-time-code"
            autofocus
            placeholder="000 000"
            style="font-family: 'SF Mono','Fira Code',monospace; letter-spacing: 0.3em; text-align: center; font-size: 1.25rem;"
          />
        </div>

        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
        <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}" /></#if>

        <div id="kc-form-buttons" class="kc-form-buttons">
          <input id="saveTOTPBtn" type="submit" value="${msg("doSubmit")}" />
          <#if isAppInitiatedAction??>
            <button id="cancelTOTPBtn" type="submit" name="cancel-aia" value="true" class="btn-default">
              ${msg("doCancel")}
            </button>
          </#if>
        </div>
      </form>

    </div>
  </#if>

</@layout.registrationLayout>
