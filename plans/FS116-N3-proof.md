# FS116-N3 — FS-116's proof side, round 4: the semi-hub rule (RING-TRANSFER-Q)

*Ephodos (Opus 5.5), job FS116-N3. Launched 2026-09-29 07:42 UTC and stopped at once by the account's halt, before anything was saved;
resumed 2026-10-03 14:36 UTC by the coordinator's message ("resume from where you stopped, starting with your stage 1 readback"). Brief
`data/fs116/briefs/FS116-N3-semihub.md`, with `plans/STANDING-RULES.md` as part of it. Identity and procedure: `.claude/agents/ephodos.md` § A
derivation job. Frozen claims: `data/fs116/claims.md` (§ 0's definitions verbatim; "valid fragment" is six-coloured unless `k` is named). I touch
only this record, `data/fs116/n3/`, `tools/fs116_n3_*.py` and `data/fs116/reports/FS116-N3.md`. Resuming check (standing rule 2): no record and no
commit of this job existed at the resume (`git log -- plans/FS116-N3-proof.md` empty; `data/fs116/n3/` empty), so nothing is redone. Grades are my
identity's grammar; the edge translation is `.claude/agents/ephodos.md` § Two vocabularies (`hand` = [hand], `derived from` = [derived],
`computed over` = [tools]).*

**Notation** (FS116-N1's and FS116-N2's headers; nothing new is meant but the words marked *new*). `p` a vertex, `ω(z)` the unit circle about `z`,
`e(θ)` the unit vector at angle `θ`, `r(θ) = p + e(θ)`; `C(z)` the colours of the tiles whose closure holds `z`, `P = C(p)`, `A(z)` the colours absent at
`z` (six in all). **N-E1**: an interior point of a tile of colour `c` is at distance 1 from no point of the closure of a tile of colour `c`.
**Non-Siamese**: distinct tiles of one colour have all cross-distances at least 1; so at a point at most one tile of each colour. **Simple**: § 0's; a
tile's cone at a vertex is one closed interval of directions (possibly a single direction, a cusp). A tile has diameter at most 1. A **change point**
`y = r(ψ)` of `p`'s ring has the ring off `Γ` on both sides (reading L, the list's § 10), colour `X̄` just clockwise (tile `R′`) and `X` just
counter-clockwise (tile `R`); `u = r(ψ + 60°)`, `v = r(ψ − 60°)`; the **germs** `u⁻, u⁺, v⁻, v⁺` and "a germ lies on a (Q) arc" are RING-GERM's. A
**tip** at `y` is a tile of `p` whose closure holds `y`; an **outer tile** a tile of a colour of `p` that is not a tile of `p`; `T_y`, `O_y` their
colours (FS116-N2-STAR). *New:* the **tip pair** is `{v⁻, u⁺}` and the **outer pair** `{u⁻, v⁺}` (the pairs RING-GERM (i) and (ii) read). `y` is a **hub**
when its four germs lie on no (Q) arc (FS116-N2's word), a **semi-hub** when exactly one of the two pairs has both its germs on no (Q) arc — **of kind O**
when that pair is the outer pair, **of kind T** when it is the tip pair — and **closed** when neither pair does. A semi-hub is **full** when both germs of
its other pair lie on (Q) arcs; a full semi-hub is **crossed** when those two (Q) arcs' colour pairs are disjoint and **parallel** when they are equal (by
FS114-N7-QOPP each (Q) arc's colours are those of two opposite tiles of `p`, so the pairs are disjoint or equal). In the arguments `ψ = 0°` and angles at
`y` are measured from `e(0°)`, the direction away from `p`.

## Theorems this phase proved

- **FS116-N3-QT** — the brief's quotation is verbatim in `data/fs116/claims.md` — computed over the one blockquote (`tools/fs116_n3_quotes.py`), § 1.1.
- **FS116-N3-CONE** — at a change point, a germ off (Q) arcs puts `R` or `R′` inside or outside the unit disc about `u` or `v`, a germ on a (Q) arc bars its two colours from a half-circle at `y`, and an edge between a tile inside and one outside `B̄(w, 1)` is an arc of `ω(w)` — [hand], one mind, over RING-GERM, GERM-R and NOBOTH, § 2.1.
- **FS116-N3-PAIR** — two (Q) arcs at one germ pair with one colour pair have their inner colours swapped — [hand], one mind, § 2.2.
- **FS116-N3-STAR2** — a full semi-hub of kind O pins `p`'s star: crossed, `ℓ + m ≤ 60°` and four edge windows; parallel, the arcs' tiles above and below `y` — [derived], one mind, § 2.3.
- **FS116-N3-SEMI** — a semi-hub is a vertex of at least four colours, or a three-colour vertex with an edge along `ω(y ± 60°)` of kind both (so `y ± 60°` has four colours), or a parallel full semi-hub of three named colours — [derived], one mind, § 2.4.
- **FS116-N3-CROSS** — at a crossed full semi-hub of kind O (the strip's type) tips have zero angle and the outer colours are the (Q) arcs' outer colours; with four colours the missing pair is the inner colours, and `p` is a change point and a semi-hub of kind O of `y`'s ring — [derived], one mind, § 3.1.
- **RING-TRANSFER-QC** — the semi-hub rule assembled (round 3's corrected form at semi-hubs) — [derived], one mind, § 3.3.
- **RING-TRANSFER-Q** — GAP at three named places (SEMI-PAR3; closed change points; crossed reciprocity) — § 3.3. **SEMI-PAR3** — GAP — § 3.2.

## Would-have-searched-here log (standing rule 5)

- The ban's end date (2026-10-01) has passed and `CLAUDE.md` § Toolchain has not been rewritten; the list's § 9 forbids enumerating ring types "by any
  program" in any case, so the log is kept. Stage 1: none (reading and recognition).
- Stage 2: would have searched germ data (which germ on which arc, which colours) at a change point for the configurations with three colours at `y`;
  instead derived them by cases from the cone lemmas (§ 2.4), and read only the held fragments' change points exactly as they are (`tools/fs116_n3_semi.py`).
- Stage 3: would have searched for a parallel full semi-hub of three colours (the bowtie with its tip removed); instead stated its forced shape
  (§ 3.2) and left the construction to the construction side.

## Fence log (standing rule 8)

- No path is fenced for this job; I must write nothing about my work where FS116-V3 or FS121-V4 could read it before their verdicts, so I write only
  here, in `data/fs116/n3/`, in `tools/fs116_n3_*.py` and in my report. The start-up context held the auto-memory index (status lines, no proof content).
  I read no session transcript and no record of FS116-V3, FS121-V4, FS116-Y3 or FS116-S1.

## G87 lookout

- Stage 1: none seen as two truths in collision. One scope classed: N2's § 3.2 says a transfer rule for (Q) types "needs a placing rule at" semi-hubs,
  reading the placed vertex as `y` itself; the recognition below says a semi-hub can place its four-colour vertex at `y ± 60°` instead — a reading of
  where the placement lands, not two held truths.

## Stage 1 — SAVED: the readback, and recognition on the claim

### 1.1 Readback of the brief

`tools/fs116_n3_quotes.py` extracts the brief's one blockquote and searches it, whitespace collapsed, in the source its `— source:` line names:
**FOUND 1 of 1** (RING-TRANSFER, `data/fs116/claims.md` § 5; `data/fs116/n3/quotes.out`); the plant (`--alter`, "finite rule" → "finite law") is
**FOUND 0 of 1** (`quotes-plant.out`). By hand, the brief's pointers: RING-TRANSFER-C and RING-TRANSFER-Q are at `plans/FS116-N2-proof.md` § 3.3 and
§ 3.2 (the brief says "§ 3.3 states them"; RING-TRANSFER-Q's entry sits in § 3.2 and § 3.3 names it — a pointer, not a mismatch); RING-GERM, RING-TWIST-C,
FS116-N1-TWIST-LIT are the list's § 10, at two minds (`plans/FS116-close-inventory.md` items 48–49, under reading L); FS116-O1-SATPIN's corrected wording
is FS116-V1's (items 30–31); N7-HUB (b), (c) at two minds (item 30); the one-mind round-1 inputs are where the brief says (`plans/FS116-N1-proof.md`
§§ 3–4), FS116-N1-GERM-R under FS116-V3's blind check (item 59); FS121-D3's recognition is `plans/FS121-D3-proof.md` § 1.2 ("each change of colour
across an interface is a swap with a unit neighbour") and § 2.3 (FS121-D3-SWAP1D). The brief's "a qualifying window (a 120° arc of ω(p) free of D)" is
RING-TWIST-C's half-open 60° window `W` with `W ∪ σ(W)` off `D`, restated. No mismatch.

derivation: FS116-N3-QT
  statement: the blockquote of `data/fs116/briefs/FS116-N3-semihub.md` occurs verbatim, whitespace collapsed, in `data/fs116/claims.md`
  uses only: the brief's blockquote and its `— source:` line; whitespace normalisation only
  not claimed: that the brief's unquoted prose is faithful beyond the pointers checked by hand in § 1.1
  argument: § 1.1 Readback of the brief
  verdict: derived
  grade: computed over: the brief's one blockquote against `data/fs116/claims.md`
  minds: 1
  model: the brief's RING-TRANSFER quotation, found at `data/fs116/claims.md` § 5
  prior art: known: a quotation check, the workflow's readback
  handoff: none — a readback, no mathematics

control: fs116-n3-quotes
  of: FS116-N3-QT — the quotation found, and one altered by a word not found
  run: python3 ../tools/fs116_n3_quotes.py --count
  expect: FOUND 1 of 1
  fault: python3 ../tools/fs116_n3_quotes.py --count --alter

**My claim, restated beside the quotation.** The frozen RING-TRANSFER is MISSTATED (round 3); my work is its (Q)-arc case in round 3's corrected
form: at a change point of a four-colour ring one of whose germ pairs lies on (Q) arcs — a semi-hub — state and derive the rule for what is placed at
distance 1 (the placed vertex's colours, its missing pair, its ring at `p`, `u`, `v`), name which semi-hub types recur, and give each lemma's behaviour
on the strip and the disk and at `k = 7`. I propose the rule's statement below before deriving it, for a blind check.

**Read, in this order:** the brief; the standing rules; the frozen list in full; `plans/FS116-N2-proof.md` in full; the plan
(`plans/FS116-local-exclusion.md`) in full; `plans/FS116-N1-proof.md` header, §§ 2–3 (TWIST-D, RING-TWIST-C, RING-GERM, RING-Q-PRIME, QDISK, RING-TWIST-Q)
and § 4.0–4.2 (GERM-R, GERM-S, QFREE4, TOUCH, ECHO); `plans/FS114-N7-proof.md` stage 2 § 2.1 (N7-HUB, -REACH, -TAN, -TAC) and stage 3 (N7-FLANK,
-QOPP, -CHAIN, -HUBQ, the (Q) cases, OC); `plans/FS121-D3-proof.md` § 1.2 and § 2.3; `plans/FS116-close-inventory.md` items 1–74;
`plans/FS112-derivation.md` header and FS112-U1, FS112-N3-NOBOTH with its proof (`plans/FS112-N-proof.md` l. 731) and `data/fs112/claims.md` § 0's contact
kinds; the held rings' outputs `data/fs116/n1/ring-survey.out`, `ring-survey-bowtie.out`, `germ.out`, `data/fs116/n2/star.out`; the strip's and the
bowtie's constructions by formula (`tools/fs112_yb2_objects.py` header and `Strip`; `tools/fs114_yb2_run.py` `Bowtie`). The object is the plan's (the
ring of a four-colour vertex), unmoved since its §G and since N2: no re-walk of the grokkings.

### 1.2 Recognition (`ephodos-recognition`, invoked fresh)

**The stall.** Two shapes at once. *A result proved only at instances:* the strip's midline change points `P_{±2}` are semi-hubs of kind O (germs
`u⁻, v⁺` off (Q) arcs, `u⁺, v⁻` at (Q) ends: `data/fs116/n1/germ.out`) and are four-colour vertices, while no held lemma places anything there.
*A known theorem that almost applies:* RING-GERM (iii) places a four-colour vertex when all four germs are off (Q) arcs; at a semi-hub one of its two
half-rules is lost.

**For a stranger** (a discrete geometer who works on map colourings of the plane avoiding distance 1, Woodall's and Townsend's vertex lemmas):
*A map of the plane by regions bounded by segments and circular arcs is coloured with six colours, no two interior points of one colour at distance 1.
Four regions meet at `p`. The unit circle about `p` passes, at `y`, from a region of one of the two colours missing at `p` to a region of the other.
Let `u` and `v` be the points of the circle at 60° on either side of `y`, so that `p, u, y, v` is a rhombus of two unit equilateral triangles. Near `u`
on the far side from `y` the circle runs along a boundary arc between two regions whose colours are both present at `p` (the unit-radius tactic), and
likewise near `v`; near `u` and `v` on the near side it does not. How many colours meet at `y`, and which?* Words the reader stops at: "(Q) arc" (struck
into the sentence as the tactic arc); "germ", "semi-hub", "ring" (struck: the sentence names the arcs). Nothing else.

**The features, sorted** (receipt in brackets):
- **each germ: off (Q) arcs, or on a (Q) arc with that arc's two colours** — *determines* [RING-GERM's Step 2 consumes "off (Q)" to put `R` or `R′` on
  one side of the perpendicular at `y` to `y − u` or `y − v`; FS116-N1-GERM-R consumes "on a (Q) arc of colours `a`, `a′`" to bar `a` and `a′` from an open
  half-circle of directions at `y`. Removed, the strip's `P₂` would be a hub and carry a tip; it has none].
- **which pair is off (Q) arcs** — *determines* which of a tip and an outer tile is forced [RING-GERM (i), (ii)].
- **the two (Q) colour pairs of a full semi-hub: disjoint or equal** — *determines* [crossed: the strip's `P₂` (pairs `{P, O}` and `{M, B}`) has no tip;
  parallel: FS114-Y2-BOWTIE's centre at `top` (pairs `{3, 1}` and `{1, 3}`) has one — `germ.out`]. In the Kneser language of FS116-N2 § 1.2: the pairs are
  edges of the diagonal perfect matching of `p`'s four tiles, and "crossed" is "the two edges of that matching", an edge of `KG(4, 2)`.
- **the inner/outer orientation of the two (Q) arcs** — *splits*: consumed only as "the two inner tiles differ" (a tile of `p` holding `u` and `v` has
  diameter `√3`); the consequence determines (one orientation of the parallel case is impossible), the rest accompanies.
- **the (Q) arcs' lengths** — *accompany* [they enter only as `0 < ℓ ≤ 60°` in FS114-N7-QOPP's windows, and cancel from the pinned star].
- **`p`'s star** (which tiles of `p` hold `ψ ± 90°` and `ψ + 180°`) — *determines* [FS116-N2's finding: outer colours' tiles of `p` lie in
  `[ψ + 90°, ψ + 270°]`, tips' in `[ψ − 90°, ψ + 90°]`, tiles holding `ψ ± 90°` inside their cones miss `y`].
- **the three unit pairs `(y, p)`, `(y, u)`, `(y, v)`** — *determine*: at `y` the six directions `ψ + 30° + 60°m` are the perpendiculars to `y − u`,
  `y − p`, `y − v`; a tile at `y` whose cone crosses the perpendicular to `w − y` has its colour absent at `w` (N-E1), and a tile inside `B̄(w, 1)` beside a
  tile outside `B(w, 1)` meets it along `ω(w)` [receipt: every step of RING-GERM's Step 2 and of FS112-U1 is this].
- **six colours** — *determines* [two absent colours; RING-GERM's Step 1].
- **non-Siamese, simple** — *determine* [one tile per colour at a point; one cone per tile].
- **`y`'s far ring, beyond `B̄(p, 1)`** — *accompanies* at this step (FS116-N2 § 2.3).

**The homes.**
1. **The cone calculus at the unit rhombus `p, u, y, v`** (the project's own: N-E1, N3-FACE, FS112-U1, FS112-N3-NOBOTH, RING-GERM). Name: at `y`, three
   unit neighbours `p`, `u`, `v`, six perpendicular directions, and each tile's cone placed against them. Theorem held: NOBOTH — a unit arc whose centre
   carries both its side colours has a centre of at least four colours or a repeated colour. Dictionary: germ off (Q) ↔ `R` (or `R′`) inside or outside the
   unit disc about `u` (or `v`); germ on a (Q) arc ↔ two colours of `p` barred from a half-circle at `y`; three colours at `y` ↔ two of `y`'s tiles adjacent
   across a perpendicular, so their edge runs along `ω(u)` or `ω(v)`. *Tests.* The old proofs apply at once (RING-GERM (i)–(iii) and N7-HUB are its
   all-germs-off case); the exceptions vanish into one statement per kind (§ 1.3); **it predicts neighbours**, each checkable on a held fragment: a crossed
   semi-hub of kind O has no tip of positive angle (the strip's `P₂`: none), a parallel one's only possible tip is the tile of `p` facing `y` (the bowtie's
   `top`: its tip is `t2`, the tile above `p`), and the parallel orientation is forced swapped (the bowtie: inner 3 at `u⁺`, inner 1 at `v⁻`). **Adopted.**
2. **The Kneser graph `KG(4, 2)`** (FS116-N2's home): the (Q) colour pairs as matching edges; crossed = complementary. **Kept as language** for the case
   split; it holds no theorem about directions.
3. **Map-colouring vertex lemmas** (Woodall 1973, Townsend, Thomassen 1999 — recalled, not read here): their vertex lemmas assume no unit-radius tactic
   (Thomassen's criterion (ii); S–V's Condition 5), which is exactly what a (Q) arc is. **Killed as a decider**: the hypothesis the theorem needs is the
   feature that defines the semi-hub.
4. **Local rules for Delone sets**: killed again for FS116-N2's reason (types vary at the first shell).

**The recognition sentence.** *A semi-hub is decided by the cone calculus at the unit rhombus `p, u, y, v`: a germ off (Q) arcs puts `y`'s `X`- or
`X̄`-tile inside or outside the unit disc about `u` or `v`, a germ on a (Q) arc bars that arc's two colours — one edge of the diagonal matching of `p`'s
tiles — from an open half-circle at `y`; so the colours at `y` are forced up to which half-circles they occupy, and where only three colours meet at `y`
two of its tiles are adjacent across a perpendicular and their edge runs along `ω(u)` or `ω(v)` with both its side colours at the centre, which NOBOTH makes
a vertex of at least four colours.* **It differs from the plan's frame and from N2's** in one place: the vertex a semi-hub places can sit at `y ± 60°`
rather than at `y`; and the one configuration the calculus leaves open is the parallel full semi-hub. Reported to the coordinator.

**Novelty, at the grain of the step:** the ingredients are in-house (FS-112's U1 and NOBOTH, FS-114's N7 tools, FS-116's ring lemmas); their composition
at a semi-hub is not found in FS-116's gate (`plans/FS116-local-exclusion.md` § 2.3, 12 queries); a search in the map-colouring vocabulary is owed
(INVENTORY).

### 1.3 The proposed statements (for freezing before any derivation is read)

Each is stated in this record's setting words (§ Notation); "lies on a (Q) arc" and the germs are RING-GERM's; nothing below is derived yet.

- **FS116-N3-SEMI** *(proposed here)*: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four
  colours, let y = r(ψ) be a semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of
  whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then
  a vertex of at least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose
  cone holds ψ + 180° (kind O) or ψ (kind T) in its interior. *Not claimed:* that a semi-hub has four colours; that the third alternative occurs, or that
  it is excluded; anything at a closed change point (the disk's corner); Siamese or non-simple fragments; anything at `k ≥ 7`.
- **FS116-N3-PAIR** *(proposed here)*: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four
  colours, if both germs of one pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour
  of each is the outer colour of the other. *Not claimed:* anything about two (Q) arcs not at one pair's germs.
- **FS116-N3-CROSS** *(proposed here)*: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four
  colours, let y = r(ψ) be a crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner
  colour b and outer colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours
  and every tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along
  ω(y) at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of
  the ring of y. *Not claimed:* that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at
  `k ≥ 7`.

## Stage 1 — SAVED

## Stage 2 — SAVED: the cone lemmas at the rhombus, PAIR, the pinned stars, and SEMI

*Class throughout (**setting S**): a non-Siamese simple valid fragment (six colours) on a closed disc of radius above 1 about a vertex `p` of at least four
colours, `y = r(ψ)` a change point of its ring; so `p` has four colours and no more and `A(p) = {X, X̄}` (RING-GERM). `ψ = 0°`; directions at `y` and at
`p` are angles from `e(0°)`. FS114-N7-QOPP's windows, used below, for a (Q) arc `[α, β]` of the ring (`0 < β − α ≤ 60°`, the inner tile holding the whole
arc): the inner tile is a tile of `p` with cone in `[β − 90°, α + 90°]`; the tile of `p` of the outer colour has cone in `[β + 90°, α + 270°]`; the two are
opposite at `p`; the tile of `p` counter-clockwise after the inner one holds `[α + 90°, β + 90°]` in its cone, and the one after the outer colour's tile holds
`[α + 270°, β + 270°]`. (Each line is N-E1 or non-Siamese at a unit pair `(p, r(θ))`, `θ ∈ [α, β]`: a tile of `p` holding `r(θ)` lies in `B̄(r(θ), 1)`; the
tile of `p` of the outer colour is not the outer tile, which leaves `B̄(p, 1)`, so it misses `B(r(θ), 1)`; the windows are disjoint with gaps of length
`β − α > 0`, so the two tiles are not adjacent, and each gap lies in the cone of the one tile between them on that side.)*

### 2.1 The cone lemmas at the unit rhombus `p, u, y, v` (FS116-N3-CONE)

**(a) Germs off (Q) arcs** (RING-GERM's Steps 1–2, two minds, with the disc statements read off them). `u⁻` off (Q): `u ∈ cl R`, so `R ⊂ B̄(u, 1)` and
`R`'s cone at `y` lies in `[30°, 210°]`. `v⁻` off (Q): an `X`-tile `R_v ≠ R` holds `v` (one holding `y` and `v` together would hold points of `R` near `y`
and of `v⁻`, more than 1 apart), so `R ∩ B(v, 1) = ∅` (non-Siamese) and `R`'s cone lies in `[−30°, 150°]`. `v⁺` off (Q): `v ∈ cl R′`, `R′ ⊂ B̄(v, 1)`, cone in
`[150°, 330°]`. `u⁺` off (Q): an `X̄`-tile `R′_u ≠ R′` holds `u`, `R′ ∩ B(u, 1) = ∅`, cone in `[−150°, 30°]`.

**(b) A germ on a (Q) arc bars its two colours.** A germ on a (Q) arc lies in the closure of the arc's inner and outer tiles, so FS116-N1-GERM-R (one mind:
for `z = y + h` along `β`, the point of `ω(z)` near `u` falls in `u⁺` when `|z − u| < 1`, i.e. `β ∈ (30°, 210°)`, and N-E1 forbids a tile of a colour that
closes on `u⁺` there) bars both colours at `y`: `u⁺`'s from `(30°, 210°)`, `v⁻`'s from `(150°, 330°)`, `u⁻`'s from `(−150°, 30°)`, `v⁺`'s from `(−30°, 150°)`.

**(c) Two tiles across a unit circle.** If tiles `T₁`, `T₂` consecutive at `y` have `T₁ ⊂ B̄(w, 1)` and `T₂ ∩ B(w, 1) = ∅`, the edge between them at `y` lies in
`cl T₁ ∩ cl T₂ ⊂ ω(w)`: an arc of `ω(w)`. If both colours are carried at `w`, the arc is of kind both at `w` (`data/fs112/claims.md` § 0: in-contact and
out-contact), and FS112-N3-NOBOTH (two minds; its proof, `plans/FS112-N-proof.md` l. 731 with FS112-U1, reads only the cones at the centre) makes `w` a vertex
of at least four colours or a repeated colour — four colours, the class being non-Siamese.

**(d) STAR's windows** (FS116-N2-STAR, one mind): `C(y) = A(p) ⊔ T_y ⊔ O_y` and `A(y) = P ∖ (T_y ∪ O_y)`; a tip's cone at `p` lies in `[−90°, 90°]` and at
`y` in `[90°, 270°]` (it lies in `B̄(p, 1)`); an outer tile's cone at `y` lies in `[−90°, 90°]` and the tile of `p` of its colour in `[90°, 180° + 90°]` (the two
are far apart, so the outer tile misses `B(p, 1)` and `p`'s tile misses `B(y, 1)`).

### 2.2 The argument of FS116-N3-PAIR

The inner tile of a (Q) arc is a tile of `p` (its points near the arc lie in `B(p, 1)`, within `< 1` of `p`'s tile of that colour) and holds the whole arc in its
closure. The two germs of one pair sit at `u` and at `v` (the tip pair `v⁻, u⁺`; the outer pair `u⁻, v⁺`), and an arc on a germ at `u` (at `v`) holds `u` (`v`)
in its closure. If the two arcs had the same inner colour, the one tile of `p` of that colour would hold `u` and `v`, `|u − v| = √3 > 1`. So the inner colours
differ, and when the colour pairs are equal each arc's inner colour is the other's outer colour. ∎ *Uses:* non-Siamese, diameter. *Model:* FS114-Y2-BOWTIE's
centre at `top`: `u⁺` on the arc `3 | 1`, `v⁻` on `1 | 3` (`data/fs116/n3/semi.out`).

### 2.3 The pinned stars of a full semi-hub (FS116-N3-STAR2)

Put `A = [60°, 60° + ℓ]` and `B = [−60° − m, −60°]` for the (Q) arcs at `u⁺` and `v⁻` of a full semi-hub of kind O (`u⁻`, `v⁺` off (Q), so `A` starts at `u` and
`B` ends at `v`), `0 < ℓ, m ≤ 60°`; `a`, `a′` the inner and outer colours of `A`; `t_c` the tile of `p` of colour `c`.
- **Crossed** (`B` has colours `b` inner, `b′` outer, `{b, b′} ∩ {a, a′} = ∅`). The windows give `t_a ⊂ [ℓ − 30°, 150°]`, `t_{a′} ⊂ [150° + ℓ, 330°]`,
  `t_b ⊂ [−150°, 30° − m]`, `t_{b′} ⊂ [30°, 210° − m]`, and the tile after `t_a` holds `[150°, 150° + ℓ]` — not `t_b`, whose window misses `150°` — so the order is
  **`t_b, t_a, t_{b′}, t_{a′}`** counter-clockwise; then `t_a` holds `[30° − m, 30°]`, `t_{a′}` holds `[210° − m, 210°]`, `t_b` holds `[330°, 330° + ℓ]`, and the
  edges are `e₁ = t_b|t_a ∈ [ℓ − 30°, 30° − m]`, `e₂ = t_a|t_{b′} ∈ [30°, 150°]`, `e₃ = t_{b′}|t_{a′} ∈ [150° + ℓ, 210° − m]`, `e₄ = t_{a′}|t_b ∈ [210°, 330°]`;
  in particular **`ℓ + m ≤ 60°`**.
- **Parallel** (by PAIR, `B` has inner `a′` and outer `a`). The windows give `t_a ⊂ [ℓ − 30°, 150°] ∩ [30°, 210° − m] = [30°, 150°]` and
  `t_{a′} ⊂ [150° + ℓ, 330°] ∩ [210°, 390° − m] = [210°, 330°]`; the tile after `t_a` (call it `t_back`) holds `[150°, 150° + ℓ]` and `[210° − m, 210°]`, so its cone
  contains `[150°, 210°]`; the tile after `t_{a′}` (`t_front`) holds `[330°, 330° + ℓ]` and `[30° − m, 30°]`, so its cone contains `[−30°, 30°]`.
- **Kind T, parallel** (`A⁻ = [60° − ℓ, 60°]` at `u⁻` with inner `a`, `B⁺ = [−60°, −60° + m]` at `v⁺` with inner `a′`): `t_a ⊂ [30° + m, 150° − ℓ]`,
  `t_{a′} ⊂ [210° + m, 330° − ℓ]`, `t_back` contains `[150° − ℓ, 210° + m]` and `t_front` contains `[−30° − ℓ, 30° + m]`.

The strip's `P₀` (crossed, `ℓ = m = 15.52°`) has its edges at `0°, 90°, 180°, 270°`, inside the four windows; the bowtie's centre (parallel, `ℓ = m = 60°`)
meets its windows with equality (`t3 = [120°, 240°]` against `[ψ + 30°, ψ + 150°]` at `ψ = 90°`) — control `fs116-n3-semi`.

### 2.4 The argument of FS116-N3-SEMI

Suppose `y` has three colours and no more; non-Siamese and simple, it has three tiles, one cone each, and consecutive tiles at `y` share an edge (near a vertex of
a locally finite segment-and-arc map the tiles are the sectors between consecutive edges). `R`'s cone contains `90°` (the ring germ counter-clockwise of `y`
approaches along `90°`) and `R′`'s contains `270°`.

**Kind O** (`u⁻`, `v⁺` off (Q): `R ⊂ B̄(u, 1)`, cone in `[30°, 210°]`; `R′ ⊂ B̄(v, 1)`, cone in `[150°, 330°]`). RING-GERM (ii) fills `(−30°, 30°)` with outer
tiles; three colours leave one, `C`, of colour `c`, and no tip (a tip would carry `c` and be a second tile of colour `c`). Counter-clockwise the tiles are
`C = [γ₁, γ₂]`, `R = [γ₂, ρ]`, `R′ = [ρ, γ₁ + 360°]`.
- (O1) `v⁻` off (Q): `R ⊂ [−30°, 150°]` gives `ρ ≤ 150°`, `R′` gives `ρ ≥ 150°`: the edge `R | R′` leaves `y` at `150°`, and with `R ∩ B(v, 1) = ∅`, `R′ ⊂ B̄(v, 1)`
  it is an arc of `ω(v)` (c); `v` carries `X` (`R_v`) and `X̄` (`R′`): of kind both, and `v` has four colours.
- (O2) `u⁺` off (Q): `ρ = 210°`, the edge `R | R′` an arc of `ω(u)` (`R ⊂ B̄(u, 1)`, `R′ ∩ B(u, 1) = ∅`), `u` carrying `X` and `X̄`: `u` has four colours.
- (O3) full, `A` at `u⁺` with colours `{a, a′}`, `B` at `v⁻` with `{b, b′}`. If `c ∈ {a, a′}`, (b) bars `c` from `(30°, 210°)`, so `γ₂ ≤ 30°`, and `R` gives `γ₂ ≥ 30°`:
  the edge `C | R` leaves at `30°`. `C ∩ B(u, 1) = ∅`, because `c` is carried at `u` by a side tile `T_c` of `A` other than `C`: the inner one is a tile of `p` and `C`
  is not; the outer one, `O_A`, has `150°` in its cone at `u` (it lies beside `A`, which leaves `u` along `150°`), while `C ∋ y` would put `O_A ⊂ B̄(y, 1)` and its
  cone at `u` in `[−150°, 30°]`. So the edge is an arc of `ω(u)` (c), with `X` and `c` both at `u`: `u` has four colours. If `c ∈ {b, b′}`: `γ₁ = −30°`, the edge
  `R′ | C` an arc of `ω(v)`, `v` four colours. Otherwise `c` lies in neither pair, so the pairs are not disjoint — the semi-hub is parallel — and `c` is a colour of
  `t_front` or `t_back` (§ 2.3); the tile of `p` of an outer colour has its cone in `[90°, 270°]` (d), which `t_front`'s `[−30°, 30°]` is not: **`c` is the colour
  of `t_back`, whose cone holds `180°` in its interior** — the third alternative.

**Kind T** (`v⁻`, `u⁺` off (Q): `R ∩ B(v, 1) = ∅`, cone in `[−30°, 150°]`; `R′ ∩ B(u, 1) = ∅`, cone in `[210°, 390°]`). RING-GERM (i) fills `(150°, 210°)` with tips;
three colours leave one tip `τ` of colour `t` and no outer tile; counter-clockwise `R = [δ, ρ₁]`, `τ = [ρ₁, ρ₂]`, `R′ = [ρ₂, δ + 360°]`, `δ ∈ [−30°, 30°]`.
- (T1) `u⁻` off (Q): `R ⊂ [30°, 210°]` gives `δ = 30°`; the edge `R′ | R` is an arc of `ω(u)` (`R ⊂ B̄(u, 1)`, `R′ ∩ B(u, 1) = ∅`), `u` carrying `X` and `X̄`.
- (T2) `v⁺` off (Q): `δ = −30°`; the edge an arc of `ω(v)`, `v` carrying `X` and `X̄`.
- (T3) full, `A⁻` at `u⁻` with `{a, a′}`, `B⁺` at `v⁺` with `{b, b′}`. If `t ∈ {a, a′}`, (b) bars `t` from `(−150°, 30°)`, so `ρ₂ = 210°`. The tile of `A⁻`'s colour `t`
  at `u` is `τ` when `t` is the inner colour (inner tiles are tiles of `p`, one per colour); were `t` the outer colour, `τ` would be another `t`-tile than the outer
  tile at `u`, so `τ ∩ B(u, 1) = ∅` and its cone at `y` would lie in `[−150°, 30°]`, against `τ ⊇ (150°, 210°)`. So `τ ⊂ B̄(u, 1)`, `R′ ∩ B(u, 1) = ∅`, and the edge
  `τ | R′` at `210°` is an arc of `ω(u)` with `t` and `X̄` both at `u`. If `t ∈ {b, b′}`: `ρ₁ = 150°`, the edge `R | τ` an arc of `ω(v)`. Otherwise the semi-hub is
  parallel and `t` is the colour of `t_front` or `t_back`; a tip's tile has its cone at `p` in `[−90°, 90°]` (d), which `t_back`'s `[150° − ℓ, 210° + m]` is not:
  **`t` is the colour of `t_front`, whose cone holds `0° = ψ` in its interior**. ∎

*Uses:* RING-GERM (two minds) for (a) and the forced tips and outer tiles; FS116-N1-GERM-R (one mind) for (b); FS116-N2-STAR (one mind) for (d);
FS114-N7-QOPP (one mind) for § 2.3; FS112-N3-NOBOTH (two minds); PAIR; non-Siamese and simple (one tile per colour, one cone per tile). Six colours are spent
at RING-GERM's Step 1 and at `C(y) = A(p) ⊔ T_y ⊔ O_y`. *Reads:* `B̄(p, 1 + ε)`.

### 2.5 The entries

derivation: FS116-N3-CONE
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, at a change point
    y = r(ψ) of the ring: u⁻ off (Q) arcs gives R ⊂ B̄(r(ψ + 60°), 1); v⁻ off them gives R ∩ B(r(ψ − 60°), 1) = ∅; v⁺ off them gives R′ ⊂ B̄(r(ψ − 60°), 1);
    u⁺ off them gives R′ ∩ B(r(ψ + 60°), 1) = ∅; a germ on a (Q) arc bars both colours of that arc from an open half-circle of directions at y — (ψ + 30°,
    ψ + 210°) for u⁺, (ψ + 150°, ψ + 330°) for v⁻, (ψ − 150°, ψ + 30°) for u⁻, (ψ − 30°, ψ + 150°) for v⁺; and an edge at y between a tile inside B̄(w, 1) and a
    tile outside B(w, 1) is an arc of ω(w), whose centre w, if it carries both side colours, is a vertex of at least four colours
  uses only: RING-GERM's Steps 1 and 2 (two minds); FS116-N1-GERM-R (one mind); FS112-N3-NOBOTH with FS112-U1 (two minds each), local at the centre;
    non-Siamese (distinct tiles of one colour at distance at least 1; no repeated colour at a point); that a tile has diameter at most 1
  not claimed: anything about a germ on a non-(Q) arc of Γ beyond RING-GERM's Step 1; the Siamese or non-simple class; anything at k ≥ 7
  argument: § 2.1 The cone lemmas at the unit rhombus `p, u, y, v` (FS116-N3-CONE)
  verdict: derived
  grade: hand
  minds: 1
  model: the strip's P₀ at its change point P₂: R = U₁ holds u = V₁ (u⁻ off), R′ = D₁ holds v = V′₁ (v⁺ off), and B (inner of the arc at v⁻) is held at
    P₂ only by U₂, along [0°, 90°] ⊂ [ψ − 30°, ψ + 150°] — `data/fs116/n3/semi.out`
  prior art: partly: RING-GERM, FS116-N1-GERM-R and FS112-U1 hold each clause; FS114-N7-OCTB uses the edge clause at the bowtie's top ("the edge R_0 | W at
    top is an arc of ω(q1)"); their assembly at the rhombus not found — FS-116's gate (`plans/FS116-local-exclusion.md` § 2.3, 12 queries)
  handoff: de Bruijn — with RING-GERM and NOBOTH, queued behind D6's map type: the six half-planes at y and the edge clause

derivation: FS116-N3-PAIR
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one pair at
    a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer colour of the other
  uses only: that the inner tile of a (Q) arc is the tile of p of its colour and holds the arc; that a germ's arc holds the germ's ring point (u or v) in its
    closure; |u − v| = √3; non-Siamese; diameter at most 1
  not claimed: anything about two (Q) arcs that are not at the germs of one pair; that a full parallel semi-hub occurs at six colours beyond FS114-Y2-BOWTIE
  argument: § 2.2 The argument of FS116-N3-PAIR
  verdict: derived
  grade: hand
  minds: 1
  model: FS114-Y2-BOWTIE's centre at top and at bot: the arcs at u⁺ and v⁻ are 3 | 1 and 1 | 3 (control fs116-n3-pair)
  prior art: partly: FS114-N7-QOPP's inner-tile clause; this pairing not found — FS-116's gate (12 queries)
  handoff: de Bruijn — with FS114-N7-QOPP, queued behind D6's map type

derivation: FS116-N3-STAR2
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a full
    semi-hub of kind O with (Q) arcs A = [ψ + 60°, ψ + 60° + ℓ] of inner colour a and outer a′ and B = [ψ − 60° − m, ψ − 60°]; if B's colours b (inner) and b′
    (outer) are disjoint from a, a′, then ℓ + m ≤ 60° and the tiles of p are, counter-clockwise, t_b, t_a, t_b′, t_a′ with edges t_b|t_a in [ψ + ℓ − 30°,
    ψ + 30° − m], t_a|t_b′ in [ψ + 30°, ψ + 150°], t_b′|t_a′ in [ψ + 150° + ℓ, ψ + 210° − m] and t_a′|t_b in [ψ + 210°, ψ + 330°]; if B's colours are a′ (inner)
    and a (outer), then t_a ⊂ [ψ + 30°, ψ + 150°], t_a′ ⊂ [ψ + 210°, ψ + 330°], and the other two tiles' cones contain [ψ − 30°, ψ + 30°] and [ψ + 150°, ψ + 210°]
  uses only: FS114-N7-QOPP's windows (one mind; re-derived in the stage's preamble from N-E1 and non-Siamese at the unit pairs (p, r(θ))); FS116-N3-PAIR;
    that p has four tiles in cyclic order (non-Siamese, simple, four colours); that A starts at u and B ends at v (u⁻, v⁺ off (Q) arcs); 0 < ℓ, m ≤ 60°
  not claimed: the windows of a crossed semi-hub of kind T (computed in § 2.3's spirit but not entered); that any star in the windows is realised
  argument: § 2.3 The pinned stars of a full semi-hub (FS116-N3-STAR2)
  verdict: derived
  grade: derived from: FS116-N3-PAIR
  minds: 1
  model: the strip's P₀ (crossed: edges at 0°, 90°, 180°, 270°, ℓ = m = 15.52°) and FS114-Y2-BOWTIE's centre (parallel: t3 = [120°, 240°], t1 = [300°, 60°]
    at ψ = 90°, the windows met with equality) — control fs116-n3-semi
  prior art: partly: FS114-N7-QOPP and N7-FLANK's windows; the two stars not found — FS-116's gate (12 queries)
  handoff: de Bruijn — with FS114-N7-QOPP

derivation: FS116-N3-SEMI
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a semi-hub
    of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit
    circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours, or y
    is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone holds ψ + 180° (kind O) or ψ (kind T)
    in its interior
  uses only: FS116-N3-CONE; FS116-N3-STAR2 and its kind-T parallel line (§ 2.3); FS116-N3-PAIR; RING-GERM (i), (ii) (two minds); FS116-N2-STAR's windows
    (one mind); non-Siamese and simple (three colours give three tiles, consecutive tiles share an edge); six colours, at RING-GERM's Step 1 and in C(y) =
    A(p) ⊔ T_y ⊔ O_y
  not claimed: that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the disk's
    corner, FS116-N1-QDISK); Siamese or non-simple fragments; anything at k ≥ 7
  argument: § 2.4 The argument of FS116-N3-SEMI
  verdict: derived
  grade: derived from: FS116-N3-CONE, FS116-N3-STAR2, FS116-N3-PAIR
  minds: 1
  model: the strip's P₀ at P₂ and P₋₂ and P₁ at its two change points (crossed full semi-hubs of kind O, four colours) and FS114-Y2-BOWTIE's centre at top
    and bot (parallel full semi-hubs of kind O, four colours) — the first alternative, `data/fs116/n3/semi.out`; no held fragment has a three-colour semi-hub
  prior art: partly: the alternatives' ingredients are FS-112's (NOBOTH) and FS-116's (RING-GERM); a placing rule at change points with a germ pair on (Q)
    arcs not found — FS-116's gate (12 queries); a search in the map-colouring vocabulary is owed
  handoff: de Bruijn — with RING-GERM, NOBOTH and STAR, after a blind second mind; a relay-result for D2 (every semi-hub but the parallel three-colour one
    places a vertex of at least four colours on ω(p))

control: fs116-n3-semi
  of: FS116-N3-SEMI — with FS116-N3-STAR2 and FS116-N3-CROSS, on the held change points (the strip's P₀, P₁; the bowtie's centre; the disk's corner, closed and silent); every (Q)
    arc read with inner and outer swapped is caught
  run: python3 ../tools/fs116_n3_semi.py | tail -n 1
  expect: SEMI ALL OK
  fault: python3 ../tools/fs116_n3_semi.py --plant | tail -n 1

control: fs116-n3-pair
  of: FS116-N3-PAIR on the bowtie's parallel full semi-hubs; the arcs at u read with inner and outer swapped (so the two inner colours agree) is caught
  run: python3 ../tools/fs116_n3_semi.py | grep -c 'inner colours [0-9], [0-9] — differ' || true
  expect: 2
  fault: python3 ../tools/fs116_n3_semi.py --plantpair | grep -c 'inner colours [0-9], [0-9] — differ' || true

### 2.6 Controls, and `k = 7`

`tools/fs116_n3_semi.py` (floats reading the exact objects, through FS116-N1's ring tool, imported unedited; a ray parity read along two rays, after a
first reading showed a phantom sliver of colour 1 at `187.07°` about the bowtie's centre, where the tool's single ray passes through `p` — the tool's own
defect, fixed before any line was believed) classifies every change point of the held rings and checks the predictions (`data/fs116/n3/semi.out`, last line
`SEMI ALL OK`): **the strip's `P₀` and `P₁`**: all four change points crossed full semi-hubs of kind O, four colours, tips none, outer colours `{a′, b′}`,
missing pair `{a, b}`, star in STAR2's crossed windows; **the bowtie's centre**: both change points parallel full semi-hubs of kind O, inner colours swapped
(PAIR), four colours (tip `t_front`, outer `t_back`), star in the parallel windows; **the disk's corner**: both change points closed (no pair off (Q) arcs),
SEMI silent. Plants: every (Q) arc read inner↔outer (`--plant`) gives 16 violations (CROSS's outer colours, missing pair and windows, RECIP); the arcs at `u`
only (`--plantpair`) makes the bowtie's inner colours agree (PAIR fires twice).

| entry | the strip (`P₀`, `P₁`) | the disk (corner `A₀`) | `k = 7` |
|---|---|---|---|
| CONE | met at every change point (the arcs' colours barred where (b) says) | closed change points: (a) silent, (b) met (every germ on a (Q) arc) | (a) spends six at RING-GERM's Step 1 (a germ off (Q) arcs carries `X` or `X̄` only when two colours are absent); (b), (c) hold at every `k` (N-E1, NOBOTH) |
| PAIR | silent (crossed) | silent (no pair) | holds at every `k` (diameter only) |
| STAR2 | crossed windows met (edges at the windows' interiors) | silent | holds at every `k` with four colours at `p` (QOPP is N-E1) |
| SEMI | first alternative (four colours) | silent: closed change points — the gap SEMI leaves to RING-Q | spent at RING-GERM's Step 1 and at `C(y) = A(p) ⊔ T_y ⊔ O_y`; R7's lattice points have no change point: vacuous |

**G87 lookout, stage 2:** none seen. Classed: the bowtie's (Q) arcs are `60°` long and its star meets STAR2's parallel windows with equality — consistent
(the windows' bounds are attained exactly when `ℓ = m = 60°`), not a collision.

## Stage 2 — SAVED

## Stage 3 — SAVED: the strip's type (CROSS), the residue, and the verdict

*Setting S as stage 2, the disc now of radius above 2 about `p` wherever `y`'s own ring is read (it must lie in a closed disc of radius above 1 about `y`).*

### 3.1 The argument of FS116-N3-CROSS

`y = r(0°)` a crossed full semi-hub of kind O: `A = [60°, 60° + ℓ]` at `u⁺` (inner `a`, outer `a′`), `B = [−60° − m, −60°]` at `v⁻` (inner `b`, outer `b′`); `p`'s
star is STAR2's crossed one, `t_b, t_a, t_{b′}, t_{a′}` with edges `e₁ … e₄` in their windows.

1. **No tip of positive angle.** A tip's tile has its cone at `p` in `[−90°, 90°]` (CONE (d)); `t_{b′}` holds `[150°, 150° + ℓ]` and `t_{a′}` holds `[210° − m, 210°]`,
   so neither is a tip. `t_a` holds `u` (it is `A`'s inner tile and `A` starts at `u`), so `t_a ⊂ B̄(u, 1)` and its cone at `y` lies in `[30°, 210°]`; CONE (b) bars `a`
   from `(30°, 210°)`, and a tip's cone at `y` lies in `[90°, 270°]`: what is left is the single direction `210°`. `t_b` holds `v`, so its cone at `y` lies in `[150°, 330°]`,
   `b` is barred from `(150°, 330°)`, and what is left is `150°`. Every tip has a cone of zero angle.
2. **Outer colours.** The tile of `p` of an outer colour has its cone in `[90°, 270°]` (CONE (d)); `t_a` holds `[30° − m, 30°]` and `t_b` holds `[330°, 330° + ℓ]`, so
   neither colour is outer: `O_y ⊆ {a′, b′}`.
3. **Four colours.** With every cone at `y` of positive angle, `T_y = ∅` (1); `C(y) = {X, X̄} ⊔ O_y` has four colours only if `O_y = {a′, b′}`, and then
   `A(y) = P ∖ O_y = {a, b}` (CONE (d)).
4. **`p` is a change point of `y`'s ring.** `t_{b′}` and `t_{a′}` are now outer colours' tiles of `p`, so their cones lie in `[90°, 270°]`: `e₂ ≥ 90°` and `e₄ ≤ 270°`, while
   `e₁ ≤ 30° − m < 90°`. The circle `ω(y)` leaves `p` along `90°` and `270°`, bending toward `y`, i.e. into directions just below `90°` and just above `270°`: inside
   `t_a` and `t_b` — unless `e₂ = 90°` (or `e₄ = 270°`) with that edge bending at least as fast as `ω(y)`; bending faster would put `ω(y)`'s branch inside `t_{b′}`
   (`t_{a′}`), whose colour is at `y` (N-E1), so the exception is an edge of `p` along `ω(y)`, excluded by hypothesis. So `p`'s two germs on `ω(y)` lie off `Γ`, in `t_b`
   (counter-clockwise of `p` about `y`, the branch along `270°`) and `t_a` (clockwise): two colours, `b` and `a`, the two missing at `y`. `p` is a change point.
5. **`p` is a semi-hub of kind O of `y`'s ring.** On `ω(y)` the points at `60°` from `p` are `v` (`p + 60°` about `y`) and `u` (`p − 60°`); `y`'s outer pair at `p` is the
   germ of `ω(y)` leaving `v` along `150°` and the one leaving `u` along `210°`, both into `B(p, 1)`; its tip pair the germs leaving `u` along `30°` and `v` along `330°`.
   *The outer pair lies on no (Q) arc of `y`'s ring:* such an arc's two side tiles have points in `B(p, 1)` near `v` (near `u`) and colours of `y`. A tile of a colour
   of `P` with points in `B(p, 1)` is a tile of `p`; the tiles of `p` of `y`'s colours `a′`, `b′` do not reach `v` (it would need `t_{a′}` or `t_{b′}` inside
   `[210°, 390°]` at `p`, against `[210° − m, 210°]` and `[150°, 150° + ℓ]`) nor `u` (inside `[−30°, 150°]`, against the same). So the sides are `X` and `X̄` (no seam: a
   non-Siamese simple fragment has none), and FS114-N7-QOPP at `y` makes a (Q) arc of `y`'s ring join opposite tiles of `y`, while `R` and `R′` are adjacent there (the
   directions `(90°, 270°)` at `y` lie in `R ∪ R′`, no tip having positive angle). *The tip pair does not:* by RING-GERM (i) at `y`'s change point `p`, both germs off
   (Q) arcs would give a tile of `y` whose closure holds `p`; but `R`, `R′` carry colours absent at `p`, and the outer tiles of `a′`, `b′` at `y` are not the tiles of
   `p` of those colours, so neither holds `p` (non-Siamese). So `p` is a semi-hub of kind O of `y`'s ring. ∎

*Uses:* STAR2 (crossed), CONE (b), (d), RING-GERM (i) at `y` (two minds), FS114-N7-QOPP at `y` (one mind), N-E1, non-Siamese and simple. *Reads:*
`B̄(p, 1 + ε) ∪ B̄(y, 1 + ε)`.

**What it does.** Read with `y`'s ring as input, CROSS is the strip's mechanism: the type "both change points crossed full semi-hubs of kind O, four colours"
places at each change point a four-colour vertex for which `p` is again a semi-hub of kind O, its missing pair the two inner colours. Whether `p` is a *crossed*
full semi-hub of `y` is not derived: it needs `y`'s germs leaving `u` along `30°` and `v` along `330°` to lie on the arcs `R | O_A` and `R′ | O_B` of `ω(y)` (as on the
strip: `data/fs116/n3/semi.out`, "p is of kind O full crossed for y"), and the order of the two outer tiles at `y` is not pinned by the cones (with them swapped,
the edges `C_{a′} | R` and `R′ | C_{b′}` would run along `ω(u)` and `ω(v)`).

### 3.2 The residue: a parallel full semi-hub of three colours (SEMI-PAR3)

SEMI's third alternative is the one configuration the cone calculus leaves. Its forced shape, kind O (the bowtie's kind): the (Q) arcs at `u⁺` and `v⁻` join the
tiles of `p` above and below `y` (`t_a ⊂ [30°, 150°]`, `t_{a′} ⊂ [210°, 330°]`), with their inner colours swapped; `y` carries `X`, `X̄` and the colour of `t_back`
(the tile of `p` away from `y`), its outer tile `C` holding `(−30°, 30°)`; the tile `t_front` of `p` toward `y` (its cone contains `[−30°, 30°]`) does not reach `y`; `R`
and `R′` meet along an edge leaving `y` into `B(p, 1)` at a direction in `[150°, 210°]`; and `y` has three colours absent — `a`, `a′` and `t_front`'s — on the whole of
`ω(y)` off `Γ`, so no parity constrains `y`'s ring (the room `k = 7` has at a four-colour vertex). Kind T: the tile toward `y` reaches it as its only tip, no outer tile,
and `R | R′` leaves `y` outward at a direction in `[−30°, 30°]`. **The bowtie realises the four-colour branch of this configuration** (tip `t_front = t2`, outer
colour `t_back`'s, 4), so the step from it to three colours is removing the tip; nothing derived here excludes that.

derivation: SEMI-PAR3
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, no change point of the ring
    is a full parallel semi-hub of exactly three colours
  argument: § 3.2 The residue: a parallel full semi-hub of three colours (SEMI-PAR3)
  verdict: gap: the step from the bowtie's four-colour parallel semi-hub to three colours — removing the tile of p toward y from y (kind O), or the outer tile
    (kind T) — is excluded by no cone at p, u, y or v; a proof must read y's own ring, which carries three absent colours and no parity

### 3.3 The verdict on RING-TRANSFER-Q

**RING-TRANSFER-Q is GAP** — at three named places, each now smaller than round 3's "a placing rule at semi-hubs":
1. **the parallel full semi-hub of three colours** (SEMI-PAR3), the one semi-hub at which no vertex of at least four colours is placed on `ω(p)`;
2. **closed change points** (both germ pairs touching (Q) arcs) — RING-Q's gap, the disk's corner (FS116-N1-QDISK: two colours), outside any semi-hub rule;
3. **recurrence beyond kind O**: a crossed four-colour semi-hub reciprocates as a semi-hub of kind O (CROSS), and as a crossed one on the strip, but whether it must
   is the order of `y`'s outer tiles, not pinned here; and, as at hubs (FS116-N2 § 2.3), nothing at `p` reads the 240° of `y`'s ring outside `B̄(p, 1)`.

Everywhere else the rule is derived, in round 3's corrected form (input: `p`'s ring with its (Q) arcs' colours and `p`'s star; output: what is placed, its colours,
its missing pair and its ring at `p`):

derivation: RING-TRANSFER-QC
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of four colours: at a semi-hub y = r(ψ) of p's ring a
    vertex of at least four colours lies at y, at r(ψ + 60°) or at r(ψ − 60°), unless y is a full parallel semi-hub of three colours, which are then the two
    absent at p and the colour of the tile of p holding ψ + 180° (kind O) or ψ (kind T) in its cone's interior; when the (Q) arcs at a semi-hub's other pair join
    the same two opposite tiles of p their inner colours are swapped; at a full semi-hub of kind O the four edges of p lie in FS116-N3-STAR2's windows; and at a crossed full semi-hub of kind O whose
    (Q) arcs have inner colours a, b and outer a′, b′, every tip has a cone of zero angle and the outer colours lie in {a′, b′}, and if y has four colours with
    cones of positive angle its missing pair is {a, b} and p — unless an edge of p runs along ω(y) — is a change point of y's ring, b counter-clockwise and a
    clockwise of it, and a semi-hub of kind O of that ring
  uses only: FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-N3-SEMI, FS116-N3-CROSS, and through them RING-GERM and FS112-N3-NOBOTH (two minds each),
    FS116-N1-GERM-R, FS116-N2-STAR and FS114-N7-QOPP (one mind each)
  not claimed: anything at a closed change point; that the parallel three-colour semi-hub is excluded or occurs (SEMI-PAR3, GAP); that p is a crossed
    semi-hub of y's ring; anything about y's ring outside B̄(p, 1); that the rule is the same at k = 7 (RING-GERM's Step 1 and C(y) = A(p) ⊔ T_y ⊔ O_y spend six)
  argument: § 3.3 The verdict on RING-TRANSFER-Q
  verdict: derived
  grade: derived from: FS116-N3-SEMI, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-STAR2
  minds: 1
  model: the strip's P₀ and P₁ (four crossed full semi-hubs of kind O, four colours, missing pairs the inner colours, each reciprocated as a crossed semi-hub of
    kind O) and FS114-Y2-BOWTIE's centre (two parallel ones, four colours) — control fs116-n3-semi
  prior art: partly: FS116-N2's RING-TRANSFER-C at hubs; at semi-hubs not found — FS-116's gate (12 queries); a search in the map-colouring vocabulary is owed
  handoff: de Bruijn — deferred with D6's map type, after a blind second mind on SEMI, PAIR, STAR2 and CROSS

derivation: RING-TRANSFER-Q
  statement: for each ring type with a (Q) arc at a vertex of four colours, the ring types of the vertices of at least four colours it places at distance 1
    are determined by a finite rule, and the types that recur at every vertex they place are named
  argument: § 3.3 The verdict on RING-TRANSFER-Q
  verdict: gap: three places — a full parallel semi-hub of three colours (SEMI-PAR3), a closed change point (RING-Q's gap at the disk's corner), and whether a
    crossed semi-hub's placed vertex has p as a crossed semi-hub (the order of its outer tiles); the rule is derived elsewhere as RING-TRANSFER-QC, its input the
    ring with its (Q) arcs' colours and p's star, as round 3 corrected

derivation: FS116-N3-CROSS
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a crossed
    full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer colour b′; then
    every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every tile at y a cone of positive
    angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y) at p, p is a change point of the ring of
    y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of the ring of y
  uses only: FS116-N3-STAR2 (crossed); FS116-N3-CONE (b), (d); RING-GERM (i) at y (two minds); FS114-N7-QOPP at y (one mind); N-E1; non-Siamese and simple
  not claimed: that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at k ≥ 7
  argument: § 3.1 The argument of FS116-N3-CROSS
  verdict: derived
  grade: derived from: FS116-N3-STAR2, FS116-N3-CONE
  minds: 1
  model: the strip's P₀ at P₂ (a = P, a′ = O, b = M, b′ = B; O_y = {B, O}, A(y) = {M, P}; P₂'s ring is M just counter-clockwise of P₀ and P just clockwise, and P₀
    is a crossed full semi-hub of kind O of it) and P₁ at P₃ — control fs116-n3-semi
  prior art: partly: FS116-N2-RECIP is its hub form (through FS116-N1-TOUCH); at a semi-hub not found — FS-116's gate (12 queries)
  handoff: de Bruijn — with STAR2 and RING-GERM

### 3.4 What it does to D2, and `k = 7`

Following four-colour vertices outward from `p` along its ring now goes through every hub (RING-GERM (iii)) and every semi-hub but SEMI-PAR3's (SEMI), the
vertex landing at `y` or at `y ± 60°`; it stops at closed change points (the disk's corner) and at SEMI-PAR3. On the strip's type it reciprocates (CROSS), and on
the strip itself it runs the midline. N2's advice for D2 ("a four-colour vertex whose ring carries an arc of `Γ`, at distance 1 from a `Γ`-free one, with its
semi-hubs") now has its rule at semi-hubs; **D2's next objects are SEMI-PAR3 and the closed change point**, the two places the rule is silent, and the
construction side's matching target is a parallel full semi-hub of three colours (the bowtie with its tip at `top` removed), by formula, or a reason it cannot exist.

| entry | the strip (`P₀`, `P₁`) | the disk (corner `A₀`) | `k = 7` |
|---|---|---|---|
| CROSS | met at all four change points, reciprocity included (`P₀` is a crossed semi-hub of kind O of `P₂`'s ring, `P₁` of `P₃`'s) | silent: closed change points | spends six at "`C(y) = {X, X̄} ⊔ O_y`" and at RING-GERM at `y`; R7: no change point |
| SEMI-PAR3 | silent (crossed) | silent | three absent colours at a four-colour `p` — the configuration's own room |
| RING-TRANSFER-QC | the model | silent (closed) | not claimed: every step spends six |

**G87 lookout, stage 3:** none seen as two truths in collision. Classed: CROSS's reciprocity holds as "crossed" on the strip while the cones leave the outer tiles'
order at `y` free — a statement not yet decided, not two truths.

## Stage 3 — SAVED
