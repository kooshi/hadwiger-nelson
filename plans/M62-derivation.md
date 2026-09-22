# M62 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Filed 2026-09-22/23 by the FS-71 batch-4a implementer (the theorem audit, `plans/FS71-theorem-audit.md`). M62 is
"the evolutionary type-M search" (`plans/M62-evolutionary-type-m.md`, minted 2026-09-09, an attempt to beat
`[Parts2020a]`'s 509-vertex record with a genome search whose feasibility filter and fitness are derived from this
project's own theorems). The milestone did not beat the record (best certified 1-minimal object: 583 vertices,
`§R23`) — its lasting content is four derivations that turned a night of search into a set of reusable facts about
type-M arenas at `ρ₁₅`. Enumeration: the whole plan file read in full (1,500 lines, §PA–§R23); the two Poros
advisories it credits (`plans/POROS-2026-09-10-m62.md`, `plans/POROS-2026-09-10-orbit-polytope.md`) grepped for
theorem-shaped content not already paraphrased in M62's own §R11–§R14 (none found beyond what M62 already states,
confirmed by heading and keyword search); `data/m62/README.md` read for provenance (all tools-side, no additional
theorem content); `tools/parts_faces.py`, `tools/parts_reduce.py` docstrings spot-checked (restate rather than add,
per batches 1–3c's repeated finding); the four now-superseded stubs (`STUB-orbit-filling-polytope.md`,
`STUB-parts-base-reconciliation.md`, `STUB-parts-reproduction.md`, `STUB-smus-reduction.md`) confirmed superseded/
absorbed by their own banners, nothing beyond what M62/M64/FS-32/M63 already carry.*

## The theorems

**M62-T1 — The rotation-admissibility trichotomy. [hand; the M62 implementer]** For a base in `K`
(`ℚ(√3,√5,√11,√33)`) and two circle radii `|u|², |v|² ∈ K`, a rotation carrying a unit chord between a point of
radius `|u|` and a point of a rotated copy of radius `|v|` exists only for the rotation adjoining `√D`, where
`D = |u|²|v|² − k²` and `k = (|u|² + |v|² − 1)/2`, with `D` decided entirely in `K`-arithmetic by an exact tower
squareness test (no float in any verdict): **`D < 0`** — no such rotation; **`D` a square in `K`** — the rotation
lies in `K(i)`, the union of base and rotated copy stays in `K²`, and **Theorem B four-colours it for free**, so
it is never a candidate; **else** — the rotation adjoins `√D` and leaves `K`, a wall-breaking candidate. *Proof:*
`plans/M62-evolutionary-type-m.md` §R1 (`tools/typem.py`, `tools/typem_exact.py`); the exact enumeration on the
Moser lattice base found 762,129 radius pairs, of which 125,232 were REJECTED-IN-K by Theorem B and 123,785 admit
no rotation, leaving 1,336 rotation classes (later corrected to 10 exact classes on a properly scoped enumeration,
`plans/STUB-consume-rotation-list.md` — the trichotomy itself is unaffected by that correction, only the count of
classes it was run over). *Proof verdict:* closes. *Rests on it:* the candidate-rotation screen behind row 64's
`ρ₆₃` object and FS-70's field screen (T4 of `plans/FS70-derivation.md`); the finding that the record's own rotation
ranks 58th of 1,336 by cross-edge-family count, with five unused families at the record's own rotation. *Prior art:*
Theorem B is ours (row 57); the squareness-test decision procedure over a quadratic tower is routine field
arithmetic, no paper sought — nearest held: `[Parts2020a]`, which never poses this as a decision procedure (his
open question 2, "working constructions of type M with other rotations are not known yet", is exactly what this
trichotomy answers with an enumerable list); zbMATH: `ab:"unit distance graph" & ab:"rotation" & ab:"admissible"`
(0), `ab:"spindle" & ab:"quadratic field" & ab:"square class"` (0). *Kernel:* declined — a computational sieve
consuming `FieldWall4.lean`'s Theorem B, not a standalone target.

**M62-T2 — The pattern-clash correctness theorem for a two-block arena. [hand; the M62 implementer, corrected by
Poros]** For an arena `L ∪ ρS` sharing one centre vertex, with `P_S` the set of colour patterns `S` (with the
centre pinned) can impose on the cross-edge endpoints it shares with `L`: **`L ∪ ρS` is 4-colourable iff there
exists `q ∈ P_S` such that `L` admits a proper 4-colouring avoiding, at each cross-edge endpoint `v`, the colour
`q[v]`** — equivalently, `L ∪ ρS` refuses four colours iff `L` "kills" every box `Safe(q)`, `q ∈ P_S`, checkable by
one solver call per element of `P_S` on the `L`-only graph (with the shared centre's colour folded into thirty
extra unit clauses on the `S` side, not a pattern dimension). *Proof:* `plans/M62-evolutionary-type-m.md` §R8 (the
derivation, from Theorem B's giving both `L` and `S` individually 4-colourable so the fifth colour is bought
entirely by cross edges) and §R11–§R13 (Poros's correction of the acceptance test the implementer first coded,
which computed `P_S` once on the full arena and never updated it — a different, wrong fixed point that provably
rejects even Heule-510's own `L` in 0 seconds; `typem.kills_all_boxes` is the corrected implementation, confirmed
against the positive control). *Proof verdict:* closes. *Rests on it:* every acceptance test M62 ran from §R13
onward (`tools/m62_run.py`, `tools/m62_descent.py`); the exhaustive 32-subset subtype law of §R20 (M62's own
consumer, filed as a measurement below, not a separate theorem). *Prior art:* ours — the general CSP-decomposition
shape (colour one block, propagate as unit clauses to the other) is folklore of constraint satisfaction, but FS-32's
own prior-art gate (`plans/FS32-smus-reduction.md` §PA) found no paper joining it to unit-distance-graph critical-
subgraph search specifically; zbMATH: `ab:"constraint propagation" & ab:"colouring" & ab:"pattern"` (0), `ab:"unit
distance" & ab:"two block" & ab:"pattern"` (0). *Kernel:* declined — an algorithm-correctness lemma for a specific
search's acceptance test, not a mathematical target in its own right.

**M62-T3 — The `ρ₁₅` cross-edge radius bound. [hand; the M62 implementer]** Every cross-edge endpoint `u` of a
type-M arena at rotation `ρ₁₅ = (7 + i√15)/8` satisfies `|u|² ≤ 64/15` (radius `≤ 8/√15 ≈ 2.0656`). *Proof:* the
collinearity clause of the cross-edge law (M31's quadrature law, G12, specialised to `ρ₁₅`) forces
`|u − ρv|² = t² + s² − (7/4)ts = 1` for the conjugate radius `s = |v|`; the quadratic form in `(t,s)` is positive
definite (`(7/4)² = 49/16 < 4`), so its level set is an ellipse, and a real solution `s` exists only for
`t² ≤ 4/(4 − 49/16) = 64/15`. `plans/M62-evolutionary-type-m.md` §R22. *Proof verdict:* closes. *Rests on it:*
the finding that enlarging the arena's radius past 2.0656 adds only interior material and leaves the cross-edge
count exactly fixed at 126 (measured unchanged from `r = 2.00` to `r = 2.44`), which is why Heule-510's own
757-vertex orbit closure could be reconstructed exactly by enlarging the base rather than by re-deriving the
cross-edge structure — the "arena was the wrong object" finding of §R22 that produced the milestone's fastest
descent (nine certified 1-minimal objects in ~15 minutes, against 43 minutes with none converged on the
undersized arena). *Prior art:* ours — a direct algebraic consequence of the quadrature law (M31-T1, already in
`LEDGER.md` § B), specialised to one rotation; no separate paper sought. *Kernel:* declined — feeds a search radius
choice; would be subsumed by any future generalisation of `quadrature_rho15` (`Quadrature.lean`) to an explicit
radius bound, not separately worth stating in Lean.

**M62-T4 — Parts's order-24 symmetry group is `⟨ζ₆⟩ ⋊ Gal(K(i)/ℚ)`, and it preserves both unit distance and the `ρ₁₅` cross-edge law. [hand; the M62 implementer, re-deriving the record-holder's §2 group from the geometry]** On
coordinates `z = (a + b√33 + i(c√3 + d√11))/12`, the order-24 group closing Parts's base (rotation by 120°, both
axis reflections, and "conjugation by `√33`" per his footnote) is `⟨ζ₆⟩ ⋊ Gal(K(i)/ℚ)`: complex conjugation is
itself the Galois automorphism `√3, √11 ↦ −√3, −√11` (which fixes `√33` and negates only the imaginary part — the
geometric reflection `y ↦ −y`), and the other nontrivial Galois element, fixing `√33` while negating `c√3` and
`d√11` individually is impossible over `K(i)` — the two extra order-2 generators beyond `⟨ζ₆, conj⟩` are
`√3 ↦ −√3` alone and `√11 ↦ −√11` alone (both arithmetic symmetries of `K` with no direct geometric meaning, since
neither alone is an isometry of the plane — they compose to the geometric reflection). Every element is a ring
homomorphism fixing `ℚ` applied coordinatewise, hence preserves unit distance; both clauses of the `ρ₁₅`
cross-edge law are polynomial identities over `K`, hence preserved too — so the whole type-M arena is equivariant
under the order-24 group and **orbit-level selection is sound**. *Proof:* `plans/M62-evolutionary-type-m.md`
§R19(1)–(2), verified by testing all four generators against the base (0 images outside under the correct group;
`⟨rot₆, conj⟩` alone, order 12, had been used through §R18 and gives the wrong orbit count) and against the
cross-edge structure (orbit sizes `{1,6,12,24}` reproduced exactly, matching Parts's own stated orders; his 19
published orbit labels reproduced as 18/19 all-even canonical representatives). *Proof verdict:* closes. *Rests on it:* the corrected base reconstruction (1,603 points / 92 orbits at radius 2, matching `[Parts2020a]` §5.6
exactly: points, orbit sizes `{1:1, 6:11, 12:32, 24:48}`, 0 images outside, 18/19 published labels as canonical
reps); M64's entire rung-lattice analysis (M64-T1, M64-T2 below), which assumes this group acts on `Aut(A)`.
*Prior art:* `[Parts2020a]` §2 states the group's generators and order without identifying it algebraically or
proving it preserves the cross-edge structure; that identification and the preservation argument are the M62
implementer's. zbMATH: `ab:"CM field" & ab:"unit distance" & ab:"symmetry group" & ab:"order 24"` (0), `ti:"Galois"
& ab:"reflection" & ab:"quadratic field" & ab:"unit distance graph"` (0). *Kernel:* declined — group-theoretic
bookkeeping feeding a search, not a standalone Lean target.

## Readings and measurements that were called theorems, or that might look like ones

- **§R1's "1,336 rotation classes" and "412 type-M admissible"** — a [tools] enumeration over one specific base at
  one specific radius (measured, not derived); explicitly marked in the plan as **SUPERSEDED** on review
  (2026-09-13): the count conflated field classes with rotations and was run on the wrong lattice. The exact,
  corrected enumeration (10 classes, 1 wall-breaking, 0 six-open) is `plans/STUB-consume-rotation-list.md`'s and is
  batch 4's (M63) territory if it produced any further theorem — not opened here, out of scope. Neither count is a
  theorem; the trichotomy that generates the list (M62-T1) is.
- **§R6's cost-structure inversion ("the solver is fast on 4-colourable and slow on NOT-4-colourable")** — an
  engineering/empirical measurement about CaDiCaL's behaviour on this instance family, not a mathematical claim; it
  drove an algorithm choice (binary search over a radius-ordered prefix instead of chunked deletion) but is not
  filed as a theorem.
- **§R9's "neither cross-edge kind suffices alone, both necessary" and §R20's exhaustive 32-subset subtype law**
  ("a connection works iff it carries BOTH kinds", `(2²−1)(2³−1) = 21` all-UNSAT, `2²+2³−1 = 11` all-SAT) — a
  [tools] exhaustive census on one specific corrected base (32 SAT asks, no cap, no unknown), confirming and
  sharpening a claim `[Parts2020a]` §3 states without measurement. Object-specific; not a general theorem about
  type-M arenas at other rotations or bases, so not filed as one. It is the sharpest confirmed instance of M62-T2's
  mechanism (cross edges of only one radius family can never kill every `L`-pattern).
- **§R14/§R18's reconstruction narrative** (the "seam base" vacuity, the various orbit counts before the correct
  group was found) — a sequence of measurements and corrected mis-readings, not theorems; the final, correct facts
  are M62-T4 and the base-matching numbers cited there.
- **§R23's speed-campaign findings** (round-1–5: solver-version comparison, the orbit-closed census being exact at
  47 asks not 756, the `sqrt(2 ln N)` argument that no amount of order diversity reaches 509 from a distribution
  centred at 594.4) — engineering measurements and a standard order-statistics argument (not new), not filed.

## Conjectures surfaced, not claimed

- **§R18(3): the "pointwise `abcd = 0`" reading is dead**, and the milestone explicitly declines to pursue a
  replacement reading further ("Most likely it is a condition on the orbit's canonical representative... Not
  pursued further"). No consumer; not a stub target.
- **The residual open half of FS-31's boundary question** ("whether his 'about 400' counts orbits inside the disk
  or orbits meeting it") is resolved as immaterial by §R22 (the real issue was the *radius*, 2.0 vs 2.44, not the
  disk-boundary convention) — not a live conjecture.
- **P5 (M6B/M6C beating M6A at equal effort) and the second rotation question (P2)** were never scored: phases
  B–E of the original §1 plan (genome, engine, run, certification) were **not run** as a genetic-algorithm loop in
  the form originally specified; the milestone became a derivation-and-descent exercise instead, reported honestly
  in §R2 ("Not run") and never revisited. Not filed as a conjecture (no statement to demote), recorded as an
  unscored prediction.

## Prior art re-attributed

None. M62 does not claim to be first at any theorem the gate re-attributed; every prior-art item found (Wagner2021,
MundingerEtAl2025, the SMUS/MUS literature) was already correctly recorded as "not held / named only" in
`BIBLIOGRAPHY.md` by the milestone's own §PA, and the theorems filed above (M62-T1–T4) are the implementer's own
derivations layered on top of that recognised background, not restatements of it.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M62-T1 | declined — a computational sieve over Theorem B (`FieldWall4.lean`), not a standalone target |
| M62-T2 | declined — an algorithm-correctness lemma for one search's acceptance test |
| M62-T3 | declined — feeds a search radius; subsumed by any future generalisation of `quadrature_rho15` |
| M62-T4 | declined — group-theoretic bookkeeping feeding orbit-level search |
