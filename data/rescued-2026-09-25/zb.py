import json,sys,time,urllib.parse,urllib.request
qs=sys.argv[1:]
for q in qs:
    url="https://api.zbmath.org/v1/document/_search?"+urllib.parse.urlencode({"search_string":q,"results_per_page":20})
    for attempt in range(3):
        try:
            raw=urllib.request.urlopen(url,timeout=30).read()
            d=json.loads(raw); break
        except Exception as e:
            d=None; time.sleep(3)
    if d is None: print("Q:",q,"-> ERROR"); continue
    r=d.get('result') or []
    st=d.get('status') or {}
    n=st.get('nr_total_results') if isinstance(st,dict) else None
    print("Q:",q,"->",n if n is not None else len(r),"hits")
    for x in r[:10]:
        t=x.get('title'); t=t.get('title') if isinstance(t,dict) else t
        print("   -",x.get('identifier'),"|",(t or '')[:120],"|",x.get('year'))
    time.sleep(2)
