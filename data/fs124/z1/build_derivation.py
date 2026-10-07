#!/usr/bin/env python3
"""FS124-Z1: build plans/FS124-derivation.md from the two derivers' records.

Every `derivation:` and `control:` block is copied character for character from
plans/FS124-E1-derivation.md or plans/FS124-E2-derivation.md; the one change is that an
`argument: § <heading>` address gains its record's file name, so that it resolves from the
new file. The prose between the blocks is this job's (PROSE below). The script fails if a
block named in ORDER is missing, or if a block of either record is not placed.

    python3 data/fs124/z1/build_derivation.py            # writes plans/FS124-derivation.md
    python3 data/fs124/z1/build_derivation.py --check    # exit 1 if the file on disk differs
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[3]
SRC = {"E1": "FS124-E1-derivation.md", "E2": "FS124-E2-derivation.md"}
OUT = ROOT / "plans/FS124-derivation.md"


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
                if line.startswith("  argument: § "):
                    line = "  argument: " + SRC[tag] + " " + line[len("  argument: "):]
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
    lines = (ROOT / "plans" / SRC["E2"]).read_text().splitlines()
    i = next(k for k, l in enumerate(lines) if l.startswith("| object | members"))
    j = i
    while lines[j].startswith("|"):
        j += 1
    return "\n".join("> " + l for l in lines[i:j]) + "\n"


P = []
add = P.append

add("""# FS-124 — tight unit pairs: the derivation file

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
of χ(ℝ²).** The kernel lane's state on 2026-10-07: the five entries of § 1's radius clause are a module complete on branch
`fs124-wk1` (57 theorems) — **kernel-checked on a branch, not through the gate, not held**; nine entries (marked "second module")
are being planned blind on branch `fs124-wk2`; the rest have no kernel job. **A second mind is owed on C124-LONE's Step II**, by its
deriver's own line, before what rests on it is built on outside this milestone (§ 3).

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

""")
add(D("E1", "C124-RADIUS-GRAPH"))
add("""
**Class**: every weak `k`-colouring of an open set, every `k ≥ 1`. **Count**: every ("No count of labels", its *uses only* line).
**What rests on it**: C124-RADIUS-COUNTABLE, C124-RADIUS-UP and, through it, C124-RADIUS-FIVE. **Kernel**: first module, complete
on a branch, not held. **The kernel planner's generalizations, its own, recorded and not entered** (inventory item 14; the dated
line of `data/fs124/claims-K1.md`): in this entry, in C124-RADIUS-COUNTABLE and in C124-RADIUS-UP the measurability of the
colouring is idle — what is used is that the monochromatic unit pairs inside the set are a null set, for any function; this
entry's almost-every clause holds pair by pair for a countable set wherever it lies; "the pairs are the motions" is the whole
proof. A dated correction stands under the entry in its record: one clause of the hand argument is used by no later line.

""")
add(D("E1", "C124-RADIUS-COUNTABLE"))
add("""
*Corollary of C124-RADIUS-GRAPH's argument.* **Class**: as above, with a countable set whose closure is compact in the open set.
**Count**: every. **What rests on it**: nothing here; it says where de Bruijn–Erdős enters C124-RADIUS-UP. **Kernel**: first module.

""")
add(D("E1", "C124-RADIUS-UP"))
add("""
*Corollary of C124-RADIUS-GRAPH.* **Class**: weak measurable `k`-colourings of the open discs about the origin, every `k ≥ 1`.
**Count**: every. **What rests on it**: C124-RADIUS-FIVE; with C124-RADIUS-DOWN, the disc criterion. **Kernel**: first module; the
planner's own: discs at any centres, and its contrapositive needs no import (item 14 (5)).

""")
add(D("E1", "C124-RADIUS-DOWN"))
add("""
**Class**: every open set, every `k ≥ 1`; [hand] **over the declared outside theorem** `Outside.OAI158.proper_to_borel_weak`.
**Count**: every. **Kernel**: first module; the planner's own: it holds for every subset of the plane (item 14 (4)). **The disc
criterion** is this entry with C124-RADIUS-UP, said in this entry's `handoff:` line; as single statements it is the kernel
planner's two join theorems, not entries here — `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`
(`7 ≤ χ(ℝ²)` iff some open disc about the origin has no weak measurable six-colouring), each on the standard three axioms and
that one declared outside theorem, **on a branch**. By the planner's record (§ 4.4, on its branch): "*Seven gives such a disc* …
rests on the standard three axioms; *such a disc gives seven* … rests on the declared outside theorem"; "an exclusion on a disc
reaches seven only through the transfer, and weak six-colourings of every disc reach six with no import".

""")
add(D("E1", "C124-RADIUS-FIVE"))
add("""
*Corollary of C124-RADIUS-UP*, over the declared outside theorem `Outside.OAI158.no_proper_five_coloring`. **Class**: open discs
of one radius. **Count**: five — C124-RADIUS-UP read at the one number where the plane's answer is known; the asking lane files it with the
calibrations. No radius is exhibited. **Kernel**: first module.

""")
add(C("E1", "radius-motions"))
add("""
""")
add(D("E2", "C124-EVERY-DIRECTION"))
add("""
**Class**: every measurable weak colouring of a measurable set. **Count**: every. **What rests on it**: nothing in this file ("no
entry below reads a fixed direction"); it answers a question the kernel planner asked while typing the radius clause (item 14
(7)). **Kernel**: not stated in the first module — it waits for a consumer and for a lemma a port from the release brings (the
planner's record § 4.2).

## 2 The one lemma, and what one piece forces

*Head: C124-SHADOW-OPEN — an open set almost all of one label bars that label at almost every point whose unit circle meets it.
Every entry of this section but C124-OPEN is this lemma and a computation with circles.*

""")
add(D("E1", "C124-SHADOW-OPEN"))
add("""
**Class**: every weak colouring of an open set; one open one-label set, not assumed connected. **Count**: every. **What rests on
it**: every other entry of this section but C124-OPEN; through C124-TYPE and C124-CENTRE-HALF, C124-FORCED-PIECES, C124-FORCED,
C124-LONE, C124-BOTH, C124-FOUR, C124-SECOND and C124-EDGE-CLOSED; through C124-CENTRE, § 5's C124-SIX. **Kernel**: second
module (being planned blind).

""")
add(D("E2", "C124-TYPE"))
add("""
*The lemma on one piece and one side.* **Class**: every weak `k`-colouring of an open set; one **connected** open one-label piece
with a point of its closure one unit from `w`. **Count**: every. **By its deriver it is two of last night's entries in one
statement** — C132-WITNESS followed by C132-WIT-SIDE (`plans/FS132-derivation.md` § 2), on C124-SHADOW-OPEN; their statements
were read by that deriver, their arguments not. **What rests on it**: C124-FORCED-PIECES, C124-LONE, C124-FOUR and
C124-EDGE-CLOSED. **Kernel**: second module.

""")
add(D("E2", "C124-CENTRE-HALF"))
add("""
*The centre, collar by collar — the stronger form of C124-CENTRE.* **Class**: every weak `k`-colouring of an open set; one label
filling one side of a unit circle near one end of a unit pair. **Count**: every. **What rests on it**: C124-LONE. **Kernel**:
second module. Its grade is [hand] over the first round's argument, inherited and read whole by its deriver.

""")
add(D("E1", "C124-CENTRE"))
add("""
*Corollary: the conjunction of C124-CENTRE-HALF's two halves* (that entry's `handoff:` line); its grade is its source's, derived
from C124-SHADOW-OPEN. **Class**: every weak `k`-colouring; a tight pair. **Count**: every. **What rests on it**:
C124-SIX-CONES. **Kernel**: second module.

""")
add(D("E1", "C124-STRADDLE"))
add("""
*The wide form at a point one unit from a far end.* **Class**: every weak `k`-colouring; a tight pair and any point one unit from
its far end but two. **Count**: every. **What rests on it**: C124-COMPLETION. **Kernel**: second module.

""")
add(D("E1", "C124-COMPLETION"))
add("""
*Corollary: C124-STRADDLE at a rhombus completion.* **Class**, **count**: as C124-STRADDLE. By its own *not claimed* line the
conclusion is not special to tight pairs. No kernel job of its own.

""")
add(D("E1", "C124-ANTIPODE"))
add("""
**Class**: every weak `k`-colouring; a tight pair whose opposite point lies in the set. **Count**: every. **What rests on it**:
nothing here. Not among the second module's nine statements.

""")
add(D("E1", "C124-OPEN"))
add("""
*A remark on the definition: the tight far ends of a centre form an open arc.* **Count**: every. Nothing rests on it; no kernel job.

""")
for c in ("shadow-geometry", "r7-tight", "maps-tight", "hex-half-none", "maps-ends"):
    add(C("E1", c))
    add("\n")
add("""## 3 The pair: what a close complementary pair forces at a common unit point

*The setting of every entry: a weak **six**-colouring of an open set, two three-piece points less than 2 apart whose label triples
are disjoint, each with a decomposition into three pieces, and a point of the set one unit from both. Head: C124-FORCED-PIECES.
**No entry claims that a weak six-colouring has such points.***

""")
add(D("E2", "C124-FORCED-PIECES"))
add("""
**Class**: three-piece points by the letter. **Count**: six; its failure at seven is C124-FORCED-SEVEN (§ 6). **It is the form
with content of last night's C132-COMP-SHARP**, whose conclusion a one-point set satisfies (a dated correction stands under that
entry in `plans/FS132-derivation.md`). **What rests on it**: C124-FORCED, C124-LONE and through it C124-BOTH, C124-FOUR,
C124-SECOND. **Kernel**: second module. *A reading of its argument by the asking lane, not entered*: it reads "every label is a
label of a piece at one of the two points", not two disjoint triples (inventory item 26); stated at that class it is a first
claim of the successor (`plans/STUB-covering-pairs.md`), not a result of this file.

""")
add(D("E2", "C124-FORCED"))
add("""
*Corollary: the posed claim, for sector points.* **Class**: sector points. **Count**: six. One topological input (the θ-curve form
of the Jordan–Schoenflies theorem) is recalled, not read. **What rests on it**: the second sentence of C124-BOTH, by its
argument; C124-SECOND is stated in its setting.

""")
add(D("E2", "C124-FORCED-AS-POSED"))
add("""
**The refuted wording**: the claim as the card posed it, for every three-piece point by the letter. Its counterexample is in its
`verdict:` line. What stands in its place is C124-FORCED-PIECES (three-piece points, on pieces) and C124-FORCED (sector points,
with an arc). **Class**: three-piece points by the letter. **Count**: six.

""")
add(D("E2", "C124-LONE"))
add("""
*What a save by one member alone forces.* **Class**: three-piece points by the letter, one member not separating. **Count**: six.
**A second mind is owed on its Step II** (`plans/FS124-E2-derivation.md` § Argument — the save by one member), by its deriver's
own line — "before C124-BOTH, C124-FOUR or C124-EDGE-CLOSED is built on outside this milestone"; the kernel planner of the second
module is that mind, blind first. *The record job's reading of the `uses only:` lines*: C124-BOTH, C124-FOUR and C124-SECOND rest
on this entry; C124-EDGE-CLOSED does not. **What rests on it**: those three. **Kernel**: second module.

""")
add(D("E2", "C124-LONE-EXISTS"))
add("""
*Where the save by one member exists.* **Class**: one held family — fragment S1 with one band; "four flowers of radius at most
about 1/4 and one band", fixing no value. **Count**: six. It keeps C124-LONE, and the first round's C124-HALF, from being
statements over empty classes; its saving member is a three-piece point by the letter only.

""")
add(D("E2", "C124-BOTH"))
add("""
*Where the save by one member is excluded.* **Class**: full members (first sentence); sector points (second sentence).
**Count**: six. By its *prior art* line it is the form, for a weak measurable colouring and by another route, of the map class's
FS112-N3-COR3 (row 135; two minds, one blind) — which this entry's one mind does not inherit. **What rests on it**: C124-SECOND.
**Kernel**: second module (the first sentence).

""")
add(D("E2", "C124-FOUR"))
add("""
**Class**: full members, each with exactly one inner, one outer and one crossing piece at the point. **Count**: six. C124-HALF-TWO
(§ 5) is its upper bound from exclusion sets. **What rests on it**: C124-SECOND. **Kernel**: second module.

""")
add(D("E2", "C124-SECOND"))
add("""
*The pair's two saves.* **Class**: sector points, both common unit points in the set, each with pattern (1, 1). **Count**: six.
Nothing rests on it; no statement uses it twice along a chain. No kernel job.

""")
for c in ("quadrant-count", "saves-fragments", "saves-r7", "saves-lone", "saves-maps", "second-count"):
    add(C("E2", c))
    add("\n")
add("""## 4 The strip's top edge

*Head: C124-EDGE-CLOSED — the first exclusion in this milestone of every weak six-colouring of a named open set.*

""")
add(D("E2", "C124-EDGE-CLOSED"))
add("""
**Class**: one held family — FS-112's strip at its own colouring: six named pieces kept, one named point contained; nothing
assumed above the line `y = √15/4`. **Count**: six ("a seventh label takes the point"). **It uses C124-TYPE six times and exact
comparisons, and no entry of § 3.** A dated correction stands under the entry in its record: its *prior art* line misses the
held map statement about the same six tiles, FS114-Y-STRIPK6 (row 138). Nothing rests on it. No kernel job ("only with a
consumer").

""")
add(D("E2", "C124-EDGE"))
add("""
*Corollary: the claim as posed; subsumed by C124-EDGE-CLOSED* (its own `handoff:` line). **Class**: one held family. **Count**: six.

""")
add(C("E2", "edge-exact"))
add("""
## 5 At a centre, from the first round: a count, and the rhombus's first half

*Two chains of the first round that the second round did not continue. C124-SIX's class has no held member at any number of
labels; C124-HALF's has one, with a one-point set on the circle.*

""")
add(D("E1", "C124-SIX"))
add("""
**Class**: every weak `k`-colouring, `k ≥ 4`; a centre whose six far ends in one 60° orbit are tight for two disjoint label
pairs. **Count**: `k ≥ 4` — **it does not spend six** (the statement; the asking lane's finding, inventory item 12 (a)). **No
object meets its hypothesis at any number of labels** (its *model* line): it may hold of an empty class. **Kernel**: none planned.

""")
add(D("E1", "C124-SIX-CONES"))
add("""
*The relay under C124-SIX; subsumed by it.* **Count**: every.

""")
add(D("E1", "C124-HALF"))
add("""
*The rhombus's first half, from exclusion sets.* **Class**: the setting of C132-COMP-SHARP — two points with witnessed triangles
on disjoint triples of six labels — with exactly one of the six sets on the unit circle about the common unit point. **Count**:
six. [hand] **over the inherited C132-WIT-SIDE** (FS-132; one mind; its statement read by this entry's deriver, its argument
not). **Its class is inhabited**, against its own *model* and *not claimed* lines: fragment S1 meets the hypothesis with the
one-point set `{x}` on the circle, and the conclusion there carries no arc (C124-LONE-EXISTS; a dated correction stands under the
entry in its record).

""")
add(D("E1", "C124-HALF-TWO"))
add("""
*Its two-set companion.* **Class**, **count**: as C124-HALF, with one set of each point on the circle. Its hypothesis was read on
held objects by the second round ([tools]): met at all 71, 20 and 71 common unit points inside the strip, the disk and the capped
strip, and at the 3 points of the kept model that the reader counts (§ 7's table: "3 of 3"). It is the upper bound of C124-FOUR.
Its own *model* line names a debt — the opposite-sides hypothesis at the card's point `w = y_1` "not read off the model by me";
whether that point is one of the reader's three was not read by the record job, so the debt stands.

""")
for c in ("six-cones", "half-sides"):
    add(C("E1", c))
    add("\n")
add("""## 6 Calibrations

*Two colourings by formula at seven labels. Each is a calibration: it shows that a statement of this file marked "six", or a
kind assumed at six, fails or is a hypothesis at seven. Neither says anything at six.*

""")
add(D("E1", "C124-KIND"))
add("""
**A calibration, at seven**: a tight pair need not have either label present at its centre. **Class**: one colouring by formula.

""")
add(D("E2", "C124-FORCED-SEVEN"))
add("""
**A calibration, at seven**: C124-FORCED-PIECES's count is sharp in six. **Class**: one colouring by formula, exact.

""")
add(C("E1", "kind-cap"))
add("\n")
add(C("E2", "seven-exact"))
add("""
## 7 The reading of the held objects — [tools], one mind; it proves nothing

**C124-READ-SAVES** (`plans/FS124-E2-derivation.md` Stage 3; reader `data/fs124/e2/saves_read.py`; outputs
`data/fs124/e2/out/`). Its grade, in its deriver's words: "[tools], one mind; floats from the objects' exact pieces, boundaries
refined by bisection, 'on the circle' decided at `10⁻⁹` at two radii". **On which objects**: at six labels FS-112's strip (tiles
−4 to 6) and disk, FS-114's capped strip, fragments T2, BB, S1 and MX, FS116-Y2-SIXFRAG, and the Searcher's kept model; at seven,
as controls, R7 and the honeycomb at circumradius 2/5. Its table, quoted (§ 3.1 of that stage):

""")
add(reading_table())
add("""
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

## 8 What this file does not hold

From the entries' own *not claimed* lines, and the asking lane's list (`plans/POROS-2026-10-07-fs124-round2.md` § 2.2):

1. That any weak six-colouring has a piece — one connected open set almost all of one label; or a three-piece point; or a close
   complementary pair. Every entry of § 3 begins from them.
2. Anything at a point of five or six labels, or for a member with four: no entry has such a member.
3. That a save is the only cause of a tight arc of kind both (the reading: FS116-Y2-SIXFRAG has eighteen and no pair).
4. Whether a three-tile vertex of an arc map with a cusp is a sector point in § 3's sense (the second deriver's open question).
5. A second mind on any entry; the one asked for by a deriver is on C124-LONE's Step II.
6. A value of χ(ℝ²), an explicit radius, or an exclusion beyond one held family (§ 4).
""")

text = "".join(P)
placed = used
allb = {(t, k, n) for t in B for (k, n) in B[t]}
missing = allb - placed
if missing:
    sys.exit("blocks of the records not placed: " + ", ".join(sorted(n for _, _, n in missing)))
if "--check" in sys.argv:
    same = OUT.exists() and OUT.read_text() == text
    print("derivations=%d controls=%d identical=%s" % (
        sum(1 for u in placed if u[1] == "derivation"), sum(1 for u in placed if u[1] == "control"), same))
    sys.exit(0 if same else 1)
OUT.write_text(text)
print("wrote %s: derivations=%d controls=%d bytes=%d" % (
    OUT.relative_to(ROOT), sum(1 for u in placed if u[1] == "derivation"),
    sum(1 for u in placed if u[1] == "control"), len(text.encode())))
