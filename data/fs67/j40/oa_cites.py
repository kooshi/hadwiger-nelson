#!/usr/bin/env python3
"""J40: OpenAlex citing-works walk. usage: oa_cites.py <doi> [<doi> ...]; prints each citing work: year | title | doi."""
import json, sys, subprocess, urllib.parse
def get(url):
    r = subprocess.run(["curl", "-s", "-m", "60", url], capture_output=True, text=True)
    return json.loads(r.stdout)
for doi in sys.argv[1:]:
    w = get("https://api.openalex.org/works/doi:" + doi)
    wid = w["id"].split("/")[-1]
    print(f"== {doi} {wid} {w.get('title','')[:70]} | cited_by_count {w.get('cited_by_count')}")
    cursor = "*"; n = 0
    while cursor:
        d = get(f"https://api.openalex.org/works?filter=cites:{wid}&per-page=200&cursor={urllib.parse.quote(cursor)}&select=id,title,publication_year,doi")
        for x in d.get("results", []):
            n += 1; print(f"  {x.get('publication_year')} | {(x.get('title') or '')[:110]} | {x.get('doi') or x['id']}")
        cursor = (d.get("meta") or {}).get("next_cursor")
        if not d.get("results"): break
    print(f"  listed {n}\n")
