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
ideals = categorical products; tower levels); six questions asked. **Two responses came back the same day** (verbatim in
`reference/wall-at-six/responses/`, verified in `plans/FS54-twenty-seven.md` §R): the fractional wall W_f (α < Q²/6 at the six
open targets proves W and closes the product hatch), five errors in our text (all confirmed, all fixed), U₃₂'s rigidity,
λ ≡ 1 mod 4 at 64, the inert-tower Hoffman invariance.

## 2. What is running (all checkpointed or short) — updated 11:30 after the wall document's two responses

| job | pid / pgid | where | what to do with it |
|---|---|---|---|
| level-3 ADMM at 27 | **stopped by pid 11:22** at ~25,671 its (certificate already filed; a lower N decides nothing) | checkpoint `data/fs54/d4/ckpt/admm-q27.npz` (sha256 `ab277ec9…`) | resume line in `data/fs54/d4/runs/RESUME.md` only if a tighter certificate is ever wanted |
| the ladder at 27 | **COMPLETE** 10:57 — every stage ≤ 117; **P8 WON** | `data/fs54/ladder/` | nothing |
| SAT on U₆₄, k = 7 and k = 6, 20 M conflicts each | pids **468640** (k=7), **468642** (k=6) | logs in the SESSION SCRATCHPAD `…/scratchpad/q27/g64-k7.log`, `g64-k6.log` (ephemeral; the script prints only at the end) | if a pid is gone and its log is lost, rerun `python3 tools/fs54_char2_q64_sat.py <k> 20000000` from lean-dir (writes into `data/fs54/char2/`); record in `data/fs54/char2/README.md`. Note (second response): a 6- or 7-colouring cannot be periodic under a subspace of dimension ≥ 8 |
| **certificate agent** | **DONE** — `bacf4a4`: **α(27) ≤ 141 CERTIFIED** (re-run by the PO), **P9 WON**; α(7) = 14, α(11) = 28 certified | `data/fs54/cert-q27-l3-N141.json`, `plans/FS54-L3-certificate-soundness.md` | an independent read of the checker (not a re-run) is owed before any claim beyond the wall document |
| **literature agent** | **DONE** — every cited theorem holds as used; Hedetniemi settled (holds ≤ 3, fails ≥ 4); `[Tardif2022]` → `[Tardif2023]` (wrong arXiv id); MMST1998 gives the tower theorem for odd primes only; the Zetterberg coset-graph name | BIBLIOGRAPHY § A/§ C, the wall document §6.3/§8/§C, plan §R | nothing |
| **47 pricing agent** (background) | — | measured price of level 3 at q = 47 (build, controls, s/iteration, projection to N < 369); must NOT launch the long solve | on its report: decide with Kooshi whether to commit the machine to the solve |

## 3. Next, ranked
1. **Level 3 at 47** once priced — α ≤ 368 refuses six, proves W_f at 47, takes 47 out of the window.
2. **23** at level 3 (five refused if N < 106, 2.35 %).
3. **U₆₄**: SAT above; the second response's stability idea (near-Hoffman-equality ⟹ near-hyperplane structure) as a
   route to α(U₆₄) < 683; a triple-level SDP at U₆₄.
4. **D5** at 27: colour search seeded from structure; the antipodal quotient. 27's question is now exactly six vs seven.
5. Close FS-54: ledger row 70 (five refused at 27; the 2-adic trichotomy; W_f and the escape hatches closed to integrality
   gaps), G59, FRONTIER re-rank, conjecture sweep of the plan.

## 4. Traps met this session
* **A wrong acceptance test flattered the result twice** (the 2-adic "norm ≤ 4" test; the stub's "worst reach" fact
  omitting 43). Audit the result you like (G21).
* **A misfiled table row passes an audit silently**: ten bibliography rows went into the alternate-keys table (§ A′), whose
  second column the audit reads as a canonical key, so every key "resolved". Moved to § A on 2026-09-16.
* **The reboot wiped `/tmp`** — the scratchpad is not storage; everything durable is in `data/` and `tools/`.
* `scripts/dev-env.sh`'s `LIBRARY_PATH` breaks non-Lean C/C++ links (use `env -u LIBRARY_PATH`); OR-Tools and cvxpy clash
  over `libhighs.so.1` (highspy pinned 1.12.0) — `data/fs54/environment.md`.
* An exp-table 𝔽_{2^m} build gave a spurious λ_min = −129 at Q = 128; the carry-less rebuild is authoritative.
* Machine: desktop, Python 3.14.7, the 3rd GPU is not on the PCI bus (only graphics cards A and B); `.venv` has pynauty,
  ortools, numba, cvxpy; KaMIS at `~/source/KaMIS`; GAP needs `GRAPE_DREADNAUT_EXE := "/usr/bin/dreadnaut";`.
