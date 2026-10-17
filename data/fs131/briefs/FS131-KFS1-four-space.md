# Brief FS131-KFS1 — rational four-space at four colours, and the fractional chromatic number over ℚ(√3, √11): the map, the skeleton and the price

*Written 2026-10-16 23:56 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KFS1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for the asking lane's last two ranks — part A, which distances a four-colouring of `ℚ⁴` can forbid beside 1 (C7); part B, the fractional chromatic number of the plane over ℚ(√3, √11) (C14) — the map of what each rests on, the statements in Lean, the skeleton with `sorry` at every leaf, a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you a prior-art search on the same two results (Ephodos, FS131-PAS2) and a bibliography filing (a Clerk), neither of which writes a file you write
  mission: § Why this job
  statements: § The results
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (a result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/FS131-KFS1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KFS1-four-space-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kfs1` (cut from `main` at `ac47c67b0`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build, current for `main`): `plans/FS131-KFS1-four-space-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kfs1/`; `data/fs131/reports/FS131-KFS1.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`, `RESULTS.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k — if the two parts will not both fit, finish part A's plan and say what part B needs; a successor plans it from your record, and that is a good report

Hello. Today the library took the asking lane's list of number-field results that the literature has asked for, one
rank at a time, to the kernel: the five-colour fields, the three-colour criterion, the `p`-adic plane, the density form
of the collapse, the ring of unit vectors. Two entries are left, and this job maps and prices both.

## Why this job

Kooshi's rule for what this project publishes:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

My ruling on what runs next:

> 1073. **The next work, ruled (logged 2026-10-16 23:55 UTC; every landing filed and pushed, item 1072; nothing running).** **Ruling, four parts.** *Choice:* the last two entries of the asking lane's list (`plans/POROS-2026-10-13-number-field-findings.md` § 3.3), in its order: **rank 7, C7** — which distances a four-colouring of rational four-space can forbid beside 1 (`CLOSED-QUESTIONS.md` § 3, LV-T3; no ledger row; "nothing after 2006 searched") — and **rank 9, C14** — the fractional chromatic number of the plane over ℚ(√3, √11) is 4 (`CLOSED-QUESTIONS.md` § 1.6), planned together by one de Bruijn planner (FS131-KFS1, parts A and B); beside it, their prior-art searches by Ephodos (FS131-PAS2: C7 after 2006, and C14 against `[Ducz2026]` Thm 3.1, which FS131-PAS1 found states the Moser ring's instance); and the owed bibliography pass by a Clerk (FS131-FBB1). *Alternative weighed:* the Lean backlog's own order (`plans/LEAN-BACKLOG.md` § The order, FS106-DIAM first: the regularity wall's hand results), or the asking lane's re-rank first. *Why:* item 995's default — the asking lane's order is in force while Kooshi says nothing — and these two finish its list; the asking lane re-ranks when the list is done, with its owed corrections (handoff § 5). *Confidence:* medium; it would change if Kooshi wants the regularity wall's backlog first. **Announcement rule, written before any report (item 995's form):** a planner's price is "planned, one mind; nothing held"; a theorem is held only when a module stating it passes the full gate on `main` and I have printed its axioms; C7's and C14's novelty is worded only as FS131-PAS2 finds it.
> — source: plans/FS131-close-inventory.md

## The results

**Part A — rational four-space at four colours (rank 7, C7).** The asking lane's entry:

> **Rank 7 — C7. Rational four-space.** *The theorem:* for `d > 0` with `d² ∈ ℚ`, a proper four-colouring of the
> unit-distance graph on `ℚ⁴` with no monochromatic pair at distance `d` exists iff `d² = p/q` with `p`, `q` odd.
> *Entry:* `data/consolidation-2026-09-27/lv/record.md` LV-T3. *Who asked:* `[Johnson2006]` p. 212, "I believe the
> following is still open". *Rests on:* "[derived, two minds, one blind]"; `[Zaks1999]` Lemma 1 (read in full).
> *The first objection:* it has no ledger row, no claim-list line and no gate — "nothing after 2006 searched". **Novelty
> unchecked.** `[Davies2026]`'s "χ(Q⁴) = 4 …, so the restriction d ⩾ 5 … is necessary" makes it timely.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

The closed-questions entry, with the derivation's outline:

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

The derivation is LV-T3 in `data/consolidation-2026-09-27/lv/record.md` (stage 3 reads `[Zaks1999]` in full), and the
blind second is stage 1 of `data/consolidation-2026-09-27/lx/record.md`. It reads `[BendaPerles2000]` pp. 122–125 for the
description of the component of the origin, and `LEDGER.md` row 57's quaternion remark for the residue `𝔽₄`.

**Part B — the fractional chromatic number over ℚ(√3, √11) (rank 9, C14).** The asking lane's entry:

> **Rank 9 — C14.** *The theorem:* the fractional chromatic number of the plane over `ℚ(√3,√11)` is 4. *Entry:*
> `plans/FS56-field-blowup.md`. *Who asked:* `[CranstonRabern2015]`, concluding section. *Rests on:* by hand; the lower
> bound is `[MatolcsiEtAl2025]`'s graph and theorem, the upper Fischer's value. *The first objection:* "Almost all of it
> is theirs" (`CLOSED-QUESTIONS.md` § 1.6); ours is one observation.
> 
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

The closed-questions entry:

> ### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`
> 
> > **`[CranstonRabern2015]`**, concluding section (Combinatorica 37, 2017): *"What is the fractional chromatic number of
> > `ℚ(√3,√11) × ℚ(√3,√11)`?"* — after noting that their graphs give `χ_f(ℚ(√3,√11)²) ≥ 76/21`.
> 
> **Our answer: 4, exactly.** The upper bound is Theorem B (§1.1, kernel-checked). The lower bound is `[MatolcsiEtAl2025]`'s
> 27-point graph `G27`, which lies in the Moser lattice inside `ℚ(√3,√11)²` and has geometric fractional chromatic number 4, combined
> with the observation that their blow-up (their Theorem 1) **never leaves the field its graph lives in**: every congruence between
> subsets of `F²` is an isometry of `F²`, the group those generate is solvable, and the Følner copies of `G27` stay in `F²`. So finite
> unit-distance graphs over `ℚ(√3,√11)` have fractional chromatic numbers arbitrarily close to 4 (and independence ratios
> arbitrarily close to `1/4`, never below). Proof: `plans/FS56-field-blowup.md` (hand). **Not kernel-checked** beyond Theorem B.
> 
> **Prior art that constrains the claim.** Almost all of it is theirs: the geometric fractional chromatic number (`[AmbrusEtAl2023]`),
> the blow-up and `G27` with its rational witness (`[MatolcsiEtAl2025]`). Ours is the field-internal reading of the blow-up and the
> upper bound. Their witness was **re-verified here** by an independent exact checker (`tools/fs56_gf_check.py`: the graph rebuilt in
> `ℚ(√3,√11)` arithmetic, every congruence decided by an exact isometry test, all 182,304 independent sets enumerated; CERTIFIED, with
> five planted faults refused — `data/fs56/g27/`). **Searched for a contradicting or earlier claim** on 2026-09-16: every work citing
> `[CranstonRabern2015]` (Semantic Scholar, 11 records; OpenAlex, 8) and `[MatolcsiEtAl2025]` (Semantic Scholar, 4; OpenAlex's preprint
> record, 0); none addresses a field plane.
> — source: CLOSED-QUESTIONS.md

Two things have changed since that entry was written, and both bear on the route. First, the kernel now holds the
density form of the collapse: `χ_f(F²) = 1/α_loc(F)` at every real number field
(`Collapse.fractionalChromaticNumber_planeOver_eq` in `Proofs/HadwigerNelson/Collapse/Density/Headline.lean`, on the
standard three axioms and `[EinsiedlerLindenstrauss2022]` Thm 1.3; stated in `plans/KERNEL-HOLDS.md`), so a second
route to the value runs through the residue targets' independence ratios at ℚ(√3, √11)'s conjugation-fixed primes,
beside the route through `[MatolcsiEtAl2025]`'s graph `G27` (its certificate re-checked by `tools/fs56_gf_check.py`,
data in `data/fs56/g27/`). Second, the prior-art job of this morning found that at the Moser ring the instance
`χ_gf = 4` is `[Ducz2026]` Thm 3.1 with `[MatolcsiEtAl2025]`'s `G27` (`plans/FS131-PAS1-prior-art.md`); FS131-PAS2 is
reading that against C14 now. Which route is cheaper, and which statement is the one to store (the field's `χ_f`, the
supremum over its finite subgraphs, or both), is yours to map.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, each result of parts A and B, what each rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** For each result: each step set against what this library and Mathlib at our pin hold, by
   declaration name and module (Mathlib's quaternions, `QuaternionAlgebra`, and the library's residue and component
   machinery for part A; the density form and Theorem B for part B); what is missing, with your estimate in lines of
   Lean. Any printed theorem a step reads (Zaks's Lemma 1, Benda and Perles's index-2 description, the blow-up of
   `[MatolcsiEtAl2025]`): formalize it if that is about an hour of agent work, and when unsure, formalize; otherwise say
   what declaring it would take (`LEAN.md` § Assumptions, its four items).
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean, read back aloud against the results in your
   record, with what is not claimed; every missing piece as a statement with `sorry`, built through `./scripts/build.sh`
   under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the experience-modeling pass
   on the head statements (`debruijn-experience-modeling`: their names and docstrings as a mathematician would cite them).
   Nothing with a `sorry` reaches `main`; the skeleton stays on your branch. Part A first; part B in the same stages if it
   fits, as its own module.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your record,
   each naming its slot (C7 has no ledger row: draft one, its number left to me). Novelty is FS131-PAS2's to find: word
   nothing about either result as new.

## What is yours to decide

The modules' names and places, the form of every Lean statement, the route for each part, whether a piece is better
proved as a general lemma, and the order of the leaves. If a result is misstated, or holds in a wider form, say so: a
wrong statement reported is a finding, and a better target is welcome with its price. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

The laptop: 12 cores, 31 GB; no other job builds. Every Lean build and every `lake env lean` over about 2 GiB goes through
the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 6 -- env MEMMAX=10G BATCH=3 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. On exit 75 wait ten minutes and retry.
`lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence that a
module is green. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep
anything your record cites under `data/fs131/kfs1/`.
