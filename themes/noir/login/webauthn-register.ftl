<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>

<@layout.registrationLayout; section>
  <#if section = "header">
    <h1 class="kc-page-title">${msg("webauthn-registration-title")}</h1>
    <p class="kc-page-subtitle">Add a passkey for faster, more secure sign-in.</p>
  <#elseif section = "form">
    <form id="register" action="${url.loginAction}" method="post">
      <input type="hidden" id="clientDataJSON" name="clientDataJSON" />
      <input type="hidden" id="attestationObject" name="attestationObject" />
      <input type="hidden" id="publicKeyCredentialId" name="publicKeyCredentialId" />
      <input type="hidden" id="authenticatorLabel" name="authenticatorLabel" />
      <input type="hidden" id="transports" name="transports" />
      <input type="hidden" id="error" name="error" />
      <@passwordCommons.logoutOtherSessions/>
    </form>

    <script type="module">
      <#outputformat "JavaScript">
      import { registerByWebAuthn } from "${url.resourcesPath}/js/webauthnRegister.js";
      window.kcNoirRegisterWebAuthn = function() {
        const input = {
          challenge: ${challenge?c},
          userid: ${userid?c},
          username: ${username?c},
          signatureAlgorithms: [<#list signatureAlgorithms as sigAlg>${sigAlg?c},</#list>],
          rpEntityName: ${rpEntityName?c},
          rpId: ${rpId?c},
          attestationConveyancePreference: ${attestationConveyancePreference?c},
          authenticatorAttachment: ${authenticatorAttachment?c},
          requireResidentKey: ${requireResidentKey?c},
          userVerificationRequirement: ${userVerificationRequirement?c},
          createTimeout: ${createTimeout?c},
          excludeCredentialIds: ${excludeCredentialIds?c},
          initLabel: ${msg("webauthn-registration-init-label")?c},
          initLabelPrompt: ${msg("webauthn-registration-init-label-prompt")?c},
          errmsg: ${msg("webauthn-unsupported-browser-text")?c}
        };
        try {
          registerByWebAuthn(input);
        } catch (e) {
          const errorEl = document.getElementById("error");
          if (errorEl) {
            errorEl.value = e && e.message ? e.message : "webAuthn registration failed";
          }
          const formEl = document.getElementById("register");
          if (formEl) {
            formEl.submit();
          }
        }
      };

      </#outputformat>
    </script>

    <div id="kc-form-buttons" class="kc-form-buttons">
      <input type="button" id="registerWebAuthn" value="${msg("doRegisterSecurityKey")}" onclick="this.disabled=true;if (window.kcNoirRegisterWebAuthn) window.kcNoirRegisterWebAuthn();" />
    </div>

    <#if !isSetRetry?has_content && isAppInitiatedAction?has_content>
      <form action="${url.loginAction}" method="post">
        <button type="submit" id="cancelWebAuthnAIA" name="cancel-aia" value="true" class="btn-default">
          ${msg("doCancel")}
        </button>
      </form>
    </#if>
  </#if>
</@layout.registrationLayout>
