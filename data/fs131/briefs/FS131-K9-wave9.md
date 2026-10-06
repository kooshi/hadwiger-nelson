# Brief FS131-K9 — wave 9 planned: the eleven rows of the reductions and the class statements

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K9
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 9's kernel modules — read its rows' derivation entries in full, write the wave's foundation sorry-free, state every row as a skeleton with `sorry` at each leaf, read each statement back against its row, a plan and a price per leaf, the outside theorems named, and a handoff implementers can split by file; prove a leaf yourself where it is short
  launch: when a slot frees, on a branch cut from `main` — which holds waves 1–5 and, since today, the example maps (`Proofs/HadwigerNelson/Plane/Models/`) — in a tree of your own, beside the planners and implementers of other waves on other branches
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address: it goes to a deriver), a definition you fix that another wave's planner reads, a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K9.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w9-kernel-plan.md` (new, on branch `fs131-w9`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9` (branch `fs131-w9`, cut from `main` at `e6e7b312` and fast-forwarded to `26b08395`, wave 8's commit, which holds wave 7's shared module `SimpleOn` and wave 8's foundation `RingCalculus/Basic`): new modules under `Plane/Reduction` and `Plane/Classes` — the layout is yours — with `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in landed modules (no statement, definition or docstring of a landed declaration is edited); `scripts/Axioms.lean` (a block of your own, headed "FS131-K9", above the `=== PURCHASED ===` banner), `plans/FS131-w9-kernel-plan.md`, `tools/fs131_k9_*.py`, `data/fs131/k9/`, `data/fs131/reports/FS131-K9.md`; **not** `main`, another wave's branch, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are opening wave 9 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones:
259 rows in ten waves. Waves 1–5 are on `main`, with a library of example maps that landed today; waves 6 and 10 are planned and being
proved on their own branches. Wave 9 is eleven rows of two kinds — the reductions behind "six measurable colours do not suffice at bounded complexity" (from FS-111, with FS-129's TOP5) and the class statements FS-129 composed (a bend for any arc, the (Q)-free class, DISC-F in the non-Siamese class). Nobody has read these rows against Lean yet. You do, and you lay the wave out.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the hand results the frontier's next milestones stand on
(`LEDGER.md` rows 139–141 and 149–153; `CLAUDE.md` § Where the problem stands, item 31): a statement defect found now, while the row is being stated, costs
a message; found by a later milestone that built on it, it costs that milestone. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The milestone's plan is your map; its § 7.3 says what every wave's planning job must hold, and it binds you (read §§ 7.1–7.5 whole):

> ### 7.3 What each wave's planning job must hold
> — source: plans/FS131-kernel-plan.md

> 1. **Reads its rows' derivation entries in full** (the CSV gives each row's address in `plans/LEAN-BACKLOG.md`, which gives the derivation file's line),
> — source: plans/FS131-kernel-plan.md

> 2. **Writes the wave's foundation first** (the column above), sorry-free, with a spec example per definition and an inhabitant per structure, on the
> — source: plans/FS131-kernel-plan.md

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md

> 4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an
> — source: plans/FS131-kernel-plan.md

> 5. **Checks vacuity at the seam**: a route lemma over a class the backlog proves empty (wave 8's V6 lemmas, ruling R4) carries
> — source: plans/FS131-kernel-plan.md

What the two waves planned before yours handed back — read both items whole: each first pass held the dispositions, the foundation and part of
the skeleton, and each found filed statements that hid a hypothesis:

> 486. **FS131-K6 done at its Stage 7: wave 6's first planning pass — dispositions for all 35 rows, the foundation, four rows proved at a wider
> — source: plans/FS131-close-inventory.md

> 484. **FS131-K10 done at its Stage 5: wave 10 planned — dispositions for all fourteen rows, a foundation, a skeleton of eleven, four rows
> — source: plans/FS131-close-inventory.md

## The statements

The wave's rows, by module, from the plan (each row's address is in `plans/LEAN-BACKLOG.md`, which gives its derivation file's line; the plan's
CSV, `data/fs131/k1/dispositions.csv`, gives its disposition, its merges and any ruling), and the wave's line of the plan's table — its
foundation and its hypotheses from outside:

> **Wave 9** (11 rows):
> — source: plans/FS131-kernel-plan.md

> - `Plane/Reduction`: FS111-C1-UNIF, FS111-C-SIX-M, FS111-M2-REDUCE-C, FS129-OR1-TOP5, FS111-V0-CLEAN, FS111-C1-PW
> — source: plans/FS131-kernel-plan.md

> - `Plane/Classes`: FS129-OR1-DISCF-NS, FS129-SR1-BENDANY, FS129-OR1-QFREE-CLASS, FS129-SR1-BENDLE3, FS129-SR3-QFREE-NS
> — source: plans/FS131-kernel-plan.md

> - merged here: FS116-S1-QF → FS129-SR3-QFREE-NS; FS129-SR2-QFCASE → FS129-SR3-QFREE-NS
> — source: plans/FS131-kernel-plan.md

> | 9 | the reductions (FS-111's `χ_m⁰ ≥ 6` route, TOP5) and the class statements (BENDANY, QFREE-NS, DISCF-NS) | 11 | the fragment restriction `F_ρ` (OR1-WHOLE's), complexity-`K` tilings and `δ₀(K)` | **row 130's conclusion** `χ(ℝ²) = χ_m⁰(ℝ²)` as a named hypothesis for C-SIX-M's and M2-REDUCE-C's "hence χ(ℝ²) ≥ 6" (given MR); supporting lemma **FS111-M-REDUCE-I** formalized here (R13) |
> — source: plans/FS131-kernel-plan.md

By the backlog's own tags this wave rests on waves 1–5, all on `main`, and one of its rows (FS129-SR3-QFREE-NS) on one row of wave 8, FS129-SR3-EMPTY-NS, which a sibling planner is stating on `fs131-w8`. Take that row as a named hypothesis in that statement, under a name of your own, read from its derivation entry (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); the join replaces the hypothesis by wave 8's theorem. Nothing here rests on wave 6.

The wave's table row names its hypothesis from outside the backlog: row 130's conclusion, `χ(ℝ²) = χ_m⁰(ℝ²)`, for the two rows that end "hence χ(ℝ²) ≥ 6" given measure rigidity. It enters as a named hypothesis (`Row130Collapse`, as the plan's § 7.4 has it), never an axiom; Kooshi has ruled that measure rigidity itself is not formalized or priced now (inventory item 488), so do not open it. Every "given MR" in a row is read for what it hides beyond that one hypothesis.

**The word "simple" is fixed, and its module is shared** (inventory item 508). Wave 7's planner decided the plan's § 7.3 item 2 this morning:
a fragment is simple *on a set* — `ArcMap.SimpleOn S`: every tile whose closure meets `S` is a Jordan domain, and the closures of two such
tiles meet in a preconnected set — with the landed `ArcMap.Simple` untouched and `Simple.simpleOn`, `simpleOn_univ`, `simpleOn_ball_iff`
proved beside it, so a row stated with `SimpleOn` implies the row as filed. It lives in one module on that planner's branch
(`fs131-w7`), **and it is already in yours**: your branch was fast-forwarded by the coordinator past that planner's commit `611ffa39`, which holds
the module (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/SimpleOn.lean`, no `sorry`, built there) and
nothing else of its work but its stage-1 record and one build log — one module, declared once, on both branches by ancestry. State a class
on a fragment with `F.SimpleOn (closedBall p R)`; the module's statements are fixed (that planner builds on them too). Never re-declare the predicate or its lemmas (`LEAN.md` § Searching —
Lean, last bullet); a row whose argument reads a tile off the disc after all is a message to me. That planner did not take a purely local
form: the second clause is about two whole closures.

**Wave 8's foundation is in your branch too** (inventory items 518, 523): its planner committed
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/RingCalculus/Basic.lean` (no `sorry`) alone, and your
branch was fast-forwarded to that commit, `26b08395`. It holds the tiles of a point, tips, outer tiles, semi-hubs, and — what your class
statements read — the two classes as predicates: `GammaFreeRing p` (no point of the ring on a boundary arc) and `QFreeRing p` (no (Q) arc
on the ring). State your rows over them; never re-declare a name of that module, whose statements are fixed (wave 8's planner builds on
them). That planner met the hazard on the way and it is worth knowing: a name another wave already declares in the same namespace fails
only when both modules meet at the root import (`ArcMap.IsOuterTile` is wave 5's, a tile in no hole; wave 8's became `IsOuterTileAt`) —
check a new name against the library with `./scripts/dupnames.sh` and a grep of `Proofs/` before you rely on it.

## Done means

1. **Your readback first**: check every quotation above against its source; read the plan's §§ 7.1–7.5 and its CSV rows for wave 9, each
   row's entry in `plans/LEAN-BACKLOG.md` and its derivation entry in full, with errata; what `Proofs/HadwigerNelson/Plane/` already holds
   that the rows reuse (read `ARCHITECTURE.md`'s rows for waves 3–5 and for `Proofs/HadwigerNelson/Plane/Models/`). Register, before reading the derivations
   closely, which rows you expect to be short, which to need an outside theorem, and which to hide a statement defect. Build the branch once
   as given (no `sorry`; the build copied into your tree predates the two shared modules, so this first build compiles them). Open your record. Commit and push.
2. **The dispositions**: for each row — the statement at the class its argument reads (G92), what it rests on inside the backlog, every
   hypothesis from outside it (named, with `LEAN.md` § Assumptions' four items for an imported theorem; formalize anything that is about an
   hour of work), and whether it is a theorem, a named-hypothesis implication, or a certified computation (`LEAN.md` § The kernel's cost
   model). A row whose derivation does not support its statement is a message to me at once.
3. **The foundation, sorry-free**: the definitions the rows' words need, each with a spec example that would fail if it drifted and each
   structure with a named inhabitant — the example maps on `main` (`Proofs/HadwigerNelson/Plane/Models/`: every one is the seven-colour brick map read in more
   colours with a picture painted in the spare ones) are where a model of a map-level hypothesis comes from; the domain-modeling pass
   (`debruijn-domain-modeling`, invoked fresh) over it.
4. **The skeleton**: every row a statement with `sorry` at its leaves, building through the worktree's `./scripts/build.sh` with only `sorry`
   warnings; each formal statement read back against its row in your record; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on
   your tree — no name declared by two modules.
5. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from the
   first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the hypotheses' inhabitants and
   the vacuity lines, and a handoff for implementers with how two could split the work by file. A leaf you can prove in about an hour, prove,
   and say so.
6. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k9/`. The rows may be more than one planning pass holds: stopping
   at a saved stage with the dispositions and the foundation done and the skeleton for one module is a good report — say where a second pass
   takes over.

## What is yours to decide

The modules and their layout, the foundation's definitions, the form of each statement within what its row claims, what is formalized and what
is named as a hypothesis, and the order. The plan's wave table is a planner's first sorting, written before any of these rows was read closely;
where a row belongs with another wave, or two rows are one theorem, say so. Attack the rows: a statement that is true only at a narrower class
than its entry says, or a "given MR" that hides more than MR, is the finding this job is best placed to make — the two waves planned before
yours each found such rows. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment 1 (2026-10-06, at launch) — what changed since this brief was written

Information only; nothing above is withdrawn.

1. **Wave 8's first planning pass has handed back.** The one row of another wave that a row of yours rests on, FS129-SR3-EMPTY-NS, is
   now stated in Lean on `origin/fs131-w8` at `f1c13612` (not on your branch; read it with `git show f1c13612:<path>` or in the tree
   below). State your named hypothesis for FS129-SR3-QFREE-NS so that this theorem discharges it at the join in a line:

> theorem emptyNS {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

>     (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) : False := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

   It is stated at `ArcMap 6` and reads no simplicity (inventory item 524). `GammaFreeRing` is in the foundation you already hold.
2. **Wave 7's first pass has handed back too** (inventory item 513): its thirteen four-colour rows are not yet stated; a second pass
   will state them on `fs131-w7`. If a row of yours reads one of them, take it as a named hypothesis under a name of your own, as
   ruling 498 has it, and tell me which.
3. **A lesson from today, for your mid-job messages** (inventory item 526): when you report a defect, say which kind it is — a
   *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than the statement needs (a shorter-route note, no
   defect). One report this session was the second kind and was retracted by its reporter within the hour.
