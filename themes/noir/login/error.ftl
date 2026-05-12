<#import "template.ftl" as layout>

<@layout.registrationLayout; section>

  <#if section = "header">
    <h1 class="kc-page-title" style="font-size:2rem;">${msg("errorTitle")!"Something went wrong"}</h1>
  </#if>

  <#if section = "form">
    <div id="kc-error-message">
      <p class="kc-page-subtitle" style="margin-bottom: 32px;">
        ${message.summary?no_esc}
      </p>

      <div id="kc-form-buttons" class="kc-form-buttons">
        <#if client?? && client.baseUrl?has_content>
          <a id="backToApplication" href="${client.baseUrl}">
            &#8592; ${kcSanitize(msg("backToApplication"))?no_esc}
          </a>
        </#if>
      </div>
    </div>
  </#if>

</@layout.registrationLayout>
