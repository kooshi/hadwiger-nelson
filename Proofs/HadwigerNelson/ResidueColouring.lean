import Proofs.HadwigerNelson.Additive
import Proofs.HadwigerNelson.Palette
import Proofs.HadwigerNelson.UnitQuadrance
import Mathlib.RingTheory.Valuation.ValuationSubring
import Mathlib.RingTheory.DedekindDomain.AdicValuation

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
   for a set of points) are specializations at `L = ℂ`, `σ = starRingEnd ℂ`. Layers 2 and 3
   compose into **`colorable_unitDistance_induce_of_valuationSubring`**, which is Theorem A in the
   write-up's own shape: a conjugation-stable subfield of `ℂ`, a conjugation-stable valuation
   subring of it, a homomorphism to a finite nontrivial ring, and every unit-distance graph drawn
   in the subfield is colourable with that many colours.

   The subfield is load-bearing and cannot be widened to `ℂ` itself: a homomorphism from a
   valuation ring to a finite nontrivial ring has a prime kernel with a finite domain — hence a
   field — as quotient, so the kernel is the maximal ideal, and the residue field of a valuation
   subring of an algebraically closed field is algebraically closed, hence infinite. (An argument,
   not a theorem — it is not formalized here; it is recorded because it says why the shape is what
   it is.)

## What this generalizes, and what it does not

`plans/FIELD-WALL-THEOREM.md` §5.1 states Theorem A for a real number field `F`, `L = F(i)` and a
prime `𝔭` of `O_L` fixed by complex conjugation, with `N(𝔭)` colours. Those hypotheses enter its
proof only to produce a conjugation-stable valuation subring with a finite residue field, which is
layer 2's hypothesis — so everything the write-up proves follows from what is here, and more:
`FieldWall4`'s own subring is the *intersection* of the two localizations at the two primes above
`2`, which is not a valuation ring and so is outside the write-up's statement.

**What is proved of the arithmetic input**: `conj_mem_valuationSubringAtPrime` — the localization
of a Dedekind domain at a height-one prime fixed by an automorphism is stable under that
automorphism, which is the Galois-equivariance step the write-up's proof spends its valuation theory
on. **What is not**: that the residue field of that localization is finite of size `N(𝔭)`
(`Ideal.absNorm`, and the `NumberField` instances behind it), and the typing that places an abstract
number field inside `ℂ`. Both are classical arithmetic and Mathlib plumbing with no new content;
they are recorded as the open instantiation in `plans/A1-theorem-A-kernel.md` §6, and nothing in
this file assumes them.

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

If instead you hold a *field* — a conjugation-stable subfield `L ⊆ ℂ` and a conjugation-stable
valuation subring of it — step 3 is free and the entry point is
`colorable_unitDistance_induce_of_valuationSubring`.

To ask instead **which pairs that colouring identifies** — §4 — you need one thing more, and it is
the hypothesis the write-up already states: that `σ` maps `ψ`'s kernel into itself, i.e. that the
prime is fixed by conjugation. Then `not_forces_of_map_ne_zero` and `not_separated_of_map_eq_zero`
say which distances can carry a compulsion at `Fintype.card G` colours, and
`map_mul_normOne_eq_zero_iff` / `map_mul_conj_eq_zero_iff` reduce a difference's residue to a
scalar's or to its norm's.

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

/-- **The residue colouring, as a colouring.** `colorable_of_normOne` below is this with the colour
count read off, and is what a milestone bounding a chromatic number calls; a caller who has to
*evaluate* the colouring — every compulsion consumer in §4 does — needs the colouring itself.

The two hypotheses are the two halves of the arithmetic: `hmem` says the edge differences are
integral, `hnorm` says they are unit vectors. -/
noncomputable def normOneColoring {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] (ψ : A →+* G) (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) : Γ.Coloring G :=
  SimpleGraph.Coloring.mk (fun v => cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom (f v))
    fun {v w} hvw hc => by
      have h0 : cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom (f v - f w) = 0 :=
        (cosetResidue_eq_iff (A := A.toAddSubgroup) ψ.toAddMonoidHom (hmem hvw)).mp hc
      rw [cosetResidue_apply_of_mem (A := A.toAddSubgroup) ψ.toAddMonoidHom (hmem hvw)] at h0
      exact map_ne_zero_of_mem_normOne hσ ψ (hmem hvw) (hnorm hvw) h0

@[simp] theorem normOneColoring_apply {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] (ψ : A →+* G) (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) (v : V) :
    normOneColoring hσ ψ Γ f hmem hnorm v
      = cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom (f v) := rfl

/-- **The residue colouring over a ring.** The two hypotheses are the two halves of the arithmetic:
`hmem` says the edge differences are integral, `hnorm` says they are unit vectors. -/
theorem colorable_of_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G)
    (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable (Fintype.card G) :=
  (normOneColoring hσ ψ Γ f hmem hnorm).colorable

end NormOne

/-! ## §4 Which pairs a residue colouring identifies

The colouring of §2 is *one* proper colouring, so every claim of the form "in every proper
`k`-colouring these two points agree" has to be true of it — and which pairs it identifies is
arithmetic rather than geometry. This section is that arithmetic, and it is two facts.

**A unit is invisible.** `RingHom.ker ψ` is an *ideal*, and multiplying by a unit of `A` does not
move an element in or out of an ideal. So the residue of `d · u` vanishes exactly when `d`'s does,
whenever `u` is a unit — and a norm-one element of a `σ`-stable subring *is* a unit
(`isUnit_of_mem_normOne`). This costs nothing: no primality, no finiteness, no nontriviality of the
residue ring.

**A `σ`-stable kernel makes the norm a test for the element.** `ψ (v · σ v) = ψ v · ψ (σ v)`, so in
a ring with no zero divisors the norm's residue vanishes iff one factor's does — and if the kernel
of `ψ` is stable under `σ` those two conditions are the same one. *That hypothesis is exactly "the
prime is fixed by conjugation"*, which is the hypothesis `plans/FIELD-WALL-THEOREM.md` states
Theorem A with; the red at the end of §7 shows it is load-bearing, with a split prime as the
counterexample. This is the half that spends primality.

Then the two consumers, in the vocabulary the six-colour hunt uses: a difference whose residue is
nonzero carries **no forced-monochromatic pair**, and one whose residue vanishes carries **no
virtual edge** (`Forcer.lean`, `Fan.lean`; the palette translation is `Palette.lean`).

`Proofs/HadwigerNelson/ValuationLaw.lean` is the instance at `L = ℂ`, `A` the odd-denominator ring
of `ℚ(√3, √11)`, `σ` complex conjugation and `G = 𝔽₄`, where it reproduces a table of computer-found
results from `[Parts2020a]`.

Over a **field** the law can be keyed on a scalar rather than on the difference, which is the form
the ledger states it in: *two points at distance `d` get the same colour exactly when `d` lies in
the prime*. `map_eq_zero_iff_of_mul_conj_eq` is that, and it is the entry point a caller at a new
prime walks to — the one thing it still owes is the **integrality** of the unit vector `(z − w)/d`,
which is the field's own arithmetic and cannot be general (`oddDenom` is an intersection of two
localizations, not a valuation ring, so `normOne_subset_valuationSubring` does not reach it). -/

section Law

variable {L V : Type*} [CommRing L] {A : Subring L} {σ : L →+* L}
variable {G : Type*} [CommRing G]

/-- **When two points of one coset share a colour** — `cosetResidue_eq_iff` for a *ring*
homomorphism, which is the form every consumer holds and which spares them the `(A := …)`
annotation the module docstring warns about. -/
theorem cosetResidue_eq_iff_map (ψ : A →+* G) {z w : L} (hmem : z - w ∈ A) :
    cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom z
        = cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom w
      ↔ ψ ⟨z - w, hmem⟩ = 0 := by
  rw [cosetResidue_eq_iff (A := A.toAddSubgroup) ψ.toAddMonoidHom hmem,
    cosetResidue_apply_of_mem (A := A.toAddSubgroup) ψ.toAddMonoidHom hmem]
  rfl

/-- **A norm-one difference is never identified** — the properness of the residue colouring, read at
one pair rather than along a graph. -/
theorem cosetResidue_ne_of_mem_normOne [Nontrivial G] (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G)
    {z w : L} (hmem : z - w ∈ A) (hnorm : z - w ∈ normOne σ) :
    cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom z
      ≠ cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom w := fun hc =>
  map_ne_zero_of_mem_normOne hσ ψ hmem hnorm ((cosetResidue_eq_iff_map ψ hmem).mp hc)

/-- **A unit is invisible to a residue.** The kernel of a ring homomorphism is an ideal, and an
ideal absorbs units both ways (`Ideal.mul_unit_mem_iff_mem`).

Note what is *not* assumed: nothing whatsoever about `G`. The four-element field's
no-zero-divisors argument, which is how this step was first written one field down, is not the
mechanism. -/
theorem map_mul_eq_zero_iff_of_isUnit (ψ : A →+* G) {a u : A} (hu : IsUnit u) :
    ψ (a * u) = 0 ↔ ψ a = 0 := by
  rw [← RingHom.mem_ker, ← RingHom.mem_ker, Ideal.mul_unit_mem_iff_mem _ hu]

/-- **Scaling by a unit vector cannot move a residue off zero.** The scalar half of the law: for a
difference that factors as `d · u` with `u` norm-one, the residue is the *scalar's*. -/
theorem map_mul_normOne_eq_zero_iff (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G)
    {d u : L} (hd : d ∈ A) (hu : u ∈ A) (hnorm : u ∈ normOne σ) :
    ψ ⟨d * u, A.mul_mem hd hu⟩ = 0 ↔ ψ ⟨d, hd⟩ = 0 :=
  map_mul_eq_zero_iff_of_isUnit ψ (a := ⟨d, hd⟩) (isUnit_of_mem_normOne hσ hu hnorm)

/-- **The norm's residue vanishes exactly with the element's**, when `σ` maps the kernel of `ψ` into
itself. That hypothesis is the write-up's *"the prime is fixed by complex conjugation"*, and it is
strictly weaker than what the four-element field supplies (there `σ` induces Frobenius, so
`ψ (σ z) = ψ z ^ 2` outright); only the implication `ψ (σ z) = 0 → ψ z = 0` is used.

`σ.restrict A A hσ` is `σ` cut down to `A`, which is where both sides of the statement live.

`[NoZeroDivisors G]` is what spends primality here. The honest hypothesis is
`(RingHom.ker ψ).IsPrime`, which is strictly weaker; the instance is chosen because it is inferred
at every call site (every residue ring in this development is a finite field) where the ideal
hypothesis would have to be discharged by hand. -/
theorem map_mul_conj_eq_zero_iff [NoZeroDivisors G] (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G)
    (hker : ∀ z : A, ψ (σ.restrict A A hσ z) = 0 → ψ z = 0) (v : A) :
    ψ (v * σ.restrict A A hσ v) = 0 ↔ ψ v = 0 := by
  rw [map_mul, mul_eq_zero]
  exact ⟨fun h => h.elim id (hker v), Or.inl⟩

/-- **A difference whose residue is nonzero carries no forced-monochromatic pair** — the half that
rules gadgets out. The residue colouring is a colouring the pair would have to survive, and it does
not identify them. -/
theorem not_forces_of_map_ne_zero [Nontrivial G] [Fintype G] {k : ℕ} (hk : Fintype.card G = k)
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G) {Γ : SimpleGraph V} (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ)
    {p q : V} (hpq : f p - f q ∈ A) (hres : ψ ⟨f p - f q, hpq⟩ ≠ 0) :
    ¬ Forces Γ k p q :=
  not_forces_of_coloring_ne hk (normOneColoring hσ ψ Γ f hmem hnorm) fun hc =>
    hres ((cosetResidue_eq_iff_map ψ hpq).mp (by simpa using hc))

/-- **A difference whose residue vanishes carries no virtual edge** — the dual half. -/
theorem not_separated_of_map_eq_zero [Nontrivial G] [Fintype G] {k : ℕ} (hk : Fintype.card G = k)
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G) {Γ : SimpleGraph V} (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ)
    {p q : V} (hpq : f p - f q ∈ A) (hres : ψ ⟨f p - f q, hpq⟩ = 0) :
    ¬ Separated Γ k p q :=
  not_separated_of_coloring_eq hk (normOneColoring hσ ψ Γ f hmem hnorm)
    (by simpa using (cosetResidue_eq_iff_map ψ hpq).mpr hres)

/-! ### Keyed on the distance rather than on the difference

The two lemmas below need `L` to be a field, because they divide by the scalar. -/

section LawField

variable {L : Type*} [Field L] {A : Subring L} {σ : L →+* L}
variable {G : Type*} [CommRing G]

/-- **The factorization step, with the geometry removed.** A difference whose norm equals a nonzero
scalar `d`'s norm is `d` times a norm-one element — over `ℂ` with `σ` complex conjugation, "two
points at distance `d` differ by `d` times a unit vector". -/
theorem div_mem_normOne {v d : L} (hd : d ≠ 0) (h : v * σ v = d * σ d) : v / d ∈ normOne σ := by
  have hsd : σ d ≠ 0 := fun h0 => hd (σ.injective (by rw [h0, map_zero]))
  rw [mem_normOne, map_div₀, div_mul_div_comm, h, div_self (mul_ne_zero hd hsd)]

/-- **The law, keyed on a scalar.** A difference `z` whose norm equals that of a nonzero `d ∈ A`,
and whose quotient by `d` lies in `A`, lies in `A` itself and has exactly `d`'s residue.

Over `ℂ` this is *"two points at distance `d` get the same colour iff `d` lies in the prime"*, and
the three hypotheses separate cleanly: `hnorm` is the geometry (the distance), `hd` says the scalar
is integral, and **`hq` is the only arithmetic** — the field's own statement that a unit vector is
integral. A caller at a new prime supplies `hq` and nothing else. -/
theorem map_eq_zero_iff_of_mul_conj_eq (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G)
    {z d : L} (hd : d ∈ A) (hd0 : d ≠ 0) (hq : z / d ∈ A) (hnorm : z * σ z = d * σ d) :
    ∃ h : z ∈ A, (ψ ⟨z, h⟩ = 0 ↔ ψ ⟨d, hd⟩ = 0) := by
  have hfac : z = d * (z / d) := by field_simp
  have hz : z ∈ A := hfac ▸ A.mul_mem hd hq
  refine ⟨hz, ?_⟩
  rw [show (⟨z, hz⟩ : A) = ⟨d * (z / d), A.mul_mem hd hq⟩ from Subtype.ext hfac]
  exact map_mul_normOne_eq_zero_iff hσ ψ hd hq (div_mem_normOne hd0 hnorm)

end LawField

end Law

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

/-- **A σ-fixed height-one prime gives a σ-stable valuation subring** — the classical source of
layer 2's hypothesis, and the step `plans/STUB-theorem-A-kernel.md` §3 named as load-bearing (the
Galois-equivariance of `v_𝔭`). Mathlib supplies the valuation subring
(`IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`); what a consumer still owes is its
stability, and that turns out to be a statement about the localization's own elements — `a / s` with
`s` outside `𝔭` maps to `σa / σs` with `σs` outside `𝔭` — rather than about valuations at all.

`σO` is the automorphism `σ` restricts to on the Dedekind domain, `hcomm` says it does restrict, and
`hfix` says it fixes the prime. -/
theorem conj_mem_valuationSubringAtPrime {O : Type*} [CommRing O] [IsDedekindDomain O]
    {L : Type*} [Field L] [Algebra O L] [IsFractionRing O L]
    (v : IsDedekindDomain.HeightOneSpectrum O) (σ : L ≃+* L) (σO : O ≃+* O)
    (hcomm : ∀ a : O, σ (algebraMap O L a) = algebraMap O L (σO a))
    (hfix : ∀ a : O, σO a ∈ v.asIdeal → a ∈ v.asIdeal) :
    ∀ z ∈ IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime L v,
      σ z ∈ IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime L v := by
  rintro z ⟨a, s, hs, rfl⟩
  refine ⟨σO a, σO s, fun h => hs (hfix s h), ?_⟩
  rw [map_mul, map_inv₀, hcomm, hcomm]

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

/-! ## §5 The plane -/

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

/-! ### Theorem A, as the write-up states it

The write-up's `L = F(i)` is a subfield of `ℂ` closed under conjugation, and its
`A = (O_L)_𝔭` is a conjugation-stable valuation subring. Those two hypotheses, and nothing else
about number fields, give the statement below. -/

/-- **Complex conjugation, restricted to a conjugation-stable subfield.** -/
def conjOn {L : Subfield ℂ} (hL : ∀ z ∈ L, (starRingEnd ℂ) z ∈ L) : L →+* L where
  toFun z := ⟨(starRingEnd ℂ) (z : ℂ), hL _ z.2⟩
  map_one' := Subtype.ext (map_one _)
  map_mul' _ _ := Subtype.ext (map_mul _ _ _)
  map_zero' := Subtype.ext (map_zero _)
  map_add' _ _ := Subtype.ext (map_add _ _ _)

@[simp] theorem coe_conjOn {L : Subfield ℂ} (hL : ∀ z ∈ L, (starRingEnd ℂ) z ∈ L) (z : L) :
    ((conjOn hL z : L) : ℂ) = (starRingEnd ℂ) (z : ℂ) := rfl

/-- Restricted conjugation is an involution. -/
theorem conjOn_conjOn {L : Subfield ℂ} (hL : ∀ z ∈ L, (starRingEnd ℂ) z ∈ L) (z : L) :
    conjOn hL (conjOn hL z) = z := Subtype.ext (Complex.conj_conj _)

/-- **Theorem A.** Let `L` be a subfield of `ℂ` closed under complex conjugation, `A` a valuation
subring of `L` that conjugation maps into itself, and `ψ` a ring homomorphism from `A` to a finite
nontrivial ring `G`. Then every unit-distance graph drawn in `L` is `|G|`-colourable.

This is `plans/FIELD-WALL-THEOREM.md` §5.1 with its number-theoretic hypotheses replaced by the two
properties its proof uses: the write-up's `L = F(i)` is such a subfield, its `A = (O_L)_𝔭` at a
conjugation-fixed prime is such a valuation subring, and its `N(𝔭)` is `Fintype.card G`. What is
*not* proved here is that a number field with a conjugation-fixed prime supplies such an `A` — see
the module docstring. -/
theorem colorable_unitDistance_induce_of_valuationSubring {L : Subfield ℂ}
    (hL : ∀ z ∈ L, (starRingEnd ℂ) z ∈ L) (A : ValuationSubring L)
    (hσ : ∀ z ∈ A, conjOn hL z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A.toSubring →+* G)
    {S : Set ℂ} (hS : S ⊆ (L : Set ℂ)) :
    ((unitDistance ℂ).induce S).Colorable (Fintype.card G) := by
  refine colorable_of_valuationSubring A hσ (conjOn_conjOn hL) ψ _
    (fun v : S => (⟨(v : ℂ), hS v.2⟩ : L)) fun v w hvw => ?_
  have hd : dist (v : ℂ) (w : ℂ) = 1 := hvw
  have hone : (v : ℂ) - (w : ℂ) ∈ normOne (starRingEnd ℂ) := sub_mem_normOne_conj_iff.mpr hd
  show _ * conjOn hL _ = 1
  refine Subtype.ext ?_
  simpa [mem_normOne, map_sub] using hone

end Plane

/-! ## §6 The unit-quadrance graph

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

/-! ## §7 Spec — the model of the hypotheses, the subsumption, and the reds -/

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

/-! ### §4's hypotheses: a model, and the two reds -/

/-- The integers as a model of §4: `σ` the identity, `A = ⊤`, and reduction mod 2 as the residue
map. Its norm-one set is `{1, −1}`, so the norm-one hypothesis below is exercised by a member that
is not the unit. -/
private def intPsi : (⊤ : Subring ℤ) →+* ZMod 2 :=
  (Int.castRingHom (ZMod 2)).comp (⊤ : Subring ℤ).subtype

private theorem intTop (z : ℤ) : z ∈ (⊤ : Subring ℤ) := Subring.mem_top z

example : (-1 : ℤ) ∈ normOne (RingHom.id ℤ) := by simp [mem_normOne]

/-- **The model of §4's hypotheses**, non-vacuous: scaling by `−1` really does leave every residue
where it was, and `−1` is a norm-one element that is not `1`. -/
example (d : ℤ) : intPsi ⟨d * (-1), intTop _⟩ = 0 ↔ intPsi ⟨d, intTop d⟩ = 0 :=
  map_mul_normOne_eq_zero_iff (fun z _ => intTop (RingHom.id ℤ z)) intPsi (intTop d) (intTop (-1))
    (by simp [mem_normOne])

/-- **Red: `IsUnit` is load-bearing in `map_mul_eq_zero_iff_of_isUnit`.** Drop it and the statement
is false — `2` is not a unit of `ℤ`, and multiplying by it lands `1` in the kernel of reduction
mod 2. -/
example : intPsi ⟨(1 : ℤ) * 2, intTop _⟩ = 0 ∧ intPsi ⟨(1 : ℤ), intTop 1⟩ ≠ 0 := by
  constructor
  · show ((1 * 2 : ℤ) : ZMod 2) = 0
    decide
  · show ((1 : ℤ) : ZMod 2) ≠ 0
    decide

/-- Coordinate swap on `ZMod 5 × ZMod 5` — which is complex conjugation on `ℤ[i]/5`. -/
private def swap5 : (ZMod 5 × ZMod 5) →+* (ZMod 5 × ZMod 5) where
  toFun p := (p.2, p.1)
  map_one' := rfl
  map_mul' _ _ := rfl
  map_zero' := rfl
  map_add' _ _ := rfl

/-- **Red: the `σ`-stable-kernel hypothesis of `map_mul_conj_eq_zero_iff` is load-bearing, and the
counterexample is a SPLIT PRIME.** `ZMod 5 × ZMod 5` *is* `ℤ[i]/5`; `swap5` *is* complex
conjugation; the first projection *is* reduction at one of the two primes above 5, and conjugation
exchanges them rather than fixing either. Then `v = (1, 0)` has nonzero residue while its norm
`v · σ v` is zero — so without `hker` the theorem would be false, which is the concrete reason
`plans/FIELD-WALL-THEOREM.md` demands a prime **fixed** by conjugation. -/
example : ∃ v : ZMod 5 × ZMod 5,
    (RingHom.fst (ZMod 5) (ZMod 5)) (v * swap5 v) = 0 ∧
      (RingHom.fst (ZMod 5) (ZMod 5)) v ≠ 0 :=
  ⟨(1, 0), by decide, by decide⟩

end Spec

end HadwigerNelson
