# FS-81 phase 0 — exact three-colour (`Θ₃`) certificates over the open real quadratic fields

*Implementer: de Bruijn (Opus 5.5), 2026-09-24, desktop (16 physical cores / 32 threads, 128 GB).
Brief: the product owner's phase-0 brief (scratch copy; its content is summarised in §0). Milestone stub:
`plans/STUB-quadratic-four-colour-classification.md`. Data: `data/fs81/phase0/`. This record is written as the phase runs.*

## 0. What this phase does

T4 (G61) says every squarefree `d ≡ 11 (mod 12)` has `χ(ℚ(√d)²) ≥ 4`. The census (`data/fs61/census.md`) certified 15 of the 40
such `d` below 500; 25 are open. FS-73's criterion (T22: `Cay(Λ, ±S)` is 3-colourable iff some `θ ∈ Hom(Λ, ℝ)` has
`θ(s) mod 1 ∈ [1/3, 2/3]` on every `s ∈ S`) turns "is this lattice graph 3-colourable?" into an exact polytope question with a
checkable certificate. An EMPTY certificate on an explicit set of unit vectors of `ℚ(√d)²` proves `χ(ℚ(√d)²) ≥ 4`
(**[cert + hand]**: the certificate by a frozen checker, the ⟹ direction of T22 by hand, derived twice at FS-73).
A NONEMPTY verdict is a typed null for that configuration only, never a 3-colouring of the field's plane.

## 1. Predictions (registered before any run)

Registered 2026-09-24T13:12+00:00, before any tree was run on any lattice in this phase. `n = (d+1)/4`,
`v = ((2n−1) + i√d)/(2n)` (G7's type-M rotation), `U^(5)` the 12 rational unit vectors with denominator dividing 5.

| id | prediction | probability | outcome |
|---|---|---|---|
| PL-1 (planner) | the K = 1 configurations are EMPTY for the small-n fields (d ≤ 47) but NONEMPTY for most d ≥ 200 | 0.60 | |
| PL-2 (planner) | `V(d, K)` is EMPTY at the K where 5^K > 2.1n | 0.70 | |
| PL-3 (planner) | the T41 shape `{1, v, z}·U^(5)` at ℚ(√47) is EMPTY | 0.55 | |
| DB-1 | `{1, v, v̄}·U^(5)` is NONEMPTY at every census d ≥ 100 | 0.75 | |
| DB-2 | `{1, v, v̄}·U^(5)` is EMPTY at d = 11 | 0.50 | |
| DB-3 | `{vᵏ : \|k\| ≤ 2}·U^(5)` is EMPTY at some census d ≥ 100 | 0.35 | |
| DB-4 | at ℚ(√47), at least one of the two T41 variants (`z` and `z̄`) is EMPTY | 0.65 | |
| DB-5 | at least one of the 25 open fields is landed by a K = 1 configuration (P0.2) | 0.45 | |
| DB-6 | at the phase's end at least 5 of the 25 open fields have a certified EMPTY | 0.50 | |
| DB-7 | where `V(d, K)` is run, it is EMPTY at the first K with 5^K > 2.1n for a majority of those fields | 0.45 | |
| DB-8 | every control returns its known outcome (positives EMPTY, negatives NONEMPTY) on the first pipeline that runs them | 0.90 | |

Known before any run, from FS-73's record (not predictions): at d = 167 `{1, v, z}·U^(5)` is EMPTY and `{1, v, v̄}·U^(5)` is
NONEMPTY (T41: of the ten 3-subsets of `{1, v, v̄, z, z̄}` only `{1, v, z}` and `{1, v̄, z̄}` are empty).

## 2. Tools, checkpoints and the resume commands (written before the first long launch)

- `tools/fs81_theta.py` — V2's relation tree (`tools/fs73v2_xbb.py`, imported, not edited) on **listed** unit vectors, driven
  iteratively; the stack of branch nodes under construction (with every finished child) is saved atomically every 60 s to
  `data/fs81/phase0/ckpt/<tag>.json.stack` beside the static part `<tag>.json` (units, relation basis, pool); a cumulative wall cap
  turns an unfinished tree into an UNDECIDED record. Tested: a ℚ(√11) tree capped at 8 s and relaunched resumed at 4,363 nodes
  and finished at 14,478 nodes, exactly V2's count, and the frozen checker passed the result.
- `tools/fs81_p0.py` — the driver. One fsync'd JSON line per item in `data/fs81/phase0/<stage>.jsonl`; certificates gzipped under
  `data/fs81/phase0/certs/`; each verdict handed at once to the frozen `tools/fs73v2_check.py` when its enumeration is affordable
  (4.2·D³/d ≤ 1.5·10⁹ loop iterations), otherwise to `tools/fs81_theta_check.py --no-enumerate`.
- **If a run dies at any instant**, the relaunch skips every recorded item and resumes the in-flight tree from its last save: it
  redoes at most 60 s of tree plus that item's checker run. The checkpoints live under `data/fs81/`, outside `build/`.
- **Resume commands** (each under the heavy lock; the same command resumes):

```
L=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock
flock -w 1800 $L python3 tools/fs81_p0.py controls --cap-s 1800          # P0.0
flock -w 1800 $L python3 tools/fs81_p0.py configs  --cap-s 1800          # P0.2, all 40 census fields, K = 1
```
