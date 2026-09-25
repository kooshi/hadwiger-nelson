import json,sys,subprocess,urllib.parse
def q(s, n=40, full=False):
    url="https://api.zbmath.org/v1/document/_search?"+urllib.parse.urlencode({"search_string":s,"results_per_page":n})
    d=json.loads(subprocess.run(["curl","-s",url],capture_output=True,text=True).stdout)
    res=d.get('result') or []
    print('HITS',d.get('status',{}).get('nr_total_results'),'|',s)
    for r in res:
        t=r.get('title',{}).get('title','')
        au=', '.join(a.get('name','') for a in r.get('contributors',{}).get('authors',[]))[:60]
        print('-',r.get('year',''),au,'::',t[:130])
        if full:
            for ec in r.get('editorial_contributions',[]) or []:
                txt=ec.get('text','')
                print('   [%s] %s'%(ec.get('contribution_type'), txt[:1500]))
for s in sys.argv[1:]:
    full = s.startswith('!')
    q(s.lstrip('!'), full=full)
