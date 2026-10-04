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

## Stage 4 — SAVED: the three geometric checks (computer algebra, before the Lean is written)

`tools/fs131_k3b_checks.py` (sympy 1.14; exact symbolic identities, exact sign reasoning on the parameter boxes, concrete configurations at
rational multiples of `π` evaluated exactly or at 60 digits; no search). Output `data/fs131/k3b/checks.out`: **A: PASS; B: PASS; C: PASS**.
Plants (`--plant A|B|C`, outputs `data/fs131/k3b/checks-plant-*.out`): each fires — A (the `v⁺` interval's upper end moved to `ψ + 170°`): the
zero test and the length test fail; B (an arc curving away claimed inside): both radii fail the inside test; C (`y_3` put at `e(b − 60°)`): the
derivative identity fails, `|x_e − y_3| < 1`, and the feasible arc no longer meets the window in `τ` alone.

| statement | what was checked | result |
|---|---|---|
| **FS116-N1-GERM-R**'s four intervals | for `z = y + h`, `y = r(ψ)`, the ring point `r(φ)` at distance 1 from `z` near `ψ ∓ 60°` moves by `dφ = −(∇_z f · h)/(∂f/∂φ)`, `f = \|z − e(φ)\|² − 1`; for each germ (side `s`) the excluded set `{β : s·dφ(β) > 0}` is an open half-circle whose zeros are exactly the stated ends (`ψ + 150°, ψ + 330°` for `v⁻`; `ψ − 30°, ψ + 150°` for `v⁺`; `ψ − 150°, ψ + 30°` for `u⁻`; `ψ + 30°, ψ + 210°` for `u⁺`), positive at the middle (`2/√3`); and at `ψ = 0`, `\|h\| = 1/50`, middle direction, the distance-1 ring point lies on the germ's side, `1.32°` from `r(ψ ∓ 60°)` (first order predicts `1.3232°`) | **TRUE** — the four intervals are exactly the derivation's; the excluded directions are where the distance-1 point moves onto the germ |
| **FS116-Y4-FLANK** | the first-order tangent cones: of `B̄(y′, 1)` at `y`, exactly `[ψ + 30°, ψ + 210°]`; of `B̄(y, 1)` at `y′`, exactly `[ψ + 210°, ψ + 390°]`; a segment leaving `y` along `ψ + 210°` has `\|seg(s) − y′\|² − 1 = s²` (it leaves the disc); arcs of radius 1 and 1/2 leaving `y` along `ψ + 210°` stay in `B̄(y′, 1)` when curving toward `y′` and leave it when curving away (turn 15°); the two unit arcs (centres `y′` and `y`, TWOCIRC's frame) satisfy `\|a(s) − b(s)\|² − 1 = −8 sin²(s/2) cos s` | **TRUE** — the cone clause follows from `t ⊆ B̄(y′, 1) ∩ B̄(y, 1)` alone; the edge clause needs only that each edge stays in the other unit disc. A shorter route than the row's second-order expansion: if either edge has radius below 1 it meets the other centre's unit circle only at its start, so one of its points is nearer than 1 to `y′` (resp. `y`), itself a point of the other edge (an initial piece contains its start); if both have radius 1, TWOCIRC at equal turns gives `−8 sin²(s/2) cos s < 0` |
| **FS116-S1-EXIT** | `P = y_b` at the tangent heading `τ = φ + 90°`; `\|y_b − y_3\| = 1`; `d\|P − y_3\|²/dβ` at `τ` equals `−2 cos(φ − b + 150°)` (sympy returns `2 sin(φ − b + 60°)`, the same function); on the box `φ − b + 150° ∈ (330°, 450°)` where `cos > 0`; mirrors `Q = y_a`, `\|y_a − y_5\| = 1`, `2 cos(g − a − 150°)` with `g − a − 150° ∈ (−90°, 30°)`; concrete exit `b = 60°, a = −60°, φ = 270°`: `\|x_e − y_3\| = √2`, the feasible heading arc is `[τ, τ + 90°]` (width `90° ≤ 120°`) and meets the exit window `[τ − 180°, τ]` in `τ` alone | **TRUE** — the derivation's identities and signs hold; the argument reads only the left derivative at `t_e` and `γ ∈ Λ` just before (K3's widening confirmed) |

No check failed, so no message was owed. The FLANK row's shorter route (radius below 1, or TWOCIRC) is the route the leaf plan gives.

## Stage 5 — SAVED: the skeleton and the read-backs

### 5.1 The skeleton

Six new modules under `Proofs/HadwigerNelson/Plane/`, every leaf `sorry`, in K3's order (SIXFRAG before the ring rows that cite it):

| module | rows | leaves |
|---|---|---|
| `Plane/LocalStructure` | the supporting lemmas (inventory ruling 27), plus `angleIcc`/`angleIoo` and `covers_one_iff` | 11 |
| `Plane/SixFragment` | FS116-Y2-SIXFRAG (`sixFrag : ArcMap 6`) | 12 (two items proved: `sixFrag_covers`, the spec example `sixCol (1/2) = 0`) |
| `Plane/Tiles` | V5-NE1, V4-DICHOTOMY, V4-MEET, S1-CLUSTER, OR1-WHOLE | 20 (`IsTile.unitNear_self` proved) |
| `Plane/RingGerm` | V4-TWIST, N1-TWIST-D, N1-GERM-R, N1-GERM-S, RING-Q-PRIME-S, N1-QFREE4, N2-FIVERING, SR1-SIXQ, SR2-TOUCHW, N1-ECHO, V5-U1, Y4-FLANK | 38 |
| `Plane/Lens` | S1-EXIT | 2 |
| `Plane/RingBand` | SR1-RINGBAND with FS110-N2-RING, FS110-Y3-GP and clause (vi) (C137); the map bridge | 15 (`ringCircleColouring`'s periodicity fields and `exists_swap_of_ring` proved) |

**96 declarations use `sorry`** (counted from the build log). **The build**: `./scripts/build.sh` in the worktree under
`scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): **OK — 440 of 440 batches, 7 modules rebuilt, 6 modules with warnings — exactly
the six new modules, every warning `declaration uses 'sorry'`** (no other warning or error in the log beyond the up-to-date probe's expected
"out-of-date" lines), 8 m 39 s, exit 0 (`build/gate/build/20261004T062815Z-1624137.log` in the worktree; driver log
`data/fs131/k3b/build-skeleton.log`). Iteration used `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false` and scratch
oleans; the evidence is this build.

`scripts/Axioms.lean`: 102 records in a new section (every theorem of the six modules and the two definitions built from leaves, `sixFrag`,
`ringCircleColouring`), listed by `tools/fs131_k3b_decls.py` (`--check`: 102 names, 0 missing; `--plant`, which drops the namespace tracking,
fails the check). `Proofs.lean`: six imports. `ARCHITECTURE.md` § 3.11: six rows; `tools/check_architecture.py` **PASS**, 198 rows, 0 mismatches.

**Where the design changed, and why** (K3's design is § "For stage 3"):
1. **Angular intervals named.** `angleIcc a b = ⋃ m : ℤ, Icc (a + 2πm) (b + 2πm)` and `angleIoo` (with a spec example and an adversary) in
   place of K3's inline `⋃ m, Icc …`: every cone clause (V5-U1, FLANK, interval cones) reads one name.
2. **`covers_one_iff`** states the equivalence K3 assumed ("a closed disc of radius above 1" = `Covers p 1`), so every read-back of that
   hypothesis is checked, not asserted.
3. **N-E1 lives in `Plane/Tiles`, not `LocalStructure`**: `LocalStructure` is pure topology (no validity), and N-E1 is FS116-V5-NE1's own
   first clause.
4. **OR1-WHOLE's `R₂` clause is stated pointwise** (`not_mem_closure_wholeRestrict_of_inner`): its argument reads, for each angle `θ`, only that
   `p + e θ` is a closure point of `T ∩ B(p, 1)` for a tile `T` of colour `c` — a point of `T ∩ B(p, 1)` is more than `1` from `p + 2e θ` by the
   triangle inequality, so no "inner side is one tile" strip is needed. The row's arc form is the corollary `not_mem_closure_wholeRestrict_R₂`.
   A widening beyond K3's (reported).
5. **FLANK split in four**: the cones (`flank_cone`), the edges' existence (`flank_edge_exists`, needing the points in the domain — the row
   presupposes the edges by its definite article), the geometry (`flank_initialPieces`, a lemma on two initial pieces and two discs), and the
   row's last clause for any sets `a`, `b` whose closures hold the edges (`flank`). The stage-4 check gave a shorter route than the row's
   second-order expansion (§ 4).
6. **GERM-S's absent colours as a set**: `(F.coloursAt p)ᶜ = {X, X'}` — the row's "X and X̄ are the colours absent at p" literally — beside
   `ncard + 2 = k`.
7. **SIXQ's (Q) clause at every `k ≥ 4`** (the row says `k = 6`; the argument reads only that `p` carries all colours and that there are at
   least four, IsQArc's own threshold). A widening (reported).
8. **ECHO in three**: `echo_unique` (the engine: the only closure point of the class of `X` at distance 1 from `w` is `2w − p`),
   `echo_of_mem_closure` (K3's widening: some closure point at distance 1 suffices), `echo` (the row, reading (B)).
9. **RINGBAND's map bridge at every `k`**: `ringCircleColouring` needs only a valid map covering `B̄(p, 1)`, a ring carrying no arc of `Γ`, and
   `g : Fin k → ZMod 3` injective on the colours absent at `p` — not "three colours at `p`" (injectivity already caps the absent colours at
   three; FS110-N2-RING's setting is the case `k = 6`, three colours at `p`). Its fields are proved from three leaves (`ring_finite_S`,
   `ring_locallyConstant`, `ring_proper`); `periodic` and `periodic_S` are proved. A widening (reported).
10. **SIXFRAG's colour by formula in `ZMod 6`** (which is `Fin 6`): sector index `⌊arg x / 60°⌋`, lens index `round(arg x / 60°)` with the
    lens test, gap colour the sector index plus 4. K3 named `locallyConstant` as a leaf; so are `nondegenerate` and `locallyFinite`
    (`sixArcs_*`), so `sixFrag` itself is a definition with no `sorry` of its own. Spec examples at four points (one per tile kind, one at
    negative `arg`), the first proved.

### 5.2 The read-backs (each formal statement against its row, `data/fs131/k3/rows.md`, and the rows merged into it)

Conventions read once: "valid (k-coloured) fragment" is `F : ArcMap k` with `hF : F.Valid` (at `k = 6` when the row names no `k`); "on a
closed disc of radius above 1 about `p`" is `F.Covers p 1` (`covers_one_iff`); "a vertex of at least four colours" is
`4 ≤ (F.coloursAt p).ncard`; "Siamese pairs allowed" is the absence of a `NonSiamese` hypothesis; "a tile of colour `c`" in a *hypothesis*
about closures, cones or germs is the class `F.region c` (weaker hypothesis, stronger theorem), and in a *conclusion* it is the class too,
equal to the tile reading through `mem_coloursAt_iff_exists_tileOf` and `coneAt_region_eq_biUnion` on the domain. Angles are reals; a
direction interval `(ψ + 150°, ψ + 330°)` is the real interval `Ioo (ψ + 5π/6) (ψ + 11π/6)`, which by the cone's `2π`-periodicity
(`mem_coneAt_add_two_pi`) is the row's circular one.

| row | declarations | read-back |
|---|---|---|
| **FS116-V5-NE1** | `ne1_region`; `IsTile.subset_ball`, `IsTile.closure_subset_closedBall`, `IsTile.dist_lt_one` | Row: `x` in the closure of a tile of colour `c` ⟹ no interior point `z` of a tile of colour `c` has `\|z − x\| = 1`; in particular `T ⊆ B(x, 1)` for `x ∈ cl T`, `cl T ⊆ B̄(x, 1)`, diameter ≤ 1. Formal: `x ∈ cl (region c)`, `z ∈ region c` ⟹ `dist z x ≠ 1` (class form: **stronger**); the three "in particular" clauses as stated, the diameter **pointwise and strict** (`dist a b < 1` on `T`, as wave 1's DIAM). Not claimed (open disc for another tile's closure point; points of `Γ`): not claimed here either. **Same, strengthened** |
| **FS116-V4-DICHOTOMY** | `unitNear_or_unitFar`, `IsTile.unitNear_self`, `IsTile.dist_le_one_of_mem_closure`, `unitNear_of_mem_closure`, `unitFar_of_mem_closure`, `NonSiamese.eq_of_unitNear` | Row: tiles `A, B` of one colour (`A = B` allowed): `A ~ B` or `A ⊥ B`; `A ~ A`, so `cl A` has diameter ≤ 1; closure points `< 1` ⟹ `~`, `> 1` ⟹ `⊥`; non-Siamese and `A ~ B` ⟹ `A = B`. Formal: each clause, `~`/`⊥` as `UnitNear`/`UnitFar` (all cross distances `< 1` / `> 1`), the closure diameter pointwise (`≤ 1` between closure points). The last clause needs no validity (formal: none). **Same** |
| **FS116-V4-MEET** | `unitNear_iff_of_mem_closure_inter` | Row: tiles `A, B` of one colour with a common closure point ⟹ for every tile `T` of that colour, `T ~ A ↔ T ~ B`. Formal: the same, under `F.Valid` (the row's setting, FS116-V4's valid fragments; the argument reads N-E1). **Same** |
| **FS116-S1-CLUSTER** | `cluster` | Row: a finite family `𝒯` of tiles of colour `c` with connected union of closures, `U` a tile of colour `c`; some point of the union at distance `< 1` from some point of `cl U` ⟹ every point of the union within `1` of every point of `cl U`. Formal: `𝒯 : Set (Set ℂ)`, `𝒯.Finite`, `IsPreconnected (⋃ T ∈ 𝒯, cl T)`; conclusion `≤ 1`. **Same** |
| **FS129-OR1-WHOLE** | `Valid.wholeRestrict`, `wholeRestrict_covers`, `isTile_wholeRestrict_iff`, `isTile_wholeRestrict_of_mem_closure`, `NonSiamese.wholeRestrict`, `Simple.wholeRestrict`, `not_mem_closure_wholeRestrict_of_inner`, `not_mem_closure_wholeRestrict_R₂` | Row: `F` valid on `B̄(p, r)`, `r > 1`, `1 < ρ ≤ r`; `F_ρ` (the map of `V ∩ int ⋃_{T ∈ 𝒯_ρ} cl T`, tiles `𝒯_ρ`) is valid on `B̄(p, ρ′)` for `ρ′ < ρ`, each tile a tile of `F` with the same closure, the tiles at `p` those of `F`, non-Siamese and simple inherited; for `ρ ≤ √3`, no tile of `F_ρ` of colour `c` has a point of `R₂(ᾱ)` in its closure when `α` (an arc of `Γ` on `ω(p)` of positive length) has inner side one tile of colour `c`. Formal: `F.wholeRestrict p ρ` is K3's `F_ρ` (`Plane/LocalMap`); validity holds for every `p, ρ` (**stronger**); the covering clause needs only `F.Covers p r`, `ρ ≤ r` (no `r > 1`, `ρ > 1`: idle); `isTile_wholeRestrict_iff` says the tiles of `F_ρ` are exactly `𝒯_ρ` (same sets ⟹ same closures and colours: the row's "each of its tiles is a tile of `F` with the same closure" and its definition of `F_ρ`'s tiles, now a theorem); the tiles at `p` (for `ρ > 0`); the `R₂` clause pointwise, with no use of the arc lying in `Γ` (**stronger**, § 5.1 item 4), and in the row's form as a corollary. **Same, strengthened** |
| **FS116-V4-TWIST** | `not_germIn_closure_rotate`, `not_mem_coloursAt_of_mem_sphere` | Row: at `p` of a valid fragment on a disc of radius above 1, no colour has a tile whose closure holds a germ `g` of `ω(p)` and a tile whose closure holds `σg` or `σ⁻¹g`; a point of `ω(p)` inside a tile has that tile's colour absent at `p` when `p` is a vertex. Formal: for every valid `F`, `¬ (GermIn p θ s (cl region c) ∧ GermIn p (θ + π/3) s (cl region c))` (σ⁻¹ is the instance at `θ − π/3`; class form; covering hypothesis **dropped**, idle); `z ∈ ω(p) ∩ region c ⟹ c ∉ coloursAt p` ("vertex" **dropped**, idle). Not claimed (germs on `Γ` with `c` on neither side): such a germ is not in `cl (region c)`, so outside the hypothesis. **Stronger** |
| **FS116-N1-TWIST-D** | `ringD`, `isClosed_ringD`, `ringD_subset_Γ`, `finite_ringD_off_ringArc` | Row: at a vertex `p` (any degree, `k ≥ 1`) of a valid fragment on a closed disc of radius above 1, `D` (points of `ω(p)` in the closure of a tile of one of `p`'s colours) is closed and lies in the arcs of `Γ` on `ω(p)` and finitely many points. Formal: `ringD` in class form (equal to the tile form on the covered ring); closed (no hypothesis); `D \ {OnRingArc} finite` under `Valid`, `Covers p 1` ("vertex" **dropped**; `k ≥ 1` automatic, `ArcMap 0` is empty); plus `D ⊆ Γ`, the step the finiteness rests on. Not claimed (non-empty; arcs alone): not claimed. **Same, strengthened** |
| **FS116-N1-GERM-R** | `germR_vMinus`, `germR_vPlus`, `germR_uMinus`, `germR_uPlus` | Row: valid fragment on a closed disc of radius above 1 about `p`; `y = r(ψ)`; `v⁻` (just cw of `r(ψ − 60°)`) in the closure of a tile of colour `c` ⟹ no tile of colour `c` approaches `y` along `β`, `β − ψ ∈ (150°, 330°)`; `v⁺`: `(−30°, 150°)`; `u⁻`: `(−150°, 30°)`; `u⁺`: `(30°, 210°)`. Formal: each germ as `GermIn p (ψ ∓ π/3) s (cl (region c))` (class form: weaker hypothesis); conclusion `β ∉ coneAt (region c) y` on the open interval (class form: stronger); covering hypothesis **dropped** (idle: N-E1 alone). Intervals checked in stage 4. **Stronger** |
| **FS116-N1-GERM-S** | `germS_absent`, `germS_inward`, `germS_outward`, `germS_four` | Row (`k = 6`): change point `y` (colour `X` just ccw, `X̄` just cw) of the ring of a vertex `p` of ≥ 4 colours ⟹ `p` has exactly four colours, `X, X̄` the absent ones; (i) if neither `v⁻` nor `u⁺` on a (Q) arc, every direction in `(ψ + 150°, ψ + 210°)` lies in the cone of a tile of a colour `c` of `p` every tile of `p` of which colour lies in `B̄(y, 1)`; (ii) if neither `u⁻` nor `v⁺` on a (Q) arc, every direction in `(ψ − 30°, ψ + 30°)` lies in the cone of a tile not of `p`, of a colour `c` of `p` every tile of `p` of which colour misses `B(y, 1)`; (iii) none of the four on a (Q) arc ⟹ `y` has ≥ 4 colours. Formal: at every `k` with `k ≤ ncard + 2` (**K3's widening**, inventory item 26; at `k = 6` the hypothesis follows from `4 ≤ ncard`); "exactly four" as `ncard + 2 = k` and `(coloursAt p)ᶜ = {X, X'}`; (i), (ii), (iii) as stated, "a tile, not a tile of `p`" as the class outside `B̄(p, 1)` (same cone in that window). **Same at `k = 6`, widened** |
| **FS116-RING-Q-PRIME-S** (+ RING-Q-PRIME) | `ringQPrimeS` | Row: change point of the ring of a vertex of ≥ 4 colours whose points at `±60°` lie on no closed (Q) arc ⟹ a vertex of ≥ 4 colours. Formal: `¬ OnQArc p (r(ψ ± π/3))` (closed arcs); at every `k` with `k ≤ ncard + 2`. RING-Q-PRIME (non-Siamese, simple, radius above 2, a (Q) arc on the ring, "no (Q) arc" read as the closed arc per its not-claimed line) is the special case. **Same at `k = 6`, widened; carries its merged row** |
| **FS116-N1-QFREE4** | `qfree4` | Row: vertex of ≥ 4 colours, ring with no (Q) arc ⟹ exactly four colours. Formal: at every `k`, `ncard + 2 ≤ k` (at `k = 6` with `4 ≤ ncard`: `ncard = 4`). **Same at `k = 6`, widened** |
| **FS116-N2-FIVERING** (+ FS112-SIX's five-colour clause, RING-TRANSFER-C's five-colour clause) | `fiveRing_no_changePoint`, `fiveRing_finite_off_Q`, `fiveRing_length`, `fiveRing_no_hub` | Row: vertex of five colours ⟹ no change point; for `θ` off a finite set `r(θ)` or `r(θ + 60°)` on a (Q) arc; (Q) arcs of total length ≥ 180°; no hub. Formal: at every `k` with `ncard + 1 = k`, `4 ≤ ncard` (`k = 6`: five colours); the finite set within `[0, 2π)`; the length as `ENNReal.ofReal π ≤ arcLength {θ \| OnQArc p (r θ)}`; no `IsHub`. FS112-SIX ("unit arcs centred at it of total length at least 180°") is the length clause; RING-TRANSFER-C's five-colour clause ("no change point and places no vertex through RING-GERM") is the first and last. **Same at `k = 6`, widened; carries both** |
| **FS129-SR1-SIXQ** (+ FS112-SIX's six-colour clause) | `sixQ_sphere_subset_Γ`, `sixQ_sides`, `sixQ_isQArc`, `sixQ_inhabited` | Row: `k ≥ 1`, all `k` colours at `p`, closed disc of radius above 1 ⟹ `ω(p) ⊆ Γ`; both side colours of every arc of `Γ` on `ω(p)` carried at `p`; at `k = 6` every arc a (Q) arc. Formal: the first under `Valid`, `Covers p 1`; the second needs nothing (all colours are carried); the third at every `k ≥ 4` (**widening**). FS112-SIX: "its whole unit circle lies in `Γ`, every arc of kind both" = first and third. Inhabitant: `sixFrag` (`sixQ_inhabited`). **Same, widened; carries its merged clause** |
| **FS129-SR2-TOUCHW** (+ FS116-N1-TOUCH) | `touchW` | Row (`k = 6`): vertex of exactly four colours; `w ∈ ω(p)` no change point, on no arc of `Γ` on `ω(p)`, none of the four germs at `w ± 60°` on a (Q) arc ⟹ the ring just cw and ccw of `w` in tiles of one colour `X` absent at `p`; each of the four germs in the closure of a tile of the other absent colour `X̄` and of no tile of colour `X`; no tile of colour `X̄` has `w` in its closure. Formal: at every `k` with `ncard + 2 = k`, `4 ≤ ncard`; `(coloursAt p)ᶜ = {X, X'}`, both germs at `w` in `region X`; each germ at `ψ ± π/3`, each side, in `cl (region X')` and in `(cl (region X))ᶜ` (no point of the germ in the closure of the class of `X`: **stronger** than "in the closure of no tile of colour `X`"); `X' ∉ coloursAt w`. N1-TOUCH's extra hypothesis (`w` in the closure of a tile of one of `p`'s colours) is absent (idle, per SR2 item 20). **Same at `k = 6`, widened** |
| **FS116-N1-ECHO** | `echo_unique`, `echo_of_mem_closure`, `echo` | Row: valid, closed disc of radius above 2; ring just cw and ccw of `w` in tiles of one colour `X` absent at `p`; `w` an essential boundary point, saturated, `X ∈ P(w)` ⟹ `2w − p` in the closure of a tile of colour `X`. Formal (`echo`): the same with the radius-2 hypothesis **dropped** (idle); `echo_of_mem_closure` drops the essential-boundary, saturation and density hypotheses for "some point of `cl (region X)` at distance 1 from `w`" (K3's widening); `echo_unique` is the engine. **Same, strengthened** |
| **FS116-V5-U1** | `ringArc_cone_inner`, `ringArc_cone_outer`, `ringArc_sideCone_inner`, `ringArc_sideCone_outer`, `ringArc_sideCone_other`, `four_of_bothKind`, `four_of_bothKind_simple` | Row: `A` an arc of `Γ` on `ω(z)`, extent `[θ₁, θ₂]`, `ℓ > 0`, inner `c`, outer `c′`: tiles of `c` at `z` cone in `[θ₂ − 90°, θ₁ + 90°]`; of `c′` in `[θ₂ + 90°, θ₁ + 270°]`; side cones `(θ₁ − 90°, θ₂ − 90°)`, `(θ₁ + 90°, θ₂ + 90°)` hold neither; if `z` carries both, the side cones hold two further colours and, non-Siamese simple, `z` has ≥ 4 colours. Formal: `IsRingArc z θ₁ θ₂ c c'` (`θ₁ < θ₂` is `ℓ > 0`); cones of the classes in `angleIcc` (class form: stronger); side cones disjoint from both classes' cones; "two further colours": every direction of a side cone in the cone of a colour `∉ {c, c′}` — **with `z ∈ F.dom` added** (§ 5.3); the four-colour clause at the class it reads (one tile per colour at `z`, interval cones) and in the row's non-Siamese simple form, both with `z ∈ F.dom`. FS112-U1's first three clauses are these (SR1 item 4). **Same, but for the added hypothesis — a statement finding** |
| **FS116-Y4-FLANK** | `flank_cone`, `flank_edge_exists`, `flank_initialPieces`, `flank` | Row: `t` a tile (valid, Siamese allowed, closed disc of radius above 1 about `p`), `y = r(ψ)`, `y′ = r(ψ + 60°)` in `cl t`, cone at `y` ⊇ `(ψ + 150°, ψ + 210°)`, at `y′` ⊇ `(ψ + 210°, ψ + 270°)` ⟹ the cone at `y` ends at `ψ + 210°`, at `y′` begins at `ψ + 210°`; for `a` (resp. `b`) the tile bordering `t` along `t`'s edge leaving `y` (`y′`) in direction `ψ + 210°`, some points of `cl a`, `cl b` are nearer than 1. Formal: "ends at" as `cone ⊆ angleIcc (ψ + 30°) (ψ + 210°)` and `ψ + 210° ∈ cone` (and "begins at" with `[ψ + 210°, ψ + 390°]`); the covering hypothesis **dropped** (idle); the edges' existence (presupposed by the row) a clause of its own for points of the domain; the last clause for **any** sets `a, b` whose closures hold the edges (K3's widening: `t` itself allowed). TWOCIRC replaces the identity step (SR1 item 1) in `flank_initialPieces`. **Same, strengthened** |
| **FS116-S1-EXIT** | `leftNormal`, `lensΛ`, `exit_lens`, `exit_lens_row` | Row: `30° < b < 90°`, `−90° < a < −30°`, `y_b, y_a, y_3, y_5`, `Λ`; `γ` `C¹` on `[0, t_e]`, `γ(0) = 0`, `γ(t) ∈ Λ` on `(0, t_e)`, `γ(t_e) ∈ ∂Λ \ {0}`, left unit normal `ν`; the four conditions ⟹ `γ + ν = y_b` or `γ − ν = y_a` at `t_e`. Formal: `exit_lens` on a left derivative `γ′ ≠ 0` at `t_e` and `γ ∈ Λ` eventually before `t_e` (K3's widening: `γ(0) = 0`, `C¹` and the whole interval idle), `ν = leftNormal γ′ = i γ′/\|γ′\|`, `∂Λ` as `frontier`; `exit_lens_row` in the row's form (`ContDiffOn ℝ 1` on `[0, t_e]`, nonvanishing `derivWithin`, `ν` from `derivWithin γ (Icc 0 t_e) t_e`). Checked in stage 4. **Same (row form), widened** |
| **FS116-Y2-SIXFRAG** | `sixFrag`, `sixFrag_valid`, `sixFrag_nonSiamese`, `sixFrag_covers`, `sixFrag_coloursAt_zero`, `sixFrag_sphere_subset_Γ`, `sixFrag_isQArc`, `sixFrag_isRingArc` | Row: `S_j` (colour `j`), `Q_j` (colour `j + 2`), `G_j` (colour `j + 4`), cut at `\|x\| = 3/2`, form a valid non-Siamese six-coloured fragment holding `B̄(p, R)` for `R < 3/2`, `p` a vertex of six colours whose ring lies in `Γ` and all of whose ring arcs are (Q). Formal: `sixFrag` by its arcs and colour formula (§ 5.1 item 10); valid, non-Siamese, covers `B̄(0, R)` for `R < 3/2` (proved), six colours at `0`, `ω(0) ⊆ Γ`, every `IsRingArc` at `0` an `IsQArc`, and one ring arc exhibited (`[0°, 30°]`, colours `0`/`2`) so the last clause is not vacuous. The tiles' identity with `S_j, Q_j, G_j` is carried by the colour formula and the arcs; spec examples pin one point of each tile kind. **Same** |
| **FS129-SR1-RINGBAND** (+ FS110-N2-RING, FS110-Y3-GP; clause (vi) per C137) | `ringband_i` … `ringband_v`, `W_eq`, `ringband_vi_periodic`, `ringband_vi_noJump`, `exists_lift`, `PairPos`; `exists_swap_of_abs_W_le_one`, `W_mod_six`, `exists_pair_of_abs_W_le_two`; `ringCircleColouring`, `exists_swap_of_ring` | Row: (i) `h = (6 − 2n₂)/3 ∈ {−2, 0, 2}`; (ii) `W = Σ m_j + 3 − h/2`; (iii) `h` changes across `θ₀` only if `Σ ∋ θ₀ + 60°j, θ₀ + 60°(j + 1)`; (iv) no swap point ⟹ all `m_j = M`, `W ∈ {6M + 2, 6M + 3, 6M + 4}`, `W = 6M + 3` unless `Σ` is `60°`-invariant; (v) no two points `60°` apart ⟹ `h = 0`, `W = 6M + 3`. Formal: (i) as `3h = hSum = 6 − 2n₂` (the row's division made exact) and `h ∈ {−2, 0, 2}`, at good `θ`; (ii) with `3 ∣ f(θ + 2π) − f(θ)`; the row's "put `W = …`" read as one number, `W_eq` (equal at every `θ ∉ S`); (iii) as local constancy of `h` on good angles near `θ₀` when `¬ PairPos θ₀` (`j < 6` suffices by periodicity); (iv) "unless invariant" as `(¬ ∀ x, x ∈ S ↔ x + π/3 ∈ S) → W = 6M + 3`; (v) with its `M`; (vi) RINGWIND's "has period 60°" and "a hexagon position that is the only one with two change points 60° apart carries no jump" (all pair positions congruent to `θ₀` mod `60°`). FS110-N2-RING on the circle and on the map (through the bridge, § 5.1 item 9); FS110-Y3-GP's two clauses on the circle. Not claimed (tiles or maps in RINGBAND proper; `h` constant across a swap): RINGBAND proper is map-free, the bridge separate. **Same; carries its merged rows and C137's clauses** |

### 5.3 The statement finding (sent to Keryx with this stage's commit)

**FS116-V5-U1's last two clauses need `z` in the fragment's open set** — a hypothesis the row leaves implicit. If `z ∉ F.dom`, the side cones
may lie outside the domain and hold no colour. **Model** (by formula; valid, non-Siamese, simple): `z = 0`, `A = r([0°, 30°])`, `η = 1/100`.
Domain: the open sector `S′ = {s e(θ) : 0 < s < 1, 0° < θ < 30°}`, the thin neighbourhood `N = {ρ e(θ) : 1 − η < ρ < 1 + η, −5° < θ < 35°}`
of `A`, and the open wedge `W = {s e(β) : 0 < s < η, 190° < β < 200°}`; `0` is not in it. Arcs: `A` and the two radial segments
`[(1 − η)e(0°), (1 + η)e(0°)]`, `[(1 − η)e(30°), (1 + η)e(30°)]`. Tiles and colours: `S′` (it contains the inner side of `A`), colour `c`; the
outer side `{1 < ρ < 1 + η, 0° < θ < 30°}`, colour `c′`; the two end pieces of `N` (`θ < 0°`, `θ > 30°`), colours `d` and `d′`; `W`, colour `c′`.
Within each tile all distances are below 1 (the sector has radius 1 and angle 30°; the pieces are small). The one same-colour cross pair is
the outer tile against `W`: for `ρ e(θ)` with `θ ∈ (0°, 30°)` and `s e(β)` with `β ∈ (190°, 200°)`, `cos(θ − β) < 0`, so the distance exceeds
`ρ > 1` — far, never exactly 1. So the map is valid and non-Siamese; every tile is a Jordan domain and the closures of distinct tiles meet in a
segment, an arc or the point `0`, so it is simple. `A ⊆ Γ` with inner colour `c` and outer `c′` (`IsRingArc 0 0 (π/6) c c′`), and `0` carries
exactly `c` (cone `[0°, 30°]`, in the facing cone `[−60°, 90°]`) and `c′` (cone `[190°, 200°]`, in the facing-away cone `[120°, 270°]`): the arc is
both-kind. The side cones `(−90°, −60°)` and `(90°, 120°)` hold no colour, and `0` has two colours, not four — the row's last two clauses fail.
With `z ∈ F.dom` the row's argument goes through (every direction of a side cone lies in some colour's cone, `exists_mem_coneAt_region`), so the
formal statements `ringArc_sideCone_other`, `four_of_bothKind`, `four_of_bothKind_simple` carry `hz : z ∈ F.dom`. The derivation's setting (a
fragment about a vertex, `z` the vertex) always has `z` in the domain, so no consumer is affected; FS112-U1's merged clauses (the first three)
need no such hypothesis.

## Stage 6 — SAVED: the leaf plans and the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh)

### 6.1 What the pass found: three statements from which most leaves derive

The pass read each leaf for the statement its proof derives from, and found that the ring rows are not twenty arguments but three engines
and their instances. Each engine is a child the implementer states first, in the module named.

1. **The crossing engine** (`Plane/Tiles`, child `Valid.dist_lt_or_gt_of_isPreconnected`): in a valid map, for `z ∈ region c` and any
   preconnected `S ⊆ closure (region c)`, every point of `S` is nearer than `1` to `z` or every point is farther (`ne1_region` makes `1`
   unattainable; wave 1's `preconnected_dist_lt_or_gt`, `Plane/DensityPoints`, does the rest). Every "N-E1 against a curve" step of the
   derivations is this lemma at a germ, a radial segment or an arc through a point: **TWIST**'s first clause (a point of the class near a point
   of `g`, against the arc `σg`), **GERM-R** (`z = y + h`, against the germ), **ECHO**'s engine (a point of the class near `x`, against the arc
   of `ω(p)` through `w`), **V5-U1**'s cones (`z + h`, against a radial segment of the inner or outer side), **TOUCHW**'s `X`-clause. Each of
   these leaves then reduces to a *pure-geometry* child — exhibit two points of the curve on either side of distance `1` — which is exact
   arithmetic on unit circles (wave 1's `dist_ringPt_ringPt_cmp_one`, `ringPt_sub_ringPt`, `norm_e_sub_e_le`).
2. **One point in the closure of one tile** (`Plane/LocalStructure`, child `mem_closure_tile`: every point of the domain lies in the closure of
   some tile): a ray from `x` avoiding the finitely many arcs near `x` (each meets a ray from `x` in finitely many points unless it is a
   segment on that ray; finitely many directions excluded) is an interval of interior points, so lies in one tile. **Re-pricing**: K3 put
   OR1-WHOLE's covering clause on `finite_tiles_near` (H); it needs only this (M) — for `y` near a point of `B̄(p, ρ′)`, the tile whose
   closure holds `y` is open with `y ∈ ball p ρ` in its closure, so it meets `B(p, ρ)`. `exists_mem_coloursAt` follows too.
3. **The sector structure at a point** (`Plane/LocalStructure`, child `localSectors`): for `x ∈ dom` there are `r > 0` and finitely many
   branches — continuous injective curves `b : [0, r) → ℂ`, `b 0 = x`, `‖b s − x‖ = s`, pairwise disjoint on `(0, r)`, each with a tangent
   direction — whose union is `Γ ∩ ball x r` (minus nothing, plus `x` when `x ∈ Γ`), and the components of `ball x r \ (Γ ∪ {x})` are the open
   polar sectors between angularly consecutive branches (each path-connected: a polar rectangle). `finite_tiles_near` (a tile meeting
   `ball x r` contains a sector), `coneAt_region_eq_biUnion` (the cone of a finite union), `Simple.coneAt_eq_angleIcc` (a Jordan boundary
   has exactly two branches at each of its points, and the tile is the sector between them), `germ_dichotomy` (the branches cross `ω(p)` at
   finitely many points) and `flank_edge_exists` (the cone's end direction is a branch's tangent) are corollaries. K3 priced the first and third
   H separately; they share this one H statement, and each is M on top of it.

**Measures for the burn-down.** No leaf recurses: every proof is a finite composition, so the measure is the leaf count (§ 5.1: 96 `sorry`
leaves) and each turn replaces a leaf by stated children. The one quantity-shaped argument is RINGBAND's band step (the jumps of `D₀(θ)`
across the finitely many events of a period), an induction on the sorted event list of `S ∩ [θ₀, θ₀ + 2π)` (`Set.Finite.toFinset` sorted;
`Finset.induction_on` over the events crossed).

**Smells read.** (a) The four GERM-R clauses are one argument under the reflection `θ ↦ 2ψ − θ` — state the geometric child once, parametric in
the sign `σ = ±1` of `±60°` and the side `s`, and instantiate four times (transporting the whole map by conjugation would be heavier).
(b) GERM-S, RING-Q-PRIME-S, TOUCHW, QFREE4 and FIVERING each re-derive "a ring point off `Γ` carries a colour absent at `p`" — that is
`not_mem_coloursAt_of_mem_sphere`, cited, never re-proved. (c) `ringband_iv`'s `M` is quantified over all good `θ`: the band step must be an
invariant of the whole period (all `m_j(θ) = m₀(θ + jπ/3)` and `m₀` constant across events), not a per-`θ` fact — the statement was checked to
carry it (§ 5.2).

### 6.2 The plan per leaf

Mathlib names confirmed with `#check` at the pin (`v4.32.0`, scratch file 2026-10-04): `IsCompact.exists_cthickening_subset_open`,
`cthickening_closedBall`, `Set.Finite.isClosed_biUnion`, `Set.Finite.closure_biUnion`, `IsPreconnected.subset_connectedComponentIn`,
`connectedComponentIn_subset`, `IsOpen.connectedComponentIn`, `IsPreconnected.image`, `IsPreconnected.Icc_subset`, `intermediate_value_Icc`,
`intermediate_value_Icc'`, `Real.cos_pos_of_mem_Ioo`, `Real.cos_nonneg_of_mem_Icc`, `HasDerivWithinAt.norm_sq`,
`IsLocalMaxOn.hasFDerivWithinAt_nonpos`, `mem_posTangentConeAt_of_segment_subset`, `Complex.arg_ofReal_of_nonneg`, `Int.floor_eq_iff`,
`round_eq`, `ZMod.intCast_zmod_eq_zero_iff_dvd`, `ZMod.intCast_cast`, `MeasureTheory.measure_union_le`, `MeasureTheory.Measure.restrict_apply`,
`Real.volume_Ico`, `Complex.dist_eq`, `Complex.sq_norm`, `Complex.normSq_apply`, `Metric.mem_closure_iff`, `mem_closure_iff_nhds`,
`Finite.exists_infinite_fiber`, `Set.Finite.biUnion`, `interior_mono`, `IsOpen.subset_interior_iff`, `frontier_inter_subset`,
`Complex.norm_exp_ofReal_mul_I`, `ContDiffOn.continuousOn`, `Set.ncard_le_ncard`, `Set.ncard_pair`, `Set.ncard_add_ncard_compl`,
`Set.Finite.isClosed`, `IsCompact.elim_finite_subcover`, `isCompact_sphere`. (Not at the pin, so not to be cited:
`IsLocalMaxOn.hasDerivWithinAt_nonpos`, `closure_biUnion_of_finite`.) Wave 1's, cited: `dist_ne_one_of_mem_of_mem_closure` (CLOSURE),
`dist_lt_one_of_isPreconnected`, `dist_lt_one_of_forall_dist_ne_one`, `preconnected_dist_lt_or_gt`, `hull2`, `subset_densitySet_of_isOpen`,
`dist_ringPt_ringPt`, `dist_ringPt_ringPt_cmp_one`, `ringPt_sub_ringPt`, `norm_e_sub_e_le`, `twoCirc_identity`, `twoCirc_cmp_one`,
`ae_arcLength_shift_pi` (UnitAvoiding; its proof is the template for a shift by `π/3`).

Difficulty: E easy, M moderate, H hard. Dependency order within each module is the order below.

**`Plane/LocalStructure`**
| leaf | route | children | grade |
|---|---|---|---|
| `Arc.finite_inter_sphere_or_eq_circ` | segment: `‖a + t(b − a) − p‖² = 1` is a quadratic in `t` with leading coefficient `‖b − a‖² > 0`, ≤ 2 roots; `circ c ρ`: `c = p, ρ = 1` is the second disjunct, `c = p, ρ ≠ 1` empty, `c ≠ p`: `A cos θ + B sin θ = C`, `(A, B) ≠ 0`, finitely many roots on `[θ₀, θ₁]` (length ≤ 2π) | `quadratic_roots_finite`, `trig_linear_roots_finite` | M |
| `covers_one_iff` | `IsCompact.exists_cthickening_subset_open` on `closedBall p 1`, `cthickening_closedBall` | — | E |
| `finite_ringΓ_off_ringArc` | cover the compact ring by finitely many `locallyFinite` neighbourhoods (`IsCompact.elim_finite_subcover`); arcs not on `ω(p)` contribute finitely many points; a point on an arc `circ p 1 θ₀ θ₁` of `Γ` is `OnRingArc` (a short sub-arc lies in `dom`, open) | `onRingArc_of_mem_circ` | M |
| `dense_interiorPts` | arc carriers are null (a segment lies in a line, an arc in a circle: `Metric.sphere` is null for `volume` on `ℂ`), so near `x` the finitely many arcs have empty interior together | `Arc.volume_carrier`, `interior_carrier_eq_empty` | E–M |
| `exists_mem_coloursAt` | `closure interiorPts = ⋃ c, closure (region c)` (finite union, `Set.Finite.closure_biUnion`) | — | E |
| `mem_closure_tile` (child, new) | engine 2 above | `exists_ray_avoiding_arcs` | M |
| `localSectors` (child, new) | engine 3 above: arcs through `x` only (`locallyFinite` + closed arcs at positive distance); each has ≤ 2 branches, graphs over the radius for small `r`; distinct branches meet only at `x` for small `r` (two distinct circles or lines meet in ≤ 2 points); sort by angle; polar sectors path-connected | `arcs_near_pass_through`, `Arc.branches`, `branches_disjoint`, `sector_isPathConnected` | **H, the wave's hardest leaf** |
| `finite_tiles_near` | a tile meeting `ball x r` contains a sector (or the punctured ball); ≤ #sectors tiles | — | M on `localSectors` |
| `mem_coloursAt_iff_exists_tileOf` | (←) `mem_coloursAt_of_tileOf`; (→) closure of a finite union of tiles near `x` | — | E on `finite_tiles_near` |
| `coneAt_region_eq_biUnion` | the cone is local (`coneAt (S ∩ ball x r) x = coneAt S x`) and of a finite union is the union | `coneAt_inter_ball`, `coneAt_union` | M |
| `exists_mem_coneAt_region` | points `zₙ ∈ interiorPts` within `1/n²` of `x + e(β)/n` (`dense_interiorPts`); `Finite.exists_infinite_fiber` on their colours | — | M |
| `germ_dichotomy` | branches cross `ω(p)` finitely often (`Arc.finite_inter_sphere_or_eq_circ`); a short germ avoids the crossings: inside one tile, or on an arc `circ p 1` with a strip on each side free of `Γ`, each side one tile | `strip_free_of_Γ` | M on `localSectors` |
| `Simple.coneAt_eq_angleIcc` | a Jordan boundary meets a small ball in exactly two branches at each of its points (`IsJordanDomain` transported: a point of a circle has a neighbourhood that is an interval); the tile is the sector between them | `jordan_two_branches` | H on `localSectors` |

**`Plane/SixFragment`** (each by exact arithmetic in `ℚ(√3, √7)`; rotation by `60°` maps colour `j` to `j + 1`, so validity is checked for colour 0)
| leaf | route | grade |
|---|---|---|
| `sixArcs_nondegenerate` | 19 arcs, each by `norm_num` on `e (jπ/3) ≠ 0` and the angle inequalities | E |
| `sixArcs_locallyFinite` | `sixArcs` is finite (a finite union of images of `Fin 6`): take `t = univ` | E |
| `sixCol_locallyConstant` | case split on `‖x‖ < 1`, `‖x‖ > 1`; off the arcs, `arg x / (π/3)` avoids the integers where the floor is read and the half-integers where the round is read (rays `60°j` in the disc are segments, outside lie in lenses; rays `60°j + 30°` outside lie in gaps; `arg`'s cut at `π` is a ray `60°·3`); the lens test is open off the lens sides | M–H (bookkeeping) |
| spec examples (3 open) | `Complex.arg` of `6/5`, `(6/5)e(π/6)`, `(1/2)e(7π/6)`; `round (1/2) = 1`; exact distances | E |
| `sixFrag_valid` | `sixCol x = sixCol y`, `dist x y = 1` ⟹ False: rotate to colour 0; the three tiles of colour 0 (`S_0`, `Q_4`, `G_2`): within each all distances `< 1`, across them all `> 1` (the derivation's 36 pairs, by symmetry 6) | H (exact plane geometry, six region pairs) |
| `sixFrag_nonSiamese` | distinct tiles of one colour are the cross pairs above, all distances `> 1` | M on the same pair lemmas |
| `sixFrag_coloursAt_zero` | sector `S_j` approaches `0` (points `t e(60°j + 30°)`, `t → 0`) | E |
| `sixFrag_sphere_subset_Γ` | the unit circle is an arc, `sphere 0 1 ⊆ ball 0 (3/2)` | E |
| `sixFrag_isQArc` | every colour is at `0` and `6 ≥ 4`: `IsQArc` from `IsRingArc` and `sixFrag_coloursAt_zero` | E |
| `sixFrag_isRingArc` | inner side of `r((0, π/6))` in `S_0` (colour 0), outer in `Q_0` (colour 2) — `quadRing_isRingArc`'s template | M |

**`Plane/Tiles`**
| leaf | route | grade |
|---|---|---|
| `Valid.unitPairsNull_region` | `unitPairSet (region c) = ∅` (a pair is two interior points of one colour at distance `‖e θ‖ = 1`) | E |
| `ne1_region` | CLOSURE at `U = region c` (`isOpen_region`) | E |
| `IsTile.subset_ball` | `dist_lt_one_of_isPreconnected` at `T`, external point `x`, `ne1_region` | E |
| `IsTile.closure_subset_closedBall`, `IsTile.dist_lt_one`, `IsTile.dist_le_one_of_mem_closure` | closure of a ball; `x ∈ T ⊆ cl T`; continuity | E |
| `Valid.dist_lt_or_gt_of_isPreconnected` (child, new: engine 1) | `preconnected_dist_lt_or_gt` + `ne1_region` | E |
| `unitNear_or_unitFar` | `hull2` at `A = region c` (`P = A ⊆ {d̄ > 0}`, `Q = B ⊆ densitySet`), or engine 1 twice | E |
| `unitNear_of_mem_closure`, `unitFar_of_mem_closure` | the dichotomy, and closure of a strict bound | E |
| `NonSiamese.eq_of_unitNear` | `by_contra`: a Siamese pair | E |
| `unitNear_iff_of_mem_closure_inter` | `T ~ A` ⟹ `dist t z ≤ 1`, `≠ 1` (`ne1_region`) ⟹ `< 1` ⟹ `T ~ B`; symmetric | E |
| `cluster` | near/far tiles of `𝒯` give two closed sets covering the preconnected union (`isPreconnected_closed_iff`); a common point is at distance exactly `1` from every point of `U` (≤ and ≥), against `ne1_region` | E–M |
| `Valid.wholeRestrict` | interior points shrink, colour unchanged | E |
| `wholeRestrict_covers` | engine 2 (`mem_closure_tile`) | M |
| `isTile_wholeRestrict_iff` | a tile of `F` meeting `B(p, ρ)` is open and inside the union of closures, so inside `wholeDom`; a component of `interiorPts F_ρ` lies in a tile `T` of `F`, which meets a closure `cl T′` with `T′` meeting `B(p, ρ)`, so `T = T′` | M |
| `isTile_wholeRestrict_of_mem_closure`, `NonSiamese.wholeRestrict`, `Simple.wholeRestrict` | transport through the iff (same sets, same colour, same closures in `ℂ`) | E |
| `not_mem_closure_wholeRestrict_of_inner` | `w ∈ T′ ∩ B(p, ρ)`, `T′ ⊆ B(p + 2e θ, 1)` (`IsTile.subset_ball`); parallelogram `‖w − (p + e θ)‖² = (‖w − p‖² + ‖w − p − 2e θ‖²)/2 − 1 < 1`; a point of `T` near `p + e θ` within `1` of `w`; so `T ~ T′`, against a point of `T ∩ B(p, 1)` more than `1` from `p + 2e θ` | M |
| `not_mem_closure_wholeRestrict_R₂` | the hypothesis of the pointwise form at each `θ ∈ [θ₁, θ₂]` (points `p + (1 − η)e θ′`, `θ′ → θ` inside) | E–M |

**`Plane/RingGerm`**
| leaf | route | grade |
|---|---|---|
| `not_germIn_closure_rotate` | engine 1: `z ∈ region c` within `ε` of `r(θ + s t₀)`; on `σg` the distance from `z` crosses `1` at `t₀` (chord at `60° ± s(t − t₀)`: `dist_ringPt_ringPt_cmp_one`), so for `ε` small `σg` has points on both sides | M |
| `not_mem_coloursAt_of_mem_sphere` | `ne1_region` at `x = p`, `dist z p = 1` | E |
| `isClosed_ringD` | sphere ∩ finite union of closures | E |
| `ringD_subset_Γ` | a point of `ringD` off `Γ` is interior, in `region (col x)` only; then `col x ∈ coloursAt p`, against `not_mem_coloursAt_of_mem_sphere` | E |
| `finite_ringD_off_ringArc` | `ringD_subset_Γ`, `finite_ringΓ_off_ringArc` | E |
| `germR_*` (four) | engine 1 against the germ at `r(ψ + σπ/3)`, side `s`; the geometric child `germR_geom σ s` (stated once): for `β` strictly inside the interval and `h → 0` along `β`, the germ has points nearer and farther than `1` from `y + h` — the first-order computation of § 4 made exact (`‖y + h − r(φ)‖² − 1` at `φ = ψ + σπ/3` has the sign of `−cos(β − ψ − σπ/3…)` up to `O(‖h‖²)`, and at the germ's far end the chord exceeds `1`) | M each on one H geometric child |
| `germS_absent` | the germs at `y` lie in `region X`, `region X′` (ring points off `Γ`): `not_mem_coloursAt_of_mem_sphere`; `Set.ncard` arithmetic over `Fin k` (`Set.ncard_add_ncard_compl`, `Set.ncard_pair`) | E |
| `germS_inward`, `germS_outward`, `germS_four` | transcribe `plans/FS116-N1-proof.md` § 4.1 (GERM-S, RING-GERM without non-Siamese): step 1 (a germ at `ψ ± 60°` not on a (Q) arc lies, by `germ_dichotomy`, in one class or on a ring arc not both-kind; carrying no `X′` and only absent colours it carries `X`); then GERM-R at the germs bounds which colours approach `y` in the window; `exists_mem_coneAt_region` gives a colour per direction; engine 1 places the tiles of `p` (in `B̄(y, 1)` / missing `B(y, 1)`); (iii) from (i) and (ii) and the two germs at `y` (`X`, `X′`) | **H** (the derivation's case split, three leaves) |
| `ringQPrimeS` | `germS_four`, with "a (Q) arc whose closed arc holds the point holds one of its germs" (child `germOnQ_of_onQArc`) | E–M |
| `qfree4` | transcribe § 4.2's argument (TWIST-D, N-E1, "a ring arc of `Γ` excludes its side colours `60°` away" — child `ringArc_excludes_sides`) | M–H |
| `fiveRing_no_changePoint` | a change point forces two absent colours (`germS_absent`'s first half at any `k`) | E |
| `fiveRing_finite_off_Q` | transcribe FS116-N2-FIVERING's argument (`plans/FS116-derivation.md:655`'s address): off `finite_ringΓ_off_ringArc`'s exceptions, a ring point off a (Q) arc and its `60°` partner off one force a second absent colour | M–H |
| `fiveRing_length` | `[0, 2π) ⊆ Q ∪ (Q − π/3) ∪ finite`, so `2π ≤ 2·arcLength Q` by the shift-invariance of `arcLength` on periodic sets (template: `ae_arcLength_shift_pi`) | M |
| `fiveRing_no_hub` | a hub is a change point | E |
| `sixQ_sphere_subset_Γ` | a ring point off `Γ` is interior, in some `region c`, and `c ∈ univ = coloursAt p`, against `not_mem_coloursAt_of_mem_sphere` | E |
| `sixQ_isQArc` | `IsQArc` from the arc, `hall`, `ncard univ = k ≥ 4` | E |
| `touchW` | transcribe FS116-N1-TOUCH's argument (`plans/FS116-N1-proof.md` § 4.2): the germs at `w` lie in classes (off `Γ`, not change point, `germ_dichotomy`), one colour `X`, absent; GERM-R with `c = X′` at all four germs; the `X`-clause by engine 1 (each of the four germs is at distance `1`, point by point, from the matching germ at `w` in `region X`) | H |
| `echo_unique` | engine 1 against the arc of `ω(p)` through `w` (the two germs and `w`): the distance from `z ∈ region X` near `x` has nonzero derivative along the arc unless `x − w ∥ e(ψ)`, i.e. `x ∈ {p, 2w − p}`; `p` is excluded by `X ∉ coloursAt p` | M |
| `echo_of_mem_closure`, `echo` | `echo_unique`; `essSupport ⊆ closure` (a point every ball about which meets the class in positive measure) | E |
| `ringArc_cone_inner`, `ringArc_cone_outer` | engine 1 against a short radial segment of the inner (outer) side at an angle of the arc where `h` faces away (toward) | M |
| `ringArc_sideCone_inner`, `ringArc_sideCone_outer` | the side cones meet neither closed cone (angle arithmetic on `angleIcc`, `angleIoo`) | E |
| `ringArc_sideCone_other` | `exists_mem_coneAt_region` (needs `z ∈ dom`) and the two previous | E |
| `four_of_bothKind` | one tile per colour, interval cones: a colour in both side cones would have an interval cone containing a facing cone, overlapping `c`'s or `c′`'s tile's cone in an interval — disjoint open tiles have cones with disjoint interiors at a point of the domain (child `coneAt_interiors_disjoint`, on `localSectors`) | M–H |
| `four_of_bothKind_simple` | `NonSiamese` ⟹ one tile per colour at `z` (two tiles of one colour with a common closure point are near: `unitNear_of_mem_closure`, then `eq_of_unitNear`); `Simple.coneAt_eq_angleIcc` | E on its parents |
| `flank_cone` | `t ⊆ B̄(y′, 1) ∩ B̄(y, 1)` (`IsTile.subset_ball`); the tangent cone of a closed unit disc at a boundary point (child `coneAt_subset_of_subset_closedBall`, § 4's first-order check); the end direction by closedness of the cone (child `isClosed_coneAt`) | M |
| `flank_edge_exists` | the end direction of `t`'s cone is a branch's tangent (`localSectors`) | M on `localSectors` |
| `flank_initialPieces` | § 4's shorter route: a piece of radius below `1` (or a segment, or curving away) inside `B̄(y′, 1)`… the segment and the outward arc leave the disc (so are excluded), an inward arc of radius `< 1` has a point strictly inside `B(y′, 1)`, paired with `y′ ∈ B′`; both of radius `1`: `twoCirc_cmp_one` at equal turns | M |
| `flank` | `flank_initialPieces`, `subset_closure` | E |

**`Plane/Lens`**
| leaf | route | grade |
|---|---|---|
| `exit_lens` | on `ω(y_b)`: `g = ‖γ − y_b‖²` has a local max on `Iic t_e` at `t_e` (`hin`), so `g′(t_e) ≥ 0` (`HasDerivWithinAt.norm_sq`, `IsLocalMaxOn.hasFDerivWithinAt_nonpos` with `−1 ∈ posTangentConeAt (Iic t_e) t_e` by `mem_posTangentConeAt_of_segment_subset`); the heading window `[τ − π, τ]`; the feasible arc for `y_3` is `[τ, τ + w]`, `w ≤ 2π/3` (§ 4's identities, exact); mirror on `ω(y_a)` | M–H (angle bookkeeping) |
| `exit_lens_row` | `exit_lens` with `γ′ = derivWithin …` (`ContDiffOn` gives `HasDerivWithinAt` on `Icc 0 t_e`, restricted to `Iic`-side), `hin` from the interval | E–M |

**`Plane/RingBand`**
| leaf | route | grade |
|---|---|---|
| `exists_lift` | sort `S ∩ [0, 2π)`; define `f` cell by cell with steps `±1` lifting `c`'s changes; extend by `f(θ + 2π) = f(θ) + 3W₀` | M |
| `ringband_i` | each step `≡ D_j (mod 3) ∈ {1, 2}` (`proper`); `hSum = (6 − n₂) − n₂`; `Σ D_j = f(θ + 2π) − f(θ) ≡ 0`, so `n₂ ≡ 0 (mod 3)` | E–M |
| `ringband_ii` | `Σ D_j = 3 Σ m_j + (6 − n₂) + 2n₂`; telescoping; `3 ∣` from `cast_eq` and `periodic` | E–M |
| `W_eq` | `θ ↦ f(θ + 2π) − f(θ)` is locally constant off `S` and its jumps at `x` and `x + 2π` agree (same colour change, `\|jump\| ≤ 1`); finitely many events | M |
| `ringband_iii` | near `θ₀`, only hexagon vertices in `S` can change; a lone change at vertex `j` turns `x → y` with both neighbours the third colour `z` (properness), and `z → x → z`, `z → y → z` both contribute `0` (RINGWIND's uses-only) | M |
| `ringband_iv` | the band step (FS110-N2-RING): `D₀` leaves `{3M + 1, 3M + 2}` only by a jump of `±2`, which needs a swap; induction over the events of a period (§ 6.1); then (ii) | M–H |
| `ringband_v` | no `60°` pair ⟹ no swap (a swap at `x` needs `x ± 60° ∈ S`) and no jump of `h` ((iii)); `h` constant with `n₂ ≡ 0` and the event-sum zero ⟹ `h = 0` | M |
| `ringband_vi_periodic` | reindex the hexagon sum (`Finset.sum_range_succ`, `periodic`) | E |
| `ringband_vi_noJump` | jumps of `h` over one period sum to zero (periodicity), and only `θ₀`'s class can jump ((iii)) | M |
| `exists_swap_of_abs_W_le_one`, `W_mod_six`, `exists_pair_of_abs_W_le_two` | (iv), (v), and `W_eq` (good `θ` exist: `S` finite per period) | E |
| `ring_finite_S`, `ring_locallyConstant`, `ring_proper` | `finite_ringΓ_off_ringArc` with no ring arcs; interior points; validity + `not_mem_coloursAt_of_mem_sphere` + injectivity | E |

### 6.3 Re-pricing

From the leaves, not from a table: of the 96 leaves (and the new children named above), **about 55 are E** (most a few lines on a cited lemma), **about 30 M**, and **eight H**:
`localSectors`, `Simple.coneAt_eq_angleIcc`, `sixFrag_valid`, `germR_geom`, `germS_inward`/`germS_outward`/`germS_four` (one argument),
`touchW`. Against K3's design the price moved down twice — OR1-WHOLE's covering clause leaves `finite_tiles_near` (engine 2), and the five
"N-E1 against a curve" rows share engine 1 — and up once: the sector structure is one H statement that four corollaries rest on, so it is the
critical path and goes first. Order for the implementer: `Tiles`' E leaves and engine 1 (they unblock everything) → `LocalStructure`'s
`mem_closure_tile`, `dense_interiorPts`, `finite_inter_sphere`, `finite_ringΓ_off_ringArc` → `localSectors` and its corollaries →
`RingGerm` (E leaves, then GERM-R, ECHO, U1, FLANK, then GERM-S, TOUCHW, QFREE4, FIVERING) → `Lens` → `RingBand` → `SixFragment` (independent;
can run in parallel with anything). The repository's own measured ratio (`CLAUDE.md` § What compute actually helps: kernel phases re-priced
five to thirty times lower once begun) says these grades are priced high; re-price from the first two leaves.

## Stage 7 — SAVED: the handoff to wave 3's implementer (the form of `plans/FS131-kernel-plan.md` § 6.1)

### 7.1 Where it is, and how the implementer works

**Branch `fs131-w3`, head `c5bf59b2`** (pushed; this section's commit follows it), worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3`
(its `.lake/packages` a symlink to the main tree's, its `.lake/build` its own copy — never replace it with a symlink). `main` (`da5303b4`, wave 1
landed) is merged in (`4b363881`). Wave 3 is **nine modules**: K3's foundation, sorry-free (`Plane/LocalMap`, `Plane/LocalMapExamples`,
`Plane/CircleColouring`), and this job's six skeleton modules (`Plane/LocalStructure`, `Plane/SixFragment`, `Plane/Tiles`, `Plane/RingGerm`,
`Plane/Lens`, `Plane/RingBand`) with **96 declarations using `sorry`**. The build is green with only those warnings
(`build/gate/build/20261004T062815Z-1624137.log` in the worktree). `Proofs.lean`, `ARCHITECTURE.md` § 3.11 (nine rows; `tools/check_architecture.py`
PASS) and `scripts/Axioms.lean` (45 foundation records clean, 102 skeleton records listed by `tools/fs131_k3b_decls.py`) are already updated, so
the wave lands by fast-forward once its gate is green.

**The build**: from inside the worktree, `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`;
never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on exit 75 wait ten
minutes and retry. For iteration, `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false` (the lakefile's options are not applied
otherwise); a new module's dependents can be iterated against scratch oleans (`lean -o <scratch>/Proofs/…/X.olean`, with the worktree's
`.lake/build/lib/lean/Proofs` mirrored into the scratch by `cp -rs` and the scratch first on `LEAN_PATH`) — never as evidence, and never writing
`-o` onto a mirrored (symlinked) existing module.

**The plan to work from**: § 6 (the three engines first; the leaf table per module; the order in § 6.3). The read-backs (§ 5.2) say what each
statement means; the stage-4 checks (`tools/fs131_k3b_checks.py`) are the computer-algebra form of GERM-R's, FLANK's and EXIT's geometry.

### 7.2 What the implementer may and may not change

**It may**: add lemmas (children) anywhere in the wave's modules — the three engines (`Valid.dist_lt_or_gt_of_isPreconnected`, `mem_closure_tile`,
`localSectors`) and every child § 6.2 names are expected additions; add supporting lemmas to the foundation modules (`Plane/LocalMap`, `Plane/ArcMap`,
`Plane/UnitPairs`, `Plane/Basic`, and wave 1's `Plane/Chord`, `Plane/DensityPoints` — e.g. a periodic shift lemma for `arcLength` beside
`ae_arcLength_shift_pi`); change imports (updating `ARCHITECTURE.md`'s Imports cell, and adding each new record to `scripts/Axioms.lean`); prove the
three open SIXFRAG spec examples.

**It may not**: change any statement of § 5 (the row theorems, their hypotheses and conclusions), any definition of `Plane/LocalMap`,
`Plane/CircleColouring` or `Plane/SixFragment` (`sixCol`, `sixArcs`), or the read-back conventions (§ 5.2's opening paragraph). A statement that
cannot be proved as written — a missing hypothesis, a false clause — comes back to the planner through Keryx with the counterexample or the stuck
goal; it is a finding, never a quiet edit. In particular `hz : z ∈ F.dom` in V5-U1's last clauses is already the corrected form (§ 5.3).

**The vacuity scan** (FS131-T1, landed on `main` as `49c3abb8`, so in this worktree only after the next merge from `main`) now tracks
`ArcMap.Valid`, `ArcMap.NonSiamese` and `ArcMap.Simple` as carriers. Every wave-3 theorem takes them at a variable map, so they should read
`GENERIC`; `sixFrag_valid` and `sixFrag_nonSiamese` are their inhabitant at a concrete map. Wave 3 adds predicates a theorem takes as a hypothesis
— `ArcMap.IsTile`, `ArcMap.TileOf`, `ArcMap.IsRingArc`, `ArcMap.IsQArc`, `ArcMap.IsChangePoint`, `ArcMap.IsHub`, `ArcMap.SaturatedAt`,
`ArcMap.IsEssBoundary`, `GermIn`, and the structures `CircleColouring`, `CircleColouring.Lift`: decide each IN or OUT by `scripts/Vacuity.lean`'s
procedure ("How a later wave registers its carriers"). The planner's recommendation: IN for `IsRingArc`, `IsChangePoint`, `IsHub` (each refutable
at a concrete map: `halfPlane2_not_isRingArc`, and `quadRing` has no change point), with controls; OUT for `CircleColouring` (existence is a
construction, `hexColouring`) and for `IsTile`/`TileOf`/`GermIn` (refutable only at a concrete set, which no theorem fixes); `Lift` OUT
(`exists_lift` makes it always inhabited). This is the implementer's decision to record; it changes no statement.

### 7.3 How the wave lands

1. Every `sorry` of the six modules gone; the full gate green on one commit in the worktree: `./scripts/build.sh` with zero warnings;
   `./scripts/axioms.sh` clean — the 102 skeleton records and every added child read `[propext, Classical.choice, Quot.sound]` (or fewer); no
   `native_decide`, no axiom; `./scripts/vacuity.sh` and `--self-test` green, every change in `sites` and the verdict counts explained;
   `tools/check_architecture.py` exit 0; `python3 tools/fs131_k3b_decls.py --check` exit 0 (re-run after adding records).
2. `main` merged into `fs131-w3` (resolve the append-only lines of `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`, keeping both sides);
   the gate re-run on the merged commit.
3. The branch fast-forwarded onto `main` (Keryx's step, after reading the saved gate logs). Nothing with a `sorry` reaches `main`.
4. The implementer's record lists every statement it proved, with its declaration, against § 5.2's read-back — "same statement" or the finding.
