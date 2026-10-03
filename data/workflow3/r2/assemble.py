#!/usr/bin/env python3
"""R2's re-rank, assembled mechanically so Keryx can file it as it stands (R1's assembler, data/workflow3/r1/assemble.py, adapted).

Reads the ranked table of plans/FRONTIER-STUBS.md and the Paths-forward table of CLAUDE.md as they stand at R2's launch (FRONTIER-STUBS.md
unchanged since R1's filing), applies R2's draft (six new rows, two rows removed to the closed list, amended cells, the new order), checks the
FS numbers, and writes:
  data/workflow3/r2/ranked-table.md          the full ranked table for plans/FRONTIER-STUBS.md (73 rows)
  data/workflow3/r2/claude-paths-forward.md  the ten rows and the group row for CLAUDE.md § Paths forward, with its net bytes
  data/workflow3/r2/solver-reading.md        per ranked stub: does its next step want a solver, read as of 2026-10-03
Run from the repository root:  python3 data/workflow3/r2/assemble.py [--self-test]
--self-test plants a duplicate FS number, a lost row, an amendment whose text is absent and an unescaped pipe inside a cell, and requires all four to be refused.
"""
import re, sys

FRONT = "plans/FRONTIER-STUBS.md"
CLAUDE = "CLAUDE.md"
OUT_T = "data/workflow3/r2/ranked-table.md"
OUT_C = "data/workflow3/r2/claude-paths-forward.md"
OUT_S = "data/workflow3/r2/solver-reading.md"

R2 = "`plans/POROS-2026-10-03-close-reread.md` § 2.5"

NEW = {  # FS number -> the row's cells after the rank (stub | question | bearing | cost | status | solver)
123: "**FS-123 the (Q)-free ring** — `plans/STUB-qfree-ring.md` (minted 2026-10-03 by FS116-Z2; FS-116's successor; route M's first half) | does any vertex of at least four colours whose ring carries no (Q) arc survive past radius `1 + ε`? The Γ-free type is empty there (FS116-Y4-EMPTY, held: two minds, the second blind, the same model; non-Siamese, simple). First, whether a fragment bent on a neighbourhood of `B̄(p, 1 + ε)` stays in EMPTY's class: side 1 of the bends signal names no ring type (`plans/FS114-NB6-verification.md` ll. 104–108), so a yes leaves every ring of C114-LOCAL-F's class its (Q) arcs plus finitely many points, closing this stub's half and deleting the change points that end non-(Q) arcs from FS-124 (R2's card 1, " + R2 + "). Then the (R2)-arc ring directly, OC and the semi-hub sharing its tip (FS116-Y4 § 3.4; V6-HUG's identity, R2's card 2); then EMPTY's Siamese and non-simple forms. No inhabitant of the (Q)-free class has been held (FS114-Y2-BOWTIE's ring carries two (Q) arcs, `plans/FS116-Z1-close.md` § 2.4 F1); fix FS-112's reading of \"(Q)\" first (NB6 ll. 109–111 record two) | a necessary piece of C114-LOCAL-F, so of seven: fragments about such vertices on discs of every radius give `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held); with FS-124 and the Siamese rungs it is C114-LOCAL-F, which answers `[SokolovVoronov2025]` Question 2's unit-arc half and with route M's map step gives `χ(ℝ²) = 7` given MR. Its first question decides the shape of the whole remaining case list, FS-124's included; in route M's saturated class FS-126's NO deletes the same (R2) arcs (FS121-Z1-NOCURVED, one mind) | unpriced (counter-priors, rule 1) | minted 2026-10-03 | no solver wanted: derivation, reading, exact fragments by formula; FS-116's list § 9 (no enumeration of maps, colourings, tile graphs, ring types) binds it through its stub",
124: "**FS-124 the (Q) ring** — `plans/STUB-q-ring.md` (minted 2026-10-03 by FS116-Z2; FS-116's successor; route M's first half) | does every vertex of at least four colours whose ring carries (Q) arcs, and every vertex of five or six colours, die within an explicit radius? The placing rule is derived (FS116-RING-GERM and FS116-N3-SEMI held; the assembled rule FS116-RING-TRANSFER-QC one mind). Left: SEMI-PAR3 (the full parallel semi-hub of three colours, the rule's one exception), the disk's corner (RING-Q false below `≈ 1.5985`, FS116-N1-QDISK), crossed reciprocity, the five- and six-colour vertices (FS116-Y2-SIXFRAG holds every disc below `3/2`, exact), the recurrence (FS116-N2's Kneser reading), FS114-K1's (Q) residues, DISC-F and LOCAL-DENSE, the Siamese class last. Its case list depends on FS-123's first question; V6-HUG's identity ranks first here at the semi-hub sharing its tip (R2's card 2) | the main remaining case set of C114-LOCAL-F and the YES side's home: every held positive past `√3` has (Q) arcs on its four-colour rings (row 136); a NO here with FS-123's is C114-LOCAL-F (`[SokolovVoronov2025]` Question 2's unit-arc half; with route M's map step, `χ(ℝ²) = 7` given MR); valid fragments about (Q)-ring vertices on discs of every radius give `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held). Each case alone is a piece | unpriced | minted 2026-10-03 | no solver wanted: derivation, exact fragments by formula; FS-116's list § 9 binds it through its stub",
125: "**FS-125 the saturated local exclusion** — `plans/STUB-saturated-local.md` (minted 2026-10-03 by FS116-Z2; route M's honest branch) | NO-SAT: an explicit radius about a four-colour vertex within which no valid fragment saturated one unit inside exists. Held: every edge at a four-colour vertex of a saturated fragment is split or tangent (FS116-O1-SATPIN, in its corrected wording). The right-angled straight cross on a (Q)-free ring dies at `R = 2`, non-Siamese (FS116-S1-QF: two derivations, the second told the verdict; its blind second mind first). Then SAT-STRIP's G3, G1, G2, SAT-QFREE's touch point, SATPIN-PER, NO-SAT, Y-SAT (the strip family saturates to `≈ 0.491` at most). Given FS-126's NO its rings carry no (R2) arc (FS121-Z1-NOCURVED, one mind) | route M's first half in the class its honest branch consumes, weaker than C114-LOCAL-F: NO-SAT with FS-128's TOP₆ and FS-126, FS-127 gives `χ_m⁰(ℝ²) = 7`, so `χ(ℝ²) = 7` given MR; necessary for seven, its failure (saturated fragments on discs of every radius) gives `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held); it un-parks the cover route (FS121-C1-SAT, held) | unpriced | minted 2026-10-03 | no solver wanted: derivation, exact fragments by formula; FS-116's list § 9 binds it through its stub",
126: "**FS-126 curved pencils** — `plans/STUB-curved-pencils.md` (minted 2026-10-03 by FS121-Z1; FS-121's successor; route M's honest branch) | can an honest saturated REG-J′ colouring, with any number of colours, have a curved tangent-type interface arc of finite radius? A NO, cusps allowed, makes C121-R2-FOUR vacuous, gives C121-NOLRA and deletes every (R2) arc from route M's maps (FS121-Z1-NOCURVED, one mind); a cocompact symmetry allows none (FS121-V5-SYM-CPT, one mind). The class has no held inhabitant: first an inhabitant by formula at some `k ≥ 7`, or an obstruction (R2's card 3), then the transverse subdivision, the open step (FS121-D1-VT held). FS-115's measurable question, thin pencils, lives here | none alone; a colour-generic rung of route M's honest branch, smaller than the answer: with FS-127, FS-128 and FS-125's NO, `χ(ℝ²) = 7` given MR. A YES at `k ≥ 7` refutes nothing at six (W-NEG), but it says the honest route cannot take its map step colour-blind and returns C121-NOLRA and C121-R2-FOUR to separate questions | unpriced | minted 2026-10-03 | no solver wanted: derivation, constructions by formula with exact checks (an inhabitant is aperiodic, FS121-V5-SYM-CPT)",
127: "**FS-127 lateral extent** — `plans/STUB-lateral-extent.md` (minted 2026-10-03 by FS121-Z1; FS-121's successor; route M's honest branch) | is the singular set of every honest saturated colouring of the plane locally finite (C121-REGJ)? It holds on grid colourings with countable breakpoints (FS121-D4-GRID, held, its second mind given FACE by name); the obstruction is the unit circle's sagitta (FS121-D4-FACE, held: a flat side facing a same-colour piece of half-width `ρ` across `g` with `2g < ρ²` loses its contact). Open: LAT, point-like accumulation of pieces shrinking faster than the square root of their gaps — first an inhabitant at some `k ≥ 7` by formula, or an exclusion. A fall colouring with a Cantor pinch would refute it (FS121-D4-FALL, one mind; FS-120) | none alone; a colour-generic rung: REG-J′ is one of the honest route's three conditions for the map step at six (FS111-M2-REDUCE-A); a wild singular set at any `k ≥ 7` would say the honest route needs regularity it cannot get colour-blind | unpriced | minted 2026-10-03 | no solver wanted: derivation, constructions by formula with exact checks",
128: "**FS-128 the six-colour rungs** — `plans/STUB-top-colour.md` (minted 2026-10-03 by FS121-Z1; FS-121's successor; route M's map step at six) | TOP₆: can the largest colour of a Grundy six-colouring obtained from a tight one be bound too (honest saturation at six, C121-SAT6)? And C121-NOPAR-C5, the cover route's NO under Condition 5, where row 134's chain stops at the vertex data and at N4-FIN's strictness, which smooth horns lack (FS121-C1-FLAT, held). First, whether TOP₆ is G13's coverage question at the top colour's boundary circles, which FS-121's three attempts never asked (`plans/FS121-Z1-close.md` § 4.1; R2's card 4). The cover route stays parked behind FS-116's NO-SAT, now FS-125's (Kooshi's to overturn) | at six and next to the answer: given a NO for honest saturated colourings, C121-SAT6 is the answer (FS121-D3-EQ, one mind), so TOP₆ is a procedure that spends six or seven restated; NOPAR-C5 is a NO for a class of maps, smaller than the answer, at six by nature; both hold vacuously under seven | unpriced | minted 2026-10-03 | no solver wanted: derivation",
115: "**FS-115 the stuck ray** — `plans/STUB-stuck-ray.md` (minted 2026-09-27 by FS112-C; re-aimed 2026-09-28 at FS-114's and FS-111's closes; demoted 2026-10-03, R2) | (b′) can a one-sided chain of stuck vertices live in a valid map with unit arcs — its extremal form a pencil of circles of radius `k + 1`, a ray needing arcs of every radius `≥ k + 1` (FS112-N3-CHAINS)? (b″) are finite stuck chains bounded? (c) does the single-vertex bowtie end live in a valid map? Its measurable question, whether FS-111's large-radius accumulation is this ray, was re-posed at FS-121's close as thin pencils and moved inside FS-126 (\"the line form is not needed\", its FS-121 bearing line) | none on the answer: after FS114-CV-EXISTS the NO needs no ray step, so (b′) and (b″) bear only on GS-4's density form (row 137); its live bearing, ¬LRA, is FS-126's since FS-121's close; its fragments (the pencil, BOWTIE) stay local positives a YES could use | unpriced | minted 2026-09-27; re-aimed 2026-09-28 (R1); demoted 2026-10-03 (R2; its banner) | in-ban: derivation, exact chain fragments by formula",
}
ORDER_TOP = [123, 124, 104, 125, 122, 128, 126, 127, 120, 117]  # ranks 1-10; then old ranks 8.. in order, FS-115 placed after FS-62
REMOVED = {116, 121}
AFTER = (62, 115)  # FS-115 re-inserted directly after FS-62

AMEND = [  # (FS number, old text, new text): exact, each must occur once in its row
(104, "at FS-114's and FS-111's closes (2026-09-28, R1) below route M's pair, FS-116 and FS-121;",
      "at FS-114's and FS-111's closes (2026-09-28, R1) below route M's pair, FS-116 and FS-121, and at theirs (2026-10-03, R2) below FS-123 and FS-124, FS-116's successors;"),
(122, "and a robust form of `[SokolovVoronov2025]` Lemma 6.1's count; HX's complementary blocking pairs (FS111-W-HX-PAIRS)",
      "and a robust form of `[SokolovVoronov2025]` Lemma 6.1's count; HX's complementary blocking pairs (FS111-W-HX-PAIRS). A datum for R1's carried card: FS116-Y4-EMPTY's kill closes on V6-HUG's identity, a deficit of order `st` in the hug lengths, which nothing in its class bounds below (FS116-Z2, one mind); so a kill by it survives a band of slack `ε` only where the hug lengths are of order `√ε` (R2, " + R2 + ", card 2)"),
(120, "none alone: the colour-generic finiteness rung both of FS-121's top rungs need (REG-J′-C₅ at five, REG-A₆ at six);",
      "none alone: the colour-generic finiteness rung both of FS-121's top rungs need (REG-J′-C₅ at five, REG-A₆ at six), now FS-127's: a fall colouring with a pinch no move removes refutes C121-REGJ (FS121-D4-FALL, one mind);"),
(117, "(minted 2026-09-28 by FS114-C; FS-116's sibling)", "(minted 2026-09-28 by FS114-C; FS-116's sibling, and FS-123's and FS-124's)"),
(117, "(K1 shared with FS-116)", "(K1 shared with FS-123 and FS-124)"),
(117, "its charge says which configurations FS-116 must exclude, and a torus YES would be FS-116's YES",
      "its charge says which configurations FS-123 and FS-124 must exclude, and a torus YES would be theirs; its (Q)-free case has no instance in the Γ-free type at `1 + ε` (FS116-Y4-EMPTY, held), and none at all if a fragment's bends keep the class (FS-123's first question)"),
(101, "(seven through route M: rows 134–138 with FS-116 and FS-121; six by FS-104)",
      "(seven through route M: rows 134–138 with FS-116's and FS-121's rows and their successors; six by FS-104)"),
(101, "FS-113 (rank 12)", "FS-113 (rank 15)"),
(41, "least eigenvalue −|S|/(k−1)", "least eigenvalue −\\|S\\|/(k−1)"),
(65, "`|Aut| = q²(q+1)·2`", "`\\|Aut\\| = q²(q+1)·2`"),
]

CNEW = {  # CLAUDE.md short rows: stub | question | bearing
123: "**FS-123 the (Q)-free ring** — `plans/STUB-qfree-ring.md` (FS-116's successor) | does a four-colour vertex whose ring carries no (Q) arc survive past `1 + ε`? The Γ-free type is empty there (FS116-Y4-EMPTY, held). First: does a fragment bent on `B̄(p, 1 + ε)` keep its class? Side 1 names no ring type, so a yes leaves every ring its (Q) arcs (R2's card 1, " + R2 + ") | a necessary piece of C114-LOCAL-F: with FS-124's NO, route M's first half; fragments at every radius give `χ(ℝ²) ≤ 6` with no MR (YESLIM); its first question shapes FS-124's case list too |",
124: "**FS-124 the (Q) ring** — `plans/STUB-q-ring.md` (FS-116's successor) | does every four-colour vertex whose ring carries (Q) arcs, and every five- or six-colour vertex, die within an explicit radius? The placing rule is held (RING-GERM, SEMI); left: SEMI-PAR3, the disk's corner, crossed reciprocity, five and six colours, the recurrence, Siamese last | the bulk of C114-LOCAL-F and the YES side's home (row 136): with FS-123's NO, route M's first half; fragments at every radius give `χ(ℝ²) ≤ 6` with no MR |",
125: "**FS-125 the saturated local exclusion** — `plans/STUB-saturated-local.md` | NO-SAT: no valid fragment saturated one unit inside, about a four-colour vertex, beyond an explicit radius; first FS116-S1-QF's blind second mind, then SAT-STRIP's G3, G1, G2 | route M's first half in the class its honest branch consumes, weaker than C114-LOCAL-F: with FS-126–FS-128, `χ(ℝ²) = 7` given MR; its failure is `χ(ℝ²) ≤ 6` with no MR |",
128: "**FS-128 the six-colour rungs** — `plans/STUB-top-colour.md` (FS-121's successor) | TOP₆, binding the top colour of a Grundy six-colouring — first as G13's coverage question (R2's card 4) — and NOPAR-C5, the parked cover route's NO | at six and next to the answer: given NO-SAT, TOP₆ is the answer restated (FS121-D3-EQ, one mind); NOPAR-C5 is a smaller NO at six by nature |",
126: "**FS-126 curved pencils** — `plans/STUB-curved-pencils.md` (FS-121's successor) | can an honest saturated colouring, at any `k`, have a curved tangent-type interface? First an inhabitant at some `k ≥ 7` or an obstruction (R2's card 3); FS-115's thin pencils live here | none alone: a NO decides three of FS-121's open claims and deletes (R2) arcs from route M's maps (FS121-Z1-NOCURVED, one mind); a YES at `k ≥ 7` says the map step cannot be colour-blind |",
127: "**FS-127 lateral extent** — `plans/STUB-lateral-extent.md` (FS-121's successor) | is the singular set of every honest saturated colouring locally finite? Open at LAT, point-like accumulation; true on grids (FACE, GRID held) | none alone: REG-J′, one of the honest route's three conditions at six; FS-120's pinch a potential refutation |",
}
CAMEND = [
(120, "none alone: FS-121's colour-generic finiteness rung; one mind throughout", "none alone: the colour-generic finiteness rung, now FS-127's potential refutation (FS121-D4-FALL); one mind throughout"),
(117, "(FS-116's sibling)", "(FS-123's and FS-124's sibling)"),
(117, "it aims FS-116", "it aims FS-123 and FS-124; its (Q)-free case turns on FS-123's first question"),
]

def fs(row):
    m = re.match(r"\| [0-9–]+ \| \*\*FS-(\d+)\b", row)
    return int(m.group(1)) if m else None

def table_rows(text, header):
    lines = text.split("\n")
    i = next(k for k, l in enumerate(lines) if l.startswith(header))
    rows = []
    for l in lines[i + 2:]:
        if not l.startswith("| "):
            break
        rows.append(l)
    return rows

def front_rows(text):
    return table_rows(text, "| rank | stub | the question | bearing on the answer | cost |")

def claude_rows(text):
    return table_rows(text, "| rank | stub | the question | bearing on the answer |\n".rstrip("\n"))

def build_front(rows, amend=AMEND, new_rows=None):
    new_rows = NEW if new_rows is None else new_rows
    by, old_order = {}, []
    for r in rows:
        n = fs(r)
        assert n is not None, r[:80]
        assert n not in by, f"duplicate FS-{n} in the source table"
        by[n] = r.split(" | ", 1)[1]  # cells after the rank
        old_order.append(n)
    assert len(old_order) == 69, f"the source table has {len(old_order)} rows, not R2's 69: re-read it before filing"
    for n, a, b in amend:
        c = by[n].count(a)
        assert c == 1, f"FS-{n}: amendment text found {c} times: {a[:60]}"
        by[n] = by[n].replace(a, b)
    for n, cells in new_rows.items():
        by[n] = cells
    rest = [n for n in old_order if n not in REMOVED and n not in ORDER_TOP and n != AFTER[1]]
    k = rest.index(AFTER[0])
    rest.insert(k + 1, AFTER[1])
    order = ORDER_TOP + rest
    expect = (set(old_order) - REMOVED) | set(new_rows)
    assert len(order) == len(set(order)), "an FS number appears twice in the new order"
    assert set(order) == expect, f"lost or invented rows: {sorted(set(order) ^ expect)}"
    out = [f"| {k} | " + by[n] for k, n in enumerate(order, 1)]
    for line in out:  # a rendered row must have exactly seven cells: no unescaped pipe inside a cell
        cells = [c for c in re.split(r"(?<!\\)\|", line)[1:]]
        if cells and cells[-1].strip() == "":
            cells = cells[:-1]
        assert len(cells) == 7, f"{line[:60]}: {len(cells)} cells, not 7 (an unescaped pipe?)"
    return out, order, old_order

def build_claude(rows, order):
    detailed = {fs(r): r.split(" | ", 1)[1] for r in rows if fs(r) is not None}
    group = [r for r in rows if r.startswith("| 11–")]
    assert len(group) == 1, "CLAUDE.md's group row moved"
    for n, a, b in CAMEND:
        assert detailed[n].count(a) == 1, f"CLAUDE FS-{n}: {a}"
        detailed[n] = detailed[n].replace(a, b)
    detailed.update(CNEW)
    out = []
    for k, n in enumerate(order[:10], 1):
        assert n in detailed, f"CLAUDE.md has no short row for FS-{n}"
        out.append(f"| {k} | " + detailed[n])
    out.append(f"| 11–{len(order)} | {len(order) - 10} more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |")
    return out

def solver_reading(cell):
    """A mechanical reading of a solver cell's words, as of 2026-10-03: the ban's dates have passed, and Kooshi's ruling on it is pending
    (`plans/FS116-close-inventory.md` O7: "restricting search to a wallclock budget per day and per week"). The cell is quoted beside it."""
    c = cell.lower()
    if c.startswith("no solver wanted"):
        return "no"
    if c.startswith("**needs search**") or c.startswith("sat"):
        return "yes: a solver (SAT or MIP), subject to O7's budget"
    if c.startswith("optional"):
        return "optional"
    if c.startswith("post-ban for the optimiser"):
        return "yes: the optimiser, subject to O7's budget; its C-VOID test needs none"
    if "(sdp)" in c:
        return "yes: an SDP certificate (no finite-witness search), subject to O7's budget"
    if any(w in c for w in ("post-ban", "until 2026-10-01", "after the week", "; sat", "finder")) or re.search(r"\blp\b", c):
        return "no for its next step; a later step wants one, subject to O7's budget"
    return "no"

def main(selftest=False):
    front = open(FRONT, encoding="utf-8").read()
    claude = open(CLAUDE, encoding="utf-8").read()
    rows = front_rows(front)
    if selftest:
        ok = 0
        for plant in ("dup", "lost", "amend", "pipe"):
            r2, am, nw = list(rows), list(AMEND), dict(NEW)
            if plant == "dup":
                r2.append(r2[10])
            elif plant == "lost":
                del r2[20]
            elif plant == "amend":
                am.append((44, "a sentence that is not in FS-44's row", "x"))
            else:
                nw[123] = nw[123].replace("(Q)-free ring**", "(Q)-free | ring**", 1)
            try:
                build_front(r2, am, nw)
                print(f"SELF-TEST FAIL: plant '{plant}' was not refused")
            except AssertionError as e:
                print(f"self-test: plant '{plant}' refused ({str(e)[:70]})"); ok += 1
        print("SELF-TEST PASS" if ok == 4 else "SELF-TEST FAIL")
        return 0 if ok == 4 else 1
    new, order, old_order = build_front(rows)
    crows = claude_rows(claude)
    cnew = build_claude(crows, order)
    old_bytes = len(("\n".join(crows)).encode())
    new_bytes = len(("\n".join(cnew)).encode())
    open(OUT_T, "w", encoding="utf-8").write("\n".join(new) + "\n")
    open(OUT_C, "w", encoding="utf-8").write("\n".join(cnew) + "\n")
    with open(OUT_S, "w", encoding="utf-8") as f:
        f.write("| rank | stub | next step wants a solver? | the solver cell as filed |\n|---|---|---|---|\n")
        for k, line in enumerate(new, 1):
            cells = re.split(r"(?<!\\)\|", line)[1:]
            sol = cells[6].strip()
            f.write(f"| {k} | FS-{order[k - 1]} | {solver_reading(sol)} | {sol} |\n")
    oldrank = {n: k for k, n in enumerate(old_order, 1)}
    moves = [f"FS-{n} {oldrank.get(n, 'new')}→{k}" for k, n in enumerate(order, 1) if oldrank.get(n) != k]
    print(f"ranked rows: {len(new)} (source {len(rows)}); FS numbers once each: {len(order) == len(set(order))}")
    print(f"removed to the closed list: {sorted(REMOVED)}; new: {sorted(NEW.keys() - set(oldrank))}")
    print("moves:", ", ".join(moves[:24]), "…" if len(moves) > 24 else "")
    print(f"CLAUDE.md table: {old_bytes} -> {new_bytes} bytes, net {new_bytes - old_bytes:+d}")
    return 0

if __name__ == "__main__":
    sys.exit(main("--self-test" in sys.argv))
