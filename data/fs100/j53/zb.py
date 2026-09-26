import urllib.error
import json,sys,urllib.request,urllib.parse
q=sys.argv[1]; n=int(sys.argv[2]) if len(sys.argv)>2 else 8; L=int(sys.argv[3]) if len(sys.argv)>3 else 300
url="https://api.zbmath.org/v1/document/_search?"+urllib.parse.urlencode({"search_string":q,"results_per_page":n})
try:
    d=json.load(urllib.request.urlopen(url,timeout=40))
except urllib.error.HTTPError as e:
    print("QUERY",q,"hits 0 (HTTP",e.code,")"); sys.exit(0)
res=d.get("result",[]); print("QUERY",q,"hits",d.get("status",{}).get("nr_total_results"))
for r in res:
    t=(r.get("title") or {}).get("title","")
    a="; ".join(x.get("name","") for x in (r.get("contributors") or {}).get("authors",[]))
    y=r.get("year"); src=(r.get("source") or {}).get("series",[{}])
    so=(src[0].get("title") if src else "") if isinstance(src,list) else ""
    ec=r.get("editorial_contributions") or []
    txt=ec[0].get("text","") if ec else ""; kind=ec[0].get("contribution_type","") if ec else ""
    print(f"- {r.get('identifier')} | {a} | {y} | {t} | {so} | [{kind}] {txt[:L]}")
