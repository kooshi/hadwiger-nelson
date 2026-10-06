#!/usr/bin/env python3
"""FS131-IR1: `a20bb6f5` (`origin/fs131-wop`'s tip: `main` plus `OpenMove`) merged into `fs131-w5c` — every file is the side it should
be, byte for byte.

For every path in the trees of BASE, OURS, THEIRS (all files, not only `Proofs/`), with the merged side read from the index, which the
working tree must equal (or from `--rev`); blobs are compared by hash, so a symlink is its target path:
  - both sides equal: the merged file is that text;
  - changed by THEIRS only (or added by it): the merged file equals THEIRS';
  - changed by OURS only (or added by it): the merged file equals OURS';
  - changed by both: allowed only for KEEP_BOTH (`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`), where the merged file's
    lines, as a multiset, are OURS' + THEIRS' − BASE's (every line either side added is there once per addition, nothing dropped), with
    one blank line of slack for the joint between two kept blocks; and no `import` line, `#print axioms` record or module-table row
    occurs twice.
Usage: fs131_ir_merge_check.py [BASE OURS THEIRS] [--rev MERGED] [--self-test]   (defaults 1be5d622 61a0b31d a20bb6f5).
Exit 0 only on PASS. `--self-test` plants five faults (a byte in `OpenMove.lean`, THEIRS-only; an extra line in `Procedure.lean`,
OURS-only; `Proofs.lean`'s `OpenMove` import dropped; a doubled axioms record; a file changed by both outside KEEP_BOTH) and requires
each to FAIL naming its file, and the unplanted run to PASS.
"""
import collections
import pathlib
import re
import subprocess
import sys

KEEP_BOTH = {"Proofs.lean", "ARCHITECTURE.md", "scripts/Axioms.lean"}


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


def check(base, ours, theirs, mtree, mread, extra_both=()):
    """mtree: path -> blob hash of the merged side; mread: path -> its bytes (or None)."""
    tb, to, tt = tree(base), tree(ours), tree(theirs)
    bad = []
    n = 0
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
            keyed = collections.Counter()
            for line in m.decode().split("\n"):
                if path == "Proofs.lean" and line.startswith("import "):
                    keyed[line] += 1
                if path == "scripts/Axioms.lean" and line.startswith("#print axioms "):
                    keyed[line] += 1
                if path == "ARCHITECTURE.md":
                    mm = re.match(r"\| `([^`]+)` \|", line)
                    if mm:
                        keyed[mm.group(1)] += 1
            # the base may already hold a repeat; only a repeat the merge created fails
            base_keyed = collections.Counter()
            if b:
                for line in blob(base, path).decode().split("\n"):
                    if path == "Proofs.lean" and line.startswith("import "):
                        base_keyed[line] += 1
                    if path == "scripts/Axioms.lean" and line.startswith("#print axioms "):
                        base_keyed[line] += 1
                    if path == "ARCHITECTURE.md":
                        mm = re.match(r"\| `([^`]+)` \|", line)
                        if mm:
                            base_keyed[mm.group(1)] += 1
            twice = [k for k, c in keyed.items() if c > 1 and c > max(base_keyed[k], collections.Counter(
                l for l in blob(ours, path).decode().split("\n"))[k], collections.Counter(
                l for l in blob(theirs, path).decode().split("\n"))[k])]
            if twice:
                bad.append(f"{path}: twice after the merge: {twice[:3]}")
            continue
        if mh != want:
            bad.append(f"{path}: merged text is not the side it should be")
    return n, bad


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    rev = None
    if "--rev" in sys.argv:
        rev = sys.argv[sys.argv.index("--rev") + 1]
        args = [a for a in args if a != rev]
    base, ours, theirs = (args + ["1be5d622", "61a0b31d", "a20bb6f5"])[:3] if len(args) >= 3 else ("1be5d622", "61a0b31d", "a20bb6f5")
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
    n, bad = check(base, ours, theirs, mtree, read)
    if "--self-test" not in sys.argv:
        for line in bad:
            print("FAIL", line)
        print(f"{n} files; {len(bad)} failure(s)")
        print("PASS" if not bad else "FAIL")
        sys.exit(1 if bad else 0)
    ok = not bad
    print("unplanted:", "PASS" if ok else f"FAIL {bad[:3]}")
    om = "Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean"
    pr = "Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean"

    def planted(path, f):
        new = f(read(path))
        h = subprocess.run(["git", "hash-object", "--stdin"], input=new, capture_output=True, check=True).stdout.decode().strip()
        mt = dict(mtree)
        mt[path] = h
        return mt, (lambda p: new if p == path else read(p))

    def dbl(m):
        lines = m.decode().split("\n")
        i = next(j for j, l in enumerate(lines) if l.startswith("#print axioms HadwigerNelson.Plane.ArcMap.exists_open"))
        return "\n".join(lines[:i] + [lines[i]] + lines[i:]).encode()

    plants = [
        (om, planted(om, lambda m: m.replace(b"HasHornCount", b"HasHornCounx", 1)), ()),
        (pr, planted(pr, lambda m: m + b"\n-- planted\n"), ()),
        ("Proofs.lean", planted("Proofs.lean", lambda m: m.replace(b"import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove\n", b"", 1)), ()),
        ("scripts/Axioms.lean", planted("scripts/Axioms.lean", dbl), ()),
        (pr, (mtree, read), (pr,)),
    ]
    for path, (mt, r), extra in plants:
        _, b2 = check(base, ours, theirs, mt, r, extra_both=extra)
        # fired: at least one failure, and every failure names the planted file (a doubled record trips two checks of one file)
        fired = bool(b2) and all(x.startswith(path + ":") for x in b2)
        print(f"plant {path}: {'FIRED' if fired else 'DID NOT FIRE'}  {b2[:1]}")
        ok = ok and fired
    print("SELF-TEST:", "every plant fired, the unplanted run passed" if ok else "FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
