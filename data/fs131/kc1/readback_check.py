#!/usr/bin/env python3
"""FS131-KC1 stage 1: check every quotation of the brief against its source.

Each blockquote of the brief ("> text" then "> — source: path ...") must occur,
character for character (the leading "> " aside), in the file its source line
names.  Prints one line per quotation and the count of mismatches; exits 1 on any.
With --fault, one character of each quotation is altered first: every line must
then read MISMATCH (the planted fault), and the script exits 0 only if all do.
"""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs131/briefs/FS131-KC1-measurable-number-plan.md").read_text()
fault = "--fault" in sys.argv
blocks, cur = [], []
for line in brief.splitlines():
    if line.startswith("> "):
        cur.append(line[2:])
    else:
        if cur:
            blocks.append(cur); cur = []
if cur:
    blocks.append(cur)
bad = 0
for b in blocks:
    src = [l for l in b if l.startswith("— source:")]
    body = "\n".join(l for l in b if not l.startswith("— source:")).strip()
    if not src:
        print("NO SOURCE LINE:", body[:60]); bad += 1; continue
    m = re.match(r"— source: (\S+)", src[0])
    text = (root / m.group(1)).read_text()
    q = body
    if fault:
        i = len(q) // 2
        q = q[:i] + ("#" if q[i] != "#" else "@") + q[i + 1:]
    ok = q in text
    print(("MATCH   " if ok else "MISMATCH"), m.group(1), "|", len(body), "chars |", body[:70].replace("\n", " "))
    bad += (not ok)
print("quotations:", len(blocks), "mismatches:", bad)
if fault:
    sys.exit(0 if bad == len(blocks) and blocks else 1)
sys.exit(1 if bad or not blocks else 0)
