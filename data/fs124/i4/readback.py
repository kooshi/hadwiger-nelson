#!/usr/bin/env python3
"""FS124-I2 stage 1 (copied from data/fs124/k2/readback.py; a source address may carry a trailing "Stage n" after the file name; sources are looked up in this worktree,
then in the main working tree, and absolute paths are taken as given): every quotation in the brief against its source, by exact substring.

Reads the brief (path given as argv[1]), takes every block of the form
    > <text>
    > — source: <path> [§ ...]
and checks that <text>, with the leading '> ' of an inner quotation removed and whitespace runs
collapsed, is a substring of the source file with whitespace runs collapsed.

Exit 0 iff every quotation is found.  `--control` plants a fault (one character of each quotation
changed) and exits 0 iff every planted quotation is NOT found (the check can fail).
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[3]
MAIN = pathlib.Path("/home/kooshi/source/lean-dir")

def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()

def blocks(brief: str):
    lines = brief.splitlines()
    out, cur = [], []
    for ln in lines:
        if ln.startswith("> — source:"):
            src = ln[len("> — source:"):].strip()
            out.append(("\n".join(cur), src))
            cur = []
        elif ln.startswith(">"):
            cur.append(ln[1:].lstrip())
        else:
            cur = []
    return out

def main():
    control = "--control" in sys.argv
    brief_path = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    brief = pathlib.Path(brief_path).read_text()
    bl = blocks(brief)
    if not bl:
        print("NO QUOTATIONS FOUND: the reader is broken"); sys.exit(2)
    bad = 0
    for text, src in bl:
        path = re.sub(r"(\.(md|lean|py|txt))\s+Stage.*$", r"\1", src.split(" § ")[0].split(" (")[0].strip())
        f = pathlib.Path(path) if path.startswith("/") else ROOT / path
        if not f.exists() and not path.startswith("/"):
            f = MAIN / path
        if not f.exists():
            print(f"MISSING SOURCE  {path}"); bad += 1; continue
        hay = norm(f.read_text())
        # a relative source that this branch holds in an older copy is also read on the main working tree
        if not path.startswith("/") and (MAIN / path).exists() and (MAIN / path) != f:
            hay = hay + " \u241e " + norm((MAIN / path).read_text())
        t = norm(text)
        if t.startswith("> "):            # a quotation of a quotation
            t = t[2:]
        if control:
            # plant: swap the case of the first letter found at or after position 10
            i = next(j for j in range(min(10, len(t) - 1), len(t)) if t[j].isalpha())
            t = t[:i] + t[i].swapcase() + t[i + 1:]
        found = t in hay
        ok = (not found) if control else found
        tag = "ok  " if ok else "FAIL"
        print(f"{tag} {'(control: planted, must be absent) ' if control else ''}{path}: {t[:70]!r}…")
        bad += (not ok)
    print(f"{len(bl)} quotations, {bad} failing{' (control run)' if control else ''}")
    sys.exit(1 if bad else 0)

if __name__ == "__main__":
    main()
