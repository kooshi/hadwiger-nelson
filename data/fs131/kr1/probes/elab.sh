#!/usr/bin/env bash
# Elaborate the given modules one at a time with lake env lean; logs under data/fs131/kr1/logs/.
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch
source scripts/dev-env.sh >/dev/null 2>&1
mkdir -p data/fs131/kr1/logs
for m in "$@"; do
  f=Proofs/HadwigerNelson/$m.lean
  log=data/fs131/kr1/logs/$(echo $m | tr / _).log
  lake env lean "$f" > "$log" 2>&1
  echo "$m exit=$?"
done
