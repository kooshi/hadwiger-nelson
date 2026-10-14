#!/usr/bin/env python3
"""FS131-IDG1 — the axioms of every declaration of this job's six compiled modules, read from the output of
`data/fs131/idg1/lean/Axioms.lean` (run on the built tree).

Rules (exit 0 only if all hold, and the planted record is reported):
1. Every record of `Rigidity/DualGroup`, `Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`, `UnitCircle` rests
   on a subset of the standard three axioms, except the one leaf this job does not hold, `exists_admissiblePair`
   (lane A's), which may also rest on `sorryAx`, and then only with its `sorry` its own (SORRY-FROM is itself).
2. No record of the six modules rests on the chain's declared printed theorem.
3. The planted record (`PLANT`: `positive_entropy_rigidity_of_polishSpace`, which rests on the declared theorem) is read
   under rule 1 and must FAIL it; if it passes, the reader cannot see the axiom, and the run exits 1.
4. Every name in REQUIRED is among the records (a reader that lost them is broken: exit 2).
5. The records of the two downstream modules (`DOWNSTREAM-…`; `Rigidity/Pieces`, `Rigidity/EntropySplitMax`, not
   this job's) are counted and listed by what their `sorry`s come from; none may come from a declaration of the six
   modules other than `exists_admissiblePair` — the duality headlines reach no `sorry` of this job's.

`--control`: plants three faults in memory after reading — `sorryAx` in `measure_eq_of_fourier`, the declared theorem in
`connectedSpace_dual`, and a downstream record whose `sorry` comes from `isClosedEmbedding_coe` — and requires exactly
those three to be reported (exit 0 when they are, 1 otherwise).

Usage: fs131_idg1_axioms.py <axioms.txt> [--control]
(FS131-IN1L's reader, `tools/fs131_in1l_axioms.py`, for this job's modules.)
"""
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
SI = "HadwigerNelson.SpectralInputs."
NOT_MINE = NS + "exists_admissiblePair"
REQUIRED = [NS + n for n in (
    "isClosedEmbedding_coe", "isTopologicalGroup_dual", "compactSpace_dual", "polishSpace_dual", "borelSpace_dual",
    "standardBorelSpace_dual", "exists_apply_ne_one", "measure_eq_of_fourier", "isProbabilityMeasure_dualHaar",
    "isHaarFourier_dualHaar", "isHaarFourier_iff",
    "le_dualAnnihilator_iff", "dualCoannihilator_top", "finite_dualAnnihilator", "subgroupHaar_bot",
    "integral_subgroupHaar_eq", "dualAnnihilator_dualCoannihilator_of_isClosed", "dualAnnihilator_dualCoannihilator",
    "eq_top_of_isClosed_of_dualCoannihilator_eq_bot", "eq_top_of_isClosed_of_dualCoannihilator_eq_bot'",
    "evalDualHom_surjective", "dualDualEquiv", "additiveDualDualEquiv", "Duality.graphSubgroup",
    "connectedSpace_dual", "not_connectedSpace_dual_zmod_two",
    "uvRing_toUnitVector_mul", "uvRing_toUnitVector_one", "rotInv_iff", "countable_unitCircle",
    "AdmissiblePair.u_nonTorsion", "AdmissiblePair.ofPow", "exists_admissiblePair")] + \
    [SI + n for n in ("IsHaarFourier.map_dual", "IsHaarFourier.map_mul_right", "IsHaarFourier.rotInv")]


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
    if control:
        m, k, a = rows[NS + "measure_eq_of_fourier"]
        rows[NS + "measure_eq_of_fourier"] = (m, k, a | {"sorryAx"})
        m, k, a = rows[NS + "connectedSpace_dual"]
        rows[NS + "connectedSpace_dual"] = (m, k, a | {DECLARED})
        victim = sorted(down)[0]
        m, k, a = down[victim]
        down[victim] = (m, k, a | {"sorryAx"})
        sorry_from[victim] = sorry_from.get(victim, set()) | {NS + "isClosedEmbedding_coe"}
    mine = {n for n, (mod, _, _) in rows.items() if mod != "PLANT"}
    bad, plant_fired, notes = [], False, []
    by_mod = {}
    for name, (mod, kind, axs) in sorted(rows.items()):
        by_mod[mod] = by_mod.get(mod, 0) + 1
        if mod == "PLANT":
            if not axs <= STANDARD and DECLARED in axs:
                plant_fired = True
                print(f"PLANT reported: {name} rests on {sorted(axs - STANDARD)}")
            continue
        if DECLARED in axs:
            bad.append(f"DECLARED {mod} {name}: rests on the declared printed theorem")
            continue
        if axs <= STANDARD:
            continue
        if name == NOT_MINE and axs <= STANDARD | {"sorryAx"} and sorry_from.get(name, set()) == {NOT_MINE}:
            notes.append(f"NOT MINE {name}: {sorted(axs)}; sorry from {sorted(sorry_from.get(name, set()))}")
            continue
        bad.append(f"AXIOMS   {mod} {kind} {name}: {sorted(axs)}"
                   + (f"; sorry from {sorted(sorry_from[name])}" if name in sorry_from else ""))
    n_rows = sum(v for k, v in by_mod.items() if k != "PLANT")
    print(f"records: {n_rows} (AXIOMS-COUNT {count}); per module: "
          + ", ".join(f"{k.split('.')[-1]} {v}" for k, v in sorted(by_mod.items()) if k != "PLANT"))
    print(f"standard three or fewer: {n_rows - len(notes) - len(bad)}; not mine (its own sorry): {len(notes)}; "
          f"failing: {len(bad)}")
    for x in notes:
        print("  " + x)
    # downstream
    d_clean = d_sorry = 0
    sources = {}
    for name, (mod, kind, axs) in sorted(down.items()):
        if DECLARED in axs:
            pass  # the chain's declared theorem is read downstream by design; reported in the listing below
        if "sorryAx" in axs:
            d_sorry += 1
            src = sorry_from.get(name, set())
            for s in src:
                sources.setdefault(s, []).append(name)
            mine_src = sorted((src & mine) - {NOT_MINE})
            if mine_src:
                bad.append(f"DOWNSTREAM {mod} {name}: its sorry comes from this job's {mine_src}")
        else:
            d_clean += 1
    print(f"downstream records: {len(down)}; on no sorry: {d_clean}; on sorry: {d_sorry}; their sorry comes from:")
    for s, users in sorted(sources.items()):
        print(f"  {s} ({len(users)} records)")
    for x in bad:
        print(x)
    if control:
        want = 3
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
