# FS-53 phase B — the certificate side: exact rational upper bounds on α(UD(𝔽_q,2))

The instrument: the triple-level SDP on the orbit algebra, block-diagonalised into real blocks, solved by SCS
through its own API in warm-started chunks on a GPU, its dual rounded to an exact rational certificate that
`tools/fplane_cert_check.py` (frozen; standard library only) re-derives from the number `q` alone.

**The mechanism, and it is the whole thing.** The exact bound is rounded from a **fresh short continuation's own
dual** — a copy of the producer's checkpoint resumed for +500 iterations in a *new* solver object, whose dual is
then swept over several cuts. Never a long-run iterate, never `--round-only`'s nudge: SCS's adaptive scale is not
checkpointed and drifts (the same 83 solve gave 1082 one way and 1260 the other).

## Order and targets

| # | q | sentence | needs ⌊N⌋ ≤ | ratio bound | card |
|---|---|---|---|---|---|
| 1 | 79 | six refused (`--k 6`) | 1040 | 1099.19 | 1 (graphics card A) |
| 2 | 67 | six refused (`--k 6`) | 748 | 813.78 — 0.9 % of margin | 0 (graphics card B) |
| 3 | 47 | five refused (`--k 5`) | 441 | 466.39 | — |
| 4 | 43 | five refused (`--k 5`) | 369 | 395.23 | — |
| 5 | 59 | six refused (`--k 6`) | 580 | 693.14 — expected out of reach | — |

`q = 27` was delivered early by phase A0.4: `data/fs53/cert-q27-N147.json`, CERTIFIED, α ≤ 147.

## Launch and resume commands — written BEFORE launch (PROTECTED rule, `CLAUDE.md` § checkpointing)

Every producer's state is the checkpoint `data/fs53/ckpt/scs-q<q>-real.npz` (outside `build/`), rewritten after
every chunk of 500 iterations. **A relaunch is the launch command, unchanged**: `--scs-ckpt` both resumes from and
saves to that path. A path that does not exist means "start from zero", silently — so the iteration count in the
checkpoint is printed before every launch and every polish.

Producer (resume = the same line):

```
env CUDA_VISIBLE_DEVICES=<dev> OPENBLAS_NUM_THREADS=2 OMP_NUM_THREADS=2 \
  build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --p <q> --blocks --real --chunk 500 \
  --scs-ckpt data/fs53/ckpt/scs-q<q>-real.npz --linear-solver gpu_indirect \
  --eps 1e-8 --max-iters 400000 --ckpt data/fs53/ckpt/round-q<q>.jsonl \
  --thresholds 1e-8 --denominators 10000000000 --weight-denominators 10000000000 \
  --out <scratch>/cert-q<q>-producer.json
```

Polish (the certificate producer; `it` is the copy's own iteration count):

```
cp data/fs53/ckpt/scs-q<q>-real.npz <scratch>/ckpt-polish-q<q>.npz
env CUDA_VISIBLE_DEVICES=<dev> OPENBLAS_NUM_THREADS=2 OMP_NUM_THREADS=2 \
  build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --p <q> --blocks --real --chunk 500 \
  --scs-ckpt <scratch>/ckpt-polish-q<q>.npz --linear-solver gpu_indirect \
  --eps 1e-8 --max-iters $((it+500)) --ckpt <scratch>/round-polish-q<q>.jsonl \
  --thresholds 1e-9,1e-8,1e-6 --denominators 1000000,100000000,10000000000 \
  --weight-denominators 100000000,10000000000 --out <scratch>/cert-q<q>-polish-$it.json
```

No `timeout` wall on any solve. Launched with `setsid`; the pgid is in `<scratch>/pgid-q<q>`; a kill is by pgid and
is verified by what stopped changing in the log, never by the exit status of the kill.

Scratch: `/home/kooshi/.claude/jobs/b1507518/tmp/phaseB/`.

## Log

**18:22** both producers launched, one per card: q = 79 on device 1 (graphics card A, pid file `pid-q79`), q = 67 on device 0
(graphics card B, `pid-q67`). Neither checkpoint existed, so both started from zero — stated before launch, not discovered after.

**18:30–18:47 item 0, the `le_diag` experiment** at q = 11, 23, 27 on the CPU beside the GPUs. Result in
`data/fs53/README.md`: the extra rows are inactive **and so is the whole class** — the plant (drop every `le_diag` row)
did not fire at any member, while the reachability control (drop the killed-orbit equalities instead) fired at all three,
collapsing each bound to the trivial `q²`. Extending the canonical list cannot close 67.

**18:47 q = 79 CERTIFIED at N = 1023.382029, ⌊N⌋ = 1023 — six refused** (`6 × 1023 = 6138 < 6241`), from a 2,000-iteration
iterate resumed +500 in a fresh solver. All 18 cuts agree on ⌊N⌋ = 1023; `--ldl` green; the checker's sha256 unchanged
(`057263079bb…`). Filed as `data/fs53/cert-q79-N1023.json` with `ldl-q79-N1023.log`.

**18:49 the q = 79 producer and its polish loop stopped, and the card moved to q = 47** — the killable-run rule: 79's
target was met with 17 integers to spare, nothing else was asked of that member, and the run was the only thing standing
between card A and member 3. It forfeits a tighter 79 bound that no sentence needs. Producer q = 47 launched at 18:49
(device 1, `pid-q47`), ~15 s per 500 iterations.

**INCIDENT, self-inflicted, nothing lost — the `pgrep -f` failure mode in a hand-rolled costume.** The stop above was
done by a Python scan of `/proc/*/cmdline` for the string `polish-q79.sh`. **That string was also in the command line of
the shell running the scan**, so the scan killed its own process group (exit 144). The standing rule names `pkill -f` and
`pgrep -f`; a hand-written matcher over `/proc` is the same instrument and has the same defect. Nothing was lost: the 79
certificate was already filed and checked, the run being killed was being killed deliberately, and q = 67 (18,500
iterations at the time) and the experiment were untouched. **The repair, in use since:** `pidof_log.py` finds a process by
the **inode** of the log file it holds open — it matches no command line, so it cannot match the shell that runs it — and
every launch writes `pid-q<q>` / `pgid-q<q>` before anything else may signal it.
