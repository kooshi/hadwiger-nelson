#!/usr/bin/env python3
"""FS131-LDB1 (FS133-LD1's data/fs133/ld1/drafts-slots.py with this landing's slots): every draft's slot — the exact
words a draft replaces or follows — occurs exactly once in its file.  Reads each file as `git show <ref>:<file>`
(default ref `main`: the drafts are filed on `main`, and this branch holds `main`'s front files unchanged but for the
one `ARCHITECTURE.md` imports cell the gate required, which the slots of draft 9 read on this branch, `HEAD`),
whitespace-normalised.  The last entry is the control: a string that must be absent, reported as such; exit 1 if any
real slot does not occur exactly once or the control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

C, N, A, B, F = "CLAUDE.md", "LEAN.md", "ARCHITECTURE.md", "BIBLIOGRAPHY.md", "tools/claude_md_fact_audit.py"
L, K = "LEDGER.md", "data/fs131/claims-NF2.md"
SLOTS = [
    ("1 the audit's sentence", C, "the current audit reads 9038 clean and 5 declared purchases, and 26 imported (and 32 axiom-free; 9,101 records at the landing of FS-133's density equality, FS133-LD1, 2026-10-14)"),
    ("2 the vacuity counts", C, "`declarations=17902 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`."),
    ("3 the nine counts (unchanged; the slot is read, not replaced)", C, "`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`"),
    ("4 what the kernel holds, the clause it follows", C, "anything at a number field's plane or at six colours; that the result is new (`[Davies2026]`). The kernel proof is this project's;"),
    ("4b the density equality's not-claimed clause", C, "Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤ m₁(ℝ²)`, or of a chromatic number;"),
    ("5 the Frontier's Last filed", C, "Last filed: **the landing of FS-133, the density equality** (FS133-LD1, 2026-10-14:"),
    ("6 LEDGER row 129, its grade note", L, "the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set), not the kernel's, which holds `1/7 ≤ m₁(ℝ²) ≤ 1`"),
    ("7 LEDGER row 92, its real places", L, "at every real place it rests on `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.2470` — external, computer-assisted, published;"),
    ("8 LEDGER row 112, its inputs", L, "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked, cert + hand: J26 exact, J49 ball arithmetic; `m₁(ℝ²) ≤ 0.246989`)"),
    ("10 BIBLIOGRAPHY [AmbrusEtAl2023], the role column's sentence it follows", B, "so `m₁(ℝ²) ≤ 0.246989 < 0.2470` is [cert + hand] here; its eq. (23) has a typo — `w1(4)` should be `w1(1)` — and its ν is 1e-5 where the notebook's is 1e-6, both valid (J26 §2.3, §4.1)"),
    ("10b BIBLIOGRAPHY [AmbrusEtAl2023], the read column's last clause", B, "Theorem 1, p. 19's computed `0.24699…` and §4's Remark re-read 2026-09-26 (FS105-W)"),
    ("10c BIBLIOGRAPHY, the library line of [AmbrusEtAl2023]", B, "| `[AmbrusEtAl2023]` | read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and Proposition 1; Tables 1–2 not line by line (J26, 2026-09-25); the authors' notebook read in full |"),
    ("11 BIBLIOGRAPHY [KMOR2016], the role column's sentence it follows", B, "On `𝔽_p²` the three lemmas hold verbatim (densities are counts over `p²`, translates are the group) and were measured: 12% below Delsarte at 11, 0.2% at 83"),
    ("11b BIBLIOGRAPHY [KMOR2016], the read column", B, "read — §3 (Lemma 3.2 with its proof, Remarks 3.3–3.4; 2026-09-14) |"),
    ("12 LEAN.md § The kernel's cost model, the line it follows", N, "(31.9 GB and a timeout against\n  3.5 GB and 5 s on 778 pairs). State list checks through `List.all` and recover the per-element form with `List.all_eq_true`."),
    ("13 LEAN.md § Searching — Lean, its last bullet's end", N, "Declare it a `.condition` with that model in its reason (`OneClass.IsShiftInvariantLaw`, FS133-LD1)."),
    ("14 GATE_CHANGES, the entry it follows", F, '(("8961", "5"), ("9038", "5")): "FS-133, the landing of the density equality'),
    ("15 claims-NF2, its last dated line", K, "- 2026-10-14 — **The certificate's analytic half is priced in the kernel** (FS131-KDB1)"),
    ("CONTROL (must be absent)", C, "the current audit reads 9438 clean"),
]
SLOTS_HEAD = [
    ("9 ARCHITECTURE, the row of Plane/OneAvoidingDensity (its head, on this branch)", A, "| `Plane/OneAvoidingDensity` | **FS-131 (FS131-KR1), skeleton: 1 leaf `sorry`.**"),
    ("9b ARCHITECTURE, the rows of the five skeleton headers", A, "| `Plane/DensityBound/Bessel` | **FS-131 (FS131-KDB1), skeleton: 13 leaves `sorry`.**"),
    ("9c", A, "| `Plane/DensityBound/BesselDefect` | **FS-131 (FS131-KDB1), skeleton: 4 leaves `sorry`.**"),
    ("9d", A, "| `Plane/DensityBound/Autocorr` | **FS-131 (FS131-KDB1), skeleton: 5 leaves `sorry`.**"),
    ("9e", A, "| `Plane/DensityBound/Pattern` | **FS-131 (FS131-KDB1), skeleton: 2 leaves `sorry`.**"),
    ("9f", A, "| `Plane/DensityBound/Window` | **FS-131 (FS131-KDB1), skeleton: 3 leaves `sorry`.**"),
    ("9g ARCHITECTURE § Trust, the sentence it follows", A, "its stored type the declared one's, and its fourteen consumers are clean (FS133-LD1)."),
]


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def main():
    ref = sys.argv[1] if len(sys.argv) > 1 else "main"
    bad = 0
    for refx, slots in ((ref, SLOTS), ("HEAD", SLOTS_HEAD)):
        for name, f, slot in slots:
            text = norm(subprocess.run(["git", "show", f"{refx}:{f}"], capture_output=True, text=True, check=True).stdout)
            n = text.count(norm(slot))
            control = name.startswith("CONTROL")
            ok = (n == 0) if control else (n == 1)
            print(f"{'ok  ' if ok else 'FAIL'} {name} [{f} at {refx}]: occurs {n} time(s)")
            bad += not ok
    print(f"slots: {len(SLOTS) - 1 + len(SLOTS_HEAD)} checked, control absent: {'yes' if bad == 0 else 'see above'}; "
          + ("SLOTS OK" if not bad else f"FAIL ({bad})"))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
