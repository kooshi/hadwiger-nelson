#!/usr/bin/env python3
"""FS116-O1: works citing a paper, from Semantic Scholar and OpenAlex, compared by DOI/arXiv id. Usage: fs116_o1_cites.py <arXiv id or DOI>.
Control: --selftest asks for citations of Voronov 2023 (arXiv:2304.10163), which FS-106's gate found cited (>= 1 expected)."""
import json, subprocess, sys, urllib.parse
def get(url):
    r = subprocess.run(["curl", "-s", "-m", "60", "-A", "fs116-o1", url], capture_output=True, text=True)
    try: return json.loads(r.stdout)
    except ValueError: return {"_error": r.stdout[:200]}
def s2(pid):
    d = get(f"https://api.semanticscholar.org/graph/v1/paper/{pid}/citations?fields=title,year,externalIds&limit=100")
    if "_error" in d or "data" not in d: return None, d
    out = {}
    for c in d["data"]:
        p = c.get("citingPaper", {}); e = p.get("externalIds") or {}
        key = (e.get("ArXiv") or e.get("DOI") or p.get("title", "")).lower()
        out[key] = f'{p.get("year")} {p.get("title")}'
    return out, d
def oa(pid):
    doi = pid if pid.startswith("10.") else "10.48550/arXiv." + pid.split(":")[-1]
    w = get("https://api.openalex.org/works/doi:" + doi)
    if "_error" in w or "id" not in w: return None, w
    d = get("https://api.openalex.org/works?filter=cites:" + w["id"].split("/")[-1] + "&per-page=100")
    out = {}
    for p in d.get("results", []):
        key = ((p.get("doi") or "").replace("https://doi.org/", "").replace("10.48550/arxiv.", "") or p.get("title", "")).lower()
        out[key] = f'{p.get("publication_year")} {p.get("title")}'
    return out, d
def run(pid):
    a, _ = s2(pid); b, _ = oa(pid)
    print(f"== {pid}: SemanticScholar {'ERROR' if a is None else len(a)}; OpenAlex {'ERROR' if b is None else len(b)}")
    for k, v in sorted((a or {}).items()): print("   S2", "(both)" if b and k in b else "      ", v[:120])
    for k, v in sorted((b or {}).items()):
        if not a or k not in a: print("   OA        ", v[:120])
    return a, b
if __name__ == "__main__":
    if sys.argv[1:] == ["--selftest"]:
        a, b = run("arXiv:2304.10163"); ok = bool(a) or bool(b)
        print("SELFTEST", "PASS" if ok else "FAIL"); sys.exit(0 if ok else 1)
    for pid in sys.argv[1:]: run(pid)
