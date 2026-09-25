#!/usr/bin/env python3
"""J23p prior-art gate helper. Modes:
  zb   <query-file>        zbMATH Open API discovery; retries a 502/timeout twice after 20 s; logs UNANSWERED, never a negative.
  zbrev <Zbl> ...          review/summary text by Zbl number (marks reviewer review vs author summary).
  arx  <query-file>        arXiv API (search_query syntax per line); prints total and titles.
  oa   <query-file>        OpenAlex works search (title_and_abstract.search); prints count and titles.
  oacite <openalex-id>     OpenAlex works citing a work (titles, years).
Every line printed is copied into the record's query tables by hand."""
import json, sys, time, urllib.parse, urllib.request, re
UA = {"User-Agent": "lean-dir-prior-art-gate/1.0 (mailto:contact@example.org)"}
def fetch(url, timeout=60):
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.read()
def zbq(s, n=100):
    url = "https://api.zbmath.org/v1/document/_search?" + urllib.parse.urlencode({"search_string": s, "results_per_page": n})
    last = None
    for attempt in range(3):
        try:
            d = json.loads(fetch(url))
            res = d.get("result", []) or []
            tot = d.get("status", {}).get("nr_total_results", len(res))
            return tot, res
        except urllib.error.HTTPError as e:
            if e.code == 404:
                return 0, []
            last = f"HTTP {e.code}"
        except Exception as e:
            last = repr(e)[:80]
        time.sleep(20)
    return f"UNANSWERED ({last}, 3 attempts)", []
def zbline(it):
    t = (it.get("title") or {}).get("title", "")
    au = "; ".join(a.get("name", "") for a in (it.get("contributors") or {}).get("authors", [])[:3])
    src = ""
    try: src = it["source"]["series"][0]["title"]
    except Exception: pass
    eds = it.get("editorial_contributions") or []
    kind = ",".join(sorted({(e.get("contribution_type") or "?") for e in eds})) or "none"
    return f"  {it.get('identifier')} | {it.get('year')} | {au} | {t[:120]} | {src[:35]} | {kind}"
def main():
    mode = sys.argv[1]
    if mode == "zb":
        for line in open(sys.argv[2]):
            s = line.strip()
            if not s or s.startswith("#"): continue
            tot, res = zbq(s)
            print(f"Q: {s}\n  hits: {tot}")
            for it in res[:15]: print(zbline(it))
            sys.stdout.flush(); time.sleep(1)
    elif mode == "zbrev":
        for an in sys.argv[2:]:
            tot, res = zbq(f"an:{an}", 5)
            if not res: print(f"== {an}: {tot}"); continue
            for it in res:
                eds = it.get("editorial_contributions") or []
                print(zbline(it))
                for e in eds:
                    print(f"   [{e.get('contribution_type')}] {(e.get('text') or '')[:2500]}")
            print()
    elif mode == "arx":
        for line in open(sys.argv[2]):
            s = line.strip()
            if not s or s.startswith("#"): continue
            url = "https://export.arxiv.org/api/query?" + urllib.parse.urlencode({"search_query": s, "max_results": 25})
            try:
                x = fetch(url).decode()
            except Exception as e:
                print(f"Q: {s}\n  UNANSWERED {e!r}"); continue
            tot = re.search(r"<opensearch:totalResults[^>]*>(\d+)<", x)
            print(f"Q: {s}\n  hits: {tot.group(1) if tot else '?'}")
            for ent in x.split("<entry")[1:]:
                i = re.search(r"<id>(.*?)</id>", ent, re.S); t = re.search(r"<title>(.*?)</title>", ent, re.S)
                y = re.search(r"<published>(\d{4})", ent)
                print(f"  {i.group(1).split('/abs/')[-1] if i else '?'} | {y.group(1) if y else '?'} | {' '.join(t.group(1).split())[:130] if t else '?'}")
            time.sleep(3)
    elif mode == "oa":
        for line in open(sys.argv[2]):
            s = line.strip()
            if not s or s.startswith("#"): continue
            url = "https://api.openalex.org/works?" + urllib.parse.urlencode({"filter": f"title_and_abstract.search:{s}", "per-page": 25, "sort": "cited_by_count:desc"})
            try:
                d = json.loads(fetch(url))
            except Exception as e:
                print(f"Q: {s}\n  UNANSWERED {e!r}"); continue
            print(f"Q(OpenAlex t&a): {s}\n  hits: {d['meta']['count']}")
            for w in d["results"]:
                print(f"  {w['id'].split('/')[-1]} | {w.get('publication_year')} | {(w.get('display_name') or '')[:130]} | cites {w.get('cited_by_count')}")
    elif mode == "oacite":
        wid = sys.argv[2]
        url = f"https://api.openalex.org/works?filter=cites:{wid}&per-page=200"
        d = json.loads(fetch(url))
        print(f"citing {wid}: {d['meta']['count']}")
        for w in d["results"]:
            print(f"  {w['id'].split('/')[-1]} | {w.get('publication_year')} | {(w.get('display_name') or '')[:130]}")
main()
