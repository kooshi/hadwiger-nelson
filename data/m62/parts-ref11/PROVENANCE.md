# Parts's vertex lists — reference [11] of arXiv:2010.12665

## What this is
`[Parts2020a]` §6 says "Lists of the vertices of some graphs can be found on the Polymath
project website [11]", and reference [11] points to `Polymath16/Code and data/This dropbox
folder/JP/Large`. This directory is that Dropbox folder, downloaded whole.

## Where it came from (2026-09-10)
- The Dropbox link is published on the Polymath wiki page *Hadwiger-Nelson problem*, section
  "Code and data", recovered through the Internet Archive:
  `https://web.archive.org/web/2020id_/http://michaelnielsen.org/polymath1/index.php?title=Hadwiger-Nelson_problem`
- The link itself is **still live on dropbox.com** (no archive needed):
  `https://www.dropbox.com/sh/ufknm1v9gtbhad3/AACB2xwaXYx5EGda38_L-0foa?dl=1`
- Downloaded as `Polymath16.zip`, 76,045,248 bytes, and extracted in place. Checksums in
  `SHA256SUMS.txt`.

## The payload
`JP/Large/` holds 43 `.vtx` files named `v<vertices>e<edges>.vtx`, one exact vertex per line in
Mathematica syntax `{x, y}` with radicals, plus `graphs.txt` — Parts's own index mapping each
file to its row of the paper's Table 1 (M-graph / L-subgraph / S-subgraph / mono-pair /
non-mono-pair / non-mono-triple, by subtype m6a, m6b, m6c).

`JP/Pink/readme.txt` states Parts's integer coordinate convention verbatim:
`(a + sqrt(33)*b)/12 = x`, `(sqrt(3)*c + sqrt(11)*d)/12 = y` — the same `(a,b,c,d)` labelling
already used in `data/m62/parts509-orbit-fillings.json`.

## Verification done here (not inherited)
Every one of the 43 graphs was checked by **exact** integer arithmetic in the rank-8
multiquadratic field `Q(sqrt3, sqrt5, sqrt11)` — no float comparison anywhere. For all 43:
vertex count, vertex distinctness and unit-edge count match the filename exactly. Negative
controls were watched to fire (moving one vertex by 1/12 drops the edge count; duplicating a
vertex drops the distinct count).

Three structural facts fell out, all exact:

1. **`v509e2442` = `v374e1860` UNION `rho15 * v136e564`**, sharing only the origin, where
   `rho15 = (7 + i*sqrt15)/8` — this project's own distance-2 spindle rotation (`Copy.lean`'s
   `spindleRot 2`). `374 + 136 - 1 = 509`.
2. **`v510e2502` = `v375e1920` UNION `rho15 * v136e564`** — the same S-subgraph and the same
   rotation.
3. **41 of the 43 graphs lie in `K = Q(sqrt3, sqrt11)`** with denominator 12 (every L-subgraph,
   every S-subgraph, every Table 1 forcer), and **only the two assembled M-graphs leave `K`**,
   into `Q(sqrt3, sqrt5, sqrt11)` with denominator `96 = 12 * 8`, the 8 being `rho15`'s. That is
   Theorem B measured on the record object: the 4-colourable parts are inside the seam field and
   only the assembly crosses the 2-adic wall.

## Two disputed Table 1 rows, settled
`CLAUDE.md` ledger row 59 flags two distances as unverified against the source PDF, both read
from automated text extraction. `graphs.txt` states them in Parts's own words together with the
pair coordinates, and both endpoints are present in the corresponding files:
- the 214-vertex non-mono-pair row is distance **3**, endpoints `(+-3/2, 0)` — **not** `sqrt3`;
- the 312-vertex non-mono-pair row is distance **1/3**, endpoints `(+-1/6, 0)` — **not** `1/sqrt3`.
The mono-pair rows are `8/3` at `(+-4/3, 0)` and `8/sqrt3` at `(0, +-4/sqrt3)`, as recorded.

## Machine-readable export
`data/m62/parts-vertex-lists.json` — all 43 graphs as integer coordinate tuples in Parts's own
convention (denominator 12 for the `K` graphs, 96 for the two M-graphs), with the verification
and decomposition facts in its `_meta`. It round-trips: recomputing unit edges from the exported
integers alone, by a separate code path, reproduces all 43 edge counts.
