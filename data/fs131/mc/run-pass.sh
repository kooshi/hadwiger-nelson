#!/usr/bin/env bash
# FS131-MC1: one pass of the gate after a green build — the kernel's own list of the library's declarations, then the gate's steps
# (data/fs131/mc/run-gate.sh). usage: data/fs131/mc/run-pass.sh <tag>; the last line of data/fs131/mc/run-pass-<tag>.out is `pass-exit=…`.
cd "$(dirname "$0")/../../.."
tag="$1"; d=data/fs131/mc
{
  /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 --wait 3600 -- lake env lean data/fs131/l5/count-modules.lean \
    > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  ./data/fs131/mc/run-gate.sh "$tag"; echo "run-gate exit=$?"
  echo "pass-exit=done"
} > "$d/run-pass-$tag.out" 2>&1
