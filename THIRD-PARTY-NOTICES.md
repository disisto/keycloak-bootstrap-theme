# Third-party notices

This project includes or, at build time, adds the following third-party software.

| Component | Where | License |
|---|---|---|
| [Bootstrap](https://github.com/twbs/bootstrap) 5.3.9 | `themes/bootstrap-signin-theme/login/resources/css/bootstrap.min.css` (included) | MIT, Copyright (c) 2011-2026 The Bootstrap Authors |
| [Bootstrap Icons](https://github.com/twbs/icons) 1.11 | SVG symbols in `themes/bootstrap-signin-theme/login/sprite.ftl` and `resources/img/favicon.svg` (included) | MIT, Copyright (c) The Bootstrap Authors |
| Bootstrap "Sign-in" example | layout and `sign-in.css` are derived from it | MIT, Copyright (c) 2011-2026 The Bootstrap Authors |
| [Keycloak](https://github.com/keycloak/keycloak) WebAuthn/passkey modules (`webauthnAuthenticate.js`, `webauthnRegister.js`, `passkeysConditionalAuth.js`) | **not included**; copied from the Keycloak image by the `Dockerfile` at build time | Apache License 2.0, Copyright Red Hat, Inc. and/or its affiliates |
| [rfc4648](https://github.com/swansontec/rfc4648.js) | **not included**; copied from Keycloak's vendor bundle by the `Dockerfile` at build time | MIT, William Swanson (see the project repository) |

## Files derived from Keycloak (Apache License 2.0)

The login page templates (`themes/bootstrap-signin-theme/login/*.ftl`, except `sprite.ftl`) are
modified versions of the templates of the same name in Keycloak's base theme
(`theme/base/login/`), and the login message files
(`themes/bootstrap-signin-theme/login/messages/*.properties`) contain texts taken from Keycloak's
message files. These parts remain under the Apache License 2.0, Copyright Red Hat, Inc. and/or
its affiliates; the changes are under MIT. Each such file says so in its header
(`SPDX-License-Identifier: MIT AND Apache-2.0`). Full license text:
[LICENSES/Apache-2.0.txt](LICENSES/Apache-2.0.txt).

The e-mail templates, the scripts, `sign-in.css` (apart from the Bootstrap example it is based on),
`sprite.ftl` and the tooling are this project's own work under MIT.

## MIT License (Bootstrap, Bootstrap Icons, rfc4648)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
