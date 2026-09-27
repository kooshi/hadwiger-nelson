import json,sys
d=json.load(open(sys.argv[1]))
res=d.get('result',[]) or []
st=d.get('status',{})
print('Q:',sys.argv[2],'| total',st.get('nr_total_results',len(res)))
for r in res[:int(sys.argv[3]) if len(sys.argv)>3 else 30]:
    t=(r.get('title') or {}).get('title','')
    y=r.get('year'); an=r.get('identifier')
    au='; '.join(a.get('name','') for a in (r.get('contributors') or {}).get('authors',[]))
    src=r.get('source')
    src=json.dumps(src)[:0]
    print(' ',an,y,au[:50],'|',t[:95])
