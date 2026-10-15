#!/usr/bin/env python3
"""FS131-ILA1 — the axioms of every declaration of the compiled modules this job writes (`Rigidity/AdmissiblePrime`,
`Rigidity/UnitCircle`), read from the output of `data/fs131/ila1/lean/Axioms.lean` (run on the built tree).
(FS131-IM11's reader, `tools/fs131_im11_axioms.py`, aimed at this job's two modules; that one is not edited.)

Exit 0 only if every record is CLEAN (a subset of the standard three axioms) — `exists_admissiblePair` among them — and
the planted record (`PLANT`, a leaf of `Rigidity/EntropySplitMax` that rests on `sorry` in this tree) is reported as resting on `sorryAx`.
Every name in REQUIRED must be among the records (exit 2 otherwise).
`--control`: plants four faults in memory — `sorryAx` into `exists_admissiblePair`, an unknown axiom into
`exists_unitPair`, a native purchase into a private helper of `AdmissiblePrime`, `sorryAx` into `AdmissiblePair.ofPow` —
and requires exactly those four reported.
Usage: fs131_ila1_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MINE = {MP + m for m in ("AdmissiblePrime", "UnitCircle")}
REQUIRED = [NS + n for n in (
    "exists_admissiblePair", "exists_unitPair", "exists_residueHom_unramified", "AdmissiblePair.ofPow", "zpowHom",
    "unitCircleEquiv", "schur_prime", "adjoin_pow_eq_top")]


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
    if control:
        def plant(name, ax):
            k = next(k for k in ours if k[1] == NS + name)
            ours[k] = dict(ours[k], axioms=set(ours[k]["axioms"]) | {ax})
        plant("exists_admissiblePair", "sorryAx")
        plant("exists_unitPair", "HadwigerNelson.Rigidity.planted_axiom")
        plant("schur_prime", "HadwigerNelson.Rigidity.schur_prime._native.native_decide.ax_1_1")
        plant("AdmissiblePair.ofPow", "sorryAx")
    bad, clean = [], 0
    for (mod, name), r in sorted(ours.items()):
        extra = r["axioms"] - STANDARD
        if not extra:
            clean += 1
            continue
        bad.append(f"NOT-CLEAN {mod.split('.')[-1]} {r['kind']} {name}: {sorted(extra)}"
                   + (f" (sorry from {sources.get(name)})" if "sorryAx" in extra else ""))
    plant_rec = recs.get(("PLANT", NS + "rotInv_sub_maxMultiple"))
    plant_ok = plant_rec is not None and "sorryAx" in plant_rec["axioms"]
    print(f"records: {len(ours)} (printer count {count}); CLEAN {clean}")
    for mod in sorted(MINE):
        rows = sorted((k[1], v) for k, v in ours.items() if k[0] == mod)
        print(f"  {mod.split('.')[-1]}: {len(rows)} records, "
              f"{sum(1 for _, v in rows if not (v['axioms'] - STANDARD))} CLEAN")
        for n, v in rows:
            print(f"    {v['kind']:7} {n} : {sorted(v['axioms'])}")
    print(f"planted record: {'reported, resting on sorryAx' if plant_ok else 'NOT REPORTED'}")
    for b in bad:
        print(b)
    if control:
        ok = len(bad) == 4 and plant_ok
        print(f"CONTROL: {len(bad)} of 4 planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    if not plant_ok:
        print("FAIL: the planted record was not reported — the printer cannot see a `sorry`")
        sys.exit(1)
    print("PASS: every record CLEAN" if not bad else f"FAIL: {len(bad)} record(s) not clean")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
