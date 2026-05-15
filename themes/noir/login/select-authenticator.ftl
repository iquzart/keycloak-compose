<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
  <#if section = "header" || section = "show-username">
    <#if section = "header">
      ${msg("loginChooseAuthenticator")}
    </#if>
  <#elseif section = "form">

    <form id="kc-select-credential-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
      <div class="${properties.kcSelectAuthListClass!}">
        <#list auth.authenticationSelections as authenticationSelection>
          <button
            class="${properties.kcSelectAuthListItemClass!}"
            type="submit"
            name="authenticationExecution"
            value="${authenticationSelection.authExecId}"
            data-display-name="${authenticationSelection.displayName}"
            data-help-text="${authenticationSelection.helpText}"
            data-icon-class="${authenticationSelection.iconCssClass}"
          >

            <div class="${properties.kcSelectAuthListItemIconClass!}">
              <i class="${properties['${authenticationSelection.iconCssClass}']!authenticationSelection.iconCssClass} ${properties.kcSelectAuthListItemIconPropertyClass!}"></i>
            </div>
            <div class="${properties.kcSelectAuthListItemBodyClass!}">
              <div class="${properties.kcSelectAuthListItemHeadingClass!}">
                ${msg('${authenticationSelection.displayName}')}
              </div>
              <div class="${properties.kcSelectAuthListItemDescriptionClass!}">
                ${msg('${authenticationSelection.helpText}')}
              </div>
            </div>
            <div class="${properties.kcSelectAuthListItemFillClass!}"></div>
            <div class="${properties.kcSelectAuthListItemArrowClass!}">
              <i class="${properties.kcSelectAuthListItemArrowIconClass!}"></i>
            </div>
          </button>
        </#list>
      </div>
    </form>

    <script>
      (function () {
        if (!window.sessionStorage || window.sessionStorage.getItem("kcNoirDirectPasskey") !== "1") {
          return;
        }

        const options = Array.from(document.querySelectorAll('button[name="authenticationExecution"]'));
        const passkeyOption = options.find((option) => {
          const display = (option.dataset.displayName || "").toLowerCase();
          const help = (option.dataset.helpText || "").toLowerCase();
          const icon = (option.dataset.iconClass || "").toLowerCase();
          const text = (option.textContent || "").toLowerCase();
          return display.includes("webauthn") || help.includes("webauthn") || icon.includes("webauthn") || text.includes("passkey");
        });

        if (passkeyOption) {
          passkeyOption.click();
          return;
        }

        window.sessionStorage.removeItem("kcNoirDirectPasskey");
      })();
    </script>

  </#if>
</@layout.registrationLayout>
