#!/usr/bin/env python3
"""FS124-L2: every draft's slot — the exact words on `main` a draft replaces or follows — occurs exactly once there.
Reads each file as `git show <ref>:<file>` (default ref origin/main), whitespace-normalised.  The last entry is the
control: a string that must be absent, reported as such; exit 1 if any real slot does not occur exactly once or the
control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

SLOTS = [
    ("1 audit sentence", "CLAUDE.md", "the current audit reads 6967 clean and 5 declared purchases, and 23 imported (and 20 axiom-free; 7,015 records at the landing of FS-124's disc criterion, FS124-L1, 2026-10-07)"),
    ("2 vacuity counts", "CLAUDE.md", "`declarations=15370 refutations-skipped=226 sites=1448`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`."),
    ("3 nine counts (stand)", "CLAUDE.md", "`axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1`"),
    ("4 GATE_CHANGES, the entry it follows", "tools/claude_md_fact_audit.py", '(("6910", "5"), ("6967", "5")):'),
    ("5 open milestones", "CLAUDE.md", "its second is being planned; Closed when its modules pass the gate."),
    ("5 open milestones, the stubs file", "plans/FRONTIER-STUBS.md", "its second is being planned; Closed when its modules pass the gate."),
    ("6 item 31, the clause's head", "CLAUDE.md", "At the unit arc itself (FS-124; rows 161–164; [hand], one mind each, kernel pending):"),
    ("6 item 31, row 162", "CLAUDE.md", "one tight pair forces nothing beyond its first step (row 162);"),
    ("6 item 31, row 163", "CLAUDE.md", "and one member pays alone only where two of its pieces meet at it only (row 163);"),
    ("7 FS-136's paragraph", "CLAUDE.md", "which is kernel-checked on a branch in FS-124's second module"),
    ("8 row 162's grade", "LEDGER.md", "**Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; C124-SHADOW-OPEN, C124-TYPE, C124-CENTRE-HALF, C124-CENTRE and C124-STRADDLE are in the kernel lane's second module, being planned."),
    ("9 row 163's grade", "LEDGER.md", "**Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; **a second mind is owed on C124-LONE's Step II**, on which C124-BOTH, C124-FOUR and C124-SECOND rest (its deriver's line; the kernel lane's second module is that mind, blind first); one topological input of C124-FORCED is recalled, not read."),
    ("10 row 164's grade", "LEDGER.md", "**Grade:** [hand] with an exact check, one mind, kernel pending; it rests on C124-TYPE and on no entry of row 163."),
    ("11 the theorem record's head", "plans/FS124-derivation.md", 'nine entries (marked "second module") are being planned blind on branch `fs124-wk2`; the rest have no kernel job.'),
    ("12 C124-FORCED's uses only", "plans/FS124-derivation.md", "(the θ-curve form of the Jordan–Schoenflies theorem: recalled, not read)"),
    ("13 LEAN.md, the bullet the new ones follow", "LEAN.md", "`LinearIsometryEquiv.measurePreserving` is in the closure (FS124-I1)."),
    ("14 LEAN.md § The gate, the sentence the new one follows", "LEAN.md", "(FS124-L1, its record's stage 6: seven, six, five)."),
    ("CONTROL (must be absent)", "CLAUDE.md", "the current audit reads 7364 clean and 5 declared purchases, zz"),
]


def norm(s):
    return re.sub(r"\s+", " ", s)


def main():
    ref = sys.argv[1] if len(sys.argv) > 1 else "origin/main"
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
