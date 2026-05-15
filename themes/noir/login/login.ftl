<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

  <#if section = "header">
    <h1 class="kc-page-title">${msg("loginAccountTitle")}</h1>
    <p class="kc-page-subtitle">Sign in to continue</p>
  </#if>

  <#if section = "form">

    <#-- ── Email / Password Form (always first) ── -->
    <#if realm.password>
      <form id="kc-form-login" action="${url.loginAction}" method="post">

        <div class="form-group kc-form-group">
          <label for="username" class="kc-label">
            <#if !realm.loginWithEmailAllowed>${msg("username")}
            <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
            <#else>${msg("email")}</#if>
          </label>
          <input
            tabindex="1"
            id="username"
            name="username"
            type="text"
            autocomplete="<#if !realm.loginWithEmailAllowed>username<#else>email</#if>"
            autofocus
            placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>you@example.com</#if>"
            value="${(login.username!'')}"
            <#if usernameEditDisabled??>disabled</#if>
            class="${messagesPerField.existsError('username','password')?then('error','')}"
          />
          <#if messagesPerField.existsError('username','password')>
            <span class="kc-field-error">
              ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
            </span>
          </#if>
        </div>

        <div class="form-group kc-form-group">
          <label for="password" class="kc-label">${msg("password")}</label>
          <div class="kc-input-group">
            <input
              tabindex="2"
              id="password"
              name="password"
              type="password"
              autocomplete="current-password"
              placeholder="••••••••"
              class="${messagesPerField.existsError('username','password')?then('error','')}"
            />
          </div>
        </div>

        <div id="kc-form-options" class="kc-form-options">
          <#if realm.rememberMe && !usernameEditDisabled??>
            <div class="checkbox kc-checkbox">
              <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                     <#if login.rememberMe??>checked</#if> />
              <label for="rememberMe">${msg("rememberMe")}</label>
            </div>
          <#else>
            <span></span>
          </#if>
          <#if realm.resetPasswordAllowed>
            <a tabindex="5" href="${url.loginResetCredentialsUrl}" class="kc-forgot-link">${msg("doForgotPassword")}</a>
          </#if>
        </div>

        <input type="hidden" id="id-hidden-input" name="credentialId"
               <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if> />

        <div id="kc-form-buttons" class="kc-form-buttons">
          <input
            tabindex="4"
            id="kc-login"
            name="login"
            type="submit"
            value="${msg("doLogIn")}"
          />
        </div>

      </form>
    </#if>

    <#-- ── Passkey / Social providers (below, as alternatives) ── -->
    <#if realm.password && social.providers?? && social.providers?has_content>
      <div class="kc-social-divider separator">
        <span>${msg("orSignInWith")!"or continue with"}</span>
      </div>
      <div id="kc-social-providers" class="kc-social-section">
        <#list social.providers as p>
          <a id="social-${p.alias}" class="kc-social-item" href="${p.loginUrl}">
            <#if p.alias?contains("webauthn") || p.alias?contains("passkey")>
              <svg viewBox="0 0 18 18" fill="none" style="width:16px;height:16px;flex-shrink:0;">
                <circle cx="7" cy="7" r="4" stroke="currentColor" stroke-width="1.5"/>
                <path d="M10 7a3 3 0 1 1-3-3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                <path d="M10 4.5h2.5v2.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M12.5 4.5l-3 3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
              </svg>
            </#if>
            <span>${p.displayName!}</span>
          </a>
        </#list>
      </div>
    </#if>

    <#-- ── Registration link ── -->
    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <div id="kc-registration" class="kc-form-footer">
        <span>${msg("noAccount")}</span>
        <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a>
      </div>
    </#if>

    <#if auth?has_content && auth.showTryAnotherWayLink()>
      <div class="kc-social-divider separator">
        <span>or</span>
      </div>

      <form id="kc-passkey-login-form" action="${url.loginAction}" method="post" class="kc-social-section">
        <input type="hidden" name="tryAnotherWay" value="on"/>
        <button type="submit" id="kc-passkey-login" class="btn-primary" onclick="window.sessionStorage.setItem('kcNoirDirectPasskey','1');">
          <img class="kc-passkey-icon" src="${url.resourcesPath}/img/PasskeyStreamlineSymbols.svg" alt="" aria-hidden="true" />
          <span>Sign in with passkey</span>
        </button>
      </form>
    </#if>

  </#if>

</@layout.registrationLayout>
