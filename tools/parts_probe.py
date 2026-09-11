#!/usr/bin/env python3
"""The S-half expansion probe: the candidate menu over an accumulative graph, and the `.vtx`
files that feed it back into the committed driver.

**Why this file exists.** `[Parts2020a]`'s loop alternates REDUCTION (which `tools/parts_reduce.py`
does) with EXPANSION (which nothing here does yet). His §6 says the S half was never expanded --
*"Reduction of S-subgraphs is briefly discussed in 5.10. Here we hardly improved the result of
Heule at all; only two edges were removed"* -- so the 136-vertex S half of the 509-vertex record is
the output of ONE rough reduction, and its expansion menu has never been run by anyone. This module
computes that menu and writes its candidates; the reduction itself is `tools/parts_run.py`,
unmodified and unimported-from except read-only.

**The admission rule, read from his own sentence** (§5.6, `parts:517-521`):

    "A base orbit is included in the graph R if, when added to the graph A, the degree of some of
     its vertices is at least 4."

"when added to the graph A" makes the degree a degree in `A u orbit`, so an added orbit's own
internal edges count; "the degree of SOME OF ITS VERTICES" makes the max over the added vertices.
That is `deg_plus` below. A stricter reading -- edges into `A` only -- is `deg_into`, and is what an
independent measurement of this menu used. On the S side there is a third reading, because an
S vertex also carries `rho15` cross edges to the frozen L companion: `deg_cross`. The three are
ordered `deg_into <= deg_plus <= deg_all`, and THE MENU IS THEIR UNION, because the filter is a
heuristic and a wrongly-excluded orbit is the one failure mode a later measurement cannot detect.

**Candidates are orbit fills, not orbit adds.** A candidate is "make base orbit `o` complete in
`A`": it contributes only `o`'s ABSENT members, so a partially filled orbit costs fewer new
vertices than its size. That is one uniform family covering both of his devices -- *"filling in the
partially occupied base orbits of graph A and (or) adding new vertices from reserve graph R"*.

Nothing here searches and nothing here is trusted: every number is re-derivable, the emitted files
are re-parsed by his own parser before they are used, and the reduction that consumes them is the
committed one.
"""
from __future__ import annotations
import argparse, os, sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_repro as P
import parts_vtx as V
import typem as T

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# ====================================================================== the base, with its edges
class ProbeBase:
    """`parts_repro.Base` plus the two edge relations a menu needs, built once.

    `unit` is the internal unit-distance relation on the lattice (the same relation both halves of
    a type-M graph carry, since `rho15` is an isometry); `cross_from_S` maps an S-side lattice
    tuple to the L-side tuples it is joined to by the cross-edge law."""

    def __init__(self, r=P.PARTS_R):
        self.base = P.Base(r)
        self.tups = self.base.tups
        E, _ = T.unit_edges_fast(self.base.pts)
        self.n_unit = len(E)
        adj = defaultdict(set)
        for i, j in E:
            adj[self.tups[i]].add(self.tups[j])
            adj[self.tups[j]].add(self.tups[i])
        self.unit = adj
        X = T.cross_edges_rho15_fast(self.base.pts)
        cr = defaultdict(set)
        for i, j in X:                       # i on the L side, j on the S side
            cr[self.tups[j]].add(self.tups[i])
        self.cross_from_S = cr

    def edges_within(self, tuples):
        """The number of internal unit edges of a vertex set -- his filename's `e` number."""
        S = set(tuples)
        return sum(len(self.unit[t] & S) for t in S) // 2


# ====================================================================== the menu
def menu(pb: ProbeBase, A_tuples, companion=None, threshold=4):
    """One row per base orbit with at least one absent vertex, with all three degree readings.

    `admitted` is the union rule: the row passes when ANY reading reaches `threshold`."""
    A = set(A_tuples)
    comp = set(companion or ())
    rows = []
    for oi, orbit in enumerate(pb.base.orbits):
        members = [pb.tups[i] for i in orbit]
        absent = [t for t in members if t not in A]
        if not absent:
            continue
        absent_set = set(absent)
        into = max(len(pb.unit[t] & A) for t in absent)
        plus = max(len(pb.unit[t] & (A | absent_set)) for t in absent)
        allr = max(len(pb.unit[t] & (A | absent_set)) + len(pb.cross_from_S[t] & comp)
                   for t in absent) if comp else plus
        rows.append({
            "label": tuple(pb.base.label[oi]),
            "size": len(members),
            "present": len(members) - len(absent),
            "absent": len(absent),
            "radii": [round(v, 4) for v in pb.base.radii[oi]],
            "deg_into": into, "deg_plus": plus, "deg_all": allr,
            "admitted": max(into, plus, allr) >= threshold,
            "admitted_by": [n for n, v in (("into", into), ("plus", plus), ("all", allr))
                            if v >= threshold],
        })
    # his order: decreasing vertex degree; then his stated priority for partially filled orbits
    # and for small orbits; then the label, so the listing is stable run to run.
    rows.sort(key=lambda r: (-max(r["deg_into"], r["deg_plus"], r["deg_all"]),
                             r["absent"], r["size"], r["label"]))
    return rows


def render(rows, only_admitted=True):
    out = [f"{'label':>18}  {'size':>4} {'pres':>4} {'abs':>4}  "
           f"{'into':>4} {'plus':>4} {'all':>4}  {'radii':>16}  by"]
    for r in rows:
        if only_admitted and not r["admitted"]:
            continue
        out.append(f"{str(r['label']):>18}  {r['size']:>4} {r['present']:>4} {r['absent']:>4}  "
                   f"{r['deg_into']:>4} {r['deg_plus']:>4} {r['deg_all']:>4}  "
                   f"{str(r['radii']):>16}  {','.join(r['admitted_by'])}")
    return "\n".join(out)


# ====================================================================== emitting his format
def vtx_line(t):
    """His own coordinates: x = (a + b*Sqrt[33])/12, y = (c*Sqrt[3] + d*Sqrt[11])/12."""
    a, b, c, d = t
    return "{(%d + %d*Sqrt[33])/12, (%d*Sqrt[3] + %d*Sqrt[11])/12}" % (a, b, c, d)


def emit_vtx(path, tuples):
    """Write a vertex list in his format, then RE-PARSE IT WITH HIS PARSER and compare as sets.

    An emitter that is never read back is a silent corruption channel; this one cannot be, because
    the file that goes to the reduction is the file that was checked."""
    tmp = path + ".tmp"
    with open(tmp, "w") as f:
        for t in tuples:
            f.write(vtx_line(t) + "\n")
    back = V.load_lattice(tmp)
    if sorted(back) != sorted(tuples) or len(back) != len(tuples):
        os.remove(tmp)
        raise AssertionError(f"{path}: round trip changed the vertex set "
                             f"({len(back)} parsed of {len(tuples)} written)")
    os.replace(tmp, path)
    return len(back)


def expanded(pb: ProbeBase, A_tuples, label):
    """`A` with base orbit `label` filled: the union, and the absent members it added."""
    oi = pb.base.by_label[tuple(label)]
    members = [pb.tups[i] for i in pb.base.orbits[oi]]
    A = set(A_tuples)
    added = [t for t in members if t not in A]
    return sorted(A | set(added)), added


# ====================================================================== CLI
def load(name):
    p = name if os.path.sep in name else os.path.join(V.REF11, name)
    if not p.endswith(".vtx"):
        p += ".vtx"
    return V.load_lattice(p)


def cmd_menu(args):
    pb = ProbeBase()
    A = load(args.A)
    comp = load(args.companion) if args.companion else None
    rows = menu(pb, A, comp, threshold=args.threshold)
    adm = [r for r in rows if r["admitted"]]
    print(f"base r={P.PARTS_R}: {len(pb.base.pts)} points, {len(pb.base.orbits)} orbits, "
          f"{pb.n_unit} unit edges")
    print(f"A = {os.path.basename(args.A)}: {len(A)} vertices, {pb.edges_within(A)} internal unit "
          f"edges" + (f"; companion {os.path.basename(args.companion)}: {len(comp)} vertices"
                      if comp else ""))
    print(f"orbits with an absent vertex: {len(rows)}; admitted at threshold {args.threshold}: "
          f"{len(adm)}  (union of the three readings)")
    print(render(rows, only_admitted=not args.all))
    if args.json:
        import json
        with open(args.json, "w") as f:
            json.dump({"kind": "m63-probe-menu", "A": os.path.basename(args.A),
                       "companion": os.path.basename(args.companion) if args.companion else None,
                       "threshold": args.threshold, "base_r": P.PARTS_R,
                       "rows": [{**r, "label": list(r["label"])} for r in rows]}, f, indent=1)
        print(f"wrote {args.json}")


def cmd_emit(args):
    pb = ProbeBase()
    A = load(args.A)
    lab = tuple(int(v) for v in args.orbit.split(","))
    pts, added = expanded(pb, A, lab)
    n = emit_vtx(args.out, pts)
    print(f"{os.path.basename(args.out)}: {n} vertices = {len(A)} + {len(added)} added from orbit "
          f"{lab}; {pb.edges_within(pts)} internal unit edges (round trip checked)")


def cmd_emit_menu(args):
    """The menu and every one of its candidates, on ONE base build.

    Twelve separate `emit` calls would rebuild the 4,513-point base twelve times; the menu is the
    thing that decides which candidates exist, so it and they belong in one pass."""
    import json
    pb = ProbeBase()
    A = load(args.A)
    comp = load(args.companion) if args.companion else None
    rows = menu(pb, A, comp, threshold=args.threshold)
    adm = [r for r in rows if r["admitted"]]
    print(f"base r={P.PARTS_R}: {len(pb.base.pts)} points, {len(pb.base.orbits)} orbits, "
          f"{pb.n_unit} unit edges")
    print(f"A = {os.path.basename(args.A)}: {len(A)} vertices, {pb.edges_within(A)} internal unit "
          f"edges" + (f"; companion {os.path.basename(args.companion)}: {len(comp)} vertices, "
                      f"{pb.edges_within(comp)} internal unit edges" if comp else ""))
    print(f"orbits with an absent vertex: {len(rows)}; admitted at threshold {args.threshold}: "
          f"{len(adm)} (union) / {sum(1 for r in rows if r['deg_into'] >= args.threshold)} "
          f"(into-A only)\n")
    print(render(rows, only_admitted=not args.all))
    os.makedirs(args.outdir, exist_ok=True)
    print()
    for r in adm:
        a, b, c, d = r["label"]
        out = os.path.join(args.outdir, f"{args.prefix}-o{a}_{b}_{c}_{d}.vtx")
        pts, added = expanded(pb, A, r["label"])
        n = emit_vtx(out, pts)
        r["file"] = os.path.relpath(out, ROOT)
        r["n_vertices"] = n
        r["n_edges_internal"] = pb.edges_within(pts)
        r["n_added"] = len(added)
        print(f"  {os.path.basename(out):>34}  {n} vertices ({len(A)} + {len(added)}), "
              f"{r['n_edges_internal']} internal unit edges")
    if args.json:
        with open(args.json, "w") as f:
            json.dump({"kind": "m63-probe-menu", "A": os.path.basename(args.A),
                       "companion": os.path.basename(args.companion) if args.companion else None,
                       "threshold": args.threshold, "base_r": P.PARTS_R,
                       "base": {"points": len(pb.base.pts), "orbits": len(pb.base.orbits),
                                "unit_edges": pb.n_unit},
                       "rows": [{**r, "label": list(r["label"])} for r in rows]}, f, indent=1)
        print(f"\nwrote {args.json}")


def cmd_control(args):
    """The stage control, before any reduction: the record's own selection, in the expanded stage.

    **Why it is free and why it is decisive.** Colourability of a selection depends on the
    selection and the frozen companion ALONE, never on the rest of the working graph, so the
    record's own S selection must refuse four colours in every expanded stage, and -- being a
    MINIMUM-cardinality refusing selection -- every one of its single-vertex deletions must be
    four-colourable. Both answers are therefore invariant across all fourteen candidates. A stage
    that fails either is not built over his object, and a stage whose answer CHANGES between
    candidates is an instrument fault, not geometry: the sweep halts.

    `v136e564` is not a subset of `v166e774` as stored (M63 §1(iv): six vertices outside), so the
    control uses a group image of the record's S half that the accumulator contains -- six of the
    twenty-four elements supply one.

    **THE IMAGE IS PINNED BY THE BASELINE ACCUMULATOR, NEVER BY THE EXPANDED ONE**, and the first
    version of this control was wrong about exactly that. An expansion makes `A` larger, so MORE
    images fit inside it -- twelve of twenty-four at `(12,2,2,0)` against six at `A166` -- and
    choosing "the image inside `A` with the smallest name" therefore chooses a DIFFERENT image for
    some candidates. Applying a group element to the S half alone, with the companion left where it
    was, is a different problem (`parts_run` §O4), so the new image does not refuse and the control
    fails for a reason that has nothing to do with the candidate. Pinning the image to the one the
    baseline `v166e774` contains is what makes the control's answer the SAME QUESTION every run,
    which is the only thing that lets a change in it mean an instrument fault.

    A second lesson from the same failure: the single-deletion check is VACUOUS unless the refusal
    check passes, because every subset of a four-colourable selection is four-colourable. It is
    reported as conditional, and a run where the refusal fails is a failure whatever it says."""
    import parts_run as PR
    import parts_stage as PS
    A = load(args.A)
    L = load(args.L)
    ref = load(args.ref)
    base = P.Base(P.PARTS_R)
    G = PR.Group(base)
    Aset = set(A)
    pin_src = set(load(args.frame_from))
    imgs = sorted((G.names[i], i) for i in range(len(G)) if G.image(i, ref) <= pin_src)
    if not imgs:
        raise SystemExit(f"no group image of {os.path.basename(args.ref)} lies inside "
                         f"{os.path.basename(args.frame_from)}: the control cannot be set up, and "
                         f"a stage that does not contain the record's own selection is not over "
                         f"his object")
    name, gi = imgs[0]
    sel = sorted(G.image(gi, ref))
    if not set(sel) <= Aset:
        raise SystemExit(f"the image pinned by {os.path.basename(args.frame_from)} is not inside "
                         f"{os.path.basename(args.A)}, which cannot happen for an expansion of it")
    stage = PS.Stage(base, L, A, side="S", rung=1, pin=True)
    n = stage.A.n
    nv = stage.present.bit_count()
    ne = len(stage.A.induced(stage.present))
    want_v = len(L) + len(Aset - {(0, 0, 0, 0)}) if (0, 0, 0, 0) in Aset else len(L) + len(A)
    print(stage.describe())
    inside_A = sum(1 for i in range(len(G)) if G.image(i, ref) <= Aset)
    print(f"  images of {os.path.basename(args.ref)} inside "
          f"{os.path.basename(args.frame_from)}: {len(imgs)} of {len(G)} (inside this A: "
          f"{inside_A}); pinned to the one named {name}")
    ok = [nv == want_v]
    print(f"  {'ok  ' if ok[-1] else 'FAIL'} stage vertex count {nv} == {len(L)} + "
          f"{nv - len(L)} (L + S without the shared centre); {ne} edges")
    ix = {(h, tuple(t)): a for a, (h, t) in
          enumerate((l[0], tuple(l[1])) for l in stage.atom_labels)}
    kept = sorted(ix[("S", t)] for t in sel if t != (0, 0, 0, 0))
    ok.append(len(kept) == len(sel) - 1)
    print(f"  {'ok  ' if ok[-1] else 'FAIL'} the selection maps to {len(kept)} atoms "
          f"(of {len(sel)} vertices, the shared centre excluded)")
    from pysat.solvers import Solver
    cls, s_, _, _ = stage.cnf()
    solver = Solver(name="cadical153", bootstrap_with=cls)
    stage._sel = s_
    v = PS.refuses(stage, kept, solver=solver)
    ok.append(v == "unsat")
    print(f"  {'ok  ' if ok[-1] else 'FAIL'} the record's own selection refuses four colours: {v}")
    bad = []
    sample = kept if args.sample <= 0 else kept[:args.sample]
    for a in sample:
        if PS.refuses(stage, [x for x in kept if x != a], solver=solver) != "sat":
            bad.append(a)
    solver.delete()
    ok.append(not bad)
    print(f"  {'ok  ' if ok[-1] else 'FAIL'} every single-vertex deletion of it is four-colourable "
          f"({len(sample)} checked{', ' + str(len(bad)) + ' REFUSED' if bad else ''})"
          f"{'' if v == 'unsat' else '  [VACUOUS: the selection itself is colourable]'}")
    print(f"\n{'ALL CONTROLS FIRED' if all(ok) else 'FAILED -- the sweep halts'}")
    sys.exit(0 if all(ok) else 1)


def _self_test():
    """Controls, each against something we did not choose:

    c1 his filenames' edge counts are our internal unit-edge counts, on three of his files;
    c2 every vertex of his S files lies in the base and in an orbit meeting the radius-2 disk;
    c3 the emitter round-trips through HIS parser;
    c4 the three degree readings are ordered, and the strict reading admits no more than the union;
    c5 filling an orbit already complete in `A` is not a candidate (the menu skips it);
    c6 a vertex set off his lattice is REFUSED by the parser rather than rounded onto it."""
    import tempfile
    fails = []

    def chk(name, cond, detail=""):
        print(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    pb = ProbeBase()
    print(f"base r={P.PARTS_R}: {len(pb.base.pts)} points, {len(pb.base.orbits)} orbits, "
          f"{pb.n_unit} unit edges")
    for f in ("v166e774", "v136e564", "v374e1860"):
        pts = load(f)
        nv, ne = V.expect(f + ".vtx")
        chk(f"{f}: our edge count is his filename's", len(pts) == nv
            and pb.edges_within(pts) == ne, f"{len(pts)} vertices, {pb.edges_within(pts)} edges")

    meet = P.orbits_meeting_disk(pb.base, 2.0)
    for f in ("v166e774", "v136e564"):
        pts = load(f)
        out = [t for t in pts if pb.base.label[pb.base.of[t]] not in meet]
        chk(f"{f} lies in orbits meeting the radius-2 disk", not out, f"{len(out)} outside")

    A = load("v166e774")
    with tempfile.TemporaryDirectory() as d:
        p = os.path.join(d, "rt.vtx")
        emit_vtx(p, A)
        chk("the emitter round-trips through his parser", sorted(V.load_lattice(p)) == sorted(A))
        with open(p, "w") as f:                       # a point off the denominator-12 lattice
            f.write("{(1 + 1*Sqrt[33])/7, (0*Sqrt[3] + 0*Sqrt[11])/12}\n")
        try:
            V.load_lattice(p)
            chk("an off-lattice point is refused", False, "it parsed")
        except ValueError as e:
            chk("an off-lattice point is refused", "not on the denominator-12 lattice" in str(e))

    rows = menu(pb, A, load("v374e1860"))
    chk("the three degree readings are ordered into <= plus <= all",
        all(r["deg_into"] <= r["deg_plus"] <= r["deg_all"] for r in rows))
    strict = {r["label"] for r in rows if r["deg_into"] >= 4}
    union = {r["label"] for r in rows if r["admitted"]}
    chk("the strict reading is inside the union", strict <= union,
        f"strict {len(strict)}, union {len(union)}")
    full = {tuple(pb.base.label[pb.base.of[t]]) for t in A}
    complete = {l for l in full
                if all(pb.tups[i] in set(A) for i in pb.base.orbits[pb.base.by_label[l]])}
    chk("no already-complete orbit is a candidate", not (complete & {r["label"] for r in rows}),
        f"{len(complete)} complete orbits in A")

    print(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    m = sub.add_parser("menu")
    m.add_argument("--A", required=True)
    m.add_argument("--companion")
    m.add_argument("--threshold", type=int, default=4)
    m.add_argument("--all", action="store_true", help="list every orbit, not only the admitted")
    m.add_argument("--json")
    m.set_defaults(f=cmd_menu)
    e = sub.add_parser("emit")
    e.add_argument("--A", required=True)
    e.add_argument("--orbit", required=True, help="a,b,c,d")
    e.add_argument("--out", required=True)
    e.set_defaults(f=cmd_emit)
    em = sub.add_parser("emit-menu")
    em.add_argument("--A", required=True)
    em.add_argument("--companion")
    em.add_argument("--threshold", type=int, default=4)
    em.add_argument("--outdir", required=True)
    em.add_argument("--prefix", default="m63-probe-S166")
    em.add_argument("--all", action="store_true")
    em.add_argument("--json")
    em.set_defaults(f=cmd_emit_menu)
    c = sub.add_parser("control")
    c.add_argument("--L", required=True)
    c.add_argument("--A", required=True, help="the S side: an accumulator, expanded or not")
    c.add_argument("--ref", default="v136e564.vtx", help="the record's own S half")
    c.add_argument("--frame-from", dest="frame_from", default="v166e774.vtx",
                   help="the accumulator that PINS which group image of --ref is used; the "
                        "baseline, never the expanded one, or the control changes its own question")
    c.add_argument("--sample", type=int, default=0, help="0 = every single-vertex deletion")
    c.set_defaults(f=cmd_control)
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if _self_test() else 1)
    if not getattr(a, "f", None):
        ap.error("give a subcommand or --self-test")
    a.f(a)


if __name__ == "__main__":
    main()
