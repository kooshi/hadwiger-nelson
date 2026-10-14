#!/usr/bin/env bash
# FS131-LP1 (after FS131-LJ1's data/fs131/lj1/run-gate.sh): one whole pass of the gate on one commit, on the laptop,
# under the slot with this machine's budget, one step at a time, each to its own log under data/fs131/lp1/gate/ with its
# exit status on the log's last line and in data/fs131/lp1/gate/run-pass-<tag>.out; every step's wall time and memory
# (the scope's charged peak and the largest single process's resident set: data/fs131/lj1/in-scope.sh, run unchanged by
# path) in data/fs131/lp1/gate/measure-<tag>.txt.  The commit under test and every tracked file modified are written first.
#
# Order (LEAN.md § The gate; the brief's item 6): the build; `lake build --no-build`; the kernel's list of declarations
# (the scan's counter); the sorry scans and the line-initial `axiom` lines; the doubled-name check and its self-test
# BEFORE the axiom audit; the audit and its self-test; the records check (tools/fs131_lp1_records.py) with its plants;
# the port's registration check (FS131-IPD1's tools/fs131_ipd1_register.py check, against the stage-1 commit of that job)
# and the generator's --check on the 31 modules, --parse-all and --self-test; the vacuity scan and its self-test, and the
# scan against the last landing's row for row, with its plants; the assumptions step and its self-test; the architecture
# check; the guarded lint; the notes check and its self-test as the last landing ran them; the stored statements of
# Outside/OAI158 and every module downstream of it that the switch read, Outside/OAI158Collapse and BorelTransfer,
# against the dump made before any edit (byte-identical), and the four edited files in text with every block comment
# removed against the commit before the edits, with its plant; the read-back across pins on lane D's prints dumped from
# this build (the streaming comparator) and the evidence receipts; the baseline's entries and the scans' sources against
# main's; the three digests against the last landing's receipts (FS131-LJ1's, data/fs131/lj1/gate/*-final.log).
# Usage (launched from a snapshot copy): run-gate.sh <tag> <main's hash as merged> [BATCH, default 8]
# LP1_ROOT: the worktree's root, when this runs from a snapshot copy outside data/fs131/lp1/
cd "${LP1_ROOT:-$(dirname "$0")/../../..}" || exit 2
[ -f scripts/build.sh ] && [ -d data/fs131/lp1 ] || { echo "not the worktree's root: $PWD"; exit 2; }
tag="$1"; MAIN="$2"; batch="${3:-8}"; L=data/fs131/lp1; d=$L/gate
[ -n "$tag" ] && [ -n "$MAIN" ] || { echo "usage: run-gate.sh <tag> <main's hash> [BATCH]"; exit 2; }
git cat-file -e "$MAIN^{commit}" || { echo "no such commit: $MAIN"; exit 2; }
mkdir -p "$d"
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
S=/home/kooshi/source/lean-dir/scripts/slot.py
IS=data/fs131/lj1/in-scope.sh
M=data/fs131/lj1/gate         # the previous landing's gated receipts: FS131-LJ1's final pass
BASE=c7122cf10                # this branch at stage 1, the commit before the docstring edits
E="Proofs/HadwigerNelson/Outside/OAI158Collapse.lean Proofs/HadwigerNelson/Outside/OAI158.lean Proofs/HadwigerNelson/Plane/RadiusOutside.lean Proofs/HadwigerNelson/Plane/LebesgueNumber.lean"
MODS31=$(tr -d "\n " < data/fs131/ipd1/order31.txt)
out="$d/run-pass-$tag.out"; meas="$d/measure-$tag.txt"; : > "$meas"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)  host=$(hostname) cores=$(nproc) mem=$(awk '/MemTotal/ {printf "%.0f GiB", $2/1048576}' /proc/meminfo)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"
  echo "main ($MAIN) against this commit, paths that differ under Proofs/ Proofs.lean scripts/ tools/ ARCHITECTURE.md:"
  git diff --name-only "$MAIN" HEAD -- Proofs Proofs.lean scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json | sed 's#^Proofs/HadwigerNelson/Outside/OAI158[A-Z].*#  (a module of Outside/OAI158*)#' | sort | uniq -c; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 --name "lp1-$name" -- "$PWD/$IS" "$PWD/$tmp" "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=$cpus /" "$tmp" >> "$meas"; rm -f "$tmp"
  else echo "MEASURE $name mem-cap=${mem}G cpus=$cpus exit=$st NOT-MEASURED (refused, or killed before its end)" >> "$meas"; fi
  echo "$name exit=$st"; }
lean1() { local name="$1" mem="$2" file="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus 2 --wait 7200 --name "lp1-$name" -- "$PWD/$IS" "$PWD/$tmp" lake env lean "$@" "$file" > "$d/$name-$tag.out" 2> "$d/$name-$tag.err"; local st=$?
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=2 /" "$tmp" >> "$meas"; rm -f "$tmp"; fi
  echo "$name exit=$st"; }
plain() { local name="$1"; shift; local t0=$(date +%s.%N); "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.txt"
  awk -v a="$t0" -v b="$(date +%s.%N)" -v n="$name" -v st="$st" 'BEGIN { printf "MEASURE %s (no slot: a script) exit=%d wall=%.1fs\n", n, st, b - a }' >> "$meas"
  echo "$name exit=$st"; }
{
  t0=$(date +%s)
  "$S" --mem 10 --cpus 4 --wait 7200 --name lp1-build -- /usr/bin/time -f "MAXRSS-KB %M" env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$d/build-$tag.log" 2>&1; st=$?
  t1=$(date +%s); echo "exit=$st" >> "$d/build-$tag.log"; echo "build exit=$st"
  echo "MEASURE build mem-cap=10G cpus=4 BATCH=$batch exit=$st wall=$((t1 - t0))s (slot wait included; build.sh's batches are sibling scopes, each capped at MEMMAX)" >> "$meas"
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  f="$(readlink -f build/gate/build/latest 2>/dev/null)"; [ -f "$f" ] && { cp "$f" "$d/receipt-build-$tag.log"; grep -c 'warning' "$f" | sed 's/^/lake full log lines holding "warning": /'; }
  run uptodate 4 2 lake build --no-build Proofs
  lean1 count-modules 8 data/fs131/l5/count-modules.lean
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines-$tag.txt"; echo "line-initial axiom declarations in Proofs/=$(wc -l < "$d/axiom-lines-$tag.txt")"
  run dupnames 8 4 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  run axioms 8 4 ./scripts/axioms.sh
  run axioms-selftest 8 4 ./scripts/axioms.sh --self-test
  for g in dupnames dupnames-self-test axioms axioms-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain records python3 tools/fs131_lp1_records.py "$d/receipt-axioms-$tag.log"
  plain records-plant python3 tools/fs131_lp1_records.py "$d/receipt-axioms-$tag.log" --plant
  plain register python3 tools/fs131_ipd1_register.py check 5692c3288
  plain gen-check python3 tools/fs131_ko1_port.py --check --modules $MODS31
  plain gen-parse-all python3 tools/fs131_ko1_port.py --parse-all
  plain gen-selftest python3 tools/fs131_ko1_port.py --self-test
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
  lean1 statements 8 $L/lean/StmtDump.lean
  { cmp "$L/stmt/before.out" "$d/statements-$tag.out" && echo "statements: BYTE-IDENTICAL to the dump made before any edit ($(grep -c '^DUMP .* : ' "$d/statements-$tag.out") constants)" || echo "statements: DIFFER"; } > "$d/statements-$tag.txt" 2>&1
  { head -c 2000000 "$d/statements-$tag.out" | sed '0,/(c Nat \[\])/s//(c Int [])/' | cmp -s - <(head -c 2000000 "$L/stmt/before.out") && echo "plant SILENT" || echo "plant: a changed constant in the first 2 MB is seen (DIFFER), as it must"; } > "$d/statements-plant-$tag.txt" 2>&1
  xz -T2 -f "$d/statements-$tag.out"
  plain code-only python3 data/fs131/lc1/code_only_diff.py $BASE $E
  plain code-only-plant python3 data/fs131/lc1/code_only_diff.py $BASE $E --plant
  run dump-here 10 2 bash $L/dump-laneD.sh here
  plain evidence python3 tools/fs131_lp1_instance_evidence.py
  plain evidence-control python3 tools/fs131_lp1_instance_evidence.py --control
  run readback 8 1 python3 tools/fs131_ipa1_readback_port.py compare $L/readback/laneD
  { diff <(git show $MAIN:scripts/vacuity-baseline.txt | grep -E '^UNKNOWN ') <(grep -E '^UNKNOWN ' scripts/vacuity-baseline.txt) && echo "baseline entries: unchanged from main's ($(grep -cE '^UNKNOWN ' scripts/vacuity-baseline.txt))"
    for f in scripts/Vacuity.lean scripts/Assumptions.lean scripts/Axioms.lean scripts/axioms-controls.txt scripts/assumptions-controls.txt scripts/assumptions-ledger.txt scripts/vacuity-baseline.txt scripts/vacuity-controls.lean scripts/DupNames.lean scripts/dupnames-controls.txt scripts/gate_report.py scripts/axioms.sh scripts/vacuity.sh scripts/assumptions.sh scripts/dupnames.sh scripts/build.sh; do
      echo "lines of $f that differ from main's: $(diff <(git show $MAIN:$f) $f | grep -c '^[<>]')"; done; } > "$d/baseline-$tag.txt" 2>&1; echo "baseline-check exit=$?"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-final.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-final.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-final.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done"
} > "$out" 2>&1
