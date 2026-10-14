# Brief FS133-IB1 — the invariant laws and the section density: fourteen leaves of the density equality's module, the two compactness leaves first

*Written 2026-10-14 02:41 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-IB1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: an implementer on a planned module of eight files, after the one who took its outside side — you take two files of its lane on measure and laws: the existence of an invariant law on the edge-free sets of a graph with the bound it gives, and the density of a random measurable set's sections; fourteen leaves, the two the plan calls risky first
  launch: now, in the tree the module's first implementer handed back an hour ago, on a new branch cut from its head; a planner works on another chain in `fs131-wch` and a planner-prover on another line in `fs131-wrc`; no landing is in flight; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf's route in the plan does not go through and you take another (say which), and with one line when the two compactness leaves are proved; the report goes to `data/fs133/reports/FS133-IB1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-IB1-implementation.md` (new, on branch `fs133-wb1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` on a **new branch `fs133-wb1`** that you cut from its head (`1dd2b4acd`, the first implementer's; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` and `Proofs/HadwigerNelson/Plane/OneClass/SectionDensity.lean` — **proofs and private helpers only, no statement changes**; one dated section appended to `plans/FS133-kernel-plan.md` (§ Done means item 6); `plans/FS133-IB1-implementation.md`; `data/fs133/ib1/`; `data/fs133/reports/FS133-IB1.md`. Nothing on `main`; nothing in the other six files of the module (the third file of this lane, `Defs`, is another implementer's)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This module's first implementer handed back an hour ago with the lane the plan called riskiest done: the
release's generic lemmas ported, the field theorem proved over them, and the declared outside theorem's statement
shown, by this library's own kernel, to be the release's. You take the next lane.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The finding is that the largest density of a set in the plane with no two points at distance one is the same whether
the set is arbitrary or measurable — ours by hand only, one mind, a week old. Its kernel module is planned to the
leaf. Your two files hold the two statements that everything on the plane's side is assembled from: that a graph on
the algebraic plane with a symmetric rotation-invariant set of steps carries an invariant law on its independent
sets whose weight at the origin is the infimum of the finite ratios, and that a random measurable set whose points
are each covered with probability at least α has sections of positive density with positive probability. Until they
are proved, every headline of the module prints an unproved dependency.

## The statements

The two claims your files answer, and what they do not claim, from the claim list fixed before the module was
planned (its dated line says where the planner typed them wider):

> K133-INV-CLASS: (entry at line 284 of the derivation file) let `S ⊆ E ∖ {0}` be symmetric and invariant under multiplication by `K`, let `𝓘_S ⊆ {0,1}^E` be the compact space of independent sets of `Cay(E, S)`, and let `a_S` be the infimum of `α(G)/|G|` over finite nonempty `G ⊂ E`, `α(G)` the independence number of the subgraph of `Cay(E, S)` induced on `G`; then some `E ⋊ K`-invariant Borel probability on `𝓘_S` has `P(0 ∈ I) = a_S`, and every `E`-invariant Borel probability on `𝓘_S` has `P(0 ∈ I) ≤ a_S`
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-INV-CLASS: that the invariant law is ergodic, or unique; that a single independent set of `E` has density `a_S` in any sense; anything with the infimum taken over finite subsets of `ℝ²` (that infimum is smaller or equal, and its equality with `a_S` at the unit distance is `C133-ONE`'s, by another route); necessity of amenability
> — source: data/fs133/claims-K1.md § Not claimed

> K133-DENS-CLASS: (entry at line 191 of the derivation file) let `(X, λ)` be a σ-finite measure space, `(Ω, μ)` a probability space, `α ≥ 0`, and `H : X × Ω → [0, 1]` measurable for the product σ-algebra, with `∫ H(x, ω) dμ(ω) ≥ α` for `λ`-almost every `x`; let `(X_n)` be measurable subsets of `X` with `0 < λ(X_n) < ∞`; then `D(ω) = limsup_n λ({x ∈ X_n : H(x, ω) > 0}) / λ(X_n)` is measurable and `∫ D dμ ≥ α`, so `μ{D ≥ α} > 0` and every event of full `μ`-measure contains an `ω` with `D(ω) ≥ α`
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-DENS-CLASS: that almost every `ω` has `D(ω) ≥ α` — in the mixture of § Argument for C133-DENS (c) half of them have `D = 0`; nor the same with `liminf` in place of `limsup` — false for the alternating annuli (control `dens-direction`); nor that the window averages converge — no stationarity is assumed
> — source: data/fs133/claims-K1.md § Not claimed

**Your fourteen leaves**, by the plan's letters: **I1–I7** in `InvariantLaw` (the plan's I3 and I4 are the two
compactness leaves: an invariant law for the shifts from a Følner sequence, and a common fixed point for the
rotations with no fixed-point theorem imported) and **D1–D5** in `SectionDensity`, with the children the plan names.
Their statements are the files'; read them in the source. **The plan per leaf**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-kernel-plan.md` § 5.2 (lane B), with § 5.0
(the split), § 5.5 (what each headline's axioms must read: everything in your two files rests on the standard three
and must not print the declared outside theorem) and § 6 (what the modeling passes changed). The first implementer's
record `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IA1-implementation.md` ends with what it learned that the plan does not say; two of its notes are for you: since two import
lines were added to the declared theorem's module, **a comparison of your statements before and after must be made
against this branch's tree, not the planner's**, and one statement of your lane (`Plane.isIndepSet_ball_half`) is
stored on another instance path than at the planner's head — in instance arguments only.

## Done means

1. **Readback** (a saved stage): the five quoted lines checked against their sources; each leaf's statement
   restated in one line beside the plan's route; the stored statements of your two files dumped from the built tree
   before any edit.
2. **I3 and I4 first** (a saved stage each). Send me the one line when both are proved, or the exact step where one
   stops.
3. **The other twelve leaves**, without changing a statement; re-price what is left from the first two you finish
   and say so in your record.
4. **No statement changed**, shown from the kernel's side for your two files against the dump of item 1 (a planted
   change watched firing); no `sorry` left in them; one build under the slot with no warning from them; the axioms
   of every public declaration of the two files printed from the built tree — the standard three and nothing else,
   with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files and the model for each hypothesis.
6. One small filing on your branch: the first implementer's draft D4 — a dated note correcting the cause the plan
   gives for the declared statement's read-back — appended to the plan word for word where the draft says it goes.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the order after the two compactness leaves; another route for a leaf where the plan's
does not go through (tell me which). Not yours: any statement; the third file of this lane; the other lanes; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build with only small modules stale takes 6 to 10 minutes; one such build at `BATCH=8` peaked
at 12.3 GB summed over its processes. Write against `lake env lean` and build rarely; do not edit a module file while
a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ib1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 12 --cpus 4 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh` from inside the worktree; never `lake build`.
Two other jobs build from time to time: on exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs133/ib1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
