#!/usr/bin/env python3
"""FS136-Z1 — the control of C136-STOP-BOWTIE-SIX (the six-tile form of the first round's dated note under
C136-STOP-BOWTIE): reads the first round's exact check (data/fs136/e1/stop_check.py bowtie, run as it is, not edited) and
keeps ONLY the six (tile, member) lines the statement names — L2, T2, V', t1 at x = q2 and T1, W at y = q1.

For the cell inside S(x) and outside S(y) near w = (sqrt 3, 0):
  a label is barred inside S(x)  by a kept tile at x with a witness strictly OUTSIDE S(w)  ("barred inside" / "on both sides");
  a label is barred outside S(y) by a kept tile at y with a witness strictly INSIDE  S(w)  ("barred outside" / "on both sides").
Prints one line; EXCLUDED iff step 1 of the exact check holds, the six labels are distinct, and all six are barred in the cell.
--fault passes --fault to the exact check (the point moved by (1/50, 0)): step 1 fails and nothing is concluded.
--drop=<tile> leaves one of the six out (a second plant: the cell must then keep a label).
Always exits 0; the line says what was found.
"""
import os, re, subprocess, sys
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
KEEP = [("L2", "x"), ("T2", "x"), ("V'", "x"), ("t1", "x"), ("T1", "y"), ("W", "y")]
drop = next((a.split("=")[1] for a in sys.argv[1:] if a.startswith("--drop=")), None)
keep = [k for k in KEEP if k[0] != drop]
cmd = [sys.executable, os.path.join(ROOT, "data", "fs136", "e1", "stop_check.py"), "bowtie"] + (["--fault"] if "--fault" in sys.argv else [])
out = subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT).stdout
step1 = bool(re.search(r"1\. \|w-x\|=1:True \|w-y\|=1:True 0<\|x-y\|<2:True", out))
rows = {}
for m in re.finditer(r"3\. tile (\S+) label (\d+) at ([xy]): .*-> barred (inside|outside|on both sides) S\(([xy])\)", out):
    rows[(m.group(1), m.group(3))] = (int(m.group(2)), m.group(4))
labels, barred, missing = set(), set(), []
for t, z in keep:
    if (t, z) not in rows: missing.append(f"{t}@{z}"); continue
    lab, how = rows[(t, z)]
    labels.add(lab)
    if z == "x" and how in ("inside", "on both sides"): barred.add(lab)       # inside S(x): the tile has a point strictly outside S(w)
    if z == "y" and how in ("outside", "on both sides"): barred.add(lab)      # outside S(y): the tile has a point strictly inside S(w)
ok = step1 and not missing and len(keep) == 6 and len(labels) == 6 and barred == set(range(1, 7))
print("bowtie-six: kept=" + ",".join(f"{t}@{'q2' if z == 'x' else 'q1'}" for t, z in keep) + f" step1={step1} lines-read={len(keep) - len(missing)} of {len(keep)}"
      f" labels={len(labels)} barred-in-the-cell(in S(q2), out S(q1))={len(barred)} left={sorted(set(range(1, 7)) - barred)} "
      + ("EXCLUDED" if ok else "NOT SHOWN"))
