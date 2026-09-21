#!/usr/bin/env python3
"""FS-66 phase 2: a FALSIFIER for the hand-proved links L1-L2 of plans/FS66-phase2-certificate.md §S (an example can
falsify, never verify).  For independent sets I of G_k = UD(Z/p^k, 2), k >= 2, with c_x = |I meets the fibre over x|, the
fibre-density inequality says, in exact integers (F = p^(2(k-1)) the fibre size):

      q_int := 2 * sum_x c_x (F - c_x)  -  sum_x sum_{s in S_1} c_x c_{x+s}   >=  0 .

Tried on: random greedy maximal independent sets; the pull-back of a level-one independent set (q_int = 0 exactly -- the
inequality is TIGHT there); and random independence-preserving perturbations of that pull-back (the informative family).
Standard library only.  Usage: fs66_b1_links_test.py P K TRIALS [SEED]   -> exit 0 iff no violation."""
import sys, random
p, k, trials = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]); random.seed(int(sys.argv[4]) if len(sys.argv) > 4 else 1)
N = p ** k; Fib = p ** (2 * (k - 1))
Sk = [(a, b) for a in range(N) for b in range(N) if (a * a + b * b) % N == 1]
S1 = sorted({(a % p, b % p) for a, b in Sk})
assert len(Sk) == p ** (k - 1) * (p + 1) and len(S1) == p + 1, "Hensel count failed"
def nbrs(v): return [((v[0] + a) % N, (v[1] + b) % N) for a, b in Sk]
def q_int(I):
    c = {}
    for (a, b) in I: c[(a % p, b % p)] = c.get((a % p, b % p), 0) + 1
    return 2 * sum(v * (Fib - v) for v in c.values()) - sum(v * c.get(((x + s) % p, (y + t) % p), 0) for (x, y), v in c.items() for s, t in S1)
def greedy(order, I=None, blocked=None):
    I = set() if I is None else I; blocked = set() if blocked is None else blocked
    for v in order:
        if v not in blocked and v not in I:
            I.add(v); blocked.update(nbrs(v))
    return I
V = [(a, b) for a in range(N) for b in range(N)]
# a level-one independent set, greedily, best of many
def greedy1():
    I = []; pts = [(a, b) for a in range(p) for b in range(p)]; random.shuffle(pts)
    for v in pts:
        if all(((v[0] - w[0]) % p, (v[1] - w[1]) % p) not in S1 for w in I): I.append(v)
    return I
I1 = max((greedy1() for _ in range(300)), key=len)
pull = {v for v in V if (v[0] % p, v[1] % p) in I1}
worst = None; sizes = []; kinds = {"greedy": 0, "pullback": 0, "perturbed": 0}
def check(I, kind):
    global worst
    assert all(w not in I for v in I for w in nbrs(v)), "not independent (harness bug)"
    qv = q_int(I); sizes.append(len(I)); kinds[kind] += 1
    if worst is None or qv < worst[0]: worst = (qv, kind, len(I))
    return qv
assert check(pull, "pullback") == 0, "the pull-back is not tight: q_int != 0"
for t in range(trials):
    if t % 2 == 0:
        check(greedy(random.sample(V, len(V))), "greedy")
    else:                                            # knock out a random part of the pull-back, refill greedily
        keep = {v for v in pull if random.random() > random.choice([0.02, 0.1, 0.3])}
        blocked = set()
        for v in keep: blocked.update(nbrs(v))
        check(greedy(random.sample(V, len(V)), set(keep), blocked), "perturbed")
print(f"p={p} k={k}: |S_k|={len(Sk)}, level-one set {len(I1)}, pull-back {len(pull)} (q_int = 0: tight); {sum(kinds.values())} independent sets "
      f"{kinds}; sizes {min(sizes)}..{max(sizes)}; least q_int = {worst[0]} ({worst[1]}, size {worst[2]})")
print("NO VIOLATION" if worst[0] >= 0 else "VIOLATION: a hand link of §S is false")
sys.exit(0 if worst[0] >= 0 else 1)
