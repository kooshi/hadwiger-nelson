#!/usr/bin/env python3
"""Every count and every set, before and after the exactness migration -- the checker for the claim.

WHAT THIS PROVED (2026-09-12). Six places in `typem.py` let a float decide a verdict about an exact
element of K = Q(sqrt3, sqrt11); commit 8b59db6 made them exact and deleted a duplicate copy of the
rho15 edge law whose SIGNED ray keys could never compare an antipodal pair. The claim that work
rests on is that no standing number moved. This script is that claim's checker: it loads the
pre-migration `typem.py` and today's in ONE process and compares results as SETS and as ORDERED
LISTS -- ordering included, because the sort order fixes vertex indices and therefore the meaning
of every stored `.vtx` file.

WHAT IT CANNOT PROVE AGAIN. Nothing about the float code's behaviour beyond what the baseline
commit holds: the float versions are gone from the tree, and this reconstructs them from git rather
than re-deriving them. It validated a ONE-TIME MIGRATION and is NOT a standing gate -- no script
runs it, and it is not part of any module's --self-test. The standing invariants were moved into
`typem_exact.py --self-test` (section 1 the sign predicate, section 6 the retired ray keying,
section 6b the KD-tree proposal gate), which is where an ongoing check belongs.

    python3 tools/m63-exactness/equiv.py                  # baseline 071ec4a vs the working tree
    python3 tools/m63-exactness/equiv.py --today 8b59db6  # vs the migration commit itself

A DIFFERENCE IS A FINDING, NOT AUTOMATICALLY A BUG. By default this compares the baseline against
whatever is on disk now, so later work that legitimately changes a number will show up here. Read
the difference and explain it; do not adjust it away.
"""
from __future__ import annotations
import argparse, sys, time
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import _trees

ap = argparse.ArgumentParser()
ap.add_argument("--baseline", default=_trees.BASELINE, help="commit holding the pre-migration code")
ap.add_argument("--today", default=None, help="commit to compare against (default: working tree)")
ap.add_argument("--quick", action="store_true", help="skip radius 2.44 (the O(n^2) parts of it)")
args = ap.parse_args()

B = _trees.load_as("typem_baseline", _trees.materialise(args.baseline, ["typem.py"]) / "typem.py")
P, p_src = _trees.today("typem_today", args.today)
print(f"baseline : {args.baseline}:tools/typem.py")
print(f"today    : {args.today + ':tools/typem.py' if args.today else p_src}\n")

fails = []


def cmp(label, a, b):
    if a == b:
        v = len(a) if isinstance(a, (set, list, dict)) else a
        print(f"  match {label} = {v}")
        return True
    fails.append(label)
    extra = f"  baseline-only={len(a - b)} today-only={len(b - a)}" if isinstance(a, (set, frozenset)) else ""
    show = (lambda x: len(x) if isinstance(x, (set, list)) else x)
    print(f"  DIFF  {label}: baseline={show(a)} today={show(b)}{extra}")
    return False


def law_edges(M, pts, nrm, c):
    """The cross-edge set, or the REFUSAL -- a law that refuses is a verdict and must match too."""
    try:
        return set(M.CrossLaw.collinear(c).edges(pts, nrm))
    except ValueError as e:
        return "REFUSED:" + ("sin2<=0" if "not a plane rotation" in str(e) else "square")


def suite(r, tag):
    t0 = time.time()
    bp, bt = B.parts_lattice(r)
    pp, pt = P.parts_lattice(r)
    cmp(f"{tag}.points (ORDERED -- this is what fixes vertex indices)", bp, pp)
    cmp(f"{tag}.tuples (ordered)", bt, pt)
    bn, pn = [B.norm2(q) for q in bp], [P.norm2(q) for q in pp]
    cmp(f"{tag}.norms (ordered)", bn, pn)
    cmp(f"{tag}.unit_edges", set(B.unit_edges(bp)), set(P.unit_edges(pp)))
    cmp(f"{tag}.orbits", sorted(map(sorted, B.parts_orbits(bp)[0])),
                          sorted(map(sorted, P.parts_orbits(pp)[0])))
    cmp(f"{tag}.rho15_fast_edges", set(B.cross_edges_rho15_fast(bp, bn)),
                                    set(P.cross_edges_rho15_fast(pp, pn)))
    cmp(f"{tag}.rho15_law_edges", set(B.CrossLaw.rho15().edges(bp, bn)),
                                   set(P.CrossLaw.rho15().edges(pp, pn)))
    for num, den in ((-7, 8), (3, 4), (1, 2), (5, 8), (-1, 4), (9, 10), (-9, 10)):
        cmp(f"{tag}.collinear({num}/{den})",
            law_edges(B, bp, bn, Fr(num, den)), law_edges(P, pp, pn, Fr(num, den)))
    print(f"    [{time.time() - t0:.1f}s]")
    return bp, pp


print("=== parts_lattice r = 2.0  (his section 5.6 base; 1,603 points in 92 orbits) ===")
bp, pp = suite(2.0, "parts2.0")
if not args.quick:
    print("=== parts_lattice r = 2.44  (3,433 points; contains Heule-510 exactly) ===")
    suite(2.44, "parts2.44")

print("=== Moser build_base ===")
for r in (2.05, 2.5):
    bb, bbt = B.build_base(r, span=4)
    pb, pbt = P.build_base(r, span=4)
    cmp(f"moser{r}.points (ordered)", bb, pb)
    cmp(f"moser{r}.tuples (ordered)", bbt, pbt)
    cmp(f"moser{r}.unit_edges", set(B.unit_edges(bb)), set(P.unit_edges(pb)))
    cmp(f"moser{r}.rho15_fast", set(B.cross_edges_rho15_fast(bb)), set(P.cross_edges_rho15_fast(pb)))

print("=== sieve: admissibility, the radius sort, and the family identity ===")
t0 = time.time()
bs, ps = B.sieve(bp, verbose=False), P.sieve(pp, verbose=False)
for k in ("pairs", "radii", "no_rotation", "rejected_in_K", "admitting", "raw_radicands"):
    cmp(f"sieve2.0.{k}", bs[k], ps[k])
cmp("sieve2.0.classes (the square-class representatives)", set(bs["classes"]), set(ps["classes"]))
cmp("sieve2.0.radius_families_total",
    sum(len(B.radius_families(e)) for e in bs["classes"].values()),
    sum(len(P.radius_families(e)) for e in ps["classes"].values()))
print(f"    [{time.time() - t0:.1f}s]")

print("=== CrossLaw.collinear refusal boundary ===")


def refusal(M, c):
    """Which verdict the law reaches on a cosine: accepted, or WHICH of the two refusals."""
    try:
        M.CrossLaw.collinear(c)
        return "accepted"
    except ValueError as e:
        return "refused(sin2<=0)" if "not a plane rotation" in str(e) else "refused(square)"


for c in (Fr(7, 8), Fr(-7, 8), Fr(1, 2), Fr(3, 4), Fr(1), Fr(-1), Fr(2), Fr(5, 4),
          Fr(99, 100), Fr(-99, 100)):
    cmp(f"collinear({c})", refusal(B, c), refusal(P, c))

print()
print("RESULT:", "ALL MATCH -- every count and every set unchanged" if not fails
      else f"{len(fails)} DIFFERENCES: {fails}")
sys.exit(1 if fails else 0)
