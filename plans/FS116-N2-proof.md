# FS116-N2 — FS-116's proof side, round 3: the ring's transfer rule (RING-TRANSFER)

*Ephodos (Opus 5.5), job FS116-N2, launched 2026-09-29 07:08 UTC at HEAD `38b27e6d`. Brief `data/fs116/briefs/FS116-N2-transfer.md`, with
`plans/STANDING-RULES.md` as part of it. Identity and procedure: `.claude/agents/ephodos.md` § A derivation job. Frozen claims: `data/fs116/claims.md`
(§ 0's definitions verbatim; "valid fragment" is six-coloured unless `k` is named). I touch only this record, `data/fs116/n2/`, `tools/fs116_n2_*.py`
and `data/fs116/reports/FS116-N2.md`. Resuming check: no record existed at start. Grades are my identity's grammar; the edge translation is
`.claude/agents/ephodos.md` § Two vocabularies (`hand` = [hand], `derived from` = [derived], `computed over` = [tools]).*

**Notation** (FS116-N1's header, `plans/FS116-N1-proof.md`, and FS-114's; nothing new is meant by it but the words marked *new*). `p` a vertex, `ω(z)`
the unit circle about `z`, `e(θ)` the unit vector at angle `θ`, `r(θ) = p + e(θ)`; `C(z)` the colours of the tiles whose closure holds `z`, `P = P(p) =
C(p)`, `A(z)` the colours absent at `z` (six colours in all). **N-E1**: an interior point of a tile of colour `c` is at distance 1 from no point of the
closure of a tile of colour `c`. **Non-Siamese**: distinct tiles of one colour have all cross-distances at least 1; so at a point there is at most one
tile of each colour. **Simple**: § 0's; a tile's cone at a vertex is then one interval, and a non-Siamese simple vertex of `m` colours has degree `m`. A
tile has diameter at most 1, so a tile of `p` lies in `B̄(p, 1)`. A **tip** at a ring point `y` is a tile of `p` whose closure holds `y`; an **outer
tile** at `y` is a tile of a colour of `p` that is not a tile of `p`. *New:* a **hub** of `p` is a change point `y` of `p`'s ring whose four germs
`u⁻, u⁺, v⁻, v⁺` at `y ± 60°` lie on no (Q) arc — by RING-GERM (iii) a vertex of at least four colours; for a hub `y = r(ψ)` the **flanking directions**
are `ψ ± 90°` at `p`; the **D-directions** of a hexagon of change points `y_k = r(ψ_0 + 60°k)` are `D_m = ψ_0 + 30° + 60°m` (FS114-N7's), so that
`y_k` is flanked by `D_{k+1}` and `D_{k−2}`; `F_k = A(y_k)`.

## Theorems this phase proved

- **FS116-N2-QT** — the brief's quotation is verbatim in `data/fs116/claims.md` — computed over the one blockquote (`tools/fs116_n2_quotes.py`), § 1.1.
- **FS116-N2-SIXRING** — at a six-colour vertex the ring is six consecutive closed 60° (Q) arcs, one per tile of `p`, each tile inside the Reuleaux
  triangle on its arc, and every outer colour along the arc of `t_i` is that of `t_{i+2}`, `t_{i+3}` or `t_{i+4}`; no change point — [derived], one mind, § 2.1.
- **FS116-N2-FIVERING** — at a five-colour vertex the ring has no change point and its (Q) arcs meet every pair `θ, θ + 60°` — [hand], one mind, § 2.1.
- **FS116-N2-STAR** — the colours at a change point of a four-colour ring split into `p`'s absent pair, tips and outer colours; the missing colours of
  the placed vertex are read off `p`'s tiles in the flanking directions — [derived], one mind, § 2.2.
- **FS116-N2-RECIP** — a four-colour hub `y` whose ring meets no (Q) arc at `p ± 60°` and no arc of `Γ` at `p` has `p` as a change point of its own
  ring — [derived], one mind, § 2.2.
- **FS116-N2-ANTI** — antipodal hubs with flanking directions inside tiles share their missing pair and swap tip and outer colour — [derived], one mind, § 2.2.
- **FS116-N2-HEX6** — the `Γ`-free ring type recurs at no four consecutive hubs of its six (in particular not at all six) — [derived], one mind, § 3.1.
- **FS116-N2-HEX3** — with every hub of four colours, the `Γ`-free type recurs at most at three consecutive hubs, and at two alternate ones only with
  `p`'s four edges at four named D-directions — [derived], one mind, § 3.1.
- **RING-TRANSFER** — MISSTATED; the corrected statement RING-TRANSFER-C is [derived], one mind, § 3.3; recurrence of types with (Q) arcs GAP (§ 3.2).

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).
- Stages 2–3: would have searched assignments of missing pairs to the six hubs (and of edges to the D-directions) for the ones that survive; instead the
  complement relations were derived by hand in the Kneser link `KG(4, 2)` (§ 3.1). Would have searched held and new fragments for a hub; instead read the
  held rings' change points (`tools/fs116_n2_star.py`), where none is a hub.

## Fence log (standing rule 8)

- No path is fenced for this job. The start-up context held the auto-memory index (status lines, no proof content). I read no session transcript. I
  write about my work only here, in `data/fs116/n2/`, in `tools/fs116_n2_*.py` and in my report. Read beyond the brief's list, at the coordinator's
  pointer (message, 2026-09-29, received during stage 1): `plans/FS116-Y2-construction.md` header and theorem table (FS116-Y2-SIXFRAG, -SIXOFF, -DCREAD).

## G87 lookout

- Stage 1: none seen as two truths in collision. One scope classed: the plan's § 3.3 ("its **transfer rule** is what a ring of one type forces on the
  four-colour vertices it places") against the recognition below (what is placed is read off `p`'s star, which the ring type does not record) — a
  statement's input too small, not two held truths.
- Stages 2–3: none seen. Classed: the strip's antipodal change points `P_{±2}` miss different pairs (`{M, P}`, `{B, O}`) while FS116-N2-ANTI makes antipodal
  hubs share theirs — the strip's flanking directions are edge directions, outside ANTI's hypothesis; a scope, not two truths.

## Stage 1 — SAVED: the readback, and recognition on the claim

### 1.1 Readback of the brief

`tools/fs116_n2_quotes.py` extracts the brief's one blockquote and searches it, whitespace collapsed, in the source its `— source:` line names:
**FOUND 1 of 1** (RING-TRANSFER, `data/fs116/claims.md` § 5); the plant (`--alter`, "finite rule" → "finite law") is NOT FOUND. By hand: the brief's
held inputs are where it says — RING-GERM, RING-TWIST-C, FS116-N1-TWIST-LIT in § 10 (two minds, `plans/FS116-V2-verification.md` § 4.5); FS116-O1-SATPIN
in § 3 (its corrected wording, V1 § 4.2, per N1 stage 4); N7-HUB (b), (c) in `plans/FS114-N7-proof.md` § 2.1; the one-mind inputs in
`plans/FS116-N1-proof.md` §§ 3–4; FS121-D3 § 1.2 ("each change of colour across an interface is a swap with a unit neighbour") and § 2.3
(FS121-D3-SWAP1D). **One pointer to note, not a mismatch:** the brief lists "N7-HUB (b), (c)" among the inputs "at two minds"; FS114-N7-3T, whose entry
carries N7-HUB, is filed at `minds: 1` (`plans/FS114-derivation.md` § 3) and its blind check was FS116-V1's first item — I use N7-HUB only through
RING-GERM (two minds), whose (i)–(iii) are its mechanism, so nothing here rests on the count.

derivation: FS116-N2-QT
  statement: the blockquote of `data/fs116/briefs/FS116-N2-transfer.md` occurs verbatim, whitespace collapsed, in `data/fs116/claims.md`
  uses only: the brief's blockquote and its `— source:` line; whitespace normalisation only
  not claimed: that the brief's unquoted prose is faithful beyond the pointers checked by hand in § 1.1
  argument: § 1.1 Readback of the brief
  verdict: derived
  grade: computed over: the brief's one blockquote against `data/fs116/claims.md`
  minds: 1
  model: the brief's RING-TRANSFER quotation, found at `data/fs116/claims.md` § 5
  prior art: known: a quotation check, the workflow's readback
  handoff: none — a readback, no mathematics

control: fs116-n2-quotes
  of: FS116-N2-QT — the quotation found, and one altered by a word not found
  run: python3 ../tools/fs116_n2_quotes.py --count
  expect: FOUND 1 of 1
  fault: python3 ../tools/fs116_n2_quotes.py --count --alter

**My claim, restated beside the quotation.** RING-TRANSFER: for each ring type at a vertex of at least four colours, state and derive the finite rule
giving the ring types of the four-colour vertices the ring places at distance 1, and name the types that can recur at every vertex they place; one
verdict (TRUE, FALSE, GAP, MISSTATED with the corrected statement), and for every lemma where it fails on the strip and the disk and what it says at
`k = 7`. At the coordinator's word, the six-colour ring type (FS116-Y2-SIXFRAG) is among the types.

**Read, in this order:** the brief; the standing rules; the frozen list in full; the plan in full; `plans/FS116-N1-proof.md` in full (stages 1–4);
`plans/FS116-V2-verification.md` stage 1 and stage 4; `plans/FS114-derivation.md` header and § 3 in full; `plans/FS114-N6-proof.md` header and stage 2
(N6-KAPPA, N6-WIN, N6-RING60, N6-QOUT, N6-NOQ); `plans/FS114-N7-proof.md` header, stages 2–3 (N7-HUB, -REACH, -TAN, -TAC, -3T, -FLANK, -QOPP, -CHAIN,
-HUBQ, -OCTB); the stub's first 150 lines (its question, forms and bearing); `plans/FS121-D3-proof.md` § 1.2 and § 2.3; `data/fs116/reports/FS116-N1.md`;
`data/fs116/n1/ring-survey.out` (the strip's midline rings). The object is the plan's (the ring of a four-colour vertex), unmoved since its §G: no re-walk.

### 1.2 Recognition (`ephodos-recognition`, invoked fresh)

**The stall.** None yet at this claim (it "has not been attempted"); the shape that dispatches is *a result proved only at instances*: N7-HUB places
four-colour vertices on a (Q)-free ring's six change points, and the plan's reading (§ 3.3) that "four-colour vertices lie on the unit triangular lattice
`p + ℤ[ζ₆]·e(y)` until a defect intervenes" was never tested against what each placed vertex's own ring must be.

**For a stranger** (a graph theorist who works on homomorphisms to Kneser graphs, and a discrete geometer who works on local rules for point sets):
*Cut an open set containing a closed disc of radius above 2 about `p` into regions by finitely many segments and circular arcs near each point, colour the
regions with six colours so that no two interior points of one colour are exactly 1 apart, and let four colours meet at `p`. Colour each point of the
unit circle about `p` by the colours of the regions touching it; off the boundaries it carries one of the two colours missing at `p`, and it changes colour
at finitely many points. At a change point `y` whose points 60° away on the circle are not on arcs along which `p`'s own colours face each other, four
colours meet (known). Given everything within distance 1 of `p`, what is forced about the unit circle about `y` — which colours are missing at `y`, where
that circle changes colour — and can the configuration at `p` repeat at every such `y`?* Words the reader stops at: "(Q) arc" — an arc of the unit circle
about `p` with both of its sides coloured by colours present at `p` (the literature's unit-radius tactic); "ring type" — the cyclic word of arcs, change
points and colours on the circle, read modulo the 60° rotation (§ 0); "hub" — *new*, struck into the sentence ("a change point whose points 60° away …").

**The features, sorted** (receipt in brackets):
- **the ring word of `p`** — *splits*. Its consequence "which change points have their four germs off (Q) arcs" *determines which points are placed*
  [RING-GERM (iii) consumes exactly that, and the disk's corner, whose change points have all four germs on (Q) arcs, carries two colours there:
  FS116-N1-QDISK]. The rest of the word *accompanies what is placed*: the placed vertex's missing colours are read off the tiles of `p` in the flanking
  directions (§ 1.2's prediction, derived at stage 2), which the ring word does not mention — on a (Q)-free ring the word's colours are the two absent
  colours only, and `p`'s four colours appear nowhere in it.
- **`p`'s star** (the directions of its edges against the flanking directions and the D-directions) — *determines what is placed* [receipt, on the strip
  (`data/fs116/n1/ring-survey.out`): `P₀` has straight edges at `0°, 90°, 180°, 270°`, its hubs-to-be `P_{±2}` sit at `0°, 180°` with flanking directions
  `±90°` — exactly edge directions — and `A(P₂) = {M, P}` while `A(P₋₂) = {B, O}` (colour sets `{B, G, O, R}` and `{G, M, P, R}` read there); a star with
  the flanking directions inside tiles forces the two antipodal placed vertices to share their missing pair (derived at stage 2). Same ring word at both
  hubs' flanks, different stars, different outputs.]
- **the far arc of the placed vertex's ring** — the arc of `ω(y)` outside `B̄(p, 1)`, 240° long — *accompanies `p`* and *determines `y`'s ring type*
  [nothing within distance 1 of `p` is at distance 1 from its interior; `ω(y) ∩ B̄(p, 1)` is the closed 120° arc from `r(ψ + 60°)` through `p` to
  `r(ψ − 60°)`]. So "the ring types of the vertices it places are determined" is expected to fail at that arc; what `p` can determine is the placed ring's
  colouring off its own `D` (it is 120°-periodic: RING-TWIST-C's `c(θ + 60°) ≠ c(θ)` with two absent colours) and its defects on the near arc.
- **six colours** — *determines* [two absent colours at each four-colour vertex: every placed vertex's missing pair is a 2-subset of the four colours of
  `p`, and two such subsets are disjoint only if complementary; at seven, three are absent and RING-GERM's Step 1 fails].
- **non-Siamese and simple** — *determines* the count [one tile per colour and one cone per tile: a four-colour vertex has exactly four edges].
- **the 60° geometry** — *determines* [`y ± 60°` on `ω(p)` are `p ∓ 60°` on `ω(y)`; `ω(p)` and `ω(2y − p)` are tangent at `y`].
- **the degree of `p`, its tactic edges** — *accompany* [enter only through the star].

**The homes.**
1. **Homomorphisms to Kneser graphs** (the graph theorist's). Name: the map `y ↦ A(y)` from four-colour vertices to 2-subsets of the six colours.
   Dictionary: "`y` is a change point of `p`'s ring" ↔ "`A(p)` and `A(y)` are disjoint" (the change point carries both of `p`'s absent colours), i.e. an
   edge of `KG(6, 2)`; the hubs of one four-colour `p` ↔ vertices of the link `KG(4, 2)` on `P(p)`, which is **three disjoint edges** — the three perfect
   matchings of a 4-set (in the grokkings' words, G73: "the `V₄` structure of `K₄`'s three perfect matchings, the three components of the Kneser graph
   `KG(4, 2)`"). Theorem the home holds: a homomorphism from a graph into `3K₂` exists iff the graph is bipartite (each component into one edge). *Tests:*
   the old proofs apply at once (an odd cycle of hub relations among `p`'s hubs is a contradiction); the exceptions vanish (every case of "which absent
   pairs can the six hubs carry" becomes one question: is the relation graph bipartite); it **predicts a neighbour** — if all six hubs recur (their rings
   place their neighbours on the hexagon) the hexagon's relations are a 6-cycle, bipartite, fine; but the star's antipodal rule (stage 2) glues `y_k` to
   `y_{k+3}` with *equal* pairs, folding the 6-cycle to a triangle, which is not bipartite — so a defect-free ring cannot recur at all six of its placed
   vertices. The dictionary holds both ways on the relation "absent pairs disjoint" and says nothing of geometry; the geometry enters as which pairs are
   related. **Adopted as the language of the transfer.**
2. **Local rules for Delone sets** (the local theorem; H3 of the plan, unread there and here): four-colour vertices as a point set whose coronas
   propagate. Its theorem needs identical coronas at every point; the Kneser prediction says the defect-free corona cannot repeat at its six neighbours, so
   the hypothesis fails at the first shell. **Killed as a decider**; kept as the word for what D2 does.
3. **Circle colourings avoiding a rotation** (H2): decides each ring's colouring (RING-TWIST-C) and so which points are hubs; transfers nothing between
   rings. **Kept for the ring, not for the transfer.**

**The recognition sentence.** *The transfer along a hub is a homomorphism into the Kneser graph `KG(6, 2)`: a hub carries `p`'s two absent colours and
misses two of `p`'s four, read off the tiles of `p` in the flanking directions; around one four-colour vertex the placed vertices' missing pairs live in
`KG(4, 2)`, a perfect matching of three edges; and whether a ring type recurs at its placed vertices is whether the graph of forced relations among them,
with the star's antipodal identifications, is bipartite.* **It differs from the plan's frame** (§ 3.3: the rule maps a ring type to ring types): the input
is the ring *and the star*, and the output is each placed vertex's colour data and its ring near `p`, not its whole ring type. RING-TRANSFER is therefore
expected **MISSTATED**; stage 2 derives the rule on the corrected input, stage 3 the recurrence. Reported to the coordinator with the verdict.

**Novelty, at the grain of the step:** the ring lemmas are FS-114's and FS-116's; the Kneser reading of absent pairs is not found in FS-116's gate
(`plans/FS116-local-exclusion.md` § 2.3, 12 queries); a search in its own words is owed (INVENTORY).

## Stage 1 — SAVED

## Stage 2 — SAVED: the ring types, and the rule at a hub

*Class throughout: a non-Siamese valid fragment on a closed disc of radius above 2 about `p` (the rings of the points of `ω(p)` must lie inside it);
"simple" added where a count of edges is used. Six colours in all unless `k` is named.*

### 2.1 The ring types, by the number of colours at `p` — only a four-colour ring places anything

**The argument of FS116-N2-SIXRING.** Six colours at `p`: none is absent, so no ring point is off `Γ` (FS116-N1-TWIST-D: a ring point off `Γ` carries a
colour absent at `p`), and the ring is a finite union of closed arcs of `Γ`. The inner side of every ring arc has points in `B(p, 1)`, so its tile is within
`< 1` of `p`'s tile of the same colour (every colour is at `p`), hence is that tile (non-Siamese): **every inner tile is a tile of `p`**, and `p` has six
tiles, one per colour. A tile has diameter at most 1, so its contacts with the ring lie in a closed arc of at most `60°` (a chord over more than `60°`
exceeds 1). Six such sets cover the circle, so each containing arc is exactly `60°`, they overlap only at ends, and each tile's contact set, being closed and
of full measure in its arc, is the whole closed arc `Z_i = [α_0 + 60°i, α_0 + 60°(i + 1)]`. So the tile `t_i` holds `p`, `z_i`, `z_{i+1}` in its closure
and lies in `B̄(p, 1) ∩ B̄(z_i, 1) ∩ B̄(z_{i+1}, 1)`, the Reuleaux triangle `Reul(p, z_i, z_{i+1})`, with cone at `p` inside `[α_i − 30°, α_i + 90°]`. Every
ring arc has both side colours at `p`, which has at least four: every ring arc is a (Q) arc. **Outer colours.** An outer tile `O` of colour `c` along a
subarc `J` of `Z_i` is not `t_c` (it lies outside `B̄(p, 1)`), so it is far from `t_c`, and `t_c` misses `B(z, 1)` for every `z ∈ J`; `t_c` reaches the two
ends of `Z_c`, so every point of `J` is at angle at least `60°` from every point of `Z_c`: with `J` a non-degenerate subarc of `Z_i` this excludes `Z_{i−1}`,
`Z_i`, `Z_{i+1}` and leaves `c ∈ {c(t_{i+2}), c(t_{i+3}), c(t_{i+4})}`. **No change point:** a change point has the ring off `Γ` on both sides. ∎ *Uses:*
TWIST-D, non-Siamese, diameter; not simplicity, not the colour count beyond "six at `p`".

**The argument of FS116-N2-FIVERING.** Five colours at `p`, absent `X`. Off a finite set, a ring point not on a (Q) arc is off `Γ` in an `X`-tile
(TWIST-D) or on an arc of `Γ` that is not (Q), one of whose side colours is absent (`p` has at least four colours, so "(Q)" fails only by a side colour), i.e.
`X`. If `r(θ)` and `r(θ + 60°)` were both such points, `r(θ + 60°)` would carry `X` while N-E1 (off `Γ`) or FS116-N1's L1 (on an arc: a ring arc of `Γ`
excludes its side colours `60°` away) excludes `X` there. So `Q ∪ σ⁻¹Q` is the whole ring up to a finite set, `Q` the union of the (Q) arcs, and `|Q| ≥ 180°`.
Off `Γ` the ring is `X` only: no change point. ∎ (This is FS116-N1-QFREE4's step made local; QFREE4 is its case `Q = ∅`.)

So **a ring of five or six colours places no vertex through RING-GERM**: the transfer rule below is a rule for four-colour rings, and the six- and
five-colour types are left with what they force on their own rings. The six-colour type's shape is general, not the family's: every six-colour vertex of the
class is a Reuleaux flower, which is FS116-Y2-SIXFRAG's straight flower relaxed to tiles inside the Reuleaux triangles; SIXFRAG's lenses `Q_j`, `Q_{j+1}`
and gap tile `G_j` are exactly the three admissible outer colours `j + 2`, `j + 3`, `j + 4` along `Z_j` (its § 2.3). **Whether the six-colour type is
excluded at some radius is not decided here**; SIXRING is the input an exclusion starts from (the coordinator's question; INVENTORY).

### 2.2 The rule at a hub of a four-colour ring

*Setting:* `p` of four colours `P`, absent `A(p) = {X, X̄}`; `y = r(ψ)` a change point of `p`'s ring (the ring off `Γ` on both sides, reading L); `T_y` the
colours of the tips at `y`, `O_y` those of the outer tiles at `y`; `u = r(ψ + 60°)`, `v = r(ψ − 60°)`.

**The argument of FS116-N2-STAR.** The ring tiles at `y` carry `X` and `X̄`, so `A(p) ⊂ C(y)`, and with six colours every other colour at `y` is in `P`. A
tile at `y` of a colour of `P` is a tile of `p` (a tip) or not (an outer tile); one tile per colour at `y` (non-Siamese), so `T_y ∩ O_y = ∅` and
`C(y) = A(p) ⊔ T_y ⊔ O_y`, `A(y) = P ∖ (T_y ∪ O_y)`. A tip lies in `B̄(y, 1)`, so its cone at `p` lies in `[ψ − 90°, ψ + 90°]`; the tile of `p` of an outer
colour `c` is distinct from the outer `c`-tile at `y`, hence far from it, hence misses `B(y, 1)`: its cone lies in `[ψ + 90°, ψ + 270°]`. A tile of `p`
whose cone contains `ψ + 90°` or `ψ − 90°` in its interior holds the branch of `ω(y)` leaving `p` in that direction, whose points are at distance 1 from `y`:
its colour is in `A(y)` (N-E1 at `y`; FS114-N7-TAN (i)). By RING-GERM (two minds), `T_y ≠ ∅` when `v⁻, u⁺` lie on no (Q) arc and `O_y ≠ ∅` when `u⁻, v⁺`
do; at a hub both, and `y` has four, five or six colours as `|T_y| + |O_y|` is 2, 3 or 4. ∎

**The argument of FS116-N2-RECIP.** `y` a hub of four colours and no more. On `ω(y)` the point `p` sits at angle `ψ + 180°`, and `u`, `v` at `ψ + 120°`,
`ψ + 240°`: **`p ∓ 60°` on `ω(y)` are the points `u`, `v` of `p`'s ring**, where `ω(y)` crosses `ω(p)` at `60°`, entering `B(p, 1)` toward `p`. Suppose
`p` lies on no arc of `Γ` on `ω(y)` and the four germs of `ω(y)` at `u` and `v` lie on no (Q) arc of `y`'s ring. `p` is in the closure of a tip, whose colour
is at `y`, so `p` is a point of `y`'s set `D`; its two germs on `ω(y)` are off `Γ`, in tiles of `p` (the ccw one leaving along `ψ − 90°`, the cw one along
`ψ + 90°`), of colours in `A(y)`. If they had one colour `Y`, `p` would be FS116-N1-TOUCH's touch point of `y`'s ring, and TOUCH says no tile of the other
colour `Ȳ` of `A(y)` has `p` in its closure; but `A(y) ⊂ P`. So **`p` is a change point of `y`'s ring**, its two sides coloured by the tiles of `p` holding
the two branches, which are the two colours of `A(y)`. ∎ *Uses:* STAR, TOUCH (one mind), N-E1, six colours (both at TOUCH and at `A(y) ⊂ P`).

**The argument of FS116-N2-ANTI.** `p` simple as well, so it has exactly four tiles; `y` and `y* = 2p − y` hubs of `p`, and `ψ ± 90°` interior to cones
of tiles `t⁺ ∋ ψ + 90°`, `t⁻ ∋ ψ − 90°`. If `t⁺ = t⁻`, its cone (an interval) holds one of the closed half-circles `[ψ − 90°, ψ + 90°]`,
`[ψ + 90°, ψ + 270°]` in its interior, leaving no room for a tip of `y` (cone in the first) or for the tile of `p` of an outer colour of `y` (cone in the
second), both of which exist at a hub: so `t⁺ ≠ t⁻`. Neither is a tip or an outer colour's tile of `y` or of `y*` (their cones cross the boundary directions),
and both colours are missing at `y` and at `y*` (the flanking directions of `y*` are the same two). The two other tiles fill the two gaps between `t⁺` and
`t⁻`, one within `(ψ − 90°, ψ + 90°)` and one within `(ψ + 90°, ψ + 270°)`; by STAR at `y` the first is the only possible tip and the second the only
possible outer colour's tile, and at `y*` the roles exchange, each non-empty at a hub. ∎ So **`A(y) = A(y*) = {c(t⁺), c(t⁻)}`, `T_y = O_{y*}`,
`O_y = T_{y*}`, each one colour, and `y`, `y*` have four colours.** Its general form, used in § 3: *if no edge of `p` leaves at a direction `δ`, the tile
holding `δ` has its colour missing at both points of `ω(p)` at `δ ± 90°` that are change points* (N-E1 at each; FS114-N7-TAN (i)).

### 2.3 What the rule reads, and what it does not

The rule's inputs are `p`'s ring (which change points are hubs: RING-GERM) **and `p`'s star** (which tiles hold the flanking directions: STAR, RECIP, ANTI).
The ring word as defined in § 0 does not record the star: on a (Q)-free ring its colours are `X, X̄` only, and none of `p`'s four colours appears in it,
while each hub's missing pair is two of those four. Its output is the hub's colours, its missing pair, whether `p` is a change point of the hub's ring
and with which colours, and the hub's germs at `p ± 60°` sitting at `u` and `v`. Nothing at `p` is at distance 1 from the interior of the arc of `ω(y)`
outside `B̄(p, 1)`, 240° long: **its arcs of `Γ`, its (Q) arcs and its touch points are not read**, though its colouring off `D` is, being 120°-periodic
(RING-TWIST-C's colour is swapped by `σ`). That no argument could read them is not claimed: no two fragments with one ring type at `p` and different far arcs
are held.

### 2.4 Controls, and `k = 7`

`tools/fs116_n2_star.py` reads every change point (ring off `Γ` both sides) of the held rings through FS116-N1's ring tool (imported, unedited; floats
reading exact objects) and checks STAR there: `A(p) ⊂ C(y)`, tips and outer colours disjoint, each tip's cone and each outer colour's `p`-tile in its half-plane,
and the germs of `ω(y)` at `p` in colours missing at `y`. Output (`data/fs116/n2/star.out`): **the strip's `P₀`**: at `0°` (`P₂`) `A(y) = {M, P}`, `T = ∅`,
`O = {B, O}`; at `180°` (`P₋₂`) `A(y) = {B, O}`, `O = {M, P}`; `P₁` the same up to colours; **the disk's corner** at `209.01°`, `330.99°`: `T = O = ∅` (two
colours). All consistent; the plant (the two half-planes swapped) reports violations. None of these change points is a hub (their germs at `±60°` touch (Q)
arcs: FS116-N1-QDISK, the germ report), so they model STAR's partial form only; **no held fragment has a hub**, and RECIP and ANTI have no held model at six
colours. **ANTI's hypothesis is exactly what the strip lacks:** `P₀`'s edges run along the flanking directions `±90°` of its change points, and their missing
pairs differ.

| entry | the strip (`P₀`, `P₁`) | the disk (corner `A₀`) | `k = 7` |
|---|---|---|---|
| SIXRING | silent: no six-colour vertex | silent | R7's lattice points have six colours of seven, one absent: their rings are three Reuleaux arcs and three arcs off `Γ` (FS116-N1 § 2.4) — "none absent" is where six is spent |
| FIVERING | silent: four-colour vertices | silent | spent at "the absent colour is `X`": with seven, five at `p` leave two |
| STAR | partial form met at `P_{±2}` (outer only) | met trivially (`T = O = ∅`) | `C(y) ⊃ A(p)` fails (three absent at `p`, two on the ring): six spent at "every other colour at `y` is in `P`" |
| RECIP | no hub: silent | no hub: silent | spent at TOUCH and at `A(y) ⊂ P` |
| ANTI | hypothesis fails (flanking directions on edges; conclusion fails too) | no hub: silent | spent through STAR |

### 2.5 The entries

derivation: FS116-N2-SIXRING
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of six colours, the ring lies in Γ and is six consecutive
    closed 60° arcs Z_i = [α + 60°i, α + 60°(i + 1)], each the whole set of ring points in the closure of one tile t_i of p; t_i lies in the Reuleaux
    triangle Reul(p, z_i, z_(i+1)) on its arc, with cone at p in [α + 60°i − 30°, α + 60°i + 90°]; every ring arc is a (Q) arc, and every outer tile along a
    non-degenerate subarc of Z_i has the colour of t_(i+2), t_(i+3) or t_(i+4); the ring has no change point, so p has no hub
  uses only: FS116-N1-TWIST-D (a ring point off Γ carries a colour absent at p); non-Siamese (the inner tile of a ring arc is p's tile of its colour, and an
    outer tile is far from p's tile of its colour); that a tile has diameter at most 1 and a chord over more than 60° exceeds 1
  not claimed: that any valid fragment has a six-colour vertex beyond radius 3/2; an exclusion of the type at any radius (FS116-Y2-SIXOFF's family stops
    below √3; the general type is open); anything in the Siamese class (there an inner tile need not be p's)
  argument: § 2.1 The ring types, by the number of colours at `p` — only a four-colour ring places anything
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: FS116-Y2-SIXFRAG, the straight flower — its sectors are the t_i, and its lenses Q_j, Q_(j+1) and gap tile G_j carry along Z_j exactly the three
    admissible outer colours j + 2, j + 3, j + 4 (plans/FS116-Y2-construction.md § 2.3, one mind, exact)
  prior art: partly: FS116-Y2's remark (§ 2.3, one mind) and FS112-NB's C-V56 hold the Reuleaux containment; the outer-colour rule not found — owed
  handoff: de Bruijn — with TWIST-D, queued behind D6's map type; a relay-result for any exclusion of six-colour vertices

derivation: FS116-N2-FIVERING
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point,
    and for every θ outside a finite set r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180° and p has no hub
  uses only: FS116-N1-TWIST-D; N-E1; FS116-N1's L1 (a ring arc of Γ excludes its side colours 60° away); that p's four or more colours make a non-(Q) ring
    arc have an absent side colour
  not claimed: anything at k ≥ 7; that a five-colour vertex occurs in any fragment
  argument: § 2.1 The ring types, by the number of colours at `p` — only a four-colour ring places anything
  verdict: derived
  grade: hand
  minds: 1
  model: none held with five colours at a vertex; at k = 7 the vertices of R7 carry six of seven, and the step "the absent colour is X" is where six is spent
  prior art: partly: FS116-N1-QFREE4 is its case with no (Q) arc; this form's search owed
  handoff: none — a relay-result for the ring-type list; crosses to Lean with TWIST-D

derivation: FS116-N2-STAR
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of four colours P, let y = r(ψ) be a change point of the
    ring, T_y the colours of the tiles of p at y and O_y those of the other tiles at y of colours of P; then C(y) = A(p) ⊔ T_y ⊔ O_y and A(y) = P ∖ (T_y ∪
    O_y); every tile of p at y has its cone at p in [ψ − 90°, ψ + 90°], and the tile of p of each colour of O_y in [ψ + 90°, ψ + 270°]; every tile of p whose
    cone holds ψ + 90° or ψ − 90° in its interior has its colour in A(y); T_y is non-empty when v⁻, u⁺ lie on no (Q) arc and O_y when u⁻, v⁺ do
  uses only: RING-GERM (i), (ii) (two minds); FS116-N1-TWIST-D; N-E1 at y; non-Siamese (one tile per colour at y; distinct tiles of one colour far apart);
    that a tile has diameter at most 1; six colours (every colour at y other than X, X̄ is in P)
  not claimed: anything at k ≥ 7; that T_y or O_y is a single colour (at a hub y has four, five or six colours); anything about the ring of y beyond its
    branches at p
  argument: § 2.2 The rule at a hub of a four-colour ring
  verdict: derived
  grade: derived from: RING-GERM
  minds: 1
  model: the strip's P₀ at its change points P_(±2) (the partial form: O = {B, O} and {M, P}, T = ∅, A(y) = {M, P} and {B, O}); the disk's corner at its
    two-colour change points (T = O = ∅) — control fs116-n2-star
  prior art: partly: FS114-N7-HUB (b), (c) and N7-TAN (i) (one mind each) on (Q)-free rings; this split at every change point not found — owed
  handoff: de Bruijn — with RING-GERM, queued behind D6's map type

derivation: FS116-N2-RECIP
  statement: in a non-Siamese valid fragment on a closed disc of radius above 2 about a vertex p of four colours P, let y = r(ψ) be a hub of p with four
    colours and no more; the points of ω(y) at 60° on either side of p are r(ψ + 60°) and r(ψ − 60°); if p lies on no arc of Γ on ω(y) and the four arcs
    of ω(y) just clockwise and just counter-clockwise of those two points lie on no (Q) arc of y's ring, then p is a change point of y's ring, its two sides
    lying in the tiles of p that hold the directions ψ − 90° and ψ + 90°, whose colours are the two colours of A(y)
  uses only: FS116-N2-STAR; FS116-N1-TOUCH (one mind: a point of D off Γ-arcs that is no change point has the other absent colour at none of its tiles);
    N-E1 at y; six colours (A(y) ⊂ P)
  not claimed: anything when an edge of p runs along ω(y) (then p lies on an arc of Γ on ω(y), a tactic edge centred at y when its sides are y's colours);
    that the hub has four colours in general; anything at k ≥ 7
  argument: § 2.2 The rule at a hub of a four-colour ring
  verdict: derived
  grade: derived from: FS116-N2-STAR, FS116-N1-TOUCH
  minds: 1
  model: none held (no held fragment has a hub, § 2.4); on (Q)-free rings FS114-N7-HUB's six change points are its instances where their rings meet the
    hypotheses
  prior art: owed
  handoff: de Bruijn — with STAR and TOUCH

derivation: FS116-N2-ANTI
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of four colours, let y = r(ψ) and y* = r(ψ + 180°)
    be hubs of p, and let ψ + 90° and ψ − 90° lie in the interiors of the cones at p of tiles t⁺ and t⁻; then t⁺ ≠ t⁻, A(y) = A(y*) = {c(t⁺), c(t⁻)},
    T_y = O_(y*) and O_y = T_(y*), each a single colour, and y and y* have four colours and no more
  uses only: FS116-N2-STAR at y and at y*; that p has exactly four tiles (non-Siamese and simple); that a cone is an interval
  not claimed: anything when an edge of p leaves at ψ + 90° or ψ − 90° (the strip: there the two missing pairs differ); anything at k ≥ 7
  argument: § 2.2 The rule at a hub of a four-colour ring
  verdict: derived
  grade: derived from: FS116-N2-STAR
  minds: 1
  model: none held with two antipodal hubs; the strip's P₀ meets every hypothesis but the interiority of the flanking directions, and fails the conclusion
    (A(P₂) = {M, P}, A(P₋₂) = {B, O}) — control fs116-n2-star
  prior art: owed
  handoff: de Bruijn — with STAR

control: fs116-n2-star
  of: FS116-N2-STAR on the held rings' change points (the strip's P₀, P₁, the disk's corner); the two half-planes swapped is caught
  run: python3 ../tools/fs116_n2_star.py | tail -n 1
  expect: STAR ALL OK
  fault: python3 ../tools/fs116_n2_star.py --plant | tail -n 1

## Stage 2 — SAVED

## Stage 3 — SAVED: which types recur, and the verdict

### 3.1 The `Γ`-free type does not recur round its hexagon (FS116-N2-HEX6, FS116-N2-HEX3)

*Setting:* `p` a vertex of at least four colours, non-Siamese and simple, on a closed disc of radius above 2, **its ring carrying no arc of `Γ`**. Let `S`
be the set of `k` for which the ring of the hub `y_k` carries no arc of `Γ` either ("`y_k` recurs"). In the Kneser language of § 1.2: the missing pairs
`F_k ⊂ P` live in the link `KG(4, 2)`, three disjoint edges `{B, P ∖ B}`.

**The argument of FS116-N2-HEX6.** (a) `p` has four colours (FS116-N1-QFREE4), hence four tiles and four edges. (b) *The hexagon.* `Γ ∩ ω(p)` is finite;
off it the ring's colour is one of `X, X̄` and changes under `σ` (N-E1), so it is not constant and a change point `y_0` exists; if `y` is a change point, the
germ just clockwise of `y + 60°` is at distance 1 from interior points just clockwise of `y` and lacks their colour, so carries the other, and likewise
counter-clockwise (RING-GERM's Step 1), so `y + 60°` is a change point. So `y_k = r(ψ_0 + 60°k)` are change points, all germs off (Q) arcs: hubs.
(c) *A recurring hub complements its neighbours.* For `k ∈ S`: `y_k` has four colours (QFREE4 at `y_k`); RECIP applies (no arc of `Γ` on `ω(y_k)`), so `p` is a
change point of `y_k`'s ring; by (b) on `ω(y_k)` the points `p ∓ 60°` of `ω(y_k)`, which are `y_{k+1}` and `y_{k−1}` (FS116-N2-RECIP), are change points of
`y_k`'s ring and carry both colours of `F_k`. So `F_k` is a 2-set and `F_{k±1} ⊂ P ∖ F_k`. (d) *No edge, a shared colour* (ANTI's general form): `D_m` is
`ψ_{m−1} + 90°` and `ψ_{m+2} − 90°`, so if no edge of `p` leaves at `D_m`, the tile holding `D_m` has its colour in `F_{m−1} ∩ F_{m+2}`. (e) If `S`
held four consecutive `k, …, k + 3`: by (c) `F_k, F_{k+2} = B`, `F_{k+1}, F_{k+3} = B′ = P ∖ B`, `F_{k+4} ⊂ B`, `F_{k−1} ⊂ B′`; then every antipodal pair
`F_j, F_{j+3}` lies in opposite classes and is disjoint, and by (d) an edge leaves `p` at each of the six `D_m`, against four edges. ∎

**The argument of FS116-N2-HEX3.** Add: every `y_k` has four colours, so every `F_j` is a 2-set and `k ∈ S` gives `F_{k±1} = P ∖ F_k`. An antipodal pair with
`F_{j+3} = P ∖ F_j` forces edges at `D_{j+1}` and `D_{j+4}` (by (d)); at most two such pairs. If `S ⊇ {k, k + 2}`: `F_{k−1} = F_{k+1} = F_{k+3} = B′`,
`F_k = F_{k+2} = B`, so the pairs `(k − 1, k + 2)` and `(k, k + 3)` are complementary and **`p`'s four edges leave at `D_k, D_{k+1}, D_{k+3}, D_{k+4}`**
(cones `60°, 120°, 60°, 120°`); the third pair is then not complementary, which excludes `k + 3`, `k + 4`, `k + 5` from `S` (each would make `F_{k+4} = B`);
and `D_{k+2}`, `D_{k+5}` lie inside the two `120°` tiles, of different colours both in `F_{k+1} ∩ F_{k+4}`, so `F_{k+4} = B′`. If `S` has no two members
at distance 2 it is `∅`, `{k}`, `{k, k+1}` or `{k, k+3}`, the last with `F_{k+3} ≠ P ∖ F_k` (else all six alternate). ∎ So **with four colours at every hub,
`S` is one of `∅, {k}, {k, k+1}, {k, k+3}, {k, k+2}, {k, k+1, k+2}`**, and the last two fix `p`'s star.

*What it says.* A `Γ`-free four-colour vertex cannot be surrounded by vertices of its own type: at least three of its six hubs carry an arc of `Γ` on their
rings when all hubs have four colours, and in every case some hub of every four consecutive does. The plan's reading ("four-colour vertices lie on the
unit triangular lattice until a defect intervenes") holds with the defect **inside the first shell**, within radius 2 of `p`. *Where six is spent:* (c)'s
2-sets and complements in a 4-set (with seven colours `F_k` has three elements and `KG(4, 2)`'s matching becomes `KG(7, 3)`-like room), QFREE4, and
RING-GERM's Step 1. *Controls:* the strip and the disk carry (Q) arcs on every four-colour ring (FS116-N1 § 2.4): silent; R7's lattice points have no change
point: silent; the slack hexagonal seven-colouring's vertices have degree 3: outside the class. No held fragment has a `Γ`-free four-colour vertex.

derivation: FS116-N2-HEX6
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries no arc
    of Γ, the ring's change points include six hubs y_k = r(ψ + 60°k), k in Z/6, and of any four consecutive y_k at least one has a ring carrying an arc
    of Γ; in particular the six rings are not all free of arcs of Γ
  uses only: FS116-N1-QFREE4 at p and at each recurring hub; RING-GERM's Step 1 and (iii) (two minds); FS116-N2-RECIP; N-E1 at y_(m−1) and y_(m+2) at a
    D-direction inside a tile; that p has four edges (non-Siamese, simple, four colours); six colours at (c)
  not claimed: that any Γ-free four-colour vertex exists in a valid six-coloured fragment; anything for rings free of (Q) arcs but carrying other arcs of Γ
    (N6-RING60's bends would be needed); anything at k ≥ 7; the placed vertices' rings beyond whether they carry an arc of Γ
  argument: § 3.1 The `Γ`-free type does not recur round its hexagon (FS116-N2-HEX6, FS116-N2-HEX3)
  verdict: derived
  grade: derived from: FS116-N2-RECIP
  minds: 1
  model: none held at six colours (no Γ-free four-colour vertex is held: FS116-N1-QFREE4's model line); the hypotheses at p are FS114-N7-HUB's, whose
    six change points are this hexagon
  prior art: partly: FS114-N6-RING60 and N7-HUB (the hexagon and its four-colour points); the complement relation in KG(4, 2) and the edge count not found
    — owed
  handoff: de Bruijn — with RECIP, STAR and TOUCH; a relay-result for D2 (the first shell of a Γ-free vertex holds a hub whose ring carries an arc of Γ)

derivation: FS116-N2-HEX3
  statement: in HEX6's setting, if every y_k has four colours and no more, the set S of k whose y_k has a ring free of arcs of Γ is empty, one hub, or of
    the form {k, k+1}, {k, k+3}, {k, k+2} or {k, k+1, k+2}; with {k, k+3} the missing pairs of y_k and y_(k+3) are not complementary; with {k, k+2} or
    {k, k+1, k+2} the four edges of p leave at D_k, D_(k+1), D_(k+3), D_(k+4) (D_m = ψ + 30° + 60°m), y_k and y_(k+2) miss one pair and y_(k+1), y_(k+3),
    y_(k+4), y_(k+5) the complementary pair
  uses only: FS116-N2-HEX6's steps (c) and (d); that two disjoint 2-subsets of a four-colour set are complementary
  not claimed: that any S of the list occurs; anything without four colours at every hub (then only HEX6)
  argument: § 3.1 The `Γ`-free type does not recur round its hexagon (FS116-N2-HEX6, FS116-N2-HEX3)
  verdict: derived
  grade: derived from: FS116-N2-HEX6
  minds: 1
  model: none held, as HEX6
  prior art: owed
  handoff: de Bruijn — with HEX6

### 3.2 Types with (Q) arcs: the recurrence is GAP

The held rings that reach farthest all carry (Q) arcs, and **none of their change points is a hub** (§ 2.4); yet the strip's midline type recurs at both
of its change points: `P_{±2}` are midline vertices of the strip, four-coloured, whose rings are `P₀`'s up to a colour bijection (the strip is a line of
congruent vertices at spacing `1/2` with colour sets of period 3; the survey of `P₀` and `P₁`, `data/fs116/n1/ring-survey.out`). What places them is RING-GERM
(ii) alone — outer tiles, from the germ pair `u⁻, v⁺` off (Q) arcs — and their four colours are the strip's, not the rule's. The disk's corner places no
four-colour vertex at its change points (FS116-N1-QDISK), and the six-colour flower places none at all (SIXRING). So for types with (Q) arcs a transfer rule
needs a placing rule at change points with one germ pair on (Q) arcs (a *semi-hub*), which no held lemma supplies, and — FS116-Y2-DCREAD — any exclusion
of the disk-corner configuration must read about `240°` round `p` from `y`, beyond any rule at `y`.

derivation: RING-TRANSFER-Q
  statement: for each ring type with a (Q) arc at a vertex of four colours, the ring types of the vertices of at least four colours it places at distance 1
    are determined by a finite rule, and the types that recur at every vertex they place are named
  argument: § 3.2 Types with (Q) arcs: the recurrence is GAP
  verdict: gap: a placing rule at a change point with one pair of its germs at ±60° on (Q) arcs — RING-GERM gives there a tip alone or an outer tile alone,
    and the strip's midline type recurs through such points (P_(±2)) with its four colours supplied by the strip, not by any lemma

### 3.3 The verdict on RING-TRANSFER

**RING-TRANSFER is MISSTATED**, for two reasons, each a finding about its words and neither shown by a pair of fragments:
1. **Its input is too small.** "For each ring type": the rule reads `p`'s ring *and its star* (STAR, RECIP, ANTI read which tiles of `p` hold the flanking
   directions), and the ring type of § 0 records no direction of `p`'s edges — on a (Q)-free ring it names no colour of `p` at all, while each placed vertex
   misses two of them. The strip shows the star deciding: its edges lie along its change points' flanking directions and its antipodal change points miss
   different pairs, where a star with those directions inside tiles would force one pair (ANTI).
2. **Its output is too large.** "The ring types of the vertices it places": each placed vertex's ring has a `240°` arc outside `B̄(p, 1)` whose arcs of `Γ`
   and (Q) arcs nothing at `p` reads. What is determined is the placed vertex's colours, its missing pair, its ring at `p` and at `p ± 60°`, and its ring's
   colouring off `D` (120°-periodic). *Not claimed:* that no argument reads the far arc — no two fragments are compared.

**The corrected statement, derived at one mind:**

derivation: RING-TRANSFER-C
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours: a ring of five or six
    colours has no change point and places no vertex through RING-GERM, the six-colour ring being six 60° (Q) arcs, one per tile of p, each tile in the
    Reuleaux triangle on its arc; a ring of four colours places its hubs, and at each hub y = r(ψ) the ring of p and the tiles of p holding the directions
    ψ + 90° and ψ − 90° determine the colours of y as the absent pair of p, the tip colours and the outer colours, and the pair missing at y, which contains
    the colour of every tile of p holding ψ ± 90° inside its cone; when y has four colours and its ring meets no (Q) arc at the points r(ψ ± 60°) and no arc
    of Γ at p, p is a change point of y's ring between the two colours missing at y; two antipodal hubs whose flanking directions lie inside tiles of p miss
    the same pair and exchange tip and outer colour; and a ring free of arcs of Γ has, among any four consecutive of its six hubs, one whose ring carries an
    arc of Γ
  uses only: FS116-N2-SIXRING, FS116-N2-FIVERING, FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI, FS116-N2-HEX6, and through them RING-GERM (two minds),
    RING-TWIST-C (two minds), FS116-N1-TWIST-D, -QFREE4 and -TOUCH (one mind each)
  not claimed: that the ring type of p alone determines any of this (the star is an input); anything about the arcs of Γ on the placed vertex's ring outside
    B̄(p, 1); the recurrence of types with (Q) arcs (RING-TRANSFER-Q, GAP); that the rule is the same at k = 7 (every step spends six: two absent colours)
  argument: § 3.3 The verdict on RING-TRANSFER
  verdict: derived
  grade: derived from: FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI, FS116-N2-HEX6, FS116-N2-SIXRING, FS116-N2-FIVERING
  minds: 1
  model: the strip's P₀ for STAR's partial form (control fs116-n2-star); FS116-Y2-SIXFRAG for the six-colour clause; no held hub for the rest
  prior art: owed — a search in the Kneser and local-rule vocabularies (§ 1.2) is the report's debt
  handoff: de Bruijn — deferred with D6's map type, after a blind second mind on STAR, RECIP, ANTI and HEX6

**For D2.** Following a `Γ`-free four-colour vertex outward, the first shell already holds a hub whose ring carries an arc of `Γ` (HEX6), and when every hub
has four colours at least three do, with `p`'s star pinned to `60°, 120°, 60°, 120°` whenever two alternate hubs recur (HEX3). The next object is therefore
a four-colour vertex whose ring carries an arc of `Γ` placed at distance 1 from a `Γ`-free one — a (Q) ring or a non-(Q) arc — and its semi-hubs, where
RING-TRANSFER-Q stalls.

## Stage 3 — SAVED
