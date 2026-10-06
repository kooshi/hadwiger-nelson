#!/usr/bin/env python3
"""FS131-MB2: check every quotation of the brief against its source (standing rule 3).

A quotation is a run of `> text` lines followed by a `> — source: <path> <section…>` line. The text must occur
in the file the source line names. A source path that is absolute is read as it stands; a relative one is read
from the main checkout (the brief quotes Keryx's files — `CLAUDE.md`, the inventory — which live there), and,
if absent there, from this worktree.

Exit 0 iff every quotation occurs at least once. `--self-test` plants a fault (the last character of each
quotation changed) and requires every planted quotation to be reported missing, beside the faithful run,
which must report none missing: the refusal is then seen to come from the text and not from the scaffolding.
"""
import os, re, sys

WORKTREE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAIN = "/home/kooshi/source/lean-dir"
BRIEF = os.path.join(MAIN, "data/fs131/briefs/FS131-MB2-models-shadow.md")


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


def resolve(path):
    if os.path.isabs(path):
        return path if os.path.exists(path) else None
    for root in (MAIN, WORKTREE):
        p = os.path.join(root, path)
        if os.path.exists(p):
            return p
    return None


def check(plant=False):
    with open(BRIEF) as f:
        qs = quotations(f.read())
    bad = 0
    rows = []
    for body, path, section, lineno in qs:
        src = resolve(path)
        if src is None:
            rows.append((lineno, path, "SOURCE MISSING", body[:60]))
            bad += 1
            continue
        with open(src) as f:
            s = f.read()
        needle = body
        if plant:
            needle = body[:-1] + ("#" if body[-1] != "#" else "@")
        n = s.count(needle)
        rows.append((lineno, src, n, body[:70].replace("\n", " ")))
        if n == 0:
            bad += 1
    return qs, rows, bad


def main():
    if "--self-test" in sys.argv:
        qs, rows, bad = check(plant=True)
        qs0, rows0, bad0 = check(plant=False)
        ok = bad == len(qs) and len(qs) > 0 and bad0 == 0
        print(f"self-test: {bad} of {len(qs)} planted quotations reported missing; "
              f"faithful run {bad0} missing -> {'OK' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    qs, rows, bad = check()
    for lineno, path, n, head in rows:
        print(f"brief l.{lineno}\t{path}\tcount={n}\t{head}")
    print(f"{len(qs)} quotations, {bad} missing")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
