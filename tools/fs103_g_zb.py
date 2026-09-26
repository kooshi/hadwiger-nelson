#!/usr/bin/env python3
"""FS103-G: zbMATH Open API discovery queries for the FS-103 prior-art gate.

Usage:
  tools/fs103_g_zb.py <tag> '<search_string>'          # fetch all pages, save JSON + a TSV digest
  tools/fs103_g_zb.py --selftest                        # a query with a known answer must find it

Saves under data/fs103/fs103-g/zb/<tag>.json.gz (all records) and <tag>.tsv
(zbl id, year, doc type, review kind, title, source). Prints the total the API
reports beside the count fetched; a mismatch is printed loudly, never silently.
Reading status: a TSV row is a LISTING. A review text is a reviewer's reading or
an author's summary (field `kind`), never ours.
"""
import gzip
import json
import pathlib
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

API = "https://api.zbmath.org/v1/document/_search"
OUT = pathlib.Path(__file__).resolve().parent.parent / "data" / "fs103" / "fs103-g" / "zb"


def fetch(search_string, page, per_page=100):
    q = urllib.parse.urlencode(
        {"search_string": search_string, "results_per_page": per_page, "page": page}
    )
    req = urllib.request.Request(API + "?" + q, headers={"User-Agent": "lean-dir-fs103-g"})
    try:
        with urllib.request.urlopen(req, timeout=90) as r:
            return json.load(r)
    except urllib.error.HTTPError as e:
        # The API answers an empty result set with HTTP 404 and a JSON body; any other
        # error is re-raised, loudly.
        if e.code == 404:
            body = json.load(e)
            st = body.get("status", {})
            if "No results found" in (st.get("internal_code") or ""):
                return {"result": [], "status": {"nr_total_results": 0}}
        raise


def run(search_string):
    recs, page, total = [], 0, None
    while True:
        d = fetch(search_string, page)
        st = d.get("status", {})
        if total is None:
            total = st.get("nr_total_results", 0)
        res = d.get("result") or []
        recs.extend(res)
        if not res or len(recs) >= total:
            break
        page += 1
        time.sleep(0.5)
    return total, recs


def digest(rec):
    zbl = rec.get("identifier") or rec.get("id")
    year = rec.get("year")
    title = ""
    t = rec.get("title")
    if isinstance(t, dict):
        title = t.get("title") or ""
    elif isinstance(t, str):
        title = t
    src = ""
    s = rec.get("source") or {}
    if isinstance(s, dict):
        src = (s.get("source") or "")
    dtype = (rec.get("document_type") or {}).get("code", "")
    kinds = []
    for ec in rec.get("editorial_contributions") or []:
        kinds.append(ec.get("contribution_type") or ("review" if ec.get("reviewer") else "summary?"))
    return [str(zbl), str(year), dtype, "/".join(kinds) or "-", title.replace("\t", " "), src.replace("\t", " ")]


def main():
    if sys.argv[1:] == ["--selftest"]:
        # Known positive: Fischer 1994 is found by the WORKFLOW 3.2 item 8 query.
        total, recs = run('ti:"chromatic number" & ab:"additive" & ab:"coloring" & py:1985-2000')
        titles = [digest(r)[4] for r in recs]
        ok = any("planar geometric graph" in t.lower() for t in titles)
        print(f"selftest: total={total} fetched={len(recs)} fischer1994_found={ok}")
        # Planted negative: a nonsense author must return zero.
        total2, recs2 = run('au:"Zzzqqxx, Nobody"')
        print(f"selftest: nonsense author total={total2} fetched={len(recs2)}")
        sys.exit(0 if ok and total2 == 0 else 1)
    tag, qs = sys.argv[1], sys.argv[2]
    OUT.mkdir(parents=True, exist_ok=True)
    total, recs = run(qs)
    with gzip.open(OUT / f"{tag}.json.gz", "wt") as g:
        g.write(json.dumps({"query": qs, "total": total, "records": recs}))
    rows = [digest(r) for r in recs]
    rows.sort(key=lambda r: r[1])
    with open(OUT / f"{tag}.tsv", "w") as f:
        f.write(f"# query: {qs}\n# total reported: {total}; fetched: {len(recs)}\n")
        for r in rows:
            f.write("\t".join("" if x is None else str(x) for x in r) + "\n")
    flag = "" if total == len(recs) else "   *** MISMATCH: fetched != total ***"
    print(f"{tag}: total={total} fetched={len(recs)}{flag}")


if __name__ == "__main__":
    main()
