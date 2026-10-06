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

*Filled at each saved stage; see the last stage's list.*

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
