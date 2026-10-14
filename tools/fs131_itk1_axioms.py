#!/usr/bin/env python3
"""FS131-ITK1 — the axioms of every declaration of the compiled modules this job writes, read from the output of
`data/fs131/itk1/lean/Axioms.lean` (run on the built tree). (FS131-ITT1's reader, `tools/fs131_itt1_axioms.py`, aimed at
this job's six modules, with no leaf allowed open; that one is not edited.)

Each record of MINE (`Rigidity/TateKernel`, `PlaceSizes`, `Multipliers`, `ThinBoxes`, `GlobalPoint`, `WanderingShells`)
is classed; exit 0 only if every record is CLEAN and the planted record is reported:
- CLEAN: a subset of the standard three axioms.
- OTHER-LEAF: the standard three and `sorryAx`, every `sorry` source a declaration that is not this job's to prove — a
  constant outside MINE, or `unitRing_eq_stableIntegers` (RingScope's leaf outside lane M9-R).  Listed with its sources.
Anything else fails: another axiom (the declared printed theorem included), or a `sorry` sourced in MINE but for
`unitRing_eq_stableIntegers`.  Every record of MINE but `unitRing_eq_stableIntegers` must be CLEAN (this job's leaves are
all proved).  The planted record (`PLANT`) must read as resting on the declared theorem; if it reads CLEAN, exit 1.
Every name in REQUIRED must be among the records (exit 2 otherwise).
`--control`: plants four faults in memory — `sorryAx` from `surjective_tatePi` itself into its own record, an unknown
axiom into `multiplier_injective`, the declared printed theorem into `Collision.point_eq`, and a `sorry` sourced in
`PlaceSizes` (`exists_one_lt_absAt`) into `TateModel.measure_shell_eq_zero` — and requires exactly those four reported.
A record resting on `sorryAx` from outside these modules (OTHER-LEAF) also fails: every leaf of this job is proved.
Usage: fs131_itk1_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MINE = {MP + m for m in ("TateKernel", "PlaceSizes", "Multipliers", "ThinBoxes", "GlobalPoint", "WanderingShells")}
THIN = "(none)"
OPEN_OK = "(none)"
REQUIRED = [NS + n for n in (
    "exists_eq_mixedEmbedding_of_mem_oAnn", "eq_zero_of_mem_oAnn", "exists_nat_forall_mem_oAnn", "tatePi_ker_subset",
    "tatePi_exists_nat_mul_mem", "tatePi_exists_isCompact", "tatePi_eq_one_forall_imp", "surjective_tatePi", "oAnn",
    "WPlace.size_toSAdele", "one_le_prod_absAt_of_mem_stableIntegers", "TateModel.exists_isGap", "exists_one_lt_absAt",
    "exists_unitVector_absAt_lt_one", "countable_splitPlace", "multiplier", "multiplier_injective",
    "absAt_multiplier_arch", "splitHeight_multiplier_le", "TateModel.exists_box_partition",
    "TateModel.exists_orbit_box", "TateModel.thinBox_heavy", "exists_eps_lt", "Collision.point_eq",
    "Collision.size_sub_point_le", "TateModel.exists_collision", "TateModel.exists_point_of_heavy",
    "TateModel.measure_leafSet_compl_eq_zero", "TateModel.measure_shell_eq_zero", "TateModel.measure_compl_TA_eq_zero",
    "zeroEntropyCarried_of_tateModel")]


def parse(path):
    recs, sources, count = {}, {}, None
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", ln)
        if m:
            mod, kind, name, ax = m.groups()
            recs[(mod, name)] = {"kind": kind, "axioms": {a.strip() for a in ax.split(",") if a.strip()}}
            continue
        m = re.match(r"SORRY-FROM (\S+) : \[(.*)\]$", ln)
        if m:
            sources[m.group(1)] = [a.strip() for a in m.group(2).split(",") if a.strip()]
            continue
        m = re.match(r"AXIOMS-COUNT (\d+)$", ln)
        if m:
            count = int(m.group(1))
    return recs, sources, count


def main():
    control = "--control" in sys.argv
    recs, sources, count = parse(sys.argv[1])
    ours = {k: v for k, v in recs.items() if k[0] in MINE or k[0] == THIN}
    if count is None or not ours:
        print("BROKEN: no records or no count — the printer or the reader is broken"); sys.exit(2)
    names = {k[1] for k in ours}
    for n in REQUIRED:
        if n not in names:
            print(f"BROKEN: {n} is not among the records"); sys.exit(2)
    modof = {k[1]: k[0] for k in recs}
    if control:
        def plant(name, ax, src=None):
            k = next(k for k in ours if k[1] == NS + name)
            ours[k] = dict(ours[k], axioms=set(ours[k]["axioms"]) | {ax})
            if src is not None:
                sources[NS + name] = src
        plant("surjective_tatePi", "sorryAx", [NS + "surjective_tatePi"])
        plant("multiplier_injective", "HadwigerNelson.Rigidity.planted_axiom")
        plant("Collision.point_eq", DECLARED)
        plant("TateModel.measure_shell_eq_zero", "sorryAx", [NS + "exists_one_lt_absAt"])
    bad, other, clean = [], [], 0
    for (mod, name), r in sorted(ours.items()):
        ax = r["axioms"]
        extra = ax - STANDARD
        if not extra:
            clean += 1
            continue
        if extra == {"sorryAx"}:
            src = sources.get(name, [])
            mine_src = [s for s in src if modof.get(s, "") in MINE and s != OPEN_OK]
            if not src:
                bad.append(f"SORRY-UNSOURCED {name}")
            elif mine_src:
                bad.append(f"SORRY-MINE {name}: from {mine_src}")
            elif mod in MINE and name != OPEN_OK and not all(s == OPEN_OK for s in src):
                bad.append(f"NOT-CLEAN {name}: a record of this job's files rests on {src}")
            else:
                other.append(f"OTHER-LEAF {mod.split('.')[-1]} {name}: from {src}")
            continue
        bad.append(f"AXIOM {name}: {sorted(extra)}")
    plant_rec = recs.get(("PLANT", NS + "positive_entropy_rigidity_of_polishSpace"))
    plant_ok = plant_rec is not None and DECLARED in plant_rec["axioms"]
    print(f"records: {len(ours)} (printer count {count}); CLEAN {clean}; OTHER-LEAF {len(other)}")
    for o in other:
        print("  " + o)
    print(f"planted record: {'reported, resting on ' + DECLARED if plant_ok else 'NOT REPORTED'}")
    for b in bad:
        print(b)
    if control:
        ok = len(bad) == 4 and plant_ok
        print(f"CONTROL: {len(bad)} of 4 planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    ok = not bad and plant_ok and not other
    print("PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
