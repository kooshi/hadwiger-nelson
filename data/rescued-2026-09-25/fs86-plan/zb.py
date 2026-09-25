import json, subprocess, sys, urllib.parse
Q=[l.strip() for l in open(sys.argv[1]) if l.strip()]
for q in Q:
    try:
        out=subprocess.run(['curl','-sG','https://api.zbmath.org/v1/document/_search','--data-urlencode','search_string='+q,'--data-urlencode','results_per_page=100'],capture_output=True,text=True,timeout=60).stdout
        js=json.loads(out); res=js.get('result',[]) or []; tot=js.get('status',{}).get('nr_total_results',len(res))
    except Exception as ex:
        print('Q',q,'ERROR',ex); continue
    print('Q',q,'| hits',tot)
    for r in res[:12]:
        t=(r.get('title') or {}).get('title','')
        y=r.get('year'); src=(r.get('source') or {}).get('source') if isinstance(r.get('source'),dict) else ''
        au='; '.join(a.get('name','') for a in (r.get('contributors') or {}).get('authors',[])[:3])
        ec=r.get('editorial_contributions') or []
        kind=','.join(sorted(set(e.get('contribution_type','?') for e in ec))) if ec else 'none'
        print('   -',y,'|',au,'|',t[:110],'|',(src or '')[:50],'|',kind)
