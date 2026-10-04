# FS131-E1 — two GAPs in the repaired chain of "maps need six": the derivation record

*Job FS131-E1 (Ephodos, Opus 5.5), started 2026-10-04 10:02 UTC. Brief `data/fs131/briefs/FS131-E1-maps-six-gaps.md` with `plans/STANDING-RULES.md`
(read in full). No fence in this milestone (inventory ruling 1). Report: `data/fs131/reports/FS131-E1.md`. Working files: `data/fs131/e1/`; exact checks
`tools/fs131_e1_*.py`. Resuming check: no record existed; nothing to resume.*

## Theorems this phase proved

None yet (stage 1 is the readback).

## Stage 1 — SAVED: the readback, the questions, the registered predictions

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact string containment against the files named; the claim list's body compared character for character with FS131-W's record
§ 1.6 at commit `c7db6d7c`, `git show c7db6d7c:plans/FS131-W-kernel-plan.md`).

| quotation in the brief | source | result |
|---|---|---|
| Q1's opening ("**Q1 (F1) — step 5 at `φ_b = π/3` exactly.** … of distinct colours") | `data/fs131/claims-E1.md` § The questions | **matches** verbatim |
| Q2's opening ("**Q2 (F2) — step 7's terminal vertex.** … (colours `A, B, C, D`,") | `data/fs131/claims-E1.md` § The questions | **matches** verbatim |
| the claim list as a whole ("copied by script, verbatim, from `plans/FS131-W-kernel-plan.md` § 1.6 … at `c7db6d7c`") | W's record at `c7db6d7c` | **matches**: identical text |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `plans/STANDING-RULES.md` rule 4 | **matches** |
| `lemmaL` "stated in the kernel" | `Proofs/HadwigerNelson/Plane/SVMap.lean:38` on branches `fs131-ww` and `fs131-w4` | present (`theorem lemmaL`) |
| "`plans/FS111-derivation.md` lines 208–222 and 618" (route M's uses of FS106-AE-MAP6) | that file | FS111-C-SIX-M (from line 208), FS111-C-REG-EQ (to line 222) and FS111-M-REDUCE-I (line 618) cite FS106-AE-MAP6, as the brief says |
| `CLAUDE.md` § The aim item 4, "Maps need six: `[Woodall1973]` Thm 6 and Townsend's manuscript, each repairing the other" | `CLAUDE.md` | **matches** |
| `[Woodall1973]` p. 198, step 5's "φ ≤ ⅓π" and "π − φ ≥ ⅔π"; p. 199, step 7's "(This is because φ_a > ⅓π and φ_c > ⅓π: a diagram will make this clear. The strictness of these inequalities is necessary.)" | the page images, PDF pp. 12–13, rendered at 130 dpi by this job | **match**: step 5's signs are `≤` and `≥`, as W read them |

One gloss, not a quotation: the claim list says the OCR layer reads "π − φ > ⅔π" in step 5; this job's `pdftotext -layout` gives "rr - + > $T" there (the
`>` survives, the `π`, `φ` and `⅔` do not). W's gloss is a reading of that string and is right about what matters: the OCR lost the equality bar.

No mismatch; no finding about the brief.

### 1.2 The papers, read (standing rule 10)

| work, copy | section | status (this job) |
|---|---|---|
| `[Woodall1973]`, `~/source/library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf` | § 3, pp. 194–200 (map definition, Thms 5–6, steps 1–8, closing remark) | text layer read in full; page images of pp. 198–199 read |
| `[Townsend1979ms]`, `~/source/library/pdf/townsend-colouring-plane-no-monochrome-units-author-manuscript-1979-posted-2024.pdf` | all 7 pp. | text layer read in full (dropped symbols read from context and from the 2005 print) |
| `[Townsend2005]`, `~/source/library/geombinatorics/geombinatorics-v14-n4-2005-04.pdf` | pp. 192–193 (Thm 5 (i)–(ii)), rendered at 150 dpi | read; for the rest the library's reading note `~/source/library/notes/townsend-2005-reading.md` (job LP, 2026-09-27: the 1979 text word for word) is relied on, not re-read |
| `[Soifer2005Townsend]` | — | not read by this job (the note: history only) |
| `[Townsend1981]` | — | not read by this job (three earlier readers: its lemma is the manuscript's Thm 1) |
| `plans/FS106-derivation.md` (TW, WO, AE-MAP6, TS-U, TS-T, L); `plans/FS106-V-verification.md` § Continuation — FS106-V3, stages 1 and 3 | — | read |

**Does the published Townsend settle either question?** Not as printed. `[Townsend2005]` pp. 192–193, Theorem 5 (ii), treats a vertex of degree 4 by a
route different from Woodall's step 7: the union `T = ∪Tᵢ` of the four sets subtended by three of the four curves, "a unit annulus, centre v", and "Suppose
none of these boundary points is a vertex. Then there exist edges which cut T (rendering it simply connected), some of which cut either both of T1 and T3 or
both of T2 and T4. It is possible for an edge to cut T and only cut one of T1 and T3 or one of T2 and T4, but such an edge must intersect the unit circle
centre v at one of at most four points, these points being the cut points of the finitely disconnected annuli which are the interiors of T1∪T2 and T3∪T4.
There must be edges cutting T which intersect the unit circle centre v at points other than these four. … Hence there must be vertices in T0, and these are
of degree 3." It never meets step 7's terminal corner (it uses no window and no step 5), but its cross-cut step and its count of exceptional points are
asserted, not argued (V3 graded them so). Its idea — a vertex must appear on the unit circle, and almost every point of that circle sees only three colours —
is the one this job makes rigorous below, with the exceptional points counted differently (by edges at the centre that are unit arcs). Graded as read: the
passage above, p. 193.

### 1.3 The questions, restated (verbatim from the claim list)

The common setting:

> *Common setting.* A map of the plane bounded by a locally finite family of segments and circular arcs (an arc map; the questions make sense for Jordan
> boundaries too), five colours, **almost-everywhere proper** (D-AEMAP): no two points of open regions of one colour are at distance exactly `1`;
> boundary points carry no colour. `ω(p)` is the unit circle about `p`; `e(θ) = (cos θ, sin θ)`. Woodall's steps 1–3 are taken as done (Woodall's normal
> form: at every vertex the regions have distinct colours, edges enter vertices in well-defined directions). A **sector** at a vertex `P` is a region near
> `P` between two consecutive edges; its **angle** is the difference of the edges' directions. For a sector `b` at `P` with edges in directions `β₁ < β₂`
> (`φ_b = β₂ − β₁`) and neighbours `a` (before `β₁`) and `c` (after `β₂`) of colours `A`, `C`, the **interior arc opposite `b`** is the set of points
> `z = P + ρ e(ψ)` with `ψ ∈ I_b = (β₂ − 3π/2, β₁ − π/2)` (length `π − φ_b`) and `ρ ∈ (1 − h, 1)`, `h` small: for each such `z`, `ω(z)` passes through `a`,
> `b` and `c` near `P`, so no region point of the arc has colour `A`, `B` or `C`. **Lemma (L)** (FS106-L, held at [hand], stated in the kernel as
> `lemmaL`): in an open set `W` coloured with two colours whose classes are open and have no unit pair, a point `b ∈ W` with both colours arbitrarily
> near has `ω(b) ∩ W = ∅`. **The strict step-4 lemma** (FS106-WO): an interior or exterior arc of positive thickness of length `> 2π/3` cannot be coloured
> with two colours; it is false at exactly `2π/3` (Townsend's counterexample: the annular sector `1 − h ≤ |x| ≤ 1`, angles `[0, 2π/3]`, cut by the arc of
> `ω((1, 0))` through `e(π/3)` into two one-coloured parts).

> **Q1 (F1) — step 5 at `φ_b = π/3` exactly.** Is the following configuration excluded? A vertex `P` with consecutive sectors `a, b, c` of distinct colours
> `A, B, C`, `φ_b = π/3`, so `I_b = (ψ₁, ψ₂)` has length exactly `2π/3`; write `Q₁ = P + e(ψ₁)`, `Q₂ = P + e(ψ₂)`. **The open case:** the edge between `b`
> and `c` is, near `P`, an arc of `ω(Q₁)`, and the edge between `a` and `b` is, near `P`, an arc of `ω(Q₂)`. *What I checked* [planner's check, one mind]:
> (i) unless the `b|c` edge lies on `ω(Q₁)` near `P`, the set `W` of points whose unit circles meet `a`, `b` and `c` contains a one-sided collar (inner or
> outer, of positive thickness) over a neighbourhood of the angle `ψ₁` — for an arc map, by comparing the edge (a segment, or a circle of another radius or
> centre) with `ω(Q₁)`, both tangent to the direction `β₂` at `P`; likewise at `ψ₂` with the `a|b` edge and `ω(Q₂)`; (ii) if at least one end carries
> such a collar, a change point `b′` of the interior arc (which has a unit pair, so both colours `D, E`, so change points at every thickness) lands — its
> circle crosses `ω(P)` at angles `θ ± α`, `α ∈ (π/3, π/3 + O(1 − |b′ − P|))` — inside `W`, against lemma (L). So only the double-unit-arc configuration is
> open; there the arc's two ends are genuine cut points and Townsend's two-colouring of the `2π/3` sector is not excluded by anything I found. *Needed:*
> a contradiction in that configuration (from the rest of the map), or a different argument giving every angle `> π/3`, or the configuration
> exhibited. Under Condition 5 (no boundary contains an arc of a unit circle) Q1 does not arise.

> **Q2 (F2) — step 7's terminal vertex.** Is the following configuration excluded? A vertex `P` with exactly four sectors `a, b, c, d` (colours `A, B, C, D`,
> distinct), every angle `> π/3`, `φ_b` the smallest (`π/3 < φ_b ≤ π/2`). The interior arc opposite `b`, `I_b = (ψ₁, ψ₂)` of length `π − φ_b ∈ [π/2, 2π/3)`,
> is coloured `D, E` only and contains unit pairs, so both colours. By lemma (L), every `D|E` change point of the arc at angle `θ` has both landings
> `θ ± α` outside the arc, so as the thickness tends to `0` the change points accumulate in the **window** `[ψ₂ − π/3, ψ₁ + π/3]` (length `φ_b − π/3`), at a
> point `Q ∈ ω(P)`, with `D` and `E` in the multicolour of `Q`. Just outside `ω(P)` near the window only `B` and `E` can occur (the unit circles about those
> points pass through `a`, `c` and `d`: computed, using `φ_a, φ_c > π/3` strictly). **The open case:** `B` does not occur near `Q`: outside `ω(P)` near `Q`
> is all `E`, and `D` reaches `ω(P)` only from inside — (a) along an arc of `ω(P)` from `Q` (a unit arc centred at `P`, `D` inside, `E` outside), or (b) at the
> single point `Q`: the tip of a `D` wedge pointing outward (the two `D|E` edges meet at `Q`, transversally to `ω(P)`), or an arc of a circle of radius `< 1`
> tangent to `ω(P)` from inside at `Q`. Then `Q` carries only `D` and `E`: under Condition 2 ("every vertex is an endpoint of at least three boundaries")
> it is not a vertex, Woodall's "e must terminate … by meeting a vertex on the unit circle with center P" fails, and step 6 is never reached. *What I
> checked* [planner's check, one mind]: lemma (L) at the change points on the `D|E` edges near `Q` (their landings fall beyond the ends of `I_b` when `Q` is
> strictly inside the window); the sector `d` at `P` (with `φ_a, φ_c > π/3`, `d` lies in the open half-plane facing every direction of the window, so the
> unit circles about the `D` points near `Q` miss `d` near `P`, and conversely); TS-U at `P` for form (a) (`D` at `P` faces the arc: consistent); unit pairs
> inside the arc (the `D` part has angular length `≤ φ_b − π/3 ≤ π/6`, the two `E` parts `≤ π/3` each, and the cross pairs land beyond the ends). No
> contradiction found. Form (a) needs a unit arc; form (b) survives Condition 5. *Needed:* a contradiction in this configuration (perhaps from the other
> three opposite arcs at `P`, or from the window's exterior collar coloured `B, E`), a different argument excluding vertices with four regions, or the
> configuration exhibited. In step 8 (five regions at `P`) the same accumulation point carries `B, D, E` (outside the window only `B` can occur), so step 8
> reduces to step 6 at `Q` in Woodall's normal form: Q2 is step 7's alone.

**Reading of the normal form used throughout** (stated so it can be checked): "at every vertex the regions have distinct colours" is read sector by sector —
at every boundary point, the local sectors carry pairwise distinct colours, and every edge separates two sectors of different colours (Woodall's step 1). In
Woodall's maps each region is a Jordan domain, so a region occupies at most one sector at a point and the two readings agree; in an arc map they agree once
step 3 has run, because step 3's argument is about two same-coloured sectors at a point, whatever regions they belong to. Strict step 5 (an angle `< π/3`
at a point of three or more sectors is excluded, by FS106-WO's strict step-4 lemma) is taken as held, as the claim list and W's record do ("Held leaves …
steps 3, 5 (strict), 6 and 8").

### 1.4 Registered predictions (before the written derivation)

Honesty first: these are registered after reading the sources, during which a route was already sketched — Townsend's annulus argument (`[Townsend2005]`
Thm 5 (ii)) made rigorous, with its exceptional points counted by unit-arc edges — so they are not blind to that sketch. What they price is whether the
sketch survives being written out and attacked.

| question | expected verdict | probability | what the outcome decides |
|---|---|---|---|
| Q2 | **derived — excluded**: no point of a five-colour almost-everywhere-proper arc map in normal form has exactly four sectors, by a route that does not pass through Woodall's step 7 (so F2's terminal corner never needs deciding) | 0.75 | whether the formalizer can replace W's open leaf `step7` (and step 8) by one lemma |
| Q1 | **derived — excluded**, by the same lemma at points of four or five sectors and by step 6 at points of three; step 5's equality case is then not needed by the chain | 0.75 (correlated with Q2: the same lemma) | whether W's open leaf `step5_eq` can be dropped rather than closed |
| either | GAP at a named step (the sketch fails on attack) | 0.2 | the brief's third outcome |
| either | realized (a configuration exhibited) | 0.05 | it would contradict the printed theorems; checked to the standard of a first-size result |

### 1.5 The targets, fixed as conjectures before any argument

The statements below are fixed now and quoted verbatim wherever they recur. "Five-colour map" means the claim list's common setting: an arc map of the
plane, five colours, almost-everywhere proper (D-AEMAP), in Woodall's normal form after steps 1–3 and strict step 5 (§ 1.3's reading).

derivation: E1-NO45
  statement: in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors
  argument: § 1.3 The questions, restated (verbatim from the claim list)
  verdict: stalls at: stage 1 — registered, not yet derived

derivation: E1-Q2
  statement: the configuration of Q2 — a point with exactly four sectors of distinct colours, every angle greater than π/3 — does not occur in a five-colour almost-everywhere-proper arc map in Woodall's normal form
  argument: § 1.3 The questions, restated (verbatim from the claim list)
  verdict: stalls at: stage 1 — registered, not yet derived

derivation: E1-Q1
  statement: the configuration of Q1 — a point with consecutive sectors a, b, c of distinct colours and the angle of b exactly π/3 — does not occur in a five-colour almost-everywhere-proper arc map in Woodall's normal form, with or without the two edges of b on unit circles
  argument: § 1.3 The questions, restated (verbatim from the claim list)
  verdict: stalls at: stage 1 — registered, not yet derived
