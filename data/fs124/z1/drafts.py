#!/usr/bin/env python3
"""FS124-Z1, stage 6: the front page's drafts, written to stdout.

Statements are read from plans/FS124-derivation.md (never typed); every quoted *not claimed*
phrase is asserted to be a substring of its entry; every slot's old words are asserted to
occur exactly once in CLAUDE.md on disk, and the net change in bytes is computed.
"""
import re, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
E = {}
cur = None
for line in (ROOT / "plans/FS124-derivation.md").read_text().splitlines():
    m = re.match(r"^derivation: (\S+)$", line)
    if m:
        cur = m.group(1); E[cur] = []
    elif cur and line.strip() == "":
        cur = None
    elif cur:
        E[cur].append(line)
def field(name, key):
    txt = "\n".join(E["C124-" + name])
    m = re.search(r"^  " + key + r": (.*?)(?=^  [a-z ]+: |\Z)", txt, re.S | re.M)
    return re.sub(r"\s+", " ", m.group(1)).strip()
S = lambda n: '"' + field(n, "statement") + '"'
def Q(name, phrase):
    assert phrase in re.sub(r"\s+", " ", " ".join(E["C124-" + name])), (name, phrase)
    return '"' + phrase + '"'

ROW161 = ("| 161 | **The disc criterion, in measure — weak six-colourings of the open discs of every radius give `χ(ℝ²) ≤ 6` with no import, and a disc "
 "with none gives seven over one declared outside theorem:** " + S("RADIUS-GRAPH") + " (C124-RADIUS-GRAPH; for a countable set with compact closure "
 "in the open set, C124-RADIUS-COUNTABLE). " + S("RADIUS-UP") + " (C124-RADIUS-UP). " + S("RADIUS-DOWN") + " (C124-RADIUS-DOWN, over the declared "
 "outside theorem `Outside.OAI158.proper_to_borel_weak`). So at each `k` the two hold together or fail together, and at six, with row 33, the plane "
 "needs seven colours precisely if some open disc has no weak measurable six-colouring. At five: " + S("RADIUS-FIVE") + " (C124-RADIUS-FIVE, over "
 "`Outside.OAI158.no_proper_five_coloring`). For a measurable weak colouring every direction is good: " + S("EVERY-DIRECTION") + " (C124-EVERY-DIRECTION). "
 "**Class:** every weak `k`-colouring of an open set, every `k ≥ 1`; no entry reads a number of labels. **Grade:** [hand] or derived from [hand] entries, "
 "one mind each, kernel pending. **Kernel-checked on a branch, not through the gate, not held** (`fs124-wk1`, 57 theorems): `colorable_iff_forall_ball` and "
 "`seven_le_chromaticNumber_plane_iff_exists_ball`, each on the standard three axioms and that one declared outside theorem; (up) and its contrapositive on "
 "the standard three alone. The kernel planner's own generalizations there are its module's, not entries: the colouring's measurability idle in the "
 "finite-set form, the countable form and (up); (down) for every subset. **Not claimed:** " + Q("RADIUS-UP", "an explicit radius at any k") + "; "
 + Q("RADIUS-UP", "that the hypothesis holds at k = 6") + "; " + Q("RADIUS-DOWN", "anything without that import") + " (C124-RADIUS-DOWN); "
 + Q("RADIUS-FIVE", "any value of R") + " (C124-RADIUS-FIVE). **Prior art:** partly — for a colouring of the whole plane the motion argument is "
 "`[GwynStavrianos2022]` Lemma 2 and this library's N-EASY; for arc maps of discs the conclusion is row 145's; the bounded case for proper colourings is "
 "Kruskal 2008 (Zbl 1139.05023, held at abstract); (down) is `[OAIMath2026]` family 158's transfer, restricted; the disc form for weak colourings not "
 "found in print. | `plans/FS124-derivation.md` § 1; `plans/FS124-E1-derivation.md` Stage 3; branch `fs124-wk1` | FS-124 (2026-10-07) |")

ROW162 = ("| 162 | **What an open piece of one label forces one unit away, in every weak colouring — the one lemma; its form for one connected piece and "
 "one side; and what one tight pair forces at its centre, beside its far end and at the opposite point, which is nothing beyond that first step:** "
 + S("SHADOW-OPEN") + " (C124-SHADOW-OPEN). " + S("TYPE") + " (C124-TYPE — by its deriver, row 157's C132-WITNESS followed by C132-WIT-SIDE in one "
 "statement). At a centre, collar by collar: " + S("CENTRE-HALF") + " (C124-CENTRE-HALF; for a tight pair, both halves: C124-CENTRE). " + S("STRADDLE")
 + " (C124-STRADDLE; at a rhombus completion, C124-COMPLETION). " + S("ANTIPODE") + " (C124-ANTIPODE). The conclusion at a completion "
 + Q("COMPLETION", "holds beside every interface between two open one-label pieces") + ": read by formula ([tools]), on R7 no completion of an interior far "
 "end centres a tight arc (0 of 6) and on FS-112's strip no end of a unit-arc piece centres one (0 of 92). **Class:** every weak `k`-colouring of an open "
 "set; **no entry spends a number of labels.** A calibration at seven: " + S("KIND") + " (C124-KIND). A count at a centre, at every `k ≥ 4` and over a class "
 "with no held member: " + S("SIX") + " (C124-SIX). **Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; C124-SHADOW-OPEN, "
 "C124-TYPE, C124-CENTRE-HALF, C124-CENTRE and C124-STRADDLE are in the kernel lane's second module, being planned. **Not claimed:** "
 + Q("SHADOW-OPEN", "anything for a set W that is not open") + "; " + Q("SHADOW-OPEN", "that any weak colouring has an open one-label set") + "; "
 + Q("TYPE", "anything for a piece that is not connected or not open") + "; " + Q("TYPE", "that any weak colouring has such a piece") + "; "
 + Q("SIX", "that the configuration exists at any k") + " (C124-SIX). **Prior art:** partly — the lemma is the second half of the argument of C132-SHADOW "
 "(row 157) and G84's shadow identity for an open piece; in the map class the centre's statement is row 138's cone form; for a weak colouring not found in "
 "print; the entries name their debts. | `plans/FS124-derivation.md` §§ 2, 5, 6; `plans/FS124-E1-derivation.md` Stages 4–5; `plans/FS124-E2-derivation.md` "
 "Stages 4–5 | FS-124 (2026-10-07) |")

V = field("FORCED-AS-POSED", "verdict")
ROW163 = ("| 163 | **What a close complementary pair forces at a common unit point, in measure — on pieces; with an arc where the members are sector "
 "points; by both members where they are full, at a point where exactly four labels are present; and the one exception, a member two of whose pieces meet "
 "at it only:** " + S("FORCED-PIECES") + " (C124-FORCED-PIECES — the statement with content of row 157's C132-COMP-SHARP, whose conclusion a one-point set "
 "meets). " + S("FORCED") + " (C124-FORCED). The same for every three-piece point by the letter is **refuted** (C124-FORCED-AS-POSED; its verdict: \"" + V
 + "\"). " + S("LONE") + " (C124-LONE), and that configuration exists: " + S("LONE-EXISTS") + " (C124-LONE-EXISTS: fragment S1 with a band). " + S("BOTH")
 + " (C124-BOTH). " + S("FOUR") + " (C124-FOUR). " + S("SECOND") + " (C124-SECOND). From exclusion sets, the first round's forms: C124-HALF and "
 "C124-HALF-TWO, over the inherited C132-WIT-SIDE (the second the upper bound of C124-FOUR). **Class:** three-piece points by the letter (C124-FORCED-PIECES, "
 "C124-LONE); full members (C124-BOTH's first sentence, C124-FOUR); sector points (C124-FORCED, C124-BOTH's second sentence, C124-SECOND). **Every entry "
 "spends six**; at seven the count fails: " + S("FORCED-SEVEN") + " (C124-FORCED-SEVEN). **Grade:** [hand] or derived from [hand] entries, one mind each, "
 "kernel pending; **a second mind is owed on C124-LONE's Step II**, on which C124-BOTH, C124-FOUR and C124-SECOND rest (its deriver's line; the kernel "
 "lane's second module is that mind, blind first); one topological input of C124-FORCED is recalled, not read. **Read on held objects** ([tools], one mind; "
 "C124-READ-SAVES): at every common unit point inside FS-112's strip and disk and FS-114's capped strip (71, 20, 71) one edge of each member lies on the "
 "point's unit circle and exactly four labels are present; fragments T2 and MX and the Searcher's kept model show two edges of one member, fragment BB none, "
 "fragment S1 a save by its bowtie alone; FS116-Y2-SIXFRAG has eighteen tight arcs of kind both and no close complementary pair. **Not claimed:** "
 + Q("FORCED-PIECES", "that a weak six-colouring has a three-piece point, or a close complementary pair") + "; " + Q("FORCED-PIECES", "anything with seven labels")
 + "; " + Q("SECOND", "that the saves close up along a chain of pairs; any exclusion") + " (C124-SECOND); " + Q("LONE-EXISTS", "a value of the chromatic number of the plane")
 + " (C124-LONE-EXISTS). **Prior art:** partly — for maps C124-BOTH is FS112-N3-COR3 (row 135; two minds, one blind): "
 + Q("BOTH", "this is its form for a weak measurable colouring and full three-piece points, by another route") + "; the bowtie as the exception is "
 "FS107-W-TAN's (row 133); not found in print. | `plans/FS124-derivation.md` §§ 3, 5–7; `plans/FS124-E2-derivation.md` Stages 3–6; "
 "`plans/FS124-E1-derivation.md` Stage 5 | FS-124 (2026-10-07) |")

ROW164 = ("| 164 | **FS-112's strip is closed at a point of its top edge against every weak six-colouring that keeps six named pieces — an exclusion of "
 "every weak six-colouring of a named open set by the open-piece lemma, local to one held family:** " + S("EDGE-CLOSED") + " (C124-EDGE-CLOSED): six uses of "
 "C124-TYPE (row 162) and exact comparisons in ℚ(√3, √15) bar all six labels on an open set near the point; nothing is assumed above the line `y = √15/4`. "
 "As posed, for a save by both members: C124-EDGE. **Class:** one held family — the strip at its own colouring; it spends six ("
 + Q("EDGE-CLOSED", "a seventh label takes the point") + "). **Grade:** [hand] with an exact check, one mind, kernel pending; it rests on C124-TYPE and on no "
 "entry of row 163. **Not claimed:** " + Q("EDGE-CLOSED", "anything about colourings that change the strip below y = √15/4") + "; "
 + Q("EDGE-CLOSED", "that no six-coloured object extends above the strip's top edge") + ". **Prior art:** partly — for extensions of the strip as a map that keep "
 "all its tiles, FS112-EDGE (row 136); the held map statement about the strip's six tiles is FS114-Y-STRIPK6 (row 138; two minds, blind) — no valid map "
 "contains them, under any colouring — and neither statement is the other; for every weak six-colouring, not found in print. | `plans/FS124-derivation.md` "
 "§ 4; `plans/FS124-E2-derivation.md` Stage 6 | FS-124 (2026-10-07) |")

CL = (ROOT / "CLAUDE.md").read_text()
def slot(title, old, new, where):
    assert CL.count(old) == 1, (title, CL.count(old))
    d = len(new.encode()) - len(old.encode())
    return (f"**{title}** — slot: `CLAUDE.md` {where}.\n\n*Replaces, exactly:*\n\n> {old}\n\n*With:*\n\n> {new}\n\n*Net change: {d:+d} bytes.*\n", d)

D = []
D.append(slot("The \"Last updated\" line",
 "Last filed: **FS-132, six by the nerve**, Derived (",
 "Last filed: **FS-124, the unit arc**, Derived (rows 161–164; `plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; "
 "no value moved; its first Lean module complete on a branch, its landing owed), its successor FS-136 named; before it **FS-132, six by the nerve**, Derived (",
 "§ Frontier, the italic line beginning \"*Last updated: 2026-10-07\""))
D.append(slot("The open-milestones paragraph",
 "**Opened 2026-10-07: FS-124, the unit arc** (`plans/STUB-q-ring.md`; Kooshi's choice), re-posed for every measurable colouring proper at almost every unit pair: what a tight unit pair passes on (`plans/POROS-2026-10-07-fs124-question.md`).",
 "**Derived 2026-10-07: FS-124, the unit arc** (`plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; rows 161–164; stub "
 "`plans/STUB-q-ring.md`; Kooshi's choice): what a boundary along a unit circle about a point one unit away forces in a measurable colouring proper at almost "
 "every unit pair that has the pieces concerned — and whether any has them is not its claim. Its first Lean module, the disc criterion, is complete on branch "
 "`fs124-wk1` (57 theorems; kernel-checked on a branch, not through the gate; its landing is owed); its second is being planned; Closed when its modules pass "
 "the gate. Its eight cases pass to its successor, **FS-136, the point across** (`plans/STUB-covering-pairs.md`), Not started.",
 "§ Paths forward, ranked, the paragraph \"**Open milestones.**\""))
D.append(slot("Item 31, its head",
 "(§ The aim; rows 131–160; FS-117,",
 "(§ The aim; rows 131–164; FS-117,",
 "§ Where the problem stands, item 31"))
D.append(slot("Item 31, a sentence added",
 "none produces a point with such data in an arbitrary colouring. What is open",
 "none produces a point with such data in an arbitrary colouring. At the unit arc itself (FS-124; rows 161–164; [hand], one mind each, kernel pending): "
 "`χ(ℝ²) ≤ 6` exactly when every open disc has a measurable six-colouring proper at almost every unit pair, the direction toward seven over the outside "
 "theorem on Borel transfer (row 161); one tight pair forces nothing beyond its first step (row 162); two three-piece points less than 2 apart on disjoint "
 "triples force a piece of one of them inside and another outside the unit circle about each common unit point — of both where both are full, at a point of "
 "exactly four labels, and one member pays alone only where two of its pieces meet at it only (row 163); FS-112's strip is closed at a point of its top edge "
 "against every weak six-colouring keeping six of its pieces (row 164). A statement that reads pieces at named points does cross the unit arc; none gives a "
 "colouring a piece. What is open",
 "the same item, after the sentence ending \"in an arbitrary colouring.\""))
D.append(slot("Item 31, its last sentence",
 "now the unit arc in measure (FS-124),",
 "now the point across a ring's covering pair (FS-136, FS-124's successor),",
 "the same item"))
D.append(slot("The ledger's pointer",
 "**Rows 1–160 live in `LEDGER.md`**",
 "**Rows 1–164 live in `LEDGER.md`**",
 "§ The novel-results ledger"))
AIM_OLD = "or valid fragments on discs of every radius (row 145)."
AIM_NEW = ("or valid fragments on discs of every radius (row 145) — in measure, exactly: `χ(ℝ²) ≤ 6` iff every open disc has a measurable six-colouring proper "
 "at almost every unit pair, toward seven over the outside theorem on Borel transfer (row 161; [hand], one mind; kernel-checked on a branch).")
D.append(slot("§ The aim, the fifth point — if the coordinator judges the disc criterion belongs there", AIM_OLD, AIM_NEW, "§ The aim, point 5"))
total = sum(d for _, d in D)
K1 = ("On discs (`Plane/RadiusOutside`): `seven_le_chromaticNumber_plane_iff_exists_ball` — `7 ≤ χ(ℝ²)` exactly when some open disc about the origin has no "
 "weak measurable six-colouring — and `colorable_iff_forall_ball` at every `k`. *Seven gives such a disc* is the contrapositive of `radius_up` "
 "(`exists_radius_of_not_colorable`) and rests on the standard three axioms; *such a disc gives seven* is the contrapositive of `radius_down` and rests on "
 "the declared outside theorem `Outside.OAI158.proper_to_borel_weak`. So an exclusion on a disc reaches seven only through the transfer, and weak "
 "six-colourings of every disc reach six with no import.")
print("### `LEDGER.md` — four rows, 161 to 164\n")
print("*Slot: `LEDGER.md`, the table of rows, after row 160. Each row is one line. Statements are copied by script from "
      "`plans/FS124-derivation.md`; every quoted *not claimed* phrase is checked to be in its entry (`data/fs124/z1/drafts.py`).*\n")
for r in (ROW161, ROW162, ROW163, ROW164):
    print(r + "\n")
print("*Bytes: " + ", ".join(f"row {161 + i}: {len(r.encode())}" for i, r in enumerate((ROW161, ROW162, ROW163, ROW164))) + ".*\n")
print("### `CLAUDE.md` § Frontier and § The aim\n")
print(f"*`CLAUDE.md` on disk is {len(CL.encode())} bytes (budget 80,000). Each slot's old words occur exactly once on disk (asserted by the script). "
      f"All seven drafts together: {total:+d} bytes, to {len(CL.encode()) + total}; without the last (§ The aim): {total - D[-1][1]:+d}.*\n")
for t, _ in D:
    print(t)
print("**Held for the landing of branch `fs124-wk1`, not for this filing** — slot: `CLAUDE.md` § Where the problem stands, after the sentence on "
      "`seven_le_chromaticNumber_plane_iff`; the first kernel planner's draft (its record § 4.4, on that branch), verbatim:\n\n> " + K1 +
      f"\n\n*Net change when filed: {len(K1.encode()) + 1:+d} bytes. When it is filed, the clause added to § The aim above loses \"kernel-checked on a branch\".*\n")
