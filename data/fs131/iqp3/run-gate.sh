#!/usr/bin/env bash
# The full gate on one commit for FS131-IQP3 (a copy of data/fs131/clone1/run-gate.sh, as FS131-ICO2's was).
# Each step runs under the memory slot with this laptop's settings; every log lands in data/fs131/iqp3/gate/
# with its exit status on its last line, and run-pass.out holds every step's exit.
cd "$(dirname "$0")/../../.." || exit 2
[ -f scripts/build.sh ] || { echo "not the repository root: $PWD"; exit 2; }
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
S=scripts/slot.py; d=data/fs131/iqp3/gate; mkdir -p "$d"
run() { local name="$1" mem="$2"; shift 2; local t0=$(date +%s)
  python3 "$S" --mem "$mem" --cpus 4 --wait 3600 --name "iqp3-$name" -- "$@" > "$d/$name.log" 2>&1; local st=$?
  echo "exit=$st wall=$(( $(date +%s) - t0 ))s" >> "$d/$name.log"; echo "$name exit=$st wall=$(( $(date +%s) - t0 ))s"; }
plain() { local name="$1"; shift; "$@" > "$d/$name.txt" 2>&1; local st=$?; echo "exit=$st" >> "$d/$name.txt"; echo "$name exit=$st"; }
{
  echo "HEAD=$(git rev-parse HEAD) $(date -u +%Y-%m-%dT%H:%M:%SZ) tracked-modified=$(git status --porcelain --untracked-files=no | wc -l)"
  run uptodate 6 lake build --no-build Proofs
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines.txt"; echo "line-initial axiom lines=$(wc -l < "$d/axiom-lines.txt")"
  run dupnames 8 ./scripts/dupnames.sh
  run dupnames-selftest 6 ./scripts/dupnames.sh --self-test
  run axioms 8 ./scripts/axioms.sh
  run axioms-selftest 8 ./scripts/axioms.sh --self-test
  run vacuity 8 ./scripts/vacuity.sh
  run vacuity-selftest 8 ./scripts/vacuity.sh --self-test
  run assumptions 8 ./scripts/assumptions.sh
  run assumptions-selftest 8 ./scripts/assumptions.sh --self-test
  plain arch python3 tools/check_architecture.py
  run lint 8 lake lint --no-build -- --no-build --trace
  for g in axioms vacuity assumptions; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f"; [ -f "$f" ] && cp "$f" "$d/receipt-$g.log"; done
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms.log" "" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity.log" "" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions.log" "" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done $(date -u +%Y-%m-%dT%H:%M:%SZ)"
} > "$d/run-pass.out" 2>&1
