# Brief FS131-KM11 — the five-colour chain: M11 (A⁺ at the empty set), typed to its leaves and priced

*Written 2026-10-14 15:12 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KM11
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the twelfth planner on this chain, and the planner of its last unplanned module but one
  role: the kernel lane's planner for module M11 — the hypothesis `(chainInterface F).APlusOfR88` of the chain's headline: for every invariant colouring and trace spectral measure, the condition R88TCA forces the measure's real part off T + A to be negative — typed to its leaves with a plan per leaf, its one step no record states as a lemma (the cyclic-subspace step) stated and planned, its composition typed, and the whole priced from first leaves written in scratch
  launch: now, in a finished tree on a new branch cut from the chain's joined line; the chain's implementer proves M3 and M2b in another tree on that line, and three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a hypothesis of `APlusOfR88` is unread or a shorter route removes a step, if a classical input none of the chain's lists names is needed, and if M11 prices over a week from its first leaves; the report goes to `data/fs131/reports/FS131-KM11.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KM11-aplus.md` (new, on branch `fs131-wm11`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1` on a **new branch `fs131-wm11`** that you cut from the chain's line at `1e438c171` (`git checkout -b fs131-wm11 1e438c171`; the tree's compiled library is `main`'s at the port's landing, so the first build compiles the chain's modules — budget 15–40 minutes, and read while it runs): new modules under `Proofs/HadwigerNelson/Rigidity/` for M11 with their lines in the build's lists and `ARCHITECTURE.md`; `plans/FS131-KM11-aplus.md`; `data/fs131/km11/`; `data/fs131/reports/FS131-KM11.md`. **Not** any typed statement of another module (`ChainAtTA`'s `chainInterface` and its `APlusOfR88` are read, not changed; M10's `contChars_tauPrime`, M2a's `bochnerHerglotz_of_countable` and M2b's `BochnerTau` are read as stated), the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the statements, after the plan per leaf, and after each priced first leaf

Hello. The chain's map priced every module; one of them, M11, it read and priced but did not type, and it names one
step in it that no record states as a lemma. M10 (the continuity group is T + A) and M2a (Herglotz–Bochner on every
countable group) are now proved on the chain's line, and M2b is being proved. You type M11 so its implementers can start.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

M11 sits at the end of the chain's road `M4 → M10 → M2b → M11`; it is the last module whose statements are not yet
typed, so its plan is on the chain's critical path.

## The statements

What the chain does not claim, and the dated lines of its claim list (`data/fs131/claims-NF2.md`) that bear on M11:

> NF2-NC: any size or price of a leaf (the map says none of leaves 8–23 is sized); that the leaf list is complete (the deriver's table names two results read on the path that are not numbered leaves: the density of the ring in its completion, and the ring equalling its maximal order away from the exception fields); that the printed rigidity theorem is formalized (it is declared, with its four items); that any leaf is new mathematics.
> — source: data/fs131/claims-NF2.md § Not claimed

> - 2026-10-14 — **`BochnerOn` is read by M11 only, at `τ′_∅` = `Rigidity.tauPrime F`** (FS131-KR1): M12's count passes from spectrum on `T + A` to continuity by dominated convergence.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The count reads one constant** (FS131-KR1; the coordinator's ruling): `Interface.Count`'s proof reads `TCA F` together with Weil's bound at the tail, through `Rigidity.tca_uniform` (module M13); no typed statement changes.
> — source: data/fs131/claims-NF2.md § Dated lines

The map planner's hand-back and the last chain implementer's, as I logged them (their words in quotation marks, the
rulings mine):

> 823. **FS131-KR1 handed back: the chain's whole remaining road on one map (2026-10-14 11:03 UTC; "JOB FS131-KR1 — DONE"; 560k by the harness's count — past the line, not to be resumed; branch `fs131-wkr` at `3fabd5e10`, tree `fs131-wch`; record `plans/FS131-KR1-chain-map.md` there, its § Stage 5 the map).** From its hand-back message: six new modules typed (M2a `Rigidity/Herglotz`, M3 `Rigidity/InvariantMeasure`, M10 `Rigidity/ContinuityGroup`, M2b `Rigidity/BochnerTau`, M13 `Rigidity/ClassRatio`, M12's input `Plane/OneAvoidingDensity`), M11, M12 and M15 read and priced; "My seven modules come to about 14,000–28,000 lines. About half of that is M12, the count … 6,000–12,000 lines, 3–6 weeks; it needs its own planner"; M13 "2,500–5,000 lines plus FS-66's certificates at 11 and 19 … the cost of checking them in the kernel is unmeasured"; "Every price is estimated from what Mathlib at the pin covers, not from a proved leaf"; the critical path "M13's uniform-tail lemma → M12, alongside lane T → M8b and M4 → M10 → M2b → M11"; the density bound typed as `Plane.OneAvoidingDensityBound`, "as you ruled", its model proved; two private lemmas of `ChainAtTA` M10 reads. **My receipt:** the seven commits exist; from its compiled tree (scratch `kr1/Ax.lean`): `Plane.OneAvoidingDensityBound` prints as "∀ A, NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) → ∀ x, limsup (fun R => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470" on `EuclideanSpace ℝ (Fin 2)` — read by me against its row 2 table: equal to the page (the page's "independent of the choice of x" makes every centre the same as one); `oneAvoidingDensityBound_model` on the standard three. **Rulings.** (1) *The two private lemmas of `ChainAtTA` (`mem_torsion_mul_arch_iff`, `exists_rat_coords`):* made public by M10's implementer, statements unchanged and dumped (one fact proved once); high. (2) *The draft claim lists' corrections (M2's "existence half", M15's model):* carried by the five dated lines, filed; the generated drafts are left as their generator writes them; high. (3) *The next slot:* M12's planner (FS131-K12, item 824) — the longest single stretch and on the critical path; alternative, the FS-66 certificate measurement for M13 — next, as a short job; medium-high. **Filed:** its five dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit; every bibliography key it cites resolves (`[Rudin1962]`, `[Kakutani1938]`, `[LevitzMott1972]`, `[KMOR2016]`, `[BachocEtAl2014]`, `[Zhang2012]` each have a row); their reading-status lines and its three `LEAN.md` lines are owed to the second filing. **For Kooshi's report:** the chain is weeks from the gate, not days — about 14,000–28,000 lines in its seven unread modules by estimate, M12 alone three to six weeks, and the density bound three to six weeks more if formalized; a fork in scope that is his (what to publish before the chain lands).
> — source: plans/FS131-close-inventory.md

> 863. **FS131-IJ1 handed back at stage 5: the chain's join, the ring-map replacement, M10 and M2a proved; M3 and M2b not reached (logged 2026-10-14 15:00 UTC; "JOB FS131-IJ1 — STAGE 5 SAVED"; 555k by the harness's count — past the line, not to be resumed; branch `fs131-wt3` at `1e438c171`, tree `fs131-wq1`; record `plans/FS131-IJ1-implementation.md` there).** From its hand-back message: the join builds; "The kernel accepts `Counting.toL F = ofUnitRing F` by `rfl` … `toL` is deleted and `toL_mem_localRing` is renamed `ofUnitRing_mem_localRing` … every stored term that changed differs only in that name: PASS, control 9 of 9"; `mem_torsion_mul_arch_iff` and `exists_rat_coords` public, stored types unchanged; "**M10.** `HadwigerNelson.Rigidity.contChars_tauPrime : ∀ (F : Subfield ℝ) [NumberField ↥F], contChars (tauPrime F) = TA F` … All six leaves are proved" (read against J45 N1 (a) at S = ∅: "the characters of ℤ[U_F] continuous for the profinite-plus-archimedean topology are exactly T + A"); "**M2a.** `HadwigerNelson.Rigidity.bochnerHerglotz_of_countable : ∀ (G : Type u_1) [AddCommGroup G] [Countable G], BochnerHerglotz G` … every positive-definite `C` is the Fourier–Stieltjes transform of a finite measure on the dual, unique among finite measures"; M3 "about 250–400 lines", M2b "about 900–1,200" re-priced at "0.4 and 0.45 of plan"; `AdmissiblePair.ofPow` is `fs131-wt1`'s proved text; a generalization (`exists_twisted_parts` true as stated, "an archimedean torsion character of R is trivial, because 1/5 ∈ R", one mind, by hand); shorter routes for M10's hard leaf and M2a's weights; `exists_rat_coords` "now public with no reader"; `lake lint` fails on the skeleton's `Rigidity.archTop`, "whose `[NumberField ↥F]` is unused"; a slip (a background job started in the main tree's directory, its redirection failed before anything ran; `main`'s status checked clean). **My receipts:** the seven commits exist; `ContinuityGroup` and `Herglotz` hold no `sorry`; from the tree's compiled library (scratch `ij1/Ax.lean`): `contChars_tauPrime` and `bochnerHerglotz_of_countable` — each `[propext, Classical.choice, Quot.sound]`. So, on the chain's line: **the continuity group is exactly T + A over every real number field, and Herglotz–Bochner holds on every countable abelian group**, kernel theorems with no assumption. **Rulings, four parts.** (1) *`archTop`'s unused `[NumberField ↥F]`:* `@[nolint unusedArguments]` on that one declaration with its reason, as item 850 ruling 1 did for `multiplier_mem`; alternative, drop the binder — declined, it moves the stored types of `archTop`, `tauPrime` and every statement over them; high. (2) *`exists_rat_coords` public with no reader:* stays public — item 823's ruling made it so for M10, and the landing's unused-declaration pass decides; medium. (3) *The next slot:* M3, M2b and the `archTop` attribute to a fresh implementer in this tree (its build is current; no compile), the M10 → M2b → M11 road; the M11 planner and the count's Λ2 and Λ3 at the next free slots; alternative, the M11 planner first — declined for now, it would need a tree compiled for the chain's line (30–60 minutes) while this one is ready; medium — changed if a chain-built tree frees first. **For lane Λ2 (to its brief):** its leaf is now `Counting.ofUnitRing_mem_localRing`, "two lines" from `ofUnitRing_mem_stableIntegers` and `mem_stableIntegers`. **For lane Λ4 (running, FS131-ICL1):** `TA_subset_contChars` is proved on `fs131-wt3`. **Tool defect (the tooling list):** no chain planner ran `lake lint`, and neither the build nor `lake env lean` runs the environment linters. **Prediction scored:** implementers at 0.4–0.45 of the planner's lines. **Owed to the second filing:** five `LEAN.md` lines and the audit block, drafted in its record.
> — source: plans/FS131-close-inventory.md

**Where everything is** (on the chain's line: the same paths in your branch once it is cut; until then in the chain
implementer's tree, read only): the map planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KR1-chain-map.md` § 2.4 — M11 read: its route
(J45 SI-1, SI-3, SI-4, A⁺ with remark (ii)), steps (a)–(g), "(d) … **the step no record states as a lemma**", its price
"1,500–2,500 lines", and what it needs (M10, M2b, M4); `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean` (the headline
and `chainInterface`, whose field `APlusOfR88` you prove); `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean`,
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/Herglotz.lean`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/BochnerTau.lean`,
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/InvariantMeasure.lean`; the derivation entries J45 (`plans/FS84-SI-D-derivation.md`)
and the records the map planner cites. `LEAN.md` § The kernel's cost model.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch cut and built;
   `(chainInterface F).APlusOfR88` printed from the kernel and restated; the map planner's steps (a)–(g) restated with
   what each reads and produces, and which kernel theorems already hold each.
2. **The statements typed** (a saved stage): with `sorry` at the leaves only, each read aloud against its derivation
   entry, each with a model; **step (d), the cyclic-subspace step, stated as a lemma** of its own with its hypotheses
   named; the composition proving `APlusOfR88` from the parts. **The domain pass as a fresh skill invocation on every
   new definition, and the obligation pass on every new statement** — and every instance and definition's stored type
   read for a class binder its section declares (item 847's defect).
3. **Priced from first leaves** (written in scratch, elaborated, measured), at least step (d)'s hard leaf; every
   classical input named, searched for by name at the pin, formalize-or-declare stated, **no axiom declared**.
4. **Lanes**, sharing no file, with what each waits on and its measured price.
5. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
6. The report in the standing rules' form.

## What is yours to decide

How M11 is cut into modules; which derivation route each step takes; the order after item 1; how far into item 3 you
reach. Not yours: a declared axiom; a change to a typed statement of another module without my ruling; proving leaves
beyond the first leaves a price needs; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name km11 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree, and run every command from inside it. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. A cap kill
under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/km11/`. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
