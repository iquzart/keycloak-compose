<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=(realm.registrationAllowed && !registrationDisabled??); section>
  <#if section = "header">
    <h1 class="kc-page-title">${msg("webauthn-login-title")}</h1>
    <p class="kc-page-subtitle">Authenticate using your passkey or security key.</p>
  <#elseif section = "form">
    <div id="kc-form-webauthn" class="kc-webauthn">
      <form id="webauth" action="${url.loginAction}" method="post">
        <input type="hidden" id="clientDataJSON" name="clientDataJSON" />
        <input type="hidden" id="authenticatorData" name="authenticatorData" />
        <input type="hidden" id="signature" name="signature" />
        <input type="hidden" id="credentialId" name="credentialId" />
        <input type="hidden" id="userHandle" name="userHandle" />
        <input type="hidden" id="error" name="error" />
      </form>

      <div id="kc-form-buttons" class="kc-form-buttons">
        <input id="authenticateWebAuthnButton" type="button" autofocus="autofocus" value="${msg("webauthn-doAuthenticate")}" />
      </div>
    </div>

    <script type="module">
      <#outputformat "JavaScript">
      import { authenticateByWebAuthn } from "${url.resourcesPath}/js/webauthnAuthenticate.js";
      const authButton = document.getElementById("authenticateWebAuthnButton");
      authButton.addEventListener("click", function() {
        const input = {
          isUserIdentified: ${isUserIdentified},
          challenge: ${challenge?c},
          userVerification: ${userVerification?c},
          rpId: ${rpId?c},
          createTimeout: ${createTimeout?c},
          errmsg: ${msg("webauthn-unsupported-browser-text")?c}
        };
        authenticateByWebAuthn(input);
      }, { once: true });
      </#outputformat>
    </script>
  <#elseif section = "info">
    <#if realm.registrationAllowed && !registrationDisabled??>
      <div id="kc-registration" class="kc-form-footer">
        <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
      </div>
    </#if>
  </#if>
</@layout.registrationLayout>
