#!/usr/bin/env bash
# the lean ADMM iteration against the reference ADMM (solve --method admm) at q = 11: 400 iterations from zero each, and
# the lean run split 200 + 200 across a checkpoint resume.  The three final report lines must agree.
cd /home/kooshi/source/lean-dir
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 NUMBA_NUM_THREADS=4
W=$(mktemp -d /tmp/claude-1000/-home-kooshi-source-lean-dir/b1507518-dd2a-4756-a291-855e63c44221/scratchpad/admmeq.XXXX)
.venv/bin/python -u tools/fs54_d4_quad.py lean-build --q 11 --workers 4 --instance $W/inst11 > /dev/null 2>&1
echo "reference: $(.venv/bin/python -u tools/fs54_d4_quad.py solve --q 11 --family l3 --method admm --ckpt $W/ref.npz --new --stop-after-chunks 400 --report-seconds 1e9 --proj-threads 4 2>&1 | grep 'admm\] it' | grep -oE 'upper reading.*mu [0-9.e+-]+')"
echo "lean:      $(.venv/bin/python -u tools/fs54_d4_quad.py lean-solve --instance $W/inst11 --ckpt $W/lean.npz --new --stop-after-iters 400 --report-seconds 1e9 --proj-threads 4 2>&1 | grep 'lean-admm\] it' | grep -oE 'upper reading.*mu [0-9.e+-]+')"
.venv/bin/python -u tools/fs54_d4_quad.py lean-solve --instance $W/inst11 --ckpt $W/split.npz --new --stop-after-iters 200 --report-seconds 1e9 --proj-threads 4 > /dev/null 2>&1
echo "split:     $(.venv/bin/python -u tools/fs54_d4_quad.py lean-solve --instance $W/inst11 --ckpt $W/split.npz --stop-after-iters 200 --report-seconds 1e9 --proj-threads 4 2>&1 | grep 'lean-admm\] it' | grep -oE 'upper reading.*mu [0-9.e+-]+')"
rm -rf "$W"
