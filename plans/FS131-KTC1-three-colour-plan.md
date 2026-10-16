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

## Stage 3 — SAVED: the skeleton, the plan, the price

### 3.1 The modules (branch `fs131-ktc1` only; `sorry` at every leaf; none reaches `main` with one)

| module | holds | imports |
|---|---|---|
| `Proofs/HadwigerNelson/CayleyThree/Circular.lean` | the rational-approximation tool, the circular colouring, the criterion, the periodic form, the `ℚ` control, row 79's class | `Arith/ThreeColourCharacter`, `Kempe`, `LocalGlobal` |
| `Proofs/HadwigerNelson/CayleyThree/Fibre.lean` | heights on `ℤ^m`, the colouring's winding, tight relations, Dickson's bound, Farkas by sides, the rational relative-interior point, rigidity | `CayleyThree/Circular`, `Mathlib.Order.WellQuasiOrder` |
| `Proofs/HadwigerNelson/CayleyThree/Density.lean` | the McShane extension, the choice of the period, density (finite and topological forms), `P = F`, the dichotomy's first clause, row 79's class | `CayleyThree/Fibre` |

Imports added to `Proofs.lean` after `Arith.ThreeColourCharacter`; three rows in `ARCHITECTURE.md` after `Arith/ThreeColourCharacter`'s
(`tools/check_architecture.py`: PASS). Elaborated module by module (`data/fs131/ktc1/seq.sh`, iteration only; logs
`data/fs131/ktc1/probes/*.out`: sorry warnings only), then through `./scripts/build.sh` under the slot (§ 3.7).

### 3.2 The head statements, read aloud against row 79

*(The coordinator's ruling, inventory item 996: state the widest form the plan proves, and row 79's class as a corollary.)*

1. `CayleyThree.colorable_three_iff_bandSet_nonempty (hS : 0 ∉ S) : (addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty`
   — *for every abelian group `A` and every set of steps `S` without `0`, the Cayley graph is 3-colourable iff some character
   `θ : A → ℝ/ℤ` has `θ(s) ∈ [1/3, 2/3]` for every `s ∈ S`.* Row 79's "(criterion) … 3-colourable ⟺ `Θ₃ ≠ ∅`", with the class
   widened. `0 ∉ S` is load-bearing: at `S = {0}` the graph is edgeless and `bandSet` is empty.
2. `CayleyThree.colorable_three_iff_exists_isPeriodic [AddGroup.FG A] (hSfin : S.Finite) : (addCayley S).Colorable 3 ↔ ∃ C,
   IsPeriodic C` — *a finitely generated abelian group with finitely many steps: 3-colourable iff some 3-colouring has a period
   group of finite index.* Row 79's "⟺ it has a periodic (circular) 3-colouring". Both hypotheses load-bearing:
   `colorable_three_rat` with `not_isPeriodic_rat` (`ℚ`, `S = {1}`) for finite generation; for finiteness of `S`, the band set of
   an irrational rotation's Bohr set over `ℤ` (by hand, not in the skeleton: it needs equidistribution).
3. `CayleyThree.exists_isPeriodic_eqOn (hSfin : S.Finite) (hgen : AddSubgroup.closure S = ⊤) (C) (B : Finset A) : ∃ C',
   IsPeriodic C' ∧ Set.EqOn C' C B` — *every 3-colouring agrees on every finite set with a periodic one*, and
   `coloring_mem_closure_isPeriodic`, the same in the product topology on `A → Fin 3` (the derivation's "dense": agreement on
   finite sets). Row 79's "(density) periodic 3-colourings are dense". `hgen` is the route's, not the truth's (§ 3.5).
4. `CayleyThree.periodicForcedSubgroup_three_eq_forcedSubgroup` and `inheritanceQuestion_three` — *`P = F` at three colours*,
   in `Kempe`'s vocabulary (`periodicForcedSubgroup S 3 = forcedSubgroup S 3`; `InheritanceQuestion S 3`). Row 79's "so `P = F`
   (C3-inherit) and C3-aper hold at three colours for the whole class".
5. `CayleyThree.forcedSubgroup_finiteIndex_iff_finite` — *`F` has finite index iff there are finitely many proper
   `k`-colourings*, every `k`, every `S`. Row 79's dichotomy, first equivalence.
6. `CayleyThree.exists_affine_of_forall_three_nsmul` — *if every band character has order 3, every 3-colouring proper along a
   generating family is affine*. Row 79's "if every point has order 3 every 3-colouring is affine".
7. `colorable_three_iff_of_fg_torsionFree`, `exists_isPeriodic_eqOn_of_fg_torsionFree` — row 79's own class
   (`[AddGroup.FG A] [IsAddTorsionFree A]`, `S` finite, `−S = S`, generating, `0 ∉ S`), each one line from the widest forms,
   so the ledger's statement is visibly an instance.

**Not claimed** (in every docstring that could be read otherwise): any `k ≠ 3`; FS73-T22's real form `θ ∈ Hom(Λ, ℝ)` (needs
torsion-freeness); the dichotomy's clause "⟺ every cell of `Θ₃` is a point" (§ 2.5); density at the standard generators of
`ℤ^r` as ours (folklore per FS73-T24: `[ChandgotiaMarcus2018]`, listings only); that the widening is new (§ 3.6); the
instances of row 79 (`ℚ(√11)`, `ℚ(√167)`).

### 3.3 The plan, leaf by leaf (route; names at the pin; children; what is hard; lines)

**`Circular`** — 440 lines.
- `exists_rat_solution_near` (110). `V = span_ℚ ({1} ∪ range x) ⊆ ℝ` (`FiniteDimensional.span_of_finite`), a basis `b` of `V`
  (`Module.Basis.ofVectorSpace`), coordinates `κ_l(v) ∈ ℚ`; for `t : basis → ℝ` put `Φ_t(v) = Σ_l κ_l(v) t_l`, so `Φ_b = id`
  and `t ↦ Φ_t(x_i)/Φ_t(1)` is continuous at `b`; a rational `t` near `b` (`DenseRange.piMap`, `Rat.denseRange_cast`,
  `DenseRange.exists_mem_open`, as in `exists_int_vector_of_forall_neg`) gives `q_i = Φ_t(x_i)/Φ_t(1)`, and `G q = b` because
  `Φ_t` is `ℚ`-linear and `Φ_t(b_k·1) = b_k·Φ_t(1)`. Hard: carrying the coordinates as rationals and as reals at once.
- `rep01`, `rep01_mem`, `coe_rep01` (15): `AddCircle.equivIco 1 0`, `AddCircle.coe_eq_coe_iff_of_mem_Ico`.
- `circular_add_ne` (35): `t, t' ∈ [0, 1)`, `t' − t ∈ [1/3, 2/3] + ℤ`; `⌊3t⌋, ⌊3t'⌋ ∈ {0, 1, 2}` equal would give `|t' − t| < 1/3`;
  then the cast to `ZMod 3` is injective on `{0, 1, 2}` (`decide` on the three values). `ker_le_periods_circularColoring` (10).
- `coloring_add_ne` (15): `addCayley_adj'`, `a ≠ a + u` from `u ≠ 0`. `colorable_three_iff_bandSet_nonempty` (15): ⟹
  `bandSet_three_nonempty_of_proper`; ⟸ `circularColoring`.
- `finiteIndex_ker_of_nsmul_eq_zero` (25): the range lies in `{t | N • t = 0}`, finite in `ℝ/ℤ` (`AddCircle` torsion lemmas,
  `#check` at the leaf); `QuotientAddGroup.quotientKerEquivRange`, `AddSubgroup.finiteIndex_of_finite_quotient`.
- `exists_torsion_mem_bandSet` (120): `S` enumerated (`Set.Finite.toFinset`, `Finset.equivFin`), a generating family `g` of
  `A` (`AddGroup.FG`), `f = Fin.append s g`; lifts `x_j ∈ [1/3, 2/3]` for the steps, `rep01` for the rest; relations generated by
  `n` vectors (`Submodule.fg_iff_exists_fin_generating_family`, as in `Winding.exists_box_point`), values `n_i ∈ ℤ`; the face:
  hold `x_j` where it is `1/3` or `2/3`; `exists_rat_solution_near` with `ε` the least distance to the other faces; the held
  `exists_character_of_box_point` gives `θ'`; a common denominator kills `f`, hence `A`. Hard: the bookkeeping of `Fin.append`.
- `colorable_three_iff_exists_isPeriodic` (25): `addCayley_erase_zero` (the pin's name: confirmed by the spec example in
  `Density`) to drop `0`; then 1, `exists_torsion_mem_bandSet`, `finiteIndex_ker_of_nsmul_eq_zero`,
  `AddSubgroup.finiteIndex_of_le`.
- `colorable_three_rat`, `not_isPeriodic_rat` (45): `x ↦ x/2` is a band character; a subgroup `K` of finite index has
  `K.index • q ∈ K` (`AddSubgroup.nsmul_index_mem`) and `ℚ` is divisible, so `K = ⊤`, so `C (0 + 1) = C 0`. Spec (15).

**`Fibre`** — 1,020 lines.
- `liftHeight_add_single` (45): decomposition independence (`height_append`, `height_perm` with `word_add_perm`), then
  `height_add_gen`. `liftHeight_cast` (15, `height_cast`). `pmHeight_add_single`, `pmHeight_cast` (20).
  `abs_pmHeight_sub_le` (45: strong induction on `l1 (x − y)`, one coordinate step at a time). `even_pmHeight_sub_sum` (20).
- `heightWinding` and `liftHeight_add_ker` (60): the difference `liftHeight (x + r) − liftHeight x` is invariant under every
  `+ e_j` (the two steps are at the same point of `A`), hence constant (`AddSubgroup.closure_induction` on the `Pi.single`
  basis); its value at `0` is the wind; `3 ∣` by `height_cast`; `minRise_le` by `height_bounds`. `pmHeight_add_ker` (15).
- `surjective_relMap_iff` (25). `fibre_nonempty` (5, `Winding.exists_box_point`), `convex_fibre` (20).
- `step_eq_one_of_isTight`, `step_eq_two_of_isTight` (60): `wind` from any base point is `3·W` (`wind_shift` and generation:
  every `a` is `π m⁺ − π m⁻`); tightness forces `height (word σ⁺) = |σ⁺|`; `height_perm` brings `j` to the front; `step_mem`.
- `fibre_coord_of_isTight` (30): `σ·x = W σ = minRise σ / 3 = min_box σ·x`, termwise.
- `exists_le_mul_of_imp_eq_zero` (90): the minimal nonzero elements of `M` are an antichain of `ι → ℕ`, finite
  (`WellQuasiOrderedLE.finite_of_isAntichain` with `Pi.wellQuasiOrderedLE`); `κ` their largest `t`; strong induction on
  `Σ_i x_i`: below `x ≠ 0` a minimal `μ` (well-foundedness of `<` on `ι → ℕ`), `x − μ ∈ M`, additivity. **Re-price here.**
- `exists_slack_bound` (80): per sign pattern `p : Fin m → Bool`, `M_p = {|σ| : σ ∈ R in orthant p}`; `minRise` and `W` are
  additive on an orthant; the slack is `ℕ`-valued by `minRise_le`; `κ = max_p κ_p`.
- `exists_mem_pi_Icc_of_forall_int` (70): the private `exists_mem_box_of_forall_int`'s proof with `lo`, `hi` in place of
  `1/3`, `2/3` (copied, not opened: the generalization is the point).
- `exists_mem_fibre_gt` (60): `ε = 1/(3κ)`, the box with `x_j ∈ [1/3 + ε, 2/3]`; at `r_j ≥ 0` the best vertex is the box's and
  `minRise_le` at `−r` pays; at `r_j < 0` the slack at `σ = −r` pays `ε|r_j|`. `Winding.flip`, `mem_fibre_flip_iff`,
  `isTight_flip_iff` (40), `exists_mem_fibre_lt` (20).
- `exists_rat_mem_fibre_relint` (110): one point per side per untight direction (§ 3), their average (`Convex.sum_mem`), then
  `exists_rat_solution_near` on the relation generators with the tight coordinates held at `1/3` or `2/3`
  (`fibre_coord_of_isTight`), `ε` the least slack of the average.
- `exists_affine_of_forall_three_nsmul` (60): every fibre point gives a band character (`exists_character_of_box_point`), of
  order 3, so `x_j ∈ {1/3, 2/3}`; convexity makes each coordinate constant; the contrapositives of `exists_mem_fibre_gt`/`_lt`
  give a tight relation through every direction; the frozen steps make `c(a + s_j) − c(a)` constant; constant differences
  along generators give an additive `φ`. `isTight_one_two` (15).

**`Density`** — 770 lines.
- `mcshane_mem`, `mcshane_le` (60): `Int.csInf_mem`, `csInf_le`; the lower bound `min_{β ∈ B}(h β − l1 (x − β))` from
  `|λ ℓ| ≤ l1 ℓ` and the triangle inequality for `l1`. `abs_mcshane_add_single_sub` (60: each term is `1`-Lipschitz and has the
  parity of `Σ x`, so steps are `±1`). `mcshane_add` (40: reindex `ℓ ↦ ℓ − ℓ₀`). `mcshane_eq_of_consistent` (25,
  `le_csInf`). `mcshane_model` (15).
- `exists_lt_l1_of_sub_nsmul_mem` (110): the vectors of `l1 ≤ D` are finitely many (a box); for each outside `M`, a
  finite-index `W ⊇ M` missing it (`exists_finiteIndex_between_notMem` on `ℤ^m`, `V = M`, `H = ⊤`); `N = q·∏ index`;
  `AddSubgroup.nsmul_index_mem`.
- `exists_periodic_properAlong_eqOn` (300: the assembly): `x*` from `exists_rat_mem_fibre_relint`, `a* = 3 − 6x*`, `T` the tight
  set, `η`; `h = pmHeight`, affine along `T` (`step_eq_one/two_of_isTight` through `pmHeight_add_single`, extended over
  `closure (Pi.single T)`: 40); lifts `B̃` of `B` (`Function.surjInv`); `D = 2·diam/η`; `M = R ⊔ ℤ^T`;
  `N` from `exists_lt_l1_of_sub_nsmul_mem` with `q = 6·den(a*)`; `L = R ⊔ N•⊤`, `λ ℓ = a*·ℓ` as an `L →+ ℤ` (integral: `w` on
  `R`, `6 ∣` on `N•⊤`); (C′) by the two cases (100); descent through `π` (`liftHeight_add_ker`, `λ ∈ 3ℤ`); periods `π(N•ℤ^m)`, of
  index at most `N^m` (`AddSubgroup.finiteIndex_of_finite_quotient`, a surjection from `Fin m → Fin N`). Hard: (C′)'s second
  case, and keeping `a*` rational while `λ` is integral.
- `exists_isPeriodic_eqOn` (30): `addCayley_erase_zero`, an enumeration of `S ∖ {0}`, `surjective_relMap_iff`, the family
  form, `addCayleyColoring`. `coloring_mem_closure_isPeriodic` (50: `nhds_pi`, `isOpen_set_pi`; a basic neighbourhood fixes a
  finite set). `periodicForcedSubgroup_three_eq_forcedSubgroup` (40: `mem_periodicForcedSubgroup`, `mem_forcedSubgroup`,
  `B = {x, x + δ}`). `forcedSubgroup_finiteIndex_iff_finite` (60: ⟹ colourings factor through `A ⧸ F`; ⟸ the translation
  orbit of each colouring is finite, its stabilizer is `periods C`, a finite intersection of finite-index subgroups).

**Total: about 2,230 lines** (Circular 440, Fibre 1,020, Density 770), every leaf on the standard three axioms, no import, no
hypothesis standing for a result of ours. Later, outside these modules: the dichotomy's cell clause (§ 2.5, about 450); density
without generation (§ 3.5, about 150). Order of the work: `Circular` (independent; it alone answers Ellenberg's question at
`k = 3` in the periodic form), then `Fibre` §1–§2, then `exists_le_mul_of_imp_eq_zero` and `exists_slack_bound` — **re-price
the rest from these two** — then `Fibre` §4–§5, then `Density`.

### 3.4 The modeling passes (fresh invocations)

- **Domain** (`debruijn-domain-modeling`): two costumes for a colouring (`A → ZMod 3` with `ProperAlong`, which every held lemma
  reads, and `(addCayley S).Coloring (Fin 3)`, which every consumer reads) are kept, with the bridge stated once in each
  direction (`coloring_add_ne`, `circularColoring`/`addCayleyColoring`). Two normalizations (the library's steps in `{1, 2}`
  with the fibre in `[1/3, 2/3]^m`; McShane's `±1` steps with slopes in `[−1, 1]^m`) meet at one stated seam,
  **`pmHeight_add_ker`** (added). Generation appears in two costumes, so **`surjective_relMap_iff`** was added as their
  bridge. `fibre` is a set beside `Winding`, not an index on it.
- **Obligation** (`debruijn-obligation-modeling`): measures named — strong induction on `Σ x` (Dickson bound), on `l1` (the
  Lipschitz bound); no induction elsewhere. The mutation audit removed two hypotheses that were not load-bearing: `0 ∉ S` in
  the periodic form and in every density statement (the graph ignores `0`: `addCayley_erase_zero`). The audit also found that
  `hgen` in density is the route's, not the truth's (§ 3.5).
- **Experience** (`debruijn-experience-modeling`): ledger numbers out of names (`…_of_row79` became `…_of_fg_torsionFree`); both
  sides named (`periodicForcedSubgroup_three_eq_forcedSubgroup`); the conclusion that the name `…_eqOn` promises is now
  `Set.EqOn`; `exists_good_N` became `exists_lt_l1_of_sub_nsmul_mem`. Every head docstring opens with the theorem as a
  mathematician would cite it and its row-79 clause.

### 3.5 Density without generation (a finding; planned, not in the skeleton)

The mutation audit's open point: dropping `hgen` from `exists_isPeriodic_eqOn` does not make it false. On cosets of `H = ⟨S⟩`
the colourings are independent; colour each of the finitely many cosets `B` meets by the generated case, then choose a
finite-index `A₀ ⊆ A` with `A₀ ∩ H` inside the common period and the cosets distinct modulo `A₀ + H` — both by residual
finiteness, applied in `A ⧸ K` and in `A ⧸ H` (`exists_finiteIndex_between_notMem`, twice). About 150 lines, for `A`
finitely generated. [hand, this planner, one mind.] So row 79's density holds for every finitely generated abelian group and
every finite `S`, by this route.

### 3.6 Prior-art question (the coordinator's ruling: a question, not a claim)

What of the widening is in print? The ⟸ of the criterion is the classical construction of a circular colouring from a
homomorphism to the circle group — for distance graphs `G(ℤ, D)` the `κ(D)` literature, for Cayley graphs the circular and
star chromatic number (Vince 1988; Zhu's survey) — and its validity for every abelian group needs nothing new. The questions for
the prior-art gate: (a) is "3-colourable ⟺ a band character exists", for arbitrary abelian Cayley graphs, stated in print (the
derivation found rank 1 not stated, FS73-T22); (b) is the periodic form with torsion or without generation stated; (c) is
density stated for arbitrary generating sets (FS73-T24 calls the standard-generator case folklore). Searched by this job:
nothing (no reading beyond the derivation's records). The search words: "circular colouring" with "Cayley graph" and "abelian";
"hom-shift" with "periodic points dense"; "three-colouring" with "height function" and "lattice"; zbMATH author listings for
Chandgotia and Zhu.

### 3.8 Front-page lines owed (drafts; Keryx files)

1. **`LEDGER.md` row 79, the grade sentence** — now, replacing *"The ⟸, the density of periodic colourings and the statement
   about forced pairs stay [hand]."* by: *"The ⟸, the periodic form, density, `P = F` and the dichotomy's first clause are planned
   for the kernel (FS131-KTC1: skeleton `CayleyThree/Circular`, `Fibre`, `Density` on branch `fs131-ktc1`, about 2,230 lines),
   stated in a wider class than this row's (inventory item 996); they stay [hand] until it lands."* — and at the landing, by:
   *"The ⟸ and the periodic form are [kernel] since <landing> (standard three), for every abelian group and every `S ∌ 0`
   (`CayleyThree.colorable_three_iff_bandSet_nonempty`) and for `A` finitely generated with `S` finite
   (`colorable_three_iff_exists_isPeriodic`; finite generation is needed: `not_isPeriodic_rat`); density and `P = F` for a
   finite generating `S`, torsion allowed (`exists_isPeriodic_eqOn`, `coloring_mem_closure_isPeriodic`,
   `periodicForcedSubgroup_three_eq_forcedSubgroup`, `inheritanceQuestion_three`); `F` of finite index ⟺ finitely many
   colourings, every `k` (`forcedSubgroup_finiteIndex_iff_finite`); the rigidity clause (`exists_affine_of_forall_three_nsmul`);
   row 79's own class as `…_of_fg_torsionFree`. The dichotomy's cell clause stays [hand]."*
2. **`CLOSED-QUESTIONS.md` § 2.4**, after its account of what row 79 answers — at the landing: *"Kernel status: the criterion,
   the periodic form and density are kernel theorems since <landing> (`Proofs/HadwigerNelson/CayleyThree/`), in the widest
   class their proofs read; what of the widening is in print is the prior-art gate's open question (FS131-KTC1 plan § 3.6)."*
3. **`CLAUDE.md` § What the kernel holds** — at the landing only, one clause after the three- and four-colour paragraph:
   *"three colours on abelian Cayley graphs (row 79): colourable iff a character puts every step in `[1/3, 2/3]`, iff
   periodically colourable (finitely generated, finitely many steps), and periodic colourings dense, so `P = F` at three
   colours (`CayleyThree/*`)."*
4. **`ARCHITECTURE.md`**: the three rows are written on the branch (this job's file to touch); at the landing their parentheticals
   change from "skeleton" to the landing's name.
5. **`BIBLIOGRAPHY.md`**: no new row (nothing new read). **`LEAN.md`**: a candidate line, if the implementer confirms it: *"The
   pin has no LP duality and no closedness of finitely generated cones; Stiemke-type steps on a lattice cone go through Dickson's
   lemma (`Pi.wellQuasiOrderedLE`, `WellQuasiOrderedLE.finite_of_isAntichain`): `CayleyThree.exists_le_mul_of_imp_eq_zero`
   (FS131-KTC1)."*

### 3.7 The build

`./scripts/build.sh` under the slot (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`, `--mem 6 --cpus 3`, `MEMMAX=6G BATCH=2`), 2026-10-16
13:59–14:31 UTC: **exit 0**; four modules rebuilt (`CayleyThree.Circular` 1.0 s, `Fibre` 2.9 s, `Density` 3.1 s, the root `Proofs`
2.0 s); the only warnings in the new modules are the 53 `declaration uses 'sorry'` (14, 26, 13 leaves); sources checked
unchanged since the build began (`data/fs131/ktc1/build2.sources.md5`). Log: `data/fs131/ktc1/build2.log`. A first build
(`build1.log`) was stopped by this job at batch 49 of its walk, by process group (exit 143, a deliberate SIGTERM, not a crash),
because the modeling passes were about to edit the modules it would read; it had compiled nothing of this job's.

**For the implementer's gate** (not run here: a skeleton has `sorry`): the colouring binders read `GENERIC` (`S` a parameter)
except `not_isPeriodic_rat`, whose carrier `(addCayley {1} : ℚ).Coloring (Fin 3)` is inhabited by `colorable_three_rat`; the
hypothesis structures are `Winding` (`nonempty_winding_one_two`), `ProperAlong` (`properAlong_one_two`), `IsTight`
(`isTight_one_two`), the McShane data (`mcshane_model`), a coloured generating set (`coloringOneTwo`); no axiom and no declared
hypothesis enters; `exists_mem_pi_Icc_of_forall_int` copies a private proof, so the dupnames scan sees no doubled name.
