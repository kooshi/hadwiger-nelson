#!/usr/bin/env python3
"""FS131-I8C — the stage's axioms print (the form of tools/fs131_i8b_axioms.py, another job's, not edited), with a control that must fire.

Reads this job's block of `scripts/Axioms.lean` (from the line holding "## FS131-I8C" to "-- FS131-I8C block end"),
runs its `#print axioms` lines against the compiled modules (so it reads what the last build wrote, never a source),
and checks every record's axioms as a set: a subset of `propext`, `Classical.choice`, `Quot.sound`.

Beside the records it plants one control, a theorem proved by `sorry`: its record must print `sorryAx`. A run in which
the control does not show `sorryAx` is an instrument failure (exit 2), as is a record count that does not match the
block's line count, or any elaboration error. Exit 1: a record with an axiom outside the three (named). Exit 0: clean.

`--fault` appends the control's name to the audited records, so the check itself must exit 1 naming it.

Usage, from the worktree root, after a build: tools/fs131_i8c_axioms.py [--fault] [--out FILE]
"""
import argparse
import os
import re
import subprocess
import sys
import tempfile

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
IMPORTS = [
    "Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub",
]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fault", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()
    src = open("scripts/Axioms.lean", encoding="utf-8").read()
    m = re.search(r"## FS131-I8C.*?-- FS131-I8C block end", src, re.S)
    if not m:
        sys.stderr.write("INSTRUMENT FAILURE: the FS131-I8C block is not in scripts/Axioms.lean\n")
        sys.exit(2)
    names = re.findall(r"^#print axioms (\S+)$", m.group(0), re.M)
    if not names:
        sys.stderr.write("INSTRUMENT FAILURE: the block has no `#print axioms` line\n")
        sys.exit(2)
    control = "FS131I8CControl.planted_sorry"
    audited = names + ([control] if a.fault else [])
    body = "\n".join(f"import {i}" for i in IMPORTS) + "\n"
    body += "set_option pp.fullNames true\n"
    body += "theorem FS131I8CControl.planted_sorry : (1 : Nat) = 2 := sorry\n"
    body += "\n".join(f"#print axioms {n}" for n in audited) + "\n"
    body += f"#print axioms {control}\n"
    with tempfile.NamedTemporaryFile("w", suffix=".lean", delete=False, dir=os.environ.get("TMPDIR")) as f:
        f.write(body)
        path = f.name
    try:
        r = subprocess.run(["lake", "env", "lean", path], capture_output=True, text=True)
    finally:
        os.unlink(path)
    out = r.stdout
    if a.out:
        with open(a.out, "w", encoding="utf-8") as f:
            f.write(out)
    errors = [l for l in out.splitlines() if ": error" in l]
    if errors:
        sys.stderr.write("INSTRUMENT FAILURE: elaboration errors:\n" + "\n".join(errors[:8]) + "\n")
        sys.exit(2)
    # records: "'name' depends on axioms: [a, b]" (possibly wrapped over lines) or "'name' does not depend on any axioms"
    flat = re.sub(r"\n\s+", " ", out)
    recs = []
    for mm in re.finditer(r"'([^']+)' (depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", flat):
        axs = set(x.strip() for x in mm.group(3).split(",")) if mm.group(3) else set()
        recs.append((mm.group(1), axs))
    if len(recs) != len(audited) + 1:
        sys.stderr.write(f"INSTRUMENT FAILURE: {len(recs)} records printed for {len(audited) + 1} asked\n{out[-2000:]}\n")
        sys.exit(2)
    cname, caxs = recs[-1]
    if cname != control or "sorryAx" not in caxs:
        sys.stderr.write(f"INSTRUMENT FAILURE: the planted control did not print sorryAx: {cname} {sorted(caxs)}\n")
        sys.exit(2)
    bad = [(n, sorted(x - STANDARD)) for n, x in recs[:-1] if not x <= STANDARD]
    free = sum(1 for _, x in recs[:-1] if not x)
    print(f"axioms print: {len(recs) - 1} records ({free} axiom-free), each a subset of the standard three: "
          f"{'NO' if bad else 'yes'}; control `{control}` prints {sorted(caxs)}")
    for n, x in bad:
        print(f"BAD {n}: {x}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
