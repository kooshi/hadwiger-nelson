#!/usr/bin/env bash
# J40: arXiv API query (https). usage: arx.sh '<search_query>' ...
for q in "$@"; do echo "== $q"; curl -s -L -m 60 "https://export.arxiv.org/api/query?search_query=$q&max_results=40" | python3 -c "
import sys,re
t=sys.stdin.read(); m=re.search(r'<opensearch:totalResults[^>]*>(\d+)',t); print('  total', m.group(1) if m else 'UNANSWERED')
for e in re.findall(r'<entry>(.*?)</entry>',t,re.S):
  ti=re.search(r'<title>(.*?)</title>',e,re.S).group(1).split(); i=re.search(r'<id>(.*?)</id>',e).group(1); p=re.search(r'<published>(\d{4})',e).group(1)
  print(' ',p,i.split('/abs/')[-1],' '.join(ti)[:105])"; sleep 3; done
