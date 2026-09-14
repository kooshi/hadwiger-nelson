# data/fs50 — records of FS-50, the independence number at the threshold

*Every file is a measurement or a relaxation on the solver's/LP's word; the certificate, if one lands, is the Lean module
(`Instances/…`) and not anything here. `plans/FS50-prior-art.md` §3 is the reading of the `lp-*` files.*

| file | what | claim scope |
|---|---|---|
| `lp-p83-k6.json` | `tools/fplane_lp.py --p 83 --k 6` with the full graph library: Delsarte's LP (`ϑ′` = 1,199.459) strengthened by [KMOR2016] Lemma 3.2 (2) rows over every translate of nine small unit-distance graphs (each `α_V` exact), Székely's rows and the atom LP of [AmbrusEtAl2023] on the wheel and the spindle, at the six-colour threshold 1,149 | max `|S|` with subgraph rows **1,197.064**; size 1,149 **feasible** under every family — the relaxation certifies nothing at 83; a float LP (HiGHS) |
| `lp-p11-k5.json`, `lp-p23-k5.json` | the same at 11 (threshold 25) and 23 (threshold 106) | 30.392 at 11 against the verified `α = 28`; 126.755 at 23; both feasible at their thresholds |
| `alpha-p23-ge87.json` | a verified 87-point independent set of UD(𝔽₂₃, 2) — the Rust engineer's WO-18 planning prototype found it in 0.03 s on one core (2026-09-14); re-verified here from the definition and through `fplane.ud_edges` | `α(23) ≥ 87` (was ≥ 69 in `data/fplane/alpha-p23.json`); the five-colour threshold 106 is still not met, nothing decided |
| `lp-attribution.json` | the single-graph maxima at 11, 23, 83 — which graph's rows carry the drop | at 83 only the triangle bites (1,197.064); the spindle bites at 11 (30.392) and not at 83 |

Regenerate: `python3 tools/fplane_lp.py --self-test` (controls: `ϑ′` reproduced with no rows; 28 feasible at 11 and 76 at
19 under every family; a planted `α` moves the bound, two-sided), then the three commands above.
