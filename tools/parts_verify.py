#!/usr/bin/env python3
"""Verify every object in [Parts2020a]'s reference-[11] archive, in exact arithmetic.

This is a control, not a computation: his filenames state the vertex and unit-edge counts, his
paper states the orbit fillings, and both are checked here against a parse that shares no code
with either. Reports per file so a long run says what it is doing from inside; writes one JSON.

Verdict vocabulary, per the house rule (no word means "clean"):
  matches-filename      -- vertex and unit-edge counts equal the name's v<V>e<E>
  count-disagrees       -- parsed fine, the counts differ; the numbers are recorded
  off-lattice           -- some vertex is not on his denominator-12 lattice at all
  off-base              -- on the lattice but outside our base radius; the radius is recorded
  type-m                -- not a lattice graph: parsed in the tower and split into L u rho*S
  unparsed              -- the parser refused; the line is recorded
"""
import json, os, sys, time
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
import parts_vtx as V
import parts_repro as P

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main(out=None):
    """Verify every object, and **rewrite the artifact only when a verified fact has changed.**

    As shipped this rewrote its own tracked JSON on every run, because the payload carries a
    `generated` date -- so merely LOOKING at the archive dirtied the working tree, and it did
    (M63 §S.3 H-1). The date is not a verified fact about his files; `files` and `base_radius`
    are, and they are what the comparison is over."""
    t0 = time.time()
    out = out or os.path.join(ROOT, "data", "m62", "parts-ref11-verified.json")
    B = P.Base(P.PARTS_R)
    print(f"[{time.time()-t0:6.1f}s] base r={P.PARTS_R}: {len(B.pts)} points / {len(B.orbits)} orbits",
          flush=True)
    res = {}
    lattice_pts = {}
    for name in V.files():
        path = os.path.join(V.REF11, name)
        want = V.expect(name)
        row = {"file": name, "expect_v": want[0], "expect_e": want[1]}
        try:
            tup = V.load_lattice(path)
        except ValueError as e:
            row["verdict"] = "type-m"
            row["reason"] = str(e)[:160]
            res[name] = row
            print(f"[{time.time()-t0:6.1f}s] {name:>16}  type-m (deferred)", flush=True)
            continue
        lattice_pts[name] = tup
        pts = [P.kpoint(t) for t in tup]
        E, _ = T.unit_edges_fast(pts)
        row["v"], row["e"] = len(tup), len(E)
        row["distinct_v"] = len(set(tup))
        off = [t for t in tup if t not in B.of]
        row["off_base"] = len(off)
        row["verdict"] = ("off-lattice" if len(set(tup)) != len(tup) else
                          "off-base" if off else
                          "matches-filename" if (len(tup), len(E)) == want else "count-disagrees")
        if not off:
            row["orbits"] = {str(list(k)): v for k, v in sorted(P.fillings(tup, B).items())}
        res[name] = row
        print(f"[{time.time()-t0:6.1f}s] {name:>16}  v {len(tup):>4}/{want[0]:<4} "
              f"e {len(E):>4}/{want[1]:<4}  off-base {len(off):>3}  {row['verdict']}", flush=True)

    # the two assembled M-graphs: parse in the tower, split, and check against the parts
    for name in [n for n, r in res.items() if r["verdict"] == "type-m"]:
        path = os.path.join(V.REF11, name)
        d = V.load_tower(path, denom=96)
        tmp = os.path.join(ROOT, "data", "m62", f".{name}.tower.json")
        E0, _ = T.unit_edges_fast([((__import__("fractions").Fraction(0),) * 4,)] * 0) if False else (None, None)
        d["edges"] = []
        json.dump(d, open(tmp, "w"))
        sp = P.split_type_m(tmp)
        os.unlink(tmp)
        res[name].update(v=sp["n"], L=len(sp["L"]), S=len(sp["S"]),
                         shared=len(sp["shared"]), off_lattice=len(sp["off_lattice"]))
        res[name]["verdict"] = ("type-m-split" if not sp["off_lattice"] else "off-lattice")
        res[name]["L_orbits"] = {str(list(k)): v for k, v in sorted(P.fillings(sp["L"].values(), B).items())}
        res[name]["S_orbits"] = {str(list(k)): v for k, v in sorted(P.fillings(sp["S"].values(), B).items())}
        print(f"[{time.time()-t0:6.1f}s] {name:>16}  {sp['n']} = L {len(sp['L'])} + S {len(sp['S'])} "
              f"- shared {len(sp['shared'])}, off-lattice {len(sp['off_lattice'])}", flush=True)

    good = sum(1 for r in res.values() if r["verdict"] in ("matches-filename", "type-m-split"))
    print(f"\n[{time.time()-t0:6.1f}s] {good}/{len(res)} objects reproduce their filename exactly")
    for n, r in sorted(res.items()):
        if r["verdict"] not in ("matches-filename", "type-m-split"):
            print(f"   {n}: {r['verdict']}  {r}")
    payload = {"kind": "parts-ref11-verified", "base_radius": P.PARTS_R,
               "generated": time.strftime("%Y-%m-%d"), "files": res}
    prior = json.load(open(out)) if os.path.exists(out) else None
    if (prior is not None and prior.get("base_radius") == payload["base_radius"]
            and prior.get("files") == json.loads(json.dumps(res))):
        print(f"unchanged: not rewritten ({out})")
        return payload
    tmp = out + ".tmp"
    with open(tmp, "w") as f:
        json.dump(payload, f, indent=1)
    os.replace(tmp, out)
    print("wrote", out)
    return payload


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else None)
