# FS-81 stage D — ℚ(√47) at four colours, calibrated first: the record

*Implementer: de Bruijn (Opus 5.5), from the owner's brief of 2026-09-24. Spec of record: `plans/FS81-quadratic-four-colours.md` §S.D,
with §B.1–§B.3 behind it. Machine for every number below: the desktop (16 physical cores / 32 threads, 128 GB).
This file is kept current enough that a successor can resume from the repository alone (§ Resume).*

## Status

| step | state |
|---|---|
| DK — the two checkers | **done**: self-tests pass (`data/fs81/phaseD/dk-selftest-*.out`); the owner's plants refused by each (K1: an index-2 quotient basis → `SPAN_MISMATCH`, a sheared basis with the table not re-indexed → `IMPROPER_EDGE`; K2: the conflict hint dropped at three positions of fixture (b)'s LRAT → `PROOF_STEP` each); committed `677d59e9` |
| D0a — the harvest | **done**: 558 recorded asks in the schema (`data/fs81/phaseD/d0a-harvest.jsonl`, summary `d0a-summary.md`) |
| D0b — the rank-4 ladder | **ladder run** (37 asks, `data/fs81/phaseD/d0b-asks.jsonl`); `R*(X_A)` bracketed from above only (below: the undecided band); quiet re-asks of the decision numbers pending |
| D1 — the screen at 47 | **first pass done**: 127 lattices; 102 four-colourable (177 witnesses, all K1-CERTIFIED), **25 survivors, 10 minimal**; the deep pass, the long residue re-asks and the calibrated `Θ₄` finder remain (successor) |
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

## D0b — the rank-4 ladder (run 2026-09-24, slot "d0b": 12 cores, 24 GiB; commit of the tool `3a5cbd8f`)

Every ask: kissat 4.0.4, wall 1,800 s enforced by the parent, the 4-core of the ball (= the whole ball at every radius), one fixed CNF
writer (K2's layout). **Times are contended** (up to twelve asks at once; the load is on every row as `[L n]`) and read the bracket
only; no number here enters a decision until it is re-asked alone. `cad` = the toolchain CaDiCaL re-asking the same CNF after an UNSAT.

| R | n (every family) | `d_ball` X_A / X_B | X_A, target encoding (unit-edge pin + chain [2, 3]) | X_A, triangle pin | X_B, target encoding | colourable, target encoding |
|---|---|---|---|---|---|---|
| 1.0 | 7,879 | 8.30 / 8.33 | UNKNOWN (wall) [L7] | UNKNOWN (wall) [L1] | UNKNOWN (wall) [L3] | UNKNOWN (wall) [L5] |
| 1.1 | 11,539 | 10.57 / 10.64 | UNKNOWN [L6] | UNKNOWN [L4] | UNKNOWN [L9] | UNKNOWN [L8] |
| 1.2 | 16,381 | 12.79 / 12.90 | UNKNOWN [L10] | UNKNOWN [L11] | UNKNOWN [L12] | UNKNOWN [L12] |
| 1.3 | 22,453 | 14.73 / 14.91 | UNKNOWN [L1] | UNKNOWN [L2] | UNKNOWN [L3] | SAT 86.9 s [L4] |
| 1.4 | 30,181 | 16.60 / 16.83 | **UNSAT 983.4 s**; cad UNSAT 365.1 [L5] | **UNSAT 181.1 s**; cad 557.4 [L8] | **UNSAT 894.3 s**; cad 667.4 [L6] | SAT 15.2 s [L7] |
| 1.5 | 39,829 | 18.41 / 18.70 | UNSAT 167.9; cad 470.5 [L11] | UNSAT 161.0; cad 481.3 [L10] | UNSAT 129.0; cad 448.5 [L12] | SAT 4.9 [L9] |
| 1.6 | 51,493 | 20.00 / 20.34 | UNSAT 253.8; cad 104.7 [L12] | UNSAT 232.1; cad 335.3 [L12] | UNSAT 262.0; cad 142.1 [L12] | SAT 1.0 [L6] |
| 1.7 | 65,575 | 21.49 / 21.88 | UNSAT 465.2; cad 114.2 [L6] | UNSAT 155.9; cad 91.3 [L7] | UNSAT 189.0; cad 103.7 [L8] | SAT 2.2 [L9] |

Instrument controls (all pass): T5 and T7 SAT at 32 points and UNSAT at 33 under the target encoding (CaDiCaL agreeing), so the pins
and chain manufacture no refusal on a graph known colourable and keep the known refusal; the wall plant (3 s on the R = 1.0 colourable
ball) fired and was recorded UNKNOWN. Every SAT model was checked proper with its pins. Every colourable-family verdict is SAT or
UNKNOWN, never UNSAT (the family is four-colourable by Theorem B, so an UNSAT there would be a defect).

**Certification of the refusals.** At R ≥ 1.5 every X_A and X_B ball contains the K2-certified 2,044-point core (checked point by point,
column `contains_certified_core`), so those refusals are certified by containment. **The three refusals at R = 1.4 are not:** that ball
does not contain the core, so they rest on two solvers agreeing (kissat and CaDiCaL), not on a certificate. They need a K2 certificate
only if one enters a decision.

**What D0b measured** (each [measured], per family, contended times):
1. **`R*(X_A)` ≤ 1.4 under both encodings** (a refusal smaller than the certified core's ball: R = 1.4 < 1.4997), **and it is not
   bracketed from below.** No X_A, X_B or even colourable ask at R ≤ 1.2 (`d_ball` ≤ 12.8) decided within 1,800 s, and the forcing asks
   stayed undecided at R = 1.3 (`d_ball` 14.7), where the plain colourable ask took 87 s to answer SAT. The undecided band on this lattice,
   under this encoding and wall: `d_ball` 8.3 – 14.7 for the forcing families, 8.3 – 12.8 for the colourable one.
2. **The refusal at the threshold is the slow one** (G65's rank-4 four-colour instance): X_A (target) took 983 s at R = 1.4 and 168–465 s
   above; X_B 894 s at 1.4 and 129–262 s above.
3. **The triangle pin is worth 5.4× at the threshold and nothing clear above it**: X_A at R = 1.4, 181 s (triangle) against 983 s (edge
   pin + chain); at 1.5, 161 against 168. At ℚ(√47) (ω = 2) the triangle pin is unavailable, so the target's encoding is the slower one
   exactly where it matters.
4. **X_B against X_A, the one axis that differs (the number of v-edges):** both refuse at exactly the same radii (1.4 up) and neither
   decides at 1.3; CPU ratios X_B/X_A 0.91, 0.77, 1.03, 0.41 at R = 1.4 … 1.7 — within a factor of 3 at every radius (contended).
5. **Solver spread persists**: CaDiCaL was 2.7× faster than kissat at X_A's threshold (365 against 983 s) and 2.8× slower at R = 1.5.
6. `maxrss_mb` on these rows is **not** the solver's peak: each child was forked from a ≈ 2.5 GB parent holding every graph, and Linux
   counts the pre-exec pages; the probe (681 MiB at R = 1.7, from a small parent) is the solver's figure.

**Predictions scored** (contended times; the ladder's grid is 0.1 in R):

| id | outcome | verdict |
|---|---|---|
| PD-1 (0.85) X_A target refuses at R = 1.5 within 1,800 s | UNSAT 167.9 s | **won** |
| PD-2 (0.45) some R ≤ 1.4 gives SAT for X_A target | no SAT at any R | **lost** |
| PD-3 (0.6) least UNSAT radius for X_A target is 1.4 or 1.5 | 1.4 (1.3 UNKNOWN) | **won**, grid-limited |
| PD-4 (0.6) X_B refuses wherever X_A does, never slower | same radii; slower at 1.6 by 3 % (262.0 against 253.8 s, contended) | **lost**, narrowly and within the noise of contended times |
| PD-5 (0.4) X_A/X_B times within a factor of 3 wherever both refuse | 0.41–1.03 | **won** (contended; the quiet re-asks may move it) |
| PD-6 (0.6) colourable SAT within 60 s at every R ≥ 1.3 and UNKNOWN at 1.0 | 87 s at 1.3; UNKNOWN at 1.0 | **lost** (first half) |
| PD-7 (0.55) X_A target faster than triangle at R = 1.5 | 167.9 against 161.0 s | **lost**, within the noise; at 1.4 the triangle pin is 5.4× faster |
| P-D0 (0.5) rank-≥2 refusals decide within 1 h only above `d_ball` ≈ 12 | within 30 min only from 16.6 (X_A, X_B); 14.7 undecided at 30 min | **not scored**: the ladder's wall was 30 min, not 1 h; a 1-hour re-ask at R = 1.3 decides it |

## D1 — the screen at 47 (first pass; `tools/fs81_d47.py`, slots of one core each)

**The sweep** (564 s): 2,520 denominators; 116 candidates (every residue set at 11, 19, 23, 31, 43 refuses four colours and a 3-pole
exists) plus 11 left undecided by a residue set at the 120 s budget. **The screen** (additive; the float `Θ₄` finder capped at 60 s;
residue targets at every q < 100 over which 47 splits and at 47 itself, 120 s per ask; quotients `Λ/NΛ` for N ≤ 15, gap-aimed, 900 s
per lattice): **102 four-colourable** — every one with a witness K1 certifies (177 witnesses, 177 CERTIFIED, 0 failed:
`data/fs81/phaseD/d47/K1-checker-run.txt`), 49 of them with a gapped colouring (so every pair on them is free, G68) — and **25
survivors**. K1's gap branch had its first positive test here: Λ₁₆₈'s residue colouring at the ramified prime 47 (image 8 of the circle,
fan gap at the origin) CERTIFIED with its controls passing (`K1-first-gapped-controls.out`).

**The survivors, typed by the screens and caps they met** (full table with covolumes: `data/fs81/phaseD/d47/survivors.md`). Every
survivor: no additive colouring into ℤ/4 or V₄ exists (enumerated, exact); the float `Θ₄` finder hit its 60 s cap (CAPPED, not
EXHAUSTED: no cell found, none excluded); every residue target asked refused four colours or was UNKNOWN at 120 s (the UNKNOWN ones
are typed nulls, not refusals); every quotient asked at N ≤ 15 refused (UNSAT) except three UNKNOWNs (Λ₂₁₃₆ at N = 13, Λ₂₃₂₈ at N = 9)
and one budget stop (Λ₂₃₂₈). **None is called rigid**: no `Θ₄` cell has been computed for any of them (G73), and the quotients refute
only periodic colourings of those periods.

**Minimal survivors** (no survivor Λ_M′ ⊂ Λ_M, i.e. no survivor M′ | M): Λ₂₄₀, Λ₃₆₀, Λ₄₀₈, Λ₈₄₀, Λ₁₂₇₂, Λ₁₄₆₄, Λ₂₁₃₆, Λ₂₁₈₄,
Λ₂₃₂₈, Λ₂₄₂₄. P-D1 (at least one survivor, 0.7): **won**.

**Their price at `d*`** (G65: `N = π²R⁴/covol` at `g·φ(R)² = d*`; `d*` below): the cheapest is **Λ₂₄₀ (108 unit vectors, covolume
2.27·10⁻⁷): 5.1·10⁷ points at `d_ball` 18.41** (R = 1.041), then Λ₄₀₈ 2.0·10⁸, Λ₃₆₀ 2.6·10⁸, Λ₈₄₀ 3.5·10⁹, the rest 2·10¹⁰–2.5·10¹¹.
**PD-8 (some survivor within 10⁷ points, 0.25): lost.** The four-colourable Λ₁₂₀ was the only lattice below 10⁷.

## D2 — the handover (D2 goes to a successor; the owner's ruling)

**What is fixed for D2, each from a measurement above:**

| item | value | source |
|---|---|---|
| `d*` | **18.41** (X_A, target encoding, R = 1.5): the least `d_ball` at which X_A refuses within a quarter of the ladder's 1,800 s wall. The quiet re-ask at R = 1.4 (`d_ball` 16.60) took **462.7 s** (min of 3: 480.1, 462.7, 466.6), 2.8 % over the quarter (450 s), so by the letter `d*` stays 18.41; read at 16.60 instead, every price below falls by about 14 % | `d0b-reask.jsonl` tags `tA`, `dstar` |
| `t_A` | **55.41 s** CPU (min of 3: 56.03, 55.45, 55.41), X_A at R = 1.5 (`d_ball` 18.41, n 39,829, 4-core = the ball), kissat 4.0.4, target encoding, desktop; `slot.py --status` at each start recorded on its row (beside it: only this stage's two R = 1.3 long asks) | `d0b-reask.jsonl`, tag `tA` |
| the wall | **W = min(4·t_A, 6 h) = 221.6 s** | §S.D |
| the encoding | K2's CNF: a unit-edge pin (the ball's origin, colour 0; its least unit neighbour, colour 1) plus the chain [2, 3] over the unpinned colours; kissat 4.0.4; CNF on disk | `tools/fs81_phaseD.py` `cnf_clauses` |
| the survivor | **Λ₂₄₀** = Z⟨U₂₄₀⟩ over ℚ(√47): M = 240, 108 unit vectors, Hermite basis rows (over 240) (1,0,0,1), (0,1,1,0), (0,0,2,0), (0,0,0,2), covolume 2.27·10⁻⁷; the minimal survivor with the least `N(d*)`; `g` = 108 > `d*` | `data/fs81/phaseD/d47/survivors.md` |
| its ball | the embedding-bounded ball (both real embeddings of (x, y) within R), as `fs73_screen.minkowski_ball` builds it on `fs81_d47.lattice_M(240, units_M(240))`; **R = 1.0411 for `d_ball` = 18.41: N ≈ 5.1·10⁷ points** (G65's law, not yet built) | `fs81_d47.price` |

**The obstruction the successor meets first, stated before any solve (the brief invited an obligation that cannot be met).** §S.D's
price needs a matched control with `n` within a factor of 2. At `d*` Λ₂₄₀'s ball has ≈ 5.1·10⁷ points against X_A's 39,829: **a factor
of 1,284**, and no X_A ball has `d_ball` ≈ 18 at 5·10⁷ points (X_A's balls grow in degree with radius: 21.5 at 65,575 points). The other
direction fails too: at sizes a solver can hold, Λ₂₄₀'s ball sits at low degree — `d_ball` ≈ 3.3 at 1.05·10⁷ points (R = 0.7), 7.3 at
1.8·10⁷ (R = 0.8, the hardness peak), 11.8 at 2.9·10⁷, 16.5 at 4.35·10⁷ (G65's law) — so every buildable ask lands in or below the
undecided band X_A itself shows (`d_ball` 8.3–14.7). And the D2 ask at `d*` (≈ 2·10⁹ clauses, tens of GB of DIMACS) cannot be parsed
within W = 221.6 s: its UNKNOWN would measure the parser, not the band (G21). **So, as specified, D2 cannot produce a price that
discharges its five obligations.** Three ways forward, for the owner:
1. **Report the price as the size ratio itself**, with no solve: "reaching X_A's refusal degree over ℚ(√47) costs ≥ 1,284 times X_A's
   points on the cheapest minimal survivor (≥ 5,000 times on the next two)" — [measured] arithmetic, carried from X_A as a [reading].
2. **Pose a denser object**: a sublattice-free shape of Λ₂₄₀ (a word ball is excluded by §B.1.1, since G65's law does not describe it),
   or the finite quotients — which refuse at every N ≤ 15 tried, and prove only that no N-periodic colouring exists.
3. **The chain route (G55)** on a survivor that stays rigid after its `Θ₄` cells are computed, which needs no ball.

**What D1 leaves for the successor:** the deep pass (`fs81_d47.py screen --ids survivors`), the UNKNOWN residue targets re-asked at a
longer budget (`fs81_d47.py recheck --budget 600`), and P3b's calibrated exact `Θ₄` finder and cell analysis on the ten minimal
survivors (a copy of `tools/fs79_p3b_theta4.py` with D = 47 and its output under `data/fs81/phaseD/d47/p3b/`) — no survivor is called
rigid before its cells are computed (G73).

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

**D0b, the ladder** (the machine's resource rule of 2026-09-24: RAM is rationed through `scripts/slot.py`, threads are not; CNFs and
solver logs go to disk under `~/fs81-phaseD-work/`, never /tmp; one JSONL row per ask appended with fsync to
`data/fs81/phaseD/d0b-asks.jsonl`). **Measured before sizing:** at the largest radius, R = 1.7, X_B has 65,575 points and 717,523
edges (`d_ball` 21.88), its CNF 3,066,820 clauses (51 MiB), and kissat refused it in 82.3 s CPU at a peak RSS of 681 MiB (a probe
under `slot.py --mem 8 --cpus 1`). Twelve workers × 681 MiB × 1.5 ≈ 12 GiB for the solvers, plus the parent's graphs (≈ 2 GiB) and up to
twelve transient clause lists being written (≈ 4 GiB): `--mem 24`.

```
cd /home/kooshi/source/lean-dir
setsid nohup python3 scripts/slot.py --mem 24 --cpus 12 --name d0b --wait 1800 -- \
    python3 tools/fs81_phaseD.py ladder --workers 12 --wall 1800 >> data/fs81/phaseD/d0b-run.log 2>&1 &
```

*If it dies at any instant, what is redone:* the asks in flight (at most twelve, each at most 1,800 s of kissat plus, for an UNSAT,
one CaDiCaL re-ask), because a row is written only when its ask ends; the graphs are rebuilt in seconds. *Resume:* the same command —
it skips every key already in the JSONL with a verdict. *Exit status:* 75 = not admitted within the wait (nothing ran); 137 = killed
by its RAM cap (raise `--mem` from the measured peak, never guess). The pgid of the `setsid` child goes to `data/fs81/phaseD/d0b.pgid`;
a kill is by that group, verified by the pid absent from `ps` and the JSONL static for ten seconds.

**The R = 1.3 long re-asks** (the owner's decision: now, beside D1, two pinned single-core asks, a 4-hour wall, marked contended):

```
cd /home/kooshi/source/lean-dir
for k in 'X_A|target|R1.3' 'X_B|target|R1.3'; do n=$(echo "$k" | cut -d'|' -f1)
  setsid nohup python3 scripts/slot.py --mem 3 --cpus 1 --name "d0b-long-$n" --wait 1800 -- \
    python3 tools/fs81_phaseD.py reask "$k" 1 14400 --contended --tag=long-R1.3 >> "data/fs81/phaseD/d0b-long-$n.log" 2>&1 &
done
```

*What a kill redoes:* the one ask (a row is written when it ends). *Resume:* the same loop (a recorded (key, tag, wall) is skipped).

**The certificate for R*(X_A) ≤ 1.4** (the owner's request: the X_A target-encoding refusal at R = 1.4 through K2 and cake_lpr):

```
cd /home/kooshi/source/lean-dir
setsid nohup python3 scripts/slot.py --mem 16 --cpus 1 --name d0b-cert14 --wait 1800 -- \
    python3 tools/fs81_phaseD.py certify 'X_A|target|R1.4' 7200 >> data/fs81/phaseD/d0b-cert14.log 2>&1 &
```

*What a kill redoes:* all of it (CaDiCaL ≈ 6–8 min, the trim, K2's check); the proof lives on disk in `~/fs81-phaseD-work/` while it is
made, and the trimmed certificate in `data/fs81/phaseD/cert-X_A-target-R1.4/`.

**D1, the screen at 47** (`tools/fs81_d47.py`, a copy of FS-79's `fs79_p0.py` at d = 47; writes `data/fs81/phaseD/d47/`):
each step resumable by re-running (every record keyed and skipped when present; a kill redoes the one denominator or screen in flight):

```
cd /home/kooshi/source/lean-dir
setsid nohup python3 scripts/slot.py --mem 4 --cpus 1 --name d1-sweep --wait 1800 -- \
    python3 tools/fs81_d47.py sweep --mmax 2520 >> data/fs81/phaseD/d47/sweep-run.log 2>&1 &
```

The sweep finished in 564 s: 2,520 denominators, **116 candidates** plus 11 left undecided by a residue set (127 lattices to screen),
listed cheapest first by G65's price in `data/fs81/phaseD/d47/screen-ids.txt`, split round-robin into three lists (one per line).
The screen's first pass, three processes in three slots (each one core, 12 GiB for the N ≤ 15 quotient CNFs):

```
for i in 1 2 3; do ids=$(sed -n "${i}p" data/fs81/phaseD/d47/screen-ids.txt)
  setsid nohup python3 scripts/slot.py --mem 12 --cpus 1 --name d1-screen-$i --wait 1800 -- \
    python3 tools/fs81_d47.py screen --ids "$ids" --theta_cap 60 --quot_total 900 --quot_nmax 15 --budget 120 \
    >> data/fs81/phaseD/d47/screen-run-$i.log 2>&1 &
done
```

*A kill redoes* the lattice in flight in that process (every screen of a lattice is a keyed row in `screen.jsonl`, skipped when
present; a quotient ask is a keyed row in `quotients.jsonl`). *Resume:* the same loop. The deep pass on the survivors
(`screen --ids survivors`) follows, then P3b's calibrated `Θ₄` finder and the cells.
