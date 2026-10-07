exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-L2: the landing of the first night's exclusion — fs132-wi4 (the skeleton, the port, the proofs) through the full gate
# and onto main, without the two skeleton modules. Worktree fs132-wl2, cut from fs132-wi4's tip (make it first).
import subprocess,os
TREE="fs132-wl2"; JOB="FS132-L2"; L=WT+TREE+"/"
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TIP=sh("git","-C",L,"rev-parse","--short=8","HEAD"); assert TIP,"make the worktree first"
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
RQ="data/external/EXT-OAI1-request.md"; INV2="plans/FS132-close-inventory.md"
S=L+"Proofs/HadwigerNelson/Plane/SixRing/"; O=L+"Proofs/HadwigerNelson/Outside/"
os.makedirs(ROOT+"data/fs132/l2",exist_ok=True)
IDENT_L="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(n,c):
    l=line(INV2,f"{n}. **",c); return "> "+l+"\n> — source: "+INV2+" § Items\n"
ITEMS="\n".join(inv(n,c) for n,c in ((40,"FS132-I2 done"),(44,"FS132-I3 done"),(46,"FS132-I4, third message"),(47,"FS132-I4 done")))
THM="\n".join([Q(S+"Orbit.lean","theorem no_outside_orbit_points "),Q(S+"Orbit.lean","theorem no_outside_orbit "),Q(S+"Orbit.lean","theorem not_ae_outside "),
               Q(S+"TwoPairs.lean","theorem no_alternating_pairs ")])
ROW=Q("LEDGER.md","| 155 | **The (Q)-free exclusion with no map and no Siamese clause:")
GATE="\n".join([Q("CLAUDE.md","as a set); the current audit reads ","§ Trust ledger"),Q("CLAUDE.md","**What the library assumes, in both forms**","§ Trust ledger"),Q("CLAUDE.md","`declarations=","§ The gate")])
b=f'''# Brief {JOB} — the landing: the first night's exclusion, with the outside lemmas ported under it, through the full gate and onto `main`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_L}
  role: the landing implementer of this milestone's first theorem — take a branch on which four colleagues' work compiles together, cut from it the two modules that are still skeletons, join it with `main`, finish its registrations, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in a tree of your own cut from the branch's tip; a deriver works under `plans/` and `data/` on `main` and a planner of another milestone on a branch of its own — neither writes a file you write; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a gap between one of the four theorems below and the sentence it is read aloud against; a declaration that prints an axiom other than the ones its record files; the vacuity scan reading a new site as vacuous or unknown, or the assumptions step having no class for a condition these modules introduce; a merge conflict in a Lean file; a gate step red for a reason you cannot repair within your touches; or a question you cannot work around. **And one line when the gate is green on the commit you will push, before you push.** The report goes to `data/fs132/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from branch `fs132-wi4` at `{TIP}`; its `.lake/build` is its own copy, made today): the merge of `main`; the removal of the two skeleton modules with their lines; under `Proofs/HadwigerNelson/`: docstrings and module headers of the landing's modules, and the generated outside modules **through their generator only**; a copy of the release's licence text beside the ported modules; `Proofs.lean`, `ARCHITECTURE.md`; `scripts/Axioms.lean` (blocks for every declaration the landing brings), `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the second by `--write-ledger` only), `scripts/axioms-controls.txt` only if a control's expected count moves with your state, `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); the port's tools under `tools/` where a re-run needs them; `plans/{JOB}-landing.md`, `tools/fs132_l2_*.py`, `data/fs132/l2/`, `data/fs132/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** the statement of any theorem or definition (a statement that must change is a message), the import module's two axioms, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py`, the derivation files (drafts for those go in your record), the outside clone at `/home/kooshi/source/math` and the audit's working copy under `/home/kooshi/.cache/ext-oai1` (read; write nothing there)
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k — you cannot read that count, so use this: **save a stage after each numbered item below, and if you have made three full gate runs without a green one, stop at a saved stage and hand back**

Hello. Last night a deriver of this project wrote, by hand, a proof that in a measurable six-colouring of the plane a point
where four colour classes meet in a cycle cannot have the unit circle about it show the two remaining colours in a certain
pattern. Today, within about fourteen hours, a planner stated that proof as forty-nine leaves, an implementer ported the three
outside lemmas it rests on with their proofs, and two more implementers proved every leaf. On the branch you stand on, the
theorem's axiom print reads the standard three. It has never been through the gate. You take it there, and onto `main`.

## Why this job

A result of this project is "held" only when its module passes the gate with its imports named — until then the ledger's
row for this theorem says "by hand, one mind". The gate is what stands between a proof that compiles and a statement a
reader who trusts none of us may rely on: that the theorem says what the row says, that no hypothesis is empty by accident,
that everything it assumes is declared, that nothing rests on a `sorry` or an axiom nobody filed. Kooshi put this theorem
first this morning, and asked that what it rests on be formalized with it; his words:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
How the branch came to be, and what its authors left for you (read each item whole in `{INV2}`):

{ITEMS}
## The statements

**No statement changes in this job.** The four theorems the landing is for, in your worktree (`{S}Orbit.lean` and
`{S}TwoPairs.lean`; read each whole, with its docstring and the definitions it names):

{THM}
**The row they are read aloud against**, as filed this morning ([hand], one mind, with a checking reading — the grade your
landing lets the filing change, for the whole plane only):

{ROW}
and the theorem record's entries, `plans/FS132-derivation.md` § 1 (C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL, C132-DIAG-WIDE):
the entries are written on an open set containing the closed unit disc; **the Lean theorems are at the whole plane**, and the
paragraph "What it stands on" in that section says what differs.

**The gate's recorded state on `main`**, which your counts are reconciled against:

{GATE}
**The four records to read**, each in your worktree: the planner's (`{L}plans/FS132-kernel-plan.md`, Stages 4 to 7:
the modules, the models in the basic module, each leaf's readback); the port's (`{L}plans/FS132-I2-implementation.md`: the cone, the
generator, the read-back across the two toolchains, §§ 3.4–3.5, its drafts D1 to D7); the two implementers'
(`{L}plans/FS132-I3-implementation.md`, `{L}plans/FS132-I4-implementation.md`: what each proved, the hypotheses dropped, their drafts). And on
`main`: the last landing's record, `plans/FS132-L1-landing.md`, for the gate's procedure step by step, with its receipts
under `data/fs132/l1/gate/`.

## Done means

1. **Your readback first**: check every quotation above against its source; read the four records and the last landing's
   record; `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`. Build the branch once as given
   (it should print 19 `sorry` warnings, all in two modules). Open your record. Commit and push.
2. **The cut.** Remove the two skeleton modules — the index lemmas' and the centres' — with their lines in `Proofs.lean` and
   their rows in `ARCHITECTURE.md`; they stay on the planner's branch for their own jobs. Confirm no module imports them
   (I found only the root file) and that `Proofs/` then holds **zero `sorry`**, by a search that would see one (plant one,
   watch it fire, remove it). Build.
3. **`main` merged in** (at `{MAIN}` when this was written). Trial it first and name the conflicts before you make it: I
   expect none in a Lean file — `main` has moved only in plans, data and the front files since the branches were cut. A
   conflict in a Lean file under `Proofs/` is a message to me. Build.
4. **The port's three loose ends.** (a) A byte-identical copy of the release's licence text (`/home/kooshi/source/math/LICENSE`)
   beside the ported modules, under a name that says whose it is, and each generated header naming it — through the
   generator. (b) The three instances on Mathlib types in the palette module (the port's record § 3.5): make them scoped
   through the generator if every module still builds; if one cannot be, keep it and say in the header why it is safe; say
   which in your record. (c) Re-run both stored-term comparisons on the joined tree — the import's
   (`tools/fs132_i1_readback.py`: the two axioms and the copied definitions, identical to the release's) and the port's
   (`tools/fs132_i2_readback.py compare`, as its record's § 3.3 runs it) — with their planted faults still firing. Any
   change of verdict: message me before repairing it.
5. **The registrations.** Every declaration the landing brings is in a block of `scripts/Axioms.lean` (three groups are in
   none: the planner's basic and confinement modules and one lemma of the palettes' module; the palette module's own
   declarations), each filed on what it rests on — nothing here should rest on either declared outside theorem, and the
   wrong-filing control must still fire. The six architecture rows and the one module docstring that still name the
   planner's branch or say "sorry until implemented" (the last implementer's draft D7) are corrected. The two modules that
   state one identity under two names: leave both unless one edit to an import removes one with no cycle; say what you did.
6. **What the library assumes.** These modules introduce conditions on parameters that no theorem concludes — the orbit's
   hypothesis, the hub's colours, the relation with no double change, the four-cycle's straddle condition, a tip, the
   shift's bounds, a density point. Read `LEAN.md` § Assumptions and the assumptions script for how such a condition is
   declared (a hypothesis standing for an outside theorem, for a hand result of ours, or for an open question is one thing;
   a condition with a model in the same module is another); run `./scripts/assumptions.sh --self-test`, then
   `./scripts/assumptions.sh`, read every failure before `--write-ledger`, and list every row the ledger gains. If the
   scheme has no class for one of them, message me with the script's line.
7. **The vacuity step**, with care — this is a theorem that concludes `False`. `scripts/vacuity.sh` and its `--self-test`;
   say how the scan classes every new site, and in particular how it treats the four theorems (a refutation's hypotheses
   are meant to be jointly unsatisfiable; what the gate asks is that each *structure* of hypotheses has an inhabitant short
   of the conclusion — the planner's basic module holds the models: name the model for each). A site read as vacuous or
   unknown is a message to me with the scan's line.
8. **Read aloud.** In your record, each of the four theorems against the row's sentence and the entry's statement, clause by
   clause — the colouring's class, the four labels and the two others, the points and their straddle sets, the two clauses
   on the ring, the conclusion — and what the Lean statement does **not** say that the row does (the open-set form), in
   words the filing can use.
9. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; the
   doubled-name check after the build and before the axiom audit (`./scripts/dupnames.sh` under the slot with `--mem 16`,
   then its `--self-test`); `scripts/axioms.sh` clean with `--self-test` green — still three declared outside axioms, every
   new record clean; `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above;
   `./scripts/assumptions.sh` and its `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, silent; the notes check and the records
   check as the last landing ran them. Take the three digests against the previous landing's receipts
   (`data/fs132/l1/gate/receipt-axioms-final.log`, `data/fs132/l1/gate/receipt-vacuity-final.log`,
   `data/fs132/l1/gate/receipt-assumptions-final.log`). Save every step's log under `data/fs132/l2/` and name them.
   **Message me one line when it is green, before you push.**
10. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`,
    `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run
    the gate on the merged commit. Name the merged commit by its hash in every check, never by a ref. Then
    `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge
    and try again.
11. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes
    from and **the exact words on `main` it replaces**: `CLAUDE.md` § Trust ledger (the audit's sentence with the joined
    tree's counts; the assumption counts) and § The gate's two count lines; a `GATE_CHANGES` entry; the Frontier's sentence
    on this milestone's Lean phase; `LEDGER.md` row 155 — its grade sentence for the whole plane, with what stays by hand
    (the open-set form) and the names and addresses of the four theorems; the dated lines for the theorem record (the three
    implementers' drafts, reconciled into one); `LEAN.md` (the port's draft for § Assumptions on porting an outside Lean
    proof; the last implementer's three bullets); `BIBLIOGRAPHY.md` (the port's draft for the release's row); the atlas
    grade for the exclusion's node. And **the open gate items at this landing**, by name, if any.
12. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the counts read from
    the gate's saved logs. Leave no background process running. **Stopping at a saved stage with the gate red at a named
    check is a good report** — say which check, its log, and what you would try next.

## What is yours to decide

The order of the registrations; how the instances are scoped; the wording of docstrings and rows; how each gate step's
finding is repaired within your touches. Not yours: any statement — if the gate shows a theorem says less or other than its
row, that is the most valuable message this job can send, and nothing is repaired around it. Three failed attempts on one
route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs132/briefs/"+JOB+"-landing.md","w").write(b)
print("written",JOB,"tip",TIP,"main",MAIN,len(b))
