"""copy_verify — the second encoding and the load-bearing chords for a copy_probe refusal.
(i) one-hot at k=4 with NO symmetry breaking; (ii) 2-bit encoding, no breaking; (iii) the cross
chords 1-minimized by single deletion (which chords the refusal needs). Float geometry as in the
probe; the 250-digit check is copy_exact.py."""
from __future__ import annotations
import json, math, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from batchkill import BUILD, load_object
import coloring, forcer, rigidity
import copy_probe as CP

def onehot_nobreak(n, edges, k, cap):
    cls = coloring.base_clauses(n, edges, k) + rigidity.amo_clauses(n, k)
    return forcer._solve(cls, n * k, cap)[0]

def twobit(n, edges, cap):
    # colour of v = (x_{2v+1}, x_{2v+2}); edge (u,v): not both bits equal
    cls = []
    for u, v in edges:
        a1, a2, b1, b2 = 2*u+1, 2*u+2, 2*v+1, 2*v+2
        # forbid (a1==b1 and a2==b2): for each of 4 assignments of (a1,a2) forbid the matching (b1,b2)
        for s1 in (1, -1):
            for s2 in (1, -1):
                cls.append([-s1*a1, -s2*a2, -s1*b1, -s2*b2])
    return forcer._solve(cls, 2 * n, cap)[0]

def main():
    label = sys.argv[1]
    obj, _ = load_object(label)
    ue = obj.unit_edges(); live = set(range(obj.n)) - set(obj.deleted)
    tfs = dict(CP.transforms(obj.pts, live))
    out = {}
    for name in [n for n in tfs if n.startswith("rot-d2-about206-+") or n.startswith("rot-d2-aboutv0-+") or n.startswith("rot-d2-about205-+")]:
        n2, e2, info = CP.union_graph(obj.pts, live, ue, tfs[name])
        base = set(tuple(sorted(e)) for e in ue)
        cross = [e for e in e2 if e[1] >= obj.n and e[0] < obj.n]
        t0 = time.time(); a = onehot_nobreak(n2, e2, 4, 900); b = twobit(n2, e2, 900)
        print(f"[verify] {name}: one-hot/no-break {a.upper()}  2-bit {b.upper()}  ({time.time()-t0:.1f}s)  cross={len(cross)}", flush=True)
        row = dict(onehot_nobreak=a, twobit=b, cross=cross, n=n2, edges=len(e2))
        if a == "unsat" and b == "unsat":
            need = []
            for c in cross:
                e3 = [e for e in e2 if e != c]
                st = onehot_nobreak(n2, e3, 4, 300)
                if st != "unsat":
                    need.append((c, st))
            print(f"[verify] {name}: chords whose single deletion breaks the refusal: {len(need)} of {len(cross)}", flush=True)
            for (c, st) in need:
                u, w = c; wi = w - obj.n
                print(f"[verify]   chord {c} -> {st}", flush=True)
            row["needed_chords"] = need
        out[name] = row
        # save the union for later exact work
        json.dump(dict(transform=name, n=n2, edges=e2, cross=cross, note="float 1e-7"),
                  open(BUILD / f"m51-copyunion-{name}.json", "w"))
    json.dump(out, open(BUILD / f"m51-copyverify-{label}.json", "w"), indent=1)

if __name__ == "__main__":
    main()
