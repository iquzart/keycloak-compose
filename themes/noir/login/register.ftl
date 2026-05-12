<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>

  <#if section = "header">
    <a href="${url.loginUrl}" id="back-to-application" class="kc-back-to">
      &#8592; ${msg("backToLogin")!"Back to login"}
    </a>
    <h1 class="kc-page-title">${msg("registerTitle")!"Create account"}</h1>
    <p class="kc-page-subtitle">${msg("registerSubtitle")!"Fill in your details to get started."}</p>
  </#if>

  <#if section = "form">
    <form id="kc-register-form" action="${url.registrationAction}" method="post">

      <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
        <div class="form-group kc-form-group">
          <label for="firstName" class="kc-label">${msg("firstName")}</label>
          <input
            type="text"
            id="firstName"
            name="firstName"
            autofocus
            placeholder="Jane"
            value="${(register.formData.firstName!'')}"
            class="${messagesPerField.existsError('firstName')?then('error','')}"
          />
          <#if messagesPerField.existsError('firstName')>
            <span style="color:var(--error);font-size:0.8rem;">${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}</span>
          </#if>
        </div>

        <div class="form-group kc-form-group">
          <label for="lastName" class="kc-label">${msg("lastName")}</label>
          <input
            type="text"
            id="lastName"
            name="lastName"
            placeholder="Doe"
            value="${(register.formData.lastName!'')}"
            class="${messagesPerField.existsError('lastName')?then('error','')}"
          />
          <#if messagesPerField.existsError('lastName')>
            <span style="color:var(--error);font-size:0.8rem;">${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}</span>
          </#if>
        </div>
      </div>

      <#if !realm.registrationEmailAsUsername>
        <div class="form-group kc-form-group">
          <label for="username" class="kc-label">${msg("username")}</label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="janedoe"
            value="${(register.formData.username!'')}"
            class="${messagesPerField.existsError('username')?then('error','')}"
          />
          <#if messagesPerField.existsError('username')>
            <span style="color:var(--error);font-size:0.8rem;">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</span>
          </#if>
        </div>
      </#if>

      <div class="form-group kc-form-group">
        <label for="email" class="kc-label">${msg("email")}</label>
        <input
          type="email"
          id="email"
          name="email"
          autocomplete="email"
          placeholder="jane@example.com"
          value="${(register.formData.email!'')}"
          class="${messagesPerField.existsError('email')?then('error','')}"
        />
        <#if messagesPerField.existsError('email')>
          <span style="color:var(--error);font-size:0.8rem;">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</span>
        </#if>
      </div>

      <#if passwordRequired??>
        <div class="form-group kc-form-group">
          <label for="password" class="kc-label">${msg("password")}</label>
          <input
            type="password"
            id="password"
            name="password"
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
      </#if>

      <div id="kc-form-buttons" class="kc-form-buttons">
        <input id="kc-register" type="submit" value="${msg("doRegister")}" />
      </div>

      <div class="kc-form-footer">
        <span>${msg("alreadyHaveAccount")!"Already have an account?"}</span>
        <a href="${url.loginUrl}">${msg("doLogIn")}</a>
      </div>

    </form>
  </#if>

</@layout.registrationLayout>
