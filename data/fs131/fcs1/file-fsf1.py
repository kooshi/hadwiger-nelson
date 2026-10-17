#!/usr/bin/env python3
"""FS131-FSF1: file FS131-ISF2's drafts 1-6, 8, 9 and 11 verbatim (the front files).
Draft texts are sliced from plans/FS131-ISF2-seam-fractional.md and plans/FS131-ISF1-seam-fractional.md, never retyped.
Every slot must occur exactly once (whitespace-insensitive unless literal) before anything is written.
PLANT=<n> alters slot n by one character (must fail).
Run from the worktree root: python3 data/fs131/fcs1/file-fsf1.py [--dry]"""
import re, sys, os

DRY = '--dry' in sys.argv
PLANT = int(os.environ.get('PLANT', '0'))
rd = lambda p: open(p, encoding='utf-8').read()
REC = rd('plans/FS131-ISF2-seam-fractional.md')
DR = REC[REC.index('## Drafts for the front page'):]
R1 = rd('plans/FS131-ISF1-seam-fractional.md')

def flat(s): return re.sub(r'\s+', ' ', s).strip()
def draft(n):
    i = DR.index('\n%d. **' % n)
    j = DR.index('\n%d. **' % (n + 1), i)
    return flat(DR[i:j])
def between(p, a, b):
    i = p.index(a) + len(a)
    return p[i:p.index(b, i)]

edits = []   # (id, file, old, new, literal)
def E(i, f, old, new, lit=False): edits.append((i, f, old, new, lit))

# D1
p = draft(1)
m = re.search(r'replace `` (.*?) `` by `` (.*?) ``\.', p)
E('D1', 'CLAUDE.md', m.group(1), m.group(2))
# D2
p = draft(2)
m = re.search(r'replace `([^`]*)` by `([^`]*)`\.', p)
E('D2', 'CLAUDE.md', m.group(1), m.group(2))
# D3
p = draft(3)
old3 = between(p, 'replace `', '` by `Last filed')
new3 = between(p, '` by `Last filed', '` (the rest of the list unchanged)')
new3 = 'Last filed' + new3
assert old3.startswith('Last filed: **rational four-space at four colours**') and old3.endswith('**the ring of unit vectors**')
assert new3.startswith('Last filed: **the fractional chromatic number') and new3.endswith('**the ring of unit vectors**')
sep = '; before it, **the ring of unit vectors**'
moved = 'before it ' + old3[len('Last filed: '):old3.index(sep)]
assert moved.endswith('moved)')
E('D3', 'CLAUDE.md', old3, new3)
# D4 (row 71)
p = draft(4)
a = p.index('replace `') + len('replace `')
b = p.index('` by `**[kernel]**')
old4 = p[a:b]
c = b + len('` by `')
d = p.index(')`. The `**[hand]**` clause before it')
new4 = p[c:d + 1]
assert old4.startswith('**[hand + cert]** With their') and new4.startswith('**[kernel]** With their') and new4.endswith('measure rigidity)')
E('D4a', 'LEDGER.md', old4, new4)
m = re.search(r'Address column: add `([^`]*)`, `([^`]*)`; milestone column: `([^`]*)`\.', p)
addr_old = '`data/fs54/cert-q23-l3-N105.json` | FS-56 |'
E('D4b', 'LEDGER.md', addr_old,
  '`data/fs54/cert-q23-l3-N105.json`, `%s`, `%s` | %s |' % (m.group(1), m.group(2), m.group(3)))
# D5 (ledger section B)
p = draft(5)
gr = re.search(r'grade `([^`]*)` → `([^`]*)`', p)
assert gr.group(1) == 'hand + cert'
par = p[p.index('add `Instances/SeamFractional` (') + len('add '):]
assert par.endswith('worst case).'); par = par[:-1]
t_old = 'approached arbitrarily closely | hand + cert | `plans/FS56-derivation.md` T3; `plans/FS56-field-blowup.md` §B3 | declined |'
t_new = ('approached arbitrarily closely | %s | `plans/FS56-derivation.md` T3; `plans/FS56-field-blowup.md` §B3; %s | declined |'
         % (gr.group(2), par))
E('D5', 'LEDGER.md', t_old, t_new)
# D6
p = draft(6)
old6 = '**Not kernel-checked** beyond Theorem B.'
assert ('replace `%s`' % old6) in p
new6 = p[p.index('by `**Kernel-checked**') + len('by `'):]
assert new6.endswith('no measure rigidity.`'); new6 = new6[:-1]
E('D6', 'CLOSED-QUESTIONS.md', old6, new6)
# D8 (BIBLIOGRAPHY): two cells
p = draft(8)
t_m = between(p, "`[MatolcsiEtAl2025]`'s \"what of ours rests on it\", add \"", '" `[CranstonRabern2015]`')
t_c = between(p, '`[CranstonRabern2015]`: add "', '"')
assert t_m.startswith("Thm 3's certificate") and t_m.endswith('not used by the kernel route.')
assert t_c.startswith('the question is answered') and t_c.endswith('FS131-ISF2).')
def bibedit(sep, add):
    def fn(line):
        cells = line.split(' | ')
        assert len(cells) == 5, len(cells)
        cells[2] = cells[2] + sep + add
        return ' | '.join(cells)
    return fn
E('D8-Matolcsi', 'BIBLIOGRAPHY.md', re.compile(r'(?m)^\| \*\*\[MatolcsiEtAl2025\]\*\*.*$'), bibedit('. ', t_m))
E('D8-Cranston', 'BIBLIOGRAPHY.md', re.compile(r'(?m)^\| \*\*\[CranstonRabern2015\]\*\*.*$'), bibedit('; ', t_c))
# D9 (KERNEL-HOLDS)
p = draft(9)
t9 = p[p.index('(in FS131-IRF1\'s draft 5\'s form): `') + len('(in FS131-IRF1\'s draft 5\'s form): `'):]
assert t9.endswith('standard three axioms.`'); t9 = t9[:-1]
anchor9 = '`HadwigerNelson.RationalFour.*`, standard three axioms.'
E('D9', 'plans/KERNEL-HOLDS.md', anchor9, anchor9 + ' ' + t9)
# D11 (LEAN.md)
i4 = R1.index('\n4. **`LEAN.md`** § The kernel')
p4 = flat(R1[i4:R1.index('\n### 5.3', i4)])
m = re.search(r'\(a\) \*(.*?)\* \(b\) \*(.*?)\* \(c\) \*(.*?)\*$', p4)
abc = [m.group(k) for k in (1, 2, 3)]
p11 = draft(11)
m = re.search(r'\(d\) \*(.*?)\* \(e\) \*(.*?)\* \(f\) \*(.*?)\*$', p11)
d_, e_, f_ = [m.group(k) for k in (1, 2, 3)]
assert abc[0].startswith('A certificate whose terms') and abc[2].endswith('(`Sound.tv_combine_aux`).')
assert d_.startswith('A merge whose two lines') and f_.endswith('(FS131-ISF2).')
E('LEAN-abc', 'LEAN.md', '\n\n## Searching — Lean\n',
  '\n' + '\n'.join('- ' + x for x in abc) + '\n\n## Searching — Lean\n', lit=True)
E('LEAN-d', 'LEAN.md', "\n\n## The kernel's cost model\n", '\n- ' + d_ + "\n\n## The kernel's cost model\n", lit=True)
E('LEAN-ef', 'LEAN.md', '\n\nThe InfoView is continuous testimony',
  '\n- ' + e_ + '\n- ' + f_ + '\n\nThe InfoView is continuous testimony', lit=True)

# ---- find slots
def rx(old): return re.compile(r'\s+'.join(re.escape(t) for t in old.split()))
cache = {}
def load(f):
    if f not in cache: cache[f] = rd(f)
    return cache[f]
plan = []
for n, (i, f, old, new, lit) in enumerate(edits, 1):
    text = load(f)
    if isinstance(old, str):
        o = old
        if PLANT == n: o = o[:-1] + ('X' if o[-1] != 'X' else 'Y')
        ms = list(re.finditer(re.escape(o), text)) if lit else list(rx(o).finditer(text))
        shown = old[:50]
    else:
        pat = old if PLANT != n else re.compile(old.pattern + 'X', old.flags)
        ms = list(pat.finditer(text)); shown = old.pattern[:50]
    print('%-14s %-26s matches=%d  old=%r' % (i, f, len(ms), shown))
    plan.append((i, f, ms, new))
bad = [x[0] for x in plan if len(x[2]) != 1]
if bad:
    print('FAIL: slots not found exactly once:', bad); sys.exit(1)
for f in set(x[1] for x in plan):
    sp = sorted((x[2][0].start(), x[2][0].end(), x[0]) for x in plan if x[1] == f)
    for a_, b_ in zip(sp, sp[1:]):
        assert a_[1] <= b_[0], ('overlap', a_, b_)
fil = load('plans/FILINGS.md')
anchorF = 'before it **the ring of unit vectors** (FS131-KRU1'
assert fil.count(anchorF) == 1
print('moved entry:', moved[:80], '...', moved[-40:])
if DRY:
    print('dry run: nothing written'); sys.exit(0)
byfile = {}
for i, f, ms, new in plan: byfile.setdefault(f, []).append((ms[0], i, new))
for f, lst in byfile.items():
    text = load(f)
    for m, i, new in sorted(lst, key=lambda t: -t[0].start()):
        r = new(m.group(0)) if callable(new) else new
        text = text[:m.start()] + r + text[m.end():]
    open(f, 'w', encoding='utf-8').write(text)
fil = fil.replace(anchorF, moved + '\n\n' + anchorF, 1)
open('plans/FILINGS.md', 'w', encoding='utf-8').write(fil)
print('written')
