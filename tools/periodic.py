#!/usr/bin/env python3
"""The periodic prober (M35 phase 2): brick colourings of the plane, hunted by SAT.

UNTRUSTED, like everything in `tools/`. A found colouring becomes mathematics only when its
table replays through `Brick.check` in Lean; a refusal here is RESOLUTION-BOUNDED — "no brick
colouring at this cell size and period", never "no periodic colouring".

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
    python3 tools/periodic.py --probe 7 - 8 8 1/2 1/2 0     # one row: k D m n w h s
    python3 tools/periodic.py --ladder 7 -                  # the registered ladder, one (k, D)
    python3 tools/periodic.py --hunt                        # the full registered campaign
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

ART = BUILD / "m35-periodic.json"
SCHEMA = ("m35-periodic v1 (plans/M35-k5-transfer.md §0b; brick refusals are "
          "RESOLUTION-bounded — a refusal at cell w×h is not a period claim; promotion tops "
          "at prober-validated until Brick.check replays in Lean)")


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
            hit = [q for q in guards if lo <= q <= hi]
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
    if any(q <= diag for q in guards):
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
            hit = [q for q in guards if lo <= q <= hi]
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
    print("BRICK ENCODING CATASTROPHE: a k = 4 row read SAT with a validated model — this "
          "contradicts the kernel theorem χ(ℝ²) ≥ 5. The encoding or the validator is "
          "wrong. ALL m35-periodic verdicts are void until resolved.")
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

    # the boundary adversary (§0b): offset (3,0) at w = 1/2 has closed lo = 1 exactly —
    # the conservative check must CONFLICT on guard 1 even though the open truth misses it
    lo, hi = interval_gen(F(3, 2), F(0), F(1, 2), F(1, 2))
    expect((lo, F(1) >= lo and F(1) <= hi), (F(1), True),
           "boundary adversary: closed hull [1, …] catches guard 1 (conservatism refuses)")
    lo2, hi2 = interval_val(F(3, 2), F(0), F(1, 2), F(1, 2))
    expect((lo2, hi2), (lo, hi), "…and the validator formula agrees at the boundary")

    # the planted green: the 3×3 rainbow at cell 2/3 is a valid 9-colouring (diag² = 8/9 < 1,
    # nearest same colour at (2·2/3)² = 16/9 > 1), and it also avoids d² = 3/2
    rainbow = [[i * 3 + j for j in range(3)] for i in range(3)]
    expect(validate(rainbow, 9, [F(1)], 3, 3, F(2, 3), F(2, 3), F(0)), None,
           "planted green: the 3×3 rainbow validates as a proper 9-colouring")
    expect(validate(rainbow, 9, [F(1), F(3, 2)], 3, 3, F(2, 3), F(2, 3), F(0)), None,
           "planted green: …and it avoids squared distance 3/2")
    bad = validate(rainbow, 9, [F(1), F(16, 9)], 3, 3, F(2, 3), F(2, 3), F(0))
    expect(bad is not None, True,
           "planted red: guard 16/9 sits ON the closed bound — conservatism refuses")

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
    else:
        status()


if __name__ == "__main__":
    main()
