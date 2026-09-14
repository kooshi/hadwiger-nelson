#!/usr/bin/env python3
"""Exact, standard-library verification of the explicit constructions.

Run with Python 3. No symbolic algebra package or SAT solver is required.
Writes the 18-vertex example to example_qsqrt2_qsqrt3.json beside this script.
The eight-copy identity does not verify the external four-colour forcer.
"""

from fractions import Fraction as Q
from itertools import combinations
from pathlib import Path
import json


class Field:
    def __init__(self, radicands):
        self.radicands = tuple(radicands)
        self.size = 1 << len(radicands)

    def element(self, constant=0):
        return Element(self, (Q(constant),) + (Q(0),) * (self.size - 1))

    def generator(self, j):
        coeff = [Q(0)] * self.size
        coeff[1 << j] = Q(1)
        return Element(self, tuple(coeff))


class Element:
    def __init__(self, field, coefficients):
        self.field = field
        self.coefficients = tuple(coefficients)

    def coerce(self, other):
        if isinstance(other, Element):
            assert self.field is other.field
            return other
        return self.field.element(other)

    def __add__(self, other):
        other = self.coerce(other)
        return Element(self.field, tuple(a + b for a, b in zip(self.coefficients, other.coefficients)))

    __radd__ = __add__

    def __neg__(self):
        return Element(self.field, tuple(-a for a in self.coefficients))

    def __sub__(self, other):
        return self + (-self.coerce(other))

    def __rsub__(self, other):
        return self.coerce(other) - self

    def __mul__(self, other):
        other = self.coerce(other)
        result = [Q(0)] * self.field.size
        for a, ca in enumerate(self.coefficients):
            if not ca:
                continue
            for b, cb in enumerate(other.coefficients):
                if not cb:
                    continue
                factor = 1
                common = a & b
                for j, d in enumerate(self.field.radicands):
                    if common & (1 << j):
                        factor *= d
                result[a ^ b] += ca * cb * factor
        return Element(self.field, tuple(result))

    __rmul__ = __mul__

    def __truediv__(self, rational):
        return self * (Q(1) / Q(rational))

    def __pow__(self, power):
        assert isinstance(power, int) and power >= 0
        result = self.field.element(1)
        for _ in range(power):
            result *= self
        return result

    def conjugate(self):
        imag_bit = 1 << (len(self.field.radicands) - 1)
        assert self.field.radicands[-1] == -1
        return Element(self.field, tuple(-c if j & imag_bit else c for j, c in enumerate(self.coefficients)))

    def norm(self):
        return self * self.conjugate()

    def __eq__(self, other):
        other = self.coerce(other)
        return self.coefficients == other.coefficients

    def __hash__(self):
        return hash((id(self.field), self.coefficients))


def colour_graph(vertex_count, edges, k):
    """Small exact backtracking search; sufficient for this explicit graph."""
    neighbours = [set() for _ in range(vertex_count)]
    for a, b in edges:
        neighbours[a].add(b)
        neighbours[b].add(a)
    colours = [-1] * vertex_count
    colours[0] = 0

    def visit():
        available = [v for v in range(vertex_count) if colours[v] < 0]
        if not available:
            return colours.copy()
        v = max(available, key=lambda t: (len({colours[w] for w in neighbours[t] if colours[w] >= 0}), len(neighbours[t])))
        forbidden = {colours[w] for w in neighbours[v]}
        for colour in range(k):
            if colour in forbidden:
                continue
            colours[v] = colour
            result = visit()
            if result is not None:
                return result
        colours[v] = -1
        return None

    return visit()


def example_four_chromatic():
    field = Field([2, 3, -1])
    sqrt2, sqrt3, i = (field.generator(j) for j in range(3))
    zero, one = field.element(0), field.element(1)
    omega = (1 + i * sqrt3) / 2
    delta = 1 + omega
    u = (-1 + 2 * i * sqrt2) / 3
    directions = [one, omega.conjugate(), u, u * omega.conjugate(), u.conjugate(), u.conjugate() * omega.conjugate()]
    assert all(v.norm() == 1 for v in directions)
    assert delta * sum(directions, zero) == 1

    points = []
    index = {}

    def vertex(z):
        if z not in index:
            index[z] = len(points)
            points.append(z)
        return index[z]

    endpoint = zero
    diamonds = []
    for direction in directions:
        z0 = endpoint
        z1 = endpoint + direction
        z2 = endpoint + omega * direction
        z3 = endpoint + delta * direction
        ids = tuple(vertex(z) for z in [z0, z1, z2, z3])
        assert len(set(ids)) == 4
        for a, b in [(z0, z1), (z0, z2), (z1, z2), (z1, z3), (z2, z3)]:
            assert (a - b).norm() == 1
        assert (z0 - z3).norm() == 3
        diamonds.append(ids)
        endpoint = z3
    assert endpoint == one
    edges = [(a, b) for a, b in combinations(range(len(points)), 2) if (points[a] - points[b]).norm() == 1]
    assert (min(index[zero], index[one]), max(index[zero], index[one])) in edges
    assert colour_graph(len(points), edges, 3) is None
    colours = colour_graph(len(points), edges, 4)
    assert colours is not None
    assert all(colours[a] != colours[b] for a, b in edges)

    # In this basis the first four coefficients are x, the last four are y.
    data = {
        "field": "Q(sqrt(2),sqrt(3))",
        "real_basis": ["1", "sqrt(2)", "sqrt(3)", "sqrt(6)"],
        "coordinates": [{"x": [str(c) for c in z.coefficients[:4]], "y": [str(c) for c in z.coefficients[4:]]} for z in points],
        "edges": edges,
        "diamonds": diamonds,
        "closing_edge": [index[zero], index[one]],
        "four_colouring": colours,
        "lower_bound_proof": "Every diamond forces its first and fourth vertices equal in any 3-colouring. The chain endpoints are adjacent.",
    }
    target = Path(__file__).with_name("example_qsqrt2_qsqrt3.json")
    target.write_text(json.dumps(data, indent=2) + "\n")
    print(f"Exact example: {len(points)} vertices, {len(edges)} induced edges, chromatic number 4.")
    print(f"Wrote {target.name}")


def verify_eight_copy_identity():
    field = Field([7, -1])
    sqrt7, i = field.generator(0), field.generator(1)
    zero = field.element(0)
    u = (-3 + i * sqrt7) / 4
    directions = [u**3, u.conjugate()**3] + [-u**2] * 3 + [-u.conjugate()**2] * 3
    assert len(directions) == 8
    assert all(v.norm() == 1 for v in directions)
    assert sum(directions, zero) == Q(3, 8)
    assert Q(8, 3) * sum(directions, zero) == 1
    assert u**2 + u.conjugate()**2 == Q(1, 4)
    assert u**3 + u.conjugate()**3 == Q(9, 8)
    print("Eight-copy identity: all eight multipliers have norm one; their sum is exactly 3/8.")
    print("This checks the multipliers, not the external four-colour forcer.")


if __name__ == "__main__":
    example_four_chromatic()
    verify_eight_copy_identity()
