#!/usr/bin/env bash
# FS131-IKC3: sample the resident set of every `lean` process whose command line names a FibreCert1x module, every
# half second, until the stop file exists or two hours pass. Read-only (ps). Output: <epoch> <pid> <rss KB> <module file>.
out="$1"; stop="$2"; end=$(( $(date +%s) + 7200 ))
: > "$out"
while [[ ! -e "$stop" && $(date +%s) -lt $end ]]; do
  ps -C lean -o pid=,rss=,args= | awk -v t="$(date +%s.%N)" '{ for (i = 3; i <= NF; i++) if ($i ~ /FibreCert1[19][A-Za-z0-9]*\.lean$/) { print t, $1, $2, $i; break } }' >> "$out"
  sleep 0.5
done
echo "sampler done $(date +%s)" >> "$out.done"
