#!/usr/bin/env python3
"""FS131-IRU2 — every record's axioms on the merged build, against each line's gated print. A copy of FS131-IFR2's
`tools/fs131_ifr2_axioms_diff.py`: the sides, the ruled set and the plants replaced; the comparison unchanged.

Reads three prints of FS131-ICO2's axioms printer (lines `AXIOMS <module> <public|private> <user name> : [<axioms>]`;
`SORRY-FROM` / `SORRY-LEAF` lines when a record holds `sorryAx`; `AXIOMS-COUNT <n>`):
  IRU1   — FS131-IRU1's print of its six modules on its gated build 3 (`data/fs131/iru1/axioms-all.txt`);
  MAIN   — FS131-IFR2's print of ten modules on `main`'s gated build (`data/fs131/ifr2/axioms-all.txt`);
  MERGED — the print of the union, sixteen modules, on the merged build (`data/fs131/iru2/lean/AxiomsAll.lean`).
Records are keyed by (module, user name): a ruled publicization changes the visibility, not the user name, and the
visibility is compared only as information (a record whose visibility differs from a side's is listed VISIBILITY, and
must be one of RULED_PUBLIC, public in MERGED; idle here, the two sides' modules being disjoint).

  SAME     every record of each side is in MERGED with the same axiom set;
  CHANGED  the axiom set differs                                   -> FAIL;
  MISSING  absent from MERGED                                      -> FAIL;
  ADDED    a MERGED record of a module some side covers that no side holds -> FAIL (a merge adds no declaration);
  SORRY    any `sorryAx` in MERGED                                 -> FAIL.
--plant: four more runs on MERGED changed in memory — one record of `Rigidity/UnitRingEq` gains
`Rigidity.positive_entropy_rigidity`, one record of `Rigidity/UsablePrime` dropped, one record added to
`Instances/UnitRingModels`, one record of `Collapse/Density/Headline` gains `sorryAx` — each must be reported by name.
Usage: fs131_iru2_axioms_diff.py IRU1 MAIN MERGED [--plant]   exit 0 iff clean (and, with --plant, every plant fired)
"""
import copy
import re
import sys

RULED_PUBLIC = {"HadwigerNelson.Rigidity.exists_integral_primitive", "HadwigerNelson.Rigidity.exists_dvd_of_dvd_exponent",
                "HadwigerNelson.Rigidity.nonempty_residueHom"}
LINE = re.compile(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$")


def read(path):
    recs = {}
    for ln in open(path, encoding="utf-8"):
        m = LINE.match(ln.rstrip("\n"))
        if m and m.group(1) != "PLANT":
            recs[(m.group(1), m.group(3))] = (m.group(2), frozenset(a.strip() for a in m.group(4).split(",") if a.strip()))
    return recs


def compare(sides, merged, quiet=False):
    fails, info = [], []
    mods = {k[0] for s in sides.values() for k in s}
    for sname, recs in sides.items():
        for key, (vis, ax) in recs.items():
            got = merged.get(key)
            if got is None:
                fails.append(f"MISSING {key[0]} {key[1]} (vs {sname})")
                continue
            if got[1] != ax:
                fails.append(f"CHANGED {key[0]} {key[1]} (vs {sname}): {sorted(ax)} -> {sorted(got[1])}")
            if got[0] != vis:
                if key[1] in RULED_PUBLIC and got[0] == "public":
                    info.append(f"VISIBILITY {key[0]} {key[1]}: {vis} in {sname}, public in MERGED (ruled)")
                else:
                    fails.append(f"VISIBILITY {key[0]} {key[1]}: {vis} in {sname}, {got[0]} in MERGED (not ruled)")
    for key, (vis, ax) in merged.items():
        if "sorryAx" in ax:
            fails.append(f"SORRY {key[0]} {key[1]}")
        if key[0] in mods and not any(key in s for s in sides.values()):
            fails.append(f"ADDED {key[0]} {key[1]} ({vis}): a merge adds no declaration")
    if not quiet:
        by = {}
        for key, (vis, ax) in merged.items():
            by.setdefault((key[0], vis), 0)
            by[(key[0], vis)] += 1
        for (m, vis), n in sorted(by.items()):
            print(f"MODULE {m} {vis}: {n} records")
        for i in info:
            print(i)
        print(f"RECORDS merged={len(merged)} IRU1={len(sides['IRU1'])} MAIN={len(sides['MAIN'])}")
        for f in fails:
            print("FAIL", f)
        print(f"VERDICT {'CLEAN' if not fails else 'FAILED'}: {len(fails)} failure(s)")
    return fails


def main():
    args = [a for a in sys.argv[1:] if a != "--plant"]
    sides = {"IRU1": read(args[0]), "MAIN": read(args[1])}
    merged = read(args[2])
    fails = compare(sides, merged)
    if "--plant" not in sys.argv:
        sys.exit(1 if fails else 0)
    keys = sorted(merged)
    k1 = next(k for k in keys if k[0].endswith("Rigidity.UnitRingEq") and merged[k][0] == "public")
    k2 = next(k for k in keys if k[0].endswith("Rigidity.UsablePrime"))
    k4 = next(k for k in keys if k[0].endswith("Density.Headline"))
    p = []
    m = copy.deepcopy(merged); m[k1] = (m[k1][0], m[k1][1] | {"HadwigerNelson.Rigidity.positive_entropy_rigidity_PLANT"})
    p.append(("axiom set changed", m, f"CHANGED {k1[0]} {k1[1]}"))
    m = copy.deepcopy(merged); del m[k2]
    p.append(("record dropped", m, f"MISSING {k2[0]} {k2[1]}"))
    k3 = next(k for k in keys if k[0].endswith("UnitRingModels"))
    m = copy.deepcopy(merged); m[(k3[0], "HadwigerNelson.UnitRingModels.planted_extra")] = merged[k3]
    p.append(("record added", m, f"ADDED {k3[0]} HadwigerNelson.UnitRingModels.planted_extra"))
    m = copy.deepcopy(merged); m[k4] = (m[k4][0], m[k4][1] | {"sorryAx"})
    p.append(("sorryAx planted", m, f"SORRY {k4[0]} {k4[1]}"))
    ok = True
    for label, mm, want in p:
        fl = compare(sides, mm, quiet=True)
        hit = [f for f in fl if f.startswith(want)]
        print(f"PLANT {label}: {'FIRED' if hit else 'NOT FIRED'} ({len(fl)} failure(s); wanted {want!r})")
        ok = ok and bool(hit)
    print("PLANTS", "ALL FIRED" if ok else "NOT ALL FIRED")
    sys.exit(0 if ok and not fails else 1)


main()
