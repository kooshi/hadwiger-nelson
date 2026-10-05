#!/usr/bin/env python3
"""FS131-WL1: a criss-cross merge's theorem statements, three-way, against its VIRTUAL merge base.

`tools/fs131_i4_mergestmts.py` (FS131-I4n, read-only here) takes `git merge-base ours theirs`, which names ONE base. When the merge has
two (a criss-cross: `fs131-ww` carries the wave-4 skeleton `f620977c`, which `main` also carries, beside the older `f01c964d`), the
single base reports every statement the skeleton changed and `main` changed again as a CONFLICT, and every skeleton declaration `main`
later deleted as a MISMATCH. Git's own merge uses a virtual base, the merge of the bases; this tool does the same at the level of
statements: base[n] = merge3(b0[n], b1[n], b2[n]) with b0 the bases' own merge base (a both-changed name there is reported), then
the check of FS131-I4n (imported, never copied) against that base. `--rename old=new` applies a rename to `ours`' statement texts (whole
identifiers) and names (any occurrence) before the check (the rename this merge was asked to make), so what remains is what the merge changed beyond it.

Usage: fs131_wl_mergestmts.py <ours> <theirs> [--rename old=new ...] [--rev <merged rev>]   (working tree when --rev is absent)
       fs131_wl_mergestmts.py --plant <ours> <theirs> [...]   alter one merged statement theirs changed; must exit 1 and name it
Exit 1 on any mismatch or conflict.
"""
import collections
import pathlib
import re
import subprocess
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_i4_mergestmts import check, stmts, texts  # noqa: E402


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True, check=True).stdout


def merge3(b, o, t):
    """One name's statement multisets: (result, conflict?)."""
    if o == t:
        return o, False
    if o == b:
        return t, False
    if t == b:
        return o, False
    return o, True


def virtual_base(ours, theirs):
    bases = git("merge-base", "--all", ours, theirs).split()
    if len(bases) == 1:
        return stmts(texts(bases[0])), bases, []
    if len(bases) != 2:
        raise SystemExit(f"{len(bases)} merge bases; this tool handles one or two")
    b0 = git("merge-base", bases[0], bases[1]).strip()
    s0, s1, s2 = stmts(texts(b0)), stmts(texts(bases[0])), stmts(texts(bases[1]))
    out, conflicts = collections.defaultdict(collections.Counter), []
    for n in set(s0) | set(s1) | set(s2):
        e = collections.Counter()
        r, c = merge3(s0.get(n, e), s1.get(n, e), s2.get(n, e))
        if c:
            conflicts.append(n)
        if r:
            out[n] = r
    return out, bases + [b0], conflicts


def renamed(s, pairs):
    out = collections.defaultdict(collections.Counter)
    for n, cnt in s.items():
        n2 = n
        for a, b in pairs:
            n2 = n2.replace(a, b)  # inside a name too: `norm_sq_framePt_sub`
        for txt, k in cnt.items():
            for a, b in pairs:
                txt = re.sub(rf"(?<![A-Za-z0-9_']){re.escape(a)}(?![A-Za-z0-9'])", b, txt)
            out[n2][txt] += k
    return out


def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    if plant:
        args.remove("--plant")
    pairs, rev = [], None
    while "--rename" in args:
        i = args.index("--rename")
        a, b = args[i + 1].split("=")
        pairs.append((a, b))
        del args[i:i + 2]
    if "--rev" in args:
        i = args.index("--rev")
        rev = args[i + 1]
        del args[i:i + 2]
    if len(args) != 2:
        print(__doc__)
        return 2
    ours, theirs = args
    base, used, bconf = virtual_base(ours, theirs)
    for n in sorted(bconf):
        print(f"BASE-CONFLICT {n}: the two merge bases changed its statements differently")
    o, t = stmts(texts(ours)), stmts(texts(theirs))
    if pairs:
        base, o = renamed(base, pairs), renamed(o, pairs)
    merged = stmts(texts(rev))
    if plant:
        victim = next(n for n in sorted(t) if t[n] != base.get(n) and t[n] == merged.get(n))
        s = next(iter(merged[victim]))
        merged[victim] = collections.Counter({s + " PLANTED": 1})
        print(f"planted: {victim}")
    bad, total = check(base, o, t, merged)
    print(f"{total} names; bases {' '.join(b[:8] for b in used)}; renames {pairs}; {bad} mismatches/conflicts, "
          f"{len(bconf)} base conflicts")
    print("FAIL" if bad or bconf else "PASS")
    return 1 if bad or bconf else 0


if __name__ == "__main__":
    sys.exit(main())
