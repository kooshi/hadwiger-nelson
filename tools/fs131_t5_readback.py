#!/usr/bin/env python3
"""FS131-T5 stage 1: check every quotation of a brief against its source.

A brief quotes a statement as two lines:

    > <the quoted line, verbatim>
    > — source: <path>[ § <section>]

This reads every such pair and reports, per quotation, whether the quoted line occurs in the source file as a
whole line (leading and trailing whitespace of the file's line ignored only where the brief's own line has
none to compare: the brief's line is compared verbatim after its `> ` prefix, and also with outer whitespace
stripped on both sides, and the report says which matched). A quotation whose source does not exist, or whose
line is absent, is a MISMATCH and the exit status is 1.

    tools/fs131_t5_readback.py <brief.md> <repo root>
    tools/fs131_t5_readback.py --self-test <repo root>

`--self-test` plants one quotation that is in its source and one that differs from it by one character, and
requires the first to read MATCH and the second MISMATCH.
"""
from __future__ import annotations

import sys
import tempfile
from pathlib import Path


def quotations(text: str) -> list[tuple[str, str]]:
    lines = text.splitlines()
    out = []
    for i, line in enumerate(lines[:-1]):
        nxt = lines[i + 1]
        if line.startswith("> ") and nxt.startswith("> — source: "):
            out.append((line[2:], nxt[len("> — source: "):].strip()))
    return out


def check(brief: Path, root: Path) -> tuple[int, int]:
    quotes = quotations(brief.read_text(encoding="utf-8"))
    bad = 0
    for quoted, source in quotes:
        path = source.split(" § ")[0].strip()
        f = root / path
        if not f.is_file():
            print(f"MISMATCH  {path}: no such file  ::  {quoted[:90]}")
            bad += 1
            continue
        src = f.read_text(encoding="utf-8", errors="replace").splitlines()
        exact = [n + 1 for n, s in enumerate(src) if s == quoted]
        loose = [n + 1 for n, s in enumerate(src) if s.strip() == quoted.strip()]
        if exact:
            print(f"MATCH     {path}:{exact[0]} (verbatim{', ' + str(len(exact)) + ' lines' if len(exact) > 1 else ''})  ::  {quoted[:90]}")
        elif loose:
            print(f"MATCH     {path}:{loose[0]} (outer whitespace differs)  ::  {quoted[:90]}")
        else:
            print(f"MISMATCH  {path}: the quoted line is not a line of the file  ::  {quoted[:90]}")
            bad += 1
    print(f"quotations={len(quotes)} mismatched={bad}")
    return len(quotes), bad


def self_test(root: Path) -> int:
    probe = root / "LEAN.md"
    line = next(s for s in probe.read_text(encoding="utf-8").splitlines() if s.startswith("- **Our own hand results**"))
    with tempfile.TemporaryDirectory() as d:
        good = Path(d) / "good.md"
        good.write_text(f"> {line}\n> — source: LEAN.md § Assumptions\n", encoding="utf-8")
        bad = Path(d) / "bad.md"
        bad.write_text(f"> {line.replace('hand', 'band', 1)}\n> — source: LEAN.md § Assumptions\n", encoding="utf-8")
        n1, b1 = check(good, root)
        n2, b2 = check(bad, root)
    ok = (n1, b1, n2, b2) == (1, 0, 1, 1)
    print("self-test: " + ("OK — the faithful quotation matched and the one-character plant did not" if ok
                           else f"FAIL — got {(n1, b1, n2, b2)}, wanted (1, 0, 1, 1)"))
    return 0 if ok else 1


def main(argv: list[str]) -> int:
    if len(argv) == 3 and argv[1] == "--self-test":
        return self_test(Path(argv[2]))
    if len(argv) != 3:
        print(__doc__)
        return 2
    n, bad = check(Path(argv[1]), Path(argv[2]))
    if n == 0:
        print("no quotation read: the brief has none in the two-line form, or the form changed")
        return 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
