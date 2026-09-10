#!/usr/bin/env python3
"""Parse [Parts2020a] reference-[11] vertex lists (`.vtx`) into his own integer coordinates.

His format (`data/m62/parts-ref11/JP/Pink/readme.txt`, verbatim): one vertex per line as the
Mathematica expression `{x, y}`, with

    x = (a + sqrt(33)*b) / 12 ,   y = (sqrt(3)*c + sqrt(11)*d) / 12 ,   a, b, c, d integers,

which is exactly the `(a,b,c,d)` labelling of `typem.parts_lattice` and of
`data/m62/parts509-orbit-fillings.json`. Parsing is EXACT -- sympy over the radicals, then the
four coefficients read off and asserted integral -- so a file that is not on his lattice fails
loudly here rather than silently rounding onto it.

A type-M graph (his `v509e2442.vtx`, `v510e2502.vtx`) is NOT on the lattice: it is
`L u rho15*S`, and the rotated half leaves `K = Q(sqrt3, sqrt11)`. Such a file is parsed in the
16-slot tower instead, and `parts_repro.split_type_m` recovers the two halves."""
import os, re, sys
import sympy as sp
from fractions import Fraction as Fr

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REF11 = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
S33, S3, S11, S15 = sp.sqrt(33), sp.sqrt(3), sp.sqrt(11), sp.sqrt(15)


def _sympify_line(line):
    e = line.strip().rstrip(",").strip()
    if not (e.startswith("{") and e.endswith("}")):
        raise ValueError(f"not a vertex line: {line!r}")
    e = e[1:-1]
    while "Sqrt[" in e:                       # innermost first: his files nest one level,
        e2 = re.sub(r"Sqrt\[([^\[\]]*)\]", r"sqrt(\1)", e)   # e.g. Sqrt[(5*(7 - Sqrt[33]))/2]
        if e2 == e:
            raise ValueError(f"unbalanced Sqrt[...] in {line!r}")
        e = e2
    parts = sp.sympify("[" + e + "]")
    if len(parts) != 2:
        raise ValueError(f"expected two coordinates: {line!r}")
    return (sp.expand(sp.sqrtdenest(parts[0])), sp.expand(sp.sqrtdenest(parts[1])))


_KBASIS = {sp.Integer(1): 0, S3: 1, S11: 2, S33: 3}


def _coeffs(e, basis, where):
    """Exact coefficients of `e` over `basis` (a dict radical -> slot). Loud on any other atom."""
    vec = [sp.Integer(0)] * (max(basis.values()) + 1)
    for term, co in sp.expand(e).as_coefficients_dict().items():
        t = sp.nsimplify(term)
        if t not in basis:
            raise ValueError(f"{where}: term {term} is outside the basis")
        vec[basis[t]] += sp.nsimplify(co)
    return vec


def _abcd(x, y, where=""):
    """(a,b,c,d) with x = (a + b*sqrt33)/12 and y = (c*sqrt3 + d*sqrt11)/12, or None."""
    try:
        X = _coeffs(12 * x, _KBASIS, where)
        Y = _coeffs(12 * y, _KBASIS, where)
    except ValueError:
        return None
    if X[1] or X[2] or Y[0] or Y[3]:
        return None                              # x must be rational + rational*sqrt33, y the dual
    vals = [X[0], X[3], Y[1], Y[2]]
    if not all(v.is_Integer for v in vals):
        return None
    return tuple(int(v) for v in vals)


def load_lattice(path):
    """Parse a `.vtx` file whose points all lie on his lattice. Raises if any does not."""
    out = []
    for n, line in enumerate(open(path), 1):
        if not line.strip():
            continue
        x, y = _sympify_line(line)
        t = _abcd(x, y, f"{os.path.basename(path)}:{n}")
        if t is None:
            raise ValueError(f"{os.path.basename(path)}:{n} is not on the denominator-12 lattice: "
                             f"{line.strip()}")
        out.append(t)
    return out


def load_tower(path, denom=96):
    """Parse a `.vtx` file into 16-slot tower coordinates over primes (3,5,7,11).

    Used for the assembled M-graphs, whose rho15-rotated half carries sqrt15."""
    coords = []
    for n, line in enumerate(open(path), 1):
        if not line.strip():
            continue
        x, y = _sympify_line(line)
        coords.append([_tower(v, denom, f"{os.path.basename(path)}:{n}") for v in (x, y)])
    return {"denom": denom, "primes": [3, 5, 7, 11], "coords": coords,
            "names": [str(i) for i in range(len(coords))]}


_TBASIS = {sp.Integer(1): 0, S3: 1, sp.sqrt(5): 2, S15: 3, sp.sqrt(7): 4,
           S11: 8, S33: 9, sp.sqrt(55): 10, sp.sqrt(165): 11, sp.sqrt(77): 12,
           sp.sqrt(21): 5, sp.sqrt(35): 6, sp.sqrt(105): 7, sp.sqrt(231): 13,
           sp.sqrt(385): 14, sp.sqrt(1155): 15}


def _tower(v, denom, where):
    """Express v in the 16-slot basis, scaled by `denom`, as integers. Loud on failure."""
    vec = [0] * 16
    for term, co in sp.expand(v * denom).as_coefficients_dict().items():
        t = sp.nsimplify(term)
        if t not in _TBASIS:
            raise ValueError(f"{where}: term {term} is outside the tower basis")
        c = sp.nsimplify(co)
        if not c.is_Integer:
            raise ValueError(f"{where}: coefficient of {term} is {c}, not integral at denom {denom}")
        vec[_TBASIS[t]] += int(c)
    return vec


def files():
    return sorted(f for f in os.listdir(REF11) if f.endswith(".vtx"))


def expect(name):
    """(vertices, edges) from his filename convention `v<V>e<E>.vtx`."""
    m = re.fullmatch(r"v(\d+)e(\d+)\.vtx", name)
    return (int(m.group(1)), int(m.group(2))) if m else None


if __name__ == "__main__":
    for f in sys.argv[1:] or files()[:1]:
        p = f if os.path.sep in f else os.path.join(REF11, f)
        try:
            pts = load_lattice(p)
            print(f"{os.path.basename(p)}: {len(pts)} lattice points, first {pts[:3]}")
        except ValueError as e:
            print(f"{os.path.basename(p)}: not on the lattice -- {e}")
