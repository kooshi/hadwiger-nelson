#!/usr/bin/env bash
# FS131-LU1: the lines of a pass's saved logs that the record's table quotes, in the pass's order.  Read-only.
# Usage: gate-summary.sh <tag>
cd "$(dirname "$0")/../../.." || exit 2
tag="${1:?tag}"; d=data/fs131/lu1/gate
h() { echo; echo "=== $*"; }
h head; cat "$d/run-gate-$tag.head"
h "every step's exit"; cat "$d/run-pass-$tag.out"
h build; grep -n 'build: OK\|rebuilt\|FAIL\|error' "$d/build-$tag.log" | cut -c1-200; tail -1 "$d/build-$tag.rss" | cut -c1-300
h uptodate; grep -v '^slot' "$d/uptodate-$tag.log"
h "sorry / axiom lines"; wc -l "$d/sorry-narrow-$tag.txt" "$d/sorry-wide-$tag.txt" "$d/axiom-lines-$tag.txt"; cut -c1-150 "$d/axiom-lines-$tag.txt"
h dupnames; grep -n 'dupnames:' "$d/dupnames-$tag.log" "$d/dupnames-selftest-$tag.log" | cut -c1-220
h unfiled; cat "$d/unfiled-$tag.txt"
h decls; grep 'LU1MODULE\|LU1TOTAL' "$d/decls-$tag.out"; cat "$d/decls-$tag.err" | head -3
h axioms; grep -n 'audited:\|axioms:\|STALE\|self-test:' "$d/axioms-$tag.log" "$d/axioms-selftest-$tag.log" | cut -c1-260
h records; cat "$d/records-$tag.txt"; tail -2 "$d/records-plant-$tag.txt" | cut -c1-200
h "block / port"; tail -4 "$d/block-$tag.txt" | cut -c1-200; tail -2 "$d/port-check-$tag.txt" | cut -c1-200; tail -2 "$d/port-selftest-$tag.txt" | cut -c1-200
h vacuity; grep -n 'scanned:\|sites:\|vacuity:\|STALE\|recorded counts\|self-test:' "$d/vacuity-$tag.log" "$d/vacuity-selftest-$tag.log" | cut -c1-260
h vacdiff; cat "$d/vacdiff-$tag.txt" | cut -c1-200; tail -3 "$d/vacdiff-plant-$tag.txt" | cut -c1-200
h assumptions; grep -n 'scanned:\|assumed:\|assumptions:\|STALE\|recorded counts\|self-test:\|FAIL' "$d/assumptions-$tag.log" "$d/assumptions-selftest-$tag.log" | cut -c1-300; grep '^=== TOTALS' "$d/receipt-assumptions-$tag.log" | cut -c1-330
h arch; tail -2 "$d/arch-$tag.txt"
h lint; grep -c 'Passed!' "$d/lint-$tag.log"; grep -n 'Linting\|Failed\|exit=' "$d/lint-$tag.log" | cut -c1-200
h notes; tail -3 "$d/notes-l5-$tag.txt" | cut -c1-200; tail -2 "$d/notes-qa4-selftest-$tag.txt" | cut -c1-200
h statements; cat "$d/statements-$tag.txt" | tail -4 | cut -c1-240; tail -2 "$d/statements-plant-$tag.txt" | cut -c1-200; cat "$d/statements-$tag.err" | head -3
h "code only"; cat "$d/code-only-$tag.txt" | cut -c1-200; tail -2 "$d/code-only-plant-$tag.txt"; cat "$d/proofs-diff-$tag.txt"
h checks; grep -c 'depends on axioms' "$d/checks-$tag.out"; grep -n 'error\|warning\|sorry' "$d/checks-$tag.out" | head -3; cat "$d/checks-$tag.err" | head -3
h compiled; cat "$d/compiled-unchanged-$tag.txt" | cut -c1-200; tail -2 "$d/compiled-unchanged-plant-$tag.txt" | cut -c1-200
h "statements of the last landing's three modules"; tail -3 "$d/statements-lc1-$tag.txt" | cut -c1-240
h baseline; cat "$d/baseline-$tag.txt"
h digests; for g in axioms vacuity assumptions; do echo "--- $g"; cat "$d/digest-$g-$tag.txt" | cut -c1-260 | head -40; done
h measure; cat "$d/measure-$tag.txt" | cut -c1-170
