import Proofs.HadwigerNelson.Rigidity.TateModel
import Proofs.HadwigerNelson.Rigidity.TateLocal
import Proofs.HadwigerNelson.Rigidity.TateArch

/-!
# Lane T, the standard character of `W` and the map `π` (FS-131, job FS131-KT1; skeleton)

Form G of the standard character (`plans/FS131-KT1-tate.md` § Stage 3), on `W = L_∞ × ∏′_{w split} L_w` with `L = F(i)`:

  `ψ(a) := e(Tr_∞(a_∞) − Tr_{L/ℚ}(t))` for any **approximant** `t` of `a` — an element of `O′` congruent to `a_w` modulo
  `O_w` at every split prime (`IsApprox`).

The approximant exists (`exists_isApprox`, from `exists_approx_completion` at the finitely many split primes where `a` is not
integral, summed), and two approximants differ by an element integral at every prime, whose trace is an integer
(`exists_int_trace_sub_of_isApprox`), so `ψ` is well defined (`tateCharFun_eq`). It is the restriction to `W` of the standard
character of the adeles (X01D l. 118; [Tate1950] § 4.1): at a split prime `w` the local factor is
`ψ_w(z) = e(−Tr(t_z))` for `t_z` integral off `w`, and the factors at the stable primes are absorbed by `O′`.

`π a := (r ↦ ψ(a r))` (`tatePi`, X01D l. 119). The facts of `TateModel` that read `ψ` alone are here: `π` continuous
(`continuous_tatePi`), equivariant (`tatePi_unit_mul`), `O′` in its kernel (`tatePi_toSAdele_of_mem`), archimedean points to
archimedean characters (`tatePi_arch_mem`). The kernel, the bound and the cover are `Rigidity/TateKernel`.

**Inhabitants.** `ψ` and `π` are definitions; their spec examples are `tatePi_apply` and `tateCharFun_eq` at `t` itself.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum

open scoped RestrictedProduct

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- **`O′` read through the valuations**: an element of `F(i)` lies in `O′` exactly when it is integral at every stable
prime (`StablePrime.localRing` is the valuation subring at the prime, `valuationSubringAtPrime_eq_valuationSubring`). -/
theorem mem_stableIntegers_iff_valuation {x : fieldI F} :
    x ∈ stableIntegers F ↔
      ∀ v : HeightOneSpectrum (𝓞 (fieldI F)), IsStablePlace F v → v.valuation (fieldI F) x ≤ 1 := by
  have hmem : ∀ P : StablePrime F, x ∈ P.localRing ↔ P.heightOne.valuation (fieldI F) x ≤ 1 := fun P => by
    show x ∈ HeightOneSpectrum.valuationSubringAtPrime (fieldI F) P.heightOne ↔ _
    rw [HeightOneSpectrum.valuationSubringAtPrime_eq_valuationSubring, Valuation.mem_valuationSubring_iff]
  rw [mem_stableIntegers]
  constructor
  · intro h v hv
    exact (hmem ⟨v.asIdeal, v.isMaximal, hv⟩).1 (h _)
  · intro h P
    exact (hmem P).2 (h P.heightOne P.comap_conj)

/-- **An approximant of `a ∈ W`**: an element of `O′` congruent to `a` modulo `O_w` at every split prime. -/
def IsApprox (a : SAdeleRing F) (t : fieldI F) : Prop :=
  t ∈ stableIntegers F ∧
    ∀ w : SplitPlace F, a.2 w - (t : w.1.adicCompletion (fieldI F)) ∈ w.1.adicCompletionIntegers (fieldI F)

/-- **Every point of `W` has an approximant** (`exists_approx_completion` at each split prime where `a` is not integral — a
finite set, since `a` lies in the restricted product — summed; each summand is integral off its prime, so in `O′`). -/
theorem exists_isApprox (a : SAdeleRing F) : ∃ t, IsApprox F a t := by
  classical
  have hO : ∀ (w : SplitPlace F) (t : fieldI F), w.1.valuation (fieldI F) t ≤ 1 →
      (t : w.1.adicCompletion (fieldI F)) ∈ w.1.adicCompletionIntegers (fieldI F) := fun w t ht => by
    rw [mem_adicCompletionIntegers, valuedAdicCompletion_eq_valuation']; exact ht
  -- the finitely many split primes where `a` is not integral
  have hfin : {w : SplitPlace F | a.2 w ∉ w.1.adicCompletionIntegers (fieldI F)}.Finite :=
    Filter.eventually_cofinite.1 a.2.2
  -- a per-prime approximant, integral off its prime
  choose t ht hat using fun w : SplitPlace F => exists_approx_completion w.1 (a.2 w)
  let S := hfin.toFinset
  refine ⟨∑ w ∈ S, t w, ?_, fun w => ?_⟩
  · -- in `O′`: each summand is integral at every stable prime (its own prime is split)
    refine (mem_stableIntegers_iff_valuation F).2 fun v hv => ?_
    refine (Valuation.map_sum_le _ fun w _ => ?_)
    exact ht w v fun h => w.2 (h ▸ hv)
  · -- at a split prime the other summands are integral (ultrametric)
    have hcoe : ((∑ w' ∈ S, t w' : fieldI F) : w.1.adicCompletion (fieldI F)) =
        ∑ w' ∈ S, (t w' : w.1.adicCompletion (fieldI F)) :=
      map_sum (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))) t S
    have hother : ∀ w' : SplitPlace F, w' ≠ w →
        (t w' : w.1.adicCompletion (fieldI F)) ∈ w.1.adicCompletionIntegers (fieldI F) := fun w' hne =>
      hO w _ (ht w' w.1 fun h => hne (Subtype.ext h.symm))
    rw [hcoe]
    by_cases hw : w ∈ S
    · rw [← Finset.add_sum_erase S _ hw, ← sub_sub]
      exact sub_mem (hat w) (sum_mem fun w' hw' => hother w' (Finset.ne_of_mem_erase hw'))
    · have haw : a.2 w ∈ w.1.adicCompletionIntegers (fieldI F) := by
        by_contra h; exact hw (hfin.mem_toFinset.2 h)
      exact sub_mem haw (sum_mem fun w' hw' => hother w' fun h => hw (h ▸ hw'))

/-- **Two approximants differ by an integral trace**: `t − t′` is integral at the split primes (both approximate `a`) and at
the stable ones (both lie in `O′`), so `exists_int_trace_of_integral` applies. -/
theorem exists_int_trace_sub_of_isApprox {a : SAdeleRing F} {t t' : fieldI F} (h : IsApprox F a t)
    (h' : IsApprox F a t') : ∃ n : ℤ, Algebra.trace ℚ (fieldI F) (t - t') = n := by
  refine exists_int_trace_of_integral _ fun v => ?_
  by_cases hv : IsStablePlace F v
  · have h1 := (mem_stableIntegers_iff_valuation F).1 h.1 v hv
    have h2 := (mem_stableIntegers_iff_valuation F).1 h'.1 v hv
    exact (Valuation.map_sub _ _ _).trans (max_le h1 h2)
  · let w : SplitPlace F := ⟨v, hv⟩
    have hd : ((t - t' : fieldI F) : w.1.adicCompletion (fieldI F)) =
        (a.2 w - (t' : w.1.adicCompletion (fieldI F))) - (a.2 w - (t : w.1.adicCompletion (fieldI F))) := by
      rw [show ((t - t' : fieldI F) : w.1.adicCompletion (fieldI F)) =
          (t : w.1.adicCompletion (fieldI F)) - (t' : w.1.adicCompletion (fieldI F)) from
        map_sub (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))) t t']
      ring
    have hm : ((t - t' : fieldI F) : w.1.adicCompletion (fieldI F)) ∈ w.1.adicCompletionIntegers (fieldI F) := by
      rw [hd]; exact sub_mem (h'.2 w) (h.2 w)
    rw [mem_adicCompletionIntegers, valuedAdicCompletion_eq_valuation'] at hm
    exact hm

/-- The value of the standard character, through the chosen approximant. -/
def tateCharFun (a : SAdeleRing F) : Circle :=
  Circle.exp (2 * Real.pi *
    (archTrace (fieldI F) a.1 - (Algebra.trace ℚ (fieldI F) (exists_isApprox F a).choose : ℝ)))

/-- **The evaluation lemma**: the standard character, through any approximant. -/
theorem tateCharFun_eq {a : SAdeleRing F} {t : fieldI F} (h : IsApprox F a t) :
    tateCharFun F a = Circle.exp (2 * Real.pi * (archTrace (fieldI F) a.1 - (Algebra.trace ℚ (fieldI F) t : ℝ))) := by
  obtain ⟨n, hn⟩ := exists_int_trace_sub_of_isApprox F (exists_isApprox F a).choose_spec h
  have ht : (Algebra.trace ℚ (fieldI F) (exists_isApprox F a).choose : ℝ) = Algebra.trace ℚ (fieldI F) t + n := by
    rw [← sub_eq_iff_eq_add', ← Rat.cast_sub, ← map_sub, hn, Rat.cast_intCast]
  rw [tateCharFun, ht, show 2 * Real.pi * (archTrace (fieldI F) a.1 - (Algebra.trace ℚ (fieldI F) t + n : ℝ)) =
      2 * Real.pi * (archTrace (fieldI F) a.1 - Algebra.trace ℚ (fieldI F) t) + (-n : ℤ) * (2 * Real.pi) by
    push_cast; ring, Circle.exp_add, Circle.exp_int_mul_two_pi, mul_one]

/-- `0` approximates a point integral at every split prime. -/
private theorem isApprox_zero_of_integral {a : SAdeleRing F}
    (h : ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) : IsApprox F a 0 :=
  ⟨zero_mem _, fun w => by
    rw [show ((0 : fieldI F) : w.1.adicCompletion (fieldI F)) = 0 from
      map_zero (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))), sub_zero]
    exact h w⟩

theorem tateCharFun_zero : tateCharFun F 0 = 1 := by
  rw [tateCharFun_eq F (isApprox_zero_of_integral F fun w => zero_mem _)]
  simp

theorem tateCharFun_add (a b : SAdeleRing F) : tateCharFun F (a + b) = tateCharFun F a * tateCharFun F b := by
  obtain ⟨ta, hta⟩ := exists_isApprox F a
  obtain ⟨tb, htb⟩ := exists_isApprox F b
  have hab : IsApprox F (a + b) (ta + tb) := ⟨add_mem hta.1 htb.1, fun w => by
    have hc : ((ta + tb : fieldI F) : w.1.adicCompletion (fieldI F)) =
        (ta : w.1.adicCompletion (fieldI F)) + (tb : w.1.adicCompletion (fieldI F)) :=
      map_add (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))) ta tb
    rw [hc, show (a + b).2 w = a.2 w + b.2 w from rfl,
      show a.2 w + b.2 w - ((ta : w.1.adicCompletion (fieldI F)) + tb) = (a.2 w - ta) + (b.2 w - tb) by ring]
    exact add_mem (hta.2 w) (htb.2 w)⟩
  rw [tateCharFun_eq F hab, tateCharFun_eq F hta, tateCharFun_eq F htb, ← Circle.exp_add]
  congr 1
  rw [show (a + b).1 = a.1 + b.1 from rfl, map_add, map_add, Rat.cast_add]
  ring

/-- **The standard character `ψ` of `W`** (form G). -/
def tateChar : AddChar (SAdeleRing F) Circle where
  toFun := tateCharFun F
  map_zero_eq_one' := tateCharFun_zero F
  map_add_eq_mul' := tateCharFun_add F

/-- **`ψ` on a point integral at every split prime**: the approximant `0` gives `ψ(a) = e(Tr_∞(a_∞))`. -/
theorem tateChar_of_integral {a : SAdeleRing F}
    (h : ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) :
    tateChar F a = Circle.exp (2 * Real.pi * archTrace (fieldI F) a.1) := by
  show tateCharFun F a = _
  rw [tateCharFun_eq F (isApprox_zero_of_integral F h)]
  simp

/-- **The product formula on `O′`**: `ψ(x) = 1` for `x ∈ O′` (the approximant `x` itself, and `Tr_∞ ∘ ι_∞ = Tr`). -/
theorem tateChar_toSAdele_of_mem {x : fieldI F} (hx : x ∈ stableIntegers F) : tateChar F (toSAdele F x) = 1 := by
  have hap : IsApprox F (toSAdele F x) x := ⟨hx, fun w => by
    rw [show (toSAdele F x).2 w = (x : w.1.adicCompletion (fieldI F)) from rfl, sub_self]
    exact zero_mem _⟩
  show tateCharFun F (toSAdele F x) = 1
  rw [tateCharFun_eq F hap, show (toSAdele F x).1 = mixedEmbedding (fieldI F) x from rfl, archTrace_mixedEmbedding,
    sub_self, mul_zero, Circle.exp_zero]

/-- **`ψ` is continuous**: it is continuous on the open subgroup `L_∞ × ∏ O_w` (`tateChar_of_integral`), hence everywhere. -/
theorem continuous_tateChar : Continuous (tateChar F) := by
  -- on the open subgroup `L_∞ × ∏ O_w` it is `e ∘ 2π Tr_∞ ∘ fst`; a homomorphism continuous at `0` is continuous
  let U : Set (SAdeleRing F) := Set.univ ×ˢ {x | ∀ w : SplitPlace F, x w ∈ w.1.adicCompletionIntegers (fieldI F)}
  have hU : IsOpen U := isOpen_univ.prod (RestrictedProduct.isOpen_forall_mem fun w => Valued.isOpen_valuationSubring _)
  have h0 : (0 : SAdeleRing F) ∈ U := ⟨Set.mem_univ _, fun w => zero_mem _⟩
  let g : SAdeleRing F → Circle := fun a => Circle.exp (2 * Real.pi * archTrace (fieldI F) a.1)
  have hg : Continuous g :=
    Circle.exp.continuous.comp (continuous_const.mul
      ((LinearMap.continuous_of_finiteDimensional (archTrace (fieldI F))).comp continuous_fst))
  have hψ : ContinuousAt (tateChar F) 0 :=
    (hg.continuousAt).congr (Filter.eventually_of_mem (hU.mem_nhds h0) fun a ha => (tateChar_of_integral F ha.2).symm)
  have hm : Continuous (tateChar F).toMonoidHom :=
    continuous_of_continuousAt_one (tateChar F).toMonoidHom hψ
  exact hm

/-- **`π : W → R̂`, `π a := (r ↦ ψ(a r))`** (X01D l. 119). -/
def tatePi : AddChar (SAdeleRing F) (Dual F) where
  toFun a :=
    { toFun := fun r => tateChar F (a * toSAdele F (ofUnitRing F r))
      map_zero_eq_one' := by simp
      map_add_eq_mul' := fun r s => by simp [mul_add, AddChar.map_add_eq_mul] }
  map_zero_eq_one' := by ext r; simp
  map_add_eq_mul' a b := by ext r; simp [add_mul, AddChar.map_add_eq_mul]

theorem tatePi_apply (a : SAdeleRing F) (r : unitRing F) :
    tatePi F a r = tateChar F (a * toSAdele F (ofUnitRing F r)) := rfl

/-- **Fact 1, continuity** (the topology of `R̂` is pointwise: `Rigidity.isClosedEmbedding_coe`). -/
theorem continuous_tatePi : Continuous (tatePi F) := by
  rw [(isClosedEmbedding_coe (unitRing F)).isInducing.continuous_iff]
  refine continuous_pi fun r => ?_
  exact continuous_subtype_val.comp ((continuous_tateChar F).comp (continuous_mul_const _))

/-- **Fact 1, equivariance**: `π(u a) = rot u (π a)` (`ofUnitRing (uvRing u * r) = unitL u * ofUnitRing r`). -/
theorem tatePi_unit_mul (u : unitVectors F) (a : SAdeleRing F) :
    tatePi F (toSAdele F (unitL u) * a) = rot u (tatePi F a) := by
  refine DFunLike.ext _ _ fun r => ?_
  show tateChar F (toSAdele F (unitL u) * a * toSAdele F (ofUnitRing F r)) =
    tateChar F (a * toSAdele F (ofUnitRing F (uvRing u * r)))
  rw [map_mul (ofUnitRing F), show ofUnitRing F (uvRing u) = unitL u from Subtype.ext rfl, map_mul (toSAdele F)]
  congr 1
  ring

/-- **Fact 3, `O′ ⊆ Λ`**: `R ⊆ O′` (`unitRing_le_stableIntegers`, read through `UnitRing.coe_mem_unitRingOver_iff`), so
`x r ∈ O′` and `tateChar_toSAdele_of_mem` applies. -/
theorem tatePi_toSAdele_of_mem {x : fieldI F} (hx : x ∈ stableIntegers F) : tatePi F (toSAdele F x) = 1 := by
  refine DFunLike.ext _ _ fun r => ?_
  rw [AddChar.one_apply]
  show tateChar F (toSAdele F x * toSAdele F (ofUnitRing F r)) = 1
  have hr : ofUnitRing F r ∈ stableIntegers F :=
    unitRing_le_stableIntegers F ((UnitRing.coe_mem_unitRingOver_iff (ofUnitRing F r)).1 r.2)
  rw [← map_mul]
  exact tateChar_toSAdele_of_mem F (Subring.mul_mem _ hx hr)

/-- **Fact 5, as read**: `π(b, 0)` has the additive real lift `r ↦ 2π Tr_∞(b · r)` (`tateChar_of_integral`). -/
theorem tatePi_arch_mem (b : mixedEmbedding.mixedSpace (fieldI F)) : tatePi F (b, 0) ∈ archChars (unitRing F) := by
  let ψ : unitRing F →+ ℝ :=
    { toFun := fun r => 2 * Real.pi * archTrace (fieldI F) (b * mixedEmbedding (fieldI F) (ofUnitRing F r))
      map_zero' := by simp
      map_add' := fun r s => by simp [map_add, mul_add] }
  refine ⟨ψ, fun r => ?_⟩
  show tateChar F ((b, 0) * toSAdele F (ofUnitRing F r)) = _
  rw [tateChar_of_integral F fun w => by
    show ((0 : SplitAdeleRing F) * toSplitAdele F (ofUnitRing F r)) w ∈ _
    rw [zero_mul]; exact zero_mem _]
  rfl

end

end HadwigerNelson.Rigidity
