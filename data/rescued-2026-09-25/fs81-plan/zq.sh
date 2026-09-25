q() { local tag="$1"; shift; curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode "search_string=$1" --data-urlencode 'results_per_page=100' -o "zb/$tag.json" -w "%{http_code} "; python3 - "$tag" "$1" <<'PY'
import json,sys
tag,qs=sys.argv[1],sys.argv[2]
try: j=json.load(open(f'zb/{tag}.json'))
except Exception as e: print(tag,'PARSE FAIL',e); sys.exit()
res=j.get('result',[]) or []; tot=j.get('status',{}).get('nr_total_results', len(res))
print(f'## {tag}: {qs!r} -> {tot} hits')
for r in res[:60]:
    t=r.get('title',{}).get('title','') if isinstance(r.get('title'),dict) else r.get('title')
    au='; '.join(a.get('name','') for a in r.get('contributors',{}).get('authors',[]))
    ecs=r.get('editorial_contributions',[]) or []
    kind=','.join(sorted(set(ec.get('contribution_type','') for ec in ecs))) or 'none'
    print(f" - {r.get('identifier','')} | {r.get('year','')} | {au[:60]} | {t[:100]} [{kind}]")
PY
}
