#!/usr/bin/env bash
# FS131-LDB1 (after FS133-LD1's data/fs133/ld1/run-gate.sh): one whole pass of the gate on one commit, on the laptop,
# under the slot with this machine's budget, one step at a time, each to its own log under data/fs131/ldb1/gate/ with its
# exit status on the log's last line and in data/fs131/ldb1/gate/run-pass-<tag>.out; every step's wall time and memory
# (the scope's charged peak and the largest single process's resident set: data/fs131/lj1/in-scope.sh, run unchanged by
# path) in data/fs131/ldb1/gate/measure-<tag>.txt.  The commit under test and every tracked file modified are written first.
#
# Order (LEAN.md § The gate; the brief's item 3): the build; `lake build --no-build`; the kernel's list of declarations
# (the scan's counter, FS131-L5's); the sorry scans and the line-initial `axiom` lines; the doubled-name check and its
# self-test BEFORE the axiom audit; the audit and its self-test; the coverage of the density bound's 83 modules by the
# audit's block (data/fs131/ldb1/lean/Coverage.lean) and the records check (tools/fs131_ldb1_records.py) with its plants;
# every generator on its generated modules — the port's 31 (tools/fs131_ko1_port.py --check), the covering's 48
# (tools/fs131_idb1_cells.py: `chain` and `modules`, rewritten in place and required byte-identical), the certificate's 23
# (tools/fs131_kdb1_x23.py --write, the same); the vacuity scan and its self-test, and the scan against the last landing's
# row for row (FS131-L5's vacdiff), with its plants; the assumptions step and its self-test; the architecture check; the
# guarded lint; the notes check and its self-test as the last landing ran them; the stored statements of the density
# bound's 83 modules against the dump before the merge (tools/fs131_ldb1_statement_diff.py, and its self-test); the 83
# files in text with every block comment removed against the commit before the merge, with its plant; the baseline's
# entries and the scans' sources against main's; the three digests against the last landing's receipts (FS133-LD1's,
# data/fs133/ld1/gate/receipt-*-final.log).
# Usage (launched from a snapshot copy): run-gate.sh <tag> <main's hash as merged> [BATCH, default 8]
# LDB1_ROOT: the worktree's root, when this runs from a snapshot copy outside data/fs131/ldb1/
cd "${LDB1_ROOT:-$(dirname "$0")/../../..}" || exit 2
[ -f scripts/build.sh ] && [ -d data/fs131/ldb1 ] || { echo "not the worktree's root: $PWD"; exit 2; }
tag="$1"; MAIN="$2"; batch="${3:-8}"; L=data/fs131/ldb1; d=$L/gate
[ -n "$tag" ] && [ -n "$MAIN" ] || { echo "usage: run-gate.sh <tag> <main's hash> [BATCH]"; exit 2; }
git cat-file -e "$MAIN^{commit}" || { echo "no such commit: $MAIN"; exit 2; }
mkdir -p "$d"
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
S=/home/kooshi/source/lean-dir/scripts/slot.py
IS=data/fs131/lj1/in-scope.sh
M=data/fs133/ld1/gate         # the previous landing's gated receipts: FS133-LD1's final pass
BASE=9fe574044                # this branch at its cut, FS131-IDB3's last commit, before the merge
MODS31=$(tr -d "\n " < data/fs131/ipd1/order31.txt)
out="$d/run-pass-$tag.out"; meas="$d/measure-$tag.txt"; : > "$meas"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)  host=$(hostname) cores=$(nproc) mem=$(awk '/MemTotal/ {printf "%.0f GiB", $2/1048576}' /proc/meminfo)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"
  echo "main ($MAIN) against this commit, paths that differ under Proofs/ Proofs.lean scripts/ tools/ ARCHITECTURE.md:"
  git diff --name-only "$MAIN" HEAD -- Proofs Proofs.lean scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json | grep -c . | sed 's/^/paths: /'
  git diff --name-only "$MAIN" HEAD -- Proofs Proofs.lean scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json | grep -v 'Plane/DensityBound/\|tools/fs131_\(idb\|kdb\|ldb\)'; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 --name "ldb1-$name" -- "$PWD/$IS" "$PWD/$tmp" "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=$cpus /" "$tmp" >> "$meas"; rm -f "$tmp"
  else echo "MEASURE $name mem-cap=${mem}G cpus=$cpus exit=$st NOT-MEASURED (refused, or killed before its end)" >> "$meas"; fi
  echo "$name exit=$st"; }
lean1() { local name="$1" mem="$2" file="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus 2 --wait 7200 --name "ldb1-$name" -- "$PWD/$IS" "$PWD/$tmp" lake env lean "$@" "$file" > "$d/$name-$tag.out" 2> "$d/$name-$tag.err"; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.err"
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=2 /" "$tmp" >> "$meas"; rm -f "$tmp"; fi
  echo "$name exit=$st"; }
plain() { local name="$1"; shift; local t0=$(date +%s.%N); "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.txt"
  awk -v a="$t0" -v b="$(date +%s.%N)" -v n="$name" -v st="$st" 'BEGIN { printf "MEASURE %s (no slot: a script) exit=%d wall=%.1fs\n", n, st, b - a }' >> "$meas"
  echo "$name exit=$st"; }
{
  t0=$(date +%s)
  "$S" --mem 10 --cpus 4 --wait 7200 --name ldb1-build -- /usr/bin/time -f "MAXRSS-KB %M" env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$d/build-$tag.log" 2>&1; st=$?
  t1=$(date +%s); echo "exit=$st" >> "$d/build-$tag.log"; echo "build exit=$st"
  echo "MEASURE build mem-cap=10G cpus=4 BATCH=$batch exit=$st wall=$((t1 - t0))s (slot wait included; build.sh's batches are sibling scopes, each capped at MEMMAX)" >> "$meas"
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  f="$(readlink -f build/gate/build/latest 2>/dev/null)"; [ -f "$f" ] && { cp "$f" "$d/receipt-build-$tag.log"; grep -c 'warning' "$f" | sed 's/^/lake full log lines holding "warning": /'; }
  run uptodate 4 2 lake build --no-build Proofs
  lean1 count-modules 8 data/fs131/l5/count-modules.lean
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines-$tag.txt"; echo "line-initial axiom declarations in Proofs/=$(wc -l < "$d/axiom-lines-$tag.txt")"
  grep -rln 'native_decide' --include='*.lean' Proofs/HadwigerNelson/Plane/DensityBound Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean > "$d/native-density-$tag.txt"; echo "files of the density bound naming native_decide=$(wc -l < "$d/native-density-$tag.txt")"
  run dupnames 8 4 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  run axioms 8 4 ./scripts/axioms.sh
  run axioms-selftest 8 4 ./scripts/axioms.sh --self-test
  for g in dupnames dupnames-self-test axioms axioms-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  lean1 coverage 5 $L/lean/Coverage.lean
  plain records python3 tools/fs131_ldb1_records.py "$d/receipt-axioms-$tag.log" --coverage "$d/coverage-$tag.out"
  plain records-plant python3 tools/fs131_ldb1_records.py "$d/receipt-axioms-$tag.log" --coverage "$d/coverage-$tag.out" --plant
  plain gen-check python3 tools/fs131_ko1_port.py --check --modules $MODS31
  plain gen-cells-chain python3 tools/fs131_idb1_cells.py chain
  plain gen-cells-modules python3 tools/fs131_idb1_cells.py modules
  plain gen-x23 python3 tools/fs131_kdb1_x23.py --write
  { echo "tracked files the generators rewrote with other bytes (git status --porcelain, untracked hidden):"
    git status --porcelain --untracked-files=no -- Proofs/HadwigerNelson/Plane/DensityBound data/fs131/idb1/gen data/fs131/idb3/gen
    echo "count=$(git status --porcelain --untracked-files=no -- Proofs/HadwigerNelson/Plane/DensityBound data/fs131/idb1/gen data/fs131/idb3/gen | wc -l)"; } > "$d/gen-identical-$tag.txt" 2>&1
  echo "generators: $(tail -1 "$d/gen-identical-$tag.txt")"
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
  lean1 statements 8 $L/lean/StatementDump.lean
  plain statements-diff python3 tools/fs131_ldb1_statement_diff.py $L/statements-before.txt "$d/statements-$tag.out"
  plain statements-selftest python3 tools/fs131_ldb1_statement_diff.py --self-test "$d/statements-$tag.out"
  [ -f "$d/statements-$tag.out" ] && { sha256sum "$d/statements-$tag.out" > "$d/statements-$tag.sha256"; xz -T2 -f "$d/statements-$tag.out"; }
  plain code-only python3 tools/fs131_ldb1_code_only.py $BASE
  plain code-only-plant python3 tools/fs131_ldb1_code_only.py $BASE --plant
  { diff <(git show $MAIN:scripts/vacuity-baseline.txt | grep -E '^UNKNOWN ') <(grep -E '^UNKNOWN ' scripts/vacuity-baseline.txt) && echo "baseline entries: unchanged from main's ($(grep -cE '^UNKNOWN ' scripts/vacuity-baseline.txt))"
    for f in scripts/Vacuity.lean scripts/Assumptions.lean scripts/Axioms.lean scripts/axioms-controls.txt scripts/assumptions-controls.txt scripts/assumptions-ledger.txt scripts/vacuity-baseline.txt scripts/vacuity-controls.lean scripts/DupNames.lean scripts/dupnames-controls.txt scripts/gate_report.py scripts/axioms.sh scripts/vacuity.sh scripts/assumptions.sh scripts/dupnames.sh scripts/build.sh; do
      echo "lines of $f that differ from main's: $(diff <(git show $MAIN:$f) $f | grep -c '^[<>]')"; done; } > "$d/baseline-$tag.txt" 2>&1; echo "baseline-check exit=$?"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-final.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-final.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-final.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done"
} > "$out" 2>&1
