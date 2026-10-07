#!/usr/bin/env bash
# FS131-LT5 (FS131-L10B's data/fs131/l10b/run-pass.sh and run-gate.sh, joined, with the assumptions step added): one whole pass of
# the gate on one commit, under the slot, one step at a time, each to its own log under data/fs131/lt5/gate/ with its exit status
# on the log's last line and in data/fs131/lt5/gate/run-pass-<tag>.out. The commit under test and every tracked file modified are
# written first. Order (LEAN.md § The gate): the build; the doubled-name check and its self-test BEFORE the axiom audit; the audit
# and its self-test; the vacuity scan and its self-test; the assumptions step — against the repository's own CLAUDE.md, where it
# fails by the absent record alone until the drafted paragraph is filed, and against the draft copy, where it must pass — and its
# self-test; the architecture check; the guarded lint; the notes checks; the records check against main's gated list (FS131-L10B's);
# the sorry scans; the two digests against main's gated receipts.
# Usage (from anywhere): data/fs131/lt5/run-gate.sh <tag>
cd "$(dirname "$0")/../../.."
tag="$1"; d=data/fs131/lt5/gate; S=/home/kooshi/source/lean-dir/scripts/slot.py
[ -n "$tag" ] || { echo "usage: run-gate.sh <tag>"; exit 2; }
out="$d/run-pass-$tag.out"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3
  "$S" --mem "$mem" --cpus "$cpus" --wait 3600 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
plain() { local name="$1"; shift; "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?; echo "exit=$st" >> "$d/$name-$tag.txt"; echo "$name exit=$st"; }
{
  run build 40 8 env MEMMAX=40G BATCH=4 ./scripts/build.sh
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  "$S" --mem 16 --cpus 4 --wait 3600 -- lake env lean data/fs131/l5/count-modules.lean > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  run dupnames 16 8 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  run axioms 30 4 ./scripts/axioms.sh
  run axioms-selftest 30 4 ./scripts/axioms.sh --self-test
  run vacuity 30 4 ./scripts/vacuity.sh
  run vacuity-selftest 30 4 ./scripts/vacuity.sh --self-test
  run assumptions-repo-claude 16 4 ./scripts/assumptions.sh
  run assumptions-draft-claude 16 4 env ASSUMPTIONS_CLAUDE="$PWD/data/fs131/lt5/drafts/CLAUDE-with-sentence.md" ./scripts/assumptions.sh
  run assumptions-selftest 16 4 ./scripts/assumptions.sh --self-test
  plain arch python3 tools/check_architecture.py
  run lint 8 4 lake lint --no-build -- --no-build --trace
  plain notes-qa4 python3 tools/fs131_qa4_notes.py list
  plain notes-qa4-selftest python3 tools/fs131_qa4_notes.py --self-test
  plain notes-l5 python3 tools/fs131_l5_notes.py --only-flagged
  for g in build dupnames dupnames-self-test axioms axioms-self-test vacuity vacuity-self-test assumptions assumptions-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain records python3 tools/fs131_l5_records.py data/fs131/l10b/count-modules-final.out "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log"
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" data/fs131/l10b/receipt-axioms-final.log CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" data/fs131/l10b/receipt-vacuity-final.log scripts/vacuity-baseline.txt CLAUDE.md
  cmp -s <(grep '^DECL ' data/fs131/l10b/count-modules-final.out | sort) <(grep '^DECL ' "$d/count-modules-$tag.out" | sort); echo "the kernel's list of declarations against main's gated list (cmp): exit=$?"
  echo "pass-exit=done"
} > "$out" 2>&1
