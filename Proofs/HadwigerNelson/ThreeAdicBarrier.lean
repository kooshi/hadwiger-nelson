import Mathlib.Combinatorics.SimpleGraph.Cayley
import Mathlib.Algebra.Field.ZMod
import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.Field.Quadratic

/-!
# The 3-adic barrier: the plane over `ℚ(√d)`, `d ≡ 2 (mod 3)`, with 3-integral directions is 3-colourable

FS-58 (`plans/FS58-four-colours.md` §2 D1; found for `d = 167` in `plans/FS58-prelude-seven-cycle-gadget.md` §4).

**The model.** A point of the plane over `ℚ(√d)` is a pair of `Adjoin d ℚ` — coordinates `re + im·√d` held as data, so each
point has exactly one representation and no map out of the plane needs `√d` to be irrational. The graph is `integralDirectionPlane d`,
the Cayley graph of that group on the unit vectors whose four rational coordinates have denominators prime to 3. Every
unit-distance graph over `ℚ(√d)` whose edge vectors are 3-integral is, up to translating each component, a subgraph of it.
When `d` is not a square (every `d ≡ 2 mod 3`) evaluation at `√d` identifies `Plane d` with `ℚ(√d)²` and this graph with the
unit-distance graph there restricted to those directions; that transfer to `ℂ` is not stated here, because nothing consumes it
(a colouring transfers only along an injective map, and the injectivity is the irrationality this model avoids buying).

**Why it is true.** When `d ≡ 2 (mod 3)`, reducing the coordinates modulo 3 sends `ℤ₍₃₎[√d]` onto `𝔽₉ = 𝔽₃[t]/(t² + 1)` with
`√d ↦ t`. A 3-integral unit vector `(a + b√d, c + e√d)` reduces to a point of the eight-point circle of `𝔽₉²`, and on that
circle `a + b + c` never vanishes (`circle_kappa_ne_zero`, 81 cases). So `kappa` — the additive map `(a + b + c) mod 3` on the
3-integral vectors — is nonzero on every edge vector, and Theorem A (`colorable_of_residue`) three-colours the graph, at every
size and with no solver. **Consequence (FS-58):** a four-chromatic unit-distance graph over such a field has an edge whose
direction has 3 in a denominator.

**Trust.** Proved in FS-58 phase D on the standard three axioms. The finite facts — the 81-tuple circle check and the
concrete vectors `diamond167` and `vanishingVectorThree` — are closed by `decide` and `decide +kernel`, never by native
evaluation.
-/

namespace HadwigerNelson.ThreeAdicBarrier

open SimpleGraph

/-- `ℚ`'s scalar action for `Adjoin d ℚ`: ordinary multiplication, as for `ℤ` (`Field/Quadratic.lean`). Declared here, in
a leaf module, so that `Field/Quadratic.lean` — which the certificates import — is not touched. -/
instance : NatScalar ℚ where
  smul n x := (n : ℚ) * x
  smul_eq _ _ := rfl

/-- **The plane over `ℚ(√d)`**, coordinates as data. -/
abbrev Plane (d : ℕ) : Type := Adjoin d ℚ × Adjoin d ℚ

/-- A rational is **3-integral** when its denominator is prime to 3, i.e. nonzero in `ZMod 3`. -/
def IsThreeIntegral (q : ℚ) : Prop := ((q.den : ℕ) : ZMod 3) ≠ 0

-- A rational whose denominator divides a number prime to 3 is 3-integral.
private theorem isThreeIntegral_of_den_dvd {q : ℚ} {n : ℕ} (h : q.den ∣ n) (hn : (n : ZMod 3) ≠ 0) :
    IsThreeIntegral q := by
  obtain ⟨k, rfl⟩ := h
  intro hq
  exact hn (by rw [Nat.cast_mul, hq, zero_mul])

private theorem isThreeIntegral_add {q r : ℚ} (hq : IsThreeIntegral q) (hr : IsThreeIntegral r) :
    IsThreeIntegral (q + r) :=
  isThreeIntegral_of_den_dvd (Rat.add_den_dvd q r) (by rw [Nat.cast_mul]; exact mul_ne_zero hq hr)

private theorem isThreeIntegral_mul {q r : ℚ} (hq : IsThreeIntegral q) (hr : IsThreeIntegral r) :
    IsThreeIntegral (q * r) :=
  isThreeIntegral_of_den_dvd (Rat.mul_den_dvd q r) (by rw [Nat.cast_mul]; exact mul_ne_zero hq hr)

-- `(-q).den = q.den` holds by `rfl` (`Rat.neg_den`).
private theorem isThreeIntegral_neg {q : ℚ} (hq : IsThreeIntegral q) : IsThreeIntegral (-q) := hq

private theorem isThreeIntegral_zero : IsThreeIntegral 0 := by
  show ((1 : ℕ) : ZMod 3) ≠ 0
  decide

private theorem isThreeIntegral_one : IsThreeIntegral 1 := by
  show ((1 : ℕ) : ZMod 3) ≠ 0
  decide

/-- **The 3-integral rationals** `ℤ₍₃₎`, a subring: denominators of sums and products divide products of denominators
(`Rat.add_den_dvd`, `Rat.mul_den_dvd`). -/
def threeIntegralRat : Subring ℚ where
  carrier := {q | IsThreeIntegral q}
  add_mem' := isThreeIntegral_add
  mul_mem' := isThreeIntegral_mul
  zero_mem' := isThreeIntegral_zero
  one_mem' := isThreeIntegral_one
  neg_mem' := isThreeIntegral_neg

/-- **Reduction modulo 3** on `ℤ₍₃₎`: `Rat.cast` into the field `ZMod 3`, a ring homomorphism there because the casts of
sums and products agree once denominators do not vanish (`Rat.cast_add_of_ne_zero`, `Rat.cast_mul_of_ne_zero`). -/
noncomputable def toZModThree : threeIntegralRat →+* ZMod 3 where
  toFun q := ((q : ℚ) : ZMod 3)
  map_one' := Rat.cast_one
  map_mul' x y := Rat.cast_mul_of_ne_zero x.2 y.2
  map_zero' := Rat.cast_zero
  map_add' x y := Rat.cast_add_of_ne_zero x.2 y.2

/-- The reduction is the cast. -/
@[simp] theorem toZModThree_apply (q : threeIntegralRat) : toZModThree q = ((q : ℚ) : ZMod 3) := rfl

/-- **The 3-integral vectors**: all four rational coordinates 3-integral. -/
def threeIntegral (d : ℕ) : AddSubgroup (Plane d) where
  carrier := {v | IsThreeIntegral v.1.re ∧ IsThreeIntegral v.1.im ∧ IsThreeIntegral v.2.re ∧ IsThreeIntegral v.2.im}
  add_mem' ha hb :=
    ⟨isThreeIntegral_add ha.1 hb.1, isThreeIntegral_add ha.2.1 hb.2.1, isThreeIntegral_add ha.2.2.1 hb.2.2.1,
      isThreeIntegral_add ha.2.2.2 hb.2.2.2⟩
  zero_mem' := ⟨isThreeIntegral_zero, isThreeIntegral_zero, isThreeIntegral_zero, isThreeIntegral_zero⟩
  neg_mem' ha := ⟨isThreeIntegral_neg ha.1, isThreeIntegral_neg ha.2.1, isThreeIntegral_neg ha.2.2.1,
    isThreeIntegral_neg ha.2.2.2⟩

private theorem mem_threeIntegral {d : ℕ} {v : Plane d} :
    v ∈ threeIntegral d ↔
      IsThreeIntegral v.1.re ∧ IsThreeIntegral v.1.im ∧ IsThreeIntegral v.2.re ∧ IsThreeIntegral v.2.im :=
  Iff.rfl

-- The three coordinates `kappa` reads, as elements of `ℤ₍₃₎`; each is additive by `rfl`.
private def reOne {d : ℕ} (v : threeIntegral d) : threeIntegralRat := ⟨(v : Plane d).1.re, (mem_threeIntegral.mp v.2).1⟩
private def imOne {d : ℕ} (v : threeIntegral d) : threeIntegralRat :=
  ⟨(v : Plane d).1.im, (mem_threeIntegral.mp v.2).2.1⟩
private def reTwo {d : ℕ} (v : threeIntegral d) : threeIntegralRat :=
  ⟨(v : Plane d).2.re, (mem_threeIntegral.mp v.2).2.2.1⟩

private theorem reOne_add {d : ℕ} (v w : threeIntegral d) : reOne (v + w) = reOne v + reOne w := rfl
private theorem imOne_add {d : ℕ} (v w : threeIntegral d) : imOne (v + w) = imOne v + imOne w := rfl
private theorem reTwo_add {d : ℕ} (v w : threeIntegral d) : reTwo (v + w) = reTwo v + reTwo w := rfl

/-- **The linear rule** `a + b + c (mod 3)` for `v = (a + b√d, c + e√d)`, each rational reduced by `toZModThree`. -/
noncomputable def kappa (d : ℕ) : threeIntegral d →+ ZMod 3 :=
  AddMonoidHom.mk' (fun v => toZModThree (reOne v) + toZModThree (imOne v) + toZModThree (reTwo v))
    fun v w => by
      rw [reOne_add, imOne_add, reTwo_add, map_add, map_add, map_add]
      ring

/-- The rule, on coordinates. -/
@[simp] theorem kappa_apply {d : ℕ} (v : threeIntegral d) :
    kappa d v = ((v : Plane d).1.re : ZMod 3) + ((v : Plane d).1.im : ZMod 3) + ((v : Plane d).2.re : ZMod 3) := rfl

/-- **The eight-point circle of `𝔽₉²` misses the kernel of the rule**, in the shape the reduction produces: a 3-integral unit
vector `(a + b√d, c + e√d)` has `a² + d·b² + c² + d·e² = 1` and `2ab + 2ce = 0`, which modulo 3 with `d ≡ 2` read as below;
on those 8 of the 81 component tuples `a + b + c ≠ 0`. -/
theorem circle_kappa_ne_zero :
    ∀ a b c e : ZMod 3, a ^ 2 + 2 * b ^ 2 + c ^ 2 + 2 * e ^ 2 = 1 → 2 * a * b + 2 * c * e = 0 → a + b + c ≠ 0 := by
  decide

/-- **The unit condition reduced**: a 3-integral unit vector's components satisfy the circle equations of `𝔽₉²` in `ZMod 3`
when `d ≡ 2 (mod 3)`. -/
theorem unit_reduce {d : ℕ} (hd : d % 3 = 2) {v : Plane d} (hv : v.1 ^ 2 + v.2 ^ 2 = 1) (h3 : v ∈ threeIntegral d) :
    (v.1.re : ZMod 3) ^ 2 + 2 * (v.1.im : ZMod 3) ^ 2 + (v.2.re : ZMod 3) ^ 2 + 2 * (v.2.im : ZMod 3) ^ 2 = 1 ∧
      2 * (v.1.re : ZMod 3) * (v.1.im : ZMod 3) + 2 * (v.2.re : ZMod 3) * (v.2.im : ZMod 3) = 0 := by
  -- The two coordinates of `v.1 ^ 2 + v.2 ^ 2 = 1`, as identities in `ℚ`.
  have hre := congrArg Adjoin.re hv
  have him := congrArg Adjoin.im hv
  simp only [pow_two, Adjoin.add_re, Adjoin.mul_re, Adjoin.add_im, Adjoin.mul_im, Adjoin.one_re,
    Adjoin.one_im] at hre him
  -- Name the four coordinates as elements of `ℤ₍₃₎`, where `toZModThree` is a ring homomorphism.
  obtain ⟨ha, hb, hc, he⟩ := mem_threeIntegral.mp h3
  obtain ⟨a, hva⟩ : ∃ a : threeIntegralRat, (a : ℚ) = v.1.re := ⟨⟨_, ha⟩, rfl⟩
  obtain ⟨b, hvb⟩ : ∃ b : threeIntegralRat, (b : ℚ) = v.1.im := ⟨⟨_, hb⟩, rfl⟩
  obtain ⟨c, hvc⟩ : ∃ c : threeIntegralRat, (c : ℚ) = v.2.re := ⟨⟨_, hc⟩, rfl⟩
  obtain ⟨e, hve⟩ : ∃ e : threeIntegralRat, (e : ℚ) = v.2.im := ⟨⟨_, he⟩, rfl⟩
  rw [← hva, ← hvb, ← hvc, ← hve] at hre him ⊢
  -- The identities lifted into `ℤ₍₃₎`, then reduced.
  have hre' : a * a + (d : threeIntegralRat) * (b * b) + (c * c + (d : threeIntegralRat) * (e * e)) = 1 :=
    Subtype.ext (by push_cast; linear_combination hre)
  have him' : a * b + b * a + (c * e + e * c) = 0 := Subtype.ext (by push_cast; linear_combination him)
  have hd3 : (d : ZMod 3) = 2 := by rw [← ZMod.natCast_mod, hd]; rfl
  have h1 := congrArg toZModThree hre'
  have h2 := congrArg toZModThree him'
  simp only [map_add, map_mul, map_natCast, map_one, map_zero, toZModThree_apply, hd3] at h1 h2
  exact ⟨by linear_combination h1, by linear_combination h2⟩

/-- **The rule never vanishes on a 3-integral unit vector** when `d ≡ 2 (mod 3)`. -/
theorem kappa_ne_zero {d : ℕ} (hd : d % 3 = 2) {v : Plane d} (hv : v.1 ^ 2 + v.2 ^ 2 = 1) (h3 : v ∈ threeIntegral d) :
    kappa d ⟨v, h3⟩ ≠ 0 := by
  rw [kappa_apply]
  obtain ⟨h1, h2⟩ := unit_reduce hd hv h3
  exact circle_kappa_ne_zero _ _ _ _ h1 h2

/-- **The congruence is used** — the adversarial member for `kappa_ne_zero`. At `d = 3` (ramified at 3) the vector
`(−√3/2, 1/2)` is a 3-integral unit vector on which the rule vanishes. (The barrier's *conclusion* still holds at
`d ≡ 0, 1 (mod 3)`, where the whole plane is 3-coloured through its residue plane at 3, `[Moorhouse2010]` Cor. 8.3, by a
different rule; that prior art is not restated here.) -/
def vanishingVectorThree : Plane 3 := (⟨0, -1 / 2⟩, ⟨1 / 2, 0⟩)

/-- `vanishingVectorThree` is 3-integral (every denominator is 1 or 2). -/
theorem vanishingVectorThree_mem : vanishingVectorThree ∈ threeIntegral 3 := by
  simp only [mem_threeIntegral, IsThreeIntegral]
  decide +kernel

/-- `vanishingVectorThree` is a unit vector: `3/4 + 1/4 = 1`. -/
theorem vanishingVectorThree_unit : vanishingVectorThree.1 ^ 2 + vanishingVectorThree.2 ^ 2 = 1 := by
  decide +kernel

/-- …and the rule vanishes on it: `0 + (−1/2) + 1/2 = 0`. So `kappa_ne_zero` needs `d ≡ 2 (mod 3)`. -/
theorem kappa_vanishingVectorThree : kappa 3 ⟨vanishingVectorThree, vanishingVectorThree_mem⟩ = 0 := by
  rw [kappa_apply]
  decide +kernel

/-- **The plane over `ℚ(√d)` with only its 3-integral directions**: the Cayley graph of `Plane d` on the unit vectors in
`threeIntegral d`. -/
def integralDirectionPlane (d : ℕ) : SimpleGraph (Plane d) :=
  addCayley {v : Plane d | v.1 ^ 2 + v.2 ^ 2 = 1 ∧ v ∈ threeIntegral d}

-- An edge's difference is `±s` for a 3-integral unit vector `s`, and both signs are 3-integral unit vectors.
private theorem sub_mem_of_adj {d : ℕ} {v w : Plane d} (h : (integralDirectionPlane d).Adj v w) :
    (v - w).1 ^ 2 + (v - w).2 ^ 2 = 1 ∧ v - w ∈ threeIntegral d := by
  rw [integralDirectionPlane, addCayley_adj] at h
  obtain ⟨-, ⟨hu, hm⟩ | ⟨hu, hm⟩⟩ := h
  · rw [show v - w = -(-v + w) by abel]
    exact ⟨by simpa only [Prod.fst_neg, Prod.snd_neg, neg_sq] using hu, (threeIntegral d).neg_mem hm⟩
  · rw [show v - w = -w + v by abel]
    exact ⟨hu, hm⟩

/-- **The 3-adic barrier.** For `d ≡ 2 (mod 3)`, the plane over `ℚ(√d)` restricted to 3-integral directions is 3-colourable. -/
theorem colorable_three_integralDirectionPlane {d : ℕ} (hd : d % 3 = 2) : (integralDirectionPlane d).Colorable 3 := by
  have h := colorable_of_residue (integralDirectionPlane d) id (kappa d)
    (fun _ _ hvw => (sub_mem_of_adj hvw).2)
    (fun v w hvw => by
      show cosetResidue (kappa d) (v - w) ≠ 0
      rw [cosetResidue_apply_of_mem (kappa d) (sub_mem_of_adj hvw).2]
      exact kappa_ne_zero hd (sub_mem_of_adj hvw).1 (sub_mem_of_adj hvw).2)
  rwa [ZMod.card] at h

/-- A 3-integral unit vector of `ℚ(√167)` outside `ℚ(i)`: a diamond side of the prelude's seven-cycle,
`((−15 − 7√167)/140, (105 − √167)/140)`. -/
def diamond167 : Plane 167 := (⟨-15 / 140, -7 / 140⟩, ⟨105 / 140, -1 / 140⟩)

/-- **The model of the barrier's graph has edges**: `diamond167` is a 3-integral unit vector, so the origin and it are
adjacent in `integralDirectionPlane 167`, and the three colours are spent on a graph that is not empty. -/
theorem integralDirectionPlane_adj_diamond167 : (integralDirectionPlane 167).Adj 0 diamond167 := by
  rw [integralDirectionPlane, addCayley_adj, neg_zero, zero_add]
  refine ⟨by decide +kernel, Or.inl ⟨by decide +kernel, ?_⟩⟩
  simp only [mem_threeIntegral, IsThreeIntegral]
  decide +kernel

end HadwigerNelson.ThreeAdicBarrier
