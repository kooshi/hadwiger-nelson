#!/usr/bin/env bash
# Regenerate data/fs58/witness-47 (FS-58 phase B5 side result). About ten seconds on the desktop. The generator is deterministic
# (Glucose4 deletion order fixed; CaDiCaL deterministic; gzip header mtime 0), so a rerun reproduces the committed files.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs58/witness-47
python3 tools/fs58_search.py direct-witness 47 q1+12+60 1.5 $D > $D/generate.out
python3 tools/fs58_check_witness.py --radicand 47 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 47 --controls $D/witness.json > $D/controls.out
echo "run-all: done; certified.out and controls.out written"
