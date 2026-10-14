#!/usr/bin/env python3
"""FS133-LD1 (FS131-LP1's data/fs131/lp1/drafts-slots.py with this landing's slots): every draft's slot — the exact
words a draft replaces or follows — occurs exactly once in its file.  Reads each file as `git show <ref>:<file>`
(default ref `HEAD`: this branch, which holds `main`'s front files unchanged and the module's `ARCHITECTURE.md` rows
the filing edits), whitespace-normalised.  The last entry is the control: a string that must be absent, reported as
such; exit 1 if any real slot does not occur exactly once or the control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

C, N, A, B, F = "CLAUDE.md", "LEAN.md", "ARCHITECTURE.md", "BIBLIOGRAPHY.md", "tools/claude_md_fact_audit.py"
L, S, T = "LEDGER.md", "plans/FRONTIER-STUBS.md", "plans/STUB-one-class-transfer.md"
FS133 = ("**Derived 2026-10-07: FS-133, the one-class transfer** (`plans/FS133-E1-derivation.md`, 13 entries, each derived, "
         "one mind; stub `plans/STUB-one-class-transfer.md`; a short milestone, unranked — it bears none on six against seven): "
         "`α₁(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²)` with no hypothesis, over `[OAIMath2026]`'s rigidity theorem "
         "(row 129); Closed when its Lean module passes the gate.")
SLOTS = [
    ("1 the audit's sentence", C, "the current audit reads 8961 clean and 5 declared purchases, and 26 imported (and 32 axiom-free; 9,024 records at the landing of the port of `[OAIMath2026]`'s transfer proof, FS131-LP1, 2026-10-14)"),
    ("1b the trust ledger, the sentence it follows", C, "its first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1."),
    ("2 the vacuity counts", C, "`declarations=17785 refutations-skipped=232 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`."),
    ("3 the nine counts (unchanged; the slot is read, not replaced)", C, "`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`"),
    ("4 the Frontier's Last filed", C, "Last filed: **the landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1, 2026-10-14:"),
    ("5 open milestones, FS-133", C, FS133),
    ("6 publication, held so far", C, "with no hypothesis, over `[OAIMath2026]`'s rigidity theorem, row 129 (FS-133; one mind) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's equality question."),
    ("7 the aim, the program", C, "on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133, the one-class transfer**;"),
    ("8 what the kernel holds, the sentence it follows", C, "The lower bound of four against every colouring, the three-colour criterion and the clause for subfields are this project's, with every kernel proof;"),
    ("9 LEDGER row 129, its grade", L, "the plane's clause since FS-133 not MR's: C133-ONE [hand], one mind, kernel pending, over `[OAIMath2026]` Theorem 2.3 (kernel-checked in the release's library, audited: `plans/EXT-OAI1-audit.md`)"),
    ("10a FRONTIER-STUBS, open milestones, FS-133", S, FS133),
    ("10b FRONTIER-STUBS, the closed list's head", S, "## Closed, absorbed and demoted"),
    ("10c the stub's banner", T, "> **Derived 2026-10-07 (FS133-E1; FS-133 inventory item 3).** All four posed claims are derived, [hand], one mind, kernel pending: `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)` with no hypothesis of this project's, over `[OAIMath2026]` family 158's rigidity theorem read itself (the import's third outside theorem when it is formalized). The derivation file is `plans/FS133-E1-derivation.md`; row 129 carries it. Prior art: not found at two passes on 2026-10-07 that lacked zbMATH. Closed when its Lean module passes the gate."),
    ("11a ARCHITECTURE § Trust, residual_fourier's row (its head)", A, "| `Outside.OAI158.Spectral.residual_fourier` (`Outside/OAI158Rigidity`) | `[OAIMath2026]` family 158, `lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean` line 403 at commit `adc7f124`"),
    ("11b ARCHITECTURE § Trust, the sentence it follows", A, "is a theorem since FS131-IF1 — `falconer_lemma2_nonempty`, proved in `Plane/MetricalBoundary` — and is no longer in this table."),
    ("11c the row of Outside/OAI158Rigidity (its head)", A, "| `Outside/OAI158Rigidity` | **FS-133 (planned by FS133-K1, proved by FS133-IA1; no `sorry`). One imported outside theorem**"),
    ("11d the row of SectionDensity (its lead)", A, "| `Plane/OneClass/SectionDensity` | **FS-133 (FS133-K1; a skeleton).**"),
    ("11e the row of Defs (its lead)", A, "| `Plane/OneClass/Defs` | **FS-133 (FS133-K1; a skeleton).**"),
    ("11f the row of Field (its lead)", A, "| `Plane/OneClass/Field` | **FS-133 (FS133-K1 the statement, FS133-IA1 the proof; no `sorry`), on the imported `Spectral.residual_fourier`.**"),
    ("11g the row of InvariantLaw (its lead)", A, "| `Plane/OneClass/InvariantLaw` | **FS-133 (FS133-K1; a skeleton).**"),
    ("11h the row of Algebraic (its lead)", A, "| `Plane/OneClass/Algebraic` | **FS-133 (FS133-K1; a skeleton), on the imported `Spectral.residual_fourier`.**"),
    ("11i the row of Fractional (its lead)", A, "| `Plane/OneClass/Fractional` | **FS-133 (FS133-K1; a skeleton), on the imported `Spectral.residual_fourier`.**"),
    ("11j the row of Pair (its lead)", A, "| `Plane/OneClass/Pair` | **FS-133 (FS133-K1; a skeleton), on the imported `Spectral.residual_fourier`.**"),
    ("11k Algebraic's row, A2's name", A, "**C133-ALG** `IsInvariantLaw.measure_zero_le_mOne`"),
    ("11l InvariantLaw's row, its first lemma's name", A, "C133-INV-CLASS: `IsShiftInvariantLaw.measure_zero_le` (any graph)"),
    ("12a LEAN.md § Assumptions, the sentence FS133-IA1's D5 follows", N, "the landing runs it again on the module as recompiled on the joined tree."),
    ("12b LEAN.md § Searching — Lean, the last bullet's end", N, "and the linter's name must be declared where the attribute is elaborated (`data/fs131/lp1/nolint/probes/attrs.lean`; FS131-LP1)."),
    ("13 GATE_CHANGES, the entry it follows", F, '(("7531", "5"), ("8961", "5")):'),
    ("14 BIBLIOGRAPHY, the release's row, the clause it follows", B, "is the release's theorem with its proof ported since FS131-IPD1's switch and FS131-LP1's landing, and its twelve records are clean;"),
    ("CONTROL (must be absent)", C, "the current audit reads 8961 clean and 5 declared purchases, zz"),
]


def norm(s):
    return re.sub(r"\s+", " ", s)


ref = sys.argv[1] if len(sys.argv) > 1 else "HEAD"
texts, bad = {}, 0
for name, f, slot in SLOTS:
    if f not in texts:
        texts[f] = norm(subprocess.run(["git", "show", f"{ref}:{f}"], capture_output=True, text=True, check=True).stdout)
    n = texts[f].count(norm(slot))
    control = name.startswith("CONTROL")
    good = (n == 0) if control else (n == 1)
    bad += not good
    print(f"{'ok  ' if good else 'FAIL'}  {n}  {name}  ({f})")
print(f"slots: {len(SLOTS) - 1} checked on {ref}, control absent: {'yes' if texts[C].count(norm(SLOTS[-1][2])) == 0 else 'NO'}; "
      + ("SLOTS OK" if not bad else f"SLOTS FAILED ({bad})"))
sys.exit(1 if bad else 0)
