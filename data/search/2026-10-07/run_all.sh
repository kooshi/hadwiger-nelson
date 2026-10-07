#!/bin/bash
# SEARCH-2026-10-07: every variant, one line each in run_all.log; each exit status read directly and recorded.
# If this dies: rerun it (the whole batch is under two minutes); nothing else is redone.
set -u
cd "$(dirname "$0")"
: > run_all.log
fail=0
for ring in turning alternating; do
  for maxlab in 3 4 5 6; do
    for xfam in simple-straight simple-curved any-straight any-curved; do
      python3 solve.py "$ring" "$maxlab" "$xfam" >> run_all.log 2>&1
      rc=$?
      echo "EXIT $ring $maxlab $xfam rc=$rc" >> run_all.log
      [ "$rc" -ne 0 ] && fail=1
    done
  done
done
echo "BATCH DONE fail=$fail" >> run_all.log
exit $fail
