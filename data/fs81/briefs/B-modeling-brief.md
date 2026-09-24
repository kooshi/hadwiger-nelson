Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to run **the modeling passes (WORKFLOW step 6) for milestone FS-81, four colours over real quadratic fields**. The plan was written by another de Bruijn, and I have accepted it. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics. You are deliberately a fresh reader: part of the value of this stage is that someone who did not write the plan reads it with the rigor of the modeling skills.

## Read first, from disk

1. `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Read them from disk; any copy in your context is a snapshot, and the disk copy is authoritative.
2. **`plans/FS81-quadratic-four-colours.md` in full.** This is the plan. Its sections:
   - §0: the milestone after the reframe;
   - §G: the re-grokking;
   - §PA: the prior-art gate;
   - §IQ: the invariant question;
   - §F: the finding, a candidate proof of T4;
   - §S: the phases;
   - §P: the predictions;
   - §M: which passes apply;
   - §X: the exchange with the advisor;
   - **§R-review: my acceptance and three binding corrections.**
3. `plans/FS81-F-sketch.md`, the planner's proofs of §F. You may read it; the stage-C verifier may not, for now.
4. `plans/STUB-quadratic-four-colour-classification.md`, the stub the plan came from.
5. `plans/POROS-2026-09-24-fs81-plan.md`, the plan-phase advisor's record.
6. `plans/FS81-close-inventory.md`, read only. Items 22–37 are the milestone so far.
7. The nearest material:
   - `CLAUDE.md` G21, G54, G55, G61, G65, G71, G73;
   - `plans/FS73-derivation.md` T6, T21–T22, T40–T42;
   - `plans/FS79-derivation.md` T4–T7, T13, T38–T49;
   - `data/fs79/records/phase-P0.md` (the four-colour screen at ℚ(√167) that stage D re-runs at ℚ(√47)).

## Where things stand

- **Stage A** (the plan) is accepted at commit `872046a1`.
- **Phase 0** (exact `Θ₃` certificates over the 25 open fields) is running under an implementer, from §S.P0's spec.
- **Stage C**, a blind, independent verification of §F, is starting now under a separate verifier. It reads only §0, §IQ items 1–2 and §F of the plan.
- **Stage D** (ℚ(√47) at four colours) comes after phase 0 releases the heavy lock. **It is the part of the plan your passes shape most.**
- **Stage E** is the close.

## Your job, in order

**First, apply my two review corrections to the plan body** (§R-review items 1–2). Mark each edit "(owner's review, §R-review item N)":
1. §G.1's G54 line: at ℚ(√47)'s primes 11 and 19 the tight/slack sign at four colours is slack (−0.796, −0.943), not refusing; 23, 31 and 43 refuse by the ratio bound. Correct the line, and anything in §S.D that leaned on it.
2. §S.D's refusing controls are abelian Cayley graphs, not unit-distance graphs. `Cay(Λ_dG, U ∪ {±v})` adds a generator of length (4/9)√12, and FS79-T5 and T7 are K₄-free Cayley graphs of ℤ and ℤ². Say so in §S.D, and correct §X's card-5 disposition to "answered for abelian Cayley graphs; no rank-4 unit-distance lattice graph is known to refuse four colours".

Commit these before the passes.

**Then the passes**, per WORKFLOW step 6 and the plan's §M: domain → obligation → experience (light). Each is a **fresh Skill-tool invocation** scoped to FS-81, never worked from memory or from skill text already in your context, and each is committed before the next. What I'd like each to settle, or at least state:

- **`debruijn-domain-modeling`** (always):
  - **Stage D's measurement, as an object.** What exactly is "the four-colour band"?
    - Which quantity is plotted against which: average degree, ball size, the fraction undecided at a wall, time to refusal.
    - On which population of graphs.
    - **What licenses carrying it from abelian Cayley graphs with a non-unit generator to unit-distance lattices over ℚ(√47)?** Correction 2 makes that a [reading]; say what would make it more than one, or what population would be the right control if one exists (for instance, a rank-4 unit-distance lattice graph over a field where four colours are refused by theorem).
    - Apply G65's lesson that a degree law does not see a word ball's ceiling.
  - **The phase-0 configurations as objects** (listed units versus keys; T41's `z` is not unique, inventory item 37). Is the configuration a set of unit vectors, a lattice, or a Cayley graph? Which one does a certificate's verdict speak about?
  - **The field-level object of §F** (`R_F`, `Θ₃(F)`, the layers). **Do not change the statements L1–L4 or F-T4, or §0 or §IQ items 1–2**: stage C is verifying them as written, and it reads those sections. If the domain pass finds a better statement, send it to me as a proposal; I apply it only after stage C's C1 verdicts are committed.
  - **Whether §M's "no Lean skeleton at this stage" should stand.** The plan invites the pass to revisit it.
- **`debruijn-obligation-modeling`:** run it on **acceptance criteria**, not on the proofs.
  - For stage D: the obligations a claimed price must discharge (its units, its population, its control, its wall) and those a claimed refusal at ℚ(√47) must discharge.
  - For stage C's C4, the finite-witness family: what a claimed K(d) bound must show.
  - Don't prove L1–L4; that is stage C's job.
- **`debruijn-experience-modeling`** (light): the certificate and checker surfaces that later stages and a reviewer consume, meaning the listed-unit certificates, the `--no-enumerate` flag and its output lines (`tools/fs81_theta_check.py`), and phase 0's per-field table. Is each verdict line read the way it will be read by someone who trusts none of this?

**Phase 0 is running from its spec, so don't edit §S.P0.** Send me any change a pass finds for phase 0 as a proposal, and I'll route it to the implementer.

**Hand back** when the three passes are committed, with stage D's section ready for an implementer to be briefed from.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary (after a committed pass), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: about 250k tokens.** FS-79's modeling agent used about 255k. Past about 500k, Kooshi's rule is that I replace rather than reuse an agent.
- **The plan file is yours to edit for this stage, except §0, §IQ items 1–2, §F and §S.P0.** Record every change's reason, and never delete a superseded decision silently: mark it and give the reason.
- **One heavy job at a time** across the machine. Any `./scripts/build.sh` run, or anything over ~2 minutes or ~8 GB, takes the lock `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`.
  - Check the exit status, because an expired wait runs nothing.
  - Phase 0 holds the lock at times; wait rather than work around it.
  - **Never run `lake build`, bare or named**; use `./scripts/build.sh`.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours. Phase 0 and the verifier commit concurrently, and the verifier writes `plans/FS81-C-verification.md`.
  - Never amend, and end commit messages with the attribution lines your harness supplies.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.
- **Kill by pid or process group and verify by effect.** On any unexplained crash, halt and tell me.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-modeling/`. Please don't list or read the other agents' directories beside it, or `~/source/lean-dir-owner/`.
- **The close inventory is mine to write.** Send me anything the close must not lose, and I'll log it the same turn.
- Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`; propose such edits in your report.
- **To reach me:** SendMessage with `to: "main"`. Your turn's final text is delivered to whichever agent last woke you, so keep it content-free ("modeling agent idle; report sent to the owner by SendMessage") and send the report itself by SendMessage.

## What I'll check at hand-back (the acceptance, up front)

1. The two review corrections applied and marked.
2. Each pass a fresh Skill invocation, each committed separately, with its changes recorded in the plan.
3. The domain pass: stage D's band defined (quantity, population, the transfer's grade); the configuration object; §M's Lean decision re-examined; any proposed restatement of §F sent to me, not applied.
4. The obligation pass: acceptance obligations for stage D's price and refusal, and for C4's K(d) claim.
5. The experience pass: the verdict lines and the per-field table read as an untrusting reviewer would.
6. §S.D ready to brief from.
7. Your report: the commits (exact hashes), approximate token usage, what you delegated (the answer should be nothing), and anything you think I or the planner got wrong.

Thank you. A fresh, rigorous read is exactly what this plan needs before stage D spends compute.
