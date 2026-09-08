import Proofs.HadwigerNelson.Additive
import Proofs.HadwigerNelson.UnitQuadrance
import Mathlib.RingTheory.Valuation.ValuationSubring

/-!
# The residue colouring — Theorem A

Colour a point by its residue modulo a prime. That is Woodall's two-colouring of the rational plane
(1973), Fischer's additive colourings (1990), and Theorem B of `plans/FIELD-WALL-THEOREM.md` — and
this file is the argument they share, with the number theory removed until only what the proof uses
is left.

**The theorem.** A graph *drawn* in an abelian group, all of whose edge differences lie in a
subgroup `A` and are nonzero under a homomorphism `ψ : A →+ G`, is `|G|`-colourable
(`colorable_of_residue`). Choose one representative per coset of `A`; colour a point by `ψ` of its
offset from its own representative. Adjacent points differ by an element of `A`, so they share a
representative, so their colours differ by `ψ` of the edge difference, which is nonzero. There is no
metric, no field, no ring and no Cayley structure in that statement — the edge set need not even be
translation-invariant.

The arithmetic enters only as sufficient conditions for the two hypotheses, in three layers:

1. **Nonzero residues — the unit layer.** A norm-one element `u` of a subring `A` stable under
   `σ : L →+* L` (that is, `u · σu = 1`) is a *unit of `A`*, because `σu` is its inverse and lies in
   `A`; so its image under any ring homomorphism to a nontrivial ring is nonzero
   (`isUnit_of_mem_normOne`, `map_ne_zero_of_mem_normOne`). That is the whole role of the norm-one
   condition — `Nontrivial G` is what carries it, and no finiteness or field structure is used.
2. **Membership — the integrality layer.** If `A` holds one of every pair of reciprocals — a
   *valuation subring*, in Mathlib's bundled form — and is `σ`-stable for an *involution* `σ`, then
   every norm-one element lies in `A`: `u · σu = 1` makes `u` a unit with `u⁻¹ = σu`, and if the
   valuation ring holds `u⁻¹` rather than `u` then it holds `σ(σu) = u`
   (`normOne_subset`, `normOne_subset_valuationSubring`). This is Theorem A's `v_𝔭(u) = 0` step
   with the Dedekind theory deleted.
3. **The plane.** `dist z w = 1` in `ℂ` says exactly that `z − w` is norm-one for complex
   conjugation (`sub_mem_normOne_conj_iff`), so the two plane forms
   (`colorable_unitDistance_of_residue` for a drawing, `colorable_unitDistance_induce_of_residue`
   for a set of points) are specializations at `L = ℂ`, `σ = starRingEnd ℂ`.

## What this generalizes, and what it does not

`plans/FIELD-WALL-THEOREM.md` §5.1 states Theorem A for a real number field `F`, `L = F(i)` and a
prime `𝔭` of `O_L` fixed by complex conjugation, with `N(𝔭)` colours. Those hypotheses enter its
proof only to produce a conjugation-stable valuation subring with a finite residue field, which is
layer 2's hypothesis — so everything the write-up proves follows from what is here, and more:
`FieldWall4`'s own subring is the *intersection* of the two localizations at the two primes above
`2`, which is not a valuation ring and so is outside the write-up's statement.

**Not proved here:** that a number field with a conjugation-fixed prime *has* such a subring. That
is the classical arithmetic (`IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime` plus the
Galois-equivariance that makes it `σ`-stable, plus finiteness of the residue field), and it is
recorded as an open instantiation in `plans/A1-theorem-A-kernel.md` §6. Nothing in this file assumes
it.

## What this is not

Four neighbouring modules do things that read alike and are different:

* `Additive.lean` (M56) — Fischer's additive colourings, where the homomorphism is **total** on the
  group. That is the case `A = ⊤` here, and the spec section proves the two colourings are the same
  function. The whole content of this file is what happens when the homomorphism is *partial*.
* `LocalGlobal.lean` (M61) — `addCayleyMap` / `addCayleyColoring` colour a Cayley graph through a
  **quotient** (fewer vertices, a total hom whose kernel misses the connection set). Also total, and
  a different construction.
* `UnitQuadrance.lean` (M58) — `unitQuadrance.map`, the finite-plane bound: a ring homomorphism
  applied coordinatewise is a graph homomorphism. That is *functoriality*, a different mechanism
  which yields the residue plane's own chromatic number rather than the size of a residue field, and
  it is strictly sharper where it applies.
* `ResidueObstruction.lean` (M60) — despite the name, about pair compulsions transported along a
  graph homomorphism. No colouring is constructed there.
* `Lift.lean` (M59) — owns the name `residue`, for the reduction of a point of `(ℤ/p²)²` to `𝔽_p²`.
  That is why the map here is `cosetResidue`: it is a residue read *coset by coset*, which is the
  one thing this construction adds to a homomorphism.

The connection set of `unitQuadrance R` is `LocalGlobal.unitCircle R ⊆ R × R`, which is `normOne` of
the conjugation of `R[i]` under the identification `R × R ≅ R[i]`. That identification is not
formalized (it would want a ring structure on `R × R` that is not the product one); what is
formalized instead is `colorable_unitQuadrance_of_residue`, the same theorem read directly on the
coordinate group.

## Using this file

To colour a set `S` of complex points with `k` colours:

1. Name a subring `A : Subring ℂ` and prove it stable under conjugation
   (`hσ : ∀ z ∈ A, starRingEnd ℂ z ∈ A`).
2. Give `ψ : A →+* G` with `G` a finite nontrivial commutative ring; `k` is `Fintype.card G`.
3. Prove that unit-distance differences of points of `S` lie in `A`. **This is the only arithmetic**
   — the descent, or the valuation argument, or whatever the field supplies. If `A` comes from a
   valuation subring, `normOne_subset_valuationSubring` discharges it outright.
4. Call `colorable_unitDistance_induce_of_residue`.

The colouring itself is `cosetResidue ψ.toAddMonoidHom`, and it is *sealed*: reason about it through
`cosetResidue_apply_of_mem` (on `A` it is `ψ`), `cosetResidue_sub` (a conditional `map_sub`) and
`cosetResidue_eq_iff` (when two points share a colour). Note that the subgroup cannot be inferred from
the homomorphism — write `cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom`, or the elaborator
reports a mismatch against `↥?m`. `cosetResidue` is noncomputable: one coset representative is chosen by
`Classical.choice`, which is why a colouring built this way has no `#eval`.

## Attribution

The residue-colouring method is Woodall's (1973) and Fischer's (1990); Theorem A is
`plans/FIELD-WALL-THEOREM.md`'s. Ours is the formalization, and the observation that the number
field, the prime and the valuation are three separable hypotheses of which the proof uses only the
third, and only through `mem_or_inv_mem`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## §1 The residue map

`ψ`, extended from the subgroup `A` to the whole group by choosing one representative per coset.
The section is normalized so that the zero coset is represented by `0`, which is what makes
`cosetResidue` literally extend `ψ` and lets every statement below avoid subtypes. -/

section Residue

variable {M G : Type*} [AddCommGroup M] [AddCommGroup G] {A : AddSubgroup M}

private theorem mk_surjective (A : AddSubgroup M) :
    Function.Surjective ⇑(QuotientAddGroup.mk' A) := fun q => Quot.exists_rep q

/-- A section of the quotient map, normalized so that the zero coset is represented by `0`. -/
private noncomputable def sect (A : AddSubgroup M) (q : M ⧸ A) : M :=
  open Classical in
  if q = 0 then 0 else Function.surjInv (mk_surjective A) q

private theorem sect_spec (A : AddSubgroup M) (q : M ⧸ A) :
    QuotientAddGroup.mk' A (sect A q) = q := by
  classical
  rw [sect]
  split
  · next h => rw [h, map_zero]
  · exact Function.surjInv_eq (mk_surjective A) q

private theorem sect_zero (A : AddSubgroup M) : sect A 0 = 0 := by
  classical
  rw [sect, if_pos rfl]

/-- The chosen representative of `x`'s coset. -/
private noncomputable def cosetRep (A : AddSubgroup M) (x : M) : M :=
  sect A (QuotientAddGroup.mk' A x)

private theorem cosetRep_of_mem {x : M} (h : x ∈ A) : cosetRep A x = 0 := by
  rw [cosetRep, show QuotientAddGroup.mk' A x = 0 from (QuotientAddGroup.eq_zero_iff x).mpr h,
    sect_zero]

private theorem sub_cosetRep_mem (A : AddSubgroup M) (x : M) : x - cosetRep A x ∈ A := by
  have h : QuotientAddGroup.mk' A (cosetRep A x) = QuotientAddGroup.mk' A x :=
    sect_spec A (QuotientAddGroup.mk' A x)
  have h2 : -cosetRep A x + x ∈ A := QuotientAddGroup.eq.mp h
  have h3 : x - cosetRep A x = -cosetRep A x + x := by abel
  rwa [h3]

private theorem cosetRep_eq_of_sub_mem {x y : M} (h : x - y ∈ A) :
    cosetRep A x = cosetRep A y :=
  congrArg (sect A) (QuotientAddGroup.eq.mpr
    (by rw [show -x + y = -(x - y) by abel]; exact A.neg_mem h))

/-- **The residue map**: `ψ`, extended from `A` to the whole group by choosing coset
representatives. Sealed — reason through `cosetResidue_apply_of_mem`, `cosetResidue_sub` and
`cosetResidue_eq_iff`. Noncomputable: the representatives come from `Classical.choice`. -/
noncomputable def cosetResidue (ψ : A →+ G) (x : M) : G :=
  ψ ⟨x - cosetRep A x, sub_cosetRep_mem A x⟩

/-- **On `A` the residue map is `ψ`** — the normalization of the section, and the way to compute any
residue a consumer actually holds. -/
theorem cosetResidue_apply_of_mem (ψ : A →+ G) {x : M} (h : x ∈ A) : cosetResidue ψ x = ψ ⟨x, h⟩ :=
  congrArg ψ (Subtype.ext (by simp only [cosetRep_of_mem h, sub_zero]))

@[simp] theorem cosetResidue_zero (ψ : A →+ G) : cosetResidue ψ 0 = 0 := by
  rw [cosetResidue_apply_of_mem ψ A.zero_mem]
  exact map_zero ψ

/-- **The defining property: a conditional `map_sub`.** Within one coset of `A` the residue map is
additive; between cosets it is unconstrained. -/
theorem cosetResidue_sub (ψ : A →+ G) {x y : M} (h : x - y ∈ A) :
    cosetResidue ψ x - cosetResidue ψ y = cosetResidue ψ (x - y) := by
  rw [cosetResidue_apply_of_mem ψ h, cosetResidue, cosetResidue, ← map_sub]
  refine congrArg ψ (Subtype.ext ?_)
  show x - cosetRep A x - (y - cosetRep A y) = x - y
  rw [cosetRep_eq_of_sub_mem h]
  abel

/-- **When two points of one coset share a colour.** The `←` direction is properness (an edge
difference with nonzero residue separates); the `→` direction is what makes a whole class of
distances monochromatic. -/
theorem cosetResidue_eq_iff (ψ : A →+ G) {x y : M} (h : x - y ∈ A) :
    cosetResidue ψ x = cosetResidue ψ y ↔ cosetResidue ψ (x - y) = 0 := by
  rw [← cosetResidue_sub ψ h, sub_eq_zero]

end Residue

/-! ## §2 The colouring -/

section Colouring

variable {V M G : Type*} [AddCommGroup M] [AddCommGroup G] {A : AddSubgroup M}

/-- **The residue colouring.** A graph drawn in an abelian group by `f`, with every edge difference
in `A` and of nonzero residue, is `|G|`-colourable.

The count is `Fintype.card G` and not the index `[A : ker ψ]`, which would be sharper; every
consumer here has a surjective `ψ` onto a field, so the sharper form has no customer. -/
theorem colorable_of_residue [Fintype G] (Γ : SimpleGraph V) (f : V → M) (ψ : A →+ G)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hne : ∀ ⦃v w⦄, Γ.Adj v w → cosetResidue ψ (f v - f w) ≠ 0) :
    Γ.Colorable (Fintype.card G) :=
  SimpleGraph.Coloring.colorable <|
    SimpleGraph.Coloring.mk (fun v => cosetResidue ψ (f v)) fun {_ _} hvw hc =>
      hne hvw ((cosetResidue_eq_iff ψ (hmem hvw)).mp hc)

end Colouring

/-! ## §3 Norm one, and the two arithmetic layers -/

section NormOne

variable {L : Type*} [CommRing L]

/-- **The norm-one set** of a ring endomorphism `σ`: the elements with `u · σu = 1`. In the plane,
with `σ` complex conjugation, these are exactly the unit vectors. -/
def normOne (σ : L →+* L) : Set L := {u | u * σ u = 1}

/-- The bridge out of `normOne` into ring arithmetic. Not a `simp` lemma: consumers state their
hypotheses in `normOne` vocabulary and the theorems below consume them in that form. -/
theorem mem_normOne {σ : L →+* L} {u : L} : u ∈ normOne σ ↔ u * σ u = 1 := Iff.rfl

/-- **A norm-one element of a σ-stable subring is a unit of that subring** — `σu` is its inverse and
lies in `A`. This is the mechanism the whole colouring rests on. -/
theorem isUnit_of_mem_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A) {u : L}
    (hu : u ∈ A) (h : u ∈ normOne σ) : IsUnit (⟨u, hu⟩ : A) :=
  IsUnit.of_mul_eq_one ⟨σ u, hσ u hu⟩ (Subtype.ext h)

/-- **The residue of a norm-one element is nonzero.** A unit maps to a unit, and a unit of a
nontrivial ring is not `0`. `Nontrivial G` is exactly what this step spends. -/
theorem map_ne_zero_of_mem_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] (ψ : A →+* G) {u : L} (hu : u ∈ A)
    (h : u ∈ normOne σ) : ψ ⟨u, hu⟩ ≠ 0 := by
  obtain ⟨b, hb⟩ := (IsUnit.map ψ (isUnit_of_mem_normOne hσ hu h)).exists_right_inv
  intro h0
  rw [h0, zero_mul] at hb
  exact zero_ne_one hb

/-- **Every norm-one element is integral** — the integrality step of Theorem A, with the valuation
theory reduced to the one property it uses: `A` holds one of every pair of reciprocals, is
`σ`-stable, and `σ` is an involution. -/
theorem normOne_subset {A : Subring L} {σ : L →+* L}
    (hA : ∀ z w : L, z * w = 1 → z ∈ A ∨ w ∈ A) (hσ : ∀ z ∈ A, σ z ∈ A)
    (hσσ : ∀ z : L, σ (σ z) = z) : normOne σ ⊆ (A : Set L) := by
  intro u h
  rcases hA u (σ u) h with hu | hsu
  · exact hu
  · have hss := hσ _ hsu
    rwa [hσσ] at hss

variable {V : Type*}

/-- **The residue colouring over a ring.** The two hypotheses are the two halves of the arithmetic:
`hmem` says the edge differences are integral, `hnorm` says they are unit vectors. -/
theorem colorable_of_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G)
    (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable (Fintype.card G) := by
  refine colorable_of_residue (A := A.toAddSubgroup) Γ f ψ.toAddMonoidHom
    (fun _ _ hvw => hmem hvw) fun v w hvw => ?_
  rw [cosetResidue_apply_of_mem _ (hmem hvw)]
  exact map_ne_zero_of_mem_normOne hσ ψ (hmem hvw) (hnorm hvw)

end NormOne

section Valuation

variable {L : Type*} [Field L] {V : Type*}

/-- **Every norm-one element lies in a σ-stable valuation subring** — `normOne_subset` with
Mathlib's bundled hypothesis (`ValuationSubring.mem_or_inv_mem`) in place of the unbundled one. -/
theorem normOne_subset_valuationSubring (A : ValuationSubring L) {σ : L →+* L}
    (hσ : ∀ z ∈ A, σ z ∈ A) (hσσ : ∀ z : L, σ (σ z) = z) :
    normOne σ ⊆ (A : Set L) := by
  refine normOne_subset (A := A.toSubring) (fun z w hzw => ?_) hσ hσσ
  rcases A.mem_or_inv_mem z with hz | hz
  · exact Or.inl hz
  · refine Or.inr ?_
    have hz0 : z ≠ 0 := by rintro rfl; simp at hzw
    have hw : w = z⁻¹ := by field_simp; linear_combination hzw
    rwa [hw]

/-- **Theorem A, valuation form.** Over a field, with `A` a conjugation-stable valuation subring,
the integrality hypothesis is discharged and only the geometry remains. -/
theorem colorable_of_valuationSubring (A : ValuationSubring L) {σ : L →+* L}
    (hσ : ∀ z ∈ A, σ z ∈ A) (hσσ : ∀ z : L, σ (σ z) = z)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A.toSubring →+* G)
    (Γ : SimpleGraph V) (f : V → L)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable (Fintype.card G) :=
  colorable_of_normOne (A := A.toSubring) hσ ψ Γ f
    (fun _ _ hvw => normOne_subset_valuationSubring A hσ hσσ (hnorm hvw)) hnorm

end Valuation

/-! ## §4 The plane -/

section Plane

open Complex

variable {V : Type*}

/-- Norm one for complex conjugation is squared modulus one. -/
theorem mem_normOne_conj_iff {z : ℂ} : z ∈ normOne (starRingEnd ℂ) ↔ normSq z = 1 := by
  rw [mem_normOne, Complex.mul_conj, ← Complex.ofReal_one, Complex.ofReal_inj]

/-- **Unit distance is norm one** — the whole of the geometry, in one line. -/
theorem sub_mem_normOne_conj_iff {z w : ℂ} :
    z - w ∈ normOne (starRingEnd ℂ) ↔ dist z w = 1 := by
  rw [mem_normOne_conj_iff, Complex.dist_eq, ← Complex.sq_norm]
  constructor
  · intro h
    nlinarith [norm_nonneg (z - w)]
  · intro h
    rw [h]
    norm_num

/-- **Theorem A in the plane, for a drawing**: a graph drawn in `ℂ` with unit-length edges whose
differences lie in a conjugation-stable subring `A` is `|G|`-colourable for any `ψ : A →+* G`. -/
theorem colorable_unitDistance_of_residue {A : Subring ℂ}
    (hσ : ∀ z ∈ A, (starRingEnd ℂ) z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G)
    {Γ : SimpleGraph V} (f : V → ℂ) (hf : ∀ ⦃v w⦄, Γ.Adj v w → dist (f v) (f w) = 1)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A) :
    Γ.Colorable (Fintype.card G) :=
  colorable_of_normOne hσ ψ Γ f hmem fun _ _ hvw => sub_mem_normOne_conj_iff.mpr (hf hvw)

/-- **Theorem A in the plane, for a set of points** — the entry point a milestone colouring a plane
over a field walks to. `hS` is the only arithmetic: every unit-distance difference inside `S` lies
in `A`. -/
theorem colorable_unitDistance_induce_of_residue {A : Subring ℂ}
    (hσ : ∀ z ∈ A, (starRingEnd ℂ) z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G) {S : Set ℂ}
    (hS : ∀ z ∈ S, ∀ w ∈ S, dist z w = 1 → z - w ∈ A) :
    ((unitDistance ℂ).induce S).Colorable (Fintype.card G) :=
  colorable_unitDistance_of_residue hσ ψ (fun v : S => (v : ℂ)) (fun _ _ hvw => hvw)
    fun v w hvw => hS _ v.2 _ w.2 hvw

end Plane

/-! ## §5 The unit-quadrance graph

The theorem read on the coordinate group of any commutative ring — evidence, rather than a docstring
claim, that nothing in §1 needed `ℂ`, a metric, or a field. -/

section Quadrance

variable {R G : Type*} [CommRing R] [AddCommGroup G]

/-- **The unit-quadrance graph of any commutative ring is `|G|`-colourable** once its circle lies in
a subgroup `A` of the coordinate group with nonzero residues. -/
theorem colorable_unitQuadrance_of_residue [Fintype G] {A : AddSubgroup (R × R)} (ψ : A →+ G)
    (hmem : ∀ v : R × R, v.1 ^ 2 + v.2 ^ 2 = 1 → v ∈ A)
    (hne : ∀ v : R × R, v.1 ^ 2 + v.2 ^ 2 = 1 → cosetResidue ψ v ≠ 0) :
    (unitQuadrance R).Colorable (Fintype.card G) := by
  have key : ∀ u v : R × R, (unitQuadrance R).Adj u v → (u - v).1 ^ 2 + (u - v).2 ^ 2 = 1 :=
    fun u v huv => by simpa using (unitQuadrance_adj.mp huv).2
  exact colorable_of_residue (unitQuadrance R) id ψ (fun u v huv => hmem _ (key u v huv))
    fun u v huv => hne _ (key u v huv)

end Quadrance

/-! ## §6 Spec — the model of the hypotheses, the subsumption, and the reds -/

section Spec

/-- Doubling on `ℤ`. -/
private def dbl : ℤ →+ ℤ := AddMonoidHom.mk' (fun x => 2 * x) (by intro a b; ring)

private theorem dbl_injective : Function.Injective dbl := by
  intro a b hab
  have h2 : 2 * a = 2 * b := hab
  omega

private theorem dbl_mem (k : ℤ) : dbl k ∈ dbl.range := AddMonoidHom.mem_range.mpr ⟨k, rfl⟩

/-- **Halving on the even integers** — a homomorphism that provably does *not* extend to `ℤ`
(`2 · φ 1 = 1` has no solution in `ZMod 2`), so the model below exercises a genuinely partial `ψ`
rather than `Additive.additiveColoring` in disguise. -/
noncomputable def halfMod : dbl.range →+ ZMod 2 :=
  (Int.castAddHom (ZMod 2)).comp (AddMonoidHom.ofInjective dbl_injective).symm.toAddMonoidHom

theorem halfMod_apply (k : ℤ) : halfMod ⟨dbl k, dbl_mem k⟩ = (k : ZMod 2) := by
  have h : (AddMonoidHom.ofInjective dbl_injective).symm ⟨dbl k, dbl_mem k⟩ = k := by
    rw [AddEquiv.symm_apply_eq]
    rfl
  show (Int.castAddHom (ZMod 2)) ((AddMonoidHom.ofInjective dbl_injective).symm _) = _
  rw [h]
  simp

/-- The graph on `ℤ` joining integers two apart. Its two components are the cosets of the even
integers, so the coset machinery is live. -/
def twoStep : SimpleGraph ℤ := SimpleGraph.fromRel fun a b => a - b = 2

/-- **The model of the hypotheses**: non-vacuity, with a partial `ψ`. -/
example : twoStep.Colorable 2 := by
  have hstep : ∀ a b : ℤ, twoStep.Adj a b → a - b = dbl 1 ∨ a - b = dbl (-1) := by
    intro a b hab
    rw [twoStep, SimpleGraph.fromRel_adj] at hab
    obtain ⟨-, h | h⟩ := hab
    · exact Or.inl (by show a - b = 2 * 1; omega)
    · exact Or.inr (by show a - b = 2 * (-1); omega)
  rw [← ZMod.card 2]
  refine colorable_of_residue twoStep id halfMod (fun a b hab => ?_) (fun a b hab => ?_)
  · rcases hstep a b hab with h | h <;> exact h ▸ dbl_mem _
  · have hid : id a - id b = a - b := rfl
    rcases hstep a b hab with h | h <;>
      rw [hid, h, cosetResidue_apply_of_mem _ (dbl_mem _), halfMod_apply] <;> decide

/-- **The subsumption of `Additive.additiveColoring`**, as an equation between the two colourings
rather than a claim in a docstring: it is the case `A = ⊤`. -/
example {M G : Type*} [AddCommGroup M] [AddCommGroup G] (Γ : SimpleGraph M) (φ : M →+ G)
    (h : ∀ a b, Γ.Adj a b → φ (a - b) ≠ 0) (x : M) :
    additiveColoring Γ φ h x = cosetResidue (φ.comp (⊤ : AddSubgroup M).subtype) x := by
  rw [additiveColoring_apply, cosetResidue_apply_of_mem _ (AddSubgroup.mem_top x)]
  rfl

/-- **Red: the residue hypothesis is load-bearing.** With `A = ⊤` and the parity homomorphism on
`ℤ`, the triangle drawn at `0, 1, 2` has `φ (0 - 2) = 0` — and it must, because a triangle is not
2-colourable. -/
example : (Int.castAddHom (ZMod 2)) ((0 : ℤ) - 2) = 0 := by decide

example : ¬ (⊤ : SimpleGraph (Fin 3)).Colorable 2 := by
  rintro ⟨C⟩
  have hinj : Function.Injective C := fun a b hab => by
    by_contra hne
    exact C.valid (by simpa using hne) hab
  simpa using Fintype.card_le_of_injective C hinj

/-- **Red: `Nontrivial G` is load-bearing.** A trivial residue ring would give one colour, and one
colour cannot cover an edge. -/
example : ¬ (⊤ : SimpleGraph (Fin 2)).Colorable 1 := by
  rintro ⟨C⟩
  have hinj : Function.Injective C := fun a b hab => by
    by_contra hne
    exact C.valid (by simpa using hne) hab
  simpa using Fintype.card_le_of_injective C hinj

end Spec

end HadwigerNelson
