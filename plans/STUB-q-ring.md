# FS-124 — the (Q) ring: does every vertex of at least four colours whose ring carries (Q) arcs, and every vertex of five or six colours, die within an explicit radius? (stub)

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
