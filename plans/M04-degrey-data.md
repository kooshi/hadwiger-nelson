# M04 — de Grey's graph as certified data  *(stub — carry-forward notes only)*

> 1581 vertices, 7877 edges, geometry verified in Lean. Terminal test: `deGrey.Valid = true`, with
> the vertex and edge counts matching the paper (397 / 1581 / 7877).

Not yet subplanned. This file exists to hold what earlier milestones learned that M04 must not
rediscover.

## Carried forward from M02 (measured, de Grey data, real file)

| | fixed, per module | marginal |
|---|---|---|
| elaboration | 28 s | 0.16 s/edge |
| memory | 3.9 GB | ~12 MB/edge |

* **The fixed cost is the vertex table elaborating**, not the geometry — 1581 × 32 integer literals
  nested four deep, paid *per module that defines the table*. So the table gets its **own module**
  (`Instances/DeGrey/Verts.lean`) and the chunk modules import its `.olean`.
* All 7877 edges in one `decide` would want ~95 GB. Plan ~32 chunks of ~250 edges, ~3 GB each; the
  chunks elaborate independently and therefore in parallel. This machine has 31 GB total, 21 GB
  available.
* The earlier "indexed lookup costs the same as pre-resolved endpoint pairs" result was measured at
  60 vertices and **does not extrapolate**. Superseded — do not cite it.
* Routing arithmetic through Mathlib's hierarchy costs nothing (0.16 vs 0.17 s/edge on a bare-`Int`
  harness) **provided `Adjoin` keeps exactly one arithmetic instance**. See `Field/Quadratic.lean`.
* `tools/emit_cert.py` already emits the whole module shape; `--chunk N` sets the slice size, and it
  *cites* the chunk theorems in `valid_of_chunks` rather than re-`decide`ing them, which would
  double the cost.
* `tools/degrey.py` writes `tools/degrey_cert.json` — integer-leaf coordinates, common denominator
  **768**, counts 397 / 1581 / 7877 reproduced exactly.

## Carried forward from M03

* Nothing on the geometry path. M03's cube machinery affects M05, not M04.
* The DIMACS for M05 is printed from the Lean CNF, which needs `deGrey.edges` to exist — so M04's
  edge list is M05's input, and its ordering is what LRAT clause ids will refer to. **Do not reorder
  the edge list between M04 and M05** without regenerating every certificate.
