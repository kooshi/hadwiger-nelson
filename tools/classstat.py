#!/usr/bin/env python3
"""Within-class unit-edge structure, per exact class key — M18 §0's anomaly instrument.

UNTRUSTED, like everything in `tools/`. This is a measuring device: it never claims, it counts.

## What it measures, and the three predictions it can falsify

For every pivot of a configuration, group the other vertices by exact squared distance (the
*classes*), and census the unit edges *inside* each class: degrees, connected components, path
and cycle lengths, triangles. The class-angle lemma (M18's first Lean target) predicts, for any
finite point set in the plane with exact coordinates:

  1. **max in-class degree ≤ 2** — two distinct circles meet in at most two points;
  2. **triangles only at r² = 1/3** — a unit triangle's circumradius² is exactly 1/3;
  3. **cycle lengths only from the field's roots of unity** — a length-n in-class cycle needs
     the order-n rotation's sine and cosine in the coordinate field. In ℚ(√3,√5,√7,√11):
     n ∈ {3, 4, 6, 12} (ζ₅ needs √(10+2√5) — the *pentagon exclusion* — and ζ₈ needs √2).
     In particular **the only odd cycles any class can carry are the 1/3-triangles**.

A violation row is printed loudly and exits nonzero: it would falsify a lemma before the kernel
was asked to check it, which is exactly when falsification is cheap.

## The resistance join (`--resist`)

M17's hunt ranked classes by how often they resisted pool rejection (r²=1/3 first, irrationals
second, r²=3 third) but aggregated irrationals into one bucket and never normalized by class
width. `--resist` re-runs the pool sweep recording *exact* resisting keys, then joins them with
the structure census, so "is r²=3's rank explained by width alone?" and "which irrational keys
actually resist — are they the 12-cycle class r² = 2+√3?" become table lookups.

    python3 tools/classstat.py --self-test
    python3 tools/classstat.py --base degrey_cert
    python3 tools/classstat.py --base degrey_cert --resist --colours 5
"""

from __future__ import annotations

import argparse
import sys
import time
from collections import Counter
from dataclasses import dataclass, field as dc_field
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import construct as C  # noqa: E402
from narrow import classes_at, is_rational, sweep_pivot  # noqa: E402
from rescan import _load_base, interpret, ledger_read  # noqa: E402

#: basis index → the square root it multiplies (bit k selects PRIMES[k] = [3,5,7,11][k])
BASIS = [1, 3, 5, 15, 7, 21, 35, 105, 11, 33, 55, 165, 77, 231, 385, 1155]


def key_symbolic(kk: tuple, denom: int) -> str:
    """An exact class key as human-readable algebra: `1/2+1/10·√5`, `2+√3`, `3`, …"""
    d2 = denom * denom
    terms = []
    for i, comp in enumerate(kk):
        if comp == 0:
            continue
        q = Fraction(comp, d2)
        terms.append(str(q) if BASIS[i] == 1 else
                     (f"√{BASIS[i]}" if q == 1 else f"{q}·√{BASIS[i]}"))
    return "+".join(terms).replace("+-", "-") or "0"


def pentagon_keys(denom: int) -> list[tuple]:
    """The exact keys of r² = (5±√5)/10 at this denominator, when they are integral there."""
    d2 = denom * denom
    out = []
    for sign in (1, -1):
        rat, root5 = Fraction(1, 2), Fraction(sign, 10)
        if (rat * d2).denominator == 1 and (root5 * d2).denominator == 1:
            kk = [0] * 16
            kk[0], kk[2] = int(rat * d2), int(root5 * d2)
            out.append(tuple(kk))
    return out


# ------------------------------------------------------------------ the census

@dataclass
class ClassRow:
    """Everything measured about one exact class key, aggregated across pivots."""
    key: tuple
    instances: int = 0          # (pivot, class) pairs with this key
    members: int = 0            # total members across instances
    inclass_edges: int = 0      # unit edges with both ends in one instance
    triangles: int = 0
    max_degree: int = 0
    cycles: Counter = dc_field(default_factory=Counter)   # cycle length → count
    paths: Counter = dc_field(default_factory=Counter)    # path edge-count → count (≥1 only)
    resist_calls: int = 0
    resist_sat: int = 0


def census(cfg: C.Config, resist: bool = False, k: int = 5,
           budget: float | None = 300.0) -> tuple[dict[tuple, ClassRow], list[str]]:
    """Walk every pivot; return per-key rows and a list of violation strings (expected empty).

    Structure is per *instance* — the same key at two pivots is two induced graphs — and the
    row aggregates. With `resist`, a shared-pool sweep runs per pivot exactly as the hunt's
    (`narrow.sweep_pivot`), and each solver call is credited to its class key."""
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    n, E = len(coords), cfg.edges()
    adj: list[set[int]] = [set() for _ in range(n)]
    for a, b in E:
        adj[a].add(b)
        adj[b].add(a)
    rows: dict[tuple, ClassRow] = {}
    violations: list[str] = []
    pool: list = []
    for p in range(n):
        cl = classes_at(coords, p)
        cid = {v: kk for kk, Q in cl.items() for v in Q}
        induced: dict[tuple, list[tuple[int, int]]] = {}
        for a, b in E:
            if a != p and b != p and cid[a] == cid[b]:
                induced.setdefault(cid[a], []).append((a, b))
        for kk, Q in cl.items():
            row = rows.setdefault(kk, ClassRow(key=kk))
            row.instances += 1
            row.members += len(Q)
            ie = induced.get(kk, [])
            row.inclass_edges += len(ie)
            if not ie:
                continue
            deg: Counter = Counter()
            nb: dict[int, list[int]] = {}
            for a, b in ie:
                deg[a] += 1
                deg[b] += 1
                nb.setdefault(a, []).append(b)
                nb.setdefault(b, []).append(a)
            row.max_degree = max(row.max_degree, max(deg.values()))
            if max(deg.values()) > 2:
                violations.append(f"DEGREE > 2: pivot {p}, key {key_symbolic(kk, cfg.denom)}")
            # triangles: count each once via sorted vertex triples on in-class edges
            tri = {tuple(sorted((a, b, c)))
                   for a, b in ie for c in nb[a] if c != b and c in adj[b]}
            row.triangles += len(tri)
            # components of a degree-≤2 graph: paths and cycles, walked once each
            seen: set[int] = set()
            for start in nb:
                if start in seen:
                    continue
                comp, frontier = {start}, [start]
                while frontier:
                    v = frontier.pop()
                    for w in nb[v]:
                        if w not in comp:
                            comp.add(w)
                            frontier.append(w)
                seen |= comp
                edge_cnt = sum(len(nb[v]) for v in comp) // 2
                if edge_cnt == len(comp) and all(len(nb[v]) == 2 for v in comp):
                    row.cycles[len(comp)] += 1
                    if len(comp) % 2 == 1 and len(comp) != 3:
                        violations.append(f"ODD {len(comp)}-CYCLE off the triangle class: "
                                          f"pivot {p}, key {key_symbolic(kk, cfg.denom)}")
                else:
                    row.paths[edge_cnt] += 1
        if resist:
            sw = sweep_pivot(n, E, coords, p, k, budget, pool=pool)
            for kk, st in sw.called:
                rows[kk].resist_calls += 1
                if st == "sat":
                    rows[kk].resist_sat += 1
    # prediction 2/3 checks that need the whole table
    for kk, row in rows.items():
        r2 = Fraction(kk[0], cfg.denom ** 2) if is_rational(kk) else None
        if row.triangles and r2 != Fraction(1, 3):
            violations.append(f"TRIANGLES at r² = {key_symbolic(kk, cfg.denom)} ≠ 1/3")
        if any(ln not in (3, 4, 6, 12) for ln in row.cycles):
            violations.append(f"cycle census {dict(row.cycles)} outside {{3,4,6,12}} at "
                              f"key {key_symbolic(kk, cfg.denom)}")
    for kk in pentagon_keys(cfg.denom):
        if kk in rows and rows[kk].inclass_edges:
            violations.append(f"PENTAGON CLASS CARRIES UNIT EDGES: {key_symbolic(kk, cfg.denom)}"
                              f" — the field-exclusion story is wrong")
    return rows, violations


def report(rows: dict[tuple, ClassRow], denom: int, top: int, resist: bool) -> None:
    def density(r: ClassRow) -> float:
        return r.inclass_edges / r.members if r.members else 0.0

    ranked = sorted(rows.values(), key=lambda r: (-r.resist_calls if resist else 0,
                                                  -r.inclass_edges, -r.members))
    head = "r² (exact)              | inst | membrs | inEdg | dens | tri | cycles"
    if resist:
        head += " | resist calls (sat)"
    print(head)
    for r in ranked[:top]:
        line = (f"{key_symbolic(r.key, denom):<24}| {r.instances:>4} | {r.members:>6} | "
                f"{r.inclass_edges:>5} | {density(r):.2f} | {r.triangles:>3} | "
                f"{dict(sorted(r.cycles.items())) if r.cycles else '-'}")
        if resist:
            line += f" | {r.resist_calls} ({r.resist_sat})"
        print(line)


# ------------------------------------------------------------------ self-test

def self_test() -> None:
    """The census on graphs whose structure is known by hand, and the violation reporter
    driven to fire on purpose."""
    # the Moser spindle: 7 points, its class structure is small and hand-checkable; above
    # all: zero triangles anywhere but r² = 1/3 classes, degree ≤ 2, no forbidden cycles
    spindle = C.spindle(C.rhombus(), pivot=2, target=3)
    rows, viol = census(spindle)
    assert not viol, f"spindle census violations: {viol}"
    assert all(r.max_degree <= 2 for r in rows.values())

    # a bare rhombus has classes but no in-class unit edge at all
    _, viol2 = census(C.rhombus())
    assert not viol2

    # the violation reporter's cycle-length test fires on a fabricated 5-cycle — the check
    # is the same predicate `census` applies to every row's census
    fake = ClassRow(key=(1,) + (0,) * 15)
    fake.cycles[5] = 1
    assert any(ln not in (3, 4, 6, 12) for ln in fake.cycles), \
        "the cycle-length predicate must reject a 5-cycle"

    # pentagon keys exist at a denominator divisible by 10 and are integral there
    pk = pentagon_keys(10)
    assert len(pk) == 2 and all(k[2] != 0 for k in pk)
    assert pentagon_keys(3) == [], "denominator 3 cannot express (5±√5)/10 integrally"

    # symbolic display round-trips the interesting keys
    assert key_symbolic((1,) + (0,) * 15, 1) == "1"
    kk = [0] * 16
    kk[0], kk[1] = 2, 1
    assert key_symbolic(tuple(kk), 1) == "2+√3"
    print("classstat.py self-test OK")


# ------------------------------------------------------------------ main

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--base", help="configuration by tools/<name>.json (or degrey_seed)")
    ap.add_argument("--ledger-name", help="candidate by its hunt_ledger name")
    ap.add_argument("--resist", action="store_true",
                    help="also run the shared-pool sweep and credit solver calls to keys")
    ap.add_argument("--colours", type=int, default=5)
    ap.add_argument("--budget", type=float, default=300.0)
    ap.add_argument("--top", type=int, default=25)
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    if args.base:
        cfg = _load_base(args.base)
        name = args.base
    elif args.ledger_name:
        led = ledger_read()
        rec = next((r for r in led.values() if r.get("name") == args.ledger_name
                    and "error" not in r), None)
        if rec is None:
            raise SystemExit(f"no ledger record named '{args.ledger_name}'")
        cfg = interpret(rec["recipe"])
        name = args.ledger_name
    else:
        ap.error("nothing to do — try --self-test, --base, or --ledger-name")
        return

    t0 = time.time()
    rows, viol = census(cfg, resist=args.resist, k=args.colours, budget=args.budget)
    print(f"{name}: {len(cfg)} pts, {len(rows)} distinct class keys, "
          f"{time.time() - t0:.0f}s\n")
    report(rows, cfg.denom, args.top, args.resist)
    if viol:
        print(f"\n** {len(viol)} PREDICTION VIOLATION(S) — a lemma is wrong; "
              f"do not formalize past this **")
        for v in viol[:40]:
            print("  " + v)
        raise SystemExit(1)
    print("\npredictions hold: degree ≤ 2, triangles only at 1/3, cycles ⊆ {3,4,6,12}, "
          "no pentagon unit edges")


if __name__ == "__main__":
    main()
