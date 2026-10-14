#!/bin/bash
# FS131-IDB3 iteration helper (never evidence; the build is the receipt): elaborate one module of the worktree against a
# scratch farm of .olean files — a symlink copy of this tree's compiled library with the modules under work compiled over
# it (LEAN.md § Searching — Lean, FS133-IB2's pattern). $1 = module path under the worktree without .lean; $2 = "o" to write
# its .olean into the farm (the farm's symlink, if any, removed first, so the real build is never written); $3 = GiB (4).
F=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/idb3-farm
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
cd $W || exit 2
[ -d "$F/Proofs" ] || { mkdir -p "$F" && cp -as "$W/.lake/build/lib/lean/Proofs" "$F/Proofs" && cp -as "$W/.lake/build/lib/lean/Proofs.olean" "$F/" 2>/dev/null; }
OUT=()
if [ "$2" = o ]; then rm -f "$F/$1.olean"; mkdir -p "$(dirname "$F/$1.olean")"; OUT=(-o "$F/$1.olean"); fi
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${3:-4}" --cpus 2 --wait 7200 --name idb3f -- env LEAN_PATH="$F:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" /usr/bin/time -f 'TIME %e s  RSS %M KB' $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true "${OUT[@]}" "$1.lean"
