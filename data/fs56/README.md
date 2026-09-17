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
| `g27/levels-g27.out` | `G27`'s programme by full enumeration (182,304 independent sets), float LP: level 1 (plain χ_f) 3.000, level 2 (pairs) 3.722, level 3 in the file; full congruence 4 is the certificate above (`tools/fs56_gf_levels.py`) | reading |
| `local-ratios.out` | least character mean over the unit circle at the real place and at the planes 𝔽₃ … 𝔽₈₃, and each quadratic field's compact-place minimum and fractional ceiling (`tools/fs56_local_ratios.py`) | readings (floats); ceilings are theorems |
| `q1/low-height.out` | ℚ(√167) at small height: unit vectors by denominator (20 … 324 for 84 … 10,920), no triangle or 5-cycle, index-4 lattices, additive colourings into ℤ/4 or ℤ/5 up to 5,460, odd girth 7 (`tools/fs56_low_height.py survey`) | exact |
| `q1/ball-420-r3-check.out` | the radius-3 ball of `Cay(Λ₄₂₀, W₄₂₀)`, 37,681 points / 108,152 edges: CaDiCaL's 3-colouring VERIFIED on the edges and EXHAUSTIVELY (every same-coloured pair by exact quadrance, with a planted recolouring caught). CNF and model regenerable under `build/fs56/q1/` (`ball 420 3`) | verified colouring |
| `q1/ball-2184-r3-check.out` | the same for denominator 2,184: 215,409 points / 632,124 edges | verified colouring |
