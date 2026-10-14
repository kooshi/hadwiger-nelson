#!/usr/bin/env bash
# FS131-LJ1 (after FS131-LU1's data/fs131/lu1/run-gate.sh): one whole pass of the gate on one commit, on the laptop,
# under the slot with this machine's budget, one step at a time, each to its own log under data/fs131/lj1/gate/ with
# its exit status on the log's last line and in data/fs131/lj1/gate/run-pass-<tag>.out; every step's wall time and
# memory — the scope's charged peak and the largest single process's resident set (in-scope.sh says what each
# measures) — in data/fs131/lj1/gate/measure-<tag>.txt.  The commit under test and every tracked file modified are
# written first.
#
# Order (LEAN.md § The gate; the brief's item 7): the build (its compilers sampled: sample-lean.sh); the kernel's lists
# of declarations (the scan's counter and this landing's dump); the sorry scans and the line-initial `axiom` lines; the
# doubled-name check and its self-test BEFORE the axiom audit; every declaration the landing brings in a block (this
# job's lj1_records.py); the audit and its self-test; every declaration of the landing filed on what it rests on and
# the whole log's IMPORTED set — the twenty-six the last landings left and this landing's twelve — with sixteen plants;
# the import's block as filed with its two controls (FS132-L1's tool) and the generated modules against the generator,
# with its plants — regression checks of modules this landing does not touch, run because the audit script they read is
# edited; the vacuity scan and its self-test, and the scan against the previous landing's gated scan row for row, with
# its plants; the assumptions step and its self-test; the architecture check; the guarded lint; the notes check and its
# self-test as the last landing ran them; the statements of the landing's six modules as stored against the dump made
# before the merge and before any edit, with its plants, and the six files in text with every block comment removed
# against the merge commit (before the docstring edits), with its plant; the statements by #check with their axioms,
# the four sites of the retired binder and the model terms (checks.lean); the compiled library against the last
# landing's manifest of its gated tree (olean_against_lu1.py: no `.olean` but that landing's three, the root and this
# line's six differs from what that gate read), with its plants, and the statements of the last two landings' modules
# as stored against those landings' own final dumps; the baseline's entries and the scans' sources against main's; the
# three digests against the previous landing's receipts (FS131-LU1's, gated commit c2f4e4f54).
# NOT run here, and why: the import's and the port's stored-term comparisons with the release (tools/fs132_i1_readback.py,
# fs132_i2_readback.py) — this landing recompiles no module they read; olean_against_lu1.py shows their files have the
# bytes the last landing's manifest lists.
# Usage (from anywhere; launched from a snapshot copy): run-gate.sh <tag> <main's hash as merged> [BATCH, default 8]
# LJ1_ROOT: the worktree's root, when this runs from a snapshot copy outside data/fs131/lj1/
cd "${LJ1_ROOT:-$(dirname "$0")/../../..}" || exit 2
[ -f scripts/build.sh ] && [ -d data/fs131/lj1 ] || { echo "not the worktree's root: $PWD"; exit 2; }
tag="$1"; MAIN="$2"; batch="${3:-8}"; L=data/fs131/lj1; d=$L/gate
[ -n "$tag" ] && [ -n "$MAIN" ] || { echo "usage: run-gate.sh <tag> <main's hash> [BATCH]"; exit 2; }
git cat-file -e "$MAIN^{commit}" || { echo "no such commit: $MAIN"; exit 2; }
mkdir -p "$d"
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
S=/home/kooshi/source/lean-dir/scripts/slot.py
M=data/fs131/lu1/gate         # the previous landing's gated receipts: FS131-LU1's final pass, on c2f4e4f54
BASE=fb76f2890                # this branch's merge of main, the commit before the docstring edits
E="Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean Proofs/HadwigerNelson/Arith/TorsionExtraction.lean Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean Proofs/HadwigerNelson/Arith/ThreeFourColours.lean Proofs/HadwigerNelson/Instances/UpperHalfCorollaries.lean"
out="$d/run-pass-$tag.out"; meas="$d/measure-$tag.txt"; : > "$meas"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)  host=$(hostname) cores=$(nproc) mem=$(awk '/MemTotal/ {printf "%.0f GiB", $2/1048576}' /proc/meminfo)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"
  echo "main ($MAIN) against this commit, paths that differ under Proofs/ Proofs.lean scripts/ tools/ ARCHITECTURE.md:"
  git diff --name-only "$MAIN" HEAD -- Proofs Proofs.lean scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json; echo "--"; } > "$d/run-gate-$tag.head"
# run <name> <mem> <cpus> <cmd…>: under the slot, inside in-scope.sh; log $d/<name>-<tag>.log; one MEASURE line
run() { local name="$1" mem="$2" cpus="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 --name "lj1-$name" -- "$PWD/$L/in-scope.sh" "$PWD/$tmp" "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=$cpus /" "$tmp" >> "$meas"; rm -f "$tmp"
  else echo "MEASURE $name mem-cap=${mem}G cpus=$cpus exit=$st NOT-MEASURED (refused, or killed before its end)" >> "$meas"; fi
  echo "$name exit=$st"; }
# lean1 <name> <mem> <file> [lean args…]: one `lake env lean` under the slot, stdout and stderr kept apart
lean1() { local name="$1" mem="$2" file="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus 2 --wait 7200 --name "lj1-$name" -- "$PWD/$L/in-scope.sh" "$PWD/$tmp" lake env lean "$@" "$file" > "$d/$name-$tag.out" 2> "$d/$name-$tag.err"; local st=$?
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=2 /" "$tmp" >> "$meas"; rm -f "$tmp"; fi
  echo "$name exit=$st"; }
plain() { local name="$1"; shift; local t0=$(date +%s.%N); "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.txt"
  awk -v a="$t0" -v b="$(date +%s.%N)" -v n="$name" -v st="$st" 'BEGIN { printf "MEASURE %s (no slot: a script) exit=%d wall=%.1fs\n", n, st, b - a }' >> "$meas"
  echo "$name exit=$st"; }
{
  # --- the build, its compilers sampled
  stop="$d/.sampler-stop-$tag"; rm -f "$stop"; : > "$d/build-$tag.rss"
  setsid "$L/sample-lean.sh" "$PWD" "$d/build-$tag.rss" "$stop" 5 > /dev/null 2>&1 &
  t0=$(date +%s)
  "$S" --mem 10 --cpus 4 --wait 7200 --name lj1-build -- env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$d/build-$tag.log" 2>&1; st=$?
  t1=$(date +%s); touch "$stop"; sleep 7; rm -f "$stop"
  echo "exit=$st" >> "$d/build-$tag.log"; echo "build exit=$st"
  echo "MEASURE build mem-cap=10G cpus=4 BATCH=$batch exit=$st wall=$((t1 - t0))s (slot wait included) $(tail -1 "$d/build-$tag.rss")" >> "$meas"
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  f="$(readlink -f build/gate/build/latest 2>/dev/null)"; [ -f "$f" ] && { cp "$f" "$d/receipt-build-$tag.log"; grep -c 'warning' "$f" | sed 's/^/lake full log lines holding "warning": /'; }
  run uptodate 4 2 lake build --no-build Proofs
  lean1 count-modules 8 data/fs131/l5/count-modules.lean
  lean1 decls 8 $L/decls.lean
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines-$tag.txt"; echo "line-initial axiom declarations in Proofs/=$(wc -l < "$d/axiom-lines-$tag.txt")"
  run dupnames 8 4 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  plain unfiled python3 $L/lj1_records.py "$d/decls-$tag.out" --unfiled scripts/Axioms.lean
  run axioms 8 4 ./scripts/axioms.sh
  run axioms-selftest 8 4 ./scripts/axioms.sh --self-test
  for g in dupnames dupnames-self-test axioms axioms-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain records python3 $L/lj1_records.py "$d/decls-$tag.out" "$d/receipt-axioms-$tag.log"
  plain records-plant python3 $L/lj1_records.py "$d/decls-$tag.out" "$d/receipt-axioms-$tag.log" --plant
  plain theorem-lines python3 $L/lj1_records.py "$d/decls-$tag.out" "$d/receipt-axioms-$tag.log" --lines
  plain block python3 tools/fs132_l1_block.py "$d" "$tag"
  plain port-check python3 tools/fs132_i2_port.py --check
  plain port-selftest python3 tools/fs132_i2_port.py --self-test
  run vacuity 8 4 ./scripts/vacuity.sh
  run vacuity-selftest 8 4 ./scripts/vacuity.sh --self-test
  for g in vacuity vacuity-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain vacdiff python3 tools/fs131_l5_vacdiff.py "$M/receipt-vacuity-final.log" "$d/receipt-vacuity-$tag.log" "$M/count-modules-final.out" "$d/count-modules-$tag.out" --rows
  plain vacdiff-plant python3 tools/fs131_l5_vacdiff.py "$M/receipt-vacuity-final.log" "$d/receipt-vacuity-$tag.log" "$M/count-modules-final.out" "$d/count-modules-$tag.out" --plant
  run assumptions 8 4 ./scripts/assumptions.sh
  run assumptions-selftest 8 4 ./scripts/assumptions.sh --self-test
  for g in assumptions assumptions-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain arch python3 tools/check_architecture.py
  run lint 8 4 lake lint --no-build -- --no-build --trace
  plain notes-l5 python3 tools/fs131_l5_notes.py --only-flagged
  plain notes-qa4-selftest python3 tools/fs131_qa4_notes.py --self-test
  lean1 statements 8 $L/StatementDump.lean; mv "$d/statements-$tag.out" "$d/statements-$tag.raw"
  python3 tools/fs124_l2_statements.py compact "$d/statements-$tag.raw" > "$d/statements-$tag.compact"; echo "statements-compact exit=$?"; rm -f "$d/statements-$tag.raw"
  plain statements python3 tools/fs124_l2_statements.py diff $L/statements/before.compact "$d/statements-$tag.compact"
  plain statements-plant python3 tools/fs124_l2_statements.py diff $L/statements/before.compact "$d/statements-$tag.compact" --plant
  plain code-only python3 $L/code_only_diff.py $BASE $E
  plain code-only-plant python3 $L/code_only_diff.py $BASE $E --plant
  { echo "paths under Proofs/ and Proofs.lean that differ from the commit before the edits ($BASE):"; git diff --stat $BASE HEAD -- Proofs Proofs.lean; } > "$d/proofs-diff-$tag.txt" 2>&1
  lean1 checks 8 $L/checks.lean -DautoImplicit=false -DrelaxedAutoImplicit=false
  plain olean-against-lu1 python3 $L/olean_against_lu1.py
  plain olean-against-lu1-plant python3 $L/olean_against_lu1.py --plant
  lean1 statements-lu1 8 data/fs131/lu1/StatementDump.lean; mv "$d/statements-lu1-$tag.out" "$d/statements-lu1-$tag.raw"
  python3 tools/fs124_l2_statements.py compact "$d/statements-lu1-$tag.raw" > "$d/statements-lu1-$tag.compact"; echo "statements-lu1-compact exit=$?"; rm -f "$d/statements-lu1-$tag.raw"
  plain statements-lu1 python3 tools/fs124_l2_statements.py diff "$M/statements-final.compact" "$d/statements-lu1-$tag.compact"
  lean1 statements-lc1 8 data/fs131/lc1/StatementDump.lean; mv "$d/statements-lc1-$tag.out" "$d/statements-lc1-$tag.raw"
  python3 tools/fs124_l2_statements.py compact "$d/statements-lc1-$tag.raw" > "$d/statements-lc1-$tag.compact"; echo "statements-lc1-compact exit=$?"; rm -f "$d/statements-lc1-$tag.raw"
  plain statements-lc1 python3 tools/fs124_l2_statements.py diff data/fs131/lc1/gate/statements-final.compact "$d/statements-lc1-$tag.compact"
  { diff <(git show $MAIN:scripts/vacuity-baseline.txt | grep -E '^UNKNOWN ') <(grep -E '^UNKNOWN ' scripts/vacuity-baseline.txt) && echo "baseline entries: unchanged from main's ($(grep -cE '^UNKNOWN ' scripts/vacuity-baseline.txt))"
    for f in scripts/Vacuity.lean scripts/Assumptions.lean scripts/Axioms.lean scripts/axioms-controls.txt scripts/assumptions-controls.txt scripts/assumptions-ledger.txt scripts/vacuity-baseline.txt scripts/vacuity-controls.lean scripts/DupNames.lean scripts/dupnames-controls.txt scripts/gate_report.py scripts/axioms.sh scripts/vacuity.sh scripts/assumptions.sh scripts/dupnames.sh scripts/build.sh; do
      echo "lines of $f that differ from main's: $(diff <(git show $MAIN:$f) $f | grep -c '^[<>]')"; done; } > "$d/baseline-$tag.txt" 2>&1; echo "baseline-check exit=$?"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-final.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-final.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-final.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done"
} > "$out" 2>&1
