#!/usr/bin/env bash
# FS131-L6A (FS131-MC1's data/fs131/mc/run-build.sh with its log directory changed): one build of the worktree under the slot.
# The log's first line names the commit and the tracked files modified; its last line is `exit=<status>`, on success and failure alike.
# usage: data/fs131/l6a/run-build.sh <tag>      (from anywhere; it changes to the worktree root)
set -u
tag="$1"
cd "$(dirname "$0")/../../.."
log="data/fs131/l6a/build-$tag.log"
{
  echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  git status --short -- Proofs Proofs.lean scripts | sed 's/^/DIRTY /'
} > "$log"
/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 --wait 3600 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh >> "$log" 2>&1
rc=$?
f="$(readlink -f build/gate/build/latest 2>/dev/null)"
echo "full log: $f" >> "$log"
[ -f "$f" ] && cp "$f" "data/fs131/l6a/build-$tag-full.log"
echo "exit=$rc" >> "$log"
exit $rc
