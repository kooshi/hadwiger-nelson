import json,sys,glob,re,html
want=set(sys.argv[1:])
seen=set()
for fn in glob.glob('q-*.json'):
    try: d=json.load(open(fn))
    except Exception: continue
    for r in d.get('result',[]) or []:
        idn=str(r.get('identifier') or r.get('id'))
        if idn in want and idn not in seen:
            seen.add(idn)
            print('=====',idn,(r.get('title') or {}).get('title',''),r.get('year'))
            for ec in r.get('editorial_contributions') or []:
                t=ec.get('text','') or ''
                t=re.sub(r'<[^>]+>','',html.unescape(t))
                rv=ec.get('reviewer') or {}
                print(f"[{ec.get('contribution_type')}] reviewer={rv.get('name','') if isinstance(rv,dict) else rv}\n{t[:2200]}\n")
