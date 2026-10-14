#!/bin/bash
# FS131-IDB1: sample the resident set of every `lean` process compiling a DensityBound module, every 2 s, until killed.
out="$1"
while true; do
  ps -C lean -o pid=,rss=,args= --no-headers 2>/dev/null | grep -F "DensityBound" | awk -v t="$(date +%s)" '{print t, $0}' >> "$out"
  sleep 2
done
