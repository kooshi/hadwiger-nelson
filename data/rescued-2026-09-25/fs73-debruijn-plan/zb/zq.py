#!/usr/bin/env python3
"""zbMATH Open API query helper: prints hit count, then id | year | authors | title | source | review-kind."""
import json, subprocess, sys, urllib.parse, os, hashlib
q = sys.argv[1]; n = int(sys.argv[2]) if len(sys.argv) > 2 else 15
url = 'https://api.zbmath.org/v1/document/_search?' + urllib.parse.urlencode({'search_string': q, 'results_per_page': 100})
out = subprocess.run(['curl', '-s', '--max-time', '60', url], capture_output=True, text=True).stdout
fn = 'q-' + hashlib.sha1(q.encode()).hexdigest()[:10] + '.json'
open(fn, 'w').write(out)
try:
    d = json.loads(out)
except Exception as e:
    print('PARSE-FAIL', q, out[:300]); sys.exit(2)
st = d.get('status', {})
tot = st.get('nr_total_results', st.get('total', '?'))
res = d.get('result', []) or []
print(f'## {q}\n# total={tot} returned={len(res)} file={fn}')
for r in res[:n]:
    yr = r.get('year')
    au = '; '.join(a.get('name','') for a in (r.get('contributors',{}) or {}).get('authors',[])[:4])
    ti = (r.get('title') or {}).get('title','')
    src = ''
    try: src = r['source']['series'][0]['title'] if r.get('source',{}).get('series') else (r.get('source',{}).get('source') or '')
    except Exception: pass
    kinds = sorted({ec.get('contribution_type','') for ec in (r.get('editorial_contributions') or [])})
    print(f"- {r.get('identifier') or r.get('id')} | {yr} | {au} | {ti[:110]} | {str(src)[:40]} | {','.join(kinds)}")
