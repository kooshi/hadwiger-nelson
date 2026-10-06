exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
TREE="fs131-w10m"; JOB="FS131-L10B"; L=WT+TREE+"/"
def tip(ref): return subprocess.run(["git","-C",ROOT,"rev-parse","--short=8",ref],capture_output=True,text=True).stdout.strip()
TIP=subprocess.run(["git","-C",L,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert TIP,"make the worktree first"
MAIN=tip("origin/main"); F1=tip("origin/fs131-wf1")
A="Proofs/HadwigerNelson/Arith/"; P="Proofs/HadwigerNelson/Plane/"
WK=L+A+"WeilKloosterman.lean"; WF=WT+"fs131-wf1/"
KP=WT+"fs131-w10k/plans/FS131-w10-kernel-plan.md"
H166="§ 16.6 For the wave's second joining job (replacing § 9.4's list where they differ)"
b=f'''# Brief {JOB} — wave 10's second landing: the proved second pass and the import of Weil's bound joined with `main` and with the proof of Falconer's lemma, the ruled tidies, the full gate on one commit, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the landing implementer of wave 10's second planning pass — merge `main` and the branch that proves Falconer's lemma into the commit that holds the pass proved and the import declared, make the short list of ruled tidies (one of them a ruled statement change), run the full gate on one commit with its newer steps, read every head's statement from the kernel, fast-forward `main`, and draft the counts and the front-page lines for the filing
  launch: when a slot frees, in a tree of its own cut from the import's commit; other jobs work on other waves in trees of their own, and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict beyond the kinds named below, a gate step red for a reason you cannot repair within your touches (the vacuity scan reading a new site as vacuous or unknown, an audit record outside the standard three that is not one of the eight on the import, a name declared twice), a ruled tidy that does not go through as ruled, a head whose statement in the kernel differs from what its file shows, a declaration on `sorryAx`, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w10k`'s history at `{TIP}`): the merges' files; the modules under `{A}` that the wave's two planning passes and their implementers wrote, and the import's module, for the ruled tidies and their docstring lines only; `{P}FalconerReduction.lean` and `{P}MetricalBoundary.lean` only as the merge brings them; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt`; the vacuity scan's files where its own procedure sends you (`scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity.sh`, `scripts/vacuity-baseline.txt` — the last only on my word); `plans/{JOB}-landing.md`, `tools/fs131_l10b_*.py`, `data/fs131/l10b/`, `data/fs131/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** any statement but the one ruled below, any landed module beyond what a merge or a ruled tidy brings, the third pass's three skeleton modules (they hold `sorry` leaves, are on another branch and are not part of this landing), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing the second half of wave 10 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, a library of example maps, wave 10's first four files and the first half of wave 6 are on `main`. Wave 10
is the arithmetic wave. Its second planning pass stated ten more modules, three implementers proved every leaf of them, and its third
planner then did the one thing a milestone here may do instead of proving: it declared an outside theorem — Weil's bound for Kloosterman
sums, in the words of the 1948 page — as an `axiom`, with the four things an import must carry. On that commit the library holds, with no
`sorry`, that every finite target of the standing field refuses six colours. Meanwhile another implementer **proved** the only outside
axiom the library had declared until then (a lemma of Falconer's), on a branch of its own. You join the three lines. After your landing
`main` declares exactly one outside axiom, and for the first time one that was read against its page by two readers.

## Why this job

A wave counts as held only when its declarations pass the full gate on one commit (the milestone's announcement rule,
`plans/FS131-close-inventory.md`); nothing with a `sorry` reaches `main`. An import is the one thing here the kernel does not check, so
the audit's account of it — which records rest on it, and that nothing else does — is this landing's first product. Kooshi, on what the
evidence must be, and on what a reader must be shown of what the library assumes:

{Q("CLAUDE.md","- **The artifact is the certificate plus the checker, never the search.**","§ The standard of evidence above rung B")}
{item(551)}
The hand-backs this landing joins, and the rulings in force (read each whole in the inventory):

{item(535)}
{item(538)}
{item(542)}
{item(547)}
{item(554)}
{item(555)}
{item(559)}
{item(556)}
The third planner's own list for this job — it replaces nothing above, and where it and this brief differ this brief is later (read the
whole section, and its §§ 15.2–15.4 and 16.2, which it cites):

{Q(KP,"- **The import at the gate** (`LEAN.md` § Trust ledger)",H166)}
{Q(KP,"- **Edits owed in landed or fixed modules, the landing's**",H166)}
**One thing in that list is superseded**: it expects two declared imports and twelve imported records. Falconer's lemma has since been
proved, so on the joined tree the declared imports are **one** (`StandingFive.kloosterman_bound`) and the imported records **eight**; the
four records that rested on Falconer's axiom are under CLEAN, on the standard three.

## The statements

**One statement changes, by ruling 542, and no other.** As it stands (read it whole): its hypotheses `hG : Measurable G` and
`hc : ∀ x, Measurable (c x)` are dropped — the proof reads neither — and `[Finite K]` becomes `[Countable K]`; the name stays; every
caller's line is adjusted and nothing else of the caller.

{Q(L+A+"MajorityVote.lean","theorem ae_eq_measurable_of_majority ")}
The import, and heads that rest on it — each of these prints the standard three **and** `StandingFive.kloosterman_bound`, and nothing
else:

{Q(WK,"axiom kloosterman_bound.{u} ")}
{Q(WK,"theorem standingFloor_seven_weil ")}
{Q(WK,"theorem seven_le_localBound_weil ")}
{Q(WK,"theorem targetFloor_six_weil ")}
Heads that rest on no import — each prints the standard three or a subset:

{Q(L+A+"Floor128.lean","theorem targetFloor_eight_128 ")}
{Q(L+A+"SpectralInputs.lean","theorem sp_if ")}
{Q(WF+P+"FalconerReduction.lean","theorem falconer_lemma2_nonempty ")}
{Q(WF+P+"MetricalBoundary.lean","theorem exists_not_tendsto_ratio_and_compl ")}
The gate's recorded state on `main`, which your counts are reconciled against:

{Q("CLAUDE.md","as a set); the current audit reads 6148 clean and 5 declared purchases","§ Trust ledger")}
{Q("CLAUDE.md","`declarations=14299 refutations-skipped=199 sites=1269`","§ The gate")}
## Done means

1. **Your readback first**: check every quotation above against its source; read the third planner's record
   (`{KP}`, Stages 10–16 — your own tree holds it through Stage 13 only, so read it there), the three second-pass implementers' reports
   on your branch under `data/fs131/reports/`, the report and the record of the job that proved Falconer's lemma
   (`{WF}data/fs131/reports/FS131-IF1.md`, `{WF}plans/FS131-IF1-implementation.md` — its last section says what the join must know),
   and the last landing's record for the gate's procedure (`/home/kooshi/source/lean-dir/plans/FS131-L6A-landing.md`, its gate and
   landing stages). Build the branch once as given (no `sorry` anywhere at `{TIP}`). Open your record. Commit and push.
2. **The merges**, each its own commit, each trialled before it is made and checked before the next. (i) `git merge origin/main` (at
   `{MAIN}` when this was written: wave 6's first half and the filing). My trial on your base conflicts in `scripts/Axioms.lean` only —
   adjacent additions, keep every side. (ii) `git merge origin/fs131-wf1` (at `{F1}`): against `main` alone it is clean; against your
   base it conflicts in `ARCHITECTURE.md` and `scripts/Axioms.lean`, where the planner added the new import's row and declaration beside
   the ones this branch removes. The resolution is the joined state, not a side: Falconer's `declareImport` line and its row in
   `ARCHITECTURE.md`'s list of imported outside theorems are **gone**; the new import's line and row **stay**; Falconer's four records
   are under CLEAN; the eight records on the new import are under IMPORTED. `scripts/axioms-controls.txt` may merge with no conflict and
   still describe neither state — set its expected counts to the joined one (one declared import, eight imported records), each control
   shown red before and green after; commit `082f86c9` on `main` is the pattern for that edit. A conflict in a Lean file under `Proofs/`
   is a message to me. A merge is committed as a merge, the index holding the merge and nothing else, checked. Build.
3. **The ruled tidies**, each checked by script to be exactly what is ruled: (i) the statement change above, with its callers; (ii)
   `NumberField standingField` becomes a global instance — one word, `local instance` to `instance`, in the landed module `StandingFive`,
   for the reason the planner's § 15.3 gives; (iii) docstrings corrected to what the kernel now holds, base text otherwise intact — `involution_eq_pow`'s names the proof it
   has (ruling 538 (b)); `sp_if`'s names its model `sp_if_hypotheses_trivial_bot` and says that one named classical hypothesis is still
   assumed (ruling 547 (a)); the two Bézout identities stay and their docstring says they are an independent witness; the four notes of
   the planner's § 16.2; the lines that still say Weil's bound is "not held … never an `axiom`"; `ARCHITECTURE.md`'s rows that still say
   "skeleton" for modules now proved; (iv) **nothing else** — `StandingFive.seven_le_localBound` and `five_le_chromaticNumber` keep their
   hypothesis forms beside the new heads, and hypotheses that rulings kept unread stay (ruling 419 (c)).
4. **Every head's statement, read from the kernel** (item 556: a section `variable` enters a theorem only if its statement mentions it,
   so a leaf can lack a hypothesis its file shows, and a comparison of text cannot see that). For every theorem the wave's records name
   as a head — the eight above and each row's head in the three second-pass reports and the planner's § 16 — a `#check` from a file
   under `data/fs131/l10b/`, run with `lake env lean` under the slot, its output saved; then, by script or by eye, each printed
   signature against the binders its file shows and against the sentence of its row. A hypothesis missing from a kernel statement is a
   message to me with the head's name, even where the theorem is proved: it means the row is stated wider than was read back.
5. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`;
   **the doubled-name check on the joined tree, after the build and before the axiom audit** —
   `/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8 -- ./scripts/dupnames.sh`, then its `--self-test` under `--mem 4 --cpus 4`
   (with a doubled theorem name an axioms print can be clean over a `sorry` copy; the planner's § 16.6 lists the names this wave
   declares in existing namespaces); `scripts/axioms.sh` clean — every record of the wave registered, **exactly eight under IMPORTED,
   each on the standard three and `StandingFive.kloosterman_bound` and nothing else, and no record anywhere on
   `falconer_lemma2_nonempty` as an axiom** — and its `--self-test` green; `scripts/vacuity.sh` and `--self-test` green, the counts
   reconciled against the line above, every new site's class said, and a new site read as vacuous or unknown, or a request for a
   baseline entry, is a message to me with the scan's line; `tools/check_architecture.py` exit 0; **the guarded lint**,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), silent; **the notes check**,
   `tools/fs131_qa4_notes.py`, no CONFLICT; **the records check** against the kernel's own list of theorems
   (`tools/fs131_l5_records.py`, as the last landings ran it: every hand-written theorem of the wave has one record, on the standard
   three or a subset, or on the import if it is one of the eight). Save every step's log under `data/fs131/l10b/` and name them.
6. **The gate's new step is not yours, but two things of it are.** A tooling job (FS131-T5, done; branch `fs131-t5`) built a step
   that lists every assumption the library makes — outside axioms, and hypotheses standing for outside theorems, hand results of ours
   and open questions — with the statements resting on each. It lands in a job of its own right after you (inventory item 562); you
   do not merge it or run it. (i) Its record
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wt5/plans/FS131-T5-assumptions.md`, the section "What is on its way") says
   what your join does to the **axiom audit's** controls: `baseline`, `imported_declared` and `banner_dropped` in
   `scripts/axioms-controls.txt` read `main`'s one declared import and its four records, and on your joined tree the one declared
   import is another axiom, with eight — read that section before you set them in step 2. (ii) Your drafts' table of hypotheses
   (step 8) is written so that job can declare from it: for each hypothesis a theorem of this wave takes — named, or written out in a
   binder — its full name (or the theorem and the binder), its kind (an outside theorem, a hand result of ours, an open question),
   its source (a `BIBLIOGRAPHY.md` key, a ledger row, a derivation entry's id) and the theorems that take it. A hand result written
   out over a theorem's own variables is the one thing that step cannot find by itself, so say plainly whether the wave has any.
7. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, say so with the diff that shows it, otherwise re-run the gate on the merged commit. Then
   `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
8. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes from: the
   `CLAUDE.md` § Trust ledger sentence's counts (clean, purchases, **imported records** — a count of records, not of axioms — and
   axiom-free), with the sentence that the library now declares one outside axiom; § The gate's two count lines; a `GATE_CHANGES` entry
   for `tools/claude_md_fact_audit.py` (the previous landing's receipts are `data/fs131/l6a/receipt-axioms-first.log` and
   `data/fs131/l6a/receipt-vacuity-first.log`); the planner's § 16.7 drafts and the Falconer job's drafts gathered and corrected for what
   the join changed (`BIBLIOGRAPHY.md` rows for Weil's paper, for the paper whose three theorems the planner read back, for Falconer's
   and the unheld lemma it cites; the sentence for `LEAN.md` § Assumptions on stating an import in its paper's own form;
   `plans/LEAN-BACKLOG.md` rows; `LEDGER.md` clauses, said about the norm-one Cayley graph and not about "the plane" until the link is
   proved); **the named hypotheses each landed theorem rests on, by name** (the table of step 6 (ii)); **the open gate items at this landing** (a theorem whose hypotheses no Lean object on `main` satisfies at once, or
   that still assumes a named hypothesis — `sp_if` is one); and the generalizations the reports found, as a list for the wave's errata.
9. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the wave's heads and record counts
   read from the gate's saved axioms log. Leave no background process running. Stopping at a saved stage with the gate red at a named
   check is a good report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how the two registry files are resolved to the joined state, how the vacuity scan's new sites are registered
under its own procedure, and whether a docstring tidy is deferred (say which, and why). The statement change is ruled and is not yours to
widen or narrow; if it does not go through as ruled — a caller needs a dropped hypothesis for a reason of its own — that is a message to
me, and the lemma lands as it stands. If the join shows something no job could see from its branch — a record the audit reads differently
on the joined line, a name two branches both declared, a head whose kernel statement is not its file's — that is a finding: fix what is
within your touches and ruled, and message me for the rest. Do not weaken a check to pass it. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave10-land.md","w").write(b)
print("written at tip",TIP,"main",MAIN,"wf1",F1)
