# Brief FS131-IG1 — the five-colour chain: the pieces, PE-1′ and Lemma Γ, proved

*Written 2026-10-14 07:36 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IG1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the chain's fourth implementer — lane G: the fifteen leaves of the pieces' module (the dual of a finitely generated piece of the ring as a solenoid, the rotation action on it totally irreducible, the chain of pieces, and Lemma Γ), over the dual group and Pontryagin duality the last implementer proved
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's planner works in `fs131-wch` (it may type statements in `Rigidity/PositiveEntropy.lean`, among them a binder dropped from `haar_or_zero_entropy`; I join the two); the port's implementer works in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf reads a statement of another module that is not yet typed or reads it in a form it does not have, and with one line when half the leaves are proved; the report goes to `data/fs131/reports/FS131-IG1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IG1-implementation.md` (new, on branch `fs131-wpg`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wpg`** that you cut from its head (`fs131-wdg` at `68c47bb40`; its build is current for that commit): `Proofs/HadwigerNelson/Rigidity/Pieces.lean` — **proofs, private helpers and import lines only, no statement changes, no definition changes**; and, from the last implementer's drafts (its record § Drafts for the landing: the `ARCHITECTURE.md` rows of its six modules, and the stale module and theorem docstrings it lists), those rows and those docstrings (prose only); your checks under `tools/` named for this job; `plans/FS131-IG1-implementation.md`; `data/fs131/ig1/`; `data/fs131/reports/FS131-IG1.md`. **Not** `Rigidity/PositiveEntropy.lean`, `Rigidity/EntropySplitMax.lean`, `Rigidity/ChainAtTA.lean`, `Rigidity/Entropy.lean`, `exists_admissiblePair`, any module under `Outside/`. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, and the last implementer's plain-text dumps `data/fs131/idg1/*.txt`, which it committed compressed): leave them, commit none of them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The chain's positive-entropy half reads one classical theorem, Einsiedler and Lindenstrauss's rigidity for
commuting automorphisms of solenoids, declared as an axiom. To apply it, the chain cuts the dual of its ring into
pieces, each a solenoid on which the rotations act totally irreducibly, and proves Lemma Γ there. The last
implementer proved the dual group and the Pontryagin duality these pieces read. You prove the pieces.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The pieces are where the declared theorem meets the chain: Lemma Γ is the statement the positive-entropy split reads,
and its hypotheses are exactly what the release's ergodic decomposition outputs. Proving it makes the split's module
the last of the positive-entropy half.

## The statements

The leaf of the chain's claim list (`data/fs131/claims-NF2.md`) the pieces serve, and the dated line that re-routed
their connectedness:

> NF2-LEAF-20: PE-2 (D:191): Lemma F (X02D:100); PE-1′, the pieces meet the printed hypotheses (X02D:146); Lemma W (X02D:156); Lemma Γ (X02D § 3.1, :181) over leaves 16, 17 (T2, T4); from `Γ` to `U` (X02D § 3.2, :196) over T1, T3.
> — source: data/fs131/claims-NF2.md

> - 2026-10-14 — **PE-1′'s connectedness is a third duality fact, D3 (FS131-KPD1).** `IsSolenoid`'s `connectedSpace` at `PieceDual M` reads that a torsion-free discrete group has a connected dual (`Rigidity.connectedSpace_dual`: the dual is divisible, and a clopen neighbourhood of `1` in a compact group contains an open subgroup of finite index), not D1 and the structure theory of compact groups that KN8's plan read. The total irreducibility's branch `N ≠ 0` reads no duality: `Y ⊆ N^⊥`, finite when `M ⧸ N` is (`Rigidity.finite_dualAnnihilator`). Leaves 8 and 9 of `Rigidity/Pieces` now wait on PD's statements only.
> — source: data/fs131/claims-NF2.md § Dated lines

The three hand-backs that typed and prepared this module, as I logged them (their words in quotation marks, the
rulings mine):

> 761. **FS131-KN8 handed back: the chain's fourth planner, at stage 6 (2026-10-14 06:55 UTC logged; "JOB FS131-KN8 — STAGE 6 SAVED … Items 1–4 and 6–8 of § Done means are done … Item 5 is done in words"; 471k by the harness's count — not to be resumed; branch `fs131-wk8` at `b531d058e`, tree `fs131-wq1`; record `plans/FS131-KN8-chain-split.md` there).** Its words: four modules typed with `sorry` at the leaves only — `Rigidity/DualGroup` (M4: "the dual of a discrete abelian group as a compact group under the pointwise topology. For countable G it is Polish, its Borel σ-algebra is the cylinder one, and it is a standard Borel space. Also separation of points, Fourier uniqueness, and Haar measure"), `Rigidity/UnitCircle` ("`AdmissiblePair` is the page's admissible Γ"), `Rigidity/Pieces` (M6: "PE-1′, the chain of pieces, Lemma Γ's steps, and Lemma Γ itself … Its hypothesis is `ErgodicSMul p.subgroup (Dual F) ρ`, which is exactly what the release's decomposition outputs"), `Rigidity/EntropySplitMax` (M7b: "the split `entropySplit_of_admissiblePair : EntropySplit F`, from one admissible pair"); "`haar_or_zero_entropy`'s proof does need `[PolishSpace X]` … The kernel's dump shows exactly ` [@PolishSpace.{u_1} X inst_1]` inserted (control fired) and the other three constants byte-identical"; "three statements of mine were false as first typed … lacked `[NumberField F]` … I corrected them before committing. No statement already typed in the chain is defective"; build 2 exit 0, 73 `sorry` warnings and no other; lint 14 passed; architecture PASS. **My receipt:** the five commits exist on `fs131-wk8`; from its compiled tree under the memory tool (scratch `kn8/Ax.lean`): `haar_or_zero_entropy`'s binders read `[BorelSpace X] [PolishSpace X]`; `Rigidity.polishSpace_dual : ∀ (G) [AddCommGroup G] [Countable G], PolishSpace (AddChar G Circle)`; `entropySplit_of_admissiblePair : ∀ {F} [NumberField ↥F] (p : AdmissiblePair F), EntropySplit F`, its axioms the standard three and `sorryAx` (a skeleton, as reported). **Rulings, four parts each.** (1) *The branch:* stays off `main` (a skeleton), the base of the chain's next lanes (D, U, G, S of record § 5.1); high. (2) *Lane PD, Pontryagin duality for a countable discrete group (D1, D2):* **formalize**, a planner first (FS131-KPD1, item 762), the declared form only as a fallback priced over a week, which comes to me (and an axiom added to the library is reported to Kooshi before it is declared); alternative, declare D2 now from `[Rudin1962]` — declined: W2, "when unsure, formalize", and the counter-priors on Lean cost; and a shorter route is in sight (below); high. **A route I saw while reading, labelled mine and unchecked, for the planner:** the one use (record § 2.3: "PE-1′'s total irreducibility needs it at `N = Y^⊥ = 0`") is "a closed subgroup `Y` of `Ĝ` with `Y^⊥ = 0` is all of `Ĝ`"; for discrete `G` a basic neighbourhood reads finitely many points, so restricting to the finitely generated `N = ⟨g₁, …, g_k⟩` (onto `N̂` since the circle is divisible) reduces it to closed subgroups of a torus times a finite group, where annihilators are Kronecker's theorem — no Haar measure, no `L²`, no Peter–Weyl. (3) *Tate's self-duality and strong approximation (M8b's inputs, prior-art debts):* priced by M8b's planner on record § Stage 4's vocabulary; bibliography rows (`[Tate1950]` or `[Weil1967]`) when a job reads one; not now; high. (4) *Lane A, `exists_admissiblePair` over every real number field:* a planner-and-implementer job in the queue; for its brief, a note of mine, unchecked: one completely split prime needs no Chebotarev — for `f` the minimal polynomial of a primitive element of the Galois closure, a prime dividing some `f(n)` and not the discriminant has a degree-one prime above it, hence (Galois) splits completely, and Schur's argument gives infinitely many such primes; medium. (5) *`Rigidity.entropySplit` sits in `ChainAtTA`, upstream of M7b:* owed to the chain's landing — the leaf moves downstream of `EntropySplitMax` with its statement unchanged, or the headline is assembled downstream (an import cycle otherwise); high. (6) *Its generalizations* (step 2 for any group action; the pigeonhole's `α′`; Herglotz–Bochner idle at countable `G`, item 757): filed as its dated lines. (7) *The three statements false as first typed:* credit for catching them before any commit; no workflow change. **Filed:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its `LEAN.md` lines (record §§ 3.5, 5.2) and the `[Rudin1962]` reading-status line (§§ 1.5, 2.1 cited, recalled, not read). **The queue's order, re-ruled:** the chain's PD planner takes this slot ahead of the density equality's lanes C and D; alternative, the density lanes now (interleaving) — declined: their landing waits on the port (about four lanes, 12–18 hours by its plan), so they have slack, while PD is on the chain's longest path; medium-high; the density lanes take the next free slot.
> — source: plans/FS131-close-inventory.md

> 775. **FS131-KPD1 handed back: Pontryagin duality typed, its route measured (2026-10-14 09:35 UTC logged; "JOB FS131-KPD1 — DONE"; 427k by the harness's count — not to be resumed; branch `fs131-wpd` at `c138bbafd`, tree `fs131-wq1`; record `plans/FS131-KPD1-pontryagin.md` there).** From its hand-back message: four new modules (`Rigidity/Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`) with `sorry` at the leaves only — "D2 general (`dualAnnihilator_dualCoannihilator_of_isClosed`), its closure form, the case … D1 (`evalDualHom_surjective`, `dualDualEquiv`, `additiveDualDualEquiv`)", D3 (`connectedSpace_dual`); "Pieces is re-pointed … 74 of 74 identical before and after, and the control fires"; "route H: Haar measure on closed subgroups, with Fourier uniqueness from `Rigidity/DualGroup`. It needs no Peter–Weyl, no L² and no tori"; "26 of 28 leaves, about 165 lines, elaborate at the pin … Grade: elaborated, not landed"; "Lane PD-I is about two to three hours of implementer work … no fallback axiom is drafted and none is needed"; build exit 0, lint 14 passed, architecture PASS; a slip of mine: "In inventory item 761, the nested quotations 'Its words: …' match neither the KN8 report on disk nor the record verbatim … They are presumably quoted from the hand-back text, which is not on disk"; a library request: "A copy of it [`Rudin1962`], or of Deitmar–Echterhoff Ch. 3". **My receipt:** the seven commits exist on `fs131-wpd`; from its compiled tree under the memory tool (scratch `kpd1/Ax.lean`): `dualAnnihilator_dualCoannihilator_of_isClosed : ∀ {G} [AddCommGroup G] [Countable G] (Y : Subgroup (AddChar G Circle)), IsClosed ↑Y → dualAnnihilator (dualCoannihilator Y) = Y`; `connectedSpace_dual : ∀ {G} [AddCommGroup G] [IsAddTorsionFree G], ConnectedSpace (AddChar G Circle)`; `evalDualHom_surjective : ∀ {G} [AddCommGroup G] [Countable G], Function.Surjective ⇑(evalDualHom G)` — the general theorems, as reported. `git merge-tree` of `fs131-wpd` with `fs131-wl1` (the chain's proved lanes): clean. **Rulings, four parts each.** (1) *Who folds the route copies:* lane PD-I's implementer, not the planner — a planner proves no more than a few lines; alternative, the planner — declined by its lane's rule; high. (2) *The next chain job:* one implementer (FS131-IDG1, item 776) on a branch from `fs131-wpd` that first merges `fs131-wl1`, taking lane D (`Rigidity/DualGroup`, on every duality headline's path), then PD-I, then U (`Rigidity/UnitCircle`, all but lane A's leaf), and the architecture cell and stale docstrings owed by item 770 ruling 1; alternative, PD-I alone first — declined, its headlines reach `sorry` only through lane D; high. (3) *My slip:* my inventory items quote hand-backs from the message the harness delivers, which is not on disk and may differ from the report file in small ways; from here on I say "from its hand-back message" when I quote one; no workflow change beyond that; high. (4) *The library request:* not urgent — the statements are standard and their proofs are being formalized here, so the textbook bears on attribution only; it goes to Kooshi as a know-not-decide line in the next report; medium. **Filed:** its three dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its four `LEAN.md` lines and the `[Rudin1962]` reading-status line (record § 5.3). **For M8b's planner:** Tate's surjectivity from D2's case (its third dated line).
> — source: plans/FS131-close-inventory.md

> 782. **FS131-IDG1 handed back: the dual group, Pontryagin duality and the unit circle proved (2026-10-14 11:00 UTC logged; "JOB FS131-IDG1 — DONE"; 466k by the harness's count — not to be resumed; branch `fs131-wdg` at `68c47bb40`, tree `fs131-wq1`; record `plans/FS131-IDG1-implementation.md` there).** From its hand-back message: "**Lane D:** `Rigidity/DualGroup`, all 13 leaves. **Lane PD-I:** all 29 `sorry`s of the four duality modules. **Lane U:** `Rigidity/UnitCircle`, 7 of its 8 leaves … Every one of these rests on exactly `[propext, Classical.choice, Quot.sound]` … No statement moved. No leaf turned out false, and none lacked a hypothesis"; "154 named constants in kind and stored type; 37 data definitions in value … The planted control was reported 8 of 8"; build 3 exit 0; lint 14 passed; `dupnames.sh` passes on the joined tree; the architecture cell and docstrings item 770 owed applied, `check_architecture.py` passes. **My receipt:** the six commits exist; `sorry` counts at `fs131-wdg`'s tip: `DualGroup` 0, `Annihilator` 0, `SubgroupHaar` 0, `Duality` 0, `DualConnected` 0, `UnitCircle` 1 (`exists_admissiblePair`, lane A's); the axioms of `measure_eq_of_fourier`, `dualAnnihilator_dualCoannihilator_of_isClosed`, `evalDualHom_surjective` and `connectedSpace_dual` were printed at item 778 from this tree, each the standard three. **Rulings.** (1) *Its six modules' `ARCHITECTURE.md` rows and docstrings that still say "skeleton", and the stale docstring of `measure_frequentVisits_le`:* filed from its drafts by the next chain implementer on this branch; high. (2) *Its generalization — unconditional forms beside `Arith/SpectralInputs`' forms over `BochnerHerglotz G`:* owed with item 757's to the chain's landing planner, who decides whether to re-point their consumers; high. (3) *Its tool defect — `data/fs131/lc1/code_only_diff.py` plants at the first `:=`, which can sit inside a docstring:* repaired in this job's copy `tools/fs131_idg1_code_only.py`; the older script goes on the tooling list; high. (4) *The tree:* keeps its compiled library, current for `fs131-wdg`, for the chain's next implementer (lane G, `Rigidity/Pieces`). **For Kooshi's report (settled):** Fourier uniqueness and Pontryagin duality for countable discrete abelian groups are kernel theorems here on the standard three, with no Peter–Weyl — classical theorems, the kernel proofs ours; on the chain's branch, not on `main`.
> — source: plans/FS131-close-inventory.md

**Your leaves** are the fifteen `sorry`s of `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/Pieces.lean`. Their statements are the file's; read them in the
source. **The plans**: the split planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN8-chain-split.md` § 2.5 (leaves 1–7 and 10–14), the duality planner's record
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KPD1-pontryagin.md` § 4.2 (leaves 8 and 9, re-pointed to the duality theorems, which are now proved), and the derivation
`plans/FS100-X02D-derivation.md` (PE-1′, § 3.1 Lemma Γ). Some leaves read statements of other modules that are still
leaves there (`haar_or_zero_entropy` in `Rigidity/PositiveEntropy`; the entropy file's tenth leaf): use them as stated;
your records will print `sorryAx` through them until those land, and your report lists which. The last implementer's
record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IDG1-implementation.md` is the worked pattern for this chain's files.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of `Pieces` dumped from the built tree before any edit.
2. **The leaves** (saved stages every few, and the one line to me at half); re-price what is left from the first two.
3. **The rows and docstrings** from the last implementer's drafts; `tools/check_architecture.py` passes.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); no `sorry` left in `Pieces`; one build under the slot with no warning from it; the axioms of every
   public declaration of `Pieces` printed from the built tree — the standard three, the declared printed theorem where
   a record applies it, and `sorryAx` only through the named leaves of other modules — each listed, with a planted
   record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for `Pieces`; the model for each hypothesis that lacks
   one (PE-1′'s non-degenerate model of the declared theorem's hypotheses is one the earlier planners named); any
   `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports a proof needs; another route for a leaf where the plan's does not go through (tell
me which). An unread binder of a statement in `Pieces` is dropped without asking, listed in your statement check as a
ruled difference and named in your report (the standing word of item 726). Not yours: any other change to a statement
or definition; the files listed as not yours; the declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ig1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`.
On exit 75 wait ten minutes and retry; the port's build of the whole library may hold the slot for up to an hour. Stop
a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ig1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
