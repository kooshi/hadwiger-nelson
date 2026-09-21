# FS-66 phase 2C — the caches for `p = 23` (a FLOAT READING only; no certificate exists at 23)

**Nothing at `p = 23` is certified, and nothing here should be quoted as a bound.** This phase was asked for
one thing at 23: the float reading of the minimal second-level relaxation, which decides whether a
five-colour certificate (`U < 529/5 = 105.8`) is worth a milestone. Rounding and certifying at 23 are
deliberately *not* done here.

| file | what it is | what regenerates it |
|---|---|---|
| `build-p23-c2.npz` | the build: 134,447 canonical monomials, the half-range product table `F(a, a', t)` (35,511 × 265 int32), the `q` forms | **87 s** on 16 cores — any run of the producer with `--fast --cache-dir data/fs66/ckpt/b1-p23` |
| `solve-gpu.npz` | the SCS iterate `(x, y, s)` with `pobj`, `dobj`, `res_pri`, `res_dual`, `status` | about 1.1 GPU-hours per 1,000 iterations on graphics card A |

**Sizes, measured.** 24 PSD blocks (one 267, twenty-two 266, one 2 × 2); 667,774 scalar rows; constraint
matrix 1,484,797 × 134,446 with **204,658,963 nonzeros**; peak host memory 16.0 GB at assembly, 6.3 GB
steady; **4.0 GB of GPU memory**; **3.926 s per iteration** at 50 iterations on `gpu_indirect`.

**Convergence was NOT attempted and is projected at 19–28 hours** (at `p = 19` it took 13,950 iterations,
and the long-run per-iteration cost ran about 1.3× the 50-iteration figure).

> **WARNING for anyone who wants to ROUND at 23.** This checkpoint was produced in **1,000-iteration
> chunks**, chosen so the reading was visible hourly. That is fine for a reading and wrong for a dual:
> at `p = 19`, 300-iteration chunks left `res_dual` flat at ~0.6 over five chunks while 3,000-iteration
> chunks converged, and the rounded bound tracks the **dual** residual, not the objective (plan §R″.4).
> **Relaunch with `--chunk-iters 3000` before rounding anything at 23.**

Resume command — the same command line; `--solve-ckpt` is reloaded when the file exists:

```
CUDA_DEVICE_ORDER=PCI_BUS_ID CUDA_VISIBLE_DEVICES=1 \
build/venv-sdp-gpu/bin/python tools/fs66_b1_cert_make.py 23 --fast --build-jobs 16 --threads 16 \
  --cache-dir data/fs66/ckpt/b1-p23 --linear-solver gpu_indirect --eps 1e-7 \
  --chunk-iters 1000 --max-iters 45000 --solve-ckpt data/fs66/ckpt/b1-p23/solve-gpu.npz \
  --no-round --record data/fs66/b1/records.jsonl
```
