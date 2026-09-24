"""Lemma X, line-data form: an exact enumeration of stripe DATA (not of colourings of any graph).

Line data on line n of the common stripe direction: L[tau][mu] (tau in F4, mu = m mod 2) -> colour.
Constraints (derived in RECORD.md, Lemma X):
 (a) L[tau][0] != L[tau][1]; for each mu, tau -> L[tau][mu] is a bijection;
 (b) {L_{n+1}[tau][0], L_{n+1}[tau][1]} = complement of {L_n[tau][0], L_n[tau][1]};
 (c) L_{n+1}[s][mu] != L_n[s+zeta][mu];        (eta-edge, v = sqrt(-3) zeta)
 (c')L_{n+1}[s][mu+1] != L_n[s+zeta^2][mu];    (eta-edge, v = -sqrt(-3) zeta^2)
 (d) L_{n+2}[tau+1][mu+1] != L_n[tau][mu];     (eta-edge, v = sqrt(-3))
Claim: every compatible (L_n, L_{n+1}, L_{n+2}) has L_n of translation type with step y in {zeta, zeta^2}
(L_n[tau][1] = L_n[tau+y][0]), L_{n+1} forced, and L_{n+2} = L_n.
"""
import itertools, sys
F4 = [(0,0),(1,0),(0,1),(1,1)]
def add(x,y): return ((x[0]+y[0])%2, (x[1]+y[1])%2)
ONE, ZETA, ZETA2 = (1,0), (0,1), (1,1)
COLS = range(4)
PLANT = len(sys.argv) > 1 and sys.argv[1] == 'plant'   # planted fault: drop constraint (d)

def lines_after(L, ok):
    """all line data L' with (a),(b) w.r.t. L and ok(L') """
    res = []
    comp = {t: [c for c in COLS if c not in L[t]] for t in F4}
    for flips in itertools.product([0,1], repeat=4):
        Lp = {t: (comp[t][f], comp[t][1-f]) for t, f in zip(F4, flips)}
        if len({Lp[t][0] for t in F4}) < 4 or len({Lp[t][1] for t in F4}) < 4: continue
        if ok(Lp): res.append(Lp)
    return res

def cc(Ln, Ln1):   # (c) and (c') between consecutive lines
    for s in F4:
        for mu in (0,1):
            if Ln1[s][mu] == Ln[add(s,ZETA)][mu]: return False
            if Ln1[s][(mu+1)%2] == Ln[add(s,ZETA2)][mu]: return False
    return True

def dd(Ln, Ln2):
    if PLANT: return True
    for t in F4:
        for mu in (0,1):
            if Ln2[add(t,ONE)][(mu+1)%2] == Ln[t][mu]: return False
    return True

def ttype(L):
    for y in (ONE, ZETA, ZETA2):
        if all(L[t][1] == L[add(t,y)][0] for t in F4): return y
    return None

stats = {}
n_triples = 0; bad = []
col0 = {t: i for i, t in enumerate(F4)}            # normalise: L_n[tau][0] = colour index of tau
for perm in itertools.permutations(COLS):
    if any(perm[i] == i for i in COLS): continue   # derangement: column 1 differs from column 0
    Ln = {t: (col0[t], perm[col0[t]]) for t in F4}
    y = ttype(Ln)
    n1s = lines_after(Ln, lambda Lp: cc(Ln, Lp))
    triples = []
    for Ln1 in n1s:
        # L_{n+2}: pair sets equal L_n's
        for flips in itertools.product([0,1], repeat=4):
            Ln2 = {t: (Ln[t][f], Ln[t][1-f]) for t, f in zip(F4, flips)}
            if len({Ln2[t][0] for t in F4}) < 4 or len({Ln2[t][1] for t in F4}) < 4: continue
            if cc(Ln1, Ln2) and dd(Ln, Ln2): triples.append((Ln1, Ln2))
    key = ('translation step ' + {ONE:'1', ZETA:'zeta', ZETA2:'zeta^2'}[y]) if y else '4-cycle'
    stats.setdefault(key, [0,0,0])
    stats[key][0] += 1; stats[key][1] += len(n1s); stats[key][2] += len(triples)
    n_triples += len(triples)
    for Ln1, Ln2 in triples:
        if y not in (ZETA, ZETA2) or Ln2 != Ln or len(n1s) != 1:
            bad.append((key, Ln, Ln1, Ln2))
print("plant (d) dropped:" if PLANT else "full constraints:")
for k, v in stats.items():
    print(f"  L_n {k}: {v[0]} line data, {v[1]} compatible L_(n+1) in total, {v[2]} compatible triples")
print("  triples violating the claim:", len(bad))
if PLANT and bad:
    print("  planted fault fires: e.g.", bad[0][0])
