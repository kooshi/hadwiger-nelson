#!/bin/bash
# FS133-LD1: sample, every 5 s while process $1 lives, the resident memory of every `lean` process of this user
# (largest single process and the sum); write the maxima to $2 at each sample (so a kill leaves the last maxima).
pid="$1"; out="$2"; maxone=0; maxsum=0
while kill -0 "$pid" 2>/dev/null; do
  read one sum < <(ps -u "$USER" -C lean -o rss= --no-headers | awk 'BEGIN{m=0;s=0} {s+=$1; if ($1>m) m=$1} END{print m, s}')
  [ "${one:-0}" -gt "$maxone" ] && maxone=$one
  [ "${sum:-0}" -gt "$maxsum" ] && maxsum=$sum
  printf 'max single lean RSS %.2f GiB; max sum of lean RSS %.2f GiB (sampled every 5 s; all of this user'"'"'s lean processes)\n' "$(echo "$maxone/1048576" | bc -l)" "$(echo "$maxsum/1048576" | bc -l)" > "$out"
  sleep 5
done
