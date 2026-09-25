import json,sys,subprocess,urllib.parse
def q(s,n=8):
    out=subprocess.run(['curl','-sG','https://api.zbmath.org/v1/document/_search','--data-urlencode','search_string='+s,'--data-urlencode','results_per_page=100'],capture_output=True,text=True,timeout=60).stdout
    try: d=json.loads(out)
    except Exception as e: print('ERR',s,out[:200]); return
    tot=d.get('status',{}).get('nr_total_results')
    res=d.get('result',[]) or []
    print(f'## {s}  -> {tot}')
    for r in res[:n]:
        t=r.get('title',{}); t=t.get('title') if isinstance(t,dict) else t
        yr=r.get('year'); 
        au='; '.join(a.get('name','') for a in (r.get('contributors',{}) or {}).get('authors',[])[:3])
        ec=r.get('editorial_contributions') or []
        kind=','.join(sorted({e.get('contribution_type','?') for e in ec})) if ec else 'none'
        src=(r.get('source') or {}).get('series') or ''
        print(f'  - {yr} | {au} | {t} | [{kind}] | zbl {r.get("identifier")}')
    json.dump(d,open('last.json','w'))
for s in sys.argv[1:]: q(s)
