#!/usr/bin/env python3
"""FS131-IRU1 stage 1: check every block quotation of the brief against its source.

Each quotation is a run of '> ' lines ending in '> — source: <path>[ § ...]'. The quoted text (prefix stripped,
whitespace collapsed) must occur verbatim in the source file (whitespace collapsed; a source's own '> ' prefixes
stripped too). A source is read from this worktree first (the skeleton modules live only on this branch), and from
the main tree when the worktree lacks it. The brief is read from the main tree, where it was committed
(`fe00e94d1`) after this branch's last merge. A planted fault (--plant) alters one character of the first and of the
last quotation and must make exactly those two fail.
After FS131-KRU1's `data/fs131/kru1/quote_check.py`.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[3]
MAIN = pathlib.Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-IRU1-ring.md"


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def blocks(text):
    cur = []
    for line in text.splitlines():
        if line.startswith(">"):
            body = line[2:] if line.startswith("> ") else line[1:]
            m = re.match(r"— source: (\S+)", body)
            if m:
                yield m.group(1), "\n".join(cur)
                cur = []
            else:
                cur.append(body)
        else:
            cur = []


def main():
    plant = "--plant" in sys.argv
    qs = list(blocks(BRIEF.read_text()))
    if not qs:
        print("NO QUOTATIONS READ — the reader is broken")
        return 2
    fails = []
    for i, (src, q) in enumerate(qs):
        if plant and i in (0, len(qs) - 1):
            # one character changed: the first letter after the first space
            j = q.index(" ") + 1
            q = q[:j] + ("Z" if q[j] != "Z" else "Y") + q[j + 1:]
        p = ROOT / src
        where = "worktree"
        if not p.exists():
            p, where = MAIN / src, "main"
        s = p.read_text()
        s2 = "\n".join(l[2:] if l.startswith("> ") else l for l in s.splitlines())
        nq = norm(q)
        if nq in norm(s) or nq in norm(s2):
            print(f"OK quote {i} ({src}, {where}): {len(nq)} chars verbatim")
            continue
        ns = norm(s2)
        lo, hi = 0, len(nq)
        while lo < hi:
            mid = (lo + hi + 1) // 2
            if nq[:mid] in ns:
                lo = mid
            else:
                hi = mid - 1
        print(f"MISMATCH quote {i} ({src}, {where}): matches for {lo} of {len(nq)} chars; "
              f"diverges at: {nq[max(0, lo - 60):lo + 60]!r}")
        fails.append(i)
    print(f"quotations read: {len(qs)}")
    if plant:
        want = [0, len(qs) - 1]
        ok = fails == want
        print(f"PLANT {'FIRED' if ok else 'NOT FIRED'}: failures {fails}, expected {want}")
        return 0 if ok else 1
    print("ALL VERBATIM" if not fails else f"FAIL: {fails}")
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main())
