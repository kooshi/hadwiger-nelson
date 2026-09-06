# data/m54 — M54, the five-colour dial (2026-09-05/06; `plans/M54-five-colour-dial.md`, results in its §R sections)

The milestone's theorem (`Proofs/HadwigerNelson/CriticalSet.lean`): a pair forced equal at k + 1 colours
confines the critical set C(G) = {v : G − v is k-colourable} to the pair's common neighbourhood, a
virtual edge to the union of neighbourhoods; in the plane a forcing graph has at most two critical
vertices and none beyond distance 2. So the criticality census prunes the five-colour sweep to the
theorem-admitted candidates. Every file carries the stage's edge-list fingerprint. Regenerate with
`tools/five_dial.py` (`self-test` first; 22 planted controls).

* `critical-EI-seed-12graph.json` — the Exoo–Ismailescu {1, 2}-seed at four colours: **C = ∅** (214/214
  deletions refuse), the theorem's calibration (P-M54-1). `critical --seed --k 4`.
* `witness-exact-core-8over3.json` — the 1,175-point witness of T20 exact in K(√247): every unit edge and
  all 6 cross chords exact identities. `exact-witness --witness data/m53/forced-spindle-core-8over3.json`.
* `critical-W-core-8over3.json` — the witness's critical set at four colours: **all 1,175 vertices
  (vertex-critical)**, each certified by its verified colouring; zero candidates at five colours by
  theorem. `critical --witness … --k 4 --workers 24`.
* `sweep-control-W-core-8over3.json` — the planted red/green for the exhaustive sweep: W + 7 shell cheats
  finds exactly the two planted forced-equal pairs; all nine pairs vacuous. `planted-sweep --witness …`.
* `nu-*.json` — ν = the fewest fifth-colour vertices of a proper 5-colouring (RC2). `nu <stage> --k 5`.
* `cross-lattice-W-core-8over3.json` — the depth-one F₂₄₇ census of the witness: every (core, copy) pair
  at distance < 2 tested exactly for an in-field glue point; the pool, its fusions and pool–pool edges;
  the core's same-side pairs classified (in-K / √247-class / other). `cross-lattice --exact … --same-side`.
* `spindles-*.json` — the two-spindle union (a `--graph` stage with points); `critical-spindles-*.json`,
  `nu-spindles-*.json`, `sweep-spindles-*.json` its dials. `two-spindle --witness … --pair2 813,1939`.
