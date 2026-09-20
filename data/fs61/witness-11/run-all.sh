#!/usr/bin/env bash
# Regenerate data/fs61/witness-11 (FS-61 phase C).  The generator is deterministic.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs61/witness-11
python3 tools/fs58_search.py extract 11 q1+q5+6+10.1+10.2+15.1+15.2+30.1+30.2+30.3 1.0 $D > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 11 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 11 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 11 $D/witness.json > $D/recheck.out
echo "run-all: done"
