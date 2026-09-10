import sys,pickle,itertools,time,json; sys.path.insert(0,'tools')
import typem as T
from multiprocessing import Pool
D=pickle.load(open('/tmp/sym_arena.pkl','rb'))
ORB=pickle.load(open('/tmp/cross_orbits.pkl','rb'))
A0=T.Arena(D['pts'],D['Ei'],D['Ec'])
CENTRE=[(i,j) for i,j in D['Ec'] if i==A0.centre or j==A0.centre]
def work(sub):
    E=list(CENTRE)
    for k in sub: E+=ORB[k]
    A=T.Arena(D['pts'],D['Ei'],E)
    t=time.time(); st=T.refuses_four(A,A.full,wall=600.0)
    ne=sum(len(ORB[k]) for k in sub)
    eps=len({i for i,j in [e for k in sub for e in ORB[k]]})
    return (tuple(sub), st, ne, eps, round(time.time()-t,1))
if __name__=="__main__":
    subs=[c for r in range(1,8) for c in itertools.combinations(range(7),r)]
    print(f"testing {len(subs)} cross-edge orbit subsets on 30 cores", flush=True)
    t0=time.time()
    with Pool(30) as p: res=p.map(work, subs)
    uns=[r for r in res if r[1]=="unsat"]
    print(f"\n{len(uns)} of {len(res)} subsets keep the full base 5-chromatic  [{time.time()-t0:.0f}s]\n")
    uns.sort(key=lambda r:(r[2],r[3]))
    print(f"  {'orbits':<18} {'edges':>5} {'endpoints':>9} {'sec':>6}")
    for sub,st,ne,eps,sec in uns[:15]:
        print(f"  {str(sub):<18} {ne:5} {eps:9} {sec:6.1f}")
    minimal=[]
    U={r[0] for r in uns}
    for sub,st,ne,eps,sec in uns:
        if not any(set(o)<set(sub) for o in U): minimal.append((sub,ne,eps))
    print(f"\nMINIMAL subsets (no proper subset works): {len(minimal)}")
    for sub,ne,eps in sorted(minimal,key=lambda x:x[1]): print(f"   {sub}  {ne} edges, {eps} endpoints/side")
    json.dump(dict(kind="typem-subtype-census", tested=len(res), unsat=len(uns),
        minimal=[[list(s),n,e] for s,n,e in minimal],
        all_unsat=[[list(r[0]),r[2],r[3]] for r in uns],
        claim_scope="Exhaustive over all 127 non-empty subsets of the 7 cross-edge orbits, on the "
        "FULL symmetric-core base. A subset that keeps the base 5-chromatic is a candidate SUBTYPE; "
        "minimality is over orbit subsets, not over individual edges."),
        open('data/m62/subtype-census.json','w'), indent=1)
