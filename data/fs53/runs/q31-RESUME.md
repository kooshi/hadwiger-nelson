# q = 31, five-refusal attempt — resume command (written BEFORE launch, per CLAUDE.md)

Question: does the relaxation at 31 converge BELOW 193?
  n = 961; five colours need a class of ceil(961/5) = 193, so alpha <= 192 refuses five.
  Phase B's certificate: float 201.66563, status `optimal_inaccurate`, from a **22.8 s** solve --
  the least converged of the whole set.  Required reach 193/240.25 = 0.8033, against the 0.7973
  just demonstrated at q = 47 on a converged solve.  INSIDE the envelope, so this is live.

Payoff if it lands: five refused at 31 puts its floor at SIX, so a single verified six-colouring
there would settle the milestone -- joining 43 and 47, where five is already refused.
If it does not: the relaxation's exact value at 31 is known and the member is closed like 23 and 27.

RESUME (identical command; --scs-ckpt both resumes from and saves to, and a MISSING path silently
starts from zero -- that cost 2h47m of a graphics card on 2026-09-15):
  cd /home/kooshi/source/lean-dir && CUDA_VISIBLE_DEVICES=GPU-UUID-REMOVED setsid nohup \
    build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --blocks --real --p 31 \
    --scs-ckpt data/fs53/ckpt/scs-q31-real.npz --chunk 2000 --eps 1e-7 --max-iters 400000 \
    --linear-solver gpu_indirect --out data/fs53/cert-q31-converged.json \
    >> /home/kooshi/.claude/jobs/b1507518/tmp/sdp31/round31.log 2>&1 &

The device is pinned by UUID, never by index: CUDA orders by PCI bus and nvidia-smi does not.
Verify with: nvidia-smi --query-compute-apps=pid,gpu_uuid --format=csv,noheader
VERIFY the result: python3 tools/fplane_cert_check.py data/fs53/cert-q31-converged.json  (must print CERTIFIED)

## CORRECTION, 2026-09-16, before any result

The launch argument above said 31's certificate "came from a 22.8 s solve -- the least converged
of the whole set". That is WRONG. `provenance.seconds` is the final ROUNDING invocation's time,
not the solve's: the checkpoint at 31 carries **170,000 iterations**, against 47's 89,000, so 31
is the MORE converged of the two, not the less. Same error CLAUDE.md already records -- a number
put into a decision without carrying what it measures -- and it is the third instance tonight.

What survives, because it was about the target rather than the convergence state: refusing five
at 31 needs reach 193/240.25 = 0.8033, and 0.7973 was just demonstrated at 47. That is still
inside the envelope, so the experiment is still worth running.

What the corrected picture says about the odds: the value is moving ~0.036 per 2,000 iterations
and decaying, from 201.27 toward a target of 193 -- 8.27 away. On that trajectory it will NOT
reach 193. Expect the member to close like 23 and 27 rather than to yield, and treat a refusal
of five at 31 as the surprise rather than the expectation.
