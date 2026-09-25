#!/usr/bin/env python3
"""Throwaway zbMATH Open API query helper for FS-79's prior-art gate. Logs every query and hit count."""
import json, sys, urllib.parse, urllib.request, os, time
LOG = os.path.join(os.path.dirname(__file__), "queries.jsonl")
def q(s, n=100, show=30, full=False):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(url, timeout=60) as r:
                d = json.load(r); break
        except Exception as e:
            err = str(e); time.sleep(2)
    else:
        hits0 = "404" in err
        with open(LOG, "a") as f: f.write(json.dumps({"q": s, "hits": 0 if hits0 else "ERR"}) + "\n")
        print(f"### {s}  -> {0 if hits0 else "ERR "+err} hits"); return
    hits = d.get("status", {}).get("nr_total_results", len(d.get("result", [])))
    res = d.get("result", [])
    with open(LOG, "a") as f:
        f.write(json.dumps({"q": s, "hits": hits}) + "\n")
    print(f"### {s}  -> {hits} hits")
    for it in res[:show]:
        ti = (it.get("title") or {}).get("title", "")
        yr = it.get("year")
        au = "; ".join(a.get("name", "") for a in (it.get("contributors") or {}).get("authors", [])[:4])
        zbl = it.get("identifier")
        src = ""
        try: src = it["source"]["series"][0]["title"]
        except Exception: pass
        kind = ""
        txt = ""
        ec = it.get("editorial_contributions") or []
        if ec:
            kind = ec[0].get("contribution_type", "")
            txt = (ec[0].get("text") or "")
        print(f" - [{zbl}] {yr} {au} | {ti} | {src} | {kind}")
        if full and txt:
            print("     " + txt[:1500].replace("\n", " "))
if __name__ == "__main__":
    full = "--full" in sys.argv
    for s in [a for a in sys.argv[1:] if a != "--full"]:
        q(s, full=full)
