#!/usr/bin/env bash
# FS-54 D4 at 47, calibration: the level-3 ADMM from zero at q = 11, 19, 23 with frequent reports, so that the iterations
# to a given relative drop below the triple level can be read against problem size (27's trajectory is on record).
# Same tool path (solve --method admm) and parameters as the 27 record.  Sequential; each run capped by its own
# --stop-after-chunks (iterations for admm) and checkpointed at every report.
cd /home/kooshi/source/lean-dir
R=data/fs54/d4/q47
echo $$ > $R/calibrate.pgid
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1
for spec in "11 4000" "19 4000" "23 3500"; do
  set -- $spec
  .venv/bin/python -u tools/fs54_d4_quad.py solve --q $1 --family l3 --method admm --proj-threads 14 \
    --ckpt data/fs54/d4/ckpt/calib-q$1.npz --new --stop-after-chunks $2 --report-seconds 5 \
    --out $R/calib-q$1.json > $R/calib-q$1.log 2>&1
  echo "EXIT q=$1 $? $(date -Is)" >> $R/calibrate.done
done
