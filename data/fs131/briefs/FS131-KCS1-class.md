# Brief FS131-KCS1 — five colours at the kernel, instance by instance and as a class; and the ring of unit vectors — the map, the skeleton and the price

*Written 2026-10-16 17:41 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KCS1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for the public roadmap's § 3 items 1–2 — row 123's results the kernel does not yet store as theorems (the quadratic family, CLS in full, ℚ(√23, ∛2)) and row 100's Lemma C′ — the map of what each rests on, the statements in Lean, the skeleton with `sorry` at every leaf, a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you three implementers taking other modules to the gate (the `p`-adic plane, the three-colour criterion, the density form of the collapse), none of which writes a file you write
  mission: § Why this job
  statements: § The results
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (a result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/FS131-KCS1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KCS1-class-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcs1`, on its branch `fs131-kcs1` (cut from `main` at `eeec277b7`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build, current for `main`): `plans/FS131-KCS1-class-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kcs1/`; `data/fs131/reports/FS131-KCS1.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k — if the two parts will not both fit, finish part A's plan and say what part B needs; a successor plans it from your record, and that is a good report

Hello. This week the library proved the main clause through five as one theorem: `χ(F²) = L(F)` whenever `L(F) ≤ 5`, at
every real number field, on two declared outside theorems (`Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five`).
What the public roadmap says is still missing from it is the part a reader would look up by field: which fields, by
name or by class, need five colours. And beside it, a ring lemma that was taken out of the library unproved.

## Why this job

Kooshi's rule for what this project publishes:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

My ruling, in the order the asking lane set, that these items take the next free slot:

> 995. **FS131-KPA1 and FS131-KTC1 launched: two planners into the free slots (logged 2026-10-16 13:33 UTC).** Briefs `data/fs131/briefs/FS131-KPA1-padic.md` and `data/fs131/briefs/FS131-KTC1-three-colour.md` from `data/fs131/briefs/scripts/mk-fs131-kpa1.py` and `mk-fs131-ktc1.py` (gate: 6 and 5 quotations, 0 failures each; the publication guard over the four files: 0 refusals); fresh `debruijn` planners on Opus in the reused worktrees `.claude/worktrees/il5` (branch `fs131-kpa1`) and `.claude/worktrees/kel1` (branch `fs131-ktc1`, five untracked logs of FS131-KEL1 left in place), both cut from `main` at `99e78e428`, packages symlinked, the main tree's build copied (disk 241 GB free after). KPA1 maps, states and prices the asking lane's rank 4 (C5: the Borel chromatic number of the anisotropic `p`-adic plane is at least `1 + (p+1)/(2√p)`, so unbounded in `p`, with the values at 7, 11, 19, 23; FS66-T7, T8, L1–L6; ledger row 75); KTC1 its rank 5 (C6: ledger row 79's three-colour criterion — the converse, the periodic form, the density, the dichotomy — beside the forward half the kernel holds since FS131-LJ1). **Ruling, four parts.** *Choice:* these two, in the asking lane's order (`plans/POROS-2026-10-13-number-field-findings.md` § 3.5: "rank 2, then rank 1 with rank 6, then rank 4"; ranks 1, 2 and 6 are in the kernel, rank 3's field equality is FS131-ICO2's). *Alternative weighed:* a planner for the public roadmap's next items (`ROADMAP.md` § 3 items 1–2: the family of 44 fields, CLS in full, ℚ(√23, ∛2), and Lemma C′) — declined for this slot: the asking lane ranks C3's instances as corollaries of what is held and C8 (Lemma C′) at rank 8; they take the next free slot. *Why:* the ranking is the asking lane's, and its default is in force while Kooshi says nothing. *Confidence:* medium-high; it would change if Kooshi wants the public roadmap's order first. **Owed, logged here:** rank 3's density form (C23: the finitary independence ratio of `F²` is the larger of `m₁(ℝ²)` and the best all-levels ratio at its primes; FS103's FRAC, TJ, ROUND) is in no job; it shares the collapse's machinery and is planned after FS131-ICO2 lands. **Announcement rule, written before any report:** a planner's price is reported as "planned, one mind; nothing held"; a theorem of either is held only when a module stating it passes the full gate on `main` and I have printed its axioms. Running: three agents (FS131-ICO2, FS131-KPA1, FS131-KTC1), 3 slots.
> — source: plans/FS131-close-inventory.md

## The results

**Part A — five colours, by field and by class.** The roadmap's entry:

> 1. **Not stored as theorems** (`LEDGER.md` row 123; the chain's gate record, `plans/FS131-LGT1-gate.md`): the family, `χ = 5` at every squarefree `d ≡ 47, 143, 167 (mod 168)` with
>    `L = 5` (44 of the 52 such `d ≤ 3000`); row 123's class statement CLS in full; and the field ℚ(√23, ∛2), the case with a
>    complex place.
> 2. **Lemma C′** (row 100): for a real number field with no ramified stable dyadic prime, the unit-vector ring equals the ring of
>    elements integral at every stable prime. Its statement as typed:
>    ```lean
>    theorem unitRing_eq_stableIntegers [NumberField F] (h : NoRamifiedStableDyadic F) :
>        UnitRing.unitRing (conjOn (fieldI_conj F)) = stableIntegers F
>    ```
>    It was taken out of the library when the chain landed, because nothing read it and its proof was a `sorry`. The statement and its
>    hand route are kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.
> — source: ROADMAP.md § 3. Planes over number fields

The chain's gate record says the same and why they were left:

> 4. **Row 123's family** (every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5`, 44 of 52 below 3000), CLS in full and
>    ℚ(√23, ∛2)'s `L = 5` are not stored; each field is an instance of the headline once `5 ≤ L(F)` is proved there.
> — source: plans/FS131-LGT1-gate.md

The ledger's row 123, quoted whole (the family's list of `d` and the 8 of 52 that are not `L = 5` are in it or in the
derivation it names):

> | 123 | **The local–global conjecture's main clause through five: for every real number field `F`, `χ(F²) ≥ min(L(F), 5)`, so `χ(F²) = L(F)` whenever `L(F) ≤ 5`. For every real number field, every stable place of `F(i)` has all-levels four-colour ratio `< 1/4` ⟺ no stable residue target is four-colourable ⟺ `L(F) ≥ 5` (CLS: the only places of ratio `≥ 1/4` are those with residue field `𝔽₃` or `𝔽₇`, dyadic inert of norm `≤ 32`, and dyadic ramified in `F(i)/F`); on that class J45's A⁺ and SP-Cor hold with J45's proofs in every degree (SPC) — the archimedean part at `n` places is one place, a product's independence ratio being its largest factor's (`m₁ < 1/4` per place, never first moments), and a complex place enters only through its compact real form, the circle inside the norm-one hyperbola. The complex-place case is inhabited and not reducible to totally real fields by monotonicity: ℚ(√23, ∛2) has `L = 5` while its totally real subfields have `L ≤ 4` (X28D-CP2), so the complex-place step is load-bearing there. With MR (row 120) that gives five; below five it is row 99; the upper half is the residue map at the place realising `L(F)` (row 52) — [kernel] since FS131-LU1 for every real number field (`UpperHalf.chromaticNumber_planeOver_le_localBound`). Row 100's exception lies outside the class (its dyadic target is bipartite) and has `L = 2`. Instances: `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335) and every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5` (44 of the 52 with `d ≤ 3000`); `χ(ℚ(√3,√5)²) = 5`; `χ(ℚ(√167)²) ≥ 5` by two routes (the class; every stable place 4-thick)** (FS-100 stage 5, wave 3; FS100-COR, CLS, SPC, TCA, CX, EXC, DLP, G27, FAM, K0b, 167, Q35, Q0, D1, CTL, GF; `plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3) 1.3–1.5, 1c). **[kernel] since FS131-LGT1 for the main clause and its five named instances — `Rigidity.min_localBound_five_le_chromaticNumber` (every real number field, no hypothesis), `Instances/SqrtClassValues`, `Instances/SqrtFortySevenFive` — on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3, declared outside theorems; `χ = L` at `L ≤ 5` is that clause with the upper half, stored as one theorem since FS131-IL5 (`Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five`, with the hypothesis-free form `min(χ(F²), 5) = min(L(F), 5)`, `Rigidity.min_chromaticNumber_five_eq_min_localBound_five`; `Rigidity/MainClauseFive`), on the same two declared outside theorems; the family (44 of 52, `d ≤ 3000`), CLS in full and ℚ(√23, ∛2) keep the derivation's grade:** **[hand + tools exact; MR row 120's grade (EL2021 Thm 1.2 external; derived for every real number field, its complex-place case never exercised on an instance); CLS three derivations — X23D and X26B blind to each other in full, X23V blind but for the dyadic level bound, which X26B re-derived blind (X26B-L1: every stable tower's new levels, odd or dyadic inert, any base ramification, bounded by `2/(q+1)` or `1/(q+1)`); FS-66's certificates at 11 and 19 re-run CERTIFIED (X25B at 11; X26B at 11, 19); the four-colourings of `U_Q`, `Q ≤ 32`, now by formula (F₂-linear, X26B); J45's A⁺ and SP-Cor field-free (J45; X05V blind; K0 two, X21V blind); R88-TCA's class form two derivations (J28D; X25B, blind to the proofs, not the outline) and two re-walks (X23D, X23V), its archimedean step at `n` places four minds; the complex-place step three minds by two routes — restriction to the compact real form (X23D; X23V, blind by commit order) and X26B-L3's ratio-0 bound (a log-averaged `J₀` Hoffman bound, one mind) — its need found blind by X25B; row 100's exception outside the class, three minds (X23D; X23V; X26B); the family and ℚ(√3,√5) two blind each (X21D, X21V; X23D, X23V)]** **Not claimed:** anything at `L ≥ 6` beyond `≥ 5` (ℚ(√167), K(√7), de Grey's field, the window fields); an explicit five-chromatic graph over any of these fields. **Prior art:** the conjecture is this project's (G48); its `L ≤ 4` range row 99; the question is `[Fischer1990]` §1's (quoted in row 99; `CLOSED-QUESTIONS.md` §2.6); the value `χ(ℚ(√47)²) = 5`, any five for a real field without √3, and MR not found in print (X24R's gate, its extent in row 121); `[Johnson2000]`, `[Johnson2006]` read 2026-09-27, not found in either, so "not found", never "first". `[Davies2026]` p. 5 (8 October 2026) poses the quadratic instances as open — a five-chromatic graph in, and six-colourability of, `ℚ(√n)²` for `n ≡ 47, 143, 167 (mod 168)` — and prints those classes as the complement of what "is known" (read in full, FS131-ER1); it has no local bound and no statement over a general number field. | `plans/FS100-derivation.md` §4; `plans/FS100-X23D-derivation.md` §2–§5; `plans/FS100-X23V-verification.md` §2–§4; `plans/FS100-X25B-derivation.md` §2–§3; `plans/FS100-X21D-derivation.md` §2–§3; `plans/FS100-X21V-verification.md` §2; `tools/x23d_class.py`, `tools/x23d_norm_one_spectrum.py`, `tools/x23v_places.py`, `tools/x23v_hoffman.py`, `tools/x21d_family.py`, `tools/x21v_checks.py`, `tools/x25b_t1_check.py`; `plans/FS100-X28D-derivation.md` §2.3, §3.3; `tools/x28d_check.py`; `plans/FS100-X26B-derivation.md` §2–§3; `tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` | FS-100 stage 5, wave 3 (crunch 2026-09-26) |
> — source: LEDGER.md

The asking lane's statement of the theorem a reader would look for, which also names the quadratic dichotomy — "at
least five colours exactly when `n ≡ 47, 143, 167 (mod 168)`" — whose other half the kernel already holds
(`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`):

> - *The theorem.* (Given the printed theorem of Einsiedler and Lindenstrauss.) The unit-distance graph on `ℚ(√47)²` has chromatic number 5. For a real quadratic field `ℚ(√n)`,
>   `n` squarefree, the plane needs at least five colours exactly when `n ≡ 47, 143, 167 (mod 168)`. For every real
>   number field `F`: let `L(F)` be the least chromatic number among the finite graphs `Cay(𝒪/𝔓^m, image of the unit
>   vectors)`, `𝔓` a prime of `F(i)` fixed by complex conjugation, `m ⩾ 1`; then `χ(F²) ⩽ L(F)`, and `χ(F²) ⩾ min(L(F),
>   5)`. Corollary: a finite triangle-free five-chromatic unit-distance graph exists in the plane (none is exhibited).
>   The definition of `L(F)` here is my reading of the kernel's `localBound` (every level `m`, the image of the unit
>   vectors); the planner fixes it from FS100-COR, where the record notes one hand step between two forms of it
>   (`plans/STUB-main-clause-five-kernel.md`, "Caveat carried from X11K2").
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

The derivation is `plans/FS100-derivation.md` (FS100-Q47, FS100-COR with CLS, SPC and TCA); the complex-place field
ℚ(√23, ∛2) is X28D-CP2 in `plans/FS100-X28D-derivation.md`. The kernel's per-field route for the four named quadratic
instances is `Proofs/HadwigerNelson/Instances/SqrtClassValues.lean`; the headline is in
`Proofs/HadwigerNelson/Rigidity/MainClauseFive.lean`.

**Part B — the ring of unit vectors.** Row 100, quoted whole (Lemma C′ is in its peel):

> | 100 | **The class theorem for character colourings (CLG), at existence scope: for every real number field `F` and `k ≥ 2`, given band rigidity (row 98), the plane has a band `k`-character — equivalently a character `k`-colouring `x ↦ ⌊kθ(x)⌋` — iff some stable place of `F(i)` carries one at some level of its residue tower; so `χ_char(F²) = min` over the residue targets, and at `k ≤ 5`, and at every `k` over fields of degree ≤ 2, a character `k`-colouring exists only if `L(F) ≤ k`** (FS-91; FS91-J07-1 to J07-15, J10-L1, J10-L2, J10-L7, J10-L8, J11-T12). **[hand (+ tools exact); two independent derivations (J07; J10 blind in phase 1, then from J07's 25 lemma statements: 24 TRUE, one GAP)]** The peel: by row 98, `θ = τ + α`; the archimedean part vanishes at every complex place and is an interval about 0 at each real one, so `τ` is band; `τ` factors through finitely many stable places (Lemma C: `R ⊗ ℤ_p = R̄_p × V_n`; Lemma C′: `R_F = O′`, the ring integral at the stable primes, with **no Galois hypothesis**, except possibly at a ramified stable dyadic place — three derivations; the exception occurs at ℚ(√5), ℚ(√17), ℚ(α)); weak approximation makes the image of `U` a product of local images; and a sum of symmetric subsets of the circle inside the band keeps **some** summand inside it (the peeling lemma, three derivations). CLG-g makes the exception explicit — a stable place carrying a band `k`-character only above level one, odd with residue field `𝔽_{p^f}`, `f ≥ 3`, `2p < k < χ(Γ_{p^f})`, or inert dyadic of norm `Q ≥ 64` — using level collapse for `k ≤ 2p` (four derivations) and every inert tower's `λ_min` scaling by `Q^{j−1}`; its corollary (g3) at `k = 7` holds only as "exact level `2e(𝔭\|3) + 1`" (a GAP in the lemmas, found by the verifier). **CLG is not a classification:** it does not say that every character colouring is pulled back from one place; that is proved at `k = 3` (row 99's no mixing) and at `k = 4` over ℚ(√59), ℚ(√83), ℚ(√131) (HD1, from CLG's *proof* with Lemma D — with no FS-66 certificate, no `[Zhang2012]`, no Lemma R), and open elsewhere (FS-92). Controls reproduced: `θ₂` at a ramified dyadic place; `[Fischer1994]`'s ℤ/4 colouring of K at one dyadic place, level 3 (one existing checker); C9 on ℚ(√11) at `Γ₇`; row 96's C-47 and C-167, C-167 with no certificate. With `A(R_F)` wide, FS89-CL3–CL5 are TRUE and FS89-CL2 false only as worded. **Not claimed:** anything about `χ` from four colours up (`Θ_k = ∅` is one-sided, G71); the classification at `k ≥ 4` beyond HD1's fields; whether CLG-g's exception is ever realised; a kernel proof. **Prior art:** the close gate found no statement of it; `χ_char` is `[BarajasSerra2008]`'s *regular chromatic number* (circulant graphs), `κ` the lonely-runner / view-obstruction parameter; Lemma C/C′ partly `[Fischer1990b]`'s (quadratic and multiquadratic cases), the general form not found, Shimura 1964 undecided; the peeling lemma not found (folklore-grade); `[Johnson2000]` and `[Johnson2006]` read 2026-09-27, not found; Lemma C′ answers `[Johnson2000]` §5's question at `n = 2` outside the exception fields (*"the problem of characterizing the additive group A generated by the unit vectors in 𝔽ⁿ"*, p. 177; `CLOSED-QUESTIONS.md` §2.7). | `plans/FS91-S1D-character.md`, `plans/FS91-S1V-character.md`, `data/fs91/j07/lemma-statements.md`, `plans/FS91-derivation.md` §2, §4, `tools/crunch_j07_checks.py`, `tools/crunch_j10_{checks,phase2}.py` | FS-91 |
> — source: LEDGER.md

The asking lane's entry:

> **Rank 8 — C8. The ring of unit vectors.** *The theorem:* for a real number field `F` in which no prime above 2
> fixed by conjugation ramifies in `F(i)`, the additive group generated by the unit vectors is the ring of elements of
> `F(i)` integral at every prime fixed by conjugation; in every case the unit-distance graph on `F²` has infinitely
> many components. *Entry:* row 100's Lemma C′ (`plans/FS91-derivation.md` § 2; its entry id not looked up). *Who
> asked:* `[Johnson2000]` § 5, p. 177. *Rests on:* by hand, three derivations; nothing unprinted. *The first objection:*
> prime inversion in general is the outside model's, the quadratic and multiquadratic cases `[Fischer1990b]`'s, and
> "`[Shimura1964]` undecided" — **novelty unchecked** where a number theorist would look first.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3

The statement as typed when it was taken out, and its hand route: `data/fs131/lch1/ring-scope-lemma-c-prime.lean`. The
derivation is `plans/FS91-derivation.md` § 2.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, each result of parts A and B, what each rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** For each result: each step set against what this library and Mathlib at our pin hold, by
   declaration name and module; what is missing, with your estimate in lines of Lean. In part A, in particular: whether
   `5 ≤ L(ℚ(√d))` holds at every squarefree `d ≡ 47, 143, 167 (mod 168)` from CLS's criterion (so that the dichotomy
   "`5 ≤ χ(ℚ(√d)²)` exactly at those classes" is one theorem with no list), and what the equality `χ = 5` needs at each
   field of the family (a five-colourable residue target, by a uniform argument or field by field); how CLS in full is
   best stated; and what the complex place of ℚ(√23, ∛2) asks of the library's notion of a real number field and its
   stable primes. Any printed theorem a step reads: formalize it if that is about an hour of agent work, and when
   unsure, formalize; otherwise say what declaring it would take (`LEAN.md` § Assumptions, its four items).
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean, read back aloud against the results in your
   record, with what is not claimed; every missing piece as a statement with `sorry`, built through `./scripts/build.sh`
   under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the experience-modeling pass
   on the head statements (`debruijn-experience-modeling`: their names and docstrings as a mathematician would cite them).
   Nothing with a `sorry` reaches `main`; the skeleton stays on your branch. Part A first; part B in the same stages if it
   fits, as its own module.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your record,
   each naming its slot; novelty as the ledger words it, and the posers credited by name. The ring lemma's novelty is
   unchecked (the asking lane: "**novelty unchecked** where a number theorist would look first"): word nothing about it
   as new.

## What is yours to decide

The modules' names and places, the form of every Lean statement, which instances ride as theorems by name and which as
one class statement, whether a piece is better proved as a general lemma, and the order of the leaves. If a result is
misstated, or holds in a wider form, say so: a wrong statement reported is a finding, and a better target is welcome
with its price.

## The machine

The laptop: 12 cores, 31 GB, shared with three implementers that build and will run full gates. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kcs1/`.
