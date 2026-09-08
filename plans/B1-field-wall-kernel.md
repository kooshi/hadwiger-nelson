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
