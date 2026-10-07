#!/usr/bin/env python3
"""FS133-E1 §PA: zbMATH Open API. Usage: zbmath_query.py <tag> <search_string>. Writes zb-<tag>.json, prints a digest."""
import sys, json, subprocess
n, s = sys.argv[1], sys.argv[2]
r = subprocess.run(["curl", "-s", "-G", "--max-time", "40", "-w", "%{http_code}", "https://api.zbmath.org/v1/document/_search",
                    "--data-urlencode", f"search_string={s}", "--data-urlencode", "results_per_page=100", "-o", f"zb-{n}.json"],
                   capture_output=True, text=True)
code = r.stdout.strip()
try:
    d = json.load(open(f"zb-{n}.json"))
except Exception:
    print(f"{n} | {s} | HTTP {code} | NO JSON"); sys.exit(0)
res = d.get("result") or []
print(f"{n} | {s} | HTTP {code} | hits {len(res)}")
for x in res[:10]:
    t = (x.get("title") or {}).get("title", "")
    au = ", ".join(a.get("name", "") for a in (x.get("contributors") or {}).get("authors", []))
    print("   ", x.get("year"), "|", au[:50], "|", t[:100])
