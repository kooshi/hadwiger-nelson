# Session handoff — 2026-09-16: FS-54 closed; FS-56 ℚ(√167) next

*For a session with no memory of this one. Current state only; the full record of FS-54 is `plans/FS54-twenty-seven.md`
(its §C is the close). Kooshi compacted after this was written.*

## 1. Where things stand

* **FS-54 twenty-seven is closed** (`CLAUDE.md` row 70, G59). Headline: **α(UD(𝔽₂₇,2)) ≤ 141 by an exact level-3 certificate,
  so five colours are refused at 27**; α ≥ 117 by every method; the 2-adic trichotomy (odd-degree real fields 2-colourable,
  U₆₄ a window member); the wall at six (`reference/wall-at-six/WALL-AT-SIX.md`) answered twice by GPT Astra, verified, five of
  our errors fixed; `[Fischer1990b]` arrived and is read (prior art for multiquadratic prime inversion).
* **Next milestone: FS-56 ℚ(√167)** — Kooshi: "Let's close this out and look at 167 next." **The stub
  `plans/STUB-quadratic-167.md` is the letter**: motivation, every number with its source, what is proved, what is predicted,
  the questions in order (Q0 first), the prior-art gate questions, failure and jackpot clauses. Open it with WORKFLOW step 3
  (subplan) and the step-3a prior-art gate.
* **Second: FS-57 the fractional wall** (`plans/STUB-fractional-wall.md`): 47 and U₆₄ in reach with measured prices.

## 2. What is running

**Nothing.** Stopped or finished, each with its state on disk: the 27 ADMM (checkpoint `data/fs54/d4/ckpt/admm-q27.npz`), the
ladder (complete), both U₆₄ SAT runs (stopped by pid, no verdict), the 47 pricing run (checkpoint
`data/fs54/d4/ckpt/admm-q47-l3.npz` at 340 iterations), every KaMIS run (records in `data/fs54/char2/`). Resume commands are in
`data/fs54/d4/runs/RESUME.md`; the 47 run needs Kooshi's approval (a 2-hour decision point, then 9–23 h projected).

## 3. The first thing FS-56 does

**Q0: the exact five-refusal certificate at 23.** The level-3 calibration iterate `data/fs54/d4/ckpt/calib-q23.npz` (3,500
iterations) reads a certificate-shaped 105.431 < 106. The producer reads that format (the pricing agent's word; untested at 23).
The command used at 27, adapted — copy the checkpoint first, never read the live file:

    cp data/fs54/d4/ckpt/calib-q23.npz data/fs54/d4/ckpt/calib-q23-certcopy.npz
    .venv/bin/python tools/fs54_l3_cert_round.py round --q 23 --ckpt data/fs54/d4/ckpt/calib-q23.npz \
        --snapshot data/fs54/d4/ckpt/calib-q23-certcopy.npz --den 100000000 --jobs 6 --k 5 \
        --out 'data/fs54/cert-q23-l3-N{N}.json' --log 'data/fs54/d4/check-q23-l3-N{N}.log'
    python3 tools/fs54_l3_cert_check.py data/fs54/cert-q23-l3-N<N>.json      # the PO re-runs this

About one CPU-hour. It is the precondition of the ℚ(√167) prediction: without it χ(Γ₂₃) = 5 stays possible.

## 4. Traps met this session (the ones that recur)

* **A wrong acceptance test flattered results twice** (the 2-adic "norm ≤ 4" test; the stub's "worst reach" fact). Audit the
  result you like (G21).
* **A named-but-unread paper on exactly our fields held a theorem we reconstructed** (`[Fischer1990b]`, M56's conjecture).
  At FS-56's gate, read `[Johnson2006]` if it can be had — the last unread compendium of this direction.
* **A misfiled table row passes an audit silently**: ten bibliography rows sat in the alternate-keys table, where the audit
  read them as aliases. Fixed.
* **KaMIS's `weighted_branch_reduce --weight_source=uniform` assigns random weights**, not unit weights; for unweighted MIS
  write METIS format 10 with weight 1 on every vertex.
* **Exact MIS does not reach these graphs**: branch-and-reduce sat at 70 on UD(𝔽₁₉,2) for 600 s (heuristics find 76).
* `scripts/dev-env.sh`'s `LIBRARY_PATH` breaks non-Lean C/C++ links (`env -u LIBRARY_PATH`); OR-Tools and cvxpy clash over
  `libhighs.so.1` — `data/fs54/environment.md`.
* Machine: desktop, Python 3.14; `.venv` has pynauty, ortools, numba, cvxpy, scipy; KaMIS at `~/source/KaMIS/deploy/`; the
  third GPU is not on the PCI bus (card A `GPU-UUID-REMOVED` and card B
  `GPU-UUID-REMOVED`, pinned by UUID).
