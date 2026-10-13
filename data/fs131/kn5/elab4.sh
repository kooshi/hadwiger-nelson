#!/usr/bin/env bash
# FS131-KN5: elaborate this line's four skeleton modules in dependency order against the tree's build (the first
# planner's lean1.sh and its olean farm, kept in this job's scratch), one log per module, every exit status printed.
# usage: elab4.sh   (run it under scripts/slot.py --mem 4 --cpus 2)
set -u
root=$(cd "$(dirname "$0")/../../.." && pwd)
export KN4_FARM=${KN5_FARM:?set KN5_FARM to a scratch directory}
mkdir -p "$root/data/fs131/kn5/logs"
rc=0
for m in ThreeColourCharacter TorsionExtraction ThreeColourCriterion DyadicQuadratic; do
  "$root/data/fs131/kn4/lean1.sh" "Arith/$m" > "$root/data/fs131/kn5/logs/$m.out" 2>&1
  e=$?
  n=$(grep -c "declaration uses .sorry." "$root/data/fs131/kn5/logs/$m.out")
  o=$(grep -c -E "error|warning" "$root/data/fs131/kn5/logs/$m.out")
  echo "$m exit=$e sorry=$n messages=$o"
  [ $e -eq 0 ] || rc=1
done
exit $rc
