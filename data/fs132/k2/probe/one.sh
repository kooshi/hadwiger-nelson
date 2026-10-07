#!/bin/bash
# Iteration only (never evidence): elaborate one SixRing module against the built tree plus scratch oleans of
# the modules elaborated before it. Usage: one.sh <Module> (e.g. Basic). Exit status is lean's.
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/olean
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$S:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -o $S/Proofs/HadwigerNelson/Plane/SixRing/$1.olean Proofs/HadwigerNelson/Plane/SixRing/$1.lean
