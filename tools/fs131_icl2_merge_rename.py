#!/usr/bin/env python3
"""FS131-ICL2: the merge's three changed constants are FS131-IJ1's ruled rename and nothing else.

Reads the dump of the tree as given (`fs131-wcl` compiled) and the dump after the merge build, and for each constant the
comparator reports CHANGED compares its stored type (and value) with the old one in which `Counting.toL` is read as
`Rigidity.ofUnitRing` and `Counting.toL_mem_localRing` as `Counting.ofUnitRing_mem_localRing`. Prints SAME-UP-TO-RENAME or
DIFFERS per field; exits 1 on any DIFFERS. --plant changes one character of one renamed field and requires DIFFERS.
Usage: fs131_icl2_merge_rename.py OLD NEW [--plant]
"""
import importlib.util
import sys

spec = importlib.util.spec_from_file_location("st", __file__.replace("merge_rename", "statements"))
st = importlib.util.module_from_spec(spec)
spec.loader.exec_module(st)
NAMES = ["HadwigerNelson.Rigidity.Counting.exists_unitRing_of_normOneL", "HadwigerNelson.Rigidity.Counting.toLocal",
         "HadwigerNelson.Rigidity.Counting.ιG"]


def body(t):
    return t.split(" ", 1)[1] if t else t   # drop the hash


def rename(t):
    return (t.replace("HadwigerNelson.Rigidity.Counting.toL_mem_localRing", "HadwigerNelson.Rigidity.Counting.ofUnitRing_mem_localRing")
             .replace("HadwigerNelson.Rigidity.Counting.toL ", "HadwigerNelson.Rigidity.ofUnitRing "))


def main(argv):
    old, _ = st.parse(argv[0])
    new, _ = st.parse(argv[1])
    plant = "--plant" in argv
    bad = 0
    for n in NAMES:
        for fld in ("type", "value"):
            x, y = old[n][fld], new[n][fld]
            if x is None:
                continue
            x2 = rename(body(x))
            if plant and n == NAMES[0]:
                x2 = x2[:-1] + ("X" if x2[-1] != "X" else "Y")
            ok = x2 == body(y)
            bad += not ok
            print(n, fld, "SAME-UP-TO-RENAME" if ok else "DIFFERS")
    if plant:
        print("plant: " + ("FIRED" if bad == 1 else "SILENT"))
        return 0 if bad == 1 else 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
