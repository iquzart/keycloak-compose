<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>

  <#if section = "header">
    <h1 class="kc-page-title">${msg("updatePasswordTitle")!"Update Password"}</h1>
    <p class="kc-page-subtitle">${msg("updatePasswordSubtitle")!"Choose a new secure password for your account."}</p>
  </#if>

  <#if section = "form">
    <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
      <div class="form-group kc-form-group">
        <label for="password-new" class="kc-label">${msg("passwordNew")!"New Password"}</label>
        <input
          type="password"
          id="password-new"
          name="password-new"
          autofocus
          autocomplete="new-password"
          placeholder="••••••••"
          class="${messagesPerField.existsError('password','password-confirm')?then('error','')}"
        />
        <#if messagesPerField.existsError('password')>
          <span style="color:var(--error);font-size:0.8rem;">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</span>
        </#if>
      </div>

      <div class="form-group kc-form-group">
        <label for="password-confirm" class="kc-label">${msg("passwordConfirm")}</label>
        <input
          type="password"
          id="password-confirm"
          name="password-confirm"
          autocomplete="new-password"
          placeholder="••••••••"
          class="${messagesPerField.existsError('password-confirm')?then('error','')}"
        />
        <#if messagesPerField.existsError('password-confirm')>
          <span style="color:var(--error);font-size:0.8rem;">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</span>
        </#if>
      </div>

      <div id="kc-form-buttons" class="kc-form-buttons">
        <#if isAppInitiatedAction??>
          <input type="submit" value="${msg("doSubmit")}" />
          <button type="submit" name="cancel-aia" value="true" class="btn-default">
            ${msg("doCancel")}
          </button>
        <#else>
          <input type="submit" value="${msg("doSubmit")}" />
        </#if>
      </div>

    </form>
  </#if>

</@layout.registrationLayout>
