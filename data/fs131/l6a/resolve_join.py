#!/usr/bin/env python3
"""FS131-L6A: resolve a diff3 hunk whose base is empty as theirs' lines then ours', with NO blank line between them —
for a Markdown table (ARCHITECTURE.md) and an import list (Proofs.lean), where `tools/fs131_l6a_keepboth.py resolve`'s
blank line between adjacent blocks would split the table. Refuses a hunk with a non-empty base. The result is checked
by `tools/fs131_l6a_keepboth.py check` like any other resolution. usage: resolve_join.py <file> [<file> ...]"""
import sys
for path in sys.argv[1:]:
    out, state, n = [], None, 0
    O, B, T = [], [], []
    for ln in open(path, encoding="utf-8").read().split("\n"):
        if ln.startswith("<<<<<<< "):
            state, n, O, B, T = "o", n + 1, [], [], []
        elif ln.startswith("||||||| ") and state == "o":
            state = "b"
        elif ln == "=======" and state == "b":
            state = "t"
        elif ln.startswith(">>>>>>> ") and state == "t":
            state = None
            if any(l.strip() for l in B):
                sys.exit(f"REFUSED: hunk {n} of {path} has a base")
            if any(not l.strip() for l in O + T):
                sys.exit(f"REFUSED: hunk {n} of {path} holds a blank line")
            out.extend(T + O)
        elif state == "o":
            O.append(ln)
        elif state == "b":
            B.append(ln)
        elif state == "t":
            T.append(ln)
        else:
            out.append(ln)
    if state is not None or n == 0:
        sys.exit(f"REFUSED: {path}: {n} hunk(s), unterminated={state is not None}")
    open(path, "w", encoding="utf-8").write("\n".join(out))
    print(f"resolved {n} hunk(s) in {path}: theirs' lines, then ours', no blank line between")
