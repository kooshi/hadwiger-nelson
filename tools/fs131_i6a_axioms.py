#!/usr/bin/env python3
"""FS131-I6A: this job's own axioms print for the declarations it proved (the audit itself is the gate's).

Reads the names of scripts/Axioms.lean's block headed "FS131-I6A" (every `#print axioms <name>` line between that heading
and the next `/-! ##` heading or the PURCHASED banner), writes a scratch Lean file that imports the module and prints the
axioms of each, runs it with `lake env lean`, and checks each record as a set: a subset of the standard three passes,
anything else (sorryAx, a native axiom, any other axiom) fails, and so does a name with no record.

The control is in the scratch file itself: a planted `theorem ... := sorry`, printed last. It MUST come back with
`sorryAx`; if it does not, the instrument is blind and the run fails with exit 3.

Usage: python3 tools/fs131_i6a_axioms.py [--out FILE] [--also NAME]...
Exit 0: every record clean and the control fired. Exit 1: a record not clean. Exit 2: no name found, or lean failed to
run. Exit 3: the control did not fire."""
import re, subprocess, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
STD = {"propext", "Classical.choice", "Quot.sound"}
AX = (ROOT / "scripts/Axioms.lean").read_text()
m = re.search(r"/-! ## FS131-I6A\b.*?-/(.*?)(?=/-! ##|#eval IO\.println \"=== PURCHASED)", AX, re.S)
names = re.findall(r"^#print axioms (\S+)", m.group(1), re.M) if m else []
if not names:
    print("NO NAME FOUND in the FS131-I6A block of scripts/Axioms.lean")
    sys.exit(2)
# a control on the failure path: `--also NAME` audits one more declaration as if it were in the block (a leaf still on
# `sorry` must then be reported NOT CLEAN, by name, and the run must exit 1)
while "--also" in sys.argv:
    i = sys.argv.index("--also")
    names.append(sys.argv[i + 1])
    del sys.argv[i:i + 2]
CONTROL = "HadwigerNelson.Plane.fs131I6aPlantedSorry"
scratch = ROOT / "data/fs131/i6a/AxiomsScratch.lean"
scratch.write_text(
    "import Proofs.HadwigerNelson.Plane.Saturated.Pinch\n\n"
    "set_option pp.fullNames true\n\n"
    + "".join(f"#print axioms {n}\n" for n in names)
    + f"\ntheorem {CONTROL} : (1 : Nat) = 2 := sorry\n#print axioms {CONTROL}\n")
r = subprocess.run(["lake", "env", "lean", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", str(scratch)],
                   cwd=ROOT, capture_output=True, text=True)
out = r.stdout + r.stderr
if "--out" in sys.argv:
    pathlib.Path(sys.argv[sys.argv.index("--out") + 1]).write_text(out)
recs = {}
for mm in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", out):
    recs[mm.group(1)] = {a.strip() for a in mm.group(2).replace("\n", " ").split(",") if a.strip()}
for mm in re.finditer(r"'([^']+)' does not depend on any axioms", out):
    recs[mm.group(1)] = set()
errors = [l for l in out.splitlines() if re.search(r": error", l)]
if errors:
    print("LEAN ERRORS:\n" + "\n".join(errors[:10]))
    sys.exit(2)
bad = 0
for n in names:
    if n not in recs:
        print(f"NO RECORD | {n}")
        bad += 1
    elif recs[n] - STD:
        print(f"NOT CLEAN | {n}: {sorted(recs[n] - STD)}")
        bad += 1
    else:
        print(f"clean     | {n}: {sorted(recs[n])}")
ctl = recs.get(CONTROL)
if ctl is None or "sorryAx" not in ctl:
    print(f"CONTROL DID NOT FIRE: {CONTROL} -> {ctl}")
    sys.exit(3)
print(f"control   | {CONTROL}: {sorted(ctl)}  (fired: sorryAx seen)")
print(f"records: {len(names)}  clean: {len(names) - bad}  not clean: {bad}")
sys.exit(1 if bad else 0)
