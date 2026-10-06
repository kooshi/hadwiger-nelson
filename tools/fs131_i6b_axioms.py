#!/usr/bin/env python3
"""FS131-I6B: print the axioms of this job's block of scripts/Axioms.lean and check each record.

Reads the '#print axioms' lines between the heading '## FS131-I6B' and the next heading or banner of
scripts/Axioms.lean, elaborates them in a scratch file importing this job's three modules (lake env lean: iteration
grade — the audit itself is the gate's, scripts/axioms.sh), and requires, for every line, one record whose axioms are
a subset of the standard three. Fails (exit 1) on a missing record, an error, or any other axiom; exit 2 if the block
is empty. The full output goes to the path given by --out.

Usage: python3 tools/fs131_i6b_axioms.py --out <file> [--plant]
  --plant adds a theorem proved by 'sorry' to the scratch file and its '#print axioms' line: the check must then name
  it with sorryAx and exit 1."""
import re, subprocess, sys, pathlib, tempfile

TREE = pathlib.Path(__file__).resolve().parent.parent
STD = {"propext", "Classical.choice", "Quot.sound"}
src = (TREE / "scripts/Axioms.lean").read_text().splitlines()
block, on = [], False
for l in src:
    if l.startswith("/-! ## FS131-I6B"):
        on = True
        continue
    if on and (l.startswith("/-! ##") or l.startswith("#eval")):
        break
    if on and l.startswith("#print axioms "):
        block.append(l.split()[2])
if not block:
    print("EMPTY BLOCK: no '#print axioms' line under '## FS131-I6B'")
    sys.exit(2)
body = ["import Proofs.HadwigerNelson.Plane.Saturated.MapColouring", "set_option pp.fullNames true"]
if "--plant" in sys.argv:
    body += ["theorem fs131_i6b_planted : (1 : Nat) = 2 := sorry"]
    block = block + ["fs131_i6b_planted"]
body += [f"#print axioms {n}" for n in block]
with tempfile.TemporaryDirectory() as d:
    p = pathlib.Path(d) / "I6BAxioms.lean"
    p.write_text("\n".join(body) + "\n")
    r = subprocess.run(["lake", "env", "lean", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", str(p)],
                       cwd=TREE, capture_output=True, text=True)
out = r.stdout + r.stderr
if "--out" in sys.argv:
    pathlib.Path(sys.argv[sys.argv.index("--out") + 1]).write_text(out)
text = " ".join(out.split())
bad = 0
for n in block:
    m = re.search(r"'" + re.escape(n) + r"' (depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", text)
    if not m:
        print(f"MISSING  | {n}: no record")
        bad += 1
        continue
    ax = {a.strip() for a in (m.group(2) or "").split(",") if a.strip()}
    if ax - STD:
        print(f"IMPURE   | {n}: {sorted(ax - STD)}")
        bad += 1
if " error" in text.replace("error:", " error"):
    print("ERROR    | the scratch file did not elaborate cleanly (see --out)")
    bad += 1
print(f"records: {len(block)}  clean: {len(block) - bad if bad <= len(block) else 0}  flagged: {bad}")
sys.exit(1 if bad else 0)
