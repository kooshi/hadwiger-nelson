#!/usr/bin/env python3
"""FS131-ISF1 -- the implementer changed no stored statement of the skeleton, from the kernel's side.

Reads two prints of `data/fs131/isf1/lean/StatementDump.lean` (a copy of FS131-IRU2's dumper; format: `## MODULE <m>
constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and
for a definition `VALUE <hash> <raw>` and, when its type is not a proposition, `DATA <hash> <raw>`):
  BEFORE -- the skeleton as the planner's build compiled it (`data/fs131/isf1/statements-skeleton.txt`, made before the
            first proof edit);
  AFTER  -- the filled module as the implementer's build compiled it.

For every constant of BEFORE that is not INTERNAL:
  SAME     AFTER's same module holds it with the same kind and flags and the same stored type (text); for a definition
           whose type is not a proposition, the same DATA (its value with proofs erased);
  CHANGED  anything else that differs                                                 -> FAIL;
  MISSING  absent from AFTER                                                          -> FAIL.
Constants AFTER adds to a module of BEFORE are listed as ADDED (helpers the proofs needed; never a failure, always shown).
Modules AFTER holds that BEFORE does not are counted per module (new modules: nothing of the skeleton to compare).

--plant runs the comparison three more times on AFTER changed in memory and requires each fault reported by name:
one character of `fractionalChromaticNumber_seamPlane`'s stored type changed; `iSup_fractionalChromaticNumber_seamPlane`
dropped; the kind of `numberField_seamField` changed. With the plants, exit 0 iff the clean comparison passed and every
plant fired.
Usage: fs131_isf1_statements.py BEFORE AFTER [--plant]
"""
import copy
import gzip
import sys

SEAM = "Proofs.HadwigerNelson.Instances.SeamFractional"
NS = "HadwigerNelson.Instances.SeamFractional."


def read(path):
    opener = gzip.open if path.endswith(".gz") else open
    mods, cur, last = {}, None, None
    with opener(path, "rt", encoding="utf-8") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            if ln.startswith("## MODULE "):
                cur = ln.split()[2]
                mods[cur] = {}
            elif ln.startswith("@@ "):
                parts = ln.split()
                kind, name = parts[1], parts[2]
                last = {"kind": kind, "flags": " ".join(parts[3:])}
                mods[cur][name] = last
            elif ln.startswith(("TYPE ", "VALUE ", "DATA ")):
                tag, rest = ln.split(" ", 1)
                last[tag] = rest.split(" ", 1)[1] if " " in rest else ""
    return mods


def compare(before, after):
    fails, added, same = [], [], 0
    for m, consts in before.items():
        am = after.get(m)
        if am is None:
            fails.append(f"MISSING-MODULE {m}")
            continue
        for n, c in consts.items():
            if "INTERNAL" in c["flags"].split():
                continue
            a = am.get(n)
            if a is None:
                fails.append(f"MISSING {n}")
                continue
            diffs = []
            if a["kind"] != c["kind"]:
                diffs.append("kind")
            if a["flags"] != c["flags"]:
                diffs.append("flags")
            if a.get("TYPE") != c.get("TYPE"):
                diffs.append("type")
            if c["kind"] == "DEF" and "PROPTYPE" not in c["flags"].split() and a.get("DATA") != c.get("DATA"):
                diffs.append("data")
            if diffs:
                fails.append(f"CHANGED {n} ({', '.join(diffs)})")
            else:
                same += 1
        for n, a in am.items():
            if n not in consts and "INTERNAL" not in a["flags"].split():
                added.append(f"{n} [{a['kind']}]")
    newmods = {m: len(c) for m, c in after.items() if m not in before}
    return fails, added, same, newmods


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after = read(args[0]), read(args[1])
    fails, added, same, newmods = compare(before, after)
    print(f"skeleton constants compared: {same} SAME, {len(fails)} failing")
    for f in fails:
        print("  FAIL " + f)
    print(f"added to the skeleton's modules: {len(added)}")
    for a in added:
        print("  ADDED " + a)
    print(f"new modules: {len(newmods)}, constants {sum(newmods.values())}")
    ok = not fails
    if "--plant" in sys.argv:
        plants = []
        p1 = copy.deepcopy(after)
        t = p1[SEAM][NS + "fractionalChromaticNumber_seamPlane"]
        t["TYPE"] = t["TYPE"].replace("4", "5", 1)
        plants.append(("type of fractionalChromaticNumber_seamPlane", p1,
                       f"CHANGED {NS}fractionalChromaticNumber_seamPlane (type)"))
        p2 = copy.deepcopy(after)
        del p2[SEAM][NS + "iSup_fractionalChromaticNumber_seamPlane"]
        plants.append(("iSup head dropped", p2, f"MISSING {NS}iSup_fractionalChromaticNumber_seamPlane"))
        p3 = copy.deepcopy(after)
        p3[SEAM][NS + "numberField_seamField"]["kind"] = "AXIOM"
        plants.append(("numberField_seamField made an axiom", p3, f"CHANGED {NS}numberField_seamField (kind)"))
        for label, pa, want in plants:
            pf, _, _, _ = compare(before, pa)
            fired = pf == [want]
            print(f"plant [{label}]: {'FIRED' if fired else 'DID NOT FIRE'} -> {pf}")
            ok = ok and fired
    print("RESULT: " + ("CLEAN" if ok else "FAIL"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
