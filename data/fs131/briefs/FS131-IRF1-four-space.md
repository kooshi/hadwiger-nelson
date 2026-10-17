# Brief FS131-IRF1 — prove which distances a four-colouring of rational four-space can forbid: the compulsion law, Johnson's question, and the structure clause, from the skeleton and its plan

*Written 2026-10-17 00:42 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IRF1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the planner's Part A — four skeleton modules under `Proofs/HadwigerNelson/RationalFour/` (about 1,190 lines, 36 `sorry`s), plus the structure clause A3 (about 40 lines) — every `sorry` replaced by a proof without changing a stored statement, through the full gate on one commit
  launch: now, in the planner's worktree and on its branch; beside you one implementer in another worktree proving the planner's Part B (the fractional chromatic number over ℚ(√3, √11)) on its own branch, writing none of your files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IRF1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IRF1-four-space.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kfs1` (at `273fb7b9a`: the planner's skeletons of both parts; `.lake/build` the planner's, current for the skeleton): the four `RationalFour` modules and new modules beside them; the removal of Part B's skeleton (`Proofs/HadwigerNelson/Instances/SeamFractional.lean`, its import line in `Proofs.lean` and its `ARCHITECTURE.md` row) in your first commit; `Proofs.lean`'s import lines and `ARCHITECTURE.md` rows for your modules; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header); the merge of `main` before the gate; `plans/FS131-IRF1-four-space.md`; your scripts and logs under `data/fs131/irf1/`; `data/fs131/reports/FS131-IRF1.md`. Front-file lines are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. In 2006 Johnson asked which distances a four-colouring of rational four-space that forbids distance 1 can also
forbid. This project derived the answer by hand, the planner mapped every step to Lean and built the skeleton, and you
prove it.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The question, its answer and the derivation's outline:

> - **Which distances can a four-colouring of `ℚ⁴` forbid beside 1?** `[Johnson2006]` p. 212: *"But I believe the following is still open: For which d > 0
>   does there exist a 4-coloring of ℚ⁴ which forbids both distances 1 and d?"* — after `[Zaks1999]`'s Lemmas 1–2 (every proper four-colouring of
>   `G(ℚ⁴, 1)` is monochromatic on pairs at `√2` and at 2), with his guess *"So perhaps all the distances 4k+2 and √4k + 2, k = 1, 2, … cannot be
>   forbidden by a proper 4-coloring of G(ℚ⁴, 1). But we leave this question for another day."* (the radical's bar covers `4k + 2`) **Answered at [derived, two minds, one blind]** (the
>   consolidation run's job LV, 2026-09-27, LV-T3 in `data/consolidation-2026-09-27/lv/record.md`; job LX blind, `data/consolidation-2026-09-27/lx/record.md`
>   stage 1): **for `d` realised in `ℚ⁴` (`d² ∈ ℚ`; for `d² ∉ ℚ` no pair is at distance `d` and a colouring exists trivially — LX's scope repair),
>   exactly the `d` with `d² = p/q`, `p, q` odd — and then every proper four-colouring forbids `d`.** Read `ℚ⁴` as the rational quaternions, `|x|² = N(x)`; `O₂`, the
>   quaternions integral at 2, is the component of the origin (`[BendaPerles2000]` pp. 124–125's description of `H⁴`; their odd-denominator `D` has index 2 in it), `𝔓 = (1 + i)O₂` its maximal ideal, `O₂/𝔓 = 𝔽₄`
>   (`LEDGER.md` row 57's quaternion remark). Left multiplication by `1 + i` carries `G(ℚ⁴, 1)` onto `G(ℚ⁴, √2)`, whose components are the cosets
>   of `𝔓`; Zaks's Lemma 1 makes each monochromatic. So every proper four-colouring is, on each component, the residue colouring onto `𝔽₄` up to
>   relabelling (the unit vectors cover `𝔽₄ˣ`, so the quotient is `K₄`): a pair is **forced equal iff `v₂(|x − y|²) ≥ 1`, forced different iff
>   `= 0`, free iff `< 0`** (different components, relabelled independently). A colouring forbidding 1 and `d` with `v₂(d²) = −k < 0`, composed
>   with a rational similarity of ratio `d`, would forbid 1 and `1/d`, where `v₂ = k ≥ 1` — impossible. Johnson's guess is the case
>   `v₂ ∈ {1, 2}`. It is the `ℚ⁴` form of `LEDGER.md` row 59's valuation law with both directions, where over K the sufficiency is open (row 59;
>   §1.3), and the `ℚ⁴` shadow of `CLAUDE.md` G70's *√3-clean is residue*. **Prior art:** `[Johnson2006]` states it open in July 2006, after
>   `[Zaks1999]` and `[Zaks1989]`; nothing after 2006 searched; `[Zaks1989]` (the density of the colour classes) is held by reviewer's text
>   only; the *if* half is `[Johnson1990]` Thm 3 (LX), the *only if* the half p. 212 calls open. **Not claimed:** a gate; the kernel.
> — source: CLOSED-QUESTIONS.md

## The statements

Two of the skeleton's head statements, on your branch (the plan's § 3.2 lists every one, read aloud):

> theorem forall_coloring_eq_iff (x y : Fin 4 → ℚ) :
>     (∀ c : ratFourGraph.Coloring (Fin 4), c x = c y) ↔ x = y ∨ 1 ≤ padicValRat 2 (sqDist4 x y) := by
> — source: Proofs/HadwigerNelson/RationalFour/Compulsion.lean

> theorem exists_coloring_forbidding_iff {d : ℝ} (hd : 0 < d) :
>     (∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, (sqDist4 x y : ℝ) = d ^ 2 → c x ≠ c y) ↔
>       (∀ r : ℚ, (r : ℝ) ≠ d ^ 2) ∨ ∃ p q : ℕ, Odd p ∧ Odd q ∧ d ^ 2 = (p : ℝ) / q := by
> — source: Proofs/HadwigerNelson/RationalFour/Forbid.lean

The plan is `plans/FS131-KFS1-four-space-plan.md` on your branch: § 2.1 the route; § 3.1–3.3 the modules, the heads and the plan per leaf; § 3.5 the
price; Stage 4 the drafts. Its report is `data/fs131/reports/FS131-KFS1.md`.

## My rulings

> 1082. **FS131-KFS1 handed back DONE: both parts planned with skeletons (logged 2026-10-17 00:40 UTC; about 395k by the harness's count — not to be resumed for work; record `plans/FS131-KFS1-four-space-plan.md`, report `data/fs131/reports/FS131-KFS1.md`; branch `fs131-kfs1` at `0c47f7b02`, worktree `il5`).** Planned, one mind; nothing held. **Part A (C7):** four modules `Proofs/HadwigerNelson/RationalFour/{Basic,Order,Compulsion,Forbid}.lean`, about 1,190 lines on the standard three axioms with no import — `[Zaks1999]` Lemma 1, `[BendaPerles2000]` pp. 123–125 and `[Johnson1990]` Thm 3 formalized; heads `forall_coloring_eq_iff`, `forall_coloring_ne_iff`, `exists_coloring_eq_and_ne_iff` (the compulsion law), `exists_coloring_forbidding_iff` (Johnson's question, every `d > 0`), its `padicValRat` form, `coloring_forbids_of_odd`, and the read-back anchor `nonempty_iso_unitDistance`. **Part B (C14):** `Instances/SeamFractional.lean`, the three heads already proved from two leaves (`numberField_seamField`, `IndepLaw.density_le_quarter_seamField`), by an invariant random independent set (`Collapse.exists_indepLaw`, standard three) and `G27`'s certificate — no blow-up and no E–L; about 1,360 lines, a generator of about 350 and generated data whose kernel price is unmeasured. **My receipts:** the four commits exist; I read the stored heads `exists_coloring_forbidding_iff` ("a colouring forbidding `d` exists ⟺ `d²` is not rational, or `d² = p/q` with `p`, `q` odd") and `forall_coloring_eq_iff` ("forced equal ⟺ `x = y` or `v₂(|x − y|²) ≥ 1`") against `CLOSED-QUESTIONS.md` § 3's C7 — they say what C7 says; `sorry` counts 36 in Part A's four modules, 2 in Part B's. **Rulings, four parts, on its held decisions:** (1) *Choice:* Part A also states A3, the structure clause (every proper four-colouring is, on each component, the residue map up to a bijection), about 40 lines. *Alternative:* leave it out. *Why:* it is the theorem the 2002 paper may hold (item 1075), so the library should state it in the form a reader can compare, and its price is small. *Confidence:* high. (2) *Choice:* Part B's first leaf is a price probe — generate the data and check two atom chunks before the whole `G27` pipeline. *Alternative:* build in the plan's order. *Why:* the kernel price is the one unmeasured number (`LEAN.md`: re-price from the first two leaves). *Confidence:* high. (3) *Choice:* two implementers at once, on two branches, each removing the other part's skeleton in its first commit (nothing with a `sorry` reaches `main`); the landings serialize. *Alternative:* one implementer for both (about 2,550 lines — past one context). *Why:* the parts share no module. *Confidence:* high. **Routed:** FS131-PAS2's generalization (every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4`) to Part B's implementer as optional; its search request (a smaller certificate for `χ_gf(G27) ≥ 4`) to `plans/SEARCH-QUEUE.md` row 27; its question for the asking lane (a `ℚ⁸` analogue through the octonions; steps A3 and A5 use associativity) to the asking lane's next job. **Held:** its front-file drafts (a ledger row for C7, `CLOSED-QUESTIONS.md` lines, bibliography "rests on" fields) until the landings and `[KubickiLehelMorayne2002]`. **Credited:** the route for C14 with no blow-up and no E–L, and its own tool defect found and fixed with a control.
> — source: plans/FS131-close-inventory.md

Why A3 matters now — a 2002 paper may hold it, and the library should state it in the form a reader compares:

> 1075. **FS131-PAS2, mid-job: a possible 2002 source for C7 (logged 2026-10-17 00:25 UTC; by message).** G. Kubicki, J. Lehel, M. Morayne, *Patch colorings and rigid colorings of the rational n-space*, J. Combin. Theory Ser. B 84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030: zbMATH withholds the abstract but its search matches the phrases "Q^4 is rigid", "every 4-coloring of", "uniquely extend", "points at distance one get distinct colors"; if "rigid" means a four-colouring of a unit tetrahedron extends uniquely over its component, C7's structure theorem is essentially theirs and Johnson's question a corollary. Also in print: `[Johnson2010]`'s restatement (Ramsey Theory, Birkhäuser 2011, p. 169: "I think that the same answer holds for n = 4, but this has not been shown"); Bau–Johnson–Noble (Canad. Math. Bull. 2021) Thm 3.3, the quaternion-similarity step. **My receipts:** OpenAlex lists it bronze open access with no repository copy; my fetch (Playwright, system Chrome headless, a fresh empty context, no login, host allow-list) got ScienceDirect's error page and HTTP 403 on `/pdf`; one web search found no author copy (SZTAKI's eprint 2901 lists it without full text). **Ruling, four parts:** *Choice:* ask Kooshi for a browser save to `~/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf`; FS131-PAS2 records C7's verdict as pending the paper and hands back without waiting; FS131-KFS1's job is unchanged (the kernel proof is wanted either way), and no public line words C7's novelty until the paper is read. *Alternative:* defeat the bot check, or hold the planner. *Why:* the paper-fetch rule (memory: the blocks are not worth defeating; Kooshi's browser save works), and a found attribution changes the credit, not the formalization. *Confidence:* high. Leads I passed to it, unread and labelled mine: arXiv:2602.17943 (matched by a search engine, title unknown); a University of Haifa record titled "On four-colourings of the rational four-space" (possibly `[Zaks1999]`). **Credited:** FS131-PAS2's probe of a withheld abstract through the search engine's phrase matches.
> — source: plans/FS131-close-inventory.md

On history and commits:

> 1025. **The unpushed history rewritten, and the privacy guard made a commit hook (logged 2026-10-16 18:38 UTC; Kooshi: "Go ahead and rewrite the local history, and maybe add a git commit hook to run the privacy guard").** Item 1022's question, answered. **Done on `main`:** the 21 commits after `origin/main` (`66d5e928c`) rewritten by `git filter-branch` with a deterministic rewording filter (two commit messages; four item headings in five versions of this file), kept outside the repository because it holds the refused words; the final tree is unchanged (`main^{tree}` equal before and after), `main` still descends from `origin/main`, and the guard over every message and every added or changed file version of the range reads 0 refusals (17 before). Every commit of the range has a new hash: the old-to-new list is `data/fs131/history-rewrite/main-2026-10-16.txt`, and every hash this file cites from items 1016–1024 is an old one. **Signatures:** `filter-branch` drops them, so the 21 commits are now unsigned. *Choice:* leave them unsigned. *Alternative weighed:* re-sign them. *Why:* re-signing puts a timestamp in each commit, so the job branches' copies of these commits would no longer rewrite to the same hashes at their landing; and 116 of the last 200 commits already on GitHub are unsigned. *Confidence:* medium; Kooshi may want them signed, which can be done once at the next push. **The job branches** (`fs131-kpa1`, `fs131-ktc1`, `fs131-kfr1`, `fs131-kcs1`) carry the old commits through my merges of `main`; each is rewritten by the same filter when its agent hands back and before it merges, so its old commits become `main`'s new ones; the `p`-adic and three-colour branches also need their stopped agents' records reworded (the filter gains those lines then). **The hooks:** `pre-commit` (each staged text file's staged content through the guard; binary files and files over 10 MB skipped and named, left to the push-time check) and `commit-msg` (the message through the guard), in the common hooks folder, so they run in every worktree; untracked, so the guard's location is not published. Controls in a scratch repository: a clean commit passes; a planted phrase is refused in a file, in a message and in a path with spaces; a binary file is skipped.
> — source: plans/FS131-close-inventory.md

In short, for you: state and prove A3 (the plan's A3, the structure clause, in the vocabulary the skeleton already has)
as a head statement; remove Part B's skeleton from this branch in your first commit, so that nothing with a `sorry`
from it can reach `main` with yours; merge `main` before the gate.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding. Take a dump of the skeleton's stored statements before
   your first proof edit (a comparator shaped like `tools/fs131_iru2_statements.py`, with a planted control watched).
2. **The leaves**, in the plan's order, re-pricing from the first two leaves and writing the re-price into your record;
   every module built through `./scripts/build.sh` under the slot; a saved stage after each module.
3. **The gate on one commit**, after merging `main`: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/irf1/`, its logs there); every count change explained against `main`'s last gate (`data/fs131/iru2/gate/`,
   the ring of unit vectors', unless I tell you another landed first); the statement comparison against your dump, A3 the
   one added head; the vacuity scan's new sites with each structure hypothesis's inhabitant named (`LEAN.md` § The gate);
   `#print axioms` of every head statement (expected: the standard three, no outside theorem). Commit any statement dump
   gzipped.
4. **The read-aloud** of each head statement against `CLOSED-QUESTIONS.md` § 3's entry and `[Johnson2006]` p. 212's
   question, in your record, with what is not claimed.
5. **The drafts** for the front files (the plan's Stage 4 brought to what is proved), each naming its slot. No novelty
   wording: C7's prior art waits on a paper not yet read (item 1075) — write "prior art: pending `[KubickiLehelMorayne2002]`"
   where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need). You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

The laptop: 12 cores, 31 GB, shared with one other implementer that builds and will run a full gate. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/irf1/`. Nothing with a `sorry` reaches `main`.
