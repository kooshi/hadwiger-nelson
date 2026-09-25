# Brief — the FS-73 close, second planner (successor)

You are **de Bruijn**, continuing FS-73's close (WORKFLOW step 9) in `/home/kooshi/source/lean-dir` as the **second close planner**.
The first close planner handed over at its token budget after sections 1–4. I'm the product owner, the coordinating session.
Kooshi's acceptance test for this close is his sentence: *"I don't want to lose anything from before. There's a lot to save."*

**Read, in order, before anything else:**
1. `…/scratchpad/fs73-close/BRIEF.md`: the first planner's brief. It is yours too, unchanged except where this file says otherwise.
2. `plans/FS73-close-inventory.md`: the checklist. Its **"Close status" block** at the top lists what is done, with commits, and
   **the successor's work in order**. Start from item 1 of that list.
3. `WORKFLOW.md` step 9 and step 3.1, and `CLAUDE.md`, from disk. Any loaded copy predates this session's edits.

**What changed since the first brief:**
- **R9 is final and verified: χ(ℚ(√167)²) ≥ 4.** Row 79 records it. Every source is final and readable, including
  `data/fs73/records/phase-P3b-q167-theta.md`, `verify-P3b-q167.md`, `data/fs73/verify-v2/`, `tools/fs73_theta_*` and
  `tools/fs73v2_*`.
- **No other agent is running,** so the heavy-job lock is free. Still take it for anything over ~2 minutes or ~8 GB.
- **Kooshi agreed** that the push happens at the end of the close, once R9 is recorded. It is mine to do, not yours.

**Your remaining work, from the status block:**
1. The three dangling files that committed text already points to:
   - `plans/STUB-algebraic-explanation.md`: Kooshi's milestone. The ℚ(√11) half is now derived; the K half is open.
   - `plans/STUB-three-colour-criterion-kernel.md`: the route for R9 into the kernel, meaning a box-LP certificate checker plus the
     criterion's ⟹ lemma.
   - `data/fs73/table/CORRECTIONS.md`.
2. The §G re-read, the §PA sweep and the forward propagation of G71 into the stubs, written as a closing §R of the plan. The first
   planner's notes include one real miss: `L21cc6506`'s unit vectors are five rotated copies of the rational pattern, which G62/G7
   predicted and nobody used.
3. Sections 5–9 of the inventory:
   - the plan and record fixes, and the retraction tally (V2's one included);
   - process and the protocol document;
   - prior art (including whether χ(ℚ(√167)²) ≥ 4 is already in print, using the zbMATH API as in WORKFLOW 3.2 item 8);
   - the new stubs, the FS-59 rewrite, the `plans/FRONTIER-STUBS.md` re-rank, and `CLAUDE.md` § Paths forward (it still names FS-73
     as next, and its FS-59 row still says "nothing above three proven");
   - last, the fact audit and the size check.
4. **Then write the closing commit's summary as a message to me.** It must say what is done, and what is declined with the reason.
   It must also give the recommendation for the next milestone, with its default.

**Budget:** about 400k tokens. At about 400k, stop at a clean boundary with the ticks current, commit, and tell me.

**The rules are unchanged:**
- commit by explicit path after each section; never push, never amend; check every hash against `git log`;
- no subagents, because delegation here is one level deep and staffing is Kooshi's call;
- never run `lake build`;
- reach me with `SendMessage`, `to: "main"`.
