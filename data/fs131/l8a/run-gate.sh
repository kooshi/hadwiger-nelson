#!/usr/bin/env bash
# FS131-L8A (after FS131-LT5's data/fs131/lt5/run-gate.sh): one whole pass of the gate on one commit, under the slot, one step at
# a time, each to its own log under data/fs131/l8a/gate/ with its exit status on the log's last line and in
# data/fs131/l8a/gate/run-pass-<tag>.out. The commit under test and every tracked file modified are written first.
# Order (LEAN.md § The gate): the build; the kernel's list of declarations; the doubled-name check and its self-test BEFORE the
# axiom audit; the audit and its self-test; the vacuity scan and its self-test; the assumptions step and its self-test; the
# architecture check; the guarded lint; the notes check; the records check against main's gated list, with its eight plants; this
# job's receipt over the line's seven blocks and twelve modules, with its fault; the kernel's statements of every theorem of the
# twelve modules against their files; the sorry scans; the three digests against main's gated receipts (FS131-LT5's, landed2).
# Usage (from anywhere): data/fs131/l8a/run-gate.sh <tag>
cd "$(dirname "$0")/../../.."
tag="$1"; d=data/fs131/l8a/gate; S=/home/kooshi/source/lean-dir/scripts/slot.py
[ -n "$tag" ] || { echo "usage: run-gate.sh <tag>"; exit 2; }
mkdir -p "$d"
M=data/fs131/lt5/gate          # main's gated receipts: FS131-LT5's third pass, on 5a62be0a (main's Proofs/, scripts/, tools/ unchanged since)
out="$d/run-pass-$tag.out"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
plain() { local name="$1"; shift; "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?; echo "exit=$st" >> "$d/$name-$tag.txt"; echo "$name exit=$st"; }
HEADS="$(grep -v '^#' data/fs131/l8a/heads.txt | grep . | paste -sd, -)"
{
  run build 40 8 env MEMMAX=40G BATCH=4 ./scripts/build.sh
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  "$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs131/l5/count-modules.lean > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  run dupnames 16 8 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  run axioms 30 4 ./scripts/axioms.sh
  run axioms-selftest 30 4 ./scripts/axioms.sh --self-test
  run vacuity 30 4 ./scripts/vacuity.sh
  run vacuity-selftest 30 4 ./scripts/vacuity.sh --self-test
  run assumptions 16 4 ./scripts/assumptions.sh
  run assumptions-selftest 16 4 ./scripts/assumptions.sh --self-test
  plain arch python3 tools/check_architecture.py
  run lint 8 4 lake lint --no-build -- --no-build --trace
  plain notes-l5 python3 tools/fs131_l5_notes.py --only-flagged
  plain notes-qa4-selftest python3 tools/fs131_qa4_notes.py --self-test
  for g in build dupnames dupnames-self-test axioms axioms-self-test vacuity vacuity-self-test assumptions assumptions-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain records python3 tools/fs131_l10b_records.py "$M/count-modules-landed2.out" "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log" --heads "$HEADS"
  plain records-plant python3 tools/fs131_l10b_records.py "$M/count-modules-landed2.out" "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log" --heads "$HEADS" --plant
  "$S" --mem 16 --cpus 4 --wait 7200 -- python3 tools/fs131_l8a_axioms.py --out "$d/l8a-axioms-$tag.raw" > "$d/l8a-axioms-$tag.txt" 2> "$d/l8a-axioms-$tag.err"; echo "l8a-axioms exit=$?"
  "$S" --mem 16 --cpus 4 --wait 7200 -- python3 tools/fs131_l8a_axioms.py --fault > "$d/l8a-axioms-fault-$tag.txt" 2> "$d/l8a-axioms-fault-$tag.err"; echo "l8a-axioms-fault exit=$? (1 expected)"
  "$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs131/l8a/kernel-sigs.lean > "$d/kernel-sigs-$tag.out" 2> "$d/kernel-sigs-$tag.err"; echo "kernel-sigs exit=$?"
  plain kernel-sigs-read python3 tools/fs131_l10b_kernelsig.py read "$d/kernel-sigs-$tag.out" --reviewed data/fs131/l8a/kernelsig-reviewed.txt --heads data/fs131/l8a/heads.txt --table "$d/kernel-sigs-table-$tag.txt"
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-landed2.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-landed2.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-landed2.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "pass-exit=done"
} > "$out" 2>&1
