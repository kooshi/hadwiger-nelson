#!/usr/bin/env bash
# FS131-LDB1 (FS133-LD1's data/fs133/ld1/lint-plant.sh, the module, the plant's name and the paths changed; before that FS131-LP1's, and FS131-LJ1's, the module (a leaf: only the root imports it), the plant's name and the paths changed; before that FS131-LU1's, the module, the plant's name and the paths changed; before that FS131-LC1's, which is FS124-L2's script; the module, the plant's name and the output directory
# changed): the guarded lint's negative control.  An unused anonymous instance binder is planted at the end of the
# landing's module — a fault the build's own linters do not report and the environment linter must — the tree is built,
# the lint is run and must exit 1 naming the plant, and the module is restored by `git checkout` whatever happened
# (trap), its digest compared with the one taken before the plant.  Nothing here is committed with the plant in it;
# the gate's pass afterwards rebuilds the module and the root from the restored text.
# Usage (from the worktree's root, tree clean): data/fs131/ldb1/lint-plant.sh [BATCH, default 8]
# With the plant in, the stale set is the planted module, the root (nothing else imports the module:
# data/fs131/lc1/dependents.py) and whatever docstring was edited since the last build, so the wide batch compiles one
# module at a time.
set -u
cd "$(dirname "$0")/../../.." || exit 2
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
S=/home/kooshi/source/lean-dir/scripts/slot.py
F=Proofs/HadwigerNelson/Plane/DensityBound/Theorem.lean
d=data/fs131/ldb1; batch="${1:-8}"
[ -z "$(git status --porcelain --untracked-files=no)" ] || { echo "tree not clean: refusing to plant"; exit 2; }
before="$(sha256sum "$F" | cut -d' ' -f1)"
echo "$before  $F" > "$d/lint-plant-digest-before.txt"
restore() {
  git checkout -- "$F"
  after="$(sha256sum "$F" | cut -d' ' -f1)"
  { echo "restored digest: $after"; echo "digest before:   $before"
    [ "$after" = "$before" ] && echo "RESTORED: the module is the text it was" || echo "NOT RESTORED"
    echo "plant's name in the file: $(grep -c zz_ldb1_lint_plant "$F") time(s)"
    echo "tracked files modified: $(git status --porcelain --untracked-files=no | wc -l)"; } | tee "$d/lint-plant-restore.txt"
}
trap restore EXIT
printf '\ntheorem zz_ldb1_lint_plant [Nonempty ℕ] : (1 : ℕ) = 1 := rfl\n' >> "$F"
echo "planted: $(grep -c zz_ldb1_lint_plant "$F") line(s)"
t0=$(date +%s)
"$S" --mem 10 --cpus 4 --wait 7200 --name ldb1-lint-plant-build -- env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$d/lint-plant-build.log" 2>&1
echo "EXIT=$? WALL_SECONDS=$(( $(date +%s) - t0 )) BATCH=$batch" >> "$d/lint-plant-build.log"; tail -3 "$d/lint-plant-build.log"
"$S" --mem 8 --cpus 4 --wait 7200 --name ldb1-lint-plant -- lake lint --no-build -- --no-build --trace > "$d/lint-plant.log" 2>&1
st=$?; echo "exit=$st" >> "$d/lint-plant.log"
if [ "$st" = 1 ] && grep -q "zz_ldb1_lint_plant" "$d/lint-plant.log"; then echo "LINT CONTROL FIRED: exit 1, the plant named"; else echo "LINT CONTROL DID NOT FIRE (exit $st)"; fi
grep -n "zz_ldb1_lint_plant\|Failed\|Linting" "$d/lint-plant.log" | head -5
