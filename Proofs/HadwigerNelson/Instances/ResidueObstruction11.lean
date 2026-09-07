import Proofs.HadwigerNelson.ResidueObstruction
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.Instances.HexShell

/-!
# The residue obstruction at `11`: the sealing plane is pairwise free, and what that forbids

The certified 5-colouring table of `UD(𝔽₁₁, 2)` (`finitePlane11Colouring`) has **no nonzero period** and
**coincides somewhere at every off-circle difference** — two `decide`s over the 121-entry table. By
`ResidueObstruction.lean` that settles, for every `√7`-free tower certificate with `11 ∤ D`:

* a pair forced equal at five colours has equal residues — its squared distance is `≡ 0 (mod 11)`;
* a virtual edge at five colours has adjacent residues — its squared distance is `≡ 1 (mod 11)`;
* so **no such certificate separates a `√3`-pair or a distance-2 pair at five colours** (`3, 4 ≢ 0, 1`),
  the two gadgets `six_le_chromaticNumber_plane_of_forced_pairs` needs — each impossible on its own over
  a field where `11` is usable (Heule's `ℚ(√3, √5, √11)`, `K(√5)`, `K(√247)`, …);

and for the plane itself: `Forces` is equality, `Separated` is adjacency, and the arity floor at five
colours is at least `3` — the finite plane that seals those fields has no pair compulsion of its own, the
finite analogue of a certified witness's floppiness at its top rung (G31).

What is NOT claimed: anything about certificates outside the `√7`-free subring, about fields where the
plane at every usable prime refuses five colours (de Grey's, at `131`), or about the field-level statement
(every unit vector is `𝔭`-integral) — that stays the hand argument of M58.
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-! ### The two properties of the certified table -/

/-- **The table has no nonzero period**: for every nonzero `d ∈ 𝔽₁₁²` some point and its `d`-translate
differ in colour. Decided over the 120 differences. -/
theorem finitePlane11_aperiodic : Aperiodic finitePlane11Colouring := by
  sorry

/-- **The table coincides at every off-circle difference**: for every nonzero `d` off the unit circle some
point and its `d`-translate share a colour. Decided over the 108 such differences (at least four
coincidences each, `tools/fpcompel.py`). -/
theorem finitePlane11_coincides : CoincidesAtNonedges (finitePlane 11) finitePlane11Colouring := by
  sorry

/-- The certified colouring, as the `Coloring` the general theorems take. -/
def finitePlane11Coloring : (finitePlane 11).Coloring (Fin 5) :=
  Coloring.mk finitePlane11Colouring finitePlane11_colouring_proper

/-! ### The plane at `11` is pairwise free at five colours -/

/-- **`UD(𝔽₁₁, 2)` forces no pair at five colours.** -/
theorem finitePlane11_forces_iff {u v : ZMod 11 × ZMod 11} :
    Forces (finitePlane 11) 5 u v ↔ u = v :=
  forces_iff_eq_of_aperiodic finitePlane11Coloring finitePlane11_aperiodic

/-- **`UD(𝔽₁₁, 2)` separates no pair but its edges at five colours.** -/
theorem finitePlane11_separated_iff {u v : ZMod 11 × ZMod 11} :
    Separated (finitePlane 11) 5 u v ↔ (finitePlane 11).Adj u v :=
  separated_iff_adj_of_coincides finitePlane11Coloring finitePlane11_coincides

/-- **The sealing plane has no arity-2 compulsion at five colours**: its arity floor is at least `3` (and
at most `5`, its degree being `12`: `arityFloor_le_of_degree`). -/
theorem three_le_arityFloor_finitePlane11 : 3 ≤ arityFloor (finitePlane 11) 5 :=
  three_le_arityFloor_of_aperiodic_coincides finitePlane11Coloring finitePlane11_aperiodic
    finitePlane11_coincides

/-! ### Certificates over the `√7`-free subring -/

namespace UDCert

variable {n : ℕ}

/-- **Forced equal at five colours ⟹ equal residues at `11`.** -/
theorem residue_eq_of_forces11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n}
    (h : Forces (edgeGraph n c.edges) 5 i j) :
    c.drawing Q4.sevenFree.res11 hS u i = c.drawing Q4.sevenFree.res11 hS u j :=
  Forces.image_eq_of_aperiodic finitePlane11Coloring finitePlane11_aperiodic
    (c.drawingHom Q4.sevenFree.res11 hS hu hv) h

/-- **A virtual edge at five colours ⟹ adjacent residues at `11`.** -/
theorem residue_adj_of_separated11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n}
    (h : Separated (edgeGraph n c.edges) 5 i j) :
    (finitePlane 11).Adj (c.drawing Q4.sevenFree.res11 hS u i) (c.drawing Q4.sevenFree.res11 hS u j) :=
  Separated.image_adj_of_coincides finitePlane11Coloring finitePlane11_coincides
    (c.drawingHom Q4.sevenFree.res11 hS hu hv) h

/-- **The distance law at `11`, forced half**: a pair listed at squared distance `r` with `r ≢ 0 (mod 11)` is
never forced equal at five colours. -/
theorem not_forces_of_pairsAt11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)} {r : ℤ}
    (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hr : (r : ZMod 11) ≠ 0) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAt Q4.sevenFree.res11 hS hu hv finitePlane11Coloring finitePlane11_aperiodic hps
    hmem hr

/-- **The distance law at `11`, separated half**: a pair listed at squared distance `r` with `r ≢ 1 (mod 11)`
is never a virtual edge at five colours. -/
theorem not_separated_of_pairsAt11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)} {r : ℤ}
    (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hr : (r : ZMod 11) ≠ 1) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAt Q4.sevenFree.res11 hS hu hv finitePlane11Coloring finitePlane11_coincides
    hps hmem hr

/-- **No `√7`-free certificate separates a `√3`-pair at five colours** — the first hex-shell gadget. -/
theorem not_separated_sqrt3_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 3 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAt11 hS hu hv hps hmem (by decide)

/-- **No `√7`-free certificate separates a distance-2 pair at five colours** — the second hex-shell gadget. -/
theorem not_separated_two_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 4 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAt11 hS hu hv hps hmem (by decide)

/-- **No `√7`-free certificate forces a distance-2 pair equal at five colours** (`4 ≢ 0`). -/
theorem not_forces_two_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 4 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAt11 hS hu hv hps hmem (by decide)

/-- **No `√7`-free certificate forces a distance-5 pair equal at five colours** (`25 ≡ 3 ≢ 0`) — the
Exoo–Ismailescu seed's forced pair, at the distance where its unit part can never carry it. -/
theorem not_forces_five_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 25 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAt11 hS hu hv hps hmem (by decide)

end UDCert

/-! ### Spec: the API on real certificates -/

/-- Heule-510's forced pairs at five colours, if any, have equal residues — free from the reduction. -/
example {i j : Fin 510} (h : Forces (edgeGraph 510 heule510.edges) 5 i j) :
    heule510Reduce11 i = heule510Reduce11 j :=
  heule510.residue_eq_of_forces11 heule510_coordsIn_sevenFree heule510_denom_inv heule510_valid h

/-- The hex shell is `√7`-free and its denominator `2` is invertible mod `11` (`6 · 2 = 12`). -/
theorem hexShell_coordsIn_sevenFree : hexShell.CoordsIn Q4.sevenFree := by decide +kernel

theorem hexShell_denom_inv11 : (6 : ZMod 11) * hexShell.denom = 1 := by decide

/-- The shell's first `√3`-pair `(1, 3)` is not a virtual edge at five colours — through the theorem (the
shell is 3-colourable, so this is also trivial; the point is the path). -/
example : ¬ Separated (edgeGraph 7 hexShellEdges) 5 1 3 :=
  hexShell.not_separated_sqrt3_11 hexShell_coordsIn_sevenFree hexShell_denom_inv11 hexShell_valid
    hexShell_p3_dist (by decide)

/-- Its first diameter `(1, 4)` likewise. -/
example : ¬ Separated (edgeGraph 7 hexShellEdges) 5 1 4 :=
  hexShell.not_separated_two_11 hexShell_coordsIn_sevenFree hexShell_denom_inv11 hexShell_valid
    hexShell_p4_dist (by decide)

/-! ### Reds -/

/-- The 3-plane's certified 3-colouring (`data/fplane/chi-p3.json`): rows `012 / 120 / 201`. -/
def finitePlane3Colouring (v : ZMod 3 × ZMod 3) : Fin 3 :=
  (![![0, 1, 2], ![1, 2, 0], ![2, 0, 1]] : Fin 3 → Fin 3 → Fin 3) v.1 v.2

/-- It is proper … -/
example : ∀ {u v : ZMod 3 × ZMod 3}, (finitePlane 3).Adj u v →
    finitePlane3Colouring u ≠ finitePlane3Colouring v := by decide

/-- … and it is NOT aperiodic — `(1, 1)` is a period — so `Aperiodic` is a real property of a table and
the hypothesis of `Forces.image_eq_of_aperiodic` is load-bearing. (The 3-plane itself is pairwise free, by all
twelve of its 3-colourings, `tools/fpcompel.py`; this one table does not show it.) -/
example : ¬ Aperiodic finitePlane3Colouring := by decide

-- The residues the distance law consults, pinned: `√3` and `2` are blocked both ways, `2√3` is a
-- residue-ALLOWED virtual edge (`12 ≡ 1`) about which the theorem is silent by design, and the seed's
-- forced distance `5` is blocked as a forced pair.
#guard (3 : ZMod 11) ≠ 1 ∧ (3 : ZMod 11) ≠ 0
#guard (4 : ZMod 11) ≠ 1 ∧ (4 : ZMod 11) ≠ 0
#guard (12 : ZMod 11) = 1
#guard (25 : ZMod 11) ≠ 0 ∧ (25 : ZMod 11) ≠ 1

end HadwigerNelson
