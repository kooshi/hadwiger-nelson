import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Subgraph
import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Proofs.HadwigerNelson.Thomassen

/-!
# Thomassen's steps on valid maps: the map graph, filled holes, 2-separators, the reduced graph `H`, and Lemma 1

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 8) for **FS114-CVB-THOM** with **FS114-CVB-PINCH** (`plans/FS114-CVB-verification.md`
§ 1.9, B1–B2): `[Thomassen1999]`'s steps other than the rainbow step hold for every valid map, Siamese pairs allowed — fill holes, read facial
cycles as boundary walks, replace the count in `int(R)` by local finiteness — and the reduced map graph `H` has a vertex of degree at least `6`.

**Pure graph theory** — not in this file: module `Thomassen` (`Proofs/HadwigerNelson/Thomassen.lean`, namespace `HadwigerNelson.Thomassen`,
over Mathlib's `SimpleGraph`; moved there verbatim by job FS131-IT1), which this file imports and reads:

* `LocallyHamiltonian G` — `[Thomassen1999]` p. 850: "for each `x` in `V(G)`, `G` has a cycle with vertex set `D₁(x)`";
* `lemma1` — Thomassen's Lemma 1 (p. 850): a connected, locally finite, locally Hamiltonian graph with at least `13` vertices has a vertex of
  degree at least `6`. **Formalized here** (a page of counting over the distance layers `D₁, …, D₄`), not imported;
* `twoSepInterior G x y` — CVB's `int(M, x, y)` (B2 step 2): the vertices of the finite components of `G − x − y`; `IsTwoSep`,
  `IsMaximalTwoSep` (Thomassen p. 852: "no 2-separator `{u, v}` with `x` or `y` in `int(M, u, v)`"); `reducedVerts`, `reduced` — `H`, the graph
  with every maximal 2-separator's interior deleted.

**On a map** (`ArcMap`): `mapGraph` (tiles, adjacent when their closures meet), `IsHoleOf` (a nonempty bounded part of the complement of a tile's
closure separated from the rest of it — "a boundary component of `x` disjoint from its outer one", read through the closure; FS131-KP), `fill` (a tile with its holes),
`IsOuterTile` (a tile inside no hole of another tile), `filledGraph` (the filled map's graph: outer tiles, adjacent when their filled closures
meet).

Rows: `cvb_thom_reduced` (B2 steps 1–3: `H` connected, locally finite, locally Hamiltonian, infinite), `cvb_thom` (B2 step 4: a vertex of
`H`-degree at least `6`), `cvb_pinch_connected` and `cvb_hole_disconnected` (B1), `exists_holed_valid_fragment` (B1's "holes are locally
consistent with validity"). Not claimed (the row's own line): the rainbow step on valid maps; the 2-separator criterion at pinches as more
than a sketch.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **The map graph `M`** (CVB § 1.9's frame): the tiles, two distinct tiles adjacent when their closures meet. -/
def mapGraph : SimpleGraph {T : Set ℂ // F.IsTile T} where
  Adj T T' := T ≠ T' ∧ (closure T.1 ∩ closure T'.1).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

/-- **`Hc` is a hole of `T`** (CVB B1: "a boundary component of `x` disjoint from its outer one"; FS131-KP's repair, plan § 2): a nonempty
bounded part of the complement of `T`'s closure whose closure misses the closure of the rest of that complement. The separation makes `Hc` a
union of whole clusters of complementary components (components chained by touching closures) not containing the unbounded one; so `T` has a
hole exactly when the complementary components, joined when their closures touch, are not one cluster — exactly when `mapGraph − T` is
disconnected. It reads the complement of the closure, not the components of `∂T`: a phantom slit can join `∂T`'s components while `cl T`
still separates (plan § 2.2). Not required to be one cluster: `fill`, `IsOuterTile` and the `cvb_*` leaves read holes only through their union
or their existence. -/
def IsHoleOf (T Hc : Set ℂ) : Prop :=
  Hc.Nonempty ∧ Hc ⊆ (closure T)ᶜ ∧ Bornology.IsBounded Hc ∧ Disjoint (closure Hc) (closure ((closure T)ᶜ \ Hc))

/-- **The filled tile** `x̂` (CVB B2 step 1): the tile with its holes. -/
def fill (T : Set ℂ) : Set ℂ := T ∪ ⋃₀ {Hc | IsHoleOf T Hc}

/-- **An outer tile**: a tile lying in no hole of another tile (the tiles the filled map keeps). -/
def IsOuterTile (T : Set ℂ) : Prop := F.IsTile T ∧ ∀ T' Hc, F.IsTile T' → IsHoleOf T' Hc → ¬ T ⊆ Hc

/-- **The filled map's graph** (CVB B2 step 1: "its map graph is `M` minus the hole contents"): the outer tiles, two distinct ones adjacent
when the closures of their filled tiles meet. -/
def filledGraph : SimpleGraph {T : Set ℂ // F.IsOuterTile T} where
  Adj T T' := T ≠ T' ∧ (closure (fill T.1) ∩ closure (fill T'.1)).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

/-! ### Holes are open, and hold whole complementary components (FS131-IP5) -/

namespace IsHoleOf

variable {T Hc : Set ℂ}

/-- A hole is open: `Hc = (cl T)ᶜ ∖ cl ((cl T)ᶜ ∖ Hc)`. -/
theorem isOpen (h : IsHoleOf T Hc) : IsOpen Hc := by
  obtain ⟨-, hsub, -, hsep⟩ := h
  have hHeq : Hc = (closure T)ᶜ \ closure ((closure T)ᶜ \ Hc) := by
    ext z
    constructor
    · intro hz
      exact ⟨hsub hz, fun h => Set.disjoint_left.mp hsep (subset_closure hz) h⟩
    · rintro ⟨hzO, hzn⟩
      by_contra hzH
      exact hzn (subset_closure ⟨hzO, hzH⟩)
  rw [hHeq]; exact isClosed_closure.isOpen_compl.sdiff isClosed_closure

/-- The rest of the complement of a holed tile's closure is open: `(cl T)ᶜ ∖ Hc = (cl T)ᶜ ∖ cl Hc`. -/
theorem isOpen_diff (h : IsHoleOf T Hc) : IsOpen ((closure T)ᶜ \ Hc) := by
  obtain ⟨-, -, -, hsep⟩ := h
  have heq : (closure T)ᶜ \ Hc = (closure T)ᶜ \ closure Hc := by
    ext z
    constructor
    · rintro ⟨hzO, hzH⟩
      exact ⟨hzO, fun hzc => Set.disjoint_left.mp hsep hzc (subset_closure ⟨hzO, hzH⟩)⟩
    · rintro ⟨hzO, hzc⟩
      exact ⟨hzO, fun h => hzc (subset_closure h)⟩
  rw [heq]; exact isClosed_closure.isOpen_compl.sdiff isClosed_closure

/-- A hole holds the whole complementary component of each of its points. -/
theorem connectedComponentIn_subset (h : IsHoleOf T Hc) {y : ℂ} (hy : y ∈ Hc) :
    connectedComponentIn (closure T)ᶜ y ⊆ Hc := by
  refine isPreconnected_connectedComponentIn.subset_left_of_subset_union h.isOpen h.isOpen_diff
    (Set.disjoint_left.mpr fun z hz hz' => hz'.2 hz) (fun z hz => ?_) ⟨y, mem_connectedComponentIn (h.2.1 hy), hy⟩
  by_cases hzH : z ∈ Hc
  · exact Or.inl hzH
  · exact Or.inr ⟨_root_.connectedComponentIn_subset _ _ hz, hzH⟩

/-- A hole misses the outer domain: it is bounded and holds the component of each of its points. -/
theorem subset_compl_outerDom (h : IsHoleOf T Hc) : Hc ⊆ (outerDom T)ᶜ := fun _ hy hyo =>
  hyo.2 (h.2.2.1.subset (h.connectedComponentIn_subset hy))

end IsHoleOf

end ArcMap

/-! ### Spec examples -/

section Spec

/-- A tile of the one-colour plane is the plane (a spec example for `mapGraph`: the one-colour plane's map graph has one vertex, so no
edge). -/
example (j : Fin 2) (T T' : {T : Set ℂ // (ArcMap.const univ isOpen_univ j).IsTile T}) :
    ¬ (ArcMap.const univ isOpen_univ j).mapGraph.Adj T T' := by
  rintro ⟨hne, -⟩
  apply hne
  obtain ⟨T, x, hx, rfl⟩ := T
  obtain ⟨T', y, hy, rfl⟩ := T'
  have hU : (ArcMap.const univ isOpen_univ j).interiorPts = univ := by simp
  apply Subtype.ext
  simp only [hU, connectedComponentIn_univ, PreconnectedSpace.connectedComponent_eq_univ]

/-- **Adversary**: a set with empty closure-complement has no hole (a spec example for `IsHoleOf`: the plane is no tile's hole-maker). -/
example (Hc : Set ℂ) : ¬ ArcMap.IsHoleOf (univ : Set ℂ) Hc := by
  rintro ⟨⟨z, hz⟩, hsub, -⟩
  simpa using hsub hz

/-! ### The two adversaries' plane set: the unit disc minus two closed discs of radius `1/4` (FS131-IP5) -/

/-- A point reached from inside `T` along a continuous path lies in `cl T`. -/
theorem mem_closure_of_path {T : Set ℂ} {z : ℂ} (γ : ℝ → ℂ) (hγ : Continuous γ) (h0 : γ 0 = z)
    (hT : ∀ᶠ t in 𝓝[>] (0 : ℝ), γ t ∈ T) : z ∈ closure T :=
  h0 ▸ mem_closure_of_tendsto ((hγ.tendsto 0).mono_left nhdsWithin_le_nhds) hT

/-- Along a path from `z`, eventually inside any open set holding `z`. -/
theorem eventually_path_mem {U : Set ℂ} {z : ℂ} (hU : IsOpen U) (hz : z ∈ U) (γ : ℝ → ℂ) (hγ : Continuous γ) (h0 : γ 0 = z) :
    ∀ᶠ t in 𝓝[>] (0 : ℝ), γ t ∈ U :=
  Filter.Eventually.filter_mono nhdsWithin_le_nhds ((hγ.tendsto 0).eventually (hU.mem_nhds (h0.symm ▸ hz)))

/-- The open set the adversaries read: inside the unit circle, outside two closed discs of radius `1/4`. -/
theorem mem_disc_minus_iff {c₁ c₂ w : ℂ} :
    w ∈ ball 0 1 \ (closedBall c₁ (1 / 4) ∪ closedBall c₂ (1 / 4)) ↔ ‖w‖ < 1 ∧ 1 / 4 < ‖w - c₁‖ ∧ 1 / 4 < ‖w - c₂‖ := by
  simp only [Set.mem_sdiff, mem_ball, mem_union, mem_closedBall, dist_eq_norm, sub_zero, not_or, not_le]

/-- **Points of the closed region off the tangencies are limits of the open one**: a point of the closed unit disc outside the two open
discs, where at most one of the three circles passes, is reached from the open region by a radial push (inward from the unit circle, outward
from a small circle). -/
theorem mem_closure_disc_minus {c₁ c₂ z : ℂ} (hz1 : ‖z‖ ≤ 1) (h1 : 1 / 4 ≤ ‖z - c₁‖) (h2 : 1 / 4 ≤ ‖z - c₂‖)
    (hu : ‖z‖ = 1 → 1 / 4 < ‖z - c₁‖ ∧ 1 / 4 < ‖z - c₂‖) (hd1 : ‖z - c₁‖ = 1 / 4 → ‖z‖ < 1 ∧ 1 / 4 < ‖z - c₂‖)
    (hd2 : ‖z - c₂‖ = 1 / 4 → ‖z‖ < 1 ∧ 1 / 4 < ‖z - c₁‖) :
    z ∈ closure (ball 0 1 \ (closedBall c₁ (1 / 4) ∪ closedBall c₂ (1 / 4))) := by
  have hO : ∀ c : ℂ, IsOpen {w : ℂ | 1 / 4 < ‖w - c‖} := fun c =>
    isOpen_lt continuous_const (continuous_norm.comp (continuous_id.sub continuous_const))
  have hB : IsOpen {w : ℂ | ‖w‖ < 1} := isOpen_lt continuous_norm continuous_const
  have hpos : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < t ∧ t < 1 := Ioo_mem_nhdsGT one_pos
  rcases eq_or_lt_of_le hz1 with hz | hz
  · -- inward from the unit circle
    obtain ⟨h1', h2'⟩ := hu hz
    have hγ : Continuous fun t : ℝ => ((1 - t : ℝ) : ℂ) * z := (Complex.continuous_ofReal.comp (continuous_const.sub continuous_id)).mul continuous_const
    refine mem_closure_of_path _ hγ (by simp) ?_
    filter_upwards [hpos, eventually_path_mem (hO c₁) h1' _ hγ (by simp), eventually_path_mem (hO c₂) h2' _ hγ (by simp)]
      with t ht ht1 ht2
    refine mem_disc_minus_iff.mpr ⟨?_, ht1, ht2⟩
    rw [norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith [ht.2]), hz]
    linarith [ht.1]
  rcases eq_or_lt_of_le h1 with hc1 | hc1
  · -- outward from the first small circle
    obtain ⟨hz', h2'⟩ := hd1 hc1.symm
    have hγ : Continuous fun t : ℝ => z + (t : ℂ) * (z - c₁) := continuous_const.add (Complex.continuous_ofReal.mul continuous_const)
    refine mem_closure_of_path _ hγ (by simp) ?_
    filter_upwards [hpos, eventually_path_mem hB hz' _ hγ (by simp), eventually_path_mem (hO c₂) h2' _ hγ (by simp)]
      with t ht ht0 ht2
    refine mem_disc_minus_iff.mpr ⟨ht0, ?_, ht2⟩
    have : z + (t : ℂ) * (z - c₁) - c₁ = ((1 + t : ℝ) : ℂ) * (z - c₁) := by push_cast; ring
    rw [this, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith [ht.1]), ← hc1]
    nlinarith [ht.1]
  rcases eq_or_lt_of_le h2 with hc2 | hc2
  · -- outward from the second small circle
    obtain ⟨hz', h1'⟩ := hd2 hc2.symm
    have hγ : Continuous fun t : ℝ => z + (t : ℂ) * (z - c₂) := continuous_const.add (Complex.continuous_ofReal.mul continuous_const)
    refine mem_closure_of_path _ hγ (by simp) ?_
    filter_upwards [hpos, eventually_path_mem hB hz' _ hγ (by simp), eventually_path_mem (hO c₁) h1' _ hγ (by simp)]
      with t ht ht0 ht1
    refine mem_disc_minus_iff.mpr ⟨ht0, ht1, ?_⟩
    have : z + (t : ℂ) * (z - c₂) - c₂ = ((1 + t : ℝ) : ℂ) * (z - c₂) := by push_cast; ring
    rw [this, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith [ht.1]), ← hc2]
    nlinarith [ht.1]
  exact subset_closure (mem_disc_minus_iff.mpr ⟨hz, hc1, hc2⟩)

/-- **A tangency point is a limit of the open region**: at `p` with `p − c₁ = −1/4`, `p − c₂ = 1/4` (two small circles tangent at `p`, inside
the unit circle), the vertical path `p + t i` enters the region. -/
theorem mem_closure_disc_minus_tangent {c₁ c₂ p : ℂ} (hp : ‖p‖ < 1) (h1 : p - c₁ = (1 / 4 : ℝ)) (h2 : p - c₂ = (-1 / 4 : ℝ)) :
    p ∈ closure (ball 0 1 \ (closedBall c₁ (1 / 4) ∪ closedBall c₂ (1 / 4))) := by
  have hγ : Continuous fun t : ℝ => p + (t : ℂ) * I := continuous_const.add (Complex.continuous_ofReal.mul continuous_const)
  refine mem_closure_of_path _ hγ (by simp) ?_
  filter_upwards [Ioo_mem_nhdsGT (one_pos (α := ℝ)),
    eventually_path_mem (isOpen_lt continuous_norm continuous_const) (show p ∈ {w : ℂ | ‖w‖ < 1} from hp) _ hγ (by simp)]
    with t ht ht0
  refine mem_disc_minus_iff.mpr ⟨ht0, ?_, ?_⟩
  · rw [show p + (t : ℂ) * I - c₁ = ((1 / 4 : ℝ) : ℂ) + (t : ℂ) * I by rw [← h1]; ring, Complex.norm_add_mul_I,
      Real.lt_sqrt (by norm_num)]
    nlinarith [ht.1]
  · rw [show p + (t : ℂ) * I - c₂ = ((-1 / 4 : ℝ) : ℂ) + (t : ℂ) * I by rw [← h2]; ring, Complex.norm_add_mul_I,
      Real.lt_sqrt (by norm_num)]
    nlinarith [ht.1]

/-- The squared distance to a real centre. -/
theorem sq_norm_sub_ofReal (z : ℂ) (a : ℝ) : ‖z - a‖ ^ 2 = (z.re - a) ^ 2 + z.im ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.ofReal_re, Complex.sub_im, Complex.ofReal_im,
    sub_zero]; ring

/-- `‖w‖ ≤ r ↔ ‖w‖² ≤ r²` for `r ≥ 0`, as used on the adversaries' circles. -/
theorem norm_le_iff_sq {w : ℂ} {r : ℝ} (hr : 0 ≤ r) : ‖w‖ ≤ r ↔ ‖w‖ ^ 2 ≤ r ^ 2 :=
  (pow_le_pow_iff_left₀ (norm_nonneg w) hr two_ne_zero).symm

/-- **The closure of the unit disc minus two closed discs** of radius `1/4` about real centres in `[-1/2, 3/4]`, given which points are
limits: off the three open pieces, every point is. -/
theorem compl_closure_disc_minus_subset {c₁ c₂ : ℂ}
    (hlim : ∀ z : ℂ, ‖z‖ ≤ 1 → 1 / 4 ≤ ‖z - c₁‖ → 1 / 4 ≤ ‖z - c₂‖ →
      z ∈ closure (ball 0 1 \ (closedBall c₁ (1 / 4) ∪ closedBall c₂ (1 / 4)))) :
    (closure (ball 0 1 \ (closedBall c₁ (1 / 4) ∪ closedBall c₂ (1 / 4))))ᶜ ⊆ (closedBall 0 1)ᶜ ∪ ball c₁ (1 / 4) ∪ ball c₂ (1 / 4) := by
  intro z hz
  by_contra h
  simp only [mem_union, mem_compl_iff, mem_closedBall, mem_ball, dist_eq_norm, sub_zero, not_or, not_le, not_lt] at h
  exact hz (hlim z h.1.1 h.1.2 h.2)

/-- The three open pieces miss the closure (it lies in the closed region). -/
theorem closure_disc_minus_subset (c₁ c₂ : ℂ) :
    closure (ball 0 1 \ (closedBall c₁ (1 / 4) ∪ closedBall c₂ (1 / 4))) ⊆ closedBall 0 1 \ (ball c₁ (1 / 4) ∪ ball c₂ (1 / 4)) :=
  closure_minimal (sdiff_subset_sdiff ball_subset_closedBall (union_subset_union ball_subset_closedBall ball_subset_closedBall))
    (isClosed_closedBall.sdiff (isOpen_ball.union isOpen_ball))

/-- Squared norms of a point against real centres. -/
theorem sq_facts (z : ℂ) (a : ℝ) {r : ℝ} :
    (‖z - a‖ ≤ r → (z.re - a) ^ 2 + z.im ^ 2 ≤ r ^ 2) ∧ (‖z - a‖ = r → (z.re - a) ^ 2 + z.im ^ 2 = r ^ 2) := by
  rw [← sq_norm_sub_ofReal]
  exact ⟨fun h => pow_le_pow_left₀ (norm_nonneg _) h 2, fun h => by rw [h]⟩

/-- **Adversary: a chain to the outside is no hole** (FS131-I5b's counterexample to the old definition, as a plane set; plan § 2.3): the
unit disc minus the closed discs of radius `1/4` about `1/4` and `3/4` — the first touches the second at `1/2`, the second touches the unit
circle at `1`. A separated part of the complement holding either small disc holds the other, then the outside, so it is unbounded. (Under the
old definition the disc about `1/4` was a hole, and `cvb_hole_disconnected` was false.) -/
theorem not_isHoleOf_chain (Hc : Set ℂ) :
    ¬ ArcMap.IsHoleOf (ball 0 1 \ (closedBall (1 / 4 : ℂ) (1 / 4) ∪ closedBall (3 / 4 : ℂ) (1 / 4))) Hc := by
  have e₁ : (1 / 4 : ℂ) = ((1 / 4 : ℝ) : ℂ) := by push_cast; ring
  have e₂ : (3 / 4 : ℂ) = ((3 / 4 : ℝ) : ℂ) := by push_cast; ring
  have hn0 : ∀ z : ℂ, ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := fun z => by rw [Complex.sq_norm, Complex.normSq_apply]; ring
  have n₁ : ‖(1 / 4 : ℂ)‖ = 1 / 4 := by rw [e₁, Complex.norm_real]; norm_num
  have hO1 : IsOpen {w : ℂ | 1 / 4 < ‖w - 1 / 4‖} := isOpen_lt continuous_const (continuous_norm.comp (continuous_id.sub continuous_const))
  -- every point of the closed region is a limit (the tangencies are `1/2` and `1`)
  have hlim : ∀ z : ℂ, ‖z‖ ≤ 1 → 1 / 4 ≤ ‖z - 1 / 4‖ → 1 / 4 ≤ ‖z - 3 / 4‖ →
      z ∈ closure (ball 0 1 \ (closedBall (1 / 4 : ℂ) (1 / 4) ∪ closedBall (3 / 4 : ℂ) (1 / 4))) := by
    intro z hz h1 h2
    by_cases hh : z = ((1 / 2 : ℝ) : ℂ)
    · subst hh
      exact mem_closure_disc_minus_tangent (by rw [Complex.norm_real]; norm_num) (by push_cast; ring) (by push_cast; ring)
    by_cases hh' : z = 1
    · subst hh'
      have hγ : Continuous fun t : ℝ => ((1 - t : ℝ) : ℂ) + ((√t : ℝ) : ℂ) * I :=
        (Complex.continuous_ofReal.comp (continuous_const.sub continuous_id)).add
          ((Complex.continuous_ofReal.comp Real.continuous_sqrt).mul continuous_const)
      refine mem_closure_of_path _ hγ (by simp) ?_
      have h1' : (1 : ℂ) ∈ {w : ℂ | 1 / 4 < ‖w - 1 / 4‖} := by
        show (1 / 4 : ℝ) < ‖(1 : ℂ) - 1 / 4‖
        rw [show (1 : ℂ) - 1 / 4 = ((3 / 4 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real]; norm_num
      filter_upwards [Ioo_mem_nhdsGT (one_pos (α := ℝ)), eventually_path_mem hO1 h1' _ hγ (by simp)] with t ht ht1
      have hs : (√t) ^ 2 = t := Real.sq_sqrt ht.1.le
      refine mem_disc_minus_iff.mpr ⟨?_, ht1, ?_⟩
      · rw [Complex.norm_add_mul_I, Real.sqrt_lt' one_pos]; nlinarith [ht.1, ht.2]
      · rw [show ((1 - t : ℝ) : ℂ) + ((√t : ℝ) : ℂ) * I - 3 / 4 = ((1 / 4 - t : ℝ) : ℂ) + ((√t : ℝ) : ℂ) * I by push_cast; ring,
          Complex.norm_add_mul_I, Real.lt_sqrt (by norm_num)]
        nlinarith [ht.1]
    have hne₁ : ¬ ((z.re - 1 / 2) ^ 2 = 0 ∧ z.im ^ 2 = 0) := fun ⟨a, b⟩ => hh (Complex.ext
      (by simp; linarith [pow_eq_zero_iff (n := 2) two_ne_zero |>.mp a]) (by simp [pow_eq_zero_iff (n := 2) two_ne_zero |>.mp b]))
    have hne₂ : ¬ ((z.re - 1) ^ 2 = 0 ∧ z.im ^ 2 = 0) := fun ⟨a, b⟩ => hh' (Complex.ext
      (by simp; linarith [pow_eq_zero_iff (n := 2) two_ne_zero |>.mp a]) (by simp [pow_eq_zero_iff (n := 2) two_ne_zero |>.mp b]))
    have q1 := sq_facts z (1 / 4) (r := 1 / 4)
    have q2 := sq_facts z (3 / 4) (r := 1 / 4)
    rw [← e₁] at q1
    rw [← e₂] at q2
    have hre : z.re ^ 2 ≤ 1 := by
      have := pow_le_pow_left₀ (norm_nonneg z) hz 2
      rw [hn0] at this; nlinarith [sq_nonneg z.im]
    refine mem_closure_disc_minus hz h1 h2 (fun hu => ⟨?_, ?_⟩) (fun hd => ⟨?_, ?_⟩) (fun hd => ⟨?_, ?_⟩)
    · linarith [norm_sub_norm_le z (1 / 4 : ℂ)]
    · by_contra h
      push Not at h
      have k0 := hn0 z
      rw [hu] at k0
      have k2 := q2.1 h
      exact hne₂ ⟨by nlinarith [sq_nonneg (z.re - 1), sq_nonneg z.im], by nlinarith [sq_nonneg (z.re - 1), sq_nonneg z.im]⟩
    · linarith [norm_le_norm_add_norm_sub' z (1 / 4 : ℂ)]
    · by_contra h
      push Not at h
      have k1 := q1.2 hd
      have k2 := q2.1 h
      exact hne₁ ⟨by nlinarith [sq_nonneg (z.re - 1 / 2), sq_nonneg z.im], by nlinarith [sq_nonneg (z.re - 1 / 2), sq_nonneg z.im]⟩
    · by_contra h
      push Not at h
      have k0 : 1 ≤ z.re ^ 2 + z.im ^ 2 := by rw [← hn0]; nlinarith [norm_nonneg z]
      have k2 := q2.2 hd
      exact hne₂ ⟨by nlinarith [sq_nonneg (z.re - 1), sq_nonneg z.im], by nlinarith [sq_nonneg (z.re - 1), sq_nonneg z.im]⟩
    · by_contra h
      push Not at h
      have k1 := q1.1 h
      have k2 := q2.2 hd
      exact hne₁ ⟨by nlinarith [sq_nonneg (z.re - 1 / 2), sq_nonneg z.im], by nlinarith [sq_nonneg (z.re - 1 / 2), sq_nonneg z.im]⟩
  -- the three open pieces of the complement, and their touching points
  intro hH
  have hHo := hH.isOpen
  have hRo := hH.isOpen_diff
  obtain ⟨hne, hsub, hb, hsep⟩ := hH
  have hO := compl_closure_disc_minus_subset hlim
  have hcl := closure_disc_minus_subset (1 / 4 : ℂ) (3 / 4)
  set O := (closure (ball 0 1 \ (closedBall (1 / 4 : ℂ) (1 / 4) ∪ closedBall (3 / 4 : ℂ) (1 / 4))))ᶜ with hOdef
  have hE : (closedBall (0 : ℂ) 1)ᶜ ⊆ O := fun z hz h => hz (hcl h).1
  have hB₁ : ball (1 / 4 : ℂ) (1 / 4) ⊆ O := fun z hz h => (hcl h).2 (Or.inl hz)
  have hB₂ : ball (3 / 4 : ℂ) (1 / 4) ⊆ O := fun z hz h => (hcl h).2 (Or.inr hz)
  have side : ∀ P : Set ℂ, IsPreconnected P → P ⊆ O → P ⊆ Hc ∨ P ⊆ O \ Hc := fun P hP hPO =>
    hP.subset_or_subset hHo hRo (Set.disjoint_left.mpr fun z hz hz' => hz'.2 hz) fun z hz => by
      by_cases h : z ∈ Hc
      · exact Or.inl h
      · exact Or.inr ⟨hPO hz, h⟩
  have nottouch : ∀ {P Q : Set ℂ}, P ⊆ Hc → Q ⊆ O \ Hc → (closure P ∩ closure Q).Nonempty → False :=
    fun hP hQ ⟨w, hw1, hw2⟩ => Set.disjoint_left.mp hsep (closure_mono hP hw1) (closure_mono hQ hw2)
  have half : (1 / 2 : ℂ) ∈ closure (ball (1 / 4 : ℂ) (1 / 4)) ∩ closure (ball (3 / 4 : ℂ) (1 / 4)) := by
    rw [closure_ball _ (by norm_num), closure_ball _ (by norm_num), mem_inter_iff, mem_closedBall, mem_closedBall, dist_eq_norm,
      dist_eq_norm, show (1 / 2 : ℂ) - 1 / 4 = ((1 / 4 : ℝ) : ℂ) by push_cast; ring,
      show (1 / 2 : ℂ) - 3 / 4 = ((-1 / 4 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Complex.norm_real]
    norm_num
  have one : (1 : ℂ) ∈ closure (ball (3 / 4 : ℂ) (1 / 4)) ∩ closure (closedBall (0 : ℂ) 1)ᶜ := by
    refine ⟨?_, ?_⟩
    · rw [closure_ball _ (by norm_num), mem_closedBall, dist_eq_norm,
        show (1 : ℂ) - 3 / 4 = ((1 / 4 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real]
      norm_num
    · have hγ : Continuous fun t : ℝ => ((1 + t : ℝ) : ℂ) := Complex.continuous_ofReal.comp (continuous_const.add continuous_id)
      refine mem_closure_of_path _ hγ (by simp) ?_
      filter_upwards [Ioo_mem_nhdsGT (one_pos (α := ℝ))] with t ht
      rw [mem_compl_iff, mem_closedBall, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by linarith [ht.1])]
      linarith [ht.1]
  -- the outside is unbounded, so it misses `Hc`; hence so do the discs chained to it
  have hEH : ¬ (closedBall (0 : ℂ) 1)ᶜ ⊆ Hc := fun h => by
    obtain ⟨R, hR⟩ := hb.subset_closedBall 0
    obtain ⟨z, hz⟩ := ArcMap.exists_not_mem_closedBall_zero (max R 1)
    exact hz (closedBall_subset_closedBall (le_max_left _ _) (hR (h fun h' => hz (closedBall_subset_closedBall (le_max_right _ _) h'))))
  have hEout : (closedBall (0 : ℂ) 1)ᶜ ⊆ O \ Hc := (side _ (isPreconnected_compl_closedBall 0 1) hE).resolve_left hEH
  have hB₂out : ball (3 / 4 : ℂ) (1 / 4) ⊆ O \ Hc :=
    (side _ (convex_ball _ _).isPreconnected hB₂).resolve_left fun h => nottouch h hEout ⟨1, one⟩
  have hB₁out : ball (1 / 4 : ℂ) (1 / 4) ⊆ O \ Hc :=
    (side _ (convex_ball _ _).isPreconnected hB₁).resolve_left fun h => nottouch h hB₂out ⟨1 / 2, half⟩
  obtain ⟨h, hh⟩ := hne
  rcases hO (hsub hh) with (h' | h') | h'
  · exact (hEout h').2 hh
  · exact (hB₁out h').2 hh
  · exact (hB₂out h').2 hh

/-- **A cluster is one hole** (item 242's case; plan § 2.3): the unit disc minus the closed discs of radius `1/4` about `±1/4`, which touch at
`0` and miss the unit circle; the two open small discs together are a hole (neither alone is: their closures touch). Exercises the separation
clause on a hole of two components. -/
theorem isHoleOf_cluster :
    ArcMap.IsHoleOf (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4)))
      (ball (-1 / 4 : ℂ) (1 / 4) ∪ ball (1 / 4 : ℂ) (1 / 4)) ∧
    ¬ ArcMap.IsHoleOf (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4))) (ball (1 / 4 : ℂ) (1 / 4)) := by
  have e₁ : (-1 / 4 : ℂ) = ((-1 / 4 : ℝ) : ℂ) := by push_cast; ring
  have e₂ : (1 / 4 : ℂ) = ((1 / 4 : ℝ) : ℂ) := by push_cast; ring
  have n₁ : ‖(-1 / 4 : ℂ)‖ = 1 / 4 := by rw [e₁, Complex.norm_real]; norm_num
  have n₂ : ‖(1 / 4 : ℂ)‖ = 1 / 4 := by rw [e₂, Complex.norm_real]; norm_num
  have hcl := closure_disc_minus_subset (-1 / 4 : ℂ) (1 / 4)
  -- every point of the closed region is a limit (the one tangency is `0`)
  have hlim : ∀ z : ℂ, ‖z‖ ≤ 1 → 1 / 4 ≤ ‖z - (-1 / 4)‖ → 1 / 4 ≤ ‖z - 1 / 4‖ →
      z ∈ closure (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4))) := by
    intro z hz h1 h2
    by_cases h0 : z = 0
    · subst h0
      exact mem_closure_disc_minus_tangent (by simp) (by push_cast; ring) (by push_cast; ring)
    have hne : ¬ (z.re ^ 2 = 0 ∧ z.im ^ 2 = 0) := fun ⟨a, b⟩ => h0 (Complex.ext
      (by simp [pow_eq_zero_iff (n := 2) two_ne_zero |>.mp a]) (by simp [pow_eq_zero_iff (n := 2) two_ne_zero |>.mp b]))
    have q1 := sq_facts z (-1 / 4) (r := 1 / 4)
    have q2 := sq_facts z (1 / 4) (r := 1 / 4)
    rw [← e₁] at q1
    rw [← e₂] at q2
    refine mem_closure_disc_minus hz h1 h2 (fun hu => ⟨?_, ?_⟩) (fun hd => ⟨?_, ?_⟩) (fun hd => ⟨?_, ?_⟩)
    · linarith [norm_sub_norm_le z (-1 / 4 : ℂ)]
    · linarith [norm_sub_norm_le z (1 / 4 : ℂ)]
    · linarith [norm_le_norm_add_norm_sub' z (-1 / 4 : ℂ)]
    · by_contra h
      push Not at h
      have k1 := q1.2 hd
      have k2 := q2.1 h
      exact hne ⟨by nlinarith [sq_nonneg z.re, sq_nonneg z.im], by nlinarith [sq_nonneg z.re, sq_nonneg z.im]⟩
    · linarith [norm_le_norm_add_norm_sub' z (1 / 4 : ℂ)]
    · by_contra h
      push Not at h
      have k1 := q1.1 h
      have k2 := q2.2 hd
      exact hne ⟨by nlinarith [sq_nonneg z.re, sq_nonneg z.im], by nlinarith [sq_nonneg z.re, sq_nonneg z.im]⟩
  have hO := compl_closure_disc_minus_subset hlim
  set O := (closure (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4))))ᶜ with hOdef
  have hB₁ : ball (-1 / 4 : ℂ) (1 / 4) ⊆ O := fun z hz h => (hcl h).2 (Or.inl hz)
  have hB₂ : ball (1 / 4 : ℂ) (1 / 4) ⊆ O := fun z hz h => (hcl h).2 (Or.inr hz)
  have hcB : ∀ c : ℂ, closure (ball c (1 / 4)) ⊆ closedBall 0 (1 / 2) ∨ ‖c‖ ≠ 1 / 4 := fun c => by
    by_cases hc : ‖c‖ = 1 / 4
    · left
      rw [closure_ball _ (by norm_num)]
      intro w hw
      rw [mem_closedBall, dist_eq_norm] at hw
      rw [mem_closedBall, dist_zero_right]
      linarith [norm_le_norm_add_norm_sub' w c]
    · exact Or.inr hc
  have hsmall : ∀ c : ℂ, ‖c‖ = 1 / 4 → closure (ball c (1 / 4)) ⊆ closedBall 0 (1 / 2) := fun c hc =>
    (hcB c).resolve_right fun h => h hc
  have zero_mem : ∀ c : ℂ, ‖c‖ = 1 / 4 → (0 : ℂ) ∈ closure (ball c (1 / 4)) := fun c hc => by
    rw [closure_ball _ (by norm_num), mem_closedBall, dist_eq_norm, zero_sub, norm_neg, hc]
  refine ⟨⟨⟨-1 / 4, Or.inl (mem_ball_self (by norm_num))⟩, fun z hz => ?_, (isBounded_ball.union isBounded_ball), ?_⟩, ?_⟩
  · rcases hz with hz | hz
    · exact hB₁ hz
    · exact hB₂ hz
  · -- the rest of the complement is the outside of the unit disc
    rw [Set.disjoint_left]
    intro w hw hw'
    have hrest : O \ (ball (-1 / 4 : ℂ) (1 / 4) ∪ ball (1 / 4 : ℂ) (1 / 4)) ⊆ (ball (0 : ℂ) 1)ᶜ := by
      rintro v ⟨hvO, hvH⟩
      rcases hO hvO with (h | h) | h
      · intro hv; exact h (ball_subset_closedBall hv)
      · exact absurd (Or.inl h) hvH
      · exact absurd (Or.inr h) hvH
    have h1 := closure_minimal hrest isOpen_ball.isClosed_compl hw'
    rw [closure_union] at hw
    have h2 : w ∈ closedBall (0 : ℂ) (1 / 2) := hw.elim (fun h => hsmall _ n₁ h) (fun h => hsmall _ n₂ h)
    rw [mem_closedBall, dist_zero_right] at h2
    exact h1 (by rw [mem_ball, dist_zero_right]; linarith)
  · -- one small disc alone is not separated: the other touches it at `0`
    rintro ⟨-, -, -, hsep⟩
    refine Set.disjoint_left.mp hsep (zero_mem _ n₂) (closure_mono ?_ (zero_mem _ n₁))
    intro v hv
    refine ⟨hB₁ hv, fun hv' => ?_⟩
    rw [mem_ball, dist_eq_norm] at hv hv'
    linarith [norm_sub_norm_le (v - (-1 / 4 : ℂ)) (v - 1 / 4),
      show ‖(v - (-1 / 4 : ℂ)) - (v - 1 / 4)‖ = 1 / 2 by
        rw [show (v - (-1 / 4 : ℂ)) - (v - 1 / 4) = ((1 / 2 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real]; norm_num,
      norm_sub_le (v - (-1 / 4 : ℂ)) (v - 1 / 4)]

end Spec

namespace ArcMap

/-! ## Holes and filled tiles (FS131-IP5): openness, nesting, and every tile inside an outer tile's fill -/


/-- A filled tile lies in its hull. -/
theorem fill_subset_compl_outerDom (T : Set ℂ) : fill T ⊆ (outerDom T)ᶜ := by
  rintro z (hz | ⟨Hc, hH, hzH⟩) hzo
  · exact hzo.1 (subset_closure hz)
  · exact IsHoleOf.subset_compl_outerDom hH hzH hzo

/-- A tile lies in its fill. -/
theorem subset_fill (T : Set ℂ) : T ⊆ fill T := fun _ hz => Or.inl hz

variable {k : ℕ} {F : ArcMap k}

/-- The closure of a filled tile lies within `1` of each point of the tile's closure (its hull does: `compl_outerDom_subset_closedBall`). -/
theorem closure_fill_subset_closedBall (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {w : ℂ} (hw : w ∈ closure T) :
    closure (fill T) ⊆ closedBall w 1 :=
  closure_minimal ((fill_subset_compl_outerDom T).trans
    (compl_outerDom_subset_closedBall (hT.closure_subset_closedBall hF hw))) isClosed_closedBall

/-- A tile inside a hole of `T` is enclosed by `T`. -/
theorem encloses_of_subset_hole {T S Hc : Set ℂ} (hS : F.IsTile S) (hH : IsHoleOf T Hc) (hSH : S ⊆ Hc) :
    EnclosesTile T S := by
  obtain ⟨y, hy⟩ := hS.nonempty
  exact ⟨y, ⟨hy, hH.2.1 (hSH hy)⟩, hH.2.2.1.subset (hH.connectedComponentIn_subset (hSH hy))⟩

/-- **Nested holes**: if the tile `T₁` lies in a hole `Hc₂` of the tile `T₂`, every hole of `T₁` lies in `Hc₂`. (`T₂` is not in a hole of
`T₁`, else each encloses the other and their hulls coincide, against `not_encloses_of_hull_eq`; so the holes of `T₁` miss `cl T₂`, and each
component `D` of a hole of `T₁` is on one side of `Hc₂`'s separation — the side of `cl T₁ ⊆ cl Hc₂`, which `cl D` meets on its frontier.) -/
theorem hole_subset_hole (hF : F.Valid) (hP : F.IsPlaneMap) {T₁ T₂ Hc₁ Hc₂ : Set ℂ} (h₁ : F.IsTile T₁) (h₂ : F.IsTile T₂)
    (hH₂ : IsHoleOf T₂ Hc₂) (hT₁ : T₁ ⊆ Hc₂) (hH₁ : IsHoleOf T₁ Hc₁) : Hc₁ ⊆ Hc₂ := by
  have hdom : ∀ S : Set ℂ, S ⊆ F.dom := fun S => by rw [hP]; exact subset_univ _
  obtain ⟨x₁, hx₁⟩ := h₁.nonempty
  have h12 : T₁ ≠ T₂ := fun h => hH₂.2.1 (hT₁ hx₁) (h ▸ subset_closure hx₁)
  -- `T₂` lies on the far side of `Hc₁`'s separation
  have hT₂ : T₂ ⊆ (closure T₁)ᶜ \ Hc₁ := by
    have hcov : T₂ ⊆ Hc₁ ∪ ((closure T₁)ᶜ \ Hc₁) := fun z hz => by
      by_cases hzH : z ∈ Hc₁
      · exact Or.inl hzH
      · exact Or.inr ⟨IsTile.subset_compl_closure h₁ h₂ h12.symm hz, hzH⟩
    rcases h₂.subset_or_subset_of_separated hH₁.2.2.2 hcov with h | h
    · exfalso
      have e12 : EnclosesTile T₁ T₂ := encloses_of_subset_hole h₂ hH₁ h
      have e21 : EnclosesTile T₂ T₁ := encloses_of_subset_hole h₁ hH₂ hT₁
      exact not_encloses_of_hull_eq hF h₂ h₁ (hdom _)
        (Subset.antisymm (outerDom_subset_of_encloses h₂ h₁ e12) (outerDom_subset_of_encloses h₁ h₂ e21)) e12
    · exact h
  have hHc₁O : Hc₁ ⊆ (closure T₂)ᶜ := fun z hz hz2 =>
    Set.disjoint_left.mp hH₁.2.2.2 (subset_closure hz) (closure_mono hT₂ hz2)
  intro w hw
  set D := connectedComponentIn (closure T₁)ᶜ w with hD
  have hwD : w ∈ D := mem_connectedComponentIn (hH₁.2.1 hw)
  have hDO : D ⊆ (closure T₂)ᶜ := (hH₁.connectedComponentIn_subset hw).trans hHc₁O
  -- a frontier point of `D` lies in `cl T₁ ⊆ cl Hc₂`
  have hfr : (frontier D).Nonempty := by
    rw [nonempty_frontier_iff]
    exact ⟨⟨w, hwD⟩, fun h => (h ▸ mem_univ x₁ : x₁ ∈ D) |> connectedComponentIn_subset _ _ |>.elim (subset_closure hx₁)⟩
  obtain ⟨z, hz⟩ := hfr
  have hzT₁ : z ∈ closure T₁ := by
    simpa using frontier_connectedComponentIn_subset isClosed_closure.isOpen_compl w hz
  have hzH₂ : z ∈ closure Hc₂ := closure_mono hT₁ hzT₁
  rcases isPreconnected_connectedComponentIn.subset_or_subset hH₂.isOpen hH₂.isOpen_diff
      (Set.disjoint_left.mpr fun z hz hz' => hz'.2 hz) (fun z hz => by
        by_cases hzH : z ∈ Hc₂
        · exact Or.inl hzH
        · exact Or.inr ⟨hDO hz, hzH⟩) with h | h
  · exact h hwD
  · exact absurd (closure_mono h hz.1) (Set.disjoint_left.mp hH₂.2.2.2 hzH₂)

/-- A tile inside a hole of another tile has its whole fill there (`hole_subset_hole`). -/
theorem fill_subset_hole (hF : F.Valid) (hP : F.IsPlaneMap) {T T' Hc' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T')
    (hH' : IsHoleOf T' Hc') (hTH : T ⊆ Hc') : fill T ⊆ Hc' := by
  rintro z (hz | ⟨Hc, hH, hzH⟩)
  · exact hTH hz
  · exact hole_subset_hole hF hP hT hT' hH' hTH hH hzH

/-- **Every tile lies in an outer tile's fill** (FS131-IP5; the chain of enclosing holes stops, as in `exists_outermost`): among the tiles
whose fill holds `S` — finitely many, their closures meeting `B̄(s, 1)` — one with a maximal hull is outer, since a hole holding it holds its
fill (`fill_subset_hole`) and its tile encloses it, strictly growing the hull (`not_encloses_of_hull_eq`). -/
theorem exists_outer_fill (hF : F.Valid) (hP : F.IsPlaneMap) {S : Set ℂ} (hS : F.IsTile S) :
    ∃ T, F.IsOuterTile T ∧ S ⊆ fill T := by
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  obtain ⟨s, hs⟩ := hS.nonempty
  set C := {T | F.IsTile T ∧ S ⊆ fill T} with hCdef
  have hfin : C.Finite := by
    refine (finite_tiles_closure_inter (isCompact_closedBall s 1) (hdom _)).subset ?_
    rintro T ⟨hT, hST⟩
    obtain ⟨w, hw⟩ := hT.nonempty
    have := closure_fill_subset_closedBall hF hT (subset_closure hw) (subset_closure (hST hs))
    refine ⟨hT, w, subset_closure hw, ?_⟩
    rw [mem_closedBall, dist_comm]; exact this
  have hne : C.Nonempty := ⟨S, hS, subset_fill S⟩
  obtain ⟨T, hTmax⟩ := hfin.exists_maximalFor (fun T => (outerDom T)ᶜ) C hne
  obtain ⟨hT, hST⟩ := hTmax.1
  refine ⟨T, ⟨hT, fun T' Hc' hT' hH' hTH => ?_⟩, hST⟩
  have henc := encloses_of_subset_hole hT hH' hTH
  have hT'C : T' ∈ C := ⟨hT', fun z hz => Or.inr ⟨Hc', hH', fill_subset_hole hF hP hT hT' hH' hTH (hST hz)⟩⟩
  have hle : (outerDom T)ᶜ ⊆ (outerDom T')ᶜ := compl_subset_compl.mpr (outerDom_subset_of_encloses hT hT' henc)
  have hge : (outerDom T')ᶜ ⊆ (outerDom T)ᶜ := hTmax.2 hT'C hle
  exact not_encloses_of_hull_eq hF hT hT' (hdom _) (compl_injective (Subset.antisymm hge hle)) henc

/-- Two outer tiles whose filled closures meet are equal or adjacent in the filled map graph, so joined. -/
theorem filledGraph_reachable_of_inter {a b : {T : Set ℂ // F.IsOuterTile T}}
    (h : (closure (fill a.1) ∩ closure (fill b.1)).Nonempty) : F.filledGraph.Reachable a b := by
  by_cases hab : a = b
  · exact hab ▸ SimpleGraph.Reachable.refl _
  · exact SimpleGraph.Adj.reachable ⟨hab, h⟩

/-- Two outer tiles whose fills hold one tile `S` are joined. -/
theorem filledGraph_reachable_of_subset {a b : {T : Set ℂ // F.IsOuterTile T}} {S : Set ℂ} (hS : S.Nonempty)
    (ha : S ⊆ fill a.1) (hb : S ⊆ fill b.1) : F.filledGraph.Reachable a b := by
  obtain ⟨s, hs⟩ := hS
  exact filledGraph_reachable_of_inter ⟨s, subset_closure (ha hs), subset_closure (hb hs)⟩

/-! ## FS114-CVB-THOM -/

/-- The filled map graph is locally finite (FS131-KP plan § 4, leaf F-LOC): a filled tile lies in its hull, inside `B̄(x, 1)` for any `x` in
its closure (`IsTile.closure_subset_closedBall`, `exists_outermost`'s hull bound), so the tiles whose filled closures meet it have closures
meeting a compact set (`finite_tiles_closure_inter`). -/
theorem filledGraph_locallyFinite (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    (F.filledGraph.neighborSet x).Finite := by
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  obtain ⟨p, hp⟩ := x.2.1.nonempty
  -- a neighbour's tile has its closure within `2` of `p`
  refine ((finite_tiles_closure_inter (isCompact_closedBall p 2) (hdom _)).preimage
    Subtype.val_injective.injOn).subset fun y hy => ?_
  obtain ⟨-, z, hzx, hzy⟩ := hy
  obtain ⟨q, hq⟩ := y.2.1.nonempty
  have h1 := closure_fill_subset_closedBall hF x.2.1 (subset_closure hp) hzx
  have h2 := closure_fill_subset_closedBall hF y.2.1 (subset_closure hq) hzy
  refine ⟨y.2.1, q, subset_closure hq, ?_⟩
  rw [mem_closedBall] at h1 h2 ⊢
  linarith [dist_triangle q z p, dist_comm z q]

/-- The filled map graph is connected (leaf F-CONN): the filled outer tiles' closures cover the plane (every tile lies in an outer tile's
fill: the enclosure chain stops, as in `exists_outermost`), so `mem_of_touch_closed` on `U = ℂ` with the touching relation of the fills. -/
theorem filledGraph_connected (hF : F.Valid) (hP : F.IsPlaneMap) : F.filledGraph.Connected := by
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  obtain ⟨S₀, hS₀, -⟩ := exists_tile_inter_of_isOpen isOpen_univ (hdom _) univ_nonempty
  obtain ⟨T₀, hT₀, hS₀T₀⟩ := exists_outer_fill hF hP hS₀
  set x₀ : {T : Set ℂ // F.IsOuterTile T} := ⟨T₀, hT₀⟩
  -- the tiles lying in the fill of an outer tile joined to `x₀`
  set P : Set (Set ℂ) := {S | F.IsTile S ∧ ∃ (T : Set ℂ) (hT : F.IsOuterTile T), S ⊆ fill T ∧ F.filledGraph.Reachable x₀ ⟨T, hT⟩}
  have key := mem_of_touch_closed isOpen_univ isPreconnected_univ (hdom _) (fun T _ _ => subset_univ T) P
    (fun S hS => ⟨hS.1, subset_univ S⟩) ⟨S₀, hS₀, T₀, hT₀, hS₀T₀, SimpleGraph.Reachable.refl _⟩ (by
      rintro S ⟨hS, T, hT, hST, hreach⟩ S' hS' - ⟨z, hzS, hzS'⟩
      obtain ⟨T', hT', hS'T'⟩ := exists_outer_fill hF hP hS'
      exact ⟨hS', T', hT', hS'T', hreach.trans (filledGraph_reachable_of_inter (a := ⟨T, hT⟩) (b := ⟨T', hT'⟩)
        ⟨z, closure_mono hST hzS, closure_mono hS'T' hzS'⟩)⟩)
  haveI : Nonempty {T : Set ℂ // F.IsOuterTile T} := ⟨x₀⟩
  have hall : ∀ v : {T : Set ℂ // F.IsOuterTile T}, F.filledGraph.Reachable x₀ v := by
    intro v
    obtain ⟨-, T, hT, hvT, hreach⟩ := key v.1 v.2.1 (subset_univ _)
    exact hreach.trans (filledGraph_reachable_of_subset (a := ⟨T, hT⟩) v.2.1.nonempty hvT (subset_fill v.1))
  exact ⟨fun v w => (hall v).symm.trans (hall w)⟩

/-- The filled map graph is infinite (leaf F-INF): the plane is unbounded and every filled tile bounded. -/
theorem filledGraph_infinite (hF : F.Valid) (hP : F.IsPlaneMap) : Infinite {T : Set ℂ // F.IsOuterTile T} := by
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  by_contra hfin
  rw [not_infinite_iff_finite] at hfin
  -- the filled closures of the finitely many outer tiles lie in one disc
  have hb : Bornology.IsBounded (⋃ T : {T : Set ℂ // F.IsOuterTile T}, closure (fill T.1)) := by
    rw [Bornology.isBounded_iUnion]
    intro T
    obtain ⟨w, hw⟩ := T.2.1.nonempty
    exact isBounded_closedBall.subset (closure_fill_subset_closedBall hF T.2.1 (subset_closure hw))
  obtain ⟨R, hR⟩ := hb.subset_closedBall 0
  -- but a point outside it lies in the closure of a tile, inside an outer tile's fill
  obtain ⟨z, hz⟩ := exists_not_mem_closedBall_zero R
  obtain ⟨S, hS, hzS⟩ := F.mem_closure_tile (hdom _ (mem_univ z))
  obtain ⟨T, hT, hST⟩ := exists_outer_fill hF hP hS
  exact hz (hR (mem_iUnion.mpr ⟨⟨T, hT⟩, closure_mono hST hzS⟩))

/-! ### The far side, and Janiszewski's theorem for holes (FS131-IP5; for F-ONE, F-SEP and F-RING) -/

/-- **A tile meeting a filled closure** is the tile or lies in one of its holes (it is open, so it meets the fill; a hole is separated from
the rest of the complement). -/
theorem eq_or_subset_hole_of_inter {X S : Set ℂ} (hX : F.IsTile X) (hS : F.IsTile S) (h : (S ∩ closure (fill X)).Nonempty) :
    S = X ∨ ∃ Hc, IsHoleOf X Hc ∧ S ⊆ Hc := by
  obtain ⟨z, hzf, hzS⟩ := (closure_inter_open_nonempty_iff hS.isOpen).mp (by rw [inter_comm]; exact h)
  rcases hzf with hzX | ⟨Hc, hH, hzH⟩
  · exact Or.inl (hS.eq_of_mem hX hzS hzX)
  · have hSX : S ≠ X := fun h => hH.2.1 hzH (subset_closure (h ▸ hzS))
    refine Or.inr ⟨Hc, hH, (hS.subset_or_subset_of_separated hH.2.2.2 fun w hw => ?_).resolve_right fun h' => (h' hzS).2 hzH⟩
    by_cases hwH : w ∈ Hc
    · exact Or.inl hwH
    · exact Or.inr ⟨IsTile.subset_compl_closure hX hS hSX hw, hwH⟩

/-- A tile meeting a filled closure lies in the fill. -/
theorem subset_fill_of_inter {X S : Set ℂ} (hX : F.IsTile X) (hS : F.IsTile S) (h : (S ∩ closure (fill X)).Nonempty) :
    S ⊆ fill X := by
  rcases eq_or_subset_hole_of_inter hX hS h with rfl | ⟨Hc, hH, hSH⟩
  · exact subset_fill S
  · exact fun z hz => Or.inr ⟨Hc, hH, hSH hz⟩

/-- An outer tile other than `X` misses the filled closure of `X`. -/
theorem IsOuterTile.disjoint_closure_fill {X S : Set ℂ} (hX : F.IsTile X) (hS : F.IsOuterTile S) (hne : S ≠ X) :
    Disjoint S (closure (fill X)) := by
  rw [Set.disjoint_iff_inter_eq_empty, ← not_nonempty_iff_eq_empty]
  intro h
  rcases eq_or_subset_hole_of_inter hX hS.1 h with h' | ⟨Hc, hH, hSH⟩
  · exact hne h'
  · exact hS.2 X Hc hX hH hSH

/-- Outer tiles off `x`, `y` whose filled closures meet are joined in `M̂ − x − y`. -/
theorem reachable_offTwo_of_inter {x y : {T : Set ℂ // F.IsOuterTile T}} {a b : Thomassen.offTwo x y}
    (h : (closure (fill a.1.1) ∩ closure (fill b.1.1)).Nonempty) : (F.filledGraph.induce (Thomassen.offTwo x y)).Reachable a b := by
  by_cases hab : a = b
  · exact hab ▸ SimpleGraph.Reachable.refl _
  · exact SimpleGraph.Adj.reachable (SimpleGraph.induce_adj.mpr ⟨fun h' => hab (Subtype.ext h'), h⟩)

/-- A tile meeting the complement of two filled closures lies in it (`subset_fill_of_inter`). -/
theorem subset_compl_of_inter_compl {X Y S : Set ℂ} (hX : F.IsTile X) (hY : F.IsTile Y) (hS : F.IsTile S)
    (h : (S ∩ (closure (fill X) ∪ closure (fill Y))ᶜ).Nonempty) : S ⊆ (closure (fill X) ∪ closure (fill Y))ᶜ := by
  obtain ⟨z, hzS, hzK⟩ := h
  rintro w hwS (hw | hw)
  · exact hzK (Or.inl (subset_closure (subset_fill_of_inter hX hS ⟨w, hwS, hw⟩ hzS)))
  · exact hzK (Or.inr (subset_closure (subset_fill_of_inter hY hS ⟨w, hwS, hw⟩ hzS)))

/-- An outer tile other than `x`, `y` misses their filled closures. -/
theorem subset_compl_of_mem_offTwo {x y : {T : Set ℂ // F.IsOuterTile T}} (v : {T : Set ℂ // F.IsOuterTile T})
    (hv : v ∈ Thomassen.offTwo x y) : v.1 ⊆ (closure (fill x.1) ∪ closure (fill y.1))ᶜ := by
  rintro w hw (h | h)
  · exact Set.disjoint_left.mp (IsOuterTile.disjoint_closure_fill x.2.1 v.2 fun h' => hv.1 (Subtype.ext h')) hw h
  · exact Set.disjoint_left.mp (IsOuterTile.disjoint_closure_fill y.2.1 v.2 fun h' => hv.2 (Subtype.ext h')) hw h

/-- A tile off two filled closures lies in the fill of an outer tile other than those two (`exists_outer_fill`). -/
theorem exists_outer_fill_offTwo (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T}) {S : Set ℂ}
    (hS : F.IsTile S) (hSK : S ⊆ (closure (fill x.1) ∪ closure (fill y.1))ᶜ) :
    ∃ (T : Set ℂ) (hT : F.IsOuterTile T), (⟨T, hT⟩ : {T : Set ℂ // F.IsOuterTile T}) ∈ Thomassen.offTwo x y ∧ S ⊆ fill T := by
  obtain ⟨T, hT, hST⟩ := exists_outer_fill hF hP hS
  obtain ⟨s, hs⟩ := hS.nonempty
  refine ⟨T, hT, ⟨fun h => hSK hs (Or.inl ?_), fun h => hSK hs (Or.inr ?_)⟩, hST⟩
  · rw [show x.1 = T from (congrArg Subtype.val h).symm]; exact subset_closure (hST hs)
  · rw [show y.1 = T from (congrArg Subtype.val h).symm]; exact subset_closure (hST hs)

/-- Off two outer tiles, infinitely many remain (`filledGraph_infinite`). -/
theorem offTwo_infinite (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T}) :
    (Thomassen.offTwo x y).Infinite := by
  haveI := filledGraph_infinite hF hP
  have hS : Thomassen.offTwo x y = ({x, y} : Set {T : Set ℂ // F.IsOuterTile T})ᶜ := by
    ext v; simp [Thomassen.offTwo]
  rw [hS]
  exact (Set.toFinite _).infinite_compl

/-- **The far side is one class** (F-ONE, F-SEP; FS131-IP5): for outer tiles `x`, `y` (equal allowed) whose filled closures lie in `B̄(c, R)`,
`M̂ − x − y` has an infinite component holding every outer tile other than `x`, `y` that meets `B̄(c, R)ᶜ`. Every tile meeting the
complement `Kᶜ` of the two filled closures lies in it (`eq_or_subset_hole_of_inter`), hence in one of its components; the tiles of the
unbounded component `W ⊇ B̄(c, R)ᶜ` are chained by touching closures (`mem_of_touch_closed`), each lies in the fill of an outer tile other than
`x`, `y` (`exists_outer_fill`), and those fills reach arbitrarily far. -/
theorem exists_far_component (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T}) {c : ℂ} {R : ℝ}
    (hR : closure (fill x.1) ∪ closure (fill y.1) ⊆ closedBall c R) :
    ∃ C : (F.filledGraph.induce (Thomassen.offTwo x y)).ConnectedComponent, ¬ C.supp.Finite ∧
      ∀ v (hv : v ∈ Thomassen.offTwo x y), (v.1 ∩ (closedBall c R)ᶜ).Nonempty →
        (F.filledGraph.induce (Thomassen.offTwo x y)).connectedComponentMk ⟨v, hv⟩ = C := by
  classical
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  set G' := F.filledGraph.induce (Thomassen.offTwo x y) with hG'
  set K := closure (fill x.1) ∪ closure (fill y.1) with hK
  have hKc : IsOpen Kᶜ := (isClosed_closure.union isClosed_closure).isOpen_compl
  have htile : ∀ S, F.IsTile S → (S ∩ Kᶜ).Nonempty → S ⊆ Kᶜ := fun S hS h => subset_compl_of_inter_compl x.2.1 y.2.1 hS h
  have hrep : ∀ S, F.IsTile S → S ⊆ Kᶜ → ∃ (T : Set ℂ) (hT : F.IsOuterTile T),
      (⟨T, hT⟩ : {T : Set ℂ // F.IsOuterTile T}) ∈ Thomassen.offTwo x y ∧ S ⊆ fill T := fun S hS hSK =>
    exists_outer_fill_offTwo hF hP x y hS hSK
  -- the unbounded component `W`
  obtain ⟨z₀, hz₀⟩ := exists_not_mem_closedBall_zero (‖c‖ + |R| + 1)
  have hfar : ∀ z : ℂ, ‖c‖ + |R| < ‖z‖ → z ∉ closedBall c R := fun z hz h => by
    rw [mem_closedBall, dist_eq_norm] at h
    linarith [norm_sub_norm_le z c, le_abs_self R]
  have hz₀R : z₀ ∉ closedBall c R := hfar z₀ (by
    rw [mem_closedBall, dist_zero_right, not_le] at hz₀; linarith)
  set W := connectedComponentIn Kᶜ z₀ with hW
  have hWo : IsOpen W := hKc.connectedComponentIn
  have hRW : (closedBall c R)ᶜ ⊆ W :=
    (isPreconnected_compl_closedBall c R).subset_connectedComponentIn hz₀R (compl_subset_compl.mpr hR)
  have hin : ∀ S, F.IsTile S → (S ∩ W).Nonempty → S ⊆ W := by
    rintro S hS ⟨z, hzS, hzW⟩
    have hSK := htile S hS ⟨z, hzS, connectedComponentIn_subset _ _ hzW⟩
    rw [hW, connectedComponentIn_eq hzW]
    exact hS.isPreconnected.subset_connectedComponentIn hzS hSK
  -- the seed
  obtain ⟨S₀, hS₀, hS₀R⟩ := exists_tile_inter_of_isOpen isClosed_closedBall.isOpen_compl (hdom _) ⟨z₀, hz₀R⟩
  have hS₀W : S₀ ⊆ W := hin S₀ hS₀ (hS₀R.mono fun z hz => ⟨hz.1, hRW hz.2⟩)
  obtain ⟨T₀, hT₀, hT₀o, hS₀T₀⟩ := hrep S₀ hS₀ (hS₀W.trans (connectedComponentIn_subset _ _))
  set C := G'.connectedComponentMk ⟨⟨T₀, hT₀⟩, hT₀o⟩ with hC
  set P : Set (Set ℂ) := {S | F.IsTile S ∧ S ⊆ W ∧ ∃ (T : Set ℂ) (hT : F.IsOuterTile T)
    (hTo : (⟨T, hT⟩ : {T : Set ℂ // F.IsOuterTile T}) ∈ Thomassen.offTwo x y), S ⊆ fill T ∧ G'.connectedComponentMk ⟨⟨T, hT⟩, hTo⟩ = C}
  have key := mem_of_touch_closed hWo isPreconnected_connectedComponentIn (hdom _) hin P (fun S hS => ⟨hS.1, hS.2.1⟩)
    ⟨S₀, hS₀, hS₀W, T₀, hT₀, hT₀o, hS₀T₀, rfl⟩ (by
      rintro S ⟨hS, hSW, T, hT, hTo, hST, hTC⟩ S' hS' hS'W ⟨z, hzS, hzS'⟩
      obtain ⟨T', hT', hT'o, hS'T'⟩ := hrep S' hS' (hS'W.trans (connectedComponentIn_subset _ _))
      refine ⟨hS', hS'W, T', hT', hT'o, hS'T', ?_⟩
      rw [← hTC]
      exact (SimpleGraph.ConnectedComponent.sound (reachable_offTwo_of_inter (a := ⟨⟨T, hT⟩, hTo⟩) (b := ⟨⟨T', hT'⟩, hT'o⟩)
        ⟨z, closure_mono hST hzS, closure_mono hS'T' hzS'⟩)).symm)
  refine ⟨C, fun hfin => ?_, fun v hv hvR => ?_⟩
  · -- the fills of the component's tiles are bounded, but tiles of `W` reach arbitrarily far
    have hb : Bornology.IsBounded (⋃ v ∈ C.supp, closure (fill v.1.1)) := by
      refine (Bornology.isBounded_biUnion hfin).mpr fun v _ => ?_
      obtain ⟨w, hw⟩ := v.1.2.1.nonempty
      exact isBounded_closedBall.subset (closure_fill_subset_closedBall hF v.1.2.1 (subset_closure hw))
    obtain ⟨R', hR'⟩ := hb.subset_closedBall 0
    obtain ⟨z, hz⟩ := exists_not_mem_closedBall_zero (max R' (‖c‖ + |R|))
    have hzR : z ∉ closedBall c R := hfar z (by
      rw [mem_closedBall, dist_zero_right, not_le] at hz; linarith [le_max_right R' (‖c‖ + |R|)])
    obtain ⟨S, hS, hzS⟩ := F.mem_closure_tile (hdom _ (mem_univ z))
    have hSW : S ⊆ W := hin S hS (((closure_inter_open_nonempty_iff isClosed_closedBall.isOpen_compl).mp
      ⟨z, hzS, hzR⟩).mono fun w hw => ⟨hw.1, hRW hw.2⟩)
    obtain ⟨-, -, T, hT, hTo, hST, hTC⟩ := key S hS hSW
    have hzT : z ∈ closure (fill T) := closure_mono hST hzS
    exact hz (closedBall_subset_closedBall (le_max_left _ _) (hR' (mem_iUnion₂.mpr
      ⟨⟨⟨T, hT⟩, hTo⟩, (SimpleGraph.ConnectedComponent.mem_supp_iff _ _).mpr hTC, hzT⟩)))
  · -- an outer tile meeting the far region lies in `W`, inside the fill of a tile of the component
    have hvW : v.1 ⊆ W := hin v.1 v.2.1 (hvR.mono fun w hw => ⟨hw.1, hRW hw.2⟩)
    obtain ⟨-, -, T, hT, hTo, hvT, hTC⟩ := key v.1 v.2.1 hvW
    rw [← hTC]
    exact SimpleGraph.ConnectedComponent.sound (reachable_offTwo_of_inter (a := ⟨v, hv⟩) (b := ⟨⟨T, hT⟩, hTo⟩)
      (let ⟨s, hs⟩ := v.2.1.nonempty; ⟨s, subset_closure (subset_fill v.1 hs), subset_closure (hvT hs)⟩))

/-! ## Janiszewski's theorem for holes (FS131-IP5), pure plane topology -/

/-- **A piece of a hole cut by a split is a hole of one continuum**: `X` an open part of `(A ∪ B)ᶜ` separated from the rest, `u`, `v` closed
sets splitting `cl X ∪ A ∪ B` with `B` on the `u` side; then `X ∩ v`, when nonempty and bounded, is a hole of `A`. -/
theorem isHoleOf_inter_of_split {A B X u v : Set ℂ} (hA : IsClosed A) (hB : IsClosed B) (hXK : X ⊆ (A ∪ B)ᶜ)
    (hsep : Disjoint (closure X) (closure ((A ∪ B)ᶜ \ X))) (hu : IsClosed u) (hv : IsClosed v)
    (hcov : closure X ∪ (A ∪ B) ⊆ u ∪ v) (hdis : Disjoint ((closure X ∪ (A ∪ B)) ∩ u) v) (hBu : B ⊆ u)
    (hne : (X ∩ v).Nonempty) (hbd : Bornology.IsBounded (X ∩ v)) : IsHoleOf A (X ∩ v) := by
  set M := closure X ∪ (A ∪ B) with hM
  have hMc : IsClosed M := isClosed_closure.union (hA.union hB)
  have hXM : X ⊆ M := fun z hz => Or.inl (subset_closure hz)
  have hcl : closure (X ∩ v) ⊆ M ∩ v :=
    closure_minimal (fun z hz => ⟨hXM hz.1, hz.2⟩) (hMc.inter hv)
  refine ⟨hne, ?_, hbd, ?_⟩
  · rw [hA.closure_eq]; exact fun z hz hzA => hXK hz.1 (Or.inl hzA)
  · rw [hA.closure_eq]
    have hsub : Aᶜ \ (X ∩ v) ⊆ (M ∩ u) ∪ ((A ∪ B)ᶜ \ X) := by
      rintro z ⟨hzA, hzXv⟩
      by_cases hzB : z ∈ B
      · exact Or.inl ⟨Or.inr (Or.inr hzB), hBu hzB⟩
      by_cases hzX : z ∈ X
      · refine Or.inl ⟨hXM hzX, ?_⟩
        rcases hcov (hXM hzX) with h | h
        · exact h
        · exact absurd ⟨hzX, h⟩ hzXv
      · exact Or.inr ⟨fun h => h.elim hzA hzB, hzX⟩
    rw [Set.disjoint_left]
    intro z hz hz'
    have hz'' := closure_mono hsub hz'
    rw [closure_union, (hMc.inter hu).closure_eq] at hz''
    rcases hz'' with h | h
    · exact Set.disjoint_left.mp hdis ⟨h.1, h.2⟩ (hcl hz).2
    · exact Set.disjoint_left.mp hsep (closure_mono inter_subset_left hz) h

/-- **No split of `cl X ∪ A ∪ B`** (the step of `not_isHoleOf_union`): with `A`, `B` closed sets without holes, `B` a continuum, each meeting
`cl X`, and one of the two pieces of `X` bounded, a split of `cl X ∪ A ∪ B` by closed `u ⊇ A`, `v` is impossible — it would cut `X` into a hole
of `A` or of `B` (`isHoleOf_inter_of_split`), or into a nonempty proper clopen subset of `ℂ`. -/
theorem not_split_aux {A B X u v : Set ℂ} (hA : IsClosed A) (hB : IsClosed B) (hBc : IsPreconnected B)
    (hAne : A.Nonempty) (hAh : ∀ H, ¬ IsHoleOf A H) (hBh : ∀ H, ¬ IsHoleOf B H) (hXo : IsOpen X) (hXK : X ⊆ (A ∪ B)ᶜ)
    (hsep : Disjoint (closure X) (closure ((A ∪ B)ᶜ \ X))) (hAX : (A ∩ closure X).Nonempty) (hBX : (B ∩ closure X).Nonempty)
    (hu : IsClosed u) (hv : IsClosed v) (hcov : closure X ∪ (A ∪ B) ⊆ u ∪ v) (hdis : Disjoint ((closure X ∪ (A ∪ B)) ∩ u) v)
    (hMv : ((closure X ∪ (A ∪ B)) ∩ v).Nonempty) (hAu : A ⊆ u)
    (hbd : Bornology.IsBounded (X ∩ u) ∨ Bornology.IsBounded (X ∩ v)) : False := by
  set M := closure X ∪ (A ∪ B) with hM
  have hMc : IsClosed M := isClosed_closure.union (hA.union hB)
  have hXM : X ⊆ M := fun z hz => Or.inl (subset_closure hz)
  have hdis' : Disjoint (M ∩ v) u := by
    rw [Set.disjoint_left]; exact fun z hz hzu => Set.disjoint_left.mp hdis ⟨hz.1, hzu⟩ hz.2
  -- `B` lies on one side
  have hBuv : B ⊆ u ∨ B ⊆ v := by
    by_contra h
    push Not at h
    obtain ⟨⟨b, hbB, hbu⟩, ⟨b', hb'B, hb'v⟩⟩ := And.intro (not_subset.mp h.1) (not_subset.mp h.2)
    obtain ⟨w, hwB, hwu, hwv⟩ := isPreconnected_closed_iff.mp hBc u v hu hv
      (fun z hz => hcov (Or.inr (Or.inr hz))) ⟨b', hb'B, (hcov (Or.inr (Or.inr hb'B))).resolve_right hb'v⟩
      ⟨b, hbB, (hcov (Or.inr (Or.inr hbB))).resolve_left hbu⟩
    exact Set.disjoint_left.mp hdis ⟨Or.inr (Or.inr hwB), hwu⟩ hwv
  rcases hBuv with hBu | hBv
  · -- `A ∪ B ⊆ u`: `X ∩ v` is clopen in `ℂ`, nonempty, and misses `A`
    have hKu : A ∪ B ⊆ u := union_subset hAu hBu
    have hcl : closure (X ∩ v) ⊆ X ∩ v := by
      intro z hz
      have hzM : z ∈ M ∩ v := closure_minimal (s := X ∩ v) (t := M ∩ v) (fun w hw => ⟨hXM hw.1, hw.2⟩) (hMc.inter hv) hz
      have hzu : z ∉ u := Set.disjoint_left.mp hdis' hzM
      have hzK : z ∉ A ∪ B := fun h => hzu (hKu h)
      have hzX : z ∈ closure X := closure_mono inter_subset_left hz
      by_contra hzXv
      have hzX' : z ∉ X := fun h => hzXv ⟨h, hzM.2⟩
      exact Set.disjoint_left.mp hsep hzX (subset_closure ⟨hzK, hzX'⟩)
    have hop : IsOpen (X ∩ v) := by
      have : X ∩ v = X ∩ uᶜ := by
        ext z
        refine ⟨fun h => ⟨h.1, Set.disjoint_left.mp hdis' ⟨hXM h.1, h.2⟩⟩, fun h => ⟨h.1, ?_⟩⟩
        exact (hcov (hXM h.1)).resolve_left h.2
      rw [this]; exact hXo.inter hu.isOpen_compl
    have hne : (X ∩ v).Nonempty := by
      by_contra hne
      rw [not_nonempty_iff_eq_empty] at hne
      have hXu : X ⊆ u := fun z hz => (hcov (hXM hz)).resolve_right fun h => (hne ▸ ⟨hz, h⟩ : z ∈ (∅ : Set ℂ))
      obtain ⟨z, hzM, hzv⟩ := hMv
      rcases hzM with hz | hz
      · exact Set.disjoint_left.mp hdis' ⟨Or.inl hz, hzv⟩ (closure_minimal hXu hu hz)
      · exact Set.disjoint_left.mp hdis' ⟨Or.inr hz, hzv⟩ (hKu hz)
    have huniv := (isClopen_iff.mp ⟨closure_subset_iff_isClosed.mp hcl, hop⟩).resolve_left hne.ne_empty
    obtain ⟨a, ha⟩ := hAne
    exact hXK (huniv ▸ mem_univ a : a ∈ X ∩ v).1 (Or.inl ha)
  · -- `B ⊆ v`: one piece of `X` is a hole of `A` or of `B`
    have hdisv : Disjoint ((closure X ∪ (B ∪ A)) ∩ v) u := by
      rw [union_comm B A]; exact hdis'
    rcases hbd with hb | hb
    · -- `X ∩ u` is a hole of `A`
      refine hAh _ (isHoleOf_inter_of_split hA hB hXK hsep hv hu (by rw [union_comm v u]; exact hcov) hdis' hBv ?_ hb)
      obtain ⟨a, haA, haX⟩ := hAX
      by_contra hne
      rw [not_nonempty_iff_eq_empty] at hne
      have hXv : X ⊆ v := fun z hz => (hcov (hXM hz)).resolve_left fun h => (hne ▸ ⟨hz, h⟩ : z ∈ (∅ : Set ℂ))
      exact Set.disjoint_left.mp hdis' ⟨Or.inr (Or.inl haA), closure_minimal hXv hv haX⟩ (hAu haA)
    · -- `X ∩ v` is a hole of `B`
      have hXK' : X ⊆ (B ∪ A)ᶜ := by rw [union_comm]; exact hXK
      have hsep' : Disjoint (closure X) (closure ((B ∪ A)ᶜ \ X)) := by rw [union_comm]; exact hsep
      refine hBh _ (isHoleOf_inter_of_split hB hA hXK' hsep' hu hv (by rw [union_comm B A]; exact hcov)
        (by rw [union_comm B A]; exact hdis) hAu ?_ hb)
      obtain ⟨b, hbB, hbX⟩ := hBX
      by_contra hne
      rw [not_nonempty_iff_eq_empty] at hne
      have hXu : X ⊆ u := fun z hz => (hcov (hXM hz)).resolve_right fun h => (hne ▸ ⟨hz, h⟩ : z ∈ (∅ : Set ℂ))
      exact Set.disjoint_left.mp hdis' ⟨Or.inr (Or.inr hbB), hBv hbB⟩ (closure_minimal hXu hu hbX)

/-- `cl X ∪ A ∪ B` is preconnected (by `not_split_aux`, on whichever side of a split `A` lies). -/
theorem isPreconnected_closure_union_aux {A B X : Set ℂ} (hA : IsClosed A) (hB : IsClosed B) (hAc : IsPreconnected A)
    (hBc : IsPreconnected B) (hAne : A.Nonempty) (hAh : ∀ H, ¬ IsHoleOf A H)
    (hBh : ∀ H, ¬ IsHoleOf B H) (hXo : IsOpen X) (hXK : X ⊆ (A ∪ B)ᶜ) (hsep : Disjoint (closure X) (closure ((A ∪ B)ᶜ \ X)))
    (hAX : (A ∩ closure X).Nonempty) (hBX : (B ∩ closure X).Nonempty)
    (hbd : ∀ u v : Set ℂ, IsClosed u → IsClosed v → X ⊆ u ∪ v → Disjoint (X ∩ u) v →
      Bornology.IsBounded (X ∩ u) ∨ Bornology.IsBounded (X ∩ v)) :
    IsPreconnected (closure X ∪ (A ∪ B)) := by
  set M := closure X ∪ (A ∪ B) with hM
  have hXM : X ⊆ M := fun z hz => Or.inl (subset_closure hz)
  rw [isPreconnected_closed_iff]
  intro u v hu hv hcov hMu hMv
  by_contra hne
  have hdis : Disjoint (M ∩ u) v := by
    rw [Set.disjoint_left]; exact fun z hz hzv => hne ⟨z, hz.1, hz.2, hzv⟩
  have hdis' : Disjoint (M ∩ v) u := by
    rw [Set.disjoint_left]; exact fun z hz hzu => hne ⟨z, hz.1, hzu, hz.2⟩
  have hXdis : ∀ {u v : Set ℂ}, Disjoint (M ∩ u) v → Disjoint (X ∩ u) v := fun h => by
    rw [Set.disjoint_left]; exact fun z hz hzv => Set.disjoint_left.mp h ⟨hXM hz.1, hz.2⟩ hzv
  -- `A` lies on one side
  have hAuv : A ⊆ u ∨ A ⊆ v := by
    by_contra h
    push Not at h
    obtain ⟨⟨a, haA, hau⟩, ⟨a', ha'A, ha'v⟩⟩ := And.intro (not_subset.mp h.1) (not_subset.mp h.2)
    obtain ⟨w, hwA, hwu, hwv⟩ := isPreconnected_closed_iff.mp hAc u v hu hv
      (fun z hz => hcov (Or.inr (Or.inl hz))) ⟨a', ha'A, (hcov (Or.inr (Or.inl ha'A))).resolve_right ha'v⟩
      ⟨a, haA, (hcov (Or.inr (Or.inl haA))).resolve_left hau⟩
    exact Set.disjoint_left.mp hdis ⟨Or.inr (Or.inl hwA), hwu⟩ hwv
  rcases hAuv with hAu | hAv
  · exact not_split_aux hA hB hBc hAne hAh hBh hXo hXK hsep hAX hBX hu hv hcov hdis hMv hAu
      (hbd u v hu hv (fun z hz => hcov (hXM hz)) (hXdis hdis))
  · exact not_split_aux hA hB hBc hAne hAh hBh hXo hXK hsep hAX hBX hv hu (by rw [union_comm v u]; exact hcov) hdis' hMu hAv
      ((hbd u v hu hv (fun z hz => hcov (hXM hz)) (hXdis hdis)).symm)

/-- **Janiszewski's theorem for holes** (FS131-IP5): two disjoint nonempty bounded closed continua, neither with a hole, have no hole together.
Were `H` a hole of `A ∪ B` and `R` the rest of the complement, `A` and `B` would each meet both `cl H` and `cl R` (else `H` or `H ∪ A`, or the
symmetric sets, would be a hole of `A` or of `B`); then `cl H ∪ A ∪ B` and `cl R ∪ A ∪ B` are continua (`isPreconnected_closure_union_aux`)
covering `ℂ` and meeting in `A ∪ B`, which is not connected — against unicoherence (`isPreconnected_inter_of_union_eq_univ`). -/
theorem not_isHoleOf_union {A B : Set ℂ} (hA : IsClosed A) (hB : IsClosed B) (hAc : IsPreconnected A) (hBc : IsPreconnected B)
    (hAne : A.Nonempty) (hBne : B.Nonempty) (hAb : Bornology.IsBounded A) (hBb : Bornology.IsBounded B) (hAB : Disjoint A B)
    (hAh : ∀ H, ¬ IsHoleOf A H) (hBh : ∀ H, ¬ IsHoleOf B H) (H : Set ℂ) : ¬ IsHoleOf (A ∪ B) H := by
  intro hH
  have hKc : IsClosed (A ∪ B) := hA.union hB
  have hHo : IsOpen H := hH.isOpen
  have hRo : IsOpen ((A ∪ B)ᶜ \ H) := by have := hH.isOpen_diff; rwa [hKc.closure_eq] at this
  obtain ⟨hHne, hHK, hHb, hHsep⟩ := hH
  rw [hKc.closure_eq] at hHK hHsep
  set R := (A ∪ B)ᶜ \ H with hR
  have hRK : R ⊆ (A ∪ B)ᶜ := sdiff_subset
  have hRH : (A ∪ B)ᶜ \ R = H := by
    ext z; constructor
    · rintro ⟨hzK, hzR⟩; by_contra hzH; exact hzR ⟨hzK, hzH⟩
    · intro hz; exact ⟨hHK hz, fun h => h.2 hz⟩
  have hRsep : Disjoint (closure R) (closure ((A ∪ B)ᶜ \ R)) := by rw [hRH]; exact hHsep.symm
  have hole_of : ∀ {D G : Set ℂ}, IsClosed D → G.Nonempty → Bornology.IsBounded G → G ⊆ Dᶜ →
      Disjoint (closure G) (closure (Dᶜ \ G)) → IsHoleOf D G := fun hD hGne hGb hGD hGsep =>
    ⟨hGne, by rw [hD.closure_eq]; exact hGD, hGb, by rw [hD.closure_eq]; exact hGsep⟩
  -- `A` and `B` each meet `cl H` and `cl R`
  have hAH : (A ∩ closure H).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at h
    refine hBh H (hole_of hB hHne hHb (fun z hz hzB => hHK hz (Or.inr hzB)) ?_)
    refine Disjoint.mono_right (closure_minimal (t := closure R ∪ A) ?_ (isClosed_closure.union hA))
      (Disjoint.union_right hHsep h.symm)
    rintro z ⟨hzB, hzH⟩
    by_cases hzA : z ∈ A
    · exact Or.inr hzA
    · exact Or.inl (subset_closure ⟨fun h => h.elim hzA hzB, hzH⟩)
  have hBH : (B ∩ closure H).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at h
    refine hAh H (hole_of hA hHne hHb (fun z hz hzA => hHK hz (Or.inl hzA)) ?_)
    refine Disjoint.mono_right (closure_minimal (t := closure R ∪ B) ?_ (isClosed_closure.union hB))
      (Disjoint.union_right hHsep h.symm)
    rintro z ⟨hzA, hzH⟩
    by_cases hzB : z ∈ B
    · exact Or.inr hzB
    · exact Or.inl (subset_closure ⟨fun h => h.elim hzA hzB, hzH⟩)
  have hAR : (A ∩ closure R).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at h
    refine hBh (H ∪ A) (hole_of hB (hHne.mono subset_union_left) (hHb.union hAb)
      (fun z hz hzB => hz.elim (fun h => hHK h (Or.inr hzB)) fun h => Set.disjoint_left.mp hAB h hzB) ?_)
    rw [closure_union, hA.closure_eq]
    refine Disjoint.mono_right (closure_mono (s := Bᶜ \ (H ∪ A)) (t := R) ?_) (Disjoint.union_left hHsep h)
    rintro z ⟨hzB, hzHA⟩
    exact ⟨fun h' => h'.elim (fun h => hzHA (Or.inr h)) hzB, fun h => hzHA (Or.inl h)⟩
  have hBR : (B ∩ closure R).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at h
    refine hAh (H ∪ B) (hole_of hA (hHne.mono subset_union_left) (hHb.union hBb)
      (fun z hz hzA => hz.elim (fun h => hHK h (Or.inl hzA)) fun h => Set.disjoint_left.mp hAB hzA h) ?_)
    rw [closure_union, hB.closure_eq]
    refine Disjoint.mono_right (closure_mono (s := Aᶜ \ (H ∪ B)) (t := R) ?_) (Disjoint.union_left hHsep h)
    rintro z ⟨hzA, hzHB⟩
    exact ⟨fun h' => h'.elim hzA (fun h => hzHB (Or.inr h)), fun h => hzHB (Or.inl h)⟩
  -- the two continua
  have hM₁ : IsPreconnected (closure H ∪ (A ∪ B)) :=
    isPreconnected_closure_union_aux hA hB hAc hBc hAne hAh hBh hHo hHK hHsep hAH hBH
      fun u v _ _ _ _ => Or.inl (hHb.subset inter_subset_left)
  have hM₂ : IsPreconnected (closure R ∪ (A ∪ B)) := by
    refine isPreconnected_closure_union_aux hA hB hAc hBc hAne hAh hBh hRo hRK hRsep hAR hBR ?_
    intro u v hu hv hcov hdis
    obtain ⟨ρ, hρ⟩ := ((hAb.union hBb).union hHb).subset_closedBall 0
    have hfarR : (closedBall (0 : ℂ) ρ)ᶜ ⊆ R := fun z hz =>
      ⟨fun h => hz (hρ (Or.inl h)), fun h => hz (hρ (Or.inr h))⟩
    by_cases hu' : ((closedBall (0 : ℂ) ρ)ᶜ ∩ u).Nonempty
    · by_cases hv' : ((closedBall (0 : ℂ) ρ)ᶜ ∩ v).Nonempty
      · exfalso
        obtain ⟨w, hw, hwu, hwv⟩ := isPreconnected_closed_iff.mp (isPreconnected_compl_closedBall 0 ρ) u v hu hv
          (fun z hz => hcov (hfarR hz)) hu' hv'
        exact Set.disjoint_left.mp hdis ⟨hfarR hw, hwu⟩ hwv
      · refine Or.inr (isBounded_closedBall (x := (0 : ℂ)) (r := ρ) |>.subset fun z hz => ?_)
        by_contra hzρ
        exact hv' ⟨z, hzρ, hz.2⟩
    · refine Or.inl (isBounded_closedBall (x := (0 : ℂ)) (r := ρ) |>.subset fun z hz => ?_)
      by_contra hzρ
      exact hu' ⟨z, hzρ, hz.2⟩
  -- unicoherence
  have hcup : (closure H ∪ (A ∪ B)) ∪ (closure R ∪ (A ∪ B)) = univ := by
    refine eq_univ_of_forall fun z => ?_
    by_cases hzK : z ∈ A ∪ B
    · exact Or.inl (Or.inr hzK)
    by_cases hzH : z ∈ H
    · exact Or.inl (Or.inl (subset_closure hzH))
    · exact Or.inr (Or.inl (subset_closure ⟨hzK, hzH⟩))
  have hcap : (closure H ∪ (A ∪ B)) ∩ (closure R ∪ (A ∪ B)) = A ∪ B := by
    ext z; constructor
    · rintro ⟨h1 | h1, h2 | h2⟩
      · exact absurd h2 (Set.disjoint_left.mp hHsep h1)
      · exact h2
      · exact h1
      · exact h1
    · intro hz; exact ⟨Or.inr hz, Or.inr hz⟩
  have hK := isPreconnected_inter_of_union_eq_univ (isClosed_closure.union hKc) (isClosed_closure.union hKc) hM₁ hM₂ hcup
  rw [hcap] at hK
  obtain ⟨a, ha⟩ := hAne
  obtain ⟨b, hb⟩ := hBne
  obtain ⟨w, -, hwA, hwB⟩ := isPreconnected_closed_iff.mp hK A B hA hB subset_rfl ⟨a, Or.inl ha, ha⟩ ⟨b, Or.inr hb, hb⟩
  exact Set.disjoint_left.mp hAB hwA hwB

/-- **The holes of a tile, together, are separated from the rest of the complement** (local finiteness: a point in both closures is in the
closure of a tile meeting one hole, hence inside it — against that hole's separation). -/
theorem disjoint_closure_sUnion_holes (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) :
    Disjoint (closure (⋃₀ {Hc | IsHoleOf X Hc})) (closure ((closure X)ᶜ \ ⋃₀ {Hc | IsHoleOf X Hc})) := by
  rw [Set.disjoint_left]
  intro z hz hz'
  have hHo : IsOpen (⋃₀ {Hc | IsHoleOf X Hc}) := isOpen_sUnion fun Hc hH => IsHoleOf.isOpen hH
  obtain ⟨S, hS, ⟨w, hwS, hwH⟩, hzS⟩ := exists_tile_mem_closure_of_mem_closure hHo (by rw [hP]; exact mem_univ z) hz
  obtain ⟨Hc, hH, hwHc⟩ := hwH
  have hSX : S ≠ X := fun h => hH.2.1 hwHc (subset_closure (h ▸ hwS))
  have hSH : S ⊆ Hc := (hS.subset_or_subset_of_separated hH.2.2.2 fun v hv => by
    by_cases hvH : v ∈ Hc
    · exact Or.inl hvH
    · exact Or.inr ⟨IsTile.subset_compl_closure hX hS hSX hv, hvH⟩).resolve_right fun h => (h hwS).2 hwHc
  exact Set.disjoint_left.mp hH.2.2.2 (closure_mono hSH hzS)
    (closure_mono (sdiff_subset_sdiff_right (subset_sUnion_of_mem hH)) hz')

/-- **A filled tile has no hole** (FS131-IP5): a hole of `cl x̂` would be a hole of `x` (its closure misses that of the union of `x`'s holes,
`disjoint_closure_sUnion_holes`), so inside `x̂`. -/
theorem not_isHoleOf_closure_fill (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) (H : Set ℂ) :
    ¬ IsHoleOf (closure (fill X)) H := by
  rintro ⟨hHne, hHK, hHb, hHsep⟩
  rw [closure_closure] at hHK hHsep
  set Hs := ⋃₀ {Hc | IsHoleOf X Hc} with hHs
  have hfill : closure (fill X) = closure X ∪ closure Hs := closure_union
  have hHHs : H ⊆ (closure X)ᶜ \ Hs := fun z hz =>
    ⟨fun h => hHK hz (closure_mono (subset_fill X) h), fun h => hHK hz (subset_closure (Or.inr h))⟩
  have hhole : IsHoleOf X H := by
    refine ⟨hHne, fun z hz => (hHHs hz).1, hHb, ?_⟩
    have hsub : (closure X)ᶜ \ H ⊆ ((closure (fill X))ᶜ \ H) ∪ closure Hs := by
      rintro z ⟨hzX, hzH⟩
      by_cases hzf : z ∈ closure (fill X)
      · rw [hfill] at hzf; exact Or.inr (hzf.resolve_left hzX)
      · exact Or.inl ⟨hzf, hzH⟩
    have h2 : closure ((closure X)ᶜ \ H) ⊆ closure ((closure (fill X))ᶜ \ H) ∪ closure Hs := by
      have := closure_mono hsub; rwa [closure_union, closure_closure] at this
    exact Disjoint.mono_right h2
      (Disjoint.union_right hHsep ((disjoint_closure_sUnion_holes hP hX).symm.mono_left (closure_mono hHHs)))
  obtain ⟨z, hz⟩ := hHne
  exact hHK hz (subset_closure (Or.inr ⟨H, hhole, hz⟩))

/-- **A filled tile's closure is a continuum**: the tile's closure with the closures of the complementary components inside its holes, each
meeting it on its frontier. -/
theorem isPreconnected_closure_fill {X : Set ℂ} (hX : F.IsTile X) : IsPreconnected (closure (fill X)) := by
  set O := (closure X)ᶜ with hO
  have hOo : IsOpen O := isClosed_closure.isOpen_compl
  obtain ⟨x₀, hx₀⟩ := hX.nonempty
  set c : Set (Set ℂ) :=
    insert (closure X) {s | ∃ z ∈ ⋃₀ {Hc | IsHoleOf X Hc}, s = closure X ∪ closure (connectedComponentIn O z)} with hc
  have hmeet : ∀ z ∈ O, (closure X ∩ closure (connectedComponentIn O z)).Nonempty := by
    intro z hz
    have hfr : (frontier (connectedComponentIn O z)).Nonempty := by
      rw [nonempty_frontier_iff]
      exact ⟨⟨z, mem_connectedComponentIn hz⟩, fun h =>
        connectedComponentIn_subset O z (h ▸ mem_univ x₀ : x₀ ∈ connectedComponentIn O z) (subset_closure hx₀)⟩
    obtain ⟨w, hw⟩ := hfr
    exact ⟨w, by simpa [hO] using frontier_connectedComponentIn_subset hOo z hw, hw.1⟩
  have hcp : IsPreconnected (⋃₀ c) := by
    refine isPreconnected_sUnion x₀ c ?_ ?_
    · rintro s (rfl | ⟨z, -, rfl⟩)
      · exact subset_closure hx₀
      · exact Or.inl (subset_closure hx₀)
    · rintro s (rfl | ⟨z, ⟨Hc, hH, hzH⟩, rfl⟩)
      · exact hX.isPreconnected.closure
      · obtain ⟨w, hw1, hw2⟩ := hmeet z (hH.2.1 hzH)
        exact hX.isPreconnected.closure.union w hw1 hw2 isPreconnected_connectedComponentIn.closure
  refine hcp.subset_closure (sUnion_subset ?_) (closure_mono ?_)
  · rintro s (rfl | ⟨z, ⟨Hc, hH, hzH⟩, rfl⟩)
    · exact closure_mono (subset_fill X)
    · exact union_subset (closure_mono (subset_fill X))
        (closure_mono ((hH.connectedComponentIn_subset hzH).trans fun w hw => Or.inr ⟨Hc, hH, hw⟩))
  · rintro w (hw | ⟨Hc, hH, hwH⟩)
    · exact ⟨closure X, mem_insert _ _, subset_closure hw⟩
    · exact ⟨_, Or.inr ⟨w, ⟨Hc, hH, hwH⟩, rfl⟩, Or.inr (subset_closure (mem_connectedComponentIn (hH.2.1 hwH)))⟩

/-- **Tiles off a closed set without holes are chained** (FS131-IP5; `cvb_pinch_connected`'s argument for any closed bounded `K`): if every
tile meeting `Kᶜ` lies in it and `K` has no hole, a nonempty set `P` of tiles in `Kᶜ`, closed under passing to a tile in `Kᶜ` whose closure
meets a member's, holds every tile in `Kᶜ`. The components of `Kᶜ` holding a tile of `P` are chained inside (`mem_of_touch_closed`) and their
union `Y` is separated from the rest (a common closure point is in the closures of tiles of both, which touch); whichever of the two misses
the unbounded part is a hole of `K`, so empty. -/
theorem mem_of_touch_closed_of_not_isHoleOf (hP : F.IsPlaneMap) {K : Set ℂ} (hK : IsClosed K) (hKb : Bornology.IsBounded K)
    (hno : ∀ H, ¬ IsHoleOf K H) (hin : ∀ S, F.IsTile S → (S ∩ Kᶜ).Nonempty → S ⊆ Kᶜ) (P : Set (Set ℂ))
    (hPt : ∀ S ∈ P, F.IsTile S ∧ S ⊆ Kᶜ) (hne : P.Nonempty)
    (hcl : ∀ S ∈ P, ∀ S', F.IsTile S' → S' ⊆ Kᶜ → (closure S ∩ closure S').Nonempty → S' ∈ P) :
    ∀ S, F.IsTile S → S ⊆ Kᶜ → S ∈ P := by
  set O := Kᶜ with hO
  have hOo : IsOpen O := hK.isOpen_compl
  have hdom : ∀ S : Set ℂ, S ⊆ F.dom := fun S => by rw [hP]; exact subset_univ _
  have hsubC : ∀ S, F.IsTile S → S ⊆ O → ∀ s ∈ S, S ⊆ connectedComponentIn O s := fun S hS hSO s hs =>
    hS.isPreconnected.subset_connectedComponentIn hs hSO
  -- every tile in a component of `O` holding a tile of `P` is in `P`
  have hcomp : ∀ w ∈ O, (∃ S ∈ P, (S ∩ connectedComponentIn O w).Nonempty) →
      ∀ S, F.IsTile S → S ⊆ connectedComponentIn O w → S ∈ P := by
    intro w hw ⟨S₀, hS₀P, hS₀w⟩
    set U := connectedComponentIn O w
    have hUo : IsOpen U := hOo.connectedComponentIn
    have hinU : ∀ S, F.IsTile S → (S ∩ U).Nonempty → S ⊆ U := by
      rintro S hS ⟨z, hzS, hzU⟩
      have hSO := hin S hS ⟨z, hzS, connectedComponentIn_subset _ _ hzU⟩
      rw [show U = connectedComponentIn O z from connectedComponentIn_eq hzU]
      exact hsubC S hS hSO z hzS
    have key := mem_of_touch_closed hUo isPreconnected_connectedComponentIn (hdom _) hinU {S | S ∈ P ∧ S ⊆ U}
      (fun S hS => ⟨(hPt S hS.1).1, hS.2⟩) ⟨S₀, hS₀P, hinU S₀ (hPt S₀ hS₀P).1 hS₀w⟩ (by
        rintro S ⟨hSP, hSU⟩ S' hS' hS'U hcl'
        exact ⟨hcl S hSP S' hS' (hS'U.trans (connectedComponentIn_subset _ _)) hcl', hS'U⟩)
    intro S hS hSU
    exact (key S hS hSU).1
  set Y := {z | z ∈ O ∧ ∃ S ∈ P, (S ∩ connectedComponentIn O z).Nonempty} with hYdef
  set Hc := O \ Y with hHcdef
  have hYsat : ∀ z ∈ O, ∀ w ∈ connectedComponentIn O z, (w ∈ Y ↔ z ∈ Y) := by
    intro z hz w hw
    rw [hYdef, mem_setOf_eq, mem_setOf_eq, ← connectedComponentIn_eq hw]
    exact ⟨fun h => ⟨hz, h.2⟩, fun h => ⟨connectedComponentIn_subset _ _ hw, h.2⟩⟩
  have hYo : IsOpen Y := by
    rw [isOpen_iff_forall_mem_open]
    intro z hz
    exact ⟨connectedComponentIn O z, fun w hw => (hYsat z hz.1 w hw).mpr hz, hOo.connectedComponentIn,
      mem_connectedComponentIn hz.1⟩
  have hHo : IsOpen Hc := by
    rw [isOpen_iff_forall_mem_open]
    intro z hz
    exact ⟨connectedComponentIn O z, fun w hw => ⟨connectedComponentIn_subset _ _ hw,
      fun hwY => hz.2 ((hYsat z hz.1 w hw).mp hwY)⟩, hOo.connectedComponentIn, mem_connectedComponentIn hz.1⟩
  have hYP : ∀ S, F.IsTile S → (S ∩ Y).Nonempty → S ∈ P := by
    rintro S hS ⟨z, hzS, hzY⟩
    exact hcomp z hzY.1 hzY.2 S hS (hsubC S hS (hin S hS ⟨z, hzS, hzY.1⟩) z hzS)
  have hsep : Disjoint (closure Hc) (closure Y) := by
    rw [Set.disjoint_left]
    intro z hzH hzY
    obtain ⟨X, hX, ⟨x', hx'X, hx'H⟩, hzX⟩ := exists_tile_mem_closure_of_mem_closure hHo (hdom _ (mem_univ z)) hzH
    obtain ⟨W, hW, ⟨w, hwW, hwY⟩, hzW⟩ := exists_tile_mem_closure_of_mem_closure hYo (hdom _ (mem_univ z)) hzY
    have hWP := hYP W hW ⟨w, hwW, hwY⟩
    have hXO : X ⊆ O := hin X hX ⟨x', hx'X, hx'H.1⟩
    have hXP : X ∈ P := hcl W hWP X hX hXO ⟨z, hzW, hzX⟩
    exact hx'H.2 ⟨hx'H.1, X, hXP, x', hx'X, mem_connectedComponentIn hx'H.1⟩
  have hYH : O \ Hc = Y := by
    ext z; constructor
    · rintro ⟨hzO, hzH⟩; by_contra hzY; exact hzH ⟨hzO, hzY⟩
    · intro hz; exact ⟨hz.1, fun h => h.2 hz⟩
  -- the far part lies in `Y` or in `Hc`; the other is a hole of `K`
  obtain ⟨ρ, hρ⟩ := hKb.subset_closedBall 0
  have hfarO : (closedBall (0 : ℂ) ρ)ᶜ ⊆ O := fun z hz h => hz (hρ h)
  have hcov : (closedBall (0 : ℂ) ρ)ᶜ ⊆ Y ∪ Hc := fun z hz => by
    by_cases hzY : z ∈ Y
    · exact Or.inl hzY
    · exact Or.inr ⟨hfarO hz, hzY⟩
  have hYHd : Disjoint Y Hc := Set.disjoint_left.mpr fun z hzY hzH => hzH.2 hzY
  obtain ⟨S₀, hS₀P⟩ := hne
  obtain ⟨s₀, hs₀⟩ := (hPt S₀ hS₀P).1.nonempty
  have hs₀Y : s₀ ∈ Y := ⟨(hPt S₀ hS₀P).2 hs₀, S₀, hS₀P, s₀, hs₀, mem_connectedComponentIn ((hPt S₀ hS₀P).2 hs₀)⟩
  have hHc : Hc = ∅ := by
    rcases (isPreconnected_compl_closedBall (0 : ℂ) ρ).subset_or_subset hYo hHo hYHd hcov with hfY | hfH
    · by_contra hne'
      refine hno Hc ⟨nonempty_iff_ne_empty.mpr hne', by rw [hK.closure_eq]; exact sdiff_subset,
        (isBounded_closedBall (x := (0 : ℂ)) (r := ρ)).subset fun z hz => ?_, by rw [hK.closure_eq, hYH]; exact hsep⟩
      by_contra hzρ
      exact hz.2 (hfY hzρ)
    · exfalso
      refine hno Y ⟨⟨s₀, hs₀Y⟩, by rw [hK.closure_eq]; exact fun z hz => hz.1,
        (isBounded_closedBall (x := (0 : ℂ)) (r := ρ)).subset fun z hz => ?_, by rw [hK.closure_eq]; exact hsep.symm⟩
      by_contra hzρ
      exact (hfH hzρ).2 hz
  intro S hS hSO
  obtain ⟨z, hz⟩ := hS.nonempty
  have hzY : z ∈ Y := by
    by_contra hzY
    have : z ∈ Hc := ⟨hSO hz, hzY⟩
    rw [hHc] at this
    exact this
  exact hYP S hS ⟨z, hz, hzY⟩

/-- Filled closures of tiles are bounded. -/
theorem isBounded_closure_fill (hF : F.Valid) {X : Set ℂ} (hX : F.IsTile X) : Bornology.IsBounded (closure (fill X)) := by
  obtain ⟨w, hw⟩ := hX.nonempty
  exact isBounded_closedBall.subset (closure_fill_subset_closedBall hF hX (subset_closure hw))

/-- **Two outer tiles with disjoint filled closures separate nothing** (FS131-IP5; F-RING's clause for a vertex absent from the ring, and
F-SEP's): `M̂ − x − y` is connected. `cl x̂ ∪ cl ŷ` has no hole (`not_isHoleOf_union` over `not_isHoleOf_closure_fill`), so the tiles off it
are chained (`mem_of_touch_closed_of_not_isHoleOf`), each in the fill of an outer tile other than `x`, `y`. -/
theorem filledGraph_offTwo_connected (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T})
    (hd : Disjoint (closure (fill x.1)) (closure (fill y.1))) : (F.filledGraph.induce (Thomassen.offTwo x y)).Connected := by
  set G' := F.filledGraph.induce (Thomassen.offTwo x y) with hG'
  set K := closure (fill x.1) ∪ closure (fill y.1) with hK
  have nonemp : ∀ X : Set ℂ, F.IsTile X → (closure (fill X)).Nonempty := fun X hX =>
    hX.nonempty.mono fun z hz => subset_closure (subset_fill X hz)
  have hno : ∀ H, ¬ IsHoleOf K H := not_isHoleOf_union isClosed_closure isClosed_closure (isPreconnected_closure_fill x.2.1)
    (isPreconnected_closure_fill y.2.1) (nonemp _ x.2.1) (nonemp _ y.2.1) (isBounded_closure_fill hF x.2.1)
    (isBounded_closure_fill hF y.2.1) hd (not_isHoleOf_closure_fill hP x.2.1) (not_isHoleOf_closure_fill hP y.2.1)
  haveI : Nonempty (Thomassen.offTwo x y) := (offTwo_infinite hF hP x y).nonempty.to_subtype
  refine ⟨fun v w => ?_⟩
  set P : Set (Set ℂ) := {S | F.IsTile S ∧ S ⊆ Kᶜ ∧ ∃ (T : Set ℂ) (hT : F.IsOuterTile T)
    (hTo : (⟨T, hT⟩ : {T : Set ℂ // F.IsOuterTile T}) ∈ Thomassen.offTwo x y), S ⊆ fill T ∧ G'.Reachable v ⟨⟨T, hT⟩, hTo⟩} with hPdef
  have key := mem_of_touch_closed_of_not_isHoleOf hP (isClosed_closure.union isClosed_closure)
    ((isBounded_closure_fill hF x.2.1).union (isBounded_closure_fill hF y.2.1)) hno
    (fun S hS h => subset_compl_of_inter_compl x.2.1 y.2.1 hS h) P (fun S hS => ⟨hS.1, hS.2.1⟩)
    ⟨v.1.1, v.1.2.1, subset_compl_of_mem_offTwo v.1 v.2, v.1.1, v.1.2, v.2, subset_fill _, SimpleGraph.Reachable.refl _⟩ (by
      rintro S ⟨hS, hSK, T, hT, hTo, hST, hreach⟩ S' hS' hS'K ⟨z, hzS, hzS'⟩
      obtain ⟨T', hT', hT'o, hS'T'⟩ := exists_outer_fill_offTwo hF hP x y hS' hS'K
      exact ⟨hS', hS'K, T', hT', hT'o, hS'T', hreach.trans (reachable_offTwo_of_inter (a := ⟨⟨T, hT⟩, hTo⟩)
        (b := ⟨⟨T', hT'⟩, hT'o⟩) ⟨z, closure_mono hST hzS, closure_mono hS'T' hzS'⟩)⟩)
  obtain ⟨-, -, T, hT, hTo, hwT, hreach⟩ := key w.1.1 w.1.2.1 (subset_compl_of_mem_offTwo w.1 w.2)
  obtain ⟨s, hs⟩ := w.1.2.1.nonempty
  exact hreach.trans (reachable_offTwo_of_inter (a := ⟨⟨T, hT⟩, hTo⟩) (b := w)
    ⟨s, subset_closure (hwT hs), subset_closure (subset_fill _ hs)⟩)

/-! ### F-RING reduced to the boundary walk (FS131-IP5): each entry repeated four times, and the non-neighbour clause -/

/-- Repeating each entry four times: the `i`-th entry is the original's `(i / 4)`-th. -/
theorem getElem?_flatMap_replicate_four {α : Type*} : ∀ (l : List α) (i : ℕ),
    (l.flatMap (List.replicate 4))[i]? = l[i / 4]?
  | [], i => by simp
  | a :: l, i => by
    rw [List.flatMap_cons]
    by_cases hi : i < 4
    · rw [List.getElem?_append_left (by simpa using hi), List.getElem?_replicate, if_pos hi,
        show i / 4 = 0 by omega]
      rfl
    · rw [List.getElem?_append_right (by simp; omega), List.length_replicate, getElem?_flatMap_replicate_four l (i - 4),
        show i / 4 = (i - 4) / 4 + 1 by omega]
      rfl

theorem length_flatMap_replicate_four {α : Type*} (l : List α) : (l.flatMap (List.replicate 4)).length = 4 * l.length := by
  induction l with
  | nil => rfl
  | cons a l ih => rw [List.flatMap_cons, List.length_append, ih, List.length_replicate, List.length_cons]; omega

/-- **A ring with each entry repeated four times is a ring**, in which every entry appears twice apart — so the ring field's "connected unless
twice apart" clause is free for neighbours (FS131-IP5). -/
theorem isRing_flatMap_replicate_four {V : Type*} {G : SimpleGraph V} {x : V} {r : List V} (h : Thomassen.IsRing G x r) :
    Thomassen.IsRing G x (r.flatMap (List.replicate 4)) := by
  obtain ⟨hmem, hcons, hsep⟩ := h
  have hlen := length_flatMap_replicate_four r
  refine ⟨fun y => ?_, fun i a b ha hb => ?_, fun y i j hij hi hj m n a b him hmj hn ha hb hao hbo => ?_⟩
  · rw [List.mem_flatMap, ← hmem y]
    simp only [List.mem_replicate, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, true_and]
    exact ⟨fun ⟨a, ha, h⟩ => h ▸ ha, fun h => ⟨y, h, rfl⟩⟩
  · rw [getElem?_flatMap_replicate_four] at ha hb
    rw [hlen] at hb
    have hi : i / 4 < r.length := by
      by_contra h'; rw [List.getElem?_eq_none (by omega)] at ha; exact absurd ha (by simp)
    rw [Nat.mod_mul_right_div_self] at hb
    by_cases h4 : (i + 1) % 4 = 0
    · rw [show (i + 1) / 4 = i / 4 + 1 by omega] at hb
      exact hcons (i / 4) a b ha hb
    · rw [show (i + 1) / 4 = i / 4 by omega, Nat.mod_eq_of_lt hi] at hb
      rw [ha] at hb
      exact Or.inl (Option.some_injective _ hb)
  · rw [getElem?_flatMap_replicate_four] at hi hj ha hb
    have hay : a ≠ y := hao.2
    have hby : b ≠ y := hbo.2
    have hmI : m / 4 ≠ i / 4 := fun h => hay (Option.some_injective _ (by rw [← ha, ← hi, h]))
    have hmJ : m / 4 ≠ j / 4 := fun h => hay (Option.some_injective _ (by rw [← ha, ← hj, h]))
    have hnI : n / 4 ≠ i / 4 := fun h => hby (Option.some_injective _ (by rw [← hb, ← hi, h]))
    have hnJ : n / 4 ≠ j / 4 := fun h => hby (Option.some_injective _ (by rw [← hb, ← hj, h]))
    have h1 : i / 4 ≤ m / 4 := Nat.div_le_div_right him.le
    have h2 : m / 4 ≤ j / 4 := Nat.div_le_div_right hmj.le
    refine hsep y (i / 4) (j / 4) (by omega) hi hj (m / 4) (n / 4) a b (by omega) (by omega) ?_ ha hb hao hbo
    rcases hn with hn | hn
    · exact Or.inl (lt_of_le_of_ne (Nat.div_le_div_right hn.le) hnI)
    · exact Or.inr (lt_of_le_of_ne (Nat.div_le_div_right hn.le) (Ne.symm hnJ))

/-- Every entry of a list repeated four times appears twice apart. -/
theorem twiceApart_flatMap_replicate_four {V : Type*} {r : List V} {y : V} (hy : y ∈ r) :
    Thomassen.TwiceApart (r.flatMap (List.replicate 4)) y := by
  obtain ⟨k, hk, rfl⟩ := List.getElem_of_mem hy
  refine ⟨4 * k, 4 * k + 2, by omega, ?_, ?_, ?_⟩
  · rw [length_flatMap_replicate_four]; omega
  · rw [getElem?_flatMap_replicate_four, show 4 * k / 4 = k by omega, List.getElem?_eq_getElem hk]
  · rw [getElem?_flatMap_replicate_four, show (4 * k + 2) / 4 = k by omega, List.getElem?_eq_getElem hk]

/-! ### The boundary walk (FS131-RL1's skeleton; plan `plans/FS131-ringlist-kernel-plan.md`)

The ring at `x` is read off a **boundary walk** (`IsBoundaryWalk`): a cyclic list of `x`'s neighbours, each joined to the next by a
*hinge* (a point in both closures), in which a tile listed twice is listed only at **edges** (`IsEdgeOf`) — closed arcs of `cl x ∩ cl y`
with a *pure point*, near which only `x`, `y` and the edge are present. The walk is built from the finite boundary graph of `∂ cl x̂`
(`exists_boundaryWalk`); its repeated tiles separate by the crossing lemma outside a small disc at a pure point
(`IsBoundaryWalk.sep`, over `inter_nonempty_of_interleaved_exterior`). -/

/-- **`E` is an edge of `x` with `y` from `u` to `w`, with pure point `p` at radius `ρ`** (FS131-RL1): `E` is closed, preconnected, in
`cl x ∩ cl y` and off `x ∪ y`, holds `u`, `w`, `p`; the open disc `B(p, ρ)` holds only `x`, `y` and `E`, meets its circle in a nonempty
connected arc of `x` and one of `y`; and `E` off the disc is two closed connected pieces, one holding `u`, the other `w`, whose circle points
`r(θ₁)`, `r(θ₃)` interleave with two circle points `r(θ₂)`, `r(θ₄)` of `x ∪ y`. On a map: a maximal arc of `∂ cl x̂` with `x` on one
side and the tile `y` on the other, `p` any point of it off the boundary graph's vertices. -/
def IsEdgeOf (x y E : Set ℂ) (u w p : ℂ) (ρ : ℝ) : Prop :=
  IsClosed E ∧ IsPreconnected E ∧ E ⊆ closure x ∩ closure y ∧ Disjoint E (x ∪ y) ∧ u ∈ E ∧ w ∈ E ∧ p ∈ E ∧ 0 < ρ ∧
    ball p ρ ⊆ x ∪ y ∪ E ∧ IsPreconnected (x ∩ sphere p ρ) ∧ (x ∩ sphere p ρ).Nonempty ∧ IsPreconnected (y ∩ sphere p ρ) ∧
    (y ∩ sphere p ρ).Nonempty ∧
    ∃ E₁ E₂ : Set ℂ, E \ ball p ρ = E₁ ∪ E₂ ∧ IsClosed E₁ ∧ IsPreconnected E₁ ∧ IsClosed E₂ ∧ IsPreconnected E₂ ∧ u ∈ E₁ ∧
      w ∈ E₂ ∧ ∃ θ₁ θ₂ θ₃ θ₄ : ℝ, θ₁ < θ₂ ∧ θ₂ < θ₃ ∧ θ₃ < θ₄ ∧ θ₄ < θ₁ + 2 * π ∧ polarPt p ρ θ₁ ∈ E₁ ∧
        polarPt p ρ θ₂ ∈ x ∪ y ∧ polarPt p ρ θ₃ ∈ E₂ ∧ polarPt p ρ θ₄ ∈ x ∪ y

/-- A spec example for `IsEdgeOf`: no edge has a pure point at radius `0` (the disc must be honest). -/
example (x y E : Set ℂ) (u w p : ℂ) : ¬ IsEdgeOf x y E u w p 0 := fun h => lt_irrefl _ h.2.2.2.2.2.2.2.1

/-- **A boundary walk at the outer tile `x`** (FS131-RL1): a list `r` of outer tiles (read cyclically) with hinges `z k`, edges `E k`, pure
points `p k` at radii `ρ k`, and the entries `edge k` that are edge entries, such that: the entries are exactly `x`'s neighbours in `M̂`;
the hinge after entry `k` lies in the closures of entry `k` and entry `k + 1`; an edge entry's edge is an edge of `x` with its tile from
the previous hinge to its own; a tile listed at two positions is an edge entry at both; and the closed disc at an edge entry's pure point
misses every other edge entry's edge. Inhabitant: `exists_boundaryWalk` supplies one at every outer tile of every valid plane map
(`sevenBrickMap` among them); the theorems reading this structure (`IsBoundaryWalk.cons`, `.sep`, `.isRing`) take that as their model. -/
structure IsBoundaryWalk (F : ArcMap k) (x : {T : Set ℂ // F.IsOuterTile T}) (r : List {T : Set ℂ // F.IsOuterTile T}) (z : ℕ → ℂ)
    (E : ℕ → Set ℂ) (p : ℕ → ℂ) (ρ : ℕ → ℝ) (edge : ℕ → Prop) : Prop where
  /-- The entries are exactly `x`'s neighbours. -/
  mem : ∀ y, y ∈ r ↔ F.filledGraph.Adj x y
  /-- The hinge after each entry lies in its closure and the next entry's. -/
  hinge : ∀ (j : ℕ) (a b : {T : Set ℂ // F.IsOuterTile T}), r[j]? = some a → r[(j + 1) % r.length]? = some b →
    z j ∈ closure a.1 ∩ closure b.1
  /-- An edge entry's edge runs from the previous hinge to its own. -/
  edgeOf : ∀ (j : ℕ) (a : {T : Set ℂ // F.IsOuterTile T}), r[j]? = some a → edge j →
    IsEdgeOf x.1 a.1 (E j) (z ((j + r.length - 1) % r.length)) (z j) (p j) (ρ j)
  /-- A tile listed twice is listed only at edges. -/
  rep : ∀ (i j : ℕ) (a : {T : Set ℂ // F.IsOuterTile T}), i ≠ j → r[i]? = some a → r[j]? = some a → edge i ∧ edge j
  /-- The closed disc at an edge entry's pure point misses every other edge entry's edge. -/
  apart : ∀ j, j < r.length → edge j → ∀ i, i < r.length → i ≠ j → edge i → Disjoint (E i) (closedBall (p j) (ρ j))

/-- **Two outer tiles are adjacent in `M̂` exactly when their own closures meet** (FS131-RL1, child **ADJ**): a common point of the filled
closures lies on no hole's inside (a hole of one meets neither the other tile nor its holes), so on both tiles' closures. -/
theorem filledGraph_adj_iff (hP : F.IsPlaneMap) {x y : {T : Set ℂ // F.IsOuterTile T}} :
    F.filledGraph.Adj x y ↔ x ≠ y ∧ (closure x.1 ∩ closure y.1).Nonempty := by
  refine ⟨fun ⟨hne, z, hzx, hzy⟩ => ⟨hne, ?_⟩, fun ⟨hne, z, hzx, hzy⟩ =>
    ⟨hne, z, closure_mono (subset_fill _) hzx, closure_mono (subset_fill _) hzy⟩⟩
  have hne' : y.1 ≠ x.1 := fun h => hne (Subtype.ext h).symm
  set Hx := ⋃₀ {Hc | IsHoleOf x.1 Hc} with hHx
  set Hy := ⋃₀ {Hc | IsHoleOf y.1 Hc} with hHy
  -- each tile lies off the other's filled closure, so off the other's holes, and its closure misses theirs
  have hsepx := disjoint_closure_sUnion_holes hP x.2.1
  have hsepy := disjoint_closure_sUnion_holes hP y.2.1
  have hyR : y.1 ⊆ (closure x.1)ᶜ \ Hx := fun w hw =>
    have h := Set.disjoint_left.mp (IsOuterTile.disjoint_closure_fill x.2.1 y.2 hne') hw
    ⟨fun h' => h (closure_mono (subset_fill _) h'), fun h' => h (subset_closure (Or.inr h'))⟩
  have hxR : x.1 ⊆ (closure y.1)ᶜ \ Hy := fun w hw =>
    have h := Set.disjoint_left.mp (IsOuterTile.disjoint_closure_fill y.2.1 x.2 (fun h => hne (Subtype.ext h))) hw
    ⟨fun h' => h (closure_mono (subset_fill _) h'), fun h' => h (subset_closure (Or.inr h'))⟩
  have hyHx : Disjoint (closure y.1) (closure Hx) := hsepx.symm.mono_left (closure_mono hyR)
  have hxHy : Disjoint (closure x.1) (closure Hy) := hsepy.symm.mono_left (closure_mono hxR)
  have hfx : closure (fill x.1) = closure x.1 ∪ closure Hx := closure_union
  have hfy : closure (fill y.1) = closure y.1 ∪ closure Hy := closure_union
  rw [hfx] at hzx
  rw [hfy] at hzy
  rcases hzx with hzx | hzx <;> rcases hzy with hzy | hzy
  · exact ⟨z, hzx, hzy⟩
  · exact absurd hzy (Set.disjoint_left.mp hxHy hzx)
  · exact absurd hzx (Set.disjoint_left.mp hyHx hzy)
  -- `z` lies in a hole of both: the component `D` of `(cl x)ᶜ` at `z` lies in `x`'s holes, so off `cl y`, so in `y`'s holes; its
  -- frontier lies in `cl x` and in `cl Hy`, which miss — so `D` is clopen, hence the plane, against `x ∩ D = ∅`
  have hzx' : z ∉ closure x.1 := fun h => Set.disjoint_left.mp hxHy h hzy
  have hzHx : z ∈ Hx := by
    by_contra h
    exact Set.disjoint_left.mp hsepx hzx (subset_closure ⟨hzx', h⟩)
  obtain ⟨Hc, hHc, hzHc⟩ := hzHx
  set D := connectedComponentIn (closure x.1)ᶜ z with hD
  have hDHx : D ⊆ Hx := (hHc.connectedComponentIn_subset hzHc).trans (subset_sUnion_of_mem hHc)
  have hDy : D ⊆ (closure y.1)ᶜ := fun w hw hwy => Set.disjoint_left.mp hyHx hwy (subset_closure (hDHx hw))
  have hzy' : z ∉ closure y.1 := hDy (mem_connectedComponentIn hzx')
  have hzHy : z ∈ Hy := by
    by_contra h
    exact Set.disjoint_left.mp hsepy hzy (subset_closure ⟨hzy', h⟩)
  obtain ⟨Hc', hHc', hzHc'⟩ := hzHy
  have hDHy : D ⊆ Hy := (isPreconnected_connectedComponentIn.subset_connectedComponentIn
    (mem_connectedComponentIn hzx') hDy |>.trans (hHc'.connectedComponentIn_subset hzHc')).trans (subset_sUnion_of_mem hHc')
  have hfr : frontier D = ∅ := by
    rw [eq_empty_iff_forall_notMem]
    intro w hw
    have h1 : w ∈ closure x.1 := by
      simpa using frontier_connectedComponentIn_subset isClosed_closure.isOpen_compl z hw
    exact Set.disjoint_left.mp hxHy h1 (closure_mono hDHy hw.1)
  have hDo : IsOpen D := isClosed_closure.isOpen_compl.connectedComponentIn
  have hDc : IsClosed D := by
    rw [← closure_subset_iff_isClosed]
    intro w hw
    by_contra hwD
    have : w ∈ frontier D := ⟨hw, by rwa [hDo.interior_eq]⟩
    rw [hfr] at this
    exact this
  rcases isClopen_iff.mp ⟨hDc, hDo⟩ with h | h
  · exact absurd (h ▸ mem_connectedComponentIn hzx' : z ∈ (∅ : Set ℂ)) (notMem_empty z)
  · obtain ⟨w, hw⟩ := x.2.1.nonempty
    exact absurd (subset_closure hw) (connectedComponentIn_subset _ _ (h ▸ mem_univ w : w ∈ D))

/-- **Clause 2 of the ring from the hinges** (FS131-RL1, child **CONS**): consecutive entries of a boundary walk are equal or adjacent —
their closures share the hinge, and a tile's closure lies in its filled closure. -/
theorem IsBoundaryWalk.cons {x : {T : Set ℂ // F.IsOuterTile T}} {r : List {T : Set ℂ // F.IsOuterTile T}} {z : ℕ → ℂ}
    {E : ℕ → Set ℂ} {p : ℕ → ℂ} {ρ : ℕ → ℝ} {edge : ℕ → Prop} (h : F.IsBoundaryWalk x r z E p ρ edge) (i : ℕ)
    (a b : {T : Set ℂ // F.IsOuterTile T}) (ha : r[i]? = some a) (hb : r[(i + 1) % r.length]? = some b) :
    a = b ∨ F.filledGraph.Adj a b := by
  by_cases hab : a = b
  · exact Or.inl hab
  · obtain ⟨h1, h2⟩ := h.hinge i a b ha hb
    exact Or.inr ⟨hab, z i, closure_mono (subset_fill _) h1, closure_mono (subset_fill _) h2⟩

/-- **Clause 3 of the ring: a repeated tile separates** (FS131-RL1, child **SEP**). Say `y` is listed at `i < j`, `a` strictly between and
`b` strictly outside, joined in `M̂ − x − y` by a chain whose filled closures make a continuum `S` off `x ∪ y`. Both positions are edge
entries (`rep`). In the cyclic arcs between consecutive appearances of `y`, let `a` sit after the appearance `s` and `b` after `t ≠ s`.
At the pure point `p s` of the edge `E s`: `K₂` = the piece of `E s` from its circle point to its far hinge, the entries from there to `a`,
`S`, the entries from `b` onward to the near hinge of `E s` (crossing later appearances of `y` along their edges, never their tile), and
the other piece of `E s` — closed, bounded, connected, off `x`, `y`, the disc and the pure point `p t`; `K₁` = `x` and `y` off the disc
with `p t` (connected: `isPreconnected_diff_ball`). They join interleaved circle points and are disjoint, against
`inter_nonempty_of_interleaved_exterior`. -/
theorem IsBoundaryWalk.sep {x : {T : Set ℂ // F.IsOuterTile T}} {r : List {T : Set ℂ // F.IsOuterTile T}} {z : ℕ → ℂ}
    {E : ℕ → Set ℂ} {p : ℕ → ℂ} {ρ : ℕ → ℝ} {edge : ℕ → Prop} (h : F.IsBoundaryWalk x r z E p ρ edge) :
    ∀ (y : {T : Set ℂ // F.IsOuterTile T}) (i j : ℕ), i < j → r[i]? = some y → r[j]? = some y → ∀ (m n : ℕ) (a b : _), i < m → m < j →
      (n < i ∨ j < n) → r[m]? = some a → r[n]? = some b → ∀ (ha : a ∈ Thomassen.offTwo x y) (hb : b ∈ Thomassen.offTwo x y),
        ¬ (F.filledGraph.induce (Thomassen.offTwo x y)).Reachable ⟨a, ha⟩ ⟨b, hb⟩ := by
  sorry

/-- **A boundary walk is a ring** (FS131-RL1): clause 1 is `mem`, clause 2 `IsBoundaryWalk.cons`, clause 3 `IsBoundaryWalk.sep`. -/
theorem IsBoundaryWalk.isRing {x : {T : Set ℂ // F.IsOuterTile T}} {r : List {T : Set ℂ // F.IsOuterTile T}} {z : ℕ → ℂ}
    {E : ℕ → Set ℂ} {p : ℕ → ℂ} {ρ : ℕ → ℝ} {edge : ℕ → Prop} (h : F.IsBoundaryWalk x r z E p ρ edge) :
    Thomassen.IsRing F.filledGraph x r :=
  ⟨h.mem, h.cons, h.sep⟩

/-! ### WALK's C6/C8, pure (FS131-RW1): an Euler circuit of the port structure -/

section Euler

variable {α β : Type*}


/-- A closed trail based at `v`: consecutive entries chain (`en a = st b`), the first starts and the last ends at `v`. -/
def BasedTrail (st en : α → β) (v : β) (L : List α) : Prop :=
  ∃ h : L ≠ [], L.IsChain (fun a b => en a = st b) ∧ st (L.head h) = v ∧ en (L.getLast h) = v

/-- Two closed trails based at one point concatenate. -/
theorem BasedTrail.append {st en : α → β} {v : β} {A B : List α} (hA : BasedTrail st en v A) (hB : BasedTrail st en v B) :
    BasedTrail st en v (A ++ B) := by
  obtain ⟨hA0, hAc, hAh, hAl⟩ := hA
  obtain ⟨hB0, hBc, hBh, hBl⟩ := hB
  refine ⟨by simp [hA0], hAc.append hBc ?_, ?_, ?_⟩
  · intro x hx y hy
    rw [List.getLast?_eq_some_getLast hA0, Option.mem_def, Option.some_inj] at hx
    rw [List.head?_eq_some_head hB0, Option.mem_def, Option.some_inj] at hy
    rw [← hx, ← hy, hAl, hBh]
  · rw [List.head_append_of_ne_nil hA0]; exact hAh
  · rw [List.getLast_append_of_ne_nil _ hB0]; exact hBl

/-- Each entry's end is some entry's start. -/
theorem BasedTrail.exists_start {st en : α → β} {v : β} {L : List α} (hL : BasedTrail st en v L) {e : α} (he : e ∈ L) :
    ∃ e' ∈ L, st e' = en e := by
  obtain ⟨hL0, hLc, hLh, hLl⟩ := hL
  obtain ⟨A, B, rfl⟩ := List.append_of_mem he
  rcases B with _ | ⟨b, B⟩
  · refine ⟨(A ++ [e]).head hL0, List.head_mem _, ?_⟩
    rw [hLh, ← hLl, List.getLast_append_of_ne_nil _ (by simp)]; rfl
  · refine ⟨b, by simp, ?_⟩
    have h := (List.isChain_append.mp hLc).2.1
    exact ((List.isChain_cons_cons.mp h).1).symm

/-- **Insertion**: a closed trail based at the start of one of a trail's entries goes in before that entry. -/
theorem BasedTrail.insert {st en : α → β} {v : β} {L : List α} (hL : BasedTrail st en v L) {e : α} (he : e ∈ L) {O : List α}
    (hO : BasedTrail st en (st e) O) :
    ∃ L', BasedTrail st en v L' ∧ (∀ a, a ∈ L' ↔ a ∈ L ∨ a ∈ O) ∧ (L.Nodup → O.Nodup → (∀ a ∈ O, a ∉ L) → L'.Nodup) := by
  obtain ⟨hL0, hLc, hLh, hLl⟩ := hL
  obtain ⟨hO0, hOc, hOh, hOl⟩ := hO
  obtain ⟨A, B, rfl⟩ := List.append_of_mem he
  have hAeB := List.isChain_append.mp hLc
  have heB : (e :: B).IsChain (fun a b => en a = st b) := hAeB.2.1
  have hOeB : (O ++ e :: B).IsChain (fun a b => en a = st b) := by
    refine hOc.append heB fun x hx y hy => ?_
    rw [List.getLast?_eq_some_getLast hO0, Option.mem_def, Option.some_inj] at hx
    simp only [List.head?_cons, Option.mem_def, Option.some_inj] at hy
    rw [← hx, ← hy, hOl]
  refine ⟨A ++ (O ++ e :: B), ⟨by simp, hAeB.1.append hOeB fun x hx y hy => ?_, ?_, ?_⟩, fun a => ?_, fun hn hOn hdis => ?_⟩
  · rw [List.head?_append_of_ne_nil _ hO0, List.head?_eq_some_head hO0, Option.mem_def, Option.some_inj] at hy
    rw [← hy, hOh]
    exact hAeB.2.2 x hx e (by simp)
  · rcases A with _ | ⟨a, A⟩
    · simp only [List.nil_append] at hLh ⊢
      rw [List.head_append_of_ne_nil hO0, hOh]; exact hLh
    · simpa using hLh
  · rw [List.getLast_append_of_ne_nil _ (by simp), List.getLast_append_of_ne_nil _ (by simp)]
    rw [List.getLast_append_of_ne_nil _ (by simp)] at hLl; exact hLl
  · simp only [List.mem_append, List.mem_cons]; tauto
  · rw [List.nodup_append] at hn ⊢
    obtain ⟨hA, heB', hAd⟩ := hn
    refine ⟨hA, List.nodup_append.mpr ⟨hOn, heB', fun x hx y hy => ?_⟩, fun x hx y hy => ?_⟩
    · rintro rfl; exact hdis x hx (List.mem_append_right _ hy)
    · rw [List.mem_append] at hy
      rcases hy with hy | hy
      · rintro rfl; exact hdis x hy (List.mem_append_left _ hx)
      · exact hAd x hx y hy


/-- **A vertex-preserving pairing exists when every vertex has evenly many ports**. -/
theorem exists_vertex_involution [DecidableEq α] [DecidableEq β] (vtx : α → β) :
    ∀ s : Finset α, (∀ b, Even (s.filter fun a => vtx a = b).card) →
      ∃ f : α → α, ∀ a ∈ s, f a ∈ s ∧ f (f a) = a ∧ f a ≠ a ∧ vtx (f a) = vtx a := by
  intro s
  induction s using Finset.strongInduction with
  | H s ih =>
  intro hev
  rcases s.eq_empty_or_nonempty with rfl | ⟨a, ha⟩
  · exact ⟨id, fun a h => absurd h (Finset.notMem_empty a)⟩
  have hfa : a ∈ s.filter fun x => vtx x = vtx a := Finset.mem_filter.mpr ⟨ha, rfl⟩
  obtain ⟨a', ha', haa'⟩ : ∃ a' ∈ s.filter (fun x => vtx x = vtx a), a' ≠ a := by
    by_contra h
    push Not at h
    have : (s.filter fun x => vtx x = vtx a) = {a} := Finset.eq_singleton_iff_unique_mem.mpr ⟨hfa, h⟩
    have h1 := hev (vtx a)
    rw [this, Finset.card_singleton] at h1
    exact Nat.not_even_one h1
  obtain ⟨ha's, hva'⟩ := Finset.mem_filter.mp ha'
  set s' := (s.erase a).erase a' with hs'
  have hs's : s' ⊂ s := (Finset.erase_ssubset (Finset.mem_erase.mpr ⟨haa', ha's⟩)).trans (Finset.erase_ssubset ha)
  have hev' : ∀ b, Even (s'.filter fun x => vtx x = b).card := by
    intro b
    by_cases hb : b = vtx a
    · have h1 : (s.filter fun x => vtx x = b) = insert a (insert a' (s'.filter fun x => vtx x = b)) := by
        ext x; simp only [Finset.mem_filter, Finset.mem_insert, hs', Finset.mem_erase]
        constructor
        · rintro ⟨hx, rfl⟩; by_cases h1 : x = a; · exact Or.inl h1
          by_cases h2 : x = a'; · exact Or.inr (Or.inl h2)
          exact Or.inr (Or.inr ⟨⟨h2, h1, hx⟩, rfl⟩)
        · rintro (rfl | rfl | ⟨⟨-, -, hx⟩, rfl⟩)
          · exact ⟨ha, hb.symm⟩
          · exact ⟨ha's, hva'.trans hb.symm⟩
          · exact ⟨hx, rfl⟩
      have h2 := hev b
      rw [h1, Finset.card_insert_of_notMem (by simp [hs', Ne.symm haa']),
        Finset.card_insert_of_notMem (by simp [hs'])] at h2
      obtain ⟨m, hm⟩ := h2
      exact ⟨m - 1, by omega⟩
    · have h1 : (s'.filter fun x => vtx x = b) = s.filter fun x => vtx x = b := by
        ext x; simp only [Finset.mem_filter, hs', Finset.mem_erase]
        constructor
        · rintro ⟨⟨-, -, hx⟩, h⟩; exact ⟨hx, h⟩
        · rintro ⟨hx, h⟩
          refine ⟨⟨fun h' => hb ?_, fun h' => hb ?_, hx⟩, h⟩
          · rw [← h, h', hva']
          · rw [← h, h']
      rw [h1]; exact hev b
  obtain ⟨f', hf'⟩ := ih s' hs's hev'
  refine ⟨fun x => if x = a then a' else if x = a' then a else f' x, fun x hx => ?_⟩
  by_cases hxa : x = a
  · subst hxa; simp [haa', ha's, hva']
  by_cases hxa' : x = a'
  · subst hxa'; simp [haa', Ne.symm haa', ha, hva']
  have hxs' : x ∈ s' := by simp [hs', hxa, hxa', hx]
  obtain ⟨h1, h2, h3, h4⟩ := hf' x hxs'
  have hfa : f' x ≠ a := fun h => by simp [hs', h] at h1
  have hfa' : f' x ≠ a' := fun h => by simp [hs', h] at h1
  simp only [hxa, hxa', if_false, hfa, hfa', h2]
  exact ⟨Finset.mem_of_mem_erase (Finset.mem_of_mem_erase h1), trivial, h3, h4⟩


section Orbits

/-- The orbit of `d` under a permutation, as a list `d, φ d, φ² d, …`. -/
noncomputable def orbList (φ : Equiv.Perm α) (d : α) : List α :=
  (List.range (Function.minimalPeriod φ d)).map fun k => (φ ^ k) d

theorem minimalPeriod_perm_pos [Finite α] (φ : Equiv.Perm α) (d : α) : 0 < Function.minimalPeriod φ d := by
  apply Function.minimalPeriod_pos_of_mem_periodicPts
  refine ⟨orderOf φ, orderOf_pos φ, ?_⟩
  show (⇑φ)^[orderOf φ] d = d
  rw [← Equiv.Perm.coe_pow, pow_orderOf_eq_one]; rfl

theorem pow_minimalPeriod_apply (φ : Equiv.Perm α) (d : α) : (φ ^ Function.minimalPeriod φ d) d = d := by
  rw [Equiv.Perm.coe_pow]; exact Function.iterate_minimalPeriod

theorem mem_orbList {φ : Equiv.Perm α} {d a : α} : a ∈ orbList φ d ↔ ∃ k < Function.minimalPeriod φ d, (φ ^ k) d = a := by
  simp [orbList]

theorem nodup_orbList (φ : Equiv.Perm α) (d : α) : (orbList φ d).Nodup := by
  refine List.Nodup.map_on (fun x hx y hy hxy => ?_) List.nodup_range
  have h := Function.iterate_injOn_Iio_minimalPeriod (f := φ) (x := d)
  simp only [List.mem_range] at hx hy
  simp only [Equiv.Perm.coe_pow] at hxy
  exact h hx hy hxy

theorem orbList_closed [Finite α] (φ : Equiv.Perm α) (d : α) {a : α} (ha : a ∈ orbList φ d) : φ a ∈ orbList φ d := by
  obtain ⟨k, hk, rfl⟩ := mem_orbList.mp ha
  rw [mem_orbList]
  by_cases hk1 : k + 1 < Function.minimalPeriod φ d
  · exact ⟨k + 1, hk1, by rw [pow_succ', Equiv.Perm.mul_apply]⟩
  · refine ⟨0, minimalPeriod_perm_pos φ d, ?_⟩
    rw [pow_zero, Equiv.Perm.one_apply, ← Equiv.Perm.mul_apply, ← pow_succ', show k + 1 = Function.minimalPeriod φ d by omega,
      pow_minimalPeriod_apply]

theorem pow_mem_of_closed {φ : Equiv.Perm α} {S : List α} (h : ∀ a ∈ S, φ a ∈ S) {a : α} (ha : a ∈ S) :
    ∀ k : ℕ, (φ ^ k) a ∈ S
  | 0 => by simpa using ha
  | k + 1 => by rw [pow_succ', Equiv.Perm.mul_apply]; exact h _ (pow_mem_of_closed h ha k)

/-- An orbit of `φ = πA ∘ σ` is a closed trail: each port's arrival vertex is the next port's departure vertex. -/
theorem basedTrail_orbList [Finite α] (σ πA : Equiv.Perm α) (vtx : α → β) (hAv : ∀ a, vtx (πA a) = vtx a) (d : α) :
    BasedTrail vtx (fun a => vtx (σ a)) (vtx d) (orbList (πA * σ) d) := by
  have hm := minimalPeriod_perm_pos (πA * σ) d
  have hne : orbList (πA * σ) d ≠ [] := by
    rw [Ne, orbList, List.map_eq_nil_iff, List.range_eq_nil]; omega
  refine ⟨hne, List.isChain_iff_getElem.mpr fun i hi => ?_, ?_, ?_⟩
  · simp only [orbList, List.getElem_map, List.getElem_range]
    rw [pow_succ', Equiv.Perm.mul_apply, Equiv.Perm.mul_apply, hAv]
  · rw [List.head_eq_getElem]; simp [orbList]
  · rw [List.getLast_eq_getElem]
    simp only [orbList, List.getElem_map, List.getElem_range, List.length_map, List.length_range]
    rw [← hAv, ← Equiv.Perm.mul_apply πA σ, ← Equiv.Perm.mul_apply, ← pow_succ',
      show Function.minimalPeriod (πA * σ) d - 1 + 1 = Function.minimalPeriod (πA * σ) d by omega, pow_minimalPeriod_apply]

/-- `σ` reverses `φ = πA ∘ σ`: `φ^k (σ (φ^k b)) = σ b`. -/
theorem pow_sigma_pow (σ πA : Equiv.Perm α) (hσ : ∀ a, σ (σ a) = a) (hA : ∀ a, πA (πA a) = a) :
    ∀ (k : ℕ) (b : α), ((πA * σ) ^ k) (σ (((πA * σ) ^ k) b)) = σ b
  | 0, b => by simp
  | k + 1, b => by
    have e1 : (πA * σ) ^ (k + 1) = (πA * σ) * (πA * σ) ^ k := pow_succ' _ _
    have e2 : (πA * σ) ^ (k + 1) = (πA * σ) ^ k * (πA * σ) := pow_succ _ _
    calc ((πA * σ) ^ (k + 1)) (σ (((πA * σ) ^ (k + 1)) b))
        = (πA * σ) (((πA * σ) ^ k) (σ (((πA * σ) ^ k) ((πA * σ) b)))) := by
          have e3 : ((πA * σ) ^ (k + 1)) b = ((πA * σ) ^ k) ((πA * σ) b) := by rw [e2]; rfl
          have e4 : ∀ c, ((πA * σ) ^ (k + 1)) c = (πA * σ) (((πA * σ) ^ k) c) := fun c => by rw [e1]; rfl
          rw [e3, e4]
      _ = (πA * σ) (σ ((πA * σ) b)) := by rw [pow_sigma_pow σ πA hσ hA k]
      _ = σ b := by simp only [Equiv.Perm.mul_apply, hσ, hA]

/-- **No orbit of `φ` holds a port with its partner** (the dihedral lemma): were `σ d = φⁿ d`, then `σ` (n even) or `πA = φ σ` (n odd)
would fix a point of the orbit. -/
theorem sigma_ne_pow (σ πA : Equiv.Perm α) (hσ : ∀ a, σ (σ a) = a) (hσ1 : ∀ a, σ a ≠ a) (hA : ∀ a, πA (πA a) = a)
    (hA1 : ∀ a, πA a ≠ a) (d : α) (n : ℕ) : σ d ≠ ((πA * σ) ^ n) d := by
  intro h
  obtain ⟨j, rfl | rfl⟩ := Nat.even_or_odd' n
  · apply hσ1 (((πA * σ) ^ j) d)
    apply ((πA * σ) ^ j).injective
    rw [pow_sigma_pow σ πA hσ hA j d, h, two_mul, pow_add, Equiv.Perm.mul_apply]
  · have hs : σ (((πA * σ) ^ (j + 1)) d) = ((πA * σ) ^ j) d := by
      apply ((πA * σ) ^ (j + 1)).injective
      rw [pow_sigma_pow σ πA hσ hA (j + 1) d, h, show 2 * j + 1 = (j + 1) + j by ring, pow_add, Equiv.Perm.mul_apply]
    apply hA1 (((πA * σ) ^ (j + 1)) d)
    calc πA (((πA * σ) ^ (j + 1)) d) = πA (σ (σ (((πA * σ) ^ (j + 1)) d))) := by rw [hσ]
      _ = ((πA * σ) ^ (j + 1)) d := by rw [hs, pow_succ', Equiv.Perm.mul_apply, Equiv.Perm.mul_apply]

/-- **An Euler circuit of the port structure** (WALK's C6/C8, pure): with `σ` (the other end of each edge) and `πA` (any pairing of the ports
at each vertex) fixed-point-free involutions and the edges connected through shared vertices, some closed trail based at `vtx a₀` lists
each edge once — every port or its partner, never both, no port twice. (Orbits of `πA ∘ σ` are closed trails holding no port with its
partner, `sigma_ne_pow`; one absorbs the next at a shared vertex, `BasedTrail.insert`.) -/
theorem exists_euler [Fintype α] [DecidableEq α] (σ πA : Equiv.Perm α) (vtx : α → β) (hσ : ∀ a, σ (σ a) = a)
    (hσ1 : ∀ a, σ a ≠ a) (hA : ∀ a, πA (πA a) = a) (hA1 : ∀ a, πA a ≠ a) (hAv : ∀ a, vtx (πA a) = vtx a)
    (hconn : ∀ S : Finset α, (∀ a ∈ S, σ a ∈ S) → S.Nonempty → (∃ a, a ∉ S) → ∃ a ∈ S, ∃ b ∉ S, vtx a = vtx b) (a₀ : α) :
    ∃ L : List α, BasedTrail vtx (fun a => vtx (σ a)) (vtx a₀) L ∧ L.Nodup ∧ (∀ a, a ∈ L ∨ σ a ∈ L) ∧ (∀ a ∈ L, σ a ∉ L) := by
  have hsig_orb : ∀ d a, a ∈ orbList (πA * σ) d → σ a ∉ orbList (πA * σ) d := by
    intro d a ha hsa
    obtain ⟨k, -, rfl⟩ := mem_orbList.mp ha
    obtain ⟨j, -, hj⟩ := mem_orbList.mp hsa
    apply sigma_ne_pow σ πA hσ hσ1 hA hA1 d (k + j)
    rw [← pow_sigma_pow σ πA hσ hA k d, ← hj, pow_add, Equiv.Perm.mul_apply]
  suffices key : ∀ n, ∀ L : List α, (BasedTrail vtx (fun a => vtx (σ a)) (vtx a₀) L ∧ L.Nodup ∧ (∀ a ∈ L, (πA * σ) a ∈ L) ∧
      (∀ a ∈ L, σ a ∉ L)) → (Finset.univ.filter fun a => a ∉ L ∧ σ a ∉ L).card = n →
      ∃ L' : List α, BasedTrail vtx (fun a => vtx (σ a)) (vtx a₀) L' ∧ L'.Nodup ∧ (∀ a, a ∈ L' ∨ σ a ∈ L') ∧ (∀ a ∈ L', σ a ∉ L') by
    exact key _ (orbList (πA * σ) a₀) ⟨basedTrail_orbList σ πA vtx hAv a₀, nodup_orbList _ _, fun a ha => orbList_closed _ _ ha,
      hsig_orb a₀⟩ rfl
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  rintro L ⟨hBT, hnd, hcl, hsf⟩ hn
  by_cases hall : ∀ a, a ∈ L ∨ σ a ∈ L
  · exact ⟨L, hBT, hnd, hall, hsf⟩
  push Not at hall
  obtain ⟨c₀, hc₀L, hc₀σ⟩ := hall
  set S := L.toFinset ∪ L.toFinset.image σ with hS
  have hmemS : ∀ a, a ∈ S ↔ a ∈ L ∨ σ a ∈ L := by
    intro a
    simp only [hS, Finset.mem_union, List.mem_toFinset, Finset.mem_image]
    constructor
    · rintro (h | ⟨b, hb, rfl⟩)
      · exact Or.inl h
      · exact Or.inr (by rw [hσ]; exact hb)
    · rintro (h | h)
      · exact Or.inl h
      · exact Or.inr ⟨σ a, h, hσ a⟩
  have hSσ : ∀ a ∈ S, σ a ∈ S := fun a ha => by
    rw [hmemS] at ha ⊢; rw [hσ]; exact ha.symm
  obtain ⟨b, hbS, c, hcS, hbc⟩ := hconn S hSσ ⟨_, (hmemS _).mpr (Or.inl (List.head_mem hBT.1))⟩
    ⟨c₀, fun h => by rcases (hmemS c₀).mp h with h | h <;> contradiction⟩
  have hcL : c ∉ L := fun h => hcS ((hmemS c).mpr (Or.inl h))
  have hcσ : σ c ∉ L := fun h => hcS ((hmemS c).mpr (Or.inr h))
  obtain ⟨e, heL, hev⟩ : ∃ e ∈ L, vtx e = vtx c := by
    rcases (hmemS b).mp hbS with hb | hb
    · exact ⟨b, hb, hbc⟩
    · obtain ⟨e, heL, he⟩ := hBT.exists_start hb
      exact ⟨e, heL, he.trans (by rw [hσ]; exact hbc)⟩
  obtain ⟨L', hBT', hmem', hnd'⟩ := hBT.insert heL (O := orbList (πA * σ) c)
    (by rw [hev]; exact basedTrail_orbList σ πA vtx hAv c)
  have hdis : ∀ a ∈ orbList (πA * σ) c, a ∉ L := by
    intro a ha haL
    obtain ⟨k, hk, rfl⟩ := mem_orbList.mp ha
    have := pow_mem_of_closed hcl haL (Function.minimalPeriod (πA * σ) c - k)
    rw [← Equiv.Perm.mul_apply, ← pow_add, Nat.sub_add_cancel hk.le, pow_minimalPeriod_apply] at this
    exact hcL this
  have hcO : c ∈ orbList (πA * σ) c := mem_orbList.mpr ⟨0, minimalPeriod_perm_pos _ _, by simp⟩
  refine ih _ ?_ L' ⟨hBT', hnd' hnd (nodup_orbList _ _) hdis, fun a ha => ?_, fun a ha hsa => ?_⟩ rfl
  · rw [← hn]
    refine Finset.card_lt_card ⟨fun a ha => ?_, fun h => ?_⟩
    · simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ha ⊢
      exact ⟨fun h => ha.1 ((hmem' a).mpr (Or.inl h)), fun h => ha.2 ((hmem' _).mpr (Or.inl h))⟩
    · have := h (Finset.mem_filter.mpr ⟨Finset.mem_univ c, hcL, hcσ⟩)
      exact (Finset.mem_filter.mp this).2.1 ((hmem' c).mpr (Or.inr hcO))
  · rcases (hmem' a).mp ha with h | h
    · exact (hmem' _).mpr (Or.inl (hcl a h))
    · exact (hmem' _).mpr (Or.inr (orbList_closed _ _ h))
  · rcases (hmem' a).mp ha with h | h <;> rcases (hmem' _).mp hsa with h' | h'
    · exact hsf a h h'
    · obtain ⟨k, -, hk⟩ := mem_orbList.mp h'
      apply hcσ
      have := pow_mem_of_closed hcl h k
      rwa [← hσ a, ← hk, pow_sigma_pow σ πA hσ hA k c] at this
    · obtain ⟨k, -, rfl⟩ := mem_orbList.mp h
      apply hcσ
      have := pow_mem_of_closed hcl h' k
      rwa [pow_sigma_pow σ πA hσ hA k c] at this
    · exact hsig_orb c a h h'

end Orbits

-- A spec example for `orbList`: an orbit list holds its starting point.
example : (0 : Fin 2) ∈ orbList (Equiv.swap 0 1) 0 := mem_orbList.mpr ⟨0, minimalPeriod_perm_pos _ _, rfl⟩

/-- A model of `exists_euler`'s hypotheses, all at once: one loop edge (two ports, `σ = πA` the swap), one vertex. -/
example : ∃ L : List (Fin 2), BasedTrail (fun _ => ()) (fun a => (fun _ => ()) (Equiv.swap (0 : Fin 2) 1 a)) () L ∧ L.Nodup ∧
    (∀ a, a ∈ L ∨ Equiv.swap (0 : Fin 2) 1 a ∈ L) ∧ (∀ a ∈ L, Equiv.swap (0 : Fin 2) 1 a ∉ L) :=
  exists_euler (Equiv.swap 0 1) (Equiv.swap 0 1) (fun _ => ()) (by decide) (by decide) (by decide) (by decide) (fun _ => rfl)
    (fun S _ ⟨a, ha⟩ ⟨b, hb⟩ => ⟨a, ha, b, hb, rfl⟩) 0

end Euler

/-! ### WALK's children (FS131-RW1): the frontier of a filled tile -/

/-- **WALK's C1: the frontier of a filled tile lies in the tile's closure** (FS131-RW1): a point of `cl x̂` off `cl x` lies in the closure
of `x`'s holes, so in a hole (the holes are separated from the rest of the complement, `disjoint_closure_sUnion_holes`), which is open
and inside `x̂`. -/
theorem frontier_closure_fill_subset (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) :
    frontier (closure (fill X)) ⊆ closure X := by
  intro w hw
  by_contra hwX
  set Hs := ⋃₀ {Hc | IsHoleOf X Hc} with hHs
  have hHo : IsOpen Hs := isOpen_sUnion fun Hc hH => IsHoleOf.isOpen hH
  have hw1 : w ∈ closure X ∪ closure Hs := by
    have := hw.1
    rwa [closure_closure, show closure (fill X) = closure X ∪ closure Hs from closure_union] at this
  have hwH : w ∈ closure Hs := hw1.resolve_left hwX
  have hwHs : w ∈ Hs := by
    by_contra h
    exact Set.disjoint_left.mp (disjoint_closure_sUnion_holes hP hX) hwH (subset_closure ⟨hwX, h⟩)
  have hsub : Hs ⊆ closure (fill X) := fun z hz => subset_closure (Or.inr hz)
  exact hw.2 (interior_maximal hsub hHo hwHs)

/-- **WALK's C2: the frontier of a filled tile is connected** (FS131-RW1): unicoherence (`isPreconnected_inter_of_union_eq_univ`) on `cl x̂`
and the closure of its complement, which is connected — a closed split of it would cut off a bounded part of the complement separated from
the rest, a hole of `cl x̂`, against `not_isHoleOf_closure_fill`. -/
theorem isPreconnected_frontier_closure_fill (hF : F.Valid) (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) :
    IsPreconnected (frontier (closure (fill X))) := by
  set K := closure (fill X) with hKdef
  have hK : IsClosed K := isClosed_closure
  rw [frontier_eq_closure_inter_closure, hK.closure_eq]
  refine isPreconnected_inter_of_union_eq_univ hK isClosed_closure (isPreconnected_closure_fill hX) ?_
    (eq_univ_of_forall fun z => by
      by_cases hz : z ∈ K
      · exact Or.inl hz
      · exact Or.inr (subset_closure hz))
  obtain ⟨R, hR⟩ := (isBounded_closure_fill hF hX).subset_closedBall 0
  -- a closed split `P ∪ Q` of `cl Kᶜ` with the far side in `P` makes `Kᶜ ∩ Q` a hole of `K`
  have key : ∀ P Q : Set ℂ, IsClosed P → IsClosed Q → closure Kᶜ ⊆ P ∪ Q → Disjoint P Q → (closedBall (0 : ℂ) R)ᶜ ⊆ P →
      (closure Kᶜ ∩ Q).Nonempty → False := by
    intro P Q hPc hQc hcov hPQ hfar hQne
    obtain ⟨q, hqs, hqQ⟩ := hQne
    have hqP : q ∉ P := fun h => Set.disjoint_left.mp hPQ h hqQ
    obtain ⟨k, hkP, hkK⟩ := mem_closure_iff.mp hqs Pᶜ hPc.isOpen_compl hqP
    have hkQ : k ∈ Q := (hcov (subset_closure hkK)).resolve_left hkP
    refine not_isHoleOf_closure_fill hP hX (Kᶜ ∩ Q) ⟨⟨k, hkK, hkQ⟩, ?_, ?_, ?_⟩
    · rw [← hKdef, hK.closure_eq]; exact inter_subset_left
    · refine (isBounded_closedBall (x := (0 : ℂ)) (r := R)).subset fun w hw => ?_
      by_contra hw'
      exact Set.disjoint_left.mp hPQ (hfar hw') hw.2
    · rw [← hKdef, hK.closure_eq]
      refine Disjoint.mono (closure_minimal inter_subset_right hQc) (closure_minimal (fun w hw => ?_) hPc) hPQ.symm
      exact (hcov (subset_closure hw.1)).resolve_right fun h => hw.2 ⟨hw.1, h⟩
  rw [isPreconnected_closed_iff]
  intro u v hu hv hcov hun hvn
  by_contra hne
  rw [not_nonempty_iff_eq_empty] at hne
  have hdis : Disjoint (closure Kᶜ ∩ u) (closure Kᶜ ∩ v) := by
    rw [Set.disjoint_iff_inter_eq_empty, show closure Kᶜ ∩ u ∩ (closure Kᶜ ∩ v) = closure Kᶜ ∩ (u ∩ v) by
      ext; simp only [mem_inter_iff]; tauto, hne]
  have hcov' : closure Kᶜ ⊆ (closure Kᶜ ∩ u) ∪ (closure Kᶜ ∩ v) := fun z hz =>
    (hcov hz).elim (fun h => Or.inl ⟨hz, h⟩) (fun h => Or.inr ⟨hz, h⟩)
  have hfarK : (closedBall (0 : ℂ) R)ᶜ ⊆ closure Kᶜ := fun w hw => subset_closure fun h => hw (hR h)
  rcases subset_or_subset_of_closed (isPreconnected_compl_closedBall 0 R) (isClosed_closure.inter hu)
      (isClosed_closure.inter hv) (hfarK.trans hcov') (fun w _ hw => Set.disjoint_left.mp hdis hw.1 hw.2) with h | h
  · exact key _ _ (isClosed_closure.inter hu) (isClosed_closure.inter hv) hcov' hdis (fun w hw => (h hw).1)
      (by obtain ⟨w, hw⟩ := hvn; exact ⟨w, hw.1, hw⟩)
  · exact key _ _ (isClosed_closure.inter hv) (isClosed_closure.inter hu) (by rw [union_comm]; exact hcov') hdis.symm
      (fun w hw => (h hw).1) (by obtain ⟨w, hw⟩ := hun; exact ⟨w, hw.1, hw⟩)

/-- A tile lies in a filled tile or off its closure (`subset_fill_of_inter`). -/
theorem IsTile.subset_fill_or_subset_compl {X T : Set ℂ} (hX : F.IsTile X) (hT : F.IsTile T) :
    T ⊆ fill X ∨ T ⊆ (closure (fill X))ᶜ := by
  by_cases h : (T ∩ closure (fill X)).Nonempty
  · exact Or.inl (subset_fill_of_inter hX hT h)
  · exact Or.inr fun w hw hwK => h ⟨w, hw, hwK⟩

/-- A filled tile is open. -/
theorem IsTile.isOpen_fill {X : Set ℂ} (hX : F.IsTile X) : IsOpen (fill X) :=
  hX.isOpen.union (isOpen_sUnion fun _ hH => IsHoleOf.isOpen hH)

/-- Each sector of a chart lies in one tile. -/
theorem IsSectorChart.exists_tile_superset {n : ℕ} {G : BranchGerms n} {z : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀) (hn : 0 < n)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) (i : Fin n) : ∃ T, F.IsTile T ∧ G.sector z r i ⊆ T := by
  obtain ⟨w, hw⟩ := hC.sector_nonempty hr i
  have hwI := hC.sector_subset_interiorPts hn hr i hw
  exact ⟨_, ⟨w, hwI, rfl⟩, hC.sector_subset_tile_of_mem hn hr ⟨w, hwI, rfl⟩ hw (mem_connectedComponentIn hwI)⟩

/-- **Near a branch point only the two sectors its germ bounds are present** (at a radius where the germs are strictly ordered): a small
ball about the point of the germ after `i` lies in the chart's ball and meets no sector but `i` and the one after it. -/
theorem IsSectorChart.near_branch {n : ℕ} {G : BranchGerms n} {z : ℂ} {r₀ : ℝ} (_hC : F.IsSectorChart G z r₀) {r : ℝ}
    (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s) (i : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 r) :
    ∃ δ > 0, ball (branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s) δ ⊆ ball z r ∧
      ∀ j, (G.sector z r j ∩ ball (branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s) δ).Nonempty →
        j = i ∨ j = BranchGerms.next i := by
  set w := branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s with hw
  have hwb : w ∈ ball z r := by rw [mem_ball, dist_eq_norm, hw, norm_branchPt_sub _ _ _ hs.1.le]; exact hs.2
  have hfar : ∀ j, j ≠ i → j ≠ BranchGerms.next i → w ∉ closure (G.sector z r j) := by
    intro j hji hjn hwj
    by_cases hn2 : 2 ≤ n
    · rcases G.eq_or_next_eq_of_mem_closure_sector hn2 hord z hs hwj with h | h
      · exact hjn h
      · exact hji (BranchGerms.next_injective h)
    · have : n = 1 := by have := i.pos; omega
      subst this
      exact hji (Subsingleton.elim _ _)
  have hev : ∀ᶠ y in 𝓝 w, y ∈ ball z r ∧ ∀ j, j ≠ i → j ≠ BranchGerms.next i → y ∉ closure (G.sector z r j) :=
    (show ∀ᶠ y in 𝓝 w, y ∈ ball z r from isOpen_ball.mem_nhds hwb).and (eventually_all.mpr fun j => by
      by_cases hj : j ≠ i ∧ j ≠ BranchGerms.next i
      · exact Filter.Eventually.mono (isClosed_closure.isOpen_compl.mem_nhds (hfar j hj.1 hj.2)) fun y hy _ _ => hy
      · exact Eventually.of_forall fun y h1 h2 => absurd ⟨h1, h2⟩ hj)
  obtain ⟨δ, hδ, hδP⟩ := Metric.eventually_nhds_iff.mp hev
  refine ⟨δ, hδ, fun y hy => (hδP hy).1, fun j ⟨y, hyS, hyb⟩ => ?_⟩
  by_contra hj
  push Not at hj
  exact (hδP hyb).2 j hj.1 hj.2 (subset_closure hyS)

/-- **WALK's C3, the sectors**: at a point of `C = ∂ cl x̂`, each sector of a chart lies in `x̂` or off `cl x̂`, and there is at least one
germ (a point with no germ is interior to its tile, which is then `x`, so interior to `cl x̂`). -/
theorem frontier_fill_chart_pos (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) {z : ℂ} (hz : z ∈ frontier (closure (fill X)))
    {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀) : 0 < n := by
  by_contra h0
  have hball := hC.empty (by omega)
  have hzX : z ∈ closure X := frontier_closure_fill_subset hP hX hz
  obtain ⟨a, haX, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨z, hzX, mem_ball_self hC.pos⟩
  have h1 : ball z r₀ ⊆ X := by
    obtain ⟨x, hx, hXx⟩ := hX
    rw [hXx, connectedComponentIn_eq (hXx ▸ haX)]
    exact (convex_ball z r₀).isPreconnected.subset_connectedComponentIn hab hball
  exact hz.2 (interior_maximal (h1.trans ((subset_fill X).trans subset_closure)) isOpen_ball (mem_ball_self hC.pos))

/-- **WALK's C3, a branch is in `C` exactly when its two sectors are on opposite sides of `cl x̂`** (FS131-RW1). -/
theorem frontier_fill_branch_iff {X : Set ℂ} (hX : F.IsTile X) {n : ℕ} {G : BranchGerms n} {z : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G z r₀) (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s)
    (i : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 r) :
    branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s ∈ frontier (closure (fill X)) ↔
      ¬ (G.sector z r i ⊆ (closure (fill X))ᶜ ↔ G.sector z r (BranchGerms.next i) ⊆ (closure (fill X))ᶜ) := by
  set K := closure (fill X) with hKdef
  set w := branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s with hw
  have hw1 : w ∈ closure (G.sector z r i) := (G.branchPt_mem_closure_sector hord z i hs).2
  have hw2 : w ∈ closure (G.sector z r (BranchGerms.next i)) := (G.branchPt_mem_closure_sector hord z (BranchGerms.next i) hs).1
  have hcases : ∀ j, G.sector z r j ⊆ fill X ∨ G.sector z r j ⊆ Kᶜ := fun j => by
    obtain ⟨T, hT, hjT⟩ := hC.exists_tile_superset hn hr j
    rcases IsTile.subset_fill_or_subset_compl hX hT with h | h
    · exact Or.inl (hjT.trans h)
    · exact Or.inr (hjT.trans h)
  have hne : ∀ j, ¬ (G.sector z r j ⊆ fill X ∧ G.sector z r j ⊆ Kᶜ) := fun j ⟨h1, h2⟩ => by
    obtain ⟨y, hy⟩ := hC.sector_nonempty hr j
    exact h2 hy (subset_closure (h1 hy))
  obtain ⟨δ, hδ, hδb, hδS⟩ := hC.near_branch hord i hs
  have hcl : ∀ y ∈ ball w δ, y ∈ closure (G.sector z r i) ∪ closure (G.sector z r (BranchGerms.next i)) := by
    intro y hy
    obtain ⟨j, hj⟩ := hC.mem_closure_some_sector hn hr (hδb hy)
    rcases hδS j ((closure_inter_open_nonempty_iff isOpen_ball).mp ⟨y, hj, hy⟩) with rfl | rfl
    · exact Or.inl hj
    · exact Or.inr hj
  constructor
  · intro hwK hsame
    rcases hcases i with hi | hi
    · have hni : G.sector z r (BranchGerms.next i) ⊆ fill X := (hcases _).resolve_right fun h =>
        hne i ⟨hi, hsame.mpr h⟩
      refine hwK.2 (interior_maximal (fun y hy => ?_) isOpen_ball (mem_ball_self hδ))
      rcases hcl y hy with h | h
      · exact closure_mono hi h
      · exact closure_mono hni h
    · have hni := hsame.mp hi
      have hwf : w ∈ closure (fill X) := by have := hwK.1; rwa [hKdef, closure_closure] at this
      obtain ⟨y, hyf, hyb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwf, mem_ball_self hδ⟩
      rcases hcl y hyb with h | h
      · obtain ⟨t, htS, htf⟩ := (closure_inter_open_nonempty_iff (hX.isOpen_fill)).mp ⟨y, h, hyf⟩
        exact hi htS (subset_closure htf)
      · obtain ⟨t, htS, htf⟩ := (closure_inter_open_nonempty_iff (hX.isOpen_fill)).mp ⟨y, h, hyf⟩
        exact hni htS (subset_closure htf)
  · intro hdiff
    rw [frontier_eq_closure_inter_closure, isClosed_closure.closure_eq]
    rcases hcases i with hi | hi
    · have hni : G.sector z r (BranchGerms.next i) ⊆ Kᶜ := (hcases _).resolve_left fun h =>
        hdiff ⟨fun h' => absurd ⟨hi, h'⟩ (hne i), fun h' => absurd ⟨h, h'⟩ (hne _)⟩
      exact ⟨closure_mono hi hw1, closure_mono hni hw2⟩
    · have hni : G.sector z r (BranchGerms.next i) ⊆ fill X := (hcases _).resolve_right fun h =>
        hdiff ⟨fun _ => h, fun _ => hi⟩
      exact ⟨closure_mono hni hw2, closure_mono hi hw1⟩

/-- Distinct germs, strictly ordered at a distance, have distinct points there (`hasCurveStar_of_branches`'s step). -/
theorem branchPt_ne_of_ne {n : ℕ} (G : BranchGerms n) {r : ℝ} (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s)
    (v : ℂ) {i j : Fin n} (hij : i ≠ j) {s : ℝ} (hs : s ∈ Ioo 0 r) :
    branchPt v (G.β i) (G.κ i) s ≠ branchPt v (G.β j) (G.κ j) s := by
  have hπ := Real.pi_pos
  have key : ∀ i j : Fin n, i < j → branchPt v (G.β i) (G.κ i) s ≠ branchPt v (G.β j) (G.κ j) s := by
    intro i j hij h
    rw [branchPt_eq, branchPt_eq, polar_eq_iff hs.1 hs.1] at h
    have h1 := G.dir_lt_dir (hord s hs) hij
    have h2 := G.dir_lt_dir_zero_add (hord s hs) j
    have h3 := G.dir_le_dir (hord s hs) (show (⟨0, j.pos⟩ : Fin n) ≤ i from Fin.mk_le_mk.mpr (Nat.zero_le _))
    have he : e (G.dir j s - G.dir i s) = 1 := by
      rw [show G.dir j s - G.dir i s = G.dir j s + -G.dir i s by ring, e_add]
      have : e (germDir (G.β j) (G.κ j) s) = e (germDir (G.β i) (G.κ i) s) := h.2.symm
      change e (germDir (G.β j) (G.κ j) s) * e (-germDir (G.β i) (G.κ i) s) = 1
      rw [this, ← e_add, add_neg_cancel]; simp [e]
    refine e_ne_one (by linarith) ?_ he
    rw [abs_lt]; constructor <;> linarith
  rcases lt_or_gt_of_ne hij with h | h
  · exact key i j h
  · exact (key j i h).symm

/-- **A curve star from some of a chart's branches**: if near `v` the set `C` is `v` and the branches of the germs in `S`, it has a
curve star of `S.card` rays at `v`. -/
theorem hasCurveStar_of_branches_finset {C : Set ℂ} {v : ℂ} {n : ℕ} (G : BranchGerms n) (S : Finset (Fin n)) {r : ℝ} (hr : 0 < r)
    (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s) (hcurv : ∀ i, |G.κ i| * r < 2)
    (heq : C ∩ ball v r = insert v (⋃ i ∈ S, branchPt v (G.β i) (G.κ i) '' Ioo 0 r)) : HasCurveStar C v S.card := by
  set f : Fin S.card → Fin n := fun j => (S.equivFin.symm j).1 with hf
  have hfinj : Function.Injective f := fun a b h => S.equivFin.symm.injective (Subtype.ext h)
  refine ⟨r, hr, fun j => branchPt v (G.β (f j)) (G.κ (f j)), fun j => (continuous_branchPt v _ _).continuousOn,
    fun j s hs => norm_branchPt_sub v _ _ hs.1.le, fun a b hab s hs => branchPt_ne_of_ne G hord v (hfinj.ne hab) hs, ?_,
    fun j s hs => branch_locally_curve v _ _ (hcurv _) hs⟩
  rw [heq]
  congr 1
  ext w
  simp only [mem_iUnion, exists_prop]
  constructor
  · rintro ⟨i, hi, hw⟩
    exact ⟨S.equivFin ⟨i, hi⟩, by simpa [hf] using hw⟩
  · rintro ⟨j, hw⟩
    exact ⟨f j, (S.equivFin.symm j).2, hw⟩

/-- **Side changes around a cycle are even in number**: for any property of the indices, the indices where it differs from the next one's
are evenly many (in `ZMod 2` each counts the property at both ends, and `next` is a bijection). -/
theorem even_card_filter_ne_next {n : ℕ} (p : Fin n → Prop) [DecidablePred p] :
    Even (Finset.univ.filter fun i => ¬ (p i ↔ p (BranchGerms.next i))).card := by
  have hbij : Function.Bijective (BranchGerms.next : Fin n → Fin n) :=
    ⟨BranchGerms.next_injective, Finite.injective_iff_surjective.mp BranchGerms.next_injective⟩
  set g : Fin n → ZMod 2 := fun i => if p i then 1 else 0 with hg
  have hterm : ∀ i, ((if ¬ (p i ↔ p (BranchGerms.next i)) then 1 else 0 : ℕ) : ZMod 2) = g i + g (BranchGerms.next i) := by
    intro i
    simp only [hg]
    by_cases h1 : p i <;> by_cases h2 : p (BranchGerms.next i) <;> simp only [h1, h2] <;> decide
  have hsum : ((Finset.univ.filter fun i => ¬ (p i ↔ p (BranchGerms.next i))).card : ZMod 2) = 0 := by
    rw [Finset.card_filter, Nat.cast_sum]
    simp_rw [hterm]
    rw [Finset.sum_add_distrib, hbij.sum_comp g, ← two_mul]
    exact zero_mul _
  exact (ZMod.natCast_eq_zero_iff_even).mp hsum

-- A spec example for `even_card_filter_ne_next`: around two indices, the property "is `0`" changes twice.
example : (Finset.univ.filter fun i : Fin 2 => ¬ ((i = 0) ↔ (BranchGerms.next i = 0))).card = 2 := by decide

/-- **WALK's C3: the frontier of a filled tile near one of its points** (FS131-RW1): at `z ∈ C = ∂ cl x̂`, out to a radius where a chart's
germs are strictly ordered, `C` is `z` and the branches whose two sectors lie on opposite sides of `cl x̂` — so `C` has a curve star there,
of an even number of rays. -/
theorem frontier_fill_inter_ball (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) {z : ℂ} (hz : z ∈ frontier (closure (fill X)))
    {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀) {r : ℝ} (hr : r ∈ Ioc 0 r₀)
    (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s) [DecidablePred fun i => G.sector z r i ⊆ (closure (fill X))ᶜ] :
    frontier (closure (fill X)) ∩ ball z r = insert z (⋃ i ∈ Finset.univ.filter fun i =>
      ¬ (G.sector z r i ⊆ (closure (fill X))ᶜ ↔ G.sector z r (BranchGerms.next i) ⊆ (closure (fill X))ᶜ),
      branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) '' Ioo 0 r) := by
  have hn := frontier_fill_chart_pos hP hX hz hC
  have hsurj : Function.Surjective (BranchGerms.next : Fin n → Fin n) :=
    Finite.injective_iff_surjective.mp BranchGerms.next_injective
  apply Subset.antisymm
  · rintro w ⟨hwK, hwb⟩
    by_cases hwz : w = z
    · exact Or.inl hwz
    right
    have hwb₀ : w ∈ ball z r₀ := ball_subset_ball hr.2 hwb
    have hwΓ : w ∈ ⋃ a ∈ F.arcs, a.carrier := by
      by_contra hwi
      have hwI : w ∈ F.interiorPts := ⟨hC.subdom hwb₀, hwi⟩
      have hw' : w ∈ ball z r ∩ F.interiorPts := ⟨hwb, hwI⟩
      rw [hC.cover r hr hn] at hw'
      obtain ⟨j, hj⟩ := mem_iUnion.mp hw'
      obtain ⟨T, hT, hjT⟩ := hC.exists_tile_superset hn hr j
      rcases IsTile.subset_fill_or_subset_compl hX hT with h | h
      · exact hwK.2 (interior_maximal ((hjT.trans h).trans subset_closure) (hC.isOpen r hr j) hj)
      · exact h (hjT hj) (by simpa using frontier_subset_closure hwK)
    have hmem : w ∈ (F.Γ ∩ ball z r₀) \ {z} := ⟨⟨⟨hC.subdom hwb₀, hwΓ⟩, hwb₀⟩, hwz⟩
    rw [hC.branches] at hmem
    obtain ⟨m, s, hs, rfl⟩ := mem_iUnion.mp hmem
    have hsr : s ∈ Ioo 0 r := ⟨hs.1, by
      have := norm_branchPt_sub z (G.β m) (G.κ m) hs.1.le
      rw [mem_ball, dist_eq_norm, this] at hwb; exact hwb⟩
    obtain ⟨i, rfl⟩ := hsurj m
    refine mem_iUnion₂.mpr ⟨i, Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_⟩, s, hsr, rfl⟩
    exact (frontier_fill_branch_iff hX hC hn hr hord i hsr).mp hwK
  · rintro w (rfl | hw)
    · exact ⟨hz, mem_ball_self hr.1⟩
    obtain ⟨i, hi, s, hs, rfl⟩ := mem_iUnion₂.mp hw
    refine ⟨(frontier_fill_branch_iff hX hC hn hr hord i hs).mpr (Finset.mem_filter.mp hi).2, ?_⟩
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]; exact hs.2

/-- **WALK's C3, the star**: `C = ∂ cl x̂` has at each of its points a curve star of an even number of rays. -/
theorem frontier_fill_hasCurveStar (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) {z : ℂ}
    (hz : z ∈ frontier (closure (fill X))) : ∃ d, Even d ∧ HasCurveStar (frontier (closure (fill X))) z d := by
  classical
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (show z ∈ F.dom by rw [hP]; exact mem_univ z)
  obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  set r := min u r₀ with hrdef
  have hr : r ∈ Ioc 0 r₀ := ⟨lt_min hu hC.pos, min_le_right _ _⟩
  have hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s := fun s hs => hsub ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
  set S := Finset.univ.filter fun i =>
    ¬ (G.sector z r i ⊆ (closure (fill X))ᶜ ↔ G.sector z r (BranchGerms.next i) ⊆ (closure (fill X))ᶜ) with hS
  refine ⟨(S.image BranchGerms.next).card, ?_, ?_⟩
  · rw [Finset.card_image_of_injective _ BranchGerms.next_injective]
    exact even_card_filter_ne_next _
  · refine hasCurveStar_of_branches_finset G (S.image BranchGerms.next) hr.1 hord
      (fun i => (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans_lt (hC.curv i)) ?_
    rw [Finset.set_biUnion_finset_image]
    exact frontier_fill_inter_ball hP hX hz hC hr hord

/-- **A chart's ball meets `Γ` in its point and its branches** (at any radius up to the chart's, when there is a germ). -/
theorem IsSectorChart.gamma_inter_ball {n : ℕ} {G : BranchGerms n} {z : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀) (hn : 0 < n)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) : F.Γ ∩ ball z r = insert z (⋃ i, branchPt z (G.β i) (G.κ i) '' Ioo 0 r) := by
  ext y
  constructor
  · rintro ⟨hyΓ, hyb⟩
    by_cases hyz : y = z
    · exact Or.inl hyz
    right
    have hmem : y ∈ (F.Γ ∩ ball z r₀) \ {z} := ⟨⟨hyΓ, ball_subset_ball hr.2 hyb⟩, hyz⟩
    rw [hC.branches] at hmem
    obtain ⟨m, s, hs, rfl⟩ := mem_iUnion.mp hmem
    refine mem_iUnion.mpr ⟨m, s, ⟨hs.1, ?_⟩, rfl⟩
    have := norm_branchPt_sub z (G.β m) (G.κ m) hs.1.le
    rw [mem_ball, dist_eq_norm, this] at hyb; exact hyb
  · rintro (rfl | hy)
    · exact ⟨hC.mem_Γ.mpr hn, mem_ball_self hr.1⟩
    obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hy
    have hmem : branchPt z (G.β i) (G.κ i) s ∈ ⋃ i, branchPt z (G.β i) (G.κ i) '' Ioo 0 r₀ :=
      mem_iUnion.mpr ⟨i, s, ⟨hs.1, hs.2.trans_le hr.2⟩, rfl⟩
    rw [← hC.branches] at hmem
    refine ⟨hmem.1.1, ?_⟩
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]; exact hs.2

/-- **At a point where `Γ` is a curve, a chart has two germs** (FS131-RW1, for C4): the curve has two points at each small distance, each on
a branch, and three germs would put three points of one small circle on the curve. -/
theorem IsSectorChart.eq_two_of_isRegularAt {n : ℕ} {G : BranchGerms n} {z : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀) (hn : 0 < n)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s) (hreg : IsRegularAt F.Γ z) : n = 2 := by
  obtain ⟨L, hL, ε, hε, hΓL⟩ := hreg
  have heq := hC.gamma_inter_ball hn hr
  have hzΓ : z ∈ F.Γ := hC.mem_Γ.mpr hn
  have hzL : z ∈ L := by
    have : z ∈ F.Γ ∩ ball z ε := ⟨hzΓ, mem_ball_self hε⟩
    rw [hΓL] at this; exact this.1
  obtain ⟨s₀, hs₀, htwo⟩ := hL.exists_two_mem_sphere hzL
  set s := min (min s₀ ε) r / 2 with hsdef
  have hm : 0 < min (min s₀ ε) r := lt_min (lt_min hs₀ hε) hr.1
  have hs0 : 0 < s := half_pos hm
  have hss₀ : s < s₀ := by linarith [min_le_left (min s₀ ε) r, min_le_left s₀ ε]
  have hsε : s < ε := by linarith [min_le_left (min s₀ ε) r, min_le_right s₀ ε]
  have hsr : s < r := by linarith [min_le_right (min s₀ ε) r]
  -- a point of `L` at distance `s` is the point of some germ
  have hongerm : ∀ p ∈ L, ‖p - z‖ = s → ∃ i, p = branchPt z (G.β i) (G.κ i) s := by
    intro p hp hps
    have hpΓ : p ∈ F.Γ ∩ ball z r := by
      have : p ∈ L ∩ ball z ε := ⟨hp, by rw [mem_ball, dist_eq_norm, hps]; exact hsε⟩
      rw [← hΓL] at this
      exact ⟨this.1, by rw [mem_ball, dist_eq_norm, hps]; exact hsr⟩
    rw [heq] at hpΓ
    rcases hpΓ with rfl | hp'
    · rw [sub_self, norm_zero] at hps; exact absurd hps.symm hs0.ne'
    · obtain ⟨i, s', hs', rfl⟩ := mem_iUnion.mp hp'
      have : s' = s := (norm_branchPt_sub z (G.β i) (G.κ i) hs'.1.le).symm.trans hps
      exact ⟨i, by rw [this]⟩
  -- a germ's point at distance `s` lies on `L`
  have honL : ∀ i, branchPt z (G.β i) (G.κ i) s ∈ L := by
    intro i
    have h1 : branchPt z (G.β i) (G.κ i) s ∈ F.Γ ∩ ball z r := by
      rw [heq]; exact Or.inr (mem_iUnion.mpr ⟨i, s, ⟨hs0, hsr⟩, rfl⟩)
    have h2 : branchPt z (G.β i) (G.κ i) s ∈ F.Γ ∩ ball z ε :=
      ⟨h1.1, by rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ hs0.le]; exact hsε⟩
    rw [hΓL] at h2; exact h2.1
  obtain ⟨p₁, hp₁, p₂, hp₂, hne, h1, h2⟩ := htwo s ⟨hs0, hss₀⟩
  obtain ⟨i₁, rfl⟩ := hongerm p₁ hp₁ h1
  obtain ⟨i₂, rfl⟩ := hongerm p₂ hp₂ h2
  have hi12 : i₁ ≠ i₂ := fun h => hne (by rw [h])
  have hge : 2 ≤ n := by
    by_contra h
    have : n = 1 := by omega
    subst this
    exact hi12 (Subsingleton.elim _ _)
  by_contra hne2
  have h3 : 3 ≤ n := by omega
  have hsph : IsCurve (sphere z s) := Or.inr ⟨z, s, hs0, rfl⟩
  have hd : ∀ a b : Fin n, a ≠ b → branchPt z (G.β a) (G.κ a) s ≠ branchPt z (G.β b) (G.κ b) s :=
    fun a b hab => branchPt_ne_of_ne G hord z hab ⟨hs0, hsr⟩
  have hon : ∀ i, branchPt z (G.β i) (G.κ i) s ∈ L ∩ sphere z s := fun i =>
    ⟨honL i, by rw [mem_sphere, dist_eq_norm, norm_branchPt_sub _ _ _ hs0.le]⟩
  have hLs := hL.eq_of_three hsph (hd ⟨0, by omega⟩ ⟨1, by omega⟩ (by simp [Fin.ext_iff]))
    (hd ⟨0, by omega⟩ ⟨2, by omega⟩ (by simp [Fin.ext_iff])) (hd ⟨1, by omega⟩ ⟨2, by omega⟩ (by simp [Fin.ext_iff]))
    (hon _) (hon _) (hon _)
  have : z ∈ sphere z s := hLs ▸ hzL
  rw [mem_sphere, dist_self] at this
  exact hs0.ne this

/-- **At a point of `C = ∂ cl x̂` some branch is in `C`** (FS131-RW1): with every sector on one side, `z` is interior to `cl x̂` or off it. -/
theorem frontier_fill_exists_ray {X : Set ℂ} (hX : F.IsTile X) {z : ℂ} (hz : z ∈ frontier (closure (fill X)))
    {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀) (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) :
    ∃ i, ¬ (G.sector z r i ⊆ (closure (fill X))ᶜ ↔ G.sector z r (BranchGerms.next i) ⊆ (closure (fill X))ᶜ) := by
  set K := closure (fill X) with hKdef
  by_contra hall
  push Not at hall
  have hcases : ∀ j, G.sector z r j ⊆ fill X ∨ G.sector z r j ⊆ Kᶜ := fun j => by
    obtain ⟨T, hT, hjT⟩ := hC.exists_tile_superset hn hr j
    rcases IsTile.subset_fill_or_subset_compl hX hT with h | h
    · exact Or.inl (hjT.trans h)
    · exact Or.inr (hjT.trans h)
  -- all sectors on the side of sector `0`
  have hsame : ∀ j, (G.sector z r j ⊆ Kᶜ ↔ G.sector z r ⟨0, hn⟩ ⊆ Kᶜ) := by
    have hiter : ∀ m : ℕ, ∀ j : Fin n, j.val = m → (G.sector z r j ⊆ Kᶜ ↔ G.sector z r ⟨0, hn⟩ ⊆ Kᶜ) := by
      intro m
      induction m with
      | zero => intro j hj; rw [show j = ⟨0, hn⟩ from Fin.ext hj]
      | succ m ih =>
        intro j hj
        have hm : m < n := by omega
        have hnext : BranchGerms.next (⟨m, hm⟩ : Fin n) = j := by
          have h1 : (⟨m, hm⟩ : Fin n).val + 1 < n := by show m + 1 < n; omega
          unfold BranchGerms.next; rw [dif_pos h1]; exact Fin.ext hj.symm
        rw [← hnext, ← hall ⟨m, hm⟩]; exact ih _ rfl
    exact fun j => hiter j.val j rfl
  have hne : ∀ j, ¬ (G.sector z r j ⊆ fill X ∧ G.sector z r j ⊆ Kᶜ) := fun j ⟨h1, h2⟩ => by
    obtain ⟨y, hy⟩ := hC.sector_nonempty hr j
    exact h2 hy (subset_closure (h1 hy))
  by_cases h0 : G.sector z r ⟨0, hn⟩ ⊆ Kᶜ
  · -- every sector off `cl x̂`: `x̂` misses the ball
    have hzf : z ∈ closure (fill X) := by have := frontier_subset_closure hz; rwa [hKdef, closure_closure] at this
    obtain ⟨y, hyf, hyb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨z, hzf, mem_ball_self hr.1⟩
    obtain ⟨j, hj⟩ := hC.mem_closure_some_sector hn hr hyb
    obtain ⟨t, htS, htf⟩ := (closure_inter_open_nonempty_iff hX.isOpen_fill).mp ⟨y, hj, hyf⟩
    exact (hsame j).mpr h0 htS (subset_closure htf)
  · -- every sector in `x̂`: the ball lies in `cl x̂`
    refine hz.2 (interior_maximal (fun y hy => ?_) isOpen_ball (mem_ball_self hr.1))
    obtain ⟨j, hj⟩ := hC.mem_closure_some_sector hn hr hy
    have hjf : G.sector z r j ⊆ fill X := (hcases j).resolve_right fun h => h0 ((hsame j).mp h)
    exact closure_mono hjf hj

/-- **WALK's C4: off the vertices `C` is regular** (FS131-RW1): at a point of `C` where `Γ` is a curve, a chart has two germs, some branch
is in `C`, and so (the side changes being even) both are: `C` is `Γ` there. -/
theorem frontier_fill_isRegularAt (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) {z : ℂ} (hz : z ∈ frontier (closure (fill X)))
    (hreg : IsRegularAt F.Γ z) : IsRegularAt (frontier (closure (fill X))) z := by
  classical
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (show z ∈ F.dom by rw [hP]; exact mem_univ z)
  obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  have hr : min u r₀ ∈ Ioc 0 r₀ := ⟨lt_min hu hC.pos, min_le_right _ _⟩
  have hord : ∀ s ∈ Ioo 0 (min u r₀), ∀ i, G.dir i s < G.nextDir i s := fun s hs => hsub ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
  have hn := frontier_fill_chart_pos hP hX hz hC
  have h2 := hC.eq_two_of_isRegularAt hn hr hord hreg
  subst h2
  set S := Finset.univ.filter fun i : Fin 2 =>
    ¬ (G.sector z (min u r₀) i ⊆ (closure (fill X))ᶜ ↔ G.sector z (min u r₀) (BranchGerms.next i) ⊆ (closure (fill X))ᶜ) with hS
  have hSall : S = Finset.univ := by
    obtain ⟨i, hi⟩ := frontier_fill_exists_ray hX hz hC hn hr
    have hi' : i ∈ S := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩
    have hev := even_card_filter_ne_next (fun i : Fin 2 => G.sector z (min u r₀) i ⊆ (closure (fill X))ᶜ)
    rw [← hS] at hev
    have hpos : 0 < S.card := Finset.card_pos.mpr ⟨i, hi'⟩
    have hle : S.card ≤ 2 := (Finset.card_le_univ S).trans (by simp)
    have hc : S.card = 2 := by obtain ⟨m, hm⟩ := hev; omega
    exact Finset.eq_univ_of_card S (by simpa using hc)
  have heq := frontier_fill_inter_ball hP hX hz hC hr hord
  rw [← hS, hSall] at heq
  have hnextU : (⋃ i ∈ (Finset.univ : Finset (Fin 2)), branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) '' Ioo 0 (min u r₀)) =
      ⋃ i, branchPt z (G.β i) (G.κ i) '' Ioo 0 (min u r₀) := by
    ext w
    simp only [Finset.mem_univ, iUnion_true, mem_iUnion]
    constructor
    · rintro ⟨i, hi⟩; exact ⟨_, hi⟩
    · rintro ⟨i, hi⟩
      obtain ⟨j, rfl⟩ := (Finite.injective_iff_surjective.mp (BranchGerms.next_injective (n := 2))) i
      exact ⟨j, hi⟩
  rw [hnextU, ← hC.gamma_inter_ball hn hr] at heq
  obtain ⟨L, hL, ε, hε, hΓL⟩ := hreg
  refine ⟨L, hL, min ε (min u r₀), lt_min hε hr.1, ?_⟩
  have e1 : ball z (min ε (min u r₀)) = ball z ε ∩ ball z (min u r₀) := by ext y; simp [mem_ball]
  rw [e1, show frontier (closure (fill X)) ∩ (ball z ε ∩ ball z (min u r₀)) =
      (frontier (closure (fill X)) ∩ ball z (min u r₀)) ∩ ball z ε by ext; simp only [mem_inter_iff]; tauto, heq,
    show F.Γ ∩ ball z (min u r₀) ∩ ball z ε = (F.Γ ∩ ball z ε) ∩ ball z (min u r₀) by ext; simp only [mem_inter_iff]; tauto, hΓL]
  ext; simp only [mem_inter_iff]; tauto

/-- **WALK's C4: the vertices** (FS131-RW1): the points of `C = ∂ cl x̂` where `Γ` is not a curve are finitely many — `Γ` has a curve star at
each point of `C` (a chart's branches), regular off its centre, and finitely many star discs cover the compact `C`. -/
theorem finite_frontier_fill_nonRegular (hF : F.Valid) (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) :
    {z | z ∈ frontier (closure (fill X)) ∧ ¬ IsRegularAt F.Γ z}.Finite := by
  have hCc : IsCompact (frontier (closure (fill X))) :=
    (isBounded_closure_fill hF hX).isCompact_closure.of_isClosed_subset isClosed_frontier frontier_subset_closure
  have h' : ∀ z ∈ frontier (closure (fill X)), ∃ r > 0, ∀ w ∈ F.Γ ∩ ball z r, w ≠ z → IsRegularAt F.Γ w := by
    intro z hz
    obtain ⟨r₀, n, G, hC⟩ := localSectors F (show z ∈ F.dom by rw [hP]; exact mem_univ z)
    obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
    have hr : min u r₀ ∈ Ioc 0 r₀ := ⟨lt_min hu hC.pos, min_le_right _ _⟩
    have hord : ∀ s ∈ Ioo 0 (min u r₀), ∀ i, G.dir i s < G.nextDir i s := fun s hs =>
      hsub ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
    have hn := frontier_fill_chart_pos hP hX hz hC
    exact (hasCurveStar_of_branches G hr.1 hord (fun i => (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans_lt (hC.curv i))
      (hC.gamma_inter_ball hn hr)).isRegularAt
  choose! r hr hreg using h'
  obtain ⟨t, htC, hcov⟩ := hCc.elim_nhds_subcover (fun z => ball z (r z)) fun z hz => ball_mem_nhds z (hr z hz)
  refine t.finite_toSet.subset ?_
  rintro z ⟨hzC, hzr⟩
  obtain ⟨x, hx, hzx⟩ := mem_iUnion₂.mp (hcov hzC)
  by_contra hzt
  have hne : z ≠ x := fun h' => hzt (h' ▸ hx)
  have hzΓ : z ∈ F.Γ := by
    obtain ⟨r₀, n, G, hC⟩ := localSectors F (show z ∈ F.dom by rw [hP]; exact mem_univ z)
    exact hC.mem_Γ.mpr (frontier_fill_chart_pos hP hX hzC hC)
  exact hzr (hreg x (htC x hx) z ⟨hzΓ, hzx⟩ hne)

/-- **Every filled outer tile has a boundary walk** (FS131-RL1, child **WALK**; plan § 3–4). The construction, over the finite boundary
graph of `C = ∂ cl x̂` (`Plane/CurveGraph`): `C` is compact and connected (unicoherence, `cl x̂` without holes), a curve star at each point
(each branch of the sector chart there is in `C` exactly when `x` is on one side and a tile of `(cl x̂)ᶜ` on the other); its vertices
are the points where `Γ` is not regular (one added point if none), its edges the port pairs (`port_pair`), each with one tile on its
outer side; its *angles* are the runs of outer sectors between consecutive rays of `C` at a vertex. Edges and angles make a 2-regular
structure, whose cycles (one direction each) are walks; cycles sharing a vertex are merged by inserting one inside an angle of the other,
which splits no edge; a tile's vertex appearances are dropped when it has an edge, and all but one when it has none. -/
theorem exists_boundaryWalk (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    ∃ (r : List {T : Set ℂ // F.IsOuterTile T}) (z : ℕ → ℂ) (E : ℕ → Set ℂ) (p : ℕ → ℂ) (ρ : ℕ → ℝ) (edge : ℕ → Prop),
      F.IsBoundaryWalk x r z E p ρ edge := by
  sorry

/-- **The boundary walk of a filled tile** (F-RING's remaining child; FS131-IP5's reduction of F-RING, by statement exactly F-RING's first
conjunct): every filled outer tile `x̂` has a ring — its neighbours listed so that cyclically consecutive entries are equal or adjacent, and any
two appearances of a neighbour `y` separate, in `M̂ − x − y`, the entries between from those outside (Thomassen's rule: a repeated neighbour is
listed only at its edge contacts). Read off a boundary walk (`exists_boundaryWalk`, `IsBoundaryWalk.isRing`; FS131-RL1's plan,
`plans/FS131-ringlist-kernel-plan.md`): the walk around `∂ cl x̂` — every complementary component's frontier, joined at pinch points — over
the finite boundary graph (`Plane/CurveGraph`), its repeated tiles separated by the crossing lemma outside a disc at a pure point of an edge
(`inter_nonempty_of_interleaved_exterior`). -/
theorem filledGraph_ringList (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    ∃ r, Thomassen.IsRing F.filledGraph x r := by
  obtain ⟨r, z, E, p, ρ, edge, hW⟩ := exists_boundaryWalk hF hP x
  exact ⟨r, hW.isRing⟩

/-- **Rings from boundary walks** (leaf F-RING, the planar heart of CVB B2 step 2): every filled outer tile `x̂` has a ring — the outer
boundary walk of `x̂` (`frontier (outerDom x)`, preconnected), listing the tiles met at each pass (sector charts), each repeated tile only at
its edge contacts — and `M̂ − x − y` is connected unless `y` appears twice apart (a bounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)` is enclosed by
edges of both; CVB's sketch, one mind). Plan § 4: the boundary walk is built over the finite boundary graph of `F` near `cl x̂` (the same
graph as `exists_far_end`'s); separation by `isPreconnected_frontier_connectedComponentIn` and `inter_nonempty_of_interleaved`. **H**, the
wave's longest leaf; may be its own job (Keryx's call after the implementer's measurement). -/
theorem filledGraph_rings (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    ∃ r, Thomassen.IsRing F.filledGraph x r ∧
      ∀ y, y ≠ x → ¬ Thomassen.TwiceApart r y → (F.filledGraph.induce (Thomassen.offTwo x y)).Connected := by
  -- the boundary walk with each entry repeated four times: every neighbour appears twice apart, and a non-neighbour's filled closure
  -- misses `x̂`'s, so `M̂ − x − y` is connected (`filledGraph_offTwo_connected`)
  obtain ⟨r₀, hr₀⟩ := filledGraph_ringList hF hP x
  refine ⟨r₀.flatMap (List.replicate 4), isRing_flatMap_replicate_four hr₀, fun y hyx htw => ?_⟩
  by_cases hadj : F.filledGraph.Adj x y
  · exact absurd (twiceApart_flatMap_replicate_four ((hr₀.1 y).mpr hadj)) htw
  · refine filledGraph_offTwo_connected hF hP x y ?_
    rw [Set.disjoint_iff_inter_eq_empty, ← not_nonempty_iff_eq_empty]
    exact fun h => hadj ⟨hyx.symm, h⟩

/-- **One infinite component** (leaf F-ONE, CVB B2 step 2): for distinct outer tiles `x`, `y`, `M̂ − x − y` has exactly one infinite
component — the tiles of the unbounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)` are chained (`mem_of_touch_closed`) and infinitely many, those of
bounded components finitely many (`finite_tiles_closure_inter` on the hull), and every component meeting no unbounded tile is among them. -/
theorem filledGraph_oneInf (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T}) (hxy : x ≠ y) :
    ∃ c : (F.filledGraph.induce (Thomassen.offTwo x y)).ConnectedComponent, ¬ c.supp.Finite ∧ ∀ c', ¬ c'.supp.Finite → c' = c := by
  -- `x ≠ y` is not read: the far side is one class for `x = y` too (`exists_far_component`)
  have _ := hxy
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  -- the two filled closures lie in one disc
  obtain ⟨p, hp⟩ := x.2.1.nonempty
  obtain ⟨q, hq⟩ := y.2.1.nonempty
  have hR : closure (fill x.1) ∪ closure (fill y.1) ⊆ closedBall p (dist q p + 1) :=
    union_subset ((closure_fill_subset_closedBall hF x.2.1 (subset_closure hp)).trans
        (closedBall_subset_closedBall (by linarith [dist_nonneg (x := q) (y := p)])))
      ((closure_fill_subset_closedBall hF y.2.1 (subset_closure hq)).trans (closedBall_subset_closedBall' (by linarith)))
  obtain ⟨C, hCinf, hCfar⟩ := exists_far_component hF hP x y hR
  refine ⟨C, hCinf, fun C' hC' => ?_⟩
  -- an infinite component has a tile meeting the far region: finitely many tiles lie in the disc
  have hfin : {v : Thomassen.offTwo x y | v.1.1 ⊆ closedBall p (dist q p + 1)}.Finite := by
    refine ((finite_tiles_closure_inter (isCompact_closedBall p (dist q p + 1)) (hdom _)).preimage
      (Subtype.val_injective.comp Subtype.val_injective).injOn).subset fun v hv => ?_
    obtain ⟨w, hw⟩ := v.1.2.1.nonempty
    exact ⟨v.1.2.1, w, subset_closure hw, hv hw⟩
  obtain ⟨v, hvC', hvR⟩ : ∃ v ∈ C'.supp, ¬ v.1.1 ⊆ closedBall p (dist q p + 1) := by
    by_contra h
    push Not at h
    exact hC' (hfin.subset fun v hv => h v hv)
  obtain ⟨w, hw, hwR⟩ := not_subset.mp hvR
  rw [← (SimpleGraph.ConnectedComponent.mem_supp_iff _ _).mp hvC']
  exact hCfar v.1 v.2 ⟨w, hw, hwR⟩

/-- **Finitely many pairs enclose a tile** (leaf F-SEP, inventory item 309; FS131-IT1's sketch, one mind): a filled outer tile `v` lies in the
interior of finitely many pairs of `M̂`. If `v ∈ int(x, y)` then `{x, y}` is a 2-separator, so `x̂` and `ŷ` touch (the rings), and `v̂` lies in a
bounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)`, inside that compact set's convex hull, so `cl x̂` and `cl ŷ` meet `B̄(p, 3)` for any `p ∈ cl v̂` (filled
tiles of diameter at most `1`), and only finitely many tiles do (`finite_tiles_closure_inter`). -/
theorem filledGraph_finSep (hF : F.Valid) (hP : F.IsPlaneMap) (v : {T : Set ℂ // F.IsOuterTile T}) :
    {p : {T : Set ℂ // F.IsOuterTile T} × {T : Set ℂ // F.IsOuterTile T} | v ∈ Thomassen.twoSepInterior F.filledGraph p.1 p.2}.Finite := by
  have hdom : ∀ A : Set ℂ, A ⊆ F.dom := fun A => by rw [hP]; exact subset_univ _
  obtain ⟨p, hp⟩ := v.2.1.nonempty
  have hfin : {T : {T : Set ℂ // F.IsOuterTile T} | (closure T.1 ∩ closedBall p 3).Nonempty}.Finite :=
    ((finite_tiles_closure_inter (isCompact_closedBall p 3) (hdom _)).preimage Subtype.val_injective.injOn).subset
      fun T hT => ⟨T.2.1, hT⟩
  refine (hfin.prod hfin).subset ?_
  rintro ⟨x, y⟩ ⟨hvo, hvfin⟩
  -- the filled closures of `x` and `y` meet: else `M̂ − x − y` is connected (`filledGraph_offTwo_connected`) and infinite
  have hmeet : (closure (fill x.1) ∩ closure (fill y.1)).Nonempty := by
    by_contra hd
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at hd
    have hconn := filledGraph_offTwo_connected hF hP x y hd
    have huniv : ((F.filledGraph.induce (Thomassen.offTwo x y)).connectedComponentMk ⟨v, hvo⟩).supp = univ :=
      eq_univ_of_forall fun w => (SimpleGraph.ConnectedComponent.mem_supp_iff _ _).mpr
        (SimpleGraph.ConnectedComponent.sound (hconn.preconnected w ⟨v, hvo⟩))
    rw [huniv] at hvfin
    exact offTwo_infinite hF hP x y (Set.finite_coe_iff.mp (Set.finite_univ_iff.mp hvfin))
  obtain ⟨z, hzx, hzy⟩ := hmeet
  obtain ⟨qx, hqx⟩ := x.2.1.nonempty
  obtain ⟨qy, hqy⟩ := y.2.1.nonempty
  have hx1 := closure_fill_subset_closedBall hF x.2.1 (subset_closure hqx)
  have hy1 := closure_fill_subset_closedBall hF y.2.1 (subset_closure hqy)
  have hdxy : dist qx qy ≤ 2 := by
    have h1 := hx1 hzx
    have h2 := hy1 hzy
    rw [mem_closedBall] at h1 h2
    linarith [dist_triangle qx z qy, dist_comm z qx]
  -- `v` lies in every disc holding both filled closures (`exists_far_component`)
  have hvin : ∀ c R, closure (fill x.1) ∪ closure (fill y.1) ⊆ closedBall c R → v.1 ⊆ closedBall c R := by
    intro c R hR
    by_contra h
    obtain ⟨w, hw, hwR⟩ := not_subset.mp h
    obtain ⟨C, hCinf, hCfar⟩ := exists_far_component hF hP x y hR
    rw [hCfar v hvo ⟨w, hw, hwR⟩] at hvfin
    exact hCinf hvfin
  have h1 := hvin qx 3 (union_subset (hx1.trans (closedBall_subset_closedBall (by norm_num)))
    (hy1.trans (closedBall_subset_closedBall' (by linarith [dist_comm qy qx])))) hp
  have h2 := hvin qy 3 (union_subset (hx1.trans (closedBall_subset_closedBall' (by linarith)))
    (hy1.trans (closedBall_subset_closedBall (by norm_num)))) hp
  refine ⟨⟨qx, subset_closure hqx, ?_⟩, ⟨qy, subset_closure hqy, ?_⟩⟩
  · rw [mem_closedBall, dist_comm]; exact h1
  · rw [mem_closedBall, dist_comm]; exact h2

/-- **The filled map graph of a valid plane map has Thomassen's planar properties** (CVB B2 steps 1–3; the six leaves above). -/
theorem filledGraph_planarLike (hF : F.Valid) (hP : F.IsPlaneMap) : Thomassen.PlanarLike F.filledGraph :=
  ⟨filledGraph_locallyFinite hF hP, filledGraph_connected hF hP, filledGraph_infinite hF hP, filledGraph_rings hF hP,
    filledGraph_oneInf hF hP, filledGraph_finSep hF hP⟩

/-- **FS114-CVB-THOM, B2 steps 1–3** (`plans/FS114-CVB-verification.md` § 1.9): for every valid map of the plane, Siamese pairs allowed, the
reduced filled map graph `H` is connected, locally finite, locally Hamiltonian and infinite — `[Thomassen1999]`'s steps other than the
rainbow step, with holes filled, facial cycles read as boundary walks, and the count in `int(R)` replaced by local finiteness. Colour-free
(CVB: "indeed every locally finite plane map with bounded connected tiles"); validity enters only through the tiles' diameter `≤ 1`
(`dist_lt_one_of_forall_dist_ne_one`). Every `k`. Model of the hypotheses: `sevenBrickMap` (valid, of the plane, `k = 7`). -/
theorem cvb_thom_reduced (hF : F.Valid) (hP : F.IsPlaneMap) :
    (Thomassen.reduced F.filledGraph).Connected ∧ (∀ x, ((Thomassen.reduced F.filledGraph).neighborSet x).Finite) ∧
      Thomassen.LocallyHamiltonian (Thomassen.reduced F.filledGraph) ∧ Infinite (Thomassen.reducedVerts F.filledGraph) :=
  Thomassen.reduced_props_of_planarLike _ (filledGraph_planarLike hF hP)

/-- **FS114-CVB-THOM** (B2 step 4): every valid map of the plane, Siamese pairs allowed, has an outer tile of degree at least `6` in the reduced
filled map graph `H` (`cvb_thom_reduced` and `Thomassen.lemma1`). The rainbow step — that such a tile's neighbours carry six colours — is not
claimed (it fails on valid maps: FS114-N114-RD's types (A) and (B)). Model of the hypotheses: `sevenBrickMap` (`k = 7`; its bricks have six
neighbours each). -/
theorem cvb_thom (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ x, 6 ≤ ((Thomassen.reduced F.filledGraph).neighborSet x).encard := by
  obtain ⟨hc, hfin, hH, hinf⟩ := cvb_thom_reduced hF hP
  exact Thomassen.lemma1 _ hfin hc hH (by rw [ENat.card_eq_top_of_infinite]; exact le_top)

/-- **FS114-CVB-PINCH, the pinch clause** (B1): in the map graph of a valid map of the plane, removing a tile with no hole leaves the graph
connected — at a pinched tile (its boundary walk visits a vertex twice) as at a simple one. Read at the class the argument reads (every tile
with no hole; Thomassen's own case is the unpinched one). Model of the hypotheses: a brick of `sevenBrickMap`. -/
theorem cvb_pinch_connected (hF : F.Valid) (hP : F.IsPlaneMap) {T : Set ℂ} (hT : F.IsTile T) (hno : ∀ Hc, ¬ IsHoleOf T Hc) :
    (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  -- FS131-KP plan § 4, leaf PINCH: through the separation, with local finiteness read at one point only
  set O := (closure T)ᶜ with hO
  have hOo : IsOpen O := isClosed_closure.isOpen_compl
  have hdom : ∀ S : Set ℂ, S ⊆ F.dom := fun S => by rw [hP]; exact subset_univ _
  have hTne : ∀ A, F.IsTile A → (A ∩ O).Nonempty → A ≠ T := by
    rintro A - ⟨z, hzA, hzO⟩ rfl
    exact hzO (subset_closure hzA)
  -- `cl T` is bounded (`IsTile.closure_subset_closedBall`)
  obtain ⟨x, hx⟩ := hT.nonempty
  have hTR : closure T ⊆ closedBall 0 (‖x‖ + 1) := by
    intro z hz
    have := hT.closure_subset_closedBall hF (subset_closure hx) hz
    rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
    linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]
  set R := ‖x‖ + 1
  have hfarO : (closedBall (0 : ℂ) R)ᶜ ⊆ O := fun z hz h => hz (hTR h)
  have hfarne : ((closedBall (0 : ℂ) R)ᶜ).Nonempty :=
    ⟨((|R| + 1 : ℝ) : ℂ), by
      rw [mem_compl_iff, mem_closedBall, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by positivity), not_le]
      linarith [le_abs_self R]⟩
  -- a tile other than `T` lies off `cl T`, inside the component of `O` of any of its points
  have hsubC : ∀ A, F.IsTile A → A ≠ T → ∀ a ∈ A, A ⊆ connectedComponentIn O a := fun A hA hAT a ha =>
    hA.isPreconnected.subset_connectedComponentIn ha (IsTile.subset_compl_closure hT hA hAT)
  -- the vertices of `M − T`, and the tiles reachable from a fixed one `A`
  set G := F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩} with hG
  let mk : ∀ A, F.IsTile A → A ≠ T → {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} :=
    fun A hA hAT => ⟨⟨A, hA⟩, fun h => hAT (congrArg Subtype.val h)⟩
  -- `M − T` has a vertex: a tile meeting the complement of a large disc
  obtain ⟨A, hA, a, haA, haW⟩ := exists_tile_inter_of_isOpen isClosed_closedBall.isOpen_compl (hdom _) hfarne
  have hAT : A ≠ T := hTne A hA ⟨a, haA, hfarO haW⟩
  set vA := mk A hA hAT
  set P : Set (Set ℂ) := {S | ∃ (hS : F.IsTile S) (hST : S ≠ T), G.Reachable vA (mk S hS hST)} with hPdef
  have hAP : A ∈ P := ⟨hA, hAT, SimpleGraph.Reachable.refl (G := G) _⟩
  -- every tile in a component of `O` that holds a tile of `P` is in `P` (`mem_of_touch_closed`)
  have hcomp : ∀ w ∈ O, (∃ S ∈ P, (S ∩ connectedComponentIn O w).Nonempty) →
      ∀ S, F.IsTile S → S ⊆ connectedComponentIn O w → S ∈ P := by
    intro w hw ⟨S₀, hS₀P, hS₀w⟩
    set U := connectedComponentIn O w
    have hUo : IsOpen U := hOo.connectedComponentIn
    have hin : ∀ S, F.IsTile S → (S ∩ U).Nonempty → S ⊆ U := by
      rintro S hS ⟨z, hzS, hzU⟩
      have hST := hTne S hS ⟨z, hzS, connectedComponentIn_subset _ _ hzU⟩
      rw [show U = connectedComponentIn O z from connectedComponentIn_eq hzU]
      exact hsubC S hS hST z hzS
    have key := mem_of_touch_closed hUo isPreconnected_connectedComponentIn (hdom _) hin {S | S ∈ P ∧ S ⊆ U}
      (fun S hS => ⟨hS.1.1, hS.2⟩) ⟨S₀, hS₀P, hin S₀ hS₀P.1 hS₀w⟩ (by
        rintro S ⟨⟨hS, hST, hreach⟩, hSU⟩ S' hS' hS'U hcl
        refine ⟨?_, hS'U⟩
        by_cases hSS' : S = S'
        · exact hSS' ▸ ⟨hS, hST, hreach⟩
        · obtain ⟨z, hz⟩ := hS'.nonempty
          have hS'T := hTne S' hS' ⟨z, hz, connectedComponentIn_subset _ _ (hS'U hz)⟩
          refine ⟨hS', hS'T, hreach.trans (SimpleGraph.Adj.reachable ?_)⟩
          exact ⟨fun h => hSS' (congrArg Subtype.val h), hcl⟩)
    intro S hS hSU
    exact (key S hS hSU).1
  -- `Y`: the union of the components of `O` holding a tile of `P`; `Hc` the rest of `O`
  set Y := {z | z ∈ O ∧ ∃ S ∈ P, (S ∩ connectedComponentIn O z).Nonempty} with hYdef
  set Hc := O \ Y with hHcdef
  have hYsat : ∀ z ∈ O, ∀ w ∈ connectedComponentIn O z, (w ∈ Y ↔ z ∈ Y) := by
    intro z hz w hw
    rw [hYdef, mem_setOf_eq, mem_setOf_eq, ← connectedComponentIn_eq hw]
    exact ⟨fun h => ⟨hz, h.2⟩, fun h => ⟨connectedComponentIn_subset _ _ hw, h.2⟩⟩
  have hYo : IsOpen Y := by
    rw [isOpen_iff_forall_mem_open]
    intro z hz
    exact ⟨connectedComponentIn O z, fun w hw => (hYsat z hz.1 w hw).mpr hz, hOo.connectedComponentIn,
      mem_connectedComponentIn hz.1⟩
  have hHo : IsOpen Hc := by
    rw [isOpen_iff_forall_mem_open]
    intro z hz
    exact ⟨connectedComponentIn O z, fun w hw => ⟨connectedComponentIn_subset _ _ hw,
      fun hwY => hz.2 ((hYsat z hz.1 w hw).mp hwY)⟩, hOo.connectedComponentIn, mem_connectedComponentIn hz.1⟩
  have hOY : O \ Hc = Y := by
    ext z; constructor
    · rintro ⟨hzO, hzH⟩; by_contra hzY; exact hzH ⟨hzO, hzY⟩
    · intro hz; exact ⟨hz.1, fun h => h.2 hz⟩
  have hOH : O \ Y = Hc := rfl
  -- a tile meeting `Y` is in `P`
  have hYP : ∀ S, F.IsTile S → (S ∩ Y).Nonempty → S ∈ P := by
    rintro S hS ⟨z, hzS, hzY⟩
    exact hcomp z hzY.1 hzY.2 S hS (hsubC S hS (hTne S hS ⟨z, hzS, hzY.1⟩) z hzS)
  -- `Hc` and `Y` are separated: a common closure point lies in `cl T`, where tiles of both touch
  have hsep : Disjoint (closure Hc) (closure Y) := by
    rw [Set.disjoint_left]
    intro z hzH hzY
    obtain ⟨X, hX, ⟨x', hx'X, hx'H⟩, hzX⟩ := exists_tile_mem_closure_of_mem_closure hHo (hdom _ (mem_univ z)) hzH
    obtain ⟨W, hW, ⟨w, hwW, hwY⟩, hzW⟩ := exists_tile_mem_closure_of_mem_closure hYo (hdom _ (mem_univ z)) hzY
    have hWP := hYP W hW ⟨w, hwW, hwY⟩
    have hXT := hTne X hX ⟨x', hx'X, hx'H.1⟩
    have hXP : X ∈ P := by
      by_cases hXW : X = W
      · exact hXW ▸ hWP
      · obtain ⟨hW', hWT, hreach⟩ := hWP
        exact ⟨hX, hXT, hreach.trans (SimpleGraph.Adj.reachable ⟨fun h => hXW (congrArg Subtype.val h).symm, z, hzW, hzX⟩)⟩
    exact hx'H.2 ⟨hx'H.1, X, hXP, x', hx'X, mem_connectedComponentIn hx'H.1⟩
  -- the far part lies in `Y` (it holds `a`), so `Hc` is bounded: empty, or a hole
  have haY : a ∈ Y := ⟨hfarO haW, A, hAP, a, haA, mem_connectedComponentIn (hfarO haW)⟩
  have hfarY : (closedBall (0 : ℂ) R)ᶜ ⊆ Y :=
    (isPreconnected_compl_closedBall (0 : ℂ) R).subset_left_of_subset_union hYo hHo
      (Set.disjoint_left.mpr fun z hzY hzH => hzH.2 hzY) (fun z hz => by
        by_cases hzY : z ∈ Y
        · exact Or.inl hzY
        · exact Or.inr ⟨hfarO hz, hzY⟩) ⟨a, haW, haY⟩
  have hHc : Hc = ∅ := by
    by_contra hne'
    apply hno Hc
    refine ⟨nonempty_iff_ne_empty.mpr hne', fun z hz => hz.1, (isBounded_closedBall (x := (0 : ℂ)) (r := R)).subset ?_, ?_⟩
    · intro z hz
      by_contra hzR
      exact hz.2 (hfarY hzR)
    · rw [hOY]; exact hsep
  -- so every tile other than `T` is in `P`: `M − T` is connected
  have hall : ∀ S, F.IsTile S → S ≠ T → S ∈ P := by
    intro S hS hST
    obtain ⟨z, hz⟩ := hS.nonempty
    have hzO : z ∈ O := IsTile.subset_compl_closure hT hS hST hz
    have hzY : z ∈ Y := by
      by_contra hzY
      have : z ∈ Hc := ⟨hzO, hzY⟩
      rw [hHc] at this
      exact this
    exact hYP S hS ⟨z, hz, hzY⟩
  haveI : Nonempty {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := ⟨vA⟩
  refine ⟨fun v w => ?_⟩
  obtain ⟨⟨S, hS⟩, hSv⟩ := v
  obtain ⟨⟨S', hS'⟩, hS'v⟩ := w
  have hST : S ≠ T := fun h => hSv (Subtype.ext h)
  have hS'T : S' ≠ T := fun h => hS'v (Subtype.ext h)
  obtain ⟨h1S, h1T, h1⟩ := hall S hS hST
  obtain ⟨h2S, h2T, h2⟩ := hall S' hS' hS'T
  exact h1.symm.trans h2

/-- **FS114-CVB-PINCH, the hole clause** (B1): in the map graph of a valid map of the plane, removing a tile with a hole disconnects the graph
(the tiles inside the hole from those outside). Whether a valid plane map with a holed tile exists is not claimed (the row: "every valid map
cannot be refuted by an object"); the local configuration is `exists_holed_valid_fragment`. `GENERIC` on plane maps. -/
theorem cvb_hole_disconnected (hF : F.Valid) (hP : F.IsPlaneMap) {T Hc : Set ℂ} (hT : F.IsTile T) (hH : IsHoleOf T Hc) :
    ¬ (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  -- FS131-KP plan § 4, leaf HOLE: no Jordan curve theorem, only the separation clause
  obtain ⟨hne, hsub, hb, hsep⟩ := hH
  set O := (closure T)ᶜ with hO
  -- `Hc` and the rest of `(cl T)ᶜ` are open (`Hc = (cl T)ᶜ \ cl ((cl T)ᶜ \ Hc)`)
  have hHeq : Hc = O \ closure (O \ Hc) := by
    ext z
    constructor
    · intro hz
      exact ⟨hsub hz, fun h => Set.disjoint_left.mp hsep (subset_closure hz) h⟩
    · rintro ⟨hzO, hzn⟩
      by_contra hzH
      exact hzn (subset_closure ⟨hzO, hzH⟩)
  have hHo : IsOpen Hc := by
    rw [hHeq]; exact isClosed_closure.isOpen_compl.sdiff isClosed_closure
  -- a tile other than `T` lies inside `Hc` or inside the rest
  have hside : ∀ A, F.IsTile A → A ≠ T → A ⊆ Hc ∨ A ⊆ O \ Hc := by
    intro A hA hAT
    refine hA.subset_or_subset_of_separated hsep fun z hz => ?_
    by_cases hzH : z ∈ Hc
    · exact Or.inl hzH
    · exact Or.inr ⟨IsTile.subset_compl_closure hT hA hAT hz, hzH⟩
  have hTne : ∀ A, F.IsTile A → (A ∩ O).Nonempty → A ≠ T := by
    rintro A - ⟨z, hzA, hzO⟩ rfl
    exact hzO (subset_closure hzA)
  -- a tile inside the hole (`exists_tile_inter_of_isOpen`, `IsTile.subset_compl_closure`, `IsTile.subset_or_subset_of_separated`)
  have hin : ∃ A, F.IsTile A ∧ A ⊆ Hc := by
    obtain ⟨A, hA, z, hzA, hzH⟩ := exists_tile_inter_of_isOpen hHo (by rw [hP]; exact subset_univ _) hne
    have hAT := hTne A hA ⟨z, hzA, hsub hzH⟩
    refine ⟨A, hA, (hside A hA hAT).resolve_right fun h => (h hzA).2 hzH⟩
  -- a tile outside it: the rest holds the complement of a large disc
  have hout : ∃ B, F.IsTile B ∧ B ≠ T ∧ B ⊆ (closure T)ᶜ \ Hc := by
    obtain ⟨x, hx⟩ := hT.nonempty
    obtain ⟨R₁, hR₁⟩ := hb.subset_closedBall 0
    have hTR : closure T ⊆ closedBall 0 (‖x‖ + 1) := by
      intro z hz
      have := hT.closure_subset_closedBall hF (subset_closure hx) hz
      rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
      linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]
    set R := max R₁ (‖x‖ + 1)
    have hW : (closedBall (0 : ℂ) R)ᶜ ⊆ O \ Hc := fun z hz =>
      ⟨fun h => hz (closedBall_subset_closedBall (le_max_right _ _) (hTR h)),
        fun h => hz (closedBall_subset_closedBall (le_max_left _ _) (hR₁ h))⟩
    obtain ⟨B, hB, z, hzB, hzW⟩ := exists_tile_inter_of_isOpen isClosed_closedBall.isOpen_compl
      (by rw [hP]; exact subset_univ _) (show ((closedBall (0 : ℂ) R)ᶜ).Nonempty from
        ⟨((|R| + 1 : ℝ) : ℂ), by
          rw [mem_compl_iff, mem_closedBall, dist_zero_right, Complex.norm_real,
            Real.norm_of_nonneg (by positivity), not_le]
          linarith [le_abs_self R]⟩)
    have hBT := hTne B hB ⟨z, hzB, (hW hzW).1⟩
    exact ⟨B, hB, hBT, (hside B hB hBT).resolve_left fun h => (hW hzW).2 (h hzB)⟩
  -- a walk of `M − T` from `A` to `B` has a dart leaving the tiles inside `Hc`; the dart's two tiles have closures in `cl Hc` and
  -- `cl ((cl T)ᶜ \ Hc)`, disjoint by `hsep`, yet adjacent
  intro hconn
  obtain ⟨A, hA, hAH⟩ := hin
  obtain ⟨B, hB, hBT, hBH⟩ := hout
  obtain ⟨a, haA⟩ := hA.nonempty
  have hAT : A ≠ T := hTne A hA ⟨a, haA, hsub (hAH haA)⟩
  let vA : {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := ⟨⟨A, hA⟩, fun h => hAT (congrArg Subtype.val h)⟩
  let vB : {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := ⟨⟨B, hB⟩, fun h => hBT (congrArg Subtype.val h)⟩
  obtain ⟨p⟩ := hconn.preconnected vA vB
  obtain ⟨d, -, hd1, hd2⟩ := p.exists_boundary_dart {v | v.1.1 ⊆ Hc} hAH (fun h => by
    obtain ⟨b, hb'⟩ := hB.nonempty
    exact (hBH hb').2 (h hb'))
  obtain ⟨hne', w, hw1, hw2⟩ := d.adj
  have hY : d.snd.1.1 ⊆ O \ Hc :=
    (hside _ d.snd.1.2 fun h => d.snd.2 (Subtype.ext h)).resolve_left hd2
  exact Set.disjoint_left.mp hsep (closure_mono hd1 hw1) (closure_mono hY hw2)

end ArcMap

/-! ### The holed fragment (`exists_holed_valid_fragment`'s object) -/

/-- A preconnected set whose norms avoid `[a, b]` lies on one side of it, the side of any of its points. -/
theorem norm_side_of_isPreconnected {S : Set ℂ} (hS : IsPreconnected S) {a b : ℝ} (hab : a ≤ b)
    (havoid : ∀ z ∈ S, ‖z‖ < a ∨ b < ‖z‖) {z₀ : ℂ} (hz₀ : z₀ ∈ S) :
    (‖z₀‖ < a → ∀ z ∈ S, ‖z‖ < a) ∧ (b < ‖z₀‖ → ∀ z ∈ S, b < ‖z‖) := by
  have hI := hS.image (fun z : ℂ => ‖z‖) continuous_norm.continuousOn
  constructor
  · intro h0 z hz
    by_contra hz'
    push Not at hz'
    obtain ⟨w, hw, hwa⟩ := hI.Icc_subset (mem_image_of_mem _ hz₀) (mem_image_of_mem _ hz) ⟨h0.le, hz'⟩
    rcases havoid w hw with h | h <;> simp only at hwa <;> linarith
  · intro h0 z hz
    by_contra hz'
    push Not at hz'
    obtain ⟨w, hw, hwb⟩ := hI.Icc_subset (mem_image_of_mem _ hz) (mem_image_of_mem _ hz₀) ⟨hz', h0.le⟩
    rcases havoid w hw with h | h <;> simp only at hwb <;> linarith

/-- A point of norm `ρ > 0` lies on the full circle `circ 0 ρ 0 (2π)`. -/
theorem mem_carrier_circ_of_norm {ρ : ℝ} {z : ℂ} (hz : ‖z‖ = ρ) : z ∈ (Arc.circ 0 ρ 0 (2 * π)).carrier := by
  have hpol : z = (ρ : ℂ) * e (Complex.arg z) := by
    rw [← hz]; exact (Complex.norm_mul_exp_arg_mul_I z).symm
  rcases le_or_gt 0 (Complex.arg z) with h | h
  · exact ⟨Complex.arg z, ⟨h, by linarith [Complex.arg_le_pi z, Real.pi_pos]⟩, by
      show (0 : ℂ) + (ρ : ℂ) * e (Complex.arg z) = z; rw [zero_add, ← hpol]⟩
  · refine ⟨Complex.arg z + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg z], by linarith⟩, ?_⟩
    show (0 : ℂ) + (ρ : ℂ) * e (Complex.arg z + 2 * π) = z
    rw [zero_add, e_add_two_pi, ← hpol]

/-- The points of `circ 0 ρ θ₀ θ₁` have norm `ρ` (`ρ ≥ 0`). -/
theorem norm_of_mem_carrier_circ {ρ θ₀ θ₁ : ℝ} (hρ : 0 ≤ ρ) {z : ℂ} (hz : z ∈ (Arc.circ 0 ρ θ₀ θ₁).carrier) : ‖z‖ = ρ := by
  obtain ⟨θ, -, rfl⟩ := hz
  show ‖(0 : ℂ) + (ρ : ℂ) * e θ‖ = ρ
  rw [zero_add, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hρ]

/-- The points of the radial segment `seg (u/2) (3u/5)` (`‖u‖ = 1`) have norm in `[1/2, 3/5]`. -/
theorem norm_of_mem_carrier_radial {u z : ℂ} (hu : ‖u‖ = 1) (hz : z ∈ (Arc.seg ((1 / 2 : ℝ) * u) ((3 / 5 : ℝ) * u)).carrier) :
    1 / 2 ≤ ‖z‖ := by
  obtain ⟨a, b, ha, hb, hab, rfl⟩ := hz
  have : a • ((1 / 2 : ℝ) * u) + b • ((3 / 5 : ℝ) * u) = ((a / 2 + 3 * b / 5 : ℝ) : ℂ) * u := by
    simp only [Complex.real_smul]; push_cast; ring
  rw [this, norm_mul, hu, mul_one, Complex.norm_real, Real.norm_of_nonneg (by positivity)]
  linarith

/-- A point `t u` with `‖u‖ = 1`, `t ∈ [1/2, 3/5]`, lies on the radial segment `seg (u/2) (3u/5)`. -/
theorem mem_carrier_radial {u : ℂ} {t : ℝ} (ht : 1 / 2 ≤ t) (ht' : t ≤ 3 / 5) :
    (t : ℂ) * u ∈ (Arc.seg ((1 / 2 : ℝ) * u) ((3 / 5 : ℝ) * u)).carrier := by
  refine ⟨(3 / 5 - t) * 10, (t - 1 / 2) * 10, by linarith, by linarith, by ring, ?_⟩
  simp only [Complex.real_smul]; push_cast; ring

/-- The holed fragment's arcs: the circles of radii `1/4` and `1/2` about `0`, and four radial segments from radius `1/2` to `3/5` on the
axes. -/
noncomputable def holedArcs : Set Arc :=
  {.circ 0 (1 / 4) 0 (2 * π), .circ 0 (1 / 2) 0 (2 * π), .seg ((1 / 2 : ℝ) * 1) ((3 / 5 : ℝ) * 1),
    .seg ((1 / 2 : ℝ) * (-1)) ((3 / 5 : ℝ) * (-1)), .seg ((1 / 2 : ℝ) * I) ((3 / 5 : ℝ) * I),
    .seg ((1 / 2 : ℝ) * (-I)) ((3 / 5 : ℝ) * (-I))}

/-- The holed fragment's colour: `2` on the disc `|z| < 1/4`, `1` on the annulus `1/4 ≤ |z| < 1/2`, and outside it one colour per open
quadrant (`3`, `4`, `5`, `0`). -/
noncomputable def holedCol (z : ℂ) : Fin 6 :=
  if ‖z‖ < 1 / 4 then 2 else if ‖z‖ < 1 / 2 then 1 else
    if 0 < z.re then (if 0 < z.im then 3 else 0) else (if 0 < z.im then 4 else 5)

/-- A spec example for `holedCol`: the centre has colour `2`, the point `3/8` colour `1`. -/
example : holedCol 0 = 2 ∧ holedCol (3 / 8) = 1 := by
  constructor
  · simp [holedCol]
  · have h : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
      rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
    simp only [holedCol, h]; norm_num

/-- Membership in the holed fragment's arcs, by norm: a point on an arc has norm `1/4` or at least `1/2`. -/
theorem norm_of_mem_holedArcs {z : ℂ} (hz : z ∈ ⋃ a ∈ holedArcs, a.carrier) : ‖z‖ = 1 / 4 ∨ 1 / 2 ≤ ‖z‖ := by
  simp only [mem_iUnion, holedArcs, mem_insert_iff, mem_singleton_iff, exists_prop] at hz
  obtain ⟨a, ha, hza⟩ := hz
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl
  · exact Or.inl (norm_of_mem_carrier_circ (by norm_num) hza)
  · exact Or.inr (norm_of_mem_carrier_circ (by norm_num) hza).ge
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)

/-- Off the holed fragment's arcs, within `3/5`: the norm is not `1/4` or `1/2`, and beyond `1/2` neither coordinate vanishes. -/
theorem holed_off_arcs {z : ℂ} (hd : ‖z‖ < 3 / 5) (hz : z ∉ ⋃ a ∈ holedArcs, a.carrier) :
    ‖z‖ ≠ 1 / 4 ∧ ‖z‖ ≠ 1 / 2 ∧ (1 / 2 < ‖z‖ → z.re ≠ 0 ∧ z.im ≠ 0) := by
  have hmem : ∀ a ∈ holedArcs, z ∉ a.carrier := fun a ha h => hz (mem_biUnion ha h)
  refine ⟨fun h => hmem _ (by simp [holedArcs]) (mem_carrier_circ_of_norm h),
    fun h => hmem _ (by simp [holedArcs]) (mem_carrier_circ_of_norm h), fun h => ⟨fun hre => ?_, fun him => ?_⟩⟩
  · -- on the imaginary axis
    obtain ⟨t, rfl⟩ : ∃ t : ℝ, z = (t : ℂ) * I := ⟨z.im, by apply Complex.ext <;> simp [hre]⟩
    have hn : ‖(t : ℂ) * I‖ = |t| := by rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hn] at h hd
    rcases le_or_gt 0 t with h0 | h0
    · rw [abs_of_nonneg h0] at h hd
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := I) (by linarith) (by linarith))
    · rw [abs_of_neg h0] at h hd
      have : (t : ℂ) * I = ((-t : ℝ) : ℂ) * (-I) := by push_cast; ring
      rw [this] at hmem
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := -I) (by linarith) (by linarith))
  · -- on the real axis
    obtain ⟨t, rfl⟩ : ∃ t : ℝ, z = (t : ℂ) * 1 := ⟨z.re, by apply Complex.ext <;> simp [him]⟩
    have hn : ‖(t : ℂ) * 1‖ = |t| := by rw [mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hn] at h hd
    rcases le_or_gt 0 t with h0 | h0
    · rw [abs_of_nonneg h0] at h hd
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := 1) (by linarith) (by linarith))
    · rw [abs_of_neg h0] at h hd
      have : (t : ℂ) * 1 = ((-t : ℝ) : ℂ) * (-1) := by push_cast; ring
      rw [this] at hmem
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := -1) (by linarith) (by linarith))

/-- **The holed fragment** (CVB B1's configuration): the disc `|z| < 1/4` of colour `2` inside the annulus `1/4 < |z| < 1/2` of colour `1`,
ringed by four quarter-annuli `1/2 < |z| < 3/5` of colours `3`, `4`, `5`, `0`; domain `B(0, 3/5)`. -/
noncomputable def holedFrag : ArcMap 6 where
  dom := ball 0 (3 / 5)
  isOpen_dom := isOpen_ball
  arcs := holedArcs
  nondegenerate := by
    intro a ha
    simp only [holedArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl | rfl <;> simp only [Arc.Nondegenerate]
    · exact ⟨by norm_num, by positivity, by linarith⟩
    · exact ⟨by norm_num, by positivity, by linarith⟩
    all_goals
      intro h
      have := congrArg (fun w : ℂ => ‖w‖) h
      simp only [norm_mul, Complex.norm_real, norm_neg, Complex.norm_I, norm_one] at this
      norm_num at this
  locallyFinite := by
    intro x _
    refine ⟨univ, univ_mem, ?_⟩
    refine Set.Finite.subset ?_ (fun a ha => ha.1)
    simp only [holedArcs]
    exact ((((((Set.finite_singleton _).insert _).insert _).insert _).insert _).insert _)
  col := holedCol
  locallyConstant := by
    intro x hx hxa
    have hd : ‖x‖ < 3 / 5 := by simpa using hx
    obtain ⟨h4, h2, hax⟩ := holed_off_arcs hd hxa
    have hcn := continuous_norm.tendsto x
    rcases lt_or_gt_of_ne h4 with hlt | hgt
    · filter_upwards [hcn.eventually (gt_mem_nhds hlt)] with y hy
      simp only [holedCol, if_pos hy, if_pos hlt]
    rcases lt_or_gt_of_ne h2 with hlt2 | hgt2
    · filter_upwards [hcn.eventually (lt_mem_nhds hgt), hcn.eventually (gt_mem_nhds hlt2)] with y hy hy'
      simp only [holedCol, if_neg (not_lt.mpr hy.le), if_pos hy', if_neg (not_lt.mpr hgt.le), if_pos hlt2]
    obtain ⟨hre, him⟩ := hax hgt2
    have hre' : ∀ᶠ y in 𝓝 x, (0 < y.re ↔ 0 < x.re) := by
      rcases lt_or_gt_of_ne hre with h | h
      · filter_upwards [(Complex.continuous_re.tendsto x).eventually (gt_mem_nhds h)] with y hy
        exact ⟨fun h' => by linarith, fun h' => by linarith⟩
      · filter_upwards [(Complex.continuous_re.tendsto x).eventually (lt_mem_nhds h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    have him' : ∀ᶠ y in 𝓝 x, (0 < y.im ↔ 0 < x.im) := by
      rcases lt_or_gt_of_ne him with h | h
      · filter_upwards [(Complex.continuous_im.tendsto x).eventually (gt_mem_nhds h)] with y hy
        exact ⟨fun h' => by linarith, fun h' => by linarith⟩
      · filter_upwards [(Complex.continuous_im.tendsto x).eventually (lt_mem_nhds h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    filter_upwards [hcn.eventually (lt_mem_nhds hgt2), hre', him'] with y hy hyr hyi
    have h1 : ¬ ‖y‖ < 1 / 4 := by linarith
    have h1' : ¬ ‖y‖ < 1 / 2 := by linarith
    have h3 : ¬ ‖x‖ < 1 / 4 := by linarith
    have h3' : ¬ ‖x‖ < 1 / 2 := by linarith
    simp only [holedCol, if_neg h1, if_neg h1', if_neg h3, if_neg h3', hyr, hyi]

/-- Two points of norm below `3/5` whose coordinates agree in sign (weakly) are less than `1` apart. -/
theorem dist_lt_one_of_same_quadrant {x y : ℂ} (hx : ‖x‖ < 3 / 5) (hy : ‖y‖ < 3 / 5) (hre : 0 ≤ x.re * y.re)
    (him : 0 ≤ x.im * y.im) : dist x y < 1 := by
  have hx2 : x.re ^ 2 + x.im ^ 2 < 9 / 25 := by
    have := Complex.sq_norm x; rw [Complex.normSq_apply] at this; nlinarith [norm_nonneg x]
  have hy2 : y.re ^ 2 + y.im ^ 2 < 9 / 25 := by
    have := Complex.sq_norm y; rw [Complex.normSq_apply] at this; nlinarith [norm_nonneg y]
  have hd : dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    rw [dist_eq_norm, Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.sub_im]; ring
  nlinarith [dist_nonneg (x := x) (y := y)]

/-- The holed fragment is valid: each colour class is one piece of diameter below `1`. -/
theorem holedFrag_valid : holedFrag.Valid := by
  intro x hx y hy hxy hcol
  have hxd : ‖x‖ < 3 / 5 := by simpa [holedFrag] using hx.1
  have hyd : ‖y‖ < 3 / 5 := by simpa [holedFrag] using hy.1
  change holedCol x = holedCol y at hcol
  have hlt : dist x y < 1 := by
    unfold holedCol at hcol
    split_ifs at hcol with a1 a2 a3 a4 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 <;>
      first
      | exact absurd hcol (by decide)
      | (rw [dist_eq_norm]; linarith [norm_sub_le x y, norm_neg y])
      | (apply dist_lt_one_of_same_quadrant hxd hyd <;> nlinarith)
  linarith

/-- A spec example for `holedArcs` and `holedFrag`: the inner circle is an arc, the centre has colour `2`, the domain is `B(0, 3/5)`. -/
example : Arc.circ 0 (1 / 4) 0 (2 * π) ∈ holedArcs ∧ holedFrag.col 0 = 2 ∧ holedFrag.dom = ball 0 (3 / 5) :=
  ⟨by simp [holedArcs], by simp [holedFrag, holedCol], rfl⟩

/-- The open annulus `1/4 < |z| < 1/2` is preconnected (the image of a band under polar coordinates). -/
theorem isPreconnected_holedAnnulus : IsPreconnected {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} := by
  have h : {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} = (fun p : ℝ × ℝ => (p.1 : ℂ) * e p.2) '' (Ioo (1 / 4) (1 / 2) ×ˢ univ) := by
    ext z
    constructor
    · rintro ⟨h1, h2⟩
      exact ⟨(‖z‖, Complex.arg z), ⟨⟨h1, h2⟩, mem_univ _⟩, Complex.norm_mul_exp_arg_mul_I z⟩
    · rintro ⟨⟨r, θ⟩, ⟨⟨h1, h2⟩, -⟩, rfl⟩
      have : ‖(r : ℂ) * e θ‖ = r := by rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
      simp only [mem_setOf_eq, this]; exact ⟨h1, h2⟩
  rw [h]
  exact (isPreconnected_Ioo.prod isPreconnected_univ).image _ (by unfold e; fun_prop)

/-- **Holes are locally consistent with validity** (FS114-CVB-PINCH's last clause, CVB B1's counterexample configuration): there is a valid
six-coloured fragment covering `B̄(0, 1/2)` with a tile that has a hole — the annulus `1/4 < |z| < 1/2` of colour `1` about the disc
`|z| < 1/4` of colour `2`, ringed by four quarter-annuli `1/2 < |z| < 3/5` of colours `3, 4, 5, 6 = 0` (`holedFrag`). -/
theorem exists_holed_valid_fragment :
    ∃ F : ArcMap 6, F.Valid ∧ F.Covers 0 (1 / 2) ∧ ∃ T Hc, F.IsTile T ∧ ArcMap.IsHoleOf T Hc := by
  set A : Set ℂ := {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} with hA
  have hint : ∀ z ∈ holedFrag.interiorPts, ‖z‖ ≠ 1 / 4 ∧ ‖z‖ ≠ 1 / 2 := by
    intro z hz
    have hd : ‖z‖ < 3 / 5 := by simpa [holedFrag] using hz.1
    obtain ⟨h1, h2, -⟩ := holed_off_arcs hd hz.2
    exact ⟨h1, h2⟩
  have hAint : A ⊆ holedFrag.interiorPts := by
    rintro z ⟨h1, h2⟩
    refine ⟨show z ∈ ball (0 : ℂ) (3 / 5) by rw [mem_ball, dist_zero_right]; linarith, fun hz => ?_⟩
    rcases norm_of_mem_holedArcs hz with h | h <;> linarith
  have h38 : (3 / 8 : ℂ) ∈ A := by
    have : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
      rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
    simp only [hA, mem_setOf_eq, this]; norm_num
  have hn38 : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
    rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
  -- the tile through `3/8` is the annulus
  have hT : A = connectedComponentIn holedFrag.interiorPts (3 / 8) := by
    apply Set.Subset.antisymm (isPreconnected_holedAnnulus.subset_connectedComponentIn h38 hAint)
    intro z hz
    have hC := isPreconnected_connectedComponentIn (x := (3 / 8 : ℂ)) (F := holedFrag.interiorPts)
    have hCsub := connectedComponentIn_subset holedFrag.interiorPts (3 / 8 : ℂ)
    have hmem := mem_connectedComponentIn (hAint h38)
    have hlo := (norm_side_of_isPreconnected hC le_rfl (a := 1 / 4) (fun w hw => lt_or_gt_of_ne (hint w (hCsub hw)).1)
      hmem).2 (by rw [hn38]; norm_num) z hz
    have hhi := (norm_side_of_isPreconnected hC le_rfl (a := 1 / 2) (fun w hw => lt_or_gt_of_ne (hint w (hCsub hw)).2)
      hmem).1 (by rw [hn38]; norm_num) z hz
    exact ⟨hlo, hhi⟩
  -- the closure of the annulus is the closed annulus
  have hclsub : closure A ⊆ {z : ℂ | 1 / 4 ≤ ‖z‖ ∧ ‖z‖ ≤ 1 / 2} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le continuous_const continuous_norm).inter (isClosed_le continuous_norm continuous_const))
  have hclsup : ∀ z : ℂ, 1 / 4 ≤ ‖z‖ → ‖z‖ ≤ 1 / 2 → z ∈ closure A := by
    intro z h1 h2
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min 1 ε with hs
    have hs0 : 0 < s := lt_min one_pos hε
    have hs1 : s ≤ 1 := min_le_left _ _
    have hsε : s ≤ ε := min_le_right _ _
    have hz0 : 0 < ‖z‖ := by linarith
    set c : ℝ := 1 - s + 3 * s / (8 * ‖z‖) with hc
    have hc0 : 0 < c := by
      have : 0 < 3 * s / (8 * ‖z‖) := by positivity
      rw [hc]; linarith
    have hnb : ‖(c : ℂ) * z‖ = (1 - s) * ‖z‖ + 3 * s / 8 := by
      rw [norm_mul, Complex.norm_real, Real.norm_of_nonneg hc0.le, hc]; field_simp
    refine ⟨(c : ℂ) * z, ⟨?_, ?_⟩, ?_⟩
    · rw [hnb]; nlinarith
    · rw [hnb]; nlinarith
    · have : dist z ((c : ℂ) * z) = |1 - c| * ‖z‖ := by
        rw [dist_eq_norm, show z - (c : ℂ) * z = ((1 - c : ℝ) : ℂ) * z by push_cast; ring, norm_mul, Complex.norm_real,
          Real.norm_eq_abs]
      have h8 : (1 - c) * ‖z‖ = s * (‖z‖ - 3 / 8) := by rw [hc]; field_simp; ring
      rw [this, show |1 - c| * ‖z‖ = |(1 - c) * ‖z‖| by rw [abs_mul, abs_of_pos hz0], h8, abs_mul, abs_of_pos hs0]
      have hab : |‖z‖ - 3 / 8| ≤ 1 / 8 := abs_le.mpr ⟨by linarith, by linarith⟩
      nlinarith [abs_nonneg (‖z‖ - 3 / 8)]
  -- the complement of the closed annulus, and its components
  have havoid : ∀ z ∈ (closure A)ᶜ, ‖z‖ < 1 / 4 ∨ 1 / 2 < ‖z‖ := by
    intro z hz
    by_contra h
    push Not at h
    exact hz (hclsup z h.1 h.2)
  have hside : ∀ z ∈ (closure A)ᶜ, (‖z‖ < 1 / 4 → connectedComponentIn (closure A)ᶜ z ⊆ ball 0 (1 / 4)) ∧
      (1 / 2 < ‖z‖ → connectedComponentIn (closure A)ᶜ z ⊆ {w | 1 / 2 < ‖w‖}) := by
    intro z hz
    have hsub := connectedComponentIn_subset (closure A)ᶜ z
    obtain ⟨h1, h2⟩ := norm_side_of_isPreconnected isPreconnected_connectedComponentIn (by norm_num : (1 / 4 : ℝ) ≤ 1 / 2)
      (fun w hw => havoid w (hsub hw)) (mem_connectedComponentIn hz)
    exact ⟨fun h w hw => by rw [mem_ball, dist_zero_right]; exact h1 h w hw, fun h w hw => h2 h w hw⟩
  have h0 : (0 : ℂ) ∈ (closure A)ᶜ := fun h => by have := (hclsub h).1; simp at this; linarith
  have hHc := (hside 0 h0).1 (by simp)
  -- the disc `|z| < 1/4` lies in the hole (preconnected, off `cl A`, through `0`)
  have hball : ball (0 : ℂ) (1 / 4) ⊆ connectedComponentIn (closure A)ᶜ 0 :=
    (convex_ball (0 : ℂ) (1 / 4)).isPreconnected.subset_connectedComponentIn (mem_ball_self (by norm_num))
      (fun w hw hwA => by
        have := (hclsub hwA).1
        rw [mem_ball, dist_zero_right] at hw
        linarith)
  -- the rest of the complement lies beyond `1/2`
  have hrest : (closure A)ᶜ \ connectedComponentIn (closure A)ᶜ 0 ⊆ {w : ℂ | 1 / 2 < ‖w‖} := by
    rintro w ⟨hw, hwn⟩
    rcases havoid w hw with h | h
    · exact absurd (hball (by rw [mem_ball, dist_zero_right]; exact h)) hwn
    · exact h
  refine ⟨holedFrag, holedFrag_valid, fun z hz => ?_, A, connectedComponentIn (closure A)ᶜ 0, ⟨3 / 8, hAint h38, hT⟩,
    ⟨0, mem_connectedComponentIn h0⟩, connectedComponentIn_subset _ _, Metric.isBounded_ball.subset hHc, ?_⟩
  · show z ∈ ball (0 : ℂ) (3 / 5)
    rw [mem_closedBall] at hz; rw [mem_ball]; linarith
  · have hc1 : closure (connectedComponentIn (closure A)ᶜ 0) ⊆ closedBall 0 (1 / 4) :=
      (closure_mono hHc).trans (closure_ball_subset_closedBall)
    have hc2 : closure ((closure A)ᶜ \ connectedComponentIn (closure A)ᶜ 0) ⊆ {w : ℂ | 1 / 2 ≤ ‖w‖} :=
      closure_minimal (fun w hw => show 1 / 2 ≤ ‖w‖ from (show 1 / 2 < ‖w‖ from hrest hw).le)
        (isClosed_le continuous_const continuous_norm)
    refine Set.disjoint_left.mpr fun w hw1 hw2 => ?_
    have := hc1 hw1
    have := hc2 hw2
    simp only [mem_closedBall, dist_zero_right, mem_setOf_eq] at *
    linarith

end HadwigerNelson.Plane
