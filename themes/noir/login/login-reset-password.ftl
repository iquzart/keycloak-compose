<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>

  <#if section = "header">
    <a href="${url.loginUrl}" id="back-to-application" class="kc-back-to">
      &#8592; ${msg("backToLogin")!"Back to login"}
    </a>
    <h1 class="kc-page-title">${msg("emailForgotTitle")}</h1>
    <p class="kc-page-subtitle">${msg("emailInstruction")!"Enter your email and we'll send a reset link."}</p>
  </#if>

  <#if section = "form">
    <form id="kc-reset-password-form" action="${url.loginAction}" method="post">

      <div class="form-group kc-form-group">
        <label for="username" class="kc-label">
          <#if !realm.loginWithEmailAllowed>${msg("username")}
          <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
          <#else>${msg("email")}</#if>
        </label>
        <input
          type="text"
          id="username"
          name="username"
          autofocus
          placeholder="you@example.com"
          value="${(auth.attemptedUsername!'')}"
          autocomplete="email"
          class="${messagesPerField.existsError('username')?then('error','')}"
        />
        <#if messagesPerField.existsError('username')>
          <span style="color:var(--error);font-size:0.8rem;">
            ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
          </span>
        </#if>
      </div>

      <div id="kc-form-buttons" class="kc-form-buttons">
        <input id="kc-reset-password" type="submit" value="${msg("doSubmit")}" />
        <a href="${url.loginUrl}" id="kc-cancel" class="btn-default">
          ${msg("doCancel")}
        </a>
      </div>

    </form>
  </#if>

  <#if section = "info">
    ${msg("emailInstructionNew")!"Check your inbox for a password reset link."}
  </#if>

</@layout.registrationLayout>
