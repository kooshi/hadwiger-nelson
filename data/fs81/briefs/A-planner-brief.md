Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to open milestone **FS-81, four colours over real quadratic fields**, as its planner. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than contribute to the mathematics, so the mathematics of the plan is yours. I'll score it by artifact when you hand it back.

## Read first, from disk

1. **The house standard:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. **Read them from disk.** Any copy loaded into your context is a snapshot from the start of my session, and this morning I rewrote four passages of `CLAUDE.md` (commit c65c78da):
   - the conjecture's exposed predictions in § The mission;
   - Frontier item 10;
   - G48's falsifier line;
   - FS-59's row.

   The disk copy is authoritative.
2. **The milestone:** `plans/STUB-quadratic-four-colour-classification.md`, in full. It carries:
   - the mission;
   - the list of the 25 open fields;
   - a §IQ draft for you to rewrite;
   - the registered outcomes (a), (b), (c);
   - the shape;
   - what was owed at the opening, of which items 2–6 are now done;
   - the provisional bearings.
3. **Why it was chosen:** `plans/POROS-2026-09-24-next-direction.md` §5. This is an advisor's recommendation, which Kooshi accepted; its record also holds cards and hunches you may find useful.
4. **The stage design and the rules in force:** `plans/SESSION-HANDOFF-2026-09-24-fs81-open.md` §1–§3, with FS-79's budget anchors and nine lessons for the owner.
5. **What the last plan got right and missed:** `plans/FS79-invariant-question.md` §R-close. Three misses matter here:
   - G72's *Do* not applied the day a new exact tool landed;
   - a one-period census read as rigidity;
   - a price quoted from a three-colour law at four colours.
6. **The nearest mathematics:**
   - `CLAUDE.md` G61, G71, G72, G73, G62, G7, G65;
   - `plans/FS73-derivation.md` T21–T22 and **T38–T45**. T40–T41 are the milestone's centre: `L21cc6506`'s product structure and the 36-vector half-page obstruction;
   - `CLOSED-QUESTIONS.md` §1.7;
   - `data/fs61/census.md`;
   - `LEDGER.md` rows 72–74 and 78–81.
7. **The design, if you plan a competition:** `plans/PROTOCOL-competitor-and-advisor.md` §1.
8. **`plans/FS81-close-inventory.md`:** read only (see "Standing rules").

## The milestone, and why it matters

T4, the census conjecture (G61), says every squarefree d ≡ 11 (mod 12) has χ(ℚ(√d)²) ≥ 4. These are the only real quadratic fields that can need four colours (`[Fischer1990]` Thms 8–9).
- **Where it stands.** It is proved field by field: 15 of the 40 fields below 500, the 15th being ℚ(√167) by FS-73's exact `Θ₃` certificate (row 79). **25 are open.**
- **The instrument.** FS-73's criterion decides three-colourability of a lattice graph exactly (G71: three-colourable iff `Θ₃` is nonempty), with certificates of kilobytes where refuting balls were priced near 10⁸ points. It has been pointed at one field. G72's *Do* says to point a new exact procedure at the open-instance list the day it lands; this milestone is that act, a day late.
- **The family.** FS73-T41 proves ℚ(√167) with 36 vectors and four inequality cases. Its twists look general:
  - G7's type-M rotation `(83 + i√167)/84` at n = (d+1)/4, which every ℚ(√d) with d ≡ 3 (mod 4) carries;
  - `(1+i)(15 − i√167)/28`, from 15² + 167 = 2·14².

  ℚ(√47) has the same shape (5² + 47 = 2·6²) and is certified, so it is a ready control. If T41 generalises, T4 holds for an infinite family. That would be the first proof of the conjecture's four-colour clause for an infinite class of fields without √3, and an answer to questions posed in print (`CLOSED-QUESTIONS.md` §1.7: Moorhouse 2010 by name for ℚ(√47); Benda–Perles Open Problem 11.6; `[Fischer1990]`'s request for an algebraic criterion).
- **The last phase** measures what FS-59 needs: the cost of refusing four colours on a rank-4 lattice, at ℚ(√47). There the conjecture predicts **exactly five** against a proven four.
- **Bearing on χ ≥ 6:** none directly. High on the programme, and possibly the publication trigger. The stub says so honestly.

## Your job in this stage: WORKFLOW steps 3, 4 and 5

**3.1: the re-grokking (§G)**, with `CLAUDE.md` and `LEDGER.md` open, per `WORKFLOW.md` 3.1. Walk in full:
- every grokking G1–G73;
- every `LEDGER.md` row 1–81's mechanism;
- every `[method]` rule in `CLAUDE.md` § Grokkings and § Building;
- every theorem of `plans/FS73-derivation.md` (T1–T45), individually, because it is the nearest material.

Walk `LEDGER.md` § B, `plans/FS79-derivation.md`, `plans/FS61-derivation.md` and `plans/FS58-derivation.md` **by block**: one verdict per block with its reason, plus an individual verdict for each line that bears. This is a scoping decision of mine, for budget; WORKFLOW 3.1 names grokkings, rows and method rules. If a block's short form hides something, walk it line by line and tell me.

Each entry gets one line and one of three verdicts, each with its reason:
- **bears:** what it says about FS-81's object, question or instruments, and which phase it changes;
- **silent:** why;
- **falsifiable here:** register it as a prediction. G61's "no witness transfers between fields" and "no route to T4" are the obvious candidates.

Write every *bears* into the phase table as an instruction, where the implementer acts on it. The test is that the re-grokking changes the plan; if it changes nothing, say so explicitly, and I will push on it.

**3.2: the prior-art gate (§PA)**, in the recognition's words, per `WORKFLOW.md` 3.2's eight questions. Two things are specific to this milestone.
- **`[Johnson2000]` and `[Johnson2006]` are the likeliest prior art and are not held.** They are Geombinatorics surveys of colouring algebraic extensions of ℚ²; `BIBLIOGRAPHY.md` § R has their identifiers and routes.
  - Try every *discovery* route an agent can take: the zbMATH API for their reviews and for everything else by `au:"Johnson, Peter D."` on the subject, any online copy, citing works that quote them, and Soifer's book chapter held in the library.
  - **Contacting anyone (the author, the editor, a library) is Kooshi's call, never an agent's.** If the papers cannot be read, record the debt in §PA, say exactly what a T4 claim may and may not say while they are unread, and propose the request to me for Kooshi.
- **"Circular coloring the plane"**, SIAM J. Discrete Math. 21 (2007) 461–465, is missing from `BIBLIOGRAPHY.md` (inventory item 11). Every `Θ_k` point is a circular colouring, so find it, read what you can, and add the entry with its honest read status.

The rest is standard:
- Name the object in its home disciplines' words and search under at least two of them, since this project's coined words appear in no paper.
- Search for the question, not only the method.
- Use the zbMATH Open API: `curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=…' --data-urlencode 'results_per_page=100'`. Record each query with its hit count, and whether a hit's text is a reviewer's review or an author's summary.
- Grep the held Polymath16 threads (`~/source/library/notes/polymath16-threads-1-18-text.txt`) per G49.
- Anything found goes into `BIBLIOGRAPHY.md` the same day, with its read status per section. An abstract is not a reading.

**3.3: the invariant question (§IQ)**, all five items, rewriting the stub's draft. This milestone differs from FS-79 in one way you should think about rather than accept. The invariant is known (the height and its slope, G71), so the structural question is a *classification of `Θ₃` over a family*, not a search for an invariant. If you think WORKFLOW 3.3 is degenerate here, or that the structural form should be something else, replace it and say why. I score §IQ with §G, and a structural form that is the existence form reworded has not done 3.3.

**4: the subplan**, at `plans/FS81-quadratic-four-colours.md` (you are its only writer): the routes and phases, each aimed by §G, §PA and §IQ. The stage shape in the handoff §2 is a starting point, not a constraint.
- Every phase names its budget, stop rule, checkpoint path, resume command, what a kill redoes, and an acceptance checklist (what · verified how · pass condition).
- Register the outcome predictions: (a), (b) and (c), or your replacements, with probabilities. Confirm each is reachable, the uninformative outcome included.
- **Stage C, the family derivation.** Design it for one derivation agent, with its brief's content ready, and write the **stall criterion** that would turn it into a competition (G51).
  - You may do the cheap arithmetic that aims it: which d in the family carry the twists T41 uses, and what congruences those twists need. That is parameter setting, and it shapes the phases.
  - **Please don't prove T41 with the twist as a parameter yourself.** Stating that question as sharply as your reframe allows is exactly your job. Answering it is stage C's, and if stage C becomes a competition, both competitors must start from the same point.
  - If the reframe shows the family is already settled (in a paper, or by a two-line argument), say so plainly. That re-aims the milestone; it is a finding.
- **Stage D, the ℚ(√47) price.** G65's degree law is a three-colour law. FS-79 quoted three-colour-law prices at four colours and the owner's report dropped the caveat. Plan how the four-colour threshold is measured, with refusing controls, before any ball is aimed.
- **Modeling passes.** Say which apply (WORKFLOW step 6). If anything is stated in Lean, write the skeleton (signatures and full statements, `sorry` at every leaf) and elaborate it with `./scripts/build.sh`, with a `#eval` or `example` per definition and a named inhabitant for every structure-typed hypothesis. **Never run `lake build`, bare or named**: a named target silently queues every stale dependency into an uncapped pool, and that has taken the desktop down.
- Every phase record carries a heading "Theorems this phase proved". The milestone's theorems are filed in `plans/FS81-derivation.md` and `LEDGER.md` § B at the close.

**5: commit** the plan (and any skeleton) by explicit path. Then **stop and hand back to me before the modeling passes (step 6).** I score §G, §PA and §IQ line by line before they run, and a fresh agent runs the passes.

## Phase 0: design it, and send me its spec early

Phase 0 is the `Θ₃` runs. It can start while you finish the plan, because the tools exist:
- `tools/fs73_theta_lib.py`, `tools/fs73_theta_cert.py`, `tools/fs73_theta_struct.py` (E's tree and structural certificate);
- `tools/fs73v2_*.py` (V2's relation tree and the rational pattern's cells);
- `tools/fs79_p0.py`, `tools/fs79_p3b_theta4.py` (FS-79's chain sweep and exact finder, generalisable to any M and d);
- FS-61's census lattices under `data/fs61/`.

**As soon as §G's bearings on phase 0 are written, send me its spec as a message.** The spec covers:
- which lattices of which fields (the census's open lattices; the saturated chain `Λ_M`; T41-shaped sub-configurations);
- the order of work (cheapest decisive first);
- the frozen checkers every certificate goes through;
- the controls:
  - positive: ℚ(√167)'s 36-vector certificate; ℚ(√47);
  - negative: three-colourable fields such as ℚ(√3), ℚ(√7), where every lattice must have a `Θ₃` point;
  - the known-positive calibration of any finder at the question's scale;
- the budget, the stop rule, the checkpoint and resume command;
- the acceptance;
- what a result may and may not claim.

**A nonempty `Θ₃` on a lattice at a depth is a typed null for the field, not a three-colouring of its plane.** I'll brief an implementer from the spec while you carry on; put the same spec in the plan.

## Poros, your advisor for this stage

A Poros advisor is already running, reading the record and writing its own expectation before it talks to you. Its agent id is `POROS_ID`.
- Message it with SendMessage, `to` set to that id. Its replies arrive wrapped as `<agent-message from="…">` at your next tool call; your plain-text output never reaches it.
- Please send it your §G draft, §PA, §IQ and phase table as each takes shape, and ask it what you might have marked *silent* that bears.
- Its advice is advice: you decide, and you record any disagreement with its reason in the plan.
- Its record stays in its own scratch directory; I move it into `plans/` at hand-back.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about. The last time a planner delegated, three agents ran that nobody had budgeted or could review.
  - If the work outgrows your context, stop at a clean boundary (for instance with §G, §PA and §IQ committed and the phases not yet written), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: aim to hand back by about 400k tokens.** FS-79's planner used about 230k. Past about 500k, error rates rise, and Kooshi's rule is that I replace rather than reuse an agent. Keep the plan file current enough that a successor could resume from the repository alone.
- **One heavy job at a time**, across all agents on the machine. That covers any `./scripts/build.sh` run, and any solver, search or numerical job expected to run over ~2 minutes or use over ~8 GB.
  - Take the shared lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <command>`.
  - A `flock -w` whose wait expires exits **without running the command**, a silent non-run, so check the exit status.
  - For a long run, use `setsid` and write the pgid to a file.
  - The reason: the desktop has no headroom for two, and concurrent builds have taken it down.
- **Commits by explicit path.** Before `git add` on any file another agent might touch, run `git diff -- <path>` and confirm every hunk is yours.
  - Never amend, and end commit messages with the attribution lines your harness supplies.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Runs over ~15 minutes checkpoint and resume exactly** (the PROTECTED paragraph in `CLAUDE.md` § Building). Kill by pid or pgid and verify by effect, never by a pattern that can match your own shell. On any unexplained crash, halt and tell me.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other `tools/fs73_*`, `tools/fs79_p0*` and `tools/fs79_p3*` file as read-only: import it, or copy it under a new `tools/fs81_*` name.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-plan/`. Please don't list or read the other agents' directories beside it.
- **The close inventory** (`plans/FS81-close-inventory.md`, WORKFLOW step 5) is mine to write. When something comes up that the close must not lose, send it to me and I'll log it the same turn: a result, a correction owed, a prior-art debt, a stale claim, an error of anyone's (mine included), a stub to mint. Please don't edit the file.
- Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`. Propose such edits in your report; they happen at the close. `BIBLIOGRAPHY.md` entries are the exception (the bibliography rule: same day).
- **State every result at its exact scope and grade** (FS-79's close). A finder's null is not an emptiness. One solver's unchecked UNSAT is not "provably". A no-go for one format is not a kind ruled out.
- **To reach me:** SendMessage with `to: "main"`. Your turn's final text is delivered to whichever agent last woke you, which may be Poros. So keep your hand-back text content-free ("planner idle; report sent to the owner by SendMessage") and send the report itself by SendMessage.

## What I'll check at hand-back (the acceptance, up front)

1. **§G:** every grokking, row, method rule and FS73 theorem has a verdict with a reason; the § B and derivation files by block, with bearing lines individually; every *bears* appears as an instruction in the phase table; predictions registered with both outcomes reachable.
2. **§PA:** the eight questions answered; the queries with hit counts; the Johnson papers read or their debt recorded with what a claim may say meanwhile; the SIAM paper entered; the Polymath16 threads grepped; bibliography entries with honest read status; what the gate taught about the object carried into §IQ and the phases.
3. **§IQ:** all five items, or a reasoned replacement; a structural form genuinely about every solution; the open-instance list.
4. **The plan:** every phase with budget, stop rule, checkpoint and resume command, what a kill redoes, and an acceptance checklist; phase 0's spec (sent to me early); stage C's brief content and stall criterion; stage D's four-colour price plan; the sequencing under the three-agent cap; which modeling passes apply.
5. **Your report:** the commits (exact hashes), approximate token usage, what you delegated (the answer should be nothing), each disagreement with Poros and how it was resolved, and anything you think I've framed wrongly. If you see a better shape for the milestone than the one this brief assumes, say so; you'll be closer to the material than I am.

Thank you, and good hunting.
