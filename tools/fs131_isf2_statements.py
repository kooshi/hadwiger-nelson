#!/usr/bin/env python3
"""FS131-ISF2 -- the merge and the docstring edit changed no stored constant, from the kernel's side.

Reads prints of the shared dumper (`data/fs131/isf2/lean/StatementDump.lean`, a copy of FS131-ISF1's, whose body is
FS131-IRF1's line for line; format: `## MODULE <m> constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL |
PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>` and, when its type is not
a proposition, `DATA <hash> <raw>`).

  compare BASE AFTER [--modules M1,M2,...]
For every module of BASE (or only the listed ones), every constant BASE holds there -- INTERNAL ones included -- must be in
AFTER's same module with the same header line (kind, name, flags) and the same TYPE line, VALUE line and DATA line (hash and
raw text): SAME. Otherwise CHANGED (naming the line) or MISSING; a constant AFTER holds in such a module that BASE does not
is ADDED. CHANGED, MISSING and ADDED all fail: nothing here was meant to move. A module of the selection absent from either
print fails.

--plant runs four more comparisons with AFTER changed in memory and requires each fault reported, by name, with nothing
else new: one character of the stored type of `HadwigerNelson.RationalFour.forall_coloring_eq_iff`; the head
`HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane` dropped; one character of the DATA of the first
definition of `Plane.G27.Check` that has one; a constant `HadwigerNelson.RationalFour.planted_extra` added to `Forbid`. A
plant whose target the selection does not hold is reported UNREACHABLE and fails (a plant that cannot fire is not a pass).
Exit 0 iff the clean comparison passes and, with --plant, every plant fires.
Usage: fs131_isf2_statements.py BASE AFTER [--modules M1,M2] [--plant]
"""
import copy
import gzip
import sys


def read(path):
    opener = gzip.open if path.endswith(".gz") else open
    mods, cur, last = {}, None, None
    with opener(path, "rt", encoding="utf-8") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            if ln.startswith("## MODULE "):
                cur = ln.split()[2]
                mods[cur] = {}
                last = None
            elif ln.startswith("@@ "):
                parts = ln.split()
                last = parts[2]
                assert last not in mods[cur], ("duplicate constant", cur, last)
                mods[cur][last] = {"HEAD": ln}
            elif ln.startswith(("TYPE ", "VALUE ", "DATA ")):
                key = ln.split(" ", 1)[0]
                assert last is not None and key not in mods[cur][last], ("stray line", cur, last, key)
                mods[cur][last][key] = ln
            elif ln.strip():
                raise SystemExit(f"unparsed line in {path}: {ln[:120]!r}")
    return mods


def compare(base, after, sel):
    out = []
    for m in sel:
        if m not in base or m not in after:
            out.append(f"MODULE-ABSENT {m} (base: {m in base}, after: {m in after})")
            continue
        b, a = base[m], after[m]
        for n, rec in b.items():
            if n not in a:
                out.append(f"MISSING {m} {n}")
                continue
            for key in ("HEAD", "TYPE", "VALUE", "DATA"):
                if rec.get(key) != a[n].get(key):
                    out.append(f"CHANGED {m} {n} ({key})")
        for n in a:
            if n not in b:
                out.append(f"ADDED {m} {n}")
    return out


def counts(mods, sel):
    tot = sum(len(mods[m]) for m in sel if m in mods)
    internal = sum(1 for m in sel if m in mods for r in mods[m].values() if " INTERNAL" in r["HEAD"])
    return tot, internal


def main():
    argv = sys.argv[1:]
    plant = "--plant" in argv
    sel = None
    if "--modules" in argv:
        i = argv.index("--modules")
        sel = argv[i + 1].split(",")
        del argv[i:i + 2]
    argv = [x for x in argv if x != "--plant"]
    base_p, after_p = argv
    base, after = read(base_p), read(after_p)
    if sel is None:
        sel = list(base)
    clean = compare(base, after, sel)
    tot, internal = counts(base, sel)
    for m in sel:
        print(f"MODULE {m}: base {len(base.get(m, {}))} constants, after {len(after.get(m, {}))}")
    for ln in clean:
        print(ln)
    print(f"compared {tot} constants of {len(sel)} module(s) ({internal} INTERNAL included): "
          f"{tot - sum(1 for x in clean if x.startswith(('MISSING', 'CHANGED')))} SAME, {len(clean)} finding(s)")
    ok = not clean
    if plant:
        def first_data(mods):
            m = "Proofs.HadwigerNelson.Plane.G27.Check"
            for n, r in mods.get(m, {}).items():
                if "DATA" in r:
                    return m, n
            return None

        def p_type(a):
            m, n = "Proofs.HadwigerNelson.RationalFour.Compulsion", "HadwigerNelson.RationalFour.forall_coloring_eq_iff"
            if n not in a.get(m, {}):
                return None
            t = a[m][n]["TYPE"]
            a[m][n]["TYPE"] = t[:-1] + ("X" if t[-1] != "X" else "Y")
            return f"CHANGED {m} {n} (TYPE)"

        def p_drop(a):
            m = "Proofs.HadwigerNelson.Instances.SeamFractional"
            n = "HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane"
            if n not in a.get(m, {}):
                return None
            del a[m][n]
            return f"MISSING {m} {n}"

        def p_data(a):
            hit = first_data(a)
            if hit is None:
                return None
            m, n = hit
            d = a[m][n]["DATA"]
            a[m][n]["DATA"] = d[:-1] + ("X" if d[-1] != "X" else "Y")
            return f"CHANGED {m} {n} (DATA)"

        def p_add(a):
            m = "Proofs.HadwigerNelson.RationalFour.Forbid"
            if m not in a:
                return None
            n = "HadwigerNelson.RationalFour.planted_extra"
            a[m][n] = {"HEAD": f"@@ THM {n}", "TYPE": "TYPE 0 True"}
            return f"ADDED {m} {n}"

        for name, fn in (("type char", p_type), ("dropped head", p_drop), ("data char", p_data), ("added", p_add)):
            a = copy.deepcopy(after)
            want = fn(a)
            if want is None or not any(want.split()[1] == m for m in sel):
                print(f"PLANT {name}: UNREACHABLE (target not in the selection)")
                ok = False
                continue
            got = compare(base, a, sel)
            new = [x for x in got if x not in clean]
            fired = new == [want]
            print(f"PLANT {name}: {'FIRED' if fired else 'DID NOT FIRE'} (new: {new})")
            ok = ok and fired
    print("RESULT:", "CLEAN" if ok else "FAIL")
    sys.exit(0 if ok else 1)


main()
