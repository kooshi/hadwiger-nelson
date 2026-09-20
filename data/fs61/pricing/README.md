# data/fs61/pricing — what the planner measured before specifying FS-61 (2026-09-19)

Plan: `plans/FS61-quadratic-census.md` §2. Machine: the desktop (16 physical cores), idle. Everything here was run from a
**scratch copy** of `tools/fs58_search.py`, `fs58_local.py`, `fs58_chain.py`, so `data/fs58/` was not touched. **Pricing, not results**:
solver verdicts are the solver's claims; phase B/C of the plan reproduces each one under its gate.

| file | command (from the scratch copy's root unless noted) | what it shows |
|---|---|---|
| `saturate-119.log` | `fs58_search.py saturate 119 180` | 144 lattices, 2.1 s wall / 21 CPU-s |
| `colour-scan-119.jsonl` | `FS58_JOBS=4 fs58_search.py colour-scan 119 1.0,1.2,1.5 0 99 1000000 120 q1+12+60.1` | the ball of radius 1.5 (13,605 points) refuses three colours in 0.69 s; radius 1.2 in 116 s; radius 1.0 is 3-colourable |
| `witness-119/` | **from the repository root** after `source scripts/dev-env.sh` (the tool calls `lean --print-prefix`): `fs58_search.py direct-witness 119 q1+12+60.1 1.5 OUT` (52 CPU-s), then the frozen `tools/fs58_check_witness.py --radicand 119 OUT/witness.json` | 456 points, 1,122 edges, `CERTIFIED` (exit 0). `witness.lrat.gz` (1.6 MB, sha256 `0ee2aceb379108a703d9494e38f6a7f6d768e1e786ca53eb624248b6a3488039`) is regenerable and not committed. Controls, recheck, 4-colouring: not run — phase C's |
| `colour-scan-143.jsonl` | `FS58_JOBS=3 fs58_search.py colour-scan 143 1.2,1.5,1.8 0 99 1500000 600 q1+q5+12+60` | radius 1.5 (283,485 points) refuses in 103 s, 1.8 (587,333) in 225 s; 1.2 (116,193) `Unknown` at the 600 s wall |
| `colour-scan-59.jsonl` | `… colour-scan 59 1.8,2.0,2.3 0 99 1500000 300 q1+q5+30.1+30.2` (first line is FS-58's own record at 1.5) | 3-colourable in under a second to 237,229 points |
| `quotient-colourable-{11,35,59,119,143}.jsonl` | `fs58_search.py quotient-colourable D POOL` | 11 `q1+6+30.2`, 35 `q1+q5+6+30`, 59 `q1+q5+30.1+30.2`: **dead** (a verified 3-colourable quotient: `Λ/6Λ`, `Λ/12Λ`; `Λ/9Λ` at 59). 119 `q1+12+60.1`, 143 `q1+q5+12+60`: live (0 of 17, 0 of 16) |

Trap met: `colour-scan`'s pool list is one comma-separated argument; extra space-separated pools are silently dropped.
