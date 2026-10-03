# FS-124 — the (Q) ring: does every vertex of at least four colours whose ring carries (Q) arcs, and every vertex of five or six colours, die within an explicit radius? (stub)

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

**The main remaining case set of the six-map NO with unit arcs.** With FS-123 and the Siamese rungs, an exclusion here at one explicit radius is
C114-LOCAL-F, hence (FS114-CV-EXISTS) no valid six-map with unit arcs at any complexity — `[SokolovVoronov2025]` Question 2's unit-arc half, almost
everywhere, for locally finite segment-and-arc maps — and, with FS-121's successors (FS-126–FS-128), route M's first half toward `χ(ℝ²) = 7` given MR. A
valid fragment by formula about a (Q)-ring vertex of at least four colours beyond `φ²/√2` meets G83's killing test and moves C114-LOCAL-F's dial; a family
of such fragments on discs of every radius gives `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held). Each case alone is a piece, not the answer.

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

G83, G91 (drafted at FS-116's close), G84 (a (Q) arc is FS111-M-PINCH's split case), G15, G21, G79, G86; rows 133–138 and FS-116's; stubs FS-123, FS-125,
FS-117, FS-121's successors FS-126–FS-128.

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
