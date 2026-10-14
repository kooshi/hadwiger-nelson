#!/usr/bin/env python3
"""FS131-ITT1 — the axioms of every declaration of the compiled modules this job writes, read from the output of
`data/fs131/itt1/lean/Axioms.lean` (run on the built tree).

Each record of MINE (`Rigidity/RingScope`, `TateModel`, `TateLocal`, `TateArch`, `TateCharacter`) and of `ThinBoxes` is
classed; exit 0 only if every record has a class and the planted record is reported:
- CLEAN: a subset of the standard three axioms.
- OTHER-LEAF: the standard three and `sorryAx`, every `sorry` source a declaration that is not this job's to prove — a
  constant outside MINE, or `unitRing_eq_stableIntegers` (RingScope's leaf outside lane M9-R).  Listed with its sources.
Anything else fails: another axiom (the declared printed theorem included), or a `sorry` sourced in MINE but for
`unitRing_eq_stableIntegers`.  Every record of MINE but `unitRing_eq_stableIntegers` must be CLEAN (this job's leaves are
all proved).  The planted record (`PLANT`) must read as resting on the declared theorem; if it reads CLEAN, exit 1.
Every name in REQUIRED must be among the records (exit 2 otherwise).
`--control`: plants four faults in memory — `sorryAx` from `TateModel.isOpenMap` itself into its own record, an unknown
axiom into `archTrace_mixedEmbedding`, the declared printed theorem into `exists_isApprox`, and a `sorry` sourced in
`TateLocal` into `ThinBoxes`' `box` — and requires exactly those four reported.
Usage: fs131_itt1_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MINE = {MP + m for m in ("RingScope", "TateModel", "TateLocal", "TateArch", "TateCharacter")}
THIN = MP + "ThinBoxes"
OPEN_OK = NS + "unitRing_eq_stableIntegers"
REQUIRED = [NS + n for n in (
    "exists_mul_stableIntegers_le", "dense_mixedEmbedding_nsmul_unitRing", "unitRing_eq_stableIntegers",
    "TateModel.mul_mem_Λ", "TateModel.π_eq_π_iff", "TateModel.toSAdele_mem_torsionChars", "TateModel.isOpenMap",
    "TateModel.sigmaCompactSpace", "TateModel.mem_TA", "TateModel.ker_eq", "exists_valuation_le_one_away",
    "exists_approx_completion", "exists_int_trace_of_integral", "exists_trace_not_int_away",
    "exists_nat_mul_integral_of_trace_int", "compactSpace_adicCompletionIntegers", "archTrace_mixedEmbedding",
    "exists_eq_mixedEmbedding_of_archTrace_int", "archTrace_mixedEmbedding_one", "mem_stableIntegers_iff_valuation",
    "exists_isApprox", "exists_int_trace_sub_of_isApprox", "tateCharFun_eq", "tateCharFun_zero", "tateCharFun_add",
    "tateChar_of_integral", "tateChar_toSAdele_of_mem", "continuous_tateChar", "continuous_tatePi", "tatePi_unit_mul",
    "tatePi_toSAdele_of_mem", "tatePi_arch_mem", "box")]


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
        plant("TateModel.isOpenMap", "sorryAx", [NS + "TateModel.isOpenMap"])
        plant("archTrace_mixedEmbedding", "HadwigerNelson.Rigidity.planted_axiom")
        plant("exists_isApprox", DECLARED)
        plant("box", "sorryAx", [NS + "exists_trace_not_int_away"])
        modof[NS + "exists_trace_not_int_away"] = MP + "TateLocal"
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
    ok = not bad and plant_ok
    print("PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
