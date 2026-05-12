<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
  <#if section = "header">
  <#elseif section = "form">
    <div class="bw-layout">
      <section class="bw-branding" aria-label="Branding panel">
        <div class="bw-branding-content">
          <h1 class="bw-title">${realm.displayName!realm.name!"Keycloak"}</h1>
        </div>
      </section>

      <section class="bw-login-pane" aria-label="Login panel">
        <div class="bw-login-card">
          <#if message?has_content>
            <div class="bw-alert">${kcSanitize(message.summary)?no_esc}</div>
          </#if>

          <form id="kc-form-login" action="${url.loginAction}" method="post">
            <label class="bw-label" for="username">${msg("usernameOrEmail")}</label>
            <input
              id="username"
              class="bw-input"
              name="username"
              type="text"
              autocomplete="username"
              value="${(login.username!'')}"
              autofocus
            />

            <label class="bw-label" for="password">${msg("password")}</label>
            <input
              id="password"
              class="bw-input"
              name="password"
              type="password"
              autocomplete="current-password"
            />

            <#if realm.rememberMe>
              <label class="bw-checkbox">
                <input id="rememberMe" name="rememberMe" type="checkbox" />
                <span>${msg("rememberMe")}</span>
              </label>
            </#if>

            <button class="bw-submit" name="login" id="kc-login" type="submit">${msg("doLogIn")}</button>
          </form>

          <div class="bw-links">
            <#if realm.resetPasswordAllowed>
              <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
            </#if>
            <#if realm.registrationAllowed>
              <a href="${url.registrationUrl}">${msg("doRegister")}</a>
            </#if>
          </div>
        </div>
      </section>
    </div>
  </#if>
</@layout.registrationLayout>
