# Session handoff — 2026-09-16, ~11:00 (de Bruijn; FS-54 twenty-seven, mid-milestone)

You arrive with no conversation memory. Record of record: `CLAUDE.md` § Frontier / § Grokkings (G56, G57 rewritten today);
the milestone plan `plans/FS54-twenty-seven.md` (§1 findings, §M domain model, §O obligations, §PA prior art, §D
deliverables with scores); `data/fs54/README.md` (every file and its claim). **Kooshi is about to give feedback on
`reference/wall-at-six/WALL-AT-SIX.md`** — the outward request for help written this session; read it before replying.

## 1. What FS-54 has established (all committed, each with its script)

**About 27** (`tools/fs54_structure.py` → `data/fs54/structure.out`):
* every edge lies in exactly one triangle, a collinear 𝔽₃-line {z, z+u, z+2u}; the 14 unit directions are a cap in PG(5,3);
* spectrum 28¹ 10²⁸ 7⁸⁴ 4¹⁶⁸ 1⁸⁴ −2¹⁶⁸ −5⁸⁴ −8¹¹²; λ_a = 3m_a − 14 ≡ 1 (mod 3), Weil forbids −11, so λ_min = −8
  (integrality is Bridges–Mena; the eigenvalues are Frobenius traces of y² = x³ + x² − a, Moisio, verified on 26 curves);
* |Aut| = 122,472 (nauty) — nothing hidden;
* **α(27) ≥ 117 and every method stops there**: exhaustive subspace-periodic 81/108/117 (SAT cross-checked, 461 orbits);
  KaMIS 117 on 7 seeds, all 9-periodic; CP-SAT per prime-order symmetry class ≤ 117 (order 7: 106 optimal);
  the calibrated Rust ladder (`data/fs54/ladder/`) free 117, rotation orders 2/4/7/14/28 → 117/117/106/99/85, line 81;
  **all fourteen 117-sets are 4-rigid** (every outside vertex has ≥ 4 neighbours inside). Six needs 122.
* **Upper side**: GLV level-3 relaxation (orbits of independent ≤ 4-sets, 77,238 variables) reads 143.055 at 8,000
  iterations and **141.6 / 142.9 (upper/lower readings) at 15,619** — below the 146 that refusing five needs. Floats only.

**Fields** (`tools/fs54_fields.gp`, `tools/fs54_quadratic_fields.gp`):
* **Primes above 2 in F(i)/F**: split → no bound; **ramified → χ(F²) ≤ 2 at any norm**; inert → Cay(𝔽_{Q²}, μ_{Q+1}).
  **Every odd-degree real field is 2-colourable.** (Today's first two field answers — the conductor-13 cubic for 27, a
  quartic for 31 — were wrong on this point and are corrected everywhere, with correction records.)
* Smallest fields seeing each member first with the wall broken: 23 → ℚ(√167), 31 → ℚ(√1055), 43 → ℚ(√4703),
  47 → ℚ(√2351); 27 needs even degree ≥ 6 (smallest found: disc-316 cubic x³+2x²−3x−2 joined with √79).
* 16 real quadratic fields (d ≤ 30,000) have local bound ≥ 6, every one decided by the planes at 43 and/or 47 — both
  implausible on the evidence, so these fields are most likely ≥ 7.
* G57's "√3 ∈ F iff usable planes have triangles" demoted to the direction that holds (ℚ has no √3; its plane at 11 has
  triangles).

**The 2-adic targets** (`data/fs54/char2/`): U_Q = Cay(𝔽_{Q²}, μ_{Q+1}) is 4-colourable at Q = 2…32; **U₆₄ has Hoffman
floor 6 (λ_min = −15) and a linear 8-colouring — a sixth window member, in characteristic 2**, realised only by fields of
degree ≥ 12; U₁₂₈ has floor 8.

**The wall**, `reference/wall-at-six/WALL-AT-SIX.md`: no residue target (odd planes, 2-adic graphs) is known to be
six-chromatic; proofs below 23 and above 47; window {23, 27, 31, 43, 47} ∪ {U₆₄}; escape hatches not covered (composite
ideals = categorical products, where Hedetniemi is open at 5–7; tower levels); six questions asked.

## 2. What is running (all checkpointed or short)

| job | pid / pgid | where | what to do with it |
|---|---|---|---|
| level-3 ADMM at 27 toward convergence | pid **550586** | log `data/fs54/d4/runs/admm-q27-converge.log`, checkpoint `data/fs54/d4/ckpt/admm-q27.npz` (atomic), out `data/fs54/d4/runs/admm-q27.json` | resume line in `data/fs54/d4/runs/RESUME.md` (no `--new`); the certificate agent rounds from a copy |
| the ladder at 27, last stage free-s2 | snapshot shell pgid **524993** (child plane-independent) | `data/fs54/ladder/` (`<stage>.done` markers) | relaunch skips finished stages (`data/fs54/ladder/RESUME.md`); score **P8** (plateau at 117) when `LADDER COMPLETE` appears in `ladder.out` |
| SAT on U₆₄, k = 7 and k = 6, 20 M conflicts each | pids **468640** (k=7), **468642** (k=6) | logs in the SESSION SCRATCHPAD `…/scratchpad/q27/g64-k7.log`, `g64-k6.log` (ephemeral!); colouring saved there as `g64-col-k{k}.npy` if SAT | if a pid is gone and its log is lost, rerun `python3 tools/fs54_char2_q64_sat.py <k> 20000000` from lean-dir (writes into `data/fs54/char2/`); record the verdict in `data/fs54/char2/README.md` |
| **certificate agent** (background subagent) | — | brief: exact rational certificate for level 3 at 27, standard-library checker, `plans/FS54-L3-certificate-soundness.md`, controls at 7 and 11 with four plants; files `tools/fs54_l3_cert_{round,check}.py`, certs in `data/fs54/` | on its report: re-run its checker yourself, open the certificate, score **P9** ([138, 146]; refuses five with p = 0.35); if ⌊N⌋ ≤ 145 — row-worthy: χ(Γ₂₇) ≥ 6 |

## 3. Next, ranked
1. **Receive the certificate** (above). If five is refused at 27: update the wall document, window.md (27's floor 6), G56.
2. **Level 3 at 47** — refusing six there needs only 0.76 % below the converged 371.84, which **takes 47 out of the window**;
   priced at ~4 M variables (`plans/FS54-D4-pricing.md` §8); check memory first. Then 23 (five refused if N < 106).
3. **U₆₄**: its six/seven question (SAT above; a triple-level SDP could refuse six — Hoffman 768 against 683).
4. **D5** at 27: colour search seeded from structure (D97: `plane-colour` cannot find even 7 or 8 colours from random starts
   at 27), and the antipodal quotient.
5. **The composite-ideal escape hatch** (wall §6.3): χ of a categorical product of two ≥ 7 planes — unmeasured.
6. Close FS-54: ledger row, G59 (characteristic 3 and the 2-adic trichotomy), FRONTIER re-rank, conjecture sweep of the plan.

## 4. Traps met this session
* **A wrong acceptance test flattered the result twice** (the 2-adic "norm ≤ 4" test; the stub's "worst reach" fact
  omitting 43). Audit the result you like (G21).
* **The reboot wiped `/tmp`** — the scratchpad is not storage; everything durable is in `data/` and `tools/`.
* `scripts/dev-env.sh`'s `LIBRARY_PATH` breaks non-Lean C/C++ links (use `env -u LIBRARY_PATH`); OR-Tools and cvxpy clash
  over `libhighs.so.1` (highspy pinned 1.12.0) — `data/fs54/environment.md`.
* An exp-table 𝔽_{2^m} build gave a spurious λ_min = −129 at Q = 128; the carry-less rebuild is authoritative.
* Machine: desktop, Python 3.14.7, the 3rd GPU is not on the PCI bus (only graphics cards A and B); `.venv` has pynauty,
  ortools, numba, cvxpy; KaMIS at `~/source/KaMIS`; GAP needs `GRAPE_DREADNAUT_EXE := "/usr/bin/dreadnaut";`.
