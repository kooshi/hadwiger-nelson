# Brief FS131-K6c — wave 6's third planning pass: the ladder's fourteen rows, the fragment's six, and three more, stated over the foundation and the fan two passes built

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K6c
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 6's third planner — read the arguments neither earlier pass read, then state the rows that are left (the ladder, the fragment, three more) as new modules over the wave's foundation, fan and curve notion, `sorry` at each leaf, each statement read back against its row, a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the second pass (FS131-K6b) handed back; the wave's implementers are proving its existing files on branches of their own, cut from commits of this branch
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address: it goes to a deriver), a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K6c.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w6-kernel-plan.md` (on branch `fs131-w6`; the two passes' record — your stages from 13, headed FS131-K6c)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6` (branch `fs131-w6`, at `32f2ab4c`): **new modules only** under `Proofs/HadwigerNelson/Plane/Saturated/` (the plan names `Ladder` and `Fragment`; the layout is yours), with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "FS131-K6c", above the `=== PURCHASED ===` banner), `plans/FS131-w6-kernel-plan.md`, `tools/fs131_k6c_*.py`, `data/fs131/k6c/`, `data/fs131/reports/FS131-K6c.md`; **not** the wave's eight existing modules (`Basic`, `Pinch`, `MapColouring`, `Fan`, `FanExamples`, `Curve`, `LocalGraph`, `FanBridge` are fixed: four implementers are proving them on branches cut from this one — a statement you need there is a message, a lemma you need beside them goes in a module of your own), any landed module beyond new declarations, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the plan of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is thirty-five rows about *saturated* colourings — classes carved by unit circles about
their own points — the regularity half of route M. Two planning passes have built its ground: a foundation over two sets on an open set and
over a family, the pinch, a curve notion (unit speed, tangent angle 1-Lipschitz), the fan at a singular point as a structure with an
inhabitant, and — new today — a deriver's proof, stated in Lean, that the fan follows from local finiteness of the singular set. Twelve rows
are stated or proved. Twenty-three, and one clause of another, are not, and almost none of their arguments has been read in this
milestone. They are yours.

## Why this job

A result counts as held only when its Lean module passes the gate. The rows left are the ones the frontier's next milestones cite most — the
ladder of unit parallels, sectors at the singular set, the saturated fragment (`LEDGER.md` rows 139–148; `CLAUDE.md` § Where the problem
stands, item 31) — and each earlier pass over this wave found filed statements that hid a hypothesis: these are the rows where the next one is
likeliest. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the two passes and the deriver handed back, and the rulings in force (read each item whole in the inventory):

> 486. **FS131-K6 done at its Stage 7: wave 6's first planning pass — dispositions for all 35 rows, the foundation, four rows proved at a wider
> — source: plans/FS131-close-inventory.md

> 487. **Rulings on K6's held items, and two slots.** (a) FS121-D1-VT is declared under its own name as VT-W's `C¹` case (its merge condition
> — source: plans/FS131-close-inventory.md

> 501. **FS131-K6b done at its Stage 12: wave 6's second planning pass — the foundation restated (item 495), the fan a library module with
> — source: plans/FS131-close-inventory.md

> 502. **Rulings on K6b's held items, and its slot.** (a) **The deriver's check runs now** (ruling 499): FS131-E8 resumed on a dated
> — source: plans/FS131-close-inventory.md

> 491. **FS131-E8 done: nine entries derived, none stalled — the bridge (item 490, its §§ 3.1–3.7 unchanged since), the consumers traced row by
> — source: plans/FS131-close-inventory.md

The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

> ### 7.3 What each wave's planning job must hold
> — source: plans/FS131-kernel-plan.md

> 1. **Reads its rows' derivation entries in full** (the CSV gives each row's address in `plans/LEAN-BACKLOG.md`, which gives the derivation file's line),
> — source: plans/FS131-kernel-plan.md

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md

> 5. **Checks vacuity at the seam**: a route lemma over a class the backlog proves empty (wave 8's V6 lemmas, ruling R4) carries
> — source: plans/FS131-kernel-plan.md

## The statements

What is yours, exactly, in the second pass's words (its record's § 12.4, six paragraphs; read the section whole, with the first pass's § 2 —
the dispositions of all thirty-five rows, yours marked "second pass" — and § 7.2):

> ### 12.4 What a third planning pass takes, exactly
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> - **The ladder, 14 of its 17 rows**: FS121-D2-EXT, -D2-THIN, -D2-SYM, -D2-PERFIN, -O1-ENDS, -O1-OUT, -DB1-L6, -DB1-L7, -D1-EROSION, -V5-RAY,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 12.4 What a third planning pass takes, exactly

> - **The fragment's six**: FS116-O1-SATPIN, -N1-AXIS, -S1-RUNG, -V4-PARTNER, -S1-KAPPA, -S1-PAIR (the last two at `ArcMap 6`, ruling 487 (e)).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 12.4 What a third planning pass takes, exactly

> - **FS111-M2-HULLC** (on a cover `disj` can fail: read `plans/FS111-M2-regularity.md` § 2.2 first; ruling 487 (b)), **FS111-W-KB-DIR** (a fan
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 12.4 What a third planning pass takes, exactly

> - **Arguments not read by either pass**: `plans/FS121-DB1-verification.md` §§ 2.3, 2.5; `FS121-V2-verification.md` §§ 2.5–2.9;
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 12.4 What a third planning pass takes, exactly

> - **Unresolved expectations**: X5 (b) (ENDS's "null set of normals" against L6's "finitely many"), (d), (e).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 12.4 What a third planning pass takes, exactly

> - **What the third pass can lean on**: rows over a fan at one point take `(F : c.Fan z) (hsat : SaturatedOn c.cls (ball z F.r \ {z}))`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 12.4 What a third planning pass takes, exactly

The deriver's table of which row reads what of the fan — confirmed against the arguments for two rows only, read from entries for most
(`/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md` § 4.6; its Stage 6, if present, is a check of the second pass's statements):

> ### 4.6 Row by row, for wave 6's second planner (added on the coordinator's word, inventory item 490; §§ 3.1–3.7 unchanged)
> — source: plans/FS131-E8-derivation.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the two passes' record whole (Stages 1–12), the wave's eight
   modules, the deriver's record, and the plan's §§ 7.1–7.5. Register, before reading the unread arguments: which rows you expect to hide a
   statement defect, which pairs to be one theorem, and how many you will state. Build the branch once as given (31 `sorry` leaves in five
   files, none yours). Open your stages in the record with what you may and may not change. Commit and push.
2. **The arguments, read in full** — the list in § 12.4 — before a row is stated; the dispositions of the first pass's § 2 revised where an
   argument reads a different class than its entry (the second pass found five such among the rows it read). A row whose argument does not
   support its statement is a message to me at once.
3. **The rows, stated**: each with `sorry` at its leaves over what the wave already holds — a fan at one point, `RegJFan` or saturation with
   `SingLocallyFinite`, `IsUnitCurve`, the family forms for a fragment — and read back against its row. Rulings in force: FS121-D1-VT under
   its own name as VT-W's `C¹` case (487 (a)); FS111-M2-HULLC's finite-perimeter step a named classical hypothesis unless no row reads the
   conclusion (487 (b)); FS116-S1-KAPPA and -S1-PAIR at `ArcMap 6` (487 (e)); every theorem that takes a `Fan` or `RegJFan` carries the
   docstring line of ruling 490 (b), as the second pass wrote it. The three expectations left open (X5 (b), (d), (e)) are settled or
   reported.
4. **Vacuity and inhabitants**: the first pass's § 2 names six classes no held object inhabits (FS121-D2-EXT, -D2-THIN, -D1-PENCILWIN,
   -V5-RAY, -D4-HOLE, and O1-OUT's curved case): each such docstring says so in `LEAN.md` § The gate's form — satisfiability open, the
   question named, an object meeting the local hypotheses with the one it fails. Every other structure-valued hypothesis has a named Lean
   inhabitant or an owed one named.
5. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on
   your tree — no name declared by two modules.
6. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from
   the first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), and a handoff for
   implementers by file. A leaf you can prove in about an hour, prove, and say so. If it is short, state the agreement of the two readings of
   the singular set under saturation as a row (the second pass's § 12.5 item 3; ruling 502 (c)).
7. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no
   background process running, and keep what your record cites under `data/fs131/k6c/`. Twenty-three rows may be more than this pass holds:
   the fan rows and the ladder first, the fragment after; stopping at a saved stage and saying exactly where a fourth pass takes over is a
   good report.

## What is yours to decide

The modules and their layout, the form of each statement within what its row claims, which rows are one theorem and its corollary (the first
pass proposed FS121-DB1-L7 with -O1-OUT), what is formalized and what is named as a hypothesis, and the order. Two minds planned what you
stand on and neither read your rows' arguments: where the foundation or the fan does not carry what a row reads, say so by message before
working around it — the implementers have not yet built far on those statements, and a change now is cheap. Attack the rows: a statement true
only at a narrower class than its entry says is the finding this job is best placed to make. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
