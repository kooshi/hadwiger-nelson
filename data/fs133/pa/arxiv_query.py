#!/usr/bin/env python3
"""FS133-E1 §PA: arXiv API listings, newest first. Usage: arxiv_query.py <tag> <query>. Writes ax-<tag>.xml and prints a digest."""
import sys, re, subprocess
n, s = sys.argv[1], sys.argv[2]
subprocess.run(["curl", "-s", "-L", "-G", "--max-time", "60", "https://export.arxiv.org/api/query",
                "--data-urlencode", f"search_query={s}", "--data-urlencode", "sortBy=submittedDate",
                "--data-urlencode", "sortOrder=descending", "--data-urlencode", "max_results=25",
                "-o", f"ax-{n}.xml"], check=False)
t = open(f"ax-{n}.xml", encoding="utf-8", errors="replace").read()
tot = re.search(r"<opensearch:totalResults[^>]*>(\d+)<", t)
es = re.findall(r"<entry>(.*?)</entry>", t, flags=re.S)
print(f"{n} | {s} | total {tot.group(1) if tot else 'NO-RESPONSE'} | shown {len(es)}")
for e in es[:int(sys.argv[3]) if len(sys.argv) > 3 else 8]:
    i = re.search(r"<id>(.*?)</id>", e).group(1).split("/abs/")[-1]
    p = re.search(r"<published>(.*?)</published>", e).group(1)[:10]
    ti = " ".join(re.search(r"<title>(.*?)</title>", e, flags=re.S).group(1).split())
    print("   ", p, i, "|", ti[:120])
