import sys, json, time
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T, coloring, rigidity, forcer
H = T.ei_H(); n = len(H); c = T.classify(H); E1, E2 = c[1], c[4]; K = 5
iA, iB = H.index(T.EI_A), H.index(T.EI_B)
e = (int(sys.argv[1]), int(sys.argv[2]))
ne = [[-coloring.var(iA, k, K), -coloring.var(iB, k, K)] for k in range(K)]
edges = E1 + [f for f in E2 if f != e]
cls = coloring.base_clauses(n, edges, K) + rigidity.amo_clauses(n, K) + T._brk_full(n, K, T._degree_order(n, edges)) + ne
found = []; t = time.time(); exact = False
while len(found) < 50000:
    st, model = forcer._solve(cls, n * K, 1800)
    if st == "unsat": exact = True; break
    if st != "sat": break
    col = rigidity.decode(model, n, K); found.append(col)
    cls.append([-coloring.var(v, col[v], K) for v in range(n)])
json.dump({"edge": e, "colourings": found, "exact": exact, "seconds": round(time.time()-t,1), "control": "a REMOVED edge (step 10, 9-point kill) — the screen must find a kill for it"}, open(f"/home/kooshi/source/lean-dir/build/m49-sep-{e[0]}-{e[1]}.json", "w"))
print(e, len(found), exact, round(time.time()-t))
