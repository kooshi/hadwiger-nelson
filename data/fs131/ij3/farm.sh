#!/bin/bash
# FS131-IJ3 iteration helper (never evidence; the build is the receipt): elaborate one file against a scratch farm of
# .olean files — a symlink copy of this tree's compiled library with the modules under work compiled over it
# (`LEAN.md` § Searching — Lean, FS133-IB2's `farm1.sh` for this tree).
#   farm.sh init                       — (re)make the farm: `cp -as` of the tree's `.lake/build/lib/lean/Proofs`
#   farm.sh o <Module/Path> [log]      — compile Proofs/<Module/Path>.lean into the farm (its symlink removed first)
#   farm.sh e <file.lean> <log>        — elaborate a file against the farm; log ends "seconds=" and "exit="
F=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/ij3-farm
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
cd $W || exit 2
LP="$F:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean"
case "$1" in
  init) rm -rf "$F"; mkdir -p "$F"; cp -as "$W/.lake/build/lib/lean/Proofs" "$F/Proofs"; cp -as "$W/.lake/build/lib/lean/Proofs.olean" "$F/" 2>/dev/null; echo "farm made: $(find $F -name '*.olean' | wc -l) oleans";;
  o) rm -f "$F/Proofs/$2.olean" "$F/Proofs/$2.ilean"; log="${3:-/dev/stdout}"; t0=$(date +%s)
     env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 5 --cpus 2 --wait 7200 --name ij3f -- env LEAN_PATH="$LP" $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$F/Proofs/$2.olean" "Proofs/$2.lean" > "$log" 2>&1; st=$?
     echo "seconds=$(( $(date +%s) - t0 ))" >> "$log"; echo "exit=$st" >> "$log"; tail -2 "$log";;
  e) log="$3"; t0=$(date +%s)
     env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 5 --cpus 2 --wait 7200 --name ij3f -- env LEAN_PATH="$LP" $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$2" > "$log" 2>&1; st=$?
     echo "seconds=$(( $(date +%s) - t0 ))" >> "$log"; echo "exit=$st" >> "$log"; tail -2 "$log";;
esac
