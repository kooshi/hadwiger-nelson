# FS-81 stage D — ℚ(√47) at four colours, calibrated first: the record

*Implementer: de Bruijn (Opus 5.5), from the owner's brief of 2026-09-24. Spec of record: `plans/FS81-quadratic-four-colours.md` §S.D,
with §B.1–§B.3 behind it. Machine for every number below: the desktop (16 physical cores / 32 threads, 128 GB).
This file is kept current enough that a successor can resume from the repository alone (§ Resume).*

## Status

| step | state |
|---|---|
| DK — the two checkers | **done**: self-tests pass (`data/fs81/phaseD/dk-selftest-*.out`); the owner's plants refused by each (K1: an index-2 quotient basis → `SPAN_MISMATCH`, a sheared basis with the table not re-indexed → `IMPROPER_EDGE`; K2: the conflict hint dropped at three positions of fixture (b)'s LRAT → `PROOF_STEP` each); committed `677d59e9` |
| D0a — the harvest | **done**: 558 recorded asks in the schema (`data/fs81/phaseD/d0a-harvest.jsonl`, summary `d0a-summary.md`) |
| D0b — the rank-4 ladder | not started (needs the heavy lock) |
| D1 — the screen at 47 | not started (needs the heavy lock) |
| D2 — one priced ask | not started (needs the heavy lock) |

## DK — the checkers

### K2: `tools/fs81_check_witness_k.py` (four-colour refusals)

**What it proves.** From a witness JSON and an LRAT proof it certifies that no proper k-colouring exists of the induced unit-distance
graph on a finite point set of F², F = ℚ(√d₁,…,√d_r) real multiquadratic, plus at most one named non-unit edge. Steps: the field (no
nonempty sub-product of the radicands a square, so the basis √(∏S) is ℚ-independent); the points (reduced integer tuples, no
duplicates); **every** unit pair re-derived in integers and equal to the file's edge list; the extra edge not unit, its squared length
reported exactly; the symmetry rule (below); the CNF built from its own edges; the LRAT checked by fs58's RUP routine (unchanged). The
conclusion switches by object: with no extra edge "hence χ(F²) ≥ k + 1"; with X_A's edge {p, q} "a FORCED PAIR … This is not a
chromatic bound" (§B.3.3).

**The symmetry rule, and its soundness** (inventory item 52, §B.2.2). Pins: a clique of the graph (unit edges plus the extra edge),
pinned to colours 0..p−1 in order. Value precedence: chains `[f1, f2]` with f1 < f2 < k and **both unpinned**; a chain touching a
pinned colour is refused (`PRECEDENCE_OVER_PINNED_COLOUR`). Each chain adds s(0..n) and `[−s(0)]`, `[−x(v,f2), s(v)]`,
`[−s(v+1), s(v), x(v,f1)]`. Sound: relabel the unpinned colours by first appearance along the vertex order (pins untouched), and set
s(v) = [f1 appears before v]. This is exactly `fs73_screen.graph_cnf`'s chain, restricted to unpinned colours.

**Two departures from §S.D's K2 row, each forced by the material:**
1. **K2 checks points over a real multiquadratic field, not only ℚ(√d).** X_A — the matched control every price needs, "its refusal
   certified by K2" — lives over K = ℚ(√3,√11) (de Grey's lattice). A ℚ(√d)-only K2 could not check it. For r = 1 the point format is
   fs58's `(a, b, c, e, m)` exactly. *Alternative weighed:* certify X_A with the frozen `tools/fs73_cert_check.py`. It cannot: it knows no
   value precedence, and the target encoding (edge pin + precedence) is what every matched comparison must hold fixed.
2. **K2 therefore has a k = 4 positive control after all — a forcing one.** X_A's certified 2,044-point core certifies under K2 at
   k = 4 twice: (a) under fs73's triangle pin with fs73's own LRAT (K2's CNF sha256 `65d3897d…` equals fs73's: the same formula clause
   for clause); (b) under a unit-edge pin plus the chain [2, 3] with a fresh CaDiCaL LRAT. So K2 has no k = 4 **chromatic** positive control
   (the owner's wording): a unit-distance graph refusing four with no extra edge — over ℚ(√d) none is known — has never passed through
   it, and the second checker stays mandatory for any D refusal.

**Self-test** (`python3 tools/fs81_check_witness_k.py --selftest`, 59 s; output `data/fs81/phaseD/dk-selftest-K2.out`): all pass.
- Controls: FS-58's ℚ(√11) witness at k = 3 CERTIFIED ("hence χ(ℚ(√11)²) ≥ 4"), with the same variable and clause counts as the frozen
  `fs58_check_witness.py`, which also certifies it; FS-58's ℚ(√47) witness likewise; the same witnesses and proofs at k = 4 REFUSED
  (`PROOF_STEP`).
- Twins: X_A (a) and (b) CERTIFIED with the forced-pair line and without any "χ(" line; squared length of the extra edge 64/27 = |v|².
- Plants, each refused for its named reason: a point moved off the lattice (`EDGE_NOT_UNIT`); a non-unit pair added (`EDGE_NOT_UNIT`);
  one edge dropped (`EDGE_MISSING`); the pin moved to a non-adjacent pair (`PIN_NOT_CLIQUE`); k changed 4 → 3 with the proof unchanged
  (`PROOF_STEP`; on the chained twin `PRECEDENCE_FORMAT`, the chain then naming a colour ≥ k); a chain [1, 2] over pinned colour 1 and a
  chain [2, 3] under the triangle pin (`PRECEDENCE_OVER_PINNED_COLOUR`); the proof truncated (`NO_EMPTY_CLAUSE`); the extra edge replaced
  by a unit edge (`EXTRA_EDGE_IS_UNIT`); dependent radicands [3, 12] (`RADICAND`); the bucketed edge search equals an all-pairs exact
  search (10,703 = 10,703).
- Information row: with the chain removed, twin (b)'s proof is refused (`PROOF_STEP`: it cites a chain clause), so the chain was used.

**The second RUP check: `tools/fs81_rup_recheck.py`.** K2 writes its CNF; `cake_lpr` — the CakeML-verified LRAT checker, built from
`github.com/tanyongkiam/cake_lpr` commit `a36874a` at `~/source/cake_lpr/cake_lpr` (`cake_lpr.S` sha256 `2f3af32d…`; built with
`cd ~/source/cake_lpr && env -u LIBRARY_PATH -u LEAN_CC make`, i.e. `gcc -O2 basis_ffi.c cake_lpr.S -o cake_lpr -std=c99`; the Lean
toolchain's library path breaks the link; full `cake_lpr.S` sha256 `2f3af32d55083839b3fa0e693afd817679c0b8944bef41def05a8b0ec72b7d4a`;
it lives outside the repository, so a successor rebuilds it with that command at that commit) — must print `s VERIFIED UNSAT`; kissat must refuse
the same CNF. Self-test: fixture (b) rechecked (cake_lpr 3.8 s, kissat 25.4 s CPU); a proof for another formula and a half-truncated
proof both not verified. This replaces the spec's first option (fs73's RUP routine through a wrapper), which is fs58's routine again and
so not independently written.

### K1: `tools/fs81_colour_check.py` (four-colourings of ℚ(√d)'s lattice graphs)

A copy of `tools/fs79_p0_check.py` (which already read d from the witness, but never checked it) with d checked to be a squarefree
integer > 1, k read and bounded, and a certified line that names d, k, the witness sha256 and what it licenses ("that lattice graph is
k-colourable — a typed null for the plane, never a colouring of ℚ(√d)²"). Rules unchanged: additive, linear, residue, quotient; the gap
claim checked at the origin's closed neighbourhood.

**Self-test** (`python3 tools/fs81_colour_check.py --selftest`; output `data/fs81/phaseD/dk-selftest-K1.out`): `--controls` on each d = 47
fixture, all pass. Fixtures (`data/fs81/phaseD/k1-fixtures/`, by `tools/fs81_phaseD.py k1-fixture`, **no solver**): an additive ℤ/4
colouring φ = (1, 1, 3, 3) on the Hermite basis of Λ₃₆ (20 unit vectors), and the N = 4 quotient witness it induces. Plants refused for
their reasons: a unit vector dropped from one enumerator (`UNIT_ENUMERATION_DISAGREES`) and from the witness's count (`UNIT_COUNT`); a
sublattice for H (`SPAN_MISMATCH`); φ = 0 (`ADDITIVE_ZERO_ON_UNIT`); d changed to 167 with the witness unchanged (`UNIT_COUNT`); d = 188
(`BAD_D`); one class recoloured to a neighbour's colour (`IMPROPER_EDGE`); a constant table (`IMPROPER_EDGE`); N = 1, a period that is
not a period (`INADMISSIBLE`); a gap claimed where the origin sees every colour (`GAP_CLAIM_FALSE`).

**One gap in K1's self-test, stated.** No d = 47 fixture is *gapped*: an additive colouring of a non-bipartite lattice graph cannot be,
since φ(U) = −φ(U) forces φ(U) = {1, 2, 3} (or a bipartite graph). The gapped branch's positive case is first exercised on D1's first
gapped witness, where `--controls` is run before the witness is believed.

### Instrument runs made in DK (controls, not band asks; none enters D0)

| run | object | encoding | solver | verdict | CPU s |
|---|---|---|---|---|---|
| K2 fixture (b) | X_A core, 2,044 points + edge {0, v} | unit-edge pin [1356, 1604] + chain [2, 3] | CaDiCaL 2.1.2 (toolchain), LRAT | UNSAT | 20.09 |
| the same CNF | | | kissat 4.0.4 | UNSAT | 25.37 |

(The LRAT: 369,404 additions, trimmed to the 272,119 the empty clause reaches, 39.8 MB gzipped.)

## D0a — the harvest (no solver)

`python3 tools/fs81_phaseD.py harvest` (deterministic; rewrites `data/fs81/phaseD/d0a-harvest.jsonl`, one row per recorded four-colour
ask in the §B.1.1 schema: family, shape, R, n, m, `d_ball`, `n₄`, `d₄`, pins, precedence, solver, version, wall, machine, verdict, CPU s,
wall fired, CNF sha256, source, note; a field the record does not hold is null). 558 rows: every item §S.D's D0a row names, plus the rest
of the same records (FS-73's 113 quotient asks on de Grey's lattice; FS-79's quotient asks at 167, including refusals; its solver-decided
residue-target and Γ₂₃ asks). Rows decided by an exhibited colouring or by the Hoffman bound are marked "not a solver ask" or omitted.
The per-family summary is `data/fs81/phaseD/d0a-summary.md`.

**The rank-4 ball asks on record** (de Grey's lattice, embedding-bounded balls about the pair's midpoint, 4-core with the pair kept;
kissat 4.0.4 unless named; pins: the pair plus a common neighbour when one exists, else the pair alone plus the chain [2, 3]):

| family | R | n | `d_ball` | verdict | CPU s | wall |
|---|---|---|---|---|---|---|
| X_A (δ = v) | 1.0 | 7,879 | 8.30 | UNKNOWN | 1,494 | 1,500 (fired) |
| X_A | 1.5 | 39,829 | 18.41 | UNSAT | 36.6 (kissat); 37.2 (Glucose, P1d); 678.7 (Lingeling, pair pins only) | — |
| X_δ, δ = 8/9 (no common neighbour: edge pin + chain) | 1.0, 1.25, 1.3, 1.4 | 7,879 – 30,181 | 8.30, 13.75, 14.73, 16.60 | UNKNOWN ×4 | ~1,494 each | 1,500 (fired) |
| X_δ, δ = 8/9 | 1.5 | 39,829 | 18.41 | UNSAT | 1,406.9 (kissat); 130.2 (Glucose) | — |
| X_δ, δ = 8/3 | 1.5 | 39,829 | 18.41 | UNSAT | 122.2 (kissat); 13.2 (Glucose) | — |
| colourable, Cay(Λ_dG, U), plain | 1.0 | 7,879 | 8.30 | **UNKNOWN** | 1,494 | 1,500 (fired) |
| colourable, plain | 1.5 | 39,829 | 18.41 | SAT ×4 | 1.1 – 3.9 | — |

X_A's 35 assumption-core rounds (pysat CaDiCaL 1.9.5): 39,829 → 2,044 points, 705 s CPU for round 0 falling to ~70 s per round at the end.

**What the record already says, before any new solve** (each [measured], one encoding per row, not yet matched):
1. **The four-colour hardness peak sits near `d_ball` ≈ 8.3 on this lattice.** The plain ask on the colourable R = 1.0 ball — a
   satisfiable instance — ran to its 1,500 s wall; at 18.41 the same family answers in seconds. (The random-graph four-colouring
   threshold ≈ 8.9 is still [external, unchecked], inventory item 54.)
2. **A rank-4 refusal can stay undecided far above the peak.** δ = 8/9's forcing asks ran to the 1,500 s wall at `d_ball` 13.75, 14.73
   and 16.60, and refused at 18.41 only after 1,407 s (kissat). So, under that encoding, four-colour refusals on this family did not
   decide within 25 minutes below `d_ball` ≈ 18. This bears on P-D0 (threshold ≈ 12, within 1 h); it is δ = 8/9, not X_A, and a 25-minute
   wall, not an hour, so it scores nothing yet.
3. **Solver spread at one object is a factor of 10–20**: X_A at R = 1.5 refused in 36.6 s (kissat, triangle pin), 37.2 s (Glucose) and
   678.7 s (Lingeling, pair pins only); δ = 8/9 in 1,407 s (kissat) against 130 s (Glucose). A price formed across solvers or encodings
   would measure them, not the band.
4. **`R*(X_A)` ≤ 1.4997 with no solver.** The certified 2,044-point core lies inside the embedding-bounded ball of radius 1.49822 /
   1.49966 (the two embeddings) about the pair's midpoint, so every such ball with R ≥ 1.4997 contains it, and so does its 4-core (a
   vertex of degree < 4 can be deleted from a refusing graph without making it colourable). Below that, no ask on record decides: R = 1.0
   is UNKNOWN, not SAT, so **the record does not bracket `R*(X_A)` from below**.

**Consequence for D0b's design** (to the owner with the D0a report): descending from R = 1.5 in steps of 0.1 walks X_A through the
radii where δ = 8/9 ran to the wall, so the ladder's lower bracket may cost several walls of UNKNOWN before a SAT. The stop rule is kept
("bracketed" = the least UNSAT and the greatest SAT radius), and every UNKNOWN rung between them is reported as the undecided band,
which is itself the band datum.

## Predictions (registered 2026-09-24, before the first band solver run)

The plan's (§P): **P-D0** (scoped by stage B) 0.5 — four-colour refusals on the refutation-rank ≥ 2 families (X_A, X_B) decide within
1 h only above `d_ball` ≈ 12; **P-D1** 0.7 — the screen at 47 leaves at least one survivor at M ≤ 2,520; **P-D2** 0.15 — D2's ask
refuses within its wall. Mine, each with the other outcome and why it is reachable:

| id | prediction | p | the other outcome, reachable because |
|---|---|---|---|
| PD-1 | X_A under the target encoding (unit-edge pin + chain [2, 3]) refuses at R = 1.5 within 1,800 s | 0.85 | UNKNOWN at the wall: one object already spans 36.6–678.7 s across solvers and pins (D0a item 3) |
| PD-2 | some R ∈ {1.0, …, 1.4} returns SAT for X_A (target encoding) within the wall, so `R*` is bracketed below | 0.45 | every lower rung UNKNOWN (or UNSAT): δ = 8/9 ran to the wall at `d_ball` 13.75–16.60 |
| PD-3 | the least UNSAT radius for X_A (target) is 1.4 or 1.5 | 0.6 | ≤ 1.3 (a smaller refusing core exists, 0.25) or none (1.5 UNKNOWN, 0.15) |
| PD-4 | X_B refuses at every radius where X_A refuses, never slower than X_A there | 0.6 | X_B slower somewhere: more edges also mean a larger formula |
| PD-5 | §B.1.5's degree-universality on X_A against X_B: CPU times to refusal within a factor of 3 at every radius where both refuse | 0.4 | a factor above 3: the solver spread at one object is already 10–20 |
| PD-6 | the colourable family (target encoding) is SAT within 60 s at every R ≥ 1.3 and UNKNOWN at the wall at R = 1.0 | 0.6 | SAT at R = 1.0 under the new pins (the recorded UNKNOWN used a triangle pin), or slow SAT above 1.3 |
| PD-7 | at R = 1.5 X_A refuses faster under the target encoding than under the triangle pin (same solver, same load) | 0.55 | the reverse: pinning three colours leaves one free, which may prune more |
| PD-8 | at least one ℚ(√47) survivor of D1 needs at most 10⁷ points to reach `d*` (G65's `N(d*)`) | 0.25 | every survivor far denser: at 167 the survivors' `N` at degree 14 was 10⁸–10¹¹ (FS-79 price), and L21cc6506 needs 2.3·10⁸ |

**Dropped from D0b, with the reason** (a measured price, not a choice): "L21cc6506 at matched `d_ball`". Its covolume is 8.6·10⁻⁸
against ≈ 1.25·10⁻³ for de Grey's lattice (39,829 points at R = 1.5), so G65's `N = π²R⁴/covol` is 2.3·10⁸ points at degree 14 and
7.5·10⁷ even at R = 0.9 (FS-79's sweep row for M = 420). No matched ask of it can be built. ℚ(√47)'s own coloured lattices from D1 take its
place as the ω = 2 colourable family, at whatever `d_ball` their covolume allows.

## Theorems this phase proved

| id | statement | grade | proof |
|---|---|---|---|
| D-T1 | Value precedence over **unpinned** colours, encoded by the auxiliary chain s(0..n), is a sound symmetry reduction under any clique pin and any vertex order; a chain touching a pinned colour is not (it forbids colourings no permutation repairs unless the pinned clique comes first in the order) | [hand] | K2's docstring, step 4; this record, K2 |
| D-T2 | De Grey's lattice point (a + bζ₆ + cw + dζ₆w)/9 is ((4a + 2b + 2c + d − d√33)/36, ((2b + d)√3 + (2c + d)√11)/36) | [hand + tools exact] | `tools/fs81_phaseD.py` `oe_to_k2`; K2 re-derives exactly fs73's 10,703 unit edges from the converted points and rebuilds fs73's CNF byte for byte (sha256 `65d3897d…`) |
| D-T3 | An additive four-colouring of a non-bipartite lattice unit-distance graph is gap-free at every vertex | [hand] | φ(−u) = −φ(u), so φ(U) is a symmetric subset of ℤ/4∖{0} or V₄∖{0}; a two-element symmetric one gives a proper 2-colouring |

## Resume

**D0b, the ladder** (under the heavy lock; one JSONL row per ask appended with fsync to `data/fs81/phaseD/d0b-asks.jsonl`):

```
cd /home/kooshi/source/lean-dir
setsid nohup flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock \
    python3 tools/fs81_phaseD.py ladder --workers 8 --wall 1800 >> data/fs81/phaseD/d0b-run.log 2>&1 &
```

*If it dies at any instant, what is redone:* the asks in flight (at most eight, each at most 1,800 s of kissat plus, for an UNSAT, one
CaDiCaL re-ask), because a row is written only when its ask ends; the CNFs are rebuilt in seconds. *Resume:* the same command — it skips
every key already in the JSONL with a verdict. *Check the launch:* `flock -w` exits 1 without running anything when the wait expires, so
the log's first line must be "D0b ladder: …"; the pgid is the `setsid` child's, read from `ps -o pgid= -p <pid>` and written to
`data/fs81/phaseD/d0b.pgid`; a kill is verified by the pid absent from `ps` and the JSONL static for ten seconds.

**D1, the screen at 47** (`tools/fs81_d47.py`, a copy of FS-79's `fs79_p0.py` at d = 47; writes `data/fs81/phaseD/d47/`):
`sweep --mmax 2520`, then `screen --ids all`, then `screen --ids survivors`; each resumable by re-running (every record keyed and
skipped when present). Written before launch in full, with its budgets, when D1 starts.
