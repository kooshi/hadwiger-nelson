# FS-79 phase P3 — every cell of Θ₄ on `L21cc6506`, exactly

*The P3 implementer (de Bruijn), 2026-09-24. Close-inventory item 89 (3): enumerate every cell of L21cc6506's Θ₄ exactly before any
forcing run for route (ii) (G55's chain at five colours over ℚ(√167)).*

## Registration (written and committed before the first run)

**The question.** Θ₄ = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(u) ∈ [1/4, 3/4] mod 1 for every u ∈ U}, Λ = `L21cc6506` = Λ₄₂₀, U its 60 unit vectors.
Its cells are the nonempty polytopes {θ ∈ ℝ⁴ : k_u + 1/4 ≤ θ(u) ≤ k_u + 3/4}, taken up to ℤ⁴ translation. For each cell: its dimension,
its constant unit vectors, one rational point. Then the intersection over all cells of the constant sets, and the upper bound on `P`
that the circular colourings give: `P ⊆ P_circ = ⋂_cells {δ ∈ Λ : V_cell(δ) = 0, θ_cell(δ) ∈ ℤ}`, where `V_cell` is the direction
space of the cell's affine hull.

**A reduction noted before running (to be checked, not assumed).** Multiplication by `i`, complex conjugation and the Galois flip
`√167 ↦ −√167` map the set of denominator-420 unit vectors to itself, so (if the run confirms it) they are automorphisms of
`Cay(Λ, U)` and the cell set is invariant under them. They preserve the rational pattern U_R and act on the rational plane by a rotation
of order 4, which fixes no line. The known 5,880 cell's constant set is exactly U_R. So the bound's real span `W = ⋂ V_cell^⊥` is either
**0** or **the rational plane**; nothing in between is possible, except through an error in this argument. The intersection of constant
sets is then one of ∅, {±1, ±i}, the other eight vectors of U_R, or all twelve.

**Prediction P3-1.** Probabilities for the intersection of the constant sets and the bound `W`:

| outcome | probability |
|---|---|
| `W = 0`: some cell of dimension ≥ 1 moves the rational layer, so the intersection of constant sets spans rank 0 and route (ii) at L21cc6506 is dead from circular colourings alone | 0.50 |
| `W` = the rational plane: every cell of dimension ≥ 1 freezes the rational layer, so the intersection is (a G-invariant part of) U_R and route (ii) stays open (not supported) | 0.45 |
| anything else (a rank-1 or other bound), which the symmetry argument above forbids | 0.05 |

*Why so even.* The two known cells point opposite ways: the 4,200 cell is a point, the 5,880 cell freezes exactly U_R. Nothing I know
makes the rational layer special among the five layers `b·U_R` (b ∈ {1, v, v̄, z, z̄}) except that it is the only one fixed by the
symmetries, which is no reason for it to be frozen in every cell. **Also registered:** the cell count is below 10⁴ (0.8), and no cell
is full-dimensional (0.7).

**Controls, both outcomes reachable.**
1. The 4,200 point and the 5,880 point (phase 0's witnesses) must fall in enumerated cells of dimension 0 and 2, with 60 and 12 constant
   unit vectors. A miss means the enumeration is wrong.
2. The same code at three colours must find Θ₃ empty (row 79). A leaf there means the code is wrong.
3. A planted fault, one ± pair of unit vectors dropped, must change the enumeration. If it does not, that pair's constraint is redundant
   everywhere, and the plant must be moved to another symmetry orbit before the control counts.
4. The cell set must map to itself under every automorphism in (A) above. A cell whose image is not in the list means a missed cell.

## What happened

**The frame (measured before the tree).** No four unit vectors form a ℤ-basis of Λ: the least index of a quadruple's span is 34,650
(= 2·3²·5²·7·11, eight quadruples), so the planned "one leaf per class" box was impossible. The tree uses FS-73's frame instead: a
dual-LLL-reduced ℤ-basis B of Λ (rows over 420: (0,1,1,0), (1,0,0,1), (0,0,2,0), (−2,0,0,0)), the fundamental box x = θ(B) ∈ [0,1]⁴, and
translation classes identified by an integer normal form of the band vector modulo C·ℤ⁴. The builder and the checker use different
normal forms. The coefficient vectors have ℓ¹ norm 195–298.

**The tree's size is intrinsic.** U is five layers b·U_R, b ∈ {1, v, v̄, z, z̄}. For a pair of layers the joint map (μ_b, μ_b′) : ℝ⁴ → ℝ⁴
has |det|/5⁴ periods of the 5ℤ²-periodic Θ_R; the least is (1, v) with 1,764 (1 and v̄ also 1,764; the others 6,889 to 72,900). So the
tree visits about 1,764 × (cells of Θ_R per period)² partial cells. Order pilots on one subtree: rational, v, v̄, z, z̄ finished in 74,370
nodes; the static ℓ¹ order had not finished at 118,717; interleaving the layers took 85,006. **Projected full tree: about 1.7·10⁷ nodes,
~11 min on 28 workers, ~130 MB of gzip.**

**The smoke run found the answer.** Two of the 210 depth-1 subtrees (x₃-slabs 0 and 1), run as a test, held 28 translation classes:
**22 of dimension 4**, 4 points, 2 of dimension 2. A full-dimensional cell makes the circular-colouring bound on P zero outright (theorem
below). I sent that to the owner before the full run. The owner verified it independently and **ruled the full exact tree out of
scope**: it existed to bound P, and P = 0 is already proved. The full run had been launched (process group 1727646, 28 workers). It was
killed by process group about five minutes in, before any subtree finished, and verified stopped (no process left in the group, the
output directory static for 10 s, the heavy lock free). **What the kill forfeits:** the complete cell census (counts by dimension over
all 210 subtrees, and the check that the whole list maps to itself under i, conjugation and the Galois flip). Nothing downstream needs
either tonight. The builder resumes it exactly if it is ever wanted:
`flock … python3 tools/fs79_p3_theta4.py tree 4 data/fs79/p3/tree-k4 --workers 28`, then `cells` and `report`.

## Results

**The theorem.** On `L21cc6506` at four colours, **Θ₄ has a full-dimensional cell, so P = F = 0.** No pair is forced, and no pair is
identified by every periodic four-colouring. **Route (ii) (G55's chain from a forced pair δ with 1/δ ∈ ℤ[U]) is dead on this lattice.**
It is not dead on other lattices over ℚ(√167), and nothing here bears on whether ℚ(√167)'s plane needs five colours.

**The witness.** θ₀ = (−4723/324, −1196/81, 1/324, −73/648) on B, a linear form of order 648. For every one of the 60 unit vectors,
θ₀(u) mod 1 ∈ [1/4 + 1/324, 3/4 − 1/324]; the minimum margin is exactly 1/324.
- `data/fs79/p3/fulldim-cell-witness.json`, CERTIFIED by the untouched phase-0 checker `tools/fs79_p0_check.py`.
- The owner verified it with his own code: B spans exactly Λ₄₂₀; the margin is 1/324; the largest ℓ¹ norm is 298; 200 random rational
  perturbations inside the ball stay in band; a planted θ₀ + 1/8 is refused.

**The argument, written out.** Here r = (1/324)/298.
1. *An open ball lies in Θ₄.* If ‖θ − θ₀‖_∞ < r, then |θ(u) − θ₀(u)| ≤ ‖c_u‖₁ · ‖θ − θ₀‖_∞ < 298 · r = 1/324 for every u. So θ(u) mod 1
   stays strictly inside (1/4, 3/4), in the same band as θ₀(u). The ball lies in one cell, and that cell is 4-dimensional.
2. *Each rational point gives a periodic colouring.* For rational θ in Θ₄ and rational β, c_{θ,β}(x) = ⌊4{θ(x) + β}⌋ is a proper
   four-colouring (T22's ⟸ at k = 4). Adjacent vertices x and x + u have fractional parts at circular distance
   ‖θ(u)‖_{ℝ/ℤ} ≥ 1/4, and two points of one quarter-arc [m/4, (m+1)/4) are closer than 1/4. The colouring is periodic under
   ker(θ mod 1), which has finite index.
3. *Separating shifts.* Let δ ∈ Λ with s = θ(δ) mod 1 ∉ {0}. If s < 1/2, take {β} = 1/4 − s/2. Then c(0) = 0, and
   {β + s} = 1/4 + s/2 ∈ (1/4, 1/2), so c(δ) = 1. If s ≥ 1/2, take {β} = 1/4 + (1 − s)/2 ∈ (1/4, 1/2], so c(0) ≥ 1, and
   {β + s} ∈ (0, 1/4), so c(δ) = 0. Either way the periodic colouring c_{θ,β} separates 0 from δ, and β is rational when θ is.
4. *Every δ ≠ 0 is separated.* θ ↦ θ(δ) is a nonzero linear functional (δ has a nonzero coordinate vector), so on the open ball it takes
   an open interval of values. The set of θ in the ball with θ(δ) ∉ ℤ is therefore nonempty and open, and it contains a rational θ. Step 3
   then gives a periodic proper colouring separating 0 and δ.
5. *Conclusion.* By T36, P = ⋂_{c periodic} Per(c) and F ⊆ P. Since every δ ≠ 0 lies outside some Per(c), **P = 0 and F = 0**. In
   particular C3-inherit (P = F) holds at L21cc6506 at four colours, trivially. The bound is not visible to any finite family: finitely
   many periodic colourings always meet in a full-rank group, as C8's census found (12Λ over 4,490 orbits).

**Smoke census, PARTIAL (2 of 210 depth-1 subtrees, x₃-slabs 0 and 1).** 159,641 nodes, 28,540 dead ends (the certified range misses
every band), no Farkas nodes (no listed child was empty; counted in the files), 34 leaves, 28 translation classes:
**22 of dimension 4, 4 of dimension 0, 2 of dimension 2.** The intersection of their constant sets is ∅, and W = ⋂ V^⊥ = 0.
- Files: `data/fs79/p3/smoke-k4/` (header and two subtree certificates) and `data/fs79/p3/smoke-k4-cells.jsonl`. Each cell record holds
  its dimension, its affinely independent exact points, two-sided dual certificates for every equality direction, its constant set and a
  barycentre.
- CERTIFIED by the standalone checker `tools/fs79_p3_theta4_check.py`, which recomputes U twice, the frame, every node's bounds and
  child list, every leaf point, its own translation normal form, and every cell's dimension (≥ by points, ≤ by equality certificates)
  and constant set. Transcript: `data/fs79/p3/smoke-k4-checker-run.txt`.
- **Not claimed:** the total number of cells, the full distribution by dimension, or that the smoke classes are all the full-dimensional
  ones. A projection from 2 of 210 slabs (about 3,000 classes) is an estimate, not a count.

## Controls

| control | outcome | status |
|---|---|---|
| 1. The known points (phase 0's witnesses), exact cell analysis on the cell containing each (`data/fs79/p3/known-points-cells.json`) | order 4,200: **dimension 0**, 60 constant, 14 unit vectors at a band edge. Order 5,880: **dimension 2**, 12 constant, **exactly U_R**, 8 at a band edge at the relative-interior barycentre. The owner had verified both by float LP (item 86); this is the exact confirmation. | passes |
| 1′. The same points among the enumerated classes | not possible without the full census (checked: neither point's class lies in slabs 0–1) | forfeited with the full run |
| 2. Θ₃ with the same code, the same two subtrees (`data/fs79/p3/smoke-k3/`) | 11,348 nodes, **0 leaves**, CERTIFIED by the checker at k = 3 | passes (partial: 2 of 210 subtrees; Θ₃ = ∅ itself is row 79's, by two independent certificates) |
| 3. Planted fault: the ± pair of half-set vector 4 (layer z̄) dropped, same two subtrees (`data/fs79/p3/plant-drop4-k4/`) | 57 classes against 28 (13 points, 2 of dimension 1, 15 of dimension 2, 27 of dimension 4). Faithful classes with that coordinate projected out form a strict subset, with 29 new classes, as dropping a constraint must give | passes: the enumeration changed |
| 4. Symmetry of the whole cell list under i, conjugation, Galois | needs the full census | forfeited with the full run (the three maps were confirmed to permute U) |
| Checker plants (smoke data) | a dropped node → MISSING_NODE; a dropped child → CHILDREN; an extra constant vector → CELL_CONST; a dimension claimed 3 for 2 → CELL_DIM. Each refused for its own reason | passes (`smoke-k4-checker-run.txt`) |
| The full-dimensional witness | CERTIFIED by `tools/fs79_p0_check.py` (untouched); the owner's independent checks, including a planted θ₀ + 1/8 refused | passes |

**A reading of Coxeter's numbers, not a disagreement.** C6 reported "12 of 60 constraints tight" at the order-5,880 point. At the cell's
relative-interior barycentre, 8 unit vectors sit at a band edge and 12 are constant: four of U_R (±1, ±i) are constant at an interior value.
The phase-0 point θ need not be in the relative interior. C8′'s "12 fixed" is the constant count, and it agrees.

## Predictions, scored

| prediction | registered | outcome |
|---|---|---|
| P3-1: W = 0 (some positive-dimensional cell moves the rational layer) | 0.50 | **won**: a full-dimensional cell moves everything |
| P3-1: W = the rational plane | 0.45 | lost |
| P3-1: anything else | 0.05 | lost (the symmetry argument's dichotomy held) |
| No cell is full-dimensional | 0.70 | **lost**: 22 of the 28 smoke classes are full-dimensional |
| The cell count is below 10⁴ | 0.80 | not scored: the census was not run (the smoke rate suggests about 3,000, unmeasured) |

## Instrument notes (for the close)

- **Read the answer from the cheapest object that can hold it.** The question needed one full-dimensional cell, which a two-subtree smoke
  test showed in three minutes. The planned object was a 1.7·10⁷-node census. The registration had also bet against full-dimensional cells
  (0.7), so the smoke test was the first look at the thing being predicted, and it was decisive.
- A gap between two known cells (a point, a 2-cell) said nothing about the rest: the phase-0 search stops at its first FOUND point, and
  the dimension checks were run only on those two. G21, "a negative measures its enumeration", in the form "two cells measure the search
  that found them".
- A bug met and fixed on the way: the cell analysis looped over 30 vectors when the plant had 29 (an IndexError, explained, fixed before
  the plant's cell step was rerun).

## Theorems this phase proved

| id | statement | grade | proof / address |
|---|---|---|---|
| P3-T1 | θ₀ = (−4723/324, −1196/81, 1/324, −73/648) on B lies in Θ₄ with margin 1/324. So the ℓ∞-ball of radius 1/(324·298) about θ₀ lies in one cell of Θ₄, which is **full-dimensional** | cert (tools exact; the phase-0 checker) + hand (step 1) | `data/fs79/p3/fulldim-cell-witness.json`; argument above |
| P3-T2 | For rational θ ∈ Θ₄ and δ with θ(δ) ∉ ℤ, some rational β makes ⌊4{θ(x) + β}⌋ a proper periodic four-colouring separating 0 and δ | hand | steps 2–3 above |
| P3-T3 | **On L21cc6506 at four colours, P = F = 0.** No forced pair, so G55's chain (route (ii)) has no input on this lattice; C3-inherit holds there trivially | derived (P3-T1, P3-T2, T36) | steps 4–5 above |
| P3-T4 | Smoke census, PARTIAL: slabs 0 and 1 of 210 hold 28 translation classes (22 of dimension 4, 4 of dimension 0, 2 of dimension 2), with an empty intersection of constant sets | tools exact, partial; checker-certified | `data/fs79/p3/smoke-k4*` |
| P3-T5 | The order-4,200 point's cell is a point. The order-5,880 point's cell has dimension 2, and its constant set is exactly U_R (12), 8 of them at a band edge in the relative interior | tools exact | `data/fs79/p3/known-points-cells.json` |
| P3-T6 | No four unit vectors of L21cc6506 form a ℤ-basis of Λ; the least index of a quadruple's span is 34,650 | tools exact | `tools/fs79_p3_theta4.py` (the determinant histogram) |
| P3-T7 | Among the five layers b·U_R, the joint map of (1, v) or (1, v̄) has the least |det| (1,102,500 = 1,764 · 5⁴) | tools exact | as above |

*Kernel decision:* declined for all. P3-T3 closes a route rather than opening one, and nothing downstream consumes it in the kernel.

## Files

`tools/fs79_p3_theta4.py` (builder: `tree`, `cells`, `report`; resumable), `tools/fs79_p3_theta4_check.py` (standalone checker, standard
library only), `data/fs79/p3/` (the witness, the known-point cells, the smoke data at k = 4 and k = 3, the plant, and checker transcripts).
