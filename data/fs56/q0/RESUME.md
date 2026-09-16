# FS-56 Q0 — the exact five-refusal certificate at 23 (written before launch, 2026-09-16)

Input: `data/fs54/d4/ckpt/calib-q23-certcopy.npz`, a copy of the level-3 ADMM calibration iterate at 3,500 iterations
(float certificate-shaped reading 105.431; five colours at 23 need an independent set of 106).
Expected cost: minutes (the q = 27 rounding of a 77,238-variable programme took under a minute; q = 23 has 99,481).
The rounding is deterministic from the snapshot, so a relaunch after a kill redoes at most that and nothing else.

Launch / relaunch (identical; the existing snapshot is reused, never the live file):

    setsid bash -c '.venv/bin/python -u tools/fs54_l3_cert_round.py round --q 23 --ckpt data/fs54/d4/ckpt/calib-q23.npz \
        --snapshot data/fs54/d4/ckpt/calib-q23-certcopy.npz --den 100000000 --jobs 6 --k 5 \
        --out "data/fs54/cert-q23-l3-N{N}.json" --log "data/fs54/d4/check-q23-l3-N{N}.log" \
        > data/fs56/q0/round-q23-l3.log 2>&1' & echo $! > data/fs56/q0/round.pid

Independent re-check by the PO: `python3 tools/fs54_l3_cert_check.py data/fs54/cert-q23-l3-N<N>.json`.
Stop: by the pid of the python process (`ps -eo pid=,ppid=,comm=`), verified by the pid absent and the log static.
