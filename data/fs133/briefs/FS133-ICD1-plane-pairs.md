# Brief FS133-ICD1 — the density equality's last two lanes: the plane (the algebraic plane to the real one, and the fractional chromatic number) and pairs

*Written 2026-10-14 06:04 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-ICD1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: an implementer on a planned module of eight files, after four who took its outside side, its measure and laws, and its definitions — you take its last two lanes, three files and thirteen leaves, the module's headlines among them
  launch: now, in the tree the last implementer handed back, on a new branch cut from its head; the port of the outside release, which this module's landing waits on, runs in `fs132-wi1`; the chain's Pontryagin-duality planner works in `fs131-wq1`; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf's route does not go through and you take another (say which), and if a record the plan's § 5.5 lists on the standard three alone prints the declared import; the report goes to `data/fs133/reports/FS133-ICD1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-ICD1-implementation.md` (new, on branch `fs133-wcd`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` on a **new branch `fs133-wcd`** that you cut from its head (`572bc6b57`; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean`, `Proofs/HadwigerNelson/Plane/OneClass/Fractional.lean` and `Proofs/HadwigerNelson/Plane/OneClass/Pair.lean` — **proofs and private helpers only, no statement changes**; in `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` only two edits, by the rulings quoted below: `upperDensity_congr_ae` made public with its statement unchanged, and the docstring of `Plane.isIndepSet_ball_half` rewritten to say what its statement asserts; `plans/FS133-ICD1-implementation.md`; `data/fs133/icd1/`; `data/fs133/reports/FS133-ICD1.md`. Nothing on `main`; nothing in the module's other files; the import of `Mathlib.Algebra.AlgebraicCard` in `InvariantLaw` stays (ruled)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This module is the density equality for the real plane: the largest density of a set with no two points at
distance one is the same whether the set is arbitrary or measurable, and with it the fractional chromatic number of
the plane is one over that density. Its outside side, its field theorem, its invariant laws, its section density and
its definitions are proved, all on the standard three axioms or on the one outside theorem the plan names. Yours are
the files that state the result.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The finding is ours by hand, one mind, and it answers a question the literature has posed (the module's claim list
says which). Until these three files are proved its headlines read as unproved. The module's landing waits on the port
of the outside release, which turns its one declared outside theorem into a theorem of this library; your files are
done before the port is, so the landing is not held up by them.

## The statements

The claim the module proves, and what it does not claim, from the claim list fixed before it was planned:

> K133-ONE: (entry at line 469 of the derivation file) `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-ONE: any value of `m₁(ℝ²)` or of a chromatic number; `m₁(ℝ²) = δ_Croft`; that some finite graph attains `sup χ_f(G)` (`[Johnson1996fcn]` Question 2); anything at a number field's plane (row 129's field form keeps "given MR"); anything at six colours — `1/m₁(ℝ²) ≤ 4.36`; that the release states any of this
> — source: data/fs133/claims-K1.md § Not claimed

The last implementer's hand-back as I logged it, with my rulings (rulings 1, 2 and 4 bind you):

> 752. **FS133-IB2 handed back: the density equality's definitions file is proved (2026-10-14 05:20 UTC logged; "JOB FS133-IB2 — DONE"; 376k by the harness's count — not to be resumed; branch `fs133-wb2` at `572bc6b57`, tree `fs133-wk1`; record `plans/FS133-IB2-implementation.md` there).** Its words: "all thirteen leaves of `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` are proved: [kernel], on [propext, Classical.choice, Quot.sound], with no statement changed"; "`HadwigerNelson.OneClass.IsInvariantLaw.isPlaneSystem` … **This is the kernel's model of the hypotheses of the field theorem `OneClass.exists_field`**"; the join — "`InvariantLaw`'s private `card_le_indepNum_induce` and `exists_indep_subset` are deleted … The bridge between α(G[S]) and the independent subsets of S is now proved once"; "`countable_algPlane` … Moved into `Defs` under Amendment 1 … its stored type is identical"; "Across the eight modules: 112 of 114 identical, plus that one moved constant and that one filled proof field"; build 249 of 249, no warning from either file, no `sorry`. **My receipt:** the four commits exist on `fs133-wb2`; `grep -c sorry` on both files: 0; I printed from the tree's compiled library under the memory tool (scratch `ib2/Ax.lean`): `inv_finIndepRatio_le_iSup_fractionalChromaticNumber`, `IsInvariantLaw.isPlaneSystem`, `isInvariantLaw_dirac`, `mOne_eq_iSup_nullMeasurableSet` — each `[propext, Classical.choice, Quot.sound]`. As reported. **Rulings, four parts each.** (1) *`Plane.upperDensity_congr_ae`, private here, needed by lane C's `Algebraic`:* made public by lane C's implementer, its statement unchanged and dumped; alternative, a second copy in lane C — declined, one fact proved once (item 747's ruling on `countable_algPlane`); high. (2) *The import `Mathlib.Algebra.AlgebraicCard` in `InvariantLaw`, now unread:* kept until lane C's modules exist (its `Algebraic` module may read it), then dropped at the landing if nothing reads it, with the stored statements dumped; alternative, drop it now — declined, it might be re-added one module later; medium-high. (3) *The double `#print axioms` line for `countable_algPlane` (blocks DB1 and DC1):* the landing drops DB1's line when DC1 is filed; high. (4) *The docstring of `Plane.isIndepSet_ball_half` claims measurability its statement does not assert:* lane C's implementer rewrites the docstring only; alternative, add the clause to the statement — declined, `measurableSet_ball` is Mathlib's and no reader needs it here; high. (5) *Correction owed — plan § 5.2 (G12) names no step for `isInvariantLaw_dirac`'s `indep` clause, which needs `Countable E`:* already ruled by IB2's Amendment 1 and made; logged against the plan's record for the density equality's landing filing. (6) *Its slip (a build launched before one file elaborated; stopped by process group at batch 56):* logged; no workflow change. (7) *The tree `fs133-wk1`:* keeps its compiled library (current for `fs133-wb2`'s head) for lanes C and D, which stay in the queue behind the chain's next job.
> — source: plans/FS131-close-inventory.md

**Your thirteen leaves** are the `sorry`s of `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean` (five), `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/Proofs/HadwigerNelson/Plane/OneClass/Fractional.lean` (three) and
`/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/Proofs/HadwigerNelson/Plane/OneClass/Pair.lean` (five) — the plan's lanes C (A1–A5, C1–C3) and D (Q1–Q5). Their statements are the files'; read them
in the source. **The plan per leaf**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-kernel-plan.md` § 5.3 (lane C) and § 5.4 (lane D), with § 5.5 (what each headline's
axioms must read — the standard three, or the standard three and the declared `Spectral.residual_fourier`, list by
list: a record of the second list that prints the import is a route that went wrong). The three earlier
implementers' records, `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IA1-implementation.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IB1-implementation.md` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IB2-implementation.md`, end with what each learned that the plan does not say.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf restated in one line
   beside the plan's route; the stored statements of the three files and of `Defs` dumped from the built tree before
   any edit.
2. **Lane C** (saved stages as leaves fall), then **lane D**; re-price what is left from the first two leaves and say so.
3. **The two edits to `Defs`**: the lemma made public (its stored type unchanged, shown by the dump), the docstring
   rewritten.
4. **No statement changed**, shown from the kernel's side against item 1's dump (the instrument
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/tools/fs133_ib2_moved.py` is the pattern; a planted change watched firing), the visibility change listed; no
   `sorry` left in the three files; one build under the slot with no warning from them; the axioms of every public
   declaration of the module printed from the built tree, each matching its list in the plan's § 5.5, with a planted
   record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for the three files; the model for each hypothesis
   that lacks one; the front-page lines for the module's headlines, at their grades, with what is not claimed.
6. The report in the standing rules' form. Leave no process running or queued. Say whether this tree's compiled
   library is still needed after you (the landing will want a tree).

## What is yours to decide

The proofs; private helpers; another route for a leaf where the plan's does not go through (tell me which). An
unread binder of a statement in your three files — a hypothesis or an instance that neither the statement nor its
proof reads — is dropped without asking, listed in your statement check as a ruled difference, and named in your
report (the standing word given to the earlier implementers, item 726). Anything else about a statement comes to me
first.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 to
13 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icd1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs133/icd1/`. Report at once any disk, memory or count reading near its
limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
