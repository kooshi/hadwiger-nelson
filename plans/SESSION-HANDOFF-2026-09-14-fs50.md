# Session handoff — 2026-09-14, late (de Bruijn; FS-50 in flight: the certificate at 83 is being produced; the close follows)

You arrive with no conversation memory. The record of record is `CLAUDE.md` § Frontier and § Grokkings; the milestone's
plan is `plans/STUB-independence-threshold.md` (the stub with §PA, §S0–S9, §M1–M3 appended — the subplan); the advisor's
pass `plans/POROS-2026-09-14-fs50-planning.md`; every record `data/fs50/README.md`, one row per file. This file is the
letter. The previous handoff (`plans/SESSION-HANDOFF-2026-09-14.md`) is superseded by this one.

## 1. What FS-50 established today, in order (all committed and pushed; `git log` since 375cb9d)

1. **§PA** (`plans/FS50-prior-art.md`): nobody has an exact α of any finite Euclidean plane or a bound below the ratio bound;
   the real-plane 1-avoiding LP transplanted (`tools/fplane_lp.py`) closes 0.2% at 83.
2. **The finding side** (WO-18, the Rust `plane-independent`, gate green, every set re-verified here): **α(83) ≥ 597**,
   **α(23) ≥ 87**; targets 1,149 and 106 `not_found`; the rotation classes at orders 84/42/28 and the line quotient exact
   (505/589/533/581).
3. **CDCL is the wrong proof system**: undecided at every size tried at 19 (77–110) and 23 (110–140), including sizes above
   the ratio bound; the class-cube cliff (a residual-density threshold ≈ 0.41, the advisor's reading); RC2 MaxSAT stalls.
4. **The triple-level SDP** (`tools/fplane_sdp.py`, direct; `tools/fplane_sdp_blocks.py`, rotation-only DFT blocks; venv
   `build/venv-sdp`, SCS): **29.18 / 85.67 / 108.55 at 11 / 19 / 23** (Hoffman 34.55 / 99.50 / 131.76; the truth 28 / ≥ 76 /
   ≥ 87), the subgraph rows subsumed, every control green; the block form reproduces 11 and 23.
5. **Exact certificates** (Opus implementers, `tools/fplane_cert_round.py` → `tools/fplane_cert_check.py`, standard library,
   rebuilds everything from `p`): **α(11) ≤ 29** (`cert-p11-N29.json`) and **α(23) ≤ 108** (`cert-p23-N108.json`) —
   the first bounds below the ratio bound for any finite Euclidean plane, stranger-checkable; the derivation
   `plans/FS50-certificate-soundness.md`. FS-17 re-described: `[87, 108]`, the threshold 105 unreachable by this relaxation.
6. **The kernel**: `add_one_le_chromaticNumber_of_indepNum_le` (`LocalGlobal.lean`) and the instances at 83 / 23 / 11
   (`Instances/IndependenceThreshold.lean`); gates green; the vacuity baseline header re-recorded (it had read STALE for days).
7. Two kernel stubs drafted (`plans/STUB-ratio-bound-kernel.md` FS-51, `plans/STUB-triple-certificate-kernel.md` FS-52),
   **not yet in `plans/FRONTIER-STUBS.md`** — the close ranks them.

## 2. What is running when this file is written

`tools/fplane_cert_round.py --p 83 --blocks --solver SCS --eps 1e-5 --max-iters 200000 --dual-cache data/fs50/ckpt/dual-p83.npz
--ckpt data/fs50/ckpt/round-p83.jsonl --thresholds 1e-8,1e-6,1e-5,1e-4,1e-3 --denominators 10000,1000000,100000000 --out
data/fs50/cert-p83.json`, launched 18:5x under `setsid` (pid file `~/.claude/jobs/b1507518/tmp/sdp/pid-c83`, log `…/c83.log`;
one core, ≈ 26 GB, an eight-hour wall). **Resume = the same command**: the dual cache skips the solve once written (verified
bit-for-bit at 11 and 23); the rounding checkpoint loses at most one candidate. The implementer's stricter variant (eps 1e-9,
`OMP_NUM_THREADS=8`, `--weight-denominators`) is in `data/fs50/README.md`; use it if the bound lands within 0.1 of 1,149.
**Read the result as: the exact `N` should land 0.0001–0.0002 above the float value; far above means the sweep found a bad
corner — rerun the sweep off the cached dual.**

## 3. The close (WORKFLOW step 9), keyed on the 83 outcome

- `⌊N⌋ ≤ 1148` — **HALT AND VERIFY** (a second rounding; the checker's `--ldl` path; `--against` on the 597-set; a second
  solver's value if one runs in the time), then: the ledger row's headline is **χ(UD(𝔽₈₃,2)) ≥ 7 on an exact certificate**
  `[exact-rational]`; G48's prediction for ℚ(√3,√7,√11) becomes **7** (`L = 7`); FS-40 closes; item 2 of "what the hunt has
  established" and G44 updated; the kernel instance's hypothesis is discharged by FS-52, not here.
- `⌊N⌋ > 1148` — the row's headline is the table (11: 29, 23: 108, 83: ⌊N⌋) with the bracket `[597, ⌊N⌋]` at 83; the digit
  stays open; FS-40 is re-scoped to "a stronger relaxation or a set", and the honest sentence is recorded.
- Either way: the row lists the three trust levels (`[solver]` the local search and the CDCL/MaxSAT negatives; `[exact-rational]`
  the certificates; `[kernel]` the lemma and the declared instances); rows 53/56 gain the certificates' addresses; G44/G48
  rewritten in place; `plans/FRONTIER-STUBS.md` re-ranked with FS-51/FS-52 added (assert every FS exactly once) and the
  mirror in `CLAUDE.md` § Paths forward; the unpursued-conjecture sweep of the plan (WORKFLOW step 9); `CLAUDE.md` under
  150,000 bytes (`wc -c`; it is at 149,519 — trim as needed, superseded text first); `BIBLIOGRAPHY.md`: Schrijver 2005 and
  Gvozdenović–Laurent 2008 as listings (the advisor's "recalled, not read"); memory updated.
- Kooshi's open decision (card 3): the product as the table (recommended) or the bit at 83 — default the table.

## 3a. 2026-09-15, 02:30 — what happened overnight

The Hermitian-form producers at 83 never converged inside their walls; the real-block value solve (four-hour wall) neither;
and **killing the `timeout` wrappers to lift the walls killed the solver children too** (both producers lost at 7.5 h and
4 h; the implementer's run too, 3 h 51 m, on my untested datum — GNU timeout 9.11 arms `PR_SET_PDEATHSIG` on its child,
tested on `sleep`: no wrapped job can be detached after the fact on this box; never wrap a multi-hour solve). Running now: the implementer's real-form producer (eps 1e-8, a twelve-hour wall it set), and
`tools/fplane_sdp_scs.py --p 83 --eps 1e-5` — the chunked, checkpointed SCS driver (no wall; resume = the same command;
checkpoint `data/fs50/ckpt/scs-p83-real.npz`; log at the job tmp `sdp/s83.log`, one residual line per chunk).

## 4. Traps met today

- `setsid cmd &` records the wrong pid; `timeout` kills without a record — every long tool now writes its record on every
  path (the race script rewritten around the toolchain's `cadical -t`; pysat's CaDiCaL cannot be interrupted).
- Detached shells lack `lean` on PATH; resolve tool binaries from `lean-toolchain`.
- cvxpy canonicalises a chain of scaled sparse terms catastrophically (254 s vs 17 s): build matrices as one linear map.
- A block solve that keeps no dual yields a number, never a certificate — the producer, not the reader, is the tool at 83.
- A control whose test data has zeros where the bug lives passes for hours (the implementer's catch).

## 5. Machine state

`lean-dir` main pushed at 82cc8ec (tree clean but for this file); `~/source/descent-engine` at 8176cb5, pushed. Running: the
producer at 83 only. No subagents. Memory (`hadwiger-nelson-project.md`) current to 18:45.
