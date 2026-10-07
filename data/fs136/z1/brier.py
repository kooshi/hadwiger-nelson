#!/usr/bin/env python3
"""FS136-Z1 (Done means 5): every registered prediction of FS-136 in one table, with Brier where binary.
Rows: (who, id, what, probability, outcome, note).  outcome: 1 met, 0 not met, None not scored (withdrawn, or not binary).
The outcomes are the derivers' and the asking lane's own scorings, reconciled (sources in the record, Stage 5); this
script only does the arithmetic and prints the table.   python3 data/fs136/z1/brier.py
"""
ROWS = [
 # the asking lane's first card (plans/STUB-covering-pairs.md § Registered expectations, before FS136-E1)
 ("card 1", "A1", "C-RINGS-READ's statement holds on the strip, the disk and the flower", 0.85, 1, ""),
 ("card 1", "A2", "… on FS114-Y2-BOWTIE", 0.5, 1, ""),
 ("card 1", "A3", "C-COVER derived as posed", 0.9, 1, "derived as posed, and restated on labels: the posed conclusion is met by a degenerate case"),
 ("card 1", "A4", "C-ONE derived", 0.9, 1, "derived, in the label form"),
 ("card 1", "A5", "C-PARTNERS derived", 0.9, 1, "resting on C124-BOTH"),
 ("card 1", "A6", "C-STOP: the disk's rim by the first-order lemma", 0.7, 1, ""),
 ("card 1", "A7", "C-STOP: the flower's far vertex by the first-order lemma alone", 0.35, 1, "met against its odds; \"the lemma is not first order\" — one witness is second order"),
 ("card 1", "A8", "the card: always", 0.08, 0, "not derived"),
 ("card 1", "A9", "the card: a ring by formula", 0.12, 0, "none built"),
 ("card 1", "A10", "the card: it turns on the ring's type", 0.8, 1, "occurred with its unit wrong: \"the table at the point across, not the ring's type\" — scored as occurred by both scorers; not cleanly binary"),
 ("card 1", "A11", "an exclusion at an explicit radius for every pieced ring of a named type, within this milestone", 0.1, 0, ""),
 ("card 1", "A12", "a six-coloured fragment past φ²/√2 about a point of four or more labels", 0.1, 0, ""),
 ("card 1", "A13", "six against seven decided here", 0.03, 0, ""),
 # the asking lane's second card (the same stub, second round; scored by FS136-E2 § 7.3)
 ("card 2", "B1", "C-FORCED derived as posed", 0.9, 1, "derived, restated in two places"),
 ("card 2", "B2", "C-FORCED found already held under another name", 0.2, 0, "partly: a step about palettes inside one argument, never an entry; for pieces not held — the card's clause did not fire"),
 ("card 2", "B3", "on R7 no cell empty", 0.97, 1, ""),
 ("card 2", "B4", "the closure of R7's pair gives at least one of R7's germs at a common unit point", 0.9, 1, "one, whole"),
 ("card 2", "B5", "… all six there", 0.3, 0, ""),
 ("card 2", "B6", "the flower's pair reaches a point beyond (−1, −1) with a forced cell", 0.35, 1, "met against its odds"),
 ("card 2", "B7", "the strip's pair a third point", 0.4, 1, "met for the eight-corner seed (c1), not for (c2); the card's seed named no object of the strip — scored on (c1), the seed its evidence describes"),
 ("card 2", "B8", "an empty cell from a pair alone beyond its own two common unit points, on any seed tried", 0.25, 0, "none on four seeds"),
 ("card 2", "B9", "C-STOP-GERMS as posed", 0.85, 1, "derived; the radius law came out stronger than posed (first order on the bowtie fragment)"),
 ("card 2", "B10", "a fragment by formula past φ²/√2 from a closure, within this round", 0.05, 0, "\"and it could not have come out\": a closure is germs"),
 ("card 2", "B11", "six against seven decided here", 0.02, 0, ""),
 ("card 2", "B12", "the card's hunch: it stalls at free cells within two steps on every held six-coloured seed", 0.65, 1, "two forcing steps on the flower and on (c1), none on (c2)"),
 ("card 2", "B13", "the card's hunch: the closure closes round a ring", 0.10, 0, ""),
 # FS136-E1 (plans/FS136-the-point-across.md § Registered predictions; scored in its record)
 ("E1", "P1a", "the reading's statement holds on the strip, the disk and the flower", 0.8, 1, ""),
 ("E1", "P1b", "… on FS114-Y2-BOWTIE", 0.6, 1, ""),
 ("E1", "P2", "at every held stop the pair's own table already has an empty cell", 0.55, 1, "four of four"),
 ("E1", "P3", "C136-TABLE derived as stated, C136-COVER and C136-ONE read off it in the label form", 0.93, 1, ""),
 ("E1", "P4a", "C136-PARTNERS derived as restated, resting on C124-BOTH", 0.85, 1, ""),
 ("E1", "P4b", "C124-LONE's Step II read and found sound by the deriver", 0.8, None, "withdrawn: the kernel planner's second look arrived first; not read by the deriver"),
 ("E1", "P5a", "the flower's far vertex excluded by C124-TYPE alone with six kept pieces", 0.9, 1, "not blind (worked before it was registered)"),
 ("E1", "P5b", "the disk's rim point excluded by C124-TYPE with pieces at its members", 0.75, 1, ""),
 ("E1", "P6a", "the card: turns on the ring's type", 0.8, 1, "as A10: occurred with its unit corrected; not cleanly binary"),
 ("E1", "P6b", "the card: always", 0.04, 0, ""),
 ("E1", "P6c", "a ring by formula appears in this job", 0.03, 0, ""),
 ("E1", "P6d", "the count is slack somewhere on a held object", 0.3, None, "withdrawn by its author as not well posed (no test for \"slack\"): a slip"),
 ("E1", "P7", "a held object breaks the card's frame", 0.2, 0, ""),
 # FS136-E2 (plans/FS136-E2-derivation.md § 0.4; scored in its Stages 2–6 and § 7.3)
 ("E2", "Q1", "C136-FORCED derived, with the corner lemma added and its second sentence restated", 0.95, 1, ""),
 ("E2", "Q2a", "R7's pair: no corner emptied", 0.99, 1, ""),
 ("E2", "Q2b", "R7's pair: the twelve seed corners and exactly three more, then a stall", 0.8, 1, "not blind (worked by hand first)"),
 ("E2", "Q3a", "the flower's pair: all four corners at (−1, −1) forced 0, 1, 0, 1", 0.9, 1, ""),
 ("E2", "Q3b", "the flower's pair: a forced corner at a further point", 0.85, 1, "not blind"),
 ("E2", "Q3c", "the flower's closure still adding corners after four rounds", 0.3, 0, ""),
 ("E2", "Q4a", "the strip (c1) forces three corners at each common unit point", 0.9, 1, ""),
 ("E2", "Q4b", "the strip (c1) reaches a third point with a forced corner", 0.5, 1, ""),
 ("E2", "Q4c", "the strip (c2) forces nothing inside the strip", 0.85, 1, ""),
 ("E2", "Q5", "an empty corner in a closure, at a point other than the seed pair's two common unit points", 0.15, 0, ""),
 ("E2", "Q6a", "C136-STOP-GERMS: all three stops emptied by corners", 0.95, 1, ""),
 ("E2", "Q6b", "every bar first order on the strip and the disk", 0.85, 1, ""),
 ("E2", "Q6c", "on the bowtie fragment some label barred only at second order in each emptied corner", 0.8, 0, "lost: the corner the vertex figures empty is first order"),
]
print("| who | id | registered | p | outcome | Brier | note |")
print("|---|---|---|---|---|---|---|")
tot = {}
for who, i, what, p, o, note in ROWS:
    b = None if o is None else (p - o) ** 2
    print(f"| {who} | {i} | {what} | {p:g} | {'met' if o == 1 else ('no' if o == 0 else 'not scored')} | {'—' if b is None else f'{b:.4f}'} | {note} |")
    if b is not None:
        for k in (who, "all"):
            n, s = tot.get(k, (0, 0.0)); tot[k] = (n + 1, s + b)
print()
for k in ("card 1", "card 2", "E1", "E2", "all"):
    n, s = tot[k]
    print(f"{k}: scored={n} mean Brier={s / n:.4f}")
print(f"rows={len(ROWS)} not scored={sum(1 for r in ROWS if r[4] is None)}")
