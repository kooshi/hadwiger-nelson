# M35 — The certified union: a modular 5-chromatic witness (DEMOTED STUB — not the next milestone)

> **DEMOTED 2026-08-11 (Kooshi, at the M34 close discussion): the two-sided
> k = 5 programme (`plans/M35-k5-transfer.md`) is THE M35** — the sweep plus
> the periodic avoidance certificates makes progress whichever way χ(ℝ²)
> points, while this object is consolidation with bounded novelty. Nothing
> below decays: the union is measured 5-chromatic (kernel-covered cubes,
> `build/m34-union-core9.json`), the proof pieces all have precedents, and
> this stub reopens on Kooshi's call — in particular if the write-up
> trigger's "maybe" clause (our own certified 5-chromatic object) makes it
> worth the field-tower work.*

*Written 2026-08-11 at M34's close. Read order: `plans/M34-act-one-certified.md`
WHOLE, then CLAUDE.md G15/G18.*

## The object, measured at M34

The union = the nine-point √3-pair core + six copies of the 791-point forcer,
each fused at one pigeonhole endpoint with its forced-equal pair (4/√3
antipodal) chained by one unit edge to the other endpoint: **4,749 vertices,
23,647 edges, χ ≥ 5 by composition** — solver-confirmed through six cubes
covered by the KERNEL theorem `core9_pigeonhole` (each ~800 s UNSAT;
`build/m34-union-core9.json`). The monolithic solve capped (G18) — the
modular proof is not a nicety here, it is the only affordable route.

## The Lean shape (all pieces have measured precedents)

1. **The pigeonhole**: `core9_pigeonhole` — DONE (kernel, M34).
2. **The kill certificate**: ONE pinned LRAT for the forcer's forced-equal
   pair — the formula solved in 133.7 s at M34 (`build/m30-forcer791.json`
   currency; pin the pair's end + the ≠-assertion, or pin a forcer triangle
   and let the Gadget layer close the palette exactly as Core122 did). One
   certificate serves all six copies (they are the SAME graph relabelled —
   `Fan.comap`/`Gadget` transport, the M09 rotation genre).
3. **The geometry — the real work**: the forcer's 791 points need a
   certificate (they are 1581-table points in the LOADER's numbering — the
   numbering lesson of M34 §R: build the cert from `m30-forcer791.json`'s
   own currency, re-derived exactly), and the six chain placements live in
   **ℚ(√3,√5,√7,√11,√23)** (the B5 triangle: cos α = 11/12,
   sin α = √23/12). The Q4 tower must grow a fifth root or the placement
   coordinates must route around it — the measured options at subplanning:
   (a) extend `Field/Quadratic.lean`'s tower to Q5 (the machinery is
   generic-by-construction over the prime list; emit/decide costs scale by
   the 32-basis — measure first); (b) state the six placements' unit-chain
   facts over ℝ directly via `Real.sqrt` arithmetic (the Compulsion.lean
   genre — no table, six hand identities, sympy-derived witnesses per the
   M32 discipline). Option (b) avoids touching frozen machinery entirely
   and six identities is small — the expected route; measure both.
4. **The assembly**: properness of the union restricts to each part;
   forced-equal transports along the relabelling; the chain edge refuses;
   `core9_pigeonhole` closes. Pure structural Lean, the M20 genre — the
   FIRST χ ≥ 5 proof with no monolithic certificate anywhere.

## What it buys, honestly

A new 5-chromatic unit-distance witness — 3× the 1581's vertex count, so
NOT a size record; its value is the PROOF SHAPE (fully modular: pigeonhole
theorem + one kill certificate + transport + composition — the A5
architecture realized end to end, reusable verbatim for any future
pigeonhole × kill assembly incl. a k = 5 find) and the write-up-trigger
question it forces. The minimization game (smaller kill gadgets, shared
copies, fusion) is real research on top: the priced grammar says the kills
carry the whole cost, and the 791 is nobody's lower bound.

## Failure clauses (sharpen at registration)

* The √23 route resists both options: report the measured costs, park the
  geometry, keep the combinatorial theorem (the union's χ ≥ 5 as a
  Fin-graph statement — still the modular first, minus the plane claim).
* The forcer LRAT balloons unexpectedly: the M05 segmentation machinery
  exists; measure first.
* Any crash: HALT and report (standing).
