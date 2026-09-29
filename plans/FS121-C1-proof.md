# FS121-C1 — the cover route's NO: NO-PAR (Ephodos, derivation job)

*Ephodos (Opus 5.5), job FS121-C1, brief `data/fs121/briefs/FS121-C1-cover-route.md` with `plans/STANDING-RULES.md` as part of it. Plan:
`plans/FS121-map-step.md` § 4.1 (the trigger). I write only this record, `data/fs121/c1/`, `tools/fs121_c1_*.py` and
`data/fs121/reports/FS121-C1.md`. Entries use my identity's grammar: `hand` is [hand], `derived from` is [derived], `computed over` is [tools];
verdict `derived` is TRUE, `gap:` is GAP. Words are the proposed addendum's (`data/fs121/c1/proposed-claims.md` § 0): a locally finite **map
colouring**, `S_j`, `F_j = cl S_j`, **`j`-bound**, the **outer unit parallel** `{d_K = 1}` and **far level** `{D_K = 1}`, the class **`𝒫_k`**,
**Grundy-bound**, **G-FIN₆**.*

## Theorems this phase proved

- *(stage 1 proves nothing; it fixes the statements)*
- C121-C1-BOUND — in a locally finite map colouring a point of `F_i ∖ S_i` is `i`-bound iff it lies on the outer unit parallel or the far level of a
  component of `F_i` — [hand], one mind — § 2.1.
- C121-C1-GMAP — a Grundy-bound colouring that is a map colouring lies in `𝒫_k`; G-FIN₆ ∧ C121-NOPAR ⟹ `χ_m⁰(ℝ²) ≥ 7`, and given C121-NOPAR, G-FIN₆ ⟺
  `χ_m⁰(ℝ²) ≥ 7` — [derived], one mind — § 2.2.
- C121-C1-SAT — honest saturated segment-and-arc map colourings lie in `𝒫_k` in every order, so C121-NOPAR implies the honest route's NO — [derived],
  one mind — § 2.3.
- C121-C1-COVMAP — DISC7's merged map lies in `𝒫_7` under no order — [tools] exact over 5040 orders, one mind — § 2.4.
- C121-C1-FLAT — flat horn germs satisfy every flank relation of FS110-N4-FIN with equality, for every `k ∈ ℤ` — [tools] exact series, one mind — § 2.5.
- C121-NOPAR-C5 — GAP at N4-FIN (and the vertex data the class does not supply) — § 2.6.
- C121-NOPAR — GAP: it contains the honest route's NO with unit arcs (open), and C121-NOPAR-C5 — § 2.6.

## Would-have-searched-here log (standing rule 5)

- Stage 2: would have searched for a Grundy-bound six-map, or a Grundy-bound seven-map under Condition 5, or a map realising the flat horn chain.
  Did not: DISC7's merged map is checked at the one point the derivation names, over every order; the flat chain is a family of germs by formula.
- Stage 1: would have searched for a member of `𝒫_7` under Condition 5 (a Grundy-bound seven-map with no unit arc), to inhabit C121-NOPAR-C5's class at
  seven. Did not: the class is stated with the inhabitants held (SQ9, HEX9 at nine) and "none held at seven".

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript, no `chats-bak/`, nothing of FS121-V2's or FS116-V2's work, and write nothing where they
read: only the four paths above.

## Slips

- *(none)*

## Stage 1 — SAVED: the readback, the recognition, and the proposed statements

### 1.1 Readback of the brief

Every quotation in the brief, and every quotation the proposed statements use, checked verbatim by `tools/fs121_c1_quotes.py` against its source
(`data/fs121/c1/quotes.tsv`; output `data/fs121/c1/quotes.out`: **17 of 17 found**; the plant, one character changed, is reported missing). The brief's two
block quotations are items 1–2: the stub's rung (its sentence continues "a.e.-proper six-colouring.", which the brief elides and I quote whole) and the
plan's trigger. The brief's unquoted summaries agree with their sources: FS121-D3-GRUNDY ("the lower colour bound at every interface"), TOP₆ "at least
as strong as the claim" (D3 § 3.5: TOP₆ implies the claim and is not shown to follow from it), and D3 § 3.5's reading ("the cover route can run on Grundy
partitions", item 16, one mind). **No mismatch.**

My claims, restated: state NO-PAR precisely (class, colour count, "outer and far", *not claimed*, inhabitants, lemmas) in
`data/fs121/c1/proposed-claims.md`, commit it and send its path; then derive NO-PAR to a verdict, with an entry for every lemma.

control: FS121-C1-QUOTES
  of: C121-NOPAR — the readback and the proposed statements: every quotation the brief and the proposed statements use occurs verbatim in its source; with one character of the first changed, it
    is reported missing
  run: python3 ../tools/fs121_c1_quotes.py ../data/fs121/c1/quotes.tsv | tail -1
  expect: quotes: 17  found: 17  missing: 0
  fault: python3 ../tools/fs121_c1_quotes.py ../data/fs121/c1/quotes.tsv --plant | tail -2 | head -1

### 1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall read.** The rung arrived as "a wall that describes a counterexample" in the stub's words, and as "a known theorem that almost applies": row
134's NO holds for segment-and-arc maps under Condition 5 and "uses no complexity bound"; FS111-M2-DISCK7 shows that maximal classes need not have arc
boundaries. The plan says where the transfer is decided: row 134's N4 step.

**For the stranger** (a combinatorial geometer who works on map colourings of the plane): *The plane is cut by a locally finite graph of Jordan arcs into
faces, each given one of six colours, with no two points of one colour's open faces at distance exactly 1. The colours are ordered, and every point of an
edge between colours `i < m` is at distance exactly 1 from the closure of colour `i`. Show that no such map exists.* Words the reader stops at: none but
"at distance exactly 1 from the closure" — the one relation their field has no name for, and so the new part of the problem. The stub's words ("unit
parallels (outer and far) of their own classes' components") are that relation drawn: C121-C1-BOUND makes them the same.

**This is a** *Grundy (first-fit) colouring of the unit-distance graph that is also a map*: in a Grundy colouring every vertex of colour `m` has a neighbour
of every colour below `m`; here, every boundary point of colour `m` is a limit of points with such neighbours. The finite theory's standard fact is that
Grundy colourings cost nothing (greedy recolouring of an optimal colouring in the order of its classes); FS121-D3-GRUNDY is its measurable form. So the
Grundy condition alone decides nothing, and the whole content of NO-PAR is the conjunction *Grundy ∧ map*.

**Features, sorted** (determines / accompanies / unsorted, with receipts):

| feature | sort | receipt |
|---|---|---|
| six colours | determines | `𝒫_7` holds R7, `𝒫_9` SQ9 and HEX9 (saturated in every order, so bound in every order) |
| locally finite map | determines | without it, `𝒫_6 = ∅` would read "no Grundy-bound six-colouring", which is `χ_m⁰ ≥ 7` itself (GRUNDY is free) |
| one-sided binding (the lower colour) | determines what separates NO-PAR from the honest route's NO | two-sided binding with REG-J′ forces integer radii (FS111-M2-INTRAD); one-sided binding does not (DISCK7's curves are far levels) |
| "components of *their own* classes" | splits | on a partition, the map's classes; on a maximal cover, the cover's classes — and the map a cover yields is not bound in its own classes (C121-C1-COVMAP) |
| circularity of boundaries | accompanies NO-PAR's statement; consumed by row 134's chain | row 134's N4-FIN uses `λ_k < υ_k`, true of distinct arcs tangent at a point, false of smooth curves (C121-C1-FLAT) |
| Condition 5 | splits the class | edges on a unit circle are the unit-arc half, where FS-114/FS-116's NO lives; the rest is where row 134's chain would run |
| the order of the colours | accompanies membership in the saturated case | a saturated segment-and-arc map is in `𝒫_k` under every order (C121-C1-SAT) |

**Homes, each with its dictionary and its test.**
1. *Map colouring (Woodall, Townsend, Sokolov–Voronov, row 134).* Dictionary: face ↔ tile; edge ↔ boundary arc; bound ↔ a contact on `ω(x)`. Test: the old
   proofs apply once the boundary is a segment or a circular arc; the one step reading circularity beyond curvature at a point is N4-FIN (C121-C1-FLAT).
   **Kept**, as the home for C121-NOPAR-C5, with its changed step named.
2. *Spindle convexity and ball hulls (Bezdek and others: the intersection of the unit discs about a set, and bodies of constant width as its fixed
   points).* Dictionary: far level `{D_K = 1}` ↔ boundary of the unit ball hull; outer parallel ↔ boundary of the unit neighbourhood; DISCK7's body ↔ a
   diametrically complete set. Test: it explains FS111-M2-HULLC (iv) and DISCK7, and predicts a neighbour — the involution `ρ ↦ 1 − ρ` of radii across a
   far level. It says nothing about colours. **Kept as the geometry of the class, not its NO** (recalled, not read; the bibliography entries are owed if
   a later stage leans on it).
3. *Grundy colourings (first-fit, `b`-colourings).* Dictionary: bound ↔ "has a neighbour of that colour". Test: the finite theorem (Grundy costs nothing)
   carries across as FS121-D3-GRUNDY, and predicts that the regularity rung, not the Grundy condition, carries the difficulty (C121-C1-GMAP (ii)).
   **Kept** for the class's definition.
4. *Maximal covers (the stub's own reading of "their own classes").* Test: the merged map of DISC7 is bound by neither side colour at some edge point, in
   every order (C121-C1-COVMAP). **Killed as the home of the stub's frame**: on a cover the boundaries are self-parallel in the cover's classes, not the
   map's.

**The choice (mine to make, per the brief): the Grundy reading.** It is the one reading in which the map the route produces is in the stub's class
(C121-C1-GMAP (i)); the cover reading fails at DISC7 (C121-C1-COVMAP); and it contains the honest route's saturated maps (C121-C1-SAT). **A finding about
the frame**, for the coordinator: *the stub's NO-PAR, read on the map a maximal cover yields, is the wrong target — that map need not be self-parallel in
its own classes; on Grundy partitions it is the right target, one-sided.*

**Predicted neighbours** (each a lemma in the proposed list): C121-C1-BOUND (the stub's parallels are binding); C121-C1-GMAP (the route composes);
C121-C1-SAT (NO-PAR contains the saturated segment-and-arc NO, so the cover route's NO is at least the honest route's); C121-C1-COVMAP; C121-C1-FLAT (N4's
changed step). **Where the transfer from row 134 changes, named before deriving:** N4-FIN's strictness — a smooth horn can have both bounding curvatures
equal; and the class supplies no curvature data at vertices at all, only that edges lie on parallels.

### 1.3 The proposed statements

*(C121-NOPAR's opening entry, verdict "gap: every step", stood here at stage 1's commit; it is rewritten at the verdict, § 2.6.)*

`data/fs121/c1/proposed-claims.md`: C121-NOPAR, C121-NOPAR-C5 (the rung and its Condition-5 part); C121-C1-BOUND, C121-C1-GMAP, C121-C1-SAT,
C121-C1-COVMAP, C121-C1-FLAT (lemmas). Statements only, quotations checked (control FS121-C1-QUOTES). Sent to "main" at this stage's commit.

## Stage 1 — SAVED

## Stage 2 — SAVED: the lemmas, and the verdicts on C121-NOPAR and C121-NOPAR-C5

*The statements are frozen as `data/fs121/claims.md` § 7 (Keryx, 2026-09-29), verbatim from `bea3d339`; each entry below quotes them (checked against § 7 by script, equal up to markdown backticks: 7 of 7). Prior-art queries of
this stage (zbMATH Open API, 2026-09-29 07:12 UTC, `data/fs121/c1/zb/`; positive control `ti:"fall colorings of graphs"` → 3): `q1` = “(spindle convex |
ball hull | "constant width") & (coloring | colouring | chromatic) & distance” (3: two proceedings volumes and a book of etudes, none bearing);
`q2` = “(map | tiling) & (curved | smooth | "circular arcs") & "chromatic number" & plane” (1: a proceedings volume); `q3` = “("parallel curve" |
"parallel body" | "outer parallel") & (coloring | colouring | chromatic)” (0). FS121-D3's Grundy query stands beside them: “(Grundy | b-coloring |
b-chromatic) & (unit distance | plane | measurable)” (15, none on colourings of a continuum).*

### 2.1 C121-C1-BOUND

*Argument.* Let `x ∈ F_i ∖ S_i`. (⟸) If `d_C(x) = 1` for a component `C` of `F_i`, the distance is attained (`C` closed), at a point of `F_i` at distance 1.
If `D_C(x) = 1`, `C` is bounded, hence compact, and the supremum is attained. Either way `x` is `i`-bound. (⟹) Let `y ∈ F_i` with `|x − y| = 1`, and `C`
the component of `F_i` holding `y`; `C` is closed and connected, so for every `z` the values `|z − p|`, `p ∈ C`, form an interval from `d_C(z)`
(attained) to `D_C(z)`; hence `d_C(x) ≤ 1 ≤ D_C(x)`, and `T₁(z)` meets `C` whenever `d_C(z) < 1 < D_C(z)`. Suppose `d_C(x) < 1 < D_C(x)`. `d_C` is
1-Lipschitz and `D_C` is 1-Lipschitz or `≡ ∞`, so the strict inequalities hold on a ball `B` about `x`. `x ∈ F_i = cl S_i`, so `B` meets an open face
`R` of colour `i`; take `z ∈ B ∩ R` and `p ∈ C ∩ T₁(z)`. `p ∈ cl S_i`: take `p_n ∈ S_i`, `p_n → p`, and `z_n = p_n + (z − p_n)/|z − p_n|` (defined for
large `n`, as `|z − p| = 1`); `z_n → z`, so `z_n ∈ R` for large `n`, and `|z_n − p_n| = 1` with both points in faces of colour `i` — against the map
colouring's definition. So `d_C(x) = 1` or `D_C(x) = 1`. ∎

derivation: C121-C1-BOUND
  statement: in a locally finite map colouring, a point x of F_i ∖ S_i is i-bound if and only if it lies on the outer unit parallel or on the far
    level of a connected component of F_i
  uses only: that no two points of faces of one colour are at distance exactly 1 and faces are open; closedness and connectedness of components; the
    intermediate value theorem on a connected set; 1-Lipschitz d_C and D_C; no colour count, no local finiteness beyond F_i = cl S_i
  not claimed: which of the two levels; that the component is unique; anything at points of S_i
  converse: § 2.1 C121-C1-BOUND
  argument: § 2.1 C121-C1-BOUND
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: R7 — every edge point lies on a unit arc centred at a point carrying both side colours (FS111-VMW-R7-PPLUS's 432 of 432 arcs of kind
    both), so it is bound by both and lies on the far level of the component holding the centre; k = 9: SQ9, every edge point on the outer unit
    parallel of the square one unit across (FS111-W-LADDER)
  prior art: partly: FS111-M2-HULLC (iv) finds the near and far levels on a regular maximal cover's classes, one direction; for map colourings and with
    the converse not found — “("parallel curve" | "parallel body" | "outer parallel") & (coloring | colouring | chromatic)” (0), “(spindle convex | ball hull | "constant width") & (coloring | colouring | chromatic) & distance” (3), none bearing
  handoff: de Bruijn — queued behind the measurable chain (FS-113): a short lemma on closed connected sets and one perturbation

### 2.2 C121-C1-GMAP

*Argument.* (i) Let `(A_1, …, A_k)` be Grundy-bound and `A_j = S_j` a.e. for a locally finite map colouring. The support of a measurable set depends only
on its class mod null sets, and the support of a union of open faces is its closure (every ball about a point of the closure meets an open face in a
set of positive measure), so `supp A_j = F_j`. A point `x` of an edge separating colours `i < m` lies in `F_m = supp A_m`, so it is at distance exactly
1 from `supp A_i = F_i`: it is `i`-bound, and by C121-C1-BOUND (`x ∈ F_i ∖ S_i`, since `x` is on the edge) it lies on the outer unit parallel or the far
level of a component of `F_i`. So the map colouring is in `𝒫_k` under `1 < … < k`. (ii) If an a.e.-proper measurable six-colouring exists, G-FIN₆ gives a
Grundy-bound six-colouring a.e. equal to a locally finite map colouring, a member of `𝒫_6` by (i), against C121-NOPAR. So none exists: `χ_m⁰(ℝ²) ≥ 7`
(the definition, row 130). Conversely, if `χ_m⁰(ℝ²) ≥ 7`, G-FIN₆'s hypothesis is never met and it holds vacuously. ∎ *What it says* (FS111-C-REG-EQ's
caution, one rung over): G-FIN₆ is the map step in Grundy form; given C121-NOPAR it is the answer restated. Its content is its form: FS121-D3-GRUNDY
makes the Grundy condition free, so G-FIN₆ asks only that one of its outputs be a locally finite map — the cover route's MUA-FIN, on a partition.

derivation: C121-C1-GMAP
  statement: (i) for every k, a Grundy-bound k-colouring that is a.e. equal to a locally finite map colouring makes that map colouring a member of 𝒫_k
    under the order 1 < 2 < … < k; (ii) G-FIN₆ and C121-NOPAR together imply χ_m⁰(ℝ²) ≥ 7, and given C121-NOPAR, G-FIN₆ holds if and only if
    χ_m⁰(ℝ²) ≥ 7
  uses only: C121-C1-BOUND; supports are invariant under null changes and equal closures for open sets; the definition of χ_m⁰ (row 130); vacuity
  not claimed: G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring
  converse: § 2.2 C121-C1-GMAP
  argument: § 2.2 C121-C1-GMAP
  verdict: derived
  grade: derived from: C121-C1-BOUND
  minds: 1
  model: k = 7: R7 — every class a MUA set (FS111-VMW-R7-MAX), so it is Grundy-bound in every order, and a map colouring
  prior art: partly: the finite form (any proper k-colouring becomes a Grundy colouring with at most k colours) is classical, recalled, not read;
    “(Grundy | b-coloring | b-chromatic) & (unit distance | plane | measurable)” (15, FS121-D3), none bearing
  handoff: de Bruijn — queued behind the measurable chain, with FS121-D3-GRUNDY: two lines once map colourings and supports are in Lean

### 2.3 C121-C1-SAT

*Argument.* Let the classes of a locally finite map colouring whose edges are finite chains of segments and circular arcs form an honest saturated
colouring. Take an edge separating colours `i ≠ m` (an edge with one colour on both sides separates nothing and is not asked about). At an interior
point `x` of the edge off the finitely many joints of its chain, the edge is locally one segment or arc, the two faces beside it have colours `i` and
`m`, each of density `1/2` at `x`, and no other colour is near `x`: `P(x) = {i, m}` and `x` is a density point of no class, so it is an essential
boundary point, and saturation puts it at distance exactly 1 from `supp S_i = F_i` and from `F_m`. Such points are dense in the edge, and for each `j` the
set of `j`-bound points, `F_j + S¹`, is closed (a closed set plus a compact one); so every point of the edge is bound by both colours, and by
C121-C1-BOUND lies on a parallel of a component of each side's class — in particular of the lower one, in every order. ∎ **What it says.** The maps the
honest route produces (FS111-M2-REDUCE-A: honest saturation, REG-J′ and ¬LRA give "a segment-and-arc map, a.e.-proper", whose edges are the saturated
interfaces) are members of `𝒫_k`. So **C121-NOPAR implies the honest route's NO**: under Condition 5 that NO is row 134, and with unit arcs it is
FS-114's NO in the saturated class, open. *The cover route's NO is not an alternative to the honest route's: it contains it.* What the cover route trades
for honest saturation (TOP₆, FS121-D3) is a NO for one-sided binding in place of two-sided.

derivation: C121-C1-SAT
  statement: for every k, a locally finite map colouring with k colours whose edges are finite chains of segments and circular arcs, and whose classes
    form an honest saturated colouring, is a member of 𝒫_k under every total order of its colours; so C121-NOPAR implies that no honest saturated
    six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs
  uses only: C121-C1-BOUND; densities 1/2 on each side of a smooth arc; saturation at essential boundary points; closedness of F_j + S¹; no colour count
  not claimed: the converse (a member of 𝒫_k need not be saturated: one side of an edge may be unbound); anything for edges that are not finite chains
  argument: § 2.3 C121-C1-SAT
  verdict: derived
  grade: derived from: C121-C1-BOUND
  minds: 1
  model: k = 7: R7; k = 9: SQ9 and HEX9 (FS111-W-SQ9, FS111-W-HEX9: saturated, segments)
  prior art: new — “(map | tiling) & (curved | smooth | "circular arcs") & "chromatic number" & plane” (1), “(Grundy | b-coloring | b-chromatic) & (unit distance | plane | measurable)” (15), none bearing
  handoff: de Bruijn — queued behind C121-C1-BOUND and the saturated-colouring definitions (FS-113)

### 2.4 C121-C1-COVMAP

*Argument.* In DISC7 (hexagonal centres `m u + n w`, `u = (3/4, √3/4)`, `w = (0, √3/2)`, colour `(m − 2n) mod 7`, same-colour centres `√21/2` apart)
the six neighbours of a colour-`c` disc carry the six other colours, the opposite pair at `c ± 1`, `c ± 2`, `c ± 3`. Fix a total order; let `ℓ` be its
least colour and `c` its second, `d` the neighbour of the colour-`c` disc opposite its `ℓ`-neighbour (`d ∉ {ℓ, c}`, so `c` precedes `d`). Put
`x = q_c + (q_d − q_c)/√3`, the point of `c`'s circle toward `q_d`, and `y = 2q_c − x`, its antipode, toward `q_ℓ`. Then `|x − q_d| = √3/2 − 1/2 < 1/2`,
`x` lies on no other circle and in no other disc, so the faces at `x` are the lens `c ∩ d`, coloured `c` (the lesser), and `d ∖ c`, coloured `d`: `x` is
an edge point separating `c` and `d`. *Not `c`-bound:* the only point of disc `c` at distance 1 from `x` is `y` (the disc has diameter 1 and `x` is on its
circle); `y` lies inside disc `ℓ`, whose points all take `ℓ`, the least colour, so a neighbourhood of `y` holds no face of colour `c` and `y ∉ F_c`; every
other `c`-disc is farther than 1 from `x`. *Not `d`-bound:* disc `d` lies within `|x − q_d| + 1/2 < 1` of `x`, and every other `d`-disc is farther than
1. ∎ Checked exactly in `ℚ(√3)` by `tools/fs121_c1_disc7.py` (output `data/fs121/c1/disc7.out`): same-colour centres at least `√21/2` apart, the geometry
at each of the 42 (least, second) pairs, and **5040 of 5040** orders with an edge point bound by neither side colour. The plant `--cover` reads binding in
the cover's classes (whole discs), where `y` counts for `c`: **0 of 5040**. *(Tool history, G21: its first run put `√3/4` into `u`'s first coordinate, and 14
of the 42 pairs passed on the wrong lattice; a failing pair's coordinates exposed it.)*

**What it says.** On the cover, `x` *is* `c`-bound — `y` is in disc `c` — so the merged map's edges lie on parallels of the **cover's** components
(FS111-M2-HULLC (iv)), not of the **map's**. The stub's NO-PAR, read on the map the cover route makes (FS111-M2-REDUCE-C's merge), is the wrong target;
read on Grundy partitions (C121-C1-GMAP) it is the right one.

derivation: C121-C1-COVMAP
  statement: under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that order, of a disc containing
    them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in 𝒫_7 under no order
  uses only: DISC7's lattice and colouring (FS111-M2-DISC7); the merge rule of FS111-M2-REDUCE-C step (1); one point per (least, second) pair; exact
    arithmetic in Q(√3)
  not claimed: anything about other maximal covers, or about DISC7's classes themselves (each disc is its own far level); anything about the island fill
    of REDUCE-C's step (3), which does not touch the edges used
  argument: § 2.4 C121-C1-COVMAP
  verdict: derived
  grade: computed over: the 42 (least, second) pairs of DISC7's colours, 5040 orders, one period of the hexagonal lattice, exact in Q(√3)
  minds: 1
  model: DISC7 itself
  prior art: new — “(spindle convex | ball hull | "constant width") & (coloring | colouring | chromatic) & distance” (3), “("parallel curve" | "parallel body" | "outer parallel") & (coloring | colouring | chromatic)” (0), none bearing; DISC7 is FS111-M2's
  handoff: none — a property of a control object; exact and periodic, formalizable on demand

control: FS121-C1-COVMAP
  of: C121-C1-COVMAP — every order leaves an edge point of DISC7's merged map unbound on both sides; read in the cover's classes, none does
  run: python3 ../tools/fs121_c1_disc7.py | tail -1
  expect: orders with an edge point bound by neither side colour: 5040 of 5040
  fault: python3 ../tools/fs121_c1_disc7.py --cover | tail -1

### 2.5 C121-C1-FLAT — row 134's N4 step, read on smooth boundaries

*Where row 134's chain reads circularity.* In FS110-N4 the arcs enter twice: as the circle `Σ(C)` bounding a tangent tile's shadow (N4-SHADOW), which for
a smooth boundary is the tile's unit parallel, a circle only to second order; and in N4-FIN's hypothesis `λ_k < υ_k`, which the record quotes as necessary
("strictness `λ_k < υ_k` is necessary, the constant `(0, 0)` survives otherwise"). Two distinct circular arcs tangent at `P_k` have different curvatures,
so a horn between arcs has `λ_k < υ_k`; two distinct smooth curves need not. Every comparison of curvatures the chain makes at `P_k` is a second-order
comparison of germs, and at equal curvature the order is decided at higher order.

*The family.* `L_k` is the line through `P_k` along `a`; `U_k` is the parallel at signed distance `k` of the germ `y = x⁴` at `P_0`. The unit parallel toward
`P_k` of `L_{k+1}` is `L_k` (a line's parallel is a line). The unit parallel toward `P_k` of `U_{k−1}` is `U_k`: parallels compose along shared normal lines,
checked through `X⁶`. As exact series, `U_k`'s height over `L_k` is `X⁴ + 8kX⁶ + O(X⁸)` — positive on both sides of `P_k` for every `k ∈ ℤ`, with
curvature 0. ∎ Checked by `tools/fs121_c1_flat.py` with `t` symbolic (output `data/fs121/c1/flat.out`); the plant `--circle` starts from `y = x²/20`
(curvature `1/10`, a circle to second order) and its chain leaves `(−1, 1)` at `k = 9` — N4-FIN's mechanism, firing.

**What it says.** Read on germs at the chain's points, N4-FIN's flank relations hold with equality along a bi-infinite chain of flat horns, so the step does
not transfer from arcs to smooth boundaries: the NO for NO-PAR's Condition-5 part needs, at N4, something beyond the flank relations at `P_k`. *A reading
(one mind), with its test:* the missing input is exactly what two-sided binding supplies. In the flat family every interface is the unit parallel of its
neighbours on both sides; if such germs sat in an honest saturated map with REG-J′, FS111-M2-INTRAD would give them integer radii of curvature almost
everywhere, and `U_k`'s curvature, `12X²` to leading order, is not — so the saturated class never meets a flat horn, and the one-sided class has no such
theorem. Killing test: a proof of C121-NOPAR-C5 that reads only germs at the chain's points, or a member of `𝒫_k` (any `k`) realising a flat horn.

derivation: C121-C1-FLAT
  statement: there are germs L_k, U_k at P_k, for every k ∈ ℤ, with U_k > L_k on both sides of P_k, every one of curvature 0 at P_k, such that for
    every k: L_k is the unit parallel toward P_k of L_{k+1}, and U_k is the unit parallel toward P_k of U_{k−1}
  uses only: the parallel of a line is a line; the exact series of the parallels of y = x⁴ at every signed distance t, and their composition, through
    X⁶ (t symbolic); no colour count
  not claimed: that any locally finite map colouring realises these germs; anything about the other steps of row 134's chain on smooth boundaries;
    that a jet argument of higher order cannot replace N4-FIN in some class
  argument: § 2.5 C121-C1-FLAT — row 134's N4 step, read on smooth boundaries
  verdict: derived
  grade: computed over: {the parallel of the germ y = x⁴ at signed distance t : t ∈ ℝ}, t symbolic, as exact power series through X⁶, and the
    composition of each with a unit step
  minds: 1
  model: the family itself (L_k lines, U_k the parallels of y = x⁴)
  prior art: partly: FS110-NB4's plant records that the constant sequence (0, 0) survives N4-FIN's recursion without strictness; its realisation by
    smooth horns not found — “(map | tiling) & (curved | smooth | "circular arcs") & "chromatic number" & plane” (1), “("parallel curve" | "parallel body" | "outer parallel") & (coloring | colouring | chromatic)” (0), none bearing
  handoff: none — a statement about where a route stops; exact, formalizable on demand

control: FS121-C1-FLAT
  of: C121-C1-FLAT — the parallels of y = x⁴ stay flat horns above the line at every distance; from a circle-like germ the chain leaves (−1, 1)
  run: python3 ../tools/fs121_c1_flat.py | tail -1
  expect: FLAT CHAIN: ALL HOLD (for every t: Y - t = X^4 + O(X^6), curvature 0, strictly above the line)
  fault: python3 ../tools/fs121_c1_flat.py --circle | tail -1

### 2.6 The verdicts

**C121-NOPAR-C5 — GAP.** Row 134's chain proves the NO for segment-and-arc maps under Condition 5 and "uses no complexity bound"; `𝒫_6`'s members under
Condition 5 have edges that are only Jordan arcs lying on parallels of their lower colours' components. The transfer stops at two named places: **the
vertex data** — every step from N3-CONF on reads one-sided tangents and the curvatures of the arcs bounding a horn, which the class does not supply (a
parallel of a compact set has an exterior ball on one side and may have corners); and, with that data granted for smooth edges, **N4-FIN**, whose
strictness smooth horns do not have (C121-C1-FLAT). The steps between (W-MERGE, N4-SHAVE, N4-RAY, N4-TERM) are not re-derived for non-circular edges
here. *Inhabitants of the class:* `k = 9`, SQ9 and HEX9; none held at seven.

**C121-NOPAR — GAP.** `𝒫_6` is empty iff its members under Condition 5 are none (C121-NOPAR-C5, GAP above) and its other members are none. The second part
contains every honest saturated six-map bounded by segments and circular arcs with an arc of radius 1 (C121-C1-SAT, every order), whose NO is FS-114's in
the saturated class — open, FS-116's question on the honest route. So a proof of C121-NOPAR must contain that NO, and the cover route in Grundy form
(C121-C1-GMAP (ii)) reaches seven only through it. *Where six is spent:* nowhere in the lemmas; only in the NO itself.

derivation: C121-NOPAR-C5
  statement: no member of 𝒫_6 satisfies Condition 5
  argument: § 2.6 The verdicts
  verdict: gap: the transfer of row 134's chain from segment-and-arc edges to edges lying on unit parallels — first at the vertex data (one-sided
    tangents and horn curvatures, which the class does not supply), then at FS110-N4-FIN, whose strictness λ_k < υ_k smooth horns lack: flat horns
    satisfy every flank relation with equality for every k (C121-C1-FLAT)

derivation: C121-NOPAR
  statement: 𝒫_6 is empty: no locally finite map colouring with six colours has a total order on its colours in which every point of every edge
    separating colours i < m lies on the outer unit parallel or on the far level of a connected component of F_i
  argument: § 2.6 The verdicts
  verdict: gap: two named steps — its members failing Condition 5 include every honest saturated six-map bounded by segments and circular arcs with a
    unit arc (C121-C1-SAT), whose NO is FS-114's NO in the saturated class, open; and its members under Condition 5 are C121-NOPAR-C5, GAP at the
    vertex data and at FS110-N4-FIN

**For the route choice (a reading, one mind).** The cover route (Grundy form) needs G-FIN₆ and C121-NOPAR; the honest route needs TOP₆, REG-J′₆, ¬LRA and
the saturated NO. C121-NOPAR contains the saturated NO, so **the cover route does not go around FS-116: it needs FS-116's NO and more.** What it trades
for honest saturation is exactly one-sided binding, and the one place in row 134's chain where that costs something at the germ level is N4-FIN, where
two-sided binding (through INTRAD) would have supplied circularity. Killing test: a derivation of C121-NOPAR-C5 or C121-NOPAR that uses no step of
FS-114/FS-116's NO and no circularity.

### 2.7 The invention signal (G87)

Read for, in every source of this job. **None found.** One framing tension, not two truths: the plan weighed the cover route as removing "the honest
route's hardest rung", and C121-C1-SAT shows its NO contains the honest route's NO; both hold (the rung removed is TOP₆, the NO added is larger).

## Stage 2 — SAVED
