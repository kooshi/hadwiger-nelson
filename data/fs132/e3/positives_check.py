#!/usr/bin/env python3
"""FS132-E3 control `positives-escape` (of C132-M-EXCL and C132-M-ORBIT).

Runs the held float survey `tools/fs116_n1_ring.py germ` (FS116-N1's; read-only) on this project's held six-coloured
fragments by formula - the strip at P0 and P1, the disk's corner, the Y2 bowtie's centre - and reads, at every change
point of each four-colour vertex's ring, which of the four germs at +-60 degrees lie off (Q) arcs.  C132-M-ORBIT forbids
a change point all of whose orbit germs lie off (Q) arcs; so no held change point may have all four off.
Prints: rings read, change points read, the number with all four germs off (Q), and the least number of germs on (Q).
--fault: runs the survey with its own plant (the strip's arch recoloured: its rings lose their change points), so the
number of change points read differs."""
import subprocess, sys, pathlib, re
root = pathlib.Path(__file__).resolve().parents[3]
cmd = [sys.executable, str(root / "tools/fs116_n1_ring.py"), "germ"] + (["--plant"] if "--fault" in sys.argv else [])
out = subprocess.run(cmd, capture_output=True, text=True, cwd=root).stdout.splitlines()
rings = cps = allfour = 0; least = 4
for ln in out:
    if ln and not ln.startswith(" "): rings += 1
    m = re.search(r"germs off \(Q\): (\S+)", ln)
    if m:
        cps += 1
        off = 0 if m.group(1) == "none" else len(re.findall(r"[uv][+-]", m.group(1)))
        allfour += off == 4
        least = min(least, 4 - off)
print(f"rings={rings} change-points={cps} all-four-germs-off-Q={allfour} least-germs-on-Q={least}")
