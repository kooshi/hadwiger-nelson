# FS116-Y3 — FS-116's construction side, round 3: the Γ-free four-colour vertex (every change point a hub)

*Job FS116-Y3 (Ephodos, Opus 5.5), from `data/fs116/briefs/FS116-Y3-hub.md` and `plans/STANDING-RULES.md` (both read in full first; `RUNNING.md` § Make
the gate fail, read before any tool). Launched 2026-09-29 07:37 UTC; stopped at 07:42 UTC by an account halt before anything was saved; resumed
2026-10-03 14:36 UTC on the coordinator's message ("Please resume from where you stopped, starting with your stage 1 readback. Your brief and its
standing rules are unchanged."). Resuming check (standing rule 2): no record, tool, data or report of this job existed at resumption
(`data/fs116/y3/` existed, empty), so nothing is resumed and stage 1 starts here. Working files `data/fs116/y3/`; exact checks `tools/fs116_y3_*.py`.
Every statement about a valid six-coloured fragment is about a possible object: at six colours the class may be empty (the frozen list's preamble). Grades
are my identity's grammar (`hand` = [hand], `derived from` = [derived], `computed over` = [tools]).*

*Notation* (FS116-N1's and FS116-N2's headers, and the frozen list's § 0; nothing new is meant by it but the words marked *new*). `e(θ)` the unit vector
at angle `θ`; `ω(z)` the unit circle about `z`; `r(θ) = p + e(θ)`; `C(z)` the colours of the tiles whose closure holds `z`; `P = C(p)`; `A(z)` the colours
absent at `z` (six colours in all). **N-E1**: if `z` is an interior point of a tile of colour `c` and `|z − w| = 1` then `c ∉ C(w)`. **Straddle**: a tile
`T` *straddles* `x` when it has points at distance below 1 and above 1 from `x`; then (its interior being connected) no point within a neighbourhood of `x`
lies in the closure of a tile of `T`'s colour. A tile has diameter at most 1. A **hub** of `p` (N2's) is a change point of `p`'s ring whose four germs at
`±60°` lie on no (Q) arc; a **tip** at a ring point `y` is a tile of `p` whose closure holds `y`; an **outer tile** at `y` is a tile of a colour of `p`
that is not a tile of `p`. *New:* a ring is **Γ-free** when no arc of `Γ` lies on it (`Γ ∩ ω(p)` finite).

## Theorems this phase proved

- **FS116-Y3-QT** — the brief's one quotation is verbatim in `data/fs116/claims.md` § 7, and its nine unquoted attributions are present at their sources —
  computed over the brief's blockquote and nine phrases (`tools/fs116_y3_quotes.py`), § 1.1.
- **FS116-Y3-SIX** — a Γ-free ring of a four-colour vertex (non-Siamese, simple) has exactly six change points, `60°` apart, all hubs — [derived], one mind, § 2.1.
- **FS116-Y3-TIPS** — the tip pattern is forced: one tip per hub, antipodal tips opposite, two double tips on opposite adjacent pairs and two single
  tips between them — [derived], one mind, § 2.2.
- **FS116-Y3-HUBCOL** — the hub colours, read off the star: four hubs `{1, 2, X, X̄}` and two `{3, 4, X, X̄}` when the star's edges are interior to their
  ranges — [derived], one mind, § 2.3.
- **FS116-Y3-TIGHT** — the four ring tiles beside the double tips' tight edges do not reach the far lattice vertices `q_5, q_1, q_2, q_4` — [derived], one mind, § 2.4.
- **FS116-Y3-NOQ** — at a hub, a tile adjacent to the ring tile on one side does not lie in the unit disc about the far lens vertex on the other — [derived], one mind, § 3.1.
- **FS116-Y3-LENS** — near the far vertex `q_k` of a lens beside a single tip, only the two non-tip colours of `p` can occur, and a hub colour there is that
  hub's tile reaching `q_k` — [derived], one mind, § 3.1.
- **FS116-Y3-TIGHTLENS** — on `B̄(p, √3)` each such lens needs one of its hubs' tips tight at `p`: at least two edges of `p` along flanking directions, five
  minimal kinds of star, **the generic star excluded at `√3`** — [derived], one mind, § 3.2.
- **FS116-Y3-NBTIP** — a hub's tip enters the unit disc about each neighbouring hub, so a neighbour's tip colour is never an outer colour; `y_2`'s only outer
  colour is 4, `y_5`'s is 3 — [derived], one mind, § 4.1 (sharpens HUBCOL, which stays true as written).
- **FS116-Y3-STARFORCE** — on `B̄(p, √3)` the star is exactly FS116-N2-HEX3's, and every double-tip hub carries the extra outer colour, alone or second in
  a named order — [derived], one mind, § 4.2 (sharpens TIGHTLENS: of its five minimal kinds only HEX3's is realised).
- **The brief's target** (a fragment beyond radius 2, or an obstruction at a named radius): **not landed** — reduced to HEX3's star with forced outer
  colours (§ 4.3, the stalled form).

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).
- Stage 2: would have enumerated assignments of the six hubs' tips to the four tiles; instead the opposite rule (antipodal tips opposite) was derived, which
  leaves one pattern by hand (§ 2.2).
- Stage 3: would have searched colourings of the lens neighbourhoods of the `q_k`; instead derived NOQ and LENS, whose four conditions are read by hand and
  checked as an 81-row truth table of a derived formula (§ 3.2).
- Stage 4: would have searched colourings of the outer wedges about HEX3's star toward radius 2 (and, after 2026-10-01, a solver could have been asked);
  instead read one branch at `2y_0` by hand and stopped, writing the stalled form (§ 4.3).

## Fence log (standing rule 8)

- My brief fences nothing for me; it asks me to write nothing about my work where FS116-V3, FS121-V3 or FS121-V4 could read it before their verdicts. I
  write only this record, `data/fs116/y3/`, `tools/fs116_y3_*.py` and my report. The harness's start-up context held the auto-memory index (status lines,
  no proof content). I read no session transcript and no FS116-V3, FS121-V3 or FS121-V4 record. At resumption I read `git log` subjects and grepped
  `plans/FS116-close-inventory.md` for "hub" (items 30, 66, 68, 70–73: statuses and owner rulings, no verifier content).

## G87 lookout

- Stage 1: none seen as two truths in collision.
- Stage 2: none seen. Classed: HEX3's star (`60°, 120°, 60°, 120°`, derived there from two alternate hubs recurring) against TIPS (the same cyclic shape forced
  with no recurrence) — the same object reached from two hypotheses, not two truths.
- Stage 3: none seen. Classed: TIGHT's statement (`q_5 ∉ cl R_{50}`) against what LENS needs (`R_{50} ⊄ B̄(q_5, 1)`) — TIGHT's own argument proves the
  stronger form; a statement narrower than its proof, recorded in § 3.1, not two truths.
- Stage 4: none seen. Classed: TIGHTLENS's five minimal kinds against STARFORCE's one — my own stage-3 list of outer colours was loose (HUBCOL's options at
  `y_2`, `y_5` never occur); a looseness corrected by dated paragraphs under § 2.3 and § 3.2, not two truths. FS116-N2-HEX3 and STARFORCE reach one star from
  different hypotheses: agreement, not collision.

## Stage 1 — SAVED: the readback, and recognition on the target

### 1.1 Readback (standing rule 3)

`tools/fs116_y3_quotes.py` (`data/fs116/y3/quotes.out`): **1 of 1 FOUND** — the brief's blockquote of Y-QRING, verbatim (whitespace collapsed) in
`data/fs116/claims.md` § 7 — and **9 of 9 attributions PRESENT**: N2's definition of a hub, "no held fragment has a hub" (N2 § 2.4), the five lemma
names FS116-N2-STAR, -RECIP, -ANTI, -HEX6, -HEX3 (N2's theorem list, each "one mind" there as the brief says), the list's § 9 (controls), and the brief's
own ban line. Plants: one word of the quotation altered (`--alter`) is NOT FOUND; the quotation against the wrong file (`--source
plans/STANDING-RULES.md`) is NOT FOUND.

**Three findings about the brief, by reading (none a defect of mine):**
1. **The class a model must have.** The brief's target allows any valid six-coloured fragment (Y-QRING allows Siamese pairs), but N2's hub lemmas
   (STAR, RECIP, ANTI, HEX6, HEX3) are stated "in a non-Siamese (simple) valid fragment". A Siamese or non-simple fragment answers the brief's question
   and is **not** a model of those lemmas. I aim at the non-Siamese simple class, and say of every object which class it is in.
2. **"A Γ-free ring, so every change point is a hub"** is right: a germ lies on a (Q) arc only if an arc of `Γ` lies on the ring there.
3. **The ban's date.** The brief says "The ban on finite-witness search runs to 2026-10-01"; today is 2026-10-03 and standing rule 5 says "Delete this rule
   after 2026-10-01 unless Kooshi extends it". The coordinator's message says the brief and its standing rules are unchanged, so I keep the brief's own
   line ("colourings given by formula and exact checks of them are in; nothing enumerates maps, colourings, tile graphs or ring types") as binding on this
   job, keep the log, and hold the question for the coordinator.

derivation: FS116-Y3-QT
  statement: the blockquote of data/fs116/briefs/FS116-Y3-hub.md occurs verbatim, whitespace collapsed, in data/fs116/claims.md, and the brief's nine named
    unquoted attributions are present at their sources
  uses only: the brief's text and the sources' text; whitespace normalisation and the quotation's list prefix only
  not claimed: that the brief's unquoted glosses are faithful beyond the nine phrases checked (the class finding above was found by reading)
  argument: § 1.1 Readback (standing rule 3)
  verdict: derived
  grade: computed over: the brief's 1 blockquote and its 9 named attributions
  minds: 1
  model: the quotation of Y-QRING, found at data/fs116/claims.md § 7
  prior art: known: data/fs116/claims.md § 7 (the source the quotation is checked against)
  handoff: none — a readback, not mathematics

control: fs116-y3-qt
  of: FS116-Y3-QT — the quotation found; with one word altered it is not
  run: python3 ../tools/fs116_y3_quotes.py | tail -n 1
  expect: quotations: 1 found 1; attributions: 9 present 9
  fault: python3 ../tools/fs116_y3_quotes.py --alter | tail -n 1

**My target, restated beside the quotation** (the quotation governs): "a valid fragment on a closed disc of radius above `φ²/√2` about a vertex of at least
four colours whose ring carries a (Q) arc — or a derived obstruction at a named radius", read by the brief as: *a valid fragment on a closed disc of radius
above 2 about a four-colour vertex whose ring carries no arc of Γ — or a derived obstruction at a named radius.*

**Read, in this order:** the brief; the standing rules; `data/fs116/claims.md` in full (§§ 0–11); `plans/FS116-N2-proof.md` in full; `plans/FS116-N1-proof.md`
header, theorem list, logs, § 2.1–2.4, § 3.1–3.4, § 4.0–4.4; `plans/FS116-Y2-construction.md` in full (stages 1–3); `RUNNING.md` § Make the gate fail;
`tools/fs114_yb_exact.py` header (read-only; FS114-YB's exact checker for segment-and-arc tiles); `plans/FS116-local-exclusion.md` l. 190–246 (the record
radii in the literature: Gibbs's disk `≈ 2.124` about no vertex, Sirgedas's searcher below 2.2, non-Siamese); `plans/FS116-close-inventory.md` items
30 (FS116-V1's second route V1-F5: "exactly six change points"), 66, 68, 70–73. The grokkings are in my context at launch (G82–G87 read for this job).

### 1.2 Recognition (`ephodos-recognition`, invoked fresh)

**The stall it starts from** — *a wall that describes a counterexample*: N2's lemmas say what a Γ-free four-colour vertex would carry (a hexagon of hubs,
their missing pairs in `KG(4, 2)`, the first shell not of its own type), and no held fragment carries one at six colours. Two numbers frame it: the
farthest any held six-coloured fragment reaches about a four-colour vertex is `φ²/√2 ≈ 1.851` (FS114-Y-DIAL, the strip, whose rings carry (Q) arcs), and the
largest six-coloured disc in the literature, Gibbs's, has radius `≈ 2.124` about a point interior to a tile. A fragment beyond radius 2 about a Γ-free
vertex would be a record twice over; so the recognition asks first what every such fragment must carry, and where.

**For a stranger** (a discrete geometer who works on colourings of the plane avoiding distance 1, and one who works on partitions into sets of diameter at
most 1): *An open set containing the closed disc of radius `R` about a point `p` is cut by segments and circular arcs, finitely many near each point, into
regions coloured with six colours so that no two interior points of one colour are exactly 1 apart; distinct regions of one colour are at least 1 apart.
Four regions meet at `p`. The unit circle about `p` meets the boundaries in finitely many points only. How large can `R` be?* Words the reader stops at:
"ring", "change point", "hub", "(Q) arc", "tip" — defined in the notation from the reader's primitives (the unit circle, its colours, boundary arcs along it);
struck from the question, which needs none of them.

**The features, sorted** (receipts in brackets):

| feature | sort | receipt |
|---|---|---|
| the unit circle about `p` meets `Γ` in finitely many points | determines | off those points it lies in tiles of the two colours absent at `p`, `c(θ + 60°) ≠ c(θ)` (N-E1; RING-TWIST-C's L2): its colours alternate, period `120°`. The argument consumes it as "the ring carries only `X`, `X̄` and has no seam", which fixes the change points' germs off (Q) arcs |
| the number of change points | determines (a consequence of the row above and of the four tiles) | each change point needs a tip (RING-GERM (i)); a tile of diameter at most 1 meets the ring in a closed arc of at most `60°`, which holds at most `2j + 2` of `6(2j + 1)` change points, and four tiles cover at most `4(2j + 2)` of them: `j = 0`, **exactly six**, `60°` apart (derived in § 2; FS116-V1's V1-F5 reached "exactly six change points" by another route) |
| four tiles at `p`, non-Siamese and simple | determines | the six hubs need tips from four tiles, each tip of two hubs only if they are adjacent: the count `(2, 2, 1, 1)`; and two tips tight at a common flanking direction cannot share an edge at `p` (their discs meet only at `p`). This **forces one tip pattern** (§ 2). With Siamese pairs the tips of RING-GERM become GERM-S's facing tiles and the count changes: *unsorted* for the Siamese class |
| the six hubs with `p` are a patch of the unit triangular lattice `ℤ[ζ₆]` | determines | every distance the argument uses is 1, `√3` or 2 between lattice points `p`, `y_k = e(60k)`, `q_k = √3·e(60k + 30°)`, `2y_k`; the forced tightnesses are unit arcs about these points |
| the shapes of the tiles beyond what the hubs force | unsorted | whether an obstruction exists is exactly whether some forced shape kills a point; a construction is a choice of them |
| six colours | determines | spent at RING-TWIST-C's L2 (two absent colours, swapped), at RING-GERM's Step 1, and at the hub colour sets of § 2. **At `k = 9` the square nine-colouring SQ9 has a Γ-free four-colour vertex at every grid point, on every disc** (its boundaries are segments): any obstruction must name where six is spent |
| the radius 2 | accompanies, as a threshold | RECIP needs radius above 2 to read the hubs' rings; the forced structure below lives in `B̄(p, 2)` because `p`'s tiles and the ring tiles straddle nothing beyond radius 2 |

**The homes.**
1. **The project's ring theory** (TWIST-D, RING-TWIST-C, RING-GERM, GERM-S, STAR): adopted for radius `1 + ε`. Its proofs apply at once to the Γ-free ring
   and give the hexagon of hubs, the tip and outer cones at each hub, and the flanking rule. *Predicts a neighbour:* the tip pattern (§ 2), which no held
   lemma states.
2. **Partitions into sets of diameter at most 1** (the discrete geometer's Borsuk-type count): the four tiles of `p` are sets of diameter at most 1 through
   `p` that must reach six points of the unit circle `60°` apart. Its one theorem here is elementary (a set of diameter at most 1 through `p` meets `ω(p)`
   in an arc of at most `60°`, and through two ring points `60°` apart it lies in their Reuleaux triangle with `p`); it **decides the tip count** and, with
   the tangency of two unit circles at `p`, the tip pattern. Adopted for § 2.
3. **The unit triangular lattice and its Reuleaux triangles**: every forced tightness is a unit arc about a lattice point, and the lens of two adjacent hubs
   has its far vertex at `q_k`. *Test:* it predicts that beyond the ring the colours excluded at `x` by `p`'s tiles and the ring tiles depend only on **which
   hubs lie within distance 1 of `x`** — the arc of `ω(p)` inside `B(x, 1)` — so the annulus `1 < |x| < 2` splits into lenses, petals and outer wedges by
   lattice circles (§ 3). Adopted as the map an obstruction or a construction reads.
4. **Gibbs's disk and Sirgedas's searcher** (the literature's six-coloured discs): objects, no theorem; their record radius is the bar a construction must
   clear. Held as context only.

**The recognition sentence.** *A Γ-free four-colour vertex is a unit triangular-lattice patch: its ring carries the two absent colours in six `60°` arcs,
its six change points are hubs at `e(60k)`, and four tiles of diameter at most 1 can tip six hubs in one way only — two Reuleaux-shaped double tips on
opposite pairs of adjacent hubs and two single tips — which fixes every hub's colours; beyond the ring the exclusions those tiles force at `x` are read off
the arc of hubs within distance 1 of `x`.* **Where it differs from the brief's frame:** the brief asks for a fragment or an obstruction; recognition says
the construction's first half is forced (§ 2: no freedom in the tip pattern), and that the forced exclusions alone leave at least three colours at every
point of the annulus `1 < |x| < 2` (§ 3) — so an obstruction, if one exists, must read the shapes of the outer tiles, and a construction is a choice of
colours on a lattice-circle arrangement. Reported to the coordinator with the result.

**Novelty, at the grain of the step:** the tip pattern and the arc map are not in FS-116's gate (`plans/FS116-local-exclusion.md` § 2.3) and no search of
my own is run yet: owed (INVENTORY).

## Stage 1 — SAVED

## Stage 2 — SAVED: the forced structure at radius `1 + ε` — six hubs, one tip pattern, the hub colours

*Class throughout: a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex `p` of at least four colours whose
ring is Γ-free. Inputs at their grades: FS116-N1-QFREE4 (one mind), RING-TWIST-C and RING-GERM (two minds), FS116-N2-STAR (one mind).*

### 2.1 Exactly six change points, all hubs (FS116-Y3-SIX)

By QFREE4 `p` has four colours and no more, absent `X, X̄`; non-Siamese and simple, it has four tiles and four edges, the tiles' cones closed intervals
(possibly degenerate) covering every direction. `Γ ∩ ω(p)` is finite, so off it the ring lies in tiles of `X` or `X̄` (TWIST-D), and `c(θ + 60°)` is the
colour other than `c(θ)` (RING-TWIST-C's L2): the colour is a step function swapped by `σ`, its colour changes are `σ`-invariant, and each half-open `60°`
window holds an odd number of them (L4). A colour change has both germs off `Γ` (no arc of `Γ` on the ring), so it is a change point, and its germs at
`±60°` lie on no (Q) arc: **every change point is a hub**; so there are `6(2j + 1)` change points. Each has a tip (RING-GERM (i)). A tile of `p` lies in
`B̄(p, 1)` with diameter at most 1, so the ring points in its closure are pairwise at most `60°` apart and lie in one closed `60°` arc, which holds at most
`2j + 2` of the change points; four tiles reach at most `4(2j + 2)`, and `4(2j + 2) ≥ 6(2j + 1)` forces `j = 0`. ∎ Rotating, the hubs are `y_k = e(60k)`
(`p` at the origin), and the ring is `X` on `(0°, 60°)`, `(120°, 180°)`, `(240°, 300°)` and `X̄` on the other three arcs (the names `X`, `X̄` chosen so).

### 2.2 The tip pattern is forced (FS116-Y3-TIPS)

**(a) Antipodal tips are not adjacent.** A tip `t` of `y` lies in `B̄(y, 1)`; a tip `t′` of `y′ = −y` in `B̄(y′, 1)`; `|y − y′| = 2`, so the two closed discs
meet only at `p` (`data/fs116/y3/lattice.out` (a)). Two tiles adjacent at `p` share a non-degenerate boundary curve from `p`, which would lie in both: so
`t` and `t′` are neither equal nor adjacent — with four tiles in a cycle, **opposite**.
**(b) One tip each, and the map.** If `y_k` had two tips, every tip of `y_{k+3}` would be opposite to both: impossible. So each hub has exactly one tip
`τ(y_k)`, and `τ(y_{k+3}) = τ(y_k) + 2` (indices of the four tiles in counter-clockwise order, mod 4). A tile tips at most two hubs, and two only if they
are adjacent (§ 2.1's `60°` arc), and then lies in their Reuleaux triangle with `p`. Six hubs on four tiles: some adjacent pair shares its tip — rotate it
to `(y_0, y_1)`, tipped by `t_a`. Then `y_3, y_4` are tipped by `t_{a+2}`; `y_2`'s tip is neither (it would tip three hubs), so it is `t_{a±1}`, and `y_5`'s
the other. **(c) Which single is which.** `t_a`'s cone at `p` lies in `[−30°, 90°]` (inside `B̄(y_0, 1) ∩ B̄(y_1, 1)`), `t_{a+2}`'s in `[150°, 270°]`; the
tile between them counter-clockwise has a cone containing `[90°, 150°]`, which no tile inside `B̄(y_5, 1)` (cone in `[210°, 30°]`) has: it tips `y_2`. ∎

So, naming the tiles by role — **`T1`** tips `y_0, y_1` (cone `[δ_4, δ_1] ⊂ [−30°, 90°]`), **`T3`** tips `y_2` (`[δ_1, δ_2] ⊂ [30°, 210°]`), **`T2`** tips `y_3, y_4`
(`[δ_2, δ_3] ⊂ [150°, 270°]`), **`T4`** tips `y_5` (`[δ_3, δ_4] ⊂ [210°, 30°]`), counter-clockwise, with `δ_1 ∈ [30°, 90°]`, `δ_2 ∈ [150°, 210°]`, `δ_3 ∈
[210°, 270°]`, `δ_4 ∈ [−30°, 30°]` — and their colours `1, 3, 2, 4`. This is the pattern of HEX3's star when `δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30°`
(N2 § 3.1: four edges at `D_k, D_{k+1}, D_{k+3}, D_{k+4}`); HEX3 needs it only when two alternate hubs recur, and here it is one member of a forced family.

### 2.3 The hub colours (FS116-Y3-HUBCOL)

By STAR, `C(y) = {X, X̄} ⊔ T_y ⊔ O_y`, `T_y = {c(τ(y))}`, and `O_y` (non-empty: RING-GERM (ii)) holds colours whose tile at `p` misses `B(y, 1)` (cone at
`p` in `[ψ + 90°, ψ + 270°]`). Reading the cones of § 2.2:

| hub | tip | outer colours possible | four colours when every `δ` is interior to its range |
|---|---|---|---|
| `y_0` | 1 | 2; 3 only if `δ_1 = 90°` | `{1, 2, X, X̄}` |
| `y_1` | 1 | 2; 4 only if `δ_4 = −30°` | `{1, 2, X, X̄}` |
| `y_2` | 3 | 4; 2 only if `δ_2 = 210°`; 1 only if `δ_1 = 30°` | `{3, 4, X, X̄}` |
| `y_3` | 2 | 1; 4 only if `δ_3 = 270°` | `{1, 2, X, X̄}` |
| `y_4` | 2 | 1; 3 only if `δ_2 = 150°` | `{1, 2, X, X̄}` |
| `y_5` | 4 | 3; 1 only if `δ_4 = 30°`; 2 only if `δ_3 = 210°` | `{3, 4, X, X̄}` |

With every `δ` interior, the flanking directions `60k ± 90°` are interior to tiles and STAR's flank clause confirms the last column (`A(y_0) = A(y_1) = A(y_3) =
A(y_4) = {3, 4}`, `A(y_2) = A(y_5) = {1, 2}`): in N2's Kneser language the six missing pairs are `B, B, B′, B, B, B′` round the hexagon, `B = {3, 4}` — antipodal
hubs share theirs and swap tip and outer colour, as ANTI says.

*Sharpened at stage 4 (2026-10-03): the extra options at `y_2` (2, 1) and at `y_5` (1, 2) never occur — the tip of a neighbouring hub always enters the
hub's unit disc (FS116-Y3-NBTIP), so `y_2`'s only outer colour is 4 and `y_5`'s is 3. The statement above stays true as written (its list is of possible
outer colours with necessary conditions); it was loose, and § 4 replaces it where it is used.*

### 2.4 The tight sides (FS116-Y3-TIGHT)

At `y_0` the tip `T1` lies in `B̄(p, 1) ∩ B̄(y_1, 1)`, whose tangent cone at `y_0` is `[90°, 210°]`, and its cone contains the closed tip cone `[150°, 210°]`
(RING-GERM (i)): so `T1`'s cone ends at `210°`, and the edge it shares there with the ring tile clockwise of `y_0` — call it `R_{50}`, colour `X̄` — lies in
`B̄(y_1, 1)`. If `cl R_{50}` held `q_5 = √3·e(330°)`, it would lie in `B̄(q_5, 1)`, and the shared edge in `B̄(y_1, 1) ∩ B̄(q_5, 1) = {y_0}` (`|y_1 − q_5| = 2`,
midpoint `y_0`). So **`q_5 ∉ cl R_{50}`**. Likewise at `y_1` (`T1`'s cone starts at `210°`, inside `B̄(y_0, 1)`): **`q_1 ∉ cl R_{12}`**; at `y_3`, `y_4` with
`T2`: **`q_2 ∉ cl R_{23}`**, **`q_4 ∉ cl R_{45}`** (`data/fs116/y3/lattice.out` (b), (c): the four distances 2 with their midpoints, and the one shared endpoint
of each double tip's cone at each of its hubs; the singles share none). The ring tiles `R_{01}`, `R_{34}` over the double tips' arcs are not constrained so.

### 2.5 Controls, and where six is spent

- **The strip and the disk:** their four-colour rings carry (Q) arcs (FS116-N1 § 2.4): outside the class, silent. **FS116-Y2-SIXFRAG:** a six-colour vertex,
  outside it. **R7 (`k = 7`):** its lattice points carry six of seven colours and three Reuleaux arcs on the ring: outside it.
- **SQ9 (`k = 9`)** has a Γ-free four-colour vertex at every grid point (its boundaries are segments). Its ring about a grid vertex has **12** change points
  (`tools/fs116_y3_hex.py sq9`: the twelve crossings with the grid lines, exact; the colours on either side read at 50 digits; plant: the colouring by columns
  only, 6), not `6(2j + 1)`: **six is spent at RING-TWIST-C's L2** (two absent colours swapped by `σ`), and so is everything after.

derivation: FS116-Y3-SIX
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles
  uses only: FS116-N1-QFREE4 (four colours and no more at p); RING-TWIST-C (the ring's colours swapped by σ, an odd number of colour changes per half-open
    60° window); RING-GERM (i) (a tip at each change point); that a tile of p has diameter at most 1 and lies in B̄(p, 1); non-Siamese and simple (four tiles)
  not claimed: anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything at
    k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists
  argument: § 2.1 Exactly six change points, all hubs (FS116-Y3-SIX)
  verdict: derived
  grade: derived from: RING-TWIST-C, RING-GERM, FS116-N1-QFREE4
  minds: 1
  model: none at six colours (no Γ-free four-colour vertex is held: N2 § 2.4); SQ9 at k = 9 meets every hypothesis but six colours and has twelve change
    points — control fs116-y3-sq9
  prior art: partly: FS116-V1's V1-F5 ("exactly six change points", inventory item 30, not read here); FS114-N6-RING60's hexagon; the tile count not found — owed
  handoff: de Bruijn — with RING-TWIST-C and RING-GERM, queued behind D6's map type

derivation: FS116-Y3-TIPS
  statement: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p, and up
    to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in [30°, 210°]),
    T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°])
  uses only: FS116-Y3-SIX; RING-GERM (i); that a tip of y lies in B̄(y, 1); that the closed unit discs about antipodal hubs meet only at p; that two tiles
    adjacent at p share a non-degenerate boundary curve from p
  not claimed: anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment exists
  argument: § 2.2 The tip pattern is forced (FS116-Y3-TIPS)
  verdict: derived
  grade: derived from: FS116-Y3-SIX, RING-GERM
  minds: 1
  model: none at six colours; the lattice facts it uses are control fs116-y3-lattice
  prior art: partly: FS116-N2-HEX3 names the star with δ = 90°, 150°, 270°, −30° under a recurrence hypothesis; the forcing of the pattern not found — owed
  handoff: de Bruijn — with SIX; a relay-result for any exclusion of the Γ-free type

derivation: FS116-Y3-HUBCOL
  statement: in FS116-Y3-TIPS's labelling, each hub's colours are X, X̄, its tip's colour and a non-empty set of outer colours drawn from the list of § 2.3
    (y_0: 2, and 3 only if δ_1 = 90°; y_1: 2, and 4 only if δ_4 = −30°; y_2: 4, and 2 only if δ_2 = 210°, 1 only if δ_1 = 30°; y_3: 1, and 4 only if
    δ_3 = 270°; y_4: 1, and 3 only if δ_2 = 150°; y_5: 3, and 1 only if δ_4 = 30°, 2 only if δ_3 = 210°); when every δ is interior to its range, y_0, y_1, y_3, y_4 carry {1, 2, X, X̄} and y_2, y_5
    carry {3, 4, X, X̄}
  uses only: FS116-Y3-TIPS; FS116-N2-STAR; RING-GERM (ii)
  not claimed: that an outer colour the list allows occurs (the boundary values of δ are necessary for the extra outer colours, not sufficient);
    anything about the hubs' rings beyond their colours
  argument: § 2.3 The hub colours (FS116-Y3-HUBCOL)
  verdict: derived
  grade: derived from: FS116-Y3-TIPS, FS116-N2-STAR
  minds: 1
  model: none at six colours
  prior art: owed
  handoff: none — a relay-result for § 3 and the families

derivation: FS116-Y3-TIGHT
  statement: in FS116-Y3-TIPS's labelling, the ring tile clockwise of y_0 does not have q_5 = √3 e(330°) in its closure, the ring tile counter-clockwise
    of y_1 not q_1, the one counter-clockwise of y_3 not q_2, the one clockwise of y_4 not q_4; at y_0 and y_1 the tip T1's cone has the endpoint 210°, at
    y_3 and y_4 the tip T2's the endpoint 30°, each along an edge inside the unit disc about the double tip's other hub
  uses only: FS116-Y3-TIPS; RING-GERM (i); that a tile with a point q in its closure lies in B̄(q, 1); |y_1 − q_5| = |y_0 − q_1| = |y_4 − q_2| = |y_3 − q_4| = 2
    with midpoints y_0, y_1, y_3, y_4
  not claimed: anything about the ring tiles over the double tips' arcs (between y_0, y_1 and between y_3, y_4); that the four ring tiles named do not
    reach beyond their hubs' discs
  argument: § 2.4 The tight sides (FS116-Y3-TIGHT)
  verdict: derived
  grade: derived from: FS116-Y3-TIPS
  minds: 1
  model: none at six colours
  prior art: owed
  handoff: none — a relay-result for § 3 and the families

control: fs116-y3-lattice
  of: FS116-Y3-TIPS and FS116-Y3-TIGHT — the lattice distances and the tip cones; q_5 misplaced to √3 e(300°) is caught
  run: python3 ../tools/fs116_y3_hex.py lattice | tail -n 1
  expect: LATTICE OK
  fault: python3 ../tools/fs116_y3_hex.py lattice --plant q | tail -n 1

control: fs116-y3-sq9
  of: FS116-Y3-SIX — at k = 9 SQ9's Γ-free four-colour vertex has twelve change points; coloured by columns only, six
  run: python3 ../tools/fs116_y3_hex.py sq9
  expect: SQ9 ring about a grid vertex: 12 points on grid lines; colour changes: 12
  fault: python3 ../tools/fs116_y3_hex.py sq9 --plant stripes

## Stage 2 — SAVED

## Stage 3 — SAVED: an obstruction — the generic star dies at `√3`, and every survivor has a tight tip beside each tight lens

*Class and labels as stage 2: non-Siamese simple, six colours, `p` at the origin with a Γ-free ring, hubs `y_k = e(60k)`, tiles `T1` (colour 1, tips `y_0,
y_1`), `T3` (3, tips `y_2`), `T2` (2, tips `y_3, y_4`), `T4` (4, tips `y_5`), edges `δ_1, …, δ_4` (§ 2.2). `q_k = y_k + y_{k+1} = √3·e(60k + 30°)`; the
**lens** `L_k` is `B̄(y_k, 1) ∩ B̄(y_{k+1}, 1)` outside `B(p, 1)`, with far vertex `q_k`; `R_{k,k+1}` is the ring tile over the arc from `y_k` to `y_{k+1}`.
The lenses `L_1, L_2, L_4, L_5` — beside the single tips — are the **tight lenses**: their ring tiles meet a double tip's tight edge (FS116-Y3-TIGHT).
The **star** is generic when every `δ_i` is interior to its range; a **boundary value** of `δ_i` is an endpoint of its range, and each is an edge of `p` along
a flanking direction `60k ± 90°` of some hub, with that hub's tip on its side — the tip **tight at `p`** for that hub.*

### 3.1 Two lemmas at a hub

**FS116-Y3-NOQ.** *At a hub `y_k`, a tile adjacent at `y_k` to the ring tile `R_{k−1,k}` (clockwise of `y_k`) does not lie in `B̄(q_k, 1)`; a tile adjacent
at `y_k` to `R_{k,k+1}` (counter-clockwise) does not lie in `B̄(q_{k−1}, 1)`.* Argument: `R_{k−1,k}` holds the whole open ring arc from `y_{k−1}` to `y_k`
(off finitely many points, one tile: a crossing with one colour on both sides is a slit or a Siamese pair, both excluded), so `y_{k−1} ∈ cl R_{k−1,k}` and
`R_{k−1,k} ⊂ B̄(y_{k−1}, 1)` (diameter at most 1). Two tiles adjacent at a vertex share a non-degenerate boundary curve from it; for a tile `O` inside
`B̄(q_k, 1)` that curve would lie in `B̄(y_{k−1}, 1) ∩ B̄(q_k, 1)`, which is `{y_k}` because `|y_{k−1} − q_k| = 2` with midpoint `y_k`
(`data/fs116/y3/lens.out`). Likewise on the other side with `|y_{k+1} − q_{k−1}| = 2`. ∎ At a hub the tiles run, counter-clockwise, outer tiles – `R_{k,k+1}`
– tip – `R_{k−1,k}` (an outer tile has points outside `B̄(p, 1)`, so its cone lies in the outward closed half-plane, which `R_{k,k+1}`, the tip and
`R_{k−1,k}` leave only at the ring's tangent directions); so **the clockwise-most outer tile lies in no `B̄(q_k, 1)`, the counter-clockwise-most in no
`B̄(q_{k−1}, 1)`, and a hub with one outer tile has it inside neither.** TIGHT is the same mechanism with the double tip in the role of `O`'s neighbour:
`R_{12} ⊄ B̄(q_1, 1)` (adjacent at `y_1` to `T1 ⊂ B̄(y_0, 1)`), and likewise `R_{23} ⊄ B̄(q_2, 1)`, `R_{45} ⊄ B̄(q_4, 1)`, `R_{50} ⊄ B̄(q_5, 1)` — what its proof
shows, stronger than its statement.

**FS116-Y3-LENS.** *Let `L_k` be a tight lens and `x` a point near `q_k` inside `B(y_k, 1) ∩ B(y_{k+1}, 1)`. Every colour at `x` is a colour of `p` other
than the tips' colours of `y_k` and `y_{k+1}`; and if that colour `c` is a colour of `y_k` (of `y_{k+1}`), then `y_k`'s (`y_{k+1}`'s) `c`-tile has `q_k` in its
closure.* Argument. The tips straddle `x`: each holds `p`, at distance about `√3`, and points near its hub, at distance below 1. `R_{k,k+1}` straddles `x`: it
holds ring points near `e(60k + 30°)`, at distance `√3 − 1` from `q_k`, and (NOQ, TIGHT) a point outside `B̄(q_k, 1)`. The other ring colour's tile
`R_{k−1,k}` straddles `x`: points near `y_k` and near `y_{k−1}`, `|q_k − y_{k−1}| = 2`. A colour `c ∈ C(y_k)`: `y_k`'s `c`-tile has points near `y_k`, within
`< 1` of `x`, so a `c`-tile at `x` is that tile (non-Siamese), and it reaches `q_k` as `x → q_k`. ∎

### 3.2 The tight-lens conditions, and the generic star (FS116-Y3-TIGHTLENS)

Combine LENS with NOQ at each tight lens. The candidate outer colours (STAR: an outer colour's tile at `p` misses `B(y, 1)`, a cone condition on the `δ`s):
`O_{y_0} ⊂ {2} ∪ {3 if δ_1 = 90°}`, `O_{y_1} ⊂ {2} ∪ {4 if δ_4 = −30°}`, `O_{y_2} ⊂ {4} ∪ {2 if δ_2 = 210°} ∪ {1 if δ_1 = 30°}`, `O_{y_3} ⊂ {1} ∪ {4 if
δ_3 = 270°}`, `O_{y_4} ⊂ {1} ∪ {3 if δ_2 = 150°}`, `O_{y_5} ⊂ {3} ∪ {1 if δ_4 = 30°} ∪ {2 if δ_3 = 210°}` (FS116-Y3-HUBCOL's list).

- **`q_1`** (`y_1` tip 1, `y_2` tip 3): the colour near `q_1` in the lens is 2 or 4. *If 2:* when `2 ∈ C(y_1)` its tile reaches `q_1`, so it is not
  `y_1`'s clockwise-most outer tile and `y_1` has two outer colours, `{2, 4}`; when `2 ∉ C(y_1)`, `O_{y_1} = {4}`; either way `δ_4 = −30°`. *If 4:* when
  `4 ∈ C(y_2)`, `y_2` has two outer colours; when not, `O_{y_2} ⊂ {1, 2}`; either way `δ_1 = 30°` or `δ_2 = 210°`. **(Q1): `δ_4 = −30° ∨ δ_1 = 30° ∨ δ_2 =
  210°`.**
- **`q_2`** (`y_2` tip 3, `y_3` tip 2), colours 1 or 4: 1 forces `δ_3 = 270°` (at `y_3`, as above), 4 forces `δ_1 = 30° ∨ δ_2 = 210°` (at `y_2`).
  **(Q2): `δ_3 = 270° ∨ δ_1 = 30° ∨ δ_2 = 210°`.**
- **`q_4`** (`y_4` tip 2, `y_5` tip 4), colours 1 or 3: 1 forces `δ_2 = 150°`, 3 forces `δ_4 = 30° ∨ δ_3 = 210°`. **(Q4).**
- **`q_5`** (`y_5` tip 4, `y_0` tip 1), colours 2 or 3: 2 forces `δ_1 = 90°`, 3 forces `δ_4 = 30° ∨ δ_3 = 210°`. **(Q5).**

**Read as tightness:** (Q1) says *`T1` is tight at `p` for `y_1` (`δ_4 = −30°`) or `T3` is tight at `p` for `y_2` (`δ_1 = 30°` or `δ_2 = 210°`)* — for
each tight lens, the tip of one of its two hubs is tight at `p` for that hub. (Q1) and (Q4) share no literal, nor do (Q2) and (Q5), so **at least two edges
of `p` lie along flanking directions**. The truth table over the `3⁴ = 81` assignments (`tools/fs116_y3_hex.py lens`, a check of the hand reading, not a
search) has 26 satisfying ones, the generic star not among them, and five minimal sets of boundary values: `{δ_1 = 30°, δ_3 = 210°}`, `{δ_1 = 30°, δ_4 =
30°}` (`T1` a cusp at `p`), `{δ_2 = 210°, δ_3 = 210°}` (`T2` a cusp), `{δ_2 = 210°, δ_4 = 30°}`, and `{δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30°}` —
**the last is FS116-N2-HEX3's star**, the only minimal set in which the single tips are not tight.

*Sharpened at stage 4 (2026-10-03): the four minimal sets in which a single tip is tight are not realised — each uses an outer colour at `y_2` or `y_5`
that FS116-Y3-NBTIP rules out — and the star is HEX3's (FS116-Y3-STARFORCE). The truth table above is of (Q1)–(Q5) as written, which stay true.*

**Radius.** The argument reads a neighbourhood of each `q_k`, `|q_k| = √3`: it applies to every fragment of the class on `B̄(p, R)` with `R ≥ √3`, whose
domain is an open set containing that disc. Below `√3` nothing here applies (the neighbourhoods needed depend on the tiles' sizes near the hubs).

### 3.3 Controls, `k ≥ 7`, and what it does to the brief's question

- **Held fragments:** none has a Γ-free four-colour vertex (§ 2.5); the lemmas are silent on the strip, the disk and SIXFRAG. **R7** (`k = 7`): no change
  point. **SQ9** (`k = 9`): no hexagon of hubs (twelve change points), so no lens; **six is spent at LENS's first clause** — with six colours every colour is
  a ring colour or a colour of `p`, and with seven a third absent colour would survive near `q_k`, straddled by nothing named here.
- **The exact facts** the arguments use (`data/fs116/y3/lens.out`): the twelve distances `|y_{k∓1} − q_{k±0}| = 2` with midpoints `y_k`, `|q_k| = √3`, the
  ring point at `√3 − 1` from `q_k`. Plants: `q_1` misplaced to `√3·e(60°)` (the facts fail at `y_0, q_1`); condition (Q1) dropped (31 satisfying
  assignments and a different minimal list — the generic star still fails, at (Q4)).
- **For the brief's target:** a Γ-free four-colour vertex on a disc of radius above 2 must have a tight star of one of the five minimal kinds; **the generic
  star is excluded already at `√3`**. FS116-N2-ANTI's hypothesis (the flanking directions of two antipodal hubs inside tiles) holds in the generic star and
  can hold at a tight one only for the pair whose flanks are not edges; RECIP and HEX6 (radius above 2) can have models only among the tight stars.

derivation: FS116-Y3-NOQ
  statement: in FS116-Y3-TIPS's setting, at a hub y_k, no tile adjacent at y_k to the ring tile over the arc from y_(k−1) to y_k lies in B̄(q_k, 1), and no
    tile adjacent at y_k to the ring tile over the arc from y_k to y_(k+1) lies in B̄(q_(k−1), 1), where q_k = y_k + y_(k+1); in particular the clockwise-most
    outer tile at y_k does not have q_k in its closure, the counter-clockwise-most does not have q_(k−1), and an only outer tile has neither
  uses only: FS116-Y3-SIX (the ring arc between consecutive hubs lies in one tile, off finitely many points); that a tile has diameter at most 1; that tiles
    adjacent at a vertex share a non-degenerate boundary curve; |y_(k−1) − q_k| = |y_(k+1) − q_(k−1)| = 2 with midpoint y_k; the cyclic order of the tiles at a
    hub (RING-GERM's cones, and that an outer tile has points outside B̄(p, 1))
  not claimed: anything at change points of rings carrying arcs of Γ (there a ring tile need not reach the next change point); anything about outer tiles
    adjacent to neither ring tile
  argument: § 3.1 Two lemmas at a hub
  verdict: derived
  grade: derived from: FS116-Y3-SIX
  minds: 1
  model: none at six colours; the lattice facts are control fs116-y3-lens
  prior art: owed
  handoff: de Bruijn — with SIX and TIPS; a relay-result for any exclusion of the Γ-free type

derivation: FS116-Y3-LENS
  statement: in FS116-Y3-TIPS's labelling, for k in {1, 2, 4, 5} and every point x close enough to q_k inside B(y_k, 1) ∩ B(y_(k+1), 1), every colour at x
    is a colour of p other than the tip colours of y_k and y_(k+1); and if it is a colour of y_k (of y_(k+1)), that hub's tile of that colour has q_k in its
    closure
  uses only: FS116-Y3-TIPS; FS116-Y3-TIGHT's argument (the ring tile R_(k,k+1) does not lie in B̄(q_k, 1)); FS116-Y3-NOQ's first clause for the ring tile
    over the arc before y_k; the straddle principle; non-Siamese (a c-coloured point within 1 of a hub's c-tile belongs to it); |q_k| = √3,
    |q_k − e(60k + 30°)| = √3 − 1, |q_k − y_(k−1)| = 2
  not claimed: anything at q_0 or q_3 (beside the double tips, where the ring tile may reach the far vertex); anything at points of the lens away from q_k
  argument: § 3.1 Two lemmas at a hub
  verdict: derived
  grade: derived from: FS116-Y3-TIPS, FS116-Y3-TIGHT, FS116-Y3-NOQ
  minds: 1
  model: none at six colours
  prior art: owed
  handoff: none — a relay-result for TIGHTLENS

derivation: FS116-Y3-TIGHTLENS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring
    carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or δ_1 = 30° or
    δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single tip, the tip of one of
    its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such fragment has a generic star
  uses only: FS116-Y3-LENS; FS116-Y3-NOQ; FS116-Y3-HUBCOL's list of candidate outer colours; that the domain of a fragment on B̄(p, R), R ≥ √3, contains a
    neighbourhood of each q_k
  not claimed: that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in the
    Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
  argument: § 3.2 The tight-lens conditions, and the generic star (FS116-Y3-TIGHTLENS)
  verdict: derived
  grade: derived from: FS116-Y3-LENS, FS116-Y3-NOQ, FS116-Y3-HUBCOL
  minds: 1
  model: none at six colours (it is an obstruction); the truth table of its four conditions is control fs116-y3-lens
  prior art: owed — a search in the words of the literature's six-coloured discs (Gibbs's disk, Sirgedas's searcher, de Grey's 2018 threads) is the debt
  handoff: de Bruijn — with NOQ, LENS, TIPS and SIX, after a blind second mind; the generic star's exclusion at √3 is a relay-result for D2's case list

control: fs116-y3-lens
  of: FS116-Y3-TIGHTLENS — the truth table of (Q1)–(Q5) (with NOQ's and LENS's facts on the line above it); with (Q1) dropped the count changes
  run: python3 ../tools/fs116_y3_hex.py lens | sed -n 2p
  expect: assignments: 81; satisfying (Q1)(Q2)(Q4)(Q5): 26; the generic star satisfies them: False; fewest boundary values in a satisfying one: 2
  fault: python3 ../tools/fs116_y3_hex.py lens --plant cond | sed -n 2p

control: fs116-y3-lens-facts
  of: FS116-Y3-NOQ — the twelve distances 2 with their midpoints at the hubs; q_1 misplaced is caught
  run: python3 ../tools/fs116_y3_hex.py lens | head -n 1
  expect: lattice facts: all hold
  fault: python3 ../tools/fs116_y3_hex.py lens --plant q | head -n 1

## Stage 3 — SAVED

## Stage 4 — SAVED: the star is forced — HEX3's star, and the extra outer colour at every double-tip hub

*Class and labels as stages 2–3.*

### 4.1 A neighbour's tip enters the hub's disc (FS116-Y3-NBTIP)

The tip `t` of a hub `y_j` has, at `y_j`, every direction of the open cone of `60°` about the direction to `p` in its cone (RING-GERM (i), one tip per hub):
it has points `z_n → y_j` whose directions from `y_j` tend to `ψ_j + 180°`. For a neighbouring hub `y_{j±1}`, `y_{j±1} − y_j = e(ψ_j ± 120°)`, at `60°` from
that direction, so `|z_n − y_{j±1}|² = 1 − 2|z_n − y_j|·cos 60° + o(|z_n − y_j|) < 1` for large `n`: **`t` meets `B(y_{j±1}, 1)`** (`tools/fs116_y3_hex.py
nbtip`: the whole open cone lies inside both neighbours' open half-planes, at every hub; widened to `180°` it leaves them). By STAR an outer colour's tile at
`p` misses `B(y, 1)`, so **a neighbour's tip colour is never an outer colour** (it is the hub's own tip or missing there). For the single-tip hubs this
empties the extra options of HUBCOL: `y_2`'s neighbours are tipped by `T1` and `T2`, so **`O_{y_2} = {4}`**; `y_5`'s by `T2` and `T1`, so **`O_{y_5} = {3}`**
(each non-empty by RING-GERM (ii)). At the double-tip hubs the rule removes nothing (`y_0`'s neighbours are tipped by `T4` and by `T1`, its own tip).

### 4.2 The star (FS116-Y3-STARFORCE)

Re-run § 3.2 with these outer sets. At `q_1` the colour near `q_1` in the lens is 2 or 4; 4 would be `y_2`'s only outer tile reaching `q_1`, which NOQ
forbids; so it is 2, and (§ 3.2) `δ_4 = −30°`. At `q_2`, 4 is forbidden the same way, 1 remains, and `δ_3 = 270°`. At `q_4` and `q_5`, `y_5`'s only outer tile
(3) is forbidden, so the colours are 1 and 2, and `δ_2 = 150°`, `δ_1 = 90°`. **So in a fragment of the class on `B̄(p, √3)` the star is exactly FS116-N2-HEX3's:
`p`'s edges leave along the flanking directions `90°, 150°, 270°, 330°`, `T1` and `T2` fill the full `120°` corners of their Reuleaux triangles at `p`, `T3`
and `T4` have `60°` cones.** Moreover, at each double-tip hub the colour the lens rule needs is present: near `q_1` the colour 2 is `y_1`'s 2-tile or a
2-tile touching no hub; in the first case `y_1`'s 2-tile is not its clockwise-most outer tile (NOQ), so `y_1` has two outer tiles, 4 then 2
counter-clockwise; in the second `O_{y_1} = {4}`. Either way **4 is an outer colour of `y_1`**. Likewise **3 at `y_0`** (two outer tiles 2 then 3, or 3
alone), **4 at `y_3`** (1 then 4, or 4 alone), **3 at `y_4`** (3 then 1, or 3 alone). The truth table over the 81 assignments with the neighbour-tip rule
(`tools/fs116_y3_hex.py star`) has exactly one satisfying assignment, HEX3's, with the candidate outer colours just listed; dropped, the rule leaves 26 — the
count of § 3.2, so the program's lens rule and the hand conditions (Q1)–(Q5) agree.

**What it says.** FS116-N2-HEX3 found this star as the price of two alternate hubs recurring; here it is forced by radius `√3` alone, with no recurrence. In
it the flanking directions of `y_2` and `y_5` (`30°`, `210°`) lie inside `T1` and `T2`, so FS116-N2-ANTI's hypothesis holds for that pair, and its
conclusion is consistent with HUBCOL (`A(y_2) = A(y_5) = {1, 2}`, tip and outer colour swapped); for the pairs `(y_0, y_3)` and `(y_1, y_4)` the flanks
are edges, outside ANTI. Every Γ-free four-colour vertex on a disc of radius above 2 — the brief's target — has this star and these outer colours.

### 4.3 What was not reached (the stall), and the families

- **The construction.** The one family the derivation leaves is HEX3's star with the outer structure of § 4.2. I wrote no object by formula in it: the
  forced pieces now run from `p` to the `q_k` (radius `√3`), and beyond them to the points `2y_k` and the outer wedges between the petals, which a
  fragment on a disc of radius above 2 must also cover, only one level of the local analysis was read (at `2y_0`, by hand during this stage and not written out, with choices
  made at `q_0` and `q_5`): it closed there without contradiction, as a vertex of colours 1, 3 and 4 with the tile beside the mirror at `q_0` of colour 6. That
  reading is one mind on one branch and is not filed as a result.
- **The families tried, against the configuration's demands.** Generic star (four free edge directions): dead at `√3` (§ 3.2). Single tips tight at `p`
  (the four other minimal sets of § 3.2): dead at `√3` (§ 4.2). HEX3's star: free parameters — the shapes of the tiles beyond the forced cones, the choice
  at each double-tip hub between one and two outer tiles, and the colour of the tile at `q_0` beyond the mirror; demand — a valid fragment to radius above 2.
  Undecided.
- **The stalled form, for a fresh mind:** *a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 2 about a four-colour vertex
  `p` whose star is HEX3's — tiles `T1` (cone `[−30°, 90°]`), `T3` (`[90°, 150°]`), `T2` (`[150°, 270°]`), `T4` (`[270°, 330°]`), hubs `e(60k)` with outer
  colours as § 4.2 says — or the point inside radius 2 where every such fragment loses all six colours.* RECIP and HEX6 can have models only here.
- **Below `√3`** the generic star is neither built nor excluded; a model there would model STAR and ANTI at every antipodal pair (radius above 1 is all
  they need). Not attempted.

derivation: FS116-Y3-NBTIP
  statement: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a neighbour's
    tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3
  uses only: RING-GERM (i) and FS116-Y3-TIPS (one tip per hub, whose cone holds the open 60° cone about the direction to p); FS116-N2-STAR (an outer colour's
    tile at p misses B(y, 1)); RING-GERM (ii) (an outer colour exists); that the direction from y_j to a neighbour is at 60° from the direction to p
  not claimed: anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
  argument: § 4.1 A neighbour's tip enters the hub's disc (FS116-Y3-NBTIP)
  verdict: derived
  grade: derived from: FS116-Y3-TIPS, FS116-N2-STAR
  minds: 1
  model: none at six colours; the angle fact is control fs116-y3-nbtip
  prior art: owed
  handoff: none — a relay-result for STARFORCE

derivation: FS116-Y3-STARFORCE
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring
    carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer
    colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at
    y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1
  uses only: FS116-Y3-TIGHTLENS's argument (FS116-Y3-LENS with FS116-Y3-NOQ at the four lenses beside the single tips); FS116-Y3-NBTIP; FS116-Y3-HUBCOL's
    cone conditions for the outer colours of the double-tip hubs
  not claimed: that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
  argument: § 4.2 The star (FS116-Y3-STARFORCE)
  verdict: derived
  grade: derived from: FS116-Y3-TIGHTLENS, FS116-Y3-NBTIP, FS116-Y3-HUBCOL
  minds: 1
  model: none at six colours; the truth table is control fs116-y3-star
  prior art: partly: FS116-N2-HEX3 (one mind) derives this star from two alternate hubs recurring; its forcing by radius √3 not found — owed
  handoff: de Bruijn — with NOQ, LENS, NBTIP, TIPS and SIX, after a blind second mind; a relay-result for D2: the Γ-free type's case list is one star

control: fs116-y3-star
  of: FS116-Y3-STARFORCE — with the neighbour-tip rule, one assignment of the four edges survives the lens rule; without it, 26
  run: python3 ../tools/fs116_y3_hex.py star | head -n 1
  expect: satisfying assignments: 1
  fault: python3 ../tools/fs116_y3_hex.py star --plant nbtip | head -n 1

control: fs116-y3-nbtip
  of: FS116-Y3-NBTIP — the open 60° cone about the direction to p lies inside both neighbours' open half-planes at every hub; a 180° cone does not
  run: python3 ../tools/fs116_y3_hex.py nbtip
  expect: NBTIP angle fact (cone half-width 30): holds at every hub
  fault: python3 ../tools/fs116_y3_hex.py nbtip --plant wide

## Stage 4 — SAVED
