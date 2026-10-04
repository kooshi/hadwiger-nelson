#!/usr/bin/env python3
"""FS129-Z2 — Brier scores of FS-129's registered binary predictions (plans/FS129-Z2-record.md § Stage 6 holds the table with sources).

Each row: (registrant, prediction id, probability registered, outcome 1/0). Probabilities and outcomes are transcribed from the registrant's record
(addresses in the record's table); this script only does the arithmetic, per registrant, per lane and pooled.

    python3 tools/fs129_z2_scores.py           # print the Brier scores
    python3 tools/fs129_z2_scores.py --fault   # flip one outcome (Poros A6) — the printed scores change (it fires)
"""
import sys

ROWS = [
    # Poros, plans/POROS-2026-10-03-fs129-card.md § 1.2
    ("Poros", "A1 a pass-1 close, P(>=1)", 0.45, 1), ("Poros", "A2 shortenings, P(>=3)", 0.60, 1),
    ("Poros", "A4 item 31 or the top three changes", 0.20, 1), ("Poros", "A5 lane A shortens a regularity-era step", 0.35, 1),
    ("Poros", "A6 pass 2 out-yields pass 1", 0.60, 0), ("Poros", "A7 another FS116-Y4-type miss", 0.60, 0),
    # FS129-OA1 § 1.3
    ("OA1", "E1 P(>=1 close)", 0.10, 0), ("OA1", "E2 P(>=1 shortened)", 0.55, 1), ("OA1", "E2 P(>=3 shortened)", 0.15, 0),
    ("OA1", "E4 lane moves the bearing", 0.07, 0), ("OA1", "E5 = Poros A5", 0.30, 1), ("OA1", "E6 a held result false", 0.03, 0),
    ("OA1", "E7 P(>=1 composition outside the list)", 0.50, 1), ("OA1", "E9 J4 yields", 0.30, 0),
    # FS129-OR1 § Registered expectations
    ("OR1", "P(>=1 close)", 0.15, 1), ("OR1", "J10 a lane-R result bears", 0.35, 1), ("OR1", "J15 the collision stands", 0.40, 0),
    ("OR1", "lane moves the bearing", 0.12, 1), ("OR1", "a held result false", 0.04, 0),
    # FS129-MA1 § 1.3 / § 5.3
    ("MA1", "E2 P(>=3 unapplied)", 0.60, 1), ("MA1", "E4 P(>=1 Y4-kind miss)", 0.55, 0), ("MA1", "E5 Falconer differs materially", 0.15, 0),
    ("MA1", "E6 bearing changes", 0.06, 0), ("MA1", "E7 a held result false", 0.03, 0), ("MA1", "E8 P(>=1 new cross-era site)", 0.45, 0),
    # FS129-MA2 § 1.3 / § 4.3
    ("MA2", "E2 P(>=3 unapplied)", 0.65, 1), ("MA2", "E4 P(>=1 Y4-kind miss)", 0.40, 0), ("MA2", "E5 P(>=1 new cross-era site)", 0.35, 0),
    ("MA2", "E6 bearing changes", 0.05, 0), ("MA2", "E7 a held result false", 0.03, 0), ("MA2", "E9 a root yields a travelling strengthening", 0.20, 0),
    # FS129-MR1 § Registered expectations, scored ("partly" left out)
    ("MR1", "G83's straddle bears on an unapplied held step", 0.55, 1), ("MR1", "the bends shorten an FS-110 GAP", 0.45, 0),
    ("MR1", "a held result false", 0.04, 0), ("MR1", "this pass changes the bearing", 0.10, 0),
    # FS129-SA1 § 6.4
    ("SA1", "E8 a held result false beyond FS89-CL2", 0.12, 0), ("SA1", "E9 an attack on a lane-A composition succeeds", 0.10, 0),
    # FS129-SR1 § 6.4 (its own seven)
    ("SR1", "bends' disagreement settled by WHOLE", 0.55, 1), ("SR1", "attack on QFREE succeeds", 0.15, 0), ("SR1", "attack on DOUBLETIP succeeds", 0.15, 0),
    ("SR1", "a repair narrower than the composition", 0.25, 0), ("SR1", "a held result false", 0.22, 0), ("SR1", "reach the end of the vacuity sort", 0.60, 1),
    ("SR1", "an empty class inherited where it matters", 0.30, 0),
    # FS129-SR2 § 4.4 (its two scored)
    ("SR2", "a held result false", 0.12, 0), ("SR2", "reach the end of the sweep", 0.55, 1),
    # FS129-SR3 § 5.2 (its six)
    ("SR3", "(a) a held result kills a residue", 0.30, 1), ("SR3", "(b) a wider V6-ADJ derived", 0.40, 1), ("SR3", "(c) a held result shown false", 0.10, 0),
    ("SR3", "this job finds a held result false", 0.08, 0), ("SR3", "all named items reached", 0.75, 1), ("SR3", "(d) the chain reads simple at p alone", 0.40, 1),
]
LANE = {"OA1": "A", "MA1": "A", "MA2": "A", "SA1": "A", "OR1": "R", "MR1": "R", "SR1": "R", "SR2": "R", "SR3": "R", "Poros": "card"}


def main():
    rows = list(ROWS)
    if "--fault" in sys.argv:
        rows = [(r, i, p, (1 - o) if i.startswith("A6") else o) for r, i, p, o in rows]
    by = {}
    for r, i, p, o in rows:
        by.setdefault(r, []).append((p - o) ** 2)
    for r, v in by.items():
        print(f"{r}: n={len(v)} Brier={sum(v) / len(v):.4f} met-as-registered-above-0.5={sum(1 for rr, i, p, o in rows if rr == r and (p > 0.5) == (o == 1))}/{len(v)}")
    for ln in ("A", "R"):
        v = [x for r, xs in by.items() if LANE[r] == ln for x in xs]
        print(f"lane {ln}: n={len(v)} Brier={sum(v) / len(v):.4f}")
    v = [x for r, xs in by.items() if r != "Poros" for x in xs]
    print(f"readers pooled: n={len(v)} Brier={sum(v) / len(v):.4f}")


main()
