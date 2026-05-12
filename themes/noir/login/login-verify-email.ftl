<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=true; section>

  <#if section = "header">
    <h1 class="kc-page-title">${msg("emailVerifyTitle")!"Check your inbox"}</h1>
    <p class="kc-page-subtitle">
      ${msg("emailVerifyInstruction1", user.email)!"We sent a verification link to your email address."}
    </p>
  </#if>

  <#if section = "form">
    <div style="text-align: center; padding: 16px 0;">
      <svg viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:48px;height:48px;color:var(--gray-400);margin:0 auto 16px;display:block;">
        <rect x="4" y="10" width="40" height="28" rx="3" stroke="currentColor" stroke-width="2.5"/>
        <path d="M4 14l20 14 20-14" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      </svg>
      <p style="font-size:0.875rem;color:var(--gray-600);line-height:1.6;">
        ${msg("emailVerifyInstruction2")!"Didn't receive an email? Check your spam folder or"}
        <a href="${url.loginAction}">${msg("doClickHere")!"click here to resend"}</a>.
      </p>
    </div>
  </#if>

</@layout.registrationLayout>
