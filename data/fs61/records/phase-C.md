# FS-61 phase C — certify every refusal: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase C and the owner's re-plan block, §5 rule 16. Implementer: de Bruijn
(Opus 5), 2026-09-20. Machine: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle, one
heavy job at a time.*

## The launch — written before the run started (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py land-all
ORDER       359, 11, 119, 143, 47, 95, 191, 71, 23   -- the owner's priority: the four fields with no certified
            witness from this route first (359 and 11 are the genuinely new certificates), the five
            re-certifications of FS-58's witnesses last, so that a hand-back loses the least.
RESUME      the identical command.  A field whose data/fs61/landings.jsonl record says CERTIFIED is skipped;
            inside a field, `extract` checkpoints every core round in witness-<d>/steps.jsonl and resumes from it.
STATE       data/fs61/landings.jsonl     one line per field, with every C-item's exit status and output line
            data/fs61/witnesses.jsonl    the manifest FS-60 consumes
            data/fs61/witness-<d>/       witness.json, witness.lrat.gz, certified.out, controls.out,
                                         wrong-radicand.out, recheck.out, colouring4.json, run-all.sh, README.md
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to a file; pgid found by the log file's inode.
PGID        1679918   (stop with `kill -TERM -1679918`, verify by effect)
```

## A correction made before the run, and what it cost

The first attempt certified `d = 359` with FS-58's `direct-witness`, which shrinks a refusing ball to a 1-minimal
vertex set by deleting one vertex at a time. **It does not checkpoint.** At 46,421 points it was still running at
**33 minutes** with nothing on disk, while it blocked the other eight fields — so it was stopped (cleanly: the process
group signalled, nothing left in the group, no partial file) and the threshold between the two generators was lowered
from 100,000 points to **20,000**, above which `extract` is used instead. `extract` runs assumption-core rounds to a
fixpoint and writes `steps.jsonl` after each, so a kill costs one round; FS-58 used it on a **440,077-point** ball over
`d = 23` in about eleven minutes, so at this size it is both the faster tool and the only resumable one. Cost of the
correction: 33 minutes redone, which is what the checkpointing rule prices a mistake at.

## A second correction, made from the measurements, and it was the decisive one

The first `land-all` selected, per field, the **smallest** refusing ball. That is the wrong choice, and the data says
so sharply: the smallest refusing ball sits in **the hard band just under the threshold**, where a single solve costs a
hundred seconds (the plan's own O3 and O4), while an extraction is thousands of solves.

| d | smallest refusing ball | one solve | fastest refusing ball | one solve |
|---|---|---|---|---|
| 47 | 3,565 pts | **103.72 s** | 8,629 pts | **0.45 s** |
| 119 | 5,605 pts | **114.18 s** | 13,605 pts | **0.75 s** |
| 95 | 6,997 pts | 32.07 s | 17,169 pts | 1.07 s |
| 359 | 46,421 pts | 19.19 s | 113,325 pts | 1.75 s |

230× the cost per solve for 2.4× fewer vertices, at `d = 47`. The selection is now the cost proxy
**`points × (solve_seconds + 0.5)`** — which keeps a fast refusal cheap without picking an enormous graph merely
because the solver saw through it instantly.

**Measured effect on `d = 359`, the same field, the same tool, one thing changed:**

```
  smallest ball (46,421 pts, refuses in 19 s):   120 core rounds -> 5,061 points, ~14 s per round, still falling
  fastest  ball (113,325 pts, refuses in 1.8 s):  14 core rounds -> 2,830 points,  0.6 s per round
```

Twenty times faster per round, and converging to a **smaller** set from a **larger** ball. "Smallest ball" was a
plausible heuristic that the measurements refute; the cost of finding that out was the two stopped runs above.

## State at the hand-back

The certification run is **in flight and resumable**. `d = 359`'s extraction has passed its core-round fixpoint and is
in the per-vertex deletion phase, checkpointing as it goes. Nothing is certified yet, so **no field's value has
changed**, and nothing in `census.md` has been touched: every refusal remains `Refusal claimed`, which is what it was.

```
RESUME      python3 tools/fs61_census.py land-all
            A field whose data/fs61/landings.jsonl record says CERTIFIED is skipped; inside a field, extract
            resumes from witness-<d>/steps.jsonl.
RUNNING     pgid 1727573 (stop with `kill -TERM -1727573`, then verify by effect: the pid absent from `ps`
            and witness-359/steps.jsonl static across ten seconds).
```

**Nothing was pushed and nothing was rescoped.** P4 ("every tier-1 refusal certifies") is **not yet scored**: no
extraction has stalled under the corrected selection — the one that looked like stalling was stalling because of my
ball choice, not because of the object.
