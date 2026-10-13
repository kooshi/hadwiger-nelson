#!/usr/bin/env python3
"""FS131-IT1 stage 1: the brief's quotations against their sources (pattern: data/fs131/iu1/readback.py on fs131-wnf).

A quotation in the brief is a `> ` line followed by a `> — source: <path> ...` line. Three kinds:
`> W2: text`          -> searched verbatim (whitespace runs collapsed) in the request file;
`> NF4-THEOREM: text` -> the text must occur verbatim in the claim list (its § The theorem);
`> - <date> — text`   -> a dated line: compared character for character with a whole line of the claim list.
The sources are read from the main checkout: the brief and the claim list's dated lines live there (this branch's copy
of the claim list was cut before them).
`--control` plants a one-token change in every quotation and must report DIFFERS for each.
Exit 0 only when every verdict is the expected one and at least one quotation was compared.
"""
import re, sys, pathlib
MAIN = pathlib.Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-IT1-leaves.md"
control = "--control" in sys.argv
brief = BRIEF.read_text()
norm = lambda s: re.sub(r"\s+", " ", s)
n = bad = 0
for m in re.finditer(r"^> (.*)\n> — source: (\S+)", brief, re.M):
    line, src = m.group(1), m.group(2)
    body = (MAIN / src).read_text()
    n += 1
    tag = line[:40]
    if control:
        # the plant goes in the quotation's body, past its label (`W2: `, `NF4-THEOREM: `): a changed label would only
        # change which comparison runs, and the control would fire for the wrong reason
        lab = re.match(r"(W2: |NF4-THEOREM: )?", line).end()
        k = re.search(r"\d", line[lab:])
        i = lab + k.start()
        line = line[:i] + str((int(line[i]) + 1) % 10) + line[i + 1:]
    if line.startswith("W2: "):
        kind, ok = "verbatim, whitespace collapsed", norm(line[4:]) in norm(body)
    elif line.startswith("NF4-THEOREM: "):
        kind, ok = "verbatim substring", line[len("NF4-THEOREM: "):] in body
    else:
        kind, ok = "a whole line, character for character", line in body.splitlines()
    print(f"[{tag}…]: {'IDENTICAL' if ok else 'DIFFERS'} ({len(line)} characters; {kind}; source {src})")
    bad += (not ok)
print(f"compared={n} differing={bad} mode={'control' if control else 'real'}")
sys.exit(0 if (n > 0 and (bad == n if control else bad == 0)) else 1)
