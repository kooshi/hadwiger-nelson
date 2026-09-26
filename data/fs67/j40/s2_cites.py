#!/usr/bin/env python3
"""J40: Semantic Scholar citing-works walk (second database). usage: s2_cites.py DOI:<doi>|ARXIV:<id> ...
Retries once after 30 s on 429/5xx; prints UNANSWERED if still failing (never a negative)."""
import json, sys, subprocess, time
for pid in sys.argv[1:]:
    url = f"https://api.semanticscholar.org/graph/v1/paper/{pid}/citations?fields=title,year,externalIds&limit=1000"
    d = None
    for a in range(3):
        r = subprocess.run(["curl", "-s", "-m", "60", "-w", "\n%{http_code}", url], capture_output=True, text=True)
        body, _, code = r.stdout.rpartition("\n")
        if code == "200": d = json.loads(body); break
        time.sleep(30)
    if d is None: print(f"== {pid}: UNANSWERED (HTTP {code})\n"); continue
    rows = d.get("data", [])
    print(f"== {pid}: {len(rows)} citing works")
    for x in sorted(rows, key=lambda x: (x['citingPaper'].get('year') or 0)):
        p = x["citingPaper"]; ids = p.get("externalIds") or {}
        print(f"  {p.get('year')} | {(p.get('title') or '')[:110]} | {ids.get('DOI') or ids.get('ArXiv') or ''}")
    print()
