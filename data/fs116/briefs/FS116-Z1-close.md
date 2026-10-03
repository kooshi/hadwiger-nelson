# Brief FS116-Z1 — the close of FS-116, the local exclusion: part 1 (the reconciliation and the derivation file)

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-Z1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; invoke `ephodos-verification` fresh with the Skill tool when you read a verifier's divergence table
  role: part 1 of FS-116's close job — the ticks, the reconciliation and the derivation file; part 2, a successor job on its own brief, writes the sweeps, the stubs and the drafts of the front page from your files
  launch: now, beside FS116-V6, a blind verifier on one statement of FS-116's list (§ 15)
  mission: § Why this job
  statements: § The question as posed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a close is not a second mind and reads every record of its milestone; but FS116-V6 is blind to every FS-116 record, so § Keeping FS116-V6 blind binds what you write
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-Z1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-Z1-close.md`
  touches: `plans/FS116-Z1-close.md`, `plans/FS116-derivation.md`, `data/fs116/fs116-z1/`, `tools/fs116_z1_*.py`, `data/fs116/reports/FS116-Z1.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — a successor on this brief finishes from your last saved stage

Hello. You are Ephodos, opening the close of FS-116, the local exclusion. FS-121's close ran today as one job and found that reading an
eleven-job milestone to reconciliation depth cost about 375k before any writing (`plans/FS121-Z1-close.md` D11). FS-116 ran seventeen jobs, so its
close is two jobs, and you are the first. Where your lane's workflow is silent, unclear or wrong for a close split this way, say so in your report:
Kooshi asked the coordinator to watch the new workflow, and your friction is the evidence.

## Why this job

FS-116's rounds are done: the opening, three proof rounds, four construction rounds, a saturation job and five blind verifiers have reported,
and a sixth verifier (FS116-V6) is running now. Kooshi's instruction for this run, after the usage-limit halt:

> Please revive your agents with messages, and continue with the milestone.
> — source: plans/FS116-close-inventory.md row 74

So this close files what the milestone established, at the grades the records support, and hands every open step forward whole.

## The question as posed

The milestone's question, from its stub's title line:

> FS-116 — the local exclusion: is there an explicit radius about a four-colour vertex within which no valid six-map fragment with unit arcs exists? (stub)
> — source: plans/STUB-local-exclusion.md

Its frozen form is C114-LOCAL-F (`data/fs116/claims.md` § 1); its bearing on the answer is the stub's § Bearing on the answer.

## What you work from

- **The close inventory, `plans/FS116-close-inventory.md`, items 1–130 and the W- and O-tables**, which the coordinator keeps and alone writes,
  with the announcement rule at its top. Read every number from the item's source, never from the inventory line. The mind counts the coordinator
  has ruled are in its "announcement rule" rulings (items 31, 49, 76, 118) and in items 108, 115 and 123: file each as ruled, or say why a record
  shows otherwise.
- **The plan**, `plans/FS116-local-exclusion.md`; **the claim list**, `data/fs116/claims.md`, §§ 0–15; the briefs in `data/fs116/briefs/`.
- **Every job's record and report**: the reports in `data/fs116/reports/`, each naming its record in `plans/` and its commits. The jobs: O1 (the
  opening), P1 (the question), N1, N2, N3 (the proof side), S1 (saturation), Y1–Y4 (the construction side), V1–V5 (blind verifiers), CL1 (the Clerk).
  Most records already carry their theorems as `derivation:` entries in your grammar; read each record's "Theorems this phase proved" first.
- **The form to follow**: your identity's entry grammar and your lane file's § The close job; FS-121's close, today, is the worked example
  (`plans/FS121-Z1-close.md` §§ 1–3 and `plans/FS121-derivation.md`), and its § B line generator `tools/fs121_z1_ledger_b.py` may be copied and adapted.

## The headline rules

- **Grades come from the minds that actually derived.** "Held" is the announcement rule's: a frozen statement, two minds, the second blind with its
  verdict committed before it compared. Everything short of that is said in words ("one mind", "one mind and a checking reading", "two derivations,
  the second told the verdict"). Name every open step.
- **FS116-Y4-EMPTY** is filed at one mind, "blind second mind running (FS116-V6)"; part 2 updates it from V6's report. The statements item 124 lists
  carry its conditional note (true vacuously if EMPTY is held), each at the count its own verifier gave.
- **Frozen statements are never edited.** A statement a verifier corrected (the inventory's statement-defect and correction-owed items: 11, 28, 29, 32,
  38, 45, 50, 51, 62, 65, 67, 77, 87, 109, 120, and any others you find) is filed in `plans/FS116-derivation.md` in its corrected wording, taken from the
  verifier's record, with the original's address. Side records are never rewritten.
- **A no-go is a result** (Kooshi: "All novel knowledge is a success"). File every GAP as the named step it is.

## Keeping FS116-V6 blind

FS116-V6 re-derives FS116-Y4-EMPTY blind to every FS-116 record, and its fence closes every `plans/FS116-*` file, `data/fs116/` but the claim list,
and every `tools/fs116_*` tool but its own. So write only inside your touches (all inside that fence), never message it, and keep your commit
subjects neutral ("FS116-Z1: stage n"). Errata to files outside FS-116 (`plans/FS114-derivation.md`: items 10, 39, 71, 110) are part 2's, after V6's
verdict is committed.

## Numbers fixed now (for part 2, and for your entry ids)

- Ledger rows are drafted by part 2 as ‹R116-a›…, numbered after FS-121's at the filing; cite results by their derivation-file ids.
- Grokkings from **G91**; stubs **FS-123–FS-125** (FS-116 item 105). Part 2 writes them.

## Done means

1. **data/fs116/fs116-z1/ticks.md**: a proposed tick for every inventory item 1–130 — "done" with where, "declined" with the reason, or
   "part 2" with what part 2 must do.
2. **`plans/FS116-Z1-close.md`**, your record, holding:
   - the readback of this brief's quotations;
   - **the reconciliation**: every claim and lemma of the rounds, its verdict, its minds and their blindness, and every divergence between a job and
     its verifier with how it was settled, as a table part 2 can work from without re-reading the records;
   - **the headline in four parts, drafted** — what FS-116 settled and at what grade (C114-LOCAL-F's case list, case by case: the Γ-free type, the
     (Q)-free rings with (R2) arcs, the rings with (Q) arcs, the six-colour vertex, the Siamese and non-simple classes); the named steps it stops at;
     what the construction side built or excluded; your confidence, with the fact that would change it;
   - the "Theorems this phase proved" heading (a close proves none of its own unless it does; say which).
3. **`plans/FS116-derivation.md`**, every theorem the milestone proved outside the kernel as an entry in your grammar, passing
   `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS116-derivation.md` from the repository root (addresses resolve from `plans/`,
   so write ../tools/… and ../data/… there). Qualify every id (`derivation: FS116-N3-SEMI`); write "Rests on it:" as prose under every block (the
   ledger's census requires it, and the gate does not check it: FS-121 item 89's finding); each entry's `handoff:` its kernel decision.
4. **The § B line drafts**, data/fs116/fs116-z1/ledger-b-draft.md (a new file), one per entry, generated from the entries' own statements, and the exit
   status of `python3 tools/fs71_ledger_b_check.py --strict` on a scratch copy of the ledger with them (and FS-121's drafts,
   `data/fs121/fs121-z1/ledger-b-draft.md`) applied.
5. **The report** in the standing rules' form. Your last words are exactly "FS116-Z1 idle; report sent to the coordinator", and the hand-back carries
   nothing else: the report goes by message.

## What is yours to decide

The order of your stages; how the derivation file is assembled (copying the records' entries by script and updating their counts is the expected
shape); which lemmas are entries and which are folded into their consumers. If the inventory, a record or this brief is wrong about something, say
so: that is a finding, not a refusal. If the milestone's own framing now looks wrong, say that too.

## Stages (save and commit each; standing rule 2)

1. The readback, and the ticks file.
2. The reconciliation.
3. `plans/FS116-derivation.md`, passing its gate.
4. The § B drafts and their check, the headline draft, then the report.

If you reach your hand-back line mid-way, stop at a saved stage and say what is left; a successor continues from there. You start no agent of your own
(`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
