# Brief FS131-K8b — wave 8's second planning pass: the nine semi-hub rows and two more, the plans for two stated leaves, and the hypothesis from wave 7

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K8b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 8's second planner — read the arguments the first pass did not, then state the nine semi-hub rows, FS116-N2-SIXRING and FS116-RING-TWIST-C as new modules over the wave's foundation, `sorry` at each leaf, each statement read back against its row; write the plans for `outerAdj` and `doubleTip`; define the three words the foundation lacks; state wave 7's FS114-N7-QOPP as a named hypothesis; a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the first pass (FS131-K8) handed back; the wave's first implementer proves that pass's leaves on a branch of its own, cut from a commit of this branch
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address and the line of the argument: it goes to a deriver), a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, the hash of a shared module, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K8b.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w8-kernel-plan.md` (on branch `fs131-w8`; the first pass's record — your stages continue its numbering, headed FS131-K8b)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8` (branch `fs131-w8`, at `f1c13612`): **new modules only under `Proofs/HadwigerNelson/Plane/RingCalculus/` (the plan names `SemiHub`; FS116-N2-SIXRING and FS116-RING-TWIST-C, which the first pass assigned to `Star`, go in a module of yours that imports it)**, with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "FS131-K8b", above the `=== PURCHASED ===` banner), `plans/FS131-w8-kernel-plan.md`, `tools/fs131_k8b_*.py`, `data/fs131/k8b/`, `data/fs131/reports/FS131-K8b.md`; **not** the wave's three existing modules (`Proofs/HadwigerNelson/Plane/RingCalculus/Basic.lean` is shared with wave 9 by ancestry and is not edited by anyone; `Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean` and `Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean` are fixed: an implementer is proving them on a branch cut from this one — the one exception is the *statements* of `outerAdj` and `doubleTip` in `Empty`, the two leaves that implementer leaves alone, which are yours to correct if their arguments require: tell me first, and edit nothing else in that file), any landed module beyond new declarations, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the plan of wave 8 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 8 is twenty-two rows of the ring calculus — what the unit circle about a vertex of a
valid map carries, in the class with no Siamese pair. Its first planner wrote the foundation, proved three rows and stated eight more, and
disposed eleven from their entries only: the nine *semi-hub* rows and two others. Those eleven are yours, with the plans for two leaves it
stated without reading their arguments.

## Why this job

A result counts as held only when its Lean module passes the gate. The semi-hub rows say what a ring passes to the vertices it
places, the held ground of the frontier's first-ranked stub, the (Q) ring (`plans/STUB-q-ring.md`; `LEDGER.md` rows 145–150) — and the
first planner names three words in them that its foundation does not define, each of which it expects to hide a statement defect. You are
the first mind in this milestone to read their arguments. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the first pass handed back and the rulings in force (read each item whole in the inventory):

> 518. **FS131-K8, by message mid-job: wave 8's foundation written, three rows proved on the way, five generalizations, a shorter
> — source: plans/FS131-close-inventory.md

> 524. **FS131-K8 done at its Stage 5: wave 8's first planning pass — the foundation, three rows proved, eight rows stated with ten
> — source: plans/FS131-close-inventory.md

> 525. **Rulings on K8's held items, and its slot.** (a) **One implementer, FS131-I8A, on `Plane/RingCalculus/Empty`'s six leaves
> — source: plans/FS131-close-inventory.md

> 498. **The planners of waves 7, 8 and 9 are prepared, and can run at once: no wave among 6–9 waits on another but for four named rows**
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

What is yours, in the first pass's words — its dispositions of your rows (each from the row's entry only where its "read" column says E), its
list of what the foundation lacks, and its handoff. Read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md`); these are the lines that are yours:

> ## Stage 2 — SAVED: the dispositions
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-N2-SIXRING | A | theorem, **not stated** (second pass) | six colours at `p` (`coloursAt p = univ`), non-Siamese, no simplicity; five clauses; the covering step ("six closed sets of at most 60° cover the circle, so each is exactly a 60° arc") is a measure/compactness argument on the circle — the one heavy leaf; inhabitant `sixFrag` (landed) | N1-TWIST-D, SR1-SIXQ (landed) | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-RING-TWIST-C | E | theorem, **not stated** (second pass) | first clause is landed TWIST-D (merge SR2-4.3-21); the parity is over *colour changes*; its hypotheses have no held model at six colours (entry) — a satisfiability-open note, and the count of points in a window needs a finite-set form | N1-TWIST-D | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-N3-PAIR | E | theorem (second pass) | non-Siamese simple; "both germs of one pair on (Q) arcs with the same pair of colours" is `GermOnQWith` twice | — | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-N3-STAR2 | E | named-hypothesis implication (second pass) | takes FS114-N7-QOPP as a hypothesis under this wave's own name (brief); needs "an edge of `p` in a window" and "counter-clockwise order of four tiles" defined — by cones (§ 3.3) | N3-PAIR; wave 7's N7-QOPP | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-N3-CONE | E | theorem (second pass) | six half-plane clauses and an edge clause; the first four are wave 3's `germR_*` in tile form (R, R′ are the ring tiles at `y`) | NOBOTH, U1, GERM-R, RING-GERM | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-N3-CROSS | E | named-hypothesis implication (second pass) | radius above 2; "cone of zero angle" to define (§ 3.3); QOPP as a hypothesis | N3-CONE, N3-STAR2, RING-GERM; N7-QOPP | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-V5-OUT2 | E | theorem (second pass) | **likely already proved here**: "if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour c has its cone at p in [θ + 90°, θ + 270°]" is `star_outer_cone` at `ψ = θ` (valid, non-Siamese, any point `p`); the second pass confirms against V5's argument that nothing more is meant | V4-DICHOTOMY | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-V5-QCOL | E | theorem (second pass) | its setting is V5's (a change point of a vertex of at least four colours, non-Siamese simple); five clauses | V5-NE1 | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-V5-DICHO | E | theorem (second pass) | a statement about either pair: wants a pair-generic "both germs on (Q) arcs" (§ 3.3) | V5-NE1, V5-QCOL, V5-U1 | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-N3-SEMI | E | theorem (second pass) | three alternatives; both kinds | N2-STAR, N3-CONE, -PAIR, -STAR2, RING-GERM, V5-DICHO, -OUT2, -QCOL, -U1 | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS116-RING-TRANSFER-QC | E | composition (second pass) | radius above 2, four colours; a conjunction of SEMI, PAIR, STAR2, CROSS — likely no declaration of its own beyond a bundling theorem | the SemiHub rows | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS129-SR3-OUTERADJ (carrying FS116-V6-ADJ) | E | theorem, stated (`outerAdj`) | its wording read as `O_y = {c} = O_y′` (the literal reading is never met: a correction owed, inventory item 518) | RING-GERM (ii), GERM-R, V4-DICHOTOMY, SR1-TWOCIRC | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> | FS129-MR1-DOUBLETIP | E | theorem, stated (`doubleTip`) | `SimpleOn (closedBall p 1)`; the entry's uses-only reads *simple* at the two hubs only ("one cone per tile at a vertex") — a candidate narrowing, unverified | Y4-FLANK, RING-GERM (i), V4-TWIST, V4-DICHOTOMY | none |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> **The hypothesis from wave 7**: FS114-N7-QOPP enters FS116-N3-STAR2, -N3-CROSS and RING-TRANSFER-QC. None of the three is stated in this
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> ### 3.3 Seams left open, by name (for the second pass)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> - **`IsSemiHub`, `IsFullSemiHub`** are four near-identical clauses. No row is stated over them yet; a pair-generic helper
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> - **Words the SemiHub rows use and the foundation does not define**: "an edge of `p` between tiles `t`, `t′` in a window `[α, β]`"
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> - **`GammaFreeRing`** reads "no arc of `Γ` lies on it"; the entry's gloss "(`Γ ∩ ω(p)` finite)" is equivalent on a covered ring only, and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> - **No concrete tip.** No example exhibits a tip or an outer tile on a valid map: the class's inhabitants (the bowtie, the strip) are not
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> - **`outerAdj`**, **`doubleTip`**: arguments not read in this pass (`plans/FS129-SR3-audit.md` § 2.2–2.3, `plans/FS129-MR1-audit.md`).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> ### 5.5 Inhabitants and vacuity
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> ### 5.6 The handoff
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

> - **The second planning pass (K8b)** takes: the nine SemiHub rows (arguments `plans/FS116-N3-proof.md`, `plans/FS116-V5-verification.md`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/plans/FS131-w8-kernel-plan.md

Wave 7's statement of FS114-N7-QOPP, final, on `origin/fs131-w7` at `195c7855` (not on your branch; the names are wave 7's own):

> theorem qArc_inner (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {u v : ℝ} {c c' : Fin k} (hA : F.IsRingArc p u v c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/Proofs/HadwigerNelson/Plane/FourColour/Local.lean

> theorem qArc_outer (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {u v : ℝ} {c c' : Fin k} (hA : F.IsRingArc p u v c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/Proofs/HadwigerNelson/Plane/FourColour/Local.lean

> theorem qArc_ne (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {u v : ℝ} {c c' : Fin k} (hA : F.IsRingArc p u v c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/Proofs/HadwigerNelson/Plane/FourColour/Local.lean

> theorem qArc_cone_disjoint (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {u v : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/Proofs/HadwigerNelson/Plane/FourColour/Local.lean

> theorem qArc_others_absent (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hS : F.SimpleOn {p}) (hpd : p ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/Proofs/HadwigerNelson/Plane/FourColour/Local.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read the first pass's record whole, the wave's modules, and the
   plan's §§ 7.1–7.5. Register, before reading the unread arguments: which rows you expect to hide a statement defect, which to be one
   theorem, and how many you will state. Build the branch once as given (10 `sorry` leaves in two files, none yours to prove). Open your stages in the record with what you may and may
   not change. Commit and push.
2. **The first pass's questions first**, each from its argument: is FS116-V5-OUT2 exactly `star_outer_cone` (then it is a citation, not a
   declaration); do `outerAdj` and `doubleTip` stand as stated (the first pass read their entries only, and names a candidate narrowing of
   `doubleTip`'s `SimpleOn` hypothesis); what the three undefined words mean in the arguments that use them. A filed statement that needs a
   hypothesis its entry lacks is a message to me at once — and say which kind you have: a *statement* defect, or a *route* that reads more
   than the statement needs (a shorter-route note, no defect). One mid-job report this session was the second kind and was retracted by its
   reporter within the hour; check which before you send.
3. **The arguments, read in full** — the records the first pass names for each row, with their verifiers' — before a row is stated; its
   dispositions revised where an argument reads a different class than its entry. A row whose argument does not support its statement is a
   message to me at once.
4. **The three words, defined**: "an edge of `p` between two tiles in a window", "a cone of zero angle", "the tiles of `p`,
   counter-clockwise" — each a definition in a module of yours with a spec example, by `debruijn-domain-modeling` invoked fresh, read against
   every argument that uses it; and the pair-generic helper for semi-hubs if the rows want statements uniform in the pair. `Basic` is not
   edited: wave 9's planner holds it by ancestry.
5. **The rows, stated**: the nine semi-hub rows, FS116-N2-SIXRING and FS116-RING-TWIST-C, each with `sorry` at its leaves and read back
   against its row. **FS114-N7-QOPP enters three of them as a hypothesis under a name of this wave's own** (ruling 498; the first pass
   proposed `QArcsJoinOpposite F p`, from the first sentence of `plans/FS114-derivation.md` l. 793) — a `Prop`-valued definition, never an
   axiom. Wave 7's second planner has stated the row itself: five theorems, quoted above from its branch (inventory item 553) —
   the inner tile's cone window and the whole arc in its closure, the outer tile's cone window, the two colours different, the two cones
   disjoint, and, under four colours and `SimpleOn` at `p`, the other colours of `p` absent along the open arc. "Opposite" arrives as
   two disjoint cones, not as a position in a cyclic order; the first four read no "simple" and any number of colours at `p`. Define
   yours so that these discharge it at the join; if your three rows consume a cyclic position among four tiles, derive it on your side
   from `qArc_cone_disjoint`, and tell me if that does not go. **A second meeting point**: its FS114-N3-ODD (`ring_odd`, stated with
   closed arcs) is the case "no arc of `Γ` meets the window" of FS116-RING-TWIST-C's last clause — state TWIST-C so that the two are one
   theorem and a corollary at the join. **And its foundation**: `Plane/FourColour/Basic` (the tactic edge, the Reuleaux cross and
   bowtie) is whole at `7baeafe8` on `origin/fs131-w7`; if a row of yours wants one of its names, tell me before you re-state anything
   — the answer is a merge of that commit, which I will ask of you then. Send me your definition when it is fixed. FS116-RING-TRANSFER-QC is a conjunction of four of the others: a bundling theorem, or no declaration, by your reading.
6. **The plans for `outerAdj` and `doubleTip`**: their arguments read (`plans/FS129-SR3-audit.md` §§ 2.2–2.3, `plans/FS129-MR1-audit.md`), a
   plan per child, and each statement confirmed or corrected (`outerAdj` is already stated at the corrected reading of inventory item 518).
7. **Vacuity and inhabitants**: the first pass's § 5.5 says which hypotheses have no Lean term yet (a change point of a four-colour vertex
   — wave 7's bowtie is the owed inhabitant) and which are satisfiability-open at six colours (the hub and (Q)-ring questions): each new
   docstring says which, in `LEAN.md` § The gate's form, with the object meeting the local hypotheses but one. FS116-RING-TWIST-C's hypotheses
   have no held model at six colours, by its entry: say so there.
8. **Rows over `SimpleOn`, a caution found today** (inventory item 533 (d)): a non-existence row stated with `F.SimpleOn S` implies the
   row as filed (`Simple.simpleOn`), but a row that is an implication between two class statements does not — its hypothesis grows with
   the class too. State such a row in both readings (on the disc, and literal `Simple`); one argument proves both.
9. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on
   your tree — no name declared by two modules (wave 8's first pass lost a build to three names already declared on `main`).
10. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines of Lean
   and in implementer jobs, never in days** (inventory item 541: this milestone's planners' line counts have been right to within a factor of
   two and their day counts high by ten in jobs; one job proves about 1,300 lines) — re-priced from the first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), and a handoff for
   implementers by file. A leaf you can prove in about an hour, prove, and say so.
11. The report, in standing rule 11's form. You do not merge another branch into this one unless I ask it by message, run the gate, or touch
    `main`. Leave no background process running, and keep what your record cites under `data/fs131/k8b/`. Eleven rows and two plans may be more than this pass holds: the questions and the three words first, then the rows in the order of their dependencies; stopping at a saved stage and saying exactly where a third pass takes over is a good report.

## What is yours to decide

The modules and their layout, the form of each statement within what its row claims, the three definitions, which rows are one theorem and its corollary or a citation of a proved one, what is formalized and what is named as a hypothesis, and the order after the first pass's questions. One mind planned what you stand on and did not read your rows' arguments: where the foundation does not carry what a row reads, say so
by message before working around it — a change now is cheap. Attack the rows: a statement true only at a narrower class than its entry says
is the finding this job is best placed to make. Three failed attempts on one route is a dispatch to the companion your identity names, never
a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment 1 (2026-10-06, at launch) — your branch now holds the empty class, proved; three findings are routed to you

Nothing above is withdrawn but where an item below says so.

1. **Your branch was fast-forwarded** from `f1c13612` to `368a2c1a`, a saved stage of the wave's first implementer (FS131-I8A, still
   running on its own branch; inventory item 567). Your tree was untouched. It now holds `emptyNS` and its six leaves proved, four new
   modules of the implementer's beside the two you were given, and **three** `sorry` leaves, not ten: `outerAdj` in `Empty`, and
   `star_anti` and `star_recip` in `Star` (the implementer is closing `star_recip` now; neither is yours to prove). Your statement
   checks are against `368a2c1a`. Your tree's build predates those six modules: the first build compiles them. "New modules only"
   stands — the implementer's modules are not yours to edit.
2. **`doubleTip` is proved, and by more than its statement** (items 563, 567). It and `v6_hug` are one-line consequences of a lemma
   the implementer found, which reads no Γ-free ring, no simplicity and no condition on the far germs:

> theorem not_sole_tip_of_adjacent_changePoints (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8/Proofs/HadwigerNelson/Plane/RingCalculus/SoleTip.lean

   So items 2 and 6 above change for `doubleTip` (not for `outerAdj`, which stays as written): there is no plan to make. Instead,
   **read that proof against the entries** (`plans/FS129-MR1-audit.md`, and FS116-V6-HUG's): why did they ask for simplicity, the two
   far germs and the Γ-free ring — a route that read more than the statement needs, or a case the Lean hypotheses exclude in another
   way? The implementer's own caution, in its record's Stage 4: two change points 60° apart are held by no fragment, so the lemma's
   hypotheses are not known to be jointly satisfiable. Say what you find, and recommend whether the two rows are restated at the wider
   class; the statements themselves are decided at the wave's landing, not by you or by it.
3. **A gap at one step of `star_anti`, for you to classify** (item 567, quoted below; read it whole): the plan's step "t⁺ ≠ t⁻ by the
   interval argument" does not close when the shared tile's cone at the vertex is the whole circle. Read the argument
   (`plans/FS116-N2-proof.md`, about ll. 220–222) and the Lean lemma it leans on, and say which it is: a statement that needs a
   hypothesis its entry lacks (then say the hypothesis and message me at once), a missing lemma (the full-circle case cannot occur
   between two antipodal hubs — then state it as a leaf with its plan), or a question for a deriver (then draft the question).

> 567. **FS131-I8A, by message mid-job: `emptyNS` is proved and saved; the generalization of item 563 is now carried by a saved stage; a gap at one step of `star_anti`** (source: I8A's message to "main", 2026-10-06; commit `368a2c1a` on `origin/fs131-w8a`, fetched — the full review is at its hand-back).
> — source: plans/FS131-close-inventory.md

4. **State every leaf so that the kernel's statement is the row's** (inventory items 556, 564; `LEAN.md` § Searching — Lean, last
   bullet). A section `variable` enters a theorem only if its statement mentions it. Today an implementer found four leaves of another
   wave's skeleton false for that reason alone — their hypothesis was a section variable the statements never named, and each was
   refuted by a kernel-checked counterexample before it could be proved. After you state a leaf, `#check` it and read the binders the
   kernel shows; where a hypothesis is carried by a section variable the statement does not mention, write `include … in` above the
   leaf. A check that compares elaborated signatures, with controls, is on that implementer's branch, to read or use:
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/tools/fs131_i7a_stmt_check.py`.
5. **Names taken on another branch — restate none of them.** Wave 6's fourth planner found that two of its rows are ring-calculus
   facts and stated them, with helpers, in a module of wave 6 (`Plane/Saturated/Fragment`, on `fs131-w6`): `exists_absent_pair`,
   `kappaChange_comm`, `pair_param`, and under `ArcMap.Valid` the names `kappa`, `rung`, `contact_eq_of_sideDisc`,
   `not_mem_closure_of_germs`, with the definition `KappaChange`. If a row of yours reads one of those facts, take it as a hypothesis
   under a name of your own and tell me — the answer is a merge, which I will ask of you then. It also settled a reading you may
   meet: "saturated on a disc", for a map, is `SaturatedOn F.region U`, never the pointwise `SaturatedAt` at every point, which is
   false at every interior point of a tile of a valid map.
