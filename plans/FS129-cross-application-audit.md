# FS-129 — the cross-application audit: the plan

*Opened 2026-10-03 by Keryx, the coordinator, from Kooshi's decisions of the same day (§ 1). Keryx writes this file; each job writes only
its own record and data (§ 6). The question card, the bearing on the answer and the registered expectations are the lanes' (§ 3, § 7);
the method, the passes and the staffing below are Kooshi's decisions, recorded. The stub, `plans/STUB-cross-application-audit.md`, holds
the request and the context; the inventory is `plans/FS129-close-inventory.md`.*

## 1. Kooshi's words

**The request** (2026-10-03 17:56 UTC): verbatim in `plans/STUB-cross-application-audit.md` § The request.

**The decisions** (2026-10-03, about 22:35 UTC, verbatim), answering four questions Keryx put to him that turn:

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.

The four questions, in Keryx's words (condensed from its message of that turn; Keryx's text, not Kooshi's):
1. **Order of the passes**: open steps first, then mechanisms, then merges and strengthening — rather than the supply-side reading the
   request's wording suggests (each theorem asking "where else do I apply?"), which is thorough but mostly housekeeping. Never pairwise:
   about 1,300 theorems make about 850,000 pairs.
2. **Staffing**: within the cap of three agents at a time; the Clerk builds the index first, then Poros's question card, then two Opus
   readers in parallel split by era; a crunch only if the index shows the candidate count needs it.
3. **The Lean backlog**: the audit prepares its input — the build order from the dependency map, and the merged and strengthened
   statements — so that the backlog formalizes each statement once, in its strong form.
4. **Reach across eras**: ask explicitly whether any arithmetic-era result (number fields, residue planes, finite planes) bears on the
   measurable question, rather than confining each reader to its era.

## 2. The corpus (measured 2026-10-03 22:36 UTC; the index job re-counts)

| pile | count | re-count with |
|---|---|---|
| derivation files, `plans/*-derivation.md` | 99 files, 2.9 MB | `ls plans/*-derivation.md \| wc -l` |
| theorems indexed in `LEDGER.md` § B (every milestone through FS-116 and FS-121, so every theorem derived so far) | 1,297 lines | `awk 'NR>=195' LEDGER.md \| grep -cP '^\s*[-\|]'` |
| entries in the block format (`derivation:` with `statement:`, `uses only:`, `not claimed:`, `grade:`, `minds:`, `handoff:` …), from late September on | 292; verdicts: 267 derived, 20 gap, 3 refuted, 2 stalls | `cat plans/*-derivation.md \| grep -cP '^derivation: '` |
| "Rests on it" paragraphs (what each result feeds) | 1,304, in 78 files | `grep -oF 'Rests on it' plans/*-derivation.md \| wc -l` |
| files with no "Rests on it" paragraph (their dependents come from other files' `uses only:` lines) | 21 | `ls plans/*-derivation.md \| grep -vF -f <(grep -lF 'Rests on it' plans/*-derivation.md)` |
| `handoff:` lines naming de Bruijn (the results whose next stop is Lean) | 77 | `grep -ohP '^\s*\**handoff:?\**.*' plans/*-derivation.md \| grep -ciP 'de ?bruijn'` |
| ledger rows | 148 | `LEDGER.md` § A |
| grokkings | G1–G91 | `.claude/skills/grokkings/SKILL.md` |
| questions the literature poses | 83 KB | `CLOSED-QUESTIONS.md` |

Two formats coexist: the block format above, and the older milestones' (`T1`, `T2`, … entries; FS-73's `T1–T38`, for one).
`tools/fs71_ledger_b_check.py` (the census checker) already parses every derivation file against § B (`parse_entries`,
`parse_new_entries`, `parse_ledger_b`); the index starts from its parser.

## 3. The shape: one index, three passes, then the record

**Stage 0 — the index** (the Clerk, FS129-IX1). Mechanical: no judgement, no mathematics. A script, `tools/fs129_index.py`, with a
negative control (`RUNNING.md` § Make the gate fail, and watch it fail), writes `data/fs129/index/`:
- `theorems.jsonl`, one record per § B theorem: its id; milestone; era (§ 5); derivation file and line; its statement and *not claimed*
  line verbatim; grade; minds; verdict; `uses only:` ids; "Rests on it" ids (and the paragraph's text where it names no id); `handoff:`;
  the ledger rows and grokkings that cite it;
- `edges.csv`, the dependency graph (an edge from a result to each result that uses it), from both directions of the record;
- `orphans.md` (results nothing uses), `hubs.md` (results by count of dependents, direct and transitive);
- `open-steps.md`, the mechanical half of the demand list: every entry whose verdict is `gap`, `stalls` or `refuted`, every "stalls at"
  and every GAP named in a derivation file or a ledger row, each with its address;
- `grokking-uses.md`: for each grokking, the theorems and milestones that cite it, and the era by majority;
- `lean-order.md`: the 77 results handed to de Bruijn and everything they rest on, in an order where each comes after what it uses;
- `statements-<era>.md`: the statements alone, one per line with id and address, so that a reader can scan an era's statements without
  opening 2.9 MB of files.

Anything the script cannot parse is listed with a `CHECK:` line, never guessed. Keryx checks five records by hand against their
files before stage 2 launches, and logs which in the inventory.

**Stage 1 — the question card** (Poros, FS129-Q1, beside stage 0). Poros writes the stub's `## The question (Poros, <date>)` and its
bearing on the answer, as its workflow sets out. It also writes the **demand list's judged half**: the open questions in the ranked
stubs that bear on the answer (the top of `plans/FRONTIER-STUBS.md` — FS-123, FS-124, FS-104 — and the successors FS-125–FS-128 and
FS-117, FS-115, FS-122), ranked by bearing, each stated as a step to close, with its address. Pass 1 works the merged list in that order.

**Stage 2 — pass 1, open steps: "finding new paths"** (two readers, FS129-OA1 and FS129-OR1). For each step on the demand list, in
Poros's order, ask which held result closes it, shortens it, or reduces it to another; derive each composition that does; record each
null. Each reader owns one era's held results (§ 5) and reads the **whole** demand list against them — so the arithmetic-era reader is
the one who asks whether a field, residue-plane or finite-plane result bears on the measurable question (decision 4).

**Stage 3 — pass 2, mechanisms: "interweaving"** (FS129-MA1, FS129-MR1). For each grokking the reader owns (by era, from
`grokking-uses.md`), every place its mechanism is used, and every place across the whole corpus where it bears and was not applied —
the failure that prompted the audit (FS116-Y4: G83's straddle held and not applied to the double tip, `plans/FS116-close-inventory.md`
items 122, 124, 127). Closed forms and identities are mechanisms too: V6-HUG (`plans/FS116-V6-verification.md` § 2.2) and Kooshi's
"where else can we use that identity?" (`plans/FS116-close-inventory.md` item 142) are this pass's.

**Stage 4 — pass 3, merges and strengthening** (FS129-SA1, FS129-SR1). Statements that are one statement; hypotheses that can be
weakened, with the weaker form derived; grades a second route already earns, under the grade rules of the time the result was filed;
records that disagree (FS-116 item 136: two records state differently what FS-112's bends leave on a ring). **Scoped first to the Lean
backlog**: everything in `lean-order.md` before the rest, so that de Bruijn formalizes the strong merged form once.

**Stage 5 — the record** (FS129-Z1, and FS129-Z2 if the record passes about fifty theorems). `plans/FS129-derivation.md`, every
composition and strengthening an entry in the block format; the "where else" lines (deliverable 1) folded into the index as a column; new
stubs; drafts of the front page (ledger rows, Frontier lines, grokking instances). Then FS-129 is **Derived**.

**Stage 6 — the Lean backlog's input** (the Clerk, FS129-L1) and **the re-rank** (Poros, FS129-P1), in parallel. FS129-L1 writes
`plans/LEAN-BACKLOG.md`: `lean-order.md` with stage 4's merges applied, each statement quoted by script from its derivation file, each
with its *not claimed* line and its upstream ids. FS129-P1 re-ranks `plans/FRONTIER-STUBS.md` with the new stubs. Keryx files both.

**Closed** when the compositions FS-129 derived pass the Lean gate — in the Lean backlog's session, which takes them as part of its
queue (Workflow 3.1: a milestone closes in Lean).

## 4. Staffing (Kooshi's decisions 2 and 3)

- **At most three agents at a time**, the Searcher included.
- **The readers and the record job are `general-purpose` agents on Opus** (`model: "opus"` in the launch), not the `ephodos` agent
  type, whose file preloads the grokkings in full. Each brief's first instruction: read `.claude/skills/ephodos/SKILL.md` in full (the
  deriver's identity; the core skills are hidden from the skill list, so it is read as a file, not loaded with the Skill tool), then
  `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end (the lane's workflow: `## A derivation job`,
  `## What leaves your lane`, `## The record job`), and the companions as the work calls for them — `ephodos-recognition` is the one this
  audit's question names ("a known theorem almost applies"). The grokkings are read by number from `.claude/skills/grokkings/SKILL.md`
  when needed, never in full by default.
- **The Clerk** (`clerk`, Sonnet) for the index and the Lean backlog's input. **Poros** (`poros`, Opus) for the card and the re-rank —
  its agent file loads the grokkings, which ranking needs; Kooshi's decision 2 named the readers.
- **No mind starts another.** `general-purpose` agents carry the Agent tool, which the agent files withhold; `.claude/settings.json`
  caps nesting at one level (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH: "1"`), and every brief carries `plans/STANDING-RULES.md` rule 1.
- **Budget**: about 300k tokens by the harness's count per job, as guidance; hand back at a saved stage before about 500k. The two era
  lanes run independently, each pass a fresh agent briefed from the previous pass's record; a reader that hands back well below the line
  may be continued into its lane's next pass, at Keryx's call.

## 5. The era split

- **Arithmetic era** (lane A): the held results of milestones through FS-103 — fields, residue targets, finite planes, measure rigidity,
  the collapse; and the kernel library's arithmetic modules.
- **Regularity-wall era** (lane R): FS-104 on — the measurable question, maps, rings, arcs, saturation.

The boundary is by milestone number; the index tags each theorem, and a theorem the index cannot place goes to `CHECK:`. Each lane owns
its era's held results and grokkings, and reads the whole demand list and the whole corpus against them.

## 6. The jobs

| job | lane | type and model | launch | writes |
|---|---|---|---|---|
| FS129-IX1 the index | — | `clerk`, Sonnet | first | `tools/fs129_index.py`, `data/fs129/index/`, `data/fs129/reports/FS129-IX1.md` |
| FS129-Q1 the question card | ask | `poros`, Opus | beside IX1 | the stub's question section and bearing; `data/fs129/demand-judged.md`; its report |
| FS129-OA1, FS129-OR1 pass 1 | A, R | `general-purpose`, Opus | after IX1 and Q1, and Keryx's spot check | `plans/FS129-OA1-audit.md` / `-OR1-`; `data/fs129/oa1/` / `or1/`; reports |
| FS129-MA1, FS129-MR1 pass 2 | A, R | `general-purpose`, Opus | after its lane's pass 1 | `plans/FS129-MA1-audit.md` / `-MR1-`; data; reports |
| FS129-SA1, FS129-SR1 pass 3 | A, R | `general-purpose`, Opus | after its lane's pass 2 | `plans/FS129-SA1-audit.md` / `-SR1-`; data; reports |
| FS129-Z1 (Z2) the record | derive | `general-purpose`, Opus | after both lanes' pass 3 | `plans/FS129-derivation.md`, new stubs, drafts; the index's where-else column |
| FS129-L1 the backlog's input | — | `clerk`, Sonnet | after Z1 | `plans/LEAN-BACKLOG.md` |
| FS129-P1 the re-rank | ask | `poros`, Opus | after Z1, beside L1 | the draft re-rank |

Briefs at `data/fs129/briefs/<job id>-<slug>.md` in the keryx header form, statements copied by script
(`data/workflow3/brief_quote.py`), each gated (`python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`) before launch. Every
brief names `plans/STANDING-RULES.md`; IX1's and L1's also `RUNNING.md`. One writer per file: the index is IX1's until Z1 adds its
column; the readers write their own records and data only; the one-writer files of `CLAUDE.md` § The pipeline stay Keryx's. No fences:
nothing in this audit is blind (Workflow 3.1).

## 7. Grades, expectations, failure

- **Grades.** A composition the audit derives is "derived, one mind" until its Lean module passes; a held result keeps the grade and
  mind count it was filed with. A grade "promoted" in pass 3 is promoted only where a second route is already on record and meets the
  rules of the time the result was filed; otherwise it is listed for the Lean backlog, which is now the promotion path.
- **Expectations.** Each reader registers, in its record's first saved stage and before reading the corpus: how many compositions, nulls,
  merges and new stubs it expects, and its probability that its lane moves the answer's bearing. Poros registers the card's. Keryx copies
  the ones that decide what runs next into the inventory.
- **Failure is a result.** A step on the demand list with no held result bearing on it is recorded as a null with what was read;
  "searched the arithmetic era for a bearing on the measurable question, found none" is a finding (decision 4). A step a search could
  decide is a `search request` for `plans/SEARCH-QUEUE.md`; no job searches.
