#!/usr/bin/env python3
"""Emit a certificate's *difference witness*: the M08 geometry, at a fraction of the kernel cost.

The per-edge route recomputes a squared distance for every listed edge. This one verifies one
squared length per distinct edge *difference* -- 133 for de Grey's 7877 edges -- and reduces each
edge to a single big-integer subtraction over packed coordinates.

**Nothing here is trusted.** A wrong difference, a wrong key, a wrong packing, a leaf out of range or
a short key list each make `DiffWitness.Certifies` return `false`; none of them can make a theorem
false. What this file has to get right is only whether Lean *accepts* the data.

Six conventions have to agree with `Proofs/HadwigerNelson/Packed.lean`, which has never read this
file. Three of them -- difference orientation, the vertex bound, and the key order -- are checked by
Lean and reported by name. The other three -- lane width, lane order inside the tower, and
x-before-y -- are pinned by the ruler constant asserted in `check_contract()`, which is the same
number `Packed.lean` guards. If that assertion fails, stop: every table this file would emit is
wrong in the same way, and no amount of staring at a `false` will say so.

Usage:
    python3 tools/emit_diffs.py tools/degrey_cert.json deGrey \\
        --dir Proofs/HadwigerNelson/Instances/DeGrey \\
        --module Proofs.HadwigerNelson.Instances.DeGrey
"""

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from emit_cert import ptlit                                        # noqa: E402  (same conventions)

LANE_BITS = 32                    # must equal `HadwigerNelson.laneBits`
VERTEX_BOUND = 1 << 29            # must equal `HadwigerNelson.vertexBound`
LANES = 32                        # integer leaves in a `Pt`: sixteen per coordinate

# The packing of the point whose thirty-two digits are 1..32 in lane order. `Packed.lean` guards the
# same number. Lane width, lane order and x-before-y are all three fixed by it.
RULER = sum((l + 1) * (1 << (LANE_BITS * l)) for l in range(LANES))


def leaves(coord):
    """A point's 32 integer leaves in lane order: x's sixteen, then y's."""
    return list(coord[0]) + list(coord[1])


def pack(coord):
    """The point as one integer, one `LANE_BITS`-wide lane per leaf, low lanes first.

    Linear by construction, which is the whole point: a difference of packed points is the packed
    difference, exactly, with no borrow between lanes to reason about.
    """
    return sum(v * (1 << (LANE_BITS * l)) for l, v in enumerate(leaves(coord)))


def check_contract():
    """Fail before emitting anything if this file and `Packed.lean` disagree about the packing."""
    ruler = [[l + 1 for l in range(16)], [l + 17 for l in range(16)]]
    got = pack(ruler)
    if got != RULER:
        raise SystemExit(
            "emit_diffs: the packing convention here does not match `Packed.lean`.\n"
            f"  the ruler point packs to {got}\n  Packed.lean guards        {RULER}\n"
            "Check LANE_BITS, the lane order (x before y, `re` before `im`), and `leaves()`.")


def sub(a, b):
    """`a - b`, componentwise -- the orientation `UDCert.ValidOn` reads: source minus target."""
    return [[x - y for x, y in zip(a[0], b[0])], [x - y for x, y in zip(a[1], b[1])]]


def differences(coords, edges):
    """The distinct edge differences in first-use order, and one key per edge.

    First-use order rather than sorted: it is stable under regeneration, and it puts the differences
    a reader meets first at the front of the table.
    """
    order, index, keys = [], {}, []
    for i, j in edges:
        d = sub(coords[i], coords[j])
        tag = (tuple(d[0]), tuple(d[1]))
        if tag not in index:
            index[tag] = len(order)
            order.append(d)
        keys.append(index[tag])
    return order, keys


def check_bounds(coords, diffs):
    """Every vertex leaf inside `VERTEX_BOUND`, every difference leaf inside twice it.

    Lean checks this too and names the offender. Checking here as well means a generator about to
    emit unusable data says so in one line rather than after a `decide +kernel`.
    """
    worst = max((abs(v) for c in coords for v in leaves(c)), default=0)
    if worst > VERTEX_BOUND:
        raise SystemExit(f"emit_diffs: a vertex leaf is {worst}, over the bound {VERTEX_BOUND}")
    worst_d = max((abs(v) for d in diffs for v in leaves(d)), default=0)
    if worst_d > 2 * VERTEX_BOUND:
        raise SystemExit(f"emit_diffs: a difference leaf is {worst_d}, over {2 * VERTEX_BOUND}")
    return worst, worst_d


def intlit(v):
    return f"({v})" if v < 0 else str(v)


def pttable(coords, lo, hi):
    """A `PtTable` over indices [lo, hi).

    **Must match `emit_cert.tablelit` split for split**, because `packOk` compares the two trees'
    shapes node by node -- which is exactly what that comparison is for.
    """
    if hi - lo == 1:
        return "(PtTable.leaf " + ptlit(coords[lo]) + ")"
    mid = (lo + hi) // 2
    return (f"(PtTable.node {mid - lo} " + pttable(coords, lo, mid) + " "
            + pttable(coords, mid, hi) + ")")


def inttable(vals, lo, hi):
    """The packed sibling of `pttable`, split at the same pivots."""
    if hi - lo == 1:
        return "(IntTable.leaf " + intlit(vals[lo]) + ")"
    mid = (lo + hi) // 2
    return (f"(IntTable.node {mid - lo} " + inttable(vals, lo, mid) + " "
            + inttable(vals, mid, hi) + ")")


def emit(data, name, mod):
    """Returns {filename: contents} for the two generated modules."""
    coords = data["coords"]
    edges = [tuple(e) for e in data["edges"]]
    n = len(coords)
    check_contract()
    diffs, keys = differences(coords, edges)
    worst, worst_d = check_bounds(coords, diffs)

    packedV = [pack(c) for c in coords]
    packedD = [pack(d) for d in diffs]

    D = [f"import {mod}.Edges",
         "import Proofs.HadwigerNelson.Packed", "",
         "/-!",
         f"# `{name}` — the difference witness",
         "",
         f"The {len(edges)} claimed edges have only **{len(diffs)} distinct difference vectors**, so a",
         f"squared length is verified {len(diffs)} times rather than {len(edges)}, and every edge",
         "reduces to one big-integer subtraction over packed coordinates.",
         "",
         "Generated by `tools/emit_diffs.py` and **not trusted**: a wrong difference, key, packing or",
         "bound makes `DiffWitness.Certifies` return `false`. See `Valid.lean` for the claim, and",
         "`PackedDiagnose.lean` for what to run when it does not hold.",
         "",
         f"Largest vertex leaf {worst}; largest difference leaf {worst_d}; the bound is",
         f"{VERTEX_BOUND}.",
         "-/", "",
         "set_option maxHeartbeats 2000000",
         "set_option maxRecDepth 100000", "",
         "namespace HadwigerNelson", "",
         f"/-- The {len(diffs)} distinct differences, their packings, the {n} vertex packings, and one",
         "key per edge in edge order. -/",
         f"def {name}Diffs : DiffWitness {n} where",
         "  packedV := " + inttable(packedV, 0, n),
         "  diffs := " + pttable(diffs, 0, len(diffs)),
         "  packedD := " + inttable(packedD, 0, len(diffs)),
         "  keys := [" + ",".join(str(k) for k in keys) + "]", "",
         "end HadwigerNelson"]

    V = [f"import {mod}.Diffs", "",
         "/-!",
         f"# `{name}` — the geometry, verified",
         "",
         f"`{name}_valid` is the whole geometric claim in one line: all {len(edges)} listed pairs are",
         "exactly one unit apart. Its statement is the one the per-edge route produced, so nothing",
         "downstream changed shape when the route underneath it did.",
         "",
         "## If this fails",
         "",
         "The build error says so in one line and tells you what to run. It cannot say more: at this",
         "size the proposition `decide` refuses cannot be printed at all, which is why the check is a",
         "named `Bool` and the failure carries a directive rather than a term.",
         "",
         "```lean",
         "import Proofs.HadwigerNelson.PackedDiagnose      -- deliberately not imported here: this",
         "namespace HadwigerNelson                          -- module is upstream of certificates",
         f"#eval {name}Diffs.faultReport {name}Table {name}   -- one line, naming the culprit",
         "```",
         "-/", "",
         "namespace HadwigerNelson", "",
         "/-- The witness is checked against the certificate's **own** vertices. -/",
         f"theorem {name}_verts : {name}.verts = {name}Table.toVerts := rfl", "",
         f"/-- The four checks: {n} vertex packings, {len(diffs)} difference packings,",
         f"{len(diffs)} squared lengths, and {len(edges)} edges.",
         "",
         "Named rather than written inline, because when it comes back `false` the tactic reports the",
         "proposition it decided — and a proposition mentioning the witness cannot be printed at this",
         "size. A reader of a failing build should meet a name and a pointer, not a page. -/",
         f"def {name}Certified : Bool := {name}Diffs.Certifies {name}Table {name}", "",
         "-- The `fail` branch is unreachable *when the geometry checks*, which is exactly when the",
         "-- linter runs. It is reachable on the day it matters, and that is the day this file exists",
         "-- for, so the linter is silenced here rather than the directive deleted.",
         "set_option linter.unreachableTactic false in",
         "set_option linter.unusedTactic false in",
         f"theorem {name}_certifies : {name}Certified = true := by",
         "  -- `decide` can only say no, and at this size it cannot even *print* the proposition it",
         "  -- decided — the pretty-printer runs out of recursion depth on the witness. So the",
         "  -- failure carries a directive instead of a wall of term.",
         "  first",
         "  | decide +kernel",
         f"  | fail \"the geometry does not check. For the culprit, in a file with \\",
         "           `import Proofs.HadwigerNelson.PackedDiagnose` and inside `namespace \\",
         f"           HadwigerNelson`:  #eval {name}Diffs.faultReport {name}Table {name}\"", "",
         "/-- Every listed edge is a real unit distance. -/",
         f"theorem {name}_valid : {name}.Valid = true :=",
         f"  {name}.valid_of_diffWitness {name}Table {name}Diffs {name}_verts {name}_certifies", "",
         "end HadwigerNelson"]

    return {"Diffs.lean": "\n".join(D) + "\n", "Valid.lean": "\n".join(V) + "\n"}


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("json", help="certificate data: coords, edges, denom")
    ap.add_argument("name", help="Lean base name, e.g. deGrey")
    ap.add_argument("--dir", required=True, help="output directory")
    ap.add_argument("--module", required=True, help="Lean module prefix of that directory")
    args = ap.parse_args()

    data = json.load(open(args.json))
    out = emit(data, args.name, args.module)
    d = Path(args.dir)
    d.mkdir(parents=True, exist_ok=True)
    for fname, text in out.items():
        (d / fname).write_text(text, encoding="utf-8")
        print(f"{d / fname}: {len(text):,} bytes")


if __name__ == "__main__":
    main()
