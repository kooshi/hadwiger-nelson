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

## Would-have-searched-here log (standing rule 5)

- The ban's end date (2026-10-01) has passed and `CLAUDE.md` § Toolchain has not been rewritten; the list's § 9 forbids enumerating ring types "by any
  program" in any case, so the log is kept. Stage 1: none (reading and recognition).

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
