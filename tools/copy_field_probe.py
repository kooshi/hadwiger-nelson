#!/usr/bin/env python3
"""copy_field_probe — does the copy lock live on the SEED-FIELD sub-lattice? (M52 phase 2, from the
atlas finding that every cross chord of the 206-copy has both endpoints in ℚ(√3, √11).)

    python3 tools/copy_field_probe.py --object <plain label> --centre 206 [--dps 50] [--cap 300]

1. Flags every live point of the object as IN the seed field ℚ(√3, √11) or not (PSLQ on both
   coordinates against {1, √3, √11, √33} at `dps` digits; a numeric census, not a proof).
2. The seed-field SUB-OBJECT: those points with the unit edges among them; counts by kind and
   depth; its k = 4 verdict alone.
3. The sub-object plus its ρ₁₅ copy about the centre (the copy of a seed-field point is in
   ℚ(√3, √11, √15)): cross chords and the k = 4 verdict — UNSAT means the lock is carried by the
   seed-field sub-lattice alone; SAT means the new-root halo material is load-bearing.
4. The complement control: the object with the seed-field halo points REMOVED, plus its copy — the
   other half of the same question.
Writes `data/m52/fieldprobe-<label>.json`. UNTRUSTED like all of tools/."""
from __future__ import annotations
import argparse, collections, json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
import mpmath as mp
import batchkill as B
import compose as C

OUT = Path(__file__).resolve().parent.parent / "data" / "m52"


def in_seed_field(z, dps):
    for coord in (z.real, z.imag):
        if abs(coord) < mp.mpf(10) ** (-(dps - 10)):
            continue
        rel = mp.pslq([coord, 1, mp.sqrt(3), mp.sqrt(11), mp.sqrt(33)], maxcoeff=10 ** 8, maxsteps=4000)
        if not rel or rel[0] == 0:
            return False
    return True


def induced(edges, keep):
    ks = set(keep)
    return [e for e in edges if e[0] in ks and e[1] in ks]


def ask(n, edges, cap):
    st, secs = C.ask_k4(n, edges, cap)
    return st, round(secs, 1)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--centre", type=int, default=206)
    ap.add_argument("--dps", type=int, default=50); ap.add_argument("--cap", type=float, default=300.0)
    a = ap.parse_args()
    t0 = time.time(); mp.mp.dps = a.dps
    obj, removed = B.load_object(a.object)
    ex = obj.mp_values(a.dps)
    live = [i for i in range(obj.n) if i not in obj.deleted]
    depth = {}
    for i, rec in enumerate(obj.prov):
        depth[i] = 0 if rec[0] == "seed" else (depth[rec[2]] if rec[0] == "rot" else 1 + max(depth[rec[1]], depth[rec[2]]))
    flag = {i: in_seed_field(ex[i], a.dps) for i in live}
    inf = [i for i in live if flag[i]]
    by_depth = collections.Counter(depth[i] for i in inf)
    by_depth_all = collections.Counter(depth[i] for i in live)
    print(f"[field] {a.object}: {len(inf)} of {len(live)} live points in Q(sqrt3,sqrt11); by depth "
          f"{dict(sorted(by_depth.items()))} of {dict(sorted(by_depth_all.items()))} [{time.time()-t0:.0f}s]", flush=True)
    ue = obj.unit_edges()
    sub = induced(ue, inf)
    st_sub, t_sub = ask(obj.n, sub, a.cap)
    print(f"[field] seed-field sub-object: {len(inf)} points, {len(sub)} unit edges, k=4 {st_sub.upper()} ({t_sub}s)", flush=True)
    # the sub-object plus its copy about the centre
    assert flag.get(a.centre, False), "the centre must be a seed-field point"
    o2 = B.Obj()
    # rebuild the sub-object as a fresh Obj: keep provenance, delete everything not in the field
    o2, _ = B.load_object(a.object)
    o2.delete_vertices([i for i in live if not flag[i] and i not in (o2.A, o2.B)])
    stats = C.compose(o2, [(2, a.centre, +1)], log=lambda *_: None)
    o2.check(30)
    bad2 = o2.verify_unit_edges(50, only_touching={i for i, r in enumerate(o2.prov) if r[0] == "rot"})
    ue2 = o2.unit_edges()
    census2 = C.chord_census(o2, ue2)
    st2, t2 = ask(o2.n, ue2, a.cap)
    print(f"[field] sub-object + copy about {a.centre}: n={o2.n} (live {o2.n - len(o2.deleted)}), unit {len(ue2)}, "
          f"cross chords {census2['cross_original_copy']}, k=4 {st2.upper()} ({t2}s)"
          + ("  — the lock lives on the seed-field sub-lattice" if st2 == "unsat" else "  — new-root material is load-bearing"), flush=True)
    # the complement control: remove the seed-field HALO points (keep the seed), add the copy
    o3, _ = B.load_object(a.object)
    o3.delete_vertices([i for i in live if flag[i] and i >= 214])
    C.compose(o3, [(2, a.centre, +1)], log=lambda *_: None)
    bad3 = o3.verify_unit_edges(50, only_touching={i for i, r in enumerate(o3.prov) if r[0] == "rot"})
    ue3 = o3.unit_edges(); census3 = C.chord_census(o3, ue3)
    st3, t3 = ask(o3.n, ue3, a.cap)
    print(f"[field] complement (seed-field halo points removed) + copy: live {o3.n - len(o3.deleted)}, unit {len(ue3)}, "
          f"cross chords {census3['cross_original_copy']}, k=4 {st3.upper()} ({t3}s)", flush=True)
    row = dict(kind="copy-field-probe", label=a.object, centre=a.centre, dps=a.dps,
               in_field=len(inf), live=len(live), in_field_by_depth={str(k): v for k, v in sorted(by_depth.items())},
               live_by_depth={str(k): v for k, v in sorted(by_depth_all.items())},
               in_field_indices=inf,
               sub_object=dict(points=len(inf), unit=len(sub), k4=st_sub, secs=t_sub),
               sub_plus_copy=dict(n=o2.n, live=o2.n - len(o2.deleted), unit=len(ue2), chords=census2["cross_original_copy"], k4=st2, secs=t2),
               complement_plus_copy=dict(live=o3.n - len(o3.deleted), unit=len(ue3), chords=census3["cross_original_copy"], k4=st3, secs=t3),
               exact_rejected=dict(sub_plus_copy=len(bad2), complement_plus_copy=len(bad3)),
               seconds=round(time.time() - t0, 1),
               claim_scope="field membership by PSLQ at dps digits (numeric census); k=4 verdicts one-hot + degree breaking at the cap; "
                           "a cap is not a verdict")
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f"fieldprobe-{a.object}.json").write_text(json.dumps(row, indent=1))
    print(f"[field] wrote {OUT / ('fieldprobe-' + a.object + '.json')} [{time.time()-t0:.0f}s]")


if __name__ == "__main__":
    main()
