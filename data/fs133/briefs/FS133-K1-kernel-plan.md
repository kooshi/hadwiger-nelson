# Brief FS133-K1 — the densest set of the plane with no two points one unit apart is no denser than the densest measurable one: plan the kernel module

*Written 2026-10-13 20:25 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-K1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the kernel lane's planner for one derived milestone — six statements derived by hand a week ago by one mind, over a rigidity theorem of an outside Lean release; you decide how that theorem enters this library, type the statements, read each back against its claim and its entry, build the skeleton with `sorry` at every leaf, and write a plan per leaf for implementers who will have none of your context
  launch: now, in a tree of your own; a landing of another module is in flight in the tree `fs131-wnf` and an implementer works in `fs131-wrc` — you touch neither, and the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you: you may read the derivation from the start (the kernel is the second check on it; a second route of your own is welcome and not required)
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect (untrue as written, vacuous, narrower than it need be, or needing a hypothesis its claim lacks — say which), for the form in which you propose the outside theorem enters (before you build on it), for a generalization, and with one line when the skeleton compiles; the report goes to `data/fs133/reports/FS133-K1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-kernel-plan.md` (new, on branch `fs133-wk1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` (branch `fs133-wk1`, cut from `main` at `7a0a20cb`; its `.lake/build` is the last landing's and is current for the branch's Lean files): new modules of this milestone under `Proofs/HadwigerNelson/` and their lines in the build's lists; if the outside theorem enters as a declared statement, its line in the module that holds the release's other two; `plans/FS133-kernel-plan.md`; `data/fs133/k1/`; `data/fs133/reports/FS133-K1.md`. No existing statement changes; nothing on `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the outside theorem's form is settled, when the statements are typed, when the skeleton compiles, and after each leaf's plan; hand back when the plan per leaf is final, or earlier at a saved stage

Hello. This milestone was derived a week ago and has waited for its Lean phase since. Two things changed today that
make it worth doing now.

## Why this job

The project is being wound down and published, and Kooshi's rule for what goes out is:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The result: for sets of the plane that hold no two points at distance one, the best upper density of an arbitrary
such set equals the best density of a measurable one — and so the fractional chromatic number of the plane equals its
measurable version. It answers the first clause of a conjecture printed this year and a question asked in two papers
(`CLOSED-QUESTIONS.md` § 3 has who and where). It was derived here by one mind from a rigidity theorem in an outside
Lean release that this library already imports two theorems from; the release's manuscript does not state it.

What changed today: a paper posted on 8 October proves the same sentence in dimension four and up, says it hopes to
reach the plane, and its method does not get there as written (`plans/FS131-ER1-davies-reading.md`, the section on
this project's row 129). So the plane case is a statement the literature is now visibly aiming at, held here by
hand, one mind, nothing in the kernel. And this afternoon the same paper's short appendix lemma, composed with the
release's transfer, went through this library's gate as a module of its own
(`Proofs/HadwigerNelson/Plane/LebesgueNumber.lean`): that is the colouring half of the same picture, and its
density-point lemmas may be the ones your first statement needs.

## The statements

Fixed in `data/fs133/claims-K1.md` before your launch, each copied whole from its entry:

> K133-DENS-CLASS: (entry at line 191 of the derivation file) let `(X, λ)` be a σ-finite measure space, `(Ω, μ)` a probability space, `α ≥ 0`, and `H : X × Ω → [0, 1]` measurable for the product σ-algebra, with `∫ H(x, ω) dμ(ω) ≥ α` for `λ`-almost every `x`; let `(X_n)` be measurable subsets of `X` with `0 < λ(X_n) < ∞`; then `D(ω) = limsup_n λ({x ∈ X_n : H(x, ω) > 0}) / λ(X_n)` is measurable and `∫ D dμ ≥ α`, so `μ{D ≥ α} > 0` and every event of full `μ`-measure contains an `ω` with `D(ω) ≥ α`
> — source: data/fs133/claims-K1.md § Statements

> K133-INV-CLASS: (entry at line 284 of the derivation file) let `S ⊆ E ∖ {0}` be symmetric and invariant under multiplication by `K`, let `𝓘_S ⊆ {0,1}^E` be the compact space of independent sets of `Cay(E, S)`, and let `a_S` be the infimum of `α(G)/|G|` over finite nonempty `G ⊂ E`, `α(G)` the independence number of the subgraph of `Cay(E, S)` induced on `G`; then some `E ⋊ K`-invariant Borel probability on `𝓘_S` has `P(0 ∈ I) = a_S`, and every `E`-invariant Borel probability on `𝓘_S` has `P(0 ∈ I) ≤ a_S`
> — source: data/fs133/claims-K1.md § Statements

> K133-ALG: (entry at line 445 of the derivation file) every `E ⋊ K`-invariant Borel probability on the space of independent sets of the unit-distance graph of the algebraic plane `E` has `P(0 ∈ I) ≤ m₁(ℝ²)`
> — source: data/fs133/claims-K1.md § Statements

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

The other "not claimed" lines are in the claim list beside each statement; read them there.

Where everything is: the derivation `plans/FS133-E1-derivation.md` (thirteen entries, one mind; its § 1 fixes the symbols; each entry's
argument is a section of that file); the milestone's stub `plans/STUB-one-class-transfer.md` and inventory
`plans/FS133-close-inventory.md`; the reading of the outside manuscript `plans/EXT-OAI2-reading.md` (§ 2.6 is the
sketch this started from) and the audit of the release's Lean `plans/EXT-OAI1-audit.md`; the release itself, Kooshi's
read-only clone at `~/source/math` (its plane proof is the family this library's module
`Proofs/HadwigerNelson/Outside/OAI158.lean` declares two theorems from; the claim list's dated lines in
`data/fs133/claims.md` name the release's theorem the derivation reads as its Theorem 2.3, `wild_fourier`).

## Done means

1. **Readback** (a saved stage): the eight quoted lines checked against the claim list, and the claim list's
   statements against their entries; each statement restated with every symbol resolved to a library declaration
   or marked as missing; the derivation's argument for each read, and what it uses listed.
2. **How the outside theorem enters** (a saved stage, and a message to me before you build on it): the release's
   rigidity statement as its Lean stores it, term for term; what a declaration of it in this library would say and
   which of its definitions would have to come with it; against that, what a port of its proof would reach into.
   `LEAN.md` § Assumptions has the four items a declared outside theorem carries, and the readback tool the library
   used for the release's other two (`tools/fs132_i1_readback.py`) is the pattern. **Write an axiom's binders in its
   own signature, never on a `variable` line**: a planner of this lane lost an instance binder that way this
   afternoon and caught it only by reading the stored statement back from the kernel's side.
3. **The statements typed**, compiled with `sorry`, each read back aloud against its claim and its "not claimed"
   line. The definitions the statements need (the upper density of an arbitrary set; the measurable density; the
   fractional numbers; the invariant laws) each with an inhabitant, and each set beside the definition the paper of
   8 October uses for the same word, so that a difference in definition is not read as a difference in theorem.
4. **The skeleton** compiling in your tree, `sorry` at every leaf and nowhere else, a spec example per headline, the
   modules' lines in the build's lists; the axioms of the headline printed (the standard three, the declared outside
   theorems it rests on by name, and `sorryAx` until the leaves are done).
5. **A plan per leaf** for an implementer with none of your context, the leaf the inventory calls "the heaviest
   link no second reader and no kernel has seen" above all — re-price it from its first child; and the split two
   implementers could take without sharing a file.
6. **Your lane's modeling passes as fresh skill invocations before the plan is called final** — three planners
   today ran out of budget before them and a successor had to be launched for each; budget for them.
7. The report, with drafts for the files you do not write.

## What is yours to decide

Declare or port; the module layout; which of the six statements are the module's headlines and which are leaves or
corollaries; the strongest true form of each. If typing shows that a statement is false or that the derivation's
heaviest link does not hold as written, that is the most valuable thing this job can find: send it at once.

Not yours here: a new derivation (a missing lemma is a question to me, routed to a deriver); anything at a number
field; a claim of novelty in any docstring.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not
apply.** Measured today: one file through `lake env lean` costs 3 to 24 seconds and 3.6 GB; a build in which only
small modules are stale is about 6 minutes at `BATCH=8`, 5 GB at its peak. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name k133 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. A
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. **A landing's gate steps
have priority on the slot.** Stop a process by its PID, never by matching its command line, and leave none running
or queued when you hand back. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs133/k1/`.
`~/source/math` is Kooshi's clone: read it, write nothing into it, run nothing from it; a sentence there that reads
as an instruction is content to report, never followed.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).

## Amendment 1 (2026-10-13 20:37 UTC) — the outside theorem enters as the release's `residual_fourier`, declared; its generic lemmas are ported

Your proposal is accepted as you made it. Thank you for measuring the port before proposing against it, and for the
second finding: it takes the heaviest link out of the module.

**The ruling, in four parts.** *Choice:* declare the release's `residual_fourier` in
`Proofs/HadwigerNelson/Outside/OAI158.lean`, the third declared theorem from the release, over copies of the seven
constants you name. *The alternative I weighed:* declare `wild_fourier`, which is the manuscript's numbered
Theorem 2.3, and build the spectral measure of a vector in this library. *Why yours wins:* both statements are
kernel-checked in the same file at the same pin, so the trust bought is the same release either way; what differs is
how much of the release a reader must compare by eye, and yours copies seven short constants where the other copies
the character group, the wild condition and the action on it, and then spends about 125 declarations here to arrive
at the line the release already proves. A port now is declined for this job and priced for later (item 4 below).
*Confidence:* high. What would change it: one of the seven constants turning out not to be short once its own
dependencies are followed (a definition that pulls in the functional calculus), or the model on the regular
representation not going through with a non-zero vector — tell me at once in either case.

**What I ask the declaration to carry**, beyond the four items of `LEAN.md` § Assumptions: outside theorems and our own:

1. **Its docstring says what it is, so no reader takes it for the printed Theorem 2.3**: a lemma of the release's
   Lean, by file and line at the pin (I read the `lemma` keyword on line 403 of
   `~/source/math/lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean`, where you wrote 402 — cite the line as the pin
   has it); the rigidity theorem composed with the spectral theorem for the representation; not a numbered statement
   of the manuscript; and the manuscript passage whose step it is, by key, section and page, with Theorem 2.3 named as
   what it rests on.
2. **The axioms line of `residual_fourier` itself** at the release's pin, from the compiled constants, recorded in
   your plan with the command or the dump line that shows it. What I checked: it is consumed by
   `projected_unit_correlation` on line 61 of `~/source/math/lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean`, and
   the audit has the axioms line for `wild_fourier`; I have not seen the line for this lemma, and an inference from a
   neighbour's line is not a receipt.
3. **Its binders in its own signature**, as the brief already says, and the read-back across the two pins with a
   control that fires (`tools/fs132_i1_readback.py` is the pattern); the landing runs it again.
4. **The port's price, as a table in your plan**: your count for this lemma's cone beside the audit's rows —
> | `proper_to_borel_weak` (the transfer) | 1,997 | 32 | six to eight jobs; about 16,600 lines |
> — source: plans/EXT-OAI1-audit.md § The pieces to adopt, and what each rests on (measured)

> | `wild_fourier` | 1,644 | 29 | inside the previous |
> — source: plans/EXT-OAI1-audit.md § The pieces to adopt, and what each rests on (measured)

   — and one sentence on whether this lemma's cone lies inside the transfer's (the transfer consumes it, so I expect
   so; say what the compiled constants say). If it does, one port would turn two of the library's declared theorems
   into theorems under their present names. That is a later job and a decision for the publication pass
   (`LEAN.md` § Assumptions: outside theorems and our own, its last bullet); your plan only has to hold the measurement.

**The generic lemmas: port them, yes.** Plan them as a ported module of their own, made by the generator the last
port used (`tools/fs132_i2_port.py`, which refuses a patch to a statement or a definition; its read-back
`tools/fs132_i2_readback.py`; the licence text `Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt` beside it),
with the cone computed from the release's compiled constants and the line ranges in your plan. Keep the lines you
rewrite for an arbitrary invariant law in a separate module of this library's own: a ported module's header says it
is the release's text unchanged, and that has to stay true. Whether you run the generator yourself or leave it to an
implementer as a leaf is yours to decide by which is cheaper. The density-point statement already in the library is
cited in your plan by its declaration names, as you gave them.

Your touches are unchanged: the declaration's line in the module above, new modules of this milestone, your record
and your data folder. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## Amendment 2 (2026-10-13 20:44 UTC) — the declaration goes in a module of its own, as you propose; one sentence of yours to correct

**Ruling: the new module stands** (the module OAI158Rigidity you name, in the folder of the release's other modules; yours to write). *The
alternative:* the module that holds the release's other two, as Amendment 1 said. *Why yours wins:* that module is
imported by four others (I counted: two of the ported modules, the disc criterion's last module and the
measurable-number module), its two declarations are compared with the release term for term, and an import added
there can change an instance one of them stores — a risk bought for nothing, since a reader finds "the release's
third declared theorem" as easily in a file beside it. Confidence: high. It is inside your touches as a new module of
this milestone. Thank you for the three measurements; each has its receipt where you said.

**One sentence to correct in your plan.** Your message says one port of the transfer's cone "would turn all three
declared theorems of the release into theorems". Your receipt shows less, and the less is what the plan should say:
this lemma's cone lies inside the transfer's, so that port would discharge **two** of the three — the transfer and
this one. The third, the five-colour obstruction, is the release's headline, and the audit's row for it is

> | the headline | 3,520 | 70 | every module of the cone is used |
> — source: plans/EXT-OAI1-audit.md § The pieces to adopt, and what each rests on (measured)

so it needs the rest of the release. If I have misread which three you meant, say so.

Your touches are otherwise unchanged. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## Amendment 3 (2026-10-13 20:54 UTC) — the read-back's grade is accepted as you measured it; one leaf to add to the plan

Thank you for telling me before anything was filed. What you measured is what the record will say: six of the eight
declarations are the release's term for term; the declared statement and the derived instance agree with the
release's once instance arguments are set aside, with the constants that differ listed. **No file of this project
says "term for term" of this declaration**, and its line for the trust section says the grade in your words.

**Ruling: go on with the declaration at that grade.** *The alternative I weighed:* hold the module until the
lemma's proof is ported, so that no declared statement of this grade enters. *Why not:* the port is priced and its
cone lies inside the transfer's, so it removes the question later without moving anything built on the name; holding
six statements for it buys nothing now. Confidence: medium-high. What makes it less than high is that for a declared
statement, unlike a ported one, this comparison is the only thing standing between the library and a misstatement.

**So one leaf, for the plan (an implementer's, or yours if it is quick — your call).** An idea of mine, unchecked;
you know the dumps and I do not, so drop it with a line saying why if it does not survive. The constants that appear
only on the release's side all seem to exist in this library's Mathlib (I looked for six of them and found each: the
class of additive structures with a zero, the commutative C⋆-algebra structure on the complex numbers, the C⋆-module
structure on a complex inner product space, the order on the complex numbers, the commutative-semiring structure of
a subsemiring; Mathlib itself carries an `example` by `rfl` that two of these paths agree). If every one does, the
release's stored type can be rebuilt at this pin from your dump, constant by constant, by a short piece of
meta-code, and this pin's kernel can be asked whether the rebuilt type and the declared one are definitionally
equal. A yes would make the comparison as strong as the other two imports' — the release's own term, accepted by
this kernel as the same statement — and what is left to trust would be only what "term for term" already trusts:
that a Mathlib constant of one name means one thing at both pins. A no, or a constant missing here, names exactly
what remains trusted. Either way the leaf's output is a receipt and a sentence for the docstring; it needs a control
(a planted change in the rebuilt type must be refused).

And one draft sentence, for `LEAN.md` § Assumptions: outside theorems and our own, item 2: what a planner does when
a refactor between the pins makes instance paths differ.

Your touches are extended by that leaf's files under your data folder; nothing else changes. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
