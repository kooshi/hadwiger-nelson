*Brief for crunch job **J47**: write "the portrait of a four-colouring of ℚ(√47)" up as a full milestone stub, to be run after the crunch.
Opus 5.5, 2026-09-25. Written by the product owner at Kooshi's request: *"Write up the portrait of 4 in 47 as a full milestone to be run at
some point after the crunch. I suspect the other wanted posters will result in the same."* It launches **after J45 and J46 report and after
both sibling posters (J38, J39) are committed** (Kooshi: *"hold the stub writer until after the posters in case they share
identities"*), so that the stub carries the verified verdicts and can say whether the three posters share one identity.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **a milestone-stub writer**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk: WORKFLOW step 2's **stub rule** in full, and steps 3.1–3.3, since the stub feeds
them. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your stub file already exists, you are resuming.** Check its last SAVED stage against `git log` and continue at the first stage not
SAVED.

## What the milestone is

The conjecture predicts that ℚ(√47)'s plane needs exactly five colours, and four is proven (`CLAUDE.md` items 10 and 14; FS-84). A Poros
session assembled the **wanted poster** of a four-colouring of that plane (`plans/POROS-2026-09-25-wanted-poster-47.md`, J37). The poster
has ten proved constraints. It closes into no theorem; it leaves one named gap. That gap is the colourings with no proper factor colouring
continuous at finitely many places, which is exactly the failure of the example invariant EI-2
(`plans/POROS-2026-09-25-infinitely-many-primes.md` §4.1; G79). The gap has two layers:
- **pure-point:** rank one is closed by T-J37-1; rank ≥ 2 is open, and J37 names the missing lemma "Kronecker selection" (§4.5);
- **continuous:** the Furstenberg-type zero-entropy remainder (J36 F5).

The milestone's question: **close the gap, or exhibit a colouring in it.** Either decides whether ℚ(√47)'s plane can be four-coloured
by any colouring that is not excluded format by format. Both outcomes count. Kooshi: *"All novel knowledge is a success."*

## Read first

- J37's poster record in full: its §3 theorems table, §3.3–§3.4, and §4.1–§4.6 (the killing tests KT-1 and KT-2, Kronecker selection
  verbatim, the registered priors, R1–R4).
- J36's record: F2–F5, F7 and §4.1–§4.4.
- **The two verification records**, which your stub must quote at their final verdicts:
  - `plans/FS84-SI-D-derivation.md` (J45, the derivation of J36's SI, A⁺, B⁺, R-U, SP);
  - `plans/FS84-SI-V-verification.md` (J46, the blind check, which also judges T-J37-1 as W1).
- The FS-84 stub `plans/STUB-five-colours-47.md`, its plan `plans/FS84-five-colours-47.md`, and `plans/FS84-close-inventory.md`
  (rows 23–25).
- Stage S1 and its blind check: `plans/FS84-S1-derivation.md` and `plans/FS84-S1V-verification.md`.
- `plans/R88-derivation.md` (T-C, T-C(A)); `LEDGER.md` rows 84, 92, 95–98 and 111–113.
- **The sibling posters (they exist when you launch):** J38 (ℚ(√59), `plans/POROS-2026-09-2*-wanted-poster-59.md`) and J39 (ℚ(√167),
  `…-167.md`). Kooshi suspects they end the same way. If they do, say so in a "Siblings" section and state whether one milestone should
  carry all three targets. Look for identities they share with ℚ(√47)'s poster: the same evasive class, the same missing lemma, the same shared input. Where they share one, state the identity once and recommend whether one milestone (or one milestone with three targets) should carry them.

## What to write

**The stub file `plans/STUB-portrait-four-colours-47.md`, as FS-100** (the next free number; FS-97 to FS-99 are taken). It follows WORKFLOW
step 2's stub rule, written so that a fresh session with no memory of tonight can subplan it with all meaning intact:
1. **Mission context in plain language.** Why this field, why four, what the conjecture predicts, and what a four-colouring would do to
   it (it would falsify the five-clause; a finite refusal can only confirm, G48).
2. **Everything known, graded and addressed.** The poster table, reproduced at exact scope and grade: [kernel], [cert], [hand, two
   derivations], [hand, one mind], [measured], [reading]. Measured nulls stay apart from theorems. J45's and J46's final verdicts replace
   J36's sketch grades wherever they apply.
3. **The gap, stated as precisely as the records allow,** with its two layers and the lemma statements verbatim:
   - Kronecker selection (J37 §4.5);
   - EI-2 (J36 §4.1);
   - SP's Furstenberg equivalence, at its verified grade.
4. **Registered expectations and priors** (J37 §4.6: Kronecker selection 0.4, EI-F 0.30; J36: EI-2 about 0.4), each with its killing test.
5. **The shape of the milestone,** as a provisional outline for the planner:
   - **§IQ's seed.** The structural form is EI-2, a question about every four-colouring. Name the invariant it forces, or write "none
     known".
   - **The in-ban derivation stages:**
     - Kronecker selection, a derivation with a blind check;
     - the continuous layer, which is a reading room unless a handle appears.
   - **The in-ban tools stage KT-1:** a ball-arithmetic re-check of `[AmbrusEtAl2023]`'s obligation H4, the input shared by five
     constraints. It needs `python-flint`, which Kooshi has been asked to approve installing. Say what a failure of KT-1 would do to each
     row.
   - **The post-ban stages:**
     - J37's R4, a triangle-free Dúcz–Varga-type finite `H` inside ℚ(√47)² (EI-F's route);
     - FS-84's own post-ban stages, cross-referenced, not copied.
6. **Failure clauses:** what counts as not landed, and what each null would teach.
7. **Named deliverables.** Include a visualizer deliverable, since this milestone produces an explorable object (the poster). Point at
   J43's unified map if it exists.
8. **The provisional-bearings line:** the grokkings you believe bear. At least G48, G64, G72, G74, G76 and G79; check G21, G54 and G60.
   Give one clause each on why.
9. **Its relation to FS-84.** FS-84 stays open, holding its post-ban search stages. This milestone is the derivation route to the same
   question. State which of FS-84's stages move here, if any, and write each moved stage down in both stubs.

**Also:**
- a row in `plans/FRONTIER-STUBS.md`, ranked with its bearing on χ ≥ 6 stated honestly (probably none directly: a four-colouring falsifies
  a prediction; five confirms);
- a matching row in `CLAUDE.md` § Paths forward, at most about 700 bytes. The file's ceiling is 325,000 bytes until the crunch ends, and
  it stands near 295,300.

Run `tools/claude_md_fact_audit.py --base <HEAD at your launch>` (it must PASS) and `tools/bib_audit.py`. Read each exit status directly.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **Touch only:**
  - `plans/STUB-portrait-four-colours-47.md`;
  - `plans/STUB-five-colours-47.md` (only the cross-reference and any moved stages);
  - `plans/FRONTIER-STUBS.md` (the new row, and the ranks it shifts);
  - `CLAUDE.md` § Paths forward (the new row, and the ranks it shifts);
  - your record `data/crunch-2026-09-25/j47-record.md`.

  **Never touch** `LEDGER.md`, job records, Poros records or verification records.
- **Quote, never paraphrase,** every statement you carry into the stub (standing rule 5), with its address.
- **No finite-witness search** (the ban runs to 2026-10-01).
- **Commits by explicit path**, subjects "J47: stage n". End commit messages with your harness's attribution lines. Push after each
  commit; never force-push.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J47.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J47 idle; report sent to the owner by SendMessage".

Thank you.
