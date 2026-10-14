# Brief FS131-KPD1 — the five-colour chain: Pontryagin duality for a countable discrete group, planned and typed to its leaves

*Written 2026-10-14 05:38 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KPD1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the fifth planner on this chain, and the first on this one classical input
  role: the kernel lane's planner for one classical input of the chain under "five colours at the square root of 47" that its leaf list did not name: Pontryagin duality for a countable discrete abelian group, in the two halves the last planner named — typed to its leaves, its route chosen by measurement, priced
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's implementer works in `fs131-wch` and the port's implementer in `fs132-wi1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a statement already typed must change, and if your pricing comes out over a week of agent work (before you plan the fallback in detail); the report goes to `data/fs131/reports/FS131-KPD1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KPD1-pontryagin.md` (new, on branch `fs131-wpd`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wpd`** that you cut from `fs131-wk8` (at `b531d058e`, checked out there now): new modules under `Proofs/HadwigerNelson/Rigidity/` (or a better place you name) with their lines in the build's lists and `ARCHITECTURE.md`; statements in `Proofs/HadwigerNelson/Rigidity/Pieces.lean` only where its leaves that read duality need one re-pointed to your theorems (the statement of an existing leaf changes only on my ruling); `plans/FS131-KPD1-pontryagin.md`; `data/fs131/kpd1/`; `data/fs131/reports/FS131-KPD1.md`. **Not** the proofs of any other module's leaves, `Rigidity/DualGroup.lean`'s statements, any module under `Outside/`, the declared printed theorem. An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the statements, after the route's measurement and after each few leaves' plans

Hello. The last planner on this chain typed the modules the positive-entropy split reads, and found that one of them
leans on a classical theorem the chain's leaf list never named: Pontryagin duality, which the derivation cites as
textbook. It sized one half at about a day and the other at about the size of the Peter–Weyl theorem. You plan it.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

So the default is to formalize, not to declare. The chain's milestone may assume the literature, but every axiom it
adds is one more thing the publication must either price onto the standard three or carry, and this one may be much
smaller than it looks: what the chain reads may be far less than the general theorem.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that names the input:

> - 2026-10-14 — **A classical input the leaf list does not name: Pontryagin duality for a countable discrete group (FS131-KN8).** PE-1′ (NF2-LEAF-20) reads that the continuous characters of `M̂` are the evaluations (D1; NF2-LEAF-15's draft names it) and that a closed subgroup of `M̂` is the annihilator of its annihilator (D2, the duality theorem for compact abelian groups); EF_F⁺'s model (NF2-LEAF-21) reads Tate's self-duality of the adeles. X02D and X01D cite them as textbook.
> — source: data/fs131/claims-NF2.md § Dated lines

The last planner's hand-back as I logged it, with my rulings (ruling 2 is yours, including a route I saw — mine,
unchecked, offered for you to measure, not a plan):

> 761. **FS131-KN8 handed back: the chain's fourth planner, at stage 6 (2026-10-14 06:55 UTC logged; "JOB FS131-KN8 — STAGE 6 SAVED … Items 1–4 and 6–8 of § Done means are done … Item 5 is done in words"; 471k by the harness's count — not to be resumed; branch `fs131-wk8` at `b531d058e`, tree `fs131-wq1`; record `plans/FS131-KN8-chain-split.md` there).** Its words: four modules typed with `sorry` at the leaves only — `Rigidity/DualGroup` (M4: "the dual of a discrete abelian group as a compact group under the pointwise topology. For countable G it is Polish, its Borel σ-algebra is the cylinder one, and it is a standard Borel space. Also separation of points, Fourier uniqueness, and Haar measure"), `Rigidity/UnitCircle` ("`AdmissiblePair` is the page's admissible Γ"), `Rigidity/Pieces` (M6: "PE-1′, the chain of pieces, Lemma Γ's steps, and Lemma Γ itself … Its hypothesis is `ErgodicSMul p.subgroup (Dual F) ρ`, which is exactly what the release's decomposition outputs"), `Rigidity/EntropySplitMax` (M7b: "the split `entropySplit_of_admissiblePair : EntropySplit F`, from one admissible pair"); "`haar_or_zero_entropy`'s proof does need `[PolishSpace X]` … The kernel's dump shows exactly ` [@PolishSpace.{u_1} X inst_1]` inserted (control fired) and the other three constants byte-identical"; "three statements of mine were false as first typed … lacked `[NumberField F]` … I corrected them before committing. No statement already typed in the chain is defective"; build 2 exit 0, 73 `sorry` warnings and no other; lint 14 passed; architecture PASS. **My receipt:** the five commits exist on `fs131-wk8`; from its compiled tree under the memory tool (scratch `kn8/Ax.lean`): `haar_or_zero_entropy`'s binders read `[BorelSpace X] [PolishSpace X]`; `Rigidity.polishSpace_dual : ∀ (G) [AddCommGroup G] [Countable G], PolishSpace (AddChar G Circle)`; `entropySplit_of_admissiblePair : ∀ {F} [NumberField ↥F] (p : AdmissiblePair F), EntropySplit F`, its axioms the standard three and `sorryAx` (a skeleton, as reported). **Rulings, four parts each.** (1) *The branch:* stays off `main` (a skeleton), the base of the chain's next lanes (D, U, G, S of record § 5.1); high. (2) *Lane PD, Pontryagin duality for a countable discrete group (D1, D2):* **formalize**, a planner first (FS131-KPD1, item 762), the declared form only as a fallback priced over a week, which comes to me (and an axiom added to the library is reported to Kooshi before it is declared); alternative, declare D2 now from `[Rudin1962]` — declined: W2, "when unsure, formalize", and the counter-priors on Lean cost; and a shorter route is in sight (below); high. **A route I saw while reading, labelled mine and unchecked, for the planner:** the one use (record § 2.3: "PE-1′'s total irreducibility needs it at `N = Y^⊥ = 0`") is "a closed subgroup `Y` of `Ĝ` with `Y^⊥ = 0` is all of `Ĝ`"; for discrete `G` a basic neighbourhood reads finitely many points, so restricting to the finitely generated `N = ⟨g₁, …, g_k⟩` (onto `N̂` since the circle is divisible) reduces it to closed subgroups of a torus times a finite group, where annihilators are Kronecker's theorem — no Haar measure, no `L²`, no Peter–Weyl. (3) *Tate's self-duality and strong approximation (M8b's inputs, prior-art debts):* priced by M8b's planner on record § Stage 4's vocabulary; bibliography rows (`[Tate1950]` or `[Weil1967]`) when a job reads one; not now; high. (4) *Lane A, `exists_admissiblePair` over every real number field:* a planner-and-implementer job in the queue; for its brief, a note of mine, unchecked: one completely split prime needs no Chebotarev — for `f` the minimal polynomial of a primitive element of the Galois closure, a prime dividing some `f(n)` and not the discriminant has a degree-one prime above it, hence (Galois) splits completely, and Schur's argument gives infinitely many such primes; medium. (5) *`Rigidity.entropySplit` sits in `ChainAtTA`, upstream of M7b:* owed to the chain's landing — the leaf moves downstream of `EntropySplitMax` with its statement unchanged, or the headline is assembled downstream (an import cycle otherwise); high. (6) *Its generalizations* (step 2 for any group action; the pigeonhole's `α′`; Herglotz–Bochner idle at countable `G`, item 757): filed as its dated lines. (7) *The three statements false as first typed:* credit for catching them before any commit; no workflow change. **Filed:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its `LEAN.md` lines (record §§ 3.5, 5.2) and the `[Rudin1962]` reading-status line (§§ 1.5, 2.1 cited, recalled, not read). **The queue's order, re-ruled:** the chain's PD planner takes this slot ahead of the density equality's lanes C and D; alternative, the density lanes now (interleaving) — declined: their landing waits on the port (about four lanes, 12–18 hours by its plan), so they have slack, while PD is on the chain's longest path; medium-high; the density lanes take the next free slot.
> — source: plans/FS131-close-inventory.md

Where everything is, in your tree: the last planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN8-chain-split.md` (§ 2.3: D1 and D2 as it found them, its route for
D1 and its sizing of D2; § 2.5: the plan per leaf, including the leaves of `Rigidity/Pieces` that wait on this lane; §
5.1: the lanes), the dual's module `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/DualGroup.lean` (the topology, compactness, Polishness, Fourier uniqueness, Haar), and the
pieces' module `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/Pieces.lean` (PE-1′ and the leaves that read duality). The derivation's use: `plans/FS100-X02D-derivation.md`
(HX-1's step 1 and PE-1′).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the exact statements the chain reads
   of D1 and D2 restated — every use, by file and declaration, with what each use needs at its site (the general
   theorem, or only the case the last planner named: a closed subgroup with zero annihilator is everything).
2. **The statements typed** (a saved stage): D1 and the form of D2 the chain reads, for a countable discrete abelian
   group with the dual's existing topology, in new modules, with `sorry` at the leaves only, each read aloud against
   the use and against a textbook statement (say which, and how much of it you read), each with a model. If the general
   D2 is cheaper than the case, say why.
3. **The route, chosen by measurement** (a saved stage): the reduction to finitely generated subgroups and tori named
   in ruling 2, against the Haar-measure route, each priced from its first leaves, not from a table; Mathlib's
   coverage at the pin of each route's pieces (tori, closed subgroups of `ℝⁿ` or of a torus, Kronecker's theorem,
   characters of finitely generated abelian groups), checked by name.
4. **A plan per leaf** an implementer can follow, and the lanes, sharing no file. **Run the domain pass as a fresh
   skill invocation on every new definition, and the obligation pass on every new statement.**
5. **The price** in agent-days, from item 3. If over a week: the fallback's four items of `LEAN.md` § Assumptions
   drafted (not declared), and a message to me first.
6. **Drafts**: dated lines for the claim list; bibliography lines for every textbook you read or cite.
7. The report in the standing rules' form.

## What is yours to decide

How the statements are cut and where the modules live; which route; whether Tate's self-duality of the adeles (the
zero-entropy side's model, the last planner's § Stage 4) shares your route, in words, if you reach it. Not yours: a
declared axiom; a change to a typed statement of another module without my ruling; proving leaves beyond a few lines
while testing a route; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is the last planner's, current with your branch's parent: build on it. One file
through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kpd1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kpd1/`.
Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
