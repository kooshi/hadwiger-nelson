# FS116-N1 — FS-116's proof side, round 1: the ring (RING-TWIST, RING-Q, then SAT-STRIP, SAT-QFREE)

*Ephodos (Opus 5.5), job FS116-N1, launched 2026-09-29 05:45 UTC at HEAD `a720e729`. Brief `data/fs116/briefs/FS116-N1-ring.md`, with
`plans/STANDING-RULES.md` as part of it. Identity and procedure: `.claude/agents/ephodos.md` § A derivation job. Frozen claims: `data/fs116/claims.md`
(its § 0 definitions are used verbatim; "valid fragment" is six-coloured unless `k` is named). I touch only this record, `data/fs116/n1/`,
`tools/fs116_n1_*.py` and `data/fs116/reports/FS116-N1.md`. Resuming check: no record existed at start. Grades are my identity's grammar; the edge
translation is `.claude/agents/ephodos.md` § Two vocabularies (`hand` = [hand], `derived from` = [derived], `computed over` = [tools]).*

**Notation used throughout** (each item is FS-110's, FS-114's or this list's; nothing new is meant by it). `p` a vertex, `ω(p)` its ring, `σ` the rotation
by `60°` about `p`, `r(θ) = p + e(θ)` the ring point at angle `θ`. `P = P(p)` the set of colours of tiles whose closure contains `p` ("p's colours"); for
a point `z`, `C(z)` the set of colours of tiles whose closure contains `z`. **N-E1** (FS-110, `plans/FS110-N-proof.md` § 1.4) in the form used here: *if `z`
is an interior point of a tile of colour `c` and `|z − w| = 1`, then `c ∉ C(w)`* — proof in two lines: a ball `B(z, δ) ⊂` that tile, a point `w′` of a
colour-`c` tile with `|w − w′| < δ`, and the distances from `w′` to `B(z, δ)` fill an interval containing 1. It uses no non-Siamese hypothesis.
**CL** (non-Siamese): two tiles of one colour with points less than 1 apart are one tile; in particular at most one tile of each colour has a given point
in its closure. **N3-FACE** (`plans/FS114-N3-proof.md` § 2.1): distinct tiles of one colour at `u`, `w` with `|u − w| = 1` have cones in the closed
half-planes facing away from each other; one tile with `u, w` in its closure lies in `B̄(u, 1) ∩ B̄(w, 1)` (diameter at most 1).

## Theorems this phase proved

- **FS116-N1-QT** — the brief's four quotations are verbatim in `data/fs116/claims.md` — computed over the four quotations (`tools/fs116_n1_quotes.py`), § 1.1.

## Would-have-searched-here log (standing rule 5)

- (none yet)

## Fence log (standing rule 8)

- No path is fenced for this job. The harness's start-up context included the auto-memory index (milestone status lines, no proof content). I read no
  session transcript and no FS116-V1, FS116-Y1 or FS121-DB1 record. I write about my work only here, in `data/fs116/n1/` and in my report.

## G87 lookout

- Stage 1: see § 1.3 (RING-TWIST's literal parity clause against its own model class — a statement defect, classed below, not two truths in collision).

## Stage 1 — SAVED: the readback, and recognition on each claim

### 1.1 Readback of the brief

`tools/fs116_n1_quotes.py` extracts every blockquote of the brief and searches it in the source its `— source:` line names, whitespace collapsed and
nothing else normalised (`data/fs116/n1/quotes.out`, exit 0): **4 of 4 FOUND** — RING-TWIST, RING-Q (with RING-Q′), SAT-STRIP, SAT-QFREE, each in
`data/fs116/claims.md` at the section the brief names. **Plant** (`--plant`): the first quotation with "is contained" changed to "is included" is NOT FOUND
(`data/fs116/n1/quotes-plant.out`, exit 0). By hand: RING-Q's quoted card ask is verbatim in `plans/POROS-2026-09-28-fs116-question.md` (checked by the
same normalisation); the brief's pointers resolve — `plans/FS121-close-inventory.md` item 8 is the ruling that `what-do-q-rings-force` stays FS-116's,
`plans/FS121-map-step.md` § 3.3 is FS121-O1-PER's argument. The brief's statement that YESLIM and SATPIN are one-mind inputs matches the plan's entries
(`plans/FS116-local-exclusion.md` § 3.4, § 4.1: `minds: 1`). **No mismatch.**

derivation: FS116-N1-QT
  statement: every blockquote of `data/fs116/briefs/FS116-N1-ring.md` occurs verbatim, whitespace collapsed, in `data/fs116/claims.md`
  uses only: the brief's four blockquotes and their `— source:` lines; whitespace normalisation only
  not claimed: that the brief's unquoted prose (its "Why this job", its reading list) is faithful beyond the pointers checked by hand in § 1.1
  argument: § 1.1 Readback of the brief
  verdict: derived
  grade: computed over: the four blockquotes of the brief against `data/fs116/claims.md`
  minds: 1
  model: the brief itself — its RING-TWIST quotation, found at `data/fs116/claims.md` § 5
  prior art: known: a quotation check, the workflow's readback
  handoff: none — a readback, no mathematics

control: fs116-n1-quotes
  of: FS116-N1-QT — the four quotations found, and one altered by a word not found
  run: python3 ../tools/fs116_n1_quotes.py --count
  expect: FOUND 4 of 4
  fault: python3 ../tools/fs116_n1_quotes.py --count --alter

**My claims, restated beside the quotations.** In this order: RING-TWIST (the ring's `D` lies on `Γ`-arcs up to finitely many points; parity of change
points in every half-open 60° window `W` with `W ∪ σ(W)` off `D`); RING-Q and RING-Q′ (in the non-Siamese simple class, change points off (Q) arcs — resp.
with their `±60°` points off (Q) arcs too — are vertices of at least four colours, when the ring carries a (Q) arc); then, if the budget holds, SAT-STRIP
and SAT-QFREE. Each gets one verdict (TRUE, FALSE, GAP, MISSTATED), its behaviour on the strip and the disk, and what it says at `k = 7`.

### 1.2 The plan, read; the object unchanged since §G

Read in full: the plan (`plans/FS116-local-exclusion.md`), the frozen list, the stub, `plans/FS114-derivation.md` (all 46 entries), `plans/FS114-N3-proof.md`
header and § 2 (N3-FACE … N3-ODD, DR), `plans/FS114-N6-proof.md` header and § 2.1–2.2 (N6-KAPPA, N6-WIN, N6-RING60), `plans/FS114-N7-proof.md` in full
(N7-HUB, N7-REACH, N7-TAN, N7-TAC, N7-3T, N7-FLANK, N7-QOPP, N7-CHAIN, N7-HUBQ, N7-OCTB), and the strip's and the disk's constructions by formula
(`tools/fs112_yb2_objects.py` `Strip`, `Disk`) with FS114-Y6's survey (`data/fs114/fs114-y6/survey.out`). The object is the plan's §IQ.3 object (the ring
of a four-colour vertex); it has not moved since the plan's §G, so no re-walk of the grokkings is owed.

### 1.3 Recognition (`ephodos-recognition`, invoked fresh), claim by claim

**RING-TWIST.** *The stranger* (someone who works on colourings of the circle avoiding a rotation): colour each point of the unit circle `ω(p)` by the
colours of the tiles whose closures contain it; points `60°` apart are at distance 1. *Features, sorted with receipts:* N-E1 — **determines** (every step
consumes it: a ring point off `Γ` has an absent colour, and an interior point forbids its colour at the points `60°` away); the number of absent colours —
**determines** (two make the ring colouring antiperiodic under `σ`; one makes a qualifying window impossible; three leave room — R7's control); the chord
`|r(θ) − r(θ + 60°)| = 1` — **determines**; Siamese pairs, degree, radius beyond `1 + ε` — **accompany** (N-E1 needs none of them; the argument reads a
neighbourhood of `ω(p)` only); the definition of "change point" — **splits**: the invariant counts the *jumps of the closure colour*, and a change point in
the quoted sense ("a point of `Γ ∩ ω(p)` where the colour of the ring off `Γ` differs on its two sides") is a jump only where the ring is off `Γ` on both
sides. *Home:* H2 of the plan (`plans/FS116-local-exclusion.md` § 2.1), and inside it an elementary theorem: **a two-valued step function on a circle that
is antiperiodic under a rotation has an odd number of jumps in every half-open fundamental interval of that rotation.** *The one changed step:* the
function is the colour of the tile-closures holding a ring point (defined, off a finite set, on all of `W ∪ σ(W)`, `Γ`-arcs included), not the colour off
`Γ`. *What the recognition predicts, checkable:* the parity holds for jumps, and fails for change points exactly at a jump that ends an arc of `Γ` on
`ω(p)` with one colour on both sides (a slit, or the seam of a Siamese pair) — so the literal clause is expected **MISSTATED**, and TRUE in any class
without such arcs (the non-Siamese simple class: FS114-N3-ODD's). Stage 2 derives it.

**RING-Q and RING-Q′.** *The stranger* (a discrete geometer): at a point `y` of the unit circle about `p` where the two colours absent at `p` meet, do
tiles of at least two more colours meet? *Features:* the cones at `y` of the two ring tiles `R` (colour `X`, counter-clockwise) and `R′` (`X̄`,
clockwise) — **determine** (`y` has at least four colours exactly when the inward and outward open cones at `y` are left to tiles of `p`'s colours,
N7-HUB (b), (c)); what confines those cones — **determines**: each of the four half-plane constraints of N7-HUB (a) is fed by one of the four germs of the
ring at `y ± 60°` carrying `X` or `X̄` (diameter toward the germ of the same tile; N3-FACE away from a distinct tile of the same colour); the (Q) arcs —
**determine only through that**: a (Q) arc matters exactly when it holds one of those four germs; non-(Q) arcs of `Γ` on the ring — **unsorted** (FS-114
bent them away; RING-Q has no bends); the radius above 2 — **unsorted**: the one point of `B̄(p, 2)` beyond the ring that the outward cone at `y` sees at
distance 1 is `y* = 2y − p`. *Homes:* H2 decides nothing here (the ring colouring is the same with or without a tip); H1's local steps (Thomassen's rainbow
step) are exactly what fails on valid maps (FS114-CVB-THOM); no outside home found. *The recognition sentence:* **RING-Q is the question whether the four
germs at `y ± 60°` carry the absent colours; where a (Q) arc holds one of them, nothing on the ring pins the ring tiles' cones at `y`, and any proof must
read past the ring — toward `y*`, which is what the radius-2 hypothesis supplies.** This does not differ from the plan's frame; it names the step where
RING-Q and RING-Q′ part.

**SAT-STRIP.** *Features:* four segment edges at `p`, each of SATPIN's tangent type — **determine**; with the strip's labelling (colours `P, B` above,
`M, O` below, edges at `0°, 90°, 180°, 270°`) SATPIN puts `{M, O}` at `r(90°)`, `{P, B}` at `r(270°)`, `{B, O}` at `r(0°)`, `{P, M}` at `r(180°)`, each
pair split along the tangent line to `ω(p)` there (FS121-O1-OUT's grid, first rung). Saturation holds only on `B̄(p, 1)`, which those tangent lines leave at
once — **so the grid's second rung is not given by saturation, only by validity on `B̄(p, 2)`**: a finding for the stage that works it.

**SAT-QFREE.** *Features:* by N-E1 at `p`, a point of `ω(p)` carrying a colour of `p` lies on `Γ`; so a split centre or a point `p ± ν(p)` is on an arc
of `Γ` on `ω(p)`, or an isolated point of `Γ ∩ ω(p)`, and SAT-QFREE's content is exactly **excluding a touch point** — an isolated point of
`Γ ∩ ω(p)` carrying a colour of `p`, across which the ring's colour does not change.

**Recognition against the plan: one difference, on RING-TWIST** (the statement's counting word), reported to the coordinator with the stage-2 result.
No home is adopted from outside the project; none is needed for RING-TWIST (the theorem is elementary), and none was found for RING-Q.

## Stage 1 — SAVED
