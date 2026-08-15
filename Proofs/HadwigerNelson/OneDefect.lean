import Proofs.HadwigerNelson.Homogeneous
import Proofs.HadwigerNelson.Glue
import Proofs.HadwigerNelson.Pigeonhole
import Proofs.HadwigerNelson.Gadget

/-!
# One defect suffices: the spindle as a theorem, and what it buys the descent

The Moser spindle's argument, abstracted and made `k`-generic. If every proper `k`-colouring of the
plane's distance graph gives the same colour to every pair of points at some fixed distance
`d ≥ 1/2`, then there is no proper `k`-colouring at all: pick `x`, a point `y` at distance `d`, and
a point `z` at distance `d` from `x` and `1` from `y` (a `d`–`d`–`1` triangle, which exists exactly
when `d ≥ 1/2`); then `C y = C x = C z` against the unit edge `yz`.

## What the domain-modeling pass found

The classical construction — place a copy of the gadget, rotate it about one endpoint until the
far endpoints are a unit apart — is *not* a step of the proof. Homogeneity (`transport_pair`)
already turns one forced pair into every pair at that distance, so both legs of the triangle are
forced equal without any copy being placed. The theorem is **homogeneity ∘ a triangle**, and the
whole of its geometry is the existence of the triangle (`exists_dist_eq_and_dist_eq_one`, from
`Glue.sphere_inter_sphere` at radii `d` and `1`; its converse for `d < 1/2` is the triangle
inequality and is the red control).

## What it buys the descent (M49)

Read a finite graph in the plane whose edges are unit pairs *plus one non-unit pair* `uv`, and
which is not `k`-colourable. Then every proper `k`-colouring of the unit-edge part gives `u` and `v`
the same colour (`forces_of_not_colorable_append_single`), so `Forces.planeIn` spreads that to
every pair of the plane at distance `|uv|`, and the spindle closes:
**`add_one_le_chromaticNumber_unitDistance_of_one_defect` — a `(k+1)`-chromatic plane graph with
ONE non-unit edge already gives `χ(ℝ²) ≥ k + 1`.** So the descent that trades a two-distance
six-forcer's distance-2 edges for unit material need not reach zero; one is enough. And the same
statement at `k = 3` with the rhombus is the Moser bound, re-proved through the abstract lemma
(`Instances/OneDefectSpec.lean`).

`forces_of_gadget` is the bridge from the certificate algebra: a gadget whose every admitted port
pattern has two ports agreeing is a `Forces` proof, and "every admitted pattern" is a `decide` over
`Fin m → Fin k`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## The triangle -/

/-- **A `d`–`d`–`1` triangle exists at every `d ≥ 1/2`**: given `x, y` at distance `d`, there is `z`
at distance `d` from `x` and `1` from `y`. The circle of radius `d` about `x` and the unit circle
about `y` meet exactly when `|d − 1| ≤ d ≤ d + 1`, i.e. `1/2 ≤ d` — `Glue.sphere_inter_sphere`. -/
theorem exists_dist_eq_and_dist_eq_one {x y : ℂ} {d : ℝ} (hxy : dist x y = d) (hd : 1 / 2 ≤ d) :
    ∃ z : ℂ, dist x z = d ∧ dist y z = 1 := by
  have hpos : 0 < d := by linarith
  have hne : x ≠ y := fun h => by rw [h, dist_self] at hxy; exact hpos.ne hxy
  have hlo : |d - 1| ≤ dist x y := by
    rw [hxy, abs_le]; constructor <;> linarith
  have hhi : dist x y ≤ d + 1 := by rw [hxy]; linarith
  have hmem : Glue.gluePoint x y d 1 ∈ Metric.sphere x d ∩ Metric.sphere y 1 := by
    rw [Glue.sphere_inter_sphere hne hlo hhi]; exact Set.mem_insert _ _
  refine ⟨Glue.gluePoint x y d 1, ?_, ?_⟩
  · rw [dist_comm]; exact Metric.mem_sphere.mp hmem.1
  · rw [dist_comm]; exact Metric.mem_sphere.mp hmem.2

/-- **The red control: below `1/2` there is no such triangle** — `dist y z ≤ dist y x + dist x z =
2d < 1`. So `1/2 ≤ d` in the spindle theorem is load-bearing, and it is exactly the geometric
content the theorem carries. -/
theorem not_exists_dist_eq_and_dist_eq_one_of_lt_half {x y : ℂ} {d : ℝ} (hxy : dist x y = d)
    (hd : d < 1 / 2) : ¬ ∃ z : ℂ, dist x z = d ∧ dist y z = 1 := by
  rintro ⟨z, hxz, hyz⟩
  have := dist_triangle y x z
  rw [dist_comm y x, hxy, hxz, hyz] at this
  linarith

/-! ## The spindle -/

/-- **The spindle theorem.** In the distance graph of any `D ∋ 1`, if every proper `k`-colouring
gives every pair of points at some distance `d ≥ 1/2` the same colour, there is no proper
`k`-colouring: the two legs of a `d`–`d`–`1` triangle are forced equal and its unit side is an
edge. `k`-generic; the Moser spindle is `k = 3`, `d = √3`, `D = {1}`. -/
theorem not_colorable_of_forced_equal {D : Set ℝ} (h1 : (1 : ℝ) ∈ D) {k : ℕ} {d : ℝ}
    (hd : 1 / 2 ≤ d)
    (h : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ), dist x y = d → C x = C y) :
    ¬ (distanceGraph ℂ D).Colorable k := by
  rintro ⟨C⟩
  have hxy : dist (0 : ℂ) (d : ℂ) = d := by
    rw [dist_zero_left, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by linarith)]
  obtain ⟨z, hxz, hyz⟩ := exists_dist_eq_and_dist_eq_one hxy hd
  have hne : (d : ℂ) ≠ z := fun heq => by rw [heq, dist_self] at hyz; exact zero_ne_one hyz
  have hadj : (distanceGraph ℂ D).Adj (d : ℂ) z := ⟨hne, hyz ▸ h1⟩
  exact C.valid hadj ((h C _ _ hxy).symm.trans (h C _ _ hxz))

/-- The spindle theorem in the numeral idiom. -/
theorem add_one_le_chromaticNumber_of_forced_equal {D : Set ℝ} (h1 : (1 : ℝ) ∈ D) {k : ℕ}
    {d : ℝ} (hd : 1 / 2 ≤ d)
    (h : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ), dist x y = d → C x = C y) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ D).chromaticNumber :=
  add_one_le_chromaticNumber_iff_not_colorable.mpr (not_colorable_of_forced_equal h1 hd h)

/-! ## From certificates to `Forces` -/

/-- **A gadget whose every admitted port pattern makes two ports agree is a forced-equal pair.**
The bridge from the certificate algebra (`Gadget.ofUnsat` on the patterns where the ports differ)
to `Forces`; `h` is a `decide` over `Fin m → Fin k`. Colour symmetry is not needed here — `sound`
speaks of every proper colouring directly. -/
theorem forces_of_gadget {k n m : ℕ} {E : List (Fin n × Fin n)} {p : Fin m → Fin n}
    (g : Gadget k n m E p) (i j : Fin m) (h : ∀ q : Fin m → Fin k, g.admits q = true → q i = q j) :
    Forces (edgeGraph n E) k (p i) (p j) :=
  fun C => h (fun t => C (p t)) (g.sound C fun _ _ hij => C.valid hij)

/-- **A refuted one-defect list is a forced-equal pair**: if the edge list with the single extra
pair `(u, v)` is not `k`-colourable, every proper `k`-colouring of the list without it gives `u` and
`v` the same colour. `Pigeonhole.mono_pair_of_not_colorable_append` at `P = [(u, v)]`. -/
theorem forces_of_not_colorable_append_single {k n : ℕ} {E : List (Fin n × Fin n)} {u v : Fin n}
    (h : ¬ (edgeGraph n (E ++ [(u, v)])).Colorable k) : Forces (edgeGraph n E) k u v := by
  intro C
  obtain ⟨p, hp, heq⟩ := mono_pair_of_not_colorable_append h C
  rw [List.mem_singleton] at hp
  subst hp
  exact heq

/-! ## One defect suffices -/

/-- **A forced-equal pair of a finite unit-distance graph, at any distance `d ≥ 1/2`, bounds the
plane's chromatic number.** The gadget's edges realized at unit distance, the forced pair at
distance `d`, and `Forces` — the spindle does the rest. `Forces.planeIn` at `D = {1}`, then
`not_colorable_of_forced_equal`, then the graph rewritten to `unitDistance ℂ`. -/
theorem add_one_le_chromaticNumber_unitDistance_of_forces {ι : Type*} {G : SimpleGraph ι} {k : ℕ}
    (q : ι → ℂ) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hhalf : 1 / 2 ≤ d) (hf : Forces G k u v) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  rw [unitDistance_eq_distanceGraph_singleton]
  refine add_one_le_chromaticNumber_of_forced_equal (D := {1}) rfl hhalf fun C x y hxy => ?_
  exact hf.planeIn q (fun i j hij => Set.mem_singleton_iff.mpr (hq i j hij)) (by norm_num) hd C hxy

/-- **One defect suffices.** A finite graph in the plane whose listed edges are unit pairs *plus one
pair at distance `d ≥ 1/2`*, and which is not `k`-colourable, gives `χ(ℝ²) ≥ k + 1`. In the
descent's terms: a `(k+1)`-chromatic `{1, d}`-graph with a single `d`-edge is as good as a
unit-distance one — μ = 1 already closes. -/
theorem add_one_le_chromaticNumber_unitDistance_of_one_defect {n k : ℕ}
    (E : List (Fin n × Fin n)) (u v : Fin n) (q : Fin n → ℂ)
    (hp : ∀ e ∈ E, dist (q e.1) (q e.2) = 1) {d : ℝ} (hd : dist (q u) (q v) = d)
    (hhalf : 1 / 2 ≤ d) (hG : ¬ (edgeGraph n (E ++ [(u, v)])).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  refine add_one_le_chromaticNumber_unitDistance_of_forces q ?_ hd hhalf
    (forces_of_not_colorable_append_single hG)
  rintro i j ⟨-, hij | hji⟩
  · exact hp (i, j) hij
  · rw [dist_comm]; exact hp (j, i) hji

end HadwigerNelson
