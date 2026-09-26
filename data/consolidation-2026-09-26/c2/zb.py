#!/usr/bin/env python3
"""C2: zbMATH Open API lookup (WORKFLOW 3.2 item 8). Usage: zb.py 'query' ... ; prints Zbl, year, source, authors, title."""
import sys, json, urllib.request, urllib.parse
for q in sys.argv[1:]:
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": q, "results_per_page": 10})
    try:
        d = json.load(urllib.request.urlopen(url, timeout=60))
    except Exception as e:
        print(f"## {q}: ERROR {e}"); continue
    res = d.get("result", [])
    print(f"## {q}: {len(res)} hits")
    for r in res:
        zbl = r.get("identifier"); yr = r.get("year")
        src = "; ".join(s.get("source", "") for s in r.get("source", {}).get("series", [])) if isinstance(r.get("source"), dict) else ""
        srcs = r.get("source", {}).get("source", "") if isinstance(r.get("source"), dict) else ""
        au = "; ".join(a.get("name", "") for a in r.get("contributors", {}).get("authors", []))
        ti = (r.get("title") or {}).get("title", "")
        links = [l.get("identifier") for l in r.get("links", []) if l.get("type") in ("arxiv", "doi")]
        print(f"   Zbl {zbl} | {yr} | {au} | {ti} | {srcs or src} | {links}")
