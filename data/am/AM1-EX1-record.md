# AM1-EX1 — the generic workflow repository: record

*Job AM1-EX1, a general-purpose engineer on Opus, briefed by `data/am/briefs/AM1-EX1-extract.md`. Written in this repository, not
committed (the brief's `touches:`); each stage is saved as a commit in `/home/kooshi/source/agentic-mathematics` and a line here.*

## Theorems this phase proved

None. This job builds a template repository; its one example theorem (`Proofs.Example.oddSum_eq_sq`) is a demonstration, not a result.

## Stage 1 — SAVED (readback and inventory)

### Readback

- The brief's two quotations (W17; W17 read by Keryx) were checked by script against `data/am/REQUEST-2026-10-16.md`: both
  verbatim.
- The identity sources: all fifteen identity folders in `.claude/skills/` (`keryx`; `poros` and two companions; `ephodos` and three;
  `debruijn` and **six**, not five as the brief says) are byte-identical to agent-forge's `identities/*/skills/` both at the commit
  the brief names and at agent-forge's HEAD (`diff -rq`, `__pycache__` excluded). Reported to the coordinator; ruled: the brief's
  count was its slip, all six are vendored.
- The two user skills: `decompress` is clean of anything personal. `peer-delegation` opens with a paragraph about the owner's own
  practice (lines 8–11, "Written at the request of a human who has treated his Claudes as peers since Sonnet 3.5 …"). It names no
  one and holds none of the brief's listed categories. Reported to the coordinator; ruled: vendored byte-identical, kept as a CHECK
  for the owner.
- A scan of every vendored identity for personal or project-specific text (names, paths, links, the problem's vocabulary) found
  none; the only outside names are the credited Ferrous suite in `debruijn-meta` and `debruijn-init`.
- The Lean runs: the controls need about fifteen `lake env lean` elaborations beside the one build. Asked; ruled: one slot
  reservation, sequential, stop if Lake's `--no-build` check says Mathlib is stale.
- The git identity the new repository's commits carry is the global one, a GitHub no-reply address; nothing else personal enters the
  commit metadata.

### The claims, restated

Build `/home/kooshi/source/agentic-mathematics`, a new git repository (branch `main`, no remote), from which a stranger opens Claude
Code and attacks a mathematical problem of their own with this repository's coordinating workflow and Lean as the kernel. It
carries the seven lanes and the coordinator (identities unchanged, workflows generic), the settings, the vendored skills, a
`CLAUDE.md` template with marked places for the principal's problem, aim, notation and counter-priors, the front files as forms,
the brief tooling, a Lean package at v4.32.0 with one example theorem, the gate made generic, the controls watched failing, a
README and an Apache-2.0 licence. It says nothing about this problem except one marked example in the README, and nothing personal
about the owner beyond the credit line.

### Inventory — what is carried, what it becomes, what is left behind

| source | becomes in the template | left behind, and why |
|---|---|---|
| `.claude/skills/{keryx, poros*, ephodos*, debruijn*}` (15 folders) | vendored byte-identical, `__pycache__` left out | nothing |
| `~/.claude/skills/{decompress, peer-delegation}` | vendored byte-identical as project skills | nothing (peer-delegation's opening paragraph: CHECK) |
| `.claude/settings.json` | the same four keys: output style `keryx`, the four cores `user-invocable-only`, spawn depth 1, `TZ=UTC` | nothing |
| `.claude/output-styles/keryx.md` | the core verbatim, then the workflow made generic | the Proof Atlas filing, the two-subscription rule, the agent-forge filing of gate defects (the owner's), the staffing numbers (the principal's) |
| `.claude/agents/{poros, ephodos, ephodos-verifier, debruijn, debruijn-implementer, searcher, clerk}.md` | identity unchanged, workflow made generic; the Searcher's and the Clerk's own identities made generic | `ferrous-engineer.md` (another project's, credited) |
| `.claude/skills/grokkings/SKILL.md` | the form: the file's rules and an entry's shape, no entries | every entry (this problem's theory) |
| `CLAUDE.md` | a template holding every workflow rule, generic, with marked places | the mathematics, results, rows, milestone numbers, history |
| the method grokkings the workflows cite (G21, G30, G46, G49, G50, G51, G67, G72, G79, G87) | stated as method rules in `CLAUDE.md` § Method, so that every citation in a workflow resolves | their instances and incidents (this problem's) |
| `WORKFLOW.md` | folded into the README's map and `CLAUDE.md` § The pipeline | its step-number history (this repository's past) |
| `plans/STANDING-RULES.md` | generic, the same twelve rules | the frozen-tool list, the problem's search kinds |
| `LEAN.md` | the generic Lean facts at the pin: assumptions and their four items, the trust ledger, the build, the invalidation table, the cost-model rules, a few tactic traps, the gate | the 48 KB of Mathlib API notes tied to this problem's declarations; the port-of-a-release procedure; every job id and measurement |
| `RUNNING.md` | § Building and § Make the gate fail, generic, the two PROTECTED paragraphs kept as protected rules with their incidents stated generically | § Toolchain (this machine's solvers and two machines); dated incidents |
| `scripts/identities.py` | reworked: `check` holds every vendored skill file to a manifest of hashes and each identity block to its skill; `sync --from <forge>` copies and re-records | nothing |
| `scripts/slot.py`, `build.sh`, `build_order.py`, `gate-log.sh`, `dev-env.sh` | generic: budgets from the machine, the library prefix from the package, the Arch clang fix only on Arch | the desktop's numbers |
| `scripts/axioms.sh` + `Axioms.lean` | rewritten small: every record found automatically, classified CLEAN / IMPORTED / PURCHASED, with planted controls | the 780 KB hand list of records |
| `scripts/vacuity.sh` + `Vacuity.lean` | the same law and six verdicts, a user-filled list of tracked carriers, planted controls | the problem's tracked carriers and its `Coloring` rules |
| `scripts/gate_report.py` | rewritten small: digests and count comparisons for the axiom audit and the vacuity scan | the assumptions scan's digest |
| `scripts/assumptions.sh` + `Assumptions.lean`, `dupnames.sh`, `lean4checker.sh`, `regen-check.sh` | the assumptions rule stated in `LEAN.md`; `lean4checker` named as the publication gate | the scripts (tied to this library's declarations, or larger than the template needs); CHECK |
| `data/workflow3/brief_quote.py`, `data/fs131/briefs/scripts/mkbrief.py` | `scripts/brief_quote.py`, `scripts/mkbrief.py`, with paths from the repository | the problem's constants in mkbrief |
| `tools/claude_md_fact_audit.py` | the generic core (token classes, protected regions, headings, pointers, `--dupes`, size budgets), its tables empty, a self-test on a built-in corpus | its 800 lines of this repository's allowances and history |
| `tools/bib_audit.py`, `tools/check_architecture.py` | generic, with self-tests | this repository's exceptions |
| `install-toolchain.sh`, `lakefile.toml`, `lean-toolchain`, `lake-manifest.json` | the same pin, package `proofs`, library `Proofs` | nothing |
| the front files' forms (`LEDGER.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `plans/SEARCH-QUEUE.md`, a stub, a close inventory, a derivation file, a handoff, a claim list, a brief) | forms with headings and one-line instructions, in place or under `plans/templates/` | every row |
| the auto-memory, `.claude/settings.local.json` | nothing | personal and machine-specific |

Commit: the new repository's first commit (the vendored skills and `.gitignore`).

## Stage 2 — SAVED (the skeleton)

- **Amendments read back.** Amendment 1 (W18, the grokkings carried whole) and Amendment 2 (W19, the why of every rule): both
  quotations checked by script against `data/am/REQUEST-2026-10-16.md`, both verbatim. Amendment 1 replaces the empty grokkings file:
  the template's file has its header rules, the entry's form and two marked example entries; `CLAUDE.md` § Grokkings carries W18's
  words, the three tiers and the rules with their reasons. Amendment 2's control (every rule with the file and line of its reason) is
  built at stage 5, after the cold read.
- **Built:** `.claude/settings.json` (the four settings unchanged) and `.claude/settings.md` (each setting's reason); the output style
  and the seven lane files, each identity block copied from its vendored skill by `scripts/identities.py sync` (check passes); the
  grokkings file; `CLAUDE.md` (template, about 33 KB); `LEAN.md`, `RUNNING.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`;
  `plans/STANDING-RULES.md`, `FRONTIER-STUBS.md`, `GROKKING-INSTANCES.md`, `GROKKINGS-RETIRED.md`, `SEARCH-QUEUE.md`; six templates
  under `plans/templates/`; `scripts/brief_quote.py`, `scripts/mkbrief.py`, and `data/briefs/example-brief.md`, which passes the brief
  gate (exit 0).
- **A finding about the source:** this repository's grokkings description says the file is preloaded into "poros, ephodos,
  ephodos-verifier and debruijn", while `.claude/agents/debruijn.md` has no `skills:` field and its workflow says "the grokkings are
  not loaded at your launch". The template follows the agent files: the three reasoning lanes preload it; de Bruijn reads by number.

Commit: `ac99cea` (new repository).

## Stage 3 — SAVED (the kernel)

- The package (`lakefile.toml`, `lean-toolchain`, `lake-manifest.json`: the same pin, Lean and Mathlib v4.32.0), `Proofs.lean` and
  `Proofs/Example.lean` (`Proofs.Example.oddSum`, `oddSum_eq_sq`, two `example`s and a `#guard`), built once: `./scripts/build.sh`
  under this repository's slot, after symlinking this repository's `.lake/packages`; 2 modules, 11 s; the new dependency check
  (`lake build --no-build` over the library's outside imports) passed first, so Mathlib was up to date and nothing of it was built.
- **A slot fact for the coordinator**: the brief's slot command carries this repository's desktop defaults (budget 90 GiB, reserve
  25 GiB), which no 8 GiB job can pass on the laptop (31 GB); the first attempt waited without admission and was stopped by me
  before admission (nothing ran, nothing reserved). Every later run used the laptop's documented ledger settings
  (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`, `LEAN.md` § Building) with the brief's `--mem 8 --cpus 2`.
- The gate, generic: `scripts/build.sh` (batches and cap as before; defaults `BATCH=4`, `MEMMAX=8G`; refuses to build a
  dependency; `MEMCAP=none` as an explicit escape where no systemd user session exists), `scripts/nosorry.py`, `scripts/Axioms.lean`
  + `axioms.sh` + `axioms_check.py` (every declaration found by the file itself, classified CLEAN / IMPORTED / PURCHASED, nine failure
  kinds), `scripts/Vacuity.lean` + `vacuity.sh` + `vacuity_check.py` + baseline (the source's law and six verdicts over a
  user-filled `trackedProps`), `scripts/gate_report.py`, `scripts/gate.sh`; `scripts/slot.py` (budget and reserve from the machine's
  memory), `dev-env.sh` (the clang fix on Arch only), `gate-log.sh`, `build_order.py`; `tools/claude_md_fact_audit.py`,
  `tools/bib_audit.py`, `tools/check_architecture.py`; `install-toolchain.sh`. `scripts/identities.py` holds 30 vendored files to
  `scripts/identities.manifest` and the six identity blocks to their skills; `sync --from <forge>` copies and re-records.

Commit: `f1f42ff` (new repository).

## Stage 4 — SAVED (the controls)

All in one slot reservation (`build/am1-gate.out`, exit 0): `./scripts/gate.sh --self-tests`.
- The gate on the example: build OK (up to date); no sorry; axioms `clean=1 imported=0 purchased=0 axiom-free=1 records=2`; vacuity
  `declarations=6 sites=0` (no tracked carrier yet); `lake lint` passed; the module map OK; identities PASS.
- Self-tests, each with partners that pass: identities 13/13 (a one-byte change in a companion and in a gate script, a lane's
  identity drift, a missing heading, an unlisted file, a missing file, an empty manifest); zero-sorry 9/9; **axiom audit 12/12** —
  sorry, sorry in a private theorem, an undeclared axiom used and unused, a declared import named and not named in
  `ARCHITECTURE.md`, an unused import, an import with no bibliography key (fails to elaborate, for the right reason: its log reads
  "declareImport: Ctl.nokey's docstring names no bibliography key"), `native_decide` with and without its purchase docstring, a stale
  purchase docstring; **vacuity scan 10/10** — VACUOUS, DECLARED, STALE, WITNESSED, GENERIC, UNKNOWN out of and in the baseline, a
  stale baseline entry, a refutation skipped and counted; the module map 5/5; the fact audit 16/16 on a built-in corpus; the
  bibliography audit 3/3.
- Each identity gate from its skill directory: `keryx` clean 0, dirty 1; `ephodos` clean (three examples) 0, dirty 1; `poros`
  clean 0, dirty 1.
- `scripts/identities.py check` on the real tree: PASS; with one byte planted in `poros-reframing/SKILL.md`: exit 1, naming the
  file; restored: PASS, and the file byte-identical to its source again.
- The fact audit on the template (`--base HEAD`): PASSED, `CLAUDE.md` 33,968 of 80,000 bytes, grokkings 4,288 of 200,000; `--dupes`:
  five repeated 10-word runs, 325 bytes (rules restated beside their use); the bibliography audit: every cited key resolves. Every
  `.sh` passes `bash -n` and every `.py` parses.
- Lean runs: one build plus 24 elaborations (2 gate, 12 + 10 controls), sequential, inside the one reservation; about 15 s and
  1.6 GB each.

Commit: the stage-4 commit (new repository), which also refiles the gate's counts in `CLAUDE.md` and adds reasons beside the lanes'
boundary rules (Amendment 2).

## Stage 5 — SAVED (the front page, the cold read, and the reasons control)

- `README.md` (the method and why it is shaped so; the minds and what each hands on; the states; the grokkings as a defining
  feature, with W18 quoted as the principal's words and the three tiers; the gates and why each exists; how to start; the costs;
  where things are; the credit; one marked worked example with `<lean-dir public URL>`), `LICENSE` (this repository's Apache-2.0
  text, unchanged; it names no copyright holder).
- **The cold read**, from `CLAUDE.md` and the output style outward: every backticked path in the template's own files resolves or
  is a pattern (`Mnn`, `mNN`); a scan for this problem's vocabulary, personal names, home paths, links and this repository's hashes
  across every committed file finds only the README's credit line, the Ferrous link and the marked example; one dangling reference
  (`(FS-73)` in a comment of `tools/bib_audit.py`) removed. Rules found reading as orders with no reason and given one: the
  coordinator's claim-list fixing, the planner's early launch, routing defects at once, numbers fixed for parallel milestones, the
  Clerk's worktree filing, the slots, the models, replacement, the search queue, reporting cadence, closing in Lean; the lanes'
  "through Keryx only" and one-writer boundaries; the planner's hand-off; the implementer's green manifold and drafts.
- The `.lake/packages` symlink removed before this stage's commit; `.lake/build` (the example's compiled files) and `build/` (every
  log of stages 3–4) are left in the working tree, both gitignored.

### The reasons control — every rule carried, and where its reason sits

*Generated by a script (`reasons.py` in this session's scratch) that finds, for each rule, a phrase of the sentence giving its
reason, and prints the file and line. All 111 found. The vendored identities carry their own reasons and are not listed.*

| rule | where its reason is |
|---|---|
| current state only in every loaded file | `CLAUDE.md`:16 |
| size budgets (80 KB, 200 KB) | `CLAUDE.md`:21 |
| a budget is met by moving, never by trimming reasoning | `CLAUDE.md`:23 |
| one home per fact | `CLAUDE.md`:28 |
| PROTECTED paragraphs | `CLAUDE.md`:33 |
| notation declared once | `CLAUDE.md`:38 |
| grades on every claim | `CLAUDE.md`:44 |
| counter-priors section | `CLAUDE.md`:73 |
| rank by bearing, never difficulty | `CLAUDE.md`:78 |
| a rung not landed is reported as not landed | `CLAUDE.md`:87 |
| derivations over objects | `CLAUDE.md`:90 |
| nothing published before Lean | `CLAUDE.md`:95 |
| a milestone may assume the literature | `CLAUDE.md`:97 |
| naming is a deliverable | `CLAUDE.md`:102 |
| the bibliography maintained | `CLAUDE.md`:111 |
| the Frontier updated at every filing | `CLAUDE.md`:121 |
| ledger row numbers stable | `CLAUDE.md`:136 |
| grokkings loaded by the reasoning lanes | `CLAUDE.md`:162 |
| grokking status at its grade | `CLAUDE.md`:168 |
| grokking Do and killing test | `CLAUDE.md`:171 |
| grokkings demoted, never deleted | `CLAUDE.md`:175 |
| every milestone opens with the reframe | `CLAUDE.md`:178 |
| theory in one paragraph | `CLAUDE.md`:181 |
| the lanes as separate minds | `CLAUDE.md`:249 |
| planner and implementer separate | `CLAUDE.md`:251 |
| the kernel is the second check | `CLAUDE.md`:255 |
| Derived results usable before Closed | `CLAUDE.md`:258 |
| identities vendored unchanged | `CLAUDE.md`:263 |
| one writer per file | `CLAUDE.md`:270 |
| nothing about an open milestone in the auto-memory | `CLAUDE.md`:274 |
| fixed conventions and paths | `CLAUDE.md`:277 |
| job ids new every time | `CLAUDE.md`:283 |
| the stub rule | `CLAUDE.md`:297 |
| staffing is the principal's | `CLAUDE.md`:304 |
| own the conclusions | `CLAUDE.md`:318 |
| delegation one level deep | `CLAUDE.md`:326 |
| standard of evidence: disbelief is the default | `CLAUDE.md`:334 |
| no native evaluation in the headline | `CLAUDE.md`:336 |
| witness re-derivable | `CLAUDE.md`:340 |
| report the hunt | `CLAUDE.md`:344 |
| re-price from the first two leaves | `CLAUDE.md`:354 |
| search by the Searcher only | `CLAUDE.md`:379 |
| completeness questions with a tool seen failing | `CLAUDE.md`:398 |
| the vacuity counts recorded | `CLAUDE.md`:409 |
| watch the gate fail | `CLAUDE.md`:418 |
| every method rule (nine) | `CLAUDE.md`:198 |
| settings: output style | `.claude/settings.md`:8 |
| settings: cores hidden | `.claude/settings.md`:9 |
| settings: spawn depth 1 | `.claude/settings.md`:10 |
| settings: TZ=UTC | `.claude/settings.md`:11 |
| standing rule 1 no agents | `plans/STANDING-RULES.md`:9 |
| standing rule 2 saved stages | `plans/STANDING-RULES.md`:13 |
| standing rule 3 verbatim quotation | `plans/STANDING-RULES.md`:21 |
| standing rule 4 every outcome counts | `plans/STANDING-RULES.md`:27 |
| standing rule 5 no search | `plans/STANDING-RULES.md`:35 |
| standing rule 6 commits by path | `plans/STANDING-RULES.md`:39 |
| standing rule 6 neutral subjects | `plans/STANDING-RULES.md`:45 |
| standing rule 7 theorems heading | `plans/STANDING-RULES.md`:49 |
| standing rule 7 planted faults | `plans/STANDING-RULES.md`:51 |
| standing rule 7 drafts name their slot | `plans/STANDING-RULES.md`:55 |
| standing rule 8 no agent ids | `plans/STANDING-RULES.md`:57 |
| standing rule 8 fences | `plans/STANDING-RULES.md`:60 |
| standing rule 9 slots | `plans/STANDING-RULES.md`:66 |
| standing rule 9 exit statuses | `plans/STANDING-RULES.md`:70 |
| standing rule 9 kill by pid | `plans/STANDING-RULES.md`:72 |
| standing rule 9 halt on crash | `plans/STANDING-RULES.md`:74 |
| standing rule 10 reading status | `plans/STANDING-RULES.md`:80 |
| standing rule 11 the report's form | `plans/STANDING-RULES.md`:95 |
| standing rule 12 budget | `plans/STANDING-RULES.md`:101 |
| Keryx: before the first milestone | `.claude/output-styles/keryx.md`:231 |
| Keryx: kernel closes milestones | `.claude/output-styles/keryx.md`:327 |
| Keryx: claim list fixed first | `.claude/output-styles/keryx.md`:304 |
| Keryx: planner launched beside the derivation, fenced | `.claude/output-styles/keryx.md`:311 |
| Keryx: defects routed at once | `.claude/output-styles/keryx.md`:315 |
| Keryx: numbers fixed in advance for parallel milestones | `.claude/output-styles/keryx.md`:331 |
| Keryx: slots default | `.claude/output-styles/keryx.md`:284 |
| Keryx: models | `.claude/output-styles/keryx.md`:286 |
| Keryx: replace past ~500k | `.claude/output-styles/keryx.md`:289 |
| Keryx: drafts filed verbatim | `.claude/output-styles/keryx.md`:348 |
| Keryx: the Clerk's filing in a worktree | `.claude/output-styles/keryx.md`:359 |
| Keryx: the search queue | `.claude/output-styles/keryx.md`:374 |
| Keryx: report at a gate or check-in | `.claude/output-styles/keryx.md`:397 |
| Poros: questions only through Keryx | `.claude/agents/poros.md`:204 |
| Poros: does not derive | `.claude/agents/poros.md`:266 |
| Poros: structural form | `.claude/agents/poros.md`:240 |
| Ephodos: the reframe before any route | `.claude/agents/ephodos.md`:319 |
| Ephodos: §G every entry by body | `.claude/agents/ephodos.md`:340 |
| Ephodos: claim list stands alone | `.claude/agents/ephodos.md`:391 |
| Ephodos: recognition first | `.claude/agents/ephodos.md`:397 |
| Ephodos: every derived claim crosses to Lean | `.claude/agents/ephodos.md`:433 |
| Ephodos: does not re-rank | `.claude/agents/ephodos.md`:476 |
| de Bruijn: blind phase 1 | `.claude/agents/debruijn.md`:206 |
| de Bruijn: findings at once | `.claude/agents/debruijn.md`:224 |
| de Bruijn: our results as hypotheses | `LEAN.md`:37 |
| de Bruijn: the plan is the hand-off | `.claude/agents/debruijn.md`:233 |
| implementer: never change a statement | `.claude/agents/debruijn-implementer.md`:204 |
| implementer: green manifold | `.claude/agents/debruijn-implementer.md`:196 |
| Searcher: choose, don't run everything | `.claude/agents/searcher.md`:12 |
| Searcher: the certificate, not the search | `.claude/agents/searcher.md`:26 |
| Clerk: copy, never judge or guess | `.claude/agents/clerk.md`:20 |
| LEAN: imports' four items | `LEAN.md`:22 |
| LEAN: never lake build | `LEAN.md`:78 |
| LEAN: lake env lean is not the check | `LEAN.md`:88 |
| LEAN: every module from the root | `LEAN.md`:157 |
| LEAN: the vacuity scan | `LEAN.md`:168 |
| LEAN: a named inhabitant | `LEAN.md`:183 |
| LEAN: gates keep their output | `LEAN.md`:188 |
| RUNNING: halt on a crash | `RUNNING.md`:25 |
| RUNNING: checkpoint long runs (PROTECTED) | `RUNNING.md`:44 |
| RUNNING: a blocking run is killable (PROTECTED) | `RUNNING.md`:60 |
| RUNNING: kill by pid, verify by effect | `RUNNING.md`:74 |

Commit: `4ab00b3` (new repository).

## Stage 6 — SAVED (the report)

The report is `data/am/reports/AM1-EX1.md` (written, not committed, as the brief's `touches:` says), in the standing rules' form,
and the same text is the hand-back.
