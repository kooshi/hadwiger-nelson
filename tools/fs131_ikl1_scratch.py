#!/usr/bin/env python3
"""FS131-IKL1: the scratch copy of `Rigidity/ClassRatio` whose leaf `ratioAtMost_cert` reads the certificate link.

Writes `data/fs131/ikl1/scratch/root/Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` from the tree's
`Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (never edited) by four insertions, each asserted to apply exactly once:

  1. `import Proofs.HadwigerNelson.Rigidity.CertLink` after the last import line;
  2. `scratch/standin19.lean.txt` before `namespace HadwigerNelson.Rigidity` (FS131-IKC4's `sum_le_nineteen` as a
     `sorry` with the statement the coordinator printed; scratch only);
  3. `scratch/discharge.lean.txt` (the two lemmas the landing adds) before the docstring of `ratioAtMost_cert`;
  4. the body `sorry` of `ratioAtMost_cert` replaced by `scratch/oneline.lean.txt` (the landing's one line);

and appends `scratch/footer.lean.txt` (the axioms and the leaves each `sorryAx` comes from, for the consumers).

--wcm4 reads M13's dyadic line's `ClassRatio` (`scratch/ClassRatio-wcm4.lean`, `git show fs131-wcm4:…` at ff3ac0c73)
and `scratch/discharge-wcm4.lean.txt` (the same two lemmas against that file's names), and writes to `scratch/root4/…`.

--plant leaves step 4 out (the body stays `sorry`) and writes the copy to `scratch/root-plant/…`: the footer must then
name `ratioAtMost_cert` itself among the leaves (the control, read by hand from the two runs' outputs).
The written copy's sha256 and the source's are printed.
"""
import hashlib
import sys
from pathlib import Path

TREE = Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1")
SRC = TREE / "Proofs/HadwigerNelson/Rigidity/ClassRatio.lean"
SCR = TREE / "data/fs131/ikl1/scratch"

LEAF_DOC = "/-- **The certificate branch at `q ∈ {11, 19}`**"
LEAF_BODY = """    ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  sorry
"""


def once(s, old, new, what):
    n = s.count(old)
    if n != 1:
        print(f"FAIL: {what}: {n} matches")
        sys.exit(1)
    return s.replace(old, new)


def main(plant, wcm4):
    src = SCR / "ClassRatio-wcm4.lean" if wcm4 else SRC
    s = src.read_text()
    lines = s.split("\n")
    last_import = max(i for i, l in enumerate(lines) if l.startswith("import "))
    lines.insert(last_import + 1, "import Proofs.HadwigerNelson.Rigidity.CertLink")
    s = "\n".join(lines)
    s = once(s, "namespace HadwigerNelson.Rigidity\n",
             (SCR / "standin19.lean.txt").read_text() + "\nnamespace HadwigerNelson.Rigidity\n", "namespace")
    dis = SCR / ("discharge-wcm4.lean.txt" if wcm4 else "discharge.lean.txt")
    s = once(s, LEAF_DOC, dis.read_text() + "\n" + LEAF_DOC, "leaf docstring")
    if not plant:
        s = once(s, LEAF_BODY, "    ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c :=\n" + (SCR / "oneline.lean.txt").read_text(),
                 "leaf body")
    else:
        once(s, LEAF_BODY, LEAF_BODY, "leaf body (plant: kept)")
    s = s.rstrip("\n") + "\n\n" + (SCR / "footer.lean.txt").read_text()
    root = SCR / (("root4" if wcm4 else "root") + ("-plant" if plant else ""))
    out = root / "Proofs/HadwigerNelson/Rigidity/ClassRatio.lean"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(s)
    print("source ", hashlib.sha256(src.read_bytes()).hexdigest(), src)
    print("written", hashlib.sha256(out.read_bytes()).hexdigest(), out)


if __name__ == "__main__":
    main("--plant" in sys.argv, "--wcm4" in sys.argv)
