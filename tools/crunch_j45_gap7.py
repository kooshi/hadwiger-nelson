"""J45 exact check (seconds): the residue-level facts behind F2's control and hypothesis (G2) over Q(sqrt 11), at the stable place above 7.

Gamma_7 = UD(F_7, 2): vertices F_7^2, circle C = {(a, b) : a^2 + b^2 = 1}, edges v ~ v + u (u in C).  The colouring is C9's
(ledger row 94): theta(x, y) = (2x + 3y)/7 mod 1, colour = floor(4 theta).  Checked, exactly:
  (1) |C| = 8 and the colouring is proper;
  (2) the gapped vertices (closed neighbourhood misses a colour) and their missing colours;
  (3) Z = {theta = 0} is independent and every vertex of Z is gapped with missing colour 3 (F2's Z-bar and g);
  (4) F2's support map at residue level -- M(v) = {gamma(v), 3} on Z, {gamma(v)} off Z -- has disjoint sets on every edge
      (the per-edge criterion of Lemma SI-3, so the control holds once the factor is identified, Lemma SI-C);
  (5) (G2): W = the gapped vertices with missing colour 3 contains an edge, and colour 3 is absent from gamma on every closed
      neighbourhood of W (so recolouring any independent subset of the lift of W to 3 stays proper).
A derivation fixed the set (all 49 vertices, all 8 unit vectors); this is a complete enumeration of it (the ban's edge, logged).
Plants: PLANT=1 replaces theta by (x + y)/7 (not a band functional): check (1) must fail.  PLANT=2 declares the Z-colour to be 2:
check (3) must fail.  Each plant must end in exit 1 with the failing check named."""
import os, sys

p = 7
PLANT = os.environ.get("PLANT", "0")
V = [(x, y) for x in range(p) for y in range(p)]
C = [v for v in V if (v[0] * v[0] + v[1] * v[1]) % p == 1]
def add(a, b):
    return ((a[0] + b[0]) % p, (a[1] + b[1]) % p)
def theta(v):
    if PLANT == "1":
        return (v[0] + v[1]) % p
    return (2 * v[0] + 3 * v[1]) % p
def colour(v):
    return (4 * theta(v)) // p
Z_COLOUR = 2 if PLANT == "2" else 3
fails = []
lines = []
# (1)
if len(C) != p + 1:
    fails.append(f"(1) circle size {len(C)} != 8")
bad = [(v, u) for v in V for u in C if colour(v) == colour(add(v, u))]
lines.append(f"(1) |C| = {len(C)}; monochromatic edges: {len(bad)}")
if bad:
    fails.append("(1) the colouring is not proper")
# (2)
def missing(v):
    seen = {colour(v)} | {colour(add(v, u)) for u in C}
    return sorted(set(range(4)) - seen)
gapped = {v: missing(v) for v in V if missing(v)}
by_theta = sorted({(theta(v), tuple(m)) for v, m in gapped.items()})
lines.append(f"(2) gapped vertices: {len(gapped)}; (theta*7, missing colours) classes: {by_theta}")
# (3)
Z = [v for v in V if theta(v) == 0]
z_indep = all(add(v, u) not in set(Z) for v in Z for u in C)
z_gap = all(v in gapped and Z_COLOUR in gapped[v] for v in Z)
lines.append(f"(3) |Z| = {len(Z)}; Z independent: {z_indep}; every Z vertex gapped with missing colour {Z_COLOUR}: {z_gap}")
if not (z_indep and z_gap):
    fails.append("(3) Z is not an independent set of gapped vertices with the declared missing colour")
# (4)
Zs = set(Z)
def M(v):
    return {colour(v), Z_COLOUR} if v in Zs else {colour(v)}
overlap = [(v, u) for v in V for u in C if M(v) & M(add(v, u))]
lines.append(f"(4) edges whose F2 support sets meet: {len(overlap)}")
if overlap:
    fails.append("(4) F2's support map is not disjoint on every edge")
# (5)
W = [v for v in V if v in gapped and 3 in gapped[v]]
Ws = set(W)
w_edges = [(v, u) for v in W for u in C if add(v, u) in Ws]
three_absent = all(colour(v) != 3 and all(colour(add(v, u)) != 3 for u in C) for v in W)
lines.append(f"(5) |W| = {len(W)} (theta*7 in {sorted({theta(v) for v in W})}); directed edges inside W: {len(w_edges)}; "
             f"colour 3 absent on every closed neighbourhood of W: {three_absent}")
if not w_edges or not three_absent:
    fails.append("(5) (G2) fails")
print("\n".join(lines))
if fails:
    print("FAIL: " + "; ".join(fails) + (f" (PLANT={PLANT})" if PLANT != "0" else ""))
    sys.exit(1)
print("VERDICT: all five checks pass")
