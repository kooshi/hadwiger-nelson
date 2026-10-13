#!/usr/bin/env bash
# FS131-IN1 — an iteration device, never evidence.  This worktree's `.lake/build` is an older job's (2026-10-07) and
# holds no `.olean` of this line's upstream modules (`Arith/TorsionExtraction`, `Arith/ThreeColourCharacter`), so
# `lake env lean` on the module fails at its first import.  This script makes a scratch farm: REAL COPIES (not
# symlinks: the source tree may be rebuilt by another job) of the `.olean`s of the import closure of
# `Proofs.HadwigerNelson.Arith.ThreeColourCriterion` within `Proofs`, taken from the planners' tree fs131-wr2, whose
# library was built from the skeleton's sources (only `Arith/TorsionExtraction.lean` differs there: its proofs, same
# statements).  The farm lives under this worktree's gitignored `build/` (on disk, regenerable by this script).
# The closure is computed from the SOURCE tree's files (the `.olean`s are its).
# usage: data/fs131/in1/farm.sh      (prints the module count, the bytes, and a digest of the copied files)
set -euo pipefail
here=$(cd "$(dirname "$0")/../../.." && pwd)
src=${IN1_SRC:-/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2}
farm=$here/build/in1-farm
lib=$src/.lake/build/lib/lean
rm -rf "$farm"; mkdir -p "$farm"
python3 - "$src" "$farm" "$lib" <<'PY'
import re, sys, shutil, hashlib, pathlib
src, farm, lib = map(pathlib.Path, sys.argv[1:4])
todo, seen = ["Proofs.HadwigerNelson.Arith.ThreeColourCriterion"], []
while todo:
    m = todo.pop()
    if m in seen: continue
    seen.append(m)
    f = src / (m.replace(".", "/") + ".lean")
    if not f.exists(): sys.exit(f"NO SOURCE for {m}")
    for imp in re.findall(r"^(?:public )?import (Proofs\.[\w.]+)", f.read_text(), flags=re.M):
        todo.append(imp)
h, total = hashlib.sha256(), 0
for m in sorted(seen):
    if m == "Proofs.HadwigerNelson.Arith.ThreeColourCriterion": continue   # the module under work is never read from the farm
    rel = m.replace(".", "/") + ".olean"
    s, d = lib / rel, farm / rel
    if not s.exists(): sys.exit(f"NO OLEAN for {m} in {lib}")
    d.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(s, d)
    b = d.read_bytes(); total += len(b); h.update(rel.encode()); h.update(hashlib.sha256(b).digest())
print(f"farm: {len(seen) - 1} upstream modules copied, {total} bytes, digest {h.hexdigest()[:16]}")
PY
# Step 2: the one upstream module whose SOURCE differs between the two trees is recompiled into the farm from THIS
# tree's source (the skeleton: every leaf `sorry`), so the farm holds exactly what this tree's build will hold —
# no helper of the other implementer's proofs can be read by accident, and an upstream `sorry` shows as `sorryAx`.
cd "$here"
own=$here/.lake/build/lib/lean
LP="$farm:$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "^$own\$" | paste -sd:)"
for m in Arith/TorsionExtraction; do
  if ! diff -q "$src/Proofs/HadwigerNelson/$m.lean" "$here/Proofs/HadwigerNelson/$m.lean" > /dev/null; then
    env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name in1 -- \
      env LEAN_PATH="$LP" lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$farm/Proofs/HadwigerNelson/$m.olean" \
      "Proofs/HadwigerNelson/$m.lean" > "$farm/$(basename $m).out" 2>&1 || { cat "$farm/$(basename $m).out"; exit 1; }
    echo "farm: $m recompiled from this tree's source ($(grep -c 'declaration uses' "$farm/$(basename $m).out") sorry warnings, $(grep -c ': error' "$farm/$(basename $m).out") errors)"
  fi
done
# every other upstream source must be the same file in the two trees
python3 - "$src" "$here" "$farm" <<'PY'
import sys, pathlib
src, here, farm = map(pathlib.Path, sys.argv[1:4])
bad = []
for o in farm.rglob("*.olean"):
    rel = o.relative_to(farm).with_suffix(".lean")
    if rel.name == "TorsionExtraction.lean": continue
    if (src / rel).read_bytes() != (here / rel).read_bytes(): bad.append(str(rel))
print(f"farm: sources of the copied modules identical in the two trees: {'yes' if not bad else 'NO: ' + ' '.join(bad)}")
sys.exit(1 if bad else 0)
PY
