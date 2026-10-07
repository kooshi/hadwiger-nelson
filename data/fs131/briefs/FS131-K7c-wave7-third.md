# Brief FS131-K7c — wave 7's third planning pass: three answers that implementers wait on, then the pinwheel

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K7c
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 7's third planner — merge the proved count and its six-colour model into the wave's line; check the nineteen stated leaves in the kernel and re-read five of them against what wave 8 found; settle which object the bowtie fragment is, from two filed records that disagree; decide one hypothesis of the bowtie's stop; then write the pinwheel's foundation and state the rows the second pass did not reach, `sorry` at each leaf, each statement read back against its row, a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the second pass (FS131-K7b) handed back; no implementer has started on its nineteen leaves, and none starts before your word
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for each of the three early answers below (items 3, 4, 5 of § Done means — each unblocks a line of implementers, so send it when it is saved, not at the hand-back), a statement defect in a row (at once, with the entry's address and the line of the argument: it goes to a deriver), a correction owed to a filed record, a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K7c.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Assumptions; § Searching — Lean, last bullets), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w7-kernel-plan.md` (on branch `fs131-w7`; the two earlier passes' record — your stages continue its numbering from Stage 8, headed FS131-K7c)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7` (branch `fs131-w7`, at `195c7855`): **new modules under `Proofs/HadwigerNelson/Plane/FourColour/`** (the first pass proposed `Pinwheel` and `BowtieFragment`; the layout is yours); **the statements and docstrings of the nineteen open leaves** of `Proofs/HadwigerNelson/Plane/FourColour/Local.lean` and `Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean` (no implementer has started them: a statement you correct is logged in your record with its reason and named in your message to me); new declarations in `Proofs/HadwigerNelson/Plane/FourColour/Basic.lean`; `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` (a block of your own, headed "FS131-K7c", above the `=== PURCHASED ===` banner) for them and for the merges; `plans/FS131-w7-kernel-plan.md`, `tools/fs131_k7c_*.py`, `data/fs131/k7c/`, `data/fs131/reports/FS131-K7c.md`; **not** an existing declaration of `Proofs/HadwigerNelson/Plane/FourColour/Basic.lean` (`Local` and `Bowtie` read it: a change there is a message first), `Proofs/HadwigerNelson/Plane/SimpleOn.lean` and everything under `Proofs/HadwigerNelson/Plane/RingCalculus/` (wave 8's, shared by ancestry and landing on `main`), `Proofs/HadwigerNelson/Plane/RouteT/` (proved), any landed module beyond new declarations, the derivation records under `plans/` (a correction owed goes to me by message), `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are the third planner of wave 7 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, wave 10 and half of wave 6 are on `main`, and wave 8 is landing as you start: a landing job is running the gate on its joined tree. Wave 7 is twenty rows about a vertex where four
colours meet in a tight six-colour map. Its first planner stated route T's count, which an implementer has since proved, with a six-colour
model of it in the kernel. Its second wrote the four-colour foundation, proved ten declarations, stated nineteen leaves in two modules — and
stopped, past its line, with eight rows and the pinwheel unstated, their arguments unread, and one discrepancy between two filed records
written down with both sides quoted and no side picked. Those are yours. Three lines of implementers wait on your first three answers, which
is why the order below is what it is.

## Why this job

A result counts as held only when its Lean module passes the gate. What is left of wave 7 is the pinwheel — the degree-4 vertex of four
colours whose four tiles turn like blades — and its exclusion with two exceptions; with the bowtie's stop it is the local half of the
unit-arc question (`LEDGER.md` rows 137–138; `CLAUDE.md` § Where the problem stands, item 31). No mind in this milestone has read the
pinwheel's arguments: the second planner read their entries only, and says so. And wave 7 cannot pass the gate until the bowtie fragment —
the explicit twenty-tile map that every structure-valued hypothesis of the wave names as its inhabitant — is in the kernel: four implementer
jobs, which cannot be briefed while two filed records disagree about what that object's central ring carries. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the earlier passes and the wave's implementers handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`; the first lines are quoted here as addresses):

> 553. **FS131-K7b done at its Stage 7: wave 7's second planning pass — the four flags decided, the four-colour foundation
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 564. **FS131-I7A done at its Stage 3: route T's count is proved — nineteen leaves and two models; four of the nineteen were false as the skeleton stated them, repaired as ruled; `anchor` not started** (implementer, Opus; harness 451k and 60 minutes by the task notice; record `fs131-w7a`'s `plans/FS131-I7A-implementation.md`; report `data/fs131/reports/FS131-I7A.md`; four commits, tip `5777e8e7`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 571. **FS131-K8b, by message mid-job: the nine semi-hub rows are stated with no hypothesis for FS114-N7-QOPP** (source: K8b's message to "main", 2026-10-06; by its word `Plane/RingCalculus/SemiHub`, 23 `sorry` leaves, elaborating, not yet built or committed — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 593. **FS131-I8C, by message mid-job: nine of `SemiHub`'s seventeen leaves built and pushed (`1e605b60`), the other eight written and elaborating; a wave 9 leaf has a short proof there; helpers its sibling may want** (source: I8C's message to "main", 2026-10-06 — everything past `1e605b60` is "elaborated, not yet built", its words; the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 595. **FS131-I7M done: the search's six-colour model is a kernel fact on its branch — `RouteT.grid12 : CountData (torusGrid 12 12) 6`; no field failed** (implementer, Opus; harness 406k and 63 minutes by the task notice; record `fs131-w7m`'s `plans/FS131-I7M-implementation.md`; report `data/fs131/reports/FS131-I7M.md`; five commits, tip `c6b169e3`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 568. **FS131-K8b, by message mid-job (its Stage 6 saved at `5d4e4d12`; no Lean of its own yet): three answers from the arguments — `star_anti`'s gap is a defect of the skeleton's hypothesis; `doubleTip`'s extra hypotheses were a route's; FS116-V5-OUT2 is `star_outer_cone`** (source: K8b's message to "main", 2026-10-06).
> — source: plans/FS131-close-inventory.md

> 592. **FS131-I8D, by message mid-job: a statement defect — five statements of `SemiHubPlaces` read "exactly four colours at `p`" and were stated with "at least four", which is four only at six colours** (source: I8D's message to "main", 2026-10-06 — the artifact is read at its hand-back).
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

And since today the gate lists what the library assumes:

> - **Every assumption in hypothesis form is declared to the gate**, in `AssumptionAudit.declared` at the end of
> — source: LEAN.md § Assumptions

## The statements

**What the second pass left you, in its words** — the first lines of the paragraphs that are yours; read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md`, Stages 5–7, and §§ 4.1–4.3 of the first pass):

> **The third planning pass, FS131-K7c** — what this pass did not reach, exactly:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> 1. **Unread arguments**: `plans/FS114-N5-proof.md`, `-N6-proof.md`, `plans/FS114-Y5-construction.md`, `-Y6-construction.md`, and the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> 2. **Rows not stated**: FS114-N5-GRING (N5-BENDG over wave 5's bends; its exclusions are `not_covers_sqrt_three`); FS114-Y3-RSTOP with
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> 3. **Rows stated in part**: FS114-N4-LEMMAS (OWN, LENS stated; **N4-TOP, N4-FIVE, N4-ARC's first clause** are not — they speak of the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> 4. **Held dispositions it should re-read**: ruling 514 (a)'s default "FS114-Y6-HALF merges into Y4-SIDES and Y4-W" holds for SIDES by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **S1 — a whiff of two records that disagree about FS114-Y2-BOWTIE's lune ring** (both quoted, no side picked; not resolved here).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **D1 — statement, minor (one mind, mine; no valid counter-map built)**: N3-HALF's last clause drops the exception its own proof
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> **Price: about 5,500 lines, four implementer jobs, of its own line** — (A) the object, its colour function, local constancy, the tiles
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | `IsReuleauxBowtie.rstopAll` | `lune` and `sides` give the diagonal pattern; then FS114-Y4-DIAG's five steps (`plans/FS114-Y4-construction.md` ll. 183–203): `top`'s sectors; the `X₁ | N` arc on `ω(q₁)` and U1; five colours at `q₁` and `λ = 60°`; the ring of `q₁` just above `r` forces E1 (FS114-Y3-R with YB2-RPREC, the tangent case); `bot`'s sector `(240°, 300°)` has no colour (with YB3-CUSP for the cusp along `300°`) | `lune`, `sides`, `cap_colour`, `own`, `updown`, `coneAt_subset_of_far` | steps 4 and 5: second-order tangencies (**their records — `plans/FS114-YB2-verification.md` (RPREC), `plans/FS114-YB3-verification.md` (DIAG step 7, CUSP) — were not read by this pass**; the implementer or the third planner reads them before the leaf is split) | 1,400 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **`Plane/FourColour/Bowtie`**, second job (`rstopAll`; about 1,400 lines): reads YB2-RPREC and YB3's DIAG first.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **J4 `SimpleOn.not_hasRepeatedColour`** — valid, non-Siamese, simple at `q ∈ dom`: `¬ F.HasRepeatedColour q` (one tile per colour,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> **Totals**: `Local` 13 leaves, about 1,200 lines with the joints: one implementer job. `Bowtie` 6 leaves, about 2,300 lines: two jobs
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md


**The first pass's dispositions of the rows not yet stated whole** (each from the row's entry only — its "read" column says E):

> | FS114-N5-GRING | `FourColour/Bowtie` | T | its two exclusions are corollaries of FS114-Y4-RSTOPALL (`√3 < 2`, the same class); what later rows read of it is N5-BENDG (the bends leave only (Q) and (R2) ring arcs at a degree-4 vertex), which is its own declaration over wave 5's bends | N4-LEMMAS, wave 5's bends | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y2-BOWTIE | `FourColour/BowtieFragment` (proposed) | C | an explicit `ArcMap 6` (twenty tiles over `ℚ(√3)`), valid, non-Siamese, covering `B̄(p, 3√3/5)`, with a Reuleaux bowtie at `p`; the wave's inhabitant; name it apart from wave 4's `bowtie` (FS112-BOWTIE, another object) | — | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y3-RSTOP | `FourColour/Bowtie` | T | about the explicit fragment (Siamese allowed): any valid fragment agreeing with it near `q1`, `q2` has `r` outside its open set; with Y3-R, Y3-D2 | Y2-BOWTIE, FS112-U1 | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N6-NOQ | `FourColour/Pinwheel` | T | with RING60 and CENT; "after the bends" is a hypothesis on the ring's arcs (only (Q) and (R2)), supplied by N5-BENDG; RING60 to be read against wave 3's FS116-N1-QFREE4 | N3-LOCAL's FLANK, N5-BENDG, FS112-U1 | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N7-QOPP | `FourColour/Pinwheel` | T | QOPP, FLANK, CHAIN, one declaration each; one mind — its class (non-Siamese? simple?) is not in the statement | N6-KAPPA, FS112-U1 | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y5-PINALL | `FourColour/Pinwheel` | T | the exclusion with the exception "E1, or E2 at two or more blades" (erratum; SR3 item 27), over its lemmas MU, ALT, POCKET, CASE, REDUCE, PIN120-60, PXKILL | FS114-Y-EDGE (proved here), FS129-SR3-E2ONE | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS129-SR3-E2ONE | `FourColour/Pinwheel` | T | the parity step over ALT at three pairs | PINALL's lemmas | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y6-E2RED | `FourColour/Pinwheel` | T | its chain clause is ALT stated at its exact E2 hypothesis per pair (E2ONE's `uses only` gives them); S1–S5's kills as lemmas; the survivor clause is E2ONE | PINALL's lemmas | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N4-LEMMAS | `FourColour/Bowtie` | T | OWN, LENS (with `NonSiamese`, per its not-claimed line), TOP, FIVE, ARC's first clause; **ARC's second clause and N4-A4NB are sentences about arguments** ("adds nothing beyond", "gives the bowtie no new constraint") and have no formal statement | N3-LOCAL, FS112-U1, -SIX, -A4SIX, -NB4P | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y6-HALF | `FourColour/Bowtie` | T | **one theorem with Y4-SIDES and Y4-W** if those are stated for a single width-1 Reuleaux triangle tile with the cone hypotheses (the class their arguments read); "the stop is not inherited" is a sentence about a proof | Y4-LUNE | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **the pinwheel**: blades `t_j`, centres `q_j`, `w_j`, pocket tiles `μ_j` and colours `m_j`, `M_j`, cones `α_j`; **E0, E1, E2**.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md


**FS114-N7-QOPP as the second pass stated it** — five leaves of `Local`, none proved — and the bowtie's stop, whose `SimpleOn` hypothesis
item 5 below asks about (each head's first line; the whole statement is at its address):

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


> theorem IsReuleauxBowtie.rstopAll (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

**Wave 3's two cone lemmas, on `main`** — which wave 8's second planner reads as carrying four of those five (inventory item 571):

> theorem ringArc_cone_inner (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
> — source: Proofs/HadwigerNelson/Plane/RingGerm.lean

> theorem ringArc_cone_outer (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
> — source: Proofs/HadwigerNelson/Plane/RingGerm.lean


**Two lemmas wave 8 has proved** (the first is `qArc_inner`'s first clause under another name; the second is the joint your record calls
J4):

> theorem qcol_inner_tile (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem simpleOn_not_hasRepeatedColour (hF : F.Valid) (hN : F.NonSiamese) {w : ℂ} (hw : w ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean


## Done means

1. **Your readback first**: check every quotation above against its source; read the record whole, the wave's modules, and the plan's
   §§ 7.1–7.5. Register, before reading the unread arguments: which of the unstated rows you expect to hide a statement defect, which to
   be one theorem with another, how many you will state whole, and which side of the discrepancy (item 4) you expect to be the object.
   Open your stages in the record with what you may and may not change. Commit and push.
2. **The merges, and one build.** Merge `origin/fs131-w7m` (at `c6b169e3`): it holds route T's count proved (`Proofs/HadwigerNelson/Plane/RouteT/Count.lean`, no
   `sorry`) and the six-colour model in the kernel (`Proofs/HadwigerNelson/Plane/RouteT/Grid12.lean`), whole. My trial merge of it into `origin/fs131-w7`
   conflicts in `scripts/Axioms.lean` only — keep both sides' blocks. **`main` is merged later, on my message.** Wave 8 — eleven modules of the ring calculus — is landing as you start. When it
   has landed I send you one message with `main`'s hash: at your next saved stage merge `origin/main` then (my trial of `origin/main`
   into `origin/fs131-w7` today conflicts in `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean` and nowhere else — registry
   files, adjacent lines, both sides kept; wave 8's files will add to those three and to no Lean file of yours); to spare a rebuild of everything `main` gained since your branch left it, copy a green build of `main`'s line over
   yours before you build — `cp -a /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/.lake/build/. /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/.lake/build/` — and only
   while no `lake` runs in that source tree (`pgrep -x lake`, then `readlink /proc/<pid>/cwd` for each); build; and tell
   me the hash. Until then wave 8's statements are read at their path in its implementer's tree (quoted above), and nothing of yours
   restates one.
   Build once now, on the first merge alone, and bring `ARCHITECTURE.md`'s row for `Count` up to what the module now holds (`tools/check_architecture.py` exit 0).
   Commit and push.
3. **The nineteen stated leaves, read from the kernel, and FS114-N7-QOPP re-read — so that `Local`'s implementer can start.**
   (a) `#check` every leaf of `Local` and `Bowtie` and compare the kernel's statement with the file's: a section `variable` enters a
   theorem only if its statement mentions it, and four leaves of this wave's count were false as stated for exactly that reason (inventory
   items 556, 564). The instrument that found them compares elaborated signatures, with controls, and is yours to reuse:
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py` (on your branch after the merge).
   (b) **The relay from wave 8** (item 571; its planner's reading, one mind, not checked by me): of the five `qArc_*`, the cone clause
   of `qArc_inner` and all of `qArc_outer` follow from wave 3's two lemmas with `NonSiamese` idle; `qArc_cone_disjoint` and `qArc_ne`
   are angle arithmetic over those; only `qArc_inner`'s first clause reads `NonSiamese` — and that clause is the lemma wave 8 has since
   proved as `qcol_inner_tile`. Decide, from the arguments: which hypotheses each of the five keeps (one its proof does not read is
   removed now, while the statements are still yours to change), and whether `qArc_inner`'s first clause is stated here at all once
   `main` is merged (two lines never state one lemma: with wave 8's module in your tree it is a citation, not a leaf).
   (c) **J4 is proved** — wave 8's `simpleOn_not_hasRepeatedColour`: your plan's row for `four_le_centre` cites it; nobody mints it.
   (d) Read each leaf's binders against its row's *not claimed* line. Twice today a planner's hypothesis did not match its row, and the
   build could not see it: `interior` of a cone admitted the whole circle where the argument read an open arc (item 568), and "at least
   four colours" stood where the argument read "exactly four" (item 592).
   Then commit, push, and **send me the hash with the line "`Local`'s implementer may be cut from here"** and the list of every leaf
   whose statement you changed, each with its reason; if `main` is not merged yet, say so in that message: I hold the cut until it is, because `four_le_centre` cites a lemma that arrives with it.
4. **The discrepancy about the bowtie fragment** (ruling 553 (a); your record's § 7.2, S1). Which object does `tools/fs114_y2_k1.py`
   build; what does the ring survey (`data/fs116/n1/ring-survey-bowtie.out`, made by `tools/fs116_n1_ring.py`) mean by "off Gamma" on
   the centre's ring between 60° and 120° — a convention under which an arc bounding a tile whose colour is carried at the centre is not
   counted, or a different object surveyed; and do the two model lines (`plans/FS114-derivation.md` ll. 496, 547) and FS116-Z2's
   erratum sentence stand. Read the construction's record (`plans/FS114-Y2-construction.md`) and both tools. This is a question of
   which object was built, not a derivation: you may run the two tools as they are, on the objects they hold, and nothing that
   searches. **By message to me as soon as it is saved**: the answer in one paragraph with the lines that decide it; each correction
   owed (the file, the line, the corrected sentence — I route it to the errata, you edit no derivation record); which rows the
   fragment can be the inhabitant for; and whether your record's § 7.5 stands — its route, its description of the object and its four
   jobs — because the fragment's first job is briefed from that answer: say, by line, what its brief should take as the object. If the
   records and the tools do not settle it, say what would: that is a good answer, and I send it to a deriver.
5. **The bowtie's stop, before `Bowtie`'s implementers.** The second pass planned `rstopAll`'s last two steps from one record without
   its verifiers': read `plans/FS114-YB2-verification.md` (RPREC) and `plans/FS114-YB3-verification.md` (DIAG's step 7, CUSP), and
   decide whether `hS : F.SimpleOn (closedBall p √3)` narrows to the set the argument's points lie in (the second pass names the closed
   unit disc as the candidate) — and, where your reading gives them to you, state DIAG's five steps as `sorry` children, so that the
   1,400-line leaf is split before a job starts on it. With it, your record's D1: N3-HALF's last clause and the exception its own proof
   names. Commit, push, and tell me "`Bowtie`'s implementers may be cut from here".
6. **The pinwheel's foundation**: blades, centres, pockets, and the three exceptions' predicates E0, E1, E2, as definitions with a
   spec example each, by `debruijn-domain-modeling` (invoked fresh), in a module of yours — over what your tree then holds, which
   since the merge of `main` includes all of wave 8's ring calculus (stars, semi-hubs, tips, change points, the tiles at a point in
   cyclic order). **Before you state a helper, search the tree for its statement's shape, not for a name**: today an implementer wrote
   two weaker copies of landed theorems, and three lemmas a plan called missing were already in the library (inventory items 584, 596).
7. **The rows, stated**: the unstated rows and the parts left of the four stated in part (your record's § 7.7, items 2 and 3), each
   with `sorry` at its leaves, read back against its row and its *not claimed* line, and `#check`ed as in item 3 (a). FS114-Y2-BOWTIE's
   own statements wait for the fragment's first job unless your answer to item 4 lets you write them now about an object to come —
   your call. A row whose argument does not support its statement is a message to me at once — and say which kind you have: a
   *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than the statement needs (a shorter-route note,
   no defect).
8. **Vacuity, inhabitants, assumptions.** The pinwheel's rows are refutations with no held fragment at `1 + ε` outside its exceptions:
   each docstring says so in `LEAN.md` § The gate's form and names the object meeting the local hypotheses but one. Every other
   structure-valued hypothesis has a named Lean inhabitant or an owed one named (the six-colour count's is `RouteT.grid12`, which the
   merge brings; `kill` has none, and its docstring says so). **And list, for the wave's landing, every assumption in hypothesis form
   that any statement of the wave takes** — a named `Prop` or one written out in a binder, standing for an outside theorem, a hand
   result of ours or an open question — each with its kind and source, in the form of `LEAN.md` § Assumptions: the gate's new step
   fails on one not declared, and the landing declares from your list. You declare nothing yourself and run no gate.
9. **Rows over `SimpleOn`** (inventory item 533 (d)): a non-existence row stated with `F.SimpleOn S` implies the row as filed
   (`Simple.simpleOn`), but a row that is an implication between two class statements does not — its hypothesis grows with the class
   too. State such a row in both readings (on the disc, and literal `Simple`); one argument proves both.
10. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh`
   on your tree — no name declared by two modules.
11. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines of
   Lean and in implementer jobs, never in days** — inventory item 541: this milestone's planners' line counts have been right to within
   a factor of two and their day counts high by ten in jobs; one job proves about 1,300 lines), the obligation-modeling pass
   (`debruijn-obligation-modeling`, invoked fresh), and a handoff for implementers by file that says which jobs can run side by side
   and from which commit. A leaf you can prove in about an hour, prove, and say so.
12. The report, in standing rule 11's form. You do not merge a branch into this one beyond the two named in item 2, run the gate, or
    touch `main`. Leave no background process running, and keep what your record cites under `data/fs131/k7c/`. **This is more than
    one pass may hold.** Items 2–5 come first because implementers wait on them; then the pinwheel's foundation; then its rows in the
    order of their dependencies. Stopping at a saved stage and saying exactly where a fourth pass takes over is a good report — the
    second pass did exactly that, and its handoff is why you can start where it stopped.

## What is yours to decide

The modules and their layout; the statements of the nineteen open leaves, corrected where an argument or the kernel says so; the answer
to the discrepancy, or the statement that the records cannot give one; whether `rstopAll`'s hypothesis narrows; the form of each new
statement within what its row claims; which rows are one theorem and its corollary; what is formalized and what is named as a
hypothesis; and the order after item 5. Two minds planned what you stand on, and neither read the pinwheel's arguments: where the
foundation does not carry what a row reads, say so by message before working around it — a change now is cheap. Attack the rows: a
statement true only at a narrower class than its entry says is the finding this job is best placed to make, and the second pass made
three. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
