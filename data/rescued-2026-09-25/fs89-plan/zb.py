import sys, json, subprocess, urllib.parse
q = sys.argv[1]; n = int(sys.argv[2]) if len(sys.argv) > 2 else 15
out = subprocess.run(['curl','-sG','https://api.zbmath.org/v1/document/_search','--data-urlencode','search_string='+q,'--data-urlencode','results_per_page=100'],capture_output=True,text=True).stdout
try:
    d = json.loads(out)
except Exception as e:
    print('PARSE FAIL', out[:300]); sys.exit()
res = d.get('result', []) or []
tot = (d.get('status') or {}).get('nr_total_results') or len(res)
print(f'QUERY {q!r}: {tot} hits')
for r in res[:n]:
    t = (r.get('title') or {}).get('title','?')
    y = r.get('year'); an = r.get('identifier')
    auth = '; '.join(a.get('name','') for a in (r.get('contributors') or {}).get('authors',[]))
    src = r.get('source') or {}
    ser = ''
    try: ser = src['series'][0]['short_title'] if src.get('series') else ''
    except Exception: pass
    ec = r.get('editorial_contributions') or []
    kind = ','.join(e.get('contribution_type','?') for e in ec) or 'none'
    txt = ''
    for e in ec:
        tt = e.get('text') or ''
        if tt: txt = tt; break
    print(f' - {an} {y} [{kind}] {auth}: {t} ({ser})')
    if len(sys.argv) > 3: print('     ', txt[:int(sys.argv[3])].replace('\n',' '))
