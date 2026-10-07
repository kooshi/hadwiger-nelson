#!/usr/bin/env bash
# FS132-L1 (after FS131-L8A's data/fs131/l8a/run-gate.sh): one whole pass of the gate on one commit, under the slot, one
# step at a time, each to its own log under data/fs132/l1/gate/ with its exit status on the log's last line and in
# data/fs132/l1/gate/run-pass-<tag>.out. The commit under test and every tracked file modified are written first.
#
# Order (LEAN.md § The gate; the brief's step 6): the build; the kernel's list of declarations; the sorry scans; the
# doubled-name check and its self-test BEFORE the axiom audit; the audit and its self-test; the landing's records in the
# audit's saved log (this job's tool, three imports) with its ten plants; the import's block as filed, with its
# wrong-filing control and its planted-sorry control, on the module as it stands; the vacuity scan and its self-test,
# and the scan against main's gated scan row for row, with its plants; the assumptions step and its self-test; the
# architecture check; the guarded lint; the notes check and its self-test as the last landing ran them; the stored-term
# comparison with the release on the module as built on this commit, with its planted faults; every statement of the
# module by #check; the three digests against the previous landing's receipts (FS131-L8A's, gated commit 126bff4d — main's
# Proofs/, Proofs.lean and scripts/ are unchanged since: `git diff --stat 126bff4d aca251ee -- Proofs/ Proofs.lean scripts/`
# is empty).
# Usage (from anywhere): data/fs132/l1/run-gate.sh <tag>
cd "$(dirname "$0")/../../.." || exit 2
tag="$1"; d=data/fs132/l1/gate; S=/home/kooshi/source/lean-dir/scripts/slot.py
[ -n "$tag" ] || { echo "usage: run-gate.sh <tag>"; exit 2; }
mkdir -p "$d"
M=data/fs131/l8a/gate          # main's gated receipts: FS131-L8A's final pass, on 126bff4d
out="$d/run-pass-$tag.out"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
plain() { local name="$1"; shift; "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?; echo "exit=$st" >> "$d/$name-$tag.txt"; echo "$name exit=$st"; }
{
  run build 40 8 env MEMMAX=40G BATCH=4 ./scripts/build.sh
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  f="$(readlink -f build/gate/build/latest 2>/dev/null)"; [ -f "$f" ] && { cp "$f" "$d/receipt-build-$tag.log"; grep -c 'warning' "$f" | sed 's/^/lake full log lines holding "warning": /'; }
  "$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs131/l5/count-modules.lean > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines-$tag.txt"; echo "line-initial axiom declarations in Proofs/=$(wc -l < "$d/axiom-lines-$tag.txt")"
  run dupnames 16 8 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  run axioms 30 4 ./scripts/axioms.sh
  run axioms-selftest 30 4 ./scripts/axioms.sh --self-test
  for g in dupnames dupnames-self-test axioms axioms-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain records python3 tools/fs132_l1_records.py "$M/count-modules-final.out" "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log"
  plain records-plant python3 tools/fs132_l1_records.py "$M/count-modules-final.out" "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log" --plant
  plain block python3 tools/fs132_l1_block.py "$d" "$tag"
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
  data/fs132/l1/run-readback.sh "gate-$tag" > "$d/readback-$tag.txt" 2>&1; echo "readback exit=$?"
  "$S" --mem 16 --cpus 2 --wait 7200 -- lake env lean data/fs132/l1/checks.lean > "$d/checks-$tag.out" 2> "$d/checks-$tag.err"; echo "checks exit=$?"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-final.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-final.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-final.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done"
} > "$out" 2>&1
