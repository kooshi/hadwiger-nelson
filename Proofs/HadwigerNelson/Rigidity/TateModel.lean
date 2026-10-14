import Proofs.HadwigerNelson.Rigidity.RingScope
import Proofs.HadwigerNelson.Rigidity.DualGroup
import Mathlib.RingTheory.DedekindDomain.FiniteAdeleRing
import Mathlib.NumberTheory.NumberField.CanonicalEmbedding.Basic
import Mathlib.Topology.Algebra.Group.OpenMapping

/-!
# The model of the dual: `TateModel F`, the facts the zero-entropy side reads of `R̂ = W/Λ` (FS-131, job FS131-KT1; skeleton)

The interface between module M8b of the chain under "five colours at the square root of 47" (EF_F⁺, the zero-entropy side)
and lane T, the construction of the model by Tate's self-duality (`plans/FS131-KT1-tate.md`; the coordinator's ruling 1 of
inventory item 791). M8b's three parts are proved over `(D : TateModel F)`; lane T proves `Rigidity.exists_tateModel`
(module `Rigidity/TateExists`). The two run beside each other.

**Read aloud, against `plans/FS100-X01D-derivation.md` § 2.0.** `L = F(i)` is `fieldI F`. Its primes are split or stable
(`IsStablePlace`: conjugation fixes the prime; `SplitPlace F`, the others). The space is

  `W = L_∞ × ∏′_{w split} L_w` (X01D l. 118), here `SAdeleRing F` — the mixed space of `L` (Mathlib's `L ⊗ ℝ`, with its
  lattice of integers and its places) times the restricted product of the completions `L_w` at the split primes with respect
  to their rings of integers `O_w`.

`toSAdele F : L →+* W` is the diagonal. A **Tate model** is a continuous homomorphism `π : W → R̂` (`R̂ = Dual F`, the
characters of `R = ℤ[U_F]`), with the five facts of X01D § 2.0 that M8b reads (FS131-KN9 § 4.1), each a field:

1. `π` is continuous and `π(u a) = rot u (π a)` for every unit vector `u` (X01D l. 120: "`u·χ` ↔ multiplication by `u`");
2. `π` is onto (l. 119: "induces `W / R^∨ ≅ R̂`");
3. its kernel lies on the diagonal, `ker π ⊆ L` (l. 119: `R^∨ = {y ∈ L : ψ(yR) = 1}`), and the lattice `Λ := {y ∈ L : π y = 1}`
   is bounded by `O′`: `O′ ⊆ Λ ⊆ d⁻¹·O′` for an integer `d ≥ 1` (l. 119: "a fractional `R`-ideal (`= 𝔡⁻¹R` up to the choice of
   `ψ`)", read on the weaker reading of the ring, FS131-KN9: `R ⊆ O′` and `c·O′ ⊆ R`);
4. `W = K + O′` with `K` compact (l. 120: "discrete and cocompact in `W`");
5. the archimedean points map to archimedean characters (l. 121: "`A` = image of `L_∞`", the half M8b reads), from which
   `π(L + L_∞) ⊆ T + A` follows (`TateModel.mem_TA`).

**Derived here, not fields:** `Λ` as an additive subgroup of `L` (`TateModel.Λ`) and `ker π = ι(Λ)` (`ker_eq`); `Λ` is an
`R`-module (`mul_mem_Λ`, from 1); two lifts of one character differ by a point of `Λ` (`π_eq_π_iff`); global points are torsion (`toSAdele_mem_torsionChars`, from 3); `π(L + L_∞) ⊆ TA F`
(`mem_TA`, from 3 and 5); `π` is open (`isOpenMap`, from 1, 2 and 4 by the open mapping theorem: `W` is σ-compact, being
the countable union of the compact sets `K + ι x`, `x ∈ O′`).

**Inhabitants.** A model of the structure is the construction itself: no object satisfies the five facts at once except a
Tate model, at any real number field. `Rigidity.exists_tateModel` (module `Rigidity/TateExists`, lane T's leaf) supplies one.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum
open scoped RestrictedProduct

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- A prime of `𝓞(F(i))` is **stable** when complex conjugation fixes it (its prime of `F` does not split in `F(i)`). -/
def IsStablePlace (v : HeightOneSpectrum (𝓞 (fieldI F))) : Prop := v.asIdeal.comap (conjO F) = v.asIdeal

/-- **The split primes of `F(i)`**: the primes conjugation moves, the finite places of `W` (X01D l. 118). -/
def SplitPlace : Type := {v : HeightOneSpectrum (𝓞 (fieldI F)) // ¬ IsStablePlace F v}

/-- **`∏′_{w split} L_w`**: the restricted product of the completions of `F(i)` at the split primes, with respect to their
rings of integers. -/
abbrev SplitAdeleRing : Type :=
  Πʳ w : SplitPlace F, [w.1.adicCompletion (fieldI F), w.1.adicCompletionIntegers (fieldI F)]

/-- The rings of integers are open in the completions: the hypothesis under which Mathlib's restricted product of topological
rings is a topological ring (`RestrictedProduct.isTopologicalRing`), as `FiniteAdeleRing`'s instance takes it. -/
instance splitAdeleRing_isOpen_integers :
    Fact (∀ w : SplitPlace F, IsOpen (w.1.adicCompletionIntegers (fieldI F) : Set (w.1.adicCompletion (fieldI F)))) :=
  ⟨fun _ => Valued.isOpen_valuationSubring _⟩

/-- **`W = L_∞ × ∏′_{w split} L_w`** (X01D l. 118; NF2-LEAF-21's `𝔸_𝒮`): the mixed space of `L = F(i)` times the split
adeles. -/
abbrev SAdeleRing : Type := mixedEmbedding.mixedSpace (fieldI F) × SplitAdeleRing F

/-- The diagonal `L → ∏′_{w split} L_w`: an element of `L` is integral at all but finitely many primes. -/
def toSplitAdele : fieldI F →+* SplitAdeleRing F where
  toFun k := ⟨fun _ => (k : _), by
    simp only [Filter.eventually_cofinite, SetLike.mem_coe, mem_adicCompletionIntegers,
      valuedAdicCompletion_eq_valuation', not_le]
    exact (HeightOneSpectrum.Support.finite (𝓞 (fieldI F)) k).preimage
      (f := fun w : SplitPlace F => w.1) Subtype.val_injective.injOn⟩
  map_one' := Subtype.ext <| funext fun _ => adicCompletion.coe_one ..
  map_mul' _ _ := Subtype.ext <| funext fun _ => adicCompletion.coe_mul ..
  map_zero' := Subtype.ext <| funext fun _ => adicCompletion.coe_zero ..
  map_add' _ _ := Subtype.ext <| funext fun _ => adicCompletion.coe_add ..

/-- **The diagonal `ι : L → W`**. -/
def toSAdele : fieldI F →+* SAdeleRing F := RingHom.prod (mixedEmbedding (fieldI F)) (toSplitAdele F)

/-- `R = ℤ[U_F] ⊆ F(i)`: the unit-vector ring, a subring of `ℂ`, read in `L`. -/
def ofUnitRing : unitRing F →+* fieldI F :=
  RingHom.codRestrict (unitRing F).subtype (fieldI F) fun r => UnitRing.unitRingOver_le_planeOverSubring F r.2

variable {F} in
/-- A unit vector of `F²`, as an element of `L = F(i)`. -/
def unitL (u : unitVectors F) : fieldI F := ⟨u, u.2.1⟩

/-! Spec examples: each fails if its definition drifts. -/

example (v : HeightOneSpectrum (𝓞 (fieldI F))) : IsStablePlace F v ↔ v.asIdeal.comap (conjO F) = v.asIdeal := Iff.rfl

example (k : fieldI F) (w : SplitPlace F) : toSplitAdele F k w = (k : w.1.adicCompletion (fieldI F)) := rfl

example (k : fieldI F) : toSAdele F k = (mixedEmbedding (fieldI F) k, toSplitAdele F k) := rfl

example (r : unitRing F) : ((ofUnitRing F r : fieldI F) : ℂ) = r := rfl

example (u : unitVectors F) : ((unitL u : fieldI F) : ℂ) = u := rfl

/-- **A Tate model of `R̂`** (X01D § 2.0, the five facts M8b reads; FS131-KN9 § 4.1; typed by FS131-KT1): a continuous
homomorphism `π : W → R̂`, equivariant for multiplication by the unit vectors, onto, with kernel on the diagonal, its lattice
between `O′` and `d⁻¹·O′`, `W` covered by a compact set plus `O′`, and the archimedean points sent to archimedean
characters. -/
structure TateModel where
  /-- `π : W → R̂` (X01D: `a ↦ (r ↦ ψ(a r))`). -/
  π : AddChar (SAdeleRing F) (Dual F)
  /-- Fact 1: `π` is continuous. -/
  continuous_π : Continuous π
  /-- Fact 1: `π(u a) = u · π(a)` for every unit vector `u` (X01D l. 120). -/
  π_unit_mul : ∀ (u : unitVectors F) (a : SAdeleRing F), π (toSAdele F (unitL u) * a) = rot u (π a)
  /-- Fact 2: `π` is onto. -/
  surjective_π : Function.Surjective π
  /-- Fact 3: the kernel lies on the diagonal (`R^∨ ⊆ L`). -/
  ker_subset : ∀ a : SAdeleRing F, π a = 1 → ∃ y : fieldI F, a = toSAdele F y
  /-- Fact 3: `O′ ⊆ Λ` — the points of `O′` are in the kernel. -/
  stableIntegers_le : ∀ x ∈ stableIntegers F, π (toSAdele F x) = 1
  /-- Fact 3: `Λ ⊆ d⁻¹·O′` for an integer `d ≥ 1`. -/
  exists_nat_mul_mem : ∃ d : ℕ, d ≠ 0 ∧ ∀ y : fieldI F, π (toSAdele F y) = 1 → (d : fieldI F) * y ∈ stableIntegers F
  /-- Fact 4: `W = K + O′` with `K` compact (cocompactness). -/
  exists_isCompact : ∃ K : Set (SAdeleRing F), IsCompact K ∧
    ∀ a : SAdeleRing F, ∃ k ∈ K, ∃ x ∈ stableIntegers F, a = k + toSAdele F x
  /-- Fact 5: an archimedean point `(b, 0)` maps to an archimedean character, one with an additive real lift. -/
  arch_mem : ∀ b : mixedEmbedding.mixedSpace (fieldI F), π (b, 0) ∈ archChars (unitRing F)

namespace TateModel

variable {F} (D : TateModel F)

/-- **`Λ = R^∨`**, the lattice of `D`: the points of `L` in the kernel of `π`. -/
def Λ : AddSubgroup (fieldI F) where
  carrier := {y | D.π (toSAdele F y) = 1}
  add_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq, map_add, AddChar.map_add_eq_mul] at hx hy ⊢
    rw [hx, hy, mul_one]
  zero_mem' := by simp
  neg_mem' {x} hx := by
    simp only [Set.mem_setOf_eq, map_neg, AddChar.map_neg_eq_inv] at hx ⊢
    rw [hx, inv_one]

theorem mem_Λ {y : fieldI F} : y ∈ D.Λ ↔ D.π (toSAdele F y) = 1 := Iff.rfl

/-- **`ker π = ι(Λ)`** (fact 3 as X01D states it). -/
theorem ker_eq (a : SAdeleRing F) : D.π a = 1 ↔ ∃ y ∈ D.Λ, a = toSAdele F y := by
  constructor
  · intro h
    obtain ⟨y, rfl⟩ := D.ker_subset a h
    exact ⟨y, h, rfl⟩
  · rintro ⟨y, hy, rfl⟩
    exact hy

/-- **`Λ` is an `R`-module** (X01D l. 119: a fractional `R`-ideal), from the equivariance: `Λ` is stable under the unit
vectors, hence under the ring they generate. -/
theorem mul_mem_Λ (r : unitRing F) {y : fieldI F} (hy : y ∈ D.Λ) : ofUnitRing F r * y ∈ D.Λ := by
  sorry

/-- **Two lifts of one character differ by a point of `Λ`** (the form Steps 3–4 of X01D read, ll. 256, 271). -/
theorem π_eq_π_iff (a b : SAdeleRing F) : D.π a = D.π b ↔ ∃ y ∈ D.Λ, a = b + toSAdele F y := by
  sorry

/-- **Global points are torsion** (X01D l. 121: `T = L/R^∨`, the half Step 7 reads): for `t ∈ L`, `π(t)` has finite order —
`N t ∈ 𝓞 L ⊆ O′ ⊆ Λ` for some integer `N ≥ 1`. -/
theorem toSAdele_mem_torsionChars (t : fieldI F) : D.π (toSAdele F t) ∈ torsionChars (unitRing F) := by
  sorry

/-- **Fact 5, as M8b reads it: `π(L + L_∞) ⊆ T + A`** (X01D l. 121, the inclusion Step 7 reads at l. 306). -/
theorem mem_TA (t : fieldI F) (b : mixedEmbedding.mixedSpace (fieldI F)) :
    D.π (toSAdele F t + (b, 0)) ∈ TA F := by
  rw [AddChar.map_add_eq_mul]
  exact Set.mul_mem_mul (D.toSAdele_mem_torsionChars t) (D.arch_mem b)

/-- **`π` is open** (read by Lemma 3.1′ (i), X01D l. 230): the open mapping theorem for the σ-compact `W`
(`AddChar.toMonoidHom` and `MonoidHom.isOpenMap_of_sigmaCompact`). -/
theorem isOpenMap : IsOpenMap D.π := by
  sorry

end TateModel

end

end HadwigerNelson.Rigidity
