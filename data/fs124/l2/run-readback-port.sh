#!/usr/bin/env bash
# FS132-L2 — the port's stored-term comparison, re-run on the joined tree (the brief's item 4 (c)), as the port's record
# § 3.3 runs it.  The port's instrument (tools/fs132_i2_readback.py, the dumper files under data/fs132/i2/readback/) is
# run unedited; every print of THIS run goes under data/fs132/l2/readback-port/ with the tag in its name.  `compare`
# writes its two tables into the port's own directory (the tool's fixed place): the summary says whether git then sees
# them changed.
#   data/fs132/l2/run-readback-port.sh <tag>      (from the worktree's root, after ./scripts/build.sh)
set -u
tag="${1:?usage: run-readback-port.sh <tag>}"
cd "$(git rev-parse --show-toplevel)" || exit 2
I2=data/fs132/i2/readback
OUT=data/fs124/l2/readback-port
SLOT=/home/kooshi/source/lean-dir/scripts/slot.py
REL_LEAN="$HOME/.elan/toolchains/leanprover--lean4---v4.34.1/bin/lean"
mkdir -p "$OUT"
sum="$OUT/summary-$tag.txt"; : > "$sum"; bad=0
say() { echo "$*" | tee -a "$sum"; }
step() { if [ "$3" = "$2" ]; then say "STEP $1: exit $3 (expected $2) ok"; else say "STEP $1: exit $3 (expected $2) BAD"; bad=1; fi; }
say "FS124-L1: the port's read-back (FS132-L2's runner, its output directory changed and nothing else), tag $tag"
say "commit: $(git rev-parse HEAD)"
say "tracked files modified: $(git status --porcelain --untracked-files=no | wc -l)"
say "release clone: $(git -C "$HOME/source/math" rev-parse HEAD 2>/dev/null)  clean: $(git -C "$HOME/source/math" status --porcelain 2>/dev/null | wc -l) modified"
marker="$OUT/.marker-$tag"; : > "$marker"; sleep 1

# (1) the release's print, made again at the release's pin (Lean v4.34.1's own binary; no lake; nothing written there)
LEAN_PATH="$(tr -d '\n' < data/fs132/i1/readback/release-lean-path.txt)" "$SLOT" --mem 12 --cpus 2 -- "$REL_LEAN" "$I2/ReleaseDump.lean" > "$OUT/ReleaseDump-$tag.out" 2> "$OUT/ReleaseDump-$tag.err"
step "release-dump (v4.34.1)" 0 $?
want=$(grep ' ReleaseDump.out$' "$I2/prints.sha256" | cut -d' ' -f1); got=$(sha256sum "$OUT/ReleaseDump-$tag.out" | cut -d' ' -f1)
say "release print digest: $got; the port's committed print: $want"
[ "$got" = "$want" ]; step "release-dump is the port's committed print, byte for byte" 0 $?

# (2) this library's print, from the modules as built on this tree
"$SLOT" --mem 12 --cpus 2 -- lake env lean "$I2/HereDump.lean" > "$OUT/HereDump-$tag.out" 2> "$OUT/HereDump-$tag.err"
step "here-dump (this pin, the built modules)" 0 $?
want=$(grep ' HereDump.out$' "$I2/prints.sha256" | cut -d' ' -f1); got=$(sha256sum "$OUT/HereDump-$tag.out" | cut -d' ' -f1)
say "here print digest: $got; the port's own print (on its branch, before the join and the scoping): $want — $([ "$got" = "$want" ] && echo IDENTICAL || echo DIFFERENT)"

# (3) the verdicts
python3 tools/fs132_i2_readback.py compare "$OUT/ReleaseDump-$tag.out" "$OUT/HereDump-$tag.out" > "$OUT/compare-$tag.out" 2>&1
step "compare: READBACK OK" 0 $?
cmp -s "$I2/compare.out" "$OUT/compare-$tag.out"; say "NOTE compare's output vs the port's own: cmp exit $? (0 = identical)"
say "the port's tables after this run, as git sees them: $(git status --porcelain -- "$I2/targets-and-definitions.tsv" "$I2/lemmas.tsv" "$I2/instance-constants.txt" | wc -l) changed"

# (4) the comparator's planted faults
python3 tools/fs132_i2_readback.py --self-test "$OUT/ReleaseDump-$tag.out" "$OUT/HereDump-$tag.out" > "$OUT/selftest-$tag.out" 2>&1
step "self-test: every plant refused" 0 $?

# (5) one level down, in this tree's environment
"$SLOT" --mem 12 --cpus 2 -- lake env lean "$I2/HereLevel1.lean" > "$OUT/HereLevel1-$tag.out" 2> "$OUT/HereLevel1-$tag.err"
step "here level-one dump" 0 $?
python3 tools/fs132_i2_readback.py level1 "$I2/ReleaseLevel1.out" "$OUT/HereLevel1-$tag.out" > "$OUT/level1-$tag.out" 2>&1
step "level one" 0 $?
cmp -s "$I2/level1.out" "$OUT/level1-$tag.out"; say "NOTE level-one table vs the port's own: cmp exit $? (0 = identical)"

n1=$(find "$HOME/.cache/ext-oai1" -newer "$marker" -type f 2>/dev/null | wc -l)
n2=$(find "$HOME/source/math" -newer "$marker" -type f 2>/dev/null | wc -l)
say "files written under ~/.cache/ext-oai1 during this run: $n1; under ~/source/math: $n2"
[ "$n1" = 0 ] && [ "$n2" = 0 ] || { say "WROTE AT THE RELEASE'S SIDE — BAD"; bad=1; }
rm -f "$marker"
say "$(tail -1 "$OUT/compare-$tag.out")"
say "$(tail -1 "$OUT/selftest-$tag.out")"
say "$(tail -1 "$OUT/level1-$tag.out")"
# the two large prints are kept compressed
xz -f -T2 "$OUT/ReleaseDump-$tag.out" "$OUT/HereDump-$tag.out"
if [ "$bad" = 0 ]; then say "PORT READ-BACK RUN $tag: OK"; else say "PORT READ-BACK RUN $tag: FAILED"; fi
exit "$bad"
