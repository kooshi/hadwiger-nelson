#!/usr/bin/env python3
"""FS131-LU1 (after FS131-LC1's data/fs131/lc1/drafts-slots.py): every draft's slot — the exact words on `main` a draft
replaces or follows — occurs exactly once there.  Reads each file as `git show <ref>:<file>` (default ref `main`: the
server is unreachable, so there is no fresher origin/main), whitespace-normalised.  The last entry is
the control: a string that must be absent, reported as such; exit 1 if any real slot does not occur exactly once or the
control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

C, L, N, K = "CLAUDE.md", "LEDGER.md", "LEAN.md", "plans/FS131-KN1-number-field-kernel-map.md"
SLOTS = [
    ("1 audit sentence", C, "the current audit reads 7395 clean and 5 declared purchases, and 26 imported (and 28 axiom-free; 7,454 records at the landing of FS-131's measurable number, FS131-LC1, 2026-10-13)"),
    ("2 vacuity counts", C, "`declarations=15969 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`."),
    ("3 nine counts and their sentence", C, "`axioms=3 rests=26 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with twenty-six theorems resting on them; thirty-five hypotheses, nineteen named and sixteen written out in a binder — seven standing for outside theorems, twenty-three for hand results of ours and five declared as open questions — taken in 98 (hypothesis, statement) pairs by 51 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5, 2026-10-06)"),
    ("4 GATE_CHANGES, the entry it follows", "tools/claude_md_fact_audit.py", '(("7364", "5"), ("7395", "5")):'),
    ("5 the theory paragraph's sentence on the upper bound", C, "A real number field's residue targets bound its plane, χ(F²) ≤ L(F) (row 52, G64; [hand]), and through"),
    ("6 what the kernel holds", C, "**χ(ℚ(√11)²) ≥ 4** and the 3-adic barrier (rows 72–73);"),
    ("7 FS-101's first slot", C, "**FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`, and the main clause through five over named hypotheses (row 127);"),
    ("7 a sentence that stays (the lower end, not in the kernel)", C, "not in the kernel, where row 127 holds it only over named hypotheses"),
    ("7 a sentence that stays (publication)", C, "in the kernel only in row 127's conditional form"),
    ("8 row 52, the grade", L, "| 52 | [hand + tools] **The finite-plane bound"),
    ("8 row 52, the sentence the new one follows", L, "and this row's bound says nothing about his field (G43)."),
    ("8 row 57", L, "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring with residue field of size N(𝔭)."),
    ("8 row 63", L, "its plane and valuation forms have **no instance over a real field yet**; the only inhabitant is the ring form on ℤ[i], deferred to FS-37"),
    ("8 row 73", L, "with the plane at 7 (`[Moorhouse2010]`, `[Fischer1990]`) **χ(ℚ(√11)²) = 4**."),
    ("8 row 99", L, "a kernel proof (FS-75)"),
    ("8 row 105", L, "**Not claimed:** the number-field reading — the `σ`-stable valuation subrings with `p` in the maximal ideal are the conjugation-stable primes above `p` — which is row 57's gap (FS-37), and with it `ASTRA-2026-09-14-T7` beyond `K(√7)`; Lemma R."),
    ("8 row 119", L, "The conjecture's widest gap has its kernel lower end here (four; five at [hand], row 123; at least six predicted; G59)."),
    ("8 row 121", L, "in the kernel only over named hypotheses, row 127"),
    ("8 row 123", L, "the upper half is the residue map at the place realising `L(F)` (row 52)"),
    ("8 row 127", L, "and, for the equality, the upper half `hUpper` (row 57's gap);"),
    ("9 LEAN.md § The gate, the assumptions bullet", N, "on a declared hypothesis no statement takes, or one a theorem proves over its own variables;"),
    ("11 LEAN.md § The gate, the vacuity bullet's last sentence", N, "(FS131-LC1, its record's stage 5: seven and nine; five and below; six)."),
    ("11 LEAN.md § Building, the bullet the new one follows", N, "plan a cap from the largest process's resident set (`data/fs131/lc1/in-scope.sh` records both) (FS131-LC1)."),
    ("11 LEAN.md § Searching, the bullet the new ones follow", N, "both stored-term comparisons with the release are run again (FS131-LC1)."),
    ("12 the map, [S1b]'s size", K, "those two localization lemmas are stated for `F : Subfield ℝ` and must be restated for a number field given as `fieldI F : Subfield ℂ`. Proofs not read in full: unknown"),
    ("12 the map, [S2]'s second sentence (in the table)", K, "The same for a multiquadratic field at a prime where every radicand is a square, a ramified radicand included (11 in `K`). | 52, 53, 73, 119 (upper end)"),
    ("12 the map, X8", K, "`[S1a]` and `[S2]` at `(11, 7)`; the lower half and the colouring of `Γ₇` are held."),
    ("13 the claim list, the line the regrade follows", "data/fs131/claims-NF1.md", "a draft that says \"onto\" is wrong and is not filed."),
    ("14 the Frontier's Last filed", C, "Last filed: **the landing of FS-131's measurable number** (FS131-LC1, 2026-10-13:"),
    ("CONTROL (must be absent)", C, "the current audit reads 7395 clean and 5 declared purchases, zz"),
]


def norm(s):
    return re.sub(r"\s+", " ", s)


def main():
    ref = sys.argv[1] if len(sys.argv) > 1 else "main"
    cache, bad = {}, 0
    print(f"ref {ref} = {subprocess.run(['git', 'rev-parse', ref], capture_output=True, text=True).stdout.strip()}")
    for label, f, s in SLOTS:
        if f not in cache:
            cache[f] = norm(subprocess.run(["git", "show", f"{ref}:{f}"], capture_output=True, text=True).stdout)
        n = cache[f].count(norm(s))
        if label.startswith("CONTROL"):
            ok = n == 0
            print(f"{'CONTROL FIRED AS EXPECTED: absent' if ok else 'CONTROL FOUND'} — {f}")
        else:
            ok = n == 1
            print(f"{'OK  ' if ok else 'BAD '} {n} time(s) in {f}: {label}")
        bad += 0 if ok else 1
    print(f"slots: {len(SLOTS) - 1} checked, {bad} bad")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
