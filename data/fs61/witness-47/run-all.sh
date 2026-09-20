#!/usr/bin/env bash
# Regenerate data/fs61/witness-47 (FS-61 phase C).  The generator is deterministic.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs61/witness-47
python3 tools/fs58_search.py direct-witness 47 q1+12+60 1.5 $D > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 47 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 47 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 47 $D/witness.json > $D/recheck.out
echo "run-all: done"
