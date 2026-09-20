#!/usr/bin/env bash
# Regenerate data/fs61/witness-95 (FS-61 phase C).  The generator is deterministic.#
# NOTE, and it is the honest caveat on "byte-identical": this witness's deletion was STOPPED at position
# 407 of 1737, so `--stop-deletion` below reproduces it only with the SAME steps.jsonl present
# (it is gitignored -- provenance, not evidence).  From an empty directory the core rounds rerun deterministically
# and `--stop-deletion` then stops at position 0, giving the larger core-round witness; drop the flag to run the
# full deletion, which is deterministic too and yields a SMALLER 1-minimal witness (slow: at d = 359 the deletion
# ran at 45 s a step).  Either way what the reviewer checks is `witness.json` + `witness.lrat.gz` as committed.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs61/witness-95
python3 tools/fs58_search.py extract 95 q1+12+60.2 1.5 $D --stop-deletion > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 95 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 95 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 95 $D/witness.json > $D/recheck.out
echo "run-all: done"
