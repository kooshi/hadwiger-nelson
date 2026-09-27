#!/usr/bin/env python3
"""FS110-YB3 — exact ring checker for Y3-GP (claims §7.1's rings), built blind to FS110-Y3's tool.

A *ring* is a colouring of the unit circle about a vertex u by the three colours t^c = {0, 1, 2} (ℤ/3), given
by its change points x_0 < … < x_{n-1} in degrees (exact Fractions in [0, 360)) and the colour of each arc
[x_i, x_{i+1}).  It is *valid* (N-E0) iff c(θ) ≠ c(θ + 60°) at every θ where both sides are arc interiors.
W is the lift's net change over one turn divided by 3: +1 for a step c → c+1, −1 for c → c−1 (claims §7.1).
General position (GP): no two change points at angular distance ≡ 0 (mod 60°).

Y3-GP (checked here): a valid GP ring has W ≡ 3 (mod 6).  The mechanism is checked independently: the function
g(θ) = c̃(θ+60) − c̃(θ) takes at most two consecutive values ≢ 0 (mod 3), Σ_k g(θ+60k) = 3W, and the number m of
k with c(θ+60(k+1)) − c(θ+60k) ≡ −1 is constant (= 3 in GP).

Run: python3 tools/fs110_yb3_ring.py            (faithful: every check must pass; exit 0)
     python3 tools/fs110_yb3_ring.py --plant A  (validity sampled only at arc midpoints: the known-REJECT control must fire)
     python3 tools/fs110_yb3_ring.py --plant B  (wrong lift, a step of +2 counted +2: the W registry and Y3-GP must fire)
Exit status 0 iff every expectation of the chosen mode held (for a plant: iff the plant was caught).
"""
from fractions import Fraction as F
import sys

PLANT = None
if "--plant" in sys.argv:
    PLANT = sys.argv[sys.argv.index("--plant") + 1]


def norm(t):
    t = F(t) % 360
    return t


class Ring:
    def __init__(self, name, pts, cols, kind):
        assert len(pts) == len(cols) >= 1
        order = sorted(range(len(pts)), key=lambda i: norm(pts[i]))
        self.x = [norm(pts[i]) for i in order]
        self.c = [cols[i] % 3 for i in order]
        self.name, self.kind = name, kind
        assert len(set(self.x)) == len(self.x), "repeated change point"
        # maximal arcs: consecutive arcs must differ in colour (a 'change point' changes the colour)
        n = len(self.x)
        assert all(self.c[i] != self.c[(i + 1) % n] for i in range(n)), f"{name}: not a list of change points"

    def colour(self, t):
        """colour at θ (θ not a change point)."""
        t = norm(t)
        assert t not in self.x
        n = len(self.x)
        for i in range(n):
            a, b = self.x[i], self.x[(i + 1) % n]
            if a < b:
                if a < t < b:
                    return self.c[i]
            else:  # wraps through 0
                if t > a or t < b:
                    return self.c[i]
        raise AssertionError("no arc")

    def breakpoints(self):
        return sorted(set(self.x) | {norm(x - 60) for x in self.x})

    def valid(self):
        """exact: c(θ) ≠ c(θ+60) on every cell of the partition by {x_i} ∪ {x_i − 60}."""
        if PLANT == "A":  # FAULT: sample only the ring's own arc midpoints
            n = len(self.x)
            samples = []
            for i in range(n):
                a, b = self.x[i], self.x[(i + 1) % n]
                if b <= a:
                    b += 360
                m = norm((a + b) / 2)
                if norm(m + 60) not in self.x:
                    samples.append(m)
        else:
            bp = self.breakpoints()
            samples = [norm((bp[i] + (bp[(i + 1) % len(bp)] + (360 if i + 1 == len(bp) else 0))) / 2)
                       for i in range(len(bp))]
        return all(self.colour(t) != self.colour(t + 60) for t in samples)

    def step(self, frm, to):
        d = (to - frm) % 3
        if d == 1:
            return 1
        if d == 2:
            return 2 if PLANT == "B" else -1  # FAULT B: lift a −1 step as +2
        raise AssertionError("not a change")

    def W(self):
        n = len(self.x)
        tot = sum(self.step(self.c[i - 1], self.c[i]) for i in range(n))
        assert tot % 3 == 0, f"{self.name}: lift does not close ({tot})"
        return tot // 3

    def lift_at(self, t):
        """c̃(θ) for θ ∈ ℝ (not a change point), with c̃ normalised to c at θ just after 0 … by counting steps from 0."""
        # c̃(θ) = c(0+) + Σ steps at change points in (0, θ) + 3W·floor(θ/360)
        t = F(t)
        k, r = divmod(t, 360)
        base = self.colour(F(1, 10**9)) if 0 not in self.x else self.c[0]
        n = len(self.x)
        s = 0
        for i in range(n):
            if 0 < self.x[i] < r:
                s += self.step(self.c[i - 1], self.c[i])
        return base + s + 3 * self.W() * int(k)

    def gp(self):
        n = len(self.x)
        return all((self.x[j] - self.x[i]) % 60 != 0 for i in range(n) for j in range(i + 1, n))

    def h60(self):
        """no two change points at angular distance exactly 60° (chord exactly 1) — the hypothesis of YB3-GP′."""
        n = len(self.x)
        return all((self.x[j] - self.x[i]) % 360 not in (60, 300) for i in range(n) for j in range(i + 1, n))

    def mechanism(self):
        """g takes ≤ 2 consecutive values ≢ 0 mod 3 (in GP); Σ_k g(θ+60k) = 3W; m constant."""
        # partition by X − 60k for every k, so that all six points θ + 60k avoid the change points
        bp = sorted({norm(x - 60 * k) for x in self.x for k in range(6)})
        cells = [norm((bp[i] + (bp[(i + 1) % len(bp)] + (360 if i + 1 == len(bp) else 0))) / 2) for i in range(len(bp))]
        W = self.W()
        gs, ms, sums = set(), set(), set()
        for t in cells:
            if t in self.x:
                continue
            g = self.lift_at(t + 60) - self.lift_at(t)
            gs.add(g)
            tot = sum(self.lift_at(t + 60 * (k + 1)) - self.lift_at(t + 60 * k) for k in range(6))
            sums.add(tot)
            m = sum(1 for k in range(6) if (self.colour(t + 60 * (k + 1)) - self.colour(t + 60 * k)) % 3 == 2)
            ms.add(m)
        return gs, ms, sums, W


def perturbed(n, deltas):
    return [F(360 * i, n) + F(d) for i, d in enumerate(deltas)]


RINGS = [
    # three aligned rings (two change points at angular distance ≡ 0 mod 60)
    (Ring("R1-aligned-six-two-colour", [60 * i for i in range(6)], [0, 1, 0, 1, 0, 1], "aligned"), 0),
    (Ring("R2-aligned-six-arc", [60 * i for i in range(6)], [0, 1, 2, 0, 1, 2], "aligned"), 2),
    (Ring("R3-aligned-nine-arc", [40 * i for i in range(9)], [i % 3 for i in range(9)], "aligned"), 3),
    # three rings in general position, by formula: nine (resp. 27) arcs, colours increasing, change points perturbed
    (Ring("R4-gp-nine-arc", perturbed(9, [0, F(7, 10), F(-13, 10), F(11, 10), F(3, 10), F(-9, 10), F(17, 10), F(-1, 10), F(9, 10)]),
          [i % 3 for i in range(9)], "gp"), 3),
    (Ring("R5-gp-nine-arc-reversed", perturbed(9, [0, F(7, 10), F(-13, 10), F(11, 10), F(3, 10), F(-9, 10), F(17, 10), F(-1, 10), F(9, 10)]),
          [(-i) % 3 for i in range(9)], "gp"), -3),
    # stage 4: aligned through a 180° pair but with no pair exactly 60° apart (YB3-GP′ applies, Y3-GP does not)
    (Ring("R7-180-pair-no-60-pair", [0, 40, 80, 125, 180, 215, 255, 290, 325], [i % 3 for i in range(9)], "aligned"), 3),
    (Ring("R6-gp-27-arc", perturbed(27, [F((7 * i) % 11, 23) - F(1, 5) for i in range(27)]), [i % 3 for i in range(27)], "gp"), 9),
]

# known-REJECT control: an arc of 70° (0 on [0,70)), the rest alternating; invalid only in a window that avoids every arc midpoint
BAD = Ring("X1-known-reject", [0, 70, 125, 180, 235, 300], [0, 1, 2, 0, 1, 2], "control")


def main():
    ok = True
    exp_fail = []
    print(f"mode: {'faithful' if PLANT is None else 'PLANT ' + PLANT}")
    for R, Wexp in RINGS:
        v = R.valid()
        W = R.W()
        g = R.gp()
        gs, ms, sums, _ = R.mechanism()
        line = f"{R.name:28s} arcs={len(R.x):2d} valid={v} GP={g} W={W:3d} (registered {Wexp:3d}) W mod 6={W % 6} H60={R.h60()} g-values={sorted(gs)} m={sorted(ms)}"
        print(line)
        if not v:
            exp_fail.append(f"{R.name}: invalid")
        if W != Wexp:
            exp_fail.append(f"{R.name}: W={W} ≠ registered {Wexp}")
        if sums != {3 * W}:
            exp_fail.append(f"{R.name}: Σ g ≠ 3W ({sums})")
        if (g != (R.kind == "gp")):
            exp_fail.append(f"{R.name}: GP flag {g} ≠ kind {R.kind}")
        if R.h60() and W % 6 != 3:
            exp_fail.append(f"{R.name}: no 60°-pair but W ≢ 3 (mod 6)  <-- YB3-GP′ refuted")
        if g:
            # Y3-GP and its mechanism
            if W % 6 != 3:
                exp_fail.append(f"{R.name}: GP ring with W ≢ 3 (mod 6)  <-- Y3-GP refuted")
            if len(gs) > 2 or max(gs) - min(gs) > 1 or any(x % 3 == 0 for x in gs):
                exp_fail.append(f"{R.name}: g outside two consecutive nonzero-mod-3 values")
            if ms != {3}:
                exp_fail.append(f"{R.name}: m ≠ 3 in GP")
    # both outcomes reachable: an aligned ring with W ≢ 3 (mod 6) exists among the registered ones
    if not any((not R.gp()) and R.W() % 6 != 3 for R, _ in RINGS):
        exp_fail.append("no aligned ring with W ≢ 3 (mod 6): the GP hypothesis would be idle")
    # known-REJECT control
    bv = BAD.valid()
    print(f"{BAD.name:28s} valid={bv} (must be False)")
    if bv:
        exp_fail.append(f"{BAD.name}: known-REJECT ring accepted")
    for e in exp_fail:
        print("FAIL:", e)
    if PLANT is None:
        print("RESULT:", "ALL PASS" if not exp_fail else "FAILURES")
        return 0 if not exp_fail else 1
    # plant mode: success iff the plant was caught, and caught for its own reason
    want = {"A": "known-REJECT ring accepted", "B": "registered"}[PLANT]
    caught = any(want in e for e in exp_fail)
    print("PLANT", PLANT, "CAUGHT for its own reason" if caught else "NOT CAUGHT")
    return 0 if caught else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:  # a crash is never a catch: report it loudly and fail
        print("CRASH (not a catch):", repr(e))
        sys.exit(2)
