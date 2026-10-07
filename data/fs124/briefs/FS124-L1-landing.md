# Brief FS124-L1 — the landing: the disc criterion — seven exactly when some disc has no weak six-colouring — through the full gate and onto `main`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-L1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the landing implementer of the first module of the milestone opened and derived today — take a branch on which three modules stand proved, join it with `main` (which has moved: another milestone's theorem landed on it two hours ago), finish its registrations, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in a tree of your own cut from the branch's tip; a deriver works under `plans/` and `data/` on `main` and a planner of the kernel lane works blind on a branch cut from the same tip — neither writes a file you write; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; a planner is working blind from nine other statements of this milestone and is shown recent commit subjects, so your commit subjects say what you did and name no statement outside this module
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a gap between a theorem below and the sentence it is read aloud against; a declaration that prints an axiom other than the ones its record files; the vacuity scan reading a new site as vacuous or unknown, or the assumptions step asking for a declaration you cannot class; a merge conflict in a Lean file; a gate step red for a reason you cannot repair within your touches; or a question you cannot work around. **And one line when the gate is green on the commit you will push, before you push.** The report goes to `data/fs124/reports/FS124-L1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-L1-landing.md` (new, on branch `fs124-wl1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1` (branch `fs124-wl1`, cut from branch `fs124-wk1` at `80ee1983`; its `.lake/build` is its own copy, made today from the last landing's tree): the merge of `main`; docstrings and module headers of the three modules of this landing; **one sentence in the module docstring of `Proofs/HadwigerNelson/Outside/OAI158.lean`** naming the release's licence (see § Done means, item 4); `Proofs.lean`, `ARCHITECTURE.md`; `scripts/Axioms.lean` (the branch's block as merged; its section prose where a count is said), `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the second by `--write-ledger` only), `scripts/axioms-controls.txt` only if a control's expected count moves with your state, `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); `plans/FS124-L1-landing.md`, `tools/fs124_l1_*.py`, `data/fs124/l1/`, `data/fs124/reports/FS124-L1.md`; `main` by the one fast-forward push this brief names; **not** the statement of any theorem or definition (a statement that must change is a message), either axiom of the import module, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py`, the derivation files (drafts for those go in your record), the outside clone at `/home/kooshi/source/math`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each numbered item below, and if you have made three full gate runs without a green one, stop at a saved stage and hand back**

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven. This afternoon a deriver of this project showed by hand that the question has a form with no infinite object
in it; a planner stated it in Lean working blind from the statements; and an implementer proved the module in half an hour.
On the branch you stand on, the last theorem reads: `7 ≤ χ(ℝ²)` if and only if some open disc about the origin has no
measurable six-colouring proper at almost every unit pair — on the standard three axioms and one declared outside theorem.
It has not been through the gate. You take it there, and onto `main`.

## Why this job

Every later result of this milestone and of its successor — an exclusion on a disc, a six-coloured fragment of any
regularity — will be consumed through this module. Until it passes the gate the ledger's row says "kernel-checked on a
branch, not held". The gate is what turns a proof that compiles into a statement a reader who trusts none of us may rely
on. Kooshi's word of this morning, and what he has said of formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

How the branch came to be, and the landing that went before yours two hours ago, whose record is your pattern (read each
item whole in its inventory):

> 19. **FS124-K1 done (434k and 60 minutes by the task notice): the radius clause is typed with no statement defect, planned
> — source: plans/FS124-close-inventory.md § Items

> 24. **FS124-I1 done (389k and 31 minutes by the task notice): the radius clause's module is proved whole on its branch and
> — source: plans/FS124-close-inventory.md § Items

> 51. **FS132-L2 done (527k and 87 minutes by the task notice), and its filing is made (16:00 UTC; commit `783e7bdb`): the first
> — source: plans/FS132-close-inventory.md § Items

## The statements

**No statement changes in this job.** The definition and the theorems the landing is for, in your worktree (read each whole,
with its docstring):

> def AeProperOn (U : Set ℂ) (c : ℂ → α) : Prop := (volume.prod arcLength) (monoPairSet U c) = 0
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/WeakColouringOn.lean

> theorem radius_graph {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/Radius.lean

> theorem radius_up (h : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/Radius.lean

> theorem radius_down (h : (unitDistance ℂ).chromaticNumber ≤ k) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

> theorem radius_five : ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball p R) c := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

> theorem colorable_iff_forall_ball :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

> theorem seven_le_chromaticNumber_plane_iff_exists_ball :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

**The row they are read aloud against**, as filed today:

> | 161 | **The disc criterion, in measure — weak six-colourings of the open discs of every radius give `χ(ℝ²) ≤ 6` with no import, and a disc with none gives seven over one declared outside theorem:** "Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the unit-distance graph on V has a proper k-colouring." (C124-RADIUS-GRAPH; for a countable set with compact closure in the open set, C124-RADIUS-COUNTABLE). "For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k." (C124-RADIUS-UP). "For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring." (C124-RADIUS-DOWN, over the declared outside theorem `Outside.OAI158.proper_to_borel_weak`). So at each `k` the two hold together or fail together, and at six, with row 33, the plane needs seven colours precisely if some open disc has no weak measurable six-colouring. At five: "There is R > 0 such that no open disc of radius R has a weak measurable five-colouring." (C124-RADIUS-FIVE, over `Outside.OAI158.no_proper_five_coloring`). For a measurable weak colouring every direction is good: "Let U be a measurable subset of the plane and c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U. Then for every unit vector u, c(z) ≠ c(z + u) for almost every point z of U with z + u in U." (C124-EVERY-DIRECTION). **Class:** every weak `k`-colouring of an open set, every `k ≥ 1`; no entry reads a number of labels. **Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending. **Kernel-checked on a branch, not through the gate, not held** (`fs124-wk1`, 57 theorems): `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`, each on the standard three axioms and that one declared outside theorem; (up) and its contrapositive on the standard three alone. The kernel planner's own generalizations there are its module's, not entries: the colouring's measurability idle in the finite-set form, the countable form and (up); (down) for every subset. **Not claimed:** "an explicit radius at any k"; "that the hypothesis holds at k = 6"; "anything without that import" (C124-RADIUS-DOWN); "any value of R" (C124-RADIUS-FIVE). **Prior art:** partly — for a colouring of the whole plane the motion argument is `[GwynStavrianos2022]` Lemma 2 and this library's N-EASY; for arc maps of discs the conclusion is row 145's; the bounded case for proper colourings is Kruskal 2008 (Zbl 1139.05023, held at abstract); (down) is `[OAIMath2026]` family 158's transfer, restricted; the disc form for weak colourings not found in print. | `plans/FS124-derivation.md` § 1; `plans/FS124-E1-derivation.md` Stage 3; branch `fs124-wk1` | FS-124 (2026-10-07) |
> — source: LEDGER.md

and the theorem record's entries, `plans/FS124-derivation.md` § 1 (C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE): the
Lean module states wider forms as its cores (any function proper at almost every unit pair, any subset) and the entries'
words as corollaries — say, for each entry, which theorem is its read-back.

**The gate's recorded state on `main`**, which your counts are reconciled against (refiled an hour ago, after the last
landing):

> as a set); the current audit reads 6910 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,953 records at the landing of FS-132's first theorem, FS132-L2, 2026-10-07), each purchase listed in `ARCHITECTURE.md` § Trust; an imported record rests on a
> — source: CLAUDE.md § Trust ledger

> **What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if
> — source: CLAUDE.md § Trust ledger

> `declarations=15292 refutations-skipped=226 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`.
> — source: CLAUDE.md § The gate

**The records to read**, in your worktree: the planner's (`/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/plans/FS124-kernel-plan.md`: the definition, each statement's
read-back, § 3.5 what the landing needs, § 4.4 its drafts) and the implementer's (`/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wl1/plans/FS124-I1-implementation.md`: the
57 theorems with their axioms, the counts measured on the branch, its twelve drafts). And on `main`: the last landing's
record, `plans/FS132-L2-landing.md`, for the gate's procedure step by step, with its receipts under `data/fs132/l2/gate/`
and its gate runner `data/fs132/l2/run-gate.sh`.

## Done means

1. **Your readback first**: check every quotation above against its source; read the two records and the last landing's
   record; `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main` (refiled today: read them from
   `main`, not from your branch). Build the branch once as given. Open your record. Commit and push.
2. **`main` merged in** (at `1f22daba` when this was written). Trial it first and name the conflicts before you make it: both
   sides added lines to `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` — keep both; I expect no conflict in a
   file under `Proofs/`, and one there is a message to me. Build.
3. **The registrations**: the branch's audit block as merged (57 records: 52 clean, five resting on a declared outside
   theorem — four on the Borel transfer, one on the five-colour theorem — each filed on exactly the one it uses, the
   wrong-filing control still firing); the prose of the audit script's imported section where it says how many records
   rest on each import; the architecture rows; `tools/check_architecture.py` exit 0; the doubled-name check.
4. **One loose end of the last landing, yours because your build pays for it**: the import module's docstring
   (`Proofs/HadwigerNelson/Outside/OAI158.lean`, hand-written; it copies ten declarations of the release) does not name the
   release's licence. Add one sentence to its module docstring naming it and pointing at the copy beside it
   (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`). Nothing else in that file changes; re-run the import's
   stored-term comparison (`tools/fs132_i1_readback.py`) to show its eight declarations are untouched.
5. **What the library assumes.** `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh`: the implementer
   measured that it fails only on the ledger rows of the five theorems that rest on an import, and that the definition's
   conditions ask no declaration — read every failure before `--write-ledger`, and list every row the ledger gains (the
   count of statements resting on a declared outside theorem goes from 18 to 23).
6. **The vacuity step**: `scripts/vacuity.sh` and its `--self-test`; say how the scan classes every new site (the
   implementer measured one new site, nothing vacuous or unknown); and, since the last landing found the scan silent on
   modules whose colourings are maps under a predicate it does not track, **name by hand the model of each hypothesis of
   the seven theorems above** and whether the kernel holds it (the planner's record names the tight seven-colouring as the
   definition's model).
7. **Read aloud.** In your record: the two join theorems, `radius_up`, `radius_down` and `radius_five` against the row's
   sentences and the entries' statements, clause by clause; **and which half of the criterion rests on the outside
   theorem and which on the standard three alone**, with the two theorems that say so.
8. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search whose plant
   fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test` green — three
   declared outside axioms as before; `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line
   above; `./scripts/assumptions.sh` and its `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint
   (`lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`), silent; the notes check and the records
   check as the last landing ran them. Take the three digests against the last landing's receipts
   (`data/fs132/l2/gate/receipt-axioms-final.log`, `data/fs132/l2/gate/receipt-vacuity-final.log`,
   `data/fs132/l2/gate/receipt-assumptions-final.log`). Save every step's log under `data/fs124/l1/` and name them.
   **Message me one line when it is green, before you push.**
9. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`,
   `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run
   the gate on the merged commit. Name the merged commit by its hash in every check. Then `git push origin HEAD:main` from
   the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
10. **Drafts for the filing**, in your record under "Drafts for the front page (FS124-L1)", each with the log line it comes
    from and **the exact words on `main` it replaces**: `CLAUDE.md` § Trust ledger (the audit's sentence; the nine
    assumption counts and the sentence that says how many theorems rest on each outside theorem) and § The gate's count
    lines; a `GATE_CHANGES` entry; § Where the problem stands — the planner's sentence on the disc criterion and which
    half needs the import (its § 4.4), checked against the landed names; the phrase "kernel-checked on a branch" wherever
    the front page and row 161 now say it of this module; `LEDGER.md` row 161's grade sentence; the theorem record's dated
    line; `LEAN.md` (the planner's and the implementer's lines not yet filed); the atlas grade of the criterion's node.
    And **the open gate items at this landing**, by name, if any.
11. **Your record**, stages headed "Stage n — SAVED (FS124-L1)"; the report in standing rule 11's form, the counts read from
    the gate's saved logs. Leave no background process running. **Stopping at a saved stage with the gate red at a named
    check is a good report** — say which check, its log, and what you would try next.

## What is yours to decide

How the merge is resolved; the wording of the docstring sentence and of rows; how each gate step's finding is repaired
within your touches. Not yours: any statement — if the gate shows a theorem says less or other than its row, that is the
most valuable message this job can send, and nothing is repaired around it. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
