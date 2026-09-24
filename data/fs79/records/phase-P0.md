# FS-79 phase 0 — ℚ(√167)'s lattices at four colours: which could need five, and what a direct refusal would cost

*Implementer (de Bruijn standard, Opus 5.5), 2026-09-23, desktop (16 physical cores / 32 threads, 128 GB).
Brief: `data/fs79/briefs/P0-implementer-brief.md`; spec: §S.P0 of `plans/FS79-invariant-question.md` (the planner's), with the
owner's five additions. Tool: `tools/fs79_p0.py` (driver), `tools/fs79_p0_check.py` (standalone checker, standard library only).
Data: `data/fs79/phase0/`.*

## Predictions (registered before any run: 2026-09-24T01:32+00:00, in the commit that first adds this file)

The implementer's own, each with a probability.

| id | prediction | probability |
|---|---|---|
| I-1 | `L21cc6506` (= Λ₄₂₀) is four-colourable by a periodic colouring found in P0.3 (any screen: Θ₄ point, residue target, additive, quotient, circular) | 0.85 |
| I-2 | the smallest candidate `M` in P0.2 (every residue set at both primes above 23 and both above 43 refuses four; not 3-colourable) is at most 2,520; point estimate `M = 1260` | 0.50 (a candidate exists with `M ≤ 30,240`: 0.75) |
| I-3 | some survivor's degree-18 ball is under 5·10⁶ points (so P0.5 runs) | 0.25 |
| I-4 | at four colours the smallest refusing residue set on the 24-point circle mod 23 has at least 7 antipodal pairs | 0.60 |

The planner's, registered in the plan: P0-a `L21cc6506` has a periodic four-colouring found by P0.3 (0.75); P0-b at least one
candidate Λ_M with M ≤ 30,240 exists (0.6); P0-c the cheapest survivor's degree-18 ball exceeds 5·10⁶ points, so P0.5 is not run
(0.65).

*(Results, theorems and the acceptance table follow when the runs land.)*
