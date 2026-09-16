# data/fs54/d4 — FS-54 D4: the level-3 relaxation at q = 27, sized, controlled, priced

The page that explains everything here is `plans/FS54-D4-pricing.md`. Tools: `tools/fs54_d4_quad.py` (the programme,
census, controls, SCS and ADMM drivers, evaluation) and `tools/fs54_d4_bench.py` (the timing measurements).
**Every number in these files is a floating-point reading or a control; none is a bound.**

| file | what it is | how to regenerate |
|---|---|---|
| `census-q27.json` | exact Aut-orbit counts of independent 2-, 3-, 4-sets at 27 with the completeness check | `tools/fs54_d4_quad.py count --q 27 --modulus 't^3-t-1'` (the census is part of `count`) |
| `count-q{19,23,27}-l3.json` | sizes of the level-3 programme: variables, blocks, PSD rows, SCS rows/nonzeros/bytes (19 and 23 include the census) | `count --q Q [--modulus ...] --family l3` |
| `checkset-q27-l3-kamis117.json` | soundness control: y from the verified 117-set, objective 117, every block PSD | `checkset --q 27 --modulus 't^3-t-1' --set data/fs54/kamis-smoke/alpha-q27-kamis.json --path set` |
| `randsets-q{11,19,27}.json` | soundness control on random maximal independent sets | `randsets --q Q --count C --seed S` (12/1, 6/2, 3/3) |
| `evaluate-q11-admm30000.json`, `evaluate-q27-admm8000.json` | certificate-shaped float value `N` of the ADMM iterate, block ranks, and the identity (★) checked at a real set with a plant | `evaluate --q Q --ckpt data/fs54/d4/ckpt/admm-qQ.npz --rank --set ...` |
| `certshape-q19-it6090.json`, `certshape-q27-it2827.json` | the same value at earlier iterates (the 27 checkpoint has since moved on) | not regenerable from the moved checkpoint; the log trajectory is in `runs/` |
| `runs/q7-*.json`, `runs/q11-*.json`, `runs/q27-triple.json` | the controls' solves (triple level with and without FS-50's `le_diag` rows; level 3) | `solve --method scs` lines in the records |
| `runs/admm-q19*.log`, `runs/admm-q27-pricing.log`/`.json` | the ADMM calibration at 19 (paused at 6,090) and the capped 8,000-iteration trajectory at 27 | `runs/RESUME.md` |
| `runs/timing-*` | SCS timings on the GPU (netlib / OpenBLAS-preloaded / verbose split), `qdldl` and `cudss` attempts at 19 | the commands are in the logs and `runs/timing-q27.sh` |
| `ckpt/` | solver checkpoints (**not committed**: large); `admm-q27.npz` is the warm start of any approved continuation | — |
