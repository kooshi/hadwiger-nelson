#!/usr/bin/env bash
# Regenerate data/fs58/witness-23/minimal. Needs ../steps.jsonl (the extraction checkpoint; run ../run-all.sh first if it is absent).
# With minimize.jsonl present (committed), seconds; without it, eight Glucose4 deletions of about 75 s each.
set -euo pipefail
cd "$(dirname "$0")/../../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs58/witness-23/minimal
python3 tools/fs58_search.py minimize 23 q1+q5+12.1+60.2 1.5 data/fs58/witness-23 $D 0,1,2,3,4,5,6,7 > $D/minimize.out
python3 tools/fs58_check_witness.py --radicand 23 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 23 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 23 $D/witness.json > $D/recheck.out
echo "run-all: done"
