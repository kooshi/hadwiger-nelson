#!/usr/bin/env python3
"""FS131-IKL1: no stored statement or definition changed, from the kernel's side.

Reads dumps made by `data/fs131/ikl1/lean/StatementDump.lean` (or FS131-ICM3's and FS131-IKC3's dumpers, same format:
`## MODULE <m> constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL]`, `TYPE <hash> <raw>`, `VALUE <hash> <raw>`
for a definition, `PP …`).

  fs131_ikl1_statements.py REF [REF ...] --new NEW [--modules-of-ref] [--plant]

For every module of the REF dumps, every constant there (internal names included: a module whose source and imports are
unchanged must store every constant, generated ones too, identically) is looked up in NEW's dump of the same module:
  SAME     same kind, same stored type, and for a definition the same stored value
  CHANGED  a kind, type or value differs                   -> FAIL
  MISSING  absent from NEW's module                       -> FAIL
NEW's constants of that module absent from REF are ADDED -> FAIL (nothing may be added to a module the line holds).
A REF module NEW does not dump at all is MODULE-MISSING -> FAIL. NEW's modules absent from every REF are listed as
NEW-MODULE (allowed: the job's own).

--plant runs the comparison three more times on NEW changed in memory (one character of one stored type; one constant
dropped; one constant added) and requires each to be reported, or exits 1. Exit 0 only when the real comparison is clean
and, with --plant, every control fired.
"""
import copy
import lzma
import sys


def read(path):
    opener = lzma.open if path.endswith(".xz") else open
    mods, cur, last = {}, None, None
    with opener(path, "rt", encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if line.startswith("## MODULE "):
                cur = line.split()[2]
                mods[cur] = {}
            elif line.startswith("@@ "):
                parts = line.split()
                last = parts[2]
                mods[cur][last] = {"kind": parts[1], "type": None, "value": None}
            elif line.startswith("TYPE "):
                mods[cur][last]["type"] = line[5:]
            elif line.startswith("VALUE "):
                mods[cur][last]["value"] = line[6:]
    return mods


def compare(refs, new, quiet=False):
    counts = {"SAME": 0, "CHANGED": 0, "MISSING": 0, "ADDED": 0, "MODULE-MISSING": 0}
    out = []
    for m, consts in refs.items():
        if m not in new:
            counts["MODULE-MISSING"] += 1
            out.append(f"MODULE-MISSING {m}")
            continue
        nm = new[m]
        for name, c in consts.items():
            d = nm.get(name)
            if d is None:
                counts["MISSING"] += 1
                out.append(f"MISSING {m} {name}")
            elif d != c:
                counts["CHANGED"] += 1
                out.append(f"CHANGED {m} {name}\n  REF {c}\n  NEW {d}")
            else:
                counts["SAME"] += 1
        for name in nm:
            if name not in consts:
                counts["ADDED"] += 1
                out.append(f"ADDED {m} {name}")
    newmods = [m for m in new if m not in refs]
    if not quiet:
        for l in out:
            print(l)
        for m in newmods:
            print(f"NEW-MODULE {m} constants={len(new[m])}")
        print("modules compared:", len(refs), " ".join(sorted(refs)))
    bad = counts["CHANGED"] + counts["MISSING"] + counts["ADDED"] + counts["MODULE-MISSING"]
    return bad, counts


def main(argv):
    if "--new" not in argv:
        print("usage: fs131_ikl1_statements.py REF [REF ...] --new NEW [--plant]")
        return 2
    i = argv.index("--new")
    refpaths = [a for a in argv[:i] if not a.startswith("--")]
    newpath = argv[i + 1]
    plant = "--plant" in argv
    refs = {}
    for p in refpaths:
        for m, c in read(p).items():
            if m in refs:
                print(f"FAIL: module {m} in two REF dumps")
                return 1
            refs[m] = c
    if not refs or sum(len(c) for c in refs.values()) == 0:
        print("FAIL: the REF dumps hold no constant")
        return 1
    new = read(newpath)
    bad, counts = compare(refs, new)
    print("COUNTS", " ".join(f"{k}={v}" for k, v in counts.items()))
    rc = 0 if bad == 0 else 1
    print("VERDICT", "PASS" if rc == 0 else "FAIL")
    if plant:
        m0 = next(iter(refs))
        n0 = next(iter(refs[m0]))
        fired = 0
        p1 = copy.deepcopy(new)
        t = p1[m0][n0]["type"]
        p1[m0][n0]["type"] = t[:-1] + ("X" if t[-1] != "X" else "Y")
        b, c = compare(refs, p1, quiet=True)
        ok = c["CHANGED"] >= 1
        fired += ok
        print("PLANT changed-type", "FIRED" if ok else "SILENT", c)
        p2 = copy.deepcopy(new)
        del p2[m0][n0]
        b, c = compare(refs, p2, quiet=True)
        ok = c["MISSING"] >= 1
        fired += ok
        print("PLANT dropped", "FIRED" if ok else "SILENT", c)
        p3 = copy.deepcopy(new)
        p3[m0]["HadwigerNelson.planted_constant"] = {"kind": "THM", "type": "0 True", "value": None}
        b, c = compare(refs, p3, quiet=True)
        ok = c["ADDED"] >= 1
        fired += ok
        print("PLANT added", "FIRED" if ok else "SILENT", c)
        print(f"PLANTS {fired}/3")
        if fired != 3:
            return 1
    return rc


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
