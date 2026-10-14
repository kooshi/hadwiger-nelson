#!/bin/bash
# FS131-IPA1: elaborate the named modules in the order given (dependency order), each through farm-run.sh with the
# label $1; stops at the first module whose exit status is not 0 or whose log holds an error or a warning.
L=$1; shift
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
for m in "$@"; do
  bash $W/data/fs131/ipa1/farm-run.sh "$m" "$L"
  rc=$(cat $W/data/fs131/ipa1/farm/$m-$L.rc)
  if [ "$rc" != 0 ] || grep -q ': error\|: warning' $W/data/fs131/ipa1/farm/$m-$L.out; then echo "STOPPED at $m"; exit 1; fi
done
echo "ALL ELABORATED: $# modules, label $L"
