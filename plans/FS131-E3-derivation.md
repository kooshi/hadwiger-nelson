# FS131-E3 — Woodall's step 3 for the Lean chain: the derivation record

*Job FS131-E3, Ephodos (Opus 5.5), 2026-10-04. Brief: `data/fs131/briefs/FS131-E3-woodall-step3.md`, with `plans/STANDING-RULES.md`. Claim list:
`data/fs131/claims-E3.md`. Fences: none (the brief: "nothing in this milestone is blind"). Working files: `data/fs131/e3/`; tools `tools/fs131_e3_*.py`.*

## Theorems this phase proved

*(Filled at the last stage; see the last SAVED stage.)*

## Stage 1 — SAVED: the readback, the questions, a defect found while reading, the registered predictions

### 1.1 Quotations against their sources (standing rule 3)

Checked by script (`git show f73cb1e3:<file>` and a substring test, paragraph by paragraph; the script is not kept, its output is below).

| quotation | in | source | result |
|---|---|---|---|
| Q1's opening ("**Q1 — Woodall's step 3, as stated.** Is `exists_woodallMerged` true: … in which") | the brief, § The questions | `data/fs131/claims-E3.md` § The questions | verbatim (the brief quotes a prefix and says so with "— source:") |
| Q2's opening ("**Q2 — a route around it.** Does the chain's conclusion (`aeMap6` …) follow without the modification — for instance by") | the brief | the claim list § The questions | verbatim (prefix) |
| `SectorsAt` and `WoodallMerged`, with docstrings | the claim list § The sources | `Proofs/HadwigerNelson/Plane/Woodall/Basic.lean` at `f73cb1e3` | verbatim (both paragraphs) |
| `exists_woodallMerged`, with docstring | the claim list | `Proofs/HadwigerNelson/Plane/Woodall/Steps.lean` at `f73cb1e3` | verbatim |
| `aeMap6`, with docstring | the claim list | the same file | verbatim |
| the FS110-W-MERGE entry ("**FS110-W-MERGE — Woodall's step 3 almost everywhere for curved arcs: …**" and its *Proof* paragraph) | the claim list | `plans/FS110-derivation.md` line 51 ff. | verbatim |

No mismatch. The brief's two quotations are prefixes of the questions and are marked as such.

### 1.2 What was read, with addresses (standing rule 10)

- **`[Woodall1973]` § 3 step 3**, p. 197, read from the page image (PDF page 11 of `~/source/library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf`,
  rendered at 130 dpi). The two sentences the chain names: *"Suppose that one of these sectors subtends an angle less than π at P. Then there exists ε > 0
  such that each point Q in that sector, whose distance from P is less than ε, has this property: each unit circle through Q, except for those through P,
  passes through X or Y."* and *"In fact, we can do this unless X and Y are completely contained within the "cone" outside two unit discs touching each
  other at P. Moreover, in this exceptional case it is easy to see, by a similar argument, that we may extend X and Y if necessary so that they fill the
  whole of this "cone" within some distance ε of P."* The step's conclusion: *"if two of the regions are in the same set, then each of them subtends angle
  0 at P."* Read in full for step 3; steps 1–2 (p. 196–197) for the "transferred regions" argument.
- **FS110-W-MERGE's argument**: `plans/FS110-N-proof.md` § Continuation — FS110-N3, Stage N3-2, §§ 2.1–2.3 (N3-CONF, N3-CLEAR, N3-UP, W-MERGE and its
  iteration, N3-DEG), lines 577–645; `plans/FS110-NB3-verification.md` §§ 2.1–2.3 (the translation lemma, N3-CONF/CLEAR/UP, W-MERGE with refinements (a)
  generic `ρ` and (b) the fill, N3-DEG by Gordan), lines 79–170. Both read in full. Both are set in `𝓜_K` (bounded complexity) **under Condition 5**;
  N3-CONF's finiteness of contacts and N3-DEG's strictness use Condition 5 (NB3 § 2.2, closing paragraph: "W-MERGE's clearance does not need Condition 5
  … but N3-CONF's finiteness and N3-DEG's strictness do").
- **The chain as it stands** at `f73cb1e3`: `Plane/Woodall/Basic.lean` (all), `Plane/Woodall/Steps.lean` (all: `exists_sectorsAt`, `coneAt_nonempty_of_mem_closure_region`,
  `SectorsAt.coloursAt_eq`, `exists_woodallMerged`, `step5_lt`, `step6`, `false_of_four_le_sectors`, `exists_three_le_sectors`, `aeMap6_normal`,
  `aeMap6_merged`, `aeMap6`), `Plane/ArcMap.lean` (all), `Plane/LocalMap.lean` §§ cones and germs, `Plane/Woodall/Collar.lean` (statements of `woodall_step4`,
  `townsend_lemma`, `false_of_collars_closed`, `collarAt_shadow_inner/outer`), `Plane/SVMap.lean` (`ts_t`: *"a point of at least three colours within
  `1/√2 + ε` of every point"*), `Plane/ValidMap/Basic.lean` line 205 (`Condition5 : ∀ a ∈ F.arcs, ∀ p, (a.carrier ∩ F.dom ∩ sphere p 1).Finite`).
- **The implementers' notes**: `plans/FS131-IW-implementation.md` Stage 6 (FS131-IWb: the route for `exists_sectorsAt`, the re-pricing of
  `exists_woodallMerged`), on `fs131-ww`; `plans/FS131-I3-implementation.md` Stage 11 (FS131-I3h: the draft `IsSectorChart` / `localSectors`), on `fs131-w3`;
  `Plane/LocalStructure.lean` on `fs131-w3` (`GoodAt`, `exists_goodAt`).
- **The restored chain's derivation**: `plans/FS131-E1-derivation.md` §§ 3.0–3.8 (E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD, E1-NO45, E1-NOBRANCH, E1-MAPS6).

### 1.3 The questions, restated (verbatim from `data/fs131/claims-E3.md` § The questions)

> **Q1 — Woodall's step 3, as stated.** Is `exists_woodallMerged` true: does every valid plane arc map have a valid plane arc map, Condition 5 kept, in which
> every colour carried by two sectors at a point is carried by zero-angle sectors only? Verdicts: **derived** (the modification with every clause — which
> vertices, which recolouring, why it stays valid, why it stays an arc map locally finite, why it is a plane map, why Condition 5 is kept, why no new
> repeated colour appears — written so a planner can state its children); **refuted** (a valid plane arc map no modification of this kind can merge,
> exhibited); or a **GAP** at a named step.

> **Q2 — a route around it.** Does the chain's conclusion (`aeMap6`: no valid five-coloured plane arc map) follow without the modification — for instance by
> proving E1-NO45 and step 6 (no point of three, four or five sectors) for maps not in normal form, reading only the cone clause of `SectorsAt` — and if so,
> at what cost in new lemmas? A route that avoids `exists_woodallMerged` entirely is as good an answer as a derivation of it.

### 1.4 A defect found while reading the definitions (before any prediction was registered)

Reading `SectorsAt` against `WoodallMerged`: a picture is any cyclic list of closed arcs with adjacent colours distinct and the right cones, and nothing
makes it minimal. At a common boundary direction `θ` of a sector of colour `A` and the next of colour `B ≠ A`, two zero-angle sectors may be inserted —
a `B`-horn, then an `A`-horn: adjacency still holds (`A | B | A | B`), `d` stays monotone with the same wrap, and every cone is unchanged because `θ` already
lies in both neighbours' closed arcs. The result is again a `SectorsAt`, now with `A` repeated on a sector of positive angle, so `WoodallMerged`, which
quantifies over **every** picture, fails at every point that has a picture with two or more sectors. Since every valid plane map has such a point, no valid
plane map satisfies `WoodallMerged` (or `WoodallNormal`, by the same insertion at a point of three sectors), and `exists_woodallMerged` is false wherever a
valid plane arc map exists — at `k = 7`, by the hexagonal seven-colouring. The entry, its argument and its control are Stage 3 (§ 3.1). Message sent to
"main" at 2026-10-04 14:00 UTC (approximately), before this stage was saved.

Because this was found before the registration, Q1 *as stated* carries no registered prediction. The predictions below are about the repaired statement
(the ∃-form, § 3.1's fix) and about Q2.

### 1.5 Registered predictions (before the written derivation; each names the decision it changes)

| id | prediction | probability | what it decides |
|---|---|---|---|
| E3-P1 | the repaired step 3 (∃-form: at every point some picture has its repeated colours on horns) is TRUE for every valid plane arc map, as a modification by small discs, with a derivation precise enough for a planner | 0.80 | a derived modification for the planner, or a GAP named for Poros |
| E3-P2 | the repaired step 3 needs no Condition 5 on the input (FS110's W-MERGE used it for finitely many contacts and for the cone's strictness; neither is needed for a merged picture) | 0.75 | whether `exists_woodallMerged` may keep its current hypotheses, or must assume `F.Condition5` |
| E3-P3 | no route avoids a modification altogether: some valid-looking configuration (a vertex whose repeated colour is mergeable) defeats every lemma of the chain at that vertex, so the chain must see a merged map | 0.85 | whether Q2 recommends rewriting step 6 / E1-NO45 for unmerged maps, or a local modification |
| E3-P4 | `aeMap6` needs the merged form only on `closedBall 0 3` and only at points of at least three colours, with edits to `aeMap6_merged`, `aeMap6_normal` and `false_of_four_le_sectors` and no new mathematics | 0.95 | which statement the planner states in place of `exists_woodallMerged` |

## Stage 1 — SAVED

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh)

**The stall, read.** Two of the skill's shapes at once. *A known theorem that almost applies*: FS110-W-MERGE is step 3 with two minds, but in `𝓜_K`,
under Condition 5, by contacts on `ω(v)` (the allowed cone `D_c(v)`), and with the horn end sandwiched by N3-UP; the Lean statement assumes none of
the first three. *A wall that describes a counterexample*: Woodall's cone, where merging fails. And a third, found in Stage 1: the conclusion as stated
is unsatisfiable (phantom horns), so the target itself must be re-posed before any route is priced.

**For a stranger** (a plane geometer, and an analyst who works on feasible sets): the plane is cut by a locally finite family of segments and circular
arcs into open cells, each given one of `k` colours, so that no two points of open cells of one colour are exactly 1 apart. At a point `v` each colour
approaches along a closed set of directions (its cone), a finite union of closed arcs. A colour is *badly placed* at `v` when it approaches along two
separated arcs of positive length, or when another colour pokes into the inside of its arc along a single direction. Unknown: a recolouring inside small
discs about finitely many points that leaves no badly placed colour at any point of a given compact set and keeps the no-unit-pair property. *This is a*
local saturation of one colour class across a wedge, and its clearance question — is the wedge at distance `≠ 1` from the class? — is the question
"does a unit circle through a point of the wedge cross the class near `v`?"

**Features, sorted** (receipts in Stage 3's entries):
| feature | sort | receipt |
|---|---|---|
| Condition 5 | accompanies | E3-W reads none of it; W-MERGE used it for finitely many contacts and for the cone's strictness, and neither is read by the merge the chain needs |
| the contacts of `c` on `ω(v)` and the cone `D_c(v)` | accompany for merges between two positive-angle sectors; determine only for merging a horn | E3-W runs with two open ray segments and `ω(v) ∩ S = ∅` alone |
| "repeated colours sit on horns" (Woodall's conclusion) | accompanies for the chain | the chain kills every horn whose neighbours differ (`step5_lt`), so it needs only "positive sectors carry distinct colours, and every horn sits between distinct colours" (E3-NICE) |
| the gap between the two sectors is `< π` | determines E3-W | the sagitta bound `r₁ cos(α/2) − r₁²` vanishes at `α = π`; control `e3-sagitta` |
| every point of the plane | accompanies | `aeMap6` reads the picture at the point `ts_t` finds (`|v| < 1/√2 + 1`) and at one point of `ω(v)`: `closedBall 0 3` (E3-CHAIN) |
| "every picture" in `WoodallMerged` | determines the vacuity | E3-PHANTOM |

**Homes.** (H1) *Woodall's own criterion*, p. 197: "each unit circle through Q, except for those through P, passes through X or Y" — the old proof
applies at once to two sectors of positive angle; made quantitative by the sagitta of a unit circle in a small disc, it is E3-W, and the exceptions
vanish: no cone, no contacts, no Condition 5, and the same lemma removes a horn of another colour poking into a sector (a neighbour it predicts).
(H2) *Feasible sets under a constraint qualification* (nonsmooth analysis): the clear set near `v` is the feasible set of the semi-infinite system
`|z − y| ≠ 1, y ∈ S near ω(v)`, its linearized cone is `D_c(v)`, and `int D_c(v) ≠ ∅` is Mangasarian–Fromovitz's condition; this is W-MERGE's mechanism, and
the horn end is the second-order case where the qualification direction `n` propagates feasibility (N3-UP). It is needed only to merge a horn with a
sector, which the chain does not need. (H3) *This project's contact theory* (G84: a saturated class is carved by unit circles about its own points): the
merge is a local saturation; it adds no theorem the first two lack. **Adopted: H1**, carried across as E3-W with the one changed step named — Woodall's
"angle less than π" becomes an explicit radius `r₁ cos(α/2)/2`, proved by the sagitta, and his exception "except for those through P" is E1-SEE
(no point of the class on `ω(v)`).

**The class.** E3-W holds for any open set `S` with no unit pair and any point `v` with `ω(v) ∩ S = ∅`: no colouring, no map, no arcs.

**Prior art.** `[Woodall1973]` p. 197, step 3 (read, page image) — the criterion, asserted without a computation; FS110-W-MERGE (this project, two minds,
Condition 5, contacts); E1-RAY (this project) uses the same first-order picture. The sagitta form and the reduction to "positive sectors distinct, horns
between distinct colours" not found in print; no new search run (the object is a lemma inside a held proof; FS131-E1's queries of 2026-10-04 covered
Woodall's step 3 and its repairs).

## Stage 2 — SAVED

## Stage 3 — SAVED: the derivation

*Notation.* `e(θ)`, `ω(p)`, `B(p, r)` as in FS131-E1 § 3.0. A **chart** at `v` is FS131-I3h's `IsSectorChart` (draft `data/fs131/i3/h/LS.lean` on `fs131-w3`): for
`r ≤ r₀` the interior points of `B(v, r)` are finitely many open preconnected **chart sectors** between sorted branches, sector `i` with cone
`[βᵢ, βᵢ₊₁]`; each lies in one colour class. A **run** of colour `c` is a maximal cyclic block of consecutive chart sectors of colour `c`.

### 3.1 The defect: phantom horns

derivation: E3-PHANTOM
  statement: for every arc map F, point v and picture F.SectorsAt v n d c with n ≥ 2, there is a picture at v with n + 2 sectors in which one colour is carried by a sector of positive angle and by a sector of angle zero
  uses only: that SectorsAt reads cones only (closed arcs, adjacency of colours, the 2π wrap); that a boundary direction of two sectors lies in both closed arcs
  not claimed: that the inserted horns exist in the map; that pictures are unique up to this insertion
  argument: § E3-PHANTOM, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: the edge midpoint of the hexagonal seven-colouring — n = 2, d = (−π/2, π/2, 3π/2) becomes n = 4, d = (−π/2, π/2, π/2, π/2, 3π/2) (control e3-phantom)
  prior art: owed — a defect of this project's definitions at f73cb1e3; no literature search applies
  handoff: de Bruijn — the ∃-forms of § 4.1 replace WoodallMerged and WoodallNormal (inventory item 158, ruled 2026-10-04)

control: e3-phantom
  of: E3-PHANTOM — the phantom picture satisfies SectorsAt's clauses at the model point and violates WoodallMerged; the fault inserts one horn only
  run: python3 ../tools/fs131_e3_phantom.py
  expect: honest=True:ok merged=True phantom=True:ok phantom_merged=False
  fault: python3 ../tools/fs131_e3_phantom.py --fault

#### E3-PHANTOM, the argument

Some sector has positive angle (the angles sum to `2π`); rotate so that it is sector `0`, with `θ = d 1` its end and sector `1` of colour `B = c 1 ≠ A = c 0`.
Set `d′ = (d 0, θ, θ, θ, d 2, …, d n)`, `c′ = (A, B, A, B = c 1, c 2, …)`: the inserted sectors are a `B`-horn and an `A`-horn at `θ`. `d′` is monotone with the same
wrap; adjacent colours differ (`A, B, A, B, …` then the old sequence); `angleIcc θ θ = θ + 2πℤ` lies in `angleIcc (d 0) θ` and `angleIcc θ (d 2)`, so every
cone union is unchanged. Sector `0` (positive) and the `A`-horn carry `A`. ∎ **So** `WoodallMerged` and `WoodallNormal` fail at every point carrying a
picture with two or more sectors; a valid plane map has a point of two or more colours (a dense open class would hold a unit pair) and a picture there
(`exists_sectorsAt`), so no valid plane map satisfies either. Their only inhabitants are one-colour maps, which is why no spec example caught it.

derivation: E3-Q1
  statement: every valid plane arc map has a valid plane arc map, Condition 5 kept, in which every colour carried by two sectors at a point is carried by zero-angle sectors only
  uses only: E3-PHANTOM; exists_sectorsAt at one point of two colours of F′; that a valid plane map has such a point
  not claimed: anything at k ≤ 5, where the statement holds vacuously and is the theorem aeMap6 itself
  argument: § E3-PHANTOM, the argument
  verdict: refuted: k = 7 and F the hexagonal seven-colouring (valid, plane): every valid plane F′ carries a phantom picture, so F′.WoodallMerged fails
  grade: derived from: E3-PHANTOM
  minds: 1
  model: F = the hexagonal seven-colouring, side s with 1/√7 < s < 1/2
  prior art: owed — a defect of the statement at f73cb1e3; no literature search applies
  handoff: de Bruijn — exists_woodallMerged restated as in § 4.1

### 3.2 Woodall's criterion, quantitative

derivation: E3-W
  statement: let S ⊆ ℂ be open with no two points at distance 1, v a point with ω(v) ∩ S = ∅, d₁ < d₂ < d₁ + π with α = d₂ − d₁, and 0 < r₁ < cos(α/2)/2 with v + s·e(dᵢ) ∈ S for 0 < s < r₁ (i = 1, 2); then every z = v + r·e(φ) with d₁ < φ < d₂ and 0 < r < r₁cos(α/2)/2 is at distance different from 1 from every point of S
  uses only: that a unit circle meets a disc of radius r₁ < 1 in its minor arc between two points of the disc's boundary; the sagitta 1 − √(1 − ℓ²/4) ≤ r₁² of a chord of length ℓ ≤ 2r₁; that the open sector {v + s·e(ψ) : 0 < s < r₁, d₁ < ψ < d₂} is a component of the disc minus the two segments and v; validity of S at one pair
  not claimed: anything for α ≥ π (the bound r₁cos(α/2) − r₁² vanishes at π); anything at a horn, which gives no open segment; anything about points of the domain off the sector
  argument: § E3-W, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: S = the class of a sector of angle 2π/3 at a vertex of the hexagonal seven-colouring, d₁, d₂ inside two sectors of one colour — no such vertex exists there (its colours are distinct), so the lemma's model is a two-sector colour class built by hand: S = {v + s·e(ψ) : 0 < s < 1/4, ψ ∈ (0, 1) ∪ (2, 2.5)} (radians), whose diameter is below 1 and ω(v) ∩ S = ∅
  prior art: partly: [Woodall1973] p. 197, step 3 ("each unit circle through Q, except for those through P, passes through X or Y"), asserted without a radius; FS110-W-MERGE's N3-CLEAR by contacts
  handoff: de Bruijn — the lemma, over sets (no map), with E1-SEE supplying ω(v) ∩ S = ∅

control: e3-sagitta
  of: E3-W — the sagitta bound: unit-circle arcs inside B(v, 0.1) with endpoints in directions [0, α] stay at distance ≥ r₁cos(α/2) − r₁² from v; the fault shrinks the allowance a hundredfold
  run: python3 ../tools/fs131_e3_sagitta.py
  expect: arcs=6560 violations=0
  fault: python3 ../tools/fs131_e3_sagitta.py --fault

#### E3-W, the argument

Let `y ∈ S`, `|z − y| = 1`. Then `|y − v| ≠ 1` (`ω(v) ∩ S = ∅`), so `v ∉ ω(y)`. `A = ω(y) ∩ B(v, r₁)` is an open arc of `ω(y)` (connected; it contains `z`).
If `A` meets one of the two open segments, a point of `S` is at distance 1 from `y ∈ S`: excluded. Otherwise `A` lies in `B(v, r₁)` minus the segments and
`v`, whose component through `z` is the open sector `W` of directions `(d₁, d₂)`; so `A ⊆ W`, and its endpoints `p, q` lie on `|x − v| = r₁` with directions in
`[d₁, d₂]`. `A` is the minor arc between `p` and `q` (the major arc has length `> π` and does not fit in a disc of diameter `2r₁ < 2`), so each point of `A` is
within the sagitta `≤ r₁²` of the segment `[p, q]`, whose points are at distance `≥ r₁cos(α/2)` from `v`. Hence `r = |z − v| ≥ r₁cos(α/2) − r₁² > r₁cos(α/2)/2`,
against the choice of `r`. ∎

### 3.3 The merge at a vertex, to the form the chain reads

derivation: E3-NICE
  statement: let F be a valid plane arc map and v a point; there are F′ and ρ ∈ (0, 1/4) with F′ valid and plane, F′ = F off the closed disc B̄(v, ρ) (same arcs and colours there), the arcs of F′ those of F plus finitely many circles about v of radii at most ρ, Condition 5 kept, F′ in NiceAt form at v, and F′ in NiceAt form at every point of B̄(v, ρ) other than v that carries at least three colours
  uses only: E3-W; a chart at v (localSectors) and at each crossing of a new circle with a branch; E1-SEE (ω(v) misses every class at v); validity of F
  not claimed: that repeated colours end on horns only (Woodall's conclusion, which needs FS110-W-MERGE's contact cone to merge a horn with a sector); anything at points outside B̄(v, ρ)
  argument: § E3-NICE, the argument
  verdict: derived
  grade: derived from: E3-W
  minds: 1
  model: the vertex v of a valid four-colour fragment whose chart reads A, B, A, C (B and C of angle < π): one merge recolours B near v with A, and v keeps two colours (E3-FAKE's picture)
  prior art: partly: [Woodall1973] p. 197 step 3 (the recolouring "add all such points Q to the same set as X and Y"); [SokolovVoronov2025] Props. 7–8 for polygons; FS110-W-MERGE for 𝓜_K under Condition 5
  handoff: de Bruijn — the single merge (F′ as an ArcMap: arcs ∪ {Arc.circ v ρ 0 (2π)}, col′ = c on the gap's chart sectors inside B(v, ρ)) and its iteration at v

#### E3-NICE, the argument

*One merge.* Take a chart at `v` (radius `r₀`). Suppose some colour `c` has two runs each holding a positive-angle chart sector. Going round, the gaps between
consecutive such runs sum to less than `2π`, so one gap `G` (a block of chart sectors, none of colour `c`) has total angle `< π`. Choose `d₁` inside the last
positive sector of the run before `G`, within `ε` of its end, and `d₂` inside the first positive sector of the run after `G`, within `ε` of its start, with
`d₂ − d₁ < π`; for small `r₁` the open segments in directions `dᵢ` lie in those sectors, so in `region c`. E3-W (with `S = region c`, `ω(v) ∩ S = ∅` by E1-SEE)
clears the open sector `(d₁, d₂)` up to radius `r₁cos(α/2)/2`; for `ρ` below that and below `r₀`, the chart sectors of `G` meet `B(v, ρ)` inside that sector
(their branches tend to directions in `(d₁, d₂)`). Recolour `R = (⋃ G) ∩ B(v, ρ)` with `c` and add the circle `|z − v| = ρ` to the arcs. *Validity*: pairs in
`R` are within `2ρ < 1`; pairs `R`–`region c` are cleared by E3-W; other classes only shrink. *Arc map*: `R` is open (a union of chart sectors cut by an open
disc), so the colour is locally constant off the new arc set; one circle more keeps local finiteness; `dom = univ` is untouched; the circle has radius `ρ ≠ 1`,
so it meets each unit circle in at most two points (Condition 5 kept). *The chart at `v`* of the new map, at radius `< ρ`, is the old one with `G`
recoloured `c`, so the number of runs drops by at least one. *New points with three colours*: on the circle only at a crossing with a branch whose two
sides inside are both in `R` (now `c`) and whose two sides outside carry distinct colours `g ≠ g′`, both `≠ c`; for `ρ` small the branch crosses
transversally, so the chart there has four positive sectors coloured `c, c, g′, g`, and the picture `(c, g′, g)` is in NiceAt form. Every other point of
`B̄(v, ρ)` other than `v` lies on at most one branch or on the circle away from branches, with at most two colours. *A colour poking into another's sector*
(a block of horns at a direction `θ` strictly inside the positive cone of `c`) is the case `G` = that block with `d₁ = θ − ε`, `d₂ = θ + ε`.
*Iteration at `v`*: repeat with smaller radii while some colour has two runs holding positive sectors; the number of runs is finite and drops each time.
*At the end*, every colour has at most one run holding a positive sector. The runs holding positive sectors, `R₁, …, R_m`, then carry distinct colours and
cover closed arcs `A_i` meeting only at their ends `θ_i`, where only horn runs sit. The picture: `A₁`, then at `θ₁` one horn for each colour of a horn run
there other than the colours of `A₁` and `A₂`, each once, then `A₂`, and so on. Its cones equal the true cones, because each colour's cone is the union of
its chart sectors' cones. Positive sectors carry distinct colours, and each horn's two neighbours are distinct whenever `n ≥ 3` (the block at `θ_i`
lists distinct colours, both different from `A_i`'s and `A_{i+1}`'s). That is NiceAt at `v` whenever `v` carries at least three colours. ∎

### 3.4 Finitely many merges on a ball, and the chain

derivation: E3-BALL
  statement: for every valid plane arc map F and every R ≥ 0 there is a valid plane arc map F′, Condition 5 kept, in which every point of closedBall 0 R carrying at least three colours is in NiceAt form
  uses only: E3-NICE; that a compact set holds finitely many points of three or more colours (each is a point where two distinct curves of arcs meet or an arc ends: a chart with at least three sectors needs at least two branches)
  not claimed: NiceAt at points outside the ball; Woodall's horn-only conclusion
  argument: § E3-BALL and E3-CHAIN, the argument
  verdict: derived
  grade: derived from: E3-NICE
  minds: 1
  model: the hexagonal seven-colouring — every vertex already in NiceAt form, so F′ = F
  prior art: owed — the localization; no search run
  handoff: de Bruijn — exists_woodallMerged as restated in § 4.1

derivation: E3-CHAIN
  statement: no valid plane arc map with at most five colours has every point of closedBall 0 3 carrying three or more colours in NiceAt form
  uses only: step5_lt (kills a horn between distinct colours at a point of three or more sectors); step6; E1-NO45 (false_of_four_le_sectors) with its normal form read at v and on ω(v); ts_t at z = 0 (|v| < 1/√2 + 1)
  not claimed: the step-3 modification itself (that is E3-BALL)
  argument: § E3-BALL and E3-CHAIN, the argument
  verdict: derived
  grade: derived from: E3-BALL
  minds: 1
  model: none can exist — a no-go at five colours; at seven the hexagonal map is in NiceAt form everywhere and the chain's step 6 fails only for want of five colours
  prior art: known: [Woodall1973] Thm 6 with [Townsend1979ms]'s repair (the everywhere-proper theorem); this localized form not found
  handoff: de Bruijn — aeMap6_merged, aeMap6_normal and false_of_four_le_sectors as restated in § 4.1

#### E3-BALL and E3-CHAIN, the argument

*E3-BALL.* Let `V` be the finite set of points of `closedBall 0 R` with at least three colours not in NiceAt form. Induct on `|V|`: merge at `v ∈ V` by
E3-NICE with `ρ` below the distance from `v` to the other points of `V` and to the ball's other three-colour points. Outside `B̄(v, ρ)` the map is unchanged
near every point, so pictures there are unchanged; inside, only `v` and NiceAt crossings carry three colours. `V` loses `v` and gains nothing. Validity,
the plane and Condition 5 pass through each step. *E3-CHAIN.* Suppose the merged form holds on `closedBall 0 3`. Take `v` from `ts_t` (`|v| < 1/√2 + 1`) and
its NiceAt picture: `n ≥ |range c| ≥ 3`. A horn has distinct neighbours, so `step5_lt` excludes it. With every angle positive, the colours are distinct
by NiceAt's second clause, and `step5_lt` gives every angle `≥ π/3`. That is a normal picture, and `step6` (`n = 3`) or `false_of_four_le_sectors`
(`n ≥ 4`) finishes. The latter needs a normal picture at its auxiliary point `w ∈ ω(v) ⊆ closedBall 0 3`, which carries exactly three colours, and gets
it the same way. ∎

### 3.5 Q2: no route avoids a modification

derivation: E3-FAKE
  statement: at a point whose sectors read A, B, A, C in cyclic order with B and C of angle less than π, there is an arc of angles ψ of positive length on which some colour of the point puts no inner collar about ψ in its shadow and some colour puts no outer collar in its shadow
  uses only: the shadow criterion of collarAt_shadow_inner/outer read as cones (a colour's cone inside the closed near half-circle, respectively far half-circle, of ψ); that B and C are disjoint and not adjacent
  not claimed: that such a point exists in a five-colour valid map (none does, by aeMap6); that every lemma of the chain fails there — only Townsend's lemma's hypothesis (finitely many cut angles) and step 6's set-up
  argument: § E3-FAKE, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: A on [0, π/2] ∪ [2π/3, 4π/3], B on [π/2, 2π/3], C on [4π/3, 2π]: two arcs of bad angles of length π/3 each (control e3-fake)
  prior art: owed — a remark on the chain; no search run
  handoff: none — the reason Q2 recommends E3-BALL over a modification-free chain

control: e3-fake
  of: E3-FAKE — bad angles counted on a grid of 1440; the fault makes B and C adjacent (the normal form), leaving the two edge normals only
  run: python3 ../tools/fs131_e3_fake.py
  expect: bad=482 of 1440
  fault: python3 ../tools/fs131_e3_fake.py --fault

#### E3-FAKE, the argument

`B` (midpoint `b`, angle `β < π`) lies in the closed near half-circle of `ψ` for `ψ` in the arc of centre `b` and half-length `(π − β)/2`; `C` (midpoint `c`,
angle `γ`) lies in the closed far half-circle for `ψ` in the arc of centre `c − π` and half-length `(π − γ)/2`. The arcs overlap in positive length when the
angular distance from `b` to `c` exceeds `(β + γ)/2`. That holds strictly, because an `A` sector of positive angle separates `B` from `C` on each side.
On the overlap both collars fail, so the cut angles are not finite and Townsend's lemma does not apply. Merging `A` across `B` (E3-NICE) leaves `v` two
colours, so `v` was never a vertex the chain could use. And the merged map's vertices can be crossings on the new circles, which `F` does not have at all.
So the chain must read a modified map. ∎

## Stage 3 — SAVED
