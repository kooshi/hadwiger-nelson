#!/usr/bin/env bash
# FS124-L2 (FS124-L1's copy of FS132-L1's script as FS132-L2 ran it; the module, the plant's name and the output directory changed): the guarded lint's negative control (after FS131-L8A's, run between its passes). An unused anonymous
# instance binder is planted at the end of the landing's module — a fault the build's own linters do not report and the
# environment linter must — the tree is built, the lint is run and must exit 1 naming the plant, and the module is
# restored by `git checkout` whatever happened (trap), its digest compared with the one taken before the plant.
# Nothing here is committed with the plant in it; the gate's pass afterwards rebuilds the module from the restored text.
# Usage (from the worktree's root, tree clean): data/fs124/l2/lint-plant.sh
set -u
cd "$(dirname "$0")/../../.." || exit 2
S=/home/kooshi/source/lean-dir/scripts/slot.py
F=Proofs/HadwigerNelson/Plane/SectorPoint.lean
d=data/fs124/l2
[ -z "$(git status --porcelain --untracked-files=no)" ] || { echo "tree not clean: refusing to plant"; exit 2; }
before="$(sha256sum "$F" | cut -d' ' -f1)"
echo "$before  $F" > "$d/lint-plant-digest-before.txt"
restore() {
  git checkout -- "$F"
  after="$(sha256sum "$F" | cut -d' ' -f1)"
  { echo "restored digest: $after"; echo "digest before:   $before"
    [ "$after" = "$before" ] && echo "RESTORED: the module is the text it was" || echo "NOT RESTORED"
    echo "plant's name in the file: $(grep -c zz_l2_lint_plant "$F") time(s)"
    echo "tracked files modified: $(git status --porcelain --untracked-files=no | wc -l)"; } | tee "$d/lint-plant-restore.txt"
}
trap restore EXIT
printf '\ntheorem zz_l2_lint_plant [Nonempty ℕ] : (1 : ℕ) = 1 := rfl\n' >> "$F"
echo "planted: $(grep -c zz_l2_lint_plant "$F") line(s)"
"$S" --mem 40 --cpus 8 --wait 7200 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh > "$d/lint-plant-build.log" 2>&1
echo "EXIT=$?" >> "$d/lint-plant-build.log"; tail -3 "$d/lint-plant-build.log"
"$S" --mem 8 --cpus 4 --wait 7200 -- lake lint --no-build -- --no-build --trace > "$d/lint-plant.log" 2>&1
st=$?; echo "exit=$st" >> "$d/lint-plant.log"
if [ "$st" = 1 ] && grep -q "zz_l2_lint_plant" "$d/lint-plant.log"; then echo "LINT CONTROL FIRED: exit 1, the plant named"; else echo "LINT CONTROL DID NOT FIRE (exit $st)"; fi
grep -n "zz_l2_lint_plant\|Failed\|Linting" "$d/lint-plant.log" | head -5
