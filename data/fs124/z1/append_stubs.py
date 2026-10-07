#!/usr/bin/env python3
"""FS124-Z1, stage 4: dated bearing blocks in the stubs this milestone moved.

Each block is inserted at the end of a stub's "Provisional bearings" section (before the next
"## " heading, or at the end of the file), or after a named paragraph. Nothing standing is
changed; the script refuses to run twice. --dry prints where each would go.
"""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
HEAD = "(FS124-Z1, the record job, 2026-10-07; every entry named is in `plans/FS124-derivation.md`, [hand] or derived from [hand] entries, **one mind, kernel pending**)"

def end_of_bearings(L):
    i = next(k for k, l in enumerate(L) if l.startswith("## Provisional bearings"))
    j = next((k for k in range(i + 1, len(L)) if L[k].startswith("## ")), len(L))
    while L[j - 1].strip() == "":
        j -= 1
    return j

def after_paragraph_starting(prefix):
    def f(L):
        i = next(k for k, l in enumerate(L) if l.startswith(prefix))
        while L[i].strip():
            i += 1
        return i
    return f

COVER = """*From FS-124's theorem record """ + HEAD + """. None says that a weak
six-colouring has a piece, a three-piece point or a close complementary pair:*

- **The tool every first claim here would use: C124-TYPE** ([hand] over C124-SHADOW-OPEN; § 2) — every weak `k`-colouring of an
  open set, one connected open one-label piece with a point of its closure one unit from `w`; it reads no number of labels. In
  the kernel lane's second module, being planned blind.
- **The count, as an entry, is for three-piece points with disjoint triples: C124-FORCED-PIECES** (derived from C124-TYPE; § 3).
  That its argument reads "every label is a label of a piece at one of the two points" is the asking lane's reading of the
  argument, not an entry: for members of four labels or more the count is to be derived here, not cited.
- **What is held at the pair, each for its class**: C124-FORCED (sector points: an arc of an edge on the point's unit circle;
  one topological input recalled, not read); C124-LONE (three-piece points by the letter: what a save by one member forces),
  with its object C124-LONE-EXISTS (one held family: fragment S1 with a band, a three-piece point by the letter only);
  C124-BOTH (full members: both separate; sector points: no save by one member alone); C124-FOUR (full members with one piece
  of each side: exactly four labels at the point); C124-SECOND (sector points, both common unit points in the set, pattern
  (1, 1): different edges, two labels in common, a cyclic order of the six). **C124-BOTH, C124-FOUR and C124-SECOND rest on
  C124-LONE, on whose Step II its deriver asks for a second mind**; cite them outside FS-124 with that said.
- **The method for a stop: C124-EDGE-CLOSED** ([hand], exact comparisons; § 4) — one held family: no weak six-colouring keeps
  six named pieces of FS-112's strip at their labels and contains the point `(1/4, √15/4 + √3/2)`. It uses C124-TYPE six times
  and no entry of § 3. The held map statement about the strip's six tiles is FS114-Y-STRIPK6 (row 138; two minds, blind);
  neither statement is the other. The disk's rim and the flower's far vertex by this method are not run.
- **Calibrations at seven** (§ 6): C124-FORCED-SEVEN (the count fails on the honeycomb at circumradius 2/5, exact) and
  C124-KIND (a tight pair with neither label present at its centre).
- **The reading** C124-READ-SAVES ([tools], one mind; § 7): the three maps read whole are of pattern (1, 1) at every common unit
  point inside; FS116-Y2-SIXFRAG has eighteen tight arcs of kind both and no close complementary pair.
- **The consumer of either answer: the radius clause** (§ 1). Weak measurable six-colourings of the open discs of every radius
  give `χ(ℝ²) ≤ 6` (C124-RADIUS-UP; no import); a disc with none gives seven only over the declared outside theorem
  `Outside.OAI158.proper_to_borel_weak` (C124-RADIUS-DOWN). Its module is complete on branch `fs124-wk1` — kernel-checked on a
  branch, not through the gate, not held.
- **Not held, that a claim here might assume** (that file's § 8): a piece in any weak six-colouring; anything for a member of
  four or more labels; whether a three-tile vertex of an arc map with a cusp is a sector point."""

QRING = """*At the record job """ + HEAD + """:* **what this milestone delivered is
`plans/FS124-derivation.md`** — thirty entries from two rounds, twenty-nine derived and one refuted: the radius clause (§ 1; its
module complete on branch `fs124-wk1`, kernel-checked on a branch, not through the gate, not held); the one lemma and what one
piece forces (§ 2); what a close complementary pair forces at a common unit point — for three-piece points, full members and
sector points, the posed wording refuted at a bowtie joined by a band (§ 3); FS-112's strip closed at one named point of its top
edge against every weak six-colouring that keeps six named pieces (§ 4); a count at a centre whose class has no held member, and
the rhombus's first half (§ 5); two calibrations at seven (§ 6); and a reading of nine six-coloured held objects, [tools] (§ 7).
**It delivered no exclusion beyond one held family, no object beyond held fragments, and no statement that a weak six-colouring
has a piece.** **The eight cases of "The question, in plain language" are open and pass to FS-136**
(`plans/STUB-covering-pairs.md`), by the asking lane's verdict above and the coordinator's ruling (`plans/FS124-close-inventory.md`
item 26)."""

FORCED = """*Since FS-124 """ + HEAD + """:* **the sharp form of the complementary pair has its
statement with content, on pieces.** C132-COMP-SHARP's conclusion is met by a one-point set (a dated correction stands under it
in `plans/FS132-derivation.md`). C124-FORCED-PIECES: of a close complementary pair of three-piece points, one member has a piece
inside the closed unit disc about each common unit point and another disjoint from the open one. For full members both do
(C124-BOTH), and with one piece of each side at each member exactly four labels are present at the point (C124-FOUR); both rest
on C124-LONE, on whose Step II its deriver asks for a second mind. **Nothing here forces a pair**: every entry begins from one
and says so in its *not claimed* line."""

SEED = """*Since FS-124 """ + HEAD + """:* two entries are stated on this stub's data —
exclusion sets at two points, no piece assumed: **C124-HALF** and **C124-HALF-TWO** ([hand] over the inherited C132-WIT-SIDE;
§ 5). With exactly one of the six sets on the unit circle about the common unit point, a neighbourhood of that point on one side
of one circle is split between two labels along the other circle; with one set of each point there, almost every point near it
has one of four labels. C124-HALF's class has one held member, with a one-point set on the circle (fragment S1; a dated
correction stands under the entry in `plans/FS124-E1-derivation.md`). **The line between this stub's arc-free side and the arc is
no wall for a statement that reads pieces**: C124-BOTH and C124-EDGE-CLOSED exclude configurations with a unit arc about a ring
point by the open-piece lemma (C124-SHADOW-OPEN, C124-TYPE) — G97's killing test, fired by its deriver's own scoring; an
amendment to G97 is drafted in `plans/FS124-Z1-record.md`. No entry gives a weak six-colouring a piece."""

BACK = """*Since FS-124 """ + HEAD + """:* **three map entries now have a statement
in measure beside them, one mind each, by other routes.** FS112-N3-COR3 (row 135): C124-BOTH with C124-FOUR, for full members
and sector points. Its verification's "One failure is not enough", with FS107-W-TAN's bowtie: C124-LONE with C124-LONE-EXISTS.
FS114-Y-STRIPK6 (row 138), for the strip at its own colouring and one point: C124-EDGE-CLOSED. Each assumes pieces at the points
it names and nothing else of the colouring; where it concludes an arc its hypothesis is a sector point — "a map's three-tile
vertex seen locally" (the asking lane, `plans/POROS-2026-10-07-fs124-round2.md` § 2.3). Not done, and a control in this stub's
direction: each read back at a map vertex and matched to its map entry clause by clause. Open, from the second deriver: whether
a three-tile vertex of an arc map with a cusp is a sector point."""

LATERAL = """*Since FS-124 """ + HEAD + """:* every entry of that file's §§ 2–4 that is not an
object begins from an open one-label set (C124-SHADOW-OPEN) or a connected one (C124-TYPE), and no entry gives a weak
six-colouring either. So what this stub's regularity would supply to that file is the piece, and no more is asked of it: with
three pieces at each of two points less than 2 apart carrying all six labels, C124-FORCED-PIECES applies as it stands; an arc on
the circle needs sector points (C124-FORCED), and "both members" full ones (C124-BOTH)."""

SAT = """*Since FS-124 """ + HEAD + """:* **what one tight pair forces with no saturation
is three statements, each for every weak `k`-colouring** (§ 2): C124-CENTRE (near the centre each label of the pair is confined
to one side of the unit circle about the far end), C124-STRADDLE (both labels absent near every other point one unit from the
far end but one) and C124-ANTIPODE (near the opposite point `2z − q`: `b` absent, and `a` absent inside the circle of radius 2
about `q`). C124-ANTIPODE is the neighbour, with no saturation, of row 140's unit parallels (G85), which need a saturated
colouring. By the first deriver (`plans/FS124-E1-derivation.md` Stage 4, "What the datum at a completion is"), whether anything is
forced at an arc's end or at a centre beyond C124-CENTRE "is not a first-order statement at any number of labels … it is where a
count across classes, or binding (FS-125, FS-128), has to enter". C124-KIND's colouring — a tight pair at seven with neither
label present at its centre — is not claimed saturated or honest."""

SIAMESE = """*Since FS-124 """ + HEAD + """:* **no entry of that file assumes a map, simplicity
or the absence of Siamese pairs.** The pair's statements (§ 3) read three pieces at each of two points and nothing else of the
colouring, so they apply to a Siamese fragment's three-tile vertices as to any other: C124-FORCED-PIECES wherever two of them
are a close complementary pair; with an arc, and for both members, where they are sector points (C124-FORCED, C124-BOTH — the
second resting on C124-LONE, on whose Step II its deriver asks for a second mind). They give this stub no kill: the map class's
kills at a degree-4 four-colour vertex are stated non-Siamese and simple, and in the asking lane's reading "'two pieces of one
label within 1' is no contradiction in measure until one has a point beyond 1 as well"
(`plans/POROS-2026-10-07-fs124-round2.md` § 1.2)."""

def end_of_file(L):
    j = len(L)
    while L[j - 1].strip() == "":
        j -= 1
    return j

PLAN = [
    ("plans/STUB-covering-pairs.md", end_of_bearings, COVER),
    ("plans/STUB-q-ring.md", after_paragraph_starting("*After the second round (Poros, FS124-P3, 2026-10-07;"), QRING),
    ("plans/STUB-forced-pair.md", end_of_bearings, FORCED),
    ("plans/STUB-seed-remainder.md", end_of_bearings, SEED),
    ("plans/STUB-exclusion-back-to-maps.md", end_of_bearings, BACK),
    ("plans/STUB-lateral-extent.md", end_of_bearings, LATERAL),
    ("plans/STUB-saturated-local.md", end_of_bearings, SAT),
    ("plans/STUB-qfree-ring.md", end_of_bearings, SIAMESE),
]
dry = "--dry" in sys.argv
for path, where, para in PLAN:
    f = ROOT / path
    L = f.read_text().split("\n")
    if any("FS124-Z1, the record job, 2026-10-07" in l for l in L):
        sys.exit("already appended in " + path)
    i = where(L)
    print(f"{path}: line {i + 1} of {len(L)}, after: {L[i - 1][-60:]!r}; next: {L[i][:40] if i < len(L) else '<end>'!r}")
    if not dry:
        L[i:i] = [""] + para.split("\n")
        f.write_text("\n".join(L))
