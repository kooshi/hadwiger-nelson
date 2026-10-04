# FS131-E1 — two GAPs in the repaired chain of "maps need six": the derivation record

*Job FS131-E1 (Ephodos, Opus 5.5), started 2026-10-04 10:02 UTC. Brief `data/fs131/briefs/FS131-E1-maps-six-gaps.md` with `plans/STANDING-RULES.md`
(read in full). No fence in this milestone (inventory ruling 1). Report: `data/fs131/reports/FS131-E1.md`. Working files: `data/fs131/e1/`; exact checks
`tools/fs131_e1_*.py`. Resuming check: no record existed; nothing to resume.*

## Theorems this phase proved

- E1-SEE (visibility through a point at distance 1) — [hand, one mind] — § 3.1 (known: FS106-DIAM's third clause).
- E1-RAY (first-order visibility from near the unit circle) — [hand, one mind] — § 3.2.
- E1-CROSS (a region crossing ω(P) avoids every colour at P) — [hand, one mind] — § 3.3.
- E1-COVER (around a point of four or five sectors, branch points on ω(P) at most π/3 apart; at least six) — [hand, one mind] — § 3.4.
- E1-GEN6 (E1-COVER at c colours and k ≥ c − 1 sectors) — [hand, one mind] — § 3.4 (a generalization, not used).
- E1-BAD (non-exceptional points of ω(P) see two sectors; at most one exceptional point per edge and per sector of angle π) — [hand, one mind] — § 3.5.
- **E1-NO45 (no point of four or five sectors in a five-colour almost-everywhere-proper arc map in normal form)** — [hand, one mind] — § 3.6.
- E1-NOBRANCH (an almost-everywhere-proper arc map in normal form has a branch point) — [hand, one mind] — § 3.7.
- **E1-MAPS6 (maps need six, for arc maps, almost everywhere, with no step 5 at equality and no steps 7–8)** — [derived, one mind] — § 3.8.
- **E1-Q2 (Q2's configuration excluded)**, **E1-Q1 (Q1's configuration excluded)** — [derived, one mind] — § 3.9.

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

The statements below are fixed now and quoted verbatim wherever they recur. *(Stage 3, 2026-10-04: the three conjecture blocks registered here
were replaced by the derived entries of the same names in § 3.9 and § 3.6, their statements unchanged character for character; the blocks' headers are
written below as "registered:" so that the gate reads each name once, and their stage-1 verdicts are kept as written.)* "Five-colour map" means the claim list's common setting: an arc map of the
plane, five colours, almost-everywhere proper (D-AEMAP), in Woodall's normal form after steps 1–3 and strict step 5 (§ 1.3's reading).

registered: E1-NO45
  statement: in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors
  argument: § 1.3 The questions, restated (verbatim from the claim list)
  verdict: stalls at: stage 1 — registered, not yet derived

registered: E1-Q2
  statement: the configuration of Q2 — a point with exactly four sectors of distinct colours, every angle greater than π/3 — does not occur in a five-colour almost-everywhere-proper arc map in Woodall's normal form
  argument: § 1.3 The questions, restated (verbatim from the claim list)
  verdict: stalls at: stage 1 — registered, not yet derived

registered: E1-Q1
  statement: the configuration of Q1 — a point with consecutive sectors a, b, c of distinct colours and the angle of b exactly π/3 — does not occur in a five-colour almost-everywhere-proper arc map in Woodall's normal form, with or without the two edges of b on unit circles
  argument: § 1.3 The questions, restated (verbatim from the claim list)
  verdict: stalls at: stage 1 — registered, not yet derived

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh)

### 2.1 The stall, read

Both questions are the same stall in two places: Woodall's argument is a **local chase** — from one opposite arc (the interior arc opposite the
smallest sector) toward one point of `ω(P)` — and it fails exactly where the chase lands somewhere that is not a vertex of three colours: at `φ_b = π/3`
the arc has the critical length and its two ends are cut by unit arcs (Q1, Townsend's `2π/3` picture), and in step 7 the chase lands on a two-colour
corner `Q` (Q2). The shape is "a clause per case" (steps 5, 6, 7, 8 are one clause per degree, and each clause chases one arc) and "a wall that describes a
counterexample" (each GAP says what an escaping configuration would have to look like). The cure the stall points to: stop chasing one arc and ask what
the **whole** circle `ω(P)` must carry, for every solution.

### 2.2 For a stranger (a plane topologist who works on arrangements of curves)

*A plane is cut by a locally finite arrangement of segments and circular arcs into open faces; each face gets one of five colours; no two points of faces
of one colour are at distance exactly 1 (points on the arrangement carry no colour). A* branch point *is a point on the closure of three or more faces;
at every point the faces around it carry distinct colours, and at a branch point the angular sectors between consecutive arcs are at least `π/3`.
Show that no branch point has exactly four or exactly five faces around it.*

Words the stranger would stop at, and what each turned out to be:
- "unit circle about a point", "sees a sector": not jargon to strike — the **determiner** (below). In the stranger's words: the circle `ω(z)`, for `z` near
  the circle `ω(P)`, passes near `P` along a curve that tends to the line through `P` perpendicular to `z − P`; it meets the faces at `P` whose directions
  lie in the open half-plane on the far side of that line from `z` (if `|z − P| < 1`) or the near side (if `|z − P| > 1`). That is the support-line /
  half-plane picture of convex geometry, and it is first order.
- "interior arc of positive thickness", "window", "change point", lemma (L): **accompaniments** of Woodall's route — the stranger's statement does not
  need them, and the derivation below consumes none of them.

"This is a" — **an annulus-crossing question in plane topology, with a first-order visibility constraint**: around the circle `ω(P)`, in a thin annulus,
either some face crosses from inside to outside, or the boundary runs along the circle, and the visibility constraint says which colours a crossing face
may have. The classical dichotomy (Janiszewski's theorem; the "crosscut or separating loop" alternative for an annulus) is the home theorem, and a counting
step decides which points of the circle can be branch points of four colours.

### 2.3 The features, sorted

| feature | sort | receipt |
|---|---|---|
| five colours | determines (consumed) | consumed at "a face crossing `ω(P)` avoids all `k ≥ 4` sector colours, so has the one colour left" and "two faces of that colour never share a non-branch boundary point"; with six colours two colours are left and the cover step fails as written; a six-colour counterexample is not exhibited, so the second half of the receipt is a consumed step, not a counterexample |
| `k ∈ {4, 5}` sectors at `P` | determines (consumed) | consumed by the same step (`k ≥ 4` leaves at most one colour to a crossing face) and by the count `k ≤ 5 < 6`; at `k = 3` two colours are left and Townsend's `2π/3` two-colouring shows the cover step has nothing to act on — step 6 (Townsend's lemma) handles `k = 3` instead |
| every sector angle `≤ π`, none zero | determines (consumed) | consumed by the colour step (the two branches of `ω(Y)` at `P` fall in two different sectors); a sector of angle `> π` contains both branch directions for an arc of `Y`'s, where four colours are allowed (first-order count); a zero-angle sector (Woodall's cone) is invisible to the crossing step. Both are supplied by strict step 5 |
| an edge at `P` lying on a unit circle `ω(Y)`, `Y ∈ ω(P)` (Q1's double unit arc; F2's form (a)) | splits | consumed only through "each edge lies on at most one unit circle through `P`": at most `k` exceptional points `Y`; the rest of the feature (which edges, curving which way, Q1's pairing with the arc's ends) accompanies |
| `φ_b = π/3` exactly (Q1) | accompanies | the derivation never reads an angle except through "`≤ π`" and "`≥ π/3`" |
| `φ_b` the smallest, `≤ π/2`; `B` absent near `Q`; `Q` a tip or an arc (Q2) | accompanies | not consumed |
| the window, lemma (L), the strict step-4 lemma | accompanies (for E1-NO45) | not consumed by E1-NO45; lemma (L) is consumed upstream, inside step 6 (Townsend's lemma) and strict step 5 |
| arc map (segments and circular arcs, locally finite) | determines (consumed) | consumed at: two distinct circles (or a circle and a line) tangent at `P` meet only at `P`; finitely many branch points and faces near a compact set; each boundary arc near a point of `ω(P)` is inside, outside, or along `ω(P)`. For Jordan boundaries these become owed (tangency can oscillate) |
| almost-everywhere properness (region points only) | determines (consumed) | every step reads colours only at points of open faces; no boundary colour is read |

### 2.4 The homes, tested

1. **The poser's literature — `[Townsend2005]` Thm 5 (ii)** (read, § 1.2). Name there: the annulus `T = ∪Tᵢ`, "every boundary point of a region in T⁰ is a
   boundary point of at most three regions", the cross-cut, "at most four points … the cut points". *Old proof applies?* Its skeleton does: a vertex must
   appear on `ω(P)`, and almost every point of `ω(P)` sees three colours only. *Changed steps:* two — the cross-cut step (asserted in print) is replaced by
   a passage lemma plus a cover argument (stage 3, L-COVER), and the "at most four cut points" (asserted) by a count of edges at `P` that are unit arcs, at
   most `k` (L-BAD). *Exceptions vanish?* Yes: degrees 4 and 5 in one statement; Woodall's steps 5 (equality), 7 and 8 are not used. *Predicts a
   neighbour?* Yes: under Condition 5 there are no exceptional points, so one branch point on `ω(P)` suffices; and at six colours the same cover step works
   at points of five or six sectors (one colour left to a crossing face) — the neighbour E1-GEN6 below. **Adopted.**
2. **Plane topology — the annulus dichotomy** (Janiszewski; for arc maps it is elementary: a finite planar arrangement). Supplies L-COVER's topology.
   Dictionary: crosscut ↔ a boundary curve passing from inside to outside of `ω(P)`; separating loop ↔ one face (or one colour class through faces whose
   closures meet) encircling `P` near `ω(P)`. Holds both ways for arc maps. **Used inside home 1.**
3. **Woodall's own route** (steps 5–8; the costume's home). Old proof fails at F1, F2 as the claim list shows. **Killed** as a home for the answer (kept as
   the reason for the questions).
4. **The project's held lemmas** — FS106-DIAM ("an open set avoiding distance 1 has `ω(p)` disjoint from it for every `p` in its closure"), FS106-TS-T
   (a point of chromaticity `≥ 3` within `1/√2 + ε` of every point), FS106-TS-U. DIAM is exactly the colour step's engine (stage 3, L-SEE); TS-T gives a
   branch point near any point but not **on** `ω(P)`, which is what the count needs; TS-U is not needed. **DIAM used.**

### 2.5 The class

The determiners place the statement at: five colours, arc maps, normal form with strict step 5, `k ∈ {4, 5}`. The instance questions (Q1 at `k ≥ 4`, Q2)
become corollaries. The cover step alone lives at a wider class — any number `c` of colours, points with `k ≥ c − 1` sectors — recorded as a
generalization (E1-GEN6), not used.

### 2.6 Prior art, measured (2026-10-04, zbMATH Open API)

`ti:"monochrome unit"` (1: `[Townsend1981]`); `au:"Townsend, S" & ti:"colour*"` (2: the 1981 note, `[Townsend2005]`); `ti:"colored map" & ti:"unit
distance"` (0); `ab:"map" & ab:"unit distance" & ab:"six colors"` (0); `ci:0251.50003`, the works citing `[Woodall1973]` (4: Townsend 1981, Reid–Jungreis–Witte
1990, Zaks 1992, Sokolov–Voronov 2026); `ci:1506.05079`, citing `[Townsend2005]` (1: Sokolov–Voronov 2026). Sokolov–Voronov is held and read by the project
(`[SokolovVoronov2025]`, FS-106): it treats maps under Conditions 5–6 with six colours and does not repair Woodall's steps 5 or 7. Reid–Jungreis–Witte and Zaks
are about rational spaces (titles; not opened — their subject is not maps). Result: the theorem "maps need six" is Woodall's and Townsend's; **a repair of
Woodall's steps 5 (equality) and 7 is not found in print**; the idea of the route is `[Townsend2005]` Thm 5 (ii)'s.

## Stage 3 — SAVED: the derivation — no point of four or five sectors (E1-NO45), and the two questions as corollaries

### 3.0 Setting, notation, and what is taken as held

- `e(θ) = (cos θ, sin θ)`; `ω(p)` the unit circle about `p`; `D(p, r)` the open disc, `D̄` the closed one. An **arc map** is the claim list's: the
  boundary is a locally finite family of segments and circular arcs; the **regions** are the components of its complement; each region carries one of
  five colours; **D-AEMAP**: no two points of open regions of one colour are at distance exactly 1. A bounded set meets finitely many arcs, hence
  finitely many regions, and contains finitely many points where an arc ends or two arcs meet.
- Near a boundary point `Y` the boundary is a finite union of arcs with an end at `Y` (an arc through `Y` counts as two **arc-ends**). The **sectors** at
  `Y` are the components of `D(Y, r)` minus the boundary, for small `r`, between consecutive arc-ends; each lies in one region; the **regions at `Y`** are
  the regions whose closure contains `Y`. A **branch point** is a boundary point with at least three sectors.
- **Normal form** (§ 1.3): **(N1)** at every boundary point the sectors carry pairwise distinct colours — so a boundary point has at least two sectors,
  the two sectors along an edge differ in colour, and the regions at a point carry exactly as many colours as there are sectors; **(N2)** at every branch
  point every sector has angle at least `π/3` — in particular positive, so no two edges at a branch point leave it in one direction.
- **Taken as held**, each at its grade (one mind): Woodall's steps 1–3, which produce (N1) (the claim list takes them as done); **strict step 5**, which
  gives (N2): a branch point with an angle `< π/3` yields a monochrome unit (FS106-WO's strict step-4 lemma); **step 6**: no branch point has exactly
  three sectors (FS106-WO, Woodall's step 6 repaired by Townsend's ⅓π lemma through V3's repair of Townsend's Theorem 4 corollary). W's record lists all
  three among its held leaves.
- For a point `P` and a direction `ψ`: `Y_ψ = P + e(ψ)`; `H⁺(ψ) = (ψ − π/2, ψ + π/2)` and `H⁻(ψ) = (ψ + π/2, ψ + 3π/2)`, open arcs of directions. "A point
  of a sector `s` at `P`" means a point of the region occupying `s`, near `P` and inside the angular range of `s`.

### 3.1 Visibility through a point of distance one

derivation: E1-SEE
  statement: in an almost-everywhere-proper arc map, if a point q of an open region lies at distance exactly 1 from a point Y, then no region whose closure contains Y has the colour of q
  uses only: that q's region is open; that ω(z) moves with z by translation; D-AEMAP at one pair of region points
  not claimed: anything about the boundary points near Y, which carry no colour; nor the converse (a colour absent at Y need not occur on ω(Y))
  argument: § E1-SEE, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring of tools/fs131_e1_hexmodel.py, at 3,600 points Y of the unit circle about a vertex (control e1-see-hex)
  prior art: known: FS106-DIAM's third clause ("an open set avoiding distance 1 has ω(p) disjoint from it for every p in its closure"), applied to the union of two regions of one colour; classical
  handoff: de Bruijn — the lemma, over ArcMap (it may already be W's or K4's in another form: compare `lemmaL`'s neighbours in Plane/SVMap)

#### E1-SEE, the argument

Let `q` lie in a region `Q` of colour `X`, `|q − Y| = 1`, and let `R` be a region of colour `X` whose closure contains `Y`. `Q` is open, so `D(q, ρ) ⊆ Q`
for some `ρ > 0`. Take `z ∈ R` with `|z − Y| < ρ`. The point `q + (z − Y)` lies in `D(q, ρ) ⊆ Q`, and `|z − (q + (z − Y))| = |Y − q| = 1`: two region
points of colour `X` at distance 1, against D-AEMAP. ∎

control: e1-see-hex
  of: E1-SEE — the model: on the hexagonal seven-colouring, the colours at each of 3,600 points Y of ω(P) (P a vertex) avoid the colours ω(Y) meets near P; the fault recolours by (i + 2j) mod 7, which is not almost-everywhere proper
  run: python3 ../tools/fs131_e1_hexmodel.py
  expect: see_checked=3600 two_sector=3600 see_violations=0 cross_checked=3597 cross_violations=0 skipped=0
  fault: python3 ../tools/fs131_e1_hexmodel.py --fault

### 3.2 First-order visibility from near the unit circle

derivation: E1-RAY
  statement: if a sector s at a point P contains a direction γ with cos(γ − ψ) < 0 (respectively > 0), then every point z close enough to P + e(ψ) with |z − P| < 1 (respectively |z − P| > 1) has a point of s on ω(z)
  uses only: that edges enter P in well-defined directions (so a closed cone of directions inside s, cut at a small radius, lies in s's region); the explicit root of the ray–circle equation
  not claimed: anything at the two directions γ = ψ ± π/2, where the first-order term vanishes and the shape of the edge decides (that case is E1-BAD's)
  argument: § E1-RAY, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: any vertex of the hexagonal seven-colouring (control e1-see-hex reads its consequence E1-CROSS there)
  prior art: partly: [Woodall1973] steps 3–7 use it without the computation ("each unit circle through Q … passes through X or Y"); FS106-V3 stage 1 (inside and outside sets of a small curve)
  handoff: none — a relay-result; it crosses inside E1-CROSS

#### E1-RAY, the argument

Let `γ` lie in the open angular range of `s` with `c = cos(γ − ψ) < 0`. Choose a closed interval `J` of directions about `γ` inside that range and `r₀ > 0`
with `P + ρe(θ)` a point of `s` for `0 < ρ < r₀`, `θ ∈ J` (edges enter `P` in well-defined directions, finitely many). For `z = P + (1 − t)e(ψ′)` with
`0 < t < 1` and `|ψ′ − ψ|` so small that `cos(γ − ψ′) ≤ c/2`, the ray `P + ρe(γ)` meets `ω(z)` where `ρ² − 2ρ(1 − t)cos(γ − ψ′) − (2t − t²) = 0`. Its
positive root is `ρ = (2t − t²) / (√((1 − t)²cos²(γ − ψ′) + 2t − t²) − (1 − t)cos(γ − ψ′))`, and the denominator is at least `(1 − t)|c|/2`, so
`ρ ≤ 4t/((1 − t)|c|) → 0`. For `t` small, `0 < ρ < r₀`: a point of `s` on `ω(z)`. For `z = P + (1 + t)e(ψ′)` and `c > 0` (with `cos(γ − ψ′) ≥ c/2`), the ray
meets `ω(z)` where `ρ² − 2ρ(1 + t)cos(γ − ψ′) + 2t + t² = 0`, whose discriminant is positive for `t` small, and the root nearer 0 is
`ρ = (2t + t²) / ((1 + t)cos(γ − ψ′) + √((1 + t)²cos²(γ − ψ′) − 2t − t²)) ≤ 2(2t + t²)/((1 + t)c) → 0`. ∎

### 3.3 A region crossing the unit circle avoids every colour at the centre

derivation: E1-CROSS
  statement: at a point P whose sectors all have positive angle, a region R whose closure meets ω(P) at a point Y both from inside and from outside — Y a limit of points of R with |· − P| < 1 and of points of R with |· − P| > 1 — has a colour different from every sector colour at P
  uses only: E1-RAY; that a sector of positive angle has a direction γ with cos(γ − ψ) ≠ 0 in its open range; D-AEMAP
  not claimed: that a region touching ω(P) from one side only avoids every colour at P (it avoids only the sectors seen from that side); nor anything at a sector of angle zero (Woodall's cone), which has no direction to see it by
  argument: § E1-CROSS, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring at a vertex P: the hexagons crossing ω(P) at 3,597 sampled points carry none of P's three colours (control e1-cross-hex)
  prior art: partly: [Townsend2005] Thm 5 (ii), p. 193 ("the only colour common to both T1 and T3 or both T2 and T4 is c5"), the same observation for the four sets Tᵢ; not found in this form
  handoff: de Bruijn — crosses with E1-NO45 as one of its lemmas

#### E1-CROSS, the argument

Write `Y = Y_ψ`. Let `s` be a sector at `P` and `γ` a direction in its open range with `cos(γ − ψ) ≠ 0` (one exists: the range is an open interval of
positive length and only two directions have cosine 0). If `cos(γ − ψ) < 0`, E1-RAY gives a neighbourhood `N` of `Y` such that every `z ∈ N` with
`|z − P| < 1` has a point of `s` on `ω(z)`; `R` has such a point `z`; if `R` had `s`'s colour, `z` and that point of `s` would be two region points of one
colour at distance 1. If `cos(γ − ψ) > 0`, the same with the points of `R` outside `D̄(P, 1)`. ∎

control: e1-cross-hex
  of: E1-CROSS — the model: the hexagons crossing ω(P) at sampled points carry none of P's colours; the fault's improper recolouring breaks it
  run: python3 ../tools/fs131_e1_hexmodel.py
  expect: see_checked=3600 two_sector=3600 see_violations=0 cross_checked=3597 cross_violations=0 skipped=0
  fault: python3 ../tools/fs131_e1_hexmodel.py --fault

### 3.4 Around a point of four or five colours, branch points are at most π/3 apart on the unit circle

derivation: E1-COVER
  statement: in a five-colour almost-everywhere-proper arc map in Woodall's normal form, if a point P lies on the boundary of exactly four or exactly five sectors, then every open arc of ω(P) containing no branch point has angular length at most π/3, and ω(P) contains at least six branch points
  uses only: E1-CROSS (through (N2): positive angles at P); (N1) at the points of ω(P) and at P; that at most one of the five colours is absent from P's sectors; the local picture of an arc map near a point of ω(P) (each arc-end inside, outside, or along ω(P)); finiteness of regions near a compact arc; connectedness of a region; D-AEMAP
  not claimed: that the branch points on ω(P) have three sectors (that is E1-NO45's step, and it needs E1-BAD); nor anything at a point of three sectors, where a crossing region may take either of two colours and the cover step has nothing to act on
  argument: § E1-COVER, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist — its hypothesis class is empty by E1-NO45, which it serves; its neighbour E1-GEN6 (six colours, five or six sectors) is not shown inhabited either
  prior art: partly: [Townsend2005] Thm 5 (ii), p. 193 — "Suppose none of these boundary points is a vertex. Then there exist edges which cut T …", asserted; the passage-and-cover argument and the π/3 spacing not found in print
  handoff: de Bruijn — crosses with E1-NO45 as its main lemma (the plane topology of an arc map near a circle: arc-end types, the maximal boundary arc along ω(P), finitely many regions near a compact arc)

#### E1-COVER, the argument

Let `P` have `k ∈ {4, 5}` sectors. Their colours are distinct (N1), so at most one colour is absent from them; when `k = 4` call it `E`. By E1-CROSS (its
hypothesis holds by (N2)), a region that crosses `ω(P)` at some point — in E1-CROSS's sense — has colour `E` when `k = 4`, and does not exist when `k = 5`.

**(a) The local picture at a point `Y ∈ ω(P)` that is not a branch point.** Either `Y` lies in a region, which then crosses `ω(P)` at `Y`; or `Y` is a
boundary point with exactly two sectors (N1), bounded by exactly two arc-ends `κ₁, κ₂`. Near `Y` an arc-end is a segment or a circular arc ending at `Y`,
so it lies strictly inside `D(P, 1)` (type I), strictly outside `D̄(P, 1)` (type O), or along `ω(P)` (type A): a line or a circle other than `ω(P)` meets
`ω(P)` in at most two points. Call the two halves of `ω(P) ∩ D(Y, r)` minus `Y` its **sides at `Y`**. A side met by no arc-end of type A carries no
boundary at all near `Y` (an I or O end meets `ω(P)` near `Y` only at `Y`), so each of its points `Y′` has a disc about it inside one sector, with points
on both sides of `ω(P)`; the discs along that side overlap, so it is one sector, and its region **crosses** `ω(P)` at `Y` (`Y′ → Y`). The cases:
- **(I, O), a passage**: each of the two sectors has both `κ₁` and `κ₂` in its frontier (two arc-ends cut a small disc into two sectors, each bounded by
  both), so it has points close to `κ₁` (inside `D(P, 1)`) and close to `κ₂` (outside `D̄(P, 1)`), arbitrarily near `Y`: **both** sectors' regions cross
  at `Y`.
- **(I, I), (O, O)**: the half-disc on the other side of `ω(P)` (outside for (I, I), inside for (O, O)) misses both arc-ends and is connected, and both
  sides at `Y` border it, so both sides lie in one sector; that sector's region crosses at `Y`.
- **(A, I), (A, O)**: one side is the A-end; the other side is free, and its sector's region crosses at `Y`.
- **(A, A)**: both sides are boundary; `Y` is interior to an arc of `ω(P)` contained in the boundary, with one sector inside and one outside.

**(b) `k = 5`.** No region crosses `ω(P)`. So every non-branch point of `ω(P)` is of type (A, A). Let `Γ` be an open arc of `ω(P)` containing no branch
point: every point of `Γ` is a boundary point interior to a boundary arc along `ω(P)`, so `Γ` lies in the boundary, and the region occupying the inner side
is locally constant along `Γ` (near each point it is the inner sector), hence one region `R` along all of `Γ`, with points arbitrarily close to every point
of `Γ`.

**(c) `k = 4`.** Let `Γ` be an open arc of `ω(P)` containing no branch point, and `Y ∈ Γ`.
- If `Y` is of type (I, O), both sectors at `Y` cross, so both are `E`; but they are the two sectors along an edge, of different colours (N1).
  Contradiction: no point of `Γ` is a passage.
- If `Y` lies in a region, or is of type (I, I), (O, O), (A, I) or (A, O), some sector's region crosses at `Y`, so `Y` lies in the closure of a region of
  colour `E`.
- If `Y` is of type (A, A), let `A_Y` be the maximal arc of `Γ` contained in the boundary and containing `Y`; it contains no branch point, so along it the
  inner region `R` and the outer region `R′` are constant. At an end `Y₁` of `A_Y` lying in `Γ` (not a branch point) the type is (A, I) or (A, O), with the
  A-end along `A_Y` and the free side beyond `Y₁`. At an (A, I) end the outer half-disc at `Y₁` misses both arc-ends and is connected, and it borders both
  the outer side of `A_Y` and the free side, so one sector holds both: `R′` crosses at `Y₁` and `R′ = E`; at an (A, O) end, symmetrically (the inner
  half-disc), `R` crosses and `R = E`. If `A_Y` has one end of
  each type in `Γ`, `R = R′ = E`, against (N1) along `A_Y`. Otherwise `Y`, adjacent to both along `A_Y`, lies in the closure of an `E` region — unless
  neither end of `A_Y` lies in `Γ`, that is, `A_Y ⊇ Γ`.

So either `Γ` lies wholly in a boundary arc along `ω(P)`, with one inner region `R` along all of it, or every point of `Γ` lies in the closure of an `E`
region. In the second case let `Γ′ ⊆ Γ` be a compact sub-arc. Finitely many regions meet a neighbourhood of `Γ′`; the sets `closure(R) ∩ Γ′`, over the
`E` regions `R`, are closed and cover `Γ′`, and they are pairwise disjoint: a point of `Γ′` in the closures of two `E` regions would carry two sectors of
colour `E` (or lie in one region), against (N1). `Γ′` is connected, so it lies in the closure of a single `E` region `R`.

**(d) The unit pair.** In each case a single region `R` has points arbitrarily close to every point of a compact sub-arc `Γ′ ⊆ Γ` (in (b) and the first
case of (c), `R` is the inner region along `Γ`). If `Γ` had angular length greater than `π/3`, take `Γ′` with angular length greater than `π/3`; its
ends `Y₁, Y₂` satisfy `|Y₁ − Y₂| > 1`. Take `x ∈ R` within `(|Y₁ − Y₂| − 1)/3` of `Y₁` and `y ∈ R` within the same of `Y₂`, so `|x − y| > 1`; `R` also has
points as close to `x` as we like. The function `|x − ·|` is continuous on the connected set `R` and takes values below and above 1, so it takes the value
1 at some point of `R`: two region points of one colour at distance 1, against D-AEMAP. So every open arc of `ω(P)` containing no branch point has angular
length at most `π/3`.

**(e) At least six.** With no branch point on `ω(P)`, the same argument runs with `Γ′ = ω(P)` itself (compact and connected: either the whole circle is a
boundary arc with one inner region, or one `E` region's closure contains it), and gives a unit pair. With exactly one, `Γ = ω(P)` minus that point has
length `2π`. So `ω(P)` carries `n ≥ 2` branch points, cutting it into `n` open arcs of length at most `π/3` each, whose lengths sum to `2π`: `n ≥ 6`. ∎

**The six-colour neighbour** (recorded, not used). Nothing in (a)–(e) reads the number five except "a crossing region has at most one colour left"; so the
same argument proves:

derivation: E1-GEN6
  statement: in an almost-everywhere-proper arc map with c colours satisfying (N1), if a point P lies on the boundary of k sectors with k ≥ c − 1, all of positive angle, then every open arc of ω(P) containing no branch point has angular length at most π/3, and ω(P) contains at least six branch points
  uses only: the argument of E1-COVER with "E" read as the one colour (if any) absent from P's sectors
  not claimed: that a non-exceptional branch point on ω(P) has three sectors when c = 6 — E1-SEE and E1-BAD give at most c − 2 = 4 colours there, and only when every angle at P is at most π, which strict step 5 does not supply at six colours
  argument: § E1-COVER, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: none exhibited — at c = 6 the hypothesis asks for a six-colour map with a point of five or six sectors, not known to exist
  prior art: partly: [Townsend2005] Thm 5 (ii) (the idea, at five colours)
  handoff: none — a generalization for the six-colour questions (FS-104 route M, S–V Question 2); recorded for the record job, not formalized here

### 3.5 Which points of ω(P) see two sectors

derivation: E1-BAD
  statement: let every sector at a point P have angle in (0, π]; call Y ∈ ω(P) exceptional when an edge at P lies, near P, on ω(Y), or when both branches of ω(Y) at P run, near P, inside one sector; then every Y ∈ ω(P) that is not exceptional has points of two different sectors of P on ω(Y), and there is at most one exceptional point per edge at P and at most one per sector of angle exactly π
  uses only: that ω(Y) passes through P with tangent perpendicular to Y − P; that two distinct circles, or a circle and a line, tangent at a point meet only there; that no two edges at P share a direction (positive angles); that ω(Y) minus P lies on Y's side of its tangent line at P
  not claimed: that an exceptional point carries four colours, or that one exists; nor anything for a sector of angle greater than π, where a whole arc of points is exceptional (strict step 5 excludes such angles at four and five sectors)
  argument: § E1-BAD, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: a vertex of the hexagonal seven-colouring (straight edges, angles 2π/3): no exceptional point, and both branches of ω(Y) meet two different hexagons at all 3,600 sampled Y (two_sector=3600 in control e1-see-hex); the tangency table of control e1-tangent
  prior art: partly: FS106-V3's repair of [Townsend1979ms]'s Theorem 4 corollary ("Each edge lies on at most one unit circle, so there are at most three cut points"), the same count at a point of three sectors
  handoff: de Bruijn — crosses with E1-NO45 as one of its lemmas

#### E1-BAD, the argument

Write `Y = Y_ψ`. `ω(Y)` passes through `P`, with tangent there perpendicular to `Y − P`; its two branches leave `P` in the directions `ψ ± π/2`, and every
point `w ≠ P` of `ω(Y)` has `⟨w − P, Y − P⟩ = |w − P|²/2 > 0`, so lies on `Y`'s side of the tangent line. Take one branch, leaving in direction `D`.
- If `D` is interior to the angular range of a sector `s`, the branch, near `P`, lies in a thin cone about `D` inside that range and within `r₀` of `P`:
  points of `s`.
- If `D` is the direction of an edge `e` and `e` does not lie on `ω(Y)`: `e` is a segment or a circular arc tangent to `D` at `P`, and `ω(Y)` is a circle
  tangent to `D` at `P`; two distinct such curves meet only at `P` (subtract the two equations: the common points lie on the common tangent line, which
  each meets only at `P`; control e1-tangent checks the table exactly). So near `P` the branch lies strictly on one side of `e`, in a thin cone about `D`
  that contains no other edge (no two edges at `P` share a direction), hence inside one of the two sectors adjacent to `e`.

So, unless an edge lies on `ω(Y)`, each branch runs near `P` inside a single sector, `s₊` and `s₋`. If `s₊ ≠ s₋`, `ω(Y)` has points of two different
sectors. If `s₊ = s₋ = s`, the closed angular range of `s` contains the antipodal directions `ψ ± π/2`, so the angle of `s` is at least `π`, hence exactly
`π`, with its edges at `ψ ± π/2` — exceptional by definition. **Counting.** An edge lying on `ω(Y)` is an arc of the unit circle about `Y`, so `Y` is its
centre: one `Y` per edge. A sector `s` of angle `π` with edges at `σ, σ + π` contains both branches only if `ψ ± π/2 = σ, σ + π`, so `Y = P + e(σ ± π/2)`,
and only for the one of these two on `s`'s side (the branches lie on `Y`'s side of the line through the two edges): one `Y` per such sector. ∎

*Erratum (FS131-W2): 'only for the one of these two on s's side' is false — the edges may curve to Y's side (FS131-W2 § 7.4, with `tools/fs131_w2_bad_pi.py`); a π-sector can carry two exceptional points, both normals of its two edges, among which those edges' unit-arc centres lie; the total count `≤ (edges) + (π-sectors)` stands, and E1-NO45's bound improves to `k`.* (filed by Keryx, 2026-10-04, from `.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md` § 7.4; inventory item 120)

control: e1-tangent
  of: E1-BAD — the tangency core: a segment or a circle tangent to the x-axis at P meets ω(Y), Y = (0, −1), only at P unless it is ω(Y) itself, and ω(Y)'s branch lies below (on Y's side) for the segment and for curvature in (−1, ∞), above for curvature below −1; the fault adds the edge on ω(Y)
  run: python3 ../tools/fs131_e1_tangent.py
  expect: line:1:below c=2:1:below c=1/2:1:below c=-3:1:below c=-3/2:1:below c=-1/2:1:above c=-1/3:1:above
  fault: python3 ../tools/fs131_e1_tangent.py --fault

### 3.6 The theorem

derivation: E1-NO45
  statement: in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors
  uses only: E1-COVER (at least six branch points on ω(P)); E1-BAD (at most five exceptional points); E1-SEE; (N1); (N2) — through strict step 5 at P, which makes every angle at P at most π, with at most one angle equal to π and only when k = 4; step 6 (FS106-WO, held) at the branch point found on ω(P)
  not claimed: the theorem for Jordan-arc boundaries (D-SV's Conditions 2–4) — the argument reads that boundary arcs are segments or circular arcs at three places (the arc-end types; tangent curves meeting once; finiteness), and the general form is owed; nor anything at six colours (E1-GEN6 is the part that survives); nor a local repair of Woodall's step 7 or of step 5's equality case — both are bypassed, not closed
  argument: § E1-NO45, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist — a no-go; the hexagonal seven-colouring satisfies every hypothesis but five colours and has no point of four or five sectors; the lemmas' local content is checked on it (controls e1-see-hex, e1-cross-hex)
  prior art: partly: [Townsend2005] Thm 5 (ii), pp. 192–193 (degree 4: "Hence there must be vertices in T0, and these are of degree 3", the cross-cut and the count of cut points asserted) and [Woodall1973] steps 7–8 (degrees 4 and 5, with the GAPs F1, F2); this argument, and the almost-everywhere arc-map form, not found in print (§ 2.6's queries)
  handoff: de Bruijn — replaces the open leaves `step5_eq` and `step7` (and the held step 8, which is no longer needed) of FS106-AE-MAP6 over ArcMap: AE-MAP6 = steps 1–3, strict step 5, step 6, E1-NO45, E1-NOBRANCH; crosses with E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD as its lemmas

#### E1-NO45, the argument

Suppose a point `P` has `k ∈ {4, 5}` sectors. By (N2) every angle at `P` is at least `π/3`, so each is at most `2π − (k − 1)π/3`: at most `π` when `k = 4`,
with equality only when the other three are exactly `π/3` (so at most one angle equals `π`), and at most `2π/3` when `k = 5` (control e1-count checks the
arithmetic on a grid). So E1-BAD applies, and `ω(P)` has at most `k + 1 = 5` exceptional points when `k = 4` and at most `k = 5` when `k = 5`. By E1-COVER,
`ω(P)` carries at least six branch points, so one of them, `Y`, is not exceptional. By E1-BAD, `ω(Y)` contains points of two different sectors of `P`,
whose colours differ (N1); by E1-SEE no region at `Y` has either colour. So the regions at `Y` carry at most three colours, and by (N1) `Y` has at most three
sectors; being a branch point, it has exactly three, of three distinct colours. Step 6 excludes such a point. ∎

control: e1-count
  of: E1-NO45 — the arithmetic of the count: with every angle at least π/3, four or five sectors leave at most five exceptional points and no sector wider than π; the fault drops strict step 5 (angles down to π/6) and the count fails
  run: python3 ../tools/fs131_e1_count.py
  expect: k=4: tuples=12341 max_points=5 max_arc_units=0; k=5: tuples=10626 max_points=5 max_arc_units=0; fewer_than_six_everywhere=True
  fault: python3 ../tools/fs131_e1_count.py --fault

### 3.7 A map with no branch point

derivation: E1-NOBRANCH
  statement: in an almost-everywhere-proper arc map satisfying (N1), with any finite number of colours, some point lies on the boundary of three or more sectors
  uses only: (N1); the Jordan curve theorem for closed curves made of finitely many segments and circular arcs; local finiteness; connectedness of a region; D-AEMAP
  not claimed: that the branch point found has any particular number of sectors
  argument: § E1-NOBRANCH, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring (it has branch points, as the statement says it must)
  prior art: known: [Woodall1973] p. 199 ("The only remaining possibility is that there are no vertices at all, and hence no edges. But this is clearly impossible"), there with connected graphs by definition; the arc-map argument is routine
  handoff: de Bruijn — the last step of FS106-AE-MAP6 over ArcMap; it needs the Jordan curve theorem for arc curves, which W's representation ruling (inventory item 89) noted Mathlib lacks — price it, or route around it by W's collar machinery

#### E1-NOBRANCH, the argument

Suppose no branch point. By (N1) every boundary point has exactly two sectors, so the boundary is a 1-manifold: each component is a simple closed curve or
a properly embedded line, and along a component the region on each side does not change (it could change only at a branch point). (i) **Every region has
diameter at most 1**: if `x, y ∈ R` with `|x − y| > 1`, `|x − ·|` takes the value 1 on the connected set `R`, as in E1-COVER (d). (ii) So no component is a
line (the region along one side would have points near every point of an unbounded curve), and every region is bounded; the boundary is nonempty (else one
region is the plane). (iii) Let `R₀` be a region. Its frontier is a finite union of disjoint simple closed curves (local finiteness); one of them, `C₁`,
bounds the unbounded component of the complement of its closure, so `R₀` lies inside `C₁` and is adjacent to it. Let `R₁` be the region adjacent to `C₁` from
outside; it is bounded, and the same construction gives `C₂ ≠ C₁` with `R₁`, hence `C₁`, inside `C₂`; and so on: distinct curves `C₁, C₂, …`, each inside the
next. `R_n` is adjacent to `C_{n+1}` along all of it, so `diam C_{n+1} ≤ diam R̄_n ≤ 1`; and `C₁` lies inside every `C_n`, so every `C_n` lies within distance 1
of a fixed point of `C₁`. Infinitely many boundary curves meet a bounded set, against local finiteness. ∎

### 3.8 The chain, restored for arc maps

derivation: E1-MAPS6
  statement: no five-colour almost-everywhere-proper arc map in Woodall's normal form exists
  uses only: (N1), which bounds the sectors at a point by five; step 6 (FS106-WO, held: no point of three sectors); E1-NO45 (none of four or five); E1-NOBRANCH; and through E1-NO45, strict step 5
  not claimed: the general Jordan-arc form (D-SV's Conditions 2–4), owed as in inventory item 89; that Woodall's printed steps 5 (at equality), 7 and 8 are correct — they are not used; anything about the normal-form procedure (steps 1–3) beyond the grade the claim list gives it
  argument: § E1-MAPS6, the argument
  verdict: derived
  grade: derived from: E1-NO45, E1-NOBRANCH
  minds: 1
  model: none can exist — a no-go (maps need six); the hexagonal seven-colouring is a map with seven colours
  prior art: known: [Woodall1973] Thm 6 and [Townsend1979ms] Thm 5 (the everywhere-proper theorem); the almost-everywhere arc-map form with this repair not found
  handoff: de Bruijn — FS106-AE-MAP6 over ArcMap, unconditionally (W's plan stated it with two open leaves); the Condition-5 form becomes a corollary

#### E1-MAPS6, the argument

In such a map every boundary point has two to five sectors (N1, five colours). Step 6 excludes three, E1-NO45 excludes four and five, so there is no
branch point, against E1-NOBRANCH. ∎

### 3.9 The two questions

derivation: E1-Q2
  statement: the configuration of Q2 — a point with exactly four sectors of distinct colours, every angle greater than π/3 — does not occur in a five-colour almost-everywhere-proper arc map in Woodall's normal form
  uses only: E1-NO45 at k = 4; none of Q2's further data (φ_b smallest, the window, B absent near Q, the corner forms (a) and (b)) is read
  not claimed: that Woodall's step 7 can be completed as printed, that is, that the D|E edges must end at a vertex on ω(P) in the window — the corner Q of form (a) or (b) is neither shown impossible nor needed; nor anything without (N1) per sector
  argument: § E1-Q2 and E1-Q1, the argument
  verdict: derived
  grade: derived from: E1-NO45
  minds: 1
  model: none can exist — the class is empty; the configuration's local data near P and Q (D|E edges, the window) are consistent with lemma (L), TS-U and the sector constraints, as W found, which is why the exclusion has to be global around ω(P)
  prior art: partly: [Townsend2005] Thm 5 (ii) (degree 4, asserted)
  handoff: de Bruijn — W's leaf `step7` is replaced by E1-NO45 at k = 4, not proved

derivation: E1-Q1
  statement: the configuration of Q1 — a point with consecutive sectors a, b, c of distinct colours and the angle of b exactly π/3 — does not occur in a five-colour almost-everywhere-proper arc map in Woodall's normal form, with or without the two edges of b on unit circles
  uses only: that the point has three, four or five sectors (N1, five colours); step 6 (FS106-WO, held) when three; E1-NO45 when four or five; the angle π/3 and the unit-arc edges are not read, except that the two unit-arc edges are two of E1-BAD's at most five exceptional points
  not claimed: that step 5's printed argument closes at φ = π/3 — it does not: the opposite arc has length exactly 2π/3 and Townsend's counterexample two-colours such an arc; what excludes the configuration is global around ω(P), not the opposite arc
  argument: § E1-Q2 and E1-Q1, the argument
  verdict: derived
  grade: derived from: E1-NO45
  minds: 1
  model: none can exist — the class is empty; the opposite arc alone is two-colourable (Townsend's 2π/3 picture, verified by FS106-V3 stage 1)
  prior art: partly: Townsend's ⅔π counterexample ([Townsend1979ms] p. 2) for why step 5 fails at equality; the exclusion as stated not found in print
  handoff: de Bruijn — W's leaf `step5_eq` is dropped: no step of the restored chain reads an angle equal to π/3

#### E1-Q2 and E1-Q1, the argument

Q2's point has exactly four sectors: E1-NO45 excludes it. Q1's point has the three consecutive sectors `a, b, c`, so three, four or five sectors in all
(N1, five colours); with three, step 6 excludes it, whatever its angles and edges; with four or five, E1-NO45 does. In neither case is `φ_b`, the window,
or the shape of an edge read — beyond the count of E1-BAD, in which Q1's two unit-arc edges (centred at `Q₁` and `Q₂`) are two of the at most five
exceptional points. ∎

### 3.10 The statement attacked (where the attack was aimed, and how it ended)

| attack | outcome |
|---|---|
| Q1's own configuration at `k = 4`: both edges of `b` unit arcs, centred at the ends `Q₁, Q₂` of the opposite arc | `Q₁, Q₂` are exceptional (E1-BAD (i)); at most three more exceptional points (two edges and possibly one sector of angle `π`); E1-COVER still demands six branch points on `ω(P)`, so a non-exceptional one exists. Survives |
| Q2's corner `Q` (D tip or D along `ω(P)`, `E` outside) | `Q` is not a branch point; at a tip (I, I) the outer sector (E) crosses, consistent; along `ω(P)` (A, A) with ends (A, I) — consistent. Neither is a contradiction by itself, which is why Woodall's local chase stalls; E1-COVER bounds every branch-point-free arc of `ω(P)` by `π/3` instead. Survives |
| make every branch point on `ω(P)` exceptional | needs six exceptional points; E1-BAD allows five at most (control e1-count), and none on an arc. Survives |
| a sector wider than `π` at `P` (an arc of exceptional points) | excluded by (N2) at four and five sectors (control e1-count's fault shows the claim fails without strict step 5). Survives, and names strict step 5 as consumed |
| a region occupying two sectors at a point (an arc map's component touching itself) | breaks "at most three colours ⇒ at most three sectors"; excluded by (N1) read per sector (§ 1.3), which Woodall's step 3 gives; the formalizer must state (N1) per sector. A reading, recorded |
| Jordan-arc boundaries | (a)'s arc-end types and E1-BAD's "tangent curves meet once" fail for oscillating arcs; recorded as not claimed |
| two arc-ends along `ω(P)` in one direction at `Y` | they would overlap and be one arc-end of the boundary set; not a case |
| `k = 3` (does the theorem prove too much?) | E1-CROSS leaves two colours to a crossing region, the passage contradiction and the cover both fail (an inside D/E alternation is allowed); `k = 3` is left to step 6, as it must be: the hexagonal seven-colouring has such points at seven colours, and at five step 6 kills them by a different (annulus, ⅓π) argument |
| six colours (does the theorem prove too much?) | E1-COVER survives as E1-GEN6; the colour count at a good branch point gives four, not three, so no contradiction — consistent with six-colour maps being undecided |

## Stage 4 — SAVED: what the verdicts do to the chain; the corrections owed, drafted

### 4.1 The verdicts

| question | verdict | how | grade |
|---|---|---|---|
| Q1 (F1) | **excluded** (E1-Q1) | not by closing step 5 at equality — the opposite arc alone is two-colourable there (Townsend) — but because the point it lives at is excluded: by step 6 at three sectors and by E1-NO45 at four or five | [derived] from E1-NO45 [hand, one mind] and step 6 [hand, one mind] |
| Q2 (F2) | **excluded** (E1-Q2) | not by completing Woodall's step 7 (the corner `Q` of forms (a), (b) is neither shown impossible nor needed) but by E1-NO45 at four sectors | [derived] from E1-NO45 [hand, one mind] |

Mid-job message sent to the coordinator at stage 3 (2026-10-04, after commit `3f775af7`): the lemma and the restructured chain, for FS131-W.

### 4.2 What each verdict does to the chain

- **FS106-WO** (`[Woodall1973]` Thm 6 repaired): **narrowed and restored.** Narrowed: Woodall's printed steps 5 (at `φ = π/3`) and 7 are GAPs (F1, F2,
  FS131-W), and V3's "Steps 5 and 7 use strict inequalities and survive" is withdrawn. Restored, for arc maps: Woodall's theorem holds by steps 1–3,
  strict step 5, step 6 (Townsend's lemma) and E1-NO45 in place of steps 7–8 (E1-MAPS6).
- **FS106-AE-MAP6**: **restored for arc maps** (E1-MAPS6: steps 1–3 at the grade the claim list gives them, strict step 5, step 6, E1-NO45,
  E1-NOBRANCH). The Conditions 2–4 (Jordan) form stays owed, as inventory item 89 already records. E1-NO45 reads the arc-map form at three places: an
  arc-end is inside, outside or along `ω(P)` near a point; two tangent curves meet once; finiteness. With Jordan edges, E1-BAD's count can reach two
  exceptional points per edge (an edge can oscillate about both unit circles tangent to it), so "at most five" fails as written.
- **Row 132's "maps need six"** and **`CLAUDE.md` § The aim item 4**: true as recorded only for arc maps, with this repair. W's widened correction (item
  91: "hold only modulo step 7 in every class, and modulo step 5's equality case with unit arcs") is **discharged for arc maps**. For general Jordan maps
  it stands as owed.
- **Route M's reductions** (FS111-C-SIX-M, -C-REG-EQ, -M-REDUCE-I, -M2-REDUCE-C, -VM2-EQ5): each uses FS106-AE-MAP6 "at its grade".
  - FS111-M-REDUCE-I's maps (saturated colourings whose interfaces off a locally finite `Σ` are segments and arcs of integer radius, rows 140–141) are arc
    maps, so its use is **restored**, at E1-MAPS6's grade.
  - FS111-M2-REDUCE-C and FS111-VM2-EQ5 state REG-J′-C_k over Jordan arcs ("finitely many Jordan arcs in each bounded set"). There the use is restored
    only when the arrangement is an arc map; otherwise it waits on the Jordan form. This is the point inventory item 89 already flagged for wave 9's planner.
- **W's formal plan** (FS131-W § 1.4 rulings, item 89): AE-MAP6 can be stated unconditionally over `ArcMap` with **no** open leaf for steps 5 or 7.
  `step5_eq` and `step7` are dropped, and step 8 is not needed. The new leaves are E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD, E1-NO45 and E1-NOBRANCH.
  E1-NOBRANCH needs the Jordan curve theorem for closed curves made of finitely many segments and circular arcs, which Mathlib lacks; it should be priced,
  or replaced by an argument in W's collar language. The Condition-5 form becomes a corollary.

### 4.3 The corrections owed, drafted (Keryx files them; each names its slot)

1. **`plans/FS106-derivation.md`, under the FS106-WO entry** (a dated erratum below the entry's last line, "the repair's assembly not found in print.
   *Kernel:* declined."):
   > *Erratum 2026-10-04 (FS131-W, FS131-E1).* "Steps 5 and 7 use strict inequalities and survive" (V3) is withdrawn. Step 5 reads `φ ≤ ⅓π` on the page
   > image, and at `φ = π/3` it calls the step-4 lemma at length exactly `2π/3`, which Townsend's counterexample refutes (F1). Step 7's "e must terminate
   > (which it can do only by meeting a vertex on the unit circle with center P)" fails at a two-colour corner (F2). Both are bypassed for arc maps by
   > `plans/FS131-E1-derivation.md` E1-NO45 ("in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of
   > exactly four or exactly five sectors"): Woodall's Thm 6 holds for arc maps by steps 1–3, strict step 5, step 6 and E1-NO45 (E1-MAPS6)
   > [hand, one mind per link]. The general Jordan form is owed.
2. **`plans/FS106-derivation.md`, under the FS106-AE-MAP6 entry** (a dated erratum below "*Kernel:* declined."):
   > *Erratum 2026-10-04 (FS131-E1).* For arc maps (locally finite segments and circular arcs) the statement holds without step 5's equality case and
   > without Woodall's steps 7–8: `plans/FS131-E1-derivation.md` E1-MAPS6, from steps 1–3, strict step 5, step 6, E1-NO45 and E1-NOBRANCH [derived, one
   > mind]. The Conditions 2–4 (Jordan-arc) form is owed: E1-NO45 reads the arc-map form at three places.
3. **`LEDGER.md` row 132** — in the bold statement, replace "maps need six modulo Townsend's simplification (c), which `[Woodall1973]`'s steps 2, 3, 5
   fill (in outline);" with:
   > maps need six for arc maps (segments and circular arcs), by `[Woodall1973]`'s steps 1–6, step 6 repaired by Townsend's lemma, and FS131-E1's
   > E1-NO45 in place of his steps 7–8, whose printed forms have GAPs (FS131-W: step 5 at `φ = π/3`, step 7's terminal corner); for Jordan boundaries,
   > owed;

   and replace "maps need six by `[Woodall1973]` Thm 6 with its step 6 repaired by Townsend's lemma, and by Townsend's 1979 manuscript with its step (c)
   filled by Woodall's" with:
   > `[Woodall1973]` Thm 6's steps 5 (at equality), 6 and 7 have GAPs as printed, and `[Townsend1979ms]` Thm 5 (ii) asserts its cross-cut step; FS131-E1
   > makes Townsend's degree-4 annulus rigorous and extends it to degree 5 (E1-NO45);

   and in the grade bracket replace "maps-six, Townsend's manuscript and Woodall one mind, the fill in outline;" with "maps-six for arc maps one mind
   (FS131-E1), Woodall's steps 1–3 in outline;". Add FS131-E1 to the row's milestone list.
4. **`CLAUDE.md` § The aim, item 4** — replace "Maps need six: `[Woodall1973]` Thm 6 and Townsend's manuscript, each repairing the other (`[Townsend1981]`
   prints no proof);" with:
   > Maps need six for arc maps: `[Woodall1973]`'s steps 1–6 (step 6 by Townsend's lemma) and FS131-E1's lemma in place of his steps 7–8, which have
   > GAPs as printed; for Jordan boundaries, owed (`[Townsend1981]` prints no proof);
5. **The inventory** (`plans/FS131-close-inventory.md`, after item 91 — Keryx's numbering): a line recording that item 88's and item 91's correction is
   discharged for arc maps by FS131-E1 (E1-NO45, E1-MAPS6) and stands for Jordan maps.
6. **`BIBLIOGRAPHY.md`**: no new row. Status updates:
   - `[Woodall1973]`: "§ 3 page images, pp. 198–199, read (FS131-W, FS131-E1): step 5's `≤`, step 7's strictness note".
   - `[Townsend2005]`: "pp. 192–193 re-read from renders by FS131-E1: Thm 5 (ii)'s cross-cut and cut-point count asserted; made rigorous in FS131-E1's
     E1-NO45".
