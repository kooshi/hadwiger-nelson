# data/fs56 — FS-56, ℚ(√167)

Plan: `plans/FS56-quadratic-167.md`. Current state only.

| path | what | trust |
|---|---|---|
| `../fs54/cert-q23-l3-N105.json` | **α(UD(𝔽₂₃,2)) ≤ 105**, exact N = 105.430586566, so χ(Γ₂₃) ≥ 6 (Q0). Filed beside the other level-3 certificates | CERTIFIED by `tools/fs54_l3_cert_check.py` |
| `../fs54/d4/check-q23-l3-N105.log` | the producer's checker run (6 s, 6 jobs) | log |
| `q0/recheck-po.log` | the PO's independent re-run in a fresh process (24 s, one job): CERTIFIED | log |
| `q0/controls.json`, `q0/controls/` | planted faults on that certificate: flipped sign, indefinite block, bumped Gram entry, lowered N refused for their named reasons; faithful dense twin passed — 5/5 as designed | log |
| `q0/round-q23-l3.log`, `q0/RESUME.md` | the rounding run and its launch/resume record (input: the 3,500-iteration calibration iterate, sha256 `9cd2d441…`) | log |
