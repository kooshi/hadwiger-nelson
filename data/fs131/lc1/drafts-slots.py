#!/usr/bin/env python3
"""FS131-LC1 (after FS124-L2's data/fs124/l2/drafts-slots.py): every draft's slot — the exact words on `main` a draft
replaces or follows — occurs exactly once there.  Reads each file as `git show <ref>:<file>` (default ref `main`: the
server is unreachable, so there is no fresher origin/main), whitespace-normalised.  The last entry is
the control: a string that must be absent, reported as such; exit 1 if any real slot does not occur exactly once or the
control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

SLOTS = [
    ("1 audit sentence", "CLAUDE.md", "the current audit reads 7364 clean and 5 declared purchases, and 23 imported (and 28 axiom-free; 7,420 records at the landing of FS-124's second module, FS124-L2, 2026-10-07)"),
    ("2 the transfer's records", "CLAUDE.md", "— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with nine; no record rests on two of the three"),
    ("3 nine counts", "CLAUDE.md", "`axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with twenty-three theorems resting on them"),
    ("4 vacuity counts", "CLAUDE.md", "`declarations=15928 refutations-skipped=228 sites=1448`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`."),
    ("5 GATE_CHANGES, the entry it follows", "tools/claude_md_fact_audit.py", '(("6967", "5"), ("7364", "5")):'),
    ("6 the front page's sentence on Falconer's number", "CLAUDE.md", "Falconer's everywhere-proper `χ_m` is one step further, a GAP; by Thm 1.4 `χ_m(ℝ²) ≥ χ_m⁰(ℝ²) ≥ 6`."),
    ("7 row 130, not claimed", "LEDGER.md", "**Not claimed:** `χ(ℝ²) = χ_m(ℝ²)` (the null-set step, a GAP in every record); `χ_B` against `χ_m`; any value."),
    ("8 row 130, the sentence the closing clause follows", "LEDGER.md", "need six colours** (FS-103 Phase 3; FS103-M1, M1b, M1c, M-FREE, M-NR, M-NSUPP, M-AE3, M-EASY, M-D, M-Q4)."),
    ("8 row 130, the chain", "LEDGER.md", "χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`"),
    ("9 LEAN.md § Searching, the bullet the new ones follow", "LEAN.md", "a module from another branch with a dump made in that branch's worktree (FS124-L2)."),
    ("9 LEAN.md § Building, the bullet the new one follows", "LEAN.md", "`lake build --no-build` under the cap says so in two seconds. (FS124-K1)."),
    ("9 LEAN.md § The gate, the sentence the new one follows", "LEAN.md", "a landing reads each skipped declaration of its modules."),
    ("10 the bibliography's status", "BIBLIOGRAPHY.md", "**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`** (2026-10-13, from a text extraction; FS131-PN1); the proofs unread."),
    ("11 the claim list, the line the regrade follows", "data/fs131/claims-NF3.md", "it is the step from \"almost every pair\" to sets with no pair at the distance that the library holds for the plane only.)"),
    ("CONTROL (must be absent)", "CLAUDE.md", "the current audit reads 7364 clean and 5 declared purchases, zz"),
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
