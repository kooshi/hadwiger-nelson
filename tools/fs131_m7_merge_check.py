#!/usr/bin/env python3
"""FS131-M7: a merge into `fs131-w5c` — every file is the side it should be, byte for byte.

A copy of FS131-IA1's `tools/fs131_ia_merge_check.py` (itself FS131-IR1's) under this job's prefix (standing rule 7 bars editing
another job's tool), with three changes: the three refs are REQUIRED arguments (this job checks two merges with different bases, so a
default would be one merge's refs silently used for the other); KEEP_BOTH is this job's (`Proofs.lean`, `ARCHITECTURE.md`,
`scripts/Axioms.lean`, `plans/FS131-I5-implementation.md` — no Lean module); and the self-test's plants choose their targets from
the three trees (a Lean file changed by THEIRS only; one changed by OURS only; an import line of `Proofs.lean` that THEIRS added; the
first `#print axioms` record; a file changed by both outside KEEP_BOTH), each raising if no target exists, so the same self-test
fires on either merge.

For every path in the trees of BASE, OURS, THEIRS (all files, not only `Proofs/`), with the merged side read from the index, which the
working tree must equal (or from `--rev`); blobs are compared by hash, so a symlink is its target path:
  - both sides equal: the merged file is that text;
  - changed by THEIRS only (or added by it): the merged file equals THEIRS';
  - changed by OURS only (or added by it): the merged file equals OURS';
  - changed by both: allowed only for KEEP_BOTH, where the merged file's lines, as a multiset, are OURS' + THEIRS' − BASE's (every
    line either side added is there once per addition, nothing dropped), with one blank line of slack for the joint between two kept
    blocks; and no `import` line, `#print axioms` record or module-table row occurs twice unless a side already had it twice.
Usage: fs131_m7_merge_check.py BASE OURS THEIRS [--rev MERGED] [--self-test]
Exit 0 only on PASS. `--self-test` requires each of five plants to FAIL naming its file, and the unplanted run to PASS.
"""
import collections
import re
import subprocess
import sys

KEEP_BOTH = {"Proofs.lean", "ARCHITECTURE.md", "scripts/Axioms.lean", "plans/FS131-I5-implementation.md"}


def git(*a, text=True):
    return subprocess.run(["git", *a], capture_output=True, text=text, check=True).stdout


def tree(rev):
    out = {}
    for line in git("ls-tree", "-r", rev).splitlines():
        meta, path = line.split("\t", 1)
        out[path] = meta.split()[2]
    return out


def blob(rev, path):
    return git("show", f"{rev}:{path}", text=False)


def keyed_lines(path, text):
    c = collections.Counter()
    for line in text.split("\n"):
        if path == "Proofs.lean" and line.startswith("import "):
            c[line] += 1
        if path == "scripts/Axioms.lean" and line.startswith("#print axioms "):
            c[line] += 1
        if path == "ARCHITECTURE.md":
            mm = re.match(r"\| `([^`]+)` \|", line)
            if mm:
                c[mm.group(1)] += 1
    return c


def check(base, ours, theirs, mtree, mread, extra_both=()):
    """mtree: path -> blob hash of the merged side; mread: path -> its bytes (or None)."""
    tb, to, tt = tree(base), tree(ours), tree(theirs)
    bad = []
    n = 0
    nboth = 0
    for path in sorted(set(tb) | set(to) | set(tt) | set(mtree)):
        b, o, t = tb.get(path), to.get(path), tt.get(path)
        mh = mtree.get(path)
        n += 1
        both = path in extra_both
        if not both and o == t:
            want = o
        elif not both and o == b:
            want = t
        elif not both and t == b:
            want = o
        else:
            nboth += 1
            m = mread(path)
            if path not in KEEP_BOTH:
                bad.append(f"{path}: changed by both sides, not in KEEP_BOTH")
                continue
            if m is None:
                bad.append(f"{path}: missing from the merged tree")
                continue
            lb = collections.Counter(blob(base, path).decode().split("\n")) if b else collections.Counter()
            lo = collections.Counter(blob(ours, path).decode().split("\n"))
            lt = collections.Counter(blob(theirs, path).decode().split("\n"))
            lm = collections.Counter(m.decode().split("\n"))
            want_c = lo + lt
            want_c.subtract(lb)
            diff = {k: lm[k] - want_c[k] for k in set(lm) | set(want_c) if lm[k] != want_c[k]}
            slack = diff.pop("", 0)
            if diff or not (0 <= slack <= 1):
                bad.append(f"{path}: merged lines are not ours + theirs − base: {dict(list(diff.items())[:3])} blank-slack {slack}")
            keyed = keyed_lines(path, m.decode())
            ko = keyed_lines(path, blob(ours, path).decode())
            kt = keyed_lines(path, blob(theirs, path).decode())
            kb = keyed_lines(path, blob(base, path).decode()) if b else collections.Counter()
            # a side may already hold a repeat; only a repeat the merge created fails
            twice = [k for k, c in keyed.items() if c > 1 and c > max(kb[k], ko[k], kt[k])]
            if twice:
                bad.append(f"{path}: twice after the merge: {twice[:3]}")
            continue
        if mh != want:
            bad.append(f"{path}: merged text is not the side it should be")
    return n, nboth, bad


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    rev = None
    if "--rev" in sys.argv:
        rev = sys.argv[sys.argv.index("--rev") + 1]
        args = [a for a in args if a != rev]
    if len(args) != 3:
        print("usage: fs131_m7_merge_check.py BASE OURS THEIRS [--rev MERGED] [--self-test]")
        sys.exit(2)
    base, ours, theirs = args
    if rev:
        mtree = tree(rev)

        def read(path):
            return blob(rev, path) if path in mtree else None
    else:
        # the index: every resolved path of the merge in progress (or of HEAD after it); the working tree must equal it
        if subprocess.run(["git", "diff", "--quiet"]).returncode != 0:
            print("FAIL the working tree differs from the index (unstaged changes): stage or discard them first")
            sys.exit(1)
        mtree = {}
        for line in git("ls-files", "-s").splitlines():
            meta, path = line.split("\t", 1)
            if meta.split()[2] != "0":
                print(f"FAIL unmerged path {path}")
                sys.exit(1)
            mtree[path] = meta.split()[1]

        def read(path):
            return git("show", f":{path}", text=False) if path in mtree else None
    n, nboth, bad = check(base, ours, theirs, mtree, read)
    if "--self-test" not in sys.argv:
        for line in bad:
            print("FAIL", line)
        print(f"{n} files ({nboth} changed by both sides); {len(bad)} failure(s)")
        print("PASS" if not bad else "FAIL")
        sys.exit(1 if bad else 0)
    ok = not bad
    print("unplanted:", "PASS" if ok else f"FAIL {bad[:3]}")
    tb, to, tt = tree(base), tree(ours), tree(theirs)
    lean = [p for p in sorted(set(to) | set(tt)) if p.startswith("Proofs/") and p.endswith(".lean")]
    theirs_only = [p for p in lean if to.get(p) == tb.get(p) and tt.get(p) != tb.get(p) and p in tt]
    ours_only = [p for p in lean if tt.get(p) == tb.get(p) and to.get(p) != tb.get(p) and p in to]
    if not theirs_only or not ours_only:
        raise SystemExit(f"PLANT TARGET ABSENT: theirs-only Lean files {len(theirs_only)}, ours-only {len(ours_only)}")
    th, ou = theirs_only[0], ours_only[0]
    added = [l for l in blob(theirs, "Proofs.lean").decode().split("\n")
             if l.startswith("import ") and l not in blob(ours, "Proofs.lean").decode().split("\n")]
    if not added:
        raise SystemExit("PLANT TARGET ABSENT: no import line of Proofs.lean that THEIRS added")

    def planted(path, f):
        old = read(path)
        new = f(old)
        if new == old:
            raise SystemExit(f"PLANT IS A NO-OP on {path}")
        h = subprocess.run(["git", "hash-object", "--stdin"], input=new, capture_output=True, check=True).stdout.decode().strip()
        mt = dict(mtree)
        mt[path] = h
        return mt, (lambda p: new if p == path else read(p))

    def flip(m):
        i = next(j for j, ch in enumerate(m) if chr(ch).isalpha())
        return m[:i] + (b"x" if m[i:i + 1] != b"x" else b"y") + m[i + 1:]

    def dbl(m):
        lines = m.decode().split("\n")
        i = next(j for j, l in enumerate(lines) if l.startswith("#print axioms "))
        return "\n".join(lines[:i] + [lines[i]] + lines[i:]).encode()

    plants = [
        (f"a byte of a THEIRS-only file ({th})", th, planted(th, flip), ()),
        (f"a line added to an OURS-only file ({ou})", ou, planted(ou, lambda m: m + b"\n-- planted\n"), ()),
        (f"an import THEIRS added dropped ({added[0]})", "Proofs.lean",
         planted("Proofs.lean", lambda m: m.replace((added[0] + "\n").encode(), b"", 1)), ()),
        ("a doubled axioms record", "scripts/Axioms.lean", planted("scripts/Axioms.lean", dbl), ()),
        (f"a file changed by both outside KEEP_BOTH ({ou})", ou, (mtree, read), (ou,)),
    ]
    for name, path, (mt, r), extra in plants:
        _, _, b2 = check(base, ours, theirs, mt, r, extra_both=extra)
        # fired: at least one failure, and every failure names the planted file (a doubled record trips two checks of one file)
        fired = bool(b2) and all(x.startswith(path + ":") for x in b2)
        print(f"plant — {name}: {'FIRED' if fired else 'DID NOT FIRE'}  {b2[:1]}")
        ok = ok and fired
    print("SELF-TEST:", "every plant fired, the unplanted run passed" if ok else "FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
