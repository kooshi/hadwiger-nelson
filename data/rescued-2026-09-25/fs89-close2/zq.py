import json, sys, urllib.parse, urllib.request
def q(s, n=100):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    req = urllib.request.Request(url, headers={"Accept": "application/json", "User-Agent": "lean-dir-prior-art-gate"})
    with urllib.request.urlopen(req, timeout=60) as r:
        d = json.load(r)
    res = d.get("result", [])
    tot = d.get("status", {}).get("nr_total_results", len(res))
    out = []
    for x in res:
        t = x.get("title", {}).get("title", "")
        yr = x.get("year", "")
        au = "; ".join(a.get("name","") for a in x.get("contributors",{}).get("authors",[])[:3])
        ec = x.get("editorial_contributions", []) or []
        kind = ",".join(sorted({e.get("contribution_type","?") for e in ec})) or "none"
        zbl = x.get("identifier","")
        out.append((zbl, yr, au, t, kind, ec))
    return tot, out
if __name__ == "__main__":
    for s in sys.argv[1:]:
        try:
            tot, out = q(s)
        except Exception as e:
            print(f"### {s} -> 0 ({e})"); continue
        print(f"### {s} -> {tot}")
        for zbl, yr, au, t, kind, ec in out[:25]:
            print(f"  {zbl} {yr} | {au} | {t[:110]} | {kind}")
