#!/usr/bin/env bash
# FS131-LU1 (FS131-LC1's, unchanged but this line): run a command INSIDE the slot's scope and record what it cost on this machine.
# Usage (as the slot's command): in-scope.sh <measure-file> <cmd> [args...]
# Appends one line to <measure-file>: the command's exit status, its wall time, and two memory numbers that measure
# different things:
#   peak     the scope's `memory.peak` (cgroup v2): what the kernel CHARGED this step — every process of it, private
#            memory and the file pages it was the first to read.  `.olean` pages another scope already holds in the
#            page cache are not charged again, so on a warm machine this is below what a cold run of the step costs.
#   max-rss  the largest resident set of any ONE process of the step (GNU time, ru_maxrss over the waited children):
#            private memory plus every mapped `.olean` page it touched, shared or not.  For a step that is one `lean`
#            process this is the number to plan a cap from.
# The command's own stdout and stderr pass through untouched; its exit status is this script's.  A step that starts
# scopes of its own (scripts/build.sh: one `systemd-run` per batch, siblings of this scope) is NOT measured by
# `peak` — the build is measured by sample-lean.sh.
f="$1"; shift
t0=$(date +%s.%N)
/usr/bin/time -f "%M" -o "$f.rss" "$@"; st=$?
t1=$(date +%s.%N)
cg="/sys/fs/cgroup$(sed -n 's/^0:://p' /proc/self/cgroup)"
peak="$(cat "$cg/memory.peak" 2>/dev/null || echo unreadable)"
rss="$(tail -1 "$f.rss" 2>/dev/null || echo unreadable)"; rm -f "$f.rss"
awk -v a="$t0" -v b="$t1" -v p="$peak" -v r="$rss" -v st="$st" -v cmd="$*" 'BEGIN {
  gb = (p ~ /^[0-9]+$/) ? sprintf("%.2f GiB", p / 1073741824) : "unreadable";
  rg = (r ~ /^[0-9]+$/) ? sprintf("%.2f GiB", r / 1048576) : "unreadable";
  printf "MEASURE exit=%d wall=%.1fs peak=%s max-rss=%s :: %s\n", st, b - a, gb, rg, cmd }' >> "$f"
exit "$st"
