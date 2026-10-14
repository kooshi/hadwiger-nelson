#!/usr/bin/env python3
"""FS131-IP23 stage 1: the readback of the brief's quotations (standing rule 3).

Every quotation in the brief (a run of '> ' lines closed by '> — source: <path>[ § section]') must occur verbatim,
as a substring, in its source file.  The brief and its sources are read from the coordinator's tree (the brief is
committed there, not on this job's branch), at the paths given.  A quotation whose source is absent is a mismatch.

Usage: fs131_ip23_readback.py [--fault]
--fault changes the last character of every quoted line; every item must then mismatch (exit 1).
Exit 0 iff at least one quotation was found and none mismatched.
(FS131-IE1's reader, `tools/fs131_ie1_readback.py`, for this job's brief; that one is not edited.)
"""
import os
import sys

MAIN = "/home/kooshi/source/lean-dir"
BRIEF = "data/fs131/briefs/FS131-IP23-ports-p2-p3.md"
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
        try:
            text = rd(src)
        except FileNotFoundError:
            text = None
        for ql in cur:
            if text is not None and spoil(ql) in text:
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
print(f"matched: {ok}  mismatched: {bad}")
if ok + bad == 0:
    print("FAIL: no quotation found in the brief — the check read nothing")
    sys.exit(2)
sys.exit(1 if bad else 0)
