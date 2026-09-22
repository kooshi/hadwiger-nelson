# `data/fs70/` — the records of FS-70, five colours over ℚ(√3,√5)

*The milestone hunts for one **four-colour forced pair at a chainable distance** over the number field ℚ(√3,√5):
two points that every proper four-colouring of some finite graph in that field must give the same colour, at a
distance `δ` whose reciprocal `1/δ` is a sum of unit vectors. The chain theorem then builds a five-chromatic
graph inside the field by hand. The plan is `plans/FS70-five-over-sqrt3-sqrt5.md`; this directory is its record.*

Nothing here is a certificate. Every number is regenerable from the tools named beside it, and the tools are
untrusted (`CLAUDE.md` § "Nothing in `tools/` is trusted"): a phase-2 witness will be checked by a separate
frozen checker that shares no code with them.

## Who owns what

| path | what it is | written by |
|---|---|---|
| `owner/` | the product owner's independent re-derivations and reviews | the owner — **not the implementer's to edit** |
| `planner/` | the milestone planner's prior-art gate responses and pilot measurements | the planner |
| `atlas.jsonl`, `screen.jsonl`, `records/`, `inflight/` | phase 0's products (below) | the phase implementers |

## The files

| file | one row is | produced by |
|---|---|---|
| **`atlas.jsonl`** | one **unit vector** of the field, to coordinate denominator 42: its nine integers `((a+b√3+c√5+d√15)/m, (e+f√3+g√5+h√15)/m)`, its three **depths** (the valuations at the primes above 2, 3 and 5), and whether it is a 2-unit and a 3-unit. 2,020 rows. | `python3 tools/fs70_field.py atlas 42 --out data/fs70/atlas.jsonl` (6 s) |
| **`screen.jsonl`** | one **lattice** of unit vectors: its generating spec and identity hash, its denominator `M`, rank, covolume, the **3-adic gate** (does it hold a unit vector of nonzero 3-depth? — a lattice of 3-units is 3-colourable and carries no four-colour compulsion, so it must never be asked), the full **additive screen** in both groups of order four, the HNF basis of the **forced sublattice** `Λ_forced` and its index, and the **chainable targets** the screen leaves alive with their chain lengths. 20 rows. | `python3 tools/fs70_fabric.py screen SPEC… --out data/fs70/screen.jsonl` (39 s for all 20) |
| **`records/phase-0.md`** | the running log of phase 0: what landed, every decision, every number with its command | the phase-0 implementer |
| **`records/fq/fq-planes.json`** | the residue planes at the split primes: `χ(UD(𝔽₉²)) = 3` and the four-colour refusals at 25 and 49, with each encoding's sha256 | `python3 tools/fs70_fq_plane.py run 9 25 49 5 --kmax 4` (1 s) |
| **`records/structure-control.json`** | the structure instruments' positive control: the imposed-quotient ask finds the 3-adic colouring rule on 3-unit fabric and refuses it on `S₂` fabric | `python3 tools/fs70_structure.py control` (37 s) |
| **`records/haugland/`** | phase 0.3's positive control: Haugland's 740-vertex graph rebuilt exactly and its refusal reproduced | `python3 tools/fs70_haugland.py build` |
| **`inflight/`** | one file per **ask in flight**: what is running, where its per-cube ledger is, its process-group file, and the command that resumes it. Deleted at the verdict. | every phase |
| **`asks.jsonl`** | one row per SAT ask, appended **at its verdict** — `verdict, lattice, shape, points, edges, avg_degree, pin, conclusion_if_unsat, sha`, plus the single-solver and cube blocks. **The pin is named by its CONCLUSION, never by the constraint it carries**: `forces δ` imposes `c(0) ≠ c(δ)` and its refutation is the forced-equal pair the chain theorem consumes; `separated δ` contracts the pair and its refutation is a virtual edge. Rendered by `python3 tools/fs70_ask.py status`. | phase 1 |
| **`kempe-screen.json`** | one row per lattice: for each chainable target, whether some additive four-colouring plus **one Kempe swap** separates the pair — which kills the target on that lattice **at every radius**, with no solver. Five lattices are dead outright, four are live. | `python3 tools/fs70_ask.py screen SPEC… --out data/fs70/kempe-screen.json` (seconds) |
| `periodic-screen.json`, `periodic-screen-p4.json` | the same question asked of `pΛ`-periodic colourings of the whole lattice (the graph on `Λ/pΛ`, `p⁸` classes). Silent on every chainable target, and structurally so: they all lie inside `4Λ`, where every additive and every periodic instrument is blind. | `fs70_ask.periodic_escape` |
| `records/phase-1.md` | the running log of phase 1: the pin correction, the Kempe screen and its controls, the asks, the structure readings | the phase-1 implementer |
| `records/asks/quotient-sweep.log` | the imposed-quotient ask at `p ≤ 4` on the four live fabrics (L4a and L5 carry periodic rules; L2 and L3 carry none) | `tools/fs70_structure.py quotient DIR P` |
| **`records/asks/*.colouring.json.gz`** and **`MANIFEST.json`** | **every SAT ask's model**, gzipped verbatim with its uncompressed sha256, its source path and the row it belongs to. A colouring is evidence and belongs beside its row, not in `build/`, which agents clean (the owner's ruling 5). | phase 1b, for phase 1's thirteen and its own |
| **`rotations.jsonl`** | **the rotation list**: one row per symmetry class of rotations of `F`, with the EXACT cross-edge anatomy of its arena on the CM base at sums of ≤ 4 — `psi` in the nine-integer form, its denominator, its 2-adic depth, whether it is a **2-unit** (then the arena is four-colourable by the residue map at the prime above 2, with no solver), whether it is **commensurate** (in the CM field `ℚ(√−3,√−5)` — and then it is a 2-unit by the theorem in `rot/cm-prime-above-2.log`), its type-M `n`, and `cross / diagonal / off_diagonal`. The header names the base, the pool and the route; a rotation absent from the file is absent from THOSE enumerations, never from the field. | phase 1c |
| **`rot/cm-prime-above-2.log`** | the PARI computation behind phase 1c's theorem: `ℚ(√−3,√−5)` has ONE prime above 2, residue field `𝔽₄`, **inert** over `ℚ(√15)`'s — so complex conjugation fixes it and every unit vector of the CM field is a 2-unit. No commensurate twist of this base can break the 2-adic wall. | phase 1c |
| **`rot/commensurate-screen.json`** | that theorem CHECKED rather than quoted: on the twelve commensurate arenas with the most cross edges, an explicit additive ℤ/4 colouring verified on every edge — 0 monochromatic of up to 354,960. | phase 1c |
| `records/phase-1c.md` | the running log of phase 1c: the two enumerations and why the brief's one is a lower bound, the commensurate theorem, the list and the price the wall charges, the 87 asks, and a grid defect that was silently shrinking every cross-edge count | the phase-1c implementer |
| `records/phase-1b.md` | the running log of phase 1b: the ζ₆ grammar, L6's screen, its asks at three densities, the type-M arena and G53's counting screen, and four instrument defects | the phase-1b implementer |

## The tools

| tool | what it does |
|---|---|
| `tools/fs70_field.py` | exact arithmetic for `F = ℚ(√3,√5)` and `E = F(i)`; the unit vectors by denominator; the depth grading; the atlas. `--selftest` carries every identity the plan quotes; `--plants` plants three faults and watches each refuse. |
| `tools/fs70_fabric.py` | lattices as integer 8-tuples over one denominator; two independent saturation methods; the 3-adic gate; the additive screen and `Λ_forced`; the three fabric shapes (Harder word balls, Haugland lenses, Minkowski balls); two independent edge derivations; the CNFs. `--plants` likewise. |
| `tools/fs70_fq_plane.py` | the residue planes `UD(𝔽_q²)` at the split primes, symmetry-broken, every model verified from the definition. |
| `tools/fs70_structure.py` | the structure instruments: the quotient screen, the period screen, and the imposed-quotient ask, with the positive control the plan specifies. |
| `tools/fs70_haugland.py` | Haugland's `G₁` rebuilt in `ℚ(ζ₈₄)` — the positive control one field over. |
| `tools/fs70_cube.py` | cube-and-conquer for a four-colour refutation, checkpointed per cube (a kill costs the cubes in flight and nothing else). |
| **`tools/fs70_arena.py`** | the **type-M arena**: a base point set plus its rotated copy sharing the centre, and **G53's counting screen** on it (`L` = the fewest circle points any proper four-colouring puts on the centre's colour, by binary search on a cardinality constraint; `2L >` the circle count refutes the arena with no arena solve). The rotation's `n` is derived from `\|1 − R\|² = 1/n` and a rotation that is not of type M is refused by name; the arena's edges are derived twice, from the lattice saturation and from the geometry, and must agree. `--plants` plants four faults, one of them (`card_ignored`) aimed at exactly the `L = 0` reading the tool returns on this field's fabric. |

| **`tools/fs70_rotations.py`** | the **in-field rotation sweep**: every rotation of `F` that makes a cross edge on a base, ranked by how many. Two enumerations, each complete for its own bound — `scan` takes every unit vector of a pool and counts its cross edges EXACTLY (complete for a bound on the rotation's denominator); `sweep` reads the condition as `psi = (z+s)/w` and reaches rotations of ANY denominator but bounds the joining vector instead, so its counts are LOWER bounds. Also the commensurability test, the type-M `n`, G53's counting screen for an arbitrary rotation, an additive four-colouring of an arena GRAPH (no saturation needed), and the exact arena with its graph.json. `--plants` plants six faults, one of them the grid defect the tool actually shipped with. |
| **`tools/fs70_rot_asks.py`** | builds each live rotation's arena and asks it at four colours, in descending order of off-diagonal cross edges — [Voronov2021] §5's own ranking. 2-unit rotations are never asked (dead by theorem) and the reason is in its docstring. The verdict is read from the ledger row the ask wrote, never from its log. |

Scratch that is regenerable in minutes lives in `build/fs70/` (gitignored) and is never the only copy of anything.
