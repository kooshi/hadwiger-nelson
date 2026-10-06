#!/usr/bin/env python3
"""FS131-MA1: check every quotation of the brief against its source (standing rule 3).

A quotation is one or more `> text` lines followed by a `> — source: <path> <section…>` line. The text must occur in
the file the source line names. The brief lives on `main`'s checkout, and so do the inventory items it quotes that were
filed after this branch was cut; a relative source path is therefore looked up in the worktree first and in the main
checkout second, and the row says which copy held the text.

Exit 0 iff every quotation occurs at least once in a copy of its source. `--self-test` plants a fault (the last
character of each quotation changed) and requires every planted quotation to be reported missing.
"""
import os, re, sys

WT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAIN = "/home/kooshi/source/lean-dir"
BRIEF = os.path.join(MAIN, "data/fs131/briefs/FS131-MA1-models-moves.md")


def quotations(text):
    lines = text.split("\n")
    out = []
    for i, line in enumerate(lines):
        m = re.match(r"^> — source: (\S+)(.*)$", line)
        if not m:
            continue
        j = i - 1
        body = []
        while j >= 0 and lines[j].startswith(">") and not lines[j].startswith("> — source:"):
            body.append(lines[j][2:] if lines[j].startswith("> ") else lines[j][1:])
            j -= 1
        out.append(("\n".join(reversed(body)), m.group(1), m.group(2).strip(), i + 1))
    return out


def copies(path):
    if os.path.isabs(path):
        return [("as given", path)]
    return [("worktree", os.path.join(WT, path)), ("main", os.path.join(MAIN, path))]


def check(plant=False):
    with open(BRIEF) as f:
        qs = quotations(f.read())
    bad = 0
    rows = []
    for body, path, section, lineno in qs:
        needle = body
        if plant:
            needle = body[:-1] + ("#" if body[-1] != "#" else "@")
        found = []
        existing = 0
        for label, src in copies(path):
            if not os.path.exists(src):
                continue
            existing += 1
            with open(src) as f:
                n = f.read().count(needle)
            found.append(f"{label}={n}")
        total = sum(int(x.split("=")[1]) for x in found)
        if existing == 0:
            rows.append((lineno, path, "SOURCE MISSING", body[:70]))
            bad += 1
            continue
        rows.append((lineno, path, " ".join(found), body[:70].replace("\n", " ")))
        if total == 0:
            bad += 1
    return qs, rows, bad


def main():
    if "--self-test" in sys.argv:
        qs, rows, bad = check(plant=True)
        ok = bad == len(qs) and len(qs) > 0
        print(f"self-test: {bad} of {len(qs)} planted quotations reported missing -> {'OK' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    qs, rows, bad = check()
    for lineno, path, n, head in rows:
        print(f"brief l.{lineno}\t{path}\tcount: {n}\t{head}")
    print(f"{len(qs)} quotations, {bad} missing")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
