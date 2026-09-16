#!/usr/bin/env bash
# FS-54 D4 pricing: per-iteration time of L3 at q=27 on graphics card A (gpu_indirect), as-is (netlib LAPACK) and with the
# CPU wheel's OpenBLAS preloaded. Short, checkpointed (--stop-after-chunks); no wall.
cd /home/kooshi/source/lean-dir
export CUDA_VISIBLE_DEVICES=GPU-UUID-REMOVED OMP_NUM_THREADS=4 OPENBLAS_NUM_THREADS=4
LD_PRELOAD="/home/kooshi/source/lean-dir/.venv/lib/python3.14/site-packages/scs.libs/libgfortran-83c28eba.so.5.0.0 /home/kooshi/source/lean-dir/.venv/lib/python3.14/site-packages/scs.libs/libopenblas-r0-11edc3fa.3.15.so" build/venv-sdp-gpu/bin/python -u tools/fs54_d4_quad.py solve --q 27 --modulus 't^3-t-1' --family l3 --ckpt data/fs54/d4/ckpt/timing-q27-openblas.npz --new --eps 1e-6 --chunk 20 --stop-after-chunks 2 --linear-solver gpu_indirect --out data/fs54/d4/runs/timing-q27-openblas.json
build/venv-sdp-gpu/bin/python -u tools/fs54_d4_quad.py solve --q 27 --modulus 't^3-t-1' --family l3 --ckpt data/fs54/d4/ckpt/timing-q27-netlib.npz --new --eps 1e-6 --chunk 5 --stop-after-chunks 1 --linear-solver gpu_indirect --out data/fs54/d4/runs/timing-q27-netlib.json
echo TIMING-DONE
