import Proofs.HadwigerNelson.Rigidity.CountResidue
/-! First leaf of block R (scratch; FS131-K12A): `[S9]` at one unramified stable prime, by Hilbert 90 modulo `P^m`. -/
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField
variable {F : Subfield ℝ} [NumberField F]

theorem leafR (P : StablePrime F) (hP : ¬ IsRamified P) (m : ℕ) {s : 𝓞 (fieldI F) ⧸ P.P ^ m}
    (hs : s ∈ normOneQ P m) :
    ∃ (x : fieldI F) (hx : x ∈ normOneL F), P.residue m ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P hx⟩ = s := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective s
  have ha : a * conjO F a - 1 ∈ P.P ^ m := by
    have h := hs
    simp only [normOneQ, Set.mem_setOf_eq, Ideal.quotientMap_mk] at h
    rw [← map_mul, ← map_one (Ideal.Quotient.mk _), Ideal.Quotient.eq] at h
    exact h
  obtain ⟨ζ, hζ⟩ : ∃ ζ : 𝓞 (fieldI F), conjO F ζ - ζ ∉ P.P := by
    by_contra h
    push Not at h
    exact hP h
  obtain ⟨w, hw⟩ : ∃ w : 𝓞 (fieldI F), w + a * conjO F w ∉ P.P := by
    by_contra h
    push Not at h
    have h1 := h 1
    rw [map_one, mul_one] at h1
    apply hζ
    have e : conjO F ζ - ζ = (1 + a) * conjO F ζ - (ζ + a * conjO F ζ) := by ring
    rw [e]
    exact P.P.sub_mem (P.P.mul_mem_right _ h1) (h ζ)
  set z := w + a * conjO F w with hzdef
  have hzb : conjO F z ∉ P.P := fun h => hw ((UpperHalf.conjO_mem_iff P).mp h)
  have hzz : z - a * conjO F z ∈ P.P ^ m := by
    have e : z - a * conjO F z = -(w * (a * conjO F a - 1)) := by
      rw [hzdef, map_add, map_mul, UpperHalf.conjO_conjO]
      ring
    rw [e]
    exact neg_mem (Ideal.mul_mem_left _ _ ha)
  have hz0 : (z : fieldI F) ≠ 0 := fun h0 =>
    hw (by rw [RingOfIntegers.coe_eq_zero_iff.1 h0]; exact P.P.zero_mem)
  have hzb0 : ((conjO F z : 𝓞 (fieldI F)) : fieldI F) ≠ 0 := fun h0 =>
    hzb (by rw [RingOfIntegers.coe_eq_zero_iff.1 h0]; exact P.P.zero_mem)
  have hconj : ((conjO F z : 𝓞 (fieldI F)) : fieldI F) = conjOn (fieldI_conj F) (z : fieldI F) :=
    UpperHalf.coe_conjO z
  have hx : (z : fieldI F) / ((conjO F z : 𝓞 (fieldI F)) : fieldI F) ∈ normOneL F := by
    show _ * _ = _
    rw [hconj] at hzb0 ⊢
    rw [map_div₀, conjOn_conjOn]
    field_simp
  refine ⟨_, hx, ?_⟩
  have hres := UpperHalf.residue_div P m z (conjO F z) hzb
  have hunit : IsUnit (Ideal.Quotient.mk (P.P ^ m) (conjO F z)) :=
    UpperHalf.isUnit_mk_pow P m ⟨conjO F z, hzb⟩
  have hmk : Ideal.Quotient.mk (P.P ^ m) z = Ideal.Quotient.mk (P.P ^ m) a * Ideal.Quotient.mk (P.P ^ m) (conjO F z) := by
    rw [← map_mul, Ideal.Quotient.eq]
    exact hzz
  rw [hmk] at hres
  exact hunit.mul_right_cancel hres

end HadwigerNelson.Rigidity.Counting
