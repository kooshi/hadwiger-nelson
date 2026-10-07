#!/usr/bin/env python3
"""FS131-L8A stage 5: the two doc comments of `Plane/RingCalculus/Empty` ruled by the coordinator mid-job (its message of
2026-10-06 on `v6_hubs`: "the docstrings of `v6_hubs` and `v6_hug` lose the scan's `VACUITY DECLARED:` marker and say the joint
vacuity in words the scan does not parse, with every fact kept … Your touches are extended to exactly these two doc comments in
`Empty`"). Exact replacements; each old text must stand exactly once, or nothing is written. `--list` prints before and after.
After the edit the scan's marker string (the two words followed by a colon) must not occur in the file: checked here."""
import sys

PATH = "Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean"
MARKER = "VACUITY DECLARED" + ":"
EDITS = [
    ("v6_hubs",
     "VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation and is consumed\n"
     "nowhere else. -/\n"
     "theorem v6_hubs ",
     "**Jointly vacuous, and a kernel fact (`v6_hubs_vacuous`)**: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a\n"
     "step of that refutation and is consumed nowhere else. (Not the scan's `VACUITY DECLARED` marker, which claims that one\n"
     "binder's carrier is empty; here each hypothesis is satisfiable alone and the five are not together.) -/\n"
     "theorem v6_hubs "),
    ("v6_hug",
     "VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation. Outside the\n"
     "Γ-free class the statement to use is `doubleTip`. (The proof reads no Γ-free ring: it is\n"
     "`not_sole_tip_of_adjacent_changePoints`, `Plane/RingCalculus/SoleTip`, which `emptyNS` consumes.) -/\n"
     "theorem v6_hug ",
     "**Jointly vacuous, and a kernel fact (`v6_hug_vacuous`)**: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a\n"
     "step of that refutation. (Not the scan's `VACUITY DECLARED` marker, which claims that one binder's carrier is empty; here\n"
     "each of the first five hypotheses is satisfiable alone and the five are not together. The statement concludes `False`, so\n"
     "the scan skips it as a refutation and reads no marker on it.) Outside the Γ-free class the statement to use is\n"
     "`doubleTip`. (The proof reads no Γ-free ring: it is `not_sole_tip_of_adjacent_changePoints`,\n"
     "`Plane/RingCalculus/SoleTip`, which `emptyNS` consumes.) -/\n"
     "theorem v6_hug "),
]


def main():
    s = open(PATH, encoding="utf-8").read()
    if "--list" in sys.argv[1:]:
        for what, old, new in EDITS:
            print(f"## {PATH} — the docstring of {what}\n--- before\n{old}\n+++ after\n{new}\n")
        return 0
    for what, old, new in EDITS:
        if s.count(old) != 1:
            sys.stderr.write(f"REFUSED: {what}: the old text stands {s.count(old)} time(s), expected 1 — nothing written\n")
            return 1
        s = s.replace(old, new)
    if MARKER in s:
        sys.stderr.write("REFUSED: the scan's marker string still occurs in the file — nothing written\n")
        return 1
    open(PATH, "w", encoding="utf-8").write(s)
    print(f"applied {len(EDITS)} edits in {PATH}; the scan's marker string occurs 0 times")
    return 0


if __name__ == "__main__":
    sys.exit(main())
