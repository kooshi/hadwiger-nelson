#!/usr/bin/env python3
"""FS131-I8B — `star_anti` changed by exactly the two ruled binders.

Reads a log of tools/fs131_i8b_stmt.py (its `base:` and `now:` lines for `star_anti`, the kernel's statements printed
with full names) and checks that the statement now is the base statement with the two ruled hypotheses inserted, in
order, immediately before the conclusion `tp ≠ tm ∧ …`, and nothing else changed.

Exit 0: exactly that. Exit 1: anything else. Exit 2: the log holds no `star_anti` pair (the check did not run).
--fault drops the second binder from the expected insertion, so the check must exit 1.
"""
import sys

B1 = "(∀ (T : Set ℂ), F.TileAt p T → T ≠ tp → ψ + Real.pi / 2 ∉ HadwigerNelson.Plane.coneAt T p) → "
B2 = "(∀ (T : Set ℂ), F.TileAt p T → T ≠ tm → ψ - Real.pi / 2 ∉ HadwigerNelson.Plane.coneAt T p) → "
ANCHOR = "ψ - Real.pi / 2 ∈ interior (HadwigerNelson.Plane.coneAt tm p) → "


def main():
    args = [a for a in sys.argv[1:] if a != "--fault"]
    fault = "--fault" in sys.argv[1:]
    lines = open(args[0], encoding="utf-8").read().splitlines()
    base = now = None
    for i, l in enumerate(lines):
        if l.startswith("DIFF ") and l.split(": ")[1] == "HadwigerNelson.Plane.ArcMap.star_anti":
            base = lines[i + 1].strip()[len("base: "):]
            now = lines[i + 2].strip()[len("now:"):].strip()
    if base is None or now is None:
        print("INSTRUMENT FAILURE: no base/now pair for star_anti in the log")
        return 2
    if base.count(ANCHOR) != 1:
        print("INSTRUMENT FAILURE: the anchor (the hypothesis hm) is not found exactly once in the base statement")
        return 2
    ins = B1 + ("" if fault else B2)
    expected = base.replace(ANCHOR, ANCHOR + ins)
    ok = expected == now and expected.split(ANCHOR + ins)[1].startswith("tp ≠ tm ∧ ")
    print(("OK" if ok else "MISMATCH") + ": star_anti now is its base statement with the two ruled binders after hm"
          + ("" if ok else " — NOT so"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
