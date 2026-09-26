#!/usr/bin/env python3
"""J28 prior-art gate: zbMATH Open API discovery queries (WORKFLOW 3.2 item 8).
Prints, per query, the hit count and up to N titles with year, Zbl number and whether the text is a review or an author summary.
Usage: python3 tools/crunch_j28_zbmath.py > data/fs86r88/j28/zbmath.txt"""
import json, sys, urllib.parse, urllib.request
QUERIES = [
 'ab:"invariant" & ab:"proper colorings" & ab:"periodic"',
 'ab:"invariant random" & ab:"coloring"',
 'ab:"forced periodicity"',
 'ab:"multiplicatively invariant" & ab:"subshift"',
 'ab:"times 2 times 3" | ab:"x2 x3" & ab:"subshift"',
 'ab:"unit distance graph" & ab:"triangle-free" & ab:"chromatic"',
 'ab:"generalized Paley" & ab:"independent sets" & ab:"subspace"',
 'ab:"Erdos-Ko-Rado" & ab:"Cayley graph" & ab:"finite field"',
 'ab:"measurable chromatic number" & ab:"plane"',
 'ab:"independence density" & ab:"Cayley graph"',
 'ab:"unitary Cayley graph" & ab:"chromatic number"',
 'ab:"chromatic number" & ab:"unit distance" & ab:"number field"',
 'ab:"colorings" & ab:"p-adic" & ab:"rigid"',
 'ab:"frozen" & ab:"colorings" & ab:"shift"',
 'ab:"Furstenberg correspondence" & ab:"independent set"',
 'ab:"Rudolph" & ab:"Johnson" & ab:"invariant measures" & ab:"solenoid"',
]
N = 6
for q in QUERIES:
    url = 'https://api.zbmath.org/v1/document/_search?' + urllib.parse.urlencode({'search_string': q, 'results_per_page': 100})
    try:
        with urllib.request.urlopen(url, timeout=40) as r:
            d = json.load(r)
    except Exception as e:  # a failure is printed loudly, never read as zero hits
        print(f'QUERY {q!r}: ERROR {e}'); continue
    res = d.get('result', []) or []
    tot = d.get('status', {}).get('nr_total_results', len(res))
    print(f'QUERY {q!r}: {tot} hits')
    for it in res[:N]:
        t = (it.get('title') or {}).get('title', '?')
        y = it.get('year', '?')
        zbl = (it.get('identifier') or '?')
        au = ', '.join(a.get('name', '?') for a in ((it.get('contributors') or {}).get('authors') or [])[:3])
        ed = it.get('editorial_contributions') or []
        kind = ed[0].get('contribution_type', '?') if ed else '-'
        print(f'   {y} | {au} | {t[:120]} | {zbl} | {kind}')
