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

## Stage 3 — SAVED: the skeleton, the plan per leaf, the price

### 3.1 The modules (branch `fs131-kfs1`; nothing with a `sorry` goes to `main`)

| module | holds | imports |
|---|---|---|
| `Proofs/HadwigerNelson/RationalFour/Basic.lean` | `sqDist`, `quatGraph`, `sqDist4`, `ratFourGraph`, `toQuat`, `quatIso`, `ratPoints`, `nonempty_iso_unitDistance`, `val`, `unitSphere`, `onePlusI` | Mathlib (quaternions, `padicValRat`, colourings, `PiL2`), `UnitDistance` |
| `RationalFour/Order.lean` | `comp`, `zero_le_val_iff`, `mul_mem_comp`, `inv_prime_mem_comp`, `inv_odd_mem_comp`, `mem_comp_iff`, `pr`, `mem_pr_iff`, `pr_le_comp`, `hur`, `hur'`, `tetra`, `sqDist_tetra`, `existsUnique_tetra_sub_mem_pr` | `RationalFour/Basic`, `SumFourSquares` |
| `RationalFour/Compulsion.lean` | Zaks's Lemma 1, forced equal / different, `residue`, `residueCol`, `residueColouring`, `nonempty_coloring`, the law on `quatGraph` and the three heads on `ratFourGraph` | `RationalFour/Order` |
| `RationalFour/Forbid.lean` | Lagrange over `ℚ`, `padicValRat_eq_zero_iff_odd`, the three forbidden-distance heads | `RationalFour/Compulsion` |
| `Instances/SeamFractional.lean` | `numberField_seamField`, `IndepLaw.density_le_quarter_seamField` (leaves); **the three heads proved from them** | `Collapse/Density/Upper`, `Arith/QuadraticPrime`, `SquareClass` |

`Proofs.lean` imports `RationalFour/Forbid` and `Instances/SeamFractional`; `ARCHITECTURE.md` § 3.6 has a row for each module
(`tools/check_architecture.py`: PASS). Each module elaborated with `lake env lean` (iteration, `data/fs131/kfs1/seq.sh`);
the build through `./scripts/build.sh` is § 3.5.

### 3.2 The head statements, read aloud against the results

**Part A** (`ratFourGraph : SimpleGraph (Fin 4 → ℚ)`, `x ∼ y ⟺ Σᵢ (xᵢ − yᵢ)² = 1`; a proper four-colouring is
`ratFourGraph.Coloring (Fin 4)`, Mathlib's `G →g ⊤`; `sqDist4 x y = Σᵢ (xᵢ − yᵢ)²`).
- `forall_coloring_eq_iff x y : (∀ c, c x = c y) ↔ x = y ∨ 1 ≤ padicValRat 2 (sqDist4 x y)` — "every proper four-colouring
  gives `x, y` one colour iff `x = y` or `v₂(|x − y|²) ≥ 1`". A1's first clause, with the trivial `x = y` written out (Mathlib's
  `padicValRat 2 0 = 0` would otherwise make the clause false at `x = y`).
- `forall_coloring_ne_iff x y : (∀ c, c x ≠ c y) ↔ padicValRat 2 (sqDist4 x y) = 0 ∧ x ≠ y` — A1's second clause; `x ≠ y`
  excludes the junk value.
- `exists_coloring_eq_and_ne_iff x y : ((∃ c, c x = c y) ∧ ∃ c, c x ≠ c y) ↔ padicValRat 2 (sqDist4 x y) < 0` — A1's third
  clause; at `x = y` both sides are false.
- `exists_coloring_forbidding_iff (hd : 0 < d) : (∃ c, ∀ x y, (sqDist4 x y : ℝ) = d ^ 2 → c x ≠ c y) ↔
  (∀ r : ℚ, (r : ℝ) ≠ d ^ 2) ∨ ∃ p q : ℕ, Odd p ∧ Odd q ∧ d ^ 2 = p / q` — `[Johnson2006]` p. 212's question as posed, for every
  `d > 0`; "distance `d`" is `|x − y|² = d²` read in `ℝ`, the only reading for rational points.
- `exists_coloring_forbidding_iff_padicValRat (hr : 0 < r)` — the same on squared distances `r ∈ ℚ>0`: iff `v₂(r) = 0`.
- `coloring_forbids_of_odd (hp : Odd p) (hq : Odd q) c (h : sqDist4 x y = p / q) : c x ≠ c y` — "and then every proper
  four-colouring forbids `d`".
- `nonempty_iso_unitDistance : Nonempty (ratFourGraph ≃g (unitDistance (EuclideanSpace ℝ (Fin 4))).induce ratPoints)` — the
  graph is the library's unit-distance graph of Euclidean four-space on its rational points: the read-back's anchor.

**Not claimed (Part A):** anything with five or more colours; anything in `ℚⁿ`, `n ≠ 4`; the structure clause A3 as a
statement (it is one line in the existing vocabulary — `∀ c x₀, ∃ e : Fin 4 ≃ Fin 4, ∀ z ∈ comp, c (x₀ + z) = e (residue z)` —
and is left out of the price unless the coordinator wants it, about 40 lines); novelty (FS131-PAS2's).

**Part B** (`seamPlane = planeOver seamField`, `K = ℚ(√3, √11)`; `unitDistance ℂ` induced on it).
- `fractionalChromaticNumber_seamPlane : ((unitDistance ℂ).induce seamPlane).fractionalChromaticNumber = 4` — C14.
- `finIndepRatio_seamPlane : … .finIndepRatio = 4⁻¹` — the infimum over nonempty finite vertex sets of `α(G[S])/|S|` is `1/4`.
- `iSup_fractionalChromaticNumber_seamPlane : ⨆ S : Finset seamPlane, χ_f(G[S]) = 4` — "finite unit-distance graphs over `K`
  have fractional chromatic numbers arbitrarily close to 4", and none above 4.

All three are **proved in the skeleton** from two leaves (`numberField_seamField`, `IndepLaw.density_le_quarter_seamField`)
through `exists_indepLaw`, `finIndepRatio_planeOver_le_cayR`, `inv_finIndepRatio_le_iSup_fractionalChromaticNumber`,
`OneClass.fractionalChromaticNumber_induce_le`, `four_colorable_of_seam_field` — the composition is checked; what is open is
the two leaves. **Not claimed (Part B):** `χ_f` at any other field; the geometric fractional chromatic number as a statement
(the certificate is consumed, not stated); novelty.

### 3.3 The plan per leaf

Leaves in the order to build them. "Route" is the proof; "uses" names confirmed with `#check` (stage 2's probes) or held by
the library; "hard" says where the time goes.

**`RationalFour/Basic`**
| leaf | route | uses | hard | lines |
|---|---|---|---|---|
| `sqDist_toQuat` | unfold `toQuat`, `QuaternionAlgebra.equivTuple` (its `symm_apply`), `normSq_def'`, `Fin.sum_univ_four`, `ring` | as named | none | 10 |
| `nonempty_iso_unitDistance` | the map `x ↦ ⟨toLp (fun i => (x i : ℝ)), _⟩`; injective; surjective on `ratPoints` by `choose`; `dist = √(Σ dist²)` (`EuclideanSpace.dist_eq`), `Real.sqrt_eq_one`, `Rat.cast` of the sum | `EuclideanSpace.dist_eq`, `Real.dist_eq`, `sq_abs` | the `PiLp`/`WithLp` coercions at the pin | 70 |
| two `val` examples | `padicValRat.of_nat`, `padicValRat.inv`, `padicValNat.self`/`padicValNat.eq_zero_of_not_dvd` | as named | none | 10 |

**`RationalFour/Order`**
| leaf | route | uses | hard | lines |
|---|---|---|---|---|
| `zero_le_val_iff` (A1) | ←: `normSq = (a²+b²+c²+d²)/(4m²)`, the sum `≡ 0 (mod 4)` for one parity (`decide` on `ZMod 4`). →: write the four coordinates over the product `D` of their denominators, `D = 2^e·m` (`Nat.exists_eq_two_pow_mul_odd`); `0 ≤ v₂` gives `4^e ∣ ΣAᵢ²`; strong induction on `e`: `4 ∣ Σ` forces one parity; all even → halve, `e − 1`; all odd → `Σ ≡ 4 (mod 8)` (decide on `ZMod 8`), so `e ≤ 1` | `padicValRat.div/pow/of_nat`, `padicValRat_of_nat` | the bookkeeping from `ℚ` coordinates to one integer quadruple — state a helper `exists_int_coords : ∃ D > 0, ∃ A, z = A / D` first | 170 |
| `mul_mem_comp` | `AddSubgroup.closure_induction` on `x`, inside it on `y`; generator case `normSq (u v) = 1` (`map_mul`) | `AddSubgroup.closure_induction`, `mul_add`, `mul_neg` | none (`Subring.closure_toAddSubgroup` is not a name at the pin) | 30 |
| `inv_prime_mem_comp` | `Nat.sum_four_squares p`; permute so `a ≠ 0` (four cases, each a quaternion with the nonzero square first); `u = q * q * (p⁻¹)`, `normSq u = 1`; `u + star u = 4a²/p − 2` (`QuaternionAlgebra` component lemmas, `ring`); `Nat.Coprime (4a²) p` from `0 < a² < p` and `p` odd prime; Bézout (`Nat.Coprime.isCoprime`, `Int.gcd_eq_gcd_ab`) writes `1/p` as an integer combination of `4a²/p` and `1` | as named | the four-case permutation; state a helper `exists_sq_lt_prime` producing `a ≠ 0` with `a² + b² + c² + d² = p` | 90 |
| `inv_odd_mem_comp` | `Nat.recOnMul`: `0` not odd; `1`; prime (odd, so `≠ 2`); product (both factors odd, `(ab)⁻¹ = a⁻¹ b⁻¹`, `mul_mem_comp`) | `Nat.recOnMul`, `Nat.odd_mul` | none | 25 |
| `mem_comp_iff` | →: closure induction with the ultrametric step `0 ≤ val x → 0 ≤ val y → 0 ≤ val (x + y)` from the normal form (odd denominators multiply, parities add; `0 ≤ val` of a normal form by ←). ←: normal form `z = (1/m)·(a, b, c, d)/2`, `(a, b, c, d)/2` an integer combination of `1, i, j, k, h` (one parity), each in `unitSphere`; `mul_mem_comp` with `inv_odd_mem_comp` | `zero_le_val_iff`, `zsmul_mem` | none beyond A1 | 60 |
| `mem_pr_iff` | `z = (1 + i) r` ⟺ `r = (1+i)⁻¹ z`; `val ((1+i)⁻¹ z) = val z − 1` for `z ≠ 0` (`normSq_inv`, `padicValRat.mul`, `v₂(1/2) = −1`); `mem_comp_iff` | `normSq_inv`, `padicValRat.mul/inv` | the `z = 0` case apart | 40 |
| `pr_le_comp` | `mem_pr_iff`, `mem_comp_iff`, `0 ≤ 1 ≤ val` | — | none | 5 |
| `sqDist_tetra` | `fin_cases` both, `normSq_def'`, `norm_num` | — | none | 10 |
| `existsUnique_tetra_sub_mem_pr` | existence: normal form, case on the parity; all even: `Σa'` odd or even picks `1` or `0` (`N ≡ Σ (mod 2)`); all odd: of `h, h′` the one with `Σ(aᵢ − m)/2` even (they differ by `m`, odd); each by `mem_pr_iff` and the parity of the squared length. Uniqueness: `tetra i − tetra j` is a unit (`sqDist_tetra`), `val = 0`, so not in `pr` | `zero_le_val_iff`, `mem_pr_iff` | the integer parity arithmetic of four cases — state one helper per case | 90 |
| example `onePlusI ∈ comp` | `add_mem` of `1`, `i` | — | none | 3 |

**`RationalFour/Compulsion`** (after the domain-modeling change of § 3.4: the quaternion-level law by membership)
| leaf | route | uses | hard | lines |
|---|---|---|---|---|
| `coloring_eq_of_sqDist_two` | gadget `0, 1, hur, a, b`; `q = (b − a)⁻¹ * (y − x)`, `normSq q = 1`; `φ z = x + (z − a) * q`; `sqDist (φ z) (φ z′) = sqDist z z′` (`map_mul`, `normSq q = 1`); nine adjacencies by `norm_num`; `∀ p q r s t : Fin 4, …` by `decide` | `Coloring.valid`, `normSq_inv` | none | 80 |
| `coloring_eq_of_mem_pr` | `x − y = (1+i) r`, `r ∈ comp = closure`; induct on `r`: `c (y + (1+i) r) = c y`; generator by the previous leaf (`normSq ((1+i)u) = 2`) | `AddSubgroup.closure_induction` | stating the motive with `y` universally quantified | 50 |
| `coloring_ne_of_mem_comp_of_notMem_pr` | `existsUnique_tetra_sub_mem_pr` gives `i ≠ 0` with `x − y − tetra i ∈ pr`; `c x = c (y + tetra i)` (previous leaf); `c (y + tetra i) ≠ c y` (adjacent: `sqDist_tetra i 0`) | — | none | 30 |
| `residueCol_ne_of_adj` | `x − y` a unit, in `comp`, so `⟦x⟧ = ⟦y⟧` (`QuotientAddGroup.eq`); the two residues are those of `x − r`, `y − r`; equal residues would put `x − y` in `pr` (`pr` a subgroup: difference of two members), but `val (x − y) = 0`; the shift is the same element of `Fin 4`, and `· + s` is injective | `QuotientAddGroup.eq`, `mk_out_eq_mul` | `residue`'s `choose` — read it through `existsUnique`'s uniqueness: state `residue_spec` and `residue_eq_iff` first | 70 |
| `residueCol_eq_imp` | same component: as above, residues equal ⇒ `x − y ∈ pr`; different components: `x − y ∉ comp` | as above | none | 25 |
| `exists_residueCol_eq_and_ne` | components differ (`⟦x⟧ ≠ ⟦y⟧`); `a := Function.update 0 ⟦y⟧ s` with `s` chosen to make `residueCol a y` equal to, or one more than, `residueCol 0 x` | `Function.update_of_ne` | none | 35 |
| the law on `quatGraph` (three) | eq: `pr` ⇒ forced (above); not in `pr` ⇒ `residueColouring 0` or a shift separates (in `comp`: separates by `residueCol_eq_imp`; not: `exists_residueCol_eq_and_ne`). ne and free: the same three facts | the leaves above | none | 45 |
| the three heads on `ratFourGraph` | transport colourings along `quatIso` (`c.comp quatIso.symm.toHom` and back), `sqDist_toQuat`, then `mem_pr_iff`, `mem_comp_iff`, and `x ≠ y ↔ toQuat x ≠ toQuat y` | `quatIso` | none | 50 |
| Zaks's Lemma 2 example | `val` of `4` is 2 | the head | none | 5 |

**`RationalFour/Forbid`**
| leaf | route | uses | hard | lines |
|---|---|---|---|---|
| `exists_sqDist4_eq` | `r = n/d`, `n·d = a² + b² + c² + e²` (`Nat.sum_four_squares`), `x = (a, b, c, e)/d` | `Rat.num_div_den` | casts | 25 |
| `padicValRat_eq_zero_iff_odd` | →: `r.num`, `r.den` coprime, `v₂ = v₂(num) − v₂(den) = 0` ⇒ both odd (one of them is odd by coprimality); ←: `padicValRat.div`, `padicValNat.eq_zero_of_not_dvd` | `padicValRat.div`, `padicValRat.of_nat` | none | 35 |
| `exists_coloring_forbidding_iff_padicValRat` | ←: `residueColouring 0` (transported) separates every pair with `val = 0`. →: `v₂ r ≥ 1`: a pair at `r` (Lagrange) is forced equal; `v₂ r < 0`: `q` with `normSq q = r`, `c' = c ∘ (q * ·)` is proper and forbids `1/r`, `v₂(1/r) ≥ 1`, contradiction by the first case | the law, `exists_sqDist4_eq` | the similarity as a graph map on `ratFourGraph` — do it on `quatGraph` and transport once | 60 |
| `coloring_forbids_of_odd` | `padicValRat_eq_zero_iff_odd` and `forall_coloring_ne_iff` | — | none | 10 |
| `exists_coloring_forbidding_iff` | `d² ∉ ℚ`: no pair at `d` (cast of a rational), any colouring; `d² = r`: the rational form and `padicValRat_eq_zero_iff_odd`, with `(p/q : ℝ) = ((p/q : ℚ) : ℝ)` | the two above | casts | 40 |
| two spec examples | the rational form at `2` and `1/2` | — | none | 10 |

**`Instances/SeamFractional`**
| leaf | route | uses | hard | lines |
|---|---|---|---|---|
| `numberField_seamField` | `seamField_le_fieldOfRadicands`; a `ℚ`-linear injection `seamField →ₗ fieldOfRadicands {3, 11}` (`Subfield.inclusion`), `FiniteDimensional.of_injective`; `CharZero` | `instNumberFieldFieldOfRadicands`, `seamField_le_fieldOfRadicands` | none | 30 |
| `IndepLaw.density_le_quarter_seamField` | the certificate pipeline B1–B5 of § 2.2, in modules of their own: `Plane/G27/Check` (core-only checker, from `X23Check` at 27 points with one common denominator for the weights), `Plane/G27/Data`, `G27/Cong*`, `G27/Atoms*` (generated by `tools/fs131_kfs1_g27.py` from `data/fs56/g27/cert-g27-mrvz.json`, with a `--check` mode), `Plane/G27/Valid` (soundness, after `X23.lean`), `Plane/G27/Law` (named children: `IndepLaw.conjSymm` — the conjugation-symmetrized law; `IndepLaw.prob_subset_congr` — `P(Y ⊆ I) = P(gY ⊆ I)` for `g` in `R ⋊ U ⋊ ⟨conj⟩`; `G27.mem_unitRing` — every point of `G27` lies in `unitRing seamField`; `G27.congruence_mem` — every congruence row's `u ∈ U`, `v ∈ R`; `IndepLaw.weight_le_one` — `E[Σ_{Y ⊆ I ∩ G27} y_Y] ≤ 1`) | `IndepLaw`, `Pattern.Congruent` as a model of the congruence predicate | the kernel price of the atom check (unmeasured: re-price from the first two chunks); the expectation over finitely many indicator events with signed rational weights (state it with `ENNReal` on positive and negative parts apart, or in `ℝ` with `integral_finsetSum`) | 1,350 + data |

### 3.4 The modeling passes

**Domain modeling** (`debruijn-domain-modeling`, fresh, scoped to this job). The cut it asked for: the intrinsic object is the
filtration `comp ⊇ pr` of `ℍ[ℚ]` — the component of the origin and its ideal `(1 + i)·comp` — of which `v₂(|z|²)` is a reading.
The valuation reading has a junk value (`padicValRat 2 0 = 0`), the membership reading none. **Change made:** the
quaternion-level law (`forall_quatColoring_eq_iff` and its two siblings) is stated by membership — forced equal iff
`x − y ∈ pr`, forced different iff `x − y ∈ comp ∧ x − y ∉ pr`, free iff `x − y ∉ comp` — and the valuation is read only in
the heads, which carry the junk value's guard in the open (`x = y ∨ …`, `… ∧ x ≠ y`). The definitions name the component
(`comp := closure unitSphere`, what the graph sees) and the description is a theorem (`mem_comp_iff`), so Benda–Perles's
statement is a theorem about the graph, not a definition. The residue field is never built: the unit tetrahedron is a
transversal of `comp/pr` whose differences are unit vectors, and that is all A7 and A8 read. Unsampled members checked:
`x = y` in each clause; `d² ∉ ℚ`; `r` with `v₂(r) < 0` (the spec example at `1/2`). Next-lemma test: A3 (the structure clause)
and Zaks's Lemma 2 and Theorem 3 state in the existing vocabulary.

**Experience modeling** (`debruijn-experience-modeling`, fresh, on the head statements). The user is a mathematician citing the
result, and a prover holding one colouring `c` and a goal `c x = c y` or `c x ≠ c y`. Findings, both applied:
1. **The forms a prover applies.** `exact?` does not return an iff's direction for `c x = c y`; the user holding one colouring
   wants the implication with `c` explicit. Added: `coloring_eq_of_one_le_padicValRat c (h : 1 ≤ v₂(|x − y|²)) : c x = c y`
   and `coloring_ne_of_padicValRat_eq_zero c (hxy : x ≠ y) (h : v₂(|x − y|²) = 0) : c x ≠ c y` — Zaks's Lemmas 1–2 and
   Theorem 3 are each one application of these. (`coloring_forbids_of_odd` already had this shape.)
2. **Attribution in the docstrings, in the words a reader cites.** The forbidden-distance head names `[Johnson2006]` p. 212's
   question and `[Johnson1990]` Thm 3 for the *if* half; the C14 head names `[CranstonRabern2015]`'s question,
   `[Fischer1994]`'s value (Theorem B) for the upper bound and `[MatolcsiEtAl2025]` Thm 3 for the lower. Internal ids (LV-T3,
   LX-T5) stay in the module docstrings, not in the heads'.
Names: the `ℚ⁴` heads follow the statement-describes-goal convention in `RationalFour.` (`forall_coloring_eq_iff`,
`exists_coloring_forbidding_iff`); the C14 heads follow the library's own `chromaticNumber_seamPlane`
(`fractionalChromaticNumber_seamPlane`, `finIndepRatio_seamPlane`), so the name a reader of Theorem B predicts is the name.
No notation, no `@[simp]`, no instance beyond `NumberField ↥seamField` (canonical: one number field structure).

**Obligation modeling** (`debruijn-obligation-modeling`, fresh, on § 3.3's hard leaves). For each, the statement from which
the proof derives; the leaf plans above are read with these:
1. **`zero_le_val_iff` (→).** Not an induction on `z`: strengthen to integer quadruples and induct on the exponent,
   *generalizing the quadruple* — `∀ e (A : Fin 4 → ℤ) m, Odd m → 4^e ∣ Σ Aᵢ² → (A/(2^e m) has the normal form)`. Step: `4 ∣ Σ`
   forces one parity (`decide` on `ZMod 4`, 256 cases); all even → `A = 2B`, `4^e ∣ Σ Bᵢ²`, the IH at `B`; all odd → `Σ ≡ 4 (mod 8)`
   (`decide` on residues mod 8 of odd squares, or `Int.sq_mod_eight`-type lemmas found by `exact?`), so `e = 0`. The bridge from
   `ℚ` is one lemma: `z = A/D` with `D` the product of the four denominators, `D = 2^e m`, and `0 ≤ val z ⟹ 4^e ∣ Σ Aᵢ²`
   (`z = 0` apart). Price unchanged (170).
2. **`mem_comp_iff`.** No induction: name the auxiliary subgroup `ord` (carrier `{z | 0 ≤ val z}`, `add_mem` from the normal
   form, `neg_mem` from `normSq_neg`); then `comp ≤ ord` is `AddSubgroup.closure_le.2` (each unit has `val = 0`) and `ord ≤ comp`
   is the normal form with `inv_odd_mem_comp` and the Hurwitz generators. `ord` is closed under `*` trivially
   (`padicValRat.mul`), which is not needed. Price −20 (40).
3. **The tetrahedron.** The statement every case reads is one lemma, linear after it: `one_le_val_div_odd` — for
   `B : Fin 4 → ℤ` not all zero and `m` odd, `1 ≤ val (B/m) ↔ 2 ∣ Σ Bᵢ` (`v₂(Σ Bᵢ²/m²) = v₂(Σ Bᵢ²)` and `B² ≡ B (mod 2)`).
   Existence then picks the vertex by the parity of `Σ Bᵢ` after subtracting it (`omega`), uniqueness is `sqDist_tetra` with
   `mem_pr_iff`. Price −20 (70).
4. **`coloring_eq_of_mem_pr`.** The motive is `∀ y, c (y + (1 + i) r) = c y`, quantified over the base point (Gries's fresh
   variable): the sum case composes two instances at two base points, the negation case reads the IH at `y − (1 + i) r`. Price
   unchanged.
5. **The `G27` bound.** Two statements, each linear: `sum_weight_prob_le_one` — `Σ_Y y_Y μ{Y ⊆ I} = ∫ Σ_{Y ⊆ I ∩ G27} y_Y dμ ≤ 1`
   (finite sum of indicators in `ℝ`, `integral_finsetSum`, the pointwise bound on `IndepSets` and `carried`); and
   `sum_weight_prob_eq` — the same sum is `w · μ.density` (invariance makes `μ{Y ⊆ I}` constant on a class; classes of two or
   more points sum to 0; every singleton has probability `μ.density`). The symmetrization is a third: `IndepLaw.conjSymm`.
   Price unchanged.

Prices after the passes: **Part A ≈ 1,190 lines** (§ 2.1's 1,210, less 40 from items 2–3, plus 20 for the two applied forms of
the experience pass); **Part B ≈ 1,350 lines** of hand-written Lean, a generator of about 350 lines of Python, and generated
modules whose kernel price is unmeasured.
