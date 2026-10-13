# Brief FS131-KN2 — the first Lean module of the number-field results: a plane over a real number field needs no more colours than any of its residue targets — statements typed, a skeleton, and a plan per leaf

*Written 2026-10-13 16:24 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KN2
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the successor of the planner who drew this milestone's map today, and you start from its record
  role: the kernel lane's planner for one module — type three statements and the instances they close, read each back against its claim, build the skeleton with `sorry` at every leaf, and write a plan per leaf for implementers who will have none of your context
  launch: now, in the tree the map was drawn in; the first planner has handed back and nobody else writes there; a deriver and the asking lane work on `main` under `plans/` and `data/` — you touch neither; nothing is landing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; the statements have no hand derivation to be blind to beyond the entries the map cites
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect (untrue as written, vacuous, narrower than it need be, or needing a hypothesis its claim lacks — say which), for a generalization you see while typing, and **with the first measurement of what `lake env lean` on one file and a build cost on this machine** (it sets the numbers for the implementers); with one line when the skeleton compiles; the report goes to `data/fs131/reports/FS131-KN2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KN2-upper-half-plan.md` (new, on branch `fs131-wnf`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` (branch `fs131-wnf`, level with `main` at `123d2bc5`; its `.lake/build` matches the branch — no Lean file has changed since the landing it was gated at): the new modules of this claim list under `Proofs/HadwigerNelson/` (the map proposes `Arith/UpperHalf`, `Arith/QuadraticPrime` and an instances file — the names are yours) and their lines in the build's lists; `plans/FS131-KN2-upper-half-plan.md`; `data/fs131/kn2/`; `data/fs131/reports/FS131-KN2.md`. No existing module's statements; nothing on `main`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, when the statements are typed, when the skeleton compiles, and after each leaf's plan; hand back when the plan per leaf is final, or earlier at a saved stage

Hello. This morning a planner of this lane mapped every result this project holds about planes over number fields
against the Lean library — what is kernel-checked, what is assumed, what is missing. Its record is on `main` now, and
it ends by naming the module to build first. You are building its skeleton.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The number-field results come first. The map found that one short piece of mathematics — a plane over a real number
field maps homomorphically onto each of its residue targets, so its chromatic number is at most theirs — is stated in
the kernel only at usable primes and only as an existence of a homomorphism, and that thirteen ledger rows wait on its
plain consequences. It imports nothing; it closes two exact values at once; it discharges one named hypothesis under
the project's best number-field theorem; and it is a leaf of every longer chain that will follow. That is why it goes
first whatever the ranking of findings says (the asking lane's ranking is still being written; it will order what
comes after this module, not this module).

The first planner stopped at its size line with phase 1 done and said where phase 2 starts: its record
`plans/FS131-KN1-number-field-kernel-map.md`, § X1 (the shared leaves), § X8 (the first module) and the closing section "What phase 2 inherits".
Read those first, then the entries of rows 52, 57, 73, 99 and 123 in the same record.

## The statements

Fixed in `data/fs131/claims-NF1.md` before your launch, copied by script from the map:

> NF1-S1A: For a real number field `F` and `𝔭` with `Arith.IsUsablePrime 𝔭`: `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))`; and `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-S1B: For a real number field `F` and `P : SpectralChain.StablePrime F`: a graph homomorphism from the unit-distance graph on `planeOver F` into `SpectralChain.levelTarget P 1`; so `χ(planeOver F) ≤ SpectralChain.localBound F`. Converse half for row 105: a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-S2: For squarefree `d > 1`, `F = ℚ(√d) ⊂ ℝ` with its `NumberField` instance, and an odd prime `p` with `d ≡ s² ≢ 0 (mod p)`: a maximal ideal `𝔭` of `𝓞 F` with `Nat.card (𝓞 F ⧸ 𝔭) = p`. The same for a multiquadratic field at a prime where every radicand is a square, a ramified radicand included (11 in `K`).
> — source: data/fs131/claims-NF1.md § Statements

> NF1-MODULE: **The first module I would start with, whatever the ranking:** the residue upper half — `[S1a]` and `[S1b]` in one new module (`Arith/UpperHalf`, importing `Arith/PlaceHom` and `SpectralChain`), `[S2]` for real quadratic fields in a second (`Arith/QuadraticPrime`), and the values they close in a third (`Instances/…`: `χ(ℚ(√11)²) = 4`, `χ(ℚ²) = 2`, `χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` again as the control against `SqrtFortySeven`). Reasons: thirteen rows wait on it; it discharges one hypothesis of the headline (`inline:UpperHalf`) and is leaf 1 of row 99; it imports nothing; and the result everyone expects first, `χ(ℚ(√47)²) = 5`, is not reachable without the whole chain, of which this is also a leaf. Two implementers could run at once with no shared file: one on `Arith/UpperHalf`, one on `Arith/QuadraticPrime`; the instances file follows both. In parallel and independent of both, the chain's own first leaf is C0 (naming `T + A`) and then leaf 13 (entropy): a third tree.
> — source: data/fs131/claims-NF1.md § Statements

What waits on each, from the map:

> NF1-WAIT-S1A: 52, 53, 73, 94, 119 (upper end), every instance field
> — source: data/fs131/claims-NF1.md § What waits on them (the map's column, copied)

> NF1-WAIT-S1B: 57, 63, 99, 103 (upper end), 105, 123, 127 (`inline:UpperHalf`)
> — source: data/fs131/claims-NF1.md § What waits on them (the map's column, copied)

> NF1-WAIT-S2: 52, 53, 73, 119 (upper end), 121 (a control: the result is already held another way), 123's instances
> — source: data/fs131/claims-NF1.md § What waits on them (the map's column, copied)

> NF1-NC: any lower bound for a plane over a field; anything above level one of a tower; `[S2]` at a prime where some radicand is not a square; that an instance's value is new mathematics (the value four over the field of the square roots of 3 and 11 is K. G. Fischer's of 1994; `LEDGER.md` § The claim list says what is ours); that the upper half alone gives any exact value — each exact value named also needs its lower half, which the map says the kernel holds for the instances listed.
> — source: data/fs131/claims-NF1.md § Not claimed

## Done means

1. **Readback** (a saved stage): the eight quoted lines checked against the claim list, and the claim list's three
   leaves against the map's § X1 rows; each statement restated in your record with the library declarations it will
   be typed over, read from the source (`Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `Proofs/HadwigerNelson/SpectralChain.lean` and what
   they import), not from the map's summary.
2. **The statements typed** (a saved stage): each as a Lean statement, compiled with `sorry`, and read back aloud
   against its claim — every hypothesis the Lean statement has that the claim lacks, and every one the claim has that
   Lean does not need, said. For each exact value among the instances, name the kernel theorem that holds its other
   half, with its axioms from `data/fs124/l2/gate/receipt-axioms-final.log`, so that the instance is an equality
   proved from two held halves and nothing else.
3. **The skeleton** compiling in your tree with `sorry` at every leaf and nowhere else; every definition with an
   inhabitant; the modules' lines in the build's lists; a spec example per headline.
4. **A plan per leaf**, for an implementer with none of your context: the statement, the route in steps, the Mathlib
   and library lemmas by full name as you found them (searched by shape — say what you searched), what you tried
   that failed, and a size only if you typed part of it.
5. **The split**: which leaves two implementers can take at once without touching one file, and what the landing
   needs after them (the map proposes: one on the first module, one on the second, the instances file after both).
6. **The machine, measured**: the wall time and peak memory of one `lake env lean` on your largest new file and of
   the build of your new modules, sent to me when you have them.
7. The report, in the standing rules' form, with the drafts for the files you do not write (the ledger rows the
   module will regrade; the map's § X9 has the first of them).

## What is yours to decide

The module names and layout; whether the residue homomorphism at a stable prime is one theorem or a short tower of
lemmas; which form of each statement is the strongest that is still true and typed without ceremony; whether an
instance belongs in this module or with the field's own file. If typing shows that one of the three leaves is already
a one-line corollary in the library, say so and state it — that is a result, not a shortfall. If a statement is
better generalized (another class of primes, a level above one), send it to me at once and keep the claim's form as
well.

Not yours here: the long chain under the five-colour results (it has its own planner to come); pricing anything by
tables; a change to any statement already through the gate.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not apply
today.** The memory tool's defaults are the desktop's and would admit almost nothing here, so run it as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name kn2 -- <command>`

One file through `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration: under the
slot with `--mem 8 --cpus 2`, from inside your worktree. A build is one at a time on this machine:
`--mem 18 --cpus 10 -- env MEMMAX=18G BATCH=2 ./scripts/build.sh` from inside the worktree; never `lake build`.
**These numbers are mine and unmeasured here — the first planner ran nothing.** If a run is refused (exit 75) or
killed for memory, that is the machine and not you: tell me what it was and what it used. Stop a process by its PID,
never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/kn2/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**;
a failed push is not an error to fix.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
