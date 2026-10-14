#!/usr/bin/env bash
# FS131-IG1: one build of this worktree under the slot, with wall time and a memory sample.
# usage: data/fs131/ig1/build.sh <tag> [BATCH]     (run from anywhere; logs under data/fs131/ig1/logs/)
# Writes build-<tag>.log (last line "exit=<status>", read that and never a pipe's status), build-<tag>.rss
# (every 5 s: UTC time, summed resident GiB of the lean and lake processes whose working directory is this
# worktree, and the largest single one), and build-<tag>.times (start, end, seconds).
set -u
cd "$(dirname "$0")/../../.."
tag="$1"; batch="${2:-8}"; here="$(pwd -P)"
log="data/fs131/ig1/logs/build-$tag.log"; rss="data/fs131/ig1/logs/build-$tag.rss"; tm="data/fs131/ig1/logs/build-$tag.times"
: > "$rss"
(
  while :; do
    sum=0; max=0
    for p in $(pgrep -u "$USER" -x lean; pgrep -u "$USER" -x lake); do
      [ "$(readlink "/proc/$p/cwd" 2>/dev/null)" = "$here" ] || continue
      r=$(awk '/^VmRSS:/ {print $2}' "/proc/$p/status" 2>/dev/null); r=${r:-0}
      sum=$((sum + r)); [ "$r" -gt "$max" ] && max=$r
    done
    echo "$(date -u +%FT%TZ) $(awk -v s="$sum" -v m="$max" 'BEGIN {printf "%.2f %.2f", s/1048576, m/1048576}')" >> "$rss"
    sleep 5
  done
) &
sampler=$!
start=$(date +%s); echo "start $(date -u +%FT%TZ)" > "$tm"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 --wait 7200 --name ig1 -- \
  env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$log" 2>&1
status=$?
kill "$sampler" 2>/dev/null
end=$(date +%s); echo "end $(date -u +%FT%TZ)" >> "$tm"; echo "seconds $((end - start))" >> "$tm"
echo "peak_sum_GiB $(sort -k2 -n -r "$rss" | head -1 | cut -d' ' -f2)  peak_one_GiB $(sort -k3 -n -r "$rss" | head -1 | cut -d' ' -f3)" >> "$tm"
echo "exit=$status" >> "$log"
