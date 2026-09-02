#!/usr/bin/env python3
"""copy_kill_table — the copy lock's finite intrinsic form (M52 §Bʹ item 3): two projected colouring
sets and a disjointness table, on a 1-minimal core of U ∪ R(U).

    python3 tools/copy_kill_table.py --object <label of the composed object> --core <core json> [--cap N]

A 4-colouring of the union is a PAIR (σ, τ): σ colours the original side S₁ (the core's original
points), τ colours the copy side S₂ ∪ {c} (the core's copy points plus the fused centre), and they
are coupled only by σ(c) = τ(c) (fix both to colour 0 — the one palette symmetry spent) and by the
cross chords p–q (p ∈ S₁∖{c}, q ∈ S₂): σ(p) ≠ τ(q). The union refuses four colours iff every pair
(σ, τ) is killed by some chord. So: enumerate Σ = the projections of proper 4-colourings of U[S₁]
onto the chord endpoints P ⊆ S₁ (blocking clauses on the projection, a long-lived CaDiCaL), T
likewise for the copy side onto Q ⊆ S₂, and write the table: |Σ|, |T|, for every (σ, τ) the set of
chords killing it (must be nonempty — a pair with NO killer is a 4-colouring of the union and the
core is not a core), and per chord the number of pairs it kills ALONE (its load-bearing count).
Then Act One, read off Σ: the colour patterns every σ wears on the load-bearing points.
Enumerations are capped (`--cap`) and a capped set is reported as capped — the table is then a
lower bound on Σ × T, never a verdict. UNTRUSTED like all of tools/."""
from __future__ import annotations
import argparse, collections, itertools, json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as B
import coloring

K = 4
OUT = Path(__file__).resolve().parent.parent / "data" / "m52"


def enumerate_projections(vertices, edges, centre, proj, cap):
    """All proper K-colourings of the graph (vertices, edges) with colour(centre) = 0, projected onto
    `proj` (a list of vertices), as a set of tuples; blocked on the projection after each model."""
    from pysat.solvers import Cadical195
    idx = {v: i for i, v in enumerate(vertices)}
    n = len(vertices)
    cls = coloring.base_clauses(n, [(idx[u], idx[v]) for u, v in edges], K)
    cls += [[-coloring.var(i, a, K), -coloring.var(i, b, K)] for i in range(n) for a in range(K) for b in range(a + 1, K)]
    cls.append([coloring.var(idx[centre], 0, K)])
    s = Cadical195(bootstrap_with=cls)
    out = set(); capped = False
    while s.solve():
        m = s.get_model(); pos = {l for l in m if l > 0}
        col = tuple(next(c for c in range(K) if coloring.var(idx[v], c, K) in pos) for v in proj)
        out.add(col)
        s.add_clause([-coloring.var(idx[v], c, K) for v, c in zip(proj, col)])
        if len(out) >= cap:
            capped = True; break
    s.delete()
    return out, capped


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--core", required=True)
    ap.add_argument("--centre", type=int, default=206); ap.add_argument("--cap", type=int, default=200000)
    a = ap.parse_args()
    t0 = time.time()
    obj, removed = B.load_object(a.object)
    core = json.load(open(a.core))
    C = set(core["core"]); cedges = [tuple(e) for e in core["edges"]]
    ue = set(map(tuple, obj.unit_edges()))
    assert all(tuple(sorted(e)) in ue for e in cedges), "core edges must be unit edges of the composed object"
    cid = {i: (rec[1], rec[3]) for i, rec in enumerate(obj.prov) if rec[0] == "rot"}
    src = {i: rec[2] for i, rec in enumerate(obj.prov) if rec[0] == "rot"}
    c = a.centre
    S1 = sorted(v for v in C if v not in cid)                       # originals, incl. the centre
    S2 = sorted(v for v in C if v in cid)
    e1 = [e for e in cedges if e[0] in set(S1) and e[1] in set(S1)]
    side2 = set(S2) | {c}
    e2 = [e for e in cedges if e[0] in side2 and e[1] in side2 and not (e[0] not in cid and e[1] not in cid)]
    cross = [(u, v) if u not in cid else (v, u) for u, v in cedges
             if ((u in cid) != (v in cid)) and u != c and v != c]     # (p original ≠ centre, q copy)
    P = sorted({p for p, _ in cross}); Q = sorted({q for _, q in cross})
    print(f"[kill] core {len(C)} = {len(S1)} original + {len(S2)} copy; edges side1 {len(e1)}, side2 {len(e2)} (with the fused centre), "
          f"cross {len(cross)}; chord endpoints P {len(P)} / Q {len(Q)}", flush=True)
    Sigma, cap1 = enumerate_projections(S1, e1, c, P, a.cap)
    print(f"[kill] |Σ| = {len(Sigma)}{' (CAPPED)' if cap1 else ''} projections of side-1 colourings onto P [{time.time()-t0:.0f}s]", flush=True)
    Tau, cap2 = enumerate_projections(sorted(side2), e2, c, Q, a.cap)
    print(f"[kill] |T| = {len(Tau)}{' (CAPPED)' if cap2 else ''} projections of side-2 colourings onto Q [{time.time()-t0:.0f}s]", flush=True)
    pi = {p: i for i, p in enumerate(P)}; qi = {q: i for i, q in enumerate(Q)}
    chord_idx = [(pi[p], qi[q]) for p, q in cross]
    alone = collections.Counter(); unkilled = 0; total = 0; killer_hist = collections.Counter()
    Sigma_l = sorted(Sigma); Tau_l = sorted(Tau)
    for sg in Sigma_l:
        for ta in Tau_l:
            total += 1
            killers = [k for k, (i, j) in enumerate(chord_idx) if sg[i] == ta[j]]
            killer_hist[len(killers)] += 1
            if not killers:
                unkilled += 1
            elif len(killers) == 1:
                alone[cross[killers[0]]] += 1
    print(f"[kill] pairs {total}: unkilled {unkilled} (must be 0 for a refuting core), killer-count histogram {sorted(killer_hist.items())[:8]}", flush=True)
    lb = sorted(alone.items(), key=lambda kv: -kv[1])
    print(f"[kill] chords that are the SOLE killer of some pair: {len(lb)} of {len(cross)}; top: " +
          ", ".join(f"{p}–{q}(src {src[q]}): {n}" for (p, q), n in lb[:8]), flush=True)
    # Act One on the load-bearing points, read from Σ
    lbp = sorted({p for (p, q), _ in lb} | {src[q] for (p, q), _ in lb})
    lbp_in_P = [p for p in lbp if p in pi]
    patt = collections.Counter(tuple(sg[pi[p]] for p in lbp_in_P) for sg in Sigma_l)
    print(f"[kill] Act One on the sole-killer points {lbp_in_P} (as read in Σ): {len(patt)} distinct patterns; "
          f"top: {patt.most_common(6)}", flush=True)
    out = dict(kind="copy-kill-table", object=a.object, core=a.core, centre=c, S1=len(S1), S2=len(S2),
               cross=[(p, q, src[q]) for p, q in cross], P=P, Q=Q, Sigma=len(Sigma), Tau=len(Tau), capped=[cap1, cap2],
               pairs=total, unkilled=unkilled, killer_hist={str(k): v for k, v in sorted(killer_hist.items())},
               sole_killers={f"{p}-{q}": n for (p, q), n in lb}, sole_killer_points=lbp_in_P,
               act_one_patterns={str(k): v for k, v in patt.most_common(40)},
               sigma_list=[list(sg) for sg in Sigma_l] if len(Sigma_l) <= 5000 else None,
               tau_list=[list(ta) for ta in Tau_l] if len(Tau_l) <= 5000 else None,
               seconds=round(time.time() - t0, 1),
               claim_scope="projections enumerated by blocking on a long-lived solver with colour(centre) = 0; "
                           "a capped set makes the table a lower bound; unkilled = 0 is the refutation re-read")
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f"killtable-{Path(a.core).stem}.json").write_text(json.dumps(out))
    print(f"[kill] wrote {OUT / ('killtable-' + Path(a.core).stem + '.json')} [{time.time()-t0:.0f}s]")


if __name__ == "__main__":
    main()
