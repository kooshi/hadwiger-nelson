# The certificate of the copy lock: the 883-point core as a kernel-checked 5-chromatic unit-distance graph (pre-subplan stub, UNNUMBERED — the COMPETING next milestone)

*Stub drafted 2026-09-02 during M52. Numbered if minted (milestones are numbered as minted). The
object cards are `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`; the finding that repriced this is M52 T14
(`plans/STANDING-QUESTIONS.md`); the exact coordinates already exist in `data/m52/exact-*.json`.*

## What it would certify

`data/m51/m51-copycore-about206-graph.json` (as an edges sidecar: `data/m52/core883-edges.json`):
883 points — 434 of the iteration-3-era descended object (102 seed + 332 glue points to depth 4)
and 449 of its ρ₁₅ copy about vertex 206 — with 4,625 unit edges, 20 of them cross chords, that
**refuses four colours** (tools level: three encodings; 1-minimal over 3,412 asks). Kernel-checked
it would be: *a unit-distance graph in the plane that is not 4-colourable*, hence χ(ℝ²) ≥ 5 — a
known bound, by a NEW witness of a new genre: seam-group fabric (every direction on the half-twist
ladder, every point in ℚ(√3, √11)) made 5-chromatic by ONE √5-rotation (ρ₁₅) — G1's field wall
realized from below, with the kill distributed over thirteen chords (T15) rather than a spindle.

## What it costs, after T14

* **Geometry**: every point of the original side is in ℚ(√3, √11) with exact 4-basis coordinates
  (`copy_exact_field.py`: all 13,796 edges of the iteration-4 object verified as exact identities);
  the copy side is `c + ρ₁₅(p − c)` with ρ₁₅ = (7 + i√3√5)/8, so the whole core lives in
  ℚ(√3, √5, √11) ⊂ ℚ(√3, √5, √7, √11) — **M02's iterated-quadratic representation, height 4, the
  one de Grey's certificate used**. The per-edge unit identity is the M06 pipeline's check, not a
  new compositum engine. Cost: the emitter (`tools/emit_cert.py`-style) fed by `exact-*.json`, and
  the kernel's elaboration of 883 points at height 4 (M06 did 1,581).
* **Combinatorics**: the M42 LRAT template at k = 4 over 883 × 4 variables and 4,625 edges — smaller
  than the 1581's certificate (7,877 edges), so hours of kernel time, not days; the pinned palette
  closure over the core's cliques as at M42.
* **The statement**: `Instances/CopyLock.lean`: `core883_not_colorable_four` (LRAT) +
  `core883_unit` (geometry) + the corollary through `lt_chromaticNumber_unitDistance` — and, because
  the drawing is `copyDrawing q 206 rho15` on the original's exact points, the M52 kernel file
  `Copy.lean` supplies the union's shape (`copyUnion`, `chromaticNumber_copyUnion_le`).
* Registered price: two to four sittings; the geometry emitter is the only new code.

## Why it might be the next milestone instead of iteration 5

Kooshi's publication clause: "*maybe* our own certified 5-chromatic object, if what it reveals is
interesting enough (his call)". What it reveals (M52): the descended fabric never left the seam
field; the lock is de Grey's angle on material de Grey never had; and the copies are witnesses,
not descent material. The certificate is the artifact that makes the first two statements
citable. Against it: it is a formalization of a known bound (χ ≥ 5), the standing policy defers
write-ups, and iteration 5 is the route to six. The decision is his; this stub is the priced
alternative so the choice is between two written things.
