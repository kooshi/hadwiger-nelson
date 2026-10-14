#!/usr/bin/env python3
"""FS131-IG1 — the axioms of every declaration of the compiled `Rigidity/Pieces`, read from the output of
`data/fs131/ig1/lean/Axioms.lean` (run on the built tree).

Each record is classed (exit 0 only if every record has a class, and the planted record is reported):
- CLEAN: a subset of the standard three axioms.
- THROUGH: the standard three and `sorryAx`, the `sorry` reached only through the named leaves of other modules that this
  job uses as stated (ALLOWED: `haar_or_zero_entropy` of `Rigidity/PositiveEntropy`, the printed Theorem 1.2;
  `ksEntropy_eq_iSup_ksEntropyOn` of `Rigidity/Entropy`, T2) — SORRY-FROM nonempty and inside ALLOWED.
- DECLARED: the standard three and the chain's declared printed theorem (`positive_entropy_rigidity`), possibly with a
  THROUGH `sorry` — the brief's "the declared printed theorem where a record applies it". Listed by name.
Anything else fails: another axiom, or a `sorry` from anywhere else (a `sorry` of `Pieces` itself above all).
The planted record (`PLANT`: `positive_entropy_rigidity_of_polishSpace`, which rests on the declared theorem) must be
read as DECLARED; if it reads CLEAN the reader cannot see the axiom, and the run exits 1.
Every name in REQUIRED must be among the records (a reader that lost them is broken: exit 2). The downstream records
(`DOWNSTREAM-…`, `Rigidity/EntropySplitMax`, not this job's) are listed by what their `sorry`s come from; none may come
from a declaration of `Pieces`.

`--control`: plants four faults in memory after reading — `sorryAx` with its source in `Pieces` itself
(`isPiece_closure_one`), an unknown axiom in `toPiece_rot`, a `sorry` from a leaf outside ALLOWED in
`ksEntropy_rot_eq_iSup` (`exists_admissiblePair`), and a downstream record whose `sorry` comes from `exists_pieceChain` —
and requires exactly those four to be reported (exit 0 when they are, 1 otherwise).

Usage: fs131_ig1_axioms.py <axioms.txt> [--control]
(FS131-IDG1's reader, `tools/fs131_idg1_axioms.py`, re-aimed: this module's records may rest on named leaves elsewhere.)
"""
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
ALLOWED = {NS + "haar_or_zero_entropy", NS + "ksEntropy_eq_iSup_ksEntropyOn"}
REQUIRED = [NS + n for n in (
    "PieceDual.continuous_dualMap", "measurable_toPiece", "IsPiece.mulR_mem", "pieceMul_zero", "pieceMul_add",
    "toPiece_rot", "isSolenoid_pieceDual", "isTotallyIrreducible_pieceAction", "not_isVirtuallyCyclic_pieceAction",
    "isPiece_closure_one", "exists_pieceChain", "isErgodicOn_map_toPiece", "ksEntropy_rot_eq_iSup",
    "integral_eq_zero_of_isAddHaarMeasure", "isHaarFourier_or_ksEntropy_eq_zero", "pieceAction", "PieceDual")]


def parse_list(s):
    s = s.strip()
    assert s.startswith("[") and s.endswith("]"), s
    body = s[1:-1].strip()
    return set() if not body else {x.strip() for x in body.split(",")}


def main():
    control = "--control" in sys.argv
    path = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    rows, down, sorry_from, count = {}, {}, {}, None
    for ln in open(path).read().splitlines():
        if ln.startswith("AXIOMS-COUNT "):
            count = int(ln.split()[1])
        elif ln.startswith("AXIOMS "):
            head, axs = ln.split(" : ", 1)
            _, mod, kind, name = head.split(" ")
            (down if mod.startswith("DOWNSTREAM-") else rows)[name] = (mod, kind, parse_list(axs))
        elif ln.startswith("SORRY-FROM "):
            head, src = ln.split(" : ", 1)
            sorry_from[head.split(" ")[1]] = parse_list(src)
    if count is None or not rows or not down:
        print("BROKEN: no AXIOMS-COUNT line, no records, or no downstream records — the printer did not run")
        sys.exit(2)
    for n in REQUIRED:
        if n not in rows:
            print(f"BROKEN: {n} is not among the records")
            sys.exit(2)
    mine = {n for n, (mod, _, _) in rows.items() if mod != "PLANT"}
    if control:
        v = NS + "isPiece_closure_one"
        m, k, a = rows[v]
        rows[v] = (m, k, a | {"sorryAx"})
        sorry_from[v] = {v}
        v = NS + "toPiece_rot"
        m, k, a = rows[v]
        rows[v] = (m, k, a | {"planted.unknownAxiom"})
        v = NS + "ksEntropy_rot_eq_iSup"
        m, k, a = rows[v]
        rows[v] = (m, k, a | {"sorryAx"})
        sorry_from[v] = sorry_from.get(v, set()) | {NS + "exists_admissiblePair"}
        victim = sorted(down)[0]
        m, k, a = down[victim]
        down[victim] = (m, k, a | {"sorryAx"})
        sorry_from[victim] = sorry_from.get(victim, set()) | {NS + "exists_pieceChain"}
    bad, plant_fired = [], False
    classes = {"CLEAN": [], "THROUGH": [], "DECLARED": []}
    for name, (mod, kind, axs) in sorted(rows.items()):
        extra = axs - STANDARD - {"sorryAx", DECLARED}
        src = sorry_from.get(name, set())
        through_ok = "sorryAx" not in axs or (src and src <= ALLOWED)
        if mod == "PLANT":
            if DECLARED in axs and not extra and through_ok:
                plant_fired = True
                print(f"PLANT reported: {name} reads DECLARED, {sorted(axs - STANDARD)}")
            else:
                print(f"PLANT NOT READ AS DECLARED: {name}: {sorted(axs)}")
            continue
        if extra or not through_ok:
            bad.append(f"AXIOMS   {mod} {kind} {name}: {sorted(axs)}" + (f"; sorry from {sorted(src)}" if src else ""))
        elif DECLARED in axs:
            classes["DECLARED"].append((name, kind, axs, src))
        elif "sorryAx" in axs:
            classes["THROUGH"].append((name, kind, axs, src))
        else:
            classes["CLEAN"].append((name, kind, axs, src))
    n_rows = len(mine)
    print(f"records of Pieces: {n_rows} (AXIOMS-COUNT {count}): CLEAN {len(classes['CLEAN'])}, "
          f"THROUGH {len(classes['THROUGH'])}, DECLARED {len(classes['DECLARED'])}, failing {len(bad)}")
    for c in ("THROUGH", "DECLARED"):
        for name, kind, axs, src in classes[c]:
            print(f"  {c} {kind} {name}: {sorted(axs)}; sorry from {sorted(src)}")
    d_clean = d_sorry = 0
    sources = {}
    for name, (mod, kind, axs) in sorted(down.items()):
        if "sorryAx" in axs:
            d_sorry += 1
            src = sorry_from.get(name, set())
            for s in src:
                sources.setdefault(s, []).append(name)
            if src & mine:
                bad.append(f"DOWNSTREAM {mod} {name}: its sorry comes from Pieces' {sorted(src & mine)}")
        else:
            d_clean += 1
    print(f"downstream records: {len(down)}; on no sorry: {d_clean}; on sorry: {d_sorry}; their sorry comes from:")
    for s, users in sorted(sources.items()):
        print(f"  {s} ({len(users)} records)")
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
    if n_rows != count:
        print(f"COUNT MISMATCH: {n_rows} records read, AXIOMS-COUNT {count}")
        sys.exit(1)
    print("PASS" if not bad else f"FAIL: {len(bad)}")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
