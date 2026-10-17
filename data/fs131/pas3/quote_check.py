"""FS131-PAS3 stage 1: check the brief's block quotations against their source, verbatim.

Usage: python3 -I quote_check.py <brief> <source> [--plant]
Each run of '> ' lines in the brief (ending before a '> — source:' line) is one quotation; it passes when its text,
joined with single spaces, is a substring of the source with its whitespace collapsed the same way.
--plant changes one character in each quotation first: every quotation must then FAIL (the control fires).
"""
import re, sys

def collapse(s):
    return re.sub(r"\s+", " ", s).strip()

def quotations(brief_text):
    blocks, cur = [], []
    for line in brief_text.splitlines():
        if line.startswith(">"):
            body = line[1:].lstrip()
            if body.startswith("— source:"):
                if cur:
                    blocks.append(" ".join(cur)); cur = []
                continue
            cur.append(body)
        elif cur:
            blocks.append(" ".join(cur)); cur = []
    if cur:
        blocks.append(" ".join(cur))
    return blocks

def main():
    brief, source = sys.argv[1], sys.argv[2]
    plant = "--plant" in sys.argv
    src = collapse(open(source, encoding="utf-8").read())
    blocks = quotations(open(brief, encoding="utf-8").read())
    bad = 0
    for b in blocks:
        q = collapse(b)
        if plant:
            i = len(q) // 2
            q = q[:i] + ("X" if q[i] != "X" else "Y") + q[i + 1:]
        ok = q in src
        bad += not ok
        print(("ok    " if ok else "MISS  ") + q[:90])
    print(f"quotations: {len(blocks)}  verbatim: {len(blocks) - bad}")
    sys.exit(1 if bad else 0)

main()
