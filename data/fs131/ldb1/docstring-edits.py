#!/usr/bin/env python3
"""FS131-LDB1: the stale docstrings of the density bound, reworded (prose only; the brief's touches). Each edit is an exact
replacement inside a `/-! … -/` or `/-- … -/` block, its old text required to occur exactly once in its file; the script
refuses (exit 1, nothing written) otherwise. `tools/fs131_ldb1_code_only.py` then shows the files' code unchanged.
Run from the worktree's root, after the build that read the old text has ended: python3 data/fs131/ldb1/docstring-edits.py
(--dry-run: check only)."""
import sys
from pathlib import Path

D = "Proofs/HadwigerNelson/Plane/DensityBound/"
EDITS = [
    ("Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",
     "# `m₁(ℝ²) < 1/4`: the density of planar sets avoiding unit distances, as a named outside hypothesis (FS-131, job FS131-KR1; module M12's input; skeleton)",
     "# `m₁(ℝ²) < 1/4`: the density of planar sets avoiding unit distances (FS-131: the statement FS131-KR1's, its leaf FS131-IDB2's; module M12's input)"),
    ("Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",
     "(an open and a closed ball differ by a null sphere, so the limsup is the same). **An external theorem, computer-assisted, a\n"
     "named hypothesis of the library standing for it — not declared as an axiom** (the coordinator's ruling of 2026-10-14: an\n"
     "axiom is Kooshi's decision; FS131-KR1 drafts its four items in `plans/FS131-KR1-chain-map.md`).",
     "(an open and a closed ball differ by a null sphere, so the limsup is the same). **A theorem of the library**:\n"
     "`oneAvoidingDensityBound` (`Plane/DensityBound/Theorem`) proves it from the paper's certificate, checked by the kernel with no\n"
     "`native_decide` (FS131-KDB1's plan; FS131-IDB1, -IDB2 and -IDB3's proofs). It entered the library as a hypothesis of the\n"
     "theorems below, never as an axiom."),
    ("Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",
     "measurable, 1-avoiding planar set has upper density at most `0.2470`, at every centre. External: a named hypothesis standing\n"
     "for an outside theorem, not proved in the library. -/",
     "measurable, 1-avoiding planar set has upper density at most `0.2470`, at every centre. Proved in the library:\n"
     "`oneAvoidingDensityBound` (`Plane/DensityBound/Theorem`), from the paper's certificate. -/"),
    ("Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",
     "/-- `m₁(ℝ²) ≤ 0.2470`, given the outside theorem. -/",
     "/-- `m₁(ℝ²) ≤ 0.2470`, given `OneAvoidingDensityBound`, which `oneAvoidingDensityBound` proves. -/"),
    ("Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",
     "/-- **`m₁(ℝ²) < 1/4`**, given the outside theorem — the form the count reads. -/",
     "/-- **`m₁(ℝ²) < 1/4`**, given `OneAvoidingDensityBound`, which `oneAvoidingDensityBound` proves — the form the count reads. -/"),
    (D + "Autocorr.lean",
     "(FS-131, FS131-KDB1; skeleton)",
     "(FS-131: FS131-KDB1's statements, FS131-IDB2's proofs)"),
    (D + "Window.lean",
     "(FS-131, FS131-KDB1; skeleton)",
     "(FS-131: FS131-KDB1's statements, FS131-IDB2's proofs)"),
    (D + "BesselDefect.lean",
     "(FS-131, FS131-KDB1; skeleton)",
     "(FS-131: FS131-KDB1's statements, FS131-IDB1's proofs)"),
    (D + "Bessel.lean",
     "(FS-131, FS131-KDB1; skeleton)",
     "(FS-131: FS131-KDB1's statements, FS131-IDB1's proofs)"),
    (D + "Pattern.lean",
     "(FS-131, FS131-KDB1; skeleton)",
     "(FS-131: FS131-KDB1's statements, FS131-IDB2's proofs)"),
]


def main():
    dry = "--dry-run" in sys.argv
    texts = {}
    bad = []
    for f, old, new in EDITS:
        t = texts.setdefault(f, Path(f).read_text())
        n = t.count(old)
        if n != 1:
            bad.append(f"{f}: the old text occurs {n} times: {old[:60]!r}")
            continue
        texts[f] = t.replace(old, new)
    for f, t in texts.items():
        for w in ("named hypothesis", "outside the backlog", "External", "external", "skeleton"):
            if w in t and "OneAvoidingDensity" in f:
                bad.append(f"{f}: still says {w!r}")
    if bad:
        print("\n".join("REFUSED " + b for b in bad))
        return 1
    for f, t in texts.items():
        print(f"{'would edit' if dry else 'edited'} {f}: {sum(1 for e in EDITS if e[0] == f)} replacement(s)")
        if not dry:
            Path(f).write_text(t)
    return 0


if __name__ == "__main__":
    sys.exit(main())
