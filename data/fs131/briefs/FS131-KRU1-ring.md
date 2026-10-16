# Brief FS131-KRU1 — the ring of unit vectors at the kernel: Lemma C′ and the components clause — the skeleton, the plan per leaf, the price

*Written 2026-10-16 19:45 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KRU1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for row 100's Lemma C′ (the additive group the unit vectors of `F²` generate is the ring of elements of `F(i)` integral at every conjugation-fixed prime, when no such prime above 2 ramifies) and the asking lane's components clause beside it — part B of a plan whose map and price exist, so this job makes its skeleton, its plan per leaf and its price, and settles the components clause's two routes
  launch: now, in a worktree of your own cut from `main`; beside you three implementers in other worktrees (the three-colour criterion, the density form of the collapse, the five-colour fields — the last of them on the branch whose record you read), none of which writes a file you write
  mission: § Why this job
  statements: § The result
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (the result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/FS131-KRU1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KRU1-ring-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kru1` (cut from `main` at `63d88d855`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build, current for `main`): `plans/FS131-KRU1-ring-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kru1/`; `data/fs131/reports/FS131-KRU1.md`. Edits to the front files and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard on every commit: if it refuses one, reword what it names and commit again, never `--no-verify`
  budget: about 400k by the harness's count, as guidance; save a stage after each stage below; hand back at a saved stage before about 500k

Hello. The planner before you mapped this lemma and priced it at about 700 lines over eight leaves, then ran out of room
for its skeleton. Its route is written down; you turn it into typed statements and a plan an implementer can follow.

## Why this job

Kooshi's rule for what this project publishes:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

## The result

The roadmap's entry, with the statement as it was typed when it was taken out of the library:

> 2. **Lemma C′** (row 100): for a real number field with no ramified stable dyadic prime, the unit-vector ring equals the ring of
>    elements integral at every stable prime. Its statement as typed:
>    ```lean
>    theorem unitRing_eq_stableIntegers [NumberField F] (h : NoRamifiedStableDyadic F) :
>        UnitRing.unitRing (conjOn (fieldI_conj F)) = stableIntegers F
>    ```
>    It was taken out of the library when the chain landed, because nothing read it and its proof was a `sorry`. The statement and its
>    hand route are kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.
> — source: ROADMAP.md § 3. Planes over number fields

Row 100, quoted whole (Lemma C′ is in its peel):

> | 100 | **The class theorem for character colourings (CLG), at existence scope: for every real number field `F` and `k ≥ 2`, given band rigidity (row 98), the plane has a band `k`-character — equivalently a character `k`-colouring `x ↦ ⌊kθ(x)⌋` — iff some stable place of `F(i)` carries one at some level of its residue tower; so `χ_char(F²) = min` over the residue targets, and at `k ≤ 5`, and at every `k` over fields of degree ≤ 2, a character `k`-colouring exists only if `L(F) ≤ k`** (FS-91; FS91-J07-1 to J07-15, J10-L1, J10-L2, J10-L7, J10-L8, J11-T12). **[hand (+ tools exact); two independent derivations (J07; J10 blind in phase 1, then from J07's 25 lemma statements: 24 TRUE, one GAP)]** The peel: by row 98, `θ = τ + α`; the archimedean part vanishes at every complex place and is an interval about 0 at each real one, so `τ` is band; `τ` factors through finitely many stable places (Lemma C: `R ⊗ ℤ_p = R̄_p × V_n`; Lemma C′: `R_F = O′`, the ring integral at the stable primes, with **no Galois hypothesis**, except possibly at a ramified stable dyadic place — three derivations; the exception occurs at ℚ(√5), ℚ(√17), ℚ(α)); weak approximation makes the image of `U` a product of local images; and a sum of symmetric subsets of the circle inside the band keeps **some** summand inside it (the peeling lemma, three derivations). CLG-g makes the exception explicit — a stable place carrying a band `k`-character only above level one, odd with residue field `𝔽_{p^f}`, `f ≥ 3`, `2p < k < χ(Γ_{p^f})`, or inert dyadic of norm `Q ≥ 64` — using level collapse for `k ≤ 2p` (four derivations) and every inert tower's `λ_min` scaling by `Q^{j−1}`; its corollary (g3) at `k = 7` holds only as "exact level `2e(𝔭\|3) + 1`" (a GAP in the lemmas, found by the verifier). **CLG is not a classification:** it does not say that every character colouring is pulled back from one place; that is proved at `k = 3` (row 99's no mixing) and at `k = 4` over ℚ(√59), ℚ(√83), ℚ(√131) (HD1, from CLG's *proof* with Lemma D — with no FS-66 certificate, no `[Zhang2012]`, no Lemma R), and open elsewhere (FS-92). Controls reproduced: `θ₂` at a ramified dyadic place; `[Fischer1994]`'s ℤ/4 colouring of K at one dyadic place, level 3 (one existing checker); C9 on ℚ(√11) at `Γ₇`; row 96's C-47 and C-167, C-167 with no certificate. With `A(R_F)` wide, FS89-CL3–CL5 are TRUE and FS89-CL2 false only as worded. **Not claimed:** anything about `χ` from four colours up (`Θ_k = ∅` is one-sided, G71); the classification at `k ≥ 4` beyond HD1's fields; whether CLG-g's exception is ever realised; a kernel proof. **Prior art:** the close gate found no statement of it; `χ_char` is `[BarajasSerra2008]`'s *regular chromatic number* (circulant graphs), `κ` the lonely-runner / view-obstruction parameter; Lemma C/C′ partly `[Fischer1990b]`'s (quadratic and multiquadratic cases), the general form not found, Shimura 1964 undecided; the peeling lemma not found (folklore-grade); `[Johnson2000]` and `[Johnson2006]` read 2026-09-27, not found; Lemma C′ answers `[Johnson2000]` §5's question at `n = 2` outside the exception fields (*"the problem of characterizing the additive group A generated by the unit vectors in 𝔽ⁿ"*, p. 177; `CLOSED-QUESTIONS.md` §2.7). | `plans/FS91-S1D-character.md`, `plans/FS91-S1V-character.md`, `data/fs91/j07/lemma-statements.md`, `plans/FS91-derivation.md` §2, §4, `tools/crunch_j07_checks.py`, `tools/crunch_j10_{checks,phase2}.py` | FS-91 |
> — source: LEDGER.md

The asking lane's entry, with the components clause and the novelty warning:

> **Rank 8 — C8. The ring of unit vectors.** *The theorem:* for a real number field `F` in which no prime above 2
> fixed by conjugation ramifies in `F(i)`, the additive group generated by the unit vectors is the ring of elements of
> `F(i)` integral at every prime fixed by conjugation; in every case the unit-distance graph on `F²` has infinitely
> many components. *Entry:* row 100's Lemma C′ (`plans/FS91-derivation.md` § 2; its entry id not looked up). *Who
> asked:* `[Johnson2000]` § 5, p. 177. *Rests on:* by hand, three derivations; nothing unprinted. *The first objection:*
> prime inversion in general is the outside model's, the quadratic and multiquadratic cases `[Fischer1990b]`'s, and
> "`[Shimura1964]` undecided" — **novelty unchecked** where a number theorist would look first.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

My ruling on the previous planner's hand-back, whose (2) is this job:

> 1027. **FS131-KCS1 handed back DONE: part A planned with a skeleton, part B mapped and priced with none (logged 2026-10-16 18:41 UTC; about 444k by the harness's count — not to be resumed for work; branch `fs131-kcs1` at `620a9fb40` after item 1025's rewrite (its commits `1b0dd7a44`, `09fc7f4c2`, `f59f5feec` before it); record `plans/FS131-KCS1-class-plan.md`, report `data/fs131/reports/FS131-KCS1.md` there).** Part A: four skeleton modules, 36 leaves, about 1,100 lines — A1 the quadratic dichotomy, with no list (`Instances/SqrtFiveClass`, `five_le_chromaticNumber_planeOver_sqrt_iff`: for squarefree `m`, `5 ≤ χ(ℚ(√m)²)` exactly when `m ≡ 47, 143, 167 (mod 168)`, about 30 lines over held theorems); A2 the family, uniform (`chromaticNumber_planeOver_sqrt_eq_five`: `χ = 5` at squarefree `d` in the class that is a square modulo 11 or modulo 19 — the derivation's own reading of "`L = 5`"; the rest of the ledger's wider "with `L = 5`" not claimed); A3 CLS in full (`Rigidity/FourColourPlaces`, `five_le_localBound_iff` with the arithmetic predicate `IsFourColourPlace`, and the all-levels reading of `L` agreeing through five); A4 ℚ(√23, ∛2) (`Instances/SqrtTwentyThreeCbrtTwo`: `χ = 5`, `L = 5`, `L(ℚ(√23)) = 4`, with a new general lemma that a `k`-th root of a non-`k`-th-power removes `Γ_p`); and a new bridge, `UpperHalf.localBound_le_unitQuadrance` (a usable prime's plane is a level-one target). Part B, Lemma C′: eight leaves, about 700 lines, routed by local Hilbert 90 and the Chinese remainder theorem (record § 2.6), no skeleton for budget; the asking lane's clause "infinitely many components in every case" needs a stable prime at every real number field, a Chebotarev-type fact Mathlib lacks. **My receipts:** the three commits exist (rewritten, item 1025); the build's full output (`build/gate/build/20261016T175931Z-4172396.log` in its worktree) reads "build: OK — 1093 of 1093 batches, 5 module(s) rebuilt" with 85 `sorry` warnings and no other warning; I read A1 (`SqrtFiveClass.lean` ll. 39–41), A2 (ll. 64–66), A3 (`FourColourPlaces.lean` ll. 73–74), A4 (`SqrtTwentyThreeCbrtTwo.lean` l. 80) and the bridge (`StableAboveUsable.lean` ll. 44–45) — as reported; `Rigidity.five_le_localBound_of_isSquare_class` is on `main` (`Rigidity/SqrtClassFive.lean` l. 270). **Rulings, four parts each.** (1) *Take the `ClassRatio` edit* (record § 3.5 item 1: `ratioAtMost_dyadic_of_six_le` public, `chromaticNumber_le_four_of_small` and `chromaticNumber_le_four_dyadic` made public) in place of `open private`. *Alternative weighed:* `open private`, the plan's choice. *Why:* item 1021 (2)'s reason — a published module reading another's private names couples them invisibly and hides the lemmas from `exact?`; FS131-IFR1 edits the same module at another line (l. 92), so the second to land merges two separate hunks. *Confidence:* medium-high. (2) *Part B waits for a successor planner* from record § 2.6; that planner states the components clause for fields with an exhibited stable prime and prices the declared Chebotarev-type route beside it; I rule between them at its hand-back. *Alternative weighed:* ask Kooshi now — declined: a declared outside theorem is within the milestone rules ("for milestones, we can trust the literature"), and the choice is clearer with both priced. *Confidence:* medium. (3) *The implementer for part A launches now*, FS131-ICS1. **Logged from its report:** a correction owed to the asking lane — its § 3.3 defines `L(F)` over every level, the kernel's `localBound` is level one (record § 3.5 item 3 drafts the sentence; the next Poros job's); a `LEAN.md` line drafted (record § 3.5 item 2, `decide` on `Squarefree n`); row 123's "with `L = 5`" wording, owed at the landing; prior-art debt — CLS's general statement unsearched by name, Lemma C′'s novelty unchecked; a stub to mint for part B. **Credited:** the planner found the dichotomy needs no list and the family no field-by-field work, and that two things row 123 calls unstored are already kernel theorems wider than its words.
> — source: plans/FS131-close-inventory.md

The previous planner's map of this part is its record's § 2.6, on its branch: `/home/kooshi/source/lean-dir/.claude/worktrees/kcs1/plans/FS131-KCS1-class-plan.md` (read it there; that worktree is
another job's, so read only). Its route: `R ⊆ O′` and `c·O′ ⊆ R` are held; what is missing is that `R` maps onto
everything at the stable primes dividing `c`, by local Hilbert 90 and the Chinese remainder theorem in place of weak
approximation, then local generation by counting and the Hensel fibre count. The derivation is `plans/FS91-derivation.md`
§ 2; the statement as typed and its hand route, `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own words,
   the lemma, the components clause, what each rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the statements and the map, brought to date.** Re-read the previous planner's § 2.6 against the library
   as it is now on `main` (names, privacy of the lemmas it reads in `Rigidity/ClassRatio`; another implementer is making
   some of that module's private lemmas public on its branch, so plan as if they were private and name any you would want
   public); the head statement in Lean, read back aloud against row 100 and the roadmap's typed form, with what is not
   claimed. **The components clause:** state it at every field with an exhibited stable prime, and price beside it the
   route that states it at every real number field with one declared outside theorem (a nontrivial quadratic extension
   of number fields has a non-split prime), with that theorem's four items of `LEAN.md` § Assumptions drafted and the
   printed source you would cite. If the non-split prime can be had without Chebotarev (for a quadratic extension there
   may be an elementary route) and you can price it, that is the better finding.
3. **Stage 3 — the skeleton and the plan.** Every missing piece as a statement with `sorry`, built through
   `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the
   experience-modeling pass on the head statements (`debruijn-experience-modeling`). Nothing with a `sorry` reaches
   `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with front-page drafts in your record, each naming its slot. The lemma's
   novelty is unchecked: word nothing about it as new.

## What is yours to decide

The modules' names and places, the form of every Lean statement, whether a piece is better proved as a general lemma,
and the order of the leaves. If the result is misstated, or holds in a wider form, say so: a wrong statement reported is a
finding, and a better target is welcome with its price.

## The machine

The laptop: 12 cores, 31 GB, shared with three implementers that build and will run full gates. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kru1/`.
