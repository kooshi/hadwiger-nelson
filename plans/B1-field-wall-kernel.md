# B1 — Theorem B in the kernel: χ(ℚ(√3,√11)²) = 4 (subplan)

*Backlog item B1 (`plans/BACKLOG-FOR-OPUS.md`), against the stub `plans/STUB-field-wall-kernel.md`.
Written 2026-09-07 on the desktop (32 cores, 125 GB); baseline `./scripts/build.sh` green in 3 m 20 s
before any edit. The record of what landed goes into the stub as `## §B. Built`.*

## 0. What is to be proved

`K = ℚ(√3, √11) ⊂ ℝ`; `K²` is the set of complex numbers with both coordinates in `K`. The claim
(`plans/FIELD-WALL-THEOREM.md` §5, Theorem B, hand-proved, not yet kernel-checked):

> every unit-distance graph drawn in `K²` is properly 4-colourable, and the Moser spindle shows four
> is needed — so `χ(G(K²)) = 4`.

Deliverable: `Proofs/HadwigerNelson/FieldWall4.lean`, on axioms exactly
`[propext, Classical.choice, Quot.sound]`, carrying

```lean
theorem four_colorable_of_seam_field : ((unitDistance ℂ).induce seamPlane).Colorable 4
theorem chromaticNumber_seamPlane : ((unitDistance ℂ).induce seamPlane).chromaticNumber = 4
```

plus the finite-graph corollary the stub states (`colorable_four_of_coords_in_seamField`).

## 1. The proof shape actually adopted, and how it differs from the stub's §2

The stub routed through `R_P`, `IsDiscreteValuationRing.TFAE` and `ValuationRing`: localize the order
at the prime above 2, prove the local ring is a DVR, hence a valuation ring, hence every unit vector
or its inverse is integral. That is the mathematician's route and it costs the whole Noetherian /
localization / DVR stack (the stub priced the TFAE hypotheses alone at ~150 lines, and flagged
`AdjoinRoot` over ℤ as a named risk).

**None of it is needed.** Working the arithmetic by hand for this subplan found a descent that
replaces the valuation theory with one parity computation:

* Let `O = ℤ[ω, i, T]` with `ω = ζ₃ = (−1+i√3)/2`, `T = (1+√33)/2` — a free ℤ-module of rank 8 on
  the basis `{1, ω} × {1, i} × {1, T}`, and (this is what matters) **maximal at 2**.
* There are two ring homomorphisms `ψ₁, ψ₂ : O → 𝔽₄`, both sending `ω ↦ Ω`, `i ↦ 1`, and `T ↦ 0`
  resp. `T ↦ 1`. They exist because `Ω² + Ω + 1 = 0`, `1² = −1` in characteristic 2, and
  `t² − t − 8 = 0` for `t ∈ {0, 1}` in characteristic 2. These are the two primes above 2.
* **The descent, in coordinates.** Write `z ∈ O` as `z = p + q·i` with `p, q ∈ ℤ[ω, T]`. Then
  `ψ₁(z) = ψ₁(p) + ψ₁(q)` and `ψ₂(z) = ψ₂(p) + ψ₂(q)`, so `ψ₁(z) = ψ₂(z) = 0` says exactly that
  `p ≡ q` in all four coordinates mod 2 — and then `z/(1+i) = (p+q)/2 + ((q−p)/2)·i` has integer
  coordinates. **No ideal, no localization, no valuation: the joint kernel of the two residue maps is
  visibly `(1+i)O`, by halving.**
* **Conjugation** is a coordinate operation (`ω ↦ −1−ω`, `i ↦ −i`, `T ↦ T`) and satisfies the
  Frobenius relation `ψ(z̄) = ψ(z)²` — the whole content of the stub's step 3 (`c(𝔭ⱼ) = 𝔭ⱼ`), as a
  four-line computation over `ZMod 2`.
* **Unit vectors.** If `u ū = 1` and `n·u ∈ O` for a positive integer `n`, then the odd part of `n`
  already suffices. Induction on `n`: with `z = n·u` we get `z z̄ = n²`; if `n` is even then
  `ψ_j(z)·ψ_j(z̄) = ψ_j(n²) = 0` and `ψ_j(z̄) = ψ_j(z)²`, so `ψ_j(z)³ = 0`, so `ψ_j(z) = 0` (𝔽₄ is a
  field) for both `j`; two descents give `z = 2i·v`, hence `(n/2)·u ∈ O`. So every unit vector of `L`
  lies in `A := O[1/odd]`, on which `ψ₁` descends (`ψ₁(odd) = 1`), and there `ψ₁(u)·ψ₁(ū) = 1`, so
  `ψ₁(u) ≠ 0`.
* **The colouring.** `A` is an additive subgroup of `ℂ`; every unit step stays inside one coset of
  `A`; choose a representative per coset (`Quotient.out`, i.e. `Classical.choice`) and colour
  `z ↦ ψ₁(z − rep(z + A))`. Adjacent points differ by a unit vector, whose residue is nonzero, so the
  colours differ. Four colours, no finiteness hypothesis — the whole plane `K²` at once.

Why `O` and not something smaller: `ρ = (5+i√11)/6`, the Moser twist, equals
`(7 − ω + T + 2ωT)/9`, so it lies in `O[1/9]` — but **not** in `ℤ[ζ₁₂, √33][1/odd]`, whose
coordinates it needs to halve. `T = (1+√33)/2` is exactly what makes the order 2-maximal, and the
descent fails without it (`1 + √33 = 2T` is the witness: it satisfies the hypothesis and not the
conclusion in the smaller ring).

Why 𝔽₄ and not ℤ/4 or 𝔽₂[ε]: `Φ₁₂` has no root in either (checked by hand; `x⁴−x²+1 ≡ 1` on
`ZMod 4` and `(x²+x+1)² ≡ 1` on `𝔽₂[ε]`), so 𝔽₄ is forced.

## 2. Module layout

One new module, `Proofs/HadwigerNelson/FieldWall4.lean`, importing `Ladder` (for
`Ladder.sqrt_indep`, the ℚ-independence of `1, √3, √11, √33`) and `Instances.SpindleBound` (for
`moserSpindle_not_colorable_three`, proved by `decide +kernel` — route A, no native purchase). One
line added to `Proofs.lean`; entries added to `scripts/Axioms.lean` CLEAN section. **No existing
module is edited**, so no certificate rebuilds.

| § | content | est. |
|---|---|---|
| §1 | `F4` — the four-element field as `structure F4 where u v : ZMod 2`, `CommRing` by `decide`, `emb : ZMod 2 →+* F4`, integer casts, `x³ = 0 → x = 0`, `card = 4` | 90 |
| §2 | `Eis` / `EisT` / `Ord` — three two-dimensional layers with `add`, `neg`, `mul`, `conj`, `intMul`, `ofInt`; `den` into `ℂ` and its ring lemmas; `psi t` into `F4` and its ring lemmas; Frobenius | 260 |
| §3 | `den` injective, through `Ladder.sqrt_indep` on real and imaginary parts | 90 |
| §4 | the descent: `psi 0 z = 0 → psi 1 z = 0 → ∃ w, w * (1+i) = z` | 70 |
| §5 | `seamField : Subfield ℝ`, `seamPlane : Set ℂ`, denominator clearing | 130 |
| §6 | unit vectors lie in `A`; `A : AddSubgroup ℂ`; `psiOf : ℂ → F4` | 140 |
| §7 | the colouring; `four_colorable_of_seam_field`; the `Finset` corollary | 90 |
| §8 | the Moser spindle in `K²`; `chromaticNumber_seamPlane = 4` | 110 |
| §9 | spec examples (the stub's §6) | 90 |
| | | **~1070** |

## 3. Decisions

| # | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| D1 | descent by parity in coordinates | the stub's DVR/`ValuationRing` route | removes the entire localization + DVR stack and the `AdjoinRoot`-over-ℤ risk the stub named; the joint kernel of the two residue maps is *visibly* `(1+i)O` once the basis is `{1,ω}×{1,i}×{1,T}` | high — the halving identity is checked by hand and by the `ρ` and `2T` examples |
| D2 | `O` as three stacked 2-dimensional structures (`Eis`, `EisT`, `Ord`) | one flat 8-coordinate structure; `AdjoinRoot` twice; the repo's `Adjoin` tower | each layer's `den`/`psi` multiplicativity is one `linear_combination` against one relation; flat would need a 64-term product identity, `AdjoinRoot` is a quotient the kernel cannot reduce, and the repo's `Adjoin` only does `√d` | high |
| D3 | `F4` as `structure F4 where u v : ZMod 2` with `CommRing` by `decide` | `GaloisField 2 2` | `u + vΩ = 0 → u = 0 ∧ v = 0` becomes `rfl`-level, and every 𝔽₄ fact is a 4- or 16-case `decide`; probed and working | high |
| D4 | state the theorem for the **whole plane** `K²`, not just finite graphs | the stub's `Finset` form | the coset colouring needs no finiteness; the `Finset` form is a two-line corollary and is also shipped | high |
| D5 | `seamField` as a `Subfield ℝ` whose carrier is the explicit ℚ-span | a bare `Set` + a docstring claim | the theorem's honesty rests on "this really is ℚ(√3,√11)"; `inv_mem` is the four-conjugate norm identity | medium — if `inv_mem` fights, ship `Subring` and say in the docstring that the field property is not proved here (recorded, not hidden) |
| D6 | reuse `moserSpindle_not_colorable_three` | re-`decide` a 7-vertex edge list here | one non-colourability fact for one graph; the imported proof is route A, standard three axioms | high |

## 4. Registered predictions (scored at the close)

* **P1** The module lands on axioms exactly `[propext, Classical.choice, Quot.sound]`.
* **P2** The descent lemma (§4) needs no `decide` over `(ZMod 2)^8`: it is four applications of one
  parity fact. *If it does need a 256-case `decide`, that is a modelling miss and is recorded.*
* **P3** `den` injectivity is the largest single obligation after the layer arithmetic, and closes
  through `Ladder.sqrt_indep` twice with no new independence lemma.
* **P4** The seven Moser-spindle residues under `ψ₁` are `0, Ω², Ω, 1, Ω, 1, Ω²` and use all four
  colours. *Derived by hand in the subplan; a disagreement means the residue map is wrong.*
* **P5** Total ≤ 1200 lines and no `sorry`.
* **P6** Elaboration of the new module under 60 s.

## 5. Stop rules

* If `Subfield` (D5) is not closed in ~120 lines, downgrade to `Subring` and record it.
* If the layer arithmetic's `linear_combination` witnesses resist, derive them with sympy and verify
  a zero residual before stating them (the house rule, `CLAUDE.md` ledger row 28).
* Any unexplained process crash: HALT and report.

---

## 6. Domain-modeling pass (2026-09-07)

Nine changes; the skeleton is rewritten to match. Two are structural, one is a real find.

**M1 — `Quad` has a universal property, and it is the recursor every compatibility lemma wants.**
The skeleton carried two generic Frobenius lemmas with six arguments each
(`lift_conjSwap_sq`, `lift_conjBase_sq`) — plumbing, because the *statement* they proved is
`ψ ∘ conj = Frobenius ∘ ψ`, an equality of ring homomorphisms. `Quad b c R` is generated by its base
and by `θ = ⟨0, 1⟩` (`x = incl x.re + incl x.im * θ`, one `rfl`-adjacent identity), so two ring homs
out of it agree as soon as they agree on the base and on `θ`. Adding `Quad.incl`, `Quad.theta`,
`Quad.decomp` and **`Quad.hom_ext`** turns every layer-compatibility fact into two generator checks,
and makes the three-layer recursion visible rather than re-derived. Both six-argument lemmas are
deleted.

**M2 — Frobenius is a ring homomorphism, so name it.** `F4.sq : F4 →+* F4` with `map_add'` by
`decide` (characteristic two). Then `psi_conj` is `(psi s).comp conj = F4.sq.comp (psi s)` and closes
by `hom_ext`. Mathlib's `frobenius` would do it too and costs an `ExpChar F4 2` instance hunt for a
map whose additivity is a four-case `decide`.

**M3 — one residue map, not two layers of one.** `psiET` and `psiO` collapse into
`psi (s : F4) (hs) : SeamOrder →+* F4`; `psiZero`, `psiOne` are its two instances at the two
idempotents.

**M4 — name the role, not the two copies.** `psi_eq_zero_of_even_norm` returned a conjunction about
`psiZero` and `psiOne`. It is one lemma about *any* residue map compatible with conjugation:
`eq_zero_of_even_norm {f : SeamOrder →+* F4} (hf : ∀ x, f (conj x) = f x * f x) …`, applied twice.

**M5 — one spelling of one predicate.** The skeleton spelled the membership existential two ways
(`Aodd`'s carrier and `psiOf`'s `dif` condition, with the quantifiers in opposite orders). One
predicate `IsAodd`, used by both. And `Aodd` becomes a **`Subring ℂ`**: it is one, the two extra
lines are free, and `psiOf` then has a `map_mul` the spec examples want.

**M6 — the span is the primitive, the field is the meaning.** `seamSpan : Set ℝ` (the ℚ-span of
`1, √3, √11, √33`) carries the proof; `seamField : Subfield ℝ` is a separate declaration with
`seamField_carrier` tying it to the span, and `mem_seamPlane_iff` is the bridge the reader reads.
If `inv_mem'` were to fight (D5's stop rule) only the bundling is lost, not the theorem — the
placement cut, applied: the field structure is what makes the *name* true and no consumer needs it.

**M7 — the find: the Moser spindle is an identity in the order, not a computation in `ℝ`.**
`ζ₆ = 1 + ω`, `ζ₃ = ω`, `i√3 = 1 + 2ω` and `9ρ = 7 − ω + T + 2ωT`, so all seven spindle points are
`den x / 9` for explicit `x : SeamOrder`. Since `den` is a ring hom and `den (conj u) = star (den u)`,
`normSq (den u) = den (u * conj u)`, and **each of the eleven unit distances becomes the single
identity `(xᵢ − xⱼ) * conj (xᵢ − xⱼ) = 81` in the order — eight integers, `decide`.** No
`Real.sqrt` manipulation anywhere in §8, and the residue table of the spec examples falls out by
`decide` on the same objects. `spindleOrd : Fin 7 → SeamOrder` is therefore the primitive and
`spindlePt` is derived.

**M8 / M9 — computation hygiene.** Pin `natCast`/`intCast` in `F4`'s `CommRing` (the defaults are
unary, and `decide` casts `81`); `deriving DecidableEq` on `Quad`.

**Seams validated.** Non-vacuity is the `le_antisymm` itself (an empty graph has chromatic number
`0`, so `= 4` cannot hold vacuously) with the spindle as the explicit model of the hypotheses. The
unsampled member `1/2 ∈ seamSpan \ A` shows the coset machinery is not dead code. The adversarial
member is the stub's planted red — `colour 0 = colour 2` at distance 2 — kept as a spec example. The
predicted next lemma ("every pair at a distance of positive 𝔭-adic valuation is monochromatic")
states in one line over this model, which is the convergence signal; the predicted generalisation
(other fields) does not, and is explicitly out of scope.

## 7. Obligation-modeling pass (2026-09-07)

The 116 leaves partition into ~55 routine layer/ring axioms (`ext` + `simp` + `ring`, or `decide`),
~10 `decide`-scale `F4` facts, and six obligations that need a designed decomposition. Those six:

**O1 — the descent (`mem_Aodd_of_unit`), strong induction on the denominator.** The statement as
skeletonized cannot carry itself: the induction is on `n`, not on `u`, so the auxiliary statement
quantifies the denominator and the order element:

```lean
∀ n : ℕ, 0 < n → ∀ (u : ℂ) (x : SeamOrder), u * star u = 1 → (n : ℂ) * u = den x → IsAodd u
```

by `Nat.strong_induction_on`, measure `n`. Odd `n`: done. Even `n = 2k`: nine local steps, and the
key one moved **entirely inside the order** — `2 = onePlusI * conj onePlusI` is a `decide`, so
`2 * (w * conj w) = x * conj x` is ring algebra with no `ℂ` division anywhere:

1. `x * conj x = ((n^2 : ℤ) : SeamOrder)` (`den_injective`, `den_conj`, `map_intCast`);
2. `psiZero x = psiOne x = 0` (`eq_zero_of_even_norm`, `n²` even);
3. `w * onePlusI = x`;
4. `2 * (w * conj w) = x * conj x` from `onePlusI * conj onePlusI = 2`;
5. `w * conj w = ((2k² : ℤ) : SeamOrder)` by cancelling `2` (`two_mul_cancel`, one line through
   `den_injective` and `ℂ` being a field);
6–7. second descent: `v * onePlusI = w`, so `x = v * (2 * θ)` (`onePlusI * onePlusI = 2 * θ`,
   `decide`);
8. hence `(k : ℂ) * u = den (θ * v)`; 9. IH at `k < n`.

Consequence for §6: **`exists_int_mul_mem_range` is restated over `ℕ` with `0 < n`**, so the
induction has no sign case.

**O2 — the parity argument (`exists_mul_onePlusI`), and it needs no `decide` (P2).**
`psi s` unfolds to `psiE z.re.re + psiE z.re.im * s + psiE z.im.re + psiE z.im.im * s`, so
`psiZero z = 0` says `psiE z.re.re = psiE z.im.re` and, with `psiOne z = 0`,
`psiE z.re.im = psiE z.im.im` (characteristic two turns `a + b = 0` into `a = b`). The chain is
three small lemmas:

* `psiE_eq_iff : psiE p = psiE q ↔ (2:ℤ) ∣ (p.re − q.re) ∧ (2:ℤ) ∣ (p.im − q.im)`
  (`F4.ext_iff` + `ZMod.intCast_zmod_eq_zero_iff_dvd`);
* `exists_half {p q : Eis} (h : psiE p = psiE q) : ∃ a, p + q = 2 * a`, and its `EisT` twin;
* the witness is then explicit and needs no cancellation: with `p + q = 2A`,
  `w := ⟨A, A − p⟩` gives `w * onePlusI = ⟨A − (A − p), A + (A − p)⟩ = ⟨p, 2A − p⟩ = ⟨p, q⟩`.

**O3 — `den_injective`, flat rather than layered.** The layered route needs three separate
irrationality facts (`√33 ∉ ℚ(√−3)`, `i ∉ ℚ(ω, T)`) and the top layer is not a real/imaginary split
at all. Flat: two lemmas

```lean
den_re : (den x).re = (a − b/2 + e/2 − f/4) + (−d/2 − h/4)·√3 + (−3h/4)·√11 + (e/2 − f/4)·√33
den_im : (den x).im = (c − d/2 + g/2 − h/4) + (b/2 + f/4)·√3 + (3f/4)·√11 + (g/2 − h/4)·√33
```

(`a … h` the eight integer coordinates), two applications of `Ladder.sqrt_indep`, then
`h = f = 0 → d = b = 0 → e = g = 0 → a = c = 0` by `linarith`. **The same two lemmas are the whole
proof of `den_mem_seamPlane`** — one statement, two consumers, which is the convergence signal.

**O4 — `seamField.inv_mem'` in two quadratic steps, not one quartic identity.** With
`x = a + b√3 + c√11 + d√33` and its three sign-conjugates,
`x·x₁ = P + Q√33` and `x₂·x₃ = P − Q√33` with `P = a² + 33d² − 3b² − 11c²`, `Q = 2ad − 2bc`, so
`N = P² − 33Q² ∈ ℚ`; `N ≠ 0` because each conjugate is nonzero by `Ladder.sqrt_indep` on a
sign-flipped coefficient tuple. Two quadratic `linear_combination`s replace a degree-four one.

**O5 — denominator clearing from four `den` evaluations, not eight.** `den 1`, `den θ = i`,
`den w = ω`, `den tt = T` are definitional; `1 + 2ω = i√3` and `2T − 1 = √33` are two three-line
`Complex.ext` computations; the eight generators of the ℚ-span are then ring expressions in those,
with denominators `1, 1, 3, 1, 1, 1, 3, 1`. `Cl` closed under `+` and under multiplication by a
rational finishes it.

**O6 — the colouring is one proof, stated at its general form.**
`colorable_four_of_subset_seamPlane` is the primitive (build `Coloring.mk` on the subtype directly);
`four_colorable_of_seam_field` is it at `S = seamPlane`. `sub_base_mem` is `Quotient.out_eq` +
`QuotientAddGroup.eq`; `colour_ne_of_unit` is `psiOf_sub` on the two `A`-members plus
`psiOf_ne_zero_of_unit`.

**Two skeleton repairs the pass found.** `psiZero`/`psiOne` were defined with `by sorry` inline — a
*definition* depending on a proof term; the two idempotence facts are restored as named `decide`
lemmas. And `spindleOrd_norm` is stated over all `i j` so it closes by one `decide` over the 49
pairs rather than eleven cases.

**Partition.** *Prove*: the above. *Test* (`#guard`/`example`, no axioms): the spindle residue
table and its eleven-edge properness, the residues of `ζ₆, ρ, σ, τ₅`, the planted red at distance 2,
`den_rho9 = 9·moserTwist` as the pin on `rho9`. *Assume*: nothing — no exported hypothesis.

**Mutation audit for the close**: drop `Odd m` from `psiOf_eq`; put `80` in `spindleOrd_norm`;
weaken `Colorable 4` to `Colorable 3`. Each must break.

## 8. Experience-modeling pass (2026-09-07)

The consumers are three: a future milestone of this repository, a human reading beside
`plans/FIELD-WALL-THEOREM.md`, and the automation (`simp`, `exact?`). What each holds at the moment
of use decided the following.

**E1 — export the consequences the record actually cites, not only the headline.** The reason this
theorem matters here is not "`K²` is 4-colourable"; it is the two sentences the Frontier quotes:
*no `K`-point unit-distance graph carries a pair compulsion at five colours* (the sentence that
halted M53) and *every distance of positive 𝔭-adic valuation is monochromatic in this colouring*.
Both are short over the finished statement and both are added:

* `not_forces_five_seamPlane` / `not_separated_five_seamPlane` — two lines through
  `SpareColour.not_forces_of_colorable` at `k = 4` (a new import, `SpareColour.lean`, small);
* **`residueColouring_eq_of_dist_two`** — a *theorem*, not a spec example: a pair at distance `2`
  is `2 ·` a unit vector, so its residue is `0` in characteristic two and the two points get the
  same colour. It is the honest form of the stub's §6 planted red ("a version of Theorem B for the
  `{1,2}`-graph would be false") and it is what makes Exoo–Ismailescu's 6-chromatic `{1,2}`-graph
  consistent with this theorem.

**E2 — design the membership path, because that is where a user gets stuck.** Every consumer must
first prove `z ∈ seamPlane`. Shipped: `mem_seamPlane_iff` (in `seamField` terms), `mem_seamField_iff`
(the explicit ℚ-span, `Iff.rfl`), and the generators `sqrt3_mem`, `sqrt11_mem`, `sqrt33_mem` — after
which the whole `Subfield` API (`add_mem`, `mul_mem`, `inv_mem`, `ratCast_mem`) is the user's, for
free. A worked `example` certifying one point is shipped in the spec section; it is the highest-value
piece of documentation in the file.

**E3 — the note's residue table and ours differ, and the file says why.** `FIELD-WALL-THEOREM.md`
§5.3 lists `ζ₆ ↦ ω², ρ ↦ ω, σ ↦ ω², τ₅ ↦ ω²`. Our `psiZero` (`T ↦ 0`) gives
`ζ₆ ↦ Ω², ρ ↦ Ω², σ ↦ Ω², τ₅ ↦ Ω`. The two tables are the **two different primes above 2**: the
note fixes the 2-adic embedding by `√33 ↦ s ≡ 17 (mod 256)`, so its `T = (1+s)/2 ≡ 9 ≡ 1`, i.e. its
prime is our `psiOne`. Recorded in the module docstring, because a reader comparing tables would
otherwise conclude one of them is wrong.

**E4 — names.** `Aodd → oddDenom` (a subring of points with an odd denominator over the order),
`IsAodd → IsOddDenom`; the one-letter `w`, `tt` (which would shadow local variables in this very
file) → `ordOmega`, `ordTau`, `ordI`; `colour → residueColouring` and
`colour_ne_of_unit → residueColouring_ne_of_dist_one` (the old name advertised a hypothesis the
statement does not take). `four_colorable_of_seam_field` is kept as the backlog names it and is the
headline; `colorable_four_of_subset_seamPlane` is the general form it instantiates.
`export FieldWall4 (seamSpan seamField seamPlane residueColouring)` so a consumer writes
`seamPlane`, not `FieldWall4.seamPlane` — the skeleton's `abbrev seamField := FieldWall4.seamField`
was two names for one object, the boundary's version of the two-costumes smell.

**E5 — the `@[simp]` budget.** Every tag stays inside `Quad` (component projections, `lift_apply`,
`conj*_apply`) — no other type in the repository is a `Quad`, so the set taxes nothing outside this
file. `mem_seamPlane_iff` and `mem_seamField_iff` are deliberately **not** tagged: they are `Iff.rfl`
and tagging them would drive every membership goal into raw existentials, which is the opposite of
the path E2 designs.


---

## 9. Results (2026-09-08)

Landed; the record is `plans/STUB-field-wall-kernel.md` §B. Gate green (build, lint, axioms), zero
`sorry`, 1,403 lines, axioms exactly the standard three on all fifteen registered declarations.
Predictions: P1, P2, P3, P4, P6 met; **P5 missed by 17 %** (1,403 lines against ≤ 1,200 registered —
the `Subfield` and the spec section are the overrun). No stop rule fired. Two corrections the kernel
forced are recorded in §B: the `√11·√33 = 11√3` coefficient, and the two-primes reconciliation of the
write-up's residue table with this file's.
