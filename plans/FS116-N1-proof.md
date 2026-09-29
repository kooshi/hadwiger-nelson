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
- **FS116-N1-TWIST-D** — RING-TWIST's first clause, at every `k`, radius `1 + ε`, Siamese pairs allowed — [hand], one mind, § 2.1.
- **RING-TWIST-C** — RING-TWIST corrected (the claim as posed is MISSTATED): the parity of the ring's colour changes in every qualifying window — [derived], one mind, § 2.2.
- **FS116-N1-TWIST-LIT** — the parity clause as posed holds on the class iff no fragment of the class has a qualifying window (the slit) — [derived], one mind, § 2.3.
- **RING-GERM** — at a change point, the tip needs the outer pair of germs at `y ± 60°` off (Q) arcs, the outer tile the inner pair; all four give four colours — [derived], one mind, § 3.1.
- **RING-Q-PRIME** (the claim RING-Q′) — TRUE as posed (closed arcs), from RING-GERM (iii) — [derived], one mind, § 3.1.
- **FS116-N1-QDISK** — the disk's corner has a two-colour change point with its `±60°` points inside (Q) arcs: RING-Q is false below radius `1.5985` — [tools], one mind, § 3.2.
- **RING-TWIST-Q** — a qualifying window's change points have both germs at `y − 60°` on (Q) arcs; a (Q)-free ring has none — [derived], one mind, § 3.4.
- **RING-Q** — GAP (not a theorem), § 3.4.

## Would-have-searched-here log (standing rule 5)

- Would have scanned ring configurations (arcs, change points, colours) at a four-colour vertex for a qualifying window or a two-colour change point.
  Instead: read the rings of the held fragments by formula (the strip's midline vertices, the disk's corner), piece by piece, with exact re-checks.

## Fence log (standing rule 8)

- No path is fenced for this job. The harness's start-up context included the auto-memory index (milestone status lines, no proof content). I read no
  session transcript and no FS116-V1, FS116-Y1 or FS121-DB1 record. I write about my work only here, in `data/fs116/n1/` and in my report.

## G87 lookout

- Stage 1: see § 1.3 (RING-TWIST's literal parity clause against its own model class — a statement defect, classed below, not two truths in collision).
- Stage 3: none seen as a collision. Classed: FS114-derivation's N7-3T model line ("FS114-Y2-BOWTIE's centre … whose ring carries no (Q) arc")
  against FS114-N6 § 4 ("Its caps are (Q) arcs") and this job's survey (the caps are (Q) arcs: inner 1 | outer 3, inner 3 | outer 1) — a slip in a model line,
  not two truths; reported as a correction owed.
- Stage 2: none seen. The claim list's R7 control ("with three colours absent the parity fails") against FS111-M-R7 (six colours at each lattice point) is a
  wrong description of a control, not two truths: R7's statement stands and the list's parenthetical is corrected in § 2.4.

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

## Stage 2 — SAVED: RING-TWIST

**Verdict.** The first clause is **TRUE as posed**, at every `k` and at radius `1 + ε` (FS116-N1-TWIST-D). The parity clause is **MISSTATED**: the
invariant is the parity of the ring's *colour changes*, and a change point in the quoted sense is a colour change only where the ring is off `Γ` on both
sides; the corrected statement is RING-TWIST-C (derived), and the clause as posed holds on the whole class **only if** no fragment of the class has a
qualifying window at all (FS116-N1-TWIST-LIT), because a slit inserted at a change point keeps every hypothesis and removes that change point.

### 2.1 The argument of FS116-N1-TWIST-D (the first clause)

Let the fragment's domain contain a neighbourhood of `ω(p)` (a closed disc of radius above 1 about `p` suffices). `Γ` is a locally finite union of segments
and circular arcs, so finitely many of its pieces meet `ω(p)`, and finitely many tiles meet a neighbourhood of it. A segment, or a circular arc on a circle
other than `ω(p)`, meets `ω(p)` in at most two points; the remaining pieces are arcs of `Γ` on `ω(p)`. So `Γ ∩ ω(p)` is the union of the arcs of `Γ` on
`ω(p)` and a finite set. **`D ⊂ Γ`:** a ring point `r(θ) ∉ Γ` is an interior point of one tile `T`, and of no other tile's closure; by N-E1 with `w = p`,
`c(T) ∉ C(p) = P`; so `C(r(θ)) = {c(T)}` misses `P` and `r(θ) ∉ D`. **`D` is closed:** near each ring point it is the ring's intersection with a finite
union of closed sets (the closures of the finitely many tiles of `p`'s colours meeting a neighbourhood). ∎ *Uses:* N-E1 and local finiteness — no count of
colours, no non-Siamese hypothesis, no simplicity, any degree. *Reads:* a neighbourhood of `ω(p)` and the tiles at `p`.

### 2.2 The argument of RING-TWIST-C (the parity)

Fix `W = [θ₀, θ₀ + 60°)` (angles increasing counter-clockwise; the clockwise convention is the mirror) with `(W ∪ σW) ∩ D = ∅`, so
`C(r(θ)) ⊂ A`, the set of colours absent at `p`, for every `θ ∈ [θ₀, θ₀ + 120°)`.

**L1 (a ring arc of `Γ` excludes its side colours `60°` away).** Let `θ` be a point of an arc `G` of `Γ` on `ω(p)` at which `Γ` coincides locally with `G`
(all but finitely many points of `G`), with side tiles `T⁻` (inside) and `T⁺` (outside). Then `c(T⁻), c(T⁺) ∉ C(r(θ ± 60°))`. *Proof.* The triangle
`p, r(θ), r(θ + 60°)` is equilateral, so `ω(r(θ + 60°))` passes through `r(θ)` and meets `ω(p)` there at `60°`: it crosses `G` transversally, and holds
interior points of `T⁻` and of `T⁺` arbitrarily close to `r(θ)`, each at distance 1 from `r(θ + 60°)`. N-E1. Likewise `θ − 60°`. ∎

Let `E` be the finite set of ring points of `Γ ∩ ω(p)` that are isolated in it, or ends of arcs of `Γ` on `ω(p)`, or points of such arcs met by another piece
of `Γ`. For `θ ∉ E` put `K(θ) = C(r(θ))` (one colour off `Γ`; the two side colours on an arc). By N-E1 off `Γ` and L1 on the arcs,
**`K(θ) ∩ C(r(θ ± 60°)) = ∅` for every `θ ∉ E`.**

**L2 (two absent colours, swapped).** Let `F = E ∪ σ⁻¹E ∪ σE`. For `θ ∈ W ∖ F`, `K(θ)` and `C(r(θ + 60°))` are non-empty, disjoint and contained in `A`. So
`|A| ≥ 2`; with `|P| ≥ 4` and six colours, `|P| = 4`, `A = {X, X̄}`, and both sets are singletons, one of each colour. Hence off the finite set `F ∪ σF`
every point of `W ∪ σW` lies in the closures of tiles of a single colour `c̄(θ) ∈ A`, and `c̄(θ + 60°) ≠ c̄(θ)` for `θ ∈ W ∖ F`. ∎ In particular (L1
with `K(θ)` a singleton) **every arc of `Γ` on `ω(p)` meeting `W ∪ σW` in an arc has one colour on both sides** — a *seam*: a slit (one tile on both
sides) or two tiles of one colour, a Siamese pair.

**L3 (a step function).** `c̄` is locally constant on `(W ∪ σW) ∖ E`: off `Γ` the tile is open; on a seam the two sides have one colour along it. So `c̄` has
finitely many **colour changes** — points where its one-sided limits differ — all in `E`. Every colour change `y` of `W` lies outside `D`, so `C(r(y)) ⊂ A`,
and it holds both absent colours (one on each side): **a colour change is a point where the two absent colours meet and no other colour does.**

**L4 (the parity).** Put `a = c̄(θ₀ +)` and `b = c̄((θ₀ + 60°) −)`. Antiperiodicity gives `c̄((θ₀ + 60°) +) = a′` (the colour other than `a`), so the colour
changes in the open window `(θ₀, θ₀ + 60°)` number `≡ [a ≠ b]` (mod 2). At `θ₀` itself: `D` is closed and `θ₀ ∉ D`, so for `θ` just below `θ₀`,
`C(r(θ)) ⊂ A`; and `θ + 60°` is just below `θ₀ + 60°`, a point of `W` with colour `b`, so by N-E1 or L1 at `θ + 60°`, `b ∉ C(r(θ))`: the colour just below
`θ₀` is `b′`. So `θ₀` is a colour change iff `b′ ≠ a`, i.e. iff `a = b`. The total in `W` is `≡ [a ≠ b] + [a = b] = 1` (mod 2). ∎

**L5 (colour changes against change points).** A change point in `W` has the ring off `Γ` on both sides with different colours: a colour change. A colour
change `y ∈ W` that is not a change point is in `E` but not an isolated point of `Γ ∩ ω(p)` with both germs off `Γ`: one of its germs lies on an arc of `Γ` on
`ω(p)`. That arc is a seam: inside `W ∪ σW` by L2's corollary, and just below `θ₀` (when `y = θ₀`) because L4's argument puts the single colour `b′` on both of
its sides. ∎ So in a fragment with no seam on `ω(p)` — every non-Siamese simple fragment (a slit makes a tile
meet itself; two tiles of one colour sharing an arc are at distance 0, hence close) — the colour changes of `W` are its change points, odd in number.

### 2.3 The clause as posed, and the slit (FS116-N1-TWIST-LIT)

Let `F₀` be any fragment of the class with a qualifying window `W`. If `W` holds an odd number of change points, pick one, `y` (both germs off `Γ`, with
colours `X̄ | X`), and insert a **slit**: the arc `S` of `ω(p)` from `y` counter-clockwise of length so small that `S ⊂ W` and `S ∩ Γ = {y}`. The result
`F₁` has `Γ₁ = Γ ∪ S`, a locally finite union of segments and circular arcs; its tiles are `F₀`'s, the `X`-tile `R ⊃ S ∖ {y}` replaced by `R ∖ S`, still
open and connected (a slit from a boundary point); its colouring is `F₀`'s, and its interior points are a subset of `F₀`'s, so no two of one colour are at
distance 1. `F₁` is a valid fragment on the same disc, Siamese pairs allowed, `p` untouched; `D` is unchanged (`cl(R ∖ S) = cl R`, colour `X ∉ P`), so `W`
still qualifies. In `F₁`, `y` ends an arc of `Γ₁` on `ω(p)` and is no change point; nothing else on the ring changed. So `F₁` has an even number of change
points in `W`. Hence the clause as posed holds on every fragment of the class iff no fragment of the class has a qualifying window; the converse direction is
vacuous. The corrected statement keeps the invariant and names the counting word: **colour changes**, of which change points are the ones off seams.

### 2.4 Controls: the strip, the disk, and `k = 7`

`tools/fs116_n1_ring.py` reads a held fragment's ring piece by piece (a float survey for aiming, `data/fs116/n1/ring-survey.out`) and re-checks the
load-bearing identities exactly (`exact`, `diskexact`; outputs `strip-exact.out`, `disk-exact.out`). Plants: the strip with its arch `U1` recoloured
`G → R` (`summary --plant`: the midline ring loses a change point and shows 890 twist violations), the strip's apex moved off `ω(P₀)` (`exact --plant`),
the disk's point `y` rotated `20°` about `A₀` (`diskexact --plant`); each fires.
- **The strip's midline vertex `P₀`** (colours `B, M, O, P`; absent `G, R`): the ring is `G` on `(0°, 60°)`, a (Q) arc `P | O` on `[60°, 75.52°]`, `R` on
  `(75.52°, 104.48°)` (the top tile `T₀`), a (Q) arc `B | M` on `[104.48°, 120°]`, `G` on `(120°, 180°)`, and the mirror image below; change points at `0°`
  and `180°`, the midline vertices `P_{±2}` (four colours each, two of them `P₀`'s: `P(P₂) = {B, G, O, R}`). **`D`** = the four closed (Q) arcs and the two
  change points (TWIST-D met); its complementary arcs are at most `60°` long, so **no qualifying window**: the parity clause is silent; the antiperiodic
  colouring it rests on holds (0 violations in 2,360 sampled pairs). `P₁` is the same up to the colour permutation.
- **The disk's corner `A₀`** (colours red, blue, yellow, orange; absent green, violet): four (Q) arcs on the ring, change points at `209.01°` and
  `330.99°`, each carrying **only green and violet** (stage 3); `D`'s complementary arcs are at most `87.83°`: **no qualifying window**; antiperiodic colouring
  0 violations in 1,756 pairs.
- **`k = 7`.** L2 is where six is spent: with seven colours and four at `p`, three are absent, `K(θ)` and `C(r(θ + 60°))` are disjoint but need not be
  swapped singletons, and no parity follows (not claimed, as the list says). **A defect in the list's not-claimed line:** its control "(with three colours
  absent the parity fails: R7's lattice points)" does not describe R7. R7's lattice points carry **six** colours (three Reuleaux ups, cosets of `2Λ`; three
  cusped downs, cosets of `M`; FS111-M-R7), so **one** is absent; the ring about a lattice point `v` is three `60°` arcs of `Γ` (the Reuleaux arcs centred at
  `v`, inner colour one of `v`'s) alternating with three `60°` arcs inside the up tiles of the fourth coset of `2Λ` (the one colour absent at `v`). `D` is the
  three closed Reuleaux arcs, its gaps are `60°`, and there is no qualifying window: at R7 the parity clause is **vacuous**, not failing. (By hand from R7's
  definition; not re-checked by a tool.)

### 2.5 The entries

derivation: FS116-N1-TWIST-D
  statement: at a vertex p of a valid k-coloured fragment on a closed disc of radius above 1 about p, for any k ≥ 1, Siamese pairs allowed, any degree, the
    set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points
  uses only: N-E1 at p (an interior point of a tile of colour c is at distance 1 from no point of the closure of a tile of colour c); that Γ is a locally
    finite union of segments and circular arcs, so finitely many of its pieces meet ω(p), each meeting it in at most two points unless it is an arc of ω(p)
  not claimed: that D is non-empty; that D is contained in the arcs of Γ on ω(p) alone (the strip's P₀ has two isolated points of D, its change points)
  argument: § 2.1 The argument of FS116-N1-TWIST-D (the first clause)
  verdict: derived
  grade: hand
  minds: 1
  model: the capped strip's midline vertex P₀ (row 136; FS114-Y-DIAL) — D is its four closed (Q) arcs and the two change points r(0°), r(180°)
    (`data/fs116/n1/ring-survey.out`; the arcs' ends and the change points on ω(P₀) exactly, `data/fs116/n1/strip-exact.out`)
  prior art: partly: FS-110's N-E1 is the whole mechanism; as a statement about the ring it is FS114-N3-ODD's setting ("off Γ-arcs of ω(p)") made explicit
  handoff: de Bruijn — the first clause as stated, with N-E1 and the local finiteness it uses; a small statement once a map type exists in Lean (D6)

derivation: RING-TWIST-C
  statement: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the
    set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points;
    and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W)
    lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every arc
    of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs
    on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and
    a colour change in W that is not a change point lies on an arc of Γ on ω(p) with one colour on both sides; so W holds an odd number of change points
    when no such arc meets W, in particular in every non-Siamese simple fragment
  uses only: FS116-N1-TWIST-D; N-E1; that a unit circle through a point of ω(p) centred 60° away crosses ω(p) there at 60°; six colours, spent once, at L2
    (two absent colours make the colours at θ and θ + 60° complementary singletons); for the last clause, that a slit makes a tile meet itself and two tiles
    of one colour sharing an arc are close
  not claimed: anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free arcs are
    at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)
  argument: § 2.2 The argument of RING-TWIST-C (the parity)
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: the capped strip's midline vertex P₀ for the hypotheses of the first clause and the antiperiodic colouring (0 violations in 2,360 sampled pairs); no
    held fragment has a qualifying window, so the parity's hypothesis has no held model at six colours
  prior art: partly: FS114-N3-ODD ("Off Γ-arcs of ω(p), every half-open 60° window of the ring of a four-colour vertex holds an odd number of change
    points", non-Siamese, one mind) — here without the non-Siamese hypothesis, with D in place of the Γ-arcs, and with the counting word corrected
  handoff: de Bruijn — the statement, its six-colour step L2 named, and TWIST-LIT's slit as the reason the counting word is colour changes

derivation: FS116-N1-TWIST-LIT
  statement: RING-TWIST's parity clause as posed — every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D holds an odd number of change
    points — holds on every fragment of RING-TWIST's class if and only if no fragment of that class has a half-open 60° window W with W ∪ σ(W) disjoint from D
  uses only: RING-TWIST-C (a qualifying window holds an odd number of colour changes); the slit: an arc of ω(p) from a change point into the tile on one
    side, added to Γ, leaves the fragment valid, the vertex p and the set D unchanged, and removes that change point and no other
  not claimed: that the class has a fragment with a qualifying window; anything in the non-Siamese simple class, where the clause holds by RING-TWIST-C
  converse: § 2.3 The clause as posed, and the slit (FS116-N1-TWIST-LIT)
  argument: § 2.3 The clause as posed, and the slit (FS116-N1-TWIST-LIT)
  verdict: derived
  grade: derived from: RING-TWIST-C
  minds: 1
  model: the capped strip about P₀, in the class at any radius in (1, φ²/√2): it has no qualifying window, and the clause holds on it vacuously
  prior art: partly: FS114-N3-ODD, whose hypothesis "off Γ-arcs of ω(p)" already excludes seams; the slit and the equivalence are this record's
  handoff: none — a finding about a statement's counting word; it travels as RING-TWIST's MISSTATED verdict

control: ring-summary
  of: RING-TWIST-C — the rings of the strip's midline vertices and the disk's corner, read piece by piece; a recoloured arch changes them
  run: python3 ../tools/fs116_n1_ring.py summary
  expect: strip P0=(0,0): P=4 (Q)arcs=4 changepoints=2 all>=4colours=True maxDfree=60.000 qualifying=no twistviolations=0
    strip P1=(1/2,0): P=4 (Q)arcs=4 changepoints=2 all>=4colours=True maxDfree=60.000 qualifying=no twistviolations=0
    disk corner A0: P=4 (Q)arcs=4 changepoints=2 all>=4colours=False maxDfree=87.827 qualifying=no twistviolations=0
  fault: python3 ../tools/fs116_n1_ring.py summary --plant

control: strip-exact
  of: FS116-N1-TWIST-D — the ends of the strip's (Q) arcs and its change points lie exactly on ω(P₀); the change points carry two of P₀'s colours
  run: python3 ../tools/fs116_n1_ring.py exact --line --noexit
  expect: EXACT OK
  fault: python3 ../tools/fs116_n1_ring.py exact --plant --line --noexit

## Stage 2 — SAVED

## Stage 3 — SAVED: RING-Q and RING-Q′

**Verdicts.** **RING-Q′ is TRUE** (as posed, reading "lie on a (Q) arc" as lying in its closed arc), and holds more widely: without "simple", without
the (Q) arc on the ring, at radius `1 + ε`; it is the case of all four germs of the **germ lemma RING-GERM** (derived), which says which germ at `y ± 60°`
forces which colour at a change point `y`. **RING-Q is GAP** at the change points some of whose germs lie on (Q) arcs, and the gap is not local: **the
disk's corner `A₀` has a change point carrying two colours only** (FS116-N1-QDISK, exact), on a non-Siamese simple valid fragment holding `B̄(A₀, R)` for
every `R < 1.5985` and the whole unit disc about that change point — so RING-Q with any radius below `1.5985` in place of "above 2" is FALSE, and any proof of
RING-Q as posed must read points of `B̄(p, 2)` outside the disk. One wording note: a change point in the quoted sense has the ring off `Γ` on both sides, so it
never lies on an arc of `Γ` on `ω(p)`; RING-Q's qualifier "that lies on no (Q) arc" is empty, and RING-Q says every change point is a vertex of at least four
colours.

### 3.1 The germ lemma (RING-GERM) and its argument

*Setting.* A non-Siamese valid fragment on a closed disc of radius above 1 about a vertex `p` of at least four colours; `y = r(ψ)` a change point, the ring
off `Γ` on both sides of `y`, of colour `X̄` just clockwise (tile `R′`) and `X` just counter-clockwise (tile `R`). Both are absent at `p` (TWIST-D), so with
six colours `p` has four and no more, and `A = {X, X̄}`. Put `u = r(ψ + 60°)`, `v = r(ψ − 60°)`, and call the **germs** the ring arcs `u⁻ = r((ψ + 60° − δ,
ψ + 60°))`, `u⁺ = r((ψ + 60°, ψ + 60° + δ))`, `v⁻`, `v⁺` likewise, `δ` small. Since `Γ ∩ ω(p)` is finitely many arcs and points, for small `δ` each germ is
either off `Γ` or inside one arc of `Γ` on `ω(p)`; a germ **lies on a (Q) arc** when that arc is a (Q) arc.

**Step 1 (the germs' colours).** The points of `u⁻` and `v⁻` are at distance 1 from interior points of `R′` (their `∓60°` images lie just clockwise of `y`),
so by N-E1 they carry no `X̄`; those of `u⁺`, `v⁺` carry no `X`. A germ off `Γ` has one absent colour (TWIST-D), hence `X` at `u⁻, v⁻` and `X̄` at `u⁺, v⁺`.
A germ inside an arc of `Γ` that is not a (Q) arc has a side colour not at `p` (`p` has four colours, so "(Q)" fails only by a side colour), an absent colour,
hence again `X` at `u⁻, v⁻` and `X̄` at `u⁺, v⁺`. **So a germ not on a (Q) arc lies in the closure of a tile of colour `X` (at `u⁻`, `v⁻`) or `X̄` (at
`u⁺`, `v⁺`).**

**Step 2 (four half-planes).** A tile has diameter at most 1 (its distances form an interval from 0 that avoids 1). By CL, `R` is the only tile of colour `X`
at `y` and `R′` the only one of `X̄`.
- (a) `u⁻` not on a (Q) arc: its `X`-tile has points within `< 1` of `R`'s points just counter-clockwise of `y` (angular gap below `60°`), so it is `R`; then
  `u ∈ cl R`, `R ⊂ B̄(u, 1)`, and **`R`'s cone at `y` lies in `[ψ + 30°, ψ + 210°]`** (facing `u`, which is at `ψ + 120°` from `y`).
- (b) `v⁻` not on a (Q) arc: its `X`-tile holds `v`; it is not `R` (then `cl R` would hold points more than `60°` apart on the ring, more than 1 apart), so
  N3-FACE at `(y, v)` gives **`R`'s cone in `[ψ − 30°, ψ + 150°]`** (facing away from `v`, at `ψ + 240°`).
- (c) `v⁺` not on a (Q) arc: as (a), its `X̄`-tile is `R′`, `R′ ⊂ B̄(v, 1)`, **`R′`'s cone in `[ψ + 150°, ψ + 330°]`**.
- (d) `u⁺` not on a (Q) arc: as (b), **`R′`'s cone in `[ψ + 210°, ψ + 390°]`**.

**Step 3 (what fills the gaps).** (i) With (b) and (d), the open cone `I = (ψ + 150°, ψ + 210°)` meets neither `R` nor `R′`; a tile at `y` whose cone meets
`I` has a colour of `p` (only `R`, `R′` carry `X`, `X̄` there) and points in `B(p, 1)` (a direction `d ∈ I` has `d · e(ψ) < 0`), so it is within `< 1` of
`p`'s tile of its colour, hence (CL) is that tile: **a tip**, a tile of `p` reaching `y`. (ii) With (a) and (c), the open cone `O = (ψ − 30°, ψ + 30°)` meets
neither; a tile there has a colour of `p` and points outside `B̄(p, 1)`, while a tile of `p` lies in `B̄(p, 1)`: **an outer tile**, of a colour of `p`, not a
tile of `p`. (iii) With all four, the tip's colour and the outer tile's differ (two tiles of one colour at `y` would be one tile, and one is a tile of `p`, the
other not), so **`y` carries `X`, `X̄` and two colours of `p`**. ∎ *Uses:* N-E1, CL, N3-FACE, diameter; six colours at Step 1 only (a germ that misses `X̄`
has `X`, because two colours are absent). *Reads:* `B̄(p, 1 + ε)`. It is N7-HUB (b), (c) and N7-HUBQ's mechanism with the bends dropped: a non-(Q) arc of `Γ`
at a germ feeds its constraint as well as a ring tile does.

**RING-Q′ from RING-GERM.** If `y + 60°` and `y − 60°` lie on no closed (Q) arc, no germ lies on one (a (Q) arc whose closure holds `u` holds one of `u`'s
germs, and conversely), and (iii) applies. So every such change point is a vertex of at least four colours — in the class RING-Q′ names and in the wider one
of RING-GERM.

### 3.2 The disk's corner: RING-Q is not local (FS116-N1-QDISK)

The disk (`[Polymath2021]` Fig. 10, rebuilt as FS112-CAL-DISK) is a valid fragment on the disc of radius `r = √((25 + 9√5)/10) ≈ 2.12426` about its
centre (FS-112's exact check), so on `B̄(A₀, R)` for every `R < r − a ≈ 1.59852`, `a = |A₀|`. Read by `tools/fs116_n1_ring.py`: `A₀` carries red, blue,
yellow, orange (degree 4; `Z`, `W₀`, `P₀`, `P₄`); its ring carries four (Q) arcs; its change points are at `209.0102°` and `330.9898°`
(`data/fs116/n1/ring-survey.out`). **Exactly** (`diskexact`, 50-digit evaluation of the exact coordinates, `data/fs116/n1/disk-exact.out`): `ω(A₀)` meets the
segment `A₁X₁` — the common side of `W₁` (green) and `P₁` (violet) — at `t = 0.500932`, margins `0.50` and `0.50` from its ends; the rotations of `y` by
`±60°` about `A₀` lie strictly inside the (Q) arcs `A₂ → A₃` (inner `Z`, red; outer `P₂`, blue; margins `0.29`, `0.33` in cross product) and `B₀ → Y₀` (inner
`P₀`, orange; outer `T₁`, yellow; margins `0.087`, `0.26`); no other boundary piece comes within `10⁻³` of `y`, and the ring is green just clockwise of `y`,
violet just counter-clockwise. **So `y` is an edge point of two colours.** The class hypotheses, read in floats (`hyp`, `data/fs116/n1/hyp.out`): distinct
tiles of one colour are at least `1.000000` apart (non-Siamese), and no two tiles' closures meet in more than one component (simple, on the sampled
boundaries). `|y| = 0.875`, so the disk holds `B̄(y, 1)` too. The mirror change point at `330.99°` is the same by the disk's reflection symmetry. The germ report
(`germ`, `data/fs116/n1/germ.out`): at both, **no germ is off the (Q) arcs**, and RING-GERM forces nothing — consistent.

### 3.3 The controls, and `k = 7`

`data/fs116/n1/germ.out` reports, at every change point of the held rings, which germs lie off (Q) arcs, what RING-GERM forces, and what the fragment has:
- **the strip's midline vertices** — change points at `0°`, `180°` with germs `u⁻`, `v⁺` off (Q) (their `±60°` points end (Q) arcs): (ii) forces an outer
  tile; the fragment has two (`U₂`, `D₂` at `P₂`) and no tip; four colours. Outside RING-Q′'s scope; RING-Q's conclusion holds there.
- **the disk's corner** — as § 3.2: no germ off (Q); two colours. RING-Q's conclusion fails (at radius `< 1.5985`); RING-Q′ is silent.
- **FS114-Y2-BOWTIE's centre** (rebuilt by FS114-YB2) — its ring carries two (Q) arcs, the Reuleaux caps (inner `t1`, outer colour 3, as FS114-N6 § 4 says:
  "Its caps are (Q) arcs"); change points `top`, `bot` with germs `u⁻`, `v⁺` off (Q): (ii) forces an outer tile; the fragment has an outer tile and a tip; four
  colours.
- A **plant in the checker** (`germ --plantrule`: the tip read from the pair `u⁻, v⁺` instead of `v⁻, u⁺`) is reported as a violation at four change points.
- **`k = 7`.** R7's lattice points carry six colours and their rings no change point (§ 2.4): RING-GERM, RING-Q and RING-Q′ are vacuous there. With seven
  colours and four at `p`, three are absent and Step 1 fails: a germ that misses `X̄` may carry the third absent colour. **Six is spent at Step 1.**

### 3.4 What RING-Q needs, and what it does to the plan

- **Where the gap sits.** At a change point, the tip needs the outer pair of germs (`v⁻`, `u⁺`) off (Q) arcs and the outer tile needs the inner pair (`u⁻`,
  `v⁺`). A change point of fewer than four colours has a (Q) arc on a germ of each missing kind — at the disk's corner on all four. Such a change point is not
  excluded by anything inside `B̄(p, 1.5985) ∪ B̄(y, 1)`; RING-Q as posed is therefore an exclusion at radius 2 of a configuration class (a change point of two
  or three colours whose `±60°` points lie on (Q) arcs), D2's kind of statement, not a ring lemma. **Registered prediction P3** ("RING-Q holds", 0.45): not
  decided; its ring-scale form is lost (the disk).
- **For D2's route.** Four-colour vertices propagate from a change point `y` to its neighbours at `y ± 60°` (N7-CHAIN's chains) exactly as long as the germs
  there avoid (Q) arcs (RING-Q′); where a chain meets a (Q) arc, the outer-pair rule and the inner-pair rule say which of the tip and the outer tile survive.
  The first object for D2 and for the construction side is the disk's corner configuration: **a two-colour change point whose `±60°` points lie inside (Q) arcs.**
  A fragment by formula holding it on `B̄(p, R)` with `R > 2` makes RING-Q FALSE; an exclusion of it at radius 2 is RING-Q's missing step.
- **A consequence for RING-TWIST** (RING-TWIST-Q below): in a non-Siamese simple fragment every change point of a qualifying window has **both** germs at `y − 60°`
  on (Q) arcs; so a ring with no (Q) arc has no qualifying window at all, and RING-TWIST's parity clause has content only just after a (Q) arc.

### 3.5 The entries

derivation: RING-GERM
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the
    ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and
    just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither
    v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor
    v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is
    not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours
  uses only: FS116-N1-TWIST-D (a ring point off Γ has a colour absent at p); N-E1; CL and N3-FACE (non-Siamese); that a tile has diameter at most 1; six
    colours, spent once, at Step 1 (a germ carrying no X̄ and a colour absent at p carries X)
  not claimed: anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on (Q)
    arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)
  argument: § 3.1 The germ lemma (RING-GERM) and its argument
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: the capped strip's midline vertex P₀ at its change point P₂ (u⁻, v⁺ off (Q) arcs; (ii) met by two outer tiles) and FS114-Y2-BOWTIE's centre at top
    (u⁻, v⁺ off (Q) arcs; an outer tile and a tip) — `data/fs116/n1/germ.out`
  prior art: partly: FS114-N7-HUB (b), (c) and FS114-N7-HUBQ (one mind each), whose mechanism this is, stated there on rings bent to (Q) and (R2) arcs; the
    split of the four germs into the tip's pair and the outer tile's pair not found — FS-116's gate (`plans/FS116-local-exclusion.md` § 2.3), 12 queries
  handoff: de Bruijn — the statement with its four germs, the six-colour step named, over TWIST-D; queued behind D6's map type

derivation: RING-Q-PRIME
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries a (Q) arc,
    every change point of the ring whose points at ±60° on ω(p) lie on no (Q) arc is a vertex of at least four colours
  uses only: RING-GERM (iii); that a (Q) arc whose closure holds a ring point holds one of its two germs
  not claimed: the change points with a point at ±60° on a (Q) arc (RING-Q, GAP); "lie on" read as the open arc (then a ±60° point may end a (Q) arc, as at
    the strip's P₂, and RING-GERM gives only one of the tip and the outer tile)
  argument: § 3.1 The germ lemma (RING-GERM) and its argument
  verdict: derived
  grade: derived from: RING-GERM
  minds: 1
  model: none held with a (Q) arc on the ring and a change point in scope — the strip's and the Y2 bowtie's change points have ±60° points ending (Q) arcs,
    the disk's inside them; the statement holds at the class RING-GERM names, where FS114-N7-HUB's (Q)-free rings are its instances
  prior art: partly: FS114-N7-HUBQ ("At a change point whose ±60° points have κ defined just outside, a tip exists", one mind), here with the outer tile and
    without bends
  handoff: de Bruijn — with RING-GERM

derivation: FS116-N1-QDISK
  statement: the disk of `[Polymath2021]` Fig. 10 (FS112-CAL-DISK), restricted to the closed disc of radius R about its corner A₀, is for every R below
    r − |A₀| ≈ 1.59852 (r = √((25 + 9√5)/10) its rim radius) a non-Siamese simple valid fragment about a vertex of four colours whose ring carries a (Q)
    arc, and the ring's change point y where ω(A₀) crosses the segment A₁X₁ is an edge point of two colours, green (W₁) and violet (P₁), whose points at
    ±60° lie inside the (Q) arcs A₂A₃ and B₀Y₀; so RING-Q with "radius above 2" replaced by any radius below 1.59852 is false
  uses only: the disk's exact coordinates (FS112-YB2's rebuild, `tools/fs112_yb2_objects.py`) and FS-112's exact validity check of it; the location of y and
    its ±60° points evaluated to 50 digits from exact expressions, every inequality with margin above 0.08; the two-colour neighbourhood of y, non-Siamese and
    simple read in floats
  not claimed: that RING-Q as posed (radius above 2) is false; that the disk extends to a fragment on any disc of radius 2 about A₀ (FS114-Y-PENT: no valid map
    agrees with the disk near its B_k); that non-Siamese and simple are exact (they are float readings on sampled boundaries)
  argument: § 3.2 The disk's corner: RING-Q is not local (FS116-N1-QDISK)
  verdict: derived
  grade: computed over: the disk's corner A₀ — the point y, its ±60° points and the arcs holding them, exact to 50 digits; the class hypotheses in floats
  minds: 1
  model: the disk itself, about A₀
  prior art: partly: the disk is Gibbs's (`[Polymath16threads]` `[07.49]`, `[Polymath2021]` Fig. 10); that its corners' rings have two-colour change points
    not found in print — FS-116's gate, "unit distance" & ("circular arcs" | "arcs of unit" | "unit arcs") (1)
  handoff: none — a statement about one held object; it crosses to Lean only as a control of RING-Q's scope

derivation: RING-TWIST-Q
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, every change point y in a
    half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D has both of its germs at y − 60° on (Q) arcs; so if the ring carries no (Q) arc, D meets every
    half-open arc of ω(p) of 120°
  uses only: RING-TWIST-C (a qualifying window holds an odd number of colour changes, each carrying the two absent colours only, and in this class they are
    change points); RING-GERM (i) and (ii); that a (Q) arc lies in D
  not claimed: that any fragment has a qualifying window; the Siamese or non-simple class (there a colour change may end a seam, where RING-GERM does not apply)
  argument: § 3.4 What RING-Q needs, and what it does to the plan
  verdict: derived
  grade: derived from: RING-TWIST-C, RING-GERM
  minds: 1
  model: FS114-Y2-BOWTIE's centre and the strip's midline vertices — rings whose D meets every half-open 120° arc (`data/fs116/n1/ring-survey.out`)
  prior art: partly: FS114-N6-RING60 with FS114-N7-HUB give it for (Q)-free rings after the bends (change points 60° apart, each in D)
  handoff: none — a relay-result tying RING-TWIST's parity clause to the (Q) arcs

derivation: RING-Q
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries a (Q) arc,
    every change point of the ring that lies on no (Q) arc is a vertex of at least four colours
  argument: § 3.4 What RING-Q needs, and what it does to the plan
  verdict: gap: a change point y with a germ at y ± 60° on a (Q) arc — RING-GERM forces no tip when v⁻ or u⁺ lies on one and no outer tile when u⁻ or v⁺
    does, and the disk's corner (FS116-N1-QDISK) has such a change point of two colours on a fragment holding B̄(A₀, 1.5985) and B̄(y, 1), so the step can
    close only through points of B̄(p, 2) outside both

control: disk-two-colour
  of: FS116-N1-QDISK — the change point on A₁X₁ and its ±60° points inside the (Q) arcs, exactly; the point rotated 20° about A₀ fails
  run: python3 ../tools/fs116_n1_ring.py diskexact --line --noexit
  expect: DISKEXACT OK
  fault: python3 ../tools/fs116_n1_ring.py diskexact --plant --line --noexit

control: disk-class
  of: FS116-N1-QDISK — non-Siamese and simple read on the disk and the strip; W₁ recoloured violet makes a Siamese pair
  run: python3 ../tools/fs116_n1_ring.py hyp
  expect: disk: least distance between distinct tiles of one colour 1.000000; tile pairs meeting in more than one component: []
    strip: least distance between distinct tiles of one colour 1.000000; tile pairs meeting in more than one component: []
  fault: python3 ../tools/fs116_n1_ring.py hyp --plant

control: germ-report
  of: RING-GERM — at every change point of the held rings, the forced tip and outer tile are present; the tip read from the wrong germs is caught
  run: python3 ../tools/fs116_n1_ring.py germ
  expect: strip P0=(0,0)
      y=   0.000  germs off (Q): u-v+  (i) tip forced=False has tip=False  (ii) outer forced=True has outer=True  colours=4  CONSISTENT
      y= 180.000  germs off (Q): u-v+  (i) tip forced=False has tip=False  (ii) outer forced=True has outer=True  colours=4  CONSISTENT
    strip P1=(1/2,0)
      y=   0.000  germs off (Q): u-v+  (i) tip forced=False has tip=False  (ii) outer forced=True has outer=True  colours=4  CONSISTENT
      y= 180.000  germs off (Q): u-v+  (i) tip forced=False has tip=False  (ii) outer forced=True has outer=True  colours=4  CONSISTENT
    disk corner A0
      y= 209.010  germs off (Q): none  (i) tip forced=False has tip=False  (ii) outer forced=False has outer=False  colours=2  CONSISTENT
      y= 330.990  germs off (Q): none  (i) tip forced=False has tip=False  (ii) outer forced=False has outer=False  colours=2  CONSISTENT
    Y2 bowtie centre
      y=  90.000  germs off (Q): u-v+  (i) tip forced=False has tip=True  (ii) outer forced=True has outer=True  colours=4  CONSISTENT
      y= 270.000  germs off (Q): u-v+  (i) tip forced=False has tip=True  (ii) outer forced=True has outer=True  colours=4  CONSISTENT
  fault: python3 ../tools/fs116_n1_ring.py germ --plantrule

## Stage 3 — SAVED
