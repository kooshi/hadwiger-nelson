#!/usr/bin/env bash
# Regenerate data/fs58/witness-23 (FS-58 phase B5). The extraction is checkpointed in steps.jsonl (gitignored, ~3 MB): with it present
# a rerun reads every round back and only re-emits the witness (about a minute: the 440,077-point ball is rebuilt to map coordinates);
# from empty it takes about 15-25 minutes on the desktop (one 3-minute refusal of the whole ball, ~76 shrinking rounds, the deletion).
# Resume after a kill: rerun this script (or the extract line alone).
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D=data/fs58/witness-23
python3 tools/fs58_search.py extract 23 q1+q5+12.1+60.2 1.5 $D > $D/extract.out
python3 -c "import json; [print(r['step'], r.get('points_in'), r.get('points_out'), r.get('seconds'), len(r['kept'])) for r in map(json.loads, open('$D/steps.jsonl'))]" > $D/rounds.out  # step, points in, points out, seconds, kept
python3 tools/fs58_check_witness.py --radicand 23 $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand 23 --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py 23 $D/witness.json > $D/recheck.out
echo "run-all: done"
