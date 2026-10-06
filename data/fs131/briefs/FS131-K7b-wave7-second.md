# Brief FS131-K7b — wave 7's second planning pass: the thirteen four-colour rows — the tactic edge, the bowtie and the lune, the pinwheel — stated over a foundation you write

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K7b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 7's second planner — read the arguments the first pass did not, write the four-colour foundation (the tactic edge, the degree-4 vertex of four colours, the lens, the Reuleaux bowtie, the pinwheel), then state the thirteen four-colour rows and the two clauses left of route T as new modules, `sorry` at each leaf, each statement read back against its row, a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the first pass (FS131-K7) handed back; the wave's first implementer proves that pass's leaves on a branch of its own, cut from a commit of this branch
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address and the line of the argument: it goes to a deriver), a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, the hash of a shared module, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K7b.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w7-kernel-plan.md` (on branch `fs131-w7`; the first pass's record — your stages continue its numbering, headed FS131-K7b)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7` (branch `fs131-w7`, at `b5ef0e39`): **new modules only under `Proofs/HadwigerNelson/Plane/FourColour/` (the first pass proposed `Local`, `Bowtie`, `BowtieFragment`, `Pinwheel`; the layout is yours)**, with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "FS131-K7b", above the `=== PURCHASED ===` banner), `plans/FS131-w7-kernel-plan.md`, `tools/fs131_k7b_*.py`, `data/fs131/k7b/`, `data/fs131/reports/FS131-K7b.md`; **not** the wave's four existing modules (`Proofs/HadwigerNelson/Plane/SimpleOn.lean` is shared with waves 8 and 9 by ancestry and is not edited by anyone; `Proofs/HadwigerNelson/Plane/RouteT/Basic.lean`, `Proofs/HadwigerNelson/Plane/RouteT/Rainbow.lean`, `Proofs/HadwigerNelson/Plane/RouteT/Count.lean` are fixed: an implementer is proving the last two on a branch cut from this one — a statement you need there is a message, a lemma you need beside them goes in a module of your own), any landed module beyond new declarations, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the plan of wave 7 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 7 is twenty rows about a vertex where four colours meet in a tight six-colour map. Its
first planner stated the seven rows of route T's count on a combinatorial map, proved three of them in part or whole, fixed what "simple"
means on a fragment (`ArcMap.SimpleOn`), and disposed the other thirteen from their entries only — it read none of their arguments, and says
so. Those thirteen, and two clauses of route T that need their vocabulary, are yours.

## Why this job

A result counts as held only when its Lean module passes the gate. The thirteen rows are the local half of the unit-arc question — what
a four-colour vertex of degree 4 forces within an explicit radius: the bowtie's stop, the pinwheel's exclusion with its two exceptions
(`LEDGER.md` rows 137–138; `CLAUDE.md` § Where the problem stands, item 31). The first
planner flagged four of their filed statements as likely to hide a hypothesis, from the entries' own words: you are the first mind in this
milestone to read their arguments. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the first pass handed back and the rulings in force (read each item whole in the inventory):

> 512. **FS131-K7, by message mid-job: route T's rows — three proved on the way, six generalizations, three hypotheses the formal
> — source: plans/FS131-close-inventory.md

> 513. **FS131-K7 done at its Stage 4: wave 7's first planning pass — route T's seven rows stated on a combinatorial map, three proved in
> — source: plans/FS131-close-inventory.md

> 514. **Rulings on K7's held items, and its slot.** (a) **Its plan's § 4.3, six dispositions, each at its stated default**: the
> — source: plans/FS131-close-inventory.md

> 508. **FS131-K7, by message mid-job: the plan's open word "simple" for a fragment is decided — the narrower reading, as a new predicate
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
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md`); these are the lines that are yours:

> ### 4.1 The dispositions
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N3-LOCAL | `FourColour/Local` (proposed) | T | six lemmas, each its own declaration; **N3-FACE and FS114-Y4-UPDOWN are one theorem** (the entry says so); N3-FACE needs the pair far; N3-PAIR to be read against wave 4's `pair_i`, `pair_ii`; N3-ODD against wave 3's twist rows before it is stated | FS112-U1, wave 3's ring rows | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N4-LEMMAS | `FourColour/Bowtie` | T | OWN, LENS (with `NonSiamese`, per its not-claimed line), TOP, FIVE, ARC's first clause; **ARC's second clause and N4-A4NB are sentences about arguments** ("adds nothing beyond", "gives the bowtie no new constraint") and have no formal statement | N3-LOCAL, FS112-U1, -SIX, -A4SIX, -NB4P | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N5-GRING | `FourColour/Bowtie` | T | its two exclusions are corollaries of FS114-Y4-RSTOPALL (`√3 < 2`, the same class); what later rows read of it is N5-BENDG (the bends leave only (Q) and (R2) ring arcs at a degree-4 vertex), which is its own declaration over wave 5's bends | N4-LEMMAS, wave 5's bends | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y2-BOWTIE | `FourColour/BowtieFragment` (proposed) | C | an explicit `ArcMap 6` (twenty tiles over `ℚ(√3)`), valid, non-Siamese, covering `B̄(p, 3√3/5)`, with a Reuleaux bowtie at `p`; the wave's inhabitant; name it apart from wave 4's `bowtie` (FS112-BOWTIE, another object) | — | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y3-RSTOP | `FourColour/Bowtie` | T | about the explicit fragment (Siamese allowed): any valid fragment agreeing with it near `q1`, `q2` has `r` outside its open set; with Y3-R, Y3-D2 | Y2-BOWTIE, FS112-U1 | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y4-LUNE | `FourColour/Bowtie` | T | LUNE (without "simple": YB3), SIDES (Siamese allowed), UPDOWN (= N3-FACE), W | FS112-U1 | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y4-RSTOPALL | `FourColour/Bowtie` | T | the seed: `Valid`, `NonSiamese`, `SimpleOn` on the points read, a Reuleaux bowtie at `p` (reading R-T), `closedBall p 1 ⊆ dom`, `r ∈ dom` ⟹ `False`; N3-DR and N4-D as corollaries (the merge) | Y4-LUNE, Y3-R, FS112-U1 | none | E | not stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-Y6-HALF | `FourColour/Bowtie` | T | **one theorem with Y4-SIDES and Y4-W** if those are stated for a single width-1 Reuleaux triangle tile with the cone hypotheses (the class their arguments read); "the stop is not inherited" is a sentence about a proof | Y4-LUNE | none | E | not stated |
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

> | FS114-N2-ENDS | `RouteT/Count`; its second sentence with the tactic edge | T | the identity and N2-SLACK on `CountData 6`, `chi2 = 0`; the tactic edge's end and centre in the second pass | N114-ROOM, N2-FIVE | as above | A | identity stated |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> | FS114-N3-JOINT | `RouteT/Count`; N3-PAY with the bowtie | T | first clause = ENDS (SR2 item 15); N2-KILL as `kill`; the assignment form as `joint`, no radius read | N2-ENDS; N3-CONT for N3-PAY | as above | A (N2-KILL), E (N3 § 3.2) | stated but N3-PAY |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> Merged (the CSV's): FS114-N3-DR, FS114-N4-D → FS114-Y4-RSTOPALL (SR2 item 16); their relay lemmas N3-CONT (for N3-PAY) and N3-DR1 are
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> ### 4.2 The four-colour foundation the second pass writes (from the records' headers, before any row is stated)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **a tactic edge** at `p` (FS114-N2's definition, `plans/FS114-N-proof.md` l. 246): in the library's words a ring arc of `ω(q)`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **a degree-4 vertex of four colours** (`HasDegree p 4`, `(coloursAt p).ncard = 4`) with its four tiles `t₁ … t₄` in cyclic order and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **a lens** (N3-SEC), **a width-1 Reuleaux triangle** `Reul(p, q₁, q₂)`, **the Reuleaux bowtie** with reading R-T (it includes its four
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> - **the pinwheel**: blades `t_j`, centres `q_j`, `w_j`, pocket tiles `μ_j` and colours `m_j`, `M_j`, cones `α_j`; **E0, E1, E2**.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> ### 4.3 Held for Keryx's ruling (each a disposition that differs from the CSV, or a form changed within what a row claims)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

> **The second planning pass, FS131-K7b** (about 400k): reads `plans/FS114-N3-proof.md` … `-N7-proof.md`, `plans/FS114-Y2-` …
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7/plans/FS131-w7-kernel-plan.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the first pass's record whole, the wave's modules, and the
   plan's §§ 7.1–7.5. Register, before reading the unread arguments: which rows you expect to hide a statement defect, which to be one
   theorem, and how many you will state. Build the branch once as given (20 `sorry` leaves in two files, none yours). Open your stages in the record with what you may and may
   not change. Commit and push.
2. **The four flagged places first**, each from its argument: FS114-N3-LOCAL's N3-FACE without "far"; N3-ODD's parity against
   FS116-N1-TWIST-LIT; FS114-N4-LEMMAS' N4-LENS without the non-Siamese hypothesis its own *not claimed* line requires; FS114-N7-QOPP's
   unstated class. Each is confirmed or cleared, with the line of the argument that decides it. A confirmed one is a message to me at once
   (ruling 512 (iii)) — and say which kind you have: a *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than
   the statement needs (a shorter-route note, no defect). One mid-job report this session was the second kind and was retracted by its
   reporter within the hour; check which before you send.
3. **The arguments, read in full** — the records the first pass names for each row, with their verifiers' — before a row is stated; its
   dispositions revised where an argument reads a different class than its entry. A row whose argument does not support its statement is a
   message to me at once.
4. **The foundation**: § 4.2's vocabulary as definitions with a spec example each, written with `debruijn-domain-modeling` and
   `debruijn-experience-modeling` (each invoked fresh) over what `main` already holds (waves 3–5: ring arcs, `BothKind`, the bends; wave 4's
   `bowtie` is another object — name yours apart). **Waves 8 and 9 read the tactic edge and the bowtie**: when the foundation module builds
   with no `sorry`, commit it alone and send me the hash, so a sibling branch takes it by ancestry and nobody re-declares a name (inventory
   items 511, 523). Wave 8's own foundation (`Plane/RingCalculus/Basic`: `TileAt`, `IsTip`, `GermOnQWith`, `QFreeRing`, and more) is whole at
   `26b08395` on `origin/fs131-w8`; if a row of yours wants one of its names, tell me before you re-state anything — the answer is a merge of
   that one commit, which I will ask of you then.
5. **The rows, stated**: the thirteen, FS114-N2-ENDS's second sentence and N3-PAY, each with `sorry` at its leaves and read back against its
   row. Ruling 514 (a) fixed the first pass's six held dispositions at their defaults, from entries only: a default that fails on your reading
   of the argument is a message, not a redo. **FS114-N7-QOPP has a reader in flight**: wave 8 takes it as a hypothesis under a name of its
   own (its planner proposed `QArcsJoinOpposite F p`, from the entry's first sentence, `plans/FS114-derivation.md` l. 793); send me your
   statement of it when it is fixed, so the two are stated to meet at the join.
6. **FS114-Y2-BOWTIE's kernel route, decided and priced**: the explicit twenty-tile map is this wave's inhabitant and the one wave 8's
   star rows owe; the first pass names the route to price it against (`Proofs/HadwigerNelson/Plane/SixFragment.lean`, 2,229 lines). If it is one implementer's job
   on its own, say so in the handoff.
7. **Vacuity and inhabitants**: the pinwheel's rows are refutations with no held fragment at `1 + ε` outside its two exceptions — each
   docstring says so in `LEAN.md` § The gate's form and names the object meeting the local hypotheses but one. Every other structure-valued
   hypothesis has a named Lean inhabitant or an owed one named.
8. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on
   your tree — no name declared by two modules (wave 8's first pass lost a build to three names already declared on `main`).
9. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from
   the first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), and a handoff for
   implementers by file. A leaf you can prove in about an hour, prove, and say so.
10. The report, in standing rule 11's form. You do not merge another branch into this one unless I ask it by message, run the gate, or touch
    `main`. Leave no background process running, and keep what your record cites under `data/fs131/k7b/`. Thirteen rows over a foundation nobody has written may be more than this pass holds: the four flags, the foundation and the bowtie rows first, the pinwheel after; stopping at a saved stage and saying exactly where a third pass takes over is a good report.

## What is yours to decide

The modules and their layout, the form of each statement within what its row claims, which rows are one theorem and its corollary (the first pass proposed three merges), what is formalized and what is named as a hypothesis, the bowtie's kernel route, and the order after the four flags. One mind planned what you stand on and did not read your rows' arguments: where the foundation does not carry what a row reads, say so
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
