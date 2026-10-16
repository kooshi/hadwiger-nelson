#!/usr/bin/env python3
"""FS131-FIF1: file FS131-IFR2's D-1, D-2, D-3, D-5, FS131-IFR1's D-4 and D-6, and FS131-PAS1 3.4 items 1-3, verbatim.
(Named file-fif1.py, beside FS131-FCS1's file.py, which it must not overwrite.)
Draft texts are sliced from the plan files, never retyped. Every slot must occur exactly once
(whitespace-insensitive) before anything is written. PLANT=<n> alters slot n by one character (must fail).
Run from the worktree root: python3 data/fs131/fcs1/file-fif1.py [--dry]"""
import re, sys, os

DRY = '--dry' in sys.argv
PLANT = int(os.environ.get('PLANT', '0'))
R2 = open('plans/FS131-IFR2-density.md', encoding='utf-8').read()
R1 = open('plans/FS131-IFR1-density.md', encoding='utf-8').read()
PAS = open('plans/FS131-PAS1-prior-art.md', encoding='utf-8').read()

def flat(s): return re.sub(r'\s+', ' ', s).strip()

def draft(src, label, head):
    s = src.index(head)
    i = src.index('\n**%s ' % label, s)
    j = re.compile(r'\n\n(\*\*D-\d+\. |## |### )').search(src, i + 3).start()
    return src[i:j]

def quote(block):
    ls = [re.sub(r'^> ?', '', l) for l in block.split('\n') if l.startswith('>')]
    return flat(' '.join(ls))

def between(p, a, b):
    i = p.index(a) + len(a)
    return p[i:p.index(b, i)]

edits = []  # (id, file, old, new)
def E(i, f, old, new): edits.append((i, f, old, new))

H2 = '### Drafts for the front page'
H1 = '### Drafts for the front page'
b = draft(R2, 'D-1.', H2); p = flat(b)
E('D1', 'CLAUDE.md', between(p, 'Replace "', '" with:'), quote(b))
b1 = between(p, '- "with eighty', ' - "`Outside').strip() if False else None
# bullets of D-1, parsed from the flat draft
bul1 = between(p, 'In the paragraph\'s current words: - ', ' - "`Outside.OAI158')
E('D1b1a', 'CLAUDE.md', between(bul1, '"', '" → "'), between(bul1, '" → "', '", the parenthesis'))
ins = between(bul1, 'too": "', '";')
E('D1b1b', 'CLAUDE.md', "the other seven on E–L too)", "the other seven on E–L too" + ins + ")")
bul2 = '`Outside.OAI158' + between(p, ' - "`Outside.OAI158', ' - "with thirty-four')
E('D1b2', 'CLAUDE.md', between(bul2, '… ', '" → "'), between(bul2, '→ "', '";'))
bul3 = ' - "with thirty-four' + between(p, ' - "with thirty-four', ' - "one record')
E('D1b3a', 'CLAUDE.md', "with thirty-four, twenty-one of which rest on Weil's bound too (",
  between(bul3, '→ "', '", the list'))
alone = between(bul3, "eleven on it alone: ", ";")
E('D1b3b', 'CLAUDE.md', "`Collapse.chromaticNumber_planeOver_eq_plane_of_thick` rests on it alone",
  "`Collapse.chromaticNumber_planeOver_eq_plane_of_thick` rests on it alone; the density form's eleven on it alone: " + alone)
bul4 = ' - "one record' + p[p.index(' - "one record') + len(' - "one record'):]
E('D1b4', 'CLAUDE.md', between(bul4, '- "', '" → "'), between(bul4, '" → "', '".'))

b = draft(R2, 'D-2.', H2); p = flat(b)
new2 = between(p, 'becomes `', '`')
E('D2a', 'CLAUDE.md', new2.replace('rests=168', 'rests=128'), new2)
E('D2b', 'CLAUDE.md', between(p, 'In words: "', '" becomes "'), between(p, '" becomes "', '" (counted'))

b = draft(R2, 'D-3.', H2); p = flat(b)
m = re.search(r'\*\* `(declarations=\d+ refutations-skipped=\d+ sites=\d+)` becomes `(declarations=\d+ refutations-skipped=\d+ sites=\d+)`', p)
E('D3', 'CLAUDE.md', m.group(1), m.group(2))
VERIFY = [('CLAUDE.md', '`vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`')]  # D-3: "the second part stays"

b = draft(R2, 'D-5.', H2)
newlast = quote(b)
assert newlast.startswith('Last filed: **the density form of the collapse**'), newlast[:60]
E('D5', 'CLAUDE.md', 'REGEX5', newlast + '; before it, **five colours by field and by class** (FS131-KCS1, FS131-ICS1),')

b = draft(R1, 'D-4.', H1)
para = quote(b)
anchor4 = "the derivation FS-103's, the kernel's check this landing's;"
assert para.startswith('**the density form of the collapse**'), para[:50]
E('D4', 'plans/KERNEL-HOLDS.md', anchor4, anchor4 + ' ' + para)

b = draft(R1, 'D-6.', H1)
E('D6', 'LEDGER.md', "the whole weight MR's (row 120);", quote(b))

def pas_item(n):
    i = PAS.index('\n%d. ' % n, PAS.index('### 3.4 Drafts'))
    j = PAS.index('\n%d. ' % (n + 1), i) if n < 4 else None
    return flat(PAS[i:j])
q = pas_item(1)
E('PAS1-1', 'README.md', between(q, 'after *"', '"*:'), between(q, 'after *"', '"*:') + ' ' + between(q, '"*: *"', '"*'))
q = pas_item(2)
E('PAS1-2', 'LEDGER.md', between(q, 'after *"', '"*:'), between(q, 'after *"', '"*:') + ' ' + between(q, '"*: *"', '"* (If'))
q = pas_item(3)
txt = q[q.index('*"**A triangle-free') + 2: q.rindex('"*')]
a3 = '- **The smallest RING that admits a 5-chromatic single-distance graph.**'
E('PAS1-3', 'CLOSED-QUESTIONS.md', a3, '- ' + txt + '\n' + a3)

def rx(old):
    return re.compile(r'\s+'.join(re.escape(t) for t in old.split()))
SPECIAL = {'REGEX5': re.compile(r'Last filed: \*\*five colours by field and by class\*\* \(FS131-KCS1,.*?no value of `χ\(ℝ²\)` moved\); before it,', re.S)}
cache = {}
def load(f):
    if f not in cache: cache[f] = open(f, encoding='utf-8').read()
    return cache[f]
plan = []
for n, (i, f, old, new) in enumerate(edits, 1):
    text = load(f)
    if old in SPECIAL:
        ms = list(SPECIAL[old].finditer(text)) if PLANT != n else []
    else:
        o = old
        if PLANT == n: o = o[:-1] + ('X' if o[-1] != 'X' else 'Y')
        ms = list(rx(o).finditer(text))
    print('%-7s %-24s matches=%d  old=%r' % (i, f, len(ms), old[:50]))
    plan.append((i, f, ms, new))
for f, v in VERIFY:
    c = len(list(rx(v).finditer(load(f))))
    print('verify  %-24s matches=%d  %r' % (f, c, v[:50]))
    if c != 1: print('FAIL: verify slot'); sys.exit(1)
bad = [x[0] for x in plan if len(x[2]) != 1]
if bad:
    print('FAIL: slots not found exactly once:', bad); sys.exit(1)
# no two slots in one file overlap
for f in set(x[1] for x in plan):
    sp = sorted((x[2][0].start(), x[2][0].end(), x[0]) for x in plan if x[1] == f)
    for a, b2 in zip(sp, sp[1:]):
        assert a[1] <= b2[0], ('overlap', a, b2)

m5 = [x for x in plan if x[0] == 'D5'][0][2][0]
par = re.search(r'(\(FS131-KCS1,.*?no value of `χ\(ℝ²\)` moved\));', m5.group(0), re.S).group(1)
moved = 'before it **five colours by field and by class** ' + flat(par)
fil = load('plans/FILINGS.md')
anchor = 'before it **three colours on abelian Cayley graphs**'
assert fil.count(anchor) == 1
print('moved entry:', moved[:100], '...', moved[-60:])
if DRY:
    print('dry run: nothing written'); sys.exit(0)

byfile = {}
for i, f, ms, new in plan: byfile.setdefault(f, []).append((ms[0], i, new))
for f, lst in byfile.items():
    text = load(f)
    for m, i, new in sorted(lst, key=lambda t: -t[0].start()):
        text = text[:m.start()] + new + text[m.end():]
    open(f, 'w', encoding='utf-8').write(text)
fil = fil.replace(anchor, moved + '\n\n' + anchor, 1)
open('plans/FILINGS.md', 'w', encoding='utf-8').write(fil)
print('written')
