# Session handoff — 2026-09-15, 04:10 (de Bruijn; FS-50 in flight: the 83 solve moved to the GPU — 10× per iteration — after Kooshi applied the killable-run rule; the first exact bound at 83 being rounded from a live iterate)

You arrive with no conversation memory. The record of record is `CLAUDE.md` § Frontier and § Grokkings; the milestone's
plan is `plans/STUB-independence-threshold.md` (§PA, §S0–S9, §M1–M3 appended); every record `data/fs50/README.md`, one row
per file; the advisor's pass `plans/POROS-2026-09-14-fs50-planning.md`. This letter supersedes
`plans/SESSION-HANDOFF-2026-09-14-fs50.md` (whose §1 still lists what the milestone established through 2026-09-14 — read
it once; nothing there is repeated here).

## 1. What changed since that letter

1. **Exact certificates:** `α(UD(𝔽₁₁,2)) ≤ 29` (`data/fs50/cert-p11-N29.json`) and `α(UD(𝔽₂₃,2)) ≤ 108`
   (`cert-p23-N108.json`; the real-block producer later reached `N = 108.546075`, the tightest exact bound at 23 here, by a
   rounding denominator of `10¹⁰`) — checked by `tools/fplane_cert_check.py` (standard library, rebuilds everything from `p`,
   0.19 s / 4.9 s). FS-17 re-described: `α(23) ∈ [87, 108]`; the relaxation's own optimum 108.55 cannot reach 105.
2. **The kernel:** `add_one_le_chromaticNumber_of_indepNum_le` (`LocalGlobal.lean`) and the instances at 83 / 23 / 11
   (`Instances/IndependenceThreshold.lean`), gates green; the vacuity baseline header re-recorded.
3. **The real block form** (base points on the two reflection axes; `tools/fplane_sdp_blocks.py --real`): 108.5467 at 23 in
   5.4 s against 208 s Hermitian; the certificate producer carries it (`tools/fplane_cert_round.py --blocks --real`, the
   implementer's; the checker byte-identical — its weights are data).
4. **The overnight loss, and the protected rule.** Three multi-hour solves at 83 were lost: no checkpoint, `timeout` walls,
   and killing a wrapper kills its child (GNU timeout 9.11, `PR_SET_PDEATHSIG`). `CLAUDE.md`'s checkpointing paragraph is
   restored to its full reasoning from git, carries this instance as clause 3, and is tagged **PROTECTED — never compress**;
   the file's size budget is **200,000 bytes** (Kooshi, 2026-09-15; it is at ≈ 150,100).
5. **The checkpointed driver** `tools/fplane_sdp_scs.py`: SCS in warm-started chunks, the iterate saved after every chunk,
   one residual line per chunk, no wall; **its first version stopped after one chunk with a wrong value** (SCS labels a
   capped chunk `solved (inaccurate - reached max_iters)`; the implementer's catch) — fixed at cd8913f's successor, the
   control at 23 runs four chunks and ends on a clean `solved`.
6. **The first numbers from 83** (the implementer's producer): ≈ 3.4 s per iteration; a day or more to convergence; an
   early iterate at 1085.75 with primal residual 4.7 — **an iterate, not a value, not a bound**; iterates approached the
   optimum from above at 11 and 23.

7. **The backend finding, and the rule applied (04:00–04:10).** This SCS wheel selects its linear-system backend by the
   STRING keyword `linear_solver=` (`qdldl`, `mkl`, `cpu_indirect`, `cpu_dense`, `gpu_indirect`, `cudss`); `use_indirect=` /
   `mkl=` were the wrong names, which is all the "constructor rejects" trap ever was. Every driver ran the wheel's AUTO
   choice — its statically linked *sequential* MKL Pardiso, one thread. Measured on the real 83 problem (A 483,397 × 49,447,
   nnz 18.9 M, 86 PSD blocks ≤ 83; box contended): **0.33 s per iteration on `gpu_indirect` (graphics card A) against 3.4 s** —
   lin-sys 76 %, the 86 CPU eigendecompositions 18 %, acceleration 2 %; setup 2 s against minutes of factorisation. The GPU
   backend was built from source (bodono/scs-python tag 3.3.1, meson, `-Duse_gpu=true -Dint32=true -Dnative_arch=true`,
   with `LIBRARY_PATH`/`LEAN_CC` unset or the compiler probe fails) into `build/venv-sdp-gpu/` (reference LAPACK for the
   cones; cvxpy on top) and, with `-Dlink_mkl=true` against the pip `mkl` packages, into `build/venv-sdp-mkl/` (threaded
   Pardiso + MKL LAPACK; needs `LD_LIBRARY_PATH=build/venv-sdp-mkl/lib`; being timed on card B). **Kooshi's ruling:** the
   four single-threaded solves kept running while their replacement was measured were "a blocking-its-own-replacement
   instance"; the rule's paragraph in `CLAUDE.md` is restored to its d5fa3bc wording, carries this instance, and is tagged
   PROTECTED. Applied: my two reading solves killed (no checkpoint yet; ~1,800 and ~550 iterations of a redundant reading
   forfeited), the implementer's producer killed mid-chunk (≤ 500 iterations forfeited, three GPU minutes) and relaunched
   from its 1,000-iteration checkpoint with `--linear-solver gpu_indirect` (the flag added to `fplane_cert_round.py`,
   default `auto`, every old command line unchanged). The implementer was told all of this by message.

8. **Two relaxations, not one (04:35).** The checker's `canonical_constraints` emits ONE `le_diag` row per orbit (P6 at the
   representative's first endpoint), while `fplane_sdp_scs.py` / `fplane_sdp_blocks.py` impose P6 at all three edges of
   the triangle an orbit represents (at 83: 139,361 rows over 47,601 orbits — 81 with one, 3,280 with two, 44,240 with
   three). So the reading tools solve a strictly tighter relaxation than the producer certifies; at 23 the two agree to
   < 10⁻³ (the extra rows did not bind). At 83 the driver's formulation on card B (`build/venv-sdp-mkl`, pid 2816615,
   ckpt `data/fs50/ckpt/scs-p83-real-gpu.npz`, log job tmp `sdp/s83gpu.log`) read pobj −1031.64 at 2,000 iterations with
   res_pri 5.5e-2 / res_dual 1.2e-1 (0.27 s/it), against the producer's −1070.23 at 6,000 with res_pri 1.66 — not yet
   comparable as values. For the six-colour sentence the certified relaxation suffices if it lands under 1,148; for the
   TABLE the tighter one is the better number where the rows bind, and certifying it means extending the canonical list
   (three rows per orbit), the derivation's multiplier steps 1–3 and the wire format, and regenerating the 11/23
   certificates — **a decision for the close**, sent to the implementer for its report.
9. **The GPU backend's honesty controls (launched 04:24 from a verified copy of the 5,000-iteration checkpoint, job tmp
   `sdp/ckpt-control.npz`):** +500 iterations on the sequential direct solver (`ctl-qdldl.log`, chunk line to sit beside
   the GPU's line at 5,500: pobj −1070.334948, res_pri 1.64, res_dual 5.83e-2) and `--round-only` under both wheels on
   the same copy (`ro-cpu.log`, `ro-gpu.log`; exact N should agree to ~10⁻⁶, as the control at 11 did). The implementer's
   reading of the rising primal residual — adaptive scaling trading primal for dual feasibility, the objective's
   increments shrinking cleanly — stands unless the qdldl line contradicts it. The 1,000-iteration certificate was
   CERTIFIED by the untouched checker here too (⌊N⌋ = 2232; `--k 6` says nothing, as it must).

## 2. What is running at 04:10 (all on the desktop; ≈ 40 GB of 125 in use; every one resumable)

| pid | what | checkpoint | note |
|---|---|---|---|
| 2808409 | the producer `fplane_cert_round.py --p 83 --blocks --real --chunk 500 --linear-solver gpu_indirect …` on **card A** (`CUDA_VISIBLE_DEVICES=1`, `build/venv-sdp-gpu`), launched 04:06 from the 1,000-iteration checkpoint | `data/fs50/ckpt/scs-p83-cert-real.npz` (every 500 iterations ≈ 3 min) | log `build/fs50-p83-real-gpu.log`; the CPU trajectory to compare against is `build/fs50-p83-real.log` (chunk 2 = 1,000 it: pobj −1073.97, res_pri 2.94, res_dual 0.377) — an inexact CG may change the iteration count, never the answer; **relaunch = the same command** |
| 2791699 | `bench83.py` in `build/venv-sdp` — the CPU split (qdldl / sequential mkl / cpu_indirect, 40/40/20 iterations) | none (a measurement; the problem data are cached at job tmp `sdp/p83-scsdata-*.npz`) | log job tmp `sdp/bench83.log`; answers "is it BLAS?" with SCS's own lin-sys/cone split |
| (bench) | `bench83.py gpu_indirect:60 mkl:40` in `build/venv-sdp-mkl` on **card B** | none | log job tmp `sdp/benchmkl.log`; decides whether the producer moves to the MKL-linked build at a checkpoint (faster cones) and gives the threaded-Pardiso CPU number |

Killed 04:01–04:06 under the rule: 2690393 and 2764850 (my reading solves, no checkpoint on disk) and 2701719 (the
producer, superseded by 2808409). The implementer's `--round-only` run (2777345) finished on its own: float bound
1074.02 at the 1,000-iteration iterate, exact N = 2466.27 recorded — and its re-score of the winner disagreed with the
sweep's record (2232.9 against 2466.3), which the implementer must resolve before any exact bound at 83 is a row.

The producer's full relaunch command (no wall; `cd` outside the backgrounded list; the pid file in the job tmp):
`setsid bash -c "echo \$\$ > <pidfile>; cd /home/kooshi/source/lean-dir && exec env CUDA_VISIBLE_DEVICES=1 OPENBLAS_NUM_THREADS=2 stdbuf -oL build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --p 83 --blocks --real --chunk 500 --scs-ckpt data/fs50/ckpt/scs-p83-cert-real.npz --linear-solver gpu_indirect --eps 1e-8 --max-iters 400000 --dual-cache data/fs50/ckpt/dual-p83-real.npz --ckpt data/fs50/ckpt/round-p83-real.jsonl --thresholds 1e-9,1e-8,1e-6,1e-4 --denominators 1000000,100000000,10000000000 --weight-denominators 100000000,10000000000 --out data/fs50/cert-p83.json" >> build/fs50-p83-real-gpu.log 2>&1 &`

The implementer agent (Opus, phase E) is still active and reports on its own; its commits are local (never pushed by it) —
review against the artifacts (run the checker yourself on any certificate; read the README rows), then push. Untracked
under `data/fs50/ckpt/`: its two files (its to commit) and my `scs-p23-ctrl.npz` (a control artifact; delete).

Launch recipe that works (the `cd` must be OUTSIDE the backgrounded list, paths absolute):
`setsid bash -c "echo \$\$ > <pidfile>; cd <repo> && exec env OPENBLAS_NUM_THREADS=4 stdbuf -oL <venv>/python <tool> …" > <log> 2>&1 &`
— no `timeout`, ever, on a solve. Waiters: by a known pid (`kill -0`), never `pgrep -f` (it matches the waiter itself).

## 3. What to do next, in order

1. When the implementer's report lands: review (the checker on its certificates; its README rows; the round-only bound
   with its iteration count and residual beside it), push, thank it by name for the chunk-loop catch and the mechanism.
2. Watch the GPU producer's chunk lines against the CPU trajectory; if `build/venv-sdp-mkl` times faster on card B bench,
   move the producer to it at a checkpoint (`LD_LIBRARY_PATH=build/venv-sdp-mkl/lib`, same command). The reading IS the
   producer's chunk lines; no separate reading run is relaunched.
3. The **first exact bound at 83** (round-only): a README row and a ledger sentence — `[exact-rational]`, with the iterate's
   residual — and, if `⌊N⌋ ≤ 1148`, HALT AND VERIFY per the previous letter's §3 before any sentence about χ.
4. The close (WORKFLOW step 9), keyed on the outcome exactly as the previous letter's §3 lays out: the ledger row with the
   three trust levels; rows 53/56; G44/G48; item 2 of "what the hunt has established"; `plans/FRONTIER-STUBS.md` re-ranked
   with FS-51 and FS-52 added (assert every FS exactly once) and the mirror in `CLAUDE.md`; the conjecture sweep;
   `BIBLIOGRAPHY.md` listings (Schrijver 2005, Gvozdenović–Laurent 2008); memory.
5. Kooshi's open decision (the advisor's card 3): the product as the *table* of certified bounds (recommended, the default)
   or the bit at 83.

## 4. Kooshi's rulings today (2026-09-15)

- The checkpointing rule is PROTECTED; its reasoning is never trimmed; every multi-hour launch answers "if this dies now,
  what is redone?" before it starts (memory: `protected-rules-checkpointing.md`, `timeout-wrapper-kill.md`).
- `CLAUDE.md`'s budget is 200,000 bytes.
- One subagent at a time; Poros for planning only, before the planner (standing from 2026-09-14).
- **The killable-run rule is PROTECTED and this was an instance** (04:00): measuring a replacement is not a precondition
  for stopping the run it replaces; kill at the checkpoint, relaunch on what the measurement names.

## 5. Traps met since the previous letter

- Killing a `timeout` wrapper kills the child; there is no after-the-fact detachment. Never wrap a solve.
- SCS's capped-chunk status begins with "solved"; only a clean "solved" is convergence.
- This SCS wheel's constructor rejects `use_indirect=` and `mkl=` **because those are the wrong keywords**: the backend is
  `linear_solver="mkl"` etc. (a string); the "indirect is slow" reading at 23 was that crash, and "MKL unusable" was this.
- A meson build under the Lean dev-env fails its compiler probe ("`/usr/bin/ccache cc` cannot compile programs"): unset
  `LIBRARY_PATH` and `LEAN_CC` for the build.
- `setsid bash -c '…' &` with the `cd` inside the backgrounded list writes the pid file in the wrong directory.
- A message about process behaviour sent to another agent without testing it on `sleep` cost that agent a run.
