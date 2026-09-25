#!/usr/bin/env python3
"""J03 prior-art gate: zbMATH Open API discovery queries (WORKFLOW 3.2 item 8). Prints hit count and titles."""
import json, sys, urllib.parse, urllib.request
def q(s, n=25):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode(
        {"search_string": s, "results_per_page": n})
    try:
        with urllib.request.urlopen(url, timeout=40) as r:
            d = json.load(r)
    except Exception as e:
        return f"ERROR {e}", []
    res = d.get("result", []) or []
    tot = d.get("status", {}).get("nr_total_results", len(res))
    out = []
    for it in res:
        t = (it.get("title") or {}).get("title", "")
        au = "; ".join(a.get("name", "") for a in (it.get("contributors") or {}).get("authors", [])[:3])
        yr = it.get("year", "")
        zbl = it.get("identifier", "")
        src = ""
        try:
            src = it["source"]["series"][0]["title"]
        except Exception:
            pass
        out.append(f"  {zbl} | {yr} | {au} | {t[:110]} | {src[:40]}")
    return tot, out
if __name__ == "__main__":
    for line in sys.stdin:
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        tot, out = q(s)
        print(f"Q: {s}\n  hits: {tot}")
        print("\n".join(out[:12]))
