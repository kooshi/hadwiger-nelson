#!/bin/bash
# FS136-E1 §PA: zbMATH Open API queries, each with its hit count and titles; output to zb.out
Q='https://api.zbmath.org/v1/document/_search'
while IFS= read -r s; do
  [ -z "$s" ] && continue
  curl -s -m 30 -G "$Q" --data-urlencode "search_string=$s" --data-urlencode "results_per_page=100" | python3 -c "
import sys,json
s=sys.argv[1]
try:
    d=json.load(sys.stdin); r=d.get('result') or []
except Exception as ex:
    print('QUERY:',s,'-> ERROR',ex); sys.exit(0)
print('QUERY:',s,'->',len(r))
for x in r[:60]:
    print('   ',x.get('year'),'|',((x.get('title') or {}).get('title') or '')[:120],'|',','.join(a.get('name','') for a in (x.get('contributors') or {}).get('authors',[]))[:70],'| Zbl',x.get('identifier'))
" "$s"
done <<'QQ'
ab:"chromatic number of the plane" & ab:disk
ab:"unit distance" & ab:colo* & ab:strip
ab:"six colo*" & ab:plane & ab:"distance"
ab:"chromatic number" & ab:plane & (ab:tiling | ab:tilings | ab:map | ab:maps) & ab:"unit distance"
ab:colo* & ab:plane & ab:"monochrom*" & ab:"unit" & (ab:regions | ab:region | ab:tiles | ab:Jordan)
ti:"chromatic number" & (ti:disk | ti:disks | ti:strip | ti:strips | ti:"bounded")
ab:"distance 1" & ab:colo* & ab:plane & (ab:trichromatic | ab:"three colo*" | ab:tricolo*)
ab:"unit circle" & ab:colo* & ab:plane & ab:"chromatic number" & (ab:boundary | ab:arc | ab:arcs)
au:"Kruskal, Clyde" & ti:chromatic
au:"Bauslaugh, Bruce"
au:"Oostema, Peter"
(ab:"realiz* all distances" | ab:"realizes all distances" | ab:"distances realized") & ab:plane & (ab:cover* | ab:partition*)
QQ
