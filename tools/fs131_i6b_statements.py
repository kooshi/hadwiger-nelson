#!/usr/bin/env python3
"""FS131-I6B: no statement or definition changed since the commit the branch was cut from.

For each file given (default: the three modules of Plane/Saturated that stood at BASE), strip every doc comment
('/-- … -/', '/-! … -/') from the BASE version and from the working-tree version, drop blank lines, and require the
BASE lines — less the 'sorry' lines, which a proof may replace — to be a subsequence, in order, of the working-tree
lines. So a declaration's keyword, name, binders, hypotheses, conclusion and every definition body must stand verbatim;
only doc comments may change, and lines may be added (helpers, proofs, imports). Also requires at least one BASE line
per file (a check that read nothing is not a pass).

Usage: python3 tools/fs131_i6b_statements.py [--plant]
  --plant alters one definition line of the working-tree text in memory (InP's '∀ i m, σ i < σ m →' to
  '∀ i m, σ i ≤ σ m →'; the first plant tried hit a doc comment, which the check rightly ignores, and passed): the
  check must then fail on MapColouring and exit 1. The plant asserts that it changed a line the check reads."""
import re, subprocess, sys, pathlib

BASE = "3928644b"
TREE = pathlib.Path(__file__).resolve().parent.parent
FILES = ["Proofs/HadwigerNelson/Plane/Saturated/Basic.lean",
         "Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean",
         "Proofs/HadwigerNelson/Plane/Saturated/MapColouring.lean"]
DOC = re.compile(r"/-[-!].*?-/", re.S)


def lines(text):
    return [l.rstrip() for l in DOC.sub("", text).splitlines() if l.strip()]


bad = 0
for f in FILES:
    old = subprocess.run(["git", "-C", str(TREE), "show", f"{BASE}:{f}"], capture_output=True, text=True, check=True).stdout
    new = (TREE / f).read_text()
    if "--plant" in sys.argv and f.endswith("MapColouring.lean"):
        before = lines(new)
        assert new.count("∀ i m, σ i < σ m →") == 1
        new = new.replace("∀ i m, σ i < σ m →", "∀ i m, σ i ≤ σ m →")
        assert lines(new) != before, "the plant changed no line the check reads"
    want = [l for l in lines(old) if l.strip() != "sorry"]
    have = lines(new)
    if not want:
        print(f"EMPTY    | {f}: no line read at {BASE}")
        bad += 1
        continue
    i, missing = 0, None
    for l in want:
        while i < len(have) and have[i] != l:
            i += 1
        if i == len(have):
            missing = l
            break
        i += 1
    if missing is None:
        print(f"kept     | {f}: {len(want)} lines of {BASE} stand in order ({len(have)} now)")
    else:
        print(f"CHANGED  | {f}: line of {BASE} not found in order: {missing[:110]}")
        bad += 1
print(f"files: {len(FILES)}  kept: {len(FILES) - bad}  changed: {bad}")
sys.exit(1 if bad else 0)
