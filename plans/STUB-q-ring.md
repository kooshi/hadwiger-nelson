# FS-124 — the (Q) ring: does every vertex of at least four colours whose ring carries (Q) arcs, and every vertex of five or six colours, die within an explicit radius? (stub)

> **Derived 2026-10-07 (FS124-Z1; `plans/FS124-derivation.md`, 30 entries; ledger rows 161–164).** Its eight cases pass to its successor, FS-136, the point across (`plans/STUB-covering-pairs.md`). Closed when its Lean modules pass the gate: the first is through the gate (FS124-L1), the second is being planned.

> **Opened 2026-10-07 (Kooshi's choice).** In the ranking this stub is *the unit arc: what a tight unit pair passes on*; its question for every measurable colouring is the section dated 2026-10-07 below (FS124-P1), its claim list `data/fs124/claims.md`, its inventory `plans/FS124-close-inventory.md`. The card of 2026-10-03 and the eight cases stand for maps.

> 2026-10-07 (FS132-P1): 'given MR' leaves this stub's bearing. From `[OAIMath2026]`: a palette that is a diagonal of the vertex's own labels is a (Q) arc in measure; its `two_state_impossible`, stated for every `k`, at six excludes a ring alternating between the two diagonals (FS-132's C132-DIAG, posed); its four-cycle argument (one outside label) is the template for the five-colour vertex. The class this stub is posed in waits on FS-132's card 1.

*Minted 2026-10-03 by FS-116's close, part 2 (FS116-Z2; `plans/FS116-Z2-close.md` stage 3), carrying `plans/FS116-close-inventory.md` items 40, 53, 61,
63, 67, 96–99 and 118 (CROSS's last clause), the (Q)-ring and many-colour rows of FS116-C114-LOCAL-F's case list (`plans/FS116-Z1-close.md` § 2.6), the
owed blind minds on FS116-N2-STAR, -RECIP and -ANTI, and FS114-K1's residues on rings with (Q) arcs. FS-116's successor; siblings FS-123
(`plans/STUB-qfree-ring.md`, the (Q)-free ring) and FS-125 (`plans/STUB-saturated-local.md`, the saturated class). **Solver column: in-ban** —
derivation, reading, exact checks of fragments by formula; no enumeration of maps, colourings, ring types or tip assignments (FS-116's frozen list § 9;
Kooshi: *"search for a finite graph is out. It would be huge, not feasible."*). Written for a session with no memory of FS-116: read `CLAUDE.md` § The aim
and § Counter-priors, `LEDGER.md` rows 133–138 and FS-116's rows (‹R116-a›–‹R116-d› until numbered), `plans/FS116-derivation.md` rounds 1, 3 and 4 (the
ring, the hub lemmas, the semi-hub rule), `data/fs116/claims.md` §§ 0, 10, 13 (the definitions: change point, hub, semi-hub, kinds O and T, crossed and
parallel, germs `u⁻, u⁺, v⁻, v⁺`), and `plans/FS114-derivation.md` § 3.*

## The question, in plain language

A **valid fragment** colours a disc about a point `p` with six colours by finitely many tiles near each point, bounded by segments and circular arcs (arcs
of radius exactly 1 allowed), with no two interior points of one colour at distance exactly 1. Let `p` be a vertex of at least four colours; its **ring**
is the unit circle `ω(p)`. Every valid map of the plane has such a vertex, so one explicit radius within which no fragment about one exists is the whole
six-map NO with unit arcs (C114-LOCAL-F; FS114-CV-EXISTS). FS-116 sorted vertices by what their ring carries. A ring carrying no arc of the boundary
`Γ` dies at `1 + ε` (FS116-Y4-EMPTY, held); FS-123 carries the rest of the rings with no (Q) arc. **This stub is the rest of the case list: rings carrying
(Q) arcs — arcs of `ω(p)` whose two side colours `p` itself carries — and the vertices of five and six colours, whose rings are mostly or wholly (Q)
arcs.** Every positive this project holds that reaches past `√3` has (Q) arcs on its four-colour vertices' rings (row 136), so this is where the YES
side, if there is one, lives.

What FS-116 left, case by case (`plans/FS116-Z1-close.md` § 2.6):
1. **SEMI-PAR3** (inventory items 96, 97): "in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four
   colours, no change point of the ring is a full parallel semi-hub of exactly three colours" — GAP: "the step from the bowtie's four-colour parallel
   semi-hub to three colours — removing the tile of p toward y from y (kind O), or the outer tile (kind T) — is excluded by no cone at p, u, y or v; a
   proof must read y's own ring, which carries three absent colours and no parity". A construction by formula (FS114-Y2-BOWTIE with its tip `t2` removed
   from `top`) or a reason none exists decides it.
2. **The closed change point, the disk's corner** (FS116-RING-Q's GAP; items 40, 97): a change point of two colours whose `±60°` points lie inside (Q) arcs.
   RING-Q is false below radius `≈ 1.5985` (FS116-N1-QDISK: `[Polymath2021]` Fig. 10's disk about its corner), and any exclusion on `B̄(p, 2)` must read the
   far side of `p`, in the directions `(ψ + 157.4°, ψ + 324.5°)` (FS116-Y2-DCREAD). A fragment by formula beyond radius 2 holding the configuration makes
   RING-Q false in its class.
3. **Crossed reciprocity** (FS116-RING-TRANSFER-Q's third place): whether a crossed semi-hub's placed vertex has `p` as a crossed semi-hub — the order of
   its outer tiles; and FS116-N3-CROSS's last clause ("p is a semi-hub of kind O of the ring of y"), one mind and a checking reading (item 118).
4. **The five- and six-colour vertices** (item 61): a five-colour vertex's ring has no change point and (Q) arcs over at least half of it (FS116-N2-FIVERING);
   a six-colour vertex's ring is six 60° (Q) arcs, one per tile of `p`, with outer colours constrained (FS116-N2-SIXRING). One family dies below `√3`
   (FS116-Y2-SIXOFF, Siamese pairs allowed); a fragment by formula holds `B̄(p, R)` for every `R < 3/2` (FS116-Y2-SIXFRAG, exact). De Grey and Gibbs left this
   vertex's next layer undone in 2018 (`[Polymath16threads]` [08.17]–[08.18]).
5. **The recurrence** (the structural form's last part): which (Q) ring types recur at every vertex of at least four colours they place. FS116-N2's
   recognition, one mind: the transfer at a hub is a homomorphism into the Kneser graph `KG(6, 2)` — a hub carries `p`'s two absent colours and misses two of
   `p`'s four, read off the tiles of `p` in the flanking directions — and around one four-colour vertex the placed missing pairs live in `KG(4, 2)`.
6. **FS114-K1's residues on rings with (Q) arcs**: N7-HUBQ's step (a tip at a change point whose `±60°` germs lie on (Q) arcs), the (Q)-pinwheel's residual
   (NB6-QSTART), the pinwheel's E1 residues and E2's survivor S6, the wrap (a pocket tile wrapping round a blade's ring end), and the Reuleaux `(2, 1, 1, 0)`
   past `√3` on rings with (Q) arcs (`plans/FS114-derivation.md` FS114-K1).
7. **The Siamese and non-simple classes** of everything above, last (G86). FS116-N1-GERM-S (held) and FS116-RING-Q-PRIME-S give the placing step there.
8. **The exclusion's two other forms, not worked at FS-116** (`data/fs116/claims.md` § 6): **DISC-F**, "there are an explicit radius `R` and a derivation
   that no valid fragment exists on any closed disc of radius `R`" (its *not claimed* line: any `R` at most the disk's `≈ 2.1246`), and **LOCAL-DENSE**,
   "there is an explicit `r ≥ 3` such that every valid fragment on a closed disc `B̄(x, r)` has, in `B̄(x, 3)`, a vertex of at least four colours or a vertex
   with a repeated colour" — with LOCAL-DENSE, C114-LOCAL-F and DISC-F are one question (`plans/FS116-local-exclusion.md` § 3.6).

## The question (Poros, 2026-10-03)

*FS129-P1's re-rank put this stub at rank 1, the milestone after the Lean backlog (`plans/POROS-2026-10-03-fs129-rerank.md` § 3). The card is that
record's rank-1 card, copied by script.*

### The card

question: what-does-a-q-ring-pass-on
  evidence: every held positive past `√3` has (Q) arcs on its four-colour rings (row 136), and in the non-Siamese class a ring with no (Q) arc dies at
    `1 + ε` (FS129-SR3-QFREE-NS); the placing rule (FS116-RING-GERM, -N3-SEMI) puts a four-colour vertex at every change point off (Q) arcs, so four-colour
    vertices propagate along the unit triangular lattice until a (Q) arc intervenes (G91); the held positives stop at named radii — FS114-Y2-BOWTIE at `√3`,
    the disk extended about a corner above `φ`, the capped strip's family Q1 open below `φ²/√2`, FS116-Y2-SIXFRAG below `3/2` (`plans/STUB-q-ring.md` ll. 60–62,
    126–129); FS-124's eight cases (ll. 25–50) are listed by ring type, and FS116-N2 reads the transfer at a hub as a homomorphism into `KG(6, 2)` (case 5)
  expected: that FS-124 is eight cases, worked one at a time as FS-116 worked its ring types
  ask: What does a four-colour vertex's (Q) ring pass to the four-colour vertices its change points place — and is that quantity conserved, so that the placed skeleton either recurs at every radius or must close within one?
  if a conserved quantity exists: cases 1, 3 and 5 are one statement about the skeleton; the held positives are read as finite pieces of it, the radius where each stops names the skeleton's obstruction, and FS-124 opens on that obstruction
  if none exists (the placed vertex's ring type is free beyond the absent pair): the cases are worked apart, SEMI-PAR3 (case 1) and the strip's family Q1 first, and the recurrence leaves the list as a reading
  answered by: derivation — Ephodos, FS-124's opening: first the held positives read by formula (their placements, exact), then the general statement
  cost: a reading round on four held objects, then one derivation round
  hunch: the type is conserved in the strip and in SIXFRAG and changes only at the disk's corner (placements-conserve-the-type, 0.4)
  falsifier: a held positive in which a placed four-colour vertex's ring has a different number of (Q) arcs from the placing vertex's, away from the disk's corner
  rank: 1

### Existence form

Is there a valid six-coloured fragment, non-Siamese, on a closed disc of radius above `φ²/√2` about a vertex `p` of at least four colours whose ring
carries a (Q) arc — or about a vertex of five or six colours? Its negation at one explicit radius, with FS-123's Siamese half, is C114-LOCAL-F; a family of
such fragments on discs of every radius gives `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM).

### Structural form

In every valid six-coloured fragment, Siamese pairs allowed, about a vertex `p` of at least four colours whose ring carries (Q) arcs: what does `p` hand to
each four-colour vertex its ring's change points place — its absent pair, the perfect matching of the six colours into that pair and the two pairs the
placed vertex misses (FS116-N2-STAR; FS116-N2's `KG(6, 2)` reading), the positions of its (Q) arcs — and which of these is invariant along every chain of
placements? The question is about every solution and cannot be answered without naming the quantity each four-colour vertex carries and passes on. Its
answer either makes the placed skeleton an image of the unit triangular lattice that must recur at every radius (the YES side's shape; the capped strip's
row of midline vertices is one finite piece), or names where every chain of placements must close (the exclusion's shape).

## The question (Poros, 2026-10-07) — for every measurable colouring proper at almost every unit pair

*FS124-P1 (`plans/POROS-2026-10-07-fs124-question.md`; brief `data/fs124/briefs/FS124-P1-question.md`). Posed after Kooshi chose this
milestone (2026-10-07) and after FS-132's three rounds. The card of 2026-10-03 above stands for maps; this section is the question in
the class the problem lives in since `[OAIMath2026]`. Nothing here is derived: every statement is posed, with what would settle it.*

**The class.** A *weak `k`-colouring* of an open set `U` of the plane is a measurable map `c` from `U` to `k` labels with
`c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U` (the wording of
`plans/FS132-derivation.md`'s entries). A label is *present* at a point when the point lies in the closed essential support of its class.

**The object, stated once.** Let `c` be a weak colouring of `U`, `q` and `z` two points with `|q − z| = 1` and `z` in `U`, and `a ≠ b` two
labels. The pair `(q, z)` is **tight for `(a, b)`** when there is `ρ > 0` with `B(z, ρ) ⊂ U` such that almost every point `w` of
`B(z, ρ)` with `|w − q| < 1` has the label `a` and almost every point `w` of `B(z, ρ)` with `|w − q| > 1` has the label `b`. `q` is the
pair's **centre**, `z` its **far end**, `a` its inside label, `b` its outside label; the two points `q + R^{±1}(z − q)`, `R` the
rotation by `π/3`, are its **rhombus completions** (each is at distance 1 from both `q` and `z`). The pair is **of kind both** when `a`
and `b` are both present at `q`. In a map a boundary arc of the unit circle about `q` is a tight pair at each of its interior points,
with no dictionary: a tile is an open set of one label. The map class's (Q) arc is a tight pair of kind both whose centre carries at
least four colours; FS-132's two appearances, (α) and (β), are a tight pair read from its centre and from its far end
(`plans/POROS-2026-10-07-fs124-question.md` § 1.2).

### The card

question: what-does-a-tight-unit-pair-pass-on
  evidence: `plans/FS132-derivation.md` § 12 — every exclusion of FS-132 is arc-free, and the three entries that reach the object
    conclude at it or produce it (C132-PLACED-RING, C132-COMP-SHARP as stated, C132-LENS); C132-M-EXCL (its § 1) forces the centre's own
    labels onto the ring at every witnessed four-cycle; `LEDGER.md` row 135, "a close complementary pair … sits on a unit rhombus with
    four-colour corners (FS-110's T2, forced)", and row 136, each printed positive "stops at the unsaved second common unit point of a
    close complementary pair saved at its first"; control `kept-model` (that file, l. 354): labels 012, 1234, 012, 0145, 012, 0235,
    interfaces-of-x=3 on-unit-circles-about=[1, 3, 5] — one shape in all 192 models, a three-label centre with three complementary
    partners, each pair saved at both common unit points
  expected: that the unit arc is the hard case — the one exception each exclusion leaves, to be excluded next at an explicit radius, ring type by ring type
  ask: When near one end of a unit pair one label fills the inside of the unit circle about the other end and another label the outside, what must a weak six-colouring carry at the two rhombus completions, and does that recur or run out?
  if it recurs (a completion is again an end of tight pairs, its labels fixed by the pair's): the tight pairs of a six-colouring span
    a labelled piece of the unit triangular lattice; FS-124 becomes one question about that labelled skeleton at every radius — the YES
    side grows the kept shape along it, the NO side looks for the lattice point with no label set left — and the cases 1, 3, 4 and 5
    above are its local rules
  if it runs out (some completion, or a point a bounded number of unit steps on, is left no label): that distance is the explicit
    radius, the exclusion holds for every weak six-colouring with a tight pair of the kind named, and what remains for seven is only
    that every six-colouring has such a pair
  if nothing is forced beyond the first step (the completions lose the pair's two labels and are otherwise free): tight pairs are not
    a skeleton; the milestone is the case list after all, worked case by case in this section's grammar, SEMI-PAR3 and the capped
    strip's family first
  answered by: derivation — Ephodos, FS-124's opening job and its first round, on the first claims below
  cost: an opening job; five first claims of a stage or less each; then one round on the skeleton
  hunch: it recurs at first order and the count bites at the centre — a four-label point cannot be the centre of tight pairs at all
    six points of a 60° orbit of its ring, so a skeleton that saves every pair twice needs five-label centres (C124-SIX; 0.5 that the
    card's first branch is the one that occurs)
  falsifier: a weak six-colouring or a held fragment with a tight pair one of whose rhombus completions has a label of the pair
    present; or a four-label point of a held object that centres six such pairs
  rank: 1

### Existence form

Is there, for every `R > 0`, a weak measurable six-colouring of the open disc of radius `R`? By C124-RADIUS below (posed) a yes is
`χ(ℝ²) = 6` and a no at one radius is `χ(ℝ²) = 7`: the existence form needs no vertex, no seed and no map. Its form at the object: is
there a weak six-colouring of an open set containing the closed disc of radius `r` about the centre of a tight pair of kind both, for
some `r` above `φ²/√2`? Held, each a map: every disc of radius below `φ²/√2` about a four-colour vertex of the capped strip (row 138);
`φ` about a corner of the disk (row 136); below `3/2` about a six-colour vertex (FS116-Y2-SIXFRAG); nothing past `φ²/√2`. G83's
killing test is this form's yes.

### Structural form

In **every** weak measurable six-colouring of an open set, and for every tight pair `(q, z)` in it: which labels are present at `q`, at
`z` and at the two rhombus completions, and in which directions at each; which unit pairs through those four points are then tight, and
for which labels; and is there a datum, defined at a point from the tight pairs through it, that every colouring carries from `q` to
each point it forces to be an end of a tight pair? The question is about every solution in the widest class where it makes sense — it
is asked at every `k`, and six enters only where a count is spent — and it cannot be answered without naming what a point carries: the
candidate is the first-order datum (for each label, the set of directions at the point in which it is present, and for each unit pair
through the point and each label present at both ends whether the label lies between the two ends or apart). Its answer is either a
rule that reproduces the datum along the unit triangular lattice (the YES side's shape; R7 is the inhabitant at seven, every boundary
"a unit arc centred at a lattice point that carries both its side colours"), or a count that fails at a named lattice step (the NO's
shape; row 136's stop — "the unsaved second common unit point" — is the instance held for maps).

### What each answer gives

| answer | toward six | toward seven |
|---|---|---|
| C124-RADIUS derived | fragments at every radius suffice in the measurable class: a family of weak six-colourings of discs, of any regularity, is `χ(ℝ²) = 6` | seven is a statement about one disc: no data at a point is needed to *state* the NO |
| the datum recurs, and a consistent labelled skeleton exists at every radius | the first object to build on that is not a list of fragments: fill its cells (the second-order problem, where every held kill is a straddle) | the NO is then not a first-order count; it must be a straddle or a second-order statement on a named cell |
| the datum recurs, and no consistent skeleton exists beyond some radius | a six-colouring's tight pairs are confined below that radius about every rich point: with C132-M-EXCL, no witnessed four-cycle survives it | an exclusion at an explicit radius for every weak six-colouring with such a point; with a rich point in every colouring (not this milestone's: FS-127, FS-128) it is `χ(ℝ²) = 7` |
| it runs out at a bounded number of steps | — | the same, shorter |
| nothing recurs | the YES side has no skeleton and builds fragment by fragment | the case list of 2026-10-03, case by case, in this section's grammar |
| C124-SIX refuted by an object | a four-label point centring six tight pairs: the honeycomb closes at four labels, and the kept shape is worth a search to radius 2 at once | — |

### The first claims a deriver takes

*Each is a statement, with its smallest form, its control and the side it would move. Each is posed in the grammar of C132-SHADOW —
open sets with one label almost everywhere — so a held map is an instance of every hypothesis and a control needs no dictionary
(FS-134's fact F2 is not on this milestone's path). None may be met by a margin: every hypothesis names a tight pair, and a colouring
with a margin has none. Order: as listed.*

- **C124-RADIUS (the YES side's clause; C132-RADIUS re-posed as two statements).** *(up)* For every integer `k ≥ 1`: if for every
  `R > 0` the open disc of radius `R` about the origin has a weak measurable `k`-colouring, then every finite unit-distance graph in the
  plane has a proper `k`-colouring, and `χ(ℝ²) ≤ k`. *(down)* If `χ(ℝ²) ≤ 6`, every open disc has a weak measurable six-colouring.
  *Smallest form of (up)*: one finite unit-distance graph of diameter `D`, one disc of radius above `D`: among the rigid motions
  carrying the graph into the disc, those making an edge monochromatic form a null set. *Uses expected*: for (up), the argument of this
  library's N-EASY on a disc, and de Bruijn–Erdős; for (down), the declared outside theorem `Outside.OAI158.proper_to_borel_weak` and
  restriction. *Controls*: at `k = 7` both hold with the hexagonal colouring; at `k = 5` (up) must fire — with `[OAIMath2026]` Thm 1.4
  it gives a radius at which no disc has a weak five-colouring, a statement not in the release. *Side*: YES for (up); with (down) and
  `χ(ℝ²) ∈ {6, 7}`, `χ(ℝ²) = 7` iff some disc has no weak six-colouring.
- **C124-CENTRE (no side: the object's first property, at every `k`).** Let `c` be a weak `k`-colouring of an open set `U`, `q` and
  `z` points of `U` with `|q − z| = 1`, and `(q, z)` tight for `(a, b)`. Then there is `η > 0` such that almost every point `w` of
  `B(q, η)` with `|w − z| > 1` has a label other than `a`, and almost every point `w` of `B(q, η)` with `|w − z| < 1` has a label other
  than `b`. *Smallest form*: one of the two sentences — it is C132-SHADOW (`plans/FS132-derivation.md` § 2) with `p = q`, `p′ = z`,
  the open piece on one side of the arc and `v` radial. *Controls*: it must hold, visibly and not vacuously, at the centre of every
  held unit arc read from the fragment's own tiles — the capped strip's midline vertices, the corners of the disk's pentagon, fragment
  T2, the bowtie fragment, the kept model's three four-label points, and R7 at seven; the plant moves one arc's centre by `0.01` in the
  checker's input, and the check must then fail. *Side*: none; it is why a tight pair's centre is never a margin point.
- **C124-COMPLETION (decides between: the first thing a tight pair passes on, at every `k`).** Let `c` be a weak `k`-colouring of
  `U`, `(q, z)` tight for `(a, b)`, and `w` a rhombus completion of the pair lying in `U`. Then there is `η > 0` such that almost every
  point of `B(w, η)` has a label other than `a` and other than `b`. *Smallest form*: one label, one side of the unit circle about
  `z` near `w` — C132-SHADOW with `p = w`, `p′ = z`, the half-disc of `a` at `z`, and a direction `v` in it with `v·(z − w) > 0`;
  then one with `v·(z − w) < 0`. *Controls*: the kept model (pair `(y_1, x)`, completions `y_0`, `y_2`, whose labels 012 hold neither
  label of the pair); fragment T2; R7 at seven. It must not fire where the pair is not tight: the hexagonal seven-colouring at
  circumradius `1/2`, where a vertex's unit circle passes through three vertices and no edge lies on it. *Side*: both — it is the rule
  the skeleton of the card's first branch is made of, and the exclusion's first step.
- **C124-KIND (a calibration: is "of kind both" a property or a hypothesis?).** There is a weak measurable seven-colouring of the
  plane, by formula, with a tight pair `(q, z)` for `(a, b)` at which neither `a` nor `b` is present at `q`. *Smallest form*: the
  hexagonal seven-colouring at circumradius `2/5` with one straight edge replaced, inside its margin, by an arc of the unit circle
  about a point whose neighbourhood carries neither tile's label; an exact check of the two margins. *Control*: the same arc at
  circumradius `1/2` must be refused by the check. *Side*: none; if TRUE, property (Q) is not a consequence of tightness, every
  NO-side statement below names the kind it needs, and what forces the kind at six is a claim that spends six.
- **C124-SIX (decides between: the first statement on the arc's side that reads no ring label).** Let `k ≥ 4`, `U` an open set
  containing the closed unit disc about `q`, `c` a weak `k`-colouring of `U`, `ψ` an angle, `z_j = q + e(ψ + jπ/3)` for `j = 0, …, 5`,
  and `a, b, a′, b′` four distinct labels such that for `j = 0, 2, 4` the pair `(q, z_j)` is tight for `(a, b)` or for `(b, a)`, and
  for `j = 1, 3, 5` the pair `(q, z_j)` is tight for `(a′, b′)` or for `(b′, a′)`. Then a label other than `a, b, a′, b′` is present at
  `q`. *Smallest form*: three pairs — if `(q, z_0)`, `(q, z_2)`, `(q, z_4)` are tight for `(a, b)` or `(b, a)`, then near `q` almost
  every point of label `a` lies in the intersection of the closed unit discs about the `z_j` at which `a` is the inside label and of
  the complements of the open unit discs about the others, a set that is `{q}` when the three agree and has angle `π/3` at `q` when
  they do not. *Control*: `tools/fs124_p1_cones.py` (the count: `equal-signs=[0, 0] mixed-signs-widths=[60]
  most-covered-by-four-labels=240 of 360`; `--fault` exits 1); it must not fire on the kept model, whose four-label points centre
  tight pairs at three consecutive ring points only; at SIXFRAG's six-colour vertex and at R7's vertices, where the pairs are not of
  this two-pair pattern and the statement does not apply, the smallest form's confinement must be seen to hold label by label.
  *Side*: both — a skeleton that saves every complementary pair at both common unit points has five-label centres (case 4
  above), and a four-label centre is excluded on its closed unit disc under the stated pairs.
- **C124-HALF (the NO side: row 135's rhombus in measure, first half; C132-ARC with its sides named).** In the setting of
  C132-COMP-SHARP (`plans/FS132-derivation.md` § 4), suppose exactly one of the six sets, `K_0`, a set of `x` with labels `t_0, t_1`, is
  contained in the unit circle about the common unit point `w`, and at least two of the three sets of `y` have a point strictly inside
  the unit circle about `w`. Then, after exchanging the names `t_0, t_1` if need be, there is `η > 0` such that almost every point of `B(w, η)` outside
  the unit circle about `y` has the label `t_1` if it lies inside the unit circle about `x` and the label `t_0` if it lies outside it.
  *Smallest form*: `x`'s two other sets are blocked on opposite sides of the unit circle about `w` (else a quadrant at `w` has no
  label left: C132-CROSS). *Second statement (two sets)*: if exactly `K_0` and one set `K′_0` of `y`, with labels `t′_0, t′_1`, are contained in
  the unit circle about `w`, `x`'s two other sets have points strictly on opposite sides of that circle, and `y`'s two other sets
  likewise, then almost every point near `w` has one of the four labels `t_0, t_1, t′_0, t′_1`. *Controls*: no held object meets the
  first statement's hypothesis — in fragment T2 three sets lie on that circle, in the kept model two — so it may hold of an empty
  class at six, and its entry says so; the second statement must hold at the kept model's `w = y_1` (labels 1234: the two third
  labels absent) once its opposite-sides hypothesis is read off the model. *Side*: NO — it turns C132-COMP-SHARP's residue from a void into a tight
  pair on one side, to which C124-CENTRE and C124-COMPLETION then apply. *Not asked here*: that a label of `y` is present at `w` —
  the map class's "four-colour corners", forced there (row 135) and open in measure; it is the first thing the skeleton round asks.

**Which side each is on.** The YES side's: C124-RADIUS (up). The NO side's: C124-HALF, and C124-SIX read as an exclusion on a closed
unit disc. Deciding between: C124-COMPLETION, C124-SIX. No side: C124-CENTRE, C124-KIND, C124-RADIUS (down).

**What to carry over from the map class first, and how.** In this order: row 138's cone form ("every tile's cone and colour is pinned
by the half-planes facing the edges' centres") — it is C124-CENTRE, already carried as C132-SHADOW; row 135's rhombus lemma
(FS112-N3-COR3) — C124-HALF, then the open "corner" statement; row 136's count (FS112's FORCE: a three-colour vertex "has at most
three close complementary partners, at rhombus completions of its unit-arc centres") — through C124-COMPLETION; then the placing rule
(FS116-N3-SEMI), whose second alternative is a tight pair read from its far end. Each is carried by re-reading its argument at the
class it reads (G92) and restating it over open one-label pieces; **none needs FS-134's dictionary fact**, which serves the other
direction — reading a palette-stated entry (C132-M-ORBIT, C132-M-EXCL) at a map vertex. A map-class statement whose argument reads a
tile as one connected piece of diameter at most 1 (FS116-V6's V6-HUBS is the known one, C132-RUN-EMPTY) does not carry over this way,
and says so.

**Carried here from FS-132, and where each now sits.** C132-RADIUS is C124-RADIUS. C132-ARC is C124-HALF. C132-PLACED's open line —
whether a pair containing a label of the centre's triple is a witnessed edge at the placed point — is not a first claim: C124-CENTRE
and C124-COMPLETION, applied to the two tight pairs C132-PLACED-RING produces at the placed point, say what its inner wedges may hold,
and the line is re-read after them.

### Registered expectations (Poros, 2026-10-07, before any derivation of these)

C124-RADIUS (up) derived as posed 0.90; (down) 0.92. C124-CENTRE derived as posed 0.92. C124-COMPLETION derived as posed 0.85.
C124-KIND true by formula 0.80. C124-SIX derived as posed 0.70, restated at its wording 0.25, refuted by an object 0.05. C124-HALF
derived as posed 0.65. The card: recurs 0.50, runs out 0.12, nothing forced beyond the first step 0.38. An exclusion at an explicit
radius, in measure, for every weak six-colouring with a tight pair of a named kind, within this milestone: 0.10. A six-coloured object
past `φ²/√2` about a tight pair's centre, by formula or search, within this milestone: 0.12. Six against seven decided by this
milestone: 0.03.

## The question (Poros, 2026-10-07, after the first round) — the save: a close complementary pair and its common unit points

*FS124-P2 (`plans/POROS-2026-10-07-fs124-round1.md`; brief `data/fs124/briefs/FS124-P2-round-one.md`). Posed after FS124-E1 brought the
six first claims of the section above to verdicts (`plans/FS124-E1-derivation.md`, sixteen entries, each derived, one mind). The two
cards above stand; the card of this morning is answered on its third branch — for one tight pair, at first order, nothing is forced
beyond the first step, at any number of labels. Nothing in this section is derived: every statement is posed, or read from a held
object by sample ([tools], one mind, `data/fs124/p2/centre_read.py`), and says which.*

**Why the unit changes.** A tight pair is not a cause. On both held six-coloured maps it is an effect, with one cause: every centre
of unit arcs inside FS-112's strip and disk is a point at distance 1 from two three-label points whose label triples are
complementary and which are less than 2 apart, with exactly one edge of each of the two on the centre's unit circle (94 of 94 such
points; the centre's four labels are those of the two edges and its absent pair the two third labels in 91 of 91 off the cut), and
no such point inside either object fails to be a centre (`unsaved_check.py`). The number six is spent there: two disjoint triples
are all six labels, so a point one unit from both has no label left unless a boundary at one of them runs along its unit circle
(C132-COMP-SHARP, `plans/FS132-derivation.md` § 4, derived, one mind). The tight seven-colouring R7 has no three-label point at all —
its only points of more than two labels are lattice points, with six — and so survives every statement below with nothing to check.

**Definitions, stated once.** `c` is a weak six-colouring of an open set `U` (the class of the section above). A **three-piece
point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of three connected open sets, each with `x`
in its closure and one label almost everywhere, the three labels distinct; its **edges** are the three common boundaries of two of
the pieces near `x`. A **close complementary pair** is two three-piece points `x`, `y` with `0 < |x − y| < 2` whose six labels are
distinct. Its **common unit points** are the two points `w` with `|w − x| = |w − y| = 1`. A common unit point `w` in `U` is **saved
by `x`** when some edge of `x` contains an arc of the unit circle about `w` with an end at `x`; the **pattern** at `w` is the pair
(number of such edges of `x`, number of such edges of `y`). A map's vertex of three tiles is a three-piece point with no dictionary.

### The card

question: what-does-a-save-cost
  evidence: `data/fs124/p2/centre_read.py rhombi` — strip "three-label-ends=40 close-complementary-pairs=54 ends-in-some-pair=40",
    "(1, 1):74", "71 of 74"; disk "(1, 1):20", "20 of 20"; `data/fs124/p2/unsaved_check.py` — no common unit point that is not a
    centre lies inside either object; `plans/FS132-derivation.md` l. 742, C132-COMP-SHARP: "one of the six sets … is contained in the
    unit circle about w"; `plans/FS124-E1-derivation.md` l. 524, "No held object meets C124-HALF's hypothesis", and l. 536,
    C124-HALF-TWO's model "owed"
  expected: that after one tight pair the unit is the centre with all its tight arcs, and that a count on six is spent at the centre
  ask: When a close complementary pair is saved at a common unit point, must one edge of each member lie on its unit circle — and what does a weak six-colouring then carry there and at the second common unit point?
  if one edge of each member is forced: a saved point's four labels and absent pair are read off the pair (C124-HALF-TWO), every
    tight arc of kind both is half of a save, and the strip's top edge is closed to every colouring that keeps its two central rows;
    the YES side must change the rows, and the NO side has a rigid labelled incidence of pairs and points to count on
  if a save by one member alone exists (an object on a neighbourhood of the four points): six has a second kind of centre — a point
    that is centre and far end of the same arc's partner, as R7's lattice points are at seven — and it is the only kind the strip's
    top edge leaves room for; a third row above the strip by formula is then worth a design and a search at once
  if neither is decided by first-order tools: the pattern is read on the five held objects not yet read and asked of the Searcher's
    wedge family as a finite question, and the round's product is the datum a pair carries between its two common unit points
  answered by: derivation — Ephodos, FS-124's second round, on the first claims below
  cost: one reading round on five held objects; then four claims of a stage or less each
  hunch: one edge of each member is not forced — a save by one member is consistent with every first-order statement held, and
    nobody has built one (an object on a neighbourhood of the rhombus 0.45; excluded 0.2)
  falsifier: a derivation that in C132-COMP-SHARP's setting an edge of each member lies on the unit circle about every common unit
    point in the set; or, among the five unread held objects, a common unit point saved by one member alone
  rank: 1

### Existence form

Is there a weak measurable six-colouring of an open set containing a close complementary pair of three-piece points and both of its
common unit points, in which one of the two is saved by one member alone? Its large form is the section above's and stands: for
every `R > 0`, a weak six-colouring of the open disc of radius `R` — by C124-RADIUS (derived, one mind) a yes is `χ(ℝ²) = 6` and a
no at one radius is `χ(ℝ²) = 7`. Held: saves by both members at every centre of the strip and the disk; no save by one member
anywhere read; nothing above the strip's top edge `|y| = √15/4 + √3/2` or outside the disk.

### Structural form

In **every** weak measurable six-colouring of an open set, for every close complementary pair of three-piece points in it and every
common unit point of the pair in the set: which edges of which member lie on the unit circle about the point; which labels are
present there, and in which of the four regions cut by the unit circles about the two members; and what does the pattern at one
common unit point fix at the other? The question is about every solution in the widest class where a pair makes sense, and it
cannot be answered without naming what a pair carries from one of its common unit points to the other: the candidate is the pattern
together with a cyclic order of the six labels in which the pairs of the two points alternate (C124-SECOND below; on the strip the
order is `P, O, G, R, B, M`). It is not the existence form reworded: that asks for one object with one pattern. **Not asked here, and
said in every claim**: that a weak six-colouring has a three-piece point, or a close complementary pair — the second is FS-122's
question (the forced pair), the first FS-127's and FS-128's.

### What each answer gives

| answer | toward six | toward seven |
|---|---|---|
| C124-FORCED derived | every close complementary pair in a six-colouring of a region is paid for at each common unit point in the region by a boundary on a unit circle: what a construction must supply, pair by pair | the first statement of this milestone that holds at six and fails at seven; with a close complementary pair in every colouring (FS-122, not asked here) the tight pair is forced |
| one edge of each member is forced | the strip cannot be continued upward with its two rows kept; the next object changes the rows | every save is a four-label centre whose labels the pair fixes: a labelled incidence on which a count over a region can be posed |
| a save by one member exists | the shape of a third row; a design by formula, then a search | a second kind of centre to exclude or to count; C124-HALF stops being a statement over an empty class |
| C124-EDGE holds | the only open continuation above the strip is named | nothing beyond the strip's family (G21) |
| C124-SECOND derived | a pair's two saves use different edges at each member: each member's three edges are spent as one, one, and one left | the datum on which "does it close up" is asked; no exclusion alone |
| some held object has a tight arc of kind both that is no edge of a save | the frame of this section is wrong for that object, and the unit is re-posed from it | — |

### The first claims a deriver takes

*Order: as listed. Kinds: **reading** (no count), **spends six** (holds at six and fails at seven, the witness named), **per class**
(true at every number of labels). Controls are on objects with no margin; R7 survives each claim that spends six because it has no
three-piece point, and that is said once here.*

- **C124-READ-SAVES (a reading; first).** On every held six-coloured object — FS-112's strip and disk (read here by sample),
  FS-114's capped strip with its caps, fragment T2, the bowtie fragment, FS116-Y2-SIXFRAG, and the Searcher's kept model — list
  every close complementary pair of three-piece points and each of its common unit points inside the object, with: the pattern; for
  pattern (1, 1), C124-HALF-TWO's hypothesis read whole (each member's two other edges with points strictly on opposite sides of the
  unit circle about the point); the labels present at the point. *Statement to verify*: at every such point the pattern is (1, 1),
  that hypothesis holds, and the labels present are exactly the four labels of the two edges. Also: every tight arc of kind both of
  each object, and whether it is an edge of some save. *Controls*: the plant moves the point by 0.01 and the pattern must read
  (0, 0); R7 must return no pair. *Side*: none. It decides whether C124-HALF-TWO is the law of every held centre, whether any held
  object has a save by one member (the section above records "in fragment T2 three sets lie on that circle"), and whether a
  six-label centre (SIXFRAG's) is a saved point at all.
- **C124-FORCED (spends six).** Let `c` be a weak six-colouring of `U`, `(x, y)` a close complementary pair of three-piece points
  and `w` a common unit point of the pair lying in `U`. Then `w` is saved by `x` or by `y`; and for every interior point `z` of the
  arc so obtained the pair `(w, z)` is tight for the two labels of that edge, in one order along the arc. *Smallest form*:
  C132-COMP-SHARP applied to the six initial pieces of the edges of length `1/n`; one edge serves for infinitely many `n`, and an
  initial piece contained in a circle is an arc of it. *Controls*: the 94 points of the strip and the disk; **fails at seven** on
  the hexagonal seven-colouring at circumradius `2/5` — two vertices with disjoint label triples less than 2 apart and a common unit
  point interior to a tile, to be exhibited by formula. *Side*: both. It is the answer to the deriver's question as far as anything
  held reaches: at six a tight pair is forced one unit from a three-piece point that has a close complementary partner.
- **C124-ONE-MEMBER (spends six; decides the card).** In the setting of C124-FORCED suppose exactly one of the six edges, an edge
  of `x` with labels `t_0, t_1`, contains an arc of the unit circle about `w` at its member. *Derive* what C124-HALF then gives in
  this grammar — after exchanging the names if need be, near `w` and outside the unit circle about `y`, the label `t_1` inside the
  unit circle about `x` and `t_0` outside it — and its consequence: `(x, w′)` is tight for `(t_1, t_0)` for `w′` on that side of `w`,
  `(w, z)` is tight for `(t_1, t_0)` along the edge, so one label lies inside both circles and each of `x`, `w` is a centre of an arc
  through the other. *Then decide*: a weak six-colouring of an open set containing `x`, `y` and `w` with this pattern, by formula
  with an exact check — or the step at which none exists. *Smallest form*: which labels may be present near `w` inside the unit
  circle about `y`, given the sides of `y`'s three edges. *Controls*: the relation "each of two points one unit apart is the centre
  of an arc through the other, one label inside both" is R7's between adjacent lattice points (label `0` between `(0, 0)` and
  `(1, 0)`), at seven and with no pair; no held six-coloured object is known to have it (C124-READ-SAVES says). *Side*: YES if built;
  NO if excluded — then every save is by both members and C124-HALF is a statement over an empty class.
- **C124-EDGE (spends six, through C124-FORCED; a computation by formula on one held object).** On FS-112's strip, let `w` be a
  point of the top edge `y = √15/4 + √3/2` that is a common unit point of a close complementary pair of the strip's three-piece
  points. Then the member of the pair on the line `y = √3/2` has no edge free for the unit circle about `w`: its three edges lie on
  the unit circles about two midline vertices and on a vertical wall. Hence a weak six-colouring of a neighbourhood of the closed
  strip that agrees with the strip on `|y| ≤ √15/4` saves no such `w` by both members. *Smallest form*: `w = (1/4, √15/4 + √3/2)`
  with the pairs `(−1/4, √15/4)`, `(1/2, √3/2)` and `(0, √3/2)`, `(3/4, √15/4)`. *Control*: the same computation at the midline
  vertices must return the 74 saves read. *Side*: toward six it names the one continuation left open, a save by the upper member's
  upward edge alone (C124-ONE-MEMBER's pattern); toward seven nothing beyond this family.
- **C124-SECOND (spends six; the datum a pair carries).** In the setting of C124-FORCED let both common unit points `w`, `w′` lie
  in `U`, each with pattern (1, 1). Then the edge of `x` on the unit circle about `w` and its edge on the one about `w′` are
  different edges, likewise for `y`; with C124-HALF-TWO's hypothesis at both, the label sets at `w` and at `w′` have exactly two
  labels in common, one of each member, their absent pairs are disjoint, and the six labels have a cyclic order in which the three
  pairs read at `w` (the two edges, the absent pair) and the three read at `w′` alternate. *Smallest form*: two unit circles through
  `x` cross there, so no arc ending at `x` lies on both. *Control*: the strip's 20 pairs with both common unit points centres
  (the order `P, O, G, R, B, M` at `x = (1/2, √3/2)`, `y = (1/2, −√3/2)`); the disk has none. *Side*: none alone; it is the
  structural form's candidate invariant, and the statement on which "do the saves close up" is next asked.

**Which kind each is.** Reading: C124-READ-SAVES. Spends six: C124-FORCED, C124-ONE-MEMBER, C124-EDGE, C124-SECOND. Per class,
cited and not re-derived: C124-SHADOW-OPEN, C124-CENTRE, C124-STRADDLE.

**The deriver's question, answered as far as the record reaches.** *What the strip's ends are*: three-label points, 40 of 40
interior ones, each one unit from exactly two midline vertices — 20 at `(k/2, ±√3/2)`, the apex of a unit triangle on two vertices
one unit apart, and 20 at `(1/4 + k/2, ±√15/4)`, on the unit circles about two adjacent vertices. So "0 of 92 ends centre a unit
arc" is true and every end is the common end of two arcs about two centres. *Whether anything at six forces a centre of kind both one
unit from an end*: a close complementary pair forces a tight pair at each common unit point (C132-COMP-SHARP; C124-FORCED is its
form here), and on the strip every end is a member of such a pair. Two things nothing held forces: that an end has a complementary
partner within 2 (FS-122's), and that all four labels are present at the saved point — C124-HALF-TWO bounds them from above, and
the equality is read (91 of 91), not derived.

**One remark for the deriver, per class, unchecked** (`plans/POROS-2026-10-07-fs124-round1.md` § 1.2): when both labels of a tight
window have sectors at the centre, the line through the centre perpendicular to each direction of the window separates the two
sectors; so a window of positive length joins non-adjacent sectors, and at a point with four sectors the pairs are the two pairs of
opposite sectors. It is C124-CENTRE read on a whole window.

### Registered expectations (Poros, 2026-10-07, before any derivation of these)

C124-READ-SAVES: its statement holds on the strip and the disk read whole 0.9; some unread object shows a pattern other than (1, 1)
0.5; a save by one member on a held object 0.1; every tight arc of kind both on the five unread objects is an edge of a save 0.6
(SIXFRAG's vertex is the likeliest miss). C124-FORCED derived as posed 0.8, restated at its wording 0.15. C124-ONE-MEMBER: an
object by formula 0.45, excluded 0.2, a gap at a named step 0.35. C124-EDGE holds as read 0.7. C124-SECOND derived as posed 0.9.
The card: one edge of each member forced 0.2; a save by one member exists 0.45; neither decided 0.35. An exclusion at an explicit
radius, in measure, for every weak six-colouring with a close complementary pair, within this milestone: 0.07. A six-coloured
object above the strip's top edge or outside the disk, by formula or search, within this milestone: 0.12. Six against seven decided
by this milestone: 0.03.

## What FS-116 established that this stands on (addresses in `plans/FS116-derivation.md`)

- **The placing rule, derived.** A change point whose `±60°` germs lie off (Q) arcs is a vertex of at least four colours (FS116-RING-GERM, held); at a
  semi-hub (a change point with germs on (Q) arcs) a vertex of at least four colours lies at `y`, at `r(ψ + 60°)` or at `r(ψ − 60°)`, unless `y` is a full
  parallel semi-hub of three colours (FS116-N3-SEMI, held; the cone calculus at the unit rhombus `p, u, y, v`, FS112-N3-NOBOTH at the third case);
  assembled as FS116-RING-TRANSFER-QC (one mind). Paired (Q) germs of one colour pair swap inner and outer colour (FS116-N3-PAIR, held).
- **Hubs**: the star determines a hub's colours and missing pair (FS116-N2-STAR); a hub's ring has `p` as a change point (FS116-N2-RECIP); antipodal hubs
  exchange tip and outer colour (FS116-N2-ANTI) — one mind each, their blind second minds owed.
- **The construction side**: no fragment by formula about a (Q)-ring four-colour vertex beyond `φ²/√2` (Y-QRING not landed; P2 met): of FS116-Y1's families,
  Q1 (the capped strip's arches kept, the region above and below free) is open, Q2 (the disk extended about a corner) dead above `φ`, Q3 (the bowtie) dead at
  `√3`; FS116-Y1-NOTCH forces the notch colours at the strip's stop points.

## Bearing on the answer

**In the measurable class (Poros, 2026-10-07; FS124-P1; `plans/POROS-2026-10-07-fs124-question.md` § 1.3).** The object is not an
exception the exclusions left over: it is what they force. At a witnessed four-cycle the centre's own labels fill part of the ring
(C132-M-EXCL); a close complementary pair puts an edge set on the unit circle about each common unit point (C132-COMP-SHARP); in maps
every valid six-map has a four-colour vertex and, non-Siamese, each has (Q) arcs or dies at `1 + ε` (rows 137, 149). So, stated
honestly on each side. **Toward seven**: an exclusion here is an exclusion of weak six-colourings *that have a tight pair of a named
kind*, at an explicit radius; it is `χ(ℝ²) = 7` only together with a statement that every weak six-colouring has such a pair, and
whether every colouring has a point with any witnessed cycle at all is FS-127's and FS-128's, not this milestone's. **Toward six**:
weak six-colourings of discs of every radius are `χ(ℝ²) = 6`, at any regularity (C124-RADIUS, posed); that a six-colouring must be
*built from* tight pairs is held for non-Siamese maps only, and nothing held stops a Siamese or a wild construction from avoiding
them — so this is the YES side's only held home, not its only possible one. **What the milestone can deliver alone**: what a tight
pair passes on, at every number of colours, and the first count that spends six on the arc's side (C124-SIX). The paragraph of
2026-10-03 below is the bearing in the map class and stands.

**The main remaining case set of the six-map NO with unit arcs, and the YES side's home** (Poros, 2026-10-03). Every held positive past `√3` has (Q) arcs
on its four-colour rings (row 136), and in the non-Siamese class no ring without one survives past `1 + ε` (row 149), so the life of a four-colour vertex is
its (Q) arcs. An exclusion here at one explicit radius, with FS-123's Siamese class, is C114-LOCAL-F, hence (FS114-CV-EXISTS) no valid six-map with unit
arcs at any complexity — `[SokolovVoronov2025]` Question 2's unit-arc half — and, with route M's map step at six (FS-125–FS-128), `χ(ℝ²) = 7` given MR. It
is route R's exact-map form too: both common unit points of a cubic trichromatic complementary pair are (Q)-ring vertices of at least four colours
(FS112-N3-COR3), so the exclusion leaves no close complementary pair in any valid map (FS129-OR1 § J15). A valid fragment by formula about a (Q)-ring vertex
beyond `φ²/√2` meets G83's killing test; a family of them on discs of every radius gives `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held). Each case alone is
a piece, not the answer.

*At FS-129's audit (FS129-Z2, 2026-10-03; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).*
- *Two pruning rules for ring types*, for case 5 (the recurrence) and at hubs and kind-T semi-hubs in case 1: **FS129-MR1-DOUBLETIP**: "in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring of p such that neither the arc of ω(p) just clockwise of r(ψ − 60°) nor the arc just counter-clockwise of r(ψ + 120°) lies on a (Q) arc; then no tile of p is at once the only tile of p whose closure holds y and the only tile of p whose closure holds y′" — the double-tip
  kill of FS116-V6-HUG and FS116-Y4-EMPTY carried to every ring whose outer germs lie off (Q) arcs (its `uses only:` without FS116-N2-STAR,
  `plans/FS129-SR1-audit.md` § 2.2) — and its outer twin **FS129-SR3-OUTERADJ**: "in a non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring such that neither the arc of ω(p) just counter-clockwise of r(ψ − 60°) nor the arc just clockwise of r(ψ + 120°) lies on a (Q) arc; then no colour of p is at once the only colour carried at y by a tile that is not a tile of p and the only colour carried at y′ by a tile that is not a tile of p" (non-Siamese, no simplicity). Neither reaches SEMI-PAR3. Caution for
  the Lean list: DOUBLETIP cannot stand in for FS116-V6-HUG's colour step without losing FS129-SR3-EMPTY-NS, since DOUBLETIP's step 3 uses one cone per
  tile at the hubs (FS-129 items 126, 131). The four uses of the two-circle identity (FS116-V6-HUG, FS114-Y5-PXKILL, FS116-V6-ADJ, FS116-Y4-FLANK's
  least-curved case) are one lemma, FS129-SR1-TWOCIRC.
- *The bends* (FS129-OR1-BENDFRAG; FS129-SR1-BENDANY at any `k`): below `√3` about `p` a step may assume `p`'s ring carries only its (Q) arcs and finitely
  many points; a step reading radius above 2, or a ring point's own ring, may not (`plans/FS129-OR1-audit.md` § J1). At a vertex of exactly three colours
  the whole ring is freed (FS129-SR1-BENDLE3), so case 1's reading of `y`'s own ring can start from a ring with no arc of `Γ` — the object of FS110-N2-RING
  and FS110-Y3-GP, whose winding is the height lane A's question sought (their one lemma is FS129-SR1-RINGBAND), provided the bends at `y` are pinned at
  `p`'s germs `r(ψ ± 60°)` (`plans/FS129-OR1-audit.md` § J2, its caveat). Case 1 shortened, not closed.
- *SEMI-PAR3's winding, explored, not derived* (`plans/FS129-MR1-audit.md` § Stage 3, (d); `data/fs129/mr1/jump_explore.py`, an exploration, not a
  control): when each (Q) arc's own side tiles hold `ω(y)`'s germs at its end, "the jump is 0 in all 8 consistent assignments, and `ω(y)` is forced to carry
  `f`, `t_front`'s colour, at both `y + e(60°)` and `y + e(300°)`"; a jump of `±2` needs an `f`-coloured tile at `u` or `v`; then `t_front` can approach
  `y` only inside the tip cone `(150°, 210°)` — a reading at radius `√3 + ε` about `p`, resting on a germ assignment not derived.
- *Case 6*: **FS129-SR3-E2ONE**: "in a non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about p, with a pinwheel at p, no edge at p of length 60° (no E1) and E2 at exactly one blade t_{c+1}, the pocket colours satisfy m_{c−1} ≠ m_c; hence POCKET at w_c and CASE at q_c hold, and no such pinwheel exists at radius 1 + ε; in particular FS114-Y6-E2RED's survivor family S6, (120°, b, 180° − b, 60°), has no member". So FS114-Y5-PINALL's exception narrows to "E1, or E2 at two or more blades", FS114-Y5-PIN120's to E2 with E1 or a
  second E2, and FS114-K1's list drops S6 (FS-129 item 130). Every Reuleaux `(2, 1, 1, 0)` in FS114-Y6-HALF's class carries a (Q) arc, so the Reuleaux
  residue "on rings with (Q) arcs" is the whole HALF class, not killed past `√3` (`plans/FS129-SR3-audit.md` § 1.3). An open line unplaced between this
  case and FS-117: FS114-Y3-RSTOP's "Y3-D2 without reading R-T" (a Reuleaux bowtie with a non-tactic edge, which no held result reads); whether FS-112's
  bends remove it first is not read (`plans/FS129-SR3-audit.md` § 4.1).
- *Case 4*: FS112-SIX is subsumed — its five-colour clause by FS116-N2-FIVERING, its six-colour clause by FS129-SR1-SIXQ (`plans/FS129-SR1-audit.md`
  § Stage 3, group 2). FS112-SIX's covering-step GAP is answered in the non-Siamese class (FS116-V4-DICHOTOMY with FS116-N2-SIXRING) and open in the
  Siamese class, case 7 (`plans/FS129-SR3-audit.md` § 4.1).
- *Case 8*: **FS129-OR1-LOCALDENSE**: "every valid six-coloured fragment on a closed disc B̄(x, 3) has, in B̄(x, 3), a vertex of at least four colours or a vertex with a repeated colour" (possibly vacuous: no valid fragment on a disc of radius 3 is held) and **FS129-OR1-DISCF-NS**: "if for some R > 0 no non-Siamese simple valid six-coloured fragment exists on a closed disc of radius R about a vertex of at least four colours, then no non-Siamese simple valid six-coloured fragment exists on any closed disc of radius R + 3". So DISC-F
  follows from C114-LOCAL-F in the non-Siamese simple class; in the Siamese or non-simple class it needs, besides, an exclusion about repeated-colour
  vertices or GS-4's density form (FS-115; `plans/FS129-OR1-audit.md` § J19). `plans/FS116-local-exclusion.md` § 3.6's "one question" holds in the
  non-Siamese simple class only (a dated note there).
- *Route R meets this case list*: in a valid map both common unit points of a cubic trichromatic complementary pair are vertices of at least four colours
  whose rings carry (Q) arcs (FS112-N3-COR3), so an exclusion here leaves no such pair in any valid map (`plans/FS129-OR1-audit.md` § J15).

## Owed second minds (before anything final rests on them)

FS116-N3-CROSS's last clause (blind; Kooshi's ruling of item 115 applied in item 118); FS116-N2-STAR, -RECIP, -ANTI (item 69; HEX6 and HEX3 are true
vacuously and need none); FS116-RING-TRANSFER-C (its clauses other than the vacuous last), FS116-RING-TRANSFER-QC, -RING-Q-PRIME, -RING-TWIST-Q, FS116-N3-STAR2, -CONE (one mind each); FS116-N2-SIXRING, -FIVERING,
FS116-Y2-SIXOFF (one mind each; SIXFRAG is exact); row 134's base, Lemma 4 at cusps (BASE-V), before any publication.

## Definitions and tools owed

- **Ring type** (item 67): the frozen list's § 0 records no edge direction of `p`; define it as the pair (ring word, star), as FS116-N2 found the rule reads
  `p`'s star.
- **A qualifying window** (item 53): FS116-RING-TWIST-C's window clauses (a 120° arc free of the set `D`) have no held model; a fragment with one, by formula,
  or a reason none exists.
- **Tool defect** (item 98): `tools/fs116_n1_ring.py`'s `locate` reads ray parity along one fixed ray; re-run the held ring surveys
  (`data/fs116/n1/ring-survey*.out`, `germ.out`) with FS116-N3's two-ray `locate2` before any statement rests on a sampled output (none does now).

## Prior-art debts

The semi-hub placement and the cone calculus at the unit rhombus were not in FS-116's gate (item 99): search the map-colouring vocabulary (Woodall's and
Townsend's vertex lemmas, read, not recalled); `[Polymath16threads]` thread 8 beyond [08.17]–[08.18] (item 63); H3, Delone sets and the local theorem
(`[DolbilinSchattschneider1998]`, Zbl 0918.52007, title only, unread) — the candidate home for the recurrence, never adopted (`plans/FS116-local-exclusion.md`
§ 2.1).

## Construction targets

- G83's killing test: a valid fragment by formula about a (Q)-ring vertex of at least four colours beyond `φ²/√2`, first in family Q1 (the strip's arches
  kept); exact check, planted fault.
- A full parallel semi-hub of three colours (item 96); the disk-corner configuration beyond radius 2 (item 40); a six-colour vertex past `3/2`.

## Registered expectations (provisional; instruments, never caps)

SEMI-PAR3 decided either way: 0.5. The disk's corner excluded on `B̄(p, 2)`: 0.35. A (Q)-ring fragment by formula beyond `φ²/√2`: 0.2. C114-LOCAL-F at an
explicit radius within the milestone: 0.15.

## Failure clauses

A local exclusion of one ring type is a piece and names the types that remain; a NO for the non-Siamese simple class says so in its headline (G21, G86);
every exclusion states its reading radius and the controls it fails on (the capped strip at `φ²/√2`, the disk at `φ`, the bowtie at `3√3/5`, SIXFRAG below
`3/2`, R7 at seven colours); a statement on a class not yet shown inhabited says so; no argument one colour class at a time (row 129); no count as a step
(G86); a candidate that fails its exact check measures the candidate.

## Deliverables

The plan (the reframe first); a derivation file; any object by formula with an exact check whose plant fires; a visualizer of a (Q) ring and the vertices
it places, if one is built; the close's drafts.

## Provisional bearings

G91 (the ring's twisted colouring and the placing rule — the object the card reads); G83 (the straddle and the four-colour vertex — the kill every
exclusion so far used); G79 (the example invariant: what the held positives carry, before sharpening a no-go — the card's first step); G73 (the Kneser
graphs `KG(6, 2)` and `KG(4, 2)` — case 5's reading lives there); G84 (a (Q) arc is FS111-M-PINCH's split case — the contact a (Q) arc is); G86 (Siamese
pairs blind every count — why case 7 is FS-123's and no count is a step); G21 (no held inhabitant past `φ²/√2` — every exclusion fails on the controls
first); proposed G92 (a held result reaches its argument's class — read DOUBLETIP's and OUTERADJ's arguments before citing their statements). Rows 133–138,
145–150, 153. Stubs FS-123 (the Siamese class), FS-125 (the saturated class), FS-117 (the count's K1′), FS-122 (route R's exact-map form).

*For the question of 2026-10-07 (Poros, FS124-P1; one line of why each, which the opening job's re-grokking replaces):* G84 (a tight
pair of kind both is contact's split case — the object's home); G92 (each map-class lemma is carried by re-reading its argument over
open one-label pieces: C132-SHADOW is row 138's cone form at the class its argument reads); G91 (the placing rule is the map-class
instance of what a tight pair passes on, and the 60° rule is why the rhombus completions are where it lands); G83 (every held kill is
a straddle, second order — where a first-order skeleton would have to be killed or filled); G95 (kind both fails under local slack at
seven, C124-KIND, so at six it is a hypothesis or a theorem that spends six); G82 (C124-RADIUS: the YES is objects on discs of every
radius, the NO a statement about one disc); G86 (no count over tiles: C124-SIX counts directions at one point); G79 (the example
invariant: what R7 and the kept shape carry at each lattice point); G94 (what these claims need from regularity is one-label open
pieces near two points, never a map). Rows 135 and 136 (the rhombus and the stop), 138 (the cone form), 145 (FS116-O1-YESLIM, for
maps), 149. Entries C132-SHADOW, C132-CROSS, C132-COMP-SHARP, C132-PLACED-RING, C132-M-EXCL (`plans/FS132-derivation.md`).

*Dated block (2026-10-07; filed by FS124-P2 from FS124-E1's record § 1.2, by script, with the one correction that job's report
names — the clause "and what a ring passes on is passed at ends" struck from G91's line: R7's shape, false of the strip. The
paragraph above stands as posed.)*

*For the question of 2026-10-07 (the opening job's re-grokking, FS124-E1; `plans/FS124-tight-pairs.md` §G):* G92 and G84 (the
first-order rule is one lemma — the class of a label is null on the unit circles about an open piece of that label — and every
claim at a tight pair is the computation of one open set; kind both is contact from both sides, never assumed); G85, G88, G16 (the
unit parallels of the arc are its centre and the arc of radius 2: a tight pair speaks at `2z − q` as well as at the completions);
G91 (tightness is open along the ring, so the object is an arc with ends); G83 (the
first-order rule is not the kill: the straddle between two pieces of one label pinned by two tight pairs is the next round's
first test); G96 (a tight pair is ball data at its far end and circle data at its centre); G97 (falsifiable here: a first-order
count that bounds unit arcs about ring points); G95 (C124-KIND is the planted slack at seven); G60 (per-class statements hold at
every number of labels: only a count across classes at a point can spend six); G89 (where tightness is not forced by a count, the
question is binding: FS-125, FS-128); G94 (the class with a tight pair is not known to be every weak six-colouring); G79 (read R7,
the strip and the disk at their tight arcs first); G82, G93 (C124-RADIUS: a random rigid motion on one open set per finite graph);
G86 (no claim reads a tile as one piece of diameter at most 1); G21 (every control on a model with no margin, its non-vacuous
count in its line); G13, G22, G90, G98 (one line each in the plan). Rows 135 (the rhombus; (Q) as a normal form reached by a
move), 136 (the stop), 138 (the cone form), 145 (fragments at every radius, for maps). Entries C132-SHADOW (whose argument is
the lemma), C132-WITNESS, C132-WIT-SIDE, C132-CROSS, C132-COMP-SHARP (`plans/FS132-derivation.md`).

*For the question after the first round (Poros, FS124-P2; one line of why each, which the second round's re-grokking replaces):* G96
(a save is the one passage held from ball data to circle data that spends six: three pieces at each of two points, a boundary on
a unit circle at a third); G97 (the unit arc is where a pair is saved — the hard case is an effect); G91 (the placing rule is the
save read from the centre; C124-SECOND is what a pair carries between its two points); G79 (the example invariant was read first:
94 saved points on two maps); G92 (C124-HALF-TWO reaches further than its filing as a rider); G95 (all four labels present at a
saved point is read, not derived: kind stays a hypothesis); G21 ("no held object meets the hypothesis" measured three objects);
G86 (the count is over incidences of pairs and points, never over tiles); G98 (the ring of a three-piece point is where a partner
would be forced, and nothing held forces one). Rows 135 (the rhombus), 136 (the stop). Entries C132-CROSS, C132-COMP-SHARP,
C132-WIT-SIDE (`plans/FS132-derivation.md`); C124-CENTRE, C124-STRADDLE, C124-HALF, C124-HALF-TWO (`plans/FS124-E1-derivation.md`).
Stubs FS-122 (the forced pair: whether a close complementary pair exists in every colouring), FS-127, FS-128.

*After the second round (Poros, FS124-P3, 2026-10-07; `plans/POROS-2026-10-07-fs124-round2.md`):* **the asking lane's verdict is
"record job"** — the question of this morning and the question after the first round are answered at their unit (one tight pair
passes on nothing beyond the first step; a close complementary pair of sector points is paid for by both members at four-label
points; the strip is closed at its top edge), and no fourth question is posed in this stub. Of the carry-over list above
("What to carry over from the map class first, and how"), the cone form and the rhombus lemma are carried; the partner count
(FS112-C-PARTNERS) and the placing rule (FS116-N3-SEMI) are not, and each further step at the pair restates a held map entry by
one application of C124-TYPE (that record's § 1.2). The eight cases of "The question, in plain language" stay open and pass,
with those two steps, to the successor `plans/STUB-covering-pairs.md` — the point across: two pieced points on the unit circle
of a point of four or more labels whose labels together are all six, and their second common unit point, where the strip, the
disk and the six-colour flower each stop (`φ²/√2`, `φ`, `√3`). Bearings added by that record: G83 (the unit this stub was
minted at, and left); G92 (C124-FORCED-PIECES reads "all six labels are spoken for", not "two triples"); G97 (its killing test
fired at C124-BOTH and C124-EDGE-CLOSED). Entries: FS112-C-PARTNERS, FS112-STOP, FS114-Y-STRIPK6 (the map statement about the
six tiles C124-EDGE-CLOSED keeps), FS114-Y-PAIRSHARE, FS116-Y2-SIXOFF.

*At the record job (FS124-Z1, the record job, 2026-10-07; every entry named is in `plans/FS124-derivation.md`, [hand] or derived from [hand] entries, **one mind, kernel pending**):* **what this milestone delivered is
`plans/FS124-derivation.md`** — thirty entries from two rounds, twenty-nine derived and one refuted: the radius clause (§ 1; its module through the gate, FS124-L1 — [kernel], the half toward seven on one declared outside theorem); the one lemma and what one
piece forces (§ 2); what a close complementary pair forces at a common unit point — for three-piece points, full members and
sector points, the posed wording refuted at a bowtie joined by a band (§ 3); FS-112's strip closed at one named point of its top
edge against every weak six-colouring that keeps six named pieces (§ 4); a count at a centre whose class has no held member, and
the rhombus's first half (§ 5); two calibrations at seven (§ 6); and a reading of nine six-coloured held objects, [tools] (§ 7).
**It delivered no exclusion beyond one held family, no object beyond held fragments, and no statement that a weak six-colouring
has a piece.** **The eight cases of "The question, in plain language" are open and pass to FS-136**
(`plans/STUB-covering-pairs.md`), by the asking lane's verdict above and the coordinator's ruling (`plans/FS124-close-inventory.md`
item 26).

*At FS-129's audit (FS129-Z2, 2026-10-03):* FS129-MR1-DOUBLETIP, FS129-SR3-OUTERADJ,
-E2ONE, FS129-SR1-TWOCIRC, -BENDANY, -BENDLE3, -RINGBAND, -SIXQ, FS129-OR1-BENDFRAG, -LOCALDENSE, -DISCF-NS; G71's height on a curve (FS110's winding)
for case 1.

*Since FS-132 (FS132-Z2, 2026-10-07; every entry named is in `plans/FS132-derivation.md`, [hand] or derived from [hand] entries, one mind, kernel
pending, unless marked):*

- **This stub's object is where every round of FS-132 ended**: a boundary that is an arc of a unit circle whose centre is the
  other end of a unit distance. It appears two ways (that file's § How to read an entry): (α) on the centre's own ring — in the
  map class a (Q) arc; in measure, palettes that hold no label outside the centre's own on a set of positive measure near a ring
  direction; (β) through the centre — an edge set of the centre lying on the unit circle about one of its ring points. The
  asking lane reads the two as one object, the unit arc of rows 135–136 (`plans/FS132-close-inventory.md` item 24; checked by
  neither the coordinator nor the record job). In that file's words, nothing in it "excludes, builds or bounds a boundary that
  is a unit arc about a ring point".
- **A measurable instance of this stub's first question** — what a (Q) ring passes to the vertices it places — **with every
  hypothesis derived from a seed's circle data: C132-PLACED-RING** ([hand], one mind, kernel pending; § 5 of that file). On a
  six-sector turning seed `x` (a point with a witnessed triangle whose palettes read `a, b, n, a, b, n`) whose ring points
  `y_1`, `y_{−1}` are outer-pure: near `y_1`, outside `x`'s ring, almost every point has the label `b` inside and `a` outside
  the unit circle about `y_0`; near `y_{−1}`, `a` inside and `b` outside; and the palettes of `y_0` on the two arcs are
  contained in `{a, b}`. So the unit circle about `y_0` runs along an interface between the two ring labels at both
  neighbours, oppositely oriented. **Not claimed by it**: that those two palettes contain both labels (each is present on one
  side of the arc; "not written out"); anything on the rest of the unit circle about `y_0`; that `y_0` is a cyclic centre. With
  three consecutive outer-pure ring points `y_0` has four labels present (C132-LENS-FOUR) — and only then is `y_0` known to
  carry both side labels `a` and `b`, the map class's property (Q); C132-PLACED-RING alone does not give it. **No model is known** — no weak
  six-colouring with a turning seed is held — so "derived" means from the seed's data, never that a seed exists.
- **A pruning rule on one orbit: C132-M-ORBIT** ([hand], one mind, with a line-by-line checking reading of its last steps by a
  second mind; the kernel lane's first module). At a point where four labels meet in a witnessed cycle, no ring direction `ψ`
  has palettes holding one of the two other labels almost everywhere near all six directions `ψ + kπ/3` while both occur near
  `ψ`. Read on a ring with (Q) arcs: every essential change of the outside state has a (Q) arc at its six-fold orbit — at each
  of the eight change points of the held fragments' four-colour vertices at least two of the four germs at ±60° lie on (Q) arcs
  (control `positives-escape`).
- **The head's "C132-DIAG, posed" is an instance of the release's own Lean theorem** (`two_state_impossible`, at every number
  of labels); what FS-132 adds is its reading on an open set, one mind (C132-DIAG-WIDE).
- **Open, carried here from FS-132, none started**: **C132-ARC** (posed in `plans/STUB-six-by-the-nerve.md` § The question,
  re-posed after the second round; "no line of it worked, its R7 control not run"; a tool it did not have when posed is
  C132-SHADOW); **C132-PLACED's open line** — whether any pair containing a label of the centre's triple is a witnessed edge at
  the placed point — with FS132-E6's forms (a)–(c) (`plans/FS132-E6-derivation.md` § The list: what fills the two inner wedges;
  what the placed point's ring carries at the orbit's four other points; the same one step on); **C132-RADIUS** — weak
  six-colourings of discs of every radius give `χ(ℝ²) ≤ 6`, the measurable form of row 145, posed and not started: the YES
  side's clause of this stub once it is posed in measure.
- **The three residues of FS-132's second round are this object**: the conclusion of C132-COMP-SHARP (one of six edge sets on
  the unit circle about the common unit point; fragment T2 realizes it with three), the residue of C132-ALT (three alternate
  ring points, each with one of the centre's three sets on its unit circle), the void of C132-PLACE (a ring point with no pure
  side).
- **A model of the hard case in a finite family**: with four labels at alternate ring points the turning ring has models in
  the Searcher's seven-flower wedge family — each interface at the centre an arc of the unit circle about a ring point, those
  ring points exactly the four-label ones (SEARCH-1007-TURN4, [cert] by a cold check of the kept models; local, flowers of
  radius about 0.25). "The search's kept model is the hard case and no statement of the stage applies to it"
  (`plans/FS132-close-inventory.md` item 28). Its extension to the annulus and the closed unit disc is `plans/SEARCH-QUEUE.md`
  line 11, held.
- **What transfers from the map class** — rows 135–138 and 145–150 are theorems about maps — needs the dictionary fact FS-134
  owes (`plans/STUB-exclusion-back-to-maps.md`: a map's palette is its ring read two-sidedly). The arc-free remainder of the
  seed is FS-135 (`plans/STUB-seed-remainder.md`).
  *Dated correction (2026-10-07; FS124-P1's finding, `plans/POROS-2026-10-07-fs124-question.md`, filed by Keryx):* the dictionary fact of
  FS-134 serves the other direction — reading a palette-stated entry (C132-M-ORBIT, C132-M-EXCL) at a map vertex. What transfers from the
  map class to measure is carried by re-reading each argument over open one-label pieces, and needs no dictionary (this stub's question
  section of 2026-10-07, "What to carry over from the map class first, and how").
- Grokkings: G94, G95; proposed G96 (circle data against ball data) and G97 (every exclusion ended at the unit arc).

## Carried card (Poros, R2, 2026-10-03; verbatim from `plans/POROS-2026-10-03-close-reread.md` § 2.5)

question: where-else-the-identity
  evidence: V6-HUG's identity (`plans/FS116-V6-verification.md` l. 159) is `|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)` at `u = e(s)`, `v = −1`,
    `w = e(−t)` — the constant width of the unit Reuleaux triangle on a unit pair, with exactly-1 only where two steps cancel (control
    `data/workflow3/r2/identity_check.py`, PASS, plant fires); V6-ADJ (§ 2.3 item 2) is the same law on the vesica's other Reuleaux triangle; FS116-Y4
    § 3.4 names three neighbours, "each unread"; V6 notes "Validity alone kills it here" (§ 2.2)
  expected: an identity special to EMPTY's double tip
  ask: In C114-LOCAL-F's open cases, where are two tiles of one colour pinned, from outside, to the two sides through one apex of a unit Reuleaux triangle on a unit pair — and which case does each exclusion remove?
  if the shared-tip semi-hub qualifies: the exclusion narrows the placing rule's only exception (SEMI-PAR3) in FS-124 case 1, and FS-124's proof side runs the identity there first
  if only (Q)-free configurations qualify: the identity serves FS-123's (R2)-arc rings and OC, and only if card 1's answer is no
  if none qualifies outside EMPTY's class: the identity's reach in FS-116's cases is EMPTY's alone; it goes to FS-129 as an index entry (unit pairs, Reuleaux sides), with FS-122's band datum
  answered by: derivation — Ephodos, at FS-124's and FS-123's openings; or FS-129's opening as its pilot entry
  cost: a reading round per configuration; each use must fail on the controls (the strip at `φ²/√2`, the disk at `φ` with RING-Q false below `≈ 1.5985`, SIXFRAG below `3/2`, the bowtie at `3√3/5`, R7 at seven colours)
  hunch: the shared-tip semi-hub qualifies (0.5)
  falsifier: a reading of the shared-tip configuration in which the two flank tiles' colours are forced to differ, as with three absent colours
  rank: 2

**Card 2's ranking**: the four named configurations, by what an exclusion there would remove from C114-LOCAL-F's case list
(`plans/FS116-Z1-close.md` § 2.6). The unit pairs in a ring picture are `{p, y}` for every ring point `y`, and `{y, σy}` for ring points `60°` apart.
Every one of them carries two Reuleaux triangles.

| rank | configuration (address) | the unit pair | what an exclusion would remove | condition |
|---|---|---|---|---|
| 1 | a semi-hub whose tip is shared with the next change point (Y4 § 3.4, neighbour 2) | `{y, σy}` on a (Q) ring | a sub-case of the placing rule on (Q) rings; if it reaches the full parallel semi-hub of three colours, SEMI-PAR3, the rule's only exception, and with it four-colour vertices propagate at every semi-hub (FS-124 cases 1, 5) | unconditional: (Q) rings are the bulk and the YES side's home (row 136) |
| 2 | (Q)-free rings carrying (R2) arcs, and OC (Y4 § 3.4, neighbours 1 and 3) | `{y, σy}` at a double tip; `{p, y}` at an (R2) arc's end | the whole (Q)-free remainder (FS-123 questions 2) | moot if card 1 answers yes; moot in the saturated class given FS-126's NO (FS121-Z1-NOCURVED, C3) |
| 3 | outer tiles of one colour at adjacent hubs, each hugging the lens arc beyond its hub (V6-ADJ, V6 § 2.3 item 2) | `{y, σy}`, the vesica's outer Reuleaux triangle | no case alone; it prunes the recurrence's outer colours (V6: "why a construction needs five-colour hubs") on (Q) rings with adjacent placed hubs (FS-124 case 5) | unconditional, but a pruning, not a removal |
| 4 | the five- and six-colour vertices (FS116-N2-FIVERING, -SIXRING) | `{p, y}` at (Q)-arc ends `60°` apart | FS-124 case 4, in part | untested; SIXFRAG (exact, every disc below `3/2`) is the control any use must fail on |

Outside the case list, the identity bears on route R through its margin. The deficit is `8 sin(s/2) sin(t/2) cos((s + t)/2) ≈ 2st`, second order in
the hug lengths, so a kill by it survives a band of slack `ε` only if the hug lengths are of order `√ε` or more. This is FS-122's carried card's
question, and Z2 filed it there as a datum (`plans/STUB-forced-pair.md` l. 42).
