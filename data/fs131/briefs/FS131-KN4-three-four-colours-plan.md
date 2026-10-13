# Brief FS131-KN4 — three and four colours over real number fields, with no hypothesis: which planes over real quadratic fields need four colours, and when a number field's plane needs exactly three — the leaf list, the statements typed, a skeleton, a plan per leaf

*Written 2026-10-13 17:33 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KN4
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the kernel lane's planner for the second module of the number-field results — make the leaf list the morning's map left as "unsized, derivation files named", type the statements, read each back against its claim and its derivation entry, build the skeleton with `sorry` at every leaf, and write a plan per leaf for implementers who will have none of your context
  launch: now, in a tree of your own; three other trees hold other modules of the same restart (`fs131-wnf`: the residue upper half, whose theorems your equalities will cite; `fs131-wkc`; `fs131-wch`) — you write in none of them; nothing is landing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect (untrue as written, vacuous, narrower than it need be, or needing a hypothesis its claim lacks — say which), for an attribution the record states two ways, for a generalization you see while typing, and with one line when the skeleton compiles; the report goes to `data/fs131/reports/FS131-KN4.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KN4-three-four-colours-plan.md` (new, on branch `fs131-wr2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2` (branch `fs131-wr2`, cut from `main` at `7c446b07`; **the tree is a retired landing's, moved: its `.lake/build` is older than the branch by two landings of modules under `Proofs/HadwigerNelson/Plane/` that nothing here imports, so iteration works as it stands and your first build compiles those**): the new modules of this claim list under `Proofs/HadwigerNelson/` and their lines in the build's lists; `plans/FS131-KN4-three-four-colours-plan.md`; `data/fs131/kn4/`; `data/fs131/reports/FS131-KN4.md`. No existing module's statements; nothing on `main`; nothing in another tree
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the leaf list, when the statements are typed, when the skeleton compiles, and after each leaf's plan; hand back when the plan per leaf is final, or earlier at a saved stage

Hello. Four jobs of this lane ran today on the restart of the Lean backlog; this is the fifth, and by the order the
asking lane recommended it is the one the field gets first.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

This morning's ranking of the number-field findings put second — and first in the order to formalize — the one that
needs no hypothesis at all: the exact number of colours for the plane over a real quadratic field, through four, and
the criterion for exactly three over every real number field. It was asked twice in print by name; a paper posted
last week calls the upper bounds "known" and leaves the exact values; and the five-colour theorem that ranks first
names this one among its hypotheses in the kernel. One instance is kernel-checked already (the field of the square
root of 11). The general statements are by hand: two independent derivations for one, three for the other.

The morning's map (`plans/FS131-KN1-number-field-kernel-map.md`) gave these rows an entry each and three shared leaves, and said plainly that it had not
made their leaf list: "unsized". Making it is the first half of your job. The ranking's entry for this finding
(`plans/POROS-2026-10-13-number-field-findings.md` § 3.3, rank 2) says what a reader would look for and what they would object to first.

## The statements

Fixed in `data/fs131/claims-NF4.md` before your launch, by script:

> NF4-THEOREM: *The theorem.* (a) For every squarefree `m ≡ 11 (mod 12)`, `χ(ℚ(√m)²) ⩾ 4`. So, with the printed values: `χ(ℚ(√m)²) = 2` for `m ≢ 3 (mod 4)`; `3` for `m ≡ 3, 7 (mod 12)`; `4` for `m ≡ 11 (mod 12)` outside the classes `47, 143, 167 (mod 168)`; and at least 4 in those. (b) For every real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`. (c) For any subfield `F` of `ℝ`: if `1/3` is an integer combination of unit vectors and `F²` has an odd cycle, then `χ(F²) ⩾ 4`.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

> NF4-ENTRIES: *Entry.* (a), (c): `plans/FS81-derivation.md` T1–T7. (b): `plans/FS91-derivation.md` FS91-J02-T2, J02-T3, J09-J4.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

> NF4-RESTS: *What it rests on.* By hand: row 82 "two independent derivations", row 99 "S1 three derivations". Kernel-checked already: `m = 11` on the standard three axioms (row 73) — which alone answers Johnson 2006's "does there exist" — and the forward half of the three-colour criterion (row 119). Conditional on nothing unprinted: row 99's route uses Weil's bound, row 82's uses none.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

> NF4-OBJECTION: *The first objection.* Attribution: the two-colour classification over every real number field and the three-colour one where `√3 ∈ F` are the outside model's (§ 2.1 item 6); the relation at `m ≡ 23 (mod 24)` and the values 2 and 3 are Fischer's and Johnson's; every upper bound is prior art — and at the level of a field the kernel does not hold it (row 57: "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring …"), so an "=" in the Lean statement needs that gap closed. Scope: (b) is for number fields; row 99 records where a wider reading fails.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

The rows, as the map has them:

> NF4-ROW-73: **Row 73 — `χ(ℚ(√11)²) ≥ 4`; with the plane at 7, `= 4`; five more fields `≥ 4` by certificate.** The lower bound kernel-checked; the others `[certified, tools]`. - K: `four_le_chromaticNumber_planeOver_eleven`, `four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem` (std3). `ARCHITECTURE.md`: "The upper bound χ ≤ 4 is `[Fischer1990]`'s and is not in the kernel." - Missing: **the exact value is two short leaves away.** `[S1a]`, and `[S2]` at `ℚ(√11)`, 7 (`11 ≡ 2² (mod 7)`); the four-colouring of `Γ₇` is already in the kernel (`finitePlane7_colorable_four`, `Instances/PlaneFreedom.lean:61`; also `GapSeven.gamma_proper`, by `decide +kernel`). - Reader after: "`χ(ℚ(√11)²) = 4`, kernel-checked, both halves" — the first exact value of a real quadratic field's plane in the kernel beside none today.
> — source: data/fs131/claims-NF4.md § The rows as the kernel map has them

> NF4-ROW-82: **Row 82 — `χ(F²) ≥ 4` whenever `1/3 ∈ ℤ[U_F]` and `F²` is not bipartite; so `χ(ℚ(√d)²) ≥ 4` for every squarefree `d ≡ 11 (mod 12)`.** `[hand, two independent derivations]`. - K: the surrounding facts — prime inversion `UnitRing.inv_natCast_mem_unitRingOver_iff`, the chain theorem in ring form `UnitRing.add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver`, the winding (row 79) — std3. The theorem: none. - Missing: `plans/FS81-derivation.md` T1 (:29), T2 (:39), T3 (:50), T4 (:66: "`1/3 ∈ ℤ[U_F]` and `Θ₃(F) ≠ ∅` make `F²` bipartite"), T5 (:82), then the family clause (`d ≡ 11 (mod 12)` gives `1/3 ∈ ℤ[U]`, by prime inversion, kernel). T2 is `[S6]`; T3–T4 are `[S7]` (torsion extraction). Unknown size. - Reader after: "every real quadratic field `ℚ(√d)`, `d ≡ 11 (mod 12)` squarefree, has a plane needing four colours, kernel-checked with no finite graph" — the family `[Johnson2000]` p. 176 poses as open.
> — source: data/fs131/claims-NF4.md § The rows as the kernel map has them

> NF4-ROW-99: **Row 99 — three colours obey the local–global conjecture over every real number field: `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`, and `χ(F²) = L(F)` whenever `L(F) ≤ 4`; `χ(ℚ(α,√7)²) = 4`.** `[hand (+ Weil, tools exact)]`; S1 three derivations, S2 two. - K: none of the theorem. It is the hypothesis `inline:Row99` (ours) of row 127's headline, in the form `localBound F ≤ 4 → localBound F ≤ χ(F²)`. - Missing, in order (statements quoted in `data/fs131/kn1/leaf-statements-99.txt`): 1. `[S1b]` the upper half at every stable prime (gives `χ ≤ L`). 2. the two-colour end: `F²` bipartite ⟹ a stable dyadic prime ramified in `F(i)/F` (GPT Astra's Thm 2.1, second derivation FS91-J02-A21p, `plans/FS91-derivation.md:266`); with (1) this is `L = 3 ⟹ χ ≥ 3`. 3. `[S6]` a three-colouring gives `θ ∈ Θ₃(R_F)`. 4. `[S7]` torsion extraction, FS91-J02-L1 (:171). 5. the finite ring `R/6R` and the joint image of the unit vectors: FS91-J02-L2 (:144), J02-L3 (:154), J07-5 (:159), with weak approximation on the norm-one torus, FS91-J10-L2 (:165). 6. norm-one functionals, FS91-J02-L4 (:175): at `q = 3^f` only `q = 3` (Weil above 243 — held as an import, at characteristic not 2 — and exact at 27, 243); at `Q = 2^f` none. 7. FS91-J02-T1 (:188), the torsion local–global theorem; FS91-J09-J4 (:192), no mixing. 8. FS91-J02-T2 (:214), S1; FS91-J02-T3 (:244), S2 — compositions. - Outside: Weil (held). Weak approximation: Mathlib at the pin has it for absolute values (`Mathlib/Analysis/AbsoluteValue/Equivalence.lean`, `NumberTheory/NumberField/InfinitePlace/Basic.lean` — found by searching "weak approximation"); the form on the norm-one torus at finite places is ours to derive from it. Not sized. - Reader today: "held by hand, three derivations." After: "`χ(F²) = L(F)` for every real number field with `L(F) ≤ 4`, kernel-checked on Weil's bound" — `[Fischer1990]` §1's question answered at three colours.
> — source: data/fs131/claims-NF4.md § The rows as the kernel map has them

The shared leaves they wait on:

> NF4-S6: A winding on the relation lattice of `Cay(R_F, U_F)` gives a character `θ` of `R_F` with `θ(U_F) ⊆ [1/3, 2/3]` (`plans/FS73-derivation.md` T22; `plans/FS81-derivation.md:39`).
> — source: data/fs131/claims-NF4.md § The shared leaves these rows wait on (the map's § X1)

> NF4-S7: Torsion extraction, FS91-J02-L1 (`plans/FS91-derivation.md:171`).
> — source: data/fs131/claims-NF4.md § The shared leaves these rows wait on (the map's § X1)

> NF4-S9: At a stable prime the image of `U_F` in `𝓞/P^m` is every norm-one element.
> — source: data/fs131/claims-NF4.md § The shared leaves these rows wait on (the map's § X1)

> NF4-NC: any upper bound as this project's (every upper bound here is prior art, and the field-level upper halves are the first module's, on branch `fs131-wnf`); the two-colour classification over every real number field and the three-colour one for fields containing the square root of 3 as this project's (they are an outside model's derivation recorded in this repository: `LEDGER.md` § B, the two entries dated 2026-09-14); anything at five colours; anything over a field that is not a number field where the map or the ledger's row 99 says a wider reading fails.
> — source: data/fs131/claims-NF4.md § Not claimed

**The upper halves are another module's.** Every "=" in the theorem needs an upper bound at the level of a field,
and those are being typed today on branch `fs131-wnf` (its tree: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf`; modules `Arith/UpperHalf`,
`Arith/QuadraticPrime` and an instances file, skeleton compiling, 24 leaves open; claim list
`data/fs131/claims-NF1.md` with its dated lines). Read its statements there. Your module proves the lower halves
and the criterion; the equalities are assembled in a file that imports both, which you plan and do not need to
compile until that module is on `main`.

## Done means

1. **Readback** (a saved stage): the eleven quoted lines checked against the claim list; the theorem's three clauses
   restated with every symbol resolved to a library declaration or marked as missing; the derivation entries the
   ranking names read where they stand, and what each proves set beside the clause it is cited for — a clause wider
   than its entry is a finding to send at once.
2. **The leaf list** (a saved stage): for each clause, the leaves in dependency order from the kernel's present
   theorems to the clause, each exact enough to type, each with its derivation address; the three shared leaves
   placed in it; what is already in the library under another name (search by the statement's shape and say what
   you searched).
3. **The statements typed**, compiled with `sorry`, each read back aloud against its claim: every hypothesis the
   Lean statement has that the claim lacks and every one the claim has that Lean does not need. The attribution
   the ranking flags is answered in the statements themselves and their docstrings: what is this project's (the
   lower bound at four; the three-colour criterion over every real number field), what is an outside model's, what
   is Fischer's and Johnson's, in the words `LEDGER.md` § The claim list and § B use.
4. **The skeleton** compiling in your tree, `sorry` at every leaf and nowhere else, every definition with an
   inhabitant, a spec example per headline, the modules' lines in the build's lists.
5. **A plan per leaf** for an implementer with none of your context; the split two implementers could work on
   without sharing a file; and what the landing needs after them.
6. **Outside statements**: the map says one row's route uses Weil's bound, which the library already declares, and
   the other uses none; confirm it from the entries, and name any other printed statement a leaf reads, with its
   page if the record has it.
7. The report, with drafts for the files you do not write (the ledger rows this would regrade; the sentence a
   reader of the repository would be told).

## What is yours to decide

The module names and layout; whether the quadratic table is one theorem or a family; how much of the character
machinery already in the library (`CharacterColouring`, the winding form of the criterion's forward half, the
relation-lattice modules) each leaf should stand on; the strongest true form of each statement. If the leaf list
shows that one clause is much further than the others, say so and say which you would build first.

Not yours here: the upper halves; the five-colour chain (it has its own architecture on branch `fs131-wch`); a
new derivation — a missing lemma is a question to me, and I route it to a deriver.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not apply
today.** Measured today by the other planners: one file through `lake env lean` costs 3 to 24 seconds and 3.6 GB; a
build is a 24-minute walk whatever changed, with 4.5 GB for its largest process. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name kn4 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2`, from inside your worktree. A
build: `--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=2 ./scripts/build.sh` from inside the worktree; never `lake build`.
Others build too: on exit 75 wait and retry. Your first build recompiles modules the others' did not, so tell me its
wall time and peak memory. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/kn4/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**;
a failed push is not an error to fix.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
