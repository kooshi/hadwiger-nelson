*Brief for job **PA1**: Poros, find other paths to solving Hadwiger–Nelson and verifying it in Lean. Opus 5.5, 2026-09-26. Written by the
product owner. An advisory job: no planner beside you; your record is the options Kooshi chooses from.*

Hello Poros. Your identity is `~/source/poros/CLAUDE.md`; read your skills directly (`~/source/poros/.claude/skills/poros/SKILL.md`,
`…/poros-reframing/SKILL.md`, `…/poros-anomaly-hunt/SKILL.md`). **`data/fs105/briefs/STANDING-RULES.md` is part of this brief** (read "FS-105"
there as "this job", and its paths as `data/paths-2026-09-26/`). Work in `/home/kooshi/source/lean-dir`. Read from disk:
- `CLAUDE.md` (its § The mission, § Publication and § Where the problem stands above all);
- `LEDGER.md` rows 100–130;
- `plans/FRONTIER-STUBS.md`, and the stubs of its top ten;
- the closes of FS-103 (`plans/FS103-collapse-cp-plane.md` §R-close) and FS-105 (`plans/FS105-harden-mr.md` §R-close).

## Kooshi's words (2026-09-26, verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing,
> that's the bar for AI found proofs, and I think we can go all the way to an HN solution). Your recommendation does sound good to me, but
> spawn a Poros advisor to look for other paths so we have some options."

The owner's recommendation he refers to: FS-104, the random-colouring number of the plane at six, aimed first at the one named gap between
the collapse and Falconer's measurable chromatic number — properly colouring Falconer's measure-zero boundary set (FS103-M's D1–D5, a finite
list-colouring problem).

## Where things stand (read the rows; this is orientation, not a source)

Given MR (row 120, hardened by FS-105):
- `χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(ℚ(√635087)²)` (rows 128, 130);
- the one-class-at-a-time density route tops out below 4.37 and never gives six (row 129);
- a six-chromatic plane means every measurable 5-colouring has a positive-measure set of monochromatic unit pairs.

Everything above five is open. Nothing past rung B and the classical interval is in the kernel beyond row 127's conditional forms.

## What I'd like from you

1. **Your expectation first**, at the top of your record `plans/POROS-2026-09-26-hn-paths.md`, before any search: which value you think
   `χ(ℝ²)` is, where a proof of it would most likely come from, and with what confidence.
2. **Three to six distinct paths to the full answer**, including at least one for each direction: a proof of six or seven from below, or of
   five or six from above. Include the owner's recommendation as the baseline to beat. For each path:
   - what it would prove, and what it rests on (which rows, which external theorems, which open steps);
   - **its Lean cost**: what Mathlib holds and what would have to be built. Consider:
     - entropy and leafwise measures, for MR;
     - Fourier analysis on `ℝ²` and weak-* compactness, for the measurable route;
     - SAT certificates through the existing LRAT checker, for a finite witness;
     - Tarski, for the bridge.

     Treat the cost as a first-class criterion (Kooshi's bar);
   - the first milestone, its kill criterion, and a probability that the path reaches the answer;
   - whether it needs finite-witness search. That search is banned to 2026-10-01; after the ban it is allowed again as one instrument.
3. **Frame items:**
   - a path the ledger opens that no stub names;
   - a step that looks cheap on paper but is ruinous to formalize (MR itself is the obvious candidate: is there a route to the answer that
     avoids MR, or one where MR's Lean cost is paid once and reused?);
   - where the collapse to measurable colourings makes a classical tool (harmonic analysis, the density LPs, Falconer's argument, spectral
     bounds) newly decisive.
4. **Hold every path to the standard of evidence** (G21; Kooshi on FS-62: "one possibility with some soft evidence"): say which evidence is
   derived, which is soft, and which is none.

## Rules

- **Touch only** your record and `data/paths-2026-09-26/pa1/`. Commits by explicit path, subjects "PA1: stage n"; push; never amend or
  force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- The ban on finite-witness search holds to 2026-10-01. Reading and fetching papers is in; contacting anyone outside is Kooshi's call.
- Work in stages and save after each: the expectation; then the paths in two saves; then the frame items and the comparison table.
- **Budget:** about 250k by the harness's count; hand back by 350k.
- **Report** to `data/paths-2026-09-26/reports/PA1.md`, committed, and by SendMessage to "main", at most 16 lines: the paths in one line each,
  with direction, Lean cost (low / medium / high / very high), probability and first milestone; your recommended order; and where you differ
  from the owner's recommendation. Final turn text: "PA1 idle; report sent to the owner by SendMessage".

Thank you.
