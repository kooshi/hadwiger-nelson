#!/usr/bin/env bash
# Regenerate data/fs61/witness-311 (FS-61 phase C).  The generator is deterministic.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs61/witness-311
python3 tools/fs58_search.py extract 311 q1+q5+40+60+120 1.2892 $D > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 311 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 311 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 311 $D/witness.json > $D/recheck.out
echo "run-all: done"
