#!/usr/bin/env python3
"""FS131-IJ1 — the axioms of every declaration of the compiled modules this job writes, read from the output of
`data/fs131/ij1/lean/Axioms.lean` (run on the built tree). (FS131-ITK1's reader, `tools/fs131_itk1_axioms.py`, aimed at
this job's seven modules; that one is not edited.)

Each record is classed; exit 0 only if every record passes its module's rule and the planted record is reported:
- CLEAN: a subset of the standard three axioms.
- OPEN-LEAF: the standard three and `sorryAx`, every `sorry` source a declaration that is a leaf this job leaves open —
  a constant of a module this job does not prove (`ChainAtTA`'s own leaves, `InvariantMeasure`, `BochnerTau`,
  `CountResidue`, `CountCompletion`, or any module outside the seven), never one of `ContinuityGroup` or `Herglotz`.
  Listed with its sources.
The rules: every record of PROVED (`ContinuityGroup`, `Herglotz`) must be CLEAN; so must the two lemmas `ChainAtTA` made
public and the heads named in MUST_CLEAN; every other record must be CLEAN or OPEN-LEAF. Any other axiom fails (the
declared printed theorem included). The planted record (`PLANT`) must read as resting on the declared theorem.
Every name in REQUIRED must be among the records (exit 2 otherwise).
`--control`: plants four faults in memory — `sorryAx` sourced in `ContinuityGroup` into `TA_subset_contChars`, an unknown
axiom into `exists_fejer_measures`, the declared printed theorem into `Counting.toLocal`, and `sorryAx` sourced in
`Herglotz` into `invariantMeasureOnClosed_of_countable` — and requires exactly those four reported.
Usage: fs131_ij1_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MINE = {MP + m for m in ("ChainAtTA", "ContinuityGroup", "Herglotz", "InvariantMeasure", "BochnerTau", "CountResidue",
                         "CountCompletion")}
PROVED = {MP + m for m in ("ContinuityGroup", "Herglotz")}
MUST_CLEAN = {NS + n for n in ("mem_torsion_mul_arch_iff", "exists_rat_coords", "contChars_tauPrime",
                               "bochnerHerglotz_of_countable", "TA_subset_contChars")}
REQUIRED = [NS + n for n in (
    "isTopologicalAddGroup_tauPrime", "isCountablyGenerated_nhds_tauPrime", "TA_subset_contChars",
    "mem_archChars_of_continuousAt", "archContinuousAt_pow_of_mem_contChars", "contChars_subset_TA",
    "contChars_tauPrime", "exists_almostInvariant_weights", "exists_fejer_measures", "exists_fourier_eq_of_tendsto",
    "bochnerHerglotz_of_countable", "mem_torsion_mul_arch_iff", "exists_rat_coords",
    "invariantMeasureOnClosed_of_countable", "bochnerOn_tauPrime", "Counting.toLocal",
    "Counting.ofUnitRing_mem_localRing")]


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
        plant("exists_fejer_measures", "HadwigerNelson.Rigidity.planted_axiom")
        plant("Counting.toLocal", DECLARED)
        plant("invariantMeasureOnClosed_of_countable", "sorryAx", [NS + "exists_fejer_measures"])
    bad, other, clean = [], [], 0
    for (mod, name), r in sorted(ours.items()):
        extra = r["axioms"] - STANDARD
        if not extra:
            clean += 1
            continue
        if extra == {"sorryAx"}:
            src = sources.get(name, [])
            proved_src = [s for s in src if modof.get(s, "") in PROVED]
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
