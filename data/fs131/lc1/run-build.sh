#!/usr/bin/env bash
# FS131-LC1: one build under the slot, measured.  Usage: run-build.sh <tag> <mem GiB> <cpus> <BATCH>
# Log: data/fs131/lc1/build-<tag>.log (the build's terminal output, then BUILD_EXIT, the wall time and the sampler's
# peaks); the sampler's own lines: build-<tag>.rss.  Lake's complete output is the gate's log the build names.
# If this dies: relaunch the same command — Lake rebuilds only what is not yet built (every compiled module's
# `.olean` is on disk when its batch ends), so the redo is the batch in flight plus the walk.
cd "$(dirname "$0")/../../.." || exit 2
tag="$1"; mem="$2"; cpus="$3"; batch="$4"; d=data/fs131/lc1
log="$d/build-$tag.log"; rss="$d/build-$tag.rss"; stop="$d/.sampler-stop-$tag"
rm -f "$stop"; : > "$rss"
echo "start $(date -u +%Y-%m-%dT%H:%M:%SZ) HEAD=$(git rev-parse HEAD) mem=${mem}G cpus=$cpus BATCH=$batch" > "$log"
git status --short | grep -v '^??' | sed 's/^/modified: /' >> "$log"
setsid "$d/sample-lean.sh" "$PWD" "$rss" "$stop" 5 > /dev/null 2>&1 &
t0=$(date +%s)
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "$mem" --cpus "$cpus" --wait 7200 \
  --name "lc1-build-$tag" -- env MEMMAX="${mem}G" BATCH="$batch" ./scripts/build.sh >> "$log" 2>&1
st=$?
t1=$(date +%s)
touch "$stop"; sleep 7
{ echo "BUILD_EXIT=$st"; echo "WALL_SECONDS=$((t1 - t0)) (the wait for the slot included)"; tail -1 "$rss"; echo "end $(date -u +%Y-%m-%dT%H:%M:%SZ)"; } >> "$log"
rm -f "$stop"
tail -6 "$log"
exit "$st"
