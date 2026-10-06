#!/usr/bin/env python3
"""FS131-MC1 — the statements of the example maps' four modules, read against the skeleton and against the branch as given.

A declaration's statement is its text from `theorem` / `def` to the first `:=`, whitespace collapsed. Two comparisons:
  skeleton   every declaration of `Plane/Models/{Paint, Moves, Stuck, Bends}` at the planner's commit (fe9d6d32) is in the tree
             verbatim, in some one of the four files — but the RULED set, which must be gone;
  as given   against `b9b3a9e5` (the tree this job received): the names gone and the statements changed must be exactly the sets
             EXPECT_GONE and EXPECT_CHANGED below, each with its reason.

  fs131_mc_statements.py              exit 0 when both hold; every difference is printed
  fs131_mc_statements.py --self-test  in memory: a second skeleton declaration dropped, a skeleton statement altered, an unlisted helper
                                      dropped — each must be reported; the faithful run must pass beside them
"""
import re, subprocess, sys

FILES = ["Proofs/HadwigerNelson/Plane/Models/%s.lean" % n for n in ("Paint", "Moves", "Stuck", "Bends")]
SKEL, GIVEN = "fe9d6d32", "b9b3a9e5"
RULED = {"stuckModel_terminal": "removed by ruling, inventory item 482"}
EXPECT_GONE = dict(RULED, **{
    "stuckModel_dist_sq": "moved to `Paint` as `dist_sq_coords` (the fold of item 479; one declaration serves `Stuck` and `Bends`)",
    "brick_floor_eq": "unused after the tidy to wave 5's `brickCell` (`sevenBrick_col_val` holds the floors)",
    "not_int_between": "unused after the tidy (`sevenBrick_mem_interiorPts` holds the argument)"})
EXPECT_CHANGED = {"shadowModel_hornSet_not_mem_hornArcs": "its two curvature bounds `≤ 2` became `≤ 1`, so that its one-base-point case is "
                  "`Paint`'s `disjoint_hornSet_hornArcs` (the fold of item 479); a helper of FS131-MB2's, no skeleton statement"}
DECL = re.compile(r"^(?:noncomputable )?(theorem|def|lemma|abbrev) ([^\s:({\[]+)(.*?):=", re.S | re.M)


def decls(text):
    return {m.group(2): " ".join((m.group(1) + " " + m.group(2) + m.group(3)).split()) for m in DECL.finditer(text)}


def at(rev):
    d = {}
    for f in FILES:
        r = subprocess.run(["git", "show", f"{rev}:{f}"], capture_output=True, text=True)
        if r.returncode == 0:
            d.update(decls(r.stdout))
    return d


def now():
    d = {}
    for f in FILES:
        d.update(decls(open(f).read()))
    return d


def check(skel, given, cur, quiet=False):
    probs = []
    for n, s in skel.items():
        if n in RULED:
            if n in cur:
                probs.append(f"RULED-BUT-PRESENT {n}")
        elif n not in cur:
            probs.append(f"SKELETON-GONE {n}")
        elif cur[n] != s:
            probs.append(f"SKELETON-CHANGED {n}")
    gone = {n for n in given if n not in cur}
    changed = {n for n in given if n in cur and cur[n] != given[n]}
    for n in sorted(gone ^ set(EXPECT_GONE)):
        probs.append(f"GONE-SET-DIFFERS {n}")
    for n in sorted(changed ^ set(EXPECT_CHANGED)):
        probs.append(f"CHANGED-SET-DIFFERS {n}")
    if not quiet:
        print(f"skeleton ({SKEL}): {len(skel)} declarations, {len([n for n in skel if n in cur and cur[n] == skel[n]])} verbatim in the tree, "
              f"{len([n for n in skel if n not in cur])} gone {sorted(n for n in skel if n not in cur)}")
        print(f"as given ({GIVEN}): {len(given)} declarations; gone {len(gone)}, changed {len(changed)}, added {len([n for n in cur if n not in given])}")
        for n in sorted(gone):
            print(f"  GONE    {n} — {EXPECT_GONE.get(n, 'NOT EXPECTED')}")
        for n in sorted(changed):
            print(f"  CHANGED {n} — {EXPECT_CHANGED.get(n, 'NOT EXPECTED')}")
        for p in probs:
            print("PROBLEM", p)
        print(f"{len(probs)} problem(s) -> {'OK' if not probs else 'FAIL'}")
    return probs


if __name__ == "__main__":
    skel, given, cur = at(SKEL), at(GIVEN), now()
    if "--self-test" in sys.argv:
        faithful = check(skel, given, cur, quiet=True)
        a = dict(cur); a.pop("stuckModel_hyps")
        b = dict(cur); b["hornModel_shave"] = b["hornModel_shave"] + " ∧ True"
        c = dict(cur); c.pop("stuckModel_shadow")
        r = [check(skel, given, x, quiet=True) for x in (a, b, c)]
        ok = (not faithful and any("SKELETON-GONE stuckModel_hyps" in p for p in r[0]) and any("SKELETON-CHANGED hornModel_shave" in p for p in r[1])
              and any("GONE-SET-DIFFERS stuckModel_shadow" in p for p in r[2]))
        print("faithful:", len(faithful), "problem(s); plants:", [len(x) for x in r], "->", "OK" if ok else "FAIL")
        sys.exit(0 if ok else 1)
    sys.exit(1 if check(skel, given, cur) else 0)
