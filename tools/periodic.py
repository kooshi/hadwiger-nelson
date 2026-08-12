#!/usr/bin/env python3
"""The periodic prober (M35 phase 2; SHARPENED at M36): brick colourings of the plane, by SAT.

UNTRUSTED, like everything in `tools/`. A found colouring becomes mathematics only when its
table replays through `Brick.check` in Lean; a refusal here is SHAPE-BOUNDED — "no brick
colouring at this cell size and period", never "no periodic colouring".

## What M36 changed, and why every M35 phase-2 negative was re-asked

The cells are HALF-OPEN, so the realizable difference vectors at an offset form an OPEN box:
a realized squared distance is strictly below the interval's upper end, and strictly above
its lower end whenever that end is positive. An offset therefore CONFLICTS with a guard only
when the guard lies STRICTLY inside its interval — M35 tested `lo <= q <= hi`, one comparison
stronger than soundness needs. That was sound and it was not free: the classical brick
seven-colouring has cell diagonal exactly 1 (`Instances/Seven.lean`), so it conflicts with
itself under the old rule and was refused; and the §0j rect grid additionally filtered to
`diag² < 1`, deleting it from the search space a second time. Both are corrected here. A
search run against a sufficient-but-not-necessary check measures the check.

One consequence for how refusals read: the condition is now the EXACT miss condition, so an
`unsat` row says "no k-colouring of the plane has THIS brick shape" rather than "none passes
our sufficient test at this shape". The caveat that remains is the shape grid, not the
certificate.

## The object (M35 §0a C6)

A brick colouring: axis-aligned w × h half-open cells in rows, row-shear s, a torus table
`m × n → k`. The colour of z = (x, y) is `table[⌊(x − s·⌊y/h⌋)/w⌋ mod m, ⌊y/h⌋ mod n]` — a
doubly periodic plane colouring for free (lattice ⟨(m·w, 0), (s·n, n·h)⟩). Properness and
distance-avoidance both reduce to ONE finite check: for every unwrapped cell-offset in a
computed window, if two cells of equal colour sit at that offset, every guarded squared
distance q must avoid the offset's closed box interval [lo, hi]. The SAT probe and the Lean
certificate check the SAME finite object; guards are SQUARED distances and always include 1
(properness).

## The stakes, honest (§0a C1)

Any k = 5 row that validates — with ANY guard list — is a proper 5-colouring of the plane,
i.e. χ(ℝ²) ≤ 5, the open upper half of Hadwiger–Nelson. Any k = 4 row that validates
contradicts the kernel theorem χ(ℝ²) ≥ 5 and is therefore an instrument CATASTROPHE (the
encoding is wrong), never a discovery. Expected landings live at k ∈ {6, 7}: certified
two-distance upper bounds.

    python3 tools/periodic.py                  # status: what exists; runs nothing
    python3 tools/periodic.py --self-test
    python3 tools/periodic.py --control                     # the kernel-certified row must SAT
    python3 tools/periodic.py --probe 7 - 8 8 1/2 1/2 0     # one row: k D m n w h s
    python3 tools/periodic.py --ladder 7 -                  # the registered ladder, one (k, D)
    python3 tools/periodic.py --hunt                        # M35's square campaign, re-asked
    python3 tools/periodic.py --hunt-rect                   # M35's rect campaign, re-asked
    python3 tools/periodic.py --hunt-tight                  # M36: the boundary-tight family
"""

from __future__ import annotations

import argparse
import json
import math
import random
import sys
import time
from fractions import Fraction as F
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
BUILD = TOOLS.parent / "build"
sys.path.insert(0, str(TOOLS))

from forcer import _solve  # noqa: E402

CATASTROPHE_EXIT = 5

ART = BUILD / "m36-periodic.json"
SCHEMA = ("m36-periodic v1 (plans/M36-seven-coloring.md §0b; the BOUNDARY-TIGHT check — a "
          "guard conflicts only when STRICTLY inside an offset's interval, which is the exact "
          "miss condition for half-open cells, so an `unsat` row is a statement about that "
          "brick SHAPE and not about our test; the standing caveat is the shape grid. Rows "
          "produced under M35's strict check live in m35-periodic.json and are superseded)")


# ---------------------------------------------------------------- exact interval arithmetic

def sqrt_ub(q: F) -> int:
    """The integer upper bound on √q used by the window — mirrors Lean's
    `Nat.sqrt ⌈q⌉ + 1` exactly (coarse is fine: it only widens the window)."""
    c = math.isqrt(int(math.ceil(q)))
    return c + 1


def interval_gen(A: F, B: F, w: F, h: F) -> tuple[F, F]:
    """GENERATOR formula (§0f D3): componentwise max(0, |centre| − width)². Closed hull —
    conservative over the half-open truth."""
    ax = max(F(0), abs(A) - w)
    ay = max(F(0), abs(B) - h)
    return ax * ax + ay * ay, (abs(A) + w) ** 2 + (abs(B) + h) ** 2


def interval_val(A: F, B: F, w: F, h: F) -> tuple[F, F]:
    """VALIDATOR formula, written independently: per-axis interval distance to zero via the
    endpoint case split. Must agree with `interval_gen` everywhere (self-test)."""
    lo_hi = []
    for centre, width in ((A, w), (B, h)):
        left, right = centre - width, centre + width
        if left <= 0 <= right:
            dmin = F(0)
        else:
            dmin = min(abs(left), abs(right))
        dmax = max(abs(left), abs(right))
        lo_hi.append((dmin, dmax))
    (xmin, xmax), (ymin, ymax) = lo_hi
    return xmin * xmin + ymin * ymin, xmax * xmax + ymax * ymax


def window(guards: list[F], w: F, h: F, s: F) -> tuple[int, int]:
    """Offset bounds (|dc| ≤ b, |dr| ≤ a) — mirrors the Lean check's own computation, plus a
    +1 margin (wider is sound: far offsets generate no constraints)."""
    Q = F(sqrt_ub(max(guards)))
    a = int(math.ceil(Q / h)) + 1
    b = int(math.ceil((Q + abs(s) * a) / w)) + 1
    return b, a


# ---------------------------------------------------------------- rows and the SAT probe

def offsets_conflicting(guards: list[F], m: int, n: int, w: F, h: F, s: F):
    """Every unwrapped offset (dc, dr) in the window whose closed interval contains a guard,
    with its torus wrap. Only the half-plane dr > 0 ∨ (dr = 0 ∧ dc ≥ 0) is emitted (the
    mirror offset constrains the same unordered pairs)."""
    b, a = window(guards, w, h, s)
    out = []
    for dr in range(0, a + 1):
        for dc in range(-b, b + 1):
            if dr == 0 and dc < 0:
                continue
            A = s * dr + w * dc
            B = h * dr
            lo, hi = interval_gen(A, B, w, h)
            # STRICTLY inside: half-open cells never realize either endpoint (M36 §0a C1)
            hit = [q for q in guards if lo < q < hi]
            if hit:
                out.append({"dc": dc, "dr": dr, "wrap": (dc % m, dr % n),
                            "lo": lo, "hi": hi, "hit": hit})
    return out


def probe(k: int, guards: list[F], m: int, n: int, w: F, h: F, s: F,
          cap: float | None = 60.0) -> dict:
    """One row: SAT over the m × n torus table. Outcomes: `sat` (validated avoider — the
    model is re-checked by the INDEPENDENT interval formula before being believed), `unsat`
    (resolution-bounded refusal), `unknown` (cap), `cell-too-big` (the cell itself realizes a
    guard — no SAT needed)."""
    row = {"k": k, "D": [str(q) for q in guards if q != 1], "m": m, "n": n,
           "w": str(w), "h": str(h), "s": str(s)}
    diag = w * w + h * h
    if any(q < diag for q in guards):
        row.update(outcome="cell-too-big", seconds=0.0)
        return row
    confl = offsets_conflicting(guards, m, n, w, h, s)
    hard = [c for c in confl if c["wrap"] == (0, 0)]
    if hard:
        row.update(outcome="unsat", reason="period-too-small",
                   hard_offsets=[(c["dc"], c["dr"]) for c in hard[:4]], seconds=0.0)
        return row

    def var(i: int, j: int, c: int) -> int:
        return (i * n + j) * k + c + 1

    clauses: list[list[int]] = []
    cells = [(i, j) for i in range(m) for j in range(n)]
    for (i, j) in cells:
        clauses.append([var(i, j, c) for c in range(k)])
        for c in range(k):
            for c2 in range(c + 1, k):
                clauses.append([-var(i, j, c), -var(i, j, c2)])
    # first-occurrence palette breaking over cell order — sound: properness and avoidance
    # are colour-invariant (the M33 rule; coverage-style colour-NAMED queries never occur here)
    order = [var(i, j, 0) for (i, j) in cells]  # noqa: F841  (cell order is (i*n+j))
    for idx in range(1, min(len(cells), 200)):
        i, j = cells[idx]
        for c in range(1, k):
            clauses.append([-var(i, j, c)] +
                           [var(*cells[e], c - 1) for e in range(idx)])
    for cf in confl:
        wc, wr = cf["wrap"]
        for (i, j) in cells:
            i2, j2 = (i + wc) % m, (j + wr) % n
            if (i2, j2) == (i, j):
                continue  # unreachable given the hard-offset guard above
            for c in range(k):
                clauses.append([-var(i, j, c), -var(i2, j2, c)])
    t0 = time.time()
    status, model = _solve(clauses, m * n * k, cap)
    row.update(outcome=status, seconds=round(time.time() - t0, 2), cap=cap,
               n_conflicting_offsets=len(confl))
    if status == "sat":
        table = [[-1] * n for _ in range(m)]
        for (i, j) in cells:
            for c in range(k):
                if var(i, j, c) in model:
                    table[i][j] = c
        if any(table[i][j] < 0 for (i, j) in cells):
            raise SystemExit("PROBE MODEL INVALID: an uncoloured cell — the at-least-one "
                             "clauses are wrong")
        bad = validate(table, k, guards, m, n, w, h, s)
        if bad:
            raise SystemExit(f"PROBE MODEL INVALID: the independent validator refuses the "
                             f"model ({bad}) — generator and validator disagree; halt")
        row["table"] = table
        if k <= 4:
            catastrophe(row)
    return row


def validate(table, k: int, guards: list[F], m: int, n: int, w: F, h: F, s: F) -> str | None:
    """The INDEPENDENT validation pass (§0f D3): re-derives every conflict through
    `interval_val` (the second formula) and re-scans the table. Returns a description of the
    first violation, or None."""
    b, a = window(guards, w, h, s)
    for dr in range(0, a + 1):
        for dc in range(-b, b + 1):
            if dr == 0 and dc < 0:
                continue
            lo, hi = interval_val(s * dr + w * dc, h * dr, w, h)
            hit = [q for q in guards if lo < q < hi]
            if not hit:
                continue
            for i in range(m):
                for j in range(n):
                    i2, j2 = (i + dc) % m, (j + dr) % n
                    if (dc, dr) != (0, 0) and (i2, j2) == (i, j):
                        return f"wrap-collision at offset ({dc},{dr})"
                    if (dc, dr) != (0, 0) and table[i][j] == table[i2][j2]:
                        return (f"same colour {table[i][j]} at cells ({i},{j})/({i2},{j2}) "
                                f"offset ({dc},{dr}), guards {hit} in [{lo},{hi}]")
    return None


def catastrophe(row: dict) -> None:
    art = load_art()
    art["status"] = "CATASTROPHE"
    art["catastrophe_row"] = row
    ART.write_text(json.dumps(art, indent=1))
    print("=" * 78 + "\nBRICK CATASTROPHE: a k = 4 row read SAT with a validated model.\n"
          "This contradicts the kernel theorem χ(ℝ²) ≥ 5, so something here is wrong — and\n"
          "since M36 the FIRST suspect is the boundary-tight relaxation itself (the strict\n"
          "`lo < q < hi` rule and Brick.check's `q ≤ loAt ∨ hiAt ≤ q`), not merely this\n"
          "encoding: if the relaxation is unsound then Instances/Seven.lean's theorem is too.\n"
          "HALT. Report to Kooshi. Every m36-periodic verdict is void until resolved.\n"
          + "=" * 78)
    raise SystemExit(CATASTROPHE_EXIT)


# ---------------------------------------------------------------- the artifact

def load_art() -> dict:
    if ART.exists():
        return json.loads(ART.read_text())
    return {"schema": SCHEMA, "machine": None, "rows": [], "status": "partial"}


def row_key(row: dict) -> tuple:
    return (row["k"], tuple(row["D"]), row["m"], row["n"], row["w"], row["h"], row["s"])


def record(row: dict, machine: str) -> None:
    art = load_art()
    art["machine"] = machine
    keys = {row_key(r) for r in art["rows"]}
    if row_key(row) not in keys:
        art["rows"].append(row)
        ART.write_text(json.dumps(art, indent=1))


def done_keys() -> set:
    return {row_key(r) for r in load_art()["rows"]}


# ---------------------------------------------------------------- the registered campaign

CLASS_GUARDS = {"-": [], "sqrt3": [F(3)], "2": [F(4)], "4rt3": [F(16, 3)], "sqrt7": [F(7)]}

# cell sizes × torus periods (in cells) × shears (fractions of w) — §0c P5/P11's grid
RESOLUTIONS = [F(2, 3), F(1, 2), F(2, 5), F(1, 3)]
PERIODS = [4, 6, 8, 12]
SHEARS = [F(0), F(1, 2), F(1, 3)]


def ladder(k: int, cls: str, cap: float, machine: str) -> None:
    guards_extra = CLASS_GUARDS[cls]
    done = done_keys()
    found = None
    for w in RESOLUTIONS:
        for per in PERIODS:
            span = w * per
            if span < 2:
                continue
            for sh in SHEARS:
                guards = [F(1)] + guards_extra
                row = {"k": k, "D": [str(q) for q in guards_extra], "m": per, "n": per,
                       "w": str(w), "h": str(w), "s": str(sh * w)}
                if row_key(row) in done:
                    continue
                r = probe(k, guards, per, per, w, w, sh * w, cap)
                record(r, machine)
                print(f"  k={k} D={cls:>5} {per}x{per}@{w} s={sh}w → {r['outcome']}"
                      f" ({r['seconds']}s)", flush=True)
                if r["outcome"] == "sat":
                    found = r
                    print(f"  AVOIDER FOUND — validated table recorded; promotion via "
                          f"Brick.check is the next step", flush=True)
                    return
    if found is None:
        print(f"  ladder (k={k}, D={cls}): all rows refused at the probed resolutions "
              f"(resolution-bounded — not a period claim)", flush=True)


def hunt(cap: float, machine: str) -> None:
    """The registered campaign (§0c): the k = 4 mass red first (any SAT is catastrophe),
    then the ladders k = 7, 6, 5 per class — descending value order within each k."""
    print("mass red control: k = 4, D = ∅ (every row must refuse):", flush=True)
    ladder(4, "-", cap, machine)
    for k in (7, 6, 5):
        for cls in CLASS_GUARDS:
            print(f"ladder k={k} class={cls}:", flush=True)
            ladder(k, cls, cap, machine)
    art = load_art()
    art["status"] = "done"
    ART.write_text(json.dumps(art, indent=1))
    print(f"campaign complete → {ART.name}")


# ---------------------------------------------------------------- §0j: the rectangular ladder

RECT_W = [F(3, 5), F(3, 4), F(4, 5), F(9, 10)]
RECT_H = [F(1, 5), F(1, 4), F(1, 3), F(2, 5)]
RECT_M = [7, 12]
RECT_SHEARS = [F(0), F(1, 2), F(1, 4)]


def ladder_rect(k: int, cls: str, cap: float, machine: str) -> None:
    """§0j: long flat bricks — the classical brick-wall family the square grid missed."""
    guards_extra = CLASS_GUARDS[cls]
    done = done_keys()
    for w in RECT_W:
        for h in RECT_H:
            # M35 §0j filtered `diag² < 1` here — the exact condition the strict check
            # needed, and exactly what deletes the boundary-tight solutions. The probe's own
            # short-circuit handles cells that genuinely realize a guard.
            n = 1
            while n * h < 3:
                n += 1
            for m in RECT_M:
                for sh in RECT_SHEARS:
                    guards = [F(1)] + guards_extra
                    row = {"k": k, "D": [str(q) for q in guards_extra], "m": m, "n": n,
                           "w": str(w), "h": str(h), "s": str(sh * w)}
                    if row_key(row) in done:
                        continue
                    r = probe(k, guards, m, n, w, h, sh * w, cap)
                    record(r, machine)
                    print(f"  k={k} D={cls:>5} {m}x{n}@{w}x{h} s={sh}w → {r['outcome']}"
                          f" ({r['seconds']}s)", flush=True)
                    if r["outcome"] == "sat":
                        print("  AVOIDER FOUND — validated table recorded; Brick.check "
                              "promotion is the next step", flush=True)
                        return
    print(f"  rect ladder (k={k}, D={cls}): all rows refused at the probed shapes "
          f"(resolution-bounded)", flush=True)


def hunt_rect(cap: float, machine: str) -> None:
    print("rect mass red: k = 4, D = ∅ (every row must refuse):", flush=True)
    ladder_rect(4, "-", cap, machine)
    print("the L3 gate first: k = 7, D = ∅ on rectangles:", flush=True)
    ladder_rect(7, "-", cap, machine)
    print("the family wedge: k = 8, D = ∅:", flush=True)
    ladder_rect(8, "-", cap, machine)
    for k in (7, 6, 5):
        for cls in ("sqrt3", "2", "4rt3", "sqrt7"):
            print(f"rect ladder k={k} class={cls}:", flush=True)
            ladder_rect(k, cls, cap, machine)
    art = load_art()
    art["status"] = "done"
    ART.write_text(json.dumps(art, indent=1))
    print(f"rect campaign complete → {ART.name}")


# ------------------------------------------------- M36: the boundary-tight family

# Cell shapes with diagonal EXACTLY 1 — the region M35's `diag² < 1` filter deleted and its
# strict check could not have accepted anyway. Rational points of w² + h² = 1.
PYTH = [(F(4, 5), F(3, 5)), (F(3, 5), F(4, 5)), (F(12, 13), F(5, 13)), (F(5, 13), F(12, 13)),
        (F(20, 29), F(21, 29)), (F(21, 29), F(20, 29)), (F(8, 17), F(15, 17)),
        (F(15, 17), F(8, 17)), (F(24, 25), F(7, 25)), (F(7, 25), F(24, 25))]
TIGHT_SHEARS = [F(0), F(1, 2), F(1, 3), F(1, 4)]
TIGHT_TORUS = {4: [(4, 4), (8, 4), (4, 8), (8, 8)], 5: [(5, 5), (10, 5), (5, 10), (10, 10)],
               6: [(6, 6), (12, 6), (6, 12), (12, 12)], 7: [(7, 7), (14, 7), (7, 14)]}

# The row the Lean kernel has already settled: Instances/Seven.lean's certificate.
CERTIFIED = (7, [F(1)], 7, 7, F(4, 5), F(3, 5), F(2, 5))


def control(cap: float, machine: str) -> None:
    """The positive control the prober never had: the kernel-certified seven-colouring must
    read SAT. If it does not, the PROBER is wrong — this row is not an open question."""
    k, guards, m, n, w, h, sh = CERTIFIED
    print("positive control — the row Instances/Seven.lean already certifies in the kernel:",
          flush=True)
    r = probe(k, guards, m, n, w, h, sh, cap)
    print(f"  k={k} {m}x{n}@{w}x{h} s={sh} → {r['outcome']} ({r['seconds']}s)", flush=True)
    if r["outcome"] != "sat":
        print("=" * 78 + "\nPROBER MIRROR BROKEN: the kernel-certified brick seven-colouring\n"
              "reads " + str(r["outcome"]) + " here. The kernel has settled this row; the\n"
              "disagreement is the prober's. Every verdict below is void until the mirror is\n"
              "fixed — diff it against build/m36-design.py offset by offset.\n" + "=" * 78)
        raise SystemExit(CATASTROPHE_EXIT)
    record(r, machine)
    print("  control GREEN — the mirror agrees with the kernel on the settled row", flush=True)


def ladder_tight(k: int, cls: str, cap: float, machine: str) -> None:
    """M36: cells of diagonal exactly 1, the region the M35 grids could not reach."""
    guards_extra = CLASS_GUARDS[cls]
    done = done_keys()
    for (w, h) in PYTH:
        for (m, n) in TIGHT_TORUS[k]:
            for sh in TIGHT_SHEARS:
                guards = [F(1)] + guards_extra
                row = {"k": k, "D": [str(q) for q in guards_extra], "m": m, "n": n,
                       "w": str(w), "h": str(h), "s": str(sh * w)}
                if row_key(row) in done:
                    continue
                r = probe(k, guards, m, n, w, h, sh * w, cap)
                record(r, machine)
                print(f"  k={k} D={cls:>5} {m}x{n}@{w}x{h} s={sh}w → {r['outcome']}"
                      f" ({r['seconds']}s)", flush=True)
                if r["outcome"] == "sat":
                    print("=" * 78, flush=True)
                    print(f"  BRICK {k}-COLOURING FOUND at a boundary-tight shape, model "
                          f"validated by the independent formula.", flush=True)
                    if k <= 6:
                        print(f"  READ THIS BEFORE INTERPRETING: at k = {k} this is a claim "
                              f"that χ(ℝ²) ≤ {k} — an open problem since 1950. It is a "
                              f"CANDIDATE, not a result, until (a) build/m36-design.py "
                              f"re-derives it independently and (b) Brick.check accepts the "
                              f"table in the kernel. Halt the campaign and report.", flush=True)
                    print("=" * 78, flush=True)
                    return
    print(f"  tight ladder (k={k}, D={cls}): every boundary-tight shape refused "
          f"(shape-bounded, not a family claim)", flush=True)


def hunt_tight(cap: float, machine: str) -> None:
    """The M36 campaign: the control, the mass red, then the re-asked questions."""
    control(cap, machine)
    print("mass red — k = 4 must refuse EVERYWHERE (a SAT here indicts the relaxation "
          "itself, and with it Instances/Seven.lean):", flush=True)
    ladder_tight(4, "-", cap, machine)
    for k in (7, 6, 5):
        for cls in CLASS_GUARDS:
            print(f"tight ladder k={k} class={cls}:", flush=True)
            ladder_tight(k, cls, cap, machine)
    art = load_art()
    art["status"] = "done"
    ART.write_text(json.dumps(art, indent=1))
    print(f"tight campaign complete → {ART.name}")


# ---------------------------------------------------------------- self-test

def self_test() -> None:
    failures = []

    def expect(got, want, what):
        ok = got == want
        print(f"  {'ok  ' if ok else 'FAIL'} {what}: {got!r}" + ("" if ok else f" (want {want!r})"))
        if not ok:
            failures.append(what)

    # the two interval formulas agree everywhere probed (§0f D3)
    rng = random.Random(35)
    agree = True
    for _ in range(200):
        A = F(rng.randint(-40, 40), rng.randint(1, 8))
        B = F(rng.randint(-40, 40), rng.randint(1, 8))
        w = F(rng.randint(1, 6), rng.randint(2, 8))
        h = F(rng.randint(1, 6), rng.randint(2, 8))
        if interval_gen(A, B, w, h) != interval_val(A, B, w, h):
            agree = False
    expect(agree, True, "200 random offsets: generator and validator intervals agree")

    # the boundary case (M35 §0b, re-read at M36): offset (3,0) at w = 1/2 has lo = 1
    # exactly. M35's rule conflicted here; the open box says the endpoint is approached and
    # never attained, so it does NOT conflict — this row IS the semantic change, pinned.
    lo, hi = interval_gen(F(3, 2), F(0), F(1, 2), F(1, 2))
    expect((lo, lo < F(1) < hi, F(1) <= hi), (F(1), False, True),
           "boundary offset: lo = 1 exactly, so guard 1 is admissible (was a conflict at M35)")
    lo2, hi2 = interval_val(F(3, 2), F(0), F(1, 2), F(1, 2))
    expect((lo2, hi2), (lo, hi), "…and the validator formula agrees at the boundary")

    # the planted green: the 3×3 rainbow at cell 2/3 is a valid 9-colouring (diag² = 8/9 < 1,
    # nearest same colour at (2·2/3)² = 16/9 > 1), and it also avoids d² = 3/2
    rainbow = [[i * 3 + j for j in range(3)] for i in range(3)]
    expect(validate(rainbow, 9, [F(1)], 3, 3, F(2, 3), F(2, 3), F(0)), None,
           "planted green: the 3×3 rainbow validates as a proper 9-colouring")
    expect(validate(rainbow, 9, [F(1), F(3, 2)], 3, 3, F(2, 3), F(2, 3), F(0)), None,
           "planted green: …and it avoids squared distance 3/2")
    # M36: a guard sitting exactly ON an interval end is ADMISSIBLE — half-open cells never
    # realize either endpoint. Under M35's strict rule this same row read as a refusal.
    expect(validate(rainbow, 9, [F(1), F(16, 9)], 3, 3, F(2, 3), F(2, 3), F(0)), None,
           "boundary guard 16/9 admissible (the offset (3,0) touches, never reaches)")
    bad = validate(rainbow, 9, [F(1), F(2)], 3, 3, F(2, 3), F(2, 3), F(0))
    expect(bad is not None, True,
           "planted red: guard 2 sits STRICTLY inside (16/9, 64/9) — refused, as no "
           "relaxation may accept")

    # a corrupted model must be rejected: repeat a colour within unit reach
    broken = [row[:] for row in rainbow]
    broken[1][1] = broken[0][0]
    expect(validate(broken, 9, [F(1)], 3, 3, F(2, 3), F(2, 3), F(0)) is not None, True,
           "corrupted table: the validator refuses (adjacent same colour)")

    # the SAT round-trip finds the green (k = 9 at 3×3, cell 2/3) and the row records sat
    r = probe(9, [F(1)], 3, 3, F(2, 3), F(2, 3), F(0), cap=30.0)
    expect(r["outcome"], "sat", "SAT probe: k = 9 at 3×3 cells 2/3 finds a colouring")

    # cell-too-big short-circuits without SAT
    r = probe(4, [F(1)], 4, 4, F(1), F(1), F(0), cap=10.0)
    expect(r["outcome"], "cell-too-big", "cells of diagonal √2 short-circuit (no SAT)")

    # the mass red control's sample: k = 4 at a real resolution must refuse
    r = probe(4, [F(1)], 8, 8, F(1, 2), F(1, 2), F(0), cap=60.0)
    expect(r["outcome"], "unsat", "mass red sample: k = 4 bricks at 1/2 refuse (χ ≥ 5)")

    # k = 2 avoiding nothing but distance-1 still refuses (χ ≥ 5 with margin)
    r = probe(2, [F(1)], 6, 6, F(1, 2), F(1, 2), F(0), cap=30.0)
    expect(r["outcome"], "unsat", "k = 2 refuses at any resolution")

    # M36 boundary-tight controls. The cell of diagonal EXACTLY 1 is admissible (it was
    # short-circuited away under the old rule), and the kernel-certified table validates.
    r = probe(7, [F(1)], 7, 7, F(4, 5), F(3, 5), F(2, 5), cap=60.0)
    expect(r["outcome"], "sat", "the certified shape (7×7 @ 4/5×3/5, s=2/5) reads SAT")
    coset = [[(i + 3 * j) % 7 for j in range(7)] for i in range(7)]
    expect(validate(coset, 7, [F(1)], 7, 7, F(4, 5), F(3, 5), F(2, 5)), None,
           "the kernel-certified coset table validates independently")
    broken7 = [row[:] for row in coset]
    broken7[1][0] = broken7[0][0]
    expect(validate(broken7, 7, [F(1)], 7, 7, F(4, 5), F(3, 5), F(2, 5)) is not None, True,
           "planted red: adjacent cells given one colour — refused")
    expect(validate(coset, 7, [F(1)], 7, 7, F(4, 5), F(1, 2), F(2, 5)) is not None, True,
           "planted red: the same table at h = 1/2 (diag² < 1) — refused")

    print("SELF-TEST:", "ok" if not failures else f"{len(failures)} FAILURES: {failures}")
    if failures:
        sys.exit(1)


# ---------------------------------------------------------------- CLI

def status() -> None:
    print("periodic.py — the M35 brick prober (runs nothing by default).")
    if not ART.exists():
        print("no artifact yet. Next: --self-test, then --hunt (the registered campaign).")
        return
    art = load_art()
    rows = art["rows"]
    print(f"{ART.name}: {len(rows)} rows, status={art.get('status')}")
    sats = [r for r in rows if r["outcome"] == "sat"]
    for r in sats:
        print(f"  SAT: k={r['k']} D={r['D']} {r['m']}x{r['n']} cells {r['w']}x{r['h']} "
              f"s={r['s']}")


def parse_frac(x: str) -> F:
    return F(x)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--probe", nargs=7, metavar=("K", "D", "M", "N", "W", "H", "S"),
                    help="one row; D is a class name from the table or '-'")
    ap.add_argument("--ladder", nargs=2, metavar=("K", "CLASS"))
    ap.add_argument("--hunt", action="store_true")
    ap.add_argument("--hunt-rect", action="store_true", dest="huntrect")
    ap.add_argument("--hunt-tight", action="store_true", dest="hunttight")
    ap.add_argument("--control", action="store_true")
    ap.add_argument("--cap", type=float, default=120.0)
    ap.add_argument("--machine", default="desktop")
    args = ap.parse_args()
    if args.self_test:
        self_test()
    elif args.probe:
        k, cls, m, n = int(args.probe[0]), args.probe[1], int(args.probe[2]), int(args.probe[3])
        w, h, s = parse_frac(args.probe[4]), parse_frac(args.probe[5]), parse_frac(args.probe[6])
        guards = [F(1)] + CLASS_GUARDS[cls]
        r = probe(k, guards, m, n, w, h, s, args.cap)
        record(r, args.machine)
        print(json.dumps({kk: vv for kk, vv in r.items() if kk != "table"}, indent=1,
                         default=str))
        if "table" in r:
            print("table:", r["table"])
    elif args.ladder:
        ladder(int(args.ladder[0]), args.ladder[1], args.cap, args.machine)
    elif args.hunt:
        hunt(args.cap, args.machine)
    elif args.huntrect:
        hunt_rect(args.cap, args.machine)
    elif args.hunttight:
        hunt_tight(args.cap, args.machine)
    elif args.control:
        control(args.cap, args.machine)
    else:
        status()


if __name__ == "__main__":
    main()
