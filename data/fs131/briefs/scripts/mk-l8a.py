exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
TREE="fs131-w8l"; JOB="FS131-L8A"; L=WT+TREE+"/"
def tip(ref): return subprocess.run(["git","-C",ROOT,"rev-parse","--short=8",ref],capture_output=True,text=True).stdout.strip()
TIP=subprocess.run(["git","-C",L,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert TIP,"make the worktree first"
MAIN=tip("origin/main"); D8=tip("origin/fs131-w8d")
P="Proofs/HadwigerNelson/Plane/RingCalculus/"; WD=WT+"fs131-w8d/"
LT="plans/FS131-LT5-landing.md"
b=f'''# Brief {JOB} — wave 8's first landing: the two parallel branches joined, `main` merged, what the wave assumes declared, the full gate on one commit with its newest step, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the landing implementer of wave 8's first two planning passes — merge the second parallel implementer's branch into the first's, check that the joined line holds no open leaf, merge `main`, make a short list of docstring corrections, declare to the gate what the wave assumes, read every head's statement from the kernel, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page lines for the filing
  launch: now, in a tree of its own cut from the first parallel implementer's tip; other jobs work on other waves in trees of their own and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict in a Lean file, a declaration that still prints `sorryAx` after the join (at once: it means a leaf thought proved on the other branch is not, or its statement differs), a gate step red for a reason you cannot repair within your touches (the vacuity scan reading a new site as vacuous or unknown, an audit record outside the standard three, a name declared twice, the assumptions step asking for a declaration no record of ours explains), a head whose statement in the kernel differs from what its file shows, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w8c` at `{TIP}`): the merges' files; the wave's modules under `{P}` — **docstrings only**, for the corrections listed below; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt` only if a control's expected count moves with your state; `scripts/Assumptions.lean` (its declared list only), `scripts/assumptions-ledger.txt` (by `--write-ledger` only); the vacuity scan's files where its own procedure sends you (`scripts/vacuity-baseline.txt` — its header's count lines only, after the scan's final run; an entry is a message to me); `plans/{JOB}-landing.md`, `tools/fs131_l8a_*.py`, `data/fs131/l8a/`, `data/fs131/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** any statement, definition or proof, any landed module beyond what a merge brings, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing wave 8 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, the first half of wave 6 and wave 10 are on `main`. Wave 8 is the *ring calculus*: what the unit circle
about a vertex of a valid map (its *ring*) carries, in the class with no Siamese pair. Two planners stated it, and five implementers
proved every leaf they stated — the last two today, in parallel, each over the other's statements. No tree has held all of it at once.
You make it one line, the kernel checks the whole chain for the first time, and it goes to `main` through a gate that since today
also lists everything a theorem assumes.

## Why this job

A wave counts as held only when its declarations pass the full gate on one commit (the milestone's announcement rule,
`plans/FS131-close-inventory.md`); nothing with a `sorry` reaches `main`. Until the join, most of this wave's second half is proved
over a leaf proved on the other branch under the same statement. This job is where that becomes a kernel fact or shows a seam. The
hand-backs and rulings behind it (read each item whole in the inventory):

{item(569)}
{item(572)}
{item(586)}
{item(592)}
{item(597)}
{item(598)}
{item(591)}
## The statements

No statement, definition or proof changes in this job. Heads of the wave, as they stand on the two branches — after the join each must
print the standard three and nothing else (read each whole):

{Q(WD+P+"Empty.lean","theorem emptyNS ")}
{Q(WD+P+"Empty.lean","theorem outerAdj ")}
{Q(L+P+"Star.lean","theorem star_anti ")}
{Q(L+P+"SemiHub.lean","theorem ringArc_star ")}
{Q(WD+P+"SemiHubPlaces.lean","theorem semiHub_places ")}
The gate's recorded state on `main`, which your counts are reconciled against, and the line every landing carries since the gate's
newest step landed:

{Q("CLAUDE.md","as a set); the current audit reads ","§ Trust ledger")}
{Q("CLAUDE.md","**What the library assumes, in both forms**","§ Trust ledger")}
{Q("CLAUDE.md","`declarations=","§ The gate")}
{Q(LT,"> A wave that brings an assumption in hypothesis form")}
## Done means

1. **Your readback first**: check every quotation above against its source; read the two parallel implementers' reports and the last
   sections of their records ("for the join", their drafts — on your branch `{L}plans/FS131-I8C-implementation.md`; on the other,
   `{WD}plans/FS131-I8D-implementation.md`), the join job's and the first implementer's records on your branch, the planners' record
   (`{L}plans/FS131-w8-kernel-plan.md`), `LEAN.md` § The gate and § Assumptions as they stand on `main` today (they changed this
   afternoon: read them on `main`, not on your branch), and the last landing's record for the gate's procedure with its newest step
   (`/home/kooshi/source/lean-dir/{LT}`). Build the branch once as given (seven `sorry`: six in `SemiHubPlaces`, one in `Empty` —
   each proved on the branch you are about to merge). Open your record. Commit and push.
2. **The join**: `git merge origin/fs131-w8d` (at `{D8}`), its own commit. My trial conflicts in `ARCHITECTURE.md` and
   `scripts/Axioms.lean` only — adjacent additions, keep every side; a conflict in a Lean file is a message to me. Committed as a
   merge, the index holding the merge and nothing else. Build. **The receipt that the wave is whole**: zero `sorry` under `Proofs/`;
   every declaration the five implementers' reports name — their clean records and every one they list as resting on the other
   branch's leaves — on exactly the standard three or a subset, with a control that fires; no statement of either side changed by
   the merge (by script, on elaborated signatures: the wave's tools are in `tools/` on your branch).
3. **`main` merged in** (at `{MAIN}` when this was written): this line last had `main` before wave 5 landed. Trial it first and
   name the conflicts before you make it (my trial: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` — adjacency, keep every
   side). A conflict in a Lean file under `Proofs/` is a message to me. Build.
4. **The docstring corrections, and nothing else in the modules** (each shown by script to touch no line outside a doc comment):
   the sentence of `fullSemiHub_star_crossed`'s docstring that says four colours follow from `germS_absent` (they do only at six
   colours: inventory item 592); the five statements ruled there say "inventory item 592" where they say "ruled on FS131-I8D's
   finding"; `SemiHub`'s line of prose that holds the word `sorry`; `ARCHITECTURE.md`'s row for `StarChart`, which still says no
   module imports it. **Not made, by ruling 598 (b)–(c)**: no row is restated at its wider class, and `Empty` keeps its import of
   `SemiHub` through `OuterAdj`.
5. **Every head's statement, read from the kernel** (inventory item 556): for every theorem the wave's records name as a head, the
   stored type's binders against its file's signature and the section variables in scope — the last landing's instrument does this
   for a list of modules (`tools/fs131_l10b_kernelsig.py` with `data/fs131/l10b/kernel-sigs.lean`, on `main`). A hypothesis missing
   from a kernel statement is a message to me with the head's name.
6. **What the wave assumes, declared** (the line quoted above; the procedure is `LEAN.md` § Assumptions on `main`): run
   `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh`, and read every failure before you declare anything. For
   each: an assumption (with its kind and a source that is a bibliography key, a ledger row or a derivation entry's id), or a
   condition with its reason — decided from the definition's docstring and the planners' records, never from the name. This wave's
   planners expected no named hypothesis (one was planned and found unnecessary: item 571); if the step finds one no record
   explains, that is a message to me. Then `--write-ledger`, every row it gains or loses read and listed.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; the
   doubled-name check after the build and before the axiom audit — `/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8
   -- ./scripts/dupnames.sh`, then its `--self-test` under `--mem 4 --cpus 4`; `scripts/axioms.sh` clean, every record of the wave
   registered and within the standard three, `--self-test` green; `scripts/vacuity.sh` and `--self-test` green, the counts
   reconciled against the line above — this wave brings refutations and theorems whose hypotheses no Lean object is yet known to
   meet (a star, a semi-hub, two adjacent change points, a nine-colour model for `emptyNS`: each owed, and said so in its
   docstring): say how the scan classes every new site, and a site read as vacuous or unknown, or a request for a baseline entry, is
   a message to me with the scan's line; `./scripts/assumptions.sh` and its `--self-test` green (the nine counts on the front page
   will read stale until I refile them: flagged, not failed); `tools/check_architecture.py` exit 0; the guarded lint,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, silent; the notes check by its working-tree wrapper,
   `tools/fs131_l5_notes.py`, no CONFLICT; the records check (`tools/fs131_l10b_records.py`, as the last landing ran it). Save every
   step's log under `data/fs131/l8a/` and name them.
8. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run the gate on the
   merged commit. Then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push,
   fetch, merge and try again.
9. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes from: the
   `CLAUDE.md` § Trust ledger sentence's counts and its nine assumption counts; § The gate's two count lines; a `GATE_CHANGES` entry
   for `tools/claude_md_fact_audit.py` (the previous landing's receipts are `data/fs131/lt5/gate/receipt-axioms-landed2.log`,
   `data/fs131/lt5/gate/receipt-vacuity-landed2.log` and `data/fs131/lt5/gate/receipt-assumptions-landed2.log`); the five implementers' and two planners'
   drafts gathered and corrected for what the join changed (`LEDGER.md` regrades — FS116-V5-QCOL's with "all clauses but the one
   never stated"; `plans/LEAN-BACKLOG.md` rows; the errata for the rows the wave found wider or narrower than filed, each with the
   Lean name that shows it); **the open gate items at this landing**, by name; and what a third planning pass still has to state
   (two rows and one clause).
10. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the wave's heads and record
    counts read from the gate's saved logs. Leave no background process running. Stopping at a saved stage with the gate red at a
    named check is a good report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how the registry files are resolved, how the vacuity scan's new sites and the assumptions step's
failures are handled under their own procedures, and whether a docstring correction is deferred (say which, and why). If the join
shows something no job could see from its branch — a declaration still on `sorryAx`, a statement the two branches hold differently, a
name both declared — that is a finding, and the first of those is the one this job exists to look for: fix what is within your
touches and ruled, and message me for the rest. Do not weaken a check to pass it. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave8-land.md","w").write(b)
print("written at tip",TIP,"main",MAIN,"w8d",D8)
