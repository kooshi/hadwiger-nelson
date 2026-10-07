#!/bin/bash
# FS132-I4 iteration helper (never evidence; the evidence is scripts/build.sh under the slot).
# Elaborates one module of Proofs/HadwigerNelson/Plane/SixRing against a scratch olean farm and, when it has no
# error, writes its .olean into the farm, so that the next module under work can import it without a walk of the
# library. The farm is a symlink copy of this worktree's built library (made by `lean1.sh --farm`); a LEAN_PATH
# entry holding a `Proofs/` directory hides every later entry's `Proofs` (FS132-I2's finding), hence the copy.
#   lean1.sh --farm            (re)make the farm from .lake/build/lib/lean
#   lean1.sh <Module>          e.g. `lean1.sh State`; prints Lean's messages; exit status is Lean's
#   lean1.sh --file <path>     elaborate any file against the farm, writing nothing
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/i4-farm
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
LP="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean"
OPTS="-DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true"
cd "$W" || exit 2
if [ "$1" = "--farm" ]; then
  rm -rf "$S" && mkdir -p "$S" && cp -rs "$W/.lake/build/lib/lean/Proofs" "$S/Proofs" && cp -s "$W/.lake/build/lib/lean/"Proofs.* "$S/" 2>/dev/null
  echo "farm: $(find "$S" -name '*.olean' | wc -l) oleans linked"; exit 0
fi
if [ "$1" = "--file" ]; then
  exec /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 -- env LEAN_PATH="$LP" "$T/bin/lean" $OPTS "$2"
fi
M="$1"
OUT="$S/Proofs/HadwigerNelson/Plane/SixRing/$M.olean"
TMP="$OUT.tmp.$$"
/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 -- env LEAN_PATH="$LP" "$T/bin/lean" $OPTS -o "$TMP" "Proofs/HadwigerNelson/Plane/SixRing/$M.lean"
rc=$?
if [ $rc -eq 0 ] && [ -f "$TMP" ]; then rm -f "$OUT"; mv "$TMP" "$OUT"; echo "== $M: olean written to the farm"; else rm -f "$TMP"; echo "== $M: FAILED (exit $rc), farm unchanged"; fi
exit $rc
