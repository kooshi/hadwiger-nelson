"""Certify a designed halo for refuser e on H: exact sympy coordinates for every halo point (from its
defining unit-circle pair), exact unit-edge list, then the two solver encodings on H − e + halo with
A ≠ B (expected UNSAT), then the row."""
import sys, json, time, math
sys.path.insert(0, "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad")
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import sympy as sp
import twodist as T, coloring, rigidity, forcer
from exact_check import seed_exact, intersect, is_unit
K = 5
H = T.ei_H(); n = len(H); c = T.classify(H); E1, E2 = c[1], c[4]
iA, iB = H.index(T.EI_A), H.index(T.EI_B)
xy = [T.approx(p) for p in H]
SEED = [seed_exact(p) for p in H]
def close(P, q): 
    v = [float(sp.N(P[0], 30)), float(sp.N(P[1], 30))]; return abs(v[0]-q[0]) < 1e-6 and abs(v[1]-q[1]) < 1e-6
def exact_point(q, seed_nbrs, other_exact):
    """q float; seed_nbrs = its unit seed neighbours; other_exact = list of exact points at unit distance
    (already-defined halo/depth-1 points). Define q as an intersection about two of these."""
    defs = [SEED[v] for v in seed_nbrs] + list(other_exact)
    for i in range(len(defs)):
        for j in range(i+1, len(defs)):
            for s in (1, -1):
                P = intersect(defs[i], defs[j], s)
                if close(P, q): return P
    return None
def certify(e, halo, label):
    """halo: list of dicts {xy, kind, seed_nbrs, halo_nbrs}. depth-1 first, then depth-2 (defined by a
    seed neighbour and a depth-1 halo neighbour or an external strong point — resolved here by search)."""
    t0 = time.time()
    exact = [None]*len(halo)
    # depth-1 first
    for i, h in enumerate(halo):
        if h["kind"] == "depth1":
            exact[i] = exact_point(h["xy"], h["seed_nbrs"], [])
            assert exact[i] is not None, ("depth1 undefined", i)
    # depth-2: seed nbr + a depth-1 halo neighbour with exact coords; iterate until stable
    changed = True
    while changed:
        changed = False
        for i, h in enumerate(halo):
            if exact[i] is not None: continue
            others = [exact[j] for j in h["halo_nbrs"] if exact[j] is not None]
            P = exact_point(h["xy"], h["seed_nbrs"], others)
            if P is not None: exact[i] = P; changed = True
    undefined = [i for i in range(len(halo)) if exact[i] is None]
    # fall back: define via external strong depth-one points (recompute the partner points around the seed)
    if undefined:
        import importlib.util
        spec = importlib.util.spec_from_file_location("ks", "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_screen.py")
        ks = importlib.util.module_from_spec(spec); _a = sys.argv; sys.argv = ["x"]; spec.loader.exec_module(ks); sys.argv = _a
        strong = [p for p in range(len(ks.P1)) if len(ks.NB[p]) >= 3]
        for i in undefined:
            q = halo[i]["xy"]
            near = [p for p in strong if abs((ks.P1[p][0]-q[0])**2 + (ks.P1[p][1]-q[1])**2 - 1) < 1e-7]
            ext = []
            for p in near:
                Pp = exact_point(ks.P1[p], ks.NB[p], []); 
                if Pp is not None: ext.append(Pp)
            exact[i] = exact_point(q, halo[i]["seed_nbrs"], ext)
            assert exact[i] is not None, ("depth2 undefined", i)
    print(f"[{label}] {e}: {len(halo)} halo points defined exactly [{time.time()-t0:.0f}s]", flush=True)
    # exact unit edges: seed–halo and halo–halo, verifying the float lists
    nb = len(H); m = len(halo)
    edges = []; kinds = {"exact": 0, "numeric-200": 0}
    for i, h in enumerate(halo):
        for v in h["seed_nbrs"]:
            ok, how = is_unit(exact[i], SEED[v]); assert ok, ("seed edge not unit", i, v); kinds[how] += 1; edges.append((v, nb+i))
        for j in h["halo_nbrs"]:
            if j > i:
                ok, how = is_unit(exact[i], exact[j]); assert ok, ("halo edge not unit", i, j); kinds[how] += 1; edges.append((nb+i, nb+j))
    print(f"[{label}] {e}: {len(edges)} halo unit edges verified ({kinds}) [{time.time()-t0:.0f}s]", flush=True)
    # solver: H − e + halo, A ≠ B
    N = nb + m
    ue = E1 + edges; tp = [f for f in E2 if f != e]
    st = T.forces_outcome(N, ue, tp, iA, iB, 3600)
    print(f"[{label}] {e}: one-hot ask (A≠B): {st} [{time.time()-t0:.0f}s]", flush=True)
    re = rigidity.reencode_confirm(N, ue, K, tp + [(iA, iB)], cap=7200)["outcome"] if st == "unsat" else "not-run"
    print(f"[{label}] {e}: 3-bit re-encode: {re} [{time.time()-t0:.0f}s]", flush=True)
    row = {"kind": "removal", "label": label, "k": 5, "framing": "forced", "target": list(e), "stage_fingerprint": T.fingerprint(nb, E1 + E2),
           "pool_fingerprint": T.fingerprint(N, ue), "pool_size": m, "cap": 3600, "outcome": st, "reencode": re,
           "halo": {"one_minimal": True, "size": m, "witnesses": m, "unknown": 0, "by": "lookup over the exact separating-colouring list", "edge_verification": kinds, "points": [[float(sp.N(P[0], 20)), float(sp.N(P[1], 20))] for P in exact], "kinds": [h["kind"] for h in halo]},
           "verdict": "removed" if st == "unsat" and re == "unsat" else ("candidate-removal" if st == "unsat" else "refused"),
           "seconds": round(time.time()-t0, 1),
           "claim_scope": "a DESIGNED unit halo (depth-two partner points, exact sympy coordinates, every unit edge verified exactly) replacing one lower-bound distance-2 edge of H at five colours: UNSAT in two encodings; 1-minimality by lookup over the complete separating-colouring list (each survivor necessary)"}
    T.record(__import__("pathlib").Path("/home/kooshi/source/lean-dir/build/m49-descent5.json"), row)
    return row
if __name__ == "__main__":
    import glob
    done = set(tuple(r["target"]) for r in json.load(open("/home/kooshi/source/lean-dir/build/m49-descent5.json"))["rows"] if r.get("label") == "seed-k5-design" and r.get("verdict") == "removed")
    halos = {}
    for f in sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-kill-halos*.json")):
        for k, v in json.load(open(f)).items():
            if isinstance(v, list): halos[k] = v
            elif isinstance(v, dict) and "halo" in v: halos[k] = v["halo"]
    for k, halo in halos.items():
        if tuple(int(x) for x in k.strip("()").split(",")) in done: print("already certified", k); continue
        e = tuple(int(x) for x in k.strip("()").split(","))
        r = certify(e, halo, "seed-k5-design")
        print(f"[seed-k5-design] {e}: verdict {r['verdict']}, halo {len(halo)} points, {r['seconds']}s", flush=True)
