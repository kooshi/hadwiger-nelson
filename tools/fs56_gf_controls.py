#!/usr/bin/env python3
"""fs56_gf_controls -- planted faults on a genuine FS-56 certificate, each run through tools/fs56_gf_check.py in a fresh process,
with a faithful twin that must pass.  A control is "as designed" only if it ends the way it was built to and for the named reason.

  python3 tools/fs56_gf_controls.py GENUINE.json OUTDIR RECORD.json

Plants (each must be REFUSED, and the refusal must contain the named fragment):
  a  w claimed above the singleton sum                       -> "the singletons sum to"
  b  one singleton weight raised by 1/1000 and w with it      -> "weighs"          (some independent set now exceeds 1)
  c  the weight of a listed set moved onto a set of the same size in a different congruence class
                                                              -> "sums to"         (two class sums break)
  d  a point moved by (1/N, 0): its unit edges vanish         -> "sums to" or "weighs" (the congruences or the bound break)
Faithful twin (must be CERTIFIED with the same w):
  t  the points relabelled by a fixed random permutation, every set renamed accordingly
"""
import json
import random
import subprocess
import sys
import time
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fs56_gf_check as C  # noqa: E402

src, outdir, record = Path(sys.argv[1]), Path(sys.argv[2]), Path(sys.argv[3])
outdir.mkdir(parents=True, exist_ok=True)
base = json.loads(src.read_text())
rng = random.Random(20260916)


def run(name, cert, expect, fragments):
    path = outdir / f"{name}.json"
    path.write_text(json.dumps(cert))
    t = time.time()
    p = subprocess.run([sys.executable, str(Path(__file__).resolve().parent / "fs56_gf_check.py"), str(path)],
                       capture_output=True, text=True)
    out = (p.stdout + p.stderr).strip().splitlines()
    verdict = next((l for l in out if l.startswith(("CERTIFIED", "NOT A CERTIFICATE", "UNREADABLE"))), out[-1] if out else "")
    if expect == "pass":
        ok = p.returncode == 0 and verdict.startswith("CERTIFIED") and f"w = {base['w']} " in verdict
    else:
        ok = p.returncode == 1 and any(f in verdict for f in fragments)
    print(f"[controls] {'OK ' if ok else 'BAD'} {name}: expected {expect}, exit {p.returncode}, {time.time() - t:.0f} s\n"
          f"           {verdict[:220]}", flush=True)
    path.unlink()  # plants are regenerable; the record keeps what was printed
    return dict(control=name, expect=expect, fragments=fragments, exit=p.returncode, printed=verdict, as_designed=ok)


def copy():
    return json.loads(json.dumps(base))


results = []
c = copy()
c["w"] = str(Fraction(c["w"]) + Fraction(1, 10))
results.append(run("a-w-overclaimed", c, "refuse", ["the singletons sum to"]))

c = copy()
single = next(e for e in c["weights"] if len(e["set"]) == 1)
single["y"] = str(Fraction(single["y"]) + Fraction(1, 1000))
c["w"] = str(Fraction(c["w"]) + Fraction(1, 1000))
results.append(run("b-singleton-raised", c, "refuse", ["weighs"]))

# c: move a nonzero weight onto a same-size set from another congruence class
c = copy()
F = C.Field(c["field"]["radicands"])
P = C.Plane(F, c["denominator"], [(tuple(x), tuple(y)) for x, y in c["points"]])
sets = [tuple(e["set"]) for e in c["weights"]]
classes = C.group_classes(P, sets)
cls_of = {t: ci for ci, cls in enumerate(classes) for t in cls}
src_t = next(t for t, Y in enumerate(sets) if len(Y) >= 2 and Fraction(c["weights"][t]["y"]) != 0)
dst_t = next(t for t, Y in enumerate(sets) if len(Y) == len(sets[src_t]) and t in cls_of and cls_of[t] != cls_of[src_t])
moved = Fraction(c["weights"][src_t]["y"])
c["weights"][dst_t]["y"] = str(Fraction(c["weights"][dst_t]["y"]) + moved)
c["weights"][src_t]["y"] = "0"
results.append(run("c-weight-moved-across-classes", c, "refuse", ["sums to"]))

c = copy()
c["points"][0][0][0] += 1
results.append(run("d-point-moved", c, "refuse", ["sums to", "weighs"]))

c = copy()
n = len(c["points"])
perm = list(range(n))
rng.shuffle(perm)  # old index i -> new index perm[i]
newpts = [None] * n
for i, pt in enumerate(c["points"]):
    newpts[perm[i]] = pt
c["points"] = newpts
for e in c["weights"]:
    e["set"] = sorted(perm[v] for v in e["set"])
results.append(run("t-faithful-relabelled", c, "pass", []))

rec = dict(kind="fs56-gf-certificate-controls", genuine=str(src), results=results,
           all_as_designed=all(r["as_designed"] for r in results))
record.write_text(json.dumps(rec, indent=1))
print(f"[controls] {sum(r['as_designed'] for r in results)}/{len(results)} as designed; wrote {record}")
sys.exit(0 if rec["all_as_designed"] else 1)
