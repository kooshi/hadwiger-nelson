#!/usr/bin/env python3
"""FS132-Z2: Brier scores of FS-132's registered predictions.

Binary items: (lane, id, statement, p, outcome) with outcome 1 (occurred), 0 (did not), None (not scored).
Three-way items: (lane, id, statement, {branch: p}, branch that occurred or None); score = sum of squared errors
over the branches (range 0..2). Prints one markdown row per item and the mean per lane.

`--fault` flips the outcome of the first scored binary item; the printed means must change (the planted fault).
Run from the repository root:  python3 tools/fs132_z2_brier.py [--fault]
"""
import sys

B = [  # binary
    ("asking, morning", "M1", "EMPTY's argument runs on the extraction's data", 0.60, 0),
    ("asking, morning", "M2", "CV-EXISTS's does", 0.20, 0),
    ("asking, morning", "M3", "C132-EXT holds as stated at every k", 0.80, 1),
    ("asking, morning", "M4", "it holds with 'closed and totally disconnected' in place of 'finite'", 0.50, None),
    ("asking, morning", "M5", "C132-DIAG holds as the reading reads it", 0.70, 1),
    ("asking, morning", "M6", "C132-RADIUS", 0.85, None),
    ("asking, morning", "M7", "card 3's first branch", 0.35, 0),
    ("asking, morning", "M8", "this milestone decides six against seven outright", 0.03, 0),
    ("asking, after round 1", "A1", "C132-COMP derived at the first attempt", 0.85, 1),
    ("asking, after round 1", "A2", "C132-PLACE's list with the third label forced in the differing case", 0.60, 1),
    ("asking, after round 1", "A4", "C132-WIT", 0.90, 1),
    ("asking, after round 1", "A6", "C132-GRUNDY7", 0.60, 0),
    ("asking, after round 1", "A7", "C132-LONG for every weak colouring within two jobs", 0.07, 0),
    ("asking, after round 1", "A8", "C132-LONG for honest colourings within two jobs", 0.15, 0),
    ("asking, after round 1", "A9", "six against seven decided by this milestone", 0.03, 0),
    ("asking, after round 2", "B1", "C132-LENS derived (as posed, with clauses (i) and (ii))", 0.65, 0),
    ("asking, after round 2", "B3", "C132-ARC derived", 0.60, None),
    ("asking, after round 2", "B4", "a seed shown to exist in every weak six-colouring within two jobs", 0.03, 0),
    ("asking, after round 2", "B5", "six against seven decided by this milestone", 0.03, 0),
    ("asking, after round 2", "B6", "the riding controls: two unchanged and margin-witness finds the vertex's labels", 0.80, 0),
    ("asking, after round 2", "B7", "the third round is answered off its branch table", 0.25, None),
    ("FS132-E1", "P1", "C132-EXT holds as posed at every k", 0.93, 1),
    ("FS132-E1", "P2", "C132-CORES with no hypothesis, every closed disc of radius above 1", 0.90, 1),
    ("FS132-E1", "P3a", "'closed and totally disconnected' suffices by the manuscript's argument", 0.05, 0),
    ("FS132-E1", "P3b", "some hypothesis weaker than finite suffices by another argument", 0.55, None),
    ("FS132-E1", "P5", "C132-RUN-CV derived", 0.10, 0),
    ("FS132-E1", "P6a", "C132-DIAG holds", 0.75, 1),
    ("FS132-E1", "P6b", "C132-RADIUS holds as posed", 0.85, None),
    ("FS132-E1", "P7", "this milestone decides six against seven", 0.02, 0),
    ("FS132-E2", "Q1a", "card 3's first branch as worded", 0.10, 0),
    ("FS132-E2", "Q1b", "nothing stays essential", 0.75, 1),
    ("FS132-E2", "Q3", "the difference located at one named step, with both controls", 0.80, 1),
    ("FS132-E2", "Q4", "invention needed", 0.25, 0),
    ("FS132-E3", "DIAG", "C132-DIAG holds", 0.80, 1),
    ("FS132-E3", "RADIUS", "C132-RADIUS holds as posed", 0.85, None),
    ("FS132-E4", "P1", "C132-COMP derived, in a form sharper than posed", 0.93, 1),
    ("FS132-E4", "P1r", "C132-COMP refuted by a held fragment", 0.02, 0),
    ("FS132-E4", "P2", "C132-PLACE's list derived for constant and step germs, the formula only for measurable ones", 0.85, 1),
    ("FS132-E4", "P2f", "a colouring by formula realizing an open line, built", 0.05, 0),
    ("FS132-E4", "P3", "C132-TURN stalls", 0.80, 1),
    ("FS132-E4", "P3a", "its alternating half derived on the way", 0.80, 1),
    ("FS132-E4", "P3d", "C132-TURN derived whole", 0.05, 0),
    ("FS132-E4", "P3r", "C132-TURN refuted by a colouring by formula", 0.03, 0),
    ("FS132-E5", "W1", "C132-WIT, the exclusion, derived as an instance", 0.95, 1),
    ("FS132-E5", "W2", "C132-WIT, the strips, derived with the side rule", 0.90, 1),
    ("FS132-E5", "W3d", "C132-WIT-EX: a defect of the statement", 0.80, 1),
    ("FS132-E5", "G1", "C132-GRUNDY7: first clause derived, thinly", 0.90, 1),
    ("FS132-E5", "G2", "C132-GRUNDY7: second clause not a statement", 0.85, 1),
    ("FS132-E5", "G3", "C132-GRUNDY7: some form of the second clause derived", 0.30, 0),
    ("FS132-E6", "L1", "C132-LENS, first sentence, derived", 0.97, 1),
    ("FS132-E6", "L2", "C132-LENS (i) derived", 0.97, 1),
    ("FS132-E6", "L3", "C132-LENS (ii) not derived as posed", 0.85, 1),
    ("FS132-E6", "L4", "C132-LENS (ii) derived in a narrower form", 0.90, 1),
    ("FS132-E6", "PL1", "C132-PLACED: the exclusion does not apply on the orbit through x", 0.80, 1),
    ("FS132-E6", "PL2", "C132-PLACED: a four-cycle of witnessed edges forced closed", 0.10, 0),
    ("FS132-E6", "ARC", "C132-ARC not reached in this context", 0.60, 1),
]

T = [  # three-way
    ("asking, after round 1", "A3", "C132-TURN", {"derived": 0.45, "stalls": 0.40, "refuted": 0.15}, "stalls"),
    ("asking, after round 1", "A5", "C132-WIT-EX", {"derived": 0.30, "stalls": 0.50, "refuted": 0.20}, "stalls"),
    ("asking, after round 2", "B2", "C132-PLACED", {"the exclusion applies on an orbit": 0.25, "a mixed ring": 0.55, "off this table": 0.20}, "a mixed ring"),
    ("FS132-E1", "P4", "C132-RUN-EMPTY", {"derived": 0.45, "stalls": 0.45, "refuted": 0.10}, "stalls"),
    ("FS132-E2", "Q2", "C132-LONG", {"derived": 0.03, "stalls": 0.95, "refuted": 0.02}, "stalls"),
    ("FS132-E3", "CV", "C132-RUN-CV", {"stalls": 0.85, "derived": 0.10, "refuted": 0.05}, "stalls"),
    ("FS132-E5", "W3", "C132-WIT-EX", {"derived": 0.10, "stalls": 0.75, "refuted": 0.05}, "stalls"),
]


def main():
    fault = "--fault" in sys.argv
    rows, lanes = [], {}
    flipped = False
    for lane, i, s, p, o in B:
        if fault and not flipped and o is not None:
            o, flipped = 1 - o, True
        if o is None:
            rows.append((lane, i, s, f"{p:.2f}", "not scored", "—"))
            continue
        b = (p - o) ** 2
        lanes.setdefault(lane, []).append(b)
        rows.append((lane, i, s, f"{p:.2f}", "occurred" if o else "did not", f"{b:.4f}"))
    tri = {}
    for lane, i, s, d, o in T:
        b = sum((p - (1.0 if k == o else 0.0)) ** 2 for k, p in d.items())
        tri.setdefault(lane, []).append(b)
        reg = ", ".join(f"{k} {p:.2f}" for k, p in d.items())
        rows.append((lane, i, s, reg, o, f"{b:.4f} (three-way)"))
    for r in rows:
        print("| " + " | ".join(r) + " |")
    print()
    allb = []
    for lane, v in lanes.items():
        allb += v
        t = tri.get(lane, [])
        print(f"{lane}: binary n={len(v)} mean Brier={sum(v)/len(v):.4f}"
              + (f"; three-way n={len(t)} mean={sum(t)/len(t):.4f}" if t else ""))
    asking = [b for lane, v in lanes.items() if lane.startswith("asking") for b in v]
    der = [b for lane, v in lanes.items() if lane.startswith("FS132") for b in v]
    print(f"asking lane, all three registrations: binary n={len(asking)} mean Brier={sum(asking)/len(asking):.4f}")
    print(f"derivers, all six: binary n={len(der)} mean Brier={sum(der)/len(der):.4f}")
    print(f"all binary: n={len(allb)} mean Brier={sum(allb)/len(allb):.4f}")


if __name__ == "__main__":
    main()
