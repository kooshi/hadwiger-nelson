#!/usr/bin/env python3
"""Two diagnostics that must not be produced by scratch scripts, and one of them is a calibration.

M63 phase C's audit recorded, as an instrument defect, that *"both reduction records and two M64
artifacts were produced by uncommitted scripts"* (§S.2 #12). These two numbers are cited in phase
D's record, so they get a committed producer.

**card28** -- *does his own four-orbit move score as an outlier?* (Poros card 28, 2026-09-11.)

  The expansion rule's look-ahead reads how many NECESSARY atoms an expansion frees, and at the
  held-out accumulator it reads zero on every single orbit tried -- including on orbits his own
  recorded move used. Poros's objection, adopted: an atom `a` is necessary because `W - a` is
  four-colourable, so to free it `(W u D) - a` must refuse -- and **in that graph every edge from
  the new material `D` to `a` has vanished along with `a`.** Adjacency to `a` therefore contributes
  nothing; what must happen is that `D` does `a`'s job on `a`'s NEIGHBOURHOOD. Sharpened, and
  pleasingly it is his own admission rule pointed at one atom's neighbourhood instead of at the
  whole accumulator:

      a new vertex `v` SERVES a correction set `C` when, for some `a` in `C`,
      `|N(v) n N(a) n A| >= 4`.

  Two rival statistics over the small (size 2-3) correction sets, both solver-free:
  **union** coverage of what a set of orbits serves (Poros's reading: different constraints need
  different substitutes, so union is progress) against **overlap** (the implementer's reading:
  shared coverage is promotion). His recorded four-orbit move from `A403` -- `(0,0,0,4)`,
  `(0,0,6,6)` and the missing halves of `(0,0,2,2)` and `(0,0,2,6)` -- is the ONE labelled positive
  anyone holds for a set-valued expansion, so it is the calibration bed: a statistic that cannot
  tell it from a random four-subset cannot be expected to find anything among 635,376 of them.

  **This is a DIAGNOSTIC and it may not feed the frozen rule.** It is computed from his labelled
  move; letting it choose the running rule's set-valued rung is exactly the contamination the
  freeze exists to prevent, and clause 2(b) would be worthless. It is pre-registered for a
  SUCCESSOR rule, with its calibration already done.

**fs35** -- FS-35's two look-ahead quantities at a state: the exchange-class vector and the
per-rung orbit-closure bound (`parts_faces.exchange_classes` via `analyse`, and `orbit_closure`).

    python3 tools/parts_diag.py card28 --out build/m63d2/card28.json
    python3 tools/parts_diag.py fs35   --out build/m63d2/fs35-1-375.json
"""
from __future__ import annotations
import argparse, itertools, json, os, random, sys, time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_repro as P
import parts_stage as PS
import parts_vtx as V
import parts_faces as F
import parts_loop as PL
import parts_rule as PR

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REF11 = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
RECORD = os.path.join(ROOT, "data", "m62", "m63-L451-reduction.json")
HIS_MOVE = [(0, 0, 0, 4), (0, 0, 6, 6), (0, 0, 2, 2), (0, 0, 2, 6)]   # M63 §S.2 #9
SEED = 20260911


def _state(log=print):
    """The 375-level state: the stage that produced it, its accumulator, its level."""
    base = P.Base(P.PARTS_R)
    st = PS.Stage(base, V.load_lattice(os.path.join(REF11, "v451e2400.vtx")),
                  V.load_lattice(os.path.join(REF11, "v136e564.vtx")), side="L", rung=1, pin=True)
    rec = json.load(open(RECORD))
    if st.fingerprint() != rec["stage_fingerprint"]:
        raise SystemExit("the stored record was not produced by this stage")
    A = sorted({tuple(st.atom_labels[i][1]) for i in rec["A"]} |
               {tuple(st.keys[st.A.centre])})
    return base, st, rec, A


def card28(*, samples=2000, degree=4, mode="exists", log=print) -> dict:
    """`mode` is Poros's card 29, and the correction is his own.

    The criterion above was stated for SINGLETON correction sets, where `C = {a}` and *exists* and
    *for all* coincide. It does not extend to pairs and triples by *exists*: widening `C` means
    `(W u D) - C` still refuses, so `D` must compensate for the WHOLE of `C`, and serving one
    member of a pair does not let both be deleted. So `mode="exists"` measures something strictly
    weaker than widening, and `mode="forall"` -- every member of `C` served by some vertex of the
    added set -- is the faithful form. The 215 sets of size 2-3 are exactly where the two differ.
    """
    t0 = time.time()
    base, st, rec, A = _state(log=log)
    tup = {i: tuple(st.atom_labels[i][1]) for i in range(len(st.atom_labels))}
    small = [frozenset(tup[a] for a in s) for s in rec["hypergraph"]["sets"] if 2 <= len(s) <= 3]
    comp = V.load_lattice(os.path.join(REF11, "v136e564.vtx"))
    orc = PL.EdgeOracle(base, comp, log=lambda *a: None)
    adj, Aset = orc.adj_LL, set(A)
    Nin = {a: (adj[a] & Aset) for s in small for a in s}
    census = PL.menu_census(base, A, orc, log=lambda *a: None)
    cands = PL.menu_candidates(base, A, census, reading=PR.READING)
    by_orbit = {}
    for c in cands:
        o = c.orbits(base)
        if len(o) == 1:
            by_orbit[next(iter(o))] = c

    def serves_atom(c, a):
        return any(len(adj[v] & Nin[a]) >= degree for v in c.vertices)

    def served(c):
        q = all if mode == "forall" else any
        return {j for j, s in enumerate(small) if q(serves_atom(c, a) for a in s)}

    sv = {c.name(base): served(c) for c in cands}
    his = [by_orbit[o] for o in HIS_MOVE if o in by_orbit]
    if len(his) != len(HIS_MOVE):
        raise SystemExit(f"only {len(his)} of his four orbits are in the menu at this state")

    def union(cs):
        return len(set().union(*[sv[c.name(base)] for c in cs]))

    def overlap(cs):
        S = [sv[c.name(base)] for c in cs]
        return sum(len(S[i] & S[j]) for i, j in itertools.combinations(range(len(S)), 2))

    hu, ho = union(his), overlap(his)
    rng = random.Random(SEED)
    us, os_ = [], []
    for _ in range(samples):
        s = rng.sample(cands, 4)
        us.append(union(s))
        os_.append(overlap(s))
    pu = sum(1 for x in us if x < hu) / len(us)
    po = sum(1 for x in os_ if x < ho) / len(os_)
    out = {"kind": "m63-card28", "schema": 1, "producer": "tools/parts_diag.py:card28",
           "question": "does his own four-orbit move score as an outlier on union coverage, on "
                       "overlap, or on neither, against random four-subsets of the menu?",
           "criterion": f"a new vertex v SERVES an atom a when |N(v) n N(a) n A| >= {degree}; a "
                        f"correction set C counts when {'EVERY' if mode == 'forall' else 'SOME'} "
                        f"member of C is served by some vertex of the added set",
           "quantifier": mode,
           "his_move": [list(o) for o in HIS_MOVE],
           "menu": len(cands), "small_correction_sets": len(small),
           "mean_served_per_orbit": round(sum(len(v) for v in sv.values()) / len(sv), 2),
           "union": hu, "overlap": ho, "samples": samples, "seed": SEED,
           "random_union_mean": round(sum(us) / len(us), 2), "random_union_max": max(us),
           "random_overlap_mean": round(sum(os_) / len(os_), 3), "random_overlap_max": max(os_),
           "union_percentile": pu, "overlap_percentile": po,
           "verdict": ("outlier-on-union" if pu >= 0.95 else
                       "outlier-on-overlap" if po >= 0.95 else "outlier-on-neither"),
           "reading": ("overlap is DEGENERATE -- random four-subsets average zero and nothing can "
                       "score below zero, so it discriminates nothing. Union is directionally "
                       "right and too weak to pre-register: about one random four-subset in five "
                       "beats his own recorded move. So both statistics die cheaply and the "
                       "set-valued rung is HIS craft rather than ours."),
           "caveat": ("the statistic is sparse -- the mean orbit serves about one of the small "
                      "correction sets -- so these are small-number comparisons with a wide "
                      "interval. Enough to kill overlap and to decline union; not enough to call "
                      "union uninformative in principle."),
           "may_not_feed_the_frozen_rule": ("computed from his labelled move; it is pre-registered "
                                            "for a SUCCESSOR rule and did not touch the running "
                                            "one, whose freeze predates it"),
           "seconds": round(time.time() - t0, 1)}
    log(f"  his move: union {hu} (p{pu:.2f}), overlap {ho} (p{po:.2f})  ->  {out['verdict']}")
    return out


def fs35(*, log=print) -> dict:
    """FS-35's two quantities at our 375 state, both solver-free."""
    t0 = time.time()
    base, st, rec, A = _state(log=log)
    an = F.analyse(base, st, rec, ask=None, log=lambda *a: None)
    oc = F.orbit_closure(base, st, rec)
    out = {"kind": "m63-fs35-1", "schema": 1, "producer": "tools/parts_diag.py:fs35",
           "state": "our 375 level (A403, companion v136e564, rung 1)",
           "exchange_classes": an["shape"]["exchange_classes"],
           "affine_dim": an["shape"]["affine_dim"], "hull": an["shape"]["hull"],
           "atom_classes": an["atom_classes"],
           "orbit_closure": [{k: r[k] for k in ("order", "invariant_minima", "min_closure",
                                                "closure_excess", "upper_bound_on_M_H")}
                             for r in oc["rungs"]],
           "seconds": round(time.time() - t0, 1)}
    log(f"  exchange classes {len(out['exchange_classes'])}, "
        f"{len(out['orbit_closure'])} rungs with closure bounds")
    return out


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd")
    for name in ("card28", "fs35"):
        p = sub.add_parser(name)
        p.add_argument("--out")
        if name == "card28":
            p.add_argument("--forall", action="store_true",
                           help="card 29: every member of a correction set served, not merely one")
    a = ap.parse_args()
    if a.cmd == "card28":
        r = card28(mode="forall" if a.forall else "exists")
    elif a.cmd == "fs35":
        r = fs35()
    else:
        ap.print_help()
        return 1
    if a.out:
        os.makedirs(os.path.dirname(a.out) or ".", exist_ok=True)
        json.dump(r, open(a.out, "w"), indent=1)
        print(f"  wrote {a.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
