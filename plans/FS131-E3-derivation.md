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
