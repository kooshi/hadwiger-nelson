import Proofs.HadwigerNelson.LocalGlobal

/-!
# Rotations of the quadrance plane, and the freedom they force

**Every finite Euclidean plane at a prime `p ≡ 3 (mod 4)` is forced-pair-free, at every colour count
it can actually be coloured with.** That is `finitePlane_forces_iff`, and it replaces the record's four
measured instances (`p = 3, 7, 11, 19`, each a table checked by `decide`) with an argument.

The mechanism is one rotation. Over any commutative ring the map `(x, y) ↦ (a·x − b·y, b·x + a·y)` at
a circle point `a² + b² = 1` preserves quadrance, so it is an automorphism of `unitQuadrance R`
(`rotEquiv`, `rotHom`); the **quarter turn** `(x, y) ↦ (−y, x)` is its instance at `(0, 1)`, available
in every ring with no hypothesis at all (`quarterTurn`). Now suppose some `d ≠ 0` is forced at the
origin. Then *every* proper colouring is `d`-periodic, so `c` is `d`-periodic and, applying that to
`c ∘ quarterTurn`, also `(quarterTurn d)`-periodic. Over `ZMod p` with `p ≡ 3 (mod 4)` the quadrance
`q` of `d` is invertible (`quadrance_eq_zero_iff`), and

    (d.1 / q) • d  +  (−d.2 / q) • (quarterTurn d)  =  (1, 0)

so `(1, 0)` is a period too — periods being closed under addition and, in a **prime** field, under
scalars, because every scalar there is a natural-number multiple. But `(1, 0)` is on the unit circle,
so the origin and `(1, 0)` are adjacent and the colouring is improper. ∎

## What a consumer may conclude, and what not

* **The colourability hypothesis is not decoration.** `Forces G k u v` is `∀ C : G.Coloring (Fin k), …`,
  so on a graph with no proper `k`-colouring it holds for *every* pair. `finitePlane 3` refuses two
  colours and every pair of it is vacuously forced — shipped below as a red beside the positive
  inhabitant (`finitePlane3_colorable_three`).
* **Prime fields only.** The argument needs additive subgroups to be scalar-closed. Over `𝔽_q` with
  `q = p^n`, `n > 1`, a subgroup is an `𝔽_p`-subspace and `d` with `quarterTurn d` spans only two
  `𝔽_p`-dimensions. The repair is known and is *not* done here: the period set contains `r · d` for
  every norm-one `r`, its `𝔽_p`-span is a subring of `𝔽_{q²}` hence a subfield, and it has more than
  `q` elements, so it is everything. That needs `𝔽_{q²}` as a field containing `𝔽_q` with the norm form
  identified with `x² + y²`, where this plane is `R × R`. See `plans/P4-generalize-and-plane-freedom.md` §3.4.
* Nothing here touches the `Separated` half (virtual edges): that is a different property of a
  colouring table and is not obviously a theorem.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### Rotation by a circle point -/

section Rotation

variable {R : Type*} [CommRing R]

/-- The plane's rotation by `(a, b)`: `(x, y) ↦ (a·x − b·y, b·x + a·y)`, additive over any ring. -/
def rotMap (a b : R) : R × R →+ R × R where
  toFun w := (a * w.1 - b * w.2, b * w.1 + a * w.2)
  map_zero' := by simp
  map_add' u v := by
    simp only [Prod.fst_add, Prod.snd_add, Prod.mk_add_mk, Prod.mk.injEq]
    constructor <;> ring

@[simp] theorem rotMap_apply (a b : R) (w : R × R) :
    rotMap a b w = (a * w.1 - b * w.2, b * w.1 + a * w.2) := rfl

/-- **Rotation by a circle point is an additive automorphism**, its inverse the rotation by `(a, −b)`. -/
def rotEquiv {a b : R} (h : a ^ 2 + b ^ 2 = 1) : R × R ≃+ R × R where
  toFun := rotMap a b
  invFun := rotMap a (-b)
  left_inv w := by
    refine Prod.ext_iff.mpr ⟨?_, ?_⟩ <;> simp only [rotMap_apply]
    · linear_combination w.1 * h
    · linear_combination w.2 * h
  right_inv w := by
    refine Prod.ext_iff.mpr ⟨?_, ?_⟩ <;> simp only [rotMap_apply]
    · linear_combination w.1 * h
    · linear_combination w.2 * h
  map_add' := (rotMap a b).map_add

@[simp] theorem rotEquiv_apply {a b : R} (h : a ^ 2 + b ^ 2 = 1) (w : R × R) :
    rotEquiv h w = (a * w.1 - b * w.2, b * w.1 + a * w.2) := rfl

/-- Rotation preserves quadrance — the identity `(a² + b²)(x² + y²)`. -/
theorem quadrance_rotMap {a b : R} (h : a ^ 2 + b ^ 2 = 1) (w : R × R) :
    quadrance (rotMap a b w) = quadrance w := by
  show (a * w.1 - b * w.2) ^ 2 + (b * w.1 + a * w.2) ^ 2 = w.1 ^ 2 + w.2 ^ 2
  linear_combination (w.1 ^ 2 + w.2 ^ 2) * h

/-- **Rotation by a circle point is an automorphism of the plane.** -/
def rotHom {a b : R} (h : a ^ 2 + b ^ 2 = 1) : unitQuadrance R →g unitQuadrance R where
  toFun := rotEquiv h
  map_rel' {u v} hadj := by
    rw [unitQuadrance_adj] at hadj ⊢
    obtain ⟨hne, hq⟩ := hadj
    refine ⟨fun heq => hne ((rotEquiv h).injective heq), ?_⟩
    simp only [rotEquiv_apply]
    linear_combination (a ^ 2 + b ^ 2) * hq + h

@[simp] theorem rotHom_apply {a b : R} (h : a ^ 2 + b ^ 2 = 1) (w : R × R) :
    rotHom h w = (a * w.1 - b * w.2, b * w.1 + a * w.2) := rfl

/-- **The quarter turn** `(x, y) ↦ (−y, x)`: rotation by `(0, 1)`, a circle point of every ring. -/
def quarterTurn (R : Type*) [CommRing R] : R × R ≃+ R × R := rotEquiv (a := (0 : R)) (b := 1) (by ring)

@[simp] theorem quarterTurn_apply (w : R × R) : quarterTurn R w = (-w.2, w.1) := by
  show ((0 : R) * w.1 - 1 * w.2, (1 : R) * w.1 + 0 * w.2) = (-w.2, w.1)
  simp

/-- The quarter turn as a graph automorphism — the same map as `quarterTurn R`, wearing the structure
`SimpleGraph.Coloring.comap` needs. -/
def quarterTurnHom (R : Type*) [CommRing R] : unitQuadrance R →g unitQuadrance R :=
  rotHom (a := (0 : R)) (b := 1) (by ring)

@[simp] theorem quarterTurnHom_apply (w : R × R) : quarterTurnHom R w = quarterTurn R w := rfl

/-- **A nonzero vector and its quarter turn are a basis**, over any field in which `-1` is not a
square. With `q = quadrance d` — invertible there, by `quadrance_eq_zero_iff_of_not_isSquare_neg_one` — the
combination is `s = (w.1·d.1 + w.2·d.2)/q`, `t = (w.2·d.1 − w.1·d.2)/q`. Pure linear algebra: this is
the half of the freeness argument below that has nothing to do with primes. -/
theorem exists_smul_quarterTurn_eq {K : Type*} [Field K] (hK : ¬ IsSquare (-1 : K)) {d : K × K}
    (hd : d ≠ 0) (w : K × K) : ∃ s t : K, s • d + t • (quarterTurn K d) = w := by
  have hq : d.1 ^ 2 + d.2 ^ 2 ≠ 0 := fun h =>
    hd ((quadrance_eq_zero_iff_of_not_isSquare_neg_one hK).mp h)
  refine ⟨(w.1 * d.1 + w.2 * d.2) / (d.1 ^ 2 + d.2 ^ 2),
    (w.2 * d.1 - w.1 * d.2) / (d.1 ^ 2 + d.2 ^ 2), ?_⟩
  refine Prod.ext_iff.mpr ⟨?_, ?_⟩ <;>
    simp only [quarterTurn_apply, Prod.fst_add, Prod.snd_add, Prod.smul_fst, Prod.smul_snd,
      smul_eq_mul] <;>
    field_simp <;> ring

end Rotation

/-! ### Periods travel along automorphisms and scalars -/

/-- **A period of a pulled-back colouring is a period of the original, pushed forward.** -/
theorem periodic_of_periodic_comp {A B β : Type*} [AddGroup A] [AddGroup B] {σ : A →+ B}
    (hσ : Function.Surjective σ) {f : B → β} {d : A}
    (h : Function.Periodic (fun a => f (σ a)) d) : Function.Periodic f (σ d) := by
  intro y
  obtain ⟨a, rfl⟩ := hσ y
  simpa [map_add] using h a

/-- **In a `ZMod n`-module every scalar multiple of a period is a period**, because every scalar is a
natural-number multiple. This is the step that confines the theorem below to *prime* fields. -/
theorem periodic_zmod_smul {n : ℕ} [NeZero n] {M β : Type*} [AddCommGroup M] [Module (ZMod n) M]
    {f : M → β} {d : M} (h : Function.Periodic f d) (s : ZMod n) :
    Function.Periodic f (s • d) := by
  have hs : s • d = s.val • d := by
    conv_lhs => rw [← ZMod.natCast_zmod_val s]
    exact Nat.cast_smul_eq_nsmul (ZMod n) s.val d
  rw [hs]
  exact h.nsmul _

/-! ### Every finite Euclidean plane at `p ≡ 3 (mod 4)` is forced-pair-free -/

section FinitePlane

variable {p k : ℕ} [Fact p.Prime]

/-- **The local obligation of the whole module**: a proper colouring is never periodic at both a
nonzero `d` and its quarter turn. The two periods generate a subgroup reaching the circle point
`(1, 0)`, which the colouring would then have to give the origin's colour. -/
theorem not_periodic_quarterTurn (hp : p % 4 = 3) (c : (finitePlane p).Coloring (Fin k))
    {d : ZMod p × ZMod p} (hd : d ≠ 0) (h1 : Function.Periodic (⇑c) d) :
    ¬ Function.Periodic (⇑c) (quarterTurn (ZMod p) d) := by
  intro h2
  obtain ⟨s, t, hst⟩ :=
    exists_smul_quarterTurn_eq (not_isSquare_neg_one_zmod hp) hd ((1 : ZMod p), (0 : ZMod p))
  have h3 : Function.Periodic (⇑c) ((1 : ZMod p), (0 : ZMod p)) := by
    rw [← hst]
    exact (periodic_zmod_smul h1 s).add_period (periodic_zmod_smul h2 t)
  have hadj : (finitePlane p).Adj (0, 0) (1, 0) := by
    rw [unitQuadrance_adj]
    exact ⟨fun heq => zero_ne_one (congrArg Prod.fst heq), by ring⟩
  exact c.valid hadj (by simpa using (h3 (0, 0)).symm)

/-- **No nonzero vector is a period of every colouring**: one of `c` and `c ∘ quarterTurn` refutes it. -/
theorem exists_not_periodic (hp : p % 4 = 3) (c : (finitePlane p).Coloring (Fin k))
    {d : ZMod p × ZMod p} (hd : d ≠ 0) :
    ∃ c' : (finitePlane p).Coloring (Fin k), ¬ Function.Periodic (⇑c') d := by
  by_contra hcon
  have hall : ∀ c' : (finitePlane p).Coloring (Fin k), Function.Periodic (⇑c') d := fun c' => by
    by_contra h'
    exact hcon ⟨c', h'⟩
  refine not_periodic_quarterTurn hp c hd (hall c) ?_
  exact periodic_of_periodic_comp (σ := (quarterTurn (ZMod p)).toAddMonoidHom)
    (quarterTurn (ZMod p)).surjective (hall (c.comap (quarterTurnHom (ZMod p))))

/-- **E1: a finite Euclidean plane has no forced pair, at every prime `≡ 3 (mod 4)` and every colour
count it admits.** -/
theorem finitePlane_forces_iff (hp : p % 4 = 3) (hcol : (finitePlane p).Colorable k)
    {x y : ZMod p × ZMod p} : Forces (finitePlane p) k x y ↔ x = y := by
  refine ⟨Forces.eq_of_forall_exists_not_periodic fun d hd => exists_not_periodic hp hcol.some hd, ?_⟩
  rintro rfl
  exact fun _ => rfl

/-- The shape M61's mechanism consumes: forces-freeness, from colourability. -/
theorem finitePlane_forces_eq (hp : p % 4 = 3) (hcol : (finitePlane p).Colorable k) :
    ∀ u v : ZMod p × ZMod p, Forces (finitePlane p) k u v → u = v :=
  fun _ _ => (finitePlane_forces_iff hp hcol).mp

end FinitePlane

/-! ### The tightness mechanism, fired from colourability alone -/

section Mechanism

variable {V R : Type*} {G : SimpleGraph V} [CommRing R] {p k : ℕ} [Fact p.Prime]

/-- **G48's mechanism with its hypothesis discharged.** `Forces.no_hom_of_spindle_radicand` asked for the
plane at `p` to be forces-free at `k` — a table per prime, held at four primes. It now asks only that the
plane be `k`-colourable. -/
theorem Forces.no_hom_of_spindle_radicand_of_colorable (hp : p % 4 = 3)
    (hcol : (finitePlane p).Colorable k) (g : G →g unitQuadrance R) (φ : R →+* ZMod p) {u v : V}
    (h : Forces G k u v) {x e : R} (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2)
    (he : φ e ≠ 0) : False :=
  Forces.no_hom_of_spindle_radicand hp (finitePlane_forces_eq hp hcol) g φ h hx he

/-- The consumer's shape, from colourability. -/
theorem Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable (hp : p % 4 = 3)
    (hcol : (finitePlane p).Colorable k) (g : G →g unitQuadrance R) {u v : V} (h : Forces G k u v)
    {x e : R} (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : IsUnit e) :
    IsEmpty (R →+* ZMod p) :=
  Forces.isEmpty_ringHom_of_spindle_radicand hp (finitePlane_forces_eq hp hcol) g h hx he

end Mechanism

/-! ### A named inhabitant of the hypothesis, and the red that shows it is load-bearing -/

/-- Colouring by `x + y` is proper on `UD(𝔽₃, 2)`: the circle `{(±1, 0), (0, ±1)}` misses the line
`x + y = 0`. **The named inhabitant** `finitePlane_forces_iff`'s hypothesis needs. -/
def finitePlane3LineColouring : ZMod 3 × ZMod 3 → Fin 3 :=
  fun w => ⟨(w.1 + w.2).val, (w.1 + w.2).val_lt⟩

theorem finitePlane3LineColouring_proper : ∀ u v : ZMod 3 × ZMod 3, (finitePlane 3).Adj u v →
    finitePlane3LineColouring u ≠ finitePlane3LineColouring v := by decide

theorem finitePlane3_colorable_three : (finitePlane 3).Colorable 3 :=
  ⟨Coloring.mk finitePlane3LineColouring fun {u v} h => finitePlane3LineColouring_proper u v h⟩

-- The hypothesis really is inhabited, so the theorem above is not a `∀` over an empty domain.
-- (The named `p = 3` corollary lives downstream in `Instances/PlaneFreedom.lean`, beside the record's
-- other three primes and beside M61's own `finitePlane3_forces_iff`, which this reproves.)
example {x y : ZMod 3 × ZMod 3} : Forces (finitePlane 3) 3 x y ↔ x = y :=
  finitePlane_forces_iff (by decide) finitePlane3_colorable_three

/-- **The red.** `UD(𝔽₃, 2)` refuses two colours — `(0,0), (1,0), (2,0)` is a triangle in characteristic
three — so at `k = 2` every pair of it is *vacuously* forced and `finitePlane_forces_iff` is false without
its colourability hypothesis. -/
theorem finitePlane3_not_colorable_two : ¬ (finitePlane 3).Colorable 2 := by
  rintro ⟨C⟩
  have h01 : C (0, 0) ≠ C (1, 0) := C.valid (by decide)
  have h02 : C (0, 0) ≠ C (2, 0) := C.valid (by decide)
  have h12 : C (1, 0) ≠ C (2, 0) := C.valid (by decide)
  exact (by decide : ∀ a b c : Fin 2, a ≠ b → a ≠ c → b ≠ c → False) _ _ _ h01 h02 h12

example : Forces (finitePlane 3) 2 (0, 0) (1, 1) ∧ ((0, 0) : ZMod 3 × ZMod 3) ≠ (1, 1) :=
  ⟨fun C => absurd ⟨C⟩ finitePlane3_not_colorable_two, by decide⟩

end HadwigerNelson
