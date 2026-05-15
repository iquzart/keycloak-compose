<!doctype html>
<html lang="${locale}">
  <head>
    <meta charset="utf-8">
    <link rel="icon" type="${properties.favIconType!'image/svg+xml'}" href="${resourceUrl}${properties.favIcon!'/favicon.svg'}">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="color-scheme" content="light">
    <meta name="description" content="${properties.description!'Manage your account settings and security.'}">
    <title>${properties.title!'Account Management'}</title>
    <style>
      :root {
        color-scheme: light;
      }

      body {
        margin: 0;
      }

      body,
      #app {
        min-height: 100%;
      }

      .app-loading-shell {
        min-height: 100vh;
        width: 100%;
        display: grid;
        place-items: center;
        background:
          radial-gradient(1000px 500px at -10% -10%, rgba(10, 10, 10, 0.1), transparent 60%),
          radial-gradient(700px 360px at 110% 10%, rgba(46, 44, 42, 0.16), transparent 60%),
          #f7f6f4;
        color: #0a0a0a;
      }

      .app-loading-card {
        width: min(420px, calc(100vw - 48px));
        border-radius: 18px;
        border: 1px solid rgba(10, 10, 10, 0.08);
        background: rgba(255, 255, 255, 0.88);
        backdrop-filter: blur(6px);
        box-shadow: 0 24px 64px rgba(10, 10, 10, 0.16);
        padding: 28px 24px;
        display: grid;
        gap: 16px;
      }

      .app-loading-brand {
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .app-loading-brand img {
        width: 56px;
        max-width: 100%;
        height: auto;
      }

      .app-loading-spinner {
        width: 28px;
        height: 28px;
        border-radius: 999px;
        border: 2px solid rgba(10, 10, 10, 0.22);
        border-top-color: #0a0a0a;
        margin: 0 auto;
        animation: spin 0.8s linear infinite;
      }

      .app-loading-text {
        margin: 0;
        text-align: center;
        font-family: "Dubai", "Barlow", system-ui, sans-serif;
        font-size: 15px;
        line-height: 1.35;
        color: rgba(10, 10, 10, 0.9);
      }

      @keyframes spin {
        to { transform: rotate(360deg); }
      }

    </style>
    <script type="importmap">
      {
        "imports": {
          "react": "${resourceCommonUrl}/vendor/react/react.production.min.js",
          "react/jsx-runtime": "${resourceCommonUrl}/vendor/react/react-jsx-runtime.production.min.js",
          "react-dom": "${resourceCommonUrl}/vendor/react-dom/react-dom.production.min.js"
        }
      }
    </script>
    <#if !isSecureContext>
      <script type="module" src="${resourceCommonUrl}/vendor/web-crypto-shim/web-crypto-shim.js"></script>
    </#if>
    <#if devServerUrl?has_content>
      <script type="module">
        import { injectIntoGlobalHook } from "${devServerUrl}/@react-refresh";

        injectIntoGlobalHook(window);
        window.$RefreshReg$ = () => {};
        window.$RefreshSig$ = () => (type) => type;
      </script>
      <script type="module">
        import { inject } from "${devServerUrl}/@vite-plugin-checker-runtime";

        inject({
          overlayConfig: {},
          base: "/",
        });
      </script>
      <script type="module" src="${devServerUrl}/@vite/client"></script>
      <script type="module" src="${devServerUrl}/src/main.tsx"></script>
    </#if>
    <#if entryStyles?has_content>
      <#list entryStyles as style>
        <link rel="stylesheet" href="${resourceUrl}/${style}">
      </#list>
    </#if>
    <#if properties.styles?has_content>
      <#list properties.styles?split(' ') as style>
        <link rel="stylesheet" href="${resourceUrl}/${style}">
      </#list>
    </#if>
    <#if entryScript?has_content>
      <script type="module" src="${resourceUrl}/${entryScript}"></script>
    </#if>
    <#if properties.scripts?has_content>
      <#list properties.scripts?split(' ') as script>
        <script type="module" src="${resourceUrl}/${script}"></script>
      </#list>
    </#if>
    <#if entryImports?has_content>
      <#list entryImports as import>
        <link rel="modulepreload" href="${resourceUrl}/${import}">
      </#list>
    </#if>
  </head>
  <body data-page-id="account">
    <div id="app">
      <main class="app-loading-shell" aria-live="polite">
        <section class="app-loading-card" aria-label="Loading account workspace">
          <div class="app-loading-brand">
            <img src="${resourceUrl}${properties.logo!'/img/noir-logo.svg'}" alt="Example.com" />
          </div>
          <div class="app-loading-spinner" aria-hidden="true"></div>
          <p class="app-loading-text">Preparing your account workspace...</p>
        </section>
      </main>
    </div>
    <noscript>JavaScript is required to use this account workspace.</noscript>
    <script id="environment" type="application/json">
      {
        "serverBaseUrl": "${serverBaseUrl}",
        "authUrl": "${authUrl}",
        "authServerUrl": "${authServerUrl}",
        "realm": "${realm.name}",
        "clientId": "${clientId}",
        "resourceUrl": "${resourceUrl}",
        "logo": "${properties.logo!""}",
        "logoUrl": "${properties.logoUrl!""}",
        "baseUrl": "${baseUrl}",
        "locale": "${locale}",
        "referrerName": "${referrerName!""}",
        "referrerUrl": "${referrer_uri!""}",
        "features": {
          "isRegistrationEmailAsUsername": ${realm.registrationEmailAsUsername?c},
          "isEditUserNameAllowed": ${realm.editUsernameAllowed?c},
          "isInternationalizationEnabled": ${realm.isInternationalizationEnabled()?c},
          "isLinkedAccountsEnabled": ${isLinkedAccountsEnabled?c},
          "isMyResourcesEnabled": ${(realm.userManagedAccessAllowed && isAuthorizationEnabled)?c},
          "isViewOrganizationsEnabled": ${isViewOrganizationsEnabled?c},
          "deleteAccountAllowed": ${deleteAccountAllowed?c},
          "updateEmailFeatureEnabled": ${updateEmailFeatureEnabled?c},
          "updateEmailActionEnabled": ${updateEmailActionEnabled?c},
          "isViewGroupsEnabled": ${isViewGroupsEnabled?c},
          "isOid4VciEnabled": ${isOid4VciEnabled?c}
        },
        "scope": "${scope!""}"
      }
    </script>
  </body>
</html>
