## Workflow 3.0 — the pipeline

The project runs as a pipeline of minds with separate crafts, joined only by files: **Poros asks the question, Ephodos derives
the answer, and de Bruijn formalizes it**. The three run at once and apart. Poros scouts ahead, Ephodos blazes the trail, and
de Bruijn paves behind them. **Keryx**, the top-level session, coordinates and does not contribute. Each role's own loop lives in
its identity (a skill in `.claude/skills/`) and its agent file (`.claude/agents/`), not here. This file holds what they share: why
the project works this way, who does what, how a milestone travels through the lanes, and what the close files.
(Kooshi, 2026-09-28, replacing Workflow 2.0's single-mind milestone: *"The new standard top level workflow will be Poros, asking
the question, then Efodos answering it, then de Bruijn formalizing it. These can all be pipelined, so 3 agents will be running,
with Poros scouting ahead, Efodos blazing the trail, and de Bruijn paving [it] behind them, all quite independent."*)

### Why we work this way — the reframe

A project past the known frontier has three tiers of knowledge, and it accumulates all three at every close:
- **results**: what the kernel checked or an independent checker certified (the ledger);
- **understanding**: the mechanisms behind the results, and the readings that name their killing tests (the grokkings);
- **method**: the instruments, their failure modes, and the rules that keep a measurement honest.

Together they are the project's *theory*. Two facts about it govern everything below.

**First: past the frontier, priors are worthless and the theory is the only map.** The literature's constructions, the solver's
defaults, an agent's sense of what usually works: each is a prior formed where the ground was known. Where the project stands, the
only knowledge that bears on the next milestone is what the project itself has established. It is held in context precisely so
that it is *used*, to say:
- what a milestone's goal *is* in the theory's terms;
- what the theory already predicts about it (a free theorem; a null that need not be run);
- what instruments it supplies (a screen, a classifier, a control with a known answer);
- what it forbids;
- what the milestone could falsify.

A plan built from an analogy with the literature while the theory sat unread has used the project's own knowledge as background.
That is the failure this workflow exists to prevent. FS-70's plan (three implementer phases, an exact theorem, a typed null) was
built by transposing a published construction. The theory held four things that bore on it:
- a classifier that says where forcing exists in that field;
- a second route, with its tools already built;
- a prediction of a null before it was run;
- the shape the plan itself named first.

Every one surfaced only when Kooshi asked a question a grokking answers.

**Second: knowledge is the world's as well as ours, and ours supplies the vocabulary to find theirs.** A prior-art search in coined
vocabulary finds nothing. One made with the object named in its discipline's terms finds what was published decades earlier, and
that naming is what the re-grokking produces. So the world's knowledge is searched *after* our own has reframed the goal, and what
the search finds about *what the object is* flows back into the theory at the close.

Hence **the reframe**: every milestone opens with two acts, in this order, before a single route is written:
1. the **re-grokking**: our theory, entry by entry, read from inside the new question;
2. the **prior-art gate**: the world's theory, searched in the recognition's words.

Their outputs stand at the head of the plan. The first act is named for what it is: not an audit, which is an instruction to check,
but re-grokking, an instruction to think (G67). The theory is written to be reasoned from: each grokking ends with what it makes you
do and what would kill it. The reframe is carried out with the rigor of the modeling passes: fresh every milestone, never from memory or
a summary, walked in full, and scored line by line. And the loop closes at every close: results to the ledger, understanding to the grokkings, each miss to the
re-grokking's instances, and every new grokking forward to the open stubs it bears on. It is the foundation of every milestone; to
omit it risks all future advancement (Kooshi, 2026-09-22).

In the pipeline, the reframe is Ephodos's opening job. Its procedure is `.claude/agents/ephodos.md` § The opening job, and the
question it starts from is Poros's card.

### The roles

| role | identity | loaded by | its lane | hands on | writes |
|---|---|---|---|---|---|
| **coordinate** | Keryx | the top-level session, by the SessionStart hook in `.claude/settings.json` (`keryx` skill) | none; it runs the lanes | briefs, fences, rulings, the report to Kooshi | the close inventory; the frozen claim lists; the front-page files (`CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `BIBLIOGRAPHY.md`), filed verbatim from the lanes' drafts; `plans/STANDING-RULES.md`; this file |
| **ask** | Poros | `.claude/agents/poros.md` (`poros`; companions `poros-anomaly-hunt`, `poros-reframing`) | scouts ahead | a question card; a re-posed question; the draft re-rank; a frame test | its records, `plans/POROS-*.md`; the `## The question` section, bearings and bearing on the answer of the stub it is briefed on |
| **derive** | Ephodos | `.claude/agents/ephodos.md` (`ephodos`; companions `ephodos-recognition`, `ephodos-invention`, `ephodos-verification`) | blazes the trail | the plan (§G, §PA, §IQ); the proposed claim list; derived statements at their grades; the close record with the drafts of the front page | its plans and job records; `data/fsNNN/claims.md` until frozen; the derivation file; new stubs and the bearing lines of open stubs; the Proof Atlas facts |
| **verify** | Ephodos, as a second mind | `.claude/agents/ephodos-verifier.md` (`ephodos` + `ephodos-verification`) | follows each derivation, fenced | a verdict per claim, committed before it compares; a divergence table | its verification record |
| **formalize** | de Bruijn | `.claude/agents/debruijn.md` (`debruijn`; companions `debruijn-domain-modeling`, `-obligation-modeling`, `-experience-modeling`, `-debugging`, `-meta`, `-init`) | paves behind | kernel theorems read back against their statements; a statement defect, back to the deriver | `Proofs/`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, its job records |

**The identities are imported, not written here.** `.claude/skills/{keryx, poros*, ephodos*, debruijn*}` are byte-identical copies
of `~/source/agent-forge/identities/*/skills/` at agent-forge commit `6b47dbd` (2026-09-28). Anything specific to lean-dir lives in
the agent files and in this file, never in an imported skill; where the repository and a skill disagree, the agent file says which
wins. To update the skills, copy them again from agent-forge's committed tree, then run each gate's self-test from its own skill
directory (for example `cd .claude/skills/keryx && python3 scripts/brief_gate.py all scripts/example-brief.md`):
- `keryx`: `scripts/brief_gate.py all scripts/example-brief.md`
- `ephodos`: `scripts/derive_gate.py all scripts/example-clean.md scripts/example-verification.md scripts/example-invention.md`
- `poros`: `scripts/poros_gate.py all scripts/example-clean.md`

Each must exit 0, and its dirty example must exit non-zero. Keryx also borrows the `peer-delegation` and `decompress` skills, which
are installed at the user level.

**Delegation is one level deep.** Only Keryx launches agents. The pipeline's agent files withhold the Agent and Workflow tools,
and `.claude/settings.json` caps subagent nesting at one level (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`). The reasons are in
`plans/STANDING-RULES.md` rule 1. The head-count, the model and the budget are Kooshi's: `CLAUDE.md` § Delegation — one level deep.

### The pipeline

```
   Poros (ask)            Ephodos (derive)                            de Bruijn (formalize)
   milestone N+1   ──▶    milestone N: opening → derivations → close   ──▶  kernel queue: packets from N, N−1, …
   question card          claim list ──▶ ephodos-verifier (blind)
        ▲                      │ "stalls at …"                               │ statement defect
        └──────────────────────┘◀────────────────────────────────────────────┘
                                 every arrow is routed by Keryx
```

- **The lanes run at once and apart, one agent in each at a time.** Each lane has its own queue:
  - Poros: the next milestones' questions, and the boundary re-read and re-rank of each closed one;
  - Ephodos: one milestone at a time, and its verifiers;
  - de Bruijn: the handoff packets and kernel milestones, in the order Keryx sets with Kooshi.

  The only couplings are packets: a question card, a frozen claim list, a handoff packet, a stall, a statement defect, a refutation.
  Each packet lives in a file, and Keryx routes it.
- **Running ahead is the design across lanes, never within one.** Within Ephodos's lane, a milestone's close is committed before the
  next milestone's opening job launches, because the close propagates the new grokkings to the next reframe. Poros may pose several
  milestones ahead; its cards are provisional until the reframe replaces their bearings.
- **Blindness is kept by routing, and by what never gets written.**
  - A verifier's inputs are the frozen claim list, `CLAUDE.md`, `LEDGER.md` and the held papers; everything else about its milestone
    is fenced (`.claude/agents/ephodos-verifier.md`).
  - Poros writes nothing from a running milestone's fenced paths into a file its verifiers can read.
  - Commit subjects stay neutral from the first blind commit on.
  - **Never write an open milestone's verdict, route or hunch into the auto-memory** (`~/.claude/projects/…/memory/`): the harness
    gives its index to every agent at launch, blind ones included, and no fence closes that channel.
- **Every job is a fresh agent with a brief on disk.** Plan and build are separate minds by design.

### Conventions

| what | where |
|---|---|
| a job id | `FSnnn-<letters><n>`, the letters naming the job's kind by the milestone's own choice (FS-114's: `N` the proof side, `Y` the construction side, `NB`/`YB` their blind verifiers, `CV` a composition check) |
| a brief | `data/fsNNN/briefs/<job id>-<slug>.md`, in the `keryx` skill's header form. Its `identity:` field names the agent file the job is launched from (`subagent_type`), e.g. `ephodos-verifier`; the file's `skills:` preload the cores |
| a report | `data/fsNNN/reports/<job id>.md`, and the same text to "main" by `SendMessage` |
| a job record | `plans/FSnn-<job>-<kind>.md` (`-proof`, `-verification`, `-construction`, `-audit`); Poros's `plans/POROS-<date>-<topic>.md` |
| a milestone's plan | `plans/FSnn-<slug>.md` |
| its claim list | `data/fsNNN/claims.md`, frozen by Keryx |
| its close inventory | `plans/FSnn-close-inventory.md` (the template is `plans/FS73-close-inventory.md`) |
| its derivation file | `plans/FSnn-derivation.md` |
| a stub | `plans/STUB-<slug>.md` |
| a handoff before a compaction | `plans/SESSION-HANDOFF-<date>.md` |

### A milestone, end to end

Each step names the lane that does it. Keryx's own procedure for every step is its core (`keryx` skill: `<the_brief>`,
`<independence>`, `<rulings>`, `<the_inventory>`, `<review>`); the lanes' procedures are their agent files.

1. **The question** (Poros, scouting). The milestone's stub gets `## The question (Poros, <date>)`, with the card and the question's
   existence and structural forms, and its provisional bearings and bearing on the answer are rewritten.
2. **Open** (Keryx). Read the stub from disk. Open the close inventory (Kooshi, 2026-09-23: nothing the close will need lives only
   in a context or a scratch directory) and brief Ephodos's opening job.
3. **The reframe and the plan** (Ephodos, opening job). §G, §PA and §IQ, then the routes, the stages and the registered
   predictions, then the proposed claim list. A kernel milestone opens instead with de Bruijn's own reframe
   (`.claude/agents/debruijn.md`).
4. **Review and freeze** (Keryx, with Kooshi). Score §G line by line and §IQ: a skipped entry is a plan defect, and a structural
   form that is the existence form reworded has not done its job. Freeze the claim list. Write the announcement rule and the
   predictions into the inventory before any report arrives. Commit.
5. **Derive and verify** (Ephodos derivation jobs; `ephodos-verifier` jobs). One verifier per frozen claim list, fenced by path,
   beside or after the derivation. Its verdict is committed before it reads the derivation.
6. **Route** (Keryx). Refutations and statement defects go to Ephodos, stalls to Poros, and derived entries whose `handoff:` names
   de Bruijn go to its queue. Proposed bibliography rows are filed the day they arrive (`CLAUDE.md`: an entry is added the day a work
   is first used).
7. **The close.** Every draft is written by a lane, and Keryx files it verbatim, so that Keryx coordinates and does not author.
   - **The close record** (Ephodos, close job). It writes the derivation file, the new stubs and the open stubs' bearing lines, and
     the Proof Atlas facts. It drafts the ledger rows, the Frontier lines, the scored predictions, the grokkings and their new
     instances, and runs the sweeps.
   - **The boundary re-read and the draft re-rank** (Poros), from the close record.
   - **The front page** (Keryx), in **one closing commit**:
     - `CLAUDE.md` § Frontier and the ledger's new rows, current state only. A milestone whose close does not update the Frontier is
       not closed.
     - `plans/FRONTIER-STUBS.md` re-ranked from Poros's draft, and a banner on each demoted stub; demote, never delete.
     - New instances of an existing rule go to `plans/GROKKING-INSTANCES.md` verbatim, with their source address, and the rule's
       entry keeps its pointer; a new rule goes to `CLAUDE.md`.
     - `tools/claude_md_fact_audit.py --base <the previous close>` and `--dupes`.
     - The Proof Atlas republished from its build (`visualizations/proof-atlas/`).
     - Every inventory line ticked "done" or "declined" with its reason, every number re-read from its source.

     When the filing is large, Keryx may brief an agent as the front-page lane to do it, under the same rule: verbatim, no authoring.
8. **Report** (Keryx, to Kooshi):
   - the milestone's name and purpose;
   - what landed, at which grade and with how many minds, and what is not claimed;
   - every decision the work forced or overturned, in four parts, with the confidence held after seeing it run;
   - what runs next.
9. **The kernel** (de Bruijn, in its own time). Each packet's formal statement is read back; then the skeleton, the modeling
   passes, the burn-down and the gate. A kernel milestone's close record drafts its counts, rows and Frontier lines for Keryx to
   file.

**The head-count** is Kooshi's (`CLAUDE.md` § Delegation — one level deep). A competition (`plans/PROTOCOL-competitor-and-advisor.md`)
or a crunch (`plans/PROTOCOL-crunch.md`) runs more agents than the pipeline's lanes, and needs his word first.

**The stub rule** (Kooshi, 2026-08-09). Every future milestone on the roadmap is kept as a detailed stub in `plans/`. It holds the
full mission context in plain language and everything the deciding session knew: the observations, the registered expectations, the
failure clauses, the named deliverables (visualizers among them, where the milestone produces an explorable object), and the
provisional bearings. It is written so a fresh mind with no conversation memory can plan it with all meaning intact. Sessions die
and compaction loses nuance; the stubs are the roadmap's memory. A direction change that does not rewrite the affected stubs is not
recorded. A demoted milestone keeps its stub with a banner saying why. Its writers are named in § The roles.

### Reporting to Kooshi

Only Keryx reports to Kooshi, in the house format of its core's `<the_principal>` and the `decompress` skill's discipline. Kooshi's
own rules that the core states less sharply:
- **No identifier is ever the noun.** A path, type or theorem name may follow the plain-English name in parentheses, as an address.
- **No shorthand and no back-references.** Never "the fix we discussed" or "as noted above": restate the thing in full, every time.
- **Describe it in the product's terms**: what a reader of the finished theorem would notice is different, before any word about how
  it was built.
- **"Do nothing" counts as an alternative** only when doing nothing was genuinely live.
- **The settled decisions go in a table**, with columns *choice · alternative · why · confidence*, so the section can be skipped.
- **The test:** a sentence that only lands for someone with the repository open, the previous message in mind, or a working
  knowledge of Lean is not finished.

A direct question still gets a direct answer. Do not turn "where did you put X" into a table.

### Where the old steps went

Workflow 2.0's step numbers are cited across `plans/`, `tools/` and `CLAUDE.md`. They now live here:

| Workflow 2.0 step | now owned by | now at |
|---|---|---|
| preamble: leaf-first up the DAG, the green manifold | de Bruijn | `.claude/agents/debruijn.md` § Your loop; the `debruijn` skill's `<the_loop>` |
| 1 Architect (`ARCHITECTURE.md`) | de Bruijn | `.claude/agents/debruijn.md` § Your loop |
| 2 Plan, and the stub rule | Poros (the question, the re-rank draft), Keryx (the filing) | § The stub rule; `.claude/agents/poros.md` § Your jobs |
| 3 Reframe: 3.1 re-grokking, 3.2 prior-art gate (items 1–8, the zbMATH API), 3.3 invariant question | Ephodos (opening job); Poros supplies 3.3's items 1–2; de Bruijn's own reframe for a kernel milestone | `.claude/agents/ephodos.md` § The opening job |
| 4 Subplan | Ephodos (a derivation plan), de Bruijn (a kernel skeleton) | the two agent files |
| 5 Commit, and the close inventory | Keryx | § A milestone, step 2; the `keryx` skill's `<the_inventory>` |
| 6 Modeling passes (the fresh-invocation rule) | de Bruijn | `.claude/agents/debruijn.md` § Your loop |
| 7 Implement, and "Theorems this phase proved" | Ephodos (derivation jobs), de Bruijn (burn-down) | the agent files; `plans/STANDING-RULES.md` rule 7 |
| 8 Quality gate | de Bruijn | `.claude/agents/debruijn.md` § Your loop; `CLAUDE.md` § The gate |
| 9 Close, and its sweeps | Ephodos (the close record), Poros (the re-read and the re-rank), Keryx (the front page) | § A milestone, step 7; `.claude/agents/ephodos.md` § The close job |
| 10 Report | Keryx | § A milestone, step 8; § Reporting to Kooshi |
| 11 Next | the pipeline | § The pipeline |
