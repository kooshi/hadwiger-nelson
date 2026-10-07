#!/usr/bin/env python3
"""FS124-Z1, stage 5: Brier scores of the registered predictions (binary: (p - outcome)^2;
a card's branches: the sum over branches). Outcomes are read from the records named in the
record's Stage 5 table; --fault flips every binary outcome (the means must move)."""
import sys
flip = "--fault" in sys.argv
B = {  # who: [(label, p, occurred)]
 "first card (FS124-P1)": [("RADIUS up as posed",.90,1),("RADIUS down",.92,1),("CENTRE as posed",.92,1),("COMPLETION as posed",.85,1),
   ("KIND by formula",.80,1),("HALF as posed",.65,1),("explicit-radius exclusion",.10,0),("object past phi^2/sqrt2",.12,0),("six against seven decided",.03,0)],
 "second card (FS124-P2)": [("statement holds on strip and disk",.9,1),("another pattern on an unread object",.5,1),("save by one member on a held object",.1,1),
   ("every tight arc an edge of a save",.6,0),("EDGE holds as read",.7,1),("SECOND as posed",.9,1),("explicit-radius exclusion",.07,0),
   ("object above the strip or outside the disk",.12,0),("six against seven decided",.03,0)],
 "first deriver (P1-P7)": [("P1 up",.95,1),("P1 down",.95,1),("P2 CENTRE",.97,1),("P2 COMPLETION",.95,1),("P2 STRADDLE",.90,1),("P2 ANTIPODE",.85,1),
   ("P3 nothing forced",.85,1),("P3 R7",.90,1),("P4",.93,1),("P5 as posed",.85,1),("P5 says less",.40,1),("P6",.75,1),("P7",.80,1)],
 "second deriver (Q1-Q5)": [("Q1 maps",.85,1),("Q1 another pattern",.8,1),("Q1 every sector member separates",.9,0),("Q1 bowtie alone",.6,1),
   ("Q2 pieces",.9,1),("Q2 sector",.9,1),("Q2 fails by the letter",.7,1),("Q3 excluded",.85,1),("Q3 object at a full member",.03,0),
   ("Q4 edge",.8,1),("Q4 SECOND",.9,1),("Q4 FOUR",.8,1),("Q5",.8,1)],
}
M = {  # branches: (probabilities, index that occurred)
 "first card: C124-SIX (as posed / restated / refuted)": ((.70,.25,.05),0),
 "first card: the card (recurs / runs out / nothing beyond the first step)": ((.50,.12,.38),2),
 "second card: C124-FORCED (as posed / restated at its wording / other)": ((.80,.15,.05),1),
 "second card: C124-ONE-MEMBER (object / excluded / gap)": ((.45,.20,.35),1),
 "second card: the card (one edge of each forced / a save by one member exists / neither)": ((.20,.45,.35),0),
}
tot = n = 0
for who, rows in B.items():
    s = [(p - ((1 - o) if flip else o)) ** 2 for _, p, o in rows]
    tot += sum(s); n += len(s)
    print(f"{who}: n={len(s)} met={sum(o for *_, o in rows)} mean-Brier={sum(s)/len(s):.3f}")
    for (lab, p, o), b in zip(rows, s):
        print(f"   {lab}: p={p} outcome={o} brier={b:.4f}")
print(f"all binary: n={n} mean-Brier={tot/n:.3f}")
for k, (ps, i) in M.items():
    print(f"{k}: brier={sum((p - (1 if j == i else 0)) ** 2 for j, p in enumerate(ps)):.4f}")
