#!/usr/bin/env python3
"""Fetch zbMATH review/summary text by Zbl number or by an author query filtered to colouring titles."""
import json, sys, urllib.parse, urllib.request
def get(s, n=100):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    with urllib.request.urlopen(url, timeout=60) as r:
        return json.load(r).get("result", []) or []
mode = sys.argv[1]
if mode == "an":
    for an in sys.argv[2:]:
        try:
            items = get(f"an:{an}", 5)
        except Exception as e:
            print(f"== {an} ERROR {e}\n"); continue
        for it in items:
            t = (it.get("title") or {}).get("title", "")
            eds = it.get("editorial_contributions") or []
            txt = " / ".join(f"[{e.get('contribution_type')}] {(e.get('text') or '')[:1500]}" for e in eds)
            print(f"== {an} {it.get('year')} {t}\n{txt}\n")
elif mode == "list":
    for it in get(sys.argv[2]):
        t = (it.get("title") or {}).get("title", "")
        print(f"{it.get('identifier')} | {it.get('year')} | {t[:120]}")
