#!/usr/bin/env bash
# Iteration only, never evidence. Usage: errs.sh Plane/SVMap — compile the module's olean into the scratch mirror (iter.sh) and print
# each error/warning header with up to 8 following lines, each cut to 220 characters.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4
bash $W/data/fs131/i4/iter.sh "$@" 2>&1 | awk '/^Proofs\/.*: (error|warning)/{n=8} n>0{print substr($0,1,220); n--}'
