# Brief FS131-PAS2 — the prior-art searches the asking lane's last two ranks owe: two statements, each searched in the field's own words, read, and recorded

*Written 2026-10-16 23:57 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-PAS2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity; this job is the prior-art gate (§PA) of your opening job, run on two statements already derived, with no derivation of its own
  role: the prior-art searcher for two results whose entries say "nothing after 2006 searched" (C7) or that the literature may already hold (C14)
  launch: now, in a worktree of your own cut from `main`; beside you a kernel planner on the same two results (de Bruijn, FS131-KFS1) and a bibliography filing (a Clerk), none of which writes a file you write
  mission: § Why this job
  statements: § The two statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if you find a statement already in print (that changes a public page and the planner's job), and when the record is done; the report goes to `data/fs131/reports/FS131-PAS2.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `plans/FS131-PAS2-prior-art.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcs1`, on its branch `fs131-pas2` (cut from `main` at `ac47c67b0`; no Lean build): `plans/FS131-PAS2-prior-art.md`; your scripts and query logs under `data/fs131/pas2/`; `data/fs131/reports/FS131-PAS2.md`. Papers you fetch go to the document library `~/source/library/` (other authors' documents never go into this repository). `BIBLIOGRAPHY.md`, `LEDGER.md`, `README.md`, `RESULTS.md` and `CLOSED-QUESTIONS.md` rows are drafted in your record, each naming its slot, never edited. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after each statement; hand back at a saved stage before about 350k

Hello. This morning's prior-art job (FS131-PAS1, `plans/FS131-PAS1-prior-art.md`) searched five of this week's results and found two of them
already in print, which is a good outcome: the front page now credits their authors. Two results on the asking lane's
list were not in it, and a kernel planner starts on both today. This job finds what the literature says about them.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

My ruling on what runs next, which names this job:

> 1073. **The next work, ruled (logged 2026-10-16 23:55 UTC; every landing filed and pushed, item 1072; nothing running).** **Ruling, four parts.** *Choice:* the last two entries of the asking lane's list (`plans/POROS-2026-10-13-number-field-findings.md` § 3.3), in its order: **rank 7, C7** — which distances a four-colouring of rational four-space can forbid beside 1 (`CLOSED-QUESTIONS.md` § 3, LV-T3; no ledger row; "nothing after 2006 searched") — and **rank 9, C14** — the fractional chromatic number of the plane over ℚ(√3, √11) is 4 (`CLOSED-QUESTIONS.md` § 1.6), planned together by one de Bruijn planner (FS131-KFS1, parts A and B); beside it, their prior-art searches by Ephodos (FS131-PAS2: C7 after 2006, and C14 against `[Ducz2026]` Thm 3.1, which FS131-PAS1 found states the Moser ring's instance); and the owed bibliography pass by a Clerk (FS131-FBB1). *Alternative weighed:* the Lean backlog's own order (`plans/LEAN-BACKLOG.md` § The order, FS106-DIAM first: the regularity wall's hand results), or the asking lane's re-rank first. *Why:* item 995's default — the asking lane's order is in force while Kooshi says nothing — and these two finish its list; the asking lane re-ranks when the list is done, with its owed corrections (handoff § 5). *Confidence:* medium; it would change if Kooshi wants the regularity wall's backlog first. **Announcement rule, written before any report (item 995's form):** a planner's price is "planned, one mind; nothing held"; a theorem is held only when a module stating it passes the full gate on `main` and I have printed its axioms; C7's and C14's novelty is worded only as FS131-PAS2 finds it.
> — source: plans/FS131-close-inventory.md

The project's wording rule: for its own results it says "prior art: not found in print", backed by searches recorded in
the ledger, and never "first"; where a search was not run, it says so. A result found in print is credited to its
authors, and that is a good outcome of this job, not a bad one.

## The two statements

1. **C7, rational four-space** — the asking lane's entry:

> **Rank 7 — C7. Rational four-space.** *The theorem:* for `d > 0` with `d² ∈ ℚ`, a proper four-colouring of the
> unit-distance graph on `ℚ⁴` with no monochromatic pair at distance `d` exists iff `d² = p/q` with `p`, `q` odd.
> *Entry:* `data/consolidation-2026-09-27/lv/record.md` LV-T3. *Who asked:* `[Johnson2006]` p. 212, "I believe the
> following is still open". *Rests on:* "[derived, two minds, one blind]"; `[Zaks1999]` Lemma 1 (read in full).
> *The first objection:* it has no ledger row, no claim-list line and no gate — "nothing after 2006 searched". **Novelty
> unchecked.** `[Davies2026]`'s "χ(Q⁴) = 4 …, so the restriction d ⩾ 5 … is necessary" makes it timely.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

   The closed-questions entry, with the derivation's outline and what was searched:

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

2. **C14, the fractional chromatic number of the plane over ℚ(√3, √11)** — the asking lane's entry:

> **Rank 9 — C14.** *The theorem:* the fractional chromatic number of the plane over `ℚ(√3,√11)` is 4. *Entry:*
> `plans/FS56-field-blowup.md`. *Who asked:* `[CranstonRabern2015]`, concluding section. *Rests on:* by hand; the lower
> bound is `[MatolcsiEtAl2025]`'s graph and theorem, the upper Fischer's value. *The first objection:* "Almost all of it
> is theirs" (`CLOSED-QUESTIONS.md` § 1.6); ours is one observation.
> 
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

   The closed-questions entry, with the 2026-09-16 search:

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

   Since then, FS131-PAS1 found that at the Moser ring the instance `χ_gf = 4` is `[Ducz2026]` Thm 3.1 with
   `[MatolcsiEtAl2025]`'s `G27` (`plans/FS131-PAS1-prior-art.md`; its query logs under `data/fs131/pas1/`). Read `[Ducz2026]` against C14 first:
   whether it states the field's value, the supremum over finite subgraphs, the geometric fractional chromatic number of a
   lattice, or something else, and how each relates.

## How to search (my instruction, from this project's prior-art rule)

- Search in the **field's own words**, never this project's coined terms (`BIBLIOGRAPHY.md` § E translates them), and in
  **two disciplines** for each object (for C7: rational distance graphs and colourings of `ℚⁿ`, and quaternion orders and
  lattices; for C14: fractional colouring and independence ratios of distance graphs, and harmonic analysis of
  distance-avoiding sets); search for the **question**, not only the method.
- **zbMATH**: its web pages refuse scripted fetches; its API works:
  `https://api.zbmath.org/v1/document/_search?search_string=...&results_per_page=60`, with `au:"Last, First"`, `ti:"…"`,
  `ab:"…"`, `py:1985-2000` joined by `&` and `|`. For every author who posed or worked the question (for C7: Johnson,
  Zaks, Benda, Perles, and — from my memory, unchecked — Chow, on distances forbidden by colourings of `ℚⁿ`; for C14: Cranston, Rabern, Matolcsi, Ruzsa, Varga, Zsámboki, Ducz, Ambrus), pull
  their **complete listing** there. Pre-2000 proceedings are in no citation graph; Geombinatorics issues are in
  `~/source/library/geombinatorics/`.
- **Read what you find** — abstract, results and references at least — before you write a verdict; a title seen only in
  a listing is recorded as such. Mine the reference lists of what you read. Record every query and every negative.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate the two statements in your
   record in the field's own words, with the query terms each suggests.
2. **One stage per statement:** the queries run (database, string, hit count), what was read and how far, and a verdict —
   *found* (the citation, what it states, how it relates: same, weaker, stronger, special case) or *not found in print*
   (with the searches that back it) — and the drafts it implies: a `BIBLIOGRAPHY.md` row for every work read, and the
   novelty line for the ledger and the public pages, each naming its slot.
3. **The report**, in the standing rules' form.

## What is yours to decide

The queries, the order, and how far to read. If a statement turns out to be misstated as a reader of the literature would
state it, say so: that is a finding. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
