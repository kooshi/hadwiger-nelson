#!/usr/bin/env python3
"""FS124-L1: every "replaces" / "follows" string of this record's drafts, asserted to occur on `main` the stated number
of times (once, unless said) — so that a draft's slot is a place that exists, in the words quoted.

Usage (from the worktree's root): data/fs124/l1/drafts-slots.py [REV]        REV defaults to origin/main
       data/fs124/l1/drafts-slots.py --control                               one letter of each string's case is swapped;
                                                                             every slot must then be reported MISSING
Exit 0 when every slot is found as stated (or, under --control, when none is); 1 otherwise.
"""
import re
import subprocess
import sys

SLOTS = [
    # (file, expected count, the words)
    ("CLAUDE.md", 1, "the current audit reads 6910 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,953 records at the landing of FS-132's first theorem, FS132-L2, 2026-10-07)"),
    ("CLAUDE.md", 1, "— no map `ℂ → Fin 5` separates every unit pair — with five, and"),
    ("CLAUDE.md", 1, "— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with five;"),
    ("CLAUDE.md", 1, "no record rests on two of the three"),
    ("CLAUDE.md", 1, "`axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with eighteen theorems resting on them;"),
    ("CLAUDE.md", 1, "`declarations=15292 refutations-skipped=226 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`."),
    ("tools/claude_md_fact_audit.py", 1, '(("6533", "5"), ("6910", "5")):'),
    ("tools/claude_md_fact_audit.py", 1, '"6576": "superseded gate count, refiled at FS132-L2\'s landing'),
    ("CLAUDE.md", 1, "Falconer's everywhere-proper `χ_m` is one step further, a GAP; by Thm 1.4 `χ_m(ℝ²) ≥ χ_m⁰(ℝ²) ≥ 6`."),
    ("LEDGER.md", 1, "**Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending. **Kernel-checked on a branch, not through the gate, not held** (`fs124-wk1`, 57 theorems): `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`, each on the standard three axioms and that one declared outside theorem; (up) and its contrapositive on the standard three alone."),
    ("LEDGER.md", 1, "The kernel planner's own generalizations there are its module's, not entries:"),
    ("LEDGER.md", 1, "`plans/FS124-E1-derivation.md` Stage 3; branch `fs124-wk1` |"),
    ("plans/FS124-derivation.md", 1, "the five entries of § 1's radius clause are a module complete on branch `fs124-wk1` (57 theorems) — **kernel-checked on a branch, not through the gate, not held**;"),
    ("plans/FS124-derivation.md", 1, "**Kernel**: first module, complete on a branch, not held."),
    ("plans/FS124-derivation.md", 1, "each on the standard three axioms and that one declared outside theorem, **on a branch**. By the planner's record (§ 4.4, on its branch):"),
    ("plans/FS124-derivation.md", 1, "not stated in the first module"),
    ("CLAUDE.md", 1, "no value moved; its first Lean module complete on a branch, its landing owed)"),
    ("CLAUDE.md", 1, "Its first Lean module, the disc criterion, is complete on branch `fs124-wk1` (57 theorems; kernel-checked on a branch, not through the gate; its landing is owed); its second is being planned; Closed when its modules pass the gate."),
    ("plans/FRONTIER-STUBS.md", 1, "Its first Lean module, the disc criterion, is complete on branch `fs124-wk1` (57 theorems; kernel-checked on a branch, not through the gate; its landing is owed); its second is being planned; Closed when its modules pass the gate."),
    ("CLAUDE.md", 1, "the direction toward seven over the outside theorem on Borel transfer (row 161);"),
    ("plans/STUB-q-ring.md", 1, "the first is complete on a branch, the second is being planned"),
    ("plans/STUB-q-ring.md", 1, "(§ 1; its module complete on branch `fs124-wk1`, kernel-checked on a branch, not through the gate, not held)"),
    ("LEAN.md", 1, "(`latest` is the last complete run; `scripts/gate-log.sh`)"),
    ("LEAN.md", 1, "(FS132-L2, its record's stage 7)."),
    ("LEAN.md", 1, "the landing runs it again on the module as recompiled on the joined tree."),
    ("LEAN.md", 0, "smulOfUnit"),
]


def norm(s):
    return re.sub(r"\s+", " ", s)


def swap(s):
    for i, ch in enumerate(s):
        if ch.isalpha() and ch.swapcase() != ch:
            return s[:i] + ch.swapcase() + s[i + 1:]
    return s + "~"


def main(argv):
    control = "--control" in argv
    a = [x for x in argv if not x.startswith("--")]
    rev = a[0] if a else "origin/main"
    sha = subprocess.run(["git", "rev-parse", rev], capture_output=True, text=True).stdout.strip()
    print(f"slots read on {rev} = {sha}" + ("  (CONTROL: one letter of each string swapped)" if control else ""))
    cache, bad, found = {}, 0, 0
    for f, want, words in SLOTS:
        if f not in cache:
            r = subprocess.run(["git", "show", f"{rev}:{f}"], capture_output=True, text=True)
            cache[f] = norm(r.stdout) if r.returncode == 0 else None
        if cache[f] is None:
            print(f"UNREADABLE {f}")
            bad += 1
            continue
        w = norm(swap(words) if control else words)
        got = cache[f].count(w)
        if control:
            if want == 0:
                continue
            ok = got == 0
            found += 0 if ok else 1
            print(f"{'MISSING (as a control must be)' if ok else 'STILL FOUND'} {f}: {words[:70]}")
        else:
            ok = got == want
            bad += 0 if ok else 1
            print(f"{'OK' if ok else 'MISMATCH'} {f}: {got} (stated {want}): {words[:70]}")
    if control:
        print("CONTROL " + ("FIRED: no altered slot is found" if not found else f"DID NOT FIRE on {found}"))
        return 1 if found else 0
    print(f"slots: {len(SLOTS)}  mismatches: {bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
