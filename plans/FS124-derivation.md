# FS-124 — tight unit pairs: the derivation file

*The theorem record of FS-124 (the boundary between two colours that runs along a unit circle about a point one unit away, in a
six-colouring), filed by its record job FS124-Z1 on 2026-10-07 (UTC). Every `derivation:` and `control:` block below is copied by
script, character for character, from the record of the deriver who wrote it — the first round's `plans/FS124-E1-derivation.md`
(sixteen entries) or the second round's `plans/FS124-E2-derivation.md` (fourteen) — and its argument is an address in that record
(`data/fs124/z1/build_derivation.py`; `--check` compares this file with what the script writes). The prose between the blocks is
the record job's and proves nothing. Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-derivation.md`, from
`plans/` (several minutes: two controls read three maps twice).*

**The grade of everything here.** Thirty entries: twenty-nine derived, one refuted. Each is [hand] or derived from [hand] entries,
**one mind, kernel pending**; four rest on a declared outside theorem or on an inherited entry of FS-132, named in their lines.
**No entry says that a weak six-colouring has a piece, a three-piece point or a close complementary pair, and none moves a value
of χ(ℝ²).** The kernel lane's state on 2026-10-07: the five entries of § 1's radius clause are kernel theorems through the gate (FS124-L1; 57 theorems, three modules); nine entries (marked "second module")
are being planned blind on branch `fs124-wk2`; the rest have no kernel job. **A second mind is owed on C124-LONE's Step II**, by its
deriver's own line, before what rests on it is built on outside this milestone (§ 3).

*Dated 2026-10-07 (FS-136's record job, FS136-Z1; the paragraph above is left standing): the second mind asked for in its
last sentence has looked, and the step has passed the kernel on a branch in the planner's statement of it — the dated
paragraph under C124-LONE, § 3. No grade moves.*

## How to read this file

**Order.** Each section is a chain: its head is the strongest form, and the entries under it marked *corollary* are its weaker
forms, each under the name its deriver gave it. No name is retired; a name that a later entry supersedes says so in the line
under it. The refuted wording is an entry of its own, with its counterexample (§ 3). The two calibrations are § 6.

**Class** — the objects an entry speaks of, in five kinds: *every weak colouring of an open set* (a measurable map to finitely
many labels, proper at almost every unit pair inside the set; nothing else assumed); *three-piece points by the letter*; *full
members*; *sector points*; *one held family* (a named object of this project). **Count** — whether the argument spends the number
six: *every* means it reads no number of labels; *six* means it uses that six labels are all the labels, and its failure at seven
is named. Where a deriver's tag or a card's kind disagreed with an entry's statement, the statement is followed.

**Definitions.** `S(p)`, `B(p, r)`, *weak `k`-colouring*, *present*, *tight for `(a, b)`*, *centre*, *far end*, *rhombus
completions*, *of kind both*: `data/fs124/claims.md` § The class, § The object. *Collars*: `plans/FS124-E1-derivation.md`
§ Notation used by every entry. *Three-piece point*, *close complementary pair*, *common unit point*, *saved by*, *pattern*:
`data/fs124/claims.md`, the dated line of 13:59 UTC, § Definitions. *Decomposition*, *edges*, *inner*, *outer*, *crossing*,
*separates*, *full*, *sector point*, *bowtie*: `plans/FS124-E2-derivation.md` § Notation used by every entry.

## 1 The class: the radius clause, and every direction

*The statement through which either answer of the milestone is consumed. In C124-RADIUS-DOWN's own `handoff:` words: with
C124-RADIUS-UP it gives, "at each k, that χ(ℝ²) ≤ k and 'every open disc has a weak measurable k-colouring' hold together or
fail together — at k = 6, with χ(ℝ²) ≤ 7 (row 33), the plane needs seven colours precisely if some open disc has no weak
measurable six-colouring". The direction toward six needs no import; the direction toward seven rests on one declared outside
theorem. Head: C124-RADIUS-GRAPH.*

derivation: C124-RADIUS-GRAPH
  statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the unit-distance graph on V has a proper k-colouring.
  uses only: that for two points v, v′ at distance 1 the map g ↦ (g(v), g(v′) − g(v)) is a bijection of the motion group onto the pairs (point, unit vector) carrying dφ dt to Lebesgue measure times arc length; weak properness in its measure form; that V is finite and U open. No count of labels, no regularity of c, nothing about the shape of U
  not claimed: anything for an infinite V (C124-RADIUS-COUNTABLE takes countable sets with compact closure in U); that any open set has a weak k-colouring; a bound on the measure of the good motions beyond "full"
  argument: FS124-E1-derivation.md § Argument — a random rigid motion
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, U the open disc of radius 2, c the hexagonal seven-colouring at circumradius 2/5 (colour (m + 3n) mod 7 on the hexagon about m(2√3/5, 0) + n(√3/5, 3/5)), V the seven points of a Moser spindle: of 20,000 sampled motions keeping V in U none gives a monochromatic unit pair (control `radius-motions`)
  prior art: partly: the argument for a colouring of the whole plane is `[GwynStavrianos2022]` Lemma 2 (held; read by FS-103, not re-read by me) and this library's N-EASY (`Proofs/HadwigerNelson/Plane/YesLimit.lean`, `AeColouring.exists_motion`; statement name read, proof not); for an open set — zbMATH "probabilistic Hadwiger" and "almost every" with "unit distance" and colouring (0), arXiv Hadwiger–Nelson with measurable and disc or bounded or local (3, none on point by title): not found in print
  handoff: de Bruijn — the statement as written, on the local weak colouring of an open set; it is `AeColouring.exists_motion` with "every motion" replaced by "the open set of motions keeping V in U". Read the formal statement back against "almost every motion in that open set", not "some motion"

**Class**: every weak `k`-colouring of an open set, every `k ≥ 1`. **Count**: every ("No count of labels", its *uses only* line).
**What rests on it**: C124-RADIUS-COUNTABLE, C124-RADIUS-UP and, through it, C124-RADIUS-FIVE. **Kernel**: `radius_graph`, through the gate (FS124-L1). **The kernel planner's generalizations, its own, recorded and not entered** (inventory item 14; the dated
line of `data/fs124/claims-K1.md`): in this entry, in C124-RADIUS-COUNTABLE and in C124-RADIUS-UP the measurability of the
colouring is idle — what is used is that the monochromatic unit pairs inside the set are a null set, for any function; this
entry's almost-every clause holds pair by pair for a countable set wherever it lies; "the pairs are the motions" is the whole
proof. A dated correction stands under the entry in its record: one clause of the hand argument is used by no later line.

derivation: C124-RADIUS-COUNTABLE
  statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a countable subset of U whose closure is a compact subset of U. Then the unit-distance graph on V has a proper k-colouring of the form v ↦ c(g(v)) for a rigid motion g with g(V) ⊂ U.
  uses only: C124-RADIUS-GRAPH's argument with countably many unit pairs; that a compact subset of an open set keeps a positive distance from its complement, so the motions near the identity keep V in U
  not claimed: anything for an uncountable V; anything for a countable V that accumulates at the boundary of U; that the colouring obtained is measurable in any sense on a larger set
  argument: FS124-E1-derivation.md § Argument — a random rigid motion
  verdict: derived
  grade: derived from: C124-RADIUS-GRAPH
  minds: 1
  model: as C124-RADIUS-GRAPH's, with V the points of the closed disc of radius 1 with both coordinates in ℚ(√3, √11) — a countable set dense in the disc holding every Moser spindle of that field inside it
  prior art: owed — not searched for in this form; for the whole plane it is the remark that N-EASY needs no compactness for a countable subfield's plane
  handoff: none — a relay-result; it says where de Bruijn–Erdős (and with it the axiom of choice) enters C124-RADIUS-UP: only in passing from countable sets to the whole plane

*Corollary of C124-RADIUS-GRAPH's argument.* **Class**: as above, with a countable set whose closure is compact in the open set.
**Count**: every. **What rests on it**: nothing here; it says where de Bruijn–Erdős enters C124-RADIUS-UP. **Kernel**: first module.

derivation: C124-RADIUS-UP
  statement: For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k.
  uses only: C124-RADIUS-GRAPH with U a disc holding the graph; the de Bruijn–Erdős theorem for the unit-distance graph of the plane. Of the hypothesis: for each finite graph, one disc that holds it
  not claimed: an explicit radius at any k; the converse (C124-RADIUS-DOWN, which uses an import); that the hypothesis holds at k = 6; anything from one disc beyond the finite graphs that fit inside it
  argument: FS124-E1-derivation.md § Argument — up, down, five
  verdict: derived
  grade: derived from: C124-RADIUS-GRAPH
  minds: 1
  model: k = 7: the hexagonal seven-colouring at circumradius 2/5 restricted to each disc satisfies the hypothesis, and χ(ℝ²) ≤ 7 is this library's row 33
  prior art: partly: de Bruijn–Erdős is classical (recalled, not read; used in this library by `chromaticNumber_plane_le_chiM0`); for arc maps of discs the conclusion is row 145's FS116-O1-YESLIM by a weak-* limit (`chromaticNumber_plane_le_six_of_fragments`); the bounded case for proper colourings is Kruskal 2008 (Zbl 1139.05023, held at abstract); the disc form for weak colourings not found in print (the queries of C124-RADIUS-GRAPH)
  handoff: de Bruijn — the statement as written, after C124-RADIUS-GRAPH; it subsumes FS116-O1-YESLIM's use (an arc map of a disc is a weak colouring of it), with no limit taken

*Corollary of C124-RADIUS-GRAPH.* **Class**: weak measurable `k`-colourings of the open discs about the origin, every `k ≥ 1`.
**Count**: every. **What rests on it**: C124-RADIUS-FIVE; with C124-RADIUS-DOWN, the disc criterion. **Kernel**: first module; the
planner's own: discs at any centres, and its contrapositive needs no import (item 14 (5)).

derivation: C124-RADIUS-DOWN
  statement: For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring.
  uses only: the declared outside theorem `Outside.OAI158.proper_to_borel_weak` ([kernel, outside]: a proper k-colouring of the plane gives a measurable one proper at almost every unit pair, at every k); that normalized angular measure and arc length have the same null sets; that the restriction of a weak colouring of the plane to an open set is a weak colouring of it
  not claimed: anything without that import; that χ(ℝ²) ≤ 6; any regularity of the colouring obtained beyond measurability
  argument: FS124-E1-derivation.md § Argument — up, down, five
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: the hypothesis is row 33, and the conclusion holds with the hexagonal seven-colouring, with no import (in this library `proper_to_borel_weak_model`)
  prior art: known: `[OAIMath2026]` family 158, "Transfer of colorability", forward direction; the restriction is immediate
  handoff: de Bruijn — one line over the import and the local definition; with C124-RADIUS-UP it gives, at each k, that χ(ℝ²) ≤ k and "every open disc has a weak measurable k-colouring" hold together or fail together — at k = 6, with χ(ℝ²) ≤ 7 (row 33), the plane needs seven colours precisely if some open disc has no weak measurable six-colouring (C132-RADIUS, as it was posed)

**Class**: every open set, every `k ≥ 1`; [hand] **over the declared outside theorem** `Outside.OAI158.proper_to_borel_weak`.
**Count**: every. **Kernel**: first module; the planner's own: it holds for every subset of the plane (item 14 (4)). **The disc
criterion** is this entry with C124-RADIUS-UP, said in this entry's `handoff:` line; as single statements it is the kernel
planner's two join theorems, not entries here — `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`
(`7 ≤ χ(ℝ²)` iff some open disc about the origin has no weak measurable six-colouring), each on the standard three axioms and that one declared outside theorem, **through the gate (FS124-L1)**. By the planner's record (§ 4.4): "*Seven gives such a disc* …
rests on the standard three axioms; *such a disc gives seven* … rests on the declared outside theorem"; "an exclusion on a disc
reaches seven only through the transfer, and weak six-colourings of every disc reach six with no import".

derivation: C124-RADIUS-FIVE
  statement: There is R > 0 such that no open disc of radius R has a weak measurable five-colouring.
  uses only: C124-RADIUS-UP at k = 5; the declared outside theorem `Outside.OAI158.no_proper_five_coloring` ([kernel, outside]); that discs of one radius are translates
  not claimed: any value of R — the argument gives the radius of a disc holding a finite unit-distance graph that is not five-colourable, which exists by compactness and has not been exhibited; the same at six
  argument: FS124-E1-derivation.md § Argument — up, down, five
  verdict: derived
  grade: derived from: C124-RADIUS-UP
  minds: 1
  model: the statement is an existence; its analogue with an exhibited radius is at k = 3: by C124-RADIUS-GRAPH no open disc holding a Moser spindle has a weak measurable three-colouring
  prior art: partly: `[OAIMath2026]` Thm 1.4 is the statement for the whole plane; for a disc not found in the release by the asking lane's reading (`plans/STUB-q-ring.md` § The first claims), not checked by me
  handoff: de Bruijn — a corollary; the formal statement to read back is "∃ R, no weak five-colouring of the ball of radius R"

*Corollary of C124-RADIUS-UP*, over the declared outside theorem `Outside.OAI158.no_proper_five_coloring`. **Class**: open discs
of one radius. **Count**: five — C124-RADIUS-UP read at the one number where the plane's answer is known; the asking lane files it with the
calibrations. No radius is exhibited. **Kernel**: first module.

*One dated line for the five entries above (C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE), filed by the coordinator from the landing's draft 8 (`plans/FS124-L1-landing.md`):* **2026-10-07, FS124-L1 — [kernel], through the full gate at `24a42aa9`**: `HadwigerNelson.Plane.radius_graph` (C124-RADIUS-GRAPH), `radius_countable` (-COUNTABLE), `radius_up` (-UP), each on `[propext, Classical.choice, Quot.sound]`; `radius_down` (-DOWN), on those and the declared outside theorem `Outside.OAI158.proper_to_borel_weak`; `radius_five` (-FIVE), on those and `Outside.OAI158.no_proper_five_coloring` (`Proofs/HadwigerNelson/Plane/Radius.lean`, `RadiusOutside.lean`; the definition, `WeakColouringOn.lean`). Statements FS124-K1's, proofs FS124-I1's, landed by FS124-L1. Each entry's words are the theorem named; under them the module proves the wider forms (any function proper at almost every unit pair, a countable set anywhere, any centres, every subset), which are the module's and not entries. No assumption in hypothesis form. "Measurable" is Borel; motions are read in their parameters.

control: radius-motions
  of: C124-RADIUS-GRAPH — the conclusion on its model: sampled rigid motions of a Moser spindle into the disc of radius 2 under the hexagonal seven-colouring at circumradius 2/5; the fault colours by hexagons of circumradius 3/5, of diameter 6/5, which is not a weak colouring
  run: python3 ../data/fs124/e1/tight_checks.py radius
  expect: circumradius=0.4 disc-radius=2.0 motions=20000 unit-pairs-per-motion=11 monochromatic-pairs=0
  fault: python3 ../data/fs124/e1/tight_checks.py radius --fault

derivation: C124-EVERY-DIRECTION
  statement: Let U be a measurable subset of the plane and c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U. Then for every unit vector u, c(z) ≠ c(z + u) for almost every point z of U with z + u in U.
  uses only: that translation is continuous in L² of the plane; Fubini for the pairs (z, u); that a continuous non-negative function vanishing at almost every point of the unit circle vanishes on it; countably many labels and radii
  not claimed: anything for a colouring that is not measurable (the kernel lane's remark is that the finite-set clause needs no measurability; this statement does); anything at distances other than 1; any use in this round — no entry below reads a fixed direction
  argument: FS124-E2-derivation.md § Argument — every direction
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring at circumradius 2/5 on the plane: for every unit vector u no point z at all has the label of z + u (tiles of diameter 4/5, same-label tiles more than 1 apart: C124-KIND's margins, first round)
  prior art: partly: by the kernel lane's planner it is the argument of a lemma of `[OAIMath2026]` for the whole plane (its relay, 2026-10-07; not read by me); the restriction to a measurable subset is the same four lines
  handoff: de Bruijn — only with a consumer; the planner asked the question, and the statement to read back is "for every unit vector, almost every point"

**Class**: every measurable weak colouring of a measurable set. **Count**: every. **What rests on it**: nothing in this file ("no
entry below reads a fixed direction"); it answers a question the kernel planner asked while typing the radius clause (item 14
(7)). **Kernel**: not stated in the first module — it waits for a consumer and for a lemma a port from the release brings (the
planner's record § 4.2).

## 2 The one lemma, and what one piece forces

*Head: C124-SHADOW-OPEN — an open set almost all of one label bars that label at almost every point whose unit circle meets it.
Every entry of this section but C124-OPEN is this lemma and a computation with circles.*

derivation: C124-SHADOW-OPEN
  statement: Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i.
  uses only: that W is open; Fubini for (p, u) ↦ p + u; weak properness in its measure form. No count of labels, no connectedness of W, no direction, no second label
  not claimed: anything for a set W that is not open; anything at a point whose unit circle meets only the boundary of W; that any weak colouring has an open one-label set
  argument: FS124-E1-derivation.md § Argument — the unit shadow of an open piece
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at seven (the Reuleaux triangle on the lattice points (m, n), (m + 1, n), (m, n + 1) coloured 2(m mod 2) + (n mod 2), the down triangle between coloured 4 + ((m − n) mod 3)): W the interior of the up tile at the origin, label 0 — the points at distance 1 from W carry no 0, and the tile's three arcs are where that set's boundary touches W's own (control `r7-tight`)
  prior art: partly: it is the second half of the argument of C132-SHADOW (`plans/FS132-E6-derivation.md` § Argument — the shadow of an open piece, read whole), whose statement keeps a segment and a direction the half never reads; G84's shadow identity for an open piece; in print the mechanism of `[OAIMath2026]` Lemma 8.1 by FS132-E5's reading (not read by me); for sets avoiding a distance and Minkowski sums with a circle the plan's §PA queries found no statement of it
  handoff: de Bruijn — the statement as written: one open set, one Fubini; C132-SHADOW is its corollary by one intermediate value, and every entry of this stage is this lemma and a computation with circles

**Class**: every weak colouring of an open set; one open one-label set, not assumed connected. **Count**: every. **What rests on
it**: every other entry of this section but C124-OPEN; through C124-TYPE and C124-CENTRE-HALF, C124-FORCED-PIECES, C124-FORCED,
C124-LONE, C124-BOTH, C124-FOUR, C124-SECOND and C124-EDGE-CLOSED; through C124-CENTRE, § 5's C124-SIX. **Kernel**: second
module (being planned blind).

derivation: C124-TYPE
  statement: Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i.
  uses only: C124-SHADOW-OPEN (`plans/FS124-E1-derivation.md` Stage 4; [hand], one mind — inherited, its argument read whole) for W = P; that a connected open set is path-connected; the intermediate value theorem for the distance to z along a path; that x is a limit of points of P
  not claimed: anything for a piece that is not connected or not open; a uniform η over pieces or over the point of P chosen; anything on the side not named; that any weak colouring has such a piece
  argument: FS124-E2-derivation.md § Argument — one piece, one side
  verdict: derived
  grade: hand
  minds: 1
  model: FS-112's strip at w = (0, 0), x = (1/2, √3/2): its three tiles there read inner (P), outer (O) and crossing (G), and at w the label P is read only inside S(x), O only outside, G nowhere (control `saves-maps`, Stage 5: 71 points, four labels each)
  prior art: partly: it is C132-WITNESS followed by C132-WIT-SIDE (`plans/FS132-derivation.md` § 2; statements read, arguments not) in one statement on C124-SHADOW-OPEN; for maps the edge exclusion (`[SokolovVoronov2025]` Props. 1–2 by row 134, not read by me); this form not found in print (the plan's §PA, second round)
  handoff: de Bruijn — the statement as written, after C124-SHADOW-OPEN: a path, one intermediate value, one inclusion in a set of the form W + S¹

*The lemma on one piece and one side.* **Class**: every weak `k`-colouring of an open set; one **connected** open one-label piece
with a point of its closure one unit from `w`. **Count**: every. **By its deriver it is two of last night's entries in one
statement** — C132-WITNESS followed by C132-WIT-SIDE (`plans/FS132-derivation.md` § 2), on C124-SHADOW-OPEN; their statements
were read by that deriver, their arguments not. **What rests on it**: C124-FORCED-PIECES, C124-LONE, C124-FOUR and
C124-EDGE-CLOSED. **Kernel**: second module.

derivation: C124-CENTRE-HALF
  statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a.
  uses only: the argument of C124-CENTRE (`plans/FS124-E1-derivation.md` § Argument — the centre, the straddle, the antipode, "The centre": [hand], one mind — inherited, read whole), which treats its two sentences separately, each from one collar and C124-SHADOW-OPEN
  not claimed: anything about the other collar; that (q, z) is tight
  argument: FS124-E2-derivation.md § Argument — the save by one member
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at a lattice point, as C124-CENTRE's (first round, control `r7-tight`): each of its two counts there is one half of this statement
  prior art: partly: it is C124-CENTRE with its hypothesis split (G92); C132-SHADOW with a radial direction
  handoff: de Bruijn — state C124-CENTRE in this form: one collar, one conclusion; the two-collar statement is its conjunction

*The centre, collar by collar — the stronger form of C124-CENTRE.* **Class**: every weak `k`-colouring of an open set; one label
filling one side of a unit circle near one end of a unit pair. **Count**: every. **What rests on it**: C124-LONE. **Kernel**:
second module. Its grade is [hand] over the first round's argument, inherited and read whole by its deriver.

derivation: C124-CENTRE
  statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b.
  uses only: C124-SHADOW-OPEN for the two collars; for a point p near q, the point of S(p) on the line through p and z, which lies in the inner collar when |p − z| > 1 and in the outer one when |p − z| < 1
  not claimed: that a or b is present at q (C124-KIND: neither need be); anything about the other labels near q; that this is all a tight pair forces at q — with a second tight far end z′ for the same (a, b) the conclusions intersect, and near q the label a is confined to B̄(z, 1) ∩ B̄(z′, 1), a region with angle π − ∠zqz′ at q
  argument: FS124-E1-derivation.md § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-SHADOW-OPEN
  minds: 1
  model: R7 at seven, q the origin, z any point of its ring in directions (0°, 60°), (a, b) = (0, 4): near q the label 0 fills a 120° sector, all of it within 1 of z, and the label 4 is present along one ray only, the cusp at 210°, at distance at least 1 from z (control `r7-tight`: 3,213 samples with the inside label, 27 with the outside label, no violation); at six, 62 unit arcs of FS-112's strip and disk, 58 of kind both (control `maps-tight`)
  prior art: partly: in the map class it is row 138's cone form ("every tile's cone and colour is pinned by the half-planes facing the edges' centres", FS-114) and FS121-DB1's cone lemma on R7 (`tools/fs121_db1_r7cones.py`); as an instance of C132-SHADOW it was matched sign by sign by the asking lane (`plans/POROS-2026-10-07-fs124-question.md` Stage 2); for a weak colouring not found in print (plan §PA)
  handoff: de Bruijn — the statement as written, after C124-SHADOW-OPEN: two inclusions of a half-ball in a set of the form W + S¹

*Corollary: the conjunction of C124-CENTRE-HALF's two halves* (that entry's `handoff:` line); its grade is its source's, derived
from C124-SHADOW-OPEN. **Class**: every weak `k`-colouring; a tight pair. **Count**: every. **What rests on it**:
C124-SIX-CONES. **Kernel**: second module.

derivation: C124-STRADDLE
  statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b.
  uses only: C124-SHADOW-OPEN for the two collars; that two distinct unit circles through z are tangent there only when their centres are equal or symmetric about z, and otherwise cross, each passing from the inside of the other to its outside. Of tightness: that z lies in the closure of both collars and that they lie on the two sides of S(q) near z
  not claimed: a uniform η as p tends to q or to 2z − q (it tends to 0); anything at those two points (C124-CENTRE, C124-ANTIPODE); anything that reads the radius of the interface — for an interface of any shape the statement at a point whose unit circle crosses it is C132-WITNESS's
  argument: FS124-E1-derivation.md § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-SHADOW-OPEN
  minds: 1
  model: as C124-COMPLETION's; and as a statement about circles alone: 11,000 points near eleven points one unit from z (10° to 350° round z, the completions at 120° and 240°), every one with its unit circle meeting both collars (control `shadow-geometry`)
  prior art: partly: C132-WITNESS (`plans/FS132-derivation.md` § 2) gives it for a connected open one-label region and a compact piece of its boundary; the map class's edge exclusion; not found in print for a weak colouring
  handoff: de Bruijn — the statement as written; one derivative of a trigonometric function and two uses of C124-SHADOW-OPEN

*The wide form at a point one unit from a far end.* **Class**: every weak `k`-colouring; a tight pair and any point one unit from
its far end but two. **Count**: every. **What rests on it**: C124-COMPLETION. **Kernel**: second module.

derivation: C124-COMPLETION
  statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and w a rhombus completion of the pair lying in U. Then there is η > 0 such that almost every point of B(w, η) has a label other than a and other than b.
  uses only: C124-STRADDLE at p = w, which is one unit from z and is neither q nor 2z − q
  not claimed: that any given label is present at w; that w is an end of a tight pair, or carries more than one label (in R7 it is an interior point of a tile); anything that spends the number of labels; anything special to tight pairs — the conclusion holds beside every interface between two open one-label pieces
  argument: FS124-E1-derivation.md § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-STRADDLE
  minds: 1
  model: R7 at seven: the completions of every far end read lie in tiles of the label 3 (control `r7-tight`); at six: 114 completions of the strip's and the disk's unit arcs that lie in the fragments, 2,850 samples, none with a label of its pair (control `maps-tight`)
  prior art: partly: in the map class it is the 60° rule of the ring calculus (G91; FS116-RING-TWIST-C) and the edge exclusion (`[SokolovVoronov2025]` Props. 1–2 by row 134; C132-WITNESS for a region of a weak colouring); posed for a weak colouring by the asking lane; not found in print for a weak colouring (plan §PA)
  handoff: none — subsumed by C124-STRADDLE, which crosses

*Corollary: C124-STRADDLE at a rhombus completion.* **Class**, **count**: as C124-STRADDLE. By its own *not claimed* line the
conclusion is not special to tight pairs. No kernel job of its own.

derivation: C124-ANTIPODE
  statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and suppose p = 2z − q lies in U. Then there is η > 0 such that almost every point of B(p, η) has a label other than b, and almost every point w of B(p, η) with |w − q| < 2 has a label other than a.
  uses only: C124-SHADOW-OPEN for the two collars; that S(w) ∩ B̄(q, 1) is an arc whose length tends to 0 as |w − q| tends to 2, and is non-empty with interior exactly when |w − q| < 2; that w ↦ w + (q − w)/|q − w| is continuous
  not claimed: that a is present near p; that the circle of radius 2 about q is an interface there; anything about the points near p at distance more than 2 from q beyond the absence of b
  argument: FS124-E1-derivation.md § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-SHADOW-OPEN
  minds: 1
  model: R7 at seven, q the origin, (a, b) = (0, 4): near the points at distance 2 in directions (0°, 60°) no sample carries 4 and none inside the circle of radius 2 carries 0 (control `r7-tight`: 1,080 samples); as a statement about circles, 4,000 points near 2z − q, 2,006 of them inside the circle of radius 2 (control `shadow-geometry`)
  prior art: partly: G85's unit parallels (row 140, for saturated colourings) and row 135's radius-2 configuration (R2) are the map-class neighbours; this statement, for a weak colouring and with no saturation, not found in this project's files by grep of the entries I read, nor in print — owed beyond that
  handoff: de Bruijn — the statement as written; it is the far half of what a tight pair forces and is not posed on the card

**Class**: every weak `k`-colouring; a tight pair whose opposite point lies in the set. **Count**: every. **What rests on it**:
nothing here. Not among the second module's nine statements.

derivation: C124-OPEN
  statement: If (q, z) is tight for (a, b) with radius ρ, then (q, z′) is tight for (a, b) for every point z′ with |z′ − q| = 1 and |z′ − z| < ρ.
  uses only: B(z′, ρ − |z′ − z|) ⊂ B(z, ρ)
  not claimed: anything at an end of a maximal arc of tight far ends; that such an arc has ends in U
  argument: FS124-E1-derivation.md § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at the origin: the far ends tight for (0, 4) are the open arc of directions (0°, 60°), read as (0.5°, 59.5°) at the control's resolution (control `r7-tight`)
  prior art: owed — a remark on a definition of this milestone
  handoff: none — a relay-result: the object is an arc with ends; the kernel lane needs it only if a later statement is about a maximal arc

*A remark on the definition: the tight far ends of a centre form an open arc.* **Count**: every. Nothing rests on it; no kernel job.

control: shadow-geometry
  of: C124-STRADDLE — the three computations as statements about circles, no colouring: for sampled points near q, near eleven points one unit from z, and near 2z − q, whether the unit circle meets each collar (ρ = 0.05), against the claims of C124-CENTRE, C124-STRADDLE and C124-ANTIPODE; the fault takes an interface arc of radius 0.9 about q, for which the centre's and the antipode's predicates must fail
  run: python3 ../data/fs124/e1/tight_checks.py geometry
  expect: arc-radius=1.0 centre-samples-far,near=1961,2039 straddle-samples=11000 antipode-samples,inside-radius-2=4000,2006 disagreements=0
  fault: python3 ../data/fs124/e1/tight_checks.py geometry --fault

control: r7-tight
  of: C124-CENTRE — on R7 by formula, at a lattice point: the tight windows of its ring with their label pairs; near the centre, the samples with the inside and the outside label and those on the wrong side; the labels at the completions; the antipode; and which points centre tight arcs — the six ends of the three windows, and six completions of interior far ends. Tight on this model: R7 has no margin. The fault colours the up tiles by n mod 2 only (an improper colouring that keeps the arcs)
  run: python3 ../data/fs124/e1/tight_checks.py r7
  expect: windows=3 (0.5,59.5):0|4 (120.5,179.5):2|5 (240.5,299.5):1|6 centre-samples=9720 with-inside-label=3213 with-outside-label=27 centre-violations=0 completion-labels=[3] completion-violations=0 antipode-samples=1080 antipode-violations=0 ends-centring-tight-arcs=6/6 completions-centring-tight-arcs=0/6
  fault: python3 ../data/fs124/e1/tight_checks.py r7 --fault

control: maps-tight
  of: C124-COMPLETION — the held six-coloured maps, read from their own tiles (FS-112's strip, tiles −4 to 6, and its disk, through `tools/fs116_n1_ring.py`'s loader and `tools/fs116_n3_semi.py`'s two-ray point location): every boundary piece of radius 1 read as a tight pair at its midpoint; C124-CENTRE at its centre; C124-COMPLETION at its two completions. The fault recolours the tile at one completion with the pair's inside label, and reads the centres with the two labels exchanged
  run: python3 ../data/fs124/e1/tight_checks.py maps
  expect: strip: unit-arcs=46 tight=42 centres-in-fragment=42 of-kind-both=38 centre-samples-inside-label,outside-label=1514,1366 centre-violations=0 completions-in-fragment=74 completion-samples=1850 completion-violations=0 ; disk: unit-arcs=20 tight=20 centres-in-fragment=20 of-kind-both=20 centre-samples-inside-label,outside-label=720,720 centre-violations=0 completions-in-fragment=40 completion-samples=1000 completion-violations=0
  fault: python3 ../data/fs124/e1/tight_checks.py maps --fault

control: hex-half-none
  of: C124-CENTRE — where the hypothesis is not met it must not be read as met: on the hexagonal seven-colouring at circumradius 1/2 a vertex's unit circle passes through three vertices and no edge lies on it — no direction of its ring reads as tight; the fault reads R7's ring with the same reader
  run: python3 ../data/fs124/e1/tight_checks.py hexhalf
  expect: colouring=hex7 circumradius=0.5 labels-at-vertex=3 three-label-points-on-its-ring=3 ring-directions=720 tight-directions=0
  fault: python3 ../data/fs124/e1/tight_checks.py hexhalf --fault

control: maps-ends
  of: C124-OPEN — the ends of the tight arcs on the held six-coloured maps: for every boundary piece of radius 1 of FS-112's strip and disk, whether its two end points are centres of boundary pieces of radius 1; the fault shifts every end point by 0.01
  run: python3 ../data/fs124/e1/tight_checks.py ends
  expect: strip: unit-arc-pieces=46 ends=92 ends-that-centre-a-unit-arc=0 ; disk: unit-arc-pieces=20 ends=40 ends-that-centre-a-unit-arc=10
  fault: python3 ../data/fs124/e1/tight_checks.py ends --fault

## 3 The pair: what a close complementary pair forces at a common unit point

*The setting of every entry: a weak **six**-colouring of an open set, two three-piece points less than 2 apart whose label triples
are disjoint, each with a decomposition into three pieces, and a point of the set one unit from both. Head: C124-FORCED-PIECES.
**No entry claims that a weak six-colouring has such points.***

derivation: C124-FORCED-PIECES
  statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).
  uses only: C124-TYPE for the six pieces; that a non-empty open set lies on no circle, so each piece has a point strictly inside or strictly outside S(w); that 0 < |x − y| < 2 makes w − x and w − y linearly independent, so the four regions cut at w by S(x) and S(y) are non-empty and open; that two disjoint triples of six labels are all the labels; one identity of propositional logic
  not claimed: that a weak six-colouring has a three-piece point, or a close complementary pair; which member separates, or that both do (C124-BOTH needs full members; in fragment S1 one does not); that the edge of the two pieces is more than the member itself (at a bowtie it is not); anything with seven labels (C124-FORCED-SEVEN)
  argument: FS124-E2-derivation.md § Argument — four regions, six pieces
  verdict: derived
  grade: derived from: C124-TYPE
  minds: 1
  model: fragment T2 at w = (1/2, √3/2): x = (0, 0) has two outer pieces and one inner, y = (1, 0) one of each side; fragment BB: both members bowties, each with one inner and one outer piece meeting at the member only (control `saves-fragments`)
  prior art: partly: C132-COMP-SHARP (`plans/FS132-derivation.md` § 4, one mind) is the statement on exclusion sets, whose conclusion a one-point set satisfies; for maps FS107-W-TAN ("a tangent pair or include a bowtie", `plans/FS107-derivation.md` l. 100) and FS112-N3-COR3 (row 135); the piece form, in measure, not found in print
  handoff: de Bruijn — the statement as written, after C124-TYPE: six applications, four non-empty open regions, and (A ∨ C)(A ∨ D)(B ∨ C)(B ∨ D) = AB ∨ CD. Read the formal statement back against "inside the closed disc" and "disjoint from the open disc" — not against "an edge lies on the circle"

**Class**: three-piece points by the letter. **Count**: six; its failure at seven is C124-FORCED-SEVEN (§ 6). **It is the form
with content of last night's C132-COMP-SHARP**, whose conclusion a one-point set satisfies (a dated correction stands under that
entry in `plans/FS132-derivation.md`). **What rests on it**: C124-FORCED, C124-LONE and through it C124-BOTH, C124-FOUR,
C124-SECOND. **Kernel**: second module. *A reading of its argument by the asking lane, not entered*: it reads "every label is a
label of a piece at one of the two points", not two disjoint triples (inventory item 26); stated at that class it is a first
claim of the successor (`plans/STUB-covering-pairs.md`), not a result of this file.

derivation: C124-FORCED
  statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of sector points and w a common unit point of the pair lying in U. Then w is saved by x or by y; and for every interior point z of the arc so obtained the pair (w, z) is tight for the two labels of that edge, in one order along the arc.
  uses only: C124-FORCED-PIECES; for a sector point, that each of the three arcs of its decomposition lies in the closure of exactly two of the three components and that every two components share one arc (the θ-curve form of the Jordan–Schoenflies theorem: recalled, not read); that a connected subset of a circle containing two points contains an arc between them; that an open subset of a closed disc lies in the open disc
  not claimed: that a weak six-colouring has a sector point, or a close complementary pair; the same for every three-piece point by the letter (C124-FORCED-AS-POSED: refuted); that only one edge lies on S(w) (fragment T2 and the kept model have two at one member); that the arc is maximal or where it ends
  argument: FS124-E2-derivation.md § Argument — sector points
  verdict: derived
  grade: derived from: C124-FORCED-PIECES
  minds: 1
  model: the strip, the disk, the capped strip, fragment T2 and the kept model: at each of their 170 common unit points inside, both members are sectors and each has an edge on the point's unit circle (controls `saves-maps`, `saves-fragments`)
  prior art: partly: for maps it is half of FS112-N3-COR3 (row 135: each corner "a leaving centre of both"; two minds, one blind); in measure, posed by the asking lane's card (`plans/STUB-q-ring.md`, the section after the first round); not found in print
  handoff: de Bruijn — after C124-FORCED-PIECES, and only if the kernel lane wants the map-shaped corollary: its one topological input is the θ-curve lemma, which is not in the statement of C124-FORCED-PIECES

*Corollary: the posed claim, for sector points.* **Class**: sector points. **Count**: six. One topological input (the θ-curve form
of the Jordan–Schoenflies theorem) is recalled, not read. **What rests on it**: the second sentence of C124-BOTH, by its
argument; C124-SECOND is stated in its setting.

derivation: C124-FORCED-AS-POSED
  statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points and w a common unit point of the pair lying in U. Then w is saved by x or by y; and for every interior point z of the arc so obtained the pair (w, z) is tight for the two labels of that edge, in one order along the arc.
  uses only: the definitions of the claim list, read by the letter; fragment BB of FS110-FRAGS (`tools/fs110_y_fragments.py`, valid by FS110-Y's exact checker: control `seam-fragments` of `plans/FS132-derivation.md` § 4 prints ACCEPT); two bands, each inside a disc of radius 3/10 about a member
  not claimed: that the posed statement fails for sector points or for full points (C124-FORCED: derived); that the banded fragment extends beyond its flowers and bands; anything about a three-piece point whose pieces stay connected in every small disc about it
  argument: FS124-E2-derivation.md § Argument — the banded bowtie
  verdict: refuted: fragment BB with each bowtie's repeated label joined by a band — both members are three-piece points by the letter, their labels are 1, 2, 3 and 4, 5, 6, they are 1 apart, and no edge of either contains an arc of a circle
  grade: hand
  minds: 1
  model: the object itself: at both common unit points the reader finds no boundary of either member on the point's unit circle, and both members separating (control `saves-fragments`: "BB … patterns=00:2 separating=xy(bb):2")
  prior art: partly: the bowtie as the exception is FS107-W-TAN's and C132-COMP-SHARP's *not claimed* line ("fragments S1, BB and MX … are valid with one"); the letter of the card's definition admitting it is this job's reading
  handoff: none — a refuted statement; what crosses is C124-FORCED-PIECES

**The refuted wording**: the claim as the card posed it, for every three-piece point by the letter. Its counterexample is in its
`verdict:` line. What stands in its place is C124-FORCED-PIECES (three-piece points, on pieces) and C124-FORCED (sector points,
with an arc). **Class**: three-piece points by the letter. **Count**: six.

derivation: C124-LONE
  statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.
  uses only: C124-TYPE for the six pieces; C124-CENTRE-HALF at the centre x for one far end w′ of S(x) near w, strictly on the chosen side of S(y); that two distinct unit circles through x that are not tangent there cut every small disc about x into four non-empty open sets and meet near x at x only; that the three pieces fill a neighbourhood of x up to a null set
  not claimed: that a weak six-colouring has a three-piece point, or a close complementary pair; that such a configuration is impossible — it is fragment S1's (C124-LONE-EXISTS); anything about the edges of the crossing piece (one of them may lie on S(w)); that (x, w′) is tight on both sides of S(y)
  argument: FS124-E2-derivation.md § Argument — the save by one member
  verdict: derived
  grade: derived from: C124-FORCED-PIECES, C124-CENTRE-HALF
  minds: 1
  model: fragment S1 at w = (1/2, √3/2): y = (1, 0) has pieces crossing, inner, crossing; x = (0, 0) has the piece of label 2 inner, of label 3 outer, of label 1 crossing; the labels at w are 2 and 3, split along S(x); the pieces of labels 2 and 3 are the opposite sectors (60°, 120°) and (240°, 300°) and meet at x only (control `saves-lone`)
  prior art: partly: for maps it is the content of FS112-N3-COR3's step "One failure is not enough" (`plans/FS112-NB3-verification.md` ll. 125–128: side cones of arcs against N112-U1; statement and that paragraph read, the lemmas under it not) and of FS107-W-TAN's alternative "or include a bowtie"; in measure, with unit circles in place of side cones, not found in print
  handoff: de Bruijn — the statement as written, after C124-FORCED-PIECES and C124-CENTRE-HALF: a case split on (inner, outer) counts (1, 2), (2, 1), (1, 1) and two inclusions

*What a save by one member alone forces.* **Class**: three-piece points by the letter, one member not separating. **Count**: six.
**A second mind is owed on its Step II** (`plans/FS124-E2-derivation.md` § Argument — the save by one member), by its deriver's
own line — "before C124-BOTH, C124-FOUR or C124-EDGE-CLOSED is built on outside this milestone"; the kernel planner of the second
module is that mind, blind first. *The record job's reading of the `uses only:` lines*: C124-BOTH, C124-FOUR and C124-SECOND rest
on this entry; C124-EDGE-CLOSED does not. **What rests on it**: those three. **Kernel**: second module.

*Dated 2026-10-07, filed by FS-136's record job (FS136-Z1; sources: `plans/FS124-close-inventory.md` items 33 and 41–42;
the paragraph above is left standing).* **The step its deriver flagged has had its second look, and has passed the kernel
on a branch in the planner's statement of it.** *The second look* (item 33): the kernel planner of the second module
"reached the statement **blind, by the same route, dated by its commit before it read the first** — and then read the
first sentence by sentence"; its words: "my route IS its, and the step stands as written"; "I did not find an error. One
mind's reading of another's argument; the kernel will be the check that counts." What it found implicit, "none of it a
gap", and its two notes for the author — the bound "with `η ≤ 1`", and that the step's real hypothesis "is not 'the other
member does not separate' but the half-window it produces" — stand as a dated correction under the step in
`plans/FS124-E2-derivation.md` (16:33 UTC). *The kernel* (items 41–42): C124-LONE is `closePair_lone`, on
`[propext, Classical.choice, Quot.sound]`, kernel-checked on branch `fs124-wi3` and **not through the gate**; "C124-LONE's
Step II is in the kernel as three named theorems." *What was not checked*, in those items' words: by the coordinator,
"its read-aloud; the build logs"; and by the implementer, "What is not shown: that the four claims' hypotheses are
inhabited" — "until they land, non-vacuity is the planner's two sampled witnesses, [measured]". *What it does to the
grade*: nothing yet — "C124-LONE, C124-BOTH and C124-FOUR stay '[hand], one mind, kernel pending'" (item 33) until the
module lands. And for whoever builds on C124-BOTH's second sentence (FS-136's C136-PARTNERS does): that clause is "TRUE
for arc-edged decompositions [kernel, on a branch]; GAP for the list's sector points at one named step" (item 42).

derivation: C124-LONE-EXISTS
  statement: There is a weak six-colouring of an open set U, by formula, with a close complementary pair (x, y) of three-piece points and a common unit point w of the pair in U at which y does not separate.
  uses only: fragment S1 of FS110-FRAGS (`tools/fs110_y_fragments.py`; valid by FS110-Y's exact checker: control `seam-fragments` of `plans/FS132-derivation.md` § 4 prints ACCEPT for S1); the band β_u of C124-FORCED-AS-POSED's argument, which S1's bowtie admits unchanged (the same four tiles at u, label 1 repeated, no label 1 elsewhere)
  not claimed: a value of the chromatic number of the plane — the object lives on four flowers of radius at most about 1/4 and one band and fixes none; that it extends to any larger set; a save by one member at a full member (C124-BOTH excludes it); the card's pattern "exactly one edge of x on the circle" — here no edge of x lies on S(w); that x is a three-piece point in any sense but the letter's (its repeated label is connected only through the band)
  argument: FS124-E2-derivation.md § Argument — the save by one member
  verdict: derived
  grade: hand
  minds: 1
  model: the object itself: x = (0, 0) a bowtie with labels 1 (two sectors, joined by the band), 2, 3; y = (1, 0) a sector point with labels 4, 5, 6; w = (1/2, √3/2); near w only the labels 2 and 3, inside and outside S(x) (control `saves-lone`)
  prior art: known: the fragment is FS110-Y2's S1 ("a bowtie u whose unit circle carries two boundary arcs … through w and w′; v generic trivalent", row 134's "exact local fragments of every seam"); read as a save by one member, and joined so as to be a three-piece point by the letter, here
  handoff: none — a local object; it is the model that keeps C124-LONE from being a statement over an empty class

*Where the save by one member exists.* **Class**: one held family — fragment S1 with one band; "four flowers of radius at most
about 1/4 and one band", fixing no value. **Count**: six. It keeps C124-LONE, and the first round's C124-HALF, from being
statements over empty classes; its saving member is a three-piece point by the letter only.

derivation: C124-BOTH
  statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.
  uses only: C124-LONE in both orders; the definition of full; for sector points the argument of C124-FORCED and that a sector point is full
  not claimed: that a weak six-colouring has a full three-piece point, or a close complementary pair; that exactly one edge of each member lies on S(w) (T2, the kept model: two at one member); anything when a member is not full (S1: one member saves alone)
  argument: FS124-E2-derivation.md § Argument — the save by one member
  verdict: derived
  grade: derived from: C124-LONE
  minds: 1
  model: FS-112's strip and disk and FS-114's capped strip: at each of their 71, 20 and 71 common unit points inside, both members are sectors and both separate, with one edge of each on the point's circle (control `saves-maps`)
  prior art: partly: for maps FS112-N3-COR3 (row 135; [hand], two minds, one blind: "each a leaving centre of both u and u′") — this is its form for a weak measurable colouring and full three-piece points, by another route; not found in print
  handoff: de Bruijn — the statement's first sentence, after C124-LONE; the second sentence with C124-FORCED's topological input

*Where the save by one member is excluded.* **Class**: full members (first sentence); sector points (second sentence).
**Count**: six. By its *prior art* line it is the form, for a weak measurable colouring and by another route, of the map class's
FS112-N3-COR3 (row 135; two minds, one blind) — which this entry's one mind does not inherit. **What rests on it**: C124-SECOND.
**Kernel**: second module (the first sentence).

derivation: C124-FOUR
  statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.
  uses only: C124-TYPE (at most those four); the second half of C124-LONE's argument applied to a side of S(y), or of S(x), on which one of the four labels is absent; fullness of both members
  not claimed: that a weak six-colouring has a full three-piece point, or a close complementary pair; which label fills which of the four regions, or that each region carries one label; anything when a member has two inner or two outer pieces (T2: five labels allowed, four present)
  argument: FS124-E2-derivation.md § Argument — the save by one member
  verdict: derived
  grade: derived from: C124-LONE
  minds: 1
  model: the strip at w = (0, 0) with x = (1/2, √3/2), y = (1/2, −√3/2): labels P, O, M, B present, G and R (the crossing pieces') absent; and 168 of 168 such points over the held objects (controls `saves-maps`, `saves-fragments`)
  prior art: partly: for maps FS112-N3-COR3's "vertices of at least four colours" (row 135); the equality was read by the asking lane ("91 of 91", `plans/POROS-2026-10-07-fs124-round1.md` § 1.3) with the remark that it "is read … not derived" (`plans/STUB-q-ring.md`, the section after the first round); C124-HALF-TWO (first round) is the upper bound
  handoff: de Bruijn — after C124-LONE; with C124-TYPE it is the first statement of this milestone that determines a point's label set from a count on six

**Class**: full members, each with exactly one inner, one outer and one crossing piece at the point. **Count**: six. C124-HALF-TWO
(§ 5) is its upper bound from exclusion sets. **What rests on it**: C124-SECOND. **Kernel**: second module.

derivation: C124-SECOND
  statement: In the setting of C124-FORCED for sector points let both common unit points w, w′ lie in U, each with pattern (1, 1). Then the edge of x on the unit circle about w and its edge on the unit circle about w′ are different edges, and the edge of y on the unit circle about w and its edge on the unit circle about w′ are different edges; the labels present at w and those present at w′ are two sets of four with exactly two labels in common, one of each member; their absent pairs are disjoint; and the six labels have a cyclic order in which the three pairs read at w (the two edges, the absent pair) and the three read at w′ alternate.
  uses only: C124-BOTH and C124-FOUR at both points; that with exactly one edge of a sector member on S(w) its third piece is crossing (an inner or outer third piece would put a second arc of the decomposition on S(w)); that an arc from x has nested initial pieces, and two distinct circles share at most two points; a count over 36 label patterns
  not claimed: that a weak six-colouring has a sector point, or a close complementary pair; that the saves close up along a chain of pairs; any exclusion; anything when a pattern is not (1, 1) (T2: (2, 1) and (1, 2))
  argument: FS124-E2-derivation.md § Argument — the two points of a pair
  verdict: derived
  grade: derived from: C124-BOTH, C124-FOUR
  minds: 1
  model: the strip's pair x = (1/2, √3/2) (labels G, O, P), y = (1/2, −√3/2) (B, M, R): at (0, 0) the edges P|O and M|B, absent G, R; at (1, 0) the edges G|O and R|B, absent P, M; common labels O and B; the cyclic order P, O, G, R, B, M (`data/fs124/e2/out/strip.txt`, the two rows of that pair)
  prior art: partly: posed by the asking lane with the strip's order; C124-HALF-TWO (first round) for the upper bound on the labels; not found in print
  handoff: de Bruijn — after C124-FOUR: a finite count; the statement to read back is the alternation, not only "different edges"

*The pair's two saves.* **Class**: sector points, both common unit points in the set, each with pattern (1, 1). **Count**: six.
Nothing rests on it; no statement uses it twice along a chain. No kernel job.

control: quadrant-count
  of: C124-FORCED-PIECES — the count as a function of the six sides alone: over the 729 assignments of inner, outer, crossing to the six pieces, the number in which "each of the four regions has a piece of its side at x or at y" differs from "x or y has an inner and an outer piece"; the fault lets a crossing piece of x serve its regions
  run: python3 -c "import itertools as I;print(sum(all(any(s==a for s in p[:3]) or any(s==b for s in p[3:]) for a in 'io' for b in 'io')!=(('i' in p[:3] and 'o' in p[:3]) or ('i' in p[3:] and 'o' in p[3:])) for p in I.product('ioc',repeat=6)))"
  expect: 0
  fault: python3 -c "import itertools as I;print(sum(all(any(s in a+'c' for s in p[:3]) or any(s==b for s in p[3:]) for a in 'io' for b in 'io')!=(('i' in p[:3] and 'o' in p[:3]) or ('i' in p[3:] and 'o' in p[3:])) for p in I.product('ioc',repeat=6)))"

control: saves-fragments
  of: C124-FORCED-PIECES — the reader on fragments T2, BB and MX and on the Searcher's kept model: members (sectors + bowties), pairs, common unit points inside, patterns (edges of x, edges of y on the point's circle), who separates (x, y, by member kind), the four-label count, C124-HALF-TWO's hypothesis, unit arcs of kind both and how many are edges of saves. Tight on these models: none has a margin. The fault moves every common unit point by 0.01
  run: python3 ../data/fs124/e2/saves_read.py T2 BB MX kept --brief
  expect: T2: members=2s+0b pairs=1 inside=2 patterns=12:1,21:1 separating=xy(ss):2 four=0/0 half-two=0/0 arcs-of-kind-both=4 edges-of-saves=4
    BB: members=0s+2b pairs=1 inside=2 patterns=00:2 separating=xy(bb):2 four=2/2 half-two=0/0 arcs-of-kind-both=0 edges-of-saves=0
    MX: members=1s+1b pairs=1 inside=2 patterns=02:1,21:1 separating=xy(bs):2 four=1/1 half-two=0/0 arcs-of-kind-both=2 edges-of-saves=2
    kept: members=4s+0b pairs=3 inside=6 patterns=11:3,12:1,21:2 separating=xy(ss):6 four=3/3 half-two=3/3 arcs-of-kind-both=9 edges-of-saves=9
  fault: python3 ../data/fs124/e2/saves_read.py T2 BB MX kept --brief --fault

control: saves-r7
  of: C124-FORCED-PIECES — where the hypothesis is not met it must not be read as met: R7 on 49 lattice points has no vertex of three labels, so no member and no pair; the fault reads the honeycomb at 2/5 with the same reader (66 members)
  run: python3 ../data/fs124/e2/saves_read.py r7 --brief
  expect: r7: members=0s+0b pairs=0 inside=0 patterns=none separating=none four=0/0 half-two=0/0
  fault: python3 ../data/fs124/e2/saves_read.py hex7 --brief

control: saves-lone
  of: C124-LONE-EXISTS — the reader on fragment S1: one sector member and one bowtie member, one pair, both common unit points inside, no boundary of either member on the point's circle, the bowtie alone separating ("x-(bs)": the first member, a bowtie, separates; the second, a sector, does not). The fault moves the two points by 0.01 (nobody separates)
  run: python3 ../data/fs124/e2/saves_read.py S1 --brief
  expect: S1: members=1s+1b pairs=1 inside=2 patterns=00:2 separating=x-(bs):2 four=0/0 half-two=0/0 arcs-of-kind-both=4 edges-of-saves=0
  fault: python3 ../data/fs124/e2/saves_read.py S1 --brief --fault

control: saves-maps
  of: C124-BOTH — the reader on FS-112's strip and disk and FS-114's capped strip, each read whole from its tiles: at every common unit point inside, the pattern, who separates, the four-label count where each member has one piece of each side, C124-HALF-TWO's hypothesis, and the unit arcs of kind both against the edges of saves. Tight on these models: none has a margin. The fault moves every common unit point by 0.01
  run: python3 ../data/fs124/e2/saves_read.py strip disk capped --brief
  expect: strip: members=40s+0b pairs=54 inside=71 patterns=11:71 separating=xy(ss):71 four=71/71 half-two=71/71 arcs-of-kind-both=38 edges-of-saves=38
    disk: members=25s+0b pairs=20 inside=20 patterns=11:20 separating=xy(ss):20 four=20/20 half-two=20/20 arcs-of-kind-both=20 edges-of-saves=15
    capped: members=40s+0b pairs=54 inside=71 patterns=11:71 separating=xy(ss):71 four=71/71 half-two=71/71 arcs-of-kind-both=38 edges-of-saves=38
  fault: python3 ../data/fs124/e2/saves_read.py strip disk capped --brief --fault

control: second-count
  of: C124-SECOND — the 36 label patterns with different saving edges at the two points: labels in common, disjoint absent pairs, one alternating hexagon; the fault allows the same edge of x at both points (then three labels can be common)
  run: python3 ../data/fs124/e2/edge_check.py second
  expect: cases=36 labels-in-common=[2] absent-pairs-disjoint=36 one-alternating-hexagon=36 second: OK
  fault: python3 ../data/fs124/e2/edge_check.py second --fault

## 4 The strip's top edge

*Head: C124-EDGE-CLOSED — the first exclusion in this milestone of every weak six-colouring of a named open set.*

derivation: C124-EDGE-CLOSED
  statement: There is no weak six-colouring of an open set that contains the point w = (1/4, √15/4 + √3/2), the three arches U_{−1}, U_0, U_1 of FS-112's strip and the parts of its tiles T_0, T_1, T_2 below the line y = √15/4, and that gives almost every point of each of these six sets the strip's label.
  uses only: C124-TYPE six times, with the members (1/2, √3/2) for U_0, U_1 and the part of T_1, (−1/4, √15/4) for U_{−1} and the part of T_0, (3/4, √15/4) for the part of T_2; exact comparisons in ℚ(√3, √15) (control `edge-exact`); that the six labels are distinct and are all the labels
  not claimed: anything about colourings that change the strip below y = √15/4; anything at seven (a seventh label takes the point); the same at the points (1/4 + k/2, √15/4 + √3/2) except through the strip's translation by 1/2, which permutes its labels (not checked against the label tables by this job beyond k = 0); that no six-coloured object extends above the strip's top edge
  argument: FS124-E2-derivation.md § Argument — the strip's top edge
  verdict: derived
  grade: hand
  minds: 1
  model: the strip itself, which stops at w: its own tiles carry no label into the open set near w in the directions between arcsin(1/4) and 30° above the top edge (row 136's colourless cone is (arcsin ¼, 180° − arcsin ¼))
  prior art: partly: for extensions of the strip as a map that keep all its tiles it is FS112-EDGE ("no valid extension of the strip holds a neighbourhood of Q", `tools/fs114_y_dial.py`'s header; row 136); for every weak measurable six-colouring that keeps only the part below y = √15/4, here — not found in print
  handoff: de Bruijn — only with a consumer: six instances of C124-TYPE with explicit points; it is the first exclusion in this milestone of every weak six-colouring of a named open set by first-order tools

**Class**: one held family — FS-112's strip at its own colouring: six named pieces kept, one named point contained; nothing
assumed above the line `y = √15/4`. **Count**: six ("a seventh label takes the point"). **It uses C124-TYPE six times and exact
comparisons, and no entry of § 3.** A dated correction stands under the entry in its record: its *prior art* line misses the
held map statement about the same six tiles, FS114-Y-STRIPK6 (row 138). Nothing rests on it. No kernel job ("only with a
consumer").

derivation: C124-EDGE
  statement: On FS-112's strip, let w be a point of the top edge y = √15/4 + √3/2 that is a common unit point of a close complementary pair of the strip's three-piece points. Then the member of the pair on the line y = √3/2 has no edge free for the unit circle about w: its three edges lie on the unit circles about two midline vertices and on a vertical wall. Hence a weak six-colouring of a neighbourhood of the closed strip that agrees with the strip on |y| ≤ √15/4 saves no such w by both members.
  uses only: the strip's tiles (`tools/fs112_yb2_objects.py`): the vertex (m/2, √3/2) has the edges x = m/2 below it and the arcs of the unit circles about ((m − 1)/2, 0) and ((m + 1)/2, 0) above it; that two tiles of the top half sharing an arch label or a top label rule out every pair but a vertex on y = √3/2 with a vertex on y = √15/4; that a segment lies on no circle and w is no midline vertex
  not claimed: anything beyond the strip's family; that the top edge is open to a save by the other member — it is not (C124-EDGE-CLOSED); the bottom edge except by the mirror, which this job did not check against the strip's labels
  argument: FS124-E2-derivation.md § Argument — the strip's top edge
  verdict: derived
  grade: hand
  minds: 1
  model: w = (1/4, √15/4 + √3/2) with the pairs (1/2, √3/2), (−1/4, √15/4) and (0, √3/2), (3/4, √15/4) — the card's smallest form (control `edge-exact`: w is at distance 1 from all four)
  prior art: known: row 136's stop ("each stops at the unsaved second common unit point of a close complementary pair saved at its first", FS112-STOP, FS112-EDGE) says it for the strip as a map; the asking lane computed the member's edges by hand (`plans/POROS-2026-10-07-fs124-round1.md` § 1.3)
  handoff: none — a computation on one held object; subsumed by C124-EDGE-CLOSED

*Corollary: the claim as posed; subsumed by C124-EDGE-CLOSED* (its own `handoff:` line). **Class**: one held family. **Count**: six.

control: edge-exact
  of: C124-EDGE-CLOSED — exact, in sympy: w at distance 1 from the four members; the circles about the midline vertices meeting S(w) at the members; the sides of the six kept pieces at named points; the direction (12, 5)/13; the six labels read from the strip's own tiles. The fault reads the point w + (1/50, 0)
  run: python3 ../data/fs124/e2/edge_check.py edge
  expect: w-at-distance-1-from-V1,V0,A-1,A1=True circles-meet-S(w)-at-the-members=True T1-part-inner=[-1, -1, -1] T0-part-inner=[-1, -1, -1] T2-part-has-a-point-outside=True arches-crossing=[True, True, True] direction-(12,5)/13:outside-S(V1),outside-S(A-1),inside-S(A1)=True labels-T0,T1,T2,U-1,U0,U1=ROMBPG edge: OK
  fault: python3 ../data/fs124/e2/edge_check.py edge --fault

## 5 At a centre, from the first round: a count, and the rhombus's first half

*Two chains of the first round that the second round did not continue. C124-SIX's class has no held member at any number of
labels; C124-HALF's has one, with a one-point set on the circle.*

derivation: C124-SIX
  statement: Let k ≥ 4, U an open set containing the closed unit disc about q, c a weak k-colouring of U, ψ an angle, z_j = q + e(ψ + jπ/3) for j = 0, …, 5, and a, b, a′, b′ four distinct labels such that for j = 0, 2, 4 the pair (q, z_j) is tight for (a, b) or for (b, a), and for j = 1, 3, 5 the pair (q, z_j) is tight for (a′, b′) or for (b′, a′). Then a label other than a, b, a′, b′ is present at q.
  uses only: C124-SIX-CONES; that a direction strictly outside a region's tangent cone leaves the region at once or for all small radii; that finitely many labels share a set of positive measure in every ball
  not claimed: that the configuration exists at any k — no held object meets the hypothesis, and none was built; which label the fifth one is, or that five suffice; anything when the six pairs use three or more label pairs (R7's centres: three windows, three disjoint pairs, no orbit of six tight far ends)
  argument: FS124-E1-derivation.md § Argument — three half-planes
  verdict: derived
  grade: derived from: C124-SIX-CONES
  minds: 1
  model: none satisfying every hypothesis is known at any number of labels; the statement may hold of an empty class. What is exhibited is the count (control `six-cones`: four labels cover at most 240° of 360°), and its failure when the far ends are 90° apart (the fault: 360°)
  prior art: partly: as C124-SIX-CONES; the statement is the asking lane's hunch `four-labels-cannot-centre-six-tight-pairs`
  handoff: de Bruijn — after C124-CENTRE: three linear inequalities per label and a positive-measure cone; read the formal statement back against "present at q"

**Class**: every weak `k`-colouring, `k ≥ 4`; a centre whose six far ends in one 60° orbit are tight for two disjoint label
pairs. **Count**: `k ≥ 4` — **it does not spend six** (the statement; the asking lane's finding, inventory item 12 (a)). **No
object meets its hypothesis at any number of labels** (its *model* line): it may hold of an empty class. **Kernel**: none planned.

derivation: C124-SIX-CONES
  statement: In the setting of C124-SIX, there is η > 0 such that almost every point of B(q, η) with a label among a, b, a′, b′ lies in a closed set that is the union of at most four regions, each bounded near q by two unit circles through q meeting at the angle π/3, or reduced to {q}.
  uses only: C124-CENTRE at the six pairs; that three unit vectors 120° apart sum to 0, and that every direction is within 60° of one of them
  not claimed: that any of the four labels is present at q; that the four regions are disjoint beyond q; anything for far ends that are not 120° apart
  argument: FS124-E1-derivation.md § Argument — three half-planes
  verdict: derived
  grade: derived from: C124-CENTRE
  minds: 1
  model: the count itself, as a pattern: over the eight sign patterns of three tight pairs 120° apart the inside label's region has angle 0° at q when the three agree and 60° when they do not (control `six-cones`); no colouring meeting C124-SIX's hypothesis is held at any number of labels
  prior art: partly: the asking lane's count (`tools/fs124_p1_cones.py`; `plans/POROS-2026-10-07-fs124-question.md` § 1.3), there with the step from discs to directions asserted; in the map class the cone calculus of FS-116 (G91); not searched in print — owed
  handoff: none — subsumed by C124-SIX, which crosses

*The relay under C124-SIX; subsumed by it.* **Count**: every.

derivation: C124-HALF
  statement: In the setting of C132-COMP-SHARP (plans/FS132-derivation.md § 4), suppose exactly one of the six sets, K_0, a set of x with labels t_0, t_1, is contained in the unit circle about the common unit point w, and at least two of the three sets of y have a point strictly inside the unit circle about w. Then, after exchanging the names t_0, t_1 if need be, there is η > 0 such that almost every point of B(w, η) outside the unit circle about y has the label t_1 if it lies inside the unit circle about x and the label t_0 if it lies outside it.
  uses only: C132-WIT-SIDE (`plans/FS132-derivation.md` § 2; [hand], one mind, inherited — statement read, argument not) at w for x's sets K_1, K_2 and for two sets of y; that two edges of a triangle carry its three labels; that the unit circles about x and y cross at w (0 < |x − y| < 2), so each of the four quadrants at w is a non-empty open set; that six labels are all the labels
  not claimed: that a label of y is present at w; anything inside the unit circle about y; that the class is inhabited at six (no held object meets the hypothesis); that (x, w) is a tight pair — it is tight on one side of the unit circle about y only
  argument: FS124-E1-derivation.md § Argument — the half
  verdict: derived
  grade: hand
  minds: 1
  model: none is known: in fragment T2 three of the six sets lie on that circle and in the Searcher's kept model two (the card's reading, `plans/STUB-q-ring.md` § The first claims; not re-read by me). What is exhibited is the count: of the nine side patterns of K_1 and K_2 two leave a label in both quadrants outside S(y), with one label each (control `half-sides`)
  prior art: partly: in the map class row 135's rhombus lemma (FS112-N3-COR3); in measure it is C132-CROSS's count run with one set on the circle, posed as C132-ARC and by the asking lane; not searched in print — owed
  handoff: de Bruijn — after C132-WIT-SIDE's module: a case split on the sides of two sets

*The rhombus's first half, from exclusion sets.* **Class**: the setting of C132-COMP-SHARP — two points with witnessed triangles
on disjoint triples of six labels — with exactly one of the six sets on the unit circle about the common unit point. **Count**:
six. [hand] **over the inherited C132-WIT-SIDE** (FS-132; one mind; its statement read by this entry's deriver, its argument
not). **Its class is inhabited**, against its own *model* and *not claimed* lines: fragment S1 meets the hypothesis with the
one-point set `{x}` on the circle, and the conclusion there carries no arc (C124-LONE-EXISTS; a dated correction stands under the
entry in its record).

derivation: C124-HALF-TWO
  statement: In the setting of C132-COMP-SHARP, if exactly K_0 and one set K′_0 of y, with labels t′_0, t′_1, are contained in the unit circle about w, x's two other sets have points strictly on opposite sides of that circle, and y's two other sets have points strictly on opposite sides of that circle, then almost every point near w has one of the four labels t_0, t_1, t′_0, t′_1.
  uses only: C132-WIT-SIDE at w for the four other sets; that six labels are all the labels
  not claimed: which of the four labels lies in which quadrant beyond C124-HALF's reading on each side; that any of the four is present at w; that K_0 and K′_0 are tight arcs
  argument: FS124-E1-derivation.md § Argument — the half
  verdict: derived
  grade: hand
  minds: 1
  model: the card names the Searcher's kept model at w = y_1 (labels 1234, the two third labels absent; control `kept-model` of `plans/FS132-derivation.md` § 2 prints those labels); its opposite-sides hypothesis was not read off the model by me — owed
  prior art: partly: as C124-HALF
  handoff: none — subsumed by C124-HALF's module (the same case split)

*Its two-set companion.* **Class**, **count**: as C124-HALF, with one set of each point on the circle. Its hypothesis was read on
held objects by the second round ([tools]): met at all 71, 20 and 71 common unit points inside the strip, the disk and the capped
strip, and at the 3 points of the kept model that the reader counts (§ 7's table: "3 of 3"). It is the upper bound of C124-FOUR.
Its own *model* line names a debt — the opposite-sides hypothesis at the card's point `w = y_1` "not read off the model by me";
whether that point is one of the reader's three was not read by the record job, so the debt stands.

control: six-cones
  of: C124-SIX-CONES — the angle at q of the region left to the inside label by three tight pairs 120° apart, over the eight sign patterns, read on the true regions at radius 10⁻⁴; the fault puts the far ends 90° apart
  run: python3 ../data/fs124/e1/tight_checks.py cones
  expect: angle-between-far-ends=120 equal-signs=[0, 0] mixed-signs-widths=[60] most-covered-by-two-pairs=240 of 360
  fault: python3 ../data/fs124/e1/tight_checks.py cones --fault

control: half-sides
  of: C124-HALF — the nine side patterns of x's two other sets (strictly inside, strictly outside, both) against the labels left on the two quadrants outside S(y); the fault leaves one label of y there (only one of y's sets with a point strictly inside S(w))
  run: python3 ../data/fs124/e1/tight_checks.py half
  expect: side-patterns=9 consistent=2 K1=in,K2=out:inside-x=t1;outside-x=t0 K1=out,K2=in:inside-x=t0;outside-x=t1
  fault: python3 ../data/fs124/e1/tight_checks.py half --fault

## 6 Calibrations

*Two colourings by formula at seven labels. Each is a calibration: it shows that a statement of this file marked "six", or a
kind assumed at six, fails or is a hypothesis at seven. Neither says anything at six.*

derivation: C124-KIND
  statement: There is a weak measurable seven-colouring of the plane, by formula, with a tight pair (q, z) for (a, b) at which neither a nor b is present at q.
  uses only: the hexagonal seven-colouring at circumradius 2/5 (hexagon about m(2√3/5, 0) + n(√3/5, 3/5) coloured (m + 3n) mod 7) and the cap K = {(x, y) : x > √3/5, |(x, y) − q| < 1} with q = (√3/5 − 60/61, 0), recoloured 0; the Pythagorean triple (11, 60, 61); comparisons of rationals and of √3, √21 with rationals
  not claimed: anything at six; that a tight pair with neither label present at its centre occurs in any weak six-colouring; that the colouring is saturated or honest; that the margin is what the construction uses — it does not (the same cap on the honeycomb at circumradius 1/2 is a weak seven-colouring too)
  argument: FS124-E1-derivation.md § Argument — the capped honeycomb
  verdict: derived
  grade: hand
  minds: 1
  model: the colouring itself: (q, z) with z = q + (1, 0) is tight for (0, 1); the tight far ends are the open arc of half-angle arcsin(11/61) ≈ 10.39° about z (196 of 3,600 directions at the reader's spread); only the label 6 is read at q, and the labels 2 and 4 at the two completions; of 200,000 sampled unit pairs none is monochromatic (control `kind-cap`)
  prior art: partly: G95's local slack at seven (EXT-OAI2 § 4.3, islands and stripes in the hexagonal seven-colouring) is the neighbouring construction; a unit arc planted in it not found in this project's files or in print — owed beyond the plan's §PA
  handoff: de Bruijn — only with a consumer: a calibration; the formal content is four inequalities and one inclusion

**A calibration, at seven**: a tight pair need not have either label present at its centre. **Class**: one colouring by formula.

derivation: C124-FORCED-SEVEN
  statement: In the hexagonal seven-colouring at circumradius 2/5 there are two vertices less than 2 apart whose label triples are disjoint, with a common unit point interior to a tile of the seventh label; neither vertex separates there and no boundary of the colouring lies on a circle.
  uses only: the colouring (hexagon about m(2√3/5, 0) + n(√3/5, 3/5) coloured (m + 3n) mod 7); exact arithmetic in ℚ(√3, √2); that two of the three 120° sectors at a vertex share a segment, which lies on no circle, against C124-FORCED-PIECES's last clause
  not claimed: anything at six; that a seven-colouring cannot have a separating vertex (C124-KIND's capped honeycomb has unit arcs)
  argument: FS124-E2-derivation.md § Argument — the honeycomb at seven
  verdict: derived
  grade: hand
  minds: 1
  model: x the common vertex of the hexagons (0, 0), (1, 0), (0, 1), labels 0, 1, 3; y the common vertex of (−1, 1), (−2, 2), (−1, 2), labels 2, 4, 5; |x − y|² = 28/25; a common unit point strictly inside the inscribed disc of the hexagon (0, 2), of label 6 (control `seven-exact`); and over a window, 66 such pairs and 132 points, none with a separating member (Stage 3's table)
  prior art: partly: C132-CROSS's control `hex7-crossings` (`plans/FS132-derivation.md` § 4: 342 vertex pairs, "a label outside both triangles always exists"); as the failure of a save at seven, posed by the card
  handoff: none — a calibration; it crosses only if the kernel lane wants the count's sharpness in six stated

**A calibration, at seven**: C124-FORCED-PIECES's count is sharp in six. **Class**: one colouring by formula, exact.

control: kind-cap
  of: C124-KIND — the capped honeycomb at circumradius 2/5 and at 1/2: the four exact comparisons, the tight pair and its window read by formula, the labels at the centre and at the completions, sampled unit pairs; the fault is circumradius 3/5 (tiles of diameter 6/5: not a weak colouring)
  run: python3 ../data/fs124/e1/tight_checks.py kind
  expect: cap:height=1/61,half-chord=11/61(2*asin=20.78deg) ; circumradius=2/5: cap-inside-edge=True enlarged-tile-diameter=4/5 weakly-proper-by-margins=True centre-inside-opposite-tile=True tight-pair=(0, 1) tight-directions=196/3600 labels-at-centre=[6] labels-at-completions=[2, 4] monochromatic-of-200000-unit-pairs=0 ; circumradius=1/2: cap-inside-edge=True enlarged-tile-diameter=1 weakly-proper-by-margins=True centre-inside-opposite-tile=True tight-pair=(0, 1) tight-directions=196/3600 labels-at-centre=[6] labels-at-completions=[2, 4] monochromatic-of-200000-unit-pairs=0
  fault: python3 ../data/fs124/e1/tight_checks.py kind --fault

control: seven-exact
  of: C124-FORCED-SEVEN — exact, in sympy: the two vertices, their triples, their squared distance, and the common unit point strictly inside the inscribed disc of a hexagon of the seventh label; the fault pairs the first vertex only with vertices of its own orientation, whose triples always meet
  run: python3 ../data/fs124/e2/edge_check.py seven
  expect: circumradius=2/5 x=up(0,0) x-labels=[0, 1, 3] y=down(-2,1) y-labels=[2, 4, 5] squared-distance=28/25 common-unit-point-strictly-inside-the-inscribed-disc-of-hexagon=(0, 2) of-label=6 seven: OK
  fault: python3 ../data/fs124/e2/edge_check.py seven --fault

## 7 The reading of the held objects — [tools], one mind; it proves nothing

**C124-READ-SAVES** (`plans/FS124-E2-derivation.md` Stage 3; reader `data/fs124/e2/saves_read.py`; outputs
`data/fs124/e2/out/`). Its grade, in its deriver's words: "[tools], one mind; floats from the objects' exact pieces, boundaries
refined by bisection, 'on the circle' decided at `10⁻⁹` at two radii". **On which objects**: at six labels FS-112's strip (tiles
−4 to 6) and disk, FS-114's capped strip, fragments T2, BB, S1 and MX, FS116-Y2-SIXFRAG, and the Searcher's kept model; at seven,
as controls, R7 and the honeycomb at circumradius 2/5. Its table, quoted (§ 3.1 of that stage):

> | object | members (sector + bowtie) | pairs | common unit points inside | patterns | who separates | exactly four labels | HALF-TWO's hypothesis | unit arcs of kind both / edges of a save |
> |---|---|---|---|---|---|---|---|---|
> | FS-112's strip (tiles −4 … 6) | 40 + 0 | 54 | 71 | (1, 1): 71 | both: 71 | 71 of 71 | 71 of 71 | 38 / 38 |
> | FS-112's disk | 25 + 0 | 20 | 20 | (1, 1): 20 | both: 20 | 20 of 20 | 20 of 20 | 20 / 15 |
> | FS-114's capped strip | 40 + 0 | 54 | 71 | (1, 1): 71 | both: 71 | 71 of 71 | 71 of 71 | 38 / 38 |
> | fragment T2 | 2 + 0 | 1 | 2 | (1, 2), (2, 1) | both: 2 | — | — | 4 / 4 |
> | the bowtie fragment BB | 0 + 2 | 1 | 2 | (0, 0): 2 | both: 2 | 2 of 2 | — | 0 / 0 |
> | fragment S1 | 1 + 1 | 1 | 2 | (0, 0): 2 | **the bowtie alone: 2** | — | — | 4 / 0 |
> | fragment MX | 1 + 1 | 1 | 2 | (0, 2), (2, 1) | both: 2 | 1 of 1 | — | 2 / 2 |
> | FS116-Y2-SIXFRAG | 6 + 0 | **0** | 0 | — | — | — | — | 18 / 0 |
> | the Searcher's kept model | 4 + 0 | 3 | 6 | (1, 1): 3, (1, 2): 1, (2, 1): 2 | both: 6 | 3 of 3 | 3 of 3 | 9 / 9 |
> | R7 (seven labels; control) | 0 | 0 | — | — | — | — | — | — |
> | the honeycomb at 2/5 (seven; control) | 66 + 0 | 66 | 132 | (0, 0): 132 | nobody: 132 | — | — | — |

**What it says, in its deriver's words** (§ 3.2 of that stage):

> **On the three maps the statement holds, read whole**: at every common unit point inside the strip, the disk and the capped strip
> (71, 20, 71) the pattern is (1, 1), C124-HALF-TWO's hypothesis holds, and the labels present are exactly the four labels of the two
> edges.

> So a save is one cause of a tight arc of kind both and not the only one; "exactly one edge of each member" is the law of the two
> printed maps and of the capped strip — objects built by one recipe — and of nothing else held.

Between those two sentences the stage lists what breaks the statement elsewhere: patterns other than (1, 1) on T2, MX, the kept
model, BB and S1; a point saved with no edge on its circle (BB); a point saved by one member alone (S1, by the bowtie); and tight
arcs of kind both that are no edge of a save (SIXFRAG 18 of 18, S1 4 of 4, the disk 5 of 20). Its controls are entered in § 3
(`saves-fragments`, `saves-r7`, `saves-lone`, `saves-maps`) and § 6 (`seven-exact`).

*Dated 2026-10-07, filed by FS-136's record job (FS136-Z1; sources: `plans/FS136-E1-derivation.md` § 6.3 item 5; FS-136
inventory item 6, ruling (b); this job's comparison, `data/fs136/z1/saves_compare.py`, output `saves_compare.out`; the
section above is left standing).* **A suspected defect of this reading's reader was examined: no count moves.** The
reader (`data/fs124/e2/saves_read.py`) rounds every vertex to nine decimals and tests "an edge lies on the circle" at
`10⁻⁹`; the same rounding, in a copy of it made by FS-136's first deriver, produced 2,296 false violations on the disk
(in that copy's own side test, repaired there before any count was kept). Re-run beside a copy with vertices kept at
full precision (`data/fs136/z1/saves_read_repaired.py`; the original is left as it is) on all eleven objects of the table
above — the strip, the disk, the capped strip, T2, BB, S1, MX, FS116-Y2-SIXFRAG, the kept model, R7 and the honeycomb at
2/5 — **the copy's line equals the original's on 11 of 11**. So every count of the table above stands, and so does every
count ledger row 163 quotes from it: 71, 20 and 71 common unit points of pattern (1, 1) with exactly four labels on the
strip, the disk and the capped strip; two edges of one member on T2, MX and the kept model; none on BB; the bowtie alone
on S1; eighteen arcs of kind both and no close complementary pair on FS116-Y2-SIXFRAG. *Controls of the comparison*: with
the repair switched off the copy reproduces the original on 11 of 11; with vertices rounded to six decimals in place of
nine the lines move (the disk reads pattern (0, 0) at all 20 points and no edge of a save; the kept model's patterns
change: `saves_digits6.out`), so the comparison can see a rounding effect; the copy's planted fault changes its line on
the 8 objects that have a common unit point to move and a pattern or a separation to lose. The rounding stays a defect of
the reader for any later use at a tighter tolerance; it is reported for the tooling job, and the reader is not edited.
**The grade of this section is unchanged: [tools], one mind; it proves nothing.**

## 8 What this file does not hold

From the entries' own *not claimed* lines, and the asking lane's list (`plans/POROS-2026-10-07-fs124-round2.md` § 2.2):

1. That any weak six-colouring has a piece — one connected open set almost all of one label; or a three-piece point; or a close
   complementary pair. Every entry of § 3 begins from them.
2. Anything at a point of five or six labels, or for a member with four: no entry has such a member.
3. That a save is the only cause of a tight arc of kind both (the reading: FS116-Y2-SIXFRAG has eighteen and no pair).
4. Whether a three-tile vertex of an arc map with a cusp is a sector point in § 3's sense (the second deriver's open question).
5. A second mind on any entry; the one asked for by a deriver is on C124-LONE's Step II.
6. A value of χ(ℝ²), an explicit radius, or an exclusion beyond one held family (§ 4).
