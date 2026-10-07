#!/usr/bin/env python3
"""FS124-E2 prior-art gate: one zbMATH Open API query; prints the hit count and up to N records (year, authors, title, Zbl).
Usage: zb.py '<search_string>' [N]   — appends the full listing to data/fs124/e2/pa/zb-log.txt"""
import sys, json, subprocess, pathlib, datetime
q = sys.argv[1]; n = int(sys.argv[2]) if len(sys.argv) > 2 else 8
r = subprocess.run(["curl", "-sS", "-G", "--max-time", "60", "https://api.zbmath.org/v1/document/_search",
                    "--data-urlencode", f"search_string={q}", "--data-urlencode", "results_per_page=100"],
                   capture_output=True, text=True)
log = pathlib.Path(__file__).resolve().parent / "pa" / "zb-log.txt"
try:
    j = json.loads(r.stdout)
except Exception as ex:
    print(f"ERROR query={q!r}: {r.stdout[:200]!r} {r.stderr[:200]!r}"); sys.exit(2)
res = j.get("result") or []
tot = (j.get("status") or {}).get("nr_total_results", len(res))
lines = [f"## {datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%S")}Z  query: {q}  hits: {tot}"]
for d in res:
    au = "; ".join(a.get("name", "?") for a in (d.get("contributors", {}).get("authors") or []))
    ti = (d.get("title") or {}).get("title", "?")
    yr = d.get("year", "?"); zid = d.get("identifier") or d.get("zbmath_id") or "?"
    ed = d.get("editorial_contributions") or []
    kind = ",".join(sorted({(e.get("contribution_type") or "?") for e in ed})) or "-"
    lines.append(f"{yr} | {au} | {ti} | Zbl {zid} | text:{kind}")
with open(log, "a") as fh: fh.write("\n".join(lines) + "\n\n")
print(lines[0]); print("\n".join(l[:230] for l in lines[1:1 + n]))
