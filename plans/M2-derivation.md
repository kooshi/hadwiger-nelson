# M2 (the kernel lane, crunch of 2026-09-25) — the kernel register, and the derivation file for its hand theorems

*Written 2026-09-25 at M2's close (WORKFLOW 2.0 step 9) by crunch job J23b (de Bruijn, Opus 5.5, M2's close planner), from the plan
(`plans/M2-kernel-lane.md`, the planner J04) and the six job records: `plans/M2-S1K-chain.md` (J14), `plans/M2-S2K-route-c.md` (J15),
`plans/M2-S3K-unit-ring.md` (J16), `plans/M2-S1D-bridge.md` (J17, hand), `plans/M2-S4K-bridge.md` (J17K), `plans/M2-S5K-noparam.md`
(J17K2). M2 was grade debt: it moved hand results into the kernel. So this file has two parts. **Part I is the kernel register** — every
declaration M2 added that a result rests on, with its file and line, its axioms, what it says in plain words, and the hand result it
promotes. **Part II is the derivation file proper** — the twelve theorems M2 stated and proved outside the kernel, one entry each, in the
form `tools/fs71_ledger_b_check.py` reads, so that `LEDGER.md` § B can index them (the § B lines are drafted in the plan's §R-close).*

*How the columns were read.* **Lines** are at `HEAD` of M2's Lean work (the ten files are unchanged since `287ab381`). **Axioms** come from
`#print axioms` run on all 226 declarations of the ten files at the close (`data/m2/j23b/AllAxioms.lean`, output
`data/m2/j23b/all-axioms.out`, parsed into `data/m2/j23b/decls.json`): `std` means exactly `[propext, Classical.choice, Quot.sound]`;
every declaration is within those three, and none uses `sorryAx` or a native axiom. **Audit** says whether `scripts/Axioms.lean` prints the
line in the gate (after the close's stage 0 added 21 record-named theorems, 1,146 records, 1,130 clean). **Ancestor** names the hand
result, `LEDGER.md` row or § B id the declaration promotes; "—" means the declaration is new plumbing with no hand ancestor. Grades are
`CLAUDE.md` § Notation's.

## Part I — the kernel register

### I.1 FS-45: the chain theorem (J14; `Proofs/HadwigerNelson/Chain.lean`)

| declaration (`HadwigerNelson.Chain.`) | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `not_colorable_chain` | 101 | std | yes | a graph drawn in `ℂ` with unit edges forces its points `a`, `b` to one colour in every `k`-colouring; unit complex numbers `u₁, …, u_m` with `(q b − q a)·Σ uⱼ = 1` place `m` copies end to end; then the unit-distance graph induced on the chain's points is not `k`-colourable (the closing edge is `0 — 1`, both chain points) | `ASTRA-2026-09-14-T5` (Theorem 4.1), `CLAUDE.md` G55; FS-45 D1. The owner read the statement against G55 (inventory 27) |
| `add_one_le_chromaticNumber_induce_of_chain` | 147 | std | yes | the same, as `χ ≥ k + 1` for the unit-distance graph on any subring `S ⊆ ℂ` holding the drawing and the multipliers | same |
| `add_one_le_chromaticNumber_unitDistance_of_chain` | 157 | std | yes | the same for the whole plane: `χ(ℝ²) ≥ k + 1` | same |
| `add_one_le_chromaticNumber_planeOver_of_chain` | 195 | std | yes | the same for `F²`, `F ⊆ ℝ` a subfield, drawing and multipliers in `planeOver F` | same |
| `planeOverSubring` (def) | 182 | std | — | `F²` as a subring of `ℂ` (closed under complex `+` and `·`) | — |
| `chainPoints` (def), `copyHom` (def), `junction_*`, `chainDrawing_*` | 40, 82, 43–76 | std | — | the chain's point set (the image, so shared points are one vertex); each placed copy is a graph hom into the induced graph; consecutive copies share their junction | J04's scratch leaves (`data/m2/j04/K1Chain.lean`) |
| `spindle_of_chain` | 231 | std | yes | `χ(ℝ²) ≥ 4`: the Moser spindle as the chain's `m = 2` case (a rhombus forced at three colours, twist `(√3 + i√33)/6` and its conjugate) | rung A; `LEDGER.md` row 44 (the spindle) — the chain theorem's model |
| `norm_eq_one_of_sq`, `rhombus_unit_of` | 167, 172 | std | yes | helpers: a complex number with `re² + im² = 1` has norm 1; a drawing of the rhombus is unit once its five edges have length 1 | — |

### I.2 FS-45's instances (J14)

`Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean`, namespace `HadwigerNelson.SqrtTwoThree`:

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `sixUnits_sum` | 74 | std | yes | the six unit vectors `1, ω̄, v, vω̄, v̄, v̄ω̄` over `ℚ(√2,√3)` sum, times the rhombus's forced difference `δ`, to `1` | `ASTRA-2026-09-14-T6` (its identity `δ(1+ω̄+v+vω̄+v̄+v̄ω̄) = 1`) |
| `sum_sixUnits`, `delta_mul_one_add_omegaBar`, `one_add_v_add_conj` | 59, 63, 69 | std | yes | the factoring: `Σ = (1 + ω̄)(1 + v + v̄)`, `δ(1 + ω̄) = 3`, `1 + v + v̄ = 1/3` | same |
| **`four_le_chromaticNumber_planeOver_two_three`** | 117 | std | yes | **`χ(ℚ(√2,√3)²) ≥ 4`**, by the chain theorem: six chained rhombi, no Moser spindle in the field | `ASTRA-2026-09-14-T6`, lower half (was tools grade); G55 |
| `eighteen_not_colorable_three` | 178 | std | yes | the 18-vertex, 33-edge list is not 3-colourable — by the gadget algebra (six pulled rhombus gadgets and the closing edge), one `decide +kernel`, no solver | `ASTRA-2026-09-14-T6` (the graph); a second oracle independent of the chain theorem's proof |
| `eighteen_colorable_four` | 182 | std | yes | four colours suffice (the reference colouring) | same |
| `pullGadget` (def), `diamond_hom` | 135, 151 | std | — / no | a gadget carried between vertex sets of different sizes along an edge-preserving map; each diamond maps into the list | — (inventory 23: `Gadget.transport` could not) |

`Proofs/HadwigerNelson/Instances/SevenConditional.lean`, namespace `HadwigerNelson.SevenConditional`:

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `G4` (def, a `Prop`) | 29 | std | — | there is a finite unit-distance graph drawn in `ℚ(√3,√11)²` forcing two points at difference exactly `8/3` to one colour in every 4-colouring | `LEDGER.md` row 47 (M53/M56's 588-core, one solver refusal, no proof log; Harder, Polymath16, 2018) — **a measurement, not a theorem** |
| `sum_eightUnits` | 63 | std | yes | for `w = (−3 + i√7)/4`: `w³ + w̄³ − 3w² − 3w̄² = 3/8` (eight unit vectors) | `ASTRA-2026-09-14-T9` (its identity) |
| **`five_le_chromaticNumber_planeOver_seven_of_G4`** | 99 | std | yes | **`G4 → χ(ℚ(√3,√7,√11)²) ≥ 5`**, i.e. `χ(K(√7)²) ≥ 5` given the forcer; conditional, and not vacuous (Theorem B makes every graph over `ℚ(√3,√11)` 4-colourable, so a witness is a genuine compulsion) | `ASTRA-2026-09-14-T9` (the implication); `LEDGER.md` row 64 holds `χ(K(√7)²) ≥ 5` at tools grade by another route |
| `planeOver_seam_subset`, `conj_w`, `eightUnits_mem` | 89, 51, 79 | std | no | `ℚ(√3,√11)² ⊆ ℚ(√3,√7,√11)²`; `w̄ = −3/2 − w`; the eight lie in the plane | — |

### I.3 FS-39 route C: transcendence is free (J15; `Proofs/HadwigerNelson/Transcendental.lean`, namespace `HadwigerNelson.RouteC`)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `planeOverIso` (def) | 75 | std | yes | the unit-distance graph on `planeOver L` is isomorphic to `unitQuadrance L` (points of `L²` at squared distance 1), for `L ⊆ ℝ` | J04's scratch leaf A |
| `chromaticNumber_eq_of_iso`, `chromaticNumber_planeOver_eq` | 91, 97 | std | yes | plumbing: isomorphic graphs have one chromatic number; the plane over `L` has `unitQuadrance L`'s | — |
| `unitQuadrance_colorable_of_subring` | 107 | std | yes | if a subring `A` of `R` holds both coordinates of every unit vector, a ring hom `A → S` pulls every `k`-colouring of `S²` back to `R²` (coset by coset, `cosetResidue`) | J04's scratch leaf B; `[Fischer1990]` Thm 6's colouring of `C₀`; `[Madore2015]` Prop. 3.2 |
| **`mem_valuationSubring_of_sq_add_sq_eq_one`** | 141 | std | yes | **the valuation lemma**: if `1 + x²` is a unit of the valuation subring `B` for every `x ∈ B`, then `a² + b² = 1` forces `a, b ∈ B` | `J04-H1` (Part II) |
| `one_add_sq_ne_zero` | 169 | std | yes | in a nontrivial formally real ring, `1 + s² ≠ 0` | — |
| **`unitQuadrance_colorable_of_valuationSubring`** | 177 | std | yes | a ring hom out of a valuation subring of `K`, killing its maximal ideal, into a ring with no square root of `−1`, pulls every colouring of that ring's plane back to `K²` — any place whose residue ring has no `√−1` | **`[Madore2015]` Prop. 3.2 at `d = 2`** (any valuation ring whose residue field makes `z₁² + z₂²` anisotropic; read at the close, p. 6 of the held PDF) — the kernel form is ours, and J15's phrasing (any ring hom to a ring with no `√−1`, killing the maximal ideal) is a hair more general; covers J17's C3′ integrality step and Theorem A's residue fields `𝔽_q`, `q ≡ 3 (mod 4)` |
| `zeroIntegral`, `zeroPlace`, `evalZero` (defs) | 205, 260, 270 | std | — | the rational functions with no pole at `t = 0`, as a subring and a `ValuationSubring (RatFunc F)`; evaluation at `0`, a ring hom onto `F` | — (hand-built; not claimed equal to Mathlib's `X`-adic valuation subring) |
| `inv_mem_zeroIntegral_of_not_mem` | 237 | std | yes | a rational function with a pole at `0` has an inverse with no pole there, vanishing there | — |
| `evalZero_eq_zero_of_mem_maximalIdeal` | 282 | std | yes | evaluation at `0` kills the maximal ideal of `zeroPlace F` | — (the one leaf the plan named as route C's gap, §2.2) |
| `chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero` | 301 | std | yes | the engine: `χ(F(t)²) = χ(F²)` for every field `F` in which `−1` is not a square | `FS39-T1`, in a stronger form |
| **`chromaticNumber_unitQuadrance_ratFunc`** | 314 | std | yes | **`χ(F(t)²) = χ(F²)` for every formally real field `F`** — `[Fischer1990]` Thm 6's colouring statement at `d = 2`. The owner read it against FS-39 route C (inventory 38) | `FS39-T1`; `CLAUDE.md` G63 |
| `chromaticNumber_unitQuadrance_ratFunc_rat` | 320 | std | yes | its inhabitant at `F = ℚ` | — |
| `chromaticNumber_unitQuadrance_eq_of_ringEquiv`, `one_add_sq_ne_zero_of_subfield` | 328, 336 | std | yes | ring-isomorphic rings have one unit-quadrance chromatic number; a subfield of `ℝ` has no `√−1` | — |
| `adjoinTranscendental` (def), `le_adjoinTranscendental`, `mem_adjoinTranscendental_self`, `adjoinTranscendentalEquiv` (def) | 342, 346, 350, 355 | std | yes (the two lemmas) | `F(t) := (IntermediateField.adjoin F {t}).toSubfield` (no proof argument); `F ≤ F(t)`; `t ∈ F(t)`; `F(t) ≃+* RatFunc F` for `t` transcendental (Mathlib's `RatFunc.algEquivOfTranscendental`) | — |
| **`chromaticNumber_planeOver_adjoin_transcendental_eq`** | 362 | std | yes | **for `F ⊆ ℝ` a subfield and `t ∈ ℝ` transcendental over `F`: the plane over `F(t)` and the plane over `F` have the same chromatic number** (in `ℕ∞`) — G63's statement at `d = 2`; it does not name the common value | `FS39-T1`; G63; `[Fischer1990]` Thm 6 |
| `transcendental_liouvilleNumber_bot`, `chromaticNumber_planeOver_liouville` | 371, 385 | std | yes | Liouville's constant `L = Σ 10^(−n!)` is transcendental over `ℚ`; so `χ(ℚ(L)²) = χ(ℚ²)` — the inhabitant (π's transcendence is not in Mathlib) | — |

### I.4 FS-47: prime inversion, valuation form (J16; `Proofs/HadwigerNelson/UnitRing.lean`, namespace `HadwigerNelson.UnitRing`)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `unitRing` (def) | 47 | std | — | for a field `L` with a ring endomorphism `σ`, the subring generated by the norm-one elements `{u : u·σu = 1}` | M56's `Σ₀`; G55's `ℤ[U]` |
| `normOne_subset_iff_stable` | 56 | std | yes | for `σ` an involution, a valuation subring holds every norm-one element iff it is `σ`-stable (⟸ is row 57's `normOne_subset_valuationSubring`; ⟹ is new, three lines) | row 57; J04's scratch leaf 1 |
| `unitRing_le_valuationSubring_iff` | 70 | std | no | `unitRing σ ≤ B` iff `B` is `σ`-stable | — |
| `inv_mem_iff_forall_valuationSubring` | 77 | std | yes | for `x ≠ 0` in a subring `R` of `L`: `x⁻¹ ∈ R` iff `x⁻¹` lies in every valuation subring above `R` (Chevalley's domination, Mathlib's `Ideal.image_subset_nonunits_valuationSubring`, Stacks 00IA) | replaces `ASTRA-2026-09-14-T1`'s lying-over step |
| **`inv_natCast_mem_unitRing_iff`** | 100 | std | yes | **prime inversion, valuation form**: in characteristic 0, with `σ` an involution and `n ≠ 0`, `1/n ∈ ℤ[U]` iff `1/n` lies in every `σ`-stable valuation subring of `L`. The owner read it (inventory 55) | `ASTRA-2026-09-14-T2` (Theorem 1.2), in valuation form; `[Fischer1990b]` Thms 1, 3–4 (special cases) |
| `inv_natCast_mem_unitRing_iff_not_mem_nonunits`, **`inv_two_mem_unitRing_iff`** | 107, 118 | std | yes | the same as "no `σ`-stable valuation subring has `n` in its maximal ideal"; at `n = 2`, **the 2-adic wall in valuation form** | `CLAUDE.md` G35 ("the wall is broken iff 1/2 lies in the unit-vector ring") |
| `planeOverSubfield` (def), `conj_mem_planeOverSubfield` | 133, 147 | std | — / no | `F(i)` as a subfield of `ℂ` (carrier `planeOver F`); it is conjugation-stable, so the involution is Theorem A's `ResidueColouring.conjOn` | row 57 |
| `unitRingOver` (def) | 151 | std | — | the unit-vector ring of `F²`: the subring of `ℂ` generated by the unit vectors with both coordinates in `F` | G55 |
| `coe_mem_unitRingOver_iff`, **`inv_natCast_mem_unitRingOver_iff`** | 172, 191 | std | yes | the plane's ring is the abstract ring of `F(i)` under conjugation; so `1/n ∈ ℤ[U_F]` iff no conjugation-stable valuation subring of `F(i)` has `n` in its maximal ideal | `ASTRA-2026-09-14-T2`, valuation form; the number-field reading is row 57's gap |
| `exists_sum_eq_of_mem_unitRingOver` | 201 | std | yes | every element of `ℤ[U_F]` is a finite sum of unit vectors of `F²` | — |
| **`add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver`** | 229 | std | yes | **the chain theorem in ring form**: a forcer drawn in `F²` at `δ ≠ 0` with `1/δ ∈ ℤ[U_F]` gives `χ(F²) ≥ k + 1` | `ASTRA-2026-09-14-T5` as G55 states it ("if `1/δ` is a sum of unit vectors") |
| `inv_five_mem_unitRing_conj` | 245 | std | yes | spec: `1/5 ∈ ℤ[U]` over `ℂ` (`(3+4i)/5 + (3−4i)/5 − 1`) | FS89-S0A-1's `ℚ` instance, in miniature |

`Proofs/HadwigerNelson/Instances/SevenUnitRing.lean`, namespace `HadwigerNelson.SevenUnitRing`:

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `inv_two_mem_unitRingOver_seven` | 34 | std | yes | `1/2 = w + w̄ + 2 ∈ ℤ[U_{K(√7)}]`, `w = (−3 + i√7)/4` | FS-47 D5; G55 |
| `three_div_eight_mem_unitRingOver_seven` | 39 | std | yes | `3/8 = 3·(1/2)³ ∈ ℤ[U_{K(√7)}]` — the number J14's conditional theorem consumes; with `G4` and the ring-form chain theorem it gives `χ(K(√7)²) ≥ 5` a second way (a spec `example`) | same |
| **`wall_broken_seven`** | 46 | std | yes | **no conjugation-stable valuation subring of `K(√7)(i)` has 2 in its maximal ideal** — the 2-adic wall broken over `K(√7)`, valuation form | `CLAUDE.md` G35, G43 (K(√7) is 6-open) |

### I.5 FS-87 target 1: the stripe lemma (J16; `Proofs/HadwigerNelson/Stripe.lean`, namespace `HadwigerNelson.Stripe`)

`ℤ × ℤ` is `ℤ[ζ₆]` in the basis `1, ζ₆`; `rim` lists the six units. `Proper c` (line 52): every point differs in colour from its six
neighbours. `NT0 c` (56): no monochromatic √3-triangle (every one is an alternate triple of the wheel at its centroid). `Striped c` (61): the
four colours split into two pairs whose index is affine, `π(c x) = π(c 0) + β x` with `β : ℤ × ℤ →+ ℤ/2`.

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `wheel_all`, `wheelFacts`, `wheel` | 84, 90, 110 | none; `[propext, Quot.sound]`; std | yes | the wheel facts, checked on all `4⁷ = 16,384` colourings of one wheel by `decide +kernel` (a complete enumeration of a set the derivation fixed): a proper wheel with no monochromatic alternate triple is type O or type P along one of three directions, and the two propagation facts | FS85-V2-T5's local lemma; J04's scratch leaf S1 |
| `typeP_zero_add`, `typeP_three_add`, `typeP_line` | 140, 149, 158 | std | no, no, yes | type P along a direction propagates along its line | FS85-V2-T5 |
| `pairOf_step`, `striped_of_line` | 188, 204 | std; `[propext, Quot.sound]` for `pairOf_step` | no, yes | a two-periodic line stripes a proper four-colouring — properness alone (simpler than V2's text) | FS85-V2-T5 |
| `rot_rim`, `proper_comp_rot`, `nt0_comp_rot`, `typeP_comp_rot`, `striped_of_comp_rot` | 289–308 | std | yes | the rotation by `ζ₆` steps the rim and carries properness, NT₀, type P and stripedness | — |
| `striped_of_typeP` | 325 | std | no | a type-P point gives a two-periodic line | FS85-V2-T5 |
| **`striped_of_proper_nt0`** | 336 | std | yes | **the stripe lemma: every proper four-colouring of the triangular lattice with no monochromatic √3-triangle is striped** | `FS85-V2-T5`; `[Parts2020hv]` §3 (human-verified); a step of row 85's chain |
| `proper_modTwo`, `nt0_modTwo` | 390, 400 | std | yes | the hypotheses inhabited: the class mod `2ℤ[ζ₆]` (a bijection `𝔽₄ → Fin 4`) is proper and NT₀ | G70 (the residue colouring is √3-clean) |
| `proper_threeCol`, `not_striped_threeCol` | 416, 429 | std | yes | NT₀ cannot be dropped: `(a + 2b) mod 3` is proper and not striped | — |

### I.6 FS-39 phases B0–B1 and C: the bridge, conditional (J17K)

`Proofs/HadwigerNelson/Bridge.lean`, namespace `HadwigerNelson.Bridge`. **The named hypothesis** `RealAlgebraicDescent` (def, line 51):
"every finite system of polynomial equations with rational coefficients that has a solution in `ℝ` has one whose coordinates are algebraic
over `ℚ`" — **true** (Tarski 1951; equivalently Artin–Lang, Lang 1953) **and unproved here**; every theorem assuming it is suffixed
`_of_descent` and its docstring says "Conditional, and not vacuous" (no `VACUITY DECLARED:` marker: the hypothesis is a true proposition,
not an empty domain; inventory 26). The owner read it (inventory 55).

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `realAlgebraicDescent_one` | 57 | std | yes | control: the hypothesis in one variable, proved (a partial inhabitant) | — |
| `not_rationalDescent` | 80 | std | yes | control: the rational twin ("a real solution has a rational one") is false, by `X₀² − 2` — so a hypothesis of this shape is not automatically consistent | — |
| `RealAlgebraicDescent.of_finite` | 96 | std | yes | the hypothesis for any finite variable type | — |
| `adjoinReal` (def), `numberField_adjoinReal` | 115, 122 | std | — / yes | finitely many real algebraic numbers generate a real number field | `J17-T1` step 3 |
| **`exists_numberField_drawing_of_descent`** | 158 | std | yes | **C1, conditional**: a finite unit-distance drawing in `ℝ²` has a drawing of the same graph with both coordinates of every point in some real number field | `J17-T1` (route T's shape) |
| `iSup_numberField_le_chromaticNumber_plane` | 199 | std | yes | the free half, unconditional: every real number field's plane has `χ ≤ χ(ℝ²)` | `J17-T3` step 1 |
| `chromaticNumber_complex_le_seven`, `iSup_numberField_le_seven`, `nonempty_numberField` | 193, 205, 242 | std | no | `χ(ℝ²) ≤ 7` (row 33), hence the supremum is at most 7; the index is nonempty (`ℚ`) — the two inputs of attainment | row 33 |
| **`chromaticNumber_plane_eq_iSup_numberField_of_descent`** | 236 | std | yes | **C2, conditional: `χ(ℝ²) = sup` over real number fields `F` of `χ(F²)`** | `J17-T3`; `[Madore2015]` ¶5.4 with ¶1.3 |
| `exists_numberField_chromaticNumber_eq_plane_of_descent` | 249 | std | yes | attainment: one real number field has `χ(F²) = χ(ℝ²)` | `J17-T3` |
| `numberField_sup` | 267 | std | yes | the compositum of two real number fields is one | — |
| **`chromaticNumber_plane_ne_six_iff_of_descent`** | 283 | std | yes | **C4, conditional: `χ(ℝ²) ≠ 6` iff every real number field with `χ = 6` lies in a real number field with `χ = 7`** | `J17-T9` = `FS62-T2`; G64 |

`Proofs/HadwigerNelson/RealClosed.lean` (Mathlib style; upstream candidates, Mathlib's own TODO):

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `Polynomial.exists_isRoot_of_odd_natDegree_real` | 52 | std | yes | a real polynomial of odd degree has a real root | — |
| `Real.isRealClosed` (instance) | 71 | std | yes | **B0: `ℝ` is real closed** | — |
| `algebraicClosure.isRealClosed` (instance) | 99 | std | yes | **B0, general: the relative algebraic closure of any field in a real closed field is real closed** (stronger than asked; no order on the closure used) | `J17-T2`, in a stronger form |
| `isRealClosed_algebraicClosure_rat_real` | 121 | std | yes | the real algebraic numbers are real closed | `J17-T2` |
| `IsSumSq.map`, `IsSemireal.of_ringHom` | 35, 42 | `[propext]` | yes | ring homs carry sums of squares; a ring with a ring hom into a semireal ring is semireal | — |

### I.7 FS-39 phase C: Lemma NP and C3 (J17K2; `Proofs/HadwigerNelson/NoParam.lean`, namespace `HadwigerNelson.NoParam`)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `exists_eq_C_mul_sq_of_mul_eq_sq` | 52 | std | yes | in `k[X]`, a factor coprime to its cofactor in a square is a nonzero constant times a square | `J17-T4`'s step |
| `natDegree_eq_zero_of_mul_mul_sub_eq_sq` | 60 | std | yes | NP's polynomial core: `p`, `q` coprime and `p·q·(p² − q²)` a square force `p`, `q` constant (`2 ≠ 0`), through Mathlib's `Polynomial.flt_catalan` at signature `(4, 4, 2)` | `J17-T4` (whose hand proof uses Mason–Stothers directly) |
| `exists_algebraMap_eq_of_sq_eq` | 108 | std | yes | a rational function whose square is a polynomial is a polynomial | — |
| **`not_isSquare_cube_sub_self`** | 114 | std | yes | **Lemma NP over every field with `2 ≠ 0`: for nonconstant `a ∈ k(X)`, `a³ − a` is not a square** | `J17-T4` (stated over `ℂ`) — stronger |
| `not_isSquare_cube_sub_self_of_charZero` | 156 | std | yes | NP in the brief's form (characteristic 0) | same |
| `mem_range_C_of_sq_eq_cube_sub_self` | 138 | std | yes | the curve `y² = x³ − x` has no new points over `k(X)` (both coordinates constant) | — |
| `twin` (def), `twin_not_mem_range_C`, `isSquare_twin_sq_sub_one` | 169, 172, 185 | std | yes | control, the genus-0 twin: `a = (X² + 1)/(2X)` is nonconstant and `a² − 1` is a square. NP's route run on it (`data/m2/j17k2/TwinProbe.lean`, outside the library) fails at exactly one step, `flt_catalan`'s signature inequality at `(2, 2, 1)` (`8 ≤ 4`): red for the genus | — |
| `X_sq_not_mem_range_C`, `isSquare_cube_sub_self_X_sq_zmod_two` | 195, 204 | std | yes | control: NP is false in characteristic 2 — over `𝔽₂`, `(X²)³ − X² = (X(X² + 1))²` | — (correction C-12 to J17's record) |
| `not_mem_adjoinTranscendental_of_sq_eq` | 218 | std | yes | C3's core: for `x ∉ F`, `y² = x³ − x`, `t` transcendental over `F ⊆ ℝ`, not both `x, y ∈ F(t)` | `J17-T5` |
| `transcendental_two_add_liouvilleNumber` | 243 | std | yes | `2 + L` is transcendental over `ℚ` | — |
| **`not_mem_adjoinTranscendental_liouville`** | 255 | std | yes | **C3, one-variable containment form**: for `F ⊆ ℝ` algebraic over `ℚ` and `t` transcendental over `F`, the reals `2 + L` and `√((2 + L)³ − (2 + L))` are not both in `F(t)` (the kernel's `E` uses `2 + L` in place of J17's `π`) | `J17-T5` |
| `sqrt_not_mem_adjoinTranscendental_bot_liouville` | 266 | std | yes | its inhabitant: `√((2 + L)³ − (2 + L)) ∉ ℚ(L)` | — |
| `IsPureTower` (inductive), `mem_of_isPureTower` | 283, 293 | std | — / yes | `L` arises from `K` by finitely many simple transcendental adjunctions inside `Ω`; the curve has no new points in such a tower (`2 ≠ 0`) | — |
| **`not_forall_mem_isPureTower`** | 320 | std | yes | **C3⁺**: no ring hom from a subfield of `ℝ` holding `2 + L` and `√((2 + L)³ − (2 + L))` into a field of characteristic 0 lands in a pure tower over a subfield algebraic over `ℚ` | `J17-T6`, up to the hand reading that `F′(t₁, …, t_m)` is such a tower (§ I.8) |
| `isPureTower_bot_liouville`, `not_forall_mem_adjoinTranscendental_bot_liouville` | 339, 344 | std | yes | inhabitants: `ℚ ⊆ ℚ(L)` is a one-step tower; C3⁺ at `E = ℝ`, `Ω = ℝ` | — |

### I.8 What the kernel does not prove (each product's scope, from the records' read-aloud sections)

| product | not proved in the kernel | where it is held instead |
|---|---|---|
| the chain theorem | G55's vertex bound `m(n − 1) + 1` (the chain's point set is the image of `Fin m × ι`, at most `m·n`; the sharper count is not stated) | G55, hand |
| `ℚ(√2,√3)` | the upper bound `χ(ℚ(√2,√3)²) ≤ 4` (G55's equality); "no Moser spindle in the field" (`√11 ∉ ℚ(√2,√3)`) is a docstring remark; the 18-vertex list's geometry (its edges unit over `ℚ(√2,√3)`) is not checked on the list — the plane bound comes through the chain theorem's own drawing | FS-45's re-aim (stage 4 draft): the dyadic residue colouring |
| `K(√7)` | `G4` itself — one CaDiCaL refusal of the 588-core with no proof log on disk | post-ban (after 2026-10-01): a fresh LRAT fed as its core (row 67's recipe) |
| route C | the value `χ(ℚ²) = 2`, so `χ(ℚ(L)²) = 2` is not a kernel statement (row 63: no real-field instance of the two-colour form); `zeroPlace F` is not claimed equal to Mathlib's `X`-adic valuation subring; no `𝔽₃` instance (`RatFunc (ZMod 3)`'s field instance timed out) | row 63; `plans/M2-S2K-route-c.md` §2.2, §4.4 |
| prime inversion | the number-field reading — "`σ`-stable valuation subrings of `E` with `p` in the maximal ideal ↔ conjugation-stable primes of `𝓞_E` above `p`" — is row 57's gap (Theorem A's), deferred to FS-37; Lemma R (`ℤ[U_F]` is the ring of elements integral at every stable prime) is not prime inversion and is not proved | FS-47's re-aim (stage 4 draft); FS-37 |
| the stripe lemma | its placement in de Grey's lattice (dB9's V1, the next leaf of row 85's chain) | FS-87's re-aim |
| the bridge | `RealAlgebraicDescent` itself, i.e. `(∃T)` for `ℝ_alg ⊆ ℝ`: months (a parametric one-variable elimination and a projection theorem, neither in Mathlib) | FS-39 phase B2 |
| C3 | (i) that an algebraically independent family `t₁, …, t_m` over `F′` is a tower of successive transcendental adjunctions (so `IsPureTower` covers every `F′(t₁, …, t_m)`) — a standard fact, named in the module doc; (ii) C3's own transcendence-degree step, made unnecessary by C3⁺. The kernel's field uses `2 + L`, not `π` (π's transcendence is not in Mathlib) | `plans/M2-S5K-noparam.md` §3.2 |

### I.9 The hand results this register promotes (their `LEDGER.md` § B rows change kernel column; drafted in the plan's §R-close)

| § B id or row | the hand statement | now in the kernel as | how much |
|---|---|---|---|
| `ASTRA-2026-09-14-T1` | a maximal ideal of `ℤ[U]` containing `p` lifts by lying-over to a stable prime above `p` | superseded: `inv_mem_iff_forall_valuationSubring` (Chevalley's domination) does the lifting in valuation form | the valuation form; the prime form is row 57's gap |
| `ASTRA-2026-09-14-T2` | prime inversion, for every real number field and rational prime | `inv_natCast_mem_unitRing_iff`, `inv_natCast_mem_unitRingOver_iff` | valuation form; the number-field reading not |
| `ASTRA-2026-09-14-T5` | the chain theorem | `not_colorable_chain` and its three forms; the ring form `add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver` | in full, less the vertex bound |
| `ASTRA-2026-09-14-T6` | the 18-vertex graph over `ℚ(√2,√3)`, `χ = 4`, no spindle (tools) | `four_le_chromaticNumber_planeOver_two_three`, `eighteen_not_colorable_three`, `eighteen_colorable_four` | the plane's lower bound; the list's `χ = 4`; not the plane's upper bound |
| `ASTRA-2026-09-14-T7` | given `G₄`, every real `F ⊇ K` with the wall broken has `χ ≥ 5` | at `F = K(√7)` only (`five_le_…_of_G4`; the ring-form route with `wall_broken_seven`); the general statement needs prime inversion's number-field form | one instance |
| `ASTRA-2026-09-14-T9` | the eight-copy `K(√7)` witness, given `G₄` | `sum_eightUnits`, `five_le_chromaticNumber_planeOver_seven_of_G4` | the implication; `G4` stays a measurement |
| `FS39-T1` | transcendence is free | `chromaticNumber_unitQuadrance_ratFunc`, `chromaticNumber_planeOver_adjoin_transcendental_eq` | in full at `d = 2`, stronger (any `F` with `−1` a non-square) |
| `FS62-T2` | the exact form of W | `chromaticNumber_plane_ne_six_iff_of_descent` | conditional on `RealAlgebraicDescent` |
| `FS85-V2-T5` | the stripe lemma | `striped_of_proper_nt0` | in full |
| `J17-T2`, `T3`, `T4`, `T5`, `T6`, `T9` | Part II below | § I.6, § I.7 | as each entry's *Kernel:* field says |

## Part II — the theorems M2 proved outside the kernel

*Twelve entries: J04's one hand lemma, one hand observation of J14's, and J17's ten. **None is new mathematics** (J17's own statement,
standing rule 4): the bridge is `[Madore2015]` ¶5.4's; the counterexamples are explicit instances of classical facts. Verification status is
stated per entry: J17V, J17's blind verifier, was declined by the owner (inventory 16); J17K and J17K2 then kernel-checked six of J17's ten,
and J17K2 read J17's Lemma NP proof step by step as a second reader ("sound as written [hand-read]", `plans/M2-S5K-noparam.md` §4.2).*

**J04-H1 — route C's integrality: a unit vector `a² + b² = 1` of a field `K` lies in every valuation subring `B` of `K` with `1 + x² ∉ B.nonunits` for all `x ∈ B`. [hand; J04, one mind; kernel-checked by J15]**
*Proof:* `plans/M2-kernel-lane.md` §4.4 obligation item 3: if `a ∉ B` then `a⁻¹ ∈ 𝔪`; if `b/a ∈ B`, `1 + (b/a)² = (a⁻¹)² ∈ 𝔪`, a
contradiction; otherwise `a/b ∈ 𝔪` and the symmetric case. *Proof verdict:* closes; J15 ported it on the second elaboration (25 lines).
*Rests on it:* route C (`chromaticNumber_unitQuadrance_ratFunc`); J17's C3′ integrality step (J17-T8) is this lemma at a degree-one place.
*Prior art:* **`[Madore2015]` Prop. 3.2's proof, first paragraph** ("if `x₁² + ⋯ + x_d² = 1` with `xᵢ ∈ K`, then in fact `xᵢ ∈ A`",
for any valuation ring `A` whose residue field makes the sum of `d` squares anisotropic; read at the close, p. 6) — J04-H1 is its `d = 2`
case with the residue condition phrased as `1 + x² ∉ 𝔪`; the same argument is `[Fischer1990]` Thm 6's at the place `t = 0`. Not ours. *Kernel:* kernel — `RouteC.mem_valuationSubring_of_sq_add_sq_eq_one`
(`Transcendental.lean:141`), with its colouring form `unitQuadrance_colorable_of_valuationSubring` (line 177).

**J14-H1 — in the 18-vertex, 33-edge graph over `ℚ(√2,√3)`, diamond 1 is redundant: diamonds 2–6 and the edge `3 — 1` already refuse three colours. [hand; J14, one mind; not kernel-checked]**
*Proof:* `plans/M2-S1K-chain.md` §1.0, read off the reference JSON: diamonds 2–6 force vertex 3 (`= δ`) and vertex 1 to one colour along
their junctions, and `3 — 1` is an edge (of diamond 1). *Proof verdict:* closes (a two-line argument; consistent with `ASTRA-2026-09-14-T6`'s
"25 of 33 edges individually critical"). *Rests on it:* the choice of the plant's edge in J14's stage 3 (a critical edge in diamonds 2–6).
*Prior art:* none sought (an observation about one object). *Kernel:* declined — it is about one listed object, and the kernel's two oracles
already certify the graph; a `decide` over the five diamonds would be minutes of work if a consumer appears.

**J17-T1 — C1: every finite unit-distance drawing in `ℝ²` descends to a real number field; the injective and induced forms too. [hand; J17, one mind; two routes]**
*Proof:* `plans/M2-S1D-bridge.md` §2.1 — route T (Tarski: `ℝ_alg ≼ ℝ`, `[Zapletal2022]` Fact 4.2 and Cor. 4.3) and route AL (the Artin–Lang
homomorphism theorem, `[GoelPatilVerma2022]` Thm 3.11, after Lang 1953), each with the injective form (fresh variables `Z_{uv}` inverting the
squared distances; `[GoelPatilVerma2022]` Cor. 3.12). *Proof verdict:* closes on each route, resting on one cited theorem of real algebra;
the two routes are not independent (J17-T10). *Rests on it:* J17-T3, J17-T9; the conditional kernel theorems of § I.6. *Prior art:*
`[Madore2015]` ¶5.4 (by Tarski; the finite-graph statement for real closed `E`), `[BendaPerles2000]` (credited in `[Fischer1990]`'s
introduction; unread). *Kernel:* kernel, **conditional** — `Bridge.exists_numberField_drawing_of_descent` proves C1 from
`RealAlgebraicDescent`, which is route T's `(∃T)` for `ℝ_alg ⊆ ℝ`; the hypothesis itself is FS-39 phase B2 (months).

**J17-T2 — the real algebraic numbers form a real closed field. [hand; J17, one mind; classical]**
*Proof:* `plans/M2-S1D-bridge.md` §2.0 (RC): square roots of positives and roots of odd-degree polynomials are algebraic; the standard
characterisation (BCR §1.2, by section). *Proof verdict:* closes. *Rests on it:* J17-T1 (both routes need a real closed base). *Prior art:*
classical; Mathlib's `FieldTheory/IsRealClosed/Basic.lean` lists it as a TODO. *Kernel:* kernel, **stronger** —
`algebraicClosure.isRealClosed` (any relative algebraic closure in a real closed field) and `isRealClosed_algebraicClosure_rat_real`, with
`Real.isRealClosed` (`RealClosed.lean:71, 99, 121`; J17K). Upstream candidates.

**J17-T3 — C2: `χ(ℝ²) = max` over real number fields `F` of `χ(F²)`; the supremum is attained. [hand; J17, one mind; from J17-T1 and de Bruijn–Erdős]**
*Proof:* `plans/M2-S1D-bridge.md` §2.2: the lower half by inclusion and `χ(ℝ²) ≤ 7` (row 33), so the supremum is a maximum; the upper half by
(dBE) and C1. *Proof verdict:* closes; the only choice-dependent step is (dBE). *Rests on it:* J17-T9; every "`χ(ℝ²) = …`" sentence of the
conjecture's bold form (G48). *Prior art:* **`[Madore2015]` ¶5.4 with ¶1.3** (he proves `χ(ℝ^d) = χ(ℝ_alg^d)`; the step to number fields is
one line he does not write); asserted without proof in `[Soifer2024]` ch. 11 (Open Problem 11.1's comment); with a false step in
`[Fischer1990]` Remark 1. *Kernel:* kernel, **conditional on `RealAlgebraicDescent`** —
`Bridge.chromaticNumber_plane_eq_iSup_numberField_of_descent` and `exists_numberField_chromaticNumber_eq_plane_of_descent`; the free half
`iSup_numberField_le_chromaticNumber_plane` is unconditional.

**J17-T4 — Lemma NP: no nonconstant `a ∈ ℂ(t)` has `a³ − a` a square in `ℂ(t)`. [hand; J17, one mind; hand-read sound by J17K2; kernel-checked by J17K2 by another route]**
*Proof:* `plans/M2-S1D-bridge.md` §2.3 (the four coprime factors are squares; `α⁴ = β⁴ + (γδ)²` against Mason–Stothers, Snyder's proof
included). *Proof verdict:* closes; its "(characteristic 0)" is characteristic ≠ 2 and its algebraically closed base is not needed (§R-close
correction C-12). *Rests on it:* J17-T5, J17-T6. *Prior art:* the elliptic curve `y² = x³ − x` has genus 1, so no rational parametrisation —
classical; Mason–Stothers (Stothers 1981, Mason 1984), the proof N. Snyder, "An alternate proof of Mason's theorem", *Elem. Math.* 55 (2000)
93–94 (Zbl 1031.11012, checked at the close). *Kernel:* kernel, **stronger** — `NoParam.not_isSquare_cube_sub_self`, over every field with
`2 ≠ 0`, through Mathlib's `Polynomial.flt_catalan` at `(4, 4, 2)`; false in characteristic 2 (kernel control).

**J17-T5 — C3: `ℚ(π, √(π³ − π))` is not purely transcendental over any number field (any real transcendental `x > 1` in place of `π`). [hand; J17, one mind; kernel-checked by J17K2 in its containment form]**
*Proof:* `plans/M2-S1D-bridge.md` §2.3: a purely transcendental form would be `F(t)` (transcendence degree 1) and give a nonconstant
point of `y² = x³ − x` over `F(t)`, against J17-T4. *Proof verdict:* closes. *Rests on it:* the claim "`[Fischer1990]` Remark 1's first
sentence is false" (C3). *Prior art:* the refutation of Remark 1's sentence is ours only as a write-up (G63 named "a function field of positive
genus" as the counterexample's kind). *Kernel:* kernel in the **one-variable containment form**, with `2 + L` for `π`:
`NoParam.not_mem_adjoinTranscendental_liouville`; its transcendence-degree step is made unnecessary by J17-T6's kernel form.

**J17-T6 — C3⁺: `ℚ(π, √(π³ − π))` embeds in no purely transcendental extension `F′(t₁, …, t_m)` of any number field `F′`. [hand; J17, one mind; kernel-checked by J17K2 by another route]**
*Proof:* `plans/M2-S1D-bridge.md` §2.3: restrict an embedding to a generic line, against J17-T4. *Proof verdict:* closes; J17K2's kernel
proof replaces the restriction by an induction on the tower (NP over every field with `2 ≠ 0` makes each step free). *Rests on it:* the
reading that no repair of Remark 1 by `[Fischer1990]`'s own tools reaches this field. *Prior art:* as J17-T5. *Kernel:* kernel —
`NoParam.not_forall_mem_isPureTower`, **up to one hand reading**: an algebraically independent family over `F′` is a tower of simple
transcendental adjunctions (`IsPureTower`).

**J17-T7 — `ℚ(π/2, √(3 − π²/4))` (a conic with no rational point) is not purely transcendental over any number field, but lies in `ℚ(√2)(s)`. [hand; J17, one mind]**
*Proof:* `plans/M2-S1D-bridge.md` §2.3, "A genus-0 counterexample too": its constant field is `ℚ`, and `p² + q² = 3` has no solution in
`ℚ(t)` (specialise at a rational point: 3 is not a sum of two rational squares); the conic has the point `(1, √2)`, so it is rational over
`ℚ(√2)`. *Proof verdict:* closes. *Rests on it:* the observation that a genus-0 counterexample to Remark 1 does not defeat Fischer's method
(`χ(E₀²) ≤ χ(ℚ(√2)²) = 2` by `[Fischer1990]` Thm 6), so the robust counterexample is J17-T5's. *Prior art:* classical (3 is not a sum of
two rational squares). *Kernel:* declined — an elementary aside, no consumer.

**J17-T8 — C3′: `χ(ℚ(π, √(π³ − π))²) = 2`. [hand; J17, one mind]**
*Proof:* `plans/M2-S1D-bridge.md` §2.3: the curve is smooth at `(0, 0)`, its local ring there is a discrete valuation ring with residue
field `ℚ`, every unit vector lies in it (J04-H1's argument: a pole would need `−1` a square in `ℚ`), and reduction plus a coset section
colours the plane from `χ(ℚ²) = 2` (Woodall). *Proof verdict:* closes. *Rests on it:* the observation that on this field Fischer's second
sentence ("`E^d` can be `k`-colored iff `F^d` can") holds with `F = ℚ` although his first is false; Q-const (surfaced, §R-close stage 3).
*Prior art:* an instance of `[Madore2015]` Prop. 3.2 at a degree-one place. *Kernel:* declined for now — the colouring step is
`RouteC.unitQuadrance_colorable_of_valuationSubring` once the curve's local ring is built in Lean (a stub line under FS-39), and the value 2
needs `χ(ℚ²) = 2` in the kernel (row 63's missing instance).

**J17-T9 — C4: `χ(ℝ²) ≠ 6` iff every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with `χ(F′²) = 7`. [derived; J17, one mind; from J17-T3's attainment and `χ(ℝ²) ≤ 7`]**
*Proof:* `plans/M2-S1D-bridge.md` §2.4 (both directions use attainment, which FS62-T2 left implicit). *Proof verdict:* closes.
*Rests on it:* G64's exact form of W. *Prior art:* `FS62-T2` (the same statement, this project's, derived earlier without the attainment step);
it restates Hadwiger–Nelson's top rung rather than reducing it. *Kernel:* kernel, **conditional on `RealAlgebraicDescent`** —
`Bridge.chromaticNumber_plane_ne_six_iff_of_descent`.

**J17-T10 — the equational existential fragment of Tarski, `(∃T)`, and the Artin–Lang homomorphism theorem are interderivable in a few lines. [hand; J17, one mind; classical]**
*Proof:* `plans/M2-S1D-bridge.md` §2.1, "The two routes are not independent": `(∃T) ⟹ AL` through an ordering of `Frac A` (Artin–Schreier)
and its real closure; `AL ⟹ (∃T)` (for `R′ ⊆ ℝ`) is route AL. *Proof verdict:* closes, citing Artin–Schreier and the existence of real
closures. *Rests on it:* the price ranking — route T is the cheaper kernel route, and P-J17b ("the Artin–Lang route's kernel price is judged
lower") scored FALSE. *Prior art:* classical (BCR ch. 4 derives Artin–Lang from Tarski–Seidenberg, by its chapter order — not read).
*Kernel:* declined — the kernel route to the unconditional bridge is `(∃T)` directly (FS-39 phase B2), and this lemma only prices it.
