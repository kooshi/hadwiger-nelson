#!/usr/bin/env python3
"""FS131-ICL1: each ruled statement change (item 726's word: an unread instance binder dropped by `omit … in`) is exactly
that. For each ruled name, strip from BEFORE's stored type the instance binders of the classes named for it, and require the
result to equal AFTER's stored type character for character. --plant strips one class too few and requires a mismatch.

Usage: fs131_icl1_ruled.py BEFORE AFTER [--plant]
"""
import re
import sys

RULED = {
    "HadwigerNelson.Rigidity.measurableSet_lonely": ["AddCommGroup", "Fintype", "DecidableEq"],
    "HadwigerNelson.Rigidity.unitPairsNull_lonely": ["AddCommGroup", "Fintype", "DecidableEq"],
    "HadwigerNelson.Rigidity.ae_sIndep_social": ["DecidableEq"],
    "HadwigerNelson.Rigidity.ae_disjoint_touched": ["DecidableEq"],
    "HadwigerNelson.Rigidity.Counting.measure_ne_eq": ["NumberField"],
}


def types(path):
    out, cur = {}, None
    for line in open(path, encoding="utf-8"):
        if line.startswith("@@ "):
            cur = line.split()[2]
        elif line.startswith("TYPE ") and cur:
            out[cur] = line.rstrip("\n").split(" ", 2)[2]
    return out


def strip(t, cls):
    # an instance binder `[inst._@… : Cls.{…} …] ` — up to its matching bracket
    i = t.find(f" : {cls}")
    if i < 0:
        return None
    j = t.rfind("[", 0, i)
    depth, k = 0, j
    while k < len(t):
        depth += t[k] == "["
        depth -= t[k] == "]"
        if depth == 0:
            break
        k += 1
    return t[:j] + t[k + 2:]


def main(argv):
    b, a = types(argv[0]), types(argv[1])
    plant = "--plant" in argv
    ok_all = True
    for n, classes in RULED.items():
        t = b[n]
        cl = classes[:-1] if plant else classes
        for c in cl:
            t2 = strip(t, c)
            if t2 is None:
                print(f"NO-BINDER {n}: {c}")
                ok_all = False
                break
            t = t2
        same = t == a[n]
        print(("EXACT    " if same else "DIFFERS  ") + f"{n}: stripped {cl}")
        ok_all &= same
    if plant:
        print("plant: " + ("SILENT (every stripped type matched)" if ok_all else "FIRED"))
        return 0 if not ok_all else 1
    print("RESULT: " + ("PASS" if ok_all else "FAIL"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
