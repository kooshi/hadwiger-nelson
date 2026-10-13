#!/usr/bin/env python3
"""FS131-IQ1 stage 1: the brief's quotations against their sources.

A quotation in the brief is a block of `> …` lines closed by `> — source: <path> [§ …]`. The quoted text (the `> ` prefix
removed) must occur as one whole line of the source file, character for character. Sources are read from the main checkout
(the claim list's dated lines are on `main`, not in this worktree's copy) — the path each was read at is printed.
`--control` changes one word of every quotation and must report DIFFERS for each; exit 0 only on the expected verdicts.
"""
import re, sys, pathlib
MAIN = pathlib.Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-IQ1-leaves.md"
control = "--control" in sys.argv
text = BRIEF.read_text()
blocks = re.findall(r"((?:^> .*\n)+?)^> — source: (\S+)", text, re.M)
n = bad = 0
for body, src in blocks:
    lines = [l[2:] for l in body.splitlines()]
    quote = "\n".join(lines)
    if control:
        quote = quote.replace(" the ", " a ", 1) if " the " in quote else quote + " x"
    srcpath = MAIN / src
    n += 1
    if not srcpath.exists():
        print(f"SOURCE ABSENT: {src}"); bad += 1; continue
    srclines = srcpath.read_text().splitlines()
    ok = quote in srclines
    print(f"{quote[:60]!r}…: {'IDENTICAL' if ok else 'DIFFERS'} ({len(quote)} characters; read at {srcpath})")
    bad += (not ok)
print(f"compared={n} differing={bad} mode={'control' if control else 'real'}")
sys.exit(0 if (n > 0 and (bad == n if control else bad == 0)) else 1)
