#!/usr/bin/env python3
"""R2 (Poros): numerical control for the reading that FS116-V6-HUG's identity is an instance of
   |u + v + w|^2 - 1 = (u+v)(v+w)(w+u)/(uvw) = 8 cos((a-b)/2) cos((b-c)/2) cos((c-a)/2)
for unit complex numbers u = e(a), v = e(b), w = e(c). Not a proof: a check with a planted fault.
Usage: identity_check.py [--plant]   (exit 0 on PASS; the plant must make it exit 1)."""
import cmath, math, random, sys

PLANT = "--plant" in sys.argv
e = lambda deg: cmath.exp(1j * math.radians(deg))

def general(a, b, c):
    rhs = 8 * math.cos(math.radians(a - b) / 2) * math.cos(math.radians(b - c) / 2) * math.cos(math.radians(c - a) / 2)
    if PLANT:  # a wrong closed form: one half-angle replaced
        rhs = 8 * math.cos(math.radians(a + b) / 2) * math.cos(math.radians(b - c) / 2) * math.cos(math.radians(c - a) / 2)
    u, v, w = e(a), e(b), e(c)
    lhs = abs(u + v + w) ** 2 - 1
    prod = ((u + v) * (v + w) * (w + u) / (u * v * w))
    return max(abs(lhs - rhs), abs(lhs - prod.real), abs(prod.imag))

def v6_hug(s, t):  # V6 § 2.2: a(s) = y0 + e(120+s), b(t) = y1 + e(300-t), y1 - y0 = e(120)
    y0 = 0; y1 = e(120)
    a = y0 + e(120 + s); b = y1 + e(300 - t)
    rhs = -8 * math.sin(math.radians(s) / 2) * math.sin(math.radians(t) / 2) * math.cos(math.radians(s + t) / 2)
    return abs(abs(a - b) ** 2 - 1 - rhs), abs(a - b) ** 2 - 1 - general_value(s, 180, -t)

def general_value(a, b, c):
    return 8 * math.cos(math.radians(a - b) / 2) * math.cos(math.radians(b - c) / 2) * math.cos(math.radians(c - a) / 2)

def v6_adj(s, t):  # V6 § 2.3 item 2: a = y1 + e(-60+s), b = y0 + e(120-t)
    y0 = 0; y1 = e(120)
    a = y1 + e(-60 + s); b = y0 + e(120 - t)
    rhs = -8 * math.sin(math.radians(s) / 2) * math.sin(math.radians(t) / 2) * math.cos(math.radians(s + t) / 2)
    return abs(abs(a - b) ** 2 - 1 - rhs)

def y4_flank(phi):  # Y4 § 3.1 least-curved case: points at turning angle phi are 2 cos(phi) - 1 apart
    y0 = 0; y1 = e(120)
    a = y0 + e(120 + phi); b = y1 + e(300 - phi)
    return abs(abs(a - b) - abs(2 * math.cos(math.radians(phi)) - 1))

random.seed(20261003)
worst = 0.0
n = 0
for _ in range(20000):
    a, b, c = (random.uniform(-720, 720) for _ in range(3))
    worst = max(worst, general(a, b, c)); n += 1
hug = max(max(v6_hug(s, t)) for s in range(0, 181, 3) for t in range(0, 181, 3))
adj = max(v6_adj(s, t) for s in range(0, 181, 3) for t in range(0, 181, 3))
fl = max(y4_flank(p) for p in range(0, 61))
zero = sorted({(s, t) for s in range(1, 180) for t in range(1, 180)
               if abs(abs(e(120 + s) - (e(120) + e(300 - t))) - 1) < 1e-12})
print(f"general factorization: {n} random triples, worst residual {worst:.2e}")
print(f"V6-HUG form on a 61x61 grid (s, t in [0, 180]): worst residual {hug:.2e}")
print(f"V6-ADJ form on the same grid: worst residual {adj:.2e}")
print(f"Y4-FLANK least-curved case, phi in 0..60: worst residual {fl:.2e}")
print(f"interior grid points (1..179 deg) where |a-b| = 1: {len(zero)}, all with s + t = 180: {all(s + t == 180 for s, t in zero)}")
ok = max(worst, hug, adj, fl) < 1e-9 and zero and all(s + t == 180 for s, t in zero)
print("RESULT:", "PASS" if ok else "FAIL")
sys.exit(0 if ok else 1)
