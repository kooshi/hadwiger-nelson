#!/usr/bin/env bash
# FS-54 D4 at q = 47: the level-3 arrowhead ADMM on the cached lean instance.  Launch under setsid; the script writes its
# process-group id first and appends to one log.  Usage:
#   solve-q47.sh <cpu|gpu> <stop-after-iters (0 = none)> <report-first> <report-seconds> [--new]
# Resume = the same command without --new (a missing checkpoint is refused without --new; an existing one with it).
cd /home/kooshi/source/lean-dir
R=data/fs54/d4/q47
echo $$ > $R/solve-q47.pgid
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 NUMBA_NUM_THREADS=14
export CUDA_VISIBLE_DEVICES=GPU-UUID-REMOVED      # graphics card A, by UUID
# memory: the group's summed RSS (GiB; overcounts pages shared across forks) and the SYSTEM MemAvailable (GiB), every 5 s
( while kill -0 $$ 2>/dev/null; do echo "$(date +%s) rss_sum $(ps -g $$ -o rss= | awk '{s+=$1} END {printf "%.2f", s/1048576}') mem_available $(awk '/MemAvailable/ {printf "%.2f", $2/1048576}' /proc/meminfo)"; sleep 5; done ) >> $R/solve-q47.mem &
echo "=== $(date -Is) launch: projector=$1 stop-after-iters=$2 report-first=$3 report-seconds=$4 $5" >> $R/solve-q47.log
.venv/bin/python -u tools/fs54_d4_quad.py lean-solve --instance data/fs54/d4/ckpt/instance-q47-l3 \
  --ckpt data/fs54/d4/ckpt/admm-q47-l3.npz --projector "$1" --proj-threads 14 --eps 1e-6 --max-iters 400000 \
  --stop-after-iters "$2" --report-first "$3" --report-seconds "$4" $5 --out $R/solve-q47-last.json >> $R/solve-q47.log 2>&1
echo "EXIT $? $(date -Is)" >> $R/solve-q47.log
