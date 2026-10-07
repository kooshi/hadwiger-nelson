#!/usr/bin/env python3
"""FS124-I1 stage 1: every quotation in the brief against its source, by exact substring.

Adapted from the planner's `data/fs124/k1/readback.py` (not edited: this is a copy under this job's
folder).  Two changes: the source path is the first whitespace-delimited token after `— source:`
(this brief writes `<path> Stage 5` as well as `<path> § …`), and a relative path is resolved
against the main working tree, where the brief lives (argv[2], default: the brief's repository).

Reads the brief (argv[1]), takes every block of the form
    > <text>
    > — source: <path> [...]
and checks that <text>, with the leading '> ' of an inner quotation removed and whitespace runs
collapsed, is a substring of the source file with whitespace runs collapsed.

Exit 0 iff every quotation is found.  `--control` plants a fault (the case of one letter of each
quotation swapped) and exits 0 iff every planted quotation is NOT found (the check can fail).
"""
import re, sys, pathlib

def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()

def blocks(brief: str):
    out, cur = [], []
    for ln in brief.splitlines():
        if ln.startswith("> — source:"):
            out.append(("\n".join(cur), ln[len("> — source:"):].strip()))
            cur = []
        elif ln.startswith(">"):
            cur.append(ln[1:].lstrip())
        else:
            cur = []
    return out

def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    brief_path = pathlib.Path(args[0]).resolve()
    root = pathlib.Path(args[1]) if len(args) > 1 else brief_path.parents[3]
    bl = blocks(brief_path.read_text())
    if not bl:
        print("NO QUOTATIONS FOUND: the reader is broken"); sys.exit(2)
    bad = 0
    for text, src in bl:
        path = src.split()[0]
        f = root / path          # an absolute path stays itself
        if not f.exists():
            print(f"MISSING SOURCE  {path}"); bad += 1; continue
        hay = norm(f.read_text())
        t = norm(text)
        if t.startswith("> "):   # a quotation of a quotation
            t = t[2:]
        if control:
            i = next(j for j in range(min(10, len(t) - 1), len(t)) if t[j].isalpha())
            t = t[:i] + t[i].swapcase() + t[i + 1:]
        found = t in hay
        ok = (not found) if control else found
        print(f"{'ok  ' if ok else 'FAIL'} {'(control: planted, must be absent) ' if control else ''}{path}: {t[:70]!r}…")
        bad += (not ok)
    print(f"{len(bl)} quotations, {bad} failing{' (control run)' if control else ''}")
    sys.exit(1 if bad else 0)

if __name__ == "__main__":
    main()
