#!/usr/bin/env python3
"""Print the review/summary text of zbMATH documents by Zbl number (J23c's gate)."""
import json, sys, subprocess, urllib.parse, re
for an in sys.argv[1:]:
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": f"an:{an}", "results_per_page": 1})
    r = subprocess.run(["curl", "-s", "-m", "40", url], capture_output=True, text=True)
    d = json.loads(r.stdout); x = (d.get("result") or [{}])[0]
    t = (x.get("title") or {}).get("title", "?")
    ec = x.get("editorial_contributions") or []
    print(f"== {an} | {x.get('year')} | {t}")
    for e in ec:
        txt = re.sub(r"\s+", " ", e.get("text") or "")
        print(f"  [{e.get('contribution_type')}] {txt[:1400]}")
    print()
