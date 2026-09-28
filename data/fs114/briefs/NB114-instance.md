*Instance file for job **FS114-NB** (the brief is `data/fs114/briefs/NB114-verify-proof.md`). Written by the product owner, 2026-09-27 night, at
FS114-N's stage-1 hand-back. The statements below are FS114-N's, quoted from its record with its proofs, grades and verdicts withheld; the claim ids
of `data/fs114/claims.md` are named where the side gave a verdict on one. Derive your own verdict on each: TRUE, FALSE (a counterexample), GAP at a
named step, or MISSTATED (with the corrected statement).*

## Terms (the side's, for these statements)

- `M` is the map graph (faces adjacent when their closures meet); `N[x]` is a face `x` with its `M`-neighbours; `deg_M(f)` is a face's `M`-degree.
- A **repeat at `x`** is a pair `y ≠ z` of tiles of one colour in `N[x]`.
- `F ∪ R`: FS-112's four-colour and repeated-colour vertices (`data/fs114/claims.md` §0). **Anchoring**: FS-112's statement that a point of `cl x` met
  by another tile at that point alone lies in `F ∪ R` (check it, as the side uses it).
- `ω(q)`: the unit circle about `q`. Siamese, close, far: as in each statement.
- On a cellular map of the torus: `V`, `E`, `F`, vertex degrees `d(v)`, face lengths `s(f)`, `V_d` the number of vertices of degree `d`, and `μ_f ≥ 0`
  counting the neighbours a face meets more than once (`μ = Σ_f μ_f`).

## The statements, in priority order

1. **N114-RD (the rainbow deficit).** In a valid map every repeat at a tile `x` is (S) a close pair, or (A) a unit arc of `∂x` shared with one member and
   centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q` alone, or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R` with
   `|p − q| = 1 = diam x`; at most one member of a far pair shares an arc with `x`. *Say what radius it reads.*
2. **N114-EULER.** On a cellular torus map: `Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d(v) − 2)(d(v) − 3) − μ`.
3. **N114-FIVE.** At `k = 5`, on a non-Siamese valid map that is cellular on a torus with `μ = 0`, where each face needs at least `deg_M(x) − (k − 1)`
   repeats, the type-(A) supply is at most `E`, and the type-(B) repeats number at least `F + V₄ + 4V₅`. Then C114-FIVE-COUNT's status as a positive
   control for a six-colour count (the claim list's §8).
4. **N114-ROOM.** At `k = 6`, on the same class, the same count forces type-(B) repeats only when `V₄ < 3V₆`.
5. **N114-COMPACT** = C114-COMPACT at every `K`, with the side's addition: a radius uniform in `K` exists if and only if C-LOCAL holds, and then (with
   FS112-N3-DENSE3) at radius `R + 3`.
6. **N114-VOR.** `[Voronov2023]` Thm 1.3 applied to a valid map's closed colour classes gives: every open disc of radius 3 holds a same-colour unit
   contact (a tile of diameter exactly 1, or two same-colour tiles at distance exactly 1). Then C114-VOR's verdict: can a valid map with unit arcs, read
   almost everywhere, replace the step closedness buys?
7. **C114-THOM-TOP**, with the side's statement to check: Lemma 1 holds for the map graph of every valid map; the topological step "`M − x` is
   connected" fails at a tile with a hole or a pinch point, and is repairable in the non-Siamese case by Thomassen's own count of same-colour faces in a
   set of diameter `< 2`, but not with Siamese pairs.
8. **N114-CUBIC.** No cubic, non-Siamese valid six-map, cellular on a torus with `μ = 0`, exists.
9. **C114-EDGE-RAINBOW**, **C114-RAINBOW** and **C114-DUAL-COUNT**, as the claim list states them.
10. **N114-FAR.** Two distinct tiles of one colour in a valid map are close (`T ∪ T′` of diameter `≤ 1`) or far (`inf |a − b| ≥ 1`); touching tiles of one
    colour are close; every tile has diameter `≤ 1`.

**The controls** (the brief's item 3): check 1, 3 and 4 against the strip, the disk, FS112-BOWTIE and the hexagonal seven-colouring, and run the
five-colour count through 3 before any six-colour statement.
