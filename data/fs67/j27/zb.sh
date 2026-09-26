#!/bin/bash
# usage: zb.sh "<zbMATH search string>"  -> prints one line per hit: year | authors | title | first 400 chars of review
q="$1"
curl -s -G "https://api.zbmath.org/v1/document/_search" --data-urlencode "search_string=$q" --data-urlencode "results_per_page=100" -o /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/zb.json
python3 - "$q" <<'PY'
import json,sys
d=json.load(open('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/zb.json'))
res=d.get('result',[]) or []
print(f"### {sys.argv[1]} -> {len(res)} hits")
for r in res:
    y=r.get('year'); t=(r.get('title') or {}).get('title','')
    au='; '.join(a.get('name','') for a in (r.get('contributors') or {}).get('authors',[]))
    rev=''
    for ec in r.get('editorial_contributions') or []:
        rev=(ec.get('text') or '')[:400].replace('\n',' '); kind=ec.get('contribution_type'); rev=f"[{kind}] "+rev; break
    print(f"- {y} | {au} | {t} | {rev}")
PY
