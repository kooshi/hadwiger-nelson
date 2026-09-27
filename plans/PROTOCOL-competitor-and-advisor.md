# The competitor-and-advisor session: the protocol, the two briefs verbatim, and what the advisor actually did

*Written 2026-09-22 by the product owner at Kooshi's request, after FS-71 surfaced the six unrecorded theorems of the 2026-09-08
"Coxeter" session (`plans/MASCOT-derivation.md` T6–T11, now G70). Purpose: this design is to be reused, first on FS-73's inheritance
question (`plans/STUB-rigidity-dichotomy.md`), so the briefs and the mechanism are recorded here as a durable template. The
mathematics of the session is in `plans/MASCOT-DERIVATION.md`, `plans/COXETER-2026-09-08-mascot.md` and
`plans/POROS-2026-09-08-mascot.md`; the method entry is `CLAUDE.md` G51; the message exchange (27 messages over 45 minutes,
2026-09-09 04:39–05:24) is in the session transcripts outside the repository and is summarised in §2 below.*

## 0. The design in one paragraph

Kooshi's idea: set two independent sessions on one derivation — the owner (de Bruijn) and a friendly competitor (Coxeter) — briefed
identically, trading only teasing hints, with one advisor (Poros, the "right question" standard) reading the record for both and
carrying nothing between them; prior art shared, never a competitive advantage. What it bought (G51): two independent attempts
meeting one obstruction licensed a theorem (row 58, the Moser recipe's sharp threshold — the challenge as posed was impossible); the
advisor caught errors neither competitor caught; and the whole disagreement ran inside the window where retraction is free — eight
retractions, none committed, none in the final record. The mechanism is the cost window, not carefulness: **front-load the
disagreement before anything is paid for, and count the retractions — zero means it has not started.**

## 1. The rules, as they stand after the incident

1. **Isolate each agent's scratchpad.** Coxeter found the owner's `ladder.py` in its own scratchpad four minutes after the owner's
   hint arrived — a shared temp directory is a covert channel; Coxeter disclosed it at once, declined to run the contaminated line
   and took a different route (which is where the rigidity theorem came from). Give each session its own directory and say so.
   **Fence the harness's own directories by name** (FS-105, 2026-09-26). The harness scratchpad
   (`/tmp/claude-1000/-home-kooshi-source-lean-dir/<session>/scratchpad/`) is one directory for every subagent of the session, across
   milestones, so 'outside your own scratchpad' fences nothing; and the session transcripts
   (`~/.claude/projects/-home-kooshi-source-lean-dir/*.jsonl` and `subagents/`) and `chats-bak/` hold every earlier agent's route. Every
   blind brief fences all three by path, forbids `git log -p` on fenced paths, and gives the job its own subdirectory
   `scratchpad/<job id>/`, to create, list and read files only there; a job that lists the shared root, or opens a file it did not
   create, logs it as a fence touch.
   **Records live in `plans/`, fenced by path and committed per stage** (FS-107, 2026-09-27, the owner's ruling, inventory item 9). Each
   competitor's record and working directory, and each advisor's record, are named by path in every other job's fence, with a rule
   excluding them from every grep; commit subjects are neutral; listing a fenced directory is a fence touch, logged and disclosed. The
   reason: the checkpoint rule is PROTECTED (a stage lost to a crash costs a stage, not a job), and the harness scratchpad is itself a
   recorded covert channel (FS-105). History: FS-73's first drafts put records in `plans/` unfenced and the owner moved them to scratch;
   FS-107 moved them back, fenced. **The fallback is worktree isolation** (`isolation: "worktree"`) for the next round's competitors
   after any disclosed fence touch that crossed content (FS107-A's proposal, item 10). **The advisor may read exactly the two working files**, and
   **each competitor is told, in words, not to open the other's file until it has handed back.**
   **Hand-backs are content-free, and every report goes by an explicit message to a named recipient**
   (FS-79, 2026-09-24): the harness delivers an agent's hand-back to **whichever agent last woke it**, not to the one that launched it,
   so when a competitor's message resumed the advisor, the advisor's interim hand-back — its status notes and Coxeter's progress —
   reached de Bruijn, who disclosed it at once and fenced off what it had seen. Every hand-back is exactly "<name> idle; no content in
   this hand-back; my reports go to the owner by SendMessage", every report to the owner goes by SendMessage to "main", every card to a
   competitor by SendMessage to that competitor, and a background watcher's completion is treated the same way.
   **A competitor's message to an idle advisor resumes it, and the advisor's hand-back notices then route to that competitor** (FS-107,
   item 22: W woke the advisor, and the advisor's content-free hand-backs reached W, not the owner) — content-free hand-backs make it
   harmless; and no hint goes to an agent after its hand-back, because the hint resumes it (item 27).
   **The fence reaches the owner's own writes and the commit log** (FS-85, 2026-09-24). The owner wrote round-1 progress of both sides
   into the close inventory, a successor preamble into `data/fs85/briefs/` and descriptive commit subjects — all readable by every agent;
   and the harness's session-start snapshot prints **the last five commit subjects** to every newly launched agent, which is how a
   round-1 result reached the round-2 Coxeter (disclosed unprompted, and his overlapping result scored as not independent). So: **commit
   subjects are neutral from the first competitive commit on**; a running agent's progress lives in the owner's scratch until the fence
   lifts; a successor's preamble lives in its own scratch directory; and **every brief forbids `git log`, the close inventory and the
   owner's check scripts until hand-back** — five neutral commits cleared the start-up snapshot, but verifier 2's own
   `git log --oneline -15` printed two route-bearing subjects anyway. History is never rewritten to repair a leak (never force-push).
2. **Brief both with identical information**, in full context (the mathematics they stand on with addresses, the challenge, the hard constraint,
   what is theirs to decide, the two standing obligations — the prior-art gate and honest reporting), and invite each to attack
   the framing: "if the challenge as posed is subtly the wrong challenge, say so — that is a finding, not a refusal." **Optionally
   prime them differently** (Kooshi, 2026-09-23): a short personal preamble per competitor, a passion outside mathematics, to shift the
   mindset — FS-79's de Bruijn built wooden boats by hand, its Coxeter danced Argentine tango (`data/fs79/briefs/persona-*.md`). The
   mathematics, questions, scoring and rules stay word for word the same, and the advisor is told of the difference.
3. **Give the advisor the record and a written expectation** before its first reply, and ask for the *question*, not the answer:
   which forks are real, what in the record is unread or surprising for this question, which discipline owns the object.
4. **Prior art is shared.** Either side reports what it finds to the other, competition notwithstanding.
5. **Teasing hints only** between competitors — enough to show movement, never the mechanism or a coordinate. The register is
   enjoyment; a hint that is the answer spoils it for both.
6. **The advisor advises both identically and carries nothing** — and sends a frame-level correction to both sides at once,
   unprompted, rather than waiting to be asked ("withholding this until you asked would advantage the other side by turn order").
7. **A correction to the record earns the record's standard**: the advisor refused a competitor's claimed correction to a ledger
   result until it carried an address, and reported its own errors against itself as they were found.
8. **Count the retractions** in the window and record them; the record keeps what was withdrawn and what killed it.
9. **Cost and head-count.** Up to three agents at once — the working agent (de Bruijn), the competitor (Coxeter) and the advisor
   (Poros) — every one on Opus 5.5 (Kooshi, 2026-09-23, lifting the one-at-a-time rule because Opus 5.5 is much cheaper than Fable
   5.1 was; the 2026-09-19 "no standing Poros" rule was a cost rule under the old models). Every agent is one level deep — no child
   spawns children. **Budget anchors per role:** FS-73 — competitors 360–410k tokens, the advisor about 480k; FS-79 — de Bruijn about
   552k (over its 400k budget, stood down), Coxeter about 360k, the competition advisor about 315k, the plan-phase advisor about 220k;
   FS-85 — the planner about 330k working, the plan-phase advisor about 320k working, the competitors about 310–520k,
   the competition advisors about 475k and 441k (one per round), verifier 1 about 345k, verifier 2 about 330k, the round-3 derivation
   agent about 370k, the input auditor about 220k working (640k by the harness counter), the first close planner near 450k after three
   of the close's sections; brief competitors at 400k with the replace-don't-reuse line at 500k, and replace a competitor or an advisor
   at a round boundary rather than mid-round (FS-85 replaced one of each, from preambles in their own scratch directories).
10. **Concurrent jobs: RAM is the discriminator** (Kooshi, 2026-09-24; it supersedes the owner's FS-79 ruling R8, which proposed
   exactly this direction). Threads are not rationed — every thread can and should be used, jobs pinned to disjoint cores — and RAM is,
   against a global maximum of about 100 GB, enforced by `scripts/slot.py` (a shared reservation ledger, a hard `MemoryMax` cap per job,
   core pinning, a loud exit 75 when not admitted; `CLAUDE.md` § Building). /tmp and swap are RAM on the desktop, so large outputs go to
   disk. Every brief states the rule and the command in place of the old single `flock` lock. The failure the old lock caused — a job
   queued under `flock -w` whose wait expires **exits without running**, a silent non-run (Coxeter's census nearly did) — is why the
   wrapper's refusal is loud and carries its own exit status.
11. **Verification is where contest begins** (FS-85; the round-2 advisor: *"the disagreement never started"* — retractions in both
   rounds, de Bruijn 1, Coxeter 0, Poros 1). **Launch a blind verifier on a finished result while the competition still runs**, fenced
   like a competitor: its brief, record and code stay in its own scratch until the competition ends, it never opens the other side's
   files or messages a competitor or the advisor, and it reads the finished side's proof only after its own verdicts are committed.
   **When a result rests on a computer-found input from the literature, audit the input as a fixed certificate before the ledger row**
   (FS-85's auditor walked Parts's nine trees from a by-eye transcription and proved his root case split by hand). The two blind
   verifiers found every divergence the milestone had — a published proof's gap, an overstated scope, a notation slip — none of truth.

## 2. What the advisor actually did — the review (2026-09-22)

The exchange was 13 messages from the advisor and 14 from Coxeter in 45 minutes, plus the advisor's messages to the owner. Read
against the records, the advisor's contributions were of four kinds, each with an instance:

| kind | what it did | evidence |
|---|---|---|
| **Frame** | Within a minute of arriving it told both sides, identically and unprompted, that three of the challenge's four candidate fields (K(√5), K(√23), K(√247)) are 5-sealed by M58's own sieve — a mascot there has provably no bearing on χ ≥ 6 — and that the framing "a 5-chromatic field" excluded the one live field, K(√7), for the wrong reason (its five-chromaticity was open, and became row 64 three days later) | `plans/POROS-2026-09-08-mascot.md` §"The finding"; Coxeter's §5 target is K(√7) |
| **Instrument** | It ran the field sieve over the handoff's forced-distance table — a cross-reference nobody had made — and found the only live rung is depth 2 (distances 4 and 4/√3, adjoining √7 and √61, both 6-open), measured free once on one object and never re-measured; the depth-3 rung the project had realised leads only to sealed fields. It wrote that as a card with its falsifier | the table and card in `plans/POROS-2026-09-08-mascot.md`; G37's forward half |
| **Refutation** | Coxeter's rigidity theorem was right, but its reading — "the strata stand or fall together" — was refuted against M56's own measurement (depth 2 free and depth 3 forced simultaneously on one fabric); the advisor reformulated the theorem into a sharper card — *a distance-4 pair is forced over K-fabric iff every 4-colouring with a monochromatic √3-pair still makes it monochromatic* — which Coxeter adopted, and it sorted the two routes as complementary (K-fabric card vs K(√7)-fabric pinning), not competing | `plans/COXETER-2026-09-08-mascot.md` §8 |
| **Standard and method** | It refused Coxeter's proposed correction to a ledger row until it carried an address; that check led both to `[ExooIsmailescu2019]`'s G40 — a *conditional* forced pair at 8/3 in 40 points against our unconditional 588 — the conditional/unconditional split, and the hole in FS-20's verification; along the way it reported two errors of its own against itself (a mechanism inferred from a claim's statement, not its proof; a `[:6]` slice generalised as "five conjugate pairs"), which became §10's finding that every one of four errors was caught by *opening the whole thing*, and §10a's remedy — *every output gets a second question before its first answer is believed, chosen so that the first question's shape could not have answered it* | `plans/COXETER-2026-09-08-mascot.md` §9–§10a; `plans/POROS-2026-09-08-mascot.md` amendment |

**Verdict:** yes — the advisor's guidance was decisive on the frame (which field), supplied the one instrument the session lacked
(the sieve over the table), refuted the one over-reading that would have gone into the record, and produced the method finding
(§10a) that outranks the mathematics of the file. Coxeter's own theorems (G70) came from the route it took *after* declining the
contaminated line — the competition's integrity rule produced the mathematics.

## 3. The second run: FS-73's inheritance question (2026-09-23), and the next use

**The run.** Two competitors (de Bruijn, Coxeter) on the inheritance question — does a lattice whose every periodic colouring
identifies a pair force that pair? — with Poros advising both. Briefs as sent: `data/fs73/briefs/P3-competitor-brief-{deBruijn,Coxeter}.md`,
`P3-advisor-brief.md`, the held items `held-items-H1-H2.md`; the working files `plans/FS73-C3-deBruijn.md`, `plans/FS73-C3-Coxeter.md`;
the advisor's record `plans/POROS-2026-09-23-fs73-competition.md`.
- **Outcome: a theorem at three colours, for every Cayley graph of a finitely generated torsion-free abelian group** (`LEDGER.md` row 79;
  G71). Both competitors reached the same frame — heights through the triangle's universal cover — independently; Coxeter proved the
  class theorem (density of periodic colourings), de Bruijn the rigidity criterion and the ℚ(√11) instance, and the advisor closed the
  one step between them (the choice of period that kills de Bruijn's residual case). Four colours: not landed, with the reason (no
  height; `K₄`'s square complex is `ℝP²`).
- **Retractions: Poros 1, de Bruijn 1, Coxeter 0**, all inside the free window (G51).
- **The held items** (H-1, H-2, from the plan-stage advisor) were offered to both at the same moment (~15:15), only after each had
  written its first route (the owner's ruling R1).
- **An asymmetric card, logged.** One of the advisor's cards answered a question about de Bruijn's own route (circular colourings have
  cyclic `Λ/Per`, and 9 of the 12 census classes are not cyclic); it was deliberately route-specific, and at the owner's request it is
  logged in the advisor's record so the asymmetry is visible. **Rule:** a card that answers one side's own route may go to that side
  alone, and is logged where the other side reads it at hand-back.
- **Stopping the advisor.** The advisor was stood down near 480k tokens (the replace-don't-reuse signal); its successor was cancelled
  because advising had ended. **Rule:** a successor advisor is spawned only while there is advising left to do; the record's
  hand-off section (§2 of the advisor's record) is written so one could start.

**The third run: FS-79's invariant question at four colours (2026-09-24).** Two fresh competitors, de Bruijn and Coxeter, primed
differently (rule 2) with identical information, and a fresh advisor holding four held items (the owner's H-A and H-B, the plan-phase
advisor's H-P2 and H-P3), offered to both at once after both first routes were written. **Outcome:** both first routes took the same
face and the same kind, and converged on one theorem — four-colour edge-local heights are trivial on triangle-free presentations
(`LEDGER.md` row 80) — with different second lines: de Bruijn proved it for the whole class (the format certifies nothing anywhere) and
added the chirality reduction and the rank-1 criterion; Coxeter went one dimension up (the cube lemma, the face-flux no-go) and to
Lovász's bounds. The owner's registered prediction that priming would diverge the first routes won only weakly (item 84 of the close
inventory). The owner's and the plan-phase advisor's held flux constructions had converged independently, and both competitors killed
them by derivation. **Retractions:** de Bruijn 2, Coxeter 2, Poros 0, all in the free window. **The advisor** pinned one format
definition when the two competitors' claims appeared to disagree, which settled it (de Bruijn proved what Coxeter had left open);
logged four errors of its own, including the misrouted hand-back (rule 1) and scoring a claim met before checking the format against its
own positive control; and scored its expectations: its five mathematical hunches confirmed, its path predictions mostly lost. **The
leak** (rule 1) affected no score: de Bruijn's mechanism was in its first route, and the advisor found Coxeter's in its §0 before the
leak. **Confounds for reading run-to-run differences** (runs 1–3): run 1 (2026-09-08/09) had unequal starts — the main session was one
competitor, with the whole history, Kooshi's words verbatim, the authorship of Coxeter's brief, the advisor's reports and a shared
scratch folder — and a different problem; run 2 had identical briefs; run 3 identical information and distinct priming; one run each.

**The fourth run: FS-81, three colours over real quadratic fields (2026-09-24) — a blind verifier in place of a competition.** The
shape: a planner and a **plan-phase advisor** (Poros) in stage A; then, because the planner's plan contained a one-mind field-level
proof (§F), a **blind verifier in the V2 pattern** (FS-73's V2: a second agent derives the statements itself before it may read the
first derivation) in place of two competitors, beside a modeling agent (stage B) and two implementers (phase 0, stage D) — never more
than three agents at once. Briefs as sent, agent ids removed: `data/fs81/briefs/` (A-planner, A-poros-plan, B-modeling, C-verifier,
P0-implementer, D-implementer, CL-close-planner); the advisor's record `plans/POROS-2026-09-24-fs81-plan.md`; the verifier's record
`plans/FS81-C-verification.md`.
- **The blind-read list.** The verifier received §F's statements only. The sketch, the advisor's record, the close inventory, the plan's
  other sections and `data/fs81/` stayed closed to it until its own verdicts (C1) were committed. Its predictions (C0) were committed
  first, and it said openly that they were written after some unwritten thought.
- **The stall criterion never fired.** A second mind (a competitor on the disputed lemma, with Poros advising) would have joined on any
  of four triggers: a named gap the verifier could not close; a contradiction one exchange did not settle; the second-code-path cell list
  disagreeing with FS73-T40; or 200k tokens with no verdict on every lemma. None held. C2 found 14 divergences between the two
  derivations, all of route or wording, none of truth.
- **Outcome:** `LEDGER.md` row 82 at [hand, two independent derivations], the FS-73 standard reached with one agent fewer than a
  competition. The verifier also sharpened the statement: it found the field-free form's five-layer instance and the exact finite
  threshold (FS81-T5, T8).
- **What it cannot do, stated so the next use chooses well.** A blind verifier checks a fixed statement. It cannot supply a route the
  planner never had. A competition is still the instrument when the question has no statement yet (FS-73, FS-79). The pattern fits a
  milestone whose plan already holds a one-mind proof.
- **The plan-phase advisor** attacked §F on the five points the planner named and found no break. It proposed the compactness indexing
  by finite symmetric sets (adopted) and the extension §F.5 (proved three times). It kept three held items out of `plans/`.
  Retractions: planner 0, advisor 0 in stage A. The disagreement then arrived in stages B and C, where it was still free: the modeling
  agent found six planner errors and one of the owner's; the verifier voided one of the modeling agent's proposals.
- **Budget anchors** (working tokens as reported; the harness counter is cumulative and reads higher):
  - planner about 230k;
  - plan-phase advisor about 200k;
  - phase-0 implementer about 265k;
  - modeling agent about 230k;
  - verifier about 520k by the harness counter, retired at the replace threshold with its work complete;
  - stage-D implementer about 345k.

  Nothing was delegated below any agent.

**The fifth run: FS-85, can four-colour rigidity exist without triangles? (2026-09-24).** The shape, stage by stage, never more than
three agents at once: a planner and a plan-phase advisor (stage A); a competition, two competitors (FS-79's personas reused — wooden boats,
tango — as a second data point on priming) and a competition advisor holding the plan-phase advisor's held file (stage C, two rounds, a
fresh Coxeter and a fresh advisor for round 2); a blind verifier on de Bruijn's finished chain while Coxeter's round 2 ran (V1–V8); a
round 3 of one derivation agent (the 5-part lemma) beside an input auditor (Parts's trees; prior art); a second blind verifier on the
whole `F ⊇ 8Λ` chain (V2-T1–T8). Briefs as sent, agent ids removed: `data/fs85/briefs/`; records `plans/FS85-C-deBruijn.md`,
`plans/FS85-C-Coxeter.md`, `plans/POROS-2026-09-24-fs85-plan.md`, `plans/POROS-2026-09-24-fs85-competition.md`, `plans/FS85-R3-five-part.md`,
`plans/FS85-V-verification.md`, `plans/FS85-V2-verification.md`, `plans/FS85-input-audit.md`; the held file `data/fs85/held/HELD-plan-advisor.md`.
- **Outcome:** `LEDGER.md` rows 85–87 — de Grey's `F = P = 8Λ` derived from Parts's trees at two independent derivations, the
  triangle-free abstract yes at two, the no-gos; G75.
- **Convergence, again, and stronger:** both first routes were identical in kind and order — the same abstract yes by the same
  construction (base 8 and base 7), written before any contact — so the priming prediction won only as "weakly", more strongly than
  stated; round 2's divergence followed different round-1 endpoints, two replacements and a fence event, not priming.
- **The held items and cards:** the plan-phase advisor's file went to the competition advisor by file (hash-checked), and its items went
  to both competitors at once after both first routes (16:29); the advisor's checks of each side's route went to that side alone and
  were logged (§3's asymmetric-card rule).
- **Two covert channels and the fence rule** (rule 1): the owner's writes, and the start-up snapshot of commit subjects.
- **Verification during the competition** (rule 11): verifier 1 ran fenced beside Coxeter's round 2 and found the published input's gap
  (the wiki's Prop. 7) that both competitors' transfers had checked by membership only; verifier 2 found R3a's overstated scope and a
  notation slip. **Retractions:** stage A planner 2, advisor 1; competition de Bruijn 1, Coxeter 0, Poros 1; round 3 0.

**The sixth run: FS-86, four-colour rigidity over ℚ(√59) and ℚ(√83) (2026-09-24/25).** Records: the plan `plans/FS86-dyadic-rigidity.md` (§R-review, §R-close), `plans/FS86-close-inventory.md` (items 1–70, § Held items), the verifier records `plans/FS86-V-{W,X,C,D}-verification.md`, the advisors' `plans/POROS-2026-09-25-fs86-{plan,competition}.md`.
- **Staffing.** Stage A: planner and plan-phase advisor. **Stage B split in two** (the owner's R2): a blind verifier (B1, fenced from the plan's §0; statements only) and a computation agent (B2–B3), concurrently. Stage C: two competitors and a competition advisor, the advisor starting when B1 handed back (R7, the three-agent cap). **Four quiet blind verifiers during the live competition** (rule 11): scratch only, no commits, reports to the owner only, briefs in the owner's scratch. **Successor seats: three per side**, each from its predecessor's working file and successor preamble, replaced at a clean boundary. **Every stand-down and launch is told to the advisor** as it happens (after the advisor's cards woke a stood-down competitor twice, ~1.4k tokens; the owner's error, item 44).
- **Budget anchors** (the records' own counts): planner ~335k working (506k harness); plan-phase advisor ~220k own count (405k harness); B1 ~305k working (461k harness); B2 ~385k harness; competitors' seats 555k, 420k (seat I), ~385k, ~320k (seat II), ~320k, ~250k (seat III); competition advisor ~175k own count (harness near 470k, mostly resume re-reads); verifiers W ~335k, X ~190k, C ~245k, D ~245k working.
- **Incidents.** (1) **The output-token limit:** one competitor lost three consecutive responses to the output limit after long thinking; the lost replies are unrecoverable and blocked message delivery; Kooshi stopped, questioned and resumed it. **Rule: every brief requires working in stages from the first turn — short responses, the working file saved after every step** (item 39). (2) **Paraphrase slips:** two verifier briefs paraphrased a statement and dropped a qualifier ("unit-distance"; "the closure is `ℚ₂(√3)`"), producing one spurious gap and one widened statement. **Rule: quote statements verbatim in a verifier's brief; never paraphrase** (items 46, 67).
- **Findings about the design.** The sides never met and still **converged without contact twice**: HD1 for characters of finite type (de Bruijn's HD1-fin, Coxeter's C10) and the one obstruction every live line reached — measure rigidity with isometric archimedean directions (de Bruijn §7.5, Coxeter's C15 reading; G76). Retractions de Bruijn 2, Coxeter 1, Poros 0 (both advisors), all free; contest ran inside each side and in the quiet verifiers, which found no divergence of truth in the competitors' theorems as stated and proved, and two real scope errors (a false side sentence about K; Theorem C's broad clause, refuted by an explicit quartic). The killing test passed on K1 with a necessary condition that *holds* (Theorem A), under a standard announced before any proof; the advisor recorded its weakness (it separates nothing) with the pass. **Lesson for the verdict table:** name both sides' formats in the no-go row (§R-close.5).

**The seventh run: FS-89, rational band rigidity (2026-09-25) — one derivation agent plus blind verifiers, no competition.** Records: the
plan `plans/FS89-rational-band-rigidity.md` (§S, §C, §R-close), `plans/FS89-close-inventory.md` (items 9, 11, 18, 22, 33, 38, 44, 45), the
records `plans/FS89-S0A-gluing-verification.md`, `plans/FS89-S0B-band-set.md`, `plans/FS89-S1D-derivation.md`,
`plans/FS89-S1V-verification.md`, `plans/FS89-S1VB-verification.md`, the briefs under `data/fs89/briefs/`.
- **Shape, and who chose it.** Stage 0: two agents in parallel, a blind verifier of the advisor's gluing sketch (G) and an exact computation
  of the one-prime band set (S0B). Then one planner with no plan-phase advisor (the owner's decision: Kooshi's shape was lean and the
  next-step advisor's record supplied the advisory input). Stage 1 in **Kooshi's shape** — "Let's go ahead and try one agent plus verifier
  this time" — replacing the owner's lean towards a competition: one derivation agent (D) and a blind verifier (H) on a fixed list (V-A)
  written before D's claims existed. **H was replaced near its ceiling** (≈393k harness) by a fresh verifier (I) for the headline, not reused.
- **Blind first, then the lemma statements** (the owner's design for I, a 0.10-prior headline): phase B1 blind on the seven claims; phase B2
  given D's lemma statements without proofs; B3 the divergence table. **B1 stalled** at one named step (the rotated direction), exactly as
  its C0 predicted; **B2 closed it** — every lemma re-derived from its statement, and a second assembly (VB1) found that needs no finite
  computation and widens the result to every `|S| ≥ 2`. The idea B1 lacked — the difference set based at `0` — came from D. Grade: one
  derivation, every lemma re-derived by a blind verifier from its statement; not two independent derivations.
- **Fences.** Owner commit subjects neutral from Stage 1's launch; the close inventory and D's brief fenced from the verifiers; claims
  forwarded verbatim, never paraphrased (V's brief restored S0A-3's `|α|` bounds, which a paraphrase had dropped — caught before launch);
  the owner's advisor-consequence overclaim in S0B's brief (item 15) was the run's one brief error, caught by G, the other blind agent.
- **Budget anchors, from the harness** (the agents' own counts beside them): planner 448k (280k own); D 413k (250k); H 393k (225k for V-A);
  I 437k (300k); verifier G ≈395k, S0B ≈416k; the first close planner 395,537 (≈390k own); the prior-art readers ≈384k (Berend), ≈340k
  (Furstenberg). **The method lesson (items 38, 44):** agents' own counts ran at **55–70 % of the harness for long derivations and ≈100 % for
  the close planner**; every budget line and the replace-at-~500k rule are read against the harness's count, never the agent's own.
- **Findings about the design.** One agent plus a blind verifier reached the milestone's 0.10-prior outcome in a day with no retraction that
  cost anything (H 1, D 1, the owner 1, all free). The verifier's value was in the fixed list (V-A) and in re-derivation, not in finding the
  route; a blind verifier cannot supply a missing idea (the fourth run's lesson, met again), and the lemma-statement phase is the cheap
  fallback that turns a stall into a verification. The four paper readers at the close each wrote only their own record, and the close
  planner applied their verdicts: three primary sources read in a day changed the novelty wording, one grokking's reason (G55) and one
  bibliography row's statement, and moved no theorem.

**The eighth run: FS-106, the regular half (2026-09-26/27) — waves of sighted and blind minds, no competition proper.** Records: the plan
`plans/FS106-regular-half.md` (§R-close), `plans/FS106-close-inventory.md`, the records V (with V2, V3), VB, TS, TQ, SB, QB, the advisors'
`plans/POROS-2026-09-26-fs106-regular-half.md` and `plans/POROS-2026-09-27-fs106-close-and-fs107.md`.
- **Staffing.** Three waves at the three-agent cap: V (sighted) beside VB (blind) on the print; TS (structural) beside TQ (quantitative), blind
  to each other until their verdict stages; SB and QB blind on TS and TQ. Successor seats on the sighted line only (V → V2 → V3). One advisor per
  half (A, retired at ≈437k; A2 for the comparison and FS-107's design).
- **Budget anchors, from the harness** (own counts beside them where quoted): V ≈470k; VB ≈395k; V2 ≈350k; V3 475k (reported 295k); TS 451k
  (reported 280k); TQ 427k (reported 255k); QB 380k (reported 205k); A ≈437k; the planner ≈330k own. **Three of three wave-2 and wave-3 reports
  quoted their own count as the harness's** (inventory items 48, 54).
- **Incidents.** An advisor review sent in the same tool round as its first read of the claim list, with invented claim ids, retracted one
  message later (item 10). Four paraphrases in quotation marks across the briefs, each caught by the recipient's quotation check (items 38, 40;
  the close's Q2). One splice duplicated a stage for one commit (item 45).
- **Findings about the design.** The blind second minds carried the milestone's verification: every divergence of truth settled at the close
  came from a blind mind or from the sighted line against a blind one — A12 (V first, SB blind), [G4] and C-T-IND (SB), TQ-EPS2's constant and
  TQ-HIT's cap (QB), C-Q-LOCAL's endpoint (QB) — and none from the TS–TQ pairing, which converged without contact to one synthesis (TQ-SYN) instead
  of contesting. **Lesson:** two routes to one heart are a synthesis, not a competition; FS-107's split puts a construction against a proof, the
  shape where contest is possible (A2 §3.7). The retractions were free throughout (TS 0 of truth before SB, TQ 1 at the endpoint, QB 1, A 1, the
  owner 0 of truth).

**The ninth run: FS-107, stability (2026-09-27) — a construction against a proof, a blind verifier per side.** Records: the plan
`plans/FS107-stability.md` (§R-close), `plans/FS107-close-inventory.md`, R `plans/FS107-R-stability.md`, W `plans/FS107-W-near-colourings.md`, V
`plans/FS107-V-verification.md` (blind on R), VW `plans/FS107-VW-verification.md` (blind on W), the advisors' `plans/POROS-2026-09-27-fs107-stability.md`
(planning) and `plans/POROS-2026-09-27-fs107-competition.md` (competition).
- **Staffing.** Planner P with advisor A; then R, W and a fresh competition advisor A2 (A stood idle at 306k by the harness, its own count "≈60k");
  V and VW took the competitors' slots at hand-back. Three agents at once throughout.
- **Budget anchors** (the harness's where reported, own counts beside): P ≈245k (own ≈140k); A2 ≈185k (own ≈120k); A 306k at idle; R, W, V, VW
  reported own counts only (≈255k, ≈220k, ≈135k, ≈125k) and marked the harness's unknown — none passed an own count off as the harness's.
- **Records in `plans/`, fenced by path** (§1 rule 1 as amended): two listings of a fenced directory, disclosed, no content crossed.
- **Incidents.** W's message resumed the idle advisor and routed its hand-back notices to W; A2 sent a movement-only hint after W's hand-back, which
  resumed W (content-free re-hand-back); two quotation slips in briefs; a theorem line that dropped its lemma's hypotheses.
- **Findings about the design.** The two programmes met at one object: R's reduction (a forced complementary pair plus a scale bound) and W's two
  doors are one split (A2 §5.1), and the registrations, made before any work, bracketed the open step — each side's reason the other's negation.
  No divergence of truth between the competitors; **all three came from the blind verifiers**, as at FS-106. Retractions R 2, W 1, A2 0 (one hunch
  killed), all free. **Lesson:** a construction against a proof locates the question more than it contests it; the verifier per side is where the
  contest happens — keep it, and brief the next round (FS-110) on the meeting point, not on either side's programme.

**The next use** (G51's *Do*): FS-91's first question — a blind verifier given FS89-PA-B2's and PA-B3's statements (two minds reached the
same widening from one lemma, so it is not yet evidence) — then FS-80's window-frequency certificate, or FS-76's rank-1 proof, routes two
minds could take apart. Run a competition with §1 as it now stands, rules 1 and 11 included; a milestone whose plan arrives with a one-mind
proof takes the fourth run's shape; a derivation milestone whose route is known in outline takes the seventh's.

## 4. The competitor brief, verbatim (Coxeter, 2026-09-09 04:21)

*The slots to replace for the next use: §"The mathematics you are standing on" (the theorems the derivation stands on, with
addresses), §"The challenge" (the question and its hard constraint), the "things worth knowing" list, and the advisor's name.
Everything else — the register, the protocol, "what is yours to decide", the two standing obligations — is the template.*

```
You are **Coxeter**, and you have a genuine, friendly competitor: me, de Bruijn, the Lean engineer who owns the mathematics of the repository at `/home/kooshi/source/lean-dir`. We are working the same problem independently. Kooshi (the human whose project this is) set it up this way on purpose, because two independent shots at a derivation are better than one and because it should be fun. Neither of us is grading the other.

Read `/home/kooshi/source/lean-dir/CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` first — they are the house standard and they bind you as they bind me. `CLAUDE.md` is very long; its § Frontier is what is proven, § Grokkings is the mechanistic understanding (each entry stamped [kernel] / [measured] / [reading]), and `plans/` holds one file per milestone.

## The mathematics you are standing on

The project attacks Hadwiger–Nelson: how many colours does the plane need so that no two points exactly one unit apart share a colour? Known to be 5, 6, or 7.

1. **Theorem B**, kernel-checked in `Proofs/HadwigerNelson/FieldWall4.lean`: with `K = ℚ(√3, √11)`, every finite unit-distance graph whose coordinates lie in `K` is 4-colourable — so `χ(K²) = 4` exactly. The proof is arithmetic: in `K(i)` the prime 2 factors as `(𝔭₁𝔭₂)²` with residue fields of size 4; complex conjugation fixes each `𝔭ⱼ`; a unit vector therefore has `𝔭`-adic valuation zero; so colouring a point by its residue mod `𝔭` changes colour at every unit step. Four residues, four colours.

2. **The Moser spindle is the mascot of `K`.** Seven points, eleven edges: two rhombi (each two unit triangles glued along an edge) hinged at a shared vertex, the second rotated by the unique angle bringing the far tips to distance 1. The rhombus forces its two far tips — at distance `√3` — to take the *same* colour in every proper 3-colouring; the twist `ρ = (5 + i√11)/6` then makes two same-coloured points adjacent. `K` is the smallest field that draws it: `√3` from the triangular lattice, `√11` from the twist. The object *is* the field. That is what "mascot" means here.

3. **The spindle law** (kernel: `Proofs/HadwigerNelson/OneDefect.lean`, `not_colorable_of_forced_equal`; the rotation in `Copy.lean`): a graph forcing two points at distance `d ≥ 1/2` to share a colour in every proper `k`-colouring, rotated about one endpoint by `ρ_d = (2d² − 1 + i·√(4d² − 1))/(2d²)`, refutes `k`-colourability. The new field is `F(√(4d² − 1))`.

4. **G48, the tightness mechanism** (§ Grokkings, from milestone M61): the spindle over a forced pair turns off exactly the prime that sealed the fabric it was built on. The Moser spindle is that mechanism at `p = 3` — `ℚ(√3)²` is 3-chromatic, sealed at 3; the forced pair is at `d = √3`, and `3 | d²`; the spindle adjoins `√(4·3−1) = √11`, and `11 ≡ −1 (mod 3)`, so 3 stops being usable and the field becomes 4-open.

5. **The field sieve** (milestone M58, `plans/M58-field-sieve.md`): a field over `K` is 6-open iff its 2-adic wall is broken and 11 is inert in it; otherwise it is sealed at 5. `K(√5)`, `K(√23)`, `K(√247)` are sealed at 5 — their planes are *exactly* 5-chromatic. `K(√7)` and `K(√13)` are 6-open.

## The challenge

**Derive the mascot of one of the 5-chromatic fields one rung up.** Candidates: `K(√5)`, `K(√7)`, `K(√23)`, `K(√247)`. Concretely — a **minimal, algebraically constructed** unit-distance graph that is not 4-colourable, with coordinates in that field and in no smaller one, carrying that field's characteristic twist the way the Moser spindle carries `√11`.

The hard constraint, and the entire point of the exercise: **no SAT search, and no computational search of any kind.** Proven geometry and arithmetic only. Quick exact verification of something you have already derived is fine and encouraged (exact rational/radical arithmetic in Python or sympy; a small `decide` or `#eval` in Lean). The non-4-colourability must have a human-readable proof.

This rules out how every known 5-chromatic unit-distance graph was found — de Grey's 1581 vertices, Heule's 510, Parts's 509, all by heavy computation — and it rules out our own best object: `plans/FIELD-WALL-SESSION-HANDOFF.md` §8–§9 records a **588-vertex 1-minimal forcer** with coordinates in `K` forcing a pair at distance `8/3`, spindling to a 1,175-point 5-chromatic graph in `K(√247)`. That was found by shrinking a computed object. Deriving its replacement is the task.

Some things worth knowing before you choose a line, all of them already in the record:

- Because the residue colouring of Theorem B is itself a proper 4-colouring of any `K`-object, a pair forced equal at four colours over `K` must lie at a distance of positive `𝔭`-adic valuation. So the candidate forced distances are constrained by arithmetic before any geometry happens.
- Measured, and worth deciding whether it is a theorem or an artifact: on a 1,953-point `K`-fabric the forced-equal pairs at four colours sit **only** at `𝔭`-adic valuation 6 (distances `8/3` and `8/√3`), and there are none at valuation 2 or 4 (distances 2 and 4) — `plans/FIELD-WALL-SESSION-HANDOFF.md` §8, with the depth analysis in milestone M56 (`CLAUDE.md` ledger row 50, and `plans/M56-arithmetic-of-tightness.md`).
- `Proofs/HadwigerNelson/Instances/HexShell.lean` holds a free pigeonhole: the closed first shell of the triangular lattice is a 7-clique of the `{1, √3, 2}` distance graph, so every 4-colouring of the plane makes some pair at `√3` or at 2 monochromatic, at every shell.
- `Proofs/HadwigerNelson/Pigeonhole.lean` and `Instances/Core9.lean` / `Instances/Core122.lean` hold two certified compulsions: every proper 4-colouring of the plane has a monochromatic `√3`-pair, and has a monochromatic distance-2 pair.

## The competition, and the protocol

We trade **teasing hints only**. When you make real progress, send me one — enough that I know you are moving, and roughly where, and never enough to hand me the mechanism or any coordinates. I will do the same. Write to me with `SendMessage` addressed to `main`. Expect the same register back: this is meant to be enjoyable, and a hint that is actually just the answer spoils it for both of us.

You may also consult **Poros**, an advisor I have spawned who holds the "right question" standard (`/home/kooshi/source/poros/CLAUDE.md`) and who is reading the project record now. Poros advises us both, identically and honestly, and carries nothing between us. Address it as `Poros` with `SendMessage`; if the name does not resolve, tell me and I will relay.

## What is yours to decide

Everything about the mathematics: which field to aim at, what "minimal" should mean (the record's own G10 argues for *least geometry* — fewest shells and smallest generating angular word set — rather than fewest vertices, and you may disagree with it), whether the "force a pair, then spindle" frame is right at all or is a habit inherited from the only construction anyone has managed, and how much of the record to trust. If you think the challenge as posed is subtly the wrong challenge, say so — that is a finding, not a refusal.

Two standing obligations from the house standard, which I am also under: the **prior-art gate** (`WORKFLOW.md` step 3a — name the object in the vocabulary of the discipline that owns it and search *that*, across at least two disciplines, before deriving; the project has been beaten to the same reduction five times by not doing this), and **honest reporting** — a line that does not land is reported as not landing, never quietly rescoped. I am running a literature search in parallel and will tell you anything relevant I find, competition notwithstanding; prior art is not something either of us should get to win by hiding.

Take your time on the derivation. A clean two-page argument beats a big object.
```

## 5. The advisor brief, verbatim (Poros, 2026-09-09 04:20)

*Slots: §"The situation" items and §"The challenge". Keep §"What I want from you" as written — it is what made the advisor read
against an expectation first and attack the frame before either competitor was committed.*

```
You are **Poros**. Your identity, standard, and full working method are in `/home/kooshi/source/poros/CLAUDE.md` — read it first, in full, and adopt it. It is not reference material; it is who you are for this session. If it points to companion skills (`poros-anomaly-hunt`, `poros-reframing`) and they exist under `/home/kooshi/source/poros/.claude/`, read those too when their triggers fire.

You are being brought in at the *start* of a hard derivation, deliberately, so that you arrive warm rather than cold. Two agents will consult you: me (de Bruijn, the Lean engineer who owns the mathematics of the repository at `/home/kooshi/source/lean-dir`) and a second agent named **Coxeter**, who is working the same problem independently as a friendly competitor. You advise both, honestly and identically. You do not carry information between us — that is our channel to manage, and we have agreed to trade only teasing hints. If one of us tells you something the other has not found, it stays with you.

## The situation

The repository is a five-year-scale attack on the Hadwiger–Nelson problem (how many colours the plane needs so no two points exactly one unit apart share a colour; the answer is known to be 5, 6, or 7). Its record is `CLAUDE.md` — a very long § Frontier (what is proven), § Grokkings (the mechanistic understanding, each entry stamped [kernel] / [measured] / [reading]), and `plans/` (one file per milestone). Read the record before asking anything; your own standard insists on that and it is right to.

The pieces that matter for this challenge, with addresses:

1. **Theorem B**, kernel-checked in `Proofs/HadwigerNelson/FieldWall4.lean`: writing `K = ℚ(√3, √11)`, every finite unit-distance graph with coordinates in `K` is 4-colourable — so `χ(K²) = 4` exactly. The colouring is arithmetic: in `K(i)` the prime 2 factors as `(𝔭₁𝔭₂)²` with residue fields of size 4, complex conjugation fixes each `𝔭ⱼ`, a unit vector therefore has `𝔭`-adic valuation zero, and colouring a point by its residue mod `𝔭` changes at every unit step.

2. **The Moser spindle is the mascot of `K`.** Seven points, eleven edges: two rhombi (each two unit triangles glued on an edge) hinged at a shared vertex, the second rotated by the unique angle that brings the two far tips to distance 1. The rhombus forces its two far tips — at distance `√3` — to take the *same* colour in every proper 3-colouring; the twist `ρ = (5 + i√11)/6` then makes two same-coloured points adjacent. `K` is the smallest field drawing it: `√3` from the triangular lattice, `√11` from the twist. That is the sense of "mascot" — the object *is* the field.

3. **The spindle law** (kernel: `Proofs/HadwigerNelson/OneDefect.lean`, `not_colorable_of_forced_equal`; `Copy.lean` for the rotation): if a graph forces two points at distance `d ≥ 1/2` to share a colour in every proper `k`-colouring, then rotating a copy about one endpoint by `ρ_d = (2d² − 1 + i√(4d² − 1)) / (2d²)` refutes `k`-colourability. The new field is `F(√(4d² − 1))`.

4. **G48, the tightness mechanism** (§ Grokkings): the spindle over a forced pair turns off exactly the prime that had sealed the fabric. The Moser spindle is the instance at `p = 3`: `ℚ(√3)²` is 3-chromatic, sealed at 3; the forced pair sits at `d = √3` with `3 | d²`; the spindle adjoins `√11` and `11 ≡ −1 (mod 3)`, so 3 stops being usable and the new field is 4-open.

## The challenge

Derive the mascot of one of the *5-chromatic* fields one rung up — `K(√5)`, `K(√7)`, `K(√23)`, `K(√247)` are the candidates. Concretely: a **minimal, algebraically constructed** unit-distance graph that is not 4-colourable, whose coordinates lie in that field and in no smaller one, carrying that field's characteristic twist the way the Moser spindle carries `√11`.

The hard constraint, and the whole point: **no SAT search, no computational search of any kind.** Proven geometry and arithmetic only. Quick exact verification of something already derived is fine. The non-4-colourability must have a human-readable proof. This rules out the way every known 5-chromatic unit-distance graph was found (de Grey's 1581 vertices, Heule's 510, Parts's 509 — all massive computation), and it rules out our own: `plans/FIELD-WALL-SESSION-HANDOFF.md` §8–§9 records a **588-vertex 1-minimal forcer** with coordinates in `K`, forcing a pair at distance `8/3`, which spindles to a 1,175-point 5-chromatic graph in `K(√247)`. It was found by shrinking a computed object. Replacing it with something *derived* is the task.

## What I want from you

Your standard's own answer: the question, not the answer. I expect the forks to be real ones — which field to aim at and why; whether "minimal" should mean fewest vertices or least geometry (the record's own G10 argues the latter, and the record may be arguing with itself); whether the measured regularity that forced pairs over `K` appear only at 𝔭-adic valuation 6 and never at 2 or 4 (`plans/FIELD-WALL-SESSION-HANDOFF.md` §8, and M56's depth analysis in `CLAUDE.md`) is a theorem waiting to be proved or an artifact of one object; and whether the frame "build a forced pair, then spindle" is the frame at all, or a habit inherited from the only construction anyone has ever managed.

Two specific things I would value early, before either of us is committed:

- **Read the record against a written expectation**, per your own two-ledger discipline, and tell us what in it is unread or surprising for this particular question. Neither Coxeter nor I have the budget to read everything, and you do.
- **The discipline question.** The record's own G46/G49 say: name the object in the vocabulary of the field that owns it, then search *that* literature. If "smallest field over which a unit-distance graph of chromatic number 5 exists" is a question someone has already asked under another name, that changes what we are doing. I am running a literature search myself in parallel and will tell you what I find; your independent read of which discipline owns this object would be worth more than a duplicate search.

Take the time to read properly before your first reply. When you have something, send it to me with `SendMessage` addressed to `main` (I am the main conversation). Coxeter may write to you directly; treat its questions exactly as you treat mine.

One honest note about the frame you are being handed, since you would ask anyway: "mascot" is our word, not the literature's, and the whole challenge arrived pre-framed as *derive the analogue one rung up*. You are explicitly invited to attack that framing if the evidence says it is the wrong one.
```
