# FS-129 — the cross-application audit: the derivation file

*Filed 2026-10-03 by FS129-Z1, the record job's first part (`data/fs129/briefs/FS129-Z1-record.md`; its record `plans/FS129-Z1-record.md`).
This file is FS-129's theorem record: every statement the audit's readers derived, as an entry in the deriver's grammar, gated by
`python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS129-derivation.md`. It is assembled by `tools/fs129_z1_assemble.py` from
the readers' records: each block is the reader's, verbatim, with its `§` addresses pointed into the reader's record; the record job's changes
are named in the prose under the entry they touch. FS129-SR3's four entries are included (the brief's amendment of 2026-10-03).*

## What FS-129 is

Kooshi asked for "an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others,
interweaving and strengthening what we have, and potentially finding new paths" (`plans/STUB-cross-application-audit.md` § The request). The
plan (`plans/FS129-cross-application-audit.md`) runs it as one index (`data/fs129/index/`, FS129-IX1) and three passes, never pairwise, in two
lanes split by milestone number — **lane A**, the arithmetic era (through FS-103), and **lane R**, the regularity-wall era (FS-104 on):

| pass | question | lane A | lane R |
|---|---|---|---|
| 1, open steps ("finding new paths") | which held result closes, shortens or reduces each step of Poros's demand list (`data/fs129/demand-judged.md`) | `plans/FS129-OA1-audit.md` | `plans/FS129-OR1-audit.md` |
| 2, mechanisms ("interweaving") | where each grokking's mechanism bears and was not applied | `plans/FS129-MA1-audit.md`, `plans/FS129-MA2-audit.md` | `plans/FS129-MR1-audit.md` |
| 3, merges and strengthening | statements that are one; hypotheses that weaken; records that disagree; the vacuity sort; the Lean order | `plans/FS129-SA1-audit.md` | `plans/FS129-SR1-audit.md`, `plans/FS129-SR2-audit.md`, `plans/FS129-SR3-audit.md` |

Each reader's report is `data/fs129/reports/<job>.md`; the inventory is `plans/FS129-close-inventory.md`.

**Grades.** Every entry here is derived, one mind, as its reader filed it (plan § 7: a composition is "derived, one mind" until its Lean module
passes); none was raised. Pass 3's attacks on the two one-mind results that move the ranking's top (FS129-OR1-QFREE's chain, FS129-MR1-DOUBLETIP)
were checking readings and did not succeed (`plans/FS129-SR1-audit.md` §§ 2.1–2.2).

**Prior art.** Kept as each reader measured it. Most entries are "owed"; several say "owed to FS129-Z1" or "for FS129-Z1": the record job did not
run those searches (its brief keeps each line as measured), so each such debt is open and held for the coordinator.

**Supersession.** Pass 3's merged forms stand first; each form they replace is kept below, its statement verbatim, its `handoff:` reading
"none — superseded by …" with the reader's handoff quoted. The kernel formalizes each merged form once:

| merged form (formalize) | in place of |
|---|---|
| FS129-SA1-NOAFF-K, with FS129-SA1-NOAFF-FIELDS | FS129-OA1-NOLIN5, FS129-MA1-NOAFF5 (and MA2's k = 4 note; FS84-S1e (ii)) |
| FS129-SA1-FALC-FAN | FS129-MA1-FALC-T, FS129-MA2-FALC-GAP4 |
| FS129-SA1-FALC-DICHO-K | FS129-MA2-FALC-DICHO |
| FS129-SA1-FALC-RES | FS129-OA1-FALC-11, FS129-MA1-FALC-19, FS129-MA2-FALC-HOSTS clause (i) |
| FS129-SA1-FALC-RED's argument for the shared statement | FS129-OA1-FALC-RED's argument |
| FS129-SR1-BENDANY, with FS129-SR1-BENDLE3 | FS129-OR1-BENDFRAG, FS129-OR1-BEND3 |
| FS129-SR1-RINGBAND (if any of the family is formalized) | FS129-OA1-RINGWIND (and FS110-N2-RING, FS110-Y3-GP) |
| FS129-SR3-QFREE-NS, over FS129-SR3-EMPTY-NS (FS116-V6's route) | FS129-OR1-QFREE (and FS116-Y4-EMPTY; FS116-S1-QF read as its case) |

Pass 3's entries that replace earlier milestones' statements (FS129-SR1-TWOCIRC, -SIXQ; FS129-SR2-CLOSURE, -HULLSET, -SUPK, -DISC1TS, -YESLIM-EQ,
-QFCASE, -TOUCHW; FS129-SR3-OUTERADJ, -E2ONE; FS129-SA1-SQRT3-LOCAL) say so in their own handoffs; the full lists for the Lean backlog are SA1 § 6.3, SR1 § 6.2, SR2 § 4.3 and SR3 § 5.1.

**Record-job notes** (each under its entry): FS129-SR2-QFCASE read FS-116's "simple" at p only — raised by this job and resolved by
FS129-SR3 (its FS129-SR3-QFREE-NS drops "simple" from QFREE; `plans/FS129-SR3-audit.md` § Stage 2), so QFCASE stands, its fields citing QFREE-NS; FS129-MR1-DOUBLETIP carries
SR3's caution that it cannot replace FS116-V6-HUG without losing FS129-SR3-EMPTY-NS; FS129-SR1-BENDLE3 omits FS129-OR1-BEND3's tile
clause, which FS129-SR1-BENDANY carries; FS129-SR1-RINGBAND does not restate FS129-OA1-RINGWIND's periodicity clauses. No hypothesis a source needed
is dropped by a merged form. Corrections made inside entries: FS129-MR1-DOUBLETIP's `uses only:` (without FS116-N2-STAR) and FS129-OA1-RINGWIND's
prior art (inventory item 100); FS129-SR2-QFCASE's `uses only:`, `grade:` and `handoff:` (QFREE-NS; items 125, 130); FALC-RED's argument by
supersession (items 67, 106).


## 1. Lane A — the slack residue plane and the Falconer fan, merged (pass 3's forms first)

derivation: FS129-SA1-PLACE-HOM
  statement: let F ⊆ ℝ be a number field with a usable prime 𝔭 of residue field 𝔽_q, and let E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n
    algebraically independent over F (n ≥ 0); then there are a subring V ⊆ E holding both coordinates of every unit vector of E² and a
    ring homomorphism φ : V → 𝔽_q that restricts to reduction mod 𝔭 on the local ring 𝒪_{F,𝔭}; so the unit-distance graph on E² has a graph
    homomorphism into Γ_q, given on each coset x₀ + V² by x ↦ φ(x − x₀)
  uses only: for n = 0, V = 𝒪_{F,𝔭} and φ the reduction (a unit vector of F is 𝔭-integral, because −1 is not a square in 𝔽_q — the valuation
    lemma `mem_valuationSubring_of_sq_add_sq_eq_one`); for n ≥ 1, by induction, V_n = {x in the valuation ring of t_n ↦ 0 on
    F(t₁, …, t_{n−1})(t_n) : x(t_n = 0) ∈ V_{n−1}} and φ_n = φ_{n−1} ∘ (evaluation at t_n = 0) — a unit vector of E_n has coordinates in that
    valuation ring because its residue field F(t₁, …, t_{n−1}) ⊂ ℝ has no square root of −1 (G63, the same valuation lemma), and its value at
    t_n = 0 is a unit vector of E_{n−1}, in V_{n−1}² by induction; that a ring homomorphism takes a unit vector to a vector of quadrance 1,
    which is non-zero and adjacent to 0 in Γ_q; the coset step of `unitQuadrance_colorable_of_subring`
  not claimed: any finitely generated E ⊂ ℝ that is not purely transcendental over a number field (G63's Remark-1 caution; a place of such
    an E lands in an uncontrolled residue field); a homomorphism onto Γ_q (only into); that V is a valuation ring
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: F = ℚ(√3), 𝔭 a prime above 11 (11 splits: 3 ≡ 5² mod 11, and 11 ≡ 3 mod 4), n = 1, t₁ = π: E = ℚ(√3, π), V = {x ∈ ℚ(√3)[π]_{(π)} :
    x(0) ∈ 𝒪_{ℚ(√3),𝔭}}, φ(x) = x(0) mod 𝔭
  prior art: partly: `[Fischer1990]` Theorem 6's proof (a unit vector over F[x] without common factor, set x = 0 — G63) and row 52's residue
    map; the composite as one homomorphism into Γ_q not searched — owed to FS129-Z1
  handoff: de Bruijn — the homomorphism behind `unitQuadrance_colorable_of_valuationSubring` (`Transcendental.lean`, via
    `cosetResidue`), iterated n times and composed with the residue map at 𝔭; every field statement of this family is formalized through it

Rests on it: FS129-SA1-NOAFF-FIELDS and FS129-SA1-FALC-RES, and every field statement of the family, which the kernel proves through this one homomorphism (SA1 § 6.3 item 2). It is G63's place t ↦ 0 composed with row 52's residue map; it carries FALC-11, FALC-19 and NOAFF5's field readings to F(t₁, …, t_n) (inventory item 88).

derivation: FS129-SA1-NOAFF-K
  statement: let k ≥ 2, let ρ : G → T be a graph homomorphism, and let φ_v : Fin k → ℝ (v a vertex of G) be functions, all but
    finitely many identically zero, such that Σ_v φ_v(C(v)) takes one value b on every proper k-colouring C of G; then φ_u is constant
    for every vertex u of G such that some proper k-colouring of T leaves a colour absent from the closed neighbourhood of ρ(u); and if
    every vertex of T has such a colouring, every φ_v is constant and b is the sum of their values
  uses only: for u with a gap γ at ρ(u) in a proper k-colouring C of T, that π∘C∘ρ is a proper k-colouring of G for every permutation π of
    the colours, and so is its repaint at u alone with π(γ) (u's neighbours map into N_T(ρ(u)), which π∘C keeps off π(γ)) — row 66's
    `repaintAt`; that the two colourings differ only at u, so φ_u(π(C(ρ(u)))) = φ_u(π(γ)); that (π(C(ρ(u))), π(γ)) runs over every ordered
    pair of distinct colours; for b, that C∘ρ is one proper colouring of G
  not claimed: inequalities (three- and four-point positivity, FS-104 route (c)'s format (ii)); identities in which one term depends on the
    colours of two or more vertices jointly (degree two or more in the simplex embedding — row 66's separated pairs are such and need a
    shared gap); anything at a vertex whose image is gapped in no colouring of T; for the indicator embedding e_{C(v)}, that a_v = 0 (only
    that a_v is a multiple of the all-ones vector)
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, G the Moser spindle without its tip edge (three-colourable), ρ into the triangle of Γ₃ (the line 𝔽₃ × 0), a target slack at
    four: the indicator vectors of G's proper four-colourings span an affine space of dimension 21 of 21 (control FS129-SA1-NOAFF4); at
    k = 5 the same graph into Γ₁₁, 28 of 28 (FS129-MA1-NOAFF5-DIM); K₄ at four colours receives no gapped target, satisfies
    Σ_v f(C(v)) = 0, and has dimension 9 of 12 (the control's fault)
  prior art: partly: FS84-S1e (`plans/FS84-S1-derivation.md` § 4.2, 2026-09-25, an unindexed in-house entry found at stage 4: k = 4, scalar
    coefficients on the tetrahedral embedding, a lattice graph with one gapped four-colouring, by translation and the single-vertex repaint);
    `[BrewsterEtAl2020]` (a gapped vertex is a non-frozen vertex, row 66's prior-art line); the literature not searched — owed to FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-OA1-NOLIN5, FS129-MA1-NOAFF5 and MA2's k = 4 note: a lemma beside
    `Slack.forces_iff_of_hom` (`FanGap.lean`), for `f : G →g P`, `φ : V →₀ (Fin k → ℝ)` and a `FanGap C (f u) γ`, concluding `φ u` constant;
    the slack corollary by `Slack`; `Slack.forces_iff_of_hom`'s forward direction is its two-vertex case

control: FS129-SA1-NOAFF4
  of: FS129-SA1-NOAFF-K — the model at k = 4: a three-colourable graph, mapped into a target slack at four, has proper four-colourings of full affine dimension
  run: python3 ../tools/fs129_sa1_family.py noaff4 | tail -1
  expect: k=4: dim 21 of 21
  fault: python3 ../tools/fs129_sa1_family.py noaff4 --fault-k4 | tail -1

Rests on it: FS129-SA1-NOAFF-FIELDS. It is the merged form of four statements (SA1 § 6.3 item 1): FS129-OA1-NOLIN5 (its k = 5 case over a residue-𝔽₁₁ prime, read with the simplex embedding — φ_v = c_v·f(·) coordinatewise, and φ_v constant forces c_v = 0 because the simplex's vertices are distinct, then w = 0), FS129-MA1-NOAFF5 (its slack clause at k = 5, φ_v = ⟨a_v, f(·)⟩, and the edge vectors span ℝ⁴), MA2's k = 4 note (`plans/FS129-MA2-audit.md` § 2.3) and the in-house prior form FS84-S1e (ii) (k = 4, filed by this job in `plans/FS84-S1-derivation.md`). Row 66's `Slack.forces_iff_of_hom` (kernel) is its two-vertex case. What it bears on: FS-104 route (c) — G75's linear-annihilator format finds nothing on a field with a slack residue target (pass 1's cross-era hit, inventory item 39).

derivation: FS129-SA1-NOAFF-FIELDS
  statement: let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a
    finite unit-distance graph; suppose k = 5 and F has a usable prime of residue field 𝔽₁₁ or 𝔽₁₉ or χ(F²) ≤ 4, or k = 4 and F has a
    usable prime of residue field 𝔽₇ or χ(F²) ≤ 3; then for every family of functions φ_v : Fin k → ℝ (v a vertex of H) with Σ_v φ_v(C(v))
    taking one value on every proper k-colouring C of H, every φ_v is constant
  uses only: FS129-SA1-NOAFF-K (its slack clause); FS129-SA1-PLACE-HOM (H into Γ_q); slackness of Γ₁₁ and Γ₁₉ at five (kernel:
    `finitePlane11_slack`, `finitePlane19_slack`) and of Γ₇ at four (the kernel's `circ7Table` is proper with a gapped vertex, and Γ₇ is a
    Cayley graph, `slack_addCayley_of_fanGap`; control FS129-SA1-NOAFF4's first line, FS129-MA2-G7GAP); χ(E²) = χ(F²) (row 104, kernel at
    d = 2, iterated n times), so H maps into K_{k−1}, which is slack at k
  not claimed: fields with no usable prime of residue field 𝔽₇, 𝔽₁₁ or 𝔽₁₉ and χ(F²) ≥ k (K at k = 4 among them — its primes above 7 have
    residue field 𝔽₄₉, and K's plane carries four-colour forced pairs, hence identities); inequalities; k ≥ 6
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: derived from: FS129-SA1-NOAFF-K, FS129-SA1-PLACE-HOM
  minds: 1
  model: k = 4, F = ℚ(√11) (11 ≡ 2² mod 7, so 7 splits into primes of residue field 𝔽₇; χ(ℚ(√11)²) = 4, row 73): G75's four-colour
    annihilator format has nothing to find on any finite configuration over ℚ(√11)(t₁, …, t_n); k = 5, F = ℚ(√3) with H the spindle
    without its tip edge (FS129-MA1-NOAFF5-DIM)
  prior art: owed — in-house inputs (row 66, row 104, G63); for FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-OA1-NOLIN5's and FS129-MA1-NOAFF5's field readings: NOAFF-K composed with PLACE-HOM and the
    three kernel slack facts

Rests on it: nothing derived in FS-129. It is the field reading FS-104 route (c)'s null uses (J12, `plans/FS129-OA1-audit.md` § 2.2): over ℚ(√11)(t₁, …, t_n) at four colours, and over every field with a usable 𝔽₁₁ or 𝔽₁₉ prime at five, no linear identity in the colours holds on any finite configuration.

derivation: FS129-SA1-FALC-FAN
  statement: let k ≥ 3, let H be a finite graph with vertices a ≠ t, t not adjacent to a, forming a Falconer fan at k colours (every proper
    k-colouring of H − a in which N(a) avoids two distinct colours c₁, c₂ gives t one of c₁, c₂), and let ρ : H → T be a graph homomorphism;
    then (A) for every proper k-colouring C of T and every colour γ absent from N_T[ρ(a)], C(ρ(t)) ∈ {C(ρ(a)), γ}, and every colour absent
    from N_T[ρ(t)] lies in {C(ρ(a)), γ}; (B) every proper (k − 1)-colouring of T gives ρ(a) and ρ(t) one colour, and leaves none of its
    k − 1 colours absent from N_T[ρ(t)]
  uses only: (A) that C∘ρ restricted to H − a is a proper k-colouring in which N(a) avoids C(ρ(a)) and γ, because ρ(N(a)) ⊆ N_T(ρ(a)) — so
    the gap is used only on ρ(N_H[a]); the fan's definition with {c₁, c₂} = {C(ρ(a)), γ}; row 66's single-vertex repaint at t, legal since
    t ∉ N(a) and ρ(N(t)) ⊆ N_T(ρ(t)); (B) a proper (k − 1)-colouring read as a k-colouring whose k-th colour is absent everywhere, then (A)
    with γ that colour
  not claimed: that any Falconer fan at five colours exists (none is known; at four colours the unit rhombus is one); the converse — a pair
    that every (k − 1)-colouring of every target identifies need not be a fan (Harder's 8/3 pair over K, FS129-MA2-FALC-DICHO's not-claimed
    line); anything about k-colourings of T with no colour absent from N_T[ρ(a)]
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, H the unit rhombus a, b, c, t (a Falconer fan at four colours), T = H and each of the 637 labelled graphs on five vertices
    that receive it, every homomorphism and every colouring: no violation of (A) or (B) (control FS129-SA1-FAN4); at k = 5 no fan is known,
    so the clauses at five are constraints on a candidate
  prior art: owed — row 66's arity-1 statement (`not_fan_of_fanGap`) moved to the doubled apex; for FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-MA1-FALC-T and FS129-MA2-FALC-GAP4: one lemma beside `not_fan_of_fanGap` (`FanGap.lean`) for
    `Fan H′ k t [a₁, a₂]`, H′ the doubled-apex graph, parametric in k and T; the colouring of H′ is C∘ρ off the apex, C(ρ(a)) at a₁ and γ at
    a₂ (not a pullback along a homomorphism, since a₁, a₂ are adjacent)

control: FS129-SA1-FAN4
  of: FS129-SA1-FALC-FAN — clauses (A) and (B) on the model at four colours, over every target on at most five vertices; and FS129-SA1-FALC-DICHO-K there
  run: python3 ../tools/fs129_sa1_family.py fan4 | tail -1
  expect: k=4 violations=0
  fault: python3 ../tools/fs129_sa1_family.py fan4 --fault-cycle | tail -1

Rests on it: FS129-SA1-FALC-DICHO-K, FS129-SA1-FALC-RES, and FS129-MA2-FALC-HOSTS clauses (ii)–(iv) as re-pointed. It is the merged form of FS129-MA1-FALC-T (clause (1) is (A); (2) is (B)'s first clause at k = 5; (3) is (B)'s second clause read on a three-colouring, whose unused fourth colour is absent everywhere) and FS129-MA2-FALC-GAP4 ((B)'s second clause at k = 5). Stated at every k ≥ 3, it is inhabited at k = 4 by the unit rhombus (control FS129-SA1-FAN4).

derivation: FS129-SA1-FALC-DICHO-K
  statement: let k ≥ 3 and let H, a, t be a Falconer fan at k colours as in FS129-SA1-FALC-FAN; then χ(H) ≥ k − 1, and if χ(H) = k − 1,
    every proper (k − 1)-colouring of H gives a and t one colour
  uses only: FS129-SA1-FALC-FAN (B) with T = K_m and ρ a proper m-colouring of H for m = χ(H) ≤ k − 2 (K_m's proper (k − 1)-colouring leaves
    colour k − 1 absent everywhere, against (B)); and with T = H, ρ the identity
  not claimed: that any fan at five colours exists; the converse — a pair forced equal at k − 1 colours need not be a fan at k (Harder's
    745-point graph forces its pair at distance 8/3 at four colours over K and is no fan at five with that apex and tip, since 8/3 is a unit
    at K's primes of residue field 𝔽₁₁, FS129-SA1-FALC-RES); anything about a fan with χ(H) ≥ k beyond the bound
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: derived from: FS129-SA1-FALC-FAN
  minds: 1
  model: k = 4, the unit rhombus: χ = 3 and every proper three-colouring gives a and t one colour (row 58; control FS129-SA1-FAN4)
  prior art: owed — G9's measured reading ("compulsions one rung below the top") is the mechanism's informal form; for FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-MA2-FALC-DICHO: two lines over FS129-SA1-FALC-FAN's lemma, `Fan H′ k t [a₁, a₂]` with
    `H.Colorable (k − 1)` giving `Forces H (k − 1) a t`

Rests on it: FS129-SA1-FALC-RES clause (i) (χ(H) ≥ 4 at k = 5). Its k = 5 case is FS129-MA2-FALC-DICHO, superseded. G9's measured reading ("compulsions one rung below the top") and this are one mechanism (inventory item 88).

derivation: FS129-SA1-FALC-RES
  statement: let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a
    finite connected unit-distance graph with apex a and tip t forming a Falconer fan at five colours; then (i) χ(F²) ≥ 4, and F has no
    usable prime of residue field 𝔽₇; (ii) for every usable prime 𝔭 of F of residue field 𝔽₁₁ or 𝔽₁₉, with V and φ as in
    FS129-SA1-PLACE-HOM at 𝔭, t − a has coordinates in V and φ(t − a) = 0
  uses only: FS129-SA1-FALC-DICHO-K (χ(H) ≥ 4) and χ(E²) = χ(F²) (row 104, iterated) for χ(F²) ≥ 4; FS129-SA1-FALC-FAN (B) at T = Γ₇ through
    FS129-SA1-PLACE-HOM, with the kernel's gapped `circ7Table` colouring moved by a translation of Γ₇ to put its gap at ρ(t) (control
    FS129-MA2-G7GAP); FS129-SA1-FALC-FAN (A) at T = Γ₁₁ and Γ₁₉ through PLACE-HOM, translated so that ρ(a) = 0, with the two exact orbit facts —
    for every w ≠ 0 in 𝔽_q², some colouring in the orbit of the held tables under Γ_q's point group and translations, with a gap γ at 0, has
    C(w) ∉ {C(0), γ} or a gap at w outside {C(0), γ} (controls FS129-SA1-ORBIT11, FS129-SA1-ORBIT19, re-running pass 1's and pass 2's tools);
    that H connected puts t − a in V² (a sum of unit vectors)
  not claimed: that any fan at five colours exists; the case φ(t − a) = 0 excluded (no held colouring has a vertex with two gap colours; the
    Searcher's queue rows 1 and 4); fields whose only four-colourable residue targets are dyadic inert U_Q with Q ∈ {4, 8, 16} (queue row 5);
    fields with L(F) ≥ 5 beyond clause (ii); the almost-everywhere form
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: derived from: FS129-SA1-FALC-FAN, FS129-SA1-FALC-DICHO-K, FS129-SA1-PLACE-HOM
  minds: 1
  model: no fan at five colours is known; the field hypotheses are inhabited — ℚ(√11) has a usable prime of residue field 𝔽₇ (11 ≡ 2² mod 7), so
    by (i) no finite connected unit-distance graph over ℚ(√11)(t₁, …, t_n) is a fan at five; K has usable primes of residue field 𝔽₁₁, where
    (ii) confines a fan's tip to its apex's residue class
  prior art: owed — in-house inputs; for FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-OA1-FALC-11, FS129-MA1-FALC-19 and FS129-MA2-FALC-HOSTS clause (i): FALC-FAN's lemma through
    PLACE-HOM, with the two orbit facts as `decide` over 2 × 121 × 24 colourings of Γ₁₁ and 40 × 361 of Γ₁₉, beside `Instances/FanGap11.lean`
    and `Instances/FanGap19.lean`; HOSTS clauses (ii)–(iv) stay as filed, re-pointed to FALC-FAN (B) and DICHO-K

control: FS129-SA1-ORBIT11
  of: FS129-SA1-FALC-RES — clause (ii) at 𝔽₁₁: the exceptional set of residue differences is {0} (pass 1's tool, re-run)
  run: python3 ../tools/fs129_oa1_falconer_fan.py | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_oa1_falconer_fan.py --fault-gap | tail -1

control: FS129-SA1-ORBIT19
  of: FS129-SA1-FALC-RES — clause (ii) at 𝔽₁₉: the exceptional set of residue differences is {0} (pass 2's tool, re-run)
  run: python3 ../tools/fs129_ma1_falcfan.py 19 | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_ma1_falcfan.py 19 --fault-gap | tail -1

Rests on it: nothing derived in FS-129; it bears on FS-104 routes (0) and (b) (J13), as the list of fields that could host a five-colour Falconer fan and where its tip must sit. It supersedes FS129-OA1-FALC-11 and FS129-MA1-FALC-19 (clause (ii) at n = 0: V = 𝒪_{F,𝔭}, φ the reduction, so φ(t − a) = 0 is t ≡ a mod 𝔭; a prime of residue field 𝔽₁₁ or 𝔽₁₉ is usable) and FS129-MA2-FALC-HOSTS clause (i) (clause (i) here, sharpened: χ(F²) ≥ 4 already excludes a usable 𝔽₃ prime, by row 52, and a dyadic place ramified in F(i), by G35). The excluded case φ(t − a) = 0 is the Searcher's queue rows 1 and 4; the dyadic U_Q targets, row 5.

derivation: FS129-SA1-FALC-RED
  statement: if a finite unit-distance graph H ⊂ ℝ² has a Falconer fan at k colours with apex a and tip t, |t − a| = r > 1/2, and
    arcsin(1/(2r))/π irrational, then every cover of ℝ² by k measurable sets has two points at distance 1 inside one of the sets, so
    χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number
  uses only: `[Falconer1981]` as `plans/FS129-MA1-audit.md` § 2.1 transcribes it from the page images — Lemma 1 in the paper's form (for a
    non-empty null set E, a countable configuration C and a point x ∈ C, a rigid motion p, chosen by the lemma, with p(x) ∈ E and, for almost
    every rotation ρ about p(x), ρ(p(C)) ∩ E = {p(x)}); Lemma 2(i) applied to a class of positive measure and positive co-measure, for E ≠ ∅
    and E null; the null-set sentence (E is the union of the classes' metrical boundaries, for disjoint classes); FS103-M's D2 (a point of E
    lies in at least two metrical boundaries, `plans/FS103-M-derivation.md` line 252); Lemma 3; Lemma 4, with Lemma 2(ii); the cover made
    disjoint first
  not claimed: the almost-everywhere form (χ_m⁰, the target given MR) — it needs Lemma 3 with a positive-measure set of translations, which the
    1981 text does not supply; that any Falconer fan at five colours exists; anything for χ(ℝ²) without MR; Lemma 1 in the form "for every
    e ∈ E, almost every rotation about e" (false in general: a null E may hold a circle about e)
  argument: FS129-SA1-audit.md § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, H the unit rhombus with tip √3 — the angle condition is Falconer's own ((5 + i√11)^m ≠ 6^m), and the statement is his Theorem 2
    at n = 2, χ_m(ℝ²) ≥ 5
  prior art: partly: `[Falconer1981]` Theorem 2's proof, which uses the spindle's rhombus; the form with a general Falconer fan owed to FS129-Z1
  handoff: de Bruijn — formalize FS129-OA1-FALC-RED's statement from this entry's argument, behind the measurable chain (FS-113), importing
    `[Falconer1981]` Lemma 1 in the paper's form only (the motion is the lemma's), Lemmas 2–4 as `plans/FS129-MA1-audit.md` § 2.1 transcribes them

Rests on it: FS-104 route (b)'s reduction — one Falconer fan at five colours, with the angle condition, would give χ_m(ℝ²) ≥ 6 for the everywhere-proper measurable chromatic number; the family's lemmas above are the constraints such a fan must meet. It carries FS129-OA1-FALC-RED's statement verbatim with the argument reordered as `[Falconer1981]` p. 188 (MA1 checked Lemmas 1–4 against the page images, `plans/FS129-MA1-audit.md` § 2.1; inventory item 67): Lemma 1 chooses the rigid motion, and is never read as "for every e ∈ E, almost every rotation about e". The kernel formalizes OA1's statement from this argument, importing Lemma 1 in the paper's form only.

derivation: FS129-MA2-FALC-HOSTS
  statement: let H ⊂ F² be a finite connected unit-distance graph over a real number field F, with apex a and tip t forming a Falconer fan at five
    colours; then (i) F has no usable prime of residue field 𝔽₃ or 𝔽₇ and no place above 2 ramified in F(i); (ii) if H is drawn in a lattice Λ
    with its complete unit-vector set U and some finite quotient Cay(Λ/NΛ, U mod N) has a proper four-colouring with a colour absent from a closed
    neighbourhood, there is no such H; (iii) if H is drawn in de Grey's lattice, t − a ∈ 8Λ; (iv) if F is ℚ(√59), ℚ(√83) or ℚ(√131), then
    t − a ∈ R ∩ 𝔓⁴ (R = ℤ[U_F], 𝔓 the dyadic prime) and every four-colouring of F² is periodic
  uses only: FS129-MA2-FALC-GAP4 and FS129-MA2-FALC-DICHO; for (i), the residue map at a usable prime 𝔭 as a homomorphism of H, translated to put a
    vertex at 0, into Γ_q (FS129-MA1-FALC-19's step: −1 a non-square in 𝔽_q), the kernel's gapped proper four-colouring of Γ₇ (`circ7Table` along
    `projAlong (1, 2)`, `Instances/PlaneFreedom.lean`; control FS129-MA2-G7GAP) moved by a translation of Γ₇ to put its gap at the tip's image,
    χ(Γ₃) = 3, and a place above 2 ramified in F(i) giving χ(F²) ≤ 2 (G35); for (ii), the quotient map Λ → Λ/NΛ and the quotient's translations;
    for (iii), row 78 (`F = P = 8Λ` on de Grey's lattice); for (iv), row 88 (`F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`) and that H connected puts t − a
    in R
  not claimed: that any fan exists in the planes (iii) and (iv) leave open; anything over K beyond MA1's (FS129-OA1-FALC-11 at the primes of residue
    field 𝔽₁₁, and row 59's dyadic law, already confine t − a there); the fields whose only four-colourable residue targets are dyadic inert U_Q
    with Q ∈ {4, 8, 16} — whether those targets have a gapped four-colouring is not decided (a search request); fields with L(F) ≥ 5, where H may
    be five-chromatic and nothing here applies
  argument: FS129-MA2-audit.md § 2.3 The arguments
  verdict: derived
  grade: derived from: FS129-MA2-FALC-GAP4, FS129-MA2-FALC-DICHO
  minds: 1
  model: (i) at ℚ(√11) — 11 ≡ 2² (mod 7), so 7 splits and the prime above it has residue field 𝔽₇, and the plane is four-chromatic (row 73) — so
    no finite connected unit-distance graph over ℚ(√11) is a Falconer fan at five colours; (ii) FS81-T24's 49 gapped lattices over ℚ(√47);
    (iii), (iv): hypotheses inhabited by the lattice and the fields themselves, the conclusion conditional on a fan
  prior art: owed — in-house inputs; not searched
  handoff: de Bruijn — clauses (ii)–(iv) as filed, over FS129-SA1-FALC-FAN (B) and FS129-SA1-FALC-DICHO-K in place of
    FS129-MA2-FALC-GAP4 and -DICHO (SA1 § 6.3 item 5); clause (i) is superseded by FS129-SA1-FALC-RES (i) and is not formalized
    from this entry (FS129-Z1, 2026-10-03); the reader's handoff, verbatim: "de Bruijn — (i) over `finitePlane7` and `PlaneRotation`'s residue homomorphism; (iii) and (iv) wait on rows 78 and 88's Lean forms"

control: FS129-MA2-G7GAP
  of: FS129-MA2-FALC-HOSTS — clause (i)'s input: the kernel's four-colouring of Γ₇ is proper and gapped (14 of 49 vertices; every vertex by a translation)
  run: python3 ../tools/fs129_ma2_fangap.py gamma7 | tail -1
  expect: proper=True gapped=14/49
  fault: python3 ../tools/fs129_ma2_fangap.py gamma7 --fault | tail -1

**Superseded in part**: clause (i) by FS129-SA1-FALC-RES (i), which is sharper; clauses (ii)–(iv) stand, over FS129-SA1-FALC-FAN (B) and FS129-SA1-FALC-DICHO-K (their k = 5 cases are this entry's cited GAP4 and DICHO). Rests on it: inventory item 87's bearing line — clause (iv) ties FS-104 route (b) to row 88 (one fan over ℚ(√59), ℚ(√83) or ℚ(√131) would settle row 88's periodicity question); for FS129-Z2's stub line. *Fields this job changed:* `handoff:` splits clause (i), superseded, from clauses (ii)–(iv), re-pointed.


## 2. Lane A — the other entries

derivation: FS129-OA1-NOPERLAW
  statement: for a stationary random colouring c of ℝ², continuous in probability and proper almost surely on every unit pair, the set Z of
    vectors x with c(0) = c(x) almost surely is a discrete subgroup of ℝ²; if the law of c is rotation-invariant, Z = {0}
  uses only: continuity in probability (x ↦ P(c(0) ≠ c(x)) is continuous, so Z is closed); stationarity (Z is a subgroup: c(x) = c(x + y) a.s. is
    the shift of c(0) = c(y)); properness on unit pairs (Z misses the unit circle); that a closed subgroup of ℝ² that is not discrete contains a
    line through 0
  not claimed: anything about pairs forced with probability below 1, or about near-forcing at a scale; that rotation-averaging preserves every
    property a route needs (it preserves stationarity, continuity in probability and almost-sure properness, which is all this statement uses)
  argument: FS129-OA1-audit.md § 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring under a uniformly random translation of its period torus: Z is its period lattice, discrete and
    non-zero, and the law is not rotation-invariant
  prior art: owed — the arithmetic analogue is G55's (row 111: a forced group invariant under the rotations is an ideal, so 0 or everything);
    this is its real-place form, not searched
  handoff: none — a relay-result recorded for FS-104's route (b); it enters no proof in this record

Rests on it: nothing (its handoff is none); a relay-result for FS-104 route (b). Its arithmetic analogue is G55's forced ideal (row 111).

derivation: FS129-SA1-SQRT3-LOCAL
  statement: for a number field F and a place w of F above 2 at which 3 is a square in the completion F_w, w is unramified in F(i)/F, and w
    splits in F(i) if and only if its residue degree f(w|2) is even; when it does not split it is inert, of norm 2^f with f = f(w|2) odd
  uses only: √−3 generates ℚ₄ = ℚ₂(ζ₃), the unramified quadratic extension of ℚ₂; F_w(i) = F_w(√−3) when 3 is a square in F_w (i = √−3/√3);
    a compositum with an unramified extension is unramified over the smaller field; ℚ₄ ⊆ F_w when 2 divides f(w|2), and not otherwise
  not claimed: anything at a dyadic place where 3 is not a square — ℚ(ζ₇)⁺'s one place above 2 is ramified in F(i) (TC1-FIELDS); at ℚ(√7)'s,
    i ∈ F_w and w splits with f = 1; anything about the places of F not above 2
  converse: FS129-SA1-audit.md § 6.2 The argument for FS129-SA1-SQRT3-LOCAL
  argument: FS129-SA1-audit.md § 6.2 The argument for FS129-SA1-SQRT3-LOCAL
  verdict: derived
  grade: hand
  minds: 1
  model: F = ℚ(√51), which does not contain √3: 51 = 3 · 17 with 17 a square in ℚ₂, so F_w = ℚ₂(√3); f = 1, and w is inert in F(i) (2 has
    e = 2, f = 2, g = 1 in ℚ(√51, i)); over the control's 223 dyadic places, 43 have 3 a square, 33 of them in fields without √3 — no violation
    (control FS129-SA1-SQRT3)
  prior art: partly: TC1-SQRT3-DYADIC (the case √3 ∈ F, by the same argument); the local facts are standard (recalled, not read)
  handoff: de Bruijn — formalize in place of TC1-SQRT3-DYADIC, as a conditional seed like it: one local lemma; it crosses with G56's dyadic
    exclusion if that is formalized

control: FS129-SA1-SQRT3
  of: FS129-SA1-SQRT3-LOCAL — both directions, at every dyadic place of 194 fields (the 182 real quadratic fields of squarefree d ≤ 300, K, K(√5), K(√7), ℚ(√3, √5), ℚ(√2, √3), ℚ(√51, √5) and six cubic or sextic fields), by PARI's relative prime decomposition
  run: gp -q ../tools/fs129_sa1_sqrt3_local.gp < /dev/null | tail -1
  expect: violations=0
  fault: FAULT=1 gp -q ../tools/fs129_sa1_sqrt3_local.gp < /dev/null | tail -1

control: FS129-SA1-SQRT3-CONV
  of: FS129-SA1-SQRT3-LOCAL — the converse direction alone: at a place with 3 a square, no split place has f(w|2) odd and no inert place has f(w|2) even
  run: CONV=1 gp -q ../tools/fs129_sa1_sqrt3_local.gp < /dev/null | tail -1
  expect: violations=0
  fault: CONV=1 FAULT=1 gp -q ../tools/fs129_sa1_sqrt3_local.gp < /dev/null | tail -1

Rests on it: nothing in FS-129. It supersedes TC1-SQRT3-DYADIC (the case √3 ∈ F), a conditional seed of the Lean order (inventory item 13); it crosses only with G56's dyadic exclusion, if that is formalized.


## 3. Lane A — superseded forms (kept, marked)

derivation: FS129-OA1-NOLIN5
  statement: let F ⊆ ℝ be a number field with a prime 𝔭 of residue field 𝔽₁₁, let H ⊂ F² be a finite connected unit-distance graph, and for a
    proper five-colouring C of H let f_C(v) be the vertex of a fixed regular 4-simplex labelled C(v); if real numbers c_v and a vector w satisfy
    Σ_v c_v f_C(v) = w for every proper five-colouring C of H, then every c_v is 0 and w = 0
  uses only: row 66's Slack (Γ₁₁, 5) (every vertex of Γ₁₁ is gapped in some proper five-colouring; kernel, `finitePlane11_slack`); the residue
    map ρ : H → Γ₁₁ (unit vectors of F are 𝔭-integral because −1 is a non-square in 𝔽₁₁; H translated to put a vertex at 0); the single-vertex
    repaint of row 66 (`repaintAt`); the injectivity of the simplex labelling
  not claimed: anything about inequalities (three- and four-point positivity, BOV's format (ii)); polynomial identities of degree ≥ 2 beyond
    row 66's separated pairs; fields with no prime of residue field 𝔽₁₁ (K(√7) among them, where 7 is a non-square mod 11 and √7 has no image);
    any statement at the real place or about χ(ℝ²)
  argument: FS129-OA1-audit.md § 2.2 J12 — FS-104 route (c), correlation constraints on stationary colourings
  verdict: derived
  grade: hand
  minds: 1
  model: H the two unit rhombi a, b, c, t and a, b′, c′, t′ of the Moser spindle without its tip edge, over ℚ(√3) (11 splits there into two
    primes of residue field 𝔽₁₁); at three colours the analogous statement fails — every proper three-colouring forces the tips, f(t) − f(t′) = 0
    — and nothing contradicts that, because Γ₁₁ is not three-colourable, so ρ supplies no three-colouring to repaint
  prior art: owed — the forced-pair case is row 66's `Slack.forces_iff` (kernel); the linear-identity form not searched
  handoff: none — superseded by FS129-SA1-NOAFF-K with FS129-SA1-NOAFF-FIELDS (FS129-Z1, 2026-10-03; SA1 § 6.3 item 1), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — a short corollary of `Slack.forces_iff_of_hom`'s proof: for each vertex u, the pulled-back colouring and its repaint at u differ only at u, so c_u (f(γ) − f(C(ρu))) = 0"

control: FS129-OA1-SLACK-ORBIT
  of: FS129-OA1-NOLIN5 — every vertex of Γ₁₁ is gapped in some colouring of the held orbit (the translations do it)
  run: python3 ../tools/fs129_oa1_falconer_fan.py | head -1
  expect: vertices of Gamma_11 gapped in some colouring of the orbit: 121 of 121
  fault: python3 ../tools/fs129_oa1_falconer_fan.py --fault-notrans | head -1

**Superseded** by FS129-SA1-NOAFF-K with FS129-SA1-NOAFF-FIELDS: its statement is NOAFF-FIELDS at k = 5 over a residue-𝔽₁₁ prime, read with the simplex embedding (FS129-SA1-NOAFF-K's prose gives the one-line passage). Kept as derived; nothing rests on it that does not rest on the merged form. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-MA1-NOAFF5
  statement: let H be a finite graph with a graph homomorphism ρ into a graph T in which every vertex has a colour absent from its closed
    neighbourhood in some proper five-colouring of T; for a proper five-colouring C of H let f_C(v) be the vertex of a fixed regular 4-simplex in ℝ⁴
    labelled C(v); if vectors a_v ∈ ℝ⁴ and a real b satisfy Σ_v ⟨a_v, f_C(v)⟩ = b for every proper five-colouring C of H, then every a_v is 0 and b = 0
  uses only: the slackness of T at five; that C∘ρ is a proper five-colouring of H when C is one of T; row 66's single-vertex repaint (a colour absent
    from N_T[ρ(u)] may be given to u alone); that a permutation of the five colours carries proper colourings to proper colourings; that the edge
    vectors f(i) − f(j) of a regular 4-simplex span ℝ⁴
  not claimed: inequalities (three- and four-point positivity, FS-104 route (c)'s format (ii)); identities of degree two or more in f; anything over a
    field with no slack residue target — over a number field F a finite connected unit-distance graph maps into Γ_q at a usable prime of residue
    field 𝔽_q (FS129-OA1-NOLIN5's residue map), so the statement covers F with such a prime at q = 11 or q = 19 (kernel `finitePlane11_slack`,
    `finitePlane19_slack`) or with a residue target of chromatic number at most four, and says nothing over a 6-open field
  argument: FS129-MA1-audit.md § 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint
  verdict: derived
  grade: hand
  minds: 1
  model: H = the two unit rhombi a, b, c, t and a, b′, c′, t′ of the Moser spindle without its tip edge, over ℚ(√3), with ρ into Γ₁₁ (11 splits in
    ℚ(√3)); its 6,480 proper five-colourings span an affine space of the full dimension 7 · 4 = 28, and at three colours, where the tips are forced
    and no slack target receives H, the dimension is 6 of 14 (control FS129-MA1-NOAFF5-DIM)
  prior art: owed — partly FS129-OA1-NOLIN5 (scalar coefficients, residue-𝔽₁₁ primes) and row 66's `Slack.forces_iff` (the forced-pair case); the
    affine-hull form not searched
  handoff: none — superseded by FS129-SA1-NOAFF-K (FS129-Z1, 2026-10-03; SA1 § 6.3 item 1), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — beside `Slack.forces_iff_of_hom`: for each vertex u and each colour permutation π, the pulled-back colouring π∘C∘ρ and its repaint at u give ⟨a_u, f(π γ) − f(π C(ρ u))⟩ = 0"

control: FS129-MA1-NOAFF5-DIM
  of: FS129-MA1-NOAFF5 — the model: the five-colourings of the two-rhombus graph have full affine dimension
  run: python3 ../tools/fs129_ma1_noaff.py | tail -1
  expect: k=5: dim 28 of 28
  fault: python3 ../tools/fs129_ma1_noaff.py --fault | tail -1

**Superseded** by FS129-SA1-NOAFF-K (its slack clause at k = 5 with φ_v = ⟨a_v, f(·)⟩). Its not-claimed line's field reading is FS129-SA1-NOAFF-FIELDS. Its control FS129-MA1-NOAFF5-DIM remains NOAFF-K's model at k = 5. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-MA1-FALC-T
  statement: let H be a finite graph with an apex a and a tip t, t not adjacent to a, forming a Falconer fan at five colours (every proper five-colouring
    of H − a in which N(a) avoids two colours c₁, c₂ gives t one of c₁, c₂), and let ρ : H → T be a graph homomorphism; then (1) for every proper
    five-colouring C of T and every colour γ absent from N_T[ρ(a)], C(ρ(t)) ∈ {C(ρ(a)), γ} and every colour absent from N_T[ρ(t)] lies in {C(ρ(a)), γ};
    (2) if T has a proper four-colouring, every proper four-colouring of T gives ρ(a) and ρ(t) one colour; (3) T has no proper three-colouring
  uses only: that C∘ρ restricted to H − a is a proper five-colouring of H − a in which N(a) avoids C(ρ(a)) (properness of C at ρ(a)) and γ (absent
    from N_T[ρ(a)]); row 66's single-vertex repaint at t (t is not adjacent to a, and its neighbours map into N_T(ρ(t))); for (2) and (3), a colouring
    with fewer than five colours read as a five-colouring with its unused colours absent everywhere
  not claimed: that any Falconer fan at five colours exists; the converse (a pair that every target identifies need not be a fan); anything about
    k ≠ 5 beyond the same argument's reach (at k colours, (3) reads "no proper (k − 2)-colouring")
  argument: FS129-MA1-audit.md § 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint
  verdict: derived
  grade: hand
  minds: 1
  model: H = the unit rhombus a, b, c, t is a Falconer fan at four colours (b, c take the two colours other than c₁, c₂, so t takes one of them); at
    four colours clause (2)'s analogue reads "a proper two-colouring of T identifies ρ(a), ρ(t)" — and the rhombus has no homomorphism into any
    two-colourable T (it holds triangles), consistent; at five colours H itself is no fan, as FS129-OA1-FALC-11's model shows directly
  prior art: owed — it is FS129-OA1-FALC-11's argument with Γ₁₁ replaced by an arbitrary target; row 66's arity-1 statement (`not_fan_of_fanGap`) moved
    to the doubled apex; not searched
  handoff: none — superseded by FS129-SA1-FALC-FAN (FS129-Z1, 2026-10-03; SA1 § 6.3 item 3), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — a lemma beside `not_fan_of_fanGap`, for `Fan H′ 5 t [a₁, a₂]` with H′ the doubled-apex graph"

**Superseded** by FS129-SA1-FALC-FAN, which states it at every k ≥ 3 (its clauses (1)–(3) are FAN's (A) and (B) at k = 5). *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-MA2-FALC-GAP4
  statement: let H, a, t be a Falconer fan at five colours as in FS129-MA2-FALC-DICHO and ρ : H → T a graph homomorphism; then no proper
    four-colouring of T leaves a colour absent from the closed neighbourhood N_T[ρ(t)]
  uses only: that a proper four-colouring C of T, read as a five-colouring, leaves the fifth colour absent everywhere; that C∘ρ restricted to
    H − a is a proper five-colouring in which N(a) avoids C(ρ(a)) and the fifth colour; row 66's single-vertex repaint at t (t is not adjacent to
    a, and its neighbours map into N_T(ρ(t)))
  not claimed: the five-colour analogue (a five-colouring of T gapped at both ρ(a) and ρ(t) only confines the tip's colour to {C(ρ(a)), the gap},
    FS129-MA1-FALC-T clause (1)); anything about targets whose four-colourings are all gap-free at ρ(t) (K's dyadic targets, U₃₂, the type-(B)
    planes), where FS129-MA2-FALC-HOSTS's confinement clauses take over
  argument: FS129-MA2-audit.md § 2.3 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: no fan at five colours is known; the argument one colour down (a fan at four colours, a three-colouring gapped at ρ(t)) holds on every
    graph with at most six vertices receiving the unit rhombus — 26,979 labelled graphs, no violation; reading the gap on the open neighbourhood
    instead, 36,030 violations at five vertices (control FS129-MA2-GAPK)
  prior art: owed — FS129-MA1-FALC-T clause (3) is the case of a three-colourable T; not searched
  handoff: none — superseded by FS129-SA1-FALC-FAN (FS129-Z1, 2026-10-03; SA1 § 6.3 item 3), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — a lemma beside `not_fan_of_fanGap` (`FanGap.lean`), for `Fan H′ 5 t [a₁, a₂]` with H′ the doubled-apex graph and a `T.Coloring (Fin 4)` with `FanGap C (ρ t) γ`"

control: FS129-MA2-GAPK
  of: FS129-MA2-FALC-GAP4 — the argument one colour down: on every labelled graph with five vertices receiving the unit rhombus, no proper three-colouring is gapped at the tip's image, and the rhombus satisfies DICHO's analogue
  run: python3 ../tools/fs129_ma2_fangap.py gapk 4 5 | tail -1
  expect: K=4 N=5 violations=0
  fault: python3 ../tools/fs129_ma2_fangap.py gapk 4 5 --fault | tail -1

**Superseded** by FS129-SA1-FALC-FAN ((B)'s second clause at k = 5). *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-MA2-FALC-DICHO
  statement: let H be a finite graph with an apex a and a tip t, t ≠ a and t not adjacent to a, forming a Falconer fan at five colours (every
    proper five-colouring of H − a in which N(a) avoids two colours c₁, c₂ gives t one of c₁, c₂); then χ(H) ≥ 4, and if χ(H) = 4 then every
    proper four-colouring of H gives a and t one colour
  uses only: FS129-MA1-FALC-T clauses (2) and (3), with T = H and ρ the identity map
  not claimed: that any Falconer fan at five colours exists; the converse — a pair forced equal at four colours need not be a fan at five
    (Harder's 745-point graph forces its pair at distance 8/3 at four colours over K, and is no fan at five with that apex and tip, since 8/3 is a
    unit at K's primes of residue field 𝔽₁₁, FS129-OA1-FALC-11); anything about a fan with χ(H) ≥ 5 beyond that bound
  argument: FS129-MA2-audit.md § 2.3 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: no fan at five colours is known; the argument one colour down, on the unit rhombus a, b, c, t (a Falconer fan at four colours, MA1's
    model): χ = 3 and every proper three-colouring gives a and t one colour (row 58: the rhombus forces) — control FS129-MA2-GAPK
  prior art: owed — in-house inputs (FS129-MA1-FALC-T); not searched
  handoff: none — superseded by FS129-SA1-FALC-DICHO-K (FS129-Z1, 2026-10-03; SA1 § 6.3 item 4), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — two lines over FS129-MA1-FALC-T's lemma: `Fan H 5 t [a₁, a₂]` with `H.Colorable 4` gives `Forces H 4 a t`"

**Superseded** by FS129-SA1-FALC-DICHO-K (its case k = 5). *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-OA1-FALC-11
  statement: let F ⊆ ℝ be a number field with a prime 𝔭 of residue field 𝔽₁₁; in every finite connected unit-distance graph H ⊂ F², every
    Falconer fan at five colours with apex a and tip t has t ≡ a (mod 𝔭)
  uses only: the residue map ρ : H → Γ₁₁ (as in FS129-OA1-NOLIN5); row 66's single-vertex repaint; the two kernel five-colourings of Γ₁₁
    (`finitePlane11Table`, `finitePlane11DoubleGapTable`, proper — decided in the kernel), their orbit under Γ₁₁'s 24-element point group and
    121 translations, and the exact finite fact read off that orbit: for every w ≠ 0 in 𝔽₁₁² some orbit colouring C with a gap γ at 0 has
    C(w) ∉ {C(0), γ} or a gap at w outside {C(0), γ} (control FS129-OA1-FALC-11-W)
  not claimed: the case t ≡ a (mod 𝔭) — no held colouring has a vertex with two gap colours, so the orbit cannot reach it (a search request);
    fields with no prime of residue field 𝔽₁₁; that any Falconer fan at five colours exists elsewhere; the almost-everywhere form
  argument: FS129-OA1-audit.md § 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement
  verdict: derived
  grade: hand
  minds: 1
  model: H = the unit rhombus a, b, c, t over ℚ(√3) (11 splits there into two primes of residue field 𝔽₁₁), apex a, tip t at distance √3:
    |t − a|² = 3 is a unit at 11, so ρ(t) ≠ ρ(a), and the statement says H is no Falconer fan at five colours — true directly: with N(a) = {b, c}
    avoiding c₁, c₂, the points b, c take two of the other three colours and t takes the third
  prior art: owed — it is row 66's arity-1 statement (`not_fan_of_fanGap`, `Forces ↔ =`) moved to the doubled apex; not searched
  handoff: none — superseded by FS129-SA1-FALC-RES (FS129-Z1, 2026-10-03; SA1 § 6.3 item 5), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — the orbit fact is a `decide` over 2 × 121 × 24 colourings of a 121-vertex graph, beside `Instances/FanGap11.lean`"

control: FS129-OA1-FALC-11-W
  of: FS129-OA1-FALC-11 — the finite fact: the exceptional set of residue differences is {0}
  run: python3 ../tools/fs129_oa1_falconer_fan.py | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_oa1_falconer_fan.py --fault-gap | tail -1

**Superseded** by FS129-SA1-FALC-RES clause (ii) at the residue field 𝔽₁₁ and n = 0. Its orbit fact (control FS129-OA1-FALC-11-W) is RES's control FS129-SA1-ORBIT11. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-MA1-FALC-19
  statement: let F ⊆ ℝ be a number field with a prime 𝔭 of residue field 𝔽₁₉; in every finite connected unit-distance graph H ⊂ F², every Falconer
    fan at five colours with apex a and tip t has t ≡ a (mod 𝔭)
  uses only: FS129-MA1-FALC-T clause (1) with T = Γ₁₉ and ρ the residue map (unit vectors of F are 𝔭-integral because −1 is a non-square in 𝔽₁₉; H
    translated to put a vertex at 0); the kernel's proper five-colouring `finitePlane19QuotColouring` (`Instances/FanGap19.lean`); its orbit under
    Γ₁₉'s 40-element point group and 361 translations, and the exact finite fact read off that orbit: for every w ≠ 0 in 𝔽₁₉² some orbit colouring C
    with a gap γ at 0 has C(w) ∉ {C(0), γ} or a gap at w outside {C(0), γ} (control FS129-MA1-FALC-19-W)
  not claimed: the case t ≡ a (mod 𝔭) — the held colouring's gaps are single (the classes y − x ∈ {4, 10}, gap colour 1), so the orbit cannot reach it;
    fields holding √3 — 3 is a non-residue mod 19, so no field with a unit triangle has such a prime (`FanGap19.lean`'s docstring); that any Falconer
    fan at five colours exists; the almost-everywhere form
  argument: FS129-MA1-audit.md § 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint
  verdict: derived
  grade: hand
  minds: 1
  model: F = ℚ(√5, √11)-type fields with 19 of residue degree one (19 splits in ℚ(√5): 5 ≡ 9² mod 19); a unit rhombus does not live there (no √3), and
    the statement's content is the orbit fact, which the control exhibits
  prior art: owed — FS129-OA1-FALC-11 at 11; not searched
  handoff: none — superseded by FS129-SA1-FALC-RES (FS129-Z1, 2026-10-03; SA1 § 6.3 item 5), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — the orbit fact is a `decide` over 40 × 361 colourings of a 361-vertex graph beside `Instances/FanGap19.lean`"

control: FS129-MA1-FALC-11-REPLAY
  of: FS129-MA1-FALC-19 — the same code path on 11's two held tables reproduces FS129-OA1-FALC-11-W's set, so the 19 run reads what the 11 run read
  run: python3 ../tools/fs129_ma1_falcfan.py 11 | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_ma1_falcfan.py 11 --fault-gap | tail -1

control: FS129-MA1-FALC-19-W
  of: FS129-MA1-FALC-19 — the finite fact: the exceptional set of residue differences at 19 is {0}
  run: python3 ../tools/fs129_ma1_falcfan.py 19 | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_ma1_falcfan.py 19 --fault-gap | tail -1

**Superseded** by FS129-SA1-FALC-RES clause (ii) at the residue field 𝔽₁₉ and n = 0. Its orbit fact is RES's control FS129-SA1-ORBIT19. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-OA1-FALC-RED
  statement: if a finite unit-distance graph H ⊂ ℝ² has a Falconer fan at k colours with apex a and tip t, |t − a| = r > 1/2, and
    arcsin(1/(2r))/π irrational, then every cover of ℝ² by k measurable sets has two points at distance 1 inside one of the sets, so
    χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number
  uses only: `[Falconer1981]` Lemma 1 (a.e. rotation of a countable configuration about a point of a null set E meets E only there), Lemma 2 (E
    non-empty and null; at a point of E at least two classes are present — FS103-M's D2), Lemma 3 (a small translation puts the apex in either
    present class and keeps every other point in its class), Lemma 4 (a circle of radius r > 1/2 with irrational unit-chord angle, almost all of
    it in S̃₁ ∪ S̃₂, contains a unit pair in S₁ or S₂) — as quoted verbatim in `plans/FS103-M-derivation.md` § 1.2, not re-read from the paper
  not claimed: the almost-everywhere form (χ_m⁰, the target given MR) — it needs Lemma 3 with a positive-measure set of translations, which the
    1981 text does not supply (FS103-M § 1.2's table) and the 2005 exposition is reported to; that any Falconer fan at five colours exists;
    anything for χ(ℝ²) without MR
  argument: FS129-OA1-audit.md § 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, H the unit rhombus with tip √3 — the angle condition is Falconer's own ((5 + i√11)^m ≠ 6^m), and the statement is his
    Theorem 2 at n = 2, χ_m(ℝ²) ≥ 5
  prior art: partly: `[Falconer1981]` Theorem 2's proof, which uses the spindle's rhombus; the form with a general Falconer fan not searched (owed)
  handoff: none — superseded by FS129-SA1-FALC-RED (FS129-Z1, 2026-10-03; the same statement, argued in Falconer's p. 188 order: SA1 § 6.3 item 6, inventory items 67, 106), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — behind the measurable chain (FS-113), with Lemmas 1–4 imported from `[Falconer1981]` as a documented assumption"

**Superseded** by FS129-SA1-FALC-RED: the same statement, verbatim, with the argument in Falconer's p. 188 order. This entry's `uses only:` states Lemma 1 as "a.e. rotation of a countable configuration about a point of a null set E meets E only there", which is not the paper's form (`plans/FS129-MA1-audit.md` § 2.2: the lemma chooses the motion, so the point of E the apex lands on cannot be fixed first); the statement stands and no grade moves (inventory item 67). Formalize from FS129-SA1-FALC-RED's argument only. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.


## 4. Lane R — the bends on a fragment and the (Q)-free ring

derivation: FS129-OR1-WHOLE
  statement: let F be a valid k-coloured fragment on a closed disc B̄(p, r) about a point p, r > 1, a map of an open set V, and let 1 < ρ ≤ r;
    let 𝒯_ρ be the tiles of F that meet the open disc B(p, ρ), and F_ρ the map of the open set U_ρ = V ∩ int ⋃_{T ∈ 𝒯_ρ} cl T whose tiles are
    the tiles of 𝒯_ρ with their colours; then F_ρ is a valid k-coloured fragment on B̄(p, ρ′) for every ρ′ < ρ, each of its tiles is a tile of F
    with the same closure, the tiles of F_ρ having p in their closure are those of F, and F_ρ is non-Siamese if F is and simple if F is; and if
    moreover ρ ≤ √3, then for every arc α of Γ on ω(p) of positive length whose inner side is one tile, of colour c, no tile of F_ρ of colour c
    has a point of R₂(ᾱ) = {p + 2u : p + u ∈ ᾱ} in its closure
  uses only: FS116-V4-DICHOTOMY (closure points at distance below 1 make two same-colour tiles near, above 1 far; non-Siamese means distinct
    same-colour tiles are far); FS116-V5-NE1 (a tile lies in B(z, 1) for every z in its closure); the parallelogram identity; local finiteness
    of Γ; the definitions of tile (a component of the open set minus Γ), Siamese and simple (`data/fs116/claims.md` § 0)
  not claimed: that the round restriction — the components of B(p, ρ) ∖ Γ — keeps non-Siamese or simple (it need not: § Control:
    fs129-or1-cut); anything about witness tiles when ρ > √3; simplicity read with closures taken relative to U_ρ (the statement reads them in
    the plane, as `data/fs116/claims.md` § 0 does)
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-WHOLE
  verdict: derived
  grade: derived from: FS116-V4-DICHOTOMY, FS116-V5-NE1
  minds: 1
  model: the capped strip of FS114-Y-DIAL about a midline four-colour vertex P_j, a valid six-coloured fragment on B̄(P_j, 1.8) (it holds every
    radius below φ²/√2 ≈ 1.851), with ρ = √3; its ring ω(P_j) carries four (Q) arcs of positive length (`data/fs116/claims.md` § 0, the capped
    strip's midline configuration)
  prior art: owed — an in-house composition of in-house lemmas; their own prior art is unsearched (`plans/STUB-qfree-ring.md` § Prior-art debts)
  handoff: de Bruijn — the statement and its not claimed, with V4-DICHOTOMY and V5-NE1 as its inputs; the identity is one line of algebra

control: fs129-or1-cut
  of: FS129-OR1-WHOLE — its not claimed line: a U-shaped tile of diameter below 1 that the round restriction to B(0, 11/10) cuts into two pieces
  run: python3 ../tools/fs129_or1_lens.py
  expect: lens ok; cut ok
  fault: python3 ../tools/fs129_or1_lens.py --fault-cut

control: fs129-or1-lens
  of: FS129-OR1-WHOLE — the lens identity, its corner value (ρ² − 1)/2 (sharp at ρ = √3) and a rational sample of the lens at ρ = 17/10
  run: python3 ../tools/fs129_or1_lens.py
  expect: lens ok; cut ok
  fault: python3 ../tools/fs129_or1_lens.py --fault

Rests on it: FS129-SR1-BENDANY, and through it FS129-SR1-BENDLE3, FS129-OR1-QFREE-CLASS, FS129-OR1-QFREE and FS129-SR2-QFCASE; also the superseded FS129-OR1-BENDFRAG and -BEND3. It settles the records that disagreed on what FS-112's bends leave on a ring (`plans/FS116-close-inventory.md` items 136, 145; `plans/FS129-SR1-audit.md` § 2.3): side 1 holds for this whole-tile restriction of radius at most √3, not for the round one it names (control fs129-or1-cut). Its identity |x − e|² = (|x|² + |x − 2e|²)/2 − 1 (|e| = 1) was checked by sympy at the coordinator's receipt (inventory item 54).

derivation: FS129-SR1-BENDANY
  statement: let F be a valid k-coloured fragment, for any k ≥ 1, on a closed disc B̄(p, r), r > 1, about a point p, and let 1 < ρ′ < min(r, √3);
    then there is a valid k-coloured fragment F″ on B̄(p, ρ′), with the same colours carried at p as in F, whose arcs of Γ on ω(p) are exactly the
    arcs of Γ on ω(p) in F both of whose side colours are carried at p, so that Γ ∩ ω(p) in F″ is those arcs and finitely many points; its tiles are
    the tiles of F meeting B(p, min(r, √3)), each unchanged except the two side tiles of each other ring arc, which differ from F's only inside lenses,
    as thin as wished, along that arc; and F″ is non-Siamese if F is, and simple if F is
  uses only: FS129-OR1-WHOLE at ρ = min(r, √3) (stated for any k); FS112-N2-BENDS (N2-TOWARD, N2-AWAY) read on a fragment by N2's route (§ 2.1 of
    this record), in which no colour count is spent (`plans/FS112-NB2-verification.md` § 1.5: six "nowhere in N2-RAY, TOWARD, AWAY, TAN, RED, SIGN, ENV");
    FS116-V4-DICHOTOMY (any k), for non-Siamese after each bend
  not claimed: anything at radius √3 or more (an (R2) arc's witness can be seen there); that F″ keeps saturation; anything about the rings of other
    points; that an arc with both side colours at p can be removed
  converse: FS129-SR1-audit.md § 3.3 FS129-SR1-BENDANY and BENDLE3, the argument
  argument: FS129-SR1-audit.md § 3.3 FS129-SR1-BENDANY and BENDLE3, the argument
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS
  minds: 1
  model: k = 6, the capped strip about a midline vertex P_j on B̄(P_j, 1.8), ρ′ = 1.7 — its four ring arcs are (Q), so F″ is F_√3 with nothing bent
    (FS129-OR1-BENDFRAG's model); no held fragment has a ring arc with a side colour absent at a centre of four or more colours, so the bend clause's
    held models are FS112-N2-RED's maps only
  prior art: owed — in-house; FS-112's bends are "not found in print" (FS112-N2-RED's entry)
  handoff: de Bruijn — in place of FS129-OR1-BENDFRAG and the bend half of FS129-OR1-BEND3: one module, the bends on a whole-tile fragment below √3,
    over FS112-N2-BENDS as an imported hypothesis until FS-112's module lands, following N2's route at the end vertices

Rests on it: FS129-SR1-BENDLE3; and FS129-OR1-QFREE-CLASS, which was written over FS129-OR1-BENDFRAG and reads the same from this form — at k = 6 and a vertex p of at least four colours, an arc of Γ on ω(p) both of whose side colours are carried at p is a (Q) arc by definition, so F″'s ring arcs are F's (Q) arcs, and its tiles at p are F's. Two notes go to de Bruijn with it (`plans/FS129-SR1-audit.md` § 2.1, the attack on QFREE's chain, a checking reading that did not succeed): follow N2's route at the end vertices (NB2's reads a contact tile's shape, which a fragment of radius below 2 does not promise), and prove the connectedness step by quasi-components.

derivation: FS129-SR1-BENDLE3
  statement: let F be a non-Siamese simple valid k-coloured fragment, for any k ≥ 1, on a closed disc B̄(p, r), r > 1, about a point p carrying at most
    three colours, and let 1 < ρ′ < min(r, √3); then there is a non-Siamese simple valid k-coloured fragment on B̄(p, ρ′), with the same colours carried
    at p, whose ring carries no arc of Γ
  uses only: FS129-SR1-BENDANY; FS116-V5-U1's last clause (in a non-Siamese simple fragment a centre carrying both side colours of an arc of Γ on its
    unit circle carries at least four colours; its argument reads validity, one tile per colour at a point and one cone per tile at a vertex, at any k)
  not claimed: anything at a point of four or more colours (there BENDANY keeps the arcs with both side colours at p: the (Q) arcs at k = 6); the
    Siamese or non-simple classes
  argument: FS129-SR1-audit.md § 3.3 FS129-SR1-BENDANY and BENDLE3, the argument
  verdict: derived
  grade: derived from: FS129-SR1-BENDANY, FS116-V5-U1
  minds: 1
  model: k = 6, a cubic trichromatic vertex u of the capped strip whose closed unit disc lies at distance above 1 from the strip's edge, on B̄(u, 1.1)
    (FS129-OR1-BEND3's model)
  prior art: owed — in-house
  handoff: de Bruijn — in place of FS129-OR1-BEND3, with BENDANY

Rests on it: nothing derived; it derives inventory item 82's "generalization, not derived" (below √3 the bends free the ring of any point of at most three colours). **Record-job note (2026-10-03):** FS129-OR1-BEND3, which this replaces with BENDANY, also concludes that the new fragment's tiles include every tile of F meeting B(q, min(r, √3)) other than the ring arcs' side tiles, changed only inside thin lenses; this statement does not say so, though its fragment is BENDANY's F″, whose statement does. No hypothesis is dropped; the Lean statement should conclude with BENDANY's tile clause, or that clause of BEND3 is lost.

derivation: FS129-OR1-QFREE-CLASS
  statement: for each of the four classes of valid six-coloured fragments — all of them, the non-Siamese ones, the simple ones, the non-Siamese
    simple ones — if for every r > 1 no fragment of the class on B̄(p, r) about a vertex p of at least four colours has a ring carrying no arc of
    Γ, then for every r > 1 no fragment of the class on B̄(p, r) about a vertex p of at least four colours has a ring carrying no (Q) arc
  uses only: FS129-OR1-BENDFRAG (its fragment F″ is in F's class, on a disc of radius above 1, with p's colours, and its ring's arcs of Γ are
    F's (Q) ring arcs)
  not claimed: the hypothesis for the Siamese or the non-simple classes (FS-123's question 3, open); anything for rings carrying a (Q) arc
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-QFREE-CLASS
  verdict: derived
  grade: derived from: FS129-OR1-BENDFRAG
  minds: 1
  model: the class of non-Siamese simple fragments, where the hypothesis is FS116-Y4-EMPTY (held) and FS129-OR1-QFREE is the conclusion
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-BENDFRAG, as the bridge that turns any Γ-free exclusion into a (Q)-free one

Rests on it: FS129-OR1-QFREE; and any later Γ-free exclusion in one of the four classes becomes a (Q)-free one at once. Its input FS129-OR1-BENDFRAG is superseded by FS129-SR1-BENDANY, which carries the same step (BENDANY's prose).

derivation: FS129-SR3-EMPTY-NS
  statement: no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying
    no arc of Γ
  uses only: FS116-V6's route to FS116-Y4-EMPTY (`plans/FS116-V6-verification.md` § 2.2) — V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP,
    V6-HUBS, V6-HUG (its colour step through V6-GERM), V6-ANTI and V6-COUNT's count — none of which reads simplicity (§ 2.1); V6-COUNT's last step read on
    sectors: every tile of p owns a sector at p, and two cyclically consecutive sectors of the two tipper groups share an edge, against V6-ANTI
  not claimed: anything in the Siamese class (V6-RING's one tile per colour at p, V6-TIP's tip and V6-HUG's uniqueness of the tip and of R⁻, R⁺ read
    non-Siamese); anything at k ≥ 7 (V6-RING and V6-TIP spend six); that FS116-Y4's own route carries the non-simple class (it reads one cone per tile at
    a double-tipped hub)
  converse: one-way — a non-existence
  argument: FS129-SR3-audit.md § 2.1 Step by step
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence); with the ring condition dropped the class is inhabited — FS114-Y2-BOWTIE, non-Siamese, about a degree-4
    vertex of four colours, its ring carrying two (Q) arcs; the count and the sector step are control fs129-sr3-simple
  prior art: partly: FS116-Y4-EMPTY (held, two routes, the simple class); FS116-V6 left the non-simple class undecided ("whether the conclusion survives
    without them I did not decide", `plans/FS116-V6-verification.md` § 2.3 item 4); no outside search — owed
  handoff: de Bruijn — in place of FS116-Y4-EMPTY, on V6's route: V6-HUG's own colour step (V6-GERM, the Γ-free ring's germs all off Γ), not
    FS129-MR1-DOUBLETIP's cone step, and V6-COUNT's last step on sectors as here

control: fs129-sr3-simple
  of: FS129-SR3-EMPTY-NS — V6-COUNT's count (three antipodal two-path patterns, disjoint tipper groups) and its last step on sectors, any number per tile
  run: python3 ../tools/fs129_sr3_simple.py
  expect: simple: count ok; sectors ok
  fault: python3 ../tools/fs129_sr3_simple.py --fault-sector

control: fs129-sr3-simple-hug
  of: FS129-SR3-EMPTY-NS — the count reads V6-HUG: without it single-edge paths survive
  run: python3 ../tools/fs129_sr3_simple.py
  expect: simple: count ok; sectors ok
  fault: python3 ../tools/fs129_sr3_simple.py --fault-hug

Rests on it: FS129-SR3-QFREE-NS, and through it FS129-SR2-QFCASE. It replaces FS116-Y4-EMPTY in the Lean order on FS116-V6's route (V6-HUG's own colour step through V6-GERM, V6-COUNT's last step on sectors), never through FS129-MR1-DOUBLETIP's cone step, which reads simplicity at the hubs (`plans/FS129-SR3-audit.md` § 2.3; inventory items 126, 131). FS116-Y4's own route does use simplicity. Prior art partly in-house: FS116-V6 had left the non-simple class undecided.

derivation: FS129-SR3-QFREE-NS
  statement: no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying
    no (Q) arc
  uses only: FS129-SR3-EMPTY-NS (for every r > 1); FS129-OR1-QFREE-CLASS at the class of non-Siamese fragments, through FS129-OR1-BENDFRAG (or
    FS129-SR1-BENDANY), whose fragment keeps non-Siamese, p's colours and its tiles at p, and whose validity reads no simplicity (§ 2.1)
  not claimed: anything in the Siamese class (FS-123's question 3); anything at k ≥ 7; anything for rings that carry a (Q) arc (FS-124); that a vertex
    with a (Q) ring dies at any radius
  converse: one-way — a non-existence
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-QFREE-CLASS
  verdict: derived
  grade: derived from: FS129-SR3-EMPTY-NS, FS129-OR1-QFREE-CLASS
  minds: 1
  model: FS114-Y2-BOWTIE, non-Siamese, on B̄(p, 3√3/5) about a degree-4 vertex of four colours — its ring carries two (Q) arcs, so the class is inhabited
    and the statement's alternative holds there
  prior art: owed — in-house
  handoff: de Bruijn — in place of FS129-OR1-QFREE (it drops "simple"), over FS129-SR3-EMPTY-NS and FS129-SR1-BENDANY; FS116-S1-QF is then its case
    with no "simple at p" step

Rests on it: FS129-SR2-QFCASE (S1-QF is its case, no simplicity step); FS-123's question 3, whose non-simple half is closed for (Q)-free rings, the Siamese half left; FS116-C114-LOCAL-F's Γ-free line and FS116-Y4-EMPTY's not-claimed line, which narrow to the Siamese class (inventory items 125, 130; FS129-Z2's stub lines). It supersedes FS129-OR1-QFREE, and FS129-SR1-BENDANY carries the bend step as it does for QFREE (BENDANY's prose). The argument address is OR1's, as SR3 filed it: the class-to-class passage, read at the non-Siamese class.

derivation: FS129-SR2-QFCASE
  statement: FS116-S1-QF's statement — no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a
    degree-4 vertex of four colours whose four edges are segments at right angles — is a case of FS129-OR1-QFREE
  uses only: FS129-SR3-QFREE-NS (S1-QF's class — non-Siamese, valid, six colours, radius 2 > 1, a degree-4 vertex of four colours, a ring
    carrying no (Q) arc — lies inside its class; no simplicity is read); that radius 2 is above 1; FS-116's "valid fragment", six-coloured unless
    "k-coloured" is written
  not claimed: anything for S1-QF in a k-coloured reading with k ≥ 7 (QFREE's limit); anything about saturation's role (QFREE needs none); anything for
    rings carrying a (Q) arc
  argument: FS129-SR2-audit.md § 3.2.2 FS129-SR2-QFCASE, the argument
  verdict: derived
  grade: derived from: FS129-SR3-QFREE-NS
  minds: 1
  model: none — a no-go, its class empty (by S1-QF's route and by QFREE); with "no (Q) arc" dropped the class is inhabited (QFREE's model,
    FS114-Y2-BOWTIE, whose ring carries two (Q) arcs), so the statement is not empty for want of fragments
  prior art: partly: FS116-S1-QF (its own route through S1-LENS, S1-EXIT, S1-CLUSTER); FS129-OR1-QFREE
  handoff: de Bruijn — formalize FS129-SR3-QFREE-NS (over FS129-SR3-EMPTY-NS, on FS116-V6's route, and FS129-SR1-BENDANY) and read S1-QF as its
    case; S1-QF's own route (LENS, EXIT, CLUSTER) is then a second route

Rests on it: nothing. **Corrected by the record job (2026-10-03; inventory items 124, 125, 130):** the argument (`plans/FS129-SR2-audit.md` § 3.2.2) showed a fragment of FS116-S1-QF's class simple at p, glossing FS-116's "simple" as "one sector per tile at p"; `data/fs116/claims.md` § 0 defines simple for the whole fragment, and S1-QF does not assume it, so the statement's "a case of FS129-OR1-QFREE" does not hold as worded (QFREE is stated for simple fragments). This job raised it; FS129-SR3 resolved it (`plans/FS129-SR3-audit.md` § 2.3): S1-QF's class lies inside FS129-SR3-QFREE-NS's, which drops "simple", so the conclusion stands with the gloss idle. Read the statement as "… is a case of FS129-SR3-QFREE-NS"; the statement above is SR2's, left verbatim. Inventory item 117's correction to `plans/FS129-OR1-audit.md` § J3 (S1-QF has no non-simple remainder) stands. As SR2 filed them: `uses only:` began "FS129-OR1-QFREE; that a degree-4 vertex of four colours with four edges has four sectors, one tile each, so the fragment is simple at p;", `grade:` read "derived from: FS129-OR1-QFREE", and the handoff "formalize QFREE (over FS116-Y4-EMPTY) and read S1-QF as its case". *Fields this job changed:* `uses only:`, `grade:` and `handoff:` cite FS129-SR3-QFREE-NS in place of FS129-OR1-QFREE, and the step "so the fragment is simple at p" is withdrawn (SR3 § 2.3; inventory items 125, 130).

derivation: FS129-MR1-DOUBLETIP
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let
    y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring of p such that neither the arc of ω(p) just clockwise of r(ψ − 60°) nor the arc just
    counter-clockwise of r(ψ + 120°) lies on a (Q) arc; then no tile of p is at once the only tile of p whose closure holds y and the only tile of p
    whose closure holds y′
  uses only: FS116-RING-GERM (i) at y and at y′ (the open cone of 60° about the direction to p lies in cones of tiles of p when neither germ of the
    tip pair lies on a (Q) arc); FS116-Y4-FLANK (colour-free, Siamese allowed); FS116-V4-TWIST (germs 60° apart carry different colours; a ring point inside a tile has an absent colour); FS116-V4-DICHOTOMY;
    non-Siamese (one tile of each colour at a point; an outer tile misses B(p, 1)); simple (one cone per tile at a vertex)
  not claimed: anything when the arc just clockwise of r(ψ − 60°) or just counter-clockwise of r(ψ + 120°) lies on a (Q) arc; that y or y′ has a
    single tip in general (two tips at either are not excluded); SEMI-PAR3 (its points y ± 60° lie at (Q) arc ends, not change points); the Siamese or
    non-simple class; anything at k ≥ 7 (three absent colours: the flank tiles' colours may differ, control fs129-mr1-doubletip's plant)
  converse: one-way — "the only" names the hypothesis (a sole shared tip), and the statement is a non-existence, not a characterization
  argument: FS129-MR1-audit.md § Argument for FS129-MR1-DOUBLETIP
  verdict: derived
  grade: derived from: FS116-Y4-FLANK, FS116-RING-GERM, FS116-V4-TWIST, FS116-V4-DICHOTOMY
  minds: 1
  model: none can exist (a non-existence); the hypotheses without the shared tip are FS116-V6-HUG's class when the ring carries no arc of Γ (empty by
    FS116-Y4-EMPTY), and no held fragment has two change points 60° apart (the capped strip's change points have u⁺ and v⁻ on (Q) arcs; the disk's
    corner has y ± 60° inside (Q) arcs); its colour, flank and cone steps are control fs129-mr1-doubletip
  prior art: owed — an in-house composition; its argument is FS116-V6-HUG's and FS116-Y4-EMPTY's, whose own prior art is unsearched
    (`plans/STUB-qfree-ring.md` § Prior-art debts)
  handoff: de Bruijn — the statement and its not claimed, over FS116-Y4-FLANK and RING-GERM (i); it carries FS116-V6-HUG as its Γ-free
    instance, so the kernel module should prove this form once and V6-HUG from it

control: fs129-mr1-doubletip
  of: FS129-MR1-DOUBLETIP — the colour step (two absent colours force one flank colour), the flank geometry (least-curved edges 2cos φ − 1 apart;
    V6-HUG's identity; YB4-2ND's form of PXKILL's pair equal to it; the three-step closure), and the cone step (no interval escapes)
  run: python3 ../tools/fs129_mr1_doubletip.py
  expect: colour ok; flank ok; cone ok
  fault: python3 ../tools/fs129_mr1_doubletip.py --fault-colour

control: fs129-mr1-doubletip-cone
  of: FS129-MR1-DOUBLETIP — the cone step reads the shared tip's cone: without it an interval of directions escapes
  run: python3 ../tools/fs129_mr1_doubletip.py
  expect: colour ok; flank ok; cone ok
  fault: python3 ../tools/fs129_mr1_doubletip.py --fault-cone

control: fs129-mr1-doubletip-flank
  of: FS129-MR1-DOUBLETIP — the flank step reads the edges' curvature: tangent segments stay 1 apart
  run: python3 ../tools/fs129_mr1_doubletip.py
  expect: colour ok; flank ok; cone ok
  fault: python3 ../tools/fs129_mr1_doubletip.py --fault-flank

Rests on it: FS116-V6-HUG, its Γ-free instance (a ring with no arc of Γ has every germ off (Q) arcs; `plans/FS129-SR1-audit.md` § Stage 3, group 1), so the kernel proves this form once and V6-HUG from it; and FS-124's ring types, which it prunes in case 5 and at hubs and kind-T semi-hubs in case 1 (inventory item 82; FS129-Z2's stub line). It does not reach SEMI-PAR3. **Changed by the record job** (inventory items 95, 100): FS116-N2-STAR is dropped from `uses only:`, `grade:` and `handoff:` — pass 3's attack (`plans/FS129-SR1-audit.md` § 2.2, a checking reading that did not succeed) found that step 3 needs only non-Siamese and FS116-V4-DICHOTOMY. As MR1 filed them: `uses only:` held "FS116-N2-STAR (C(y) = A(p) ⊔ T_y ⊔ O_y at a change point, p of four colours)" between FLANK and V4-TWIST; `grade:` read "derived from: FS116-Y4-FLANK, FS116-RING-GERM, FS116-N2-STAR, FS116-V4-TWIST, FS116-V4-DICHOTOMY"; the handoff read "over FS116-Y4-FLANK, RING-GERM (i) and N2-STAR". **Caution for the Lean list (FS129-SR3, `plans/FS129-SR3-audit.md` § Stage 2 — SAVED: item (d)):** SR1 § 6.2 item 2, "DOUBLETIP in place of V6-HUG", would lose FS129-SR3-EMPTY-NS, because this entry's step 3 uses one cone per tile at the hubs; FS116-V6-HUG's own colour step is kept for the Γ-free ring. *Fields this job changed:* FS116-N2-STAR dropped from `uses only:`, `grade:` and `handoff:` (SR1 § 2.2: step 3 needs only non-Siamese and FS116-V4-DICHOTOMY; inventory items 95, 100).

derivation: FS129-SR3-OUTERADJ
  statement: in a non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and
    y′ = r(ψ + 60°) be change points of the ring such that neither the arc of ω(p) just counter-clockwise of r(ψ − 60°) nor the arc just clockwise of
    r(ψ + 120°) lies on a (Q) arc; then no colour of p is at once the only colour carried at y by a tile that is not a tile of p and the only colour
    carried at y′ by a tile that is not a tile of p
  uses only: FS116-RING-GERM (ii) at y (outer pair u⁻, v⁺) and at y′ (u′⁻, v′⁺) — u⁻ (the ring just clockwise of y′) and v′⁺ (just counter-clockwise
    of y) are off Γ because y′ and y are change points, the other two by hypothesis — and its first clause (p has four colours, X and X̄ absent);
    V6-GERM's neighbourhood form at y from the germs u⁻ (colour X) and u⁺ (colour X̄), and at y′ from v′⁺ (X) and v′⁻ (X̄), all off Γ (the argument of
    FS116-N1-GERM-R, which reads only N-E1 and the germs' colours); the germs' colours from validity (ring points 60° apart differ, two absent colours);
    non-Siamese (one tile per colour at a point; distinct tiles of one colour have no closure points below 1 apart, FS116-V4-DICHOTOMY); the diameter
    bound; FS129-SR1-TWOCIRC at the mirror apex y + y′ − p; six colours, spent in RING-GERM and in the colour of the tile beyond the outer tile
  not claimed: anything when y or y′ carries two or more outer colours (the tile beyond the outer tile may then be outer and unpinned: tangent segments
    stay exactly 1 apart, plant --fault-tangent); anything when the arc just counter-clockwise of r(ψ − 60°) or just clockwise of r(ψ + 120°) lies on a
    (Q) arc (RING-GERM (ii) is then unavailable); the Siamese class; anything at k ≥ 7 (a third absent colour leaves the tile beyond unpinned, plant
    --fault-seven); that y or y′ has a single tip
  converse: one-way — a non-existence; "the only" names the hypothesis, not a characterization
  argument: FS129-SR3-audit.md § 3.1 Argument for FS129-SR3-OUTERADJ
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence, hypothetical by design); the hypotheses without the shared colour are met at a four-colour hub whose neighbour
    has another outer colour — no held fragment has two change points 60° apart (as for DOUBLETIP); FS116-V6's stage-1 candidate (outer colours 2, 3 at
    y_0 and 2 at y_1, `plans/FS116-V6-verification.md` § 2.3 item 1) shows the rule at work: its builder gave y_0 a second outer colour because of it
  prior art: owed — an in-house composition; its last step is FS116-V6-ADJ's and FS114-Y5-PXKILL's mechanism (G83's straddle), unsearched outside
  handoff: de Bruijn — the statement and its not claimed, over RING-GERM (ii), V6-GERM's neighbourhood form and TWOCIRC; it carries FS116-V6-ADJ's
    argument as its last step, so V6-ADJ is formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair) or
    not at all

control: fs129-sr3-outeradj
  of: FS129-SR3-OUTERADJ — the cone facts at y and y′ (interval arithmetic), the colour step, and the mirror arcs below 1 (identity exact, grid by intervals)
  run: python3 ../tools/fs129_sr3_outeradj.py
  expect: outeradj: cones ok; colour ok; arcs ok
  fault: python3 ../tools/fs129_sr3_outeradj.py --fault-tangent

control: fs129-sr3-outeradj-seven
  of: FS129-SR3-OUTERADJ — the colour step spends six: with a third absent colour the tile beyond the outer tile is not forced to be X
  run: python3 ../tools/fs129_sr3_outeradj.py
  expect: outeradj: cones ok; colour ok; arcs ok
  fault: python3 ../tools/fs129_sr3_outeradj.py --fault-seven

Rests on it: FS-124's ring types, which it prunes beside FS129-MR1-DOUBLETIP (DOUBLETIP's outer twin; inventory item 133, FS129-Z2's stub line). It widens FS116-V6-ADJ (two change points 60° apart, each with its outer germ off the shared arc free of (Q) arcs, never share a single outer colour; non-Siamese, no simplicity) and carries V6-ADJ's argument as its last step, so V6-ADJ is formalized class-free or not at all (its handoff). It rests on FS129-SR1-TWOCIRC's identity, through V6-ADJ's step.

derivation: FS129-SR1-TWOCIRC
  statement: let y₀ and y₁ be points of the plane with |y₀ − y₁| = 1, and p a point with |p − y₀| = |p − y₁| = 1; for real s, t let a(s) be the point
    of ω(y₀) reached from y₁ by turning through the angle s about y₀ toward p, and b(t) the point of ω(y₁) reached from y₀ by turning through the
    angle t about y₁ toward p; then |a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t, and for
    0 < s, t < 180° the distance |a(s) − b(t)| is below 1 when s + t < 180°, equal to 1 when s + t = 180°, and above 1 when s + t > 180°
  uses only: a congruence taking (y₀, y₁, p) to (e(0°), e(60°), 0), which keeps "toward p"; there a(s) = y₀ + e(120° + s) and b(t) = y₁ + e(300° − t);
    the half-angle formulas
  not claimed: anything about tiles — each use (FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ, FS116-Y4-FLANK) adds its own pinning of two tiles to the
    two circles; anything for s or t outside (0°, 180°)
  argument: FS129-SR1-audit.md § 3.1 FS129-SR1-TWOCIRC, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: s = t = 30°: |a − b| = 2 cos 30° − 1 = √3 − 1, the gap of FS116-V6-HUG's model line ("its two X̄ ring tiles √3 − 1 apart at s = t = 30°")
  prior art: partly: in-house three times, unnamed (FS114-YB4-2ND's expanded form, FS116-V6-HUG's product form, FS116-Y4-FLANK's diagonal); Poros's
    R2 card 2 names it the three-unit-step closure |u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw) (as quoted in plans/FS129-MR1-audit.md; the card
    not re-read here); the constant width of the unit Reuleaux triangle
  handoff: de Bruijn — one lemma, proved once and consumed by FS114-Y5-PXKILL, FS116-V6-ADJ, FS116-Y4-FLANK and (through FS129-MR1-DOUBLETIP)
    FS116-V6-HUG; the statement and its not claimed

control: fs129-sr1-twocirc
  of: FS129-SR1-TWOCIRC — both forms of the identity, the diagonal 2cos φ − 1, the sign on a grid of angles (step 15°), and V6-ADJ's mirror, exactly
  run: python3 ../tools/fs129_sr1_twocirc.py
  expect: twocirc ok
  fault: python3 ../tools/fs129_sr1_twocirc.py --fault-sign

control: fs129-sr1-twocirc-diag
  of: FS129-SR1-TWOCIRC — the diagonal reads 2cos φ − 1, not 2cos φ + 1
  run: python3 ../tools/fs129_sr1_twocirc.py
  expect: twocirc ok
  fault: python3 ../tools/fs129_sr1_twocirc.py --fault-diag

Rests on it: the identity steps of FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ and FS116-Y4-FLANK (each keeps its own pinning of two tiles), and through FLANK FS129-MR1-DOUBLETIP. It is Kooshi's "where else can we use that identity?" (`plans/FS116-close-inventory.md` item 142) answered: one law found three times, unnamed (inventory item 75).


## 5. Lane R — the other entries

derivation: FS129-SR3-E2ONE
  statement: in a non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about p, with a pinwheel at p, no edge at p of
    length 60° (no E1) and E2 at exactly one blade t_{c+1}, the pocket colours satisfy m_{c−1} ≠ m_c; hence POCKET at w_c and CASE at q_c hold, and no
    such pinwheel exists at radius 1 + ε; in particular FS114-Y6-E2RED's survivor family S6, (120°, b, 180° − b, 60°), has no member
  uses only: FS114-Y5-ALT at the three pairs (μ_c, μ_{c+1}), (μ_{c+1}, μ_{c+2}), (μ_{c+2}, μ_{c+3}) — each needs only all edges below 60° and no E2 at
    t_{c+2}, t_{c+3}, t_c respectively; that each pocket colour m_j is one of the two colours absent at p (FS114-Y5-MU's setting: pocket tiles lie
    inside B(p, 1) and are not tiles of p); FS114-Y6-E2RED's chain clause (E2 at t_{c+1} breaks only ALT(μ_{c−1}, μ_c), which only POCKET at w_c reads,
    which only CASE at q_c reads — two readings, FS114-Y6's and YB5's blind one); FS114-Y5-PINALL's chain outside E1 and E2 (POCKET, CASE, REDUCE,
    PIN120-60, PXKILL), whose use of "no E2" is ALT alone (YB4 item 11, YB5 item 6)
  not claimed: E2 at two or more blades (two broken ALTs leave the parity free: plant --fault-two); E1, with or without E2 (E1 breaks MU at its edge,
    so not every pocket colour is defined, and the residues E1-Z, E1-60, E1-ν, E1{1,2}, E1{1,4} stand); E1CAP's wrap at λ_3; anything in the Siamese
    or non-simple class
  converse: one-way — a non-existence; "exactly one" is a hypothesis, not a characterization
  argument: FS129-SR3-audit.md § 1.3 Argument for FS129-SR3-E2ONE
  verdict: derived
  grade: derived from: FS114-Y5-PINALL, FS114-Y6-E2RED
  minds: 1
  model: none can exist (a non-existence, hypothetical by design); the local configuration of P_90 at radius 1 + ε, built by formula
    (`tools/fs114_y5_px.py`), meets every hypothesis but E2, and no held object has E2 at a blade; the parity and S6's death under CASE are control
    fs129-sr3-e2one
  prior art: owed — an in-house composition (ALT, three times, around the four-cycle of pockets); the pinwheel exclusion's own prior art is FS-114's
    gate ("ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0))
  handoff: de Bruijn — the parity step as a corollary of ALT at three pairs; with it FS114-Y5-PINALL is formalized with the exception "E1, or E2 at two
    or more blades", and S6 leaves FS114-K1's case list

control: fs129-sr3-e2one
  of: FS129-SR3-E2ONE — the parity on all 64 colourings of the four pockets for each broken pair, and S6 killed by CASE at q_c on a grid of b
  run: python3 ../tools/fs129_sr3_e2one.py
  expect: e2one: parity ok; F2 ok
  fault: python3 ../tools/fs129_sr3_e2one.py --fault-two

control: fs129-sr3-e2one-case
  of: FS129-SR3-E2ONE — CASE at q_c reads the neighbour a_{c−1} = 120°, not a_{c+1}
  run: python3 ../tools/fs129_sr3_e2one.py
  expect: e2one: parity ok; F2 ok
  fault: python3 ../tools/fs129_sr3_e2one.py --fault-case

Rests on it: FS114-Y5-PINALL's exception, which narrows to "E1, or E2 at two or more blades", and FS114-Y5-PIN120's; FS114-Y6-E2RED's not-claimed line (S6 is empty); FS114-K1's case list, which drops S6 and the wrap's E2RED site (inventory items 127, 130). This job files the errata under FS114-Y5-PINALL and FS114-Y6-E2RED (`plans/FS114-derivation.md`); the stub lines are FS129-Z2's (item 133).

derivation: FS129-SR1-SIXQ
  statement: let F be a valid k-coloured fragment, for any k ≥ 1, Siamese pairs allowed, on a closed disc of radius above 1 about a point p at which
    all k colours are carried; then ω(p) lies in Γ, and both side colours of every arc of Γ on ω(p) are carried at p; so at k = 6, when p carries six
    colours, every arc of Γ on ω(p) is a (Q) arc
  uses only: FS116-N1-TWIST-D (the ring points in the closure of a tile of one of p's colours form a closed set lying in the union of the arcs of Γ on
    ω(p) and finitely many points); that every point of the fragment's open set lies in the closure of a tile (Γ, a locally finite union of arcs, has
    empty interior); the definition of (Q) (both side colours and at least four colours at the centre)
  not claimed: FS116-N2-SIXRING's structure (six 60° arcs, each the ring points of one tile; it needs non-Siamese); anything when a colour is absent at
    p (five colours: FS116-N2-FIVERING); that a fragment with a six-colour vertex exists beyond radius 3/2
  argument: FS129-SR1-audit.md § 3.2 FS129-SR1-SIXQ, the argument
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: FS116-Y2-SIXFRAG, the straight flower: its centre carries six colours and its ring is six (Q) arcs (FS116-N2-SIXRING's model line)
  prior art: partly: FS112-SIX's six-colour clause (valid six-coloured maps, two minds), of which this is the fragment form at any k
  handoff: de Bruijn — with TWIST-D, in place of FS112-SIX's six-colour clause; FS112-SIX's five-colour clause is FS116-N2-FIVERING's last clause
    in a weaker form, so FIVERING is formalized in its place

Rests on it: nothing derived in FS-129; with FS116-N2-FIVERING it replaces FS112-SIX in the Lean order (SR1 § 6.2 item 3); FS116-N2-SIXRING stays as its non-Siamese strengthening.

derivation: FS129-SR1-RINGBAND
  statement: let c colour the circle by ℤ/3, defined and locally constant off a finite set Σ of change points, with c(θ) ≠ c(θ + 60°) wherever both
    are defined; lift c to c̃, changing by +1 or −1 at each change point, and put W = (c̃(θ + 360°) − c̃(θ))/3; for θ with no point θ + 60°j in Σ put
    D_j(θ) = c̃(θ + 60°(j + 1)) − c̃(θ + 60°j), m_j(θ) = ⌊D_j(θ)/3⌋, n₂(θ) = #{j : D_j(θ) ≡ 2 (mod 3)} and h(θ) = (1/3) Σ_{j=0..5} d(c(θ + 60°j),
    c(θ + 60°(j + 1))), with d(x, y) = ±1 as y = x ± 1 (FS129-OA1-RINGWIND's W); then (i) h(θ) = (6 − 2n₂(θ))/3, a value in {−2, 0, 2}; (ii) W = m_0(θ)
    + m_1(θ) + … + m_5(θ) + 3 − h(θ)/2; (iii) h changes across θ₀ only if Σ holds two points θ₀ + 60°j and θ₀ + 60°(j + 1); (iv) if no point of Σ is a
    swap point (a change point x with c(x + 60°−) = c(x+) and c(x + 60°+) = c(x−), or the same with −60°), all m_j(θ) equal one integer M, W is
    6M + 2, 6M + 3 or 6M + 4, and W = 6M + 3 unless Σ is invariant under the rotation by 60°; (v) if no two points of Σ are 60° apart, h is 0
    everywhere and W = 6M + 3
  uses only: c(θ) ≠ c(θ + 60°), so no D_j is ≡ 0 (mod 3); that Σ is finite; at an event, the change of D_j is Δ_{j+1} − Δ_j (Δ_j the step crossed at
    the hexagon's j-th point, 0 if none), so the changes sum to zero; FS110-N2-RING's band step (D_0 leaves {3M + 1, 3M + 2} only by a jump of ±2,
    which needs a swap)
  not claimed: anything about tiles or maps (the circle colouring is the input; FS110-N2-RING's setting — a three-colour vertex whose ring carries no
    arc of Γ, coloured by its three absent colours — supplies one); that h is constant across two change points 60° apart (the swap moves it, row 132
    and G71)
  argument: FS129-SR1-audit.md § 3.4 FS129-SR1-RINGBAND, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: the ring of six 60° arcs coloured 0, 1, 2, 0, 1, 2 — no swap point, Σ invariant, h = 2, W = 2 = 6·0 + 2; nine 40° arcs coloured 0, 1, 2, …
    (`plans/FS110-Y-construction.md` § 8.2's control) — no two change points 60° apart, h = 0, W = 3
  prior art: partly: FS110-N2-RING (the band) and FS110-Y3-GP (the count n₂ = 3, so W = 6M + 3), in-house, two minds each; FS129-OA1-RINGWIND
    (one mind) is (i) with (iii); G71's height functions; the identity (ii) and the refinement in (iv) not found in-house (not searched outside)
  handoff: none — FS110-N2-RING and -Y3-GP are declined for the kernel and RINGWIND crosses nowhere; if any of the three is formalized, this lemma is
    formalized once in their place

control: fs129-sr1-ringband
  of: FS129-SR1-RINGBAND — (i), (ii), (iii), (iv) and (v) on every proper discretised ring of 12 and of 18 cells and on 4000 seeded random ones of
    24 to 60 cells (44 with no 60° pair, 10896 with no swap point, 30 of those rotation-invariant)
  run: python3 ../tools/fs129_sr1_ringband.py
  expect: ringband ok (101284 rings; no 60-degree pair 44, no swap point 10896, of which rotation-invariant 30)
  fault: python3 ../tools/fs129_sr1_ringband.py --fault

Rests on it: nothing (its handoff is none); it is the one lemma under FS110-N2-RING, FS110-Y3-GP and FS129-OA1-RINGWIND, formalized in their place should any be. **Record-job note (2026-10-03):** RINGWIND's last clauses — W has period 60°, its jumps over one period sum to zero, and a hexagon position that is the only one with two change points 60° apart carries no jump — are not restated here; they follow at once from h's definition (h(θ + 60°) is the same cyclic sum over one hexagon) with (iii). No hypothesis is dropped; a Lean statement replacing RINGWIND should carry them.

derivation: FS129-OR1-LOCALDENSE
  statement: every valid six-coloured fragment on a closed disc B̄(x, 3) has, in B̄(x, 3), a vertex of at least four colours or a vertex with a repeated
    colour
  uses only: FS112-DISC1 (a closed disc of radius 1 holds a vertex of degree at least 3), read on a fragment: its argument nests tiles surrounding x, each
    of diameter at most 1 and so inside B̄(x, 1); FS112-N3-BASE, read on a fragment: if B̄(u, 2) about a cubic trichromatic vertex u holds no vertex of at
    least four colours and none with a repeated colour, the base derives a contradiction from the colours of points of B̄(u, 2) alone, after N2-TOWARD
    bends of inert unit arcs centred in B̄(u, 1) (NB3's walk: "every point whose colours it reads lies in B̄(u, 2)"; "C-LOCAL: radius 2 about u")
  not claimed: that the class is inhabited (no fragment on a disc of radius 3 is held); that the vertex found has at least four colours (it may have
    a repeated colour instead); anything below radius 3; that FS112-N3-BASE's own
    inputs (row 134's base, BASE-V's residue: CUSP-BASE's D5 items 1–4, 6 at one mind) are stronger than their grade
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-LOCALDENSE
  verdict: derived
  grade: derived from: FS112-DISC1, FS112-N3-BASE
  minds: 1
  model: none held — no valid six-coloured fragment on a disc of radius 3 is known (the largest held is FS112-CAL-DISK's disk, radius ≈ 2.1246), and
    the class may be empty (DISC-F at radius 3 would empty it), in which case the statement is vacuous; it carries something exactly on the YES side's
    objects — fragments on discs of every radius (FS116-O1-YESLIM) — each of which it constrains
  prior art: owed — in-house; FS112-N3-DENSE3's own prior art is "not found in print"
  handoff: de Bruijn — with FS112-N3-DENSE3's module (FS-114's stub), stated on fragments

Rests on it: FS129-OR1-DISCF-NS. Its input FS112-DISC1 is now a case of FS106-TS-T (FS129-SR2-DISC1TS). The class may be empty (no fragment on a disc of radius 3 is held); then it is vacuous, and it constrains exactly the YES side's objects (FS116-O1-YESLIM).

derivation: FS129-OR1-DISCF-NS
  statement: if for some R > 0 no non-Siamese simple valid six-coloured fragment exists on a closed disc of radius R about a vertex of at least four
    colours, then no non-Siamese simple valid six-coloured fragment exists on any closed disc of radius R + 3
  uses only: FS129-OR1-LOCALDENSE; that a non-Siamese simple fragment has no vertex with a repeated colour (two tiles of one colour at a vertex are near,
    FS116-V4-DICHOTOMY; one tile twice at a vertex has a closure that meets itself); that a fragment on a disc is a fragment on every smaller disc inside it
  not claimed: the Siamese or non-simple form (there LOCAL-DENSE's repeated-colour alternative is not covered by C114-LOCAL-F); the hypothesis itself
    (C114-LOCAL-F in the non-Siamese simple class, open — FS-124)
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-DISCF-NS
  verdict: derived
  grade: derived from: FS129-OR1-LOCALDENSE, FS116-V4-DICHOTOMY
  minds: 1
  model: the hypothesis is open, so the model is its class: FS114-Y2-BOWTIE, a non-Siamese valid fragment about a four-colour vertex on B̄(p, 3√3/5),
    inhabits the class the hypothesis quantifies over at radius below 3√3/5
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-LOCALDENSE

Rests on it: nothing derived; with C114-LOCAL-F in the non-Siamese simple class (FS-124, open) it gives DISC-F there at radius R + 3 (J19, half closed). Inventory item 59 notes the consequence for `plans/FS116-local-exclusion.md` § 3.6 (outside this job's files).

derivation: FS129-OR1-TOP5
  statement: if REG-J′₅ holds — FS111-M-REDUCE-I's regularity hypothesis at five colours, a saturated colouring whose singular set Σ is locally finite
    with finitely many interface arcs at each point of Σ — then the honest existence form of C-SAT-T at five (every tight a.e.-proper five-colouring can
    be modified, keeping it a.e.-proper with five colours, into an honest saturated one; FS121-SAT6's k = 5 clause) holds if and only if
    χ_m⁰(ℝ²) ≥ 6, the forward direction at FS106-AE-MAP6's grade (modulo Townsend's simplification (c))
  uses only: FS111-M-REDUCE-I ("with FS106-AE-MAP6, χ_m⁰(ℝ²) ≥ 6 follows from those two statements at k = 5"); FS111-V0-RESCALE (a tight a.e.-proper
    k-colouring exists if and only if χ_m⁰(ℝ²) ≤ k); vacuity
  not claimed: REG-J′₅ (FS121-REGJ at five, open — FS-127's LAT); the honest existence form at five; the equivalence without REG-J′₅; the forward
    direction beyond FS106-AE-MAP6's grade; anything at six (FS121-D3-EQ)
  converse: FS129-OR1-audit.md § Argument for FS129-OR1-TOP5
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-TOP5
  verdict: derived
  grade: derived from: FS111-M-REDUCE-I, FS111-V0-RESCALE
  minds: 1
  model: vacuous when χ_m⁰(ℝ²) ≥ 6 (no tight five-colouring exists, by FS111-V0-RESCALE, and every clause holds); no non-vacuous model is known, which is
    the statement's content: at five colours the top-colour clause is the answer restated once REG-J′₅ is granted
  prior art: owed — in-house; the six-colour mirror is FS121-D3-EQ
  handoff: de Bruijn — the statement as a corollary of FS111-M-REDUCE-I's module, over FS106-AE-MAP6 as an imported hypothesis

Rests on it: nothing derived; it is the map step at five (J10) stated as the answer restated once REG-J′₅ is granted — a carrier for it is FS129-P1's ranking call (inventory item 26).

derivation: FS129-SR2-CLOSURE
  statement: let U ⊆ ℝ² be open, with (Leb ⊗ σ){(x, w) ∈ U × S¹ : x + w ∈ U} = 0; then no point of U is at distance exactly 1 from a point of cl U
  uses only: FS111-M2-INT with A = U; that every point of an open set is a Lebesgue density point of it, so U ⊆ int Ũ; that every density point of U
    lies in cl U, so cl Ũ = cl U
  not claimed: anything for a point of cl U against another point of cl U (two boundary points may be at distance 1: the hexagonal seven-colouring's
    opposite vertices, FS111-C-HULL-SO's object); anything for sets that are not open (that is FS111-M2-INT itself)
  argument: FS129-SR2-audit.md § 2.2.1 FS129-SR2-CLOSURE, the argument
  verdict: derived
  grade: derived from: FS111-M2-INT
  minds: 1
  model: U the open hexagon of circumradius 1/2 (diameter 1, so no two of its points are at distance 1); cl U's farthest point from any point of U is
    below 1
  prior art: partly: in-house three times — FS106-DIAM's third clause, FS111-V0-CLOSE, FS116-V5-NE1's first clause — and FS111-M2-INT is its measurable form
  handoff: de Bruijn — formalize once, as FS111-M2-INT's corollary for open sets (or by V0-CLOSE's translation argument directly), in place of FS106-DIAM
    (iii), FS111-V0-CLOSE and FS116-V5-NE1's first clause; the statement and its not claimed

Rests on it: the three places it is proved — FS106-DIAM (iii), FS111-V0-CLOSE, FS116-V5-NE1's first clause — which the kernel proves once, as FS111-M2-INT's corollary for open sets (SR2 § 4.3 item 9).

derivation: FS129-SR2-HULLSET
  statement: let A ⊆ ℝ² be measurable with (Leb ⊗ σ){(x, w) : x ∈ A, x + w ∈ A} = 0, Ã its Lebesgue density points and A* = {x : d̄_A(x) > 0}; for
    every path-connected C ⊆ Ã and every x ∈ A*, either |x − c| < 1 for every c ∈ C or |x − c| > 1 for every c ∈ C; when C is compact, either
    sup_{c∈C}|x − c| < 1 or dist(x, C) > 1
  uses only: FS111-V0-ID1's argument, which reads only that A's own unit pairs are null; continuity of c ↦ |x − c| on a path-connected C; a continuous
    function on a compact set attains its bounds
  not claimed: A* ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for non-compact C (FALSE: FS111-C-HULL-SO); anything at points of density 0
  argument: FS129-SR2-audit.md § 2.2.2 FS129-SR2-HULLSET, the argument
  verdict: derived
  grade: derived from: FS111-V0-ID1
  minds: 1
  model: A one hexagon of the tight hexagonal seven-colouring (FS111-C-HULL's model), C its interior, x a point of another hexagon of the same colour
    (distance above 1.29 to every point of C)
  prior art: partly: FS111-C-HULL (the same conclusion for tight a.e.-proper colourings in D-NF), FS-106's I-D1 for tight colourings
  handoff: de Bruijn — in place of FS111-C-HULL: one measurable set, no colouring, no tightness, no normal form; C-HULL is its case S_j = A

Rests on it: FS111-C-HULL as its case, and through C-HULL its consumers FS111-M-PINCH, -M-HULL2, -M2-FIX, -M-COVER-SC, -M-HALF, which then need no colouring, tightness or normal form for this step (SR2 § 2.1 row 24; § 4.3 item 10). It is the true top of the lane-R root chain that the false edge from the refuted FS111-C-HULL-SO had displaced (inventory items 77, 99).

derivation: FS129-SR2-SUPK
  statement: for every k ≥ 1, µ_k⁰ = lim_{ε→0} µ_k(ε) = lim_{ε→0} µ_k^tile(ε) = lim_{ε→0} µ_k^per(ε), with µ_k⁰, µ_k(ε), µ_k^tile(ε), µ_k^per(ε)
    defined as FS106-SUP defines them at six (the suprema of the upper densities covered by a.e.-proper, band-proper, band-proper tiled, and
    band-proper periodic tiled partial k-colourings)
  uses only: FS106-SUP's argument (plans/FS106-TQ-derivation.md § 3.2) and its Lemmas P and T (§ 3.1) and TQ-REM-i, none of which reads the number of
    classes: Lemma P copies a colouring of a square, Lemma T colours each grid square by the least class meeting it in positive measure, REM-i keeps
    points class by class
  not claimed: SUP's second clause (µ^per(ε) = µ(ε) at each ε, and attainment) at every k — QB's stronger form was not read here; any value of µ_k⁰
  argument: FS129-SR2-audit.md § 2.2.3 FS129-SR2-SUPK, the argument
  verdict: derived
  grade: derived from: FS106-SUP
  minds: 1
  model: k = 7 — the tight hexagonal seven-colouring covers everything with no monochromatic unit pair a.e., so µ₇⁰ = 1, and its slack shrinkings
    show lim µ₇(ε) = 1
  prior art: partly: FS106-SUP at six (two minds); FS106-EQ's every-k form already uses it at every k
  handoff: de Bruijn — in place of FS106-SUP; then FS106-EQ's (e) has its input as stated, and EQ's (c) ⟺ (d) is SUPK at the value 1

Rests on it: FS106-EQ's every-k form, whose clause (e) rests on FS106-SUP and was stated at every k while SUP was stated at six; this job files the erratum under FS106-EQ. FS106-EQ's (c) ⟺ (d) is SUPK read at the value 1.

derivation: FS129-SR2-DISC1TS
  statement: every closed disc of radius 1 of a valid map contains a vertex of degree at least 3 (FS112-DISC1's statement), as a case of FS106-TS-T
  uses only: FS106-TS-T (every point of an almost-everywhere-proper map has a point of chromaticity at least 3 within 1/√2 + ε); that a valid map is an
    almost-everywhere-proper map in TS-T's sense (FS-112's definition: a locally finite map by open connected tiles, no two interior points of one
    colour at distance 1); that in a locally finite map a point in the closures of tiles of three colours is a vertex where at least three tiles meet
  not claimed: anything sharper than TS-T's radius 1/√2 + ε; the trichromatic or cubic forms TS-T gives under Conditions 5 or 6
  argument: FS129-SR2-audit.md § 2.2.4 FS129-SR2-DISC1TS, the argument
  verdict: derived
  grade: derived from: FS106-TS-T
  minds: 1
  model: none known for valid maps, which are six-coloured and whose non-existence is the map NO itself (hypothetical by design, a step toward the
    NO); TS-T's own class, a.e.-proper maps with any number of colours, is inhabited by the tight hexagonal seven-colouring, which has a vertex of
    degree 3 within 1/2 of every point
  prior art: partly: CB's D6 (the trichromatic form for cubic maps), as FS112-DISC1's entry says
  handoff: de Bruijn — formalize FS106-TS-T in place of FS112-DISC1; DISC1's consumers (FS112-N2-DENSE, -N3-DENSE3) read it as TS-T's corollary

Rests on it: FS112-DISC1's consumers — FS112-N2-DENSE, FS112-N3-DENSE3 and FS129-OR1-LOCALDENSE — which read it as FS106-TS-T's corollary (SR2 § 4.3 item 12).

derivation: FS129-SR2-YESLIM-EQ
  statement: for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment, then χ_m⁰(ℝ²) ≤ k (FS116-O1-YESLIM's
    first clause), as a corollary of FS106-EQ's implication (c) ⟹ (a) at k
  uses only: FS106-EQ (c) ⟹ (a) at k — if for every δ > 0 there are k disjoint measurable classes with Leb ⊗ σ-null monochromatic unit pairs whose union
    has upper density at least 1 − δ, then χ_m⁰(ℝ²) ≤ k (FS106-COMP's first clause, stated by EQ at every k); Lemma P of plans/FS106-TQ-derivation.md
    § 3.1 in its Leb ⊗ σ-null form; that a fragment's tile boundaries are Lebesgue-null and its colour classes have no unit pair between interior points
  not claimed: YESLIM's clause at six with no MR (that is row 130's χ(ℝ²) ≤ χ_m⁰(ℝ²), unchanged); anything about a single fragment of bounded radius
  argument: FS129-SR2-audit.md § 3.2.1 FS129-SR2-YESLIM-EQ, the argument
  verdict: derived
  grade: derived from: FS106-EQ
  minds: 1
  model: k = 7 — the tight hexagonal seven-colouring restricted to discs of every radius is a valid seven-coloured fragment on each, and χ_m⁰(ℝ²) ≤ 7
  prior art: partly: FS116-O1-YESLIM (the same statement by COMP's Route I directly), FS106-COMP
  handoff: de Bruijn — formalize FS106-EQ's (c) ⟹ (a) once at every k (the weak-* step), and YESLIM as this two-line corollary in place of its own
    weak-* argument

Rests on it: FS116-O1-YESLIM's first clause, which becomes a two-line corollary of FS106-EQ's (c) ⟹ (a) (SR2 § 4.3 item 18); the YES side's reading (valid fragments on discs of every radius give χ_m⁰(ℝ²) ≤ k) through it.

derivation: FS129-SR2-TOUCHW
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a
    point of ω(p) which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and
    just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one
    colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of
    colour X̄ has w in its closure
  uses only: FS116-N1-TOUCH's argument (plans/FS116-N1-proof.md § 4.2), in which the hypothesis "w in the closure of a tile of one of p's colours" is
    idle (FS116-V3 § 3.1: TRUE with it idle; § 4.4's uses-only note); FS116-N1-TWIST-D; N-E1; FS116-N1-GERM-R with c = X̄ at all four germs; six colours
  not claimed: anything at k ≥ 7; anything when a germ lies on a (Q) arc; that such a point exists in any fragment of SAT-QFREE's class
  argument: FS129-SR2-audit.md § 3.2.3 FS129-SR2-TOUCHW, the argument
  verdict: derived
  grade: derived from: FS116-N1-TOUCH
  minds: 1
  model: FS116-Y1-F15's F(1/5) at q_N — the ring there is R with germs G, as TOUCH's model line says, and q_N meets the hypotheses with or without the idle one
  prior art: owed — in-house (FS116-V3 § 3.1 found the hypothesis idle; this entry states the wider form)
  handoff: de Bruijn — in place of FS116-N1-TOUCH; FS116-N2-RECIP's use of TOUCH reads it

Rests on it: FS116-N2-RECIP, which uses FS116-N1-TOUCH and reads the wider form (SR2 § 4.3 item 20). The idle hypothesis was found by FS116-V3 § 3.1; this entry states the wider form so that it is formalized once.


## 6. Lane R — superseded forms (kept, marked)

derivation: FS129-OR1-QFREE
  statement: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a
    ring carrying no (Q) arc
  uses only: FS116-Y4-EMPTY (the same statement with "no arc of Γ" for "no (Q) arc"); FS129-OR1-QFREE-CLASS at the non-Siamese simple class
  not claimed: anything in the Siamese or non-simple classes (FS-123 question 3; FS-124 case 7); anything at k ≥ 7 (EMPTY's own limit); anything
    for rings that carry a (Q) arc (FS-124); that a four-colour vertex with a (Q) ring dies at any radius
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-QFREE-CLASS
  verdict: derived
  grade: derived from: FS116-Y4-EMPTY, FS129-OR1-QFREE-CLASS
  minds: 1
  model: FS114-Y2-BOWTIE, a non-Siamese valid six-coloured fragment on B̄(p, 3√3/5) about a degree-4 vertex of four colours — its ring carries
    two (Q) arcs, the Reuleaux caps (FS-116's erratum under FS114-N7-3T), so the class is inhabited and the statement's alternative holds there
  prior art: owed — in-house
  handoff: none — superseded by FS129-SR3-QFREE-NS (FS129-Z1, 2026-10-03; the same statement with "simple" dropped: SR3 § 2.2, inventory items 125, 128), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — the statement and its not claimed, over FS116-Y4-EMPTY (FS-116's module) and FS129-OR1-BENDFRAG"

**Superseded** by FS129-SR3-QFREE-NS, the same statement with "simple" dropped, on FS116-V6's route (SR3 § 2.2); its not-claimed "the Siamese or non-simple classes" narrows to the Siamese class (inventory item 130). Rests on it, as filed: FS-123's question 1, answered yes (J1, inventory item 54); `CLAUDE.md` item 31's open case "(Q)-free rings with (R2) arcs", closed in the non-Siamese simple class (inventory item 57, for FS129-Z2 to score); in OR1's § J3, NO-SAT's case 2 (SAT-QFREE) and case 1's G3, closed in the non-Siamese simple class; FS116-Y4-EMPTY's not-claimed line, whose erratum this job files. Pass 3's attack on its two named steps did not succeed (`plans/FS129-SR1-audit.md` § 2.1; a checking reading, not a second mind). Whether a blind second mind runs is Kooshi's call (inventory item 56); the default files it derived, one mind. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-OR1-BENDFRAG
  statement: let F be a valid six-coloured fragment on a closed disc B̄(p, r), r > 1, about a vertex p of at least four colours, and let
    1 < ρ′ < min(r, √3); then there is a valid six-coloured fragment F″ on B̄(p, ρ′) in which p is a vertex whose tiles at p have the colours
    they have in F, whose arcs of Γ on ω(p) are F's (Q) arcs on ω(p) and no others, so that Γ ∩ ω(p) in F″ is those arcs and finitely many
    points; F″ is non-Siamese if F is, and simple if F is
  uses only: FS129-OR1-WHOLE at ρ = min(r, √3); FS112-N2-BENDS through its proof's two operations — N2-TOWARD (outer colour absent at the centre
    ⟹ the whole arc, ends included, bends toward it, validly, creating no unit arc) and N2-AWAY (inner colour absent at the centre and no
    inner-colour tile touching R₂(ᾱ) ⟹ the whole arc bends away) — read on a fragment; the definition of (Q) (its centre carries both side
    colours and at least four colours); FS116-V4-DICHOTOMY (for non-Siamese after each bend)
  not claimed: anything at radius √3 or more, where an (R2) arc's witness can be seen and FS112-N2-RED's (R2) arcs survive (side 2, about maps);
    that F″ keeps any saturation F has; anything about the rings of other vertices (bending p's ring and a ring point's ring together is not
    claimed: their witnesses see each other); that F″ agrees with F off thin lenses along the bent arcs (true by construction, not part of the
    statement)
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-BENDFRAG
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS
  minds: 1
  model: the capped strip about P_j on B̄(P_j, 1.8) with ρ′ = 1.7 — its four ring arcs are (Q), so F″ is F_√3 with nothing bent; no held
    fragment has a non-(Q) arc on the ring of a vertex of at least four colours (`plans/STUB-qfree-ring.md` § Construction targets), so the bend
    clause has no held fragment as a model, only FS112-N2-RED's maps
  prior art: owed — in-house; FS-112's bends are "not found in print" (FS112-N2-RED's entry)
  handoff: none — superseded by FS129-SR1-BENDANY (FS129-Z1, 2026-10-03; SR1 § 6.2 item 5), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — the statement and its not claimed, over FS112-N2-BENDS as an imported hypothesis until FS-112's module lands"

**Superseded** by FS129-SR1-BENDANY (its case at k = 6 and a vertex of at least four colours; BENDANY's prose). FS129-OR1-QFREE-CLASS was written over this entry and reads the same step from BENDANY. *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-OR1-BEND3
  statement: let F be a non-Siamese simple valid six-coloured fragment on a closed disc B̄(q, r), r > 1, about a vertex q of exactly three colours, and
    1 < ρ′ < min(r, √3); then there is a non-Siamese simple valid six-coloured fragment on B̄(q, ρ′) in which q is a vertex whose tiles at q have the
    colours they have in F, whose ring carries no arc of Γ, and whose tiles include every tile of F meeting B(q, min(r, √3)) other than the side tiles
    of arcs of Γ on ω(q), which it modifies only inside thin lenses along those arcs
  uses only: FS129-OR1-WHOLE; FS112-N2-BENDS (N2-TOWARD, N2-AWAY) read on a fragment, as in FS129-OR1-BENDFRAG's argument; FS116-V5-U1 (at the centre of
    an arc of Γ the inner colour's sectors lie in the facing cone, the outer colour's in the away cone, neither in the two open side cones); that a
    non-Siamese simple fragment has no repeated colour at a vertex (two tiles of one colour at q are near, by FS116-V4-DICHOTOMY; one tile twice at q
    has a closure that meets itself)
  not claimed: that the bends can be pinned at chosen points of ω(q) keeping the germs there of circles that cross ω(q) (J2 needs it; not derived);
    anything at radius √3 or more; anything in the Siamese or non-simple classes; anything about vertices of four or more colours (FS129-OR1-BENDFRAG)
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-BEND3
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS, FS116-V5-U1
  minds: 1
  model: any cubic trichromatic vertex u of the capped strip (FS114-Y-DIAL) whose closed unit disc lies at distance above 1 from the strip's edge, on
    B̄(u, 1.1): a non-Siamese valid fragment about a vertex of three colours (`plans/FS112-NB3-verification.md` § 1.4's killing test 8 reads the strip's
    trichromatic vertices); its ring's arcs of Γ, if any, are bent
  prior art: owed — in-house
  handoff: none — superseded by FS129-SR1-BENDANY with FS129-SR1-BENDLE3 (FS129-Z1, 2026-10-03; SR1 § 6.2 item 5), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "de Bruijn — with FS129-OR1-BENDFRAG (one module: the bends on a whole-tile fragment below √3)"

**Superseded** by FS129-SR1-BENDANY with FS129-SR1-BENDLE3. Its tile clause is BENDANY's, not BENDLE3's (BENDLE3's note). *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff.

derivation: FS129-OA1-RINGWIND
  statement: let c colour the circle by three colours, defined and locally constant off a finite set Σ of change points, with c(θ) ≠ c(θ + 60°)
    wherever both are defined; for θ with no point θ + 60°j in Σ let W(θ) = (1/3) Σ_{j=0..5} d(c(θ + 60°j), c(θ + 60°(j+1))), where d(x, y) is +1
    if y = x + 1 and −1 if y = x − 1 (mod 3); then W takes values in {−2, 0, 2}, has period 60°, and changes across θ₀ only if Σ contains two
    points θ₀ + 60°j and θ₀ + 60°(j+1) for some j; so its jumps over one period sum to zero, and a hexagon position that is the only one with two
    change points 60° apart carries no jump
  uses only: properness at 60°; that a single hexagon vertex changing from colour x to colour y forces both its hexagon neighbours to the third
    colour z, and z → x → z, z → y → z both contribute 0; that changes at non-adjacent hexagon vertices are read against unchanged neighbours;
    periodicity of W; that six steps of ±1 summing to 0 mod 3 sum to −6, 0 or 6
  not claimed: that W is constant (two change points 60° apart can move it by ±2 — the swap of row 132 and G71); anything about the parts of the
    ring outside the fragment (at radius below 2 about p, part of ω(y) is unread); that SEMI-PAR3 holds or fails
  argument: FS129-OA1-audit.md § 3.1 J2 — FS-124 case 1, SEMI-PAR3
  verdict: derived
  grade: hand
  minds: 1
  model: the colouring c(θ) = ⌊θ/60°⌋ mod 3 (six 60° arcs coloured 0, 1, 2, 0, 1, 2): Σ = six points, every hexagon position has all six
    vertices changing at once, W = 2 on both sides of each — the jumps are zero, as the sum rule requires
  prior art: partly: in-house — FS110-N2-RING (the band) and FS110-Y3-GP (the count n₂), two minds each: W here is Y3-GP's invariant read
    position by position, W = (6 − 2n₂)/3 (`plans/FS129-SR1-audit.md` § Stage 3, group 7; inventory item 100); and G71 (Chandgotia's height
    functions for three-colourings) and row 132's index of density traces, both "fail only at a swap"; the ring-hexagon form outside the
    house not searched (owed)
  handoff: none — superseded by FS129-SR1-RINGBAND (FS129-Z1, 2026-10-03; SR1 § 6.2 item 8; neither crosses unless one of the family is formalized), which de Bruijn formalizes once in its place; the
    reader's handoff, verbatim: "none — a relay-result handed to FS-124's opening and to lane R (FS129-OR1) for J2; it enters no proof here"

control: FS129-OA1-RINGWIND-ALL
  of: FS129-OA1-RINGWIND — every proper three-colouring of the 12-cell discretised ring (first cell fixed) obeys the jump rule
  run: python3 ../tools/fs129_oa1_ringwind.py | tail -1
  expect: violations: 0
  fault: python3 ../tools/fs129_oa1_ringwind.py --fault | tail -1

**Superseded** by FS129-SR1-RINGBAND ((i) with (iii); its periodicity clauses follow from h's definition, RINGBAND's note). **Changed by the record job** (inventory item 100): `prior art:` names the in-house prior forms; as OA1 filed it, it read "partly: G71 (Chandgotia's height functions for three-colourings) and row 132's index of density traces, both \"fail only at a swap\"; the ring-hexagon form not searched (owed)". *Fields this job changed:* `handoff:` marks the supersession and quotes the reader's handoff; `prior art:` names the in-house prior forms FS110-N2-RING and FS110-Y3-GP (inventory item 100).
