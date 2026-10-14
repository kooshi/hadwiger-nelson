"""FS131-IDB2 prototype (untrusted planning instrument for lane X): does every listed congruence {I, J} of the paper's
certificate have an explicit isometry z -> u*(b ? conj z : z) + v carrying X|I onto X|J, with u, v in Q(sqrt3, sqrt11)(i)
and |u| = 1, as the library's `DualCert.Congruent` asks? Exact arithmetic (Fractions); the correspondence I[k] -> J[k] is the
notebook's order (J26 checked its pairwise distances). Prints the counts and the denominators a Lean encoding would carry.
Run from the worktree root: python3 data/fs131/idb2/proto/proto_cong.py"""
import sys
from fractions import Fraction as Fr
from math import lcm
from pathlib import Path
sys.path.insert(0, 'tools')
import j26_ambrus_check as J

pts = J.read_points(Path('data/pa-ambrus2023/verification23.nb'))
w0, wT, w1, w2, wc = J.read_coeffs(Path('data/pa-ambrus2023/g23.csv'))
Z = (Fr(0),) * 4
ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
fm, fa, fs = J.fmul, J.fadd, J.fsub

def finv(x):  # inverse in Q(sqrt3)(sqrt11): x = p + q*sqrt11, p, q in Q(sqrt3)
    a, b, c, d = x
    p, q = (a, b), (c, d)
    def m3(u, v): return (u[0]*v[0] + 3*u[1]*v[1], u[0]*v[1] + u[1]*v[0])
    n = (m3(p, p)[0] - 11*m3(q, q)[0], m3(p, p)[1] - 11*m3(q, q)[1])   # p^2 - 11 q^2 in Q(sqrt3)
    den = n[0]**2 - 3*n[1]**2
    ninv = (n[0]/den, -n[1]/den)
    pr, qr = m3(p, ninv), m3((-q[0], -q[1]), ninv)
    r = (pr[0], pr[1], qr[0], qr[1])
    assert fm(r, x) == ONE
    return r

def cmul(x, y): return (fs(fm(x[0], y[0]), fm(x[1], y[1])), fa(fm(x[0], y[1]), fm(x[1], y[0])))
def csub(x, y): return (fs(x[0], y[0]), fs(x[1], y[1]))
def cadd(x, y): return (fa(x[0], y[0]), fa(x[1], y[1]))
def conj(x): return (x[0], fs(Z, x[1]))
def cdiv(x, y):
    n = fa(fm(y[0], y[0]), fm(y[1], y[1]))
    ni = finv(n)
    t = cmul(x, conj(y))
    return (fm(t[0], ni), fm(t[1], ni))
def cnorm2(x): return fa(fm(x[0], x[0]), fm(x[1], x[1]))

ok, bad, dens = 0, [], []
for v_, I, Jx in wc:
    P = [pts[i - 1] for i in I]; Q = [pts[j - 1] for j in Jx]
    found = None
    for b in (False, True):
        Pb = [conj(p) if b else p for p in P]
        if len(I) == 1:
            u = (ONE, Z); vv = csub(Q[0], Pb[0])
        else:
            u = cdiv(csub(Q[1], Q[0]), csub(Pb[1], Pb[0])); vv = csub(Q[0], cmul(u, Pb[0]))
        if cnorm2(u) == ONE and all(cadd(cmul(u, p), vv) == q for p, q in zip(Pb, Q)):
            found = (b, u, vv); break
    if found:
        ok += 1
        b, u, vv = found
        dens.append(lcm(*[c.denominator for part in u + vv for c in part]))
    else:
        bad.append((I, Jx))
print(f"congruences {len(wc)}: explicit isometry found {ok}, none {len(bad)}" + (f" e.g. {bad[:3]}" if bad else ""))
print("lcm of u, v denominators: max", max(dens), "distinct", sorted(set(dens))[:12])
print("point denominators lcm", lcm(*[c.denominator for p in pts for part in p for c in part]))
