#!/usr/bin/env bash
# FS131-I10B: the environment linters on a scratch copy of the module, and their negative control.
# Iteration only (never the gate's run): `lake env lean` on a copy of `StationaryRatio.lean` with `#lint` appended.
#   pass:    the module as committed                       -> data/fs131/i10b/logs/lint-pass.txt     (expect: 0 errors)
#   control: the same with every `have _ := …` line removed -> data/fs131/i10b/logs/lint-control.txt  (expect: unusedArguments
#            names the seven statement arguments the proofs do not read, and exit 1)
# Run from the worktree root, under the slot: scripts/slot.py --mem 6 --cpus 2 -- data/fs131/i10b/lint-control.sh
set -u
SRC=Proofs/HadwigerNelson/Arith/StationaryRatio.lean
D=data/fs131/i10b/scratch
python3 - "$SRC" "$D" <<'PY'
import re, sys
src, d = sys.argv[1], sys.argv[2]
s = open(src).read()
anchor = "import Mathlib.Topology.Instances.ZMod\n"
assert s.count(anchor) == 1
s = s.replace(anchor, anchor + "import Mathlib.Tactic.Linter.Lint\nimport Batteries.Tactic.Lint\n")
open(f"{d}/lint-pass.lean", "w").write(s + "\n#lint\n")
n = len(re.findall(r"^  have _ := .*\n", s, flags=re.M))
open(f"{d}/lint-control.lean", "w").write(re.sub(r"^  have _ := .*\n", "", s, flags=re.M) + "\n#lint\n")
print("consuming lines removed for the control:", n)
PY
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$D/lint-pass.lean" > data/fs131/i10b/logs/lint-pass.txt 2>&1
p=$?; echo "exit=$p" >> data/fs131/i10b/logs/lint-pass.txt
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$D/lint-control.lean" > data/fs131/i10b/logs/lint-control.txt 2>&1
c=$?; echo "exit=$c" >> data/fs131/i10b/logs/lint-control.txt
rm -f "$D/lint-pass.lean" "$D/lint-control.lean"
echo "pass exit=$p (want 0); control exit=$c (want 1)"
[ "$p" -eq 0 ] && [ "$c" -eq 1 ]
