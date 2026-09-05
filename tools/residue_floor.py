#!/usr/bin/env python3
"""residue_floor — the residue-type obstruction to IN-FIELD descent, computed exactly (2026-09-05).

Theorem (the field-wall note §7.2, sharpened here): let Γ = (V, unit edges, cheats C) be a K-point
{1,2}-graph forcing A ≡ B at five colours, K = ℚ(√3, √11). For a cheat subset C' ⊆ C consider the
2-SAT system Σ(C'): variables x_v (v a seed vertex); x_u ⊕ x_v for each cheat {u,v} ∈ C'; ¬(x_u ∧ x_v)
for each unit edge {u,v} among seed vertices; ¬(x_A ∧ x_B). If Σ(C') is satisfiable, the residue
4-colouring r (Theorem B) with the fifth colour on S = {v : x_v} is a proper 5-colouring of
unit ∪ C' that separates A from B, and it stays one after adjoining ANY finite set of K-points
(colour them by r): no in-field halo can ever make C' force. So every in-field-reachable standing
set has Σ UNSAT — in particular it contains an odd cycle of the cheat graph, or a side-choice
conflict. The XOR part is satisfiable iff every component of the cheat graph (V, C') is bipartite.

    python3 tools/residue_floor.py --object <label> --sidecar build/m51-edges-<label>+cull149.json
        [--batch-dir build/m53-batch/<label>-cull149/step01-b2 --verdicts build/m53-p0/replay-infield-b2/verdicts.jsonl]

Reports: the cheat graph's components and bipartiteness for the seed (446), the live set (344) and
the standing set; Σ for the standing set, for every single-cheat removal, and for the named batch;
the shortest odd cycle; and (optional) whether any in-field SURVIVOR class of a batch replay is
residue-type — predicted 0 whenever the remaining standing set keeps an odd cycle. UNTRUSTED like
all of tools/.
"""
from __future__ import annotations
import argparse, json, sys, time
from collections import defaultdict, deque
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))

ROOT = Path(__file__).resolve().parent.parent


def components(edges):
    adj = defaultdict(set)
    for a, b in edges:
        adj[a].add(b); adj[b].add(a)
    seen = {}; out = []
    for s in adj:
        if s in seen:
            continue
        seen[s] = 0; stack = [s]; comp = {s}; bip = True
        while stack:
            u = stack.pop()
            for w in adj[u]:
                if w not in seen:
                    seen[w] = 1 - seen[u]; comp.add(w); stack.append(w)
                elif seen[w] == seen[u]:
                    bip = False
        out.append((sorted(comp), bip))
    return sorted(out, key=lambda c: -len(c[0]))


def shortest_odd_cycle(edges):
    adj = defaultdict(set)
    for a, b in edges:
        adj[a].add(b); adj[b].add(a)
    best = None
    for s in adj:
        lvl = {s: 0}; q = deque([s])
        while q:
            u = q.popleft()
            for w in adj[u]:
                if w not in lvl:
                    lvl[w] = lvl[u] + 1; q.append(w)
                elif lvl[w] == lvl[u]:
                    L = 2 * lvl[u] + 1
                    if best is None or L < best:
                        best = L
    return best


def sigma_sat(cheats, seed_unit, A, B):
    """Σ(C'): returns (sat: bool, S: list | None)."""
    from pysat.solvers import Solver
    var = {}
    def x(v):
        if v not in var:
            var[v] = len(var) + 1
        return var[v]
    cl = []
    for u, v in cheats:
        cl.append([x(u), x(v)]); cl.append([-x(u), -x(v)])
    for u, v in seed_unit:
        cl.append([-x(u), -x(v)])
    cl.append([-x(A), -x(B)])
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        ok = s.solve()
        if not ok:
            return False, None
        m = set(l for l in s.get_model() if l > 0)
        return True, sorted(v for v, i in var.items() if i in m)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--sidecar", required=True)
    ap.add_argument("--batch-dir", default=None); ap.add_argument("--verdicts", default=None)
    ap.add_argument("--result", default=None)
    a = ap.parse_args()
    t0 = time.time()
    import twodist as T
    H = T.ei_H(); cls = T.classify(H, radii=(1, 4))
    A, B = H.index(T.EI_A), H.index(T.EI_B)
    sc = json.loads(Path(a.sidecar).read_text())
    live = set(sc["seed_live"]); removed = set(map(tuple, sc["removed"]))
    cheats_live = [tuple(e) for e in sc["cheats"]]
    standing = [e for e in cheats_live if e not in removed]
    seed_unit = [e for e in cls[1] if e[0] in live and e[1] in live]
    assert (A, B) == tuple(sc["forced_pair"]), (A, B, sc["forced_pair"])
    out = {"kind": "residue-floor", "object": a.object, "sidecar": a.sidecar, "live": len(live),
           "seed_unit_live": len(seed_unit), "standing": len(standing)}
    print(f"[floor] live seed vertices {len(live)}, unit edges among them {len(seed_unit)}, standing cheats {len(standing)}, A={A} B={B}")

    for name, C in (("seed-446", cls[4]), ("live-344", cheats_live), ("standing", standing)):
        comps = components(C)
        nb = sum(1 for _, b in comps if not b)
        soc = shortest_odd_cycle(C)
        print(f"[floor] {name}: {len(C)} cheats on {sum(len(c) for c, _ in comps)} vertices; components {len(comps)}, "
              f"non-bipartite {nb} (sizes {[len(c) for c, b in comps if not b]}); shortest odd cycle {soc}")
        out[name] = {"cheats": len(C), "components": len(comps), "non_bipartite": nb,
                     "non_bipartite_sizes": [len(c) for c, b in comps if not b], "shortest_odd_cycle": soc}
    sat, S = sigma_sat(standing, seed_unit, A, B)
    print(f"[floor] Σ(standing): {'SAT — CONTRADICTS the certificate (a residue-type separating colouring exists)' if sat else 'UNSAT (as the certificate requires)'}")
    out["sigma_standing"] = {"sat": sat, "S": S}
    # every single-cheat removal
    blocked = []
    for e in standing:
        s1, S1 = sigma_sat([c for c in standing if c != e], seed_unit, A, B)
        if s1:
            blocked.append([list(e), S1])
    print(f"[floor] single removals with Σ SAT (cheats no in-field halo can ever remove): {len(blocked)} of {len(standing)}")
    out["single_blocked"] = blocked
    # the named batch, if any
    if a.batch_dir:
        hdr = json.loads(Path(a.batch_dir, "classes.jsonl").open().readline())
        batch = [tuple(e) for e in hdr["batch"]]
        floor = [e for e in batch if e in standing]  # the batch list is every removed+floor cheat; the floor ones are the standing ones
        rest = [c for c in standing if c not in floor]
        comps = components(rest); nb = sum(1 for _, b in comps if not b)
        s2, S2 = sigma_sat(rest, seed_unit, A, B)
        print(f"[floor] batch floor {floor}: remaining standing {len(rest)}, non-bipartite components {nb}, shortest odd cycle {shortest_odd_cycle(rest)}, Σ {'SAT' if s2 else 'UNSAT'}")
        out["batch"] = {"floor": [list(e) for e in floor], "remaining": len(rest), "non_bipartite": nb, "sigma_sat": s2, "S": S2}
    # residue-type scan of survivors
    if a.batch_dir and a.verdicts:
        import batchkill as BK, residue_colouring as RC
        obj, _ = BK.load_object(a.object)
        ex = json.loads((ROOT / "data" / "m52" / f"exact-{a.object}.json").read_text())["points"]
        def four(v):
            A_, B_ = v; assert all(nn == 0 for nn, dd in B_)
            return tuple(Fr(nn, dd) for nn, dd in A_)
        pts = {int(i): (four(ex[i]["x"]), four(ex[i]["y"])) for i in ex if int(i) not in obj.deleted}
        ue = [tuple(e) for e in obj.unit_edges()]
        rcols = {}
        for start in (17, 256 - 17):
            col, _ = RC.colour(pts, ue, RC.sqrt33_2adic(start))
            rcols[start] = col
        verdict = {}
        for line in Path(a.verdicts).read_text().splitlines():
            if line.startswith("#") or not line.strip():
                continue
            i, v = line.split()[:2]; verdict[int(i)] = v
        surv = sorted(i for i, v in verdict.items() if v != "killed")
        vcount = defaultdict(int)
        for v in verdict.values(): vcount[v] += 1
        print(f"[floor] verdicts: {dict(vcount)}; scanning {len(surv)} non-killed classes for residue type")
        livelist = sorted(live)
        def is_residue_type(colstr, col):
            # some colour c is the 'fifth'; on the other vertices colour must be an injective function of the residue
            for c in "01234":
                f = {}; ok = True
                for v in livelist:
                    if colstr[v] == c:
                        continue
                    rv = col[v]
                    if rv in f and f[rv] != colstr[v]:
                        ok = False; break
                    f[rv] = colstr[v]
                if ok and len(set(f.values())) == len(f):
                    return c
            return None
        hits = []
        with Path(a.batch_dir, "classes.jsonl").open() as fh:
            next(fh)
            for idx, line in enumerate(fh):
                if idx not in verdict:
                    continue
                s = json.loads(line) if line.startswith('"') else line.strip()
                for start, col in rcols.items():
                    c = is_residue_type(s, col)
                    if c is not None:
                        hits.append([idx, verdict[idx], start, c])
        print(f"[floor] residue-type classes among ALL listed classes: {len(hits)} (among survivors: {sum(1 for h in hits if h[1] != 'killed')})")
        out["residue_type_hits"] = hits; out["verdict_counts"] = dict(vcount)
    out["seconds"] = round(time.time() - t0, 1)
    if a.result:
        Path(a.result).write_text(json.dumps(out, indent=1)); print(f"[floor] wrote {a.result}")


if __name__ == "__main__":
    main()
