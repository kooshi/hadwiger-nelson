#!/usr/bin/env python3
"""FS124-Z1, stage 3: append the five dated corrections, each under the text it corrects.

Nothing standing is changed: each paragraph is inserted after a blank line, and the script
refuses to run twice (it looks for its own marker). --dry prints where each would go.
"""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
MARK = "*Correction, dated 2026-10-07 (filed by FS-124's record job, FS124-Z1"

def after_entry(lines, name):
    i = lines.index("derivation: " + name)
    while lines[i].strip():
        i += 1
    return i + 1                      # the line after the blank line that ends the entry

def after_line(lines, start, ending):
    i = next(k for k in range(start, len(lines)) if lines[k].rstrip().endswith(ending))
    assert lines[i + 1].strip() == "", "the paragraph does not end where expected"
    return i + 2

E1_GRAPH = MARK + """; source: the kernel
planner's record `plans/FS124-kernel-plan.md` § 4.1 on branch `fs124-wk1`, the row "the bad pairs `N`" of its table; inventory
item 19, "For the deriver's entry"):* in § Argument — a random rigid motion, the sentence "The set `N` of pairs `(z, u)` … is
measurable (`c` is) and null (weak properness)" has one clause that no later line uses. The planner: "the hand argument's clause
"measurable (`c` is)" is not used by any later line, and the entry's own *uses only* says "no regularity of `c`"; the kernel
statement is `AeProperOn`, for any function". The step reads only that `N` is null. The entry's statement, verdict, grade and
count of minds are unchanged; that the result holds for any function proper at almost every unit pair is the planner's own
generalization, recorded in `plans/FS124-derivation.md` § 1 and not entered."""

E1_HALF = MARK + """; source:
`data/fs124/reports/FS124-E2.md`, INVENTORY, "correction owed" — the second deriver's drafted line, verbatim):* "2026-10-07
(FS124-E2): fragment S1 meets the hypothesis, its set on the circle being the single point x; the conclusion holds there and
carries no arc (plans/FS124-E2-derivation.md, C124-LONE-EXISTS)." It corrects four places that stand above and below: this
entry's *not claimed* clause "that the class is inhabited at six (no held object meets the hypothesis)"; its *model* line's "none
is known"; "No held object meets C124-HALF's hypothesis" in § Theorems this phase proved; and "No held object meets its
hypothesis" in Stage 5's "Read against the card". The entry's statement, verdict, grade and count of minds are unchanged."""

E2_EDGE = MARK + """; source: the asking
lane's record `plans/POROS-2026-10-07-fs124-round2.md` § 1.2, the row "the strip's six tiles and the disk's pentagon are in no
valid map, under any colouring", and § 1.3, S5):* this entry's *prior art* line names FS112-EDGE and misses a held map statement
about the same six tiles — **FS114-Y-STRIPK6** (`plans/FS114-derivation.md`; row 138; [hand], two minds, blind): "In the strip's
geometry the six tiles at a valley `V_m` (the arches `U_{m−1}`, `U_m` and the top tile `T_m`) and at the apex of `U_{m+1}`
(`U_{m+1}`, `T_{m+1}`, `T_{m+2}`) pairwise straddle distance 1, so the two vertices are complementary under every colouring; …
so by FS112-N3-COR3 no valid map contains these six tiles, under any colouring". The asking lane (S5): "FS114-Y-STRIPK6 (maps,
whole tiles, every colouring) and C124-EDGE-CLOSED (every weak six-colouring, the tiles cut at the apex line, the strip's
colouring) do not cite each other." Neither statement is the other: the held one is about maps that contain the six whole
tiles, under every colouring; this one is about every weak six-colouring that keeps six cut pieces at the strip's own labels.
Which six tiles each names was not compared tile by tile by the record job. The entry's statement, verdict, grade and count of
minds are unchanged."""

F132_SHARP = MARK + """; sources:
`plans/FS124-E2-derivation.md`, the entry C124-FORCED-PIECES and Stage 5's "Read against the card"; `LEDGER.md` row 157's
sentence "Since FS-124's second round"):* **as stated, this entry's conclusion is met by a one-point set.** A compact set `K_j`
containing `x` may be `{x}` alone, and `x` lies on the unit circle about `w`. In the second deriver's words, C132-COMP-SHARP "is
the statement on exclusion sets, whose conclusion a one-point set satisfies" (C124-FORCED-PIECES, *prior art*); and fragment S1
is a held instance in this entry's setting — "S1 meets its hypothesis with the one-point set `{x}` as the set on the circle —
which is also why its conclusion there carries no arc" (said of C124-HALF, whose hypothesis is this entry's setting with exactly
one set on that circle). So the sentence above, "force one of the six edge sets onto the unit circle about each of their common
unit points", forces no arc where the set is a point. **The statement with content is on pieces** (C124-FORCED-PIECES; derived
from C124-TYPE, [hand], one mind, kernel pending; `plans/FS124-derivation.md` § 3): "Let c be a weak six-colouring of U, (x, y) a
close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then
x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc
about w; the edge of those two pieces lies on S(w)." For sector points an arc of an edge lies on that circle (C124-FORCED); for
three-piece points by the letter the arc form is refuted (C124-FORCED-AS-POSED: at a bowtie the edge of the two pieces can be the
member alone). This entry's statement, verdict, grade and count of minds are unchanged."""

F132_SQUARE = MARK + """; sources: `data/fs132/claims.md`,
the dated line "2026-10-07 (after FS132-K2's Stage 6, commit `34ba3019` on branch `fs132-wk1`; FS-132 inventory item 39)";
`plans/FS132-close-inventory.md` item 39, ruling (b)):* the comparison that the paragraph above says "nobody has done" has been
made, by the kernel planner's successor — "at the grade of a checking reading, one mind, with the argument open". It read the
first deriver's steps against its predecessor's route: the route is that deriver's steps S5 and S7 with S6 exchanged for this
library's covering theorem for the square, "and on this reading only S6 reads the region's shape … I see no step left to derive".
**The verdict stays "gap"** — "until a deriver's entry or a kernel proof stands" (the claim list); "C132-CORES-SQUARE stays a gap,
with the comparison on record as a checking reading" (ruling 39 (b)). A fact for whoever formalizes it, from the same line: "the
release's Lean mesh theorem refutes connected sets joining points more than 2 apart, where the hand argument proves every
threshold above 1; re-typed as it stands the kernel would hold a square of side above 2 — a disc of radius above √2, less than
C132-CORES-FREE claims". The entry's statement, verdict, grade and count of minds are unchanged."""

PLAN = [
    ("plans/FS124-E1-derivation.md", lambda L: after_entry(L, "C124-RADIUS-GRAPH"), E1_GRAPH),
    ("plans/FS124-E1-derivation.md", lambda L: after_entry(L, "C124-HALF"), E1_HALF),
    ("plans/FS124-E2-derivation.md", lambda L: after_entry(L, "C124-EDGE-CLOSED"), E2_EDGE),
    ("plans/FS132-derivation.md", lambda L: after_line(L, L.index("derivation: C132-COMP-SHARP"), "`plans/FS132-Z1-record.md` § 5."), F132_SHARP),
    ("plans/FS132-derivation.md", lambda L: after_line(L, L.index("derivation: C132-CORES-SQUARE"), "one short stage, that nobody has done. **Side: no side.**"), F132_SQUARE),
]
dry = "--dry" in sys.argv
for path, where, para in PLAN:
    f = ROOT / path
    L = f.read_text().split("\n")
    if any(para.split("\n")[1] in l for l in L):
        sys.exit("already appended in " + path)
    i = where(L)
    print(f"{path}: line {i + 1}, after: {L[i - 2][-70:]!r}")
    if not dry:
        L[i:i] = para.split("\n") + [""]
        f.write_text("\n".join(L))
