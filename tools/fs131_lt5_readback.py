#!/usr/bin/env python3
"""FS131-LT5 stage 1: check every quotation of the brief against its source.

A brief quotes a statement as two lines:

    > <the quoted line, verbatim>
    > — source: <path>[ § <section>]

Each quoted line must be a whole line of its source (the path is relative to the repository root, or
absolute). Where the source names a section (`§ <heading words>`), the line must also lie under a heading
that contains those words — a quotation found in the file but under another heading is a MISMATCH, because a
count quoted from the wrong section is a different count. A source that does not exist, or a line that is
absent, is a MISMATCH; the exit status is 1 on any, and on a brief with no quotation in the two-line form.

    tools/fs131_lt5_readback.py <brief.md> <repo root>
    tools/fs131_lt5_readback.py --self-test <repo root>

`--self-test` plants four quotations and requires: a faithful one MATCH; the same line with one character
changed MISMATCH; a faithful line cited under a section it is not in MISMATCH; a faithful line whose source
file does not exist MISMATCH.
"""
from __future__ import annotations

import re
import sys
import tempfile
from pathlib import Path

HEADING = re.compile(r"^(#{1,6})\s+(.*\S)\s*$")


def quotations(text: str) -> list[tuple[str, str]]:
    lines = text.splitlines()
    out = []
    for i, line in enumerate(lines[:-1]):
        nxt = lines[i + 1]
        if line.startswith("> ") and nxt.startswith("> — source: "):
            out.append((line[2:], nxt[len("> — source: "):].strip()))
    return out


def headings_above(src: list[str], n: int) -> list[str]:
    """The headings in force at line index n: the nearest heading of each level above it, outermost first,
    each cut off by a later heading of the same or a higher level."""
    stack: list[tuple[int, str]] = []
    for s in src[:n]:
        m = HEADING.match(s)
        if m:
            level = len(m.group(1))
            while stack and stack[-1][0] >= level:
                stack.pop()
            stack.append((level, m.group(2)))
    return [h for _, h in stack]


def check(brief: Path, root: Path) -> tuple[int, int]:
    quotes = quotations(brief.read_text(encoding="utf-8"))
    bad = 0
    for quoted, source in quotes:
        parts = source.split(" § ", 1)
        path = parts[0].strip()
        section = parts[1].strip() if len(parts) == 2 else None
        f = Path(path) if path.startswith("/") else root / path
        if not f.is_file():
            print(f"MISMATCH  {path}: no such file  ::  {quoted[:90]}")
            bad += 1
            continue
        src = f.read_text(encoding="utf-8", errors="replace").splitlines()
        hits = [n for n, s in enumerate(src) if s == quoted]
        how = "verbatim"
        if not hits:
            hits = [n for n, s in enumerate(src) if s.strip() == quoted.strip()]
            how = "outer whitespace differs"
        if not hits:
            print(f"MISMATCH  {path}: the quoted line is not a line of the file  ::  {quoted[:90]}")
            bad += 1
            continue
        if section is not None:
            want = section.lower()
            under = [n for n in hits if any(want in h.lower() for h in headings_above(src, n))]
            if not under:
                found = headings_above(src, hits[0])
                print(f"MISMATCH  {path}:{hits[0] + 1}: the line is in the file but under {found}, not under § {section}  ::  {quoted[:90]}")
                bad += 1
                continue
            hits = under
            how += f", under § {section}"
        more = f", {len(hits)} lines" if len(hits) > 1 else ""
        print(f"MATCH     {path}:{hits[0] + 1} ({how}{more})  ::  {quoted[:90]}")
    print(f"quotations={len(quotes)} mismatched={bad}")
    return len(quotes), bad


def self_test(root: Path) -> int:
    probe = root / "LEAN.md"
    line = next(s for s in probe.read_text(encoding="utf-8").splitlines() if s.startswith("- **Our own hand results**"))
    cases = {
        "faithful": (f"> {line}\n> — source: LEAN.md § Assumptions\n", (1, 0)),
        "one character changed": (f"> {line.replace('hand', 'band', 1)}\n> — source: LEAN.md § Assumptions\n", (1, 1)),
        "wrong section": (f"> {line}\n> — source: LEAN.md § Toolchain\n", (1, 1)),
        "no such file": (f"> {line}\n> — source: LEAN-absent.md § Assumptions\n", (1, 1)),
    }
    ok = True
    with tempfile.TemporaryDirectory() as d:
        for name, (text, want) in cases.items():
            p = Path(d) / "case.md"
            p.write_text(text, encoding="utf-8")
            got = check(p, root)
            verdict = "as expected" if got == want else f"WRONG: got {got}, wanted {want}"
            print(f"  control [{name}]: {verdict}")
            ok = ok and got == want
    print("self-test: " + ("OK — all four controls behaved" if ok else "FAIL"))
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
