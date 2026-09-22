# FS-70 phase 0 — the fabric: what landed

*Written 2026-09-21 by the phase-0 implementer (Opus 5), against `plans/FS70-five-over-sqrt3-sqrt5.md` §4 phase 0
and the owner's brief. Every number below names the command that produced it. Machine: the desktop (16 physical cores / 32 threads, 125 GB). Nothing in this phase asks the milestone's own question — phase 1
does that; phase 0 builds the instruments and the screens that say where an ask is worth running, and proves each
instrument can fail.*

---

## 1. Headline

Every acceptance criterion of phase 0 is met, and three things changed.

1. **The plan's §2.2 screen table is reproduced exactly** — all seven rows, every count, and every covolume of
   §2.4 — and extended to 20 lattices, including all five of phase 1's. **The owner's rich-lattice counts
   48 / 16 / 216 are reproduced at denominator 14 and 30 and found unchanged at 42.**
2. **Haugland's positive control is reproduced exactly**: `|V(T₅)| = 1042`, `|V(T₆)| = 12856`, and
   **`G₁` = 740 vertices / 3,985 edges**, all four numbers his paper states, in exact `ℚ(ζ₈₄)` arithmetic.
3. **Three findings the plan did not have** (§4 below): a two-line lemma that turns P1 from a measurement into a
   theorem-with-one-open-bit; a chainable distance the plan never named (`δ = 4/7`, two copies, live on any
   lattice holding `1/7`); and `δ = 4` at chain length **3**, not the plan's 4.

---

## 2. The deliverables, step by step

### 0.1 The tools hardened — `tools/fs70_field.py`, `tools/fs70_fabric.py`

**Both self-tests green; all six planted faults fire, each with its reason named.**

```
python3 tools/fs70_field.py  --plants     # faithful twin green; unit_loose, depth_root, box_tight all refused
python3 tools/fs70_fabric.py --plants     # faithful twin green; basis_drop, sat_generators, screen_partial refused
```

| tool | plant | what it breaks | how it was seen to refuse |
|---|---|---|---|
| field | `unit_loose` | the unit test reads only the rational part of `x²+y²` | *"the unit test accepted (0, (1+√3)/2) — only the rational part was read"* |
| field | `depth_root` | the place above 2 uses a 3-adic Hensel root | *"v_q(N) = 1 is not divisible by f(P/q) = 2: the chosen 2-adic root does not select a prime of E"* |
| field | `box_tight` | the enumerator's box loses its boundary | *"units of denominator 1: got 0, plan §2.1 says 4"* |
| fabric | `basis_drop` | the HNF basis loses a row | *"rank 7, not 8: the basis does not span the generators' ℤ-module"* |
| fabric | `sat_generators` | the saturation returns the generator set | *"zeta12+u3+v4: \|S\| = 60, g = 60; the plan §2.2 reads g = 300"* |
| fabric | `screen_partial` | the screen tests one unit vector | *"proper ℤ/4 additive colourings 49152, not 1296"* |

The `unit_loose` plant did **not** fire on the first attempt: the test vector I had chosen, `(1, i√3/2)`, has
rational norm-part 7/4, so the loosened test rejected it anyway. The fix was to choose a vector whose norm has
rational part exactly 1 and a nonzero irrational part — `(0, (1+√3)/2)`, norm `1 + √3/2`. **A control whose
failure mode is unreachable has not been tested by passing** (`CLAUDE.md` § "Make the gate fail"); this one was
caught only because the plants are run, not reasoned about.

**Integer coordinates (the plan's §3.7).** Inside a lattice every point is an integer 8-tuple over the lattice
denominator `M`: addition is tuple addition and a hash is a tuple. The exact unit test runs once per lattice (on
the saturation), not once per pair. The plan's killed `T₈` build (5.8 GB of `Fraction` arithmetic in 7.5 min) is
now a word ball of 478,333 points in **23 s at well under a gigabyte** (§3 below).

**The enumerator.** `units_over(M)` was rewritten as a box-plus-hash: both coordinates of a unit vector over `M`
satisfy `|σ(X)| ≤ M` under each of the four real embeddings, so enumerate that box, group by the exact square,
and look up `M² − X²`. §2.1's table is reproduced **exactly** at every denominator it lists
(4, 8, 8, 16, 16, 24, 16, 48, 8, 32, 64, **0 at 11**, 32, 48, 48) and the whole atlas to 42 costs **6.3 s**
against the old code's minutes per denominator.

**`data/fs70/atlas.jsonl`: 2,020 unit vectors to denominator 42**, each with its three depths. 1,220 are 2-units,
1,180 are 3-units. Denominators 11, 22 and 33 hold none, as they must (11 is usable for the field, so every unit
vector is 11-integral).

### 0.2 The screen — `data/fs70/screen.jsonl`, 20 lattices

```
python3 tools/fs70_fabric.py screen <20 specs> --out data/fs70/screen.jsonl     # 39 s for all 20
```

| lattice | gate | M | g | ℤ/4 (√3, 2, 4/3, 8/3) | Klein (same) | `Λ_forced` index | chainable targets |
|---|---|---|---|---|---|---|---|
| `zeta12` | **fail** | 2 | 12 | 36 (12, 12, –, –) | 36 (0, 36, –, –) | 4⁴ | ±4 (3) |
| `zeta12+u3` | pass | 6 | 36 | **1296 (432, 432, 1296, 1296)** | 1296 (0, 1296, 1296, 1296) | 4⁸ | 4/3 (3), 4 (3), 8/3 (6) |
| `zeta12+u3+q7` | pass | 42 | 60 | 1296 (432, 432, 1296, 1296) | 1296 (0, …) | 4⁸ | **4/7 (2)**, 4/3 (3), 4 (3) |
| `zeta12+v4` | **fail** | 8 | 36 | **0** | **0** | 1 | (everything; nothing is screened) |
| `zeta12+w4` | **fail** | 8 | 36 | 288 (96, 96, –, –) | 480 (0, 480, –, –) | 4⁸ | ±4 (3) |
| `zeta12+u3+v4` | pass | 24 | **300** | 0 | 0 | 1 | — |
| `zeta12+u3+w4` | pass | 24 | 180 | 0 | 0 | 1 | — |
| `zeta12+u3+rho15` | pass | 48 | **540** | 0 | 0 | 1 | — |
| `zeta12+d6` | pass | 12 | 36 | 240 (80, 80, –, –) | 336 (0, 336, –, –) | 4⁸ | ±4 (3) |
| **`group:u3:2` (L1)** | pass | 18 | 60 | 1296 (432, 432, 1296, 1296) | 1296 (0, …) | 4⁸ | 4/3 (3), 4 (3), **4/9 (4)**, 8/3 (6) |
| `group:u3:3` | pass | 54 | 84 | 1296 (432, 432, 1296, 1296) | 1296 (0, …) | 4⁸ | as L1 |
| **`group:u3:2+v4` (L2)** | pass | 72 | **540** | 0 | 0 | 1 | — |
| **`group:u3:2+w4` (L3)** | pass | 72 | 324 | 0 | 0 | 1 | — |
| `group:u3:2+d6` (L5) | pass | 36 | 108 | 144 (48, 48, 144, 144) | 216 (0, …) | 4⁸ | as L1 |
| `zeta12+u3+q7+s7` (L4a) | pass | 42 | 276 | 144 (48, 48, 144, 144) | 1296 (0, …) | **4⁶** | 4/7 (2), 4/3 (3), 4 (3) |
| `zeta12+u3+q5+s5` (L4b) | pass | 30 | 180 | 336 (112, 112, 336, 336) | 1296 (0, …) | 4⁸ | 4√15/15 (2), 4/3 (3), 4/15 (4) |
| `zeta12+u3+q5+s5+q7+s7` | pass | 210 | 132\* | 432 (144, 144, …)\* | 1296\* | 4⁸\* | 4/7 (2), 4/3 (3) |
| `twounits:14` | pass | 16,380 | 212\* | **48 (16, 16, 48, 48)** | **216 (0, …)** | 4⁵ | 4/7 (2), 4/3 (3), 4 (3) |
| `twounits:30` | pass | 5.3·10¹⁰ | 660\* | **48 (16, 16, 48, 48)** | **216** | 4⁵ | as above |
| `twounits:42` | pass | 2.5·10¹⁵ | 1220\* | **48 (16, 16, 48, 48)** | **216** | 4⁵ | as above |

\* *generators only*: the lattice's denominator makes a complete saturation unaffordable, so the screen is
constrained by the generating set alone. **The interpretation rule, recorded in the tool and in every such row
(`saturation_complete: false`):** more constraints can only remove colourings, so *"no additive colouring
exists"* stays sound while a *kill* ("some φ identifies δ") does **not** — a surviving φ might fail on a unit
vector the constraint set missed. The `twounits:*` rows are therefore **upper bounds**, which is exactly the
direction the owner's re-grade of P1 uses.

**Every one of §2.2's seven rows is reproduced exactly**, including every `φ(target) = 0` count, and every
covolume of §2.4 (`ζ₁₂,v` 7.91, `ζ₁₂,w` 14.06, `ζ₁₂,u` 0.549, `ζ₁₂,u,q₇` 2.29·10⁻⁴, `ζ₁₂,u,v` 1.34·10⁻⁴,
`ζ₁₂,u,w` 2.14·10⁻³). `zeta12+v4` and `zeta12+w4` read **gate: fail**, as the plan requires.

**The owner's comparison (brief, ruling 2).** My richest 2-unit lattice is the span of **all 1,220 2-unit vectors
to denominator 42**. It reads **48 ℤ/4 colourings, 16 with `φ(i√3) = 0`, 216 Klein** — the owner's 48 / 16 / 216
at denominators 14 and 30, unchanged at 42. The kill is stable across a further half-decade of denominators.

### 0.3 The positive control: Haugland's `G₁` — `tools/fs70_haugland.py`

Rebuilt from `[Haugland2026]` §§2–3 and Appendix A in exact `ℚ(ζ₈₄)` arithmetic (rational polynomials modulo the
84th cyclotomic polynomial, degree 24; complex conjugation is `ζ ↦ ζ⁻¹`).

| what | ours | his | |
|---|---|---|---|
| `\|u₂₉\|² = 1` | exact | — | the test of the whole `ε` derivation |
| Appendix A parses | **228 paths** (32 of length 5, 196 of length 6), every vector sum **exactly** `B = i√3` | — | see below |
| `\|V(T₅)\|` | **1042** | 1042 | ✅ |
| `\|V(T₆)\|` | **12856** | 12856 | ✅ |
| `G₀` | 1294 points, 6727 edges | (not stated) | |
| **`G₁`** (the 7-core of `G₀`) | **740 points, 3985 edges** | 740, 3985 | ✅ |
| `A ≠ B` control | **SAT in 1.68 s** (kissat) | — | the graph really is four-colourable when `A ≠ B` |
| `A = B` | **UNSAT**: 1,458 cubes, **1,458 UNSAT, 0 SAT, 0 UNKNOWN**, 436 s wall / 9,425 CPU s at 22 jobs | UNSAT (CaDiCaL) | ✅ |

**Appendix A is an independent check of the `ε` derivation, and it is a strong one.** Rather than assume the
printed column layout, the parser splits each line's integers into consecutive blocks by dynamic programming,
accepting a block only when its vectors sum **exactly** to `B = (0,√3)` in the field. Every line of the
appendix parsed. A wrong `ε` makes every one of those 228 sums wrong, so this alone pins the construction.

*One discrepancy, recorded:* the 228 printed paths visit **731** distinct points, all of them in `V(G₁)`
(`|A \ G₁| = 0`), leaving **9** of `G₁`'s 740 vertices uncovered, where he writes that the paths *"collectively
visit all vertices of `G₁`"*. Since every path is exactly valid and the vertex counts match his, this is a fact
about the printed list (or about `pdftotext`'s extraction of it), not about the reconstruction.

**The refutation, and what it cost.** The prediction **P8 (*"phase 0.3 reproduces his refusal in under 60 s of
solver time"*) LOST, by more than two orders of magnitude.** Eight single-solver configurations — kissat and
CaDiCaL, each with and without the symmetry break, `kissat --unsat` on both, and both on the contracted encoding
— ran **27, 27, 27, 27, 12, 12, 9 and 9 minutes with no verdict** and were killed once the cube pass had settled
it. (What that kill forfeits, named out loud: whether any of them would have closed at a larger budget. The
verdict was already in hand, so the loss is a timing datum and nothing else.)

**Cube-and-conquer closes it in 436 s of wall time.** Contract `A` and `B` into one vertex (the same question,
and unit propagation then crosses the identification instead of having to derive it), pin a unit triangle at the
contracted vertex, branch on the colours of the seven highest-degree vertices: 1,458 of the 16,384 cubes survive
the branching set's own edges, and **all 1,458 are UNSAT**, 0 SAT, 0 UNKNOWN, at 22 jobs — 9,425 CPU seconds in
total, about 6.5 s a cube. Each cube's verdict is appended to `cubes.jsonl` as it lands, so a kill costs the
cubes in flight and nothing else (`tools/fs70_cube.py … --resume`). The ledger, the graph and the full record are
in `data/fs70/records/haugland/`.

*Reading, for phase 1, and it is the most useful thing this control produced:* **a 740-vertex four-colour
refusal with a monochromatic-pair constraint is not a single-solver instance on this hardware** — eight
configurations failed to close it at budgets up to 27 minutes, while the cube pass took 436 s. Phase 1's stop
rule (plan §1.3: 30 min of kissat, then one cube pass of 8 cubes) has the right shape but the wrong proportions:
**the cube pass should be the first resort on any candidate above a few hundred vertices, not the second, and 8
cubes is far too few** — 1,458 cubes on 22 cores is what closed this one, and the branching set that produced
them was simply the seven highest-degree vertices. A 30-minute single-solver UNKNOWN on a graph of this size
carries no information at all.

### 0.4 The residue planes — `tools/fs70_fq_plane.py`, `data/fs70/records/fq/fq-planes.json`

```
python3 tools/fs70_fq_plane.py run 9 25 49 5 --kmax 4 --budget 600 --out data/fs70/records/fq     # 1 s
```

| q | vertices / edges | degree | circle | ω | verdicts (kissat, triangle pinned, precedence on the rest) |
|---|---|---|---|---|---|
| **9** | 81 / 324 | 8 | 8 | 3 | k = 2 **UNSAT** (0.001 s) — *the control that the encoding can refuse*; k = 3 **SAT**, model verified proper on all 324 edges → **χ(UD(𝔽₉²)) = 3** |
| **25** | 625 / 7,500 | 24 | 24 | 3 | k = 2, 3 UNSAT; **k = 4 UNSAT** (0.050 s) → χ ≥ 5 |
| **49** | 2,401 / 57,624 | 48 | 48 | 3 | k = 2, 3 UNSAT; **k = 4 UNSAT** (0.378 s) → χ ≥ 5 |
| 5 (bonus control) | 25 / 50 | 4 | 4 | 2 | k = 2 UNSAT, k = 3 SAT verified → χ(UD(𝔽₅²)) = 3 |

Every encoding's sha256 is in the JSON. `k = 5` at q = 25 and q = 49 was asked at a 600 s budget and came back
**UNKNOWN** on both — recorded as a fact about the encoding, never about the graph (G21).

So the plan's §3.1 inputs hold: the 3-adic gate's value `χ(UD(𝔽₉²)) = 3` is re-derived here with its refusal
control, and the residue planes at 5 and 7 obstruct nothing at four colours.

### 0.5 The structure instruments — `tools/fs70_structure.py`, `data/fs70/records/structure-control.json`

```
python3 tools/fs70_structure.py control --budget 600 --out data/fs70/records/structure-control.json    # 37 s
```

The imposed-quotient ask is implemented by **quotienting** rather than by adding equality clauses: one variable
per class of `Λ/pΛ` the point set meets, an edge between classes holding a unit-distance pair, and a
**self-loop** — a unit-distance pair inside one class — settles the ask UNSAT with no solver at all.

| fabric | ask | result |
|---|---|---|
| `ζ₁₂,v` Minkowski ball `R = 2.5` (19,957 points, 111,990 edges, degree 11.22) | `L = 3Λ`, k = 4 | 4,893 classes, 52,134 quotient edges, **0 self-loops → SAT in 0.33 s**, and the lifted colouring is **verified proper on all 111,990 edges** |
| `S₂` word ball `k = 2` (1,801 points, 6,900 edges) | `L = 3Λ`, k = 4 | **4,140 unit-distance pairs inside a single class → UNSAT, no solver** |
| the same ball | `L = 2Λ` | 38,094 self-loops → UNSAT, no solver |
| the same ball | `L = 4Λ` | 12,376 classes, 0 self-loops → **SAT in 7.4 s**, lifted colouring verified |

**Both outcomes are reachable and both were seen**, which is the point of the control. The instrument finds the
3-adic residue rule the planner's own test missed.

**A correction to the plan's §2.3.** The plan says the planner's structure test on that ball *"looked for a
period and for factoring through `Λ/2Λ` and `Λ/4Λ` and found neither"*. Asked as an **existence** question, the
`4Λ` ask is **SAT**: a `4Λ`-periodic four-colouring of that ball exists (found, lifted, verified). The planner's
test asked whether the colouring it *had in hand* was `4Λ`-periodic — a different and weaker question. The
imposed-quotient ask is the instrument; the screen on a found colouring is not.

The ball itself reproduces the planner's numbers exactly (19,957 points, 111,990 edges, degree 11.22) and my
four-embedding ball law predicts 18,790 points and degree 11.213 against them.

### 0.6 Records skeleton — `data/fs70/README.md`, `records/`, `inflight/`

`data/fs70/README.md` names every file's role, who owns it, and the command that regenerates it.

---

## 3. The two measurements the owner asked for beyond the plan

### (a) The 16 survivors

```
python3 tools/fs70_fabric.py survivors twounits:42 --target isqrt3
```

On the richest 2-unit lattice (all 1,220 2-units to denominator 42) the 48 proper ℤ/4 additive colourings split
**16 / 16 / 16 by the value of `φ(1)`**, and the 16 with `φ(i√3) = 0` are **exactly** those with `φ(1) = 2` —
which are **exactly** those with `φ(2) = 0`. All sixteen also have `φ(u) = 2`, `φ(1/3) = 2`, `φ(4/3) = 0`. They
fall into 8 orbits of size 2 under conjugation and `φ ↦ −φ`; multiplication by `ζ₁₂` is *not* a symmetry of this
lattice (the generating set is cut at denominator 42, and `ζ₁₂` times a denominator-42 unit vector can have
denominator 84), which is why the orbits are small.

**They do not lift the residue colouring `ψ`.** `ψ` and `ψ̄` are the 𝔽₄-valued residue maps at the two primes
above 2, so they sit in the **Klein** family — and *no* Klein colouring has `φ(i√3) = 0` (the count is 0 on every
lattice screened), exactly as §3.1 says (`ψ(i√3) = ω + ω² = 1`). **So the √3 kill comes only from the ℤ/4 family,
never from the residue colouring at 2.**

### (b) The degree an `S₂` word fabric reaches

```
python3 tools/fs70_fabric.py word group:u3:2 {2,3,4}
```

| sums of ≤ k | points | edges | average degree | build |
|---|---|---|---|---|
| 2 | 1,801 | 6,900 | 7.66 | 0.3 s |
| 3 | 34,381 | 192,060 | 11.17 | 1.7 s |
| **4** (Harder's own depth) | **478,333** | **3,460,848** | **14.47** | **23 s** |

**And there is no `partial` risk on L1**: `|S₂| = 60 = g`, so the Harder generating set **is** its own saturation
— every unit vector the lattice holds is already a generator. Confirmed two ways: the saturation-stepped edge set
and the geometric one (a float grid proposes, exact integer arithmetic decides) agree **exactly** at k = 2 and
k = 3 (6,900 and 192,060 edges), the 60 distinct edge directions that occur are all in `S₂`, and none lies
outside the saturation.

*For phase 1's aiming:* G65 says a ball below average degree ~12 is a calibration point, not an ask. Sums of ≤ 3
sit at 11.17 — just below — and sums of ≤ 4 at 14.47, which is where FS-61's certified refusals lived, at
478k points. **The lens between `0` and the target with an m-core is the shape that gets the degree without the
size** (Haugland's own `T₆` is 12,856 points and his 7-core of `G₀` is 740).

---

## 4. Three findings

### (i) The triangle lemma: P1 becomes one bit, on *any* lattice with a unit triangle

Let `φ : Λ → ℤ/4` be additive and nonzero on every unit vector of a lattice `Λ` containing the unit triangle
`{0, 1, ζ₆}` (every lattice here does — `√3 ∈ F`). Then

> **`φ(i√3) = 0` ⟺ `φ(2) = 0` ⟺ `φ(1) = 2`.**

*Proof.* `φ(2) = 2φ(1)`, which vanishes iff `φ(1) ∈ {0,2}`, and `φ(1) ≠ 0` because `1` is a unit vector. For the
other: `i√3 = 2ζ₆ − 1`, so `φ(i√3) = 2φ(ζ₆) − φ(1)`. (⟸) if `φ(1) = 2` then, `ζ₆` and `ζ₆ − 1` both being unit
vectors, `φ(ζ₆)` is neither 0 nor 2, hence odd, hence `2φ(ζ₆) = 2` and `φ(i√3) = 0`. (⟹) if `φ(i√3) = 0` then
`φ(1) = 2φ(ζ₆) ∈ {0,2}` and `φ(1) ≠ 0`. ∎

So **the √3 virtual edge and the distance-2 virtual edge are killed by exactly the same colourings**, and the
whole of P1 reduces to one bit per lattice: *does some proper `φ` have `φ(1) = 2`?* Checked in the fabric
self-test on three lattices; observed on all nine screened lattices that admit any proper `φ`, where the split by
`φ(1)` is exactly uniform in thirds (1296 = 3 × 432, 288 = 3 × 96, 240 = 3 × 80, 144 = 3 × 48, 336 = 3 × 112,
48 = 3 × 16). **The uniform thirds stay measured**, not derived: I have no argument that a lattice admitting a
`φ` with `φ(1)` odd must admit one with `φ(1) = 2`.

This upgrades P1's grade from *"measured, stable to denominator 30"* to *"a two-line lemma plus one measured
bit"*, and it shows the kill is **not** special to 2-unit fabric: `zeta12+w4` and `zeta12+d6` — neither of them
2-unit lattices — kill the √3 virtual edge too, for the same reason.

### (ii) A chainable distance the plan never named: `δ = 4/7`, two copies

`ρ₁₅ + ρ̄₁₅ = 7/4` exactly, so `1/δ` with `δ = 4/7` is a sum of **two** unit vectors and `4/7 > 1/2`: a
four-colour forced pair at distance `4/7` closes with **one ρ₁₅ spindle**. It lies in `Λ_forced` on every lattice
holding `1/7` — `zeta12+u3+q7`, `zeta12+u3+q7+s7` and all three `twounits:*` rows. The plan's §3.5 table has no
chain shorter than 2 (distance 2, `v + v̄`), and this is the second one; it is the cheapest closer the field has.

### (iii) `δ = 4` is chain **3**, not 4

The plan's §3.5 gives `1/4 = 1 + 1 + v² + v̄²`, four copies. Exactly, `1/4 = v̄ + v² + ρ₁₅ = v̄ + v² − v̄²` — a sum
of **three** unit vectors, so `δ = 4` closes with three copies. (Verified by exhaustive search over the 140 unit
vectors of denominator ≤ 8.) Likewise `3/4 = −1 + ρ₁₅ + ρ̄₁₅`, confirming `δ = 4/3` at three.

*Scope, stated so no phase over-reads it (G21):* the chain enumeration searches sums of at most **four** unit
vectors of denominator at most **8** (140 vectors), exhaustively, using an exact meet-in-the-middle on the
imaginary part. A distance absent from the `targets` column is absent **from that pool at that length**, not from
the field. The `8/3` row carries chain 6 from the plan's own identity, not from this enumeration.

---

## 5. Decisions

| # | the choice | the alternative I weighed | why this one | confidence |
|---|---|---|---|---|
| 1 | **Saturation method B is the default; method A is the cross-check.** | The plan's order (A by default, B as the fallback where `qfminim` overflows). | B is complete *by construction* — `Λ ⊆ (1/M)ℤ⁸`, so every unit vector of `Λ` has denominator dividing `M` — and here it is also **cheaper**: the box of `M` costs `(2M)⁴/240` elements, which is 0.03 s at `M = 18` and 3.9 s at `M = 72`, where A's cost grows as `1/covolume` and is 10⁷ vectors on the dense lattices phase 1 uses. `--sat-method both` runs both and asserts they agree; they do, on five lattices. | **high** — measured both ways on five lattices |
| 2 | **Method B refuses by name above a cost cap instead of truncating.** | Truncate the enumeration at some denominator and carry on. | A truncated saturation makes the screen's *kills* unsound (a colouring proper on a subset of the unit vectors is not a colouring), while leaving "no additive colouring exists" sound. The refusal names the cost, the memory and the two ways out. | high |
| 3 | **A `generators-only` saturation mode, flagged `saturation_complete: false`.** | Leave the `twounits:*` lattices out of the screen entirely. | Their denominators are astronomical (2.5·10¹⁵ at `twounits:42`) so no complete saturation exists at any price — but the owner's P1 re-grade needs exactly this over-approximation, and the flag plus the interpretation rule keeps it honest. | high |
| 4 | **The precedence symmetry break is the linear (auxiliary-variable) encoding.** | The naive `x[v][c] → ⋁_{u<v} x[u][c−1]`, which the planner's tool used. | The naive form is `O(n²)` literals: on the 19,957-point ball it wrote a **1.1 GB** CNF and took the process to 3.2 GB before I killed it. The linear form is `O(nk)` clauses and is controlled in the self-test — broken and unbroken encodings must agree on three instances. | high — the control is in the self-test |
| 5 | **Edges are derived two ways and the two are asserted equal.** | One derivation (stepping through the saturation). | The saturation-stepped derivation is complete *only if* the saturation is; the geometric one (float grid proposes, exact integers decide) is independent of it. They agree exactly on every fabric tested, which is the control on both — and the geometric one also reports the edge **directions**, which is how a graph built from a subset of the directions would be caught. | high |
| 6 | **Haugland's refutation by cube-and-conquer, not by one solver.** | Keep waiting on the single-solver runs, or accept an UNKNOWN. | Six single-solver configurations (kissat, CaDiCaL, each with and without a break, plus the contracted encoding and `--unsat` tuning) ran past 20 minutes with no verdict; the cube pass was projecting ~10 minutes within its first 25 cubes. An UNKNOWN at a budget would have been a fact about the encoding, not the control the phase owes. | high |
| 7 | **I did not build the plan's L4 (`S₂` plus the 5- and 7-families) as one lattice.** | Force it through with method A. | Its denominator is 630, so method B needs an 880 GB box and method A about 10¹⁵ lattice vectors — neither is a compute question. I screened its two halves instead (`zeta12+u3+q7+s7` at `M = 42` and `zeta12+u3+q5+s5` at `M = 30`, both complete) and the six-family lattice generators-only. **Phase 1 should treat L4 as two lattices**, and the `4/7` target lives on the 7-half. | high — the cost is arithmetic, not a measurement |

---

## 6. What a kill redoes, and what is in flight

Nothing in phase 0 runs long except the Haugland control, and it is **finished**: its in-flight marker is
deleted and its ledger, graph and record are committed under `data/fs70/records/haugland/`. While it ran, each
cube's verdict was appended to `cubes.jsonl` as it landed, so a kill would have cost at most the 22 cubes in
flight, and `data/fs70/inflight/haugland-cubes.json` carried the resume command and the process-group file.
Everything else here regenerates in seconds to a minute; the commands are in `data/fs70/README.md`.

**Cost of the phase, for the owner's budget:** the Haugland control is 15.7 min of geometry (single-threaded,
115 MB) plus 436 s on 22 cores; everything else together is under three minutes. Nothing else ran while the
geometry did, except the two one-second residue-plane runs.

## 7. WORKFLOW step 9's two sweeps over this phase's additions

* **"conjecture"** — one: the uniform thirds in the split of the proper ℤ/4 colourings by `φ(1)` (§4(i)). It is
  recorded as **measured, not derived**, and its natural home is the P1 row of the plan's §7 rather than a stub
  of its own: it is a sharpening of a prediction the owner has already graded, and the triangle lemma makes it
  the *only* remaining open part of P1. **Declined as a stub; flagged to the owner as a one-line addition to P1.**
* **"not claimed"** — the scope note of §4(iii) (the chain pool is denominator ≤ 8 and length ≤ 4); the
  `saturation_complete: false` rule of §0.2; the 9 uncovered vertices in Haugland's Appendix A, which is a claim
  about the printed list and not about `G₁`. All three are recorded where they are used, not as stubs.

---

## 8. Where the plan and the brief were wrong — consolidated

| where | what it says | what is the case |
|---|---|---|
| plan §3.2 | saturation method A (PARI `qfminim`) is the method; B is the fallback where A overflows | **The order is backwards.** B is complete by construction and cheaper on every lattice this milestone uses; A's cost grows as `1/covolume` and is ~10⁷ vectors on phase 1's dense lattices. B is now the default and A the cross-check; `--sat-method both` asserts they agree, and they do on five lattices. |
| plan §2.3 | the planner's structure test *"looked for a period and for factoring through `Λ/2Λ` and `Λ/4Λ` and found neither"* | Asked as an **existence** question by the imposed-quotient ask, `L = 4Λ` on that same ball is **SAT** — a `4Λ`-periodic four-colouring exists, found, lifted, and verified proper on all 111,990 edges. (`2Λ` really is impossible, and by a self-loop, with no solver.) The planner's test asked whether the colouring it had was periodic, which is the weaker question. |
| plan §3.5 | `δ = 4` needs **4** copies, via `1 + 1 + v² + v̄² = 1/4` | **3 copies**: `1/4 = v̄ + v² − v̄²` exactly. |
| plan §3.5 | the chainable distances are `2, 4/3, 4, 8/3` | **`4/7` is chainable with 2 copies** (`ρ₁₅ + ρ̄₁₅ = 7/4`, and `4/7 > 1/2` so a single `ρ₁₅` spindle closes it), on every lattice holding `1/7`. Also `4/9` at 4, `4/15` at 4, `4√15/15` at 2 on the 5-family lattice. |
| plan §4.1, L4 | `S₂` plus the 7-family and the 5-family orbits, as one lattice | Its denominator is 630, so a complete saturation needs an 880 GB box (method B) or ~10¹⁵ lattice vectors (method A). **Phase 1 must treat L4 as two lattices** (`…+q7+s7` at `M = 42`, `…+q5+s5` at `M = 30`, both saturated completely here), or accept a generators-only screen whose kills are not sound. |
| plan §1.3 | per ask: 30 min of kissat, then one cube pass of **8 cubes** | The 740-vertex control needed **1,458 cubes** on 22 cores after eight single-solver configurations failed at up to 27 minutes. Eight cubes is two orders of magnitude too few, and a single-solver UNKNOWN at this size carries no information. |
| plan §7, P1 | *"measured, stable to denominator 30"* | Half of it is a **two-line lemma** (§4(i)): `φ(i√3) = 0 ⟺ φ(2) = 0 ⟺ φ(1) = 2` on any lattice with a unit triangle. What stays measured is one bit — does some proper `φ` have `φ(1) = 2`? — observed true, in exactly one third of the colourings, on all nine screened lattices that admit any `φ`. |
| plan §7, P8 | phase 0.3 reproduces the refusal *"in under 60 s of solver time"* | **Lost.** 9,425 CPU seconds, and only by cube-and-conquer. |
| the brief | *"the count of edge directions that are not in the lattice's saturation (which is what makes a graph `partial`)"* on `S₂` | **Zero, and necessarily so**: `|S₂| = 60 = g`, so Harder's generating set **is** the saturation of its own lattice. There is no `partial` risk on L1 at any depth. Confirmed by two independent edge derivations agreeing exactly. |
