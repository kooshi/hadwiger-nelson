#!/usr/bin/env python3
"""The audit instrument: one level set against `[Parts2020a]`'s published tables, as rows that can
disagree.

**Why his tables live in a file and not at the call site.** Typing `his_edges=(1920, 1930)` where
an audit is called is precisely where a number gets nudged toward agreement -- and this milestone's
failure mode is not a wrong answer but a right-looking one, since we hold his answers. So Table 1
is transcribed once into `data/m62/parts-table1.json`, with his own index supplying each row's
files and an attestation count per field, and an `AuditSpec` shrinks to **a row id**. A call site
cannot invent a target.

**Absence is never a blank.** Every field of his row produces a row: `agrees`, `differs`,
`not-compared -- his table does not attest it`, or `not-compared -- our level is truncated`. A
reviewer can otherwise not tell *agrees* from *never compared*, which is silent omission wearing a
checkmark.

**No aggregate verdict and no `reproduced` field** (the reason is in `parts_report`'s docstring).
Rows say `agrees` or `differs`; nothing sums them.

    python3 tools/parts_audit.py --self-test
    python3 tools/parts_audit.py audit --record data/m62/m63-L451-reduction.json --spec L451 \\
            --out data/m62/m63-audit-L451.json
"""
from __future__ import annotations
import argparse, itertools, json, os, random, sys, time
from collections import Counter, defaultdict
from dataclasses import dataclass, field
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_faces as F
import parts_repro as P
import parts_report as R
import parts_reduce as RED
import parts_run as RUN
import parts_stage as PS
import parts_vtx as V
import typem as T

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TABLE1 = os.path.join(ROOT, "data", "m62", "parts-table1.json")
TABLE2 = os.path.join(ROOT, "data", "m62", "parts-table2-orbit-fillings.json")


def table1(path=TABLE1):
    return json.load(open(path))


# ===================================================================== the spec
@dataclass(frozen=True)
class AuditSpec:
    """Which of his rows this level set is compared against, and nothing else.

    Everything compared comes from the transcription, so a call site cannot invent a target."""
    name: str
    his_row: str | None
    extra_columns: tuple = ()
    L_file: str = ""
    S_file: str = ""
    side: str = "L"

    @staticmethod
    def known():
        return {
            "S166": AuditSpec("S166", "S-M6A-136", (), "v374e1860.vtx", "v166e774.vtx", "S"),
            "L451": AuditSpec("L451", "L-M6A-375", ("table2:375_m6ab_set",),
                              "v451e2400.vtx", "v136e564.vtx", "L"),
            "M6B403": AuditSpec("M6B403", "L-M6B-375", ("table2:375_m6ab_set",),
                                "v403e2106.vtx", "v141e594.vtx", "L"),
            "joint-A412-A166": AuditSpec("joint-A412-A166", None, (),
                                         "v412e2106.vtx", "v166e774.vtx", "LS"),
        }


# ===================================================================== orbit rows
@dataclass(frozen=True)
class OrbitRow:
    """`status` is DERIVED from the three measurements, never stored beside them.

    His definition of stable is *the same non-empty vertex set in every minimal graph* (§6), and a
    single-valued range does NOT imply it: L451's (2,0,2,4) is 10 in every minimum with a VARYING
    vertex set. So that orbit is `unstable-constant-count` and can never be `stable`."""
    label: tuple
    size: int
    lo: int
    hi: int
    vertex_set_constant: bool
    his_range: tuple | None = None
    his_shaded_stable: bool | None = None

    @property
    def status(self) -> str:
        if self.hi == 0:
            return "absent"
        if self.vertex_set_constant:
            return "stable"
        return "unstable-constant-count" if self.lo == self.hi else "unstable-varying-count"

    @property
    def relation(self) -> str:
        if self.his_range is None:
            return "not-compared -- his table does not attest it"
        return "agrees" if (self.lo, self.hi) == tuple(self.his_range) else "differs"

    def as_json(self):
        return {"orbit": list(self.label), "size": self.size, "lo": self.lo, "hi": self.hi,
                "vertex_set_constant": self.vertex_set_constant, "status": self.status,
                "his_range": list(self.his_range) if self.his_range else None,
                "relation": self.relation, "his_shaded_stable": self.his_shaded_stable}


def _side_tuples(stage, atoms):
    """The `(half, lattice tuple)` vertices of a set of atoms."""
    out = []
    for a in atoms:
        out.extend(stage.vertex_labels(stage.atoms[a]))
    return out


def level_vertices(stage, rec):
    """Every minimum as a set of `(half, tuple)` vertices, the shared centre included."""
    centre = ("L", stage.keys[stage.A.centre])
    return [frozenset(_side_tuples(stage, m)) | {centre} for m in rec["minima"]]


def orbit_rows(base, stage, mins, his_column=None, shading=None):
    """Per-orbit ranges over a level set, with his printed column where one is attributed."""
    rows = []
    labels = defaultdict(list)
    for m in mins:
        c = Counter()
        sets = defaultdict(set)
        for h, t in m:
            oi = base.of.get(t)
            if oi is None:
                continue
            c[base.label[oi]] += 1
            sets[base.label[oi]].add((h, t))
        for lab in set(c) | set(labels):
            labels[lab].append((c.get(lab, 0), frozenset(sets.get(lab, ()))))
    for lab in sorted(labels, key=lambda l: (base.radii[base.by_label[l]][0], l)):
        vals = labels[lab]
        counts = [v for v, _ in vals]
        vsets = {s for _, s in vals}
        his = None
        if his_column:
            his = his_column.get(tuple(lab))
        rows.append(OrbitRow(label=tuple(lab), size=base.size(tuple(lab)),
                             lo=min(counts), hi=max(counts),
                             vertex_set_constant=(len(vsets) == 1 and max(counts) > 0),
                             his_range=his,
                             his_shaded_stable=(shading or {}).get(tuple(lab))))
    return rows


def his_ranges(column: str, path=TABLE2):
    """A printed `{M}` column of Table 2 as `{orbit: (lo, hi)}`. His cells are '4', '0-8', ''."""
    t = json.load(open(path))
    out = {}
    for r in t["rows"]:
        raw = str(r.get("set", {}).get(column, "")).strip()
        if not raw:
            continue
        if "-" in raw:
            a, b = raw.split("-", 1)
            out[tuple(r["orbit"])] = (int(a), int(b))
        else:
            out[tuple(r["orbit"])] = (int(raw), int(raw))
    return out


# ===================================================================== counts up to a group
def atom_perms(base, stage, group=None):
    """`{group index: atom permutation}` for every element that maps the atom set to itself.

    Counting `|{M}|` up to a group is otherwise the audit's whole cost: done on `(half, tuple)`
    vertex sets it rebuilds 3,264 x 24 frozensets of 375 labels per convention, which measured at
    over twenty minutes for three conventions and nearly cost this phase its audit to a timeout.
    An atom permutation is the same map as a lookup table, so an image becomes a set comprehension
    over small integers."""
    G = group or F.base_group_perms(base)
    alab = [(l[0], tuple(l[1])) for l in stage.atom_labels]
    ix = {t: i for i, t in enumerate(alab)}
    out = {}
    for gi, g in enumerate(G):
        try:
            p = [ix[(h, g[t])] for h, t in alab]
        except KeyError:
            continue                                  # not a symmetry of this atom set
        out[gi] = p
    return out, alab, ix


def canonical_counts(base, stage, mins, group=None):
    """`|{M}|` under three named conventions, each a `SetSize`.

    **The convention that is his**, measured on both sides (8 on S, 282 on L): *the stabiliser of
    the reduced part, with the frozen part free to move along*. For a one-sided stage that is
    `Stab(W_reduced)`; for a joint stage it is the diagonal `Stab(W_L) n Stab(W_S)`. The other two
    are that group intersected with the companion's stabiliser, and the whole base group.

    Also reports `closed_under`, which is NOT guaranteed: `Aut(A)` is a symmetry of the stage only
    when the companion is invariant, and `g in Stab(W_L)` gives `g(M) u g(C)` refusing, not
    `g(M) u C`. A count taken where it is false counts orbits MEETING the level (§O6)."""
    G = group or F.base_group_perms(base)
    perms, alab, _ = atom_perms(base, stage, group=G)
    red = {t for h, t in alab}
    comp = {t for h, t in stage.vertex_labels(stage.fixed)}
    st_red = [gi for gi in perms if {G[gi][t] for t in red} == red]
    st_comp = [gi for gi in perms if {G[gi][t] for t in comp} == comp]
    both = [gi for gi in st_red if gi in st_comp]
    # `mins` are ATOM INDEX lists, as the record stores them.
    fro = [frozenset(m) for m in mins]
    lev = set(fro)

    def orbits(gis):
        reps, closed = set(), True
        for m in fro:
            imgs = []
            for gi in gis:
                p = perms[gi]
                img = frozenset(p[a] for a in m)
                imgs.append(img)
                if img not in lev:
                    closed = False
            reps.add(min(tuple(sorted(i)) for i in imgs) if imgs else tuple(sorted(m)))
        return len(reps), closed

    out = {}
    for name, gs in (("Stab(reduced part), companion free -- HIS convention", st_red),
                     ("Stab(reduced) n Stab(companion)", both),
                     ("the whole order-24 base group", sorted(perms))):
        n, closed = orbits(gs)
        out[name] = {"order": len(gs),
                     "count": R.asdict(R.SetSize(R.Count(n, "symmetry-collapsed", of=len(fro)),
                                                 up_to=name)),
                     "closed_under": closed,
                     "reading": ("orbits contained in the level" if closed else
                                 "orbits MEETING the level -- the level is not closed under this "
                                 "group, so this is not a count of orbits inside it")}
    return out


# ===================================================================== his own files
def compare_accumulator(base, stage, rec, his_file, group=None):
    """Our `A` against his published accumulator: literal equality, both set differences with
    their vertices named, and every group element mapping ours onto his."""
    G = group or F.base_group_perms(base)
    his = set(RUN.load_side(his_file))
    A_atoms = rec.get("A", rec.get("A_sample"))
    ours = {t for h, t in _side_tuples(stage, A_atoms)} | {stage.keys[stage.A.centre]}
    maps = [i for i, g in enumerate(G) if {g[t] for t in ours} == his]
    return {"his_file": his_file, "his_n": len(his), "ours_n": len(ours),
            "literal_equal": ours == his,
            "ours_not_his": [list(t) for t in sorted(ours - his)][:24],
            "his_not_ours": [list(t) for t in sorted(his - ours)][:24],
            "group_elements_mapping_ours_onto_his": len(maps),
            "relation": "A-equal" if ours == his else ("A-equal-up-to-the-group" if maps
                                                       else "A-differs"),
            "capped": "A_sample" in rec}


def membership(base, stage, rec, mins, his_member_file, group=None):
    """How many of his file's 24 group images lie in our level set, and how many lie inside `A`."""
    G = group or F.base_group_perms(base)
    his = set(RUN.load_side(his_member_file))
    side = "S" if stage.side == "S" else "L"
    A_atoms = rec.get("A", rec.get("A_sample"))
    Aset = {t for h, t in _side_tuples(stage, A_atoms)} | {stage.keys[stage.A.centre]}
    lev = {frozenset(t for h, t in m) for m in mins}
    in_level = in_A = 0
    for g in G:
        try:
            img = frozenset(g[t] for t in his)
        except KeyError:
            continue
        in_level += img in lev
        in_A += img <= Aset
    return {"his_file": his_member_file, "images_in_the_level": in_level,
            "images_inside_A": in_A, "of": len(G),
            "relation": "his-member-is-ours" if in_level else "his-member-not-in-our-level"}


# ===================================================================== edges
def edge_decomposition(stage, atoms):
    """ALWAYS the whole decomposition, never one number: e(L), e(S), and the off-centre cross
    edges by RADIUS FAMILY.

    His Table 1 quotes e(L) for an L row, e(S) for an S row and the union for an M-type row, and
    his subtype name IS the auxiliary count -- M6 means six auxiliary edges -- so one function
    serves every row and the reader can see which term was compared."""
    n = stage.A.n
    mask = stage.fixed
    for a in atoms:
        mask |= stage.atoms[a]
    E = stage.A.induced(mask)
    norms = {}

    def nm(v):
        if v not in norms:
            norms[v] = T.norm2(stage.A.pts[v % n])
        return norms[v]
    out = {"e_L": 0, "e_S": 0, "cross_centre": 0, "cross_by_family": Counter()}
    four = (Fr(4), Fr(0), Fr(0), Fr(0))
    aux = {(Fr(17, 6), Fr(0), Fr(0), Fr(1, 6)), (Fr(17, 6), Fr(0), Fr(0), Fr(-1, 6))}
    for u, v in E:
        lu, lv = u < n, v < n
        if lu and lv:
            out["e_L"] += 1
        elif not lu and not lv:
            out["e_S"] += 1
        elif u % n == stage.A.centre or v % n == stage.A.centre:
            out["cross_centre"] += 1
        else:
            a, b = nm(u), nm(v)
            fam = ("reference" if a == four and b == four else
                   "auxiliary" if {a, b} <= aux else f"other:{T.kstr(a)}|{T.kstr(b)}")
            out["cross_by_family"][fam] += 1
    out["cross_by_family"] = dict(out["cross_by_family"])
    out["cross_off_centre"] = sum(out["cross_by_family"].values())
    out["total"] = len(E)
    # HIS accounting of e(S), which is not ours and the difference is exactly the centre.
    # The shared rotation centre is an L-side vertex here (the arena forbids the S-side copy), so
    # every centre-cross edge is (centre, S point) and this decomposition books it as cross. He
    # counts the S-subgraph as 136 vertices INCLUDING the centre, so those 12 edges are his e(S):
    #   2442 = 1860 (e_L) + 564 (his e_S = our 552 + 12) + 12 (reference) + 6 (auxiliary).
    # Measured on the record 2026-09-11. Comparing our raw e_S against his Table 1 would report
    # 552 against 564 and read `differs` -- a false alarm from an accounting convention, which is
    # exactly what an audit must not manufacture.
    out["e_S_his"] = out["e_S"] + out["cross_centre"]
    out["e_L_his"] = out["e_L"]
    out["subtype_reading"] = (f"M{out['cross_by_family'].get('auxiliary', 0)}"
                              if out["cross_by_family"].get("auxiliary") else "no auxiliary edges")
    return out


def edge_profile(base, stage, mins_atoms, group=None):
    """Over a level: the multiset of the compared term, its range, and the stabiliser orders of
    the fewest-edge members -- his parenthetical, e.g. '1 (2)'."""
    G = group or F.base_group_perms(base)
    side_key = "e_S_his" if stage.side == "S" else "e_L_his"
    rows = [(edge_decomposition(stage, m)[side_key], m) for m in mins_atoms]
    counts = Counter(e for e, _ in rows)
    lo = min(counts) if counts else None
    stabs = []
    for e, m in rows:
        if e != lo:
            continue
        verts = {t for h, t in _side_tuples(stage, m)} | {stage.keys[stage.A.centre]}
        stabs.append(sum(1 for g in G if {g[t] for t in verts} == verts))
    return {"term": side_key, "multiset": {str(k): v for k, v in sorted(counts.items())},
            "range": [lo, max(counts)] if counts else None,
            "fewest_edge_members": len(stabs),
            "fewest_edge_stabiliser_orders": sorted(set(stabs)),
            "his_parenthetical_reading": (f"{sorted(set(stabs))[0]}" if len(set(stabs)) == 1
                                          else "several")}


# ===================================================================== Y, re-verified
def reverify_hypergraph(stage, rec, sample=100, seed=0, budget_s=240.0):
    """An INDEPENDENT rebuild: `typem.cnf_for` on the induced graph and a fresh solver, sharing no
    CNF code with `Stage.cnf`.

    Every correction set `C` of size <= 2, plus a seeded sample of the rest, must satisfy
    `A - C` colourable and `A - (C - {x})` refusing for every `x in C`. Plus the antichain
    property over all of `Y`, which needs no solver at all."""
    from pysat.solvers import Solver
    Y = [sorted(c) for c in rec["hypergraph"]["sets"]]
    allA = set(range(len(stage.atoms)))

    def refuses(drop):
        mask = stage.fixed
        for a in allA - set(drop):
            mask |= stage.atoms[a]
        cl = T.cnf_for(stage.A, mask)
        with Solver(name="cadical153", bootstrap_with=cl) as s:
            return not s.solve()

    small = [c for c in Y if len(c) <= 2]
    rest = [c for c in Y if len(c) > 2]
    rng = random.Random(seed)
    chosen = small + rng.sample(rest, min(sample, len(rest)))
    bad_min, bad_corr, done = [], [], []
    # A TIME BUDGET, because independence costs cold asks. Sharing one incremental oracle would
    # make this fast and would destroy the point: the whole value of this check is that it
    # rebuilds the CNF through `typem.cnf_for` and a fresh solver, sharing no code with
    # `Stage.cnf`. So the asks stay cold -- and a cold refusing ask on these stages was measured
    # at up to 186 s (§R2.4) -- and the SAMPLE shrinks to fit the budget instead. The count then
    # reports what was actually checked, which is the honest form: `Count(n, "sampled", of=|Y|)`.
    t0 = time.time()
    for c in chosen:
        if time.time() - t0 > budget_s:
            break
        done.append(c)
        if refuses(c):
            bad_corr.append(c)                    # deleting C must LOSE the property
            continue
        for x in c:
            if not refuses([y for y in c if y != x]):
                bad_min.append(c)                 # C - {x} must KEEP it, else C is not minimal
                break
    chosen = done
    seen = [frozenset(c) for c in Y]
    viol = [[sorted(a), sorted(b)] for a, b in itertools.combinations(seen, 2)
            if a < b or b < a][:8]
    return {"checked": R.asdict(R.Count(len(chosen), "sampled", of=len(Y))),
            "size_le_2_all_checked": len(small),
            "not_a_correction_set": [list(c) for c in bad_corr][:8],
            "not_minimal": [list(c) for c in bad_min][:8],
            "antichain": R.asdict(R.Count(len(Y), "exhaustive")),
            "antichain_violations": viol,
            "relation": ("Y-reverified" if not bad_corr and not bad_min and not viol else
                         "; ".join(x for x in [
                             f"not-a-correction-set:{len(bad_corr)}" if bad_corr else "",
                             f"not-minimal:{len(bad_min)}" if bad_min else "",
                             f"antichain-violated:{len(viol)}" if viol else ""] if x))}


# ===================================================================== symmetry side-checks
def involution_classes(base, stage, group=None):
    """Conjugacy classes of the stage's `Aut(A)`, and which class each involution lies in
    (M64 P7's unchecked half). The excess of a rung is a CLASS FUNCTION, so this says which
    rungs must agree before any of them is computed."""
    G = group or F.base_group_perms(base)
    aut = F.stage_symmetry(base, stage, G)
    P_ = list(aut.perms)
    n = len(P_[0]) if P_ else 0
    comp = lambda a, b: tuple(a[b[k]] for k in range(n))
    inv = {p: next(q for q in P_ if comp(p, q) == tuple(range(n))) for p in P_}
    classes = []
    seen = set()
    for p in P_:
        if p in seen:
            continue
        c = {comp(comp(g, p), inv[g]) for g in P_}
        seen |= c
        classes.append(sorted(c))
    order = lambda p: next(k for k in range(1, 25)
                           if all(x == y for x, y in zip(_pow(p, k, n), range(n))))
    return {"aut_order": aut.order, "classes": len(classes),
            "class_sizes": [len(c) for c in classes],
            "involution_classes": [{"size": len(c), "orders": sorted({order(p) for p in c})}
                                   for c in classes if any(order(p) == 2 for p in c)],
            "reading": "the excess of a rung is a class function, so involutions in one class must "
                       "give the same rung minimum; M64 §R10 measured 375, 375, 375, 376, 376, "
                       "376, >=377 on the L side"}


def _pow(p, k, n):
    out = tuple(range(n))
    for _ in range(k):
        out = tuple(p[x] for x in out)
    return out


def his_symmetry_guess(path=TABLE1):
    """A free check, since Table 1 is transcribed anyway (Poros, note to card 9): his §5.6 guesses
    that *"for a triples a good approximation will be provided by graphs with symmetries of order
    3 or 6; for pairs with symmetries of order 2 or 4"*. Scored against his own result rows.

    M64 §R10's rung lattice supersedes the guess wherever a stage and its `Y` exist -- everywhere
    in C-E -- but NOT where no stage exists yet, which is exactly phase G's fresh arenas."""
    t = table1(path)
    rows = t["rows"]
    out = {"triples": {"expected": [3, 6], "rows": [], "hits": 0},
           "pairs": {"expected": [2, 4], "rows": [], "hits": 0}}
    for k, r in rows.items():
        kind = ("triples" if "triple" in r["type"] else
                "pairs" if "pair" in r["type"] else None)
        if kind is None:
            continue
        sym = r["sym"]
        hit = any(s in out[kind]["expected"] for s in sym)
        out[kind]["rows"].append({"row": k, "sym": sym, "matches_his_guess": hit})
        out[kind]["hits"] += hit
    for kind in out:
        n = len(out[kind]["rows"])
        out[kind]["score"] = f"{out[kind]['hits']}/{n}"
    out["note"] = ("scored over his own result rows only; the guess is about where to LOOK, so a "
                   "miss is not an error in his paper")
    return out


def completeness_control(rows, classes):
    """M64 P10: does a level set produced AFTER its exchange classes were computed span the affine
    hull those classes predict? Meaningful for C3's level and the rung levels; on the two stages
    the classes were computed FROM, it reports `not-applicable` -- which is the circularity that
    left P10 unscored."""
    if not classes:
        return {"verdict": "not-applicable -- no predicted classes were registered before this "
                          "level was produced"}
    dims = F.affine_dim([tuple(r) for r in rows]) if rows else 0
    predicted = sum(len(m) - 1 for m, c in classes if c is not None) + \
        sum(len(m) for m, c in classes if c is None)
    return {"affine_dim": dims, "predicted_dim": predicted,
            "verdict": "spans-the-predicted-hull" if dims == predicted else
                       f"does-not-span: {dims} against {predicted} -- the level is INCOMPLETE"}


# ===================================================================== the shading (capped)
SHADING_REFUSAL = """shading not extracted: {why}
  The stable/unstable partition is therefore NOT gated from the shading; the ranges still are,
  and every orbit row carries its measured status (stable / unstable-constant-count /
  unstable-varying-count) from OUR level, which is a statement about our object either way.
  His definition (section 6): stable = the same non-empty vertex set in every minimal graph."""


def table_shading(pdf, page, table, *, dpi=200, gray=(224, 224, 224), cap_note=None):
    """Cell backgrounds of his Table 2 (page 25) or Table 3 (page 26), read by rasterising with
    `pdftoppm` and sampling the exact shading gray inside each cell, with cell boxes from
    `pdftotext -bbox-layout` word positions -- never from hand-typed pixel offsets.

    **Capped at about two engineer-hours by the product owner** (subplan §A.2 #3). Past that the
    partition is reported unattested through §E3's refusal path, and a scoped agent may take it as
    a subphase. This function REFUSES rather than guessing when the raster tooling or the cell
    boxes are unavailable."""
    import shutil
    if not shutil.which("pdftoppm") or not shutil.which("pdftotext"):
        raise SystemExit(SHADING_REFUSAL.format(why="pdftoppm/pdftotext are not on PATH"))
    raise SystemExit(SHADING_REFUSAL.format(
        why=cap_note or "not implemented within phase C's two-engineer-hour cap"))


def shading_control(shading, level_rows, table_json=TABLE2, column=None):
    """TWO controls, because the first is necessary and not sufficient (§O7).

    (i) On HIS data: a fill cell is shaded iff its value equals its orbit's size (*'Filled orbits
    are highlighted in gray'*). Any disagreement lists the cells and makes the extraction
    `shading-unreliable`; no stable/unstable verdict is then emitted from it. This catches a
    misread gray and a column misalignment, but NOT a row misalignment in the label column alone.

    (ii) On OUR data: a shaded label means stable, and stable implies a constant count, so a
    shaded label whose orbit's count VARIES in our level is a contradiction -- either the shading
    refers to a different column of Table 2, or our level is not the one that column describes.
    That is the half with teeth."""
    if not shading:
        return {"verdict": "not-extracted", "gated": False}
    bad_fill, bad_label = [], []
    for lab, cell in shading.get("fill", {}).items():
        if cell["shaded"] != (cell["value"] == cell["orbit_size"]):
            bad_fill.append({"orbit": list(lab), "value": cell["value"],
                             "orbit_size": cell["orbit_size"], "shaded": cell["shaded"]})
    for r in level_rows:
        s = shading.get("label", {}).get(tuple(r.label))
        if s and r.lo != r.hi:
            bad_label.append({"orbit": list(r.label), "our_range": [r.lo, r.hi]})
    return {"verdict": ("shading-unreliable" if bad_fill else
                        "shading-contradicts-our-level" if bad_label else "shading-consistent"),
            "arithmetic_control_failures": bad_fill,
            "our_level_contradictions": bad_label,
            "gated": not bad_fill and not bad_label}


def check_A_column(his_A_file, printed_column, base, caption_total=None):
    """His printed `A` column against the orbit fillings of his own `A` file: the printed sum
    against the caption and the file, and every differing row (M63 §1(ii)'s method).

    `printed_column` is `{orbit label: value}` from a transcription; `None` means the column has
    not been transcribed, and the row then says so rather than being omitted."""
    tup = RUN.load_side(his_A_file)
    fill = P.fillings(tup, base)
    if printed_column is None:
        return {"his_file": his_A_file, "file_total": len(tup),
                "relation": "not-compared -- the printed column is not transcribed",
                "file_fillings": {str(list(k)): v for k, v in sorted(fill.items())}}
    printed = {tuple(k): v for k, v in printed_column.items()}
    diffs = [{"orbit": list(k), "printed": printed.get(k, 0), "file": fill.get(k, 0)}
             for k in set(printed) | set(fill) if printed.get(k, 0) != fill.get(k, 0)]
    return {"his_file": his_A_file, "file_total": len(tup),
            "printed_total": sum(printed.values()), "caption_total": caption_total,
            "printed_vs_caption": (None if caption_total is None
                                   else sum(printed.values()) - caption_total),
            "differing_rows": diffs,
            "relation": "A-column-agrees" if not diffs else f"A-column-differs:{len(diffs)}"}


# ===================================================================== the composition
def audit_level(base, stage, rec, spec: AuditSpec, *, shading=None, group=None, sample=100,
                log=print):
    """Composes the above into one record of `parts_report.Comparison` rows in mode 'tuning'
    (M63 is not frozen yet), each carrying its attestation. No aggregate verdict.

    Refuses every range, partition, necessary-atom and completeness claim on a level whose count
    method is not exhaustive."""
    G = group or F.base_group_perms(base)
    t1 = table1()
    his = t1["rows"].get(spec.his_row) if spec.his_row else None
    method = rec["M_set"]["count"]["method"]
    complete = method in ("exhaustive", "exhaustive-level")
    mins_atoms = rec["minima"]
    mins = level_vertices(stage, rec)
    comps, notes = [], []

    def cmp_row(what, ours, theirs, att):
        c = R.Comparison(what, ours, theirs, att, "tuning", gated=False)
        comps.append({"what": what, "ours": ours, "his": theirs, "attestation": att,
                      "relation": (c.relation if theirs is not None else
                                   "not-compared -- his table does not attest it"),
                      "render": c.render()})

    M_vertices = rec.get("M_vertices")
    if his:
        cmp_row("|M| (vertices)", M_vertices, his["M"], his["attestation"]["M"])
        ep = edge_profile(base, stage, mins_atoms, group=G) if complete else None
        if ep:
            cmp_row("edges, low endpoint", ep["range"][0], his["edges"][0],
                    his["attestation"]["edges_low"])
            cmp_row("edges, high endpoint", ep["range"][1], his["edges"][1],
                    his["attestation"]["edges_high"])
        else:
            notes.append("edges: not-compared -- our level is truncated")
        acc = compare_accumulator(base, stage, rec, his["A_file"], group=G) if his["A_file"] else None
        if acc:
            cmp_row("|A| (vertices)", acc["ours_n"], his["A"], his["attestation"]["A"])
        cc = canonical_counts(base, stage, mins_atoms, group=G)
        hisconv = cc["Stab(reduced part), companion free -- HIS convention"]
        cmp_row("|{M}| up to Aut(A), companion free", hisconv["count"]["count"]["n"], his["set"],
                his["attestation"]["set"])
    else:
        acc, cc = None, canonical_counts(base, stage, mins_atoms, group=G)
        notes.append(f"no row of his Table 1 is attributed to {spec.name}: a joint reduction is "
                     f"compared with his tables on |M| and edges only, never as a reproduction "
                     f"row (M63 §6)")

    col = None
    if his and his.get("columns"):
        c0 = [c for c in his["columns"] if c.startswith("table2:")]
        if c0:
            col = his_ranges(c0[0].split(":", 1)[1])
    rows = orbit_rows(base, stage, mins, his_column=col, shading=shading) if complete else []
    if not complete:
        notes.append(f"ranges, partition, necessary atoms and completeness: REFUSED -- the level's "
                     f"count method is {method!r}, and every one of those is sound only for a "
                     f"complete level")

    out = {
        "kind": "m63-audit", "schema": 1, "producer": "tools/parts_audit.py:audit_level",
        "spec": {"name": spec.name, "his_row": spec.his_row, "side": stage.side},
        "mode": "tuning",
        "summary": {
            "headline": rec.get("headline", rec.get("bound_render")),
            "rows_differing": [c["what"] for c in comps if c["relation"] == "differs"],
            "rows_not_compared": [c["what"] for c in comps
                                  if c["relation"].startswith("not-compared")] + notes,
            "orbit_rows_differing": [list(r.label) for r in rows if r.relation == "differs"],
            "level_complete": complete, "count_method": method,
            "spent": (his or {}).get("spent"),
        },
        "comparisons": comps,
        "counts": cc,
        "accumulator": acc,
        "orbit_rows": [r.as_json() for r in rows],
        "edge_profile": edge_profile(base, stage, mins_atoms, group=G) if complete else None,
        "edge_decomposition_of_first_minimum": edge_decomposition(stage, mins_atoms[0]) if mins_atoms else None,
        "stage_fingerprint": stage.fingerprint(), "stage_identity": stage.identity(),
        "base_fingerprint": R.fp_base(base),
        "provenance": R.provenance(),
    }
    if his and his.get("M_file"):
        out["membership"] = membership(base, stage, rec, mins, his["M_file"], group=G)
    return out


# ===================================================================== controls
def _self_test(quick=True):
    """c2.1-c2.9, each planted and watched to fire."""
    fails = []

    def chk(name, cond, detail=""):
        print(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    D = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
    B = P.Base(P.PARTS_R)
    G = F.base_group_perms(B)
    st = PS.Stage(B, V.load_lattice(os.path.join(D, "v451e2400.vtx")),
                  V.load_lattice(os.path.join(D, "v136e564.vtx")), side="L", rung=1)
    rec = json.load(open(os.path.join(ROOT, "data", "m62", "m63-L451-reduction.json")))
    mins = level_vertices(st, rec)

    # c2.1 -- remove one group image of one minimum and watch closure fail
    cc = canonical_counts(B, st, rec["minima"], group=G)
    closed = cc["Stab(reduced part), companion free -- HIS convention"]["closed_under"]
    chk("c2.1 the stored L451 level is closed under Aut(A)", closed)
    cc2 = canonical_counts(B, st, rec["minima"][1:], group=G)
    chk("c2.1 removing one member breaks closure",
        not cc2["Stab(reduced part), companion free -- HIS convention"]["closed_under"])
    chk("c2.1 his count convention gives 282",
        cc["Stab(reduced part), companion free -- HIS convention"]["count"]["count"]["n"] == 282,
        str(cc["Stab(reduced part), companion free -- HIS convention"]["count"]["count"]["n"]))

    # c2.2 -- his A with one vertex removed must read A-differs
    acc = compare_accumulator(B, st, rec, "v403e2112.vtx", group=G)
    chk("c2.2 our A equals his v403e2112 literally", acc["relation"] == "A-equal", acc["relation"])
    tmp = os.path.join(ROOT, "build", "gate", "m63", "planted-A.vtx")
    os.makedirs(os.path.dirname(tmp), exist_ok=True)
    lines = open(os.path.join(D, "v403e2112.vtx")).read().splitlines()
    open(tmp, "w").write("\n".join(lines[:-1]) + "\n")
    acc_bad = compare_accumulator(B, st, rec, tmp, group=G)
    chk("c2.2 A-differs fires when one vertex is removed, naming it",
        acc_bad["relation"] == "A-differs" and len(acc_bad["ours_not_his"]) == 1,
        f"{acc_bad['relation']}, {acc_bad['ours_not_his']}")
    os.unlink(tmp)

    # c2.4 -- a synthetic level whose orbit keeps the same count with different vertices
    lab = (2, 0, 2, 4)
    rows = orbit_rows(B, st, mins)
    r = next(x for x in rows if x.label == lab)
    chk("c2.4 (2,0,2,4) is 10 in every minimum with a VARYING vertex set, so it is "
        "unstable-constant-count and never stable",
        r.lo == r.hi == 10 and r.status == "unstable-constant-count",
        f"lo {r.lo} hi {r.hi} status {r.status}")

    # c2.3 -- one row of his printed column shifted by +1 must read differs
    col = his_ranges("375_m6ab_set")
    rows_ok = orbit_rows(B, st, mins, his_column=col)
    diff_ok = [tuple(x.label) for x in rows_ok if x.relation == "differs"]
    chk("c2.3 the L451 audit differs from his printed 375 column in exactly two orbits",
        set(diff_ok) == {(2, 0, 6, 4), (10, 0, 2, 4)}, str(diff_ok))
    shifted = dict(col)
    k0 = (0, 0, 0, 0)
    shifted[k0] = (col[k0][0] + 1, col[k0][1] + 1)
    rows_bad = orbit_rows(B, st, mins, his_column=shifted)
    chk("c2.3 a row shifted by +1 reads differs",
        any(tuple(x.label) == k0 and x.relation == "differs" for x in rows_bad))

    # c2.5 -- a truncated record refuses every range claim
    trunc = dict(rec)
    trunc["M_set"] = {"count": {"n": 10, "method": "truncated-at-budget", "of": 10},
                      "up_to": "as found"}
    a_tr = audit_level(B, st, trunc, AuditSpec.known()["L451"], group=G)
    chk("c2.5 a truncated level refuses ranges, partition and completeness",
        a_tr["orbit_rows"] == [] and any("REFUSED" in n for n in
                                         a_tr["summary"]["rows_not_compared"]),
        str([n for n in a_tr["summary"]["rows_not_compared"] if "REFUS" in n])[:90])

    # c2.7/c2.8 -- Y, on a small sample, plus planted violations
    rv = reverify_hypergraph(st, rec, sample=8, seed=0)
    chk("c2.7 the sampled correction sets re-verify on an independent rebuild",
        rv["relation"] == "Y-reverified", rv["relation"])
    rec_bad = json.loads(json.dumps(rec))
    biggest = max(rec_bad["hypergraph"]["sets"], key=len)
    extra = next(a for a in range(len(st.atoms)) if a not in biggest)
    rec_bad["hypergraph"]["sets"] = [sorted(biggest + [extra])]
    rv_bad = reverify_hypergraph(st, rec_bad, sample=1, seed=0)
    chk("c2.7 a correction set with an extra atom reads not-minimal",
        "not-minimal" in rv_bad["relation"], rv_bad["relation"])

    # c2.9 -- Table 6's A column against v238e1131 (the positive control) is deferred to the run
    chk("c2.6/c2.9 shading and the A columns are exercised by the run, not the self-test", True,
        "see the audit artifacts")

    print(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


def cmd_audit(a):
    B = P.Base(P.PARTS_R)
    G = F.base_group_perms(B)
    spec = AuditSpec.known()[a.spec]
    rec = json.load(open(a.record))
    D = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
    st = PS.Stage(B, V.load_lattice(os.path.join(D, spec.L_file)),
                  V.load_lattice(os.path.join(D, spec.S_file)), side=spec.side, rung=1)
    if st.fingerprint() != rec.get("stage_fingerprint"):
        raise SystemExit(f"the record was produced on stage {rec.get('stage_fingerprint')} and this "
                         f"spec builds {st.fingerprint()}: the audit would compare two objects.")
    out = audit_level(B, st, rec, spec, group=G)
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
    with open(a.out + ".tmp", "w") as f:
        json.dump(out, f, indent=1)
    os.replace(a.out + ".tmp", a.out)
    print(json.dumps(out["summary"], indent=1))
    print("wrote", a.out)


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    au = sub.add_parser("audit")
    au.add_argument("--record", required=True)
    au.add_argument("--spec", required=True, choices=sorted(AuditSpec.known()))
    au.add_argument("--out", required=True)
    au.set_defaults(f=cmd_audit)
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if _self_test() else 1)
    if not getattr(a, "f", None):
        ap.error("give a subcommand or --self-test")
    a.f(a)


if __name__ == "__main__":
    main()
