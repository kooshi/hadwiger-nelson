#!/usr/bin/env python3
"""FS131-I8B, stage 1 (the form of tools/fs131_k8b_quotes.py, which is another job's and is not edited): check every quotation of a brief against its source (standing rule 3).

A quotation is a block of consecutive lines beginning "> " that ends with a line "> — source: <path>[ § …]".
Each quoted text (the block joined by single spaces, whitespace collapsed) must occur in the source with
whitespace collapsed.  Relative paths resolve against --root (the main checkout), then against --alt.

Exit 0 when every quotation is found; exit 1 and name each one that is not.
--fault plants a one-word change in the first quotation, which must then be reported missing (exit 1).
"""
import argparse
import pathlib
import re
import sys


def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def quotations(text: str):
    block = []
    for line in text.splitlines():
        s = line.lstrip()
        if s.startswith(">"):
            block.append(s[1:].strip())
            continue
        if block:
            yield block
            block = []
    if block:
        yield block


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("brief")
    ap.add_argument("--root", default="/home/kooshi/source/lean-dir")
    ap.add_argument("--alt", default="/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b")
    ap.add_argument("--fault", action="store_true")
    a = ap.parse_args()
    text = pathlib.Path(a.brief).read_text()
    n = bad = 0
    for block in quotations(text):
        src_lines = [b for b in block if b.startswith("— source:")]
        if not src_lines:
            print(f"NO SOURCE LINE: {block[0][:80]!r}")
            bad += 1
            continue
        src = src_lines[0][len("— source:"):].strip()
        path = src.split(" § ")[0].strip()
        body = norm(" ".join(b for b in block if not b.startswith("— source:")))
        n += 1
        if a.fault and n == 1:
            body = body.replace("mechanical", "mechanicaI", 1) if "mechanical" in body else body + " PLANTED"
        cands = [pathlib.Path(path)] if path.startswith("/") else [pathlib.Path(a.root) / path, pathlib.Path(a.alt) / path]
        found = False
        where = None
        for c in cands:
            if c.is_file() and body in norm(c.read_text()):
                found, where = True, c
                break
        if found:
            print(f"ok   {n:2d}  {str(where)[-70:]:70s}  {body[:60]!r}")
        else:
            bad += 1
            print(f"MISS {n:2d}  {path}  {body[:100]!r}")
    print(f"quotations={n} missing={bad}")
    if n == 0:
        print("NO QUOTATION FOUND: the check did not run")
        return 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
