# Brief FS133-IA1 — the outside side of the density equality: port the release's generic lemmas, prove the field theorem that is the module's heaviest link, and give the declared theorem its model

*Written 2026-10-13 21:26 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-IA1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the first implementer of a planned module of eight files and 43 leaves — you take one of its four lanes, the one that touches the outside release: a ported module made by the generator, the field theorem proved over it, and the two leaves beside the declared outside theorem
  launch: now, in the planner's tree on a new branch — the planner has handed back and nobody else writes there; a landing of another module is in its final pass in `fs131-wnf` and has priority on the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the port needs a patch on anything but a proof line, if the declared statement would have to change by one character, and with one line when the ported module builds; the report goes to `data/fs133/reports/FS133-IA1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-IA1-implementation.md` (new, on branch `fs133-wa1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` on a **new branch `fs133-wa1`** that you cut from its head (`fe95f704d`; its build is current for that commit): the new generated module the plan calls `Outside/OAI158Transfer` with its line in the build's lists and its row in `ARCHITECTURE.md`; in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean` and `Proofs/HadwigerNelson/Plane/OneClass/Field.lean` **proofs and private helpers only — no statement changes, and not one character of the declared `axiom`**; `plans/FS133-IA1-implementation.md`; `data/fs133/ia1/`; `data/fs133/reports/FS133-IA1.md`. Nothing on `main`; nothing in the other six files of the module (three other lanes own them); nothing in the outside release's clone, which is read only
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. A planner finished this module's plan an hour ago: every statement typed and read back, eight files that build
with `sorry` at 43 leaves and nowhere else, a plan per leaf, and the leaves split into four lanes that share no file.
You are the first implementer, on the lane the planner says carries the most risk and so goes first.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The finding is that the largest density of a set in the plane with no two points at distance one is the same whether
the set is arbitrary or measurable — an answer to a question two recent papers pose — and it is ours by hand only,
one mind, a week old. In the kernel it will rest on one declared theorem of an outside Lean release, which the planner
has declared, with its read-back, in `Outside/OAI158Rigidity`. Your lane is everything between that declaration and
the rest of the module: the release's own generic lemmas brought here by port (kernel-checked here, no axiom), and
over them the one theorem — the planner calls it the field theorem — from which the other three lanes read
everything they need of the outside side. Until it is proved, every headline of the module prints an unproved
dependency.

One more thing rides on your first leaf. The port you make is the first measurement of what it costs to bring a
module of the release's transfer proof to this library's version of Mathlib, and Kooshi has a decision pending on
porting the whole of it. What your port needed — patches, renames, minutes — is wanted as a result in its own right.

## The statements

The claim your lane serves, and what the module does not claim, from the claim list fixed before it was planned:

> K133-ALG: (entry at line 445 of the derivation file) every `E ⋊ K`-invariant Borel probability on the space of independent sets of the unit-distance graph of the algebraic plane `E` has `P(0 ∈ I) ≤ m₁(ℝ²)`
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-ALG: the same at any number field's plane — over `ℚ(√3,√11)` a colour class of Theorem B's residue colouring is an invariant independent set of density `1/4 > m₁(ℝ²)`, and every step below but Theorem 2.3 runs there; the same for laws invariant under translations alone; the form with several algebraic distances (the argument reads the distance only as "`K` is transitive on the algebraic circle of that radius and dense in the real one", but no entry is written)
> — source: data/fs133/claims-K1.md § Not claimed

> K133-NC-ALL: any value of the densities or of a chromatic number; anything at a number field's plane; that the outside release states any of these (its manuscript does not); that the result is new — a paper posted on 8 October 2026 proves the same sentence in dimension four and up and names the plane as its aim (`BIBLIOGRAPHY.md`, the row keyed Davies2026; `plans/FS131-ER1-davies-reading.md`).
> — source: data/fs133/claims-K1.md § Not claimed

**Your four leaves**, by the plan's letters: **P**, the ported module; **F**, `OneClass.exists_field` in
`Proofs/HadwigerNelson/Plane/OneClass/Field.lean`; **X**, `Spectral.residual_fourier_cross`, and **M**,
`Spectral.residual_fourier_model`, both in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean`. Their statements are
the files'; read them in the source. **The plan per leaf**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-kernel-plan.md` § 5.1 (lane A), with § 5.0 (the split), § 5.5
(what each headline's axioms must read when its leaves are done), § 2 (how the declared theorem entered, and the grade
of its read-back in § 2.4) and § 6 (what the modeling passes changed). The planner's report: `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/data/fs133/reports/FS133-K1.md`.

## Done means

1. **Readback** (a saved stage): the four quoted lines checked against their sources; each leaf's statement
   restated in one line beside the plan's route for it.
2. **P, the port** (a saved stage): made with the generator the last port used (`tools/fs132_i2_port.py`, which
   refuses a patch to a statement or a definition), the licence text beside it
   (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`), its read-back run with a control that fires
   (`tools/fs132_i2_readback.py`), and every declaration of it printing the standard three axioms and nothing else.
   **And the measurement**: per ported declaration group, what the generator needed at this pin (patches on proof
   lines, renamed Mathlib constants, anything refused), the wall time, and one paragraph on what this says about
   porting the rest of the transfer's cone. Send me the one line when it builds.
3. **M and X** (a saved stage). M's axioms are the standard three: the model must not read the declared theorem.
4. **F** (saved stages as its parts fall). If P stalls, the plan says how F can be written without it; tell me
   before you take that road.
5. **No statement changed**, shown from the kernel's side for your three files (a comparison of stored statements
   before and after, with a planted change watched firing); no `sorry` left in them; one build under the slot with
   no warning from them; the axioms of every public declaration of your lane printed from the built tree and set
   against the plan's § 5.5 — a declaration on its second list that prints the import is a route that went wrong.
6. **Drafts for the landing**, in your record: the audit's block for your files, the model for each hypothesis, and
   anything a reader of the declared theorem's docstring should be told that it does not yet say.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the order inside your lane beyond "P first"; how the ported module is cut into
declaration groups. Not yours: any statement; the declared theorem's text; the optional leaf the plan calls R (ruled
out of this job: it waits on the decision about the port); the other three lanes; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build with only small modules stale takes 6 to 10 minutes; one such build at `BATCH=8` peaked
at 12.3 GB summed over its processes. Write against `lake env lean` and build rarely; do not edit a module file while
a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ia1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree (the
planner's `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/data/fs133/k1/lean1.sh` does this). The build: `--mem 12 --cpus 4 -- env MEMMAX=12G BATCH=4
./scripts/build.sh` from inside the worktree; never `lake build`. A landing's gate steps have priority on the slot.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record
cites lives under `data/fs133/ia1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-13 21:49 UTC) — the declared theorem's module takes the two imports now; the comparison leaf is back in your lane

You found what the planner's probe and I both missed. I had searched this library's Mathlib for those names, found
them, and then deferred to a probe that said they did not exist — without asking under which imports it had looked.
Thank you; this is the difference between a declared statement whose gap is unexplained and one whose gap is a
single named instance.

**Ruling: add the two import lines to the module that holds the declared theorem, now, and let the ported module
import the same, as the release's side does.** *The alternative I weighed:* leave that module's imports as they are
and let a separate comparison carry everything. *Why this wins:* by your measurement it shrinks what differs between
the release's stored statement and ours from 24 constants against 4 to 4 against 2, all on one path; it puts every
module of this milestone on the path the release's own proofs were written for; and it costs least today, before
any other lane has built on the present path. *Confidence:* medium-high. It would change — tell me at once and fall
back to today's imports — if the change moves a stored statement of any of the eight modules in anything but
instance arguments, or if proofs of your lane break on the release's path in a way a line cannot mend.

**What goes with it:**

1. The two import lines in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean`, and **not one character of the
   declared statement's text**; the docstring's sentence about the cause corrected to what you measured (the path
   is chosen by the import list, not by the pin; what still differs, by name).
2. The skeleton rebuilt, and the before-and-after dump of all eight modules' stored statements you already
   prepared: the list of what moved, and for each that it moved in instance arguments only (the planner's
   comparison with instances erased is the instrument; a planted change must be refused).
3. The read-back of the declared statement run again on the module as it then stands, with its controls — the
   record says what it prints, not what we expect.
4. **The comparison leaf the plan calls R is back in your lane** — its premise for waiting is gone. The form is
   yours to choose by cost, and the aim is that nothing is left to trust beyond "a Mathlib constant of one name means
   one thing at both pins": at the least, the two instance terms that still differ shown equal at this pin by a
   kernel-checked equality, and the comparator showing the two stored statements are identical once that one subterm
   is rewritten; the full rebuilt-type check if it now costs about the same. After the field theorem, or left as a
   leaf with its plan if your budget is short — the field theorem comes first.
5. Two drafts in your record: a dated note for the plan's § 2.4 (what the cause was), and one sentence for `LEAN.md`
   § Assumptions: outside theorems and our own, item 2 — what to do before blaming the pin for a stored statement
   that differs.

Your touches are extended by exactly that: the import lines and the docstring of the declared theorem's module, and
the files of leaf R under your data folder or beside the module, as you judge. On your fourth point: yes, tell me
whether the ported module's imports move any stored statement of the other lanes' files; that list is wanted
whatever it says. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
