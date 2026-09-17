# data/fs58/witness-71 — FS-58 phase B5 side result: the plane over ℚ(√71) needs four colours

Built and checked exactly as `data/fs58/witness-47/README.md` describes (a coarse pool of 3-non-integral directions whose ball of physical
radius 1.5 refuses three colours; a 1-minimal refusing set; no forced pair, no chain). Regenerate: `bash data/fs58/witness-71/run-all.sh`
(deterministic; the rebuild was checked byte-identical).

| record | what |
|---|---|
| `witness.json`, `witness.lrat.gz` | the points (a, b, c, e, m) = ((a + b√71)/m, (c + e√71)/m), the exact unit edges, the pinned edge, CaDiCaL's LRAT |
| `certified.out` | `tools/fs58_check_witness.py --radicand 71`: CERTIFIED |
| `controls.out` | twelve planted faults refused for their named reasons, the faithful twin certified, all-pairs = bucketed = file |
| `recheck.out` | `tools/fs58_recheck_witness.py` (shares no code with generator or checker): Fraction all-pairs edges = file; Lingeling, CaDiCaL 1.5.3, MapleChrono UNSAT; deleting the pinned vertex leaves a 3-colourable graph |
| `generate.out` | the generator's run: pool, piece size, refusing-set size, solver timings, deletion controls |
