#!/usr/bin/env python3
"""FS116-O1 prior-art queries against the zbMATH Open API. Saves each response to data/fs116/o1/zb/<n>.json and prints
count + titles. --selftest: a known positive (Woodall's 1973 paper by title words) must return >= 1 hit, and a planted
nonsense query must return 0; exit non-zero otherwise."""
import json, sys, subprocess, urllib.parse, os
OUT = "data/fs116/o1/zb"
def q(s, n=100):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    r = subprocess.run(["curl", "-s", "-m", "60", url], capture_output=True, text=True)
    try:
        d = json.loads(r.stdout)
    except ValueError:
        return "ERROR (non-JSON reply)", [], {"raw": r.stdout[:500]}
    total = (d.get("status") or {}).get("nr_total_results")
    if total is None: total = len(d.get("result") or [])
    return total, d.get("result", []) or [], d
def show(i, s):
    t, res, d = q(s)
    json.dump(d, open(f"{OUT}/{i}.json", "w"))
    print(f"[{i}] {s}  -> {t}")
    for x in res[:12]:
        ti = (x.get("title") or {}).get("title", "")
        au = "; ".join(a.get("name", "") for a in (x.get("contributors") or {}).get("authors", [])[:3])
        yr = x.get("year", "")
        print(f"     {yr} {au} :: {ti[:110]}")
    return t
if __name__ == "__main__":
    if sys.argv[1:] == ["--selftest"]:
        a = show("st1", 'ti:"distances realized by sets covering the plane"')
        b = show("st2", 'ti:"qwzxv unobtainium chromatic"')
        ok = a >= 1 and b == 0
        print("SELFTEST", "PASS" if ok else "FAIL"); sys.exit(0 if ok else 1)
    for i, s in enumerate(open(sys.argv[1]).read().strip().splitlines(), 1):
        show(i, s)
