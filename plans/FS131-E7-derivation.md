# FS131-E7 — a model or a contradiction for four hypothesis sets, and a stuck vertex in a terminal map

*Job FS131-E7 (Ephodos, one mind). Brief: `data/fs131/briefs/FS131-E7-models.md`. Claim list: `data/fs131/claims-E7.md`. Scripts and scratch:
`data/fs131/e7/`. Report: `data/fs131/reports/FS131-E7.md`. Nothing in `Proofs/`, in any worktree or on any branch but `main` is changed by this
job; no search is run (standing rule 5): every object below is given by formula and every computation checks a derived shape.*

## Theorems this phase proved

Filled as the stages land; each line carries its grade and its address in this record.

- (stage 1) none — the readback.

## Stage 1 — SAVED (FS131-E7): the readback, the questions restated, what was read, the predictions

### 1.1 The quotations, checked by script

`data/fs131/e7/e7_quotecheck.py` reads the brief's 19 quotations against the files they name and the claim list's 31 Lean blocks against
their Lean files (text up to whitespace, and the line number of each declaration): **50 of 50 match, exit 0**. Planted fault (`--plant`, one
word of the first quotation misspelt): 1 failure, exit 1. The control is `quotes-brief` below.

Two things about the brief that are not mismatches of text:

- The brief and the claim list are dated 2026-10-06; this job's clock read 2026-10-06 04:53 (UTC) at its start. A time zone, not a defect.
- The brief's inference "a model inside [`sixFrag`] would sit at a point other than `0`" is checked in § 3.6: no point of `sixFrag` other than
  `0` qualifies either (a point `v` with `Covers v 1` has `|v| < 1/2`, and such a point carries one, two or six colours).

One drift, not a mismatch: at this job's start the claim list's line number for `n3_end_four_colours` (l. 1767 of `Terminal.lean` in the
worktree `fs131-w5c`) was exact; forty minutes later the declaration stood at l. 1768, the text unchanged (another job is editing that
branch). The script checks text in a live worktree and reports a drifted line as a note.

control: quotes-brief
  of: nb4p-half-hnb — the readback it rests on: every quotation of the brief and every Lean block of the claim list against its source
  run: python3 ../data/fs131/e7/e7_quotecheck.py | tail -1
  expect: quotations checked: 50  failures: 0
  fault: python3 ../data/fs131/e7/e7_quotecheck.py --plant | tail -1

### 1.2 The five questions, verbatim from `data/fs131/claims-E7.md` § The questions

> **Q1 — `a4six`.** Is there a `k`, an `F : ArcMap k`, a point `v` and colours `a`, `b` satisfying `hF`, `hv`, `hab`, `habs` and `hno` at once? Answer with such an object exhibited exactly, each of the five checked on it; or with a derivation that the five are contradictory; or with the step where neither is reached.

> **Q2 — `straddlers_third`.** Is there a `k`, an `F : ArcMap k`, a point `v`, an angle `θ` and colours `X`, `X'` satisfying `hF`, `hv`, `hcompl`, `hX`, `hX'` and `hna` at once? Answer in the same three forms.

> **Q3 — `nb4p`.** The theorem concludes `False` from `hF`, `hv`, `h4`, `hy`, `hring` and `hnb`. Is there a `G : ArcMap 6` with `v`, `ψ`, `X`, `X'` satisfying the first four at once; one satisfying the first four with `hring`; and one satisfying the first four with `hnb`? Answer each in the same three forms.

> **Q4 — `flank_ne_of_doublyShadowed`.** Is there a `k`, an `F : ArcMap k`, a point `v`, reals `α`, `κ₁`, `κ₂` and colours `g`, `h` satisfying `hF`, `h5`, `hv`, `h1`, `h12`, `h2`, `hg`, `hh` and `hD` at once? Answer in the same three forms.

> **Q5 — a stuck vertex in a terminal map of the plane.** Is there a `k ≥ 7`, an `F : ArcMap k` and a point `v` with `F.Valid`, `F.IsPlaneMap`, `F.Terminal` and `F.IsStuck v`? Answer with such a map exhibited exactly, with a derivation that none exists, or with the step where neither is reached.

> *Not claimed*: anything at six colours on a map of the plane (an object there is a valid six-map of the plane, the open problem); the truth of the five theorems (each is kernel-checked, or, for `n3_end_four_colours`, proved on its branch); any other theorem of FS131-QA4's lists.

I call Q3's three sub-questions **Q3a** (`hF`, `hv`, `h4`, `hy`), **Q3b** (those with `hring`) and **Q3c** (those with `hnb`).

### 1.3 What was read, and how far

| source | read | what it gave |
|---|---|---|
| `Proofs/HadwigerNelson/Plane/ArcMap.lean` | whole | `ArcMap`, `Γ`, `interiorPts`, `region`, `coloursAt`, `Valid`, `Covers`: the model is point-set; `k` is any natural number; a colour may be idle |
| `Plane/ValidMap/Basic.lean` l. 28–176 | the definitions | `frameX`, `tanHeight`, `TanAbove`, `hornSet`, `curvDown`, `curvUp`, `shadow`, sectors, horns, flanks, the three moves, `Terminal`, `IsStuck`, `allowedCone`, contact types |
| `Plane/LocalMap.lean` l. 97–280 | the ring vocabulary | `GermIn`, `OnRingArc` (any sub-arc of `ω(p)` inside `Γ`), `IsChangePoint`, `IsQArc` |
| `Plane/SixFragment.lean` l. 1–140 and its theorem list | header, definitions | `sixFrag`: sector flower, lenses, gaps; domain `B(0, 3/2)`; six colours at `0`; `ω(0) ⊆ Γ` |
| `Plane/ValidMap/UnitArc.lean` l. 6317–6479 | `nb4p`'s proof, whole | **the proof reads `hnb` only through its first conjunct** (§ 1.4) |
| `Plane/Woodall/Merge.lean` l. 636–700 | `recolour`, `recolour_valid` | the library's planting step: a set `W` recoloured `c`, valid when `W` has no unit pair and none with `F`'s class of `c` |
| `Plane/ValidMap/BaseSteps.lean` | the list of `bowtie_*` theorems only | the bowtie's facts at `0`, `±i`; its body (about 2,700 lines) not read |
| `plans/FS131-QA4-audit.md` §§ 2–6 | whole | the audit's rows; its two planting proposals (§ 3.2 (b), § 3.5) |
| `plans/FS112-derivation.md` l. 28–70, 250–300 | the entries | FS112-NB4P, FS112-A4SIX ("On the strip its hypothesis is vacuous in the union sense and met in the disjoint sense"), the strip, the disk, FS112-BUDGET2 |
| `plans/FS112-N-proof.md` l. 60–84, 104–110, 136–215 | § 1.4 row 1, § 2.1 W1 | NB-4's argument (straddlers, the alternation, the half-plane count); (E1) and (E2) |
| `plans/FS110-N-proof.md` § 2.2, `plans/STUB-stuck-ray.md`, `plans/FS131-E6-derivation.md` §§ 3.1–3.3 | **not read** at this stage | Q4 and Q5 are derived below from the Lean definitions; the three are read, or named as unread, in their stages |
| `LEAN.md` § The gate | the two quoted lines only | — |

### 1.4 A finding met on the way: `nb4p` never reads half of `hnb`

In `nb4p`'s proof (`UnitArc.lean` l. 6317–6477) the hypothesis `hnb` occurs once, as `(hnb k hk).1` (l. 6384): the clause about `ω(y_{j+1})`.
Its second conjunct, `¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) − 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))`, the clause about `ω(y_{j−1})`, is
never used. So the theorem holds with `hnb` weakened to its first half. It bears on Q3b and Q3c: the hypothesis that collides with the other
five is one rotational sense of (E2), not both. Inventory kind: generalization.

derivation: nb4p-half-hnb
  statement: the proof of `nb4p` at `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` l. 6317–6477 uses `hnb` only through its first conjunct, `¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) + 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))` for `j < 6`; so `False` follows from `hF`, `hv`, `h4`, `hy`, `hring` and that conjunct at every `j < 6`
  uses only: the text of the proof: `hnb` occurs once after the signature, as `(hnb k hk).1` (l. 6384), feeding `straddlers_third`
  not claimed: that the second conjunct alone suffices in Lean (true by the mirror `z ↦ z̄` at [hand], § 5.4, and not checked by the kernel); that either conjunct can be dropped from the hand statement FS112-NB4P without re-reading its three minds' proofs
  argument: § 1.4 A finding met on the way: `nb4p` never reads half of `hnb`
  verdict: derived
  grade: hand
  minds: 1
  model: `nb4p`'s own proof text; the count is the control `hnb-occurrences`
  prior art: owed — not searched; a fact about this repository's proof, not about the literature
  handoff: de Bruijn — the planner's choice: restate `nb4p` with the one conjunct (a strictly stronger theorem, no proof change beyond the binder), or leave it and note the idle half in the docstring

control: hnb-occurrences
  of: nb4p-half-hnb — the uses of `hnb` inside `nb4p`'s proof body, each printed with whether it takes the first projection
  run: python3 ../data/fs131/e7/e7_hnb.py
  expect: uses of hnb in the proof body: 1  through .1: 1  through .2 or whole: 0
  fault: python3 ../data/fs131/e7/e7_hnb.py --plant

### 1.5 Predictions, registered before any written derivation

Said plainly: by the time these were written I had worked each question in my head from the definitions, so these are predictions about what
the written derivations and their checks will confirm, not priors formed cold. Each decides what the next stage builds.

| id | prediction | probability | decides |
|---|---|---|---|
| P1 | Q1: a model at `k = 6` with both absent colours live on the ring (a four-petal Reuleaux flower) passes its exact checks | 0.85 | whether Q1's verdict is "model at the readers' parameter" or "model only with idle colours (`sixFrag` padded, `k = 8`)" |
| P2 | Q2: the same flower with one small cell recoloured is a model at `k = 6` | 0.8 | whether Q2 needs a second object |
| P3a, P3c | Q3a and Q3c: that recoloured flower is a model of both | 0.8 | the same |
| P3b | Q3b: neither a model nor a contradiction is reached in this job; if decided later, a model exists | 0.7 that it stalls here; 0.6 for a model, given a decision | whether `hnb` is idle (it is, if Q3b is contradictory) |
| P4 | Q4: a model at `k = 9`, two fresh colours planted in `sevenBrickMap`, each shadow coming from a horn at the pole on the far side; no contradiction | 0.85 | whether `flank_ne_of_doublyShadowed` is empty where N4-STUCK reads it |
| P5 | Q5: yes, at `k = 12`: a small bowtie planted in three bricks of `sevenBrickMap`, terminal because no other point has a repeated colour or a horn | 0.75 | the bearing line for `plans/STUB-stuck-ray.md` and the stuck family's docstrings |

## Stage 2 — SAVED (FS131-E7): recognition, run on the five claims before any derivation

`ephodos-recognition` invoked fresh. For each claim: the stall read, the problem written for a stranger, the features sorted with their
receipts, the homes tried, the description that forces the answer. The derivations are §§ 3–7; a receipt marked (§ n) is discharged there.

### 2.1 Q1–Q3, one object: "which sets of diameter 1 hold both a point and part of its unit circle?"

**The stall read.** The audit's wording is "a result proved only at instances, and no instance": the three theorems were derived inside a
proof by cases about six-coloured maps, and the only exact six-coloured objects with a four-colour vertex on file (the strip, the disk) have
a covering pair at it, so branch 1 of the dichotomy had no example. The candidate handed down, `sixFrag`, is the costume's neighbour: it was
named because it is the six-coloured fragment the library holds, not because its vertex has two absent colours (it has none).

**For a stranger (a convex geometer).** Colour an open neighbourhood of the closed unit disc with `k` colours, the classes bounded by finitely
many segments and circular arcs, no class holding two points at distance exactly 1. At the centre `v` exactly `k − 2` colours accumulate. Can
the two others, `a` and `b`, each occur near the unit circle `ω(v)` without ever both accumulating at one of its points (Q1)? Can they both
accumulate at a point `y′ ∈ ω(v)` while no boundary arc of the colouring runs along the unit circle about `y′` through the point of `ω(v)`
`60°` before it (Q2)? With `k = 6`: can `ω(v)` pass from `a` to `b` across a single boundary point (Q3a), with the six points of its
`60°`-orbit all off the boundary arcs lying along `ω(v)` (Q3b), or with no boundary arc along the unit circle about one orbit point through
its neighbour (Q3c)? Words the reader stops at: none.

**This is a** covering problem for sets of diameter at most 1. A class that accumulates at `v` and reaches `ω(v)` from inside is a set of
diameter at most 1 holding points near `v` and near `ω(v)`; the widest such set is the open Reuleaux triangle on `v` and two points of
`ω(v)` `60°` apart (the three open unit discs about the vertices of a unit equilateral triangle), whose cone at `v` is `120°` wide and whose
share of `ω(v)` is `60°`. So the ring's inner side is covered by one `60°` petal per colour of `v` and the rest by the absent colours.

**Features, sorted.**

| feature | sort | receipt |
|---|---|---|
| "a colour of `v` occupies at most `60°` of the ring's inner side, and then its sectors at `v` lie in a `120°` cone" | determines | FS112-L60 and FS112-U1 (kernel: `UnitArc`'s L60, U1 families); the flower attains both (§ 3) |
| the number of colours at `v` being `k − 2`, i.e. exactly two absent | determines, through its consequence "the inner side has `360° − 60°·(k − 2)` to give to two colours" | at `k = 6`: `120°`, in four gaps (§ 3.5: fewer gaps force a horn of an absent colour at `v`, three force three absent colours) |
| `k = 6` itself | accompanies Q1 and Q2 (their statements are for every `k`); determines Q3 (`G : ArcMap 6` is in the statement) | a model of Q1 with idle colours at `k = 8` (§ 3.6) and one at `k = 6` (§ 3) |
| "no covering pair", union sense | consumed only as: `cl(region a) ∩ cl(region b) ∩ ω(v) = ∅` | § 3.4 — the two closures are separated by the petals' `60°` arcs |
| the strip and the disk as the examples | accompanies | both have covering pairs at their four-colour vertices (FS112-A4SIX's own note); neither is needed |
| `sixFrag` as the candidate | accompanies | § 3.6: no point of it has exactly two absent colours and `Covers v 1` |
| whether the absent colours appear on the ring at all | **unsorted by the statement** — `hno` holds vacuously when they are idle | § 3.6 names the degenerate model so that nobody takes it for the meant one |

**Homes.**

1. *Convex geometry: sets of constant width, Reuleaux's triangle.* Name there: a complete set of diameter 1 through `v`. What the field holds:
   every set of diameter `d` lies in a set of constant width `d` (Pál's completion theorem — **recalled, not read**; nothing below rests on it:
   the one fact used, that the open Reuleaux triangle has no two points at distance 1, is proved in § 3.2 in two lines). Dictionary: colour of
   `v` reaching the ring ↔ petal; cone of the colour at `v` ↔ the triangle's `120°` corner; ring arc of `Γ` with that inner colour ↔ the
   triangle's far side. Test "predicts a neighbour": yes — it predicts that four petals leave four `30°` gaps whose inner apexes are
   `2·2 sin 15° = 1.0353…` apart across the centre, barely above 1, so the picture exists and is nearly rigid (§ 3.5). **Adopted.**
2. *This project's own: FS112's (E1)/(E2) and the ring's `60°` twist (G91).* Name there: a four-colour vertex whose ring's change points are
   saved by arcs of its own circle. It supplies the reading of Q3: Q3c is (E1) with no (E2), Q3b is (E2) with no (E1). It supplies no object.
   **Kept as the checklist the object is read against** (the ring of § 3's flower carries (Q) arcs, as row 149 requires of any four-colour
   vertex that lives past `1 + ε` in the non-Siamese class; the flower is non-Siamese).
3. *The audit's planted picture (fresh colours on a brick background).* It would give Q1 and Q2 at large `k` at once and cannot give Q3
   (`k = 6` is in the statement). **Killed for this group** by home 1 giving `k = 6`; it is the home of Q4 and Q5.

**Where the recognition differs from the brief** (a finding, as the workflow asks): the brief's candidate and its inference ("a model inside
[`sixFrag`] would sit at a point other than `0`") are both set aside — the model is a new fragment, a flower of four petals where `sixFrag`
has six sectors. And the question the brief did not pose is the one the statement leaves open: whether the model's absent colours are live.

### 2.2 Q4: "the unit parallel of a circular arc is the concentric arc"

**The stall read.** A known calculus almost applies: the audit found flanks under Condition 5 (E6's map) and found the double shadow failing
there. The misplaced feature is *where the shadows come from*.

**For a stranger (a differential geometer).** Two disjoint open sets `g`, `h` in the plane, neither holding two points at distance 1. Near a
point `v`, `g` fills the thin region just above a circular arc through `v` of curvature `κ₂`, and `h` the thin region just below a tangent
arc of curvature `κ₁ < κ₂`, both curvatures strictly between `−1` and `1`. Can some thin region between two further tangent arcs lie, near
`v`, both in the set of points at distance exactly 1 from `g` and in the set of points at distance exactly 1 from `h`? No boundary arc may
have radius 1.

**This is a** statement about parallel curves (offsets): the points at distance 1 from a circle of radius `R` are the concentric circles of
radii `R ± 1`. An arc of upward curvature `τ` through the pole `S′ = v − n` has its unit parallel through `v` with curvature
`τ/(1 − τ)`, and one through `N = v + n` with curvature `τ/(1 + τ)` — the library's `curvUp` and `curvDown` (`ValidMap/Basic.lean` l. 65–70).

**Features, sorted.**

| feature | sort | receipt |
|---|---|---|
| the shadow of `g` on the band comes from a `g`-region at the pole **below**, bounded above by an arc tangent to the axis | determines | § 6.2: a `g`-region at the upper pole shadows everything above its parallel, the flank of `g` included, against validity |
| `−1 < κ₁`, `κ₂ < 1` and Condition 5 | determine only through "no arc of radius 1", which the parallels respect when the poles' arcs have curvature in `(−1/2, 1/2)` | § 6.1's curvatures `1/5`, `1/10`, `1/2`, `3/4` |
| `g ≠ h` | the theorem's conclusion; a model has it by construction | — |
| a horn of a third colour between the flanks | accompanies — the statement has no `IsHorn` | § 6.4 gives the variant with one |
| the stuck vertex N4-STUCK reads the theorem at | accompanies the question (the reader's further hypotheses are declared refuted under Condition 5) | `Contact.lean` l. 2395's docstring |
| the number of colours | accompanies | two fresh colours on any valid Condition-5 background |

**Homes.** (1) *The project's N4-SHADOW calculus*, in Lean as `curvDown`/`curvUp` — adopted; the transfer's changed step: the calculus is
second-order in the hand records, and here both validity and the shadows are made exact by concentric circles (a triangle inequality about
a common centre; an intermediate-value step on one circle). (2) *E6's twelve-colour map* — killed by the audit itself (its shadows are
complementary). (3) *The bowtie* — killed by `h1`, `h2` (its horn bounds are `±1`) and Condition 5.

### 2.3 Q5: "with spare colours, a stuck vertex is a local picture and terminality is a statement about where pictures were drawn"

**The stall read.** A wall that describes a counterexample: the audit asks what the *completed bowtie* would have to satisfy everywhere. The
description that moves it asks what `Terminal` reads at a point at all.

**For a stranger (a combinatorial geometer).** A locally finite colouring of the plane by `k ≥ 7` colours with circular-arc boundaries, no
class holding two points at distance 1. Call a point *eligible* if some colour has two or more sectors at it, or some sector at it is a cusp
between two tangent arcs. A move is available only at eligible points (the three moves' definitions each start from a repeated colour or a
horn). Is there such a colouring with an eligible point at which no move is available, and none available anywhere else?

**This is a** planting problem: `Terminal` is vacuous at every non-eligible point, so a map whose eligible points are exactly one stuck
vertex is terminal. Colours used once on a set of diameter below 1 constrain nothing; so the vertex's picture can be drawn in spare colours
inside tiles of any valid plane map that has no eligible point.

**Features, sorted.**

| feature | sort | receipt |
|---|---|---|
| `Terminal` reads only points with a repeated colour or a horn | determines | the definitions of `MergeAvailable` (`2 ≤ n ∧ HasSectors v c n`), `RayAvailable` and `ShaveAvailable` (each an `IsHorn`), `ValidMap/Basic.lean` l. 143–160 |
| `k ≥ 7` | determines only through "a valid plane map without eligible points exists, with colours to spare" | `sevenBrickMap` at 7; five more colours for the picture (§ 7); at `k = 6` the background is the open problem |
| the bowtie's eleven tiles and its domain | accompany | § 7 uses three small discs: the vertex and its two poles |
| unit arcs at the stuck vertex | determine | under Condition 5 a stuck vertex in a terminal map is refuted (`n4_fin`'s chain); the picture's horn is bounded by `ω(N)` and `ω(S′)` |
| the completion's cells | accompany | no cell is needed when each disc lies inside one brick |

**Homes.** (1) *The audit's § 3.2 (b), "a planted picture", with `ArcMap.recolour`* — adopted. (2) *The audit's § 3.5, "the completed
bowtie"* — set aside, not killed: it would also work, at several times the size, and its terminality elsewhere is the unchecked part.
(3) *FS-115's question (c)* — the six-colour form; this question's answer does not transfer to it (the spare colours are the whole mechanism).

### 2.4 The grokkings that bear on this job's objects

**bears**: G91 — its Do, "before building on a ring type's structure lemmas, ask whether the type is inhabited", is Q1–Q3 word for word;
G83 — the flower is a valid fragment by formula about a four-colour vertex whose ring carries (Q) arcs, on a disc of radius `5/4`, below
the killing test's `φ²/√2 ≈ 1.851`, so the test does not fire and the object is a datum for FS-124; G85/G84 — the unit parallel of an
interface is Q4's whole mechanism; G92 — `nb4p`'s idle half of `hnb` and `a4six`'s reach to every `k` are instances; G21 — every model
below pleases, so each gets a control that can fail and a note of what it does not exercise. **falsifiable here**: none (no reading's
killing test is in reach). silent: every other entry.
