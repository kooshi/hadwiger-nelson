# FS-66 phase 2C — the caches for `p = 19` (plan `plans/FS66-phase2-certificate.md` §X)

Nothing here is a certificate. The certificate is `../../b1/cert-p19.json`, and its word is the frozen
checker's. These are the two expensive, deterministic things the phase would otherwise have to redo after a
crash, kept **outside** `build/` because `build/` is scratch that agents clean.

| file | what it is | what regenerates it |
|---|---|---|
| `build-p19-c2.npz` | the build: the orbit list (52,370 canonical monomials, encoded), the half-range product table `F(a, a', t)` (16,653 × 181 int32) and the `q` forms | **26 s** — any run of the producer with `--fast --cache-dir data/fs66/ckpt/b1-p19` rebuilds it if it is missing |
| `solve-gpu.npz` | the SCS iterate `(x, y, s)` after 9,000 iterations, with `pobj`, `dobj`, `res_pri`, `res_dual`, `status`; **the dual `y` in it is what `cert-p19.json` was rounded from** | **about 2.5 GPU-hours** on graphics card A |
| `solve-gpu-300chunks-1500it.npz` | the superseded iterate of the first attempt, kept as the evidence behind the chunk-size finding (300-iteration chunks left `res_dual` flat at ~0.6 over five chunks) | — |

**If a run dies at any instant, the relaunch redoes:** the build (nothing, if this cache is here — it reloads in
0.4 s), the assembly (12 s), and the iterations since the last checkpoint (at most `--chunk-iters`).

**Resume command** — the same command line; `--solve-ckpt` is reloaded when the file exists:

```
CUDA_DEVICE_ORDER=PCI_BUS_ID CUDA_VISIBLE_DEVICES=1 \
build/venv-sdp-gpu/bin/python tools/fs66_b1_cert_make.py 19 --fast --build-jobs 16 --threads 16 \
  --cache-dir data/fs66/ckpt/b1-p19 --linear-solver gpu_indirect --eps 1e-7 \
  --chunk-iters 3000 --max-iters 45000 --solve-ckpt data/fs66/ckpt/b1-p19/solve-gpu.npz \
  --no-round --record data/fs66/b1/records.jsonl
```

**And to round a checkpoint WITHOUT calling a solver** (re-entering SCS destroys the dual you came for —
five warm-started iterations took `res_pri` from 1.33e−03 to 1.95):

```
~/venvs/fs66/bin/python tools/fs66_b1_cert_make.py 19 --fast --cache-dir data/fs66/ckpt/b1-p19 \
  --round-only --solve-ckpt data/fs66/ckpt/b1-p19/solve-gpu.npz --scan --jobs 6 \
  --out data/fs66/b1/cert-p19.json --record data/fs66/b1/records.jsonl
```
