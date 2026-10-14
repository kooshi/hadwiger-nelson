#!/usr/bin/env python3
"""FS131-LDB1 stage 1: the readback of the brief's quotations.
(FS133-LD1's reader, tools/fs133_ld1_readback.py, with this job's brief and the inline quotation W6 added.)

Every quotation in the brief (a run of '> ' lines closed by '> — source: <path>[ § section]') must occur verbatim,
as a substring, in its source file.  The brief and its sources are read from the coordinator's tree (the brief is
committed there, not on this job's branch), at the paths given.

Usage: fs131_ldb1_readback.py [--fault]
--fault changes the last character of every quoted line; every item must then mismatch (exit 1).
Exit 0 iff at least one quotation was found and none mismatched.
"""
import os
import sys

MAIN = "/home/kooshi/source/lean-dir"
BRIEF = "data/fs131/briefs/FS131-LDB1-landing.md"
fault = "--fault" in sys.argv


def rd(p):
    return open(os.path.join(MAIN, p), encoding="utf-8").read()


def spoil(s):
    return s[:-1] + ("#" if s[-1] != "#" else "@") if fault else s


ok = bad = 0
cur = []
for ln in rd(BRIEF).split("\n"):
    if ln.startswith("> — source: "):
        src = ln[len("> — source: "):].split(" § ")[0].strip()
        text = rd(src)
        for ql in cur:
            if spoil(ql) in text:
                ok += 1
                print("match   ", src, "|", ql[:70])
            else:
                bad += 1
                print("MISMATCH", src, "|", ql[:70])
        cur = []
    elif ln.startswith("> "):
        cur.append(ln[2:])
    else:
        cur = []
# The brief's one inline quotation: W6, "Yes, prove the density bound.", from data/fs131/REQUEST-2026-10-13.md.
INLINE = [("data/fs131/REQUEST-2026-10-13.md", "Yes, prove the density bound.")]
for src, ql in INLINE:
    assert ql in rd(BRIEF), "the inline quotation is not in the brief as given here"
    if spoil(ql) in rd(src):
        ok += 1
        print("match   ", src, "|", ql[:70], "(inline)")
    else:
        bad += 1
        print("MISMATCH", src, "|", ql[:70], "(inline)")
print(f"matched: {ok}  mismatched: {bad}")
if ok + bad == 0:
    print("FAIL: no quotation found in the brief — the check read nothing")
    sys.exit(2)
sys.exit(1 if bad else 0)
