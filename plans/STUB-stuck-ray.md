# FS-115 — the stuck ray: can a one-sided chain of stuck vertices live in a six-map with unit arcs, are finite chains bounded, and does the one-vertex bowtie end live in one? (stub)

> **Re-aimed 2026-09-28 (R1), rank 4 → 6.** FS114-CV-EXISTS removed the ray step from the NO; this stub's live bearing is as a rung of FS-121, through ¬LRA, if FS111-C's one-mind reading that LRA is this ray holds.

*Minted 2026-09-27 by the close planner FS112-C at FS-112's close, on Kooshi's ruling (`plans/FS112-close-inventory.md` item 59: *"point two
milestones at the two gaps, so we can focus on them specifically. They seem to require more research and careful exploration, and may be more
complicated than they appear."*), rank 2, above FS-111; its sibling is FS-114, the global step (`plans/STUB-global-step.md`), and this stub's bearing
depends on the form FS-114 takes. **Solver column: in-ban** — derivation, reading, and exact checks of chain fragments given by formula. Written for a
session with no memory of FS-112: read `CLAUDE.md` § The aim and § Counter-priors first, then `LEDGER.md` rows 133–136, `plans/FS110-derivation.md`
§1 (the N4 chain: SHADOW, SHAVE, STUCK, FIN, TERM), `plans/FS112-derivation.md` §§1–3 and its entries FS112-Y3-END-NEEDS and FS112-BOWTIE,
`data/fs112/fs112-c/reconciliation.md` §§1.5–1.6 and 1.8–1.9 (stage 1b, FS112-C2), and `plans/FS112-YB3-verification.md` §3.1.*

**Provisional bearings** (WORKFLOW 3.1 replaces them at the opening): G79 (the chain's end, flipped from a wall into an anchor at FS-112), G72, G82,
G21 (a local fragment is not a map; a finite chain is not a ray), G30 (the next discipline: dynamics of a parabolic map), G51, G17, G71 (the index at a
bowtie seam; FS-112's E12 untested); rows 133–136; stubs FS-114, FS-111. *At FS-114's close:* G83 (rewritten), rows 137–138; stubs FS-116, FS-117. *At FS-111's close:* FS111-M2-INTRAD (two minds on its core): off a locally finite singular set saturated interfaces have integer radii, so the map step at six needs only no large-radius accumulation — which is this stub's stuck ray in another form (FS111-M2-REDUCE-A); FS-121 shares it.

## The question, in plain language

Row 134 proved that no six-map of the plane bounded by segments and circular arcs, none of radius 1, is a valid six-colouring (no two interior points
of one colour at distance 1). Its proof reduced every map to one whose vertices are all *cubic* — three colours, one sector each — by local moves
(merge, shave, bend). The moves fail at one kind of vertex, a **stuck vertex**: a degree-4 vertex where one colour occupies two thin opposite horns
along a line, the colour above filling the upper side and the colour below the lower side (a Woodall cone). A stuck vertex forces the next point of its
normal line, one unit away, to be stuck too, so stuck vertices come in **chains** `P_k = v + kn` at unit spacing. Along a chain the curvatures of the
horns' arcs obey two recursions, `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k` with `f(λ) = λ/(1 + λ)` and `f̃ = f⁻¹`; row 134 forbade chains infinite in
both directions (N4-FIN), and under Condition 5 (no unit arcs) every chain is infinite in both directions, so there were none.

With unit arcs, FS-112 found (two minds, one blind) that **a chain can end**: at a horn whose bounding arc is a unit arc (curvature exactly `±1`), the
propagation step fails, so chains may be finite, and **one-sided infinite chains — stuck rays — are consistent with every inequality held**
(FS112-N2-RAY). The extremal ray is explicit: `λ_k = −1/(k+1)`, `υ_k = 0` — its lower arcs are the circles of radius `k + 1` about the point `P_{−1}`
one step beyond its end, its upper arcs straight, every shadow tight (NB2's pencil).

> **The stuck ray (b′).** In a valid map with unit arcs, reduced to a terminal modification, can a stuck chain be infinite in one direction? Exclude
> it, or realise it.
> **Long chains (b″, named at FS-112's close).** Is the length of finite stuck chains bounded — uniformly over the map — or can a valid map carry finite
> chains of every length? (N3-ALPH, the case of finitely many arc radii that is not periodic, is a sub-question.)
> **The bowtie end (c, added at stage 1b of FS-112's close).** A stuck vertex whose two horns lie between the unit circles about its two neighbours on
> the normal line — bounded by unit arcs above and below, shadowed by the unit-radius tactic's own in-type sectors at both neighbours — is a chain of one
> vertex that ends at unit arcs on both sides. It exists as an exact local fragment (FS112-BOWTIE). Can it live in a valid map of the plane? And the
> chain ends FS-112 did not walk: a unit arc bounding **one** horn only of a side (an (R2) arc), at a chain of any length.

## Bearing on the answer

**None alone.** FS-114's global step in FS112-N3-DENSE3's form (no valid map has a vertex of at least four colours or a repeated colour within 3 of every
point) is the NO for every map and needs neither (b′) nor (b″) (FS112-C-COMPOSE). This stub matters when FS-114 is attacked in its **four-colour form**
(no valid map whose four-colour vertices come within `R` of every point): for doubly periodic maps that form suffices alone (no ray, bounded chains:
FS112-N3-PER); for aperiodic maps — the limit objects that row 133's W-EQ-K produces and a NO at bounded complexity must cover — it needs both (b′) and
(b″). So: **decisive jointly with FS-114's four-colour form**, for aperiodic maps; a realised ray inside a full valid map would be a YES (`χ(ℝ²) ≤ 6`,
no MR), but a ray realised as a local fragment is only a local positive, which kills the four-colour route and leaves DENSE3's.
The bowtie end (c), added at stage 1b, moves neither form: when all four of its horn arcs are unit arcs its neighbours are four-colour vertices
(FS112-C-DOUBLE, one mind), so it is within 1 of `F`; it bears as a locally terminal object a YES could use, and through FS112-C-ENDS's one residue.

**At FS-114's close (2026-09-28, FS114-C; `plans/FS114-C-close.md` stage 5).** FS-114's plan chose DENSE3's form (2026-09-27), and then
**FS114-CV-EXISTS** (two minds, blind to each other) proved that every valid map has a vertex of at least four colours — so the unit-arc NO is one local
statement about one such vertex (C114-LOCAL-F, FS-116's), with no ray step: **(b′) and (b″) bear only on GS-4's density form** ("four-colour vertices
within `R` of every point"), never on the NO. FS112-C-ENDS's residue is **empty** (CV-ENDS, two minds) and FS112-C-DOUBLE is at two minds, so (c) bears
only as a locally terminal object a YES could use. **A cross-milestone link for Poros's re-rank** (`plans/FS114-close-inventory.md` item 78): FS111-M2-INTRAD
derives that FS-111's route M needs ¬LRA, large-radius accumulation, which is this stub's stuck ray in the measurable setting — so FS-115's bearing may be
larger than "none alone" through FS-111's route M; FS-111's close states that clause.

## What FS-112 established (addresses in `plans/FS112-derivation.md`)

- **Why chains can end** (FS112-FLANK, FS112-N2-FLANK-Q, FS112-N2-RAY): at a horn bound of exactly `±1`, FS-110's list of flank shadows gains an in-type
  flank tile at the arc's centre, and N4-STUCK's step (iv) fails; every such bound sits on a (Q) arc or an (R2) arc.
- **What every chain carries** (FS112-N3-CHAINS, two minds, one blind): neither curvature decreases along a chain and one strictly increases per step;
  over a finite set `K` of curvatures a chain has at most `2|K| − 3` vertices; **a ray needs boundary arcs of radius at least `k + 1` at its `k`-th
  vertex** (equality is the pencil). So a ray needs infinitely many arc radii, and **a doubly periodic map has none** — its terminal modification is
  periodic (FS112-N3-PER). Whether a non-periodic map with finitely many arc radii keeps finitely many in its terminal modification is GAP N3-ALPH
  (SHAVE's new circle has a shadow's exact curvature; a bend's tangent start one chosen in an interval).
- **What every end carries** (FS112-N3-END, two minds, one blind): at an end with horn bound `−1`, the next point carries at least four colours and a
  repeated colour, and a both-kind unit arc is centred two steps beyond — **or the chain is the single doubly bounded vertex**, N3-END's second disjunct;
  with FS-112's close, **the point one step beyond every finite end has at least four colours** (FS112-C-ENDS, one mind, repaired at stage 1b for the
  single vertex; its one residue below). So a ray's one end is anchored at a four-colour vertex; its vertices are repeated-colour vertices, consistent
  with DENSE3 along its line.
- **The end analysis, corrected** (FS112-Y3-END-NEEDS; its levels two minds, one blind: Y3; YB3): if both horns of a stuck vertex `E` are bounded by unit
  arcs of `ω(E + n)` and **neither** by a unit arc of `ω(E − n)`, keeping `E` stuck and `E + n` terminal needs five colours at `E + n` and a seventh at
  `E + 2n` — so no such end exists. That covers every end of a chain of two or more vertices (FS112-END). **As Y3 stated it — every three-colour end at a
  unit arc — it is FALSE** (FS112-YB3): its first requirement missed an in-type tile at `E − n`, possible exactly when `E`'s lower arcs are unit arcs of
  `ω(E − n)`, and the one step the seventh colour needs that Y3 assumed (the lower flank at `E + n` is not `E`'s upper colour) is YB3's alone. Composed at
  the close (FS112-C-HORNEND, one mind): **a horn bound `±1` on both horns of a stuck vertex of a terminal map occurs only at a one-vertex chain bounded
  by unit arcs on both sides**; and when all four horn arcs are unit arcs, both neighbours carry in-type flank tiles and are (Q) centres with at least four
  colours (FS112-C-DOUBLE, one mind, a sketch). So a ray's finite end, and every end of a chain of two or more vertices, sits where the next point is an
  NB4P exception or carries an arc of the end vertex's own circle through it, or at a unit arc bounding one horn only — the case not walked. The close's
  first scope point (FLANK's in-type exception at the centre) is settled: it does not occur at such an end (YB3, one mind); its second (Y3's periodic
  corollary) is corrected in the reconciliation §1.9.
- **Held objects**: a finite chain `P_0, P_1, E` with the recursion taken with equality from the end (radii 3, 2, 1 about the centre `N`), realised
  exactly over ℚ with `N` completed two ways, neither terminal at `N` (FS112-Y3-END-AB; two rebuilds, one blind: `tools/fs112_y3_chainend.py`,
  `tools/fs112_yb3_frags.py enda endb`). **BOWTIE** (FS112-BOWTIE, `tools/fs112_yb3_frags.py bowtie`, exact, 21 / 21 pairs): `E = (0, 0)`, its colour-2
  horns between `ω((0, 1))` and `ω((0, −1))`, the in-type sectors `G` (colour 1) about `(0, 1)` and `H` (colour 3) about `(0, −1)`, radius 1, half-angle
  `arcsin(5/13)`; `E` stuck with three colours, both neighbours four-coloured and not stuck, locally terminal. It is FS112-N3-END's second disjunct in N3's
  first description, built blind by the construction side's verifier. No ray, no terminal end of a chain of two or more vertices, no chain longer than
  three is held.
- **Long chains are arithmetically free**: from one end `λ_k ≥ −1/(k+1)`, from the other `υ_k ≤ 1/(L − k + 1)`, compatible for every length `L`; each
  such chain needs about `L` distinct curvatures, which a map with infinitely many arc radii can supply (FS112-C-COMPOSE item 3). A Hausdorff limit at
  bounded complexity (W-EQ-K's) would turn long chains into a ray only if terminality and the stuck structure pass to limits — not derived.

## What is open, named

1. (b′): exclude or realise a one-sided stuck chain in a valid terminal map.
2. (b″): a uniform bound on finite chain length; or a derivation that unbounded lengths force a ray in a limit that is still valid and terminal.
3. N3-ALPH.
4. **The bowtie end (c).** Can FS112-BOWTIE's neighbourhood be completed: `E ± n` have four colours each, so their rings must meet NB4P (FS112-NB4P), and
   the arc of `G` on `ω(E + n)` spans ≈ 45.2° — YB3's in-ban test, first. Then whether the configuration lives in a valid map, and YB3's question: can
   every stuck vertex of a terminal map be read as a bowtie?
5. **The ends not walked.** A unit arc bounding one horn only of a side (an (R2) arc), at a chain of any length: FS112-C-HORNEND's and FS112-C-DOUBLE's
   hypotheses exclude it, and FS112-C-ENDS's one residue sits there (a one-vertex chain bounded by unit arcs on both sides but not on all four horn
   arcs, at a bound on an (R2) arc). Second minds on FS112-C-HORNEND and FS112-C-DOUBLE.
6. **The transverse structure of a ray**: what lies beside the line. A ray's own repeated-colour vertices satisfy DENSE3 within distance 3 of the line;
   beyond that, other four-colour or repeated-colour vertices are needed. How does the pencil's flattening (radius `k + 1`) meet the tiles beside it?

## Reading (a reading room before a route; nothing below is chosen in advance)

**Disciplines whose methods bear.**
- *One-dimensional dynamics of a parabolic map.* `f(λ) = λ/(1 + λ)` is a parabolic Möbius map with fixed point 0; its iterates are `λ/(1 + kλ)`, and
  the extremal ray is the orbit of `−1`, converging to the fixed point at rate `1/k` — the setting of Fatou coordinates and parabolic implosion. A ray is
  a one-sided orbit of two coupled recursions; a finite chain an orbit segment between two boundary values. The chain's inequalities are a discrete
  Riccati system.
- *Circle geometry.* The arcs of a chain are circles tangent to one line at points `P_k` at unit spacing; the extremal ray's lower arcs form a coaxal
  (concentric) pencil. Tangent-circle chains along a line (Ford circles are the classical family), inversive geometry, rigidity of tangency patterns.
- *Degree reduction in map colouring.* `[Woodall1973]` §3 (steps 2, 3, 5; its cone is the stuck vertex) and `[SokolovVoronov2025]` Props. 7–8, the
  printed chain this project made curved (row 134); FS-110's N4 records (`plans/FS110-N-proof.md` § Continuation — FS110-N4).

**The prior-art gate's questions** (WORKFLOW 3.2, in the discipline's words): "chain of circles tangent to a line", "curvature recursion `κ/(1 + κ)`",
"parabolic Möbius iteration" with "tiling" or "colouring"; the Polymath16 threads' tile rules for vertices of degree 4 (`[Polymath16threads]`
`[08.45]`–`[08.65]`, de Grey's rules; `[06.62]`–`[07.33]`, Gibbs's degree-4 enumeration, whose outputs are unheld — does it list the vertex between two
tangent unit circles, BOWTIE's `E`?); zbMATH `au:"Woodall, D"` for any later treatment of his cones.

## Registered expectations (instruments for G21, scored at the close; never caps)

| expectation | p | both outcomes reachable |
|---|---|---|
| (b′) excluded at one mind within FS-115 | 0.35 | a derivation, or a local exact fragment family realising arbitrarily long one-sided chains |
| a family of chain fragments by formula, each member exact and terminal at its end, of unbounded length | 0.3 | the checker on named members; or a derived obstruction at the end |
| (b″) bounded (a uniform bound on finite chains) | 0.25 | a derivation, or a family of valid chains of every length |
| BOWTIE's neighbourhood completes to a valid fragment containing the closed discs of radius 1 about both neighbours | 0.5 | an exact fragment by formula; or a derived obstruction at a named ring point |
| the one-horn unit-arc end excluded as the two-horn one is (a seventh colour) | 0.55 | a derivation; or an exact terminal end fragment with one horn bounded by a unit arc |
| a second mind confirms FS112-C-HORNEND and FS112-C-DOUBLE | 0.75 | a derivation; or a terminal doubly bounded vertex whose neighbour is an (R2) centre |
| a named obstruction or GAP as the product | 0.85 | — |

## Failure clauses

- A ray or a long chain realised as a local fragment is not a valid map: a local positive for the four-colour route, never a YES.
- An exclusion for doubly periodic maps only is FS112-N3-PER, already held; a result must reach aperiodic maps.
- A chain's end analysis that assumes N4-STUCK's structure at the next point measures that assumption (FS112-END's scope).
- A family of formula chains that all fail measures the family's image: state its free parameters against the recursion's.

## Deliverables

The plan with §G, §PA and §IQ; `plans/FS115-derivation.md`; exact chain fragments under `tools/fs115_*`, each given by formula and checked at named
members; verdicts on (b′), (b″), N3-ALPH and the bowtie end (c) with their grades; the transverse structure of the extremal ray, derived.
