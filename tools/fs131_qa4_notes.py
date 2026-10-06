#!/usr/bin/env python3
"""FS131-QA4: read each inhabitant note against its theorem's signature.

For every audited theorem whose docstring speaks of an inhabitant or model, print the model objects the docstring names
(`bowtie`, `cuspFrag`, `sevenBrick…`, `l60Frag`, `sixFrag`, `triLattice`, `halfDisc`, `threeSectorDisc`) beside the global
hypotheses its signature takes (`Covers`, `IsPlaneMap`, `IsTerminalMap`, `Condition5`), and flag a **CONFLICT** where the named
object is known not to satisfy one of them:
  bowtie   : not Covers 0 1, not IsPlaneMap (data/fs131/qa4/QA4Bowtie.lean), so not IsTerminalMap; fails Condition 5 (its unit arcs)
  cuspFrag : not Covers 0 1 (same file), so not IsPlaneMap, not IsTerminalMap
  l60Frag  : a neighbourhood of a lens: not IsPlaneMap, not IsTerminalMap
A docstring that itself limits the claim ("local hypotheses", "a fragment", "at the point", "is the caller's") is flagged
LOCAL-SAID, not CONFLICT.

Usage: fs131_qa4_notes.py list | --self-test
"""
import importlib.util, os, re, sys
HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("census", os.path.join(HERE, "fs131_qa4_census.py"))
census = importlib.util.module_from_spec(spec); spec.loader.exec_module(census)
qa1 = census.qa1
FAILS = {"bowtie": {"Covers", "IsPlaneMap", "IsTerminalMap", "Condition5"},
         "cuspFrag": {"Covers", "IsPlaneMap", "IsTerminalMap"},
         "l60Frag": {"IsPlaneMap", "IsTerminalMap"}}
OBJ = re.compile(r"`(bowtie|cuspFrag|sevenBrick\w*|l60Frag|sixFrag|triLattice|halfDisc|threeSectorDisc)\b")
GLOB = ("Covers", "IsPlaneMap", "IsTerminalMap", "Condition5")
SAID = re.compile(r"local hypothes|a fragment|at the point|the caller's|on a fragment|hypothesis by hypothesis", re.I)
NONE = re.compile(r"[Nn]o model|[Nn]o inhabitant|none (is )?expected|no Lean model|none in Lean", re.S)


def rows(loaded):
    out = []
    for b, ref, p, t, ds in loaded:
        if t is None:
            continue
        for d in ds:
            if d["kind"] not in census.THM_KINDS:
                continue
            doc = census.full_doc(t, d)
            m = census.INH_RE.search(doc)
            if not m:
                continue
            tail = doc[max(0, m.start() - 60):]
            objs = sorted({o if not o.startswith("sevenBrick") else "sevenBrick" for o in OBJ.findall(tail)})
            # hypotheses only: the signature up to its conclusion
            concl = census.conclusion(d["sig"])
            hyps = d["sig"][:len(d["sig"]) - len(concl)]
            glob = [g for g in GLOB if re.search(r"\b" + g + r"\b", hyps)]
            verdict = ""
            bad = sorted({g for o in objs for g in FAILS.get(o, ()) if g in glob})
            if bad:
                verdict = ("LOCAL-SAID" if SAID.search(tail) else "CONFLICT") + ":" + ",".join(bad)
            elif not objs and NONE.search(tail):
                verdict = "NONE-SAID"
            elif not objs:
                verdict = "NO-OBJECT"
            out.append((b, os.path.basename(p)[:-5], d["line"], d["name"], ",".join(glob), ",".join(objs), verdict))
    return out


def self_test():
    src = {(bd, p): "" for bd, _, p in census.AUDITED}
    k0 = (census.AUDITED[0][0], census.AUDITED[0][2])
    src[k0] = ("/-- A. Inhabitant of the hypotheses: `bowtie` at `0`. -/\n"
               "theorem a1 (hv : F.Covers v 1) (h : F.IsStuck v) : True := trivial\n\n"
               "/-- B. Model of the local hypotheses: `bowtie` at `0` (a fragment). -/\n"
               "theorem b1 (hP : F.IsPlaneMap) (h : F.IsStuck v) : True := trivial\n\n"
               "/-- C. Inhabitant: `bowtie` at `0`. -/\n"
               "theorem c1 (h : F.IsStuck v) : F.Covers v 1 → True := fun _ => trivial\n\n"
               "/-- D. Inhabitant of the hypotheses: `sevenBrickMap`. -/\n"
               "theorem d1 (hP : F.IsPlaneMap) : True := trivial\n\n"
               "/-- E. No model expected: a refutation. -/\n"
               "theorem e1 (hP : F.IsPlaneMap) : False := sorry\n")
    r = {x[3]: x for x in rows(census.load(src))}
    fails = 0

    def want(c, msg):
        nonlocal fails
        if not c:
            print("self-test FAIL:", msg); fails += 1
    want(r["a1"][6] == "CONFLICT:Covers", f"a1: {r['a1']}")
    want(r["b1"][6].startswith("LOCAL-SAID"), f"b1: {r['b1']}")
    want(r["c1"][6] == "", f"c1 (Covers in the conclusion, not a hypothesis): {r['c1']}")
    want(r["d1"][6] == "", f"d1: {r['d1']}")
    want(r["e1"][6] == "NONE-SAID", f"e1: {r['e1']}")
    # planted fault: with the bowtie's known failures emptied, a1 must stop being a conflict
    saved = FAILS["bowtie"]; FAILS["bowtie"] = set()
    want({x[3]: x for x in rows(census.load(src))}["a1"][6] == "", "PLANT: conflict reported with no known failure")
    FAILS["bowtie"] = saved
    print("self-test:", "OK (6 controls, 1 planted)" if fails == 0 else f"FAIL ({fails})")
    return 1 if fails else 0


if __name__ == "__main__":
    if len(sys.argv) >= 2 and sys.argv[1] == "--self-test":
        sys.exit(self_test())
    if len(sys.argv) >= 2 and sys.argv[1] == "list":
        for x in rows(census.load()):
            print("\t".join(str(y) for y in x))
        sys.exit(0)
    print(__doc__); sys.exit(2)
