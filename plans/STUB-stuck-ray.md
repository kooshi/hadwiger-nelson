# FS-115 — the stuck ray: can a one-sided chain of stuck vertices live in a six-map with unit arcs, and are finite chains bounded? (stub)

*Minted 2026-09-27 by the close planner FS112-C at FS-112's close, on Kooshi's ruling (`plans/FS112-close-inventory.md` item 59: *"point two
milestones at the two gaps, so we can focus on them specifically. They seem to require more research and careful exploration, and may be more
complicated than they appear."*), rank 2, above FS-111; its sibling is FS-114, the global step (`plans/STUB-global-step.md`), and this stub's bearing
depends on the form FS-114 takes. **Solver column: in-ban** — derivation, reading, and exact checks of chain fragments given by formula. Written for a
session with no memory of FS-112: read `CLAUDE.md` § The aim and § Counter-priors first, then `LEDGER.md` rows 133–136, `plans/FS110-derivation.md`
§1 (the N4 chain: SHADOW, SHAVE, STUCK, FIN, TERM), `plans/FS112-derivation.md` §§1–3, and `data/fs112/fs112-c/reconciliation.md` §§1.5–1.6.*

**Provisional bearings** (WORKFLOW 3.1 replaces them at the opening): G79 (the chain's end, flipped from a wall into an anchor at FS-112), G72, G82,
G21 (a local fragment is not a map; a finite chain is not a ray), G30 (the next discipline: dynamics of a parabolic map), G51, G17; rows 133–136; stubs
FS-114, FS-111.

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

## Bearing on the answer

**None alone.** FS-114's global step in FS112-N3-DENSE3's form (no valid map has a vertex of at least four colours or a repeated colour within 3 of every
point) is the NO for every map and needs neither (b′) nor (b″) (FS112-C-COMPOSE). This stub matters when FS-114 is attacked in its **four-colour form**
(no valid map whose four-colour vertices come within `R` of every point): for doubly periodic maps that form suffices alone (no ray, bounded chains:
FS112-N3-PER); for aperiodic maps — the limit objects that row 133's W-EQ-K produces and a NO at bounded complexity must cover — it needs both (b′) and
(b″). So: **decisive jointly with FS-114's four-colour form**, for aperiodic maps; a realised ray inside a full valid map would be a YES (`χ(ℝ²) ≤ 6`,
no MR), but a ray realised as a local fragment is only a local positive, which kills the four-colour route and leaves DENSE3's.

## What FS-112 established (addresses in `plans/FS112-derivation.md`)

- **Why chains can end** (FS112-FLANK, FS112-N2-FLANK-Q, FS112-N2-RAY): at a horn bound of exactly `±1`, FS-110's list of flank shadows gains an in-type
  flank tile at the arc's centre, and N4-STUCK's step (iv) fails; every such bound sits on a (Q) arc or an (R2) arc.
- **What every chain carries** (FS112-N3-CHAINS, two minds, one blind): neither curvature decreases along a chain and one strictly increases per step;
  over a finite set `K` of curvatures a chain has at most `2|K| − 3` vertices; **a ray needs boundary arcs of radius at least `k + 1` at its `k`-th
  vertex** (equality is the pencil). So a ray needs infinitely many arc radii, and **a doubly periodic map has none** — its terminal modification is
  periodic (FS112-N3-PER). Whether a non-periodic map with finitely many arc radii keeps finitely many in its terminal modification is GAP N3-ALPH
  (SHAVE's new circle has a shadow's exact curvature; a bend's tangent start one chosen in an interval).
- **What every end carries** (FS112-N3-END, two minds, one blind): at an end with horn bound `−1`, the next point carries at least four colours and a
  repeated colour, and a both-kind unit arc is centred two steps beyond; with FS-112's close, **the point one step beyond every finite end has at least
  four colours** (FS112-C-ENDS, one mind). So a ray's one end is anchored at a four-colour vertex; its vertices are repeated-colour vertices, consistent
  with DENSE3 along its line.
- **Y3's end analysis** (FS112-Y3-END-NEEDS, one mind; its blind verifier FS112-YB3 was running at the close — read its record first): keeping the end
  stuck and its unit-arc centre terminal needs at least five colours at the centre, and blocking both its MERGE and its SHAVE needs a seventh colour — so
  **no stuck chain of a terminal map ends at a unit arc while its end vertex has three colours**. If it holds, horn-bound-`±1` ends do not occur, and a
  ray's finite end, and every finite chain's ends, sit at a four-colour vertex of NB4P's kind or at an arc of the end vertex's own circle through the
  next point. Two scope points the close named: its setting excludes FLANK's in-type exception at the centre (the count seems to close there too, not
  said), and its corollary about periodic maps omits ends at four-colour vertices without a horn bound `±1`.
- **Held objects**: a finite chain `P_0, P_1, E` with the recursion taken with equality from the end (radii 3, 2, 1 about the centre `N`), realised
  exactly over ℚ with `N` completed two ways, neither terminal at `N` (FS112-Y3-END-AB, `tools/fs112_y3_chainend.py`). No ray, no terminal chain end,
  no chain longer than three is held.
- **Long chains are arithmetically free**: from one end `λ_k ≥ −1/(k+1)`, from the other `υ_k ≤ 1/(L − k + 1)`, compatible for every length `L`; each
  such chain needs about `L` distinct curvatures, which a map with infinitely many arc radii can supply (FS112-C-COMPOSE item 3). A Hausdorff limit at
  bounded complexity (W-EQ-K's) would turn long chains into a ray only if terminality and the stuck structure pass to limits — not derived.

## What is open, named

1. (b′): exclude or realise a one-sided stuck chain in a valid terminal map.
2. (b″): a uniform bound on finite chain length; or a derivation that unbounded lengths force a ray in a limit that is still valid and terminal.
3. N3-ALPH.
4. A second mind on Y3-END-NEEDS (if FS112-YB3 did not settle it) and its two scope points.
5. **The transverse structure of a ray**: what lies beside the line. A ray's own repeated-colour vertices satisfy DENSE3 within distance 3 of the line;
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
`[08.45]`–`[08.65]`, de Grey's rules; `[06.62]`–`[07.33]`, Gibbs's degree-4 enumeration, whose outputs are unheld); zbMATH `au:"Woodall, D"` for any
later treatment of his cones.

## Registered expectations (instruments for G21, scored at the close; never caps)

| expectation | p | both outcomes reachable |
|---|---|---|
| (b′) excluded at one mind within FS-115 | 0.35 | a derivation, or a local exact fragment family realising arbitrarily long one-sided chains |
| a family of chain fragments by formula, each member exact and terminal at its end, of unbounded length | 0.3 | the checker on named members; or a derived obstruction at the end |
| (b″) bounded (a uniform bound on finite chains) | 0.25 | a derivation, or a family of valid chains of every length |
| Y3-END-NEEDS holds as stated (a second mind) | 0.6 | FS112-YB3's verdict, or a terminal end fragment with a three-colour end vertex |
| a named obstruction or GAP as the product | 0.85 | — |

## Failure clauses

- A ray or a long chain realised as a local fragment is not a valid map: a local positive for the four-colour route, never a YES.
- An exclusion for doubly periodic maps only is FS112-N3-PER, already held; a result must reach aperiodic maps.
- A chain's end analysis that assumes N4-STUCK's structure at the next point measures that assumption (FS112-END's scope).
- A family of formula chains that all fail measures the family's image: state its free parameters against the recursion's.

## Deliverables

The plan with §G, §PA and §IQ; `plans/FS115-derivation.md`; exact chain fragments under `tools/fs115_*`, each given by formula and checked at named
members; verdicts on (b′), (b″) and N3-ALPH with their grades; the transverse structure of the extremal ray, derived.
