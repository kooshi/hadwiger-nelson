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

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).

## Fence log (standing rule 8)

- My brief fences nothing for me; it asks me to write nothing about my work where FS116-V3, FS121-V3 or FS121-V4 could read it before their verdicts. I
  write only this record, `data/fs116/y3/`, `tools/fs116_y3_*.py` and my report. The harness's start-up context held the auto-memory index (status lines,
  no proof content). I read no session transcript and no FS116-V3, FS121-V3 or FS121-V4 record. At resumption I read `git log` subjects and grepped
  `plans/FS116-close-inventory.md` for "hub" (items 30, 66, 68, 70–73: statuses and owner rulings, no verifier content).

## G87 lookout

- Stage 1: none seen as two truths in collision.

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
