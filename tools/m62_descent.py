"""M62 alternating exact-test descent. Both halves shrink, each against the other's pattern set."""
import sys, pickle, time, json, random, os
sys.path.insert(0, 'tools')
import typem as T
from multiprocessing import Pool
open('/tmp/ed2.pid','w').write(str(os.getpid()))

SUB = (1, 5)
D = pickle.load(open('/tmp/sym_arena.pkl', 'rb'))
ORB = pickle.load(open('/tmp/cross_orbits.pkl', 'rb'))
A0 = T.Arena(D['pts'], D['Ei'], D['Ec'])
E = [(i, j) for i, j in D['Ec'] if i == A0.centre or j == A0.centre]
for k in SUB: E += ORB[k]
A = T.Arena(D['pts'], D['Ei'], E)
Ec = [(i, j) for i, j in E if i != A.centre and j != A.centre]
Lep, Sep = T.cross_endpoints(A, Ec)
NORM1 = [j for j in range(A.n) if T.norm2(D['pts'][j]) == T.ONE]
CENTRE_UNITS = [[-((A.n + j) * 4 + 1)] for j in NORM1]      # centre pinned to 0 -> S norm-1 != 0
MASKS, _ = T.arena_orbits(A, D['pts'])
LM = (1 << A.n) - 1

def cnf(side):
    c = T.side_cnf(A, side)
    return c + CENTRE_UNITS if (side & ~LM) else c

def pats(side, ep, cap=200000):
    from pysat.solvers import Solver
    out = []
    with Solver(name="cadical153", bootstrap_with=cnf(side)) as s:
        while len(out) < cap:
            if not s.solve(): return out, True
            tr = set(l for l in s.get_model() if l > 0)
            p = tuple(next(c for c in range(4) if v*4+c+1 in tr) for v in ep)
            out.append(p); s.add_clause([-(v*4+p[i]+1) for i, v in enumerate(ep)])
    return out, False

def boxes(P, ep_other, mine_is_L):
    """Assumption sets: for each opposite pattern, the colours my endpoints must avoid."""
    oi = {v: t for t, v in enumerate(ep_other)}
    out = []
    for q in P:
        a = set()
        for (i, j) in Ec:
            me, them = (i, A.n + j) if mine_is_L else (A.n + j, i)
            t = oi.get(them)
            if t is not None: a.add(-(me*4 + q[t] + 1))
        out.append(sorted(a))
    return out

G = {}
def _init(bx, side_is_L): G['bx'], G['isL'] = bx, side_is_L
def _try(side):
    from pysat.solvers import Solver
    with Solver(name="cadical153", bootstrap_with=cnf(side)) as s:
        for b in G['bx']:
            if s.solve(assumptions=b): return side, False
    return side, True

if __name__ == "__main__":
    t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
    cur = {"L": A.full & LM, "S": A.full & ~LM}
    log(f"subtype {SUB}: {len(Ec)} cross edges, {len(Lep)}/{len(Sep)} endpoints, "
        f"start L={cur['L'].bit_count()} S={cur['S'].bit_count()}")
    rng = random.Random(20260910)
    for rnd in range(10**6):
        progress = False
        for me in ("L", "S"):
            other = "S" if me == "L" else "L"
            P, ex = pats(cur[other], Sep if other == "S" else Lep)
            if not ex: log(f"  {me}: opposite set CAPPED, skip"); continue
            bx = boxes(P, Sep if other == "S" else Lep, me == "L")
            ok, _ = _try_local = (None, None)
            G['bx'], G['isL'] = bx, me == "L"
            s0, ok = _try(cur[me])
            if not ok:
                log(f"  {me}: CONTROL FAILED -- current half does not block all {len(P)} boxes"); sys.exit(1)
            live = [m for m in MASKS if (m & cur[me]) == m and m
                    and not (m & (1 << A.centre)) and not (m & (1 << (A.n + A.centre)))]
            if not live: continue
            log(f"  {me}: |P_{other}|={len(P)}, {len(live)} orbits live, L={cur['L'].bit_count()} S={cur['S'].bit_count()}")
            for chunk in (max(1, len(live)//4), max(1, len(live)//16), max(1, len(live)//64), 8, 2, 1):
                props = []; pool = live[:]; rng.shuffle(pool)
                for i in range(0, min(len(pool), 28*chunk), chunk):
                    t = cur[me]
                    for m in pool[i:i+chunk]: t &= ~m
                    if t != cur[me]: props.append(t)
                if not props: continue
                with Pool(28, initializer=_init, initargs=(bx, me == "L")) as p:
                    res = p.map(_try, props)
                good = [s for s, o in res if o]
                if good:
                    best = min(good, key=lambda s: s.bit_count())
                    log(f"    {me}: {cur[me].bit_count()} -> {best.bit_count()} (chunk {chunk}, {len(good)}/{len(props)})")
                    cur[me] = best; progress = True
                    json.dump(dict(subtype=list(SUB), L=hex(cur['L']), S=hex(cur['S']),
                                   total=cur['L'].bit_count()+cur['S'].bit_count(), round=rnd,
                                   seconds=round(time.time()-t0,1)),
                              open('data/m62/ed2-ckpt.json','w'))
                    break
        tot = cur['L'].bit_count() + cur['S'].bit_count()
        log(f"round {rnd}: L={cur['L'].bit_count()} + S={cur['S'].bit_count()} = {tot}")
        if not progress:
            log("converged"); break
    union = cur['L'] | cur['S']
    st = T.refuses_four(A, union, wall=3600.0)
    log(f"FINAL union={union.bit_count()}; direct solver: {st.upper()}")
    json.dump(dict(kind="typem-alt-descent", subtype=list(SUB), L=hex(cur['L']), S=hex(cur['S']),
                   vertices=union.bit_count(), direct=st, seconds=round(time.time()-t0,1),
                   claim_scope="Alternating exact-box descent, both halves. REFUSED-4 at best; NOT a find."),
              open('data/m62/ed2-result.json','w'), indent=1)
