#!/usr/bin/env python3
"""FS132-Z2: append dated bearing lines and dated correction notes to open stubs.

Each insertion is placed by an anchor asserted to occur exactly once; nothing that stands is changed
(the script only inserts). Idempotent: an insertion whose first 70 characters are already in the file is
skipped. `--check` asserts every insertion is present exactly once; `--check --fault` asks for an
insertion that was never made and must exit non-zero (the planted fault).

Run from the repository root:  python3 tools/fs132_z2_append.py [--check [--fault]]
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
D = "`plans/FS132-derivation.md`"

INS = []


def add(path, mode, anchor, text):
    INS.append((path, mode, anchor, text.strip("\n")))


# ---------------------------------------------------------------- FS-124, the (Q) ring
add("plans/STUB-q-ring.md", "before", "## Carried card (Poros, R2, 2026-10-03;", f"""
*Since FS-132 (FS132-Z2, 2026-10-07; every entry named is in {D}, [hand] or derived from [hand] entries, one mind, kernel
pending, unless marked):*

- **This stub's object is where every round of FS-132 ended**: a boundary that is an arc of a unit circle whose centre is the
  other end of a unit distance. It appears two ways (that file's § How to read an entry): (α) on the centre's own ring — in the
  map class a (Q) arc; in measure, palettes that hold no label outside the centre's own on a set of positive measure near a ring
  direction; (β) through the centre — an edge set of the centre lying on the unit circle about one of its ring points. The
  asking lane reads the two as one object, the unit arc of rows 135–136 (`plans/FS132-close-inventory.md` item 24; checked by
  neither the coordinator nor the record job). In that file's words, nothing in it "excludes, builds or bounds a boundary that
  is a unit arc about a ring point".
- **A measurable instance of this stub's first question** — what a (Q) ring passes to the vertices it places — **with every
  hypothesis derived from a seed's circle data: C132-PLACED-RING** ([hand], one mind, kernel pending; § 5 of that file). On a
  six-sector turning seed `x` (a point with a witnessed triangle whose palettes read `a, b, n, a, b, n`) whose ring points
  `y_1`, `y_{{−1}}` are outer-pure: near `y_1`, outside `x`'s ring, almost every point has the label `b` inside and `a` outside
  the unit circle about `y_0`; near `y_{{−1}}`, `a` inside and `b` outside; and the palettes of `y_0` on the two arcs are
  contained in `{{a, b}}`. So the unit circle about `y_0` runs along an interface between the two ring labels at both
  neighbours, oppositely oriented. **Not claimed by it**: that those two palettes contain both labels (each is present on one
  side of the arc; "not written out"); anything on the rest of the unit circle about `y_0`; that `y_0` is a cyclic centre. With
  three consecutive outer-pure ring points `y_0` has four labels present (C132-LENS-FOUR). **No model is known** — no weak
  six-colouring with a turning seed is held — so "derived" means from the seed's data, never that a seed exists.
- **A pruning rule on one orbit: C132-M-ORBIT** ([hand], one mind, with a line-by-line checking reading of its last steps by a
  second mind; the kernel lane's first module). At a point where four labels meet in a witnessed cycle, no ring direction `ψ`
  has palettes holding one of the two other labels almost everywhere near all six directions `ψ + kπ/3` while both occur near
  `ψ`. Read on a ring with (Q) arcs: every essential change of the outside state has a (Q) arc at its six-fold orbit — at each
  of the eight change points of the held fragments' four-colour vertices at least two of the four germs at ±60° lie on (Q) arcs
  (control `positives-escape`).
- **The head's "C132-DIAG, posed" is an instance of the release's own Lean theorem** (`two_state_impossible`, at every number
  of labels); what FS-132 adds is its reading on an open set, one mind (C132-DIAG-WIDE).
- **Open, carried here from FS-132, none started**: **C132-ARC** (posed in `plans/STUB-six-by-the-nerve.md` § The question,
  re-posed after the second round; "no line of it worked, its R7 control not run"; a tool it did not have when posed is
  C132-SHADOW); **C132-PLACED's open line** — whether any pair containing a label of the centre's triple is a witnessed edge at
  the placed point — with FS132-E6's forms (a)–(c) (`plans/FS132-E6-derivation.md` § The list: what fills the two inner wedges;
  what the placed point's ring carries at the orbit's four other points; the same one step on); **C132-RADIUS** — weak
  six-colourings of discs of every radius give `χ(ℝ²) ≤ 6`, the measurable form of row 145, posed and not started: the YES
  side's clause of this stub once it is posed in measure.
- **The three residues of FS-132's second round are this object**: the conclusion of C132-COMP-SHARP (one of six edge sets on
  the unit circle about the common unit point; fragment T2 realizes it with three), the residue of C132-ALT (three alternate
  ring points, each with one of the centre's three sets on its unit circle), the void of C132-PLACE (a ring point with no pure
  side).
- **A model of the hard case in a finite family**: with four labels at alternate ring points the turning ring has models in
  the Searcher's seven-flower wedge family — each interface at the centre an arc of the unit circle about a ring point, those
  ring points exactly the four-label ones (SEARCH-1007-TURN4, [cert] by a cold check of the kept models; local, flowers of
  radius about 0.25). "The search's kept model is the hard case and no statement of the stage applies to it"
  (`plans/FS132-close-inventory.md` item 28). Its extension to the annulus and the closed unit disc is `plans/SEARCH-QUEUE.md`
  line 11, held.
- **What transfers from the map class** — rows 135–138 and 145–150 are theorems about maps — needs the dictionary fact FS-134
  owes (`plans/STUB-exclusion-back-to-maps.md`: a map's palette is its ring read two-sidedly). The arc-free remainder of the
  seed is FS-135 (`plans/STUB-seed-remainder.md`).
- Grokkings: G94, G95; proposed G96 (circle data against ball data) and G97 (every exclusion ended at the unit arc).
""")

# ---------------------------------------------------------------- FS-123, the Siamese class
add("plans/STUB-qfree-ring.md", "before", "## Carried card (Poros, R2, 2026-10-03;", f"""
*Since FS-132 (FS132-Z2, 2026-10-07):* C132-M-EXCL ({D} § 1; [hand], one mind, with a second mind's checking reading of its
last steps; kernel pending) is this stub's first case with no map and no Siamese clause: at a point where four labels meet in a
witnessed cycle the palettes cannot almost everywhere hold one of the two other labels. That it covers a valid six-coloured
fragment at a vertex where four tiles of four colours meet in a cycle is **given two facts about maps** — a map's edge carries
the two-colour exclusion (derived for connected open tiles, C132-WITNESS, one mind; the composition unwritten) and a map's
palette is its ring read two-sidedly (underived): the short job FS-134, `plans/STUB-exclusion-back-to-maps.md`. Left to this
stub after it: a vertex of at least four colours whose tiles about it contain no four-cycle of four colours (FS132-E3's
report). The asking lane's banner for this stub — "Absorbed on the measurable road … Demoted 3 → 8 until the kernel has
C132-M-EXCL; then to the closed list" (`plans/POROS-2026-10-07-fs132-night.md` § Banners) — is drafted, not filed. G86: a kill
that reads points and distances reaches the Siamese class, and this is the instance.
""")
add("plans/STUB-qfree-ring.md", "eof", "", f"""
## Dated correction notes (FS132-Z2, 2026-10-07)

- **The head's line of 2026-10-07 (FS132-P1), "Its first case is FS-132's existence form, asked for measurable colourings"**:
  that form is answered NO in the measurable class — C132-M-EMPTY, the instance of C132-M-EXCL at an extracted centre with a
  cycle of four labels ({D} § 10; [hand], one mind, kernel pending). **"a second route to its NO at radius 2 … (a placement,
  queued for the Searcher)"**: the first consumer of `plans/SEARCH-QUEUE.md` line 9 is met by C132-M-EXCL at radius 1 with no
  graph; the line stays open at low priority as a second route (`plans/FS132-close-inventory.md` item 10).
""")

# ---------------------------------------------------------------- FS-127, lateral extent
add("plans/STUB-lateral-extent.md", "eof", "", f"""
*Since FS-132 (FS132-Z2, 2026-10-07) — this stub now carries the existence question FS-132 gave up.* By Kooshi's word of
2026-10-07 (`data/external/EXT-OAI1-request.md` § Kooshi's sixth word: "I agree with all 3", the first of the three being that
FS-132 "stop asking whether readable meeting points must exist and deliver 'what any such point's circle forces'"; the
coordinator's reading there: the question "stays with FS-127 and FS-128"; `plans/FS132-close-inventory.md` items 23 (b), 24,
32 (a)), **whether every weak measurable six-colouring has a point with usable data on its unit circle is no longer FS-132's
question.** What FS-132 derived of it ({D} §§ 2, 3, 8; each [hand] or derived from [hand] entries, one mind, kernel pending):

- **Centres exist with no hypothesis**: every closed disc of radius above 1 holds a cyclic centre, at every number of colours
  (C132-CORES-FREE). A square form, side above 1, is posed by the kernel planner and entered as a gap (C132-CORES-SQUARE).
- **Data at a centre, under a hypothesis nobody supplies at six**: on a closed disc of radius above 1 with finitely many cyclic
  centres, one centre carries a label cycle with continua, limiting directions and the two-label exclusions (C132-EXT-DISC).
  What its argument reads of the hypothesis is zero length of the centres and **isolation of the one essential centre**; at the
  island colouring's accumulation centre the conclusion with its clause (4) is false, and true at the isolated ones (control
  `hex7-islands`).
- **Where isolation is read**: not in the exclusion's proof — that runs from any connected subset of one smoothed class's
  superlevel set, "no hole, no exceptional set, no centre, no isolation, one label at a time" (C132-WIT-SUPER) — but in the
  step before it, the selection of a point through which connected pieces of two smoothed classes pass and reach a common
  second point. Existence with no hypothesis on the centres stalls there (C132-WIT-EX). Its smallest open form (O), verbatim:
  "a weak colouring and a disc of radius above 1 in which, at every point, the graph of witnessed label pairs is a forest".
- **Data are free where there is a margin, and do not locate a centre** (C132-WIT-MARGIN): labels whose supports keep off an
  annulus about a point's unit circle are witnessed there by every nearby point. So the question is real only for colourings
  with no margin. FS132-E5's question for this stub: do this project's tight seven-colourings have a disc with no margin for
  any three labels at any point?
- **Two inclusions, not one place** (the asking lane; `plans/FS132-close-inventory.md` item 21): a point's *transition graph*
  is a property of every small ball about it, its *witness graph* a property of its unit circle. FS-132's exclusions read the
  second; no entry derives circle data at a point from its small balls.

The asking lane's re-aim of this stub — honest colourings; "an essential centre is isolated and the centres have zero length"
(`plans/POROS-2026-10-07-fs132-night.md` § The ranked table, rank 4, and § Banners) — is drafted, not filed. Of FS132-E1's two
proposals: the extraction for countable closed sets of centres was declined as a stub by the asking lane (the same record,
§ The debts); its side question — under REG-J′, are a saturated colouring's cyclic centres locally finite, "a candidate,
unchecked" — was not started, and belongs beside FS131-E8's line above. Grokkings: G94; proposed G96.
""")

# ---------------------------------------------------------------- FS-128, the top colour
add("plans/STUB-top-colour.md", "before", "## Carried card (Poros, R2, 2026-10-03;", f"""
*Since FS-132 (FS132-Z2, 2026-10-07) — with FS-127, this stub now carries the existence question FS-132 gave up.* By Kooshi's
word of 2026-10-07 (`data/external/EXT-OAI1-request.md` § Kooshi's sixth word; the coordinator's reading there: it "stays with
FS-127 and FS-128"; `plans/FS132-close-inventory.md` item 32 (a)), whether every weak measurable six-colouring has a point with
usable data on its unit circle is no longer FS-132's question. How the head's line of 2026-10-07 ("Whether a saturated normal
form is on the road at all waits on FS-132's cards 1 and 2") resolved: **for the exclusions no normal form is read** — on the
side where no boundary is a unit arc about a ring point they run for every weak measurable colouring ({D} § 12) — **and for
existence the normal form is undecided.** What FS-132 found about honesty as that normal form (its §§ 7–8; [hand], one mind):

- the Grundy test's first clause tests nothing: for no order of the labels is the hexagonal seven-colouring at circumradius
  2/5, or either slack colouring planted in it, a Grundy colouring (C132-GRUNDY7-NOT, whose *not claimed* line reads "that this
  tells the slack colourings from the hexagonal one — it does not, and that is the finding");
- for a suitable order *some* output of the Grundy construction is one label on the whole slack ball (C132-GRUNDY7-LOCAL); "the
  Grundy-ization" is not one output, so C132-GRUNDY7's second clause is withdrawn as posed, and its two readings are open —
  (G1) some output, (G2) every honest seven-colouring (`plans/FS132-E5-derivation.md` § What the second clause is, and what is
  left of it);
- the statement honesty would have to supply: on the unit circle about a point with a witnessed triangle, the three outside
  labels change finitely often (C132-RING-TAME's first clause, a stall: "for three labels on a strip no rigidity is held, by the
  release or here"; false wherever local slack exists along the strip, G95). FS132-E2's form "three labels on a strip" was
  declined as a stub by the asking lane on the night, pending C132-GRUNDY7 (`plans/POROS-2026-10-07-fs132-night.md` § The
  debts), which did not decide the class; it is placed here and at FS-125. FS132-E5's calibration for it, a reading with its
  killing test: a Grundy seven-colouring with a banded pair of facing unit arcs, or its exclusion (leaning on G84).

Grokkings: G89, G95, G84.
""")

# ---------------------------------------------------------------- FS-125, the saturated class
add("plans/STUB-saturated-local.md", "eof", "", f"""
*Since FS-132 (FS132-Z2, 2026-10-07):* the exclusions FS-132 derived for weak measurable colourings — the outside-labelled
four-cycle (C132-M-EXCL), the complementary pair (C132-COMP-SHARP), the alternating ring in step form (C132-ALT); each [hand],
one mind, kernel pending — read no arc and no normal form, and each stops at one object, a boundary that is a unit arc about a
ring point ({D} § 12). So NO-SAT is on the measurable road only if a normal form is chosen for the *existence* step, and
nothing yet says that it is saturation: the asking lane's line for this stub reads "Demoted … on the road again only on the
condition its row names" (`plans/POROS-2026-10-07-fs132-night.md` § Banners; drafted, not filed). One statement of FS-132's is
a normal-form statement and bears here — **three labels on a strip**: on the unit circle about a point with a witnessed
triangle, do the three outside labels change finitely often (C132-RING-TAME's first clause, a stall; "its first clause is
false wherever local slack exists along the strip, so it is a statement for a normal form or false at six",
`plans/FS132-close-inventory.md` item 7)? Declined as a stub by the asking lane on the night; placed here and at FS-128
(`plans/STUB-top-colour.md`). G95, G84.
""")

# ---------------------------------------------------------------- FS-122, the forced pair
add("plans/STUB-forced-pair.md", "before", "## A card carried for the opening (filed by Keryx, 2026-09-29)", f"""
*Since FS-132 (FS132-Z2, 2026-10-07; entries in {D}, [hand] or derived from [hand], one mind, kernel pending):* **the pair's
exclusion is derived in the exact class, up to one residue.** C132-CROSS (a covering count at a common unit point: "it reads no
properness") and C132-COMP-SHARP: two points less than 2 apart carrying witnessed triangles on disjoint triples of six labels
force one of the six edge sets onto the unit circle about each of their common unit points — with no cone scale. The residue
is real: fragment T2 realizes it. Row 133's sharpening is drafted (`plans/FS132-Z1-record.md` § 5.1). **What is left of route R
in the exact class is the forcing alone, and it stalled**: that some centre is not a triangle (C132-LONG, C132-M-CV) stalls at
the winding of the three outside labels on a triangle centre's unit circle (C132-RING-TAME), and behind it "two further steps
of the regular chain have no weak form (two centres of one type at distance between 1 and 2, and the bicycle)". Derived on the
way, with no colouring in them: a loop in the triangle of three labels with the 60° exclusion has degree 3 modulo 6
(C132-INDEX, C132-RING-WIND), and the classes of the centres inside a circle add up to the circle's (C132-REL). FS132-E3's
hand-over for the forcing: put to row 134's base the question FS-132 put to this project's exclusion — does that chain at a
cubic three-colour vertex read arcs and degree three, or only a triangle centre's three exclusion sets and its palettes? The
asking lane's re-aim of this stub at the exact class (`plans/POROS-2026-10-07-fs132-night.md` § The ranked table, rank 3, and
§ Banners) is drafted, not filed. Proposed G98 (six is the count at which the outside labels wind).
""")

# ---------------------------------------------------------------- FS-130, the bicycle's windings
add("plans/STUB-bicycle-windings.md", "eof", "", f"""
*Since FS-132 (FS132-Z2, 2026-10-07):* two statements with no colouring in them bear on the windings ({D} §§ 3–4; [hand], one
mind; a second derivation of the first by the kernel planner, blind, not counted): **C132-INDEX** — a continuous loop in the
triangle of three labels whose supports at `e` and at the 60° rotation of `e` are disjoint has degree congruent to 3 modulo
6 — and **C132-REL** — the classes of the cyclic centres inside a circle add up to the circle's. In the weak measurable class
the bicycle is one of the regular chain's two last steps with "no weak form" (C132-LONG's stall). FS132-E2 proposed this
line; the asking lane moved this stub 15 → 5 in its drafted re-rank of the night (`plans/POROS-2026-10-07-fs132-night.md`
§ The ranked table; drafted, not filed).
""")

# ---------------------------------------------------------------- FS-132's own stub
add("plans/STUB-six-by-the-nerve.md", "before", "## The mission, in plain language", f"""
**What FS-132 delivers (dated line, FS132-Z2, 2026-10-07; by Kooshi's word of that day, `data/external/EXT-OAI1-request.md`
§ Kooshi's sixth word; `plans/FS132-close-inventory.md` items 24, 32).** FS-132 delivers **what a point with data on its unit
circle is forced to carry**, in the class of every measurable colouring proper at almost every unit pair, with no map:
{D}, 57 entries — 47 derived, 10 stalls and gaps — each [hand] or derived from [hand] entries, one mind, kernel pending, but
the day's search ([cert] in its finite family). Whether every such colouring *has* such a point is no longer this milestone's
question: it is FS-127's and FS-128's (`plans/STUB-lateral-extent.md`, `plans/STUB-top-colour.md`). The configuration every
round ended at — a boundary that is an arc of a unit circle whose centre is the other end of a unit distance — is FS-124's
(`plans/STUB-q-ring.md`), the next milestone by the same word. **No value moved.** Where each open thread went:
`plans/FS132-Z2-record.md` Stage 2. Open inside this milestone's Lean phase, and so not stubs: the square form of "centres
exist" (C132-CORES-SQUARE, a gap: one comparison of the planner's route with FS132-E1's steps S5–S7, on branch `fs132-wk1`);
the first night's exclusion on an open set (its ground there is one mind's reading of two proofs of the release as local, step
M0; the whole-plane form is formalized first). Owed from § Named deliverables and not delivered: the nerve viewer
(`plans/FS132-close-inventory.md` item 1).
""")
add("plans/STUB-six-by-the-nerve.md", "after",
    "  hunch: it cannot — at a change on an outside-pure arc whose two neighbours also change", f"""
  *Dated line (2026-10-07, from FS132-E4's report, `data/fs132/reports/FS132-E4.md`; filed by FS132-Z2):* true on outer-pure ring points of a six-sector turning ring and not on inner-pure ones, where nothing is placed (C132-PLACE and the list under it, {D} § 4); "on a twelve-sector ring the sides exchange roles".
""")
add("plans/STUB-six-by-the-nerve.md", "after",
    "that is not a step on the six arcs; anything at a ring point one of whose neighbours has no pure outer side.", f"""
  *Dated line (2026-10-07, from FS132-E6, `plans/FS132-E6-derivation.md` § The gap in clause (ii); filed by FS132-Z2):* clause (ii) is a gap as posed — C132-LENS-II. "Pure sides are opposite at antipodes" holds one way only: a point strictly inside the unit circle about `y` is strictly outside the one about `2x − y`, and not conversely; three sets `{{x, q_j}}` with `|q_j − x| = 3` give six pure inner sides and no pure outer side. Derived of it: C132-LENS-FOUR and C132-LENS-GERM. Open: sixteen patterns of sides, carried by FS-135 (`plans/STUB-seed-remainder.md`). The first sentence and clause (i) are derived (C132-LENS, C132-LENS-SIDE).
""")


def marker(text):
    return text.strip()[:70]


def main():
    check = "--check" in sys.argv
    fault = "--fault" in sys.argv
    bad = 0
    done = skipped = 0
    for path, mode, anchor, text in INS:
        f = ROOT / path
        body = f.read_text(encoding="utf-8")
        mk = marker(text) if not (check and fault) else marker(text)[::-1]
        n = body.count(mk)
        if check:
            if n != 1:
                print(f"MISSING  {path}: marker occurs {n} times: {mk[:50]!r}")
                bad += 1
            else:
                print(f"present  {path}: {mk[:50]!r}")
            continue
        if n:
            skipped += 1
            continue
        if mode == "eof":
            new = body.rstrip("\n") + "\n\n" + text + "\n"
        else:
            lines = body.split("\n")
            hits = [i for i, ln in enumerate(lines) if anchor in ln]
            assert len(hits) == 1, f"{path}: anchor occurs {len(hits)} times: {anchor[:60]!r}"
            i = hits[0]
            block = text.split("\n")
            if mode == "before":
                lines[i:i] = block + [""]
            elif mode == "after":
                lines[i + 1:i + 1] = [""] + block
            else:
                raise SystemExit(f"unknown mode {mode}")
            new = "\n".join(lines)
        assert len(new) > len(body)
        f.write_text(new, encoding="utf-8")
        done += 1
    if check:
        print(f"insertions={len(INS)} missing={bad}")
        sys.exit(1 if bad else 0)
    print(f"insertions={len(INS)} written={done} skipped={skipped}")


if __name__ == "__main__":
    main()
