#!/usr/bin/env python3
"""FS131-ICL2: no statement and no definition of this job's five modules changed, from the kernel's side
(after FS131-ICL1's comparator, `tools/fs131_icl1_statements.py`).

Reads two dumps made by `data/fs131/icl2/lean/StatementDump.lean` (every constant of `Rigidity/FiniteZhang`,
`CountTorus`, `CountResidue`, `CountCompletion`, `CountDescent` as the compiled `.olean`s store it):

  BEFORE  the dump of the tree as given (before any edit to the five files)
  AFTER   the dump of the tree after the proofs

and reports, for every constant of BEFORE that is not an internal name (`Name.isInternalDetail`):
  SAME      same kind, same stored type (and, for a definition, the same stored value)
  CHANGED   a stored type or value differs (both lines printed)      -> FAIL, unless named by --ruled
  MISSING   absent from AFTER                                         -> FAIL
and for AFTER's constants absent from BEFORE:
  ADDED-INTERNAL   a private helper or a generated name (allowed: proofs and private helpers are this job's)
  ADDED-GENERATED  a reserved name Lean generates on demand where a tactic asks (`f.congr_simp`, `f.eq_<n>`, `f.eq_def`;
                   no author can declare one) — allowed, listed; `scripts/dupnames.sh` reads whether another module
                   holds a copy
  ADDED-PUBLIC     a public declaration                               -> FAIL (the brief allows none)

It also reads every stored type of BEFORE (or of one dump, with --binders-only) for the class binders its section declares
(item 847's defect): in `Rigidity/FiniteZhang` a constant whose type binds `G` must bind `AddCommGroup G` and `Finite G`;
in the four other modules a constant whose type names `Subfield` must bind `NumberField`. Each miss is printed as
BINDER-MISS (a reading, classed by hand in the record: by design — a declaration above the section's `variable`, an
`omit … in`, a definition that reads no finiteness — or a defect), not a failure of the comparison.

--ruled NAME … names constants whose change the brief rules (here `Counting.finite_quot`, item 847 ruling 2): reported
RULED with both stored types, not failed.

--plant runs the comparison three more times on AFTER changed in memory (one character of one public stored type; one
public constant dropped; one public constant added) and requires each to be reported, or exits 1.

Usage: fs131_icl1_statements.py BEFORE AFTER [--ruled NAME ...] [--plant]
       fs131_icl1_statements.py --binders-only DUMP
"""
import re
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_def|eq_\d+)$")

FZ = "Proofs.HadwigerNelson.Rigidity.FiniteZhang"
CE = "Proofs.HadwigerNelson.Rigidity.CountResidue"   # the plant's module for the binder control


def parse(path):
    consts, order, mod, cur = {}, [], None, None
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if line.startswith("## MODULE "):
                mod = line.split()[2]
            elif line.startswith("@@ "):
                parts = line.split()
                cur = {"kind": parts[1], "name": parts[2], "internal": "INTERNAL" in parts[3:], "mod": mod,
                       "type": None, "value": None, "pp": None}
                consts[cur["name"]] = cur
                order.append(cur["name"])
            elif line.startswith("TYPE "):
                cur["type"] = line[5:]
            elif line.startswith("VALUE "):
                cur["value"] = line[6:]
            elif line.startswith("PP "):
                cur["pp"] = line[3:]
    if not consts:
        raise SystemExit(f"FAIL: no constant parsed from {path}")
    return consts, order


def binder_misses(consts):
    out = []
    for n, c in consts.items():
        if c["internal"] or c["type"] is None:
            continue
        t = c["type"]
        # a class binder is a binder whose type is the class applied: ` : NumberField.{0} (…)` in the raw print (a mere
        # mention, `NumberField.RingOfIntegers …`, is not one — the first version of this check read it as one and was
        # blind to `finite_quot`, item 847's defect; the control below now plants exactly that shape)
        if c["mod"] == FZ and ("{G : Type" in t or "(G : Type" in t):
            for cls in ("AddCommGroup", "Finite"):
                if not re.search(r" : " + cls + r"\.\{", t):
                    out.append(f"BINDER-MISS {n}: binds G, lacks {cls}")
        if c["mod"] != FZ and "Subfield" in t and not re.search(r" : NumberField\.\{", t):
            out.append(f"BINDER-MISS {n}: names Subfield, lacks NumberField")
    return out


def compare(before, after, ruled, quiet=False):
    bad, lines = 0, []
    counts = {"SAME": 0, "CHANGED": 0, "RULED": 0, "MISSING": 0, "ADDED-INTERNAL": 0, "ADDED-GENERATED": 0,
              "ADDED-PUBLIC": 0}
    for n, b in before.items():
        if b["internal"]:
            continue
        a = after.get(n)
        if a is None:
            counts["MISSING"] += 1
            bad += 1
            lines.append(f"MISSING {n}")
            continue
        same = a["kind"] == b["kind"] and a["type"] == b["type"] and (b["kind"] != "DEF" or a["value"] == b["value"])
        if same:
            counts["SAME"] += 1
        elif n in ruled:
            counts["RULED"] += 1
            lines.append(f"RULED {n}\n  before TYPE {b['type']}\n  after  TYPE {a['type']}")
        else:
            counts["CHANGED"] += 1
            bad += 1
            lines.append(f"CHANGED {n}\n  before TYPE {b['type']}\n  after  TYPE {a['type']}")
            if b["kind"] == "DEF" and a["value"] != b["value"]:
                lines.append("  (stored value differs)")
    for n, a in after.items():
        if n in before:
            continue
        if a["internal"]:
            counts["ADDED-INTERNAL"] += 1
            lines.append(f"ADDED-INTERNAL {n}")
        elif GENERATED.search(n):
            counts["ADDED-GENERATED"] += 1
            lines.append(f"ADDED-GENERATED {n}")
        else:
            counts["ADDED-PUBLIC"] += 1
            bad += 1
            lines.append(f"ADDED-PUBLIC {n}")
    if not quiet:
        for l in lines:
            print(l)
        print(" ".join(f"{k}={v}" for k, v in counts.items()))
    return bad, counts


def main(argv):
    if argv[:1] == ["--binders-only"]:
        consts, _ = parse(argv[1])
        m = binder_misses(consts)
        for l in m:
            print(l)
        print(f"binder misses: {len(m)} of {sum(1 for c in consts.values() if not c['internal'])} public constants")
        return 0
    args = [a for a in argv if not a.startswith("--")]
    ruled = set()
    if "--ruled" in argv:
        i = argv.index("--ruled")
        ruled = {a for a in argv[i + 1:] if not a.startswith("--")}
        args = [a for a in args if a not in ruled]
    before, border = parse(args[0])
    after, _ = parse(args[1])
    for l in binder_misses(before):
        print(l)
    bad, counts = compare(before, after, ruled)
    if counts["SAME"] == 0:
        print("FAIL: no constant compared")
        return 1
    if "--plant" in argv:
        pub = [n for n in border if not before[n]["internal"] and n in after and n not in ruled]
        if not pub:
            print("FAIL: no public constant to plant into")
            return 1
        t = pub[len(pub) // 2]
        ok = True
        # 1. one character of one stored type
        a1 = {k: dict(v) for k, v in after.items()}
        ty = a1[t]["type"]
        j = len(ty) // 2
        a1[t]["type"] = ty[:j] + ("X" if ty[j] != "X" else "Y") + ty[j + 1:]
        b1, c1 = compare(before, a1, ruled, quiet=True)
        print(f"PLANT type-char in {t}: CHANGED={c1['CHANGED']} -> {'FIRED' if c1['CHANGED'] >= 1 else 'SILENT'}")
        ok &= c1["CHANGED"] >= 1
        # 2. one constant dropped
        a2 = {k: v for k, v in after.items() if k != t}
        b2, c2 = compare(before, a2, ruled, quiet=True)
        print(f"PLANT drop {t}: MISSING={c2['MISSING']} -> {'FIRED' if c2['MISSING'] >= 1 else 'SILENT'}")
        ok &= c2["MISSING"] >= 1
        # 3. one public constant added
        a3 = dict(after)
        a3["HadwigerNelson.FS131ICL2Plant"] = {"kind": "THM", "name": "HadwigerNelson.FS131ICL2Plant",
                                               "internal": False, "mod": FZ, "type": "True", "value": None, "pp": "True"}
        b3, c3 = compare(before, a3, ruled, quiet=True)
        print(f"PLANT add public: ADDED-PUBLIC={c3['ADDED-PUBLIC']} -> {'FIRED' if c3['ADDED-PUBLIC'] >= 1 else 'SILENT'}")
        ok &= c3["ADDED-PUBLIC"] >= 1
        # 4. a binder miss
        a4 = {k: dict(v) for k, v in before.items()}
        ce = [n for n in border if not before[n]["internal"] and before[n]["mod"] == CE
              and re.search(r" : NumberField\.\{", before[n]["type"]) and "NumberField.RingOfIntegers" in before[n]["type"]]
        if ce:
            # drop the binder's class and keep the mention `NumberField.RingOfIntegers` (the shape that hid item 847)
            a4[ce[0]]["type"] = re.sub(r" : NumberField\.\{", " : NumberFeld.{", a4[ce[0]]["type"])
            m4 = binder_misses(a4)
            print(f"PLANT binder in {ce[0]}: misses={len(m4)} -> {'FIRED' if len(m4) > len(binder_misses(before)) else 'SILENT'}")
            ok &= len(m4) > len(binder_misses(before))
        print("plant: " + ("ALL FIRED" if ok else "SOME SILENT"))
        return 0 if ok else 1
    print("RESULT: " + ("PASS" if bad == 0 else f"FAIL ({bad})"))
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
