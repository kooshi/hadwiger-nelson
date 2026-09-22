# Owner's scoring of Phase 2D — the certificate at 23 (2026-09-21, evening). ACCEPTED.

| check | result |
|---|---|
| The frozen checker (`tools/fs66_b1_cert_check.py`, sha256 `735b926798ffac14…`, unmodified) run by me on the shipped `data/fs66/b1/cert-p23.json` (sha256 `28cf189c83d2…`), `--m 5` | **CERTIFIED**, exit 0; 3,049.7 s wall / 3,035.4 s user, 8.60 GB peak (`po-recheck-phase2d-23.out`). `5·U_num = 48992318760443262233948788623512870 < 529·scale`. |
| `records.jsonl` at `p = 23` recounted against the file's digest | 15 rows: 13 producer rows (one, `D = 14`, `shift = 1e-10`, carries the shipped digest) and 2 check rows (`--m 5` CERTIFIED, `--m 6` BOUND ONLY), both naming the shipped digest and the frozen checker's. |
| The 87-point independent set of `UD(𝔽₂₃, 2)` in `level-one-sets.json` | 87 distinct points, 0 internal unit edges, by my own all-pairs code from the definition (shares nothing with the implementer's verifier). |
| Plant A — one row multiplier negated (row 777) in a scratch copy | **REFUSED NEGATIVE_MULTIPLIER** at step 2, in 1.16 s, naming the row and the count. |
| Plant B — one block entry `R[3][5]`, `R[5][3]` of the first 267-block raised by 1 | **REFUSED IDENTITY_MISMATCH** at step 6 after 3,047.8 s: the two sides differ at 144 of 134,447 canonical monomials, the first three named with their residuals (±2116). Positive definiteness survived the plant, as it should — the refusal came from the identity, the right cause. |
| Headline integers read from the file by me | `U_num = 9798463752088652446789757724702574`, `scale = 10^32`; `5·U_num < 529·scale` true, `6·U_num < 529·scale` false. |

So `U = 97.984637520886524467…`, and by the hand links L1, L2, L6 of `data/fs66/b1/SOUNDNESS.md` **no `UD(ℤ/23^k, 2)`, `k ≥ 1`, is
five-colourable**; `α(UD(𝔽₂₃, 2)) ≤ 97` by L2's `k = 1` case. Both plants refused for their own named reasons, on the shipped file's
size. The implementer's own controls (`U_num − 1`; a moved point in the 87-set) were different plants from mine.

**Where the implementer corrected the record, accepted:** the rounding law is `10^(4−D)` at 23, not `10^(3−D)` (the recipe followed
literally returns no certificate — the scan must cover three decades); the rounding cost 7.6× 19's, not 2.9× (the cascade over K, not
the product table, dominates); the checker's hot spot at 23 is the Bareiss eliminations (≈ 35 of 52 min), not the product table;
`⌊U⌋ = 97` is final for this instrument (the relaxation's optimum is 97.5677, so 96 is unreachable). All four are in G66 or the plan.

**The GPU solve at 23 is stopped at the close** (record before signal, per the rule): *cause* — the certificate is in and the integer
part of `U` cannot improve; *measurement* — chunk 2 at 6,000 iterations, `pobj 97.567673`, `dobj 97.567172`, `res_dual 1.94e−03`,
13 h of graphics card A; *forfeit* — decimals of `U` (≈ 97.57 against 97.98) and a converged iterate nobody has a use for; the checkpoint
`solve-gpu.npz` stays on disk (untracked, regenerable-by-resume), and `data/fs66/ckpt/b1-p23/README.md` holds the resume command and
the two re-round commands should anyone want the decimals.
