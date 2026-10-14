#!/usr/bin/env python3
"""FS131-IJ2 — the axioms of every declaration of the compiled modules this job writes, read from the output of
`data/fs131/ij2/lean/Axioms.lean` (run on the built tree). (FS131-IJ1's reader, `tools/fs131_ij1_axioms.py`, aimed at
this job's three modules; that one is not edited.)

Each record is classed; exit 0 only if every record passes its module's rule and the planted record is reported:
- CLEAN: a subset of the standard three axioms.
- OPEN-LEAF: the standard three and `sorryAx`, every `sorry` source a declaration that is a leaf this job leaves open —
  `BochnerTau`'s `archimedean_support`, or a constant of a module outside the three — never one of `ContinuityGroup`
  or `InvariantMeasure`, nor a proved leaf of `BochnerTau`.
The rules: every record of PROVED (`ContinuityGroup`, `InvariantMeasure`) must be CLEAN; so must the heads named in
MUST_CLEAN; every other record must be CLEAN or OPEN-LEAF. Any other axiom fails (the declared printed theorem
included). The planted record (`PLANT`) must read as resting on the declared theorem. Every name in REQUIRED must be
among the records (exit 2 otherwise).
`--control`: plants four faults in memory — `sorryAx` sourced in `ContinuityGroup` into `TA_subset_contChars`, an unknown
axiom into `exists_shiftInvariant_on`, the declared printed theorem into `exists_twisted_parts`, and `sorryAx` sourced in
`InvariantMeasure` into `bochnerOn_tauPrime` — and requires exactly those four reported.
Usage: fs131_ij2_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MINE = {MP + m for m in ("ContinuityGroup", "InvariantMeasure", "BochnerTau")}
PROVED = {MP + m for m in ("ContinuityGroup", "InvariantMeasure")}
MUST_CLEAN = {NS + n for n in ("contChars_tauPrime", "TA_subset_contChars", "invariantMeasureOnClosed_of_countable",
                               "exists_shiftInvariant_on", "exists_rotInvariant_of_shiftInvariant",
                               "finite_quotient_nsmul", "exists_twisted_parts")}
OPEN_LEAVES = {NS + "archimedean_support"}
REQUIRED = [NS + n for n in (
    "isTopologicalAddGroup_tauPrime", "isCountablyGenerated_nhds_tauPrime", "TA_subset_contChars",
    "mem_archChars_of_continuousAt", "archContinuousAt_pow_of_mem_contChars", "contChars_subset_TA",
    "contChars_tauPrime", "exists_shiftInvariant_on", "exists_rotInvariant_of_shiftInvariant",
    "invariantMeasureOnClosed_of_countable", "finite_quotient_nsmul", "archimedean_support", "exists_twisted_parts",
    "bochnerOn_tauPrime")]


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
    ours = {k: v for k, v in recs.items() if k[0] in MINE}
    if count is None or not ours or count != len(ours):
        print(f"BROKEN: records {len(ours)}, printer count {count} — the printer or the reader is broken")
        sys.exit(2)
    names = {k[1] for k in ours}
    for n in REQUIRED:
        if n not in names:
            print(f"BROKEN: {n} is not among the records")
            sys.exit(2)
    modof = {k[1]: k[0] for k in recs}
    if control:
        def plant(name, ax, src=None):
            k = next(k for k in ours if k[1] == NS + name)
            ours[k] = dict(ours[k], axioms=set(ours[k]["axioms"]) | {ax})
            if src is not None:
                sources[NS + name] = src
        plant("TA_subset_contChars", "sorryAx", [NS + "mem_archChars_of_continuousAt"])
        plant("exists_shiftInvariant_on", "HadwigerNelson.Rigidity.planted_axiom")
        plant("exists_twisted_parts", DECLARED)
        plant("bochnerOn_tauPrime", "sorryAx", [NS + "exists_shiftInvariant_on"])
    bad, other, clean = [], [], 0
    for (mod, name), r in sorted(ours.items()):
        extra = r["axioms"] - STANDARD
        if not extra:
            clean += 1
            continue
        if extra == {"sorryAx"}:
            src = sources.get(name, [])
            proved_src = [s for s in src if modof.get(s, "") in PROVED or
                          (modof.get(s, "") in MINE and s not in OPEN_LEAVES)]
            if not src:
                bad.append(f"SORRY-UNSOURCED {name}")
            elif proved_src:
                bad.append(f"SORRY-PROVED {name}: from {proved_src}, in a module this job proved")
            elif mod in PROVED or name in MUST_CLEAN:
                bad.append(f"NOT-CLEAN {name}: rests on {src}")
            else:
                other.append(f"OPEN-LEAF {mod.split('.')[-1]} {name}: from {src}")
            continue
        bad.append(f"AXIOM {name}: {sorted(extra)}")
    plant_rec = recs.get(("PLANT", NS + "positive_entropy_rigidity_of_polishSpace"))
    plant_ok = plant_rec is not None and DECLARED in plant_rec["axioms"]
    info = recs.get(("INFO", NS + "AdmissiblePair.ofPow"))
    print(f"records: {len(ours)} (printer count {count}); CLEAN {clean}; OPEN-LEAF {len(other)}")
    for mod in sorted(MINE):
        n_mod = sum(1 for k in ours if k[0] == mod)
        c_mod = sum(1 for k, v in ours.items() if k[0] == mod and not (v["axioms"] - STANDARD))
        print(f"  {mod.split('.')[-1]}: {n_mod} records, {c_mod} CLEAN")
    for o in other:
        print("  " + o)
    print(f"planted record: {'reported, resting on ' + DECLARED if plant_ok else 'NOT REPORTED'}")
    print(f"info: AdmissiblePair.ofPow {sorted(info['axioms']) if info else 'MISSING'}")
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
