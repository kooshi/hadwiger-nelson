#!/usr/bin/env python3
"""FS131-ICM4: no statement and no definition of this job's files changed, from the kernel's side
(FS131-ICM1's comparator, `tools/fs131_icm1_statements.py`, with one addition: the private declarations).

ADDED IN FS131-ICM2 — the private declarations. This job's six leaves are private theorems, and the definitions their
statements use (`levelSet`, `CharBound`, `red`) are private definitions; the comparison above skips every internal name.
So every `_private.<module>.0.<name>` constant of BEFORE whose last name component is a user name (not `_proof_n`,
`_simp_n`, `match_n`, `eq_n`, …) is compared as well: PRIVATE-SAME (same kind and stored type, and for a definition the
same stored value), PRIVATE-CHANGED (-> FAIL), PRIVATE-MISSING (-> FAIL). --plant adds a fifth control: one character of
a private leaf's stored type, which must read PRIVATE-CHANGED.

Reads two dumps made by `data/fs131/icm2/lean/StatementDump.lean` (every constant of the modules it names, as the compiled
`.olean`s store them):

  BEFORE  the dump of the tree as given (before any edit: `Rigidity/ClassRatio`, `CountCompletion`, and `CountDescent`
          for reference)
  AFTER   the dump of the tree after the proofs (the same modules, and the modules this job adds)

and reports, for every constant of BEFORE that is not an internal name (`Name.isInternalDetail`):
  SAME      same kind, same stored type (and, for a definition, the same stored value)
  CHANGED   a stored type or value differs (both lines printed)      -> FAIL, unless named by --ruled
  MISSING   absent from AFTER                                         -> FAIL
and for AFTER's constants absent from BEFORE:
  ADDED-INTERNAL   a private helper or a generated name (allowed: proofs and private helpers are this job's)
  ADDED-GENERATED  a reserved name Lean generates on demand (`f.congr_simp`, `f.eq_<n>`, `f.eq_def`) — allowed, listed
  NEW-MODULE       a public constant of a module BEFORE does not hold (a module this job adds: allowed, listed)
  ADDED-PUBLIC     a public declaration in a module BEFORE holds      -> FAIL (the brief allows none there)
  NEW              a public declaration named by --new NAME (ADDED IN FS131-ICM3: the brief's amendment of
                   2026-10-14 adds exactly `Rigidity.ratioAtMost_of_two_notMem`) — allowed, listed

It also reads every stored type of BEFORE (or of one dump, with --binders-only) for the class binder its section declares
(item 847's defect): a constant whose type names `Subfield` must bind `NumberField` (` : NumberField.{0} (…)` in the raw
print; a mere mention such as `NumberField.RingOfIntegers` is not a binder). Each miss is printed as BINDER-MISS, classed
by hand in the record, never a failure of the comparison.

--plant runs the comparison four more times on AFTER changed in memory (one character of one public stored type; one
public constant dropped; one public constant added in an old module; one binder's class removed with a mention of
`NumberField.RingOfIntegers` kept) and requires each to be reported, or exits 1.

Usage: fs131_icm1_statements.py BEFORE AFTER [--ruled NAME ...] [--plant]
       fs131_icm1_statements.py --binders-only DUMP
"""
import re
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_def|eq_\d+)$")
BINDER = re.compile(r" : NumberField\.\{")


def parse(path):
    consts, order, mod, cur, mods = {}, [], None, None, set()
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if line.startswith("## MODULE "):
                mod = line.split()[2]
                mods.add(mod)
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
    return consts, order, mods


def binder_misses(consts):
    out = []
    for n, c in consts.items():
        if c["internal"] or c["type"] is None:
            continue
        t = c["type"]
        if "Subfield" in t and not BINDER.search(t):
            out.append(f"BINDER-MISS {n} ({c['mod'].split('.')[-1]}): names Subfield, lacks NumberField")
    return out


USERPRIV = re.compile(r"^_private\.(?:[^.]+\.)+0\.(.+)$")


def private_user(n):
    m = USERPRIV.match(n)
    if not m:
        return None
    last = m.group(1).split(".")[-1]
    if last.startswith("_") or re.match(r"(match|eq|proof|simp)_\d+$", last) or last in ("eq_def", "congr_simp"):
        return None
    return m.group(1)


def compare_private(before, after, quiet=False):
    bad, counts, lines = 0, {"PRIVATE-SAME": 0, "PRIVATE-CHANGED": 0, "PRIVATE-MISSING": 0}, []
    for n, b in before.items():
        if private_user(n) is None:
            continue
        a = after.get(n)
        if a is None:
            counts["PRIVATE-MISSING"] += 1
            bad += 1
            lines.append(f"PRIVATE-MISSING {n}")
            continue
        same = a["kind"] == b["kind"] and a["type"] == b["type"] and (b["kind"] != "DEF" or a["value"] == b["value"])
        if same:
            counts["PRIVATE-SAME"] += 1
        else:
            counts["PRIVATE-CHANGED"] += 1
            bad += 1
            lines.append(f"PRIVATE-CHANGED {n}\n  before TYPE {b['type']}\n  after  TYPE {a['type']}")
    if not quiet:
        for l in lines:
            print(l)
        print(" ".join(f"{k}={v}" for k, v in counts.items()))
    return bad, counts


NEW_ALLOWED = set()


def compare(before, after, before_mods, ruled, quiet=False):
    bad, lines = 0, []
    counts = {"SAME": 0, "CHANGED": 0, "RULED": 0, "MISSING": 0, "ADDED-INTERNAL": 0, "ADDED-GENERATED": 0,
              "NEW-MODULE": 0, "ADDED-PUBLIC": 0}
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
        elif a["mod"] not in before_mods:
            counts["NEW-MODULE"] += 1
            lines.append(f"NEW-MODULE {a['mod'].split('.')[-1]} {n}")
        elif n in NEW_ALLOWED:
            counts["NEW"] = counts.get("NEW", 0) + 1
            lines.append(f"NEW {n}")
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
        consts, _, _ = parse(argv[1])
        m = binder_misses(consts)
        for l in m:
            print(l)
        print(f"binder misses: {len(m)} of {sum(1 for c in consts.values() if not c['internal'])} public constants")
        return 0
    if "--new" in argv:
        i = argv.index("--new")
        NEW_ALLOWED.add(argv[i + 1])
        argv = argv[:i] + argv[i + 2:]
    args = [a for a in argv if not a.startswith("--")]
    ruled = set()
    if "--ruled" in argv:
        i = argv.index("--ruled")
        ruled = {a for a in argv[i + 1:] if not a.startswith("--")}
        args = [a for a in args if a not in ruled]
    before, border, bmods = parse(args[0])
    after, _, _ = parse(args[1])
    for l in binder_misses(before):
        print(l)
    bad, counts = compare(before, after, bmods, ruled)
    pbad, pcounts = compare_private(before, after)
    bad += pbad
    if counts["SAME"] == 0 or pcounts["PRIVATE-SAME"] + pcounts["PRIVATE-CHANGED"] == 0:
        print("FAIL: no constant compared")
        return 1
    if "--plant" in argv:
        pub = [n for n in border if not before[n]["internal"] and n in after and n not in ruled]
        if not pub:
            print("FAIL: no public constant to plant into")
            return 1
        t = pub[len(pub) // 2]
        ok = True
        a1 = {k: dict(v) for k, v in after.items()}
        ty = a1[t]["type"]
        j = len(ty) // 2
        a1[t]["type"] = ty[:j] + ("X" if ty[j] != "X" else "Y") + ty[j + 1:]
        _, c1 = compare(before, a1, bmods, ruled, quiet=True)
        print(f"PLANT type-char in {t}: CHANGED={c1['CHANGED']} -> {'FIRED' if c1['CHANGED'] >= 1 else 'SILENT'}")
        ok &= c1["CHANGED"] >= 1
        a2 = {k: v for k, v in after.items() if k != t}
        _, c2 = compare(before, a2, bmods, ruled, quiet=True)
        print(f"PLANT drop {t}: MISSING={c2['MISSING']} -> {'FIRED' if c2['MISSING'] >= 1 else 'SILENT'}")
        ok &= c2["MISSING"] >= 1
        a3 = dict(after)
        oldmod = before[t]["mod"]
        a3["HadwigerNelson.FS131ICM2Plant"] = {"kind": "THM", "name": "HadwigerNelson.FS131ICM2Plant",
                                               "internal": False, "mod": oldmod, "type": "True", "value": None,
                                               "pp": "True"}
        _, c3 = compare(before, a3, bmods, ruled, quiet=True)
        print(f"PLANT add public in {oldmod.split('.')[-1]}: ADDED-PUBLIC={c3['ADDED-PUBLIC']} -> "
              f"{'FIRED' if c3['ADDED-PUBLIC'] >= 1 else 'SILENT'}")
        ok &= c3["ADDED-PUBLIC"] >= 1
        a4 = {k: dict(v) for k, v in before.items()}
        ce = [n for n in border if not before[n]["internal"] and BINDER.search(before[n]["type"] or "")]
        if not ce:
            print("FAIL: no constant with a NumberField binder to plant into")
            return 1
        a4[ce[0]]["type"] = BINDER.sub(" : NumberFeld.{", a4[ce[0]]["type"]) + " NumberField.RingOfIntegers"
        m4 = binder_misses(a4)
        fired = len(m4) > len(binder_misses(before))
        print(f"PLANT binder in {ce[0]}: misses={len(m4)} -> {'FIRED' if fired else 'SILENT'}")
        ok &= fired
        pv = [n for n in border if private_user(n) and n in after and (private_user(n) or "").endswith("colorable_four_dyadic_small")]
        if not pv:
            print("FAIL: no private leaf to plant into")
            return 1
        a5 = {k: dict(v) for k, v in after.items()}
        ty = a5[pv[0]]["type"]
        j = len(ty) // 2
        a5[pv[0]]["type"] = ty[:j] + ("X" if ty[j] != "X" else "Y") + ty[j + 1:]
        _, c5 = compare_private(before, a5, quiet=True)
        print(f"PLANT type-char in private {private_user(pv[0])}: PRIVATE-CHANGED={c5['PRIVATE-CHANGED']} -> "
              f"{'FIRED' if c5['PRIVATE-CHANGED'] >= 1 else 'SILENT'}")
        ok &= c5["PRIVATE-CHANGED"] >= 1
        print("plant: " + ("ALL FIRED" if ok else "SOME SILENT"))
        return 0 if ok else 1
    print("RESULT: " + ("PASS" if bad == 0 else f"FAIL ({bad})"))
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
