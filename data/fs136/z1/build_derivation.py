#!/usr/bin/env python3
"""FS136-Z1: build plans/FS136-derivation.md from the two derivers' records.

Every `derivation:` and `control:` block but two is copied character for character from
plans/FS136-E1-derivation.md (R1) or plans/FS136-E2-derivation.md (R2); the one change is that an
`argument: § <heading>` or `converse: § <heading>` address gains its record's file name, so that it resolves
from the new file. The two blocks that are not copies are the record job's own and are marked OWN below:
the entry C136-STOP-BOWTIE-SIX (the six-tile form the first deriver wrote as a dated note and left to the
record job) and its control. The prose between the blocks is this job's (it proves nothing).
The script fails if a block named here is missing, or if a block of either record is not placed.

    python3 data/fs136/z1/build_derivation.py            # writes plans/FS136-derivation.md
    python3 data/fs136/z1/build_derivation.py --check    # exit 1 if the file on disk differs
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[3]
SRC = {"R1": "FS136-E1-derivation.md", "R2": "FS136-E2-derivation.md"}
OUT = ROOT / "plans/FS136-derivation.md"


def blocks(tag):
    out, cur, name = {}, None, None
    for line in (ROOT / "plans" / SRC[tag]).read_text().splitlines():
        m = re.match(r"^(derivation|control): (\S+)\s*$", line)
        if m:
            name, cur = (m.group(1), m.group(2)), [line]
            continue
        if cur is not None:
            if line.strip() == "":
                out[name] = cur
                cur = None
            else:
                for key in ("argument", "converse"):
                    if line.startswith(f"  {key}: § "):
                        line = f"  {key}: " + SRC[tag] + " " + line[len(f"  {key}: "):]
                cur.append(line)
    if cur is not None:
        out[name] = cur
    return out


B = {t: blocks(t) for t in SRC}
used = set()


def D(tag, name):
    used.add((tag, "derivation", name))
    return "\n".join(B[tag][("derivation", name)]) + "\n"


def C(tag, name):
    used.add((tag, "control", name))
    return "\n".join(B[tag][("control", name)]) + "\n"


def reading_table():
    lines = (ROOT / "plans" / SRC["R1"]).read_text().splitlines()
    i = next(k for k, l in enumerate(lines) if l.startswith("| object | labels | members"))
    j = i
    while lines[j].startswith("|"):
        j += 1
    return "\n".join("> " + l for l in lines[i:j]) + "\n"


P = []
add = P.append

add("""# FS-136 — the point across: covering pairs, the table, and what a seed forces: the derivation file

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

""")
add(D("R1", "C136-TABLE"))
add("""
**Class**: every weak `k`-colouring of an open set; finitely many points one unit from `w`, each with finitely many pieces.
**Count**: none read ("Not consumed: the number of labels", its *uses only* line). **What it does not claim**, first: "that
a weak colouring has a piece"; and "a converse — a label left at every cell does not give a colouring". **What is new**, in
its deriver's words: "for maps nothing (FS110-N-SEAM (b)); in measure, beyond C124-FORCED-PIECES: any number of members,
pieces and labels, labels repeated at a member, and the conclusion on labels." **What rests on it**: C136-COVER, C136-ONE,
C136-FORCED (§ 2, its forward half), the five whole-tile exclusions and the flower's germ form (§ 4). **Kernel**: its
one-member form is `ae_onSide_of_label`, kernel-checked on a branch in FS-124's second module, not through the gate; the
statement over finitely many members is for this milestone's own module, whose planner was launched, blind, while this file
was being filed (FS136-K1; FS-136 inventory item 16).

""")
add(D("R1", "C136-COVER"))
add("""
*Corollary of C136-TABLE at two members.* **Class**: weak colourings whose labels are all carried by the two families.
**Count**: all the labels (stated at six; "where 'six' is read, … it is read as 'all the labels'"). **The posed form is its
case with a weaker conclusion**: the card's "has an inner and an outer piece" is met by one one-label region cut in two
along the unit circle, so the claim was restated on labels before it was derived (the claim list's dated line of 16:06 UTC);
C124-FORCED-PIECES (FS-124) is its case for two disjoint triples of three pieces. **One route with the kernel planner's
`exists_inner_outer_of_cover`** (its G5, which concludes on pieces): "My route is the kernel planner's …; it is not a second
derivation." **What it does not claim**, first: "that separation suffices for w to be coloured — on FS116-Y2-SIXFRAG and
FS114-Y2-BOWTIE a member separates at a point across and a cell is empty". **Kernel**: none; the label form is a statement
for this milestone's module — to read back against "a label all of whose pieces", its `handoff:` line.

""")
add(D("R1", "C136-ONE"))
add("""
*Corollary of C136-TABLE at one member.* **Class**: weak colourings with a point whose family carries all the labels.
**Count**: all the labels (stated at six). **Verdict on the claim as posed**, its deriver's: "derived, in the label form
(the posed 'has the label of a piece of `p` inner at `w`' is weaker where two pieces of `p` share a label)". For maps it is
FS116-N2-SIXRING without the map and the non-Siamese clause, "at that price: the conclusion is about labels on the two
sides of the ring, not about which tile lies there". C136-COLLAR (§ 2) is the neighbouring statement for a point that lacks
one label. **Kernel**: none.

""")
add(C("R1", "rings-r7"))
add("\n")
add(C("R1", "cover-count"))
add("""
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

""")
add(D("R2", "C136-CORNERS"))
add("""
*A lemma.* **Class**: plane geometry; no colouring. It is why "the cell" of the card is one connected corner — or two, the
horns outside two unit circles tangent at the point. **What rests on it**: C136-FORCED ("connected, with w in its
closure"), every table of §§ 3–4. **Kernel**: none; "this lemma crosses only with a consumer of 'is a piece'".

""")
add(D("R2", "C136-CLASS"))
add("""
*A lemma.* **Class**: plane geometry; corners bounded by rays and circular arcs. A corner's class at a point one unit away
is decided by direction and then by signed curvature — "it is what makes a table a finite exact computation". **What rests
on it**: every class read in §§ 3–4 and C136-COLLAR's hypothesis. The gate's one warning on this file's source is here: the
statement is two-way and its control (`corners-selftest`) is read as one direction; its eleven corners include both.

""")
add(D("R2", "C136-FORCED"))
add("""
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

""")
add(D("R2", "C136-CLOSE"))
add("""
*Derived from C136-FORCED, step by step.* **Class**: every weak `k`-colouring of an open set and every set of labelled
corners it has. **Count**: none read. **What a seed forces**, its deriver's words: "a countable family of corners at
isolated points — each had at some radius, none of a size any statement bounds — unless a point carrying at least `k − 1`
labels forces along an arc." **What it does not claim**, beside the line quoted at the head of this section: "a converse —
a seed whose closure empties no corner need not be had by any colouring"; "the bars of extent — a whole tile can be
crossing where its corner is inner, and those bars are not in the closure of the corners"; "that the closure of a finite
seed is finite". **What rests on it**: the three computed closures (§ 3), C136-STOP-GERMS (§ 4). **Kernel**: none without a
consumer.

""")
add(D("R2", "C136-COLLAR"))
add("""
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

""")
add(C("R2", "corners-selftest"))
add("\n")
add(C("R2", "forced-r7-window"))
add("\n")
add(C("R2", "forced-arc"))
add("""
*`forced-r7-window` is a **calibration at seven**, exact: on R7 "a label R7 has there" is never barred, and at every one of
432 corners the labels left are R7's. `forced-arc` prints a closure of the bowtie fragment's seed that "is a lower bound
(collars are not propagated)"; that closure is no entry.*

## 3 Three closures, computed — instances of C136-CLOSE on named corners

*Each is the forced closure of named labelled corners of one object, computed by `data/fs136/e2/closure.py` with every
class an exact sign in the object's own number field, forced steps only: no branch is taken. Their grade is **computed
over** the set their `grade:` lines name. **Every closure stalls; none empties a corner beyond its seed pair's own common
unit points; none forces a label along an arc.** A stall is a list of free corners — choices, the search lane's (queue
lines 17–20). None is a statement about any colouring but those that have the seed's corners.*

""")
add(D("R2", "C136-CLOSE-R7"))
add("""
***Calibration at seven.*** **Class**: one seed — the twelve corners of R7 at two adjacent lattice points. **What it
shows**: no corner is emptied at any step (the survival control), and the closure is fifteen corners and stalls. **It
corrects the stub's table row** "tightness at seven is rigid from two points", in its deriver's words: "with both members
full the table is *exact* at every corner … and it stalls all the same, because R7 has two or three labels in those corners
and a forced corner carries one label, too few to bar anything one unit further on." Registered before it was run, not
blind ("worked by hand before the script was written").

""")
add(D("R2", "C136-CLOSE-FLOWER"))
add("""
**Class**: one seed — seven corners of the flower at `e(180°)` and `e(270°)`. Six corners forced at two points inside the
fragment's disc, each the fragment's colour; two steps; a stall. "**A unit arc is forced, not designed**: at `(−1, −1)` the
labels `0` and `1` meet along the unit circle about `e(270°)`" — C136-FORCED's second sentence, on a held object. Free
corners: 18 at 5 points in the disc, 40 at 11 in the plane.

""")
add(D("R2", "C136-CLOSE-STRIP"))
add("""
**Class**: two seeds of the strip — (c1) eight corners at two four-label points half a unit apart; (c2) the six corners of
the first round's pair of three-label points. **Two readings inside it are floats**, by its *uses only* line: which of the
two corners between a tile's two curves is the tile's ("the object's own float point-location (five samples)"), and "in
the strip". **It corrects the card's third seed**, which "names no object of the strip". (c1) forces ten corners at six
points in two steps and stalls; (c2) forces nothing in the strip, and "their only product is the exclusion at the point
across". Free corners: (c1) 106 at 26 points; (c2) 4 at 1 point.

""")
add(C("R2", "close-r7"))
add("\n")
add(C("R2", "close-flower"))
add("\n")
add(C("R2", "close-strip"))
add("""
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

""")
add(D("R2", "C136-STOP-GERMS"))
add("""
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

""")
add(D("R2", "C136-STOP-GERMS-RADIUS"))
add("""
*A quantitative rider to C136-STOP-GERMS.* **Class**: the same three families. **Restated by its deriver** against the
card and against its own first fixing ("in (c) the same within `c·r²`"): "derived, and **restated, because it says less
than the argument carries** — the bowtie fragment's case is first order like the other two …, and the conclusion is put as
a statement about the colouring's domain". **What it does not claim**: "a law for the flower's far vertex, where one label
is barred only at second order and the first round's r² stands". Nothing rests on it.

""")
add(D("R1", "C136-STOP-STRIP"))
add("""
*Corollary of C136-STOP-GERMS (a); the first round's whole-tile form, derived there from C136-TABLE.* **Class**: one held
family — six whole tiles of the strip. **Count**: six. **Against C124-EDGE-CLOSED** (FS-124, ledger row 164), its *not
claimed* line: that entry "keeps three arches and the parts of T_0, T_1, T_2 below the line y = √15/4, uses three members
and does not keep T_{−1}; this one keeps six whole tiles at two members" — neither contains the other. For maps the same
six tiles are FS114-Y-STRIPK6's, "there under every colouring, here at the strip's own".

""")
add(D("R1", "C136-STOP-DISK"))
add("""
*Corollary of C136-STOP-GERMS (b).* **Class**: one held family — six whole tiles of the disk at two three-label vertices.
**Count**: six. What is new beyond the held entries, its deriver's words: "the
class of colourings; in method nothing — it is the count (class L0), C124-FORCED-PIECES's contrapositive on whole tiles." Its *not
claimed* line leaves "the nine other rim points at that distance and the ten at 1.764" to the disk's symmetry, "read in
floats …; not checked exactly".

""")
add(D("R1", "C136-STOP-BOWTIE"))
add("""
*Corollary of C136-STOP-GERMS (c), and of C136-STOP-BOWTIE-SIX below.* **Class**: one held family — eight whole tiles.
**Count**: six. Two dated notes stand under it in R1 (the control's ten kept tiles are eight distinct; six suffice for one
cell). **Which cell**: this entry's witnesses empty "the cell inside the unit circle about q₂ and outside that about q₁,
and … its mirror cell" — true of whole tiles; the second round found that the two vertex figures alone empty a third, the
corner outside both circles, which "that entry's finite list of witnesses did not reach. Nothing in that entry is wrong;
its statement stands" (R2, under C136-STOP-GERMS). With whole tiles all three are empty.

""")
add("""derivation: C136-STOP-BOWTIE-SIX
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

""")
add("""***The record job's entry**, not a copy: the statement is the one the first deriver's dated note names ("its `statement:`
would name `L2, T2, V′, t1, T1, W`"), and the claim list's line of 17:13 UTC leaves it to this job ("a restated entry is the
record job's to write"). Its argument is the first round's, with the note's witnesses: inside `S(q₂)` the labels `6, 2, 5, 1`
are barred by `L2, T2, V′, t1`, outside `S(q₁)` the labels `4, 3` by `T1, W`. **Its one mind is the first deriver's**; the
record job read the six witness lines from the exact check's output and wrote the control below, which is a reading of
another job's exact check and no second derivation.* **Class**: one held family — six whole tiles. **Count**: six. **It is
not a corollary of C136-STOP-GERMS (c)**, and that entry is not a corollary of it.

""")
add("""control: bowtie-six
  of: C136-STOP-BOWTIE-SIX — the record job's reading of the first round's exact check on the bowtie fragment (run as it is), keeping only the six lines the statement names: L2, T2, V′, t1 at q₂ (each must have a witness strictly outside the unit circle about (√3, 0)) and T1, W at q₁ (each strictly inside); the six labels distinct; all six barred in the cell inside S(q₂) and outside S(q₁). The fault moves the point by (1/50, 0): step 1 of the exact check fails and nothing is read
  run: python3 ../data/fs136/z1/bowtie_six.py
  expect: bowtie-six: kept=L2@q2,T2@q2,V'@q2,t1@q2,T1@q1,W@q1 step1=True lines-read=6 of 6 labels=6 barred-in-the-cell(in S(q2), out S(q1))=6 left=[] EXCLUDED
  fault: python3 ../data/fs136/z1/bowtie_six.py --fault

""")
add(D("R1", "C136-STOP-FLOWER-GERMS"))
add("""
*The head at the flower.* **Class**: one held family — the germs of six tiles at two ring points, every `0 < r ≤ 1/4`.
**Count**: six. **The answer to the stub's question** whether "the first-order lemma reaches the flower's far vertex", its
deriver's: "The lemma reaches it, and it is not a first-order lemma. C124-TYPE reads a point of the piece strictly off the
unit circle; it reads no cone … what second order costs is the size of the ball on which the conclusion holds (`≈ r²`),
never the conclusion." The second round's engine reads this stop as its positive for "order 2" (control `stop-corners`).

""")
add(D("R1", "C136-STOP-FLOWER"))
add("""
*Corollary of C136-STOP-FLOWER-GERMS at `r = 1/4`* ("r = 1/4 gives parts of the fragment's own tiles", that entry's *model*
line). **Class**: one held family — six whole tiles. **Count**: six. A dated note stands under it in R1: the check keeps
seven distinct tiles, and "the statement's six are the ones the empty cell uses". For maps it is FS116-Y2-SIXOFF (one
mind), "narrower in one way — one pattern, the fragment's own".

""")
add(C("R2", "stop-corners"))
add("\n")
add(C("R2", "stop-shadow"))
add("\n")
add(C("R1", "stop-exact"))
add("""
*`stop-exact` is exact in each object's own tower; a defect of it is reported by the second deriver and moves no verdict:
it "proves bars from a finite list of boundary points and misses the corner outside both circles at the bowtie fragment's
stop" (FS-136 inventory item 14) — it under-reads, so what it prints empty is empty. `stop-shadow` is floats, on another
code path.*

## 5 The bound on partners

""")
add(D("R1", "C136-PARTNERS"))
add("""
**Class**: sector points (three pieces, three labels, three arcs). **Count**: six, through C124-BOTH. **Its grade, said
whole**, in its deriver's words: "[hand] over C124-BOTH, which is derived from C124-LONE — one mind, kernel pending, the
step its deriver flagged now looked at a second time by the kernel planner (blind first; 'stands as written', two
corrections filed) and not by me." **And in the kernel** (`plans/FS124-close-inventory.md` items 41–42): the clause it
rests on — C124-BOTH's second sentence — is, in the implementer's words, "TRUE for arc-edged decompositions [kernel, on a
branch]; GAP for the list's sector points at one named step" (the θ-curve leaf), and nothing of it is through the gate; so
for sector points as this entry states them the kernel does not yet hold its input. **What is new**: "nothing but the class" — FS112-C-PARTNERS's two lines
under a dictionary. **What it does not claim**, first: "anything for a member of four or more labels … — C124-BOTH is not
held there, and on the disk and the flower a four-label member pays alone". Nothing rests on it.

""")
add(C("R1", "partners-held"))
add("""
*`partners-held` reads another job's outputs in floats (the asking lane's reader): a reading, not a proof.*

## 6 The reading of the held objects — [tools]; four points exact

""")
add(D("R1", "C136-RINGS-READ"))
add("""
**What is exact and what is not.** The entry's grade is "computed over: the set of the four points across named in the
statement" — one point on each of the strip, the disk, the flower and the bowtie fragment, each exact in its object's own
number field, and each excluded by an entry of § 4. **Every count around it is [tools], floats, one mind, and is not an
entry** (R1 § 2.2; reader `data/fs136/e1/rings_read.py`; outputs `data/fs136/e1/out/`). **On which objects**: at six labels
FS-112's strip (tiles −4 to 6), FS-114's capped strip, `[Polymath2021]`'s disk, FS116-Y2-SIXFRAG, FS114-Y2-BOWTIE,
fragments T2, S1, MX, BB, and the Searcher's kept model; at seven, as a calibration, R7 (50 tiles). Its table, quoted:

""")
add(reading_table())
add("""
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

""")
add(C("R1", "rings-held"))
add("\n")
add(C("R1", "rings-strip"))
add("\n")
add(C("R1", "rings-small"))
add("""
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
""")

text = "".join(P)
want_d = {(t, k[0], k[1]) for t in B for k in B[t]}
missing = want_d - used
if missing:
    sys.exit(f"blocks of the records not placed: {sorted(missing)}")
if "--check" in sys.argv:
    cur = OUT.read_text() if OUT.exists() else ""
    if cur != text:
        sys.exit("FS136-derivation.md differs from what the script writes")
    print(f"check: FS136-derivation.md is what the script writes ({len(used)} copied blocks, 2 of the record job's)")
else:
    OUT.write_text(text)
    nd = sum(1 for u in used if u[1] == "derivation"); nc = sum(1 for u in used if u[1] == "control")
    print(f"wrote {OUT.relative_to(ROOT)}: {nd} copied entries, {nc} copied controls, 1 entry and 1 control of the record job, {len(text)} bytes")
