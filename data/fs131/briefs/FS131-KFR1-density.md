# Brief FS131-KFR1 — the density form of the collapse at the kernel: a number field's finitary independence ratio is the larger of the plane's and its primes' — the map, the skeleton and the price

*Written 2026-10-16 15:11 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KFR1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for the density form of ledger row 128's collapse — row 129's field clause and the theorems beside it in FS-103's derivation — mapped against the library now that the collapse is a kernel theorem, stated in Lean, built as a skeleton with `sorry` at every leaf, planned per leaf and priced in lines of Lean
  launch: now, in the collapse's worktree on a fresh branch cut from `main`; beside you two kernel implementers and a clerk in other worktrees, none of which writes a file you write
  mission: § Why this job
  statements: § The results
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (a result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/FS131-KFR1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KFR1-density-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1`, on its branch `fs131-kfr1` (cut from `main` at `65ee5a95c`; `.lake/packages` a symlink to the main tree's, `.lake/build` the collapse's gated build, which is `main`'s): `plans/FS131-KFR1-density-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kfr1/`; `data/fs131/reports/FS131-KFR1.md`. Edits to the front files and to existing modules (the `Collapse/` modules among them) are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. The collapse landed on `main` an hour ago: the plane over ℚ(√635087) needs exactly as many colours as the whole
plane, in the kernel with no hypothesis of ours. Its derivation had a density form beside it, which nobody has planned
for the kernel; it may now be mostly built.

## Why this job

Kooshi's rule for what this project publishes:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The asking lane's rank 3 (`plans/POROS-2026-10-13-number-field-findings.md` § 3.2) is the collapse together with its density form; the collapse is held, and this
is the rest of it, as the lane wrote it:

> - *The theorem.* (Given the same printed theorem.) Let `F` be a totally real number field such that at every prime of `F(i)` fixed by complex
>   conjugation the finite graphs above have all non-trivial normalised eigenvalues below `1/5` in absolute value.
>   Then `χ(F²) = χ(ℝ²)`. This holds for `ℚ(√635087)` and for `ℚ(√3,√5,√7,√11)`, the field of de Grey's graph. With
>   `[OAIMath2026]`: `χ(ℚ(√635087)²) ∈ {6, 7}`, and since that plane has no unit triangle, a finite triangle-free
>   six-chromatic unit-distance graph exists. Density form: for a real number field `F`, the finitary independence
>   ratio of `F²` (row 129's `α₁(F²)`; its definition to be taken from the entry) is the larger of `m₁(ℝ²)` and the best
>   all-levels independence ratio among the finite graphs at its primes.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3 The first ten, each as the theorem a reader would look for

My log of the collapse's landing, with two items owed to the next job that touches `Collapse/` (its rulings (1) and (2)):

> 1005. **FS131-ICO2 handed back; the collapse lands on `main` (logged 2026-10-16 15:09 UTC; "JOB FS131-ICO2 — DONE"; about 530k by the harness's count — not to be resumed; branch `fs131-ico1` at `01f52bcef`; record `plans/FS131-ICO2-collapse.md`, report `data/fs131/reports/FS131-ICO2.md`).** All 49 leaves of the seven `Collapse/` modules proved (28 by FS131-ICO1, 21 here), 80 public theorems (`data/fs131/ico2/gate/theorems-proved.txt`); beyond item 1004's: `Collapse.chromaticNumber_planeOver_eq_plane_of_forall_thickAt` (row 128's per-place words; with Weil's bound, which makes per-place thickness uniform), `chromaticNumber_planeOver_sqrt635087_six_or_seven` (`6 ≤ χ(ℚ(√635087)²) ≤ 7`, adding `Outside.OAI158.no_proper_five_coloring`), `chromaticNumber_plane_le_of_thick` (the load-bearing step, on Thm 1.3 alone); the kernel's thickness at the two fields is Weil's bound (`2√103/104 = 0.1952`, `2√131/132 = 0.1734`), not row 128's exact spectra; two docstrings that overclaimed a model corrected (docstrings only). Drafts D1–D13 for the front files. **My receipts:** the commits after `7c72b9bf7` touch `plans/` and `data/` only (26 files); the guard over the branch's 130 changed files and its messages: 0 refusals; `git merge-tree` clean. **Read aloud against row 128, by me:** the row is "given MR … for every totally real number field `F` whose stable places are all 6-thick (`λ*_v < 1/5` at every level, both signs) … `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)`; instances ℚ(√635087) … and de Grey's field"; the kernel holds the field equality `χ(F²) = χ(ℝ²)` with no MR hypothesis (MR proved from Thm 1.3), at every real number field, totally real or not, uniformly `c`-thick with `c < 1/5`, and per place given Weil's bound; both instances with no hypothesis. Not in these statements: `χ_CP` (the plane's equality is `Outside.OAI158.chromaticNumber_plane_eq_chiM0`, held separately), and the row's consequences beyond `6 ≤ χ ≤ 7` (the triangle-free clause, S_nf). **Announcement rule (items 977, 988): met** — merged into `main` as `0f81fe2a3` (`--no-ff`), `main` equal to `7c72b9bf7` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files; the axioms printed by me (item 1004); the statements read above. The main tree's build: the gated build copied in, then `build.sh`: "all 2162 modules already up to date, nothing built, 0 module(s) with warnings". **Rulings, four parts each.** (1) *The two one-line splits of the six-or-seven corollary* (`six_le_chromaticNumber_planeOver_sqrt635087`, `chromaticNumber_planeOver_sqrt635087_le_seven`, proposed for `exact?`) *are owed to the next job that touches `Collapse/`*, not added now; alternative, add them now — declined: two new public statements after the gate need a gate of their own; high. (2) *The model at `k = 7`* (a field uniformly thick below `1/6`, every stable residue size `Q ≥ 142`, inhabiting the selection's joint hypotheses) *is owed with them*; medium. (3) *The filing by a Clerk* (FS131-FC10, `.claude/worktrees/filing2`, branch `fs131-fc10`), with the audit's transition written by me in its brief; alternative, file the thirteen drafts myself — declined: the workflow names the Clerk the pen for a large filing, and two implementers are running; high. **Credited:** the job lowered its own build's memory cap to fit beside two planners, and found that the general form needs one outside theorem fewer than its instances.
> — source: plans/FS131-close-inventory.md

## The results

Ledger row 129, quoted whole — its plane clause is a kernel theorem since FS133-LD1; its field clause is what this job
plans:

> | 129 | **Row 123's five is a fractional bound rounded, and given MR the fractional local–global principle holds exactly. Row 123's chain runs one colour class at a time; the colour count enters only at the pigeonhole on the densest class, so its bound is `χ(F²) ≥ ⌈1/α_loc(F)⌉` with `α_loc(F) = max(m₁(ℝ²), sup_v r_v)` (`r_v` a stable place's all-levels independence ratio) and `1/α_loc ≤ 4.36`: that route never gives six. Given MR(F), every `R ⋊ U`-invariant random independent set of `F²` has density at most `α_loc(F)`, so the finitary independence ratio is `α₁(F²) = α_loc(F)`; unconditionally a denser invariant set gives an SP witness. With no MR (FS-133; `plans/FS133-E1-derivation.md`, C133-ONE, C133-FN): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, i.e. `f(n)/n → m₁(ℝ²)` — the first clause of `[DuczVarga2026]` Conjecture 1 — and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²) ∈ [4.04876, 4.35987]`, answering `[MatolcsiEtAl2025]` §2's "it is not known whether equality holds" — posed first by `[Johnson1996fcn]` (p. 103, Question 1; p. 104, Question 3) and `[Johnson2000surprises]` (p. 143, Problems 3 and 4), read at their pages 2026-09-27 and 2026-10-06; over `[OAIMath2026]` family 158's Theorem 2.3 (`wild_fourier`) read as a statement, with no Tarski. At ℚ(√635087), given MR there, finite triangle-free unit-distance graphs reach it. At ℚ(√47), given MR there, held certificates give a triangle-free graph with `χ_f ≥ 4.0000439`** (FS-103; FS103-F-SI, EXT, FRAC, TJ, ROUND, DV, TF, 47, PL, B-AMEN, B-CHIF). **[hand + tools exact; FRAC, TJ, ROUND, DV, TF, 47 two derivations (FS103-F; FS103-B blind to F's record); B-AMEN's reverse half and B-CHIF one mind, both off the killing test's chain and off `α₁(ℝ²) = m₁(ℝ²)`, which use only B-AMEN's Følner half (two blind: F, B; FS105-W-D1); the whole weight MR's (row 120); the plane's clause since FS-133 not MR's: C133-ONE and C133-FN **[kernel]** since FS133-LD1 (`OneClass.finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`, `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`, `tendsto_minIndepNum_div`; each on `[propext, Classical.choice, Quot.sound]`), through `[OAIMath2026]` Theorem 2.3 composed with the spectral theorem — the release's `Spectral.residual_fourier`, its proof ported (`Outside/OAI158Ergodicity`, FS131-KO1 to FS131-LP1); the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set); the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470` — the upper end `[AmbrusEtAl2023]` Theorem 1 itself, **[kernel]** since FS131-LDB1 (`Plane.oneAvoidingDensityBound`, with `Plane.mOne_le_of_oneAvoidingDensityBound`; standard three), so `1/m₁(ℝ²) ≥ 1/0.2470 > 4.0485` there, short of the interval's `4.04876` (the paper's computed `0.24699…`)]** Mechanism: the published expectation `α₁(ℝ²) ≠ m₁(ℝ²)` (`[AmbrusEtAl2023]` §4; `[MatolcsiEtAl2025]`) came from graphs in the Moser lattice, where the tight dyadic places pin `1/4`; the gap is a place's, gone at a field whose places all read below `m₁` (G60). **The finite-graph killing test for MR is withdrawn (FS-133):** `α₁(ℝ²) = m₁(ℝ²)` holds with no MR, so no proof of `α₁(ℝ²) > m₁(ℝ²)` exists and the test as filed can never fire (its cheap form `α₁ ≥ 1/4` was false in print, FS105-W-D1, W-D2). What stays testable is the field form: unconditionally `α₁(F²) ≥ α₁(𝒜²) = m₁(ℝ²)`, and given MR(F) at a field whose places all read below `m₁`, `α₁(F²) = m₁(ℝ²)`; so a proof that every finite unit-distance graph **in ℚ(√635087)²** has independence ratio at least some `c > m₁(ℝ²)` refutes MR there. **Not claimed:** `m₁ = δ_Croft` (the conjecture's second clause); any value of `m₁`; anything at six. **Prior art:** `[MatolcsiEtAl2025]` Conjecture 1 was already disproved in print by `[DuczVarga2026]` (held, read); the equalities not found (F §3.6, five queries; a gate under descriptive-combinatorics names owed; FS-133's gate (fifteen arXiv queries, two web searches, 2026-10-07; zbMATH down): not found; the descriptive-combinatorics neighbours named, unread (`plans/FS133-one-class-transfer.md` § PA.4)); the plane's equality is the `d = 2` case of `[Davies2026]` Thm 1.1's density half (`ᾱ_D(ℝ^d) = m_D(ℝ^d)`, proved there for `d ⩾ 4` only, by a transference that is four-dimensional; its abstract hopes for `d = 2`) — read in full 2026-10-13 (FS131-ER1), not in it; B-CHIF likely folklore. Notation: F's `ρ(F)` is renamed `α_loc(F)` against MRVZ's Hall ratio `ρ(ℝ²) = 1/α₁`. | `plans/FS103-derivation.md` §2; `plans/FS103-F-fractional-shadow.md` §2–§3; `plans/FS103-B-verification.md` §2–§4; `tools/fs103_f_places.py`, `tools/fs103_b_places.py`; `plans/FS105-derivation.md` §4 | FS-103 (2026-09-26) |
> — source: LEDGER.md

The derivation's entries (`plans/FS103-derivation.md`; FS-103's fixed claim list `data/fs103/claims.md`; the close's assembly
`plans/FS103-collapse-cp-plane.md` § R-close):

> **FS103-F-FRAC — The fractional local–global principle: given MR(F), every `R ⋊ U`-invariant random independent set of `F²` has density `≤ α_loc(F) = max(m₁(ℝ²), sup_v r_v)`, so `α₁(F²) = α_inv(F²) = α_loc(F)`; unconditionally, an invariant set of density `> α_loc(F)` gives an SP witness. [hand, two (F; B blind), over held lemmas (J45-N1/N2, R-U, SP-oi; X25B-L1/PZ/T or C14.1–C14.3; R88-TC-ext), given MR(F)]** *Proof:* F §2.3; B §2.1. *Proof verdict:* TRUE given MR, both; the count of classes never appears (B). F §3.4 item 2 ("the reverse `α₁(F²) ≥ α_inv` is false in general") is false — it holds for every real field (B-AMEN) — a slip in F's commentary, no claim affected. *Rests on it:* FS103-F-ROUND, -DV, -TF, -47; row 129. *Prior art:* the header's. *Kernel:* declined.
> — source: plans/FS103-derivation.md

> **FS103-F-TJ — T-J39-3 per class: a density-`δ` invariant independent set gives `max(m₁, max_{v ∈ N_δ} r_v) ≥ δ` or an SP witness, `N_δ` the stable places with `λ*_v ≥ δ/(1−δ)` (thick at density `δ` iff `λ* < δ/(1−δ)`); as a construction the mixing selection per class keeps only density `≥ (δ − ϑ)/(1 − ϑ)`, `ϑ = λ*/(1 + λ*)`. [hand, two (F; B)]** *Proof:* F §2.4; B §2.2. *Proof verdict:* TRUE, both; the claim file left `ϑ` undefined (B) — defined here. *Rests on it:* FS103-CTL's CTL-FRAC. *Prior art:* the header's. *Kernel:* declined.
> — source: plans/FS103-derivation.md

> **FS103-F-ROUND — Row 123's lower bound is `χ(F²) ≥ ⌈1/α_loc(F)⌉`: the colour count enters row 123's chain only as the pigeonhole on the densest class (X25B-T); `1/α_loc(F) ≤ 1/δ_Croft ≤ 4.35987` at every field, so this route never gives six. [hand, two (F; B)]** *Proof:* F §2.5; B §2.3. *Proof verdict:* TRUE, both. *Rests on it:* G24 and G60's updates; the verdict's first line. *Prior art:* the header's. *Kernel:* declined.
> — source: plans/FS103-derivation.md

> **FS103-F-TF — Given MR(ℚ(√635087)): for every `ε > 0` a finite unit-distance graph without triangles has independence ratio `≤ m₁(ℝ²) + ε ≤ 0.24699 + ε`, so fractional chromatic number `≥ 4.0487 − O(ε)`. [hand, two (F; B)]** *Proof:* F §3.2; B §3.4 (FRAC at a field without `√3`, G57). *Proof verdict:* TRUE given MR, both. *Rests on it:* row 129. *Prior art:* every graph of `[DuczVarga2026]` contains triangles (its field holds `ζ₆`, F). *Kernel:* declined.
> — source: plans/FS103-derivation.md

> **FS103-B-AMEN — For every real number field, with no MR: `α₁(F²) = α_inv(F²)` (an invariant random independent set of density `δ` meets any finite `G ⊂ F²` in `δ|G|` points on average), and `α_inv(F²) ≥ α_loc(F)` (pullbacks). [hand, one mind (B)]** *Proof:* B §2.1 "The equalities". *Proof verdict:* not re-checked; it refutes F §3.4 item 2 as worded. *Rests on it:* FS103-F-FRAC's equality form. *Prior art:* the header's. *Kernel:* declined.
> — source: plans/FS103-derivation.md

Measure rigidity at a number field, which these entries are "given", is now proved in the library (`Rigidity.mrPlus`, on
the standard three and `Rigidity.positive_entropy_rigidity`), and the collapse's planner showed that it discharges the
derivation's one use of MR in the load-bearing step (`plans/FS131-KCL1-collapse-plan.md` § Stage 2). Whether the same holds
at each use above is part of your map. The plane's density equality is FS-133's (`plans/FS133-E1-derivation.md`, its landing `plans/FS133-LD1-landing.md`;
in the kernel as `OneClass.finIndepRatio_plane_eq_mOne` in `Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean` and its
neighbours, `CLAUDE.md` § Where the problem stands).

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, each result, each hypothesis it rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** Each step of the five entries, and of the two owed items of item 1005, set against what the
   library (the seven modules under `Proofs/HadwigerNelson/Collapse/`, those under
   `Proofs/HadwigerNelson/Plane/OneClass/` and `Proofs/HadwigerNelson/Rigidity/`) and Mathlib at our pin hold, by declaration name and
   module; for every use of MR, whether `Rigidity.mrPlus` discharges it; what is missing, with your estimate of each piece in
   lines of Lean. Also say whether "a finite triangle-free six-chromatic unit-distance graph exists" (the asking lane's
   corollary) is within reach from the held `6 ≤ χ(ℚ(√635087)²)` and a de Bruijn–Erdős step, and at what price.
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean, read back aloud against row 129 and the
   entries in your record, with what is not claimed; every missing piece as a statement with `sorry`, built through
   `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the
   experience-modeling pass on the head statements (`debruijn-experience-modeling`). Nothing with a `sorry` reaches
   `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your
   record, each naming its slot.

## What is yours to decide

The definitions (which of the library's independence ratios each entry's `α₁`, `α_inv` and `α_loc` is, or a new one), the
modules' names and places, the form of every Lean statement, which results ride in the first module, and the order of the
leaves. If an entry is misstated, or holds in a wider form (as the collapse did: every real number field, not only totally
real ones), say so: a wrong statement reported is a finding, and a better target is welcome with its price.

## The machine

The laptop: 12 cores, 31 GB, shared with two implementers and a clerk. Every Lean build and every `lake env lean` over
about 2 GiB goes through the slot, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kfr1/`.
