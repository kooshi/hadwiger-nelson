#!/usr/bin/env python3
"""FS116-N3 readback: every blockquote of the brief occurs verbatim (whitespace collapsed) in its named source.
--count prints 'FOUND k of n'; --alter changes one word of the first quotation (a plant that must not be found)."""
import re, sys, os
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
n = lambda s: re.sub(r'\s+', ' ', s).strip()
brief = open(os.path.join(ROOT, 'data/fs116/briefs/FS116-N3-semihub.md')).read()
quotes, cur, src = [], [], None
for line in brief.splitlines() + ['']:
    if line.startswith('>'):
        body = line[1:].strip()
        if body.startswith('— source:'):
            src = body.split('source:')[1].strip().split(' §')[0]
        else:
            cur.append(body)
    elif cur:
        quotes.append((n(' '.join(cur)).lstrip('- ').strip(), src)); cur, src = [], None
if '--alter' in sys.argv:
    quotes[0] = (quotes[0][0].replace('finite rule', 'finite law'), quotes[0][1])
found = sum(q in n(open(os.path.join(ROOT, s)).read()) for q, s in quotes)
print(f'FOUND {found} of {len(quotes)}')
