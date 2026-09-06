#!/usr/bin/env python3
"""additive — the finite additive theory of a unit-distance chunk (M56, plans/M56-arithmetic-of-tightness.md).

A chunk X (exact points in a number field, unit edges) has a difference lattice Λ = ℤ-span of its edge
vectors. An ADDITIVE k-colouring of X is a homomorphism φ : Λ → G, |G| = k, nonzero on every edge vector;
it colours a unit-component by φ(p − p₀). Every additive colouring is a proper colouring (L2), so

    F_true(X, k)  ⊆  F_add(X, k) := the pairs every admissible φ identifies       (plans/M56 §S1 L2)

and every difference in kΛ is identified by every admissible φ (L1: a group of order k has exponent | k).
Kempe swaps of an additive colouring separate more: a same-coloured pair whose difference misses the
sublattice Λ_c^φ = ⟨u : φ(u) = ±c⟩ is separated by swapping the two classes at difference c on one
component (§M1.5), so F_true ⊆ F_add ∩ F_K.

    python3 tools/additive.py self-test                                 # planted controls, red seen first
    python3 tools/additive.py lattice  --seed
    python3 tools/additive.py homs     --seed --k 5
    python3 tools/additive.py forced   --object LABEL --k 4 --dial data/m53/rigidity-dial-it4.json
    python3 tools/additive.py kempe    --object LABEL --k 4 --dial …
    python3 tools/additive.py defect   --seed --k 5 --colourings data/m56/colourings-EI-seed-k5.json
    python3 tools/additive.py additive-test --seed --k 5 --colourings …
    python3 tools/additive.py obstruct --degrey --k 4

VERDICTS (§M2.4, exactly these words): `forced-additively` (every admissible φ identifies the pair —
THEORY-LEVEL: F_add ⊇ F_true, it does NOT say every colouring identifies them), `separated-additively`
(an admissible φ separates them — the colouring is in the record, verified proper: a CERTIFICATE that
the pair is not forced), `kempe-separated` with mechanism `sublattice` | `component` (the swapped
colouring is built and verified), `kempe-forced` (theory-level), `not-comparable` (different
unit-components), `vacuous` (no admissible φ — says nothing about χ), `undecided` (a cap).
The jackpot protocol is never reached here: `forced --k 5 --sweep FILE` lists `candidates_for_ask` and
`five_dial.py ask` decides. UNTRUSTED like everything in tools/; every emitted colouring is re-verified
on the stage's edge list before it is written."""
from __future__ import annotations
import argparse, hashlib, itertools, json, math, sys, time
from collections import Counter, defaultdict
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "m56"
FORCED_LICENCE = ("A row reading forced-additively says every ADDITIVE colouring of this chunk gives the pair one "
                  "colour; it does NOT say every colouring does — the fabric's valuation-4 pairs are the standing "
                  "counterexample (forced-additively, separated by the solver). A row reading separated-additively "
                  "or kempe-separated comes with an explicit proper colouring in the same file, verified; it IS a "
                  "certificate that the pair is not forced. vacuous means no additive colouring exists and says "
                  "nothing about χ.")


# ====================================================================== exact frames and stages
class Frame:
    """How a point's exact coordinates become a rational vector, and how exact squared distances are read.
    `dim` rationals per point; `dist2_key(p, q)` returns a hashable exact key; `is_rational_dist2(key)`
    turns a key into a Fraction when the squared distance is rational (else None)."""
    def __init__(self, name: str, meaning: str, dim: int):
        self.name, self.meaning, self.dim = name, meaning, dim

    def dist2_key(self, p, q):
        raise NotImplementedError

    def rational_of_key(self, key):
        raise NotImplementedError

    def header(self):
        return dict(name=self.name, meaning=self.meaning, dim=self.dim)


class FrameEI4(Frame):
    """(a, b, c, d) ↦ ((a√3 + b√11)/12, (c + d√33)/12); dist² = (3α² + 11β² + γ² + 33δ² + 2(αβ + γδ)√33)/144."""
    def __init__(self):
        super().__init__("EI4", "((a*sqrt3 + b*sqrt11)/12, (c + d*sqrt33)/12)", 4)

    def dist2_key(self, p, q):
        al, be, ga, de = (p[i] - q[i] for i in range(4))
        return (3 * al * al + 11 * be * be + ga * ga + 33 * de * de, al * be + ga * de)   # (×144, √33-part ×72)

    def rational_of_key(self, key):
        return key[0] / 144 if key[1] == 0 else None


class FrameK8(Frame):
    """x = (x0, x1, x2, x3), y likewise over (1, √3, √11, √33): 8 rationals."""
    def __init__(self):
        super().__init__("K8", "(x, y) each over the basis (1, sqrt3, sqrt11, sqrt33)", 8)

    @staticmethod
    def _sq(v):
        from copy_exact_field import K
        a = K(*v[:4]); b = K(*v[4:])
        s = a * a + b * b
        return tuple(s.c)

    def dist2_key(self, p, q):
        return self._sq(tuple(p[i] - q[i] for i in range(8)))

    def rational_of_key(self, key):
        return key[0] if key[1] == 0 and key[2] == 0 and key[3] == 0 else None


class FrameKExt16(Frame):
    """x = A + √m B, y likewise, A, B ∈ K: 16 rationals (K's 4-basis four times)."""
    def __init__(self, m: int):
        super().__init__(f"K{m}-16", f"(x, y) each as A + sqrt({m})*B with A, B over (1, sqrt3, sqrt11, sqrt33)", 16)
        self.m = m

    def dist2_key(self, p, q):
        from copy_exact_field import K
        from five_dial import KExt
        KExt.m = self.m
        d = [p[i] - q[i] for i in range(16)]
        x = KExt(K(*d[0:4]), K(*d[4:8])); y = KExt(K(*d[8:12]), K(*d[12:16]))
        s = x * x + y * y
        return tuple(s.A.c) + tuple(s.B.c)

    def rational_of_key(self, key):
        return key[0] if all(c == 0 for c in key[1:]) else None


class FrameField16(Frame):
    """tools/field.py's 16-vector over {√(∏S) : S ⊆ primes}, x and y: 32 rationals (integers over `denom`)."""
    def __init__(self, primes, denom: int):
        super().__init__(f"field16{primes}", f"(x, y) each a 16-vector over the square-free radicals of {primes}, scaled by 1/{denom}", 32)
        self.primes, self.denom = list(primes), denom
        import field as Fld
        self.tab = Fld.mul_table(self.primes)
        self.Fld = Fld

    def dist2_key(self, p, q):
        # p, q are 32 Fractions = integer coordinates / denom; work on the integer vectors and remember the denominator²
        dx = [int((p[i] - q[i]) * self.denom) for i in range(16)]
        dy = [int((p[16 + i] - q[16 + i]) * self.denom) for i in range(16)]
        s = self.Fld.add(self.Fld.mul(dx, dx, self.tab), self.Fld.mul(dy, dy, self.tab))
        return tuple(Fr(c, self.denom * self.denom) for c in s)

    def rational_of_key(self, key):
        return key[0] if all(c == 0 for c in key[1:]) else None


class FrameQ(Frame):
    """A rational ℚ^d frame with the standard inner product (the planted grids; dim = 2d)."""
    def __init__(self, d: int, meaning: str):
        super().__init__(f"Q{d}", meaning, d)

    def dist2_key(self, p, q):
        return (sum((p[i] - q[i]) ** 2 for i in range(self.dim)),)

    def rational_of_key(self, key):
        return key[0]


class FrameHex(Frame):
    """ℤ[ζ₆] in the basis (1, ζ₆): (a, b) ↦ a + bζ₆; |a + bζ₆|² = a² + ab + b²."""
    def __init__(self):
        super().__init__("hex2", "(a, b) meaning a + b*zeta6", 2)

    def dist2_key(self, p, q):
        a, b = p[0] - q[0], p[1] - q[1]
        return (a * a + a * b + b * b,)

    def rational_of_key(self, key):
        return key[0]


class Chunk:
    """A finite graph with exact points: name, points (list of tuples of Fractions), edges, frame, the
    loader's unit claim. Components and the fingerprint (the same recipe as five_dial.Stage) are derived."""
    def __init__(self, name, points, edges, frame: Frame, source: str, unit_verified: str, meta=None, floats=None):
        self.name, self.points, self.frame, self.source, self.unit_verified = name, points, frame, source, unit_verified
        self.n = len(points)
        self.edges = sorted({(min(u, v), max(u, v)) for u, v in edges if u != v})
        self.meta = dict(meta or {})
        self.adj = [set() for _ in range(self.n)]
        for u, v in self.edges:
            self.adj[u].add(v); self.adj[v].add(u)
        self.comp = [-1] * self.n
        self.bases = []
        for s in range(self.n):
            if self.comp[s] != -1:
                continue
            self.bases.append(s); self.comp[s] = len(self.bases) - 1; stack = [s]
            while stack:
                x = stack.pop()
                for y in self.adj[x]:
                    if self.comp[y] == -1:
                        self.comp[y] = self.comp[s]; stack.append(y)
        self._floats = floats

    def fingerprint(self) -> str:
        h = hashlib.sha256(); h.update(f"{self.n}\n".encode())
        for u, v in self.edges:
            h.update(f"{u} {v}\n".encode())
        return h.hexdigest()[:16]

    def header(self) -> dict:
        return dict(name=self.name, n=self.n, edges=len(self.edges), fingerprint=self.fingerprint(), source=self.source,
                    frame=self.frame.header(), unit_verified=self.unit_verified, components=len(self.bases), **self.meta)

    def label(self) -> str:
        return f"{self.name} (n={self.n}, edges={len(self.edges)}, fp={self.fingerprint()}, frame={self.frame.name})"

    def diff(self, u, v):
        return tuple(self.points[u][i] - self.points[v][i] for i in range(self.frame.dim))

    def floats(self):
        """Float positions for candidate proposal (exact arithmetic disposes)."""
        if self._floats is None:
            self._floats = np.array([float_of(self.frame, p) for p in self.points])
        return self._floats

    def pairs_at(self, d2: Fr):
        """Every same-component pair at EXACT squared distance d2 (float proposes within 1e-6, the frame disposes)."""
        from scipy.spatial import cKDTree
        xy = self.floats(); tree = cKDTree(xy); r = math.sqrt(float(d2))
        cand = tree.query_pairs(r + 1e-6) - set(tree.query_pairs(max(r - 1e-6, 0.0)))
        out = []
        for u, v in sorted(cand):
            if self.comp[u] != self.comp[v]:
                continue
            key = self.frame.dist2_key(self.points[u], self.points[v])
            if self.frame.rational_of_key(key) == d2:
                out.append((u, v))
        return out


def float_of(frame: Frame, p):
    if frame.name == "EI4":
        a, b, c, d = (float(x) for x in p)
        return ((a * 3 ** 0.5 + b * 11 ** 0.5) / 12, (c + d * 33 ** 0.5) / 12)
    if frame.name == "K8":
        r = [1.0, 3 ** 0.5, 11 ** 0.5, 33 ** 0.5]
        return (sum(float(p[i]) * r[i] for i in range(4)), sum(float(p[4 + i]) * r[i] for i in range(4)))
    if frame.name.startswith("K") and frame.name.endswith("-16"):
        m = int(frame.name[1:-3]); r = [1.0, 3 ** 0.5, 11 ** 0.5, 33 ** 0.5]
        A = lambda v: sum(float(v[i]) * r[i] for i in range(4))
        return (A(p[0:4]) + m ** 0.5 * A(p[4:8]), A(p[8:12]) + m ** 0.5 * A(p[12:16]))
    if frame.name.startswith("field16"):
        vals = []
        for k in range(16):
            v = 1.0
            for j, pr in enumerate(frame.primes):
                if k >> j & 1:
                    v *= pr ** 0.5
            vals.append(v)
        return (sum(float(p[i]) * vals[i] for i in range(16)), sum(float(p[16 + i]) * vals[i] for i in range(16)))
    if frame.name == "hex2":
        a, b = float(p[0]), float(p[1])
        return (a + b / 2, b * 3 ** 0.5 / 2)
    if frame.name.startswith("Q"):
        return tuple(float(x) for x in p)
    raise ValueError(frame.name)


# ---------------------------------------------------------------------- loaders
def load_seed() -> Chunk:
    import twodist as T
    H = T.ei_H(); c = T.classify(H, radii=(1,))
    A, B = H.index(T.EI_A), H.index(T.EI_B)
    return Chunk("EI-seed-unit", [tuple(p) for p in H], c[1], FrameEI4(), "twodist.ei_H() unit edges (the seed's unit part; cheats are NOT edges here)",
                 "every edge verified by twodist.dist2_is (exact)", meta=dict(forced_pair=[A, B], cheats=446))


def load_object(label: str) -> Chunk:
    import batchkill as BK
    obj, removed = BK.load_object(label)
    ex = json.loads((ROOT / "data" / "m52" / f"exact-{label}.json").read_text())
    pts = {}
    ei_shape = True
    for k, v in ex["points"].items():
        A_, B_ = v["x"]; assert all(nn == 0 for nn, dd in B_), ("a K(√5) point — additive.py's K loaders are for K-point objects", k)
        x = [Fr(nn, dd) for nn, dd in A_]
        A_, B_ = v["y"]; assert all(nn == 0 for nn, dd in B_)
        y = [Fr(nn, dd) for nn, dd in A_]
        if not (x[0] == 0 and x[3] == 0 and y[1] == 0 and y[2] == 0):
            ei_shape = False
        pts[int(k)] = (x, y)
    live = sorted(pts); idx = {v: i for i, v in enumerate(live)}
    ue = [(idx[u], idx[v]) for u, v in obj.unit_edges() if u in idx and v in idx]
    if ei_shape:
        P = [(12 * pts[v][0][1], 12 * pts[v][0][2], 12 * pts[v][1][0], 12 * pts[v][1][3]) for v in live]; fr = FrameEI4()
    else:
        P = [tuple(pts[v][0]) + tuple(pts[v][1]) for v in live]; fr = FrameK8()
    return Chunk(f"object-{label[-24:]}", P, ue, fr, f"descent object {label}: data/m52/exact-{label}.json (live vertices re-indexed 0..n−1 in object order)",
                 ex.get("claim_scope", "exact file"), meta=dict(object=label, live_index_of_object=live, forced_pair=[idx[obj.A], idx[obj.B]]))


def load_witness(path: str) -> Chunk:
    d = json.loads(Path(path).read_text())
    m = int(d["m"]); fr = FrameKExt16(m)
    P = []
    for pt in d["points"]:
        (xA, xB), (yA, yB) = pt
        P.append(tuple(Fr(n_, d_) for n_, d_ in xA) + tuple(Fr(n_, d_) for n_, d_ in xB) + tuple(Fr(n_, d_) for n_, d_ in yA) + tuple(Fr(n_, d_) for n_, d_ in yB))
    return Chunk(d["stage"]["name"], P, [tuple(e) for e in d["edges"]], fr, f"exact witness {path}", d.get("claim_scope", "exact file"),
                 meta=dict(centre_index=d.get("centre_index"), cross_chords=d.get("cross_chords")))


def load_field16(path: str, name: str) -> Chunk:
    import field as Fld
    d = json.loads(Path(path).read_text())
    primes, denom = d["primes"], int(d["denom"])
    fr = FrameField16(primes, denom)
    P = [tuple(Fr(c, denom) for c in xy[0]) + tuple(Fr(c, denom) for c in xy[1]) for xy in d["coords"]]
    E = [tuple(e) for e in d["edges"]]
    bad = [(u, v) for u, v in E if not Fld.is_unit((d["coords"][u][0], d["coords"][u][1]), (d["coords"][v][0], d["coords"][v][1]), denom, fr.tab)]
    assert not bad, (f"{name}: {len(bad)} listed edges are not exactly unit", bad[:3])
    return Chunk(name, P, E, fr, f"{path} (vertex order of the file; the same order as tools/degrey_graph.json for the 1581)",
                 f"all {len(E)} edges verified unit by field.is_unit at load")


def load_graph(path: str) -> Chunk:
    d = json.loads(Path(path).read_text())
    if "frame" not in d:
        raise SystemExit("additive.py needs EXACT coordinates: --graph takes this tool's exact JSON (frame + rational points + edges); "
                         "a float graph is refused. Exact loaders: --seed, --object LABEL, --witness PATH, --heule510, --degrey, --planted NAME.")
    fr = frame_of_name(d["frame"])
    P = [tuple(Fr(x) if isinstance(x, str) else Fr(x[0], x[1]) for x in p) for p in d["points"]]
    return Chunk(d.get("name", Path(path).stem), P, [tuple(e) for e in d["edges"]], fr, f"graph {path}", d.get("unit_verified", "as given"))


def frame_of_name(name: str) -> Frame:
    if name == "EI4":
        return FrameEI4()
    if name == "K8":
        return FrameK8()
    if name == "hex2":
        return FrameHex()
    if name.startswith("Q"):
        return FrameQ(int(name[1:]), "rational coordinates")
    raise SystemExit(f"unknown frame {name}")


def load_chunk(a) -> Chunk:
    if getattr(a, "seed", False):
        return load_seed()
    if getattr(a, "object", None):
        return load_object(a.object)
    if getattr(a, "witness", None):
        return load_witness(a.witness)
    if getattr(a, "heule510", False):
        return load_field16(str(ROOT / "tools" / "heule510.json"), "heule510")
    if getattr(a, "degrey", False):
        return load_field16(str(ROOT / "tools" / "degrey_cert.json"), "degrey1581")
    if getattr(a, "field16", None):
        return load_field16(a.field16, Path(a.field16).stem)
    if getattr(a, "graph", None):
        return load_graph(a.graph)
    if getattr(a, "planted", None):
        return planted(a.planted)
    raise SystemExit("no stage given (--seed | --object LABEL | --witness PATH | --heule510 | --degrey | --field16 FILE | --graph FILE | --planted NAME)")


# ---------------------------------------------------------------------- planted stages
def planted(name: str) -> Chunk:
    if name == "grid":
        R = 3; pts = [(Fr(x), Fr(y)) for x in range(-R, R + 1) for y in range(-R, R + 1)]
        idx = {p: i for i, p in enumerate(pts)}
        E = [(idx[p], idx[(p[0] + 1, p[1])]) for p in pts if (p[0] + 1, p[1]) in idx] + [(idx[p], idx[(p[0], p[1] + 1)]) for p in pts if (p[0], p[1] + 1) in idx]
        return Chunk("planted-grid", pts, E, FrameQ(2, "Z^2 ball, unit edges = the 4-neighbours"), "planted", "by construction", meta=dict(origin=idx[(Fr(0), Fr(0))]))
    if name == "hex":
        R = 3; pts = [(Fr(a), Fr(b)) for a in range(-R, R + 1) for b in range(-R, R + 1) if abs(a + b) <= R]
        idx = {p: i for i, p in enumerate(pts)}
        units = [(1, 0), (0, 1), (-1, 1)]
        E = [(idx[p], idx[(p[0] + u, p[1] + v)]) for p in pts for u, v in units if (p[0] + u, p[1] + v) in idx]
        return Chunk("planted-hex", pts, E, FrameHex(), "planted", "by construction", meta=dict(origin=idx[(Fr(0), Fr(0))]))
    if name in ("moser", "k4e", "l7-moser", "disconnected"):
        # K8 frame: (x0,x1,x2,x3, y0,y1,y2,y3) over (1,√3,√11,√33)
        def pt(x, y): return tuple(x) + tuple(y)
        O = pt((0, 0, 0, 0), (0, 0, 0, 0)); one = pt((1, 0, 0, 0), (0, 0, 0, 0))
        z6 = pt((Fr(1, 2), 0, 0, 0), (0, Fr(1, 2), 0, 0)); onez6 = pt((Fr(3, 2), 0, 0, 0), (0, Fr(1, 2), 0, 0))
        rho = pt((Fr(5, 6), 0, 0, 0), (0, 0, Fr(1, 6), 0)); rhob = pt((Fr(5, 6), 0, 0, 0), (0, 0, Fr(-1, 6), 0))
        rz6 = pt((Fr(5, 12), 0, 0, Fr(-1, 12)), (0, Fr(5, 12), Fr(1, 12), 0))       # ρζ₆ = (5 − √33 + i(5√3 + √11))/12
        rho1z6 = tuple(rho[i] + rz6[i] for i in range(8))                             # ρ(1 + ζ₆)
        two = pt((2, 0, 0, 0), (0, 0, 0, 0)); rr = pt((Fr(5, 3), 0, 0, 0), (0, 0, 0, 0))
        if name == "moser":
            P = [O, one, z6, onez6, rho, rz6, rho1z6]
            E = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (0, 4), (0, 5), (4, 5), (4, 6), (5, 6), (3, 6)]
            ch = Chunk("planted-moser", [tuple(Fr(x) for x in p) for p in P], E, FrameK8(), "planted", "checked below")
        elif name == "k4e":
            P = [O, one, z6, onez6]; E = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3)]
            ch = Chunk("planted-k4e", [tuple(Fr(x) for x in p) for p in P], E, FrameK8(), "planted", "checked below")
        elif name == "l7-moser":
            P = [O, one, two, rho, rhob, rr]; E = [(0, 1), (1, 2), (0, 3), (0, 4), (3, 5), (4, 5)]
            ch = Chunk("planted-l7-moser", [tuple(Fr(x) for x in p) for p in P], E, FrameK8(), "planted: {0, 1, 2, ρ, ρ̄, ρ + ρ̄} for the Moser twist ρ = (5 + i√11)/6", "checked below")
        else:
            far = pt((10, 0, 0, 0), (0, 0, 0, 0))
            P = [O, one, z6, onez6] + [tuple(p[i] + far[i] for i in range(8)) for p in (O, one, z6, onez6)]
            E = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (4, 5), (4, 6), (5, 6), (5, 7), (6, 7)]
            ch = Chunk("planted-disconnected", [tuple(Fr(x) for x in p) for p in P], E, FrameK8(), "planted", "checked below")
        for u, v in ch.edges:
            assert ch.frame.rational_of_key(ch.frame.dist2_key(ch.points[u], ch.points[v])) == 1, ("planted edge not unit", name, u, v)
        ch.unit_verified = "every planted edge verified unit in K8 at construction"
        return ch
    if name in ("l7-rho15", "l7-heule"):
        import field as Fld
        primes = [3, 5, 7, 11]; denom = 64
        fr = FrameField16(primes, denom)
        def vec(rat_coeffs):   # {basis_index: Fraction} → integer 16-vector over denom
            v = [0] * 16
            for i, q in rat_coeffs.items():
                x = Fr(q) * denom; assert x.denominator == 1; v[i] = int(x)
            return v
        r15 = 1 | 2   # √3·√5 = √15 → bits 0,1
        r5, r11 = 2, 8
        if name == "l7-rho15":
            # ρ = (7 + i√15)/8: chunk {0, 1, 2, ρ, ρ̄, ρ + ρ̄ = 7/4}; 1/4 = 2 − 7/4 ∈ Λ so 1 ∈ 4Λ
            pts = [(vec({}), vec({})), (vec({0: 1}), vec({})), (vec({0: 2}), vec({})),
                   (vec({0: Fr(7, 8)}), vec({r15: Fr(1, 8)})), (vec({0: Fr(7, 8)}), vec({r15: Fr(-1, 8)})), (vec({0: Fr(7, 4)}), vec({}))]
            E = [(0, 1), (1, 2), (0, 3), (0, 4), (3, 5), (4, 5)]; nm = "planted-l7-rho15"
        else:
            # ξ = (√5 + i√11)/4 (Heule's field, no √7): ξ² = (5 − 11 + 2i√55)/16 = (−3/8) + i√55/8; chunk {0, 1, 2, ξ², ξ̄², ξ² + ξ̄² = −3/4}
            r55 = 2 | 8
            pts = [(vec({}), vec({})), (vec({0: 1}), vec({})), (vec({0: 2}), vec({})),
                   (vec({0: Fr(-3, 8)}), vec({r55: Fr(1, 8)})), (vec({0: Fr(-3, 8)}), vec({r55: Fr(-1, 8)})), (vec({0: Fr(-3, 4)}), vec({}))]
            E = [(0, 1), (1, 2), (0, 3), (0, 4), (3, 5), (4, 5)]; nm = "planted-l7-heule"
        for u, v in E:
            assert Fld.is_unit(pts[u], pts[v], denom, fr.tab), ("planted edge not unit", name, u, v)
        P = [tuple(Fr(c, denom) for c in xy[0]) + tuple(Fr(c, denom) for c in xy[1]) for xy in pts]
        return Chunk(nm, P, E, fr, "planted (L7 witness chunk)", "every planted edge verified unit by field.is_unit")
    if name == "l7-rho247":
        from copy_exact_field import K
        # ρ = (119 + 3i√247)/128 in K247-16: x = A + √247 B, A, B ∈ K over (1, √3, √11, √33)
        def kp(x_A, x_B, y_A, y_B): return tuple(x_A) + tuple(x_B) + tuple(y_A) + tuple(y_B)
        z = (Fr(0),) * 4
        O = kp(z, z, z, z); one = kp((Fr(1), 0, 0, 0), z, z, z); two = kp((Fr(2), 0, 0, 0), z, z, z)
        rho = kp((Fr(119, 128), 0, 0, 0), z, z, (Fr(3, 128), 0, 0, 0)); rhob = kp((Fr(119, 128), 0, 0, 0), z, z, (Fr(-3, 128), 0, 0, 0))
        rr = kp((Fr(119, 64), 0, 0, 0), z, z, z)
        P = [tuple(Fr(x) for x in p) for p in (O, one, two, rho, rhob, rr)]; E = [(0, 1), (1, 2), (0, 3), (0, 4), (3, 5), (4, 5)]
        ch = Chunk("planted-l7-rho247", P, E, FrameKExt16(247), "planted (L7 witness chunk)", "checked below")
        for u, v in E:
            assert ch.frame.rational_of_key(ch.frame.dist2_key(ch.points[u], ch.points[v])) == 1, ("planted edge not unit", name, u, v)
        ch.unit_verified = "every planted edge verified unit in K(√247)"
        return ch
    raise SystemExit(f"unknown planted stage {name}")


# ====================================================================== the lattice
def egcd(a, b):
    if b == 0:
        return (abs(a), (1 if a >= 0 else -1), 0)
    g, x, y = egcd(b, a % b)
    return (g, y, x - (a // b) * y)


class Lattice:
    """The ℤ-span of integer vectors of length n as a reduced echelon (Hermite) basis. `coords` expresses a
    rational vector in the basis (None if outside the ℚ-span); membership in mΛ is `depth`."""
    def __init__(self, n):
        self.n = n; self.rows = {}

    def insert(self, v):
        v = list(v)
        for col in range(self.n):
            if v[col] == 0:
                continue
            if col in self.rows:
                row = self.rows[col]; a, b = row[col], v[col]
                g, x, y = egcd(a, b)
                new = [x * r + y * w for r, w in zip(row, v)]
                v = [(a // g) * w - (b // g) * r for r, w in zip(row, v)]
                self.rows[col] = new
                continue
            if v[col] < 0:
                v = [-w for w in v]
            self.rows[col] = v
            return

    def reduce(self):
        cols = sorted(self.rows)
        for i, c in enumerate(cols):
            for c2 in cols[i + 1:]:
                r2 = self.rows[c2]; p = r2[c2]
                q = self.rows[c][c2] // p
                if q:
                    self.rows[c] = [a - q * b for a, b in zip(self.rows[c], r2)]

    @property
    def rank(self):
        return len(self.rows)

    def basis(self):
        return [self.rows[c] for c in sorted(self.rows)]

    def coords(self, w):
        w = [Fr(x) for x in w]; out = []
        for c in sorted(self.rows):
            row = self.rows[c]; q = w[c] / row[c]; out.append(q)
            w = [a - q * b for a, b in zip(w, row)]
        return None if any(w) else out

    @staticmethod
    def depth(coords, p: int):
        """min p-adic valuation over the coordinates (∞ for 0); None if some coordinate is non-integral."""
        if coords is None or any(x.denominator != 1 for x in coords):
            return None
        best = math.inf
        for x in coords:
            n_ = abs(int(x))
            if n_ == 0:
                continue
            v = 0
            while n_ % p == 0:
                n_ //= p; v += 1
            best = min(best, v)
        return best


def build_lattice(ch: Chunk):
    """Λ(X) from the edge vectors, scaled to integers by the chunk's global denominator; checked two ways."""
    scale = 1
    for p in ch.points:
        for x in p:
            scale = scale * x.denominator // math.gcd(scale, x.denominator)
    vecs = []
    for u, v in ch.edges:
        d = tuple(int((ch.points[u][i] - ch.points[v][i]) * scale) for i in range(ch.frame.dim))
        vecs.append(d)
    L = Lattice(ch.frame.dim)
    for d in vecs:
        L.insert(d)
    L.reduce()
    # control 1: every edge vector has integral coordinates (span ⊇ E)
    bad = [i for i, d in enumerate(vecs) if Lattice.depth(L.coords(d), 2) is None]
    assert not bad, ("lattice: an edge vector is not in its own span?!", bad[:3])
    # control 2: a second insertion order gives the same reduced basis (uniqueness ⟹ the same span)
    L2 = Lattice(ch.frame.dim)
    for d in reversed(vecs):
        L2.insert(d)
    L2.reduce()
    assert L.basis() == L2.basis(), "lattice: two insertion orders disagree — the reduction is not canonical"
    return L, vecs, scale


# ====================================================================== groups of order k and homs
def abelian_groups(k: int):
    """Every abelian group of order k as a tuple of cyclic orders (elementary divisors), named."""
    def factor(n):
        out = {}; p = 2
        while p * p <= n:
            while n % p == 0:
                out[p] = out.get(p, 0) + 1; n //= p
            p += 1
        if n > 1:
            out[n] = out.get(n, 0) + 1
        return out

    def partitions(a):
        if a == 0:
            yield []
            return
        def rec(rem, mx):
            if rem == 0:
                yield []
                return
            for first in range(min(rem, mx), 0, -1):
                for rest in rec(rem - first, first):
                    yield [first] + rest
        yield from rec(a, a)
    per_prime = []
    for p, a in sorted(factor(k).items()):
        per_prime.append([[p ** e for e in part] for part in partitions(a)])
    groups = []
    for combo in itertools.product(*per_prime):
        divisors = tuple(sorted((m for part in combo for m in part), reverse=True))
        groups.append(divisors)
    names = {g: "x".join(f"Z/{m}" for m in g) for g in groups}
    return groups, names


def unit_classes(L: Lattice, vecs, m: int):
    """Coordinates of each edge vector mod m, as a set of tuples (with counts)."""
    out = Counter()
    for d in vecs:
        c = L.coords(d)
        out[tuple(int(x) % m for x in c)] += 1
    return out


def enumerate_homs(L: Lattice, vecs, group):
    """All φ ∈ ∏ (ℤ/m_i)^r nonzero on every unit class, by full enumeration (rank ≤ 8)."""
    r = L.rank
    parts = []
    for m in group:
        S = np.array(sorted(unit_classes(L, vecs, m)), dtype=np.int64)
        P = np.array(list(itertools.product(range(m), repeat=r)), dtype=np.int64)
        zero = (S @ P.T) % m == 0           # (k_classes, m^r): φ kills class j
        parts.append((P, zero, S))
    # a hom is a tuple (φ_1, …, φ_t); admissible iff for every unit class, some component is nonzero.
    # unit classes must be aligned across components: index by the edge vector, not by the per-m class
    kill_by_vec = []
    for (P, zero, S), m in zip(parts, group):
        cls = {tuple(s): j for j, s in enumerate(S.tolist())}
        col = [cls[tuple(int(x) % m for x in L.coords(d))] for d in vecs]
        kill_by_vec.append(zero[col, :])   # (n_edges, m^r) boolean: component i kills edge e under φ_i
    # combine: enumerate tuples of indices whose AND over components is all-False on every edge
    sizes = [kb.shape[1] for kb in kill_by_vec]
    out = []
    for combo in itertools.product(*[range(s) for s in sizes]):
        killed = np.ones(len(vecs), dtype=bool)
        for i, c in enumerate(combo):
            killed &= kill_by_vec[i][:, c]
        if not killed.any():
            out.append(tuple(tuple(int(x) for x in parts[i][0][c]) for i, c in enumerate(combo)))
    return out


def sat_homs(L: Lattice, vecs, group, extra_nonzero=(), extra_zero=(), max_models: int = 0, wall: float | None = None):
    """Homs by SAT: variables φ_{i,j} ∈ ℤ/m_i one-hot; for every unit class s (coords mod m_i) the tuple of
    partial sums must be nonzero in some component. `extra_nonzero`/`extra_zero`: further difference vectors
    (integer coordinate tuples) constrained to φ(d) ≠ 0 / φ(d) = 0. Returns (status, models) with
    max_models = 1 for a single model, > 1 to enumerate with blocking clauses up to that many."""
    from pysat.solvers import Solver
    r = L.rank
    nv = [0]
    def new():
        nv[0] += 1; return nv[0]
    clauses = []
    phi = []   # phi[i][j][a] = var "φ_i(basis j) = a"
    for m in group:
        comp = []
        for j in range(r):
            vs = [new() for _ in range(m)]
            clauses.append(vs)
            for a in range(m):
                for b in range(a + 1, m):
                    clauses.append([-vs[a], -vs[b]])
            comp.append(vs)
        phi.append(comp)

    def sum_vars(i, s):
        """one-hot vars for Σ_j s_j φ_i(j) mod m_i"""
        m = group[i]
        cur = None   # list of m vars, cur[a] ⟺ partial sum = a
        for j in range(r):
            if s[j] % m == 0:
                continue
            nxt = [new() for _ in range(m)]
            clauses.append(nxt)
            for a in range(m):
                for b in range(a + 1, m):
                    clauses.append([-nxt[a], -nxt[b]])
            for b in range(m):
                if cur is None:
                    clauses.append([-phi[i][j][b], nxt[(s[j] * b) % m]])
                else:
                    for a in range(m):
                        clauses.append([-cur[a], -phi[i][j][b], nxt[(a + s[j] * b) % m]])
            cur = nxt
        return cur   # None means the sum is identically 0

    def constrain(d, nonzero: bool):
        sums = []
        for i, m in enumerate(group):
            s = tuple(int(x) % m for x in d)
            sv = sum_vars(i, s)
            sums.append(sv)
        if nonzero:
            lits = []
            for i, sv in enumerate(sums):
                if sv is not None:
                    lits.append(-sv[0])          # component i nonzero ⟺ ¬(sum = 0)
            if not lits:
                clauses.append([])               # identically zero: unsatisfiable
            else:
                clauses.append(lits)
        else:
            for sv in sums:
                if sv is not None:
                    clauses.append([sv[0]])
    seen = set()
    for d in vecs:
        key = tuple(int(x) for x in L.coords(d))
        if key in seen:
            continue
        seen.add(key); constrain(key, True)
    for d in extra_nonzero:
        constrain(tuple(int(x) for x in d), True)
    for d in extra_zero:
        constrain(tuple(int(x) for x in d), False)
    models = []
    status = "unsat"
    with Solver(name="cadical153", bootstrap_with=clauses) as s:
        while s.solve():
            model = set(l for l in s.get_model() if l > 0)
            hom = tuple(tuple(next(a for a in range(m) if phi[i][j][a] in model) for j in range(r)) for i, m in enumerate(group))
            models.append(hom); status = "sat"
            if max_models and len(models) >= max_models:
                if max_models > 1:
                    status = "capped" if s.solve() else "sat"   # one more probe: was there another?
                break
            s.add_clause([-phi[i][j][hom[i][j]] for i, m in enumerate(group) for j in range(r)])
    if status == "sat" and max_models > 1:
        status = "sat-complete"
    return status, models


def hom_apply(hom, group, coords):
    """φ(d) as a tuple of residues, then as an int in 0..k−1 (mixed radix)."""
    val = []
    for i, m in enumerate(group):
        val.append(sum(int(c) * a for c, a in zip(coords, hom[i])) % m)
    return tuple(val)


def tuple_to_int(val, group):
    x = 0
    for a, m in zip(val, group):
        x = x * m + a
    return x


def point_coords(ch: Chunk, L: Lattice, scale: int):
    """Integer lattice coordinates of every point relative to its component's base point (cached on the chunk)."""
    key = ("_pc", id(L))
    if getattr(ch, "_pc_key", None) == key:
        return ch._pc
    M = np.zeros((ch.n, L.rank), dtype=np.int64)
    for v in range(ch.n):
        b = ch.bases[ch.comp[v]]
        d = tuple(int((ch.points[v][i] - ch.points[b][i]) * scale) for i in range(ch.frame.dim))
        c = L.coords(d)
        assert c is not None and all(x.denominator == 1 for x in c), ("a point is not at a lattice offset from its component's base", v)
        M[v] = [int(x) for x in c]
    ch._pc_key = key; ch._pc = M
    return M


def colouring_of_hom(ch: Chunk, L: Lattice, scale: int, hom, group):
    """The colour vector (ints 0..k−1) of the additive colouring, per component from its base point."""
    M = point_coords(ch, L, scale)
    col = np.zeros(ch.n, dtype=np.int64)
    for i, m in enumerate(group):
        col = col * m + (M @ np.array(hom[i], dtype=np.int64)) % m
    return [int(x) for x in col]


def verify_proper(col, edges):
    return [(u, v) for u, v in edges if col[u] == col[v]]


def canon(col):
    names = {}
    return tuple(names.setdefault(c, len(names)) for c in col)


def all_homs(ch: Chunk, L, vecs, scale, k, max_models=200000, log=print):
    """Every admissible hom for every group of order k, with its verified colouring; enumeration below rank 9,
    SAT (with blocking, capped) above. Returns the record's `groups` block."""
    groups, names = abelian_groups(k)
    out = []
    for g in groups:
        t0 = time.time()
        if L.rank <= 8:
            homs = enumerate_homs(L, vecs, g); method, exact = "enumerate", True
        else:
            st, homs = sat_homs(L, vecs, g, max_models=max_models); method = "sat"
            exact = st in ("unsat", "sat-complete")
        cols = []
        for h in homs:
            c = colouring_of_hom(ch, L, scale, h, g)
            bad = verify_proper(c, ch.edges)
            assert not bad, ("INSTRUMENT CATASTROPHE: an admissible hom's colouring is not proper", g, h, bad[:3])
            cols.append(c)
        parts = {}
        for i, c in enumerate(cols):
            parts.setdefault(canon(c), i)
        out.append(dict(group=names[g], divisors=list(g), homs=[[list(x) for x in h] for h in homs], colourings=cols,
                        count=len(homs), partitions=len(parts), partition_reps=sorted(parts.values()),
                        method=method, exact=exact, seconds=round(time.time() - t0, 2)))
        log(f"  {names[g]}: {len(homs)} admissible homs ({method}, exact={exact}) = {len(parts)} colourings up to palette [{time.time() - t0:.1f}s]")
    return out


# ====================================================================== commands
def out_path(a, sub: str, ch: Chunk, k=None):
    if getattr(a, "out", None):
        return Path(a.out)
    DATA.mkdir(parents=True, exist_ok=True)
    return DATA / (f"{sub}-{ch.name}" + (f"-k{k}" if k is not None else "") + ".json")


def write(path: Path, rec: dict, log=print):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(rec, indent=1))
    log(f"[additive] wrote {path}")


def cmd_lattice(a):
    ch = load_chunk(a); L, vecs, scale = build_lattice(ch)
    cls = {m: len(unit_classes(L, vecs, m)) for m in (2, 3, 4, 5, 7)}
    print(f"[lattice] {ch.label()}: rank {L.rank} (frame dim {ch.frame.dim}), scale {scale}, {len(ch.bases)} unit-component(s); "
          f"distinct unit classes mod m: {cls}")
    rec = dict(kind="additive-lattice", stage=ch.header(), lattice=dict(rank=L.rank, basis=L.basis(), scale=scale, method="incremental Hermite form, two insertion orders agree"),
               unit_classes_mod=cls, claim_scope="Λ = the ℤ-span of the edge vectors in the stage's frame scaled by `scale`; every edge vector re-expressed with integral coordinates (control 1); two insertion orders give the same reduced basis (control 2)")
    write(out_path(a, "lattice", ch), rec)


def cmd_homs(a):
    ch = load_chunk(a); L, vecs, scale = build_lattice(ch); k = a.k
    print(f"[homs] {ch.label()} k={k}: rank {L.rank}")
    groups = all_homs(ch, L, vecs, scale, k, max_models=a.max)
    total = sum(g["count"] for g in groups); parts = sum(g["partitions"] for g in groups)
    head = "; ".join(f"{g['count']} {g['group']}-homs = {g['partitions']} colourings up to palette ({g['method']}, exact={g['exact']})" for g in groups)
    print(f"[homs] {ch.label()} k={k}: {head}; total {total} homs = {parts} colourings" + ("" if total else " — VACUOUS (no additive colouring; says nothing about χ)"))
    rec = dict(kind="additive-homs", stage=ch.header(), k=k, lattice=dict(rank=L.rank, basis=L.basis(), scale=scale), groups=groups,
               total_homs=total, total_partitions=parts, vacuous=(total == 0),
               claim_scope="every admissible hom listed with its colouring (colour ints 0..k−1 in the stage's vertex order, per component from its base point), re-verified proper on the stage's edge list; `partitions` counts distinct colourings up to palette; `exact` is False only for a capped SAT enumeration")
    write(out_path(a, "homs", ch, k), rec)
    return ch, L, vecs, scale, groups


def select_pairs(a, ch: Chunk, log=print):
    """The pairs to judge: --all (every non-adjacent same-component pair), --classes d2 list (exact), --pairs FILE, --dial FILE."""
    classes = {}
    if getattr(a, "dial", None):
        d = json.loads(Path(a.dial).read_text())
        obj = ch.meta.get("object")
        if d.get("object") != obj:
            raise SystemExit(f"--dial refused: the dial is for object {d.get('object')!r}, the stage is {obj!r}")
        live = ch.meta["live_index_of_object"]; idx = {v: i for i, v in enumerate(live)}
        forced = {(idx[u], idx[v]) if idx[u] < idx[v] else (idx[v], idx[u]) for u, v, cl in d["forced_pairs"]}
        for c in d["classes"]:
            d2 = Fr(c["d2"]); prs = ch.pairs_at(d2)
            assert len(prs) == c["pairs"], (f"dial class {c['d2']}: the stage has {len(prs)} exact pairs, the dial records {c['pairs']}")
            classes[str(d2)] = dict(pairs=prs, dial_forced=[p for p in prs if p in forced], v2=c.get("v2"))
        log(f"  dial {a.dial}: {len(classes)} classes, {sum(len(c['pairs']) for c in classes.values())} pairs, {len(forced)} dial-forced (all classes reproduced exactly)")
        return classes
    if getattr(a, "classes", None):
        for s in a.classes.split(","):
            d2 = Fr(s); prs = ch.pairs_at(d2)
            classes[str(d2)] = dict(pairs=prs, dial_forced=None)
            log(f"  class {s}: {len(prs)} exact pairs")
        return classes
    if getattr(a, "pairs", None):
        prs = [tuple(p) for p in json.loads(Path(a.pairs).read_text())]
        classes["listed"] = dict(pairs=prs, dial_forced=None)
        return classes
    if getattr(a, "all", False):
        prs = [(u, v) for u in range(ch.n) for v in range(u + 1, ch.n) if v not in ch.adj[u]]
        classes["all-nonadjacent"] = dict(pairs=prs, dial_forced=None)
        log(f"  all non-adjacent pairs: {len(prs)}")
        return classes
    raise SystemExit("forced/kempe need a pair selection: --all | --classes d2,… | --pairs FILE | --dial FILE")


def cmd_forced(a):
    ch, L, vecs, scale, groups = cmd_homs(a)
    k = a.k
    classes = select_pairs(a, ch)
    cols = [(gi, hi, np.array(g["colourings"][hi])) for gi, g in enumerate(groups) for hi in range(g["count"])]
    total_homs = len(cols)
    C = np.array([c for _, _, c in cols]) if cols else None   # (homs, n)
    results = {}
    sweep = None
    if getattr(a, "sweep", None):
        sweep = json.loads(Path(a.sweep).read_text())
        assert sweep.get("status") == "done", "--sweep needs a COMPLETE rigidity record (status done)"
        # both record shapes: rigidity.py's forced_equal.confirmed and five_dial's eq_confirmed
        fe_list = sweep.get("forced_equal", {}).get("confirmed") if isinstance(sweep.get("forced_equal"), dict) else sweep.get("eq_confirmed", [])
        sweep["_forced"] = {tuple(sorted(p[:2])) for p in (fe_list or [])}
    candidates = []
    exact_family = all(g["exact"] for g in groups)
    extra_cols = []   # colourings found by the per-pair SAT re-ask (capped families), appended to the record
    for name, cl in classes.items():
        rows = Counter(); sep_by = {}
        prs = cl["pairs"]
        same = [(u, v) for u, v in prs if ch.comp[u] == ch.comp[v]]
        rows["not-comparable"] += len(prs) - len(same)
        if total_homs == 0:
            rows["vacuous"] += len(same); same = []
        forced_pairs = []
        B = max(1000, int(2e7 // max(1, total_homs)))   # ≤ ~2·10⁷ comparisons per block
        for s0 in range(0, len(same), B):
            blk = same[s0:s0 + B]
            ua = np.array([u for u, _ in blk]); va = np.array([v for _, v in blk])
            diff = C[:, ua] != C[:, va]                      # (homs, block)
            anysep = diff.any(axis=0)
            first = np.argmax(diff, axis=0)
            for j, (u, v) in enumerate(blk):
                if anysep[j]:
                    i = int(first[j]); rows["separated-additively"] += 1; sep_by[f"{u},{v}"] = [cols[i][0], cols[i][1]]
                else:
                    forced_pairs.append((u, v))
        for (u, v) in forced_pairs:
            if not exact_family:
                # the family is capped: decide the pair exactly by one SAT call (∃ admissible φ with φ(d) ≠ 0?)
                d = L.coords(tuple(int((ch.points[u][i] - ch.points[v][i]) * scale) for i in range(ch.frame.dim)))
                decided = False
                for gi, g in enumerate(groups):
                    st, models = sat_homs(L, vecs, tuple(g["divisors"]), extra_nonzero=[d], max_models=1)
                    if st == "sat":
                        c = colouring_of_hom(ch, L, scale, models[0], tuple(g["divisors"]))
                        assert not verify_proper(c, ch.edges) and c[u] != c[v], "INSTRUMENT CATASTROPHE: the re-ask's hom is not a separating proper colouring"
                        extra_cols.append(dict(group=g["group"], hom=[list(x) for x in models[0]], colours=c))
                        rows["separated-additively"] += 1; sep_by[f"{u},{v}"] = ["re-ask", len(extra_cols) - 1]; decided = True
                        break
                if decided:
                    continue
            rows["forced-additively"] += 1
            if k == 5 and v not in ch.adj[u] and cl["dial_forced"] is None:
                if sweep is None:
                    candidates.append([u, v])
                elif (u, v) in sweep["_forced"]:
                    rows["forced-additively:sweep-forced"] += 1
                else:
                    rows["forced-additively:sweep-separated"] += 1
        entry = dict(pairs=len(cl["pairs"]), verdicts=dict(rows), separated_by_hom=sep_by)
        if cl["dial_forced"] is not None:
            df = set(cl["dial_forced"])
            add_forced = set(forced_pairs) if exact_family else {p for p in forced_pairs if f"{p[0]},{p[1]}" not in sep_by}
            entry["dial"] = dict(forced=len(df), free=len(cl["pairs"]) - len(df),
                                 add_forced_and_dial_forced=len(add_forced & df), add_forced_and_dial_free=len(add_forced - df),
                                 add_free_and_dial_forced=len(df - add_forced), add_free_and_dial_free=len(cl["pairs"]) - len(add_forced | df))
            assert not (df - add_forced), (f"F_add ⊇ F_true VIOLATED on class {name}: {len(df - add_forced)} dial-forced pairs are additively separated — one of the lattice, the homs or the dial is wrong")
            entry["v2"] = cl["v2"]
        results[name] = entry
        line = ", ".join(f"{k_} {v_}" for k_, v_ in rows.items())
        dl = (f"; dial: {entry['dial']['forced']} forced of {len(cl['pairs'])} — additively forced ∧ dial-free {entry['dial']['add_forced_and_dial_free']} (non-additive separations)" if cl["dial_forced"] is not None else "")
        print(f"[forced] {ch.label()} k={k}, class {name} ({len(cl['pairs'])} pairs): {line}{dl}")
    if candidates:
        print(f"[forced] CANDIDATE — {len(candidates)} forced-additively non-adjacent pairs at k=5 and NO complete sweep given for this stage; ask through five_dial.py ask (the jackpot protocol lives there)")
    rec = dict(kind="additive-forced", stage=ch.header(), k=k, lattice=dict(rank=L.rank, basis=L.basis(), scale=scale),
               groups=[dict(group=g["group"], count=g["count"], partitions=g["partitions"], method=g["method"], exact=g["exact"]) for g in groups],
               colourings=[dict(group=groups[gi]["group"], hom=groups[gi]["homs"][hi], colours=groups[gi]["colourings"][hi]) for gi, hi, _ in cols],
               reask_colourings=extra_cols, family_exact=exact_family,
               classes=results, candidates_for_ask=candidates, dial=getattr(a, "dial", None), sweep=getattr(a, "sweep", None),
               claim_scope="per pair: forced-additively (every listed hom identifies it — THEORY-LEVEL), separated-additively (the cited colouring, listed here and verified proper, separates it — a certificate), not-comparable (different components), vacuous (no hom). " + FORCED_LICENCE)
    write(out_path(a, "forced", ch, k), rec)


def sublattice_of(L: Lattice, vecs, coords_list, sel):
    """The ℤ-span of the selected edge vectors, as a Lattice in the coordinates of L's basis (rank-r integer vectors)."""
    S = Lattice(L.rank)
    for d, c in zip(vecs, coords_list):
        if sel(d, c):
            S.insert([int(x) for x in c])
    S.reduce()
    return S


def cmd_kempe(a):
    ch, L, vecs, scale, groups = cmd_homs(a)
    k = a.k
    classes = select_pairs(a, ch)
    coords_list = [L.coords(d) for d in vecs]
    # per hom: colour vector; per unordered colour pair {x,y}: components of the {x,y}-subgraph; per c: Λ_c
    plans = []
    for gi, g in enumerate(groups):
        divisors = g["divisors"]
        for hi in range(g["count"]):
            hom = g["homs"][hi]; col = g["colourings"][hi]
            # value of φ on each edge vector, as an int
            phi_e = [tuple_to_int(hom_apply(hom, divisors, c), divisors) for c in coords_list]
            # group elements as tuples; c ↦ −c
            def neg(t): return tuple((-x) % m for x, m in zip(t, divisors))
            def as_tuple(i):
                out = []
                for m in reversed(divisors):
                    out.append(i % m); i //= m
                return tuple(reversed(out))
            comps = {}
            subl = {}
            for x in range(k):
                for y in range(x + 1, k):
                    cval = tuple((p - q) % m for p, q, m in zip(as_tuple(x), as_tuple(y), divisors))
                    key = min(cval, neg(cval))
                    if key not in subl:
                        subl[key] = sublattice_of(L, vecs, coords_list, lambda d, c, cv=cval: as_tuple(tuple_to_int(hom_apply(hom, divisors, c), divisors)) in (cv, neg(cv)))
                    # components of the {x,y}-subgraph
                    cid = [-1] * ch.n; ncomp = 0
                    for s in range(ch.n):
                        if col[s] not in (x, y) or cid[s] != -1:
                            continue
                        cid[s] = ncomp; stack = [s]
                        while stack:
                            p = stack.pop()
                            for q in ch.adj[p]:
                                if col[q] in (x, y) and cid[q] == -1:
                                    cid[q] = ncomp; stack.append(q)
                        ncomp += 1
                    comps[(x, y)] = (cid, ncomp, key)
            plans.append((gi, hi, col, comps, subl))
    results = {}; verified_swaps = 0
    for name, cl in classes.items():
        rows = Counter(); mech = Counter(); witness = {}
        for (u, v) in cl["pairs"]:
            if ch.comp[u] != ch.comp[v]:
                rows["not-comparable"] += 1; continue
            if not plans:
                rows["vacuous"] += 1; continue
            verdict = None
            for gi, hi, col, comps, subl in plans:
                if col[u] != col[v]:
                    verdict = ("separated-additively", None, gi, hi); break
                x = col[u]
                for y in range(k):
                    if y == x:
                        continue
                    key_xy = (min(x, y), max(x, y)); cid, ncomp, ckey = comps[key_xy]
                    if cid[u] != cid[v]:
                        # BUILD the swapped colouring and VERIFY it (the theorem, instance-certified)
                        new = list(col)
                        for w in range(ch.n):
                            if cid[w] == cid[u]:
                                new[w] = y if col[w] == x else x
                        bad = verify_proper(new, ch.edges)
                        assert not bad and new[u] != new[v], ("INSTRUMENT CATASTROPHE: a Kempe swap is not a proper separating colouring", gi, hi, u, v, bad[:3])
                        verified_swaps += 1
                        dcoords = L.coords(tuple(int((ch.points[u][i] - ch.points[v][i]) * scale) for i in range(ch.frame.dim)))
                        in_sub = Lattice.depth(subl[ckey].coords([int(t) for t in dcoords]), 2) is not None
                        verdict = ("kempe-separated", "component" if in_sub else "sublattice", gi, hi, y); break
                if verdict:
                    break
            if verdict is None:
                rows["kempe-forced"] += 1
            else:
                rows[verdict[0]] += 1
                if verdict[0] == "kempe-separated":
                    mech[verdict[1]] += 1; witness[f"{u},{v}"] = dict(group=verdict[2], hom=verdict[3], swap_with=verdict[4], mechanism=verdict[1])
        entry = dict(pairs=len(cl["pairs"]), verdicts=dict(rows), mechanisms=dict(mech), witnesses=witness)
        if cl["dial_forced"] is not None:
            df = set(cl["dial_forced"])
            kempe_forced = {p for p in cl["pairs"] if f"{p[0]},{p[1]}" not in witness and ch.comp[p[0]] == ch.comp[p[1]] and plans and all(plan[2][p[0]] == plan[2][p[1]] for plan in plans)}
            entry["dial"] = dict(forced=len(df), kempe_forced=len(kempe_forced), kempe_forced_and_dial_forced=len(kempe_forced & df),
                                 kempe_forced_and_dial_free=len(kempe_forced - df), dial_forced_and_kempe_separated=len(df - kempe_forced))
            assert not (df - kempe_forced), (f"F_K ⊇ F_true VIOLATED on class {name}: {len(df - kempe_forced)} dial-forced pairs are Kempe-separated — the swap code or the dial is wrong")
            entry["v2"] = cl["v2"]
        results[name] = entry
        line = ", ".join(f"{k_} {v_}" for k_, v_ in rows.items())
        dl = (f"; dial: {entry['dial']['forced']} forced — kempe-forced ∧ dial-free {entry['dial']['kempe_forced_and_dial_free']}" if cl["dial_forced"] is not None else "")
        print(f"[kempe] {ch.label()} k={k}, class {name} ({len(cl['pairs'])} pairs): {line} (mechanisms {dict(mech)}){dl}")
    rec = dict(kind="additive-kempe", stage=ch.header(), k=k, lattice=dict(rank=L.rank, basis=L.basis(), scale=scale),
               groups=[dict(group=g["group"], count=g["count"], partitions=g["partitions"]) for g in groups],
               colourings=[dict(group=groups[gi]["group"], hom=groups[gi]["homs"][hi], colours=groups[gi]["colourings"][hi]) for gi, g in enumerate(groups) for hi in range(g["count"])],
               classes=results, verified_swaps=verified_swaps, dial=getattr(a, "dial", None),
               claim_scope="per same-coloured pair under every additive colouring listed: kempe-separated (a swap of two classes on the component of the first vertex, BUILT and verified proper and separating; mechanism `sublattice` when the difference misses Λ_c^φ, `component` when it lies in Λ_c^φ but the finite component excludes the second vertex), kempe-forced (no single swap of any listed colouring separates them — THEORY-LEVEL), separated-additively, not-comparable, vacuous. " + FORCED_LICENCE)
    write(out_path(a, "kempe", ch, k), rec)


def load_colourings(a, ch: Chunk, k: int):
    d = json.loads(Path(a.colourings).read_text())
    if d.get("stage_fingerprint") not in (None, ch.fingerprint()):
        raise SystemExit(f"--colourings refused: recorded for fingerprint {d.get('stage_fingerprint')}, the stage is {ch.fingerprint()}")
    cols = d["colourings"]
    bad = [i for i, c in enumerate(cols) if len(c) != ch.n]
    if bad:
        raise SystemExit(f"--colourings refused: colouring {bad[0]} has {len(cols[bad[0]])} entries, the stage has {ch.n} vertices")
    improper = [i for i, c in enumerate(cols) if verify_proper(c, ch.edges)]
    return cols, improper, d


def cmd_defect(a):
    ch, L, vecs, scale, groups = cmd_homs(a)
    k = a.k; cols, improper, d = load_colourings(a, ch, k)
    fam = [np.array(c) for g in groups for c in g["colourings"]]
    exact = all(g["exact"] for g in groups)
    perms = list(itertools.permutations(range(k)))
    hist = Counter(); per = []
    for c in cols:
        c = np.array(c); best = None
        for f in fam:
            M = np.zeros((k, k), dtype=np.int64)
            np.add.at(M, (c, f), 1)
            agree = max(sum(M[x, pi[x]] for x in range(k)) for pi in perms)
            dd = ch.n - int(agree)
            best = dd if best is None else min(best, dd)
        per.append(best); hist[best] += 1
    print(f"[defect] {ch.label()} k={k}: {len(cols)} colourings ({len(improper)} improper on this edge list) against {len(fam)} additive colourings"
          f" ({'complete' if exact else 'INCOMPLETE — defects are upper bounds'}): histogram {dict(sorted(hist.items()))}")
    rec = dict(kind="additive-defect", stage=ch.header(), k=k, family=len(fam), family_exact=exact, colourings=len(cols), improper=improper,
               defects=per, histogram=dict(sorted(hist.items())), colourings_file=a.colourings,
               claim_scope="defect = the least Hamming distance from the colouring to an additive colouring of the listed family under the best palette bijection (all k! tried); exact when the family is complete, an upper bound otherwise")
    write(out_path(a, "defect", ch, k), rec)


def cmd_additive_test(a):
    ch, L, vecs, scale, groups = cmd_homs(a)
    k = a.k; cols, improper, d = load_colourings(a, ch, k)
    parts = {}
    for gi, g in enumerate(groups):
        for hi, c in enumerate(g["colourings"]):
            parts.setdefault(canon(c), (gi, hi))
    verdicts = []; n_add = 0
    for c in cols:
        key = canon(c)
        if key in parts:
            verdicts.append(dict(verdict="additive", group=parts[key][0], hom=parts[key][1])); n_add += 1
        else:
            verdicts.append(dict(verdict="not-additive"))
    exact = all(g["exact"] for g in groups)
    print(f"[additive-test] {ch.label()} k={k}: {n_add} of {len(cols)} colourings are additive (partition equality against the {'complete' if exact else 'INCOMPLETE'} family of {len(parts)} additive partitions); {len(improper)} improper")
    rec = dict(kind="additive-test", stage=ch.header(), k=k, family_partitions=len(parts), family_exact=exact, colourings=len(cols), additive=n_add, improper=improper,
               verdicts=verdicts, colourings_file=a.colourings,
               claim_scope="a colouring is `additive` iff its partition of the vertices equals that of a listed admissible hom's colouring (M1.3: partitions, not labels); with a complete family `not-additive` is exact")
    write(out_path(a, "additive-test", ch, k), rec)


def cmd_obstruct(a):
    ch = load_chunk(a); L, vecs, scale = build_lattice(ch); k = a.k
    groups, names = abelian_groups(k)
    exps = sorted({g[0] for g in groups})   # the exponent of each group is its largest divisor
    rep = {}
    for e in exps:
        hits = [i for i, d in enumerate(vecs) if all(int(x) % e == 0 for x in L.coords(d))]
        rep[e] = dict(units_in_eLambda=len(hits), example_edges=[list(ch.edges[i]) for i in hits[:5]])
    fired = {e: r["units_in_eLambda"] for e, r in rep.items() if r["units_in_eLambda"]}
    if fired:
        print(f"[obstruct] {ch.label()} k={k}: unit vectors in eΛ for exponent(s) {fired} — no additive colouring into any group of that exponent (Fischer's 1/k obstruction, chunk form); says NOTHING about χ")
    else:
        print(f"[obstruct] {ch.label()} k={k}: no unit vector lies in eΛ for any exponent in {exps} — the obstruction is absent (homs may still fail by hyperplane cover; `homs` decides)")
    rec = dict(kind="additive-obstruct", stage=ch.header(), k=k, lattice=dict(rank=L.rank, basis=L.basis(), scale=scale), exponents=rep,
               claim_scope="a unit vector u ∈ eΛ (all coordinates ≡ 0 mod e) kills every hom into a group of exponent e (L1); the chunk form of Fischer's 1/k ∈ Σ₀; absence is NOT existence")
    write(out_path(a, "obstruct", ch, k), rec)


# ====================================================================== self-test
def self_test():
    class A:
        def __init__(self, **kw):
            self.__dict__.update(kw)
    fails = []
    def check(name, cond):
        print(f"  [{'ok' if cond else 'RED'}] {name}")
        if not cond:
            fails.append(name)
    print("[self-test] planted controls")
    # grid at 2: exactly the parity hom; forced (0,0)-(2,0); kempe-forced
    ch = planted("grid"); L, vecs, scale = build_lattice(ch)
    check("grid: rank 2", L.rank == 2)
    g = enumerate_homs(L, vecs, (2,))
    check("grid k=2: exactly one admissible Z/2-hom (parity)", len(g) == 1)
    col = colouring_of_hom(ch, L, scale, g[0], (2,))
    o = ch.meta["origin"]; two = ch.points.index((Fr(2), Fr(0))); one = ch.points.index((Fr(1), Fr(0)))
    check("grid: (0,0),(2,0) identified by parity; (0,0),(1,0) separated", col[o] == col[two] and col[o] != col[one])
    d = L.coords(tuple(int((ch.points[o][i] - ch.points[two][i]) * scale) for i in range(2)))
    check("grid: the difference (2,0) has 2-adic depth 1 in Λ (∈ 2Λ) — L1 forces it", Lattice.depth(d, 2) == 1)
    # a planted non-member: half a unit vector
    check("lattice: half a unit vector is NOT in Λ (non-integral coordinates)", Lattice.depth(L.coords((Fr(1, 2), Fr(0))), 2) is None)
    check("lattice: u + v IS in Λ", Lattice.depth(L.coords((1, 1)), 2) == 0)
    # hex at 3 and 4
    ch = planted("hex"); L, vecs, scale = build_lattice(ch)
    h3 = enumerate_homs(L, vecs, (3,)); h4 = enumerate_homs(L, vecs, (4,)); h22 = enumerate_homs(L, vecs, (2, 2))
    check("hex k=3: the (√−3) colouring: 2 Z/3-homs = 1 partition", len(h3) == 2 and len({canon(colouring_of_hom(ch, L, scale, h, (3,))) for h in h3}) == 1)
    check("hex k=4: Z/4-homs exist (the derived (2, 1) among them, up to sign)", len(h4) > 0 and any(h[0] in ((2, 1), (2, 3), (1, 2), (3, 2), (1, 1), (3, 3)) for h in h4))
    check("hex k=4: the mod-2 colouring: 6 Z/2xZ/2-homs = 1 partition", len(h22) == 6 and len({canon(colouring_of_hom(ch, L, scale, h, (2, 2))) for h in h22}) == 1)
    # kempe on hex with the Z/2xZ/2 hom: (0,0)-(4,0) separated by a swap (sublattice mechanism); grid (0,0)-(2,0) kempe-forced
    o = ch.points.index((Fr(-2), Fr(0))); four = ch.points.index((Fr(2), Fr(0)))
    hom = h22[0]; col = colouring_of_hom(ch, L, scale, hom, (2, 2))
    sep = False
    if col[o] == col[four]:
        x = col[o]
        for y in range(4):
            if y == x:
                continue
            cid = [-1] * ch.n; nc = 0
            for s in range(ch.n):
                if col[s] not in (x, y) or cid[s] != -1:
                    continue
                cid[s] = nc; st = [s]
                while st:
                    p = st.pop()
                    for q in ch.adj[p]:
                        if col[q] in (x, y) and cid[q] == -1:
                            cid[q] = nc; st.append(q)
                nc += 1
            if cid[o] != cid[four]:
                new = [((y if col[w] == x else x) if cid[w] == cid[o] else col[w]) for w in range(ch.n)]
                sep = not verify_proper(new, ch.edges) and new[o] != new[four]
                break
    check("hex kempe: (−2,0),(2,0) (difference 4·1 ∈ 4Λ) — identified by the mod-2 hom, separated by a verified Kempe swap", col[o] == col[four] and sep)
    # moser: no Z/3, Z/4 and Z/2xZ/2 exist; k4e: no Z/2, Z/3 exists
    ch = planted("moser"); L, vecs, scale = build_lattice(ch)
    check("moser: rank 4", L.rank == 4)
    check("moser k=3: no admissible Z/3-hom (no additive 3-colouring — no χ claim follows)", len(enumerate_homs(L, vecs, (3,))) == 0)
    check("moser k=4: Z/4-homs exist and Z/2xZ/2-homs exist", len(enumerate_homs(L, vecs, (4,))) > 0 and len(enumerate_homs(L, vecs, (2, 2))) > 0)
    ch = planted("k4e"); L, vecs, scale = build_lattice(ch)
    check("K4−e k=2: none; k=3: some", len(enumerate_homs(L, vecs, (2,))) == 0 and len(enumerate_homs(L, vecs, (3,))) > 0)
    # l7-moser: 1/3 ∈ Λ so the unit vector 1 ∈ 3Λ — obstruct fires at 3; not at 2
    ch = planted("l7-moser"); L, vecs, scale = build_lattice(ch)
    hits3 = [i for i, d in enumerate(vecs) if all(int(x) % 3 == 0 for x in L.coords(d))]
    hits2 = [i for i, d in enumerate(vecs) if all(int(x) % 2 == 0 for x in L.coords(d))]
    check("l7-moser: 1/3 ∈ Λ (2ρ + 2ρ̄ − 3): the unit vector 1 lies in 3Λ — obstruct fires at 3", len(hits3) > 0)
    check("l7-moser: no unit vector in 2Λ — obstruct silent at 2", len(hits2) == 0)
    for nm, e_expect in (("l7-rho15", 4), ("l7-heule", 4), ("l7-rho247", 4)):
        ch = planted(nm); L, vecs, scale = build_lattice(ch)
        hits = [i for i, d in enumerate(vecs) if all(int(x) % e_expect == 0 for x in L.coords(d))]
        hits5 = [i for i, d in enumerate(vecs) if all(int(x) % 5 == 0 for x in L.coords(d))]
        check(f"{nm}: the unit vector 1 lies in {e_expect}Λ (1/{e_expect} ∈ Λ, L7) — obstruct fires at {e_expect}; silent at 5", len(hits) > 0 and len(hits5) == 0)
    # disconnected: a cross pair is not comparable
    ch = planted("disconnected")
    check("disconnected: two components; a cross pair is not-comparable", len(ch.bases) == 2 and ch.comp[0] != ch.comp[4])
    # SAT path agrees with enumeration on the seed (rank 4) at k = 5 and k = 4
    ch = load_seed(); L, vecs, scale = build_lattice(ch)
    e5 = enumerate_homs(L, vecs, (5,)); st5, s5 = sat_homs(L, vecs, (5,), max_models=10000)
    check(f"seed k=5: SAT enumeration ({len(s5)}, {st5}) agrees with brute force ({len(e5)})", st5 == "sat-complete" and set(s5) == set(e5))
    e22 = enumerate_homs(L, vecs, (2, 2)); st22, s22 = sat_homs(L, vecs, (2, 2), max_models=10000)
    check(f"seed k=4 Z/2xZ/2: SAT ({len(s22)}) agrees with brute force ({len(e22)})", st22 == "sat-complete" and set(s22) == set(e22))
    e4 = enumerate_homs(L, vecs, (4,)); st4, s4 = sat_homs(L, vecs, (4,), max_models=10000)
    check(f"seed k=4 Z/4: SAT ({len(s4)}) agrees with brute force ({len(e4)})", st4 == "sat-complete" and set(s4) == set(e4))
    # the forced pair at 5: every Z/5-hom identifies it; the per-pair SAT (φ(d) ≠ 0) is UNSAT
    A, B = ch.meta["forced_pair"]
    dAB = tuple(int((ch.points[A][i] - ch.points[B][i]) * scale) for i in range(4))
    stAB, _ = sat_homs(L, vecs, (5,), extra_nonzero=[L.coords(dAB)], max_models=1)
    cols5 = [colouring_of_hom(ch, L, scale, h, (5,)) for h in e5]
    check("seed k=5: (205,206) identified by all 72 homs (enumeration) and the per-pair SAT with φ(d) ≠ 0 is UNSAT", all(c[A] == c[B] for c in cols5) and stAB == "unsat")
    # defect: a hom's own colouring reads 0, one repaint reads 1
    c0 = cols5[0]; c1 = list(c0); c1[7] = (c1[7] + 1) % 5
    fam = [np.array(c) for c in cols5]; perms = list(itertools.permutations(range(5)))
    def defect(c):
        c = np.array(c); best = None
        for f in fam:
            M = np.zeros((5, 5), dtype=np.int64); np.add.at(M, (c, f), 1)
            dd = ch.n - max(sum(M[x, pi[x]] for x in range(5)) for pi in perms)
            best = dd if best is None else min(best, dd)
        return best
    check("defect: an additive colouring reads 0, a one-vertex repaint reads 1", defect(c0) == 0 and defect(c1) == 1)
    check("additive-test: the hom's colouring is additive, the repaint is not", canon(c0) in {canon(c) for c in cols5} and canon(c1) not in {canon(c) for c in cols5})
    # U: the two residue colourings (independent 2-adic computation) are among the Z/2xZ/2 partitions
    try:
        chU = load_object("S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1"); LU, vU, sU = build_lattice(chU)
        h22U = enumerate_homs(LU, vU, (2, 2)); parts = {canon(colouring_of_hom(chU, LU, sU, h, (2, 2))) for h in h22U}
        import residue_colouring as RC
        live = chU.meta["live_index_of_object"]
        ex = json.loads((ROOT / "data" / "m52" / "exact-S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1.json").read_text())["points"]
        pts = {i: ([Fr(n_, d_) for n_, d_ in ex[str(v)]["x"][0]], [Fr(n_, d_) for n_, d_ in ex[str(v)]["y"][0]]) for i, v in enumerate(live)}
        ok = True
        for start in (17, -17):
            S = RC.sqrt33_2adic(start % 256)
            col, ncomp = RC.colour(pts, chU.edges, S)
            vec = [col[i] for i in range(chU.n)]
            names = {}; vec = [names.setdefault(c, len(names)) for c in vec]
            ok &= canon(vec) in parts and not verify_proper(vec, chU.edges)
        check(f"U k=4: both residue colourings (residue_colouring.py, 2-adic) are among the {len(parts)} Z/2xZ/2 partitions", ok and len(parts) == 2)
    except FileNotFoundError as e:
        print(f"  [skip] U cross-check: {e}")
    print(f"[self-test] {'ALL GREEN' if not fails else 'RED: ' + ', '.join(fails)}")
    return not fails


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    def stage_args(p):
        p.add_argument("--seed", action="store_true"); p.add_argument("--object"); p.add_argument("--witness"); p.add_argument("--heule510", action="store_true")
        p.add_argument("--degrey", action="store_true"); p.add_argument("--field16"); p.add_argument("--graph"); p.add_argument("--planted"); p.add_argument("--out")
    p = sub.add_parser("lattice"); stage_args(p); p.set_defaults(f=cmd_lattice)
    for name, f in (("homs", cmd_homs), ("forced", cmd_forced), ("kempe", cmd_kempe)):
        p = sub.add_parser(name); stage_args(p); p.add_argument("--k", type=int, required=True); p.add_argument("--max", type=int, default=200000)
        if name != "homs":
            p.add_argument("--all", action="store_true"); p.add_argument("--classes"); p.add_argument("--pairs"); p.add_argument("--dial"); p.add_argument("--sweep")
        p.set_defaults(f=f)
    for name, f in (("defect", cmd_defect), ("additive-test", cmd_additive_test)):
        p = sub.add_parser(name); stage_args(p); p.add_argument("--k", type=int, required=True); p.add_argument("--max", type=int, default=200000)
        p.add_argument("--colourings", required=True); p.set_defaults(f=f)
    p = sub.add_parser("obstruct"); stage_args(p); p.add_argument("--k", type=int, required=True); p.set_defaults(f=cmd_obstruct)
    p = sub.add_parser("self-test"); p.set_defaults(f=lambda a: sys.exit(0 if self_test() else 1))
    a = ap.parse_args()
    a.f(a)


if __name__ == "__main__":
    main()
