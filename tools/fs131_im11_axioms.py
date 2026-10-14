#!/usr/bin/env python3
"""FS131-IM11 — the axioms of every declaration of the compiled modules this job writes, read from the output of
`data/fs131/im11/lean/Axioms.lean` (run on the built tree). (FS131-IJ1's reader, `tools/fs131_ij1_axioms.py`, aimed at
this job's four modules; that one is not edited.)

Each record is classed; exit 0 only if every record passes its module's rule and the planted record is reported:
- CLEAN: a subset of the standard three axioms.
- OPEN-LEAF: the standard three and `sorryAx`, every `sorry` source a declaration of a module this job does not write
  (M2b's `Rigidity/BochnerTau`, M3's `Rigidity/InvariantMeasure`, or any module outside the four), never one of the four.
  Listed with its sources.
The rules: every record of `SpectralSubspace` and `ContinuityGroup` must be CLEAN, and so must every head in MUST_CLEAN
(the leaves of `TraceSplit` and `APlus` whose proofs read neither M2b nor M3); every other record must be CLEAN or
OPEN-LEAF. Any other axiom fails (the declared printed theorem included). The planted record (`PLANT`) must read as
resting on the declared theorem. Every name in REQUIRED must be among the records (exit 2 otherwise).
`--control`: plants four faults in memory — `sorryAx` sourced in `SpectralSubspace` into `setIntegral_compl_TA_re`, an
unknown axiom into `gram_sum_eq`, the declared printed theorem into `aPlusOfR88`, and `sorryAx` sourced outside into
`trace_decomp` (a MUST_CLEAN head) — and requires exactly those four reported.
Usage: fs131_im11_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MINE = {MP + m for m in ("SpectralSubspace", "TraceSplit", "APlus", "ContinuityGroup")}
ALL_CLEAN = {MP + m for m in ("SpectralSubspace", "ContinuityGroup")}
MUST_CLEAN = {NS + n for n in (
    "integral_colourInd_mul_comp", "trace_decomp", "condLaw_comp_colourShift", "inner_colourInd_comp_unit",
    "colourCond_ae_eq_condLaw", "integral_colourCond_mul_comp", "setIntegral_compl_TA_rot", "tendsto_mul_nhds_tauPrime",
    "comap_colourRot_colourFactor", "factorColouring_shift_ae", "factorColouring_rot_ae",
    "integral_condLaw_mul_eq_zero_of_adj", "factorColouring_mem_X4", "factorLaw_carried", "factorLaw_shift_inv",
    "factorLaw_rot_inv", "numberField_bot", "archHom", "mem_nhds_profTop")}
REQUIRED = [NS + n for n in (
    "gram_sum_eq", "posDef_koopman", "comp_mem_contVec", "inner_comp_eq_inner_comp_neg",
    "IsSpectralMeasureOf.add_of_orthogonal", "exists_trigPoly_tendsto", "norm_sq_koopmanSum_re_add_im",
    "inner_koopmanSum_re", "comp_koopmanSum", "exists_spectral_vector", "spectral_null_of_orthogonal",
    "isSpectralMeasureOf_condExpL2", "spectral_null_model", "integral_colourInd_mul_comp", "trace_decomp",
    "condLaw_comp_colourShift", "inner_colourInd_comp_unit", "colourCond_ae_eq_condLaw", "integral_colourCond_mul_comp",
    "setIntegral_compl_TA_re", "setIntegral_compl_TA_rot", "tendsto_mul_nhds_tauPrime", "comap_colourRot_colourFactor",
    "factorColouring_shift_ae", "factorColouring_rot_ae", "integral_condLaw_mul_eq_zero_of_adj", "factorColouring_mem_X4",
    "factorLaw_carried", "factorLaw_shift_inv", "factorLaw_rot_inv", "factorLaw_trace_null", "equalAtUnits_of_not_neg",
    "numberField_bot", "aPlusOfR88", "aplus_model", "contChars_tauPrime", "archHom", "mem_nhds_profTop")]


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
        plant("setIntegral_compl_TA_re", "sorryAx", [NS + "exists_spectral_vector"])
        plant("gram_sum_eq", "HadwigerNelson.Rigidity.planted_axiom")
        plant("aPlusOfR88", DECLARED)
        plant("trace_decomp", "sorryAx", [NS + "bochnerOn_tauPrime"])
    bad, other, clean = [], [], 0
    for (mod, name), r in sorted(ours.items()):
        extra = r["axioms"] - STANDARD
        if not extra:
            clean += 1
            continue
        if extra == {"sorryAx"}:
            src = sources.get(name, [])
            mine_src = [s for s in src if modof.get(s, "") in MINE]
            if not src:
                bad.append(f"SORRY-UNSOURCED {name}")
            elif mine_src:
                bad.append(f"SORRY-MINE {name}: from {mine_src}, in a module this job writes")
            elif mod in ALL_CLEAN or name in MUST_CLEAN:
                bad.append(f"NOT-CLEAN {name}: rests on {src}")
            else:
                other.append(f"OPEN-LEAF {mod.split('.')[-1]} {name}: from {src}")
            continue
        bad.append(f"AXIOM {name}: {sorted(extra)}")
    plant_rec = recs.get(("PLANT", NS + "positive_entropy_rigidity_of_polishSpace"))
    plant_ok = plant_rec is not None and DECLARED in plant_rec["axioms"]
    print(f"records: {len(ours)} (printer count {count}); CLEAN {clean}; OPEN-LEAF {len(other)}")
    for mod in sorted(MINE):
        n_mod = sum(1 for k in ours if k[0] == mod)
        c_mod = sum(1 for k, v in ours.items() if k[0] == mod and not (v["axioms"] - STANDARD))
        print(f"  {mod.split('.')[-1]}: {n_mod} records, {c_mod} CLEAN")
    for o in other:
        print("  " + o)
    print(f"planted record: {'reported, resting on ' + DECLARED if plant_ok else 'NOT REPORTED'}")
    for n in ("bochnerOn_tauPrime", "invariantMeasureOnClosed_of_countable"):
        info = recs.get(("INFO", NS + n))
        print(f"info: {n} {sorted(info['axioms']) if info else 'MISSING'}"
              + (f", sorry from {sources.get(NS + n, [])}" if info and "sorryAx" in info["axioms"] else ""))
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
