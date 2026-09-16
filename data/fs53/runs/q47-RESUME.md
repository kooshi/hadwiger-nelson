# q = 47, six-refusal attempt — resume command (written BEFORE launch, per CLAUDE.md)

Question: does the triple-level relaxation at q = 47 converge BELOW 369?
  n = 2209; six colours need a class of ceil(2209/6) = 369; so alpha <= 368 refuses six.
  Phase B's committed certificate: float 377.42463, status `optimal_inaccurate`, 140 s. 2.23% too high.
Both outcomes are informative: below 369 removes 47 from the window (chi >= 7); above it fixes the
relaxation's exact value at 47 and closes phase B at that member with a stated reason.

RESUME (the checkpoint both resumes from and saves to; a MISSING path silently starts from zero):
  cd /home/kooshi/source/lean-dir && CUDA_VISIBLE_DEVICES=GPU-UUID-REMOVED setsid nohup build/venv-sdp-gpu/bin/python \
    tools/fplane_sdp_scs.py --p 47 --eps 1e-7 --chunk 2000 --max-iters 400000 \
    --linear-solver gpu_indirect --ckpt data/fs53/ckpt/scs-q47-real-conv.npz \
    --out /home/kooshi/.claude/jobs/b1507518/tmp/sdp47/sdp-q47.json \
    >> /home/kooshi/.claude/jobs/b1507518/tmp/sdp47/s47.log 2>&1 &

ROUND (never through a nudge; from a fresh short continuation's own dual, +2000 iterations):
  build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --blocks --real --p 47 \
    --scs-ckpt data/fs53/ckpt/scs-q47-real.npz --extra-iters 2000 --out data/fs53/cert-q47-N<N>.json
  then: python3 tools/fplane_cert_check.py data/fs53/cert-q47-N<N>.json   (must print CERTIFIED)

NOTE 2026-09-15 23:10: phase B's own checkpoint `scs-q47-real.npz` (cone 72,638) is NOT compatible
with this driver's problem (cone 88,741): the producer drops the `le_diag` constraint class, which
FS-53 measured to be inactive, so the two formulations have the SAME optimum but different warm-start
shapes. This run therefore starts from zero on its own path and leaves phase B's artifact untouched.

NOTE 2026-09-15 23:12: the device is pinned by UUID, not by index. `CUDA_VISIBLE_DEVICES=1` put the
solve on card B (nvidia-smi index 0) because CUDA orders by PCI bus and nvidia-smi does not. card A is GPU-UUID-REMOVED. Verify with: nvidia-smi --query-compute-apps=pid,gpu_uuid --format=csv,noheader

## 2026-09-15 23:52 — the reading CONVERGED, and it does NOT refuse six

`fplane_sdp_scs.py` reached `status solved` (not "inaccurate") at 132,125 iterations:
  pobj -371.40910, res_pri 1.94e-07, res_dual 2.49e-06, gap 4.40e-08.
So the relaxation's optimum at q = 47 is **371.409**, against the 369 six needs. Six is NOT
refused at 47 and no further compute will change that -- the value is converged, not stopped.
What it DOES buy: alpha(47) <= 371 instead of <= 377, so the six-window at 47 falls from
[369..377] (9 integers) to [369..371] (3 integers).

The run then crashed in post-processing on a cvxpy API drift (`chain.solvers` -> `chain.solver`),
AFTER the checkpoint was saved; patched in the tool. Nothing was lost.

BANK IT (the producer uses its own smaller formulation -- it drops the inactive `le_diag` class --
so it reads phase B's checkpoint, not this run's):
  CUDA_VISIBLE_DEVICES=GPU-UUID-REMOVED build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --blocks --real --p 47 \
    --scs-ckpt data/fs53/ckpt/scs-q47-real.npz --chunk 2000 --eps 1e-7 --max-iters 400000 \
    --linear-solver gpu_indirect --out data/fs53/cert-q47-converged.json
