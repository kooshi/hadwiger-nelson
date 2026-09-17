import Proofs.HadwigerNelson.Instances.SqrtEleven.Valid
import Proofs.HadwigerNelson.Instances.SqrtEleven.Cnf.Cert
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.SquareClass

/-!
# The plane over `ℚ(√11)` needs four colours

FS-58 (`plans/FS58-four-colours.md`, phase D2): **`four_le_chromaticNumber_planeOver_eleven`** —
`χ(ℚ(√11)²) ≥ 4`, from a 204-point unit-distance graph in `ℚ(√11)²` with no proper 3-colouring.

## The witness, and who checks what

The points, the 455 edges and the refutation are `data/fs58/witness-11/` (`witness.json`, `witness.lrat.gz`), built
by `tools/fs58_witness.py` as four chained copies of a 52-point forcer along `1/3 = 1 + 1 + v + v̄`,
`v = (−5 + i√11)/6` (that directory's README has the construction). `tools/fs58_emit_witness.py` put them through the
repository's emitters unchanged: `Instances/SqrtEleven/{Table,Edges,Geom00,Valid}` (`tools/emit_cert.py`, scale 150)
and `Instances/SqrtEleven/Cnf/` (`tools/emit_mask.py`, three colours, the pin `c(0) = 0`, `c(1) = 1`). Nothing in
`tools/` is trusted; the kernel checks

* that all 455 listed pairs are exactly one unit apart (`eleven204_valid`, exact integer arithmetic in the tower);
* that every coordinate uses only the `1` and `√11` slots of the tower (`eleven204_coordsIn_elevenOnly`), so every
  point lies in `ℚ(√11)²`;
* that the clause table holds `coloringCNF 3 204 eleven204.edges` with the pin appended (`eleven204_agrees`), and the
  CaDiCaL refutation of that formula step by step (`eleven204_unsat`).

## What is not proved here

The matching upper bound. `χ(ℚ(√11)²) ≤ 4` is `[Fischer1990]`'s and is **not** in the kernel, so this module proves
`χ ≥ 4` and not `χ = 4` for the plane. For the finite graph it proves both (`eleven204_colorable_four`).
-/

namespace HadwigerNelson

open SimpleGraph SquareClass

-- `Adjoin.eval`'s defining equation, restated locally for the reason `SeamCert.lean`'s private copy gives: the
-- lemma belongs in `Field/Quadratic.lean`, whose declarations have ~1,500 transitive dependents.
private theorem eval_mk {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} (evalBase : K →+* ℝ)
    (r : ℝ) (hr : r ^ 2 = d) (x : Adjoin d K) :
    Adjoin.eval evalBase r hr x = evalBase x.re + evalBase x.im * r := rfl

/-! ### `ℤ[√11]` inside the tower -/

/-- **`ℤ[√11]` inside the tower.** `Q4 = Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`: `x.re` and `x.im` are the two
`√11`-components, their `.im` are the `√7`-coefficients, the `.re.im` the `√5`-coefficients and the `.re.re.im` the
`√3`-coefficients. All six vanish exactly when `x.re, x.im ∈ ℤ`, i.e. `x ∈ ℤ[√11]`.

The six conditions are taken together, not as an intersection of "`√3`-free", "`√5`-free" and "`√7`-free" subrings:
`SeamCert.lean` records why forgetting an inner generator alone is not closed under multiplication. -/
def Q4.elevenOnly : Subring Q4 where
  carrier := {x | x.re.im = 0 ∧ x.im.im = 0 ∧ x.re.re.im = 0 ∧ x.im.re.im = 0 ∧
    x.re.re.re.im = 0 ∧ x.im.re.re.im = 0}
  mul_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq] at hx hy ⊢
    obtain ⟨hx1, hx2, hx3, hx4, hx5, hx6⟩ := hx; obtain ⟨hy1, hy2, hy3, hy4, hy5, hy6⟩ := hy
    simp only [Adjoin.mul_re, Adjoin.mul_im, Adjoin.add_re, Adjoin.add_im, Adjoin.natCast_re,
      Adjoin.natCast_im, hx1, hx2, hx3, hx4, hx5, hx6, hy1, hy2, hy3, hy4, hy5, hy6, mul_zero, zero_mul,
      add_zero, and_self]
  one_mem' := by simp
  add_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq] at hx hy ⊢
    obtain ⟨hx1, hx2, hx3, hx4, hx5, hx6⟩ := hx; obtain ⟨hy1, hy2, hy3, hy4, hy5, hy6⟩ := hy
    simp [Adjoin.add_re, Adjoin.add_im, hx1, hx2, hx3, hx4, hx5, hx6, hy1, hy2, hy3, hy4, hy5, hy6]
  zero_mem' := by simp
  neg_mem' {x} hx := by
    simp only [Set.mem_setOf_eq] at hx ⊢
    obtain ⟨hx1, hx2, hx3, hx4, hx5, hx6⟩ := hx
    simp [Adjoin.neg_re, Adjoin.neg_im, hx1, hx2, hx3, hx4, hx5, hx6]

/-- Membership decides, so `CoordsIn` decides: a `decide` over a certificate's table checks that it is drawn in
`ℚ(√11)`. -/
instance : DecidablePred (· ∈ Q4.elevenOnly) :=
  fun x => decidable_of_iff (x.re.im = 0 ∧ x.im.im = 0 ∧ x.re.re.im = 0 ∧ x.im.re.im = 0 ∧
    x.re.re.re.im = 0 ∧ x.im.re.re.im = 0) Iff.rfl

example : (⟨⟨⟨⟨2, 0⟩, 0⟩, 0⟩, ⟨⟨⟨-3, 0⟩, 0⟩, 0⟩⟩ : Q4) ∈ Q4.elevenOnly := by decide
example : (⟨⟨⟨⟨2, 1⟩, 0⟩, 0⟩, 0⟩ : Q4) ∉ Q4.elevenOnly := by decide
example : (⟨0, ⟨⟨0, 1⟩, 0⟩⟩ : Q4) ∉ Q4.elevenOnly := by decide

/-- **An element of `ℤ[√11]` evaluates into every real field holding `√11`.** -/
theorem Q4.eval_mem_of_mem_elevenOnly {F : Subfield ℝ} (h11 : Real.sqrt 11 ∈ F) {x : Q4}
    (hx : x ∈ Q4.elevenOnly) : Q4.eval x ∈ F := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := hx
  simp only [Q4.eval, eval_mk, h1, h2, h3, h4, h5, h6, map_zero, zero_mul, add_zero, Int.coe_castRingHom]
  exact add_mem (intCast_mem F _) (mul_mem (intCast_mem F _) h11)

/-! ### A certificate drawn in a subring bounds the plane over any field its evaluations land in -/

namespace UDCert

variable {n : ℕ}

/-- **Every point of a certificate whose coordinates lie in `S` lies in the plane over any real field `F` into which
`S` evaluates.** The denominator divides out inside `F`. Inhabited by `eleven204` with `S = Q4.elevenOnly` in
`four_le_chromaticNumber_planeOver_eleven`. -/
theorem point_mem_planeOver (c : UDCert n) {S : Subring Q4} (hS : c.CoordsIn S) {F : Subfield ℝ}
    (hSF : ∀ x ∈ S, Q4.eval x ∈ F) (i : Fin n) : c.point i ∈ planeOver F := by
  have hD : (c.denom : ℝ) ∈ F := by simp
  exact mem_planeOver.mpr ⟨div_mem (hSF _ (hS i).1) hD, div_mem (hSF _ (hS i).2) hD⟩

/-- **A valid certificate whose coordinates lie in `S` bounds the plane over any real field `F` into which `S`
evaluates from below**: its graph maps into that plane's unit-distance graph. Inhabited by `eleven204` in
`four_le_chromaticNumber_planeOver_eleven`. -/
theorem chromaticNumber_le_planeOver (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true)
    {S : Subring Q4} (hS : c.CoordsIn S) {F : Subfield ℝ} (hSF : ∀ x ∈ S, Q4.eval x ∈ F) :
    (edgeGraph n c.edges).chromaticNumber ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have hunit := c.valid_sound hd hv
  refine chromaticNumber_mono_of_hom ⟨fun i => ⟨c.point i, c.point_mem_planeOver hS hSF i⟩, ?_⟩
  rintro i j ⟨-, hm | hm⟩
  · exact unitDistance_adj.mpr (hunit (i, j) hm)
  · exact unitDistance_adj.mpr (by rw [dist_comm]; exact hunit (j, i) hm)

end UDCert

/-! ### The 204-point witness: shape pins and controls, compiled every build -/

#guard eleven204.edges.length = 455
#guard eleven204.edges.eraseDups.length = 455
#guard eleven204.edges.all fun e => e.1 < e.2
#guard (eleven204.edges.map (·.1) ++ eleven204.edges.map (·.2)).eraseDups.length = 204
#guard eleven204.denom = 150
-- The pinned edge: vertex 0 is `(0, 0)` and vertex 1 is `(1, 0)`, stored at scale 150.
#guard eleven204.edges.contains (0, 1)
#guard eleven204.verts 0 = ⟨0, 0⟩ ∧ eleven204.verts 1 = ⟨150, 0⟩

-- The compiled cross-check of `eleven204_valid`: `badEdges` is the compiler's evaluation of the predicate the kernel
-- settles.
#guard eleven204.badEdges.isEmpty

-- The negative control. Collapse vertex 1 onto vertex 0 and the check must fail, naming only edges at vertex 1.
-- Vertex 1 rather than vertex 0, because vertex 0 is the origin here and collapsing onto it from 0 moves nothing.
#guard !(({ eleven204 with verts := fun i => if i = 1 then eleven204.verts 0 else eleven204.verts i } :
  UDCert 204)).badEdges.isEmpty
#guard (({ eleven204 with verts := fun i => if i = 1 then eleven204.verts 0 else eleven204.verts i } :
  UDCert 204)).badEdges.all fun be => be.1.1 = 1 ∨ be.1.2 = 1

-- The field control: a `√3` slipped into one coordinate must leave `ℤ[√11]`, so `CoordsIn` is not constantly true.
#guard !decide (({ eleven204 with verts := fun i => if i = 5 then ⟨⟨⟨⟨⟨0, 1⟩, 0⟩, 0⟩, 0⟩, 0⟩ else eleven204.verts i } :
  UDCert 204).CoordsIn Q4.elevenOnly)

/-! ### The witness's claims -/

/-- **The 204 points lie in `ℚ(√11)²`**: every stored coordinate uses only the `1` and `√11` slots of the tower. -/
theorem eleven204_coordsIn_elevenOnly : eleven204.CoordsIn Q4.elevenOnly := by decide +kernel

/-- The ports: the pinned edge, `(0, 0)` and `(1, 0)`. -/
def eleven204Ports : Fin 2 → Fin 204 := ![0, 1]

/-- The certificate was filed against the cube pinning the ports to `0, 1`. -/
private theorem eleven204_pinCube : pinCube eleven204Ports ![0, 1] = eleven204Cube := by decide

/-- **The refutation as a gadget**: no proper 3-colouring gives the two ports different colours — one certificate
covers all `3 · 2` relabellings, by colour symmetry. -/
def eleven204Refuted : Gadget 3 204 2 eleven204.edges eleven204Ports :=
  Gadget.ofUnsat ![0, 1] (by rw [eleven204_pinCube]; exact eleven204_unsat)

/-- **The pinned edge**: the ports are adjacent, so they cannot share a colour. -/
def eleven204Edge : Gadget 3 204 2 eleven204.edges eleven204Ports :=
  Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))

/-- The refutation and the edge, composed: at two ports there are two colour partitions, and each gadget rules out
one. `#eval eleven204Gadgets.survivors` when this stops refuting. -/
def eleven204Gadgets : Gadget 3 204 2 eleven204.edges eleven204Ports := eleven204Refuted.inter eleven204Edge

-- The `fail` branch is unreachable *when the gadgets refute*, which is when the linter runs.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The 204-point graph has no proper 3-colouring.** Kernel-checked from the CaDiCaL certificate, which nothing here
trusts. -/
theorem eleven204_not_colorable_three : ¬ (edgeGraph 204 eleven204.edges).Colorable 3 :=
  not_colorable_of_gadget eleven204Gadgets (by
    first
    | decide
    | fail "eleven204Gadgets admits a port colouring, so this graph is not refuted. Run \
            `#eval eleven204Gadgets.survivors` from a fresh file importing this module.")

/-! ### The control that must go red: four colours suffice for the graph

Found by `tools/fs58_emit_witness.py --four-colouring` (DSatur-ordered backtracking) and trusted for nothing: the
kernel checks it on every edge. Without it, a graph refuted at every colour count would read exactly like this
success; with it, the finite graph's chromatic number is exactly four. -/

/-- A proper 4-colouring of the 204 points, one colour per vertex in vertex order. -/
def eleven204Colours : List ℕ :=
  [1, 0, 2, 1, 0, 0, 1, 0, 0, 0, 2, 2, 1, 2, 2, 0, 0, 2, 1, 0, 0, 2, 2, 1, 0, 1, 0, 1, 1, 2, 1, 0, 2, 2, 0, 2, 2, 1,
   1, 1, 2, 1, 1, 0, 2, 1, 0, 2, 0, 1, 0, 0, 0, 1, 2, 1, 0, 0, 1, 2, 1, 0, 1, 0, 2, 0, 1, 2, 2, 0, 1, 2, 1, 2, 2, 2,
   1, 0, 2, 0, 0, 1, 1, 2, 0, 1, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 0, 0, 0, 1, 2, 0, 1, 1, 1, 2, 0, 1, 0, 1, 0, 1, 1, 0,
   1, 1, 1, 1, 0, 2, 2, 2, 0, 1, 1, 0, 0, 0, 2, 0, 0, 1, 1, 1, 2, 0, 2, 3, 0, 1, 0, 2, 1, 2, 1, 1, 1, 0, 2, 2, 1, 2,
   3, 1, 2, 2, 0, 0, 0, 1, 2, 1, 2, 2, 1, 3, 2, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 2, 2, 1, 1, 3, 2, 2, 1, 1, 1, 0, 0,
   0, 1, 0, 1, 0, 1, 1, 2, 0, 1, 2, 0, 1, 1]

#guard eleven204Colours.length = 204
-- The fourth colour is used, so this is a 4-colouring and not a 3-colouring wearing a wider type.
#guard eleven204Colours.all (· < 4) && eleven204Colours.contains 3

/-- The colouring at the index type `Coloring` wants. -/
def eleven204Colour (v : Fin 204) : Fin 4 := ⟨eleven204Colours.getD v.val 0 % 4, Nat.mod_lt _ (by decide)⟩

/-- **The colouring is proper**, checked edge by edge in the kernel. -/
theorem eleven204_colour_proper :
    eleven204.edges.all (fun e => decide (eleven204Colour e.1 ≠ eleven204Colour e.2)) = true := by
  decide +kernel

/-- **Four colours suffice for the 204-point graph**, so `eleven204_not_colorable_three` is a statement about three
colours and the graph's chromatic number is exactly four. -/
theorem eleven204_colorable_four : (edgeGraph 204 eleven204.edges).Colorable 4 :=
  ⟨Coloring.mk eleven204Colour fun {v w} h => by
    have hall := List.all_eq_true.mp eleven204_colour_proper
    rcases h.2 with hm | hm
    · exact of_decide_eq_true (hall _ hm)
    · exact (of_decide_eq_true (hall _ hm)).symm⟩

/-- **The 204-point graph needs four colours.** -/
theorem four_le_chromaticNumber_eleven204 : 4 ≤ (edgeGraph 204 eleven204.edges).chromaticNumber := by
  exact_mod_cast add_one_le_chromaticNumber_iff_not_colorable.mpr eleven204_not_colorable_three

/-! ### The plane -/

/-- `√11 ∈ ℚ(√11)`. -/
theorem sqrt_eleven_mem_fieldOfRadicands_eleven : Real.sqrt 11 ∈ fieldOfRadicands {11} := by
  simpa using sqrt_mem_fieldOfRadicands (D := {11}) (d := 11) (by simp)

/-- **The plane over any real field holding `√11` needs four colours.** The statement at its proof's level: the
204-point witness uses nothing about the field but `√11 ∈ F`. `four_le_chromaticNumber_planeOver_eleven` is the case
`F = ℚ(√11)`. -/
theorem four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem {F : Subfield ℝ} (h11 : Real.sqrt 11 ∈ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  four_le_chromaticNumber_eleven204.trans
    (eleven204.chromaticNumber_le_planeOver (by decide) eleven204_valid eleven204_coordsIn_elevenOnly
      fun _ hx => Q4.eval_mem_of_mem_elevenOnly h11 hx)

/-- **The plane over `ℚ(√11)` needs four colours**: `χ(ℚ(√11)²) ≥ 4`.

The graph is the unit-distance graph of `ℂ` restricted to the points with both coordinates in `ℚ(√11)`; the bound comes
from the 204-point witness of FS-58 (`data/fs58/witness-11/`), whose points lie in `ℚ(√11)²`
(`eleven204_coordsIn_elevenOnly`), whose 455 edges are exact unit distances (`eleven204_valid`) and which has no proper
3-colouring (`eleven204_not_colorable_three`, from a kernel-replayed LRAT refutation).

Unlike `four_le_chromaticNumber_planeOver`, the bound does not come from a Moser spindle: `ℚ(√11)` contains no `√3`,
so its plane has no equilateral triangle and no spindle. **Not proved here:** the matching upper bound
`χ(ℚ(√11)²) ≤ 4`, which is `[Fischer1990]`'s and is not in the kernel. -/
theorem four_le_chromaticNumber_planeOver_eleven :
    4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber :=
  four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem sqrt_eleven_mem_fieldOfRadicands_eleven

end HadwigerNelson
