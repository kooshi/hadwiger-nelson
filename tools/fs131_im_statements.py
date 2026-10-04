#!/usr/bin/env python3
"""FS131-IM1: the three moves' statements, copied by script from `Contact` (at d4f946ae) into `Moves` as `…_aux`.

    python3 tools/fs131_im_statements.py --print   # print each statement block as it should appear in Moves
    python3 tools/fs131_im_statements.py --check   # check that Moves holds each `…_aux` with the statement text of Contact's
                                                   # leaf, character for character after the name (hypotheses, binders,
                                                   # conclusion), and print the diff of the statement text (empty when equal)

A statement block runs from `theorem <name>` to the first `:= by` that ends a line. Exit 0 only when all three match.
"""
import difflib
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_REV = "d4f946ae"
CONTACT = "Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean"
MOVES = "Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean"
NAMES = ["exists_shave", "exists_rayMerge", "exists_merge"]


def block(text, name):
    m = re.search(rf"^theorem {re.escape(name)} .*?:= by$", text, re.S | re.M)
    return m.group(0) if m else None


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in ("--print", "--check"):
        print(__doc__)
        return 2
    src = subprocess.run(["git", "show", f"{SRC_REV}:{CONTACT}"], cwd=ROOT, check=True, capture_output=True, text=True).stdout
    bad = 0
    if sys.argv[1] == "--print":
        for n in NAMES:
            b = block(src, n)
            if b is None:
                print(f"FAIL: no statement of {n} in {CONTACT} at {SRC_REV}")
                return 1
            print(b.replace(f"theorem {n} ", f"theorem {n}_aux ", 1) + "\n")
        return 0
    moves = (ROOT / MOVES).read_text()
    for n in NAMES:
        s = block(src, n)
        t = block(moves, n + "_aux")
        if s is None or t is None:
            print(f"FAIL: {n}: statement missing ({'Contact' if s is None else 'Moves'})")
            bad += 1
            continue
        s_body = s[len(f"theorem {n}"):]
        t_body = t[len(f"theorem {n}_aux"):]
        diff = list(difflib.unified_diff(s_body.split("\n"), t_body.split("\n"), f"Contact:{n}", f"Moves:{n}_aux", lineterm=""))
        if diff:
            print(f"FAIL: {n}: statement text differs\n" + "\n".join(diff))
            bad += 1
        else:
            print(f"ok: {n}_aux has Contact's statement of {n} verbatim ({len(s_body.splitlines())} lines; diff empty)")
    if bad:
        print(f"FAIL: {bad} statement(s) differ")
        return 1
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
