#!/usr/bin/env python3
"""FS131-IG1 — the stale docstrings and `ARCHITECTURE.md` rows that FS131-IDG1's record names (§ Drafts for the landing:
"`ARCHITECTURE.md` § 3, the rows of my six modules" and "Module and theorem docstrings now stale"), rewritten in prose
only. A module-docstring passage must occur exactly once inside the module docstring (the first `/-! … -/` block); the one
theorem-docstring passage (`measure_frequentVisits_le`) exactly once inside a `/-- … -/` block; an architecture passage
exactly once inside its module's row. The script refuses otherwise and writes nothing. Run from the worktree:
  python3 -I data/fs131/ig1/work/docstrings.py
"""
import pathlib
import re
import sys

R = pathlib.Path("Proofs/HadwigerNelson/Rigidity")
MODDOC = {
    "DualGroup.lean": [("module M4 of `plans/FS131-KN3-chain-plan.md`; skeleton)",
                        "module M4 of `plans/FS131-KN3-chain-plan.md`; proved by FS131-IDG1)")],
    "Annihilator.lean": [("(FS-131, job FS131-KPD1; skeleton)", "(FS-131, job FS131-KPD1; proved by FS131-IDG1)"),
                         ("""Pontryagin duality** (`Rigidity/Duality`), not proved here.""",
                          """Pontryagin duality** (`Rigidity/Duality`, `dualAnnihilator_dualCoannihilator_of_isClosed`), proved there.""")],
    "SubgroupHaar.lean": [("(FS-131, job FS131-KPD1; skeleton)", "(FS-131, job FS131-KPD1; proved by FS131-IDG1)")],
    "Duality.lean": [("(FS-131, job FS131-KPD1; skeleton)", "(FS-131, job FS131-KPD1; proved by FS131-IDG1)")],
    "DualConnected.lean": [("(FS-131, job FS131-KPD1; skeleton)", "(FS-131, job FS131-KPD1; proved by FS131-IDG1)")],
    "UnitCircle.lean": [("the vocabulary of modules M6 and M7b; skeleton)",
                         "the vocabulary of modules M6 and M7b; proved by FS131-IDG1 but `exists_admissiblePair`)")],
}
THMDOC = {
    "ZeroEntropyNames.lean": [("""stated under this library's name
until lane P's port is joined; its proof is then that theorem (module docstring).""",
                               """stated under this library's name;
its proof is the port's `Outside.OAI015.excessiveOccupation_measure_bound` (module docstring).""")],
}
ARCH = {
    "Rigidity/DualGroup": [("**FS-131 (FS131-KN8), skeleton: 13 leaves `sorry`.**",
                            "**FS-131 (FS131-KN8, proved by FS131-IDG1): no `sorry`.**")],
    "Rigidity/Annihilator": [("**FS-131 (FS131-KPD1), skeleton: 8 leaves `sorry`.**",
                              "**FS-131 (FS131-KPD1, proved by FS131-IDG1): no `sorry`.**"),
                             ("**Leaves:**", "**Proved (FS131-IDG1):**"),
                             ("`dualCoannihilator_top` (separation), `isClosed_dualAnnihilator`",
                              "`dualCoannihilator_top` (separation), `isClosed_setOf_apply_eq_one`, `isClosed_dualAnnihilator`")],
    "Rigidity/SubgroupHaar": [("**FS-131 (FS131-KPD1), skeleton: 6 leaves `sorry`.**",
                               "**FS-131 (FS131-KPD1, proved by FS131-IDG1): no `sorry`.**"),
                              ("**Leaves:**", "**Proved (FS131-IDG1):**")],
    "Rigidity/Duality": [("**FS-131 (FS131-KPD1), skeleton: 9 leaves `sorry`.**",
                          "**FS-131 (FS131-KPD1, proved by FS131-IDG1): no `sorry`.**"),
                         ("**Leaves:**", "**Proved (FS131-IDG1):**")],
    "Rigidity/DualConnected": [("**FS-131 (FS131-KPD1), skeleton: 4 leaves `sorry`.**",
                                "**FS-131 (FS131-KPD1, proved by FS131-IDG1): no `sorry`.**"),
                               ("**Leaves:** all four.", "**Proved (FS131-IDG1):** all four.")],
    "Rigidity/UnitCircle": [("**FS-131 (FS131-KN8), skeleton: 8 leaves `sorry`.**",
                             "**FS-131 (FS131-KN8; proved by FS131-IDG1 but lane A's `exists_admissiblePair`), skeleton: 1 leaf `sorry`.**")],
}


def refuse(msg):
    print("REFUSED: " + msg)
    sys.exit(1)


def main():
    out = {}
    for f, reps in MODDOC.items():
        p = R / f
        s = out.get(p, p.read_text())
        i = s.index("/-!")
        j = s.index("-/", i)
        doc = s[i:j]
        for a, b in reps:
            if doc.count(a) != 1:
                refuse(f"{f}: occurs {doc.count(a)} times in the module docstring: {a[:70]!r}")
            doc = doc.replace(a, b)
        out[p] = s[:i] + doc + s[j:]
    for f, reps in THMDOC.items():
        p = R / f
        s = out.get(p, p.read_text())
        for a, b in reps:
            blocks = [m for m in re.finditer(r"/--.*?-/", s, flags=re.S) if a in m.group(0)]
            if len(blocks) != 1 or s.count(a) != 1:
                refuse(f"{f}: occurs in {len(blocks)} docstrings, {s.count(a)} times in the file: {a[:70]!r}")
            s = s.replace(a, b)
        out[p] = s
    arch = pathlib.Path("ARCHITECTURE.md")
    t = arch.read_text()
    lines = t.split("\n")
    for mod, reps in ARCH.items():
        idx = [k for k, ln in enumerate(lines) if ln.startswith(f"| `{mod}` |")]
        if len(idx) != 1:
            refuse(f"ARCHITECTURE.md: {len(idx)} rows for {mod}")
        ln = lines[idx[0]]
        for a, b in reps:
            if ln.count(a) != 1:
                refuse(f"ARCHITECTURE.md row {mod}: occurs {ln.count(a)} times: {a[:70]!r}")
            ln = ln.replace(a, b)
        lines[idx[0]] = ln
    out[arch] = "\n".join(lines)
    for p, s in out.items():
        p.write_text(s)
        print(f"rewritten: {p}")


if __name__ == "__main__":
    main()
