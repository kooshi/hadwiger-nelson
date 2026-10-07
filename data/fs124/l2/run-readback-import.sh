#!/usr/bin/env bash
# FS132-L1 — the stored-term comparison, re-run on the joined tree (the brief's step 3).
#
#   data/fs132/l1/run-readback.sh <tag>          (from the worktree's root, after ./scripts/build.sh)
#
# The import's instrument (tools/fs132_i1_readback.py and the dump files under data/fs132/i1/readback/) is run
# unedited; every output of THIS run goes under data/fs132/l1/readback/ with the tag in its name, so the import's
# own prints stay as it committed them and the two runs can be compared.  Every step's exit status is written to
# the summary; the script's own exit is 0 only if every step behaved.
set -u
tag="${1:?usage: run-readback.sh <tag>}"
root="$(git rev-parse --show-toplevel)"
cd "$root" || exit 2
I1=data/fs132/i1/readback
OUT=data/fs124/l2/readback-import
SLOT=/home/kooshi/source/lean-dir/scripts/slot.py
REL_LEAN="$HOME/.elan/toolchains/leanprover--lean4---v4.34.1/bin/lean"
mkdir -p "$OUT"
sum="$OUT/summary-$tag.txt"
: > "$sum"
bad=0
say() { echo "$*" | tee -a "$sum"; }
step() { # step <name> <expected exit> <actual exit>
  if [ "$3" = "$2" ]; then say "STEP $1: exit $3 (expected $2) ok"; else say "STEP $1: exit $3 (expected $2) BAD"; bad=1; fi
}
# the import's own prints hold the slot's admission line ("slot: admitted …", its stderr merged in); this run keeps
# stderr apart, so two prints are compared with that one line taken out of both and nothing else
same() { cmp -s <(grep -v '^slot: ' "$1") <(grep -v '^slot: ' "$2"); }
say "FS124-L1: the import's read-back (FS132-L1's runner as FS132-L2 ran it, its output directory changed and nothing else), tag $tag"
say "commit: $(git rev-parse HEAD)"
say "tracked files modified: $(git status --porcelain --untracked-files=no | wc -l)"
say "module digest: $(sha256sum Proofs/HadwigerNelson/Outside/OAI158.lean | cut -c1-16)  olean: $(sha256sum .lake/build/lib/lean/Proofs/HadwigerNelson/Outside/OAI158.olean | cut -c1-16)"
say "release clone: $(git -C "$HOME/source/math" rev-parse HEAD 2>/dev/null)  clean: $(git -C "$HOME/source/math" status --porcelain 2>/dev/null | wc -l) modified"
marker="$OUT/.marker-$tag"; : > "$marker"; sleep 1

# (1) the release's eight declarations, printed again at the release's pin (Lean v4.34.1's own binary; LEAN_PATH is the
#     audit's compiled working copy; no lake, so nothing is written there)
LEAN_PATH="$(cat "$I1/release-lean-path.txt")" "$SLOT" --mem 16 --cpus 2 -- "$REL_LEAN" "$I1/ReleaseDump.lean" > "$OUT/ReleaseDump-$tag.out" 2> "$OUT/ReleaseDump-$tag.err"
step "release-dump (v4.34.1)" 0 $?
same "$I1/ReleaseDump.out" "$OUT/ReleaseDump-$tag.out"; step "release-dump equals the import's committed print (the slot's line apart)" 0 $?
[ -s "$OUT/ReleaseDump-$tag.out" ] && [ "$(grep -c '^DUMP .* : ' "$OUT/ReleaseDump-$tag.out")" = 8 ]; step "release-dump holds eight declarations" 0 $?

# (2) the module's eight declarations, from the module as built on this tree
"$SLOT" --mem 16 --cpus 2 -- lake env lean "$I1/ModuleDump.lean" > "$OUT/ModuleDump-$tag.out" 2> "$OUT/ModuleDump-$tag.err"
step "module-dump (this pin, the built module)" 0 $?
same "$I1/ModuleDump.out" "$OUT/ModuleDump-$tag.out"; say "NOTE module-dump vs the import's own print (before the join; the slot's line apart): cmp exit $? (0 = identical)"

# (3) the comparison
python3 tools/fs132_i1_readback.py decls "$OUT/ReleaseDump-$tag.out" "$OUT/ModuleDump-$tag.out" > "$OUT/decls-module-$tag.out" 2>&1
step "decls: eight of eight identical" 0 $?

# (4) the comparator's six planted faults
python3 tools/fs132_i1_readback.py --self-test "$OUT/ReleaseDump-$tag.out" "$OUT/ModuleDump-$tag.out" > "$OUT/selftest-$tag.out" 2>&1
step "self-test: six plants fire" 0 $?

# (5) the control in Lean: six declarations altered, two faithful, under the module's imports on this tree
"$SLOT" --mem 16 --cpus 2 -- lake env lean "$I1/ControlDump.lean" > "$OUT/ControlDump-$tag.out" 2> "$OUT/ControlDump-$tag.err"
step "control-dump" 0 $?
python3 tools/fs132_i1_readback.py decls "$OUT/ReleaseDump-$tag.out" "$OUT/ControlDump-$tag.out" \
  --expect-different ProperColoring,angularMeasure,direction,WeakColoring,no_proper_five_coloring,proper_to_borel_weak > "$OUT/decls-control-$tag.out" 2>&1
step "control: six different, two identical" 0 $?
# and the same control WITHOUT the expectation must be refused (the red, seen as a red)
python3 tools/fs132_i1_readback.py decls "$OUT/ReleaseDump-$tag.out" "$OUT/ControlDump-$tag.out" > "$OUT/decls-control-red-$tag.out" 2>&1
step "control read as a plain comparison is refused" 1 $?

# (6) one step down: the 83 constants the statements name, in the module's environment on this tree
"$SLOT" --mem 16 --cpus 2 -- lake env lean "$I1/ModuleLevel1.lean" > "$OUT/ModuleLevel1-$tag.out" 2> "$OUT/ModuleLevel1-$tag.err"
step "module level-one dump" 0 $?
python3 tools/fs132_i1_readback.py level1 "$I1/ReleaseLevel1.out" "$OUT/ModuleLevel1-$tag.out" > "$OUT/level1-$tag.out" 2>&1
step "level one: no constant absent" 0 $?
same "$I1/level1-module.out" "$OUT/level1-$tag.out"; say "NOTE level-one table vs the import's own (before the join): cmp exit $? (0 = identical)"

# (7) the nine characterisations, over the module as built on this tree
"$SLOT" --mem 16 --cpus 2 -- lake env lean "$I1/ModuleSemantic.lean" > "$OUT/ModuleSemantic-$tag.out" 2> "$OUT/ModuleSemantic-$tag.err"
step "nine characterisations elaborate" 0 $?
nmsg=$(( $(wc -c < "$OUT/ModuleSemantic-$tag.out") + $(grep -v '^slot: ' "$OUT/ModuleSemantic-$tag.err" | wc -c) ))
say "characterisations: $nmsg bytes of message from lean (0 = none)"
[ "$nmsg" = 0 ]; step "characterisations elaborate with no message" 0 $?
[ "$(grep -c '^example' "$I1/SemanticBody.lean.inc")" = 9 ]; step "the characterisations' text holds nine examples" 0 $?

# nothing written at the release's side
n1=$(find "$HOME/.cache/ext-oai1" -newer "$marker" -type f 2>/dev/null | wc -l)
n2=$(find "$HOME/source/math" -newer "$marker" -type f 2>/dev/null | wc -l)
say "files written under ~/.cache/ext-oai1 during this run: $n1; under ~/source/math: $n2"
[ "$n1" = 0 ] && [ "$n2" = 0 ] || { say "WROTE AT THE RELEASE'S SIDE — BAD"; bad=1; }
rm -f "$marker"
say "$(tail -2 "$OUT/decls-module-$tag.out" | head -1)"
say "$(tail -1 "$OUT/decls-module-$tag.out")"
say "$(tail -1 "$OUT/selftest-$tag.out")"
say "$(tail -1 "$OUT/decls-control-$tag.out")"
say "$(tail -1 "$OUT/level1-$tag.out")"
if [ "$bad" = 0 ]; then say "READ-BACK RUN $tag: OK"; else say "READ-BACK RUN $tag: FAILED"; fi
exit "$bad"
