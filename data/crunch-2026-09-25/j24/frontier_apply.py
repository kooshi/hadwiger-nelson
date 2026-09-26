"""J24 stage 4: plans/FRONTIER-STUBS.md — the open line, the re-rank preamble, the re-aimed rows (M1 4.5-4.6, M2 4d, M3 R4.F and
R5.1, J29), the five new rows, the three deleted rows, the ranks renumbered (55 rows), the closed list. Every anchor exactly once.
Run: python3 data/crunch-2026-09-25/j24/frontier_apply.py [--dry] [--plant]"""
import re, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
DRY = '--dry' in sys.argv or '--plant' in sys.argv
F = ROOT / 'plans/FRONTIER-STUBS.md'; T = F.read_text(); T0 = T
errors = []
def rep(old, new, tag):
    global T
    n = T.count(old)
    if n != 1: errors.append(f'{tag}: anchor occurs {n}: {old[:70]!r}'); return
    T = T.replace(old, new)
# ---- the open line
OLD = ("**The 2026-09-25 crunch holds three milestones open:** M1 = FS-91 (rank 2 below; `plans/FS91-character-local-global.md`), M2 = the kernel "
       "lane (FS-45, FS-39, and FS-87 or FS-47; `plans/M2-kernel-lane.md`), M3 = FS-76 in rank one and FS-64 at five colours "
       "(`plans/M3-exotic-colourings.md`); queue `plans/CRUNCH-2026-09-25-queue.md`, index `plans/CRUNCH-2026-09-25-INDEX.md` (it carries results; "
       "blind verifiers do not open it).")
if '--plant' in sys.argv: OLD += 'PLANTED'
NEW = ("**No milestone is open.** **The 2026-09-25 crunch closed its three milestones** (queue `plans/CRUNCH-2026-09-25-queue.md`, index "
       "`plans/CRUNCH-2026-09-25-INDEX.md`): **M1 = FS-91 — CLOSED** (`LEDGER.md` rows 98–102; G77; FS-82 closed and FS-83 answered with it; "
       "FS-92, FS-93, FS-94 minted; the closed list; `plans/FS91-character-local-global.md` §R-close, `plans/FS91-derivation.md`), **Paid "
       "(theorem)**, O1 at a prior of 0.30; **M2 — the kernel lane — CLOSED** (`LEDGER.md` rows 103–107; `plans/M2-kernel-lane.md` §R-close; "
       "`plans/M2-derivation.md`): FS-39, FS-45, FS-47 and FS-87 re-aimed, none closed, **Paid (kernel)**; **M3 — FS-76 in rank one and FS-64 "
       "at five colours — CLOSED** (`LEDGER.md` rows 108–110; G78; FS-95, FS-96 minted; `plans/M3-exotic-colourings.md` §R-close, "
       "`plans/M3-derivation.md`): Q1 **not landed**, Q2 **landed in part**.")
rep(OLD, NEW, 'open line')
# ---- the re-rank preamble and the crunch pointer line
PRE_ANCHOR = "*Re-ranked 2026-09-25 at FS-89's close, one rank per row."
rep(PRE_ANCHOR, ("*Re-ranked 2026-09-25 at the crunch's close (M1–M3), one rank per row. **Closed:** FS-91 (rows 98, 100–102), FS-82 (row 99); "
  "**answered for falsifiers:** FS-83 (row 100; its remainder to FS-92); the closed list. **Minted:** FS-92 (character classification, rank 12), "
  "FS-93 (band rigidity from the pyjama theorem, 21), FS-94 (one-prime minimal sets, 22) at M1's close; FS-95 (rank-one walls, 7), FS-96 "
  "(windows at the non-mixing places, 11) at M3's. **Re-aimed:** FS-59, FS-64, FS-75, FS-47, FS-48, FS-46, FS-84 (M1: rows 99–101); FS-39, FS-45, "
  "FS-47, FS-87 (M2: rows 103–107); FS-76, FS-64, FS-59, FS-49, FS-69, FS-67 (M3: rows 108–110); FS-80 and FS-84 (J29). **Moved:** FS-39 from 20 "
  "to 27, below FS-68 (M2's proposal: what is left is B2, months, and a reading); FS-69 up one, beside FS-65 and FS-57 (two consumers now). "
  "The earlier re-rank's paragraph follows.*\n\n" + PRE_ANCHOR), 'preamble')
rep("*Stubs with unfolded 2026-09-25 crunch work carry a closing section \"Where the 2026-09-25 work on this lives\":",
    "*The 2026-09-25 crunch's work is folded in at its three closes; the closing sections \"Where the 2026-09-25 work on this lives\" stay as addresses in:", 'pointer')
# ---- the table
ls = T.split('\n')
h = [i for i, l in enumerate(ls) if l.startswith('| rank | stub | the question |')]
assert len(h) == 1
s = h[0] + 2; e = s
while e < len(ls) and ls[e].startswith('|'): e += 1
rows = {}
for l in ls[s:e]:
    m = re.match(r'^\| \d+ \| (?:\*\*)?FS-(\d+)', l)
    if not m: errors.append(f'unkeyed {l[:50]}'); continue
    rows[m.group(1)] = l.split(' | ')
def cell(k, i, fn, tag):
    if k not in rows: errors.append(f'{tag}: FS-{k} missing'); return
    c = rows[k]; last = (i == 6)
    v = c[i][:-2].rstrip() if last else c[i]
    v2 = fn(v)
    if v2 is None: errors.append(f'{tag}: edit failed'); return
    c[i] = v2 + (' |' if last else '')
def app(txt): return lambda v: v.rstrip() + ' ' + txt
def pre(txt): return lambda v: txt + ' ' + v
def sub(a, b):
    def f(v):
        if v.count(a) != 1: return None
        return v.replace(a, b)
    return f
Q, B, CO, ST, SO = 2, 3, 4, 5, 6
# FS-59 (M1 4.5; M3 R4.F)
cell('59', Q, app("**At FS-91's close:** given CLG_7, `χ_char(ℚ(√167)²) = 8` (row 101; unconditionally `6 ≤ χ_char ≤ 8`): no character colouring with five, six or seven colours exists, so any colouring with fewer than eight colours — and any falsifier of \"≥ 6\" — is one no character gives; the known bracket is `4 ≤ χ ≤ 7`. **At M3's close:** window five-colourings over finitely many places reduced to nine places (row 110); a five-colouring no window gives is untouched."), 'FS-59')
cell('59', ST, app("; re-aimed at the M1 and M3 closes (2026-09-25)"), 'FS-59 st')
# FS-84 (M1 4.5; J29)
cell('84', Q, app("**At FS-91's close:** no character four-colouring, now through the class theorem with no certificate (C-47, row 100), and at every `L = 5` field by CLG-g's (g1). **J29's reframe** (`plans/FS84-five-colours-47.md`): the survivors' `Θ₄` cell analysis can only colour a survivor (G71, row 96); a refusal needs a finite graph or a four-class averaged certificate; `χ(ℚ(√47)²) = 5` answers Soifer 55.1 and Moorhouse's ℚ(√47) question."), 'FS-84')
cell('84', ST, app("; planned 2026-09-25 (`plans/FS84-five-colours-47.md`, J29; its stages run from 2026-10-01)"), 'FS-84 st')
# FS-75 (M1 4.5)
cell('75', Q, pre("**Re-aimed at FS-91's close:** S1 over every real number field (J02-T2's chain: J02-L1, L2, L3, L4(a) and a finite sumset) and no mixing (FS91-J09-J4) in the kernel (row 99) — every leaf finite algebra plus one character-sum bound (Weil above 243, exact below), with FS81-T2 and FS73-T22's ⟹ as the named hand inputs; fallback, a checker for ℚ(α,√7)'s prime data (FS91-J02-C1) and FS-81's census certificates. *The earlier aim:*"), 'FS-75')
cell('75', ST, app("; re-aimed at FS-91's close"), 'FS-75 st')
# FS-80 (J29)
cell('80', Q, app("ℚ(√47) is a target beside ℚ(√167) (its fractional cap `121/28 > 4`; J29, `plans/FS84-five-colours-47.md`)."), 'FS-80')
# FS-76 (M3)
cell('76', Q, app("**At M3's close:** rank one reduced to single colourings (row 108), open at FW and KT; frozen walls → FS-95."), 'FS-76')
cell('76', ST, app("; re-aimed at M3's close"), 'FS-76 st')
# FS-87 (M2 4d)
cell('87', Q, pre("**Target 1, the stripe lemma, is in the kernel (M2; `Stripe.lean`, `striped_of_proper_nt0`; row 106) — 17 minutes, 447 lines with controls; the triangle condition enters once, properness does the rest.** Next: dB9's V1 (target 2), then the checker for Parts's nine trees (target 3)."), 'FS-87')
cell('87', CO, lambda v: "hours (targets 2–3, priced from target 1's rate); weeks (W)", 'FS-87 co')
cell('87', ST, app("; target 1 in the kernel at M2's close"), 'FS-87 st')
# FS-67 (M3 R5.1)
cell('67', Q, app("**At M3's close:** for maps *into the Moser spindle* the answer is yes in print (`[TardifWrochna2019]` Thm 2, strong multiplicativity; found by M3's prior-art reader, `plans/M3-PA-mixing.md` Stage 2)."), 'FS-67')
# FS-64 (M1 4.5; M3 R4.F)
cell('64', Q, sub("a window over several places at five colours is still untouched.",
    "**At FS-91's close:** a single character needs eight colours over ℚ(√167) given CLG_7 (row 101), so the one-place windowless case is closed at five, six and seven. **At M3's close:** five-colour windows over ℚ(√167) excluded off 43 with no real place; the rest reduces to nine places (row 110) → FS-96; the mixed window — several places, non-linear readings — is the remaining question."), 'FS-64')
cell('64', B, app("— the finite-place half at five over ℚ(√167) is now a theorem off 43; the live part is the nine places (FS-96)"), 'FS-64 b')
cell('64', ST, app("; re-aimed at the M1 and M3 closes"), 'FS-64 st')
# FS-48 (M1 4.5)
cell('48', Q, pre("**Re-aimed at FS-91's close:** three colours are decided for every multiquadratic (indeed every real number) field: `χ = 3` iff non-bipartite and some prime above 3 has residue field `𝔽₃` (row 99); what remains is the four- and five-colour table. *Earlier:*"), 'FS-48')
cell('48', ST, app("; re-aimed at FS-91's close"), 'FS-48 st')
# FS-45 (M2 4d)
cell('45', Q, pre("**D1–D3 in the kernel (M2; row 103):** the chain theorem over the graph induced on the chain's point set, four forms and a ring form; `χ(ℚ(√2,√3)²) ≥ 4` with the 18-vertex refusal as a second oracle by the gadget algebra (no LRAT); `G4 → χ(K(√7)²) ≥ 5`. **Left:** phase C's certificate, a fresh LRAT of the 588-core's refusal fed as its core — a solver run, so **after 2026-10-01** — then the unconditional `K(√7)` bound; `χ(ℚ(√2,√3)²) ≤ 4` by the dyadic residue colouring; G55's vertex bound. *The original aim:*"), 'FS-45')
cell('45', CO, lambda v: "post-ban: a solver run plus a core replay (row 67's recipe); the upper bound about a day", 'FS-45 co')
cell('45', ST, app("; D1–D3 in the kernel at M2's close"), 'FS-45 st')
cell('45', SO, lambda v: "SAT after 2026-10-01", 'FS-45 so')
# FS-39 (M2 4d; M1 4.5)
cell('39', Q, lambda v: (v[:v.index(', through `normOne_subset_valuationSubring`')] + ". **In the kernel (M2):** B′ route C (row 104; the lemma is `[Madore2015]` Prop. 3.2 at `d = 2`); B0 (`ℝ`, `ℝ_alg` real closed), B1 and C (C1, C2 attained, C4) conditional on `RealAlgebraicDescent` (row 107); NP, C3, C3⁺. The bridge is `[Madore2015]` ¶5.4's (Tarski); the gate ran (J04, J17: nothing else in print; `[BendaPerles2000]` unread). **Left:** B2, `(∃T)` in the kernel — months; the Benda–Perles read; Q-const (G63); `χ(ℚ²) = 2` in the kernel (row 63), on which `χ(ℚ(L)²) = 2` and J17-T8 wait. **At FS-91's close:** S1 holds for every algebraic `F ⊆ ℝ` and every purely transcendental extension of one, with `L(F)` read over all `c`-stable valuation rings (row 99); a general transcendental `F` meets this stub's gap.") if v.count(', through `normOne_subset_valuationSubring`') == 1 and v.rstrip().endswith('Prior-art gate owed') else None, 'FS-39')
cell('39', B, app("; every `χ(ℝ²)` sentence now cites a kernel theorem with one named hypothesis"), 'FS-39 b')
cell('39', CO, lambda v: "B2 months; the rest done", 'FS-39 co')
cell('39', ST, app("; re-aimed at M2's close and moved below FS-68"), 'FS-39 st')
# FS-47 (M2 4d; M1 4.5)
cell('47', Q, pre("**D3 in valuation form and D5's `3/8` are in the kernel (M2; row 105)** — Chevalley's domination in place of lying-over, so no number field; the chain theorem in ring form. **Re-aimed at FS-91's close:** the statement is Lemma C/C′ with no Galois hypothesis (row 100; FS91-J07-3, J07-4, J02-L2, J10-L1): `ℤ[U_F] = O′`, the ring integral at the stable primes, except possibly at a ramified stable dyadic place (which occurs at ℚ(√5), ℚ(√17), ℚ(α)); prime inversion is its corollary. **Left:** the number-field reading (row 57's gap — the one lemma under Theorem A's field form and ASTRA T7 beyond `K(√7)`; with FS-37), Lemma R at its corrected scope (FS-86's re-aim), D4, D6. *The original aim:*"), 'FS-47')
cell('47', CO, lambda v: "the number-field reading with FS-37; D4 about two days", 'FS-47 co')
cell('47', ST, app("; re-aimed at the M1 and M2 closes"), 'FS-47 st')
# FS-46 (M1 4.5)
cell('46', Q, app("**At FS-91's close:** superseded in scope by FS-75's re-aim — S1 now holds over every real number field, with or without √3 (row 99); Theorem 3.1's rhombus route remains a cheaper kernel instance for `√3 ∈ F`."), 'FS-46')
# FS-69 (M3)
cell('69', Q, app("**At M3's close:** it also decides the finite-place windows at five over ℚ(√167) (`B₁(43) < 369.8`, row 110)."), 'FS-69')
cell('69', B, app("; also the last gap in M3's finite-place window count"), 'FS-69 b')
# FS-49 (M3 R4.F)
cell('49', Q, app("**At M3's close:** its measurable analogue is posed in print — Mixon's 2018 criterion (Polymath16 fourth thread): a five-colour forced `{1,2}`-vertex at an irrational angle proves `χ_µ(ℝ²) ≥ 6`; windows over finitely many places of ℚ(√167) cannot supply it from thick places (row 110)."), 'FS-49')
# new rows
NEWROWS = {
 '92': ["| 0", "**FS-92 character colourings: classification and CLG-g's exception** — `plans/STUB-character-classification.md` (minted at FS-91's close)",
        "Is every band `k`-character of a real number field's unit-vector ring, `k ≥ 4`, one stable place's pullback plus an archimedean part? The class theorem (row 100) is an existence statement; the classification is proved at `k = 3` (no mixing, row 99) and at HD1's fields (row 96), open elsewhere. Is CLG-g's exception ever realised — a band 6- or 7-character above level one of a `U₆₄` tower, or at level `2e + 1` above 3 at `q = 27`? Does (g3) hold at `e ≥ 2`?",
        "none directly; the shape a character falsifier of the conjecture would need", "a day per question; derivation", "minted at FS-91's close (M1 of the 2026-09-25 crunch)", "none (derivation) |"],
 '93': ["| 0", "**FS-93 band rigidity from the pyjama theorem** — `plans/STUB-pyjama-gluing.md` (minted at FS-91's close)",
        "Does band rigidity on `R_S` (row 98) follow from `[Manners2015]` Lemma 5.3 on the half rings by one gluing step? An effective `N_k` (`[KravitzLeng2025]`); density (Manners's Remark 5.4(i)); read Muchnik 2005, which decides whether row 98 is in print.",
        "none; attribution and effectivity", "the Muchnik read first (a fetch); the gluing a day", "minted at FS-91's close (from J23p's close gate, `plans/FS91-PA-close.md` §C.5)", "none (derivation) |"],
 '94': ["| 0", "**FS-94 one-prime minimal sets** — `plans/STUB-one-prime-minimal-sets.md` (minted at FS-91's close)",
        "The minimal sets of the one-prime band set off `T + A` (row 102): their dimension; are all of them of J12's S-adic kind; the band-1/5 analogue at one prime; the discretized-rotation literature (Bosio–Vivaldi, Vivaldi, Adler–Kitchens–Tresser, Akiyama–Pethő).",
        "none; mechanism", "open-ended; the literature read first", "minted at FS-91's close", "none (derivation) |"],
 '95': ["| 0", "**FS-95 rank-one walls** — `plans/STUB-rank-one-walls.md` (minted at M3's close)",
        "Frozen walls, the binary model for `D ⊇ {1,2}`, and the completion route: FS-76's rank-one reading R2 is open at FW and KT (row 108), and a frozen wall is invisible to every Kempe argument (G78).",
        "none", "the derivations days; the completion route's first step an exact enumeration a derivation fixes", "minted at M3's close (M3 of the 2026-09-25 crunch)", "none until 2026-10-01; then that enumeration (the owner's ruling) |"],
 '96': ["| 0", "**FS-96 windows at five colours at the non-mixing places** — `plans/STUB-windows-five-nonmixing.md` (minted at M3's close)",
        "D2 at the seven non-mixing finite places of ℚ(√167) and the null-set step (row 110): a window five-colouring over `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`; 43 at depth needs `B₁(43) < 369.8` (FS-69).",
        "speculative; the live part of FS-64 at five colours over the conjecture's widest gap", "derivations days; the `κ` questions finite, after 2026-10-01", "minted at M3's close", "none until 2026-10-01 |"],
}
for k, v in NEWROWS.items():
    if k in rows: errors.append(f'FS-{k} already present')
    rows[k] = v
for k in ('91', '83', '82'):
    if k not in rows: errors.append(f'FS-{k} missing'); continue
    del rows[k]
ORDER = '59 90 84 75 80 76 95 87 67 64 96 92 48 78 77 88 72 55 45 63 93 94 60 47 46 68 39 43 49 65 69 57 62 41 42 44 51 52 20 17 2 13 12 19 37 27 23 30 35 22 8 29 9 10 5'.split()
if sorted(ORDER) != sorted(rows): errors.append(f'order/rows differ: {sorted(set(ORDER) ^ set(rows))}')
out = []
for r, k in enumerate(ORDER, 1):
    c = list(rows[k]); c[0] = f'| {r}'; out.append(' | '.join(c))
ls[s:e] = out; T = '\n'.join(ls)
# ---- the closed list: three entries at its head
CL = "## Closed, absorbed and demoted\n"
rep(CL, CL + (
 "* **FS-91 band rigidity at six colours, and at one prime** — `plans/STUB-band-rigidity-six.md`. **Closed 2026-09-25** as M1 of the 2026-09-25 crunch "
 "(record `plans/FS91-character-local-global.md`, §R-close first; `plans/FS91-derivation.md`; close inventory `plans/FS91-close-inventory.md`; `LEDGER.md` rows 98, "
 "100–102; G77): band rigidity at every band (row 98), the class theorem for character colourings at existence scope (row 100), the character chromatic "
 "numbers (row 101), one prime failing three ways (row 102); **Paid (theorem)**, O1 at a prior of 0.30. Successors FS-92, FS-93, FS-94.\n"
 "* **FS-82 three colours at residue degree three** — `plans/STUB-three-colours-residue-degree-three.md`. **Closed 2026-09-25** at FS-91's close (row 99): "
 "for every real number field `χ(F²) = 3` iff non-bipartite with a prime above 3 of residue field `𝔽₃`; `χ(ℚ(α,√7)²) = 4`; the stub's banner corrects "
 "its dyadic-target sentence.\n"
 "* **FS-83 the layer method at four and five colours** — `plans/STUB-layer-method-five-colours.md`. **Answered for falsifiers 2026-09-25** at FS-91's close "
 "(row 100, CLG-g): a character `k`-colouring of a real number field's plane exists only if `L(F) ≤ k`, at every `k ≤ 5` and at every `k` over fields of "
 "degree ≤ 2; the remainder (CLG-g's exception; whether every character colouring is local) is FS-92's.\n"), 'closed list')
if errors:
    print('ERRORS:'); [print(' ', x) for x in errors]; sys.exit(1)
print(f'rows {len(out)}; FRONTIER-STUBS.md {len(T0.encode())} -> {len(T.encode())} bytes')
if not DRY: F.write_text(T)
