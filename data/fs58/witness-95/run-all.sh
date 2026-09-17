#!/usr/bin/env bash
# Regenerate data/fs58/witness-95 (FS-58 phase B5 side result). The extraction checkpoint steps.jsonl is gitignored; from empty the
# assumption-core rounds take about two minutes, and the deletion is then STOPPED where B5 stopped it only if steps.jsonl carries the
# same deletion record -- without it, drop --stop-deletion to run the full (slow, ~1 h) deletion, which yields a smaller witness.
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs58/witness-95
python3 tools/fs58_search.py extract 95 q1+12+60.2 1.5 $D --stop-deletion > $D/extract.out
python3 tools/fs58_check_witness.py --radicand 95 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 95 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 95 $D/witness.json > $D/recheck.out
echo "run-all: done"
