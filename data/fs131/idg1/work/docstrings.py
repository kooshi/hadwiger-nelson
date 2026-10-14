#!/usr/bin/env python3
"""FS131-IDG1 — the stale module docstrings FS131-IN1L's record names (§ Drafts for the landing, "Module docstrings now
stale"), rewritten in prose only. Each replacement must match exactly once inside the module docstring (the first
`/-! … -/` block) of its file; the script refuses otherwise and writes nothing. Run from the worktree:
  python3 -I data/fs131/idg1/work/docstrings.py
"""
import pathlib
import sys

R = pathlib.Path("Proofs/HadwigerNelson/Rigidity")
EDITS = {
    "ChainAtTA.lean": [
        ("(FS-131, jobs FS131-KN3 and FS131-KN6; skeleton)",
         "(FS-131, jobs FS131-KN3 and FS131-KN6; lane C proved by FS131-IN1L; three leaves `sorry`)"),
        ("""**Leaves (`sorry`), each a module of the architecture in `plans/FS131-KN3-chain-plan.md`:** `measurableSet_TA`,
`rot_preimage_TA`, `exists_nonTorsion_unitVector` (module C0); `entropySplit` (PE-2 at one non-torsion rotation: modules
M5–M7); `zeroEntropyCarried` (EF_F⁺: module M8).""",
         """**Proved by FS131-IN1L** (module C0): `measurableSet_TA`, `rot_preimage_TA`, `exists_nonTorsion_unitVector`.
**Leaves (`sorry`), each a module of the architecture in `plans/FS131-KN3-chain-plan.md`:** `entropySplit` (PE-2 at one
non-torsion rotation: modules M5–M7); `zeroEntropyCarried` (EF_F⁺: module M8)."""),
        ("""**Inhabitants.** `one_mem_TA`. `MRPlus`,""",
         """**Inhabitants.** `one_mem_TA`; `zeroEntropyCarried_model` (the point mass at the trivial character meets every
hypothesis of `ZeroEntropyCarried`'s clause, and its conclusion, at every non-torsion vector). `MRPlus`,"""),
    ],
    "HaarMultiple.lean": [
        ("(FS-131, job FS131-KN7; skeleton)", "(FS-131, job FS131-KN7; proved by FS131-IN1L)"),
    ],
    "SolenoidErgodic.lean": [
        ("(FS-131, job FS131-KN7; skeleton)", "(FS-131, job FS131-KN7; proved by FS131-IN1L)"),
    ],
    "ZeroEntropyNames.lean": [
        ("(FS-131, job FS131-KN7; skeleton)", "(FS-131, job FS131-KN7; proved by FS131-IN1L)"),
        ("""It is stated
here under a name of this library because lane P's port (`Outside/OAI015Maximal`, on another branch) is not yet joined;
at the join its proof is that theorem, and the statement is not changed (FS131-KN7, § Stage 5).""",
         """It is stated
here under a name of this library, and its proof is that theorem of the port (`Outside/OAI015Maximal`,
`Outside.OAI015.excessiveOccupation_measure_bound`), joined by FS131-IN1L with the statement not changed."""),
    ],
}


def main():
    out = {}
    for f, reps in EDITS.items():
        p = R / f
        s = p.read_text()
        i, j = s.index("/-!"), s.index("-/", s.index("/-!"))
        doc = s[i:j]
        for a, b in reps:
            if doc.count(a) != 1:
                print(f"REFUSED: {f}: the passage occurs {doc.count(a)} times in the module docstring: {a[:70]!r}")
                sys.exit(1)
            doc = doc.replace(a, b)
        out[p] = s[:i] + doc + s[j:]
    for p, s in out.items():
        p.write_text(s)
        print(f"rewritten: {p}")


if __name__ == "__main__":
    main()
