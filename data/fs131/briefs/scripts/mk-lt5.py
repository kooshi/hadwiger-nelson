exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LT5: the landing of the gate's step that lists what the library assumes (FS131-T5's branch).
# Run AFTER wave 10's second landing is on main and the tree below is made from main's tip:
#   git -C $R worktree add -q -b fs131-lt5 $R/.claude/worktrees/fs131-wlt origin/main   (then .lake as usual, push -u)
import subprocess, os
TREE="fs131-wlt"; BR="fs131-lt5"; JOB="FS131-LT5"; L=WT+TREE+"/"
def tip(ref): return subprocess.run(["git","-C",ROOT,"rev-parse","--short=8",ref],capture_output=True,text=True).stdout.strip()
TIP=subprocess.run(["git","-C",L,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert TIP,"make the worktree first"
T5=tip("origin/fs131-t5")
T=WT+"fs131-wt5/"; TR=T+"plans/FS131-T5-assumptions.md"
L10="plans/FS131-L10B-landing.md"; L6="plans/FS131-L6A-landing.md"
assert os.path.exists(ROOT+L10),"wave 10's second landing's record is not on main yet"
H="Proofs/HadwigerNelson/"
HWAY="§ What is on its way — how each landing meets the step"; HDR="§ Drafts for the front page"
b=f'''# Brief {JOB} — the gate's new step lands: every assumption the library makes, in both forms, declared on `main` as it stands, the docstrings that say whose each is, the full gate on one commit, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the landing implementer of a tooling job — merge the branch that built the gate's step listing what the library assumes (outside theorems declared as axioms, and hypotheses standing for outside theorems, for hand results of ours and for open questions) into `main`'s line as it stands today, declare everything two landings have brought since that step's list was made, read the list's judgement calls as their second reader, make the docstring edits it asks for, run the full gate with the new step on one commit, fast-forward `main`, and draft the lines the front files gain
  launch: after wave 10's second landing, in a tree of its own cut from `main`; other jobs work on other waves in trees of their own and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for an assumption on `main` that no record of ours names (at once, with the declaration and the statements that take it), a docstring and a record that disagree about whose a hypothesis is, a declared condition or premise you would class as an assumption (it moves a count the front page will state), a failure of the step you cannot settle from the records, a gate step red for a reason outside your touches, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` at `{TIP}`): the merge's files; `scripts/Assumptions.lean` (its declared list, and its code only for the one ruled change and for a defect you show with a control), `scripts/assumptions.sh`, `scripts/assumptions-ledger.txt` (by `--write-ledger` only), `scripts/assumptions-controls.txt`, `scripts/gate_report.py`; **docstrings, and nothing but docstrings**, in the modules under `Proofs/` that the step's record names in its draft 8; `ARCHITECTURE.md` (§ 5, the new subsection); `plans/{JOB}-landing.md`, `tools/fs131_lt5_*.py`, `data/fs131/lt5/`, `data/fs131/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** any statement, definition or proof under `Proofs/`, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record; the two bibliography rows the step needed are filed)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. This library's claim is that everything in it reduces to what the kernel checked plus what was explicitly chosen to trust. Until
today nothing listed the second half of that sentence in full: the audit sees an outside theorem declared as an `axiom`, and does not see
a theorem that says "if Herglotz–Bochner holds, then …", which prints the standard three axioms and is counted clean. The project's owner
asked for the instrument, an implementer built it on a branch, and its first run on `main` found thirty-three such hypotheses — one of
them an outside theorem the coordinator's own search had missed. It is not on `main`. You put it there, on a library that has grown by
two landings since its list was made.

## Why this job

{item(551)}
{item(548)}
{item(562)}
A list kept by hand goes wrong the way mine did; a step that fails when a landing brings an assumption nobody declared does not. But the
step's verdict on a hypothesis is only as good as the one line that declares it — an assumption, or a mere condition on a theorem's
parameters — and every such line on the branch is one mind's reading. This landing is where a second reader sees them, and where the
step first meets modules its author never saw.

## The statements

No statement, definition or proof changes in this job. Docstrings change, and one of them by a ruling (item 562 (b)): the hypothesis
below is assumed — the second line takes it — and its docstring's "Named here, not imported" is true only of the third, which states it
under an equivalence. Read each whole, with its docstring:

{Q(H+"Plane/Slack.lean","def Voronov11 ")}
{Q(H+"Plane/Slack.lean","theorem mu_lt_of_voronov11 ")}
{Q(H+"Plane/Slack.lean","theorem forall_mu_six_lt_one_iff ")}
The outside theorem my search missed, as an instance of what the step finds and of a docstring that does not yet say whose it is:

{Q(H+"Bridge.lean","def RealAlgebraicDescent ")}
The step's own account of what a landing must do, and of the docstrings (read both sections whole in its record):

{Q(TR,"- **A wave that brings a named hypothesis**",HWAY)}
{Q(TR,"- **`KloostermanBound` becoming an axiom** (Weil's bound)",HWAY)}
{Q(TR,"- **The job removing `falconer_lemma2_nonempty`**",HWAY)}
{Q(TR,"- **When an assumption is proved**",HWAY)}
{Q(TR,"**8. Docstrings under `Proofs/`, for a landing to make**",HDR)}
The gate's recorded state on `main`, which your other counts are reconciled against:

{Q("CLAUDE.md","as a set); the current audit reads ","§ Trust ledger")}
{Q("CLAUDE.md","`declarations=","§ The gate")}
## Done means

1. **Your readback first**: check every quotation above against its source; read the step's record in full
   (`{TR}` — the design of Stage 2, what the first runs changed in Stage 3, the enumeration of Stage 5, "What is on its way", the
   drafts) and its report (`{T}data/fs131/reports/FS131-T5.md`); `scripts/Assumptions.lean`'s declared list on that branch, line by
   line; the two landings' records for what they brought (`/home/kooshi/source/lean-dir/{L10}` — its table of hypotheses, written for
   you — and `/home/kooshi/source/lean-dir/{L6}`, its drafts' list of named hypotheses and open gate items); `LEAN.md` § The gate,
   § Assumptions and § Trust ledger. Build the branch once as given (expect it up to date; no `sorry` anywhere: this is `main`). Open
   your record. Commit and push.
2. **The merge**: `git merge origin/fs131-t5` (at `{T5}`), its own commit. Trial it first; confirm by `git diff --stat` that it changes
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
   `--self-test` green, and the branch's mutation harness run once more on the joined tree** (`{T}tools/fs131_t5_mutate.py`, which the merge brings into your tree, as its
   record's Stage 6 ran it); `tools/check_architecture.py` exit 0; the guarded lint, `lake lint --no-build -- --no-build --trace` under
   the slot with `--mem 8`, silent; the notes check, `tools/fs131_qa4_notes.py`, no CONFLICT; the records check,
   `tools/fs131_l5_records.py`. Save every step's log under `data/fs131/lt5/` and name them.
10. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
    `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, say so with the diff that shows it, otherwise re-run the gate on the merged commit. Then
    `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and retry.
11. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes from: the
    step's record's drafts 1 and 3–5 brought to the landed state — the paragraph `CLAUDE.md` § Trust ledger gains, its nine counts read
    from your landed receipt; the sentence and the bullet for `LEAN.md` § The gate; the two bullets for § Assumptions; the row for
    § Trust ledger's table — and its draft 7, the line every landing brief carries from now on, corrected if the procedure moved.
    `ARCHITECTURE.md` § 5's new subsection (its draft 6) you write yourself, with the three tables as they stand on the landed tree.
    And **the enumeration itself, for the owner**: by kind, by name, in plain words what each assumes and where it comes from, with
    the count of statements on each, and what the step counts and cannot decide.
12. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the enumeration its first result.
    Leave no background process running. Stopping at a saved stage with the step red at a named failure you could not settle from
    the records is a good report — say which, its log, and whom the question is for.

## What is yours to decide

How each new module's hypotheses are declared, within the step's own procedure and the records; the wording of each docstring edit;
the order inside each step; whether a defect you find in the step's code is repaired here (with a control that shows it) or reported.
Three things are not yours: no statement moves; a declared condition does not become an assumption, or the reverse, on your reading
alone; and both forms stay enumerated — an assumption does not leave the list because of how it entered (the owner's word, item 551).
If the honest result is that the step cannot be made green on today's `main` without a decision that is not yours, land nothing and say
exactly what is needed. Do not weaken a check to pass it. Three failed attempts on one route is a dispatch to the companion your
identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-gate-step-land.md","w").write(b)
print("written",JOB,"at tip",TIP,"t5",T5)
