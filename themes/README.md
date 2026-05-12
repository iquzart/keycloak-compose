# Noir — Keycloak Theme

A minimal, classy, production-grade black & white Keycloak theme with a split-panel layout.

## Layout

```
┌─────────────────────┬─────────────────────┐
│                     │                     │
│   BRAND PANEL       │   AUTH PANEL        │
│   (black bg)        │   (off-white bg)    │
│                     │                     │
│   • Logo            │   • Login form      │
│   • Tagline         │   • Password reset  │
│   • Descriptor      │   • TOTP / OTP      │
│   • Footer          │   • Passkey auth    │
│                     │   • Registration    │
└─────────────────────┴─────────────────────┘
```

On screens ≤ 900px, the brand panel is hidden and the auth form takes the full width.

## Files

```
noir/
└── login/
    ├── theme.properties          # Theme config (parent = base)
    ├── template.ftl              # Master layout (split panels)
    ├── login.ftl                 # Login form
    ├── login-reset-password.ftl  # Forgot password
    ├── login-otp.ftl             # TOTP / OTP challenge
    ├── login-config-totp.ftl     # TOTP setup (QR + code)
    ├── webauthn-authenticate.ftl # Passkey login
    ├── webauthn-register.ftl     # Passkey registration
    ├── login-update-password.ftl # Forced password update
    ├── login-verify-email.ftl    # Email verification
    ├── register.ftl              # New account registration
    ├── error.ftl                 # Error page
    └── resources/
        └── css/
            └── noir.css          # All styles (CSS variables, responsive)
```

## Installation

1. Copy the `noir/` folder into your Keycloak themes directory:
   ```
   $KEYCLOAK_HOME/themes/noir/
   ```

2. In the Keycloak Admin Console:
   - Go to **Realm Settings → Themes**
   - Set **Login Theme** to `noir`
   - Save

3. (Optional) Customise the brand panel in `template.ftl`:
   - Change the logo SVG or swap in an `<img>` tag
   - Update the tagline and descriptor copy
   - The realm display name is pulled automatically from Keycloak

## Design Tokens

All design decisions are CSS variables at the top of `noir.css`:

| Variable        | Value      | Usage                     |
|-----------------|------------|---------------------------|
| `--ink`         | `#0a0a0a`  | Primary dark colour       |
| `--paper`       | `#f7f6f4`  | Auth panel background     |
| `--white`       | `#ffffff`  | Input backgrounds         |
| `--gray-*`      | Various    | Text, borders, surfaces   |
| `--font-display`| Playfair Display | Headers, brand    |
| `--font-body`   | DM Sans    | Body, inputs, buttons     |
| `--transition`  | 200ms ease | All transitions           |

## Compatibility

- Keycloak 21+ (Quarkus distribution)
- Tested against `parent=base` theme
- PatternFly 5 overrides included
- Google Fonts loaded via CDN (swap to self-hosted for air-gapped deployments)
