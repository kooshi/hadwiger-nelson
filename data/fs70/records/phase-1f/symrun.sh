#!/bin/bash
# arm 2b: the k=4 control formula plus the lex-leader break, one kissat run at 1,800 s.
B=build/fs70/1f/base_body.cnf
K=build/fs70/1f/break.cnf
NV=$(python3 -c "import json;m=json.load(open('build/fs70/1f/break-meta.json'));print(m['variables_total'])")
NC=$(python3 -c "import json;b=json.load(open('build/fs70/1f/base-meta.json'));m=json.load(open('build/fs70/1f/break-meta.json'));print(b['body_clauses']+m['break_clauses'])")
echo "header: p cnf $NV $NC"
{ printf 'p cnf %s %s\n' "$NV" "$NC"; cat $B $K; } | /usr/bin/time -f 'TIMEV wall=%e s maxRSS=%M kB exit=%x' kissat -q -n --time=1800
echo "kissat exit=$?"
