#!/usr/bin/env python3
"""FS136-Z1 (Done means 6): the drafts for the front page, built by script so that every statement is verbatim and
every slot is exact.  Statements are read from plans/FS136-derivation.md (`statement:` fields); each replacement's
"replaces" text is asserted to occur exactly once in its target file, and its net change in bytes is computed.
    python3 data/fs136/z1/drafts.py        # writes data/fs136/z1/drafts.md and prints the byte table
"""
import re, pathlib, sys
ROOT = pathlib.Path(__file__).resolve().parents[3]
DER = (ROOT / "plans/FS136-derivation.md").read_text()


def field(entry, name):
    m = re.search(rf"^derivation: {re.escape(entry)}\n((?:  .*\n)+)", DER, re.M)
    assert m, entry
    f = re.search(rf"^  {name}: (.*)$", m.group(1), re.M)
    assert f, (entry, name)
    return f.group(1)


def st(entry):
    return '"' + field(entry, "statement") + '"'


def nc(entry, frag):
    assert frag in field(entry, "not claimed"), (entry, frag)
    return '"' + frag + '"'


def once(path, text):
    s = (ROOT / path).read_text()
    n = s.count(text)
    assert n == 1, (path, n, text[:70])
    return s


OUT, BYTES = [], []


def repl(n, path, where, old, new):
    once(path, old)
    d = len(new.encode()) - len(old.encode())
    BYTES.append((n, path, d))
    OUT.append(f"**Draft {n} — `{path}`, {where}.** *Replaces* (occurs once):\n\n> {old}\n\n*with:*\n\n> {new}\n\n*Net change: {d:+d} bytes.*\n")


def after(n, path, where, anchor, new):
    once(path, anchor)
    d = len(new.encode()) + 1
    BYTES.append((n, path, d))
    OUT.append(f"**Draft {n} — `{path}`, {where}.** *Follows* the line that begins (occurs once):\n\n> {anchor}\n\n*New text:*\n\n{new}\n\n*Net change: {d:+d} bytes.*\n")


# ------------------------------------------------------------------ LEDGER.md rows 165-167
ADDR = "`plans/FS136-derivation.md`"
row165 = (
 "| 165 | **The table at a point with pieced points on its unit circle, in every weak colouring that has the pieces; the count it gives for two "
 "families and for one, on labels; and the bound on a sector point's partners:** " + st("C136-TABLE") + " (C136-TABLE — the head; no number of labels "
 "is read). " + st("C136-COVER") + " (C136-COVER; the claim as posed, \"has an inner and an outer piece\", is its case with a conclusion that one "
 "one-label region cut in two along the circle meets). " + st("C136-ONE") + " (C136-ONE). " + st("C136-PARTNERS") + " (C136-PARTNERS). "
 "**Class:** every weak `k`-colouring of an open set with the named pieces — **no entry says a weak six-colouring has a piece**; the two counts "
 "are stated at six and read \"all the labels\" (the tight seven-colouring R7 obeys them at seven: two adjacent lattice points carry all seven); "
 "sector points (C136-PARTNERS). **Grade:** [hand] (C136-TABLE, over row 162's C124-TYPE) and derived from it, one mind each, kernel pending. "
 "C136-TABLE was reached on one route by two jobs — this milestone's first deriver and the kernel planner of FS-124's second module, blind, at "
 "one member — \"Not two independent derivations: same lemma, same step\"; it counts as one mind, and its one-member form "
 "(`ae_onSide_of_label`) is kernel-checked on a branch, not through the gate. C136-PARTNERS is [hand] over row 163's C124-BOTH, second sentence "
 "(one mind; in the kernel on a branch for arc-edged decompositions only, a gap for sector points at one named step). **Read on held objects** "
 "([tools], floats, one mind): \"0 violations of the table at 359 inside points (263 on the six-coloured objects, the capped strip not counted "
 "beside the strip, and 96 on R7 at seven)\". **Not claimed:** " + nc("C136-TABLE", "that a weak colouring has a piece") + "; "
 + nc("C136-TABLE", "a converse — a label left at every cell does not give a colouring") + "; "
 + nc("C136-COVER", "that separation suffices for w to be coloured") + "; "
 + nc("C136-PARTNERS", "anything for a member of four or more labels, or a three-piece point that is not a sector point") + ". "
 "**Prior art:** known for maps — the covering pair and the count are FS-110's (FS110-N-SEAM with N-E2, two minds, one blind; FS110-CALC's "
 "A-EXACT, three minds; rows 133–134), and the partners FS112-C-PARTNERS's (one mind); the one-point form is partly FS116-N2-SIXRING's (one "
 "mind, non-Siamese); in measure the count for two disjoint triples is row 163's C124-FORCED-PIECES; for weak colourings with any number of "
 "members, pieces and labels, not found in print. | "
 + ADDR + " §§ 1, 5, 6; `plans/FS136-E1-derivation.md` Stages 2–4 | FS-136 (2026-10-07) |")
row166 = (
 "| 166 | **The table run forward — a corner on which the pieces one unit away leave one label has that label; what a seed forces is labelled "
 "corners at isolated points, never a region; and a point that carries all the labels but one forces the missing label on one-sided collars of "
 "arcs of its unit circle:** " + st("C136-FORCED") + " (C136-FORCED; over two lemmas of plane geometry — unit circles through a point cut `2m` "
 "connected corners there, C136-CORNERS; a corner is inner, outer or crossing by the cyclic order of curves by direction and then signed "
 "curvature, C136-CLASS). " + st("C136-CLOSE") + " (C136-CLOSE). " + st("C136-COLLAR") + " (C136-COLLAR). **Computed, exactly, by forced steps "
 "only** (grade: computed over the named corners): " + st("C136-CLOSE-R7") + " (C136-CLOSE-R7 — a calibration at seven: tight is not rigid for "
 "forced corners). On the flower the pair at `e(180°)`, `e(270°)` forces six corners at two points in the fragment's disc and stalls, and on "
 "FS-112's strip two four-label points force ten corners at six points and stall, while its pair of three-label points forces nothing "
 "(C136-CLOSE-FLOWER, C136-CLOSE-STRIP; two readings inside the strip's are floats). **Every closure computed stalls within two steps; none "
 "empties a corner beyond its pair's own common unit points; a label is forced along arcs on one held object only** — the bowtie fragment's two "
 "five-label points, four arcs of 60°. **Class:** every weak `k`-colouring of an open set that has the named pieces or labelled corners; no "
 "number of labels is read but \"all the labels but one\" by the collar. **No weak six-colouring is known to have a piece, a corner or a point "
 "of five labels: no entry gives a colouring a first piece, none excludes a colouring of a disc, none bears on the value.** **Grade:** [hand] "
 "(C136-FORCED over row 165's C136-TABLE; the two lemmas) and derived from it, or computed over named corners in exact arithmetic; one mind "
 "each, kernel pending. **Not claimed:** " + nc("C136-CLOSE", "no region of definite size is forced, and a closure all of whose corners at every point reached are forced is a set of vertex figures, not a coloured fragment")
 + "; " + nc("C136-COLLAR", "any width — η depends on w and on c and is bounded below by nothing, at the ends of A or anywhere along it") + "; "
 + nc("C136-COLLAR", "what V bars one unit further on (a fact about its extent; not computed here)") + "; "
 + nc("C136-CLOSE", "a converse — a seed whose closure empties no corner need not be had by any colouring") + ". "
 "**Prior art:** partly — for palettes at the hubs of one ring the forward step is a step inside row 155's C132-M-ORBIT argument, never an "
 "entry; for maps it is placing (G91; row 147; the map entries named, not read) and, at a five-colour vertex, FS116-N2-FIVERING (read at its "
 "statement only); for pieces, not found in print. | " + ADDR + " §§ 2–3; `plans/FS136-E2-derivation.md` Stages 2–5, 8; `data/fs136/e2/closure.py` | FS-136 (2026-10-07) |")
row167 = (
 "| 167 | **The four held stops — each held six-coloured object stops at a point one unit from two of its vertices whose labels are all six, and "
 "each stop is excluded for the weak six-colourings that keep the corner patterns of named tiles at those two vertices; exclusions local to one "
 "held family, none of a colouring of a disc:** " + st("C136-STOP-GERMS") + " (C136-STOP-GERMS). At first order: " + st("C136-STOP-GERMS-RADIUS")
 + " (C136-STOP-GERMS-RADIUS). The flower: " + st("C136-STOP-FLOWER-GERMS") + " (C136-STOP-FLOWER-GERMS; one label is barred there only at second "
 "order). **Corollaries, on whole tiles** (derived first, from row 165's table): C136-STOP-STRIP, C136-STOP-DISK, C136-STOP-BOWTIE (eight "
 "tiles), C136-STOP-FLOWER. On the bowtie fragment a second form is held beside the germ form, and neither contains the other: "
 + st("C136-STOP-BOWTIE-SIX") + " (C136-STOP-BOWTIE-SIX; the first deriver's dated note, entered at the record job). The four points are exact "
 "(C136-RINGS-READ): at squared distance `(7 + 3√5)/4`, `(3 + √5)/2`, `3`, `3` from the strip's, the disk's, the flower's and the bowtie "
 "fragment's centres. **Class:** one held family each — the strip (six tiles), `[Polymath2021]`'s disk (six), FS114-Y2-BOWTIE (eight; six used), "
 "FS116-Y2-SIXFRAG (six) — at the object's own labels; each spends six. **A held stop is a fact about two vertex figures**: the corners at the two "
 "vertices already leave a corner beside the stop with no label, and extent only adds bars. **Grade:** derived from row 166's C136-CLOSE or row "
 "165's C136-TABLE with exact signs in each object's own number field; C136-STOP-GERMS-RADIUS [hand]; one mind each, kernel pending. **Read on "
 "the objects** ([tools], floats, the asking lane's reader): all 70 stops of the four objects keep an empty cell by germs. **Not claimed:** "
 + nc("C136-STOP-GERMS", "any exclusion of a colouring that does not keep these parts; a value of the chromatic number of the plane; that a weak six-colouring has these corners")
 + "; " + nc("C136-STOP-FLOWER", "no statement about every weak six-colouring of a disc") + "; "
 + nc("C136-STOP-GERMS-RADIUS", "the best constants, or any explicit one") + ". **Prior art:** known for maps — FS114-Y-STRIPK6 (row 138) and "
 "FS114-Y-PENT (two minds each, blind), FS114-Y3-RSTOP (two minds; its \"cone (−60°, 60°)\" is the corner emptied here), FS112-STOP (two minds, "
 "one blind), FS116-Y2-SIXOFF (one mind); in measure row 164's C124-EDGE-CLOSED closes the strip's point with other kept sets and three members — \"neither "
 "statement contains the other\"; for weak colourings keeping germs, not found in print. | " + ADDR + " §§ 4, 6; `plans/FS136-E2-derivation.md` Stage 6; "
 "`plans/FS136-E1-derivation.md` Stages 2, 5 | FS-136 (2026-10-07) |")
for q in ("Not two independent derivations: same lemma, same step", "neither statement contains the other"):
    pass
L = (ROOT / "LEDGER.md").read_text()
assert L.count("\n| 164 |") == 1 and "\n| 165 |" not in L
OUT.append("### `LEDGER.md`\n\n**Draft 1 — `LEDGER.md`, the table of rows: three new rows, placed directly after the row that begins `| 164 |` "
           "(the last row of that table).** Each is written as it should stand.\n")
for r in (row165, row166, row167):
    OUT.append(r + "\n")
BYTES.append((1, "LEDGER.md", sum(len(r.encode()) + 1 for r in (row165, row166, row167))))
OUT.append(f"*Net change: {BYTES[-1][2]:+d} bytes (not a budgeted file).*\n")

# ------------------------------------------------------------------ CLAUDE.md § Frontier
OUT.append("### `CLAUDE.md` § Frontier\n")
repl(2, "CLAUDE.md", "§ Frontier, the \"Last updated\" line",
     "Last filed: **FS-124, the unit arc**, Derived (rows 161–164; `plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; no value moved; its first Lean module, the disc criterion, through the gate, FS124-L1), its successor FS-136 opened; before it",
     "Last filed: **FS-136, the point across**, Derived (rows 165–167; `plans/FS136-derivation.md`, 21 entries, each derived; [hand] or computed exactly over named corners, one mind each, kernel pending; every statement is about colourings that already have named regions or corners; no value moved), its successor FS-137 minted; before it **FS-124, the unit arc**, Derived (rows 161–164; `plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; no value moved; its first Lean module, the disc criterion, through the gate, FS124-L1); before it")
repl(3, "CLAUDE.md", "§ Where the problem stands, item 31's head", "(§ The aim; rows 131–164; FS-117,", "(§ The aim; rows 131–167; FS-117,")
repl(4, "CLAUDE.md", "§ Where the problem stands, item 31, after the sentences on FS-124",
     "A statement that reads pieces at named points does cross the unit arc; none gives a colouring a piece. What is open is this item's question at six;",
     "A statement that reads pieces at named points does cross the unit arc; none gives a colouring a piece. At a point with pieced points on its unit circle (FS-136; rows 165–167; [hand] or computed exactly, one mind each, kernel pending): almost every point near it has a label that is pure, on that point's side, at each of them that carries it, so of two such points whose labels are all six one has a label wholly inside and another wholly outside the unit circle about each common unit point (row 165); the strip, the disk, the flower and the bowtie fragment each stop at such a point, and each stop is excluded for the weak six-colourings that keep the corner patterns of named tiles at its two vertices (row 167); run forward, a corner with one label left has it, a seed of points with three or four labels forces corners at isolated points and never a region — every closure computed stalls within two steps — and a point carrying five labels forces the sixth on a one-sided collar of each arc of its unit circle along which none of the five is pure on that side (row 166). Each starts from regions or corners somebody keeps; none excludes a colouring of a disc. What is open is this item's question at six;")
repl(5, "CLAUDE.md", "§ Where the problem stands, item 31's last sentence",
     "now the point across a ring's covering pair (FS-136, FS-124's successor),",
     "open as FS-124 left them, with what a five-label point's collars force (FS-137, FS-136's successor, unranked),")
repl(6, "CLAUDE.md", "§ The novel-results ledger", "**Rows 1–164 live in `LEDGER.md`**", "**Rows 1–167 live in `LEDGER.md`**")
repl(7, "CLAUDE.md", "§ Paths forward, the open-milestones paragraph",
     "Its eight cases pass to its successor, **FS-136, the point across** (`plans/STUB-covering-pairs.md`), Opened 2026-10-07.",
     "Its eight cases passed to its successor and are open. **Derived 2026-10-07: FS-136, the point across** (`plans/FS136-derivation.md`, 21 entries, each derived; [hand] or computed exactly over named corners, one mind each; rows 165–167; stub `plans/STUB-covering-pairs.md`): what the regions at the points one unit from a point force there, in a measurable colouring proper at almost every unit pair that has those regions — the table, the two counts, the four held stops by two vertex figures, the forward step with its closure, the collar — and whether any colouring has them is not its claim. Nothing of it is in the kernel. Its Lean phase would state first the head statement over finitely many members, the label form of the count, the one-point form and the forward step on a cell — each a few lines over `ae_onSide_of_label`, which is kernel-checked on a branch in FS-124's second module — and the collar and the exclusions only with a consumer; Closed when its module passes the gate. Its successor, **FS-137, collars** (`plans/STUB-collars.md`), is minted, unranked.")
repl(8, "CLAUDE.md", "§ Paths forward, the ranked table, row 1 (the whole row)",
     [l for l in (ROOT / "CLAUDE.md").read_text().split("\n") if l.startswith("| 1 | **FS-136 the point across**")][0],
     "| 1 | **FS-136 the point across** — `plans/STUB-covering-pairs.md` (Derived 2026-10-07; kernel pending; the asking lane re-ranks at its next job) | run forward, how far do the regions at two pieced points whose labels are all six force a weak six-colouring — to a corner with no label, a corner with a choice, or round a ring? Answered on every seed tried: a stall at a choice within two steps. Every held stop is such a pair's second common unit point and is closed by the two vertex figures | the local half of both roads from a two-point seed: an empty corner would be an exclusion for colourings with the seed (seven only with a seed for every colouring); a closure is corners at points, never a fragment; a stall is a design's free choices; its successor **FS-137 collars** (`plans/STUB-collars.md`) — what a five-label point's collars force — sits unranked below the ranked rows until the asking lane ranks it |")
C = (ROOT / "CLAUDE.md").read_text()
tot = sum(d for n, p, d in BYTES if p == "CLAUDE.md")
OUT.append(f"**`CLAUDE.md` in all: {tot:+d} bytes — {len(C.encode())} → {len(C.encode()) + tot} of 80,000.**\n")
(ROOT / "data/fs136/z1/drafts.md").write_text("\n".join(OUT))
for n, p, d in BYTES:
    print(f"draft {n}: {p} {d:+d} bytes")
print(f"CLAUDE.md total {tot:+d}: {len(C.encode())} -> {len(C.encode()) + tot}")
