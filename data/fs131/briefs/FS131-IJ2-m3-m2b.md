# Brief FS131-IJ2 — the five-colour chain: the invariant measure and Bochner at the twisted parts proved

*Written 2026-10-14 15:00 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IJ2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the chain's implementer — one ruled attribute on the skeleton's `Rigidity.archTop` (so the guarded lint passes), then the map's modules M3 (`InvariantMeasure`: an invariant probability measure on a closed invariant set of the dual, for a countable group) and M2b (`BochnerTau`: Bochner's theorem at the twisted parts, the road from the continuity group to M11), as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the certificate checker, the density bound's covering, the count's plane and extension lanes) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if M2b's hard leaf prices it above 2,000 lines, if a stored statement lacks a class binder its section declares (item 847's defect); the report goes to `data/fs131/reports/FS131-IJ2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IJ2-implementation.md` (new, on branch `fs131-wt4`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wt4`** that you cut from its head (`fs131-wt3` at `1e438c171`; its build is current for that commit): in `Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean` (or wherever `archTop` is declared) **one attribute only**, `@[nolint unusedArguments]` on `archTop` with a one-line comment giving the reason (item 863 ruling 1); **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/InvariantMeasure.lean` and `Proofs/HadwigerNelson/Rigidity/BochnerTau.lean`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/FS131-IJ2-implementation.md`; `data/fs131/ij2/`; `data/fs131/reports/FS131-IJ2.md`. **Not** the count's modules (lanes of their own), `ChainAtTA.lean`, the lane T and M8b modules, `Herglotz.lean` and `ContinuityGroup.lean` beyond the one attribute, any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`, `itt1/`, `itk1/`, `ij1/`): leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The last implementer joined the chain's two lines, proved that the continuity group is exactly T + A over every
real number field, and proved Herglotz–Bochner on every countable abelian group. You take the next two modules of the
map on the same road.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

M2b is the step from the continuity group to M11, the last unplanned module on the chain's critical path; M3 is short
and reads M2a's weights, now proved.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what M2 and M3 are and who reads M2b:

> - 2026-10-14 — **M2 and M3 are typed by averaging** (FS131-KR1): `Rigidity.bochnerHerglotz_of_countable` (M2's existence half; uniqueness is `DualGroup.measure_eq_of_fourier`, item 757) and `Rigidity.invariantMeasureOnClosed_of_countable`, each composed over its leaves; neither route reads `[Rudin1962]` or `[Kakutani1938]`.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **`BochnerOn` is read by M11 only, at `τ′_∅` = `Rigidity.tauPrime F`** (FS131-KR1): M12's count passes from spectrum on `T + A` to continuity by dominated convergence.
> — source: data/fs131/claims-NF2.md § Dated lines

The map planner's hand-back and the last implementer's, as I logged them (their words in quotation marks, the rulings mine):

> 823. **FS131-KR1 handed back: the chain's whole remaining road on one map (2026-10-14 11:03 UTC; "JOB FS131-KR1 — DONE"; 560k by the harness's count — past the line, not to be resumed; branch `fs131-wkr` at `3fabd5e10`, tree `fs131-wch`; record `plans/FS131-KR1-chain-map.md` there, its § Stage 5 the map).** From its hand-back message: six new modules typed (M2a `Rigidity/Herglotz`, M3 `Rigidity/InvariantMeasure`, M10 `Rigidity/ContinuityGroup`, M2b `Rigidity/BochnerTau`, M13 `Rigidity/ClassRatio`, M12's input `Plane/OneAvoidingDensity`), M11, M12 and M15 read and priced; "My seven modules come to about 14,000–28,000 lines. About half of that is M12, the count … 6,000–12,000 lines, 3–6 weeks; it needs its own planner"; M13 "2,500–5,000 lines plus FS-66's certificates at 11 and 19 … the cost of checking them in the kernel is unmeasured"; "Every price is estimated from what Mathlib at the pin covers, not from a proved leaf"; the critical path "M13's uniform-tail lemma → M12, alongside lane T → M8b and M4 → M10 → M2b → M11"; the density bound typed as `Plane.OneAvoidingDensityBound`, "as you ruled", its model proved; two private lemmas of `ChainAtTA` M10 reads. **My receipt:** the seven commits exist; from its compiled tree (scratch `kr1/Ax.lean`): `Plane.OneAvoidingDensityBound` prints as "∀ A, NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) → ∀ x, limsup (fun R => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470" on `EuclideanSpace ℝ (Fin 2)` — read by me against its row 2 table: equal to the page (the page's "independent of the choice of x" makes every centre the same as one); `oneAvoidingDensityBound_model` on the standard three. **Rulings.** (1) *The two private lemmas of `ChainAtTA` (`mem_torsion_mul_arch_iff`, `exists_rat_coords`):* made public by M10's implementer, statements unchanged and dumped (one fact proved once); high. (2) *The draft claim lists' corrections (M2's "existence half", M15's model):* carried by the five dated lines, filed; the generated drafts are left as their generator writes them; high. (3) *The next slot:* M12's planner (FS131-K12, item 824) — the longest single stretch and on the critical path; alternative, the FS-66 certificate measurement for M13 — next, as a short job; medium-high. **Filed:** its five dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit; every bibliography key it cites resolves (`[Rudin1962]`, `[Kakutani1938]`, `[LevitzMott1972]`, `[KMOR2016]`, `[BachocEtAl2014]`, `[Zhang2012]` each have a row); their reading-status lines and its three `LEAN.md` lines are owed to the second filing. **For Kooshi's report:** the chain is weeks from the gate, not days — about 14,000–28,000 lines in its seven unread modules by estimate, M12 alone three to six weeks, and the density bound three to six weeks more if formalized; a fork in scope that is his (what to publish before the chain lands).
> — source: plans/FS131-close-inventory.md

> 863. **FS131-IJ1 handed back at stage 5: the chain's join, the ring-map replacement, M10 and M2a proved; M3 and M2b not reached (logged 2026-10-14 15:00 UTC; "JOB FS131-IJ1 — STAGE 5 SAVED"; 555k by the harness's count — past the line, not to be resumed; branch `fs131-wt3` at `1e438c171`, tree `fs131-wq1`; record `plans/FS131-IJ1-implementation.md` there).** From its hand-back message: the join builds; "The kernel accepts `Counting.toL F = ofUnitRing F` by `rfl` … `toL` is deleted and `toL_mem_localRing` is renamed `ofUnitRing_mem_localRing` … every stored term that changed differs only in that name: PASS, control 9 of 9"; `mem_torsion_mul_arch_iff` and `exists_rat_coords` public, stored types unchanged; "**M10.** `HadwigerNelson.Rigidity.contChars_tauPrime : ∀ (F : Subfield ℝ) [NumberField ↥F], contChars (tauPrime F) = TA F` … All six leaves are proved" (read against J45 N1 (a) at S = ∅: "the characters of ℤ[U_F] continuous for the profinite-plus-archimedean topology are exactly T + A"); "**M2a.** `HadwigerNelson.Rigidity.bochnerHerglotz_of_countable : ∀ (G : Type u_1) [AddCommGroup G] [Countable G], BochnerHerglotz G` … every positive-definite `C` is the Fourier–Stieltjes transform of a finite measure on the dual, unique among finite measures"; M3 "about 250–400 lines", M2b "about 900–1,200" re-priced at "0.4 and 0.45 of plan"; `AdmissiblePair.ofPow` is `fs131-wt1`'s proved text; a generalization (`exists_twisted_parts` true as stated, "an archimedean torsion character of R is trivial, because 1/5 ∈ R", one mind, by hand); shorter routes for M10's hard leaf and M2a's weights; `exists_rat_coords` "now public with no reader"; `lake lint` fails on the skeleton's `Rigidity.archTop`, "whose `[NumberField ↥F]` is unused"; a slip (a background job started in the main tree's directory, its redirection failed before anything ran; `main`'s status checked clean). **My receipts:** the seven commits exist; `ContinuityGroup` and `Herglotz` hold no `sorry`; from the tree's compiled library (scratch `ij1/Ax.lean`): `contChars_tauPrime` and `bochnerHerglotz_of_countable` — each `[propext, Classical.choice, Quot.sound]`. So, on the chain's line: **the continuity group is exactly T + A over every real number field, and Herglotz–Bochner holds on every countable abelian group**, kernel theorems with no assumption. **Rulings, four parts.** (1) *`archTop`'s unused `[NumberField ↥F]`:* `@[nolint unusedArguments]` on that one declaration with its reason, as item 850 ruling 1 did for `multiplier_mem`; alternative, drop the binder — declined, it moves the stored types of `archTop`, `tauPrime` and every statement over them; high. (2) *`exists_rat_coords` public with no reader:* stays public — item 823's ruling made it so for M10, and the landing's unused-declaration pass decides; medium. (3) *The next slot:* M3, M2b and the `archTop` attribute to a fresh implementer in this tree (its build is current; no compile), the M10 → M2b → M11 road; the M11 planner and the count's Λ2 and Λ3 at the next free slots; alternative, the M11 planner first — declined for now, it would need a tree compiled for the chain's line (30–60 minutes) while this one is ready; medium — changed if a chain-built tree frees first. **For lane Λ2 (to its brief):** its leaf is now `Counting.ofUnitRing_mem_localRing`, "two lines" from `ofUnitRing_mem_stableIntegers` and `mem_stableIntegers`. **For lane Λ4 (running, FS131-ICL1):** `TA_subset_contChars` is proved on `fs131-wt3`. **Tool defect (the tooling list):** no chain planner ran `lake lint`, and neither the build nor `lake env lean` runs the environment linters. **Prediction scored:** implementers at 0.4–0.45 of the planner's lines. **Owed to the second filing:** five `LEAN.md` lines and the audit block, drafted in its record.
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (0) **The attribute** on `archTop`, then the guarded lint (`lake lint --no-build -- --no-build
--trace`, under the slot) silent on the chain's files with its planted control red. (1) **M3**, `InvariantMeasure` (2
leaves; the map planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KR1-chain-map.md` § 2.2 and § 4.3). (2) **M2b**, `BochnerTau` (4 leaves; § 2.1): the hard leaf
`exists_twisted_parts` first, to re-price — the last implementer found it true as stated and sketched its route (its
record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IJ1-implementation.md` § 5.5). That record is the worked pattern for this chain's files.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your files dumped from the built tree before any edit, every instance
   and definition read for a class binder its section declares and its stored type lacks.
2. **The attribute and the lint** (a saved stage).
3. **M3, then M2b** (saved stages as leaves fall); re-price M2b from its first two leaves and say so.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree, each listed, with a planted record watched
   showing.
5. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each module; another route for a leaf where the plan's does not
go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wt3`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ij2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree — and
run every command from inside it (the last implementer's slip: a background job started from the main tree). The build:
`--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and
retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ij2/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
