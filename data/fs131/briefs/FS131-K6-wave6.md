# Brief FS131-K6 — wave 6 planned: the thirty-five rows on saturated colourings — the pinch, the saturated fragment, map colourings, the ladder

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K6
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 6's kernel modules — read its thirty-five rows' derivation entries, write the wave's foundation sorry-free, state every row as a skeleton with `sorry` at each leaf, read each statement back against its row, a plan and a price per leaf, the outside theorems named, and a handoff an implementer can build from; prove a leaf yourself where it is short
  launch: now, on `main` — which holds wave 5 since today — in a tree of your own, beside wave 10's planner and the example maps' implementer on other branches
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address: it goes to a deriver), a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K6.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (its § The gate gained two passages today: the doubled-name check, and the rule that two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w6-kernel-plan.md` (new, on branch `fs131-w6`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6` (branch `fs131-w6`, cut from `main` at wave 5's landing): new modules under `Proofs/HadwigerNelson/Plane/Saturated/` for the wave (the plan names `Pinch`, `Fragment`, `MapColouring`, `Ladder`; the layout is yours), with `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in landed modules (no statement, definition or docstring of a landed declaration is edited); `scripts/Axioms.lean` (a block of your own, headed "FS131-K6", above the `=== PURCHASED ===` banner), `plans/FS131-w6-kernel-plan.md`, `tools/fs131_k6_*.py`, `data/fs131/k6/`, `data/fs131/reports/FS131-K6.md`; **not** `main`, another wave's branch, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are opening the second half of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones: 259 rows in ten waves. Waves 1–5 are on `main` — wave 5, the termination procedure and the density argument, landed today through the full
gate. Wave 6 is the largest wave left: thirty-five rows about *saturated* colourings — classes carved by unit circles about their own points — from
three milestones (FS-111, FS-116, FS-121): the pinch at a junction, the saturated fragment, map colourings, and the ladder. Nobody has read these
rows against Lean yet. You do, and you lay the wave out.

## Why this job

A result counts as held only when its Lean module passes the gate, and 111 rows stand in waves 6–10. Wave 6's rows are route M's regularity — "off
a locally finite singular set a saturated class's interfaces are segments and arcs of integer radius" (`LEDGER.md` rows 139–144; `CLAUDE.md`
§ The aim, item 6, and § Where the problem stands, item 31) — the hand results the frontier's next milestones build on. Kooshi, on pricing this work:

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

## The statements

The wave's rows, by module, from the plan (each row's address is in `plans/LEAN-BACKLOG.md`, which gives its derivation file's line; the plan's CSV
gives its disposition and any ruling):

> **Wave 6** (35 rows):
> — source: plans/FS131-kernel-plan.md

> - `Plane/Saturated/Pinch`: FS111-M-HALF, FS111-M-PINCH, FS111-M-C11, FS111-M2-HULLC, FS111-W-KB-DIR, FS111-W-NOBEND, FS111-M2-INTRAD, FS121-D3-FALLSAT, FS121-V2-EROSION-DIAM
> — source: plans/FS131-kernel-plan.md

> - `Plane/Saturated/Fragment`: FS116-O1-SATPIN, FS116-N1-AXIS, FS116-S1-RUNG, FS116-V4-PARTNER, FS116-S1-KAPPA, FS116-S1-PAIR
> — source: plans/FS131-kernel-plan.md

> - `Plane/Saturated/MapColouring`: FS121-C1-BOUND, FS121-C1-SAT, FS121-C1-GMAP
> — source: plans/FS131-kernel-plan.md

> - `Plane/Saturated/Ladder`: FS121-D2-EXT, FS121-D2-THIN, FS121-DB1-L3, FS121-O1-ENDS, FS121-O1-OUT, FS121-V2-SECTOR, FS121-D1-EROSION, FS121-V5-LOC, FS121-V5-RAY, FS121-D2-SYM, FS121-D4-HOLE, FS121-DB1-L6, FS121-DB1-L7, FS121-V3-CPI, FS121-V2-VT-W, FS121-D1-PENCILWIN, FS121-D2-PERFIN
> — source: plans/FS131-kernel-plan.md

> - merged here: FS111-W-NOREP → FS121-DB1-L3; FS121-D1-VT → FS121-V2-VT-W
> — source: plans/FS131-kernel-plan.md

The plan warns that this wave's definitions are where a statement defect is likeliest: its § 7.3 item 2, quoted above, names wave 6's "honest" and
"`D-NF`" among the words the derivations never fixed. Fix them in the foundation before any row is stated, and say what each choice costs.
## Done means

1. **Your readback first**: check every quotation above against its source; read the plan's §§ 7.1–7.5 and its CSV rows for wave 6, each row's
   entry in `plans/LEAN-BACKLOG.md` and its derivation entry in full, with errata; what `Proofs/HadwigerNelson/Plane/` already holds that the rows
   reuse (waves 3–5: sectors, unit arcs, the moves, terminal maps — read `ARCHITECTURE.md`'s rows). Register, before reading the derivations closely, which rows you expect to be short, which to need
   an outside theorem, and which to hide a statement defect. Build the branch once as given. Open your record. Commit and push.
2. **The dispositions**: for each of the thirty-five rows — the statement at the class its argument reads (G92), what it rests on inside the backlog,
   every hypothesis from outside it (named, with `LEAN.md` § Assumptions' four items for an imported theorem; formalize anything that is about an
   hour of work), and whether it is a theorem, a named-hypothesis implication, or a certified computation (`LEAN.md` § The kernel's cost model).
   A row whose derivation does not support its statement is a message to me at once.
3. **The foundation, sorry-free**: the definitions the rows' words need, each with a spec example that would fail if it drifted and each structure
   with a named inhabitant; the domain-modeling pass (`debruijn-domain-modeling`, invoked fresh) over it.
4. **The skeleton**: every row a statement with `sorry` at its leaves, building through the worktree's `./scripts/build.sh` with only `sorry`
   warnings; each formal statement read back against its row in your record; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py`
   exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; no name you declare stands in another module
   (`./scripts/dupnames.sh` on your tree: no name declared by two modules).
5. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from the first
   two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the hypotheses' inhabitants, and a handoff
   for implementers with how two could split the work by file. A leaf you can prove in about an hour, prove, and say so.
6. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k6/`. Thirty-five rows are more than one planning pass may hold: stopping at a
   saved stage with the dispositions and the foundation done and the skeleton for one or two modules is a good report — say where a second pass
   takes over.

## What is yours to decide

The modules and their layout, the foundation's definitions, the form of each statement within what its row claims, what is formalized and what is
named as a hypothesis, and the order. The plan's wave table is a planner's first sorting, written before any of these rows was read closely; where
a row belongs with another wave, or two rows are one theorem, say so. Attack the rows: a statement that is true only at a narrower class than its
entry says, or a "given MR" that hides more than MR, is the finding this job is best placed to make. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
