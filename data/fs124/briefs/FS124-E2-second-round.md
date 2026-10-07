# Brief FS124-E2 — the second round: what it costs a six-colouring to save a close complementary pair at a common unit point

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-E2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this is a derivation job on a fixed claim list, in a milestone whose object has just changed — so its first stage walks the grokkings again from inside the new object, as your workflow's opening asks of the job that meets such a change
  role: the second derive round of the milestone on tight unit pairs — read on every held six-coloured object how a pair of three-colour points with all six colours between them, less than 2 apart, is saved at the points one unit from both; then derive, in the asking lane's order, that such a pair forces a boundary along a unit circle there, whether one member can do the saving alone, what the strip's top edge then allows, and what a pair carries from one of its two common unit points to the other
  launch: now, on `main`, into the first free slot; an implementer and a planner of the kernel lane work on branches and write nothing you write
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind to you
  channel: message the coordinator ("main") by SendMessage **(1) with each claim's exact statement and its *not claimed* line as soon as your plan holds them**; **(2) with each verdict as it is saved** — derived, refuted by an object, a gap at a named step, or, for the reading, what was read; **(3) at once** for anything that would fix the value of the chromatic number of the plane (it goes to Kooshi as "claimed by one mind, unchecked"), for a held object that breaks the card's frame, for a defect in a statement, for two results that cannot both hold, or for prior art; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-E2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS124-E2-derivation.md`
  touches: `plans/FS124-E2-derivation.md`, `plans/FS124-tight-pairs.md` (the milestone's plan: dated additions only — the re-walk, this round's route and predictions — the first round's text left standing), `data/fs124/e2/` (every script and its output — not `tools/`: a landing may be in flight on `main` within the day), `data/fs124/reports/FS124-E2.md`; **not** the claim list (`data/fs124/claims.md` is the coordinator's: a statement you find wrong is a message), the stub (the asking lane's), the first round's record `plans/FS124-E1-derivation.md` or any derivation file of another milestone (a correction owed is a draft in your record), `CLAUDE.md`, `LEDGER.md`, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. This milestone was opened this morning on one object: a boundary between two colours that runs exactly along a unit
circle, centred on a point one unit away. A colleague took its six first claims this afternoon and brought every one to a
verdict — and found that one such boundary, by itself, forces almost nothing: the two colours are absent at the two points one
unit from both its ends, at any number of colours, and that is all. Then the asking lane went back to the six-coloured objects
this project holds and read them for *why* their boundaries sit where they do. It found one cause, 94 times out of 94: each
centre of such boundaries is the rescue of a pair of three-colour points that between them use all six colours and lie less
than 2 apart. A point one unit from both has no colour left — unless a boundary at one of them runs along its unit circle.
That is where the number six is spent, and it is the unit of your round.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `data/external/EXT-OAI1-request.md` § Kooshi's sixth word):

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

The first round's statements hold at every number of colours, so by themselves they cannot tell six from seven. Four of the
five claims below are posed to hold at six and fail at seven, each with its witness named; the tight seven-colouring survives
them because it has no three-colour point at all. If the central one is derived, it is this milestone's first statement that
spends the count. And one claim asks you to *build*: a rescue by one member of the pair alone, by formula on a small
neighbourhood — or the step that forbids it. If it exists, six has a second kind of centre and the strip has a way upward; if
it does not, every rescue fixes four colours at a point, and there is a rigid incidence to count on. Either is a result;
do not lean toward seven. The card, its reason for the unit, its registered expectations, and how the round came to be posed:

> question: what-does-a-save-cost
> — source: plans/STUB-q-ring.md

> **Why the unit changes.** A tight pair is not a cause. On both held six-coloured maps it is an effect, with one cause: every centre
> — source: plans/STUB-q-ring.md

> C124-READ-SAVES: its statement holds on the strip and the disk read whole 0.9; some unread object shows a pattern other than (1, 1)
> — source: plans/STUB-q-ring.md

> 8. **FS124-E1, verdicts on the first-order rule (13:24 UTC): derived — and the card's question, for one tight pair, gets its
> — source: plans/FS124-close-inventory.md § Items

> 9. **FS124-E1 done (482k and 35 minutes by the task notice): the opening, and all six claims at verdicts — the first round
> — source: plans/FS124-close-inventory.md § Items

> 12. **FS124-P2, first message (13:59 UTC): the second round's card is saved — and the unit is neither the card's nor the
> — source: plans/FS124-close-inventory.md § Items

## The claims

**The claim list** is `data/fs124/claims.md` — read it whole, with its dated lines: the first round's statements and verdicts, then this
round's definitions and five claims, as posed (**posed, or read from held objects by sample — none derived**; each claim's
controls, its side and the witness of its kind are in the stub, `plans/STUB-q-ring.md` § The question (Poros, 2026-10-07, after the first
round) — read that section whole, with the two cards above it):

>   **Definitions, stated once.** `c` is a weak six-colouring of an open set `U` (the class of the section above). A **three-piece point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of three connected open sets, each with `x` in its closure and one label almost everywhere, the three labels distinct; its **edges** are the three common boundaries of two of the pieces near `x`. A **close complementary pair** is two three-piece points `x`, `y` with `0 < |x − y| < 2` whose six labels are distinct. Its **common unit points** are the two points `w` with `|w − x| = |w − y| = 1`. A common unit point `w` in `U` is **saved by `x`** when some edge of `x` contains an arc of the unit circle about `w` with an end at `x`; the **pattern** at `w` is the pair (number of such edges of `x`, number of such edges of `y`). A map's vertex of three tiles is a three-piece point with no dictionary.
> — source: data/fs124/claims.md

>   **C124-READ-SAVES** (a reading; first) — as posed: On every held six-coloured object — FS-112's strip and disk (read here by sample), FS-114's capped strip with its caps, fragment T2, the bowtie fragment, FS116-Y2-SIXFRAG, and the Searcher's kept model — list every close complementary pair of three-piece points and each of its common unit points inside the object, with: the pattern; for pattern (1, 1), C124-HALF-TWO's hypothesis read whole (each member's two other edges with points strictly on opposite sides of the unit circle about the point); the labels present at the point. *Statement to verify*: at every such point the pattern is (1, 1), that hypothesis holds, and the labels present are exactly the four labels of the two edges. Also: every tight arc of kind both of each object, and whether it is an edge of some save.
> — source: data/fs124/claims.md

>   **C124-FORCED** (spends six) — as posed: Let `c` be a weak six-colouring of `U`, `(x, y)` a close complementary pair of three-piece points and `w` a common unit point of the pair lying in `U`. Then `w` is saved by `x` or by `y`; and for every interior point `z` of the arc so obtained the pair `(w, z)` is tight for the two labels of that edge, in one order along the arc. *Smallest form*: C132-COMP-SHARP applied to the six initial pieces of the edges of length `1/n`; one edge serves for infinitely many `n`, and an initial piece contained in a circle is an arc of it.
> — source: data/fs124/claims.md

>   **C124-ONE-MEMBER** (spends six; decides the card) — as posed: In the setting of C124-FORCED suppose exactly one of the six edges, an edge of `x` with labels `t_0, t_1`, contains an arc of the unit circle about `w` at its member. *Derive* what C124-HALF then gives in this grammar — after exchanging the names if need be, near `w` and outside the unit circle about `y`, the label `t_1` inside the unit circle about `x` and `t_0` outside it — and its consequence: `(x, w′)` is tight for `(t_1, t_0)` for `w′` on that side of `w`, `(w, z)` is tight for `(t_1, t_0)` along the edge, so one label lies inside both circles and each of `x`, `w` is a centre of an arc through the other. *Then decide*: a weak six-colouring of an open set containing `x`, `y` and `w` with this pattern, by formula with an exact check — or the step at which none exists. *Smallest form*: which labels may be present near `w` inside the unit circle about `y`, given the sides of `y`'s three edges.
> — source: data/fs124/claims.md

>   **C124-EDGE** (spends six, through C124-FORCED; a computation by formula on one held object) — as posed: On FS-112's strip, let `w` be a point of the top edge `y = √15/4 + √3/2` that is a common unit point of a close complementary pair of the strip's three-piece points. Then the member of the pair on the line `y = √3/2` has no edge free for the unit circle about `w`: its three edges lie on the unit circles about two midline vertices and on a vertical wall. Hence a weak six-colouring of a neighbourhood of the closed strip that agrees with the strip on `|y| ≤ √15/4` saves no such `w` by both members. *Smallest form*: `w = (1/4, √15/4 + √3/2)` with the pairs `(−1/4, √15/4)`, `(1/2, √3/2)` and `(0, √3/2)`, `(3/4, √15/4)`.
> — source: data/fs124/claims.md

>   **C124-SECOND** (spends six; the datum a pair carries) — as posed: In the setting of C124-FORCED let both common unit points `w`, `w′` lie in `U`, each with pattern (1, 1). Then the edge of `x` on the unit circle about `w` and its edge on the one about `w′` are different edges, likewise for `y`; with C124-HALF-TWO's hypothesis at both, the label sets at `w` and at `w′` have exactly two labels in common, one of each member, their absent pairs are disjoint, and the six labels have a cyclic order in which the three pairs read at `w` (the two edges, the absent pair) and the three read at `w′` alternate. *Smallest form*: two unit circles through `x` cross there, so no arc ending at `x` lies on both.
> — source: data/fs124/claims.md

**What it stands on.** The first round's record, `plans/FS124-E1-derivation.md` — sixteen entries, each [hand] or derived from one, one mind: the one
lemma (an open set carrying a label bars it from almost every point at distance exactly 1), what a tight pair forces at its
centre, at every point one unit from its far end, and at the opposite point; the rhombus's first half and its two-set form,
which the asking lane now reads as the law of every held centre. Last night's record, `plans/FS132-derivation.md` § 4: the complementary pair's
sharp form (one of six sets lies on the unit circle about a common unit point), one mind, kernel pending, and the one-witness
side statement under it, whose argument the first round's deriver did not read. The asking lane's record, `plans/POROS-2026-10-07-fs124-round1.md`, with its
readers under `data/fs124/p2/` (by sample, one mind, four planted faults firing) and one remark for you, per class and
unchecked, at the end of the card's section. The plan, `plans/FS124-tight-pairs.md`, with the first round's re-grokking, prior-art gate and
invariant question. **The held objects**: the strip and the disk (read by the asking lane), the capped strip's caps, fragment
T2, the bowtie fragment, the six-colour fragment and the search's kept model (unread for this property), and the tight
seven-colouring; the first round's loaders and its tightness reader are under `data/fs124/e1/` — its report names a reader
it had to repair near an arc's end, and the controls it did not run.

## Done means

1. **Your readback, and the re-walk.** Check this brief's quotations against their sources; read the card's section, the
   first round's record and the asking lane's record whole. Then, in the plan, a dated addition: the grokkings walked again
   from inside the new object — a close complementary pair and its saves — with what each entry that bears dictates for
   this round (G83, G84, G91 and G96 to G98 at least), this round's route, and a prediction per claim registered before you
   derive. Prior art: the pair's exclusion and its rescue by a unit arc, in the map class, are this project's rows 133 to
   136 with the papers they cite — say what is already in print for maps, and search for the measurable form. Commit and push.
2. **Each claim's exact statement, with its *not claimed* line — your first message.** Every one says that it does not claim
   a weak six-colouring has a three-piece point or a close complementary pair. Where a claim as posed can be met by a
   degenerate case, or says less than its wording, restate it and say why.
3. **The reading first** (it tells you what the other four are about): on every held six-coloured object, by formula from
   its own tiles, exact where the object is exact — the pairs, their common unit points, the pattern at each, the rhombus's
   two-set hypothesis read whole, the labels present; every tight arc of kind both, and whether it is an edge of a save.
   The asking lane's counts are by sample: reproduce them or correct them, and say which. Each reader with a planted fault
   watched firing; the tight seven-colouring must return no pair. **A held object that breaks the pattern is a message to
   me at once** — the card says what it would mean.
4. **Then the four claims, in order, each to a verdict saved before the next starts**, in your lane's derivation form: that
   a pair forces a tight arc at each common unit point (with its failure at seven exhibited by formula); the save by one
   member alone — its consequence derived, then **an object by formula with an exact check, or the named step at which none
   exists, or a gap said as a gap**; the strip's top edge; the pair's two saves and the cyclic order. No search: a step a
   search could decide is a `search request` line in your report. **A verdict by message as each is saved.**
5. **If a save by one member is built**: stop and message me before going on — say on what neighbourhood it is a weak
   six-colouring, what checked it, and what it does not show (it is a local object: it fixes no value).
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E2-derivation.md`, from `plans/`) green; the report
   in standing rule 11's form. **Stopping at a saved stage with the reading done and the forcing claim at a verdict is a good
   report** — say exactly where a successor takes over.

## What is yours to decide

The route to every claim; the statements' final wording (through me, by dated lines); how the reading is made exact; whether
to build or to exclude first in the third claim. Attack the card as hard as an outside claim: its counts are one mind's, by
sample, read this afternoon — if a held object has a centre that is no rescue of a pair, if "exactly one edge of each" is an
artefact of two objects built by one recipe, if the unit should be something else again, that is a finding and the round's
most valuable one. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator
can only review work it knows exists).
