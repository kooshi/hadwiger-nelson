#!/bin/bash
# FS137-E1 §PA: zbMATH Open API, abstracts in two disciplines' words. Output: zb.out (query, hit count, first titles).
q() { r=$(curl -sG --max-time 40 "https://api.zbmath.org/v1/document/_search" --data-urlencode "search_string=$1" --data-urlencode "results_per_page=100"); 
  n=$(printf '%s' "$r" | python3 -c "import sys,json
try:
    d=json.load(sys.stdin); rs=d.get('result') or []
    print(len(rs)); [print('    ', (x.get('zbmath_url') or x.get('id')), '|', (x.get('title') or {}).get('title','')[:110], '|', x.get('year')) for x in rs[:8]]
except Exception as e: print('ERR', e)"); echo "QUERY: $1"; echo "  hits: $n"; }
q 'ab:"chromatic number of the plane" & ab:vert* & (ab:angle* | ab:"angle sum")'
q '(ab:"map-type" | ab:"map type" | ab:tiling*) & ab:colo* & (ab:"unit distance" | ab:"distance 1" | ab:"monochrom*") & ab:vert* & ab:circle*'
q 'ab:Reuleaux & ab:colo* & ab:plane'
q '(ab:"list colo*" | ab:choosab*) & ab:circle & (ab:"unit distance" | ab:"distance graph*")'
q '(ab:"list colo*" | ab:choosab*) & (ab:"blow-up*" | ab:"lexicographic product") & ab:cycle*'
q 'ab:"chromatic number of the plane" & (ab:"six colo*" | ab:"6-colo*" | ab:"seven colo*" | ab:"7-colo*") & (ab:local* | ab:"vertex figure*" | ab:discharging | ab:tiling*)'
q 'ab:discharging & (ab:"unit distance" | ab:"chromatic number of the plane")'
q 'au:"Townsend, Stephen" & py:1979-2006'
q 'au:"Coulson, D*" & (ti:tiling* | ti:chromatic*)'
