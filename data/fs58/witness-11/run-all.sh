#!/usr/bin/env bash
# Regenerate data/fs58/witness-11 (FS-58 phase B3). Resumable: every finished solver step is read back from steps.jsonl and
# skipped, so a rerun with the record present takes seconds; from empty it takes about two minutes on the desktop.
# To rebuild from scratch: move steps.jsonl aside first. `chain --redo` rebuilds the witness (byte-identical: CaDiCaL is
# deterministic and the gzip header carries mtime 0).
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs58/witness-11
python3 tools/fs58_witness.py identities        > $D/identities.out
python3 tools/fs58_witness.py scan              > $D/scan.out
python3 tools/fs58_witness.py forcer 1000       > $D/forcer.out
python3 tools/fs58_witness.py chain --redo      > $D/chain.out
python3 tools/fs58_check_witness.py $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --controls $D/witness.json > $D/controls.out
echo "run-all: done; certified.out and controls.out written"
