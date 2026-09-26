"""J24 stage 2: apply M1, M2, M3's LEDGER.md drafts (rows, corrections, § B lines) to LEDGER.md.
Run: python3 data/crunch-2026-09-25/j24/ledger_apply.py [--dry]   (--plant: corrupt one anchor; must exit 1)
Every draft is read from its close's plan file, never retyped; every replacement anchor must occur exactly once."""
import re, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
DRY = '--dry' in sys.argv or '--plant' in sys.argv
P1 = (ROOT / 'plans/FS91-character-local-global.md').read_text()
P2 = (ROOT / 'plans/M2-kernel-lane.md').read_text()
P3 = (ROOT / 'plans/M3-exotic-colourings.md').read_text()
L = (ROOT / 'LEDGER.md').read_text()
errors = []
def sect(t, a, b):
    s = t.index(a); return t[s:t.index(b, s)]
ROWMAP = {'N1': '98', 'N2': '99', 'N3': '100', 'N4': '101', 'N5': '102',
          'next-a': '103', 'next-b': '104', 'next-c': '105', 'next-d': '106', 'next-e': '107',
          'next+2': '110', 'next+1': '109', 'next': '108'}
def renum(s):
    # row placeholders inside text: N1..N5 (not N₅, N_k), next-a..e, next, next+1, next+2 after "row"/"rows"
    s = re.sub(r'(?<![A-Za-z0-9_₀-₉])N([1-5])(?![0-9])', lambda m: ROWMAP['N' + m.group(1)], s)
    s = re.sub(r'\bnext-([a-e])\b', lambda m: ROWMAP['next-' + m.group(1)], s)
    s = re.sub(r'(rows? )next\+2\b', lambda m: m.group(1) + '110', s)
    s = re.sub(r'(rows? )next\+1\b', lambda m: m.group(1) + '109', s)
    s = re.sub(r'(rows? )next\b(?![-+])', lambda m: m.group(1) + '108', s)
    s = re.sub(r'FS-M1a', 'FS-92', s); s = re.sub(r'FS-M1b', 'FS-93', s); s = re.sub(r'FS-M1c', 'FS-94', s)
    return s
def rows(t, a, b, lead):
    out = []
    for line in sect(t, a, b).splitlines():
        m = re.match(r'^\| (' + lead + r') \|', line)
        if m: out.append((m.group(1), line))
    return out
# § A rows
A1 = rows(P1, '#### 4.1', '#### 4.2', r'N[1-5]')
A2 = rows(P2, '#### 4a.', '#### 4b.', r'next-[a-e]')
A3 = rows(P3, '#### R4.L', '**Row 92, correction', r'next(?:\+[12])?')
newA = []
for tag, line in A1 + A2 + A3:
    num = ROWMAP[tag]
    body = line[len('| ' + tag + ' |'):]
    newA.append('| ' + num + ' |' + renum(body))
if [x[0] for x in A1 + A2 + A3] != ['N1','N2','N3','N4','N5','next-a','next-b','next-c','next-d','next-e','next','next+1','next+2']:
    errors.append('row set: ' + str([x[0] for x in A1 + A2 + A3]))
# the M3 milestone cell reads "M3 (crunch 2026-09-25)"; M2's "M2 (FS-45)" etc.; M1's "FS-91" — kept as drafted
# corrections (M1 4.2): parse the table's old/new pairs
corr = []
for line in sect(P1, '#### 4.2', '(Row 92').splitlines():
    m = re.match(r'^\| (\d+) \| "(.*)" \| "(.*)" \|$', line)
    if m: corr.append((m.group(1), m.group(2).replace('\\"', '"'), renum(m.group(3).replace('\\"', '"'))))
if len(corr) != 7: errors.append(f'M1 4.2 pairs: {len(corr)}')
# row 92: M3 R4.L and J26 §4.4
corr.append(('92', 'for sets of places whose split places are odd (C14.2 at `p = 2`, where their\ndyadic places split, not checked)'.replace('\n', ' '),
             'for every finite set of places (C14.2 (c) holds at `q = 2`: M3, row 110, two minds)'))
corr.append(('92', 'external, computer-assisted, published, not re-checked here (its audit a named post-close item; this grade to be upgraded in place)',
             'external, computer-assisted, published; **its certificate re-checked here** (J26, `plans/PA-ambrus2023-audit.md`: exact on the finite obligations, double precision on the Bessel obligation with Lipschitz constants derived here; the authors\' Mathematica notebook not run, and its similarity-for-congruence and Lipschitz gaps shown harmless)'))
if '--plant' in sys.argv: corr[0] = (corr[0][0], corr[0][1] + ' PLANTED', corr[0][2])
lines = L.split('\n')
def rowidx(n):
    ix = [i for i, l in enumerate(lines) if l.startswith('| ' + n + ' |')]
    return ix[0] if len(ix) == 1 else None
for n, old, new in corr:
    i = rowidx(n)
    if i is None: errors.append(f'row {n} not unique'); continue
    c = lines[i].count(old)
    if c != 1: errors.append(f'row {n}: anchor occurs {c}: {old[:60]}'); continue
    lines[i] = lines[i].replace(old, new)
# insert § A rows after row 97
i97 = rowidx('97')
if i97 is None or any(rowidx(r[2:5].strip()) is not None for r in newA): errors.append('row 97 / new rows')
else: lines[i97 + 1:i97 + 1] = newA
L2 = '\n'.join(lines)
# header pointer (J24a's L1) → current state
oldH = ('*Work of the 2026-09-25 crunch not yet folded into rows is indexed in `plans/CRUNCH-2026-09-25-INDEX.md`, with its items in\n'
        '`plans/FS91-close-inventory.md`, `plans/M2-close-inventory.md` and `plans/M3-close-inventory.md`.*')
newH = ('*The 2026-09-25 crunch\'s three milestones are folded in: rows 98–102 (M1, FS-91), 103–107 (M2, the kernel lane) and 108–110\n'
        '(M3); its index is `plans/CRUNCH-2026-09-25-INDEX.md` and its items `plans/FS91-close-inventory.md`, `plans/M2-close-inventory.md` and\n'
        '`plans/M3-close-inventory.md`.*')
if L2.count(oldH) != 1: errors.append('header pointer')
L2 = L2.replace(oldH, newH)
# § B lines
B1 = [l for l in sect(P1, '#### 4.3', '#### 4.4').splitlines() if re.match(r'^\| FS91-', l)]
B2 = [l for l in sect(P2, '#### 4b.', 'Kernel-column changes').splitlines() if re.match(r'^\| J(04|14|17)-', l)]
B3 = [l for l in sect(P3, '#### R4.B', '#### R4.C').splitlines() if re.match(r'^\| M3-', l)]
def m3proof(l):
    cells = l.split(' | ')
    # cells: ['| id', 'M3', statement, grade, proof, 'kernel |']
    if len(cells) >= 6 and not cells[4].startswith('`plans/'):
        cells[4] = '`plans/M3-derivation.md` ' + cells[4]
    return ' | '.join(cells)
B3 = [m3proof(l) for l in B3]
B = [renum(l) for l in B1 + B2 + B3]
if (len(B1), len(B2), len(B3)) != (73, 12, 46): errors.append(f'§ B counts {len(B1)}, {len(B2)}, {len(B3)}')
L2 = L2.rstrip('\n') + '\n' + '\n'.join(B) + '\n'
# M2 kernel-column changes
for line in sect(P2, 'Kernel-column changes', '#### 4c.').splitlines():
    m = re.match(r'^\| `([^`]+)` \| (.*?) \| (.*) \|$', line)
    if not m: continue
    bid, now, new = m.groups()
    ix = [i for i, l in enumerate(L2.split('\n')) if l.startswith('| ' + bid + ' |')]
    ls = L2.split('\n')
    if len(ix) != 1: errors.append(f'§ B {bid}: {len(ix)} lines'); continue
    row = ls[ix[0]]
    if not row.endswith('| ' + now + ' |'): errors.append(f'§ B {bid}: kernel cell is not "{now}": {row[-80:]}'); continue
    ls[ix[0]] = row[:-len(now + ' |')] + renum(new) + ' |'
    L2 = '\n'.join(ls)
# J26: the FS86-Cx-C14 § B grade
oldC = '| hand + external (AmbrusEtAl2023 at real places) |'
if L2.count(oldC) != 1: errors.append('C14 grade')
L2 = L2.replace(oldC, '| hand + external (AmbrusEtAl2023 at real places; its certificate re-checked by J26) |')
if errors:
    print('ERRORS:'); [print(' ', e) for e in errors]; sys.exit(1)
print(f'rows added {len(newA)}; corrections {len(corr)}; § B lines {len(B)}; LEDGER.md {len(L.encode())} -> {len(L2.encode())} bytes')
if not DRY: (ROOT / 'LEDGER.md').write_text(L2)
