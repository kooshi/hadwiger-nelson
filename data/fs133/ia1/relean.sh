#!/bin/bash
# FS133-IA1 iteration helper (never evidence — the build under the slot is): re-elaborate the named modules of the
# worktree in the order given, each written over its `.olean` in the build's library, so that a dump can read the
# effect of a change before a build walks.  Arguments: module paths relative to the worktree root.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
for f in "$@"; do
  o=".lake/build/lib/lean/${f%.lean}.olean"
  t0=$(date +%s)
  "$W/data/fs133/ia1/lean1.sh" "$f" -o "$o" > "/tmp/claude-1000/relean.$$.out" 2>&1; rc=$?
  n=$(grep -c "error" "/tmp/claude-1000/relean.$$.out")
  echo "relean $f: exit $rc, $(( $(date +%s) - t0 )) s, error lines $n"
  if [ $rc -ne 0 ]; then grep -n "error" -A6 "/tmp/claude-1000/relean.$$.out" | head -40; rm -f "/tmp/claude-1000/relean.$$.out"; exit $rc; fi
  rm -f "/tmp/claude-1000/relean.$$.out"
done
