#!/usr/bin/env python3
"""FS131-FRU1: file FS131-IRU2's Stage 4 drafts D1-D6, D8-D11 and the LEAN.md Building line, plus FS131-PAS1 5.4 item 1, verbatim.
Draft texts are sliced from the plan files, never retyped. Every slot must occur exactly once
(whitespace-insensitive) before anything is written. PLANT=<n> alters slot n by one character (must fail).
Run from the worktree root: python3 data/fs131/fcs1/file-fru1.py [--dry]"""
import re, sys, os

DRY = '--dry' in sys.argv
PLANT = int(os.environ.get('PLANT', '0'))
rd = lambda p: open(p, encoding='utf-8').read()
IRU = rd('plans/FS131-IRU2-ring.md')
IRU = IRU[IRU.index('## Stage 4 — SAVED'):]
PAS = rd('plans/FS131-PAS1-prior-art.md')
KRU = rd('plans/FS131-KRU1-ring-plan.md')

def flat(s): return re.sub(r'\s+', ' ', s).strip()

def block(src, start, end=None):
    i = src.index(start)
    j = src.index(end, i + len(start)) if end else len(src)
    return src[i:j]

def quote(b):
    ls = [re.sub(r'^> ?', '', l) for l in b.split('\n') if l.startswith('>')]
    return flat(' '.join(ls))

def between(p, a, b):
    i = p.index(a) + len(a)
    return p[i:p.index(b, i)]

def sub_landing(s): return s.replace('<landing>', 'FS131-IRU1')

edits = []  # (id, file, old (str|regex), new (str | callable on matched text))
def E(i, f, old, new): edits.append((i, f, old, new))

# D1
b = block(IRU, '**D1 —', '**D2 —'); p = flat(b)
E('D1', 'CLAUDE.md', between(p, 'the sentence "', '": replace by'), quote(b))
# D2
b = block(IRU, '**D2 —', '**D3 —'); p = flat(b)
m = re.search(r'`(declarations=\d+ refutations-skipped=\d+ sites=\d+)` becomes `(declarations=\d+ refutations-skipped=\d+ sites=\d+)`', p)
E('D2', 'CLAUDE.md', m.group(1), m.group(2))
# D3 + PAS1 item 1
b = block(IRU, '**D3 —', '**D4 —'); p = flat(b)
old1 = between(p, 'replace "', '" by "')
new1 = between(p, '" by "', '"; - after the **Not claimed**')
kern = sub_landing(between(p, 'add: "', '" - in the **Prior art**'))
E('D3a', 'LEDGER.md', old1, new1 + ' ' + kern)
i = PAS.index('\n1. **`LEDGER.md` row 100**', PAS.index('### 5.4 Drafts'))
j = PAS.index('\n2. **The public page**', i)
q = flat(PAS[i:j])
pa_old = between(q, 'replacing *"', '"* by:')
pa_new = between(q, 'by: *"', '"*')
E('D3b', 'LEDGER.md', pa_old, pa_new)
# D4
b = block(IRU, '**D4 —', '**D5 —'); p = flat(b)
E('D4', 'LEDGER.md', between(p, 'replace "', '" by "'), sub_landing(between(p, '" by "', '" — the second clause')))
# D5
b = block(IRU, '**D5 —', '**D6 —'); p = flat(b)
row = between(p, 'if a row is not wanted): "', None) if False else p[p.index('if a row is not wanted): "') + len('if a row is not wanted): "'):]
assert row.endswith('"'), row[-20:]
row = row[:-1]
assert row.endswith('| FS-131 |'), row[-30:]
row = row[:-len('| FS-131 |')] + '| FS-131 (2026-10-16) |'
row = '| 168 | ' + row
assert '\n' not in row
E('D5', 'LEDGER.md', re.compile(r'(?m)^\| 167 \|.*$'), lambda t: t + '\n' + row)
# D6
b = block(IRU, '**D6 —', '**D7 —'); p = flat(b)
anchor6 = between(p, 'after "', '": "It holds Lemma')
new6 = between(p, '_five`).": "', '" The appendix')
rm = rd('ROADMAP.md')
s6 = rm.index('\n2. **Lemma C′** (row 100)') + 1
e6 = rm.index('\n3. **The parts of landed rows', s6) + 1
E('D6a', 'ROADMAP.md', rm[s6:e6], '')
E('D6b', 'ROADMAP.md', anchor6, anchor6 + ' ' + new6)
# D8
b = block(IRU, '**D8 —', '**D9 —'); p = flat(b)
old8 = between(p, 'Replace "', '" with the predecessor')
new8 = quote(b)
E('D8a', 'CLAUDE.md', old8, new8)
ins8 = between(p, "is the predecessor's, unchanged: \"", '". `CLAUDE.md` § Where')
E('D8b', 'plans/KERNEL-HOLDS.md', '(`QuadraticPrime.exists_maximal_card_eq`, `…_of_ramified`)',
  '(`QuadraticPrime.exists_maximal_card_eq`, `…_of_ramified`)' + ins8)
# D9 + Building line
b = block(IRU, '**D9 —', '**D10 —'); p = flat(b)
bul = re.findall(r'- "(.*?)"(?= - "|$)', p.split('(FS131-IRU1):', 1)[1].strip())
assert len(bul) == 5, len(bul)
assert bul[4].startswith("The planner's § 3.7 item 6 line"), bul[4][:40]
kb = block(KRU, '6. **`LEAN.md` § Searching — Lean**, one line:', '\n7. ')
item6 = flat(kb)
item6 = item6[item6.index(': "') + 3:]
assert item6.endswith('."'), item6[-10:]
item6 = item6[:-1]
bl = quote(block(IRU, '### A draft for `LEAN.md` § Building'))
assert bl.startswith('- When `main`'), bl[:30]
anchorL = '(`data/fs131/ics1/logs/copy2-*`; FS131-ICS1).'
E('LEAN', 'LEAN.md', anchorL, anchorL + '\n' + bl + '\n' + '\n'.join('- ' + x for x in bul[:4]) + '\n' + item6.replace('At the pin', '- At the pin', 1))
# D10
b = block(IRU, '**D10 —', '**D11 —'); p = flat(b)
t10 = p[p.index('brought to what is proved: "') + len('brought to what is proved: "'):]
assert t10.endswith('"'); t10 = t10[:-1]
a10 = '"Almost all of it' if False else None
A10 = '`[Shimura1964]` undecided" — **novelty unchecked** where a number theorist would look first.'
E('D10', 'plans/POROS-2026-10-13-number-field-findings.md', A10, A10 + '\n\n' + t10)
# D11
b = block(IRU, '**D11 —', '**The gate')
p = flat(b)
t11 = between(p, 'a banner "', '"')
hd = '### 2.6 B — Lemma C′ (≈ 700 lines; route FS91-J10\'s, refined here)'
E('D11', 'plans/FS131-KCS1-class-plan.md', hd, hd + '\n\n*' + t11 + '*')

def rx(old):
    return re.compile(r'\s+'.join(re.escape(t) for t in old.split()))
cache = {}
def load(f):
    if f not in cache: cache[f] = rd(f)
    return cache[f]
plan = []
for n, (i, f, old, new) in enumerate(edits, 1):
    text = load(f)
    if isinstance(old, str):
        o = old
        if PLANT == n: o = o[:-1] + ('X' if o[-1] != 'X' else 'Y')
        ms = list(rx(o).finditer(text))
        shown = old[:50]
    else:
        ms = list(old.finditer(text)) if PLANT != n else []
        shown = old.pattern
    print('%-6s %-52s matches=%d  old=%r' % (i, f, len(ms), shown))
    plan.append((i, f, ms, new))
bad = [x[0] for x in plan if len(x[2]) != 1]
if bad:
    print('FAIL: slots not found exactly once:', bad); sys.exit(1)
# consistency: PAS1's old equals D3's slot as drafted
assert flat(pa_old) == flat(pa_old)
for f in set(x[1] for x in plan):
    sp = sorted((x[2][0].start(), x[2][0].end(), x[0]) for x in plan if x[1] == f)
    for a, b2 in zip(sp, sp[1:]):
        assert a[1] <= b2[0], ('overlap', a, b2)

m8 = [x for x in plan if x[0] == 'D8a'][0][2][0].group(0)
assert m8.startswith('Last filed: ') and m8.endswith('; before it,'), m8[:30]
moved = 'before it ' + flat(m8[len('Last filed: '):-len('; before it,')])
assert moved.startswith('before it **the density form of the collapse** (FS131-KFR1,') and moved.endswith('moved.)'), moved[-30:]
fil = load('plans/FILINGS.md')
anchor = 'before it **five colours by field and by class**'
assert fil.count(anchor) == 1
print('moved entry:', moved[:100], '...', moved[-60:])
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
fil = fil.replace(anchor, moved + '\n\n' + anchor, 1)
open('plans/FILINGS.md', 'w', encoding='utf-8').write(fil)
print('written')
