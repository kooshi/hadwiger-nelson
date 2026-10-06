# Brief FS131-K8 — wave 8 planned: the twenty-two rows of the ring calculus — the star, semi-hubs, and the emptiness of the Γ-free class

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K8
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 8's kernel modules — read its rows' derivation entries in full, write the wave's foundation sorry-free, state every row as a skeleton with `sorry` at each leaf, read each statement back against its row, a plan and a price per leaf, the outside theorems named, and a handoff implementers can split by file; prove a leaf yourself where it is short
  launch: when a slot frees, on a branch cut from `main` — which holds waves 1–5 and, since today, the example maps (`Proofs/HadwigerNelson/Plane/Models/`) — in a tree of your own, beside the planners and implementers of other waves on other branches
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address: it goes to a deriver), a definition you fix that another wave's planner reads, a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K8.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w8-kernel-plan.md` (new, on branch `fs131-w8`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8` (branch `fs131-w8`, cut from `main` at `e6e7b312`): new modules under `Plane/RingCalculus/` (the plan names `Star`, `SemiHub`, `Empty`) — the layout is yours — with `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in landed modules (no statement, definition or docstring of a landed declaration is edited); `scripts/Axioms.lean` (a block of your own, headed "FS131-K8", above the `=== PURCHASED ===` banner), `plans/FS131-w8-kernel-plan.md`, `tools/fs131_k8_*.py`, `data/fs131/k8/`, `data/fs131/reports/FS131-K8.md`; **not** `main`, another wave's branch, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are opening wave 8 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones:
259 rows in ten waves. Waves 1–5 are on `main`, with a library of example maps that landed today; waves 6 and 10 are planned and being
proved on their own branches. Wave 8 is twenty-two rows about the unit ring of a four-colour vertex in the non-Siamese class — what the ring passes to the vertices it places (the star, the semi-hubs) and the emptiness of the Γ-free class — from the milestone FS-116, with three compositions of FS-129. Nobody has read these rows against Lean yet. You do, and you lay the wave out.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the hand results the frontier's next milestones stand on
(`LEDGER.md` rows 145–150; `CLAUDE.md` § Where the problem stands, item 31): a statement defect found now, while the row is being stated, costs
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

> **Wave 8** (22 rows):
> — source: plans/FS131-kernel-plan.md

> - `Plane/RingCalculus/Star`: FS116-N2-SIXRING, FS116-RING-GERM, FS116-N2-STAR, FS116-N2-ANTI, FS116-N2-RECIP, FS116-RING-TWIST-C
> — source: plans/FS131-kernel-plan.md

> - `Plane/RingCalculus/SemiHub`: FS116-N3-PAIR, FS116-N3-STAR2, FS116-N3-CONE, FS116-N3-CROSS, FS116-V5-OUT2, FS116-V5-QCOL, FS116-V5-DICHO, FS116-N3-SEMI, FS116-RING-TRANSFER-QC
> — source: plans/FS131-kernel-plan.md

> - `Plane/RingCalculus/Empty`: FS116-V6-HUBS, FS116-V6-ANTI, FS116-V6-HUG, FS116-V6-COUNT, FS129-SR3-EMPTY-NS, FS129-SR3-OUTERADJ, FS129-MR1-DOUBLETIP
> — source: plans/FS131-kernel-plan.md

> - merged here: FS116-Y4-EMPTY → FS129-SR3-EMPTY-NS; FS116-V6-ADJ → FS129-SR3-OUTERADJ; FS116-Y4-OBST → FS129-SR3-EMPTY-NS
> — source: plans/FS131-kernel-plan.md

> | 8 | the ring calculus, non-Siamese: RING-GERM, the star, semi-hubs, the Γ-free class's emptiness | 22 | tips, the transfer star, semi-hubs (full, parallel, crossed), the Γ-free and (Q)-free classes as predicates | none |
> — source: plans/FS131-kernel-plan.md

By the backlog's own tags this wave rests on waves 1, 3 and 4, all on `main`, and three of its rows (FS116-N3-STAR2, FS116-N3-CROSS, FS116-RING-TRANSFER-QC) on one row of wave 7, FS114-N7-QOPP, which a sibling planner is stating now on `fs131-w7`. Take that row as a named hypothesis in those three statements, under a name of your own, read from its derivation entry (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); the join replaces the hypothesis by wave 7's theorem.

The plan's § 7.3 item 5 names this wave: a route lemma over a class the backlog proves empty (the V6 lemmas) carries its vacuity in its docstring, in `LEAN.md` § The gate's form. And § 7.3 item 2's open word "simple" (a fragment's tiles that cross the domain's boundary) is being decided by wave 7's planner: state your classes with that reading as a parameter or over the literal one, say which, and I relay its decision when it arrives.

## Done means

1. **Your readback first**: check every quotation above against its source; read the plan's §§ 7.1–7.5 and its CSV rows for wave 8, each
   row's entry in `plans/LEAN-BACKLOG.md` and its derivation entry in full, with errata; what `Proofs/HadwigerNelson/Plane/` already holds
   that the rows reuse (read `ARCHITECTURE.md`'s rows for waves 3–5 and for `Proofs/HadwigerNelson/Plane/Models/`). Register, before reading the derivations
   closely, which rows you expect to be short, which to need an outside theorem, and which to hide a statement defect. Build the branch once
   as given (no `sorry`). Open your record. Commit and push.
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
   process running, and keep what your record cites under `data/fs131/k8/`. The rows may be more than one planning pass holds: stopping
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
