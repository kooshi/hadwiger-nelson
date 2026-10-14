# Brief FS131-KM15 — the five-colour chain: M15, the instances, `ℚ(√47)` first — typed, priced, and proved as far as you reach

*Written 2026-10-14 20:25 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KM15
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; on this job you also prove the leaves you plan, after your plan is saved (my ruling, item 918 (1))
  role: the kernel lane's planner and first prover for module M15 of the five-colour chain — the instance at `ℚ(√47)`: `NumberField` for its `Subfield ℝ`, `5 ≤ localBound` there by computing every stable prime and its level-one target, and `χ(ℚ(√47)²) = 5` composed from the chain's headline and the kernel's upper half; typed to its leaves with a plan per leaf, priced from first leaves, then proved in the plan's order as far as your budget reaches
  launch: now, in the chain's joined tree (its last job has handed back; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a statement of the chain is false at `ℚ(√47)` or needs a hypothesis it lacks, if a stable prime falls outside the map's reading (§ 2.7), if M15 needs a private leaf of `Rigidity/ClassRatio` made public, if the first leaves price M15 above 2,000 lines, and with one line when `χ(ℚ(√47)²) = 5` is stated and its axioms printed; the report goes to `data/fs131/reports/FS131-KM15.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KM15-instances.md` (new, on branch `fs131-wm15`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wm15`** that you cut from its head (`fs131-wj` at `bda6a98f2`; its compiled library is current for that commit, build 5): new modules for M15 (under `Proofs/HadwigerNelson/Instances/` or `Proofs/HadwigerNelson/Rigidity/`, yours to choose) with their lines in the build's lists and `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/FS131-KM15-instances.md`; `data/fs131/km15/`; `data/fs131/reports/FS131-KM15.md`. **Not** any existing module's file — `Rigidity/ClassRatio.lean` is another job's on another branch (FS131-ICM3), and `Instances/SqrtFortySeven.lean`, `SpectralChain.lean` and the headline's module are read, not edited; any module under `Outside/`; the declared printed theorem. Untracked files of earlier jobs under `data/fs131/`: leave them. Nothing on `main`; no push
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the statements, after the plan per leaf with its price, and as leaves fall

Hello. The five-colour chain's headline is stated on this branch with every hypothesis the chain proves discharged:
for every real number field, `min(L(F), 5) ≤ χ(F²)`. What it is for is one field. `χ(ℚ(√47)²) = 5` answers a question
Moorhouse asked in 2010 and the existence half of Soifer's Open Problem 55.1, and it is the result whose landing starts
the repository's publication. You type the instance that reads the headline there, and prove it.

## Why this job

Kooshi's word for when the publication pass begins:

> Once the chain lands, we'll do some sanitization, git history rewrites, some nice readmes, a public readable roadmap of what's left to be formalized, and push to github. Not a full writeup, just that. Then we'll get back to work. That also solves our backup issue.
> — source: data/fs131/REQUEST-2026-10-13.md

In the plan's terms, "the chain lands" is `χ(ℚ(√47)²) = 5` through the gate on `main` with no hypothesis of ours left
(`plans/SESSION-HANDOFF-2026-10-14.md` § 1). M15 is the last module of that road nobody has typed.

## The statements

The chain's leaf for M15, and what the chain does not claim, from its claim list (`data/fs131/claims-NF2.md`):

> NF2-LEAF-23: `NumberField` for `ℚ(√47)`'s `Subfield ℝ`, and `5 ≤ localBound` there: every stable prime of `ℚ(√47, i)` and its target (D:116, FS100-T1: the class among real quadratic fields is `d ≡ 47, 143, 167 (mod 168)`). Then `ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)` (D:275), `ℚ(√3,√5)` (D:301), `ℚ(√167) ≥ 5` (D:279).
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-NC: any size or price of a leaf (the map says none of leaves 8–23 is sized); that the leaf list is complete (the deriver's table names two results read on the path that are not numbered leaves: the density of the ring in its completion, and the ring equalling its maximal order away from the exception fields); that the printed rigidity theorem is formalized (it is declared, with its four items); that any leaf is new mathematics.
> — source: data/fs131/claims-NF2.md § Not claimed

The join's hand-back, the last hand-back on M13's line, and the day's search, as I logged them (their words in quotation
marks, the rulings mine):

> 918. **FS131-IJN1 handed back: the chain joined, M9-S and `mulTwoThree_model` proved, the headline stated with every hypothesis the chain proves discharged (logged 2026-10-14 20:24 UTC; "JOB FS131-IJN1 — DONE"; 591k by the harness's count; branch `fs131-wj` at `bda6a98f2`, tree `fs131-wq1`; record `plans/FS131-IJN1-join.md` there).** From its hand-back message: "`Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField F], Plane.OneAvoidingDensityBound → (localBound F ≤ 4 → localBound F ≤ χ(F²)) → min (localBound F) 5 ≤ χ(F²)` — the headline … Its conclusion is the closed headline's: the kernel compared the two terms and found them the SAME, and the control fired"; its `sorryAx` "through exactly these seven leaves of other lines": `ClassRatio` ll. 214 `card_fibre`, 224 `norm_charSum_new_le`, 346 `ratioAtMost_dyadic`, 351 `chromaticNumber_le_four_of_small`, 359 `ratioAtMost_cert`, 366 `charBound_one_exact`, and `Plane/OneAvoidingDensity` l. 54; two hypotheses kept, `hOA` (`[AmbrusEtAl2023]` Thm 1) and `hRow99` ("on `main`, `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` states it text for text"); `mrPlus` (MR⁺ over every real number field) on the standard three and `positive_entropy_rigidity`; `noRamifiedStableDyadic_of_tca` and `mulTwoThree_model` on the standard three; eight binder drops and one cascade, each checked from the kernel's side; "851 of the chain's 870 public records rest on the standard three and 8 on the declared Einsiedler–Lindenstrauss alone"; build 5 green, statements PASS (1,132; control 10/10), 235 records PASS, lint 14/14, `axioms.sh` OK (34 imported), dupnames OK, architecture PASS; corrections owed (28 module titles still say "skeleton"; `zeroEntropyCarried` and `zeroEntropyCarried_of_numberField` now one stored type under two names; the `example` modelling `card_words_badStarts_le` lists two dropped clauses); Lemma F stays private; M3's ten private copies (item 876); its own tool defects, fixed. **My receipts:** the seven commits are on `fs131-wj`; from the tree's compiled library (scratch `ijn1/Ax1.lean`) the headline's statement as reported, on `[propext, sorryAx, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`, `mrPlus` on the standard three and `positive_entropy_rigidity`, `noRamifiedStableDyadic_of_tca` and `ZdAction.mulTwoThree_model` on the standard three; `SpectralChain.localBound` is one definition on `main` and on `fs131-wj` (`SpectralChain.lean` l. 301 on both). **The seven leaves are each proved or assigned on another line:** `card_fibre`, `norm_charSum_new_le`, `chromaticNumber_le_four_of_small` on `fs131-wcm2` (item 905); `ratioAtMost_dyadic` and `charBound_one_exact` in FS131-ICM3; `ratioAtMost_cert` from FS131-IKC4 at the landing; the density leaf on `fs131-wdb3` (item 895). **Rulings, four parts.** (1) *The next job on the chain's line:* M15, the instances, `ℚ(√47)` first — a planner who types it, prices it, and then proves its leaves as far as the budget reaches, in this tree on a new branch from `fs131-wj` (item 919); alternative, a planner only and an implementer after — declined for a module the map prices at 800–1,500 lines with its route written (`plans/FS131-KR1-chain-map.md` § 2.7): the mind that learns the place computations' Mathlib API is best placed to prove them, and the hand-off would cost the critical path an hour; medium-high — changed if the planner's first leaves price it above 2,000 lines, when an implementer takes the rest. (2) *`hRow99` at `ℚ(√47)`:* vacuous once `5 ≤ localBound` is proved, so the instance needs no discharge of it; at fields with `L ≤ 4` the landing reads `main`'s theorem; high. (3) *`hOA`:* discharged at the chain's landing by `main`'s `Plane.oneAvoidingDensityBound` (after FS131-LDB1's merge); high. (4) *The two names for one fact:* at the chain's landing one of `zeroEntropyCarried` and `zeroEntropyCarried_of_numberField` is removed and its readers redirected (a fact is proved once), the landing choosing by readers; the stale `example` and the 28 titles go to the landing's docstring sweep; high. **Drafts held for the chain's landing:** `data/fs131/ijn1/draft-axioms-block.lean`, `draft-assumptions.txt`, `draft-lean-md.txt`, the record's § Drafts D4 (in `fs131-wq1`). **Credited:** the job's own tool defects found and fixed before its receipts. **The tree's build:** kept, current for `fs131-wj` at build 5, for item 919.
> — source: plans/FS131-close-inventory.md

> 905. **FS131-ICM2 handed back at stage 4: Lemma P proved, the exclusions at 3 and 7 proved, the exact spectra reduced to a closed statement (logged 2026-10-14 19:21 UTC; "JOB FS131-ICM2 — STAGE 4 SAVED"; branch `fs131-wcm2` at `a7501c681`, tree `fs131-wch`; record `plans/FS131-ICM2-implementation.md` there).** From its hand-back message: "`Rigidity.tca_uniform` and `Rigidity.exists_uniform_tail` … rest on `[propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]` … with no `sorry`"; Lemma P's two leaves on the standard three ("at an odd stable prime with `|𝓞 ⧸ P| = Q²`, every norm-one residue at level `n + 1` has exactly `Q` norm-one lifts at level `n + 2`"; "a character non-trivial on `ker red` sums to at most `(2/(Q + 1))·|S_{n+2}|`"); "at `Q ∈ {3, 7}` the level-one target is four-colourable"; `charBound_one_exact` reduced through `charBound_one_of_circleCos` to `circleCos_bound` ("a closed statement about `ZMod Q`. Read true in floating point, with margins `1.638·10⁻³` and `4.880·10⁻⁶`"); GAP at four private leaves (`ratioAtMost_dyadic`, `circleCos_bound`, `charBound_one_exact_27`, `ratioAtMost_cert`); "`count_of_oneAvoidingDensityBound`: its `sorryAx` now comes only from `Plane.upperDensity_le_of_oneAvoidingDensityBound` and `Rigidity.noRamifiedStableDyadic_of_tca`. No leaf of M13 is under it"; statements SAME 44, PRIVATE-SAME 69, CHANGED 0; two generalizations (Lemma P in any finite ring with an involution and a square-zero ideal; K3's isomorphism "in all but name"); a tool defect (ICM1's comparator skipped internal names) fixed in its own; a grading slip corrected. **My receipt:** item 901 (`tca_uniform` printed by me: the standard three and Weil's bound). **Rulings, four parts.** (1) *The next job on this line:* `circleCos_bound` (rational cosine bounds, one kernel `List.all` check of 528 and 960 pairs), then `charBound_one_exact_27`, then the dyadic branch with its own Lemma P; `ratioAtMost_cert` at the landing's join — item 906; high. **Corrections owed:** M13's prices (Lemma P 617 lines; the exclusions 60 against 300–500; the exact spectra 200 + 300–600 against 700–1,200). **Tool defect (the tooling list):** a statement comparator that skips internal names passes a changed private leaf.
> — source: plans/FS131-close-inventory.md

> 908. **SEARCH-2026-10-14 handed back: smaller certificates at both residue sizes (logged 2026-10-14 19:29 UTC; "JOB SEARCH-2026-10-14 — DONE"; 170k by the harness's count; record `plans/SEARCH-2026-10-14.md`).** From its hand-back message: "yes, a smaller relaxation still gets below a quarter at both residue sizes, and FS-66's frozen checker accepts both new certificates. But the frozen format fixes every block at 183 rows (63 at p = 11). So the large positive-definite (PSD) witnesses and the K table do not shrink"; p = 19: "U = 88.643400…, below 90.25 by 1.607 … `--m 4`: [cert] CERTIFIED, exit 0, 4 min 57 s, 3.1 GB … A copy with U_num − 1: REFUSED"; p = 11: "U = 30.077390…, below 30.25 by 0.173 … CERTIFIED"; ops 602,989 → 20,274 at 19; "level one (basis φ_0 alone) fails at both"; readings for the deriver (one distance class alone suffices at 11; five single classes clear 1/4 at 19; "The unit pairs, N(2h) = 1, add nothing at 7, 11 or 19"); a correction owed (row 24 quotes a paraphrase); two slips of its own (an exit-line wrapper; a log-name bug), nothing lost. **My receipts:** the five commits exist; both certificate files are on `main` (above). **Rulings, four parts.** (1) *Filing the certificates:* they stay where they are, `data/search/2026-10-14/certs/`, read by address by the kernel lane — `data/fs66/b1/` is FS-66's frozen record; alternative, copy them there — declined, a second home for one file; high. (2) *The p = 19 leaf:* switched to the reduced certificate, through the present checker first (item 907's ruling); the p = 11 leaf stays on FS-66's certificate (already checked; its margin 2.05 against the reduced one's 0.173); high. (3) *The readings for the deriver* (single distance classes suffice): filed here as an observation [measured, float] for any later write-up; no job now. **Filed:** row 24's fate in `plans/SEARCH-QUEUE.md`, with the paraphrase noted, this commit. **Slips, the job's own, credited.**
> — source: plans/FS131-close-inventory.md

**Where everything is** (all in your tree): the map planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KR1-chain-map.md` § 2.7 — M15's statements, "No scope model is
needed", the reading of `5 ≤ L(ℚ(√47))` ("`47 ≡ 7 (mod 8)` puts no stable prime above 2; `3` and `7` are inert …"), the
floors at `p ∈ {11, 19, 23, 31}` and at every `p ≥ 43` by Weil, and the price; the headline
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean`; `localBound`, `StablePrime` and `levelTarget` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/SpectralChain.lean`; M13's
per-prime class-ratio facts in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (`RatioAtMost`, `tca_of_five_le_localBound`, the private
leaves at each residue size); the field `F47` and the upper half `chromaticNumber_planeOver_sqrt47_le_five` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Instances/SqrtFortySeven.lean`; `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Instances/UpperHalfValues.lean` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Arith/UpperHalf.lean`; the join's record
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IJN1-join.md`. `LEAN.md` § Searching — Lean, and § The kernel's cost model.

**Two things the composition needs from elsewhere, each to be stated as a hypothesis or read by name, not proved here:**
the density bound (`Plane.OneAvoidingDensityBound`, the headline's `hOA`) is proved on another line and reaches `main`
at its landing, so your final theorem may take it as a hypothesis; and the per-residue-size class-ratio facts are M13's
(another job proves them on its line). If a fact you need is a private leaf of `ClassRatio`, tell me which: it is made
public on M13's line, and you read it by name — a fact is proved once.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch cut; the headline, `localBound`,
   `StablePrime` and `levelTarget` printed from the kernel and restated in one line each; § 2.7's reading restated step
   by step, with what each step needs from Mathlib at this pin (searched by name, `#check`ed).
2. **The statements typed** (a saved stage), `sorry` at the leaves only, each read aloud against NF2-LEAF-23 and § 2.7,
   each with a model: `NumberField` for `F47`; **every stable prime of `ℚ(√47)` and its residue size** as a statement of
   its own; `5 ≤ localBound F47`; and **`χ(ℚ(√47)²) = 5`** from the headline and the upper half, over the density bound
   as a hypothesis at most. **The domain pass as a fresh skill invocation on every new definition, and the obligation pass
   on every new statement**, and every instance and definition's stored type read for a class binder its section declares
   (item 847's defect).
3. **Priced from first leaves** (written in scratch, elaborated, measured) — at least the stable-prime classification's
   hardest leaf; every classical input named and searched for by name; **no axiom declared**. The next field's price
   (`ℚ(√143)`), one line, from the same measure.
4. **The leaves proved** in the plan's order, as far as you reach; then one build under the slot with no warning from your
   files but their remaining leaves'; the axioms of every public declaration of your files printed from the built tree —
   the standard three, Weil's bound, `positive_entropy_rigidity`, or `sorryAx` only through named leaves, each listed; the
   guarded lint (`lake lint --no-build -- --no-build --trace`) with no finding in your files.
5. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with leaves
   left, each named with its plan, is a good report.

## What is yours to decide

How M15 is cut into modules; the route of each leaf; the order after item 1; how far into item 4 you reach. An unread
binder of a statement of yours is dropped. Not yours: a declared axiom; a change to a typed statement of another module
without my ruling; an edit to any existing module's file; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wj` at build 5. One file through `lake env lean`: 3 to 24
seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name km15 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. On exit 75 wait ten minutes and retry. A cap kill under a
`timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is
wiped at power-off: anything your record cites lives under `data/fs131/km15/`. Report at once any disk, memory or count
reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
