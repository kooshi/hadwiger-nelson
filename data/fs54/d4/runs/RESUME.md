# FS-54 D4 runs — resume commands (written before launch)

Checkpoints live in `data/fs54/d4/ckpt/` (outside `build/`; not committed — large). Every solve rewrites its checkpoint
atomically (tmp + rename) at each report. **A relaunch is the launch command WITHOUT `--new`**: with `--new` an existing
checkpoint is refused, and without it a missing checkpoint is refused, so a wrong path cannot silently start from zero.
Stop a run by its pid (`ps -eo pid,args`), verify by the pid absent and the checkpoint's digest static — never `pkill -f`.

| run | state | resume |
|---|---|---|
| q=27 level-3 ADMM (the pricing trajectory) | **stopped by pid (550586, SIGTERM) at ~25,671 iterations, 2026-09-16 11:22**, to free the cores for pricing 47 — the certificate `data/fs54/cert-q27-l3-N141.json` was already filed and a lower N decides nothing (five needs 146, six 122); last line: upper reading 140.974, lower 141.972; checkpoint `ckpt/admm-q27.npz` (11:21:30, sha256 `ab277ec92952981d…`, verified static after the pid vanished) | `OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 .venv/bin/python -u tools/fs54_d4_quad.py solve --q 27 --modulus 't^3-t-1' --family l3 --method admm --proj-threads 14 --ckpt data/fs54/d4/ckpt/admm-q27.npz --eps 1e-6 --max-iters 400000 --report-seconds 60 --out data/fs54/d4/runs/admm-q27.json` (no `--new`, no cap; ~0.17 s/it; expected over 30 min — **needs approval**) |
| q=19 level-3 ADMM calibration | **paused by pid at 6,090 iterations** to free the cores for 27 | `OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 .venv/bin/python -u tools/fs54_d4_quad.py solve --q 19 --family l3 --method admm --proj-threads 12 --ckpt data/fs54/d4/ckpt/admm-q19.npz --eps 1e-6 --max-iters 200000 --report-seconds 60 --out data/fs54/d4/runs/admm-q19.json` |

The q=27 run was first launched with `--new --stop-after-chunks 8000` (for `--method admm` the cap counts iterations from
the launch or resume point). The q=19 run was first launched with the batched projector and resumed on the thread-pool
projector (log part 1: `admm-q19-part1-batched.log`).
