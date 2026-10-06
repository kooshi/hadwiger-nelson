exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
TREE="fs131-wf1"; JOB="FS131-IF1"; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"merge-base","HEAD","main"],capture_output=True,text=True).stdout.strip()[:8]
assert BASE,"make the worktree first"
P="Proofs/HadwigerNelson/Plane/"
FR=P+"FalconerReduction.lean"; UP=P+"UnitPairs.lean"; K2="plans/FS131-w2-kernel-plan.md"
b=f'''# Brief {JOB} — the library's one assumed outside theorem becomes a theorem: `[Falconer1981]` Lemma 2 (i), proved, and its axiom removed

*Written 2026-10-06 by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: prove the one statement this library declares as an `axiom` from outside — a measurable set of the plane that is neither null nor conull has a point that is a density point neither of it nor of its complement — replace the axiom by the theorem under the same name and statement, take its declaration out of the audit's list of imports, and move the four theorems that rested on it to the clean records
  launch: when a slot frees, on a branch cut from `main`; a landing of another wave is in flight on `main`, and you do not land
  mission: § Why this job
  statements: § The statement
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job if the candidate route below fails at a step and you see no other (at once, with the step: the question then goes to a deriver, and that is a good outcome, not a failure), if the statement as the axiom has it is false or differs from the paper's sentence, or for a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{BASE}`): `{FR}` — the `axiom` becomes a `theorem` of the same name and statement, its docstring rewritten to say what is now proved, nothing else in that file but what the change forces; a new module of your own under `{P}` for the proof if it wants one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `ARCHITECTURE.md` § 5's list "Imported outside theorems" (the row goes); `scripts/Axioms.lean` (the `declareImport` line goes, the four records move from IMPORTED to CLEAN, your new declarations are registered), `scripts/axioms.sh` only where its self-test's expected counts move with yours (each shown red before and green after); `plans/{JOB}-implementation.md`, `tools/fs131_if1_*.py`, `data/fs131/if1/`, `data/fs131/reports/{JOB}.md`; **not** any other statement, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record), `main`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. This library rests on what the kernel checked plus what it explicitly chose to trust, and it has chosen to trust exactly one
outside theorem as an axiom: a lemma from a 1981 paper of Falconer's, which four of its theorems use. Its planner assumed it because it
had no proof in hand — the paper defers the proof to another author's lemma that we do not hold — and marked it "to be formalized before
publication". Kooshi has now asked for it. You prove it.

## Why this job

An axiom is the one thing in this repository the kernel does not check, and one that misstates its paper can be inconsistent. The
project's rule, and his word on this one:

{Q("LEAN.md","- **A milestone may assume the literature** (Kooshi, 2026-10-03).","§ Assumptions: outside theorems and our own")}
{Q("LEAN.md","- **At publication** the cost of landing every assumption on the standard three axioms is measured first;","§ Assumptions: outside theorems and our own")}
{item(548)}
When this lands, the audit's list of declared imports is empty until the next one arrives, and four theorems read the standard three.

## The statement

No statement changes: the axiom's statement is the theorem's, verbatim. As it stands on `main`, with the two definitions it uses and
the planner's read-back of it against the paper's page (read each whole, with its docstring):

{Q(FR,"axiom falconer_lemma2_nonempty ")}
{Q(FR,"    ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ")}
{Q(UP,"noncomputable def densityRatio ")}
{Q(UP,"def densitySet ")}
{Q(K2,"- **`[Falconer1981]` Lemma 2 (i) — imported as an axiom**","§ 12.1 Rulings and outside theorems")}
The four theorems that rest on it today:

{Q(FR,"theorem exists_mem_falconerE ")}
{Q(FR,"theorem fan_tip_ae_mem ")}
{Q(FR,"theorem falconer_reduction ")}
{Q(FR,"theorem le_chiM_of_falconerFan ")}
## A candidate route — the coordinator's, one mind, not checked

*I am not a deriver, and this is not a plan: it is an argument I saw while reading the planner's note, written down so that you do not
spend the job rediscovering it. Nobody has checked it. Attack it first; if a step is wrong, say which, and take another route or stop.*

Write `φ(c, r) = |S ∩ B̄(c, r)| / |B̄(c, r)|`. (1) Both `S` and `Sᶜ` have positive measure, so by Lebesgue's density theorem each has
density points; fix a closed ball `B₀` whose interior holds a density point of each. (2) *The step*: inside any closed ball `B` whose
interior holds a density point `a` of `S` and a density point `b` of `Sᶜ`, and for any bound `δ > 0`, there is a closed ball
`B̄(c, ρ) ⊆ B` with `ρ ≤ δ` and `φ(c, ρ) = 1/2`: take `ρ ≤ δ` so small that `B̄(a, ρ), B̄(b, ρ) ⊆ B`, `φ(a, ρ) > 1/2` and
`φ(b, ρ) < 1/2` (at `b` the ratio of `S` tends to `0`); `c ↦ φ(c, ρ)` is continuous, the segment from `a` to `b` is connected, and
every ball of radius `ρ` centred on it stays in `B` because `B` is convex. (3) A ball with `φ = 1/2` holds positive measure of `S`
and of `Sᶜ` in its interior (a sphere is null), hence a density point of each, so the step repeats: closed balls
`B₀ ⊇ B₁ ⊇ B₂ ⊇ …` with radii `r_n ≤ r_{{n−1}}/2` and `φ = 1/2` for `n ≥ 1`. (4) Their intersection is one point `x`. Since
`x ∈ B_n`, `B_n ⊆ B̄(x, 2 r_n)` and `|B_n| = |B̄(x, 2 r_n)| / 4`; so `|Sᶜ ∩ B̄(x, 2 r_n)| ≥ |Sᶜ ∩ B_n| = |B_n| / 2 =
|B̄(x, 2 r_n)| / 8`, and the ratio of `S` at `x` along the radii `2 r_n → 0` is at most `7/8`: `x` is no density point of `S`. The
same with `S` and `Sᶜ` exchanged: `x` is no density point of `Sᶜ`. What I expect to cost lines: the continuity of `c ↦ |S ∩ B̄(c, ρ)|`
(the symmetric difference of two balls of one radius has measure tending to `0` with the distance of the centres), and the form in which
this library or Mathlib holds Lebesgue's density theorem for `densitySet` as defined above — closed balls, the filter `𝓝[>] 0`.

## Done means

1. **Your readback first**: check the quotations against their sources; read `{FR}` around the axiom (the module's § on Lemmas 2–4, the
   model `upperHalfPlane_falconer_hyp`), the definitions and the density lemmas the library already holds (`{UP}` and what imports it),
   the planner's § 12.1, and the audit's procedure for imports beside the IMPORTED banner of `scripts/Axioms.lean`. Build the branch once
   as given (no `sorry` anywhere: this is `main`). Open your record with what you may and may not change. Commit and push.
2. **The route, attacked before it is used**: in your record, each step of the candidate with what it reads and whether you accept it;
   then the Mathlib and library lemmas each step needs, confirmed with `#check`. Re-price in lines after that, and say so.
3. **The theorem**: `falconer_lemma2_nonempty` as a `theorem`, same name, same binders, same conclusion — `git diff` on its statement
   shows the keyword and nothing else — with children under names of your own. Saved after each child or group (a build, the axioms
   print with a control that fires, commit, push).
4. **The audit moved with it**: the `declareImport` line removed; the four records under CLEAN, each printing the standard three; your
   declarations registered; `scripts/axioms.sh` and its `--self-test` green, with any control whose expected count moves shown red before
   and green after; `./scripts/dupnames.sh`; `tools/check_architecture.py` exit 0; the row gone from `ARCHITECTURE.md`'s list of imported
   outside theorems. If the self-test's design needs at least one declared import to exercise its IMPORTED controls, say how it behaves
   with none — another import (Weil's bound for Kloosterman sums) is on its way on another branch, and the two branches meet at a landing.
5. **Drafts for the filing**, in your record: the `CLAUDE.md` § Trust ledger sentence's counts as they will read (imported records 4
   → 0 from this branch alone); the `BIBLIOGRAPHY.md` row's sentence for `[Falconer1981]` (Lemma 2 (i) no longer assumed; proved here by
   an argument of our own, which is not Croft's unless you find it is) and a row for any work you read for the density theorem; the line
   `LEAN.md` § Trust ledger needs, if any.
6. No other statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. **You do not
   land**: you do not merge another branch, run the full gate, or touch `main` — the next landing job merges your branch. Leave no
   background process running, and keep what your record cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved"; the report in standing rule 11's form, ending
   with what is left and its route. Stopping at a saved stage with the route refuted at a named step is a good report.

## What is yours to decide

Whether the candidate route is right, and the proof — it is yours, not mine: a cleaner argument, a Mathlib theorem that gives the
statement outright, or a general form (any dimension, any Vitali-type family) of which this is an instance are all better outcomes than
my sketch; the module's layout; your helpers. The statement is not yours to change: if it is false as stated, or says something other than
the paper's sentence, that is a message to me and a finding about a declared axiom. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-falconer-lemma2.md","w").write(b)
print("written",JOB,"base",BASE)
