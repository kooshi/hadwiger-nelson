# FS-131 wave 3 — the kernel plan: arc maps and fragments, Siamese allowed (de Bruijn, the planner, FS131-K3; continued by FS131-K3b)

*Brief: `data/fs131/briefs/FS131-K3-wave3.md`. Branch `fs131-w3`, worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3`, built
on wave 1's frozen skeleton (`3358a401`). The opening plan is `plans/FS131-kernel-plan.md` (§§ 4–7); this record follows its § 6 form. Nothing in
this milestone is blind (inventory ruling 1).*

## Theorems this phase proved

None: a planning job. The foundation's spec examples and inhabitants (stage 2) are proved, but they are checks of definitions, not theorems of
the backlog. FS131-K3b (stages 3 on) likewise proves no backlog theorem: the skeleton's two proved items (`sixFrag_covers`, the spec example
`sixCol (1/2) = 0`) are checks of a definition.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in" | `plans/FS131-kernel-plan.md` § 7.3, item 3 | **verbatim**, cut mid-sentence: the source goes on "its record against the row." Nothing changed by the cut |
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors (Kooshi, 2026-09-26) | **verbatim**; the source continues "Your predecessor formalized …" |

The brief's row list checked against `data/fs131/k1/dispositions.csv`: the CSV has 21 rows with wave 3 and disposition *formalize*;
less FS116-O1-YESLIM (inventory ruling 6, moved to wave 2) these are exactly the brief's 20. Merged into them (CSV `merged_into`): FS116-N1-TOUCH →
FS129-SR2-TOUCHW; FS116-RING-Q-PRIME → FS116-RING-Q-PRIME-S; FS110-N2-RING, FS110-Y3-GP → FS129-SR1-RINGBAND (the brief's four); and two the
brief does not name, both carried here: **FS112-SIX → FS116-N2-FIVERING and FS129-SR1-SIXQ** (SR1 item 3; FS112-SIX's erratum of 2026-10-03 makes
its two clauses those two rows), and **FS116-RING-TRANSFER-C → FS116-N2-FIVERING and FS116-N2-SIXRING** (ruling R7: its five-colour clause is
FIVERING's content; its six-colour clause is SIXRING's, wave 8). FS129-SR2-YESLIM-EQ goes with FS116-O1-YESLIM to wave 2.

### 1.2 The rows, quoted

Every statement, not-claimed line, uses-only line and merge note is quoted verbatim by `tools/fs131_k3_rows.py` into
`data/fs131/k3/rows.md` (26 sections: the 20 rows and the six merged ones), from `plans/LEAN-BACKLOG.md`, which quotes the derivation files by
script. `python3 tools/fs131_k3_rows.py --check` re-reads the file against the backlog (OK); `--plant` alters one interval in a copy of the backlog
and the check fires (FIRED). Stage 3's read-backs set each formal statement beside its quotation.

| row | derivation address | its object | caution / merge carried |
|---|---|---|---|
| FS116-V5-NE1 | `plans/FS116-derivation.md:1258` | tiles, any `k` | first clause as FS129-SR2-CLOSURE's corollary (SR2 item 9); "in particular" by FS106-DIAM (i) |
| FS116-V4-DICHOTOMY | `:972` | tiles, any `k` | first clause as FS111-M-HULL2's case (SR2 item 10); "A ~ A" by FS106-DIAM (i) (SR2 item 9) |
| FS116-V4-MEET | `:988` | tiles | — |
| FS116-S1-CLUSTER | `:838` | a finite family of tiles | — |
| FS129-OR1-WHOLE | `plans/FS129-derivation.md:577` | the whole-tile restriction `F_ρ` | — |
| FS116-V4-TWIST | `:1003` | the ring, any `k` | — |
| FS116-N1-TWIST-D | `:108` | the ring, any `k` | in place of RING-TWIST-C's first clause and V5-RING's first two (SR2 item 21) |
| FS116-N1-GERM-R | `:414` | a ring point, any `k` | — |
| FS116-N1-GERM-S | `:452` | a change point, six colours | — |
| FS116-RING-Q-PRIME-S | `:475` | a change point | carries FS116-RING-Q-PRIME (SR2 item 21) |
| FS116-N1-QFREE4 | `:490` | a (Q)-free ring | — |
| FS116-N2-FIVERING | `:655` | a five-colour vertex | carries FS112-SIX's five-colour clause, RING-TRANSFER-C's five-colour clause |
| FS129-SR1-SIXQ | `plans/FS129-derivation.md:913` | a vertex carrying all `k` colours | carries FS112-SIX's six-colour clause |
| FS129-SR2-TOUCHW | `plans/FS129-derivation.md:1120` | a touch point | carries FS116-N1-TOUCH (its idle hypothesis dropped) |
| FS116-N1-ECHO | `:528` | a touch point, saturated | filed in reading (B) |
| FS116-V5-U1 | `:1538` | an arc of `Γ` on `ω(z)` | first three clauses in place of FS112-U1's (SR1 item 4); four-colour clause a corollary |
| FS116-Y4-FLANK | `:1686` | one tile at two ring points | TWOCIRC in place of its identity step (SR1 item 1) |
| FS116-S1-EXIT | `:906` | a curve in a lens | — |
| FS116-Y2-SIXFRAG | `:365` | one explicit fragment | the milestone's six-colour inhabitant (opening plan § 7.3 item 5) |
| FS129-SR1-RINGBAND | `plans/FS129-derivation.md:933` | a ℤ/3 circle colouring | caution C137 (RINGWIND's periodicity clauses); carries FS110-N2-RING, FS110-Y3-GP |

### 1.3 The worktree builds as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, at
`3358a401`: **OK — 440 of 440 batches, 8 modules rebuilt, 7 modules with warnings** (wave 1's skeleton: the `declaration uses 'sorry'` warnings),
8 m 13 s, exit 0 (`build/gate/build/20261004T052558Z-1264653.log` in the worktree; the driver's own log `data/fs131/k3/build-stage1.log`).

### 1.4 Registered before the definitions (scored at stage 3)

1. The likeliest defect is not in a row but in the vocabulary: "arc of `Γ` on `ω(p)`", its "side colours", "a germ lies on a (Q) arc" and
   "change point" were never given a point-set meaning, only the map-edge meaning of FS-112's header (an edge between two tiles). Expect at least
   one row whose truth depends on which reading is taken (probability 0.5).
2. Expect most covering hypotheses ("on a closed disc of radius above 1 about p") to be idle in the rows that rest on N-E1 alone (GERM-R, TWIST,
   ECHO), and the rows to hold at any `k` where the derivation spends no colour count (probability 0.8).
3. Expect wave 3 to need part of the local structure of a map at a point — finitely many tiles near a point, every direction in some tile's cone —
   which § 7.1 of the opening plan places in wave 4's foundation (probability 0.7).
4. Expect no row to need wave 2's measurable vocabulary beyond what the foundation already holds (`upperDensityAt`, `essSupport`); ECHO is the
   only row that reads density (probability 0.9).

## Stage 2 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

### 2.1 The model, and why this shape

Three new modules under `Proofs/HadwigerNelson/Plane/`, sorry-free, on `fs131-w3`:

| module | holds |
|---|---|
| `Plane/LocalMap` | `Arc.isClosed_carrier`; **`isOpen_interiorPts`** (§ 7.1's item), `isOpen_region`; tiles open, connected, non-empty and monochromatic (`IsTile.col_eq`), `TileOf c T`; `UnitNear`/`UnitFar` (the rows' `~`, `⊥`); `coneAt S y` (limit directions); `Side`, `germ`, `GermIn`; `ringArc`, `OnRingArc`, `innerColours`/`outerColours`, **`IsRingArc p θ₁ θ₂ c c'`** (an arc of `Γ` on `ω(p)` with constant sides, inner colour `c`, outer `c'`), **`IsQArc`**, `GermOnQ`, `OnQArc`; **`IsChangePoint p ψ X X'`**, **`IsHub`**; `essColours` (`P(w)`), `IsEssBoundary`, `SaturatedAt`; `restrict`, `wholeDom`, **`wholeRestrict`** (`F_ρ`); `Arc.InitialPiece` |
| `Plane/LocalMapExamples` | spec examples and inhabitants (§ 2.3) |
| `Plane/CircleColouring` | RINGBAND's vocabulary: `CircleColouring`, `Lift`, `Good`, `step`, `hSum`, `h`, `LeftVal`/`RightVal`, `IsSwap`, `Lift.W`, `Lift.D`, `Lift.m`, `Lift.n₂`; inhabitants `hexColouring`, `nineColouring` with their lifts |

**The one decision every row inherits: "a tile of colour `c`" read as the colour class `F.region c`** wherever a row speaks of the closure,
the cone or a germ "of a tile of colour `c`". This is the reading the foundation already made for `P_cl` (`coloursAt`: the colours whose
region has `x` in its closure), so it is a consistency, not a new choice. It is the intrinsic object: N-E1, the engine of every ring row, is a
statement about one colour class with no unit pairs (an interior point of the class is never at distance exactly 1 from a closure point of the
class — CLOSURE's corollary), and tiles enter only where a row distinguishes tiles of one colour (DICHOTOMY, MEET, CLUSTER, WHOLE, FLANK, "a
tile of `p`", Siamese). The two readings coincide because finitely many tiles meet a small disc about any point of the domain
(`finite_tiles_near`, a skeleton leaf of stage 3). Effect on the formal statements: a *hypothesis* in the class form is weaker than the tile
form (the theorem is stronger); a *conclusion* in the class form is equivalent to the tile form through that lemma.

**Points of the ring, point-set.** "An arc of `Γ` on `ω(p)`" was never given a point-set meaning: FS112's header defines (Q) and (R2) for
*edges of the map* (one tile on each side). `IsRingArc` says: the closed sub-arc `r([θ₁, θ₂])`, of positive length, lies in `Γ`, and at every
interior point the inner side carries exactly the colour `c` and the outer side exactly `c'` (`innerColours`, `outerColours`: the colours whose
class has the point in the closure of its part inside `B(p, 1)`, resp. outside `B̄(p, 1)`). "(Q)" is then the header's own words: both side
colours carried at `p`, which carries at least four.

### 2.2 The definitions the derivations never fixed: the choice, the alternatives, the rows each would change

| term | chosen | alternatives | rows whose statement would change |
|---|---|---|---|
| closure / cone / germ "of a tile of colour `c`" | the colour class (`region c`) | (a) one tile literally | none in truth: equivalent through `finite_tiles_near`; under (a) every N-E1 step must first pick the tile, and TWIST-D's `D` is closed only after the lemma |
| arc of `Γ` on `ω(p)`, its side colours | `IsRingArc`: colour-constant sides, point-set | (a) the map-edge reading — a maximal edge between two tiles; (b) the presentation reading — an element `circ p 1 θ₀ θ₁` of `F.arcs` | none under (a): "(Q)", "a germ lies on a (Q) arc", "the (Q) arcs have total length ≥ 180°", "every arc of `Γ` on `ω(p)` is (Q)" depend only on colours and agree; (b) is incidental — one map has many presentations (an arc may be split, or overlap another), so (b) would make FIVERING's length clause presentation-dependent — rejected |
| change point | reading L (`data/fs116/claims.md` § 13): `r(ψ) ∈ Γ`, the ring off `Γ` on both sides, colours `X` (ccw) `≠ X'` (cw) | the frozen § 0 reading without "off `Γ` on both sides" | under the alternative a point where a ring arc ends and the ring leaves `Γ` would be a change point; § 10's statements were checked under L, and the close's notes say so. Where `Γ` crosses `ω(p)` transversally (the opening plan's § 7.3 item 2), both germs are off `Γ` for small length, so the definition applies with no case split; a tangential touch with one tile on both sides is no change point |
| approaches `y` along `β` / the cone of a tile | limit directions (`plans/FS116-N1-proof.md` § 4.1, verbatim definition) — closed, `2π`-periodic | directions of rays `y + s e(β)` inside the set for small `s` | under the ray reading a cusp has an empty cone, against § 13's "possibly a single direction, a cusp" |
| a germ lies in / on a set | `GermIn`: some open arc of positive length on that side lies in it | — | — |
| essential multicolour, saturation at `w` | over `region j` (`Γ` is null, so this is D-NF's `S_j`) | wave 2's colouring-level form | none; wave 2 defines the colouring-level form, and an `ArcMap`'s colouring restricted to its domain agrees off the null `Γ` |
| `F_ρ` | `restrict` to `V ∩ int ⋃ {cl T : T meets B(p, ρ)}`, closures in `ℂ` (the row's not-claimed line reads simplicity "in the plane") | closures relative to `U_ρ` | the row excludes it |
| "t's edge leaving `y` in direction `δ`" (FLANK) | `Arc.InitialPiece α y δ B`: `B` an initial piece of an arc `α` of the map | sector branches (wave 4) | none |
| RINGBAND's lift "changing by `+1` or `−1` at each change point" | `|jump| ≤ 1` with `f ≡ c (mod 3)` | literal `±1` | none: where `c` changes the jump is `≡ ±1`, so `±1`; where it does not, `0` |

None of these choices changes what a row says, so no message was owed under the brief's § What is yours to decide.

### 2.3 Validation (the seams)

Every definition has a spec example that fails if it drifts, and the adversaries fail if a definition becomes trivially true:

- `coneAt`: `π ∈ coneAt (B(0, 1)) 1`; **adversary** `0 ∉ coneAt (B(0, 1)) 1`. `germ`: the germ just counter-clockwise of `r(0)` lies in the upper
  half-plane. `UnitNear` (a disc of radius `1/3` with itself), `UnitFar` (two such discs `3` apart).
- **`halfPlane2 : ArcMap 2`** (`B(0, 2)` cut along the real axis): `halfPlane2_isChangePoint` (`r(0)` a change point, colour `1` ccw and `0` cw);
  `IsHub 0 0`; `halfPlane2_not_isRingArc` and **adversary** `¬ OnRingArc 0 x`; **adversary** `r(π/2)` is no change point.
- **`quadRing : ArcMap 4`** (both axes and the unit circle; quadrant colours inside, opposite outside): `quadRing_coloursAt_zero` (four colours at
  `0`), `quadRing_isRingArc` (`IsRingArc 0 0 (π/2) 0 2`: inner colour `0`, outer `2` — checks `innerColours`, `outerColours` and `Γ` together),
  `quadRing_isQArc`, `GermOnQ 0 (π/4) .ccw`, `OnRingArc`, `OnQArc` at a closed end; **adversary**: no ring point is a change point.
- `essColours`, `IsEssBoundary`, `SaturatedAt` on the one-colour map of the plane (`P(w) = {0}`, not an essential boundary point, saturated);
  `upperDensityAt_empty`, `upperDensityAt_univ`. `TileOf` and `wholeDom` on the one-colour disc `B(0, 2)` (`wholeDom 0 1 = B(0, 2)`).
  `Arc.InitialPiece`: `[0, 1]` of `[0, 2]`, a quarter of the upper half circle; **adversary** `[0, −1]` is no initial piece of `[0, 2]`.
- **`CircleColouring`**: `hexColouring` (six `60°` arcs `0, 1, 2, 0, 1, 2`): `W(π/6) = 2`, `h(π/6) = 2`, `Good (π/6)`; `nineColouring` (nine `40°` arcs):
  `W(π/45) = 3`, `h(π/45) = 0` — RINGBAND's two models, the second the `h = 0`, `W = 6M + 3` case (v) predicts.

Inhabitants of the structures a theorem will take: `ArcMap` (`const`, `halfDisc`, `halfPlane2`, `quadRing`; a *valid* map of a class with a
vertex of at least four colours is not built here — FS116-Y2-SIXFRAG, a stage-3 row, is the six-colour one; the four-colour ones are
FS114-Y2-BOWTIE, wave 7, and FS114-Y-DIAL's strip), `CircleColouring` and `Lift` (`arcsColouring`, `arcsLift`).

### 2.4 The gate on this commit

- `./scripts/build.sh` in the worktree under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): **OK — 440 of 440 batches, 4 modules
  rebuilt** (the three new ones and `Proofs`), **7 modules with warnings — exactly wave 1's seven skeleton modules** (their `sorry` warnings);
  the three new modules build with no warning, 8 m 8 s, exit 0 (`build/gate/build/20261004T055346Z-1444180.log` in the worktree; driver log
  `data/fs131/k3/build-stage2.log`).
- `./scripts/axioms.sh` (under the slot): FAIL as expected on the branch — the **28** `sorryAx` records are wave 1's skeleton, none ours; the
  **45** new records (`scripts/Axioms.lean`, section "FS-131 wave 3 (job FS131-K3)") all read `[propext, Classical.choice, Quot.sound]`, checked
  by script against the log (`build/gate/axioms/20261004T060225Z-1503931.log`; `data/fs131/k3/axioms-stage2.log`). Purchases unchanged (5).
- `tools/check_architecture.py`: **PASS**, exit 0 — 192 module rows, 0 import mismatches (three new rows in § 3.11).
- `lake env lean` was used only for iteration; the evidence is the build above.

## For stage 3 — the skeleton as designed, not yet written (drafts; the next session writes and builds them)

*This job reached its budget line after stage 2. What follows is the design the skeleton is to be written from, so that stage 3 is
transcription and checking, not re-derivation. Nothing here is built; every formal shape below is to be elaborated, read back against
`data/fs131/k3/rows.md`, and corrected where the kernel disagrees.*

**Modules** (all import `Plane/LocalMap`): `Plane/LocalStructure` (the supporting lemmas below), `Plane/Tiles` (NE1, DICHOTOMY, MEET, CLUSTER,
WHOLE; imports wave 1's `Plane/Diameter`, `Plane/DensityPoints`), `Plane/RingGerm` (TWIST, TWIST-D, GERM-R, GERM-S, Q-PRIME-S, QFREE4,
FIVERING, SIXQ, TOUCHW, ECHO, U1, FLANK; imports `Plane/Tiles`, `Plane/Chord`), `Plane/Lens` (EXIT; `Plane/Basic` only), `Plane/SixFragment`
(SIXFRAG), `Plane/RingBand` (RINGBAND with N2-RING, Y3-GP; imports `Plane/CircleColouring`, `Plane/RingGerm` for the map bridge).

**Supporting lemmas (`Plane/LocalStructure`, sorry leaves) — wave 3 needs part of the local structure § 7.1 placed in wave 4** (registered
expectation 3, confirmed):
- `Arc.finite_inter_sphere_or_onRing`: a nondegenerate arc meets `ω(p)` in at most two points unless it is `circ p 1 θ₀ θ₁` (line–circle and
  circle–circle intersections are quadratics) — M.
- `finite_ringΓ_off_arcs`: `(F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x}` is finite when `closedBall p 1 ⊆ F.dom` (compactness + local
  finiteness + the previous lemma) — M.
- `dense_interiorPts`: `F.dom ⊆ closure F.interiorPts` (`Γ` nowhere dense) — E–M; so `x ∈ dom → ∃ c, c ∈ F.coloursAt x`.
- `ne1_region` (N-E1, class form): `F.Valid → x ∈ closure (F.region c) → z ∈ F.region c → dist z x ≠ 1` — E, from `isOpen_region`, the
  class having no unit pairs (`unitPairSet` empty by validity) and wave 1's `dist_ne_one_of_mem_of_mem_closure`.
- `germ_dichotomy`: for `ringPt p θ ∈ F.dom`, some germ is inside one tile, or inside `Γ` on an `IsRingArc` with constant sides whose side tiles
  have the germ in their closure — M–H (curvilinear strip beside the open germ avoids the finitely many other arcs).
- `finite_tiles_near`: `x ∈ F.dom → ∃ r > 0, {T | F.IsTile T ∧ (T ∩ ball x r).Nonempty}.Finite` — **H, the wave's hardest leaf**: near `x`
  only arcs through `x` remain; each is ≤ 2 branches monotone in `|z − x|`; distinct branches are disjoint off `x` for small `r` and keep their
  cyclic order; the complement is ≤ #branches curvilinear sectors, each connected. Consequences: `mem_coloursAt_iff_tile`,
  `coneAt_region_eq_iUnion`, `exists_mem_coneAt_region` (every direction lies in some colour's cone — E by pigeonhole without it).
- `Simple.coneAt_isInterval`: in a simple map, each tile's cone at a point of its closure is one closed interval — H (sectors + a Jordan curve has
  exactly two branches at each of its points); used only by V5-U1's last clause.
Report this to Keryx as a plan finding (it is in the report).

**The rows' formal shapes** (`k` general unless the derivation spends a colour count; `Covers p 1` stands for "a closed disc of radius above 1
about `p`", equivalent by compactness since `dom` is open):
- **V5-NE1** (`Tiles`): (1) `ne1_region` as the row's first clause (class form: stronger); (2) `F.IsTile T → x ∈ closure T → T ⊆ ball x 1`;
  (3) `closure T ⊆ closedBall x 1`; (4) pointwise diameter `∀ a b ∈ T, dist a b < 1` (via wave 1's `dist_lt_one_of_forall_dist_ne_one`).
- **V4-DICHOTOMY**: `F.TileOf c A → F.TileOf c B → UnitNear A B ∨ UnitFar A B` (proof: wave 1's `hull2` at `region c`, per SR2 item 10);
  `UnitNear A A`; closure points `< 1` ⟹ near, `> 1` ⟹ far; `F.NonSiamese → UnitNear A B → A = B`.
- **V4-MEET**: tiles of one colour with a common closure point: `UnitNear T A ↔ UnitNear T B` for every tile `T` of that colour.
- **S1-CLUSTER**: `𝒯 : Finset (Set ℂ)` of tiles of colour `c`, `IsPreconnected (⋃ T ∈ 𝒯, closure T)`, `U` a tile of colour `c`, a pair at distance
  `< 1` ⟹ all pairs `≤ 1`.
- **OR1-WHOLE**: for `F.Covers p r`, `1 < ρ ≤ r`: `(F.wholeRestrict p ρ).Valid`, `Covers p ρ'` for `ρ' < ρ`, `IsTile` of `F_ρ` ↔ a tile of `F`
  meeting `B(p, ρ)` (same sets, so same closures), tiles at `p` the same, `NonSiamese` and `Simple` inherited; and for `ρ ≤ √3`, a tile `T` of
  colour `c` and `θ₁ < θ₂` with `∀ θ ∈ Ioo θ₁ θ₂, ∀ᶠ η in 𝓝[>] 0, p + (1 − η) e θ ∈ T` ("the inner side is one tile"), no tile of `F_ρ` of colour
  `c` has `p + 2 e θ`, `θ ∈ Icc θ₁ θ₂`, in its closure. **Generalization:** the argument never reads that the arc lies in `Γ`. Needs
  `finite_tiles_near` (the covering clause).
- **V4-TWIST** (class form, no covering hypothesis — idle): `¬ (GermIn p θ s (closure (region c)) ∧ GermIn p (θ ± π/3) s (closure (region c)))`;
  and `z ∈ sphere p 1 → z ∈ region c → c ∉ coloursAt p` ("when `p` is a vertex" idle). **Generalizations** (both hypotheses idle).
- **N1-TWIST-D** (any point `p`, `Covers p 1`): with `D = {x ∈ sphere p 1 | ∃ c ∈ coloursAt p, x ∈ closure (region c)}`: `IsClosed D ∧
  (D \ {x | OnRingArc p x}).Finite`. ("vertex" idle.)
- **N1-GERM-R** (`Valid` only — the covering hypothesis is idle; any `k`): for `y = r(ψ)`, four clauses, e.g. `GermIn p (ψ − π/3) .cw (closure
  (region c)) → ∀ β ∈ Ioo (ψ + 5π/6) (ψ + 11π/6), β ∉ coneAt (region c) (ringPt p ψ)`; `v⁺`: `(ψ − π/6, ψ + 5π/6)`; `u⁻`: `(ψ − 5π/6, ψ + π/6)`;
  `u⁺`: `(ψ + π/6, ψ + 7π/6)`. Check the four intervals numerically before writing (the derivation's GERM-R argument gives them).
- **N1-GERM-S** (**generalized to any `k` with `k ≤ ncard (coloursAt p) + 2` and `4 ≤ ncard (coloursAt p)`** — the argument reads "exactly two
  colours absent", not six; at `k = 6` it is the row): `IsChangePoint p ψ X X'` ⟹ `ncard (coloursAt p) + 2 = k`, `X, X' ∉ coloursAt p`; (i) if
  `¬ GermOnQ p (ψ − π/3) .cw ∧ ¬ GermOnQ p (ψ + π/3) .ccw`: `∀ β ∈ Ioo (ψ + 5π/6) (ψ + 7π/6), ∃ c ∈ coloursAt p, β ∈ coneAt (region c) y ∧ ∀ A,
  TileOf c A → p ∈ closure A → A ⊆ closedBall y 1`; (ii) outer pair `(ψ + π/3) .cw`, `(ψ − π/3) .ccw`: `∀ β ∈ Ioo (ψ − π/6) (ψ + π/6), ∃ c ∈
  coloursAt p, β ∈ coneAt (region c \ closedBall p 1) y ∧ ∀ A, TileOf c A → p ∈ closure A → Disjoint A (ball y 1)` ("a tile, not a tile of
  `p`": the part of the class outside `B̄(p, 1)`, which no tile of `p` meets); (iii) all four: `4 ≤ ncard (coloursAt y)`.
- **RING-Q-PRIME-S**: as GERM-S's hypotheses with `¬ OnQArc p (ringPt p (ψ ± π/3))` ⟹ `4 ≤ ncard (coloursAt (ringPt p ψ))`.
- **N1-QFREE4** (any `k`): `Covers p 1`, `4 ≤ ncard (coloursAt p)`, `∀ θ₁ θ₂, ¬ IsQArc p θ₁ θ₂` ⟹ `ncard (coloursAt p) + 2 ≤ k`.
- **N2-FIVERING** (any `k`, `ncard (coloursAt p) + 1 = k`, `4 ≤ ncard`): no change point; `{θ | ¬ OnQArc p (r θ) ∧ ¬ OnQArc p (r (θ + π/3))} ∩ Ico 0
  (2π)` finite; `ENNReal.ofReal π ≤ arcLength {θ | OnQArc p (r θ)}`; `∀ ψ, ¬ IsHub p ψ`. Carries FS112-SIX's five-colour clause and
  RING-TRANSFER-C's. No inhabitant known (its not-claimed line).
- **SR1-SIXQ** (any `k`): `coloursAt p = univ`, `Covers p 1` ⟹ `sphere p 1 ⊆ Γ`, both side colours of every `IsRingArc` at `p` (trivial), and at
  `k = 6` every ring arc `IsQArc`. Inhabitant: SIXFRAG.
- **SR2-TOUCHW** (any `k` with `ncard + 2 = k`, `4 ≤ ncard`): `w = r(ψ)`, `¬ ∃ X X', IsChangePoint p ψ X X'`, `¬ OnRingArc p w`, no germ at
  `ψ ± π/3` on a (Q) arc ⟹ `∃ X X', X ≠ X' ∧ X, X' ∉ coloursAt p ∧ GermIn p ψ s (region X)` for both sides `∧` each of the four germs `GermIn
  (closure (region X')) ∧ GermIn (closure (region X))ᶜ` `∧ X' ∉ coloursAt w`. Carries N1-TOUCH (idle hypothesis dropped).
- **N1-ECHO** (any `k`, `Valid`; the radius-2 hypothesis idle): `echoOnly`: both germs at `w = r(ψ)` in `region X`, `X ∉ coloursAt p`, `x ∈ closure
  (region X)`, `dist x w = 1` ⟹ `x = 2w − p`; `echo` (the row, reading B): adding `IsEssBoundary w`, `SaturatedAt w`, `X ∈ essColours w` ⟹ `X ∈
  coloursAt (2w − p)`. **Generalization:** only "some point of the support of `X` at distance 1 from `w`" is read.
- **V5-U1** (any `k`): `IsRingArc z θ₁ θ₂ c c'` ⟹ `coneAt (region c) z ⊆ ⋃ m, Icc (θ₂ − π/2 + 2πm) (θ₁ + π/2 + 2πm)`; `c'`'s cone in
  `[θ₂ + π/2, θ₁ + 3π/2]`; neither `c` nor `c'` in the open side cones; each direction of an open side cone lies in the cone of a colour `∉ {c, c'}`;
  four-colour clause at the class it reads (one tile per colour at `z`, interval cones) and the row's non-Siamese simple corollary (via
  `Simple.coneAt_isInterval`, `finite_tiles_near`).
- **Y4-FLANK**: `t` a tile with `y = r(ψ)`, `y' = r(ψ + π/3)` in `closure t`, cone hypotheses ⟹ `coneAt t y ⊆ ⋃ m, Icc (ψ + π/6 + 2πm) (ψ + 7π/6
  + 2πm)` and `ψ + 7π/6 ∈ coneAt t y` (and the mirror at `y'`); and for arcs `α, α' ∈ F.arcs` with `α.InitialPiece y (ψ + 7π/6) B`,
  `α'.InitialPiece y' (ψ + 7π/6) B'`, `B ⊆ closure t`, `B' ⊆ closure t`, and any tiles `a, b` with `B ⊆ closure a`, `B' ⊆ closure b`: `∃ z ∈ closure
  a, ∃ z' ∈ closure b, dist z z' < 1` (stronger than the row: any bordering tiles). The curvature is forced: a segment tangent to `ω(y')` at `y`
  leaves `B̄(y', 1)`, so `α` is an arc of radius `≤ 1`. Check numerically first.
- **S1-EXIT** (`Lens`): **generalized** — only the left derivative at `t_e` and `γ(t) ∈ Λ` just before `t_e` are read (`γ(0) = 0` and `C¹` idle):
  `HasDerivWithinAt γ γ' (Iic t_e) t_e`, `γ' ≠ 0`, `∀ᶠ t in 𝓝[<] t_e, γ t ∈ Λ`, `γ t_e ∈ frontier Λ \ {0}`, the four distance conditions with
  `ν = I * γ' / ‖γ'‖` ⟹ `γ t_e + ν = e b ∨ γ t_e − ν = e a`. Check numerically first (random `a`, `b`, exit points, headings).
- **Y2-SIXFRAG** (`SixFragment`): `sixFrag : ArcMap 6`, `dom = ball 0 (3/2)`; arcs: six radial segments `[0, e(60°j)]`, the unit circle, twelve
  unit arcs (each lens side, centre `e(60°j ± 30°)`, from the ring to `√3 e(60°j)`); colour by `arg` (sector `j` inside; outside: `Q_j` (`j + 2`) if
  within 1 of `e(60°j ± 30°)`, else `G_j` (`j + 4`)), with `locallyConstant` a named sorry leaf. Theorems: `Valid`, `NonSiamese`, `Covers 0 R`
  (`R < 3/2`), `coloursAt 0 = univ`, `sphere 0 1 ⊆ Γ`, every `IsRingArc` at `0` is `IsQArc`. Rotation by `60°` maps colour `j` to `j + 1`: six
  same-colour checks for colour 0 (`S_0`, `Q_4`, `G_2`: three diameters below 1, three cross distances above 1). Run `tools/fs116_y2_six.py frag`
  (existing checker) as the control. **Schedule first** (opening plan § 7.3 item 5): it is SIXQ's inhabitant.
- **SR1-RINGBAND** (`RingBand`): for `C : CircleColouring`, `L : C.Lift`, `θ` with `C.Good θ`: (i) `3 * C.h θ = C.hSum θ = 6 − 2 * L.n₂ θ` and `C.h
  θ ∈ {−2, 0, 2}`; (ii) `L.W θ = Σ_{j<6} L.m j θ + 3 − C.h θ / 2`; `3 ∣ L.f (θ + 2π) − L.f θ` and `L.W` the same at every good `θ`; (iii) no jump of
  `C.h` at `θ₀` unless `θ₀ + jπ/3, θ₀ + (j+1)π/3 ∈ S` for some `j`; (iv) no swap point ⟹ `∃ M, ∀ θ j, C.Good θ → j < 6 → L.m j θ = M`, `L.W ∈ {6M +
  2, 6M + 3, 6M + 4}`, and `L.W = 6M + 3` unless `S` is invariant under `+π/3`; (v) no two points of `S` `π/3` apart ⟹ `C.h = 0` on good `θ`, `L.W =
  6M + 3`; **(vi), carried from FS129-OA1-RINGWIND per caution C137**: `C.h (θ + π/3) = C.h θ` and no jump at a position that is the only one in
  its period with a `60°` pair. Corollaries: FS110-N2-RING (`|L.W| ≤ 1 → ∃ x, C.IsSwap x`), FS110-Y3-GP (no `60°` pair ⟹ `L.W ≡ 3 (mod 6)`, so
  `|L.W| ≤ 2` needs a `60°` pair); `exists_lift`; the map bridge (a three-colour vertex of a valid six-coloured fragment whose ring carries no arc
  of `Γ`, coloured through any `g : Fin 6 → ZMod 3` injective on the absent colours, is a `CircleColouring` with `S = {θ | r θ ∈ Γ}`).

**Inhabitants and vacuity (to write as docstring notes):** six-colour classes — SIXFRAG; four-colour classes (GERM-S, Q-PRIME-S, QFREE4, TOUCHW) —
FS114-Y2-BOWTIE (wave 7) and FS114-Y-DIAL's strip (not in the backlog); five-colour (FIVERING) — none known, not claimed to exist; RINGBAND —
`hexColouring`, `nineColouring`. No wave-3 row quantifies over a class the backlog proves empty.

**Order:** foundation (done) → `LocalStructure` statements → SIXFRAG → Tiles → RingGerm → Lens → RingBand; `ARCHITECTURE.md`, `Proofs.lean`,
`scripts/Axioms.lean` updated in the same commit; build; read-backs in the opening plan's § 6.2 form; per-leaf plans with `#check`ed names
(`debruijn-obligation-modeling` invoked fresh).

## Stage 3 — SAVED: the readback, the merge, the build (FS131-K3b)

*FS131-K3b resumes here (standing rule 2: K3's stages 1 and 2 are SAVED at `f74c3edb` and `e335b208`, its report at `7d89b077`; the section "For
stage 3" above is K3's design, unwritten). Brief: `data/fs131/briefs/FS131-K3b-wave3-skeleton.md`. Stages from here are numbered on from K3's.*

**The brief's quotations (standing rule 3).**

| quotation in the brief | source | result |
|---|---|---|
| K3's handoff, "stage 3 (the skeleton of the 20 rows with sorry leaves, … and the order (SIXFRAG first)" | `data/fs131/reports/FS131-K3.md` (worktree), first `HELD FOR THE COORDINATOR` line | **verbatim** (an exact-substring match by script, one occurrence) |
| the six merged rows (FS116-N1-TOUCH → TOUCHW; RING-Q-PRIME → RING-Q-PRIME-S; FS110-N2-RING, FS110-Y3-GP → RINGBAND; FS112-SIX → FIVERING and SIXQ; RING-TRANSFER-C → FIVERING and SIXRING) | `data/fs131/k1/dispositions.csv` `merged_into`, split on `;` (inventory item 28) | **agrees**; all six are quoted verbatim in `data/fs131/k3/rows.md`, whose `--check` against the backlog re-runs **OK** today |
| rulings 26, 27 and caution C137 | `plans/FS131-close-inventory.md` items 26–27; `plans/LEAN-BACKLOG.md` § C137 | **agree** with the brief's summary; quoted by script in `data/fs131/k3b/rulings-quoted.md` |

**The rows.** The 20 rows and the six merged rows stand as quoted in `data/fs131/k3/rows.md` (K3's script, `tools/fs131_k3_rows.py --check`: OK
on the merged tree). FS116-RING-TRANSFER-C enters this wave by its five-colour clause only (FIVERING); its six-colour clause is FS116-N2-SIXRING's,
wave 8; its four-colour clause is DNF (SR1 item DNF). FS112-SIX's five-colour clause is FIVERING's length clause, its six-colour clause SIXQ's.

**The rulings in force for this wave.** Item 27: `Plane/LocalStructure` carries the three local-structure lemmas (finite tiles near a point, the
germ dichotomy, interval cones in a simple map). Item 26: each row stated at the class its argument reads (K3's list of widenings). Caution C137:
RINGBAND carries RINGWIND's periodicity clauses as clause (vi).

**The merge.** `main` (`da5303b4`, wave 1 landed) merged into `fs131-w3` as `4b363881`, no conflict: `ARCHITECTURE.md`, `Proofs.lean` and
`scripts/Axioms.lean` keep both sides' appended lines (checked by grep: wave 1's rows and K3's three rows present).

**The build.** `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree: **OK — 440 of 440 batches, 12 modules rebuilt, 0 modules with warnings**, 8 m 15 s, exit 0 (`build/gate/build/20261004T060833Z-1516785.log`
in the worktree; driver log `data/fs131/k3b/build-stage1.log`). Wave 1's seven modules are sorry-free on the merged tree; K3's foundation builds
clean on top of them.
