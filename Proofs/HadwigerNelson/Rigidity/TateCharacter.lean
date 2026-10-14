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
  sorry

/-- **An approximant of `a ∈ W`**: an element of `O′` congruent to `a` modulo `O_w` at every split prime. -/
def IsApprox (a : SAdeleRing F) (t : fieldI F) : Prop :=
  t ∈ stableIntegers F ∧
    ∀ w : SplitPlace F, a.2 w - (t : w.1.adicCompletion (fieldI F)) ∈ w.1.adicCompletionIntegers (fieldI F)

/-- **Every point of `W` has an approximant** (`exists_approx_completion` at each split prime where `a` is not integral — a
finite set, since `a` lies in the restricted product — summed; each summand is integral off its prime, so in `O′`). -/
theorem exists_isApprox (a : SAdeleRing F) : ∃ t, IsApprox F a t := by
  sorry

/-- **Two approximants differ by an integral trace**: `t − t′` is integral at the split primes (both approximate `a`) and at
the stable ones (both lie in `O′`), so `exists_int_trace_of_integral` applies. -/
theorem exists_int_trace_sub_of_isApprox {a : SAdeleRing F} {t t' : fieldI F} (h : IsApprox F a t)
    (h' : IsApprox F a t') : ∃ n : ℤ, Algebra.trace ℚ (fieldI F) (t - t') = n := by
  sorry

/-- The value of the standard character, through the chosen approximant. -/
def tateCharFun (a : SAdeleRing F) : Circle :=
  Circle.exp (2 * Real.pi *
    (archTrace (fieldI F) a.1 - (Algebra.trace ℚ (fieldI F) (exists_isApprox F a).choose : ℝ)))

/-- **The evaluation lemma**: the standard character, through any approximant. -/
theorem tateCharFun_eq {a : SAdeleRing F} {t : fieldI F} (h : IsApprox F a t) :
    tateCharFun F a = Circle.exp (2 * Real.pi * (archTrace (fieldI F) a.1 - (Algebra.trace ℚ (fieldI F) t : ℝ))) := by
  sorry

theorem tateCharFun_zero : tateCharFun F 0 = 1 := by
  sorry

theorem tateCharFun_add (a b : SAdeleRing F) : tateCharFun F (a + b) = tateCharFun F a * tateCharFun F b := by
  sorry

/-- **The standard character `ψ` of `W`** (form G). -/
def tateChar : AddChar (SAdeleRing F) Circle where
  toFun := tateCharFun F
  map_zero_eq_one' := tateCharFun_zero F
  map_add_eq_mul' := tateCharFun_add F

/-- **`ψ` on a point integral at every split prime**: the approximant `0` gives `ψ(a) = e(Tr_∞(a_∞))`. -/
theorem tateChar_of_integral {a : SAdeleRing F}
    (h : ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) :
    tateChar F a = Circle.exp (2 * Real.pi * archTrace (fieldI F) a.1) := by
  sorry

/-- **The product formula on `O′`**: `ψ(x) = 1` for `x ∈ O′` (the approximant `x` itself, and `Tr_∞ ∘ ι_∞ = Tr`). -/
theorem tateChar_toSAdele_of_mem {x : fieldI F} (hx : x ∈ stableIntegers F) : tateChar F (toSAdele F x) = 1 := by
  sorry

/-- **`ψ` is continuous**: it is continuous on the open subgroup `L_∞ × ∏ O_w` (`tateChar_of_integral`), hence everywhere. -/
theorem continuous_tateChar : Continuous (tateChar F) := by
  sorry

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
  sorry

/-- **Fact 1, equivariance**: `π(u a) = rot u (π a)` (`ofUnitRing (uvRing u * r) = unitL u * ofUnitRing r`). -/
theorem tatePi_unit_mul (u : unitVectors F) (a : SAdeleRing F) :
    tatePi F (toSAdele F (unitL u) * a) = rot u (tatePi F a) := by
  sorry

/-- **Fact 3, `O′ ⊆ Λ`**: `R ⊆ O′` (`unitRing_le_stableIntegers`, read through `UnitRing.coe_mem_unitRingOver_iff`), so
`x r ∈ O′` and `tateChar_toSAdele_of_mem` applies. -/
theorem tatePi_toSAdele_of_mem {x : fieldI F} (hx : x ∈ stableIntegers F) : tatePi F (toSAdele F x) = 1 := by
  sorry

/-- **Fact 5, as read**: `π(b, 0)` has the additive real lift `r ↦ 2π Tr_∞(b · r)` (`tateChar_of_integral`). -/
theorem tatePi_arch_mem (b : mixedEmbedding.mixedSpace (fieldI F)) : tatePi F (b, 0) ∈ archChars (unitRing F) := by
  sorry

end

end HadwigerNelson.Rigidity
