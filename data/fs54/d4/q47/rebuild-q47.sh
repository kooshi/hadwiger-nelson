#!/usr/bin/env bash
# the q = 47 build again, with the cache-sized canonical-form chunks (1,000 sets per call), into a second directory; its
# manifest digests must equal the first build's (the instance is deterministic), after which the copy is removed.
cd /home/kooshi/source/lean-dir
R=data/fs54/d4/q47
echo $$ > $R/rebuild-q47.pgid
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 NUMBA_NUM_THREADS=14
( while kill -0 $$ 2>/dev/null; do echo "$(date +%s) mem_available $(awk '/MemAvailable/ {printf "%.2f", $2/1048576}' /proc/meminfo)"; sleep 2; done ) > $R/rebuild-q47.mem &
.venv/bin/python -u tools/fs54_d4_quad.py lean-build --q 47 --family l3 --workers 14 \
  --instance data/fs54/d4/ckpt/instance-q47-l3-rebuild --out $R/rebuild-q47.json > $R/rebuild-q47.log 2>&1
echo "EXIT $?" >> $R/rebuild-q47.log
python3 - >> $R/rebuild-q47.log <<'PY'
import json
a = json.load(open("data/fs54/d4/ckpt/instance-q47-l3/manifest.json")); b = json.load(open("data/fs54/d4/ckpt/instance-q47-l3-rebuild/manifest.json"))
same = all(a[k] == b[k] for k in ("sha256_V", "sha256_C_bs", "fingerprint", "cone", "oc", "labels", "offsets", "nb"))
print(f"DETERMINISM: sha256_V {a['sha256_V'][:16]} vs {b['sha256_V'][:16]}; sha256_C_bs {a['sha256_C_bs'][:16]} vs {b['sha256_C_bs'][:16]} -> {'IDENTICAL' if same else 'DIFFERENT'}")
PY
