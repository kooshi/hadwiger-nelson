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
| PL-1 (planner) | the K = 1 configurations are EMPTY for the small-n fields (d ≤ 47) but NONEMPTY for most d ≥ 200 | 0.60 | **lost** on its first clause: at K = 1 no listed configuration is EMPTY at 35 or 47 (A, B NONEMPTY; C at 47 NONEMPTY); 11 (B) and 23 (C) are. The second clause holds (no listed configuration EMPTY at any d ≥ 200); the verifier decided it by theorem too (inventory item 65) |
| PL-2 (planner) | `V(d, K)` is EMPTY at the K where 5^K > 2.1n | 0.70 | **won** at every d (T8: the true threshold is d < 21·5^(K−1), about 5^K > 0.95n, so 2.1n is past it); P0.3 certified B at K_B at all 40 fields |
| PL-3 (planner) | the T41 shape `{1, v, z}·U^(5)` at ℚ(√47) is EMPTY | 0.55 | **lost**: NONEMPTY at both (a, c) = (5, 6), (9, 8), both signs, each certified (orbit control included) |
| DB-1 | `{1, v, v̄}·U^(5)` is NONEMPTY at every census d ≥ 100 | 0.75 | **won** (NONEMPTY at all 40 census d) |
| DB-2 | `{1, v, v̄}·U^(5)` is EMPTY at d = 11 | 0.50 | **lost** (NONEMPTY; the verifier's §4.0 at d ≡ 11 mod 24) |
| DB-3 | `{vᵏ : \|k\| ≤ 2}·U^(5)` is EMPTY at some census d ≥ 100 | 0.35 | **lost** (at K = 1 B is EMPTY only at d = 11: T8's d < 21) |
| DB-4 | at ℚ(√47), at least one of the two T41 variants (`z` and `z̄`) is EMPTY | 0.65 | **lost** (all four NONEMPTY) |
| DB-5 | at least one of the 25 open fields is landed by a K = 1 configuration (P0.2) | 0.45 | **lost** as registered (no listed K = 1 configuration is EMPTY at an open field); P0.2 landed 11 open fields only through **saturations** of K = 1 configurations, an object added after registration — reported, not counted as a win |
| DB-6 | at the phase's end at least 5 of the 25 open fields have a certified EMPTY | 0.50 | **won**: 25 of 25 (P0.3), 11 of them twice |
| DB-7 | where `V(d, K)` is run, it is EMPTY at the first K with 5^K > 2.1n for a majority of those fields | 0.45 | **won** (at every field; T8) |
| DB-8 | every control returns its known outcome (positives EMPTY, negatives NONEMPTY) on the first pipeline that runs them | 0.90 | **lost**: the tree alone left Λ₂₆ over ℚ(√3) UNDECIDED at 312 s; the screen-then-tree pipeline returned every known outcome |

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

**Mid-run changes (each at a clean boundary; no finished item re-run).**
- *The verifier's theorem (stage C §4.0, [hand]):* A's listed configuration is NONEMPTY at every K for d ≡ 11 (mod 24). There A now
  gets the small-order screen only, never tree time; a row whose screen misses reads "UNDECIDED; nonempty by theorem"; any certified
  EMPTY on A's listed configuration at d ≡ 11 (mod 24) stops the driver (it would contradict a derived claim). A's rows carry d mod 24.
  Saturations are outside the theorem and still run.
- *The experience pass (plan §B.3.1–§B.3.2).* **Adopted:** every PASS line of `tools/fs81_theta_check.py` now names d, the
  certificate file's sha256 (16 hex) and the conclusion with its grade ("… not 3-colourable: χ(ℚ(√d)²) ≥ 4 [cert + hand: FS73-T22 ⟹]";
  NONEMPTY lines end "a typed null for the field, never a colouring of the plane"), and counts in one unit ("M vectors = M/2 pairs");
  the table has the header sentence ("only an `E` cell speaks about the field"), the column "χ ≥ 4 certified by", and the words
  "listed configuration" / "saturation". The self-test (10 EMPTY plants per mode, 9 NONEMPTY) and both coverage mutants were re-run
  after the change: the shipped checker passes, each mutant fails. **Declined:** rewording the `--no-enumerate` parenthesis — the
  explanation is appended after it instead, so every earlier record's `check_line` stays an exact prefix of the new line.
- *Saturation trees are capped at 600 s in P0.2* (the configurations keep the brief's 30 min): the saturation step is an addition to
  the brief and must fit its one-day budget. The first 54-pair saturation (d = 83, B, D = 4,410) ran its full 30 min: UNDECIDED at
  653,274 nodes, its checkpoint kept (`data/fs81/phase0/ckpt/d83-B-K1-sat.json*`) for a later resume.

## 6. P0.3 — B at the verifier's threshold (T8: B at level K is EMPTY iff d < 21·5^(K−1))

P0.2 is paused (15 records; resumable by its command in §2) so that P0.3, predicted decisive for every open field, runs first; the
owner asked for the node counts at the first two fields before the day is committed. Targets: B = `{vᵏ : |k| ≤ 2}·U^(5^K)` at
`K_B(d)`, the least K with `d < 21·5^(K−1)`: K = 2 at d = 35, 83 (50 pairs; D = 4,050 and 22,050); K = 3 at the other 23 open
fields (70 pairs; D from 182,250 to 3,782,250). Certification by `tools/fs81_theta_check.py --no-enumerate` (the frozen checker's
enumeration would cost 8·10⁹ loop iterations already at d = 35).

```
flock -w 1800 $L python3 tools/fs81_p0.py configs --stage p03 --no-saturate --cap-s 1800 --names B --K 2 --fields 35,83
flock -w 1800 $L python3 tools/fs81_p0.py configs --stage p03 --no-saturate --cap-s 1800 --names B --K 3 --fields <the other 23>
```

**The structural route (chosen for P0.3; the relation tree kept as a secondary, independent route).** The relation tree on B at
K = 2, d = 35 (50 pairs) had searched 695,570 nodes in 1,440 s without a verdict. The verifier's T8 mechanism gives a certificate
whose size does not grow with n: `tools/fs81_struct.py` (generator) and `tools/fs81_struct_check.py` (standalone checker,
standard library only). The reduction, stated in both files' docstrings: μ_k = (θ(vᵏ), θ(ivᵏ)) satisfies n Δ²μ_k + μ_k = 0;
μ_k ∈ Θ_K ⊆ c + (P ∪ F) + 5^K ℤ² (the rational layer, P0.1, which the checker re-proves by induction on the level at the given K);
writing μ_k = c + 5^K m_k + δ_k forces L_k(δ) = n Δ²δ_k + δ_k ∈ 5^K(ℤ + ½)² for k = −1, 0, 1; the checker re-enumerates all
3,125 assignments of δ-types (the polygon P or one of the four order-3 points) and every half-integer target meeting L_k's exact
interval range, and demands a checked Farkas vector for each surviving combination. Hand steps: R2 (ℚ-linearity and the recurrence)
and R4's algebra, plus T22's ⟹; grade [cert + hand]. The checker's own self-test: 8 plants (a case dropped, a multiplier doubled or
negated, the equality multipliers zeroed, a field past the threshold, a level too low, d ≢ 3 mod 4, and R3 run without the
order-3 points, which must fail because they are real points of Θ_K). **The owner's plant passed** (Farkas vectors swapped between two cases, 10 random swaps in each of `d83-B-K2.json` and `d491-B-K3.json`: all 20 refused), and a mutant whose target enumeration skips the lowest half-integer target fails this self-test; the owner re-derived R2 and R4 by hand.
The generator reports a missing exact Farkas vector as an error, never as "feasible"; at the other side of the threshold
(K_B − 1) it stops at the first feasible case.

Launch (the new resource rule: RAM rationed by `scripts/slot.py`, threads not; light, one core):
```
scripts/slot.py --mem 2 --cpus 1 --name fs81-p03-struct -- python3 tools/fs81_struct.py sweep 35,83,107,131,155,179,203,215,227,251,263,287,299,323,347,371,383,395,407,419,443,455,467,479,491,11,23,47,59,71,95,119,143,167,191,239,311,335,359,431 data/fs81/phase0/p03-struct.jsonl data/fs81/phase0/struct
```
(resumable: recorded (d, K) pairs are skipped; each item is seconds.)

**P0.2 resumed under the new resource rule (2026-09-24), in six disjoint field groups, each its own stage file; each command resumes itself:**
```
scripts/slot.py --mem 3 --cpus 1 --name fs81-configs -- python3 tools/fs81_p0.py configs --cap-s 1800 --stage configs --fields 131,155,179,203,215
scripts/slot.py --mem 3 --cpus 1 --name fs81-configs-g6 -- python3 tools/fs81_p0.py configs --cap-s 1800 --stage configs-g6 --fields 95,119,143,167,191,239,311,335,359,431
scripts/slot.py --mem 3 --cpus 1 --name fs81-configs-g4 -- python3 tools/fs81_p0.py configs --cap-s 1800 --stage configs-g4 --fields 407,419,443,455,467
scripts/slot.py --mem 3 --cpus 1 --name fs81-configs-g5 -- python3 tools/fs81_p0.py configs --cap-s 1800 --stage configs-g5 --fields 479,491,11,23,47,59,71
scripts/slot.py --mem 3 --cpus 1 --name fs81-configs-g2 -- python3 tools/fs81_p0.py configs --cap-s 1800 --stage configs-g2 --fields 227,251,263,287,299
scripts/slot.py --mem 3 --cpus 1 --name fs81-configs-g3 -- python3 tools/fs81_p0.py configs --cap-s 1800 --stage configs-g3 --fields 323,347,371,383,395
```

### P0.3 results: B at K_B(d), structural certificates — **all 25 open fields landed** [cert + hand]

| d | mod 8 | mod 24 | census | K_B | pairs | at K_B: verdict (checked Farkas combinations) | certificate | at K_B − 1 |
|---|---|---|---|---|---|---|---|---|
| 35 | 3 | 11 | open | 2 | 50 | EMPTY (0) | `data/fs81/phase0/struct/d35-B-K2.json` | δ-system feasible (first case found) |
| 83 | 3 | 11 | open | 2 | 50 | EMPTY (256) | `data/fs81/phase0/struct/d83-B-K2.json` | δ-system feasible (first case found) |
| 107 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d107-B-K3.json` | δ-system feasible (first case found) |
| 131 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d131-B-K3.json` | δ-system feasible (first case found) |
| 155 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d155-B-K3.json` | δ-system feasible (first case found) |
| 179 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d179-B-K3.json` | δ-system feasible (first case found) |
| 203 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d203-B-K3.json` | δ-system feasible (first case found) |
| 215 | 7 | 23 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d215-B-K3.json` | δ-system feasible (first case found) |
| 227 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d227-B-K3.json` | δ-system feasible (first case found) |
| 251 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d251-B-K3.json` | δ-system feasible (first case found) |
| 263 | 7 | 23 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d263-B-K3.json` | δ-system feasible (first case found) |
| 287 | 7 | 23 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d287-B-K3.json` | δ-system feasible (first case found) |
| 299 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d299-B-K3.json` | δ-system feasible (first case found) |
| 323 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d323-B-K3.json` | δ-system feasible (first case found) |
| 347 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d347-B-K3.json` | δ-system feasible (first case found) |
| 371 | 3 | 11 | open | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d371-B-K3.json` | δ-system feasible (first case found) |
| 383 | 7 | 23 | open | 3 | 70 | EMPTY (64) | `data/fs81/phase0/struct/d383-B-K3.json` | δ-system feasible (first case found) |
| 395 | 3 | 11 | open | 3 | 70 | EMPTY (256) | `data/fs81/phase0/struct/d395-B-K3.json` | δ-system feasible (first case found) |
| 407 | 7 | 23 | open | 3 | 70 | EMPTY (64) | `data/fs81/phase0/struct/d407-B-K3.json` | δ-system feasible (first case found) |
| 419 | 3 | 11 | open | 3 | 70 | EMPTY (256) | `data/fs81/phase0/struct/d419-B-K3.json` | δ-system feasible (first case found) |
| 443 | 3 | 11 | open | 3 | 70 | EMPTY (256) | `data/fs81/phase0/struct/d443-B-K3.json` | δ-system feasible (first case found) |
| 455 | 7 | 23 | open | 3 | 70 | EMPTY (64) | `data/fs81/phase0/struct/d455-B-K3.json` | δ-system feasible (first case found) |
| 467 | 3 | 11 | open | 3 | 70 | EMPTY (256) | `data/fs81/phase0/struct/d467-B-K3.json` | δ-system feasible (first case found) |
| 479 | 7 | 23 | open | 3 | 70 | EMPTY (64) | `data/fs81/phase0/struct/d479-B-K3.json` | δ-system feasible (first case found) |
| 491 | 3 | 11 | open | 3 | 70 | EMPTY (256) | `data/fs81/phase0/struct/d491-B-K3.json` | δ-system feasible (first case found) |
| 11 | 3 | 11 | certified | 1 | 30 | EMPTY (0) | `data/fs81/phase0/struct/d11-B-K1.json` | — |
| 23 | 7 | 23 | certified | 2 | 50 | EMPTY (0) | `data/fs81/phase0/struct/d23-B-K2.json` | δ-system feasible (first case found) |
| 47 | 7 | 23 | certified | 2 | 50 | EMPTY (0) | `data/fs81/phase0/struct/d47-B-K2.json` | δ-system feasible (first case found) |
| 59 | 3 | 11 | certified | 2 | 50 | EMPTY (0) | `data/fs81/phase0/struct/d59-B-K2.json` | δ-system feasible (first case found) |
| 71 | 7 | 23 | certified | 2 | 50 | EMPTY (0) | `data/fs81/phase0/struct/d71-B-K2.json` | δ-system feasible (first case found) |
| 95 | 7 | 23 | certified | 2 | 50 | EMPTY (64) | `data/fs81/phase0/struct/d95-B-K2.json` | δ-system feasible (first case found) |
| 119 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d119-B-K3.json` | δ-system feasible (first case found) |
| 143 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d143-B-K3.json` | δ-system feasible (first case found) |
| 167 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d167-B-K3.json` | δ-system feasible (first case found) |
| 191 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d191-B-K3.json` | δ-system feasible (first case found) |
| 239 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d239-B-K3.json` | δ-system feasible (first case found) |
| 311 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d311-B-K3.json` | δ-system feasible (first case found) |
| 335 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d335-B-K3.json` | δ-system feasible (first case found) |
| 359 | 7 | 23 | certified | 3 | 70 | EMPTY (0) | `data/fs81/phase0/struct/d359-B-K3.json` | δ-system feasible (first case found) |
| 431 | 7 | 23 | certified | 3 | 70 | EMPTY (64) | `data/fs81/phase0/struct/d431-B-K3.json` | δ-system feasible (first case found) |

Every row at K_B: `fs81_struct_check.py` PASS. Relation-tree route on the same object: d = 11, K = 1 EMPTY (9,186 nodes), the frozen checker PASS; d = 35, K = 2 UNDECIDED at 1,821 s and 835,827 nodes (`data/fs81/phase0/p03.jsonl`).

**Scope of the P0.3 certificates (the owner's wording, adopted).** Each certificate proves `χ(ℚ(√d)²) ≥ 4` at grade **[cert + hand]**,
the hand part being R2 (the ℚ-linear extension and the recurrence), R4 (the coefficients n, −(2n−1), n sum to 1, so L_k lands in
5^K(ℤ + ½)²) and FS73-T22's ⟹ direction. It is **independent of the field-level theorem F-T4**: it uses T22 and the rational layer
(re-proved by the checker at the given K), not F-T4's lemmas L1 or L4 — the two routes are separate evidence. **The structural form
is the instrument, not a convenience:** the relation tree was priced out on B (UNDECIDED at 835,827 nodes in 30 minutes over ℚ(√35),
50 pairs), while the structural certificate decides each field in about a second.

## 7. P0.2 — results (complete, 2026-09-24)

331 objects over the 40 census fields (records `data/fs81/phase0/configs*.jsonl`, six groups; every object in
`data/fs81/records/phase-P0-objects.md`, derived by `tools/fs81_table.py`). Every EMPTY and every NONEMPTY verdict passed its checker:
222 through the frozen `fs73v2_check.py`, 72 through `fs81_theta_check.py --no-enumerate` (after the owner's plant); no ERROR row.

| object | EMPTY | NONEMPTY | UNDECIDED at the cap |
|---|---|---|---|
| listed configurations (A, B, C, D at K = 1) | 6 — all at certified fields | 198 | 0 |
| saturations (every unit vector of a NONEMPTY configuration's span, D ≤ 5,000) | 83, at 22 fields (11 of them open) | 27 | 17 (600 s cap; 1,800 s for the first) |

- **Listed configurations at K = 1.** EMPTY exactly at: B over ℚ(√11); the T41 shape C over ℚ(√23) at (a, c, s) = (3, 4, +), ℚ(√71) at
  (1, 6, +), ℚ(√119) at (9, 10, −), ℚ(√167) at (11, 12, −) and (15, 14, +). **A is NONEMPTY at all 40 fields** (the verifier's §4.0 at
  d ≡ 11 mod 24; at d ≡ 23 mod 24 T8's threshold is d < 21 at K = 1); **B at every d ≥ 23**; **D (the N = 5 layer) at every field where
  it exists**; **C is NONEMPTY at 47 (both (a, c), both signs)** and at every d ≡ 7 (mod 8) from 191 up, open or certified. The T41
  shape empties at K = 1 only at d ∈ {23, 71, 119, 167}, all ≡ 23 (mod 48), and not at the next members of that class with a C layer
  (263, 311, 359) — a threshold in n, as for B [measured; a lead for the family derivation, not a claim].
- **The stop guard never fired:** no EMPTY on A's listed configuration at d ≡ 11 (mod 24).
- **Saturations landed 11 open fields by the relation tree and the frozen checker**, independently of P0.3's structural route:
  35, 131, 155, 179, 251, 287, 395, 407, 467, 479, 491. The other 14 open fields (83, 107, 203, 215, 227, 263, 299, 323, 347, 371, 383,
  419, 443, 455) have no tree-route certificate at this depth: their saturations were NONEMPTY, UNDECIDED at the cap, or above D = 5,000.
- **Failures on the way, each explained, none a process crash:** an int64 overflow in the screen (`a7fa50e5`); PARI's 8 MB stack
  overflowing on a 162-pair relation basis (`f9969a6c`, gp now at 2 GB); group 6's first run OOM-killed inside its own 3 GiB slot
  at the saturation of A over ℚ(√311), by the uncapped short-relation pool (fixed in `f9969a6c`; relaunched at 4 GiB, completed).
  Each relaunch resumed past the recorded items.

## 8. The per-field table (the phase's result)

**Only an EMPTY certificate speaks about the field**: it proves χ(ℚ(√d)²) ≥ 4 at [cert + hand]. Every other count is a typed null for
the object named. The P0.3 column's hand part is R2, R4 (re-derived by the owner) and FS73-T22's ⟹; the tree column's is T22's ⟹ alone.

| d | mod 8 | mod 24 | census | χ ≥ 4 certified by: P0.3 structural (object; certificate; checker) | also certified by the relation tree (P0.2 objects; frozen checker) | P0.2 nulls (typed) |
|---|---|---|---|---|---|---|
| 35 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d35-B-K2.json`; fs81_struct_check.py PASS | saturation of configuration A (30 pairs, D = 90); saturation of configuration B (54 pairs, D = 810) | 2 NONEMPTY |
| 83 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d83-B-K2.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 107 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d107-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 131 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d131-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration D:7:6:- (32 pairs, D = 1650) | 7 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 155 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d155-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (74 pairs, D = 390); saturation of configuration D:5:6:+ (36 pairs, D = 1950) | 7 NONEMPTY |
| 179 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d179-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration D:1:6:- (32 pairs, D = 450) | 7 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 203 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d203-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 215 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d215-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 227 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d227-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 251 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d251-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (42 pairs, D = 630); saturation of configuration D:27:14:+ (36 pairs, D = 3150); saturation of configuration D:27:14:- (24 pairs, D = 3150); saturation of configuration D:37:18:+ (24 pairs, D = 3150); saturation of configuration D:37:18:- (36 pairs, D = 3150) | 6 NONEMPTY |
| 263 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d263-B-K3.json`; fs81_struct_check.py PASS | — | 9 NONEMPTY |
| 287 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d287-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration C:1:12:- (36 pairs, D = 720); saturation of configuration C:15:16:+ (36 pairs, D = 1440); saturation of configuration C:15:16:- (24 pairs, D = 1440) | 7 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 299 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d299-B-K3.json`; fs81_struct_check.py PASS | — | 2 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 323 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d323-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 347 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d347-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 371 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d371-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 383 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d383-B-K3.json`; fs81_struct_check.py PASS | — | 9 NONEMPTY |
| 395 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d395-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration D:35:18:+ (36 pairs, D = 4950); saturation of configuration D:35:18:- (24 pairs, D = 4950); saturation of configuration D:45:22:+ (24 pairs, D = 4950); saturation of configuration D:45:22:- (36 pairs, D = 4950) | 6 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 407 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d407-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (42 pairs, D = 1020) | 2 NONEMPTY |
| 419 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d419-B-K3.json`; fs81_struct_check.py PASS | — | 6 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 443 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d443-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 455 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d455-B-K3.json`; fs81_struct_check.py PASS | — | 3 NONEMPTY |
| 467 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d467-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (54 pairs, D = 1170) | 2 NONEMPTY |
| 479 | 7 | 23 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d479-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration C:13:18:+ (30 pairs, D = 3600); saturation of configuration C:13:18:- (44 pairs, D = 3600); saturation of configuration D:49:24:+ (24 pairs, D = 1200); saturation of configuration D:49:24:- (50 pairs, D = 1200) | 10 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 491 | 3 | 11 | open | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d491-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (54 pairs, D = 1230) | 6 NONEMPTY |
| 11 | 3 | 11 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^1) (30 pairs); `data/fs81/phase0/struct/d11-B-K1.json`; fs81_struct_check.py PASS | saturation of configuration A (54 pairs, D = 30); listed configuration B = {vᵏ : \|k\| ≤ 2}·U^(5) (30 pairs, D = 90); saturation of configuration D:3:2:+ (48 pairs, D = 150); saturation of configuration D:3:2:- (48 pairs, D = 150); saturation of configuration D:13:6:+ (48 pairs, D = 150); saturation of configuration D:13:6:- (72 pairs, D = 150) | 5 NONEMPTY |
| 23 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d23-B-K2.json`; fs81_struct_check.py PASS | saturation of configuration A (30 pairs, D = 60); saturation of configuration B (90 pairs, D = 360); listed configuration C = {1, v, z}, (a, c) = (3, 4), sign +·U^(5) (18 pairs, D = 120) | 8 NONEMPTY |
| 47 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d47-B-K2.json`; fs81_struct_check.py PASS | saturation of configuration A (30 pairs, D = 120); saturation of configuration C:9:8:- (24 pairs, D = 240) | 9 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 59 | 3 | 11 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d59-B-K2.json`; fs81_struct_check.py PASS | saturation of configuration A (50 pairs, D = 150); saturation of configuration D:11:6:+ (32 pairs, D = 150); saturation of configuration D:11:6:- (26 pairs, D = 150); saturation of configuration D:21:10:+ (26 pairs, D = 750); saturation of configuration D:21:10:- (40 pairs, D = 750) | 6 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 71 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d71-B-K2.json`; fs81_struct_check.py PASS | saturation of configuration A (66 pairs, D = 180); saturation of configuration B (210 pairs, D = 3240); listed configuration C = {1, v, z}, (a, c) = (1, 6), sign +·U^(5) (18 pairs, D = 180); saturation of configuration C:1:6:- (44 pairs, D = 180); saturation of configuration C:21:16:+ (64 pairs, D = 1440); saturation of configuration C:21:16:- (80 pairs, D = 1440); saturation of configuration D:3:4:+ (52 pairs, D = 900); saturation of configuration D:3:4:- (32 pairs, D = 900); saturation of configuration D:53:24:+ (70 pairs, D = 1800); saturation of configuration D:53:24:- (72 pairs, D = 1800) | 9 NONEMPTY |
| 95 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^2) (50 pairs); `data/fs81/phase0/struct/d95-B-K2.json`; fs81_struct_check.py PASS | saturation of configuration A (54 pairs, D = 240); saturation of configuration D:15:8:+ (36 pairs, D = 1200); saturation of configuration D:15:8:- (24 pairs, D = 1200); saturation of configuration D:25:12:+ (24 pairs, D = 1200); saturation of configuration D:25:12:- (48 pairs, D = 1200) | 6 NONEMPTY |
| 119 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d119-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration C:3:8:+ (48 pairs, D = 1200); saturation of configuration C:3:8:- (38 pairs, D = 1200); saturation of configuration C:9:10:+ (28 pairs, D = 300); listed configuration C = {1, v, z}, (a, c) = (9, 10), sign -·U^(5) (18 pairs, D = 300) | 5 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 143 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d143-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (30 pairs, D = 360) | 2 NONEMPTY |
| 167 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d167-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (30 pairs, D = 420); saturation of configuration C:11:12:+ (24 pairs, D = 840); listed configuration C = {1, v, z}, (a, c) = (11, 12), sign -·U^(5) (18 pairs, D = 840); listed configuration C = {1, v, z}, (a, c) = (15, 14), sign +·U^(5) (18 pairs, D = 420) | 5 NONEMPTY |
| 191 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d191-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration C:3:10:+ (60 pairs, D = 2400); saturation of configuration C:3:10:- (54 pairs, D = 2400); saturation of configuration C:31:24:+ (42 pairs, D = 480); saturation of configuration C:31:24:- (42 pairs, D = 480); saturation of configuration D:23:12:- (42 pairs, D = 2400); saturation of configuration D:33:16:+ (42 pairs, D = 2400) | 10 NONEMPTY, 3 UNDECIDED at the cap (weak finder of isolated points) |
| 239 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d239-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (102 pairs, D = 600); saturation of configuration C:7:12:+ (36 pairs, D = 600); saturation of configuration C:7:12:- (36 pairs, D = 600); saturation of configuration D:9:8:+ (34 pairs, D = 600); saturation of configuration D:9:8:- (46 pairs, D = 600); saturation of configuration D:79:36:+ (52 pairs, D = 1800); saturation of configuration D:79:36:- (44 pairs, D = 1800) | 10 NONEMPTY |
| 311 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d311-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration C:29:24:+ (64 pairs, D = 3120); saturation of configuration C:29:24:- (54 pairs, D = 3120) | 10 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 335 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d335-B-K3.json`; fs81_struct_check.py PASS | — | 2 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |
| 359 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d359-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration A (74 pairs, D = 900); saturation of configuration C:17:18:+ (34 pairs, D = 900); saturation of configuration C:17:18:- (26 pairs, D = 900); saturation of configuration C:21:20:+ (26 pairs, D = 1800); saturation of configuration C:21:20:- (48 pairs, D = 1800); saturation of configuration D:19:12:+ (36 pairs, D = 900); saturation of configuration D:19:12:- (28 pairs, D = 900) | 10 NONEMPTY |
| 431 | 7 | 23 | certified | listed B = {vᵏ : \|k\| ≤ 2}·U^(5^3) (70 pairs); `data/fs81/phase0/struct/d431-B-K3.json`; fs81_struct_check.py PASS | saturation of configuration C:9:16:+ (30 pairs, D = 4320); saturation of configuration C:9:16:- (40 pairs, D = 4320) | 10 NONEMPTY, 1 UNDECIDED at the cap (weak finder of isolated points) |

**All 25 open census fields are landed** by P0.3's structural certificates on the listed configuration
`{vᵏ : |k| ≤ 2}·U^(5^K_B(d))` (K_B = 2 at d = 35, 83; 3 elsewhere), and 11 of them also by the relation tree on a saturated lattice
through the frozen checker. With FS-61's 14 and FS-73's ℚ(√167), **all 40 squarefree d ≡ 11 (mod 12) below 500 now have a certified
χ(ℚ(√d)²) ≥ 4.** Not claimed: a three-colouring of any plane; anything about d ≥ 500 (the verifier's F-T4 is the field-level route).

**P0.4 not run, by the stop rule:** every open field had a certified EMPTY after P0.3, so the census lattices and the saturated chain
were not needed. (P0.2's saturations are the nearest thing: several are the census's own open lattices, e.g. ℚ(√35)'s `Ldb4246f8`.)

## 9. Theorems this phase proved

*(Grades per `CLAUDE.md` § Notation. "Structural checker" = `tools/fs81_struct_check.py`, planted by the owner; "frozen" =
`tools/fs73v2_check.py`; "new checker" = `tools/fs81_theta_check.py`, planted by the owner.)*

| id | statement | grade | where the proof lives |
|---|---|---|---|
| P0-T1 | **χ(ℚ(√d)²) ≥ 4 for each of the 25 open census d** (35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419, 443, 455, 467, 479, 491): the listed configuration `{vᵏ : \|k\| ≤ 2}·U^(5^K_B(d))` has empty Θ₃ | cert + hand (R2, R4, FS73-T22 ⟹) | `data/fs81/phase0/struct/d<d>-B-K<K>.json`, structural checker PASS; §6 |
| P0-T2 | the same at the 15 census fields certified earlier (11, 23, 47, 59, 71, 95, 119, 143, 167, 191, 239, 311, 335, 359, 431) — a second, uniform witness for each | cert + hand | as P0-T1 |
| P0-T3 | χ(ℚ(√d)²) ≥ 4 at 35, 131, 155, 179, 251, 287, 395, 407, 467, 479, 491 **also** by relation-tree certificates on saturated lattices (D ≤ 5,000), independent of the structural route | cert + hand (T22 ⟹) | `data/fs81/phase0/certs/*-sat.json.gz`, frozen PASS; §7 |
| P0-T4 | the reduction for B: θ ∈ Θ₃ ⟹ δ-system (L_k(δ) = nΔ²δ_k + δ_k ∈ 5^K(ℤ + ½)², δ_k ∈ P ∪ F) is solvable | hand (re-derived by the owner) | `tools/fs81_struct_check.py` docstring R2, R4; §6 |
| P0-T5 | the rational layer: Θ_K ⊆ c_K + (P_K ∪ F_K) + 5^K ℤ² at K ≤ 3 by the checker's induction; equality with one polygon and four order-3 points per period at K ≤ 6 by exact lifting | tools exact (the verifier proved every K) | `tools/fs81_struct_check.py` R3; `tools/fs81_rational.py`; §3 |
| P0-T6 | at K_B(d) − 1 the δ-system is solvable at all 40 fields (the generator's side of T8's threshold; a necessary condition only, not a point of Θ₃) | tools exact (float LP proposes feasibility; not certified) | `data/fs81/phase0/p03-struct.jsonl` |
| P0-T7 | a new EMPTY certificate for ℚ(√59) on the 23 edge-direction pairs of its FS-61 witness | cert + hand | `data/fs81/phase0/certs/ctl-pos-59-witness.json.gz`, frozen PASS |
| P0-T8 | at K = 1 the listed configurations are EMPTY exactly at: B over ℚ(√11); C over ℚ(√23) (3, 4, +), ℚ(√71) (1, 6, +), ℚ(√119) (9, 10, −), ℚ(√167) (11, 12, −) and (15, 14, +); NONEMPTY with a certified point at the other 198 tested | cert (EMPTY: + hand) | `data/fs81/records/phase-P0-objects.md` |
| P0-T9 | A = `{1, v, v̄}·U^(5)`'s span over ℚ(√167) is L21cc6506's lattice (its θ fails on z̄ = (225, 15, −225, 15)), so a configuration's span can decide where the configuration does not | cert | `data/fs81/phase0/checker-fixtures/wide-A167-on-L21cc6506.json` |
| P0-T10 | complex conjugation and √d ↦ −√d send the T41 configuration C(s = +) to the same set, neither C(+) nor C(−): the two signs are the two orbits; conjugate pairs agree at 167 and 47 | tools exact + cert | `data/fs81/phase0/orbits.jsonl` |
| P0-T11 | the frozen `fs73v2_check.py`'s own `--self-test` passes both coverage mutants (low child r·x ≤ lo − 2; high child r·x ≥ hi + 2); the checker itself is unchanged and sound | tools (mutation test) | §3's note; the mutants in the implementer's scratch |

## 10. What is left, and how to resume

- **Nothing of P0.0–P0.3 is open.** 17 saturations stay UNDECIDED at their caps (listed in `phase-P0-objects.md`); their checkpoints
  are under `data/fs81/phase0/ckpt/` (449 MB, git-ignored), resumable by re-running their group's command with a larger `--cap-s`.
- **Leads for the family derivation (not claims):** the T41 shape empties at K = 1 only at d ∈ {23, 71, 119, 167} (≡ 23 mod 48) and
  not at 263, 311, 359 — a threshold in n like B's; the N = 5 layer never empties at K = 1.
- **Relation-tree prices on B** (for anyone tempted to use the tree there): K = 2, ℚ(√35): UNDECIDED at 835,827 nodes, 30 min;
  K = 2, ℚ(√83): UNDECIDED at 541,772 nodes, 30 min (`data/fs81/phase0/p03.jsonl`); K = 2, ℚ(√23) (the one K = 2 case the frozen checker could have read, D = 1,800): UNDECIDED at 458,007 nodes, 30 min; K = 1, ℚ(√11): EMPTY at 9,186 nodes (`data/fs81/phase0/p03-tree-xcheck.jsonl`).

## 11. The acceptance pass: every certificate re-checked

`scripts/slot.py --mem 8 --cpus 12 --name fs81-recheck -- env WORKERS=12 python3 tools/fs81_recheck.py data/fs81/phase0/{controls,orbits,configs,configs-g2,configs-g3,configs-g4,configs-g5,configs-g6,p03-tree-xcheck,p03-struct}.jsonl`
re-ran, on the files as committed, the checker each record names (frozen `fs73v2_check.py`, `fs81_theta_check.py --no-enumerate`,
or `fs81_struct_check.py`), and required the verdict the record states: **411 certificates, 0 failed**
(`data/fs81/records/phase-P0-recheck.out`). **A naming defect it covers:** certificate files are named by object (d, configuration,
K), so a second stage deciding the same object (the orbit control, the ℚ(√11) cross-check) and P0.2's own run wrote the same file,
the later overwriting the earlier; the two trees are the same deterministic computation on the same object, and the re-check ran every
referencing record against the file now on disk.
