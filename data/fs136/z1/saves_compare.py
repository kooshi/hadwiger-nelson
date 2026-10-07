#!/usr/bin/env python3
"""FS136-Z1 (Done means 3): the earlier reader of FS-124 (data/fs124/e2/saves_read.py, left as it is) against this job's
repaired copy (data/fs136/z1/saves_read_repaired.py: vertices at full precision), object by object, one --brief line each.

  python3 data/fs136/z1/saves_compare.py            # runs original, repaired, repaired --norepair, repaired --fault; writes saves_compare.out
Three runs per object, in parallel processes.  The line `moved=` counts the objects whose repaired line differs from the
original's; `control=` counts the objects whose --norepair line equals the original's (it must be all of them: the copy
with its repair switched off IS the original); `fault=` counts the objects whose line changes under the repaired copy's
planted fault (every object with a common unit point inside must change).
"""
import subprocess, sys, os, concurrent.futures as cf
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
OBJ = "strip disk capped T2 BB S1 MX sixfrag kept r7 hex7".split()
ORIG = os.path.join(ROOT, "data", "fs124", "e2", "saves_read.py")
COPY = os.path.join(HERE, "saves_read_repaired.py")


def run(job):
    kind, name = job
    cmd = {"original": [ORIG, name, "--brief"], "repaired": [COPY, name, "--brief"],
           "norepair": [COPY, name, "--brief", "--norepair"], "fault": [COPY, name, "--brief", "--fault"]}[kind]
    p = subprocess.run([sys.executable] + cmd, capture_output=True, text=True, cwd=ROOT)
    return kind, name, p.returncode, p.stdout.strip(), p.stderr.strip()[-300:]


def main():
    jobs = [(k, n) for n in OBJ for k in ("original", "repaired", "norepair", "fault")]
    res = {}
    with cf.ProcessPoolExecutor(max_workers=int(os.environ.get("WORKERS", "12"))) as ex:
        for kind, name, rc, out, err in ex.map(run, jobs):
            res[(kind, name)] = (rc, out, err)
    lines, moved, control, fault, bad = [], 0, 0, 0, 0
    for n in OBJ:
        for k in ("original", "repaired", "norepair", "fault"):
            rc, out, err = res[(k, n)]
            bad += rc != 0
            lines.append(f"{k:9s} exit={rc} {out}" + (f" STDERR: {err}" if err else ""))
        o, r, c, f = (res[(k, n)][1] for k in ("original", "repaired", "norepair", "fault"))
        moved += r != o; control += c == o; fault += f != r
        lines.append(f"  -> {n}: repaired {'DIFFERS FROM' if r != o else 'equals'} original; norepair {'equals' if c == o else 'DIFFERS FROM'} original; fault {'changes' if f != r else 'does not change'} the line")
    lines.append(f"objects={len(OBJ)} moved={moved} control={control} of {len(OBJ)} fault={fault} nonzero-exits={bad}")
    open(os.path.join(HERE, "saves_compare.out"), "w").write("\n".join(lines) + "\n")
    print(lines[-1])
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
