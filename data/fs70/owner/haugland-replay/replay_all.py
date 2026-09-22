#!/usr/bin/env python3
"""Owner's full replay of the Haugland A = B refutation: every one of the 1,458 cubes of the complete case split,
re-solved with the owner's own CNF (built from data/fs70/records/haugland/G1.json) and PySAT's CaDiCaL 1.9.5.
Writes one line per cube to replay.jsonl as it lands; a kill loses only the cubes in flight."""
import json, gzip, itertools, time, multiprocessing, os
from collections import defaultdict
g=json.load(open('data/fs70/records/haugland/G1.json'))
A,B=g['A'],g['B']; n0=len(g['points']); E0=[tuple(e) for e in g['edges']]
def rl(v): return A if v==B else v
E1={tuple(sorted((rl(a),rl(b)))) for a,b in E0}
verts=sorted(set(range(n0))-{B}); idx={v:i for i,v in enumerate(verts)}
E=sorted({(idx[a],idx[b]) for a,b in E1}); n=len(verts); Ac=idx[A]
adj=defaultdict(set)
for a,b in E: adj[a].add(b); adj[b].add(a)
for v1 in sorted(adj[Ac]):
    c=adj[Ac]&adj[v1]
    if c: tri=(v1,min(c)); break
pins=[(Ac,0),(tri[0],1),(tri[1],2)]; fixed=dict(pins)
cand=sorted((v for v in range(n) if v not in fixed), key=lambda v:-len(adj[v]))[:7]
surv=[]
for assign in itertools.product(range(4),repeat=7):
    col=dict(fixed); col.update(zip(cand,assign))
    if all(col.get(w)!=c for v,c in zip(cand,assign) for w in adj[v]): surv.append(assign)
base=[]
var=lambda v,c: v*4+c+1
for v in range(n): base.append([var(v,c) for c in range(4)])
for a,b in E:
    for c in range(4): base.append([-var(a,c),-var(b,c)])
for v,c in pins: base.append([var(v,c)])
def solve(cube):
    from pysat.solvers import Solver
    t=time.time()
    with Solver(name='cadical195', bootstrap_with=base+[[var(v,c)] for v,c in zip(cand,cube)]) as s:
        r=s.solve()
    return cube, r, round(time.time()-t,2)
out='data/fs70/owner/haugland-replay/replay.jsonl'
done=set()
if os.path.exists(out):
    done={tuple(json.loads(l)['cube']) for l in open(out)}
todo=[c for c in surv if c not in done]
print(f"contracted {n}/{len(E)}; pins {pins}; branching {cand}; cubes {len(surv)}; already done {len(done)}; todo {len(todo)}", flush=True)
with multiprocessing.get_context('fork').Pool(24) as pool, open(out,'a') as fh:
    for cube,r,t in pool.imap_unordered(solve, todo):
        fh.write(json.dumps({'cube':list(cube),'verdict':'UNSAT' if r is False else ('SAT' if r else 'UNKNOWN'),'seconds':t})+'\n'); fh.flush()
print("DONE", flush=True)
