*The FS-79 modeling-pass brief (WORKFLOW step 6) as sent on 2026-09-23 by the product owner. It carries no agent ids.*

Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to run **the modeling passes (WORKFLOW step 6) for milestone FS-79, the invariant question at four colours**, on a plan another de Bruijn wrote and I have accepted. I'm the product owner: Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics. You are deliberately a fresh reader. Part of the value of this stage is that someone who did not write the plan reads it with the rigor of the modeling skills before two competitors are briefed from it.

## Read first, from disk

`/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. **Read them from disk.** Any copy in your context is a snapshot from the start of my session, and the disk copy is authoritative. Then:
- **`plans/FS79-invariant-question.md` in full.** This is the plan: §0, §G (the re-grokking), §PA (the prior-art gate), §IQ (the invariant question, WORKFLOW 3.3), §S (the phases), §K, §P (predictions), §M (which passes apply), §C (the text of the competition briefs), §X (the exchange with the plan-phase advisor).
- `plans/STUB-invariant-question-four-colours.md`: the stub it came from.
- `CLAUDE.md` G72 (the method), G71 (the three-colour theorem and its four-colour no-go), G51, G60, G66.
- `plans/FS73-derivation.md`: T21–T30, T34–T38 and T40–T45 are the material the plan leans on most.
- `plans/PROTOCOL-competitor-and-advisor.md` §1, §3, §4, §5: the competition that §C feeds.
- `plans/FS79-close-inventory.md`: read only. Items 26–32 are my review of the plan.

## Where things stand

The plan is accepted at commit `aebd48f7` (my review), with two findings routed to you and one slot filled by my ruling. Phase 0, a measurement over ℚ(√167), is running in parallel under a separate implementer; its results fill one slot of §C later ([P0-SURVIVORS]). Please leave that slot open and don't read phase 0's results into §C: the competition's question is written from §IQ, not from the measurement. After you, two fresh competitors and a fresh advisor are briefed from §C.

## Your job, in order

**First, the owner's review items (commit them before the passes):**

1. **Record the acceptance** in the plan: a short "§R-review" section after §X, carrying: the plan accepted at `aebd48f7`; the blind-control score (inventory item 32); rulings R1 (FS-79 may take the density question; inventory item 17) and R2 (the ranking; item 31); and findings 1–2 with how you resolved them.
2. **Finding 1: "Kind 0" conflates two things** (inventory item 29).
   - **The plan's claim.** §IQ item 3, §C.2's (Q-obs) success test ("a certificate that is not a density certificate"), §C.2's "things worth knowing" item 6 and P-B′'s example ("every kind-0 invariant is controlled by χ_f") all treat invariant means of cylinder events as controlled by the fractional chromatic number.
   - **My argument that this is true only for one-point (colour-class) densities.** Take shift-invariant measures on the colouring space, projected to windows of length `max D + 1`. In rank 1 they are exact: a stationary measure on the window-state graph exists iff a cycle does. So they refute `G(ℤ,{1,3,7,12,17,22})` at four colours, where `χ_f ≤ 29/8`. That is the plan's own "the rank-1 transfer matrix is already a certificate".
   - **Why it matters.** As written, the plan would steer competitors away from G72's third move: averaging over the symmetry and certifying on the group, which is how the three-colour slope arose.
   - **What to do.** Don't take my word for it: check the argument, and tell me if it is wrong. If it holds, split the kind (one-point densities; window-pattern frequencies at window `w`), and restate the (Q-obs) success test **by size** (a certificate that does not grow with the smallest refuting subgraph), not by kind. Then fix §C.2 item 6 and P-B′ to match. How the three-colour `Θ₃` relates to the window kind is a fair question to *pose* in §IQ or §C. Answering it is the competitors' job.
3. **Finding 2** (inventory item 30): §0 item 5 says route (ii) "is how five was reached over K". But χ(K²) = 4, and over K rigidity gives five only in wall-broken extensions of K (G55: the 8/3 pair chains where `1/2 ∈ ℤ[U]`). Reword.
4. **Fill [RANKING]** in §C.2 and §IQ item 2 by ruling R2: (Q-obs) first, (Q-rig) second, (Q) third (existence plus inheritance, as restated at `61495ca1`).

**Then the passes**, per WORKFLOW step 6 and the plan's §M. Each is a **fresh Skill-tool invocation** scoped to FS-79, never worked from memory or from skill text already in your context, and each is committed before the next.

- **`debruijn-domain-modeling`, always.** Drive the plan's objects to their true shape. Things I'd like it to settle or at least state:
  - **"An invariant carried by every four-colouring", formally**: a shift-equivariant map out of the colouring space, a continuous cocycle, a measure functional? A no-go of a named kind (P-B′) is a statement only once "kind" is a definition.
  - **The class `𝒞_r`**: `S` need not generate `Λ` (T42), so a rank-1 graph sits inside every rank. Is "rank" the rank of `Λ` or of `⟨S⟩`, and what does each choice do to "a result that reaches ℚ(√167) must hold in rank 4, triangle-free"?
  - **The "size" in (Q-obs)'s success test**: what quantity, measured how, compared against what.
  - **Whether §K's "no Lean at the plan stage" should stand.** The plan chose it with medium confidence and invited the pass to overturn it.
- **`debruijn-obligation-modeling`**, if the domain pass leaves anything a competitor must prove. Run it on the **acceptance criteria**, not on the proofs: for each face, the obligations a claimed answer must discharge. For example, for (Q-obs): every colouring carries the invariant; the admissible set is computable from `S`; emptiness on a named inhabitant; a size bound. Competitors are then scored against obligations stated in advance.
- **`debruijn-experience-modeling`** only if the domain pass decides a Lean statement is written (§M's rule), or if you judge that §C is the milestone's consumer surface. It is what two fresh minds will act on. If so, say why.

**Hand back** when §C is paste-ready: every slot filled except [P0-SURVIVORS], and the advisor's slots in §C.3. Stop before any competition launches.

## What is not yours

- **Please don't attempt the invariant or any face's answer.** Sharpening the questions, the classes and the acceptance criteria is exactly your job. Answering is the competitors'. Both must start from the same point, and a head start would turn the competition into a check of one answer. If the passes show a face is already answered (a theorem, a two-line argument, a counterexample like the one the advisor's late card found), say so plainly. That is a finding.
- **The owner's held items.** I hold candidate invariants of my own for the competition's advisor, outside the repository. Please don't look for them or open `~/source/lean-dir-owner/`, so the plan's framing stays independent of mine. The plan-phase advisor's record lives in its own scratch directory and is private until the competition ends. §X summarises what you need from it.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about. If the work outgrows your context, stop at a clean boundary (after a committed pass), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: about 300k tokens** (the plan's §S.4). Past about 500k, Kooshi's rule is that I replace rather than reuse an agent.
- **The plan file is yours to edit for this stage.** The planner has stood down; you are the plan's only writer until you hand back. Record every change's reason, and never delete a superseded decision silently: mark it and give the reason.
- **One heavy job at a time** across the machine. Any `./scripts/build.sh` run, or anything over ~2 minutes or ~8 GB, takes the lock `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`. Phase 0's implementer holds it at times; wait rather than work around it. **Never run `lake build`, bare or named**; use `./scripts/build.sh`. A named target silently queues every stale dependency into an uncapped pool, and that has taken the desktop down.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours; phase 0 is committing under `tools/` and `data/fs79/` at the same time. Never push, never amend, and end commit messages with the attribution lines your harness supplies. Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited: `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees; `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`; `data/fs73/coxeter-c3/certcheck.py`.
- **Kill by pid or process group and verify by effect.** On any unexplained crash, halt and tell me.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-modeling/`. Please don't list or read the other agents' directories beside it.
- **The close inventory is mine to write.** Send me anything the close must not lose (a result, a correction owed, an error of anyone's, mine included) and I'll log it the same turn.
- Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`; propose such edits in your report.
- To reach me: SendMessage with `to: "main"`.

## What I'll check at hand-back

1. §R-review present; findings 1–2 resolved, or argued against with reasons; [RANKING] filled.
2. Each pass a fresh Skill invocation, each committed separately, with its changes recorded in the plan.
3. The domain pass's definitions: "invariant of a kind", the class and its rank parameter, the size measure.
4. The obligation pass's per-face acceptance criteria, written so a competitor's claim can be scored against them.
5. §C paste-ready except [P0-SURVIVORS]; §C.3 filled.
6. Your report: commits (exact hashes), approximate token usage, what you delegated (the answer should be nothing), anything you think I or the planner got wrong.

Thank you. A fresh, rigorous read is exactly what this plan needs before two minds are set loose on it.
