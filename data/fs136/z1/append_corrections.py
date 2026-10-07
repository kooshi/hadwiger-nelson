#!/usr/bin/env python3
"""FS136-Z1 (Done means 3 and 4): append the dated corrections and the stubs' bearing notes, each under the text it
concerns, the original left standing.

Each insertion names a file, an ANCHOR line that must occur exactly once in it, and the text placed after that line
(END_OF_FILE appends). Nothing is replaced. A second run changes nothing (each text carries the marker "FS136-Z1" and
an insertion whose whole text is already present is skipped).

    python3 data/fs136/z1/append_corrections.py            # applies; prints one line per insertion
    python3 data/fs136/z1/append_corrections.py --dry      # checks every anchor, writes nothing
"""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
END_OF_FILE = object()
INS = []


def ins(path, anchor, text):
    INS.append((path, anchor, text))


# ------------------------------------------------------------------ plans/FS136-E1-derivation.md
E1 = "plans/FS136-E1-derivation.md"
ins(E1, "   and the non-Siamese clause enter; in measure nothing bounds a piece from below (G96). It is the asking lane's to pose.", """
   *Erratum, dated 2026-10-07 (filed by FS-136's record job, FS136-Z1; drafted by the second deriver,
   `plans/FS136-E2-derivation.md` § 7.5 item 4; source: that record's Stage 6 — the entry C136-STOP-GERMS with its controls
   `stop-corners` and `stop-shadow`). The text above is left standing. Its sentence is false, in the second deriver's
   words: "a cell is emptied by pieces that are *crossing* at the point across, and crossing is a fact about a piece's
   extent … on the flower the germs suffice only because of the tangency" — "is false: at the strip's, the disk's and the
   bowtie fragment's stops the corners at the two members already empty the corner outside both unit circles, at first
   order, and extent only adds bars." So "which pieces at the members must reach across its unit circle?" is not the
   question the table leaves, and this round does not point back to the existence question: a held stop is excluded by
   the corner patterns at its two members alone (an entry at three stops; the asking lane's reading in floats at all 70,
   `plans/POROS-2026-10-07-fs136-round1.md` § 1.3). In the asking lane's words: "No entry of the round is wrong — each
   keeps whole tiles, a stronger hypothesis than it needs."*
""")
ins(E1, "`L2, T2, V′, t1, T1, W`).", """
*Added 2026-10-07 by FS-136's record job (FS136-Z1; sources: `plans/FS136-E2-derivation.md` Stage 6, under
C136-STOP-GERMS, with its controls `stop-corners` and `stop-shadow`; FS-136 inventory item 14). The entry and the two
notes above are left standing.* **Which corner the two vertex figures empty.** The cells this entry's witnesses empty —
inside the unit circle about `q₂` and outside that about `q₁`, and the mirror — are emptied by whole tiles: in the second
deriver's words, "true of whole tiles (`T2` and `T1` cross as tiles and are inner as corners); in corner form those two
cells keep one label each (`2` and `4`) and the emptied corner is the third, outside both, which that entry's finite list
of witnesses did not reach. Nothing in that entry is wrong; its statement stands." That third corner is "the cone
(−60°, 60°)" of the held map entry FS114-Y3-RSTOP. **A defect of this record's checker, reported by the second deriver,
no verdict moving**: `stop_check.py` "proves bars from a finite list of boundary points and misses the corner outside
both circles at the bowtie fragment's stop" — it under-reads, so its line for that cell ("labels not shown barred: 6")
is a bar not found, never a label left. **The six-tile form named above is entered** by the record job as
C136-STOP-BOWTIE-SIX (`plans/FS136-derivation.md` § 4), at the grade and count of minds of the note above, with a control
that reads this record's six witness lines (`data/fs136/z1/bowtie_six.py`). It and C136-STOP-GERMS (c) are both held and
neither contains the other: six whole tiles; the germs of eight.
""")
ins(E1, "   on the disk. Whether it moves any of that reader's counts was not examined.", """
   *Examined, dated 2026-10-07 (FS-136's record job, FS136-Z1; `data/fs136/z1/saves_compare.py`, its output
   `saves_compare.out`). That reader was re-run beside a copy with vertices kept at full precision
   (`data/fs136/z1/saves_read_repaired.py`; the original left as it is), on all eleven objects it reads. **No count
   moves**: the copy's line equals the original's on 11 of 11 objects. With the repair switched off the copy reproduces
   the original on 11 of 11; with vertices rounded to six decimals in place of nine the lines do move (the disk reads no
   edge on a circle at any of its 20 points: `saves_digits6.out`), so the comparison can see a rounding effect. The
   rounding stays a defect of that reader for any later use; none of the counts FS-124's theorem record § 7 or ledger
   row 163 quote depends on it. The dated line stands under that § 7.*
""")

# ------------------------------------------------------------------ plans/FS124-derivation.md
F = "plans/FS124-derivation.md"
ins(F, "deriver's own line, before what rests on it is built on outside this milestone (§ 3).", """
*Dated 2026-10-07 (FS-136's record job, FS136-Z1; the paragraph above is left standing): the second mind asked for in its
last sentence has looked, and the step has passed the kernel on a branch in the planner's statement of it — the dated
paragraph under C124-LONE, § 3. No grade moves.*
""")
ins(F, "on this entry; C124-EDGE-CLOSED does not. **What rests on it**: those three. **Kernel**: second module.", """
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
""")
ins(F, "(`saves-fragments`, `saves-r7`, `saves-lone`, `saves-maps`) and § 6 (`seven-exact`).", """
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
""")

# ------------------------------------------------------------------ plans/STUB-covering-pairs.md (dated correction notes; what it delivered)
S = "plans/STUB-covering-pairs.md"
ins(S, "objects the closure has been read one step only, from pairs (`data/fs136/p1/germs_read.out`).", """
*Correction, dated 2026-10-07 (filed by FS-136's record job, FS136-Z1; sources: `plans/FS136-E2-derivation.md` Stage 1,
finding 1, and its entries C136-CLOSE and C136-COLLAR; FS-136 inventory items 10 and 12; the paragraph above is left
standing, and re-wording it is the asking lane's). "Such a closure is a six-coloured fragment given by formula from its
seed alone" does not hold as worded. What a seed forces is, in C136-CLOSE's deriver's words, "a countable family of
corners at isolated points — each had at some radius, none of a size any statement bounds — unless a point carrying at
least `k − 1` labels forces along an arc"; so this form "cannot be met by the closure of a finite seed unless some member
carries at least `k − 1` labels and forces along a whole arc of its unit circle". That exception is inhabited at six on
one held object: the bowtie fragment's two five-label points force their missing labels on one-sided collars of four arcs
of 60° (C136-COLLAR — a definite length, no definite width). What collars force is not computed: stub FS-137,
`plans/STUB-collars.md`.*
""")
ins(S, "| on R7 at seven the closure reproduces R7 near the seed | — | tightness at seven is rigid from two points: the control every six-coloured closure is compared with |", """
*Correction, dated 2026-10-07 (filed by FS-136's record job, FS136-Z1; drafted by the second deriver,
`plans/FS136-E2-derivation.md` § 7.5 item 3; source: its entries C136-CLOSE-R7 and C136-CLOSE; the table above is left
standing). **Its last row falls**: "on R7 at seven the closure reproduces R7 near the seed … tightness at seven is rigid
from two points" is to read "on R7 the closure of two adjacent lattice points is fifteen corners and stalls; the pair's
table is exact at every corner and no corner is emptied" (C136-CLOSE-R7: computed exactly, one mind). **Its fourth row is
about corners, not regions**: a closure that closes up is, in C136-CLOSE's *not claimed* line, "a set of vertex figures,
not a coloured fragment", so "a fragment by formula past print" cannot come from the closure of a seed of points with
three or four labels. The other rows stand as answered: the forward statement holds (C136-FORCED); no seed tried reached
an empty corner beyond its pair's own common unit points; every closure stalled, and the free corners are the search
lane's (queue lines 17–20).*
""")
ins(S, "  seven for that seed; a closed ring — toward six; a stall — the free cells, to the Searcher.", """
  *Correction, dated 2026-10-07 (filed by FS-136's record job, FS136-Z1; drafted by the second deriver,
  `plans/FS136-E2-derivation.md` § 7.5 item 2; sources: its Stage 0.2 item 1 and its entry C136-CLOSE-STRIP; the bullet
  above is left standing). Seed (c), "the six tiles of a covering pair at one of its 34 three-label coloured points",
  names no object of the strip: those 34 points are the common unit points of pairs of four-label members (eight tiles).
  It is to read "(c1) the eight corners of two four-label points half a unit apart, whose common unit points are two of
  the 34 three-label coloured points; (c2) the six corners of a pair of three-label points". Both were run
  (C136-CLOSE-STRIP): (c1) forces ten corners at six points and stalls; (c2) forces nothing in the strip. Throughout this
  bullet a "germ" and a "cell" are, as derived, labelled corners (C136-CORNERS: a cell is one corner, or two).*
""")
ins(S, END_OF_FILE, """
*What this milestone delivered (FS136-Z1, its record job, 2026-10-07; every entry named is in `plans/FS136-derivation.md` —
twenty-one entries, each derived: [hand], derived from [hand] entries, or computed exactly over named corners; **one mind
each, kernel pending**). **Every statement is about weak colourings that already have named regions or corners; no weak
six-colouring is known to have one. None excludes a colouring of a disc; none fixes or bears on the value of χ(ℝ²).***

- **The table** (C136-TABLE, § 1): near a point with finitely many points one unit away, each with finitely many pieces,
  almost every point has a label that is pure on its side at every one of them that carries it — any number of members,
  pieces and labels. It was reached on one route by this milestone's first deriver and by the kernel planner of FS-124's
  second module, and counts as one mind. **The count** for two families carrying all the labels (C136-COVER) and for one
  (C136-ONE), each on labels: the conclusions as posed were met by one region cut in two along the circle.
- **The four held stops** (§ 4): the strip's, the disk's and the bowtie fragment's are excluded for every weak
  six-colouring that keeps the parts of the named tiles within any `r > 0` of two vertices (C136-STOP-GERMS; first order
  at all three, C136-STOP-GERMS-RADIUS); the flower's for the germs of six tiles (C136-STOP-FLOWER-GERMS; one label barred
  at second order). The whole-tile forms are corollaries. A held stop is a fact about two vertex figures.
- **The forward step and the closure** (§ 2): a corner on which the pieces one unit away leave one label has that label
  (C136-FORCED); chained (C136-CLOSE), a seed forces labelled corners at isolated points, each of no definite size — "a
  set of vertex figures, not a coloured fragment". **Computed on three objects** (§ 3), exactly, by forced steps only: the
  tight seven-colouring's pair stalls after three corners, none emptied; the flower's pair after six; the strip's two
  four-label points after ten; the strip's pair of three-label points forces nothing.
- **The collar** (C136-COLLAR, § 2): a point whose corners carry all the labels but one forces the missing label on a
  one-sided collar of every arc of its unit circle along which none of its own labels is pure on that side — a definite
  length, no definite width; inhabited on the bowtie fragment's two five-label points. What collars force is not
  computed: stub FS-137, `plans/STUB-collars.md`.
- **The bound on partners** (C136-PARTNERS, § 5), over C124-BOTH's second clause.
- **The two cards' branches.** First card: the third branch, "with its unit corrected — the table at the point across,
  not the ring's type"; "always" not derived; no ring by formula. Second card: every closure stalled within two steps —
  the card's own clause for sending the milestone to its record job; no empty corner from a pair beyond its own common
  unit points on four seeds; and a closure cannot close into a fragment.
- **What it did not deliver**: a piece or a corner in any weak six-colouring; an exclusion beyond one held family;
  FS-124's eight cases one by one (they are open — the dated note in `plans/STUB-q-ring.md`); the structural form's second
  half, a relation between the tables of one ring beyond the closure. The free corners of the four computed closures are
  the search lane's (queue lines 17–20, with line 15).
""")

# ------------------------------------------------------------------ the four open stubs this milestone moved: bearing notes
HEAD = ("*Since FS-136 (FS136-Z1, the record job, 2026-10-07; every entry named is in `plans/FS136-derivation.md`, [hand], derived from "
        "[hand] entries or computed exactly over named corners, **one mind each, kernel pending**; each is about weak colourings that "
        "already have the named regions or corners, and none is known to):* ")
ins("plans/STUB-lateral-extent.md", END_OF_FILE, "\n" + HEAD + """every entry of that file begins from pieces or
labelled corners at named points, and none gives a weak six-colouring one. Two bear on what this stub would have to
supply. **C136-FORCED** gives a piece at a new point from pieces at old ones, and what it gives is a germ — its *not
claimed* line: "a lower bound for η (it is half the least witness depth of the bars used, and shrinks at every step)";
chained (**C136-CLOSE**), "no region of definite size is forced". So a radius for a forced corner is this stub's ground —
"a piece of definite size" (the second deriver's sweep, `plans/FS136-E2-derivation.md` § 7.4) — and nothing in FS-136
supplies it. **C136-COLLAR** forces a region with a definite length and no definite width, and only from a point that
already carries five of the six labels. **This stub's question was not re-posed by FS-136**: the first round's closing
sentence, which pointed back here ("which pieces at the members must reach across its unit circle?"), is withdrawn by a
dated erratum under it — a held stop is excluded by the corner patterns at its two members alone (**C136-STOP-GERMS**).
""")
ins("plans/STUB-seed-remainder.md", END_OF_FILE, "\n" + HEAD + """**question 3's forward step has an entry for
pieces.** The sentence this stub keeps of FS132-E3's paragraph — "a region where one label is forced survives" — was read
at its source by FS-136's second deriver: it is "the forward step **in the palette calculus**", "used inside
C132-M-ORBIT's argument (M3–M5 …) and never entered as a statement". For pieces it is now **C136-FORCED**: at a point `w`,
a corner cut by the unit circles about finitely many points one unit away, on which their pieces bar every label but one,
has that label almost everywhere — at every `k`, for any number of such points. Chained it is **C136-CLOSE**, and what a
seed of pieces forces is labelled corners at isolated points, each of no definite size. **On this stub's own data —
palettes and exclusion sets, no piece assumed — no entry of FS-136 applies as it stands**: each reads pieces or labelled
corners. One count of G98's has a form for pieces: at a point carrying five of six labels one label is left for its ring,
and **C136-COLLAR** forces it on a side of every arc of the unit circle along which none of the point's own labels is
pure on that side. No entry gives a weak six-colouring a piece or a seed.
""")
ins("plans/STUB-q-ring.md", "- Grokkings: G94, G95; proposed G96 (circle data against ball data) and G97 (every exclusion ended at the unit arc).", """
""" + HEAD + """**the eight cases of "The question, in plain language" were not taken one by one by FS-136, and are
open.** Its unit turned out to be a point with rich points on its own unit circle, with the ring of a centre an index:
"'Four or more labels at `p`' is not read by anything at the point across" (its reading, [tools]). What it holds that
touches a case: **case 4** — at a point whose pieces carry all six labels the unit circle separates inner-pure from
outer-pure labels near each of its points (**C136-ONE**: FS116-N2-SIXRING's statement on labels, with no map and no
non-Siamese clause); at a point whose corners carry five labels the sixth is forced on a one-sided collar of every arc
along which none of the five is pure on that side (**C136-COLLAR**; beside FS116-N2-FIVERING, which its deriver read at
its statement only); the flower's far vertex `(√3, 0)` is excluded for every weak six-colouring that keeps the germs of
six of its tiles at two ring points (**C136-STOP-FLOWER-GERMS**: FS116-Y2-SIXOFF at the fragment's own pattern).
**Case 2's object**, the disk about its corner, stops at a rim point that is excluded for every weak six-colouring that
keeps the germs of six of its tiles at two three-label vertices (**C136-STOP-GERMS** (b)): the disk's own stop, in
measure; it does not decide case 2. **Cases 1, 3 and 5–8**: nothing. Where the eight cases go after FS-136 is the asking
lane's to say at its re-rank.
""")
ins("plans/STUB-exclusion-back-to-maps.md", END_OF_FILE, "\n" + HEAD + """**more map entries have a statement in
measure beside them**, each naming its map entry in its `prior art:` line: FS110-N-SEAM (b) with N-E2 (two minds, one
blind) — **C136-TABLE**; FS110-N-SEAM (a)–(b) with FS110-CALC's A-EXACT — **C136-COVER**, the count for members of any
number of labels; FS116-N2-SIXRING — **C136-ONE**, on labels; FS112-C-PARTNERS — **C136-PARTNERS** ("nothing new but the
class"); FS116-Y2-SIXOFF — **C136-STOP-FLOWER-GERMS**; FS112-STOP, FS112-DISK-RIM and FS114-Y-PENT — **C136-STOP-GERMS**
(b); FS114-Y-STRIPK6 — **C136-STOP-GERMS** (a), at the strip's own colouring; FS114-Y3-RSTOP — **C136-STOP-GERMS** (c),
the same corner as its "cone (−60°, 60°)"; FS116-N2-FIVERING — **C136-COLLAR** (the map entry read at its statement
only); placing (G91) — **C136-FORCED** (the map entries named, not read). **In this stub's direction, back to maps, the
derivers' own verdict is "for maps nothing"** new. One instrument does cross: **C136-CLASS** classes a corner by direction
and then by signed curvature, where "the cone calculus of FS-116 reads directions only and says 'tangent' where this
reads curvature" — a map vertex's corners can be classed by it exactly (`data/fs136/e2/closure.py`). Not done: any of
these read back at a map vertex and matched to its map entry clause by clause.
""")


def main():
    dry = "--dry" in sys.argv
    texts = {}
    for path, anchor, text in INS:
        s = texts.setdefault(path, (ROOT / path).read_text())
        key = text.strip()
        if key in s:
            print(f"skip (already present) {path}: {key[:50]!r}"); continue
        assert "FS136-Z1" in text
        if anchor is END_OF_FILE:
            s = s.rstrip("\n") + "\n" + text
        else:
            lines = s.split("\n")
            hits = [i for i, l in enumerate(lines) if l == anchor]
            if len(hits) != 1:
                sys.exit(f"ANCHOR occurs {len(hits)} times in {path}: {anchor[:80]!r}")
            i = hits[0]
            lines[i + 1:i + 1] = text.rstrip("\n").split("\n")
            s = "\n".join(lines)
        texts[path] = s
        print(f"{'would insert' if dry else 'inserted'} in {path} after {'END OF FILE' if anchor is END_OF_FILE else repr(anchor[:60])}")
    if not dry:
        for path, s in texts.items():
            (ROOT / path).write_text(s)
    return 0


if __name__ == "__main__":
    sys.exit(main())
