#!/bin/bash
# FS131-ICS1 iteration helper (never evidence; the build is): compile one module into a farm, with the lakefile's options.
# The farm is a REAL copy (cp -a) of this worktree's compiled `Proofs/` library taken once, so a build walking in the
# worktree never rewrites a file the farm reads (FS131-ICO2's lean1.sh used symlinks). $1 = module path under
# Proofs/HadwigerNelson without .lean, or a .lean file elsewhere (then $3 names the module path it is compiled as);
# $2 = memory GiB (default 6). Output .olean goes over the farm's copy of that module.
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/kcs1
S=$W/build/ics1-farm
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
if [ ! -d "$S/Proofs" ]; then mkdir -p "$S" && cp -a "$W/.lake/build/lib/lean/Proofs" "$S/Proofs" && cp -a "$W/.lake/build/lib/lean/Proofs.olean" "$S/Proofs.olean"; fi
SRC="Proofs/HadwigerNelson/$1.lean"; MOD="$1"
if [ -f "$1" ]; then SRC="$1"; MOD="${3:?module path needed}"; fi
mkdir -p "$S/Proofs/HadwigerNelson/$(dirname "$MOD")"
rm -f "$S/Proofs/HadwigerNelson/$MOD.olean" "$S/Proofs/HadwigerNelson/$MOD.ilean"
cd "$W" && exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${2:-6}" --cpus 2 --wait 7200 --name ics1-iter -- env LEAN_PATH="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" "$T/bin/lean" -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o "$S/Proofs/HadwigerNelson/$MOD.olean" "$SRC"
