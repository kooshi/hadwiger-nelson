# Brief FS131-IU1 — 12 leaves of one file: a plane over a real number field maps homomorphically onto its residue target at every stable prime, at every level — and what follows: the bound by the local bound, the two-colour case, the converse half

*Written 2026-10-13 17:50 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IU1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of one file of the first number-field module — replace every `sorry` in it with a proof, changing no statement; print the axioms of its headline theorems; build once at the end; draft what the landing will need
  launch: now, in a tree of your own; the other file of the module has its own implementer (FS131-IQ1, on `Arith/QuadraticPrime.lean` in another tree); a landing of another module is in flight in a third tree and two planners work in others — the build slot is shared, and you will wait for it at times
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); for a library or Mathlib lemma the plan names that does not exist as named; and with one line when the file has no `sorry` and its headlines print their axioms; the report goes to `data/fs131/reports/FS131-IU1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IU1-implementation.md` (new, on your branch)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` (branch `fs131-wnf`, at `223241b0a`): `Proofs/HadwigerNelson/Arith/UpperHalf.lean` — proofs and private helper lemmas only, **no statement of the skeleton changes** — and nothing else under `Proofs/`; `plans/FS131-IU1-implementation.md`; `data/fs131/iu1/`; `data/fs131/reports/FS131-IU1.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback and after every two or three leaves; re-price a long leaf from its first child and say the price in your record; hand back at a saved stage before you would guess 500k, with the leaves done and left by name

Hello. This is the first implementation job of the restart, on a skeleton a planner of this lane finished an hour
ago. Its plan is unusually complete: every leaf has a route, the names it cites were checked by a probe, and it found
and repaired a false statement before anyone tried to prove it.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The results about planes over number fields come first, and nearly all of them stand on one short piece of
mathematics that the kernel held only in part: a plane over a real number field maps homomorphically onto its residue target at every stable prime, at every level — and what follows: the bound by the local bound, the two-colour case, the converse half. Thirteen ledger rows wait on its consequences; it
discharges a named hypothesis under the project's best number-field theorem; and with its sibling file it closes exact
values at once — the plane over the field of the square root of 11 needs exactly four colours, among them. Until these
leaves are proved, those values print `sorryAx`.

## The statements

The claims this file answers, from the claim list fixed before the skeleton was planned, with its two dated lines (a
statement corrected by a counterexample, and three widened):

> NF1-S1A: For a real number field `F` and `𝔭` with `Arith.IsUsablePrime 𝔭`: `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))`; and `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-S1B: For a real number field `F` and `P : SpectralChain.StablePrime F`: a graph homomorphism from the unit-distance graph on `planeOver F` into `SpectralChain.levelTarget P 1`; so `χ(planeOver F) ≤ SpectralChain.localBound F`. Converse half for row 105: a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime.
> — source: data/fs131/claims-NF1.md § Statements

> - 2026-10-13 16:36 UTC — **NF1-S2's second sentence is false as written; found by the module's planner (FS131-KN2) while typing it; its counterexample checked by me.** Its words: "Read with more than one radicand divisible by p it is false. Counterexample: F = Q(sqrt 11, sqrt 22), p = 11. Both radicands are squarefree and are 0 = 0^2 mod 11, so 'every radicand is a square' holds; but F = Q(sqrt 11, sqrt 2) and 2 is not a square mod 11 (the squares are 1, 3, 4, 5, 9), so 11 is inert in Q(sqrt 2) and every prime of F above 11 has residue field of 121 elements: no maximal ideal with 11. The missing hypothesis: at most one radicand is divisible by p, and p^2 does not divide it. '11 in K' is that case and is true." **The statement stands with that hypothesis**: the other radicands nonzero squares modulo p, at most one radicand divisible by p, and p² not dividing it.
> — source: data/fs131/claims-NF1.md

> - 2026-10-13 16:36 UTC — **Three statements widened by the same planner, each kept beside the claim's own form as a corollary** (its words): NF1-S1A — "both clauses follow in four lines from Arith.placeHom_base and Arith.exists_hom_of_isPlaceHom, and are proved in the skeleton, no sorry"; NF1-S1B — "the homomorphism … exists into levelTarget P m at every level m >= 1, by the same argument", with the bound at every level; NF1-S2's first sentence — "needs neither 'squarefree' nor 'd > 1': for any natural d and odd prime p with d a nonzero square mod p, Q(sqrt d) in R has a maximal ideal of its integers with p elements in the quotient — and the same for any finite set of such radicands". A further leaf it names: a number-field instance for the field of a finite set of radicands, which the library lacks.
> — source: data/fs131/claims-NF1.md

**The leaves, by name, as the skeleton has them** — `Proofs/HadwigerNelson/Arith/UpperHalf.lean` in your tree, 12 of them:
`mem_localRing`, `conj_mem_localRing`, `isUnit_mk_pow`, `residue_div`, `residue_conj`, `coe_mem_nonunits_localRing_iff`, `localRing_ne_top`, `exists_hom_levelTarget`, `two_mem_of_conj_trivial`, `colorable_two_planeOver_of_ramified`, `exists_stablePrime_of_valuationSubring`, `inv_natCast_mem_unitRingOver_iff_forall_stablePrime`. Their statements are the file's and are not restated here: read them in the
source, and read each back against the plan before you prove it.

**The plan**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KN2-upper-half-plan.md` — § Stage 4 has a plan per leaf (the route in steps, the lemmas by full name as the planner
found them, what it tried that failed); § D has the split between the two files and what the landing needs; § Stage 2
has the read-back of each statement and the three changes its modeling pass made. Its probes, which print every cited
name under the module's imports, are under `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/kn2/probes/`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against the claim list; every leaf's statement read in the
   source and restated in one line in your record with the plan's route beside it; a leaf whose statement and plan
   disagree is a message before you start it.
2. **The leaves**, in the plan's order, each proved without changing a statement. A helper lemma you need is private
   to the file unless the plan names it. A leaf that resists after two honest routes is left as `sorry` with a comment
   holding what you have — the helper statements, the route, where it stops — and reported by name: that is a good
   stage, not a failure.
3. **No statement changed**, shown: the stored types of the file's declarations compared with the skeleton's at
   `223241b0a` from the kernel's side (the last implementers' comparison scripts are the pattern:
   `data/fs136/i1/` on branch `fs136-wk1`, or write your own with a planted fault watched firing).
4. **The axioms** of the file's headline theorems printed from a check file: the standard three and nothing else —
   or `sorryAx` named with the leaf it comes from.
5. **One build at the end**, under the slot, zero warnings from your file (the unused-variable and unused-instance
   linters run there; the plan says where an `omit` is already in place).
6. **Drafts for the landing**, in your record: the audit block's records for this file (every declaration a person
   typed), an inhabitant or model named for each hypothesis of the headlines, and anything a reader of the statements
   should be told that the docstrings do not say.
7. The report in the standing rules' form. Leave no background process running.

## What is yours to decide

The proofs; private helpers; the order within the plan's dependency order; whether a leaf is better proved in a more
general form privately. If a statement can be strengthened at no cost, tell me and keep the skeleton's form — the
planner fixed these and another file reads them.

Not yours: any statement; the other file; the instances file; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not
apply.** Measured today by the planner of this module: one file through `lake env lean` costs 2 to 3 seconds and
3.6 GB once the imports are read; a build is 24 minutes at `BATCH=2` and 6.5 minutes at `BATCH=8`, almost all of it
Lake starting once per batch, with 4.5 GB at its peak. **So: write against `lake env lean`, and build once.** Do not
edit a module file while a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name iu1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2`, from inside your worktree
(the planner's script `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/kn2/lean1.sh` does exactly this and times it). The build:
`--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside your worktree; never `lake build`. Others
build too: on exit 75 wait and retry — a landing's gate steps can hold the slot for a long time, so keep proving
against `lake env lean` meanwhile. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/iu1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
