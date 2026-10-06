# Brief FS131-K6b — wave 6's second planning pass: the foundation restated over a family, the fan as a module, the bridge's eight new rows, the ladder and the fragment

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K6b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 6's second planner — first restate the foundation's pointwise predicates over a family of sets and save that stage (it unblocks an implementer); then land the fan as a library module with an inhabitant, plan the eight entries a deriver added today (the bridge from "the singular set is locally finite" to the fan) as rows, read the arguments the first pass did not read and state those rows (the ladder, the fragment, five more) with `sorry` at each leaf, a plan and a price per leaf, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the first pass (FS131-K6) handed back, beside jobs of other waves on other branches; the deriver FS131-E8 may still be writing its last stages on `main`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job — **one line when the restated foundation is saved** (§ Done means 2: an implementer launches on a branch cut from that commit); a statement defect in a row or a gap in the deriver's argument (at once, with the address: it goes to the deriver); a generalization or a shorter route; an outside theorem you would import; a change you find you need in `Basic` or `Pinch` after § Done means 2 is saved; or a question you cannot work around. The report goes to `data/fs131/reports/FS131-K6b.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the doubled-name check and the inhabitant rule; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w6-kernel-plan.md` (on branch `fs131-w6`; the first pass's record — your stages from 8, headed FS131-K6b)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6` (branch `fs131-w6`, at `714a972b`): the modules under `Proofs/HadwigerNelson/Plane/Saturated/` — `Basic`, `Pinch` and `MapColouring` for the restatement of § Done means 2 (signatures and the statements of open leaves; no proved theorem loses its proof), and new modules for the fan, the bridge, the fragment and the ladder (the layout is yours); `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in landed modules (no statement, definition or docstring of a declaration that is on `main` is edited); `scripts/Axioms.lean` (a block of your own, headed "FS131-K6b", above the `=== PURCHASED ===` banner), `plans/FS131-w6-kernel-plan.md`, `tools/fs131_k6b_*.py`, `data/fs131/k6b/`, `data/fs131/reports/FS131-K6b.md`; **not** `main` (you read the deriver's record there, you do not write it), another wave's branch, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are taking wave 6 of the Lean backlog from its first planning pass to a skeleton implementers can build. The milestone, FS-131, turns
this project's hand-derived results into kernel-checked ones: 259 rows in ten waves, waves 1–5 on `main`. Wave 6 is thirty-five rows about
*saturated* colourings — classes carved by unit circles about their own points — the regularity half of route M. Your predecessor read twelve of
the rows against their arguments, wrote the foundation, proved four rows at a wider class than filed, and stated eight leaves. It also found that
the hypothesis every later row reads — a *fan* of curves with end tangents at each singular point — is stronger, by four clauses, than the words
the hypothesis was frozen in, and that nothing derived the step between them. A deriver took that question this morning and answered it: the step
holds. So the wave has grown by eight rows, and one of its definitions has become a theorem's conclusion.

## Why this job

A result counts as held only when its Lean module passes the gate. Wave 6's rows are what the frontier's next milestones build on: "off a locally
finite singular set a saturated class's interfaces are segments and arcs of integer radius" (`LEDGER.md` rows 139–144; `CLAUDE.md` § The aim,
item 6). With the bridge in the kernel, every one of them reads, under saturation, one hypothesis — the singular set is locally finite — which is
exactly the open question the frontier asks (FS-127); without it the wave would be held over a hypothesis stronger than the ledger's, joined to it
by one mind's hand argument. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the first pass handed back, the deriver's result, and the rulings in force (read each item whole in the inventory):

> 486. **FS131-K6 done at its Stage 7: wave 6's first planning pass — dispositions for all 35 rows, the foundation, four rows proved at a wider
> — source: plans/FS131-close-inventory.md

> 487. **Rulings on K6's held items, and two slots.** (a) FS121-D1-VT is declared under its own name as VT-W's `C¹` case (its merge condition
> — source: plans/FS131-close-inventory.md

> 481. **FS131-K6, by message mid-job (`fs131-w6` at `c3ffb4e7`, build OK by its word): five rows of wave 6 hold at a wider class than filed;
> — source: plans/FS131-close-inventory.md

> 490. **FS131-E8, by message mid-job (its Stage 3 saved, `0310d854` on `main`, pushed): the bridge under REG-J′ is derived — the frozen
> — source: plans/FS131-close-inventory.md

The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

> ### 7.3 What each wave's planning job must hold
> — source: plans/FS131-kernel-plan.md

> 1. **Reads its rows' derivation entries in full** (the CSV gives each row's address in `plans/LEAN-BACKLOG.md`, which gives the derivation file's line),
> — source: plans/FS131-kernel-plan.md

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md

> 4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an
> — source: plans/FS131-kernel-plan.md

## The statements

What the first pass says you need, in its own words (its record's § 7.2, five items; read the section whole, and its § 2 table of dispositions,
which marks your rows "second pass"):

> ### 7.2 For the second planning pass (the Ladder, the Fragment rows, C11 (ii), INTRAD, HULLC, KB-DIR, NOBEND) — what it needs
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> 1. **First decision: state the pinch locally, over a family.** `Basic` is over `AeColouring k`. Two consumers need more: FS116-O1-SATPIN reads
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 7.2 For the second planning pass

> 2. **The fan**: § 6's design, to land as `Plane/Saturated/Fan` with an inhabitant (`sq9` at a grid vertex: four branches along the axes, constant
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 7.2 For the second planning pass

> 3. **Curves**: the Ladder's rows speak of circular arcs and segments inside `closure 𝓘`; state them over sets `{z + n e θ : θ ∈ I}` with the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 7.2 For the second planning pass

> 4. **Read the FS-116 and FS-121 arguments** (not read here): `plans/FS121-DB1-verification.md` §§ 2.3, 2.5; `FS121-V2-verification.md` §§ 2.3, 2.5,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 7.2 For the second planning pass

> 5. Unresolved from § 1.4: X5 (b) (ENDS's "null set of normals" against L6's "finitely many"), (d) (SATPIN's inner-disc reading), (e) (D2-SYM's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 7.2 For the second planning pass

The fan and the bridge as the first pass designed them (a design file, elaborated but not a library module; read it whole):

> structure Fan (c : AeColouring k) (z : ℂ) where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean

> def RegJFan (c : AeColouring k) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean

> def RegJBridge (k : ℕ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean

The deriver's eight entries — each [hand], one mind, kernel pending — in its record on `main`
(`/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md`; read its Stage 3 whole, every entry's *uses only* and *not claimed* lines, and
§ 3.6's reading of your structure field by field):

> - **FS131-E8-LOCAL** — off Σ the interface set of a saturated colouring is the whole closure of the essential boundary, locally one `C^{1,1}` graph
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-GAMMA** — clause (γ): near an isolated point `z` of Σ, in a disc of radius at most `1/2`, every interface component is an open arc
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-BETA** — clause (β): a component with an end at `z` has increasing distance from `z`, so it is a polar graph with a limit direction: § 3.3.
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-ALPHA** — clause (α): finitely many components meet the half disc, and a smaller disc holds only those that end at `z`: § 3.4.
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-DELTA** — clause (δ): a connected open set meeting no essential boundary and no cusp is almost everywhere of one colour: § 3.5.
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-FAN** — the class: a fan with end tangents at every singular point isolated in Σ, with saturation read in a punctured disc only;
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-BRIDGE** — the instance: saturated with Σ locally finite gives the fan at every point of Σ; `RegJBridge k` holds for every `k`, the
> — source: plans/FS131-E8-derivation.md

> - **FS131-E8-CLAUSE2** — under saturation the frozen words' second clause follows from the first, and every bounded set meets finitely many
> — source: plans/FS131-E8-derivation.md

Its hand-off lines to you, and its two notes on statements the first pass wrote (item 490 has both; the first is in its § 3.1 (2), the second in
FS131-E8-LOCAL's *not claimed* line):

>   handoff: de Bruijn — the statement as a lemma producing the planner's Fan at z from Σ ∩ ball z R ⊆ {z} and saturation at the essential boundary
> — source: plans/FS131-E8-derivation.md

>   handoff: de Bruijn — ∀ c : AeColouring k, Saturated c.cls → (∀ x, ∃ r > 0, (c.singularSet ∩ ball x r).Finite) → c.RegJFan, which gives
> — source: plans/FS131-E8-derivation.md

>   handoff: de Bruijn — c.RegJLiteral follows from Saturated c.cls and local finiteness of c.singularSet; a corollary of FS131-E8-BRIDGE, wanted
> — source: plans/FS131-E8-derivation.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the first pass's record whole (Stages 1–7) and its report
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/reports/FS131-K6.md`), the three modules and the design file, the
   deriver's record through its last saved stage, and the plan's §§ 7.1–7.5. Register, before reading the unread arguments closely: which of
   your rows you expect to hide a statement defect, which to be short, and your price for the bridge. Build the branch once as given (eight
   `sorry` leaves). Open your stages in the record with what you may and may not change. Commit and push.
2. **The foundation restated, saved first** (the first pass's § 7.2 item 1): `H1`, `H2`, `TwoColourAt`, `IsSplitAt`, `HasTwoDiscsAt`,
   `IsTangentAt` over a family of sets, the `AeColouring` forms their instances; with the deriver's two notes — FS111-M-PINCH's two-colour ball a
   neighbourhood of the point, not a ball centred at it, and FS111-M-C11 (ii) carrying "no cusp in the neighbourhood". Nothing is proved over
   `pinch` yet, so this is the cheap moment. The four proved rows and the inhabitants still build; each restated leaf is read back against its
   row; the spec examples still fail when a definition drifts. Build, commit, push, and **send me one line** naming the commit: an implementer on
   `Pinch` then launches on a branch cut from it, so from that commit on `Basic`'s and `Pinch`'s statements are fixed for you too — a change you
   find you need after it is a message to me, never an edit.
3. **The fan as a library module** (the first pass's § 7.2 item 2): the structure, `HasSector`, `HasHorn`, `RegJFan`, `RegJLiteral`, each with a
   spec example, and a named inhabitant (`sq9` at a grid vertex: four branches of constant angle). No `sorry` in the definitions or the
   inhabitant.
4. **The bridge's eight rows**: for each of the deriver's entries — the statement at the class its argument reads, what it rests on, a skeleton
   with `sorry` at its leaves, a plan and a price per leaf. FS131-E8-FAN is the lemma that produces a `Fan` at `z`; -BRIDGE and -CLAUSE2 are its
   corollaries; -LOCAL is, by the deriver's reading, the form of C11 (ii) the kernel needs and holds FS121-V5-LOC with V5-OFF — say which of
   those rows become corollaries. This is where Mathlib has no home (a curve with Lipschitz tangent, its arclength, the components of the
   interface set): use one curve notion for these rows and for the first pass's § 7.2 item 3, re-price from the first two leaves you prove or
   state in full, and read the deriver's two kernel route notes (its § 3.1 (2) and the italic note in § 3.2 (2)). Every theorem that takes a
   `Fan` or `RegJFan` says in its docstring "under saturation equivalent to the singular set being locally finite, by FS131-E8-BRIDGE", with
   that entry's grade until its module lands (ruling 490 (b), which replaces ruling 481 (b)'s wording).
5. **The rows the first pass left**: the ladder (17), the fragment (6), and FS111-M2-HULLC, -W-KB-DIR, -W-NOBEND, -M2-INTRAD and C11 (ii) — each
   argument read in full first (the first pass's § 7.2 item 4 lists them), its disposition revised where the argument reads a different class
   than the entry, then stated with `sorry` at its leaves and read back. Rulings 487 (a)–(c) and (e) are in force: FS121-D1-VT under its own
   name as VT-W's `C¹` case; HULLC's finite-perimeter step a named classical hypothesis unless no row reads the conclusion; the two proposed
   merges yours to confirm; FS116-S1-KAPPA and -S1-PAIR at `ArcMap 6`. A row whose argument does not support its statement is a message to me
   at once.
6. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on your
   tree — no name declared by two modules.
7. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price), the
   obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the inhabitants (the first pass's § 7.1 lists what is owed: `sq9`
   as an `ArcMap 9` for `sat_inP` among them) and the vacuity lines in `LEAN.md` § The gate's form, and a handoff for implementers saying how
   they split by file. A leaf you can prove in about an hour, prove, and say so.
8. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k6b/`. **This is more than one pass may hold.** The order above is the
   order of value: items 2 and 3 unblock implementers, item 4 is the wave's new mathematics, item 5 is the bulk. Stopping at a saved stage with
   items 2–4 done and the ladder or the fragment left to a third pass is a good report — say exactly where it takes over.

## What is yours to decide

The modules and their layout, the family form of the foundation, the curve notion, the form of each statement within what its row claims, which
rows are one theorem and its corollary, what is formalized and what is named as a hypothesis, and the order after item 2. The first pass's plan is
one mind's, and so is the deriver's argument, written this morning and read by me once: the kernel is its second check, and you are the first
reader who has to make it compile. Attack both. A step of the
bridge that does not formalize as written, a constant that is off, a hypothesis a proof reads that an entry does not name — each is a message to
me with the address, and a finding; the deriver may still be running and can answer the same hour. If a row of the ladder turns out to need only
a fan at one point and no local finiteness — or more than the fan gives — say so row by row: the deriver is tracing the same consumers, and I
will send you its table when it arrives. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
