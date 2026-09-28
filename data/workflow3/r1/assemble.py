#!/usr/bin/env python3
"""R1's re-rank, assembled mechanically so Keryx can file it as it stands.

Reads the ranked table of plans/FRONTIER-STUBS.md and the Paths-forward table of CLAUDE.md as they stood at R1's launch, applies
R1's draft (new rows, amended cells, renumbering), checks the FS numbers, and writes:
  data/workflow3/r1/ranked-table.md          the full ranked table for plans/FRONTIER-STUBS.md (69 rows)
  data/workflow3/r1/claude-paths-forward.md  the rows for CLAUDE.md § Paths forward (29 rows and the group row), with its net bytes
Run from the repository root:  python3 data/workflow3/r1/assemble.py [--self-test]
--self-test plants a duplicate FS number and a lost row, and requires both to be refused.
"""
import re, sys

FRONT = "plans/FRONTIER-STUBS.md"
CLAUDE = "CLAUDE.md"
OUT_T = "data/workflow3/r1/ranked-table.md"
OUT_C = "data/workflow3/r1/claude-paths-forward.md"

NEW = {  # FS number -> the row's cells after the rank (stub | question | bearing | cost | status | solver)
116: "**FS-116 the local exclusion** — `plans/STUB-local-exclusion.md` (minted 2026-09-28 by FS114-C; FS-114's successor; route M's first half) | exclude every valid six-map fragment with unit arcs on a closed disc of explicit radius about a vertex of at least four colours (C114-LOCAL-F). Every valid map has such a vertex (FS114-CV-EXISTS, two minds blind to each other; row 137), so one radius uniform in the complexity gives the NO for every locally finite map, Siamese pairs included — sufficient, not shown necessary: at each complexity bound compactness gives some radius (FS114-N114-COMPACT), and uniformity is C-LOCAL. Any radius exceeds `φ²/√2 ≈ 1.8512` (the capped strip). First, R1's card 1 (`plans/POROS-2026-09-28-close-reread.md` §2.4): do FS-114's second-order straddle kills survive an ε-band uniformly in the complexity? Then round 7's queue: a blind check of N7-3T and N7-HUB (b); the wrap lemma (one lemma, three GAPs); the open-cap family OC; rings with (Q) arcs, from the R-E2/E2 comparison; E1's residues, E2's survivor S6, non-simple bowties; beyond K1, four-colour vertices with at most two tactic edges or of degree ≥ 5 (N7-HUB's hexagon lead). Owed: row 134's Lemma 4 at cusps before anything final | route M's first half, and not vacuous under seven: a NO answers `[SokolovVoronov2025]` Question 2's unit-arc half and `[Polymath2021]` p. 199's hope for segment-and-arc maps, and with FS-121's map step gives `χ_m⁰(ℝ²) = 7`, so `χ(ℝ²) = 7` given MR (FS111-C-SEVEN-M, two minds) — each half necessary for seven, each equivalent to it given the other; a YES, a valid six-map of the plane, gives `χ(ℝ²) ≤ 6` with no MR | unpriced (counter-priors, rule 1) | minted 2026-09-28 | in-ban: derivation, reading, exact fragments by formula",
121: "**FS-121 the map step** — `plans/STUB-map-step.md` (minted 2026-09-28 by FS111-C; FS-111's successor; route M's second half) | can a tight colouring of the plane be replaced by a map — at six by one bounded by segments and circular arcs (REG-A₆), at five by any map? REG-A₆ reduces to honest saturation, REG-J′₆ (a locally finite singular set, finitely many arcs at each point) and no large-radius accumulation, ¬LRA (FS111-M2-REDUCE-A, two minds); off such a set saturated interfaces have integer radii (FS111-M2-INTRAD). Smaller rungs first: NO-PAR (a NO for self-parallel boundaries, at row 134's N4 step), interface-maximal six-colourings, MUA-REG-P; its colour-generic finiteness rung is FS-120, and ¬LRA may be FS-115's ray (one mind). First, R1's card 2: can its map be taken of bounded complexity? Calibration: Cohen–Mani's Question 5.1 | route M's second half: with FS-116's NO it gives `χ_m⁰(ℝ²) = 7`, so `χ(ℝ²) = 7` given MR; its failure is a tight six-colouring, `χ(ℝ²) ≤ 6` with no MR (link 2); at five, given AE-MAP6, its cover form is equivalent to `χ_m⁰(ℝ²) ≥ 6` (FS111-VM2-EQ5) — FS-104's YES in another form, its failure `χ(ℝ²) = 5` with no MR. At six it holds vacuously under seven (true at `k ≥ 7` on R7, FS111-W-NEG), so its proof must be colour-generic, and progress is its smaller rungs | unpriced | minted 2026-09-28 | in-ban: derivation and reading",
122: "**FS-122 the forced pair** — `plans/STUB-forced-pair.md` (minted 2026-09-28 by FS111-C; route R) | must every near-colouring of the plane with small holes carry a close complementary pair of fat junctions, at every complexity (A-ALL)? A-ALL is equivalent to seven (FS111-W-NEG, two minds), so the milestone's statements are its smaller ones: B-RR, a junction cone scale bounded below independently of the holes (B-NONABS, its hole-dependent form, is FALSE, FS111-W-B-NONABS), and a robust form of `[SokolovVoronov2025]` Lemma 6.1's count; HX's complementary blocking pairs (FS111-W-HX-PAIRS) | the answer itself in route R's form: A-ALL with CP and B-RR gives `χ_m⁰(ℝ²) = 7` with no map NO, so `χ(ℝ²) = 7` given MR; its failure is `χ(ℝ²) ≤ 6` with no MR; it meets route M nowhere below the answer (under Condition 5 at bounded complexity no valid map has a close complementary pair, row 134), so its smaller statements bear only through A-ALL | unpriced | minted 2026-09-28 | in-ban: derivation and reading",
120: "**FS-120 the pinch at a junction** — `plans/STUB-pinch-at-junction.md` (minted 2026-09-28 by FS111-C) | in a regular maximal partition — a measurable fall colouring of the unit-distance graph — can a pinch be removed locally, or does its cascade climb the ladder of unit parallels (FS111-M4-LADDER; at most `1/(2c)` rungs up, FS111-M4-CUT, its downward half conditional) with forced classes and no spare colour at any `k` (FS111-M4-MOVE) to a junction, and stop there? Also MUA-FIN-L in partitions (GAP at the singular set) and (F1) for irregular maximal sets; its question 1: no maximal seven-cover with a pinched class has been exhibited | none alone: the colour-generic finiteness rung both of FS-121's top rungs need (REG-J′-C₅ at five, REG-A₆ at six); a pinch no local move removes would say route M's finiteness is global; every link one mind (FS111-M3, M4; no verifier ran) | unpriced | minted 2026-09-28 | in-ban: derivation, exact objects by formula; post-ban, a finder over periodic partitions as a dial",
115: "**FS-115 the stuck ray** — `plans/STUB-stuck-ray.md` (minted 2026-09-27 by FS112-C; re-aimed 2026-09-28 at FS-114's and FS-111's closes) | (b′) can a one-sided chain of stuck vertices live in a valid map with unit arcs — its extremal form a pencil of circles of radius `k + 1`, a ray needing arcs of every radius `≥ k + 1` (FS112-N3-CHAINS)? (b″) are finite stuck chains bounded? (c) does the single-vertex bowtie end live in a valid map? New: is FS-111's large-radius accumulation LRA, which REG-A₆ must exclude (FS111-M2-REDUCE-A, two minds), this ray in the measurable setting, as FS111-C reads it (one mind, unchecked)? | none alone: after FS114-CV-EXISTS the NO needs no ray step, so (b′) and (b″) bear only on GS-4's density form (row 137); its live bearing is as a rung of FS-121 through ¬LRA, if that reading holds; its fragments (the pencil, BOWTIE) are local positives a YES could use | unpriced | minted 2026-09-27; re-aimed 2026-09-28 (R1; its banner) | in-ban: derivation, exact chain fragments by formula",
117: "**FS-117 route T, the count** — `plans/STUB-route-t-count.md` (minted 2026-09-28 by FS114-C; FS-116's sibling) | does no non-Siamese valid six-map with unit arcs exist, by Euler's formula and local payments? Route T's charge (`n`, `n − 2`, `n`, `n + 6` at degrees 3–6, FS114-N2-ENDS) sums to zero on torus maps, averages on discs at every complexity (FS114-N2-AVG, two minds) and is negative only at a degree-4 four-colour vertex with three or four tactic edges; the non-Siamese NO reduces to K1′ ∧ K2′ ∧ GAP-μ (K1 shared with FS-116). Left: K2′, GAP-μ (and its hull form, FS114-N6-MTP), COVER-3, Sirgedas's metagraph, the torus design | none alone, and partial by theorem: a tile count is blind to Siamese pairs (FS114-N2-REFINE; drafted G86), so it reaches the non-Siamese NO at best — de Grey's target (`[Polymath16threads]` `[16.317]`), Thomassen's theorem without scalability; its charge says which configurations FS-116 must exclude, and a torus YES would be FS-116's YES | unpriced | minted 2026-09-28 | in-ban: derivation, exact identities on torus maps by formula",
}
ORDER_TOP = [116, 121, 104, 122, 120, 115, 117]   # ranks 1-7; then old ranks 5.. in order
REMOVED = {114, 111}

AMEND = [  # (FS number, old text, new text): exact, each must occur once in its row
(104, "**Rank 3 since FS-107's close (2026-09-27), below FS-110 and FS-111 (the owner's ruling, `plans/FS107-close-inventory.md` item 36); re-aimed at the reframe, not demoted.**",
      "**Rank 3 since FS-107's close (2026-09-27); at FS-114's and FS-111's closes (2026-09-28, R1) below route M's pair, FS-116 and FS-121; re-aimed at the reframe, not demoted.**"),
(104, "`χ_g(H)` (post-ban) |", "`χ_g(H)` (post-ban); the regularity route at five is FS-121's cover statement, which given AE-MAP6 is equivalent to this stub's YES (FS111-VM2-EQ5) — a reformulation, not a shortcut |"),
(109, "tile-share dial (the stub, 2026-09-27) |", "tile-share dial (the stub, 2026-09-27); a second dial along complexity: `δ₀(K)`, the least hole density at complexity `≤ K`, whose uniform positivity is seven (FS111-C1-UNIF, two minds) |"),
(108, "none on the answer (row 131 makes regular classes constraints on the tight question, not answers to it)",
      "none on the answer (row 131 makes regular classes constraints on the tight question, not answers to it) — except that FS-121's route at five rests on FS106-AE-MAP6 (FS111-M2-REDUCE-C), so Townsend's (c) now sits under a route to six"),
(113, "(FS-105 §K) |", "(FS-105 §K); FS-111's route-M lemmas (FS111-C1-UNIF, M-PINCH, M-C11, M2-FIX, M2-INTRAD and the rest) queue behind it, their objects not in `Proofs/` |"),
(101, "(seven through row 134, FS-111 and FS-112; six by FS-104)", "(seven through route M: rows 134–138 with FS-116 and FS-121; six by FS-104)"),
(101, "FS-113 (rank 8)", "FS-113 (rank 12)"),
]

CNEW = {  # CLAUDE.md short rows: stub | question | bearing
116: "**FS-116 the local exclusion** — `plans/STUB-local-exclusion.md` (FS-114's successor) | exclude every valid fragment on a disc of explicit radius, uniform in the complexity, about a four-colour vertex — every valid map has one (row 137), so this suffices for the NO; any radius exceeds `φ²/√2`. First R1's band question (`plans/POROS-2026-09-28-close-reread.md` §2.4), then round 7's queue | route M's first half: a NO answers `[SokolovVoronov2025]` Question 2's unit-arc half and, with FS-121, gives `χ(ℝ²) = 7` given MR; a YES gives `χ(ℝ²) ≤ 6` with no MR",
121: "**FS-121 the map step** — `plans/STUB-map-step.md` (FS-111's successor) | can a tight colouring be replaced by a segment-and-arc map (six) or a map (five)? Smaller rungs first: NO-PAR, interface maximality, ¬LRA | route M's second half: with FS-116's NO, `χ(ℝ²) = 7` given MR; its failure is a tight six-colouring, `χ(ℝ²) ≤ 6` with no MR; at five, given AE-MAP6, FS-104's YES in another form",
122: "**FS-122 the forced pair** — `plans/STUB-forced-pair.md` (route R) | a close complementary pair of fat junctions in every near-colouring (A-ALL ⟺ seven); its smaller statements B-RR and a robust Lemma 6.1 count | the answer itself in route R's form, with no map NO; its smaller statements bear only through it",
120: "**FS-120 the pinch at a junction** — `plans/STUB-pinch-at-junction.md` | in a measurable fall colouring, is a pinch's cascade along its ladder of unit parallels absorbed where the ladder ends? | none alone: FS-121's colour-generic finiteness rung; one mind throughout",
115: "**FS-115 the stuck ray** — `plans/STUB-stuck-ray.md` | a one-sided chain of stuck vertices, its extremal form a pencil of circles of radius `k + 1`, in a valid map with unit arcs; is it FS-111's large-radius accumulation (one mind)? | none alone: the NO needs no ray (row 137); a rung of FS-121 through ¬LRA if that reading holds",
117: "**FS-117 route T, the count** — `plans/STUB-route-t-count.md` (FS-116's sibling) | the non-Siamese NO by Euler's formula: K2′, GAP-μ, COVER-3, the torus design | none alone, partial by theorem (a tile count is blind to Siamese pairs); it aims FS-116",
}
CAMEND = [(108, "none on the answer (row 131)", "none on the answer (row 131), but under FS-121's route at five (AE-MAP6)")]

def fs(row):
    m = re.match(r"\| [0-9–]+ \| \*\*FS-(\d+)\b", row)
    return int(m.group(1)) if m else None

def front_rows(text):
    lines = text.split("\n")
    i = next(k for k, l in enumerate(lines) if l.startswith("| rank | stub | the question | bearing on the answer | cost |"))
    rows = []
    for l in lines[i + 2:]:
        if not l.startswith("| "):
            break
        rows.append(l)
    return rows

def claude_set(text):
    rows = claude_rows(text)
    ns = {fs(r) for r in rows if fs(r) is not None}
    g = [r for r in rows if r.startswith("| 30–")][0]
    ns |= {int(x) for x in re.findall(r"FS-(\d+)", g[:g.index(" — in rank order")])}
    return ns

def build_front(rows, src_expect):
    by = {}
    for r in rows:
        n = fs(r)
        assert n is not None, r[:80]
        assert n not in by, f"duplicate FS-{n} in the source table"
        by[n] = "| ".join(r.split("| ")[2:])  # cells after the rank
    old_order = [fs(r) for r in rows]
    assert set(old_order) == src_expect, f"the frontier table and CLAUDE.md's table disagree: {sorted(set(old_order) ^ src_expect)}"
    for n, a, b in AMEND:
        assert by[n].count(a) == 1, f"FS-{n}: amendment text found {by[n].count(a)} times: {a[:60]}"
        by[n] = by[n].replace(a, b)
    for n, cells in NEW.items():
        by[n] = cells
    rest = [n for n in old_order if n not in REMOVED and n not in ORDER_TOP]
    order = ORDER_TOP + rest
    expect = (set(old_order) - REMOVED) | set(NEW)
    assert len(order) == len(set(order)), "an FS number appears twice in the new order"
    assert set(order) == expect, f"lost or invented rows: {sorted(set(order) ^ expect)}"
    return [f"| {k} | " + by[n] for k, n in enumerate(order, 1)], order

def claude_rows(text):
    lines = text.split("\n")
    i = next(k for k, l in enumerate(lines) if l == "| rank | stub | the question | bearing on the answer |")
    rows = []
    for l in lines[i + 2:]:
        if not l.startswith("| "):
            break
        rows.append(l)
    return rows

def build_claude(rows, order):
    detailed = {fs(r): "| ".join(r.split("| ")[2:]) for r in rows if fs(r) is not None}
    group = [r for r in rows if r.startswith("| 30–")]
    assert len(group) == 1
    for n, a, b in CAMEND:
        assert detailed[n].count(a) == 1, f"CLAUDE FS-{n}: {a}"
        detailed[n] = detailed[n].replace(a, b)
    detailed.update(CNEW)
    out = []
    for k, n in enumerate(order[:29], 1):
        assert n in detailed, f"CLAUDE.md has no short row for FS-{n}"
        out.append(f"| {k} | " + detailed[n])
    tail = ", ".join(f"FS-{n}" for n in order[29:])
    g = group[0]
    old_tail_ok = re.match(r"\| 30–\d+ \| (.*?) — in rank order", g)
    assert old_tail_ok, g[:80]
    out.append(g.replace(g[:g.index(" — in rank order")], f"| 30–{len(order)} | {tail}", 1))
    return out

def main(selftest=False):
    front = open(FRONT, encoding="utf-8").read()
    claude = open(CLAUDE, encoding="utf-8").read()
    rows = front_rows(front)
    if selftest:
        ok = 0
        for plant in ("dup", "lost"):
            r2 = list(rows)
            if plant == "dup":
                r2.append(r2[10])
            else:
                del r2[20]
            try:
                build_front(r2, claude_set(claude))
                print(f"SELF-TEST FAIL: plant '{plant}' was not refused")
            except AssertionError as e:
                print(f"self-test: plant '{plant}' refused ({str(e)[:70]})"); ok += 1
        print("SELF-TEST PASS" if ok == 2 else "SELF-TEST FAIL")
        return 0 if ok == 2 else 1
    new, order = build_front(rows, claude_set(claude))
    crows = claude_rows(claude)
    cnew = build_claude(crows, order)
    old_bytes = len(("\n".join(crows)).encode())
    new_bytes = len(("\n".join(cnew)).encode())
    open(OUT_T, "w", encoding="utf-8").write("\n".join(new) + "\n")
    open(OUT_C, "w", encoding="utf-8").write("\n".join(cnew) + "\n")
    print(f"ranked rows: {len(new)} (source {len(rows)}); FS numbers once each: {len(order) == len(set(order))}")
    print(f"CLAUDE.md table: {old_bytes} -> {new_bytes} bytes, net {new_bytes - old_bytes:+d}")
    return 0

if __name__ == "__main__":
    sys.exit(main("--self-test" in sys.argv))
