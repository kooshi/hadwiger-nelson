#!/usr/bin/env python3
"""FS131-LJ1 stage 1 (FS131-LU1's data/fs131/lu1/readback_check.py pointed at this brief): every quotation of the brief against its
source.

Each blockquote of the brief ("> text" then "> — source: path ...") must occur, character for character (the leading
"> " aside), in the file its source line names.  Prints one line per quotation and the count of mismatches; exits 1 on
any.  With --ref REF the brief and the sources are read as `git show REF:path` (the claim list's two dated lines are on
`main` and reach this tree with the merge); without it, from the working tree.  With --fault, one character of each
quotation is altered first: every line must then read MISMATCH, and the script exits 0 only if all do.
"""
import pathlib
import re
import subprocess
import sys

root = pathlib.Path(__file__).resolve().parents[3]
args = sys.argv[1:]
ref = args[args.index("--ref") + 1] if "--ref" in args else None
fault = "--fault" in args


def read(path):
    if ref:
        return subprocess.run(["git", "-C", str(root), "show", f"{ref}:{path}"], capture_output=True, text=True,
                              check=True).stdout
    return (root / path).read_text()


brief = read("data/fs131/briefs/FS131-LJ1-landing.md")
blocks, cur = [], []
for line in brief.splitlines():
    if line.startswith("> "):
        cur.append(line[2:])
    else:
        if cur:
            blocks.append(cur)
            cur = []
if cur:
    blocks.append(cur)
print(f"read from: {'git ' + ref + ' = ' + subprocess.run(['git', '-C', str(root), 'rev-parse', ref], capture_output=True, text=True).stdout.strip() if ref else 'the working tree'}")
bad = 0
for b in blocks:
    src = [ln for ln in b if ln.startswith("— source:")]
    body = "\n".join(ln for ln in b if not ln.startswith("— source:")).strip()
    if not src:
        print("NO SOURCE LINE:", body[:60])
        bad += 1
        continue
    m = re.match(r"— source: (\S+)", src[0])
    text = read(m.group(1))
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
