#!/usr/bin/env bash
# FS-54 D4 at q = 47: the soundness control on the cached instance -- y computed exactly from FS-53's verified 265-set,
# objective and every block's least eigenvalue from the assembled data, and two plants that must fire.
cd /home/kooshi/source/lean-dir
R=data/fs54/d4/q47
echo $$ > $R/checkset-q47.pgid
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 NUMBA_NUM_THREADS=14
( while kill -0 $$ 2>/dev/null; do echo "$(date +%s) mem_available $(awk '/MemAvailable/ {printf "%.2f", $2/1048576}' /proc/meminfo)"; sleep 5; done ) > $R/checkset-q47.mem &
.venv/bin/python -u tools/fs54_d4_quad.py lean-checkset --instance data/fs54/d4/ckpt/instance-q47-l3 \
  --set data/fs53/alpha-q47-ge265.json --path best_set --workers 14 --out $R/checkset-q47-set265.json > $R/checkset-q47.log 2>&1
echo "EXIT $?" >> $R/checkset-q47.log
