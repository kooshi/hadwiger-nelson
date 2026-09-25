#!/usr/bin/env python3
"""Throwaway arXiv API helper; logs query + hit count."""
import sys, urllib.parse, urllib.request, re, json, os, time
LOG = os.path.join(os.path.dirname(__file__), "queries-arxiv.jsonl")
def q(s, n=40, full=False):
    url = "http://export.arxiv.org/api/query?" + urllib.parse.urlencode({"search_query": s, "max_results": n})
    with urllib.request.urlopen(url, timeout=60) as r:
        x = r.read().decode()
    tot = re.search(r"<opensearch:totalResults[^>]*>(\d+)<", x)
    tot = int(tot.group(1)) if tot else -1
    with open(LOG, "a") as f: f.write(json.dumps({"q": s, "hits": tot}) + "\n")
    print(f"### {s} -> {tot}")
    for e in x.split("<entry>")[1:]:
        t = re.sub(r"\s+", " ", re.search(r"<title>(.*?)</title>", e, re.S).group(1))
        i = re.search(r"<id>http://arxiv.org/abs/(.*?)</id>", e).group(1)
        a = re.findall(r"<name>(.*?)</name>", e)[:4]
        p = re.search(r"<published>(\d{4})", e).group(1)
        print(f" - {i} {p} {'; '.join(a)} | {t}")
        if full:
            s_ = re.sub(r"\s+", " ", re.search(r"<summary>(.*?)</summary>", e, re.S).group(1))
            print("     " + s_[:1400])
    time.sleep(3)
if __name__ == "__main__":
    full = "--full" in sys.argv
    for s in [a for a in sys.argv[1:] if a != "--full"]:
        q(s, full=full)
