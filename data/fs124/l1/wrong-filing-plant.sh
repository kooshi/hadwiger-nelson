#!/usr/bin/env bash
# FS124-L1: the wrong-filing control on the audit script itself (the implementer's control of its stage 3, run again on
# the merged tree): `radius_five`'s line (under IMPORTED) and `radius_up`'s (under CLEAN) are exchanged in
# scripts/Axioms.lean, the audit is run and must exit 1 naming both — an imported record under CLEAN, a clean one under
# IMPORTED — and the file is put back from a copy whatever happened (trap), its digest compared with the one before.
# Nothing is committed with the plant in it.  Usage (from the worktree's root, no build in flight):
#   data/fs124/l1/wrong-filing-plant.sh
set -u
cd "$(dirname "$0")/../../.." || exit 2
S=/home/kooshi/source/lean-dir/scripts/slot.py
F=scripts/Axioms.lean; d=data/fs124/l1
keep="$(mktemp)"; cp "$F" "$keep"
before="$(sha256sum "$F" | cut -d' ' -f1)"
restore() { cp "$keep" "$F"; rm -f "$keep"; after="$(sha256sum "$F" | cut -d' ' -f1)"
  { echo "digest before: $before"; echo "digest after:  $after"
    [ "$after" = "$before" ] && echo "RESTORED: the audit script is the text it was" || echo "NOT RESTORED"; } | tee "$d/wrong-filing-restore.txt"; }
trap restore EXIT
python3 - "$F" <<'PY'
import sys
p = sys.argv[1]
t = open(p, encoding="utf-8").read()
a = "#print axioms HadwigerNelson.Plane.radius_five\n"
b = "#print axioms HadwigerNelson.Plane.radius_up\n"
assert t.count(a) == 1 and t.count(b) == 1, (t.count(a), t.count(b))
t = t.replace(a, "\0").replace(b, a).replace("\0", b)
open(p, "w", encoding="utf-8").write(t)
print("planted: the two lines exchanged")
PY
"$S" --mem 30 --cpus 4 --wait 7200 -- ./scripts/axioms.sh > "$d/wrong-filing-plant.log" 2>&1
st=$?; echo "exit=$st" >> "$d/wrong-filing-plant.log"
n1=$(grep -c "FAIL import-in-clean 'HadwigerNelson.Plane.radius_five'" "$d/wrong-filing-plant.log")
n2=$(grep -c "FAIL stale-import 'HadwigerNelson.Plane.radius_up'" "$d/wrong-filing-plant.log")
if [ "$st" = 1 ] && [ "$n1" -ge 1 ] && [ "$n2" -ge 1 ]; then echo "WRONG-FILING CONTROL FIRED: exit 1, both records named"; else echo "WRONG-FILING CONTROL DID NOT FIRE (exit $st; $n1, $n2)"; fi
grep -n "^.*FAIL \|check(s) failed\|axioms: " "$d/wrong-filing-plant.log" | cut -c1-220 | head -8
