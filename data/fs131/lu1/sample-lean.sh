#!/usr/bin/env bash
# FS131-LU1 (FS131-LC1's, unchanged but this line): what a build costs in memory on this machine.  scripts/build.sh starts one systemd scope per batch (a
# sibling of the slot's scope), so the slot's own scope does not see the compilers; this samples them directly.
# Usage: sample-lean.sh <worktree> <out-file> <stop-file> [interval-seconds]
# Every interval: the `lean` processes whose working directory is <worktree> (found by /proc/<pid>/cwd — never by a
# command-line pattern, and nothing is signalled), their resident sets summed and the largest one, with the module it
# is compiling.  Writes a line at each new maximum of either, a heartbeat line every 60 samples, and a final line when
# <stop-file> appears.  RSS counts mapped `.olean` pages in every process that maps them: the sum double-counts shared
# pages, the largest single process does not.
wt="$(readlink -f "$1")"; out="$2"; stop="$3"; iv="${4:-5}"
maxsum=0; maxone=0; maxn=0; n=0; samples=0; onemod="-"; summods="-"
echo "sampler start $(date -u +%Y-%m-%dT%H:%M:%SZ) worktree=$wt interval=${iv}s pid=$$" >> "$out"
while [ ! -e "$stop" ]; do
  sum=0; one=0; cnt=0; mod="-"; mods=""
  for p in $(pgrep -x lean); do
    [ "$(readlink -f /proc/$p/cwd 2>/dev/null)" = "$wt" ] || continue
    r=$(awk '/^VmRSS:/ {print $2}' /proc/$p/status 2>/dev/null); [ -n "$r" ] || continue
    m=$(tr '\0' '\n' < /proc/$p/cmdline 2>/dev/null | grep -m1 '\.lean$' | sed 's#.*/Proofs/#Proofs/#')
    sum=$((sum + r)); cnt=$((cnt + 1)); mods="$mods ${m:-?}"
    if [ "$r" -gt "$one" ]; then one=$r; mod="${m:-?}"; fi
  done
  samples=$((samples + 1))
  if [ "$sum" -gt "$maxsum" ]; then maxsum=$sum; maxn=$cnt; summods="$mods"; echo "$(date -u +%H:%M:%S) new max sum-rss=$((sum / 1024)) MiB over $cnt process(es):$mods" >> "$out"; fi
  if [ "$one" -gt "$maxone" ]; then maxone=$one; onemod="$mod"; echo "$(date -u +%H:%M:%S) new max one-rss=$((one / 1024)) MiB: $mod" >> "$out"; fi
  [ $((samples % 60)) -eq 0 ] && echo "$(date -u +%H:%M:%S) heartbeat samples=$samples now: $cnt process(es), sum-rss=$((sum / 1024)) MiB" >> "$out"
  sleep "$iv"
done
echo "sampler end $(date -u +%Y-%m-%dT%H:%M:%SZ) samples=$samples PEAK_SUM_RSS_MIB=$((maxsum / 1024)) (over $maxn process(es):$summods) PEAK_ONE_RSS_MIB=$((maxone / 1024)) ($onemod)" >> "$out"
