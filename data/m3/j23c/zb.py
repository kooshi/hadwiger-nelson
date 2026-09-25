#!/usr/bin/env python3
"""zbMATH Open API discovery queries for M3's close gate (J23c). Prints count and one line per hit."""
import json, sys, subprocess, urllib.parse
def q(s, n=40):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    r = subprocess.run(["curl", "-s", "-m", "40", url], capture_output=True, text=True)
    try:
        d = json.loads(r.stdout)
    except Exception:
        return f"QUERY {s!r}: ERROR {r.stdout[:200]!r}"
    res = d.get("result", []) or []
    tot = d.get("status", {}).get("nr_total_results", len(res))
    out = [f"QUERY {s!r}: {tot} hits"]
    for x in res:
        t = (x.get("title") or {}).get("title", "?")
        y = x.get("year", "?")
        au = "; ".join(a.get("name", "?") for a in (x.get("contributors") or {}).get("authors", [])[:3])
        src = ""
        try:
            src = x["source"][0]["series"][0]["title"]
        except Exception:
            pass
        out.append(f"  {y} | {au} | {t[:110]} | {src[:40]} | zbl {x.get('identifier','')}")
    return "\n".join(out)
if __name__ == "__main__":
    for s in sys.argv[1:]:
        print(q(s)); print()
