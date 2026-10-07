# FS-131 wave 8 — the kernel plan: the ring calculus in the non-Siamese class

*Job FS131-K8 (de Bruijn, the planner), 2026-10-06, branch `fs131-w8`. Brief: `data/fs131/briefs/FS131-K8-wave8.md`. The milestone's
plan is `plans/FS131-kernel-plan.md` (§§ 7.1–7.5 bind this job). Working files: `data/fs131/k8/`.*

## Theorems this phase proved

All [kernel] on branch `fs131-w8` (built through `./scripts/build.sh`, log `data/fs131/k8/logs/build-3-skeleton.log`; not gated, not on
`main`); addresses are declarations of `HadwigerNelson.Plane.ArcMap` unless a module is named.

- **FS116-RING-GERM**, in tile form — `ringGerm_inward` (i), `ringGerm_outward` (ii, with no non-Siamese hypothesis); its first clause and
  (iii) are wave 3's `germS_absent`, `germS_four` (`Plane/RingCalculus/Star`).
- **FS116-N2-STAR**, whole — `star_coloursAt`, `star_absent`, `IsTip.coneAt_subset` (`…/Basic`), `star_outer_cone`, `star_flank` (any tile of
  any valid map), `star_flank_interior`, `star_tip_nonempty`, `star_outer_nonempty` (`…/Star`).
- **FS116-V6-ANTI**, class-free — `v6_anti` (`…/Empty`).
- The foundation's lemmas (`…/Basic`, no `sorry`): `NonSiamese.tile_eq_of_dist_lt`, `NonSiamese.tile_eq_of_mem_closure`,
  `coloursAt_inter_eq`, `disjoint_tipColours_outerTileColours`, `mem_outerTileColours_iff`, `isTip_comm`, `tipColours_comm`,
  `cos_nonpos_of_coneAt_of_disjoint`, `coneAt_subset_of_subset_closedBall`, `coneAt_subset_of_disjoint_ball`, `inter_ball_nonempty_of_coneAt`,
  `inter_ball_nonempty_of_inward_cone`, `exists_not_mem_closedBall_of_coneAt`, `isHub_iff`, `IsHub.not_isSemiHub`,
  `IsFullSemiHub.isSemiHub`, `GammaFreeRing.qFreeRing`, `QFreeRing.isHub`, `GermIn.ringPt_mem_closure`, `halfPlane2_gammaFreeRing`.
- [tools, exact] FS116-V6-COUNT's count as a finite statement: 72 configurations meet its hypotheses, none violates its conclusion
  (`tools/fs131_k8_count.py`; planted fault `--fault-hug`: 1,056 violations, exit 1).

Stated with `sorry`: `star_recip`, `star_anti` (`…/Star`); `ringPt_sixth_dist_le_one`, `v6_hubs`, `v6_hug`, `v6_count`,
`exists_ne_mem_closure_inter_of_split`, `emptyNS`, `outerAdj`, `doubleTip` (`…/Empty`). Not stated: the nine SemiHub rows, FS116-N2-SIXRING,
FS116-RING-TWIST-C.

## Stage 1 — SAVED: the readback, the registered expectations, the branch built as given

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| § 7.3's items 1–5 (first lines) | `plans/FS131-kernel-plan.md` ll. 560–573 | verbatim, each cut at its first line |
| items 486 and 484 (first lines) | `plans/FS131-close-inventory.md` ll. 4886, 4854 | verbatim |
| "**Wave 8** (22 rows):" and its four bullets | `plans/FS131-kernel-plan.md` ll. 539–543 | verbatim |
| the wave table's row 8 | `plans/FS131-kernel-plan.md` l. 483 | verbatim |

No mismatch. Two facts about the brief's surroundings, neither a defect of it: the inventory in this worktree stops before item 508
(the branch was cut before it was filed), so items 508 and 511–514 were read from `main`'s copy; and the plan's wave-8 list has 22 rows
plus three merged ones, 25 lines of `data/fs131/k1/dispositions.csv` — counted by script, as the brief says.

### 1.2 What was read

- The plan's §§ 7.1–7.5; the CSV's 25 lines for this wave; each row's entry in `plans/LEAN-BACKLOG.md` (extracted by script to
  `data/fs131/k8/rows-extract.md`, 26 entries with FS114-N7-QOPP's), with its cautions, errata and merge notes.
- The definitions: `data/fs116/claims.md` § 13's notation paragraph (tip, outer tile, tip pair, outer pair, hub, semi-hub of kind O
  and T, closed, full, crossed, parallel) and its l. 203 (Γ-free).
- The landed library the rows reuse: `Plane/ArcMap`, `Plane/LocalMap` (both in full), `Plane/SimpleOn` (in full), the statement
  surface of `Plane/RingGerm` and `Plane/Tiles`, and `ARCHITECTURE.md`'s rows for waves 3–5 and the models.
- The arguments read in full: `plans/FS116-N2-proof.md` § 2.1–2.4 (SIXRING, STAR, RECIP, ANTI) and `plans/FS116-V6-verification.md`
  § 2.1–2.2 (the whole route to EMPTY). **Not read in this pass**: the arguments of the nine SemiHub rows
  (`plans/FS116-N3-proof.md`, `plans/FS116-V5-verification.md`), RING-TWIST-C's (`plans/FS116-N1-proof.md` § 2.2) and the two audits
  behind OUTERADJ and DOUBLETIP (`plans/FS129-SR3-audit.md`, `plans/FS129-MR1-audit.md`); those rows are disposed from their entries,
  and § 2 marks each such row.

### 1.3 Registered expectations

Registered after reading the 25 entries' statements and before any argument (the N2 and V6 arguments were opened after this list was
fixed; it is written down here at the first save, which is later than it was formed — the job's slip, disclosed).

- **Short** (provable in this pass or one implementer sitting): FS129-SR3-OUTERADJ, FS129-MR1-DOUBLETIP, FS116-N3-PAIR,
  FS116-V6-COUNT, FS116-N2-ANTI.
- **An outside theorem**: none (the plan's table says none); the risk is plane topology hidden under "the tile lies in the Reuleaux
  triangle" and "the four tiles form a cycle of shared edges".
- **A statement defect**: FS116-N2-SIXRING (five clauses, an existence of an indexing), FS116-N3-STAR2 (windows; degenerate lengths),
  FS116-V5-OUT2 (the CSV already narrows its setting), the V6 lemmas (the class each reads against the class each is filed in); and
  at least one row filed at "radius above 1" whose argument reads the ring of a point of `ω(p)`, hence radius 2.

Scored in the last stage.

### 1.4 The branch as given

`./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`), log `data/fs131/k8/logs/build-1-as-given.log`; its
result is recorded in Stage 2's first lines (the build waited for a slot and was still walking at this save).

## Stage 2 — SAVED: the dispositions

*The branch as given built: `data/fs131/k8/logs/build-1-as-given.log` ends "build: OK — 466 of 466 batches, 2 module(s) rebuilt, 0 module(s)
with warnings", `EXIT=0`.*

**Read** marks whether the row's argument was read in full in this pass (A) or the row is disposed from its entry only (E). An E row's class
and its hypotheses are the entry's words, unverified against the argument: the second pass reads the argument before stating it.

| row | read | disposition | class the argument reads / what differs from the entry | rests on (in the backlog) | outside |
|---|---|---|---|---|---|
| FS116-RING-GERM | A (through wave 3's GERM-S) | **theorem, proved** | first clause and (iii): landed, Siamese allowed (`germS_absent`, `germS_four`); (i) non-Siamese for the tile identification only; (ii) no non-Siamese; every `k` with at most two colours absent | wave 3: GERM-S, V4-DICHOTOMY | none |
| FS116-N2-STAR | A | **theorem, proved** | "radius above 1" is right (the stage note of `plans/FS116-N2-proof.md` § 2 says "above 2" for the whole stage; STAR reads only `B̄(p, 1)`); the flank clause class-free (generalization 1); the outer-cone clause at any point and `ψ` | RING-GERM, V4-DICHOTOMY, V5-NE1 | none |
| FS116-N2-RECIP | A | theorem, stated (`star_recip`) | `y` a change point of four colours — "hub" idle, non-Siamese idle (generalization 2); `Covers p 2` read (TOUCHW at `y`) | N2-STAR, SR2-TOUCHW (landed) | none |
| FS116-N2-ANTI | A | theorem, stated (`star_anti`) | *simple* read at the tiles of `p`: `SimpleOn {p}` (generalization 3); four colours at `p`, `k = 6` | N2-STAR | none |
| FS116-N2-SIXRING | A | theorem, **not stated** (second pass) | six colours at `p` (`coloursAt p = univ`), non-Siamese, no simplicity; five clauses; the covering step ("six closed sets of at most 60° cover the circle, so each is exactly a 60° arc") is a measure/compactness argument on the circle — the one heavy leaf; inhabitant `sixFrag` (landed) | N1-TWIST-D, SR1-SIXQ (landed) | none |
| FS116-RING-TWIST-C | E | theorem, **not stated** (second pass) | first clause is landed TWIST-D (merge SR2-4.3-21); the parity is over *colour changes*; its hypotheses have no held model at six colours (entry) — a satisfiability-open note, and the count of points in a window needs a finite-set form | N1-TWIST-D | none |
| FS116-N3-PAIR | E | theorem (second pass) | non-Siamese simple; "both germs of one pair on (Q) arcs with the same pair of colours" is `GermOnQWith` twice | — | none |
| FS116-N3-STAR2 | E | named-hypothesis implication (second pass) | takes FS114-N7-QOPP as a hypothesis under this wave's own name (brief); needs "an edge of `p` in a window" and "counter-clockwise order of four tiles" defined — by cones (§ 3.3) | N3-PAIR; wave 7's N7-QOPP | none |
| FS116-N3-CONE | E | theorem (second pass) | six half-plane clauses and an edge clause; the first four are wave 3's `germR_*` in tile form (R, R′ are the ring tiles at `y`) | NOBOTH, U1, GERM-R, RING-GERM | none |
| FS116-N3-CROSS | E | named-hypothesis implication (second pass) | radius above 2; "cone of zero angle" to define (§ 3.3); QOPP as a hypothesis | N3-CONE, N3-STAR2, RING-GERM; N7-QOPP | none |
| FS116-V5-OUT2 | E | theorem (second pass) | **likely already proved here**: "if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour c has its cone at p in [θ + 90°, θ + 270°]" is `star_outer_cone` at `ψ = θ` (valid, non-Siamese, any point `p`); the second pass confirms against V5's argument that nothing more is meant | V4-DICHOTOMY | none |
| FS116-V5-QCOL | E | theorem (second pass) | its setting is V5's (a change point of a vertex of at least four colours, non-Siamese simple); five clauses | V5-NE1 | none |
| FS116-V5-DICHO | E | theorem (second pass) | a statement about either pair: wants a pair-generic "both germs on (Q) arcs" (§ 3.3) | V5-NE1, V5-QCOL, V5-U1 | none |
| FS116-N3-SEMI | E | theorem (second pass) | three alternatives; both kinds | N2-STAR, N3-CONE, -PAIR, -STAR2, RING-GERM, V5-DICHO, -OUT2, -QCOL, -U1 | none |
| FS116-RING-TRANSFER-QC | E | composition (second pass) | radius above 2, four colours; a conjunction of SEMI, PAIR, STAR2, CROSS — likely no declaration of its own beyond a bundling theorem | the SemiHub rows | none |
| FS116-V6-HUBS | A | theorem, stated (`v6_hubs`; `ringPt_sixth_dist_le_one`) | `m = 1` over the Γ-free class, without *simple* (ruling Y); the second clause class-free (`IsTile.dist_le_one_of_mem_closure`, landed, with pure trigonometry). VACUITY DECLARED, with `v6_hubs_vacuous` | wave 3 | none |
| FS116-V6-ANTI | A | **theorem, proved** (`v6_anti`) | class-free (generalization 4): no vacuity | V5-NE1 (diameter) | none |
| FS116-V6-HUG | A | theorem, stated (`v6_hug`) | the Γ-free class, without *simple*, its own colour step. VACUITY DECLARED, with `v6_hug_vacuous`. A local form (two adjacent change points, the germs `v⁻` and `u′⁺` off `Γ`) looks sufficient and is not verified — a candidate generalization for the second pass | GERM-R, V4-DICHOTOMY, SR1-TWOCIRC (landed) | none |
| FS116-V6-COUNT | A | **certified computation** (`v6_count`) and a theorem (`exists_ne_mem_closure_inter_of_split`) | the count is finite combinatorics with no map (generalization 5); the last step by a connected circle, no sectors (the shorter route) | — | none |
| FS129-SR3-EMPTY-NS (carrying FS116-Y4-EMPTY, FS116-Y4-OBST) | A | theorem, stated (`emptyNS`), a composition | exactly four colours at `p` are read (the count is four tiles), so `k = 6`; stated at `ArcMap 6` | the V6 rows, RING-GERM, STAR | none |
| FS129-SR3-OUTERADJ (carrying FS116-V6-ADJ) | E | theorem, stated (`outerAdj`) | its wording read as `O_y = {c} = O_y′` (the literal reading is never met: a correction owed, inventory item 518) | RING-GERM (ii), GERM-R, V4-DICHOTOMY, SR1-TWOCIRC | none |
| FS129-MR1-DOUBLETIP | E | theorem, stated (`doubleTip`) | `SimpleOn (closedBall p 1)`; the entry's uses-only reads *simple* at the two hubs only ("one cone per tile at a vertex") — a candidate narrowing, unverified | Y4-FLANK, RING-GERM (i), V4-TWIST, V4-DICHOTOMY | none |

**No outside theorem** is imported by this wave: the plan's table said none, and none appeared in the rows read. No `axiom`, no
`native_decide`.

**The hypothesis from wave 7**: FS114-N7-QOPP enters FS116-N3-STAR2, -N3-CROSS and RING-TRANSFER-QC. None of the three is stated in this
pass; the second pass states it as a `Prop`-valued definition of this wave's own name (proposed: `QArcsJoinOpposite F p`, read from
`plans/FS114-derivation.md:793`, its first sentence only — "every (Q) arc of a four-colour degree-4 vertex joins opposite tiles … the
other two tiles' colours are absent along it"), a hypothesis of those three theorems, never an axiom.

## Stage 3 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

`Proofs/HadwigerNelson/Plane/RingCalculus/Basic.lean`, no `sorry`; its docstring is the definitions' reading. **Its statements are fixed
from the commit that holds it alone** (the coordinator's request, inventory item 518): waves 7 and 9 take it by ancestry.

### 3.1 The model, and why this shape

- Everything is a predicate on `ArcMap k`, beside wave 3's vocabulary (`Plane/LocalMap`): no new type, no index. The one inductive,
  `SemiKind`, names the rows' "kind O / kind T".
- **`IsTip p y T` is symmetric** (`isTip_comm`): a tip at `y` of `p` is a tile of both points. The rows' asymmetry (centre `p`, ring
  point `y`) is the role, not the object — which is why RECIP and CROSS can read `p` on `y`'s ring with no new definition.
- **`tipColours`, `outerTileColours`** (`T_y`, `O_y`) are sets of colours; `coloursAt p ∩ coloursAt y = T_y ∪ O_y` at a point of the domain
  (`coloursAt_inter_eq`), disjointly in a valid non-Siamese map. STAR's `C(y) = A(p) ⊔ T_y ⊔ O_y` is this with `A(p) ⊆ C(y)`.
- **The two germ pairs** are kept as two explicit conjunctions (`TipPairFree`, `OuterPairFree`) whose conjuncts are syntactically the
  hypotheses of wave 3's `germS_inward` and `germS_outward`, so the tile forms consume the landed theorems with no rewriting. (The
  intrinsic description — each pair is an orbit of the reflection in the line `py`: the two germs on the far sides of `u`, `v`, and the two
  on the near sides — would index germs by `Side.sign`, and every use would then rewrite `ψ + (−1)·π/3` to `ψ − π/3`.)
- **The non-Siamese engine** is one lemma, `NonSiamese.tile_eq_of_dist_lt`; every tile identification of the rows proved so far is an
  application of it.

### 3.2 What the pass changed

1. `GermOnQWith` first carried `IsRingArc p θ₁ θ₂ a a' ∧ IsQArc p θ₁ θ₂`: `IsQArc` hides a second pair of colours, equal to `a`, `a'` only
   by a uniqueness argument — one concept in two costumes. It now carries the (Q) clauses on `a`, `a'` themselves.
2. `outerTileColours` was defined by colours and `IsOuterTileAt` by tiles with nothing between them: `mem_outerTileColours_iff` is the bridge.
3. `isTip_comm`, `tipColours_comm` added (the next lemma the model owed, named before looking: RECIP's and CROSS's change of centre).
4. Two diagonal examples pin the definitions where no map is needed: `tipColours p p = coloursAt p`, `outerTileColours p p = ∅`.

### 3.3 Seams left open, by name (for the second pass)

- **`IsSemiHub`, `IsFullSemiHub`** are four near-identical clauses. No row is stated over them yet; a pair-generic helper
  (`PairFree`/`PairFull : SemiKind → Prop`, `Iff.rfl` bridges) is a new declaration the SemiHub pass adds if FS116-V5-DICHO and -N3-SEMI
  want statements uniform in the pair.
- **Words the SemiHub rows use and the foundation does not define**: "an edge of `p` between tiles `t`, `t′` in a window `[α, β]`"
  (proposed: a common direction of the two tiles' cones at `p` in the window), "a cone of zero angle" (`∃ β, coneAt T y = angleIcc β β`),
  "the tiles of `p`, counter-clockwise" (an order on four cone intervals). Each is a likely statement defect in E1's sense.
- **`GammaFreeRing`** reads "no arc of `Γ` lies on it"; the entry's gloss "(`Γ ∩ ω(p)` finite)" is equivalent on a covered ring only, and
  that bridge is `v6_hubs`'s first child (§ 5.2, H1).
- **No concrete tip.** No example exhibits a tip or an outer tile on a valid map: the class's inhabitants (the bowtie, the strip) are not
  Lean terms yet.

### 3.4 Validation

`halfPlane2` (Γ-free ring, a hub, both pairs free; no semi-hub of either kind) and `quadRing` (a (Q) arc: not (Q)-free, not Γ-free; a germ
on a (Q) arc with its colours named) carry the spec examples; neither is valid, and the docstring says so.

## Stage 4 — SAVED: the skeleton and the read-backs

`Plane/RingCalculus/Star` (2 `sorry`) and `Plane/RingCalculus/Empty` (8 `sorry`); `Proofs.lean`, `ARCHITECTURE.md`
(`tools/check_architecture.py` PASS, `data/fs131/k8/logs/check-architecture.log`), `scripts/Axioms.lean` (block "FS131-K8", above the
PURCHASED banner). Each formal statement against its row:

- **RING-GERM (i)** "every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p": `∀ β ∈ Ioo
  (ψ + 5π/6) (ψ + 7π/6), ∃ T, F.IsTip p y T ∧ β ∈ coneAt T y`. The tile is a tip (a tile of `p` with `y` in its closure), which is what
  "in the cone of a tile of p" at `y` says. Hypothesis "neither v⁻ nor u⁺ lies on a (Q) arc" is `TipPairFree`.
- **RING-GERM (ii)** "… lies in the cone of a tile of a colour of p that is not a tile of p": `∃ T, F.IsOuterTileAt p y T ∧ β ∈ coneAt T y`
  over `Ioo (ψ − π/6) (ψ + π/6)`.
- **STAR** "C(y) = A(p) ⊔ T_y ⊔ O_y and A(y) = P ∖ (T_y ∪ O_y)": `star_coloursAt`, `star_absent`, with disjointness in
  `disjoint_tipColours_outerTileColours` (non-Siamese) and the two inclusions `tipColours_subset`, `outerTileColours_subset`. "every tile
  of p at y has its cone at p in [ψ − 90°, ψ + 90°]": `IsTip.coneAt_subset`. "the tile of p of each colour of O_y in [ψ + 90°, ψ + 270°]":
  `star_outer_cone`. "every tile of p whose cone holds ψ + 90° or ψ − 90° in its interior has its colour in A(y)": `star_flank_interior`
  (`interior (coneAt T p)` is the interior of the set of angles). "T_y is non-empty when v⁻, u⁺ lie on no (Q) arc and O_y when u⁻, v⁺ do":
  `star_tip_nonempty`, `star_outer_nonempty`. The row's "p of four colours" enters as `4 ≤ ncard` and `k ≤ ncard + 2`.
- **RECIP** "the points of ω(y) at 60° on either side of p are r(ψ + 60°) and r(ψ − 60°)": on `ω(y)`, `p` is at `ψ + π`
  (`ringPt_ringPt_add_pi`), so the four germs are `GermOnQ y (ψ + π ± π/3) s` — **not yet read back as the points `r(ψ ± 60°)` by a lemma**
  (owed: `ringPt (ringPt p ψ) (ψ + π − π/3) = ringPt p (ψ + π/3)` and its mirror; the hypothesis `hq` does not need them). "p is a change
  point of y's ring, its two sides lying in the tiles of p that hold the directions ψ − 90° and ψ + 90°, whose colours are the two colours
  of A(y)": `∃ Y Y', F.IsChangePoint y (ψ + π) Y Y' ∧ (F.coloursAt y)ᶜ = {Y, Y'} ∧` each germ of `ω(y)` at `p` lies in a tile of `p` of
  that colour. **Not in the formal statement**: that those tiles "hold the directions ψ ∓ 90°" (it follows from the germ lying in the
  tile; a corollary the implementer may add).
- **ANTI**: as the docstring; `T_y = O_(y*)` and `O_y = T_(y*)` "each a single colour" are the two `∃ c, … = {c} ∧ … = {c}` clauses.
- **V6-HUBS** "the change points are y_k = r(ψ₀ + 60°k), six of them": `∃ ψ₀, ∀ ψ, (∃ X X', F.IsChangePoint p ψ X X') ↔ ∃ n : ℤ, ψ = ψ₀ +
  n * (π / 3)` (angles are real, so the six points are one coset of `(π/3)ℤ`). "a tile of p tips at most two, and two only if
  consecutive": `IsTile.dist_le_one_of_mem_closure` with `ringPt_sixth_dist_le_one`.
- **V6-ANTI** "a tile tipping y_k and a tile tipping y_(k+3) share no edge at p": `closure T ∩ closure T' ⊆ {p}` — stronger than "no
  edge": no common closure point but `p`.
- **V6-HUG** "no tile T of p tips both y_0 and y_1 while being the only tip at each": hypotheses `hT hT' h1 h2`, conclusion `False`.
- **V6-COUNT** "M = 4, s = 2, each hub of S has exactly two tips, and every tip at a hub of S is a double tile; the two hubs of S are
  antipodal": `v6_count`'s five conjuncts, over `tip : Fin 4 → ZMod 6 → Prop`. **Not in it**: the row's `M`, `s`, `S` as named quantities.
- **EMPTY-NS**: the row verbatim at `ArcMap 6`; "ring carrying no arc of Γ" is `GammaFreeRing`.
- **OUTERADJ**, **DOUBLETIP**: as their docstrings; the germs named are the row's ("just counter-clockwise of r(ψ − 60°)", "just
  clockwise of r(ψ + 120°)" for OUTERADJ; the other two for DOUBLETIP).

## Stage 5 — SAVED: the plan per leaf (`debruijn-obligation-modeling`, invoked fresh), inhabitants, the handoff

### 5.1 Prices, from the first leaves

RING-GERM's tile forms (40 lines), STAR (110 lines) and `v6_anti` (25 lines) each closed in one or two elaborations: a leaf that is a
composition over landed lemmas costs minutes. The plan's table had nothing per leaf for this wave; the prices below are from these.

### 5.2 `Empty` — the route to `emptyNS`

Library lemmas confirmed by use in this pass's proofs (each elaborated): `germS_absent`, `germS_inward`, `germS_outward`, `qfree4`,
`ne1_region`, `unitNear_or_unitFar`, `UnitFar.one_le_dist_of_mem_closure`, `NonSiamese.eq_of_unitNear`, `IsTile.subset_ball`,
`IsTile.closure_subset_closedBall`, `coneAt_region_eq_biUnion`, `mem_coloursAt_iff_exists_tileOf`, `cos_nonneg_of_mem_coneAt`,
`mem_angleIcc_of_cos_nonneg_single`, `dist_ringPt_germ_le`, `e_add_pi`, `re_e_mul_conj_e`; Mathlib: `IsPreconnected.intermediate_value`,
`Real.cos_sub_pi`, `Real.cos_pi_div_two_sub`, `Real.cos_add_pi_div_two`, `Real.cos_sub_pi_div_two`. Named and not yet confirmed:
`finite_tiles_near`, `GoodAt.not_tile_subset_ball` (`Plane/LocalStructure`), `twoCirc_cmp_one` (`Plane/Chord`), `isPreconnected_sphere`.

- **`v6_hubs`** (the hard leaf; about 600–900 lines). The statement the proof derives from: *on a covered Γ-free ring every germ lies in
  one colour class* — define nothing new, state `∀ θ s, ∃ c, GermIn p θ s (F.region c)`. Children, each over a strictly smaller object:
  - H1 `(F.Γ ∩ sphere p 1).Finite` from `Covers p 1` and `GammaFreeRing` (V6's R-ARC; look first in `Plane/LocalStructure` beside
    `finite_ringD_off_ringArc`).
  - H2 every germ in one class (H1: a short germ is off `Γ`, in the domain, connected); its colour is absent at `p`
    (`not_mem_coloursAt_of_mem_sphere`), so it is `X` or `X′` (`qfree4` with six colours gives exactly two absent).
  - H3 the germ colours at `θ` and `θ + π/3` on one side differ (`not_germIn_closure_rotate`).
  - H4 on an open arc with no change point the germ colour is constant: the ccw colour at `θ` is the cw and the ccw colour at every
    nearby `θ′ > θ`; with no change point cw and ccw agree, so the colour is locally constant on a connected interval.
  - H5 change points are invariant under `ψ ↦ ψ + π/3`, colours swapped (H3; the point is on `Γ` because its two germs differ).
  - H6 a change point exists (else H4 on the whole ring against H3).
  - H7 no change point lies strictly between `ψ` and `ψ + π/3`. Two cases. *One* between them, `ψ′`: H4 on `(ψ, ψ′)` and on
    `(ψ′, ψ + π/3)` gives the cw colour at `ψ + π/3` equal to the ccw colour at `ψ′`, which is `X′`, against H5 (it is `X`). *Two or more*:
    eighteen change points in three orbits; each has a tip (`star_tip_nonempty`: on a Γ-free ring every pair is free), `p` has four tiles
    (one per colour, `NonSiamese.tile_eq_of_mem_closure`), and a tile's tipped points are pairwise within `1`, so at most four of the
    eighteen (a window of four consecutive in cyclic order): `16 < 18`. **The count alone does not give `m ≤ 1`** (at `m = 2` twelve
    points and four tiles tipping three each is consistent): the one-point case needs H4, as V6-WIN's parity does.
  Measure: each child speaks of one germ, one arc, or one finite set; none restates the goal.
- **`ringPt_sixth_dist_le_one`**: `dist (r α) (r β) = 2 |sin((α − β)/2)|` (look for `dist_ringPt_ringPt_cmp_one`, `Plane/Chord` or
  `Plane/RingGerm`, used by `dist_ringPt_shift_cmp`); reduce `n − m` modulo 6 and check six residues. About 80 lines.
- **`v6_hug`**: V6's argument verbatim (`plans/FS116-V6-verification.md` ll. 148–161). Children: (a) `T`'s cone at `y` ends at
  `ψ + 7π/6` and at `y′` begins there — this is wave 3's `flank_cone` with its hypotheses from `ringGerm_inward` and uniqueness of the tip;
  (b) the tiles `R⁻`, `R⁺` beyond those edges are `X′`-tiles (colour exclusion by `germR_*` and six colours); (c) the two edges lie on
  `ω(y′)` and `ω(y)` (`flank_edge_exists`, then V6-GERM's two-sided bound); (d) `flank_initialPieces` (TWOCIRC, landed) gives points of
  `cl R⁻`, `cl R⁺` nearer than 1; (e) `R⁻ ≠ R⁺` have ring germs more than 1 apart: against `unitNear_or_unitFar`. Wave 3's `flank` is
  nearly (c)–(d) already. About 300 lines.
- **`v6_count`**: a certified computation. Encode a tile's tip set as one of 13 values (none, one hub, two consecutive hubs), prove the
  encoded statement by `decide +kernel` over `13⁴ = 28,561` cases as a `Bool` (`List.all`, `LEAN.md` § The kernel's cost model), and recover
  the `Prop` form from `hcons`. Measure the kernel time on the encoded statement first; if it is over a minute, the hand count
  (`plans/FS116-V6-verification.md` ll. 163–169) is five lines of arithmetic over `Finset.card`. About 150 lines either way.
- **`exists_ne_mem_closure_inter_of_split`**: `finite_tiles_near` gives `r` with finitely many tiles meeting `B(p, r)`; shrink `r` below
  the distance from `p` to each of those tiles that is not a tile of `p`; the sphere `S(p, r/2)` lies in the union of the closures of the
  tiles of `p` (interior points are dense in the domain near `p`: `Γ` is a locally finite union of arcs); each tile of `p` meets that
  sphere (`GoodAt.not_tile_subset_ball`, and a tile is connected); two closed sets covering a connected sphere, both non-empty, meet. About
  200 lines. One mind's route, unproved: if the density step resists, the fallback is SR3's sector form over wave 4's `IsSectorChart`.
- **`emptyNS`**: the composition. From `v6_hubs` take `ψ₀`; index the four tiles of `p` by `Fin 4` (the four colours of `p`; a transport
  lemma `v6_count` over any `ι` with `Fintype.card ι = 4` keeps the bijection out of the geometry); `tip i a` is "tile `i` has
  `r(ψ₀ + a·π/3)` in its closure"; `hcover` from `star_tip_nonempty`, `hcons` from `ringPt_sixth_dist_le_one`, `hhug` from `v6_hug`;
  `v6_count` gives `a`; split the tiles of `p` into tippers of `a` and of `a + 3`; the split lemma against `v6_anti`. About 200 lines.
- **`outerAdj`**, **`doubleTip`**: arguments not read in this pass (`plans/FS129-SR3-audit.md` § 2.2–2.3, `plans/FS129-MR1-audit.md`).
  Their entries' uses-only lines name the landed lemmas (`germS_outward`/`ringGerm_outward`, `germR_*`, `flank`, `flank_cone`,
  `unitNear_or_unitFar`); a plan per child is the second pass's.

### 5.3 `Star` — the two open leaves

- **`star_recip`** (about 150 lines): `Covers y 1` from `Covers p 2`; `(coloursAt y)ᶜ ⊆ coloursAt p` from `star_absent`; both germs of `ω(y)`
  at `p` lie in one class each (`¬ OnRingArc y p` and local finiteness — the same child as H2 above, at one point) of colours absent at
  `y` (`not_mem_coloursAt_of_mem_sphere`); if the two colours were equal `touchW` at `y`, angle `ψ + π`, gives the other absent colour
  off `coloursAt p`, against the inclusion; `p ∈ Γ` because `p` carries four colours; the tiles from `mem_coloursAt_iff_exists_tileOf`
  and connectedness of a germ.
- **`star_anti`** (about 250 lines): `SimpleOn.coneAt_eq_angleIcc_sep` at `p` for `t⁺`, `t⁻`; `star_flank_interior` puts both colours in
  `A(y)` and `A(y*)`; `star_tip_nonempty`, `star_outer_nonempty` at both hubs with `star_coloursAt` give four colours at each and
  `|A| = 2`; `t⁺ ≠ t⁻` by the interval argument (`plans/FS116-N2-proof.md` ll. 219–226); the single tip colour by `IsTip.coneAt_subset`
  and `star_outer_cone` against the separated intervals.

### 5.4 The statements, attacked (the pass's validation)

- `v6_count`'s hypotheses have 72 models and its negation none; with `hhug` dropped 1,056 of 1,128 configurations violate the conclusion:
  the hypothesis is load-bearing (`tools/fs131_k8_count.py`).
- `star_outer_cone` without non-Siamese is false as argued (a Siamese twin of `p`'s tile at `y` is an outer tile of the same colour
  inside `B(y, 1)`); `star_flank` needs both directions (a tip has all its directions within 90° and its colour at `y`).
- `emptyNS` is stated at `ArcMap 6`, not at every `k` with two colours absent: the count reads four tiles.
- `v6_hubs`'s count step was attacked before it was planned: `m = 2` passes the count (above), so the plan carries H4.

### 5.5 Inhabitants and vacuity

| declaration | status of its hypotheses |
|---|---|
| `ringGerm_inward`, `ringGerm_outward`, `star_*` | a change point of a four-colour vertex with two colours absent: held by hand (the bowtie's top, the strip's `P₂`), **no Lean term yet** — wave 7's bowtie is the owed inhabitant, as for wave 3's rows of the same class |
| `star_flank`, `star_outer_cone`, `v6_anti`, `ringPt_sixth_dist_le_one`, `exists_ne_mem_closure_inter_of_split` | class-free; any valid map with a vertex is a model (`stuckModel`, `sixFrag`) — a named `example` each is owed before the gate |
| `v6_count` | 72 models, exact tool; a Lean `example` of one configuration owed |
| `star_recip`, `star_anti`, `outerAdj`, `doubleTip` | satisfiability open at six colours (the hub and (Q)-ring questions, FS-124); docstrings say so and name the object meeting the local hypotheses but one |
| `v6_hubs`, `v6_hug` | VACUITY DECLARED, with `v6_hubs_vacuous`, `v6_hug_vacuous` (ruling, item 518) |
| `emptyNS` | a refutation; its hypotheses hold together at `k = 9` on SQ9's lattice vertex — the Lean term `sq9 : ArcMap 9` with `Valid`, `NonSiamese`, `Covers`, four colours and `GammaFreeRing` is **owed before the wave's gate** (wave 6 owes `sq9` already, item 486) |

### 5.6 The handoff

- **Statements are fixed**; a change an implementer needs comes back through the coordinator. Docstrings may be corrected.
- **Two implementers, by file**: *I8A* on `Plane/RingCalculus/Empty` — `ringPt_sixth_dist_le_one`, `v6_count`,
  `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, then `emptyNS` (about 1,500–1,900 lines; `v6_hubs` first-priced at half of
  it); *I8B* on `Plane/RingCalculus/Star` — `star_recip`, `star_anti` (about 400 lines) — a small job that can ride with the second planning pass's
  first implementer. `outerAdj` and `doubleTip` wait for the second pass's plan.
- **The second planning pass (K8b)** takes: the nine SemiHub rows (arguments `plans/FS116-N3-proof.md`, `plans/FS116-V5-verification.md`,
  unread here), FS116-N2-SIXRING and FS116-RING-TWIST-C (into `Star`), the plans for `outerAdj` and `doubleTip`, the three words of § 3.3,
  the hypothesis `QArcsJoinOpposite`, and the check that FS116-V5-OUT2 is `star_outer_cone`.
- **Counting `sorry`**: `rg -c "^\s*sorry" Proofs/HadwigerNelson/Plane/RingCalculus/` — `Star.lean` 2, `Empty.lean` 8, `Basic.lean` 0.
- **Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from the worktree; `lake env lean` with
  `-DautoImplicit=false -DrelaxedAutoImplicit=false` for iteration (a module's `.olean` written with `-o` lets the next module iterate;
  remove it before the real build).

### 5.7 The registered expectations, scored

- *Short*: FS116-N2-ANTI — not met (stated, a 250-line leaf); FS116-V6-COUNT — met in part (a certified computation, and its last step a
  new lemma); FS116-N3-PAIR, FS129-SR3-OUTERADJ, FS129-MR1-DOUBLETIP — not tested (arguments unread). **Not predicted**: the two rows that
  were short are FS116-RING-GERM and FS116-N2-STAR, both because wave 3 had landed their Siamese forms.
- *An outside theorem*: none — met. The hidden plane topology is real at one place (`exists_ne_mem_closure_inter_of_split`), and is a
  connectedness argument, not Jordan's theorem.
- *A statement defect*: of the four rows named, none confirmed in the rows read (SIXRING, the V6 lemmas) — the V6 lemmas turned out
  *wider* than filed, not defective; FS116-V5-OUT2 is likely a restatement of a clause of STAR. **Not predicted**: the wording defect in
  FS129-SR3-OUTERADJ. *A row needing radius 2 under "radius above 1"*: not found — STAR, the one row whose stage note says "above 2",
  reads radius 1.

### 5.8 Slips, the job's

- Thirteen of 22 rows' arguments unread (the nine SemiHub rows, RING-TWIST-C, OUTERADJ, DOUBLETIP; SIXRING read and not stated): § 2's E
  marks. The obligation-modeling pass covers the ten stated leaves only.
- The expectations were written to file after two arguments had been opened (§ 1.3).
- The first build's wait for a slot was spent reading, not saved as a stage; stages 2–5 are committed together.
- No `example` applies a proved theorem to a Lean model yet (§ 5.5).
- **Three names of the first draft were already declared on `main`**, in modules the foundation did not import:
  `cos_nonpos_of_mem_coneAt` (`Plane/ValidMap/UnitArc` l. 1612 — the same lemma, its hypothesis as `∀ z ∈ S, 1 ≤ dist z (y + e γ)`),
  `IsOuterTile` (`Plane/ValidMap/MapGraph` l. 66 — another notion, a tile in no hole) and `anti` (`Plane/ValidMap/BaseSteps` l. 1590,
  FS112-N3-ANTI). The second build failed at the root import on the first of them (`data/fs131/k8/logs/build-2-skeleton.log`,
  "environment already contains …"); `lake env lean` on one module cannot see this, and my search for prior declarations had read
  `Plane/*.lean` only. Repaired before any commit: the duplicate lemma deleted and the landed one used (`…/Basic` now imports
  `Plane/ValidMap/UnitArc`; `cos_nonpos_of_coneAt_of_disjoint` is its disjointness form), `IsOuterTile` renamed `IsOuterTileAt`,
  `recip` and `anti` renamed `star_recip`, `star_anti`; every new name then grepped against all of `Proofs/` by declaration keyword. The
  mid-job message to the coordinator carried two of the old names; the message with the foundation's hash corrects them.

---

# FS131-K8b — the second planning pass (stages 6 onward)

*Job FS131-K8b (de Bruijn, the planner), 2026-10-06, branch `fs131-w8`, from `368a2c1a`. Brief:
`data/fs131/briefs/FS131-K8b-wave8-second.md` (on `main`), with its Amendment 1. Working files: `data/fs131/k8b/`. The stages continue
the first pass's numbering.*

## Theorems this phase proved (FS131-K8b)

All [kernel] on branch `fs131-w8` (built through `./scripts/build.sh`, log `data/fs131/k8b/logs/build-3-split.log`; not gated, not on
`main`); declarations of `HadwigerNelson.Plane.ArcMap` in `Plane/RingCalculus/SemiHub` unless a module is named.

- **FS116-V5-QCOL**, its carried-colour clause, Siamese pairs allowed — `qcol_cw`, `qcol_ccw` (over wave 3's `germ_absent_class`,
  `not_germIn_closure_rotate`); its outer-tile clause at any tile of any valid map — `IsTile.not_mem_closure_of_not_subset_ball`.
- **FS116-N3-CONE (b)**, the four half-circles — `germOnQ_bar_uPlus`, `germOnQ_bar_vMinus`, `germOnQ_bar_uMinus`, `germOnQ_bar_vPlus`
  (over wave 3's `germR_*`, with `IsRingArc.germIn_closure`, `GermOnQWith.germIn_closure`); **(c)**, the set step —
  `closure_inter_subset_sphere`.
- The definitions' first lemmas: `IsEdgeDir.symm`, `IsStar4.isEdgeDir₁₂`, `…₂₃`, `…₃₄`, `IsStar4.angleIcc_subset_cone₂`, `…_cone₄`,
  `isSemiHub_iff_qSide`, `isFullSemiHub_iff_qSide`.
- **From stated leaves** (each a proof term over a `sorry` leaf, so not yet a theorem of the kernel): `ringArc_dist_le_one` (from
  `qcol_inner_tile`), **FS116-N3-PAIR** `germPair_swap` (from `germPair_inner_ne`), FS116-N3-CROSS's first clause as filed
  `crossed_tip_zeroAngle` (from `crossed_no_tip`), **FS116-RING-TRANSFER-QC**'s first clause `transferQC` (from `semiHub_places`; the
  last two in `…/SemiHubPlaces`).
- **FS116-V5-OUT2** is the first pass's `star_outer_cone` (`…/Star`): a citation, no declaration.

Stated with `sorry`: 17 leaves in `…/SemiHub`, 6 in `…/SemiHubPlaces` (Stage 9's tables). Not stated: FS116-N2-SIXRING,
FS116-RING-TWIST-C (§ 9.7).

## Stage 6 — SAVED: the readback, the registered expectations, what may and may not change

### 6.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_k8b_quotes.py` reads every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace
collapsed, in the source (`data/fs131/k8b/logs/quotes.log`): **40 quotations, 40 found verbatim, 0 missing**. Planted fault
(`--fault`, one letter changed in the first quotation): exit 1, one `MISS` (`data/fs131/k8b/logs/quotes-fault.log`).

Three notes on the sources, none a defect of the brief:

- The five statements of wave 7 (`qArc_inner`, `qArc_outer`, `qArc_ne`, `qArc_cone_disjoint`, `qArc_others_absent`) were found in the
  worktree `fs131-w7` and then read whole at the commit the brief names (`git show 195c7855:…/FourColour/Local.lean` ll. 215–250):
  the same five, each with `sorry`. `ring_odd` and `ring_odd'` are at ll. 185–199 of that file, stated with `¬ F.OnRingArc p (ringPt p θ)`
  on a half-open window.
- The inventory in this worktree stops before item 508; items 498, 518, 524, 525, 533, 541, 553, 563, 567 were read on `main`.
- Amendment 1 says three `sorry` leaves at `368a2c1a`: counted by `rg -c "^\s*sorry"`: `Star.lean` 2, `Empty.lean` 1 — three.

### 6.2 What was read before the arguments

The first pass's record whole (Stages 1–5); `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building; the milestone plan's
§§ 7.1–7.5; the wave's modules in full: `Plane/RingCalculus/Basic`, `Star`, `Empty`, `SoleTip` (the implementer's), and the statement
surfaces of `TilesAt`, `RingColour`, `HubCount`; `Plane/LocalMap` and `Plane/SimpleOn` in full; the eleven rows' entries
(`data/fs131/k8/rows-extract.md`).

### 6.3 What this pass may and may not change

- **May**: new modules under `Proofs/HadwigerNelson/Plane/RingCalculus/` (with `Proofs.lean`, `ARCHITECTURE.md`); a block
  "FS131-K8b" in `scripts/Axioms.lean`; this record; `tools/fs131_k8b_*.py`; `data/fs131/k8b/`; the report.
- **May, after telling the coordinator**: the *statement* of `outerAdj` in `Empty` (the one leaf of that file the implementer leaves
  alone). `doubleTip` is proved (Amendment 1): its statement is decided at the wave's landing.
- **May not**: `Basic` (shared with wave 9 by ancestry), `Star`, `Empty` beyond `outerAdj`'s statement, the implementer's four
  modules (`HubCount`, `TilesAt`, `SoleTip`, `RingColour`), any landed module, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`. No merge
  of another branch unless asked. No name of wave 6's `Plane/Saturated/Fragment` or of wave 7's `Plane/FourColour/*` restated.

### 6.4 Registered expectations

Registered after the entries, the first pass's record and the Lean foundation, and **before** any of the unread arguments
(`plans/FS116-N3-proof.md`, `plans/FS116-V5-verification.md`, `plans/FS116-N1-proof.md` § 2.2, `plans/FS129-SR3-audit.md`,
`plans/FS129-MR1-audit.md`; `plans/FS116-N2-proof.md` ll. 200–230 for the `star_anti` gap).

**Rows expected to hide a statement defect** (probability that the entry lacks a hypothesis its argument reads, or a word has no
reading under which the row is true as filed):

| row | p | where |
|---|---|---|
| FS116-N3-STAR2 | 0.35 | "the tiles of p are, counter-clockwise, …" reads exactly four tiles at `p`; the entry says "at least four colours" (0.6 that four is forced by another row, so no defect); a degenerate window when `ℓ + m = 60°` |
| FS116-N3-CROSS | 0.5 | the last clause ("`p` is a semi-hub of kind O of the ring of `y`") — one mind and a checking reading; "cone of zero angle" for a tile that may have an empty or a one-point cone |
| FS116-N3-SEMI | 0.4 | "the tile of `p` whose cone holds `ψ + 180°` (kind O) or `ψ` (kind T) in its interior" — cone at `p` or at `y`? |
| FS116-N3-CONE | 0.4 | the edge clause: "an edge at `y` between a tile inside `B̄(w, 1)` and a tile outside `B(w, 1)`" needs the two tiles adjacent along a common boundary arc from `y` |
| FS116-RING-TWIST-C | 0.5 | the half-open window's ends (an arc of `Γ` ending at the window's start); `σ` undefined in the entry |
| FS116-V5-QCOL | 0.25 | "in this setting"; "the hub's partner point" at a change point that is no hub |
| FS116-N2-SIXRING | 0.2 | the indexing's existence; the covering step |
| FS116-V5-DICHO, FS116-N3-PAIR | 0.15 each | |
| `outerAdj` (stated) | 0.3 | that it needs *simple* or a second germ condition |

**Expected to be one theorem** (or a citation): FS116-V5-OUT2 is `star_outer_cone` (0.85); FS116-N3-PAIR is the bracket of
FS116-V5-DICHO's first alternative, one theorem and a corollary (0.8); FS116-RING-TRANSFER-QC adds nothing to SEMI, PAIR, STAR2,
CROSS (0.8); FS116-N3-CONE's first four clauses are wave 3's `germR_*` in tile form (0.8); FS116-RING-TWIST-C's last clause and wave
7's `ring_odd` are one theorem and a corollary (given by the brief).

**How many rows will be stated in this pass**: median 8 of 11 (5 to 11); the likeliest to go to a third pass are FS116-N2-SIXRING and
FS116-RING-TWIST-C (their arguments are the longest per row and neither is on the SemiHub rows' dependency chain).

**The `star_anti` gap** (Amendment 1, item 3): expected a missing lemma, 0.5; a statement defect needing a hypothesis, 0.3; a
deriver's question, 0.2. Formed from the Lean side only: `SimpleOn.coneAt_eq_angleIcc_sep` allows `β₂ = β₁ + 2π`, and then every
other tile of `p` has its cone inside the one direction `β₁` — three horns in one direction beside a tile that surrounds `p`; I do
not yet see what excludes it between two antipodal hubs.

Scored in the last stage.

### 6.5 The branch as given

`./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`), log `data/fs131/k8b/logs/build-1-as-given.log`; at
this save it waits for a slot (two 40 GiB builds hold 80 of the ledger's 90). Its result is recorded in Stage 7's first lines.

## Stage 7 — SAVED: the first pass's questions, from the arguments

*The branch as given built: `data/fs131/k8b/logs/build-1-as-given.log` ends "build: OK — 468 of 468 batches, 6 module(s) rebuilt, 2
module(s) with warnings", `EXIT=0` (the six are the implementer's four modules, `Empty` and the root; the warnings are the three `sorry`
leaves).*

**Read in full in this pass**: `plans/FS116-N3-proof.md` (all 525 lines); `plans/FS116-V5-verification.md` § 1.4, § 2.1 (V5-RING,
-GERM, -OUT, -TIPSET), Stage 3 whole (§§ 3.1–3.6) and Stage 4's divergence tables for SEMI, PAIR, CROSS; `plans/FS116-N1-proof.md`
§§ 2.1–2.3 (TWIST-D, RING-TWIST-C, the slit); `plans/FS116-N2-proof.md` § 2.2 (STAR, RECIP, ANTI); `plans/FS129-SR3-audit.md` Stage 3
(§ 3.1, OUTERADJ); `plans/FS129-MR1-audit.md` ll. 120–206 (DOUBLETIP, mechanism 3a); wave 7's five statements and `ring_odd` at
`195c7855`. **Not read**: `plans/FS116-N2-proof.md` § 2.1 (SIXRING — the first pass read it; not re-read, and the row is not stated
here); `plans/FS116-V6-verification.md` (the first pass's).

### 7.1 FS116-V5-OUT2 is `star_outer_cone` — a citation

The row: "in V5-QCOL's setting (or V5-RING's), if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour
c has its cone at p in [θ + 90°, θ + 270°]" (`plans/FS116-V5-verification.md` l. 543). "Outer tile" is § 13's — a tile of a colour of
`p` that is not a tile of `p` — which is `outerTileColours`; the conclusion is `star_outer_cone`'s at `ψ = θ`, word for word
(`Star.lean` l. 125). Its Lean proof reads valid and non-Siamese only: the setting clause is idle (**generalization**), and the route is
shorter than V5's (two tiles of one colour are near or far, so the far tile misses `B(y, 1)`; no root of a quadratic). No declaration.

### 7.2 `doubleTip` and `v6_hug`: the extra hypotheses were a route's

`not_sole_tip_of_adjacent_changePoints` (`SoleTip.lean`, read in full) against `plans/FS129-MR1-audit.md` ll. 156–176: the two far germs
enter MR1's step 1 only (RING-GERM (i), to make the sole tip's cone contain `(150°, 210°)` at `y` and `(210°, 270°)` at `y′`, the input
of FS116-Y4-FLANK); *simple* enters step 3 only ("R's cone — one interval (simple)", to identify the flank tile); the Γ-free ring was
V6's setting and is never read (MR1's look-back, ll. 178–179). The implementer's proof takes the colour beside the tip from the sole-tip
hypothesis itself (a tile of a colour of `p` inside `B(p, 1)` near `y` is a tile of `p` and of `y`, hence the tip) and forms no cone. Its
hypotheses are a subset of both entries', so no case is excluded another way. **Recommendation for the landing**: one theorem (the
lemma), the two rows its corollaries; a generalization for the errata of FS116-V6-HUG and FS129-MR1-DOUBLETIP (inventory items 563, 567).

### 7.3 The gap at `star_anti`: a defect of the skeleton's hypothesis, not of the row

The row excludes "anything when an edge of p leaves at ψ + 90° or ψ − 90°" (its *not claimed* line, `plans/FS116-derivation.md:714`
entry), and `plans/FS116-N2-proof.md` ll. 228–229 gives the general form ("if no edge of p leaves at a direction δ, the tile holding δ
…"). The skeleton states "in the interiors of the cones" as `ψ ± π/2 ∈ interior (coneAt t p)`, the interior of a set of reals. The two
agree unless the cone is every direction. Then: with `t⁺ = t⁻ = t`, a tip of `y` (cone in `[ψ − 90°, ψ + 90°]`,
`IsTip.coneAt_subset`) and the tile of `p` of an outer colour of `y` (cone in `[ψ + 90°, ψ + 270°]`, `star_outer_cone`) are other
tiles than `t`, so by `SimpleOn.coneAt_eq_angleIcc_sep` each has its cone inside the one direction `β₁` the open interval leaves free,
and non-empty: `β₁ = ψ ± 90°`. That is three cusp tiles along `ψ + 90°` (or `ψ − 90°`) beside a tile that surrounds `p` — edges of `p`
do leave along `ψ ± 90°`, the case the row excludes and the Lean hypothesis admits. I found no first-order exclusion of that
configuration (worked: the tips of `y` and `y*` are two of the cusps, each tangent to its hub's unit circle from inside; the third
cusp lies between the two circles; colours and distances at `p`, `y`, `y*`, `u`, `v` are consistent to first order) and no
construction. **The hypothesis to add**: `∀ T, F.TileAt p T → T ≠ tp → ψ + π/2 ∉ coneAt T p` and its mirror for `tm` — in this pass's
word, no `IsEdgeDir p tp T (ψ + π/2)`. Sent to the coordinator (inventory item 568) and ruled: the two binders are added by the
owner of `Star.lean`. No row of this pass reads `star_anti`. The excluded case is a stub line, not a job: "can a tile of a four-colour
vertex have every direction in its cone, with two antipodal hubs?"

### 7.4 `outerAdj` stands as stated

Against `plans/FS129-SR3-audit.md` § 3.1 (ll. 304–327): the two germ hypotheses are the row's (`hv`: the arc just counter-clockwise of
`r(ψ − 60°)`; `hu`: the arc just clockwise of `r(ψ + 120°)`), the conclusion is its *not claimed* line's reading (`O_y = {c} = O_y′`),
and "No step reads simple" (l. 327) is confirmed: the Lean statement has no `SimpleOn`. The argument reads "at most two colours
absent", never six: a candidate generalization (`k ≤ ncard + 2` in place of `ArcMap 6`), as for the sole-tip lemma; the statement is
left as the first pass fixed it. Its plan is § 9.4.

### 7.5 The three words, in the arguments that use them

| word | where | what the argument reads | definition |
|---|---|---|---|
| "an edge of `p` between `t`, `t′` in a window `[α, β]`" | STAR2 (`plans/FS116-N3-proof.md` ll. 233–237) | the common end direction of two consecutive cones at `p` — first order only | the star's `e_i ∈ Icc α β`; standalone, `IsEdgeDir p T T′ δ` |
| "no edge of `p` leaves at `δ`" | ANTI (`plans/FS116-N2-proof.md` l. 228) | exactly one tile of `p` approaches `p` along `δ` | `∀ T′, ¬ IsEdgeDir p T T′ δ` |
| "an edge at `y` … is an arc of `ω(w)`" | CONE (c), SEMI (b) (ll. 212–215, 256–262) | a curve: an initial piece of an arc of the map leaving `y`, in two tiles' closures | the landed `Arc.InitialPiece` (wave 3) and `BothKind` (wave 4); no new word |
| "unless an edge of `p` runs along `ω(y)` at `p`" | CROSS step 4 (ll. 411–413) | `p` on an arc of `Γ` on `ω(y)` | the landed `OnRingArc y p` (as `star_recip`'s `hna`) |
| "the tiles of `p` are, counter-clockwise, …" | STAR2 | four cones, consecutive closed intervals covering the directions | `IsStar4` |
| "a cone of zero angle" | CROSS step 1 (ll. 402–405) | "what is left is the single direction 210°": the cone lies in one direction | `ZeroAngleAt` |
| "the tile of `p` whose cone holds `ψ + 180°` … in its interior" | SEMI (c) | the cone at **`p`** (V5's attack, l. 674: "not the tile at y"), and the argument gives the cone ⊇ `[ψ + 150°, ψ + 210°]` | stated in that stronger form |

## Stage 8 — SAVED: the definitions (`debruijn-domain-modeling`, invoked fresh), the skeleton, the read-backs

Two new modules, so that two implementers share no file: `Plane/RingCalculus/SemiHub` (the words, FS116-V5-QCOL, -N3-PAIR, -V5-DICHO,
-N3-CONE, -N3-STAR2) and `Plane/RingCalculus/SemiHubPlaces` (FS116-N3-SEMI, -N3-CROSS, RING-TRANSFER-QC), which imports it.
`Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` PASS, `data/fs131/k8b/logs/check-architecture.log`),
`scripts/Axioms.lean` (block "FS131-K8b", above the PURCHASED banner: the declarations with no `sorry` beneath them). No `axiom`, no
`native_decide`. `Basic`, `Star`, `Empty` and the implementer's four modules are untouched.

### 8.1 The model, and why this shape

- **The intrinsic object is first-order: the cones of the tiles of `p` as closed intervals of directions.** STAR2's argument never
  leaves it (windows from FS112-U1, a cyclic order of intervals). So "the tiles of `p`, counter-clockwise, with edges in windows" is
  `IsStar4`: four tiles, pairwise distinct, all the tiles of `p`, cones `[e₁, e₂]`, `[e₂, e₃]`, `[e₃, e₄]`, `[e₄, e₁ + 2π]` with
  `e₁ ≤ e₂ ≤ e₃ ≤ e₄ ≤ e₁ + 2π`; a row's "the edge `t|t′` lies in `[α, β]`" is `e_i ∈ Icc α β`. It is the landed sector chart
  (`IsSectorChart`, wave 3) read out at four tiles with the tiles named — a `Prop`-valued structure beside the map, no index. The
  degenerate star (three cusps in one direction, `e₁ = e₂ = e₃ = e₄`) is representable: it is § 7.3's configuration.
- **The curve-level "edge" needs no new word**: wave 3's `Arc.InitialPiece` and wave 4's `BothKind` already say "an edge leaving `y`"
  and "an arc of `ω(w)` both of whose side colours are carried at `w`". Defining a second edge word would have been one concept in two
  costumes.
- **The two germ pairs are the two orbits of one reflection** (in the line `p y`: `u ↔ v`, clockwise ↔ counter-clockwise), so a pair
  is a `Side`: the germ on side `s` of `u` with the germ on side `s.flip` of `v` (`Side.flip` is landed, `Plane/ValidMap/HexRing`).
  PAIR and DICHO are stated once over `s`; `SemiKind.qSide` (`O ↦ ccw`, `T ↦ cw`) with `isSemiHub_iff_qSide`,
  `isFullSemiHub_iff_qSide` (proved) bridges to the foundation's four clauses, which stay as they are.
- **No named hypothesis for FS114-N7-QOPP** (the brief's item 5; a decision of this pass, sent to the coordinator). What STAR2, CROSS
  and RING-TRANSFER-QC read of it (`plans/FS116-N3-proof.md` ll. 194–199): (i) FS112-U1's two cone windows — landed in wave 3 at class
  level, Siamese pairs allowed (`ringArc_cone_inner`, `ringArc_cone_outer`, `Plane/RingGerm` ll. 2185, 2194); (ii) "the inner tile is
  `p`'s tile and holds the arc" — FS116-V5-QCOL's own clause, `qcol_inner_tile` here; (iii) the cyclic position of the two tiles, which
  wave 7's five statements do not carry and which is `ringArc_star` here. A hypothesis provable in ten lines from landed lemmas is not a
  hypothesis. **At the join**: wave 7's `qArc_inner` (first clause) and this pass's `qcol_inner_tile` are one lemma under two names —
  one of them becomes a one-line corollary; `qArc_inner`'s cone clause and `qArc_outer` are `coneAt_mono` of the two landed lemmas.
- **`ZeroAngleAt`** is kept for the row's wording and for cusp tiles; CROSS's clause is stated at its truth (`crossed_no_tip`) with the
  row's wording a corollary.

### 8.2 What the pass changed

1. A first draft carried `QArcsJoinOpposite` as a four-field structure; reading wave 3's `ringArc_cone_inner` showed three of its
   fields landed and the fourth a clause of QCOL: removed.
2. DICHO and STAR2 were first drafted over a full semi-hub; their arguments read only the two arcs and four tiles at `p`: restated
   with no change point (G92). STAR2's arcs are given as `IsRingArc p (ψ + π/3) (ψ + π/3 + ℓ) a a′` — the sub-arc from `u` — and
   `GermOnQWith.exists_isRingArc_ccw`, `…_cw` produce it from a germ, so QCOL's "a (Q) arc holding `u⁺` and not `u⁻` ends at `u`" is
   needed by no consumer.
3. `qcol_not_one_arc` lost its change point: both germs' points lie in the closure of one tile of `p` and are more than `1` apart,
   whichever way round the arc goes — V5's branch "would contain `y`" is not needed. The root is `ringArc_dist_le_one` (proved from
   `qcol_inner_tile`).
4. SEMI's "holds `ψ + 180°` in its interior" would have repeated § 7.3's defect; stated as cone ⊇ `[ψ + 150°, ψ + 210°]`.
5. Names: wave 7 holds `ArcMap.pair`, `main` holds `anti`, wave 6 `pair_param`; every name here was grepped by declaration keyword
   against `Proofs/` on this branch and on `fs131-w6`, `fs131-w7`, `fs131-w9` (`qArc_*` avoided; `germPair_*`, `ringTile_*`,
   `crossed_*`, `fullSemiHub_star_*` are new), then `./scripts/dupnames.sh` on the built tree (§ 8.5).

### 8.3 The statements against their rows

- **FS116-V5-QCOL** ("in this setting p has exactly four colours and X, X̄ are the two absent; a germ that lies on no (Q) arc
  "carries" an absent colour … namely X at u⁻ and v⁻ and X̄ at u⁺ and v⁺, and the hub's partner point (u or v) lies in the closure of a
  tile of that colour; a germ on a (Q) arc lies on an arc of ω(p) whose inner tile is p's tile of the inner colour and whose outer
  tile is not a tile of p; the two germs of one pair never lie on one (Q) arc, and a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u
  (v)"): first clause — landed `germS_absent`. "Carries": `qcol_cw` (`GermIn p θ .cw (closure (F.region X))` for `θ = ψ ± π/3`),
  `qcol_ccw` (`X′`); the partner point by `GermIn.ringPt_mem_closure`. Inner tile: `qcol_inner_tile`. Outer tile: the general
  `IsTile.not_mem_closure_of_not_subset_ball`. One arc: `qcol_not_one_arc`. "Ends at `u`": **not stated as such** — replaced by the
  sub-arc lemmas (§ 8.2 item 2); the literal clause (the arc's own end is `u`) is not in the kernel and no row reads it.
- **FS116-N3-PAIR**: `germPair_swap` — `{a, a′} = {b, b′} → a = b′ ∧ a′ = b` for the pair on side `s`; the row's class (change point,
  simple, four colours) contains the statement's.
- **FS116-V5-DICHO**: `germPair_dicho` — `(a = b′ ∧ a′ = b) ∨ Disjoint {a, a′} {b, b′}`; "Π₁ = Π₂ (and then the inner colour of each
  is the outer colour of the other)" is the first disjunct (it implies `{a, a′} = {b, b′}`).
- **FS116-N3-CONE**: (a) `ringTile_uMinus` (`R ⊆ closedBall u 1`, with `u ∈ closure R`), `ringTile_vMinus` (`Disjoint R (ball v 1)`),
  `ringTile_vPlus`, `ringTile_uPlus`; `R`, `R′` are "the tile of colour `X` (`X′`) with `y` in its closure". (b) the four
  `germOnQ_bar_*` — the half-circles `(ψ + 30°, ψ + 210°)` for `u⁺`, `(ψ + 150°, ψ + 330°)` for `v⁻`, `(ψ − 150°, ψ + 30°)` for
  `u⁻`, `(ψ − 30°, ψ + 150°)` for `v⁺`, each as `Ioo` in radians, the conclusion on the two colour classes (what "bars both colours"
  says of every tile of them). (c) `closure_inter_subset_sphere`, `isRingArc_of_edge` ("is an arc of `ω(w)`": an `IsRingArc w` with
  `y` on it, inner colour the inside tile's), `four_le_of_bothKind`.
- **FS116-N3-STAR2**: `fullSemiHub_star_crossed` — the row's four windows in radians (`π/6 = 30°`): `e₁ ∈ [ψ + ℓ − 30°, ψ + 30° − m]`
  (the edge `t_b|t_a`), `e₂ ∈ [ψ + 30°, ψ + 150°]` (`t_a|t_b′`), `e₃ ∈ [ψ + 150° + ℓ, ψ + 210° − m]` (`t_b′|t_a′`),
  `e₄ ∈ [ψ + 210°, ψ + 330°]` (`t_a′|t_b`), the star read from `t_a`; `ℓ + m ≤ π/3`. `fullSemiHub_star_parallel` — "`t_a ⊂
  [ψ + 30°, ψ + 150°]`, `t_a′ ⊂ [ψ + 210°, ψ + 330°]`" as bounds on the star's edges, "the other two tiles' cones contain
  `[ψ − 30°, ψ + 30°]` and `[ψ + 150°, ψ + 210°]`" by `IsStar4.angleIcc_subset_cone₄`, `…_cone₂`. **Not in the statements**: "full
  semi-hub of kind O" (not read; the docstring says how the row's hypothesis gives the arcs).
- **FS116-N3-SEMI**: `semiHub_places` — three alternatives as the row's; the second with the landed `BothKind` and `y ∈ ringArc w θ₁
  θ₂`; the third with `IsFullSemiHub`, the swapped pair as two `GermOnQWith`, `coloursAt y = (coloursAt p)ᶜ ∪ {c}`.
- **FS116-N3-CROSS**: `crossed_no_tip` (stronger than "zero angle"), `crossed_tip_zeroAngle` (the row's clause), `crossed_outer`
  (`⊆ {a′, b′}`), `crossed_four` (`O_y = {a′, b′}`, `A(y) = {a, b}`; "every tile at y a cone of positive angle" dropped as idle),
  `crossed_changePoint` (`IsChangePoint y (ψ + π) b a`: `b` just counter-clockwise, `a` just clockwise; `¬ OnRingArc y p`),
  `crossed_semiHub` (`IsSemiHub y (ψ + π) .O`).
- **FS116-RING-TRANSFER-QC**: `transferQC`, its first clause (a weakening of SEMI: where the four-colour vertex lies); the other
  clauses are cited. "Four colours" at `p` is `4 ≤ ncard` with `k ≤ ncard + 2`, as everywhere in the wave.

### 8.4 The statements, attacked

- **Signatures read from the kernel** (`#check @…` on fourteen leaves, `data/fs131/k8b/logs/semihub-signatures.log`): every hypothesis
  is a binder of the statement; no section variable carries one (the modules declare only `{k}` and `{F}`).
- **The windows against the held objects** (by hand, from `plans/FS116-N3-proof.md` l. 244): the strip's `P₀`, `ℓ = m = 15.52°`, edges
  at `0°, 90°, 180°, 270°`: `0° ∈ [−14.48°, 14.48°]`, `90° ∈ [30°, 150°]`, `180° ∈ [165.52°, 194.48°]`, `270° ∈ [210°, 330°]`; the
  bowtie's centre, `ℓ = m = 60°`, `t3 = [120°, 240°]` at `ψ = 90°`: equal to `[ψ + 30°, ψ + 150°]`.
- **DICHO's one-shared-colour cases** (V5 wrote "cases written in my working" for the outer pair, l. 582): worked here from the
  windows for both pairs. Star from `A₁` with `t_a = t₁`, `t_a′ = t₃`. Tip pair, windows `in(A₁) = [ψ − 30° + ℓ₁, ψ + 150°]`,
  `out(A₁) = [ψ + 150° + ℓ₁, ψ + 330°]`, `in(A₂) = [ψ + 210°, ψ + 390° − ℓ₂]`, `out(A₂) = [ψ + 30°, ψ + 210° − ℓ₂]`: (`b = a′`)
  `t₃ ⊆ in(A₂)` forces `e₃ ≥ ψ + 210°`, and `t_b′ ∈ {t₂, t₄} ⊆ out(A₂)` then needs `e₂ ≥ ψ + 390°` or `e₄ ≥ ψ + 390°`; (`b′ = a`)
  `t₁ ⊆ out(A₂)` forces `e₁ ≥ ψ + 30°`, and `t_b = t₂` needs `e₃ ≤ ψ + 30° − ℓ₂`, `t_b = t₄` needs `e₁ ≤ ψ + 30° − ℓ₂`; (`b′ = a′`)
  `t₃ ⊆ out(A₂)` forces `e₄ ≤ ψ + 210° − ℓ₂`, and `t_b ∈ {t₂, t₄} ⊆ in(A₂)` needs `e₃ ≤ ψ + 30° − ℓ₂` or `e₄ ≤ ψ + 30° − ℓ₂` — each
  against the star's bounds. Outer pair, `in(A₁) = [ψ − 30°, ψ + 150° − ℓ₁]`, `out(A₁) = [ψ + 150°, ψ + 330° − ℓ₁]`,
  `in(A₂) = [ψ + 210° + ℓ₂, ψ + 390°]`, `out(A₂) = [ψ + 30° + ℓ₂, ψ + 210°]`: the same three cases close the same way. One mind; the
  implementer's `linarith` is the second check. A longer arc narrows every window, so the statement needs no "ends at `u`".
- **`crossed_no_tip` for `t_a′`**: the windows alone do not exclude a tip (`[e₃, e₄] ⊆ [ψ + 270°, ψ + 330°]` is inside a tip's
  half-circle); what excludes it is `e₃ ≤ ψ + 210° − m` from the crossed star — the statement rightly rests on STAR2.
- **A statement of this pass shown too weak before it was saved**: none found false. Two were found *wider than drafted* (§ 8.2
  items 2, 3).

### 8.5 The build

`./scripts/build.sh` under the slot; logs `data/fs131/k8b/logs/build-2-semihub.log` (the single-module draft) and
`build-3-split.log` (the two modules as committed); results in Stage 10's first lines.

## Stage 9 — SAVED: the plan per leaf (`debruijn-obligation-modeling`, invoked fresh), prices, inhabitants, the handoff

### 9.1 The statements the proofs derive from

Three lemmas carry the module; every other leaf is one of them with arithmetic.

1. **`ringArc_star`** — a (Q) arc of a four-colour vertex simple at it puts the star in a normal form (inner tile first, outer colour's
   tile third, four bounds on the edges). The crossed star, the two parallel stars, DICHO, `crossed_no_tip` (for `t_a′`, `t_b′`) and
   `crossed_outer` are each: take that star, locate one or two more coloured tiles at positions 2 and 4, and close by `linarith` on
   `e₁ … e₄`. The repeated chain is one missing lemma, minted once: **C1 `exists_int_of_angleIcc_subset`** — `a ≤ b → hi < lo + 2π →
   angleIcc a b ⊆ angleIcc lo hi → ∃ m : ℤ, lo + 2 * π * m ≤ a ∧ b ≤ hi + 2 * π * m` (a connected interval inside a disjoint union of
   translates lies in one), with **C2** "an integer `m` with `|2πm| < 2π` is `0`". Every use is then `obtain ⟨m, _, _⟩ := C1 …; have :
   m = 0 := …; linarith`.
2. **The non-Siamese engine at a germ** — `NonSiamese.tile_eq_of_dist_lt` (landed) through one child, **G1
   `mem_closure_tile_of_near`**: a closure point `z` of the class of `c`, in the domain, nearer than `1` to a closure point of a tile `R`
   of colour `c`, is in `closure R` (take a `c`-tile with `z` in its closure, `mem_coloursAt_iff_exists_tileOf`; it is `R`). `qcol_inner_tile`,
   the four `ringTile_*`, `germPair_inner_ne`, the far side tiles in SEMI and `crossed_no_tip` are this.
3. **The tiles of a point from its sector chart** (`localSectors`, `IsSectorChart.exists_tile_inter_ball`, `.cone`, `.sorted`; wave 3):
   under `SimpleOn {x}` the tiles of `x` are the chart's sectors, one each (**K1 `IsSectorChart.tileAt_equiv`**), and two consecutive
   sectors share the branch between them — an initial piece of a map arc in both closures (**K2
   `IsSectorChart.exists_initialPiece_between`**). `exists_isStar4` is K1 at `n = 4`; `isRingArc_of_edge` and SEMI's edges are K2. K2 is
   the one piece of plane topology in the pass; `exists_initialPiece_of_cone` (`Plane/LocalStructure` l. 3394) and wave 4's
   `exists_isRingArc*` lemmas (`Plane/ValidMap/BaseSteps`, `UnitArc`, `FlankUA`) are where to look first.

Partition: **proved** — every leaf below; **tested** — the windows on the strip and the bowtie (§ 8.4, by hand; no Lean model);
**assumed** — nothing (no named hypothesis).

### 9.2 `Plane/RingCalculus/SemiHub` — seventeen leaves

Landed lemmas confirmed by elaboration in this pass's proofs: `germS_absent`, `germ_absent_class`, `not_germIn_closure_rotate`,
`germR_uPlus`, `germR_uMinus`, `germR_vPlus`, `germR_vMinus`, `IsRingArc.ringArc_subset_closure`, `IsTile.subset_ball`,
`IsTile.dist_le_one_of_mem_closure`, `mem_coloursAt_iff_exists_tileOf`, `Icc_subset_angleIcc`, `angleIcc_subset_angleIcc`
(`Plane/Woodall/Basic`), `mem_coneAt_of_mem_isOpen`, `Side.flip`. Named and read at their statements, not yet used:
`ringArc_cone_inner`, `ringArc_cone_outer`, `IsRingArc.mono` (`Plane/ValidMap/Procedure` l. 110), `angleIcc_add_int_mul`
(`Plane/ValidMap/HexRing` l. 433), `coneAt_nonempty`, `coneAt_region_eq_biUnion`, `coneAt_biUnion_finite`, `noBoth`,
`IsSectorChart.hasRepeatedColour_iff` (`Plane/ValidMap/Pushforward` l. 122), `dist_ringPt_shift_cmp`, `exists_ball_tileAt`,
`exists_fin_tileAt`, `unitNear_or_unitFar`, `UnitFar.one_le_dist_of_mem_closure`.

| leaf | route | children | hard | lines |
|---|---|---|---|---|
| `qcol_inner_tile` | for `φ ∈ Ioo θ₁ θ₂`: `innerColours = {c}` gives `c`-points in `ball p 1` near `r(φ)`; each is in `T` (engine, as `SoleTip`'s `key`); close the arc as `IsRingArc.ringArc_subset_closure` does | G1 | nothing | 35 |
| `GermOnQWith.exists_isRingArc_ccw`, `…_cw` | the closed sub-arc `r([θ, θ + ℓ])`, `ℓ < δ`, lies in the arc (compact, so closed); choose `ℓ` below the first `t > 0` with `r(θ + t) ∈ {r(θ₁), r(θ₂)}`, so every interior point is `r(φ′)`, `φ′ ∈ Ioo θ₁ θ₂` | "a point of `ringPt p '' Icc` that is not an end's image is an interior point's image" | angles modulo `2π` | 70 + 40 |
| `qcol_not_one_arc` | `ringArc_dist_le_one` on a point of each germ; `dist_ringPt_shift_cmp` gives more than `1` at angular distance `120° ± (t + t′)` | — | nothing | 40 |
| `germPair_inner_ne` | sub-arcs at `u`, `v`; if `a = b` one tile of `p` holds both (`qcol_inner_tile` twice): the same chord | — | nothing | 60 |
| `germPair_dicho` | sub-arcs; `germPair_inner_ne`; `ringArc_star` on the arc at `u`; the three one-shared-colour cases × the position of the fourth tile, each `linarith` after C1 (§ 8.4) | C1, C2 | bookkeeping: twelve small cases | 200 |
| `ringTile_uMinus`, `ringTile_vPlus` | `qcol_cw` / `qcol_ccw` puts the germ in the closure of the class; G1 with the ring germ of `y` (in `R`: one tile per colour at `y`) puts it in `closure R`; `IsTile.subset_ball` | G1; "the ring germ of a change point lies in the tile of its colour at `y`" | nothing | 60 + 30 |
| `ringTile_vMinus`, `ringTile_uPlus` | the class's tile at `v` (at `u`) is not `R` (`R′`): its closure holds germ points more than `1` from `R`'s; far apart (`unitNear_or_unitFar`, non-Siamese), so `≥ 1` from `v` | the same two | nothing | 2 × 45 |
| `isRingArc_of_edge` | `B ⊆ sphere w 1` (`closure_inter_subset_sphere`); a segment has no three points on a circle, a circular piece on `ω(w)` has centre `w` and radius `1`; shrink into the domain; sides constant by K2's local picture | K2 | **the plane topology at `y`** | 250 |
| `four_le_of_bothKind` | `noBoth`; no repeated colour at `w`: two sectors of one colour are two tiles (K1) of one colour at a point | K1; `not_hasRepeatedColour_of_simpleOn` | wave 7's `IsTacticAt.four_le_centre` is a twin: one lemma at the join | 80 |
| `exists_isStar4` | K1 at `n = 4` (four colours ↔ four tiles: `exists_fin_tileAt` and distinct colours); cones and order from `.cone`, `.sorted` | K1; `ncard_tileAt_eq` | sector → tile (each sector lies in one tile of `x`) | 250 |
| `ringArc_star` | a star; rotate (`IsStar4.rotate`, by `angleIcc_add_int_mul`) so `c`'s tile is first; C1 shifts it into the facing window; `c′`'s tile is not second or fourth (`linarith`), and its bounds by C1; `c ≠ c′` from disjoint windows and a non-empty cone | C1, C2; `IsStar4.rotate`, `IsStar4.shift`; `disjoint_angleIcc_antipodal` | nothing after C1 | 200 + 130 |
| `fullSemiHub_star_crossed` | `ringArc_star` on `A`; `b`'s tile is fourth and `b′`'s second (the other placement contradicts FS112-U1's windows for `B`, `linarith`); the four windows and `ℓ + m ≤ 60°` read off | C1 | nothing | 110 |
| `fullSemiHub_star_parallel`, `…_parallel_T` | `ringArc_star` on `A`; `B`'s windows on `t₁` (outer colour `a`) and `t₃` (inner colour `a′`) | C1 | nothing | 2 × 80 |

About 1,700 lines as priced; by the milestone's calibration (item 541: proofs 0.21 to 0.72 of plan) 400 to 1,250 written — **one
implementer job**.

### 9.3 `Plane/RingCalculus/SemiHubPlaces` — six leaves

| leaf | route | children | hard | lines |
|---|---|---|---|---|
| `semiHub_places` | below | K1, K2 at `n = 3`; the far side tile | **the largest leaf** | 450 + 200 |
| `crossed_no_tip` | sub-arcs; the crossed star; a tip is one of the four: `t_a`, `t_b` hold arc points more than `1` from `y` (`qcol_inner_tile`); `t_a′`, `t_b′` hold a direction outside `[ψ − 90°, ψ + 90°]` (`IsTip.coneAt_subset`, C1) | C1 | nothing | 120 |
| `crossed_outer` | `P = {a, a′, b, b′}`; `star_outer_cone` against `ψ + 30° ∈ cone t_a` and `ψ − 30° ∈ cone t_b` | "four distinct colours carried at a point of four colours are its colours" | nothing | 80 |
| `crossed_four` | `star_coloursAt`, `star_absent`, `crossed_no_tip`, `crossed_outer`; counting in `Set (Fin k)` | — | `ncard` arithmetic | 80 |
| `crossed_changePoint` | the two germs of `ω(y)` at `p` lie in colour classes (`¬ OnRingArc y p`, finiteness of `Γ ∩ ω(y)` off arcs — `star_recip`'s first child); their colours are absent at `y` (`not_mem_coloursAt_of_mem_sphere`), so in `{a, b}` (`crossed_four`); the germ's tangent direction `ψ ∓ 90°` is in its tile's cone at `p`, and the crossed star puts `ψ − 90°` outside `cone t_a` and `ψ + 90°` outside `cone t_b` | "a germ approaches its point along the tangent"; C1 | no curvature is needed (the entry's "bending at least as fast" is replaced by the colour set) | 200 |
| `crossed_semiHub` | change point: the leaf above. Tip pair not free: else `ringGerm_inward` at `y` gives a tip at `p` of `y`, a tip at `y` of `p` (`isTip_comm`) — none (`crossed_no_tip`). Outer pair free: a (Q) arc of `y`'s ring at such a germ has side colours carried at `y` and carried near `v` (`u`) inside `B(p, 1)`; `a′`, `b′` are not (their tiles of `p` would have `v` in the closure, against the star); so the sides are `X`, `X′`, distinct (`ringArc_cone_inner`, `…_outer` at `y`: disjoint windows, non-empty cones), so `cone R ∩ cone R′ = ∅` at `y`; but every direction of `[ψ + 90°, ψ + 270°]` at `y` is in `cone R ∪ cone R′` (a tile there of another colour of `y` would be a tip), both closed, both met: a common direction | `iUnion_coneAt_tileAt` (the cones of the tiles of a point cover the directions); `disjoint_angleIcc_antipodal` | **the row's weakest clause** (one mind and a checking reading): prove it last, report the step if it does not close | 300 |

**`semiHub_places`, the case table** (a route shorter than the entry's: no direction is tracked at `y`). `y` has at least three colours
(`star_coloursAt`; `star_outer_nonempty` for kind O, `star_tip_nonempty` for kind T). If exactly three: three tiles at `y` (K1), `R`,
`R′` and one more — an outer tile `C` (kind O; no tip) or a tip `τ` (kind T; no outer tile) — and *any two of three tiles are
consecutive*, so share an edge (K2). Then, by which germs of the other pair lie on (Q) arcs:

| case | the two tiles | why one is inside `B̄(w, 1)` and the other misses `B(w, 1)` | both colours at `w` |
|---|---|---|---|
| O, `v⁻` off | `R′`, `R` at `w = v` | `ringTile_vPlus`; `ringTile_vMinus` | `X′` (`v ∈ closure R′`), `X` (`qcol_cw`) |
| O, `u⁺` off | `R`, `R′` at `w = u` | `ringTile_uMinus`; `ringTile_uPlus` | `X`, `X′` (`qcol_ccw`) |
| O, full, `c ∈ {a, a′}` | `R`, `C` at `u` | `ringTile_uMinus`; `C` is not the `c`-tile at `u` (that one is `p`'s tile, or holds outer points of the arc more than `1` from `y`), so far from it | `X`, `c` (a side colour of the arc at `u`) |
| O, full, `c ∈ {b, b′}` | `R′`, `C` at `v` | mirror | `X′`, `c` |
| O, full, otherwise | — | `germPair_dicho` gives the parallel pair; `fullSemiHub_star_parallel`; `star_outer_cone` rules out `t_front`: the third alternative with `t_back` | — |
| T, `u⁻` off | `R`, `R′` at `u` | `ringTile_uMinus`; `ringTile_uPlus` | `X`, `X′` |
| T, `v⁺` off | `R′`, `R` at `v` | `ringTile_vPlus`; `ringTile_vMinus` | `X′`, `X` |
| T, full, `t ∈ {a, a′}` | `τ`, `R′` at `u` | `τ` is `p`'s tile of the inner colour (holds `u`), and cannot be far from the outer tile at `u` (`ringGerm_inward` gives it points in `B(u, 1)`); `ringTile_uPlus` | `t`, `X′` |
| T, full, `t ∈ {b, b′}` | `R`, `τ` at `v` | mirror | `X`, `t` |
| T, full, otherwise | — | parallel; `fullSemiHub_star_parallel_T`; `IsTip.coneAt_subset` rules out `t_back`: the third alternative with `t_front` | — |

In each edge case: K2 gives the initial piece, `isRingArc_of_edge` the arc of `ω(w)`, `four_le_of_bothKind` the four colours.
FS116-N3-CONE (b) (`germOnQ_bar_*`) is not read on this route.

About 1,430 lines as priced — **one implementer job**, after or beside `SemiHub`'s (it reads that module's statements only).

### 9.4 `outerAdj` (`Plane/RingCalculus/Empty`) — the plan

The entry's argument (`plans/FS129-SR3-audit.md` § 3.1) speaks of sectors ("the sector of O … ends at 30°", "the tile whose sector
follows it"); the route below is its region-level form, the mirror of `not_sole_tip_of_adjacent_changePoints` (same module shape, the
two arcs run outward to the apex `p′ = y + y′ − p` instead of inward to `p`). Put `c` for the shared outer colour, `X` (`X′`) for the
ring's colour just counter-clockwise (clockwise) of `y`; at `y′` they are swapped (`not_germIn_closure_rotate`, as `SoleTip` l. 183).

- **A0** the two tiles: `O`, the `c`-tile at `y`, and `O′`, the `c`-tile at `y′`, differ and are far apart. `ringGerm_outward` at `y`
  (its outer pair: the germ just clockwise of `y′` is in a colour class, so on no (Q) arc; `hv`) puts `ψ` in the cone of an outer
  tile at `y`, of colour `c`, so `O`; `exists_not_mem_closedBall_of_coneAt` gives `O` a point outside `B̄(y′, 1)`, and `O′ ⊆ B(y′, 1)`.
  Then `unitNear_or_unitFar` and non-Siamese.
- **A1** *beside a sole outer colour*: near `y`, every interior point outside `B̄(p, 1)` and outside `B̄(y′, 1)` has colour `c`, so lies
  in `O`. Its colour is not `X` (near `y` the class of `X` stays in `B̄(y′, 1)`: `Valid.dist_le_one_of_near_germ` from the germ just
  clockwise of `y′`), not `X′` (near `y` the class of `X′` stays in `B̄(v, 1)`, `v = r(ψ − 60°)`: the same lemma **in closure form**, from
  `qcol_ccw` at `v` — this is where `hv` is read — and the points in question are outside `B̄(v, 1)`); a colour of `p` there is on a
  tile with `y` in its closure (`exists_ball_tileAt`) that is no tile of `p`: an outer tile, so `O`.
- **A2** so the arc of `ω(y′)` leaving `y` away from `p` lies in `closure O` (`mem_closure_diff_closedBall`); the mirror at `y′` (with
  `hu`, through `qcol_cw` at `r(ψ + 120°)` for the change point `y′`) puts the arc of `ω(y)` leaving `y′` away from `p` in `closure O′`.
- **A3** `twoCirc_cmp_one` at the mirror apex: the two arcs have points nearer than `1`; `NonSiamese.tile_eq_of_dist_lt`: `O = O′`,
  against A0.

Children: `Valid.dist_le_one_of_near_germ_closure` (the implementer's lemma with `GermIn … (closure (F.region c))`: its proof already
passes through `germ_Icc_subset_closure`), `exists_ball_subset_closure_of_sole_outer` (A1), the two ring identities at the mirror apex.
What is hard: nothing new — `SoleTip` is the template, 330 lines; **about 380 lines**, to ride with `SemiHubPlaces`' job or the next
free one. The statement reads `ArcMap 6`; the argument reads `k ≤ ncard + 2`.

### 9.5 Prices

| unit | lines as priced | implementer jobs |
|---|---|---|
| `SemiHub` (17 leaves) | 1,700 | 1 |
| `SemiHubPlaces` (6 leaves) with `outerAdj` | 1,430 + 380 | 1, or 2 if `semiHub_places` runs to its price |
| FS116-RING-TWIST-C, FS116-N2-SIXRING (not stated) | a third planning pass, then about 1 job for TWIST-C; SIXRING's covering step unpriced | — |

**Re-priced from this pass's first leaves**: `qcol_cw`, `qcol_ccw` (10 lines each over wave 3, first elaboration), `germPair_swap`,
`transferQC`, the four `germOnQ_bar_*` and `closure_inter_subset_sphere` closed as written; a leaf that is a composition over landed
lemmas costs minutes, as the first pass found. The lines above are for leaves that are not.

### 9.6 Inhabitants and vacuity

| declaration | status of its hypotheses |
|---|---|
| `qcol_cw`, `qcol_ccw`, `ringTile_*` | a change point of a four-colour vertex with two absent: held by hand (the bowtie's centre, the strip's `P₀`), **no Lean term** — wave 7's bowtie is the owed inhabitant, as for `Star`'s rows |
| `qcol_inner_tile`, `ringArc_dist_le_one`, `germOnQ_bar_*`, `germPair_inner_ne`, `germPair_swap`, `germPair_dicho`, `exists_isStar4`, `ringArc_star`, `fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `crossed_no_tip`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub` | met by held fragments (the strip's `P₀` at `P₂`: crossed; the bowtie's centre at `top`: parallel — `data/fs116/n3/semi.out`), **no Lean term**; each docstring names its model |
| `fullSemiHub_star_parallel_T` | no held model (no held semi-hub of kind T); satisfiability open (FS-124) |
| `semiHub_places`, `transferQC` | hypotheses met by the strip and the bowtie, which land in the first alternative; the second and third alternatives have no held model, and whether the third occurs is SEMI-PAR3's open question — said in the docstring |
| `closure_inter_subset_sphere`, `IsTile.not_mem_closure_of_not_subset_ball`, `GermOnQWith.exists_isRingArc_*`, `IsRingArc.germIn_closure`, `isRingArc_of_edge`, `four_le_of_bothKind` | class-free or read one arc: `quadRing` (`Plane/LocalMapExamples`, not valid) carries a ring arc and a germ on it; a named `example` each is owed before the gate |
| the definitions | spec examples in `SemiHub` (two per word, one an adversary); **a Lean star is owed** — `quadRing` at `0` with its four quadrant tiles is the candidate, about 150 lines |
| `outerAdj`, `not_sole_tip_of_adjacent_changePoints` | two change points `60°` apart: held by no fragment; satisfiability open (FS-124), as the docstrings say |

No `VACUITY DECLARED` marker is added: no class of this pass is proved empty.

### 9.7 FS116-RING-TWIST-C and FS116-N2-SIXRING — not stated; what a third pass starts from

**RING-TWIST-C** (argument read: `plans/FS116-N1-proof.md` § 2.2, L1–L5). Its first clause is landed (`ringD`,
`finite_ringD_off_ringArc`, `Plane/RingGerm`). L1 is landed too: `IsRingArc.not_mem_closure_third`. The design, so that it and wave 7's
`ring_odd` are one theorem and a corollary at the join:
- `twistC_four`: `F : ArcMap 6`, valid, `Covers p 1`, `4 ≤ ncard`, and `∀ θ ∈ Ico θ₀ (θ₀ + 2π/3), ringPt p θ ∉ F.ringD p` give
  `(coloursAt p).ncard = 4` (L2).
- the colour off a finite set, its swap under `θ ↦ θ + π/3`, and "every arc of `Γ` on `ω(p)` meeting the double window in an arc has
  one colour on both sides" (`IsRingArc p θ₁ θ₂ c c′` with `Ioo θ₁ θ₂` meeting the window gives `c = c′`).
- a new word, *colour change* (the single colour differs on the two sides: `coloursAt` is `{X}` on a germ counter-clockwise and
  `{X′}` clockwise, `X ≠ X′`), and `Odd {θ ∈ Ico θ₀ (θ₀ + π/3) | colour change}.ncard` (L4), each with `coloursAt = (coloursAt p)ᶜ`.
- change points are colour changes; a colour change that is no change point lies on a seam (L5).
- **the last clause in `ring_odd`'s own shape**: `(hfree : ∀ θ ∈ Ico θ₀ (θ₀ + π / 3), ¬ F.OnRingArc p (ringPt p θ)) → Odd {θ ∈ Ico θ₀
  (θ₀ + π / 3) | ∃ X X′, F.IsChangePoint p θ X X′}.ncard`. At the join it is `ring_odd hF hp (twistC_four …) hfree`: `ring_odd` reads
  four colours where TWIST-C derives them, and reads no D-freeness, so `ring_odd` is the theorem and TWIST-C's last clause its
  corollary; the colour-change clauses are TWIST-C's own content (they allow seams, which `ring_odd` does not).
- its entry says no held fragment has a qualifying window: satisfiability-open, to be said in each docstring with the strip's `P₀`
  (a D-free arc of `60°`, short of the `120°` the window asks) as the object meeting the hypotheses but one.

**SIXRING**: the first pass's disposition stands (Stage 2's row); this pass adds only that `ringArc_dist_le_one` (here) gives "each
arc is at most `60°`" for its covering step, and that its clause "cone at p in `[α + 60°i − 30°, α + 60°i + 90°]`" is
`ringArc_cone_inner` on the tile's arc.

### 9.8 The handoff

- **Statements are fixed**; a change an implementer needs comes back through the coordinator. Docstrings may be corrected.
- **By file**: *I8B* on `Plane/RingCalculus/SemiHub` (17 leaves; mint C1, C2, G1, K1, K2 first, in a helper module of its own if it
  wants them shared — `SemiHubPlaces`' implementer needs C1, K1, K2 too, so K1 and K2 go in a module both can import, e.g.
  `Plane/RingCalculus/StarChart`, written by whichever job starts first and taken by the other by merge); *I8C* on
  `Plane/RingCalculus/SemiHubPlaces` (6 leaves) and `outerAdj` in `Empty` (after the first implementer has handed `Empty` back).
- **Order inside a file**: `SemiHub` — `qcol_inner_tile`, the sub-arc lemmas, `germPair_inner_ne`, `qcol_not_one_arc`, the four
  `ringTile_*`, then `exists_isStar4`, `ringArc_star`, the three stars, `germPair_dicho`, then `isRingArc_of_edge`,
  `four_le_of_bothKind`. `SemiHubPlaces` — `crossed_no_tip`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `semiHub_places`,
  `crossed_semiHub` last.
- **`star_anti`** gains two binders on the first implementer's branch (ruling, item 568); nothing here reads it.
- **Counting `sorry`**: `rg -c "^\s*sorry" Proofs/HadwigerNelson/Plane/RingCalculus/` — `SemiHub.lean` 17,
  `SemiHubPlaces.lean` 6, `Empty.lean` 1, `Star.lean` 2.
- **At the join with wave 7**: `qcol_inner_tile` and `qArc_inner`'s first clause are one lemma; `four_le_of_bothKind` and
  `IsTacticAt.four_le_centre` share `not_hasRepeatedColour_of_simpleOn`; FS116-RING-TWIST-C's last clause is `ring_odd`'s corollary
  (§ 9.7). No hypothesis is discharged there.

## Stage 10 — SAVED: the build, the registered expectations scored, slips

### 10.1 The build and the doubled-name check

`./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`), three times: as given (Stage 7's first lines); the
single-module draft, `data/fs131/k8b/logs/build-2-semihub.log` — "build: OK — 468 of 468 batches, 2 module(s) rebuilt, 3 module(s) with
warnings", `EXIT=0`; and the two modules as committed, `data/fs131/k8b/logs/build-3-split.log` — "build: OK — 468 of 468 batches, 3
module(s) rebuilt, 4 module(s) with warnings", `EXIT=0`. Its full log (`build/gate/build/20261006T201048Z-2910962.log`, "Build
completed successfully (5818 jobs)") holds 78 warning lines, every one `declaration uses sorry`, in four files: `Star` (2 leaves),
`Empty` (1), `SemiHub` (17), `SemiHubPlaces` (6). `rg -c "^\s*sorry"` agrees: 2, 1, 17, 6.

The leaves' signatures and axioms from the built modules (`data/fs131/k8b/logs/semihub-signatures.log`): 27 `#check @…` lines; the
declarations proved outright print `[propext, Classical.choice, Quot.sound]`, and the two proved from leaves that were printed
(`ringArc_dist_le_one`, `transferQC`) print `sorryAx` as well — the print sees a `sorry` beneath a proof term.

`./scripts/dupnames.sh` on the built tree (`data/fs131/k8b/logs/dupnames.log`): "dupnames: OK — no name is declared by two modules (23
generated on demand, listed above)", `EXIT=0`. `tools/check_architecture.py`: `RESULT: PASS`.

Not run, by the brief: the gate (`axioms.sh`, `vacuity.sh`, the linters). `scripts/Axioms.lean`'s block "FS131-K8b" lists eighteen
declarations with no `sorry` beneath them; the build elaborates that file's imports only through `Proofs.lean`, so the block's first
real reading is the wave's gate.

### 10.2 The registered expectations (§ 6.4), scored

- **A statement defect hidden in a row**: none found in the nine rows stated. By row: STAR2 (0.35) — none; "at least four colours" is
  exactly four in the row's setting, as the 0.6 side said. CROSS (0.5) — none; its last clause is the weakest-graded of the pass (one
  mind and a checking reading) and its first clause is vacuous, both already on file. SEMI (0.4) — a wording ambiguity only ("cone" is
  the cone at `p`; "interior" stated in the stronger form). CONE (0.4) — none: "an edge" is a curve the landed vocabulary names. QCOL
  (0.25) — none; its clause "ends at `u`" is not stated as such (no consumer). DICHO, PAIR (0.15) — none; both wider than filed, and
  DICHO's outer-pair cases, unrecorded in its verification, worked here. `outerAdj` (0.3) — stands. TWIST-C (0.5), SIXRING (0.2) — not
  tested. **Not predicted**: that the defect of this pass would be in the first pass's *skeleton* (`star_anti`'s `interior`), and of
  the kind I gave 0.3; and that the three "named-hypothesis implications" need no hypothesis.
- **One theorem**: OUT2 is `star_outer_cone` — met. PAIR is DICHO's bracket — met in substance (both rest on `germPair_inner_ne`), but
  PAIR reads less (no *simple*, no four colours), so it is its own statement. RING-TRANSFER-QC adds nothing — met (a weakening of SEMI,
  stated; the rest cited). "CONE's first four clauses are wave 3's `germR_*` in tile form" — **not met**: they are RING-GERM's Steps
  1–2 (the carried colour and the non-Siamese engine); it is clause (b) that is `germR_*`. TWIST-C and `ring_odd` — designed (§ 9.7),
  not stated.
- **Rows stated**: nine of eleven against a registered median of eight; the two not stated are the two named as likeliest.
- **The `star_anti` gap**: registered 0.5 a missing lemma, 0.3 a hypothesis, 0.2 a deriver's question; it is a hypothesis — of the
  skeleton, the row carrying it in its *not claimed* line.

### 10.3 Slips, the job's

- Two rows of eleven not stated (FS116-N2-SIXRING, FS116-RING-TWIST-C); SIXRING's argument not re-read.
- No Lean model of a star, of a semi-hub or of a (Q) arc's tiles: the definitions' examples are generic (§ 9.6 says what is owed).
- Stage 9's plans are one mind and unelaborated: C1's hypotheses, K1 and K2 are stated in prose, not in Lean; the wave-4 lemmas named
  for K2 were found by name, not read.
- Stages 7–10 are one commit: the Lean had to build first, and the wait for a slot was spent writing the record.
- The module was first written as one file and split in two after the handoff was priced; the single-file build
  (`build-2-semihub.log`) is kept beside the final one.
- I cannot read the harness's token count; the hand-back is at this saved stage on my own estimate of the budget's line.
