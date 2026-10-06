#!/usr/bin/env bash
# FS131-L5 (after FS131-OL1's data/fs131/ol/run-gate.sh): the gate's steps after the build, under the slot, one at a time, each
# to its own driver log with its exit status on the log's last line. The commit under test is written first. Order (LEAN.md
# § The gate, as filed 2026-10-06): the doubled-name check and its self-test BEFORE the axiom audit; the audit and its
# self-test; the vacuity scan and its self-test; the architecture check; the guarded lint; the notes check; the sorry scan.
# Usage (from the worktree root, after a green ./scripts/build.sh): data/fs131/l5/run-gate.sh <tag>
tag="$1"; d=data/fs131/l5; S=/home/kooshi/source/lean-dir/scripts/slot.py
[ -n "$tag" ] || { echo "usage: run-gate.sh <tag>"; exit 2; }
{ echo "HEAD=$(git rev-parse HEAD)"; echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/' ; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3
  "$S" --mem "$mem" --cpus "$cpus" --wait 3600 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
run dupnames 16 8 ./scripts/dupnames.sh
run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
run axioms 30 4 ./scripts/axioms.sh
run axioms-selftest 30 4 ./scripts/axioms.sh --self-test
run vacuity 30 4 ./scripts/vacuity.sh
run vacuity-selftest 30 4 ./scripts/vacuity.sh --self-test
python3 tools/check_architecture.py > "$d/arch-$tag.txt" 2>&1; st=$?; echo "exit=$st" >> "$d/arch-$tag.txt"; echo "arch exit=$st"
run lint 8 4 lake lint --no-build -- --no-build --trace
python3 tools/fs131_l5_notes.py --only-flagged > "$d/notes-$tag.txt" 2>&1; st=$?; echo "exit=$st" >> "$d/notes-$tag.txt"; echo "notes exit=$st"
grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
for g in build dupnames dupnames-self-test axioms axioms-self-test vacuity vacuity-self-test; do
  f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f"
  [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
done >> "$d/run-gate-$tag.head"
echo DONE
