# FS-66 — the caches for `p = 23`, and how to re-round when the solve converges

**What is certified at 23 lives elsewhere**: `data/fs66/b1/cert-p23.json`, with its statement, its trust
word and its scan curve in `data/fs66/b1/README.md` (§ *Phase 2D*). Nothing in *this* directory is a
certificate — these are a build cache, a solver iterate and a log, all provenance.

| file | what it is | what regenerates it |
|---|---|---|
| `build-p23-c2.npz` | the build: 134,447 canonical monomials, the half-range product table `F(a, a', t)` (35,511 × 265 int32), the `q` forms | **87 s** on 16 cores — any run of the producer with `--fast --cache-dir data/fs66/ckpt/b1-p23` |
| `solve-gpu.npz` | the live SCS iterate `(x, y, s)` with `pobj`, `dobj`, `res_pri`, `res_dual`, `status`, rewritten atomically after every chunk | about 1.1–1.8 GPU-hours per 1,000 iterations on graphics card A |
| `solve-gpu.it6000.npz` | the owner's read-only copy of the 6,000-iteration checkpoint — **the dual `cert-p23.json` was rounded from** (sha256 `1f78c15c7c21…`) | `cp` of the above at that chunk boundary |
| `solve.log` | one line per chunk | — |

**Sizes, measured.** 24 PSD blocks (one 267, twenty-two 266, one 2 × 2); 667,774 scalar rows; constraint
matrix 1,484,797 × 134,446 with **204,658,963 nonzeros**; peak host memory 16.0 GB at assembly, 6.3 GB
steady; **4.0 GB of GPU memory**; **3.926 s per iteration** at 50 iterations on `gpu_indirect`, 7.30 and
5.44 s/iteration over the first two 3,000-iteration chunks.

## The run in progress

It is in the shape a **certifying** run needs — **3,000-iteration chunks**, the granularity that converged
at `p = 19` — so the hours that produce the reading are the first hours of the converging solve. (The chunk
shape is not cosmetic: at `p = 19`, 300-iteration chunks left `res_dual` flat at ~0.6 over five chunks while
3,000-iteration chunks converged to `res_dual` 1.1e−05 — and the rounded bound tracks the **dual** residual,
not the objective, plan §R″.4.)

| | |
|---|---|
| log | `solve.log` — one line per chunk |
| PID / process group | `solve.pid` / `solve.pgid` beside this file |
| checkpoint | `solve-gpu.npz`, rewritten after every chunk (atomically, via `.part`) |
| chunk | 3,000 iterations, 4.5–6.1 h so far |
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

---

## When it converges: the two commands that replace `cert-p23.json`

The shipped certificate was rounded from the **6,000-iteration** checkpoint, whose `res_dual` was 1.94e−03;
the rounding loss it paid was 0.4170 against the float reading 97.567673 (at 19 the loss ran about 250 ×
`res_dual`, and here it ran 215 ×). A converged dual will pay a loss of order 0.005 instead, so a re-round
should land `U` near **97.573** against the shipped **97.984637**.

**It will not change what the file licenses.** `U` can never fall below the relaxation's own optimum — the
certificate is a feasible point of its dual — and that optimum is at least the float reading 97.5677, so
`⌊U⌋ = 97` is final, and six colours (which need `U < 529/6 = 88.1667`) are out of this relaxation's reach
at 23 by nine whole colours' worth of margin. The gain from converging is cosmetic: a tighter `U` in the
same sentence.

**Step 1 — re-round** (no solver is called; `--round-only` reads `y` out of the checkpoint. Re-entering SCS
destroys the dual you came for: measured at 19, five warm-started iterations took `res_pri` from 1.33e−03
to 1.95 and the bound from ~78 to 192.6). Copy the converged checkpoint to a read-only name first, so the
file a certificate is rounded from cannot move under it:

```
cp -p data/fs66/ckpt/b1-p23/solve-gpu.npz data/fs66/ckpt/b1-p23/solve-gpu.converged.npz
chmod 444 data/fs66/ckpt/b1-p23/solve-gpu.converged.npz

~/venvs/fs66/bin/python tools/fs66_b1_cert_make.py 23 --fast --cache-dir data/fs66/ckpt/b1-p23 \
  --round-only --solve-ckpt data/fs66/ckpt/b1-p23/solve-gpu.converged.npz \
  --scan --scan-shifts 1e-7,1e-8,1e-9,1e-10,1e-11,1e-12 --scan-digits 12,14 --jobs 12 \
  --out data/fs66/b1/cert-p23.json --record data/fs66/b1/records.jsonl
```

**Cost, measured on this machine at this size:** one exact attempt is **1,856 s of one core** (31 min) and
**921 MB**; the twelve-attempt scan above is one wave on 12 cores. Each attempt is a pure function of
(checkpoint, shift, digits), so a kill redoes only itself.

**Step 2 — re-check.** Nothing is certified until the frozen checker says so:

```
python3 tools/fs66_b1_cert_check.py data/fs66/b1/cert-p23.json --m 5 --record data/fs66/b1/records.jsonl
python3 tools/fs66_b1_cert_check.py data/fs66/b1/cert-p23.json --m 6 --record data/fs66/b1/records.jsonl
```

**Cost, measured:** the checker on a 23-sized certificate takes about **50 minutes and 12 GB** on one core
(the figures beside the shipped file in `data/fs66/b1/README.md` are the quiet-machine ones). `--m 5` must
end `CERTIFIED`, exit 0; `--m 6` must end `BOUND ONLY`, exit 3.

Then update the numbers in `data/fs66/b1/README.md` § *Phase 2D* (the table, the licensed statement, the
scan curve) and append the new rows to `records.jsonl`; the old certificate is simply replaced.
