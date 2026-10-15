# Brief FS131-PR1 — draft the public README and the public roadmap of what is left to formalize

*Written 2026-10-15 01:49 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-PR1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus. Here your plan is not a skeleton: it is an honest public account of what the library proves and what it does not yet
  role: the author of two public pages of a Lean repository about to go on GitHub — its front README and a readable roadmap of what is left to formalize — and of any short directory READMEs a stranger needs to find their way; every claim on them traced to the ledger, the gate's logs or the kernel's print
  launch: now, in the tree that holds `main`'s compiled library; one other job runs, a read-only sweep of the history, in another tree
  mission: § Why this job
  statements: § What the pages rest on
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if the ledger, the front page and the kernel's print disagree about any result, or if a page would need a decision that is Kooshi's (a licence, a name, what is public); the report goes to `data/fs131/reports/FS131-PR1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full
  record: `plans/FS131-PR1-readme.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1`, on its branch `fs131-pr1` (cut from `main` at `8c026e86d`; its compiled library is current for `main`'s Lean sources, gated as `eee71c74c`): `README.md` and `ROADMAP.md` at the root (new); at most five new `README.md` files in directories you choose, each named in your record; `plans/FS131-PR1-readme.md`; your scripts and outputs under `data/fs131/pr1/`; `data/fs131/reports/FS131-PR1.md`. **Not** `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md` or any file under `Proofs/` — where one of them is wrong or stale, draft the correction in your record. No build. Nothing on `main`; no push
  budget: about 300k by the harness's count, as guidance; save a stage after the readback, after the inventory of results, after each page's draft, and at the hand-back; hand back at a saved stage before about 450k

Hello. This repository has spent eighty-five days building a kernel-checked account of the Hadwiger–Nelson problem.
Kooshi now wants it on GitHub, readable by a stranger, before the work goes on. You write the two pages that stranger
reads first.

## Why this job

Kooshi's word for this step:

> Once the chain lands, we'll do some sanitization, git history rewrites, some nice readmes, a public readable roadmap of what's left to be formalized, and push to github. Not a full writeup, just that. Then we'll get back to work. That also solves our backup issue.
> — source: data/fs131/REQUEST-2026-10-13.md

The trigger is met. My log of the landing, and of the front page's filing that brought `CLAUDE.md` and `LEDGER.md`
current with it:

> 944. **FS131-LGT1 handed back: the gate green on `eee71c74c`, read aloud, the front page drafted (logged 2026-10-15 01:37 UTC; "JOB FS131-LGT1 — DONE"; 462k by the harness's count; branch `fs131-wlc` at `194ec35cf`, tree `fs131-wq1`; record `plans/FS131-LGT1-gate.md`, report `data/fs131/reports/FS131-LGT1.md`).** From its hand-back message: "[kernel] `HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : (SimpleGraph.induce (planeOver SqrtFortySeven.F47) (unitDistance ℂ)).chromaticNumber = 5`, where `F47 = Subfield.closure {√47}`. No hypothesis; the same five axioms. Read against row 121's headline claim `χ(ℚ(√47)²) = 5`: it states exactly that"; the headline "Read against row 123's main clause: word for word, for every real number field, complex places included"; M15's other values with no hypothesis, and "Not stored as theorems: `χ = L` at `L ≤ 5` (it is a two-line composition with the upper half), the family of 44 of 52 fields, CLS in full, and ℚ(√23, ∛2)"; "what the kernel did not check is exactly two declared outside theorems"; 1,439 audit records generated from the kernel's print, 235 of them named by no draft; four declared conditions retired, three declared `.condition`; "statement defect — none found"; drafts 1–22 "each slot checked once on `main` by `data/fs131/lgt1/drafts-slots.py` (23 slots OK; its control at `9fe574044` fails on 10)", novelty "per the 00:33 amendment"; the four raw dumps deleted after the check read them; a question: "E–L Thm 1.3's in-file model, `positive_entropy_rigidity_model`, is degenerate (the one-point solenoid …). I did not check whether PE-1′ is a stated theorem exhibiting a non-degenerate model"; "`lean4checker` was not run. Neither is a gate item." **My receipts:** the four commits after `eee71c74c` touch `plans/` and `data/` only (`git diff eee71c74c 194ec35cf` outside them empty); merged into `main` as `9543a549b` (`--no-ff`, after item 943's `1b589dcb5`), and `git diff eee71c74c main` outside `plans/` and `data/` is empty; my own reading of the instance (item 940 (d)): `F47` is `SquareClass.fieldOfRadicands {47}` = `Subfield.closure ((fun d : ℕ => Real.sqrt d) '' {47})`, the subfield ℚ(√47) of ℝ (`Instances/SqrtFortySeven.lean` l. 39, `SquareClass.lean` l. 306); `planeOver F = {z : ℂ | z.re ∈ F ∧ z.im ∈ F}` (`SquareClass.lean` l. 63), F² in ℂ; `unitDistance ℂ` adjacency `dist x y = 1` (`UnitDistance.lean` l. 40); so the stored type says the unit-distance graph on ℚ(√47)² has chromatic number 5 — row 121's `χ(ℚ(√47)²) = 5`; it has no binder. The degenerate-model question read: the axiom's hypothesis "no virtually cyclic factors" has a non-degenerate inhabitant in `ZdAction.mulTwoThree_model` (`Rigidity/PositiveEntropy.lean` l. 415, FS131-IJN1), and the statement's read-back against the page is `plans/FS131-KN7-chain-next.md` § Stage 3 (one read-back, written again at repair R1). **Announcement rule (item 940): met on its letter** — (a) item 943; (b) `main` at `1b589dcb5` and again at `9543a549b` equal to `eee71c74c` outside `plans/` and `data/`; (c) item 943's print; (d) the gate-runner's stage 4 and my reading above. **W6's trigger is met:** row 121's `χ(ℚ(√47)²) = 5` is through the gate on `main` with no hypothesis of ours. **Rulings, four parts.** (1) *The three `.condition` declarations stand as declared:* alternative, `EntropySplitEvery` as a `.former` of kind `ours` — declined for now: the kernel holds `EntropySplit F` with no such hypothesis, so nothing rests on it; the second filing may reclass it; medium. (2) *The front page from drafts 1–22 by a Clerk filing (base `faa9a919c`), its novelty wording checked by me first:* alternative, file them myself — declined, the filing is verbatim work; high. (3) *`lean4checker` and the comparator* at the publication pass, as `CLAUDE.md` § The mission's publication paragraph names them; alternative, now — declined: no gate item, and the pass's first step is Kooshi's word on its shape; high. (4) *The generalization `χ(F²) = L(F)` at `L(F) ≤ 5` stated by name:* to the publication roadmap with Lemma C′, or a short job if Kooshi wants it before the push; medium. **Correction to my § 7 rule:** the handoff says the merge is mine "after the hand-back"; I merged the gated commit at the green line (item 943) and the records at the hand-back — the sources merged are the gated commit's either way. **Credited:** the 235 records only the kernel's print found; the stale self-test controls caught before the pass.
> — source: plans/FS131-close-inventory.md

> 946. **FS131-FC7 handed back: the five-colour chain's front page filed (logged 2026-10-15 01:46 UTC; "JOB FS131-FC7 — DONE (stage 4 saved)"; 163k by the harness's count; branch `fs131-f7` at `8ff1bb435`, tree `fs133-wk1`).** From its hand-back message: "Drafts 1–21 are filed, and draft 22 (the atlas) is untouched by your choice. The fact audit passes and CLAUDE.md is 79,235 bytes"; "Move 1: the FS-133 block in § Open milestones is replaced by your pointer text … the block was 1,238 bytes"; "Move 2: draft 5 is filed. Its three older entries … went verbatim as one line to the top of … plans/FILINGS.md"; "The two tokens the moves sent to FILINGS.md, 'Plane/DensityBound' and '1422', took EXTERNAL_HOMES entries in the FS131-FC5 form"; "CHECK: none new." **My receipts:** the four commits on `fs131-f7`; nothing uncommitted; `CLAUDE.md` 79,235 bytes; in its tree and again on `main` after the merge, `tools/claude_md_fact_audit.py --base faa9a919c` "AUDIT PASSED (0 failure(s))" and `--dupes` exit 0; the "Last filed" line opens with the five-colour chain's entry and ends "before it, every earlier filing, newest first: `plans/FILINGS.md`"; `plans/FILINGS.md`'s first entry is the density bound's; the branch did not touch the inventory (`git diff main...fs131-f7` on it empty). Merged into `main` as `af24b9b7e` (`--no-ff`, `git merge-tree` clean). **The next filing's fact-audit base: `af24b9b7e`.** **Credited:** the size check stopped where the brief said, and every byte count was written per step.
> — source: plans/FS131-close-inventory.md

"Not a full writeup": the README says what is here, what it proves at what grade, what it rests on, whose it is, and how
to check it; the roadmap lists what is not yet formalized. Neither argues the mathematics.

## What the pages rest on

The project's rule for words a stranger reads:

> - **Naming is a first-class deliverable**: every working term in this repository is coined in-house and appears in no paper — the mechanism
> — source: CLAUDE.md § The mission, Publication

Whose work this is, in the project's own words:

> The mathematics and the engineering here are the agents': the questions Poros's, the derivations Ephodos's, the kernel proofs
> — source: CLAUDE.md § Whose work this is

**The sources, in order of authority:** the kernel's print from this tree's compiled library (statements and
`#print axioms`; one file through `lake env lean`, below); the gate's logs on `main` (`data/fs131/lgt1/gate/`, the last
full gate, green on `eee71c74c`); `LEDGER.md` (one row per result, its grade, its address, its prior art, § The claim
list for what is ours); `CLAUDE.md` § The mission and § Frontier (current state); `LEAN.md` § Trust ledger and
§ Assumptions (the declared outside theorems and the hypotheses); `ARCHITECTURE.md` (the module map);
`BIBLIOGRAPHY.md` (every cited work; its § E maps this project's words to the literature's);
`plans/LEAN-BACKLOG.md` and `plans/STUB-lean-backlog.md` (what the Lean backlog holds). Lemma C′ (row 100), deleted from
the library at the chain's landing, has its statement kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.

## Done means

1. **Readback** (a saved stage): the quotations above checked against their sources; your record restates, one line
   each, what the README must say and what the roadmap must list.
2. **The inventory of results** (a saved stage), in your record: every headline result the README will name — at least
   the interval `5 ≤ χ(ℝ²) ≤ 7` on the standard three axioms, `6 ≤ χ(ℝ²)` on `[OAIMath2026]`'s declared theorem,
   `χ(ℝ²) = χ_m⁰(ℝ²)`, the density equality, the density bound, the number-field values through four, and the
   five-colour chain (`min(L(F), 5) ≤ χ(F²)`, `χ(ℚ(√47)²) = 5` and the other instances) — each with its Lean name, its
   stored statement and its axioms as you print them now, its ledger row and grade, and its whose-is-it line in the
   ledger's words. Print every statement and axiom list yourself: one scratch file under `data/fs131/pr1/`, run from
   inside the tree, `env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8
   --cpus 2 --wait 3600 --name pr1 -- lake env lean -DautoImplicit=false <file>`.
3. **`README.md`** (a saved stage): what the repository is, in a paragraph; the results table (plain-words statement, Lean
   name, what it rests on, whose it is); what the library assumes (the declared outside theorems by name and citation, and
   the audit that checks it); how to build and check it (the pin, `scripts/build.sh`, the axiom audit — machine-independent,
   no path of this laptop); how the repository is laid out; how it was made (the agents and Kooshi's part, from the
   quotation above). Novelty in the ledger's words: "prior art: not found in print", the parts that are not ours named;
   never "new", "first" or "novel" as a claim, and never "not new" for a result of ours. A few screens, not a paper.
4. **`ROADMAP.md`** (a saved stage): what is left to formalize, complete and plain — every ledger row whose grade is not
   `[kernel]` (or the part of a row that is not), grouped by what it bears on; the declared outside theorems (Weil's bound,
   Einsiedler–Lindenstrauss Theorem 1.3, the release's five-colouring theorem) and what landing each on the standard three
   axioms would mean; Lemma C′; `χ(F²) = L(F)` at `L(F) ≤ 5` as one named theorem (a two-line composition, not yet stored);
   the milestones whose Lean phase is open (`CLAUDE.md` § Paths forward). Each item with its source address. No time or
   difficulty estimate: rank by bearing on the answer (`CLAUDE.md` § Counter-priors, rule 1).
5. **Directory READMEs**, only where a stranger would be lost without one, each a few lines.
6. **The report** in the standing rules' form, with every place the ledger, the front page and the print disagree, and
   every decision you left to Kooshi (a licence among them: the repository has no licence file).

## What is yours to decide

The pages' structure, wording and length; which results are headline; which directories get a README; how to translate
in-house terms (with § E's table). Do not mention the session-transcript folder `chats-bak/` or any personal detail of
Kooshi's: whether the transcripts stay in the public history is undecided. If a ledger row and the kernel's print
disagree, the print wins on the page and the disagreement goes to me.

## The machine

Laptop, 12 cores, 31 GB; one other job runs. This tree's compiled library is current for `main`'s Lean sources: do not
build, and do not edit any file under `Proofs/`. `/tmp` is wiped at power-off: keep what your record cites under
`data/fs131/pr1/`. Commit on your branch by explicit path and **do not push**: the remote is down and the
coordinator copies the branches to a backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
