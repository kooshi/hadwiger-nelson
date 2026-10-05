#!/usr/bin/env python3
"""FS131-I4n: a merge's theorem statements against both parents, over the whole `Proofs/` tree.

For each theorem name, the multiset of its statements (text from `theorem <name>` to the first `:=`, whitespace-normalized)
is read at the merge base, at each parent and in the working tree (or at `--rev`). A statement is checked three-way: the
merged result must equal what a clean three-way merge of statements gives — a side that changed a name's statements from the
base wins; if both changed it differently, that is a CONFLICT; and the merged tree must hold exactly that. Files may move
(statements are keyed by name, not path). Exit 1 on any mismatch or conflict.

Usage: fs131_i4_mergestmts.py <ours> <theirs> [--rev <merged rev>]   (working tree when --rev is absent)
       fs131_i4_mergestmts.py --plant <ours> <theirs>                  change one statement of `theirs` in a copy; must exit 1
"""
import collections
import pathlib
import re
import subprocess
import sys

PAT = re.compile(r"^(?:private |protected )*theorem (\S+)(.*?):=", re.S | re.M)


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True, check=True).stdout


def texts(rev):
    if rev is None:
        return [p.read_text() for p in sorted(pathlib.Path("Proofs").rglob("*.lean"))]
    names = git("ls-tree", "-r", "--name-only", rev, "Proofs").split()
    return [git("show", f"{rev}:{p}") for p in names if p.endswith(".lean")]


def stmts(ts):
    out = collections.defaultdict(collections.Counter)
    for t in ts:
        for m in PAT.finditer(t):
            out[m.group(1)][" ".join(m.group(2).split())] += 1
    return out


def check(base, ours, theirs, merged):
    bad = 0
    names = set(base) | set(ours) | set(theirs) | set(merged)
    for n in sorted(names):
        b, o, t, m = base.get(n, collections.Counter()), ours.get(n, collections.Counter()), \
            theirs.get(n, collections.Counter()), merged.get(n, collections.Counter())
        if o == t:
            want = o
        elif o == b:
            want = t
        elif t == b:
            want = o
        else:
            print(f"CONFLICT {n}: both sides changed its statements")
            bad += 1
            continue
        if m != want:
            print(f"MISMATCH {n}: merged {dict(m)} expected {dict(want)}")
            bad += 1
    return bad, len(names)


def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    if plant:
        args.remove("--plant")
    rev = None
    if "--rev" in args:
        i = args.index("--rev")
        rev = args[i + 1]
        del args[i:i + 2]
    if len(args) != 2:
        print(__doc__)
        return 2
    ours, theirs = args
    mb = git("merge-base", ours, theirs).strip()
    base, o, t = stmts(texts(mb)), stmts(texts(ours)), stmts(texts(theirs))
    merged = stmts(texts(rev))
    if plant:
        # plant: alter one statement that theirs changed or added, in the merged view only
        victim = next(n for n in sorted(t) if t[n] != base.get(n))
        s = next(iter(merged[victim]))
        merged[victim] = collections.Counter({s + " PLANTED": 1})
        print(f"planted: {victim}")
    bad, total = check(base, o, t, merged)
    print(f"{total} names; base {mb[:8]}; {bad} mismatches/conflicts")
    print("FAIL" if bad else "PASS")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
