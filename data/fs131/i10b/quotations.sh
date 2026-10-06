#!/usr/bin/env bash
# FS131-I10B: standing rule 3 — each quotation of the brief, grep -F'd in the file the brief names.
# Usage: data/fs131/i10b/quotations.sh  (from the worktree root). Prints one line per quotation; exits 1 on any miss.
MAIN=/home/kooshi/source/lean-dir
WT=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b
miss=0
chk() { # file, string
  n=$(grep -cF -- "$2" "$1")
  if [ "$n" -ge 1 ]; then echo "MATCH ($n)  $1 :: ${2:0:70}"; else echo "MISS       $1 :: ${2:0:70}"; miss=1; fi
}
chk "$MAIN/CLAUDE.md" "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time."
chk "$MAIN/plans/FS131-close-inventory.md" '484. **FS131-K10 done at its Stage 5: wave 10 planned — dispositions for all fourteen rows, a foundation, a skeleton of eleven, four rows'
chk "$MAIN/plans/FS131-close-inventory.md" "485. **Rulings on K10's held items, and its slot.** (a) **Three implementers by file, as it splits them**; the first, FS131-I10A"
chk "$MAIN/plans/FS131-close-inventory.md" '477. **FS131-K10, by message at its Stage 1 (`fs131-w10` at `6ca3fb4e`): a statement defect in a filed hand result, a gap, a generalization**'
chk "$MAIN/plans/FS131-close-inventory.md" '478. **Rulings on item 477** (sent to K10 by message). (a) **TC1-STANDING-FIVE takes a second named hypothesis beside `Row123Chain`, the'
chk "$MAIN/plans/FS131-close-inventory.md" '493. **FS131-I10A done: all nine leaves of wave 10'"'"'s first file pair proved — `SpectralInputs` and `CharacterColouring` hold no `sorry`, over'
chk "$WT/plans/FS131-w10-kernel-plan.md" '### 5.3 `StationaryRatio` — three leaves'
chk "$WT/plans/FS131-w10-kernel-plan.md" '### 5.5 The named hypotheses, with `LEAN.md` § Assumptions'"'"' four items, and what each would take'
# the control: a string that is in none of the files must read MISS
n=$(grep -cF -- "484. **FS131-K10 done at its Stage 6" "$MAIN/plans/FS131-close-inventory.md")
if [ "$n" -eq 0 ]; then echo "CONTROL fired (a planted wrong quotation reads 0)"; else echo "CONTROL FAILED"; miss=1; fi
exit $miss
