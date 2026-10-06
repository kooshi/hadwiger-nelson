#!/usr/bin/env python3
"""FS131-L6A: the ruled tidies have exactly the ruled shape (the brief's item 3).

  tools/fs131_l6a_tidyshape.py [--self-test] <ref>

<ref> is the commit before the tidies (Stage 2's tip). Checked, in the working tree against <ref>:

 (a) SHAPE    the two deleted lemmas of `FanBridge` at <ref> — `polarRegion_isOpen`, `polarRegion_isPreconnected` — have,
              the name alone substituted, the statements of `FanBuild`'s `isOpen_polarRegion`,
              `isPreconnected_polarRegion` (text from `theorem` to the first ` :=`, whitespace collapsed): the same
              statements binder for binder;
 (b) OLD-NAME neither old name occurs anywhere under `Proofs/`, in `scripts/Axioms.lean` or in `ARCHITECTURE.md`;
 (c) USES     outside the deleted block, the non-comment code lines of `FanBridge` that differ from <ref> are exactly
              three, each <ref>'s line with one old name replaced by the new one, in the declarations
              `isOpen_cell`, `isPreconnected_polarRegion_of_le`, `exists_isOpen_subset_cells`;
 (d) CODE     no other Lean file of the fourteen has a changed line outside a `/-- … -/` or `/-! … -/` block;
 (e) RECORDS  `scripts/Axioms.lean`'s `#print axioms` names changed by: the two old names removed; FS131-I6C's six and
              FS131-I6E's fourteen added; nothing else — and each added name stands in its own job's block.

Exit 0 iff all hold. --self-test also plants, on copies: a use left on the old name (OLD-NAME), a binder of a deleted
lemma's statement changed at the comparison (SHAPE), a proof line changed in another file (CODE), a record added that
no report lists (RECORDS); each must fail with its word.
"""
import difflib
import os
import re
import subprocess
import sys

DIR = "Proofs/HadwigerNelson/Plane/Saturated/"
P = "HadwigerNelson.Plane."
PAIRS = [("polarRegion_isOpen", "isOpen_polarRegion"), ("polarRegion_isPreconnected", "isPreconnected_polarRegion")]
USE_DECLS = ["isOpen_cell", "isPreconnected_polarRegion_of_le", "exists_isOpen_subset_cells"]
I6C = [P + n for n in ("HasTwoDiscsAt.one_le_norm_sub", "HasTwoDiscsAt.norm_sub_le", "HasTwoDiscsAt.normal_unique", "local_graph",
                       "AeColouring.local_graph", "sq9_exists_isInterfaceChart")]
I6E = [P + "AeColouring.Fan." + n for n in (
    "exists_unitCurve_branch", "exists_twoColourNhd_branch", "dist_eq_one_of_common_contact", "contacts_of_no_common",
    "branch_outside_discs", "branch_contacts", "exists_contact_nextDir", "exists_contact_dir", "sector_constraints",
    "horn_false", "false_of_horn_next", "false_of_horn_dir", "sector_alone", "sector_unique")]


def show(ref, path):
    r = subprocess.run(["git", "show", f"{ref}:{path}"], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else ""


def stmt(text, name):
    m = re.search(r"^theorem " + re.escape(name) + r"\b(.*?) :=", text, re.S | re.M)
    return None if not m else " ".join(m.group(1).split())


def code_lines(text):
    """[(line, enclosing declaration's short name)] for lines outside doc comments and module docs."""
    out, depth, decl = [], False, ""
    for ln in text.split("\n"):
        s = ln.strip()
        if depth:
            if "-/" in ln:
                depth = False
            continue
        if s.startswith("/-") and "-/" not in s:
            depth = True
            continue
        if s.startswith("/-") and s.endswith("-/"):
            continue
        m = re.match(r"^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable )*(?:theorem|def|lemma|abbrev|instance|structure)\s+(\S+)", ln)
        if m:
            decl = m.group(1)
        out.append((ln, decl))
    return out


def check(ref, read=None, old_fb=None, label="check"):
    """read(path) -> text of the working tree (overridable for plants); old_fb overrides <ref>'s FanBridge."""
    read = read or (lambda p: open(p, encoding="utf-8").read())
    faults = []
    fb_old = old_fb if old_fb is not None else show(ref, DIR + "FanBridge.lean")
    fb_new, build = read(DIR + "FanBridge.lean"), read(DIR + "FanBuild.lean")
    for old, new in PAIRS:                                                        # (a)
        a, b = stmt(fb_old, old), stmt(build, new)
        if a is None or b is None or a != b:
            faults.append(f"SHAPE {old} against {new}: {a!r} / {b!r}")
    files = sorted(f for f in os.listdir(DIR) if f.endswith(".lean"))
    for old, _ in PAIRS:                                                          # (b)
        for path in [DIR + f for f in files] + ["scripts/Axioms.lean", "ARCHITECTURE.md"]:
            if re.search(r"\b" + old + r"\b", read(path)):
                faults.append(f"OLD-NAME {old} in {path}")
    a = fb_old.index("/-- **A polar region between two continuous graphs is open.** -/")       # (c)
    b = fb_old.index("/-- A polar point a full turn on is the same point. -/")
    kept = fb_old[:a] + fb_old[b:]
    co, cn = code_lines(kept), code_lines(fb_new)
    changed = []
    sm = difflib.SequenceMatcher(None, [l for l, _ in co], [l for l, _ in cn], autojunk=False)
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal":
            continue
        if tag != "replace" or i2 - i1 != j2 - j1:
            faults.append(f"USES a code change in FanBridge that is not a line-for-line replacement ({tag} {i1}:{i2} -> {j1}:{j2})")
            continue
        for k in range(i2 - i1):
            changed.append((co[i1 + k][0], cn[j1 + k][0], cn[j1 + k][1]))
    for o, n, d in changed:
        ok = any(o.replace(x, y) == n and o.count(x) == 1 for x, y in PAIRS)
        if not ok:
            faults.append(f"USES a changed line that is not the rename: {o.strip()[:70]!r} -> {n.strip()[:70]!r}")
    if sorted(d for _, _, d in changed) != sorted(USE_DECLS):
        faults.append(f"USES the changed lines are in {sorted(d for _, _, d in changed)}, expected {sorted(USE_DECLS)}")
    for f in files:                                                               # (d)
        if f == "FanBridge.lean":
            continue
        o, n = [l for l, _ in code_lines(show(ref, DIR + f))], [l for l, _ in code_lines(read(DIR + f))]
        if o != n:
            faults.append(f"CODE {f}: a line outside its doc comments differs from {ref}")
    recs = lambda t: [l.split()[2] for l in t.split("\n") if l.startswith("#print axioms ")]   # (e)
    ax_new = read("scripts/Axioms.lean")
    ro, rn = recs(show(ref, "scripts/Axioms.lean")), recs(ax_new)
    gone, added = sorted(set(ro) - set(rn)), sorted(set(rn) - set(ro))
    if gone != sorted(P + o for o, _ in PAIRS):
        faults.append(f"RECORDS removed {gone}")
    if added != sorted(I6C + I6E):
        faults.append(f"RECORDS added, not the reports' twenty: {sorted(set(added) ^ set(I6C + I6E))}")
    if len(rn) != len(set(rn)):
        faults.append("RECORDS a name printed twice")
    for job, names in (("FS131-I6C", I6C), ("FS131-I6E", I6E)):
        m = re.search(r"^/-! ## " + job + r" .*?(?=^/-! ## |^#eval IO\.println)", ax_new, re.S | re.M)
        blk = m.group(0) if m else ""
        for nm in names:
            if f"#print axioms {nm}\n" not in blk:
                faults.append(f"RECORDS {nm} is not in block {job}")
    print(f"{label}: statements compared {len(PAIRS)}; FanBridge code lines changed {len(changed)} "
          f"(in {sorted(d for _, _, d in changed)}); records {len(ro)} -> {len(rn)} (-{len(gone)}, +{len(added)}); faults {len(faults)}")
    for f in faults:
        print("  " + f)
    return faults


def main(argv):
    args = [a for a in argv if not a.startswith("--")]
    if len(args) != 1:
        print(__doc__)
        return 2
    ref = args[0]
    faults = check(ref)
    if "--self-test" not in argv:
        print("tidy shape: PASS" if not faults else "tidy shape: FAIL")
        return 1 if faults else 0
    ok = not faults
    real = lambda p: open(p, encoding="utf-8").read()

    def with_edit(path, fn):
        return lambda p: fn(real(p)) if p == path else real(p)
    fb = DIR + "FanBridge.lean"
    plants = [
        ("OLD-NAME", "a use left on the old name",
         dict(read=with_edit(fb, lambda t: t.replace("isOpen_polarRegion z hlo", "polarRegion_isOpen z hlo", 1)))),
        ("SHAPE", "a binder of a deleted lemma changed at the comparison",
         dict(old_fb=show(ref, fb).replace("theorem polarRegion_isOpen (z : ℂ) {r : ℝ}", "theorem polarRegion_isOpen (z : ℂ) (r : ℝ)", 1))),
        ("CODE", "a proof line changed in another file",
         dict(read=with_edit(DIR + "FanBuild.lean", lambda t: t.replace("  rw [isOpen_iff_mem_nhds]", "  rw [isOpen_iff_mem_nhds] ", 1)))),
        ("RECORDS", "a record no report lists",
         dict(read=with_edit("scripts/Axioms.lean", lambda t: t.replace(
             "#print axioms " + I6C[0] + "\n", "#print axioms " + I6C[0] + "\n#print axioms " + P + "zz_planted\n", 1)))),
    ]
    for word, what, kw in plants:
        fl = check(ref, label=f"plant ({what})", **kw)
        fired = any(f.startswith(word) for f in fl)
        print(f"  -> {'fired' if fired else 'DID NOT FIRE'} ({word})")
        ok = ok and fired
    print("self-test: PASS" if ok else "self-test: FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
