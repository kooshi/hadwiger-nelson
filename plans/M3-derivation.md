# M3 (crunch milestone, 2026-09-25) — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-25 at M3's close (WORKFLOW 2.0 step 9) by crunch job J23c (de Bruijn, Opus 5.5, M3's close planner), from the plan
(`plans/M3-exotic-colourings.md`, the planner J06) and the five job records: `plans/M3-S1A-rank-one.md` (J18), `plans/M3-S1B-rank-one.md`
(J19), `plans/M3-S1V-rank-one.md` (J20), `plans/M3-S1D-windows-five.md` (J21), `plans/M3-S1V-windows-five.md` (J22, resumed as J22b). **M3
is the crunch's third milestone — FS-76 in rank one (Q1) and FS-64 at five colours over ℚ(√167) (Q2) — not the 2026-07 milestone M03**; ids
here carry the prefix `M3-` and the job number. Grades are `CLAUDE.md` § Notation's, as each record gives them. A proof held in a record is
not repeated here; this file is the index that survives the ledger rows' compression. `LEDGER.md` § B will index every entry, one line each
(drafted in the plan's §R-close, stage 4). **M3 added no Lean**, so nothing below is kernel-checked; every kernel decision is recorded per
entry.*

**Duplicates are merged, one entry per theorem.** An entry carries the id of its first full derivation, and its title names every other id
the records give the same theorem (`= J20-K0`, `= J22-T6`, …), so a grep for any id lands here. Independence is stated per entry in the
records' own terms: **blind** means the deriver had seen neither the other derivation nor its statement; **from the fixed list** means a
verifier derived it from the planner's statement (§S of the plan, written before either derivation), not from the deriver's; **from the
statement** means the verifier had seen the deriver's statement, not its proof (J20's B1 for J19-KC/FRZ/KEF and its B2; J22's B1 for
J21-MX/TH/RED and its B2). **Corrections are applied as filed:** J20's reading of J19-KC's `N`; J22's scope corrections of J21's headlines
(SL, D1-43p, NG1, NG2, the `0.1974` display); J22's exact upgrade of the 59 margin; J18's and J20's correction of A-Kq.

**Who found what.** **J06** (the planner): the recognitions in the plan's "The milestone in the theory's terms" and §M, one mind, handed on
to be proved (§8). **J18** (Q1 derivation): F2, F3, K0loc, K0H, AK1, AK2, AKq, EQ, DC, KE⟹; tools CTL, DPR. **J19** (the second mind on
J18's stall; it read two withheld passages of J18's record, its §1.1): KC, ENDS, FRZ, KEF, TW, BIN, KT; tools CTL, AF✗. **J20** (blind
verifier of Q1; B1 blind to J18 and J19, from the fixed list and the owner's quotation of J19's three statements; B2 from J18's and J19's
statements): W, E1, E2, T35W, EQ, RET, K0–K2, Q, CUT, KC, FRZ, KEF, TW, BIN, DC, NAMED. **J21** (Q2 derivation): D0, D1, D1fac, D1-3, D1-2,
D1-43p, SL, D3, MX, TH, RED, D2p, NG1, NG2, NG3, D4. **J22** (blind verifier of Q2; B1 blind, from the fixed list and the owner's quotation of
MX, TH, RED; B2 by J22b from J21's five further statements): T1–T13.

**Notation, fixed once.** *Q1:* `D ⊂ ℤ_{>0}` finite, `m = max D`, `G(ℤ, D)` the distance graph, `X_k(D)` its proper `k`-colourings (a
one-dimensional shift of finite type, window `m + 1`); the **window-state graph** `W` (vertices the `m`-words occurring in some point, edges
the `(m+1)`-words); a **phase** is a cyclic strongly connected component, **rigid** if a single cycle; a **wall** a path between two distinct
phases; `F_k(D)`, `P_k(D)` the forced and periodic-forced groups. The **labelled** (transfer) quotient is FS-79's (`rank1_phases.py`: a
class's out-edges are its canonical representative's, one per admissible colour); the **plain** (orbit) quotient has edges the `S_k`-orbits
of `(m+1)`-words. A **strand** is a component of a two-colour subgraph; a periodic point is **Kempe-frozen** when each of its six two-colour
subgraphs is connected. **A-T1 (R2):** "For every finite `D ⊂ ℤ_{>0}`, if every phase of the window-state graph of `X₄(D)` is rigid, then no
wall exists." *Q2:* `F = ℚ(√167)`; for a place `v`, `Γ_v = Cay(F_v², T_v)`, `T_v` the unit circle; `Γ_S = ∏_{v∈S} Γ_v` (categorical
product); a **window `k`-colouring** over `S` is `W : G_S → [k]` with measurable classes; formats **E** (proper at every edge), **N** (C14′:
proper on pairs inside a conull set), **N′** (every edge with an endpoint outside a null vertex set `Z` proper), **L** (finite levels at
finite places), **Borel**. A place is **5-thick** if its local graph contains a compact open subgroup `K` and a probability `ν` on `T_v ∩ K`
with `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/4`. `χ_µ` is `[KechrisMarks2020]`'s (a µ-measurable colouring proper at every edge).

**Scope, stated once.** Q1's statements are about four-colouring shifts of distance graphs on ℤ (rank one); every one is also a statement
about FS-76's inheritance question there (`P₄(D) = F₄(D)`, FS79-T35), and none reaches rank ≥ 2 except through FS79-T34's class. Q2's
statements are about **window colourings** of ℚ(√167)'s plane; a window colouring gives a colouring of `F²` (`r ↦ W(ι_S(r) + t)`), and the
converse is claimed nowhere, so a "no" removes one format of falsifier of the local–global conjecture's "≥ 6" at ℚ(√167), never a colouring
no window gives (J22 §4.3). **Nothing in Q2 touches `χ_µ(ℝ²)` itself** (J21 §4.5). "Not found in print" is not "new"; the prior-art
position of each headline is §R-close stage 3 of the plan.

---

## §1. Q1 — the one-dimensional facts and the equivalences

**M3-J18-F2 — the return lemma: if `C` is rigid, a path of `W` in `C` at times `s < t` follows `C`'s cycle between them; a point with both limit phases equal to a rigid `C` is on `C`'s periodic orbit. (= J20-RET: "a point whose two tails lie in one rigid phase is the periodic point of that phase, up to shift".) [hand; two derivations: J18 §2.0 F2, J20 §2.2 blind]**
*Proof:* J18 §2.0 (F1, F2); J20 §2.2. *Proof verdict:* closes (J18 §4.2 item 1 names it the first thing a reviewer checks). *Rests on it:*
K0loc, AK1, KC (4), every Kempe entry. *Prior art:* standard (one-dimensional SFTs). *Kernel:* declined as a standalone; it is the first leaf
of any kernel port of Q1 (FS-76 stub).

**M3-J18-F3 — one-dimensional SFT facts: some phase not a single cycle ⟹ `h > 0`; every phase a single cycle ⟹ `h = 0` and `X` countable; and, every phase rigid, a wall exists ⟺ `X` is infinite ⟺ `X` has a non-periodic point. (= J20-W (the window-state graph is essential and its bi-infinite paths are exactly the points), J20-E1 ("`X₄(D)` is finite iff every phase is rigid and no wall exists"), J20-E2 ("`h(X₄(D)) > 0` iff some phase is not rigid"); = the planner's recognition "R2 ⟺ a countable four-colouring shift of a distance graph is finite".) [hand (standard; Lind–Marcus §4.3–4.4 recalled by J18, §2.2–2.3 and Thm 4.3.1 cited by J20); two derivations, J20 blind]**
*Proof:* J18 §2.0 F3; J20 §2.1. *Proof verdict:* closes. *Rests on it:* EQ, DC. *Prior art:* textbook (Lind–Marcus); the
identification "R2 ⟺ countable ⟹ finite for colouring shifts" is the planner's (plan, "The milestone in the theory's terms"). *Kernel:*
declined (standard SFT theory, absent from Mathlib; no consumer until A-T1 lands).

**M3-J20-T35W — FS79-T35 re-derived on the unquotiented window-state graph, `X₄(D) = ∅` included: `P ≠ F` iff every phase is rigid and a wall exists. [hand; J18 re-derived T35 in the quotient (J18 §2.5), J20 on `W` (J20 §2.1); two derivations of a held theorem]**
*Rests on it:* A-T2 ⟺ A-T1. *Prior art:* FS79-T35 (this project). *Kernel:* declined (as FS79-T35).

**M3-J18-EQ — A-T1 ⟺ A-T1′ ⟺ A-T2 ⟺ A-K3, for every `D` separately; and route (ii)'s potential (a reflection- and colour-invariant function on phases strictly decreasing along walls) exists on all-rigid shifts iff A-T1. (= J20-EQ, first clause; and A-C ⟺ `∃D ¬A-T1(D)`.) [hand; first clause two derivations (J18 §2.5, §3.1; J20 §2.1 from the fixed list); second clause one mind (J20: "not verifiable", the potential undefined in its brief)]**
*Proof:* J18 §2.5 (A-K3 ⟹ A-T1 by the orbit step, the converse vacuous), §3.1 (route (ii)); J20 §2.1. *Proof verdict:* closes. *What it
means:* **A-K3, the plan's "one hard obligation", is the theorem in reversal form, not a smaller step** (J18 C0 had it at 0.45 for this reason).
*Rests on it:* the plan's §M obligation tree is corrected by it (R4.C). *Kernel:* declined.

**M3-J18-DC — the Δ-completion theorem: "A-T1 fails iff there are a four-colouring `c` of ℤ that is eventually periodic in both directions and not periodic, and an `M ≥ 1` with `D_c(M) ≠ ∅`, such that every phase of `X₄(D_c(M))` is a single cycle", where `D_c(M) = {d ∈ [1, M] : c(x) ≠ c(x + d) for every x}`. (= J20-DC.) [hand; two derivations: J18 §3.2; J20 §3.2 from the statement, "under my reading", which B3 found identical to J18's definition (J20 §4.1)]**
*What it does:* removes `D` — A-T1 says every heteroclinic four-colouring of ℤ has a positive-entropy completion at every window; a
counterexample is one heteroclinic colouring with an all-rigid completion. *Rests on it:* the construction route to A-C (J20 §3.4's first
exact step, stub). *Prior art:* not found (plan §PA.2's searches; the close's gate, stage 3). *Kernel:* declined.

## §2. Q1 — the local lemmas

**M3-J18-K0loc — Lemma K0-loc: a periodic point `p` of a rigid phase (no hypothesis on the other phases) has every two-colour Kempe component infinite, all `k` colours on every closed neighbourhood, every Kempe component unbounded both ways (crossing every cut), and every `m`-window carrying at least `k − 1` colours; hence A-K0. (= J20-K0 (A-K0 as stated) and J20-CUT items 1–2 (every `m`-window of a rigid-phase point uses at least three colours; every cut crossed by an edge of every colour pair).) [hand; two derivations: J18 §2.1, J20 §2.2–§2.4 from the fixed list]**
*Rests on it:* AK1, the free quotient on phases, KC, ENDS. *Prior art:* the Kempe/fan-gap entropy argument is G13/G42's mechanism in rank one.
*Kernel:* declined (no consumer yet).

**M3-J18-K0H — the rank-one transcription of FS86-dB-H with two-sided gap-freeness is false: FS73-T30's rigid–rigid walls leave gap-free periodic colourings on a left half-line; only the one-sided form (A-K2) gives unique continuation. [hand + FS-79 tools; J18 §2.1; J20 §3.2 TRUE from the statement (T30's walls re-derived exactly, §3.3)]**
*Correction it carries:* the plan's "A-K2 is FS86-dB-H's rank-one form" holds only with **left**-gap-freeness (inventory row 10). *Kernel:*
declined.

**M3-J18-AK1 — A-K1: if every phase of `X₄(D)` is rigid and `X₄(D) ≠ ∅`, then `χ(G(ℤ, D)) = 4`. (= J20-K1.) [hand; two derivations, J20 from the fixed list]**
*Proof:* a periodic three-colouring would be a gapped periodic point (J18 §2.2; second route by row 45's entropy floor). *Kernel:* declined.

**M3-J18-AK2 — A-K2: a left-gap-free `c ∈ X_k(D)` is determined by any left half-line; a wall leaves a phase only at a left gap of its periodic point whose second colour survives. (= J20-K2, both clauses.) [hand; two derivations, J20 from the fixed list]**
*Proof:* J18 §2.3; J20 §2.2. *Kernel:* declined.

**M3-J18-AKq — A-Kq holds for the labelled (transfer) quotient; its rigidity clause is false for the plain (orbit) quotient (`D = {1}`: `W` is the complete digraph on four colours, entropy `log 3`, the plain quotient one looped vertex); the wall clause holds for both. (= J20-Q, which adds `D = {1, 2}` (entropy `log 2`), the mechanism (the quotients disagree only at a phase vertex using at most two colours), and "`W` all rigid ⟹ every quotient all rigid".) [hand (+ tools exact, J20's Q1 check); two derivations, J20 from the fixed list; C0 had the plain form at 0.05 (J18) and A-Kq at 0.55 (J20)]**
*Proof:* J18 §2.4; J20 §2.3, `tools/crunch_j20_checks.py` Q1, `data/m3/j20/checks-run.txt`. *Consequence:* T35, T36 and FS-79's scan used
the labelled quotient and are unaffected; the plan's §M item 1 and §S's parenthesis "the claims below hold in either form" are corrected
(inventory rows 9, 42). *Kernel:* declined; the `D = {1}` counterexample is a one-line `decide` if ever wanted.

**M3-J20-CUT — J20's cut lemmas: (3) at a wall's exit site the window is not coloured inside the two colours absent from the backward neighbourhood; (4) a crossing-free cut for the pair `π` in a wall point from `A` to `B` gives a wall from `A` to `τ_π·B` (walls are closed under future swaps). [hand; one mind (J20 §2.4)]**
*Rests on it:* J20's named stall (the operations that do not reach A-T1). *Kernel:* declined.

## §3. Q1 — Kempe structure and the stall

**M3-J18-KE⟹ — KE ⟹ A-T1, where KE (verbatim, J18 §3.5): "Let `D ⊂ ℤ_{>0}` be finite, and let `c ∈ X₄(D)` agree with a periodic point `p` of a rigid phase `C` on a left half-line and with a periodic point `q` of a rigid phase `C′ ≠ C` on a right half-line. Then some two-colour Kempe component of `c` is bounded on exactly one side, and swapping its two colours gives a point whose tail on the unbounded side lies in a phase that is not a single cycle." [hand; two derivations: J18 §3.5, J20 §3.2 from the statement]**
*KE itself:* **OPEN**, and false on a named class (M3-J19-KEF). *Kernel:* declined.

**M3-J19-KC — Kempe closure in an all-rigid `X₄(D)`: (1) `Per(X)` is finite, every strand of a periodic point is two-sided and `σ^N`-invariant for `N` the least common multiple of the least periods in `Per(X)`; (2) the Kempe class of a periodic point is a finite set of periodic points; (3) the Kempe class of a non-periodic point consists of non-periodic points; (4) every non-periodic point is a wall point whose tails lie in different labelled phases, and so is every point of its Kempe class. (= J20-KC.) [hand (+ tools exact, J20's Q2); two derivations: J19 §2.3; J20 §2.5 from the statement — clause 1 FALSE with `N` a point's least period (`D = {1, 3, 6, 9}`, least period 4, `{a,c}`-strands `6ℤ, 6ℤ + 2, 6ℤ + 4`), TRUE with J19's own `N` (J19 line 144); clauses 2–3 TRUE]**
*Correction applied:* J19's theorems-table line leaves `N` undefined; it must read "`N` a common period of all periodic points (the lcm of
their least periods)" (J20 §4.1, §4.4; inventory rows 42, 66). *Rests on it:* KT ⟹ A-T1. *Kernel:* declined.

**M3-J19-ENDS — the ends partition of a wall point `c` (agreeing with `p` on `(−∞, a)` and `q` on `(b, ∞)`, both with two-sided strands): each strand of `p` has exactly one left-end component in `c`, and the left-unbounded components partition `p`'s strands (likewise on the right); every finite component of `H_c^{ef}` meets `[a − m, b + m]`; swapping a component with left ends `A` and right ends `B` gives a point agreeing with `p_A` and `q_B` on half-lines. [hand; tools exact on the control (`tools/crunch_j19_ends.py` asserts clause 1 every run); J20 §3.2 from the statement: clauses 1, 3 TRUE; clause 2 TRUE in the reading "lie within distance `m` of the junction", which is J19's own `[a − m, b + m]`]**
*Rests on it:* FRZ, KEF, KT. *Kernel:* declined.

**M3-J19-FRZ — if `c` is a wall point with Kempe-frozen tails, every point of its Kempe class has tails that are colour relabellings of the same tails. (= J20-FRZ, which notes that no rigidity is used.) [hand; two derivations: J19 §2.5; J20 §2.5 from the statement]**
*What it means:* no Kempe argument can move a frozen-tailed wall. *Kernel:* declined.

**M3-J19-KEF — KE fails at every rigid–rigid wall point all of whose one-sided components are total (their ends are all the strands of their tail for that pair), in particular at every rigid–rigid wall between Kempe-frozen tails; so KE ⟹ KE♯: "in no `X₄(D)` does a rigid–rigid wall join two Kempe-frozen periodic points". (= J20-KEF, which adds KE1′ ⟹ KE♯ and KT ⟹ KE♯.) [hand; two derivations: J19 §2.5; J20 §2.5 ("in particular" clause, B1) and §3.1 (whole, B2, once KE was forwarded) from the statement]**
*KE♯:* **OPEN**, not refuted on any named set (J20-NAMED: none has a frozen rigid point). *C0:* J19's C0-4 (KE refuted by a derived
argument or instance) half met. *Kernel:* declined.

**M3-J19-KT — the Kempe transport lemma, as implications: KE ⟹ KT ⟹ A-T1, and KT ⟹ KE♯; so A-T1 = FW ∧ A-T1ⁿᶠ, with FW ("no all-rigid `X₄(D)` has a wall between Kempe-frozen periodic points") out of reach of every Kempe argument (J19-FRZ). KT (verbatim, J19 §2.8): "Let `c ∈ X₄(D)` agree with a periodic point of a rigid phase `C` on a left half-line and with a periodic point of a rigid phase `C′ ≠ C` on a right half-line. Then finitely many Kempe moves turn `c` into a point whose two tails lie in one labelled phase, or into a point one of whose tails lies in a phase that is not a single cycle." [hand; two derivations of the implications: J19 §2.8; J20 §3.1 from the statement, which adds that KT restricted to all-rigid `X` is equivalent to A-T1 there, and reads the split as tautological given FW's definition]**
*KT itself:* **OPEN** (J19, J20). *The named missing step (J19 §2.8 item 3):* for a rigid–rigid wall with a non-frozen tail, show that the
ends partitions of the points in its Kempe class allow the two tails to be moved into one Kempe orbit of labelled phases. *Kernel:* declined.

**M3-J19-TW — every wall `C → C′` has a chiral end; if one end is achiral a twin wall `E → gẼ` exists. (= J20-TW, which proves it for every wall between two distinct phases of any `X₄(D)`, rigid or not — FS79-T34's step 5 needs no rigidity.) [hand; two derivations: J19 §2.5; J20 §3.2 from the statement (and generalised)]**
*Prior art:* FS79-T34's rank-one core (this project), re-derived. *Correction applied:* J19-TW needs no rigidity (J20 §4.4). *Kernel:* declined.

**M3-J19-BIN — for `D ⊇ {1, 2}`, `X₄(D)` is a 24-to-1, `S₄`-free extension of a binary return-time shift `Y(D)` (letter R when `c(y) = c(y − 3)`, N otherwise; a four-state leftward automaton); phases, rigidity, walls and mirroring transfer, so A-T1 on this class reads "a binary return-time shift whose periodic points are all isolated in their SCCs has no heteroclinic point". (= J20-BIN, with the factor `y(x) = [c(x + 3) = c(x)]`.) [hand; two derivations: J19 §2.7; J20 §3.2 from the statement]**
*Rests on it:* the proposed subclass stub (A-T1 on `D ⊇ {1, 2}`). *Kernel:* declined.

## §4. Q1 — tools-grade entries

**M3-J18-CTL — the control `{1,5,7,10}`: 583 states in the labelled quotient, 18 phases, 17 rigid, 15 walls (FS-79's numbers, reproduced by independent code); `χ = 3`; the 9 rigid–rigid walls run from phases 65, 67, 81 to 23, 49, 55, all six ends chiral (period 20); 8 of 9 BFS wall points have `D_c(100) = {1,5,7,10}` (trivial completion); all 9 satisfy KE. [tools exact; one run (J18 §3.3, `tools/crunch_j18_phases.py`, `data/m3/j18/controls.txt`, `swaptail.txt`); the phase counts confirmed independently by J20-NAMED (187 labelled phases, 186 rigid; "18 up to colour permutation, 17 rigid"); the completions and the KE rows not re-checked by J20]**
*What it explains:* FS-79's "adding one distance killed every wall whenever it killed the entropy" (8 of the 9 walls cannot be separated
from the entropy by adding any distance ≤ 100). *Kernel:* declined.

**M3-J18-DPR — the one derived check: `D′ = D_c(40) = {1,5,7,10,13,27,33}` for the BFS wall point `81 → 49`: 20,023 states, 25 phases, 24 rigid, one non-rigid (10,817 states), 3 walls, one rigid–rigid (`3637 → 96`, both ends chiral), whose one-sided swaps satisfy KE; A-C not landed. [tools exact; one run (J18 §3.4, `data/m3/j18/completion-81-49-M40.txt`); registered before the run (P-J18-DC, 0.80 non-rigid: met); J20 partly confirmed — one non-rigid labelled phase, 270 rigid, rigid–rigid walls with period-20 non-frozen chiral ends; "satisfies KE" not checked by J20 (budget; inventory row 47)]**
*Kernel:* declined.

**M3-J19-CTL — on the control the 9 rigid–rigid walls run from the family {65, 67, 81} to its mirror family {55, 23, 49} (three twin walls, six crossing); of their 62 one-sided components the 10 total ones keep the tail rigid and the 52 proper ones send it to the non-rigid phase 57, matching J18's swap data row for row; over all 17 rigid phases, 120 of 170 single-strand swaps land in a rigid phase and 50 in 57. [tools exact; one run (J19 §2.2, `tools/crunch_j19_mirror.py`, `tools/crunch_j19_ends.py`, `data/m3/j19/`); J19's C0-5 (twin-family walls, 0.6) met]**
*What it explains:* J18 §3.3's "some other one-sided swaps keep the tail in its own phase" — exactly the relabellings. *Kernel:* declined.

**M3-J19-AF✗ — conjecture AF ("in an all-rigid `X₄(D)` every periodic point is Kempe-frozen") is false: in the all-rigid `X₄({2,6,11,13,14})` (94 phases up to colour permutation, no wall) every one of the 94 rigid periodic points is non-frozen (one complementary couple of pairs with 6 strands each; periods 4, 8, 12, 24; 46 chiral); single-strand swaps stay rigid, connect all 94 phases, and join every chiral phase to its mirror. (= part of J20-NAMED.) [tools exact; two tools: J19 §2.6 (`tools/crunch_j19_frozen.py`, 2.0 s, registered before the run, C0-6 "all frozen" at 0.35 lost), J20 §3.3 (`tools/crunch_j20_walls.py`, frozenness decided by quotient connectivity plus closed-walk voltage gcd); one `D`, chosen by a stated rule, at the ban's edge]**
*What it says:* the richest all-rigid shift held is Kempe-rich, not frozen, and has no wall — the evidence for A-T1 does not live in the
frozen class. *Kernel:* declined.

**M3-J20-NAMED — on FS73-T30's four wall sets (`{1,5,7,10}`, `{3,5,9,10}`, `{3,7,9,10}`, `{5,7,9,10}`), on `{2,6,11,13,14}` and on `{1,5,7,10,13,27,33}` no rigid periodic point is Kempe-frozen; every rigid–rigid wall end has period 20 and is chiral (labelled-phase counts 187/186, 262/258, 369/348, 163/162, 2,094/2,094, 271/270; rigid–rigid reachable pairs 1,296, 144, 48, 144, 0, 144). [tools exact; one run each (J20 §3.3, `tools/crunch_j20_walls.py`, `data/m3/j20/walls-run.txt`; controls `{3,6,9}` not frozen and `{1,2,3}` frozen; the plant fires); J20's own slip (a lift sign) caught and fixed before any verdict used the tool (J20 §4.3)]**
*What it says:* FW (and KE♯) has no test case in hand. *Kernel:* declined.

## §5. Q2 — the corner, the count and the factor table

**M3-J21-D0 — "A measurable window five-colouring over `S = {∞₁}` is exactly a proper five-colouring of the unit-distance graph of `ℝ²` with Lebesgue-measurable classes; for every finite `S` containing a real place, a measurable proper five-colouring of that graph pulls back to a measurable window five-colouring over `S`. Hence no measurable window five-colouring over any `S` containing a real place implies `χ_µ(ℝ²) ≥ 6`." [hand; two derivations: J21 §2.1, J22 §2.3 blind (fixed list)]**
*Scope:* `χ_µ` is `[KechrisMarks2020]`'s, everywhere-proper (J21 §1.1 Q8); the same for Borel. = the planner's recognition "FS-64 at five
over any `S ∋ ∞` contains `χ_µ(ℝ²) ≤ 5`". *Kernel:* declined (measure theory; no consumer).

**M3-J21-D1 — "For every finite set `S` of places of ℚ(√167) containing no real place, if every local graph `Γ_v`, `v ∈ S`, has measurable independence ratio `< 1/5`, then no measurable window five-colouring over `S` exists" — in formats E, N and L. [hand (= FS86-Cx-C14.3 at `k = 5`, C14.1 and C14.3 re-walked line by line); two derivations: J21 §2.2, J22 §2.3 blind]**
*Rests on it:* the finite-place half of the headline. *Kernel:* declined.

**M3-J21-D1fac — ℚ(√167)'s factor table: the local graph has ratio `< 1/5` at 23 (both places, `≤ 97.984637/529 = 0.18523`, row 75's certificate), at every stable `p ≥ 59` (59: level-one Hoffman `0.199119854095`, exact; `p ≥ 67` by Weil; constant up the tower by Lemma P), at the ramified 167 (`≤ 0.12615`), and at every odd split place (0, C14.2 (c)); the stable places below 59 are exactly 23 and 43. [hand + tools + cert; two derivations: J21 §2.3 (59 by a float spectrum, error `< 10⁻¹¹`, margin `8.8·10⁻⁴`), J22 §2.3 blind with **59 exact** (M3-J22-T1) and **23's certificate re-checked by the frozen FS-66 checker** (§7)]**
*Correction applied:* 59's grade upgraded from float to exact (inventory row 53). *Kernel:* declined (the 23 certificate is FS-66's; a
kernel port of FS-66's checker is FS-66's own question).

**M3-J21-D1-3 — the place of ℚ(√167) above 3 is split in `F(i)/F` (`167 ≡ 2 mod 3`, 3 inert in `F`, `F_v = ℚ₉ ∋ i`), so FS-64's configuration (ii) contributes a factor of ratio 0 (C14.2 (c) at `q = 9`). [hand; two derivations: J21 §2.4, J22 §2.3 blind; the planner's recognition (plan §G.4 item 5) the first statement]**
*What it teaches:* the barrier prime is, in C14's terms, a split place — the best factor for the count and (J21-TH) a non-mixing one.
*Kernel:* declined.

**M3-J21-D1-2 — C14.2 (c) holds verbatim at residue size `q = 2`: ℚ(√167)'s one dyadic place (`F_v = ℚ₂(i)`, split in `F(i)/F`) has ratio 0 with error `≤ 3/(2n+4)`; the proof uses `q` only through `1/(q − 1) ≤ 1`. (= J22-T3.) [hand (+ tools: an FFT at `ℚ₂(i)`, `(2n+1)λ_min = −2` at `n = 1, 2, 3`, plant fires); two derivations: J21 §2.5, J22 §2.3 blind]**
*Consequence:* FS86-CL1's qualifier "whose split places are odd" can be dropped at ℚ(√47) and ℚ(√167) — **now two minds** (inventory row 18;
LEDGER row 92's correction, drafted at stage 4). *Kernel:* declined.

**M3-J21-D1-43p — at 43, partial: (1) windows reading the 43-adic places at level one are excluded, in D1's setting (no real place, every other factor of ratio `< 1/5`), since `α(Γ₄₃)/1849 ≤ 365/1849 = 0.197404` (row 69's certificate); (2) the fibre-share inequality with only the spectrum (and `Σφ² ≤ Σφ`) gives exactly Hoffman's `0.213755422119`; (3) D1-43 at depth (an all-levels bound `sup_k α(G_k)/43^{2k} < 1/5`) is GAP. [hand + cert; J21 §2.6; J22 §3.1 from the statement: clause 1 TRUE in D1's setting (its headline's "`≤ 0.1974`" truncates an upper bound: `≤ 0.19741`); clause 2 as J21's headline states it ("the fibre-share inequality alone") FALSE of `B₁(43)`, TRUE of the spectral relaxation (J22-T10); clause 3 ("so it cannot close 43 at depth") GAP, true only of the spectral relaxation]**
*Filed at the corrected scope (inventory row 49):* "with only the spectrum" and "in D1's setting". **The named missing object (J22 §3.1):**
a certificate for `B₁(43) < 369.8` (FS-69's instrument, 84 GPU-days, out under the ban), or a fractional `φ` meeting the inequality with
`Σφ ≥ 369.8` (which would refute the route). J21's body (§2.6) already said the moment relaxation could close it; the headline overclaimed.
*Also:* the uniform measure is optimal for both Hoffman and mixing on the level-one circle (M3-J21-UNIF). *Kernel:* declined.

**M3-J22-T10 — the fibre-share inequality `⟨φ, A₁φ⟩ ≤ 2Σφ(1 − φ)` with only the spectrum (and `Σφ² ≤ Σφ`) gives exactly Hoffman's ratio whenever `|λ_min| ≥ 2`, and its true maximum `B₁(p)` is strictly below Hoffman unless `Γ_p` has an independent set meeting Hoffman's bound; at 43, `B₁(43) < 395.2338`. [hand + tools exact; one mind (J22b §3.1; `tools/crunch_j22_b2_checks.py` h43, plant `α = 396` fires)]**
*Rests on it:* the correction of J21-D1-43p's clauses 2–3. *Prior art:* the Hoffman equality case is classical (Hoffman; Haemers); the
statement about `B₁` is about FS-66's relaxation (row 75). *Kernel:* declined.

**M3-J22-T1 — `Γ₅₉`'s nontrivial spectrum lies in `(−15, 15)`: `λ_min = −14.91757700177875`, `λ_max = 14.51093575399911`, `λ* = 0.2486262833630 < 1/4` (margin `1.374·10⁻³`), Hoffman `0.199119854095 < 1/5`. [tools exact, two code bases (Sturm counts on the 60 Galois-orbit minimal polynomials in Python/sympy; PARI `minpoly` + `polsturm`); controls reproduce FS-86 B1's `λ_min` at 11, 19, 23, 31, 43 to 13 digits; three plants each fire at their own check, one re-planted after firing for the wrong reason (J22 §2.5)]**
*Settles:* J21's one close number (inventory row 26) — the places above 59 are 5-thick and of ratio `< 1/5`, exactly. *Kernel:* declined
(a kernel certificate is possible — an exact spectrum — but no consumer asks for it).

**M3-J22-T2 — the level-one `λ*` of the standard compact piece: 0.625 (`q = 9`), 0.4106 (25), 0.2772 (49), 0.3317 (23), 0.3393 (29), 0.2719 (43), 0.2557 (61), all `≥ 1/4`; 0.2220 (67), 0.1831 (121) `< 1/4`; at 2, `λ* = 1` for every measure. [tools exact (J22 §2.2, `data/m3/j22/`); agrees with J21's table to the digits printed (J22 §4.2 row 16); 167 sharper in J21 (`0.15160`) than J22's Weil + Lemma P (`≤ 0.154`)]**
*Kernel:* declined.

## §6. Q2 — products, the reduction, the obstructions, the inhabitants

**M3-J21-SL — the slicing lemma: for a σ-compact locally compact abelian `G`, `Γ = Cay(G, T)` and a graph `Y` on a σ-finite measure space, a measurable proper `k`-colouring of `Γ × Γ × Y` restricts along `(x, y) ↦ (x, x + s, y)` to a measurable proper `k`-colouring of `Γ × Y` for almost every `s` (every `s` if Borel); properness at every edge is kept for every `s`. (= J22-T11's positive half.) [hand; J21 §3.1; J22 §3.2 from the statement — as J21's headline states it ("a locally compact abelian `G`", "any measured graph `Y`") the a.e. clause is FALSE: `G = ℝ × ℝ_d`, `T = {±(1,0)}`, `Y = K₂`, class 2 of every slice `V × {s₁}` with `V` non-measurable (under the local-measurability convention); TRUE for σ-compact `G`, σ-finite `Y`, which covers every use in M3]**
*Filed at the corrected scope* (inventory rows 49, 62). *Rests on it:* D3, RED's merging. *Kernel:* declined.

**M3-J21-D3 — `χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`, and the same for `χ_B`: two real places merge in every window question. (= J22-T5.) [hand; two derivations: J21 §3.1 (by SL), J22 §2.3 blind (shifted diagonals, Fubini)]**
*Kernel:* declined.

**M3-J21-MX — the mixing selection: "`K` compact abelian, `ν` a probability on `T_K ⊆ K`, `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/(k−1)`: for every Borel graph `X`, a Borel proper `k`-colouring of `X × Cay(K, T_K)` yields the Borel proper `k`-colouring `φ(x) = min{j : μ(W(x,·)^{-1}(j)) > λ*/(1+λ*)}` of `X`; for measurable `W` proper off a null vertex set, `φ` is measurable and proper off a null vertex set" (format N′, every edge with an endpoint outside the null set). Its engine: the compact expander-mixing lemma `μ(P)μ(Q) ≤ λ*√(μ(P)(1−μ(P))μ(Q)(1−μ(Q)))` for edge-free `P, Q`. (= J22-T6.) [hand; two derivations: J21 §3.2; J22 §2.2 in B1 from the statement (blind to the proof), with the weaker N′ reading, and at B3 J21's stronger N′ (the outer-measure step) re-derived TRUE (J22 §4.2 row 8)]**
*Scope:* the null-set step is named — edges with both ends in the null set are not controlled (J21 §3.2 last paragraph; under CH an
independent set of a mixing compact Cayley graph can have full outer measure). *Classical case:* `K = ℤ/n`, `T_K = K ∖ 0` gives
`χ(G × K_n) = min(χ(G), n)` (Burr–Erdős–Lovász 1976, as cited in `[Zhu2025]` §1). *In Kechris–Marks's terms:* a positive special case of
Problem 4.23 — `C_B(k+1)` for pairs `(G, Cay(K, T_K))` with the second factor `k`-mixing (J21 §3.2). *Prior art:* J21's 9 zbMATH queries
negative; the close's gate, stage 3. *Kernel:* a candidate in its finite form (a finite abelian Cayley factor, Parseval and a pigeonhole);
declined for now — no consumer in the kernel, and the prior-art gate first.

**M3-J21-UNIF — for the standard compact subgraph at a stable or split place, averaging any probability `ν` on `T_v ∩ K` over the norm-one torus gives the uniform (Haar) measure with `|ν̂_unif(ξ)| ≤ max_u |ν̂(uξ)|`: the uniform measure is optimal for both Hoffman and mixing, so no reweighting of the circle makes a non-thick place thick. [hand; two derivations: J21 §2.6 (b), §3.3; J22 §2.2 ("Uniform optimal", convexity plus transitivity of the torus on `T_K`), from MX/TH's statement]**
*Scope:* "not thick" means "not removable by J21-MX on the standard compact piece"; other compact subgroups were not examined (J21 §3.3).
*Kernel:* declined.

**M3-J21-TH — the thick places of ℚ(√167): every finite place is 5-thick except twelve — the dyadic place, the places above 3, 5, 7 (inert in `F`, split in `F(i)/F`), the two above 29 and the two above 61 (split), and the two above 23 and the two above 43 (stable); for those twelve the standard compact subgraph has `λ* ≥ 1/4` and the uniform measure is optimal. (= J22's TH verdict, with J22-T1, T2, T8.) [tools + hand (Weil; Lemma P; higher-level Kloosterman sums, classical); two derivations: J21 §3.3, J22 §2.2 from the statement with exact spectra (two code bases) — 59 thick by `1.374·10⁻³`, the one close margin, settled exactly]**
*Kernel:* declined.

**M3-J22-T8 — at a split place with odd `p`, a level-`m ≥ 2` character with equal negative valuations has `|ν̂| ≤ 2/(q − 1)` (stationary phase); Lemma P re-derived (a coset of `𝔽_p^×` meets `μ_{p+1}` in at most 2 points). [hand; J22 §2.2; J21 §3.3 uses the same bound as classical input (`|K(a,b;π^m)| ≤ 2q^{m/2}`)]**
*Prior art:* the Kloosterman stationary-phase bound is classical; Lemma P is FS86-LP. *Kernel:* declined.

**M3-J21-RED — the reduction: for every finite set `S` of places of ℚ(√167), with `S_red` = `S` with every 5-thick place deleted and one place kept of each isomorphic pair (the two real places; the two places above 23, 29, 43, 61), `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`; a Borel window five-colouring over `S` exists iff one exists over `S_red`; a measurable one over `S` (format E) gives one over `S_red` in format N′, and one over `S_red` in E (resp. N′) gives one over `S` in E (resp. N′). [hand (given MX and TH's thick side); two derivations: J21 §3.4, J22 §2.2 from the statement]**
*Corollaries at ℚ(√167) (J21 §3.4):* **(a)** with no real place, every finite-place window falsifier must read a place above 43, and a Borel
one exists iff one exists over `S_red ⊆ {43, 2, 3, 5, 7, 23, 29, 61}` containing 43; **(b)** with a real place and only thick finite places,
a Borel window five-colouring over `S` exists iff `χ_B(ℝ²) ≤ 5` (measurable: into N′); **(c)** everything else — `S_red` containing `∞` and
one of 2, 3, 5, 7, 23, 29, 43, 61 — is open. *Edge case (J22):* `S_red = ∅` gives one looped vertex; both sides fail, consistently.
*Kernel:* declined.

**M3-J21-D2p — D2(a) and D2(b) hold when every factor of `B` is thick: Borel, iff; measurable, ⟸, and ⟹ into format N′. (= J22-T7 (D2(a) ⟸, and ⟹ in the Borel form when every factor of `B` is 5-thick) and J22-T9 (D2(b) ⟺ D2(a) for each `B`, given D3).) [hand; two derivations: J21 §3.5, J22 §2.1 blind and §3.3 from the statement]**
*The fixed-list claims D2(a), D2(b) stay GAP* at two named steps (J21, J22 agreeing): **GAP-1** the null-set step (a measurable proper
five-colouring of `A × B` gives one of `ℝ²` proper off a null vertex set, not everywhere; J22: "N′ ⟹ E for `UD(ℝ²)` at five colours, or a
Borel hypothesis on `W`"); **GAP-2** the non-thick factors eligible for D2 (2, 3, 5, 7, 23, 29, 61 up to conjugation; 43 fails D2's ratio
hypothesis as far as is known): "a measurable selection `A × B → A` for a factor that is not 5-thick". *Kernel:* declined.

**M3-J21-NG1 — the planner's cylinder lemma (plan §M, D2's route: "an independent set of `A′ × B` of relative density `> β` is a.e. a cylinder `I × B`") is false already for `A′ = A = UD(ℝ²)`, for every `B` of the D2 class. (= J22-T12, which refutes it in the literal reading — every proper subset of a cylinder — and in the containment reading the induction needs — "a.e. inside `I′ × G_B` for some independent `I′`", by a cylinder with a hole `(I″ × G_B) ∪ (H₁ × P) ∪ (H₂ × P)`, `P = ∏ p_vO_v²`.) [hand (+ tools exact, J22's ng1 check); two constructions: J21 §3.6 (a checkerboard of discs and squares, which J22 B3 found also refutes the containment reading), J22 §3.4 from the statement]**
*Correction applied (inventory row 49):* J21's intermediate "`β ≤ 0.18523`" is not a bound for every D2-eligible `B` (a factor at 59 is only
known `≤ 0.19912`); the right reason is `β < 1/5 < 0.2267`, and the conclusion stands. *What it says:* a density above `β` controls no
fibre; any correct cylinder lemma must be fibre-local, which is MX's threshold selection (J22 §3.4). *Kernel:* declined.

**M3-J21-NG2 — ratio alone cannot carry D2, at 125 colours: `B = F[K₄₁] = Cay(ℤ₈₃ × ℤ₄₁, (S × ℤ₄₁) ∪ ({0} × ℤ₄₁ ∖ 0))` with `F` Exoo's circulant `Cay(ℤ₈₃, {±2, ±22, ±25, ±34})` is a finite abelian Cayley graph with `α(B)/|B| = 27/3403 < 1/125`, and `A = K₁₂₅^B` has `χ(A × B) ≤ 125 < χ(A)` (Zhu's Theorem 3.5 instance of Shitov's construction). (= J22-T13 for the exact parts.) [hand + external: `χ(A) > 125` is `[Zhu2021]`'s Theorem 3.5 (sketched in `[Zhu2025]` §3) and `α(F) = 27` is Exoo's search, both unchecked here; odd girth exactly 7, the Cayley structure and `27·125 = 3375 < 3403` exact (J22 §3.5, `tools/crunch_j22_b2_checks.py`); J21 §3.6, J22 §3.5 from the statement]**
*Filed at the corrected scope and grade (inventory row 49):* "at 125 colours", grade hand + external. At five colours the ratio-only
statement is `[Zhu2025]`'s weakened conjecture at `n = 5`, not decided by NG2 — an analogy there, not a counterexample (J22 §3.5). The
two-point LP bound on `α(F)` is 35.61 and Hoffman 37.10, so `α(F) = 27` stays external (J22 §1.4). *Kernel:* declined.

**M3-J21-NG3 — at a split place the whole local graph is not mixing; only compact subgraphs can be: two clopen cross-independent sets of window density bounded below exist. (= J22-T4: clopen cross-independent sets `C, D` of window density `≥ 2/9` each, every edge preserving `d₀(u)` or `d₋₁(w)`, so no density-threshold selection runs on any compact window `⊇ π⁻¹O²`.) [hand; two constructions: J21 §3.6 (digit classes of negative valuation, densities `→ 1/4` at `q = 2`), J22 §2.1 (blind)]**
*What it says:* at a split place J21-MX's reach is exactly the compact subgraph's `λ*`. *J22's open step (inventory row 61):* whether the
cross-independence ratio `κ < 1/5` on the standard piece `Cay(O², {(ε, ε⁻¹)})` at `q = 9, 25, 49, 29, 61`, or at 23 (`κ ≤ λ*/(1 + λ*)`
gives `0.2036` at 61 and more elsewhere) — finite questions, after the ban. *Kernel:* declined.

**M3-J21-D4 — both inhabitants of the format: C9's `⌊4θ̃⌋` (`θ̃ = θ₇(g₇) + ℓ(g_∞)`, `θ₇(x, y) = {(2x + 3y)/7}₇`, `0 < |c| ≤ 1/28`) is a Borel window four-colouring of ℚ(√11)'s plane over `{∞, 7}` (one real place, one place above 7), proper at every edge, a pullback from neither factor; a periodic seven-colouring with Borel classes (the hexagonal one, or the kernel-checked `sevenBrick`, row 33) is a window seven-colouring over `{∞₁}` of every real field. [hand (C9's residue table re-checked); two derivations: J21 §4.1, J22 §2.3 blind]**
*Consistency check (J21):* `Γ₇`'s Hoffman ratio `2/7` forces `λ* ≥ 2/5 > 1/3`, so `Γ₇` is not 4-mixing — as it must not be. *Kernel:* the
seven-colour half is already kernel (`plane_colorable_seven`); the four-colour half declined.

## §7. The FS-66 checker re-run at 23 (the one item only the close could read)

**M3-CHK23 — the frozen FS-66 checker (`tools/fs66_b1_cert_check.py`, sha256 prefix `735b926798ffac14`, matching row 75's) on the existing certificate `data/fs66/b1/cert-p23.json --m 5`. [an existing checker on an existing certificate (in, under the ban); J22's first run killed by its own 8 GiB slot cap at step 6/7 (exit 137, peak 8,383,092 kB — explained, not a crash); the owner's re-run under a 16 GiB slot, log `data/m3/j22/fs66-cert-p23-m5-rerun.out`]**
*Verdict:* **pending at this file's stage-2 save** — filed in the plan's §R-close when the log's last line reads `exit=<code>`. D1-fac's 23
clause rests on row 75's recorded CERTIFIED verdict either way.

## §8. The planner's statements (J06), mapped

The plan's recognitions were "[hand, planner, one mind], stated for the derivation jobs to prove or refute" (plan line 8). Each is filed
where a job proved or corrected it:

| the planner's statement | where filed | outcome |
|---|---|---|
| R2 ⟺ "a countable four-colouring shift of a distance graph is finite" | M3-J18-F3, M3-J18-EQ | proved (two derivations) |
| A-T1 ⟸ A-K3 + T34's orbit step | M3-J18-EQ | proved; and A-K3 ⟺ A-T1, so not a smaller step |
| "in an all-rigid shift every periodic colouring is fan-gap-free and has only infinite Kempe components" | M3-J18-K0loc | proved (in the stronger local form) |
| A-K2 as "the rank-1 form of FS86-dB-H" | M3-J18-AK2, M3-J18-K0H | true only with left-gap-freeness |
| A-Kq's one-line proof (§M item 1: "an edge's lift is determined by its source") | M3-J18-AKq | fails exactly at windows of ≤ 2 colours; the plain quotient's rigidity clause is false |
| FS-64 at five over any `S ∋ ∞` contains `χ_µ(ℝ²) ≤ 5` | M3-J21-D0 | proved (two derivations) |
| at ℚ(√167) the place above 3 is split | M3-J21-D1-3 | proved (two derivations) |
| Hoffman at 43 is `0.21376 > 1/5`, so D1-43 needs more than Hoffman | M3-J21-D1-43p, M3-J22-T10, M3-J22-T2 (`0.213755422119` exact) | confirmed; and the fibre-share `B₁(43)` is strictly below Hoffman |
| the cylinder lemma (§M, D2's route) | M3-J21-NG1 | false, in both readings |

## §9. What M3 leaves open (not theorems; listed so that no reader counts them)

- **A-T1 (R2), A-T1′, A-T2, A-K3, A-C:** GAP (three named stalls: J18 at KE, J19 at KT's transport step, J20 at its own named step, which
  J20 identifies with J19's FW plus the non-frozen half). **KE, KE1′, KE♯, KT:** open. **P-A6** (EES's aperiodic colourings in
  positive-entropy shifts) unscorable: `[EggletonErdosSkilton1990]` unheld.
- **D1-43:** GAP at an all-levels bound at 43 (`B₁(43) < 369.8`). **D2(a), D2(b):** GAP-1 and GAP-2. **`χ_µ(ℝ²)`:** untouched.

## §10. Kernel decisions, in one place

No entry is kernel-checked. Declined throughout, for one reason: no kernel consumer exists yet, and each result is either standard
(SFT facts), a lemma whose use waits on A-T1 (Q1's chain, a kernel target only if FS-76's rank one lands), or measure-theoretic on locally
compact groups (Q2). **Two candidates are named for a future kernel list:** M3-J21-MX in its finite form (a finite abelian Cayley factor —
Parseval and a pigeonhole — once the prior-art gate has spoken), and the `D = {1}` counterexample of M3-J18-AKq (a one-line `decide`, if
FS-79's quotient is ever ported).
