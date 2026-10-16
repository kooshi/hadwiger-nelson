#!/usr/bin/env python3
"""FS131-IQP3 — the audit's records for the p-adic plane's landing, generated from the kernel's print of every record of the
eight modules it brings (`data/fs131/iqp3/lean/AxiomsAll.lean` -> `data/fs131/iqp3/axioms-all.txt`), less the records
`scripts/Axioms.lean` already holds. FS131-ICO2's `data/fs131/ico2/audit_block.py` (after FS131-LGT1's
`tools/fs131_lgt1_audit_block.py`), its plant made reachable when no record of the landing is filed yet.

Every PUBLIC theorem or definition is classed as `scripts/axioms.sh` classes it (LEAN.md § Trust ledger):
  CLEAN     a subset of the standard three;
  IMPORTED  the standard three and declared outside theorems, at least one;
  OPEN      `sorryAx` among its axioms — the generator STOPS (the gate takes no sorry);
  BAD       any other axiom — the generator STOPS.
An IMPORTED record goes to the block of the declared import it is placed under: `no_proper_five_coloring` if it names that
one, else `positive_entropy_rigidity` if it names that one, else `kloosterman_bound`. A record `scripts/Axioms.lean`
already prints is not emitted again; its section there must agree with its class here, or the generator STOPS (MISFILED).
`--coverage` emits nothing and requires every public record already filed (the check after the blocks are in).

Writes <out>.imported-np5.lean, <out>.imported-pe.lean, <out>.imported-kb.lean, <out>.clean.lean and prints the counts.
Usage: audit_block.py <axioms-all.txt> <scripts/Axioms.lean> <out-prefix> [--coverage] [--plant]
--plant (in memory): an unknown axiom in one record, a sorryAx in another, and a third CLEAN record filed under PURCHASED;
exits 0 only when all three are reported, each by name, and nothing else stops.
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
    pa = pb = pc = None
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    recs, audit, pre = read_records(args[0]), read_audit(args[1]), args[2]
    if not recs:
        print("NO RECORDS — the printer or the reader is broken")
        return 2
    if plant:
        pub = [r for r in recs if r[1] == "public"]
        clean = [r for r in pub if not (r[3] - STANDARD)]
        if len(pub) < 3 or len(clean) < 3:
            print("PLANT UNREACHABLE: needs three public CLEAN records")
            return 2
        a, b, c = clean[0], clean[1], clean[2]
        a[3] = a[3] | {"planted.unknownAxiom"}
        b[3] = b[3] | {"sorryAx"}
        audit[c[2]] = "PURCHASED"
        pa, pb, pc = a[2], b[2], c[2]
        print(f"PLANTED: unknown axiom in {pa}; sorryAx in {pb}; {pc} filed under PURCHASED")
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
            cls = "IMPORTED"
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
    if plant:
        want = [f"BAD {pa} ", f"OPEN {pb} ", f"MISFILED {pc}:"]
        got = [w for w in want if any(st.startswith(w) for st in stops)]
        print(f"PLANT {'FIRED: all three reported' if len(got) == 3 else 'NOT FIRED: reported ' + str(got)}"
              f" ({len(stops)} stop(s) in all)")
        return 0 if len(got) == 3 and len(stops) == 3 else 1
    if stops:
        print(f"STOP: {len(stops)} record(s) the gate cannot take")
        return 1
    if coverage:
        print(f"COVERAGE OK: every one of the {npub} public records is filed under its class")
        return 0
    for key, rows in blocks.items():
        with open(f"{pre}.{'imported-' + key if key != 'clean' else key}.lean", "w", encoding="utf-8") as f:
            for mod, name in sorted(rows):
                f.write(f"#print axioms {name}\n")
        print(f"BLOCK {key}: {len(rows)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
