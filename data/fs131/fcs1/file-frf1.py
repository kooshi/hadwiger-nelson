#!/usr/bin/env python3
"""FS131-FRF1: file FS131-IRF1's drafts 1-6 and 8 and its two LEAN.md lines, verbatim, with the brief's substitutions.
Draft texts are sliced from the plan files, never retyped. Every slot must occur exactly once
(whitespace-insensitive) before anything is written. PLANT=<n> alters slot n by one character (must fail).
Run from the worktree root: python3 data/fs131/fcs1/file-frf1.py [--dry]"""
import re, sys, os

DRY = '--dry' in sys.argv
PLANT = int(os.environ.get('PLANT', '0'))
rd = lambda p: open(p, encoding='utf-8').read()
REC = rd('plans/FS131-IRF1-four-space.md')
DR = REC[REC.index('## Drafts for the front page'):]
PAS = rd('plans/FS131-PAS3-kubicki-lehel-morayne.md')

def flat(s): return re.sub(r'\s+', ' ', s).strip()
def block(src, start, end=None):
    i = src.index(start)
    j = src.index(end, i + len(start)) if end else len(src)
    return src[i:j]
def between(p, a, b):
    i = p.index(a) + len(a)
    return p[i:p.index(b, i)]

def draft(n):
    nxt = '\n%d. **' % (n + 1)
    b = block(DR, '\n%d. **' % n, nxt if n < 9 else None)
    return flat(b)

PENDING = 'pending `[KubickiLehelMorayne2002]`'
NIP = 'not found in print (FS131-PAS2, FS131-PAS3)'

edits = []
def E(i, f, old, new): edits.append((i, f, old, new))

# PAS3 3.4 item 5: novelty line, "the answer to" .. "The kernel proof is this project's."
pi = PAS.index('5. **The novelty line for the C7 module')
pj = PAS.index('\n6. **Optional, for the kernel lane**', pi)
p5 = flat(PAS[pi:pj])
novelty = p5[p5.index('the answer to'):p5.index("The kernel proof is this project's.") + len("The kernel proof is this project's.")]
assert novelty.startswith('the answer to `[Johnson2006]` p. 212') and novelty.endswith("is this project's."), novelty[-30:]

# draft 1
p = draft(1)
m = re.search(r'replace `` (.*?) `` by `` (.*?) ``\.', p)
E('D1', 'CLAUDE.md', m.group(1).replace('`, `', '`, `'), m.group(2))
# draft 2
p = draft(2)
E('D2', 'CLAUDE.md', between(p, 'replace `', '` by `'), between(p, '` by `', '`. The assumptions'))
# draft 3: the new row 169
p = draft(3)
row = p[p.index('`| N | ') + 1:]
assert row.endswith('|`'); row = row[:-1]
assert row.startswith('| N | **The four-colour compulsion law'), row[:40]
row = '| 169 |' + row[len('| N |'):]
assert row.count('**Prior art:** ' + PENDING + '.') == 1
row = row.replace('**Prior art:** ' + PENDING + '.', '**Prior art:** ' + novelty)
tail_old = '| consolidation run (2026-09-27); FS-131 (FS131-KFS1, FS131-IRF1) |'
assert row.endswith(tail_old), row[-90:]
assert row.count(' | ') == 3, row.count(' | ')   # four columns
row = row[:-len(tail_old)] + '| FS-131 (2026-10-17) |'
assert PENDING not in row
E('D3', 'LEDGER.md', re.compile(r'(?m)^\| 168 \|.*$'), lambda t: t + '\n' + row)
# draft 4
p = draft(4)
old4 = between(p, 'replace `', '` by `**Kernel-checked**')
new4 = p[p.index('by `**Kernel-checked**') + len('by `'):]
assert new4.endswith('`'); new4 = new4[:-1]
assert PENDING not in new4
E('D4', 'CLOSED-QUESTIONS.md', old4, new4)
# draft 5
p = draft(5)
t5 = p[p.index('a clause after the last: `') + len('a clause after the last: `'):]
assert t5.endswith('`'); t5 = t5[:-1]
t5 = t5.replace(PENDING, NIP)
anchor5 = 'the cell family (rows 34–41). Also χ(Heule-510) = χ(Heule-553) = 5 and χ(de Grey\'s 1581) ≤ 5.'
E('D5', 'plans/KERNEL-HOLDS.md', anchor5, anchor5 + ' ' + t5)
# draft 6
p = draft(6)
t6 = between(p, 'the "Last filed" line: `', '`, the previous filing moving')
assert t6.startswith('Last filed: **rational four-space') and t6.endswith('moved)'), t6[-20:]
assert PENDING not in t6
E('D6', 'CLAUDE.md', re.compile(r'Last filed: \*\*the ring of unit vectors\*\*.*?; before it, ', re.S), None)  # new set below
# draft 8
p = draft(8)
body = p[p.index('rests on it": ') + len('rests on it": '):] if 'rests on it": ' in p else None
if body is None:
    body = p[p.index('"what of ours rests on it", ') + len('"what of ours rests on it", ') if '"what of ours rests on it", ' in p else 0:]
body = p[p.index('`[Zaks1999]` —'):]
parts = re.split(r'; (?=`\[(?:BendaPerles2000|Johnson1990|Johnson2006|KubickiLehelMorayne2002)\]` — )', body)
assert len(parts) == 5, len(parts)
keys = ['Zaks1999', 'BendaPerles2000', 'Johnson1990', 'Johnson2006', 'KubickiLehelMorayne2002']
bib = {}
for k, t in zip(keys, parts):
    assert t.startswith('`[%s]` — ' % k), (k, t[:30])
    t = t[len('`[%s]` — ' % k):]
    t = t.replace(PENDING, NIP)
    if not t.endswith('.'): t += '.'
    bib[k] = ' **In the kernel (FS131-IRF1):** ' + t
def bibedit(k, ncells, idx):
    def new(line):
        cells = line.split(' | ')
        if ncells == 5: assert len(cells) == 5, (k, len(cells))
        else:
            assert len(cells) == 2 and cells[1].endswith(' |'), (k, len(cells))
        if ncells == 5:
            cells[idx] = cells[idx] + bib[k]
        else:
            cells[1] = cells[1][:-2].rstrip() + bib[k] + ' |'
        return ' | '.join(cells)
    return new
for k, nc, ix in [('Zaks1999', 2, 1), ('BendaPerles2000', 5, 2), ('Johnson1990', 5, 2), ('Johnson2006', 5, 2), ('KubickiLehelMorayne2002', 5, 2)]:
    E('D8-' + k, 'BIBLIOGRAPHY.md', re.compile(r'(?m)^\| \*\*\[%s\]\*\*.*$' % k), bibedit(k, nc, ix))
# LEAN.md: the two lines of Stage 2
s2 = block(REC, '**Two things the plan did not say, both found by the elaborator:**', '**The re-price from the first two leaves**')
i1 = s2.index('\n1. **'); i2 = s2.index('\n2. **')
def bullet(txt):
    lines = txt.strip('\n').split('\n')
    lines[0] = re.sub(r'^\d\. ', '- ', lines[0])
    return '\n'.join([lines[0]] + ['  ' + l.lstrip() for l in lines[1:]]).rstrip()
lean = bullet(s2[i1:i2]) + '\n' + bullet(s2[i2:])
assert lean.startswith('- **A coercion') and '\n- **An anonymous constructor' in lean
E('LEAN', 'LEAN.md', '\n\n## The package\n', '\n' + lean + '\n\n## The package\n')

# ---- find slots
def rx(old): return re.compile(r'\s+'.join(re.escape(t) for t in old.split()))
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
        ms = list(rx(o).finditer(text)) if o.strip() == o else list(re.finditer(re.escape(o), text))
        shown = old[:50]
    else:
        ms = list(old.finditer(text)) if PLANT != n else []
        shown = old.pattern[:50]
    print('%-26s %-26s matches=%d  old=%r' % (i, f, len(ms), shown))
    plan.append((i, f, ms, new))
bad = [x[0] for x in plan if len(x[2]) != 1]
if bad:
    print('FAIL: slots not found exactly once:', bad); sys.exit(1)

# D6 needs the matched old entry
m6 = [x for x in plan if x[0] == 'D6'][0][2][0].group(0)
assert m6.startswith('Last filed: ') and m6.endswith('; before it, ')
old_entry = m6[len('Last filed: '):-len('; before it, ')]
assert old_entry.startswith('**the ring of unit vectors** (FS131-KRU1, FS131-IRU1, FS131-IRU2,') and old_entry.endswith('moved)'), old_entry[-30:]
short = '**the ring of unit vectors** (FS131-KRU1, FS131-IRU1, FS131-IRU2)'
new6 = t6 + '; before it, ' + short + ', '
plan = [(i, f, ms, (new6 if i == 'D6' else new)) for (i, f, ms, new) in plan]
moved = 'before it ' + flat(old_entry)
fil = load('plans/FILINGS.md')
anchorF = 'before it **the density form of the collapse**'
assert fil.count(anchorF) == 1
print('moved entry:', moved[:90], '...', moved[-50:])

for f in set(x[1] for x in plan):
    sp = sorted((x[2][0].start(), x[2][0].end(), x[0]) for x in plan if x[1] == f)
    for a, b2 in zip(sp, sp[1:]):
        assert a[1] <= b2[0], ('overlap', a, b2)
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
