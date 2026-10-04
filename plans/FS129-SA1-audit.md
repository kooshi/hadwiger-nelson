# FS129-SA1 — pass 3 of the cross-application audit, lane A (the arithmetic era): merges, strengthening, vacuity, and the records that disagree

*Job FS129-SA1, brief `data/fs129/briefs/FS129-SA1-pass3.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 4. Writes only this file, `data/fs129/sa1/`, `tools/fs129_sa1_*.py` and
`data/fs129/reports/FS129-SA1.md`. Started 2026-10-03. A successor continues from the last SAVED stage.*

## Theorems this phase proved

*(filled at the last stage)*

## Stage 1 — SAVED (readback, registered expectations, the plan of stages)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script, `data/fs129/sa1/readback.py` (exact substring, then whitespace normalised), 2026-10-03; with `--fault` (a word appended to
every quotation) it reports 4 of 4 missing, so it reads the claim.

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "**Kooshi's reading** (2026-10-03, verbatim): "Oh... oh I see. … This is another reason for workflow 3.1 and the lean backlog."" | `plans/FS129-close-inventory.md` § Items (item 32) | verbatim, whitespace normalised (the source wraps the line) |

The brief's item references check against `plans/FS129-close-inventory.md`: items 13 (three conditional seeds), 20 (X25B-PZ, X25B-LP, the 68
ids), 33–37 (the vacuity sort and its fourth heading, the borderline list), 67 (FALC-RED reordered as Falconer p. 188), 68 and 88 (the merges),
69 (ASTRA-2026-09-14-T10), 77 (the 24 "nothing" edges), 89 (FS89-CL2). **No mismatch; no finding about the brief.**

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow; `plans/STANDING-RULES.md`; the plan; `plans/FS129-close-inventory.md` in full. **Not yet
read:** the index files, passes 1 and 2's records, any derivation file, any grokking body.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

| # | expectation | registered |
|---|---|---|
| SA1-E1 | merges in the Falconer–slack family that earn an entry (a merged statement de Bruijn formalizes in place of two or more) | 3 (NOAFF5 at every k; FALC-T with DICHO and GAP4; the G63 rider to F(t₁, …, t_n)) |
| SA1-E2 | merge lines in total (entry or line), the whole job | 10 |
| SA1-E3 | hypotheses weakened, with the weaker form derived | 2 |
| SA1-E4 | lane-A flagged results sorted **empty** (vacuous as stated) | 2 (ASTRA-T10 over residue-𝔽₁₁ fields among them, if its statement is read as a class) |
| SA1-E5 | disagreeing records found and reconciled (beyond FS89-CL2 and ASTRA-T10, which the brief names) | 2 |
| SA1-E6 | of the 68 ids in item 20, theorems the record has lost (not duplicates, not non-theorems) | 5 |
| SA1-E7 | of item 77's 24 edges, lane A's share; and of those, false | 6 lane A; half false |
| SA1-E8 | P(pass 3 finds a held result false, beyond FS89-CL2, which is already known) | 0.12 |
| SA1-E9 | P(an attack on a one-mind composition of passes 1–2 in lane A succeeds) | 0.10 |

### 1.4 The plan of stages (each saved and committed before the next)

1. This stage.
2. **(a) the Falconer-fan and slack-plane family, merged** — read the ten entries and their sources (row 66, G9, G63, M60-T2, M61-T5,
   FS86-Cx-C11); merged entries `FS129-SA1-<NAME>` in the block format, gated.
3. **(b) the records that disagree** — FS89-CL2 and what downstream inherits; ASTRA-2026-09-14-T10 (also a vacuity case).
4. **(c) X25B-PZ, X25B-LP and the 68 ids; (d) the lane-A "nothing" edges** of item 77.
5. **The vacuity sort** — lane A's flagged results (`data/fs129/index/vacuity.md`), the borderline list, and **(e)** the older record's
   hubs, roots and Lean-order entries read for vacuity; the rest listed unsorted.
6. **The Lean order, lane A's part, swept**; the FS129-L1 list; "Theorems this phase proved"; the report.

## Stage 2 — SAVED (item (a): the Falconer-fan and slack-plane family, merged)

*Read for this stage: the ten entries in their records (`plans/FS129-OA1-audit.md` §§ 2.2–2.3; `plans/FS129-MA1-audit.md` §§ 2–3.1;
`plans/FS129-MA2-audit.md` §§ 2–4); `LEDGER.md` row 66; M60-T2 (`plans/M60-derivation.md` line 28) and M60's per-class table
(`plans/M60-five-colour-residue-obstruction.md` line 161); M61-T5 (`plans/M61-derivation.md` line 98); FS86-Cx-C11 (`plans/FS86-derivation.md`
line 227); the bodies of G9, G13, G63, G75; `Proofs/HadwigerNelson/FanGap.lean` (`FanGap`, `Slack`, `not_fan_of_fanGap`,
`Slack.forces_iff_of_hom`), `Fan.lean` (`Fan`), `Instances/FanGap19.lean`'s docstring, `Instances/PlaneFreedom.lean` (`circ7Table`),
`Transcendental.lean` (`mem_valuationSubring_of_sq_add_sq_eq_one`, `unitQuadrance_colorable_of_subring`); `plans/FS103-M-derivation.md` D2
(line 252).*

### 2.1 Recognition: what the family is

Every entry in the family but two is **one move — the single-vertex repaint along a homomorphism into a target with a gap (row 66) —
applied to one of two finite objects**: a separable function of the colours constant on all proper colourings (NOLIN5, NOAFF5, MA2's
k = 4 note, row 66's `Slack.forces_iff` as its two-vertex case), or a Falconer fan (FALC-T, FALC-11, FALC-19, DICHO, GAP4, HOSTS (i)).
The five colours enter only as the number of colours, so each statement holds at every `k`; and the field enters only through a
homomorphism into a target, so G63's place `t ↦ 0`, composed with the residue map, carries every field statement to `F(t₁, …, t_n)` at no
cost. The two that are not this move are **FALC-RED** (measure theory: Falconer's Lemmas 1–4) and **NOPERLAW** (stationary CP colourings:
a closed subgroup argument); they stay as stated, FALC-RED with its argument reordered (item 67).

Under that description the family is **seven statements** (§ 2.3): two abstract lemmas at every `k` (NOAFF-K, FALC-FAN), one corollary
(DICHO-K), the place lemma (PLACE-HOM), two field corollaries over `F(t₁, …, t_n)` (NOAFF-FIELDS, FALC-RES), and FALC-RED re-argued.
NOAFF-K is stated in the termwise form — a sum `Σ_v φ_v(C(v))` of one function of each vertex's colour — which contains the simplex form
(an affine functional `⟨a_v, f(i)⟩` is such a `φ_v`, constant only when `a_v = 0`, since the simplex's edge vectors span) and the indicator
form (where the conclusion is "`a_v` a multiple of the all-ones vector", not `a_v = 0`; MA1's prose "(or indicator)" in § 3.1 item 1 is
loose on this point, its entry statement is not), and needs no Euclidean geometry in Lean. It is also stated **locally**: `φ_u` is
constant at every `u` whose image is gapped in some colouring — the strength of row 66's `not_forces_of_fanGap`, which has no slackness
premise.

### 2.2 The merge map (the brief's item (a), clause by clause)

| held statement | merged home | how |
|---|---|---|
| FS129-OA1-NOLIN5 (scalar `c_v`, residue-𝔽₁₁ prime) | FS129-SA1-NOAFF-K, FS129-SA1-NOAFF-FIELDS | `Σ c_v f_C(v) = w` is `k − 1` termwise identities `φ_v = c_v ⟨e_i, f(·)⟩`; constant `φ_v` forces `c_v = 0`. NOAFF-FIELDS at `k = 5`, `n = 0`, 𝔽₁₁ |
| FS129-MA1-NOAFF5 (vector `a_v`, any target slack at five) | FS129-SA1-NOAFF-K at `k = 5` | `φ_v = ⟨a_v, f(·)⟩`; the slackness hypothesis weakened to a gap at `ρ(u)` alone, for the clause at `u` |
| MA2's "NOAFF5's argument at every `k`" (k = 4: Γ₇, three-colourable targets; § 2.3, not entered) | FS129-SA1-NOAFF-K, FS129-SA1-NOAFF-FIELDS at `k = 4` | entered now: G75's four-colour annihilator format is empty over every field with a usable 𝔽₇ prime or `χ(F²) ≤ 3` — ℚ(√11), a four-chromatic plane (row 73), among them |
| row 66's `Slack.forces_iff_of_hom` (→) | FS129-SA1-NOAFF-K, two-vertex case | `Forces G k u u'` is the termwise identity `φ_u = [· = i]`, `φ_{u′} = −[· = i]`; NOAFF-K makes `φ_u` constant, false for `k ≥ 2`, unless `u = u′`. Already kernel; NOAFF-K is formalized beside it |
| FS129-MA1-FALC-T (1) | FS129-SA1-FALC-FAN (A) at `k = 5` | verbatim content, at every `k ≥ 3` |
| FS129-MA1-FALC-T (2) | FS129-SA1-FALC-FAN (B), first half | a `(k − 1)`-colouring read as a `k`-colouring with the `k`-th colour absent everywhere |
| FS129-MA1-FALC-T (3) | FS129-SA1-FALC-FAN (B), second half, for a `(k − 2)`-colourable `T` | a `(k − 2)`-colouring, read as a `(k − 1)`-colouring, is gapped everywhere (MA2's "GAP4's three-colourable case") |
| FS129-MA2-FALC-GAP4 | FS129-SA1-FALC-FAN (B), second half, at `k = 5` | same statement at every `k` |
| FS129-MA2-FALC-DICHO | FS129-SA1-FALC-DICHO-K at `k = 5` | `T = K_{χ(H)}` and `T = H` in FALC-FAN (B) (MA2: "clause (2) with `T = H` is DICHO") |
| FS129-OA1-FALC-11, FS129-MA1-FALC-19 | FS129-SA1-FALC-RES (ii) | FALC-FAN (A) at Γ₁₁ and Γ₁₉ plus the two orbit facts (controls re-run below), over `F(t₁, …, t_n)` |
| FS129-MA2-FALC-HOSTS (i) | FS129-SA1-FALC-RES (i) | sharpened: "no usable 𝔽₃ prime, no dyadic place ramified in F(i)" is replaced by its cause, `χ(F²) ≥ 4` (DICHO-K's `χ(H) ≥ 4` with `χ(E²) = χ(F²)`, row 104); the 𝔽₃ and dyadic clauses are instances (row 52: `χ ≤ χ(Γ₃) = 3`; G35: `χ ≤ 2`); 𝔽₇ stays a clause of its own (Γ₇ is four-chromatic and gapped) |
| FS129-MA2-FALC-HOSTS (ii)–(iv) | unchanged | re-pointed: they use FALC-FAN (B) and DICHO-K in place of GAP4 and DICHO |
| G63's place `t ↦ 0` (MA2's rider, not entered) | FS129-SA1-PLACE-HOM | entered: one subring `V ⊆ F(t₁, …, t_n)` holding every unit vector's coordinates and a ring map `V → 𝔽_q`; each field statement above is stated over `F(t₁, …, t_n)` through it |
| FS129-OA1-FALC-RED | FS129-SA1-FALC-RED | statement verbatim; `uses only:` and argument reordered as Falconer p. 188 (item 67) |
| FS129-OA1-NOPERLAW | unchanged | no overlap: a closed-subgroup argument on stationary colourings; handoff none, as filed |

**Three of the brief's named merges do not hold as merges** (said so per the brief's "how to read a disagreement"; each is a correction
of a pass-2 line, not of a held statement):

1. **M60-T2 is not subsumed by row 66.** M60-T2 ("Over any field with a usable prime `p ≥ 5` whose residue plane is 5-colourable and
   pairwise free at five colours (`F_p(5) = \{0\}`, `S_p(5) = N₁`): **no finite unit-distance graph separates a `√3`-pair or a
   distance-2 pair at five colours, and none forces either pair equal**", `plans/M60-derivation.md` line 30) rests on a **congruence
   transfer law** — pull back every colouring of Γ_p, so a forced pair has `d² ≡ 0` and a virtual edge `d² ≡ 1 (mod 𝔭)` — under a
   hypothesis about Γ_p alone. Row 66 rests on a **repaint** under a different hypothesis (`Slack`, `PairwiseFusable`) and concludes more
   (`Forces ↔ =`, `Separated ↔ Adj`). Where both apply (p = 3, 7: fewer colours leave a colour absent everywhere; p = 11: the kernel's two
   tables) row 66's conclusion contains M60-T2's. **At p = 19 the virtual-edge half is not row 66's**: row 66 states only the forces half
   there ("The virtual-edge half (`Separated ↔ Adj`) is NOT stated at `19`", `Instances/FanGap19.lean` line 18), while M60's per-class
   table holds `S₁₉(5) = N₁` at tools grade ("every non-unit class IDENTIFIED by some verified 5-colouring — **`S₁₉(5) = N₁`, P4 MET**",
   `plans/M60-five-colour-residue-obstruction.md` line 161). That half has content: ℚ(√6) has a usable prime of residue field 𝔽₁₉
   (`6 ≡ 5²`, `19 ≡ 3 (mod 4)`) and points at distance √3 (`(√6/2, √6/2)`). **So M60-T2 at 19's virtual-edge half stays M60-T2's**, and
   M60-T2 beyond p ∈ {3, 7, 11, 19} rests on an unverified hypothesis, as its own verdict says. For the Lean backlog: M60-T2's general-p
   form was declined; its 19 virtual-edge instance is a tools result (a per-class SAT table), which the kernel would take as 18 decided
   colourings of Γ₁₉ — not in the Lean order, so a line, not an entry.
2. **M61-T5 is not subsumed by row 66.** M61-T5 is the tightness mechanism at every `k` ("Over a field `F` sealed at `k` by a usable prime
   `𝔭` … a pair forced equal at `k` colours has `𝔭 | d²` …; its spindle adjoins `√(4d² − 1)` …", `plans/M61-derivation.md` line 98), with
   instances where row 66 does not apply — the Moser spindle at three colours over ℚ(√3) (Γ₃ is not slack at three: the rhombus forces its
   √3 pair there), K's four-colour forced pairs at four. Row 66 answers only M61-T5's **six-level consequence** ("does any 5-sealed field
   carry a pair forced equal at five colours?") with "no" over residue-𝔽₁₁ fields — which M61-T5's own *Rests on it* already says ("row
   66's later, stronger closure … this entry is the mechanism itself, row 66 the theorem that the six-level design target built on it never
   fires"). The records agree; MA1's "subsumed" line overstates it.
3. **FS86-Cx-C11 is not NOAFF5's four-colour face as a merge.** C11 ("On the field plane, `F(R) ≠ 0` iff the zero set of the whole
   annihilator ideal … is a finite set of torsion characters; "some annihilator exists ⟹ `F(R) ≠ 0`" is not claimed",
   `plans/FS86-derivation.md` line 227) is spectral synthesis on a type-(B) plane; NOAFF-K is a repaint. They meet consistently: over a field
   with a slack residue target at four (usable 𝔽₇ prime, or `χ(F²) ≤ 3`) NOAFF-FIELDS makes the four-colour annihilator ideal of every
   finite configuration zero — and the plane's, since NOAFF-K takes any graph `G` with finitely supported `φ` — so `F(R) = 0` and the zero set
   is the whole character torus, C11's "not finite torsion" side, in its strongest form. Type-(B) planes have no such target (else
   `F(R) = 0` would be immediate), so the two statements live on disjoint field classes. A consistency line for G75, not a merge; C11 is
   kernel-declined in any case.

And one is a line, not a merge: **G9 and DICHO**. G9 is a [measured] reading ("hunt compulsions one rung below the top — a core asked at
χ−1 colours — and expect the top rung empty"); DICHO-K is a proof that a fan at `k` in a `(k − 1)`-chromatic host is a forced pair at
`k − 1`, one rung below. DICHO-K is a proved instance of G9's *Do*; drafted as a grokking instance in § 2.5, nothing to formalize twice.

### 2.3 The entries

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
  argument: § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, G the Moser spindle without its tip edge (three-colourable), ρ into the triangle of Γ₃ (the line 𝔽₃ × 0), a target slack at
    four: the indicator vectors of G's proper four-colourings span an affine space of dimension 21 of 21 (control FS129-SA1-NOAFF4); at
    k = 5 the same graph into Γ₁₁, 28 of 28 (FS129-MA1-NOAFF5-DIM); K₄ at four colours receives no gapped target, satisfies
    Σ_v f(C(v)) = 0, and has dimension 9 of 12 (the control's fault)
  prior art: partly: `[BrewsterEtAl2020]` (a gapped vertex is a non-frozen vertex, row 66's prior-art line); the termwise affine-hull form not
    searched — owed to FS129-Z1's prior-art gate
  handoff: de Bruijn — formalize in place of FS129-OA1-NOLIN5, FS129-MA1-NOAFF5 and MA2's k = 4 note: a lemma beside
    `Slack.forces_iff_of_hom` (`FanGap.lean`), for `f : G →g P`, `φ : V →₀ (Fin k → ℝ)` and a `FanGap C (f u) γ`, concluding `φ u` constant;
    the slack corollary by `Slack`; `Slack.forces_iff_of_hom`'s forward direction is its two-vertex case

control: FS129-SA1-NOAFF4
  of: FS129-SA1-NOAFF-K — the model at k = 4: a three-colourable graph, mapped into a target slack at four, has proper four-colourings of full affine dimension
  run: python3 ../tools/fs129_sa1_family.py noaff4 | tail -1
  expect: k=4: dim 21 of 21
  fault: python3 ../tools/fs129_sa1_family.py noaff4 --fault-k4 | tail -1

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
  argument: § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: F = ℚ(√3), 𝔭 a prime above 11 (11 splits: 3 ≡ 5² mod 11, and 11 ≡ 3 mod 4), n = 1, t₁ = π: E = ℚ(√3, π), V = {x ∈ ℚ(√3)[π]_{(π)} :
    x(0) ∈ 𝒪_{ℚ(√3),𝔭}}, φ(x) = x(0) mod 𝔭
  prior art: partly: `[Fischer1990]` Theorem 6's proof (a unit vector over F[x] without common factor, set x = 0 — G63) and row 52's residue
    map; the composite as one homomorphism into Γ_q not searched — owed to FS129-Z1
  handoff: de Bruijn — the homomorphism behind `unitQuadrance_colorable_of_valuationSubring` (`Transcendental.lean`, via
    `cosetResidue`), iterated n times and composed with the residue map at 𝔭; every field statement of this family is formalized through it

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
  argument: § 2.4 The arguments
  verdict: derived
  grade: derived from: FS129-SA1-NOAFF-K, FS129-SA1-PLACE-HOM
  minds: 1
  model: k = 4, F = ℚ(√11) (11 ≡ 2² mod 7, so 7 splits into primes of residue field 𝔽₇; χ(ℚ(√11)²) = 4, row 73): G75's four-colour
    annihilator format has nothing to find on any finite configuration over ℚ(√11)(t₁, …, t_n); k = 5, F = ℚ(√3) with H the spindle
    without its tip edge (FS129-MA1-NOAFF5-DIM)
  prior art: owed — in-house inputs (row 66, row 104, G63); for FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-OA1-NOLIN5's and FS129-MA1-NOAFF5's field readings: NOAFF-K composed with PLACE-HOM and the
    three kernel slack facts

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
  argument: § 2.4 The arguments
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

derivation: FS129-SA1-FALC-DICHO-K
  statement: let k ≥ 3 and let H, a, t be a Falconer fan at k colours as in FS129-SA1-FALC-FAN; then χ(H) ≥ k − 1, and if χ(H) = k − 1,
    every proper (k − 1)-colouring of H gives a and t one colour
  uses only: FS129-SA1-FALC-FAN (B) with T = K_m and ρ a proper m-colouring of H for m = χ(H) ≤ k − 2 (K_m's proper (k − 1)-colouring leaves
    colour k − 1 absent everywhere, against (B)); and with T = H, ρ the identity
  not claimed: that any fan at five colours exists; the converse — a pair forced equal at k − 1 colours need not be a fan at k (Harder's
    745-point graph forces its pair at distance 8/3 at four colours over K and is no fan at five with that apex and tip, since 8/3 is a unit
    at K's primes of residue field 𝔽₁₁, FS129-SA1-FALC-RES); anything about a fan with χ(H) ≥ k beyond the bound
  argument: § 2.4 The arguments
  verdict: derived
  grade: derived from: FS129-SA1-FALC-FAN
  minds: 1
  model: k = 4, the unit rhombus: χ = 3 and every proper three-colouring gives a and t one colour (row 58; control FS129-SA1-FAN4)
  prior art: owed — G9's measured reading ("compulsions one rung below the top") is the mechanism's informal form; for FS129-Z1
  handoff: de Bruijn — formalize in place of FS129-MA2-FALC-DICHO: two lines over FS129-SA1-FALC-FAN's lemma, `Fan H′ k t [a₁, a₂]` with
    `H.Colorable (k − 1)` giving `Forces H (k − 1) a t`

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
  argument: § 2.4 The arguments
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
  argument: § 2.4 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, H the unit rhombus with tip √3 — the angle condition is Falconer's own ((5 + i√11)^m ≠ 6^m), and the statement is his Theorem 2
    at n = 2, χ_m(ℝ²) ≥ 5
  prior art: partly: `[Falconer1981]` Theorem 2's proof, which uses the spindle's rhombus; the form with a general Falconer fan owed to FS129-Z1
  handoff: de Bruijn — formalize FS129-OA1-FALC-RED's statement from this entry's argument, behind the measurable chain (FS-113), importing
    `[Falconer1981]` Lemma 1 in the paper's form only (the motion is the lemma's), Lemmas 2–4 as `plans/FS129-MA1-audit.md` § 2.1 transcribes them

### 2.4 The arguments

*FS129-SA1-NOAFF-K.* Fix `u` with a gap: a proper `k`-colouring `C` of `T` and `γ` absent from `N_T[ρ(u)]`; put `β = C(ρ(u)) ≠ γ`. For a
permutation `π` of the colours, `π∘C` is proper with `π(γ)` absent from `N_T[ρ(u)]`. So `π∘C∘ρ` is a proper `k`-colouring of `G` (`ρ` is a
homomorphism), and so is its repaint at `u` alone with `π(γ)` (every neighbour of `u` maps into `N_T(ρ(u))`, whose colours miss `π(γ)`). The
sum takes the value `b` on both; they differ only at `u`; so `φ_u(π(β)) = φ_u(π(γ))`. As `π` varies, `(π(β), π(γ))` is every ordered pair of
distinct colours: `φ_u` is constant. If every vertex of `T` has a gap, every `φ_v` is constant, `φ_v ≡ c_v`, and evaluating at `C∘ρ` gives
`b = Σ_v c_v` (a finite sum). ∎ *The simplex form:* `φ_v(i) = ⟨a_v, f(i)⟩` constant means `a_v` is orthogonal to every edge vector of the
regular `(k − 1)`-simplex, which span `ℝ^{k−1}`, so `a_v = 0` (FS129-MA1-NOAFF5's conclusion); with scalar coefficients, FS129-OA1-NOLIN5's.

*FS129-SA1-PLACE-HOM.* `n = 0`: if `(u, v)` is a unit vector of `F` with `u ∉ 𝒪_{F,𝔭}`, then `v ∉ 𝒪_{F,𝔭}` with the same valuation and
`1 + (v/u)² = u⁻²` lies in the maximal ideal, so `−1` is a square in `𝔽_q` — false for `q ≡ 3 (mod 4)` (the kernel's valuation lemma).
`n ≥ 1`: on `E_n = E_{n−1}(t_n)` the place `t_n ↦ 0` has residue field `E_{n−1} ⊂ ℝ`, with no square root of `−1`, so the same lemma puts every
unit vector's coordinates in its valuation ring `O`; evaluation at `t_n = 0` is a ring map `O → E_{n−1}` taking a unit vector to a unit vector,
whose coordinates lie in `V_{n−1}` by induction. So `V_n = ev⁻¹(V_{n−1}) ∩ O` holds every unit vector's coordinates, `φ_n = φ_{n−1} ∘ ev` is a
ring map, and constants `c ∈ F` satisfy `ev(c) = c`, so `φ_n` restricts to `φ_0` on `𝒪_{F,𝔭}`. Each edge `x — x + e` of the plane has `e ∈ V²`,
so stays in one coset of `V²`; on the coset `x₀ + V²` put `x ↦ φ(x − x₀)`: an edge goes to `φ(x − x₀)` and `φ(x − x₀) + φ(e)`, with `φ(e)` of
quadrance `φ(e₁)² + φ(e₂)² = φ(1) = 1`, an edge of Γ_q. ∎

*FS129-SA1-NOAFF-FIELDS.* By PLACE-HOM `H` maps into `Γ₁₁`, `Γ₁₉` or `Γ₇`, each slack at the stated `k` (kernel), or, when `χ(F²) ≤ k − 1`, into
`K_{k−1}` (`χ(E²) = χ(F²)`, row 104 iterated: each `E_j = E_{j−1}(t_j)` with `E_{j−1} ⊂ ℝ` formally real), which is slack at `k` (the `k`-th colour
is absent everywhere). NOAFF-K's slack clause finishes. ∎

*FS129-SA1-FALC-FAN.* (A) Colour `H − a` by `C∘ρ`. It is proper; `N(a)` maps into `N_T(ρ(a))`, which misses `C(ρ(a))` (properness) and `γ` (the gap;
also `γ ≠ C(ρ(a))`), so the colouring is admissible for the fan with `{c₁, c₂} = {C(ρ(a)), γ}`, and `C(ρ(t)) ∈ {C(ρ(a)), γ}`. If `γ′ ∉ {C(ρ(a)), γ}`
were absent from `N_T[ρ(t)]`, repaint `t` alone with `γ′`: still proper (`t ∉ N(a)`, and `t`'s neighbours map into `N_T(ρ(t))`), still admissible,
and `t`'s colour is outside the pair — against the fan. (B) Read a proper `(k − 1)`-colouring `C` of `T` as a `k`-colouring whose `k`-th colour is
absent everywhere, and take `γ` that colour in (A): `C(ρ(t)) ∈ {C(ρ(a)), γ}` and `C(ρ(t)) ≠ γ`, so `C(ρ(t)) = C(ρ(a))`. If one of the `k − 1`
colours, `γ′`, were absent from `N_T[ρ(t)]`, (A) puts `γ′ ∈ {C(ρ(a)), γ}`, so `γ′ = C(ρ(a)) = C(ρ(t))` — but `γ′` is absent from `N_T[ρ(t)] ∋ ρ(t)`. ∎
FALC-T (3) is (B) at a `(k − 2)`-colourable `T`: its `(k − 2)`-colouring, read with `k − 1` colours, leaves colour `k − 1` absent from `N_T[ρ(t)]`.

*FS129-SA1-FALC-DICHO-K.* If `m = χ(H) ≤ k − 2`, a proper `m`-colouring is a homomorphism `ρ : H → K_m`; `K_m` has a proper `(k − 1)`-colouring
leaving colour `k − 1` absent from every closed neighbourhood, against FALC-FAN (B). So `χ(H) ≥ k − 1`. If `χ(H) = k − 1`, FALC-FAN (B) with
`T = H` and `ρ` the identity says every proper `(k − 1)`-colouring of `H` gives `a` and `t` one colour. ∎

*FS129-SA1-FALC-RES.* (i) `χ(H) ≥ 4` (DICHO-K at `k = 5`) and `H ⊂ E²`, so `χ(F²) = χ(E²) ≥ 4` (row 104). If `F` had a usable prime of residue field
`𝔽₇`, PLACE-HOM gives `ρ : H → Γ₇`; Γ₇ is a Cayley graph and the kernel's colouring `circ7Table[y − 2x]` is a proper four-colouring with a gapped
vertex, so a translate of it is gapped at `ρ(t)`, against FALC-FAN (B). (ii) At a prime of residue field `𝔽_q`, `q ∈ {11, 19}`, compose PLACE-HOM's
map with the translation putting `ρ(a)` at `0`; then `ρ(t) = φ(t − a) =: w` (one coset, `H` connected). If `w ≠ 0`, the orbit fact gives a proper
five-colouring `C` of `Γ_q` with a gap `γ` at `0` and either `C(w) ∉ {C(0), γ}` — against FALC-FAN (A)'s first half — or a gap at `w` outside
`{C(0), γ}` — against its second half. So `w = 0`. ∎ *Instances of (i):* a usable prime of residue field `𝔽₃` gives `χ(F²) ≤ χ(Γ₃) = 3` (row 52);
a place above 2 ramified in `F(i)` gives `χ(F²) ≤ 2` (G35) — so HOSTS (i)'s two other clauses are (i)'s first half.

*FS129-SA1-FALC-RED* (the order of `[Falconer1981]` p. 188; statement as FS129-OA1-FALC-RED). Suppose `S₁, …, S_k` cover `ℝ²`, are measurable, and
none holds a unit pair; make them disjoint (`S_j ∖ ⋃_{i<j} S_i`; still unit-pair-free). No class is co-null (a co-null set holds a unit pair:
the pairs `(x, x + e)` with both ends in it have full measure), and some class has positive measure, so some class has positive measure and
positive co-measure, and Lemma 2(i) makes its metrical boundary non-empty and null; by the null-set sentence `E = ℝ² ∖ ⋃_j S̃_j` is the union of
the metrical boundaries, so `E` is non-empty, and null (each boundary is null by Lemma 2(i), a null class having empty boundary). **Lemma 1** with
`C = V(H)` and `x = a` gives a rigid motion `p` with `p(a) ∈ E` and, for almost every rotation `R` about `x₁ := p(a)`, `R(p(V(H))) ∩ E = {x₁}`. By D2,
`x₁` lies in at least two metrical boundaries, say `∂S₁ ∩ ∂S₂`. For such `R`, each other vertex `v` has `R(p(v)) ∉ E`, so `R(p(v)) ∈ S̃_{k(v)}` for one
`k(v)`. **Lemma 3** with `j = 1` and `j = 2` gives translations `τ₁`, `τ₂` with `τ_j(x₁) ∈ S_j` and `τ_j(R(p(v))) ∈ S_{k(v)}` for every other vertex.
No class holds a unit pair and translations keep distances, so `k` is a proper colouring of `H − a` and `N(a)` avoids colour 1 (by `τ₁`) and
colour 2 (by `τ₂`). The fan gives `k(t) ∈ {1, 2}`: `R(p(t)) ∈ S̃₁ ∪ S̃₂`. As `R` ranges over almost every rotation, `R(p(t))` ranges over almost
every point of the circle of radius `r` about `x₁` (rotational measure pushes forward to circular measure), so almost all of that circle lies in
`S̃₁ ∪ S̃₂`, and **Lemma 4** gives a unit pair in `S₁` or `S₂` — a contradiction. ∎ The one change from FS129-OA1-FALC-RED's argument: the point of
`E` is the one Lemma 1 supplies, never one chosen first.

### 2.5 Lines for the record job (not entries)

- **Grokking instance, G9** (for `plans/GROKKING-INSTANCES.md`, G9's section; source `plans/FS129-SA1-audit.md` § 2.2): "FS129-SA1-FALC-DICHO-K
  proves G9's *Do* for one object: a Falconer fan at `k` colours in a `(k − 1)`-chromatic host is a forced pair at `k − 1` colours — the compulsion
  sits one rung below the colour count the fan is posed at."
- **Consistency line, G75** (for G75's last sentence, FS129-Z1's draft): over a field with a usable prime of residue field `𝔽₇` or `χ(F²) ≤ 3`,
  the four-colour annihilator ideal of the plane is zero (FS129-SA1-NOAFF-FIELDS, any graph, finitely supported `φ`); FS86-Cx-C11 lives on
  type-(B) planes, which have no such prime.
- **Corrections of pass-2 lines**: `plans/FS129-close-inventory.md` item 68's "M60-T2 and M61-T5 are subsumed by row 66" — partly: M60-T2's
  virtual-edge half at 19 and M61-T5's mechanism at `k = 3, 4` are not row 66's (§ 2.2 items 1–2); "FS86-Cx-C11 is NOAFF5's four-colour face" — a
  consistency, on disjoint field classes (item 3).

## Stage 3 — SAVED (item (b): the records that disagree — FS89-CL2, ASTRA-2026-09-14-T10)

*Read for this stage: `plans/FS89-derivation.md` lines 25–30 (Notation), 42–103 (S0A-1 to S0A-13), 300–340 (D5-T2, CL1–CL5 and the correction
banner); `LEDGER.md` rows 95, 96; `plans/FS91-close-inventory.md` rows 61, 69, 75, 78; `plans/FS91-derivation.md` FS91-J03a-9 (line 123),
FS91-J07-12 to -14 (lines 352–362); `plans/FS91-S1D-character.md` § 4.4; `plans/FS91-S0F-three-colours.md` (how J02 used CL2);
`plans/ASTRA-2026-09-14-derivation.md` T10 (line 55); `data/fs129/index/edges.csv` and `roots.md` for both.*

### 3.1 FS89-CL2 — false as written in the record, corrected on the front page

**The two records, quoted.**
- `plans/FS89-derivation.md` line 27, the Notation: "`A`: archimedean characters `λ_e(x) = Re(ē x)`"; and FS89-CL2 (line 326): "For every
  subfield `F ⊆ ℝ`: `Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`; every four- or five-colour character colouring of any real field's plane is a
  torsion character plus an archimedean one". A banner above CL2 (line 324) says "**Correction owed (2026-09-25 crunch):** … Not applied here;
  the close rewrites this entry."
- `LEDGER.md` row 95: "`Θ₄(R_F) ⊆ T₁₆₈ + A`, `Θ₅(R_F) ⊆ T + A` for every `F ⊆ ℝ`, with `A = Hom_ℚ(F(i), ℝ) mod 1`, the archimedean characters of
  every place of `F(i)`; with one embedding's `λ_e` the clause is false, row 98".

**Which the argument supports: row 95's.** FS91-J03a-9's counterexample, re-checked here: over ℚ(√3), let `τ` be the additive three-colouring
(the residue map at the ramified prime above 3 into `𝔽₉ = 𝔽₃[i]`, then `a + bi ↦ (a + b)/3`, which is `1/3` or `2/3` on each of `±1, ±i`) and
`λ(x) = Re(ē σ₂(x))` with `σ₂` the embedding moving `√3`, `0 < |e| ≤ 1/12`. On a unit `u`, `|λ(u)| ≤ |e| ≤ 1/12`, so `(τ + λ)(u) ∈ [1/4, 3/4]`: it
is in `Θ₄(R_F)`. If `τ + λ = t + λ_f` with `t` torsion and `λ_f = Re(f̄ ·)` at the identity embedding, then `L = λ − λ_f` takes values in
`(1/N)ℤ` on `R_F`. On `ℤ[i][1/5] ⊂ R_F`, `σ₂` is the identity, so `L(w^n) = Re((ē − f̄) w^n)` with `w = (3 + 4i)/5`: bounded, and dense in an
interval unless `e = f` (w is not a root of unity) — so `e = f`; then `L(i√3 · w^n) = −2√3 Re(ē i w^n)` (`i√3 = 2ζ₆ − 1 ∈ R_F`), again bounded with
infinitely many values unless `e = 0`. So `τ + λ ∉ T + A` with the one-embedding `A`, and it is in `T + A` with `A = Hom_ℚ(F(i), ℝ) mod 1`.
The record's CL2, read with its own Notation, is **false**; with the wide `A` it is **true** (FS91-J07-14, two derivations).

**A finding the front page's correction did not name: the same Notation makes FS89-S0A-2 and FS89-S0A-10 false as written too.** S0A-2
("`Θ_k(ℤ[U_ℚ]) ⊆ T_N + A` ⟹ `Θ_k(R_F) ⊆ T_N + A` for every subfield `F ⊆ ℝ`, at every band", line 47) and S0A-10 ("`Θ_k(ℤ[U_ℚ]) ⊆ T + A`
⟺ `Θ_k(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ`, every band", line 91) state the field clause with the same `A`. Over `ℚ(i)` the two readings of
`A` agree, and RQ₄ holds there (FS89-D2-T1), so at `F = ℚ(√3)`, band 1/4, the left side is true and the right side, read with `λ_e`, is false by the
same counterexample. Their **arguments** carry the wide `A` — S0A-2's own words: "the lift `lim 5^k·(small rep of Nθ(x/5^k))` is one real
functional", a ℚ-linear functional on `F(i)`, which is `Hom_ℚ(F(i), ℝ)`, not `Re(ē ·)` — so the repair is the **Notation**, once, and it repairs
CL2, S0A-2 and S0A-10 together. FS-91's inventory row 61 names the Notation ("FS89-derivation "Notation": over R_F, A must be Hom_ℚ(F(i), ℝ) mod
1") but the record's banner sits only above CL2. **This matters for the Lean backlog**: S0A-2's `*Kernel:*` line reads "stub (a candidate for
FS-87's list: short, and the conduit from `Q` to every field)" — formalized from the Notation as written, it is unprovable.

**What downstream of CL2 inherits.** The index gives CL2 two out-edges (`FS89-CL2,FS89-CL3,rests`, `FS89-CL2,FS89-CL5,rests`; CL2's "*Rests on it:*
CL3–CL5; row 95's field clause" — the range hides CL4 from the parser). By their own grade lines CL3–CL5 are compositions of S0A-6, S0A-8, S0A-9
with D2-T1 or D5-T2, not of CL2; they use the field clause's *content* through those steps, and every one of them "reads **both** real places"
(`plans/FS91-S1D-character.md` § 4.4: "So the one-embedding misreading (J03a-9) sits only in FS89-CL2's wording, not in any step of CL3–CL5"),
with CL3, CL4, CL5 each TRUE under the wide `A` (FS91-J07-14, two derivations) and each re-proved through CLG with fewer inputs (FS91-J07-12, -13).
Row 95 is corrected; row 96 states no `A`. J02 (FS-91's three-colour job) cited CL2 only as "a second route, not needed and not claimed"
(`plans/FS91-S0F-three-colours.md` line 102). **So nothing downstream inherits the falsity**: the deepest lane-A root chain (`roots.md` rank 21,
FS89-S0B-C1 → … → FS89-D2-T1 → FS89-CL2 → FS89-CL3) is sound in content, with its last link a content edge (CL3 uses the field clause through
S0A-6, at the wide `A`), not a citation of CL2's wording. **Two index edges are false**: `FS91-J03a-9,FS89-CL2,rests` and `FS91-J07-14,FS89-CL2,rests`
— both correcting entries name CL2 in their *Rests on it* as the thing corrected, not as a user (item 77's kind; for FS129-Z1's index pass).

**Draft erratum for `plans/FS89-derivation.md`** (for FS129-Z1, the record job's pen; a dated entry under the Notation paragraph, the original
text left standing): "*Erratum (2026-10-03, FS129-SA1, from FS91-J03a-9 and FS91-J07-14; `plans/FS91-close-inventory.md` rows 61, 69, 78):* over
`R_F` with `F ≠ ℚ`, read `A` as `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, the archimedean characters of every place of `F(i)`; `λ_e(x) = Re(ē x)` at one
embedding is its case `F = ℚ`. With the one-embedding reading FS89-S0A-2, FS89-S0A-10 and FS89-CL2 are false (ℚ(√3), band 1/4:
`τ + Re(ē σ₂(·))`); with `A(R_F)` they hold, and every proof step in this file already reads every real place (FS91-J07-14)." And the CL2 banner
gains "and S0A-2, S0A-10 (the same Notation)".

### 3.2 ASTRA-2026-09-14-T10 — a hypothesis empty on part of its stated scope, and a sentence weaker than its hypothesis

**The statement** (`plans/ASTRA-2026-09-14-derivation.md` line 55): "For any real `F ⊇ K`: if some finite unit-distance graph over `F` has a
proper five-colouring in which two points at distance 2 are properly separated (`Separated` at distance 2, five colours), then transporting
an isometric copy of that graph onto each of the 892 length-2 edges of `[ExooIsmailescu2019]`'s 426-vertex `{1,2}`-graph … gives a
unit-distance graph over `F` needing at least six colours". **Its prose** (same line, *Rests on it*): "row 66 explains why, over a 5-sealed
field, though the `ρ₆₃` arena is 6-open — its emptiness stays measured, per G31".

**Two items, one of vacuity and one of wording.**
1. **Empty on part of the scope** (item 69). Over every `F ⊇ K` with a usable prime of residue field `𝔽₁₁`, row 66 gives `Separated G 5 u u' ↔
   G.Adj u u'` for every graph with a homomorphism into Γ₁₁ — the residue map is one — so a distance-2 pair is never a five-colour virtual edge,
   and the hypothesis has no member. The same holds over every `F` with `χ(F²) ≤ 4` (a four-colouring read with five colours leaves the fifth
   absent everywhere, so any non-adjacent pair can be repainted alike). K itself is in the first class (11 ramifies in ℚ(√11) and splits in
   ℚ(√3), `3 ≡ 5² mod 11`, residue field `𝔽₁₁`). The statement has content only over `F ⊇ K` with neither — `χ(F²) ≥ 5` and no usable
   `𝔽₁₁` prime: a 6-open field, K(√7) the first (`7` is a non-square mod 11, so its primes above 11 have residue field `𝔽₁₂₁`), where the
   hypothesis's membership is open and the one sweep run (FS-63's ρ₆₃ arena, all 1,306,721,748 pairs) found none.
2. **The sentence is weaker than the hypothesis it means.** "has a proper five-colouring in which two points at distance 2 are properly
   separated" reads as *there is a colouring* giving the two points different colours — true of almost every graph — while the parenthetical
   `Separated` and the proof ("forcing each replaced length-2 edge's endpoints to differ by the copy's own gadget property", applied to an
   arbitrary five-colouring of the assembly) use *every* proper five-colouring. Read as written, the statement is false (a gadget whose two
   points merely *can* differ forces nothing). The argument supports the universal reading.

**Draft correction** (for FS129-Z1; an erratum under T10, the original standing): "*Erratum (2026-10-03, FS129-SA1; `plans/FS129-close-inventory.md`
item 69):* read the hypothesis as "two points at distance 2 that receive different colours in every proper five-colouring of the graph
(`Separated` at distance 2, five colours)". The hypothesis is empty over every `F ⊇ K` with a usable prime of residue field `𝔽₁₁` (row 66,
`Separated ↔ Adj`) and over every `F` with `χ(F²) ≤ 4`; the sentence has content only over fields with `χ(F²) ≥ 5` and no such prime — K(√7) the
first."

**What rests on T10:** no entry by id (`data/fs129/index/edges.csv` has no edge from it; its *Rests on it* names row 43 and the H4 sweep, neither
a consumer). Its kernel line is a stub, "FS-49 — `six_le_chromaticNumber_plane_of_separated_two`, blocked on a kernel certificate of the
`{1,2}` graph itself", not in the Lean order. **For the Lean backlog**: if FS-49 is formalized, its hypothesis is `Separated` (every colouring), and
it is instantiated over no field with a usable `𝔽₁₁` prime — there it is vacuous by row 66, a theorem the kernel already holds.

### 3.3 The tally for item (b)

Records that disagree, reconciled: **FS89-CL2** against row 95 (row 95's reading supported; the Notation is the repair, and it covers S0A-2 and
S0A-10, which the front page's correction did not name); **ASTRA-T10**'s sentence against its own parenthetical and proof (the universal reading
supported), with its scope empty over residue-𝔽₁₁ fields as its own prose knows. No held result is newly false: both falsities are of wording,
and in each the argument carries a true statement that nothing downstream contradicts.
