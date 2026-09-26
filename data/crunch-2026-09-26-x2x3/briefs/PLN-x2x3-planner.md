*Brief for the planner of the 2026-09-26 ×2×3 crunch. Opus 5.5. Written by the product owner. Its template is the last crunch's planner
brief (`data/crunch-2026-09-25/briefs/PLN-crunch-planner-brief.md`); this brief overrides it where they differ.*

Hello de Bruijn (`DEBRUIJN.md`). I'm the product owner and orchestrator of `/home/kooshi/source/lean-dir`; Kooshi, whose project this is,
has asked me to coordinate and not to do the mathematics. I'd like you to **plan a two-hour crunch attacking the ×2×3 problem, as a job
queue**. An advisor (Poros) works beside you. **The plan is yours to write; the choices are Kooshi's**, through me.

## Kooshi's words (2026-09-26, verbatim)

> "next, we'll do a short crunch run attacking the x2x3 problem"

> "Quick crunch. 2 hours, 6 agent slots, CLAUDE.md unbounded temporarily so we don't need to compress on the fly. Launch a planner and a
> Poros advisor to lay out the queue attacking x2x3. Read up on the last crunch run for any additional details. You act as coordinator
> only, and preserve your context, so a subagent does bookkeeping runs."

## The clock and the slots

- **The crunch opened at 10:26 UTC and ends at about 07:26.** Your queue table and the first briefs should be committed by about
  **05:55**, so that the jobs get about an hour and the close about half an hour. Plan in stages: first the queue table, the claim list
  and the first two or three briefs; send me those the moment they are committed, and I launch them while you finish. Polish later or
  not at all.
- **Six agent slots in all.** You and Poros hold two until you hand back. A Sonnet clerk does the bookkeeping and holds a slot while it
  runs (it is running now, briefly, to record the budget change below). So the first wave can be three jobs; after you and Poros hand
  back, five working jobs plus the clerk.
- **`CLAUDE.md` has no byte budget during this crunch** (Kooshi, above). The close's front-page job adds what it needs and compresses
  nothing. A clerk is recording that in the file's header now.
- **The last crunch is your template:** `plans/CRUNCH-2026-09-25-queue.md` §1 (protocol), §4 (brief skeletons), §8 (its close and lessons),
  and `data/crunch-2026-09-25/briefs/` (STANDING-RULES.md, J00-clerk.md, and the pair that worked on a fixed claim list:
  J51D-FS100-kronecker-derivation.md and J51V-FS100-kronecker-verifier.md). Reuse by reference; write only what changes.

## What ×2×3 is to this project (pointers, not a prescription)

Read these from disk; quote, never paraphrase:
- `LEDGER.md` rows 116–118, and row 118 above all: MR(F) — "every `U`-invariant, `E`-null, finite positive measure on `R̂` is a multiple of
  Haar" — is its zero-entropy half plus an owed lemma, PE-lim. Einsiedler–Lindenstrauss 2021's Theorem 1.3 covers positive entropy; its
  Theorem 1.2's total irreducibility fails for every finitely generated `Γ ⊂ U` on `R̂` (J51-T2).
- `plans/FS100-three-field-lemma.md` §PA.3 (the MR reading room, answered) and §R-close; `plans/FS100-derivation.md`;
  `plans/STUB-measure-rigidity-three-fields.md` (FS-100, re-aimed) and `plans/STUB-infinite-place-spectra.md` (FS-97, absorbed; its
  "(R1), (R2), entropy and ×2×3").
- `CLAUDE.md` G72 (the structural question), G76 (the character side: closed-set rigidity at two or more primes holds, rows 95, 98), G79
  (the example invariant against the counterexample invariant), G21, G49, G50 (FS-100's instance: papers held under a journal-year key were
  written "none held" — grep `BIBLIOGRAPHY.md` and `~/source/library/` before calling anything unheld).
- The literature named so far: Furstenberg 1967 (closed sets; held), Rudolph 1990, A. Johnson 1992, Host 1995, Einsiedler–Lindenstrauss 2003
  and 2021/2022, Lindenstrauss–Wang 2012, Z. Wang 2012, Bekka–Francini 2022, Berend 1983/1984.

**Questions the records leave** (a starting list; rank them yourself, with the advisor, and add better ones):
1. **Hardness.** Does MR(F) at ℚ(√47), or its zero-entropy half, *imply* an open case of Furstenberg's measure conjecture (for example
   through a quotient or sub-solenoid of `R̂` on which some `U`-action looks like `×p, ×q`)? A yes is a theorem that FS-100's lemma is at
   least as hard as ×2×3, and it re-routes FS-100. A no-go counts in full (G79; "all novel knowledge is a success").
2. **The flip (G79).** What does the spectral measure of every *actual* four-colouring carry that an arbitrary zero-entropy invariant
   measure need not? Can properness, the band, `E`-nullness or the rotated real direction force positive entropy, so that EL2021 Theorem 1.3
   applies and the open problem is sidestepped for the consumer at ℚ(√47)?
3. **PE-lim**, the owed lemma, as a derivation.
4. **What `U` has that ×2×3 lacks:** infinitely many split primes and a rotated archimedean direction. Does any result for actions with more
   (or infinitely many) multipliers, or for invariance under many `×p`, give more than two multipliers do?
5. **What the consumer needs:** MR for every measure, or only for measures of a special shape.

The honest prior is that the classical conjecture will not fall in two hours. Say so in the expectations, with a number, and plan for the
results a two-hour attack can actually buy: a reduction, a hardness theorem, a special case, a proof that a route is closed, a reading.

## What to produce: `plans/CRUNCH-2026-09-26-x2x3-queue.md`

1. **The protocol deltas**, at most a screen: the clock; the slots; the crunch directory `data/crunch-2026-09-26-x2x3/` (`briefs/`,
   `reports/`, `READY.md`); the clerk's cadence; halts and resumes; `CLAUDE.md` unbounded; when the close starts and what it contains.
2. **The milestone's reframe, compact but complete** (WORKFLOW 3, Kooshi's rule; propose how to keep it in proportion to two hours, never
   how to skip it): name the milestone (a new stub, or FS-100's next slot — your call, argued); §G, the walk of the grokkings and rows that
   bear, one line each; §PA, what is held and which sections a reader must read; §IQ, the existence form and the structural form.
3. **The queue table** (the last crunch's §2 columns). Jobs of about an hour and at most about 250k harness tokens each; at least three
   startable at once. **Derivation jobs run beside blind verifiers on a fixed claim list, quoted verbatim in the plan before any derivation
   starts** (the J51D/J51V pattern). A close-math job and a front-page job at the end, with start times.
4. **Briefs as files** under `data/crunch-2026-09-26-x2x3/briefs/`, ready to launch ("Your brief is on disk: read `<path>` in full
   first"); a **STANDING-RULES.md** for this crunch (the last one with the deltas changed); and the clerk's brief (J00, Sonnet: the last
   one with the paths changed).
5. **Registered expectations**, with probabilities, including the honest probability that the conjecture itself, or MR's zero-entropy half,
   is proved; and what would make the two hours good.
6. **The close inventory**, opened as its own file (WORKFLOW 5).

## Mechanics

- **The advisor:** a Poros session launched beside you. I'll send you its id by message. Send it your drafts as they take shape and ask
  what it would change; its advice is advice: you decide, and record disagreements.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  The reason: staffing is Kooshi's budget decision, and I can only review work I know about. The same line goes into every brief you write,
  with its reason.
- **Work in stages:** short responses; save and commit after each section. A response lost to the output-token limit is unrecoverable.
- **The ban holds** (no finite-witness search until 2026-10-01; exact checks of seconds are fine). Every brief carries the "would have
  searched here" log.
- **All novel knowledge is a success** (Kooshi). Tell every job not to lean toward a yes, and quote statements verbatim in every brief.
- **Commits by explicit path** (`git add <new>`, then `git commit <paths> -m …`), never amend, push after each commit (on a ref-lock race,
  `sleep 4` and retry), never force-push. Neutral subjects ("X23 planner: stage n"). End messages with your harness's attribution lines.
- **Don't edit** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or `BIBLIOGRAPHY.md`; propose such edits in the plan.
- **Budget:** about 200k tokens by the harness's count; hand back by 280k.
- **Report** to me by SendMessage (`to: "main"`), at most 12 lines: the jobs to launch first with their brief paths, the protocol deltas in
  five lines, the hash. Send an early message as soon as the first briefs are committed. Keep your final turn text content-free: "planner
  idle; report sent to the owner by SendMessage".

Thank you.
