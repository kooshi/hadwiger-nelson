import json, sys, urllib.parse, urllib.request, urllib.error, time
def q(s, n=100):
    url='https://api.zbmath.org/v1/document/_search?'+urllib.parse.urlencode({'search_string':s,'results_per_page':n})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers={'Accept':'application/json'}), timeout=60) as r:
                d=json.load(r); break
        except urllib.error.HTTPError as e:
            if e.code==404: return 0, []
            err=e; time.sleep(3)
        except Exception as e:
            err=e; time.sleep(3)
    else:
        return None, str(err)
    res=d.get('result',[]) or []
    tot=d.get('status',{}).get('nr_total_results', len(res))
    out=[]
    for it in res:
        t=it.get('title',{}).get('title','') if isinstance(it.get('title'),dict) else it.get('title')
        au='; '.join(a.get('name','') for a in (it.get('contributors',{}).get('authors',[]) or []))
        yr=it.get('year')
        so=json.dumps(it.get('source',''))[:80]
        an=it.get('identifier')
        rev=''
        for ec in it.get('editorial_contributions',[]) or []:
            txt=ec.get('text') or ''
            rev=(ec.get('contribution_type','')+': '+txt[:600])
        out.append((an,yr,au,t,so,rev))
    return tot,out
if __name__=='__main__':
    for line in sys.stdin:
        line=line.strip()
        if not line or line.startswith('#'): continue
        tot,out=q(line)
        print('='*8, line, '->', tot)
        if isinstance(out,str): print('ERR',out); continue
        for o in out[:25]:
            print(' ', o[0], o[1], '|', o[2][:60], '|', (o[3] or '')[:140], '|', o[4][:40])
        time.sleep(1)
