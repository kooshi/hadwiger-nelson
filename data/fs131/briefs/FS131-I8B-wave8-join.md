# Brief FS131-I8B — wave 8, the join and the shared part: the first implementer's branch merged, `star_anti` at its ruled statement and proved, and the three lemmas two later implementers share, in a module of their own

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I8B
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 8's second implementer — merge the first implementer's finished branch into the wave's line, make one ruled statement change (`star_anti` gains two hypotheses) and prove that leaf, and state and prove the three shared helper lemmas the second planner named in prose, in a new module saved first, so that two implementers can start from your tip in parallel
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back; nobody else works on wave 8 while you do
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job when the helper module is saved (its commit hash and the three statements, at once: two jobs wait on that message), for a merge conflict in a Lean file, if the ruled hypotheses do not close `star_anti` or the leaf is false with them (at once, with the configuration), if a helper cannot be stated so that the uses the plan names go through, or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-I8B.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I8B-implementation.md` (new, on branch `fs131-w8b`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b` (branch `fs131-w8b`, cut from `fs131-w8` at `8d979793`): the merge's files; `Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean` — `star_anti`'s statement by the ruled change, its docstring, its proof, and helpers under names no other module declares; **a new module** `Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean` (or a name you prefer) for the shared lemmas, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I8B", above the `=== PURCHASED ===` banner); `plans/FS131-I8B-implementation.md`, `tools/fs131_i8b_*.py`, `data/fs131/i8b/`, `data/fs131/reports/FS131-I8B.md`; **not** any other statement, the two modules of semi-hub rows (`SemiHub`, `SemiHubPlaces`: their leaves are the next two implementers'), `outerAdj`, the wave's foundation, any landed module, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones; waves 1–5, the first half of wave 6 and most of wave 10 are on `main`. Wave 8 is the *ring calculus*: what the unit circle about a
vertex of a valid map (its *ring*) carries, in the class with no Siamese pair. Today its first implementer proved the wave's first
theorem — no four-colour vertex has a ring free of boundary arcs — and its second planner stated nine more rows in two new modules,
twenty-three leaves. Those two lines of work are on two branches, one leaf between them is stuck on a statement that was written too
wide, and the two modules' proofs share three lemmas that exist only as sentences in a plan. You make the ground the next two
implementers stand on.

## Why this job

A result counts as held only when its Lean module passes the gate, and two implementers who each need a lemma the other is writing
either wait on each other or state it twice — which this milestone forbids (`LEAN.md` § Searching — Lean, last bullet: two branches
never state one lemma under one name). So the shared part is written once, first, by one job. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The hand-backs and rulings behind this brief (read each item whole in the inventory):

> 567. **FS131-I8A, by message mid-job: `emptyNS` is proved and saved; the generalization of item 563 is now carried by a saved stage; a gap at one step of `star_anti`** (source: I8A's message to "main", 2026-10-06; commit `368a2c1a` on `origin/fs131-w8a`, fetched — the full review is at its hand-back).
> — source: plans/FS131-close-inventory.md

> 568. **FS131-K8b, by message mid-job (its Stage 6 saved at `5d4e4d12`; no Lean of its own yet): three answers from the arguments — `star_anti`'s gap is a defect of the skeleton's hypothesis; `doubleTip`'s extra hypotheses were a route's; FS116-V5-OUT2 is `star_outer_cone`** (source: K8b's message to "main", 2026-10-06).
> — source: plans/FS131-close-inventory.md

> 569. **FS131-I8A done at its Stage 5: wave 8's empty class is proved — `emptyNS` and its six leaves, `doubleTip`, `star_recip`; `star_anti` left open at its old statement** (implementer, Opus; harness 556k and 77 minutes by the task notice; record `fs131-w8a`'s `plans/FS131-I8A-implementation.md`; report `data/fs131/reports/FS131-I8A.md`; four commits, tip `e1e0c74d`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 572. **FS131-K8b done at its Stage 10: wave 8's second planning pass — nine semi-hub rows stated in two new modules with no hypothesis from wave 7; two rows left for a third pass** (planner; harness 609k and 48 minutes by the task notice; record `fs131-w8`'s `plans/FS131-w8-kernel-plan.md` Stages 6–10; report `data/fs131/reports/FS131-K8b.md`; commits `5d4e4d12`, `8d979793`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

## The statements

**One statement changes, by ruling 568 (a), and no other.** The leaf as it stands in your tree:

> theorem star_anti {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean

The row it formalizes excludes a case in its own words, and the hypotheses `hp'`, `hm` above admit that case when a tile's cone at the
vertex is every direction:

>   not claimed: anything when an edge of p leaves at ψ + 90° or ψ − 90° (the strip: there the two missing pairs differ); anything at k ≥ 7
> — source: plans/FS116-derivation.md

The ruled change — two binders after `hm`, nothing else — and what the implementer who found the gap handed on about it (by thought
only, not elaborated: attack it before you lean on it):

>     (hp'' : ∀ T, F.TileAt p T → T ≠ tp → ψ + π / 2 ∉ coneAt T p)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md § 5.5 The coordinator's ruling on `star_anti`, and what I did with it

>     (hm'' : ∀ T, F.TileAt p T → T ≠ tm → ψ - π / 2 ∉ coneAt T p)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md § 5.5 The coordinator's ruling on `star_anti`, and what I did with it

> - **The binders close the stuck case.** If `tp = tm = t` with the whole circle as cone, every other tile of `p` has its cone in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md § 5.5 The coordinator's ruling on `star_anti`, and what I did with it

> - **They are no new content at a proper interval.** If the cone of `tp` is `angleIcc β₁ β₂` with `β₂ < β₁ + 2π`, its interior is in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md § 5.5 The coordinator's ruling on `star_anti`, and what I did with it

> - **Their form is usable as written**: the proof applies them to a tip (`IsTip p y S` gives `F.TileAt p S`) and to the tile of `p` of an
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md § 5.5 The coordinator's ruling on `star_anti`, and what I did with it

> - **The route for the rest**: (a) `cp ≠ cm` from `tp ≠ tm` (one tile per colour at `p`); (b) `{cp, cm} ⊆ A(y), A(y*)` from
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md § 5.5 The coordinator's ruling on `star_anti`, and what I did with it

The three shared lemmas exist only in the second planner's prose (its own slip, said in its record: "stated in prose, not in Lean").
Its sentences, and its hand-off — **in which the job names differ from mine: what it calls "I8B" on `SemiHub` is FS131-I8C, its "I8C"
on `SemiHubPlaces` is FS131-I8D, and you are the job it says "starts first"**:

>    `e₁ … e₄`. The repeated chain is one missing lemma, minted once: **C1 `exists_int_of_angleIcc_subset`** — `a ≤ b → hi < lo + 2π →
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/plans/FS131-w8-kernel-plan.md § 9.1 The statements the proofs derive from

>    under `SimpleOn {x}` the tiles of `x` are the chart's sectors, one each (**K1 `IsSectorChart.tileAt_equiv`**), and two consecutive
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/plans/FS131-w8-kernel-plan.md § 9.1 The statements the proofs derive from

>    sectors share the branch between them — an initial piece of a map arc in both closures (**K2
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/plans/FS131-w8-kernel-plan.md § 9.1 The statements the proofs derive from

> - **By file**: *I8B* on `Plane/RingCalculus/SemiHub` (17 leaves; mint C1, C2, G1, K1, K2 first, in a helper module of its own if it
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/plans/FS131-w8-kernel-plan.md § 9.8 The handoff

> - **`star_anti`** gains two binders on the first implementer's branch (ruling, item 568); nothing here reads it.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/plans/FS131-w8-kernel-plan.md § 9.8 The handoff

## Done means

1. **Your readback first**: check the quotations against their sources; read the second planner's record (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8b/plans/FS131-w8-kernel-plan.md`, Stages 6–10; its
   § 7.3 on the gap, § 9.1 on the shared lemmas, §§ 9.2–9.3 for every use of C1, K1 and K2 in the two modules' plans), the first
   implementer's record (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-I8A-implementation.md`, Stage 5), the wave's modules in your tree, and the row's entry. Build the branch once as given (26 `sorry` leaves:
   17 and 6 in the two semi-hub modules, 2 in `Star`, 1 in `Empty`). Open your record. Commit and push.
2. **The merge**: `git merge origin/fs131-w8a` (at `e1e0c74d`: the first implementer's last stage — `star_recip` proved, docstrings; your
   base already holds its earlier commits). Trial it first; my trial of it on your base shows no conflict. A conflict in a registry file is adjacent
   additions, keep every side; one in a Lean file is a message to me. Committed as a merge, the index holding the merge and
   nothing else. Build: 25 leaves.
3. **The shared module, saved before anything else of yours**: C1 (`exists_int_of_angleIcc_subset`: an interval inside a union of
   `2π`-translates of an interval shorter than `2π` lies in one), K1 (`IsSectorChart.tileAt_equiv`: under `SimpleOn` at a point its
   tiles are its chart's sectors, one each) and K2 (`IsSectorChart.exists_initialPiece_between`: two consecutive sectors share an
   initial piece of a map arc in both closures) — stated in Lean by you, from the planner's sentences and from **every use the two
   plans make of them** (list the uses in your record, then state each lemma so they go through; where two uses want two forms, state
   the general one and a corollary). `#check` each and read the binders the kernel shows (inventory item 556: a section `variable`
   enters a theorem only if its statement mentions it). Prove them. The planner found the wave-4 lemmas it names for K2 by name and
   did not read them: read them. C2 and the planner's G1 are yours to place — in the shared module if both later jobs need them.
   **Then a build, the axioms print with a control that fires, commit, push, and one message to me with the hash and the three
   statements.**
4. **`star_anti`**: the ruled change exactly — the two binders (their form adjusted only if the proof needs it, and then say what and
   why), a docstring clause naming the excluded case and the row's line — then the proof. Its `sorry` is the only one that leaves
   `Star`. If the hypotheses do not close it, or it is false with them, that is a message, and the leaf stays open with the change
   made and its gap named.
5. **The statement check**: against `8d979793` and against `e1e0c74d`, on elaborated signatures (two implementers' tools do this, with
   controls: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/tools/fs131_i8a_stmt.py` is the wave's own) — exactly one
   declaration changed, `star_anti`, by exactly the two binders; your additions listed.
6. No other statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do
   not run the gate or touch `main`. `./scripts/dupnames.sh` before each push that adds names; `tools/check_architecture.py` exit 0. **After your last green build, the guarded
   lint** — `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved: a
   landing's gate went red today on an instance argument a proof did not read, which the build's own linters do not report
   (inventory item 573). A line it reports in what you wrote is yours to repair if no statement of a leaf changes, and a message if one does.
   Leave no background process running, and keep what your record cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED (FS131-I8B)", "Theorems this phase proved", each read against its sentence; and a
   section **"For the two implementers who start from here"**: the shared lemmas with their statements, which use each serves, and
   anything in the two modules' plans your reading of the foundation shows will not go as written. The report in standing rule 11's
   form. Stopping at a saved stage with the merge and the shared module done and `star_anti` open is a good report: the shared module
   is what two jobs wait on.

## What is yours to decide

The statements of the three shared lemmas (they are helpers, and yours — but two jobs will build on them, so state them for their
uses, not for your convenience), the module's name and layout, the route for `star_anti`, your helpers. The ruled change is not yours
to widen: no third hypothesis, and neither binder dropped, without a message. If the planner's sentence for a shared lemma is false
as it reads, or the plans' uses need something it does not give, that is a finding: state what is true and say so. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
