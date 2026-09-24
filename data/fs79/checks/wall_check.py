# Independent check for D=(5,7,9,10): (a) build an explicit bi-infinite-extendable pattern across a cross edge;
# (b) enumerate periodic 4-colourings with period p<=P (circulant colourings, SAT enumeration of window patterns) and confirm the
# pattern (up to colour permutation) never occurs.  Independent of rank1_density's SCC code except for picking the edge.
import itertools, sys
from pysat.solvers import Cadical153
D=(5,7,9,10); k=4; L=max(D)
import rank1_density as R
# rebuild graph via R's internals quickly
res=R.analyse(D,k); print(res)
# re-derive states & a cross edge explicitly (small re-implementation)
def canon(w):
    m={};return tuple(m.setdefault(c,len(m)) for c in w)
states=set()
for w in itertools.product(range(k),repeat=L):
    if all(w[i]!=w[i+d] for i in range(L) for d in D if i+d<L): states.add(canon(w))
states=sorted(states)
def succs(s): return [canon(s[1:]+(c,)) for c in range(k) if all(s[L-d]!=c for d in D)]
# essential pruning by iteration
alive=set(states)
while True:
    na={s for s in alive if any(t in alive for t in succs(s))}
    pr={}
    for s in na:
        for t in succs(s):
            if t in na: pr[t]=1
    na={s for s in na if s in pr}
    if na==alive: break
    alive=na
# SCCs via reachability (small graph)
adj={s:[t for t in succs(s) if t in alive] for s in alive}
def reach(s):
    seen={s};st=[s]
    while st:
        x=st.pop()
        for y in adj[x]:
            if y not in seen: seen.add(y);st.append(y)
    return seen
R_={s:reach(s) for s in alive}
cross=[(s,t) for s in alive for t in adj[s] if s not in R_[t]]
print("states",len(states),"alive",len(alive),"cross edges (s->t with no return)",len(cross))
s,t=cross[0]
pattern=s+(t[-1],) if canon(s[1:]+(t[-1],))==t else None
# t is canonical; recover actual appended colour relative to s's labelling:
for c in range(k):
    if all(s[L-d]!=c for d in D) and canon(s[1:]+(c,))==t: pattern=s+(c,); break
print("cross-edge pattern (length L+1):",pattern)
# (b) all patterns of length L+1 occurring in periodic colourings with period p<=P
P=int(sys.argv[1]) if len(sys.argv)>1 else 40
found=False
for p in range(1,P+1):
    if any(d%p==0 for d in D): continue
    # enumerate all proper colourings of circulant C_p(D) up to colour perm, collecting canonical windows; stop if pattern seen
    sol=Cadical153(); v=lambda i,c:i*k+c+1
    for i in range(p):
        sol.add_clause([v(i,c) for c in range(k)])
        for c in range(k):
            for c2 in range(c+1,k): sol.add_clause([-v(i,c),-v(i,c2)])
        for d in D:
            for c in range(k): sol.add_clause([-v(i,c),-v((i+d)%p,c)])
    # ask directly: does some periodic colouring contain the pattern at position 0 (up to colour permutation)?
    for perm in itertools.permutations(range(k)):
        assum=[v(j%p,perm[pattern[j]]) for j in range(L+1)]
        # consistency when L+1>p: positions wrap
        ok=True; seen={}
        for j in range(L+1):
            if seen.setdefault(j%p,perm[pattern[j]])!=perm[pattern[j]]: ok=False;break
        if ok and sol.solve(assumptions=assum): found=(p,perm); break
    sol.delete()
    if found: break
print("pattern occurs in a periodic colouring with period <=",P,":",found)
