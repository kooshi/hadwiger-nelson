import Proofs.HadwigerNelson.ResidueObstruction
import Proofs.HadwigerNelson.LocalGlobal

/-!
# The 2-adic residue tower of the seam field, level by level, ring-free

`K = ℚ(√3, √11)`; at a prime `𝔓` of `K(i)` above `2` the completion is `ℚ₂(√3, ζ₃)` with integers `O = ℤ₂[ω][√3]`,
`ω² = −1 − ω`, uniformiser `π = 1 + √3`, `𝔓² = (2)`, residue field `𝔽₄`. The **level-`m` residue plane** is the Cayley
graph `P_m = Cay(O/𝔓^m, S_m)`, `S_m = {z : z·z̄ = 1}` — the COMPLEX form (Theorem B's `K₄` at level one), because at `2`
the coordinates of a unit vector are not integral, only `z = x + iy` is.

**The representation (FS-38 §S3, [hand 1]).** `O/𝔓^m ≅ (ℤ/2^⌈m/2⌉)[ω] ⊕ π·(ℤ/2^⌊m/2⌋)[ω]` as additive groups —
`z = A + πB`, `A = a + bω`, `B = c + dω` — from `π² = 2 + 2π`; the norm is a pair of
Eisenstein forms, `N(A + πB) = (N(A) + 2N(B)) + π·(Tr(A, B) + 2N(B))` with `N(a + bω) = a² − ab + b²` and
`Tr(A, B) = 2ac − ad − bc + 2bd`, the `ω`-components vanishing because both forms are rational. So the circle is the
fibre of a ring-valued form over `(1, 0)` on a product of `ZMod`s, and the graph is Mathlib's `addCayley` — no ring is
built for `O/𝔓^m` itself. The identification with the
ring `O/𝔓^m` is a hand derivation recorded in the plan; validated at `m = 1..7` by `|S_m| = 3·2^{m−1}`, by two
perturbations of the formula that break the count, and — the discriminating control — by coincidence with an
independently built graph at levels `4` and `5`. Conjugation and multiplication by `ω` are additive automorphisms
preserving the circle; the level map `m + 1 → m` reduces both components.

**What is stated here** is structure only; the colourings are in `Instances/TwoAdicFour.lean` (level 4 is pairwise free,
a short list of tables) and `Instances/TwoAdicFive.lean` (level 5 forces exactly the kernel of the level map, one
LRAT refusal plus the `ω`-orbit). **[hand 2]**: that a `K`-certificate translated to the origin draws into `P_m` is the
`𝔓`-integrality of `z` for unit vectors, row 57's gap; nothing here draws a certificate.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### Eisenstein integers modulo `n`, and their two forms -/

/-- `(ℤ/n)[ω]`: the pair `(a, b)` for `a + bω`, `ω² = −1 − ω`. A plain product, so the additive group, the finite
type and decidable equality come free; the ring structure is never needed — only the two forms below. -/
abbrev EisMod (n : ℕ) : Type := ZMod n × ZMod n

namespace EisMod

variable {n : ℕ}

/-- The norm `N(a + bω) = a² − ab + b²`. -/
def norm (z : EisMod n) : ZMod n := z.1 ^ 2 - z.1 * z.2 + z.2 ^ 2

/-- The trace form `Tr(z, w) = z·w̄ + z̄·w = 2ac − ad − bc + 2bd`, symmetric, with `Tr(z, z) = 2·N(z)`. -/
def trace (z w : EisMod n) : ZMod n := 2 * z.1 * w.1 - z.1 * w.2 - z.2 * w.1 + 2 * z.2 * w.2

/-- Conjugation `ω ↦ −1 − ω`: `(a, b) ↦ (a − b, −b)`. -/
def conj : EisMod n →+ EisMod n where
  toFun z := (z.1 - z.2, -z.2)
  map_zero' := by simp
  map_add' x y := by ext <;> simp <;> ring

/-- Multiplication by `ω`: `(a, b) ↦ (−b, a − b)`. -/
def omegaMul : EisMod n →+ EisMod n where
  toFun z := (-z.2, z.1 - z.2)
  map_zero' := by simp
  map_add' x y := by ext <;> simp <;> ring

@[simp]
theorem norm_omegaMul (z : EisMod n) : norm (omegaMul z) = norm z := by
  simp only [norm, omegaMul, AddMonoidHom.coe_mk, ZeroHom.coe_mk]
  ring

@[simp]
theorem trace_omegaMul_omegaMul (z w : EisMod n) : trace (omegaMul z) (omegaMul w) = trace z w := by
  simp only [trace, omegaMul, AddMonoidHom.coe_mk, ZeroHom.coe_mk]
  ring

@[simp]
theorem norm_conj (z : EisMod n) : norm (conj z) = norm z := by
  simp only [norm, conj, AddMonoidHom.coe_mk, ZeroHom.coe_mk]
  ring

@[simp]
theorem trace_conj_conj (z w : EisMod n) : trace (conj z) (conj w) = trace z w := by
  simp only [trace, conj, AddMonoidHom.coe_mk, ZeroHom.coe_mk]
  ring

/-- `ω³ = 1`: three applications of `omegaMul` are the identity — the source of its injectivity. -/
theorem omegaMul_omegaMul_omegaMul (z : EisMod n) : omegaMul (omegaMul (omegaMul z)) = z := by
  simp only [omegaMul, AddMonoidHom.coe_mk, ZeroHom.coe_mk]
  ext <;> simp
  ring

theorem omegaMul_injective : Function.Injective (omegaMul : EisMod n → EisMod n) :=
  Function.LeftInverse.injective (g := fun z => omegaMul (omegaMul z)) omegaMul_omegaMul_omegaMul

variable {n' : ℕ}

/-- The norm commutes with a ring homomorphism applied to both components. -/
@[simp]
theorem norm_map (φ : ZMod n →+* ZMod n') (z : EisMod n) : norm (Prod.map φ φ z) = φ (norm z) := by
  simp only [norm, Prod.map_fst, Prod.map_snd, map_sub, map_add, map_mul, map_pow]

@[simp]
theorem trace_map (φ : ZMod n →+* ZMod n') (z w : EisMod n) :
    trace (Prod.map φ φ z) (Prod.map φ φ w) = φ (trace z w) := by
  simp only [trace, Prod.map_fst, Prod.map_snd, map_sub, map_add, map_mul, map_ofNat]

/-- `ω`-multiplication commutes with a ring homomorphism applied to both components — oriented with the map inward
and `ω` outward, so that `trace_omegaMul_omegaMul` fires next. -/
@[simp]
theorem omegaMul_map (φ : ZMod n →+* ZMod n') (z : EisMod n) :
    Prod.map φ φ (omegaMul z) = omegaMul (Prod.map φ φ z) := by
  simp only [omegaMul, AddMonoidHom.coe_mk, ZeroHom.coe_mk, Prod.map_fst, Prod.map_snd, Prod.map_apply,
    map_neg, map_sub]

end EisMod

/-! ### The additive group of a level -/

/-- `O/𝔓^m` as an additive group: `(A, B)` for `A + πB`, `A ∈ (ℤ/2^⌈m/2⌉)[ω]`, `B ∈ (ℤ/2^⌊m/2⌋)[ω]` — an Eisenstein
module of rank 2 with coefficient rings at two adjacent powers of 2. -/
abbrev TwoAdicLevel (m : ℕ) : Type := EisMod (2 ^ ((m + 1) / 2)) × EisMod (2 ^ (m / 2))

example : TwoAdicLevel 1 = ((ZMod 2 × ZMod 2) × (ZMod 1 × ZMod 1)) := rfl
example : TwoAdicLevel 4 = ((ZMod 4 × ZMod 4) × (ZMod 4 × ZMod 4)) := rfl
example : TwoAdicLevel 5 = ((ZMod 8 × ZMod 8) × (ZMod 4 × ZMod 4)) := rfl

/-- The reduction from the `A`-ring of level `m` to its `B`-ring, `ℤ/2^⌈m/2⌉ → ℤ/2^⌊m/2⌋`. The same family, at `m + 1`,
is the `A`-component of the level map `m + 1 → m`; at `m` it is the `B`-component. -/
def castDown (m : ℕ) : ZMod (2 ^ ((m + 1) / 2)) →+* ZMod (2 ^ (m / 2)) :=
  ZMod.castHom (pow_dvd_pow 2 (by omega : m / 2 ≤ (m + 1) / 2)) _

/-- `2^{⌊m/2⌋+1} = 0` in the `A`-ring, because `⌈m/2⌉ ≤ ⌊m/2⌋ + 1`. The one arithmetic fact behind both `dbl`'s
additivity and its commutation with reduction: doubling kills the ambiguity in a `B`-ring representative. -/
theorem two_pow_succ_eq_zero (m : ℕ) : (2 : ZMod (2 ^ ((m + 1) / 2))) ^ (m / 2 + 1) = 0 := by
  have h : ((2 ^ (m / 2 + 1) : ℕ) : ZMod (2 ^ ((m + 1) / 2))) = 0 :=
    (ZMod.natCast_eq_zero_iff _ _).mpr (pow_dvd_pow 2 (by omega))
  simpa using h

/-- `2·a` read in the `A`-ring does not see `a`'s reduction modulo `2^⌊m/2⌋` — the well-definedness of `dbl`,
stated on natural-number representatives so both consumers can use it. -/
theorem two_mul_natCast_mod (m a : ℕ) :
    (2 : ZMod (2 ^ ((m + 1) / 2))) * ((a % 2 ^ (m / 2) : ℕ) : ZMod (2 ^ ((m + 1) / 2)))
      = 2 * (a : ZMod (2 ^ ((m + 1) / 2))) := by
  conv_rhs => rw [← Nat.mod_add_div a (2 ^ (m / 2))]
  push_cast
  rw [mul_add, ← mul_assoc, ← pow_succ', two_pow_succ_eq_zero, zero_mul, add_zero]

/-- Doubling from the `B`-ring into the `A`-ring, `x ↦ 2·x̃`: well defined because `2·(x + 2^⌊m/2⌋ t) ≡ 2x` modulo
`2^⌈m/2⌉` (`⌈m/2⌉ ≤ ⌊m/2⌋ + 1`). Additive, not multiplicative; the only place a representative (`ZMod.val`) is read. -/
def dbl (m : ℕ) : ZMod (2 ^ (m / 2)) →+ ZMod (2 ^ ((m + 1) / 2)) where
  toFun x := 2 * (x.val : ZMod (2 ^ ((m + 1) / 2)))
  map_zero' := by simp
  map_add' x y := by
    simp only [ZMod.val_add]
    rw [two_mul_natCast_mod, Nat.cast_add, mul_add]

/-- Doubling commutes with reduction: both sides are `2·x̃` read modulo `2^⌈m/2⌉`, and `2^⌈m/2⌉ ∣ 2^{⌊m/2⌋+1}`. -/
@[simp]
theorem castDown_dbl (m : ℕ) (x : ZMod (2 ^ ((m + 1) / 2))) :
    castDown (m + 1) (dbl (m + 1) x) = dbl m (castDown m x) := by
  have hv : (castDown m x).val = x.val % 2 ^ (m / 2) := by
    rw [castDown, ZMod.castHom_apply, ← ZMod.natCast_val, ZMod.val_natCast]
  simp only [dbl, AddMonoidHom.coe_mk, ZeroHom.coe_mk, map_mul, map_ofNat, map_natCast, hv]
  exact (two_mul_natCast_mod m x.val).symm

/-- **The norm form** `N(A + πB) = (N(A) + 2N(B)) + π·(Tr(A, B) + 2N(B))`, from `π² = 2 + 2π` and the rationality of
`N` and `Tr` (their `ω`-components vanish): valued in the `A`-ring and the `B`-ring respectively. -/
def normForm (m : ℕ) (z : TwoAdicLevel m) : ZMod (2 ^ ((m + 1) / 2)) × ZMod (2 ^ (m / 2)) :=
  (EisMod.norm z.1 + dbl m (EisMod.norm z.2),
   EisMod.trace (Prod.map (castDown m) (castDown m) z.1) z.2 + 2 * EisMod.norm z.2)

/-- **The circle `S_m`**: the fibre of the norm form over `1 = 1 + π·0`. -/
def twoAdicCircle (m : ℕ) : Set (TwoAdicLevel m) := {z | normForm m z = (1, 0)}

instance (m : ℕ) : DecidablePred (· ∈ twoAdicCircle m) := fun z =>
  inferInstanceAs (Decidable (normForm m z = (1, 0)))

/-- **The level-`m` residue plane** `P_m = Cay(O/𝔓^m, S_m)`. -/
def twoAdicPlane (m : ℕ) : SimpleGraph (TwoAdicLevel m) := addCayley (twoAdicCircle m)

instance (m : ℕ) : DecidableRel (twoAdicPlane m).Adj :=
  inferInstanceAs (DecidableRel (addCayley (twoAdicCircle m)).Adj)

/-- `|S_m| = 3·2^{m−1}`, the spec check at the levels the kernel decides cheaply. -/
example : (Finset.univ.filter (· ∈ twoAdicCircle 1)).card = 3 := by decide
example : (Finset.univ.filter (· ∈ twoAdicCircle 2)).card = 6 := by decide
example : (Finset.univ.filter (· ∈ twoAdicCircle 3)).card = 12 := by decide

/-- `|S_4| = 24`, `|S_5| = 48`: the same count at the two levels the instance modules use. -/
theorem twoAdicCircle_four_card : (Finset.univ.filter (· ∈ twoAdicCircle 4)).card = 24 := by
  decide +kernel

theorem twoAdicCircle_five_card : (Finset.univ.filter (· ∈ twoAdicCircle 5)).card = 48 := by
  decide +kernel

/-! ### Symmetries -/

/-- Conjugation on a level, componentwise (`π` is real). -/
def twoAdicConj (m : ℕ) : TwoAdicLevel m →+ TwoAdicLevel m :=
  EisMod.conj.prodMap EisMod.conj

/-- Multiplication by the unit `ω` on a level, componentwise (`π` commutes with `ω`). -/
def twoAdicOmega (m : ℕ) : TwoAdicLevel m →+ TwoAdicLevel m :=
  EisMod.omegaMul.prodMap EisMod.omegaMul

/-- The norm form is `ω`-invariant: `norm_omegaMul`, `trace_omegaMul_omegaMul`, and `castDown` commutes with the
linear map `omegaMul`. -/
theorem normForm_twoAdicOmega (m : ℕ) (z : TwoAdicLevel m) : normForm m (twoAdicOmega m z) = normForm m z := by
  simp [normForm, twoAdicOmega]

theorem twoAdicOmega_mem_circle (m : ℕ) {z : TwoAdicLevel m} (h : z ∈ twoAdicCircle m) :
    twoAdicOmega m z ∈ twoAdicCircle m := by
  rw [twoAdicCircle, Set.mem_setOf_eq, normForm_twoAdicOmega]
  exact h

theorem twoAdicOmega_injective (m : ℕ) : Function.Injective (twoAdicOmega m) := by
  intro x y h
  simp only [twoAdicOmega, AddMonoidHom.coe_prodMap] at h
  have h1 := congrArg Prod.fst h
  have h2 := congrArg Prod.snd h
  simp only [Prod.map_fst, Prod.map_snd] at h1 h2
  exact Prod.ext (EisMod.omegaMul_injective h1) (EisMod.omegaMul_injective h2)

theorem normForm_twoAdicConj (m : ℕ) (z : TwoAdicLevel m) : normForm m (twoAdicConj m z) = normForm m z := by
  have hcd : Prod.map (castDown m) (castDown m) (EisMod.conj z.1)
      = EisMod.conj (Prod.map (castDown m) (castDown m) z.1) := by
    refine Prod.ext ?_ ?_ <;>
      simp only [EisMod.conj, AddMonoidHom.coe_mk, ZeroHom.coe_mk, Prod.map_fst, Prod.map_snd,
        map_neg, map_sub]
  simp only [normForm, twoAdicConj, AddMonoidHom.coe_prodMap, Prod.map_fst, Prod.map_snd,
    EisMod.norm_conj, hcd, EisMod.trace_conj_conj]

theorem twoAdicConj_mem_circle (m : ℕ) {z : TwoAdicLevel m} (h : z ∈ twoAdicCircle m) :
    twoAdicConj m z ∈ twoAdicCircle m := by
  rw [twoAdicCircle, Set.mem_setOf_eq, normForm_twoAdicConj]
  exact h

/-- Multiplication by `ω` as a graph endomorphism (an automorphism; `Forces.map` consumes it). -/
def twoAdicOmegaHom (m : ℕ) : twoAdicPlane m →g twoAdicPlane m where
  toFun := twoAdicOmega m
  map_rel' := by
    intro u v h
    rw [twoAdicPlane, addCayley_adj] at h ⊢
    refine ⟨fun he => h.1 (twoAdicOmega_injective m he), ?_⟩
    rw [← map_neg, ← map_add, ← map_neg, ← map_add]
    exact h.2.imp (twoAdicOmega_mem_circle m) (twoAdicOmega_mem_circle m)

@[simp] theorem twoAdicOmegaHom_apply (m : ℕ) (z : TwoAdicLevel m) : twoAdicOmegaHom m z = twoAdicOmega m z := rfl

/-! ### The level maps -/

/-- The reduction `O/𝔓^{m+1} → O/𝔓^m`: `castDown (m + 1)` on the `A`-component, `castDown m` on the `B`-component. -/
def twoAdicLevelMap (m : ℕ) : TwoAdicLevel (m + 1) →+ TwoAdicLevel m :=
  ((castDown (m + 1)).toAddMonoidHom.prodMap (castDown (m + 1)).toAddMonoidHom).prodMap
    ((castDown m).toAddMonoidHom.prodMap (castDown m).toAddMonoidHom)

/-- The norm form commutes with reduction: `castDown` is a ring hom and `dbl` commutes with it. -/
theorem normForm_twoAdicLevelMap (m : ℕ) (z : TwoAdicLevel (m + 1)) :
    normForm m (twoAdicLevelMap m z) =
      (castDown (m + 1) (normForm (m + 1) z).1, castDown m (normForm (m + 1) z).2) := by
  simp [normForm, twoAdicLevelMap, map_ofNat]

/-- The circle reduces into the circle: `S_{m+1} → S_m`. -/
theorem twoAdicLevelMap_mem_circle (m : ℕ) {z : TwoAdicLevel (m + 1)} (h : z ∈ twoAdicCircle (m + 1)) :
    twoAdicLevelMap m z ∈ twoAdicCircle m := by
  rw [twoAdicCircle, Set.mem_setOf_eq, normForm_twoAdicLevelMap]
  rw [twoAdicCircle, Set.mem_setOf_eq] at h
  rw [h]
  simp

/-- **No fibre carries an edge**: a circle point of level `m + 2` reduces to a NONZERO point of level `m + 1` — its
image lies on that level's circle, where `(1, 0) ≠ (0, 0)` because `2 ^ ((m + 2) / 2) ≥ 2`. (At level `0` the target ring
is `ZMod 1` and this fails, which is why the level hom below starts one level up.) -/
theorem twoAdicLevelMap_ne_zero_of_mem_circle (m : ℕ) {z : TwoAdicLevel (m + 2)}
    (h : z ∈ twoAdicCircle (m + 2)) : twoAdicLevelMap (m + 1) z ≠ 0 := by
  haveI : Fact (1 < 2 ^ ((m + 2) / 2)) :=
    ⟨lt_of_lt_of_le (by norm_num) (Nat.pow_le_pow_right (by norm_num) (by omega : 1 ≤ (m + 2) / 2))⟩
  intro h0
  have hc := twoAdicLevelMap_mem_circle (m + 1) h
  rw [h0, twoAdicCircle, Set.mem_setOf_eq] at hc
  simp [normForm, EisMod.norm, EisMod.trace, Prod.map_fst, Prod.map_snd] at hc

/-- **The level map is a graph homomorphism** `P_{m+2} →g P_{m+1}` — the tower's structure maps. Indexed from level
`1` upward: the map onto level `0` (one vertex, no edge) is no homomorphism, since `K₄` has edges. -/
def twoAdicLevelHom (m : ℕ) : twoAdicPlane (m + 2) →g twoAdicPlane (m + 1) where
  toFun := twoAdicLevelMap (m + 1)
  map_rel' := by
    intro u v h
    rw [twoAdicPlane, addCayley_adj] at h ⊢
    have key : ∀ {x y : TwoAdicLevel (m + 2)}, -x + y ∈ twoAdicCircle (m + 2) →
        -twoAdicLevelMap (m + 1) x + twoAdicLevelMap (m + 1) y ∈ twoAdicCircle (m + 1) := by
      intro x y hxy
      rw [← map_neg, ← map_add]
      exact twoAdicLevelMap_mem_circle (m + 1) hxy
    refine ⟨?_, h.2.imp key key⟩
    intro he
    rcases h.2 with hs | hs
    · exact twoAdicLevelMap_ne_zero_of_mem_circle m hs (by rw [map_add, map_neg, he]; simp)
    · exact twoAdicLevelMap_ne_zero_of_mem_circle m hs (by rw [map_add, map_neg, he]; simp)

@[simp] theorem twoAdicLevelHom_apply (m : ℕ) (z : TwoAdicLevel (m + 2)) :
    twoAdicLevelHom m z = twoAdicLevelMap (m + 1) z := rfl

/-- **Why the tower's structure maps start at level one**, as a theorem rather than a remark: level `0` is a single
point with no edge, level `1` is `K₄`, and an edge cannot map to a non-edge — so NO map at all from level `1` to
level `0` respects adjacency, and `twoAdicLevelHom` is uninhabitable at `m = 0`. The negative control for this
module's indexing: re-index `twoAdicLevelHom` to `m + 1 → m` and it is this statement that refutes it. -/
theorem no_hom_twoAdicPlane_one_to_zero (f : TwoAdicLevel 1 → TwoAdicLevel 0) :
    ¬ ∀ u v, (twoAdicPlane 1).Adj u v → (twoAdicPlane 0).Adj (f u) (f v) := by
  intro h
  have hsub : ∀ x y : TwoAdicLevel 0, x = y := by decide
  have hadj : (twoAdicPlane 1).Adj 0 ((1, 0), (0, 0)) := by decide
  exact (h _ _ hadj).ne (hsub _ _)

/-! ### Level one is the clique, and it has no gap -/

set_option synthInstance.maxSize 1000 in
set_option synthInstance.maxHeartbeats 1000000 in
/-- **Level one is `K₄` and has no gap at four colours**: every proper 4-colouring of `P₁` shows all three other
colours on every neighbourhood — the 2-adic side of the dichotomy at level one (`decide` over the 256 functions). -/
theorem twoAdicPlane_one_no_fanGap :
    ∀ f : TwoAdicLevel 1 → Fin 4, (∀ u v, (twoAdicPlane 1).Adj u v → f u ≠ f v) →
      ∀ γ : Fin 4, ¬ (γ ≠ f 0 ∧ ∀ w, (twoAdicPlane 1).Adj 0 w → f w ≠ γ) := by
  decide +kernel


end HadwigerNelson
