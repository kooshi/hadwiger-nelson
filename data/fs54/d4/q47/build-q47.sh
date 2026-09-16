#!/usr/bin/env bash
# FS-54 D4 at q = 47: build the level-3 instance on the lean path, with the orbit-completeness census, and cache it.
# Launched under setsid; writes its process-group id first; samples the group's summed RSS every 2 s.
cd /home/kooshi/source/lean-dir
R=data/fs54/d4/q47
echo $$ > $R/build-q47.pgid
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 NUMBA_NUM_THREADS=14
( while kill -0 $$ 2>/dev/null; do echo "$(date +%s) $(ps -g $$ -o rss= | awk '{s+=$1} END {printf "%.2f", s/1048576}')"; sleep 2; done ) > $R/build-q47.rss &
.venv/bin/python -u tools/fs54_d4_quad.py lean-build --q 47 --family l3 --workers 14 --census \
  --instance data/fs54/d4/ckpt/instance-q47-l3 --out $R/build-q47.json > $R/build-q47.log 2>&1
echo "EXIT $?" >> $R/build-q47.log
