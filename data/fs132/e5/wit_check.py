#!/usr/bin/env python3
"""FS132-E5 — two geometric controls for C132-WIT. No search: fixed pseudo-random samples (a linear congruential generator).

  wit_check.py sides [--fault]   C132-WIT-STRIP's side rule. Centre x = 0, a witness q, a unit vector f with | |f - q| - 1 | > 1e-3.
                                 The point (1 + w) f lies in the straddle set of {0, q} exactly when |f - q| < 1, and (1 - w) f
                                 exactly when |f - q| > 1 (w = 1e-6). Counts the disagreements.
                                 --fault: predict the side by the sign of f.q instead (the rule for a limiting direction).
  wit_check.py mono  [--fault]   The straddle set of {p, q} lies in the straddle set of any finite K containing p and q.
                                 --fault: test the reverse inclusion.
"""
import sys, math

state = 20261007
def rnd():
    global state
    state = (1103515245 * state + 12345) % (1 << 31)
    return state / float(1 << 31)

def in_delta(z, K):
    d = [math.hypot(z[0] - k[0], z[1] - k[1]) for k in K]
    return min(d) < 1.0 < max(d)

def sides(fault):
    w, n, bad, outer, inner = 1e-6, 0, 0, 0, 0
    while n < 200000:
        rq, aq, af = 0.05 + 2.45 * rnd(), 2 * math.pi * rnd(), 2 * math.pi * rnd()
        q = (rq * math.cos(aq), rq * math.sin(aq)); f = (math.cos(af), math.sin(af))
        dist = math.hypot(f[0] - q[0], f[1] - q[1])
        if abs(dist - 1.0) < 1e-3:
            continue
        n += 1
        if fault:
            pred_outer = (f[0] * q[0] + f[1] * q[1]) > 0
        else:
            pred_outer = dist < 1.0
        got_outer = in_delta(((1 + w) * f[0], (1 + w) * f[1]), [(0.0, 0.0), q])
        got_inner = in_delta(((1 - w) * f[0], (1 - w) * f[1]), [(0.0, 0.0), q])
        outer += got_outer; inner += got_inner
        if got_outer != pred_outer or got_inner == pred_outer:
            bad += 1
    print(f"samples={n} outer={outer} inner={inner} disagreements={bad}")

def mono(fault):
    n, bad = 0, 0
    for _ in range(100000):
        K = [(3 * rnd() - 1.5, 3 * rnd() - 1.5) for _ in range(5)]
        z = (4 * rnd() - 2, 4 * rnd() - 2)
        small, big = in_delta(z, K[:2]), in_delta(z, K)
        if fault:
            small, big = big, small
        if small:
            n += 1
            bad += (not big)
    print(f"in-the-smaller={n} violations={bad}")

if __name__ == "__main__":
    {"sides": sides, "mono": mono}[sys.argv[1]]("--fault" in sys.argv)
