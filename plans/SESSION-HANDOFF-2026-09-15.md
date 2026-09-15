# Session handoff — 2026-09-15, 06:40 (de Bruijn; FS-50 CLOSED: six colours refused at 83 by exact certificate; FS-53 the sixth colour stubbed as the next milestone)

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

10. **The two relaxations, measured properly (the implementer, 04:50): the extra rows are valid, new, and INACTIVE at 11 and
   23.** One tool, one tolerance (10⁻⁹), one thing differing: canonical list vs all three edges gives 29.176799 / 29.176799
   at 11 (152 extra rows over 96 orbits) and 108.546073 / 108.546073 at 23 (1,740 over 980). My earlier 23 comparison differed
   in two things (rows AND tolerance: the reading tool at SCS's default 10⁻⁴; the producer's own formulation reads 108.621145
   there). **Decision: do not extend the canonical list now**; record the rows as a known unexploited strengthening and revisit
   only if the two 83 solves converge to different values at equal tolerance (then it is a measurement, not a hunch).
11. **The baseline, uncontended (bench, 04:45):** the wheel's sequential MKL Pardiso runs **1.405 s/iteration alone** (lin-sys
   94 %, cones 3 %, factorisation 771 s); the 3.4 s/it the four concurrent solves showed was memory-bandwidth contention
   among bandwidth-bound direct solves (2.5×). `cpu_indirect` 0.76 s/it (setup 3 s). So the GPU is ≈ 7× the lone sequential
   solver, 17× the contended one, ≈ 2× the threaded Pardiso (0.70 s/it, 8 threads). The BLAS part was never the cost.
12. **`--against` is unavailable at 83, and the checker's last line contradicts its verdict there.** With `--against
   data/fs50/wo18/p83-chain.json` the four checks CERTIFIED the file and the 597-set was re-verified independent, then after
   34 min 17 s the run ended "NOT A CERTIFICATE: --against assembles the certificate's matrices … 47458321 entries … re-run
   without --against". The 34 minutes are `evaluate_at_set` calling `build_orbits(p)` (the n² union-find) at line 1266 and an
   n × n addition table at 1279, both before the `p > 29` guard at 1299. **DONE 05:05 under a recorded decision (plan §M3; self-test green with controls 12–14; the 83 file with
   `--against` now ends on CERTIFIED in 16.9 s, exit 0). What was done:** decide the display's feasibility as the first statement of `evaluate_at_set`; print the
   CERTIFIED line last in every path; make the unavailability a note, not a refusal; add the negative control that a run with
   an unavailable `--against` still ends on CERTIFIED; re-run the whole self-test. **The HALT-AND-VERIFY protocol at 83 is
   therefore:** the untouched checker on the file FIRST (it decides), then a second rounding from the same iterate at a
   different cut and denominator, then `--ldl` on the blocks; the 597-set's independence is the part of `--against` that does
   run. Latest rounding from the live checkpoint (the implementer): N = 1379.80 at 6,000 iterations; the rounding gap over
   the objective has gone 1380 → 1159 → 310 while the objective sits within half a unit of 1,070 since 3,000 iterations —
   the dual's inaccuracy is what must close, to about 78.

## 2. What is running at 05:30 (all on the desktop; ≈ 40 GB of 125 in use; every one resumable)

| pid | what | checkpoint | note |
|---|---|---|---|
| 2808409 | the producer `fplane_cert_round.py --p 83 --blocks --real --chunk 500 --linear-solver gpu_indirect …` on **card A** (`build/venv-sdp-gpu`), from the 1,000-iteration checkpoint at 04:06 | `data/fs50/ckpt/scs-p83-cert-real.npz` (every 500 iterations ≈ 100 s) | log `build/fs50-p83-real-gpu.log`; at 23,500 (05:27): pobj −1067.08, res_pri 1.87, res_dual 4.4e-2, the dual residual falling ≈ 5e-4 per 2,500; **relaunch = the same command** (README "Resume") |
| 2816615 | the reading driver `fplane_sdp_scs.py --p 83 --eps 1e-5 --chunk 2000 --linear-solver gpu_indirect` on **card B** (`build/venv-sdp-mkl`, `LD_LIBRARY_PATH=build/venv-sdp-mkl/lib`, `CUDA_VISIBLE_DEVICES=0`) — the TIGHTER relaxation (all three le_diag rows), a reading | `data/fs50/ckpt/scs-p83-real-gpu.npz` (every 2,000 ≈ 8 min) | log job tmp `sdp/s83gpu.log`; at 16,000: pobj −1019.44, res_pri 2.8e-2, res_dual 3.9e-2; relaunch = the same command |
| 2891008, 2891009 | the backend-honesty controls, relaunched 05:22 on the wheel's sequential Pardiso (`--linear-solver mkl`, `build/venv-sdp`) from the verified 5,000-iterate copies `sdp/ckpt-control{,-qdldl}.npz` (the QDLDL pair killed after 58 min in the factorisation) | none needed (a control; redo ≈ 30 min) | logs `sdp/ctl-mkl.log` (+500 iterations, its chunk line beside the GPU's at 5,500: pobj −1070.334948, res_pri 1.64, res_dual 5.83e-2) and `sdp/ro-mkl.log` (`--round-only`; its exact N beside the GPU wheel's 1401.821726 on the same iterate) |
| 2895860 | `sdp/anytime-loop.sh`: every ≈ 25 min copies the live checkpoint at a chunk boundary and rounds an exact bound from it on the GPU wheel (`--round-only`, never touching the live file) | — | one line per rounding in `sdp/anytime-loop.log` (iterate, float, exact N, residuals, file); **writes `HALT AND VERIFY` there when ⌊N⌋ ≤ 1148** — then the untouched checker on that file first, a second rounding, `--ldl`, before any sentence |

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

## 3. What to do next, in order (rewritten 06:40 after the close)

**GO (Kooshi, 2026-09-15 ~10:30): FS-53 subplanning is under way — WORKFLOW steps 3a (§PA), Poros planning-only, the planner
(one subagent at a time), then the modeling passes; PAUSE before implementation (step 7). Every step commits as it lands and this letter's §3 says which step was reached. Progress ledger:** §PA — DONE (committed; `plans/STUB-sixth-colour.md` §PA, with the stub's §0/§2 corrected: 83 is only ≥ 7,
the window's upper bounds are the line-periodic 8/8/8/10/10/12, five is CDCL-undecided at 23–47, Moorhouse's open cell at 17 is phase A′);
Poros — DONE (`plans/POROS-2026-09-15-fs53-planning.md`, committed; verdict: the certificate cannot refuse six at 23–47 (reach 0.82–0.90 of the ratio bound against thresholds 0.67–0.79) and can at 67/79 and refuse five at 43/47; nobody has ever asked a window plane for six colours — the first measurement is `plane-colour --p 23 --k 6`; the window has EIGHT members, q = 27 (𝔽₂₇, field ℚ(√3, α), α³ = α + 1) was omitted from the stub and G56; `field_q27` was deleted by a3adc46 so `chi-q27.json` is unreproducible; the '+1 over the floor' reading is false at p = 3 (tight) and its repair is χ = ⌈q²/α⌉; Kooshi's asymptote inverted: χ_f = q²/α diverges like √q and crosses six once near 23–31); the first measurement DONE and committed (`data/fs53/README.md`: no window plane found six-colourable by the Rust colourer at 23/31/43/47, nor seven at 23; controls green); planner — RUNNING since ≈ 12:50 (Opus; writes §S into `plans/STUB-sixth-colour.md` and the skeleton, commits incrementally; brief at job tmp `planner-brief-fs53.md`); modeling passes — not started (de Bruijn runs them, fresh Skill invocations, after the planner's commit); then PAUSE before implementation (Kooshi).

**FS-50 is closed** (ledger row 68, G56, `plans/STUB-independence-threshold.md` §Close, committed): six colours refused at 83
by two independent exact certificates, α(UD(𝔽₈₃,2)) ≤ 1082 (`data/fs50/p83-refusal/`; the README's "refusal of six" section
has the table, the mechanism and the reproduction command). The certificates came from the backend-honesty control's two
arms — a fresh +500 continuation of one checkpoint on each backend, each rounding its own dual — where the live run's
iterates rounded 200 above the objective (SCS's adaptive scale is not checkpointed) and `--round-only`'s nudge costs ~170.

1. **DONE 07:00 — the reproduction rerun** (identical chunk line; 1082.915378 reproduced; twelve cuts of the same dual all ⌊N⌋ = 1082; recorded in the README). Originally: (job tmp `sdp/repro.log`; the Pardiso arm from `iterate-5000-common-parent.npz`
   with a dual cache and three cuts): its 10⁻⁸/10¹⁰ candidate must reproduce 1082.915378 to every digit; the other cuts round
   the identical dual. Record the numbers in the README's refusal section.
2. **The seven-colouring attempt at 83** (`~/source/descent-engine/target/release/plane-colour --p 83 --k 7`, a few
   minutes): found ⟹ χ(UD(𝔽₈₃,2)) = 7 exactly (the colouring kernel-consumable); not found ⟹ "not found", nothing decided.
   Either way a README row and a sentence in row 68.
3. **The converged reading**: the producer (pid 2808409) prints its chunk lines and at convergence rounds its own dual and
   checks the file; the polish loop (`sdp/anytime-loop2.sh`, pid in `sdp/pid-anytime-loop2`) rounds a fresh continuation
   every ≈ 25 min into `sdp/anytime-loop.log`. The tightest certificate replaces the README's table entry; the reading goes
   beside it as [solver]. Then kill card B reading run (2816615) — its value, the tighter relaxation's, is a reading only.
4. **FS-53 the sixth colour** (`plans/STUB-sixth-colour.md`, rank 1): WORKFLOW step 3 — the §PA prior-art gate first (in the
   disciplines' words: finite Euclidean graphs' chromatic and independence numbers; splitting conditions for number fields),
   then the subplan (Poros planning-only, before the planner; one subagent at a time; Opus implementers), skeleton, modeling
   passes; the table across the window on the GPU is phase A and starts with 23 and 47.
5. Standing: the checker is frozen again (one recorded change, §M3); FS-52 is the kernel form of the certificate; a session
   handoff before any compaction.

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
