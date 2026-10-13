# Brief FS131-KN5 — before anyone proves over them: the modeling passes on a 29-leaf skeleton, its first build, and a plan an implementer can follow for its two thinnest leaves

*Written 2026-10-13 18:16 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KN5
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the successor of the planner who typed this skeleton today and ran out of budget before three steps of the lane's workflow
  role: the kernel lane's planner finishing a plan — run the modeling passes the first planner could not (they may change the form of a statement, which is why they come before the proofs), get the skeleton through its first real build with the linters, and turn two leaves whose route is "a sketch by one mind" into a plan per leaf or a precise question
  launch: now, in the first planner's tree — it has handed back and nobody else writes there; implementers work on another module in the trees `fs131-wnf` and `fs131-wq1`, and a landing is in flight in `fs131-wkc`: the build slot is shared and you will wait for it
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement whose form a modeling pass changes (the old and the new form, and why), for a statement defect, for a dyadic leaf that needs a derivation and not a plan (say the exact step), and with one line when the build is green with the linters read; the report goes to `data/fs131/reports/FS131-KN5.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KN5-three-four-colours-passes.md` (new, on branch `fs131-wr2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2` (branch `fs131-wr2`, at `09f5e7b16`; its `.lake/build` is an old landing's — the first build compiles two landings of modules under `Proofs/HadwigerNelson/Plane/` as well as this line's four): the four skeleton modules of this line under `Proofs/HadwigerNelson/Arith/` (`ThreeColourCharacter`, `TorsionExtraction`, `ThreeColourCriterion`, `DyadicQuadratic`) and the planned joining text under `data/fs131/kn4/lean/` — statements and definitions may change **only by a modeling pass, each change recorded with its reason**; `plans/FS131-KN5-three-four-colours-passes.md`; a dated section appended to the first planner's plan where a leaf's plan changes; `data/fs131/kn5/`; `data/fs131/reports/FS131-KN5.md`. Nothing on `main`; nothing in another tree
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after each pass, when the build is green, and after each dyadic leaf's plan; hand back at a saved stage rather than start a step you cannot finish

Hello. A planner of this lane typed a four-module skeleton today — three and four colours over real number fields,
the finding the field gets first — found a false shared leaf by typing it, widened three statements, and stopped at
its budget with three things undone, each of which it named. This job is those three things, so that the
implementers who follow start on statements that will not move under them.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

An implementer may not change a statement; a modeling pass may. If the passes run after the proofs, every change
costs a proof. The first planner said so in its hand-back: the passes "were not run as fresh skill invocations",
"no full build" (its build request waited behind other lines' builds for the whole job, so the linters have never
read these files), and the two leaves added late "want a deriver's page or a second planning pass before an
implementer", with one residue class "the thinnest".

## The statements

The claim list `data/fs131/claims-NF4.md`, its theorem and the three dated lines that changed it today:

> NF4-THEOREM: *The theorem.* (a) For every squarefree `m ≡ 11 (mod 12)`, `χ(ℚ(√m)²) ⩾ 4`. So, with the printed values: `χ(ℚ(√m)²) = 2` for `m ≢ 3 (mod 4)`; `3` for `m ≡ 3, 7 (mod 12)`; `4` for `m ≡ 11 (mod 12)` outside the classes `47, 143, 167 (mod 168)`; and at least 4 in those. (b) For every real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`. (c) For any subfield `F` of `ℝ`: if `1/3` is an integer combination of unit vectors and `F²` has an odd cycle, then `χ(F²) ⩾ 4`.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

> - 2026-10-13 17:51 UTC — **Three statements widened by the module's planner (FS131-KN4) at its first stage; each is typed in the wider form with the claim's own form as a corollary; "[hand, one mind, the planner]" until the kernel has them.** Its words: "G-1: clause (a)'s lower bound needs neither squarefreeness nor the quadratic field — every subfield F of R holding sqrt(d) for a natural d = 11 (mod 12) has chi(F^2) >= 4 (1/n = 2 - v - conj v with d + 1 = 4n, v = ((2n-1) + i sqrt d)/(2n), and 3 | n); likewise chi >= 3 for d = 3 (mod 4). G-2: clause (c)'s strongest form is '1/3 in Z[U_F] gives Colorable 3 -> Colorable 2', i.e. chi(F^2) is never 3 there. G-3: clause (b) does not need the outside model's two-colour classification: the dyadic case of the proof ends in a character equal to 1/2 on every unit vector, which is a two-colouring, so 'not bipartite' closes it with no prime above 2 named." No statement defect found in the list.
> — source: data/fs131/claims-NF4.md

> - 2026-10-13 17:59 UTC — **NF4-S9 is untrue as written; found by the module's planner (FS131-KN4); its counterexample counted independently by me.** Its words: "Counterexample: F = Q, P = (1+i), m = 4. O/P^4 = Z[i]/4 has 8 elements x with x * conj x = 1 (a^2 + b^2 = 1 mod 4); a unit vector of Q^2 is (a+bi)/c with c odd and a^2 + b^2 = c^2 = 1 mod 8, so one of a, b is divisible by 4 and the image is {{1, -1, i, -i}}: 4 elements; 1 + 2i is missed." **The statement stands at level one, at every stable prime** ("inert by Hilbert 90 in the residue field; ramified because t^2 = 1 forces t = 1 in characteristic 2"); at higher levels it is claimed here only where the prime is unramified in F(i)/F, and that half is not derived by the planner. This module reads level one only.
> — source: data/fs131/claims-NF4.md

> - 2026-10-13 17:59 UTC — **Two statements added, in the planner's words, as leaves of this module's line** (the upper halves of two rows of the quadratic table, which the first module's claim list does not state): NF4-DYADIC-TWO — "'= 2 for squarefree m not 3 mod 4' needs a stable prime of Q(sqrt m)(i) above 2 ramified over Q(sqrt m)"; NF4-DYADIC-FOUR — "'= 4 for m = 11 mod 24' needs the stable prime above 2 with residue field F_4 (inert in F(i)/F exactly when m = 3 mod 8; the target then has four vertices)". Both values are prior art (the claim list's "not claimed" line); what is typed is their kernel form.
> — source: data/fs131/claims-NF4.md

The skeleton and its plan: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/plans/FS131-KN4-three-four-colours-plan.md` (a plan per leaf in its § 4; the two dyadic leaves in its § 4.5; the modeling
passes it owes in its § Stage 3); the first planner's report `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/data/fs131/reports/FS131-KN4.md`.

## Done means

1. **Readback** (a saved stage): the four quoted lines checked against the claim list; the plan's § 4 and the four
   modules' statements read; each definition and each headline listed with the claim it answers.
2. **The modeling passes, as fresh invocations of your lane's skills** (a saved stage each): the domain pass on
   every definition and headline statement of the four modules and the joining text; the obligation pass on the
   leaves the plan calls long; the experience pass on what a reader of the published statements meets (names,
   argument order, what a docstring must say about whose result a value is). For each change: the old form, the
   new form, the reason, and the re-elaboration. A pass that changes nothing says so with what it weighed.
3. **The first build**, under the slot, and the linters' verdict read from its log; fix what they flag in the
   skeleton (an unused variable, a missing docstring) without touching a statement's meaning; send the wall time
   and peak memory.
4. **The two dyadic leaves**: for each of the three residue classes the first planner names, a plan an implementer
   can follow — the objects typed, the route in steps, the lemmas by full name as found — or, where the route needs
   mathematics nobody has written down, the exact step as a question for the derive lane. Check each class against
   a small exact computation where one is cheap, with a planted fault watched firing.
5. **The split confirmed** for implementers after your changes: which of the four modules two implementers can
   take at once, and what the joining module needs from the other line (`fs131-wnf`, whose first file is now fully
   proved on its branch).
6. The report in the standing rules' form.

## What is yours to decide

Every change a pass makes; whether a dyadic leaf is restated in a form that is easier to prove and equally useful
to the table; the batch size of your build once you have seen the first. If the passes show the skeleton is
already right, the job is short and that is a good result.

Not yours: proving the leaves (prove one only if it falls in a few lines while you test a plan); the other
module; the five-colour chain.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build is a 24-minute walk at `BATCH=2` and 6.5 minutes at `BATCH=8` when only small modules
are stale, 4.5 GB at its peak; a rebuild of 117 real modules by the landing is in progress now and is the first
measurement of that kind. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn5 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree
(the first planner's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/data/fs131/kn4/lean1.sh` does this). The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4
./scripts/build.sh` from inside the worktree — four cores, so that it can run beside another line's build; never
`lake build`. **The landing has priority on the slot**: if your build has waited an hour, tell me. Stop a process by
its PID, never by matching its command line, and leave none running or queued when you hand back — the first
planner's queued build outlived it and I had to stop it. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/kn5/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
