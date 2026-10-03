#!/usr/bin/env python3
"""FS116-Y3 readback (standing rule 3): every blockquote of the brief occurs verbatim (whitespace collapsed) in its named source, and the
brief's unquoted attributions are present at the sources it names.

  python3 tools/fs116_y3_quotes.py            prints one line per item and a last line 'quotations: n found k; attributions: m present j'
  --alter                                     changes one word of the first quotation (a plant: it must be NOT FOUND)
  --source PATH                               checks every quotation against PATH instead (a plant: the wrong file finds none)
"""
import os
import re
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')


def norm(s):
    return re.sub(r'\s+', ' ', s).strip()


def read(rel):
    with open(os.path.join(ROOT, rel), encoding='utf-8') as f:
        return f.read()


brief = read('data/fs116/briefs/FS116-Y3-hub.md')
quotes, cur, src = [], [], None
for line in brief.splitlines() + ['']:
    if line.startswith('>'):
        body = line[1:].strip()
        if body.startswith('— source:'):
            src = body.split('source:')[1].strip().split(' §')[0]
        else:
            cur.append(body)
    elif cur:
        quotes.append((norm(' '.join(cur)).lstrip('- ').strip(), src))
        cur, src = [], None

if '--alter' in sys.argv:
    quotes[0] = (quotes[0][0].replace('derived obstruction', 'proved obstruction'), quotes[0][1])
override = None
if '--source' in sys.argv:
    override = sys.argv[sys.argv.index('--source') + 1]

# The brief's unquoted attributions: (phrase as the source has it, source file), each a pointer the brief's prose relies on.
ATTR = [
    ('a **hub** of `p` is a change point `y` of `p`\'s ring whose four germs', 'plans/FS116-N2-proof.md'),
    ('no held fragment has a hub', 'plans/FS116-N2-proof.md'),
    ('**FS116-N2-STAR** —', 'plans/FS116-N2-proof.md'),
    ('**FS116-N2-RECIP** —', 'plans/FS116-N2-proof.md'),
    ('**FS116-N2-ANTI** —', 'plans/FS116-N2-proof.md'),
    ('**FS116-N2-HEX6** —', 'plans/FS116-N2-proof.md'),
    ('**FS116-N2-HEX3** —', 'plans/FS116-N2-proof.md'),
    ('## 9. Controls, killing tests and shared constraints', 'data/fs116/claims.md'),
    ('The ban on finite-witness search runs to 2026-10-01', 'data/fs116/briefs/FS116-Y3-hub.md'),
]

nfound = 0
for q, s in quotes:
    s = override or s
    ok = q in norm(read(s))
    nfound += ok
    print(f'{"FOUND" if ok else "NOT FOUND"}  [{s}]  {q[:90]}...')
npres = 0
for phrase, s in ATTR:
    ok = norm(phrase) in norm(read(s))
    npres += ok
    print(f'{"PRESENT" if ok else "MISSING"}  [{s}]  {phrase}')
print(f'quotations: {len(quotes)} found {nfound}; attributions: {len(ATTR)} present {npres}')
