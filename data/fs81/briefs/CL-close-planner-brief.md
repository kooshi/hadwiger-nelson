# Brief: FS-81's close (WORKFLOW step 9), for the planner who writes it

You are **de Bruijn**, the engineer who owns the mathematics of `/home/kooshi/source/lean-dir`, working as **the planner for FS-81's
close**. I'm the product owner, the coordinating session. Kooshi, the human whose project this is, asked me to coordinate this
milestone rather than write it. His standing instructions for a close still hold:
- *"close out with the findings"*;
- *"I don't want to lose anything from before. There's a lot to save."*

**Every result enters the ledger and the Frontier at its exact scope and grade.** At FS-79's close the owner's morning report
overstated seven things, and since then this is a rule. A hand proof checked twice is not "kernel"; a finder's null is not an emptiness;
a price carried from a control is a [reading]; and nothing is "new" or "first" while the prior-art debt below stands.

## Read from disk first

- `WORKFLOW.md`: step 9 in full, and steps 3.1 and 3.3, because the close re-reads §G and §IQ.
- `CLAUDE.md` and `DEBRUIJN.md`. Any copy loaded into your context predates this session's edits. In particular, `CLAUDE.md` § Building
  gained **the resource rule today**, so read it before you run anything.
- `LEDGER.md`, by address, not loaded whole.

## Your checklist already exists

It is `plans/FS81-close-inventory.md`, items 1–86. It was written as the milestone ran (WORKFLOW step 5), not reconstructed at the end,
and every item names its source.
- **Work through it, and tick each item in the file as you finish it:** "done at <hash>", or "declined, with the reason". From now on
  you are its only writer.
- **Read every number from its source record, never from the inventory.** That is `CLAUDE.md`'s one-home-per-fact rule, and it also
  catches the owner's slips. One of mine is item 51.
- **The inventory is not scripture.** If an item is wrong, or something is missing, fix it and tell me.

**The sources, in one place.**
- **The plan:** `plans/FS81-quadratic-four-colours.md`. Its sections are §0, §G, §PA, §IQ, §F, §S, §P, §M, §X, §R-review, and §B (the
  modeling passes).
- **The proofs:**
  - `plans/FS81-F-sketch.md` (the planner's);
  - `plans/FS81-C-verification.md` (the blind verifier's; §5 is "Theorems this phase proved");
  - `plans/FS81-derivation.md` (T1–T8, opened by the verifier).
- **The phase records:**
  - `data/fs81/records/phase-P0.md` (§9 is "Theorems this phase proved"), with `phase-P0-objects.md`;
  - `data/fs81/records/phase-D.md` ("Theorems this phase proved"), with `data/fs81/phaseD/d47/survivors.md`.
- **The advisor's record:** `plans/POROS-2026-09-24-fs81-plan.md`.
- **The briefs:** `data/fs81/briefs/`.
- **The owner's checks:** cited in the inventory rows (items 22, 36, 41, 48, 61, 64, 72, 73, 79).

## What the close must produce (WORKFLOW 9; the inventory itemises it)

1. **`plans/FS81-derivation.md` completed.** It already holds T1–T8. Add every other theorem FS-81 proved outside the kernel:
   - phase 0's P0-T1–T11;
   - stage D's D-T theorems;
   - anything in the plan's §F, the modeling passes (§B) or the verifier's record that is not yet filed.

   Each entry carries its statement, grade, the proof's address, what rests on it, prior art and a kernel decision. Add one line each in
   `LEDGER.md` § B, and keep `tools/fs71_ledger_b_check.py` green. **Credit every finding by name:** the planner, the plan-phase advisor,
   the phase-0 implementer, the modeling agent, the blind verifier, the stage-D implementer, and the owner where an owner check is cited.
2. **`LEDGER.md` rows 82 onward.** Row numbers are stable identifiers, never renumbered or reused. How many rows, and what each carries,
   is yours. Three natural candidates:
   - **the field-level theorem**: F-T4 for every squarefree d ≡ 11 (mod 12) and in its general, field-free form, with §F.5 and T7, at
     [hand, two independent derivations];
   - **the census completed**: all 40 squarefree d ≡ 11 (mod 12) below 500 certified, the 25 open fields by structural certificates at
     [cert + hand], 11 of them also through the frozen checker, independent of F-T4;
   - **the four-colour calibration and ℚ(√47)**: R*(X_A) ≤ 1.4 certified; the undecided band; the ℚ(√47) screen's 25 survivors; D2's
     price as a size ratio at [reading].

   **Every row states what is not claimed.**
   - Nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread (items 10, 33). The relation is `[Fischer1990]` Thm
     10(ii) and Ex. 4; the step from additive colourings to all colourings is ours, as far as the gate reached (plan §PA.4 has the
     wording a claim may use).
   - FS73-T22's ⟹ direction is hand-proved, never kernel.
3. **`CLAUDE.md`, current state only.**
   - **The Frontier:**
     - "last updated";
     - "where the problem stands": item 14 rewritten, and item 10's proved range widened (χ = L for every real quadratic field with
       L ≤ 4);
     - the mission's exposed-predictions paragraph (four at the census's 25 open fields is now proved; five at ℚ(√47) was priced, not
       landed);
     - the ledger pointer (rows 1–N);
     - Paths forward.
   - **The grokkings:**
     - **G61 rewritten.** T4 is proved. "No proof and no route to one" and "no witness transfers between fields" keep a demotion
       record (G67's rule: a grokking that dies is demoted, never deleted). Add the mod-8 skew reading (items 59, 66) with its killing
       test.
     - **A new grokking, if the findings earn one.** The field-level three-colour theorem and its layer method, stated as a law with a
       trigger, a *Do*, and what it forbids or its killing test (G67's form). Whether it earns an entry, and its number, are yours.
     - **Instances**, each an instance line and not a retelling:
       - G21: a relation tree is a weak finder of isolated points; contended times inflate 2–3×; a finite configuration measures its
         depth;
       - G54's *Do* naming all three signs (item 15);
       - G65's four-colour band (items 76, 84);
       - G38 and G55: Fischer's additive obstruction upgraded to all colourings, and ASTRA-T4's missing half without √3;
       - G49 (Fischer 1990 held the relation);
       - G51 (the blind verifier in the V2 pattern, in place of a competition);
       - G71's *Do* (three colours are decided exactly for real quadratic fields);
       - G72's second count (below).
   - **Rules:**
     - value precedence with pins (item 52), and the SAT-solver week (item 82) stated with absolute dates as current state: one week
       from this close's date;
     - § Building's resource paragraph already carries Kooshi's rule from today; don't restate it.
   - **Size:** the budget is 275,000 bytes and the file is 262,342 now. That is tight. Compress without loss elsewhere if you must, and
     never touch a `[PROTECTED]` paragraph.
   - **The fact audit at the end:** `tools/claude_md_fact_audit.py --base fad1c032` (FS-79's close) and `--dupes` (it stood at 15
     runs). Nothing lost, nothing retold; an intended change gets an ALLOW entry with its reason.
4. **§R-close in `plans/FS81-quadratic-four-colours.md`.**
   - **The §G re-read:** which extractions paid (G7 + G62 + G55 + T40 produced §F), and which entries should have borne and did not.
   - **The §PA sweep for recognitions:**
     - Fischer's relation;
     - the torus-coset reading;
     - circular colouring as the discipline's name for a Θ point.
   - **The §IQ re-read, G72's second count** (item 1): did the result come through the structural question, the field-level
     classification of Θ₃, or from elsewhere? State it honestly, and state the phase-0 certificates' route separately.
     - The advisor's proposal to count target-moving results separately from no-gos (item 7) is **Kooshi's call**. Record the count
       both ways and leave the proposal open.
   - **The predictions, scored once:**
     - the plan's §P;
     - phase 0's;
     - the verifier's C0;
     - stage D's PD-1–PD-8;
     - P-G54 (already scored);
     - P-D0, unscorable as worded (item 84).
   - **The retraction tally, the errata and the honesty record:**
     - the owner's errors (items 15, 51);
     - the agents' slips (items 21, 31, 67, 84);
     - the kills and their forfeits (items 77, 67);
     - tool defects (items 38, 81).
5. **Stubs, and `plans/FRONTIER-STUBS.md` properly re-ranked** (item 8: the rank column repeats below rank 1, so it orders nothing).
   - **FS-81's banner.**
   - **New stubs or re-aims, where the findings earn them:**
     - the residual three-colour case (item 66(1));
     - multiquadratic fields without √3, with ℚ(√2,√7) first (item 28; FS-48 re-aimed, or a new stub);
     - FS-75 re-aimed (item 66(2));
     - ℚ(√47) at five colours, carrying D1's deep pass (item 86);
     - the layer method at five colours, and item 12 routed to FS-64;
     - the d ≡ 23 (mod 48) lead (item 79).
   - **FS-59's bearing** gets the measured four-colour band and the matched-control infeasibility (items 76, 84, 86).
   - **`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5** (item 9): rewrite or retire it.
   - **Don't pre-empt the next direction.** Kooshi has ruled a one-week SAT-solver ban after this close, and a separate Poros is
     advising what that week should do. Rank honestly, mark which stubs need a SAT solver, and leave the choice open.
6. **The protocol:** FS-81's run, recorded in §3's style of `plans/PROTOCOL-competitor-and-advisor.md`. That is a plan-phase advisor, then a
   **blind verifier in place of a competition**, with the stall criterion that never fired. Add the budget anchors: planner about 230k
   working tokens; plan-phase advisor about 200k; phase-0 implementer about 265k; modeling agent about 230k; verifier about 520k
   (harness counter); stage-D implementer about 345k.
7. **Everything else in the inventory:**
   - `CLOSED-QUESTIONS.md` §1.7 is **not** closed while the Johnson papers are unread (plan §PA.4). A pointer line is the most it gets.
   - `BIBLIOGRAPHY.md` read-statuses (Fischer 1990's re-read; the Johnson debt).
   - The G72 killing-test proposal, left to Kooshi.
   - The plan's errata.

## Rules, each with its reason

- **The gates.** FS-81 added no Lean. Run:
  - `./scripts/build.sh`, whose up-to-date check takes about 2 seconds;
  - `scripts/axioms.sh` and `scripts/vacuity.sh`. Read their saved logs under `build/gate/`, and confirm § The gate's counts are
    unchanged, or update them;
  - `tools/check_architecture.py`, `tools/bib_audit.py` and `tools/fs71_ledger_b_check.py`.

  Anything over ~2 GiB or ~2 minutes runs under **`scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`**, the resource rule from today.
  For a Lean build, reserve and cap at the same number: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`.
  **Never run `lake build`.**
- **No SAT solver.** This close needs none, and the week after it bans them.
- **Commit after each section, by explicit path.** Before each `git add`, run `git diff -- <path>`, because another agent (an advisor)
  may be writing its own record meanwhile. Never amend. Report every hash; I check each against `git log`. Don't push; I push.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation). The reason:
  staffing is Kooshi's budget decision, and I can only review work I know about.
- **Budget: at about 450k tokens, stop at a clean boundary** with the inventory ticked, commit, and tell me. A successor continues from
  the ticks. That is a good report, not a failure. FS-73's close took two planners.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-close/`.
  Don't read other agents' directories, and don't open `~/source/lean-dir-owner/`. /tmp is RAM on this machine, so keep large files on
  disk.
- **Every report goes to me by SendMessage (to: "main"), including your final one.** Make your hand-back content-free ("close planner
  idle; reports go to the owner by SendMessage").
- **Reaching me:** SendMessage with `to: "main"`, at any time, and for any judgement call the inventory doesn't settle.

**What is yours to decide:**
- the wording of every row and entry;
- how many ledger rows;
- which findings earn a grokking and which are instances of an existing one;
- the derivation file's organisation;
- the stubs' ranks.

Push back on anything in the inventory you think is wrong.
