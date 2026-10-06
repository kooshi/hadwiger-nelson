#!/usr/bin/env python3
"""FS131-M6: `origin/fs131-w5` (carrying `main`) merged into `fs131-w5c` — every file is the side it should be, byte for byte, up to
the declared edits. A copy of FS131-M5's `tools/fs131_m5_merge_check.py` under this job's prefix (standing rule 7), with this merge's
edits, a `cut` edit kind (delete one declaration: from the line beginning START through the line before the one beginning END, each
occurring once), renames for the axioms records, and a check of the shared record `plans/FS131-I5-implementation.md`.

For every file under `Proofs/` (and `Proofs.lean`, `scripts/Axioms.lean`, `ARCHITECTURE.md`), against the merge base BASE, OURS
(`fs131-w5c` before the merge) and THEIRS (`origin/fs131-w5`):
  - changed by THEIRS only: the merged file equals THEIRS';
  - changed by OURS only: the merged file equals OURS' after the declared edits (EDITS: `framePt -> fromFrame` in `HornShadow` and
    `Terminal`; the copies of `fs131-w5`'s or `main`'s lemmas removed; the uses renamed; `Limit`'s new import), each applied exactly;
  - changed by both (`BaseDense`, `Contact`): the merged file equals `git merge-file`'s clean three-way merge;
  - `Proofs.lean`: its imports are the three-way merge of the sides' sets, none twice;
  - `scripts/Axioms.lean`: its records are the three-way merge of the sides' sets, OURS' added records renamed (REC_RENAME) and those of
    the removed copies dropped (REC_DROP), none twice; its other lines the three-way union;
  - `ARCHITECTURE.md`'s module table row by row three-way (a row changed by one side is that side's), up to ROW_EDITS;
  - the record: OURS' and THEIRS' lines each a subsequence of the merged record's, which has exactly the base's lines plus both sides'
    additions plus the join (3 lines), before any stage appended after OURS' last line.
Usage: fs131_m6_merge_check.py [BASE OURS THEIRS] [--rev MERGED] [--self-test]   (defaults 75689a4c e37e864d origin/fs131-w5; the merged
side is the working tree unless --rev names a commit). Exit 0 only on PASS. --self-test plants six faults (a byte in a THEIRS-only
module, an extra line in `Terminal`, a dropped import in `Proofs.lean`, a doubled axioms record, a reverted Imports cell, a dropped line
of the record) and requires each to FAIL naming its file, and the unplanted run to PASS.
"""
import collections
import os
import re
import subprocess
import sys
import tempfile

V = "Proofs/HadwigerNelson/Plane/ValidMap/"
P = "Proofs/HadwigerNelson/Plane/"
REC = "plans/FS131-I5-implementation.md"

HS_USE_OLD = "  have hpre := isPreconnected_hornSet_unit (v := v) (α := α) (r := r) hνν' hν.le hν' hr2\n"
HS_USE_NEW = ("  have hpre := isPreconnected_hornSet v α (r := r) hνν'\n"
              "    ((mul_le_of_le_one_left hr.le hνabs).trans_lt (by linarith))\n"
              "    ((mul_le_of_le_one_left hr.le (abs_le.mpr ⟨by linarith, hν'⟩)).trans_lt (by linarith))\n")
# file -> list of edits, applied in order to OURS' text: ("rep", old, new, count) or ("cut", START, END)
EDITS = {
    V + "HornShadow.lean": [
        ("rep", "N_add_eq_framePt", "normalPt_add_eq_fromFrame", 1), ("rep", "framePt", "fromFrame", 41),
        ("cut", "/-- **A horn with bounds in `[−1, 1]` is connected**", "/-- **The vertical drop**"),
        ("rep", "(over `isPreconnected_hornSet_unit` and", "(over `Surgery`'s `isPreconnected_hornSet` and", 1),
        ("rep", HS_USE_OLD, HS_USE_NEW, 1)],
    V + "Terminal.lean": [
        ("rep", "framePt", "fromFrame", 17),
        ("cut", "/-- **A horn whose lower arc is on `ω(S′)`, with a lower flank", "/-- **A direction of a colour's class at a point"),
        ("rep", "Hg.isRingArc_lower_ua (hvC w) hy", "Hg.isRingArc_lower (hvC w) hy", 1),
        ("rep", "(`IsHorn.isRingArc_lower_ua`)", "(`IsHorn.isRingArc_lower`)", 1)],
    V + "Limit.lean": [
        ("cut", "/-- The parametrisation of an arc: the segment's affine parameter", "/-- The parameter interval is compact."),
        ("cut", "/-- **Branch points are closure points of the sectors they bound** (FS131 wave 4's",
         "/-- **In a good ball about `x`, a chart at another point"),
        ("rep", "carrier_eq_imageL", "carrier_eq_image", 3), ("rep", "finite_ptL_eq", "finite_pt_eq", 2), ("rep", "ptL", "pt", 25),
        ("rep", "paramsL", "params", 17), ("rep", "subL", "sub", 11),
        ("rep", "import Proofs.HadwigerNelson.Plane.ValidMap.Contact\n",
         "import Proofs.HadwigerNelson.Plane.ValidMap.Contact\nimport Proofs.HadwigerNelson.Plane.ValidMap.MapTopology\n", 1),
        ("rep", "(branchPt_mem_closure_sector_pair G", "(BranchGerms.branchPt_mem_closure_sector G", 2)],
    V + "Procedure.lean": [
        ("cut", "/-- A ring arc is unchanged by whole turns of both ends. -/", "/-- A radius-two arc is unchanged"),
        ("rep", "rw [ringArc_add_int]", "rw [ringArc_add_two_pi_mul]", 1)],
}
REC_RENAME = [("framePt", "fromFrame"), ("Arc.isCompact_paramsL", "Arc.isCompact_params"),
              ("Arc.ordConnected_paramsL", "Arc.ordConnected_params"), ("Arc.finite_ptL_eq", "Arc.finite_pt_eq")]
REC_DROP = {"HadwigerNelson.Plane.isPreconnected_hornSet_unit", "HadwigerNelson.Plane.ArcMap.IsHorn.isRingArc_lower_ua",
            "HadwigerNelson.Plane.Arc.continuous_ptL", "HadwigerNelson.Plane.Arc.carrier_eq_imageL", "HadwigerNelson.Plane.Arc.carrier_subL",
            "HadwigerNelson.Plane.Arc.nondegenerate_subL", "HadwigerNelson.Plane.ArcMap.branchPt_mem_closure_sector_pair",
            "HadwigerNelson.Plane.ArcMap.ringArc_add_int"}
REC_KEEP = set()
ROW_EDITS = {
    "Plane/ValidMap/Limit": (" | `Plane/ValidMap/Chain`, `Plane/Tiles`, `Plane/ValidMap/Sectors`, `Plane/ValidMap/Contact` | ",
                             " | `Plane/ValidMap/Chain`, `Plane/Tiles`, `Plane/ValidMap/Sectors`, `Plane/ValidMap/Contact`, "
                             "`Plane/ValidMap/MapTopology` | "),
    "Plane/ValidMap/HornShadow": ("over `isPreconnected_hornSet_unit`, `exists_drop_height`",
                                  "over `Surgery`'s `isPreconnected_hornSet`, `exists_drop_height`"),
}
SPECIAL = {"Proofs.lean", "scripts/Axioms.lean", "ARCHITECTURE.md"}


def apply_edit(want, ed):
    """One declared edit; returns (text or None, failure message or None)."""
    if ed[0] == "rep":
        _, old, new, n = ed
        if want.count(old) != n:
            return None, f"declared edit's old text {old[:40]!r} occurs {want.count(old)} times, not {n}"
        return want.replace(old, new), None
    _, a, b = ed
    L = want.split("\n")
    i = [k for k, ln in enumerate(L) if ln.startswith(a)]
    j = [k for k, ln in enumerate(L) if ln.startswith(b)]
    if len(i) != 1 or len(j) != 1 or j[0] <= i[0]:
        return None, f"declared cut {a[:40]!r} .. {b[:40]!r}: start found {len(i)}, end found {len(j)}"
    return "\n".join(L[:i[0]] + L[j[0]:]), None


def is_subseq(small, big):
    it = iter(big)
    return all(any(x == y for y in it) for x in small)


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
            for ed in EDITS.get(p, []):
                want, msg = apply_edit(want, ed)
                if want is None:
                    bad.append(f"FAIL {p}: {msg}")
                    break
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
    def ren(r):
        for a_, b_ in REC_RENAME:
            r = r.replace(a_, b_)
        return r
    added_o = {ren(r) for r in ro - rb} - REC_DROP
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
    # the shared record
    rb_, ro_, rt_ = (show(base, REC).split("\n"), show(ours, REC).split("\n"), show(theirs, REC).split("\n"))
    rm_ = M[REC].split("\n")
    last = ro_[-1] if ro_[-1] else ro_[-2]
    idx = [k for k, ln in enumerate(rm_) if ln == last]
    if not idx:
        bad.append(f"FAIL {REC}: OURS' last line is missing")
    else:
        body_ = rm_[:idx[-1] + 1] + ([""] if ro_[-1] == "" else [])
        if not (is_subseq(ro_, body_) and is_subseq(rt_, body_)):
            bad.append(f"FAIL {REC}: a side's lines are not all in the merged record, in order")
        if len(body_) != len(ro_) + len(rt_) - len(rb_) + 3:
            bad.append(f"FAIL {REC}: {len(body_)} lines up to OURS' last, not base + both additions + the 3-line join "
                       f"({len(ro_) + len(rt_) - len(rb_) + 3})")
        if not any(ln.startswith("*The join (FS131-M6") for ln in body_):
            bad.append(f"FAIL {REC}: no line names the join")
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
    base, ours, theirs = a if len(a) == 3 else ("75689a4c", "e37e864d", "origin/fs131-w5")
    paths = tracked(ours) | tracked(theirs) | (tracked(rev) if rev else set(git("ls-files", "Proofs").split())) | {REC}
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
        (V + "Terminal.lean", lambda s: s + "\n-- planted\n"),
        ("Proofs.lean", lambda s: s.replace("import Proofs.HadwigerNelson.Plane.ValidMap.Moves\n", "", 1)),
        ("scripts/Axioms.lean", lambda s: s.replace("#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux\n",
                                                     "#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux\n"
                                                     "#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux\n", 1)),
        ("ARCHITECTURE.md", lambda s: s.replace(ROW_EDITS["Plane/ValidMap/Limit"][1], ROW_EDITS["Plane/ValidMap/Limit"][0], 1)),
        (REC, lambda s: s.replace("## Stage 51 — SAVED (FS131-M5): the hand-back\n", "", 1)),
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
