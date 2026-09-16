# Phase B's solver logs — provenance for the six certificates of 2026-09-15

These evidence `cert-q{79,67,59,47,43,31}-N*.json` (the six exact certificates that took the window for a
six-chromatic finite Euclidean plane from eight members to five). They lived only in job scratch until
2026-09-16.

* `prod-q*.log` — each member's producing solve.
* `polish-q*-<iters>.log` — the continuations, each rounding from **its own** dual. The naming records the
  iterate. This is where the corrected recipe was measured: a **+500** continuation at `q = 67` rounded to
  748.83, clearing its threshold by nothing, while **+2,000** gave 745.23 — a float bound 1.21 lower whose
  dual also rounds 2.5× tighter (rounding loss 1.633 against 4.022). Three integers, on the member that had
  one to spare. The mechanism in `CLAUDE.md` row 68 was right; the number in it was wrong.
* `arm*.log` — the two-backend arms that give an independent pair at one iterate.
* `exp-q*.log` — the `le_diag` experiment's logs; its records are in `../../ledag/`.

**A note on the checkpoints.** `--scs-ckpt` both resumes from and **saves to** its path, so
`../../ckpt/scs-q31-real.npz` no longer holds phase B's 170,000-iteration state: the 2026-09-16 convergence
run advanced it to the converged 394,925-iteration state behind `cert-q31-N200.json`. Phase B's earlier state
is in git history, and `phaseB/arm31.npz` in the (ephemeral) job scratch was the same bytes. This is the
documented trap in the other direction — the flag is a two-way door, and a path that does **not** exist
silently starts from zero, which cost 2h47m of a graphics card on 2026-09-15.
