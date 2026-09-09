import Proofs.HadwigerNelson.Forcer
import Proofs.HadwigerNelson.DistanceGraph
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

/-!
# The mascot obstruction: where the Moser spindle's recipe stops, and why

The Moser spindle is built by one recipe: take the **smallest graph forcing two non-adjacent
vertices to share a colour** at `k` colours, hinge two copies of it at a common vertex, and pick
the hinge angle so the two forced vertices land at distance one.  This file locates the recipe's
threshold exactly — it works at `k ≤ 3` and at no `k` above — and names the invariant that puts
it there.

## The abstract floor

* `card_le_of_forces` — a graph forcing a pair at `k` colours has at least `k + 1` vertices.
* `isNClique_of_forces_of_card` — at exactly `k + 1` vertices it is the complete graph minus the
  forced edge, hence contains a `k`-clique.

## The obstruction, host-generic

* `not_forces_of_drawing` — **a host graph with no `k`-clique draws no minimal forcing gadget at
  `k` colours.**  The clique number is the whole hypothesis; nothing here is geometric.

## The plane

* `no_four_unit_points` / `no_isNClique_of_four_le` — the plane's unit-distance graph has clique
  number three.
* `not_forces_of_unit_drawing` — hence **no `k + 1` points of the plane carry a pair forced at `k`
  colours, for any `k ≥ 4`**.
* `exists_forces_of_unit_drawing_three` — and at `k = 3` they do: the rhombus, two unit triangles
  on a shared edge, is the minimal gadget drawn.

The threshold is therefore sharp, and the reason is a comparison of two numbers: the plane's
clique number *equals* the colour count at `k = 3` and falls below it forever after.  Below that
line forcing is local, free, and four points wide; above it no counting argument forces anything
and every compulsion is global — which is why the Moser spindle is seven vertices and every
5-chromatic unit-distance graph ever built is five hundred and needed a computer.
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

/-! ## The obstruction, host-generic

Nothing below the plane's own clique bound is geometric: a drawing is an injective homomorphism,
an injective homomorphism carries cliques forward, and the minimal forcing gadget carries a
`k`-clique.  So the recipe's threshold in *any* host is that host's clique number. -/

section Host

variable {V W : Type*} [Fintype V] [DecidableEq V] [DecidableEq W]
  {G : SimpleGraph V} {H : SimpleGraph W} {k : ℕ}

omit [Fintype V] [DecidableEq V] in
/-- **An injective homomorphism carries a clique forward.**  Weaker hypotheses than a graph
embedding: adjacency need only be preserved, never reflected — which is exactly what a drawing
of an abstract graph in the plane gives. -/
theorem isNClique_image (f : V → W) (hinj : Function.Injective f)
    (hf : ∀ x y : V, G.Adj x y → H.Adj (f x) (f y))
    {n : ℕ} {s : Finset V} (hs : G.IsNClique n s) : H.IsNClique n (s.image f) := by
  constructor
  · intro p hp q hq hne
    simp only [Finset.coe_image, Set.mem_image, Finset.mem_coe] at hp hq
    obtain ⟨a, ha, rfl⟩ := hp
    obtain ⟨b, hb, rfl⟩ := hq
    exact hf a b (hs.1 ha hb (fun e => hne (by rw [e])))
  · rw [Finset.card_image_of_injective _ hinj, hs.2]

/-- **The mascot obstruction, host-generic.**  A host graph with no `k`-clique draws no minimal
forcing gadget at `k` colours: any drawn graph on at most `k + 1` vertices forces no pair.

Both hypotheses on the size are used and neither is slack — below `k + 1` vertices forcing is
impossible outright (`card_le_of_forces`), and at exactly `k + 1` the gadget is `K_{k+1}` minus
the forced edge, whose `k`-clique the host cannot hold. -/
theorem not_forces_of_drawing (f : V → W) (hinj : Function.Injective f)
    (hf : ∀ x y : V, G.Adj x y → H.Adj (f x) (f y))
    (hcard : Fintype.card V ≤ k + 1) (hfree : ∀ s : Finset W, ¬ H.IsNClique k s)
    {u v : V} (huv : u ≠ v) : ¬ Forces G k u v := fun h =>
  hfree _ (isNClique_image f hinj hf
    (isNClique_of_forces_of_card h huv (le_antisymm hcard (card_le_of_forces h huv))))

end Host

/-! ## The plane's clique number -/

private theorem sq_dist_of_dist {a b : ℂ} (h : dist a b = 1) :
    (a.re - b.re) ^ 2 + (a.im - b.im) ^ 2 = 1 := by
  have hd : Real.sqrt ((a.re - b.re) ^ 2 + (a.im - b.im) ^ 2) = 1 := by
    rw [← Complex.dist_eq_re_im]; exact h
  have hnn : (0:ℝ) ≤ (a.re - b.re) ^ 2 + (a.im - b.im) ^ 2 := by positivity
  nlinarith [Real.sq_sqrt hnn, hd]

private theorem dist_of_sq_dist {a b : ℂ}
    (h : (a.re - b.re) ^ 2 + (a.im - b.im) ^ 2 = 1) : dist a b = 1 := by
  rw [Complex.dist_eq_re_im, h, Real.sqrt_one]

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

/-- **The plane's clique number is three** — no unit-distance clique of any size from four up,
since a clique's subsets are cliques. -/
theorem no_isNClique_of_four_le {n : ℕ} (hn : 4 ≤ n) (s : Finset ℂ) :
    ¬ (unitDistance ℂ).IsNClique n s := by
  rintro ⟨hcl, hcard⟩
  obtain ⟨t, hts, htcard⟩ := Finset.exists_subset_card_eq (s := s) (n := 4) (by omega)
  exact no_isNClique_four t ⟨hcl.subset (Finset.coe_subset.mpr hts), htcard⟩

/-! ## The threshold in the plane -/

/-- **The mascot obstruction.**  For every `k ≥ 4`, no `k + 1` points of the plane carry a pair
forced to share a colour in every proper `k`-colouring.

The minimal forcing gadget at `k` colours is the complete graph on `k + 1` vertices minus the
forced edge; it contains a `k`-clique; the plane's unit-distance graph has clique number three.
So the Moser spindle's recipe — minimal gadget, hinged, closed by a rotation — has no analogue
above three colours. -/
theorem not_forces_of_unit_drawing {V : Type*} [Fintype V] [DecidableEq V]
    {G : SimpleGraph V} {k : ℕ} (hk : 4 ≤ k) (f : V → ℂ) (hinj : Function.Injective f)
    (hf : ∀ x y : V, G.Adj x y → dist (f x) (f y) = 1)
    (hcard : Fintype.card V ≤ k + 1) {u v : V} (huv : u ≠ v) : ¬ Forces G k u v :=
  not_forces_of_drawing f hinj (fun x y hxy => unitDistance_adj.mpr (hf x y hxy)) hcard
    (fun s => no_isNClique_of_four_le hk s) huv

/-- **The mascot obstruction at four colours**, the case the challenge was posed at: no five
points of the plane carry a pair forced to share a colour in every proper four-colouring. -/
theorem not_forces_five_points {V : Type*} [Fintype V] [DecidableEq V]
    {G : SimpleGraph V} (f : V → ℂ) (hinj : Function.Injective f)
    (hf : ∀ x y : V, G.Adj x y → dist (f x) (f y) = 1)
    (hcard : Fintype.card V = 5) {u v : V} (huv : u ≠ v) : ¬ Forces G 4 u v :=
  not_forces_of_unit_drawing (by norm_num) f hinj hf (le_of_eq hcard) huv

/-! ## The threshold is sharp: at three colours the gadget is drawable

The negative above says the recipe has no analogue at `k ≥ 4`.  What makes that a *threshold*
rather than a bound is the other side: at `k = 3` the minimal gadget is a unit-distance graph,
and it is the one the Moser spindle hinges. -/

private theorem sqrt_three_sq : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)

private theorem sqrt_three_pos : 0 < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)

/-- **The rhombus drawn**: two unit triangles on the shared edge `1 —— 2`, far corners `0` and `3`
a distance `√3` apart.  Indices match `Gadget.rhombus`, whose forced pair is `(0, 3)`. -/
noncomputable def rhombusDraw : Fin 4 → ℂ
  | 0 => ⟨1/2, Real.sqrt 3 / 2⟩
  | 1 => ⟨0, 0⟩
  | 2 => ⟨1, 0⟩
  | 3 => ⟨1/2, -(Real.sqrt 3 / 2)⟩

theorem rhombusDraw_injective : Function.Injective rhombusDraw := by
  intro x y hxy
  fin_cases x <;> fin_cases y <;>
    simp_all [rhombusDraw, Complex.ext_iff] <;> linarith [sqrt_three_pos]

/-- **Every edge of the rhombus is drawn at length one.** -/
theorem rhombusDraw_unit (x y : Fin 4) (hxy : (edgeGraph 4 rhombus).Adj x y) :
    dist (rhombusDraw x) (rhombusDraw y) = 1 := by
  obtain ⟨-, hmem⟩ := hxy
  refine dist_of_sq_dist ?_
  fin_cases x <;> fin_cases y <;> simp_all [rhombus, rhombusDraw] <;>
    nlinarith [sqrt_three_sq]

/-- **The threshold is sharp.**  At three colours the minimal forcing gadget — four vertices,
`k + 1` exactly — *is* a unit-distance graph: two unit triangles on a shared edge, whose far
corners take the same colour in every proper three-colouring.  Hinging two copies of it at a
shared corner and closing the far corners at distance one is the Moser spindle.

Against `not_forces_of_unit_drawing` this brackets the recipe exactly: it works at `k = 3` and
at no `k` above, and the reason is the comparison of the plane's clique number with `k`. -/
theorem exists_forces_of_unit_drawing_three :
    ∃ (G : SimpleGraph (Fin 4)) (f : Fin 4 → ℂ) (u v : Fin 4),
      Function.Injective f ∧ (∀ x y : Fin 4, G.Adj x y → dist (f x) (f y) = 1) ∧ u ≠ v ∧
        Forces G 3 u v :=
  ⟨edgeGraph 4 rhombus, rhombusDraw, 0, 3, rhombusDraw_injective, rhombusDraw_unit,
    by decide, rhombus_forces⟩

end HadwigerNelson
