#!/usr/bin/env python3
"""BK stage 3: rewrite the six-framed bearing text of the stubs listed in plans/RERANK-2026-09-27.md § 3, in current-state words.

Each edit names its file, the 1-based line range it replaces (the heading line, if any, and the bearing paragraph(s) only), the text
the first replaced line must start with (a guard against a moved file), and the new text. Run once from the repository root; it refuses
to run if any guard fails, so a second run does nothing.
"""
from pathlib import Path

E = []  # (file, first_line, last_line, guard, new_text)

def add(f, a, b, guard, new):
    E.append((f, a, b, guard, new.strip("\n")))

# FS-67, the status-level paragraph: only the bearing sentences before "**Provisional bearings:**" change (done as a string edit below).
add("STUB-tight-product-colourings", 133, 137, "## 4. Bearing on χ(ℝ²) ≥ 6", """
## 4. Bearing on the answer

None on deciding `χ(ℝ²)`, and none on its formalization: product locality (PL) is content only at fields with a stable place that is not
6-thick, and at the fields where every place mixes the field is the plane (row 128, G81), so the direction (links 1–6 of `CLAUDE.md`
§ The aim) never meets it. **Derived:** PL is necessary for S under HN = 7 and for the conjecture's six-clauses, and its CP form at 23 and
43, `PL_∃(23, 43)`, is one conjunct of six at ℚ(√167) (row 125; FS-96, FS-59). **Soft as to truth:** Hedetniemi fails for finite graphs
from four colours up, and these factors do not mix. Its own value is mechanism: the justification under FS-58's blind-screen reading and
FS-61's A.7 (G61 (3)'s 11 half is now a theorem, its 7 half measured), and the model of a statement the local–global conjecture's shape
(G48) needs — *when does a colouring of a product of local targets have to be local at one place?*
""")

add("STUB-writeup-main-clause-five", 133, 135, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None: it is the fallback write-up of rows 120–123 (its lead, rows 128–130, Kooshi's call). It writes up MR (row 120), on which link 1 of
the direction rests, and by the 2026-09-26 publication rule it waits on its rows' formalization in Lean in full, with no declared
purchases (`CLAUDE.md` § Publication; FS-101's lane, and FS-113 for MR itself). The push toward six it was the fallback for was replaced
by the aim.
""")

add("STUB-window-frequency-certificate", 92, 95, "## Bearing on χ ≥ 6", """
## Bearing on the answer

**Derived as the shape a certificate of six must take; soft as to success.** Link 3 of the direction: one colour class at a time caps
below 4.37 (row 129; the fractional version at 4.36, G60), so a proof of six must read how the classes fit together, and averaged window
frequencies on the real plane are that shape (G24's integrality; FS-104's route (c)). A certificate at five colours on the real plane
gives `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (row 130), hence `χ(ℝ²) ≥ 6` given MR (row 128): the lower half at six, not the answer alone. At four
colours, the stub's first object, it is a solver-free certificate format whose size the symmetry controls; over ℚ(√167) it would restate
a value held at [hand] by measure rigidity (row 123) in a checkable format.
""")

add("STUB-certificate-at-43", 64, 69, "## 4. Bearing on χ(ℝ²) ≥ 6", """
## 4. Bearing on the answer

**None on the answer; idle compute and reading-room work.** A residue plane at 43 bounds only the fields that use it, never ℝ², and the
fields where the field is the plane (link 1) have no usable plane there (row 128). Field-level: it completes FS-66's statement for
`ℚ(√167)` (23 alone leaves 43 as the one tower the certificate does not cover; "43 at depth" is part of six there, row 125), it is the
last gap in M3's finite-place window count, and it attacks FS-57's fractional wall and FS-65's exact numbers from a direction neither stub
considered — if this instrument beats the level-3 relaxation at 43 and 47 as it did at 19 and 23, the six-colour thresholds there
(`α < 308` and `α < 368`) come into a certifier's reach for the first time. A six refused at 43 or 47 removes a window member (G56).
""")

add("STUB-measure-rigidity-three-fields", 512, 516, "## 11. Bearing on χ ≥ 6", """
## 11. Bearing on the answer

**None on the answer.** MR at the fields link 1 of the direction uses is held (rows 120, 128; at de Grey's field walked once, FS-105), and
the stub's left items — TR-ROT at NA₀, C-4, row 100's exception fields, the complex place — sit at fields the direction does not visit. At
ℚ(√47) its five-clause is met (row 121). At ℚ(√167), T-J39-5 converts the conjecture's "≥ 6" into the plane's measurable chromatic number,
`χ_CP(ℝ²) ≥ 6`, given MR, PL(23, 43) and 43's depth: it locates six at link 1's question and does not advance it. Since wave 3 (row 125,
[hand]): "`Y` has none ⟺ `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`", and "No held result gives either conjunct". Its kernel port is FS-101; MR in
full in Lean is FS-113's (`plans/STUB-mr-in-lean.md`).
""")

add("STUB-five-colour-rigidity-table", 32, 35, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None beyond FS-49's (one five-colour virtual edge at distance 2, whose six-chromatic graph would give `χ(ℝ²) ≥ 6` with no MR; a finite
witness for six is out as a route, Kooshi). Medium as FS-49's supply: it is the screen that says where a five-colour compulsion, the
chain's input to a finite six-graph, can live over the 6-open fields, and a table loose everywhere retires the lattice route to six in
those fields. Since row 123 every 6-open real field needs five through MR, with no forcer. The direction (links 1–6 of `CLAUDE.md`
§ The aim) does not use it.
""")

add("STUB-three-colour-criterion-kernel", 109, 113, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None on the answer: it lifts row 82 from [hand] to the kernel — a class theorem over a family of fields, and a write-up's backbone if the
Johnson papers leave it ours. It put the falsification field's lower bound, four, in the kernel (row 119; five there is [hand], through
MR, row 123), and it is the first kernel certificate type that refuses colourings of an infinite graph by a polytope rather than a finite
graph by a resolution proof. Its re-aimed target, row 99 in the kernel, would discharge one of FS-101's named hypotheses (row 127 names
row 99) — the main clause's, not the answer's.
""")

add("STUB-four-colour-inheritance", 87, 90, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None on the answer: its object is compulsions on lattice fabric (Cayley graphs of `ℤ^r`) at four and five colours, a finite-fabric
programme the direction (links 1–6 of `CLAUDE.md` § The aim) does not use. High on that programme: every five- or six-forcer built from
fabric is a four- or five-colour compulsion on lattice fabric, and whether such compulsions are always visible to periodic colourings — and
certifiable — is this stub's question.
""")

add("STUB-de-grey-chain-kernel", 35, 38, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None on the answer. High on the standard of evidence: row 85 moves from a checker's and two readers' word to the kernel's, and since
nothing is published before it is formalized in Lean (`CLAUDE.md` § Publication), a write-up of Mixon's 2018 question
(`CLOSED-QUESTIONS.md` §2.5; FS-20) needs exactly this.
""")

add("STUB-tower-never-rises", 61, 66, "## 4. Bearing on χ(ℝ²) ≥ 6", """
## 4. Bearing on the answer

**None on the answer.** It decides whether the local–global conjecture's local bound `L(F)` is the right invariant or must be replaced by
its all-levels form — and FS-66 already shows the two agree wherever we can certify; at the fields link 1 of the direction uses every
stable place mixes, and neither form enters (row 128). Its value is as mechanism (what a residue colouring can and cannot see at depth), as
the first exact measurable-density value for a `p`-adic plane (deliverable 1 or 2; row 129's local term `r_v` at an odd place), and as the
missing control (3) for any future level-two ask. It is idle-compute and reading-room work beside FS-59.
""")

add("STUB-last-lattice", 43, 46, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None on the answer. The prediction it served, five over ℚ(√3,√5), is met (row 123, [hand], through MR), so some finite graph over that
field is five-chromatic and this lattice would be its explicit object. A four-colouring of the lattice with no periodic colouring would be
C3-aper's first counterexample at four colours (FS-76), not a falsifier of the conjecture. The direction does not use it.
""")

add("STUB-kr6", 35, 37, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None on the answer: a question about periodic colourings of one lattice, which the direction does not use. On that programme: the
smallest place a four-colour C3-aper counterexample could be on arithmetic fabric — four-colourable with no periodic colouring would be
the first.
""")

add("STUB-literal-ring-mixon", 29, 32, "## Bearing on χ ≥ 6", """
## Bearing on the answer

None on the answer. It closes the literal form of a question posed in print in 2018 (`CLOSED-QUESTIONS.md` §2.5), which row 85 answered
only at its exact scope.
""")

add("STUB-padic-distance-classification", 74, 83, "## 5. Bearing on χ(ℝ²) ≥ 6", """
## 5. Bearing on the answer

**None on the answer; low-medium as mechanism.** It builds no forcer and touches no wall, and the direction does not use the residue
method it classifies: at the fields where the field is the plane every place mixes (row 128). What it buys:
(a) a *complete* statement of what the project's own residue instrument can and cannot forbid, which is the kind
of thing a write-up needs and which G38/G43 currently assert rather than prove; (b) C3, which if true is a
structural explanation of the residue method's blindness above four; (c) it is a **derivation**, cheap, with the
machinery in the kernel already, and it answers the number-field analogue of a completely-solved rational
problem — the shape G46 says to prefer over an object search.
""")

add("STUB-field-level-criteria", 64, 68, "## Bearing on χ ≥ 6", """
## Bearing on the answer

**None.** Upper bounds on multiquadratic planes below five do not touch the direction, which works where every place mixes (row 128). It
feeds FS-20 (the Theorem A section of the paper), where a field-level statement is worth more than a subring-level one, and it closes
Theorem A's own gap (`plans/A1-theorem-A-kernel.md` §R2); it would also turn FS-36's decomposition into a kernel statement about
four-chromatic planes.
""")

add("STUB-expansion-measure", 69, 73, "## §3 — Bearing on χ(ℝ²) ≥ 6", """
## §3 — Bearing on the answer

**None on the answer; indirect, and it must be said so.** This is a measure for a search loop, not a construction, and the loop it serves,
M62's search for a five-chromatic unit-distance graph below 509 vertices, moves no value of `χ(ℝ²)`. Its value is that M62's own angle is
an expansion strategy, and today it has no way to tell a working expansion from a stalled one.
""")

add("STUB-four-colours-167", 316, 316, "**Bearing on χ(ℝ²) ≥ 6:**", """
**Bearing on the answer:** only through the plane. Six at ℚ(√167) gives `χ(ℝ²) ≥ 6` (its plane is a subgraph of ℝ²'s), narrowing the
answer to {6, 7}; but it contains `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)` (row 125, given MR), so it is never cheaper than FS-104's question plus
product locality, and the direction reaches ℚ(√167) only through FS-104 (link 1's measurable question at six). Its own content is a
field's: the conjecture's widest gap — predicted ≥ 6 against a proven 5 at [hand] (4 in the kernel, row 119), robust to every level of
the tower at 23 (row 75); a five confirms and cannot falsify (FS-64). The smallest 6-open real field, every lattice over it of rank ≤ 4:
the cheapest arena for six by rank [reading, Poros, 2026-09-24].
""")

add("STUB-adelic-window-colouring", 189, 192, "**Bearing on χ ≥ 6:", """
**Bearing on the answer: none.** A window colouring of `F²` bounds `χ(F²)`, and `χ(ℝ²)` only if it reads the real place alone (FS-44's
object); where every place mixes the field is the plane (row 128), so link 1's fields leave it nothing to add. **Derived:** one of the two
ways six can occur at a field if HN = 7 ("six below HN", R1); **soft** (the conjecture predicts no). **It is the only ceiling instrument
that could decide six at a field:** G64 proves six can hide nowhere but the gap between `L(F)` and `χ(F²)`, and closing that gap from above
is exactly what this would do. It is also the only stub in the set whose *success* would refute the conjecture's bold form rather than
support it — a 6 or a 5 over a field with `L ≥ 7` — which is the right relationship between an instrument and a belief. The finite-place
half at five over ℚ(√167) is a theorem off 43, and given MR the live places are `{∞, 23, 43}` (row 125; FS-96).
""")

add("STUB-fractional-wall", 64, 65, "**Bearing on χ ≥ 6:**", """
**Bearing on the answer:** none — W is a statement about what the residue method can certify (`L(F) ≠ 6` for every `F`), and it neither
proves nor refutes a value of `χ(ℝ²)`; the fields where the field is the plane (row 128) have no window member (first stable places 103;
131 and 479). Its value is structural (G59): it sharpens FS-56's prediction from "≥ 6" to "7", closes the composite-ideal hatch, and `U₆₄`
is the cheapest live killing test of G64's norm reading.
""")

add("STUB-main-clause-five-kernel", 52, 52, "**Bearing on χ ≥ 6:**", """
**Bearing on the answer:** none on deciding. On the Lean formalization of the answer, conditional: its collapse slot (FS-103's Phase 4,
Kooshi's call, after `InvariantMeasureOnClosed` as Markov–Kakutani) is link 1 in the kernel over named hypotheses, which every lower bound
above five proved through MR needs (seven through row 134, FS-111 and FS-112; six through FS-104), and which an upper bound given by a CP
colouring (link 2) does not need. MR itself stays a named hypothesis here; MR in full in Lean is FS-113's (`plans/STUB-mr-in-lean.md`). Its
first slot, the main clause through five (row 127), puts the conjecture's proved range (G48) on the kernel's word one named interface at a
time, and bears none on the answer.
""")

add("STUB-character-classification", 50, 52, "**Bearing on χ ≥ 6:", """
**Bearing on the answer: none;** the direction does not use character colourings. Field-level, it decides the *shape* a character
falsifier of the local–global conjecture would need: CLG-g already excludes character colourings with fewer than `L(F)` colours at `k ≤ 5`
and over quadratic fields; the exception is the only character route left at six and seven, and the classification says whether a
character colouring can be local at no prime at all.
""")

add("STUB-quadratic-witnesses-kernel", 35, 35, "**Bearing on χ(ℝ²) ≥ 6:**", """
**Bearing on the answer:** none; it moves field values from the checker's word to the kernel's — the five witnesses of §1 and, with row
57's gap, the upper halves of §3. The direction does not use them.
""")

add("STUB-pyjama-gluing", 39, 40, "**Bearing on χ ≥ 6:", """
**Bearing on the answer: none.** It settles attribution for band rigidity (row 95 and FS-91's row) and would make `H_k` effective — a finite,
checkable torsion list at every band, which turns every "given `H_k`" in the class theorem into a finite statement.
""")

add("STUB-one-prime-minimal-sets", 37, 39, "**Bearing on χ ≥ 6:", """
**Bearing on the answer: none.** Every real field's unit-vector ring has infinitely many split primes, where two-prime rigidity applies; the
one-prime set is a model of what the second prime forbids. Its value is mechanism and a clean dynamical object (a piecewise isometry of the
square with nine centres), possibly already classified in the discretized-rotation literature.
""")

add("STUB-theorem-B-writeup", 516, 517, "Bearing on `χ(ℝ²) ≥ 6`:", """
Bearing on the answer: **none** — the stub is ranked on the publication trigger, which since 2026-09-26 is formalization in Lean in full,
with no declared purchases (`CLAUDE.md` § Publication). The unification is the literature review the programme's own next milestones need,
and doing it once properly is what stops G49 firing a third time.
""")

add("STUB-consolidation-remainder", 118, 118, "**Bearing on χ(ℝ²) ≥ 6:", """
**Bearing on the answer: none, and this stub says so.** Its §2 blocks the paper (FS-20). The work on the answer is the direction's
(`CLAUDE.md` § The aim), ranked in `plans/FRONTIER-STUBS.md`.
""")

add("STUB-vacuity-coverage", 204, 207, "**Bearing on χ(ℝ²) ≥ 6:", """
**Bearing on the answer: none, and this stub says so.** It is the statement-level gate over the toolkit's `Forces`/`Separated`/`Fan`
consumers, and its value is the one FS-26 named: **this is the only kind of work on the board that could find another `core9_plane`** —
a theorem that passes the build, the axiom audit, the sorry scan and a read-aloud, and still says nothing.
""")


def main() -> int:
    bad = []
    texts = {}
    for f, a, b, guard, new in E:
        p = Path("plans") / f"{f}.md"
        lines = texts.setdefault(f, p.read_text(encoding="utf-8").split("\n"))
        if not lines[a - 1].startswith(guard):
            bad.append(f"{f}:{a}: expected {guard!r}, found {lines[a - 1][:60]!r}")
    if bad:
        print("REFUSED:", *bad, sep="\n  "); return 1
    # apply bottom-up per file so line numbers stay valid
    for f in texts:
        for _, a, b, _, new in sorted([e for e in E if e[0] == f], key=lambda e: -e[1]):
            texts[f][a - 1:b] = new.split("\n")
    # FS-67's status paragraph: a string edit, the provisional bearings kept
    t67 = "\n".join(texts["STUB-tight-product-colourings"])
    old = ("**Bearing on χ ≥ 6: none.** Mechanism only: the answer to \"when must a colouring of a product be local at one factor\" in the class where\n"
           "it is sharp (mixing factors), and a clean no-go (gap-freedom alone, from four colours up). **Provisional bearings:**")
    new = ("**Bearing on the answer: none** (product locality is content only at a stable place that is not 6-thick, and link 1's fields have\n"
           "none, row 128; § 4). Mechanism only: the answer to \"when must a colouring of a product be local at one factor\" in the class where\n"
           "it is sharp (mixing factors), and a clean no-go (gap-freedom alone, from four colours up). **Provisional bearings:**")
    assert t67.count(old) == 1, "FS-67 status paragraph moved"
    texts["STUB-tight-product-colourings"] = t67.replace(old, new).split("\n")
    for f, lines in texts.items():
        (Path("plans") / f"{f}.md").write_text("\n".join(lines), encoding="utf-8")
    print(f"applied {len(E) + 1} edits in {len(texts)} files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
