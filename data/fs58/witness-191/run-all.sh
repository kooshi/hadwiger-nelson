#!/usr/bin/env bash
# Regenerate data/fs58/witness-191 (FS-58 phase B5 side result; method as data/fs58/witness-47/README.md). Deterministic rebuild.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs58/witness-191
python3 tools/fs58_search.py direct-witness 191 q1+q5+20+60.1 1.5 $D > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 191 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 191 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 191 $D/witness.json > $D/recheck.out
echo "run-all: done"
