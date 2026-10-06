# FS-131 — a planner's price against what the implementer measured

*Keryx, 2026-10-06, at Kooshi's word ("Calibrate that price against plan factor, because it matters for many implementations that get
deferred"). Inventory item 541. The measurements are `data/fs131/calibration/measure.out`, produced by `measure.py` beside it; the
planned figures are each job's "prediction scored" line in `plans/FS131-close-inventory.md` (item numbers below) and the planners'
price tables. One mind's reading of the pairs; the numbers are the scripts' and the records'.*

## 1. What one implementer job is, measured

Nineteen finished implementer jobs of this milestone (waves 4–6, 10 and the example maps):

- **Lean written**: 259 to 3,122 lines inserted under `Proofs/` per job; median 1,341.
- **Tokens** (the harness's count, the eight jobs that have one): 353k to 546k; median about 430k, mean 445k. By least squares over those
  eight, **tokens ≈ 311k + 129 per line**: about 300k of a job is fixed (the readback, the build as given, the record, the report), and
  a job at its 500k line holds about 1,500 lines. All-in, 277 to 712 tokens per line, median about 430.
- **Wall-clock** (the harness's duration, four jobs): 44, 59, 68, 79 minutes, of which four to six builds of eight or nine minutes each
  are about half. First-to-last commit over all nineteen: 25 to 80 minutes.

So **one implementer job is about an hour, about 430k–450k tokens, and about 1,300 lines of proved Lean** (up to about 2,000 when the leaves are
long, 500 when they are few).

## 2. The factor depends on the unit the planner priced in

| the planner priced in | pairs | measured ÷ planned | how to read such a price |
|---|---|---|---|
| **tokens** | 4 implementer jobs, 1 planning pass | 1.18, 1.28, 1.35, 1.48 (the planning pass: 3.1) | about right; add a third |
| **lines of Lean** | 13 | median about 0.75; proofs 0.21 to 0.72; explicit objects and models 0.9 to 1.8 | about right; proofs run under, objects over |
| **sessions** (one session is one job) | 7 | 0.2 to 1.0, typically 0.5 | halve |
| **agent-hours and agent-days** (wave 6's planners) | 4 | in jobs: 22 h, 2 d, 9 d and 12 d each took **one** job; on the clock between one sixteenth and one eighty-fifth, taking a day as eight hours | divide the days by ten to get jobs |

The pairs, with their inventory items:

- *Tokens*: FS131-I10A 300k → 404k (493); I10B 350k → 449k (506); I10C 300k → 444k (519); I10D 300k → 353k (538); the planning pass
  K10b 150k → 472k (509).
- *Lines*: I10A 1,550 → 1,020 (493); I10B 1,900 → 660 (506); I10D 610 → 442 (538); CG1 2,250 → 1,190 (402); CC2's two leaves 650 → 135
  (416); the bridge of wave 6, about 5,000 for 23 planner-days → 3,321 for the 21 of them proved (items 539, 540); KM1's relabelling
  60 → 45 (460); BA3 350 → 361 (464); MB1 950–1,300 → 1,157 (470); MB2 950–1,300 → 1,500 and 350–500 → 566 (479); MA1 950–1,350 →
  1,718 (472); IL2 400–600 → 800 (388).
- *Sessions*: IS1 1 → 1 (431); IA2 1 → 1 (447); IR2's kit, a quarter of one against two for the step (435); IR3 2 → 1 (449); BA1
  2 → 1 (454); BA2 "about five times cheaper than the plan's table" (456); IL2 1 → "well under" 1 (388).
- *Agent-time*: I6A 22 h → one job, about thirty minutes of proving (516); I6B 2 d → one job, with a model the plan had not priced
  (530); I6C 9 d → one job (539); I6D 12 d → one job (540).

**What the table says.** The planners know how much Lean a result needs: their line counts are right to within a factor of two either
way, and their token counts to within a half. What they misjudge is **time per line**. Wave 6's planners priced about 220 lines to an
agent-day (5,000 lines, 23 days); the implementers wrote 700 to 1,700 lines an hour, builds included. A price in days or hours therefore
carries no information beyond the line count it was derived from, and overstates the cost by one to two orders of magnitude; the same is
on record for earlier milestones (`plans/GROKKING-INSTANCES.md` § What compute actually helps: "5× to ≥ 30× in time, never in tokens").

## 3. What it does not measure

- **Planning.** Every figure above is an implementer's. Each wave also took one to four planning passes of about 450k–550k tokens each
  (wave 6: four, and a deriver's job), and a landing of about 540k. A result that is not yet stated costs a planning pass before any of
  the above applies.
- **Leaves a planner marks as hard.** Of wave 6's thirty-four new leaves its planner names six as carrying the price's interval, and two
  of those as having no route in the kernel yet (one rests on a two-line hand step, one on one mind's argument). None has been attempted.
  The factor above is for leaves whose route exists.
- **Mathematics that is missing, not merely unformalized.** Where a planner wrote "no proof in hand", the cost is a derivation, and
  no line count prices that.
- **Jobs that did not finish in one.** The outward bend of wave 5 took a planner and three implementers, and `exists_arcStep` two
  attempts; their per-job figures are in the table, their job counts are not.
- **The sample.** Eight jobs carry a harness token count and four a harness duration; the other minutes are commit times plus twelve.

## 4. The rule adopted

1. **A price is read in lines and converted to jobs**: lines ÷ 1,500, rounded up, plus one planning pass if the statements do not exist.
   A price in days is converted through the line count its planner used, or divided by ten.
2. **Planners price in lines of Lean and in implementer jobs, never in days** (their briefs say so from this item on).
3. **`LEAN.md` § Assumptions' "about an hour of agent work" is one implementer job**: about 1,300 lines with its route known. A result
   a planner prices at up to about ten of its days is inside that hour.
