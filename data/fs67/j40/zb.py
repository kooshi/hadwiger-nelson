#!/usr/bin/env python3
"""J40: zbMATH Open API discovery. usage: zb.py [--rev N] "<query>" ...  Prints the total and one line per hit;
--rev N prints up to N chars of each hit's review/summary with its kind (review = reviewer; summary = author's claim).
Retries once after 20 s on HTTP 5xx / bad JSON and prints UNANSWERED if it still fails (never a negative)."""
import json, sys, subprocess, urllib.parse, time
def fetch(s, n=100):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    for attempt in range(2):
        r = subprocess.run(["curl", "-s", "-m", "60", "-w", "\n%{http_code}", url], capture_output=True, text=True)
        body, _, code = r.stdout.rpartition("\n")
        if code == "200":
            try: return json.loads(body), code
            except Exception: pass
        if code == "404":  # the API answers 404 for an empty result set
            try:
                d = json.loads(body)
                if (d.get("status") or {}).get("nr_total_results", None) in (0, None): return {"result": [], "status": {"nr_total_results": 0}}, code
            except Exception: pass
        time.sleep(20)
    return None, code
def main():
    args = sys.argv[1:]; rev = 0
    if args and args[0] == "--rev": rev = int(args[1]); args = args[2:]
    for s in args:
        d, code = fetch(s)
        if d is None:
            print(f"QUERY {s!r}: UNANSWERED (HTTP {code})\n"); continue
        res = d.get("result") or []
        tot = (d.get("status") or {}).get("nr_total_results", len(res))
        print(f"QUERY {s!r}: {tot} hits")
        for x in res:
            t = (x.get("title") or {}).get("title", "?"); y = x.get("year", "?")
            au = "; ".join(a.get("name", "?") for a in (x.get("contributors") or {}).get("authors", [])[:4])
            src = ""
            try: src = x["source"][0]["source"][:60]
            except Exception: pass
            print(f"  {y} | {au} | {t[:100]} | {src} | {x.get('identifier','')}")
            if rev:
                for ec in x.get("editorial_contributions") or []:
                    txt = (ec.get("text") or "").replace("\n", " ")
                    print(f"     [{ec.get('contribution_type')}] {txt[:rev]}")
        print()
main()
