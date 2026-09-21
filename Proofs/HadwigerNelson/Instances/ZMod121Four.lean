import Proofs.HadwigerNelson.ResidueTower
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.Instances.ZMod121Four.Pts
import Proofs.HadwigerNelson.Instances.ZMod121Four.Cnf.Cert
import Proofs.HadwigerNelson.Gadget

/-!
# `χ(UD(ℤ/121, 2)) = 5` — the residue ceiling does not drop at level two

FS-66 (`plans/FS66-residue-tower-drop.md`). Every upper bound this repository holds on the number of
colours a plane over a number field needs comes from colouring the residue plane at the **first** level.
Reduction modulo `p²` is a ring homomorphism too, so `χ(UD(ℤ/p², 2)) ≤ χ(UD(𝔽_p, 2))`
(`chromaticNumber_unitQuadrance_zmod_le_of_dvd`); the milestone asks whether that is ever strict. **At
`p = 11` it is not**: level two needs five colours, exactly as level one does. This is the first kernel
statement about a level-two residue plane, and the first value of `χ` for any `UD(ℤ/p^r, 2)` with `r ≥ 2`
in print anywhere the milestone's prior-art gate could reach.

## The two halves

* **Upper.** `finitePlane11_colorable_five` pulled back along `ZMod.castHom (11 ∣ 121)`. No data, no
  solver: a 5-colouring of level one, read through the level map, is a 5-colouring of level two.
* **Lower.** An **883-point, 3,441-edge subgraph** of the 14,641-vertex level-two plane that has no
  proper 4-colouring. Its points are `Instances/ZMod121Four/Pts.lean`, its edges
  `Instances/ZMod121Four/Edges.lean`, and the refutation of the 14,650-clause formula those edges
  generate is `Instances/ZMod121Four/Cnf/` — a CaDiCaL LRAT proof replayed step by step by the kernel
  through the M05 pipeline. The graph is 1-minimal in vertices (`data/fs66/witness-p11-l2-k4/`), and it
  is a *subgraph*: a graph that refuses to be coloured refutes every graph it maps into, so the kernel
  is never shown the whole plane, whose formula is 3,879,868 clauses against 14,650.

## What the kernel re-derives, and what nothing here trusts

Neither the point table, nor the edge list, nor the clause table, nor the certificate is trusted.

* `zmod121FourEdges_all_ok` — **every listed pair really has unit quadrance modulo 121**, computed from
  the packed point table in natural-number arithmetic, `decide +kernel` over all 3,441 pairs. A table
  entry off by one, or an edge list from another graph, fails here. It also excludes loops and repeated
  points, since `unitPairNat 121 u u = false`.
* `zmod121Four_agrees` (generated) — the clause table really holds `coloringCNF 4 883 zmod121FourEdges`
  with the cube appended, so a wrong table is a failed check and never a false theorem.
* `zmod121Four_unsat` (generated) — every derivation step of the LRAT propagates.
* `zmod121FourTriangle` — the three pinned vertices are pairwise adjacent **in the listed graph**,
  checked here against the edge list rather than taken from the generator's word for it. Pinning three
  colours is sound only because of that, and one certificate then covers all `4! = 24` relabellings.

## What is deliberately absent

No field-level consumer: a refusal at level two says nothing new about `χ(ℚ(√47)²)` or any number
field's plane, because the field-level residue step is still a hand theorem (`UnitQuadrance.lean`'s
module doc, FS-47). No statement about level three, about the `11`-adic plane, or about the tower's
limit: none has a certificate, and a level-two refusal does not imply one at level three.
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-! ### The listed graph, and that it really is drawn in `UD(ℤ/121, 2)` -/

/-- The `i`-th listed point, read out of the packed table: one shift and one mask. -/
def zmod121FourPt (i : Fin 883) : ℕ × ℕ := unpackPt 121 14 zmod121FourPacked i.val

-- The data, pinned: the pinned triangle's three points, so a regenerated table that silently changed
-- is caught at the build rather than in a proof.
#guard zmod121FourPt 0 == (0, 0)
#guard zmod121FourPt 27 == (0, 120)
#guard zmod121FourPt 430 == (47, 60)

/-- **Every listed pair passes the unit-quadrance check** — 3,441 pairs, each two table reads and a
dozen `Nat` operations. Stated as a `Bool` through `List.all` on a measurement: `decide +kernel` on the
`∀ e ∈ list, …` form of the same claim costs an order of magnitude more (`CLAUDE.md` § The kernel's cost
model; FS-38 measured 31.9 GB and a timeout against 3.5 GB and 5 s). -/
theorem zmod121FourEdges_all_ok :
    zmod121FourEdges.all (fun e => unitPairNat 121 (zmod121FourPt e.1) (zmod121FourPt e.2)) = true := by
  decide +kernel

/-- Where the listed graph's `i`-th vertex sits in the plane over `ZMod 121`. The only cast in the whole
path, and it happens here rather than in the data. -/
def zmod121FourVert (i : Fin 883) : ZMod 121 × ZMod 121 :=
  (((zmod121FourPt i).1 : ZMod 121), ((zmod121FourPt i).2 : ZMod 121))

/-- **Every listed pair is an edge of `UD(ℤ/121, 2)`.** This is the check that the certificate is about
the object the headline names: the indices are the generator's, and a disagreement about them would
leave almost every listed pair a non-edge. -/
theorem zmod121FourEdges_adj {a b : Fin 883} (h : (a, b) ∈ zmod121FourEdges) :
    (unitQuadrance (ZMod 121)).Adj (zmod121FourVert a) (zmod121FourVert b) :=
  (unitPairNat_eq_true_iff (by norm_num) _ _).mp
    (List.all_eq_true.mp zmod121FourEdges_all_ok (a, b) h)

/-- **The listed graph maps into the plane over `ZMod 121`.** -/
def zmod121FourHom : edgeGraph 883 zmod121FourEdges →g unitQuadrance (ZMod 121) where
  toFun := zmod121FourVert
  map_rel' := by
    intro i j hij
    rcases hij.2 with h | h
    · exact zmod121FourEdges_adj h
    · exact (zmod121FourEdges_adj h).symm

/-! ### The refutation -/

/-- The triangle whose colours the certificate names: the three vertices the cube pins. -/
def zmod121FourPorts : Fin 3 → Fin 883 := ![0, 27, 430]

/-- The certificate was filed against the cube pinning that triangle to `0, 1, 2`. -/
private theorem zmod121Four_pinCube : pinCube zmod121FourPorts ![0, 1, 2] = zmod121FourCube := by decide

/-- **The refutation**: no proper 4-colouring gives the three ports three different colours. One
certificate covers all `4! = 24` relabellings, by colour symmetry. -/
def zmod121FourRefuted : Gadget 4 883 3 zmod121FourEdges zmod121FourPorts :=
  Gadget.ofUnsat ![0, 1, 2] (by rw [zmod121Four_pinCube]; exact zmod121Four_unsat)

/-- **The triangle**: its three edges, each forbidding its ends from agreeing. Pinning three colours is
sound only because these three vertices are pairwise adjacent, and this is where that is checked —
against the edge list, in the kernel, not against the generator's own word for it. -/
def zmod121FourTriangle : Gadget 4 883 3 zmod121FourEdges zmod121FourPorts :=
  (Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide)
      (List.mem_of_elem_eq_true (by decide +kernel)))).inter
    ((Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide)
        (List.mem_of_elem_eq_true (by decide +kernel)))).inter
      (Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide)
        (List.mem_of_elem_eq_true (by decide +kernel)))))

/-- The two constraints, composed. `#eval zmod121FourGadgets.survivors` when this stops refuting. -/
def zmod121FourGadgets : Gadget 4 883 3 zmod121FourEdges zmod121FourPorts :=
  zmod121FourRefuted.inter zmod121FourTriangle

/-- **The listed graph has no 4-colouring** — the certificate and the triangle's own three edges leave
no colouring of the ports at all, decided over all 64. -/
theorem zmod121FourEdgeGraph_not_colorable : ¬ (edgeGraph 883 zmod121FourEdges).Colorable 4 :=
  not_colorable_of_gadget zmod121FourGadgets (by decide)

/-! ### The plane over `ZMod 121` -/

/-- **`χ(UD(ℤ/121, 2)) > 4`**: a 4-colouring of the plane would restrict to the listed 883-point
subgraph, which has none. The solver-dependent surface of this module is exactly this declaration, and
what it rests on is an LRAT certificate the kernel replays step by step — never the solver's word. -/
theorem unitQuadrance_zmod121_not_colorable_four : ¬ (unitQuadrance (ZMod 121)).Colorable 4 :=
  fun h => zmod121FourEdgeGraph_not_colorable (Colorable.of_hom zmod121FourHom h)

/-- **`χ(UD(ℤ/121, 2)) ≤ 5`**: level one's verified 5-colouring, read through the level map. No data. -/
theorem unitQuadrance_zmod121_colorable_five : (unitQuadrance (ZMod 121)).Colorable 5 :=
  unitQuadrance_colorable_of_ringHom (ZMod.castHom (show 11 ∣ 121 by norm_num) (ZMod 11))
    finitePlane11_colorable_five

/-- **The unit-distance graph over the ring of integers modulo 121 needs exactly five colours**: at the
prime 11 the residue ceiling does not drop at level two. -/
theorem chromaticNumber_unitQuadrance_zmod121 :
    (unitQuadrance (ZMod 121)).chromaticNumber = 5 :=
  chromaticNumber_eq_iff_colorable_not_colorable.mpr
    ⟨unitQuadrance_zmod121_colorable_five, unitQuadrance_zmod121_not_colorable_four⟩

/-- **The level-two plane is 5-chromatic and level one's value is unchanged by it** — the tower
inequality of `chromaticNumber_unitQuadrance_zmod_le_of_dvd` is an equality here. Stated so that the
milestone's question ("does the ceiling drop?") has a declaration that answers it in its own words. -/
theorem chromaticNumber_unitQuadrance_zmod121_eq_finitePlane11 :
    (unitQuadrance (ZMod 121)).chromaticNumber = (finitePlane 11).chromaticNumber := by
  rw [chromaticNumber_unitQuadrance_zmod121, chromaticNumber_finitePlane11]

/-! ### Reds — each is a control that would go red if the thing it guards broke -/

section Reds

/-- The cast from the packed table into the plane is faithful at the pinned triangle, and does not
collapse it: three distinct points of `(ℤ/121)²`, stated in the plane's own coordinates. -/
example : zmod121FourVert 0 = (0, 0) ∧ zmod121FourVert 27 = (0, 120) ∧
    zmod121FourVert 430 = (47, 60) := by decide

/-- A point of the table moved by one is not a neighbour of what it was a neighbour of: `(0,0)` and
`(0,120)` are adjacent, `(0,0)` and `(0,119)` are not. This is the fault the edge check catches. -/
example : unitPairNat 121 (0, 0) (0, 120) = true ∧ unitPairNat 121 (0, 0) (0, 119) = false := by decide

/-- The pin is a clique of the listed graph, stated separately from the gadget that uses it. -/
example : (edgeGraph 883 zmod121FourEdges).Adj 0 27 ∧ (edgeGraph 883 zmod121FourEdges).Adj 0 430 ∧
    (edgeGraph 883 zmod121FourEdges).Adj 27 430 :=
  ⟨edgeGraph_adj_of_mem (by decide) (List.mem_of_elem_eq_true (by decide +kernel)),
   edgeGraph_adj_of_mem (by decide) (List.mem_of_elem_eq_true (by decide +kernel)),
   edgeGraph_adj_of_mem (by decide) (List.mem_of_elem_eq_true (by decide +kernel))⟩

end Reds

end HadwigerNelson
