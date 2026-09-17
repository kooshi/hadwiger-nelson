# data/fs58/search-23 — FS-58 phase B5: the search over ℚ(√23) — LANDED (χ(ℚ(√23)²) ≥ 4, certified; = 4 with row 52)

Tool: `tools/fs58_search.py` (untrusted; every edge exact; solver verdicts are claims, SAT models verified edge by edge). Plan:
`plans/FS58-four-colours.md` §R-B4 (carried to B5). Budget: about 5 hours of wall time from 03:32. This record was first written at the
half-way mark (05:50) and is updated in place. `survey.jsonl` (6.9 MB, 4 min to regenerate) and `qscreen.jsonl` (2.6 MB, 2 min) are
gitignored; every other record is committed.

## Result

**The witness is `data/fs58/witness-23/`: 475 points of ℚ(√23)², 1,099 unit edges, no proper 3-colouring — CERTIFIED by
`tools/fs58_check_witness.py --radicand 23`, twelve planted faults refused, decorrelated recheck passed, the whole extraction reproduced
from empty.** With the residue plane at 7 (row 52, hand level) **χ(ℚ(√23)²) = 4**. A smaller certified witness from the same extraction, 297 points and
670 edges, is `data/fs58/witness-23/minimal/`. It needs no forced pair and no chain: it is a
refusing subset of one ball.

The pool: axis (4) + the (3/5, 4/5) family (8) + the orbit of `((7 + √23)/12, (7 − √23)/12)` (8) + the orbit of
`((49 + √23)/60, (7 − 7√23)/60)` (16): 36 unit vectors, lattice covolume 1.14·10⁻⁴, least odd cycle 9 (4,528 edges inside BFS level 4 —
no 5- or 7-cycle), no linear form mod 3 nonzero on every generator. The lattice of the axis and the class-60 orbit already contains the
other two orbits (a saturated lattice).

| ball radius | points | edges | verdict (pysat CaDiCaL 1.9.5) |
|---|---|---|---|
| 1.2 | 180,421 | 765,000 | undecided: Unknown at a 60 s wall (first scan) and again at a 900 s wall — the hard band just below refusal (compare ℚ(√47), where the ball one step below its refusing radius also stalled) |
| 1.3 | 248,213 | 1,220,300 | **refuses** (77 s) |
| 1.4 | 334,073 | 1,853,572 | **refuses** (142 s) |
| 1.5 | 440,077 | 2,698,324 | **refuses** (130 s; 180 s again as extraction round 0) |
| 1.5, without the (3/5, 4/5) family (`q1+12.1+60.2`) | 440,077 | 2,098,516 | 3-colourable (model verified, 1.3 s) |
| 1.5, axis and class 60 only (`q1+60.2`) | 440,077 | 1,498,868 | 3-colourable (model verified, 1.1 s) |

## What was tried, what it measured, what it cost (all ℚ(√23) unless marked)

| step | what it measured | cost | result |
|---|---|---|---|
| calibration on ℚ(√11) | capsule pieces (points within R of the segment [0, 3u] in both embeddings) of the 36-direction pool | seconds | forces `(0, 3u)` and the virtual edge at `2u` for all four direction classes at R = 0.8 (≈ 2,700 points), not at R = 0.6 (≈ 1,250). The 20-direction sub-pool `q1+q5+10.1` forces at 332–576 points |
| the R-B4 nulls, explained | bipartiteness of the pools R-B4 probed | seconds | ℚ(√11)'s 24 √11-vectors (`10.1+10.2`) and ℚ(√23)'s 24 √23-vectors of denominator 40 (`8+40`) are **bipartite** — they could force nothing at any size; ℚ(√23)'s 36-direction pool has no odd cycle of length ≤ 9 |
| a 2-adic obstruction [hand] | the ℚ(√11) forcer's mechanism: a "diamond" (u, ū) whose chord 2x is a rational vector of odd parity (5-cycles "diamond + 3 rational steps") | — | for `d ≡ 7 (mod 8)` no such chord exists: with `s = (p + qi)/m`, `m` odd, the condition `(4m² − n)·n = d·□` (n = p² + q²) forces the left side ≡ 3 (mod 8) against d ≡ 7. So ℚ(√23) and ℚ(√167) lack ℚ(√11)'s cheapest odd cycles |
| pool survey | 27,377 unions of orbit classes (least denominators ≤ 200 in pairs, ≤ 104 in triples, ≤ 60 up to 5 classes): covolume, reduced coordinates, bipartite, forms mod 3, least odd cycle | 11 CPU-min ×16 | 1,395 bipartite; odd girth 5 only with 13 \| N (`q1+52.1+52.3`, covolume 4.5·10⁻⁴); the coarse 3-non-integral pools (denominators 8, 12, 24) have odd girth 7 |
| quotient screen (D3.7) | 400 pools with odd girth ≤ 7, 24 lattices each, targets `sep 2u, 3u, 4u`, `id 2u` | 30 CPU-min | 66 pools fully killed (no target can ever be forced); the 3-integral survivors keep exactly `sep 3u` and `id 2u` (the affine kills); pools with class 8 have no 3-colourable quotient at all |
| capsule probes | `sep 2u/3u/4u`, `id 2u`, controls | ≈ 10 CPU-min | no forced pair on any piece up to 365,878 points (174 records) |
| local rigidity meter | fraction of word-length-2 pairs forced equal or different in a ball of radius 1.5–2.0 | minutes | ℚ(√11) pools: 32 of 64 and 56 of 192 pinned at R = 1.5; **every ℚ(√23) pool read 0** (10 pools, up to 142,657 points); control ℚ(√11) `q5+10.2` (which never forced) reads 0 |
| least character mean | the ratio-bound shadow on 1,505 pools | 166 CPU-min | best −0.523 (`q1+q5+12.1+12.2+16`); the coarse 8/12/24 pools read −0.85 (nearly bipartite); none above −1/2 |
| layered rank-3 pools | axis/rational families + "layer" vectors (s, t√23) only | 50 min, stopped | single-layer pools: every target killed by a quotient; pairs of layers: no odd cycle ≤ 11, no forcing to 240k points (killed at pool 64 of 135; resumable) |
| direct colourability of balls (3-non-integral pools, D1) | is the ball of radius 1.2–2.0 3-colourable at all? | ≈ 2 CPU-h | survey pools to 200,000 points: all 3-colourable (223 verified models) or solver budget; **saturated lattices** (a lattice with every unit vector of its denominator it holds): `q1+q5+12.1+60.2` refused at 440,077 points; the scan was stopped with 27 of 48 lattices unscanned to free the machine for the extraction (resumable: `FS58_JOBS=4 tools/fs58_search.py colour-scan 23 1.5 0 99 1000000 600 <specs>`) |
| extraction and certificate | `tools/fs58_search.py extract` (checkpointed) | 11 min wall | 77 assumption-core rounds 440,077 → 1,241; Glucose4 deletion → 475; CERTIFIED (`data/fs58/witness-23/`) |

## For a chain, if one is ever wanted

`1/3 = u₁ + u₂ + u₃` over ℚ(√23)(i) with three unit vectors of denominator 39 — `(−7/39, 8√23/39)`,
`((10 − 6√23)/39, (−15 − 4√23)/39)`, `((10 + 6√23)/39, (15 − 4√23)/39)` (checked exactly; a meet-in-the-middle search over the 268 unit
vectors of denominator ≤ 60 found no shorter sum, and `1/2` needs four). The witness above does not use it.

## Instrument defects found (and handled)

* **pysat's conflict-budgeted CaDiCaL stalls on small near-threshold pieces**: a 4,609-point ball that is certainly 3-colourable (its
  11,369-point superset was coloured in 0.03 s) returned `Unknown` at 60 s and an unbudgeted solve ran over 10 minutes; the rigidity
  meter's `unknown` counts on ℚ(√11) at R = 1.0 and ℚ(√47) at R = 1.1 are the same defect. `Unknown` is never read as a refusal.
* **Resume skipped `over cap` records**: a rerun with a larger cap re-asked nothing. Fixed: over-cap and budget records are re-asked.

## Side results from the calibration (other fields; all certified)

The direct route — a coarse pool of 3-non-integral directions whose ball refuses three colours, no forced pair and no chain — was found
first over ℚ(√47) and then, in a 10-minute scan of fields `d ≡ 2 (mod 3)`, over ℚ(√71) and ℚ(√191) (and a solver claim over ℚ(√95)):

| field | pool | ball | witness | status |
|---|---|---|---|---|
| ℚ(√47) | `q1+12+60` | 8,629 points | 169 points, 385 edges | **CERTIFIED**, controls pass, decorrelated recheck (`data/fs58/witness-47/`) |
| ℚ(√71) | `q1+q5+60.2+120.2` | 47,597 | 148 points, 346 edges | **CERTIFIED**, controls pass, decorrelated recheck (`data/fs58/witness-71/`) |
| ℚ(√191) | `q1+q5+20+60.1` | 53,177 | 483 points, 1,203 edges | **CERTIFIED**, controls pass, decorrelated recheck (`data/fs58/witness-191/`) |
| ℚ(√95) | `q1+12+60.2` | 17,169 | 1,068 points, 3,096 edges (deletion stopped: not 1-minimal) | **CERTIFIED**, controls pass, decorrelated recheck (`data/fs58/witness-95/`) |

ℚ(√71), ℚ(√95), ℚ(√191) all have 7 split (a usable 𝔽₇ plane), so each would be exactly 4 with row 52's bound; ℚ(√47) has 11, so 4 ≤ χ ≤ 5.

## ℚ(√167)

Not landed; see `data/fs58/search-167/README.md`.
