"""Grow to refusal, then descend -- the expansion half of Parts's alternation, at orbit granularity.

**Why growth is the cheap direction, measured rather than assumed.** A deletion pays the EXPENSIVE
verdict on every accepted drop (a refutation) and the cheap one on every rejection; a growth pays
the cheap verdict (a colouring turns up) on every prefix that is still colourable and the expensive
one only about log2(N) times. Same answer, inverted cost -- `typem.grow_to_refusal`'s own docstring
records the measurement, and the 757-vertex object reproduces it (colourable asks 0.2-2 s, refusing
asks 8-13 s).

So a run is: shuffle the orbit-halves, binary-search the shortest refusing prefix, and hand what
comes out to the descent. Different shuffles reach different regions of the arena, which is what
makes this a SEARCH rather than one more reduction of one fixed object -- the 757 closure explores
only the neighbourhood of Heule's own graph, and nothing below its 510 can come from there alone.
"""
from __future__ import annotations
import sys, os, json, time, pickle, random, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T


def orbit_halves(orb, n, centre):
    """Every (side, orbit) pair as a vertex list on the 2n index space; the S-side centre is not a
    vertex (invariant I1) and the L-side centre is hard, so neither is a droppable half."""
    out = []
    for gi, o in enumerate(orb):
        L = [i for i in o if i != centre]
        S = [n + i for i in o if n + i != n + centre]
        if L: out.append(("L", gi, L))
        if S: out.append(("S", gi, S))
    return out


def grow(A, halves, order, log, wall=900.0):
    """Shortest refusing prefix of `order`, by binary search. Monotone: a longer prefix is a
    superset, and refusal is upward closed."""
    centre_bit = 1 << A.centre
    pref = lambda m: centre_bit | sum(1 << v for k in order[:m] for v in halves[k][2])
    asks = 0
    st = T.refuses_four(A, pref(len(order)), wall); asks += 1
    if st != "unsat":
        log(f"  the whole order does not refuse ({st}) -- no claim"); return None, asks
    lo, hi = 1, len(order)
    while lo < hi:
        mid = (lo + hi) // 2
        p = pref(mid); asks += 1
        s = T.refuses_four(A, p, wall)
        log(f"    prefix {mid:3d}/{len(order)} ({p.bit_count():5d} vertices): {s}")
        if s == "unsat": hi = mid
        elif s == "sat": lo = mid + 1
        else: log("    UNDECIDED at cap -- widening, no claim"); lo = mid + 1
    return pref(hi), asks


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--arena", default="/tmp/arena244.pkl")
    ap.add_argument("--seeds", type=int, default=8)
    ap.add_argument("--out", default="data/m62/grow244.json")
    ap.add_argument("--wall", type=float, default=900.0)
    a = ap.parse_args()
    D = pickle.load(open(a.arena, "rb"))
    A = T.Arena(D["pts"], D["Ei"], D["Ec"]); n = D["n"]
    halves = orbit_halves(D["orb"], n, A.centre)
    t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
    log(f"arena: {A.N} vertices, {len(halves)} orbit-halves, {len(D['Ei'])} internal + "
        f"{len(D['Ec'])} cross edges")
    rows = []
    for s in range(a.seeds):
        order = list(range(len(halves))); random.Random(s).shuffle(order)
        p, asks = grow(A, halves, order, log, a.wall)
        if p is None: continue
        rows.append(dict(seed=s, vertices=p.bit_count(), asks=asks, present=hex(p),
                         seconds=round(time.time() - t0, 1)))
        log(f"  seed {s}: shortest refusing prefix = {p.bit_count()} vertices [{asks} asks]")
        json.dump(dict(kind="grow-to-refusal-orbit-prefix", rows=rows,
                       scope="each row is the shortest refusing PREFIX of one random orbit order -- "
                             "an upper bound reached without any deletion, not a minimal object"),
                  open(a.out, "w"), indent=1)
    if rows:
        log(f"sizes: {sorted(r['vertices'] for r in rows)}")
