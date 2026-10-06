#!/usr/bin/env bash
# FS131-MC1: one build of the worktree under the slot; the log ends with a line `exit=<status>` on success and on failure alike.
# usage: data/fs131/mc/run-build.sh <tag>      (from the worktree root)
set -u
tag="$1"
cd "$(dirname "$0")/../../.."
log="data/fs131/mc/build-$tag.log"
{
  echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  git status --short -- Proofs Proofs.lean scripts | sed 's/^/DIRTY /'
} > "$log"
/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 --wait 3600 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh >> "$log" 2>&1
rc=$?
echo "exit=$rc" >> "$log"
exit $rc
