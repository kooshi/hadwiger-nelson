import sys, json; sys.path.insert(0, "/home/kooshi/source/lean-dir/tools"); import twodist as T, closure as CL, coloring, rigidity, forcer
H = T.ei_H(); pts = [T.to_closure(p) for p in H]; c = T.classify(H); E1, E2 = c[1], c[4]; n = len(H); K = 5
iA, iB = H.index(T.EI_A), H.index(T.EI_B)
a = json.load(open("/home/kooshi/source/lean-dir/build/m49-descent5.json"))
rows = [r for r in a["rows"] if r.get("label")=="seed-k5-lb" and r.get("verdict")=="removed"]
def sub_pool(halo, e, r, cur):
    a0, b0 = CL.approx(cur[e[0]]), CL.approx(cur[e[1]]); mx, my = (a0[0]+b0[0])/2, (a0[1]+b0[1])/2
    return [q for q in halo if (CL.approx(q)[0]-mx)**2+(CL.approx(q)[1]-my)**2 <= r*r]
cur = list(pts)
first = rows[0]; e = tuple(first["target"])
halo = sub_pool(T.pool_seam(cur, [cur[e[0]], cur[e[1]]])[0], e, first["radius"], cur)
q = halo[first["halo"]["ids"][0] - len(cur)]
allpts = cur + [q]; ue = T.closure_unit_edges(allpts); p = len(allpts) - 1
N = sorted([x for x,y in ue if y == p] + [y for x,y in ue if x == p])
print("edge", e, "point's unit neighbours in H:", N, flush=True)
base = coloring.base_clauses(n, E1 + [f for f in E2 if f != e], K) + rigidity.amo_clauses(n, K)
ne = [[-coloring.var(iA, k, K), -coloring.var(iB, k, K)] for k in range(K)]
st2, _ = forcer._solve(base + ne, n * K, 600); print("control: H − e with A≠B alone:", st2, "(expected sat)", flush=True)
avoid = [[-coloring.var(v, 4, K)] for v in N]
st, _ = forcer._solve(base + ne + avoid, n * K, 1800)
print("H − e, A≠B, N(p) avoids colour 4:", st, "(unsat = N(p) forced RAINBOW in every separating colouring; palette-WLOG)", flush=True)
