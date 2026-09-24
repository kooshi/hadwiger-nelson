# FS-81 stage D — ℚ(√47) at four colours, calibrated first: the record

*Implementer: de Bruijn (Opus 5.5), from the owner's brief of 2026-09-24. Spec of record: `plans/FS81-quadratic-four-colours.md` §S.D,
with §B.1–§B.3 behind it. Machine for every number below: the desktop (16 physical cores / 32 threads, 128 GB).
This file is kept current enough that a successor can resume from the repository alone (§ Resume).*

## Status

| step | state |
|---|---|
| DK — the two checkers | built; self-tests pass (`data/fs81/phaseD/dk-selftest-*.out`); **awaiting the owner's plant** on each before any verdict they check is believed |
| D0a — the harvest | not started |
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
   for clause); (b) under a unit-edge pin plus the chain [2, 3] with a fresh CaDiCaL LRAT. The class the spec named — a unit-distance
   graph over ℚ(√d) refusing four — still has no positive control, so the second checker stays mandatory for any D refusal.

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
`env -u LIBRARY_PATH make`, since the Lean toolchain's library path breaks the link) — must print `s VERIFIED UNSAT`; kissat must refuse
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

## Theorems this phase proved

| id | statement | grade | proof |
|---|---|---|---|
| D-T1 | Value precedence over **unpinned** colours, encoded by the auxiliary chain s(0..n), is a sound symmetry reduction under any clique pin and any vertex order; a chain touching a pinned colour is not (it forbids colourings no permutation repairs unless the pinned clique comes first in the order) | [hand] | K2's docstring, step 4; this record, K2 |
| D-T2 | De Grey's lattice point (a + bζ₆ + cw + dζ₆w)/9 is ((4a + 2b + 2c + d − d√33)/36, ((2b + d)√3 + (2c + d)√11)/36) | [hand + tools exact] | `tools/fs81_phaseD.py` `oe_to_k2`; K2 re-derives exactly fs73's 10,703 unit edges from the converted points and rebuilds fs73's CNF byte for byte (sha256 `65d3897d…`) |
| D-T3 | An additive four-colouring of a non-bipartite lattice unit-distance graph is gap-free at every vertex | [hand] | φ(−u) = −φ(u), so φ(U) is a symmetric subset of ℤ/4∖{0} or V₄∖{0}; a two-element symmetric one gives a proper 2-colouring |

## Resume

*(Written before the first long run; see D0b.)*
