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
do and what would kill it. The reframe is carried out fresh every milestone, never from memory or a summary, walked in full, and
scored line by line. And the loop closes at every close: results to the ledger, understanding to the grokkings, each miss to the
re-grokking's instances, and every new grokking forward to the open stubs it bears on. It is the foundation of every milestone; to
omit it risks all future advancement (Kooshi, 2026-09-22).

In the pipeline, the reframe is Ephodos's opening job. Its procedure is `.claude/agents/ephodos.md` § The opening job, and the
question it starts from is Poros's card.

### The roles

| role | identity | loaded by | its lane | hands on | owns |
|---|---|---|---|---|---|
| **coordinate** | Keryx | the top-level session, by the SessionStart hook in `.claude/settings.json` (`keryx` skill) | none; it runs the lanes | briefs, fences, rulings, the report to Kooshi | the close inventory, the frozen claim lists, the front-page files (`CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `BIBLIOGRAPHY.md`), `plans/STANDING-RULES.md`, this file |
| **ask** | Poros | `.claude/agents/poros.md` (`poros`; companions `poros-anomaly-hunt`, `poros-reframing`) | scouts ahead | a question card in the next milestone's stub; a re-posed question; a frame test | its records `plans/POROS-*.md`; the stub it is briefed to pose |
| **derive** | Ephodos | `.claude/agents/ephodos.md` (`ephodos`; companions `ephodos-recognition`, `ephodos-invention`, `ephodos-verification`) | blazes the trail | the plan (§G, §PA, §IQ), the proposed claim list, derived statements at their grades, the derivation file and the close record | its plans and job records, `data/fsNNN/claims.md` until frozen |
| **verify** | Ephodos, second mind | `.claude/agents/ephodos-verifier.md` (`ephodos` + `ephodos-verification`) | follows each derivation, fenced | a verdict per claim, committed before it compares; a divergence table | its verification record |
| **formalize** | de Bruijn | `.claude/agents/debruijn.md` (`debruijn`; companions `debruijn-domain-modeling`, `-obligation-modeling`, `-experience-modeling`, `-debugging`, `-meta`, `-init`) | paves behind | kernel theorems read back against their statements; a statement defect, back to the deriver | `Proofs/`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, its job records |

**The identities are imported, not written here.** `.claude/skills/{keryx, poros*, ephodos*, debruijn*}` are byte-identical copies
of `~/source/agent-forge/identities/*/skills/` at agent-forge commit `6b47dbd` (2026-09-28). Anything specific to lean-dir lives in
the agent files and in this file, never in an imported skill. To update the skills, copy them again from agent-forge's committed
tree, then run each gate's self-test from its skill directory:
- `keryx/scripts/brief_gate.py all scripts/example-brief.md`
- `ephodos/scripts/derive_gate.py all scripts/example-clean.md scripts/example-verification.md scripts/example-invention.md`
- `poros/scripts/poros_gate.py all scripts/example-clean.md`

Each must exit 0, and its dirty example must exit non-zero. Keryx also borrows the `peer-delegation` and `decompress` skills, which
are installed at the user level.

**Delegation is one level deep.** Only Keryx launches agents. The pipeline's agent files withhold the Agent and Workflow tools,
and `.claude/settings.json` caps subagent nesting at one level (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`). The reasons are in
`plans/STANDING-RULES.md` rule 1. Staffing (head-count, model, budget) is Kooshi's: `CLAUDE.md` § Delegation — one level deep.

### The pipeline

```
   Poros (ask)            Ephodos (derive)                            de Bruijn (formalize)
   milestone N+1   ──▶    milestone N: opening → derivations → close   ──▶  kernel queue: packets from N, N−1, …
   question card          claim list ──▶ ephodos-verifier (blind)
        ▲                      │ "stalls at …"                               │ statement defect
        └──────────────────────┘◀────────────────────────────────────────────┘
                                 every arrow is routed by Keryx
```

- **The lanes run at once and apart.** Each has its own queue:
  - Poros: the next milestones' questions, and the boundary re-read of each closed one;
  - Ephodos: one milestone at a time, and its verifiers;
  - de Bruijn: the handoff packets and kernel milestones, in the order Keryx sets with Kooshi.

  The only couplings are packets: a question card, a frozen claim list, a handoff packet, a stall, a statement defect, a refutation.
  Each packet lives in a file, and Keryx routes it.
- **Running ahead is the design across lanes, never within one.** Within Ephodos's lane, a milestone's close is committed before
  the next milestone's opening job launches, because the close propagates the new grokkings to the next reframe. Poros may pose
  several milestones ahead; its cards are provisional until the reframe replaces their bearings.
- **Blindness is kept by routing.** A verifier's only input is the frozen claim list. Poros's cards never carry derivation content
  toward a verifier. Commit subjects stay neutral from the first blind commit on.
- **Every job is a fresh agent with a brief on disk.** Plan and build are separate minds by design. A mind past about 500k tokens
  (the harness's count) is replaced from the record, not continued.

### A milestone, end to end

Each step names the lane that does it. Keryx's own procedure for every step is its core (`keryx` skill: `<the_brief>`,
`<independence>`, `<rulings>`, `<the_inventory>`, `<review>`); the lanes' procedures are their agent files.

1. **The question** (Poros, scouting). The milestone's stub (`plans/STUB-<slug>.md`) gets Poros's question card, the question's
   existence and structural forms, provisional bearings, and its bearing on the answer.
2. **Open** (Keryx). Read the stub from disk, and open the close inventory, `plans/FSnn-close-inventory.md`
   (`plans/FS73-close-inventory.md` is the template). Write to it the moment an item comes up, one line per item with its source
   address. Nothing the close will need lives only in a context, or in a scratch directory (Kooshi, 2026-09-23). Then brief
   Ephodos's opening job.
3. **The reframe and the plan** (Ephodos, opening job). §G, §PA and §IQ, then the routes, the stages and the registered
   predictions, then the proposed claim list, `data/fsNNN/claims.md`.
4. **Review and freeze** (Keryx, with Kooshi). Score §G line by line and §IQ: a skipped entry is a plan defect, and a structural
   form that is the existence form reworded has not done its job. Freeze the claim list. Write the announcement rule and the
   predictions into the inventory before any report arrives. Commit.
5. **Derive and verify** (Ephodos derivation jobs; `ephodos-verifier` jobs). One verifier per frozen claim list, fenced by path,
   beside or after the derivation. Its verdict is committed before it reads the derivation.
6. **Route** (Keryx). Refutations and statement defects go to Ephodos; stalls go to Poros; derived entries whose `handoff:` names
   de Bruijn go to its queue.
7. **The close.**
   - **The close record** (Ephodos, close job). This holds the derivation file (`plans/FSnn-derivation.md`, every theorem proved
     outside the kernel, in the Ephodos entry grammar); the §G re-read, and whether §IQ's structural question produced the result;
     the §PA sweep for what the object *is*; the sweep of the plan for unpursued conjectures; and the proposed grokkings, ledger
     lines and stubs.
   - **The front page** (Keryx, quoting the close record verbatim):
     - `CLAUDE.md` § Frontier and the ledger's new rows, rewritten in place, current state only. A milestone whose close does not
       update the Frontier is not closed.
     - The re-rank of `plans/FRONTIER-STUBS.md`, with each row's bearing on the answer stated honestly; demote with a banner, never
       delete.
     - New instances of existing rules go to `plans/GROKKING-INSTANCES.md`, and new rules to `CLAUDE.md`.
     - Bibliography rows.
     - `tools/claude_md_fact_audit.py --base <the previous close>` and `--dupes`.
     - The published Proof Atlas brought current (`visualizations/proof-atlas/`).
     - Every inventory line ticked "done" or "declined" with its reason, every number re-read from its source.
   - **The boundary re-read** (Poros), after the close: the closed record read for what was missed, and its hunch ledger scored.
8. **Report** (Keryx, to Kooshi): the milestone's name and purpose, what landed at which grade and with how many minds, what is not
   claimed, the decisions made, and what runs next.
9. **The kernel** (de Bruijn, in its own time). Each packet's formal statement is read back, then skeleton, modeling passes,
   burn-down and the gate. Its counts (axioms, vacuity) and trust-ledger lines are proposed to Keryx, which files them in
   `CLAUDE.md`.

**The stub rule** (Kooshi, 2026-08-09). Every future milestone on the roadmap is kept as a detailed stub in `plans/`. It holds the
full mission context in plain language and everything the deciding session knew: the observations, the registered expectations,
the failure clauses, the named deliverables, and the provisional bearings. It is written so a fresh mind with no conversation memory
can plan it with all meaning intact. Sessions die and compaction loses nuance; the stubs are the roadmap's memory. A direction
change that does not rewrite the affected stubs is not recorded. A demoted milestone keeps its stub with a banner saying why.
Whoever a brief names writes a stub: Poros for its question, Ephodos's close job for the stubs it proposes, and Keryx for a banner.

### Reporting to Kooshi

Only Keryx reports to Kooshi, in the house format of its core's `<the_principal>`, with the `decompress` skill's discipline:
- plain words, and every decision in four parts;
- the default for each open item, with a recommendation and a confidence;
- items ranked, with counts in the headings;
- the settled decisions listed so they can be skipped;
- tables, not paragraphs.

Three rules of Kooshi's that the core states less sharply:
- **No shorthand and no back-references.** Never "the fix we discussed" or "as noted above": restate the thing in full, every
  time.
- **Describe it in the product's terms**: what a reader of the finished theorem would notice is different, before any word about
  how it was built.
- **The test:** a sentence that only lands for someone with the repository open, the previous message in mind, or a working
  knowledge of Lean is not finished.

A direct question still gets a direct answer. Do not turn "where did you put X" into a table.

### Where the old steps went

Workflow 2.0's step numbers are cited across `plans/`, `tools/` and `CLAUDE.md`. They now live here:

| Workflow 2.0 step | now owned by | now at |
|---|---|---|
| 1 Architect (`ARCHITECTURE.md`) | de Bruijn | `.claude/agents/debruijn.md` § Your loop |
| 2 Plan, and the stub rule | Poros (the question), Keryx (the ranking) | § A milestone, step 1; § The stub rule; `.claude/agents/poros.md` § Your jobs |
| 3 Reframe: 3.1 re-grokking, 3.2 prior-art gate (items 1–8, the zbMATH API), 3.3 invariant question | Ephodos (opening job); Poros supplies 3.3's items 1–2 | `.claude/agents/ephodos.md` § The opening job |
| 4 Subplan | Ephodos (a derivation plan), de Bruijn (a kernel skeleton) | the two agent files |
| 5 Commit, and the close inventory | Keryx | § A milestone, step 2; the `keryx` skill's `<the_inventory>` |
| 6 Modeling passes (the fresh-invocation rule) | de Bruijn | `.claude/agents/debruijn.md` § Your loop |
| 7 Implement, and "Theorems this phase proved" | Ephodos (derivation jobs), de Bruijn (burn-down) | the agent files; `plans/STANDING-RULES.md` rule 7 |
| 8 Quality gate | de Bruijn | `.claude/agents/debruijn.md` § Your loop; `CLAUDE.md` § The gate |
| 9 Close, and its sweeps | Ephodos (the close record), Keryx (the front page), Poros (the re-read) | § A milestone, step 7; `.claude/agents/ephodos.md` § The close job |
| 10 Report | Keryx | § Reporting to Kooshi |
| 11 Next | the pipeline | § The pipeline |
