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

## The exact certificates (level 3) — these ARE bounds, once the checker says CERTIFIED

Derivation: `plans/FS54-L3-certificate-soundness.md`. Producer (untrusted, numpy): `tools/fs54_l3_cert_round.py`.
Checker (standard library, exact): `tools/fs54_l3_cert_check.py`. The certificates themselves sit one level up, in
`data/fs54/`: `cert-q7-l3-N14.json`, `cert-q11-l3-N28.json`, **`cert-q27-l3-N141.json` (α(UD(𝔽₂₇,2)) ≤ 141, so not
five-colourable)**.

| file | what it is | how to regenerate |
|---|---|---|
| `round-q{7,11}-l3.log`, `round-q27-l3-a.log` | the producer's run: the float reading of the iterate, the rounded float score through the solver's own matrix, the exact N, and the checker's tail | `.venv/bin/python tools/fs54_l3_cert_round.py round --q 27 --modulus 't^3-t-1' --ckpt data/fs54/d4/ckpt/admm-q27.npz --snapshot data/fs54/d4/ckpt/admm-q27-certcopy-a.npz --den 100000000 --jobs 6 --k 5 --out 'data/fs54/cert-q27-l3-N{N}.json' --log 'data/fs54/d4/check-q27-l3-N{N}.log'` (7 and 11: `--ckpt data/fs54/d4/ckpt/qQ-l3.npz --snapshot data/fs54/d4/ckpt/qQ-l3-certcopy.npz --den 1000000000`); the snapshot is not committed (43 MB; sha256 in the certificate's provenance) |
| `check-q{7,11,27}-l3-N*.log` | the checker's verdict in a fresh process (27: six workers, 8 s) | `python3 tools/fs54_l3_cert_check.py data/fs54/cert-q27-l3-N141.json --jobs 6 --k 5` |
| `check-q27-l3-N141-jobs1.log` | the same, one process, the stranger's runtime (28 s) | `--jobs 1` |
| `check-self-test.log` | the checker's self-test: group generators and two plants; canonical form vs brute force (with a Frobenius-dropped plant); the anchored-matrix expansion vs its definition at genuine sets at 7 (two plants); plants in synthetic certificates; (★) at genuine sets with a stabiliser plant | `python3 tools/fs54_l3_cert_check.py --self-test` |
| `cert-controls.json`, `cert-controls/*.log` | the controls on the GENUINE certificates: 3 pass; flipped sign, indefinite dense block (with its faithful dense twin), bumped Gram entry, smaller N at 7, 11, 27; the other modulus `t^3-t-2` (hash kept, hash updated) with its faithful transported twin at 27 — 21 of 21 as designed. The planted files are not committed (5.6 MB each at 27) | `tools/fs54_l3_cert_round.py transport --cert data/fs54/cert-q27-l3-N141.json --out T.json`, then `controls --workdir W --logdir data/fs54/d4/cert-controls --out data/fs54/d4/cert-controls.json --genuine … --plant-from …` (and `--append --modulus-plant … --transported T.json`) |
| `expansion-q27-kamis117.log`, `expansion-q11-maxsat28.log` | the checker's keyed expansion against the definition of the anchored matrix at the verified maximum sets, 3,000 sampled entries of every matrix of the certificate, with a sign plant | `python3 tools/fs54_l3_cert_check.py CERT --expansion-check SETFILE --set-path set --samples 100` |
| `against-q{7,11,27}-*.log` | (★) evaluated exactly at a maximum independent set, term by term | `python3 tools/fs54_l3_cert_check.py CERT --against SETFILE --set-path …` |
| `alpha-q7-bb.json` | a maximum independent set at 7 (size 14, found by an exhaustive branch and bound over the 49 points), the input of the at-7 evaluation; `--against` re-verifies its independence and refuses a set that is not | any exhaustive search; α(UD(𝔽₇,2)) = 14 |
