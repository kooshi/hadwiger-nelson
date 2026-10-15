# FS131-KC13 working files

- `lean/FibreCheck.lean` — the kernel checker as measured (core Lean). `lean/Cert{3,7,11}.lean` — FS-66's certificates
  re-encoded by `tools/fs131_kc13_gen.py` (commands below); `lean/K*.lean` the `decide +kernel` declarations measured;
  `lean/E*.lean` the compiled `#eval` checks; `lean/P*.lean`, `Prof7.lean` the profiling probes of stage 2.
- `lean/controls/` — planted faults (`--corrupt U|rowlam|Rentry|stream|M`); `KF*` prove the checker returns `false`.
  `Bad11U.lean` is not committed (4.3 MB): regenerate with the p = 11 command and `--corrupt U --no-psd`.
- `probes/` — the cost-model probes (kernel arithmetic, loops, trees, retention, list literals, hash collisions).
  The 2 MB literal probes were deleted after measuring (`ListLit`: 1,000 × 8 kbit, 3.8 s; `BigLit`: one 1 MB literal,
  killed after 2 min of parsing).
- `logs/` — every measured run.

Build (from `lean/`, with `LEAN_PATH=$PWD:$(lean --print-libdir)`):

    lean -o FibreCheck.olean FibreCheck.lean
    python3 ../../../../tools/fs131_kc13_gen.py ../../../fs66/b1/cert-p11.json Cert11.lean --name cert11 --nseg 2
    lean -o Cert11.olean Cert11.lean
    lean K11s0.lean   # under scripts/slot.py --mem 13 --cpus 1
