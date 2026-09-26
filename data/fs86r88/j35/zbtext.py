#!/usr/bin/env python3
"""Print the zbMATH review/summary text, source and links for given Zbl numbers or arXiv ids (an:...)."""
import json, sys, urllib.parse, urllib.request, re, html
for an in sys.argv[1:]:
    url = 'https://api.zbmath.org/v1/document/_search?' + urllib.parse.urlencode({'search_string': f'an:{an}', 'results_per_page': 5})
    try:
        d = json.load(urllib.request.urlopen(url, timeout=60))
    except Exception as e:
        print(an, 'ERROR', e); continue
    for it in d.get('result', [])[:1]:
        ed = it.get('editorial_contributions') or []
        src = it.get('source') or {}
        links = [l.get('identifier') for l in (it.get('links') or [])][:4]
        print('==', an, '|', (it.get('title') or {}).get('title'), '|', it.get('year'), '|', json.dumps(src)[:200], '|', links)
        for e in ed[:1]:
            t = re.sub(r'<[^>]+>', '', html.unescape(e.get('text', '')))
            print('  [', e.get('contribution_type'), ']', t[:1500])
