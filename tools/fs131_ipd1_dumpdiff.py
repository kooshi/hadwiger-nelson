#!/usr/bin/env python3
"""FS131-IPD1: compare two dumps of `data/fs131/ipd1/lean/ModuleDumpHead.lean` (every constant of the named modules'
own compiled data: kind, name, stored type, universe parameters, the value's hash) constant by constant.

Each constant's block is its `@@` line and the lines after it up to the next `@@` or `##`.  Reports, per module and
in total, the constants IDENTICAL, DIFFERENT (with the first line that differs), and ONLY-IN one dump; exit 0 iff
every constant of either dump is IDENTICAL and the two dumps name the same modules with the same counts.

Usage: fs131_ipd1_dumpdiff.py A B [--modules M,M]      (.xz read transparently)
       fs131_ipd1_dumpdiff.py --control A               plant one changed type, one changed value hash, one constant
                                                        removed in a copy of A; require each reported, by name, and the
                                                        unplanted comparison of A with itself to pass
"""
import lzma
import sys


def read(path):
    op = lzma.open if path.endswith(".xz") else open
    mods, cur, blocks, order = {}, None, {}, []
    name = None
    with op(path, "rt") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            if ln.startswith("## MODULE "):
                p = ln.split()
                cur = p[2]
                mods[cur] = int(p[3].split("=")[1])
                name = None
            elif ln.startswith("## SUMMARY"):
                name = None
            elif ln.startswith("@@ "):
                name = (cur, ln.split()[2])
                if name in blocks:
                    raise SystemExit(f"{path}: {name} twice")
                blocks[name] = [ln]
                order.append(name)
            elif name is not None:
                blocks[name].append(ln)
    if not blocks:
        raise SystemExit(f"{path}: no constant read")
    return mods, blocks


def compare(a, b, only=None, quiet=False):
    ma, ba = a
    mb, bb = b
    bad = []
    if only:
        ba = {k: v for k, v in ba.items() if k[0] in only}
        bb = {k: v for k, v in bb.items() if k[0] in only}
        ma = {k: v for k, v in ma.items() if k in only}
        mb = {k: v for k, v in mb.items() if k in only}
    if ma != mb:
        bad.append(f"MODULES differ: {sorted(set(ma.items()) ^ set(mb.items()))[:6]}")
    same = 0
    for k in sorted(set(ba) | set(bb)):
        if k not in bb:
            bad.append(f"ONLY-IN-A {k[0]} {k[1]}")
        elif k not in ba:
            bad.append(f"ONLY-IN-B {k[0]} {k[1]}")
        elif ba[k] != bb[k]:
            i = next((i for i, (x, y) in enumerate(zip(ba[k], bb[k])) if x != y), min(len(ba[k]), len(bb[k])))
            x = ba[k][i] if i < len(ba[k]) else "(none)"
            y = bb[k][i] if i < len(bb[k]) else "(none)"
            bad.append(f"DIFFERENT {k[0]} {k[1]}: {x[:90]!r} / {y[:90]!r}")
        else:
            same += 1
    if not quiet:
        for x in bad:
            print(x)
        print(f"DUMPDIFF {'OK' if not bad else 'FAILED'}: {same} IDENTICAL, {len(bad)} reported, "
              f"{len(ma)} modules")
    return bad


def main():
    if sys.argv[1] == "--control":
        a = read(sys.argv[2])
        ok = not compare(a, a, quiet=True)
        print(f"unplanted (A against itself): {'PASS' if ok else 'FAILED'}")
        mods, blocks = a
        keys = list(blocks)
        k1, k2, k3 = keys[len(keys) // 3], keys[len(keys) // 2], keys[2 * len(keys) // 3]
        pb = {k: list(v) for k, v in blocks.items()}
        t = next(i for i, ln in enumerate(pb[k1]) if ln.startswith("TYPE "))
        pb[k1][t] = pb[k1][t] + " planted"
        v = next((i for i, ln in enumerate(pb[k2]) if ln.startswith("VALUE ")), None)
        if v is None:
            k2 = next(k for k in keys[len(keys) // 2:] if any(ln.startswith("VALUE ") for ln in blocks[k]))
            v = next(i for i, ln in enumerate(pb[k2]) if ln.startswith("VALUE "))
        pb[k2][v] = "VALUE 1" + pb[k2][v][len("VALUE "):]
        del pb[k3]
        pm = dict(mods)
        pm[k3[0]] -= 1
        rep = compare(a, (pm, pb), quiet=True)
        want = {f"DIFFERENT {k1[0]} {k1[1]}", f"DIFFERENT {k2[0]} {k2[1]}", f"ONLY-IN-A {k3[0]} {k3[1]}"}
        got = {r.split(":")[0] for r in rep if not r.startswith("MODULES")}
        mod_rep = any(r.startswith("MODULES") for r in rep)
        for w in sorted(want):
            print(f"plant '{w}': {'REPORTED' if w in got else 'SILENT'}")
        print(f"plant 'a module's count off by one': {'REPORTED' if mod_rep else 'SILENT'}")
        good = ok and want <= got and len(got) == 3 and mod_rep
        print("CONTROL OK" if good else "CONTROL FAILED")
        return 0 if good else 1
    only = None
    if "--modules" in sys.argv:
        only = {"Proofs.HadwigerNelson.Outside." + m if "." not in m else m
                for m in sys.argv[sys.argv.index("--modules") + 1].split(",")}
    bad = compare(read(sys.argv[1]), read(sys.argv[2]), only)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
