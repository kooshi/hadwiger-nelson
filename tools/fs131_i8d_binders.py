#!/usr/bin/env python3
"""FS131-I8D — the five ruled statements changed by exactly the one ruled binder (the form of the join job's
tools/fs131_i8b_binders.py, another job's, not edited).

Reads a log of tools/fs131_i8d_stmt.py (its `base:` and `now:` lines, the kernel's statements printed with full
names) and checks, for each of the five declarations of the ruling, that the statement now is the base statement
with the hypothesis `4 ≤ (F.coloursAt p).ncard` — which must occur exactly once in the base, as a hypothesis —
replaced by `(F.coloursAt p).ncard = 4`, and nothing else changed.

Exit 0: exactly that, for all five. Exit 1: anything else. Exit 2: a declaration's base/now pair is not in the log
(the check did not run).
--fault expects `= 5` in place of `= 4`, so the check must exit 1 on every declaration.
"""
import sys

NS = "HadwigerNelson.Plane.ArcMap."
NAMES = ["crossed_four", "crossed_changePoint", "crossed_semiHub", "semiHub_places", "transferQC"]
OLD = "→ 4 ≤ (F.coloursAt p).ncard → "
NEW = "→ (F.coloursAt p).ncard = 4 → "


def main():
    args = [a for a in sys.argv[1:] if a != "--fault"]
    fault = "--fault" in sys.argv[1:]
    new = NEW.replace("= 4", "= 5") if fault else NEW
    lines = open(args[0], encoding="utf-8").read().splitlines()
    pairs = {}
    for i, l in enumerate(lines):
        if l.startswith("DIFF ") and ": CHANGED" in l:
            name = l.split(": ")[1]
            pairs[name] = (lines[i + 1].strip()[len("base: "):], lines[i + 2].strip()[len("now:"):].strip())
    bad = 0
    for n in NAMES:
        if NS + n not in pairs:
            print(f"INSTRUMENT FAILURE: no base/now pair for {n} in the log")
            return 2
        base, now = pairs[NS + n]
        if base.count(OLD) != 1:
            print(f"INSTRUMENT FAILURE: the hypothesis `4 ≤ (F.coloursAt p).ncard` occurs {base.count(OLD)} times in the base statement of {n}")
            return 2
        ok = base.replace(OLD, new) == now
        bad += 0 if ok else 1
        print(("OK       " if ok else "MISMATCH ") + f"{n}: now is its base statement with `4 ≤ (F.coloursAt p).ncard` replaced by "
              f"`(F.coloursAt p).ncard = {'5' if fault else '4'}`" + ("" if ok else " — NOT so"))
    extra = sorted(set(pairs) - {NS + n for n in NAMES})
    if extra:
        print("OTHER CHANGED DECLARATIONS IN THE LOG: " + ", ".join(extra))
        bad += 1
    print(f"binders: {len(NAMES) - bad if bad <= len(NAMES) else 0} of {len(NAMES)} as ruled")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
