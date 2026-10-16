# Brief FS131-IFR1 — prove the density form of the collapse: the independence ratio of the plane over every real number field, from the skeleton and its plan

*Written 2026-10-16 17:39 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IFR1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of four modules a planner typed and planned — ledger row 129's field clause in the kernel, at every real number field and with no hypothesis of ours — every `sorry` replaced by a proof without changing a statement (but for the three ruled changes below), then the full gate on one commit
  launch: now, in the planner's worktree and on its branch, with `main` merged in; beside you two implementers taking other modules to the gate in their own worktrees (the `p`-adic plane, the three-colour criterion); none writes another's files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IFR1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IFR1-density.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1`, on its branch `fs131-kfr1` (at `a0600cf37`: the planner's skeleton with `main` merged in, no Lean from `main` since the planner's build; `.lake/build` current for the skeleton): the four new modules `Proofs/HadwigerNelson/Collapse/Density/{Defs, Upper, Headline}.lean` and `Proofs/HadwigerNelson/Plane/TriangularPacking.lean` (their proofs; their statements only as ruled below); in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` the one word `private` before `ratioAtMost_of_charBound` (l. 92) and a docstring for it, nothing else; in `Proofs/HadwigerNelson/Collapse/Headline.lean` the two splits and the model at `k = 7`, added and nothing changed; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/FS131-IFR1-density.md`; your scripts and logs under `data/fs131/ifr1/`; `data/fs131/reports/FS131-IFR1.md`. Front-file edits (`LEDGER.md` row 129, `CLAUDE.md`, `ROADMAP.md`, `README.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules found that every use of measure rigidity in the four derivation entries
behind row 129 is discharged by a theorem the library already proves (`Rigidity.mrPlus`), so the row's field clause can
be a kernel theorem at every real number field, with no hypothesis of ours and wider than the row. The skeleton builds
green, with 81 `sorry` leaves over four modules and a plan for each; you prove them.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Row 129 is that kind of finding: this project's derivation, [hand], given measure rigidity. Its plane clause is already
in the kernel (FS-133: the plane's finitary independence ratio is `m₁(ℝ²)`); its field clause — the independence ratio
of the plane over a number field is the larger of the plane's and the best ratio at one of the field's primes — is what
this module adds, with the fractional chromatic number of every such plane beside it, and the fractional collapse at
the two fields where the colouring collapse already holds.

## The statements

The row, as the ledger states it now:

> | 129 | **Row 123's five is a fractional bound rounded, and given MR the fractional local–global principle holds exactly. Row 123's chain runs one colour class at a time; the colour count enters only at the pigeonhole on the densest class, so its bound is `χ(F²) ≥ ⌈1/α_loc(F)⌉` with `α_loc(F) = max(m₁(ℝ²), sup_v r_v)` (`r_v` a stable place's all-levels independence ratio) and `1/α_loc ≤ 4.36`: that route never gives six. Given MR(F), every `R ⋊ U`-invariant random independent set of `F²` has density at most `α_loc(F)`, so the finitary independence ratio is `α₁(F²) = α_loc(F)`; unconditionally a denser invariant set gives an SP witness. With no MR (FS-133; `plans/FS133-E1-derivation.md`, C133-ONE, C133-FN): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, i.e. `f(n)/n → m₁(ℝ²)` — the first clause of `[DuczVarga2026]` Conjecture 1 — and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²) ∈ [4.04876, 4.35987]`, answering `[MatolcsiEtAl2025]` §2's "it is not known whether equality holds" — posed first by `[Johnson1996fcn]` (p. 103, Question 1; p. 104, Question 3) and `[Johnson2000surprises]` (p. 143, Problems 3 and 4), read at their pages 2026-09-27 and 2026-10-06; over `[OAIMath2026]` family 158's Theorem 2.3 (`wild_fourier`) read as a statement, with no Tarski. At ℚ(√635087), given MR there, finite triangle-free unit-distance graphs reach it. At ℚ(√47), given MR there, held certificates give a triangle-free graph with `χ_f ≥ 4.0000439`** (FS-103; FS103-F-SI, EXT, FRAC, TJ, ROUND, DV, TF, 47, PL, B-AMEN, B-CHIF). **[hand + tools exact; FRAC, TJ, ROUND, DV, TF, 47 two derivations (FS103-F; FS103-B blind to F's record); B-AMEN's reverse half and B-CHIF one mind, both off the killing test's chain and off `α₁(ℝ²) = m₁(ℝ²)`, which use only B-AMEN's Følner half (two blind: F, B; FS105-W-D1); the whole weight MR's (row 120); the plane's clause since FS-133 not MR's: C133-ONE and C133-FN **[kernel]** since FS133-LD1 (`OneClass.finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`, `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`, `tendsto_minIndepNum_div`; each on `[propext, Classical.choice, Quot.sound]`), through `[OAIMath2026]` Theorem 2.3 composed with the spectral theorem — the release's `Spectral.residual_fourier`, its proof ported (`Outside/OAI158Ergodicity`, FS131-KO1 to FS131-LP1); the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set); the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470` — the upper end `[AmbrusEtAl2023]` Theorem 1 itself, **[kernel]** since FS131-LDB1 (`Plane.oneAvoidingDensityBound`, with `Plane.mOne_le_of_oneAvoidingDensityBound`; standard three), so `1/m₁(ℝ²) ≥ 1/0.2470 > 4.0485` there, short of the interval's `4.04876` (the paper's computed `0.24699…`)]** Mechanism: the published expectation `α₁(ℝ²) ≠ m₁(ℝ²)` (`[AmbrusEtAl2023]` §4; `[MatolcsiEtAl2025]`) came from graphs in the Moser lattice, where the tight dyadic places pin `1/4`; the gap is a place's, gone at a field whose places all read below `m₁` (G60). **The finite-graph killing test for MR is withdrawn (FS-133):** `α₁(ℝ²) = m₁(ℝ²)` holds with no MR, so no proof of `α₁(ℝ²) > m₁(ℝ²)` exists and the test as filed can never fire (its cheap form `α₁ ≥ 1/4` was false in print, FS105-W-D1, W-D2). What stays testable is the field form: unconditionally `α₁(F²) ≥ α₁(𝒜²) = m₁(ℝ²)`, and given MR(F) at a field whose places all read below `m₁`, `α₁(F²) = m₁(ℝ²)`; so a proof that every finite unit-distance graph **in ℚ(√635087)²** has independence ratio at least some `c > m₁(ℝ²)` refutes MR there. **Not claimed:** `m₁ = δ_Croft` (the conjecture's second clause); any value of `m₁`; anything at six. **Prior art:** `[MatolcsiEtAl2025]` Conjecture 1 was already disproved in print by `[DuczVarga2026]` (held, read); the equalities not found (F §3.6, five queries; a gate under descriptive-combinatorics names owed; FS-133's gate (fifteen arXiv queries, two web searches, 2026-10-07; zbMATH down): not found; the descriptive-combinatorics neighbours named, unread (`plans/FS133-one-class-transfer.md` § PA.4)); the plane's equality is the `d = 2` case of `[Davies2026]` Thm 1.1's density half (`ᾱ_D(ℝ^d) = m_D(ℝ^d)`, proved there for `d ⩾ 4` only, by a transference that is four-dimensional; its abstract hopes for `d = 2`) — read in full 2026-10-13 (FS131-ER1), not in it; B-CHIF likely folklore. Notation: F's `ρ(F)` is renamed `α_loc(F)` against MRVZ's Hall ratio `ρ(ℝ²) = 1/α₁`. | `plans/FS103-derivation.md` §2; `plans/FS103-F-fractional-shadow.md` §2–§3; `plans/FS103-B-verification.md` §2–§4; `tools/fs103_f_places.py`, `tools/fs103_b_places.py`; `plans/FS105-derivation.md` §4 | FS-103 (2026-09-26) |
> — source: LEDGER.md

The skeleton's head statements, on your branch (the plan names every other):

> theorem finIndepRatio_planeOver_eq_localRatio [NumberField F] :
>     ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = localRatio F := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

> theorem finIndepRatio_planeOver_eq_iSup_density [NumberField F] :
>     ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = ⨆ μ : IndepLaw F, μ.density := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

> theorem fractionalChromaticNumber_planeOver_eq [NumberField F] :
>     ((unitDistance ℂ).induce (planeOver F)).fractionalChromaticNumber = (localRatio F)⁻¹ := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

> theorem fractionalChromaticNumber_planeOver_eq_plane_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
>     (hc : c < 1 / 5) :
>     ((unitDistance ℂ).induce (planeOver F)).fractionalChromaticNumber = (unitDistance ℂ).fractionalChromaticNumber := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

> theorem IndepLaw.density_le_notThick [NumberField F] (μ : IndepLaw F) {δ : ℝ} (hδ0 : 0 < δ) (hδ : δ < 1 / 2)
>     (hμ : μ.density = ENNReal.ofReal δ) :
>     μ.density ≤ max mOne (⨆ (P : StablePrime F) (_ : ∀ c : ℝ, c < δ / (1 - δ) → ¬ ThickAt P c), stableRatio P) := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

> theorem exists_finite_triangleFree_six_chromatic :
>     ∃ S : Finset ℂ, ((unitDistance ℂ).induce (S : Set ℂ)).CliqueFree 3 ∧
>       ((unitDistance ℂ).induce (S : Set ℂ)).chromaticNumber = 6 := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

The right side of the first:

> def localRatio : ℝ≥0∞ := max mOne (⨆ P : StablePrime F, stableRatio P)
> — source: Proofs/HadwigerNelson/Collapse/Density/Defs.lean

TJ's derivation entry, whose second clause my ruling (1) below adds:

> **FS103-F-TJ — T-J39-3 per class: a density-`δ` invariant independent set gives `max(m₁, max_{v ∈ N_δ} r_v) ≥ δ` or an SP witness, `N_δ` the stable places with `λ*_v ≥ δ/(1−δ)` (thick at density `δ` iff `λ* < δ/(1−δ)`); as a construction the mixing selection per class keeps only density `≥ (δ − ϑ)/(1 − ϑ)`, `ϑ = λ*/(1 + λ*)`. [hand, two (F; B)]** *Proof:* F §2.4; B §2.2. *Proof verdict:* TRUE, both; the claim file left `ϑ` undefined (B) — defined here. *Rests on it:* FS103-CTL's CTL-FRAC. *Prior art:* the header's. *Kernel:* declined.
> — source: plans/FS103-derivation.md

The plan is `plans/FS131-KFR1-density-plan.md` on your branch: § 3.1 lists the skeleton; § 3.2 reads the head statements aloud against row 129;
§ 3.3 is the plan per leaf; § 3.4 the price (about 2,650 lines, D2 `Collapse/Density/Upper` the long pole at 1,370, two
thirds of it copy-and-adapt of `Collapse/Dichotomy` and `Collapse/Slice`) and the order — D1 and D4 first (no measure
rigidity, no spectral theory), then D2's count and Følner leaves, then D2's dichotomy and extension, then D3; § 3.5 its
choices; §§ 3.6–3.7 its modeling passes, with one spec example owed to you (`localRatio ⊥ = 2⁻¹`, the one field where the
right side is not `m₁`). Its report is `data/fs131/reports/FS131-KFR1.md`.

## My rulings

The planner's mid-job findings, which I adopted:

> 1008. **FS131-KFR1, mid-job: two widenings and a gap (logged 2026-10-16 15:25 UTC; by message; branch `fs131-kfr1`, stage 1 at `20a356c9f`, record § 1.3).** Its readings, planned, nothing proved: (1) FRAC's field clause at every real number field, no total reality, no `R = O′`, no MR hypothesis — `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)`, `r_P` the all-levels ratio at the stable prime `P` (ramified ones need no case: there `r_P ≥ 1/2`), every SP witness closed by `Rigidity.mrPlus`; (2) the fractional collapse — at a field uniformly `c`-thick with `c < 1/5`, every `r_P ≤ c/(1+c) < 1/6` by Hoffman, and `m₁(ℝ²) ≥ 2π/(21√3) = 0.1728 > 1/6` from the open part of a held seven-disc lemma, so `α₁(F²) = m₁(ℝ²)` and `χ_f(F²) = χ_f(ℝ²)` beside the collapse; the kernel's `m₁ ≥ 1/7` alone falls short of ℚ(√635087)'s Weil–Hoffman bound 0.1633; (3) a gap: ROUND's "this route never gives six" needs `m₁ > 1/5`; open discs of radius `1/2` on the triangular lattice of spacing 2 give `m₁ ≥ π/(8√3) = 0.2267`, so `1/m₁ < 4.42`, a new module of about 250 lines through `Plane.upperDensity_of_periodic`. **My receipt (by hand):** in (3) two points of one open disc are less than 1 apart and two of different discs more than `2 − 1 = 1`, and one disc of area `π/4` per cell of area `2√3` gives `π/(8√3)`. **Ruling, four parts.** *Choice:* plan all three — the widest form as the head (item 996's rule), the fractional collapse as a theorem beside it, and the 250-line disc module as part of the plan. *Alternative weighed:* keep ROUND at the kernel's `1/7` and state only what it reaches — declined: ROUND's content is the bound below 5, which `1/7` cannot give. *Why:* each is in reach and each is the statement a reader cites. *Confidence:* high for (3)'s arithmetic, medium-high for (1) and (2), which the kernel checks.
> — source: plans/FS131-close-inventory.md

Its hand-back:

> 1017. **FS131-KFR1 handed back DONE (logged 2026-10-16 15:57 UTC; about 490k by the harness's count — not to be resumed for work; branch `fs131-kfr1` at `26f14172f`, worktree `.claude/worktrees/kcl1`; record `plans/FS131-KFR1-density-plan.md`, report `data/fs131/reports/FS131-KFR1.md` there).** It had finished before the stop message reached it. Skeleton built (`build.sh` OK, 5 modules rebuilt, only `sorry` warnings): head `Collapse.finIndepRatio_planeOver_eq_localRatio` (`α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)` at every real number field, MR discharged by `Rigidity.mrPlus`), B-AMEN, `χ_f(F²) = 1/α_loc(F)`, the fractional collapse, TJ's first clause, ROUND with the triangular packing, TF, a finite triangle-free six-chromatic unit-distance graph (about 150 lines), item 1005's two splits (proved) and the `k = 7` model; about 2,675 lines over 83 leaves in four modules. **Not yet done by me (next session):** check its commits and build log, read its head statements, copy its record and report onto `main`, rule on its three held items (TJ's second clause, about 110 lines, only on my word; making `ratioAtMost_of_charBound` public in `Rigidity/ClassRatio`, an edit to a landed module; the splits living in the new `Collapse/Density/Headline`), log the prior-art question (the triangle-free six-chromatic graph and the fractional forms, not searched), and brief its implementer.
> — source: plans/FS131-close-inventory.md

My review and the three rulings on what it held for me:

> 1021. **FS131-KFR1 reviewed, and its three held items ruled (logged 2026-10-16 17:33 UTC; owed by item 1017).** **My receipts:** the six commits `20a356c9f`, `33bbc83dd`, `c2d2d8fb7`, `0bcac0a96`, `26f14172f`, `627ec43ba` exist on `fs131-kfr1`; `data/fs131/kfr1/build.log` ends "build: OK — 242 of 242 batches, 5 module(s) rebuilt, 4 module(s) with warnings, 8m12s" and "build exit=0"; I read the head statement in source (`Collapse/Density/Headline.lean` ll. 49–51: `((unitDistance ℂ).induce (planeOver F)).finIndepRatio = localRatio F` at `[NumberField F]`), `localRatio` (`Defs.lean` l. 47: `max mOne (⨆ P : StablePrime F, stableRatio P)`) and `stableRatio` (ll. 40–43: every level `m ≥ 1`, every independent set of `levelTarget P m`, its share of the residue ring), and the corollary (`Headline.lean` ll. 171–175: a finite `S ⊂ ℂ` whose unit-distance graph is `CliqueFree 3` with `chromaticNumber = 6`) — as reported; `sorry` counts 22, 18, 22 and 9 in `Defs`, `Upper`, `Headline` and `Plane/TriangularPacking`. **Rulings, four parts each.** (1) *TJ's second clause is added* (about 110 lines). *Alternative weighed:* leave it out, the planner's choice (a remark on a construction no theorem uses). *Why:* the clause is part of the filed entry's statement (`plans/FS103-derivation.md` FS103-F-TJ: "as a construction the mixing selection per class keeps only density `≥ (δ − ϑ)/(1 − ϑ)`, `ϑ = λ*/(1 + λ*)`"), and Kooshi's W2 formalizes every finding of ours; without it the entry cannot be regraded [kernel] whole. *Confidence:* medium-high; what would change it: the clause turning out to need machinery far past 110 lines, in which case the implementer stops at it and says so. (2) *`ratioAtMost_of_charBound` is made public* in `Rigidity/ClassRatio` (l. 92), with a docstring, and listed in the statement comparison as a ruled change; the new modules call it by name. *Alternative weighed:* `open private`, the planner's plan. *Why:* a published module reading another's private name couples the two invisibly and hides the lemma from `exact?`; the edit is one word, and no other branch in flight edits that module (it is read, not changed, by `fs131-kpa1`). *Confidence:* medium-high. (3) *Item 1005's two splits and the model at `k = 7` go into `Collapse/Headline`*, beside `chromaticNumber_planeOver_sqrt635087_six_or_seven`, unless that needs an import `Collapse/Headline` lacks, in which case they stay where planned and the record says why. *Alternative weighed:* keep them in the new `Collapse/Density/Headline`, the planner's placement. *Why:* the planner placed them there only because its brief made landed modules draft-only; a reader looking for the halves of `6 ≤ χ(ℚ(√635087)²) ≤ 7` looks beside the corollary, and the density module is about independence ratios. *Confidence:* medium (low stakes). **Logged from its report:** a prior-art question — a finite triangle-free unit-distance graph with `χ = 6`, and the fractional forms — not searched: word nothing as new; a stub to mint — the pattern-law refactor of `Collapse/` (one `PatternLaw F Λ N` for colourings and independent sets), recommended against for now by the planner (record § 3.7); a spec example `localRatio ⊥ = 2⁻¹` owed to the implementer (record § 3.7). **Credited:** the planner found that every use of measure rigidity in the four entries is discharged by the kernel's `Rigidity.mrPlus`, so the head statement holds at every real number field with no hypothesis, and that a triangle-free six-chromatic finite unit-distance graph is in reach for about 150 lines.
> — source: plans/FS131-close-inventory.md

So, in short: (1) state and prove TJ's second clause (about 110 lines; if it needs far more, stop at it and message
me); (2) make `ratioAtMost_of_charBound` public in `Rigidity/ClassRatio` with a docstring, and call it by name — its
dependents recompile, so do this edit in the first build, not the last; (3) put the two splits and the model at `k = 7`
in `Collapse/Headline` beside `chromaticNumber_planeOver_sqrt635087_six_or_seven`, unless that needs an import it lacks.
Each of the three is a ruled change in the statement comparison.

The wording rule of the day:

> 1022. **Wording the privacy guard refuses, found at the restart (logged 2026-10-16 17:45 UTC).** The guard (the private lists' checker, run on every brief) refused my first draft of FS131-IQP3's brief, and items 1016 and 1018–1020, on its rules for an account's usage (six hits in the inventory, three in the brief). *Done:* items 1016 and 1018–1020 and the handoff's resume line reworded in place ("a pause at Kooshi's word"; his reason left out as a private account matter); the guard then reads 0 refusals on both files. *Owed, before the next push:* the same wording is in unpushed history — the messages of `a7c63242c` and `f2f1bc8d7` on `main`, the earlier versions of the inventory and the handoff in those commits, and on the branches the records `plans/FS131-IQP2-padic.md` and `plans/FS131-ICT2-three-colour.md` with the message of `59634120b`. The push protocol's privacy check will refuse them. Rewriting unpushed history is Kooshi's call (the push rules say never amend); the alternative is to ask him whether the guard's rule should cover these words. Held for his word, with the push.
> — source: plans/FS131-close-inventory.md

In your files and messages the pause is "a pause Kooshi called", nothing more.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the three rulings and
   the order of work in your record; report any mismatch as a finding.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind (a copy leaf, a new leaf) and
   writing the re-price into your record; every module built through `./scripts/build.sh` under the slot; a saved stage
   after each module. The owed spec example `localRatio ⊥ = 2⁻¹` in D1.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/ifr1/`, its logs there),
   every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on `7c72b9bf7`,
   unless I tell you another landed first); the statement comparison against a dump of the skeleton's stored statements
   that you take before your first proof edit (a comparator shaped like `data/fs131/ico2/statements.py`, with a planted
   control watched), the ruled changes listed; the vacuity scan's new sites with each structure hypothesis's inhabitant
   named (`LEAN.md` § The gate); `#print axioms` of every head statement (expected, from the plan: the field clause, B-AMEN,
   `χ_f` and TJ on the standard three and `Rigidity.positive_entropy_rigidity`, with `StandingFive.kloosterman_bound`
   where Weil's bound is read; the two instances and the triangle-free graph as their proofs read; the splits on the
   six-or-seven corollary's list — the record says which, as printed). Commit any statement dump gzipped (inventory item
   1011: two uncompressed 48.7 MB dumps went public before this rule).
4. **The read-aloud** of each head statement against row 129 and the entries FS103-F-FRAC, -F-TJ, -F-ROUND, -F-TF and
   -B-AMEN (`plans/FS103-derivation.md`), in your record, with what is not claimed (a value of `m₁` or `χ_f(ℝ²)`; anything
   at six colours beyond the corollary).
5. **The drafts** for the front files, each naming its slot. No novelty wording: the prior-art search for the fractional
   forms and the triangle-free six-chromatic graph has not been run (item 1021) — write "prior art not yet searched"
   where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. The planner recommended against the pattern-law refactor of
the collapse's modules (one `PatternLaw F Λ N` for colourings and independent sets) for now; if the copies in D2 convince you
otherwise, say so with a price, but do not refactor landed modules. Not yours: any stored statement of the skeleton or of
`main` beyond the three ruled changes (message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers that will run full gates. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/ifr1/`. Nothing with a `sorry` reaches `main`.
