#!/usr/bin/env bash
# FS131-IT1: the build under the slot, with the resident memory of its whole process tree sampled every 2 s.
# usage: build_sampled.sh <log prefix> <BATCH>      writes <prefix>.out, <prefix>.err, <prefix>.peak
# The peak is a sum of RSS over the tree, so pages of .olean files mapped by several processes are counted once each
# time: an upper estimate.
set -u
root=$(cd "$(dirname "$0")/../../.." && pwd)
log=$1; batch=$2
cd "$root"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 --wait 7200 \
  --name it1 -- env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$log.out" 2> "$log.err" &
pid=$!
echo "$pid" > "$log.pid"
peak=0; samples=0
while kill -0 "$pid" 2>/dev/null; do
  cur=$(ps -e -o pid=,ppid=,rss= | awk -v root="$pid" '
    { pp[$1]=$2; rss[$1]=$3 }
    END { for (p in pp) { q=p; d=0; while (q in pp && q!=root && d<64) { q=pp[q]; d++ } if (q==root) s+=rss[p] } print s+0 }')
  samples=$((samples+1))
  [ "$cur" -gt "$peak" ] && peak=$cur
  sleep 2
done
wait "$pid"; rc=$?
echo "exit=$rc samples=$samples peak_tree_rss_kb=$peak" > "$log.peak"
exit $rc
