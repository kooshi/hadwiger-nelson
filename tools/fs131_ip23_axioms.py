#!/usr/bin/env python3
"""FS131-IP23 — the axioms of every declaration of the compiled `Rigidity/Entropy` and `Rigidity/EntropySplitMax` (the
two files whose leaves this job proves), read from the output of `data/fs131/ip23/lean/Axioms.lean` (run on the built
tree).

Each record is classed (exit 0 only if every record has a class, and the planted record is reported):
- CLEAN: a subset of the standard three axioms.
- OTHER-LEAF: the standard three and `sorryAx`, the `sorry` reached only through named leaves that are not this job's
  (ALLOWED: the five leaves of `Rigidity/EntropySplitMax` this job does not prove) — SORRY-FROM nonempty and inside
  ALLOWED.  Listed by name with where the `sorry` comes from.
Anything else fails: another axiom (the declared printed theorem included: neither file applies it), a `sorry` from
anywhere else, and any `sorry` at all in a record of MUST_CLEAN (the two leaves this job proves, and every record of
`Rigidity/Entropy`, which holds no leaf now).
The planted record (`PLANT`: `positive_entropy_rigidity_of_polishSpace`, which rests on the declared theorem) must be
read as resting on it; if it reads CLEAN the reader cannot see an axiom, and the run exits 1.
Every name in REQUIRED must be among the records (a reader that lost them is broken: exit 2).

`--control`: plants four faults in memory after reading — `sorryAx` in the tenth leaf `ksEntropy_eq_iSup_ksEntropyOn`
(with its source in `Entropy` itself), an unknown axiom in `invariantSigma_le`, a `sorry` from a leaf outside ALLOWED in
`measure_haarSet_eq_zero` (`exists_admissiblePair`), and the declared printed theorem in the first leaf
`condExpKernel_ergodicDecomposition` — and requires exactly those four to be reported (exit 0 when they are).

Usage: fs131_ip23_axioms.py <axioms.txt> [--control]
(FS131-IG1's reader, `tools/fs131_ig1_axioms.py`, aimed at these two modules; that one is not edited.)
"""
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
ENTROPY = "Proofs.HadwigerNelson.Rigidity.Entropy"
SPLIT = "Proofs.HadwigerNelson.Rigidity.EntropySplitMax"
LEAVES = [NS + "ksEntropy_eq_iSup_ksEntropyOn", NS + "condExpKernel_ergodicDecomposition"]
ALLOWED = {NS + n for n in ("rotInv_sub_maxMultiple", "measure_haarSet_eq_zero", "ksEntropy_eq_zero_of_not_smul_le",
                            "entropySplit_of_admissiblePair", "not_smul_dualHaar_le_dirac_one")}
REQUIRED = LEAVES + sorted(ALLOWED) + [NS + n for n in (
    "nameCell", "blockEntropy", "partitionEntropy", "ksEntropyOn", "ksEntropy", "ksEntropy_eq_measureEntropy",
    "ksEntropy_bind_eq_zero", "invariantSigma", "invariantSigma_le", "haarSet")]


def parse_list(s):
    s = s.strip()
    assert s.startswith("[") and s.endswith("]"), s
    body = s[1:-1].strip()
    return set() if not body else {x.strip() for x in body.split(",")}


def main():
    control = "--control" in sys.argv
    path = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    rows, sorry_from, count = {}, {}, None
    for ln in open(path).read().splitlines():
        if ln.startswith("AXIOMS-COUNT "):
            count = int(ln.split()[1])
        elif ln.startswith("AXIOMS "):
            head, axs = ln.split(" : ", 1)
            _, mod, kind, name = head.split(" ")
            rows[name] = (mod, kind, parse_list(axs))
        elif ln.startswith("SORRY-FROM "):
            head, src = ln.split(" : ", 1)
            sorry_from[head.split(" ")[1]] = parse_list(src)
    if count is None or not rows:
        print("BROKEN: no AXIOMS-COUNT line, or no records — the printer did not run")
        sys.exit(2)
    for n in REQUIRED:
        if n not in rows:
            print(f"BROKEN: {n} is not among the records")
            sys.exit(2)
    must_clean = set(LEAVES) | {n for n, (mod, _, _) in rows.items() if mod == ENTROPY}
    mine = {n for n, (mod, _, _) in rows.items() if mod != "PLANT"}
    if control:
        v = LEAVES[0]
        m, k, a = rows[v]
        rows[v] = (m, k, a | {"sorryAx"})
        sorry_from[v] = {v}
        v = NS + "invariantSigma_le"
        m, k, a = rows[v]
        rows[v] = (m, k, a | {"planted.unknownAxiom"})
        v = NS + "measure_haarSet_eq_zero"
        m, k, a = rows[v]
        sorry_from[v] = sorry_from.get(v, set()) | {NS + "exists_admissiblePair"}
        v = LEAVES[1]
        m, k, a = rows[v]
        rows[v] = (m, k, a | {DECLARED})
    bad, plant_fired = [], False
    classes = {"CLEAN": [], "OTHER-LEAF": []}
    for name, (mod, kind, axs) in sorted(rows.items()):
        extra = axs - STANDARD - {"sorryAx"}
        src = sorry_from.get(name, set())
        if mod == "PLANT":
            if DECLARED in axs:
                plant_fired = True
                print(f"PLANT reported: {name} rests on {sorted(axs - STANDARD)}")
            else:
                print(f"PLANT NOT READ: {name}: {sorted(axs)}")
            continue
        if extra:
            bad.append(f"AXIOMS   {mod} {kind} {name}: {sorted(axs)} — beyond the standard three and `sorryAx`")
        elif "sorryAx" in axs and name in must_clean:
            bad.append(f"SORRY    {mod} {kind} {name}: a record that must be clean rests on `sorryAx` (from {sorted(src)})")
        elif "sorryAx" in axs and not (src and src <= ALLOWED):
            bad.append(f"SORRY    {mod} {kind} {name}: `sorryAx` from {sorted(src)}, outside the named leaves")
        elif "sorryAx" in axs:
            classes["OTHER-LEAF"].append((mod, name, kind, axs, src))
        else:
            classes["CLEAN"].append((mod, name, kind, axs, src))
    print(f"records of the two modules: {len(mine)} (AXIOMS-COUNT {count}): CLEAN {len(classes['CLEAN'])}, "
          f"OTHER-LEAF {len(classes['OTHER-LEAF'])}, failing {len(bad)}")
    for mod in (ENTROPY, SPLIT):
        print(f"  {mod}: {sum(1 for r in mine if rows[r][0] == mod)} records")
    for mod, name, kind, axs, src in classes["CLEAN"]:
        print(f"  CLEAN {kind} {name}: {sorted(axs)}")
    for mod, name, kind, axs, src in classes["OTHER-LEAF"]:
        print(f"  OTHER-LEAF {kind} {name}: {sorted(axs)}; sorry from {sorted(src)}")
    for x in bad:
        print(x)
    if control:
        want = 4
        ok = len(bad) == want and plant_fired
        print(f"CONTROL: {len(bad)} of {want} planted faults reported, plant {'fired' if plant_fired else 'SILENT'} — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    if not plant_fired:
        print("CONTROL: THE PLANTED RECORD WAS NOT REPORTED — the reader cannot see the declared axiom")
        sys.exit(1)
    if len(mine) != count:
        print(f"COUNT MISMATCH: {len(mine)} records read, AXIOMS-COUNT {count}")
        sys.exit(1)
    print("AXIOMS OK" if not bad else f"AXIOMS FAILED: {len(bad)}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
