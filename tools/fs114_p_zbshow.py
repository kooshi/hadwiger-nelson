#!/usr/bin/env python3
"""FS114-P §PA: print each zbMATH API result file's hits: year, authors, title, source, Zbl, and the first 300 characters of the review or
summary, marked by kind (reviewer's review or the author's summary: an author's summary is a claim, never a reading — G50)."""
import json, sys
for f in sys.argv[1:]:
    d = json.load(open(f)); r = d.get('result')
    print('==', f, '|', d.get('status', {}).get('nr_total_results'))
    if not isinstance(r, list): print('   (no result list)', str(d)[:200]); continue
    for x in r:
        t = (x.get('title') or {}).get('title', '?')
        au = '; '.join(a.get('name', '?') for a in ((x.get('contributors') or {}).get('authors') or []))
        yr = x.get('year'); src = ((x.get('source') or {}).get('series') or [{}])
        so = (x.get('source') or {}).get('source', '')
        zbl = x.get('identifier')
        ec = x.get('editorial_contributions') or []
        txt = ''; kind = ''
        if ec:
            kind = ec[0].get('contribution_type', ''); txt = (ec[0].get('text') or '')[:300].replace('\n', ' ')
        print(f'- {yr} | {au} | {t} | {so} | {zbl} | [{kind}] {txt}')
