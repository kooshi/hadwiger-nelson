#!/usr/bin/env python3
"""FS131-LJ1 (FS131-LU1's data/fs131/lu1/drafts-slots.py with this landing's slots): every draft's slot — the exact words on `main` a draft
replaces or follows — occurs exactly once there.  Reads each file as `git show <ref>:<file>` (default ref `main`: the
server is unreachable, so there is no fresher origin/main), whitespace-normalised.  The last entry is
the control: a string that must be absent, reported as such; exit 1 if any real slot does not occur exactly once or the
control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

C, L, N, B = "CLAUDE.md", "LEDGER.md", "LEAN.md", "BIBLIOGRAPHY.md"
SLOTS = [
    ("1 audit sentence", C, "the current audit reads 7447 clean and 5 declared purchases, and 26 imported (and 28 axiom-free; 7,506 records at the landing of FS-131's first number-field module, the residue upper half, FS131-LU1, 2026-10-13)"),
    ("1b the import's count of records", C, "`StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — with eight imported records;"),
    ("1b a sentence that stays", C, "no record rests on two of the three"),
    ("2 vacuity counts", C, "`declarations=16029 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`."),
    ("3 nine counts and their sentence", C, "`axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1` — three outside theorems declared as axioms, with twenty-six theorems resting on them; thirty-four hypotheses, nineteen named and fifteen written out in a binder — seven standing for outside theorems, twenty-two for hand results of ours and five declared as open questions — taken in 106 (hypothesis, statement) pairs by 52 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5, 2026-10-06; one hand result left the list at FS131-LU1, 2026-10-13: the upper half `χ(F²) ≤ L(F)` is the theorem `UpperHalf.chromaticNumber_planeOver_le_localBound`)"),
    ("4 GATE_CHANGES, the entry it follows", "tools/claude_md_fact_audit.py", '(("7395", "5"), ("7447", "5")):'),
    ("5 what the kernel holds, the sentence it follows", C, "`χ(ℚ(√167)²) ≤ 8` and `χ(ℚ(√47)²) ≤ 5` a second way (rows 52, 57, 63, 105, 119, 121; FS131-LU1; known values and bounds, the kernel proofs ours);"),
    ("6 the Frontier's Last filed", C, "Last filed: **the landing of FS-131's first number-field module, the residue upper half**"),
    ("7 row 52", L, "The two values stay [hand + tools] until the ramified clause is applied at 11 to `K(√5)` and `K(√247)`: no file states those instances."),
    ("7 row 73", L, "four exactly except 47 (≤ 5 at 11)."),
    ("7 row 79, the grade", L, "**[hand; two independent derivations — de Bruijn and Coxeter — read by Poros; the owner checked the two deciding steps]**"),
    ("7 row 82, the grade (with the row's head, to be unique)", L, "three-colourability of every real quadratic plane is decided exactly** (FS-81 stages A and C; the theorems `plans/FS81-derivation.md` T1–T7). **[hand, two independent derivations]**"),
    ("7 row 82, not claimed", L, "anything in the kernel (FS73-T22's ⟹ is hand-proved, never kernel; FS-75);"),
    ("7 row 99, the grade", L, "**[hand (+ Weil, tools exact); S1 three derivations (J02, J09, J09v), S2 and the torsion theorem two, S3 three, no mixing two independent (J09; J09v blind, a different route)]**"),
    ("7 row 99, not claimed", L, "a kernel proof (FS-75) — of which one leaf is in the kernel since FS131-LU1, the upper half `χ(F²) ≤ L(F)` for every real number field (`UpperHalf.chromaticNumber_planeOver_le_localBound`); every other step of the row stays [hand];"),
    ("7 row 105", L, "the reading applied at any named field (`K(√7)`'s \"every prime above 2 splits in `K(√7)(i)`\" is not stated);"),
    ("8 LEAN.md § Searching, the bullet the new ones follow", N, "`tools/check_architecture.py` fails on a row's imports cell and on module coverage; a misnamed identifier in a row's description is listed under `[3]` and does not fail (FS131-IV1, two plants on copies)."),
    ("8 LEAN.md § The gate, the sentence the new one follows", N, "(`hUpper` of `SpectralChain.chromaticNumber_eq_localBound`, proved by `UpperHalf.chromaticNumber_planeOver_le_localBound` and retired by FS131-LU1 — its record's stage 4 has the receipt);"),
    ("9 the bibliography row, what rests on it (with the words before it, to be unique)", B, "colorings of the graphs (ℚ²(√m), 1)\"*. the upper bound `χ(ℚ(√11)²) ≤ 4` is kernel-checked since FS131-LU1 (`UpperHalf.chromaticNumber_planeOver_eleven`)."),
    ("9 the bibliography row, its reading", B, "which conclude only the additive case (`LEDGER.md` row 82)"),
    ("10 the theory paragraph", C, "and through five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five;"),
    ("CONTROL (must be absent)", C, "the current audit reads 7447 clean and 5 declared purchases, zz"),
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
