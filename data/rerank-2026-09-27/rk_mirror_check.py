#!/usr/bin/env python3
"""Check that CLAUDE.md § Paths forward mirrors plans/FRONTIER-STUBS.md's ranked table: the same stub at every rank 1-29, in order, one row per
rank, and a group row labelled 30-N listing ranks 30..N in rank order. Exit 0 on PASS, 1 on FAIL (each culprit named).

    python3 data/rerank-2026-09-27/rk_mirror_check.py                     # the working tree
    python3 data/rerank-2026-09-27/rk_mirror_check.py --rev <git rev>     # both files at a revision
    python3 data/rerank-2026-09-27/rk_mirror_check.py --self-test         # plant faults, watch each fire; a faithful copy must pass
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SINGLE = 29  # CLAUDE.md shows ranks 1-29 as rows (E1's design); the rest are one group row


def stubs_table(text):
    """[(rank, FS id)] in file order from plans/FRONTIER-STUBS.md's ranked table."""
    lines = text.split("\n")
    a = lines.index("## Ranked stubs")
    b = next(i for i, l in enumerate(lines) if l.startswith("## Closed, absorbed and demoted"))
    out = []
    for l in lines[a:b]:
        m = re.match(r"\| (\d+) \| \*\*(FS-\d+)[ *]", l)
        if m:
            out.append((int(m.group(1)), m.group(2)))
    return out


def mirror_table(text):
    """([(rank label, FS id)] for the single rows, (group label, [FS ids]) or None) from CLAUDE.md § Paths forward."""
    lines = text.split("\n")
    h = lines.index("| rank | stub | the question | bearing on the answer |")
    singles, group = [], None
    for l in lines[h + 2:]:
        if not l.startswith("|"):
            break
        label = l.split("|")[1].strip()
        stub = l.split("|")[2]
        if re.fullmatch(r"\d+", label):
            m = re.search(r"FS-\d+", stub)
            singles.append((label, m.group(0) if m else None))
        else:
            ids = re.findall(r"FS-\d+", stub.split(" — in rank order")[0])
            group = (label, ids)
    return singles, group


def check(stubs_text, claude_text):
    errs = []
    st = stubs_table(stubs_text)
    ranks = [r for r, _ in st]
    if ranks != list(range(1, len(st) + 1)):
        errs.append("FRONTIER-STUBS ranks are not 1..%d in order: %s" % (len(st), ranks))
    ids = [f for _, f in st]
    dup = sorted({f for f in ids if ids.count(f) > 1})
    if dup:
        errs.append("FRONTIER-STUBS lists these stubs more than once: %s" % dup)
    by_rank = dict(st)
    singles, group = mirror_table(claude_text)
    labels = [lab for lab, _ in singles]
    if labels != [str(k) for k in range(1, SINGLE + 1)]:
        errs.append("CLAUDE.md's single-row rank labels are not 1..%d, one each, in order: %s" % (SINGLE, labels))
    for k, (lab, fs) in enumerate(singles, start=1):
        want = by_rank.get(k)
        if fs != want:
            errs.append("CLAUDE.md row %d (labelled %s) shows %s; FRONTIER-STUBS rank %d is %s" % (k, lab, fs, k, want))
    n = len(st)
    if group is None:
        errs.append("CLAUDE.md has no group row")
    else:
        glab, gids = group
        if glab != "30–%d" % n:
            errs.append("CLAUDE.md's group row is labelled %r; FRONTIER-STUBS runs to %d, so it should read '30–%d'" % (glab, n, n))
        want = [by_rank[k] for k in range(SINGLE + 1, n + 1) if k in by_rank]
        if gids != want:
            miss = [f for f in want if f not in gids]
            extra = [f for f in gids if f not in want]
            errs.append("CLAUDE.md's group row differs from FRONTIER-STUBS ranks %d–%d (missing %s, extra %s, order %s)"
                        % (SINGLE + 1, n, miss, extra, "same" if sorted(gids) != sorted(want) else "differs"))
    return errs


def git_show(rev, path):
    return subprocess.run(["git", "show", "%s:%s" % (rev, path)], cwd=ROOT, check=True, capture_output=True, text=True).stdout


def self_test():
    s = (ROOT / "plans/FRONTIER-STUBS.md").read_text()
    c = (ROOT / "CLAUDE.md").read_text()
    ok = True
    base = check(s, c)
    print("control (faithful copies):", "PASS" if not base else "FAIL %s" % base)
    ok &= not base
    singles, group = mirror_table(c)

    def plant(name, s2, c2):
        nonlocal ok
        e = check(s2, c2)
        print("plant %-42s %s" % (name + ":", "fired: " + e[0][:110] if e else "DID NOT FIRE"))
        ok &= bool(e)

    # 1. a duplicate rank label (the defect this check found in the pre-RK mirror: 21, 21 and 25, 25)
    l22 = next(l for l in c.split("\n") if l.startswith("| 22 |"))
    plant("duplicate rank label", s, c.replace(l22, "| 21 |" + l22[len("| 22 |"):], 1))
    # 2. two single rows swapped
    l5 = next(l for l in c.split("\n") if l.startswith("| 5 |"))
    l6 = next(l for l in c.split("\n") if l.startswith("| 6 |"))
    c2 = c.replace(l5, "@@5@@").replace(l6, "| 6 |" + l5[len("| 5 |"):]).replace("@@5@@", "| 5 |" + l6[len("| 6 |"):])
    plant("stubs swapped at ranks 5 and 6", s, c2)
    # 3. the group row's order changed
    glab, gids = group
    a, b = gids[0], gids[1]
    gline = next(l for l in c.split("\n") if l.startswith("| %s |" % glab))
    swapped = gline.replace(a + ",", "@@A@@", 1).replace(b + ",", a + ",", 1).replace("@@A@@", b + ",", 1)
    plant("group row reordered", s, c.replace(gline, swapped))
    # 4. a stub dropped from the group row
    plant("group row missing a stub", s, c.replace(gline, gline.replace(", " + gids[-1] + " —", " —", 1)))
    # 5. a stale group label
    plant("stale group label", s, c.replace(gline, gline.replace("| %s |" % glab, "| 30–63 |", 1)))
    # 6. FRONTIER-STUBS itself: a rank gap
    r7 = next(l for l in s.split("\n") if l.startswith("| 7 | **FS-"))
    plant("FRONTIER-STUBS rank gap", s.replace(r7, "| 70 |" + r7[len("| 7 |"):], 1), c)
    print("SELF-TEST", "PASS" if ok else "FAIL")
    return 0 if ok else 1


def main():
    if "--self-test" in sys.argv:
        return self_test()
    if "--rev" in sys.argv:
        rev = sys.argv[sys.argv.index("--rev") + 1]
        s, c = git_show(rev, "plans/FRONTIER-STUBS.md"), git_show(rev, "CLAUDE.md")
    else:
        s, c = (ROOT / "plans/FRONTIER-STUBS.md").read_text(), (ROOT / "CLAUDE.md").read_text()
    errs = check(s, c)
    for e in errs:
        print("FAIL:", e)
    st = stubs_table(s)
    print("checked %d ranked stubs; CLAUDE.md single rows %d, group row %s" % (len(st), len(mirror_table(c)[0]), (mirror_table(c)[1] or ("none",))[0]))
    print("RESULT:", "PASS" if not errs else "FAIL (%d)" % len(errs))
    return 0 if not errs else 1


if __name__ == "__main__":
    sys.exit(main())
