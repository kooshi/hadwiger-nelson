"""J24 stage 3: apply M1, M2 and M3's CLAUDE.md drafts, renumbered (rows 98-110, G77/G78, items 26/27, FS-92..96), with the
compositions the closes left to the front page (the Last-updated line, the open-milestones line, the re-rank, G72's ordinals,
the ledger range) and the owner's rulings (the five Do/killing-test drafts applied; G55's tag untouched, D-8 in the body; G63's
tag as drafted). Drafts are read from their sources (M1's script, M2's plan blocks, M3's plan block), never retyped.
Run: python3 data/crunch-2026-09-25/j24/claude_apply.py [--dry] [--plant]   (--plant corrupts one anchor; must exit 1)"""
import re, sys, types
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
DRY = '--dry' in sys.argv or '--plant' in sys.argv
errors = []
def renum(s):
    s = re.sub(r'(?<![A-Za-z0-9_₀-₉])N([1-5])(?![0-9])', lambda m: str(97 + int(m.group(1))), s)
    s = re.sub(r'\bnext-([a-e])\b', lambda m: str(103 + 'abcde'.index(m.group(1))), s)
    s = re.sub(r'rows next–next\+2', 'rows 108–110', s)
    s = re.sub(r'(rows? )next\+2\b', r'\g<1>110', s); s = re.sub(r'(rows? )next\+1\b', r'\g<1>109', s)
    s = re.sub(r'(rows? )next\b(?![-+–])', r'\g<1>108', s)
    s = re.sub(r'FS-M1a', 'FS-92', s); s = re.sub(r'FS-M1b', 'FS-93', s); s = re.sub(r'FS-M1c', 'FS-94', s)
    return s
# ---- M1: its (old, new) list, from its own script
src = (ROOT / 'data/fs91/j23a/claude_md_drafts.py').read_text().split('if "--render" in sys.argv:')[0]
ns = {'sys': sys}; exec(src, ns); E1 = [(o, renum(n)) for o, n in ns['E']]
assert len(E1) == 33, len(E1)
# ---- M2: its blocks, parsed by its own parser
spec = (ROOT / 'data/m2/j23b/claude_md_drafts.py').read_text()
m2 = types.ModuleType('m2'); m2.__file__ = str(ROOT / 'data/m2/j23b/claude_md_drafts.py'); exec(spec.rsplit('\nmain()', 1)[0], m2.__dict__)
D2 = m2.parse((ROOT / 'plans/M2-kernel-lane.md').read_text())
D2 = {did: (op, {k: renum(v) if k == 'new' else v for k, v in b.items()}) for did, op, b in D2}
assert len(D2) == 23, len(D2)
# ---- M3: its block
P3 = (ROOT / 'plans/M3-exotic-colourings.md').read_text()
blk = P3.split('<!-- M3-CLAUDE-DRAFT-BEGIN -->')[1].split('<!-- M3-CLAUDE-DRAFT-END -->')[0]
def grab(a, b):
    s = blk.index(a); e = blk.index(b, s) + len(b); return blk[s:e]
m3_item = renum(grab("**Rank one at four colours, and windows at five over ℚ(√167)**", "nothing touches `χ_µ(ℝ²)`."))
m3_g = renum(grab("* **G77 — Rank-one inheritance", "they forbid a Kempe proof of the frozen case.*")).replace('G77', 'G78')
m3_g76 = renum(grab('"**At five colours over ℚ(√167)**', "it is `χ_B(ℝ²)`'s.\"")[1:-1])
m3_g50 = renum(grab('"**M3\'s:** `[Zhang2012]`', 'went unsearched."')[1:-1])
m3_g30 = grab('"→ descriptive set theory', 'entered at M3)"')[1:-1]
m3_76 = renum(grab('"**At M3\'s close:** rank one reduced', 'rank-one-walls stub."')[1:-1]).replace('the new\n  rank-one-walls stub', 'FS-95').replace('the new rank-one-walls stub', 'FS-95')
m3_69 = grab('"also decides the finite-place windows', 'M3)."')[1:-1]
m3_item = m3_item.replace('(G77)', '(G78)')
def one(s): return ' '.join(s.split())
m3_item, m3_g, m3_g76, m3_g50, m3_g30, m3_76, m3_69 = map(one, (m3_item, m3_g, m3_g76, m3_g50, m3_g30, m3_76, m3_69))
# ---- the text, and the editing primitives
C = (ROOT / 'CLAUDE.md').read_text(); C0 = C
def rep(old, new, tag):
    global C
    n = C.count(old)
    if n != 1: errors.append(f'{tag}: anchor occurs {n}: {old[:70]!r}'); return
    C = C.replace(old, new)
def after(anchor, new, tag): rep(anchor, anchor + new, tag)
sizes = []
# ================= M1 =================
E1_by = {i + 1: e for i, e in enumerate(E1)}
LAST = ("*Last updated: 2026-09-25 — **the 2026-09-25 crunch closed its three milestones** (rows 98–110; G77, G78 minted; G21, G30, G35, "
  "G48, G50, G55, G61, G63, G64, G67, G71, G72, G74, G75, G76 edited): **FS-91 (M1)** — band rigidity at every band, the class theorem for "
  "character colourings at existence scope, the character chromatic numbers at the exposed fields, one prime failing three ways, and three "
  "colours over every real number field; **Paid (theorem)**, O1 at a prior of 0.30 (`plans/FS91-character-local-global.md` §R-close); "
  "**M2** — the kernel lane: FS-45's chain theorem, FS-39's route C and conditional bridge, FS-47's prime inversion in valuation form, FS-87's "
  "stripe lemma; **Paid (kernel)** (`plans/M2-kernel-lane.md` §R-close); **M3** — FS-76 in rank one reduced and **not landed**, FS-64 at five "
  "colours over ℚ(√167) **landed in part** (the mixing selection; windows reduced to nine places) (`plans/M3-exotic-colourings.md` §R-close).")
o, n = E1_by[1]; E1_by[1] = (o, LAST)
PRE = ("(re-ranked 2026-09-25 at the crunch's close (M1–M3), one rank per row: FS-91 and FS-82 closed, FS-83 answered; FS-92 to FS-96 minted; "
  "FS-39 moved below FS-68, FS-69 up one; FS-39, FS-45, FS-47, FS-48, FS-59, FS-64, FS-69, FS-75, FS-76, FS-87 re-aimed; G77, G78 forwarded.")
o, n = E1_by[11]; E1_by[11] = (o, PRE)
# C8: items 25-26, then M3's item 27
o, n = E1_by[8]; E1_by[8] = (o, n + '\n27. ' + m3_item.replace('**Rank one', '**Rank one', 1).replace(' (rows 108–110; M3', ' (rows 108–110, G78; M3', 1))
# C17: FS-64's row end — M3's five-colour windows replace "a five-colour window over ℚ(√167) is untouched"
o, n = E1_by[17]
n = n.replace('; a five-colour window over ℚ(√167) is untouched |',
  '; **at M3\'s close** five-colour windows over ℚ(√167) are excluded off 43 with no real place, and the rest reduces to nine places (row 110; FS-96) |', 1)
n = n.replace('| — | **FS-92 character', '| — | **FS-96 windows at the non-mixing places** — `plans/STUB-windows-five-nonmixing.md` (minted at M3\'s close) | D2 at seven places, the null-set step; FS-64 at five colours over ℚ(√167) after row 110 | speculative |\n| — | **FS-92 character', 1)
E1_by[17] = (o, n)
# C19 is merged into M2's D-17 (both rewrite FS-47's row)
del E1_by[19]
# C21: the stable range covers G78 too
o, n = E1_by[21]; E1_by[21] = (o, 'G1–G78 are stable')
# C31: G76's body, then M3's sentence (M3 R4.G: "before its Do"; placed in the body after the rigidity sentence)
o, n = E1_by[31]; E1_by[31] = (o, n + ' ' + m3_g76)
# C33: G77, then M3's G78, before G51
o, n = E1_by[33]; E1_by[33] = (o, n.replace('* **G51 — A competitor', m3_g + '\n* **G51 — A competitor', 1))
if '--plant' in sys.argv: E1_by[2] = (E1_by[2][0] + 'PLANTED', E1_by[2][1])
for i in sorted(E1_by):
    o, n = E1_by[i]; rep(o, n, f'M1 C{i}')
# M3 in the prior-art position (with M1's C9, C10 text in place)
rep("and one prime's three failures (rows 99–102);", "and one prime's three failures (rows 99–102); rank one at four colours reduced to single colourings, the mixing selection and the windows at five over ℚ(√167) (rows 108–110);", 'M3 ours')
rep("the regular chromatic number (`[BarajasSerra2008]`);", "the regular chromatic number (`[BarajasSerra2008]`); the mixing selection's complete-graph case (Burr–Erdős–Lovász, `[Tardif2008]` Thm 3.2) and its threshold beside `K_k` (`[PakVilenchik2013]`); the ratio-only counterexample (`[Zhu2021]` Thm 3); one-dimensional SFT facts (Lind–Marcus);", 'M3 not ours')
sizes.append(('M1 (+ M3 items folded above)', len(C.encode()) - len(C0.encode())))
C1 = C
# ================= M2 =================
skip = {'D-4', 'D-4b', 'D-5', 'D-8', 'D-11'}   # composed here: the open line, the Last-updated line, G55's body sentence, G72's count
for did, (op, b) in D2.items():
    if did in skip: continue
    new = b.get('new', '')
    if did == 'D-1':  # keep gate_report.py's regex readable: "current audit reads N clean and M declared purchases"
        new = 'current audit reads 1130 clean and 5 declared purchases (and 11 axiom-free; 1,146 records at M2\'s close), each listed'
    if did == 'D-9b':  # keep the prior art's statement and proof method, and the route's full name (nothing from before lost)
        a = 'Nothing here is ours but the kernel forms.'
        if new.count(a) != 1: errors.append('D-9b anchor')
        new = new.replace(a, '`[Fischer1990]` Theorem 6 is the statement for every dimension and for additive colourings too ("`F^d` can be k-colored iff `F(α)^d` can"), proved by writing a unit vector over `F[x]` without common factor and setting `x = 0`. ' + a)
        bb = 'Tarski\'s equational\n  existential fragment'
        if new.count(bb) != 1: errors.append('D-9b Tarski')
        new = new.replace(bb, 'the equational\n  existential fragment of Tarski–Seidenberg')
    if did == 'D-17':  # merged with M1's C19
        new = new.replace('with the chain theorem in ring form. Left:', 'with the chain theorem in ring form; **re-aimed at FS-91\'s close:** the statement is Lemma C/C′ (row 100), `ℤ[U_F] = O′` with no Galois hypothesis off a ramified stable dyadic place, prime inversion a corollary. Left:', 1)
        if 'Lemma C/C′' not in new: errors.append('D-17 merge')
    if op == 'replace': rep(b['old'], new, did)
    elif op == 'after': after(b['after'], new, did)
    elif op == 'span':
        s = C.find(b['start']); e = C.find(b['end'], s)
        if s < 0 or e < 0 or C.count(b['start']) != 1: errors.append(f'{did}: span'); continue
        C = C[:s] + new + C[e + len(b['end']):]
    elif op == 'line':
        ls = C.split('\n'); ix = [i for i, l in enumerate(ls) if l.startswith(b['line'])]
        if len(ix) != 1: errors.append(f'{did}: line prefix occurs {len(ix)}'); continue
        ls[ix[0]] = new; C = '\n'.join(ls)
# D-8 as ruled: G55's tag untouched; the sentence first in the body, updating the tag's clause
after('every result below is a kernel target, FS-45–48 (Kooshi, 2026-09-14)]**',
  ' Of these kernel targets, in the kernel since M2: the chain theorem and its ring form (`1/δ ∈ ℤ[U_F]`), prime inversion in valuation form, the ℚ(√2,√3) lower bound and the `K(√7)` implication (rows 103, 105); the rest named at M2\'s close remain targets — prime inversion\'s number-field reading (row 57\'s gap), `G4`\'s certificate, `χ(ℚ(√2,√3)²) ≤ 4`, the vertex bound `m(n − 1) + 1`, the two-colour classification.', 'D-8 body')
# the open-milestones line (M2 D-4/D-4b composed with M1's and M3's closes)
OPEN_OLD = ("**Three are open, as the 2026-09-25 crunch** (queue `plans/CRUNCH-2026-09-25-queue.md`; index `plans/CRUNCH-2026-09-25-INDEX.md`, "
  "which carries results and which blind verifiers do not open; none of the crunch's work enters this file before its milestone closes): **M1** = "
  "FS-91 (`plans/FS91-character-local-global.md`); **M2** = the kernel lane, FS-45, FS-39, and FS-87 or FS-47 (`plans/M2-kernel-lane.md`); **M3** "
  "= FS-76 in rank one and FS-64 at five colours (`plans/M3-exotic-colourings.md`).")
OPEN_NEW = ("**None is open.** **The 2026-09-25 crunch closed its three milestones** (queue `plans/CRUNCH-2026-09-25-queue.md`; index "
  "`plans/CRUNCH-2026-09-25-INDEX.md`): **M1 = FS-91 — CLOSED** (rows 98–102, G77; `plans/FS91-character-local-global.md`, its §R-close first; "
  "`plans/FS91-derivation.md`; the stub `plans/STUB-band-rigidity-six.md` carries the banner, and with it FS-82 closed, `plans/STUB-three-colours-residue-degree-three.md`, and FS-83 answered for falsifiers, `plans/STUB-layer-method-five-colours.md`); **M2 — the kernel lane (FS-45, FS-39, FS-87, FS-47) — CLOSED** (rows 103–107; `plans/M2-kernel-lane.md` §R-close; "
  "the kernel register `plans/M2-derivation.md`); **M3 — FS-76 in rank one and FS-64 at five colours — CLOSED** (rows 108–110, G78; "
  "`plans/M3-exotic-colourings.md` §R-close; `plans/M3-derivation.md`).")
rep(OPEN_OLD, OPEN_NEW, 'open line')
sizes.append(('M2', len(C.encode()) - len(C1.encode())))
C2 = C
# ================= M3 (the rest) and the compositions =================
rep('unentered: commutative algebra, FS-10)', m3_g30.replace(' (Borel and measurable combinatorics, entered at M3)', ' (Borel and measurable combinatorics, entered at M3, rows 109–110)') + '; unentered: commutative algebra, FS-10)', 'M3 G30')
rep(' *Do: scan, at the opening', ' ' + m3_g50 + ' *Do: scan, at the opening', 'M3 G50')
G72_ANCHOR = "**Sixth (FS-89):** §IQ posed Berend's MT/ID property modulo the isometric direction; row 95 is that property: **six of six**."
after(G72_ANCHOR, (" **Seventh (FS-91):** the class theorem through the structural question — the peel on the value-set profile — and no mixing at "
  "`k = 3` with it; band rigidity at every band by extending a known tool: **seven of seven**. **Eighth (M2):** its one derivation, the bridge "
  "(J17), through the structural question — a ring hom into `ℝ_alg` is Artin–Lang — with a classical answer; the kernel ports are outside the "
  "count: **eight of eight**. **Ninth (M3):** both questions through the structural form; Q2's invariant found (the fibre's classes above the "
  "mixing threshold), Q1's not (FW rules out every Kempe invariant): **nine of nine**."), 'G72')
# FS-76 and FS-69 rows (question cells)
ls = C.split('\n')
for key, add in (('| 8 | **FS-76 four colours', ' ' + m3_76), ('| 30 | FS-69 the all-levels', '; ' + m3_69)):
    ix = [i for i, l in enumerate(ls) if l.startswith(key)]
    if len(ix) != 1: errors.append(f'row {key}'); continue
    cells = ls[ix[0]].split(' | '); cells[2] = cells[2].rstrip() + add; ls[ix[0]] = ' | '.join(cells)
# FS-95 row after FS-76's
ix = [i for i, l in enumerate(ls) if l.startswith('| 8 | **FS-76 four colours')]
if ix: ls[ix[0] + 1:ix[0] + 1] = ['| — | **FS-95 rank-one walls** — `plans/STUB-rank-one-walls.md` (minted at M3\'s close) | frozen walls, `D ⊇ {1,2}`, the completion route (row 108) | none |']
C = '\n'.join(ls)
rep('**Rows 1–94 live in `LEDGER.md`**', '**Rows 1–110 live in `LEDGER.md`**', 'ledger range')
sizes.append(('M3 (the rest) + compositions', len(C.encode()) - len(C2.encode())))
# ================= one home per fact: rewordings where a new entry retold a ledger line word for word (--dupes) =================
rep("the archimedean part vanishes at complex places and is an interval about 0 at real ones;",
    "its archimedean part is zero at each complex place and an interval about 0 at each real one;", 'dupe G77 a')
rep("and a sum of symmetric subsets of the circle inside the band keeps **some** summand inside it.",
    "and when symmetric subsets of the circle add up inside the band, **some** one of them already lies in it (the peeling lemma).", 'dupe G77 b')
rep("Nothing kills the theorem but a defect in its chain; it forbids a character colouring with fewer",
    "Nothing kills it but a flaw in the derivation; it forbids a character colouring with fewer", 'dupe G77 c')
rep("In an all-rigid shift periodic points are gap-free with two-sided strands and the Kempe class of a wall point keeps its tails in different labelled phases;",
    "In an all-rigid shift the periodic points are gap-free with two-sided strands, and Kempe moves never bring a wall point's two tails into one labelled phase;", 'dupe G78')
rep("is *a countable four-colouring shift of a distance graph on ℤ is finite*,", "is *countable ⟹ finite* for four-colouring shifts of distance graphs on ℤ,", 'dupe item 27')
_m = re.findall(r"`ℚ\(π, √\(π³ − π\)\)` embeds\s+in no purely transcendental extension of any number field", C)
if len(_m) != 1: errors.append(f'dupe G63: {len(_m)}')
else: C = C.replace(_m[0], "`ℚ(π, √(π³ − π))` lies in no purely transcendental extension of any number field")
# ================= the re-rank =================
ORDER = ['59', '90', '84', '75', '80', '76', '95', '87', '67', '64', '96', '92', '48', '78', '77', '88', '72', '55', '45', '63', '93', '94',
         '60', '47', '46', '68', '39', '43', '49', '65', '69', '57', '62', '41', '20', '13', '27', '30', '8', '9']
ls = C.split('\n')
h = [i for i, l in enumerate(ls) if l.startswith('| rank | stub | the question | bearing on χ ≥ 6 |')]
if len(h) != 1: errors.append('table header')
else:
    s = h[0] + 2; e = s
    while e < len(ls) and ls[e].startswith('|'): e += 1
    body = ls[s:e]; byk = {}
    for l in body:
        m = re.match(r'^\| [^|]* \| (?:\*\*)?FS-(\d+)', l)
        if not m: errors.append(f'unkeyed row {l[:60]}'); continue
        if m.group(1) in byk: errors.append(f'FS-{m.group(1)} twice')
        byk[m.group(1)] = l
    if sorted(byk) != sorted(ORDER): errors.append(f'table keys {sorted(set(byk) ^ set(ORDER))}')
    out, r = [], 1
    for k in ORDER:
        l = byk.get(k, '');
        if not l: continue
        span = re.match(r'^\| ([^|]*) \|', l).group(1).strip()
        width = 1
        if re.match(r'^\d+–\d+$', span): a, b = map(int, span.split('–')); width = b - a + 1
        lab = str(r) if width == 1 else f'{r}–{r + width - 1}'
        out.append('| ' + lab + ' |' + l[len('| ' + span + ' |'):]); r += width
    ls[s:e] = out; C = '\n'.join(ls)
    if r - 1 != 55: errors.append(f'ranks end at {r - 1}')
if errors:
    print('ERRORS:'); [print(' ', x) for x in errors]; sys.exit(1)
print('net by stage:', sizes, '| total', len(C.encode()) - len(C0.encode()), '| CLAUDE.md', len(C0.encode()), '->', len(C.encode()))
if len(C.encode()) >= 300000: print('OVER BUDGET'); sys.exit(1)
if not DRY: (ROOT / 'CLAUDE.md').write_text(C)
