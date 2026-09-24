#!/bin/bash
# usage: zq.sh 'query'   (zbMATH Open API, discovery)
curl -s -G --max-time 40 "https://api.zbmath.org/v1/document/_search" --data-urlencode "search_string=$1" --data-urlencode "results_per_page=50" -o /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-comp-debruijn/zq.json
python3 - "$1" <<'PY'
import json,sys
try:
    d=json.load(open('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-comp-debruijn/zq.json'))
except Exception as e:
    print('##', sys.argv[1], '-> (no JSON: %s)'%e); sys.exit()
res=d.get('result',[]) or []
print('##', sys.argv[1], '->', d.get('status',{}).get('nr_total_results', len(res)))
for r in res[:50]:
    t=r.get('title',{}).get('title','') if isinstance(r.get('title'),dict) else r.get('title')
    au=[a.get('name') for a in (r.get('contributors') or {}).get('authors',[])][:3]
    print(' -', r.get('year'), '|', '; '.join(a for a in au if a), '|', (t or '')[:120], '| zbl', r.get('identifier'))
PY
