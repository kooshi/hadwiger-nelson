# Brief FS129-Q1 — FS-129's question card, and the ranked list of open steps the audit's readers will work

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-Q1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow; invoke `poros-anomaly-hunt` or `poros-reframing` fresh with the Skill tool if your loop dispatches to them
  role: the ask lane at FS-129's opening — the question card in the stub, the bearing on the answer, and the demand list's judged half
  launch: now, beside FS129-IX1 (the Clerk's index of every derived theorem), which writes different files
  mission: § Why this job
  statements: § The question as posed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1), and no blind job is running
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around; the report goes to `data/fs129/reports/FS129-Q1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-03-fs129-card.md`
  touches: `plans/POROS-2026-10-03-fs129-card.md`, `plans/STUB-cross-application-audit.md` (its question section, new, and its section "Bearing on the answer", rewritten in place; nothing else in it), `data/fs129/demand-judged.md`, `data/fs129/reports/FS129-Q1.md`
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k

Hello. You are Poros, opening a milestone unlike the others: it asks no question of the plane directly. It asks, of everything this
project has already derived, where each result bears beyond the milestone it was derived for. Your card decides what the audit's
readers look for first, and your ranked list of open steps is the order they work in.

## Why this job

Kooshi asked for the audit on 2026-10-03, and decided its method the same day; both are quoted under § The question as posed. His
decision 1 sets the order of the passes — open steps first ("finding new paths"), then mechanisms ("interweaving"), then merges and
strengthening — and decision 4 asks, explicitly, whether any arithmetic-era result (number fields, residue planes, finite planes) bears
on the measurable question. The plan, `plans/FS129-cross-application-audit.md`, lays out the stages; **read its § 3 (Stage 1 is yours)
and § 7 (grades, expectations, failure)**. The stub, `plans/STUB-cross-application-audit.md`, holds the request, the four instances that
prompted the audit (§ Why now), and the precedents.

The readers who follow you are `general-purpose` agents on Opus that read the deriver's identity but not the grokkings in full (Kooshi's
decision 2), split by era: lane A owns the held results of every milestone through FS-103, lane R those of FS-104 on (plan § 5). Each
reads the whole demand list against its own era's results. Your list is the one place their search is aimed by someone who holds the
whole theory at once.

## The question as posed

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

The four questions those answers reply to are in the plan's same section, in the coordinator's words.

## What you work from

- The stub and the plan, above.
- The ranked stubs, `plans/FRONTIER-STUBS.md`, and the stubs the plan names for the demand list: FS-123
  (`plans/STUB-qfree-ring.md`), FS-124 (`plans/STUB-q-ring.md`), FS-104 (`plans/STUB-cp-plane-six.md`), FS-125
  (`plans/STUB-saturated-local.md`), FS-126 (`plans/STUB-curved-pencils.md`), FS-127 (`plans/STUB-lateral-extent.md`), FS-128
  (`plans/STUB-top-colour.md`), FS-117 (`plans/STUB-route-t-count.md`), FS-115 (`plans/STUB-stuck-ray.md`), FS-122
  (`plans/STUB-forced-pair.md`).
- Your last record, `plans/POROS-2026-10-03-close-reread.md`, whose hunch ledger you carry forward.
- `CLAUDE.md` § The aim and § Where the problem stands, item 31, for what "bearing on the answer" means now; `LEDGER.md` by row.
- The Clerk's index will land at `data/fs129/index/` while you work (its `data/fs129/index/open-steps.md` is the mechanical half of the demand list: every
  `gap`, `stalls` and `refuted` verdict in the record). You need not wait for it; if it is there when you rank, use it, and say so.

## Done means

1. **The card in the stub**: a section `## The question (Poros, 2026-10-03)` in `plans/STUB-cross-application-audit.md`, after
   § Method and staffing, with `### The card` in your identity's grammar, `### Existence form` and `### Structural form`, as your lane's
   workflow sets out (`.claude/agents/poros.md` § Your jobs, job 1). If no structural form comes for an audit, write "no structural form
   yet" and why. The stub's section "Bearing on the answer" rewritten in place (the coordinator's provisional line replaced).
2. **`data/fs129/demand-judged.md`**: the open steps in the stubs above that bear on the answer, ranked by bearing, each stated as a
   step to close — quoted verbatim from its stub with its address where the stub states it, your own words labelled as yours where it
   does not — with one line on its bearing. Add any open step from elsewhere in `plans/FRONTIER-STUBS.md`, or from the arithmetic era,
   whose bearing earns it a place, saying why. Where you can, name for a step which grokkings or held results you would read first;
   label that as a hunch, scored later.
3. **Registered expectations** in your record's first saved stage, before you read the stubs for the list: how many steps you expect
   the readers to close or shorten, how many nulls, and your probability that the audit moves the bearing on the answer — and,
   separately, your probability that the arithmetic era bears on any regularity-era step (decision 4).
4. **Your record**, `plans/POROS-2026-10-03-fs129-card.md`: the evidence inventory, the hunch ledger carried forward, the
   `Invention signal:` line, every card; gated with `python3 .claude/skills/poros/scripts/poros_gate.py all <record>` before each stage's
   commit; and the heading "Theorems this phase proved" with the line saying it proved none.
5. The report, in standing rule 11's form.

## What is yours to decide

The card, its forms, the ranking and its criteria, which stubs to read most closely, and whether the demand list should carry steps the
plan did not name. If the plan's shape — the passes, their order, the era split — looks wrong from where you stand, say so with the
reason: a frame correction at the opening is the cheapest one this audit will get, and it goes to Kooshi through the coordinator.

## Your first stage: the readback

Check both quotations above against their sources, and restate in your record, in your own words, what the demand list is for and who
reads it. A mismatch is a finding about this brief.

## Gate note (the coordinator's)

The brief gate fails this brief twice, on `data/fs129/index/` and `data/fs129/index/open-steps.md`: they do not exist yet because
FS129-IX1, launched beside you, writes them. The gate accepts a path that exists or that the recipient writes, and has no case for a
path a parallel job writes. Judged false; filed in agent-forge (its STATUS file under forge/, the Keryx section) with this brief as the repro.
