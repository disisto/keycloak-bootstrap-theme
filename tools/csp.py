#!/usr/bin/env python3
# Keycloak Bootstrap Theme
# https://github.com/disisto/keycloak-bootstrap-theme
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025-2026 Roberto Di Sisto

"""Print a strict Content-Security-Policy for a Keycloak realm that uses this theme.

The theme itself needs no inline code. Keycloak's own pages still do (account console, the
third-party-cookie check and the login-status iframe), so their inline <script>/<style> blocks are
allowed by hash. The hashes change with every Keycloak version: run this again after each upgrade.

Usage:
  tools/csp.py https://sso.example.com my-realm [--frame-src https://app.example.com ...]
               [--connect-src https://api.example.com ...] [--client account-console]
               [--redirect-uri https://sso.example.com/realms/my-realm/account/]

Then set the output in the admin console: Realm settings > Security defenses > Headers >
Content-Security-Policy. Only standard library, no third-party packages.
"""
import argparse
import base64
import hashlib
import re
import sys
import urllib.parse
import urllib.request


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": "keycloak-bootstrap-theme-csp/1.0"})
    with urllib.request.urlopen(req, timeout=15) as r:
        return r.read().decode("utf-8", "replace")


def inline_blocks(html):
    scripts = [m.group(2) for m in re.finditer(r"<script([^>]*)>([\s\S]*?)</script>", html)
               if "src=" not in m.group(1)
               and not re.search(r"type=[\"']?application/(ld\+)?json", m.group(1))]  # data, not executed
    styles = [m.group(1) for m in re.finditer(r"<style[^>]*>([\s\S]*?)</style>", html)]
    return scripts, styles


def sha(text):
    return "'sha256-" + base64.b64encode(hashlib.sha256(text.encode()).digest()).decode() + "'"


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("base_url", help="Keycloak base URL, e.g. https://sso.example.com")
    ap.add_argument("realm")
    ap.add_argument("--client", default="account-console", help="client for the login page check")
    ap.add_argument("--redirect-uri", help="redirect_uri of that client (default: the account console)")
    ap.add_argument("--frame-src", nargs="*", default=[], help="extra origins Keycloak may frame")
    ap.add_argument("--connect-src", nargs="*", default=[], help="extra origins for fetch/XHR")
    a = ap.parse_args()

    base = a.base_url.rstrip("/") + "/realms/" + urllib.parse.quote(a.realm)
    redirect = a.redirect_uri or base + "/account/"
    login_url = (base + "/protocol/openid-connect/auth?response_type=code&scope=openid"
                 "&client_id=" + urllib.parse.quote(a.client) + "&redirect_uri=" + urllib.parse.quote(redirect, safe="")
                 + "&code_challenge=E9Melhoofk1xQyYYGB4DJuC4lgCMmL64pFyiUVGsHtg&code_challenge_method=S256")

    s, st = inline_blocks(fetch(login_url))
    if s or st:
        sys.exit(f"login page has {len(s)} inline script(s) and {len(st)} style block(s): "
                 "is the realm's login theme set to bootstrap-signin-theme?")

    scripts, styles = [], []
    for path in ("/account/", "/protocol/openid-connect/3p-cookies/step1.html",
                 "/protocol/openid-connect/3p-cookies/step2.html",
                 "/protocol/openid-connect/login-status-iframe.html"):
        try:
            s, st = inline_blocks(fetch(base + path))
        except Exception as e:  # e.g. account console disabled
            print(f"note: {path} skipped ({e})", file=sys.stderr)
            continue
        scripts += [sha(x) for x in s]
        styles += [sha(x) for x in st]

    uniq = lambda items: "".join(" " + i for i in dict.fromkeys(items))
    print("default-src 'none'; "
          f"script-src 'self'{uniq(scripts)}; style-src 'self'{uniq(styles)}; "
          "img-src 'self' data:; font-src 'self'; "
          f"connect-src 'self'{uniq(a.connect_src)}; frame-src 'self'{uniq(a.frame_src)}; "
          "frame-ancestors 'self'; base-uri 'self'; object-src 'none'; manifest-src 'self'")


if __name__ == "__main__":
    main()
