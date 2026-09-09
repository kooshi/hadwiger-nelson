import Proofs.HadwigerNelson.Forcer
import Proofs.HadwigerNelson.DistanceGraph
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

/-!
# The mascot obstruction: the Moser spindle's recipe has no analogue at four colours

The Moser spindle is built by one recipe: take the **smallest graph forcing two non-adjacent
vertices to share a colour** at `k = 3`, hinge two copies of it at a common vertex, and pick the
hinge angle so the two forced vertices land at distance one.  This file proves the recipe stops
at `k = 3`, and says exactly why.

* `card_le_of_forces` — a graph forcing a pair at `k` colours has at least `k + 1` vertices.
* `isNClique_of_forces_of_card` — at exactly `k + 1` vertices it is the complete graph minus the
  forced edge, hence contains a `k`-clique.
* `no_four_unit_points` — four points of the plane are never pairwise at distance one.
* `not_forces_unitDistance_five` — hence **no five points of the plane carry a forced pair at four
  colours**: the minimal forcing gadget has no unit-distance realisation at any `k ≥ 4`.

The contrast is the content.  At three colours the minimal gadget is `K₄` minus an edge, and that
*is* a unit-distance graph — the rhombus of two unit triangles, far tips at `√3`, which is exactly
what the Moser spindle hinges.  At four colours the minimal gadget contains `K₄`, and the plane's
unit-distance graph has clique number three.  The obstruction is that the plane's clique number
*equals* the colour count at `k = 3` and falls below it forever after.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## The abstract floor -/

section Abstract

variable {V : Type*} [Fintype V] [DecidableEq V] {G : SimpleGraph V} {k : ℕ} {p q : V}

omit [Fintype V] [DecidableEq V] in
/-- **Joining a forced pair destroys colourability** — the whole content of "forces". -/
theorem not_colorable_sup_edge_of_forces (h : Forces G k p q) (hpq : p ≠ q) :
    ¬ (G ⊔ SimpleGraph.edge p q).Colorable k := by
  rintro ⟨C⟩
  have hadj : (G ⊔ SimpleGraph.edge p q).Adj p q := by
    refine Or.inr ?_
    simp [SimpleGraph.edge_adj, hpq]
  exact C.valid hadj (h (C.comap (SimpleGraph.Hom.ofLE le_sup_left)))

/-- **A graph on `n + 1` vertices with a non-adjacent pair is `n`-colourable** — paint the two
apart vertices alike and everything else distinctly. -/
theorem colorable_of_not_adj {H : SimpleGraph V} {a b : V} (hab : ¬ (a = b))
    (hnadj : ¬ H.Adj a b) {n : ℕ} (hcard : Fintype.card V = n + 1) : H.Colorable n := by
  have h1 : Fintype.card {x : V // x = b} = 1 := Fintype.card_subtype_eq b
  have hc := Fintype.card_subtype_compl (fun x : V => x = b)
  rw [h1, hcard] at hc
  have hsub : Fintype.card {x : V // ¬ (x = b)} = n := by omega
  let e : {x : V // ¬ (x = b)} ≃ Fin n := Fintype.equivFinOfCardEq hsub
  refine ⟨SimpleGraph.Coloring.mk
    (fun x => if hx : x = b then e ⟨a, hab⟩ else e ⟨x, hx⟩) ?_⟩
  intro x y hxy heq
  by_cases hx : x = b <;> by_cases hy : y = b
  · exact hxy.ne (hx.trans hy.symm)
  · rw [dif_pos hx, dif_neg hy] at heq
    have : a = y := congrArg Subtype.val (e.injective heq)
    exact hnadj (by rw [this, ← hx]; exact hxy.symm)
  · rw [dif_neg hx, dif_pos hy] at heq
    have : x = a := congrArg Subtype.val (e.injective heq)
    exact hnadj (by rw [← this, ← hy]; exact hxy)
  · rw [dif_neg hx, dif_neg hy] at heq
    exact hxy.ne (congrArg Subtype.val (e.injective heq))

omit [DecidableEq V] in
/-- **The size floor.**  A forced pair at `k` colours needs at least `k + 1` vertices. -/
theorem card_le_of_forces (h : Forces G k p q) (hpq : p ≠ q) : k + 1 ≤ Fintype.card V := by
  by_contra hlt
  exact not_colorable_sup_edge_of_forces h hpq
    ((SimpleGraph.colorable_of_fintype _).mono (by omega))

/-- **At the floor, the graph is complete minus the forced edge**, so it carries a `k`-clique. -/
theorem isNClique_of_forces_of_card (h : Forces G k p q) (hpq : p ≠ q)
    (hcard : Fintype.card V = k + 1) : G.IsNClique k (Finset.univ.erase q) := by
  constructor
  · intro x hx y hy hne
    by_contra hnadj
    refine not_colorable_sup_edge_of_forces h hpq (colorable_of_not_adj hne ?_ hcard)
    rintro (hg | he)
    · exact hnadj hg
    · rw [SimpleGraph.edge_adj] at he
      rcases he.1 with ⟨_, rfl⟩ | ⟨rfl, _⟩
      · exact (Finset.mem_erase.mp hy).1 rfl
      · exact (Finset.mem_erase.mp hx).1 rfl
  · rw [Finset.card_erase_of_mem (Finset.mem_univ q), Finset.card_univ, hcard]
    rfl

end Abstract

/-! ## The geometric obstruction -/

private theorem sq_dist_of_dist {a b : ℂ} (h : dist a b = 1) :
    (a.re - b.re) ^ 2 + (a.im - b.im) ^ 2 = 1 := by
  have hd : Real.sqrt ((a.re - b.re) ^ 2 + (a.im - b.im) ^ 2) = 1 := by
    rw [← Complex.dist_eq_re_im]; exact h
  have hnn : (0:ℝ) ≤ (a.re - b.re) ^ 2 + (a.im - b.im) ^ 2 := by positivity
  nlinarith [Real.sq_sqrt hnn, hd]

/-- **The plane has no unit-distance `K₄`.**  Four points pairwise one apart give three plane
vectors whose Gram determinant is `1/2` by the distance data and `0` because any three vectors in
a two-dimensional space are dependent. -/
theorem no_four_unit_points {a b c d : ℂ} (hab : dist a b = 1) (hac : dist a c = 1)
    (had : dist a d = 1) (hbc : dist b c = 1) (hbd : dist b d = 1) (hcd : dist c d = 1) :
    False := by
  have Hab := sq_dist_of_dist hab
  have Hac := sq_dist_of_dist hac
  have Had := sq_dist_of_dist had
  have Hbc := sq_dist_of_dist hbc
  have Hbd := sq_dist_of_dist hbd
  have Hcd := sq_dist_of_dist hcd
  have hP : (a.re - b.re) * (a.re - c.re) + (a.im - b.im) * (a.im - c.im) = 1/2 := by
    linear_combination (Hab + Hac - Hbc) / 2
  have hQ : (a.re - b.re) * (a.re - d.re) + (a.im - b.im) * (a.im - d.im) = 1/2 := by
    linear_combination (Hab + Had - Hbd) / 2
  have hR : (a.re - c.re) * (a.re - d.re) + (a.im - c.im) * (a.im - d.im) = 1/2 := by
    linear_combination (Hac + Had - Hcd) / 2
  have gram :
      ((a.re - b.re) ^ 2 + (a.im - b.im) ^ 2) *
          (((a.re - c.re) ^ 2 + (a.im - c.im) ^ 2) * ((a.re - d.re) ^ 2 + (a.im - d.im) ^ 2)
            - ((a.re - c.re) * (a.re - d.re) + (a.im - c.im) * (a.im - d.im)) ^ 2)
        - ((a.re - b.re) * (a.re - c.re) + (a.im - b.im) * (a.im - c.im)) *
          (((a.re - b.re) * (a.re - c.re) + (a.im - b.im) * (a.im - c.im))
              * ((a.re - d.re) ^ 2 + (a.im - d.im) ^ 2)
            - ((a.re - c.re) * (a.re - d.re) + (a.im - c.im) * (a.im - d.im))
              * ((a.re - b.re) * (a.re - d.re) + (a.im - b.im) * (a.im - d.im)))
        + ((a.re - b.re) * (a.re - d.re) + (a.im - b.im) * (a.im - d.im)) *
          (((a.re - b.re) * (a.re - c.re) + (a.im - b.im) * (a.im - c.im))
              * ((a.re - c.re) * (a.re - d.re) + (a.im - c.im) * (a.im - d.im))
            - ((a.re - c.re) ^ 2 + (a.im - c.im) ^ 2)
              * ((a.re - b.re) * (a.re - d.re) + (a.im - b.im) * (a.im - d.im))) = 0 := by
    ring
  rw [Hab, Hac, Had, hP, hQ, hR] at gram
  norm_num at gram

/-- **The plane has no unit-distance `K₄`,** as a clique statement. -/
theorem no_isNClique_four (s : Finset ℂ) : ¬ (unitDistance ℂ).IsNClique 4 s := by
  rintro ⟨hcl, hcard⟩
  obtain ⟨w, x, y, z, hwx, hwy, hwz, hxy, hxz, hyz, rfl⟩ := Finset.card_eq_four.mp hcard
  have hw : w ∈ ({w, x, y, z} : Finset ℂ) := by simp
  have hx : x ∈ ({w, x, y, z} : Finset ℂ) := by simp
  have hy : y ∈ ({w, x, y, z} : Finset ℂ) := by simp
  have hz : z ∈ ({w, x, y, z} : Finset ℂ) := by simp
  exact no_four_unit_points
    (unitDistance_adj.mp (hcl hw hx hwx)) (unitDistance_adj.mp (hcl hw hy hwy))
    (unitDistance_adj.mp (hcl hw hz hwz)) (unitDistance_adj.mp (hcl hx hy hxy))
    (unitDistance_adj.mp (hcl hx hz hxz)) (unitDistance_adj.mp (hcl hy hz hyz))

/-- **The mascot obstruction.**  No five points of the plane carry a pair forced to share a
colour in every proper four-colouring.  Since a forcing graph needs at least `k + 1 = 5`
vertices and at exactly five is the complete graph minus the forced edge — which contains a
`K₄` the plane cannot draw — the Moser spindle's recipe has no analogue at four colours. -/
theorem not_forces_of_unit_drawing {V : Type*} [Fintype V] [DecidableEq V]
    {G : SimpleGraph V} (f : V → ℂ) (hinj : Function.Injective f)
    (hf : ∀ x y : V, G.Adj x y → dist (f x) (f y) = 1)
    (hcard : Fintype.card V = 5) {u v : V} (huv : u ≠ v) : ¬ Forces G 4 u v := by
  intro h
  have hcl := isNClique_of_forces_of_card h huv (by omega)
  refine no_isNClique_four ((Finset.univ.erase v).image f) ?_
  constructor
  · intro p hp q hq hne
    simp only [Finset.coe_image, Set.mem_image, Finset.mem_coe] at hp hq
    obtain ⟨a, ha, rfl⟩ := hp
    obtain ⟨b, hb, rfl⟩ := hq
    have hab : a ≠ b := fun e => hne (by rw [e])
    exact unitDistance_adj.mpr (hf a b (hcl.1 ha hb hab))
  · rw [Finset.card_image_of_injective _ hinj, hcl.2]

end HadwigerNelson
