#!/usr/bin/env python3
"""FS131-KRU1 stage 1: check every block quotation of the brief against its source.

Each quotation is a run of '> ' lines ending in '> — source: <path>[ § ...]'.
The quoted text (prefix stripped, whitespace collapsed) must occur verbatim in the
source file (whitespace collapsed). A planted fault (--plant) alters one character
of the first quotation and must make the check fail.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[3]
# the brief was committed on main after this branch was cut (1fccf2874)
BRIEF = pathlib.Path("/home/kooshi/source/lean-dir/data/fs131/briefs/FS131-KRU1-ring.md")

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

def blocks(text):
    cur = []
    for line in text.splitlines():
        if line.startswith(">"):
            body = line[1:].lstrip(" ") if line.startswith("> ") or line == ">" else line[1:]
            m = re.match(r"— source: (\S+)", body)
            if m:
                yield m.group(1), "\n".join(cur)
                cur = []
            else:
                cur.append(line[2:] if line.startswith("> ") else line[1:])
        else:
            cur = []

def main():
    plant = "--plant" in sys.argv
    ok = True
    for i, (src, q) in enumerate(blocks(BRIEF.read_text())):
        if plant and i == 0:
            q = q.replace("formalized", "formalised", 1)
        p = ROOT / src
        if not p.exists():
            # brief sources may be on main only
            p = pathlib.Path("/home/kooshi/source/lean-dir") / src
        s = p.read_text()
        # sources may be block-quoted or table rows; strip leading '> ' in source too
        s2 = "\n".join(l[2:] if l.startswith("> ") else l for l in s.splitlines())
        nq = norm(q)
        hit = nq in norm(s) or nq in norm(s2)
        if not hit:
            # find the longest prefix that matches, to locate the divergence
            lo, hi = 0, len(nq)
            ns = norm(s2)
            while lo < hi:
                mid = (lo + hi + 1) // 2
                if nq[:mid] in ns: lo = mid
                else: hi = mid - 1
            print(f"MISMATCH quote {i} ({src}): matches for {lo} of {len(nq)} chars; diverges at: {nq[max(0,lo-60):lo+60]!r}")
            ok = False
        else:
            print(f"OK quote {i} ({src}): {len(nq)} chars verbatim")
    print("ALL VERBATIM" if ok else "FAIL")
    return 0 if ok else 1

if __name__ == "__main__":
    sys.exit(main())
