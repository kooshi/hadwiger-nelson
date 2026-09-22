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
| `asks.jsonl` | one row per SAT ask, appended **at its verdict** (phase 1) — `verdict, lattice, shape, points, edges, avg_degree, pin, solver, seconds, sha` | phase 1 |

## The tools

| tool | what it does |
|---|---|
| `tools/fs70_field.py` | exact arithmetic for `F = ℚ(√3,√5)` and `E = F(i)`; the unit vectors by denominator; the depth grading; the atlas. `--selftest` carries every identity the plan quotes; `--plants` plants three faults and watches each refuse. |
| `tools/fs70_fabric.py` | lattices as integer 8-tuples over one denominator; two independent saturation methods; the 3-adic gate; the additive screen and `Λ_forced`; the three fabric shapes (Harder word balls, Haugland lenses, Minkowski balls); two independent edge derivations; the CNFs. `--plants` likewise. |
| `tools/fs70_fq_plane.py` | the residue planes `UD(𝔽_q²)` at the split primes, symmetry-broken, every model verified from the definition. |
| `tools/fs70_structure.py` | the structure instruments: the quotient screen, the period screen, and the imposed-quotient ask, with the positive control the plan specifies. |
| `tools/fs70_haugland.py` | Haugland's `G₁` rebuilt in `ℚ(ζ₈₄)` — the positive control one field over. |
| `tools/fs70_cube.py` | cube-and-conquer for a four-colour refutation, checkpointed per cube (a kill costs the cubes in flight and nothing else). |

Scratch that is regenerable in minutes lives in `build/fs70/` (gitignored) and is never the only copy of anything.
