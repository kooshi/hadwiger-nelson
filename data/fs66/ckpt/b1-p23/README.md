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

## The run that is in progress, and how to take it over

It is in the shape a **certifying** run needs — **3,000-iteration chunks**, the granularity that converged
at `p = 19` — so the hours that produce the reading are already the first hours of the converging solve.
(An earlier launch used 1,000-iteration chunks for hourly visibility; it was killed at 14 minutes, before
any checkpoint existed, so nothing was lost. The chunk shape is not cosmetic: at `p = 19`, 300-iteration
chunks left `res_dual` flat at ~0.6 over five chunks while 3,000-iteration chunks converged to `res_dual`
1.1e−05 — and the rounded bound tracks the **dual** residual, not the objective, plan §R″.4.)

| | |
|---|---|
| log | `data/fs66/ckpt/b1-p23/solve.log` — one line per chunk |
| PID / process group | `solve.pid` / `solve.pgid` beside this file |
| checkpoint | `solve-gpu.npz`, rewritten after every chunk (atomically, via `.part`) |
| chunk | 3,000 iterations, about 3.3 h |
| never | under a `timeout` wall |

**To find the process without matching a command line** (a pattern matches the shell that runs it):

```
D=data/fs66/ckpt/b1-p23
for d in /proc/[0-9]*; do
  [ "$(readlink $d/fd/1 2>/dev/null)" = "$(readlink -f $D/solve.log)" ] && basename $d
done
```

Verify any kill **by effect**: the PID absent from `ps`, and `solve-gpu.npz`'s digest unchanged across ten
seconds — never by group membership, and never through a pattern that can match the killing shell.

**Resume command** — the same command line; `--solve-ckpt` is reloaded when the file exists, and at most one
chunk is ever redone:

```
CUDA_DEVICE_ORDER=PCI_BUS_ID CUDA_VISIBLE_DEVICES=1 \
build/venv-sdp-gpu/bin/python tools/fs66_b1_cert_make.py 23 --fast --build-jobs 16 --threads 16 \
  --cache-dir data/fs66/ckpt/b1-p23 --linear-solver gpu_indirect --eps 1e-7 \
  --chunk-iters 3000 --max-iters 45000 --solve-ckpt data/fs66/ckpt/b1-p23/solve-gpu.npz \
  --no-round --record data/fs66/b1/records.jsonl
```

**The stopping criterion used at 19**, which is the one to use here: the chunk loop ends only on a clean
`status solved` — SCS labels *every* chunk that reaches its iteration cap `solved (inaccurate - reached
max_iters)`, and the cap **is** the chunk size, so that string is not a verdict. At 19 the clean `solved`
came at 13,950 iterations after 3 h 23 m.

**When it has converged**, round it with the widened grid §R′.2 prescribes — and call no solver, because
re-entering SCS destroys the dual you came for (measured at 19: five warm-started iterations took `res_pri`
from 1.33e−03 to 1.95, and the bound from ~78 to 192.6):

```
~/venvs/fs66/bin/python tools/fs66_b1_cert_make.py 23 --fast --cache-dir data/fs66/ckpt/b1-p23 \
  --round-only --solve-ckpt data/fs66/ckpt/b1-p23/solve-gpu.npz \
  --scan --scan-shifts 1e-8,1e-9,1e-10 --scan-digits 12,14 --jobs 6 \
  --out data/fs66/b1/cert-p23.json --record data/fs66/b1/records.jsonl
```

At `p = 23` one exact rounding attempt will cost well over the 243 s it cost at 19 (it scales like
`#reps² × n`, which is 2.9× larger), so price the scan before committing the cores. Five colours at 23 need
`U < 529/5 = 105.8`; the checker's verdict is asked with `--m 5`.
