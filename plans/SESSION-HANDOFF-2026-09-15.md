# Session handoff — 2026-09-15, 03:45 (de Bruijn; FS-50 in flight: four checkpointed solves at 83, the first exact bound at 83 being rounded from a live iterate; compaction next)

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

## 2. What is running at 03:45 (all on the desktop; ≈ 40 GB of 125 in use; every one resumable)

| pid | what | checkpoint | note |
|---|---|---|---|
| 2690393 | `fplane_sdp_scs.py --p 83 --eps 1e-5 --chunk 2000` — **the OLD loop** (in memory since 02:14) | `data/fs50/ckpt/scs-p83-real.npz` (written at its first chunk end, ≈ 1.7 h per chunk) | **it will exit after chunk 1 and write a bogus `data/fs50/sdp-p83-scs-real.json`**: delete that file and relaunch the same command with the fixed code — it resumes from the checkpoint. Log: job tmp `sdp/s83.log` |
| 2764850 | the same driver, fixed code, `--eps 1e-4 --chunk 1000` | `data/fs50/ckpt/scs-p83-real-e4.npz` | the earlier reading; log `sdp/s83e4.log` |
| 2701719 | the implementer's producer `fplane_cert_round.py --p 83 --blocks --real --chunk 500 --scs-ckpt …` | `data/fs50/ckpt/scs-p83-cert-real.npz` (updated every ≈ 28 min) | keeps the dual; the certificate's source |
| 2777345 | the implementer's `--round-only` against that checkpoint | `data/fs50/ckpt/round-p83-anytime.jsonl` | **any dual is a sound certificate**: the first exact bound at 83 comes from the half-converged iterate, weaker and real; each later rounding can only tighten |

The implementer agent (Opus, phase E) is still active and reports on its own; its commits are local (never pushed by it) —
review against the artifacts (run the checker yourself on any certificate; read the README rows), then push. Untracked
under `data/fs50/ckpt/`: its two files (its to commit) and my `scs-p23-ctrl.npz` (a control artifact; delete).

Launch recipe that works (the `cd` must be OUTSIDE the backgrounded list, paths absolute):
`setsid bash -c "echo \$\$ > <pidfile>; cd <repo> && exec env OPENBLAS_NUM_THREADS=4 stdbuf -oL <venv>/python <tool> …" > <log> 2>&1 &`
— no `timeout`, ever, on a solve. Waiters: by a known pid (`kill -0`), never `pgrep -f` (it matches the waiter itself).

## 3. What to do next, in order

1. When the implementer's report lands: review (the checker on its certificates; its README rows; the round-only bound
   with its iteration count and residual beside it), push, thank it by name for the chunk-loop catch and the mechanism.
2. When pid 2690393 exits: delete the bogus record, relaunch from the checkpoint. Read the first chunk lines of both of my
   runs for the per-iteration cost; if the 1e-4 run converges first, record its value as the reading.
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

## 5. Traps met since the previous letter

- Killing a `timeout` wrapper kills the child; there is no after-the-fact detachment. Never wrap a solve.
- SCS's capped-chunk status begins with "solved"; only a clean "solved" is convergence.
- This SCS wheel's constructor rejects `use_indirect` and `mkl`; the "indirect is slow" reading at 23 was that crash.
- `setsid bash -c '…' &` with the `cd` inside the backgrounded list writes the pid file in the wrong directory.
- A message about process behaviour sent to another agent without testing it on `sleep` cost that agent a run.
