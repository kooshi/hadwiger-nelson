#!/usr/bin/env bash
# Iteration only, never evidence: elaborate one edited Woodall module and write its olean into the private scratch mirror
# (build/iwb-olean, a `cp -rs` mirror of .lake/build/lib/lean/Proofs). The symlinks are removed first, so nothing writes
# through into .lake/build. usage: data/fs131/iwb/olean.sh Basic|Collar|NoFourFive|Steps
set -uo pipefail
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww
m=$1
D=build/iwb-olean/Proofs/HadwigerNelson/Plane/Woodall
rm -f $D/$m.olean $D/$m.ilean $D/$m.olean.hash $D/$m.ilean.hash $D/$m.trace
exec data/fs131/iwb/run.sh -o $D/$m.olean -i $D/$m.ilean Proofs/HadwigerNelson/Plane/Woodall/$m.lean
