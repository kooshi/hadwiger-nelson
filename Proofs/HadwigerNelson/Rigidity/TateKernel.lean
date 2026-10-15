import Proofs.HadwigerNelson.Rigidity.TateCharacter
import Proofs.HadwigerNelson.Rigidity.Duality

/-!
# Lane T, Tate's `L^⊥ = L` in the form the model reads: the kernel, its bound, the cover, the surjectivity (FS-131, job FS131-KT1)

**Read aloud.** `oAnn F` is the annihilator of `O′` in `W` under the standard character, `{a | ψ(a s) = 1 for all s ∈ O′}`.
* `exists_eq_mixedEmbedding_of_mem_oAnn` — **the archimedean step**: a point of `oAnn` integral at every split prime has its
  archimedean part on the diagonal (`exists_eq_mixedEmbedding_of_archTrace_int`, tested on `𝓞 L`).
* `eq_zero_of_mem_oAnn` — **the split step, local non-degeneracy**: a point `c` of `oAnn` with archimedean part `0`, integral
  at every split prime, is `0`. If `c_{w₀} ≠ 0`, take `t₀` integral off `w₀` with `Tr t₀ ∉ ℤ` (`exists_trace_not_int_away`)
  and `s` integral off `w₀` with `s ≡ t₀ / c_{w₀}` modulo `O_{w₀}` (`exists_approx_completion`): `t₀` approximates `c·s`, so
  `ψ(c s) = e(−Tr t₀) ≠ 1`, though `s ∈ O′`.
* `exists_nat_forall_mem_oAnn` — **`oAnn ⊆ ι(d₀⁻¹·O′)`**: subtract an approximant `t_a` (`ι(O′) ⊆ oAnn`, the product formula
  `tateChar_toSAdele_of_mem`), apply the archimedean step to get `y`, multiply `b − ι y` by the denominator `d₀` of the trace
  dual (`exists_nat_mul_integral_of_trace_int`) so that every test element stays in `O′`, apply the split step. The inverse
  different never enters (`plans/FS131-KT1-tate.md` § 4.2).
* `tatePi_ker_subset`, `tatePi_exists_nat_mul_mem` — **fact 3** for `R`: `c·O′ ⊆ R` (`exists_mul_stableIntegers_le`, lane M9-R)
  puts `c·a` in `oAnn` when `π a = 1`; the bound is `d = d₀·c`.
* `tatePi_exists_isCompact` — **fact 4**: `K := closure(fundamental domain of 𝓞 L in L_∞) × ∏_{split} O_w`, compact
  (`ZSpan.fundamentalDomain_isBounded`, `compactSpace_adicCompletionIntegers` and Tychonoff); subtract an approximant, then an
  element of `𝓞 L` (`ZSpan.exist_unique_vadd_mem_fundamentalDomain`).
* `tatePi_eq_one_forall_imp` and `surjective_tatePi` — **fact 2**: the annihilator of `π(W)` in `R` is `0` (an archimedean
  point `(b, 0)` with `Tr_∞(b r) = 1/2`, using `archTrace_mixedEmbedding_one`), and `π(W) = π(K)` is compact, so closed; D2's
  case `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` (lane PD) gives `π(W) = R̂`.

**Inhabitants.** Statements about the definitions of `Rigidity/TateCharacter` at every real number field.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum

open scoped RestrictedProduct

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- **The annihilator of `O′` in `W`** under the standard character. -/
def oAnn : Set (SAdeleRing F) := {a | ∀ s ∈ stableIntegers F, tateChar F (a * toSAdele F s) = 1}

variable {F}

/-- An integer of `L` is integral at every prime. -/
private theorem valuation_coe_le_one (v : HeightOneSpectrum (𝓞 (fieldI F))) (s : 𝓞 (fieldI F)) :
    v.valuation (fieldI F) (s : fieldI F) ≤ 1 := by
  show v.valuation (fieldI F) (algebraMap (𝓞 (fieldI F)) (fieldI F) s) ≤ 1
  rw [valuation_of_algebraMap]
  exact v.intValuation_le_one s

/-- An element of `L` is integral in `L_v` exactly when its valuation is at most `1`. -/
private theorem coe_mem_integers_iff (v : HeightOneSpectrum (𝓞 (fieldI F))) (x : fieldI F) :
    (x : v.adicCompletion (fieldI F)) ∈ v.adicCompletionIntegers (fieldI F) ↔ v.valuation (fieldI F) x ≤ 1 := by
  rw [mem_adicCompletionIntegers, valuedAdicCompletion_eq_valuation']

/-- The integers of `L` lie in `O′`. -/
private theorem coe_mem_stableIntegers (s : 𝓞 (fieldI F)) : (s : fieldI F) ∈ stableIntegers F :=
  (mem_stableIntegers_iff_valuation F).2 fun v _ => valuation_coe_le_one v s

/-- An element integral off one split prime lies in `O′` (the stable primes are not split). -/
private theorem mem_stableIntegers_of_away (w : SplitPlace F) {x : fieldI F}
    (hx : ∀ v ≠ w.1, v.valuation (fieldI F) x ≤ 1) : x ∈ stableIntegers F :=
  (mem_stableIntegers_iff_valuation F).2 fun v hv => hx v fun h => w.2 (h ▸ hv)

/-- The split components of a product, a difference and a diagonal point. -/
private theorem snd_mul_apply (a b : SAdeleRing F) (w : SplitPlace F) : (a * b).2 w = a.2 w * b.2 w := rfl

private theorem snd_sub_apply (a b : SAdeleRing F) (w : SplitPlace F) : (a - b).2 w = a.2 w - b.2 w := rfl

private theorem toSAdele_snd_apply (x : fieldI F) (w : SplitPlace F) :
    (toSAdele F x).2 w = (x : w.1.adicCompletion (fieldI F)) := rfl

/-- `e(2πx) = 1` makes `x` an integer. -/
private theorem exists_int_of_exp_eq_one {x : ℝ} (h : Circle.exp (2 * Real.pi * x) = 1) : ∃ n : ℤ, x = n := by
  obtain ⟨n, hn⟩ := Circle.exp_eq_one.1 h
  refine ⟨n, mul_left_cancel₀ (by positivity : (2 * Real.pi) ≠ 0) ?_⟩
  rw [hn]; ring

/-- The diagonal is injective (its archimedean part is). -/
private theorem toSAdele_injective : Function.Injective (toSAdele F) := fun _ _ h =>
  mixedEmbedding_injective (fieldI F) (congrArg Prod.fst h)

/-- `oAnn` is stable under subtracting a point of `ι(O′)` (`ι(O′) ⊆ oAnn`, the product formula on `O′`). -/
private theorem sub_toSAdele_mem_oAnn {a : SAdeleRing F} (ha : a ∈ oAnn F) {t : fieldI F}
    (ht : t ∈ stableIntegers F) : a - toSAdele F t ∈ oAnn F := fun s hs => by
  rw [sub_mul, ← map_mul, AddChar.map_sub_eq_div, ha s hs, tateChar_toSAdele_of_mem F (mul_mem ht hs), div_one]

/-- **The archimedean step.** -/
theorem exists_eq_mixedEmbedding_of_mem_oAnn {a : SAdeleRing F} (ha : a ∈ oAnn F)
    (hint : ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) :
    ∃ y : fieldI F, a.1 = mixedEmbedding (fieldI F) y ∧
      ∀ s : 𝓞 (fieldI F), ∃ n : ℤ, Algebra.trace ℚ (fieldI F) (y * s) = n := by
  -- `ψ(a·ι s) = e(Tr_∞(a_∞ · ι_∞ s))` for `s ∈ 𝓞 L` (the approximant `0`), and it is `1`
  have htr : ∀ s : 𝓞 (fieldI F), ∃ n : ℤ,
      archTrace (fieldI F) (a.1 * mixedEmbedding (fieldI F) (s : fieldI F)) = n := fun s => by
    have hi : ∀ w : SplitPlace F, (a * toSAdele F (s : fieldI F)).2 w ∈ w.1.adicCompletionIntegers (fieldI F) :=
      fun w => mul_mem (hint w) ((coe_mem_integers_iff w.1 _).2 (valuation_coe_le_one w.1 s))
    have h1 := ha _ (coe_mem_stableIntegers s)
    rw [tateChar_of_integral F hi] at h1
    exact exists_int_of_exp_eq_one h1
  obtain ⟨y, hy⟩ := exists_eq_mixedEmbedding_of_archTrace_int a.1 htr
  refine ⟨y, hy, fun s => ?_⟩
  obtain ⟨n, hn⟩ := htr s
  rw [hy, ← map_mul, archTrace_mixedEmbedding] at hn
  exact ⟨n, by exact_mod_cast hn⟩

/-- **The split step (local non-degeneracy).** -/
theorem eq_zero_of_mem_oAnn {c : SAdeleRing F} (hc : c ∈ oAnn F) (h1 : c.1 = 0)
    (hint : ∀ w : SplitPlace F, c.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) : c = 0 := by
  have h2 : ∀ w : SplitPlace F, c.2 w = 0 := by
    by_contra hne
    push Not at hne
    obtain ⟨w₀, hw₀⟩ := hne
    -- `t₀` integral off `w₀` with `Tr t₀ ∉ ℤ`, and `s ≡ t₀ / c_{w₀}` at `w₀`, integral off `w₀`
    obtain ⟨t₀, ht₀, htr⟩ := exists_trace_not_int_away w₀.1
    obtain ⟨s, hs, hst⟩ := exists_approx_completion w₀.1 ((t₀ : w₀.1.adicCompletion (fieldI F)) / c.2 w₀)
    -- `t₀` approximates `c·ι s`
    have hap : IsApprox F (c * toSAdele F s) t₀ := by
      refine ⟨mem_stableIntegers_of_away w₀ ht₀, fun w => ?_⟩
      show c.2 w * (s : w.1.adicCompletion (fieldI F)) - (t₀ : w.1.adicCompletion (fieldI F)) ∈ _
      by_cases hw : w = w₀
      · obtain rfl := hw
        have he : c.2 w * (s : w.1.adicCompletion (fieldI F)) - (t₀ : w.1.adicCompletion (fieldI F)) =
            -(c.2 w * ((t₀ : w.1.adicCompletion (fieldI F)) / c.2 w - s)) := by
          rw [mul_sub, mul_div_cancel₀ _ hw₀]; ring
        rw [he]
        exact neg_mem (mul_mem (hint w) hst)
      · have hw' : w.1 ≠ w₀.1 := fun h => hw (Subtype.ext h)
        exact sub_mem (mul_mem (hint w) ((coe_mem_integers_iff w.1 s).2 (hs w.1 hw')))
          ((coe_mem_integers_iff w.1 t₀).2 (ht₀ w.1 hw'))
    have hψ : tateCharFun F (c * toSAdele F s) = 1 := hc s (mem_stableIntegers_of_away w₀ hs)
    rw [tateCharFun_eq F hap, show (c * toSAdele F s).1 = c.1 * mixedEmbedding (fieldI F) s from rfl, h1, zero_mul,
      map_zero, zero_sub] at hψ
    obtain ⟨n, hn⟩ := exists_int_of_exp_eq_one hψ
    refine htr (-n) ?_
    have hn' : ((Algebra.trace ℚ (fieldI F) t₀ : ℚ) : ℝ) = ((-n : ℤ) : ℝ) := by
      rw [Int.cast_neg]; linarith
    exact_mod_cast hn'
  exact Prod.ext h1 (RestrictedProduct.ext _ _ h2)

variable (F) in
/-- **Tate's `O′^⊥ ⊆ L`, with its bound**: the annihilator of `O′` lies on the diagonal, inside `d₀⁻¹·O′`. -/
theorem exists_nat_forall_mem_oAnn :
    ∃ d₀ : ℕ, d₀ ≠ 0 ∧ ∀ a ∈ oAnn F, ∃ x : fieldI F, a = toSAdele F x ∧ (d₀ : fieldI F) * x ∈ stableIntegers F := by
  obtain ⟨d₀, hd₀, hd⟩ := exists_nat_mul_integral_of_trace_int (K := fieldI F)
  refine ⟨d₀, hd₀, fun a ha => ?_⟩
  -- 1. subtract an approximant
  obtain ⟨t, ht⟩ := exists_isApprox F a
  obtain ⟨b, hb⟩ : ∃ b, b = a - toSAdele F t := ⟨_, rfl⟩
  have hbO : b ∈ oAnn F := hb ▸ sub_toSAdele_mem_oAnn ha ht.1
  have hbint : ∀ w : SplitPlace F, b.2 w ∈ w.1.adicCompletionIntegers (fieldI F) := fun w => by
    rw [hb]; exact ht.2 w
  -- 2. the archimedean step
  obtain ⟨y, hy, htry⟩ := exists_eq_mixedEmbedding_of_mem_oAnn hbO hbint
  have hdyO : (d₀ : fieldI F) * y ∈ stableIntegers F :=
    (mem_stableIntegers_iff_valuation F).2 fun v _ => hd y htry v
  -- 3. `c := d₀(b − ι y)` lies in `oAnn`, with archimedean part `0`, integral at every split prime
  obtain ⟨c, hc⟩ : ∃ c, c = toSAdele F (d₀ : fieldI F) * (b - toSAdele F y) := ⟨_, rfl⟩
  have hc1 : c.1 = 0 := by
    rw [hc]
    show mixedEmbedding (fieldI F) (d₀ : fieldI F) * (b.1 - mixedEmbedding (fieldI F) y) = 0
    rw [hy, sub_self, mul_zero]
  have hcint : ∀ w : SplitPlace F, c.2 w ∈ w.1.adicCompletionIntegers (fieldI F) := fun w => by
    have hm : (((d₀ : fieldI F) * y : fieldI F) : w.1.adicCompletion (fieldI F)) =
        ((d₀ : fieldI F) : w.1.adicCompletion (fieldI F)) * (y : w.1.adicCompletion (fieldI F)) :=
      map_mul (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))) _ _
    rw [hc, snd_mul_apply, snd_sub_apply, toSAdele_snd_apply, toSAdele_snd_apply, mul_sub, ← hm]
    exact sub_mem (mul_mem ((coe_mem_integers_iff w.1 _).2 (by simpa using valuation_coe_le_one w.1 (d₀ : 𝓞 (fieldI F))))
      (hbint w)) ((coe_mem_integers_iff w.1 _).2 (hd y htry w.1))
  have hcO : c ∈ oAnn F := fun s hs => by
    have he : c * toSAdele F s =
        b * toSAdele F ((d₀ : fieldI F) * s) - toSAdele F ((d₀ : fieldI F) * y * s) := by
      rw [hc, map_mul, map_mul, map_mul]; ring
    rw [he, AddChar.map_sub_eq_div, hbO _ (mul_mem (natCast_mem _ d₀) hs),
      tateChar_toSAdele_of_mem F (mul_mem hdyO hs), div_one]
  -- 4. local non-degeneracy, and `ι d₀` is a unit
  have hc0 := eq_zero_of_mem_oAnn hcO hc1 hcint
  have hbeq : b = toSAdele F y := by
    have hu : toSAdele F ((d₀ : fieldI F))⁻¹ * c = b - toSAdele F y := by
      rw [hc, ← mul_assoc, ← map_mul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hd₀), map_one, one_mul]
    rw [← sub_eq_zero, ← hu, hc0, mul_zero]
  refine ⟨t + y, ?_, ?_⟩
  · rw [map_add, ← hbeq, hb, add_sub_cancel]
  · rw [mul_add]
    exact add_mem (mul_mem (natCast_mem _ d₀) ht.1) hdyO

/-- **`π a = 1` puts `ι(c)·a` in `oAnn`**, for `c` with `c·O′ ⊆ R` (`exists_mul_stableIntegers_le`): for `s ∈ O′`,
`ψ(ι(c) a ι(s)) = π(a)(c s) = 1`. -/
private theorem toSAdele_mul_mem_oAnn {c : ℕ}
    (hc : ∀ x ∈ stableIntegers F, (c : fieldI F) * x ∈ UnitRing.unitRing (conjOn (fieldI_conj F)))
    {a : SAdeleRing F} (ha : tatePi F a = 1) : toSAdele F (c : fieldI F) * a ∈ oAnn F := fun s hs => by
  let r : unitRing F := ⟨(((c : fieldI F) * s : fieldI F) : ℂ), (UnitRing.coe_mem_unitRingOver_iff _).2 (hc s hs)⟩
  have hra : ofUnitRing F r = (c : fieldI F) * s := Subtype.ext rfl
  have h := DFunLike.congr_fun ha r
  rw [tatePi_apply, hra, AddChar.one_apply] at h
  rw [mul_comm (toSAdele F _) a, mul_assoc, ← map_mul]
  exact h

variable (F)

/-- **Fact 3, the kernel on the diagonal**, for `R`. -/
theorem tatePi_ker_subset (a : SAdeleRing F) (ha : tatePi F a = 1) : ∃ y : fieldI F, a = toSAdele F y := by
  obtain ⟨c, hc0, hc⟩ := exists_mul_stableIntegers_le F
  obtain ⟨d₀, -, hd⟩ := exists_nat_forall_mem_oAnn F
  obtain ⟨x, hx, -⟩ := hd _ (toSAdele_mul_mem_oAnn hc ha)
  refine ⟨((c : fieldI F))⁻¹ * x, ?_⟩
  rw [map_mul, ← hx, ← mul_assoc, ← map_mul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hc0), map_one, one_mul]

/-- **Fact 3, `Λ ⊆ d⁻¹·O′`**, for `R` (`d = d₀·c`). -/
theorem tatePi_exists_nat_mul_mem :
    ∃ d : ℕ, d ≠ 0 ∧ ∀ y : fieldI F, tatePi F (toSAdele F y) = 1 → (d : fieldI F) * y ∈ stableIntegers F := by
  obtain ⟨c, hc0, hc⟩ := exists_mul_stableIntegers_le F
  obtain ⟨d₀, hd₀, hd⟩ := exists_nat_forall_mem_oAnn F
  refine ⟨d₀ * c, mul_ne_zero hd₀ hc0, fun y hy => ?_⟩
  obtain ⟨x, hx, hdx⟩ := hd _ (toSAdele_mul_mem_oAnn hc hy)
  rw [← map_mul] at hx
  have hxy : x = (c : fieldI F) * y := (toSAdele_injective hx).symm
  rw [Nat.cast_mul, mul_assoc, ← hxy]
  exact hdx

/-- **Fact 4, cocompactness.** -/
theorem tatePi_exists_isCompact : ∃ K : Set (SAdeleRing F), IsCompact K ∧
    ∀ a : SAdeleRing F, ∃ k ∈ K, ∃ x ∈ stableIntegers F, a = k + toSAdele F x := by
  classical
  haveI : ∀ w : SplitPlace F, CompactSpace (w.1.adicCompletionIntegers (fieldI F)) :=
    fun w => compactSpace_adicCompletionIntegers w.1
  let B := mixedEmbedding.latticeBasis (fieldI F)
  let H : Set (SplitAdeleRing F) := Set.range (RestrictedProduct.structureMap
    (fun w : SplitPlace F => w.1.adicCompletion (fieldI F))
    (fun w => (w.1.adicCompletionIntegers (fieldI F) : Set (w.1.adicCompletion (fieldI F)))) Filter.cofinite)
  have hH : IsCompact H := isCompact_range RestrictedProduct.isEmbedding_structureMap.continuous
  have hD : IsCompact (closure (ZSpan.fundamentalDomain B)) := (ZSpan.fundamentalDomain_isBounded B).isCompact_closure
  refine ⟨closure (ZSpan.fundamentalDomain B) ×ˢ H, hD.prod hH, fun a => ?_⟩
  -- an approximant, then the integer part of the archimedean remainder in the lattice `ι_∞(𝓞 L)`
  obtain ⟨t, ht⟩ := exists_isApprox F a
  obtain ⟨s, hs⟩ := (mixedEmbedding.mem_span_latticeBasis (fieldI F)).1 (ZSpan.floor B (a - toSAdele F t).1).2
  have hs' : mixedEmbedding (fieldI F) (s : fieldI F) = (ZSpan.floor B (a - toSAdele F t).1 : _) := hs
  refine ⟨a - toSAdele F (t + s), ⟨?_, ?_⟩, t + s, add_mem ht.1 (coe_mem_stableIntegers s), by abel⟩
  · have he : (a - toSAdele F (t + s)).1 = ZSpan.fract B (a - toSAdele F t).1 := by
      rw [ZSpan.fract_apply, ← hs', map_add, ← sub_sub]
      rfl
    rw [he]
    exact subset_closure (ZSpan.fract_mem_fundamentalDomain B _)
  · have hmem : ∀ w : SplitPlace F, (a - toSAdele F (t + s)).2 w ∈ w.1.adicCompletionIntegers (fieldI F) := fun w => by
      have ha' : (((t + s : fieldI F)) : w.1.adicCompletion (fieldI F)) =
          (t : w.1.adicCompletion (fieldI F)) + ((s : fieldI F) : w.1.adicCompletion (fieldI F)) :=
        map_add (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))) _ _
      rw [snd_sub_apply, toSAdele_snd_apply, ha', ← sub_sub]
      exact sub_mem (ht.2 w) ((coe_mem_integers_iff w.1 _).2 (valuation_coe_le_one w.1 s))
    obtain ⟨h, hh⟩ := RestrictedProduct.exists_structureMap_eq_of_forall _ _ hmem
    exact ⟨h, hh⟩

/-- **The annihilator of `π(W)` in `R` is `0`.** -/
theorem tatePi_eq_one_forall_imp (r : unitRing F) (h : ∀ a : SAdeleRing F, tatePi F a r = 1) : r = 0 := by
  by_contra hr
  have hx : ofUnitRing F r ≠ 0 := by
    intro h0
    apply hr
    apply Subtype.ext
    have h0' : ((ofUnitRing F r : fieldI F) : ℂ) = 0 := by rw [h0]; rfl
    exact h0'
  have hn : (Module.finrank ℚ (fieldI F) : ℚ) ≠ 0 := Nat.cast_ne_zero.2 Module.finrank_pos.ne'
  -- `b := ι_∞(q / x)`, `q = 1/(2[L:ℚ])`: then `Tr_∞(b·ι_∞ x) = Tr q = 1/2`, and `π(b, 0)(r) = e(π) ≠ 1`
  let q : ℚ := 1 / (2 * (Module.finrank ℚ (fieldI F) : ℚ))
  let b := mixedEmbedding (fieldI F) (algebraMap ℚ (fieldI F) q * (ofUnitRing F r)⁻¹)
  have h1 := h (b, 0)
  rw [tatePi_apply, tateChar_of_integral F fun w => by
    show ((0 : SplitAdeleRing F) * toSplitAdele F (ofUnitRing F r)) w ∈ _
    rw [zero_mul]; exact zero_mem _] at h1
  have h2 : ((b, 0) * toSAdele F (ofUnitRing F r) : SAdeleRing F).1 =
      mixedEmbedding (fieldI F) (algebraMap ℚ (fieldI F) q) := by
    show b * mixedEmbedding (fieldI F) (ofUnitRing F r) = _
    rw [← map_mul, mul_assoc, inv_mul_cancel₀ hx, mul_one]
  rw [h2, archTrace_mixedEmbedding, Algebra.trace_algebraMap] at h1
  obtain ⟨m, hm⟩ := exists_int_of_exp_eq_one h1
  have hq : (Module.finrank ℚ (fieldI F) • q : ℚ) = 1 / 2 := by
    rw [nsmul_eq_mul]
    show (Module.finrank ℚ (fieldI F) : ℚ) * (1 / (2 * (Module.finrank ℚ (fieldI F) : ℚ))) = 1 / 2
    field_simp
  rw [hq] at hm
  have h3 : ((2 * m : ℤ) : ℝ) = 1 := by push_cast; norm_num at hm; linarith
  have h4 : 2 * m = 1 := by exact_mod_cast h3
  omega

/-- **Fact 2, surjectivity.** -/
theorem surjective_tatePi : Function.Surjective (tatePi F) := by
  haveI : Countable (unitRing F) := @countable_unitRing F (Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F))
  obtain ⟨K, hK, hcov⟩ := tatePi_exists_isCompact F
  let Y : Subgroup (Dual F) := (tatePi F).toMonoidHom.range
  -- `π(W) = π(K)`, since `ι(O′)` is in the kernel
  have hrange : (Y : Set (Dual F)) = tatePi F '' K := by
    ext χ
    constructor
    · rintro ⟨a, rfl⟩
      obtain ⟨k, hk, x, hx, ha⟩ := hcov (Multiplicative.toAdd a)
      refine ⟨k, hk, ?_⟩
      show tatePi F k = tatePi F (Multiplicative.toAdd a)
      rw [ha, AddChar.map_add_eq_mul, tatePi_toSAdele_of_mem F hx, mul_one]
    · rintro ⟨k, -, rfl⟩
      exact ⟨Multiplicative.ofAdd k, rfl⟩
  have hY : IsClosed (Y : Set (Dual F)) := by
    rw [hrange]
    exact (hK.image (continuous_tatePi F)).isClosed
  have hbot : dualCoannihilator Y = ⊥ := by
    refine (AddSubgroup.eq_bot_iff_forall _).2 fun r hr => tatePi_eq_one_forall_imp F r fun a => ?_
    exact hr _ ⟨Multiplicative.ofAdd a, rfl⟩
  have htop := eq_top_of_isClosed_of_dualCoannihilator_eq_bot Y hY hbot
  intro χ
  have hχ : χ ∈ Y := htop ▸ Subgroup.mem_top χ
  obtain ⟨a, ha⟩ := hχ
  exact ⟨Multiplicative.toAdd a, ha⟩

end

end HadwigerNelson.Rigidity
