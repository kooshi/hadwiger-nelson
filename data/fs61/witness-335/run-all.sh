#!/usr/bin/env bash
# Regenerate data/fs61/witness-335 (FS-61 phase C).  The generator is deterministic.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs61/witness-335
python3 tools/fs58_search.py extract 335 q1+q5+60+300 1.4301 $D > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 335 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 335 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 335 $D/witness.json > $D/recheck.out
echo "run-all: done"
