#!/usr/bin/env python3
"""FS131-I5j: check a brief's block quotations verbatim against their sources (standing rule 3).

A quotation is a run of `> ` lines followed by a `> — source: <address>` line. The address's first
token that names an existing file (absolute, or relative to the main tree or the worktree) is the
source; a relative path resolves to the main tree's copy first (the brief's own tree), an absolute one
as given. The quoted text, with line breaks folded
to single spaces, must occur in the source with its line breaks folded the same way.

Usage: fs131_i5_quote_check.py BRIEF MAIN_TREE WORKTREE [--plant]
`--plant` changes one letter of the first quotation and expects a MISMATCH (the negative control).
Exit 0 only when every quotation is found (or, under --plant, when the planted one is caught).
"""
import os
import re
import sys


def fold(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def resolve(addr: str, main: str, wt: str) -> str | None:
    for tok in re.split(r"[\s(),;]+", addr):
        tok = tok.strip("`")
        if not tok:
            continue
        if tok == "CLAUDE.md":
            return os.path.join(main, "CLAUDE.md")
        for base in ([""] if os.path.isabs(tok) else [main, wt]):
            p = os.path.join(base, tok) if base else tok
            if os.path.isfile(p):
                return p
    return None


def quotes(brief: str):
    lines = open(brief, encoding="utf-8").read().splitlines()
    buf = []
    for ln in lines:
        if ln.startswith("> — source:"):
            yield fold(" ".join(buf)), ln[len("> — source:"):].strip()
            buf = []
        elif ln.startswith("> "):
            buf.append(ln[2:])
        else:
            buf = []


def main() -> int:
    brief, main_tree, wt = sys.argv[1:4]
    plant = "--plant" in sys.argv
    bad = 0
    n = 0
    for i, (q, addr) in enumerate(quotes(brief)):
        n += 1
        if plant and i == 0:
            q = q.replace("practically", "practicaly", 1) if "practically" in q else q[:-1] + ("x" if q[-1] != "x" else "y")
        src = resolve(addr, main_tree, wt)
        if src is None:
            print(f"UNRESOLVED  {q[:70]!r}  <- {addr}")
            bad += 1
            continue
        ok = q in fold(open(src, encoding="utf-8").read())
        print(f"{'verbatim' if ok else 'MISMATCH'}  {q[:90]!r}  <- {os.path.relpath(src, main_tree) if src.startswith(main_tree) else src}")
        bad += 0 if ok else 1
    print(f"{n} quotations, {bad} not verbatim")
    if plant:
        return 0 if bad >= 1 else 1
    return 0 if (bad == 0 and n > 0) else 1


if __name__ == "__main__":
    sys.exit(main())
