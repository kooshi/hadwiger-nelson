#!/usr/bin/env python3
"""Exact arithmetic in ℚ(√p₀, √p₁, √p₂, √p₃), cleared of denominators — **once**.

UNTRUSTED, like everything in `tools/`. Lean re-derives every geometric claim from the emitted data
by kernel reduction of `UDCert.Valid`, so a bug here can only cost a theorem and can never buy one.

## Why this file exists

Five generators carried their own copy of this multiplication table: `degrey.py`, `corespindle.py`,
`heule.py`, `spindle.py` and `scan.py` — two of them over `Fraction`, three over cleared integers.
A sixth was about to be written for M12's constructor. That is a role nobody had named, and the fix
is subtraction: one module, five importers, and the arithmetic that decides whether two points are a
unit apart is defined in exactly one place.

## The representation

A number is a **16-vector of integers** over the basis `{√(∏ S) : S ⊆ primes}`: bit `k` of the basis
index means "this term carries `√primes[k]`". Multiplying basis elements `i` and `j` gives basis
`i ^ j`, with the shared primes coming out as an integer factor — that is the entire multiplication
rule, and it is why the tower is cheap.

Coordinates are stored **scaled by a common denominator**, so every question this project asks —
"are these two points exactly one apart?" — is an integer identity rather than a float comparison.

## The field is derived, not chosen

Spindling about a pair at squared distance `r²` — rotating a copy until a designated pair lands a
unit apart, which is how the Moser spindle, de Grey's graph and the core-and-spindle were all
built — rotates by

    cos θ = (2r² − 1) / (2r²),      sin θ = √(4r² − 1) / (2r²)

so **the spindle stays in the field exactly when `4r² − 1` is a square there**. The four square roots
this project uses are precisely the spindle radicals of `r² = 1, 3/2, 2, 3`:

| `r²` | `4r² − 1` | gives |
|---|---|---|
| 1 | 3 | √3 — the unit rhombus |
| 3/2 | 5 | √5 |
| 2 | 7 | √7 |
| 3 | 11 | √11 — the Moser spindle's rhombus diagonal |
| 4 | 15 | √15, and de Grey's rotation by `2·arcsin(1/4)` is `cos 7/8, sin √15/8` |

`spindle_radicand` and `is_square` below are that test, and they are what a constructor consults
before proposing a move.
"""

from __future__ import annotations

from fractions import Fraction
from itertools import combinations

DIM = 16
PRIMES = [3, 5, 7, 11]


# ------------------------------------------------------------------ the tower

def mul_table(primes: list[int] = PRIMES) -> list[list[tuple[int, int]]]:
    """`tab[i][j] = (basis index, integer factor)` for the product of basis elements `i` and `j`."""
    tab = [[(0, 0)] * DIM for _ in range(DIM)]
    for i in range(DIM):
        for j in range(DIM):
            f = 1
            for k in range(len(primes)):
                if (i >> k) & 1 and (j >> k) & 1:
                    f *= primes[k]
            tab[i][j] = (i ^ j, f)
    return tab


TAB = mul_table()


def mul(x: list[int], y: list[int], tab=None) -> list[int]:
    tab = TAB if tab is None else tab
    out = [0] * DIM
    for i, xi in enumerate(x):
        if xi:
            row = tab[i]
            for j, yj in enumerate(y):
                if yj:
                    idx, f = row[j]
                    out[idx] += xi * yj * f
    return out


def add(x, y): return [a + b for a, b in zip(x, y)]
def sub(x, y): return [a - b for a, b in zip(x, y)]
def neg(x): return [-a for a in x]
def scal(c: int, x): return [c * a for a in x]
def is_zero(x): return not any(x)


def const(c: int) -> list[int]:
    v = [0] * DIM
    v[0] = c
    return v


def root(p: int, primes: list[int] = PRIMES) -> list[int]:
    """`√p` as a basis vector, for `p` one of the tower's primes."""
    v = [0] * DIM
    v[1 << primes.index(p)] = 1
    return v


# ------------------------------------------------------------------ points and distances

def psub(p, q): return (sub(p[0], q[0]), sub(p[1], q[1]))
def padd(p, q): return (add(p[0], q[0]), add(p[1], q[1]))


def distsq(p, q, tab=None) -> list[int]:
    """The exact squared distance between two **stored** points. At denominator `d`, a real unit
    distance appears here as `d²` — which is what `UDCert.ValidOn` checks in Lean."""
    dx, dy = psub(p, q)
    return add(mul(dx, dx, tab), mul(dy, dy, tab))


def is_unit(p, q, denom: int, tab=None) -> bool:
    """Exactly one apart, as an integer identity. No tolerance anywhere."""
    return distsq(p, q, tab) == const(denom * denom)


# ------------------------------------------------------------------ what the field admits

def squarefree(n: int) -> int:
    n = abs(n)
    s, d = 1, 2
    while d * d <= n:
        e = 0
        while n % d == 0:
            n //= d
            e += 1
        if e % 2:
            s *= d
        d += 1
    return s * n


def _divisors(primes: list[int]) -> set[int]:
    out = set()
    for r in range(len(primes) + 1):
        for c in combinations(primes, r):
            p = 1
            for x in c:
                p *= x
            out.add(p)
    return out


def is_square(q: Fraction, primes: list[int] = PRIMES) -> bool:
    """Is the **rational** `q` a square in ℚ(√primes)?

    A multiquadratic field's rational squares are exactly the rationals whose squarefree part is a
    product of the adjoined primes, so this is decidable in one line. Irrational arguments are a
    harder question and are not answered here — see `spindle_radicand`'s caller, which only ever
    asks about squared distances that came out rational.
    """
    if q < 0:
        return False
    if q == 0:
        return True
    return squarefree(q.numerator * q.denominator) in _divisors(primes)


def spindle_radicand(r2: Fraction) -> Fraction:
    """`4r² − 1`: what must be a square for a spindle at squared distance `r²` to stay in the field."""
    return 4 * r2 - 1


def spindle_available(r2: Fraction, primes: list[int] = PRIMES) -> bool:
    """Can a copy be rotated about a point until a pair at squared distance `r²` lands a unit apart,
    **without leaving the field**? If not, the construction is not available and a generator must
    say so rather than round."""
    return r2 > 0 and is_square(spindle_radicand(r2), primes)


def missing_root(r2: Fraction) -> int:
    """The square root a spindle at `r²` would need adjoined. Names the extension a refusal implies,
    so "unavailable" is actionable rather than a dead end."""
    v = spindle_radicand(r2)
    return squarefree(v.numerator * v.denominator)


# ------------------------------------------------------------------ emission

def render(v: list[int], primes: list[int] = PRIMES) -> str:
    """The nested-pair literal `Q4` is written as, innermost prime first.

    The tower is `Adjoin p₃ (Adjoin p₂ (Adjoin p₁ (Adjoin p₀ ℤ)))`, so the outermost pair splits on
    the *last* prime. Written out rather than as `31 + 3 * …` so that the kernel meets tower elements
    instead of casts it has to unfold.
    """
    def go(idx: list[int], level: int) -> str:
        if level < 0:
            return str(v[idx[0]])
        lo = [i for i in idx if not (i >> level) & 1]
        hi = [i for i in idx if (i >> level) & 1]
        return f"⟨{go(lo, level - 1)},{go(hi, level - 1)}⟩"
    return go(list(range(DIM)), len(primes) - 1)


# ------------------------------------------------------------------ controls

def self_test() -> None:
    """Both directions of everything, because arithmetic that is wrong in one direction only looks
    exactly like arithmetic that works."""
    def expect(got, want, what):
        if got != want:
            raise SystemExit(f"SELF-TEST FAILED — {what}: got {got}, wanted {want}")
        print(f"  ok  {what}")

    r3, r11 = root(3), root(11)
    expect(mul(r3, r3), const(3), "√3 · √3 = 3")
    expect(mul(r11, r11), const(11), "√11 · √11 = 11")
    expect(mul(r3, r11), mul(r11, r3), "the product commutes")
    expect(is_zero(sub(mul(r3, r11), mul(r3, r11))), True, "√33 − √33 = 0")
    expect(mul(r3, r11)[1 | 8], 1, "√3 · √11 lands on the √33 basis element, not on 33")

    # the unit equilateral triangle at denominator 2: (0,0), (2,0), (1,√3)
    a = (const(0), const(0))
    b = (const(2), const(0))
    c = (const(1), r3)
    expect(is_unit(a, b, 2), True, "the unit triangle's base is a unit")
    expect(is_unit(a, c, 2), True, "and its left side")
    expect(is_unit(b, c, 2), True, "and its right side")
    expect(is_unit(a, (const(3), const(0)), 2), False,
           "a point at 1.5 is NOT a unit away — the negative partner")

    F = Fraction
    expect([spindle_available(F(x)) for x in (1, 2, 3, 4)], [True] * 4,
           "the four spindle radii that generate this field are all available")
    expect(spindle_available(F(3, 2)), True, "and r² = 3/2, which is where √5 comes from")
    expect(spindle_available(F(4, 3)), False, "r² = 4/3 is NOT available — it needs √39")
    expect(missing_root(F(4, 3)), 39, "and the refusal names √39")
    expect(spindle_available(F(7, 4)), False, "r² = 7/4 is not available either (√6)")
    expect(missing_root(F(5)), 19, "r² = 5 would need √19")
    expect(spindle_available(F(0)), False, "a degenerate radius is refused, not divided by")

    # de Grey's own rotation, from the paper: 2·arcsin(1/4) is the spindle at r = 2
    expect(spindle_radicand(F(4)), 15, "de Grey's rotation is the r² = 4 spindle, radicand 15")
    expect(render(const(1)), "⟨⟨⟨⟨1,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩",
           "the literal renderer puts 1 in the constant slot")
    print("self-test: OK")


if __name__ == "__main__":
    self_test()
