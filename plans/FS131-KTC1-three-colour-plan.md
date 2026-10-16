# FS131-KTC1 — three-colourings of lattice Cayley graphs at the kernel: the criterion's converse, periodicity, density

*Planner: de Bruijn (Opus 5.5), job FS131-KTC1, brief `data/fs131/briefs/FS131-KTC1-three-colour.md` (on `main` at `9a545b3c4`).
Worktree `.claude/worktrees/kel1`, branch `fs131-ktc1`, cut from `main` at `99e78e428`. Started 2026-10-16 13:33 UTC. No fence
(`plans/FS131-close-inventory.md` § Rulings in force, ruling 1).*

## Theorems this phase proved

None. A planning job: the skeleton's statements carry `sorry` at every leaf, and nothing of it reaches `main`.

## Stage 1 — SAVED: the readback

### 1.1 The quotations of the brief, checked against their sources

Each quotation was compared byte for byte by a script against its source in this worktree (`main` at `99e78e428`; the brief
itself is on `main` at `9a545b3c4`, after the cut, and was read there).

| quotation | source | result |
|---|---|---|
| W2 (2026-10-13) | `data/fs131/REQUEST-2026-10-13.md` l. 4 | identical |
| *The theorem.* (Rank 5, C6) | `plans/POROS-2026-10-13-number-field-findings.md` § 3.3, l. 406–408 | identical |
| *The first objection.* (Rank 5, C6) | the same file, l. 415–416 | identical |
| ledger row 79, whole | `LEDGER.md` row 79 (unchanged since `d859ff5ec`, the same on `main`) | identical |
| `bandSet_three_nonempty_of_proper`, docstring and signature | `Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean` l. 272–275 | identical |

No mismatch. One observation about the brief's frame, not a mismatch: the Poros statement it quotes has **no generation
hypothesis** on `S`, and row 79 has one ("`S = −S` finite generating"); the two are compared in § 1.3.

### 1.2 The result, in my words

For an abelian group `A` and a set `S ⊆ A ∖ {0}` of steps, the Cayley graph `Cay(A, S)` joins `a` and `a + s`. Row 79, at three
colours and for `A` finitely generated torsion-free with `S = −S` finite and generating, says four things.

1. **The criterion.** `Cay(A, S)` has a proper 3-colouring exactly when some character `θ : A → ℝ/ℤ` sends every step into the
   closed arc `[1/3, 2/3]`; and exactly when it has a 3-colouring that is constant on the cosets of some subgroup of finite index
   (a *periodic* colouring). The colouring a character gives is `x ↦ ⌊3·{θ(x)}⌋`, the circular colouring.
2. **Density.** For every proper 3-colouring `c` and every finite set `B`, some periodic proper 3-colouring agrees with `c` on `B`:
   the periodic colourings are dense in the space of colourings with the product topology (agreement on finite sets). With it, a
   difference `δ` identified by every periodic colouring is identified by every colouring: `P = F`, the inheritance question
   (C3-inherit) at three colours, and C3-aper (a colourable graph has a periodic colouring).
3. **The dichotomy.** The forced group `F` has finite index ⟺ there are finitely many colourings ⟺ every cell of `Θ₃` is a point;
   and when every point of `Θ₃` has order 3, every 3-colouring is affine.
4. **The instances**: `F = 3Λ` at `ℚ(√11)`'s `Λ₁₀`, the certificates, `χ(ℚ(√167)²) ≥ 4` and the four-colour no-gos — not this
   job's (the `ℚ(√167)` bound is row 119's kernel theorem).

**What the kernel holds of it** (all on the standard three axioms, `Arith/ThreeColourCharacter`, `ThreeColour`, `ThetaCert`,
`Kempe`):
- the criterion's ⟹ in character form, **for every abelian group and every set of steps**: `bandSet_three_nonempty_of_proper`
  (a colouring changing along every step of `U` gives `θ` with `θ(U) ⊆ [1/3, 2/3]`), through `nonempty_winding` (the integer
  height's winding on the relation lattice), `Winding.exists_box_point` (the winding is realised by a point of `[1/3, 2/3]^m`),
  `exists_character_of_box_point` and `bandSet_nonempty_of_finite` (compactness of the character group);
- the vocabulary of the inheritance question: `periods`, `IsPeriodic` (period group of finite index), `forcedSubgroup` (`F`),
  `periodicForcedSubgroup` (`P`), `InheritanceQuestion S k` (`P ≤ F` given a periodic colouring), and residual finiteness
  `exists_finiteIndex_between_notMem` (`Kempe`);
- the `Θ₃`-emptiness certificate checker (`ThetaCert`, row 119).

**What is left**: the criterion's ⟸ (the circular colouring), the periodic form, density, `P = F` at three colours, the
dichotomy and the rigidity clause.

### 1.3 Two readings made during the readback (findings, sent to the coordinator at once; § 2.6 has the argument)

- **The class is wider than row 79 says, in every clause this job plans.** (i) The criterion in character form needs only
  `0 ∉ S`: the ⟸ (circular colouring) holds for every abelian group and every set of steps, and the held ⟹ already does. (ii) The
  periodic form needs `A` finitely generated and `S` finite, and neither torsion-freeness, nor symmetry, nor generation; finite
  generation is necessary (`A = ℚ`, `S = {1}`: colourable, and no proper subgroup of finite index exists). (iii) The density route
  planned here (§ 2.4) uses no torsion-freeness and no symmetry: it needs `S` finite and generating, and by a coset reduction not
  even generation. Grade of (i), (ii): [hand, this planner; short]. Of (iii): a reading of the route, [hand, one mind], to be
  checked by the kernel when the module lands.
- **The derivation's `θ ∈ Hom(Λ, ℝ)` form (T22) needs torsion-freeness; the character form does not** (T42 records the reason:
  `ℤ/3` is 3-colourable with `Hom(ℤ/3, ℝ) = 0`). The kernel states the character form, which is row 79's own wording.

## Stage 2 — SAVED: the map

*Every name below was read in its module or confirmed by `#check` at the pin (`data/fs131/ktc1/probes/Names.lean`, its print
`Names.out`; one name probed and absent: `ContinuousLinearMap.exists_extension_norm_eq`, not used). Prices are lines of Lean,
proofs included, at this library's density; LEAN.md's rule stands — re-price from the first two leaves.*

### 2.1 The steps the unheld parts need, against what is held

| step (derivation) | what it says | held here or in Mathlib | missing, and its price |
|---|---|---|---|
| T22 ⟸ (C1) | `⌊3{θ(x)}⌋` is proper when `θ(S) ⊆ [1/3, 2/3]`; periodic under `ker θ` | `band`, `bandSet` (`Arith/CharacterColouring`); `AddCircle.equivIco`, `AddCircle.coe_eq_coe_iff_of_mem_Ico`, `Int.floor`; `addCayleyColoring` (`LocalGlobal`), `periods`, `IsPeriodic` (`Kempe`) | `rep01`, `circular`, `circular_add_ne`, `circularColoring`, `periodic_circular`: **60** |
| T22 ⟹ | the winding gives `θ ∈ Θ₃` | **held**: `bandSet_three_nonempty_of_proper` (every group, every step set) | the `Coloring`-to-`ProperAlong` bridge for `addCayley S` with `0 ∉ S`: **15** |
| T22, "has a rational vertex" | a nonempty band set over finitely many steps has a point of finite order | `Submodule.fg_iff_exists_fin_generating_family`, `IsNoetherian` (as `Winding.exists_box_point` uses them); `exists_character_of_box_point` (held, any real vector integral on relations); `FiniteDimensional.span_of_finite`, `Module.Basis`, `DenseRange.piMap`, `Rat.denseRange_cast` | **R1** `exists_rat_solution_near` (a rational linear system with a real solution has rational solutions arbitrarily near it: a `ℚ`-basis of the span of `1` and the coordinates, the basis coordinates moved to nearby rationals, normalized at `1`): **110**. **R2** `exists_torsion_mem_bandSet` (the face of the box the real point lies in, held fixed; R1; the held character; a common denominator): **120** |
| periodic form | colourable ⟺ periodically colourable | R2; `circularColoring`; `QuotientAddGroup.quotientKerEquivRange`; `AddSubgroup.finiteIndex_of_finite_quotient`; the finiteness of the `N`-torsion of `ℝ/ℤ` | **40**; the necessity model at `ℚ` (no proper subgroup of finite index, `AddSubgroup.nsmul_index_mem`): **45** |
| T21 (L1, Lemma 1) | the height on `ℤ^m`, steps `±1`, `≡ c∘π (mod 3)` | **held on words**: `ThreeColour.height`, `height_append`, `height_perm`, `height_add_gen`, `height_cast`, `height_bounds`, `step`, `wind_shift` | `liftHeight` on `ℤ^m` from words (`H(m) = height 0 m⁺ − height (π m) m⁻`), its step law, its mod-3 law, `pmHeight = 3Σm − 2H`, the ℓ¹ Lipschitz bound, parity: **170** |
| T21 (L2, Lemma 2) | the winding is global, additive, `≡ Σρ (mod 2)` | `Winding`, `minRise` (held); the held construction is inside `nonempty_winding`'s proof, not a definition | `heightWinding` (the colouring's own winding as a definition) and `liftHeight_add_ker`: **50** |
| T21 (L3) | the fibre is nonempty | **held**: `Winding.exists_box_point` | — |
| T23 / H-ii (first half) | a tight relation freezes every step along its directions | `height_perm`, `height_bounds`, `wind_shift` | `step_eq_one_of_tight`, `step_eq_two_of_tight` (generation used to move the base point): **60** |
| T23 / H-ii (second half: LP duality, Stiemke in de Bruijn's form) | a coordinate constant on the fibre at a box face is frozen by a tight relation | `geometric_hahn_banach_closed_point` (used privately by `exists_mem_box_of_forall_int`), `exists_int_vector_of_forall_neg` (public); **no LP duality, no Minkowski–Weyl, no closedness of finitely generated cones at the pin** (`Mathlib/Geometry/Convex/Cone/DualFinite.lean` names Minkowski–Weyl only in prose) | **replaced by Dickson's lemma** (§ 2.3): `exists_le_mul_of_imp_eq_zero` (an abstract Gordan bound, `Pi.wellQuasiOrderedLE`, `WellQuasiOrderedLE.finite_of_isAntichain`): **90**; per orthant: `exists_slack_bound`: **80**; the box separation for a general box `∏[lo_j, hi_j]` (the private lemma's proof, generalized): **70**; `exists_box_point_gt` and, through the colour-reversing involution `Winding.flip`, `exists_box_point_lt`: **100** |
| H-iii, "`a*` rational in the relative interior" | a rational fibre point strict off the tight directions | R1; convexity of the fibre | `exists_rat_relint` (average of finitely many points, then R1 on the affine hull with the tight coordinates fixed) and `fibre_coord_of_tight`: **110** |
| T23 (rigidity: points of order 3) | every colouring affine | the above | `exists_addMonoidHom_of_forall_three_nsmul`: **60** (rides) |
| H-iii (McShane) | `ĥ(m) = min_{β, ℓ} h(β) + a*·ℓ + ‖m − β − ℓ‖₁` is a periodic height agreeing on `B` | `Int.csInf_mem`, `csInf_le`, `le_csInf` | `mcshane` and its five laws (attained, below each term, steps `±1`, `L`-equivariant, agrees under consistency): **200** |
| H-iii, the choice of `N` | `N` even, a multiple of `6·den(a*)`, with `N·Q` missing every nonzero class of norm `≤ D` in `Q = ℤ^m/(R + ℤ^T)` | **held**: `exists_finiteIndex_between_notMem` (residual finiteness, `Kempe`); `AddSubgroup.nsmul_index_mem` | `exists_good_N` (the finite set of short classes, one finite-index subgroup per class, the product of indices): **110** |
| H-iii, (C′) | the consistency inequality | the laws above | `consistent` (the two cases `ℓ ∈ R + ℤ^T`, `ℓ ∉`): **100** |
| H-iii, descent | `ĥ mod 3` is a periodic proper colouring of `Cay(A, S)` agreeing with `c` on `B` | `addCayleyColoring`, `Function.surjInv` | descent, finite index of `π(Nℤ^m)`, agreement: **120** |
| T24, `P = F`, C3-aper | from density | **held**: `mem_periodicForcedSubgroup`, `mem_forcedSubgroup`, `forcedSubgroup_le_periodicForcedSubgroup`, `InheritanceQuestion`, `inheritanceQuestion_iff` | **40** |
| T24 / H-iv (first equivalence) | `F` of finite index ⟺ finitely many colourings | `periods`, `AddSubgroup.finiteIndex_iInf`-type lemmas | `forcedSubgroup_finiteIndex_iff_finite`, every `k`, every `S`: **60** (rides) |
| T24 / H-iv (second equivalence) | ⟺ every cell of `Θ₃` is a point | the whole fibre layer | **not in the first modules** (§ 2.5): **≈ 450** |
| density, topological form | the closure statement in `A → Fin 3`, product topology | `Fin 3`'s discrete topology (an instance at the pin, probed); `isOpen_set_pi`, `nhds_pi` | **50** |

### 2.2 The printed results the steps read

- **The height lift** (`K₃`'s universal cover is the line; four-cycle-free targets have heights): Chandgotia 2017 and K. Schmidt's
  cocycles, as the derivation names them (T21, *Prior art*; read in summary there, not by me). **Formalized here**: the library
  already holds it on words (`ThreeColour`), and its passage to `ℤ^m` is 170 lines.
- **Hahn–Banach separation in finite dimension**: Mathlib (`geometric_hahn_banach_closed_point`); used, never declared.
- **LP duality / Stiemke's alternative** (T23, H-ii): textbook; **not at the pin**. Formalized here **in the form this proof needs**
  through Dickson's lemma (Mathlib's `Pi.wellQuasiOrderedLE`), never declared. Under an hour of agent work it is not; it is still
  formalized, since an axiom for it would be a statement of ours about polyhedra, not a printed theorem read back.
- **McShane's extension** (H-iii; prior art Chandgotia–Pak–Tassy 2019, unread): an explicit formula on `ℤ^m`, formalized here.
- **Residual finiteness of finitely generated abelian groups**: held (`exists_finiteIndex_between_notMem`).
- **Dickson's lemma**: Mathlib.

No step is declared as an outside theorem; nothing in the plan takes a hand result of ours as a hypothesis.

### 2.3 The one change of route: Dickson in place of LP duality

H-ii's LP step ("`max_{A(c)}(−a_t) = −1` gives, by duality, a relation `σ` with `w(σ) = ‖σ‖₁`") is used once, to make the
McShane extension agree with `c` along the tight directions. The pin has no LP duality. The route here proves the contrapositive
form directly. In the library's normalization (`x ∈ [1/3, 2/3]^m`, steps in `{1, 2}`, `minRise r ≤ 3·W r`), call
`σ ∈ R` **tight** when `minRise σ = 3·W σ`.

1. *Tight relations freeze* (combinatorial, no polyhedra): along a tight `σ`, every step of every word for `σ⁺` is `1` and every
   step for `σ⁻` is `2`, from every base point (`wind_shift` with generation; `height_perm` puts any letter first). So `σ_j > 0`
   gives `step(·, j) ≡ 1`, `σ_j < 0` gives `≡ 2`.
2. *No tight relation through `j` gives a uniform slack*: on each orthant the slack `3·W σ − minRise σ` and `σ_j` are additive
   functions into `ℕ` on the monoid `R ∩ orthant`; its minimal nonzero elements are an antichain of `ℕ^m`, finite by Dickson, so
   `σ_j ≤ κ·(3·W σ − minRise σ)` with `κ` the largest `σ_j` among them (strong induction on `‖σ‖₁`).
3. *Uniform slack gives a fibre point with `x_j > 1/3`*: the held separation argument run on the box with `x_j ∈ [1/3 + ε, 2/3]`,
   `ε = 1/(3κ)`: at a relation with `r_j < 0` the box's best vertex loses `ε|r_j|`, which the slack pays.
4. *The other side* (`x_j < 2/3` unless a tight relation has `σ_j < 0`) is the same statement for the reversed colouring's winding
   `r ↦ Σ_j r_j − W r` (`Winding.flip`).

This also removes the derivation's two uses of saturation (H-ii's "scale `σ` into `R`": `σ` is in `R` already; H-iii's "multiple of
the exponent of the torsion of `Q`": residual finiteness of `Q` does the same for every finitely generated `Q`) — the basis of
§ 1.3 (iii).

### 2.4 The density route, as it will be built

For `s : Fin m → A` listing `S` (all of it: no choice of one generator per `±` pair), generating, `0 ∉ S`, `c` proper, `B` finite:
1. `h = pmHeight` on `ℤ^m`: steps `±1`, `h ≡ c∘π − c(0) (mod 3)`, `h(m + ρ) = h(m) + w(ρ)` on `R`, `w(ρ) = 3Σρ − 6W(ρ)`;
2. `a* = 3 − 6x*` from `exists_rat_relint`: `|a*_j| = 1` exactly on the tight set `T`, `η = min_{j ∉ T}(1 − |a*_j|) > 0`; `h` is
   affine along `T` (§ 2.3, 1);
3. `D = 2·diam₁(B̃)/η`; `N` from `exists_good_N`; `L = R + Nℤ^m`, `λ(ℓ) = a*·ℓ ∈ 3ℤ`;
4. `ĥ = mcshane h B̃ L λ`; (C′) by the two cases; `c' = ĥ mod 3 + c(0)` descended through `π`; periodic under `π(Nℤ^m)`.

### 2.5 What does not ride in the first modules

The dichotomy's clause "`⟺` every cell of `Θ₃` is a point" (H-iv). Its kernel statement would be "finitely many 3-colourings ⟺
`bandSet S (band 3)` finite". Each direction needs more than the fibre layer gives: (⟸) the winding-to-cell injection, the affine
hull of a one-point fibre forcing `R + ℤ^T` of finite index (rank linear algebra), and the count of colourings with a given winding;
(⟹) distinct points of an infinite band set giving distinct colourings, by the rational relative-interior points of a fat cell and
the mean slope of a periodic colouring as an invariant. About 450 lines, in a module of its own after the three below. The row's
rigidity clause ("every point of order 3 ⟹ every colouring affine") and the first equivalence do ride.
