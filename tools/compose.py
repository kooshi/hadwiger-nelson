#!/usr/bin/env python3
"""compose — a composed descent object: the base object plus rotated copies of its unit part, as
ONE object file (M52 D9: a copy is one more recipe constructor, `('rot', centre, source, sign)`,
exact by construction — cos 7/8, sin ±√15/8 about an exact point; the copy of the centre IS the
centre, and every other coincidence is REFUSED, never fused).

    python3 tools/compose.py --base <label> --copies rot2:206:+ rot2:206:- rot2:0:+ rot2:0:-
    python3 tools/compose.py --self-test

Copies are of the base's ORIGINAL live points by default (`--source base`: the seed and its halos,
never earlier copies — the four-copy union of the Q8 record); `--source all` copies the copies too
(a different object; registered, not default). The output is `build/m50-object-<label>.json` with
`<label> = <base>+rot2-206p+…`, carrying the base's `removed` and `deleted` unchanged (the standing
cheats do not move: copy points are non-seed material), both fingerprints, and a row in
`build/m50-batch.json`. Controls, always run: `Obj.check()` re-derives every point from provenance
at 30 digits; the whole unit graph is asked at k = 4 (a ρ₁₅ copy of the it-4 object refuses four
colours — the copy-lock — while the bare seed's copy is SAT); the file is reloaded and its
fingerprints verified. UNTRUSTED, like everything in tools/: the certify re-derives geometry."""
from __future__ import annotations
import argparse, json, math, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from scipy.spatial import cKDTree
import batchkill as B
import coloring, forcer, rigidity
import twodist as T

COINCIDE = 1e-9   # float coincidence screen; a hit is then decided at 50 digits


def parse_copy(spec: str):
    """'rot2:206:+' -> (2, 206, +1). Only d = 2 (ρ₁₅) is a recipe kind today."""
    kind, centre, sign = spec.split(":")
    assert kind == "rot2", f"only the distance-2 spindle rotation is a recipe kind (got {kind})"
    centre = 0 if centre in ("v0", "0") else int(centre)
    assert sign in ("+", "-"), spec
    return 2, centre, +1 if sign == "+" else -1


def copy_tag(centre: int, sign: int) -> str:
    return f"rot2-{centre}{'p' if sign > 0 else 'm'}"


def compose(obj: B.Obj, copies, source: str = "base", log=print):
    """Append every copy to `obj` in place. Returns per-copy stats. Refuses a non-centre
    coincidence (the §Bʹ seam) and a deleted or out-of-range centre."""
    stats = []
    for _, centre, sign in copies:
        assert 0 <= centre < obj.n, ("centre out of range", centre)
        assert centre not in obj.deleted, ("centre is a deleted vertex", centre)
        srcs = [i for i in range(obj.n) if i not in obj.deleted
                and (source == "all" or obj.prov[i][0] != "rot")]
        P = np.array(obj.pts)
        imgs = np.array([B._rot_xy(obj.pts[centre], obj.pts[i], sign) for i in srcs])
        tree = cKDTree(P)
        d, j = tree.query(imgs, k=1)
        fused = 0; added = []
        n_before = obj.n
        for k, i in enumerate(srcs):
            if d[k] < COINCIDE:
                if i == centre and j[k] == centre:
                    fused += 1; continue
                # a non-centre coincidence: decide at 50 digits, then refuse — never fuse silently
                import mpmath as mp
                ex = obj.mp_values(50)
                img = ex[centre] + B._rot_mp(sign, mp) * (ex[i] - ex[centre])
                gap = abs(img - ex[int(j[k])])
                raise AssertionError(f"copy of {i} about {centre} sign {sign:+d} coincides with existing "
                                     f"point {int(j[k])} (gap {mp.nstr(gap, 5)} at 50 digits) — refused (M52 §Bʹ)")
            added.append(obj.add_rot(centre, i, sign))
        stats.append(dict(tag=copy_tag(centre, sign), centre=centre, sign=sign, sources=len(srcs),
                          added=len(added), fused=fused, first_index=n_before, last_index=obj.n - 1))
        log(f"[compose] {copy_tag(centre, sign)}: {len(srcs)} sources -> {len(added)} points added, {fused} fused (the centre)")
    return stats


def chord_census(obj: B.Obj, ue):
    """Edges by class: original–original, within one copy, original–copy (cross), copy–copy (cross
    between different copies). Copy id = (centre, sign) from provenance."""
    cid = {}
    for i, rec in enumerate(obj.prov):
        if rec[0] == "rot":
            cid[i] = (rec[1], rec[3])
    per = {}
    orig = within = cross_oc = cross_cc = 0
    for u, v in ue:
        a, b = cid.get(u), cid.get(v)
        if a is None and b is None:
            orig += 1
        elif a is not None and b is not None:
            if a == b:
                within += 1; per.setdefault(a, [0, 0, 0])[0] += 1
            else:
                cross_cc += 1; per.setdefault(a, [0, 0, 0])[2] += 1; per.setdefault(b, [0, 0, 0])[2] += 1
        else:
            cross_oc += 1; per.setdefault(a or b, [0, 0, 0])[1] += 1
    return dict(original=orig, within_copies=within, cross_original_copy=cross_oc, cross_copy_copy=cross_cc,
                per_copy={copy_tag(c, s): dict(within=w, cross_to_original=x, cross_to_other_copies=y)
                          for (c, s), (w, x, y) in per.items()})


def ask_k4(n, edges, cap):
    cls = coloring.base_clauses(n, edges, 4) + rigidity.amo_clauses(n, 4)
    cls += T._brk_full(n, 4, T._degree_order(n, edges))
    t0 = time.time()
    st, _ = forcer._solve(cls, n * 4, cap)
    return st, time.time() - t0


def write_object(obj: B.Obj, label: str, removed):
    ue = obj.unit_edges()
    standing = [e for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    d = {"prov": obj.prov[214:], "removed": [list(e) for e in removed],
         **({"deleted": sorted(obj.deleted)} if obj.deleted else {}),
         "fingerprint": obj.fingerprint(removed), "fingerprint_bare": obj.fingerprint(),
         "n": obj.n, "unit": len(ue), "cheats": len(standing)}
    (B.BUILD / f"m50-object-{label}.json").write_text(json.dumps(d))
    return d


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base")
    ap.add_argument("--copies", nargs="*", default=[])
    ap.add_argument("--source", choices=["base", "all"], default="base")
    ap.add_argument("--label", default=None)
    ap.add_argument("--cap", type=float, default=300.0, help="k = 4 control cap (s)")
    ap.add_argument("--no-k4", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    t0 = time.time()
    obj, removed = B.load_object(a.base)
    copies = [parse_copy(c) for c in a.copies]
    label = a.label or a.base + "".join("+" + copy_tag(c, s) for _, c, s in copies)
    print(f"[compose] base {a.base}: n={obj.n} live={obj.n - len(obj.deleted)} standing cheats="
          f"{len([e for e in obj.cheats if tuple(e) not in set(map(tuple, removed))])}", flush=True)
    stats = compose(obj, copies, a.source)
    obj.check(30)                                   # every point re-derived from provenance
    ue = obj.unit_edges()
    census = chord_census(obj, ue)
    print(f"[compose] {label}: n={obj.n}, unit edges {len(ue)} = {census['original']} original + "
          f"{census['within_copies']} within copies + {census['cross_original_copy']} original–copy chords + "
          f"{census['cross_copy_copy']} copy–copy chords", flush=True)
    k4 = None
    if not a.no_k4:
        st, secs = ask_k4(obj.n, ue, a.cap)
        k4 = dict(verdict=st, secs=round(secs, 1))
        print(f"[compose] k = 4 on the whole unit graph: {st.upper()} ({secs:.1f}s)"
              + ("  — the copy-lock: a 5-chromatic unit graph (tools level)" if st == "unsat" else ""), flush=True)
    d = write_object(obj, label, removed)
    obj2, removed2 = B.load_object(label)           # reload: both fingerprints verified by the loader
    assert obj2.n == obj.n and obj2.fingerprint(removed2) == d["fingerprint"]
    row = {"kind": "compose", "label": label, "base": a.base, "copies": stats, "source": a.source,
           "n": obj.n, "unit": len(ue), "cheats": d["cheats"], "census": census, "k4": k4,
           "fingerprint": d["fingerprint"], "fingerprint_bare": d["fingerprint_bare"],
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "the composed object as an object file; copies exact by recipe (rho15 about an "
           "exact point), unit census at 1e-7 (the certify re-derives at 250 digits); k4 verdict is a "
           "tools-level control on the whole unit graph"}
    T.record(B.BUILD / "m50-batch.json", row)
    print(f"[compose] wrote build/m50-object-{label}.json (fp {d['fingerprint']}, bare {d['fingerprint_bare']}) [{time.time()-t0:.0f}s]")


def self_test():
    """Green: the bare seed plus one ρ₁₅ copy about 206 composes, checks, reloads, and its unit
    graph is SAT at four colours (the Q8 control: no lock on the seed alone). Red: a deleted centre
    is refused; a planted coincidence (copy about a point onto its own mirror twin) is refused."""
    t0 = time.time()
    obj = B.Obj(); removed = []
    stats = compose(obj, [(2, 206, +1)])
    obj.check(30)
    ue = obj.unit_edges(); census = chord_census(obj, ue)
    st, secs = ask_k4(obj.n, ue, 120)
    assert st == "sat", ("the bare seed's copy must be 4-colourable (Q8 control)", st)
    label = "selftest-compose"
    d = write_object(obj, label, removed)
    obj2, _ = B.load_object(label)
    assert obj2.n == obj.n and obj2.fingerprint() == d["fingerprint_bare"]
    print(f"[self-test] green: seed+rot2-206p n={obj.n} chords={census['cross_original_copy']} k4=SAT ({secs:.1f}s), reload ok")
    # red 1: a deleted centre
    o3 = B.Obj(); o3.delete_vertices([13])
    try:
        compose(o3, [(2, 13, +1)]); raise SystemExit("red 1 FAILED: deleted centre accepted")
    except AssertionError as e:
        print(f"[self-test] red 1 seen: {str(e)[:60]}")
    # red 2: a planted coincidence — rotate about 206 by + then compose the SAME copy again with
    # --source all: every copy point's image coincides with... no: compose the '-' copy of the '+'
    # copy: R⁻(R⁺(p)) = p lands on the original — a non-centre coincidence, refused.
    o4 = B.Obj(); compose(o4, [(2, 206, +1)])
    try:
        compose(o4, [(2, 206, -1)], source="all"); raise SystemExit("red 2 FAILED: coincidence accepted")
    except AssertionError as e:
        print(f"[self-test] red 2 seen: {str(e)[:90]}")
    (B.BUILD / f"m50-object-{label}.json").unlink()
    print(f"[self-test] PASS [{time.time()-t0:.0f}s]")


if __name__ == "__main__":
    main()
