#!/usr/bin/env python3
"""FS131-IJ3 — the axioms of every declaration of the seven compiled modules this job writes, read from the output of
`data/fs131/ij3/lean/Axioms.lean` (run on the built tree). FS131-IJ2's reader (`tools/fs131_ij2_axioms.py`), rewritten for
these modules and this job's classes; that one is not edited.

Each record is classed:
- CLEAN: a subset of the standard three axioms.
- IMPORTED: the standard three and the declared printed theorem `positive_entropy_rigidity`, nothing else.
- OPEN-LEAF: `sorryAx` among them (with the standard three, and the declared theorem allowed), every `sorry` source one of
  the leaves this job leaves open (OPEN_LEAVES) or a constant of a module outside the seven.
Exit 0 only if: every record is one of the three; every name in MUST_CLEAN is CLEAN; every name in MUST_IMPORTED is
IMPORTED; every name in REQUIRED is present; and the planted record (`PLANT`) reads IMPORTED.
`--control`: plants four faults in memory (an unknown axiom into `archimedean_support`; `sorryAx` sourced in a proved leaf,
`exists_pattern_names_le`, into `ksEntropy_eq_zero_iff_of_finite`; the declared theorem into `bochnerOn_tauPrime`;
`sorryAx` with no source into `haar_or_zero_entropy`) and requires exactly those four reported.
Usage: fs131_ij3_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
DECLARED = NS + "positive_entropy_rigidity"
MINE = {MP + m for m in ("ContinuityGroup", "BochnerTau", "UnitCircle", "EntropySplitMax", "EntropyFibres",
                         "PositiveEntropy", "ChainAtTA")}
OPEN_LEAVES = {NS + n for n in ("exists_admissiblePair", "ZdAction.mulTwoThree_model", "entropySplit",
                                "zeroEntropyCarried", "noRamifiedStableDyadic_of_tca")}
MUST_CLEAN = {NS + n for n in (
    "archimedean_support", "bochnerOn_tauPrime", "exists_twisted_parts", "finite_quotient_nsmul", "archHom",
    "archTop_eq", "eventually_archTop", "norm_archHom_nsmul", "fivePow", "nsmul_fivePow", "inv_five_mem",
    "exists_nsmul_mem_of_mem_nhds_profTop", "contChars_tauPrime", "measurable_blockLabel", "blockEntropy_iterate",
    "ksEntropy_eq_zero_of_iterate", "ksEntropy_finite_mixture_eq_zero", "observationEntropy_comp_le",
    "exists_sectionPartition", "exists_pattern_names_le", "ksEntropy_eq_zero_iff_of_finite", "finFour_fibre_model",
    "ZdAction.two_le_of_not_isVirtuallyCyclic", "ZdAction.noVirtuallyCyclicFactors_of_isIrreducible",
    "ZdAction.coe_nsmul", "ZdAction.map_eq_of_isAddHaarMeasure", "ZdAction.eq_of_isErgodicOn_of_invariant_component",
    "ZdAction.invariantComponent_model", "finTwo_haar_model", "isAddHaarMeasure_of_add_invariant",
    "rotInv_sub_maxMultiple", "not_smul_dualHaar_le_dirac_one", "condExpKernel_ergodicDecomposition")}
MUST_IMPORTED = {NS + n for n in ("haar_or_zero_entropy",)}
REQUIRED = sorted(MUST_CLEAN | MUST_IMPORTED | OPEN_LEAVES | {NS + n for n in (
    "measure_haarSet_eq_zero", "ksEntropy_eq_zero_of_not_smul_le", "entropySplit_of_admissiblePair")})


def parse(path):
    recs, srcs = {}, {}
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", ln)
        if m:
            mod, kind, name, ax = m.groups()
            recs[(mod, name)] = {"kind": kind, "axioms": {a.strip() for a in ax.split(",") if a.strip()}}
            continue
        m = re.match(r"SORRY-FROM (\S+) : \[(.*)\]$", ln)
        if m:
            srcs[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
    return recs, srcs


def classify(name, ax, srcs, names_by_mod):
    extra = ax - STANDARD
    if not extra:
        return "CLEAN", ""
    if extra == {DECLARED}:
        return "IMPORTED", ""
    if "sorryAx" in extra and extra <= {"sorryAx", DECLARED}:
        s = srcs.get(name, set())
        if not s:
            return "BAD", "sorryAx with no source named"
        mine_proved = [c for c in s if c not in OPEN_LEAVES and any(c in names_by_mod[m] for m in MINE)]
        if mine_proved:
            return "BAD", f"sorry sourced in a declaration of this job's modules not left open: {sorted(mine_proved)}"
        return "OPEN-LEAF", f"sources {sorted(s)}"
    return "BAD", f"axioms {sorted(extra)}"


def main():
    control = "--control" in sys.argv
    path = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    recs, srcs = parse(path)
    if not recs:
        print("NO RECORDS — the printer or the reader is broken")
        return 2
    names_by_mod = {}
    for (mod, name) in recs:
        names_by_mod.setdefault(mod, set()).add(name)
    if control:
        recs[(MP + "BochnerTau", NS + "archimedean_support")]["axioms"].add("planted.unknownAxiom")
        recs[(MP + "EntropyFibres", NS + "ksEntropy_eq_zero_iff_of_finite")]["axioms"].add("sorryAx")
        srcs[NS + "ksEntropy_eq_zero_iff_of_finite"] = {NS + "exists_pattern_names_le"}
        recs[(MP + "BochnerTau", NS + "bochnerOn_tauPrime")]["axioms"].add(DECLARED)
        recs[(MP + "PositiveEntropy", NS + "haar_or_zero_entropy")]["axioms"].add("sorryAx")
        srcs.pop(NS + "haar_or_zero_entropy", None)
    present = {name for (_, name) in recs}
    missing = [n for n in REQUIRED if n not in present]
    if missing:
        print(f"MISSING RECORDS: {missing}")
        return 2
    bad, counts = [], {}
    plant_ok = False
    for (mod, name), r in sorted(recs.items()):
        cls, why = classify(name, r["axioms"], srcs, names_by_mod)
        if mod == "PLANT":
            plant_ok = cls == "IMPORTED"
            print(f"PLANT {name}: {cls} — {'reported resting on the declared theorem' if plant_ok else 'NOT REPORTED'}")
            continue
        counts[(mod, cls)] = counts.get((mod, cls), 0) + 1
        if cls == "BAD":
            bad.append(f"BAD {mod} {name}: {why}")
        elif name in MUST_CLEAN and cls != "CLEAN":
            bad.append(f"NOT CLEAN {name}: {cls} {why}")
        elif name in MUST_IMPORTED and cls != "IMPORTED":
            bad.append(f"NOT IMPORTED {name}: {cls} {why}")
        if cls != "CLEAN" and r["kind"] == "public":
            print(f"{cls:9s} {name} {why}")
    for (mod, cls), c in sorted(counts.items()):
        print(f"  {mod.replace(MP, '')}: {cls} {c}")
    print(f"records: {sum(counts.values())}")
    for b in bad:
        print(b)
    if not plant_ok:
        bad.append("PLANT not reported")
    if control:
        ok = len(bad) == 4
        print(f"CONTROL: {len(bad)} of 4 planted faults reported — {'the check can fail' if ok else 'DID NOT FIRE'}")
        return 0 if ok else 1
    print("PASS" if not bad else f"FAIL: {len(bad)}")
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
