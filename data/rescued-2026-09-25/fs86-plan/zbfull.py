import json, subprocess, sys
for q in sys.argv[1:]:
    out=subprocess.run(['curl','-sG','https://api.zbmath.org/v1/document/_search','--data-urlencode','search_string='+q,'--data-urlencode','results_per_page=5'],capture_output=True,text=True,timeout=60).stdout
    js=json.loads(out)
    for r in js.get('result',[]) or []:
        t=(r.get('title') or {}).get('title','')
        print('###',r.get('year'),t,'| zbl',r.get('identifier'),'| id',r.get('id'))
        for e in r.get('editorial_contributions') or []:
            txt=e.get('text') or ''
            print('   [%s by %s]'%(e.get('contribution_type'),(e.get('reviewer') or {}).get('name','')), txt[:1400].replace('\n',' '))
        links=r.get('links') or []
        print('   links:',[l.get('url') or l.get('identifier') for l in links][:4])
