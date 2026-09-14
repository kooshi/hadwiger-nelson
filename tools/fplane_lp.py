#!/usr/bin/env python3
"""fplane_lp — the autocorrelation LP for independent sets of UD(F_p, 2), p ≡ 3 (mod 4): Delsarte's LP over the norm
classes (= ϑ′, measured equal to Hoffman's ratio bound at every prime tried) STRENGTHENED by the inclusion–exclusion
constraints the real-plane 1-avoiding-set literature uses — [KMOR2016] Lemma 3.2 (2) (a finite unit-distance subgraph V
with independence number α_V gives Σ_{x∈V} a(x) ≤ δ·α_V, here summed over every translate and rotation-averaged), (3)
(Székely's inclusion–exclusion), and [AmbrusEtAl2023] Lemma 1 (the full atom LP of a point set X). Everything is a
relaxation: a size s that is INFEASIBLE certifies α < s (an independent set of size ≥ s contains one of size exactly s,
whose autocorrelation satisfies every row). Floats (HiGHS); a derivation plus an LP, no kernel content.

Vertex (x, y) ↦ the field F_p²; quadrance Q(x, y) = x² + y²; class of a nonzero vector = its quadrance (p−1 classes of
p+1 points each; no nonzero isotropic vector when p ≡ 3 mod 4). Variables g(c) = (class average of a(t)/δ) for c ≥ 2,
with g(0) = 1 and g(1) = 0 fixed; |S| = 1 + (p+1)·Σ_{c≥2} g(c).
"""
import argparse, json, math, sys, time
from pathlib import Path
import numpy as np
from scipy.optimize import linprog

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane  # noqa: E402

DATA = Path(__file__).resolve().parent.parent / "data" / "fs50"


# ---------------------------------------------------------------- geometry in F_p² as the field F_p(i)
def Q(v, p):
    return (v[0] * v[0] + v[1] * v[1]) % p

def add(u, v, p):
    return ((u[0] + v[0]) % p, (u[1] + v[1]) % p)

def sub(u, v, p):
    return ((u[0] - v[0]) % p, (u[1] - v[1]) % p)

def mul(u, v, p):
    """(a + bi)(c + di)"""
    return ((u[0] * v[0] - u[1] * v[1]) % p, (u[0] * v[1] + u[1] * v[0]) % p)

def sqrt_mod(a, p):
    a %= p
    if a == 0:
        return 0
    if pow(a, (p - 1) // 2, p) != 1:
        return None
    return pow(a, (p + 1) // 4, p)  # p ≡ 3 (mod 4)

def zeta6(p):
    """a primitive sixth root of unity on the unit circle: 1/2 + i√3/2 — exists iff 3 is a square mod p"""
    r = sqrt_mod(3, p)
    if r is None:
        return None
    half = pow(2, -1, p)
    z = (half, (r * half) % p)
    assert Q(z, p) == 1
    zz = z
    for _ in range(5):
        zz = mul(zz, z, p)
    assert zz == (1, 0)
    return z

def moser_twist(p):
    """ρ = 5/6 + i√11/6, the rotation taking a unit rhombus's far tip to unit distance from itself — needs √11"""
    r = sqrt_mod(11, p)
    if r is None:
        return None
    s = pow(6, -1, p)
    rho = ((5 * s) % p, (r * s) % p)
    assert Q(rho, p) == 1
    return rho


# ---------------------------------------------------------------- small unit-distance graphs drawn in the plane
def graph_library(p):
    """name → list of points (drawn about the origin); every graph's α is recomputed exactly below, never assumed"""
    lib = {}
    u = (1, 0)
    z = zeta6(p)
    if z is not None:
        v = mul(u, z, p)
        lib["triangle"] = [(0, 0), u, v]
        lib["rhombus"] = [(0, 0), u, v, add(u, v, p)]
        rim = []
        w = u
        for _ in range(6):
            rim.append(w); w = mul(w, z, p)
        lib["wheel6"] = [(0, 0)] + rim
        rho = moser_twist(p)
        if rho is not None:
            R = [(0, 0), u, v, add(u, v, p)]
            spin = R + [mul(x, rho, p) for x in R[1:]]
            lib["spindle"] = spin
    circ = fplane.circle(p)
    lib["circle+centre"] = [(0, 0)] + circ
    if z is not None:
        # two wheels sharing the edge (0, u): centres 0 and u
        rim0 = lib["wheel6"][1:]
        rim1 = [add(u, x, p) for x in rim0]
        lib["wheelpair"] = sorted(set([(0, 0), u] + rim0 + rim1))
        # the centre with two of the circle's hexagons (cosets of ⟨ζ₆⟩ on the circle)
        hexes = []; left = set(circ)
        while left:
            w = min(left); h = []
            for _ in range(6):
                h.append(w); left.discard(w); w = mul(w, z, p)
            hexes.append(h)
        lib["hex2+centre"] = [(0, 0)] + hexes[0] + hexes[1]
        if len(hexes) >= 3:
            lib["hex3+centre"] = [(0, 0)] + hexes[0] + hexes[1] + hexes[2]
        # the radius-2 hexagonal patch of the triangular lattice ℤ[ζ₆]·u: 19 points
        pts = set()
        for a in range(-2, 3):
            for b in range(-2, 3):
                if abs(a + b) <= 2:
                    pa = ((a * u[0]) % p, (a * u[1]) % p); pb = mul(v, ((b) % p, 0), p)
                    pts.add(add(pa, pb, p))
        lib["hexpatch19"] = sorted(pts)
    return lib

def induced_edges(V, p):
    idx = {v: i for i, v in enumerate(V)}
    assert len(idx) == len(V), "repeated point"
    E = [(i, j) for i in range(len(V)) for j in range(i + 1, len(V)) if Q(sub(V[i], V[j], p), p) == 1]
    return E

def alpha_exact(nv, E):
    """the independence number by branch and bound with component splitting (small graphs only)"""
    adj = [set() for _ in range(nv)]
    for i, j in E:
        adj[i].add(j); adj[j].add(i)
    sys.setrecursionlimit(10000)

    def comps(S):
        S = set(S); out = []
        while S:
            start = S.pop(); stack = [start]; comp = {start}
            while stack:
                x = stack.pop()
                for y in adj[x]:
                    if y in S:
                        S.remove(y); comp.add(y); stack.append(y)
            out.append(comp)
        return out

    def mis(S):
        if not S:
            return 0
        cs = comps(S)
        if len(cs) > 1:
            return sum(mis(c) for c in cs)
        S = cs[0]
        v = max(S, key=lambda x: len(adj[x] & S))
        if len(adj[v] & S) <= 2:  # paths and cycles: greedy-by-degree is exact enough via recursion below, keep simple
            pass
        without = mis(S - {v})
        with_v = 1 + mis(S - {v} - adj[v])
        return max(without, with_v)

    return mis(set(range(nv)))


# ---------------------------------------------------------------- the LP
class Model:
    def __init__(self, p):
        self.p = p; self.n = p * p
        self.L = fplane.scheme_eigen(p)  # L[(c, cp)] = Σ_{s∈N_c} cos(2π⟨m,s⟩/p), N(m) = cp
        self.cs = list(range(2, p))      # free classes
        self.ci = {c: i for i, c in enumerate(self.cs)}
        # Fourier rows: 1 + Σ_c g(c) L[(c,cp)] ≥ 0  ⇔  −Σ_c L g ≤ 1
        self.A_ub = [[-self.L[(c, cp)] for c in self.cs] for cp in range(0, p)]
        self.b_ub = [1.0] * p
        self.rows_note = {"fourier": p}
        self.A_eq = []; self.b_eq = []

    def size_vec(self):
        return np.array([(self.p + 1)] * len(self.cs), dtype=float)  # |S| = 1 + Σ (p+1) g(c)

    def add_subgraph_rows(self, name, V, alpha_V):
        """[KMOR2016] (2) over every translate: Σ_{x∈V} g(Q(x+z)) ≤ α_V; rows deduplicated by class multiset"""
        p = self.p; seen = set(); k = 0
        for zx in range(p):
            for zy in range(p):
                cnt = [0] * p
                for x in V:
                    cnt[Q(((x[0] + zx) % p, (x[1] + zy) % p), p)] += 1
                key = tuple(cnt)
                if key in seen:
                    continue
                seen.add(key); k += 1
                row = [float(cnt[c]) for c in self.cs]
                self.A_ub.append(row); self.b_ub.append(float(alpha_V - cnt[0]))
        self.rows_note[f"subgraph:{name}"] = k
        return k

    def add_szekely_row(self, name, C, s):
        """[KMOR2016] (3), Székely: Σ_{pairs⊂C} g(Q(x−y)) ≥ |C| − n/s  (needs the target size s)"""
        cnt = [0] * self.p
        for i in range(len(C)):
            for j in range(i + 1, len(C)):
                cnt[Q(sub(C[i], C[j], self.p), self.p)] += 1
        assert cnt[0] == 0
        row = [-float(cnt[c]) for c in self.cs]
        self.A_ub.append(row); self.b_ub.append(-(len(C) - self.n / s))
        self.rows_note[f"szekely:{name}"] = 1

    def solve_max(self):
        """maximise |S| under the homogeneous rows (Fourier + subgraph): the strengthened Delsarte bound"""
        r = linprog(-self.size_vec(), A_ub=np.array(self.A_ub), b_ub=np.array(self.b_ub),
                    A_eq=np.array(self.A_eq) if self.A_eq else None, b_eq=np.array(self.b_eq) if self.b_eq else None,
                    bounds=[(0, None)] * len(self.cs), method="highs")
        assert r.status == 0, r.message
        return 1 - r.fun, r.x

    def feasible_at(self, s):
        """is size s feasible under every row plus |S| = s?"""
        A_eq = self.A_eq + [list(self.size_vec())]; b_eq = self.b_eq + [s - 1.0]
        r = linprog(np.zeros(len(self.cs)), A_ub=np.array(self.A_ub), b_ub=np.array(self.b_ub),
                    A_eq=np.array(A_eq), b_eq=np.array(b_eq), bounds=[(0, None)] * len(self.cs), method="highs")
        if r.status == 0:
            return True, r.x
        if r.status == 2:
            return False, None
        raise RuntimeError(r.message)


def atoms_feasible(model, X, s, extra_A_ub=None):
    """[AmbrusEtAl2023] Lemma 1 for the point set X at size s: atom variables b(ε) = a_X(ε)/δ over the independent
    subsets ε ⊆ X; Σ b = n/s; Σ_{ε∋i} b = 1; Σ_{ε∋i,j} b = g(Q(x_i − x_j)); joined to the class LP at |S| = s."""
    p = model.p
    idx = {v: i for i, v in enumerate(X)}
    E = induced_edges(X, p); adj = [set() for _ in X]
    for i, j in E:
        adj[i].add(j); adj[j].add(i)
    # enumerate independent subsets
    atoms = []
    def rec(i, cur, banned):
        if i == len(X):
            atoms.append(tuple(cur)); return
        rec(i + 1, cur, banned)
        if i not in banned:
            rec(i + 1, cur + [i], banned | adj[i])
    rec(0, [], set())
    m = len(atoms); ng = len(model.cs); nv = ng + m
    A_ub = [row + [0.0] * m for row in model.A_ub]; b_ub = list(model.b_ub)
    if extra_A_ub:
        for row, b in extra_A_ub:
            A_ub.append(row + [0.0] * m); b_ub.append(b)
    A_eq = []; b_eq = []
    A_eq.append(list(model.size_vec()) + [0.0] * m); b_eq.append(s - 1.0)
    A_eq.append([0.0] * ng + [1.0] * m); b_eq.append(model.n / s)
    for i in range(len(X)):
        A_eq.append([0.0] * ng + [1.0 if i in a else 0.0 for a in atoms]); b_eq.append(1.0)
    for i in range(len(X)):
        for j in range(i + 1, len(X)):
            c = Q(sub(X[i], X[j], p), p)
            row = [0.0] * nv
            for k, a in enumerate(atoms):
                if i in a and j in a:
                    row[ng + k] = 1.0
            if c == 1:
                assert not any(row), "adjacent pair inside an atom"
                continue
            if c == 0:
                raise AssertionError("repeated point")
            row[model.ci[c]] = -1.0
            A_eq.append(row); b_eq.append(0.0)
    r = linprog(np.zeros(nv), A_ub=np.array(A_ub), b_ub=np.array(b_ub), A_eq=np.array(A_eq), b_eq=np.array(b_eq),
                bounds=[(0, None)] * nv, method="highs")
    if r.status == 0:
        return True, m
    if r.status == 2:
        return False, m
    raise RuntimeError(r.message)


def largest_feasible_atoms(model, X, lo, hi):
    """bisect the largest integer s in [lo, hi] feasible for the atom LP on X (reported as measured)"""
    assert atoms_feasible(model, X, lo)[0]
    if atoms_feasible(model, X, hi)[0]:
        return hi
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if atoms_feasible(model, X, mid)[0]:
            lo = mid
        else:
            hi = mid
    return lo


def largest_feasible(model, lo, hi):
    """bisect the largest integer s in [lo, hi] with feasible_at(s) (monotone for the true problem; reported as measured)"""
    assert model.feasible_at(lo)[0]
    if model.feasible_at(hi)[0]:
        return hi
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if model.feasible_at(mid)[0]:
            lo = mid
        else:
            hi = mid
    return lo


def run(p, graphs, szekely, target, atoms_sets, verbose=True):
    t0 = time.time()
    lib = graph_library(p)
    base = Model(p)
    delsarte, _ = base.solve_max()
    rec = dict(kind="fplane-lp", p=p, n=p * p, delsarte_theta_prime=delsarte, graphs={}, rows={})
    if verbose:
        print(f"[lp] p={p}: Delsarte LP (ϑ′) = {delsarte:.4f}; graphs available: {sorted(lib)}", flush=True)
    m = Model(p)
    for name in graphs:
        if name not in lib:
            print(f"[lp]   {name}: not drawable at p={p}, skipped", flush=True); continue
        V = lib[name]; E = induced_edges(V, p); a = alpha_exact(len(V), E)
        k = m.add_subgraph_rows(name, V, a)
        rec["graphs"][name] = dict(vertices=len(V), edges=len(E), alpha=a, rows=k)
        if verbose:
            print(f"[lp]   {name}: {len(V)} vertices, {len(E)} edges, α = {a}, {k} distinct translate rows", flush=True)
    strengthened, g = m.solve_max()
    rec["strengthened_max"] = strengthened
    if verbose:
        print(f"[lp] max |S| with subgraph rows = {strengthened:.4f}  (Delsarte {delsarte:.4f}; drop {100*(1-strengthened/delsarte):.3f}%)", flush=True)
    if target:
        for name in szekely:
            if name in lib:
                m.add_szekely_row(name, lib[name], target)
        feas, _ = m.feasible_at(target)
        rec["target"] = target; rec["feasible_at_target_subgraph_szekely"] = feas
        if verbose:
            print(f"[lp] size {target} with subgraph + Székely rows: {'FEASIBLE' if feas else 'INFEASIBLE → α < %d' % target}", flush=True)
        for name in atoms_sets:
            if name in lib:
                feas_a, na = atoms_feasible(m, lib[name], target)
                rec.setdefault("atoms", {})[name] = dict(atoms=na, feasible_at_target=feas_a)
                if verbose:
                    print(f"[lp] atoms LP on {name} ({na} atoms) at size {target}: {'FEASIBLE' if feas_a else 'INFEASIBLE → α < %d' % target}", flush=True)
    rec["rows"] = m.rows_note; rec["seconds"] = time.time() - t0
    return rec


def self_test():
    """controls: (i) no rows → ϑ′ as recorded; (ii) at 11 every family keeps 28 feasible (α(11) = 28 is verified);
    (iii) at 19 keeps 76 feasible; (iv) a planted α_V − 1 on the wheel at 11 must make 28 infeasible or lower the max
    below the truth — the rows are live"""
    ok = True
    def check(name, cond):
        nonlocal ok
        print(f"  [{'ok' if cond else 'FAIL'}] {name}"); ok = ok and cond
    r11 = run(11, ["triangle", "rhombus", "wheel6", "spindle", "circle+centre"], ["wheel6", "circle+centre"], 28, ["wheel6", "spindle"], verbose=False)
    check("p=11 Delsarte = 34.55 (theta-below-84 record)", abs(r11["delsarte_theta_prime"] - 34.55) < 0.01)
    check("p=11 size 28 stays feasible (subgraph + Székely)", r11["feasible_at_target_subgraph_szekely"])
    check("p=11 size 28 stays feasible (atoms)", all(v["feasible_at_target"] for v in r11.get("atoms", {}).values()))
    check("p=11 strengthened max ≥ 28", r11["strengthened_max"] >= 28 - 1e-6)
    lib = graph_library(11)
    check("p=11 α(wheel6)=3, α(spindle)=2, α(circle+centre)=(p+1)/2",
          alpha_exact(7, induced_edges(lib["wheel6"], 11)) == 3 and alpha_exact(7, induced_edges(lib["spindle"], 11)) == 2
          and alpha_exact(13, induced_edges(lib["circle+centre"], 11)) == 6)
    # planted fault: claim α(wheel6) = 2 (false); the LP must move below the truth's certificate size at 11
    m = Model(11); m.add_subgraph_rows("wheel6-planted", lib["wheel6"], 2)
    planted, _ = m.solve_max()
    truth = Model(11); truth.add_subgraph_rows("wheel6", lib["wheel6"], 3); true_max, _ = truth.solve_max()
    check(f"planted α(wheel6)=2 gives {planted:.2f} < {true_max:.2f} with the true α — rows are live, two-sided: "
          f"0 < {true_max - planted:.2f} < {true_max - 28:.2f}", 0 < true_max - planted < true_max - 28 + 1e-9)
    r19 = run(19, ["circle+centre"], ["circle+centre"], 76, [], verbose=False)
    check("p=19 size 76 stays feasible", r19["feasible_at_target_subgraph_szekely"])
    print("self-test", "PASSED" if ok else "FAILED"); return ok


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--p", type=int)
    ap.add_argument("--graphs", default="triangle,rhombus,wheel6,spindle,circle+centre")
    ap.add_argument("--szekely", default="wheel6,circle+centre")
    ap.add_argument("--atoms", default="wheel6,spindle")
    ap.add_argument("--target", type=int, default=0, help="the size to test for feasibility (default ⌈n/k⌉ needs --k)")
    ap.add_argument("--k", type=int, default=0)
    ap.add_argument("--out")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        sys.exit(0 if self_test() else 1)
    target = a.target or (math.ceil(a.p * a.p / a.k) if a.k else 0)
    rec = run(a.p, [g for g in a.graphs.split(",") if g], [g for g in a.szekely.split(",") if g], target, [g for g in a.atoms.split(",") if g])
    rec["claim_scope"] = ("a relaxation: Delsarte's LP over the norm classes plus inclusion–exclusion rows from small unit-distance subgraphs "
                          "([KMOR2016] (2) over all translates, (3) Székely, [AmbrusEtAl2023] atoms); INFEASIBLE at a size certifies α below it "
                          "on the LP solver's word (floats, HiGHS); FEASIBLE certifies nothing")
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True); Path(a.out).write_text(json.dumps(rec, indent=1)); print(f"  wrote {a.out}")

if __name__ == "__main__":
    main()
