#!/bin/bash
# FS133-IB2: elaborate a working copy of a module with the dump footer appended; the copy with its footer is written
# beside it as <name>.footer.lean and removed afterwards.  $1 = the working copy (relative to the worktree root);
# stdout = the dump and the AXIOMS lines, stderr = Lean's messages.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
t="${1%.lean}.footer.lean"
cat "$1" data/fs133/ib2/lean/Footer.lean.inc > "$t" || exit 2
./data/fs133/ib2/lean1.sh "$t"
rc=$?
rm -f "$t"
exit $rc
