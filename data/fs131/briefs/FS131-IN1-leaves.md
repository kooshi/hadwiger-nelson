# Brief FS131-IN1 — 13 leaves of one module: the three-colour criterion toward the prime, in the ring of unit vectors, and the two-colour end

*Written 2026-10-13 20:12 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IN1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of one module of the three-and-four-colours line — replace every `sorry` in it with a proof, changing no statement; print the axioms of its headline theorems; build once at the end; draft what the landing will need
  launch: now, in a tree of your own; the line's other three modules are separate jobs in other trees, each reading upstream leaves as stated; another module's last leaves and a landing are in flight in other trees — the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); for a library or Mathlib lemma the plan names that does not exist as named; and with one line when the file has no `sorry` and its headlines print their axioms; the report goes to `data/fs131/reports/FS131-IN1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IN1-implementation.md` (new, on your branch)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc` (branch `fs131-wrc`, at `34d9113b2`): `Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean` — proofs and private helper lemmas only, **no statement of the skeleton changes** — and nothing else under `Proofs/`; `plans/FS131-IN1-implementation.md`; `data/fs131/in1/`; `data/fs131/reports/FS131-IN1.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback and after every two or three leaves; re-price a long leaf from its first child and say the price in your record; hand back at a saved stage before you would guess 500k, with the leaves done and left by name

Hello. Two planners of this lane built this skeleton today. The first typed it and caught a false shared statement
by typing it; the second ran the lane's three modeling passes before any proof, changed three statements while that
was still free, re-derived every leaf by hand, and built the skeleton three times with the linters silent. Two other
modules planned the same way this morning were proved this afternoon with the plan holding on every leaf.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

By the asking lane's ranking the finding the field gets first is the one that needs no hypothesis: the exact number
of colours for planes over real quadratic fields, through four, and the criterion for exactly three over every real
number field. It was asked twice in print by name, and a paper posted last week calls the upper bounds known and
leaves the exact values. This module is one of its four: the three-colour criterion toward the prime, in the ring of unit vectors, and the two-colour end.

## The statements

The theorem the line proves, and the three dated lines that changed its claim list today:

> NF4-THEOREM: *The theorem.* (a) For every squarefree `m ≡ 11 (mod 12)`, `χ(ℚ(√m)²) ⩾ 4`. So, with the printed values: `χ(ℚ(√m)²) = 2` for `m ≢ 3 (mod 4)`; `3` for `m ≡ 3, 7 (mod 12)`; `4` for `m ≡ 11 (mod 12)` outside the classes `47, 143, 167 (mod 168)`; and at least 4 in those. (b) For every real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`. (c) For any subfield `F` of `ℝ`: if `1/3` is an integer combination of unit vectors and `F²` has an odd cycle, then `χ(F²) ⩾ 4`.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

> - 2026-10-13 17:51 UTC — **Three statements widened by the module's planner (FS131-KN4) at its first stage; each is typed in the wider form with the claim's own form as a corollary; "[hand, one mind, the planner]" until the kernel has them.** Its words: "G-1: clause (a)'s lower bound needs neither squarefreeness nor the quadratic field — every subfield F of R holding sqrt(d) for a natural d = 11 (mod 12) has chi(F^2) >= 4 (1/n = 2 - v - conj v with d + 1 = 4n, v = ((2n-1) + i sqrt d)/(2n), and 3 | n); likewise chi >= 3 for d = 3 (mod 4). G-2: clause (c)'s strongest form is '1/3 in Z[U_F] gives Colorable 3 -> Colorable 2', i.e. chi(F^2) is never 3 there. G-3: clause (b) does not need the outside model's two-colour classification: the dyadic case of the proof ends in a character equal to 1/2 on every unit vector, which is a two-colouring, so 'not bipartite' closes it with no prime above 2 named." No statement defect found in the list.
> — source: data/fs131/claims-NF4.md

> - 2026-10-13 17:59 UTC — **NF4-S9 is untrue as written; found by the module's planner (FS131-KN4); its counterexample counted independently by me.** Its words: "Counterexample: F = Q, P = (1+i), m = 4. O/P^4 = Z[i]/4 has 8 elements x with x * conj x = 1 (a^2 + b^2 = 1 mod 4); a unit vector of Q^2 is (a+bi)/c with c odd and a^2 + b^2 = c^2 = 1 mod 8, so one of a, b is divisible by 4 and the image is {{1, -1, i, -i}}: 4 elements; 1 + 2i is missed." **The statement stands at level one, at every stable prime** ("inert by Hilbert 90 in the residue field; ramified because t^2 = 1 forces t = 1 in characteristic 2"); at higher levels it is claimed here only where the prime is unramified in F(i)/F, and that half is not derived by the planner. This module reads level one only.
> — source: data/fs131/claims-NF4.md

> - 2026-10-13 17:59 UTC — **Two statements added, in the planner's words, as leaves of this module's line** (the upper halves of two rows of the quadratic table, which the first module's claim list does not state): NF4-DYADIC-TWO — "'= 2 for squarefree m not 3 mod 4' needs a stable prime of Q(sqrt m)(i) above 2 ramified over Q(sqrt m)"; NF4-DYADIC-FOUR — "'= 4 for m = 11 mod 24' needs the stable prime above 2 with residue field F_4 (inert in F(i)/F exactly when m = 3 mod 8; the target then has four vertices)". Both values are prior art (the claim list's "not claimed" line); what is typed is their kernel form.
> — source: data/fs131/claims-NF4.md

**Your leaves, by name** — `Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean` in your tree, 13 of them:
`targetFloor_four_weil`, `exists_mul_conj_inv_eq_of_mul_conj_eq_one`, `exists_normOne_zero_of_card_ne_nine`, `eq_zero_of_forall_normOne_eq`, `exists_maximal_card_nine`, `exists_maximal_conj_trivial`, `conj_mem_unitRing`, `exists_unitSet_mul_conjR_eq`, `comap_conjR_eq`, `finite_quotient_span_natCast`, `exists_maximal_of_torsion`, `fieldBandSet_two_nonempty_of_conj_trivial`, `exists_maximal_conj_trivial_of_colorable_two`. Their statements are the file's: read them in the source, and read each back
against the plan before you prove it.

**The plans, in this order**: the dated section at the end of `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/plans/FS131-KN4-three-four-colours-plan.md` (where the second planner changed the first's
plan), then `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/plans/FS131-KN5-three-four-colours-passes.md` — § Stage 3 (the long leaves split into children, each with a route), § Stage 5 (the dyadic
leaves), § Stage 7 (the leaf list after the passes, the split, and what each module reads from upstream as stated);
then the first plan's § 4 for the leaves the second did not touch. Their name checks are under
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/data/fs131/kn5/`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against the claim list; every leaf's statement read in the
   source and restated in one line in your record with the plan's route beside it; a leaf whose statement and plan
   disagree is a message before you start it.
2. **The leaves**, in the plan's order, each proved without changing a statement. A helper you need is private to
   the file unless the plan names it. A leaf that resists after two honest routes is left as `sorry` with a comment
   holding what you have, and reported by name: that is a good stage, not a failure.
3. **No statement changed**, shown from the kernel's side against the skeleton at `34d9113b2` (the scripts of today's two
   implementers are the pattern: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/iu1/` — and
   read the tool defect its record names before you copy it: a statement printed from two paths can differ in an
   instance binder's name), with a planted fault watched firing.
4. **The axioms** of the file's headline theorems printed from the built module: the standard three and nothing
   else — or the one declared outside theorem the plan says a leaf reads, named — or `sorryAx` with the leaf it
   comes from.
5. **One build at the end**, under the slot, zero warnings from your file.
6. **Drafts for the landing**, in your record: the audit block's records for this file (every declaration a person
   typed), an inhabitant or model named for each hypothesis of the headlines, and anything a reader of the
   statements should be told that the docstrings do not say — the attribution of each value above all (what is this
   project's, what is an outside model's, what is Fischer's and Johnson's, as the docstrings already try to say).
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the order within the plan's dependency order; whether a leaf is better proved in a
more general form privately. If a statement can be strengthened at no cost, tell me and keep the skeleton's form.

Not yours: any statement; the other modules; the joining module; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 6
seconds and 3.6 GB once the imports are read; a build is 6 to 9 minutes at `BATCH=8` when only small modules are
stale, about 5 GB at its peak. **Write against `lake env lean`, and build once.** Do not edit a module file while a
build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name in1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree.
The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. A landing's gate
steps have priority on the slot: keep proving against `lake env lean` while you wait. Stop a process by its PID,
never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/in1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-13 20:28 UTC) — make the two widenings: a statement that carries a hypothesis its proof never reads is not what this library publishes

You kept the skeleton's form and told me, exactly as the brief asks. My ruling, now that I have your proofs' word for
it: **drop the two unread hypotheses** — `[Finite k]` from `exists_mul_conj_inv_eq_of_mul_conj_eq_one` and `hσσ` from
`eq_zero_of_forall_normOne_eq` — with the two `have _ := …` lines that kept the linters quiet, and adjust the one
consumer in the file that passed the second. Why: these statements will be read by people outside the project, and a
line whose only purpose is to hide an unused hypothesis from a linter is the kind of thing a reader takes as a sign
that the statement was not understood; the claim list carries the change as a dated line. Your touches are extended
to **those two statements and their consumer, and nothing else of the skeleton's statements**. In your statement
check, show these two as the only differences from the skeleton (a planted third must still be reported). The joining
module reads the first at a finite residue field and is not compiled in your tree; say in your drafts that its call
site needs no change, or what change it needs.

Thank you for the note on this tree's build: the one build at the end compiling about forty modules is expected, and
your scratch farm is a fine way to iterate until then. You start no agents of your own (standing rule 1: delegation is
one level deep, because the coordinator can only review work it knows exists).
