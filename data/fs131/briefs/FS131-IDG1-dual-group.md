# Brief FS131-IDG1 — the five-colour chain: the dual group, Pontryagin duality and the unit circle, proved

*Written 2026-10-14 06:22 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IDG1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the chain's third implementer — three lanes its last two planners left ready, on one branch that first joins the chain's proved lanes into the duality planner's branch: the dual of a countable group as a compact Polish group with Fourier uniqueness and Haar measure; Pontryagin duality over it; the unit vectors as a group acting by rotation
  launch: now, in the duality planner's tree (its job is finished; nobody else writes there) on a new branch; the port's implementer works in `fs132-wi1` and the density equality's in `fs133-wk1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the join does not go through as described, and with one line when lane D's leaves are proved; the report goes to `data/fs131/reports/FS131-IDG1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IDG1-implementation.md` (new, on branch `fs131-wdg`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wdg`** that you cut from its head (`fs131-wpd` at `c138bbafd`; its build is current for that commit) and into which you merge `fs131-wl1` (at `7a369b624`) with `--no-ff` as your first commit (`git merge-tree` reports it clean); then, **proofs, private helpers and import lines only — no statement changes, no definition changes**: `Proofs/HadwigerNelson/Rigidity/DualGroup.lean`, `Proofs/HadwigerNelson/Rigidity/Annihilator.lean`, `Proofs/HadwigerNelson/Rigidity/SubgroupHaar.lean`, `Proofs/HadwigerNelson/Rigidity/Duality.lean`, `Proofs/HadwigerNelson/Rigidity/DualConnected.lean`, and `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean` except its leaf `exists_admissiblePair`; and, from the chain's last implementer's drafts (its record § Drafts for the landing), the `ARCHITECTURE.md` imports cell of `Rigidity/ZeroEntropyNames` and the rows of its three modules, and the stale module docstrings it names (prose only); your checks under `tools/` named for this job; `plans/FS131-IDG1-implementation.md`; `data/fs131/idg1/`; `data/fs131/reports/FS131-IDG1.md`. **Not** `exists_admissiblePair`, `Rigidity/Pieces.lean`, `Rigidity/EntropySplitMax.lean`, `Rigidity/ChainAtTA.lean`, the entropy file's tenth leaf, any module under `Outside/`, the declared printed theorem. An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This chain is the first-ranked thing this project has to show. Its last implementer proved three lanes and with
them the theorem that assembles the headline from its eight hypotheses; its last planner found that the Pontryagin
duality the chain reads costs hours, not the week it was feared to, because it rests on one module of the chain's own
that is not proved yet: the dual group's. You prove that module, the duality over it, and the unit-circle module beside
them.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Every duality headline of the chain reaches an unproved step only through the dual group's leaves, Fourier uniqueness
above all; with them proved, the pieces' module and the positive-entropy split can be built on solid ground.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the duality lane now is:

> - 2026-10-14 — **Pontryagin duality for a countable discrete group needs no Peter–Weyl, and the general D2 costs what the case costs (FS131-KPD1).** On `Ĝ = AddChar G Circle` with the pointwise topology, Fourier uniqueness (`Rigidity.measure_eq_of_fourier`, Stone–Weierstrass over the evaluations) and the Haar measure of a closed subgroup (`Rigidity.subgroupHaar`) give D2 for every closed subgroup (`Rigidity.dualAnnihilator_dualCoannihilator_of_isClosed`: `Z := (Y^⊥)^⊥` has `Z^⊥ = Y^⊥` for free, and the Haar measures of `Y` and `Z` have one Fourier transform), and D1 follows from D2 at `G × ℤ` (`Rigidity.evalDualHom_surjective`). Typed in `Rigidity/Annihilator`, `Rigidity/SubgroupHaar`, `Rigidity/Duality`; 26 of the lane's 28 leaves elaborate in copies (`data/fs131/kpd1/route/`), the headlines resting on `Rigidity/DualGroup`'s leaves only. The torus route of inventory item 761 contains it: Mathlib has no D2 for tori.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **PE-1′'s connectedness is a third duality fact, D3 (FS131-KPD1).** `IsSolenoid`'s `connectedSpace` at `PieceDual M` reads that a torsion-free discrete group has a connected dual (`Rigidity.connectedSpace_dual`: the dual is divisible, and a clopen neighbourhood of `1` in a compact group contains an open subgroup of finite index), not D1 and the structure theory of compact groups that KN8's plan read. The total irreducibility's branch `N ≠ 0` reads no duality: `Y ⊆ N^⊥`, finite when `M ⧸ N` is (`Rigidity.finite_dualAnnihilator`). Leaves 8 and 9 of `Rigidity/Pieces` now wait on PD's statements only.
> — source: data/fs131/claims-NF2.md § Dated lines

The two hand-backs as I logged them (their words in quotation marks, the rulings mine):

> 770. **FS131-IN1L handed back: the chain's lanes H, C and N proved (2026-10-14 08:30 UTC logged; "JOB FS131-IN1L (brief FS131-IN1-three-lanes) — DONE"; 531k by the harness's count — past the line, not to be resumed; branch `fs131-wl1` at `7a369b624`, tree `fs131-wch`; record `plans/FS131-IN1L-implementation.md` there).** Its words: "All three lanes are proved: 21 kernel theorems, each on `[propext, Classical.choice, Quot.sound]`"; lane H, seven leaves; lane C, three leaves and the two ruled in (item 755); lane N, nine leaves; "**Consequence — TRUE [kernel]:** these four now rest on the standard three … `min_localBound_five_le_chromaticNumber_of_closed`, the headline with closed hypotheses; `chainInterface`, `five_le_chromaticNumber_of_mrPlus`, `entropySplit_of_every`"; "all 61 named constants match the dump taken before any edit, and the only additions are the two you ruled in. The planted control fired 6 of 6"; build 4 green, its files warning-free; "`tools/check_architecture.py` fails on one cell" (the imports cell of `Rigidity/ZeroEntropyNames`, outside its touches); five unread hypotheses kept and referenced by `have _ :=`; a generated public constant `badStarts.congr_simp` caught by its statement check and removed. **My receipt:** from the tree's compiled library under the memory tool (scratch `in1l/Ax.lean`): `min_localBound_five_le_chromaticNumber_of_closed`, `exists_forall_exp_le_measureReal_nameCell`, `map_sub_maxMultiple`, `zeroEntropyCarried_model` — each `[propext, Classical.choice, Quot.sound]`. As reported. What that headline is: the composition from its eight named hypotheses, now complete; the hypotheses themselves are still leaves of the chain (the entropy split, the zero-entropy side, the count, and the rest). **Rulings.** (1) *The architecture cell and the stale docstrings:* filed by the next chain job that works on this line's branch, from its drafts (record § Drafts), not by me; alternative, a one-cell job now — declined, nothing reads the branch before then; high. (2) *The five unread hypotheses:* each is a binder of a statement typed by a planner from the deriver's entry; by the standing rule an unread binder of a statement of ours is dropped — owed to the chain's next planner, with a dump, not to an implementer; alternative, keep them — declined by that rule; medium-high. (3) *The tree's compiled library:* kept; `fs131-wch` is the chain's implementer tree, current for `fs131-wl1`. (4) *Re-price:* lanes H and C about 55 minutes, lane N about 2 hours — the chain's implementer lanes run at hours, as the planners priced them. **For Kooshi's report (settled):** the chain's headline, read with its eight hypotheses, now rests on the standard three; what remains is to prove the hypotheses.
> — source: plans/FS131-close-inventory.md

> 775. **FS131-KPD1 handed back: Pontryagin duality typed, its route measured (2026-10-14 09:35 UTC logged; "JOB FS131-KPD1 — DONE"; 427k by the harness's count — not to be resumed; branch `fs131-wpd` at `c138bbafd`, tree `fs131-wq1`; record `plans/FS131-KPD1-pontryagin.md` there).** From its hand-back message: four new modules (`Rigidity/Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`) with `sorry` at the leaves only — "D2 general (`dualAnnihilator_dualCoannihilator_of_isClosed`), its closure form, the case … D1 (`evalDualHom_surjective`, `dualDualEquiv`, `additiveDualDualEquiv`)", D3 (`connectedSpace_dual`); "Pieces is re-pointed … 74 of 74 identical before and after, and the control fires"; "route H: Haar measure on closed subgroups, with Fourier uniqueness from `Rigidity/DualGroup`. It needs no Peter–Weyl, no L² and no tori"; "26 of 28 leaves, about 165 lines, elaborate at the pin … Grade: elaborated, not landed"; "Lane PD-I is about two to three hours of implementer work … no fallback axiom is drafted and none is needed"; build exit 0, lint 14 passed, architecture PASS; a slip of mine: "In inventory item 761, the nested quotations 'Its words: …' match neither the KN8 report on disk nor the record verbatim … They are presumably quoted from the hand-back text, which is not on disk"; a library request: "A copy of it [`Rudin1962`], or of Deitmar–Echterhoff Ch. 3". **My receipt:** the seven commits exist on `fs131-wpd`; from its compiled tree under the memory tool (scratch `kpd1/Ax.lean`): `dualAnnihilator_dualCoannihilator_of_isClosed : ∀ {G} [AddCommGroup G] [Countable G] (Y : Subgroup (AddChar G Circle)), IsClosed ↑Y → dualAnnihilator (dualCoannihilator Y) = Y`; `connectedSpace_dual : ∀ {G} [AddCommGroup G] [IsAddTorsionFree G], ConnectedSpace (AddChar G Circle)`; `evalDualHom_surjective : ∀ {G} [AddCommGroup G] [Countable G], Function.Surjective ⇑(evalDualHom G)` — the general theorems, as reported. `git merge-tree` of `fs131-wpd` with `fs131-wl1` (the chain's proved lanes): clean. **Rulings, four parts each.** (1) *Who folds the route copies:* lane PD-I's implementer, not the planner — a planner proves no more than a few lines; alternative, the planner — declined by its lane's rule; high. (2) *The next chain job:* one implementer (FS131-IDG1, item 776) on a branch from `fs131-wpd` that first merges `fs131-wl1`, taking lane D (`Rigidity/DualGroup`, on every duality headline's path), then PD-I, then U (`Rigidity/UnitCircle`, all but lane A's leaf), and the architecture cell and stale docstrings owed by item 770 ruling 1; alternative, PD-I alone first — declined, its headlines reach `sorry` only through lane D; high. (3) *My slip:* my inventory items quote hand-backs from the message the harness delivers, which is not on disk and may differ from the report file in small ways; from here on I say "from its hand-back message" when I quote one; no workflow change beyond that; high. (4) *The library request:* not urgent — the statements are standard and their proofs are being formalized here, so the textbook bears on attribution only; it goes to Kooshi as a know-not-decide line in the next report; medium. **Filed:** its three dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its four `LEAN.md` lines and the `[Rudin1962]` reading-status line (record § 5.3). **For M8b's planner:** Tate's surjectivity from D2's case (its third dated line).
> — source: plans/FS131-close-inventory.md

**Your leaves**: lane **D**, the thirteen leaves of `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/DualGroup.lean` (the plan per leaf: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN8-chain-split.md` § 2.5, with item 757
on Fourier uniqueness by Mathlib's `ext_of_forall_mem_subalgebra_integral_eq_of_polish` and Haar by `haarMeasure ⊤`);
lane **PD-I**, the four duality modules, whose proofs are written and measured in the planner's copies `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/kpd1/route/` (26 of 28
leaves elaborate there) — fold them in, prove the two spec leaves the planner left (its record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KPD1-pontryagin.md` § 4.1), build, and
compare the stored terms; lane **U**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/UnitCircle.lean`'s leaves other than `exists_admissiblePair` (the plan:
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN8-chain-split.md` § 2.5). The order: D first (PD-I's headlines rest on it), then PD-I, then U. The last implementer's record
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-IN1L-implementation.md` is the worked pattern for this chain's files (its join, dumps and axiom checks) and holds the drafts for the
architecture cell and the docstrings.

## Done means

1. **The join and the readback** (a saved stage): the merge commit; one build under the slot of the joined tree; the
   quoted lines checked against their sources; each leaf's statement restated in one line beside its plan; the stored
   statements of your six files dumped from the built tree before any edit.
2. **Lane D** (saved stages as leaves fall, and the one line to me when they are all proved); re-price what is left
   from the first two leaves and say so.
3. **Lane PD-I** (a saved stage): the route copies folded in, the two spec leaves proved, the stored terms compared
   with the planner's dump (no statement moved).
4. **Lane U** (a saved stage).
5. **The architecture cell and the docstrings** from the last implementer's drafts; `tools/check_architecture.py` passes.
6. **No statement and no definition changed**, shown from the kernel's side against the dump of item 1 (a planted
   change watched firing); no `sorry` left in your files but `exists_admissiblePair`; one build under the slot with no
   warning from them but that leaf's; the axioms of every public declaration of your files printed from the built tree —
   the standard three and nothing else, with a planted record watched showing.
7. **Drafts for the landing**, in your record: the audit's block for your files; the model for each hypothesis that
   lacks one; any `LEAN.md` lines.
8. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports a proof needs; another route for a leaf where the plan's does not go through (tell
me which). An unread binder of a statement in your files is dropped without asking, listed in your statement check as a
ruled difference and named in your report (the standing word of item 726). Not yours: any other change to a statement or
definition; the leaves listed as not yours; the declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wpd`; the join adds the entropy branch's three ported
modules and its proved files, so the first build compiles them (expect 10–20 minutes). One file through `lake env
lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idg1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`. On
exit 75 wait ten minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/idg1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
