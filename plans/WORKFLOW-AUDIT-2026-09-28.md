# Workflow audit — ceremony and accounting against value (2026-09-28)

*Written by Keryx at Kooshi's request, 2026-09-28: "I'd like to lighten our load if possible. Our workflow has become long, bureaucratic,
and complex. … audit both, and retire any workflow grokkings into their own file, recorded but not always loaded, and report what parts
of the workflow are ceremony and accounting rather than value." One mind (the coordinator auditing its own workflow), from the record;
nothing below is filed as a change except § 1. Every number is read from the address beside it.*

## 1. Done: seven workflow grokkings retired

Moved verbatim to `plans/GROKKINGS-WORKFLOW.md` (23,290 bytes), each leaving in `CLAUDE.md` its number, title, original status tag and
one line naming where its content is now carried: G30, G46, G49, G50, G51, G67, G72, and the paragraph that opened § Grokkings.
`CLAUDE.md` went from 295,069 to 274,901 bytes. `tools/claude_md_fact_audit.py` now joins the new file to its corpus (`--retired`);
the audit passes with 0 failures, and `--dupes` reads 20 repeated runs. One operative clause was added where it had no workflow home:
G50's "read every held-but-unread paper whose title touches the milestone" is now in `.claude/agents/ephodos.md` §PA.

Kept loaded, with the reason:
- **G21** (a negative measures its enumeration): a rule about reading evidence, used mid-work by every mind that measures; only its
  planting half is in the standing rules. Returns to full use when the search ban lifts on 2026-10-01.
- **G79** (walls arrive as a counterexample's invariant): a move made during a derivation; the workflow holds only its close-time
  count. FS-114's close found it "should have borne and was used late" (`plans/FS114-C-close.md` §4.1), FS-111's that it "paid most".
- **G87** (the invention signal): added this afternoon so that every mind is on the lookout.
- **G58, G65**: instruments of the domain, not the workflow.

The one operative clause the retirement leaves unloaded: G30's "prefer a dial … over a search for a positive". It matters again when
searches return after 2026-10-01.

## 2. What the record says pays

| part | evidence it pays | address |
|---|---|---|
| A blind second mind, fenced, verdicts committed before comparing | a divergence of truth in every FS-114 round; three in FS-111, each before anything was filed | `plans/FS114-C-close.md` §4.1 row 13; `plans/FS111-C-close.md` §4.1 X18 |
| Statements fixed word for word, quoted by script | the coordinator's summaries dropped or widened a clause six times in FS-114 before scripting; none after | `plans/WORKFLOW3-test-drive.md` F8 |
| The structural question (Poros's card, Ephodos's §IQ) | 18 of 21 derivation milestones' results came through it; both last milestones' products did | `plans/GROKKING-INSTANCES.md` §G72; both closes §4.2 |
| Poros's boundary re-read at a close | caught two overstatements in the closes' drafts before filing | test drive F11 |
| The prior-art search at the opening | FS-111's C^{1,1} step came from it (Rataj–Zajíček, Walther); historically `[Fischer1994]` | `plans/FS111-C-close.md` §4.1 X8 |
| The re-grokking's *bears* lines, turned into phase instructions | 10 of 15 extractions paid in FS-114, 12 of 18 in FS-111 (one misfired) | both closes §4.1 |
| Saved stages, committed | a halt costs a stage, never a job; cheap | standing rule 2 |

## 3. Ceremony — the form has outlived its purpose, or costs well above what it returns

| part | cost | what it returned | proposal |
|---|---|---|---|
| **A written verdict for every entry in the re-grokking walk, "silent" ones included** | about 27 KB per plan (FS-114: 28,376 bytes; FS-111: 26,492); FS-114 wrote 196 "silent" lines against 60 "bears"; every ledger row walked (about 140) | the *bears* lines paid (§2). The one real miss, G54 in FS-111, came from walking once while the object changed, not from skipping an entry | write reasons only for *bears* and *falsifiable here*; name the silent entries by number on one line; walk the ledger rows the stub cites plus the last close's; re-walk when the milestone's object changes (the finding of FS-111's close, test drive F9(6)) |
| **Running counts of method rules** (G72's "18 of 21", G79's record, G67's killing-test tallies) | a sweep in every close; two closes incremented G72 from the same base and collided | the rules are settled by their own counts | stop counting; record only a counterexample to a rule |
| **Registered predictions for every phase, with probabilities, scored at the close** | FS-114: nineteen plan predictions (7 met, 9 not met, 3 never reached; Brier 0.134) and eight job predictions, five never scored because the mind that would score them never ran (`plans/FS114-C-close.md` §4.5) | a calibration reading (the misses were the ambitious ones, priced low) and one informative miss (E1); FS-111's exposed a generator defect (X4). No recorded decision any of them changed. The exact checks at named values in the same table are controls, not predictions, and they pay | register only a prediction whose outcome decides what runs next (launch, stop, or re-route), a handful per milestone |
| **The "would have searched here" log** | a section in every record | its purpose was the ban's | let it lapse with the ban on 2026-10-01 (standing rule 5 already says so) |
| **The brief gate's path checks** | three of five briefs and one amendment failed on first run in the test drive, every time on a path check (a directory prefix, a relative address, a record not yet written), never on a quotation (test drive I2, F3) | the quotation check is the half that catches real errors | keep the quotation check; fix the path checks upstream (agent-forge) or drop them |

## 4. Accounting — bookkeeping that records rather than decides; the largest cost

| part | cost | proposal |
|---|---|---|
| **One theorem written four to six times**: the job record's entry and its "Theorems this phase proved" line; the close's derivation file (FS-114: 80,663 bytes; FS-111: 96,324 — about three times the old one-paragraph shape, test drive F9(2)); one § B line in `LEDGER.md` (§ B is now 255,858 bytes); the Proof Atlas facts; the ledger row; the Frontier summary item. A census checker exists to keep the copies in step | the derivation file is the one home. Drop the "Theorems this phase proved" heading (a record's entries are already the list) and `LEDGER.md` § B (generate an index by script when one is wanted). Keep each entry's `handoff:` line: it is the queue of what must be formalized before anything is published |
| **The close itself**: two milestones' closes took five agents at 320k–600k tokens each, and the filing agent asked twelve questions because drafts did not name their slots | shrinks with the line above and the two below; price a close from its theorem count |
| **The close inventory**: FS-114's is 96,988 bytes for 122 items; 25 inventories hold 1.2 MB | one line per item, no narration |
| **The ranked list of future milestones**: about 95 table rows and 114 stub files (`plans/FRONTIER-STUBS.md`, 148,125 bytes), re-ranked in full at every close, and its top 29 rows copied into `CLAUDE.md` (13,248 bytes loaded into every agent) | re-rank only the top five at a close; the tail keeps its last rank; in `CLAUDE.md` keep the top five rows and a pointer |
| **"Where the problem stands"**: 31 numbered items, 19,789 bytes loaded into every agent, rewritten at each close | keep the items that bear on the current aim (the regularity wall and the measurable question); send the rest to the ledger rows they summarize |
| **`plans/GROKKING-INSTANCES.md`**: 101,410 bytes of second and later instances, drafted at each close | file an instance only when it changes the rule's wording or its *Do* |
| **The Proof Atlas refreshed at every close** | Kooshi uses it to pick targets, so it stays; it caused two frictions in the test drive (F1, F13). Generate its facts from the filed ledger rows instead of having the close draft them |

## 5. Loaded into every agent though one lane needs it

Every agent, the Clerk included, loads all of `CLAUDE.md`: a Sonnet agent launched with nothing to read measured 148k tokens, most of
it this file (`.claude/agents/clerk.md` § What the history added); TB1's launch context was about 165k (test drive F7).

| section | bytes | who needs it | proposal |
|---|---|---|---|
| § Make the gate fail, and watch it fail | 20,501 | whoever builds an instrument or a checker | move to a file the lanes that build tools read (de Bruijn's workflow; a derivation job's brief when it builds a tool), leaving the unifying rule and a pointer |
| § Building | 10,823 | whoever runs a long process | the same; two of its paragraphs are **PROTECTED**, so moving them verbatim is Kooshi's call, not the coordinator's |
| § Toolchain | 9,246 | whoever runs a solver or a build | the same |
| § Grokkings | about 143,000 after the retirement | Ephodos and Poros reason from it; de Bruijn and the Clerk rarely | the largest remaining lever, and the riskiest: the grokkings are loaded so that they are used (G67), and every miss on record was an entry read too thinly, not one absent. Not recommended now |

Moving the first three would take about 40 KB (roughly 10k tokens) off every launch.

## 6. The coordinator's own ceremony

- **The announcement rule** earns its place only when blind verification runs; for a close or a kernel port it is a formality.
- **My close inventories** are the heaviest accounting in the pipeline (§4). They are mine to shorten.
- **The test drive's own record** (`plans/WORKFLOW3-test-drive.md`) holds thirteen pending edits to the lane files, none filed. Filing
  the ones that remove work (drafts name their slot; the atlas facts generated, not drafted) shrinks the close.

## 7. Done at Kooshi's word (2026-09-28)

Kooshi: "Do #2, #3, #4. I like #1 and #5, having a central home for the most important facts. You can, however, reduce the in-CLAUDE
milestone list to the top 10, with just a count of outstanding after that instead of a list." (The numbers are the report's: #2 the
re-grokking walk, #3 the process sections, #4 the counts and predictions; #1, one home per theorem, and #5, the front page, are declined.)

| item | what changed | where |
|---|---|---|
| #2 | §G writes a reason only for an entry that bears or is falsifiable, lists the rest by number, walks the ledger rows the stub cites and those the last close filed, and is walked again when the milestone's object changes; Keryx scores the *bears* lines and the silent list | `.claude/agents/ephodos.md` § The opening job §G and § A derivation job; `.claude/agents/debruijn.md` (kernel §G); `.claude/output-styles/keryx.md` step 4 |
| #3 | § Toolchain (all but the search ban), § Building and § Make the gate fail moved verbatim to `RUNNING.md` (40,089 bytes), the two PROTECTED paragraphs with their tags; each heading stays in `CLAUDE.md` with a pointer. De Bruijn reads it in full at launch; a derivation job reads its gate section before building a check; every brief for a job that runs processes or builds a checker names it; standing rules 2, 7 and 9 point to it | `RUNNING.md`; `CLAUDE.md` § Toolchain, § Building, § The gate; `plans/STANDING-RULES.md`; the three lane files; `scripts/build.sh`, `scripts/vacuity.sh` messages |
| #4 | no running count of any method rule (a close records only a counterexample to G72 or G79); a prediction is registered only where its outcome decides what runs next, and names that decision | `.claude/agents/ephodos.md` (the plan proper; the close's sweeps); `CLAUDE.md` G79's killing test |
| the table | `CLAUDE.md` § Paths forward keeps ranks 1–10 and one row, "11–69 — 59 more open stubs"; Keryx copies the top ten at each close. The Proof Atlas's two citations of ranks 11 and 16 now cite the same rows of `plans/FRONTIER-STUBS.md` | `CLAUDE.md`; `.claude/output-styles/keryx.md` step 7; `tools/viz_proof_atlas_facts.py` |

`CLAUDE.md`: 274,901 → 229,585 bytes. Checks: `tools/claude_md_fact_audit.py` (now joining `RUNNING.md`, the retired grokkings and, for the
loss audit only, `plans/FRONTIER-STUBS.md`; two superseded range labels recorded with their reasons) passes with 0 failures and its
self-test passes; `--dupes` 21 runs; `scripts/identities.py check` PASS; `tools/bib_audit.py` exit 0; the atlas checker 187 checked,
0 failed, and its self-test passes; `scripts/gate_report.py` still reads the gate's nine counts and the trust ledger's two.
