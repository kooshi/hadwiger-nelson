# FS-136 — the point across: covering pairs, the table, and what a seed forces: the derivation file

*The theorem record of FS-136 (two meeting points of a measurable six-colouring whose colours together are all six, and the
points one unit from both), filed by its record job FS136-Z1 on 2026-10-07 (UTC). Every `derivation:` and `control:` block
below but two is copied by script, character for character, from the record of the deriver who wrote it — the first round's
`plans/FS136-E1-derivation.md` (R1; ten entries, seven controls) or the second round's `plans/FS136-E2-derivation.md` (R2; ten
entries, eight controls) — and its argument is an address in that record (`data/fs136/z1/build_derivation.py`; `--check`
compares this file with what the script writes). The two that are not copies are marked **the record job's**: the entry
C136-STOP-BOWTIE-SIX, which the first deriver wrote as a dated note and left to this job, and its control. The prose between
the blocks is the record job's and proves nothing. Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all
FS136-derivation.md`, from `plans/` (some minutes: sixteen controls, each run twice).*

**The grade of everything here.** Twenty-one entries, each **derived**: twenty of two derivers and one restated form. Each is
[hand], derived from [hand] entries, or computed over a named finite set with exact arithmetic — **one mind each, kernel
pending**. **Every statement is about weak colourings that already have named regions (pieces, tiles) or corners; no weak
six-colouring is known to have one.** So: **no entry excludes a weak six-colouring of a disc; none fixes or bears on the
value of χ(ℝ²)**; every exclusion is of the colourings that keep named tiles, or their germs, of one held object; and the one
entry that forces a region of definite extent (C136-COLLAR, § 2) starts from a point that already carries all the labels but
one, which somebody must supply. **The kernel lane's state on 2026-10-07**, said exactly: the disc criterion of the
milestone before is held (FS124-L1, through the gate); the nine statements of that milestone's second module — among them
the one-member form of this milestone's head statement, `ae_onSide_of_label` — are kernel-checked on a branch, not through
the gate; **nothing of this milestone's own twenty-one is in the kernel** (its kernel planner, FS136-K1, was
launched blind at 19:20 UTC on seven of the statements). One statement was reached by two jobs on one
route (§ 1): its count of minds is one.

## How to read this file

**Order.** Each section is a chain: its head is the strongest form, and the entries marked *corollary* are weaker forms,
each under the name its deriver gave it. No name is retired. Where two forms are both held and neither contains the other,
the line under them says so. § 3 is computed closures (instances of § 2's C136-CLOSE on named corners); § 6 is the reading
of the held objects, which is [tools].

**Class** — the objects an entry speaks of: *every weak `k`-colouring of an open set* (a measurable map to `k` labels,
proper at almost every unit pair inside the set) *with the named pieces or corners*; *sector points* (FS-124's); *one held
family* (named tiles, or their germs, of one object this project holds); *one seed* (named labelled corners of one object);
*plane geometry* (no colouring). **Count** — whether the argument spends a number of labels: *none read*; *all the labels*
(the statement is put at six and its argument reads only that the named families carry every label — it holds at any
number, and the tight seven-colouring R7 obeys it at seven); *six* (a held six-coloured object). **Calibration** marks an
entry or control at seven, on R7, which has no margin anywhere.

**Definitions.** `S(p)`, `B(p, r)`, *weak `k`-colouring*, *piece*, *pieced point*, *inner*, *outer*, *crossing*,
*separates*, *covering pair*, *common unit points*, *the point across*: `data/fs136/claims.md`, "Definitions, stated once".
*Family of pieces at `x`*, *inner-pure*, *outer-pure*, *barred at `w`*, *separates at `w` by labels*: the same file, the
dated line of 16:06 UTC, "Added by this plan". *Corner*, *labelled corner*, a colouring *has* a labelled corner, a corner
*inner*, *outer*, *crossing at `w`*, *the corners at `w` cut by* unit circles, *forces*, *empties*, *the forced closure in
`U`*: the same file, the dated line of 18:25 UTC, "Added by this round". *Sector point*, *edges*, *full*:
`plans/FS124-E2-derivation.md` § Notation used by every entry. *A cell* at `w`: the points near `w` on chosen sides of the
members' unit circles (R1 § 2.1); by C136-CORNERS a cell is one corner, or two.

**The held objects named below.** FS-112's strip (`[AxenovichEtAl2014]`'s, as built in `tools/fs112_yb2_objects.py`);
`[Polymath2021]`'s disk (the same tool); FS116-Y2-SIXFRAG, "the flower" (`tools/fs116_y2_six.py`); FS114-Y2-BOWTIE, "the
bowtie fragment" (`tools/fs114_y2_k1.py`); R7, the tight seven-colouring by unit Reuleaux triangles on the triangular
lattice. Each stops at a point — the strip at `(1/4, √15/4 + √3/2)`, the disk at a rim point, the flower and the bowtie
fragment at `(√3, 0)` — called its *stop*.

## 1 The table at a point, and the two counts

*The head statement of the milestone. In its deriver's words (R1, "Theorems this phase proved"): "near a point with
finitely many members one unit away, almost every point's label is pure, on that point's side, at every member that has
it. Any number of members, pieces, labels." **Two jobs reached it on one route**: this milestone's first deriver, over
finitely many members, and the kernel planner of FS-124's second module, blind, at one member (`ae_onSide_of_label`). In
the deriver's words (R1 § 3.0 item 1): "**Reached by two minds** … **and one route**: C124-TYPE per piece, then
finiteness. Not two independent derivations: same lemma, same step. What this record adds to G6 is no mathematics: the
words (inner-pure, outer-pure, barred; a cell), the reading of held objects in them, and the use as an exclusion criterion".
Its count of minds is one.*

derivation: C136-TABLE
  statement: Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_m distinct points with |x_i − w| = 1, and 𝒫_i a family of pieces at x_i. Then there is η > 0 such that almost every point z of B(w, η) has a label a with the property: for every i such that a is a label of 𝒫_i, a is inner-pure at w for 𝒫_i if |z − x_i| < 1, and outer-pure at w for 𝒫_i if |z − x_i| > 1.
  uses only: C124-TYPE (`plans/FS124-derivation.md` § 2; [hand] over C124-SHADOW-OPEN, one mind — inherited; its argument read whole, C124-SHADOW-OPEN's read at its statement) once for each piece and each side on which the piece has a point; that a non-empty open set inside a closed disc has a point of the open disc; that the families and the set of members are finite. Not consumed: the number of labels; that the pieces of one member are disjoint, have different labels or fill a neighbourhood; |x_i − w| = 1 (the kernel planner's G3) — it is in the statement because the cells are cut at w by circles through w
  not claimed: that a weak colouring has a piece; anything about a label of no 𝒫_i (it is unconstrained); a converse — a label left at every cell does not give a colouring; the largest η (it is half the least witness depth: for a piece crossing by a thin horn it is of the order of the horn's width)
  argument: FS136-E1-derivation.md § Argument — the table
  verdict: derived
  grade: hand
  minds: 1
  model: every held object at every common unit point of a covering pair inside it: 105 points of the strip, 60 of the disk, 42 of FS116-Y2-SIXFRAG, 34 of FS114-Y2-BOWTIE, 22 of the small fragments and the kept model, and at seven 96 of R7 — no sample off its cell's labels (controls `rings-held`, `rings-strip`, `rings-small`, `rings-r7`)
  prior art: partly: for maps, whole tiles and two members it is FS110-N-SEAM (b) with N-E2 (`plans/FS110-derivation.md` l. 189, `plans/FS110-N-proof.md` ll. 96–119; two minds, one blind); at one member it is the kernel planner's G6, `ae_onSide_of_label` (FS124-K2, blind, one mind, typed in a skeleton, not in the kernel) — the same route; C124-FORCED-PIECES's first half for three pieces of different labels; print: plan §PA item 2 and zbMATH "ab:"unit circle" & ab:colo* & ab:plane & ab:"chromatic number" & (ab:boundary | ab:arc | ab:arcs)" (1), "ab:"distance 1" & ab:colo* & ab:plane & (ab:trichromatic | ab:"three colo*" | ab:tricolo*)" (0) — not found
  handoff: de Bruijn — it is `ae_onSide_of_label` at each of finitely many members, intersected; read the formal statement back against "every piece of that label", not "some piece"

**Class**: every weak `k`-colouring of an open set; finitely many points one unit from `w`, each with finitely many pieces.
**Count**: none read ("Not consumed: the number of labels", its *uses only* line). **What it does not claim**, first: "that
a weak colouring has a piece"; and "a converse — a label left at every cell does not give a colouring". **What is new**, in
its deriver's words: "for maps nothing (FS110-N-SEAM (b)); in measure, beyond C124-FORCED-PIECES: any number of members,
pieces and labels, labels repeated at a member, and the conclusion on labels." **What rests on it**: C136-COVER, C136-ONE,
C136-FORCED (§ 2, its forward half), the five whole-tile exclusions and the flower's germ form (§ 4). **Kernel**: its
one-member form is `ae_onSide_of_label`, kernel-checked on a branch in FS-124's second module, not through the gate; the
statement over finitely many members is for this milestone's own module, whose planner was launched, blind, while this file
was being filed (FS136-K1; FS-136 inventory item 16).

derivation: C136-COVER
  statement: Let c be a weak six-colouring of U, x, y points with 0 < |x − y| < 2, 𝒫_x, 𝒫_y families of pieces at x and at y such that each of the six labels is a label of 𝒫_x or of 𝒫_y, and w a point of U with |w − x| = |w − y| = 1. Then x or y separates at w by labels: one of the two families has a label all of whose pieces are inner at w and another label all of whose pieces are outer at w.
  uses only: C136-TABLE with m = 2; that 0 < |x − y| < 2 makes w − x and w − y linearly independent, so each of the four cells cut at w by S(x) and S(y) meets every ball about w in a non-empty open set; that every label is a label of 𝒫_x or of 𝒫_y — where "six" is read, and it is read as "all the labels"; the identity (A ∨ C)(A ∨ D)(B ∨ C)(B ∨ D) = AB ∨ CD
  not claimed: that a weak six-colouring has a pieced point or a covering pair; which member separates; that the two pure labels' pieces share more than the member; that separation suffices for w to be coloured — on FS116-Y2-SIXFRAG and FS114-Y2-BOWTIE a member separates at a point across and a cell is empty (Stage 5); anything for a pair whose labels are not all the labels (at seven, six of seven: C124-FORCED-SEVEN)
  argument: FS136-E1-derivation.md § Argument — the count for two members, and for one
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: FS116-Y2-SIXFRAG at w = (−1, −1): x = e(180°) with labels 2, 3, 5 does not separate; y = e(270°) with labels 0, 1, 2, 4 has 0 inner-pure and 1 outer-pure; at seven, R7's 54 pairs of lattice points carrying all seven labels, each with a full table at its common unit points inside (control `rings-r7`)
  prior art: known for maps: FS110-N-SEAM (a)–(b) with FS110-CALC's A-EXACT — "the union of the closure types is all six; disjointness is an extra hypothesis where a lemma needs it" (`data/fs110/claims.md` l. 327), members of any number of colours, families of any size, two and three minds; in measure, for two disjoint triples of three pieces: C124-FORCED-PIECES; for any two finite families, with the conclusion on pieces: the kernel planner's G5 (blind; the same route as mine); the conclusion on labels: here; print: not found (plan §PA)
  handoff: de Bruijn — after `ae_onSide_of_label`: four non-empty open cells and one identity; the statement to read back is "a label all of whose pieces", since "an inner piece and an outer piece" is met by one region cut along the circle

*Corollary of C136-TABLE at two members.* **Class**: weak colourings whose labels are all carried by the two families.
**Count**: all the labels (stated at six; "where 'six' is read, … it is read as 'all the labels'"). **The posed form is its
case with a weaker conclusion**: the card's "has an inner and an outer piece" is met by one one-label region cut in two
along the unit circle, so the claim was restated on labels before it was derived (the claim list's dated line of 16:06 UTC);
C124-FORCED-PIECES (FS-124) is its case for two disjoint triples of three pieces. **One route with the kernel planner's
`exists_inner_outer_of_cover`** (its G5, which concludes on pieces): "My route is the kernel planner's …; it is not a second
derivation." **What it does not claim**, first: "that separation suffices for w to be coloured — on FS116-Y2-SIXFRAG and
FS114-Y2-BOWTIE a member separates at a point across and a cell is empty". **Kernel**: none; the label form is a statement
for this milestone's module — to read back against "a label all of whose pieces", its `handoff:` line.

derivation: C136-ONE
  statement: Let c be a weak six-colouring of U, p a point with a family 𝒫 of pieces at p whose labels are all six, and w a point of U with |w − p| = 1. Then there is η > 0 such that almost every point of B(w, η) inside the unit circle about p has a label inner-pure at w, and almost every point of B(w, η) outside it a label outer-pure at w; so p separates at w by labels, and no label is present near w on both sides of that circle.
  uses only: C136-TABLE with m = 1; that every label is a label of 𝒫; that both half-balls have positive measure
  not claimed: that a weak six-colouring has a pieced point with six labels; that one label fills a side; that the points near w belong to the pieces of p — only that their labels are labels of pieces of p lying on that side; anything at seven (R7's lattice points carry six of seven, and the seventh fills their rings' gaps)
  argument: FS136-E1-derivation.md § Argument — the count for two members, and for one
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: FS116-Y2-SIXFRAG's vertex p: its six sectors; at each ring point read, the sectors' labels inside and other labels of p outside (`data/fs136/e1/out/sixfrag.txt`: the twelve common unit points with six labels are p itself, read as a common unit point of six pairs; the ring points carry three and four labels, all labels of p)
  prior art: partly: for maps FS116-N2-SIXRING ("the ring lies in Γ … every ring arc is a (Q) arc"; one mind, non-Siamese) and FS112-SIX (two minds, by FS116-Y2's § 2.3; not read by me); the asking lane posed this form (`plans/POROS-2026-10-07-fs124-round2.md` § 4.1); print: de Grey's and Gibbs's six-sector picture ([Polymath16threads] [08.17]–[08.18], by FS116-Y2's reading, not read by me) — the statement not found
  handoff: de Bruijn — `ae_onSide_of_label` with the cover sentence at one point; one line after it

*Corollary of C136-TABLE at one member.* **Class**: weak colourings with a point whose family carries all the labels.
**Count**: all the labels (stated at six). **Verdict on the claim as posed**, its deriver's: "derived, in the label form
(the posed 'has the label of a piece of `p` inner at `w`' is weaker where two pieces of `p` share a label)". For maps it is
FS116-N2-SIXRING without the map and the non-Siamese clause, "at that price: the conclusion is about labels on the two
sides of the ring, not about which tile lies there". C136-COLLAR (§ 2) is the neighbouring statement for a point that lacks
one label. **Kernel**: none.

control: rings-r7
  of: C136-TABLE — at seven, on R7 (25 Reuleaux tiles and 25 concave tiles about the origin): every lattice point read carries six of the seven labels, two adjacent ones carry all seven between them, and at every common unit point inside the table holds with no cell empty. The fault moves one member of every pair by 0.01
  run: python3 ../data/fs136/e1/rings_read.py r7 --brief
  expect: r7: labels=7 members=16 centres=16 covering-pairs=54 on-a-ring=54 inside=96[L2:96] violations=0 not-inside=12[L2:12] least=1.7321:8 stop-class=L2:12
  fault: python3 ../data/fs136/e1/rings_read.py r7 --brief --fault

control: cover-count
  of: C136-COVER — the count as a function of the states alone: over the 50,625 assignments, to four labels, of a state at x and a state at y (inner-pure, outer-pure, barred, or not a label of that member; not absent at both), the number in which each of the four cells has a label no state bars and neither member has an inner-pure and an outer-pure label; the fault lets a label barred at x serve x's cells
  run: python3 -c "import itertools as I;S=['in','out','bar','-'];print(sum(all(any(a in (s,'-') and b in (t,'-') for a,b in st) for s in ('in','out') for t in ('in','out')) and not ((any(a=='in' for a,b in st) and any(a=='out' for a,b in st)) or (any(b=='in' for a,b in st) and any(b=='out' for a,b in st))) for st in I.product([(a,b) for a in S for b in S if (a,b)!=('-','-')],repeat=4)))"
  expect: 0
  fault: python3 -c "import itertools as I;S=['in','out','bar','-'];print(sum(all(any(a in (s,'-','bar') and b in (t,'-') for a,b in st) for s in ('in','out') for t in ('in','out')) and not ((any(a=='in' for a,b in st) and any(a=='out' for a,b in st)) or (any(b=='in' for a,b in st) and any(b=='out' for a,b in st))) for st in I.product([(a,b) for a in S for b in S if (a,b)!=('-','-')],repeat=4)))"

*`rings-r7` is a **calibration at seven**: a [tools] reading in floats, on R7. It also carries the correction of the stub's
first control ("R7 has no covering pair" is false as reasoned: two adjacent lattice points lack different labels and carry
all seven between them; the dated correction stands in the stub).*

## 2 The forward step: corners, the closure, the collar

*The table read forward. Two lemmas of plane geometry say what a cell is and how a corner is classed; C136-FORCED says that
a corner on which the pieces one unit away bar every label but one has that one label; C136-CLOSE chains the step; and
C136-COLLAR is the step at one member taken along an arc. **What the step forces is a germ** — in C136-CLOSE's own *not
claimed* line: "no region of definite size is forced, and a closure all of whose corners at every point reached are forced
is a set of vertex figures, not a coloured fragment". The exception is the collar, and only from a point that already
carries all the labels but one.*

derivation: C136-CORNERS
  statement: Let w be a point and x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1. There is ρ₀ > 0 such that for every 0 < ρ ≤ ρ₀ the disc B(w, ρ) less w and the circles S(x_i) is the disjoint union of 2m connected open sets, each with w in its closure and each lying inside or outside each S(x_i) — the sets Σ_ρ of the 2m corners at w cut by those circles; and two of them lie on the same side of every S(x_i) exactly when m = 2, x_1 + x_2 = 2w, and they are the two outside both circles.
  uses only: inversion in S(w) — a unit circle through w goes to a line at distance 1/2 from w and its inside to the half-plane beyond that line; that outside a disc holding every crossing point of m distinct lines their complement is 2m connected regions, one between each two cyclically consecutive ends; that a cell of a line arrangement is convex and that a convex set with two ends at infinity contains a line
  not claimed: anything about a colouring; a value of ρ₀
  converse: FS136-E2-derivation.md § Converse — two corners on the same sides
  argument: FS136-E2-derivation.md § Argument — the corners at a point
  verdict: derived
  grade: hand
  minds: 1
  model: w = (0, 0) with the members (1, 0), (−1, 0) — four corners, two of them outside both circles; with (1, 0), (0, 1) — four corners with four different sides; with all three — six with six (control `corners-selftest`, its last three cases); and R7 at (1/2, √3/2) seen from (0, 0) and (1, 0): corners of 120°, 60°, 120°, 60° (`data/fs136/e2/out/r7.txt`)
  prior art: known: elementary plane geometry (inversion at a common point of circles; the unbounded cells of an arrangement of lines); no source read, and nothing rests on one
  handoff: none — the kernel's statement of C136-FORCED can be on the cell (the points on the chosen sides), which needs no connectedness; this lemma crosses only with a consumer of "is a piece"

*A lemma.* **Class**: plane geometry; no colouring. It is why "the cell" of the card is one connected corner — or two, the
horns outside two unit circles tangent at the point. **What rests on it**: C136-FORCED ("connected, with w in its
closure"), every table of §§ 3–4. **Kernel**: none; "this lemma crosses only with a consumer of 'is a piece'".

derivation: C136-CLASS
  statement: Let Σ = (x; γ₁, γ₂) be a corner and w a point with |w − x| = 1. Order the curves from x that are rays or circular arcs cyclically, counter-clockwise by direction at x and, for one direction, by signed curvature (positive when the centre is to the left). Let β₋, β₊ be the two branches of S(w) at x, β₋ the one whose counter-clockwise neighbours are inside S(w). Then Σ is inner at w exactly when β₋ ≤ γ₁ < γ₂ ≤ β₊ in that order counted from β₋, and outer at w exactly when β₊ ≤ γ₁ < γ₂ ≤ β₋ counted from β₊.
  uses only: inversion in the unit circle about x — a ray from x goes to its own far part, a circle of radius R through x to a line at distance 1/(2R) from x, so a curve of direction d and signed curvature κ goes to the end in direction d of the line at signed offset κ/2 to the left of d; that outside a large disc finitely many half-lines with distinct (direction, offset) are disjoint and lie in the cyclic order of (direction, offset); that the closed unit disc about w goes to a closed half-plane whose far part lies between the ends β₋ and β₊
  not claimed: anything for edges that are not rays or circular arcs; a depth for the points a corner that is not inner has strictly outside S(w) (it is of the order of ρ when an edge direction is transversal to S(w) on the wrong side, and of ρ² when the wrong side is reached only along an edge tangent to S(w))
  converse: FS136-E2-derivation.md § Converse — a corner that is not between the branches
  argument: FS136-E2-derivation.md § Argument — the class of a corner
  verdict: derived
  grade: hand
  minds: 1
  model: x = (0, 0), w = (1, 0): the quarter-planes about the directions 0° and 180° are inner and outer; the right half-plane is crossing (its edges are rays tangent to S(w), outside it at second order); the horn between S(w) and the unit circle about (−1, 0) is outer; the horn between S(w) and a circle of radius 1/2 inside it is inner (control `corners-selftest`, eleven cases, each read exactly and by samples)
  prior art: known: elementary (order of contact of circles at a common point); for maps the cone calculus of FS-116 reads directions only and says "tangent" where this reads curvature (first round, Stage 1, last row of its table); no source read
  handoff: none — it is what makes a table a finite exact computation; the kernel needs it only if a computed closure is to be checked there

*A lemma.* **Class**: plane geometry; corners bounded by rays and circular arcs. A corner's class at a point one unit away
is decided by direction and then by signed curvature — "it is what makes a table a finite exact computation". **What rests
on it**: every class read in §§ 3–4 and C136-COLLAR's hypothesis. The gate's one warning on this file's source is here: the
statement is two-way and its control (`corners-selftest`) is read as one direction; its eleven corners include both.

derivation: C136-FORCED
  statement: About weak colourings that have the named pieces; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1, 𝒫_i a family of pieces at x_i, Σ one of the corners at w cut by S(x_1), …, S(x_m), and ℓ a label such that every label other than ℓ is a label of some 𝒫_i that is not inner-pure at w for 𝒫_i if Σ is inside S(x_i), and not outer-pure at w for 𝒫_i if Σ is outside S(x_i). Then there is η > 0 such that Σ_η is a connected open subset of U with w in its closure and almost every point of Σ_η has the label ℓ: c has the labelled corner (w, Σ, ℓ). If two such corners, with labels ℓ ≠ ℓ′, are adjacent along a branch β of some S(x_i), then for some η > 0 the set Σ_η ∪ Σ′_η ∪ (β ∩ B(w, η)) is open, almost every point of it on one side of S(x_i) has the label ℓ, and almost every point of it on the other side the label ℓ′.
  uses only: C136-TABLE (`plans/FS136-E1-derivation.md` § 3.1; [hand] over C124-TYPE, one mind — inherited; its argument read whole) for the same members and families; C136-CORNERS for "connected, with w in its closure" and for "open"; that Σ lies on one side of every S(x_i). Not consumed: the number of labels; that the families' labels are all the labels (only that every label but ℓ is carried and barred); |x_i − w| = 1 beyond what C136-TABLE reads
  not claimed: that a weak colouring has a piece; that ℓ is itself unbarred on Σ — if every label is barred the conclusion holds for two labels at once and no such colouring exists (the first round's exclusions); a lower bound for η (it is half the least witness depth of the bars used, and shrinks at every step); anything on a corner where two or more labels are unbarred; anything where fewer than k − 1 labels are carried by the families (a label of no family is never barred); that the forced piece reaches beyond B(w, η), is a tile of anything, or has ℓ everywhere and not almost everywhere; in the second sentence, that the two pieces are all there is near w
  argument: FS136-E2-derivation.md § Argument — a corner with one label left
  verdict: derived
  grade: hand
  minds: 1
  model: at seven, R7: for each of the 54 pairs of lattice points less than 2 apart in a window and each of their 108 common unit points, the table from the pair's twelve corners — 432 corners, 141 of them with one label left, and at every one of the 432 the labels left are exactly the labels R7 has there (control `forced-r7-window`: "viol=0 … forced_wrong=0 exact=432"); at six, FS116-Y2-SIXFRAG at (−1, −1): four corners with one label left, 0 inside the unit circle about e(270°) and 1 outside — the interface is that circle (`data/fs136/e2/out/flower.txt`); FS-112's strip at (1/4, √15/4): three corners with one label left (`out/strip1.txt`)
  prior art: partly: for palettes at the hubs of one ring it is a step inside C132-M-ORBIT's argument, never an entry (`plans/FS132-E3-derivation.md` ll. 513–515: "a region near a ring point in which the transfer (⋆) leaves one label, so the colouring is forced there"; `plans/FS132-derivation.md` l. 102); for maps a forced step is placing (G91; FS116-RING-TRANSFER-QC, -N3-SEMI, -N2-STAR, -N2-RECIP, named by the claim list and not read by me); for pieces: declined twice (C124-FOUR and C136-ONE, their *not claimed* lines) and not found in the seven derivation files (Stage 0.2 item 2); print: zbMATH, four queries in the recognition's words (`data/fs136/e2/pa/zb.out`): "ab:"constraint propagation" & (ab:"chromatic number of the plane" | ab:"unit distance" | ab:"unit-distance")" (0), "(ab:"forced" | ab:"forcing") & ab:colo* & ab:plane & (ab:"unit circle" | ab:"unit distance") & (ab:region* | ab:tile* | ab:tiling*)" (1: a conference volume, Zbl 1271.05002, title only), "(ab:"local rule*" | ab:"vertex figure*" | ab:"empire*") & ab:colo* & (ab:"unit distance" | ab:"chromatic number of the plane")" (0), "ab:"chromatic number of the plane" & (ab:measurable | ab:"map-type" | ab:"map type") & (ab:"propagat*" | ab:"extend*" | ab:"extension")" (0) — not found
  handoff: de Bruijn — on the cell, not the corner: "for the set C of points on the chosen side of each S(x_i): almost every point of C ∩ B(w, η) has the label ℓ" is three lines over `ae_onSide_of_label` at each member (a point of C off the null sets has a label pure on C's side at every member carrying it); read the hypothesis back against "every label but ℓ is a label of some family that is not pure on C's side", not "of some piece"; the corner form (connected, w in its closure) needs C136-CORNERS and crosses only with a consumer

**Class**: every weak `k`-colouring of an open set; any finite set of points one unit from `w`, each with a finite family of
pieces. **Count**: none read — "Not consumed: the number of labels; that the families' labels are all the labels (only that
every label but ℓ is carried and barred)". **The forward half of C136-TABLE**, "the half its *not claimed* line left — a
region where none was kept". **Restated against the card in two places**, its deriver's words: "'the cell' is one of the
corners cut at `w` …, so that the conclusion is a piece; and the second sentence says where the two labels are". **What it
does not do**: "give a colouring a first piece". **Prior art, said whole**: for palettes at the hubs of one ring it is a
step inside C132-M-ORBIT's argument (FS-132), "never an entry"; for maps a forced step is placing (G91), the map entries
named and not read by its deriver; for pieces, "declined twice (C124-FOUR and C136-ONE, their *not claimed* lines)". **What
rests on it**: C136-CLOSE, C136-COLLAR. **Kernel**: none; its cell form — "for the set C of points on the chosen side of
each S(x_i): almost every point of C ∩ B(w, η) has the label ℓ" — "is three lines over `ae_onSide_of_label` at each
member"; the corner form "crosses only with a consumer".

derivation: C136-CLOSE
  statement: About weak colourings that have the seed; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U that has every labelled corner of a set 𝒮. Then c has every labelled corner of the forced closure of 𝒮 in U, and no finite subset of that closure empties a corner at a point of U. The closure is the union of the sets 𝒮_0 = 𝒮, 𝒮_{n+1} = 𝒮_n ∪ {(w, Σ, ℓ) : w ∈ U, forced by a finite subset of 𝒮_n}.
  uses only: C136-FORCED at each step, with the pieces Σ_ρ of the corners c has (connected for small ρ: C136-CORNERS' picture at a member); that a corner which is not inner at w has, at every radius, a point strictly outside S(w); that the step reads a finite subset and that a larger family forces whatever a smaller one does; that a corner Σ_η has positive measure
  not claimed: that a weak colouring has the seed; any radius — a corner of the closure is had at some ρ > 0 that depends on c and is not bounded below along the closure, so no region of definite size is forced, and a closure all of whose corners at every point reached are forced is a set of vertex figures, not a coloured fragment; a converse — a seed whose closure empties no corner need not be had by any colouring; the bars of extent — a whole tile can be crossing where its corner is inner, and those bars are not in the closure of the corners; that the closure of a finite seed is finite
  argument: FS136-E2-derivation.md § Argument — the closure
  verdict: derived
  grade: derived from: C136-FORCED
  minds: 1
  model: R7 with the twelve corners at (0, 0) and (1, 0): it has the seed, its closure is fifteen corners, and R7 has each of the three forced ones (C136-CLOSE-R7; control `close-r7`: "agree-with-object=3 of 3")
  prior art: partly: as C136-FORCED; the closure as an object — the least family closed under a forced step — is the card's (`plans/STUB-covering-pairs.md` § Structural form), posed there on pieces and "as a fixpoint of a monotone step"; for maps the nearest held object is the ring calculus's placing run along a ring (G91); print: as C136-FORCED — not found
  handoff: none — a kernel statement would need a type of corners and their classes (C136-CLASS); it crosses only with a consumer: a seed whose closure empties a corner (none found), or the Searcher's propagator checked there

*Derived from C136-FORCED, step by step.* **Class**: every weak `k`-colouring of an open set and every set of labelled
corners it has. **Count**: none read. **What a seed forces**, its deriver's words: "a countable family of corners at
isolated points — each had at some radius, none of a size any statement bounds — unless a point carrying at least `k − 1`
labels forces along an arc." **What it does not claim**, beside the line quoted at the head of this section: "a converse —
a seed whose closure empties no corner need not be had by any colouring"; "the bars of extent — a whole tile can be
crossing where its corner is inner, and those bars are not in the closure of the corners"; "that the closure of a finite
seed is finite". **What rests on it**: the three computed closures (§ 3), C136-STOP-GERMS (§ 4). **Kernel**: none without a
consumer.

derivation: C136-COLLAR
  statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, whose labels are all the labels but one, ℓ, and A an open arc of S(x) lying in U such that at every point w of A each label of F has a corner in F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x).
  uses only: C136-FORCED with the one member x at each point w of A (the two corners cut at w by S(x) are the parts of a small disc inside and outside S(x)), for the pieces Σ_ρ of the corners c has, as in C136-CLOSE's argument; that an open subset of the plane is the union of countably many of any family of open sets covering it; that the part of a disc inside (or outside) a unit circle through its centre is connected for a small radius, and that an arc is connected
  not claimed: that a weak colouring has such corners; any width — η depends on w and on c and is bounded below by nothing, at the ends of A or anywhere along it; anything at the end points of A; anything for a point whose corners lack two labels (two labels are left on each side) or lack none (there a side on which no label is pure cannot be coloured at all: C136-ONE); that an arc A exists for a given F (it is read from the corners by C136-CLASS: for the flower's centre and for R7's lattice points there is none); that V is a tile, reaches beyond its collar, or has ℓ everywhere and not almost everywhere; what V bars one unit further on (a fact about its extent; not computed here)
  argument: FS136-E2-derivation.md § Argument — the collar
  verdict: derived
  grade: derived from: C136-FORCED
  minds: 1
  model: FS114-Y2-BOWTIE with the five corners at q₂ = (√3/2, −1/2), whose labels are all but 4: A the open arc of S(q₂) of directions 150° to 210° from q₂ (from the origin to (0, −1)), on which each of the five corners is outer or crossing; the fragment has the label 4 at 118 of 118 samples just inside that arc; and the same at q₁ with the label 2 (control `forced-arc`: "arc-forced=4" — these two and the two arcs of directions −30° to 30°, outside, beyond the fragment)
  prior art: partly: for maps FS116-N2-FIVERING (`plans/FS116-derivation.md` l. 655: "in a valid fragment on a closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point"; read at its statement only, its argument and mind count not read) — G98's count, one label left for the ring of a point of five; for pieces in measure: here, as C136-FORCED at one member taken along an arc; print: as C136-FORCED — not found
  handoff: de Bruijn — only with a consumer: `ae_onSide_of_label` at the one member for each point of the arc, a countable subcover, and the connectedness of a union of half-discs along an arc

*Derived from C136-FORCED at one member, along an arc — the one entry of this milestone that forces a region of definite
extent.* **Class**: every weak `k`-colouring of an open set with a point whose corners carry all the labels but one.
**Count**: "all the labels but one", any `k`. **The region it forces has a definite length and no definite width**: its
*not claimed* line — "any width — η depends on w and on c and is bounded below by nothing, at the ends of A or anywhere
along it". **Inhabited at six on a held object**: the bowtie fragment's two five-label points, four arcs of 60° (its
*model* line; control `forced-arc`). **Where it gives nothing**: the flower's six-label centre (isolated ring points only)
and R7's lattice points, which carry six of seven labels — "for the flower's centre and for R7's lattice points there is
none". **It gives no colouring a first piece**: "no weak six-colouring is known to have a point of five labels". **What it
leaves**, its *not claimed* line: "what V bars one unit further on (a fact about its extent; not computed here)" — the
question of stub FS-137 (`plans/STUB-collars.md`). **Prior art**: for maps FS116-N2-FIVERING, "read at its statement only,
its argument and mind count not read" — a debt. **Kernel**: none; "only with a consumer".

*Correction, dated 2026-10-07 (20:10 UTC; filed by the coordinator; source: the asking lane's re-read, job FS136-P2, checked by the coordinator at `data/fs136/e1/out/bowtie.txt` l. 1, "5-label:4"): the bowtie fragment has **four** five-label points, not two. The arc scan was seeded with two of them (`q₂`, `q₁`), and what is said here of "its two five-label points" is said of those two; the other two have not been scanned. No verdict moves.*

control: corners-selftest
  of: C136-CLASS — the arithmetic (four roots: in the field, a nested one, a new one, a product) and the classifier on eleven corners at (0, 0) seen from (1, 0), each read exactly and by samples — quarter-planes, the half-plane with tangent edges, the disc's own corner, three horns between tangent circles, two horns between circles of radius 1/2 and 2 and the unit circle — and C136-CORNERS on three arrangements (antipodal: two corners outside both; a right angle; three members). Tight: seven of the eleven are decided by curvature alone. The fault orders curves by direction only
  run: python3 ../data/fs136/e2/closure.py selftest
  expect: selftest: 18 of 18 OK
  fault: python3 ../data/fs136/e2/closure.py selftest --fault=bend

control: forced-r7-window
  of: C136-FORCED — at seven, on the tight colouring R7 (no margin anywhere): the 54 pairs of lattice points less than 2 apart in the window −1 ≤ m, n ≤ 2, their 108 common unit points, the 432 corners cut there; for each corner the labels the pair's twelve corners leave, against the labels of R7's own corners that meet it, exactly: viol = a label R7 has there is barred (it would refute C136-TABLE or the engine); forced_wrong = one label left and R7 has another or more; exact = the labels left are exactly R7's. The fault (the card's plant: one more bar) reads the first corner of each pair as crossing wherever it is inner
  run: python3 ../data/fs136/e2/closure.py window
  expect: r7 window: pairs=54 points=108 corners=432 viol=0 forced=141 forced_wrong=0 exact=432 empty=0 class-samples=1296 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py window --fault=bar

control: forced-arc
  of: C136-COLLAR — C136-FORCED's case of one member, along an arc: the ten corners of FS114-Y2-BOWTIE at its two five-label points; the scan of both unit circles (one exact sample per open arc between critical directions); arc-forced counts the sides of arcs with one label left — four: inside and outside each circle along a 60° arc, the label the point lacks. Not a claim of this round; the closure it prints is a lower bound (collars are not propagated). The fault bars the label of the first forced corner on every corner
  run: python3 ../data/fs136/e2/closure.py close bowtie12 --brief --rounds=3
  expect: bowtie12: seed=10 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=5 at 3 points | emptied=1 conflicts=0 | arc-scans=2 arc-forced=4 | corners read: forced=7 free=17 outside-U empty=1 outside-U forced=2 outside-U free=9 seed-point free=12 | agree-with-object=5 of 5 (disagree 0, unread 0) | class-samples=226 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close bowtie12 --brief --rounds=3 --fault=bar

*`forced-r7-window` is a **calibration at seven**, exact: on R7 "a label R7 has there" is never barred, and at every one of
432 corners the labels left are R7's. `forced-arc` prints a closure of the bowtie fragment's seed that "is a lower bound
(collars are not propagated)"; that closure is no entry.*

## 3 Three closures, computed — instances of C136-CLOSE on named corners

*Each is the forced closure of named labelled corners of one object, computed by `data/fs136/e2/closure.py` with every
class an exact sign in the object's own number field, forced steps only: no branch is taken. Their grade is **computed
over** the set their `grade:` lines name. **Every closure stalls; none empties a corner beyond its seed pair's own common
unit points; none forces a label along an arc.** A stall is a list of free corners — choices, the search lane's (queue
lines 17–20). None is a statement about any colouring but those that have the seed's corners.*

derivation: C136-CLOSE-R7
  statement: The forced closure in the plane of the twelve labelled corners of the tight seven-colouring R7 at the lattice points (0, 0) and (1, 0) is those twelve and three more: at (1/2, √3/2) the corner inside both points' unit circles, with the label 0; at (1/2, −√3/2) the corner inside the unit circle about (0, 0) and outside that about (1, 0), with the label 1, and the corner outside the first and inside the second, with the label 3. It empties no corner; at every point one unit from two or more of its four points every other corner cut there has two or more labels left; and along the unit circles about (0, 0) and (1, 0), off those points, each side has two or more labels left.
  uses only: C136-CLASS for every class and C136-CORNERS for every table; exact signs in ℚ(√3); the refinement remark under C136-CLOSE (the table of the whole family at each point); that a corner is forced only at a point whose members carry at least six of the seven labels — so the points to read are those one unit from two or more points of the family, and the whole unit circle of each point carrying six labels, which is read by one sample in each open arc between critical directions (the classes of that point's corners are constant on such an arc) and at the critical points
  not claimed: what C136-CLOSE does not claim; anything about the closure of the two points' whole tiles (extent adds bars: not computed); that R7 is the only colouring with the seed; anything for another pair of points of R7 except by its symmetries
  argument: FS136-E2-derivation.md § Argument — the three closures, computed
  verdict: derived
  grade: computed over: the twelve corners of R7 at (0, 0) and (1, 0); two rounds; the tables at 8 points and along 2 unit circles (12 arcs, 2 critical points); exact in ℚ(√3)
  minds: 1
  model: R7 itself: it has the seed and each of the three forced corners — the Reuleaux tile on (0, 0), (1, 0), (1/2, √3/2) at its third corner, and at (1/2, −√3/2) the halves, away from the cusp between them, of the two Reuleaux tiles there that hold (0, 0) and (1, 0)
  prior art: partly: the asking lane read the first step in floats with whole tiles ("singleton cells per coloured point … 1:69 2:27", `data/fs136/p1/germs_read.out`); the closure: here
  handoff: none — a control at seven; nothing consumes it

***Calibration at seven.*** **Class**: one seed — the twelve corners of R7 at two adjacent lattice points. **What it
shows**: no corner is emptied at any step (the survival control), and the closure is fifteen corners and stalls. **It
corrects the stub's table row** "tightness at seven is rigid from two points", in its deriver's words: "with both members
full the table is *exact* at every corner … and it stalls all the same, because R7 has two or three labels in those corners
and a forced corner carries one label, too few to bar anything one unit further on." Registered before it was run, not
blind ("worked by hand before the script was written").

derivation: C136-CLOSE-FLOWER
  statement: The forced closure in the open disc of radius 3/2 about the origin of the seven labelled corners of FS116-Y2-SIXFRAG at e(180°) and e(270°) is those seven and six more: at (−1, −1) the four corners cut by the two points' unit circles, the two inside the unit circle about e(270°) with the label 0 and the two outside it with the label 1; at (−1 + √3/2, −1/2) the two corners outside the unit circle about e(180°), with the label 4. It empties no corner. The forced closure of the same seven in the whole plane is those thirteen and two more, at (−1 − √3/2, −1/2), the two corners inside the unit circle about e(180°), with the label 4; it empties no corner.
  uses only: as C136-CLOSE-R7, with exact signs in ℚ(√3, √7) (the fragment's own tower; no root is adjoined); no point of either closure carries five labels, so no unit circle is scanned
  not claimed: what C136-CLOSE does not claim; anything about the closure of whole tiles; that a weak six-colouring has these seven corners; anything about the fragment's other pattern or its other pairs; that the closure in the plane says anything about a colouring of a set that does not hold its three points
  argument: FS136-E2-derivation.md § Argument — the three closures, computed
  verdict: derived
  grade: computed over: the seven corners of FS116-Y2-SIXFRAG at e(180°) and e(270°); three rounds; the tables at 10 points (in the disc of radius 3/2) and at 13 points (in the plane); exact in ℚ(√3, √7)
  minds: 1
  model: the fragment itself: each of the six corners forced inside it has the fragment's colour there (control `close-flower`: "agree-with-object=6 of 6") — at (−1, −1) the lens Q4's and the lens Q5's sides of the unit circle about e(270°), at (−1 + √3/2, −1/2) an interior point of the sector S4
  prior art: partly: the first step is the first round's reading (C136-COVER's model; "in/in=0 in/out=1 out/in=0 out/out=1", `data/fs136/e1/out/sixfrag.txt`) and the asking lane's; the second step and the stall: here
  handoff: none — a computed closure with no consumer

**Class**: one seed — seven corners of the flower at `e(180°)` and `e(270°)`. Six corners forced at two points inside the
fragment's disc, each the fragment's colour; two steps; a stall. "**A unit arc is forced, not designed**: at `(−1, −1)` the
labels `0` and `1` meet along the unit circle about `e(270°)`" — C136-FORCED's second sentence, on a held object. Free
corners: 18 at 5 points in the disc, 40 at 11 in the plane.

derivation: C136-CLOSE-STRIP
  statement: (c1) The forced closure, in FS-112's strip and in the whole plane alike, of the eight labelled corners of the strip at (0, 0) and (1/2, 0) is those eight and ten more: three at each of (1/4, √15/4) and (1/4, −√15/4), and one at each of the four points ((1 + 3√5)/8, ±(√15 − √3)/8) and ((3 − 3√5)/8, ±(√15 − √3)/8); it empties no corner. (c2) The forced closure in the strip of its six labelled corners at (−1/4, √15/4) and (1/2, √3/2) is those six: at their common unit point (0, 0) each of the four corners has two labels left, and their other common unit point, (1/4, √15/4 + √3/2), is not in the strip; at that point the six empty the corner outside both unit circles.
  uses only: as C136-CLOSE-R7, with exact signs in ℚ(√3, √5) and, in the last round of (c1), one adjoined root; the strip's tiles list their boundary pieces without a direction of travel, so which of the two corners between a tile's two curves at a point is the tile's is taken from the object's own float point-location (five samples) — the two curves themselves are exact; "in the strip" is read by the first round's float test (two small circles about the point read whole); no point of either closure carries five labels
  not claimed: what C136-CLOSE does not claim; anything about the closure of whole tiles; that a weak six-colouring has either seed; for (c2), more than C136-STOP-GERMS (a) at the point outside the strip; that the card's seed "(c) the six tiles of a covering pair at one of its 34 three-label coloured points" is either of these — it names no object of the strip (Stage 0.2 item 1)
  argument: FS136-E2-derivation.md § Argument — the three closures, computed
  verdict: derived
  grade: computed over: the eight corners of FS-112's strip at (0, 0), (1/2, 0) — three rounds, the tables at 28 points; and its six corners at (−1/4, √15/4), (1/2, √3/2) — one round in the strip, two in the plane; exact in ℚ(√3, √5) and one extension
  minds: 1
  model: the strip itself: each of the ten forced corners of (c1) has the strip's colour there (control `close-strip`: "agree-with-object=10 of 10")
  prior art: partly: the first step of (c1) is the asking lane's float reading ("0:71 3:34": three singleton cells at each of the 34 three-label points) and the first round's (`data/fs136/e1/out/strip.txt` ll. 64–65); the stall of (c2) at (0, 0) is the first round's line 58 of that file; the second step of (c1): here
  handoff: none — computed closures with no consumer

**Class**: two seeds of the strip — (c1) eight corners at two four-label points half a unit apart; (c2) the six corners of
the first round's pair of three-label points. **Two readings inside it are floats**, by its *uses only* line: which of the
two corners between a tile's two curves is the tile's ("the object's own float point-location (five samples)"), and "in
the strip". **It corrects the card's third seed**, which "names no object of the strip". (c1) forces ten corners at six
points in two steps and stalls; (c2) forces nothing in the strip, and "their only product is the exclusion at the point
across". Free corners: (c1) 106 at 26 points; (c2) 4 at 1 point.

control: close-r7
  of: C136-CLOSE-R7 — the closure, with its checks on other paths: the three forced corners sampled against R7's colour function, every class against samples. Tight: R7 has no margin. The fault bars the label of the first forced corner on every corner (one planted wrong bar): a corner must be emptied
  run: python3 ../data/fs136/e2/closure.py close r7 --brief
  expect: r7: seed=12 corners at 2 points (full neighbourhoods: True) labels=7 | rounds=2 closed=yes | forced=3 at 2 points | emptied=0 conflicts=0 | arc-scans=2 arc-forced=0 | corners read: forced=3 free=21 seed-point free=12 | agree-with-object=3 of 3 (disagree 0, unread 0) | class-samples=156 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close r7 --brief --fault=bar

control: close-flower
  of: C136-CLOSE-FLOWER — both closures (in the disc of radius 3/2; in the plane), each with the forced corners sampled against the fragment's colour function where the fragment is defined and every class against samples. Tight: the fragment has no margin. The fault bars the label of the first forced corner on every corner
  run: python3 ../data/fs136/e2/closure.py close flower --brief; python3 ../data/fs136/e2/closure.py close flower --plane --brief
  expect: flower: seed=7 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=6 at 2 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=8 free=18 outside-U forced=2 outside-U free=10 seed-point free=4 | agree-with-object=6 of 6 (disagree 0, unread 0) | class-samples=69 mismatches=0
    flower: seed=7 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=8 at 3 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=12 free=40 seed-point free=6 | agree-with-object=6 of 8 (disagree 0, unread 2) | class-samples=90 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close flower --brief --fault=bar; python3 ../data/fs136/e2/closure.py close flower --plane --brief --fault=bar

control: close-strip
  of: C136-CLOSE-STRIP — the four closures: (c1) in the strip and in the plane, (c2) in the strip and in the plane; forced corners sampled against the strip's colour function, classes against samples. Tight: the strip has no margin. The fault bars one label on every corner (for c1 the first forced corner's; for c2, which forces nothing, the least label left on its first free corner)
  run: python3 ../data/fs136/e2/closure.py close strip1 --brief --rounds=3; python3 ../data/fs136/e2/closure.py close strip1 --plane --brief --rounds=3; python3 ../data/fs136/e2/closure.py close strip2 --brief; python3 ../data/fs136/e2/closure.py close strip2 --plane --brief
  expect: strip1: seed=8 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=10 at 6 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=14 free=106 seed-point free=16 | agree-with-object=10 of 10 (disagree 0, unread 0) | class-samples=148 mismatches=0
    strip1: seed=8 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=10 at 6 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=14 free=106 seed-point free=16 | agree-with-object=10 of 10 (disagree 0, unread 0) | class-samples=148 mismatches=0
    strip2: seed=6 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=1 closed=yes | forced=0 at 0 points | emptied=1 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: free=4 outside-U empty=1 outside-U forced=2 outside-U free=1 | agree-with-object=0 of 0 (disagree 0, unread 0) | class-samples=12 mismatches=0
    strip2: seed=6 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=2 closed=yes | forced=2 at 1 points | emptied=1 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: empty=1 forced=2 free=21 | agree-with-object=0 of 2 (disagree 0, unread 2) | class-samples=32 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close strip1 --brief --rounds=3 --fault=bar; python3 ../data/fs136/e2/closure.py close strip1 --plane --brief --rounds=3 --fault=bar; python3 ../data/fs136/e2/closure.py close strip2 --brief --fault=bar; python3 ../data/fs136/e2/closure.py close strip2 --plane --brief --fault=bar

## 4 The four held stops

*Each held six-coloured object stops at a point one unit from two of its vertices whose labels are all six, and at each
the regions at those two vertices leave a sliver beside the stop where no label is allowed. **Every entry here is an
exclusion of the weak six-colourings that keep named tiles — or the parts of those tiles near two points — of one held
object at their labels. None is a statement about every weak six-colouring of a disc; none fixes or bears on the value of
χ(ℝ²); no weak six-colouring is known to keep them.** Each restates a held map entry, named in its `prior art:` line;
what is new in each is "the class of colourings".*

**Which form is the entry, which the corollary.**

| stop | by the parts of the tiles within `r` of the two members (germs) | by whole tiles | how they stand |
|---|---|---|---|
| the strip, `(1/4, √15/4 + √3/2)` | C136-STOP-GERMS (a), every `r > 0`, six tiles | C136-STOP-STRIP, the same six | the germ form is the head; the whole-tile form is its **corollary** (a colouring that keeps a tile keeps its part near the member). Against FS-124's C124-EDGE-CLOSED, which closes the same point with three members and other kept sets: "neither statement contains the other" |
| the disk, a rim point at squared distance `φ²` from a pentagon corner | C136-STOP-GERMS (b), every `r > 0`, six tiles | C136-STOP-DISK, the same six | head and **corollary** |
| the bowtie fragment, `(√3, 0)` | C136-STOP-GERMS (c), every `r > 0`, eight tiles — "six of them used": the corners of `W, t1, V′, T2` at `q₂` and `V, T1` at `q₁` empty the corner **outside both** unit circles | C136-STOP-BOWTIE, the same eight tiles; and C136-STOP-BOWTIE-SIX, six whole tiles `L2, T2, V′, t1, T1, W`, which empty a cell **inside one circle and outside the other** | C136-STOP-BOWTIE is a **corollary of each** of the other two. **Neither of those two contains the other**: the six whole tiles are not the six corners (in corner form "those two cells keep one label each", R2), and eight germs are not six whole tiles |
| the flower, `(√3, 0)` | C136-STOP-FLOWER-GERMS, every `0 < r ≤ 1/4`, six tiles | C136-STOP-FLOWER, the same six | head and **corollary** (at `r = 1/4`); here one label is barred only at second order |

derivation: C136-STOP-GERMS
  statement: About weak six-colourings that keep the named parts of one held object's tiles; none is known to. For every r > 0 there is no weak six-colouring of an open set that contains the point w and the parts within distance r of their members of the named tiles, and gives almost every point of each part its label in the object — for (a) FS-112's strip, w = (1/4, √15/4 + √3/2), the members (−1/4, √15/4), (1/2, √3/2) and the six tiles of C136-STOP-STRIP; (b) the disk, with w, the members and the six tiles of C136-STOP-DISK; (c) FS114-Y2-BOWTIE, w = (√3, 0), the members q₂, q₁ and the eight tiles of C136-STOP-BOWTIE.
  uses only: C136-CLOSE's second clause for the labelled corners of the named tiles at the two members (a colouring that keeps the part of a tile within r of a member has that tile's corner there, at a radius at most r); C136-CLASS and C136-CORNERS for the table at w; exact signs in each object's own tower (control `stop-corners`): in each case the corner at w outside both members' unit circles has every one of the six labels barred
  not claimed: what C136-STOP-STRIP, -DISK and -BOWTIE do not claim; any exclusion of a colouring that does not keep these parts; a value of the chromatic number of the plane; that a weak six-colouring has these corners; for (c), that the first round's six tiles (L2, T2, V′, t1, T1, W) suffice in corner form — they do not: the six corners that empty the corner outside both circles are W, t1, V′, T2 at q₂ and V, T1 at q₁
  argument: FS136-E2-derivation.md § Argument — the stops with corners
  verdict: derived
  grade: derived from: C136-CLOSE
  minds: 1
  model: the three objects, none of which holds a neighbourhood of its point; the flower's far vertex, the first round's own germ entry (C136-STOP-FLOWER-GERMS), read by the same engine as a positive: its emptied corner is inside the unit circle about e(−30°) and outside that about e(30°), as that entry says
  prior art: known for maps, as statements about germs: FS114-Y-PENT ("no valid map agrees with the disk near B_k, Z^R_k, Z^L_{k+1}"; two minds, blind), FS114-Y3-RSTOP ("agrees with it near q1 and q2 … the stop is the cone (−60°, 60°) at r"; two minds) — that cone is the corner outside both circles found here — and FS114-Y-STRIPK6 for the strip's six tiles; for whole tiles in measure: C136-STOP-STRIP, -DISK, -BOWTIE (first round, one mind); for two sector points with germs as pieces it is C124-BOTH's case; the asking lane read all 70 stops with germs in floats (`data/fs136/p1/germs_read.out`); the corner form in measure, exact: here
  handoff: none — the form a later statement would cite and the form of the Searcher's screen; it crosses to the kernel only with a consumer (the strip's is the cheapest: six classes in ℚ(√3, √5))

*The head for three stops.* **Class**: three held families of corners — "six, six and eight (six of them used)".
**Count**: six. **What is new**, its deriver's words: "against the first round's three, the hypothesis is the two vertex
figures and nothing of the tiles' extent, and no `r₀` is needed; against the map entries, the class of colourings." **It
decides a disagreement between two readings** (the first deriver's closing sentence, that a cell is emptied by "a fact
about a piece's extent", and the asking lane's reading by germs at 70 stops): at these three stops "the corners at the two
members already empty the corner outside both unit circles, at first order, and extent only adds bars"; the dated erratum
stands under R1 § 6.4. **On the bowtie fragment** the corner the vertex figures empty is the one outside both members' unit
circles — "the cone (−60°, 60°)" of the held two-mind map entry FS114-Y3-RSTOP — audited by its deriver on a second path
before it was kept (control `stop-shadow`). **The six-corner form at the bowtie fragment is its deriver's line, not a
statement of this file**: "the six corners that empty the corner outside both circles are W, t1, V′, T2 at q₂ and V, T1
at q₁" (its *not claimed* line). **Kernel**: none; "the strip's is the cheapest" if a consumer comes.

derivation: C136-STOP-GERMS-RADIUS
  statement: In the setting of C136-STOP-GERMS, in each of (a), (b) and (c) there are r₀ > 0 and c > 0 such that for every 0 < r ≤ r₀: an open set that carries a weak six-colouring keeping the parts within distance r of their members of the named tiles at their labels contains no point within c·r of w of the corner at w outside both members' unit circles.
  uses only: C124-SHADOW-OPEN (`plans/FS124-derivation.md` § 2; [hand], one mind — inherited, read at its statement) for the part of each tile within r of its member; that this part holds, for r ≤ r₀, the piece Σ_r of the tile's corner there; that for each label one of the named corners at a member x is not outer at w **and has in its cone a direction u with u·(w − x) > 0** (control `stop-corners`: "order 1" at all three); the estimate of § Argument — the stops with corners
  not claimed: the best constants, or any explicit one; anything in the three other corners at w; that a colouring keeping the parts exists; a law for the flower's far vertex, where one label is barred only at second order and the first round's r² stands
  argument: FS136-E2-derivation.md § Argument — the stops with corners
  verdict: derived
  grade: hand
  minds: 1
  model: the three objects: each is defined up to its point and holds no point of that corner (the strip's and the disk's own edges pass through w; the bowtie fragment is cut at radius 3√3/5)
  prior art: partly: the asking lane's float reading — depth exponents 0.60–1.05 at all 540 witnesses of the strip and the disk, "near 2 at … 16 of the bowtie fragment's" (`data/fs136/p1/germs_read.out`), which is why it posed r² for the bowtie fragment; that the bowtie fragment's emptied corner is first order: here; for maps FS114-Y3-RSTOP's "the stop is the cone (−60°, 60°) at r" is the same corner
  handoff: none — a quantitative rider with no consumer

*A quantitative rider to C136-STOP-GERMS.* **Class**: the same three families. **Restated by its deriver** against the
card and against its own first fixing ("in (c) the same within `c·r²`"): "derived, and **restated, because it says less
than the argument carries** — the bowtie fragment's case is first order like the other two …, and the conclusion is put as
a statement about the colouring's domain". **What it does not claim**: "a law for the flower's far vertex, where one label
is barred only at second order and the first round's r² stands". Nothing rests on it.

derivation: C136-STOP-STRIP
  statement: There is no weak six-colouring of an open set that contains the point (1/4, √15/4 + √3/2) and the six tiles T_{−1}, T_0, U_{−1}, T_1, U_0, U_1 of FS-112's strip, and that gives almost every point of each of these tiles the strip's label.
  uses only: C136-TABLE with the members (−1/4, √15/4) and (1/2, √3/2) and the six tiles as their families; exact signs in ℚ(√3, √5) (control `stop-exact`): the point is one unit from both members, and each of the six tiles has a point of its boundary strictly inside the unit circle about it; that the six labels are distinct and are all the labels
  not claimed: what C124-EDGE-CLOSED does not claim; that this statement contains C124-EDGE-CLOSED or is contained in it — that entry keeps three arches and the parts of T_0, T_1, T_2 below the line y = √15/4, uses three members and does not keep T_{−1}; this one keeps six whole tiles at two members; a value of the chromatic number of the plane
  argument: FS136-E1-derivation.md § Argument — a cell with every label barred
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: the strip itself, which stops at the point; the cell with every label barred is the one outside both members' unit circles
  prior art: known: C124-EDGE-CLOSED (`plans/FS124-derivation.md` § 4; [hand], one mind) for another six kept sets at the same point; for maps FS112-EDGE (two minds, one blind) and FS114-Y-STRIPK6 (two minds, blind: "by FS112-N3-COR3 no valid map contains these six tiles, under any colouring") — these are the same six tiles as FS114-Y-STRIPK6's up to the strip's translation, there under every colouring, here at the strip's own
  handoff: none — the stub's control for this stage ("the strip's (1/4, √15/4 + √3/2) must reproduce C124-EDGE-CLOSED"): it does, by two members where that entry uses three

*Corollary of C136-STOP-GERMS (a); the first round's whole-tile form, derived there from C136-TABLE.* **Class**: one held
family — six whole tiles of the strip. **Count**: six. **Against C124-EDGE-CLOSED** (FS-124, ledger row 164), its *not
claimed* line: that entry "keeps three arches and the parts of T_0, T_1, T_2 below the line y = √15/4, uses three members
and does not keep T_{−1}; this one keeps six whole tiles at two members" — neither contains the other. For maps the same
six tiles are FS114-Y-STRIPK6's, "there under every colouring, here at the strip's own".

derivation: C136-STOP-DISK
  statement: On [Polymath2021]'s disk as rebuilt in `tools/fs112_yb2_objects.py`, let x and y be its vertices nearest (−1.5, 0.16246) and (−0.80902, 1.11352), p its vertex nearest (−0.5, 0.16246), and w = x + y − p. There is no weak six-colouring of an open set that contains w and the six tiles R1, S1, W1, P0, S0, T1 of that rebuild, and that gives almost every point of each of these tiles its colour in the disk.
  uses only: C136-TABLE with the members x, y and the six tiles — the three at x, the three at y — as their families; that each tile is a connected open set with its member an end point of one of its boundary pieces; exact signs in the disk's tower (control `stop-exact`): |w − x| = |w − y| = 1, 0 < |x − y| < 2, |w − p|² = (3 + √5)/2, and each of the six tiles has a point of its boundary strictly inside the unit circle about w; that the six colours are distinct and are all the labels
  not claimed: any exclusion of a weak six-colouring that does not keep these six tiles; no statement about every weak six-colouring of a disc and no value of the chromatic number of the plane; the nine other rim points at that distance and the ten at 1.764 except by the disk's five-fold symmetry and mirror, which permute its colours (read in floats, class L0 at all twenty: § 2.2; not checked exactly); which of FS112-DISK-RIM's names C_k, D_k this point carries (not matched by me); anything at seven
  argument: FS136-E1-derivation.md § Argument — a cell with every label barred
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: the disk itself, whose rim passes through w; the cell with every label barred is the one outside both members' unit circles
  prior art: known for maps: FS112-STOP and FS112-DISK-RIM ("exactly the ten C_k, D_k, each with an open colourless cone of width 108°"; two minds and one), FS114-Y-PENT ("no valid map agrees with the disk near B_k, Z^R_k, Z^L_{k+1}"; two minds, blind); in measure it is an instance of C124-FORCED-PIECES read backwards — two three-label members with disjoint triples, neither separating — which FS-124 did not run on the disk; print: [Polymath2021] Fig. 10 gives the disk and no reason for its radius (by FS112-CAL-DISK's reading)
  handoff: de Bruijn — only with a consumer: six instances of C124-TYPE with explicit points in the disk's tower

*Corollary of C136-STOP-GERMS (b).* **Class**: one held family — six whole tiles of the disk at two three-label vertices.
**Count**: six. What is new beyond the held entries, its deriver's words: "the
class of colourings; in method nothing — it is the count (class L0), C124-FORCED-PIECES's contrapositive on whole tiles." Its *not
claimed* line leaves "the nine other rim points at that distance and the ten at 1.764" to the disk's symmetry, "read in
floats …; not checked exactly".

derivation: C136-STOP-BOWTIE
  statement: There is no weak six-colouring of an open set that contains the point (√3, 0) and the eight tiles t1, W, L1, T1, V, L2, T2, V′ of FS114-Y2-BOWTIE (the names of `tools/fs114_y2_k1.py`: t1, W, L1, T1, V have q₁ = (√3/2, 1/2) as an end point of a boundary piece, and t1, W, L2, T2, V′ have q₂ = (√3/2, −1/2)), and that gives almost every point of each of these tiles its colour in that fragment.
  uses only: C136-TABLE with the members q₂, q₁ and the tiles named by the check (control `stop-exact`: "kept tiles: L2 T2 V' W t1 L1 T1 V W t1") as their families; exact signs in ℚ(√3): (√3, 0) is one unit from both, they are 1 apart, and the witnesses bar every label on the cell inside the unit circle about q₂ and outside that about q₁, and on its mirror cell
  not claimed: any exclusion of a weak six-colouring that does not keep these tiles; a value of the chromatic number of the plane; that fewer tiles suffice (not looked for); the five other points at distance √3 that the reading classes L1 (floats)
  argument: FS136-E1-derivation.md § Argument — a cell with every label barred
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: the fragment itself, which holds the closed disc of radius 3√3/5 about p and no neighbourhood of (√3, 0)
  prior art: known for maps: FS114-Y3-RSTOP ("no valid fragment (Siamese pairs allowed) that agrees with it near q1 and q2 contains a neighbourhood of r = q1 + e(330°) = (√3, 0)"; two minds, YB2 with "the stop is the cone (−60°, 60°) at r") — the same point, the same two members, there for maps; that r is the point across of a covering pair on the ring of p: the asking lane's inference (`plans/POROS-2026-10-07-fs124-round2.md`, addendum), confirmed in Stage 2
  handoff: none — the fourth held stop, for the card's falsifier

*Corollary of C136-STOP-GERMS (c), and of C136-STOP-BOWTIE-SIX below.* **Class**: one held family — eight whole tiles.
**Count**: six. Two dated notes stand under it in R1 (the control's ten kept tiles are eight distinct; six suffice for one
cell). **Which cell**: this entry's witnesses empty "the cell inside the unit circle about q₂ and outside that about q₁,
and … its mirror cell" — true of whole tiles; the second round found that the two vertex figures alone empty a third, the
corner outside both circles, which "that entry's finite list of witnesses did not reach. Nothing in that entry is wrong;
its statement stands" (R2, under C136-STOP-GERMS). With whole tiles all three are empty.

derivation: C136-STOP-BOWTIE-SIX
  statement: There is no weak six-colouring of an open set that contains the point (√3, 0) and the six tiles L2, T2, V′, t1, T1, W of FS114-Y2-BOWTIE (the names of `tools/fs114_y2_k1.py`: L2, T2, V′ and t1 have q₂ = (√3/2, −1/2) as an end point of a boundary piece, and T1 and W have q₁ = (√3/2, 1/2)), and that gives almost every point of each of these tiles its colour in that fragment.
  uses only: C136-TABLE with the members q₂, q₁ and the families {L2, T2, V′, t1} at q₂ and {T1, W} at q₁; the witnesses of the first round's exact check in ℚ(√3) (control `stop-exact`, its lines for the bowtie fragment, read by control `bowtie-six`): (√3, 0) is one unit from both members, they are 1 apart, each of L2, T2, V′, t1 has a point of its boundary strictly outside the unit circle about (√3, 0), and each of T1, W has one strictly inside; that the six tiles' labels 6, 2, 5, 1, 4, 3 are distinct and are all the labels
  not claimed: any exclusion of a weak six-colouring that does not keep these six tiles — no statement about every weak six-colouring of a disc and no value of the chromatic number of the plane; that a weak six-colouring has these pieces; that six is least (not looked for: each of the six is needed for this one cell, and another cell or other tiles were not tried); the corner form — with the parts of these six tiles near q₂ and q₁ in place of the tiles the cell keeps a label (C136-STOP-GERMS, its *not claimed* line); the five other points at distance √3 that the reading classes L1 (floats)
  argument: FS136-E1-derivation.md § Argument — a cell with every label barred
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: the fragment itself, which holds the closed disc of radius 3√3/5 about p and no neighbourhood of (√3, 0); the cell with every label barred is the one inside the unit circle about q₂ and outside that about q₁
  prior art: known for maps: FS114-Y3-RSTOP (two minds; "no valid fragment (Siamese pairs allowed) that agrees with it near q1 and q2 contains a neighbourhood of r = q1 + e(330°) = (√3, 0)", as C136-STOP-BOWTIE's line quotes it); in measure, the eight-tile form: C136-STOP-BOWTIE; this six-tile form: the first deriver's dated note under that entry (`plans/FS136-E1-derivation.md`, "Added 2026-10-07, with the line above": "Six of them suffice for one cell … a statement with six kept tiles is the sharper one and is what the record job should file if it files one"), entered here by the record job
  handoff: none — the sharper whole-tile form of the fourth stop; like the other exclusions it crosses only with a consumer

***The record job's entry**, not a copy: the statement is the one the first deriver's dated note names ("its `statement:`
would name `L2, T2, V′, t1, T1, W`"), and the claim list's line of 17:13 UTC leaves it to this job ("a restated entry is the
record job's to write"). Its argument is the first round's, with the note's witnesses: inside `S(q₂)` the labels `6, 2, 5, 1`
are barred by `L2, T2, V′, t1`, outside `S(q₁)` the labels `4, 3` by `T1, W`. **Its one mind is the first deriver's**; the
record job read the six witness lines from the exact check's output and wrote the control below, which is a reading of
another job's exact check and no second derivation.* **Class**: one held family — six whole tiles. **Count**: six. **It is
not a corollary of C136-STOP-GERMS (c)**, and that entry is not a corollary of it.

control: bowtie-six
  of: C136-STOP-BOWTIE-SIX — the record job's reading of the first round's exact check on the bowtie fragment (run as it is), keeping only the six lines the statement names: L2, T2, V′, t1 at q₂ (each must have a witness strictly outside the unit circle about (√3, 0)) and T1, W at q₁ (each strictly inside); the six labels distinct; all six barred in the cell inside S(q₂) and outside S(q₁). The fault moves the point by (1/50, 0): step 1 of the exact check fails and nothing is read
  run: python3 ../data/fs136/z1/bowtie_six.py
  expect: bowtie-six: kept=L2@q2,T2@q2,V'@q2,t1@q2,T1@q1,W@q1 step1=True lines-read=6 of 6 labels=6 barred-in-the-cell(in S(q2), out S(q1))=6 left=[] EXCLUDED
  fault: python3 ../data/fs136/z1/bowtie_six.py --fault

derivation: C136-STOP-FLOWER-GERMS
  statement: For every r with 0 < r ≤ 1/4 there is no weak six-colouring of an open set that contains the point (√3, 0) and the parts of the tiles S5, Q5, G5 of FS116-Y2-SIXFRAG within distance r of e(−30°) and the parts of its tiles S0, Q0, G0 within distance r of e(30°), and that gives almost every point of each of these six parts its label in that fragment.
  uses only: C136-TABLE as in C136-STOP-FLOWER; that for r ≤ 1/4 each part is connected (S5 and S0: the intersection of two discs; the four others: one of the four wedges cut from B(member, r) by two unit circles that cross at the member and next meet at distance at least 1 from it); the witnesses, with t = r/2 — for S5 the point e(−30°) + t e(180°), at squared distance 1 + t² + √3 t from (√3, 0); for Q5 any point, since Q5 lies in the open unit disc about e(−90°), which is 2 from (√3, 0); for G5 the point e(−30°) + t e(300°) on the common tangent, at squared distance 1 + t²; for S0 the point e(30°) + t e(270°), at 1 + t² − t; for Q0 any point, since Q0 lies in the closed unit disc about (√3, 0); for G0 the point e(30°) + t e(30°), at 1 + t² − t
  not claimed: what C136-STOP-FLOWER does not claim; a radius of exclusion bounded below as r tends to 0 — the ball about (√3, 0) on which the cell is empty has radius of the order of r², because G5's witness is at depth about t²/2
  argument: FS136-E1-derivation.md § Argument — the flower's germs, and what "second order" costs
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: r = 1/4 gives parts of the fragment's own tiles; the tangent-ray witness at t = 1/4 is checked exactly (control `stop-exact`, its last line: in G5, strictly outside the unit circle about (√3, 0)); moved to the direction 330° the point is inside that circle (the fault)
  prior art: partly: FS116-Y2-SIXOFF's Step 3 has this point ("whose points e(−30°) + t·e(300°) … give |x − y|² = 1 + 2s·cos(χ − 30°) + t² + O(st + s²) > 1 at t = 2√s … the horn between the tangent circles", one mind, for maps); as a witness for C124-TYPE in the class of weak colourings: here
  handoff: none — subsumed for the kernel lane by C136-STOP-FLOWER's form; it is the answer to "does the lemma reach the flower"

*The head at the flower.* **Class**: one held family — the germs of six tiles at two ring points, every `0 < r ≤ 1/4`.
**Count**: six. **The answer to the stub's question** whether "the first-order lemma reaches the flower's far vertex", its
deriver's: "The lemma reaches it, and it is not a first-order lemma. C124-TYPE reads a point of the piece strictly off the
unit circle; it reads no cone … what second order costs is the size of the ball on which the conclusion holds (`≈ r²`),
never the conclusion." The second round's engine reads this stop as its positive for "order 2" (control `stop-corners`).

derivation: C136-STOP-FLOWER
  statement: There is no weak six-colouring of an open set that contains the point (√3, 0) and the six tiles S5, Q5, G5, S0, Q0, G0 of FS116-Y2-SIXFRAG, and that gives almost every point of each of these tiles its label in that fragment (5, 1, 3, 0, 2, 4).
  uses only: C136-TABLE with the two members e(−30°), e(30°) and the six tiles as their families; that each tile is a connected open set with its member an end point of one of its boundary pieces; exact signs in ℚ(√3, √7) (control `stop-exact`): (√3, 0) is one unit from both members, the members are 1 apart, and each tile has a point of its boundary strictly on the needed side of the unit circle about (√3, 0) — S5, Q5, G5 strictly outside, S0, Q0, G0 strictly inside; that the six labels are distinct and are all the labels
  not claimed: any exclusion of a weak six-colouring that does not keep these six tiles — in particular no statement about every weak six-colouring of a disc and no value of the chromatic number of the plane; that a weak six-colouring has these pieces; the fragment's other colouring pattern (FS116-Y2-SIXOFF's pattern B); the other five far vertices except through the fragment's rotation by 60°, which permutes its labels (not checked by this job beyond j = 0); anything at seven
  argument: FS136-E1-derivation.md § Argument — a cell with every label barred
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: the fragment itself, which is cut at radius 3/2 and holds no neighbourhood of (√3, 0); the cell with every label barred is the one inside the unit circle about e(−30°) and outside that about e(30°) — the directions (240°, 300°) of FS116-Y2-SIXOFF's Step 3
  prior art: known for maps: FS116-Y2-SIXOFF (`plans/FS116-derivation.md` l. 392; [hand], one mind: no valid fragment with the six straight sectors and the six lenses holds radius √3, either pattern); for every weak six-colouring keeping six tiles at two ring points: here; print: de Grey's and Gibbs's six-sector picture and "what next?" ([Polymath16threads] [08.17]–[08.18], by FS116-Y2's reading, not read by me) — no statement of a stop found (plan §PA; second pass `data/fs136/e1/pa/zb2.out`)
  handoff: de Bruijn — only with a consumer: six instances of C124-TYPE with explicit points in ℚ(√3, √7)

*Corollary of C136-STOP-FLOWER-GERMS at `r = 1/4`* ("r = 1/4 gives parts of the fragment's own tiles", that entry's *model*
line). **Class**: one held family — six whole tiles. **Count**: six. A dated note stands under it in R1: the check keeps
seven distinct tiles, and "the statement's six are the ones the empty cell uses". For maps it is FS116-Y2-SIXOFF (one
mind), "narrower in one way — one pattern, the fragment's own".

control: stop-corners
  of: C136-STOP-GERMS — the exact table at each stop from the corners of the object's tiles at the two members (the tiles are named in each line; x and y as in the first round's control): the labels left on each of the four corners at w, and for an emptied corner the order of its bars — 1 if every label has a bar with a direction strictly on the wrong side in the corner's cone, 2 if some label is barred only along a tangent edge. The flower's far vertex is the positive for "order 2" (its label 3: the gap tile's tangent edge). The fault reads the point moved by (1/50, 0)
  run: python3 ../data/fs136/e2/closure.py stops
  expect: strip: w=(0.25000,1.83427) corners at x: T-1 U-1 T0 | at y: T1 U0 U1 | labels=6 | corners at w (x/y): out/out=EMPTY(order 1) in/out=R in/in=OR out/in=O | class-samples=6 mismatches=0
    disk: w=(-1.80902,1.11352) corners at x: R1 S1 W1 | at y: S0 T1 P0 | labels=6 | corners at w (x/y): out/in=yellow out/out=EMPTY(order 1) in/out=red in/in=redyellow | class-samples=6 mismatches=0
    bowtie: w=(1.73205,0.00000) corners at x: W t1 L2 V' T2 | at y: V L1 t1 W T1 | labels=6 | corners at w (x/y): out/in=4 in/in=234 in/out=2 out/out=EMPTY(order 1) | class-samples=10 mismatches=0
    flower: w=(1.73205,0.00000) corners at x: Q0 S5 Q5 G5 | at y: G0 Q1 S0 Q0 | labels=6 | corners at w (x/y): out/in=1 in/in=2 in/out=EMPTY(order 2; second-order only: 3) out/out=1 | class-samples=8 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py stops --fault=move

control: stop-shadow
  of: C136-STOP-GERMS — a second path to the same sixteen corners, in floats, with no class and no cyclic order: straight from C124-SHADOW-OPEN, a label is barred at a point z one millionth from w iff the unit circle about z meets a corner of that label at a member (sampled at radii from 0.02 down). Written after the bowtie fragment's table came out against the first round's cells and the asking lane's exponent (G21: a result that surprises is audited on another path before it is kept). The fault reads z on the far side of w
  run: python3 ../data/fs136/e2/shadow_check.py
  expect: strip: corners at w=4 left by the shadow: EMPTY R OR O | agree with the exact table: 4 of 4
    disk: corners at w=4 left by the shadow: yellow EMPTY red redyellow | agree with the exact table: 4 of 4
    bowtie: corners at w=4 left by the shadow: 4 234 2 EMPTY | agree with the exact table: 4 of 4
    flower: corners at w=4 left by the shadow: 1 2 EMPTY 1 | agree with the exact table: 4 of 4
  fault: python3 ../data/fs136/e2/shadow_check.py --fault

control: stop-exact
  of: C136-STOP-FLOWER — exact, in each object's own tower: the point across of the named pair is one unit from both members, the members are less than 2 apart, its squared distance from the centre is 3, φ², φ⁴/2 and 3; every tile with a member as an end point of a boundary piece, with witnesses among exact points of its boundary strictly inside or outside the unit circle about the point; the cells in which every label is shown barred; and the horn's witness on the tangent ray. The fault reads the point moved by (1/50, 0), and a point of the direction 330° for the horn
  run: python3 ../data/fs136/e1/stop_check.py flower disk strip bowtie horn | grep -v '^  '
  expect: flower: p=(0.00000,0.00000) x=(0.86603,-0.50000) y=(0.86603,0.50000) w=x+y-p=(1.73205,0.00000)
    flower: kept-tiles=8 labels=6 cells-proved-empty=in/out EXCLUDED
    disk: p=(-0.50000,0.16246) x=(-1.50000,0.16246) y=(-0.80902,1.11352) w=x+y-p=(-1.80902,1.11352)
    disk: kept-tiles=6 labels=6 cells-proved-empty=out/out EXCLUDED
    strip: p=(0.00000,0.00000) x=(-0.25000,0.96825) y=(0.50000,0.86603) w=x+y-p=(0.25000,1.83427)
    strip: kept-tiles=6 labels=6 cells-proved-empty=out/out EXCLUDED
    bowtie: p=(0.00000,0.00000) x=(0.86603,-0.50000) y=(0.86603,0.50000) w=x+y-p=(1.73205,0.00000)
    bowtie: kept-tiles=10 labels=6 cells-proved-empty=in/out,out/in EXCLUDED
    horn: q=e(-30)+t*e(300), t=1/4: outside-S(p)=True outside-S(e(-90))=True outside-S(e(30))=True inside-the-cut=True strictly-outside-S(w)=True HORN WITNESS OK
  fault: python3 ../data/fs136/e1/stop_check.py flower disk strip bowtie horn --fault | grep -v '^  '

*`stop-exact` is exact in each object's own tower; a defect of it is reported by the second deriver and moves no verdict:
it "proves bars from a finite list of boundary points and misses the corner outside both circles at the bowtie fragment's
stop" (FS-136 inventory item 14) — it under-reads, so what it prints empty is empty. `stop-shadow` is floats, on another
code path.*

## 5 The bound on partners

derivation: C136-PARTNERS
  statement: Let c be a weak six-colouring of U and x a sector point. For each edge of x there is at most one point w such that the edge begins with an arc of the unit circle about w, so there are at most three such points; if y is a close complementary sector partner of x and both common unit points w, w′ of the pair lie in U, then each of w, w′ is one of those points and y = w + w′ − x; so x has at most three close complementary sector partners both of whose common unit points lie in U.
  uses only: C124-BOTH's second sentence (`plans/FS124-derivation.md` § 3: "each has an edge that contains an arc of S(w) with an end at the member"; derived from C124-LONE, one mind, kernel pending — inherited, cited as the coordinator's relay of FS124-K2's § 4.2 allows; its argument and C124-LONE's Step II not read by me); that a connected subset of an arc containing its first point is an initial piece of it, and the rest of the arc keeps a positive distance from that point; that two distinct circles share at most two points; that four points x, w, y, w′ with |w − x| = |w′ − x| = |w − y| = |w′ − y| = 1, w ≠ w′, x ≠ y satisfy x + y = w + w′
  not claimed: that a weak six-colouring has a sector point or a close complementary pair; anything for a partner with only one common unit point in U (37 of the strip's 54 pairs: control `partners-held`); anything for a member of four or more labels, or a three-piece point that is not a sector point — C124-BOTH is not held there, and on the disk and the flower a four-label member pays alone (§ 2.2 item 5); that the two points use different edges of x (C124-SECOND, for pattern (1, 1)); that three is attained except on the strip and the kept model as read
  argument: FS136-E1-derivation.md § Argument — at most three partners
  verdict: derived
  grade: hand
  minds: 1
  model: the Searcher's kept model: its centre has three partners, the three ring points with complementary triples, each pair with both common unit points inside (control `partners-held`: "kept: … partners-histogram={1: 3, 3: 1}"); FS-112's strip: 28 members with three partners, none with more
  prior art: known for maps: FS112-C-PARTNERS ("every close complementary cubic trichromatic partner of a cubic trichromatic vertex u is the fourth corner w_i + w_j − u of a unit rhombus on two of u's leaving centres, so u has at most three such partners"; one mind over FS112-N3-COR3's two) and FS114-Y-PAIRSHARE's first clause (two minds, blind); in measure posed by the asking lane (`plans/POROS-2026-10-07-fs124-round2.md` § 1.2, "one step"); print: not found (plan §PA)
  handoff: none — a corollary of C124-BOTH's second clause by two lines of plane geometry; it crosses only if the kernel lane takes that clause (the sector clause, the planner's § 2.4)

**Class**: sector points (three pieces, three labels, three arcs). **Count**: six, through C124-BOTH. **Its grade, said
whole**, in its deriver's words: "[hand] over C124-BOTH, which is derived from C124-LONE — one mind, kernel pending, the
step its deriver flagged now looked at a second time by the kernel planner (blind first; 'stands as written', two
corrections filed) and not by me." **And in the kernel** (`plans/FS124-close-inventory.md` items 41–42): the clause it
rests on — C124-BOTH's second sentence — is, in the implementer's words, "TRUE for arc-edged decompositions [kernel, on a
branch]; GAP for the list's sector points at one named step" (the θ-curve leaf), and nothing of it is through the gate; so
for sector points as this entry states them the kernel does not yet hold its input. **What is new**: "nothing but the class" — FS112-C-PARTNERS's two lines
under a dictionary. **What it does not claim**, first: "anything for a member of four or more labels … — C124-BOTH is not
held there, and on the disk and the flower a four-label member pays alone". Nothing rests on it.

control: partners-held
  of: C136-PARTNERS — the asking lane's reader on the second round's outputs for the strip, the disk and the kept model (three-label members only): the histogram of partners per member — none above three, three attained on the strip and at the kept model's centre; and how many pairs have one common unit point inside. A reading of another job's outputs, floats. The fault drops the second member of every line (no pair is read)
  run: python3 ../data/fs124/p3/pairs_read.py strip disk kept
  expect: strip: pairs=54 both=17 one=37 distances={0.7569: 34, 1.732: 10, 1.9364: 10} partners-histogram={2: 12, 3: 28} points=10 pairs-per-point={2: 1, 5: 1, 8: 8} unsaved-point-at-distance={0.5: 1, 1.0: 2, 1.851: 34} (tautology, not evidence: completions=17/17)
    disk: pairs=20 both=0 one=20 distances={0.9416: 8, 0.9417: 2, 1.1755: 8, 1.1756: 2} partners-histogram={1: 10, 2: 15} points=5 pairs-per-point={4: 5} unsaved-point-at-distance={1.618: 10, 1.764: 8, 1.765: 2} (tautology, not evidence: completions=0/0)
    kept: pairs=3 both=3 one=0 distances={1.0: 3} partners-histogram={1: 3, 3: 1} points=3 pairs-per-point={2: 3} unsaved-point-at-distance={} (tautology, not evidence: completions=3/3)
  fault: python3 ../data/fs124/p3/pairs_read.py strip disk kept --fault

*`partners-held` reads another job's outputs in floats (the asking lane's reader): a reading, not a proof.*

## 6 The reading of the held objects — [tools]; four points exact

derivation: C136-RINGS-READ
  statement: On FS-112's strip the point (1/4, √15/4 + √3/2) is the point across of the covering pair ((−1/4, √15/4), (1/2, √3/2)) on the ring of (0, 0), and its squared distance from (0, 0) is (7 + 3√5)/4; on [Polymath2021]'s disk as rebuilt by FS112-CAL-DISK the point across of the covering pair of three-label vertices near (−1.5, 0.16246), (−0.80902, 1.11352) on the ring of the corner near (−0.5, 0.16246) of the central pentagon is at squared distance (3 + √5)/2 from that corner; on FS116-Y2-SIXFRAG the point across of (e(−30°), e(30°)) on the ring of the six-label vertex is (√3, 0); on FS114-Y2-BOWTIE the point across of (q₂, q₁) on the ring of p is (√3, 0); and in each of the four cases every label is barred, by C124-TYPE applied to the object's own tiles at the two members, on one of the four cells cut near that point by the two members' unit circles.
  uses only: the objects' exact pieces (`tools/fs112_yb2_objects.py`, `tools/fs116_y2_six.py`, `tools/fs114_y2_k1.py`) and exact signs in their towers (control `stop-exact`, Stage 5); for "barred", C124-TYPE (`plans/FS124-derivation.md` § 2; [hand], one mind — inherited, its argument read whole) with witnesses among exact points of the tiles' boundaries
  not claimed: that a weak six-colouring has a piece, a pieced point or a covering pair; that these are the least distances of a point across not inside — that is the float reading of § 2.2, by enumeration of each object's vertices ([tools], one mind); that a reading proves anything about a colouring not read; the validity of any object (each object's own entry)
  argument: FS136-E1-derivation.md § 2.2 The table of the reading ([tools], floats, one mind)
  verdict: derived
  grade: computed over: the set of the four points across named in the statement, each with the tiles of its object at its two members, exact in the objects' own towers
  minds: 1
  model: the four objects themselves
  prior art: partly: FS112-STOP (two minds, one blind) and FS112-EDGE hold the strip's and the disk's stops as "the second common unit point of a close complementary trivalent pair" for maps; FS114-Y3-RSTOP (two minds) the bowtie fragment's stop, not named there as a point across; FS116-Y2-SIXOFF (one mind) the flower's; the asking lane read three of the four in floats (`data/fs124/p3/pairs_read.out`); that all four are excluded by the pair's own tiles in the class of weak colourings: Stage 5; print: plan §PA item 2, none
  handoff: none — a reading with four exact points; what crosses is Stage 5's exclusions

**What is exact and what is not.** The entry's grade is "computed over: the set of the four points across named in the
statement" — one point on each of the strip, the disk, the flower and the bowtie fragment, each exact in its object's own
number field, and each excluded by an entry of § 4. **Every count around it is [tools], floats, one mind, and is not an
entry** (R1 § 2.2; reader `data/fs136/e1/rings_read.py`; outputs `data/fs136/e1/out/`). **On which objects**: at six labels
FS-112's strip (tiles −4 to 6), FS-114's capped strip, `[Polymath2021]`'s disk, FS116-Y2-SIXFRAG, FS114-Y2-BOWTIE,
fragments T2, S1, MX, BB, and the Searcher's kept model; at seven, as a calibration, R7 (50 tiles). Its table, quoted:

> | object | labels | members (≥ 3 labels) | centres (≥ 4) | covering pairs (on a ring) | common unit points inside: class; violations | not inside: class | least distance of a point across not inside; class there |
> |---|---|---|---|---|---|---|---|
> | FS-112's strip, tiles −4…6 | 6 | 50 | 10 | 71 (54) | 105: all L2; 0 of 151,200 | 34 L0, 3 L2 (the 3 at the window's ends) | **1.8512** at six interior centres: **L0**; (0.5, 1.0, 1.0 at the window's ends: L2) |
> | FS-114's capped strip, as loaded | 6 | 50 | 10 | 71 (54) | 105: all L2; 0 | 34 L0, 3 L2 | the strip's line, count for count (its tiles differ from the strip's as loaded; not examined further) |
> | `[Polymath2021]`'s disk | 6 | 30 | 5 | 40 (40) | 60: all L2; 0 of 86,400 | 20 L0 | **1.618** at all five centres: **L0** (ten points; ten more at 1.764: L0) |
> | FS116-Y2-SIXFRAG | 6 | 13 | 7 | 24 (18) | 42: all L2; 0 of 60,480 | 6 L1 | **1.7321** about the six-label vertex: **L1** (six points, `√3 e(60j)`) |
> | FS114-Y2-BOWTIE | 6 | 11 | 7 | 24 (20) | 34: all L2; 0 of 48,956 | 10 L1, 4 L2 | **1.7321** about `p`: **L1** (six points, among them `(√3, 0) = q₁ + q₂ − p`); 1.9319 about each `q_i`: L2 |
> | T2, S1, MX, BB | 6 | 4, 2, 4, 4 | 2, 0, 2, 2 | 2, 1, 1, 1 | 4, 2, 2, 2: all L2; 0 | none | none: every point across is inside |
> | the Searcher's kept model | 6 | 7 | 3 | 6 (3) | 12: all L2; 0 | none | none |
> | R7, 50 tiles (seven labels) | 7 | 16 | 16 | 54 (54) | 96: all L2; 0 of 138,240 | 12 L2 (the window's edge) | 1.7321: L2 — the window's edge, not a stop |

*Classes*: **L0** neither member separates by labels; **L1** a member separates and some cell is empty; **L2** no cell
empty. **What the reading says**, in its deriver's words (R1 § 2.2): the least distance of a point across not inside is
"`1.8512`, `1.618`, `1.7321` — exactly `φ²/√2`, `φ`, `√3` at the named points"; "The fourth held object is the same kind of
point"; "No held object breaks the card's frame"; "Every held stop is excluded by its own pair's tiles alone … The count is
necessary and not sufficient"; "'Four or more labels at `p`' is not read by anything at the point across — and a coloured
common unit point of a covering pair can carry two labels", paid for by one member alone (10 points of the disk, 6 of the
flower, 4 of the bowtie fragment), and "For two three-label sector points C124-BOTH forbids this; with a
four-label member it occurs on two held objects." Its total, from its report: "0 violations of the table at 359 inside
points (263 on the six-coloured objects" and 96 on R7 at seven).

**A second reading of the same objects, by germs** — the asking lane's ([tools], floats, one mind;
`data/fs136/p1/germs_read.py`, outputs beside it; `plans/POROS-2026-10-07-fs136-round1.md` § 1.2–1.3): "All 70 held stops
(flower 6, disk 20, bowtie fragment 10, strip 34) keep an empty cell when only the parts of the tiles within 0.0125 of the
two members are kept"; at 142 of 257 coloured common unit points some cell has one label left. The first is now an entry
at three named stops (C136-STOP-GERMS) and stays a reading at the other 67; the second is C136-FORCED's hypothesis, read.

control: rings-held
  of: C136-RINGS-READ — the reader on FS116-Y2-SIXFRAG, [Polymath2021]'s disk and FS114-Y2-BOWTIE, each read whole from its tiles: members, centres, covering pairs, the class of the table at every common unit point (inside, with the samples that violate the table; not inside), the least distance of a point across not inside about each centre and the class there. Tight on these models: none has a margin. The fault moves one member of every pair by 0.01 (violations must appear)
  run: python3 ../data/fs136/e1/rings_read.py sixfrag disk bowtie --brief
  expect: sixfrag: labels=6 members=13 centres=7 covering-pairs=24 on-a-ring=18 inside=42[L2:42] violations=0 not-inside=6[L1:6] least=1.7321:1 stop-class=L1:6
    disk: labels=6 members=30 centres=5 covering-pairs=40 on-a-ring=40 inside=60[L2:60] violations=0 not-inside=20[L0:20] least=1.618:5 stop-class=L0:10
    bowtie: labels=6 members=11 centres=7 covering-pairs=24 on-a-ring=20 inside=34[L2:34] violations=0 not-inside=14[L1:10,L2:4] least=1.7321:1,1.9319:4 stop-class=L1:6,L2:4
  fault: python3 ../data/fs136/e1/rings_read.py sixfrag disk bowtie --brief --fault

control: rings-strip
  of: C136-RINGS-READ — the reader on FS-112's strip, tiles −4 to 6; the values 0.5 and 1.0 are at the window's two ends. The fault moves one member of every pair by 0.01
  run: python3 ../data/fs136/e1/rings_read.py strip --brief
  expect: strip: labels=6 members=50 centres=10 covering-pairs=71 on-a-ring=54 inside=105[L2:105] violations=0 not-inside=37[L0:34,L2:3] least=0.5:1,1.0:2,1.8512:6 stop-class=L0:24,L2:3
  fault: python3 ../data/fs136/e1/rings_read.py strip --brief --fault

control: rings-small
  of: C136-RINGS-READ — the reader on fragments T2, S1, MX, BB and the Searcher's kept model: no point across outside any of them. The fault moves one member of every pair by 0.01
  run: python3 ../data/fs136/e1/rings_read.py T2 S1 MX BB kept --brief
  expect: T2: labels=6 members=4 centres=2 covering-pairs=2 on-a-ring=1 inside=4[L2:4] violations=0 not-inside=0[] least=none stop-class=none
    S1: labels=6 members=2 centres=0 covering-pairs=1 on-a-ring=0 inside=2[L2:2] violations=0 not-inside=0[] least=none stop-class=none
    MX: labels=6 members=4 centres=2 covering-pairs=1 on-a-ring=1 inside=2[L2:2] violations=0 not-inside=0[] least=none stop-class=none
    BB: labels=6 members=4 centres=2 covering-pairs=1 on-a-ring=1 inside=2[L2:2] violations=0 not-inside=0[] least=none stop-class=none
    kept: labels=6 members=7 centres=3 covering-pairs=6 on-a-ring=3 inside=12[L2:12] violations=0 not-inside=0[] least=none stop-class=none
  fault: python3 ../data/fs136/e1/rings_read.py T2 S1 MX BB kept --brief --fault

## 7 What this file does not hold

From the entries' own *not claimed* lines and the two derivers' closing sections (R1 § 6.4; R2 §§ 7.6, 8):

1. **That any weak six-colouring has a piece, a corner, a pieced point, a covering pair or a seed.** Every entry begins from
   them. So no entry excludes a weak six-colouring of a disc, and none bears on six against seven.
2. **A region of definite size from a seed of points with three or four labels.** A closure is corners at isolated points;
   the collar has a length and no width, and starts from a point of all labels but one.
3. **What a collar forces one unit further on** — "a corner emptied, a stall, or a second collar" (R2 Stage 8, the smallest
   open form): stub FS-137. The closure of the bowtie fragment's two five-label points as computed "is a lower bound".
4. **An empty corner from a pair alone beyond its own two common unit points**: none on four seeds (the search lane's
   line 15 is the systematic form).
5. **A converse of the table**: labels left at every cell do not give a colouring. **A relation between the tables of one
   ring** beyond the closure ("the structural form's second half … is not answered", R1 § 6.4 item 2).
6. **Exactness of the reading** beyond four points, and of two float readings inside C136-CLOSE-STRIP.
7. **A second mind on any entry.** The second deriver names C136-FORCED, C136-CLASS's order and C136-COLLAR: each "has
   controls on another code path … and no second derivation". The kernel is the workflow's second check, and none of these
   is in it.
8. **The six-corner form of the bowtie fragment's stop as a statement**, and any minimality of kept tiles.
9. **A value of χ(ℝ²), an explicit radius, or an exclusion beyond one held family.**
