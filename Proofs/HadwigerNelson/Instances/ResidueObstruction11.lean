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
* **no such certificate forces a pair at distance `5/3` equal at five colours, or separates one**
  (`(5/3)² = 25/9`, and `25 ≢ 0, 9`) — Philip Gibbs's 2018 question on the Polymath16 blog, answered
  for every certificate of his graph without building one (`not_forces_five_thirds_11`), and modelled on
  Heule-510, which has pairs at exactly `5/3` and is 5-colourable, so the question is live there;

and for the plane itself: `Forces` is equality, `Separated` is adjacency, and the arity floor at five
colours lies in `{3, 4, 5}` — the finite plane that seals those fields has no pair compulsion of its own,
the finite analogue of a certified witness's floppiness at its top rung (G31).

## What a consumer may conclude

`UDCert.not_separated_sqrt3_11 c …`: THIS certificate, reduced through `res11`, does not separate the
listed `√3`-pair at five colours; with `not_separated_two_11`, no `√7`-free certificate with `11 ∤ D` is
either hex-shell gadget. The field-level reading — no such gadget exists in Heule's field, or in `K(√5)`,
`K(√247)` — adds the hand argument that every unit-distance graph there is such a certificate (M58,
`reference/Chat-analysis/VERIFICATION.md` §1) and is NOT formalized. `three_le_arityFloor_finitePlane11`
and `arityFloor_finitePlane11_le_five` are statements about the finite graph `finitePlane 11` alone.

What is NOT claimed: anything about certificates outside the `√7`-free subring, about fields where the
plane at every usable prime refuses five colours (de Grey's, at `131`), or about the field-level statement
(every unit vector is `𝔭`-integral) — that stays the hand argument of M58. Nor the `√247` variant of Gibbs's
question (`ζ₂ = (−3+i√247)/16`): its coordinates are outside the tower, so no certificate here can hold them.
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-! ### The two properties of the certified table -/

/-- **The table has no nonzero period**: for every nonzero `d ∈ 𝔽₁₁²` some point and its `d`-translate
differ in colour. Decided over the 120 differences. -/
theorem finitePlane11_aperiodic : Aperiodic finitePlane11Colouring := by
  decide +kernel

/-- **The table coincides at every off-circle difference**: for every nonzero `d` off the unit circle some
point and its `d`-translate share a colour. Decided over the 108 such differences (at least four
coincidences each, `tools/fpcompel.py`). -/
theorem finitePlane11_coincides : CoincidesAtNonedges (finitePlane 11) finitePlane11Colouring := by
  decide +kernel

/-- The certified colouring function, bundled with its properness as the `Coloring` the general theorems
take. Named by dot notation on the function so the two are one object, not two spellings. -/
def finitePlane11Colouring.toColoring : (finitePlane 11).Coloring (Fin 5) :=
  Coloring.mk finitePlane11Colouring finitePlane11_colouring_proper

-- The same two properties by the compiled evaluator (`#guard` runs `decide` through `#eval`, not the
-- kernel): a second, decorrelated path through the table.
#guard decide (Aperiodic finitePlane11Colouring)
#guard decide (CoincidesAtNonedges (finitePlane 11) finitePlane11Colouring)

/-! ### The plane at `11` is pairwise free at five colours -/

/-- **`UD(𝔽₁₁, 2)` forces no pair at five colours.** -/
theorem finitePlane11_forces_iff {u v : ZMod 11 × ZMod 11} :
    Forces (finitePlane 11) 5 u v ↔ u = v :=
  forces_iff_eq_of_aperiodic finitePlane11Colouring.toColoring finitePlane11_aperiodic

/-- **`UD(𝔽₁₁, 2)` separates no pair but its edges at five colours.** -/
theorem finitePlane11_separated_iff {u v : ZMod 11 × ZMod 11} :
    Separated (finitePlane 11) 5 u v ↔ (finitePlane 11).Adj u v :=
  separated_iff_adj_of_coincides finitePlane11Colouring.toColoring finitePlane11_coincides

/-- **The sealing plane has no arity-2 compulsion at five colours**: its arity floor is at least `3`. -/
theorem three_le_arityFloor_finitePlane11 : 3 ≤ arityFloor (finitePlane 11) 5 :=
  three_le_arityFloor_of_aperiodic_coincides finitePlane11Colouring.toColoring finitePlane11_aperiodic
    finitePlane11_coincides

/-- **… and at most `5`**: five distinct neighbours of the origin can never be rainbow
(`arityFloor_le_of_degree`, M45). So `arityFloor (finitePlane 11) 5 ∈ {3, 4, 5}` — the sealing plane's
compulsion structure sits exactly where de Grey's witness's does at its top rung (M48: `{4, 5}`). -/
theorem arityFloor_finitePlane11_le_five : arityFloor (finitePlane 11) 5 ≤ 5 :=
  arityFloor_le_of_degree (G := finitePlane 11) (v := (0, 0))
    ![(1, 0), (0, 1), (10, 0), (0, 10), (5, 3)] (by decide) (by decide)

/-! ### Certificates over the `√7`-free subring -/

namespace UDCert

variable {n : ℕ}

/-- **Forced equal at five colours ⟹ equal residues at `11`.** -/
theorem residue_eq_of_forces_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n}
    (h : Forces (edgeGraph n c.edges) 5 i j) :
    c.drawing Q4.sevenFree.res11 hS u i = c.drawing Q4.sevenFree.res11 hS u j :=
  Forces.image_eq_of_aperiodic finitePlane11Colouring.toColoring finitePlane11_aperiodic
    (c.drawingHom Q4.sevenFree.res11 hS hu hv) h

/-- **A virtual edge at five colours ⟹ adjacent residues at `11`.** -/
theorem residue_adj_of_separated_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n}
    (h : Separated (edgeGraph n c.edges) 5 i j) :
    (finitePlane 11).Adj (c.drawing Q4.sevenFree.res11 hS u i) (c.drawing Q4.sevenFree.res11 hS u j) :=
  Separated.image_adj_of_coincides finitePlane11Colouring.toColoring finitePlane11_coincides
    (c.drawingHom Q4.sevenFree.res11 hS hu hv) h

/-- **The distance law at `11`, forced half**: a pair listed at squared distance `r` with `r ≢ 0 (mod 11)` is
never forced equal at five colours. -/
theorem not_forces_of_pairsAt_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)} {r : ℤ}
    (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hr : (r : ZMod 11) ≠ 0) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAt Q4.sevenFree.res11 hS hu hv finitePlane11Colouring.toColoring finitePlane11_aperiodic hps
    hmem hr

/-- **The distance law at `11`, separated half**: a pair listed at squared distance `r` with `r ≢ 1 (mod 11)`
is never a virtual edge at five colours. -/
theorem not_separated_of_pairsAt_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)} {r : ℤ}
    (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hr : (r : ZMod 11) ≠ 1) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAt Q4.sevenFree.res11 hS hu hv finitePlane11Colouring.toColoring finitePlane11_coincides
    hps hmem hr

/-- **No `√7`-free certificate separates a `√3`-pair at five colours** — the first hex-shell gadget. -/
theorem not_separated_sqrt3_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 3 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAt_11 hS hu hv hps hmem (by decide)

/-- **No `√7`-free certificate separates a distance-2 pair at five colours** — the second hex-shell gadget. -/
theorem not_separated_two_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 4 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAt_11 hS hu hv hps hmem (by decide)

/-- **No `√7`-free certificate forces a distance-2 pair equal at five colours** (`4 ≢ 0`). -/
theorem not_forces_two_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 4 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAt_11 hS hu hv hps hmem (by decide)

/-- **No `√7`-free certificate forces a distance-5 pair equal at five colours** (`25 ≡ 3 ≢ 0`) — the
Exoo–Ismailescu seed's forced pair, at the distance where its unit part can never carry it. -/
theorem not_forces_five_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAt ps 25 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAt_11 hS hu hv hps hmem (by decide)

/-- **The distance law at `11` at a rational squared distance, forced half**: a pair listed at squared
distance `s / t` with `s ≢ 0 (mod 11)` is never forced equal at five colours. Nothing is asked of `t`
(`not_forces_of_distSq_ratio` says why). -/
theorem not_forces_of_pairsAtRatio_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)} {s t : ℤ}
    (hps : c.PairsAtRatio ps s t = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hs : (s : ZMod 11) ≠ 0) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAtRatio Q4.sevenFree.res11 hS hu hv finitePlane11Colouring.toColoring
    finitePlane11_aperiodic hps hmem hs

/-- **… separated half**: a pair listed at squared distance `s / t` with `s ≢ t (mod 11)` is never a virtual
edge at five colours. -/
theorem not_separated_of_pairsAtRatio_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)} {s t : ℤ}
    (hps : c.PairsAtRatio ps s t = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hst : (s : ZMod 11) ≠ t) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAtRatio Q4.sevenFree.res11 hS hu hv finitePlane11Colouring.toColoring
    finitePlane11_coincides hps hmem hst

/-- **No `√7`-free certificate with `11 ∤ D` forces a pair at distance `5/3` equal at five colours**:
`(5/3)² = 25/9` and `25 ≢ 0 (mod 11)` (as a residue, `25 · 9⁻¹ ≡ 4`).

This is the negative answer to Philip Gibbs's question on the Polymath16 blog (third thread, 2 May 2018):
is the point `5/3` the same colour as the origin in every 5-colouring of `Z ⊕ Z ⊕ Z`, where `Z` is the set
of unit-modulus numbers `ω^a η^b ζ^c` (`ω = (1+i√3)/2`, `η = (√33+i√3)/6`, `ζ = (−1+i√15)/4`)? Those
coordinates lie in `ℚ(√3, √5, √11)` with denominators built from `2` and `3`, so every certificate of that
graph, with `5/3` and the origin among its listed points, meets the hypotheses.

**Scope.** Gibbs's graph is an instance of this theorem's quantifier; no certificate of it is built here.
His second variant replaces `ζ` by `ζ₂ = (−3+i√247)/16`, whose `√247` lies outside the tower `Q4`, so for
that graph the same congruence is still a hand argument (`CLOSED-QUESTIONS.md` §1.4). The model is
Heule-510's pair `(19, 59)` below. -/
theorem not_forces_five_thirds_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAtRatio ps 25 9 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Forces (edgeGraph n c.edges) 5 i j :=
  c.not_forces_of_pairsAtRatio_11 hS hu hv hps hmem (by decide)

/-- **… nor is such a pair a virtual edge** (`25 ≢ 9 (mod 11)`): over these certificates the distance `5/3`
carries no pair compulsion of either kind at five colours. -/
theorem not_separated_five_thirds_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {ps : List (Fin n × Fin n)}
    (hps : c.PairsAtRatio ps 25 9 = true) {i j : Fin n} (hmem : (i, j) ∈ ps) :
    ¬ Separated (edgeGraph n c.edges) 5 i j :=
  c.not_separated_of_pairsAtRatio_11 hS hu hv hps hmem (by decide)

end UDCert

/-! ### Spec: the API on real certificates -/

/-- Heule-510's forced pairs at five colours, if any, have equal residues — free from the reduction. -/
example {i j : Fin 510} (h : Forces (edgeGraph 510 heule510.edges) 5 i j) :
    heule510Reduce11 i = heule510Reduce11 j :=
  heule510.residue_eq_of_forces_11 heule510_coordsIn_sevenFree heule510_denom_inv heule510_valid h

/-- The positive face, closing the loop: an edge of Heule-510 IS separated (`Separated.of_adj`), and the
theorem returns its residues adjacent — the fact the reduction homomorphism states directly. -/
example {i j : Fin 510} (h : (edgeGraph 510 heule510.edges).Adj i j) :
    (finitePlane 11).Adj (heule510Reduce11 i) (heule510Reduce11 j) :=
  heule510.residue_adj_of_separated_11 heule510_coordsIn_sevenFree heule510_denom_inv heule510_valid
    (Separated.of_adj h)

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

/-- … and it is NOT aperiodic — it is `(x + y) mod 3`, so `(1, 2)` is a period — so `Aperiodic` is a real property of a table and
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
-- Gibbs's `5/3`, stored as `25/9`: blocked both ways (`25 ≢ 0` and `25 ≢ 9`), with residue `4`. And the red
-- that pins the hypothesis as load-bearing: at `11/3` (`121/9`) the numerator vanishes and the theorem is silent.
#guard (25 : ZMod 11) ≠ 0 ∧ (25 : ZMod 11) ≠ 9 ∧ (25 : ZMod 11) * 9⁻¹ = 4
#guard (121 : ZMod 11) = 0

/-! ### The model: the `5/3` law at Heule-510

`not_forces_five_thirds_11` quantifies over certificates, so it needs an inhabitant, and a live one:
`Forces` is vacuously true on a graph that refuses five colours, so the model must be 5-colourable.
Heule-510 is (`heule510_colorable_five`), and it has pairs at exactly `5/3`: 139 of them by an exact search
of its table, of which the kernel certifies the first, `(19, 59)`. -/

/-- **Heule-510's pair `(19, 59)` is at squared distance exactly `25/9`**: `9 · distSq = 25 · 96²`. -/
theorem heule510_pairsAtRatio_five_thirds : heule510.PairsAtRatio [(19, 59)] 25 9 = true := by
  decide +kernel

-- The check refuses a wrong ratio: the pair is not at squared distance `5/3`.
example : heule510.PairsAtRatio [(19, 59)] 5 3 = false := by decide +kernel

/-- The pair really is `5/3` apart in `ℂ`, through `pairsAtRatio_sound`. -/
example : dist (heule510.point 19) (heule510.point 59) = 5 / 3 := by
  have h := heule510.pairsAtRatio_sound (by decide) (by decide) heule510_pairsAtRatio_five_thirds
    (19, 59) (List.mem_singleton_self _)
  rwa [show ((25 : ℤ) : ℝ) / ((9 : ℤ) : ℝ) = (5 / 3) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)] at h

/-- **The `5/3` law on a live object**: in the 5-colourable Heule-510 — not Gibbs's graph, of which no
certificate is built here — the pair `(19, 59)` at distance `5/3` is not forced to share a colour at five
colours. -/
example : ¬ Forces (edgeGraph 510 heule510.edges) 5 19 59 :=
  heule510.not_forces_five_thirds_11 heule510_coordsIn_sevenFree heule510_denom_inv heule510_valid
    heule510_pairsAtRatio_five_thirds (List.mem_singleton_self _)

/-- … nor forced apart. -/
example : ¬ Separated (edgeGraph 510 heule510.edges) 5 19 59 :=
  heule510.not_separated_five_thirds_11 heule510_coordsIn_sevenFree heule510_denom_inv heule510_valid
    heule510_pairsAtRatio_five_thirds (List.mem_singleton_self _)

/-- The model is live: Heule-510 is 5-colourable, so the `Forces` refuted above is not vacuously true. -/
example : (edgeGraph 510 heule510.edges).Colorable 5 := heule510_colorable_five

end HadwigerNelson
