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
        return f"saturation of configuration {tag} ({r['N']} pairs, D = {r.get('D')})"
    return f"listed configuration {tag} = {conf} ({r['N']} pairs, D = {r.get('D')})"


def main():
    recs = []
    for p in sys.argv[1:]:
        recs += [json.loads(l) for l in open(p) if l.strip()]
    by = defaultdict(list)
    for r in recs:
        by[r["d"]].append(r)
    fields = sorted(by, key=lambda d: (d not in OPEN, d))
    print("### Per field\n")
    print("| d | mod 8 | census | first certified EMPTY (object; certificate) | otherwise |")
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
                ver += " at cap"
            print(f"| {d} | {obj(r)} | {ver} | {chk} | {st.get('nodes', '')} | {st.get('wall_s', '')} |")


if __name__ == "__main__":
    main()
