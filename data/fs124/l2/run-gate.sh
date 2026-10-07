#!/usr/bin/env bash
# FS124-L2 (after FS124-L1's data/fs124/l1/run-gate.sh): one whole pass of the gate on one commit, under the slot, one
# step at a time, each to its own log under data/fs124/l2/gate/ with its exit status on the log's last line and in
# data/fs124/l2/gate/run-pass-<tag>.out.  The commit under test and every tracked file modified are written first.
#
# Order (LEAN.md § The gate; the brief's item 7): the build; the kernel's lists of declarations (the scan's counter and
# this landing's dump); the sorry scans; the doubled-name check and its self-test BEFORE the axiom audit; every
# declaration the landing brings in a block (this job's tool); the audit and its self-test; every declaration of the
# landing filed under CLEAN on the standard three or fewer, and the whole log's IMPORTED set as filed (this job's tool,
# with its twelve plants); the import's block as filed with its two controls (FS132-L1's tool); the generated modules
# and the licence copy against the generator, with its plants; the vacuity scan and its self-test, and the scan against
# main's gated scan row for row, with its plants; the assumptions step and its self-test; the architecture check; the
# guarded lint; the notes check and its self-test as the last landing ran them; both stored-term comparisons with the
# release on the modules as built on this commit; the statements as stored against the dump made before the modules
# were recompiled, with its plants; the statements by #check with their axioms and the models; the baseline's entries
# against main's; the three digests against the previous landing's receipts (FS124-L1's, gated commit 24a42aa9).
# Usage (from anywhere): data/fs124/l2/run-gate.sh <tag>
cd "$(dirname "$0")/../../.." || exit 2
tag="$1"; d=data/fs124/l2/gate; S=/home/kooshi/source/lean-dir/scripts/slot.py
[ -n "$tag" ] || { echo "usage: run-gate.sh <tag>"; exit 2; }
mkdir -p "$d"
M=data/fs124/l1/gate          # main's gated receipts: FS124-L1's final pass, on 24a42aa9
out="$d/run-pass-$tag.out"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"
  echo "main's Proofs/, Proofs.lean, scripts/ since the previous landing's gated commit: $(git diff --name-only 24a42aa9 origin/main -- Proofs Proofs.lean scripts | wc -l) path(s) differ"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
plain() { local name="$1"; shift; "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?; echo "exit=$st" >> "$d/$name-$tag.txt"; echo "$name exit=$st"; }
{
  run build 40 8 env MEMMAX=40G BATCH=4 ./scripts/build.sh
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  f="$(readlink -f build/gate/build/latest 2>/dev/null)"; [ -f "$f" ] && { cp "$f" "$d/receipt-build-$tag.log"; grep -c 'warning' "$f" | sed 's/^/lake full log lines holding "warning": /'; }
  "$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs131/l5/count-modules.lean > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  "$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs124/l2/decls.lean > "$d/decls-$tag.out" 2> "$d/decls-$tag.err"; echo "decls exit=$?"
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines-$tag.txt"; echo "line-initial axiom declarations in Proofs/=$(wc -l < "$d/axiom-lines-$tag.txt")"
  run dupnames 16 8 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  plain unfiled python3 tools/fs124_l2_records.py "$d/decls-$tag.out" --unfiled scripts/Axioms.lean
  run axioms 30 4 ./scripts/axioms.sh
  run axioms-selftest 30 4 ./scripts/axioms.sh --self-test
  for g in dupnames dupnames-self-test axioms axioms-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain records python3 tools/fs124_l2_records.py "$d/decls-$tag.out" "$d/receipt-axioms-$tag.log"
  plain records-plant python3 tools/fs124_l2_records.py "$d/decls-$tag.out" "$d/receipt-axioms-$tag.log" --plant
  plain block python3 tools/fs132_l1_block.py "$d" "$tag"
  plain port-check python3 tools/fs132_i2_port.py --check
  plain port-selftest python3 tools/fs132_i2_port.py --self-test
  run vacuity 30 4 ./scripts/vacuity.sh
  run vacuity-selftest 30 4 ./scripts/vacuity.sh --self-test
  for g in vacuity vacuity-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain vacdiff python3 tools/fs131_l5_vacdiff.py "$M/receipt-vacuity-final.log" "$d/receipt-vacuity-$tag.log" "$M/count-modules-final.out" "$d/count-modules-$tag.out" --rows
  plain vacdiff-plant python3 tools/fs131_l5_vacdiff.py "$M/receipt-vacuity-final.log" "$d/receipt-vacuity-$tag.log" "$M/count-modules-final.out" "$d/count-modules-$tag.out" --plant
  run assumptions 16 4 ./scripts/assumptions.sh
  run assumptions-selftest 16 4 ./scripts/assumptions.sh --self-test
  for g in assumptions assumptions-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain arch python3 tools/check_architecture.py
  run lint 8 4 lake lint --no-build -- --no-build --trace
  plain notes-l5 python3 tools/fs131_l5_notes.py --only-flagged
  plain notes-qa4-selftest python3 tools/fs131_qa4_notes.py --self-test
  data/fs124/l2/run-readback-import.sh "gate-$tag" > "$d/readback-import-$tag.txt" 2>&1; echo "readback-import exit=$?"
  data/fs124/l2/run-readback-port.sh "gate-$tag" > "$d/readback-port-$tag.txt" 2>&1; echo "readback-port exit=$?"
  "$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs124/l2/StatementDump.lean > "$d/statements-$tag.raw" 2> "$d/statements-$tag.err"; echo "statements-dump exit=$?"
  python3 tools/fs124_l2_statements.py compact "$d/statements-$tag.raw" > "$d/statements-$tag.compact"; echo "statements-compact exit=$?"; rm -f "$d/statements-$tag.raw"
  plain statements python3 tools/fs124_l2_statements.py diff data/fs124/l2/statements/before-joined.compact "$d/statements-$tag.compact"
  plain statements-plant python3 tools/fs124_l2_statements.py diff data/fs124/l2/statements/before-joined.compact "$d/statements-$tag.compact" --plant
  "$S" --mem 16 --cpus 2 --wait 7200 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs124/l2/checks.lean > "$d/checks-$tag.out" 2> "$d/checks-$tag.err"; echo "checks exit=$?"
  { diff <(git show origin/main:scripts/vacuity-baseline.txt | grep -E '^UNKNOWN ') <(grep -E '^UNKNOWN ' scripts/vacuity-baseline.txt) && echo "baseline entries: unchanged from main's ($(grep -cE '^UNKNOWN ' scripts/vacuity-baseline.txt))"; echo "lines of scripts/Vacuity.lean that differ from main's: $(diff <(git show origin/main:scripts/Vacuity.lean) scripts/Vacuity.lean | wc -l)"; echo "lines of scripts/Assumptions.lean that differ from main's: $(diff <(git show origin/main:scripts/Assumptions.lean) scripts/Assumptions.lean | wc -l)"; echo "lines of scripts/axioms-controls.txt that differ from main's: $(diff <(git show origin/main:scripts/axioms-controls.txt) scripts/axioms-controls.txt | wc -l)"; } > "$d/baseline-$tag.txt" 2>&1; echo "baseline-check exit=$?"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-final.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-final.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-final.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done"
} > "$out" 2>&1
