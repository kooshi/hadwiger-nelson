# Product owner's decorrelated recheck of the phase-1a witness: own edge test, own CNF (different variable order),
# CaDiCaL binary with NO pin; plus one plant of the owner's choosing handed to the implementer's checker.
import json, gzip, subprocess, sys, os, shutil, itertools, collections
W='data/fs66/witness-p11-l2-k4/witness.json'
CAD='/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical'
out=sys.argv[1]
w=json.load(open(W)); n=w['n']; k=w['k']; P=[tuple(p) for p in w['points']]; E=[tuple(e) for e in w['edges']]
assert n==121 and k==4
bad=[e for e in E if ((P[e[0]][0]-P[e[1]][0])**2+(P[e[0]][1]-P[e[1]][1])**2)%n!=1]
print(f"points {len(P)} (distinct {len(set(P))}), edges {len(E)} (distinct unordered {len({frozenset(e) for e in E})}), non-unit listed pairs: {len(bad)}")
deg=collections.Counter(); 
for a,b in E: deg[a]+=1; deg[b]+=1
print(f"average degree {2*len(E)/len(P):.3f}, min degree {min(deg.values())}, max {max(deg.values())}, isolated points {len(P)-len(deg)}")
def cnf(kk,path):
    # own order: variables colour-major (c*N + v + 1); edge clauses first, then at-least-one
    N=len(P); var=lambda v,c: c*N+v+1
    cl=[[-var(a,c),-var(b,c)] for a,b in E for c in range(kk)]+[[var(v,c) for c in range(kk)] for v in range(N)]
    open(path,'w').write(f"p cnf {N*kk} {len(cl)}\n"+''.join(' '.join(map(str,c))+' 0\n' for c in cl))
for kk,expect in ((4,20),(5,10)):
    f=f"{out}/own-k{kk}.cnf"; cnf(kk,f)
    r=subprocess.run([CAD,'-q',f],capture_output=True,text=True)
    print(f"own CNF, k={kk}, no pin: cadical exit {r.returncode} (20 = UNSAT, 10 = SAT) -> {'as expected' if r.returncode==expect else 'UNEXPECTED'}")
    if kk==5 and r.returncode==10:
        pos={int(t) for ln in r.stdout.splitlines() if ln.startswith('v ') for t in ln.split()[1:] if int(t)>0}
        N=len(P); col=[next(c for c in range(5) if c*N+v+1 in pos) for v in range(N)]
        print("   5-colouring proper on every listed edge:", all(col[a]!=col[b] for a,b in E))
# the owner's plant: replace one listed edge by a pair that is a unit pair modulo 11 but NOT modulo 121
cand=None
for i,j in itertools.combinations(range(len(P)),2):
    q=(P[i][0]-P[j][0])**2+(P[i][1]-P[j][1])**2
    if q%11==1 and q%121!=1 and (i,j) not in set(E): cand=(i,j); break
print("plant: pair", cand, P[cand[0]], P[cand[1]], "quadrance mod 11 =", ((P[cand[0]][0]-P[cand[1]][0])**2+(P[cand[0]][1]-P[cand[1]][1])**2)%11, "mod 121 =", ((P[cand[0]][0]-P[cand[1]][0])**2+(P[cand[0]][1]-P[cand[1]][1])**2)%121)
w2=dict(w); E2=sorted(set(E[:-1])|{cand}); w2['edges']=[list(e) for e in E2]
json.dump(w2,open(f"{out}/plant.json",'w'))
shutil.copy('data/fs66/witness-p11-l2-k4/witness.lrat.gz',f"{out}/plant.lrat.gz")
r=subprocess.run([sys.executable,'tools/fs66_check_witness.py',f"{out}/plant.json",f"{out}/plant.lrat.gz"],capture_output=True,text=True)
print("implementer's checker on the plant: exit",r.returncode,"|",(r.stdout.strip().splitlines() or ['(no stdout)'])[-1][:220])
