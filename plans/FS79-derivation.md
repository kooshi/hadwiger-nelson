# FS-79 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-24 at the close (WORKFLOW 2.0 step 9) by the close planner (de Bruijn, Opus 5.5), from the plan
(`plans/FS79-invariant-question.md` §0, §IQ, §X, §R-review, §D), every phase record's "Theorems this phase proved"
(`data/fs79/records/phase-P0.md`, `phase-P3-theta4.md`, `phase-P3b-survivors.md`), the two competitors' working files
(`plans/FS79-C-deBruijn.md` §2–§4, §2a, §2b, §3a, §7; `plans/FS79-C-Coxeter.md` §1, §4 — neither has that heading) and the advisors'
records. Grades are `CLAUDE.md` § Notation's. A proof held in a record is not repeated here; this file is the index that survives the
ledger rows' compression (rows 80–81); T44–T49 are P3b's. `LEDGER.md` § B indexes every entry, one line each (`tools/fs71_ledger_b_check.py --strict`).
**FS-79 added no Lean**, so nothing below is kernel-checked and every kernel decision is recorded per entry.*

**Who found what** (credited per entry): the **planner** (the plan, §0, §PA, §IQ); **Poros (plan)**, the plan-phase advisor; the
**modeling agent** (the domain, obligation and experience passes, §D, §C.4); the **phase-0 implementer** (P0); the competitors
**de Bruijn** and **Coxeter** (P2); **Poros (competition)**, the competition advisor; the **P3 implementer** (the exact Θ₄ tree); the
**P3b implementer** (the survivors); and the **owner** (the product owner's checks, cited by close-inventory item).

**Scope, stated once for every entry below** (Kooshi's question of 2026-09-24, close-inventory item 97). A no-go is stated for its
**format**, never for "a kind": the formats are edge-local heights, the colour complex's loop winding, face-local parity-free fluxes and
coindex topological bounds. Wider-window cocycles, the index topological bounds and non-local 2-forms are open. A single solver's
unchecked UNSAT is tools-grade, never "provably". A ball priced at G65's degree-18 aim is a price of that ball, not of a refutation.

## §1. The plan's theorems (the planner, Poros (plan), the modeling agent, the owner)

**T1 — Every three-colourable lattice graph is four-colourable and loose at four colours; so 56 of FS-61's 57 lattices over ℚ(√167) are settled at four with no screen. [derived; the planner]**
A `k`-colourable graph carries no `(k+1)`-colour pair compulsion (row 45's spare-colour lemma, `not_forces_of_colorable`), so `F = 0`
at four colours on every three-colourable lattice; of FS-61's 57 lattices, 52 carry certified gapped periodic three-colourings and 3
are 3-integral (FS73-T18, row 72), and `Ld14c588b` colours linearly (FS73-T27). *Proof:* plan §0 item 4. *Proof verdict:* closes (a kernel lemma applied to screened instances). *Rests on it:*
phase 0's population (only `L21cc6506` and the saturated chain `Λ_M` screened). *Prior art:* none needed. *Kernel:* declined — the
lemma is kernel; the instances are FS-73's certified colourings.

**T2 — A finite-index forced group does not by itself give a chainable δ: route (ii)'s exact target is a forced δ that is a unit at every conjugation-stable prime. [hand; Poros (plan), card B]**
G55's chain closes in `F` from a forced δ only if `1/δ ∈ ℤ[U]`, which by prime inversion (ASTRA-T2) needs δ prime to every
conjugation-stable prime of `F(i)`; a lattice whose four-colourings were all residue colourings at a usable 𝔭 has `F = 𝔭Λ`, rigid and
useless. Over ℚ(√167), `1/2, 1/3, 1/7 ∈ ℤ[U]` (`[Fischer1990]` Ex. 4) and 5 too (the primes above 5 are swapped by conjugation;
Coxeter C6). *Proof:* plan §0 item 5; `plans/POROS-2026-09-23-fs79-plan.md` §5.1 item 8. *Proof verdict:* closes. *Rests on it:*
(Q-rig)'s target-grade form; FS-59's route (ii). *Prior art:* `[Fischer1990b]` (prime inversion for real quadratic fields). *Kernel:*
declined (FS-47 holds prime inversion's kernel form).

**T3 — Plain density of periodic four-colourings is false in rank 1: FS73-T30's four walls are one-way. [tools, three independent checks; Poros (plan), the planner, the owner]**
For `D = {1,5,7,10}`, `{3,5,9,10}`, `{3,7,9,10}`, `{5,7,9,10}`, the window-state graph of `G(ℤ, D)` modulo colour permutation,
restricted to essential states, has edges between distinct strongly connected components — local patterns that occur in a four-colouring
and in no periodic one: 8, 4, 24 and 2 such edges; without the quotient 192 and 96 on the first two (the owner's own code, 24 times
each); zero on the controls `{1,3,4,5}`, `{1,2,4,8}`, `{2,3,5,9}` and on every three-colour control; Poros's SAT check found the pattern in
no periodic colouring up to period 60. Existence (`[EggletonErdosSkilton1990]`) and `P = F = 0` (FS73-T30) hold on the same graphs, so
the live forms are existence and inheritance; `S` need not generate, so the failure holds in every rank. *Proof:* plan §IQ item 2;
`data/fs79/checks/{rank1_density.py, rank1_density_scan.py, planner_rank1.py, owner_rank1_check.py}`. *Proof verdict:* closes (exact
enumeration). *Rests on it:* (Q)'s restatement as existence plus inheritance; FS-76's re-aim. *Prior art:* `[EggletonErdosSkilton1990]`
(aperiodic colourings may coexist with periodic ones in rank 1). *Kernel:* declined.

**T4 — In rank 1 the window-frequency programme is exact, so window frequencies are not controlled by `χ_f`. [hand; the owner (review finding 1), checked by Poros (plan) and the modeling agent]**
A shift-invariant probability on the legal windows of length `max D + 1` is a circulation on the window-state graph; a circulation
exists iff the graph has a cycle iff the colouring space is nonempty. So the invariant-measure LP at that window decides rank 1, and it
refutes `G(ℤ, {1,3,7,12,17,22})` at four colours although `χ_f ≤ 29/8` (T5). One-point densities (colour-class densities) are the
kind `χ_f` controls. Poros's strengthening, a **reading** for FS-73's certificate: the slope is the invariant mean of a pair-cylinder
function, so `Θ₃ = ∅` is a two-point-density certificate plus the integrality of the winding. *Proof:* plan §R-review finding 1;
`plans/POROS-2026-09-23-fs79-plan.md` §5.4. *Proof verdict:* closes (the rank-1 argument); the Θ₃ reading is a reading. *Rests on it:*
§IQ's split of Kind 0 into 0₁ and 0_W; (Q-obs)'s success test restated by size. *Prior art:* standard (circulations on de Bruijn-type
graphs). *Kernel:* declined.

**T5 — The rank-1 benchmark and its sibling. [tools exact; Poros (plan), the modeling agent, independently]**
`D = {1,3,7,12,17,22}` is sum-free (so `G(ℤ, D)` is triangle-free), `{0,2,4,6,10,15,20,25}` is independent mod 29 (so `χ_f ≤ 29/8`),
four colours are refused on 33 consecutive points and possible on 32 (Glucose4 bisection, Minisat22, CaDiCaL), and its window-state
graph has 3,555 states modulo colour permutation, none essential. `D = {1,6,8,11,12}`: K₄-free, not four-colourable, 2,348 window states
none essential, independence density ≥ 1/4 from a period-20 set (Poros reports exactly 1/4). So in rank 1 the transfer certificate is
about as large as the plain refutation, and rank 1 is uninformative for a size test. *Proof:* `data/fs79/checks/{bench_recheck.py,
modeling_rank1_bench.py, modeling_rank1_states.py}`. *Proof verdict:* closes. *Rests on it:* (Q-obs)'s benchmark and the refutation-rank
requirement (T7). *Prior art:* none. *Kernel:* declined.

**T6 — Lemma D1 (canonical form): `Cay(Λ, S)` is a disjoint union of copies of `Cay(⟨S⟩, S)`, so its colourability and `F` are those of `⟨S⟩`. [hand; the modeling agent]**
Hence every face is posed with `Λ = ⟨S⟩` and `r = rank ⟨S⟩`. The same for `P` when a periodic colouring exists is **only sketched**
(residual finiteness; FS73-T24's care with saturation). *Proof:* plan §D.1. *Proof verdict:* closes for colourability and `F`; the `P` half
is a sketch (no claim leaned on it). *Rests on it:* the class's rank parameter. *Prior art:* standard. *Kernel:* declined.

**T7 — Lemma D2 and the refutation rank `ρ₄`: rank alone is met trivially, so (Q-obs) asks for `ρ₄ ≥ 2`. [hand; the modeling agent]**
`G(ℤ, {1,3,7,12,17,22}) □ ℤ = Cay(ℤ², {(±d, 0)} ∪ {(0, ±1)})` has rank 2, is K₄-free (a clique of a Cartesian product lies in one
fibre), is not four-colourable and has `χ_f ≤ 29/8` (the larger factor's) — so the plan's "no rank-≥2 K₄-free graph with certified
`χ_f ≤ 4` and `χ = 5` is known" was false (close-inventory item 44). `ρ₄` := the least rank of a subgroup `L` with `Cay(L, S ∩ L)` not
four-colourable; `ρ₄ ≥ 2` is decidable (the rank-1 pieces are distance graphs, FS73-T28), and every unit-distance lattice graph has it
free (a line through 0 holds at most one ± pair of unit vectors). *Proof:* plan §D.2. *Proof verdict:* closes. *Rests on it:* (Q-obs)'s
class. *Prior art:* χ_f of Cartesian products (standard). *Kernel:* declined.

## §2. Phase 0: ℚ(√167)'s lattices at four colours (the phase-0 implementer; the owner's checks)

**T8 — `L21cc6506` (= Λ₄₂₀, the lattice of row 79) is four-colourable, additively and linearly. [cert + hand; the phase-0 implementer; the owner's independent recount]**
Exactly 8 homomorphisms `Λ₄₂₀ → ℤ/4` are nonzero on all 60 unit vectors, none into `V₄`; none is gapped, necessarily (`φ(U) = −φ(U)`
and an all-odd `φ` would two-colour the graph, so `φ(U) = {1, 2, 3}`). A second rule: the Θ₄ point θ = (799/840, 199/280, 1/2, 631/980)
on the LLL basis, period index 5,880, not in Θ₃. *Proof:* `data/fs79/records/phase-P0.md`, theorem 1; witnesses
`data/fs79/phase0/witnesses/L21cc6506-*.json`, CERTIFIED by `tools/fs79_p0_check.py`; the owner's code
`data/fs79/checks/owner_l21_z4_check.py`. *Proof verdict:* closes. *Rests on it:* row 81; route (ii) moved to T38–T40. *Prior art:*
consistent with `[Fischer1990]` Ex. 4 (no additive `k`-colouring of the **full** plane for `k < 11`): the obstruction lives above this
lattice. *Kernel:* declined.

**T9 — The saturated chain: `U(Λ_M) = U_M`, `Λ_X ⊆ Λ_Y` iff `X | Y` on true denominators, colourability passes down and refusal up, and `Λ₄₂₀ = L21cc6506`. [hand; the phase-0 implementer]**
*Proof:* phase-P0.md, theorem 2. *Proof verdict:* closes. *Rests on it:* the survivors' minimality and the non-minimal survivors'
verdicts by containment (each contains Λ₄₂₀₀). *Prior art:* none. *Kernel:* declined.

**T10 — Circular forms `⌊4{φ(x)}⌋` are Θ₄ points, so the circular screen is covered by the Θ₄ screen wherever that is exhaustive. [hand; the phase-0 implementer]**
*Proof:* phase-P0.md, theorem 3. *Proof verdict:* closes. *Rests on it:* the screen order. *Prior art:* FS73-T22's ⟸ half. *Kernel:* declined.

**T11 — The residue sets of the circle mod 23 at four colours. [tools exact, refusals replicated; the phase-0 implementer]**
Of 224 dihedral orbits, 203 colour, 20 refuse, 1 is UNKNOWN at 60 s (`(0,1,3,4,6,7,9,10)`); monotone. Every colourable orbit but the
empty set colours by a linear form, and every one has a gapped colouring. Minimal refusing sets: `(0,1,2,3,4,6,10)` (7 pairs, the
smallest), `(0,1,2,3,4,5,6,9)`, `(0,1,2,4,6,7,8,10)`, `(0,1,2,4,5,6,8,9,10)`; maximal colourable: `(0,1,2,3,4,5,6,7)`,
`(0,1,2,4,5,6,8,10)`, `(0,1,2,3,4,5,7,8,9,10)` (10 pairs). The full circle refuses (Hoffman 4.0148 > 4; Schrijver's ϑ′ 131.76 < 529/4).
Port control: at `k = 3` the same code reproduces implementer C's table exactly (224 / 98 / 126). *Proof:*
`data/fs79/phase0/classify-q23-k4.jsonl`; phase-P0.md, theorem 4. *Proof verdict:* closes at the budget (one orbit UNKNOWN). *Rests on it:*
 the sweep's candidate test. *Prior art:* FS73-T19 (three colours). *Kernel:* declined.

**T12 — No unit vector over any of 2,586 denominators has 23 or 43 in its denominator (integrality at the stable primes). [tools, asserted on every M; the phase-0 implementer, the owner's addition]**
*Proof:* phase-P0.md, theorem 5. *Proof verdict:* closes on the range. *Rests on it:* the sweep's deduplication. *Prior art:*
`[Fischer1990b]` (p-integrality of unit vectors at stable primes). *Kernel:* declined.

**T13 — The sweep: 2,586 denominators, 370 distinct rank-4 lattices, 115 candidates (smallest `M = 264`), and the price of a degree-18 ball. [tools exact on `U_M`; the phase-0 implementer]**
The range is a finite part of the chain: every `M ≤ 2,520`, then the multiples of 420 and 2,520 up to 30,240. Drops: rank 2 (289),
3-integral (143), a residue set at 23 or 43 colours (97), undecided at one 43-set (15). Candidates carry 36–852 unit vectors; degree-18
ball prices 1.38·10⁸ (`M = 540`) to 1.16·10¹⁵ points. **The prices are of balls at G65's three-colour degree aim; the four-colour
hardness band is unmeasured, so they are not the cost of a refutation.** *Proof:* `data/fs79/phase0/sweep.jsonl`; phase-P0.md, theorem
6. *Proof verdict:* closes on the range. *Rests on it:* row 81; FS-59. *Prior art:* FS61-T5 (the degree law). *Kernel:* declined.

**T14 — Additive survival: 141 of the 370 lattices have no additive four-colouring into ℤ/4 or V₄ (the smallest Λ₈₈); along the multiples of 420 the first is Λ₈₄₀. [tools exact; the phase-0 implementer]**
At the multiples computed, ℤ/4-colourings exist exactly when `8 ∤ M` — **observed, not proved** (§6, reading R1). *Proof:*
`data/fs79/phase0/additive.jsonl`; phase-P0.md, theorem 7. *Proof verdict:* closes for the table; the pattern is a reading. *Rests on it:*
 nothing downstream. *Prior art:* G41's exponent obstruction; `[Fischer1990]` Ex. 4. *Kernel:* declined.

**T15 — The four-colour screens: 118 of 130 lattices four-colourable (39 loose by a fan gap); 12 survivors, 7 minimal — at the screens listed, not refusals. [cert where CERTIFIED, tools otherwise; the phase-0 implementer]**
First rules: additive 64, gapped residue 36, linear Θ₄ point 10, full quotient 8; all 159 witnesses CERTIFIED by
`tools/fs79_p0_check.py` with planted controls per kind (and the owner's three plants, close-inventory item 63). The ramified prime 167
colours 36 lattices; **Λ₂₅₂₀ is loose** (a gapped residue colouring at 167). Minimal survivors Λ₂₄₄₈ (84 unit vectors), Λ₂₃₂₈ (92),
Λ₂₄₀₀ (100), Λ₄₂₀₀ (180), Λ₁₀₉₂₀ (324), Λ₁₄₂₈₀ (324), Λ₂₄₃₆₀ (852); five more contain Λ₄₂₀₀. A survivor is one that capped screens did
not colour: additive (exhaustive), Θ₄ by a float-LP finder capped at 60 s (not an emptiness certificate), residue targets at a 15–30 s
budget, quotients at `N ≤ 12`. *Proof:* phase-P0.md, theorem 8 and the survivor table; `screen.jsonl`, `verdicts.jsonl`,
`quotients.jsonl`. *Proof verdict:* closes for every coloured row; the survivor rows are typed nulls. *Rests on it:* row 81; §IQ item 5;
P3b. *Prior art:* none. *Kernel:* declined.

**T16 — No survivor's image colours at the ramified prime 167 at 300 s; three 72-point images have no gapped four-colouring there by one solver's UNSAT, unchecked. [tools, one solver, no proof checked; the owner]**
Seven distinct images cover all twelve survivors (24, 40, 40, 72, 72, 72, 56 points), each asked gap-aimed and plain by kissat with an
edge pin and precedence, after interval forms and the Hoffman floor (floors 2.50–3.83 < 4). Gap-aimed UNSAT on Λ₁₀₉₂₀ (94.65 s),
Λ₁₄₂₈₀ (83.97 s), Λ₂₄₃₆₀ (37.36 s); every other ask UNKNOWN at 300 s. *Proof:* `data/fs79/phase0/owner-recheck-167.jsonl`;
`data/fs79/checks/recheck167.py`. *Proof verdict:* a typed null plus three unchecked refusals (no LRAT, no second solver). *Rests on it:*
Poros (competition)'s card 1, scored a typed null. *Prior art:* none. *Kernel:* declined.

## §3. The competition (de Bruijn, Coxeter, Poros (competition))

*The class 𝒞 is Cayley graphs `Cay(Λ, S)`, `Λ` finitely generated torsion-free abelian, `S = −S` finite, `0 ∉ S`, in canonical form
`Λ = ⟨S⟩`. The edge-local format (Kind 1_edge) is the one Poros (competition) pinned for both competitors
(`data/fs79/checks/poros-competition/pinned-1edge.txt`): closedness on commutator squares only; the winding on relations and the slope as
the certificate's data; the checker never tests a window larger than one square.*

**T17 — The ℤ/2 winding of FS73-T29 is the relation's length parity: the colour complex's loops give a four-colouring no invariant of its own. [hand; Coxeter (C1), Poros (competition) independently; the owner checked]**
`K₄ × K₂ ≅ Q₃` is `K₄`'s bipartite double cover; the lift is `c̃(x) = (c(πx), |x| mod 2)`, so the winding on `ρ ∈ R` is `‖ρ‖₁ mod 2`
for every colouring — a character of the graph. **Scope:** this is the loop invariant of `K₄`'s square complex; cocycles reading wider
windows are open (`[CGHO2025coh]` Thm 5.8's route), so "no loop invariant at all" overreaches (close-inventory item 71). *Proof:*
`plans/FS79-C-Coxeter.md` C1; Poros's hunch `the-z2-winding-is-forced`. The owner: `K₄ × K₂ ≅ Q₃` by brute-force isomorphism; on 223
random closed walks the lift closes iff the length is even. *Proof verdict:* closes. *Rests on it:* the correction of G71 and FS73-T29.
*Prior art:* `[CGHO2025coh]` (square group ℤ/2 for `K₄`, standard generators). *Kernel:* declined.

**T18 — C1(a): if every generator lies in the component of its negative in the non-triangle graph `𝒢_S`, every four-colour edge-local cocycle is trivial (coboundary plus homomorphism). [hand + tools exact; de Bruijn; read by Poros (competition)]**
`𝒢_S` joins `s ~ t` iff `s ≠ ±t` and `{0, s, t}` is not a triangle. The `abcb` pattern makes `A_s − A_t` constant along `𝒢_S`-edges
(it needs a fourth colour, which is why three-colour heights exist); `s ~* −s` makes the symmetric part constant; the rainbow `abcd`
pattern makes the antisymmetric part a closed cochain on `K₄`'s square complex, exact over ℚ (`H¹(ℝP²; ℝ) = 0`). Step 3 as first
written was retracted (de Bruijn's retraction 1, found by Poros) and replaced by Lemma D (T19). Exact check: mod-p nullity meets the
substituted trivial dimension on 13 presentations (grid ℤ², ℤ³; ℤ[ζ₆] extra 2; `Cay(ℤ,{1,2,3})` extra 2; de Grey's lattice 30 = 30;
Λ₄₂₀ 33 = 33; Λ₂₄₄₈ 45 = 45; Λ₂₄₀₀ 53 = 53; …), two plants refused. *Proof:* `plans/FS79-C-deBruijn.md` §2, §2a; its tools in
`data/fs79/comp-debruijn/tools/`. *Proof verdict:* closes. *Rests on it:* T21; row 80; G73. *Prior art:* the grid case is `[CGHO2025coh]`
Thm 1.1's edge-local shadow. *Kernel:* declined.

**T19 — Lemma D: if some component of `𝒢_S` contains a pair `±s`, then `𝒢_S` is connected. [hand; de Bruijn; read by Poros (competition)]**
By an extreme functional `ℓ` on `S`: the maximiser and its negative lie in that component, and any element outside it would push `S`
past its extreme. *Proof:* `plans/FS79-C-deBruijn.md` §2a. *Proof verdict:* closes; checked on 57,718 generating sets (each connected or
exactly two ±-swapped components). *Rests on it:* T18 (replaces its retracted step 3), T20. *Prior art:* none. *Kernel:* declined.

**T20 — Lemma S: if `𝒢_S` is disconnected, `S` is `±{a}`, `±{a, 2a}` or `±{a, b, a+b}` (rank ≤ 2): a sum-closed half. [hand; de Bruijn; read by Poros (competition)]**
*Proof:* `plans/FS79-C-deBruijn.md` §2a (extreme functional; all 126 split cases of the 57,718 checked have this form). *Proof verdict:*
closes. *Rests on it:* T21. *Prior art:* none found. *Kernel:* declined.

**T21 — C1 complete: a non-trivial four-colour edge-local height exists iff `S` has a sum-closed half, and every such graph is four-colourable — so the edge-local format accepts no certificate on any graph of 𝒞 at four colours. [hand; de Bruijn; read by Poros (competition)]**
On the split presentations the height is Moore–Newman's, generalised: `A_s(a, b) = σ(s)·E(a ⊕ b)` with colours in `V₄` and `E` the
three vectors of an equilateral triangle. Four-colourability of the split forms: two colours, three colours, a Θ₃ point, and for a
dependent `±{a, b, a+b}` (a distance graph `G(ℤ, {p, q, p+q})`) a direct stripe colouring descended from the triangular lattice, which
replaced a recalled, unread lonely-runner citation. Among unit-distance lattice graphs of rank ≥ 2 only ℤ[ζ₆] has a non-trivial one;
de Grey's lattice has none (C1(c)). Coxeter's reading that the format never accepts non-degenerately on a K₄-free graph (its Q1) is
this theorem, proved by de Bruijn. **Scope:** the edge-local format only. *Proof:* `plans/FS79-C-deBruijn.md` §2a, §7. *Proof verdict:*
closes; scored met on OBS-N1–N4. *Rests on it:* row 80; G73; FS-76's certificate question. *Prior art:* `[MooreNewman2000]` §III (the
triangular lattice's height); `[CGHO2025coh]` (the grid). *Kernel:* declined.

**T22 — C1ₖ: at `k ≥ 5` colours no presentation with at least two generator classes carries a non-trivial edge-local height; at `k = 4` the split case has exactly two extra dimensions. [hand, checked at k = 3–6; de Bruijn; the Kneser step re-derived by Coxeter; the owner checked the combinatorial fact]**
Adding the rainbow square identity in the orderings `(a,b,c,d)` and `(b,a,d,c)` gives `Sym(a,b) = Sym(c,d)` for disjoint colour pairs,
so the symmetric part is constant on the components of the Kneser graph `KG(k, 2)`: three components at `k = 4` (`K₄`'s perfect matchings,
`V₄`'s non-zero elements), leaving two free dimensions, and connected for `k ≥ 5`. De Bruijn's "cross squares" derivation was retracted
by him (retraction 2) and replaced; the conclusion stands. **Scope:** presentations with `n ≥ 2` generator classes (`n = 1` has no
squares); the edge-local format. *Proof:* `plans/FS79-C-deBruijn.md` §2b; Coxeter's re-derivation (close-inventory item 85: holds, nothing
to repair); the owner: `KG(4,2)` has 3 components, `KG(k,2)` connected for `k = 5…8`, a plant discriminates (item 82). *Proof verdict:*
closes. *Rests on it:* G73 ("one dimension up" answered negatively for this format, not for π₂-type fluxes). *Prior art:* none found.
*Kernel:* declined.

**T23 — C1-L: the same theorem on the language of the colouring shift, given two occurrence conditions; so de Grey's four-colourings carry no edge-local height even on their own language. [hand + tools exact; de Bruijn]**
If every `s` is joined to `−s` in the graph of `abcb` occurrences and some colouring has a rainbow commutator square, every edge-local
cocycle of `X` is trivial. Exact on all 9,120 of de Grey's colourings (30 = 30) and on `L21cc6506`'s exhibited colourings (33 = 33).
*Proof:* `plans/FS79-C-deBruijn.md` §4. *Proof verdict:* closes. *Rests on it:* FS-74's re-aim (de Grey's rigidity is not an edge-local
height). *Prior art:* none. *Kernel:* declined.

**T24 — C3, the square lemma: at four colours an edge-local form closed on an induced square is `δg + κ`, over ℚ; so edge-local heights are trivial on every triangle-free Cayley graph with two ± pairs. [hand + tools exact; Coxeter; the owner's 𝔽₂ check]**
Reached independently of T18 (Poros (competition) found it in Coxeter's first route before the misrouted hand-back, close-inventory
items 66, 75). Over 𝔽₂ the three 4-cycles of `K₄` have rank 2, so the lemma is characteristic-dependent and true over ℚ (the owner,
item 72). Coxeter's retraction R2: the format first demanded closedness on every relation cycle, which forces winding 0 and excludes
FS-73's height; corrected to commutator squares with the winding as datum, controls recomputed (triangular lattice 8 against 6,
Moore–Newman's two; grid 5/5; `G(ℤ,{1,3})` 5/5). *Proof:* `plans/FS79-C-Coxeter.md` C3. *Proof verdict:* closes (scored met under the
pinned format). *Rests on it:* row 80; G73; the G51 convergence count. *Prior art:* `[CGHO2025coh]` Thm 1.1 (grid). *Kernel:* declined.

**T25 — C7: every continuous edge-local cocycle of `X(L21cc6506, U, 4)` is `δg + κ`; and monopoles occur on 2,889 of its 4,060 generator triples. [tools exact on exhibited colourings + hand; Coxeter]**
On 3,000 colourings of `Λ/4Λ` and 600 of `Λ/8Λ`, 378 of the 435 direction pairs show all four square types and their graph is
connected; the 57 misses are sampling artifacts (the missing identifications are SAT at `N = 4, 8`). *Proof:* `plans/FS79-C-Coxeter.md`
C7. *Proof verdict:* closes. *Rests on it:* T23's instance, independently. *Prior art:* none. *Kernel:* declined.

**T26 — C2, as narrowed: the coindex topological bounds are at most 4 on every K₂,₃-free graph, so on every unit-distance graph; the index bounds are not covered. [prior art applied + hand; Coxeter; the scope narrowed by the owner's reading of the paper]**
`[SimonyiTardos2006]`'s Zig-zag Theorem is stated for topologically `t`-chromatic graphs, `coind(B₀(G)) ≥ t − 1`: every proper
colouring then holds a completely multicoloured `K_{⌈t/2⌉,⌊t/2⌋}`, and `t = 5` needs a `K₃,₂`, which two unit circles cannot hold. So
`coind(B₀) + 1`, `coind(H) + 2` and Lovász's `conn(N) + 3` certify at most four on unit-distance graphs. **`ind(B₀(G)) + 1` and
`ind(H(G)) + 2`, which chain (1) of the paper places above them, are not constrained.** Coxeter's scope sentence ("every topological bound
of the hierarchy; Lovász's `conn(N(G)) + 3` the strongest") overclaimed and inverted the ranking; also `S^{t−2} → B₀(H)` should read
`S^{t−1}` (close-inventory item 90). *Proof:* `plans/FS79-C-Coxeter.md` C2; `BIBLIOGRAPHY.md` `[SimonyiTardos2006]` (read §2, §3.2, §3.3).
*Proof verdict:* closes for the coindex format. *Rests on it:* G30's topology sentence; FS-9's bearing. *Prior art:*
`[SimonyiTardos2006]` (the theorem); the unit-distance corollary is one line, probably folklore, not found stated. *Kernel:* declined.

**T27 — The cube lemma: `Q₃` has 2,652 proper four-colourings, 24 of them monopoles; with parity-dependent values the face-local 2-forms have `H² = 0`, and `H² = 1` (the skyrmion class) once the monopoles are excluded; parity-free, `H² = 0` either way. [tools exact; Coxeter; recomputed by Poros (competition)]**
*Proof:* `plans/FS79-C-Coxeter.md` C4 (rank at two 31-bit primes); Poros's independent recomputation, `data/fs79/checks/poros-competition/p3/`
(parity-free closed = exact = 33 with or without monopoles, at `2³¹ − 1` and `2⁶¹ − 1`; the sheet-dependent control 65/66 against 65).
*Proof verdict:* closes. *Rests on it:* T29; the owner's held item H-A killed in its local form. *Prior art:* none found. *Kernel:*
declined.

**T28 — The rhombus lemma: four unit vectors of the plane with zero sum form two opposite pairs; so no generator triple of a unit-distance lattice graph has a body-diagonal chord. [hand; Coxeter]**
In a triangle-free one every pair of non-parallel generators spans an induced square and every triple an induced 3-cube (checked on
`L21cc6506`: 435 pairs, 4,060 triples, 0 chords; and on Λ₂₄₄₈, Λ₂₃₂₈, Λ₂₄₀₀). *Proof:* `plans/FS79-C-Coxeter.md` C4. *Proof verdict:*
closes. *Rests on it:* T29's reach. *Prior art:* elementary. *Kernel:* declined.

**T29 — C4, with the repair: where there are at least three pairwise non-parallel directions, every pair spans an induced square and every triple an induced 3-cube, every closed parity-free face-local 2-form is `dη + κ` globally, and its flux is the same for every colouring. [tools exact + hand; Coxeter; the gluing re-derived by Poros (competition), who added the repair]**
With two directions the triple condition is vacuous and the conclusion false (84 square patterns against at most 25 exact dimensions,
e.g. ℤ[i]); nothing downstream breaks (no relation torus there), and every ℚ(√167) lattice has at least 18 directions. The
parity-free format is the only one a non-bipartite Cayley graph admits. *Proof:* `plans/FS79-C-Coxeter.md` C4;
`plans/POROS-2026-09-24-fs79-competition.md` §7. *Proof verdict:* closes with `n ≥ 3`. *Rests on it:* row 80; G73. *Prior art:* none
found. *Kernel:* declined.

**T30 — C4′: on every non-bipartite graph the signed flux through an even relation torus is slaved to the monopole charge swept, `deg(Σ) = −Q/2`, and averaged signed densities vanish. [hand; Poros (competition)'s reading, registered first, checked by Coxeter; de Bruijn checked the premise]**
An odd relation acts on the `Q₃`-lift as the antipode for every colouring (T17), and the antipode reverses `S²`. *Proof:*
`plans/FS79-C-Coxeter.md` C4′; Poros's hunch `the-mean-flux-vanishes`. *Proof verdict:* closes. *Rests on it:* the held items H-A and H-P2
declined as routes by both competitors. *Prior art:* none found. *Kernel:* declined.

**T31 — The Kempe period group of an additive four-colouring: `KPer(φ) = ⟨U₂⟩ ∩ ⟨U₁ − U₁⟩`; on `L21cc6506` each of the 8 has index 8 and their intersection index 64. [hand + tools exact; Coxeter]**
*Proof:* `plans/FS79-C-Coxeter.md` C6 (the lemma); `data/fs79/comp-coxeter/work/kper_additive.py`. *Proof verdict:* closes.
*Rests on it:* nothing now (route (ii) at `L21cc6506` is dead by T40). *Prior art:* FS73-T1 (the Kempe period group). *Kernel:* declined.

**T32 — The census of `L21cc6506`'s 4Λ-periodic colourings: 266,928 pinned colourings of `Λ/4Λ` in 4,490 orbits, every Kempe period group of rank 4, their intersection exactly 12Λ. [tools exact, complete; Coxeter]**
With the two phase-0 Θ₄ colourings the intersection has index 1,778,112,000 and contains 29,400·Λ — an upper bound on `P`,
**superseded** by T33 and T40 (`P = 0`), not retracted. No gapped colouring at `N = 4, 8`. Coxeter's retraction R1 ("the colouring
space may be small") was killed by this count. *Proof:* `plans/FS79-C-Coxeter.md` §4 (C8); `data/fs79/comp-coxeter/work/kper_orbits.py`. *Proof verdict:*
closes for the period searched. *Rests on it:* the G21 instance (a one-period census is blind to looseness at unbounded periods).
*Prior art:* none. *Kernel:* declined.

**T33 — C8′: the order-4,200 Θ₄ cell of `L21cc6506` is a point and the order-5,880 cell has dimension 2 with constant set exactly the rational pattern `U_R`; so its four-colouring space is infinite. [tools exact + hand; Coxeter; the owner verified by LP; P3 confirmed exactly]**
By FS73-T22's ⟸ direction the 2-cell's rational points give periodic colourings of unbounded period, so `P` has rank ≤ 2 (T37 of FS-73).
Coxeter's C6 had read "empty interior" as a point (its own G21 instance, caught by Poros's question on dimension). *Proof:*
`plans/FS79-C-Coxeter.md` §4 (C8′); close-inventory item 86 (the owner's LPs: singular values 0.028, 0.010; exactly 12 constant unit
vectors, all rational; a planted off-band θ refused); P3-T5. *Proof verdict:* closes. *Rests on it:* T40 made it moot for route (ii).
*Prior art:* none. *Kernel:* declined.

**T34 — C2 (de Bruijn): a counterexample to inheritance periodic in `r − 1` directions has two distinct rigid ends, at least one chiral, so never an additive end; with Coxeter's repair when `Λ/W` has torsion. [hand; de Bruijn; read by Poros (competition); re-derived by Coxeter]**
Two achiral ends would close a cycle of walls through the ends' phases. The repair: when `Λ/W` has torsion and δ's image is `(0, τ ≠ 0)`,
"every W-periodic colouring is δ-periodic" fails; assume `W` saturated, or state rigidity only when `j ≠ 0` (period `j·ord(τ)`); the
wall and the chirality survive. It proves Coxeter's FS-73 reading (FS73 §8) as a theorem, any `k`. It ships no inhabitant of its full
hypothesis: that would be a counterexample. *Proof:* `plans/FS79-C-deBruijn.md` §3; close-inventory item 85. *Proof verdict:* closes in
rank 1; with the repair in general. *Rests on it:* FS-76's re-aim. *Prior art:* none. *Kernel:* declined.

**T35 — The exact rank-1 criterion at four colours: `P ≠ F` iff every cyclic phase of the window-state graph is a single cycle and a wall exists. [hand; de Bruijn; both directions read by Poros (competition)]**
On FS73-T30's walls the conditions of T34 are met (rigid chiral ends joined by walls) and yet `P = F = 0`, because a positive-entropy
phase elsewhere carries periodic points of unbounded least period: T34 is necessary and far from sufficient. *Proof:*
`plans/FS79-C-deBruijn.md` §3a; `data/fs79/comp-debruijn/tools/rank1_phases.py`. *Proof verdict:* closes. *Rests on it:*
T36; FS-76. *Prior art:* FS73-T30's wall criterion (one direction). *Kernel:* declined.

**T36 — The exhaustive rank-1 scan: no counterexample to C3-inherit at four colours among the 2,706 sets with `11 ≤ max D ≤ 14`, `3 ≤ |D| ≤ 5`, gcd 1. [tools exact; de Bruijn]**
194 not four-colourable; 2,023 with a positive-entropy phase and no wall; 112 with walls, every one beside a positive-entropy phase; 377
with every phase rigid, none with a wall. With FS73-T30 (`max D ≤ 10`), rank-1 inheritance holds for every `max D ≤ 14`, `|D| ≤ 5`.
The scan measures its range. *Proof:* `data/fs79/comp-debruijn/runs/rank1_scan.jsonl` (md5 `46a1c86a…`). *Proof verdict:* a typed
null on its range. *Rests on it:* reading R2 (§6). *Prior art:* none. *Kernel:* declined.

**T37 — In de Grey's lattice each of the 48 non-Eisenstein unit vectors lies alone in its coset of the Eisenstein sublattice `T₀`, so the cosets are coupled by single matchings. [tools exact; de Bruijn]**
By G14 no pair of cosets presses on its own, so the stripes and `F = 8Λ` are a many-layer effect. *Proof:* `plans/FS79-C-deBruijn.md`
§7; `data/fs79/comp-debruijn/tools/degrey_cosets.py`. *Proof verdict:* closes. *Rests on it:* FS-74's re-aim. *Prior art:* `[Hubai2018]` (the stripes).
*Kernel:* declined.

## §4. Verification (P3: the P3 implementer, the owner)

**T38 — P3-T1: θ₀ = (−4723/324, −1196/81, 1/324, −73/648) on the dual-LLL basis puts every unit vector of `L21cc6506` strictly inside the band with margin 1/324, so the ℓ∞-ball of radius 1/(324·298) about θ₀ lies in one full-dimensional cell of Θ₄. [cert + hand; the P3 implementer; the owner verified]**
*Proof:* `data/fs79/records/phase-P3-theta4.md` step 1; `data/fs79/p3/fulldim-cell-witness.json`, CERTIFIED by the untouched
`tools/fs79_p0_check.py`; the owner (close-inventory item 92): the basis spans exactly Λ₄₂₀, the margin is exactly 1/324, the largest ℓ¹
norm is 298, 200 random rational perturbations in the ball stay in band, a planted θ₀ + 1/8 is refused. *Proof verdict:* closes.
*Rests on it:* T40. *Prior art:* none. *Kernel:* declined.

**T39 — P3-T2: for rational θ ∈ Θ₄ and δ with θ(δ) ∉ ℤ, some rational β makes `⌊4{θ(x) + β}⌋` a proper periodic four-colouring separating 0 and δ. [hand; the P3 implementer]**
The argument is colour-generic: at `k` colours, a full-dimensional cell of Θ_k gives `P = F = 0` the same way (at three colours this is
FS73-T24's dichotomy, one direction). *Proof:* phase-P3-theta4.md steps 2–3. *Proof verdict:* closes. *Rests on it:* T40; G73's
instrument. *Prior art:* FS73-T22 (⟸). *Kernel:* declined.

**T40 — P3-T3: on `L21cc6506` at four colours `P = F = 0`: no pair is forced, so G55's chain has no input there. [derived (T38, T39, FS73-T36); the P3 implementer]**
Route (ii) is dead on this lattice; C3-inherit holds there trivially. **Not implied:** anything on other ℚ(√167) lattices, or on whether
ℚ(√167)'s plane needs five. *Proof:* phase-P3-theta4.md steps 4–5. *Proof verdict:* closes. *Rests on it:* row 81; FS-59's re-aim; the
G21 and G68 corrections. *Prior art:* none. *Kernel:* declined (it closes a route; nothing consumes it in the kernel).

**T41 — P3-T4: the smoke census, PARTIAL — slabs 0 and 1 of 210 hold 28 translation classes of Θ₄ cells (22 of dimension 4, 4 points, 2 of dimension 2), with an empty intersection of constant sets. [tools exact, partial; checker-certified; the P3 implementer]**
159,641 nodes, 28,540 dead ends, 34 leaves, no Farkas nodes; CERTIFIED by the standalone `tools/fs79_p3_theta4_check.py` with four
planted faults refused. **Not claimed:** the total cell count or the full distribution (the full tree, about 1.7·10⁷ nodes, was ruled
out of scope once T40 held). The checker verifies the constant lists, not the summary counts beside them (the owner's plant, item 96).
Controls: Θ₃ on the same slabs has 0 leaves; dropping one ± pair gives 57 classes against 28. *Proof:* `data/fs79/p3/smoke-k4*`,
`smoke-k4-checker-run.txt`. *Proof verdict:* closes on its two slabs. *Rests on it:* nothing beyond T38. *Prior art:* none. *Kernel:*
declined.

**T42 — P3-T5: the order-4,200 point's cell is a point (60 constant unit vectors); the order-5,880 point's cell has dimension 2, constant set exactly `U_R` (12), 8 at a band edge in its relative interior. [tools exact; the P3 implementer]**
The exact confirmation of T33; Coxeter's "12 tight" is the constant count. *Proof:* `data/fs79/p3/known-points-cells.json`. *Proof verdict:*
 closes. *Rests on it:* T33. *Prior art:* none. *Kernel:* declined.

**T43 — P3-T6 and P3-T7: no four unit vectors of `L21cc6506` form a ℤ-basis (least index 34,650, eight quadruples); among the five layers `b·U_R`, the joint map of (1, v) or (1, v̄) has the least |det|, 1,102,500 = 1,764·5⁴. [tools exact; the P3 implementer]**
P3-T6 reproduces FS73-T44 independently; P3-T7 makes the full Θ₄ tree intrinsically about 10⁷ nodes. *Proof:* `tools/fs79_p3_theta4.py`
(the determinant histogram). *Proof verdict:* closes. *Rests on it:* the tree's price. *Prior art:* FS73-T44. *Kernel:* declined.

## §5. The survivors (P3b: the P3b implementer)

*P3b's record: `data/fs79/records/phase-P3b-survivors.md` (registration `8a5e9903`, result `99523d6c`); its "Theorems this phase
proved" P3b-T1…T6 are T44–T49 below. Tool `tools/fs79_p3b_theta4.py`; data `data/fs79/p3b/`; every witness CERTIFIED by the
untouched `tools/fs79_p0_check.py` (`data/fs79/p3b/checker-run.txt`), and the owner re-certified the three-colour witnesses and saw
his plant (`L21cc6506`'s loose witness read at `k = 3`) refused THETA_OUT_OF_BAND.*

**T44 — P3b-T1: `L21cc6506` has a Θ₄ cell of maximum margin exactly 3/56, reconfirming `F = P = 0` at four colours. [cert + tools exact + hand; the P3b implementer]**
P3's witness point had margin 1/324; the finder's control run found the cell's exact maximum 3/56 (the point used has margin
1289/32204). *Proof:* `data/fs79/p3b/witnesses/L21cc6506-theta4-loose.json`; `steps.jsonl`; P3's five-step argument (T38–T40).
*Proof verdict:* closes. *Rests on it:* the finder's positive control. *Prior art:* none. *Kernel:* declined.

**T45 — P3b-T2: Λ₁₃₄₄, Λ₁₅₈₄ and Λ₂₃₅₂ are four-colourable and loose at four colours (`F = P = 0`), by cells of maximum margin 141/668, 173/11844 and 93/668. [cert + hand; the P3b implementer]**
Phase 0 had them only as four-colourable. They were the finder's calibration: known positives at the survivors' coefficient size (ℓ¹
up to 1,548 against the survivors' 1,644–17,430), each found loose within 150 s. None is on the instance list. *Proof:*
`data/fs79/p3b/witnesses/{1344,1584,2352}-theta4-loose-cal.json`; P3's argument holds for any lattice. *Proof verdict:* closes.
*Rests on it:* the calibration that types the survivors' nulls (T49). *Prior art:* none. *Kernel:* declined.

**T46 — P3b-T3: Λ₁₃₄₄ and Λ₂₃₅₂ are three-colourable: their Θ₄ witnesses keep every unit vector at distance ≥ 77/167 and ≥ 260/668 > 1/3 from the integers, so they lie in Θ₃. [cert; the P3b implementer; the owner re-certified at `k = 3`]**
*Proof:* `data/fs79/p3b/witnesses/{1344,2352}-theta3-cal.json`, CERTIFIED at `k = 3`. *Proof verdict:* closes. *Rests on it:* nothing
downstream. *Prior art:* FS73-T22 (the criterion). *Kernel:* declined.

**T47 — P3b-T4: Λ₂₄₄₈ is admissible at `N = 11` and `Λ₂₄₄₈/11Λ₂₄₄₈` is not four-colourable — a correction to phase 0's survivor table. [tools, replicated (kissat and cadical UNSAT), no proof checked; the P3b implementer]**
Phase 0's quotient budget ran out after `N = 10`, and its table called every other `N ≤ 12` inadmissible. A quotient refusal is not a
refusal of the lattice. *Proof:* `data/fs79/p3b/quotients.jsonl`; `steps.jsonl` quot-N11. *Proof verdict:* a solver verdict. *Rests on it:*
the corrected survivor row (phase-P0.md, noted there). *Prior art:* none. *Kernel:* declined.

**T48 — P3b-T5: no quotient colours any survivor: refusals at `N = 13` (Λ₂₄₄₈, Λ₂₄₀₀, Λ₄₂₀₀ and so its five superlattices, Λ₁₄₂₈₀, Λ₂₄₃₆₀) and at `N = 14` (Λ₂₃₂₈ replicated; Λ₂₄₄₈, Λ₂₄₀₀ by one solver); undecided at Λ₂₃₂₈'s `N = 13` and Λ₂₄₄₈'s `N = 15`. [tools, no proof checked; the P3b implementer]**
Λ₁₀₉₂₀ had no admissible `N ≤ 15` asked (its first admissible `N ≥ 13` is 16). The cap was checked only between asks (a 9-minute overrun).
*Proof:* the record's quotient table; `quotients.jsonl`. *Proof verdict:* solver verdicts. *Rests on it:* row 81; FS-59's next screens.
*Prior art:* none. *Kernel:* declined.

**T49 — P3b-T6 and the Θ₄ step: no Θ₄ point found on any of the seven survivors by HiGHS in 1,100 s — calibrated by T45, not a certificate — and the exact emptiness tree priced, not run: least quadruple determinants 34,650 (`L21cc6506`) and 4,928,028 (Λ₂₄₄₈), 476 root children on Λ₂₄₄₈. [tools, calibrated; tools exact for the determinants; the P3b implementer]**
The one-core pilot left Λ₂₄₄₈'s first subtree unfinished past 31,144 nodes; projected ≥ ~1.5·10⁷ nodes (a lower bound) and ~2·10⁹ by
determinant scaling — neither is a count. The implementer's first statement ("~10⁹, far beyond the cap") was corrected by itself to this
scope. The same engine could not prove `Θ₃(L21cc6506) = ∅` in 300 s, so its nulls are uninformative about emptiness. *Proof:* the
record's "What happened" and `steps.jsonl` (price-tree-k4). *Proof verdict:* a typed null plus exact determinants. *Rests on it:* row
81; FS-59 step 3. *Prior art:* FS73-T44 (the 34,650). *Kernel:* declined.

## §6. Conjectures and readings this milestone stated and did not prove (the close's sweep)

- **R1 — additive colourings into ℤ/4 exist exactly when `8 ∤ M`** (phase 0, T14): observed along the multiples of 420, a 2-adic pattern
  beside `1/2 ∈ ℤ[U]` (G35, G41). **Carried into FS-59's stub** as a cheap derivation, not a stub of its own.
- **R2 — in rank 1 at four colours, every phase rigid ⟹ no wall** (de Bruijn, §3a; unrefuted on 377 of 377 all-rigid sets, T36): with
  T35 it would prove rank-1 inheritance at four colours. **Carried into FS-76's stub** (its rank-1 laboratory).
- **R3 — arithmetic cannot enter an averaged certificate as a label** (Poros (competition)'s product-axis reading, its own derivation,
  unchecked; close-inventory items 88, 89(4)): the product of any invariant measure with Haar measure on the 𝔭-adic odometer is always a
  consistent joint, so residue labels add nothing to a window-frequency programme. Killing test: a residue-labelled window LP that
  refutes where the unlabelled one of the same window does not. **Carried into G73 as a reading and into the new stub FS-80**
  (`plans/STUB-window-frequency-certificate.md`).
- **R4 — at ℚ(√167) a four-colour certificate, if one exists, is averaged, non-local or structure-derived** (Coxeter C5, derived from
  T17–T29 for cell-local formats; de Bruijn's §5 reading on the challenge): **carried into G73**; the averaged route is FS-80.
- **R5 — de Bruijn's R1c (the flat tetrahedron):** `K₄`'s clique complex with unit triangles is the flat orbifold `ℝ²/p2`, and
  Moore–Newman's height is its developing map. **Carried into FS-74's stub** (hexagonal fabric), with R6.
- **R6 — de Bruijn's R3 (a quadratic slope relation):** on one hexagon system the triangle-orientation density equals the determinant of
  the height slope for every ergodic measure, so the admissible set is not convex. Not pursued. **Carried into FS-74's stub.**
- **R7 — the G68 question at `L21cc6506`** (the P3 implementer, close-inventory item 95): do finitely many periodic colourings' Kempe
  period groups already meet in 0 there, or does looseness need infinitely many? A generic interior circular colouring is the natural
  candidate. **Carried into G68's corrected sentence and FS-59's stub.**
- **The plan's own sweep** (`grep -n -i "conjecture\|not claimed"`, 7 hits): G48's conjecture (its own stubs); §D.4's "`M`-independence
  is a conjecture about certificates" (whether a Θ-type certificate's size is independent of the coefficients) — **carried into FS-80**;
  the FS-66 tower conjecture (FS-68). No new stub beyond FS-80.
