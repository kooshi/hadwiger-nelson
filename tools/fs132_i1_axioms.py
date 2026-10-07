#!/usr/bin/env python3
"""FS132-I1 — the axioms of the import module's records, each checked as a set against what it is filed under.

`scripts/Axioms.lean` files this job's records in three groups: CLEAN (the standard three, or fewer), IMPORTED on
`no_proper_five_coloring` (H), IMPORTED on `proper_to_borel_weak` (T).  This tool reads a `#print axioms` print of
those records and checks each record's axiom SET against its group: a clean record carries no import; an H record
carries H and not T; a T record carries T and not H; nothing carries `sorryAx` or any other axiom.  It reads the
list of records out of `scripts/Axioms.lean` itself (the lines of the two FS132-I1 blocks), so it checks the file
that ships and not a copy of it.

  fs132_i1_axioms.py emit                 print the Lean file to run: the module imported, one `#print axioms` per record
  fs132_i1_axioms.py emit --inline FILE   the same with FILE's text in place of the import (a control: an altered copy
                                          of the module, elaborated as one file)
  fs132_i1_axioms.py check PRINT.out      exit 0 only if every record is printed and every set is as filed
  fs132_i1_axioms.py check PRINT.out --expect-fail NAME[,NAME…]
                                          a control: exit 0 only if exactly the named records are refused
"""
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
NS = "HadwigerNelson.Outside.OAI158."
STANDARD = {"propext", "Classical.choice", "Quot.sound"}
H, T = NS + "no_proper_five_coloring", NS + "proper_to_borel_weak"


def filed():
    """{record: group} read from scripts/Axioms.lean: 'H', 'T' or 'clean'."""
    text = (REPO / "scripts/Axioms.lean").read_text(encoding="utf-8")
    imported, rest = text.split('#eval IO.println "=== CLEAN ==="', 1)
    out, group = {}, None
    for ln in imported.splitlines():
        if ln.startswith("-- FS132-I1: the records resting on `no_proper_five_coloring`"):
            group = "H"
        elif ln.startswith("-- FS132-I1: the records resting on `proper_to_borel_weak`"):
            group = "T"
        elif ln.startswith("#print axioms " + NS) and group:
            out[ln.split()[2]] = group
        else:
            group = None        # a block is its header comment and the `#print axioms` lines directly under it
    clean_block = rest.split("-- FS132-I1\n", 1)
    if len(clean_block) == 2:
        for ln in clean_block[1].splitlines():
            if ln.startswith("#print axioms " + NS):
                out[ln.split()[2]] = "clean"
            else:
                break
    return out


def emit(inline):
    recs = filed()
    if inline:
        head = Path(inline).read_text(encoding="utf-8")
    else:
        head = "import Proofs.HadwigerNelson.Outside.OAI158\n"
    return head + "\nset_option pp.fullNames true\n" + "".join(f"#print axioms {r}\n" for r in recs)


def parse(text):
    """{record: set of axioms} from a `#print axioms` print (a list may wrap over lines)."""
    flat = re.sub(r"\s+", " ", text)
    out = {}
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", flat):
        out[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", flat):
        out[m.group(1)] = set()
    return out


def check(text):
    recs, got = filed(), parse(text)
    rows, refused = [], []
    n = {"clean": 0, "H": 0, "T": 0}
    for r, group in recs.items():
        short = r[len(NS):]
        if r not in got:
            refused.append(short)
            rows.append(f"FAIL  {short}: filed under {group} and NOT PRINTED")
            continue
        ax = got[r]
        why = []
        if "sorryAx" in ax:
            why.append("carries sorryAx")
        other = ax - STANDARD - {H, T, "sorryAx"}
        if other:
            why.append(f"carries {sorted(other)}")
        if group == "clean" and ax & {H, T}:
            why.append(f"filed clean and carries {sorted(a[len(NS):] for a in ax & {H, T})}")
        if group == "H" and (H not in ax or T in ax):
            why.append("filed on no_proper_five_coloring alone; carries "
                       f"{sorted(a[len(NS):] for a in ax & {H, T}) or 'neither import'}")
        if group == "T" and (T not in ax or H in ax):
            why.append("filed on proper_to_borel_weak alone; carries "
                       f"{sorted(a[len(NS):] for a in ax & {H, T}) or 'neither import'}")
        if why:
            refused.append(short)
            rows.append(f"FAIL  {short}: " + "; ".join(why))
        else:
            n[group] += 1
            rows.append(f"ok    {short}: {group}: [{', '.join(sorted(a.replace(NS, '') for a in ax))}]")
    return rows, refused, n, len(recs)


def main(argv):
    if len(argv) >= 2 and argv[1] == "emit":
        inline = argv[argv.index("--inline") + 1] if "--inline" in argv else None
        sys.stdout.write(emit(inline))
        return 0
    if len(argv) >= 3 and argv[1] == "check":
        rows, refused, n, total = check(Path(argv[2]).read_text(encoding="utf-8"))
        for r in rows:
            print(r)
        print(f"records filed: {total}  as filed: {sum(n.values())} (clean {n['clean']}, on H {n['H']}, on T {n['T']})  "
              f"refused: {len(refused)} {refused}")
        if total == 0:
            print("NO RECORD READ from scripts/Axioms.lean — that is a failure, not a pass")
            return 1
        if "--expect-fail" in argv:
            want = sorted(x for x in argv[argv.index("--expect-fail") + 1].split(",") if x)
            ok = sorted(refused) == want
            print(f"CONTROL {'FIRED AS EXPECTED' if ok else 'DID NOT MATCH'}: expected refused {want}")
            return 0 if ok else 1
        return 1 if refused else 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
