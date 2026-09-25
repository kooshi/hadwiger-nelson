-- PLANT (J16 stage 2): the involution hypothesis dropped from leaf 1; must fail to elaborate.
import Proofs.HadwigerNelson.Chain
import Proofs.HadwigerNelson.ResidueColouring
import Mathlib.RingTheory.Valuation.LocalSubring

/-!
# The unit-vector ring and prime inversion, valuation form (FS-47)

The **unit-vector ring** `ℤ[U]` of a field `L` with an involution `σ` is the subring the norm-one elements generate
(M56's `Σ₀`, `[Fischer1990b]`'s lattice). In the plane, `L = F(i)`, `σ` is complex conjugation and the norm-one elements are
the unit vectors.

**Prime inversion, valuation form** (`inv_natCast_mem_unitRing_iff`): `1/n ∈ ℤ[U]` iff `1/n` lies in every σ-stable valuation
subring of `L` — equivalently (`inv_natCast_mem_unitRing_iff_not_mem_nonunits`) no σ-stable valuation subring has `n` in its
maximal ideal. The two directions:
- *only if*: every norm-one element lies in every σ-stable valuation subring (`normOne_subset_valuationSubring`, row 57);
- *if*: Chevalley's domination (`Ideal.image_subset_nonunits_valuationSubring`, Stacks 00IA) — a non-unit of a subring is a
  non-unit of some valuation subring above it — and a valuation subring holds every norm-one element exactly when it is
  σ-stable (`normOne_subset_iff_stable`).

**What is not proved here.** GPT Astra's Theorem 1.2 (`plans/ASTRA-2026-09-14-derivation.md` T2) reads the right-hand side as
"no conjugation-stable prime of `F(i)` lies above `n`", for a real number field `F`. The translation — σ-stable valuation
subrings of a number field with `n` in the maximal ideal are the conjugation-stable primes of its integers above `n` — is row
57's named gap (FS-37), and the kernel does not hold it. So "the 2-adic wall is broken" is, in the kernel,
`inv_two_mem_unitRing_iff`'s right-hand side, not the statement about primes.

**The plane.** `unitRingOver F` is the unit-vector ring of the plane over `F : Subfield ℝ`, a subring of `ℂ`; it is the image
of the abstract ring for `L = F(i)` (`planeOverSubfield`, `conjOn`, `coe_mem_unitRingOver_iff`), so prime inversion reads in
the plane's vocabulary (`inv_natCast_mem_unitRingOver_iff`). And membership is a finite sum of unit vectors
(`exists_sum_eq_of_mem_unitRingOver`), which is exactly what the chain theorem consumes: **G55's chain theorem in ring form**,
`add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver` — a forcer at `δ` with `1/δ ∈ ℤ[U]` refuses its colour count.
-/

namespace HadwigerNelson
namespace UnitRing

open SimpleGraph SquareClass Chain

/-! ## The ring, over a field with an involution -/

section Abstract

variable {L : Type*} [Field L]

/-- **The unit-vector ring** `ℤ[U]`: the subring the norm-one elements of `σ` generate. -/
def unitRing (σ : L →+* L) : Subring L := Subring.closure (normOne σ)

theorem normOne_subset_unitRing (σ : L →+* L) : normOne σ ⊆ unitRing σ := Subring.subset_closure

/-- The ring lies in a subring exactly when the norm-one elements do. -/
theorem unitRing_le_iff {σ : L →+* L} {A : Subring L} : unitRing σ ≤ A ↔ normOne σ ⊆ A := Subring.closure_le

/-- **A valuation subring holds every norm-one element iff it is σ-stable.** `⟸` is `normOne_subset_valuationSubring`; `⟹`:
for `z ≠ 0`, `σz/z` has norm one, so `σz = (σz/z)·z`. Both directions use that `σ` is an involution. -/
theorem normOne_subset_iff_stable (σ : L →+* L) (B : ValuationSubring L) :
    normOne σ ⊆ (B : Set L) ↔ ∀ z ∈ B, σ z ∈ B := by
  refine ⟨fun h z hz => ?_, fun h => normOne_subset_valuationSubring B h hσσ⟩
  rcases eq_or_ne z 0 with rfl | hz0
  · simp
  · have hn : σ z / z ∈ normOne σ := by
      rw [mem_normOne, map_div₀, hσσ]
      have : σ z ≠ 0 := fun h0 => hz0 (by simpa [hσσ] using congrArg σ h0)
      field_simp
    have : σ z = σ z / z * z := by field_simp
    rw [this]
    exact B.mul_mem _ _ (h hn) hz

/-- The unit-vector ring lies in a valuation subring iff the valuation subring is σ-stable. -/
theorem unitRing_le_valuationSubring_iff (σ : L →+* L) (hσσ : ∀ z : L, σ (σ z) = z) (B : ValuationSubring L) :
    unitRing σ ≤ B.toSubring ↔ ∀ z ∈ B, σ z ∈ B := by
  rw [unitRing_le_iff, ← normOne_subset_iff_stable σ hσσ B]
  rfl

/-- **An element of a subring is invertible there iff its inverse lies in every valuation subring above it** — Chevalley's
domination (`Ideal.image_subset_nonunits_valuationSubring`) applied to the principal ideal it generates. -/
theorem inv_mem_iff_forall_valuationSubring (R : Subring L) {x : L} (hx : x ∈ R) (hx0 : x ≠ 0) :
    x⁻¹ ∈ R ↔ ∀ B : ValuationSubring L, R ≤ B.toSubring → x⁻¹ ∈ B := by
  refine ⟨fun h B hB => hB h, fun h => ?_⟩
  by_contra hinv
  let I : Ideal R := Ideal.span {⟨x, hx⟩}
  have hI : I ≠ ⊤ := by
    intro htop
    obtain ⟨r, hr⟩ := Ideal.mem_span_singleton'.mp ((Ideal.eq_top_iff_one I).mp htop)
    have hr' : (r : L) * x = 1 := by simpa using congrArg Subtype.val hr
    exact hinv (by rw [inv_eq_of_mul_eq_one_left hr']; exact r.2)
  obtain ⟨B, hRB, hsub⟩ := Ideal.image_subset_nonunits_valuationSubring I hI
  have hxB : x ∈ B.nonunits := hsub ⟨⟨x, hx⟩, Ideal.mem_span_singleton_self _, rfl⟩
  rw [ValuationSubring.mem_nonunits_iff_or] at hxB
  rcases hxB with h0 | hnot
  · exact hx0 h0
  · exact hnot (h B hRB)

/-- **Prime inversion, valuation form** (FS-47 D3; GPT Astra's Theorem 1.2 with `[Fischer1990b]` Thms 1, 3–4 as special cases):
`1/n ∈ ℤ[U]` iff `1/n` lies in every σ-stable valuation subring.

**Not the number-field statement.** Reading the right-hand side as "no conjugation-stable prime of `F(i)` lies above `n`" for
a real number field `F` is row 57's gap (FS-37): that σ-stable valuation subrings with `n` in the maximal ideal are the
conjugation-stable primes above `n` is not proved in the kernel. -/
theorem inv_natCast_mem_unitRing_iff [CharZero L] (σ : L →+* L) (hσσ : ∀ z : L, σ (σ z) = z) {n : ℕ} (hn : n ≠ 0) :
    (n : L)⁻¹ ∈ unitRing σ ↔ ∀ B : ValuationSubring L, (∀ z ∈ B, σ z ∈ B) → (n : L)⁻¹ ∈ B := by
  rw [inv_mem_iff_forall_valuationSubring (unitRing σ) (natCast_mem _ n) (Nat.cast_ne_zero.mpr hn)]
  exact forall_congr' fun B => by rw [unitRing_le_valuationSubring_iff σ hσσ B]

/-- **Prime inversion, "no stable place above `n`" form**: `1/n ∈ ℤ[U]` iff no σ-stable valuation subring has `n` in its
maximal ideal. The number-field reading is row 57's gap, as in `inv_natCast_mem_unitRing_iff`. -/
theorem inv_natCast_mem_unitRing_iff_not_mem_nonunits [CharZero L] (σ : L →+* L) (hσσ : ∀ z : L, σ (σ z) = z) {n : ℕ}
    (hn : n ≠ 0) :
    (n : L)⁻¹ ∈ unitRing σ ↔ ∀ B : ValuationSubring L, (∀ z ∈ B, σ z ∈ B) → (n : L) ∉ B.nonunits := by
  rw [inv_natCast_mem_unitRing_iff σ hσσ hn]
  refine forall_congr' fun B => imp_congr_right fun _ => ?_
  rw [B.mem_nonunits_iff_or, not_or, not_not]
  exact ⟨fun h => ⟨Nat.cast_ne_zero.mpr hn, h⟩, fun h => h.2⟩

/-- **The 2-adic wall, valuation form** (G35): `1/2 ∈ ℤ[U]` iff no σ-stable valuation subring has `2` in its maximal ideal.
"The wall is broken" is the left-hand side; that the right-hand side says "every prime above 2 splits in `F(i)`" is row 57's
gap. -/
theorem inv_two_mem_unitRing_iff [CharZero L] (σ : L →+* L) (hσσ : ∀ z : L, σ (σ z) = z) :
    (2 : L)⁻¹ ∈ unitRing σ ↔ ∀ B : ValuationSubring L, (∀ z ∈ B, σ z ∈ B) → (2 : L) ∉ B.nonunits := by
  simpa using inv_natCast_mem_unitRing_iff_not_mem_nonunits σ hσσ (n := 2) two_ne_zero

end Abstract

/-! ## The plane: `F(i)` inside `ℂ`, conjugation, and the ring in the chain theorem's vocabulary -/

section Plane

/-- Conjugation keeps the plane over `F`. -/
theorem conj_mem_planeOver {F : Subfield ℝ} {z : ℂ} (hz : z ∈ planeOver F) : starRingEnd ℂ z ∈ planeOver F :=
  ⟨by simpa using hz.1, by simpa using F.neg_mem hz.2⟩

/-- **The plane over `F` is a subfield of `ℂ`** — it is `F(i)`: `z⁻¹ = z̄ / |z|²`. -/
def planeOverSubfield (F : Subfield ℝ) : Subfield ℂ :=
  { planeOverSubring F with
    inv_mem' := fun z hz => by
      have hz' : z ∈ planeOver F := hz
      have hn : Complex.normSq z ∈ F := by
        rw [Complex.normSq_apply]
        exact F.add_mem (F.mul_mem hz'.1 hz'.1) (F.mul_mem hz'.2 hz'.2)
      exact ⟨by rw [Complex.inv_re]; exact F.div_mem hz'.1 hn,
        by rw [Complex.inv_im]; exact F.div_mem (F.neg_mem hz'.2) hn⟩ }

@[simp] theorem mem_planeOverSubfield {F : Subfield ℝ} {z : ℂ} : z ∈ planeOverSubfield F ↔ z ∈ planeOver F := Iff.rfl

/-- **Complex conjugation on `F(i)`**, the involution whose norm-one elements are the unit vectors of `F²`. -/
noncomputable def conjOn (F : Subfield ℝ) : planeOverSubfield F →+* planeOverSubfield F :=
  (starRingEnd ℂ).restrict (planeOverSubfield F) (planeOverSubfield F) fun _ hz => conj_mem_planeOver hz

theorem coe_conjOn (F : Subfield ℝ) (z : planeOverSubfield F) : (conjOn F z : ℂ) = starRingEnd ℂ (z : ℂ) := rfl

theorem conjOn_conjOn (F : Subfield ℝ) (z : planeOverSubfield F) : conjOn F (conjOn F z) = z :=
  Subtype.ext (Complex.conj_conj _)

/-- **The unit-vector ring of the plane over `F`**: the subring of `ℂ` generated by the unit vectors of `F²`. -/
def unitRingOver (F : Subfield ℝ) : Subring ℂ := Subring.closure {z | z ∈ planeOver F ∧ ‖z‖ = 1}

theorem unit_mem_unitRingOver {F : Subfield ℝ} {z : ℂ} (hz : z ∈ planeOver F) (h1 : ‖z‖ = 1) : z ∈ unitRingOver F :=
  Subring.subset_closure ⟨hz, h1⟩

/-- The ring stays in the plane. -/
theorem unitRingOver_le_planeOverSubring (F : Subfield ℝ) : unitRingOver F ≤ planeOverSubring F :=
  Subring.closure_le.mpr fun _ hz => hz.1

/-- The norm-one elements of `conjOn F` are the unit vectors of `F²`. -/
theorem mem_normOne_conjOn_iff {F : Subfield ℝ} (z : planeOverSubfield F) : z ∈ normOne (conjOn F) ↔ ‖(z : ℂ)‖ = 1 := by
  have h : z ∈ normOne (conjOn F) ↔ (z : ℂ) ∈ normOne (starRingEnd ℂ) := by
    rw [mem_normOne, mem_normOne, Subtype.ext_iff]
    rfl
  rw [h, mem_normOne_conj_iff, Complex.normSq_eq_norm_sq]
  exact ⟨fun h2 => by nlinarith [norm_nonneg (z : ℂ)], fun h1 => by rw [h1]; norm_num⟩

/-- **The plane's ring is the abstract ring of `F(i)`**: an element of `F(i)` lies in `unitRingOver F` iff it lies in
`unitRing (conjOn F)`. -/
theorem coe_mem_unitRingOver_iff {F : Subfield ℝ} (x : planeOverSubfield F) :
    (x : ℂ) ∈ unitRingOver F ↔ x ∈ unitRing (conjOn F) := by
  constructor
  · intro hx
    have hle : unitRingOver F ≤ (unitRing (conjOn F)).map (planeOverSubfield F).subtype := by
      refine Subring.closure_le.mpr fun z hz => ?_
      exact ⟨⟨z, hz.1⟩, normOne_subset_unitRing _ ((mem_normOne_conjOn_iff _).mpr hz.2), rfl⟩
    obtain ⟨y, hy, hyx⟩ := hle hx
    rwa [show y = x from Subtype.ext hyx] at hy
  · intro hx
    have hle : unitRing (conjOn F) ≤ (unitRingOver F).comap (planeOverSubfield F).subtype :=
      unitRing_le_iff.mpr fun z hz => unit_mem_unitRingOver z.2 ((mem_normOne_conjOn_iff z).mp hz)
    exact hle hx

/-- **Prime inversion in the plane** (valuation form): `1/n` is in the unit-vector ring of `F²` iff no conjugation-stable
valuation subring of `F(i)` has `n` in its maximal ideal. The number-field reading is row 57's gap
(`inv_natCast_mem_unitRing_iff`). -/
theorem inv_natCast_mem_unitRingOver_iff (F : Subfield ℝ) {n : ℕ} (hn : n ≠ 0) :
    (n : ℂ)⁻¹ ∈ unitRingOver F ↔
      ∀ B : ValuationSubring (planeOverSubfield F), (∀ z ∈ B, conjOn F z ∈ B) →
        (n : planeOverSubfield F) ∉ B.nonunits := by
  have h : (n : ℂ)⁻¹ = (((n : planeOverSubfield F)⁻¹ : planeOverSubfield F) : ℂ) := by simp
  rw [h, coe_mem_unitRingOver_iff]
  exact inv_natCast_mem_unitRing_iff_not_mem_nonunits _ (conjOn_conjOn F) hn

/-- **Membership is a finite sum of unit vectors.** `U` is closed under products and negation and holds `1`, so the ring it
generates is its additive span; the representation is an existential, which is all the chain theorem needs. -/
theorem exists_sum_eq_of_mem_unitRingOver {F : Subfield ℝ} {x : ℂ} (hx : x ∈ unitRingOver F) :
    ∃ (m : ℕ) (u : Fin m → ℂ), (∀ j, ‖u j‖ = 1) ∧ (∀ j, u j ∈ planeOver F) ∧ ∑ j, u j = x := by
  let S : Set ℂ := {z | z ∈ planeOver F ∧ ‖z‖ = 1}
  suffices h : ∃ (m : ℕ) (u : Fin m → ℂ), (∀ j, u j ∈ S) ∧ ∑ j, u j = x by
    obtain ⟨m, u, hu, hs⟩ := h
    exact ⟨m, u, fun j => (hu j).2, fun j => (hu j).1, hs⟩
  refine Subring.closure_induction (p := fun x _ => ∃ (m : ℕ) (u : Fin m → ℂ), (∀ j, u j ∈ S) ∧ ∑ j, u j = x)
    ?_ ?_ ?_ ?_ ?_ ?_ hx
  · exact fun z hz => ⟨1, fun _ => z, fun _ => hz, by simp⟩
  · exact ⟨0, Fin.elim0, fun j => j.elim0, by simp⟩
  · exact ⟨1, fun _ => 1, fun _ => ⟨(planeOverSubring F).one_mem, by simp⟩, by simp⟩
  · rintro _ _ _ _ ⟨m, u, hu, rfl⟩ ⟨n, v, hv, rfl⟩
    refine ⟨m + n, Fin.append u v, fun j => ?_, by rw [Fin.sum_univ_add]; simp [Fin.append_left, Fin.append_right]⟩
    refine Fin.addCases (fun i => ?_) (fun i => ?_) j
    · simpa [Fin.append_left] using hu i
    · simpa [Fin.append_right] using hv i
  · rintro _ _ ⟨m, u, hu, rfl⟩
    exact ⟨m, fun j => -u j, fun j => ⟨(planeOverSubring F).neg_mem (hu j).1, by simpa using (hu j).2⟩,
      by simp [Finset.sum_neg_distrib]⟩
  · rintro _ _ _ _ ⟨m, u, hu, rfl⟩ ⟨n, v, hv, rfl⟩
    refine ⟨m * n, fun k => u (finProdFinEquiv.symm k).1 * v (finProdFinEquiv.symm k).2, fun k =>
      ⟨(planeOverSubring F).mul_mem (hu _).1 (hv _).1, by rw [norm_mul, (hu _).2, (hv _).2, one_mul]⟩, ?_⟩
    rw [Finset.sum_mul_sum, ← Fintype.sum_prod_type']
    exact Fintype.sum_equiv finProdFinEquiv.symm _ (fun p => u p.1 * v p.2) fun _ => rfl

/-- **G55's chain theorem in ring form**: a unit-distance drawing in `F²` forcing its marked pair equal at `k` colours, with
`δ = q b − q a ≠ 0` and `1/δ` in the unit-vector ring of `F²`, gives `χ(F²) ≥ k + 1` — the ring membership is the chain's
multipliers (`exists_sum_eq_of_mem_unitRingOver`). With prime inversion, `1/δ ∈ ℤ[U]` is decided place by place. -/
theorem add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver {F : Subfield ℝ} {ι : Type*} {G : SimpleGraph ι}
    {k : ℕ} (q : ι → ℂ) (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) (hqF : ∀ z, q z ∈ planeOver F) {a b : ι}
    (hf : Forces G k a b) (hδ : q b ≠ q a) (hinv : (q b - q a)⁻¹ ∈ unitRingOver F) :
    ((k + 1 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  obtain ⟨m, u, hu, huF, hsum⟩ := exists_sum_eq_of_mem_unitRingOver hinv
  exact add_one_le_chromaticNumber_planeOver_of_chain q hq hqF hf u hu huF
    (by rw [hsum]; exact mul_inv_cancel₀ (sub_ne_zero.mpr hδ))

end Plane

/-! ## Spec -/

-- The involution hypothesis is inhabited by complex conjugation.
example : ∀ z : ℂ, starRingEnd ℂ (starRingEnd ℂ z) = z := Complex.conj_conj

/-- **Spec, over `ℂ`**: `1/5 = (3+4i)/5 + (3−4i)/5 − 1` lies in `ℤ[U]`. -/
theorem inv_five_mem_unitRing_conj : (5 : ℂ)⁻¹ ∈ unitRing (starRingEnd ℂ) := by
  have hu : (⟨3 / 5, 4 / 5⟩ : ℂ) ∈ normOne (starRingEnd ℂ) := by
    rw [mem_normOne_conj_iff, Complex.normSq_mk]; norm_num
  have hv : (⟨3 / 5, -(4 / 5)⟩ : ℂ) ∈ normOne (starRingEnd ℂ) := by
    rw [mem_normOne_conj_iff, Complex.normSq_mk]; norm_num
  have h : (5 : ℂ)⁻¹ = ⟨3 / 5, 4 / 5⟩ + ⟨3 / 5, -(4 / 5)⟩ - 1 := by
    apply Complex.ext <;> norm_num
  rw [h]
  exact sub_mem (add_mem (normOne_subset_unitRing _ hu) (normOne_subset_unitRing _ hv)) (one_mem _)

-- Prime inversion consumed at `n = 5` over `ℂ`: every conjugation-stable valuation subring of `ℂ` holds `1/5`.
example : ∀ B : ValuationSubring ℂ, (∀ z ∈ B, starRingEnd ℂ z ∈ B) → (5 : ℂ)⁻¹ ∈ B :=
  (inv_natCast_mem_unitRing_iff (starRingEnd ℂ) Complex.conj_conj (n := 5) (by norm_num)).mp
    (by exact_mod_cast inv_five_mem_unitRing_conj)

-- `unitRingOver` over `ℚ`: `(3 + 4i)/5` is a unit vector of `ℚ²`, so `1/5 ∈ ℤ[U_ℚ]` by the same identity.
example : (5 : ℂ)⁻¹ ∈ unitRingOver (⊥ : Subfield ℝ) := by
  have hq : ∀ r : ℚ, (r : ℝ) ∈ (⊥ : Subfield ℝ) := fun r => SubfieldClass.ratCast_mem (⊥ : Subfield ℝ) r
  have hu : (⟨3 / 5, 4 / 5⟩ : ℂ) ∈ unitRingOver ⊥ :=
    unit_mem_unitRingOver ⟨by simpa using hq (3 / 5), by simpa using hq (4 / 5)⟩
      (norm_eq_one_of_sq (by norm_num))
  have hv : (⟨3 / 5, -(4 / 5)⟩ : ℂ) ∈ unitRingOver ⊥ :=
    unit_mem_unitRingOver ⟨by simpa using hq (3 / 5), by simpa using hq (-(4 / 5))⟩
      (norm_eq_one_of_sq (by norm_num))
  have h : (5 : ℂ)⁻¹ = ⟨3 / 5, 4 / 5⟩ + ⟨3 / 5, -(4 / 5)⟩ - 1 := by
    apply Complex.ext <;> norm_num
  rw [h]
  exact sub_mem (add_mem hu hv) (one_mem _)

end UnitRing
end HadwigerNelson
