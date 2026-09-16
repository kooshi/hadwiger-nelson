# data/fs56 — FS-56, ℚ(√167)

Plan: `plans/FS56-quadratic-167.md`. Current state only.

| path | what | trust |
|---|---|---|
| `../fs54/cert-q23-l3-N105.json` | **α(UD(𝔽₂₃,2)) ≤ 105**, exact N = 105.430586566, so χ(Γ₂₃) ≥ 6 (Q0). Filed beside the other level-3 certificates | CERTIFIED by `tools/fs54_l3_cert_check.py` |
| `../fs54/d4/check-q23-l3-N105.log` | the producer's checker run (6 s, 6 jobs) | log |
| `q0/recheck-po.log` | the PO's independent re-run in a fresh process (24 s, one job): CERTIFIED | log |
| `q0/controls.json`, `q0/controls/` | planted faults on that certificate: flipped sign, indefinite block, bumped Gram entry, lowered N refused for their named reasons; faithful dense twin passed — 5/5 as designed | log |
| `q0/round-q23-l3.log`, `q0/RESUME.md` | the rounding run and its launch/resume record (input: the 3,500-iteration calibration iterate, sha256 `9cd2d441…`) | log |
| `g27/cert-g27-mrvz.json` | `[MatolcsiEtAl2025]`'s `G27` and dual witness in FS-56's class-sum form (`tools/fs56_mrvz_import.py`; sources `~/source/library/supplementary/mrvz-2311.10069-fcn4/`, sha256 in the file) | input |
| `g27/check-g27.log` | **χ_gf(G27) ≥ 4 CERTIFIED** by `tools/fs56_gf_check.py`: 49 unit edges recomputed in ℚ(√3,√11), 11,640 congruence classes, all 182,304 independent sets; so χ_f(ℚ(√3,√11)²) = 4 (`plans/FS56-field-blowup.md`) | CERTIFIED |
| `g27/controls-g27.json` | planted faults on that certificate (w overclaimed; a singleton raised; a weight moved across classes; a point moved) refused for their named reasons, relabelled twin passed — 5/5 | log |
