# Brief FS133-LD1 — land the density equality on `main` through the full gate, after the port: FS-133 closes

*Written 2026-10-14 13:09 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-LD1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the lander of the density equality — a module of eight files under `Plane/OneClass/` with nothing unproved, on one declared theorem of the outside release that the port, now on `main`, proves; you join it with `main` by the port planner's recipe (the copied definitions and the declared theorem removed, the ported ones read in their place), make two ruled corrections, take it through every step of the gate on one commit, read its headlines aloud against their claim list, and draft the front-page lines that close its milestone; the merge into `main` is the coordinator's, at your green line
  launch: now, in the density equality's tree — its last job has handed back and nobody else writes there; three other jobs (the class-ratio certificates, the density bound's planner, the chain's implementer) work in other trees and share the build slot; `main` at `7d0df2562` holds the port and its filing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if the join conflicts outside the files the recipe names, if a step of the recipe's check column fails (step 8's dump not IDENTICAL is a stop), if the read-aloud finds a statement that says more or less than its claim-list entry, if a count is not what the audit's own arithmetic predicts, and **with one line when the gate is green on one commit** (then finish your record and hand back: the merge into `main` is mine); the report goes to `data/fs133/reports/FS133-LD1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-LD1-landing.md` (new, on branch `fs133-wl1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` on a **new branch `fs133-wl1`** that you cut from its head (`fs133-wpq` at `110f1c923`; its compiled library is current for that commit): the merge of `main`; the recipe's edits — deleting `Proofs/HadwigerNelson/Outside/OAI158Transfer.lean` with its lines, and in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean` the six copied definitions and the declared `residual_fourier` (the kept declarations character for character, the module docstring rewritten), one import line in `Proofs/HadwigerNelson/Plane/OneClass/Field.lean`; the two ruled corrections in the module's files under `Proofs/HadwigerNelson/Plane/OneClass/` (below; no other statement change); docstrings, prose only, where they still call `residual_fourier` declared; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the recipe and the gate's steps require; your checks under `tools/` named for this job; `plans/FS133-LD1-landing.md`; `data/fs133/ld1/`; `data/fs133/reports/FS133-LD1.md`. **Not** any module under `Outside/` the port generated (the generator writes those, and it is frozen), any other module, the front files (you draft their lines). Nothing on `main`; no push
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the join builds, after each gate step that passes, and at the green line

Hello. This is the fifth landing on this machine in two days. The density equality was proved in the kernel last
night, file by file, by five implementers, with one theorem of the outside release taken as declared; this
afternoon the port of that release's proofs landed on `main`, and the theorem it declared is now proved there. You
bring the two together and make it held.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

When this module passes the gate on `main`, FS-133 (the one-class transfer) is Closed: its Lean module is through the
gate. Its headline answers a question the literature has posed — the first clause of `[DuczVarga2026]`'s Conjecture 1
and `[MatolcsiEtAl2025]` §2's equality question — and its claim list says plainly that the result is not new (below).

## The statements

The module's headlines, as its claim list states them, and what it does not claim (`data/fs133/claims-K1.md`):

> K133-ONE: (entry at line 469 of the derivation file) `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`
> — source: data/fs133/claims-K1.md § Statements

> K133-FN: (entry at line 487 of the derivation file) `f(n)/n → m₁(ℝ²)` as `n → ∞`, where `f(n)` is the minimum of `α(G)` over `n`-point subsets `G` of the plane
> — source: data/fs133/claims-K1.md § Statements

> K133-PAIR: (entry at line 649 of the derivation file) an admissible `ℓ : ℝ² → Λ` exists if and only if a Lebesgue-measurable `ℓ : ℝ² → Λ` admissible almost everywhere exists; and an admissible `ℓ : ℝ² → Λ` exists if and only if an admissible `ℓ : E → Λ` exists
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-ONE: any value of `m₁(ℝ²)` or of a chromatic number; `m₁(ℝ²) = δ_Croft`; that some finite graph attains `sup χ_f(G)` (`[Johnson1996fcn]` Question 2); anything at a number field's plane (row 129's field form keeps "given MR"); anything at six colours — `1/m₁(ℝ²) ≤ 4.36`; that the release states any of this
> — source: data/fs133/claims-K1.md § Not claimed

> K133-NC-ALL: any value of the densities or of a chromatic number; anything at a number field's plane; that the outside release states any of these (its manuscript does not); that the result is new — a paper posted on 8 October 2026 proves the same sentence in dimension four and up and names the plane as its aim (`BIBLIOGRAPHY.md`, the row keyed Davies2026; `plans/FS131-ER1-davies-reading.md`).
> — source: data/fs133/claims-K1.md § Not claimed

The density equality's last hand-backs and the rulings on its landing, as I logged them (their words in quotation
marks; the rulings are mine and are your rules):

> 779. **FS133-ICD1 handed back: the density equality's headlines have nothing unproved beneath them (2026-10-14 10:25 UTC logged; "JOB FS133-ICD1 — STAGE 4 SAVED"; 485k by the harness's count — not to be resumed; branch `fs133-wcd` at `b84e09ef8`, tree `fs133-wk1`; record `plans/FS133-ICD1-implementation.md` there).** From its hand-back message: "Lane C is finished and lane D is not. 11 of the 13 leaves are proved in the kernel, and no statement changed … In `Pair`, Q4 and Q5 are still `sorry` and were not started"; "the headlines now have no `sorry` beneath them, each on Std + RF: K133-ONE, first line: α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²) … second line: χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²) … C133-FN: f(n)/n → m₁(ℝ²)"; "C133-PAIR is not landed"; "92 stored statements compared … 89 are identical; the 3 made public keep identical stored types"; "all 125 records of the module match plan § 5.5. 110 rest on Std, 11 on Std + RF, and 4 (the open Q4/Q5 records) on `sorryAx`"; a correction owed (an import of `Mathlib.Analysis.Subadditive` not named by the plan; no stored statement moved); a tool note (a `simp only` generated `Subadditive.lim.congr_simp`, replaced by `rw`); Q4 and Q5 "priced at one to two long stages each … Q5 needs two new pieces: a density-point lemma for two sets at radius r; an extension lemma (Rado selection) for a pattern of forbidden label pairs". **My receipt:** from the tree's compiled library under the memory tool (scratch `icd1/Ax.lean`): `OneClass.finIndepRatio_plane_eq_mOne : (unitDistance ℂ).finIndepRatio = Plane.mOne` and `OneClass.fractionalChromaticNumber_plane : (unitDistance ℂ).fractionalChromaticNumber = Plane.mOne⁻¹`, each on the standard three and `Outside.OAI158.Spectral.residual_fourier`; `mOne_le_finIndepRatio` on the standard three. As reported. (The memory tool waited once for room, "ledger 20 + 4 > budget 22 GiB" — its budget, not the machine's: 27 GB of 31 were available.) **What this is:** ledger row 129's plane clause — the largest density of a set with no two points at distance one is the same for arbitrary and for measurable sets, and the plane's fractional chromatic number is one over it — in the kernel, on one declared outside theorem the port is turning into a theorem; not on `main`, not through the gate; the claim list's *not claimed* holds (nothing beyond `1/7 ≤ m₁(ℝ²)` about the value). **Rulings.** (1) *Q4 and Q5:* a fresh implementer in this tree when the next slot frees (the module's landing waits on the port, about 12–20 hours of lanes, so they have slack); its brief carries the two new pieces as planned leaves, and if either is larger than a stage the implementer says so first; alternative, land the module without `Pair` — declined, the module passes the gate whole or not at all, and C133-PAIR is in its claim list; high. (2) *The unnamed import:* accepted (no statement moved); the landing's ARCHITECTURE cell draft carries it. (3) *The `congr_simp` tool note:* for the joins — `dupnames.sh` runs before every audit at a join (the recipe's step 6), which catches it. **For Kooshi's report — the night's headline result, at its grade:** the density equality is proved in the kernel modulo one declared theorem of the outside release, which the port is removing; it answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's question; it is not yet merged or through the gate.
> — source: plans/FS131-close-inventory.md

> 789. **FS133-IPQ1 handed back: the density equality's module has no `sorry` (2026-10-14 12:20 UTC logged; "JOB FS133-IPQ1 — DONE"; 394k by the harness's count — not to be resumed; branch `fs133-wpq` at `110f1c923`, tree `fs133-wk1`; record `plans/FS133-IPQ1-implementation.md` there).** From its hand-back message: "Both of `Pair`'s leaves are proved and checked by the kernel. No statement changed except one hypothesis I dropped because the proof never used it (the standing word of item 726). `Plane/OneClass` now has no `sorry`. It is not on `main` and has not been through the gate"; Q4 on the standard three and `residual_fourier`; Q5 on the standard three alone — "The distances only have to be positive: they need not be algebraic or countable"; "C133-PAIR. Both clauses … now have no `sorry` beneath them"; "Of 175 constants in the seven files, 174 are IDENTICAL and 1 is BINDER-DROPPED"; "All 125 axiom records match the plan's § 5.5: 111 on the standard three, 14 also on `residual_fourier`, none on `sorryAx`"; a lint failure outside its touches — "`HadwigerNelson.Plane.ofReal_integral_le_measure_pos` (Plane/OneClass/SectionDensity.lean l. 156 …) Its argument 4, `[IsProbabilityMeasure μ]`, is never used"; a correction owed to FS133-ICD1's draft block's wording. **My receipt:** `grep -c sorry` on the seven files of `Plane/OneClass`: 0 each; from the tree's compiled library under the memory tool (scratch `ipq1/Ax.lean`): `exists_admissibleOn_univ_iff_ae` and `exists_admissibleOn_univ_iff_algPlane` — the standard three and `Outside.OAI158.Spectral.residual_fourier`; `exists_admissibleOn_of_ae` — the standard three. As reported. **Rulings.** (1) *The unused `[IsProbabilityMeasure μ]` of `ofReal_integral_le_measure_pos`:* dropped by the density equality's landing, by the unread-binder rule, with the dump and its callers rebuilt; alternative, silence the linter — declined, the rule drops an unread binder of ours; high. (2) *ICD1's block wording:* corrected at the landing from IPQ1's DQ1. (3) *The module:* complete on its branch; its landing follows the port's, by the join recipe (FS131-KO1 § 4.5), and adds no axiom; the tree's compiled library is kept for it. **For Kooshi's report:** the density equality's module (eight files) has nothing unproved; on one declared outside theorem the port removes; not yet merged or gated.
> — source: plans/FS131-close-inventory.md

> 798. **FS131-IPD1 — the switch's steps 0–5 done; the join's step 0: three shared definitions up to proof arguments, ruled (2026-10-14 14:05 UTC; by message).** From its message: "54 of the 57 shared constants are IDENTICAL; three are INSTANCES-ONLY … `approxField`, `approxIndex` and `measurableField` … Their types are IDENTICAL. Their values differ only in which generated proof auxiliary they cite … The auxiliaries are the same propositions: their types print alike on both sides … Nothing downstream stores these values"; "`Spectral.residual_fourier` is an axiom there and a theorem of OAI158Ergodicity here, its type IDENTICAL in full print"; "Switch steps 0–5 are done. All 485 named constants of OAI158 and its 24 downstream modules are IDENTICAL after the build, the five moved ones included … `proper_to_borel_weak` is now a theorem of OAI158BorelTransfer, its type IDENTICAL to the axiom's. The twelve records plus T itself print exactly the standard three. `axioms.sh`: OK, 8961 clean, 32 axiom-free, 26 imported, 5 purchases; 2 declared imports." **Ruling:** the three classed up to proof arguments, each side's auxiliary recorded by name with its type, and the join's step 8 dump of the eight density modules IDENTICAL or a stop; alternative, re-elaborate the density copies first — declined, equal by proof irrelevance with nothing downstream storing them; high. **A count read:** 26 imported is `main`'s 38 less the transfer's twelve (twenty on Weil's bound, six on the five-colouring theorem); the plan's "26 → 14" (§ 4.6) predated FS131-LJ1's twelve records on Weil's bound — the landing reads the audit, not the plan. Sent by one message.
> — source: plans/FS131-close-inventory.md

> 840. **FS131-LP1 handed back: the port of the transfer proof through the full gate (logged 2026-10-14 13:01 UTC; "JOB FS131-LP1 — DONE"; 714k by the harness's count — past the line, not to be resumed; branch `fs131-wlp` at `1d98dc942`, gated at `75a0035f1`, tree `fs132-wi1`; record `plans/FS131-LP1-landing.md`).** From its hand-back message: "`HadwigerNelson.Outside.OAI158.proper_to_borel_weak` is now `[OAIMath2026]`'s theorem with its proof ported, on `[propext, Classical.choice, Quot.sound]`"; "Read term for term against the release's statement: the read-back says IDENTICAL, and my own print of the stored types (564 characters) is identical at both pins. Its stored type is also the type of the axiom it replaced"; "the twelve theorems that rested on the axiom now each rest on exactly the standard three" (named: `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, `chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0`, `seven_le_chromaticNumber_plane_iff`, `Plane.exists_isWeakColouringOn_of_colorable`, `radius_down`, `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball`, `colorable_iff_exists_nullMeasurable_proper`, `chromaticNumber_plane_eq_chiLebesgue`, `chromaticNumber_euclidean_plane_eq_chiLebesgue`); every count as predicted; "READBACK OK, 524 constants, 0 failing"; the comparator streaming ("Lane D ran in 1 minute at 4.0 GiB instead of 20 GiB"); the four read-back items closed under rulings 1–3; the lint's 25 findings silenced in-file under Amendment 1 ("`@[nolint]` does attach to anonymous instances at this pin, so the fallback was not needed"); "No stored statement moved". **My receipts:** item 839 (the gate's logs read); the two commits after `75a0035f1` touch only `data/` (59 files) and `plans/` (1); the trial merge with `main` reported no conflict. **Its inventory lines, filed here:** results — the transfer and its twelve consumers on the standard three, the library's declared outside axioms 3 → 2; the comparator streams within 8 GiB with its controls; `generator_unitary`'s two instance paths agree by kernel `rfl`, the planted disagreement refused; the four new skipped refutations named (record stage 4.3). Tool defects (to the tooling list): FS131-IPD1's ADAPTED_VALUE plant changed only an instance argument and is re-aimed; the CLASS_PARAMS withdrawal plant cannot fire on lane D and now reports UNREACHABLE; the lint had never run over the port. **Corrections owed** (to the second filing): `scripts/Vacuity.lean` line 561's history paragraph still calls the transfer "the imported `proper_to_borel_weak`"; `plans/EXT-OAI1-audit.md` "about 16,600 lines" → 12,005 lines of declarations (15,964 with scaffolding; item 759). **For the density equality's landing:** its join (KO1 plan § 4.5, steps 1–9) can read this landing's receipt that the ported `residual_fourier` has exactly that branch's axiom's type. **Open gate items, none a red check:** the density branch's join; `lean4checker` not run on the port; the whole-file comparator kept as a reference; lane D's prints not committed (reproducible by script); ADAPTED_VALUE accepting instance-argument changes, by its ruling; the generator's text-only statement guard; `Vacuity.lean` line 561; EXT-OAI1's line count; `hexShell_plane5`'s classing. Disk: its 2.9 GB of prints deleted; 318 GB free after.
> — source: plans/FS131-close-inventory.md

> 841. **The port merged into `main`; item 808's announcement rule met (2026-10-14 13:01 UTC).** Merge `398523e99` (`--no-ff`, `fs131-wlp` at `1d98dc942`; no conflict). **The check:** `main` against the gated commit `75a0035f1`, outside `plans/` and `data/`, differs in two files only — `.claude/output-styles/keryx.md` (the staffing line, item 825) and `BIBLIOGRAPHY.md` (Rudin's row, item 828) — and those differences are line for line `main`'s own edits since the branch's base `e928d4aa2`; `Proofs/`, `Proofs.lean`, `scripts/`, `tools/`, `ARCHITECTURE.md`, `LEAN.md`, `CLAUDE.md` and the package files are equal to the gated commit. So all three conditions hold: the gate green on one commit, merged into `main`, `main` equal to it outside `plans/` and `data/`. **Held on `main`, through the gate:** `[OAIMath2026]` family 158's transfer from an arbitrary proper colouring of the plane to a Borel one proper at almost every unit pair is a theorem of this library, ported with its proof, on the standard three axioms; with it `χ(ℝ²) = χ_m⁰(ℝ²)`, `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²) = χ_m(ℝ²)` and the disc criterion's half toward seven rest on the standard three; the library declares two outside axioms (Weil's bound, the release's five-colouring theorem). Other people's mathematics, ported; no value moved. **The reference compiled tree for `main` is now `fs132-wi1`** (its build is the gated one, current for `main`'s Lean); `fs131-wrc` holds the pre-port build. **Next, by the handoff's order:** the filing (the Clerk, FS131-FC4, in `fs132-wi1` on a branch from `main`, which changes no Lean source there), then the density equality's landing. **The slot:** the one FS131-LP1 freed; the Clerk counts a half; the density equality's landing (an implementer, a whole slot) waits for the filing's hand-back or the next free slot, so that its drafts quote the front page as filed — alternative, launch it now beside the Clerk — declined, a slot and a half over the cap of four; high.
> — source: plans/FS131-close-inventory.md

**The recipe** is `plans/FS131-KO1-port-plan.md` § 4.5 on `main` (steps 0–9; step 0 is done, item 798). It names the branch `fs133-wb1`;
`fs133-wpq` descends from it and holds the whole module. **The two ruled corrections:** (1) the unread
`[IsProbabilityMeasure μ]` of `ofReal_integral_le_measure_pos` dropped (item 789 ruling 1) — a statement change, dumped
before and after, its callers rebuilt; (2) ICD1's block wording corrected from IPQ1's DQ1 (item 789 ruling 2; the record
`/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IPQ1-implementation.md`). Where everything else is, in your tree: the plan `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-kernel-plan.md`, the implementers' records (`/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-ICD1-implementation.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IPQ1-implementation.md` and the
three before them). On `main`: the port's landing record `plans/FS131-LP1-landing.md` — its receipts `data/fs131/lp1/gate/` are **the "previous"
side of your digests**, and its slot checker `data/fs131/lp1/drafts-slots.py` is the pattern for yours; the milestone's
stub `plans/STUB-one-class-transfer.md` and inventory `plans/FS133-close-inventory.md` (read, not written).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; `LEAN.md` § The gate, § Assumptions and
   § Trust ledger as they stand on `main`; step 1 of the recipe (the dump of every named constant of the eight modules,
   from this tree's build, before the merge).
2. **The join** (recipe steps 2–9; a saved stage, the build's one line to me): the merge of `main` (a trial first, naming
   any conflict); steps 3–5; the doubled-name check before the audit (step 6); the build (step 7); the dump compared
   (step 8: IDENTICAL, or INSTANCES-ONLY and then the kernel `Eq.refl` check with its plants; `Spectral.residual_fourier`
   a theorem of the port, its stored type the declared one's — the port's landing logged that receipt, item 840); the
   axioms of `residual_fourier_cross`, `OneClass.exists_field` and every record of the module (step 9: the standard three).
3. **The two corrections**, shown from the kernel's side against item 1's dump (the dropped binder the only change).
4. **Read aloud**, in your record: each headline's stored statement against its claim-list entry above — the density
   equality in both forms, the finite-subset limit, the labelling claim both ways — and say which Lean names carry each.
5. **The full gate on one commit**, as the port's landing ran it (its record § Stage 7): `./scripts/build.sh` with zero
   warnings; zero `sorry` in `Proofs/` (a search whose plant fires); the doubled-name check and its `--self-test`;
   `scripts/axioms.sh` clean with `--self-test` green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled;
   `./scripts/assumptions.sh` and `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint
   --no-build -- --no-build --trace`, under the slot), silent, with its planted control red; the notes check and the
   records check; the generator's `--check` on the port's modules (unchanged by you). The three digests against
   `data/fs131/lp1/gate/receipt-axioms-final.log`, `data/fs131/lp1/gate/receipt-vacuity-final.log` and
   `data/fs131/lp1/gate/receipt-assumptions-final.log` (say exactly which front-page lines they report stale). The audit
   reads 9,024 records on `main` (8,961 clean, 32 axiom-free, 26 imported, 5 purchases); predict this landing's counts
   from the module's records before the run, and reconcile every difference. Every step's log saved under
   `data/fs133/ld1/gate/` and named, with its wall time and peak memory. Then one line to me.
6. **Drafts for the filing**, in your record under "Drafts for the front page (FS133-LD1)", each with the log line it
   comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once (give the
   fact-audit tool's table every token your drafts retire): the audit's, the gate's and the assumptions' count lines in
   `CLAUDE.md`; FS-133's state Derived → Closed wherever `CLAUDE.md` names it (§ Frontier, its open-milestones paragraph,
   § Publication's "Held so far" clause, § The aim), with the Lean names; `LEDGER.md` row 129's grade regraded to
   [kernel] for what the module holds, the rest left at its grade; `plans/FRONTIER-STUBS.md`'s line and the stub's
   banner; `ARCHITECTURE.md` § Trust and its rows; `LEAN.md`'s lines from the implementers' records; a `GATE_CHANGES`
   entry. **Whose it is**: say what the claim list's not-claimed lines say — the statement is not new; the kernel proof
   is this project's; the transfer and the residual Fourier step are `[OAIMath2026]`'s. And the open gate items, by name.
7. **Your record**, stages headed "Stage n — SAVED (FS133-LD1)"; the report in the standing rules' form, the counts read
   from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with the gate
   red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; the batch size of each build; the wording of a docstring or an
open gate item. Not yours: any statement but the ruled binder; any generated module's text; the generator; the merge
into `main`; a push; anything in another tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs133-wpq`; the merge adds the port's 31 generated modules and
`Outside/OAI158Collapse`, so the first build compiles them (the port's own build of 58 modules took 11 minutes here).
Measured by the port's landing: every whole-library gate step is one `lean` process of up to 5.5 GiB; a whole final pass
was about 35 minutes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ld1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build: `--mem 10 --cpus 4 --
env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may hold 12 GiB of the slot for long
stretches: on exit 75 wait ten minutes and retry, and tell me if a step has waited an hour. A cap kill under a `timeout`
wrapper shows as exit 143, not 137 (read the system log for "oom-kill"). Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: every log your record cites lives under `data/fs133/ld1/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
