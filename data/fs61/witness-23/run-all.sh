#!/usr/bin/env bash
# Regenerate data/fs61/witness-23 (FS-61 phase C).  The generator is deterministic.#
# NOTE -- what "byte-identical" means here.  The pass condition is byte-identical witness.json from the
# COMMITTED WITNESS DIRECTORY, and this witness's deletion was STOPPED at position 467 of
# 1280, so the gitignored steps.jsonl checkpoint is part of what makes that true: `--stop-deletion`
# below reproduces this file only with that SAME checkpoint present.  What a rerun WITHOUT it produces, both
# deterministic: with `--stop-deletion`, the core rounds rerun and the deletion stops at position 0, giving the
# LARGER core-round witness; without the flag, the full deletion runs and gives a SMALLER 1-minimal one (slow --
# at d = 359 it ran at 45 s a step).  A stopped deletion is never *finished* later: the frozen extract resumes at
# a stale scan position and skips, so only a from-scratch run is 1-minimal.  And none of this is the evidence:
# what a reviewer checks is `witness.json` + `witness.lrat.gz` AS COMMITTED, through the frozen checker.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs61/witness-23
python3 tools/fs58_search.py extract 23 q1+q5+12.1+60.2 1.3 $D --stop-deletion > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 23 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 23 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 23 $D/witness.json > $D/recheck.out
echo "run-all: done"
