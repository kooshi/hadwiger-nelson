# Brief FS131-LT5 — the gate's new step lands: every assumption the library makes, in both forms, declared on `main` as it stands, the docstrings that say whose each is, the full gate on one commit, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LT5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the landing implementer of a tooling job — merge the branch that built the gate's step listing what the library assumes (outside theorems declared as axioms, and hypotheses standing for outside theorems, for hand results of ours and for open questions) into `main`'s line as it stands today, declare everything two landings have brought since that step's list was made, read the list's judgement calls as their second reader, make the docstring edits it asks for, run the full gate with the new step on one commit, fast-forward `main`, and draft the lines the front files gain
  launch: after wave 10's second landing, in a tree of its own cut from `main`; other jobs work on other waves in trees of their own and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for an assumption on `main` that no record of ours names (at once, with the declaration and the statements that take it), a docstring and a record that disagree about whose a hypothesis is, a declared condition or premise you would class as an assumption (it moves a count the front page will state), a failure of the step you cannot settle from the records, a gate step red for a reason outside your touches, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-LT5.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-LT5-landing.md` (new, on branch `fs131-lt5`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wlt` (branch `fs131-lt5`, cut from `main` at `e9a65a86`): the merge's files; `scripts/Assumptions.lean` (its declared list, and its code only for the one ruled change and for a defect you show with a control), `scripts/assumptions.sh`, `scripts/assumptions-ledger.txt` (by `--write-ledger` only), `scripts/assumptions-controls.txt`, `scripts/gate_report.py`; **docstrings, and nothing but docstrings**, in the modules under `Proofs/` that the step's record names in its draft 8; `ARCHITECTURE.md` (§ 5, the new subsection); `plans/FS131-LT5-landing.md`, `tools/fs131_lt5_*.py`, `data/fs131/lt5/`, `data/fs131/reports/FS131-LT5.md`; `main` by the one fast-forward push this brief names; **not** any statement, definition or proof under `Proofs/`, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record; the two bibliography rows the step needed are filed)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. This library's claim is that everything in it reduces to what the kernel checked plus what was explicitly chosen to trust. Until
today nothing listed the second half of that sentence in full: the audit sees an outside theorem declared as an `axiom`, and does not see
a theorem that says "if Herglotz–Bochner holds, then …", which prints the standard three axioms and is counted clean. The project's owner
asked for the instrument, an implementer built it on a branch, and its first run on `main` found thirty-three such hypotheses — one of
them an outside theorem the coordinator's own search had missed. It is not on `main`. You put it there, on a library that has grown by
two landings since its list was made.

## Why this job

> 551. **Kooshi's word, 2026-10-06: the gate is to enumerate both kinds of assumption; a special-purpose staff slot for that job;
> — source: plans/FS131-close-inventory.md

> 548. **Kooshi's word, 2026-10-06: Falconer's lemma is pulled into this milestone; and two questions of his, answered with a
> — source: plans/FS131-close-inventory.md

> 562. **FS131-T5 done: the gate has a step that lists what the library assumes, in both forms; `main` assumes 34 things, six of them outside theorems** (implementer, Opus, the special-purpose slot; harness 534k and 76 minutes by the task notice; record `fs131-t5`'s `plans/FS131-T5-assumptions.md`; report `data/fs131/reports/FS131-T5.md`; six commits, tip `4dd69014`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

A list kept by hand goes wrong the way mine did; a step that fails when a landing brings an assumption nobody declared does not. But the
step's verdict on a hypothesis is only as good as the one line that declares it — an assumption, or a mere condition on a theorem's
parameters — and every such line on the branch is one mind's reading. This landing is where a second reader sees them, and where the
step first meets modules its author never saw.

## The statements

No statement, definition or proof changes in this job. Docstrings change, and one of them by a ruling (item 562 (b)): the hypothesis
below is assumed — the second line takes it — and its docstring's "Named here, not imported" is true only of the third, which states it
under an equivalence. Read each whole, with its docstring:

> def Voronov11 : Prop :=
> — source: Proofs/HadwigerNelson/Plane/Slack.lean

> theorem mu_lt_of_voronov11 (hV : Voronov11) {ε : ℝ} (hε : 0 < ε) : mu 6 ε < 1 := by
> — source: Proofs/HadwigerNelson/Plane/Slack.lean

> theorem forall_mu_six_lt_one_iff : (∀ ε > (0 : ℝ), mu 6 ε < 1) ↔ Voronov11 := by
> — source: Proofs/HadwigerNelson/Plane/Slack.lean

The outside theorem my search missed, as an instance of what the step finds and of a docstring that does not yet say whose it is:

> def RealAlgebraicDescent : Prop :=
> — source: Proofs/HadwigerNelson/Bridge.lean

The step's own account of what a landing must do, and of the docstrings (read both sections whole in its record):

> - **A wave that brings a named hypothesis** (`WEqKLimit`, `ReduceToMap`, `MapNO`, `GammaFreeEmptyNS`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md § What is on its way — how each landing meets the step

> - **`KloostermanBound` becoming an axiom** (Weil's bound): while a hypothesis it is a `.former … .outside "[Weil1948] …"`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md § What is on its way — how each landing meets the step

> - **The job removing `falconer_lemma2_nonempty`**: its four `RESTS` rows go stale (`stale-consumer`) and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md § What is on its way — how each landing meets the step

> - **When an assumption is proved**: a theorem concluding a declared former over its own variables with no hypothesis
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md § What is on its way — how each landing meets the step

> **8. Docstrings under `Proofs/`, for a landing to make** (none is this job's to change; each rebuilds its module's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md § Drafts for the front page

The gate's recorded state on `main`, which your other counts are reconciled against:

> as a set); the current audit reads 6304 clean and 5 declared purchases, and 8 imported (and 17 axiom-free; 6,334 records at wave 10's second
> — source: CLAUDE.md § Trust ledger

> `declarations=14501 refutations-skipped=199 sites=1269`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`.
> — source: CLAUDE.md § The gate

## Done means

1. **Your readback first**: check every quotation above against its source; read the step's record in full
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md` — the design of Stage 2, what the first runs changed in Stage 3, the enumeration of Stage 5, "What is on its way", the
   drafts) and its report (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/data/fs131/reports/FS131-T5.md`); `scripts/Assumptions.lean`'s declared list on that branch, line by
   line; the two landings' records for what they brought (`/home/kooshi/source/lean-dir/plans/FS131-L10B-landing.md` — its table of hypotheses, written for
   you — and `/home/kooshi/source/lean-dir/plans/FS131-L6A-landing.md`, its drafts' list of named hypotheses and open gate items); `LEAN.md` § The gate,
   § Assumptions and § Trust ledger. Build the branch once as given (expect it up to date; no `sorry` anywhere: this is `main`). Open
   your record. Commit and push.
2. **The merge**: `git merge origin/fs131-t5` (at `4dd69014`), its own commit. Trial it first; confirm by `git diff --stat` that it changes
   no file under `Proofs/`. A conflict is a message to me unless it is `scripts/gate_report.py` or a registry file with adjacent
   additions (keep every side).
3. **The step on today's `main`, read before anything is declared**: run `./scripts/assumptions.sh --self-test`, then
   `./scripts/assumptions.sh`, under the slot as its record says, and save both outputs. Expect it red — its list was made at a commit
   before wave 6's first half and wave 10's second half landed, before Falconer's axiom became a theorem and before Weil's bound became
   the library's one outside axiom. In your record, every failure by kind, with what it means: a consumer of an axiom that is gone, a
   theorem resting on an axiom the ledger does not list, a former no theorem concludes, a closed hypothesis nobody declared, a declared
   hypothesis a theorem now proves.
4. **Everything declared, from the records**: for each failure, one line of the declared list — an assumption (a named former or a
   site, with its kind and a source that is a `BIBLIOGRAPHY.md` key, a ledger row, or a derivation entry's id), or a condition or a
   premise with its reason — decided from the definition's docstring, the landings' tables and the planners' records, never from the
   name. Entries that are no longer true leave (an assumption since proved; a hypothesis that became an axiom). **An assumption no
   record names, or a docstring and a record that disagree, is a message to me before you declare it.** A hand result written out over
   a theorem's own variables is the one thing the step cannot find: the second landing's table says whether wave 10 has any; for wave
   6's first half, read its fourteen modules' docstrings for the words and say what you found.
   **Two cases the second landing's table raises, pre-ruled so that you need not ask**: a named former that a theorem now proves
   with no assumption in hypothesis form — `StandingFloor`, proved at 7 and 5 by theorems that rest on the declared import — is no
   longer an assumption in hypothesis form: its entry leaves, by the step's own rule for a proved assumption, and the import's own
   rows carry the dependence (every theorem resting on the axiom is listed under it). And `KloostermanBound`, the hypothesis form of
   Weil's bound, which a theorem now concludes from the import at characteristic not 2, is declared only if the step asks for it;
   if it does, it is an outside theorem under the key of the import. Say in your record what the step did with each. If the step's
   rules and these two readings disagree, that is a message to me.
5. **The second reading**: the branch declares 31 conditions and 2 premises, each with a reason that is one mind's. Read each against
   the definition and the statements that take it. In your record, a table: the entry, your reading, agree or not. Where you would
   class one as an assumption, message me with the definition and its consumers — do not change it alone, and do not let it pass.
6. **The docstrings** (the record's draft 8, items (a)–(e)), each edit a comment and nothing else — shown by script: the diff under
   `Proofs/` touches no line outside a docstring, and every declaration's elaborated signature is what it was (an implementer's tool
   compares elaborated signatures, with controls: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/tools/fs131_i7a_stmt_check.py`;
   read it and use it or write the same check). For `Voronov11`, the ruled sentence: it is taken as a hypothesis by one theorem and
   stated under an equivalence by another, named. Then the step's `SILENT` and `HINT` counts as they now stand.
7. **One ruled change to the instrument** (item 562 (d)): the digest in `scripts/gate_report.py` today only flags counts that are
   absent from `CLAUDE.md`. Make absence fail, with the sentence to add in its message, and a control that shows it red on a copy with
   the sentence removed and green with it — a recorded count whose deletion passes is the gate's own failure mode. The first filing is
   then: I add the sentence, and the digest passes.
8. **The ledger**: `./scripts/assumptions.sh --write-ledger`; in your record, every row it adds and every row it removes, each read —
   an added row is a statement of this library that is conditional on something, and the list of them is this job's product.
9. **The full gate on one commit** (the docstring edits rebuild what they touch): `./scripts/build.sh` with zero warnings (count
   them); zero `sorry` in `Proofs/`; the doubled-name check after the build and before the axiom audit —
   `/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8 -- ./scripts/dupnames.sh`, then its `--self-test` under
   `--mem 4 --cpus 4`; `scripts/axioms.sh` and `--self-test` green, the record counts unchanged from the second landing's;
   `scripts/vacuity.sh` and `--self-test` green, its counts unchanged (say so with both lines); **`./scripts/assumptions.sh` and its
   `--self-test` green, and the branch's mutation harness run once more on the joined tree** (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/tools/fs131_t5_mutate.py`, which the merge brings into your tree, as its
   record's Stage 6 ran it); `tools/check_architecture.py` exit 0; the guarded lint, `lake lint --no-build -- --no-build --trace` under
   the slot with `--mem 8`, silent; the notes check, `tools/fs131_qa4_notes.py`, no CONFLICT; the records check,
   `tools/fs131_l5_records.py`. Save every step's log under `data/fs131/lt5/` and name them.
10. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
    `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, say so with the diff that shows it, otherwise re-run the gate on the merged commit. Then
    `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and retry.
11. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LT5)", each with the log line it comes from: the
    step's record's drafts 1 and 3–5 brought to the landed state — the paragraph `CLAUDE.md` § Trust ledger gains, its nine counts read
    from your landed receipt; the sentence and the bullet for `LEAN.md` § The gate; the two bullets for § Assumptions; the row for
    § Trust ledger's table — and its draft 7, the line every landing brief carries from now on, corrected if the procedure moved.
    `ARCHITECTURE.md` § 5's new subsection (its draft 6) you write yourself, with the three tables as they stand on the landed tree.
    And **the enumeration itself, for the owner**: by kind, by name, in plain words what each assumes and where it comes from, with
    the count of statements on each, and what the step counts and cannot decide.
12. **Your record**, stages headed "Stage n — SAVED (FS131-LT5)"; the report in standing rule 11's form, the enumeration its first result.
    Leave no background process running. Stopping at a saved stage with the step red at a named failure you could not settle from
    the records is a good report — say which, its log, and whom the question is for.

## What is yours to decide

How each new module's hypotheses are declared, within the step's own procedure and the records; the wording of each docstring edit;
the order inside each step; whether a defect you find in the step's code is repaired here (with a control that shows it) or reported.
Three things are not yours: no statement moves; a declared condition does not become an assumption, or the reverse, on your reading
alone; and both forms stay enumerated — an assumption does not leave the list because of how it entered (the owner's word, item 551).
If the honest result is that the step cannot be made green on today's `main` without a decision that is not yours, land nothing and say
exactly what is needed. Do not weaken a check to pass it. Three failed attempts on one route is a dispatch to the companion your
identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
