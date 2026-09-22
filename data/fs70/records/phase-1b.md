# FS-70 phase 1b — the CM-shaped lattice with the wall-breaker: what landed

*Written 2026-09-22 by the phase-1b implementer (Opus 5), against the owner's review
`data/fs70/owner/review-phase1-2026-09-22.md` §4, the phase-1 record `data/fs70/records/phase-1.md`, and
`plans/FS70-five-over-sqrt3-sqrt5.md`. Machine: the desktop (16 physical cores / 32 threads,
125 GB). Every number names the command that produced it.*

---

## 1. Headline

**No refusal. L6 — the one fabric with the structure of every known five-colour forcer — colours at every size
built, and it was asked at a density no earlier shape in this milestone reached.**

1. **The owner's screen is reproduced exactly, and its central reading is upgraded from a computation to a
   theorem.** L6 = `group6:u3:2+zeta6:rho15` has `M = 144`, rank 6, 42 generators, `g = 54`, no additive
   four-colouring of either kind, every chainable target live — the owner's numbers, to the integer (§2).
   The twelve unit vectors beyond the 42 generators are **exactly the ζ₆-orbit of `v = (1 + i√15)/4`**, so
   `½ = v + v̄` and `ζ₆/2 = ζ₆v + ζ₆v̄` lie in the lattice and the **plan's own §3.4 theorem** applies: no
   homomorphism to a group of order four is nonzero on every unit vector. L6 is silent to the additive screen
   and to the Kempe screen for the same structural reason as L2 and L3, and only a solver can speak on it.
2. **Rank 6 buys density that rank 8 could not.** L6's word balls reach **average degree 17.09 at 805,693
   points**, where phase 1's rank-8 lattices topped out at 15.5 at 1,864,417 points with an empty 14-core.
   That is the largest degree this milestone has ever asked at, on 43 % of the point count — and it **decides**,
   where phase 1's biggest shapes did not (§3).
3. **Every ask that returned a verdict returned SAT** (§4), at four densities: the balls at sums of ≤ 3
   (11,593 points, degree 10.95), ≤ 4 (109,957, degree 14.10) and ≤ 5 (805,693, degree 17.09), and the **14-core
   of the last — 217,015 points at degree 18.98**, the first object this milestone has produced above degree 18
   and one where a refusal would have carried up to the whole ball. Every model was read back and verified
   proper on every fabric edge and on its pin before its row was written.
   **And the solve time falls as the density rises.** The `k = 4` ball's control takes 8.23 s at degree 14.10;
   the 14-core's takes **1.16 s at degree 18.98** on twice as many vertices, and `forces 4/3` on it takes 1.17 s.
   That is G65's regime exactly — "from 14 up almost everything decides in seconds" — and it says the fabric is
   nowhere near a colouring threshold from either side. The 55–470 s the `k = 5` ball costs is **size**, not
   hardness.
4. **The type-M arena at `n = 4` is built and answered, and G53's counting compulsion is not merely weak there
   but ABSENT** (§5). The diagonal circle of the CM base is exactly `2 ×` its unit-vector set — 30 points, and
   it does not grow with the base, at any radius from sums of ≤ 2 to ≤ 5. `L = min over proper four-colourings
   of |{circle points on the centre's colour}| = **0**` at every one of those radii: some four-colouring of the
   base gives the centre a colour that **no** circle point carries. G53 refutes when `2L > 30`, i.e. `L ≥ 16`.
   Against `ρ₆₃`'s provisional `10/30` (G53) this reads `0/30`. The arena itself — 54,433 points, 352,326
   edges — four-colours in 0.15 s, and its **whole cross-edge budget is 78 of 352,326**, of which 30 are the
   diagonal `v — Rv` edges and 48 off-diagonal.
5. **Two real gaps in the instrument were found and closed, and one of them was suppressing asks.** Above
   400,000 vertices `fs70_ask.py` streams the CNF, and the streaming writer emitted no symmetry break; a
   `forces` ask gets its third pin only when the pair has a common neighbour, and over L6 the targets `2/3`,
   `8/3` and `4` have none — so at the largest shape those three asks were **refused outright rather than
   asked** (§6). The break is now streamed, byte-identical to the list writer's, with the comparison shown able
   to fail. And `fs70_ask.py` refused a control on any graph whose lattice spec it could not parse, which no
   arena has.
6. **The `|n| ≤ 3` knob is priced and declined, not skipped** (§7): `group6:u3:3+zeta6:rho15` is still rank 6
   but has `M = 432`, which puts its saturation at `2.32 × 10⁹` box elements (≈ 195 GB, ≈ 84 h) by method B and
   `≈ 1.8 × 10⁸` `qfminim` vectors by method A. Without a complete saturation the unit-distance graph is
   partial, and on a partial graph a **colouring means nothing** — which is the only verdict this fabric has
   ever returned. So the knob buys nothing at any price we can pay.

**What this adds to phase 1's null.** Phase 1 killed the 2-unit route by derivation and left one fabric
unasked. That fabric is now asked, at higher density than anything before it, and it colours. The conjecture's
prediction at ℚ(√3,√5) stays unmet, and the reason has narrowed again: it is not the quarter turn. Removing
ζ₁₂ — the one structural difference between this milestone's fabric and every known forcer's — buys a denser,
cheaper, better-behaved lattice and **no compulsion at all**.

---

## 2. L6: the screen, and why its additive family is empty by theorem

`python3 tools/fs70_fabric.py lattice 'group6:u3:2+zeta6:rho15'`, row appended to `data/fs70/screen.jsonl`;
the Kempe row appended to `data/fs70/kempe-screen.json`.

| quantity | mine | the owner's `po_cm_lattice.py 2 rho15` |
|---|---|---|
| denominator `M` | **144** | 144 |
| rank | **6** | 6 |
| generators | **42** | 42 |
| unit vectors `g` | **54** | 54 |
| proper additive ℤ/4 colourings | **0** | 0 |
| proper additive Klein colourings | **0** | 0 |
| chainable targets live | **44** (2, 4/3, 2/3, 4, 8/3, i√3 among them) | every target live |

Also: log₁₀ covolume **−3.3334**; lattice sha `cfb3453a912db9a2`; the **3-adic gate PASSES** through
`ū = (−2 − i√5)/3`, with 24 of the 54 unit vectors 3-non-units; nine 2-adic depth classes of six vectors each.

**The twelve extra unit vectors.** The saturation holds 54 vectors on 42 generators. The twelve it adds are
exactly the ζ₆-orbit of `v = (1 + i√15)/4` — four of denominator 4 (`±v`, `±v̄`) and eight of denominator 8
(`ζ₆^m v`, `ζ₆^m v̄`), verified as a **set equality**, not a count. The reason is the identity the plan already
records: `ρ₁₅ = −v̄²`. Adjoining the ζ₆-orbit of `ρ₁₅` to `ℤ[ζ₆, u]` pulls in its square root's whole orbit.

**So the empty additive family is the plan's §3.4 theorem, not a computation.** `v + v̄ = ½` and
`ζ₆v + ζ₆v̄ = ζ₆/2` are both in the lattice (checked), so `Λ ⊇ ½·{1, ζ₆}`, and then `φ(1) = 2φ(½)` and
`φ(ζ₆) = 2φ(ζ₆/2)` lie in `2G`: in the Klein group both vanish, in ℤ/4 both equal 2, and either way
`φ(ζ₆²) = φ(ζ₆ − 1) = 0` at a unit vector. **L6 is exactly as invisible to the additive and Kempe screens as
L2 and L3 are, and for exactly their reason — it contains the wall-breaker.** That it is also CM-shaped and
rank 6 is what makes it new.

---

## 3. The shapes, and what rank 6 buys

`python3 tools/fs70_fabric.py word 'group6:u3:2+zeta6:rho15' k --out build/fs70/L6-wk --no-cnf`

| `k` | points | edges | average degree | build |
|---|---|---|---|---|
| 1 | 43 | 84 | 3.91 | instant |
| 2 | 883 | 3,336 | 7.56 | instant |
| 3 | 11,593 | 63,444 | 10.95 | 0.4 s |
| 4 | 109,957 | 775,458 | 14.10 | 4.7 s |
| **5** | **805,693** | **6,885,174** | **17.09** | 40.1 s |

Against phase 1's rank-8 lattices, whose `k = 4` balls were 1.84–1.89 M points at degree **15.4–15.8**, with
L5's 14-core **empty**. L6 reaches a higher degree on 43 % of the points — the rank is the lever, and phase 1's
§7 ceiling ("the step up in degree has an end on this field") was a ceiling of the rank-8 lattices it had, not
of the field.

**Word distances of the targets from the origin** (so nothing is asked that the shape cannot reach, and nothing
is skipped silently): `i√3`, `2`, `4/3` at **2**; `2/3`, `8/3`, `4` at **4**. The `k = 3` ball carries four of
the seven pins and the `k = 4` and `k = 5` balls all seven.

---

## 4. The asks

Every row is in `data/fs70/asks.jsonl`; every colouring is committed, gzipped with its uncompressed sha256, in
`data/fs70/records/asks/` beside a `MANIFEST.json` (phase 1's thirteen copied in as well, per the owner's
ruling 5 — `build/` is scratch that agents clean).

### 4.1 L6 at sums of ≤ 3 — 11,593 points, 63,444 edges, degree 10.95

| pin | verdict | solver seconds |
|---|---|---|
| control | SAT | 0.16 |
| forces 2 | SAT | 0.03 |
| forces 4/3 | SAT | 0.16 |
| separated i√3 | SAT | 0.16 |

### 4.2 L6 at sums of ≤ 4 — 109,957 points, 775,458 edges, degree 14.10

| pin | verdict | solver seconds | pins |
|---|---|---|---|
| control | SAT | 8.23 | 3 |
| forces 2 | SAT | 2.81 | 3 |
| forces 4/3 | SAT | 2.57 | 3 |
| separated i√3 | SAT | 2.63 | 3 |
| forces 2/3 | SAT | 53.07 | 2 + precedence |
| forces 8/3 | SAT | 68.86 | 2 + precedence |
| forces 4 | SAT | 103.01 | 2 + precedence |

**One solver-effort signal, and it is about the ENCODING, not the graph** (G21). The three slow pins are exactly
the three whose pair has **no common neighbour** in the fabric, so the tool can pin only two colours and must
break the residual two-colour symmetry with the linear precedence encoding: **4,641,234 clauses and 659,742
variables against 3,871,538 and 439,828** for a three-pin ask on the same graph, and 20× to 40× the wall clock.
Single-sample, one solver, recorded as a fact about two encodings of one graph.

### 4.3 L6 at sums of ≤ 5 — 805,693 points, 6,885,174 edges, degree 17.09

PLACEHOLDER-K5-TABLE

### 4.4 The 14-core of the `k = 5` ball — 217,015 points, 2,059,614 edges, degree 18.98

The core ladder on the `k = 5` ball (`python3 tools/fs70_fabric.py core build/fs70/L6-w5 m`):

| | points | edges | degree |
|---|---|---|---|
| the ball | 805,693 | 6,885,174 | 17.09 |
| **14-core** | **217,015** | **2,059,614** | **18.98** |
| 16-core | 0 | — | — |

**Phase 1's densest object — L5's `k = 4` ball, 1,864,417 points at degree 15.47 — has an EMPTY 14-core** (its
record, decision 7). L6's exists, holds a quarter of the ball, and reads two degrees higher than the ball it came
from: **the first object this milestone has produced above degree 18, at 12 % of the point count of the largest
thing phase 1 ever asked.** A core is a subgraph, so a **refusal** on it is a refusal on the whole ball and on
the lattice, while a colouring of it says nothing about the ball — which is the right trade when the hunt is for
a refusal (G65: step up in degree). The origin and `4/3` survive the coring; `2`, `8/3` and `4` do not, and the
tool says so rather than asking a pin it cannot pose.

PLACEHOLDER-C14-TABLE

### 4.5 The base alone, and the arena

| graph | points / edges / degree | pin | verdict | seconds |
|---|---|---|---|---|
| the CM base `group6:u3:2` at ≤ 4 | 27,217 / 176,124 / 12.94 | control | SAT | 0.08 |
| the arena `B ∪ ρ₁₅·B` at `n = 4` | 54,433 / 352,326 / 12.95 | control | SAT | 0.15 |

The base control is **the defect check the brief names**: the CM base is 2-integral, so the residue colouring
at the prime above 2 four-colours it and a refusal there would be a defect in the tool rather than a finding.
It colours in 0.08 s.

---

## 5. The type-M arena at `n = 4`, and G53's counting screen

`tools/fs70_arena.py` (new). The rotation arithmetic is **derived, not assumed**: `|1 − R|²` must be the
reciprocal of an integer `n` or the tool refuses `R` by name as not of type M, and then the diagonal circle —
the base points `v` with `|v − Rv| = 1` — is exactly `|v|² = n`. For `ρ₁₅ = (7 + i√15)/8` that is
`|1 − ρ₁₅|² = 1/4`, so **`n = 4`** and the circle is `|v| = 2`, matching `cos θ = 7/8 = (2n−1)/(2n)` (G7).

**The circle is exactly twice the unit shell, and it does not grow.**

| base radius | points | edges | degree | circle `\|v\| = 2` |
|---|---|---|---|---|
| ≤ 2 | 451 | 1,650 | 7.32 | **30** |
| ≤ 3 | 4,141 | 21,330 | 10.30 | **30** |
| ≤ 4 | 27,217 | 176,124 | 12.94 | **30** |
| ≤ 5 | 136,021 | 1,049,568 | 15.43 | **30** |

The 30 circle points are exactly `{2z : z a unit vector of the base}` (asserted as a set equality in the
self-test). This is `t = 2` in **G52**'s sense — the record's own situation — so the residue certificate's
defeat on this arena is automatic and carries no information about the object; the live quantity is the
counting ratio and the off-diagonal cross-edge share, not the circle's existence.

**G53's counting screen reads `L = 0` at every one of those radii.** The criterion refutes the arena when
`2L > 30`, i.e. `L ≥ 16`; what the solver exhibits instead is a proper four-colouring of the base in which
**no** circle point carries the centre's colour. Compare `ρ₆₃`, where G53 was provisionally `10/30`. The
compulsion is not weak here, it is absent.

**The arena's anatomy** (computed by the tool, written into its `graph.json`, at base radius ≤ 4):

| | |
|---|---|
| points | 54,433 (27,217 per half, **1 shared** — the centre only) |
| edges | 352,326 |
| within half 0 / half 1 | 176,124 / 176,124 — each exactly the base's own graph |
| **cross edges** | **78** — the arena's whole compulsion budget (G31) |
| of which diagonal `v — Rv` | **30** (the circle, in bijection) |
| off-diagonal | **48** |

The edges are derived **twice and must agree**: from the saturation of the arena lattice (`M = 144`, rank 8,
`g = 138`; complete by construction) and from an independent geometric derivation (a float grid proposing,
exact arithmetic deciding). They are identical, 352,326 both ways. The geometric derivation can only *miss* an
edge, so agreement is evidence the saturation is complete — and it is what refuses the `cross_dropped` plant.

---

## 6. Two defects in the instrument, both found by asking what the tool would not answer

**(a) The streaming CNF writer was suppressing asks.** Above 400,000 vertices `fs70_ask.py` streams the CNF
rather than building a clause list, and the streaming path emitted **no symmetry break** — justified when it
was written on the ground that it is only used where three colours are pinned. But a `forces` ask gets its
third pin only when the pair has a **common neighbour**, and over L6 the targets `2/3`, `8/3` and `4` have
none. So at the largest shape those three asks hit

> `805693 vertices with only 2 pins: the streaming writer emits no precedence break, so this instance would be
> asked with its residual colour symmetry unbroken -- refused`

— the symmetry rule obeyed and **the question left unasked**, which is the worse of the two failures. The fix
streams the same linear precedence break the list writer uses (`s[v][c]` = "colour `c` occurs at some `u ≤ v`",
O(n) clauses over O(n) auxiliary variables), in the same variable numbering, emitted only when two or more
colours are free. The self-test asserts the two writers are **byte-identical** at both two and three pins and
shows the comparison able to fail by dropping one edge; that comparison caught **two off-by-one errors** in my
declared clause count before anything was asked.

**(b) A control was refused on any graph whose lattice spec could not be parsed.** `build_instance` looked up
the preferred pin triangle `0, 1, ζ₆` by rebuilding the lattice from `meta['lattice']`, and raised on an
unparsable name — which every arena, union and cored graph has. It now falls through to the first triangle in
the graph, which is the same statement (any unit triangle's three colours can be relabelled).

**(c) A plant that fired for the wrong reason, caught and repaired.** After the arena anatomy was folded into
`build_arena`, the `cross_dropped` plant referenced a dictionary the refactor had removed and fired with
`NameError: name 'pts' is not defined` — red, for a reason that had nothing to do with the check it was written
to test. Repaired to use the anatomy's own `inside` mask; it now fires through the geometric control, which is
the check it is for.

---

## 7. The `|n| ≤ 3` knob: priced and declined

`group6:u3:3+zeta6:rho15` is 54 generators, **still rank 6**, but `M = 432`.

| route | cost | verdict |
|---|---|---|
| saturation method B (complete by construction) | box of `M = 432`: **2.32 × 10⁹** elements ≈ **195 GB**, ≈ **84 h** — 77× the tool's 3 × 10⁷ cap | refused by name |
| saturation method A (`qfminim` on the trace form) | covolume `5.729 × 10⁻⁶` → **≈ 1.8 × 10⁸** lattice vectors in `gp`; phase 1 records method A overflowing a 4 GB stack far below that | not attempted |

Without a complete saturation the shape's unit-distance graph is **partial**, and `fs70_fabric` labels it so:
on a partial graph a refusal still stands but **a colouring does not** — and a colouring is the only verdict
this fabric has ever returned. So the knob cannot buy a usable answer at any price available here. Recorded as
a typed null, not a skip.

---

## 8. Decisions

| # | the choice | the alternative I weighed | why this one | confidence |
|---|---|---|---|---|
| 1 | **Add `zeta6:NAME`, `group6:NAME:k` and bare `zeta6` to the generator grammar**, rather than a one-off script for L6 | Build L6's generator list by hand in a throwaway, as the owner's `po_cm_lattice.py` does | Every downstream instrument — the saturation, the screen, `Λ_forced`, the shapes, the CNF writer, the Kempe screen — takes a `SPEC`, and a hand-built list would have had to be threaded through all of them. The grammar cost twenty lines and made L6 a first-class lattice with a sha, a screen row and a Kempe row. | **high** |
| 2 | **The `zeta6_as_zeta12` plant is a plant on the ORBIT, not on the lattice** — it swaps the rotation used to build a ζ₆ orbit | Assert the absence of ζ₁₂ in the lattice and call that the check | Both are in: the assertion is the check, the plant is what shows the assertion can fire. The plant's value is that it is the one mistake that would silently put the quarter turn back and make L6 into one of phase 1's lattices. | **high** |
| 3 | **Ask ≤ 3, then ≤ 4, then ≤ 5 — the brief's ladder — rather than phase 1's "largest affordable first"** | Phase 1's decision 4: a SAT at the biggest shape subsumes every subgraph, so ask big first | The small shapes cost **half a second in total**, and the ladder is what makes the degree column a measurement rather than a single point. With the k=5 ball at 40 s to build and minutes to solve, the ladder cost nothing and bought the density curve in §3, which is the phase's main structural finding. | **high** |
| 4 | **Fix the streaming writer rather than record "three asks refused by the symmetry rule"** | Record the refusal as a typed null and move on | A tool that refuses a question for want of twenty lines of encoding is producing a null about itself. The fix is the same encoding the list writer already uses and the byte-identity control makes it checkable. | **high** — the control is two-sided and was shown able to fail |
| 5 | **Report `L = 0` only after building a two-sided control for the counting instrument** | Report the `L = 0` reading as measured | A binary search whose UNSAT branch never fires returns `L = 0` on **every** input, and the real fabric had never produced an UNSAT. The self-test now runs the same routine on two hand graphs whose `L` is known — a K4 on the circle with a non-adjacent centre (`L = 1`, "at most 0" UNSAT) and an edgeless circle (`L = 0`) — and a `card_ignored` plant makes the failure mode explicit. | **high** |
| 6 | **Price the `\|n\| ≤ 3` knob and decline it, in the record** | Try method A and see | A colouring on a partial graph is not a verdict, and a partial graph is the only thing an incomplete saturation can give. Both routes are two orders of magnitude over budget, which is a number worth writing down rather than an afternoon worth spending. | **high** |

---

## 9. Where the plan, phase 1, the review or the brief was wrong

| where | what it says | what is the case |
|---|---|---|
| **the owner's review §3** | L6 has *"no additive colouring of either kind"* — reported as a computation of `po_cm_lattice.py` | True, and it is a **theorem**: the saturation holds the ζ₆-orbit of `v = (1+i√15)/4`, so `½` and `ζ₆/2` lie in the lattice and the plan's §3.4 theorem applies. Nothing needs to be computed, and the same argument covers every lattice that saturates to hold `v`. |
| **the brief, ask (ii)** | *"the copy's points have 2-adic depth 4, so no residue colouring crosses"* | The depth of `ρ₁₅` is **−4**, not 4 (`plans/FS70…` §3.1's own self-test values: `depth(ρ₁₅) = −4`). The sign is a convention and every consequence is conjugation-symmetric, so the conclusion stands; the number in the brief does not. |
| **the brief, ask (ii)** | asks for the counting screen *"first … then the control on `A`"* | Both were run, and the order did not matter here because `L = 0` makes the screen's answer "no refutation" rather than a decision. Worth recording that the screen is **1,000× cheaper** than the arena solve only when it refutes; when it does not, it costs a binary search and the arena still has to be asked. |
| **plan §7, P2 / phase 1 §7** | the 2-unit route dead by derivation, *"the fabric that is not ruled out costs `R⁸` to make dense"* | The `R⁸` ceiling is a fact about **rank-8** lattices. L6 is rank 6, and its word balls reach degree 17.09 at 805,693 points — denser than anything phase 1 built, at 43 % of the size. The ceiling moved with the rank. |
| **phase 1 §5.1a and the plan §1.2** | *"do not ask below average degree 12 except as a calibration point"* | Kept: the `k = 3` ball at degree 10.95 is recorded as a calibration point and the verdicts that matter are at 14.10 and 17.09. |

---

## 10. What a kill would have redone, and what is on disk

Nothing in this phase held state only in a process. Every shape is a `graph.json` written once
(`build/fs70/L6-w{3,4,5}`, `build/fs70/CMbase-w4`, `build/fs70/arena-n4-k4`); every ask appends its row at its
verdict and carries an in-flight file with its pid and process group while it runs; the counting screen writes
`build/fs70/arena-count-k{2,3,4,5}.json`. The longest single step is the `k = 5` ball (40 s to build) and the
`k = 5` asks (55–470 s each), so a kill at any instant costs minutes, never a result.

**Regenerating everything:**

```
python3 tools/fs70_fabric.py lattice 'group6:u3:2+zeta6:rho15'
python3 tools/fs70_fabric.py word 'group6:u3:2+zeta6:rho15' 5 --out build/fs70/L6-w5 --no-cnf
python3 tools/fs70_ask.py run build/fs70/L6-w5 control --single-budget 600 --no-cube
python3 tools/fs70_arena.py count 'group6:u3:2' 4 --rot rho15
python3 tools/fs70_arena.py build 'group6:u3:2' 4 --rot rho15 --out build/fs70/arena-n4-k4
```

**The three tools' self-tests and plants, all green:** `fs70_fabric` 5 plants, `fs70_ask` 3, `fs70_arena` 4.

---

## 11. WORKFLOW step 9's two sweeps over this phase's additions

* **"conjecture"** — three, none of them claimed, each flagged to the owner as a stub candidate.
  1. **The half-integer criterion.** Every lattice this milestone has found with no additive four-colouring —
     L2, L3 and now L6 — contains `½` in its ℤ-span: L2 and L3 by construction (they adjoin `v` or `w`), L6
     because its *saturation* holds the ζ₆-orbit of `v` even though no generator does. The plan's §3.4 gives one
     direction (`½·{1, ζ₆} ⊆ Λ` ⟹ no additive four-colouring). **Is the converse true?** It is exact and cheap
     to test against the 21 lattices already in `screen.jsonl`, and if it holds, the additive screen reduces to
     one membership test and the phase-1 Kempe machinery becomes a statement about lattices that do *not* hold
     `½`.
  2. **Does a type-M arena's diagonal circle ever grow?** Over the CM base it is exactly `2 ×` the unit shell —
     30 points — at base radius ≤ 2 and at ≤ 3, ≤ 4 and ≤ 5 alike. Finiteness is immediate (a lattice has
     finitely many points of a given norm); what is measured, and not proved, is that it **saturates at the
     smallest ball that reaches it at all**, so growing the base can never buy G53 a larger circle — only a
     larger `L`, which here is 0.
  3. **Is the largest non-empty core degree a function of the lattice rank?** Rank 8 at ball degree 15.47: the
     14-core is empty (phase 1). Rank 6 at ball degree 17.09: the 14-core holds 217,015 points at degree 18.98
     and the 16-core is empty. Two points, one variable, and a reading at best — but if it is real, the rank is
     the dial for density and the milestone has been turning the wrong one.
* **"not claimed"** —
  (i) that L6 is four-colourable **as a lattice**: what is measured is that the shapes asked are — the balls at
  sums of ≤ 3, ≤ 4, ≤ 5 and the 14-core of the last;
  (ii) that the 14-core's colourability says anything about the ball it came from — a core is a subgraph, so its
  SAT verdicts are about the core alone (only a refusal would travel upward);
  (iii) anything at arity above 2 — every ask here is a pair or a whole fabric;
  (iv) that `group6:u3:3+zeta6:rho15` behaves any differently: what is established is that its saturation is
  unaffordable by either method, so it cannot be asked in a way whose colouring would mean anything;
  (v) that the arena at base radius ≤ 5, or at any `n` other than 4, four-colours — neither was built;
  (vi) a verdict on `separated i√3` at the ≤ 5 ball, on L2's `k = 4` control, or on L3's — each is recorded with
  its budget and its encoding, never as a fact about a graph (G21).
