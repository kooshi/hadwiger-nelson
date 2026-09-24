*The FS-79 stage-A planner brief as sent on 2026-09-23 by the product owner, with the advisor's agent id replaced by `POROS_ID`. The plan-phase advisor's brief is committed after the competition (close inventory, items 4 and 12).*

Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to open milestone **FS-79, the invariant question at four colours**, as its planner. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than contribute to the mathematics, so the mathematics of the plan is yours. I'll score it by artifact when you hand it back.

## Read first, from disk

`/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. **Read them from disk.** Any copy loaded into your context is a snapshot from the start of my session, and today I added G72 to `CLAUDE.md`, and step 3.3 plus the close-inventory rule (step 5) to `WORKFLOW.md`. The disk copy is authoritative. Then:
- `plans/STUB-invariant-question-four-colours.md`: the milestone, in full. It has a §IQ draft for you to rewrite, the registered outcomes (a), (b) and (c), the design, and provisional bearings.
- `CLAUDE.md` **G72** (the method; this is its first planned instance), **G71** (the three-colour theorem and why it stops at four), **G51** (the competitor-and-advisor design).
- `plans/SESSION-HANDOFF-2026-09-23-fs79-open.md` §2: the four-stage shape (plan, phase 0, competition, close), with FS-73's budget anchors.
- `plans/FS73-rigidity-dichotomy.md` **§R-close**: what the last plan got right and missed. Two misses matter here: the prior-art gate found the heights and did not carry them into the competition brief; and a periodic search measured its period cap.
- `plans/PROTOCOL-competitor-and-advisor.md` §1 and §3: the competition's rules as they stand.
- `plans/FS79-close-inventory.md`: read only (see "Standing rules").

## The milestone, and why it matters

FS-73 proved χ(ℚ(√167)²) ≥ 4, and the proof came from a question about something else. "Does every colouring of a lattice graph look like a periodic one?" was asked of every lattice at once, with the arithmetic removed and search forbidden. Answering it needed an invariant every three-colouring carries, the height, and its slope made existence a finite polytope question (`Θ₃`). Two direct attacks aimed at ℚ(√167) had stalled. G72 is the abstraction: *pose a question that cannot be answered without an invariant every solution carries.*

FS-79 reruns that reframing, not the tool, one colour up.
- **The target** is five colours over ℚ(√167). The local–global conjecture predicts at least six there, against a proven four.
- **The obstacle:** the lattices that could need five are high-rank, and their refuting patches are priced near 10⁷–10⁸ points (G65, G69). Only a certificate at the level of the symmetry scales to them.
- **The structural question** is posed at four colours for Cayley graphs of finitely generated torsion-free abelian groups. G71 says the one-dimensional invariant, a height, does not exist there. Kooshi's certificate question (does a two-sided certificate scheme exist?) is equivalent to decidability (FS73-T29).

The bearing on χ ≥ 6 is in the stub: medium-high on the programme, speculative, and a no-go is still a finding.

## Your job in this stage: WORKFLOW steps 3, 4 and 5

**3.1: the re-grokking (§G)**, with `CLAUDE.md` and `LEDGER.md` open, per `WORKFLOW.md` 3.1. Walk in full:
- every grokking G1–G72;
- every `LEDGER.md` row 1–79's mechanism;
- every `[method]` rule in `CLAUDE.md` § Grokkings and § Building;
- every theorem of `plans/FS73-derivation.md` (T1–T45), individually, because it is the nearest material.

`LEDGER.md` § B (the theorems proved outside the kernel) may be walked **by milestone block**: one verdict per block with its reason, plus an individual verdict for each line that bears. That is a scoping decision of mine, made because FS-73's planner ran to about 580k tokens. WORKFLOW 3.1 names grokkings, rows and method rules, not § B lines. If you find a block where the short form hides something, walk it line by line and tell me.

Each entry gets one line and one of three verdicts, each with its reason:
- **bears:** what it says about FS-79's object, question or instruments, and which phase it changes;
- **silent:** why;
- **falsifiable here:** register it as a prediction.

Then write every *bears* into the phase table as an instruction, where the implementer or competitor acts on it. The test of the re-grokking is that it changes the plan. If it changes nothing, say so explicitly; that is a claim I will push on.

**3.2: the prior-art gate (§PA)**, in the recognition's words, per `WORKFLOW.md` 3.2's eight questions.
- Name the object in the vocabulary of the discipline it belongs to, and search that, under at least two disciplines. This project's coined words appear in no paper.
- The handoff §2 lists the disciplines I'd start from. Extend or replace them by your own naming.
- Use the zbMATH Open API (`curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=…' --data-urlencode 'results_per_page=100'`). Record each query and its hit count, and whether a hit's text is a reviewer's review or an author's summary.
- Grep the held Polymath16 threads (`~/source/library/notes/polymath16-threads-1-18-text.txt`) for the milestone's objects, per G49's new rule.
- Anything found goes into `BIBLIOGRAPHY.md` the same day, with its read status per section. An abstract is not a reading.
- **Carry what the gate teaches about the object into §IQ and §C.** FS-73's gate found heights and left them out of its competition brief, and both competitors re-derived them.

**3.3: the invariant question (§IQ)**, all five items of `WORKFLOW.md` 3.3, rewriting the stub's draft:
1. the existence form;
2. the structural form: about every four-colouring, not one; in the most general class where it still makes sense; with the arithmetic stripped;
3. the invariant it forces, or "none known";
4. its derivation-only route;
5. the open instances it would decide.

I score §IQ with §G. A structural form that is the existence form reworded has not done 3.3. If you think the stub's structural form is the wrong one, replace it and say why. That is exactly your job.

**4: the subplan**, at `plans/FS79-invariant-question.md` (you are its only writer): the routes and phases, each aimed by §G, §PA and §IQ.
- Every phase names its budget, stop rule, checkpoint path, resume command, what a kill redoes, and an acceptance checklist (what · verified how · pass condition).
- Register the outcome predictions: (a), (b) and (c) of the stub or your replacements, with probabilities. Confirm each is reachable, the uninformative outcome included.
- Say which modeling passes (WORKFLOW step 6) apply. This is a derivation milestone and may add no Lean at all. If it states anything in Lean, write the skeleton (signatures and full statements, `sorry` at every leaf) and elaborate it with `./scripts/build.sh`, with a `#eval` or `example` per definition and a named inhabitant for every structure-typed hypothesis. Never run `lake build`, bare or named: a named target silently queues every stale dependency into an uncapped pool, and that has taken the desktop down.
- Every phase record carries a heading "Theorems this phase proved". The milestone's theorems are filed in `plans/FS79-derivation.md` and `LEDGER.md` § B at the close.

**5: commit** the plan (and any skeleton) by explicit path. Then **stop and hand back to me before the modeling passes (step 6).** I score §G, §PA and §IQ line by line before they run, and a fresh agent will run the passes (FS-73's lesson: the plan and the passes together overran one agent's budget).

## Phase 0: design it, and send me its spec early

Phase 0 is a measurement that runs while you finish the plan, if the three-agent cap allows:
- a periodic four-colour screen of the ℚ(√167) lattices, by rank;
- plus implementer C's residue-set rule from FS-73's phase P2b, re-run at four colours;
- output: which lattices *could* need five colours. That fills §IQ item 5 and feeds FS-59.

FS-73's tools and data are in `tools/fs73_*.py` and `data/fs73/`, with the records in `data/fs73/records/` (P2b: `phase-P2b-q167.md`); the frozen ones are listed below. **As soon as §G's bearings on phase 0 are written, send me phase 0's spec** as a message: the lattices, the screens, the periods, the controls, the budget, the stop rule, the checkpoint, the acceptance, and what the result is and is not allowed to claim. I'll brief an implementer from it while you carry on. Put the same spec in the plan.

**Phase 0 must not shape the competition's question.** Write §C from §IQ, not from phase 0's results.

## The competition phase: design it, don't run it

The structural question will be run under the protocol: two fresh competitors (de Bruijn and Coxeter), briefed identically, with isolated scratch directories, and a fresh Poros advising both, retractions counted. Your plan contains that phase with a section **§C** holding the text for both competitors' briefs: the protocol §4 template's slots filled (the mathematics they stand on, with addresses; the challenge stated precisely, with its known positive, de Grey's lattice with `F = 8Λ`, and what outcome (b) would look like; the things worth knowing, including what §PA found), plus the advisor's slots from §5.

**Please don't attempt the invariant yourself.** Stating the question as sharply as your reframe allows, including any reduction that makes it a better-posed question, is exactly your job, and I want it. Answering it is the competitors' job. Both must start from the same point, and a planner's head start would turn the competition into a check of one answer. If the reframe or the gate shows the question is already answered (a theorem in some literature, a known undecidability, a two-line argument), say so plainly. That re-aims the milestone, and it is a finding, not a spoiler.

**The owner's held items.** I hold two candidate invariants of my own for the competition-phase advisor. They live outside the repository on purpose. Please don't look for them or open `~/source/lean-dir-owner/`. The reason: the plan's own framing should be independent of mine, and the held items reach the competitors only after each has written its own first route.

## Poros, your advisor for this stage

A Poros advisor is already running, reading the record and writing its own expectation before it talks to you. Its agent id is `POROS_ID`. Message it with SendMessage, `to` set to that id. Its replies arrive wrapped as `<agent-message from="…">` at your next tool call; your plain-text output never reaches it. Please send it your §G draft, §PA, §IQ and phase table as each takes shape, and ask it what you might have marked *silent* that bears. Its advice is advice: you decide, and you record any disagreement with its reason in the plan. **Unlike FS-73, Poros's record stays in its own scratch directory and you do not commit it.** I move it into `plans/` after the competition, because the competitors will read `plans/`.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know about. The last time a planner delegated, three agents ran that nobody had budgeted or could review. If the work outgrows your context, stop at a clean boundary (for instance with §G, §PA and §IQ committed and the phases not yet written), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: aim to hand back by about 450k tokens.** Past about 500k, error rates rise, and Kooshi's rule is that I replace rather than reuse an agent. Keep the plan file current enough that a successor could resume from the repository alone.
- **One heavy job at a time**, across all agents on the machine: any `./scripts/build.sh` run, and any solver, search or numerical job expected to run over ~2 minutes or use over ~8 GB. Take the shared lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <command>`. For a long run, use `setsid` and write the pgid to a file. The reason: the desktop has no headroom for two, and concurrent builds have taken it down.
- **Commits by explicit path.** Before `git add` on any file another agent might touch, run `git diff -- <path>` and confirm every hunk is yours. Never push, never amend, and end commit messages with the attribution lines your harness supplies. Report each commit's exact hash; I check every hash against `git log` (two agents last milestone reported hashes that did not exist).
- **Runs over ~15 minutes checkpoint and resume exactly** (the PROTECTED paragraph in `CLAUDE.md` § Building). Kill by pid or pgid and verify by effect, never by a pattern that can match your own shell. On any unexplained crash, halt and tell me.
- **Frozen tools**, never edited: `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees; `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`; `data/fs73/coxeter-c3/certcheck.py`.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-plan/`. Please don't list or read the other agents' directories beside it.
- **The close inventory** (`plans/FS79-close-inventory.md`, WORKFLOW step 5) is mine to write. When something comes up that the close must not lose (a result, a correction owed, a prior-art debt, an error of anyone's, including mine, a stub to mint), send it to me and I'll log it the same turn. Please don't edit the file.
- Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`. Propose such edits in your report; they happen at the close. `BIBLIOGRAPHY.md` entries are the exception (the bibliography rule: same day).
- To reach me: SendMessage with `to: "main"`.

## What I'll check at hand-back (the acceptance, up front)

1. **§G:** every grokking, row, method rule and FS73 theorem has a verdict with a reason; § B by block, with bearing lines individually; every *bears* appears as an instruction in the phase table; predictions registered with both outcomes reachable.
2. **§PA:** the eight questions answered; the queries with hit counts; the held Polymath16 threads grepped; bibliography entries added with honest read status; what it taught about the object carried into §IQ and §C.
3. **§IQ:** all five items; a structural form that is genuinely about every solution, in the most general class that makes sense; the invariant named or "none known"; the open-instance list.
4. **The plan:** every phase with budget, stop rule, checkpoint and resume command, what a kill redoes, and an acceptance checklist; phase 0's spec (sent to me early); the competition phase with §C ready to paste into two identical briefs and the advisor's slots; the sequencing under the three-agent cap; which modeling passes apply.
5. **Your report:** the commits (exact hashes), approximate token usage, what you delegated (the answer should be nothing), each disagreement with Poros and how it was resolved, and anything you think I've framed wrongly. If you see a better shape for the milestone than the one this brief assumes, say so; you'll be closer to the material than I am.

Thank you, and good hunting.
