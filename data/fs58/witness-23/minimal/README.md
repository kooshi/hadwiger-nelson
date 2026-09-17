# data/fs58/witness-23/minimal — a smaller certified witness over ℚ(√23), for the kernel step

The same claim as `data/fs58/witness-23/` — χ(ℚ(√23)²) ≥ 4 — from the same extraction checkpoint (`../steps.jsonl`, the 1,241-point
assumption-core fixpoint of the 440,077-point ball), shrunk by Glucose4 deletion in eight seeded random orders
(`tools/fs58_search.py minimize`; seeds 0–7 gave 363, 297, 454, 430, 490, 302, 310, 467 points, in `minimize.jsonl`; the parent's
norm-ordered deletion gave 475). The smallest, seed 1, is emitted here: **297 points, 670 unit edges, 12,225 LRAT additions** (the
parent: 475, 1,099, 16,009). It is 1-minimal.

| record | what |
|---|---|
| `certified.out` | `tools/fs58_check_witness.py --radicand 23`: CERTIFIED |
| `controls.out` | twelve planted faults refused, faithful twin certified, all-pairs = bucketed = file (670) |
| `recheck.out` | Fraction all-pairs edges = file; Lingeling, CaDiCaL 1.5.3, MapleChrono UNSAT; deleting the pinned vertex leaves a 3-colourable graph |
| `minimize.jsonl`, `minimize.out` | each seed's refusing set and time; the emission log. Re-emission from `minimize.jsonl` is byte-identical (checked) |

Recommended input for a kernel form (the smaller of the two); the parent directory stays the record of how the refusal was found.
