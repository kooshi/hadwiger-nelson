#!/bin/bash
# FS131-IKC4 iteration helper (never evidence; the build is the receipt): compile or elaborate files against a scratch
# farm of .olean files (`build/ikc4farm`, gitignored): a symlink to this tree's compiled `Arith/FibreCert` (core only,
# no Mathlib) and the p = 19 data modules compiled into it. Run under scripts/slot.py.
#   farm.sh o <logdir> <Module> ...   compile Proofs/HadwigerNelson/Arith/<Module>.lean into the farm (lean -o)
#   farm.sh e <logdir> <file.lean> ... elaborate a probe file against the farm (no output written)
# Each file under /usr/bin/time -v; log <logdir>/<name>.log; one line per file in <logdir>/exits.txt.
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf
F=$W/build/ikc4farm
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
cd $W || exit 2
mode="$1"; logdir="$2"; shift 2
mkdir -p "$logdir"
for x in "$@"; do
  if [ "$mode" = o ]; then
    src=Proofs/HadwigerNelson/Arith/$x.lean; n=$x
    rm -f "$F/Proofs/HadwigerNelson/Arith/$x.olean"
    /usr/bin/time -v env LEAN_PATH="$F:$T/lib/lean" $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
      -o "$F/Proofs/HadwigerNelson/Arith/$x.olean" "$src" > "$logdir/$n.log" 2>&1
  else
    n="$(basename "$x" .lean)"
    /usr/bin/time -v env LEAN_PATH="$F:$T/lib/lean" $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
      "$x" > "$logdir/$n.log" 2>&1
  fi
  echo "$n exit $?" >> "$logdir/exits.txt"
done
