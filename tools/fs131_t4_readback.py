#!/usr/bin/env python3
"""FS131-T4 readback (standing rule 3): every quotation in the brief against its source.

The brief quotes in the form

    > <one line of the source>
    > — source: <path, relative to the repository or absolute>[ § <section>]

A quotation passes when its text is, whitespace runs collapsed, the START of some line of the source (the brief quotes a line, or the
first line of a paragraph it then names). A source path under another worktree is read where it stands.

Usage: python3 tools/fs131_t4_readback.py [--plant]
  --plant   the control: one character of each quotation is changed in memory, and every one must then MISMATCH; and a faithful
            copy (the unchanged quotations) must pass in the same run. Exit 0 iff both halves behave.
Exit 0 iff every quotation is found; prints one line per quotation, and the count read (zero quotations read is a failure).
"""
import pathlib
import re
import subprocess
import sys

REPO = pathlib.Path(__file__).resolve().parent.parent
REL = "data/fs131/briefs/FS131-T4-dupnames.md"


def brief_path():
    """The brief on this branch if it is here; else the main checkout's copy (the brief was committed to `main` after this branch
    was cut, so the worktree does not hold it). The path used is printed."""
    here = REPO / REL
    if here.is_file():
        return here
    common = subprocess.run(["git", "-C", str(REPO), "rev-parse", "--path-format=absolute", "--git-common-dir"],
                            capture_output=True, text=True, check=True).stdout.strip()
    return pathlib.Path(common).parent / REL


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def pairs(text):
    out, lines = [], text.split("\n")
    for i, ln in enumerate(lines):
        m = re.match(r"^> — source: (\S+)", ln)
        if m and i > 0 and lines[i - 1].startswith("> "):
            out.append((i, lines[i - 1][2:], m.group(1)))
    return out


def found(quote, path):
    p = pathlib.Path(path)
    p = p if p.is_absolute() else REPO / p
    if not p.is_file():
        return None
    q = norm(quote)
    return any(norm(ln).startswith(q) for ln in p.read_text().split("\n"))


def corrupt(q):
    k = len(q) // 2
    return q[:k] + ("X" if q[k] != "X" else "Y") + q[k + 1:]


def run(mutate):
    ps = pairs(brief_path().read_text())
    bad = 0
    for line, quote, src in ps:
        r = found(mutate(quote), src)
        verdict = "SOURCE MISSING" if r is None else ("ok" if r else "MISMATCH")
        bad += verdict != "ok"
        print(f"  {verdict:14s} brief l.{line}  {src}  | {norm(quote)[:90]}")
    return len(ps), bad


if __name__ == "__main__":
    print(f"brief: {brief_path()}")
    n, bad = run(lambda q: q)
    print(f"quotations read: {n}; not found: {bad}")
    if "--plant" in sys.argv:
        print("--- planted: one character of each quotation changed")
        n2, bad2 = run(corrupt)
        ok = n > 0 and bad == 0 and n2 == n and bad2 == n
        print("PLANT:", "FIRED (every corrupted quotation MISMATCH; the faithful run found every one)" if ok else "DID NOT BEHAVE")
        sys.exit(0 if ok else 1)
    sys.exit(0 if n > 0 and bad == 0 else 1)
