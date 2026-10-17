#!/usr/bin/env python3
"""FS131-FPA2: file FS131-PAS2's ruled drafts (record sections 4.4 items 1-3 and 2.4 item 4, verbatim) and the
owed bibliography pass.  Run from the worktree root.
`file.py --plant` changes one part-1 slot text by a character and must FAIL (nothing written).
Without it, every edit is made in memory; every slot must occur exactly once (whitespace-insensitive) or
nothing is written."""
import re, sys, pathlib

REC = pathlib.Path('plans/FS131-PAS2-prior-art.md')
PLANT = '--plant' in sys.argv
norm = lambda s: re.sub(r'\s+', ' ', s).strip()
rec = REC.read_text()

def section(start, end):
    a = rec.index(start); b = rec.index(end, a)
    return norm(rec[a:b])

sec24 = section('### 2.4 Drafts', '## Stage 3')
sec44 = section('### 4.4 Drafts', "**C14's novelty line**")
def item(sec, n, nxt):
    a = sec.index(f' {n}. **') if n > 1 else sec.index('1. **')
    b = sec.index(f' {nxt}. **', a + 1) if nxt else len(sec)
    return sec[a:b].strip()
it44 = [item(sec44, 1, 2), item(sec44, 2, 3), item(sec44, 3, None)]
it24_4 = item(sec24, 4, None)
assert it24_4.startswith('4. **`BIBLIOGRAPHY.md`**'), it24_4[:60]
assert it44[2].startswith('3. **`BIBLIOGRAPHY.md`**')

files = {}
def get(f):
    if f not in files:
        files[f] = pathlib.Path(f).read_text()
    return files[f]
log = []

def sub(f, slot, new, label, keep_slot=False):
    """replace slot (whitespace-insensitive, exactly once) by new; keep_slot: insertion after the slot"""
    if PLANT and label.startswith('P1-1'):
        slot = slot[:6] + 'X' + slot[7:]
    txt = get(f)
    rx = r'\s+'.join(re.escape(w) for w in slot.split())
    ms = list(re.finditer(rx, txt))
    if len(ms) != 1:
        sys.exit(f'FAIL {label}: slot occurs {len(ms)} times in {f}: {slot[:80]!r}')
    m = ms[0]
    out = (m.group(0) + new) if keep_slot else new
    files[f] = txt[:m.start()] + out + txt[m.end():]
    log.append(label)

B = 'BIBLIOGRAPHY.md'
def lines_of(f):
    return get(f).split('\n')
def one_line(prefix, label):
    ls = lines_of(B)
    idx = [i for i, l in enumerate(ls) if l.startswith(prefix)]
    if len(idx) != 1:
        sys.exit(f'FAIL {label}: line prefix {prefix!r} occurs {len(idx)} times')
    return ls, idx[0]
def put(ls, label):
    files[B] = '\n'.join(ls); log.append(label)
def append_last_cell(prefix, text, label):
    ls, i = one_line(prefix, label)
    assert ls[i].endswith(' |'), label
    ls[i] = ls[i][:-2] + text + ' |'
    put(ls, label)

# ---------------- PART 1 ----------------
# 4.4 item 1 : CLOSED-QUESTIONS 1.6
t = it44[0]
slot = re.search(r'\(\*"…(.*?)"\*\): \*"', t).group(1)
new = re.search(r'\(\*"….*?"\*\): \*"(.*)"\*\.?$', t).group(1)
sub('CLOSED-QUESTIONS.md', slot, ' ' + new, 'P1-1 CLOSED-QUESTIONS 1.6', keep_slot=True)
# 4.4 item 2 : LEDGER row 71
t = it44[1]
m = re.search(r'after \*"…(.*?)"\*: \*"(.*)"\*\.$', t)
sub('LEDGER.md', m.group(1), ' ' + m.group(2), 'P1-2 LEDGER row 71', keep_slot=True)
# 4.4 item 3 : bibliography lines
t = it44[2]
for key, lab in (('Ducz2026', 'Ducz status'), ('MatolcsiEtAl2025', 'Matolcsi status')):
    a = re.search(r'- `\[%s\]`, its status cell: append \*"(.*?)"\*\.' % key, t).group(1)
    assert a.startswith('; ')
    append_last_cell(('| **[%s]** |' if key == 'Ducz2026' else '| **[%s]** /') % key, a, 'P1-3 ' + lab)
a = re.search(r'- `\[DuczVarga2026\]`: append \*"(.*?)"\*', t).group(1)
append_last_cell('| **[DuczVarga2026]** |', a, 'P1-3 DuczVarga status')
m = re.search(r'- § C, a listing row: \*(.*?)\* \| \*(.*?)\*\.?$', t)
jungic = (m.group(1), m.group(2))
# 2.4 item 4
t = it24_4
a = re.search(r'`\[Johnson2010\]` — append to its status cell: \*"(.*?)"\*', t).group(1)
append_last_cell('| **[Johnson2010]** / **[GrahamTressler2010]** |', '; ' + a, 'P1-4 Johnson2010 status')
bcopy = re.search(r'copy \*"(held: .*?)"\*;', t).group(1)
bstat = re.search(r'status \*"(read: .*?)"\*;', t).group(1)
ls, i = one_line('| **[BauJohnsonNoble2021]** | S. Bau, P. Johnson', 'P1-4 Bau A')
cells = ls[i].split(' | ')
assert len(cells) == 5 and cells[3].startswith('not held'), cells[3:]
cells[3] = bcopy
assert cells[4].endswith(' |'), cells[4]
cells[4] = cells[4][:-2] + '; ' + bstat + ' |'
ls[i] = ' | '.join(cells); put(ls, 'P1-4 BauJohnsonNoble2021 § A copy and read')
ls, i = one_line('| **[BauJohnsonNoble2021]** S. Bau', 'P1-4 Bau C')
ls[i] = ls[i][:-2] + '; **superseded by the § A row** |'; put(ls, 'P1-4 BauJohnsonNoble2021 § C row marked superseded')
z = re.search(r'`\[Zaks1989\]` — status: \*"(.*?)"\.?\*', t).group(1)
ls, i = one_line('| **[Zaks1989]** J. Zaks', 'P1-4 Zaks')
cells = ls[i].split(' | ')
assert len(cells) == 3, len(cells)
cells[1] = cells[1] + '; ' + z
ls[i] = ' | '.join(cells); put(ls, 'P1-4 Zaks1989 status')

newA = []
for key in ('JohnsonVoloshin2007', 'KubickiLehelMorayne2002'):
    m = re.search(r'new \*\*`\[%s\]`\*\* — \*(.*?)\* \| \*(.*?)\* \| \*(.*?)\* \| \*(.*?)\*[.;]' % key, t)
    newA.append('| **[%s]** | ' % key + ' | '.join(m.groups()) + ' |')
# listing rows
m = re.search(r'Listing rows \(§ C, "(searched, title or review only)", FS131-PAS2\): (.*?) — each \*"(.*?)"\*\.', t)
label, names, verdict = m.groups()
def split_top(s):
    out, depth, cur, k = [], 0, '', 0
    while k < len(s):
        ch = s[k]
        if ch == '(': depth += 1
        if ch == ')': depth -= 1
        if depth == 0 and s[k:k+2] == '; ':
            out.append(cur); cur = ''; k += 2; continue
        cur += ch; k += 1
    out.append(cur); return out
names = split_top(names); assert len(names) == 7, names
newC = ['| %s | **Searched, title or review only** (FS131-PAS2): %s |' % (n, verdict) for n in names]
newC.append('| %s | %s |' % jungic)

if PLANT:
    sys.exit('PLANT NOT CAUGHT')

# ---------------- PART 2 ----------------
L = '~/source/library/'
# 2.2 deGrey2026 / Haugstrup2026: R.4 rows 8 and 9 -> § A rows
ls = lines_of(B)
def r4(prefix):
    idx = [i for i, l in enumerate(ls) if l.startswith(prefix)]
    assert len(idx) == 1, prefix
    return idx[0]
rows = {}
for num, key in ((8, 'deGrey2026'), (9, 'Haugstrup2026')):
    i = r4('| %d | **[%s]** — ' % (num, key))
    c = ls[i].split(' | ')
    assert len(c) == 5, (key, len(c))
    work = c[1].split('** — ', 1)[1]
    ident, why, status = c[2], c[3], c[4][:-2]
    rows[key] = (i, work, ident, why, status)
cq = {'deGrey2026': 'the `CLOSED-QUESTIONS.md` § 3 entries "A triangle-free 5-chromatic unit-distance graph, and one of the smallest order" and "A triangle-free 6-chromatic unit-distance graph in ℝ³" (both cite it) and the README § 5 prior-art line ("a question of de Grey and of Haugstrup (both 2026)")',
      'Haugstrup2026': 'the `CLOSED-QUESTIONS.md` § 3 entry "A triangle-free 6-chromatic unit-distance graph in ℝ³" (cites its closing section) and the README § 5 prior-art line ("a question of de Grey and of Haugstrup (both 2026)")'}
copy = {'deGrey2026': 'held: `library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf`, pp. 111–118',
        'Haugstrup2026': 'held: `library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf` (same issue), pp. 102–110'}
newA2 = []
for key in ('deGrey2026', 'Haugstrup2026'):
    i, work, ident, why, status = rows[key]
    newA2.append('| **[%s]** | %s (%s) | Cited by %s. From its § R.4 row — why: %s | %s | %s |'
                 % (key, work, ident.split(' (')[0].split(' · ')[0] if False else ident.split('. The journal')[0].split(' (a listing')[0].split(' (found')[0], cq[key], why, copy[key], status))
for i in sorted((rows['deGrey2026'][0], rows['Haugstrup2026'][0]), reverse=True):
    del ls[i]
files[B] = '\n'.join(ls); log.append('2.2 R.4 rows 8 and 9 deleted (not renumbered)')

# 2.3 Shimura1964: R.4 #17 key to a plain reference
ls, i = one_line('| 17 | **[Shimura1964]** — ', '2.3 Shimura')
ls[i] = ls[i].replace('| 17 | **[Shimura1964]** — ', '| 17 | `[Shimura1964]` — ', 1); put(ls, '2.3 Shimura1964 R.4 #17 key plain')

# 2.5 : Neukirch, arXiv listing rows
newA3 = ['| **[Neukirch1999]** | Neukirch, 1999 (the title is not in the citing plan; Madore\'s excerpt cites "Neukirch 1999, theorem 13.4", `data/m2/j17/excerpts/madore2015-p5.1-5.4.txt` l. 89) | `plans/FS131-KRU1-ring-plan.md`: the price of the declared-axiom route cites it, Ch. VII § 13, for Chebotarev\'s existence clause for an automorphism `σ` of a Galois extension of number fields | not held; cited by the planner, not read here | not read (the plan: "recalled, not read; no copy in the library") |']
listing = [
 ('arXiv:1502.00965 Godsil–Rooney (title not in the record)', 'Abstract only (FS131-PAS1, `plans/FS131-PAS1-prior-art.md` § 2.2, 2026-10-16): "None states a criterion for a given `S`." Not held.'),
 ('arXiv:2303.06267 `[CervantesKrebs2023]`\'s Payan note (a Heuberger-matrix proof of Payan)', 'Abstract only (FS131-PAS1, `plans/FS131-PAS1-prior-art.md` § 2.2, 2026-10-16): "None states a criterion for a given `S`." Not held.'),
 ('arXiv:2312.06898 Bucić–Davies (Amer. Math. Monthly 2025)', 'Abstract only (FS131-PAS1, `plans/FS131-PAS1-prior-art.md` § 3.2, 2026-10-16): large girth, exponential chromatic number in `ℝ^d`. Not held.'),
 ('arXiv:2512.05302 Krebs–Pan–Prakash (title not in the record)', 'Abstract only (FS131-PAS1, `plans/FS131-PAS1-prior-art.md` § 2.2, 2026-10-16): "None states a criterion for a given `S`." Not held.'),
 ('arXiv:2606.23762 Tung (title not in the record)', 'Abstract only (FS131-PAS1, `plans/FS131-PAS1-prior-art.md` § 2.2, 2026-10-16): "None states a criterion for a given `S`." Not held.'),
 ('arXiv:2607.26942 García-Marco–Knauer–Menara (circular chromatic number ≤ 4 for semiminimal abelian Cayley graphs)', 'Abstract only (FS131-PAS1, `plans/FS131-PAS1-prior-art.md` § 2.2, 2026-10-16): "None states a criterion for a given `S`." Not held.'),
 ('arXiv:2602.17943 G. Istrate, C. Zara, *Hypersphere-based restricting conditions for colorings of the Euclidean space* (20 February 2026)', 'Checked by FS131-PAS2 (`plans/FS131-PAS2-prior-art.md` § 2.3, 2026-10-17): colourings of `ℝⁿ` under hypersphere forcing conditions, by its abstract; no bearing on `ℚ⁴`. Not held.'),
]
newC3 = ['| %s | %s |' % x for x in listing]

# 2.4 § B rows
def a_cells(prefix):
    ls_ = lines_of(B)
    idx = [i for i, l in enumerate(ls_) if l.startswith(prefix)]
    assert len(idx) == 1, prefix
    c = ls_[idx[0]].split(' | ')
    assert len(c) == 5, prefix
    return c[4][:-2]
bfiles = [
 ('pdf/BauJohnsonNoble2021-single-distance-graphs-rational-points-cmb-64-13-24.pdf', 'BauJohnsonNoble2021', a_cells('| **[BauJohnsonNoble2021]** | S. Bau')),
 ('pdf/arXiv-2607.00404-minac-nguyen-tan-sums-of-units-finite-rings.pdf', 'MinacNguyenTan2026', a_cells('| **[MinacNguyenTan2026]**')),
 ('pdf/arXiv-2610.09474-davidson-monomial-cayley-graphs-one-parameter.pdf', 'Davidson2026', "Read: the abstract, the introduction's statement of results, Conjectures 4.3 and 4.7, Corollary 4.6 and § 5's programme (2026-10-13, from a text extraction; FS131-PN1); the proofs unread"),
 ('pdf/arXiv-2610.21940-enami-matsushita-cayley-abelian-circular-colorings.pdf', 'EnamiMatsushita2026', a_cells('| **[EnamiMatsushita2026]**')),
 ('pdf/arXiv-1102.0120-barroero-frei-tichy-additive-unit-representations-survey.pdf', 'BarroeroFreiTichy2011', a_cells('| **[BarroeroFreiTichy2011]**')),
 ('pdf/schinzel-1969-remarque-sur-le-travail-de-nagell-acta-arith15-245-246.pdf', 'Schinzel1969', a_cells('| **[Schinzel1969]**')),
 ('pdf/nagell-1969-sur-les-diviseurs-premiers-des-polynomes-acta-arith15-235-244.pdf', 'Nagell1969', a_cells('| **[Nagell1969]**')),
]
newB = ['| `%s` | `[%s]` | %s |' % x for x in bfiles]

# insert rows
t_ = get(B)
anchor = "\n\n### A′. Retired and alternate keys"
assert t_.count(anchor) == 1
files[B] = t_.replace(anchor, "\n" + "\n".join(newA + newA2 + newA3) + anchor); log.append('new § A rows (%d)' % len(newA + newA2 + newA3))
t_ = get(B)
lisu = [l for l in t_.split('\n') if l.startswith('| `pdf/arXiv-2610.15424-li-su-every-n-points-no-unit-distance-m1.pdf` |')]
assert len(lisu) == 1
files[B] = t_.replace(lisu[0], lisu[0] + "\n" + "\n".join(newB)); log.append('new § B rows (%d)' % len(newB))
t_ = get(B)
lastc = [l for l in t_.split('\n') if l.startswith('| arXiv:math/0511147 *Planar coincidences for N-fold symmetry*')]
assert len(lastc) == 1
nxt = t_.index(lastc[0]) + len(lastc[0])
assert t_[nxt:nxt+2] == '\n\n', repr(t_[nxt:nxt+30])
files[B] = t_[:nxt] + "\n" + "\n".join(newC + newC3) + t_[nxt:]; log.append('new § C rows (%d)' % len(newC + newC3))

for f, txt in files.items():
    pathlib.Path(f).write_text(txt)
print('OK', len(log), 'edits:'); print('\n'.join(log))
print('\nNEW § A ROWS:'); print('\n'.join(r[:200] for r in newA + newA2 + newA3))
print('\nNEW § C ROWS:'); print('\n'.join(r[:200] for r in newC + newC3))
print('\nNEW § B ROWS:'); print('\n'.join(r[:200] for r in newB))
