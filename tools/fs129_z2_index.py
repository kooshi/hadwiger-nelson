#!/usr/bin/env python3
"""FS129-Z2 — the index corrected (FS-129 inventory items 77, 99, 111, 118).

Reads the index as FS129-IX1 wrote it (data/fs129/index/edges.csv, theorems.jsonl) and never edits it or tools/fs129_index.py. Writes,
beside the originals, `edges-corrected.csv`, `edges-dropped.csv`, `hubs-corrected.md`, `roots-corrected.md`, `cycles-corrected.md`,
`lean-order-corrected.md`, `vacuity-corrected.md` and `corrections.md` (what changed and why), with the same definitions the original
files state in their headers, recomputed on the corrected edges by the original script's own functions (imported, not copied).

Corrections, each an edge (from, to) read as in edges.csv — "to uses from":
  sorted by a reader (classes as in tools/fs129_sr1_edges.py: real / route / false / reversed):
    SR1  26 lane-R edges from "Rests on it: nothing …" sentences   (plans/FS129-SR1-audit.md § 4.1; tools/fs129_sr1_edges.py)
    SR2  23 edges inside lane-R cycles                            (plans/FS129-SR2-audit.md § 2.3; tools/fs129_sr2_cycles.py)
    SA1   9 lane-A "nothing" edges and 2 correction edges into FS89-CL2 (plans/FS129-SA1-audit.md § 4.3)
  false and reversed edges are dropped (listed in edges-dropped.csv); a reversed edge's true direction (`to` -> `from`, i.e. `from`
  uses `to`) is added where edges.csv lacks it (class `reversed-fix`); route edges are kept and marked `route`.
  added by rule (item 111), each marked:
    range   a range citation "T3–T5" / "FS89-CL2–CL5" in a `uses only:`, Rests-on-it or `derived from:` text loses its middle member
            (the original tokenizer reads the two ends only). Each middle member that resolves by the original tiers (exact id, or
            `<file prefix>-<token>`) gets the edge the field implies, when both ends also resolve so (the family is an id family).
    prefix  a hyphenated token in a `uses only:` line or a `derived from:` grade written without its milestone prefix (`C-HULL` for
            FS111-C-HULL, `M-PINCH`), resolved only when it has exactly one suffix candidate (data/fs129/index/unresolved.md), the
            candidate is not the citing entry, and the candidate's milestone number is at most the citing entry's (a result does not use
            a later milestone's). Every other suffix candidate stays unresolved and is listed in corrections.md.

    python3 tools/fs129_z2_index.py            # write the corrected files; exit 1 if a self-check fails
    python3 tools/fs129_z2_index.py --fault    # plant one fault (keep the false edge FS111-C-HULL-SO -> FS111-C-HULL); writes NOTHING,
                                               # prints the summary, which must differ from the clean run's (it fires)
"""
from __future__ import annotations

import csv
import importlib.util
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
IX = ROOT / "data" / "fs129" / "index"
_spec = importlib.util.spec_from_file_location("fs129_index", ROOT / "tools" / "fs129_index.py")
fx = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(fx)  # definitions only; its main() runs under __main__ alone

SR1 = [  # plans/FS129-SR1-audit.md § 4.1, as tools/fs129_sr1_edges.py SORTED
    ('FS111-C-HULL-SO', 'FS111-C-HULL', 'false'), ('FS111-M2-DISCK7-AS-PLACED', 'FS111-M2-DISCK7', 'false'),
    ('FS112-Y3-R1', 'FS112-N3-CHAINS', 'false'), ('FS114-K1', 'FS114-N7-HUB', 'false'), ('FS114-ROUTE-T', 'FS114-N2-LEMMAS', 'reversed'),
    ('FS116-O1-YESLIM', 'FS116-C114-LOCAL-F', 'real'), ('FS116-RING-Q', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-RING-TRANSFER-QC', 'FS116-C114-LOCAL-F', 'real'), ('FS116-S1-QF', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-S1-QF', 'FS116-SAT-STRIP', 'real'), ('FS116-SEMI-PAR3', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-V4-MEET', 'FS116-S1-KAPPA', 'route'), ('FS116-V4-OUTER', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V4-PARTNER', 'FS116-S1-KAPPA', 'route'), ('FS116-V4-TWIST', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V5-DICHO', 'FS116-N3-SEMI', 'route'), ('FS116-V5-LENS', 'FS116-Y3-SIX', 'route'),
    ('FS121-C1-GMAP', 'FS121-D3-GRUNDY', 'false'), ('FS121-D1-PENCILWIN', 'FS121-O1-OUT', 'false'),
    ('FS121-D2-PERFIN', 'FS121-D2-SYM', 'reversed'), ('FS121-D4-HOLE', 'FS111-M-PINCH', 'false'),
    ('FS121-DB1-L6', 'FS111-M2-INTRAD', 'false'), ('FS121-DB1-L7', 'FS121-O1-OUT', 'false'),
    ('FS121-V2-EROSION-DIAM', 'FS121-D1-EROSION', 'false'), ('FS121-V2-VT-W', 'FS121-D1-VT', 'false'),
    ('FS121-V3-CPI', 'FS121-V2-SECTOR', 'false'),
]
SR2 = [  # plans/FS129-SR2-audit.md § 2.3, as tools/fs129_sr2_cycles.py SR2_SORTED
    ('FS111-C1-PW', 'FS111-C1-UNIF', 'false'), ('FS111-C1-UNIF', 'FS111-C1-PW', 'false'),
    ('FS106-EQ', 'FS106-SUP', 'false'),
    ('FS121-D1-R2CORNER', 'FS121-D1-R2SMOOTH', 'reversed'), ('FS121-D1-R2CORNER', 'FS121-D1-RUNG2', 'reversed'),
    ('FS121-DB1-L4', 'FS121-DB1-L1', 'reversed'), ('FS121-V5-RAY', 'FS121-V5-LOC', 'reversed'),
    ('FS111-M3-FIXCONV', 'FS111-M2-FIX', 'false'),
    ('FS114-CV-EXISTS', 'FS112-L60', 'false'), ('FS114-CV-EXISTS', 'FS112-N3-DENSE3', 'reversed'),
    ('FS114-CV-EXISTS', 'FS114-L60-WALK', 'reversed'),
    ('FS114-N6-NOQ', 'FS114-Y5-PINALL', 'false'), ('FS114-Y5-PINALL', 'FS114-N6-NOQ', 'false'),
    ('FS114-N5-GRING', 'FS114-Y4-RSTOPALL', 'route'), ('FS114-Y3-RSTOP', 'FS114-N4-D', 'false'),
    ('FS114-Y3-RSTOP', 'FS114-Y4-RSTOPALL', 'real'), ('FS114-Y4-RSTOPALL', 'FS114-N4-D', 'false'),
    ('FS114-Y4-RSTOPALL', 'FS114-Y3-RSTOP', 'false'),
    ('FS111-M2-DISC7', 'FS111-M2-HULLC', 'false'), ('FS111-M-COVER-SC', 'FS111-M2-HULLC', 'false'),
    ('FS112-BUDGET2', 'FS112-NB4P', 'false'),
    ('FS112-C-ENDS', 'FS114-CV-EXISTS', 'route'), ('FS114-CV-HD', 'FS114-CV-EXISTS', 'route'),
]
SA1 = [  # plans/FS129-SA1-audit.md § 4.3: the nine lane-A "nothing" edges, then the two correction edges into FS89-CL2
    ('FS56-T6', 'FS56-T2', 'reversed'), ('FS79-T31', 'FS79-T40', 'false'), ('FS79-T41', 'FS79-T38', 'false'),
    ('FS85-A3', 'FS85-dB2', 'false'), ('FS91-J01-3', 'FS91-J01-2', 'false'), ('FS91-J03a-6', 'FS91-J01-7', 'false'),
    ('M3-J21-NG3', 'M3-J21-MX', 'false'), ('MASCOT-T3', 'MASCOT-T4', 'false'), ('Q8-T1', 'M51-T1', 'false'),
    ('FS91-J03a-9', 'FS89-CL2', 'false'), ('FS91-J07-14', 'FS89-CL2', 'false'),
]
SORTS = [("SR1", SR1), ("SR2", SR2), ("SA1", SA1)]
# the 16 ids of item 20's 68 that the no-entry lookup missed because they are filed with a milestone prefix (plans/FS129-SA1-audit.md § 4.2)
PREFIX16 = {"X27D-EQ": "FS100-X27D-EQ", "X27D-E": "FS100-X27D-E", "X27D-ATT": "FS100-X27D-ATT", "X27D-FL": "FS100-X27D-FL",
            "X27D-SIERP": "FS100-X27D-SIERP", "X28D-P": "FS100-X28D-P", "X28D-S": "FS100-X28D-S", "X28D-CP1": "FS100-X28D-CP1",
            "X28D-CP2": "FS100-X28D-CP2", "X28D-CP3": "FS100-X28D-CP3", "X28D-ODD": "FS100-X28D-ODD", "X28D-CUBE": "FS100-X28D-CUBE",
            "TS-L1": "FS106-TS-L1", "TC-tab": "R88-TC-tab", "D0-T1": "FS89-D0-T1", "D5-L2": "FS89-D5-L2"}
FAULT_KEEP = ('FS111-C-HULL-SO', 'FS111-C-HULL')
RANGE = re.compile(r"(?<![A-Za-z0-9-])((?:[A-Za-z0-9]+-)*[A-Za-z]+)(\d+)\s*[–—]\s*((?:[A-Za-z0-9]+-)*[A-Za-z]*)(\d+)\b")
MSNUM = re.compile(r"^(?:FS|M)(\d+)")


def load():
    recs = {}
    with open(IX / "theorems.jsonl", encoding="utf-8") as f:
        f.readline()
        for ln in f:
            d = json.loads(ln)
            recs[d["id"]] = d
    rows = [r for r in csv.reader(ln for ln in open(IX / "edges.csv", encoding="utf-8") if not ln.startswith("#"))][1:]
    return recs, [(a, b, s) for a, b, s in rows]


def prefix_of(r):
    return Path(r["file"]).name[: -len("-derivation.md")]


def resolve_tok(tok, pfx, ids):
    if tok in ids:
        return tok
    if f"{pfx}-{tok}" in ids:
        return f"{pfx}-{tok}"
    return None


def range_edges(recs, ids):
    """(from, to, field, citation) for each middle member of a range citation, by the original resolution tiers."""
    out = []
    for i, r in sorted(recs.items()):
        pfx = prefix_of(r)
        texts = [("uses", r["uses_raw"] or ""), ("rests", r["rests_text"] or "")]
        gm = re.match(r"\s*derived from\b", r["grade"] or "", re.I)
        if gm:
            texts.append(("grade", r["grade"][gm.end():]))
        for fld, t in texts:
            for m in RANGE.finditer(t):
                s1, n1, s2, n2 = m.group(1), int(m.group(2)), m.group(3), int(m.group(4))
                if s2 and not s1.endswith(s2):
                    continue  # "T7–FS3": not one family
                if not (n1 < n2 <= n1 + 40):
                    continue
                lo, hi = resolve_tok(f"{s1}{n1}", pfx, ids), resolve_tok(f"{s1}{n2}", pfx, ids)
                if not (lo and hi):
                    continue
                for n in range(n1 + 1, n2):
                    mid = resolve_tok(f"{s1}{n}", pfx, ids)
                    if not mid or mid == i:
                        continue
                    e = (i, mid) if fld == "rests" else (mid, i)
                    out.append((e[0], e[1], fld, m.group(0)))
    return out


def prefix_edges(recs, ids):
    """(from, to, field, token) for the strict suffix-candidate rule; and the list of candidates not resolved."""
    added, left = [], []
    for ln in open(IX / "unresolved.md", encoding="utf-8"):
        m = re.match(r"- `([^`]+)` — in (uses only|rests on it|grade) of (\S+) \(([^)]+)\)(?: — suffix candidates: (.*))?$", ln.rstrip("\n"))
        if not m or not m.group(5):
            continue
        tok, where, frm, addr, cands = m.groups()
        cl = [c.strip() for c in cands.split(",")]
        ok = (where in ("uses only", "grade") and "-" in tok and "…" not in cands and len(cl) == 1 and cl[0] != frm and cl[0] in ids)
        if ok:
            a, b = MSNUM.match(cl[0]), MSNUM.match(frm)
            ok = bool(a and b and int(a.group(1)) <= int(b.group(1)))
        (added if ok else left).append((cl[0] if ok else cands, frm, where, tok, addr))
    return [(c, f, w, t) for c, f, w, t, _ in added], left


def correct(recs, edges, fault=False):
    ids = set(recs)
    present = {(a, b): s for a, b, s in edges}
    problems = []
    seen = {}
    for name, lst in SORTS:
        for a, b, k in lst:
            if (a, b) not in present:
                problems.append(f"{name}: sorted edge {a} -> {b} is not in edges.csv")
            if (a, b) in seen:
                problems.append(f"{name}: edge {a} -> {b} sorted twice (also {seen[(a, b)]})")
            seen[(a, b)] = name
    cls = {(a, b): (k, name) for name, lst in SORTS for a, b, k in lst}
    drop = {e for e, (k, _) in cls.items() if k in ("false", "reversed")}
    if fault:
        drop.discard(FAULT_KEEP)
    kept = [(a, b, s, cls[(a, b)][0] if (a, b) in cls else "") for a, b, s in edges if (a, b) not in drop]
    dropped = [(a, b, s, cls[(a, b)][0], cls[(a, b)][1]) for a, b, s in edges if (a, b) in drop]
    have = {(a, b) for a, b, *_ in kept}
    added = []
    for (a, b), (k, name) in sorted(cls.items()):
        if k == "reversed" and (b, a) not in have:
            added.append((b, a, "z2", "reversed-fix")); have.add((b, a))
    rng = range_edges(recs, ids)
    for a, b, fld, cit in rng:
        if (a, b) not in have and (a, b) not in drop:
            added.append((a, b, "z2", "range")); have.add((a, b))
    pre, left = prefix_edges(recs, ids)
    for a, b, fld, tok in pre:
        if (a, b) not in have and (a, b) not in drop:
            added.append((a, b, "z2", "prefix")); have.add((a, b))
    for a, b, *_ in added:
        if a not in ids or b not in ids:
            problems.append(f"added edge {a} -> {b} has an endpoint that is no entry")
    allk = kept + added
    if len({(a, b) for a, b, *_ in allk}) != len(allk):
        problems.append("duplicate edge in the corrected list")
    if not fault and any((a, b) in drop for a, b, *_ in allk):
        problems.append("a dropped edge survives")
    for k_ in PREFIX16.values():
        if k_ not in ids:
            problems.append(f"PREFIX16: {k_} is not an entry id")
    return {"kept": kept, "added": added, "dropped": dropped, "range": rng, "prefix": pre, "prefix_left": left, "problems": problems}


def graph(recs, es):
    adj, radj = defaultdict(set), defaultdict(set)
    for a, b in es:
        adj[a].add(b); radj[b].add(a)
    nodes = sorted(recs)
    comps = fx.tarjan(nodes, adj)
    depth = fx.depths(nodes, comps, adj, radj)
    return {"adj": adj, "radj": radj, "comps": comps, "cycles": [c for c in comps if len(c) > 1], "depth": depth}


def lean(recs, g, closure_edges=None):
    seeds = sorted(i for i, r in recs.items() if r["handoff"] and fx.DEBRUIJN.search(r["handoff"]))
    ix = {"records": recs, "radj": g["radj"], "comps": g["comps"]}
    return fx.lean_order(ix), seeds


def summary(recs, res, g, lo, lo_first):
    nd = {i: len(fx.descendants(g["adj"], i)) for i in recs}
    rk = sorted(recs, key=lambda i: (-g["depth"]["down"][i], -nd[i], i))
    k = defaultdict(int)
    for *_, c in res["kept"]:
        k[c or "unsorted"] += 1
    return (f"z2 index: edges {len(res['kept']) + len(res['dropped'])} -> {len(res['kept']) + len(res['added'])} "
            f"(dropped {len(res['dropped'])}: false {sum(1 for d in res['dropped'] if d[3] == 'false')}, reversed {sum(1 for d in res['dropped'] if d[3] == 'reversed')}; "
            f"kept and marked route {k['route']}, real {k['real']}; added {len(res['added'])}: reversed-fix {sum(1 for a in res['added'] if a[3] == 'reversed-fix')}, "
            f"range {sum(1 for a in res['added'] if a[3] == 'range')}, prefix {sum(1 for a in res['added'] if a[3] == 'prefix')}); "
            f"cycles {len(g['cycles'])}; Lean order {len(lo['closure'])} ({len(lo_first['closure'])} on first routes); "
            f"top root {rk[0]} depth {g['depth']['down'][rk[0]]}; FS111-C-HULL-SO dependents {nd['FS111-C-HULL-SO']}; FS121-D4-HOLE dependents {nd['FS121-D4-HOLE']}")


def main():
    fault = "--fault" in sys.argv
    recs, edges = load()
    res = correct(recs, edges, fault)
    es = [(a, b) for a, b, *_ in res["kept"] + res["added"]]
    g = graph(recs, es)
    lo, seeds = lean(recs, g)
    g_first = graph(recs, [(a, b) for a, b, s, c in res["kept"] + res["added"] if c != "route"])
    lo_first, _ = lean(recs, g_first)
    # the sorts alone (no added edges), for comparison with SR2's printed line
    g_sorts = graph(recs, [(a, b) for a, b, *_ in res["kept"]])
    lo_sorts, _ = lean(recs, g_sorts)
    line = summary(recs, res, g, lo, lo_first)
    print(line)
    print(f"z2 index, the readers' sorts alone (no added edges): cycles {len(g_sorts['cycles'])}; Lean order {len(lo_sorts['closure'])}")
    for p in res["problems"]:
        print("PROBLEM:", p)
    if fault:
        print("(--fault: one false edge kept; nothing written)")
        return 0
    if res["problems"]:
        return 1
    write(recs, res, g, lo, lo_first, line, g_sorts, lo_sorts)
    return 0


def hdr(what):
    return f"<!-- {what} | command: python3 tools/fs129_z2_index.py | FS129-Z2, from data/fs129/index/edges.csv and theorems.jsonl as FS129-IX1 wrote them -->\n\n"


def write(recs, res, g, lo, lo_first, line, g_sorts, lo_sorts):
    adj, radj, depth = g["adj"], g["radj"], g["depth"]
    nd = {i: len(fx.descendants(adj, i)) for i in recs}
    # edges-corrected.csv
    with open(IX / "edges-corrected.csv", "w", encoding="utf-8", newline="") as f:
        f.write("# edges.csv corrected by FS129-Z2 (inventory items 77, 99, 111, 118): false and reversed edges dropped (edges-dropped.csv); "
                "z2 = '' (unsorted, as IX1 wrote it), real / route (sorted by a reader and kept; a route edge is a step of a second mind's route, "
                "not needed by the first proof), reversed-fix (the true direction of a reversed edge), range (a range citation's middle member), "
                "prefix (a hyphenated id written without its milestone prefix, strict rule); consumers skip lines starting # | command: python3 tools/fs129_z2_index.py\n")
        w = csv.writer(f, lineterminator="\n")
        w.writerow(["from", "to", "source", "z2"])
        for row in sorted(res["kept"] + res["added"]):
            w.writerow(row)
    with open(IX / "edges-dropped.csv", "w", encoding="utf-8", newline="") as f:
        f.write("# the edges of edges.csv that FS129-Z2 dropped: class false or reversed, with the reader whose sort it is | command: python3 tools/fs129_z2_index.py\n")
        w = csv.writer(f, lineterminator="\n")
        w.writerow(["from", "to", "source", "class", "sorted_by"])
        for row in sorted(res["dropped"]):
            w.writerow(row)
    # hubs
    hub = sorted(recs, key=lambda i: (-nd[i], -len(adj.get(i, ())), i))
    old_rank = {}
    for ln in open(IX / "hubs.md", encoding="utf-8"):
        m = re.match(r"\| (\d+) \| (\S+) \|", ln)
        if m:
            old_rank[m.group(2)] = int(m.group(1))
    with open(IX / "hubs-corrected.md", "w", encoding="utf-8") as f:
        f.write(hdr("results by count of dependents, top 100, on edges-corrected.csv (route edges counted)") + "# Hubs (corrected)\n\n")
        f.write("| rank | id | direct | transitive | was (hubs.md) | address | era |\n|---|---|---|---|---|---|---|\n")
        for k, i in enumerate(hub[:100], 1):
            r = recs[i]
            f.write(f"| {k} | {i} | {len(adj.get(i, ()))} | {nd[i]} | {old_rank.get(i, '—')} ({r['n_dependents_transitive']}) | {r['file']}:{r['line']} | {r['era']} |\n")
    # roots
    rk = sorted(recs, key=lambda i: (-depth["down"][i], -nd[i], i))
    old_r = {}
    for ln in open(IX / "roots.md", encoding="utf-8"):
        m = re.match(r"\| (\d+) \| (\S+) \| (\d+) \|", ln)
        if m:
            old_r[m.group(2)] = (int(m.group(1)), int(m.group(3)))
    with open(IX / "roots-corrected.md", "w", encoding="utf-8") as f:
        f.write(hdr("roots: results where a long chain of dependents starts, top 100 by depth_down, on edges-corrected.csv") + "# Roots (corrected)\n\n")
        f.write("Definitions as `roots.md` (longest chain of dependents, each cycle condensed; ties by transitive dependents, then id; every depth a lower "
                "bound for older-format results). `was` gives the rank and depth in `roots.md`.\n\n")
        f.write("| rank | id | depth_down | direct | transitive | depth_up | was (roots.md) | address | era |\n|---|---|---|---|---|---|---|---|---|\n")
        for k, i in enumerate(rk[:100], 1):
            r = recs[i]
            was = f"{old_r[i][0]} ({old_r[i][1]})" if i in old_r else "—"
            f.write(f"| {k} | {i} | {depth['down'][i]} | {len(adj.get(i, ()))} | {nd[i]} | {depth['up'][i]} | {was} | {r['file']}:{r['line']} | {r['era']} |\n")
        gone = sorted((v[0], i) for i, v in old_r.items() if i not in set(rk[:100]))
        f.write(f"\nLeft the top 100 ({len(gone)}): " + ", ".join(f"{i} (was {n})" for n, i in gone) + "\n\n## Chains\n\n")
        for k, i in enumerate(rk[:100], 1):
            f.write(f"{k}. {i} ({depth['down'][i]}): " + " → ".join(fx.chain_down(depth, i)) + "\n")
    # cycles
    old_c = [ln.strip() for ln in open(IX / "cycles.md", encoding="utf-8") if ln.startswith("- ")]
    with open(IX / "cycles-corrected.md", "w", encoding="utf-8") as f:
        f.write(hdr("dependency cycles (strongly connected components of size > 1) on edges-corrected.csv") + "# Cycles (corrected)\n\n")
        f.write(f"{len(g['cycles'])} components, {sum(len(c) for c in g['cycles'])} members (cycles.md: {len(old_c)} components). "
                f"With the readers' sorts alone (no added edges): {len(g_sorts['cycles'])}.\n\n")
        for c in g["cycles"]:
            f.write(f"- {len(c)} members: {', '.join(c)}\n")
    # lean order
    old_lo = {}
    for ln in open(IX / "lean-order.md", encoding="utf-8"):
        m = re.match(r"\| (\d+) \| (\S+) \|", ln)
        if m:
            old_lo[m.group(2)] = int(m.group(1))
    with open(IX / "lean-order-corrected.md", "w", encoding="utf-8") as f:
        f.write(hdr("the results whose handoff names de Bruijn (SEED) and everything they rest on, each after what it uses, on edges-corrected.csv") + "# Lean order (corrected)\n\n")
        f.write(f"Seeds: {len(lo['seeds'])} (as `lean-order.md`). Closure: {len(lo['closure'])} entries on every kept edge; {len(lo_first['closure'])} on first routes "
                f"(route edges left out); the readers' sorts alone give {len(lo_sorts['closure'])}; `lean-order.md` had {len(old_lo)}. `role` adds ROUTE-ONLY where the "
                "entry is in the closure only through a route edge. Order: dependencies first, ties by id, a cycle's members together and flagged CYCLE. "
                "Errata the index cannot see (FS-129 item 116) and the FS129-SR1 § 6.2 list of statements that do not formalize as stated are FS129-L1's to apply.\n\n")
        f.write("| # | id | role | was | address | era | needs | kernel / handoff |\n|---|---|---|---|---|---|---|---|\n")
        for k, (i, cyc) in enumerate(lo["sequence"], 1):
            r = recs[i]
            needs = sorted(y for y in radj.get(i, ()) if y in lo["closure"])
            role = ("SEED" if i in lo["seeds"] else "upstream") + (" (conditional: handoff begins `none`)" if i in lo["seeds"] and re.match(r"none\b", r["handoff"], re.I) else "") \
                + (" CYCLE" if cyc else "") + ("" if i in lo_first["closure"] else " ROUTE-ONLY")
            tail = fx.trunc(r["handoff"] or r["kernel"], 120).replace("|", "\\|")
            f.write(f"| {k} | {i} | {role} | {old_lo.get(i, '—')} | {r['file']}:{r['line']} | {r['era']} | {', '.join(needs)} | {tail} |\n")
        left = sorted((n, i) for i, n in old_lo.items() if i not in lo["closure"])
        new = sorted(i for i in lo["closure"] if i not in old_lo)
        f.write(f"\nLeft the Lean order ({len(left)}; leaving means no seed rests on it, not that it has no value — FS-129 item 118): "
                + ", ".join(f"{i} (was {n})" for n, i in left) + "\n\n")
        f.write(f"Joined it ({len(new)}): " + (", ".join(new) or "none") + "\n")
    # vacuity
    nk = sorted((i for i in recs if recs[i]["model_flag"] == "none-known"), key=lambda i: (-nd[i], i))
    with open(IX / "vacuity-corrected.md", "w", encoding="utf-8") as f:
        f.write(hdr("the none-known results of vacuity.md, with their dependents recomputed on edges-corrected.csv") + "# Vacuity (corrected dependents)\n\n")
        f.write("The flag rule and the flags are `vacuity.md`'s, unchanged; only the dependents move. The judged sort of these results "
                "(inhabited / empty / hypothetical by design / no-go) is FS129-SR1's (`plans/FS129-SR1-audit.md` § 6) and FS129-SA1's (§ 5); "
                "only an empty result passes vacuity to its dependents.\n\n")
        f.write("| # | id | transitive (was) | direct (was) | address |\n|---|---|---|---|---|\n")
        for k, i in enumerate(nk, 1):
            r = recs[i]
            f.write(f"| {k} | {i} | {nd[i]} ({r['n_dependents_transitive']}) | {len(adj.get(i, ()))} ({r['n_dependents_direct']}) | {r['file']}:{r['line']} |\n")
        f.write("\n## Dependents, corrected\n\n")
        for i in nk:
            d = sorted(fx.descendants(adj, i))
            f.write(f"- {i}: {', '.join(d) if d else '—'}\n")
    # corrections.md
    with open(IX / "corrections.md", "w", encoding="utf-8") as f:
        f.write(hdr("what FS129-Z2 changed in the index, edge by edge") + "# Index corrections (FS129-Z2)\n\n")
        f.write(f"Summary: {line}\n\n## Dropped ({len(res['dropped'])})\n\n| from | to | source | class | sorted by |\n|---|---|---|---|---|\n")
        for row in sorted(res["dropped"]):
            f.write("| " + " | ".join(row) + " |\n")
        f.write(f"\n## Kept and marked ({sum(1 for *_, c in res['kept'] if c)})\n\n| from | to | source | class |\n|---|---|---|---|\n")
        for row in sorted(r for r in res["kept"] if r[3]):
            f.write("| " + " | ".join(row) + " |\n")
        f.write(f"\n## Added ({len(res['added'])})\n\n| from | to | class | from the text |\n|---|---|---|---|\n")
        why = {(a, b): f"`{c}` in {fld}" for a, b, fld, c in res["range"]}
        why.update({(a, b): f"`{t}` in {w}" for a, b, w, t in res["prefix"]})
        for a, b, s, c in sorted(res["added"]):
            f.write(f"| {a} | {b} | {c} | {why.get((a, b), 'the true direction of ' + b + ' -> ' + a)} |\n")
        f.write(f"\n## Suffix candidates left unresolved ({len(res['prefix_left'])}) — the strict rule did not apply; each is a reader's call\n\n")
        for cands, frm, where, tok, addr in res["prefix_left"]:
            f.write(f"- `{tok}` in {where} of {frm} ({addr}) — candidates: {cands}\n")
        f.write("\n## The no-entry lookup's prefix defect (item 111; `checks.md` § \"Ids that appear in no indexed entry\")\n\n"
                "These 16 of item 20's 68 ids are filed with a milestone prefix and were reported as appearing in no indexed entry; each prefixed id is an "
                "entry (checked by this script):\n\n")
        for k_, v in sorted(PREFIX16.items()):
            f.write(f"- `{k_}` — {v}\n")


if __name__ == "__main__":
    sys.exit(main())
