# Brief FS131-KN8 — the five-colour chain, next: what the positive-entropy split reads, typed; the split's module typed to its leaves; then the zero-entropy side's second module

*Written 2026-10-14 04:42 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KN8
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the fourth planner on this chain, after three who laid out its architecture, brought its first layer through a build, repaired its declared printed theorem to its page and typed two of its modules
  role: the kernel lane's planner on the chain under "five colours at the square root of 47" — type the statements the positive-entropy split reads from other modules (the dual of the field as a compact group with its Borel structure and Haar measure; Fourier uniqueness; Lemma Γ), type the split's own module to its leaves, and, as far as you reach, the zero-entropy side's second module
  launch: now, in the tree the last planner used (its job is finished), on a new branch cut from its branch; the port's planner works in `fs132-wi1` and the density equality's implementer in `fs133-wk1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, or a statement change of ours other than the one § What is yours to decide pre-approves; before you elaborate any file of the outside release (say which and how large — the method of item 717 is approved, so this is a notice unless the file fails its scan); the report goes to `data/fs131/reports/FS131-KN8.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KN8-chain-split.md` (new, on branch `fs131-wk8`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wk8`** that you cut from `fs131-wk7` (at `6b7ec2426`, checked out there now): new modules of the chain under `Proofs/HadwigerNelson/Rigidity/` with their lines in the build's lists and `ARCHITECTURE.md`; statements in `Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` (the module that holds `haar_or_zero_entropy`) and `Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean` only where a module you plan needs one typed or the pre-approved change below; the draft claim lists under `data/fs131/kn3/` where your plans change them (old text kept in git); `plans/FS131-KN8-chain-split.md`; `data/fs131/kn8/`; `data/fs131/reports/FS131-KN8.md`. **Not** the proofs in `Rigidity/Entropy.lean`, `Rigidity/ZeroEntropyNames.lean`, `Rigidity/SolenoidErgodic.lean`, `Rigidity/HaarMultiple.lean`, the C0 leaves of `Rigidity/ChainAtTA.lean`, or any module under `Outside/`: those are five ready lanes for implementers (the last planner's record § 6.4), who will work from your branch or its parent; a statement in one of them that your plan needs changed comes to me first. An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; you cannot read that count, so save a stage (a commit on your branch) after the readback, after each module's statements, and after each few leaves' plans; hand back at a saved stage rather than start a step you cannot finish

Hello. The last planner on this chain repaired the declared printed theorem to its page, weakened the entropy split
to what its one consumer reads (so the theorem that assembles the measure-rigidity statement from its two halves is now
proved with nothing under it), typed the zero-entropy names and the largest Haar multiple, and measured the release's
ergodic decomposition as a port of hours. It ran out of room before typing the split's own module. That is where you
start.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The chain is the kernel proof that the plane over the field of √47 needs five colours (ledger rows 121 and 123), on
one declared printed theorem. Its proved theorems are only as far along as its planned statements: five lanes are
ready for implementers, and the two modules after them — the split, and the zero-entropy side's second half — are
still words. The planners are the chain's critical path.

## The statements

What the chain does not claim, from its claim list `data/fs131/claims-NF2.md`, and the two leaves this job's modules
carry, with the dated line that narrowed the first:

> NF2-NC: any size or price of a leaf (the map says none of leaves 8–23 is sized); that the leaf list is complete (the deriver's table names two results read on the path that are not numbered leaves: the density of the ring in its completion, and the ring equalling its maximal order away from the exception fields); that the printed rigidity theorem is formalized (it is declared, with its four items); that any leaf is new mathematics.
> — source: data/fs131/claims-NF2.md § Not claimed

> NF2-LEAF-20: PE-2 (D:191): Lemma F (X02D:100); PE-1′, the pieces meet the printed hypotheses (X02D:146); Lemma W (X02D:156); Lemma Γ (X02D § 3.1, :181) over leaves 16, 17 (T2, T4); from `Γ` to `U` (X02D § 3.2, :196) over T1, T3.
> — source: data/fs131/claims-NF2.md

> NF2-LEAF-21: EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
> — source: data/fs131/claims-NF2.md

> - 2026-10-14 — **NF2-LEAF-20 is narrowed: the entropy split is read at one rotation (FS131-KN7, Amendment 2 of its brief).** `Rigidity.EntropySplit` asks for entropy zero at one rotation by a non-torsion unit vector, which is all `mrPlus_of_split_of_carried` reads; PE-2 at every rotation is `Rigidity.EntropySplitEvery`, which implies it and is off the headline's path. Off the path with it: Lemma W for every non-torsion vector and the torsion case (X02D ll. 156, 166); on the path: one admissible `Γ`. `mrPlus_of_split_of_carried` is now a theorem on the standard three axioms.
> — source: data/fs131/claims-NF2.md § Dated lines

The last planner's hand-back as I logged it (its words are in quotation marks; the rulings are mine — rulings 2 and 3
are yours to act on):

> 750. **FS131-KN7 handed back: the chain's third planner, at stage 6 (2026-10-14 05:00 UTC logged; "JOB FS131-KN7 — STAGE 6 SAVED. Items 1–4 and 6 of § Done means are done, each a saved stage. Item 5 is done in part"; 576k by the harness's count — past the line, not to be resumed; branch `fs131-wk7` at `6b7ec2426`, tree `fs131-wq1`; record `plans/FS131-KN7-chain-next.md` there).** Its words: R1 made — "clause (4) now uses `borel (X ⧸ G j)`. Beside it, `positive_entropy_rigidity_of_polishSpace` gives the old form for Polish `X`"; the split — "`EntropySplit` asks for entropy zero at one rotation by a non-torsion unit vector … `mrPlus_of_split_of_carried` (EN1-FROM-TWO) now rests on the standard three axioms with no `sorry` under it"; lane N typed (`Rigidity/ZeroEntropyNames`, 8 leaves; `Rigidity/SolenoidErgodic`, 1 leaf); the trials — "`action_ergodic_decomposition` uses at most 559 lines of the release, against 22,632 in its declared cone. It elaborates with 0 errors after three renames, all inside proofs … The generating-sequence theorem's bundle is 1,843 lines and elaborates with 0 errors after one rename"; M7a typed (`Rigidity/HaarMultiple`, 7 leaves, the largest Haar multiple as an upper adjoint); "M7b is planned in words only, and M8b was not reached"; build 4 exit 0 with 31 `sorry` warnings only, lint 14 passed, architecture PASS. **My receipt:** the seven commits `90039269f`…`6b7ec2426` exist on `fs131-wk7`; the record's § 6.5 names the logs; I printed the axioms from the tree's compiled library under the memory tool (`lake env lean`, scratch `kn7/Ax.lean`): `mrPlus_of_split_of_carried` — `[propext, Classical.choice, Quot.sound]`; `positive_entropy_rigidity_of_polishSpace` — those and `HadwigerNelson.Rigidity.positive_entropy_rigidity`; `EntropySplit : Subfield ℝ → Prop`. As reported. **Rulings, four parts each.** (1) *The branch:* stays off `main` (a skeleton: 31 leaves and an axiom not yet declared to the audit) and becomes the base of the next planner's branch; alternative weighed, merging the two proved theorems to `main` alone — declined, they read the chain's skeleton modules; high. (2) *Its question on `haar_or_zero_entropy` (module M5) possibly needing `[PolishSpace X]`:* a standing word to the next planner — it may add that binder without waiting for me, provided every use of the theorem on the headline's path is at a space whose Polish instance is a theorem of the library (the dual of a countable field), the old and new stored types are dumped, and a dated line is drafted; alternative weighed, a ruling each time — declined, the change only narrows a statement of ours toward its one use and the kernel checks the discharge; high; it would change if a use site's space has no Polish instance in reach. (3) *`StandardBorelSpace (Dual F)`, owed for the release's decomposition:* the next planner's, typed with module M4 (the dual as a compact group), from metrizability of the dual of a countable group (a closed subset of a countable product of circles); alternative, leave it to M7b's implementer — declined, M7b's statements read it; high. (4) *The prior-art debt ("a compact abelian group with countable dual is metrizable", recalled not read):* declined as a debt — nothing rests on it now that the axiom states the page's σ-algebra; the step it backed is the record's [reading] that the old clause was not false, and the record labels it so; at the dual of a countable field the kernel will hold the instance itself (ruling 3); high. (5) *The next job:* a fresh planner on M4's statements, M7b typed, and M8b (FS131-KN8, item 751), in the same tree, its branch cut from `fs131-wk7`; alternative weighed, an implementer on the five ready lanes (N, H, P2, P3, C — record § 6.4) — declined for this slot: the planners are the chain's critical path, and the five lanes share no file and fill the slots the port's and the density equality's jobs free; medium-high; it would change if the port's planner hands back first with implementers to staff. **Filed:** its three dated lines for `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its two `LEAN.md` lines, its `ARCHITECTURE.md` § Trust line (at the first landing that proves a record from the axiom), its two `BIBLIOGRAPHY.md` reading-status lines (record § Drafts). **Cleanup:** `fs131-wnf`'s compiled copy (5.1 GB) deleted, the brief that named it having handed back (`data/cleanup/2026-10-14-builds-deleted-late.txt`); disk 330 GB free.
> — source: plans/FS131-close-inventory.md

Where everything is, all in your tree on its branch: the last planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN7-chain-next.md` (§ 6.3: the split's module
planned in words, with its vocabulary decided; § 6.4: the lanes; § 6.2: the Haar multiple; § 2.1: the quotient's
σ-algebra; § Stage 4: the release's decomposition and what it asks of the space), the planner before it
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN6-chain-first-layer.md` (§ 5.6: the lanes; § Stage 4: the re-cut), the chain's architecture `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN3-chain-plan.md` (its module table: M2 Fourier
uniqueness and Herglotz–Bochner, M4 the dual as a compact group with Haar measure, M5 `haar_or_zero_entropy`, M6 the
pieces and Lemma Γ, M7 the split, M8 the zero-entropy side), and the two draft claim lists `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/kn3/claims-M7-entropy-split.md` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/kn3/claims-M8-zero-entropy-carried.md`. The
deriver's records on `main`: `plans/FS131-EN2-derivation.md` (§ 5.2, entry EN2-PE2-MAX: the split's proof in steps;
entries EN2-L31 and the model for the zero-entropy side), `plans/FS100-X02D-derivation.md` (§ 3.1, Lemma Γ; § 3.2, from
`Γ` to `U`) and `plans/FS100-X01D-derivation.md` (§ 2.0, the model of the dual as adeles modulo the diagonal; Lemma
3.1′ and the pigeonhole of Lemma 3.2′).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the last planner's § 6.3 restated in
   your record, with the statements of the declared theorem and of `EntropySplit` as the kernel prints them.
2. **What the split reads, typed** (a saved stage): the dual of the field as a compact group — its topology,
   compactness, `PolishSpace` and `StandardBorelSpace` for its Borel structure (ruling 3 of the item above), and its
   Haar probability measure invariant under translation and under the rotations; Fourier uniqueness for finite measures
   on it; Lemma Γ as X02D § 3.1 states it — each in the module the chain's architecture assigns it, or a better cut you
   name, with `sorry` at the leaves only, each read aloud against its source, each with a model, a plan per leaf.
3. **`haar_or_zero_entropy`'s Polish question settled** (ruling 2 of the item above): whether its proof needs `[PolishSpace X]`;
   if it does, make the change on the standing word, with the dumps and the dated line it asks for.
4. **The split's module typed** (a saved stage): `entropySplit`'s module from the vocabulary of the last planner's § 6.3
   (the unit vectors as a subgroup of the circle, their rotation action on the dual, admissibility, the Borel structure)
   and its statements (a)–(d) there, each read aloud against EN2-PE2-MAX's steps, each with a model, a plan per leaf,
   compiled with `sorry` at the leaves only. Name the step that would fail if a reading were wrong.
5. **The zero-entropy side's second module planned, as far as you reach**: the model of the dual as adeles modulo the
   diagonal, Lemma 3.1′ over the names already typed, the pigeonhole, the wandering step — typed with `sorry` at the
   leaves only and planned per leaf, or, if you do not reach it, its vocabulary decided in words as the last planner did
   for the split.
6. **Lanes**: the implementer lanes after this job, sharing no file, with what each needs; **run the domain pass as a
   fresh skill invocation on every new definition, and the obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; any `LEAN.md` or bibliography lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; which of the deriver's routes each takes where it offers two; the order after item
1; how far into item 5 you reach. **Pre-approved, on the standing word of ruling 2:** adding `[PolishSpace X]` to
`haar_or_zero_entropy`, on its conditions. Not yours: any other change to a statement already typed without my ruling;
the declared theorem; proving leaves beyond a few lines while testing a plan; the five implementer lanes' proofs; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; the disk has about 330 GB free — do not copy compiled libraries
between trees.** This tree's compiled library is the last planner's, current with your branch's parent: build on it.
One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn8 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kn8/`.
Copies of the release's text stay under the tree's ignored `build/` folder and are in no commit. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
