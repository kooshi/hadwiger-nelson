exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-L1: the import's landing — fs132-wi1 joined with main (after FS132-F1's filing is merged), one consequence added,
# the full gate on one commit, main fast-forwarded, the drafts for the filing. Run this generator only AFTER the filing's merge:
# it asserts the merge is on main (the front page says six) so that the brief's quotations are of the filed text.
import subprocess,os
TREE="fs132-wi1"; JOB="FS132-L1"; L=WT+TREE+"/"
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TIP=sh("git","-C",L,"rev-parse","--short=8","HEAD"); assert TIP,"the import's worktree is gone"
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
cm=open(ROOT+"CLAUDE.md").read()
assert "[OAIMath2026]" in cm and "open at six against seven" in cm, "run after FS132-F1's branch is merged: the front page does not say six yet"
M="Proofs/HadwigerNelson/Outside/OAI158.lean"; RD="plans/EXT-OAI2-reading.md"; AU="plans/EXT-OAI1-audit.md"
I1=L+"plans/FS132-I1-implementation.md"
IDENT_L="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
b=f'''# Brief {JOB} — the import's landing: two outside theorems of `[OAIMath2026]` enter this library through the full gate, with the one question as a theorem

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_L}
  role: the landing implementer of the import — merge `main` into the import's branch, add one two-line consequence and register it, re-run the stored-term comparison on the joined tree, write the assumptions ledger's new rows, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in the import's own tree; two derivers work under `plans/` and `data/` on `main` and commit nothing else there; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a stored term of either imported statement or of a copied definition that no longer reads identical to the release's after `main` is merged (whatever the cause and however harmless — inventory item 629, ruling (a)); a merge conflict in a Lean file; a declaration that prints an axiom other than the ones its record files; a gate step red for a reason you cannot repair within your touches; the vacuity scan reading a new site as vacuous or unknown; or a question you cannot work around. The report goes to `data/fs132/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): the merge's files; `{M}` — **one theorem added at its end, with its docstring, and nothing else**; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the import's block: one record more), `scripts/axioms-controls.txt` only if a control's expected count moves with your state; `scripts/assumptions-ledger.txt` (by `--write-ledger` only); `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); `plans/{JOB}-landing.md`, `tools/fs132_l1_*.py`, `data/fs132/l1/`, `data/fs132/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** either axiom's statement, any copied definition, any other statement or proof, any other module, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py` (drafts for those go in your record), the outside clone at `/home/kooshi/source/math` and the audit's working copy under `/home/kooshi/.cache/ext-oai1` (read; write nothing)
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Two days ago an outside organisation published a Lean-formalized proof that the plane is not five-colourable, and with it a
transfer: a proper colouring of the plane with `k` colours exists if and only if a measurable one proper at almost every unit pair
does. This project built and audited that Lean at its own versions, and Kooshi chose to import its two theorems into this library
as declared outside theorems. A colleague wrote the import yesterday on the branch you now stand on: one module, the release's
definitions copied, the two statements as axioms compared with the release's stored terms symbol for symbol across the two
toolchains, and the bridges to this library's own vocabulary — `6 ≤ χ(ℝ²) ≤ 7`, and `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis. It is
built and probed on its branch, and not gated. You take it through the gate and onto `main`.

## Why this job

When this lands, the library's own interval for the plane reads six to seven, and the equality this project held only under a
hypothesis about measure rigidity is a theorem resting on one named outside statement. It is also the first time the library's
count of outside axioms rises above one, so the trust ledger's numbers and sentences all move, and every one of them is read by
whoever later asks what this project assumed. The reviews and rulings behind the job (read each item whole in
`plans/FS131-close-inventory.md`):

{item(619)}
{item(629)}
Kooshi's word on how the release enters (`data/external/EXT-OAI1-request.md`, read whole):

{Q("data/external/EXT-OAI1-request.md","> 1. port or import: let's import and adopt parts piecemeal if needed.")}
## The statements

**No statement on the branch changes in this job.** The two imports and the bridges they carry, as they stand in the module
(`{L}{M}`; read each whole, with its docstring's four items):

{Q(L+M,"axiom no_proper_five_coloring")}
{Q(L+M,"axiom proper_to_borel_weak")}
{Q(L+M,"theorem weakColoring_iff_unitPairsNull")}
{Q(L+M,"theorem chromaticNumber_plane_six_or_seven")}
{Q(L+M,"theorem chromaticNumber_plane_eq_chiM0")}
**The one theorem you add** — the import's implementer checked it and left it out because no row stated it; I have ruled it in
(item 629, ruling (b)). Its file, checked by `lake env lean` on the branch and not built into the library, is
`{L}data/fs132/i1/extra/seven-criterion.lean`:

{Q(L+"data/fs132/i1/extra/seven-criterion.lean","theorem seven_le_chromaticNumber_plane_iff")}
{Q(L+"data/fs132/i1/extra/seven-criterion.lean","    7 ≤ (unitDistance ℂ).chromaticNumber")}
The sentence it is read aloud against — the front page's statement that the problem is one question, as filed today:

{Q("CLAUDE.md","5. **So Hadwiger–Nelson is one question: can vanishing holes save the seventh colour?**","§ The aim")}
The gate's recorded state on `main`, which your counts are reconciled against:

{Q("CLAUDE.md","as a set); the current audit reads ","§ Trust ledger")}
{Q("CLAUDE.md","**What the library assumes, in both forms**","§ Trust ledger")}
{Q("CLAUDE.md","`declarations=","§ The gate")}
## Done means

1. **Your readback first**: check every quotation above against its source; read the import's record whole
   (`{I1}` — its stage 1's cross-pin comparison and the table of 83 constants, stage 3's probes and "At the join", its ten drafts,
   and "What was checked, and by whom"), the audit's Stage 8 (`{AU}`), `LEAN.md` § The gate, § Assumptions and § Trust ledger as
   they stand on `main`, and the last landing's record for the gate's procedure (`plans/FS131-L8A-landing.md`, stages 5–6). Build
   the branch once as given. Open your record. Commit and push.
2. **`main` merged in** (at `{MAIN}` when this was written; the branch was cut before wave 8 of the Lean backlog landed and before
   today's front-page filing). Trial it first and name the conflicts before you make it: the import's implementer's dry run found
   `ARCHITECTURE.md` conflicting in one place, the end of § 3 — keep `main`'s rows, then the branch's § 3.12 — and `Proofs.lean`
   and `scripts/Axioms.lean` merging by themselves. A conflict in a Lean file under `Proofs/` is a message to me. Build.
3. **The comparison, again, on the joined tree.** Re-run the import's instrument on the built module
   (`{L}tools/fs132_i1_readback.py`, as its record's stage 2 ran it): the eight declarations must read identical to the release's,
   term for term, and its planted faults must still fire. Wave 8 brought modules and imports this branch never saw, and which
   instance a term elaborates with depends on the imports — that is how the one difference so far arose. Any difference: message
   me before repairing it.
4. **The one theorem added**, at the end of the module, under a docstring that says what it is (row 131's criterion read for the
   plane's chromatic number itself; on the standard three and the transfer alone) and reads it aloud against the sentence quoted
   above — term by term: is `(unitDistance ℂ).chromaticNumber` the plane's chromatic number in row 33's sense (the module's own
   bridge says how), is `⨆ ε > 0, Plane.mu 6 ε` that sentence's limit of the best six-class cover as `ε → 0`, and does `< 1` say
   "holes of density bounded below"? If the reading shows a gap between the Lean statement and the sentence, say so and leave the
   theorem out: that is a finding for the deriver's lane. Registered in the import's block of `scripts/Axioms.lean`, filed on the
   transfer alone, with the block's wrong-filing control re-run.
5. **What the library assumes, written**: `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh` — the import's
   record expects exactly the `unlisted-consumer` failures for the theorems that rest on the two new axioms (nine on its tree; ten
   with yours) and nothing else; read every failure before `--write-ledger`, and list every row the ledger gains or loses. No line
   of `scripts/Assumptions.lean` is expected; if the step asks for one, message me.
6. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; the
   doubled-name check after the build and before the axiom audit (`./scripts/dupnames.sh` under the slot with `--mem 16`, then its
   `--self-test`); `scripts/axioms.sh` clean with `--self-test` green — three declared imports, every record of the module filed on
   the one import it uses or on none; `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above —
   say how the scan classes every new site (the transfer's hypothesis is inhabited at seven by a model in the module; the
   five-colour statement has no hypothesis), and a site read as vacuous or unknown is a message to me with the scan's line;
   `./scripts/assumptions.sh` and its `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, silent; the notes check and the records check as
   the last landing ran them. Take the three digests against the previous landing's receipts
   (`data/fs131/l8a/gate/receipt-axioms-final.log`, `data/fs131/l8a/gate/receipt-vacuity-final.log`,
   `data/fs131/l8a/gate/receipt-assumptions-final.log`). Save every step's log under `data/fs132/l1/` and name them.
7. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run the gate on the
   merged commit. Name the merged commit by its hash in every check, never by a ref (another job's fetch moves refs between two
   runs). Then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch,
   merge and try again.
8. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes from and
   **the exact words on `main` it replaces** (the front page was refiled today: read it on `main` after your merge, not from the
   import's record, whose drafts were written against the text before wave 8's landing):
   - `CLAUDE.md` § Trust ledger — the audit's sentence with the joined tree's counts, the sentence naming the library's outside
     axioms (the import's draft 2, updated), and the nine assumption counts (its draft 3, updated); § The gate's two count lines;
     a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py` on the joined tree's counts.
   - The front-page sentences that today say the release's theorems are "not in this library": `CLAUDE.md` § The mission's row D
     and § Frontier's first paragraph under "Where the problem stands" — a replacement for each that says what the library now
     holds and on what (the declared outside theorem, by name), keeping what stays true (the classical interval
     `5 ≤ χ(ℝ²) ≤ 7` is still what the library proves with no import).
   - `LEDGER.md` rows 33 and 130: the audit's Stage 8 sentences with the import's additions (its draft 9), and for row 131 one
     sentence naming your theorem; `BIBLIOGRAPHY.md`, the release's row, its "what of ours rests on it" cell: the import's draft 9
     sentence; a dated note for the audit's record (item 629, ruling (e)); `LEAN.md`: the import's drafts 4 and 5.
   - **The open gate items at this landing**, by name, if any; and what the stored-term comparison does not cover (the import's
     record says it: Mathlib below the constants the statements name).
9. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the counts read from the
   gate's saved logs. Leave no background process running. Stopping at a saved stage with the gate red at a named check is a good
   report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how the registry files are resolved, how the scans' new sites are handled under their own procedures,
and whether the added theorem's reading-aloud holds. Do not weaken a check to pass it. If the join shows something the branch
could not — a term that elaborates differently, a name `main` now declares, a count that does not reconcile — that is a finding:
fix what is within your touches and ruled, and message me for the rest. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
os.makedirs(ROOT+"data/fs132/briefs",exist_ok=True)
open(ROOT+"data/fs132/briefs/"+JOB+"-import-land.md","w").write(b)
print("written at tip",TIP,"main",MAIN)
