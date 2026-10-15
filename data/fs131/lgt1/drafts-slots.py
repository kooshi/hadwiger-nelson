#!/usr/bin/env python3
"""FS131-LGT1 (FS131-LDB1's data/fs131/ldb1/drafts-slots.py with this landing's slots): every draft's slot — the exact
words a draft replaces or follows — occurs exactly once in its file.  Reads each file as `git show <ref>:<file>`
(default ref `main`: the drafts are filed on `main`), whitespace-normalised.  The last entry is the control: a string
that must be absent, reported as such; exit 1 if any real slot does not occur exactly once or the control is found.
Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

C, N, B, F = "CLAUDE.md", "LEAN.md", "BIBLIOGRAPHY.md", "tools/claude_md_fact_audit.py"
L, K = "LEDGER.md", "data/fs131/claims-NF2.md"
SLOTS = [
    ("1 the audit's sentence", C, "the current audit reads 9438 clean and 5 declared purchases, and 26 imported (and 355 axiom-free; 9,824 records at the landing of the density bound, FS131-LDB1, 2026-10-14)"),
    ("2 the declared outside axioms", C, "The library declares two outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — with twenty imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1); and, from `[OAIMath2026]` family 158, a Lean development built and audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with six; no record rests on both,"),
    ("3 the nine counts and their sentence", C, "`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` — two outside theorems declared as axioms, with twenty-seven theorems resting on them;"),
    ("3b the pairs and statements", C, "taken in 102 (hypothesis, statement) pairs by 52 statements"),
    ("4 the vacuity counts", C, "`declarations=20563 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`."),
    ("5 the Frontier's Last filed", C, "Last filed: **the landing of the density bound** (FS131-LDB1, 2026-10-14:"),
    ("6 what the kernel holds, the clause it follows", C, "The theorem is `[AmbrusEtAl2023]`'s; the route, the formalization and the kernel check are this project's;"),
    ("7 where the problem stands, the algebraic lower end", C, "— at [hand] grade, over MR (row 120: `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement, with a two-mind deduction of its Thm 1.2, and `[EinsiedlerFish2010]`'s method transferred, three blind derivations), not in the kernel, where row 127 holds it only over named hypotheses."),
    ("8 the theory paragraph's five", C, "at five given MR, by measure rigidity for the unit-vector group, with no witness graph: rows 120, 123, G80; [hand])"),
    ("9 the conjecture's proved range", C, "Its proved range is `plans/WHERE-THE-PROBLEM-STANDS.md` item 10's — every `L ≤ 5`, at [hand] through MR (row 123)."),
    ("10 the exposed predictions met", C, "**all met**, at [hand] through MR (rows 120–121, 123)"),
    ("11 ℚ(√167)", C, "proven 4 in the kernel (row 119) and ≥ 5 at [hand] (row 123),"),
    ("12 publication, the answered question", C, "in the kernel only in row 127's conditional form;"),
    ("13 LEDGER row 121, its consequences", L, "in the kernel only over named hypotheses, row 127;"),
    ("14 LEDGER row 123, its grade's head", L, "**[hand + tools exact; MR row 120's grade (EL2021 Thm 1.2 external;"),
    ("15 LEDGER row 127, the value given the chain", L, "`χ(ℚ(√47)²) = 5` given the chain (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain`);"),
    ("15b LEDGER row 127, not claimed", L, "**Not claimed:** any named hypothesis. **Prior art:** the upper half at ℚ(√47) is row 52's residue colouring; the kernel forms ours."),
    ("16 LEAN.md § Building, its last bullet's end", N, "(`data/fs131/ipd1/farm2-run.sh`, FS131-IPD1; `data/fs131/lp1/advalue-run.sh`, FS131-LP1)."),
    ("17 LEAN.md § Searching — Lean, its last bullet's end", N, "(`tools/fs131_idb1_cells.py chain`, `modules`; `tools/fs131_kdb1_x23.py --write`: the covering's 48 modules and the certificate's 23 byte for byte; FS131-LDB1)."),
    ("18 BIBLIOGRAPHY [EinsiedlerLindenstrauss2022], the role column", B, "PE-2's positive-entropy input (row 120), resting since FS-105 on its Thm 1.3 plus the deduction FS105-DED [hand, two minds], EL2003's proof being an outline"),
    ("19 BIBLIOGRAPHY [Weil1948], the role column's end", B, "**as a statement about the norm-one Cayley graph of `𝔽_{p²}`**, not yet about the plane `UD(𝔽_p, 2)` (no declaration links the two)"),
    ("20 GATE_CHANGES, the entry it follows", F, '(("9038", "5"), ("9438", "5")): "FS-131, the landing of the density bound'),
    ("21 claims-NF2, its last dated line", K, "- 2026-10-14 — **The density bound is landed** (FS131-LDB1)"),
    ("CONTROL (must be absent)", C, "the current audit reads 10650 clean"),
]


def norm(s):
    return re.sub(r"\s+", " ", s)


def main():
    ref = sys.argv[1] if len(sys.argv) > 1 else "main"
    cache, bad = {}, 0
    for label, f, slot in SLOTS:
        if f not in cache:
            cache[f] = norm(subprocess.run(["git", "show", f"{ref}:{f}"], check=True, capture_output=True,
                                           text=True).stdout)
        n = cache[f].count(norm(slot))
        if label.startswith("CONTROL"):
            ok = n == 0
            print(f"{'ok  ' if ok else 'FAIL'}  {label}: found {n} time(s)")
        else:
            ok = n == 1
            print(f"{'ok  ' if ok else 'FAIL'}  {label} ({f}): {n} time(s)")
        bad += 0 if ok else 1
    print(f"slots: {len(SLOTS) - 1} checked, control absent: {'yes' if cache[C].count(norm(SLOTS[-1][2])) == 0 else 'NO'}; "
          + ("SLOTS OK" if not bad else f"FAIL ({bad})"))
    return 1 if bad else 0


sys.exit(main())
