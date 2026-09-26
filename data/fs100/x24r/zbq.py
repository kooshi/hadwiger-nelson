#!/usr/bin/env python3
"""X24R helper: run one zbMATH Open API query, save the JSON under zb/, print one line per hit.
Usage: zbq.py <tag> '<search_string>' [keyword ...]  -- keywords mark hits whose title/review contains them."""
import json, sys, subprocess, re, os, hashlib
tag, q = sys.argv[1], sys.argv[2]
kws = [k.lower() for k in sys.argv[3:]]
out = os.path.join(os.path.dirname(__file__), 'zb', tag + '.json')
allres = []
page = 0
while True:
    r = subprocess.run(['curl', '-sG', 'https://api.zbmath.org/v1/document/_search',
                        '--data-urlencode', 'search_string=' + q,
                        '--data-urlencode', 'results_per_page=100',
                        '--data-urlencode', f'page={page}'], capture_output=True, text=True, check=True)
    d = json.loads(r.stdout)
    res = d.get('result') or []
    allres += res
    tot = d["status"].get("nr_total_results") or 0
    if len(allres) >= tot or not res or page > 5:
        break
    page += 1
json.dump({'query': q, 'total': tot, 'result': allres}, open(out, 'w'))
print(f'## {tag}: {q!r}  total={tot} fetched={len(allres)}')
for x in allres:
    t = ' '.join(x.get('title', {}).get('title', '') .split()) if isinstance(x.get('title'), dict) else str(x.get('title'))
    yr = x.get('year')
    src = x.get('source', {}).get('series', [{}]) if isinstance(x.get('source'), dict) else ''
    so = ''
    try:
        so = x['source']['source'][0]['source']
    except Exception:
        pass
    auth = '; '.join(a['name'] for a in x.get('contributors', {}).get('authors', []))
    txt = ' '.join(e.get('text') or '' for e in x.get('editorial_contributions', []))
    kinds = ','.join(e.get('contribution_type', '?') for e in x.get('editorial_contributions', []))
    hit = [k for k in kws if k in (t + ' ' + txt).lower()]
    mark = ('*' + '/'.join(hit)) if hit else ''
    print(f"{x.get('identifier')} | {yr} | {auth[:60]} | {t[:120]} | {so[:60]} | {kinds} {mark}")
