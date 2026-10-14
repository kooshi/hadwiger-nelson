#!/usr/bin/env python3
"""FS131-IN1L — the axioms of every declaration of this job's four compiled modules, read from the output of
`data/fs131/in1l/lean/Axioms.lean` (run on the built tree).

Rules (exit 0 only if all hold, and the planted record is reported):
1. Every record of `Rigidity/HaarMultiple`, `Rigidity/ZeroEntropyNames`, `Rigidity/SolenoidErgodic` rests on a subset
   of the standard three axioms.
2. Every record of `Rigidity/ChainAtTA` rests on a subset of the standard three, except the records in NOT_MINE — the
   three leaves this job does not hold and the two theorems that read them — which may also rest on `sorryAx`, and
   then only with every `sorry` coming from the three leaves (SORRY-FROM). A record outside NOT_MINE that rests on
   `sorryAx`, or a NOT_MINE record whose `sorry` comes from anywhere else, fails.
3. No record of the four modules rests on the chain's declared printed theorem.
4. The planted record (`PLANT`: `positive_entropy_rigidity_of_polishSpace`, which rests on the declared theorem) is read
   under rule 1 and must FAIL it; if it passes, the reader cannot see the axiom, and the run exits 1.
5. Every name in REQUIRED is among the records (a reader that lost them is broken: exit 2).

Usage: fs131_in1l_axioms.py <axioms.txt>
"""
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
DECLARED = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
NS = "HadwigerNelson.Rigidity."
LEAVES_NOT_MINE = {NS + n for n in ("entropySplit", "zeroEntropyCarried", "noRamifiedStableDyadic_of_tca")}
NOT_MINE = LEAVES_NOT_MINE | {NS + "mrPlus", NS + "min_localBound_five_le_chromaticNumber_closed"}
CHAIN = "Proofs.HadwigerNelson.Rigidity.ChainAtTA"
REQUIRED = [NS + n for n in (
    "maxMultiple_smul_le", "smul_le_iff_le_maxMultiple", "maxMultiple_le_measure_univ", "sub_maxMultiple_add",
    "not_smul_le_sub_maxMultiple", "map_sub_maxMultiple", "maxMultiple_self",
    "card_words_badStarts_le", "mul_card_heavyNames_le", "mul_measureReal_light_le_blockEntropy",
    "measure_frequentVisits_le", "badStarts_nameOf_le_visits", "rpow_mul_exp_le_exp", "measureReal_lightCells_le",
    "exists_forall_exp_le_measureReal_nameCell", "ZdAction.IsErgodicOn.null_or_conull_of_ae_invariant",
    "measurableSet_TA", "rot_preimage_TA", "exists_nonTorsion_unitVector", "rotInv_dirac_one",
    "zeroEntropyCarried_model", "chainInterface", "entropySplit_of_every")]


def parse_list(s):
    s = s.strip()
    assert s.startswith("[") and s.endswith("]"), s
    body = s[1:-1].strip()
    return set() if not body else {x.strip() for x in body.split(",")}


def main():
    rows, sorry_from, count = {}, {}, None
    for ln in open(sys.argv[1]).read().splitlines():
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
        print("BROKEN: no AXIOMS-COUNT line or no records — the dumper did not run")
        sys.exit(2)
    for n in REQUIRED:
        if n not in rows:
            print(f"BROKEN: {n} is not among the records")
            sys.exit(2)
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
        if axs <= STANDARD:
            continue
        if mod == CHAIN and name in NOT_MINE and axs <= STANDARD | {"sorryAx"} \
                and sorry_from.get(name, set()) <= LEAVES_NOT_MINE:
            notes.append(f"NOT MINE {name}: {sorted(axs)}; sorry from {sorted(sorry_from.get(name, set()))}")
            continue
        bad.append(f"AXIOMS   {mod} {kind} {name}: {sorted(axs)}"
                   + (f"; sorry from {sorted(sorry_from[name])}" if name in sorry_from else ""))
    n_rows = sum(v for k, v in by_mod.items() if k != "PLANT")
    print(f"records: {n_rows} (AXIOMS-COUNT {count}); per module: "
          + ", ".join(f"{k.split('.')[-1]} {v}" for k, v in sorted(by_mod.items()) if k != "PLANT"))
    print(f"standard three or fewer: {n_rows - len(notes) - len(bad)}; not mine (sorry from the three leaves): "
          f"{len(notes)}; failing: {len(bad)}")
    for x in notes:
        print("  " + x)
    for x in bad:
        print(x)
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
