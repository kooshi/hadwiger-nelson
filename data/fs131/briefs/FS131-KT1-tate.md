# Brief FS131-KT1 — the five-colour chain: the interface to the adelic model typed, then Tate's self-duality planned to its leaves

*Written 2026-10-14 07:43 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KT1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the seventh planner on this chain
  role: the kernel lane's planner for the zero-entropy side's model — first type the structure that holds exactly the facts the zero-entropy side reads of the dual of the ring as adeles modulo the diagonal, so that two lanes can run beside each other; then plan lane T, the construction of that structure (Tate's self-duality of the adeles in the form the model reads), to its leaves, choosing between two forms of the local character by measurement, and price it
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's implementer works in `fs131-wq1` on the pieces, the port's implementer in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a classical input none of the chain's lists names is needed, and if your price for lane T comes out over a week of agent work (before you plan a fallback); the report goes to `data/fs131/reports/FS131-KT1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KT1-tate.md` (new, on branch `fs131-wkt`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch` on a **new branch `fs131-wkt`** that you cut from its head (`fs131-wk9` at `aee998a46`; its build is current for that commit): new modules under `Proofs/HadwigerNelson/Rigidity/` (or a better place you name) with their lines in the build's lists and `ARCHITECTURE.md`; the draft claim list `data/fs131/kn3/claims-M8-zero-entropy-carried.md` where your plan changes it (old text kept in git); `plans/FS131-KT1-tate.md`; `data/fs131/kt1/`; `data/fs131/reports/FS131-KT1.md`. **Not** any typed statement of another module, the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the interface, after the measurement of the two forms, and after each few leaves' plans

Hello. The zero-entropy side of the chain reads a model of the dual of its ring: adeles modulo the diagonal, through a
standard character. Mathlib has the adele rings as topological rings and nothing of their duality. The last planner
decided the model on a weaker reading of the ring than the derivation used, priced Tate's duality at several days, and
recommended an interface so that the model's construction and the zero-entropy side's use of it can be built at the
same time. I approved the interface. You type it, then plan its construction.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The construction of the adelic model is now the longest single stretch on the chain's road; a typed interface lets the
zero-entropy side's planner and implementers start without waiting for it.

## The statements

The leaf of the chain's claim list (`data/fs131/claims-NF2.md`) the model serves, and the two dated lines that say
what it now reads:

> NF2-LEAF-21: EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
> — source: data/fs131/claims-NF2.md

> - 2026-10-14 — **Tate's self-duality reads D2 for its surjectivity (FS131-KPD1, in words).** `π(W) ⊆ R̂` has zero annihilator, and is closed once `W/Λ` is compact, so `π` is onto by `Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot`, and open for free; its kernel `Λ = R^∨` and the cocompactness are the adelic part M8b must price.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **EF_F⁺ on a weaker reading of the ring (FS131-KN9; a reading, one mind; the kernel is its test).** X01D's model, Lemma PF, the pigeonhole and Step 6's finite orbits read `R` only through `R ⊆ O′` (FS91-J10-L1 (c)) and `c·O′ ⊆ R` for an integer `c ≥ 1` (FS91-J10-L1 (e)), both over every real number field. If M8b's proof is written so (the coordinator's ruling: it is planned so), EF_F⁺ and MR⁺ hold over every real number field, NF2-MRPLUS-SCOPE (a)'s GAP at row 100's exception fields closes, and `R = O′` (Lemma C′) leaves the headline's path unless module M12 reads it; the class `L ≥ 5` is inside the scope either way.
> — source: data/fs131/claims-NF2.md § Dated lines

The two hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine; ruling 1 of the
first is the interface, ruling 2 is lane T):

> 791. **FS131-KN9 handed back: M5 and M9 typed and planned, M8b decided in words (2026-10-14 12:45 UTC logged; "JOB FS131-KN9 — DONE"; 531k by the harness's count — past the line, not to be resumed; branch `fs131-wk9` at `aee998a46`, tree `fs131-wch`; record `plans/FS131-KN9-chain-zero-entropy.md` there).** From its hand-back message: "**M5 is typed and planned** … A new module, `Rigidity/EntropyFibres` (9 leaves) … `Rigidity/PositiveEntropy` (10 leaves, `haar_or_zero_entropy` last)"; "**`haar_or_zero_entropy` no longer takes `[PolishSpace X]`** … The kernel's dump shows exactly that binder removed and nothing else changed … The statement is again FS131-KN7's, character for character"; "**M9 is typed in a new module, `Rigidity/RingScope`** … R ⊆ O′, proved; c·O′ ⊆ R, over every real number field; R = O′ in the scope: typed, off M8b's path, planned in words only"; "**M8b is decided in words, not typed** … I recommend packaging it as a structure `TateModel F`: the five facts M8b reads"; "Tate's duality: Mathlib at the pin has none of it … I recommend formalizing it as lane T, with a planner first. My price, from Mathlib's state and not from an elaborated leaf: several days, two to four thousand lines"; "Strong approximation and Lusin–Souslin: not needed on the routes chosen"; builds 1–4 exit 0, lint passed; an architecture cell failure inherited from the join (fixed on `fs131-wdg` by FS131-IDG1). **My receipt:** the six commits exist; from its compiled tree under the memory tool (scratch `kn9/Ax.lean`): `haar_or_zero_entropy`'s binders read `[AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]`, no `PolishSpace`; `unitRing_le_stableIntegers` on the standard three. **Rulings, four parts each.** (1) *The `TateModel F` interface:* approved — a structure whose fields are exactly the five facts of its record § 4.1 that M8b reads, each stated as X01D states it, quantifying over nothing of ours beyond what X01D reads; its existence is lane T's leaf; M8b's records print `sorryAx` through it until lane T lands; it is typed first by the next planner (FS131-KT1, item 792) so that lane T and M8b's parts 2–4 can run beside each other; alternative, M8b typed straight over a construction — declined, it serializes the longest stretch of the chain; high. (2) *Lane T, Tate's duality:* **formalize**, a planner first (the same job, after the interface), measuring both forms of the local character on its first two leaves and pricing from them; no axiom declared; if priced over a week, a message to me first; alternative, declare it now from `[Tate1950]` — declined (W2; "when unsure, formalize"); high. (3) *`noRamifiedStableDyadic_of_tca` (lane M9-S):* proved in place in `Rigidity/ChainAtTA` by an implementer, a proof only, off the headline's path; medium-high. (4) *M12's question (does T-C(A) read `R = O′`, or only Lemma C (d)):* carried to M12's planner. (5) *The `Pieces` docstring line:* sent to FS131-IG1 as its Amendment 1. **Filed this commit:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim; two `BIBLIOGRAPHY.md` rows, `[Tate1950]` and `[Weil1967]`, from its drafts (not held, not read; `tools/bib_audit.py` passes). **Owed to the second filing:** its four `LEAN.md` lines. **The chain's ready implementer lanes now:** M5-E, M5-P, M9-R, M9-S, P2, P3 (and S after G, P2, E).
> — source: plans/FS131-close-inventory.md

> 775. **FS131-KPD1 handed back: Pontryagin duality typed, its route measured (2026-10-14 09:35 UTC logged; "JOB FS131-KPD1 — DONE"; 427k by the harness's count — not to be resumed; branch `fs131-wpd` at `c138bbafd`, tree `fs131-wq1`; record `plans/FS131-KPD1-pontryagin.md` there).** From its hand-back message: four new modules (`Rigidity/Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`) with `sorry` at the leaves only — "D2 general (`dualAnnihilator_dualCoannihilator_of_isClosed`), its closure form, the case … D1 (`evalDualHom_surjective`, `dualDualEquiv`, `additiveDualDualEquiv`)", D3 (`connectedSpace_dual`); "Pieces is re-pointed … 74 of 74 identical before and after, and the control fires"; "route H: Haar measure on closed subgroups, with Fourier uniqueness from `Rigidity/DualGroup`. It needs no Peter–Weyl, no L² and no tori"; "26 of 28 leaves, about 165 lines, elaborate at the pin … Grade: elaborated, not landed"; "Lane PD-I is about two to three hours of implementer work … no fallback axiom is drafted and none is needed"; build exit 0, lint 14 passed, architecture PASS; a slip of mine: "In inventory item 761, the nested quotations 'Its words: …' match neither the KN8 report on disk nor the record verbatim … They are presumably quoted from the hand-back text, which is not on disk"; a library request: "A copy of it [`Rudin1962`], or of Deitmar–Echterhoff Ch. 3". **My receipt:** the seven commits exist on `fs131-wpd`; from its compiled tree under the memory tool (scratch `kpd1/Ax.lean`): `dualAnnihilator_dualCoannihilator_of_isClosed : ∀ {G} [AddCommGroup G] [Countable G] (Y : Subgroup (AddChar G Circle)), IsClosed ↑Y → dualAnnihilator (dualCoannihilator Y) = Y`; `connectedSpace_dual : ∀ {G} [AddCommGroup G] [IsAddTorsionFree G], ConnectedSpace (AddChar G Circle)`; `evalDualHom_surjective : ∀ {G} [AddCommGroup G] [Countable G], Function.Surjective ⇑(evalDualHom G)` — the general theorems, as reported. `git merge-tree` of `fs131-wpd` with `fs131-wl1` (the chain's proved lanes): clean. **Rulings, four parts each.** (1) *Who folds the route copies:* lane PD-I's implementer, not the planner — a planner proves no more than a few lines; alternative, the planner — declined by its lane's rule; high. (2) *The next chain job:* one implementer (FS131-IDG1, item 776) on a branch from `fs131-wpd` that first merges `fs131-wl1`, taking lane D (`Rigidity/DualGroup`, on every duality headline's path), then PD-I, then U (`Rigidity/UnitCircle`, all but lane A's leaf), and the architecture cell and stale docstrings owed by item 770 ruling 1; alternative, PD-I alone first — declined, its headlines reach `sorry` only through lane D; high. (3) *My slip:* my inventory items quote hand-backs from the message the harness delivers, which is not on disk and may differ from the report file in small ways; from here on I say "from its hand-back message" when I quote one; no workflow change beyond that; high. (4) *The library request:* not urgent — the statements are standard and their proofs are being formalized here, so the textbook bears on attribution only; it goes to Kooshi as a know-not-decide line in the next report; medium. **Filed:** its three dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its four `LEAN.md` lines and the `[Rudin1962]` reading-status line (record § 5.3). **For M8b's planner:** Tate's surjectivity from D2's case (its third dated line).
> — source: plans/FS131-close-inventory.md

Where everything is: the last planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KN9-chain-zero-entropy.md` § Stage 4 (§ 4.1: the model built for `O′` and read for `R`,
its table of the five facts M8b reads and how each is obtained; § 4.3: the classical inputs, searched at the pin; §
4.4: what M8b's planner inherits), the duality planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KPD1-pontryagin.md` § 5.2 (the surjectivity from the duality theorem's
case), the split planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN8-chain-split.md` § Stage 4 (the model's vocabulary first decided), the ring's module
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Rigidity/RingScope.lean` (`stableIntegers`, `R ⊆ O′` proved, `c·O′ ⊆ R` typed), and the
derivation `plans/FS100-X01D-derivation.md` § 2.0 (the model).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the five facts restated from § 4.1's
   table, each with where M8b reads it.
2. **The interface** (a saved stage): `TateModel F` typed as ruling 1 of the first item says — its fields exactly the
   five facts, each read aloud against X01D's statement of it, quantifying over nothing of ours beyond what X01D reads;
   the existence `exists_tateModel` (or your name) a leaf; a model of the structure's hypotheses where one is possible
   without the construction (say if none is); compiled with `sorry` at the leaves only.
3. **The two forms of the local character, measured** (a saved stage): both definitions of `ψ_w` the last planner names
   (or the two you find), each carried through its first two leaves in scratch, and the cheaper chosen by what the
   leaves cost, not by a table.
4. **Lane T planned** (saved stages): the construction typed to its leaves — `W`, `ψ`, `π`, the five facts as theorems
   — with `sorry` at the leaves only, each read aloud, each with a model, a plan per leaf naming Mathlib's
   declarations at the pin.
5. **The price** in agent-days, from items 3–4; if over a week, a message to me first. No axiom declared.
6. **Lanes**, sharing no file; **the domain pass as a fresh skill invocation on every new definition, and the
   obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; the form of `ψ_w`; the order after item 2. Not yours: a declared axiom; a change
to a typed statement of another module without my ruling; proving leaves beyond a few lines while measuring; M8b's
parts 2–4 (another planner's, over your interface); the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kt1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's build of the whole library
may hold the slot for up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/kt1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
