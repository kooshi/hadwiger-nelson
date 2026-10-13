#!/usr/bin/env bash
# FS131-KN4: elaborate the planned joining module against BOTH lines' skeletons, writing in neither tree.
# A scratch farm = symlink copy of fs131-wnf's built library, plus this line's three modules compiled into it.
set -u
here=$(cd "$(dirname "$0")/../../.." && pwd)
wnf=${KN4_WNF:-/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf}
farm=${KN4_JOIN_FARM:-/tmp/claude-1000/kn4-join-farm}
lib=$wnf/.lake/build/lib/lean
rm -rf "$farm"; mkdir -p "$farm"; cp -rs "$lib/Proofs" "$farm/"
cd "$wnf"
LP="$farm:$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "^$lib\$" | paste -sd:)"
cd "$here"   # lean -o wants its input under the working directory; the path above is still fs131-wnf's
for m in Arith/ThreeColourCharacter Arith/TorsionExtraction Arith/ThreeColourCriterion; do
  mkdir -p "$farm/Proofs/HadwigerNelson/$(dirname $m)"
  LEAN_PATH="$LP" lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$farm/Proofs/HadwigerNelson/$m.olean" \
    "$here/Proofs/HadwigerNelson/$m.lean" 2>&1 | grep -v "declaration uses" 
done
LEAN_PATH="$LP" lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$here/data/fs131/kn4/lean/ThreeFourColours.lean"
