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
flock -w 1800 $L python3 tools/fs81_p0.py configs  --cap-s 1800 --fields 35,83,107,131,155,179,203,215,227,251,263,287,299,323,347,371,383,395,407,419,443,455,467,479,491,11,23,47,59,71,95,119,143,167,191,239,311,335,359,431   # P0.2: the 25 open fields first, then the 15 certified (controls)
```

## 3. P0.1 — the rational layer, exactly (a measurement of a finite shadow)

`tools/fs81_rational.py 6 --out data/fs81/phase0/rational` (0.1 s; exact Fractions; closed half-plane clipping keeps degenerate
cells). `U^(5^K)` spans `(1/5^K)ℤ[i]`; θ on it is `μ = (θ(1), θ(i))`, and its rotation set `Θ_K` has period `5^K ℤ²`. Lifting:
`Θ_K ⊆ Θ_(K−1)`, so the 25 translates of each level-(K−1) cell are clipped by the four new direction pairs. Every vertex of every
cell is re-checked against all directions of its level.

| K | period | direction pairs | cells per period | the polygon | its area | the points |
|---|---|---|---|---|---|---|
| 1 | 5 | 6 | 1 polygon + 4 points | 12-gon centred (5/2, 5/2) | 17/189 ≈ 0.08995 | (5/3)·(1 or 2, 1 or 2) |
| 2 | 25 | 10 | 1 polygon + 4 points | 20-gon centred (25/2, 25/2) | 61/693 ≈ 0.08802 | (25/3)·(1 or 2, 1 or 2) |
| 3 | 125 | 14 | 1 polygon + 4 points | 28-gon centred (125/2, 125/2) | 437/4977 ≈ 0.08780 | (125/3)·(1 or 2, 1 or 2) |
| 4 | 625 | 18 | 1 polygon + 4 points | 36-gon | ≈ 0.08768 | order 3 |
| 5 | 3,125 | 22 | 1 polygon + 4 points | 44-gon | ≈ 0.08755 | order 3 |
| 6 | 15,625 | 26 | 1 polygon + 4 points | 52-gon | ≈ 0.08746 | order 3 |

**Reading (measured at K ≤ 6, not proved for all K):** `Θ_K = (5^K/2)(1,1) + (D_K ∪ F_K) + 5^K ℤ²`, where
`D_K = {δ : |⟨δ, x⟩| ≤ 1/6 for every x ∈ U^(5^K)}` is a `4(2K+1)`-gon (one edge pair per direction pair) shrinking to the disc of
radius 1/6 (area π/36 ≈ 0.087266), and `F_K` is four isolated points of order 3: `θ(1), θ(i) ∈ {5^K/3, 2·5^K/3}` mod `5^K`,
the additive `𝔽₃`-colourings `(p + iq)/5^K ↦ pa + qb (mod 3)`. At the polygon's centre `θ(x) ≡ 1/2` on every unit vector (the
bipartite point: `p + q` is odd whenever `p² + q² = 25^K`). K = 1 reproduces FS73-T40's `Θ_R`. The fraction of the torus in `Θ_K`
falls like `25^(−K)`: each level keeps exactly one of the 25 lifts of the polygon. Data: `data/fs81/phase0/rational/rational-layer-K{1..6}.json`.

## 4. P0.0 — controls, both sides, before any null is read

`python3 tools/fs81_p0.py controls --cap-s 1800` (records `data/fs81/phase0/controls.jsonl`, certificates
`data/fs81/phase0/certs/ctl-*.json.gz`). Every lattice ran twice: through **the tree alone** (the pipeline that produces every EMPTY
certificate; capped at 300 s on negatives) and through **the small-order screen, then the tree** (the pipeline P0.2 uses; the screen
tries every θ of order 3, 6, 9 or 12 on the Hermite basis — a finder only, its θ checked like any other). Every verdict went to the
frozen `tools/fs73v2_check.py`, all key denominators here being small enough for its enumeration.

| control | lattice | pairs | tree alone | screen, then tree | frozen checker |
|---|---|---|---|---|---|
| positive, d = 167 (7 mod 8) | T41's `{1, v, z}·U^(5)`, z at (a, c) = (15, 14) | 18 | EMPTY, 1,587 nodes, 2.5 s | EMPTY | PASS (the complete unit set of its span) |
| positive, d = 47 (7 mod 8) | Coxeter's `cert_47` lattice `60\|5,1,5,3;…` | 14 | EMPTY, 537 nodes | EMPTY | PASS; `certcheck.py cert_47.json` also OK |
| positive, d = 11 (3 mod 8) | E's `Ld65c8ee8` | 54 | EMPTY, 14,478 nodes (V2's count exactly) | EMPTY | PASS |
| positive, d = 59 (3 mod 8) | **new:** the 23 edge-direction pairs of the certified ℚ(√59) witness (D = 90) | 23 | EMPTY, 8,106 nodes, 13 s | EMPTY | PASS |
| negative, d = 59 | `Ld65c8ee8` over ℚ(√59) | 18 | point, 1,077 nodes | point of order 9 | PASS NONEMPTY (all 36 unit vectors) |
| negative, d = 167 | `Ld14c588b` | 22 | point, 1,189 nodes | point (tree) | PASS NONEMPTY (all 44) |
| negative, d = 3 | every distinct rank-4 `Λ_M`, M ≤ 60 (16 lattices, 6–54 pairs) | | 15 points; **`Λ₂₆` UNDECIDED at 312 s, 171,657 nodes** | 16 points, all of order 3 | PASS on all 31 certificates |
| negative, d = 7 | every distinct rank-4 `Λ_M`, M ≤ 60 (15 lattices, 6–54 pairs) | | 15 points | 15 points, all of order 3 | PASS on all 30 |

**Verdict: the controls pass, on both sides, through the pipeline P0.2 uses** — every positive EMPTY and every negative NONEMPTY,
each certified by the frozen checker. **The tree alone is a weak finder of isolated points:** on `Λ₂₆` over ℚ(√3) (54 pairs) it
searched 171,657 nodes in 312 s without landing on the order-3 point the screen finds in 3 ms. This is why the screen runs before
every tree: a NONEMPTY configuration whose points are isolated and of small order would otherwise cost a 30-minute cap and come back
UNDECIDED. Isolated points of order beyond 12 are still found only by the tree (G21: a finder measures its search order).
**Checker parity:** `tools/fs81_theta_check.py` in its default mode printed the same line as the frozen checker on all 73 control
certificates.

## 5. P0.2 — the K = 1 configurations over the 40 census fields

**The configurations.** `n = (d+1)/4`, `v = ((2n−1) + i√d)/(2n)`. A = `{1, v, v̄}·U^(5)`; B = `{vᵏ : |k| ≤ 2}·U^(5)`;
C = `{1, v, z}·U^(5)` with `z = (1+i)(a − s·i√d)/(2c)`, `a² + d = 2c²`; D = `{1, v, z₅}·U^(5)` with `z₅ = (2+i)(a − s·i√d)/(5c)`,
`a² + d = 5c²`. **The (a, c) is not unique** (the brief's form is right, the spec must name the solution): at d = 167 the smallest
solution of `a² + 167 = 2c²` is (11, 12), and T40's z is (15, 14). P0.2 runs the two smallest (a, c) at each field, each with
both signs s = ±. C exists only at d ≡ 7 (mod 8) (a² + d = 2c² forces it), D wherever −d is a square mod 5 and the norm equation
is solvable (131, 155, 179, 251, 395, 419, 479, 491 among the open fields; the brief's "d ≡ 3 (mod 8)" is not required).

**Saturation (added, approved by the owner):** a configuration's span can hold unit vectors it does not list. At d = 167,
span A is L21cc6506's lattice, whose Θ is empty, while A's own 18 pairs are 3-colourable. So for every NONEMPTY configuration with
D ≤ 5,000, the driver enumerates every unit vector of the span (O(D²)); if the configuration's θ fails on one, the saturation gets
its own tree (`…-sat`). An EMPTY saturation proves `χ(ℚ(√d)²) ≥ 4` at the same grade (FS73-T11: a refusal on a subgraph carries
up). In every table below a saturation is its own object.

**Orbits (the modeling agent's §B.1.10, adopted at the owner's request, 2026-09-24).** Θ₃ is equivariant under multiplication by a
unit vector, complex conjugation and `√d ↦ −√d`. Computed: complex conjugation and the Galois map send C(s = +) to the same set,
`{1, v̄, z̄}·U^(5)`, which is neither C(+) nor C(−); likewise for D. So the two signs are the two orbits (T41's `{1, v, z}` and
`{1, v, z̄}`), and **the orbit keying removed no item from P0.2's list**: it held one representative per orbit already. **The free
control:** each orbit run both ways must agree. At d = 167: C(15, 14, +) EMPTY and its conjugate EMPTY (1,587 and 1,584 nodes,
frozen PASS); C(15, 14, −) NONEMPTY and its conjugate NONEMPTY. At d = 47: C(5, 6, ±) and their conjugates all NONEMPTY.
Records: `data/fs81/phase0/orbits.jsonl`.

**An int64 overflow stopped the first launch** at d = 83's saturated B (the screen's Hermite coordinates exceed int64 at D = 4,410);
a Python exception, not a process crash; fixed by reducing the coordinates mod lcm(3, 6, 9, 12) first (commit `a7fa50e5`), and the
relaunch resumed past the recorded items.
