#!/usr/bin/env python3
"""FS132-L1: the import's block of `scripts/Axioms.lean` — every record's axiom SET as filed, with two controls.

The check itself is the import's (`tools/fs132_i1_axioms.py`, run unedited: it reads the block out of the
`scripts/Axioms.lean` that ships and refuses a record whose axioms are not exactly its group's). This tool drives it on
the module as built and on two altered copies of the module's own text — made here by exact replacement, each
replacement asserted to have happened — so that the controls are of the module as it stands at the landing, with the
landing's theorem in it:

  module    the built module, imported: every record as filed (exit 0)
  wrong     a WRONG FILING, planted twice in one copy: `six_le_chiM0` proved through the collapse (the import's own
            plant — then it and `chiM0_six_or_seven` carry both imports), and `seven_le_chromaticNumber_plane_iff`
            given `six_le_chiM0` as an idle step (then it carries both). Exactly those three must be refused.
  sorry     `direction_coe`'s proof replaced by `sorry`: exactly the records above it must be refused — the ten the
            import's control named and the landing's theorem, eleven.

Usage (from the worktree's root, after the build):  tools/fs132_l1_block.py OUTDIR TAG
Writes OUTDIR/block-{module,wrong,sorry}-TAG.{lean,out,check}; exit 0 only if all three behave.
"""
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
MODULE = REPO / "Proofs/HadwigerNelson/Outside/OAI158.lean"
SLOT = "/home/kooshi/source/lean-dir/scripts/slot.py"
I1 = str(REPO / "tools/fs132_i1_axioms.py")

WRONG = [
    ("  rw [chromaticNumber_plane_eq_complex] at h\n  exact h.trans Plane.chromaticNumber_plane_le_chiM0\n",
     "  rw [chromaticNumber_plane_eq_complex, chromaticNumber_plane_eq_chiM0] at h\n  exact h\n"),
    ("  rw [chromaticNumber_plane_eq_chiM0]; exact Plane.seven_le_chiM0_iff\n",
     "  have _h6 := six_le_chiM0\n  rw [chromaticNumber_plane_eq_chiM0]; exact Plane.seven_le_chiM0_iff\n"),
]
SORRY = [
    ("  have h : 2 * Real.pi / (2 * Real.pi) * θ = θ := by\n    rw [div_self (by positivity), one_mul]\n"
     "  rw [direction, AddCircle.toCircle_apply_mk, h, Circle.coe_exp, Plane.e]\n",
     "  sorry\n"),
]
EXPECT_WRONG = "six_le_chiM0,chiM0_six_or_seven,seven_le_chromaticNumber_plane_iff"
EXPECT_SORRY = ("nonempty_aeColouring_of_colorable,colorable_iff_nonempty_aeColouring,chiM0_le_chromaticNumber_plane,"
                "chromaticNumber_plane_eq_chiM0,seven_le_chromaticNumber_plane_iff,direction_coe,"
                "weakColoring_iff_unitPairsNull,nonempty_aeColouring_of_weak,weakColoring_of_aeColouring,"
                "exists_weakColoring_iff_nonempty_aeColouring,proper_to_borel_weak_model")


def altered(text, repls):
    for old, new in repls:
        if text.count(old) != 1:
            raise SystemExit(f"PLANT NOT MADE: the text to replace occurs {text.count(old)} time(s), not once:\n{old}")
        text = text.replace(old, new)
    return text


def run(cmd, out):
    with open(out, "w", encoding="utf-8") as f:
        return subprocess.run(cmd, stdout=f, stderr=subprocess.STDOUT, cwd=REPO).returncode


def one(outdir, tag, name, inline_text, expect):
    base = outdir / f"block-{name}-{tag}"
    if inline_text is None:
        lean = subprocess.run([sys.executable, I1, "emit"], capture_output=True, text=True, cwd=REPO).stdout
    else:
        src = base.with_suffix(".src.lean")
        src.write_text(inline_text, encoding="utf-8")
        lean = subprocess.run([sys.executable, I1, "emit", "--inline", str(src)], capture_output=True, text=True, cwd=REPO).stdout
        src.unlink()
    base.with_suffix(".lean").write_text(lean, encoding="utf-8")
    # an altered copy does not elaborate cleanly as a file (the `sorry` warns; the copy re-declares nothing the
    # library imports, since it is the module's own text in place of the import) — lean's exit is recorded, not required
    st_lean = run([SLOT, "--mem", "16", "--cpus", "2", "--", "lake", "env", "lean",
                   "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", str(base.with_suffix(".lean"))],
                  base.with_suffix(".out"))
    cmd = [sys.executable, I1, "check", str(base.with_suffix(".out"))]
    if expect:
        cmd += ["--expect-fail", expect]
    st = run(cmd, base.with_suffix(".check"))
    last = base.with_suffix(".check").read_text(encoding="utf-8").strip().splitlines()[-2:]
    print(f"{name}: lean exit {st_lean}; check exit {st} — " + " | ".join(last))
    return st == 0


def main(argv):
    if len(argv) != 2:
        print(__doc__)
        return 2
    outdir, tag = Path(argv[0]), argv[1]
    outdir.mkdir(parents=True, exist_ok=True)
    text = MODULE.read_text(encoding="utf-8")
    ok = one(outdir, tag, "module", None, None)
    ok = one(outdir, tag, "wrong", altered(text, WRONG), EXPECT_WRONG) and ok
    ok = one(outdir, tag, "sorry", altered(text, SORRY), EXPECT_SORRY) and ok
    # the plain check of each altered copy must be RED (the control read without its expectation)
    for name in ("wrong", "sorry"):
        st = subprocess.run([sys.executable, I1, "check", str(outdir / f"block-{name}-{tag}.out")],
                            capture_output=True, text=True, cwd=REPO).returncode
        print(f"{name}, read as a plain check: exit {st} ({'red, as it must be' if st == 1 else 'NOT RED'})")
        ok = ok and st == 1
    print("block:", "PASS — every record as filed; both controls fired" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
