#!/usr/bin/env python3
"""FS131-KO1 stage 2: the cone of the full port, and its overlap with every name this library already declares.

Reads `data/fs131/ko1/cone/ConeDump.out` (the release's compiled constants, at its pin: `CONE` lines with a mask —
bit 0 the transfer `proper_to_borel_weak`, bit 1 the rigidity lemma `residual_fourier`, bit 2 the headline) and one or
more name listings of this library at its pin (`data/fs131/ko1/lean/names-*.out.xz`, `NamesDump.lean`: one `NAME` line
per compiled constant with its module).  A release constant `OAI.EuclideanFiveColor.X` or `OAI.PlaneFiveColor.X` is
`HadwigerNelson.Outside.OAI158.X` here (the one-namespace map of FS133-IA1); the two anonymous instances of
`Coloring.lean` 19–20 carry the names `Outside/OAI158` and `Outside/OAI158Palette` gave them (ALIAS).

Prints: the cone per target (constants, source declarations, source lines, modules); per release module the cone's
declarations and lines; the module-level dependency order; for each listing, every cone constant whose name here is
already declared, by the module that declares it; and the headline's residual after the port (declarations of the
headline's cone in neither the transfer's cone nor this library).

Usage: fs131_ko1_overlap.py [--control]
--control plants three faults (a cone name added to a listing, a listing's overlap name removed, a cone line dropped)
and requires each to change the report as planted; exit 1 if any does not.
"""
import lzma
import pathlib
import sys
from collections import defaultdict

ROOT = pathlib.Path(__file__).resolve().parent.parent
D = ROOT / "data/fs131/ko1"
CONE = D / "cone/ConeDump.out"
LISTINGS = [("main", D / "lean/names-main.out.xz"), ("fs133-wb1", D / "lean/names-fs133wb1.out.xz")]
ROOTS = ("OAI.EuclideanFiveColor.", "OAI.PlaneFiveColor.")
OURS = "HadwigerNelson.Outside.OAI158."
ALIAS = {"OAI.EuclideanFiveColor.instIsAddHaarMeasureAnglesAngularMeasure":
         OURS + "angularMeasure.instIsAddHaarMeasure",
         "OAI.EuclideanFiveColor.instIsProbabilityMeasureAnglesAngularMeasure":
         OURS + "angularMeasure.instIsProbabilityMeasure"}


def here(n):
    if n in ALIAS:
        return ALIAS[n]
    for p in ROOTS:
        if n.startswith(p):
            return OURS + n[len(p):]
    return None


def read_cone(lines):
    rows = [l.rstrip("\n").split("\t") for l in lines]
    return [r for r in rows if r[0] == "CONE"], [r for r in rows if r[0] == "EDGE"], [r for r in rows if r[0] == "DECL"]


def read_names(lines):
    out = {}
    for l in lines:
        r = l.rstrip("\n").split("\t")
        if r[0] == "NAME":
            out[r[3]] = (r[1], r[2])
    return out


def outermost(rows):
    """(module, first, last, owner, mask) for the outermost source declarations of the given CONE rows."""
    own = {}
    for r in rows:
        k = (r[1], int(r[2]), int(r[3]), r[4])
        own[k] = own.get(k, 0) | int(r[7])
    bym = defaultdict(list)
    for (m, a, b, o), mask in own.items():
        bym[m].append((a, b, o, mask))
    out = []
    for m, l in bym.items():
        l.sort(key=lambda x: (x[0], -x[1]))
        cur = None
        for x in l:
            if cur is not None and x[0] <= cur[1]:
                out[-1] = (m, cur[0], cur[1], cur[2], out[-1][4] | x[3])
                continue
            cur = x
            out.append((m, x[0], x[1], x[2], x[3]))
    return out


def report(cone, edges, decls, listings):
    o = []
    for bit, label in ((1, "transfer"), (2, "rigidity lemma"), (4, "headline")):
        rs = [r for r in cone if int(r[7]) & bit]
        top = [t for t in outermost(rs)]
        o.append(f"CONE {label}: constants={len(rs)} declarations={len(top)} "
                 f"lines={sum(b - a + 1 for _, a, b, _, _ in top)} modules={len({t[0] for t in top})}")
    o.append("SUBSET rigidity-in-transfer=" + str(all(int(r[7]) & 1 for r in cone if int(r[7]) & 2)))
    tr = [r for r in cone if int(r[7]) & 1]
    top = outermost(tr)
    ndecl = defaultdict(int)
    for r in decls:
        ndecl[r[1]] += 1
    per = defaultdict(lambda: [0, 0])
    for m, a, b, _, _ in top:
        per[m][0] += 1
        per[m][1] += b - a + 1
    mod = {r[6]: r[1] for r in tr}
    dep = defaultdict(set)
    for e in edges:
        if e[1] in mod and e[2] in mod and mod[e[1]] != mod[e[2]]:
            dep[mod[e[1]]].add(mod[e[2]])
    depth = {}

    def dd(m):
        if m not in depth:
            depth[m] = 1 + max((dd(x) for x in dep[m]), default=0)
        return depth[m]
    for m in sorted(per, key=lambda m: (dd(m), m)):
        o.append(f"MODULE {dd(m)}\t{m}\t{per[m][0]} of {ndecl[m]} declarations\t{per[m][1]} lines\t<- "
                 + " ".join(sorted(x.rsplit('.', 1)[-1] for x in dep[m])))
    for label, names in listings:
        hits = defaultdict(list)
        for r in tr:
            h = here(r[6])
            if h and h in names:
                hits[names[h][0]].append((r[1].rsplit(".", 1)[-1], names[h][1], r[6], h))
        o.append(f"OVERLAP {label}: {sum(len(v) for v in hits.values())} cone constants already declared here")
        for m in sorted(hits):
            o.append(f"  {m}: {len(hits[m])}")
            for f, kind, rel, h in sorted(hits[m]):
                o.append(f"    {f}\t{kind} here\t{rel}\t-> {h}")
    # the headline's residual: declarations of the headline's cone outside the transfer's cone, not declared here
    allnames = set()
    for _, names in listings[:1]:
        allnames |= set(names)
    priv_here = {n.split(".0.", 1)[1] for n in allnames if n.startswith("_private.") and ".0." in n}
    res = defaultdict(lambda: [0, 0])
    for m, a, b, ow, mask in outermost(cone):
        if not mask & 4 or mask & 1:
            continue
        h = here(ow.split(".0.", 1)[1] if ow.startswith("_private.") else ow)
        if h and (h in allnames or h in priv_here):
            continue
        res[m][0] += 1
        res[m][1] += b - a + 1
    o.append(f"RESIDUAL headline after the port (against {listings[0][0]}): declarations={sum(v[0] for v in res.values())} "
             f"lines={sum(v[1] for v in res.values())} modules={len(res)}")
    for m in sorted(res, key=lambda m: -res[m][1]):
        o.append(f"  {m}\t{res[m][0]}\t{res[m][1]}")
    return o


def load():
    cone, edges, decls = read_cone(CONE.read_text().splitlines())
    listings = [(lab, read_names(lzma.open(p, "rt").read().splitlines())) for lab, p in LISTINGS]
    return cone, edges, decls, listings


def main():
    cone, edges, decls, listings = load()
    base = report(cone, edges, decls, listings)
    if "--control" not in sys.argv:
        print("\n".join(base))
        return 0
    ok = True
    # 1. a cone name planted in the main listing must appear as overlap
    lab, names = listings[0]
    victim = next(r for r in cone if int(r[7]) & 1 and here(r[6]) and here(r[6]) not in names and r[5] == "theorem")
    planted = dict(names)
    planted[here(victim[6])] = ("Proofs.Planted", "theorem")
    o1 = report(cone, edges, decls, [(lab, planted)] + listings[1:])
    f1 = any("Proofs.Planted" in l for l in o1) and o1 != base
    print(f"plant 'a cone name added to {lab}': {'REPORTED' if f1 else 'SILENT'}")
    # 2. an overlap name removed from the density listing must vanish
    lab2, names2 = listings[1]
    gone = here("OAI.PlaneFiveColor.Spectral.residual_fourier")
    assert gone in names2, "the plant needs the axiom in the density listing"
    n2 = {k: v for k, v in names2.items() if k != gone}
    o2 = report(cone, edges, decls, [listings[0], (lab2, n2)])
    f2 = not any(l.endswith("-> " + gone) and "fs133" in "".join(o2) for l in o2) and o2 != base
    print(f"plant 'the axiom removed from {lab2}': {'REPORTED' if f2 else 'SILENT'}")
    # 3. a cone line dropped must change the counts
    c3 = [r for r in cone if r is not victim]
    o3 = report(c3, edges, decls, listings)
    f3 = o3[0] != base[0]
    print(f"plant 'one CONE line dropped': {'REPORTED' if f3 else 'SILENT'}")
    ok = f1 and f2 and f3
    print("CONTROL OK" if ok else "CONTROL FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
