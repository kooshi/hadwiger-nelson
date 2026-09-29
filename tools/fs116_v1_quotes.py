#!/usr/bin/env python3
"""FS116-V1 readback: each statement block the brief quotes (its '> - **NAME** ...' lines up to the '> — source' line)
must appear verbatim, whitespace-normalised, in the frozen claim list. Exit 1 on any mismatch.
Usage: fs116_v1_quotes.py BRIEF CLAIMS   (fault plant: pass --plant to drop one character from each quote first)"""
import re, sys

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    plant = "--plant" in sys.argv
    brief, claims = (open(p, encoding="utf-8").read() for p in args)
    blocks, cur = [], None
    for line in brief.splitlines():
        if line.startswith("> - **"):
            cur = [line[2:]]
        elif cur is not None and line.startswith("> — source"):
            blocks.append(cur); cur = None
        elif cur is not None and line.startswith(">"):
            cur.append(line[1:])
    nc = norm(claims)
    bad = 0
    for b in blocks:
        q = norm(" ".join(b))
        if plant:
            q = q[:40] + q[41:]
        name = re.match(r"- \*\*([^*]+)\*\*", q)
        ok = q in nc
        print(("ok   " if ok else "MISS ") + (name.group(1) if name else q[:30]) + f"  ({len(q)} chars)")
        bad += not ok
    print(f"blocks: {len(blocks)}  mismatches: {bad}")
    sys.exit(1 if bad or not blocks else 0)

main()
