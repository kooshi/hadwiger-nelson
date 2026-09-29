# FS121-C1 — the cover route's NO: NO-PAR (Ephodos, derivation job)

*Ephodos (Opus 5.5), job FS121-C1, brief `data/fs121/briefs/FS121-C1-cover-route.md` with `plans/STANDING-RULES.md` as part of it. Plan:
`plans/FS121-map-step.md` § 4.1 (the trigger). I write only this record, `data/fs121/c1/`, `tools/fs121_c1_*.py` and
`data/fs121/reports/FS121-C1.md`. Entries use my identity's grammar: `hand` is [hand], `derived from` is [derived], `computed over` is [tools];
verdict `derived` is TRUE, `gap:` is GAP. Words are the proposed addendum's (`data/fs121/c1/proposed-claims.md` § 0): a locally finite **map
colouring**, `S_j`, `F_j = cl S_j`, **`j`-bound**, the **outer unit parallel** `{d_K = 1}` and **far level** `{D_K = 1}`, the class **`𝒫_k`**,
**Grundy-bound**, **G-FIN₆**.*

## Theorems this phase proved

- *(stage 1 proves nothing; it fixes the statements)*

## Would-have-searched-here log (standing rule 5)

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

derivation: C121-NOPAR
  statement: 𝒫_6 is empty: no locally finite map colouring with six colours has a total order on its colours in which every point of every edge
    separating colours i < m lies on the outer unit parallel or on the far level of a connected component of F_i
  argument: § 1.3 The proposed statements
  verdict: gap: every step — the statement is fixed at this stage, as proposed, and not yet derived; this entry is rewritten at the verdict stage

`data/fs121/c1/proposed-claims.md`: C121-NOPAR, C121-NOPAR-C5 (the rung and its Condition-5 part); C121-C1-BOUND, C121-C1-GMAP, C121-C1-SAT,
C121-C1-COVMAP, C121-C1-FLAT (lemmas). Statements only, quotations checked (control FS121-C1-QUOTES). Sent to "main" at this stage's commit.

## Stage 1 — SAVED
