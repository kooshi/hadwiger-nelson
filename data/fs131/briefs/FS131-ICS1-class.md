# Brief FS131-ICS1 — prove five colours by field and by class: the quadratic dichotomy, the family, CLS in full, ℚ(√23, ∛2), from the skeleton and its plan

*Written 2026-10-16 18:42 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICS1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of part A of a plan — four skeleton modules (36 leaves, about 1,100 lines) stating row 123's results the kernel does not yet hold as theorems — every `sorry` replaced by a proof without changing a statement, three private lemmas of `Rigidity/ClassRatio` made public by ruling, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch, with `main` merged in; beside you three implementers in other worktrees (the `p`-adic plane, the three-colour criterion, the density form of the collapse); none writes another's files, but the density form's implementer also edits `Rigidity/ClassRatio` at another line (`ratioAtMost_of_charBound`, l. 92, made public): touch no other line of that module than your ruling names
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ICS1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICS1-class.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcs1`, on its branch `fs131-kcs1` (at `9db09ce35`: the planner's skeleton with `main` merged in, no Lean from `main` since the planner's build; `.lake/build` current for the skeleton): the four skeleton modules `Proofs/HadwigerNelson/Instances/SqrtFiveClass.lean`, `Proofs/HadwigerNelson/Rigidity/FourColourPlaces.lean`, `Proofs/HadwigerNelson/Instances/SqrtTwentyThreeCbrtTwo.lean`, `Proofs/HadwigerNelson/Arith/StableAboveUsable.lean` (their proofs; their statements only by my word); in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` the edit of the plan's § 3.5 item 1 and nothing else; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/FS131-ICS1-class.md`; your scripts and logs under `data/fs131/ics1/`; `data/fs131/reports/FS131-ICS1.md`. Front-file edits (`LEDGER.md` row 123, `CLAUDE.md`, `ROADMAP.md`, `README.md`, `LEAN.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. This week the kernel proved that the plane over every real number field needs exactly `L(F)` colours whenever
`L(F) ≤ 5`. What it does not yet say by name is which fields those are. The planner found that the answer for real
quadratic fields needs no list — five colours exactly on three residue classes modulo 168 — and that the family, the
class statement and a field with a complex place are each short over what the library holds. You prove them.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Row 123 is that kind of finding, and the quadratic dichotomy answers, for every real quadratic field at once, the
question the literature asks by naming ℚ(√47).

## The statements

Row 123, as the ledger states it now:

> | 123 | **The local–global conjecture's main clause through five: for every real number field `F`, `χ(F²) ≥ min(L(F), 5)`, so `χ(F²) = L(F)` whenever `L(F) ≤ 5`. For every real number field, every stable place of `F(i)` has all-levels four-colour ratio `< 1/4` ⟺ no stable residue target is four-colourable ⟺ `L(F) ≥ 5` (CLS: the only places of ratio `≥ 1/4` are those with residue field `𝔽₃` or `𝔽₇`, dyadic inert of norm `≤ 32`, and dyadic ramified in `F(i)/F`); on that class J45's A⁺ and SP-Cor hold with J45's proofs in every degree (SPC) — the archimedean part at `n` places is one place, a product's independence ratio being its largest factor's (`m₁ < 1/4` per place, never first moments), and a complex place enters only through its compact real form, the circle inside the norm-one hyperbola. The complex-place case is inhabited and not reducible to totally real fields by monotonicity: ℚ(√23, ∛2) has `L = 5` while its totally real subfields have `L ≤ 4` (X28D-CP2), so the complex-place step is load-bearing there. With MR (row 120) that gives five; below five it is row 99; the upper half is the residue map at the place realising `L(F)` (row 52) — [kernel] since FS131-LU1 for every real number field (`UpperHalf.chromaticNumber_planeOver_le_localBound`). Row 100's exception lies outside the class (its dyadic target is bipartite) and has `L = 2`. Instances: `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335) and every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5` (44 of the 52 with `d ≤ 3000`); `χ(ℚ(√3,√5)²) = 5`; `χ(ℚ(√167)²) ≥ 5` by two routes (the class; every stable place 4-thick)** (FS-100 stage 5, wave 3; FS100-COR, CLS, SPC, TCA, CX, EXC, DLP, G27, FAM, K0b, 167, Q35, Q0, D1, CTL, GF; `plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3) 1.3–1.5, 1c). **[kernel] since FS131-LGT1 for the main clause and its five named instances — `Rigidity.min_localBound_five_le_chromaticNumber` (every real number field, no hypothesis), `Instances/SqrtClassValues`, `Instances/SqrtFortySevenFive` — on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3, declared outside theorems; `χ = L` at `L ≤ 5` is that clause with the upper half, stored as one theorem since FS131-IL5 (`Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five`, with the hypothesis-free form `min(χ(F²), 5) = min(L(F), 5)`, `Rigidity.min_chromaticNumber_five_eq_min_localBound_five`; `Rigidity/MainClauseFive`), on the same two declared outside theorems; the family (44 of 52, `d ≤ 3000`), CLS in full and ℚ(√23, ∛2) keep the derivation's grade:** **[hand + tools exact; MR row 120's grade (EL2021 Thm 1.2 external; derived for every real number field, its complex-place case never exercised on an instance); CLS three derivations — X23D and X26B blind to each other in full, X23V blind but for the dyadic level bound, which X26B re-derived blind (X26B-L1: every stable tower's new levels, odd or dyadic inert, any base ramification, bounded by `2/(q+1)` or `1/(q+1)`); FS-66's certificates at 11 and 19 re-run CERTIFIED (X25B at 11; X26B at 11, 19); the four-colourings of `U_Q`, `Q ≤ 32`, now by formula (F₂-linear, X26B); J45's A⁺ and SP-Cor field-free (J45; X05V blind; K0 two, X21V blind); R88-TCA's class form two derivations (J28D; X25B, blind to the proofs, not the outline) and two re-walks (X23D, X23V), its archimedean step at `n` places four minds; the complex-place step three minds by two routes — restriction to the compact real form (X23D; X23V, blind by commit order) and X26B-L3's ratio-0 bound (a log-averaged `J₀` Hoffman bound, one mind) — its need found blind by X25B; row 100's exception outside the class, three minds (X23D; X23V; X26B); the family and ℚ(√3,√5) two blind each (X21D, X21V; X23D, X23V)]** **Not claimed:** anything at `L ≥ 6` beyond `≥ 5` (ℚ(√167), K(√7), de Grey's field, the window fields); an explicit five-chromatic graph over any of these fields. **Prior art:** the conjecture is this project's (G48); its `L ≤ 4` range row 99; the question is `[Fischer1990]` §1's (quoted in row 99; `CLOSED-QUESTIONS.md` §2.6); the value `χ(ℚ(√47)²) = 5`, any five for a real field without √3, and MR not found in print (X24R's gate, its extent in row 121); `[Johnson2000]`, `[Johnson2006]` read 2026-09-27, not found in either, so "not found", never "first". `[Davies2026]` p. 5 (8 October 2026) poses the quadratic instances as open — a five-chromatic graph in, and six-colourability of, `ℚ(√n)²` for `n ≡ 47, 143, 167 (mod 168)` — and prints those classes as the complement of what "is known" (read in full, FS131-ER1); it has no local bound and no statement over a general number field. | `plans/FS100-derivation.md` §4; `plans/FS100-X23D-derivation.md` §2–§5; `plans/FS100-X23V-verification.md` §2–§4; `plans/FS100-X25B-derivation.md` §2–§3; `plans/FS100-X21D-derivation.md` §2–§3; `plans/FS100-X21V-verification.md` §2; `tools/x23d_class.py`, `tools/x23d_norm_one_spectrum.py`, `tools/x23v_places.py`, `tools/x23v_hoffman.py`, `tools/x21d_family.py`, `tools/x21v_checks.py`, `tools/x25b_t1_check.py`; `plans/FS100-X28D-derivation.md` §2.3, §3.3; `tools/x28d_check.py`; `plans/FS100-X26B-derivation.md` §2–§3; `tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` | FS-100 stage 5, wave 3 (crunch 2026-09-26) |
> — source: LEDGER.md

The skeleton's head statements, on your branch (the plan names every other):

> theorem five_le_chromaticNumber_planeOver_sqrt_iff {m : ℕ} (hm : Squarefree m) :
>     5 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber ↔
>       m % 168 = 47 ∨ m % 168 = 143 ∨ m % 168 = 167 := by
> — source: Proofs/HadwigerNelson/Instances/SqrtFiveClass.lean

> theorem chromaticNumber_planeOver_sqrt_eq_five {d : ℕ} (hd : Squarefree d)
>     (hcl : d % 168 = 47 ∨ d % 168 = 143 ∨ d % 168 = 167) (h : IsSquare (d : ZMod 11) ∨ IsSquare (d : ZMod 19)) :
>     ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {d}))).chromaticNumber = 5 := by
> — source: Proofs/HadwigerNelson/Instances/SqrtFiveClass.lean

> theorem five_le_localBound_iff [NumberField F] :
>     5 ≤ localBound F ↔ ∀ P : StablePrime F, ¬ IsFourColourPlace P := by
> — source: Proofs/HadwigerNelson/Rigidity/FourColourPlaces.lean

> theorem chromaticNumber_planeOver_sqrt23_cbrt2_eq_five : ((unitDistance ℂ).induce (planeOver F23)).chromaticNumber = 5 := by
> — source: Proofs/HadwigerNelson/Instances/SqrtTwentyThreeCbrtTwo.lean

> theorem localBound_le_unitQuadrance {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) :
>     localBound F ≤ (unitQuadrance (𝓞 F ⧸ 𝔭)).chromaticNumber := by
> — source: Proofs/HadwigerNelson/Arith/StableAboveUsable.lean

The plan is `plans/FS131-KCS1-class-plan.md` on your branch: § 1.3 its findings; §§ 2.1–2.5 the map of part A; § 3.1 the skeleton; § 3.2 the
head statements read aloud, with what is not claimed; § 3.3 the plan per leaf; § 3.4 its modeling passes; § 3.5 the
drafts for files it does not write. Part B (§ 2.6, the ring lemma) is not yours: a later planner takes it. Its report is
`data/fs131/reports/FS131-KCS1.md`.

## My rulings

> 1027. **FS131-KCS1 handed back DONE: part A planned with a skeleton, part B mapped and priced with none (logged 2026-10-16 18:41 UTC; about 444k by the harness's count — not to be resumed for work; branch `fs131-kcs1` at `620a9fb40` after item 1025's rewrite (its commits `1b0dd7a44`, `09fc7f4c2`, `f59f5feec` before it); record `plans/FS131-KCS1-class-plan.md`, report `data/fs131/reports/FS131-KCS1.md` there).** Part A: four skeleton modules, 36 leaves, about 1,100 lines — A1 the quadratic dichotomy, with no list (`Instances/SqrtFiveClass`, `five_le_chromaticNumber_planeOver_sqrt_iff`: for squarefree `m`, `5 ≤ χ(ℚ(√m)²)` exactly when `m ≡ 47, 143, 167 (mod 168)`, about 30 lines over held theorems); A2 the family, uniform (`chromaticNumber_planeOver_sqrt_eq_five`: `χ = 5` at squarefree `d` in the class that is a square modulo 11 or modulo 19 — the derivation's own reading of "`L = 5`"; the rest of the ledger's wider "with `L = 5`" not claimed); A3 CLS in full (`Rigidity/FourColourPlaces`, `five_le_localBound_iff` with the arithmetic predicate `IsFourColourPlace`, and the all-levels reading of `L` agreeing through five); A4 ℚ(√23, ∛2) (`Instances/SqrtTwentyThreeCbrtTwo`: `χ = 5`, `L = 5`, `L(ℚ(√23)) = 4`, with a new general lemma that a `k`-th root of a non-`k`-th-power removes `Γ_p`); and a new bridge, `UpperHalf.localBound_le_unitQuadrance` (a usable prime's plane is a level-one target). Part B, Lemma C′: eight leaves, about 700 lines, routed by local Hilbert 90 and the Chinese remainder theorem (record § 2.6), no skeleton for budget; the asking lane's clause "infinitely many components in every case" needs a stable prime at every real number field, a Chebotarev-type fact Mathlib lacks. **My receipts:** the three commits exist (rewritten, item 1025); the build's full output (`build/gate/build/20261016T175931Z-4172396.log` in its worktree) reads "build: OK — 1093 of 1093 batches, 5 module(s) rebuilt" with 85 `sorry` warnings and no other warning; I read A1 (`SqrtFiveClass.lean` ll. 39–41), A2 (ll. 64–66), A3 (`FourColourPlaces.lean` ll. 73–74), A4 (`SqrtTwentyThreeCbrtTwo.lean` l. 80) and the bridge (`StableAboveUsable.lean` ll. 44–45) — as reported; `Rigidity.five_le_localBound_of_isSquare_class` is on `main` (`Rigidity/SqrtClassFive.lean` l. 270). **Rulings, four parts each.** (1) *Take the `ClassRatio` edit* (record § 3.5 item 1: `ratioAtMost_dyadic_of_six_le` public, `chromaticNumber_le_four_of_small` and `chromaticNumber_le_four_dyadic` made public) in place of `open private`. *Alternative weighed:* `open private`, the plan's choice. *Why:* item 1021 (2)'s reason — a published module reading another's private names couples them invisibly and hides the lemmas from `exact?`; FS131-IFR1 edits the same module at another line (l. 92), so the second to land merges two separate hunks. *Confidence:* medium-high. (2) *Part B waits for a successor planner* from record § 2.6; that planner states the components clause for fields with an exhibited stable prime and prices the declared Chebotarev-type route beside it; I rule between them at its hand-back. *Alternative weighed:* ask Kooshi now — declined: a declared outside theorem is within the milestone rules ("for milestones, we can trust the literature"), and the choice is clearer with both priced. *Confidence:* medium. (3) *The implementer for part A launches now*, FS131-ICS1. **Logged from its report:** a correction owed to the asking lane — its § 3.3 defines `L(F)` over every level, the kernel's `localBound` is level one (record § 3.5 item 3 drafts the sentence; the next Poros job's); a `LEAN.md` line drafted (record § 3.5 item 2, `decide` on `Squarefree n`); row 123's "with `L = 5`" wording, owed at the landing; prior-art debt — CLS's general statement unsearched by name, Lemma C′'s novelty unchecked; a stub to mint for part B. **Credited:** the planner found the dichotomy needs no list and the family no field-by-field work, and that two things row 123 calls unstored are already kernel theorems wider than its words.
> — source: plans/FS131-close-inventory.md

In short, for you: take the plan's § 3.5 item 1 — state `ratioAtMost_dyadic_of_six_le` as a public theorem after
`ratioAtMost_dyadic`, make `chromaticNumber_le_four_of_small` and `chromaticNumber_le_four_dyadic` public (with
docstrings), and call them by name, with no `open private`. Do this edit in your first build, since it recompiles every
module after `ClassRatio`. Each is a ruled change in the statement comparison.

And on history and commits:

> 1025. **The unpushed history rewritten, and the privacy guard made a commit hook (logged 2026-10-16 18:38 UTC; Kooshi: "Go ahead and rewrite the local history, and maybe add a git commit hook to run the privacy guard").** Item 1022's question, answered. **Done on `main`:** the 21 commits after `origin/main` (`66d5e928c`) rewritten by `git filter-branch` with a deterministic rewording filter (two commit messages; four item headings in five versions of this file), kept outside the repository because it holds the refused words; the final tree is unchanged (`main^{tree}` equal before and after), `main` still descends from `origin/main`, and the guard over every message and every added or changed file version of the range reads 0 refusals (17 before). Every commit of the range has a new hash: the old-to-new list is `data/fs131/history-rewrite/main-2026-10-16.txt`, and every hash this file cites from items 1016–1024 is an old one. **Signatures:** `filter-branch` drops them, so the 21 commits are now unsigned. *Choice:* leave them unsigned. *Alternative weighed:* re-sign them. *Why:* re-signing puts a timestamp in each commit, so the job branches' copies of these commits would no longer rewrite to the same hashes at their landing; and 116 of the last 200 commits already on GitHub are unsigned. *Confidence:* medium; Kooshi may want them signed, which can be done once at the next push. **The job branches** (`fs131-kpa1`, `fs131-ktc1`, `fs131-kfr1`, `fs131-kcs1`) carry the old commits through my merges of `main`; each is rewritten by the same filter when its agent hands back and before it merges, so its old commits become `main`'s new ones; the `p`-adic and three-colour branches also need their stopped agents' records reworded (the filter gains those lines then). **The hooks:** `pre-commit` (each staged text file's staged content through the guard; binary files and files over 10 MB skipped and named, left to the push-time check) and `commit-msg` (the message through the guard), in the common hooks folder, so they run in every worktree; untracked, so the guard's location is not published. Controls in a scratch repository: a clean commit passes; a planted phrase is refused in a file, in a message and in a path with spaces; a binary file is skipped.
> — source: plans/FS131-close-inventory.md

So: a commit hook runs the privacy guard on every commit you make; if it refuses one, reword what it names and commit
again, never `--no-verify`; message me if you cannot tell what to reword. The hashes the planner's record cites changed
in the rewrite: `data/fs131/history-rewrite/fs131-kcs1-2026-10-16.txt` maps them.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves and writing the re-price into your record;
   every module built through `./scripts/build.sh` under the slot; a saved stage after each module.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/ics1/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
   `7c72b9bf7`, unless I tell you another landed first); the statement comparison against a dump of the skeleton's
   stored statements that you take before your first proof edit (a comparator shaped like
   `data/fs131/ico2/statements.py`, with a planted control watched), the ruled changes listed; the vacuity scan's new
   sites with each structure hypothesis's inhabitant named (`LEAN.md` § The gate); `#print axioms` of every head
   statement (expected, from the plan: those that read the headline on the standard three, `StandingFive.kloosterman_bound`
   and `Rigidity.positive_entropy_rigidity`; CLS and the bridge as their proofs read — the record says which, as
   printed). Commit any statement dump gzipped.
4. **The read-aloud** of each head statement against row 123, in your record, with what is not claimed (the members of
   the ledger's wider "with `L = 5`" that are neither a square modulo 11 nor modulo 19).
5. **The drafts** for the front files, each naming its slot, the planner's § 3.5 items 2–4 among them. No novelty
   wording: CLS's general statement has not been searched for by name (item 1027) — write "prior art not yet searched"
   where a novelty line would go; ℚ(√47)'s value keeps the ledger's attribution.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
beyond the ruled `ClassRatio` edit (message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with three other implementers that build and will run full gates. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/ics1/`. Nothing with a `sorry` reaches `main`.
