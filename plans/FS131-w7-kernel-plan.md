# FS-131, wave 7 — the kernel plan (job FS131-K7, de Bruijn, the planner)

*Wave 7 of the Lean backlog: twenty rows about a vertex where four colours meet in a tight six-colour map — route T's count, the Reuleaux
bowtie and its lunes, the pinwheel. Brief `data/fs131/briefs/FS131-K7-wave7.md`; branch `fs131-w7`, worktree
`.claude/worktrees/fs131-w7`, cut from `main` at `e6e7b312`. Working files `data/fs131/k7/`. Nothing in this milestone is blind
(`plans/FS131-close-inventory.md` § Rulings in force, ruling 1).*

## Theorems this phase proved

*Filled at each stage; every line is a Lean declaration on branch `fs131-w7`, built through `./scripts/build.sh`, not yet through the gate
(the gate is the landing job's).*

(see the last SAVED stage's list; none at Stage 1)

## Stage 1 — SAVED: the readback, the registered expectations, the branch built as given

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | found, verbatim |
| "### 7.3 What each wave's planning job must hold" and its items 1–5 (first lines) | `plans/FS131-kernel-plan.md` ll. 556–572 | found, verbatim, each a line's opening words |
| "486. **FS131-K6 done at its Stage 7: wave 6's first planning pass — dispositions for all 35 rows, the foundation, four rows proved at a wider" | `plans/FS131-close-inventory.md` l. 4886 | found, verbatim (the item's first line) |
| "484. **FS131-K10 done at its Stage 5: wave 10 planned — dispositions for all fourteen rows, a foundation, a skeleton of eleven, four rows" | same, l. 4854 | found, verbatim (first line) |
| "**Wave 7** (20 rows):" and the three module lines and the merge line | `plans/FS131-kernel-plan.md` ll. 533–537 | found, verbatim |
| the wave table's row 7 | same, l. 482 | found, verbatim |

No mismatch. One remark on the brief, not a defect: it says § 7.3 item 2 "leaves one decision to you by name"; the plan's words are "the
wave-7/8 planner decides with Ephodos's reading, and reports", and the inventory's item 17 (a) held an Ephodos job for it "briefed before wave
7's planner". No such job's answer is in the inventory, so the decision below (Stage 2) is this job's, by an argument and a Lean equivalence,
and is reported to Keryx for wave 8.

### 1.2 Read

- `plans/STANDING-RULES.md`, `LEAN.md` in full; `RUNNING.md` § Building; `plans/FS131-kernel-plan.md` §§ 5, 7.1–7.6; the inventory's § What
  "Closed" means, § Rulings in force, items 17, 484–487.
- `data/fs131/k1/dispositions.csv`: the 22 rows of wave 7 (20 formalize, 2 merged into FS114-Y4-RSTOPALL).
- `plans/LEAN-BACKLOG.md`: rows 72–88 (ll. 1997–2455), C27 (l. 5840), L88, L90, L98 (ll. 6507–6600), FS114-Y6-E2RED (l. 6871), cautions C116,
  C118 — every statement, not-claimed line, grade, minds, handoff, dated note and merge note of the wave's rows.
- `plans/FS114-derivation.md`: the header, § 2 (ll. 106–277: RD, Y-EDGE, EULER, FIVE, ROOM, CUBIC, NB-DUAL, ENDS, JOINT, with both errata),
  § 3's entries for every row of the wave (ll. 419–722, 793–809), with the errata under Y3-RSTOP, Y5-PINALL, Y6-E2RED;
  `plans/FS129-derivation.md` l. 874 (FS129-SR3-E2ONE).
- The arguments read in full: `plans/FS114-N-proof.md` § 1.3, § 1.4 (N114-FAR, Anchoring, N114-RD, -EDGE-RB, -EULER, -FIVE, -ROOM, -CUBIC),
  § N2-2.1–N2-2.3 (N2-ABS, N2-SLACK, N2-ENDS, N2-VCAP, N2-KILL). **Not read in full at this stage** (said where a disposition rests on the
  entry alone): `plans/FS114-N3-proof.md` … `-N7-proof.md`, `plans/FS114-Y2-construction.md` … `-Y6-construction.md`, the verifiers' records.
- The library (`ARCHITECTURE.md` rows for `Plane/ArcMap`, `LocalMap`, `Tiles`, `RingGerm`, `Lens`, `SixFragment`, `ValidMap/Basic`,
  `Sectors`, `Contact`, `Cone`, `UnitArc`, `BaseSteps`, `BrickMap`, `FlankUA`, `MapTopology`, `MapGraph`, `Models/*`; `ArcMap.lean` in full;
  `LocalStructure`'s `Simple.coneAt_eq_angleIcc` and `_sep`; `Tiles`' `wholeRestrict` lemmas).

### 1.3 Registered expectations (written after reading the rows' statements in the backlog and before reading the derivations)

- **X1 — short rows** (a leaf of an hour or less each once the foundation stands): FS114-N114-EULER (a count over a rotation system),
  FS114-N114-ROOM, FS114-N2-ENDS's identity, FS114-N3-JOINT's first clause and N2-KILL (integer arithmetic over the count's hypotheses),
  FS114-N2-FIVE given the tile inequality, FS114-Y-EDGE. P(at least four of these six are proved or one `omega`/`nlinarith` away at this job's
  end) = 0.6.
- **X2 — outside theorems**: Euler's formula enters the counting rows as the defining equation of a combinatorial torus map and needs no
  import, 0.8; the passage from a doubly periodic `ArcMap` to that combinatorial object is not formalized in this wave and is named, 0.85;
  no `axiom` is added by this job, 0.9.
- **X3 — statement defects**: at least one of the twenty rows hides a hypothesis its formal statement must add, 0.85; median 3, 80 %
  interval [1, 7]. Likeliest: FS114-N114-EULER's `μ ≥ 0` (which degrees?), FS114-N3-LOCAL (six lemmas, one mind, a blind check owed by its
  own handoff), FS114-N7-QOPP (one mind), FS114-N4-LEMMAS' N4-A4NB and FS114-Y6-HALF's "hold unchanged" and FS114-N114-ROOM's "forces type
  (B) only when" (sentences about arguments, not about maps), FS114-N2-ENDS (one mind).
- **X4 — size**: the wave is more than one planning pass holds; this pass ends with the dispositions, the decision on "simple", route T's
  foundation and skeleton, and the four-colour modules' foundation left to a second pass, 0.7.
- **X5 — FS114-Y2-BOWTIE** (twenty tiles over `ℚ(√3)`, 46 same-colour pairs) is the wave's largest leaf, the size of wave 3's `SixFragment`
  (2,229 lines) or more, and is the inhabitant the bowtie rows need, 0.8.

### 1.4 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree: **OK — all 1801 modules already up to date,
nothing built, 0 modules with warnings** (`data/fs131/k7/logs/build-0-as-given.log`, `EXIT=0`).
