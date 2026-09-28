# Session handoff — 2026-09-28, Workflow 3.0 merged; the test drive is next

*Written by the top-level session at ~21:00 UTC, 2026-09-28, before Kooshi compacts it. For whoever reads it next with no memory of
the day, most likely this session after its compaction. Current state only. The FS-114 and FS-111 detail stays in their close
inventories and in `plans/SESSION-HANDOFF-2026-09-26.md` item "0-morning"; this file does not retell it.*

## 1. Read first

1. **Who you are.** You are the top-level session, and since today its identity is **Keryx**, the coordinator. Check your system
   prompt for the heading `# Keryx in lean-dir — the workflow`.
   - **If it is there**, the output style loaded (`.claude/output-styles/keryx.md`, selected in `.claude/settings.json`). Your
     identity and your workflow are in force.
   - **If it is not**, this session started before the style existed. Claude Code reads style files only at startup, so a
     compaction alone does not load it. Read `.claude/output-styles/keryx.md` in full now, work from it, and tell Kooshi that a fresh
     session is needed for the style to load itself.
2. **Check the agent types.** The Agent tool's list of agent types must include `poros`, `ephodos`, `ephodos-verifier` and
   `debruijn`. If it lists only the old ones (`ferrous-engineer`, `general-purpose`, …), this session loaded its agent list before the
   files existed. Then the test drive needs a fresh session. Do not fake it by giving a general-purpose agent an identity file:
   that is the setup Kooshi replaced today.
3. **Then report to Kooshi.** His words at the handoff: *"Next, I'll compact, and you can take it for a test drive on the next
   milestone. Hopefully, after compaction, you get all the fresh files too. Give me a report when you load in."* Say:
   - what loaded (the style, the agent types, CLAUDE.md without the WORKFLOW import);
   - the state of FS-114 and FS-111 (§3);
   - the test-drive choice (§4), with your recommendation.

## 2. What changed today (all merged: `main` = `64a47e97`, pushed; branch `keryx-pipeline` merged, worktree removed)

Kooshi, in order, verbatim:
- *"The main agent will be the herald. Efodos, Poros, and de Bruijn will be agent files instead of ad-hoc general purpose agents. Each
  will have their own non-overlapping workflow with their own loop, exercising their own skills, which will also be imported to
  `.claude`. This will clean up and hopefully improve our flow. Anything which is duplicated by the agent IDs or skills can be removed
  from our workflow files."*
- *"The new standard top level workflow will be Poros, asking the question, then Efodos answering it, then de Bruijn formalizing it.
  These can all be pipelined, so 3 agents will be running, with Poros scouting ahead, Efodos blazing the trail, and de Bruijn paving
  irmt behind them, all quite independent. Efodos cab still have multiple stages, and will have verification versions of itself running
  after new theorems, also possibly in parallel to it."*
- *"Yes, move all duplicated workflow steps, and generally split the whole workflow into the separate agent files. The workflow
  sections should go beneath the verbatim identities if they can't be in separate files loaded with @."*
- *"The main branch should be silent. Those milestones landed within the past few hours."*

The result, as it stands on `main`:

| mind | the one file it loads (identity verbatim, then its lean-dir workflow) |
|---|---|
| Keryx, the top-level session | `.claude/output-styles/keryx.md` |
| Poros, ask, scouts ahead | `.claude/agents/poros.md` |
| Ephodos, derive, blazes the trail | `.claude/agents/ephodos.md` |
| Ephodos, a blind second mind | `.claude/agents/ephodos-verifier.md` (also preloads `ephodos-verification`) |
| de Bruijn, formalize, paves behind | `.claude/agents/debruijn.md` (also holds the Lean-only sections moved out of `CLAUDE.md`) |

- **Identities.** They are imported unchanged from `~/source/agent-forge` (commit `6b47dbd`) into `.claude/skills/`.
  - `python3 scripts/identities.py check` holds each copy to its skill; `sync` re-copies after an update; `--self-test` plants two
    faults.
  - The four core skills are hidden from the model's skill list (`skillOverrides`), so no mind loads a second identity.
- **CLAUDE.md** no longer imports `WORKFLOW.md`, and holds a shared map (§ The pipeline). `WORKFLOW.md` is an index loaded by no one.
  `DEBRUIJN.md` is deleted.
- **The rules every brief shares** are `plans/STANDING-RULES.md`. It passes Keryx's brief gate, and a copy without rule 1 fails it.
- **Head-count**: three agents at once, one per lane, plus Ephodos verifiers in parallel; a competition or a crunch needs Kooshi's
  word (`CLAUDE.md` § Delegation, and Keryx's § Staffing).
- **Probes run today:** 6 one-turn headless runs on the cheapest model, plus one cold-read reviewer earlier.
  - `@` imports do not expand in agent files or output styles.
  - A fresh session on the branch saw Keryx's workflow heading.
  - A `poros` agent run with the style off saw only its own identity.
  - `claude --agent <lane>` as a main session also gets Keryx's style, unless `--settings '{"outputStyle":"default"}'` is passed
    (`WORKFLOW.md` says so).

## 3. The state of the science (read the sources; this is only a pointer)

- **FS-114 (the unit-arc question) and FS-111 (the cone scale) are OPEN.** Their jobs all finished this morning; the last, FS114-YB5,
  reported at 09:02. **Neither has a close**: `CLAUDE.md` § Frontier still reads "Last updated: 2026-09-27 — FS-112 … closed".
- Every result, ruling and slip is in `plans/FS114-close-inventory.md` (items 1–120) and `plans/FS111-close-inventory.md` (items 1–37).
  The morning state and the next steps planned then are `plans/SESSION-HANDOFF-2026-09-26.md` item "0-morning": a blind check of
  N7-HUB, then round 7 (OC, (Q)-rings, E1/E2). Items 118–120 of FS-114's inventory hold the held items (N7's reading R-E2, YB5's GAPs).
- **A file to rescue at FS-111's close:** `data/fs111/fs111-w/{blocks,hex7_free,hx_pairs}.out` are untracked outputs of job FS111-W,
  written 02:06–02:38. They are small, and later jobs noticed their names but never committed them. Check the FS111-W record
  (`plans/FS111-W-wild.md`) for citations; commit or decline them with a reason.
- **The search ban runs to 2026-10-01** (`CLAUDE.md` § Toolchain).

## 4. The test drive — the choice to put to Kooshi

| option | what it exercises | recommendation |
|---|---|---|
| **A. Close FS-114 and FS-111 under the new close path** | An Ephodos close job per milestone (the derivation file, stubs, drafts of the front page), then a Poros re-read and draft re-rank, then Keryx filing verbatim in one closing commit. The FS111-W rescue. Then Poros poses the next milestone's question from the re-ranked frontier. | **Recommended**, medium-high: the closes are owed anyway, they exercise the most new machinery, and a close is where the old workflow's gaps (drafts no lane wrote) showed |
| B. Continue FS-114's round 7 first | Ephodos derivation jobs and blind verifiers on a frozen claim list; the new fences | If Kooshi judges FS-114 not landed |
| C. Open the next ranked milestone now, leaving the closes for later | Poros scouting, the Ephodos opening (the reframe), freezing a claim list | Only if Kooshi wants the opening path tested first; it leaves two milestones unfiled |

Whatever runs, **register as instruments before the first brief** (scored at the test drive's close):
- whether a lane agent had to ask a question its file should have answered;
- whether any brief failed Keryx's gate;
- whether `derive_gate.py`'s path rule (addresses from the record's own folder) bit anyone;
- whether a verifier's fence held.

Every friction goes in the inventory, as a candidate edit to the lane's file.

## 5. Rules in force that are easy to miss after a compaction

- Brief by agent type (`subagent_type: "ephodos"`, and so on), with the brief on disk in the `keryx` skill's header form, gated with
  `python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`. Name `plans/STANDING-RULES.md` in every brief.
- Nothing about an open milestone goes into the auto-memory: its index reaches every agent at launch, blind ones included.
- You coordinate and do not author. Lanes draft; you file verbatim.
- Push freely to origin; never force-push.
- Commit subjects stay neutral from the first blind job on.
- Check `date` before logging any time.
- Budgets in briefs are guidance; replace an agent past about 500k tokens by the harness's count.
