#!/usr/bin/env bash
# FS131-LU1 (FS131-LC1's, after FS124-L2's; the module, the plant's name and the paths changed): the zero-sorry search's negative control.  A theorem with a `sorry` body is appended
# to the landing's module — never built, never committed — the gate's narrow search is run and must find exactly that
# line, and the module is restored by `git checkout` whatever happened (trap), its digest compared with the one taken
# before.  Usage (from the worktree's root, tree clean, no build or pass in flight): data/fs131/lu1/sorry-plant.sh
set -u
cd "$(dirname "$0")/../../.." || exit 2
F=Proofs/HadwigerNelson/Instances/UpperHalfValues.lean
[ -z "$(git status --porcelain --untracked-files=no)" ] || { echo "tree not clean: refusing to plant"; exit 2; }
search() { grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean; }
echo "HEAD=$(git rev-parse HEAD)"
echo "narrow lines before the plant: $(search | wc -l)"
before="$(sha256sum "$F" | cut -d' ' -f1)"
restore() {
  git checkout -- "$F"
  after="$(sha256sum "$F" | cut -d' ' -f1)"
  echo "digest before: $before"; echo "digest after:  $after"
  [ "$after" = "$before" ] && echo "RESTORED: the module is the text it was" || echo "NOT RESTORED"
  echo "plant's name in the file: $(grep -c zz_lu1_sorry_plant "$F") time(s)"
  echo "narrow lines after the restore: $(search | wc -l)"
  echo "tracked files modified: $(git status --porcelain --untracked-files=no | wc -l)"
}
trap restore EXIT
printf '\ntheorem zz_lu1_sorry_plant : (1 : ℕ) = 2 := by sorry\n' >> "$F"
n="$(search | wc -l)"
echo "narrow lines with the plant: $n"
search | cut -c1-160
if [ "$n" = 1 ] && search | grep -q "UpperHalfValues.lean:.*zz_lu1_sorry_plant"; then echo "PLANT FIRED: the search finds the planted sorry and nothing else"; else echo "PLANT DID NOT FIRE"; fi
