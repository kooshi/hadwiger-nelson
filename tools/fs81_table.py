#!/usr/bin/env python3
"""FS-81 phase 0: the per-field table from the stage records (derived; never hand-edited).

Cell codes: E = EMPTY, certificate PASSed by the named checker; N = NONEMPTY, a point certified (on the listed units; `N*` when
the frozen checker also passed it on every unit vector of the span); N(θ) = a saturation whose units the configuration's own θ
already colours (no new tree); U = UNDECIDED at the cap (the tree is a weak finder of isolated points: an isolated point of order
above 12 reads as UNDECIDED); X = error; − = the configuration does not exist at d.
Usage: fs81_table.py STAGE.jsonl [STAGE2.jsonl ...]
"""
import json
import sys
from collections import defaultdict

OPEN = {35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419, 443, 455, 467, 479, 491}


def code(r):
    v = r["verdict"]
    if v == "EMPTY":
        return "E" if r.get("check") == "PASS" else "E?"
    if v == "NONEMPTY":
        if "check" not in r:
            return "N(θ)"
        if r.get("check") == "PASS":
            return "N*" if "frozen" in r.get("checker", "") else "N"
        return "N" if r.get("check2") == "PASS" else "N?"
    if v == "UNDECIDED":
        return f"U({r['stats']['nodes']})"
    return "X"


LAYERS = {"A": "{1, v, v̄}", "B": "{vᵏ : \\|k\\| ≤ 2}"}


def obj(r):
    """What the row's certificate is about: a listed configuration, or the saturation of one (all unit vectors of its span)."""
    if "census_id" in r:
        return f"FS-61 open lattice {r['census_id']} (all {r['N']} pairs of its key, D = {r['D']})"
    name = r.get("config", "?")
    K = r.get("K", 1)
    tag, *rest = name.replace("conj|", "").replace("gal|", "").split(":")
    if tag in LAYERS:
        lay = LAYERS[tag]
    elif tag in ("C", "D"):
        lay = "{1, v, z" + ("" if tag == "C" else "₅") + f"}}, (a, c) = ({rest[0]}, {rest[1]}), sign {rest[2]}"
    else:
        lay = name
    conf = f"{lay}·U^(5{'' if K == 1 else '^' + str(K)})"
    if name.startswith("conj|"):
        conf = "complex conjugate of " + conf
    if r.get("saturated"):
        return f"saturation of configuration {name} ({r['N']} pairs, D = {r.get('D')})"
    return f"listed configuration {tag} = {conf} ({r['N']} pairs, D = {r.get('D')})"


def summary(recs, struct):
    """The phase's per-field table: the P0.3 structural certificate (listed B at K_B) and the P0.2 tree-route EMPTY objects."""
    st = {}
    for r in struct:
        if r["K"] == r["K_B"]:
            st[r["d"]] = r
    by = defaultdict(list)
    for r in recs:
        by[r["d"]].append(r)
    print("| d | mod 8 | mod 24 | census | χ ≥ 4 certified by: P0.3 structural (object; certificate; checker) | "
          "also certified by the relation tree (P0.2 objects; frozen checker) | P0.2 nulls (typed) |")
    print("|---|---|---|---|---|---|---|")
    for d in sorted(set(st) | set(by), key=lambda d: (d not in OPEN, d)):
        s3 = st.get(d)
        c3 = (f"listed B = {{vᵏ : \\|k\\| ≤ 2}}·U^(5^{s3['K']}) ({10 * (2 * s3['K'] + 1)} pairs); `{s3['cert']}`; "
              f"fs81_struct_check.py {s3.get('check')}") if s3 else "—"
        emp = [obj(r) for r in by[d] if r["verdict"] == "EMPTY" and r.get("check") == "PASS"]
        nn = sum(1 for r in by[d] if r["verdict"] == "NONEMPTY")
        un = sum(1 for r in by[d] if r["verdict"] == "UNDECIDED")
        nulls = f"{nn} NONEMPTY" + (f", {un} UNDECIDED at the cap (weak finder of isolated points)" if un else "")
        print(f"| {d} | {d % 8} | {d % 24} | {'open' if d in OPEN else 'certified'} | {c3} | {'; '.join(emp) or '—'} | {nulls} |")


def main():
    args = sys.argv[1:]
    if args and args[0] == "--summary":
        struct = [json.loads(l) for l in open(args[1]) if l.strip()]
        recs = []
        for p in args[2:]:
            recs += [json.loads(l) for l in open(p) if l.strip()]
        summary(recs, struct)
        return
    recs = []
    for p in args:
        recs += [json.loads(l) for l in open(p) if l.strip()]
    by = defaultdict(list)
    for r in recs:
        by[r["d"]].append(r)
    fields = sorted(by, key=lambda d: (d not in OPEN, d))
    print("**Only an `E` cell speaks about the field.** It proves χ(ℚ(√d)²) ≥ 4 at grade [cert + hand: FS73-T22 ⟹]. Every other "
          "cell is a typed null for the object named. Codes: `E` EMPTY, certificate PASSed; `N` NONEMPTY certified on the listed "
          "configuration only; `N*` NONEMPTY certified on every unit vector of the object's span (its saturation); `N(θ)` a saturation "
          "the configuration's own θ already colours; `U` UNDECIDED at the cap (the tree is a weak finder of isolated points: an "
          "isolated point of order above 12 reads UNDECIDED).\n")
    print("### Per field\n")
    print("| d | mod 8 | census | χ ≥ 4 certified by (object; certificate) | otherwise |")
    print("|---|---|---|---|---|")
    for d in fields:
        first = next((r for r in by[d] if r["verdict"] == "EMPTY" and r.get("check") == "PASS"), None)
        if first:
            cell, other = f"{obj(first)}; `{first['cert']}` ({first['checker']})", ""
        else:
            und = [r for r in by[d] if r["verdict"] == "UNDECIDED"]
            cell = "—"
            other = (f"NONEMPTY on every object at depth K = {max(r.get('K', 1) for r in by[d])}"
                     + (f"; {len(und)} UNDECIDED at the cap (a weak finder of isolated points: order > 12 reads UNDECIDED)"
                        if und else ""))
        print(f"| {d} | {d % 8} | {'open' if d in OPEN else 'certified'} | {cell} | {other} |")
    print("\n### Every object\n")
    print("| d | object | verdict | checker | tree nodes | s |")
    print("|---|---|---|---|---|---|")
    for d in fields:
        for r in by[d]:
            st = r.get("stats", {})
            chk = r.get("checker", "—") + (f" {r.get('check')}" if r.get("check") else "")
            if r.get("check") == "FAIL" and r.get("check2"):
                chk = (f"frozen FAIL on an unlisted unit of the span; {r['checker2']} {r['check2']} (listed units)")
            if "check" not in r and r["verdict"] == "NONEMPTY":
                chk = r.get("finder", "")
            ver = code(r)
            if r["verdict"] == "UNDECIDED":
                ver += " at cap (weak finder of isolated points)"
            if (r.get("by_theorem") or (r.get("config") == "A" and r["d"] % 24 == 11)) and not r.get("saturated"):
                ver += ("; NONEMPTY by theorem [hand, verifier §4.0]" if r["verdict"] == "NONEMPTY"
                        else "; nonempty by theorem [hand, verifier §4.0]")
            if r.get("config") == "A" and not r.get("saturated"):
                ver += f"; d ≡ {r['d'] % 24} (mod 24)"
            print(f"| {d} | {obj(r)} | {ver} | {chk} | {st.get('nodes', '')} | {st.get('wall_s', '')} |")


if __name__ == "__main__":
    main()
