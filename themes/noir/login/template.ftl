<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html lang="${(locale.currentLanguageTag)!'en'}" class="${properties.kcHtmlClass!}">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="robots" content="noindex, nofollow" />
  <title>${msg("loginTitle",(realm.displayName!''))}</title>

  <#if properties.stylesCommon?has_content>
    <#list properties.stylesCommon?split(' ') as style>
      <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
    </#list>
  </#if>
  <#if properties.styles?has_content>
    <#list properties.styles?split(' ') as style>
      <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
    </#list>
  </#if>
  <#if properties.scripts?has_content>
    <#list properties.scripts?split(' ') as script>
      <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
    </#list>
  </#if>
  <script type="importmap">
    {
      "imports": {
        "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
      }
    }
  </script>
</head>

<body class="${properties.kcBodyClass!}">

  <!-- ═══ Brand Panel (Left) ═══════════════════════════════ -->
  <div class="kc-brand-panel">
    <div class="kc-brand-logo">
      <div class="logo-mark">
        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
          <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
        </svg>
      </div>
      <span class="logo-name">${realm.displayName!realm.name}</span>
    </div>

    <div class="kc-brand-center">
      <p class="tagline">
        <strong>Blueprint environment,</strong><br>
        <em>ready for your brand and data.</em>
      </p>
      <p class="descriptor">
        This experience is a starting template.<br>
        Update copy, visuals, and realm data before production.
      </p>
    </div>

    <div class="kc-brand-footer">
      &copy; ${.now?string("yyyy")} ${realm.displayName!realm.name}
    </div>
  </div>

  <!-- ═══ Auth Panel (Right) ═══════════════════════════════ -->
  <div class="kc-auth-panel">
    <div class="kc-auth-inner">

      <#-- Alert / Flash Messages -->
      <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
        <div class="alert alert-${message.type}">
          <#if message.type = 'success'><span>&#10003;</span></#if>
          <#if message.type = 'warning'><span>&#9888;</span></#if>
          <#if message.type = 'error'><span>&#10007;</span></#if>
          <#if message.type = 'info'><span>&#8505;</span></#if>
          <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
        </div>
      </#if>

      <#-- Page content slot -->
      <#nested "header" />
      <#nested "form" />

      <#-- Optional info block -->
      <#if displayInfo>
        <div id="kc-info" class="kc-info">
          <div id="kc-info-message" class="kc-info-message">
            <#nested "info" />
          </div>
        </div>
      </#if>

    </div>
  </div>

</body>
</html>
</#macro>
