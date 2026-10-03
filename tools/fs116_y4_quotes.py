#!/usr/bin/env python3
"""FS116-Y4 readback (standing rule 3): every blockquote of the brief, and its one inline quotation, occurs verbatim (whitespace collapsed) in its
named source, and the brief's unquoted attributions are present at the sources it names.

  python3 tools/fs116_y4_quotes.py            one line per item, last line 'quotations: n found k; attributions: m present j'
  --alter                                     changes one word of the first quotation (a plant: it must be NOT FOUND)
  --source PATH                               checks every quotation against PATH instead (a plant: the wrong file finds none)
"""
import os
import re
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
BRIEF = 'data/fs116/briefs/FS116-Y4-hex3.md'


def norm(s):
    return re.sub(r'\s+', ' ', s).strip()


def read(rel):
    with open(os.path.join(ROOT, rel), encoding='utf-8') as f:
        return f.read()


brief = read(BRIEF)
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

# the one inline quotation (the brief gives it in double quotes and names "The list's § 9" as its home)
INLINE = '"No enumeration of maps, colourings, tile graphs or dual graphs, by any program."'
assert INLINE in norm(brief), 'the inline quotation is not in the brief as transcribed here'
quotes.append((INLINE.strip('"'), 'data/fs116/claims.md'))

if '--alter' in sys.argv:
    quotes[0] = (quotes[0][0].replace('closed disc of radius above 2', 'closed disc of radius at least 2'), quotes[0][1])
override = sys.argv[sys.argv.index('--source') + 1] if '--source' in sys.argv else None

# The brief's unquoted attributions: (phrase as the source has it, source file), each a pointer the brief's prose relies on.
ATTR = [
    # "derived, at one mind, that on a disc of radius sqrt3 the vertex's star must be FS116-N2-HEX3's": STARFORCE's theorem line says one mind
    ('**FS116-Y3-STARFORCE** — on `B̄(p, √3)` the star is exactly FS116-N2-HEX3\'s', 'plans/FS116-Y3-construction.md'),
    ('[derived], one mind, § 4.2 (sharpens TIGHTLENS', 'plans/FS116-Y3-construction.md'),
    # "a blind verifier is checking it now": FS116-V5's brief exists and names STARFORCE
    ('FS116-Y3-STARFORCE', 'data/fs116/briefs/FS116-V5-verify.md'),
    # "the close inventory's item 88"
    ('| 88 | stub to mint or re-aim | The HEX3-star vertex beyond radius 2', 'plans/FS116-close-inventory.md'),
    # "the list's §§ 13 and 14 are the form"
    ('## 13. Added at round 4, the semi-hub rule', 'data/fs116/claims.md'),
    ('## 14. Added at round 4, the setting of § 12\'s last three statements', 'data/fs116/claims.md'),
    # the brief's reading of RECIP and HEX6 as N2's lemmas
    ('**FS116-N2-RECIP** —', 'plans/FS116-N2-proof.md'),
    ('**FS116-N2-HEX6** —', 'plans/FS116-N2-proof.md'),
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
