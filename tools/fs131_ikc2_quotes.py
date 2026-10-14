#!/usr/bin/env python3
"""FS131-IKC2: check each quotation block of a brief against the file its `source:` line names.

Usage: fs131_ikc2_quotes.py BRIEF ROOT [--plant]
Each block is a run of lines starting with '> ' followed by '> — source: <path>[ § ...]'.
The block's text (the '> ' stripped, the source line dropped) is whitespace-normalised and searched for in the
whitespace-normalised source file under ROOT. Exit 1 if any block is not found. --plant changes one character of
the first block before searching (a control: it must report NOT FOUND and exit 1).
"""
import re, sys, pathlib

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

def blocks(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith(">"):
            body = line[1:].lstrip(" ")
            m = re.match(r"— source: (\S+)", body)
            if m:
                out.append(("\n".join(cur), m.group(1)))
                cur = []
            else:
                cur.append(body)
        else:
            cur = []
    return out

def main():
    brief, root = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
    plant = "--plant" in sys.argv
    bs = blocks(brief.read_text())
    if not bs:
        print("NO BLOCKS FOUND"); sys.exit(1)
    bad = 0
    for k, (q, src) in enumerate(bs):
        if plant and k == 0:
            q = q.replace("formalized", "formalised", 1)
        # an inventory item quoted as '> 848. ...' : a leading bullet '- ' in the source is allowed
        t = norm((root / src).read_text())
        nq = norm(q)
        nq_core = re.sub(r"^- ", "", nq)
        ok = nq_core in t
        print(f"block {k+1}: {src}: {'FOUND' if ok else 'NOT FOUND'} ({len(nq)} chars)")
        bad += not ok
    print(f"{len(bs)} blocks, {bad} not found")
    sys.exit(1 if bad else 0)

main()
