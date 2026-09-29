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

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).

## Fence log (standing rule 8)

- No path is fenced for this job. The start-up context held the auto-memory index (status lines, no proof content). I read no session transcript. I
  write about my work only here, in `data/fs116/n2/`, in `tools/fs116_n2_*.py` and in my report. Read beyond the brief's list, at the coordinator's
  pointer (message, 2026-09-29, received during stage 1): `plans/FS116-Y2-construction.md` header and theorem table (FS116-Y2-SIXFRAG, -SIXOFF, -DCREAD).

## G87 lookout

- Stage 1: none seen as two truths in collision. One scope classed: the plan's § 3.3 ("its **transfer rule** is what a ring of one type forces on the
  four-colour vertices it places") against the recognition below (what is placed is read off `p`'s star, which the ring type does not record) — a
  statement's input too small, not two held truths.

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
