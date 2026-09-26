#!/usr/bin/env python3
"""J35 prior-art gate: query zbMATH Open API (default) or OpenAlex (-o) and print hit count + up to N compact rows.
Usage: python3 zb.py [-o] [-n N] 'query1' 'query2' ...   (appends everything to data/fs86r88/j35/queries.log too)
A failure prints ERROR loudly; HTTP 404 from zbMATH is its empty-result response (J28's control), printed as '0 hits (404)'."""
import json, sys, time, urllib.parse, urllib.request, urllib.error, os
args = sys.argv[1:]; oa = False; N = 8
while args and args[0].startswith('-'):
    f = args.pop(0)
    if f == '-o': oa = True
    elif f == '-n': N = int(args.pop(0))
log = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'queries.log'), 'a')
def out(s): print(s); log.write(s + '\n')
for q in args:
    if oa:
        url = 'https://api.openalex.org/works?' + urllib.parse.urlencode({'search': q, 'per-page': 25, 'mailto': 'x@example.org'})
    else:
        url = 'https://api.zbmath.org/v1/document/_search?' + urllib.parse.urlencode({'search_string': q, 'results_per_page': 100})
    d = None
    for attempt in range(3):
        try:
            with urllib.request.urlopen(url, timeout=60) as r: d = json.load(r); break
        except urllib.error.HTTPError as e:
            if e.code == 404 and not oa: d = {'result': [], 'status': {'nr_total_results': 0}}; break
            if e.code in (502, 503, 429): time.sleep(8); continue
            out(f'[{time.strftime("%H:%M")}] {"OA" if oa else "ZB"} {q!r}: ERROR HTTP {e.code}'); break
        except Exception as e:
            out(f'[{time.strftime("%H:%M")}] {"OA" if oa else "ZB"} {q!r}: ERROR {e}'); time.sleep(5)
    if d is None: out(f'  UNANSWERED {q!r}'); continue
    if oa:
        res = d.get('results', []); tot = d.get('meta', {}).get('count', len(res))
        out(f'[{time.strftime("%H:%M")}] OA {q!r}: {tot} hits')
        for it in res[:N]:
            au = ', '.join(a['author'].get('display_name', '?') for a in (it.get('authorships') or [])[:3])
            src = ((it.get('primary_location') or {}).get('source') or {}) or {}
            out(f'   {it.get("publication_year")} | {au} | {(it.get("title") or "?")[:110]} | {src.get("display_name","?")[:40]} | {it.get("doi") or it.get("id")}')
    else:
        res = d.get('result', []) or []; tot = d.get('status', {}).get('nr_total_results', len(res))
        out(f'[{time.strftime("%H:%M")}] ZB {q!r}: {tot} hits')
        for it in res[:N]:
            t = (it.get('title') or {}).get('title', '?'); y = it.get('year', '?')
            au = ', '.join(a.get('name', '?') for a in ((it.get('contributors') or {}).get('authors') or [])[:3])
            src = '; '.join((s.get('series') or [{}])[0].get('short_title', '') or s.get('source','') for s in (it.get('source') or [])[:1]) if isinstance(it.get('source'), list) else ''
            ed = it.get('editorial_contributions') or []; kind = ed[0].get('contribution_type', '-') if ed else '-'
            out(f'   {y} | {au} | {t[:110]} | {it.get("identifier","?")} | {kind}')
log.close()
