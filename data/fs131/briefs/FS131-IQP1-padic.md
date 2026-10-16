# Brief FS131-IQP1 — implement the padic skeleton: every `sorry` proved, the build, the gate on one commit and the drafts

*Written 2026-10-16 14:38 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IQP1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the modules a planner typed and planned (FS131-KPA1) — the Borel chromatic number of the anisotropic p-adic plane, at least `1 + (p+1)/κ` for every prime `p ≡ 3 (mod 4)` and so unbounded in `p`, with its values at 3, 7, 11, 19 and 23 — every `sorry` replaced by a proof without changing a statement, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch; beside you two other jobs (the collapse's implementer, which may be gating, and the implementer of the other skeleton planned this afternoon), neither of which writes a file you write
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), for a generalization, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IQP1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IQP1-padic.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kpa1` (at `8f5f0e3fd`: the planner's last commit `621ccacc4` with `main` merged in, no Lean changed; `.lake/build` holds the built skeleton): `Proofs/HadwigerNelson/PadicPlane/` (`Basic`, `Measure`, `Upper`, `Tower`, `Values`) and the three certificate modules at 7 the plan names (`Arith/FibreCert7`, `FibreCert7Check`, `FibreCert7Bound`) — their proofs, and their statements only by my word; new helper modules you create, each named in your record; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/FS131-IQP1-padic.md`; your scripts and logs under `data/fs131/iqp1/`; `data/fs131/reports/FS131-IQP1.md`. Front-file edits (`LEDGER.md`, `CLAUDE.md`, `LEAN.md`, `ROADMAP.md`, `README.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 450k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules handed back an hour ago with a plan per leaf and a skeleton that builds
green; you prove the leaves.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

This row of the ledger (row 75) is a finding of ours held by hand; with this module it becomes a kernel theorem. My
rulings on the planner's open choices, from the inventory:

> 997. **FS131-KPA1's finding, mid-job: a shorter route and two widenings (logged 2026-10-16 13:55 UTC; by message; branch `fs131-kpa1` at `75c2ee81b`, stage 1 saved).** Its readings, [hand, one mind each]: (1) FS66-T7 needs Weil's bound alone, not the posers' Theorem 2.5 — Hoffman's ratio bound at each level `UD(ℤ/p^k, 2)` (held, composed with Weil and FS-66's L1 at every level of every odd stable prime, as the private `Rigidity.ratioAtMost_weil` in `Rigidity/ClassRatio`; at `F = ℚ` the stable prime of `ℚ(i)` above `p` has the tower `(ℤ/p^k)[i]`), then one measure step: the cosets of `p^kℤ_p²` that a measurable independent set fills to more than half are independent at level `k`, so `μ(I) ≤ sup_k α(G_k)/p^{2k}` by regularity; (2) a better constant, `χ_Bor(ℚ_p²) ≥ 1 + (p+1)/κ_p` with `κ_p = max(2, −λ_min(Γ_p))` (4.01 at 23 against T7's 3.50; below the certificates' values at 7–23), through the private `charBound_of_charBound_oneT`; (3) the same bound at every complete discretely valued field of odd residue characteristic with residue field `𝔽_q`, `q ≡ 3 (mod 4)` — not checked line by line, and not planned here. No statement defect. A grade note for row 75: its `U = 77.511742` at 19 is FS-66's `cert-p19.json`, not in the kernel; the kernel holds the Searcher's smaller certificate (`U = 88.6434…`, item 907), also below `361/4`. **My receipts:** the commit exists; both private theorems stand at `Rigidity/ClassRatio.lean` ll. 887 and 1880; item 907's certificate is `U = 88.643400…`. **Ruling, four parts.** *Choice:* plan route (1); take (2)'s constant as the head statement if it costs little, with T7's `2√p` form as a corollary; record (3) as a reading for a stub of its own; draft row 75's grade note; draft making the two private theorems public as an edit to `Rigidity/ClassRatio`, applied only after FS131-ICO2 merges, because that job's branch edits the same file (D-E2, 78 lines) and the edit recompiles its dependents — the skeleton states what it needs as its own `sorry` leaves meanwhile. *Alternative weighed:* import Theorem 2.5 as the asking lane's entry says T7 needs — declined: one outside theorem fewer, and Mathlib has no Fourier analysis on `ℚ_p` to state it in. *Why:* fewer declared theorems is the publication bar's direction. *Confidence:* medium-high; it would change if the measure step needs more than one Hensel lift or a measurability lemma Mathlib lacks. **Correction owed:** `plans/POROS-2026-10-13-number-field-findings.md` § 3.3 rank 4 says T7 is "conditional on two printed theorems"; owed to the asking lane's next record if the kernel confirms route (1). **Credited:** the planner found the shorter route from the statement rather than the derivation's text.
> — source: plans/FS131-close-inventory.md

> 999. **FS131-KPA1 handed back: the `p`-adic plane planned, its skeleton green (logged 2026-10-16 14:36 UTC; "JOB FS131-KPA1 — DONE"; about 530k by the harness's count — past its line, not to be resumed; branch `fs131-kpa1` at `621ccacc4`; record `plans/FS131-KPA1-padic-plan.md`, report `data/fs131/reports/FS131-KPA1.md`).** Five skeleton modules `PadicPlane/{Basic, Measure, Upper, Tower, Values}`, 38 `sorry` leaves, about 1,535 hand-written lines by route A plus a generated certificate module at 7: `PadicPlane.le_borelChromaticNumber_of_charSum` (if every non-trivial character sum over the circle of `𝔽_p²` is at least `−κ`, `κ ≥ 2`, then `⌈1 + (p+1)/κ⌉ ≤ χ_Bor(ℚ_p²)`), `le_borelChromaticNumber_padicPlane` (the case `κ = 2√p`, FS66-T7), `not_exists_bound_borelChromaticNumber_padicPlane` (`[BardestaniMallahiKarai2017]` Question 1 answered no), the values `= 3, 4, 5, 5` at `p = 3, 7, 11, 19`, `6 ≤` and `≤ 8` at 23. Its findings: the route needs Weil's bound alone (item 997); the kernel already holds the certificates at 3, 11 and 19 (at 19 the Searcher's reduced one); FS-66's certificate at 7 checked by the kernel in a probe (8,598 ops, 48.8 s, 2.89 GB); the certificate at 23 is 1,444,136 ops, a search request; a correction owed (`[Madore2015]` Prop. 3.2 with Rem. 3.6, not Prop. 3.8, gives the chain's ends at `p ≡ 3 (mod 4)`; row 75's prior-art cell and `CLOSED-QUESTIONS.md` § 1.8; drafts in its § 5.2–5.3); row 75's grade note (§ 5.2); a stub to mint, the bound at every anisotropic local field (§ 5.5); bibliography read-status lines (§ 5.4); `LEAN.md` lines (§ 5.6). **My receipts:** the five commits exist; `data/fs131/kpa1/build-gate.log` ends "Build completed successfully"; I read the definition `borelChromaticNumber` (`PadicPlane/Basic.lean` ll. 47–48: the least `k` with a proper colouring into `Fin k` whose classes are `borel`-measurable, `⊤` if none), `padicPlane p := unitQuadrance ℚ_[p]` (`addCayley` of the unit circle `x² + y² = 1`), and the head statements in `data/fs131/kpa1/heads.out` — as reported, Borel throughout, the plain chromatic number of `ℚ_p²` not stated. Records, report and data copied onto `main`; the skeleton stays on its branch; the guard over the 19 files and the branch's messages: 0 refusals. **Rulings, four parts each.** (1) *T0 by route A* (public pieces, about 150 lines, no edit to `Rigidity/ClassRatio`); alternative, route B (about 20 lines after making two private theorems public, § 5.1) — declined: it waits on the collapse's merge and recompiles that file's 25 dependents for 130 lines; the § 5.1 edit is declined with it; medium-high. (2) *The landing goes without `six_le_borelChromaticNumber_padicPlane_twentyThree`:* the implementer moves that leaf out of the landing's modules, keeps its plan in the record, and states at 23 what is proved; the reduced certificate is search request 26 in `plans/SEARCH-QUEUE.md`; alternative, price FS-66's 26 MB file as a job of its own — declined until the search has answered, since the reduction at 19 cut that check by a factor of seven; high. (3) *The stub, the corrections and the grade note are filed at the landing,* with the implementer's drafts; high. **Announcement rule (item 995):** held only when its module passes the full gate on `main` and I have printed its axioms (expected: the bound and the unboundedness on the standard three and `StandingFive.kloosterman_bound`; each value on the standard three, or with Weil's bound where the lower half reads it).
> — source: plans/FS131-close-inventory.md

**Item 999's ruling (2), in practice:** `six_le_borelChromaticNumber_padicPlane_twentyThree` leaves the landing's
modules (nothing with a `sorry` reaches `main`); keep its statement and its plan in your record, and state at 23 what is
proved (the upper bound eight, and whatever lower bound the held pieces give). The reduced certificate it needs is search
request 26 in `plans/SEARCH-QUEUE.md`; a later job adds it. Ruling (1): T0 by route A, from public pieces, with no edit to
`Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` — another job's branch edits that file.

## The statements

The head statements as the skeleton types them on your branch (the plan names every other):

> /-- **Hoffman's bound of `UD(𝔽_p, 2)` carries to the Borel p-adic plane**: at `p ≡ 3 (mod 4)`, a lower bound `−κ`, `κ ≥ 2`,
> on the real parts of the non-trivial character sums over the circle of `(ℤ/p)²` gives
> `χ_Bor(ℚ_p²) ≥ ⌈1 + (p + 1)/κ⌉`. -/
> theorem le_borelChromaticNumber_of_charSum (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) {κ : ℝ} (hκ : 2 ≤ κ)
>     (h : ∀ ψ : AddChar (ZMod p × ZMod p) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re) :
>     ((⌈1 + ((p : ℝ) + 1) / κ⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
>   sorry
> 
> /-- **Every Borel colouring of the anisotropic p-adic plane uses at least `1 + (p + 1)/(2√p)` colours** (FS66-T7): for
> every prime `p ≡ 3 (mod 4)`, a proper colouring of `padicPlane p` with `k` colours whose colour classes are Borel sets has
> `1 + (p + 1)/(2√p) ≤ k`. The form a reader cites; `le_borelChromaticNumber_padicPlane` is the same in `ℕ∞`. -/
> theorem one_add_div_le_of_borelColoring (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) {k : ℕ}
>     (c : (padicPlane p).Coloring (Fin k)) (hc : ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑c ⁻¹' {i})) :
>     1 + ((p : ℝ) + 1) / (2 * Real.sqrt p) ≤ k := by
>   sorry
> 
> /-- **The Borel chromatic number of the anisotropic p-adic plane** (FS66-T7): for every prime `p ≡ 3 (mod 4)`,
> `χ_Bor(ℚ_p²) ≥ 1 + (p + 1)/(2√p)`, as the least integer above it. -/
> theorem le_borelChromaticNumber_padicPlane (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) :
>     ((⌈1 + ((p : ℝ) + 1) / (2 * Real.sqrt p)⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
>   sorry
> 
> /-- **`[BardestaniMallahiKarai2017]` Question 1 (the p-adic Hadwiger–Nelson problem), answered no**: no constant `B`
> bounds the Borel chromatic number of the p-adic plane as `p` ranges over the primes `p ≡ 3 (mod 4)`. Stated in the shape
> of the question. -/
> theorem not_exists_bound_borelChromaticNumber_padicPlane :
>     ¬ ∃ B : ℕ, ∀ (p : ℕ) [Fact p.Prime], p % 4 = 3 → borelChromaticNumber (padicPlane p) ≤ B := by
>   sorry
> — source: Proofs/HadwigerNelson/PadicPlane/Values.lean

> /-! ## The values -/
> 
> /-- **`χ_Bor(ℚ₃²) = 3`**: the bound gives `⌈1 + 4/(2√3)⌉ = 3`, and `UD(𝔽₃, 2)` is three-colourable. -/
> theorem borelChromaticNumber_padicPlane_three : borelChromaticNumber (padicPlane 3) = 3 := by
>   sorry
> 
> /-- **`χ_Bor(ℚ₇²) = 4`**: FS-66's certificate at 7 (`⌈49/U⌉ = 4`), and `UD(𝔽₇, 2)` is four-colourable. -/
> theorem borelChromaticNumber_padicPlane_seven : borelChromaticNumber (padicPlane 7) = 4 := by
>   sorry
> 
> /-- **`χ_Bor(ℚ₁₁²) = 5`**: FS-66's certificate at 11 (`⌈121/U⌉ = 5`), and `UD(𝔽₁₁, 2)` is five-colourable. -/
> theorem borelChromaticNumber_padicPlane_eleven : borelChromaticNumber (padicPlane 11) = 5 := by
>   sorry
> 
> /-- **`χ_Bor(ℚ₁₉²) = 5`**: the kernel's certificate at 19 (`U < 361/4`), and `UD(𝔽₁₉, 2)` is five-colourable. -/
> theorem borelChromaticNumber_padicPlane_nineteen : borelChromaticNumber (padicPlane 19) = 5 := by
>   sorry
> 
> /-- **`χ_Bor(ℚ₂₃²) ≥ 6`**: FS-66's certificate at 23 (`⌈529/U⌉ = 6`). -/
> theorem six_le_borelChromaticNumber_padicPlane_twentyThree : 6 ≤ borelChromaticNumber (padicPlane 23) := by
>   sorry
> 
> /-- **`χ_Bor(ℚ₂₃²) ≤ 8`**: `UD(𝔽₂₃, 2)` is eight-colourable. -/
> theorem borelChromaticNumber_padicPlane_twentyThree_le_eight : borelChromaticNumber (padicPlane 23) ≤ 8 :=
>   borelChromaticNumber_le_of_colorable 23 (by norm_num) CayleyCert.colorable_finitePlane23_eight
> — source: Proofs/HadwigerNelson/PadicPlane/Values.lean

The plan is `plans/FS131-KPA1-padic-plan.md` on your branch (also on `main`): its read-aloud of the head statements against ledger row 75, the
plan per leaf with routes, Mathlib names at the pin and line counts, the price, and its drafts for the front files. Its
report is `data/fs131/reports/FS131-KPA1.md`.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their sources; restate in your record the targets and
   the order of work; dump the skeleton's stored statements before your first proof, for the gate's comparison (the
   collapse job's method: `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ico1/lean/StatementDump.lean`
   and `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ico2/statements.py`, in that job's worktree; read
   them, never write there).
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind and writing the re-price into
   your record; a saved stage after each module.
3. **The build** through `./scripts/build.sh` under the slot, with no `sorry` in the landing's modules, and `lake lint`.
4. **Merge `main`**, then **the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/iqp1/`, its logs pointed there), every count change explained against the last gate on `main` (at present
   `data/fs131/il5/gate/`, gated on `113ca8ece`; if the collapse lands on `main` before your gate, its gate is the
   baseline, and I will tell you), the statement comparison against your stage-1 dump, the vacuity scan's new sites with
   each structure hypothesis's inhabitant named (`LEAN.md` § The gate), and `#print axioms` of every head statement
   (expected: the bound and the unboundedness on the standard three and `StandingFive.kloosterman_bound`; each value on the standard three, or with Weil's bound where its lower half reads it — the record says which).
5. **The read-aloud** of each head statement against ledger row 75, in your record, with what is not claimed.
6. **The drafts** for the front files (the planner's, brought to what is proved), each naming its slot; novelty in the
   ledger's words ("prior art: not found in print" only where that is the finding).
7. **The report**, in the standing rules' form.

## What is yours to decide

Every proof, helper lemmas and their modules, the order within the plan's order, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB until its gate is done. From inside
your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink.
`/tmp` is a tmpfs: keep what your record cites under `data/fs131/iqp1/`. Nothing with a `sorry` reaches `main`.
