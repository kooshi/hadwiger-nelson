#!/usr/bin/env python3
"""FS131-ICT2 — the audit's records for the three-colour landing (`CayleyThree/Circular`, `Fibre`, `Density`), generated
from the kernel's print of every record of the three modules (`data/fs131/ict2/lean/AxiomsAll.lean` ->
`data/fs131/ict2/axioms-all.txt`), less the records `scripts/Axioms.lean` already holds. FS131-ICO2's
`data/fs131/ico2/audit_block.py` (after FS131-LGT1's `tools/fs131_lgt1_audit_block.py`), with one change: this landing
declares no import and takes no hypothesis, so a record on a declared import STOPS the generator too (IMPORTED is not
expected here; the plan's § 3.7 and the head statements' probe say every record is on the standard three or fewer).

Every PUBLIC theorem or definition is classed as `scripts/axioms.sh` classes it (LEAN.md § Trust ledger):
  CLEAN     a subset of the standard three;
  IMPORTED  the standard three and declared outside theorems, at least one — STOPS here (not expected);
  OPEN      `sorryAx` among its axioms — STOPS (the gate takes no sorry);
  BAD       any other axiom — STOPS.
A record `scripts/Axioms.lean` already prints is not emitted again; its section there must agree with its class here, or the
generator STOPS (MISFILED). `--coverage` emits nothing and requires every public record already filed (the check after the
block is in).

Writes <out>.clean.lean and prints the counts.
Usage: fs131_ict2_audit_block.py <axioms-all.txt> <scripts/Axioms.lean> <out-prefix> [--coverage] [--plant]
--plant (in memory): an unknown axiom in one record, a sorryAx in another, a declared import in a third, and one CLEAN
record already filed moved to the PURCHASED section; requires all four reported and exit 1.
"""
import re
import sys
from collections import defaultdict

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
PE = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
NP5 = "HadwigerNelson.Outside.OAI158.no_proper_five_coloring"
IMPORTS = {PE, KB, NP5}


def read_records(path):
    recs = []
    for ln in open(path, encoding="utf-8"):
        m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", ln.rstrip("\n"))
        if m and m.group(1) != "PLANT":
            ax = {a.strip() for a in m.group(4).split(",") if a.strip()}
            recs.append([m.group(1), m.group(2), m.group(3), ax])
    return recs


def read_audit(path):
    sec, out = None, {}
    for ln in open(path, encoding="utf-8"):
        m = re.match(r'#eval IO\.println "=== (\w+) ==="', ln)
        if m:
            sec = m.group(1)
            continue
        m = re.match(r"#print axioms (\S+)\s*$", ln)
        if m:
            out[m.group(1)] = sec
    return out


def main():
    plant, coverage = "--plant" in sys.argv, "--coverage" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    recs, audit, pre = read_records(args[0]), read_audit(args[1]), args[2]
    if not recs:
        print("NO RECORDS — the printer or the reader is broken")
        return 2
    if plant:
        pub = [r for r in recs if r[1] == "public"]
        new = [r for r in pub if r[2] not in audit]
        old = [r for r in pub if r[2] in audit and audit[r[2]] == "CLEAN"]
        if len(new) < 3 or not old:
            print("PLANT UNREACHABLE: needs three unfiled records and one filed CLEAN record")
            return 2
        new[0][3] = new[0][3] | {"planted.unknownAxiom"}
        new[1][3] = new[1][3] | {"sorryAx"}
        new[2][3] = new[2][3] | {KB}
        audit[old[0][2]] = "PURCHASED"
        print(f"PLANTED: unknown axiom in {new[0][2]}; sorryAx in {new[1][2]}; {KB} in {new[2][2]}; "
              f"{old[0][2]} filed under PURCHASED")
    blocks = {"np5": [], "pe": [], "kb": [], "clean": []}
    stops, present, npub, npriv = [], 0, 0, 0
    per_mod = defaultdict(lambda: defaultdict(int))
    for mod, kind, name, ax in recs:
        if kind != "public":
            npriv += 1
            continue
        npub += 1
        extra = ax - STANDARD
        if not extra:
            cls = "CLEAN"
        elif "sorryAx" in extra:
            stops.append(f"OPEN {name} ({mod}): {sorted(ax)}")
            continue
        elif extra <= IMPORTS:
            stops.append(f"IMPORTED {name} ({mod}): {sorted(extra)} — this landing declares no import")
            continue
        else:
            stops.append(f"BAD {name} ({mod}): {sorted(extra)}")
            continue
        per_mod[mod][cls if cls == "CLEAN" else "+".join(sorted(e.rsplit('.', 1)[1] for e in extra))] += 1
        if name in audit:
            present += 1
            if audit[name] != cls:
                stops.append(f"MISFILED {name}: class {cls}, filed under {audit[name]}")
            continue
        if coverage:
            stops.append(f"UNFILED {name} ({mod}): class {cls}")
            continue
        key = "clean" if cls == "CLEAN" else "np5" if NP5 in extra else "pe" if PE in extra else "kb"
        blocks[key].append((mod, name))
    for mod in sorted(per_mod):
        print(f"MODULE {mod}: " + ", ".join(f"{k} {v}" for k, v in sorted(per_mod[mod].items())))
    for s in stops:
        print(s)
    print(f"records: {npub} public ({present} already filed), {npriv} private (not audited)")
    if stops:
        print(f"STOP: {len(stops)} record(s) the gate cannot take")
        if plant:
            kinds = {s.split()[0] for s in stops}
            want = {"BAD", "OPEN", "IMPORTED", "MISFILED"}
            print(f"PLANT {'ALL REPORTED' if want <= kinds and len(stops) == 4 else 'NOT ALL REPORTED'}: {sorted(kinds)}")
            return 1 if want <= kinds and len(stops) == 4 else 0
        return 1
    if plant:
        print("PLANT NOT REPORTED")
        return 0
    if coverage:
        print(f"COVERAGE OK: every one of the {npub} public records is filed under its class")
        return 0
    rows = blocks["clean"]
    with open(f"{pre}.clean.lean", "w", encoding="utf-8") as f:
        for mod, name in sorted(rows):
            f.write(f"#print axioms {name}\n")
    print(f"BLOCK clean: {len(rows)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
