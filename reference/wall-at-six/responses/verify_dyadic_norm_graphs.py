"""Reproducible verification for norm-one Cayley graph deductions."""
import json
from collections import Counter
import numpy as np


def mul(a, b, poly):
    n = poly.bit_length()-1
    out = 0
    while b:
        if b & 1:
            out ^= a
        b >>= 1
        a <<= 1
        if a >> n:
            a ^= poly
    return out


def power(a, e, poly):
    out = 1
    while e:
        if e & 1:
            out = mul(out, a, poly)
        a = mul(a, a, poly)
        e >>= 1
    return out


def remainder(a, b):
    while a and a.bit_length() >= b.bit_length():
        a ^= b << (a.bit_length()-b.bit_length())
    return a


def gcd(a, b):
    while b:
        a, b = b, remainder(a, b)
    return a


def irreducible(poly):
    n = poly.bit_length()-1
    x = 2
    for j in range(1, n+1):
        x = mul(x, x, poly)
        if j <= n//2 and gcd(x ^ 2, poly) != 1:
            return False
    return x == 2


def walsh(a):
    a = np.array(a, dtype=np.int64, copy=True)
    h = 1
    while h < len(a):
        blocks = a.reshape(-1, 2*h)
        left, right = blocks[:, :h].copy(), blocks[:, h:].copy()
        blocks[:, :h] = left+right
        blocks[:, h:] = left-right
        h *= 2
    return a


def colour(vertex, masks):
    return sum(((vertex & a).bit_count() & 1) << j
               for j, a in enumerate(masks))


results = []
for m in range(1, 7):
    q = 1 << m
    n = q*q
    poly = next(p for p in range(n+1, 2*n, 2) if irreducible(p))
    unit = [u for u in range(1, n) if power(u, q+1, poly) == 1]
    assert len(unit) == q+1
    indicator = np.zeros(n, dtype=np.int64)
    indicator[unit] = 1
    ev = walsh(indicator)
    assert ev[0] == q+1
    pair_sums = {u ^ v for i, u in enumerate(unit) for v in unit[i+1:]}
    assert len(pair_sums) == q*(q+1)//2
    common = walsh(ev*ev)//n
    for d in range(1, n):
        norm = power(d, q+1, poly)
        x = power(norm, q-2, poly)
        trace = 0
        for _ in range(m):
            trace ^= x
            x = mul(x, x, poly)
        assert trace in (0, 1)
        assert common[d] == 2*trace
    best, pair = q+1, None
    bvec = np.arange(1, n)
    for a in range(1, n):
        nums = q+1+ev[a]+ev[bvec]+ev[bvec ^ a]
        nums[a-1] = 4*(q+1)
        j = int(nums.argmin())
        val = int(nums[j])//4
        if val < best:
            best, pair = val, [a, int(bvec[j])]
    assert best == sum(all((s & a).bit_count()%2 == 0 for a in pair) for s in unit)
    masks = pair if best == 0 else None
    if m == 6:
        rng = np.random.default_rng(20260916)
        for trial in range(200000):
            a,b,c = map(int, rng.integers(1, n, size=3))
            span = {0,a,b,c,a^b,a^c,b^c,a^b^c}
            if len(span) != 8:
                continue
            if sum(int(ev[t]) for t in span) == 0:
                masks = [a,b,c]
                break
        assert masks is not None
    assert masks is not None
    # Independently check the colouring directly on every edge.
    labels = [colour(v, masks) for v in range(n)]
    assert all(labels[v] != labels[v^s] for v in range(n) for s in unit)
    row = {
        'Q':q, 'field_polynomial_bits':hex(poly),
        'spectrum':sorted(Counter(map(int, ev)).items()),
        'minimum_unit_points_in_binary_codim2_subspace':best,
        'minimizing_masks':pair,
        'proper_linear_colour_masks':masks,
        'colour_class_sizes':sorted(Counter(labels).values()),
        'common_neighbour_trace_identity_verified':True,
        'sidon_verified':True,
    }
    if m == 5:
        minimal = set(map(int, np.flatnonzero(ev == -11)))
        assert len(minimal) == 33
        assert len({a^b for a in minimal for b in minimal if a < b}) == 528
        planes = {frozenset([a,b,a^b]) for a in minimal for b in minimal
                  if a != b and a^b in minimal}
        assert len(planes) == 11
        classes = set()
        for plane in planes:
            a,b = sorted(plane)[:2]
            for label in range(4):
                block = tuple(v for v in range(n) if colour(v,[a,b]) == label)
                assert len(block) == 256
                classes.add(block)
        assert len(classes) == 44
        def trace4(x):
            ans = 0
            for _ in range(5):
                ans ^= x
                x = power(x,4,poly)
            return ans
        assert all(trace4(u) != 0 for u in unit)
        def trace2(x):
            ans = 0
            for _ in range(10):
                ans ^= x
                x = mul(x,x,poly)
            return ans
        masks_from_units = {sum(trace2(mul(u,1 << j,poly)) << j for j in range(10)) for u in unit}
        assert masks_from_units == minimal
        row['Q32_trace4_colouring_verified'] = True
        row['Q32_minimal_character_support_is_unit_circle'] = True
        row['Q32_algebraic_maximum_independent_sets_constructed'] = len(classes)
        row['Q32_algebraic_colour_partitions_constructed'] = len(planes)
    results.append(row)
    print(json.dumps(row), flush=True)
