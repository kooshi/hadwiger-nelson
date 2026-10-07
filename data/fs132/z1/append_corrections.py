#!/usr/bin/env python3
"""FS132-Z1, stage 4: append the dated corrections. Each is inserted after an anchor line (asserted unique), with blank
lines around it; nothing that stands is changed. Idempotent: a correction whose first 60 characters are already in the
file is skipped."""
import sys
from pathlib import Path
PLANS = Path(__file__).resolve().parents[3] / "plans"

def insert_after(fname, anchor, text, stop=None):
    """Insert `text` as a paragraph after the paragraph (or block) that the anchor line begins. A block head
    (derivation:/control:) is matched as a whole line; any other anchor by its beginning. `stop`: a line beginning that
    ends the paragraph early (consecutive list items have no blank line between them)."""
    p = PLANS / fname
    body = p.read_text()
    if text in body:
        print("skip (present):", fname, text[:50]); return
    lines = body.split("\n")
    exact = anchor.startswith(("derivation: ", "control: "))
    idx = [i for i, ln in enumerate(lines) if (ln == anchor if exact else ln.startswith(anchor))]
    assert len(idx) == 1, (fname, anchor, len(idx))
    j = idx[0]
    while j + 1 < len(lines) and lines[j + 1].strip() != "" and not (stop and lines[j + 1].startswith(stop)):
        j += 1
    tail = lines[j + 1:]
    new = lines[: j + 1] + ["", text] + ([""] if tail and tail[0].strip() != "" else []) + tail
    p.write_text("\n".join(new))
    print("inserted:", fname, "after line", j + 1)

Z = "filed by FS132-Z1, the record job"

# 1. the ring card's read-off line (E6's draft, verbatim), under item (i) of § Where C132-TURN stalls
insert_after("FS132-E4-derivation.md", "- **(i) The witness at the ring point.**", stop="- **(ii)", text=
"  *Dated line (2026-10-07, " + Z + "; the text between the quotation marks is FS132-E6's draft, verbatim), on the sentence above "
"\"Every pattern of sides has such a point when all six ring points have a pure side: the side is opposite at antipodes, so the six "
"read O O O I I I (take the middle O) or O I O I O I (take any I).\":* \"2026-10-07, FS132-E6: true when each of the three sets has "
"a point strictly inside three of the six unit circles about the ring points and strictly outside the other three (so when each has a "
"limiting direction at `x` perpendicular to no ring direction); false as written — sets `{x, q_j}` with `|q_j − x| > 2` make all six "
"sides inner-pure and none outer-pure. The entry C132-TURN-EDGE does not use the sentence. And by C132-LENS-SIDE the pattern "
"O I O I O I does not occur at all. Source: `plans/FS132-E6-derivation.md` Stage 2, § The gap in clause (ii).\" *And on \"the first "
"is the relation of C132-EXT-DISC's clause (5)\" in the same item: the dated correction under the entry C132-TURN in this record "
"applies — the clause is read there more widely than its entry.*")

# 2. the stall's wording, under the entry C132-TURN
insert_after("FS132-E4-derivation.md", "derivation: C132-TURN",
"*Dated correction (2026-10-07, " + Z + "; sources: `plans/POROS-2026-10-07-fs132-round2.md` ll. 66–76; `plans/FS132-close-inventory.md` "
"item 21; `data/fs132/claims.md`, the dated correction of item 21):* the verdict line of the entry C132-TURN above calls the stalled step "
"\"the relation of C132-EXT-DISC's clause (5)\". That reads the clause more widely than its entry: clause (5) is derived for the "
"extraction's own continua and says nothing of whatever witnesses a hypothesis hands a point, and for those the relation is false in "
"general (FS132-E5's anchored witnessed triangle at a point whose transition graph is a path: hand, one mind, no control, at seven). The "
"claim list's wording: \"C132-TURN's stall is: that a witnessed triangle given at a point lies in that point's own transition graph — a "
"statement no entry of this list asserts.\" And the statement as posed carries the defect its poser names — it \"attaches data of a unit "
"circle to a point defined by its small balls, with nothing joining them\"; it stands as stalled and is not re-posed in that form. The "
"entry is left as filed.")

# 3. the second round's seven-colour controls are controls of the margin case
insert_after("FS132-E4-derivation.md", "control: hex7-crossings",
"*Dated line (2026-10-07, " + Z + "; source: `plans/FS132-E6-derivation.md` Stage 2, § The two riding controls, with its controls "
"`hex-half-crossings` and `hex-half-sides`; `plans/FS132-close-inventory.md` item 28 (d)):* the control `hex7-crossings` above, at "
"circumradius 2/5, is a control of the margin case. Re-run on the honeycomb at circumradius 1/2, where every tile has diameter exactly "
"1, its fourth count moves — own-label-near-crossing 0 → 36 of 432 crossings (216 vertex pairs) — and every one of the 5,760 such "
"samples lies inside that vertex's unit circle, as the blocking rule requires. C132-CROSS is untouched; \"the zero at 2/5 was the "
"margin\". The control stands as run.")

insert_after("FS132-E5-derivation.md", "control: margin-witness",
"*Dated line (2026-10-07, " + Z + "; source: `plans/FS132-E6-derivation.md` Stage 2, § The two riding controls, with its control "
"`hex-half-margin`; `plans/FS132-close-inventory.md` item 28 (d)):* the control `margin-witness` above, at circumradius 2/5, records "
"the margin case only. Re-run at circumradius 1/2 it reads vertex-labels-on-annulus 6,672 where it reads 0 here, with all seven labels "
"seen: C132-WIT-MARGIN's hypothesis fails there — \"at 1/2 no witness comes from a margin\" — and the entry is untouched. The same holds "
"of the second round's other seven-colour control, `hex7-crossings` in `plans/FS132-E4-derivation.md` (its dated line is there). The "
"control stands as run.")

# 4. the plan's dictionary term for a tip
insert_after("FS132-six-by-the-nerve.md", "**The dictionary** (map → measurable):",
"*Dated correction (2026-10-07, " + Z + "; source: `plans/FS132-E3-derivation.md` § The route, step by step, row V6-TIP, and its report "
"`data/fs132/reports/FS132-E3.md`, the line \"statement defect\"):* in the dictionary above, \"a tip at `y` → a label `c` of the cycle "
"with `y ∈ H_c`\" is too wide — it also holds of a label present only outside the unit disc about `p`. The term that carries the step "
"V6-TIP is \"`y` in the closure of `H_c ∩ B(p, 1)`\" (in the step table's words, `y ∈ cl(H_c ∩ B(p, 1))`). The text above is left as "
"written.")

# 5. clause (5), under C132-EXT-DISC in the first deriver's record
insert_after("FS132-E1-derivation.md", "derivation: C132-EXT-DISC",
"*Dated line (2026-10-07, " + Z + "; sources: `plans/POROS-2026-10-07-fs132-round2.md` ll. 66–74; `plans/FS132-close-inventory.md` item 21; "
"`data/fs132/claims.md`, the dated correction of item 21):* on clause (5) of the entry C132-EXT-DISC above, which stands as filed. The "
"clause is still one mind's (step S11), against the letter of the manuscript's sentence \"The extracted cycle need not consist of edges "
"of Γ_x\". Two rounds later its consumers are two, and small: a closing remark of FS132-E3 on mixed rings (the release's Lemma 6.2 acting "
"on the extracted cycle), and the words \"forming a cycle of the transition graph\" in FS132-E5's C132-WIT-EX-FIN. No exclusion of the "
"milestone reads it (C132-M-ORBIT reads clauses (1) and (3) only). The coordinator's ruling 16 (c) called it load-bearing for C132-TURN's "
"stall, and that ruling is withdrawn: the clause is derived for the extraction's own continua and says nothing of whatever witnesses a "
"hypothesis hands a point, for which the relation is false in general. No second reading of it was ordered; it keeps its flag for the "
"two consumers named.")

# 6. the two-pair ring's attribution, and the exclusion's second reading, in the readings deriver's record
insert_after("FS132-E3-derivation.md", "derivation: C132-DIAG-WIDE",
"*Dated line (2026-10-07, " + Z + "; sources: the kernel planner's record `plans/FS132-kernel-plan.md` on branch `fs132-wk1` at `e3695302`, "
"§ 2.3; `plans/FS132-close-inventory.md` item 25; `data/fs132/claims.md`, the dated line of item 25):* an attribution, for the entry "
"C132-DIAG-WIDE above, which stands as filed. For a colouring of the whole plane its statement is an instance of "
"`OAI.EuclideanFiveColor.two_state_impossible`, which the release proves in Lean at every number of labels under \"at most two labels "
"outside the two sets\" (`States.lean:243`, by the planner's reading; this record had not read the Lean). It is `[OAIMath2026]`'s theorem "
"at six and is worded from now on as a corollary of its Lean, not as a result of this milestone; what this record adds is the reading on "
"an open set containing the closed unit disc, [hand], one mind.")

insert_after("FS132-E3-derivation.md", "derivation: C132-M-ORBIT",
"*Dated line (2026-10-07, " + Z + "; sources: `plans/FS132-E5-derivation.md` § The exclusion, step by step; the kernel planner's record "
"`plans/FS132-kernel-plan.md` on branch `fs132-wk1` at `e3695302`, §§ 3.1–3.4; `plans/FS132-close-inventory.md` items 18, 22, 30):* the "
"entry C132-M-ORBIT above stands as filed. Since it was filed: (1) FS132-E5 reworked M1–M6 from this argument and read M7–M9; the argument "
"reads one point of each set besides `p`, so the statement with four points `q_j` in place of four compact sets (C132-WIT-ORBIT) is this "
"theorem, not a wider one. (2) The kernel lane's planner, kept from this record until its commit `1eb4b94b`, reached blind the state, the "
"chart, a forced label at each hub by another route, the unit-pair relation on its diagonal and the kill for a clean change, and stopped "
"at M8; with the fence lifted it read M4–M9 line by line — \"I found no gap. Grade: two minds on M7–M9 (the deriver; this reading), M8 no "
"longer unread\" — re-derived M7's constant, and made the four-point form its Lean leaf, at the whole plane. So where this record says M8 "
"and M9 have no second reader, each now has a reading made with the argument open; M6 and M8 still have one derivation. The step-by-step "
"account is `plans/FS132-derivation.md` § 1.")

# 7. earlier milestones' derivation files: the exclusion with no map and no Siamese clause
NOTE = ("*Dated note (2026-10-07, FS132-Z1, the record job of FS-132; from `plans/FS132-derivation.md` §§ 1–2, entries C132-M-ORBIT, "
"C132-M-EXCL and C132-WITNESS; `plans/FS132-close-inventory.md` items 6, 10, 30):* the entry {name} above stands as filed. In FS-132 its "
"exclusion was derived for measurable colourings with no map and **no Siamese clause** — C132-M-EXCL: \"let U, p, c, the labels a_0, "
"a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e "
"the palette P_p(e) contains X or Y\" (the setting, read in that file's entry C132-M-ORBIT: a weak measurable six-colouring of an open "
"set containing the closed unit disc about p, four of the six labels in a cycle, and for each consecutive pair a compact set through p "
"and another point whose straddle set misses both labels' closed essential supports). Grade: [hand], **one mind's derivation (FS132-E3) "
"and a second mind's reading** — the kernel lane's planner, whose own blind route reached the argument's shape and stopped at one lemma, "
"and who then read the argument's last steps line by line; not two blind derivations — **kernel pending**. It covers a valid six-coloured "
"fragment wherever four tiles of four colours meet in a cycle at the vertex and the ring carries no (Q) arc{extra}, **given two facts "
"about maps**: (1) a map's edge carries the two-colour exclusion for its two side colours — derived in FS-132 for tiles that are "
"connected open sets (C132-WITNESS, [hand], one mind), the composition written by nobody; (2) a map's palette at the vertex is its ring "
"read two-sidedly — derived by nobody. Until both are written this entry's class hypotheses are not struck. What would be left for the "
"Siamese class after them: a Siamese vertex whose tiles about it contain no such cycle (FS132-E3's report). Not claimed: anything at a "
"ring carrying a (Q) arc; anything at seven colours or more.")
GAMMA = " — in particular no arc of Γ at all, which is this entry's case"
insert_after("FS116-derivation.md", "*Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR1-audit.md` § 2.3; `plans/FS129-close-inventory.md` item 96):*",
             NOTE.format(name="FS116-Y4-EMPTY", extra=GAMMA))
insert_after("FS129-derivation.md", "Rests on it: FS129-SR3-QFREE-NS, and through it FS129-SR2-QFCASE.",
             NOTE.format(name="FS129-SR3-EMPTY-NS", extra=GAMMA))
insert_after("FS129-derivation.md", "Rests on it: FS129-SR2-QFCASE (S1-QF is its case, no simplicity step);",
             NOTE.format(name="FS129-SR3-QFREE-NS", extra=""))
