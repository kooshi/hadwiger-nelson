#!/usr/bin/env python3
"""FS131-M5: `main` merged into `fs131-w5` — every file is the side it should be, byte for byte, up to the declared edits.

For every file under `Proofs/` (and `Proofs.lean`, `scripts/Axioms.lean`, `ARCHITECTURE.md`), against the merge base BASE, OURS
(`fs131-w5` before the merge) and THEIRS (`origin/main`):
  - changed by THEIRS only: the merged file equals THEIRS' (every wave-4 module, Woodall, MERGE: `main`'s side);
  - changed by OURS only: the merged file equals OURS' after the declared edits (EDITS below: the `framePt → fromFrame` rename in
    `FlankUA`, the identical copies removed or made module-local, the imports that removal needs) applied exactly, each old text
    occurring exactly the stated number of times;
  - changed by both (a `.lean` file): the merged file equals `git merge-file`'s clean three-way merge;
  - `Proofs.lean`: its import lines are the three-way merge of the sides' sets (kept by both, or added by either), none twice;
  - `scripts/Axioms.lean`: its `#print axioms` lines are the three-way merge of the sides' sets, with the records OURS added renamed by
    the rename and those of the removed or module-local copies dropped (REC_DROP), none twice; its other lines the three-way merge;
  - `ARCHITECTURE.md`'s module table, row by row, three-way (a row changed by one side is that side's), up to the two Imports cells the
    removals change (ROW_EDITS).
Usage: fs131_m5_merge_check.py [BASE OURS THEIRS] [--rev MERGED] [--self-test]   (defaults 111830c8 e6ba8923 origin/main; the merged
side is the working tree unless --rev names a commit). Exit 0 only on PASS. --self-test plants five faults in the merged view (a byte in
a `main`-only module, an extra edit in `FlankUA`, a dropped import in `Proofs.lean`, a doubled axioms record, a reverted Imports cell),
requires each to FAIL naming its file, and the unplanted run to PASS.
"""
import collections
import os
import re
import subprocess
import sys
import tempfile

V = "Proofs/HadwigerNelson/Plane/ValidMap/"
P = "Proofs/HadwigerNelson/Plane/"

NEXT_INJ = '''/-- `next` is injective: the germ after `i` determines `i`. -/
theorem next_injective : Function.Injective (next : Fin n → Fin n) := by
  intro i j h
  unfold next at h
  split_ifs at h with hi hj hj <;> simp only [Fin.ext_iff] at h <;> ext <;> omega

'''
COLOURS_SUB = '''/-- An interior point carries only its own colour. -/
theorem coloursAt_subset_of_mem_interiorPts {z : ℂ} (hz : z ∈ F.interiorPts) : F.coloursAt z ⊆ {F.col z} := by
  intro j hj
  have hev := F.locallyConstant z hz.1 hz.2
  obtain ⟨y, hy, hyj⟩ := mem_closure_iff_nhds.mp hj _ hev
  rw [mem_singleton_iff, ← hyj.2]
  exact hy

'''
UPN = '''/-- A class with no two points at distance exactly `1` has no unit pairs (`AeProperRegions.unitPairsNull_cls`, class by class). -/
theorem unitPairsNull_of_dist_ne_one {W : Set ℂ} (hne : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1) : UnitPairsNull W := by
  have h : unitPairSet W = ∅ := by
    ext q
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro h1 h2
    exact hne _ h1 _ h2 (by rw [dist_self_add_right, norm_e])
  unfold UnitPairsNull
  rw [h, MeasureTheory.measure_empty]

'''
N_ADD = '/-- The point `N + t e(α − π/2 + x)` in the frame at `v` along `e α`: `(t sin x, 1 − t cos x)`. -/\ntheorem N_add_eq_fromFrame (v : ℂ) (α t x : ℝ) :\n    v + e (α + π / 2) + (t : ℂ) * e (α - π / 2 + x) = fromFrame v α (t * Real.sin x) (1 - t * Real.cos x) := by\n  unfold fromFrame\n  rw [e_add α (π / 2), show α - π / 2 + x = α + (x - π / 2) by ring, e_add α (x - π / 2), e_eq (π / 2), e_eq (x - π / 2),\n    Real.cos_pi_div_two, Real.sin_pi_div_two, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two]\n  push_cast\n  ring\n\n'
# file -> list of (old, new, count); applied in order to OURS' text
EDITS = {
    V + "FlankUA.lean": [("framePt", "fromFrame", 29), (N_ADD, "", 1),
                         ("rw [N_add_eq_fromFrame]", "rw [normalPt_add_eq_fromFrame]", 1)],
    V + "MapTopology.lean": [
        (NEXT_INJ, "", 1), (COLOURS_SUB, "", 1),
        ("import Proofs.HadwigerNelson.Plane.ValidMap.HexRing\n",
         "import Proofs.HadwigerNelson.Plane.ValidMap.HexRing\nimport Proofs.HadwigerNelson.Plane.ValidMap.Surgery\n", 1)],
    V + "Dense.lean": [
        (UPN, "", 1), ("unitPairsNull_of_dist_ne_one", "unitPairsNull_of_no_unit_pair", 1),
        ("import Proofs.HadwigerNelson.Plane.ValidMap.Cor3\n",
         "import Proofs.HadwigerNelson.Plane.ValidMap.Cor3\nimport Proofs.HadwigerNelson.Plane.FalconerReduction\n", 1)],
    P + "PlaneTopology.lean": [
        ("/-- `e θ · e (−θ) = 1`. -/\ntheorem e_mul_e_neg (θ : ℝ)",
         "/-- `e θ · e (−θ) = 1`. Module-local: the public statement is `Plane/Slack`'s `e_mul_e_neg`, which this module does not import "
         "(FS131-M5). -/\nprivate theorem e_mul_e_neg (θ : ℝ)", 1)],
    P + "CurveGraph.lean": [
        ("/-- A branch point reads its direction modulo `2π`. -/\ntheorem branchPt_congr {v : ℂ}",
         "/-- A branch point reads its direction modulo `2π`. Module-local: the public statement is `Plane/ValidMap/Moves`'s "
         "`branchPt_congr_dir`, which\nthis module does not import (FS131-M5). -/\nprivate theorem branchPt_congr {v : ℂ}", 1)],
}
RENAME = ("framePt", "fromFrame")
# OURS' records whose declaration this merge removed or made module-local (a name THEIRS also records stays, once)
REC_DROP = {"HadwigerNelson.Plane.BranchGerms.next_injective", "HadwigerNelson.Plane.ArcMap.coloursAt_subset_of_mem_interiorPts",
            "HadwigerNelson.Plane.unitPairsNull_of_dist_ne_one", "HadwigerNelson.Plane.e_mul_e_neg",
            "HadwigerNelson.Plane.branchPt_congr", "HadwigerNelson.Plane.ArcMap.N_add_eq_fromFrame"}
# a record OURS moved (its line deleted at the base's place, re-added beside its new module) that `main` deleted with its old place:
# `n3_end` left `BaseSteps` on both sides, and lives on this branch in `Terminal` (a set-level three-way merge would drop it)
REC_KEEP = {"HadwigerNelson.Plane.ArcMap.n3_end"}
ROW_EDITS = {
    "Plane/ValidMap/Dense": (" | `Plane/ValidMap/Terminal`, `Plane/ValidMap/HexRing`, `Plane/ValidMap/Cor3` | ",
                             " | `Plane/ValidMap/Terminal`, `Plane/ValidMap/HexRing`, `Plane/ValidMap/Cor3`, `Plane/FalconerReduction` | "),
    "Plane/ValidMap/MapTopology": (" | `Plane/ValidMap/HexRing`, `Plane/Tiles`, `Plane/PlaneTopology`, `Plane/CurveGraph` | ",
                                   " | `Plane/ValidMap/HexRing`, `Plane/ValidMap/Surgery`, `Plane/Tiles`, `Plane/PlaneTopology`, "
                                   "`Plane/CurveGraph` | "),
}
SPECIAL = {"Proofs.lean", "scripts/Axioms.lean", "ARCHITECTURE.md"}


def git(*a, ok=False):
    r = subprocess.run(["git", *a], capture_output=True, text=True)
    if r.returncode and not ok:
        raise SystemExit(f"git {' '.join(a)}: {r.stderr}")
    return r.stdout if r.returncode == 0 else None


def show(ref, path):
    return git("show", f"{ref}:{path}", ok=True)


def tracked(ref):
    return set(git("ls-tree", "-r", "--name-only", ref, "Proofs").split()) | SPECIAL


def changed(a, b):
    return set(git("diff", "--name-only", a, b, "--", "Proofs", "Proofs.lean", "scripts/Axioms.lean", "ARCHITECTURE.md").split())


def merged_texts(rev, paths):
    out = {}
    for p in paths:
        if rev:
            out[p] = show(rev, p)
        else:
            out[p] = open(p, encoding="utf-8").read() if os.path.exists(p) else None
    return out


def merge_file(o, b, t):
    with tempfile.TemporaryDirectory() as d:
        fs = []
        for n, s in (("o", o), ("b", b), ("t", t)):
            f = os.path.join(d, n)
            open(f, "w", encoding="utf-8").write(s)
            fs.append(f)
        r = subprocess.run(["git", "merge-file", "-p", *fs], capture_output=True, text=True)
        return r.stdout, r.returncode


def three(b, o, t):
    """A three-way merge of sets: kept by both, or added by either."""
    return (b & o & t) | (o - b) | (t - b)


def rows(t):
    d = collections.OrderedDict()
    for ln in t.split("\n"):
        m = re.match(r"^\| `([^`]+)` \|", ln)
        if m:
            d.setdefault(m.group(1), []).append(ln)
    return d


def check(base, ours, theirs, M):
    bad = []
    co, ct = changed(base, ours), changed(base, theirs)
    for p in sorted(set(M) - SPECIAL):
        if not p.endswith(".lean"):
            continue
        b, o, t, m = show(base, p), show(ours, p), show(theirs, p), M[p]
        if p in ct and p not in co:
            if m != t:
                bad.append(f"FAIL {p}: changed by main only, merged differs from main's")
        elif p in co and p not in ct:
            want = o
            for old, new, n in EDITS.get(p, []):
                if want is None or want.count(old) != n:
                    bad.append(f"FAIL {p}: declared edit's old text occurs {0 if want is None else want.count(old)} times, not {n}")
                    want = None
                    break
                want = want.replace(old, new)
            if want is not None and m != want:
                bad.append(f"FAIL {p}: changed by ours only, merged differs from ours' with the declared edits")
        elif p in co and p in ct:
            if b is None or o is None or t is None:
                if m != (t if o == b else o):
                    bad.append(f"FAIL {p}: added or deleted on a side, merged unexpected")
                continue
            w, rc = merge_file(o, b, t)
            if rc != 0:
                bad.append(f"FAIL {p}: both sides changed and git merge-file reports {rc} conflict(s)")
            elif m != w:
                bad.append(f"FAIL {p}: both sides changed, merged differs from the clean three-way merge")
        else:
            if m != b:
                bad.append(f"FAIL {p}: changed by neither side, merged differs from the base")
    for p in EDITS:
        if p not in co or p in ct:
            bad.append(f"FAIL {p}: a declared edit is on a file that is not ours-only")
    # Proofs.lean
    imp = lambda s: [ln for ln in s.split("\n") if ln.startswith("import ")]
    ib, io, it, im = (set(imp(show(base, "Proofs.lean"))), set(imp(show(ours, "Proofs.lean"))), set(imp(show(theirs, "Proofs.lean"))),
                      imp(M["Proofs.lean"]))
    if len(im) != len(set(im)):
        bad.append("FAIL Proofs.lean: an import line occurs twice")
    wi = three(ib, io, it)
    if set(im) != wi:
        bad.append(f"FAIL Proofs.lean: imports differ from the three-way union (missing {sorted(wi - set(im))}, "
                   f"extra {sorted(set(im) - wi)})")
    # scripts/Axioms.lean
    ao, at, am = (show(ours, "scripts/Axioms.lean"), show(theirs, "scripts/Axioms.lean"), M["scripts/Axioms.lean"])
    rec = lambda s: [ln[len("#print axioms "):] for ln in s.split("\n") if ln.startswith("#print axioms ")]
    rb, ro, rt, rm = set(rec(show(base, "scripts/Axioms.lean"))), set(rec(ao)), set(rec(at)), rec(am)
    added_o = {r.replace(*RENAME) for r in ro - rb} - REC_DROP
    want = (rb & ro & rt) | added_o | (rt - rb) | (REC_KEEP & ro)
    if len(rm) != len(set(rm)):
        bad.append(f"FAIL scripts/Axioms.lean: a record occurs twice ({[r for r, c in collections.Counter(rm).items() if c > 1][:3]})")
    if set(rm) != want:
        bad.append(f"FAIL scripts/Axioms.lean: records differ (missing {sorted(want - set(rm))[:5]}, extra {sorted(set(rm) - want)[:5]})")
    other = lambda s: collections.Counter(ln for ln in s.split("\n") if ln.strip() and not ln.startswith("#print axioms "))
    ob, oo, ot, om = set(other(show(base, "scripts/Axioms.lean"))), set(other(ao)), set(other(at)), set(other(am))
    if om != three(ob, oo, ot):
        bad.append("FAIL scripts/Axioms.lean: non-record lines differ from the union of both sides'")
    # ARCHITECTURE.md
    rb, ro2, rt2, rm2 = (rows(show(base, "ARCHITECTURE.md")), rows(show(ours, "ARCHITECTURE.md")), rows(show(theirs, "ARCHITECTURE.md")),
                         rows(M["ARCHITECTURE.md"]))
    for k in set(rb) | set(ro2) | set(rt2) | set(rm2):
        B, O, T, Mm = rb.get(k), ro2.get(k), rt2.get(k), rm2.get(k)
        if O == T:
            w = O
        elif O == B:
            w = T
        elif T == B:
            w = O
        else:
            bad.append(f"FAIL ARCHITECTURE.md: row {k} changed on both sides")
            continue
        if k in ROW_EDITS and w is not None:
            old, new = ROW_EDITS[k]
            w = [ln.replace(old, new) for ln in w]
        if Mm != w:
            bad.append(f"FAIL ARCHITECTURE.md: row {k} is not the side that changed it (with the declared Imports edit)")
    return bad, len(M)


def main():
    a = sys.argv[1:]
    self_test = "--self-test" in a
    rev = None
    if "--rev" in a:
        i = a.index("--rev")
        rev = a[i + 1]
        del a[i:i + 2]
    a = [x for x in a if x != "--self-test"]
    base, ours, theirs = a if len(a) == 3 else ("111830c8", "e6ba8923", "origin/main")
    paths = tracked(ours) | tracked(theirs) | (tracked(rev) if rev else set(git("ls-files", "Proofs").split()))
    M = merged_texts(rev, sorted(paths))
    bad, n = check(base, ours, theirs, M)
    for b in bad:
        print(b)
    print(f"{n} files; base {base}; ours {ours}; theirs {theirs}; {len(bad)} failure(s)")
    print("FAIL" if bad else "PASS")
    if not self_test:
        return 1 if bad else 0
    if bad:
        print("self-test needs the unplanted run to PASS")
        return 1
    plants = [
        (V + "Surgery.lean", lambda s: s.replace("theorem", "theorem ", 1)),
        (V + "FlankUA.lean", lambda s: s + "\n-- planted\n"),
        ("Proofs.lean", lambda s: s.replace("import Proofs.HadwigerNelson.Plane.ValidMap.Moves\n", "", 1)),
        ("scripts/Axioms.lean", lambda s: s.replace("#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux\n",
                                                     "#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux\n"
                                                     "#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux\n", 1)),
        ("ARCHITECTURE.md", lambda s: s.replace(ROW_EDITS["Plane/ValidMap/Dense"][1], ROW_EDITS["Plane/ValidMap/Dense"][0], 1)),
    ]
    ok = True
    for p, f in plants:
        M2 = dict(M)
        M2[p] = f(M[p])
        if M2[p] == M[p]:
            print(f"SELF-TEST plant on {p} changed nothing")
            ok = False
            continue
        b2, _ = check(base, ours, theirs, M2)
        hit = [x for x in b2 if p in x]
        print(f"SELF-TEST plant on {p}: {'FIRED' if hit else 'MISSED'} {hit[:1]}")
        ok &= bool(hit)
    print("SELF-TEST OK" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
