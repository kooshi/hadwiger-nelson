# FS131-KFS1 — rational four-space at four colours (C7), and `χ_f` of the plane over ℚ(√3, √11) (C14): the map, the skeleton and the price

*de Bruijn, the planner (Opus), 2026-10-17. Brief: `data/fs131/briefs/FS131-KFS1-four-space.md` (on `main`, commit 24d9c671d).
Worktree `.claude/worktrees/il5`, branch `fs131-kfs1`, cut from `main` at `ac47c67b0`. Nothing in this milestone is fenced
(brief, `fences: none`); I read the derivations (LV, LX) in stage 1. Working files: `data/fs131/kfs1/`.*

## Theorems this phase proved

None. This is a planning job: every statement below is a skeleton with `sorry`, or a plan. Prices are "planned, one mind;
nothing held".

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

`data/fs131/kfs1/quote_check.py` takes every block quotation of the brief (a run of `>` lines closed by `— source: <path>`),
collapses whitespace and nested `>` prefixes on both sides, and requires the quote's text to occur in the source. Result
(`data/fs131/kfs1/quote_check.out`): **6 quotes, 6 FOUND, exit 0** — W2 (`data/fs131/REQUEST-2026-10-13.md`), item 1073
(`plans/FS131-close-inventory.md`), ranks 7 and 9 (`plans/POROS-2026-10-13-number-field-findings.md` § 3.3), the ℚ⁴ entry and
§ 1.6 (`CLOSED-QUESTIONS.md`). Planted control: one character changed in the first quote (`formalize` → `formalise`) reads
MISSING and exit 1 (`quote_check_plant.out`). The tool's first version missed the nested quote of § 1.6 (`> > …`); the miss was
the tool's, fixed by stripping repeated `>` prefixes, not a mismatch in the brief.

The brief's one unquoted claim checked by the kernel: `Collapse.fractionalChromaticNumber_planeOver_eq` rests on the standard three
and `Rigidity.positive_entropy_rigidity` (`#print axioms`, `data/fs131/kfs1/probes/AxiomsB.out`) — as the brief says.

**Mismatches: none in the brief.** Two observations about the sources, logged as findings below (1.4).

### 1.2 Part A, restated

Notation: read `ℚ⁴` as the rational quaternions `ℍ[ℚ]`, `N(x) = x₀² + x₁² + x₂² + x₃²`, so the squared Euclidean distance of
`x, y` is `N(x − y)`; `w(x) = v₂(N(x))`, the 2-adic valuation of the rational `N(x)`. A *proper four-colouring* is a map
`ℚ⁴ → {4 colours}` that differs on every pair at distance 1. A colouring *forbids* `d` if it differs on every pair at distance `d`.

- **A1, the compulsion law** (LV-T3 = LX-T5). For `x ≠ y` in `ℚ⁴`: every proper four-colouring gives `x, y` one colour iff
  `w(x − y) ≥ 1`; every one gives them different colours iff `w(x − y) = 0`; neither is forced iff `w(x − y) < 0`.
- **A2, the answer to `[Johnson2006]` p. 212** (LX-T6). For `d > 0`: a proper four-colouring of `ℚ⁴` forbidding `d` exists iff
  `d² ∉ ℚ`, or `d² = p/q` with `p, q` odd positive integers. When `d² = p/q` with `p, q` odd, **every** proper four-colouring
  forbids `d`. (For `d² ∉ ℚ` no pair of `ℚ⁴` is at distance `d` — LX's scope repair; for `d² ∈ ℚ>0` every `d` is realized,
  by Lagrange.)
- **A3, the structure** (LX-T5's restatement). Every proper four-colouring is, on each component `x₀ + R`, the residue map
  `R → R/P ≅ 𝔽₄` followed by a bijection to the colours, where `R = {w ≥ 0} = H ⊗ ℤ₍₂₎` (`H` the Hurwitz order) and
  `P = {w ≥ 1} = (1 + i)R`.

**What each rests on.** A1–A3: two derivations, LV (stage 3, one mind) and LX (stage 1, blind to LV), agreeing; the inputs are
Zaks's Lemma 1 (`[Zaks1999]` p. 92: pairs at `√2` forced equal), which LX replaces by its own five-point gadget L4, and the
description of the component of the origin (`[BendaPerles2000]` pp. 123–125: their `H⁴`, odd-denominator `D` of index 2), which
LX replaces by its own L1–L3 (the valuation `w`, `|R/P| = 4`, and `⟨S⟩ = R` by the ring route: `1/p` from the trace of the unit
`q²/p`, `N(q) = p`). The *if* half of A2 is `[Johnson1990]` Thm 3. **Nothing of A is in the kernel; no ledger row.**

**What the library holds for Part A:** nothing specific. No module mentions quaternions (`grep -rl "Quaternion\|ℍ\[" Proofs/` is
empty); the library's `UnitDistance.unitDistance V` (adjacency `dist x y = 1` on a metric space) and Mathlib's
`SimpleGraph.Coloring` are the vocabulary. Theorem B's residue colouring (`FieldWall4`) is the plane analogue (𝔽₄ at a prime of
`K(i)` above 2), not reusable here: its ring is `ℤ[√3, √11, i]`, not a quaternion order.

### 1.3 Part B, restated

- **B1** (C14). `χ_f(K²) = 4` for `K = ℚ(√3, √11)`, the plane over `K` with unit distance.
- **B2** (§ 1.6's parenthesis). Every finite unit-distance graph over `K` has independence ratio at least `1/4`, and ratios
  arbitrarily close to `1/4` occur; equivalently `α₁(K²) = 1/4` and `sup_{finite S} χ_f(K²[S]) = 4`.

**What it rests on (the hand route, `plans/FS56-field-blowup.md`).** Upper: Theorem B, `χ(K²) = 4` (`[Fischer1994]`'s value,
kernel-checked: `HadwigerNelson.chromaticNumber_seamPlane`). Lower: `[MatolcsiEtAl2025]`'s `G27` (27 points of `K²`) with its
geometric fractional bound `χ_gf(G27) ≥ 4` (their Thm 3; their rational witness re-checked here by `tools/fs56_gf_check.py`:
level 12, 28,496 weighted sets, 11,640 congruence classes, 182,304 independent sets; `data/fs56/g27/check-g27.log`), and their
blow-up (their Thm 1) read inside `K` (FS56 B1–B2: Følner sets of the solvable isometry group of `K²`). At the Moser ring the
instance `χ_gf = 4` is `[Ducz2026]` Thm 3.1 with `G27` (`plans/FS131-PAS1-prior-art.md`).

**What the library holds for Part B** (each by `#print axioms`, `data/fs131/kfs1/probes/AxiomsB.out`):
- `chromaticNumber_seamPlane : ((unitDistance ℂ).induce seamPlane).chromaticNumber = 4` (`FieldWall4`), and
  `planeOver_seamField : planeOver seamField = seamPlane := rfl` (`SquareClass`).
- `Collapse.exists_indepLaw [NumberField F] : ∃ μ : IndepLaw F, (cayR F).finIndepRatio ≤ μ.density` — **standard three
  axioms** (B-AMEN's amenability half: no Einsiedler–Lindenstrauss).
- `Collapse.finIndepRatio_planeOver_le_cayR`, `SimpleGraph.inv_finIndepRatio_le_iSup_fractionalChromaticNumber` — standard
  three.
- `Collapse.fractionalChromaticNumber_planeOver_eq : χ_f(F²) = (localRatio F)⁻¹` — standard three **and E–L**.
- `Plane/DensityBound/X23Check`, `X23`: a core-only checker and its soundness for `[AmbrusEtAl2023]`'s 23-point congruence
  certificate over `ℤ[√3, √11]` (FS131-IDB3) — hard-wired to 23 points, but the pattern for `G27`'s.
- **No `NumberField ↥seamField` instance** (`grep` finds none): owed for any route through `IndepLaw`.

### 1.4 Findings from the readback

1. **(shorter route, Part B — a finding for the coordinator, not urgent.)** `χ_f(K²) ≥ 4` needs neither the blow-up nor E–L: an
   invariant random independent set `μ : IndepLaw K` exists with `α₁ ≤ μ.density` on the standard three
   (`exists_indepLaw`), and `G27`'s certificate bounds `μ.density ≤ 1/4` directly — `P(Y ⊆ I)` is constant on congruence classes
   by invariance, and the certificate's identity is an expectation. So the route through the density form
   (`fractionalChromaticNumber_planeOver_eq`, which would also need every stable prime's ratio bounded by `1/4`, each by the same
   certificate) is dominated: more trust (E–L) and more work. Stage 2 maps it.
2. **(source wording, no defect.)** `CLOSED-QUESTIONS.md`'s ℚ⁴ entry and Poros's rank 7 state the theorem for `d² ∈ ℚ`; LX's table
   shows the literal "for which `d > 0`" answer adds `d² ∉ ℚ` (vacuous). The head statement below states the unconditional
   answer, with the realized form beside it — no correction owed, since both sources carry the scope.

## Stage 2 — SAVED: the map

Names confirmed by `#check` at the pin: `data/fs131/kfs1/probes/NamesA.out` (Mathlib) and `AxiomsB.out` (library). Line counts
are planned estimates for hand-written Lean, one mind; generated data counted apart.

### 2.1 Part A — the route

The route is LX's (stage 1 of `data/consolidation-2026-09-27/lx/record.md`, L1–L6 and the corollary), which matches the one I
sketched before reading it, with one change of instrument: nothing is said about `ℤ₍₂₎` or `𝔽₄` as objects. Everything is read
through `w(z) = padicValRat 2 (normSq z)` and one **normal form** — `w(z) ≥ 0` iff `z = (a, b, c, d)/(2m)` with `m` odd and
`a ≡ b ≡ c ≡ d (mod 2)` — so every residue fact is an integer parity fact. The four residue classes of the component are named by
the **unit tetrahedron** `T = {0, 1, h, h′}`, `h = ½(1+i+j+k)`, `h′ = ½(1+i+j−k)`: its six differences are unit vectors, so it
meets the four classes once each, and no map to `𝔽₄` is ever built.

| step | content | holds | missing | est. lines |
|---|---|---|---|---|
| A0 graph | `Q4.sqDist x y = normSq (x − y)` on `ℍ[ℚ]`; the unit graph on `ℍ[ℚ]` and on `Fin 4 → ℚ` (Σ squares), iso by `QuaternionAlgebra.equivTuple`; bridge to `(unitDistance (EuclideanSpace ℝ (Fin 4))).induce ratPoints` (`EuclideanSpace.dist_eq`) | Mathlib `Quaternion.normSq` (a `→*₀`), `normSq_def'`, `equivTuple`, `EuclideanSpace.dist_eq`; library `unitDistance` | the three graphs and two isos | 110 |
| A1 normal form (LX L1's computation) | `0 ≤ w z ↔ ∃ m a b c d, Odd m ∧ a ≡ b ≡ c ≡ d [ZMOD 2] ∧ z = ⟨a,b,c,d⟩/(2m)` | `padicValRat.mul/div/pow/of_nat`, `Nat.exists_eq_two_pow_mul_odd`; parity of four squares mod 4 and 8 by `decide` on `ZMod 8` | all | 170 |
| A2 the component order | `comp : AddSubgroup ℍ[ℚ]` with carrier `{z \| 0 ≤ w z}` (closed under `+` through the normal form: odd denominators multiply, parities add); `pr : AddSubgroup` = image of `comp` under `(1 + i) * ·`, with `z ∈ pr ↔ z = 0 ∨ 1 ≤ w z` | `normSq` multiplicative (`map_mul`), `normSq_inv` | all | 120 |
| A3 generation (LX L3, the ring route) | `comp = AddSubgroup.closure S`, `S = {u \| normSq u = 1}`: `⊇` from `w u = 0`; `⊆` from the normal form, the Hurwitz generators `1, i, j, k, h ∈ S`, and `1/m ∈ closure S` for odd `m` | `Nat.sum_four_squares`, `Int.gcd_eq_gcd_ab`, `Nat.recOnMul`, `AddSubgroup.closure_induction`; `Subring.closure_toAddSubgroup` **is not a name at the pin**, so `closure S` closed under `*` is a double closure induction | all | 160 |
| A4 Zaks's Lemma 1 (LX L4) | every proper four-colouring agrees on each pair at squared distance 2: the gadget `0, 1, h, a = ½(1+i+j−k), b = ½(1+i−j+k)` moved by `z ↦ x + (z − a)·q`, `q = (b − a)⁻¹(y − x)`, `normSq q = 1`, and a `decide` over `Fin 4⁵` | `SimpleGraph.Coloring.valid`, `normSq_def'` | all | 80 |
| A5 forced equal (LX L5) | `1 ≤ w(x − y) → c x = c y` for every colouring: `x − y = (1 + i)r`, `r ∈ closure S`, induction, each generator `(1 + i)u` of norm 2 by A4 | A2, A3, A4 | all | 60 |
| A6 the tetrahedron | for `z ∈ comp` there is `t ∈ T` with `z − t ∈ pr`; unique; `t = 0` iff `z ∈ pr` | A1 (parity cases), A2 | all | 90 |
| A7 forced different (LX L6) | `w(x − y) = 0 → c x ≠ c y`: A6 gives `t ∈ {1, h, h′}` with `x − y − t ∈ pr`, so `c x = c (y + t) ≠ c y` (A5, properness) | A5, A6 | all | 40 |
| A8 the residue colourings (LX L5's converse) | for every `σ : ℍ[ℚ] ⧸ comp → Fin 4 ≃ Fin 4`… concretely `c_a x = index of A6's t for x − out⟦x⟧, shifted by a⟦x⟧` is proper for every `a : ℍ[ℚ] ⧸ comp → ZMod 4`; it separates `w = 0` pairs; it can join or split any pair in two components | `QuotientAddGroup.mk_out_eq_mul`, `leftRel_apply` | all | 130 |
| A9 the compulsion law (head) | the three iff's of 1.2 A1 | A5, A7, A8 | — | 60 |
| A10 the forbidden distances (head) | 1.2 A2, the unconditional form and the realized form, and "every colouring forbids `√(p/q)`"; `v₂ r = 0 ↔ r = p/q, p, q odd` for `r > 0`; Lagrange for `r ∈ ℚ>0`; the similarity `x ↦ qx`, `normSq q = r` | `Nat.sum_four_squares`, `padicValRat.inv`, `Rat.num_div_den` | all | 140 |
| A11 spec and models | `Nonempty (G.Coloring (Fin 4))` (A8) as the hypotheses' model; examples for `sqDist`, the gadget, the tetrahedron, `v₂` of `1/3, 2, 1/2, 6` | — | all | 50 |
| **Part A total** | | | | **≈ 1,210** |

**Printed theorems the steps read, and what is done with each.** All three are formalized here, none declared:
- `[Zaks1999]` Lemma 1 (p. 92): A4, about 80 lines — under the hour's line (`LEAN.md` § Assumptions). Zaks's own reflection
  argument is replaced by right multiplication by a unit quaternion (LX L4), the same statement.
- `[BendaPerles2000]` pp. 123–125 (the component of the origin is `H⁴`): A1 + A3, about 330 lines. Over the hour's line by
  lines, but the brief's rule is "when unsure, formalize", and an axiom here would be a statement about an unprinted-in-Lean
  description of a subgroup whose read-back would cost what the proof costs. **Formalize.**
- `[Johnson1990]` Thm 3 (the *if* half of A2): it is A8's separation clause — free once A8 exists.

**Generalizations seen while mapping (no message: none changes a statement anyone is building on).**
- A1–A8 never use dimension four except through the quaternion multiplication (`normSq` multiplicative, so similarities and the
  transitivity on pairs of one squared distance exist). The same law holds verbatim in `ℚ⁸` with the octonions? Not claimed:
  octonions are non-associative and A3's ring argument and A5's `(1 + i)·` both use associativity. Recorded as a question, not a
  generalization.
- A3 gives more than the component: `closure S` is a **ring** (`S·S ⊆ S`), so the component of the origin is a subring
  — the `ℚ⁴` form of `unitRingOver`'s statement in the plane (`UnitRing.lean`).

### 2.2 Part B — the routes, compared

| route | lower bound `χ_f(K²) ≥ 4` from | rests on | missing | est. lines |
|---|---|---|---|---|
| **B-I (chosen): invariant law + `G27`'s certificate** | `exists_indepLaw` (an `R ⋊ U`-invariant random independent set `μ` of `Cay(R, U)` with `α₁(K²) ≤ μ.density`) and `μ.density ≤ 1/4` read off `G27`'s certificate: `P(Y ⊆ I)` is constant on congruence classes, the singletons sum to `w = 4`, and every independent set of `G27` weighs at most 1 | standard three | `NumberField ↥seamField`; the `G27` checker, data and soundness; the law's conjugation symmetrization; the expectation identity | 1,350 + data |
| B-II: the density form | `fractionalChromaticNumber_planeOver_eq` and `stableRatio P ≤ 1/4` at **every** stable prime of `K(i)` | E–L, standard three | the same certificate argument once per level target, over every prime | more than B-I |
| B-III: the printed blow-up | `[MatolcsiEtAl2025]` Thm 1 inside `K` (FS56 B2): Følner sets of the countable solvable isometry group of `K²`, regular fractional colourings, a compactness limit | standard three | Følner sequences for solvable groups (not in Mathlib at the pin), the polytope compactness, the certificate | more than B-I |

B-I is B-III's averaging done once in the library (`exists_indepLaw` is the amenability step, on the standard three) and read
at the certificate's points: the `G27` certificate is consumed exactly as `[MatolcsiEtAl2025]`'s Theorem 1 consumes it, by
an invariant aggregate. B-II pays E–L for nothing. **B-I is the implementer's route.**

B-I's steps:

| step | content | holds | missing | est. lines |
|---|---|---|---|---|
| B0 number field | `NumberField ↥seamField` from `seamField_le_fieldOfRadicands` and `instNumberFieldFieldOfRadicands` (a subfield of a finite-dimensional field is finite-dimensional) | both (`SquareClass`, `Arith/QuadraticPrime`) | the instance | 30 |
| B1 the checker (core-only) | `G27Check`: `X23Check`'s integer arithmetic in `ℤ[√3, √11, √33]` (`Q4`, `C4`) with 27 points; the congruence-row check (an explicit isometry `z ↦ u z^(b) + v` per listed set, `\|u\| = 1`); class sums `= 0` and singleton sum `= w·D` over a common denominator `D`; the DFS over the independent sets of `G27` accumulating `Σ_{Y ⊆ S} y_Y` | `X23Check` as the template (324 lines) | a copy at `n = 27`, with rational weights over one denominator | 380 |
| B2 data and checks (generated) | `G27Data` (27 points over denominator 12, 49 edges, 28,496 weighted sets, 11,640 classes), `G27Cong*` (the congruence rows), `G27Atoms*` (the DFS chunks), from `data/fs56/g27/cert-g27-mrvz.json` by a generator with a `--check` mode | `tools/fs131_kdb1_x23.py` as the template; the JSON's provenance hashes | the generator (Python, ~350 lines) and the modules | data |
| B3 soundness | `G27.Valid` from the accepted checks: congruences as isometries of `ℂ`, the class sums, the atoms | `X23.lean` (834 lines) as the template, `Pattern.Congruent` | the adaptation (no Bessel weights) | 600 |
| B4 the isometries are the law's | every congruence row of `G27` (`z ↦ u z + v` or `u z̄ + v`, `\|u\| = 1`, points in `R`) has `u ∈ U_K`, `v ∈ R`; `IndepLaw` is invariant under `R ⋊ U`; a conjugation-symmetrized law `(μ + conj₊μ)/2` is an `IndepLaw` of the same density invariant under conjugation too | `IndepLaw` (`shift_inv`, `rot_inv`), `unitRing`, `unitVectors` | all | 160 |
| B5 the expectation identity | for an invariant law and a valid certificate: `w · μ.density = Σ_c (Σ_{Y ∈ c} y_Y) P(Y_c ⊆ I) ≤ E[Σ_{Y ⊆ I ∩ G27} y_Y] ≤ 1`; so `μ.density ≤ 1/w` | `MeasureTheory` finite sums of indicators (`integral_finsetSum`, `lintegral` forms) | all | 180 |
| B6 heads | `χ_f(K²) = 4`; `α₁(K²) = 1/4`; `⨆_S χ_f(K²[S]) = 4` | `chromaticNumber_seamPlane`, `exists_indepLaw`, `finIndepRatio_planeOver_le_cayR`, `inv_finIndepRatio_le_iSup_fractionalChromaticNumber`, `OneClass.fractionalChromaticNumber_induce_le` | a `χ_f ≤ χ` lemma if none exists | 100 |
| **Part B total** | | | | **≈ 1,450 + the generator + data** |

**The kernel price of B2 is the one unmeasured number.** `X23`'s atom check was 7.12 M mask tests at about 140 µs each in 103
theorems (`LEAN.md` § The kernel's cost model); `G27`'s DFS visits 182,304 nodes but its tests are terms × prefixes, with
28,496 terms of about 250-digit rationals. Re-price from the first two chunks (`LEAN.md`: a kernel leaf priced from a plan's table
is priced high). A smaller certificate — lower level or smaller support — would cut it; finding one is an LP over the certificate
form, a search request (stage 3 § 3.6), never a reason to wait.

**Printed theorems the steps read.** `[MatolcsiEtAl2025]` Thm 3 (`χ_gf(G27) ≥ 4`) enters as its certificate, checked by the
kernel — formalized, not declared. Their Thm 1 (the blow-up) is not needed on route B-I. `[Fischer1994]`'s value is Theorem B,
held.
