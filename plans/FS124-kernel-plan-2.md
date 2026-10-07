# FS-124 — the kernel plan for the second module: what one piece of a colour forces at distance 1, and a close complementary pair (job FS124-K2)

*De Bruijn, the planner. Brief: `data/fs124/briefs/FS124-K2-kernel-plan.md` (on `main`). Claim list: `data/fs124/claims-K2.md`
(on `main`; nine statements: C124-SHADOW-OPEN, -CENTRE-HALF, -CENTRE, -STRADDLE, -TYPE, -FORCED-PIECES, -LONE, -BOTH, -FOUR).
Branch `fs124-wk2`, cut from `fs124-wk1` at `80ee1983`. Working files: `data/fs124/k2/`. The record is written in stages; each
is committed before the next starts.*

## Theorems this phase proved

None yet (a planning job; Stage 5 will list the leaves taken through the build to measure the price).

## Stage 1 — SAVED (FS124-K2): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/k2/readback.py <brief>` (the first module's script, with
sources looked up in this worktree, then in the main working tree) takes every quoted block with its `— source:` line and
looks for it, whitespace-normalized, in the file named: **13 of 13 found** (Kooshi's two passages; the nine statements' first
lines against `data/fs124/claims-K2.md`; `def AeProperOn`; `theorem radius_graph`). Control: `--control` changes the case of
one letter in each quotation and must find none of the thirteen — it found none (exit 0 on both runs).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; `data/fs124/claims-K2.md`; the first module's three files (`Plane/WeakColouringOn`, `Plane/Radius`,
`Plane/RadiusOutside`) and its planner's record (`plans/FS124-kernel-plan.md`); of the library, by the shape of what the
nine statements need: `Plane/Basic`, `Plane/UnitPairs`, `Plane/DensityPoints`, `Plane/Closure`, the declaration lists of
`Plane/Cover`, `Plane/Chord`, `Plane/PlaneTopology`, `Plane/LocalMap`, `Plane/LocalStructure`, `Plane/ArcMap`, `Plane/Tiles`.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — all 1847 modules already up to date, nothing built, 0 module(s) with warnings, 3s`
(`data/fs124/k2/logs/build-0-as-given.log`). No `sorry`, no warning.

**Two notes on the brief** (neither changes the job):
1. The claim list `data/fs124/claims-K2.md` and the brief are on `main` only; this branch does not hold them. I read them
   there and quote them from there.
2. The brief's `touches:` does not name `scripts/Axioms.lean` or `scripts/Assumptions.lean`; I leave both alone and list
   what a landing adds.

**Touches of fenced material, disclosed** (standing rule 8):
- At launch, the harness's context showed five commit subjects of `main`. Two are of this milestone's fenced lanes. The
  first: "FS124-P3: stage 1 — the re-read: thirteen expectations scored (five and a half missed); the map-class steps after
  the rhombus sorted by what each reads; six surprises with addresses — every held stop is the second common unit point of
  two pieced ring points whose labels are all six". What it carried: that the asking lane's re-read found, in the map class,
  stops at "the second common unit point of two pieced ring points whose labels are all six" — the configuration the last
  four statements are about, and no route to any of the nine. The second: "FS124-P3: stage 0 — the readback (11 of 11
  quotations) and thirteen expectations written before the items they are about were opened" — nothing of a route.
- 15:34 UTC, `git log --oneline -1 -- data/fs124/claims-K2.md` on `main`, run to date the claim list: it printed the first
  sixty characters of the subject "FS-124: inventory item 24 (the first module's impl…", which the launch context had
  already shown in full ("…implementer back); the kernel claim list for the second module; its planner's brief (FS124-K2),
  gate exit 0"). Nothing of a route.
- The first module's planner's record (open to me by the brief) names, in its § 4.2, the derivers' entry
  C124-EVERY-DIRECTION and its statement ("for a measurable weak colouring of a measurable `U`, every direction is good, not
  almost every one"), with the remark that its proof needs the continuity of translation in `L²`. That entry is not one of
  the nine; I note it because it is a statement of the derivers' that I have seen before phase 2.
- 15:49 UTC: the coordinator's message naming Amendment 1 of the brief (the fence extended to files written on `main`
  since launch: `plans/FS124-derivation.md`, `plans/FS124-Z1-record.md`, `data/fs124/z1/`, `plans/STUB-covering-pairs.md`,
  the blocks dated 2026-10-07 in the other stub files, the paragraphs dated 2026-10-07 in `plans/FS132-derivation.md`). I
  read the amendment in the brief and have opened none of those files. (At launch I had listed the names in
  `data/fs124/` on `main` — `briefs`, `claims-K1.md`, `claims-K2.md`, `claims.md`, `e1`, `e2`, `i1`, `k1`, `k2`, `p1`,
  `p2`, `p3`, `reports` — names only, no content.)

## Stage 2 — SAVED (FS124-K2): the definitions, the nine statements typed and read back, the skeleton (phase 1, blind)

Six modules under `Proofs/HadwigerNelson/Plane/`, registered in `Proofs.lean` and in `ARCHITECTURE.md`'s map
(`tools/check_architecture.py`: PASS). The skeleton as first typed: build under the slot exit 0, `477 of 477 batches, 6
module(s) rebuilt, 5 module(s) with warnings` — the warnings are `declaration uses sorry` and nothing else
(`data/fs124/k2/logs/build-1-skeleton.log`, commit `875aa28c6`). The skeleton after the three passes and the
coordinator's ruling: Stage 3.

| module | imports | holds |
|---|---|---|
| `Plane/CircleCrossing` | `Plane/Basic` | plane geometry, no colouring: the two sides of a unit circle, two unit circles crossing at a point, the four regions, the arc through them, two circles through a point, the tangent disc |
| `Plane/OnePiece` | `Plane/Radius`, the above | C124-SHADOW-OPEN, -TYPE, -CENTRE-HALF, -CENTRE, -STRADDLE; pieces, sides, tight pairs; the model `tightModel` |
| `Plane/ThreePiece` | `Plane/OnePiece` | the decomposition at a three-piece point, edges, separation, one-of-each, fullness, saving, arc edges; the two models |
| `Plane/ClosePair` | `Plane/ThreePiece` | close complementary pairs, labels present; C124-FORCED-PIECES, -LONE, -BOTH, -FOUR |
| `Plane/ClosePairModel` | `Plane/ClosePair` | inhabitants of the four statements' hypotheses, and the control at seven colours |
| `Plane/SectorPoint` | `Plane/ClosePair` | the claim list's sector point, the θ-lemma (one leaf, owed as its own job), C124-BOTH's second clause in the list's words |

### 2.1 The definitions, each against the list's words, each with its model

**"Almost every point of `W` has the label `i`"** is `∀ᵐ z, z ∈ W → c z = i` (plane Lebesgue measure; definitionally
`W ≤ᵐ[volume] c ⁻¹' {i}`), and "a label other than `i`" is `… → c z ≠ i`. No definition is minted for it: every
consumer filters on it directly. The colouring is the first module's total `c`, read on `U` (`AeProperOn U c`,
`IsWeakColouringOn U c`).

**The side of a unit circle** (`CircleSide`, mine; the list says "inside `S(w)`", "outside `S(w)`", "a side of `S(y)`").
`inside.region w = ball w 1`, `outside.region w = (closedBall w 1)ᶜ`, `flip`, `sign`. It is in the statements
because C124-LONE quantifies over "a side of `S(y)`", and it is in the proofs because every argument here is one
argument at the two sides.

**The unit circles about `p` and `q` cross at `z`** (`CrossAt p q z`, mine): `dist z p = 1`, `dist z q = 1`, `p ≠ q`,
`p + q ≠ 2 z`. C124-STRADDLE's "`p ≠ q` and `p ≠ 2z − q`" and a close pair's "`0 < |x − y| < 2`" at a common unit point
are both this (`crossAt_of_dist_lt_two`). Model: `crossAt_zero_one_add_I`. Adversaries: a circle with itself; two
circles tangent from outside.

**A piece of label `i` at `x`** (`IsPieceAt U c x P i`, mine — it is C124-TYPE's hypothesis, word for word: "P a
connected open subset of U almost every point of which has the label i, x a point of the closure of P"). Preconnected
is asked; non-empty follows from the closure. Model: the tangent discs inside `tightModel`'s collars; the pieces of
the two three-piece models.

**Inner, outer, crossing** (`InnerAt P w := P ⊆ closedBall w 1`, `OuterAt P w := Disjoint P (ball w 1)`,
`CrossingAt P w := ¬ InnerAt P w ∧ ¬ OuterAt P w`): "inner at `w` if `P ⊂ B̄(w, 1)`, outer at `w` if `P ∩ B(w, 1) = ∅`,
and crossing at `w` otherwise". `crossingAt_iff` is the list's gloss "(it has a point strictly inside and a point
strictly outside `S(w)`)"; `not_innerAt_and_outerAt` is "a non-empty open set lies on no circle, so every piece is
exactly one of the three". `OnSide σ P w` is inner for `σ = inside`, outer for `σ = outside` (by `Iff.rfl`). The list
asks `|w − x| = 1` in the definition; the predicates do not (no statement needs it there). Spec examples: a small disc
about `0` is inner at `0`, not outer, not crossing; a disc about `1` is crossing at `0`.

**A tight pair with its collars** (`IsTightWith U c q z a b ρ`, `IsTight U c q z a b := ∃ ρ, …`, `innerCollar q z ρ =
ball z ρ ∩ ball q 1`, `outerCollar q z ρ = ball z ρ \ closedBall q 1`): "`|q − z| = 1` and `z` in `U`, and `a ≠ b` …
there is `ρ > 0` with `B(z, ρ) ⊂ U` such that almost every point `w` of `B(z, ρ)` with `|w − q| < 1` has the label `a`
and almost every point `w` of `B(z, ρ)` with `|w − q| > 1` has the label `b`". `z ∈ U` is derived (`IsTightWith.mem`).
That `c` is a weak colouring of `U` is a hypothesis of the theorems, not a field. Not defined, because no statement of
the nine reads them: the rhombus completions, kind both. Model: `isTight_tightModel` — on three discs of radius `1/10`
about `0`, `1`, `1 + i`: near `1` the label `0` inside the unit circle about `0` and `1` outside it, elsewhere `2`; the
pair `(0, 1)` is tight for `(0, 1)`, and `1 + i` is a point of the unit circle about `1` other than `0` and `2` (for
C124-STRADDLE). Adversary: no pair is tight for `(a, a)`.

**A three-piece point with a decomposition and its edges** (`ThreePiece U c x`, data: `nbhd`, `piece : Fin 3 → Set ℂ`,
`label : Fin 3 → α`; `IsThreePiecePoint U c x := Nonempty …`; `D.edge i j = closure (piece i) ∩ closure (piece j) ∩
nbhd`). Fields, against "a point x of U with a neighbourhood that is, up to a null set, the union of three connected
open sets, each with x in its closure and one label almost everywhere, the three labels distinct": `nbhd ∈ 𝓝 x`,
`nbhd ⊆ U`, `piece i ⊆ nbhd`, open, preconnected, `x ∈ closure (piece i)`, `∀ᵐ z, z ∈ piece i → c z = label i`,
`label` injective, `volume (nbhd \ ⋃ i, piece i) = 0`. **Two readings, confirmed by the coordinator as the list's**: `N`
is any neighbourhood of `x` inside `U` (not asked open) with the pieces inside it and `N` minus the pieces null. The
pieces' disjointness is a lemma (`disjoint_piece`: "two open sets with different labels almost everywhere are
disjoint").

**The two kinds of model of a three-piece point** (the brief asks exactly what each is):
- *an ordinary three-sector point* — `sectorPoint`: at `0`, in the disc of radius `1/4` (which holds no unit pair, so
  every measurable colouring is a weak colouring of it), the three open sectors cut by the rays along `1`, `i` and
  `−1 − i`: `{0 < re ∧ 0 < im}`, `{re < 0 ∧ re < im}`, `{im < 0 ∧ im < re}` — each an intersection of two half-planes,
  convex. Each edge is a radius: arc-edged, hence full. It is also the list's sector point (`sectorPoint_isSector`,
  `Plane/SectorPoint`).
- *a three-piece point by the letter only* — `petalPoint`: at `0`, in the same disc, two triangular petals
  `|im| < re < 1/8` and `|im| < −re < 1/8`, and the rest `{|re| < |im| ∨ 1/8 < |re|}`, which is connected around the
  petals' far sides (its two wedges meet its two caps inside the disc). The two petals' closures meet at `0` only
  (`petalPoint_edge`), so it is **not full** (`petalPoint_not_isFull`). This is the list's bowtie "when its two
  `a`-sectors are joined inside the neighbourhood": the joined piece is the sea.

**A close complementary pair and its common unit points** (`ClosePair U c x y`: `left`, `right`, `x ≠ y`, `dist x y <
2`, `∀ i j, left.label i ≠ right.label j`; `IsCommonUnitPoint x y w := dist w x = 1 ∧ dist w y = 1`). "Two three-piece
points x, y with 0 < |x − y| < 2 whose six labels are distinct" — each member's three by `label_injective`, across by
`label_ne`. "Its common unit points are the two points" is `exists_isCommonUnitPoint`. The definition does not ask the
common unit point to lie in `U`; the statements do. Adversaries: no point is a close pair with itself; `2` is not a
common unit point of `0` and `1 − i`.

**A member that separates** (`D.SeparatesAt w := ∃ i j, InnerAt (piece i) w ∧ OuterAt (piece j) w`); **one inner, one
outer, one crossing** (`D.OneOfEach w σ`, `σ : Equiv.Perm (Fin 3)`: `σ 0` inner, `σ 1` outer, `σ 2` crossing — a
bijection between the pieces and the three kinds, which is what "exactly one … one … one" says, and it names the
pieces whose labels the conclusions use); **a full member** (`D.IsFull := ∀ i j, i ≠ j → x ∈ closure (D.edge i j \
{x})`: "for every two of its pieces x is a limit of points other than x of their edge"); **saved** (`D.Saves w := ∃ i
j, i ≠ j ∧ HasUnitArcFrom (D.edge i j) w x`, where `HasUnitArcFrom E w x` says the points `w + (x − w) e(s t)`, `0 ≤ t ≤
δ`, are in `E` for a turning sense `s = ±1` and some `δ > 0`: "some edge of x contains an arc of the unit circle about
w with an end at x"). The pattern (a pair of counts) is not defined: no statement of the nine reads it.

**A sector point** (`ThreePiece.IsSector`, `Plane/SectorPoint`): `∃ r > 0, ∃ J : Fin 3 → C(unitInterval, ℂ)`, each
injective, `J m 0 = x`, `dist (J m 1) x = r`, `dist (J m t) x < r` for `t ≠ 1`, two different arcs meeting at `x`
only, each piece a `connectedComponentIn (ball x r \ ⋃ m, range (J m))`, and the pieces' union that complement. Word
for word the list's sentence, an arc being an injective continuous image of `[0, 1]`. Model: `sectorPoint_isSector`.

**Present** (`presentAt U c w := {i | w ∈ essSupport (U ∩ c ⁻¹' {i})}`, `essSupport` being `Plane/UnitPairs`' "points
every open ball about which meets the set in positive measure"): "a label is present at a point when the point lies
in the closed essential support of its class". Confirmed by the coordinator as the list's reading. Spec example: a
constant colouring has exactly its one label present at each point of an open set.

### 2.2 The nine statements typed, read back clause by clause

Each claim has two declarations: the statement **in the form my route gives** (for `AeProperOn U c` at any label
type; no measurability), and the claim **in the list's words** as its corollary at `IsWeakColouringOn U c` with labels
`Fin k` (or `Fin 6`). The second is the one read back here; its docstring quotes the claim.

**C124-SHADOW-OPEN** — `shadow_open` (core: `AeProperOn.ae_unitShadow_ne`, proved).
```lean
theorem shadow_open {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {W : Set ℂ}
    (hW : IsOpen W) (hWU : W ⊆ U) {i : Fin k} (hi : ∀ᵐ z, z ∈ W → c z = i) :
    IsOpen (U ∩ unitShadow W) ∧ ∀ᵐ z, z ∈ U ∩ unitShadow W → c z ≠ i
```
"U an open set" `hU`; "c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair"
`hc`; "W an open subset of U almost every point of which has the label i" `hW`, `hWU`, `hi`; "the set of points of U
at distance exactly 1 from some point of W" is `U ∩ unitShadow W` (`unitShadow`, `Plane/Cover`: `{z | ∃ y ∈ F, dist z y
= 1}`); "is open, and almost every point of it has a label other than i". *Not claimed, not said*: nothing for a
non-open `W`; nothing at a point whose unit circle meets only the boundary of `W`; no existence. **Does not spend six.**

**C124-TYPE** — `piece_type` (core: `IsPieceAt.ae_ne_region`, proved).
```lean
theorem piece_type {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {P : Set ℂ}
    (hPo : IsOpen P) (hPc : IsConnected P) (hPU : P ⊆ U) {i : Fin k} (hi : ∀ᵐ z, z ∈ P → c z = i) {x w : ℂ}
    (hx : x ∈ closure P) (hw : w ∈ U) :
    ((∃ y ∈ P, dist y w < 1) → ∃ η > 0, ∀ᵐ z, z ∈ ball w η → 1 < dist z x → c z ≠ i) ∧
      ((∃ y ∈ P, 1 < dist y w) → ∃ η > 0, ∀ᵐ z, z ∈ ball w η → dist z x < 1 → c z ≠ i)
```
Every clause as worded, **except that `|w − x| = 1` is not a hypothesis** (generalization G3: the proof does not read
it, and with it as a binder the linter would report an unused argument). *Not claimed, not said*: nothing for a piece
not connected or not open; no uniform `η`; nothing on the side not named. **Does not spend six.**

**C124-CENTRE-HALF** — `centre_half` (core: `AeProperOn.ae_ne_of_ae_region`).
```lean
theorem centre_half {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ}
    (hq : q ∈ U) (hqz : dist q z = 1) {ρ : ℝ} (hρ : 0 < ρ) (hball : ball z ρ ⊆ U) (a : Fin k) :
    ((∀ᵐ w, w ∈ ball z ρ → dist w q < 1 → c w = a) → ∃ η > 0, ∀ᵐ p, p ∈ ball q η → 1 < dist p z → c p ≠ a) ∧
      ((∀ᵐ w, w ∈ ball z ρ → 1 < dist w q → c w = a) → ∃ η > 0, ∀ᵐ p, p ∈ ball q η → dist p z < 1 → c p ≠ a)
```
"q and z points of U" — `hq`, and `z ∈ U` from `hρ`, `hball`; the rest word for word. *Not claimed, not said*: nothing
about the other collar; not that the pair is tight. **Does not spend six.**

**C124-CENTRE** — `tight_centre` (core: `IsTight.ae_ne_centre`).
```lean
theorem tight_centre {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ}
    (hq : q ∈ U) {a b : Fin k} (ht : IsTight U c q z a b) :
    ∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w ≠ a) ∧ (∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠ b)
```
`|q − z| = 1` and `z ∈ U` are carried by `IsTight`. *Not claimed, not said*: that `a` or `b` is present at `q`; anything
about other labels near `q`. **Does not spend six.**

**C124-STRADDLE** — `tight_straddle` (core: `IsTight.ae_ne_straddle`).
```lean
theorem tight_straddle {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ}
    {a b : Fin k} (ht : IsTight U c q z a b) {p : ℂ} (hp : p ∈ U) (hpz : dist p z = 1) (hpq : p ≠ q)
    (hanti : p ≠ 2 * z - q) : ∃ η > 0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b
```
Word for word ("weak k-colouring of U": `U` open, as the class is defined). *Not claimed, not said*: no uniform `η`;
nothing at `q` or at `2z − q`. **Does not spend six.**

**C124-FORCED-PIECES** — `closePair_forced_pieces` (core: `ClosePair.separatesAt_or`, over `exists_onSide_of_cover`).
```lean
theorem closePair_forced_pieces {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c)
    {x y w : ℂ} (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) :
    (∃ i j, InnerAt (C.left.piece i) w ∧ OuterAt (C.left.piece j) w ∧ C.left.edge i j ⊆ sphere w 1) ∨
      ∃ i j, InnerAt (C.right.piece i) w ∧ OuterAt (C.right.piece j) w ∧ C.right.edge i j ⊆ sphere w 1
```
"x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open
unit disc about w; the edge of those two pieces lies on S(w)". *Not claimed, not said*: which member; that both do;
that the edge is more than the point; nothing at seven. **Spends six, in `ClosePair.exists_label_eq`** — six distinct
labels among six, so every label is a piece's.

**C124-LONE** — `closePair_lone` (core: `ClosePair.lone_of_cover`).
```lean
theorem closePair_lone … (hy : ¬ C.right.SeparatesAt w) :
    ∃ σ : Equiv.Perm (Fin 3), C.left.OneOfEach w σ ∧
      (∃ τ : CircleSide, ∃ η > 0,
        (∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)) ∧
          ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = C.left.label (σ 1)) ∧
      ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
        C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
          Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
          closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x}
```
"x has exactly one inner piece, one outer piece and one crossing piece at w" — `σ`; "with labels a and b for the inner
and the outer one" — `label (σ 0)`, `label (σ 1)`; "a side of S(y) and η > 0 such that almost every point of B(w, η) on
that side has the label a if it lies inside S(x) and the label b if it lies outside S(x)" — `τ`, `η`; "a point w′ ≠ w
of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint
from B(w, 1) ∪ B(w′, 1), and their closures meet at x only". *Not claimed, not said*: nothing about the edges of the
crossing piece; not that `(x, w′)` is tight on both sides of `S(y)`. **Spends six in the same one line.**

**C124-BOTH** — `closePair_both_separate` (first clause; core: `ClosePair.separatesAt_right_of_isFull`) and
`closePair_both_saved` (second clause, **for arc-edged decompositions**, by the coordinator's ruling — § 2.4), with
`closePair_both_saved_of_isSector` (`Plane/SectorPoint`) the clause in the list's words over the θ-lemma.
```lean
theorem closePair_both_separate … (hfx : C.left.IsFull) (hfy : C.right.IsFull) :
    C.left.SeparatesAt w ∧ C.right.SeparatesAt w
theorem closePair_both_saved … (hax : C.left.HasArcEdges) (hay : C.right.HasArcEdges) :
    C.left.Saves w ∧ C.right.Saves w
```
*Not claimed, not said*: that exactly one edge of each lies on `S(w)`; anything when a member is not full. **Spends
six in the same one line.**

**C124-FOUR** — `closePair_four` (core: `ClosePair.presentAt_eq`, `ClosePair.ncard_inner_outer`).
```lean
theorem closePair_four … (hfx : C.left.IsFull) (hfy : C.right.IsFull) {σ τ : Equiv.Perm (Fin 3)}
    (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} ∧
      (presentAt U c w).ncard = 4
```
"exactly four labels are present at w: those of the two inner and the two outer pieces". *Not claimed, not said*: which
label fills which region; that each region carries one label. **Spends six in the same one line.**

### 2.3 What the typing found (sent to the coordinator at 15:52 UTC, before this stage's commit)

No statement defect: each of the nine survives typing, none is vacuous (§ 2.5), and I reach each by a route of my
own. Generalizations — each is what my route uses, and each has its declaration in the skeleton:

- **G1. Measurability of `c` is idle in all nine.** C124-SHADOW-OPEN is one Fubini slice read forwards (a null set
  of pairs has almost every slice null, `Measure.measure_ae_null_of_prod_null`, which asks no measurable set), and the
  other eight are derived from it. `AeProperOn.ae_unitShadow_ne`: any function, any label type; `U` need not be open
  for the almost-everywhere clause.
- **G2. Finiteness of the label set is idle** in SHADOW-OPEN, TYPE, CENTRE-HALF, CENTRE, STRADDLE — and in the last
  four as well once the cover sentence of G5 is the hypothesis (the families of pieces are finite; the labels need
  not be).
- **G3. C124-TYPE: `|w − x| = 1` is not used.** The statement holds at every `w ∈ U`. Connected is read as
  preconnected. A corollary at `w = x`, free: a piece at a point of `U` lies in the closed unit disc about the point
  (`IsPieceAt.innerAt_self`).
- **G4. TYPE is the one principle, and its two clauses are one statement**: a piece at `x` that is **not** on the
  closed side `σ` of `S(w)` has its label almost nowhere on the side `σ` of `S(x)` near `w` (`IsPieceAt.ae_ne_region`,
  proved). CENTRE-HALF is TYPE applied to the disc tangent to `S(q)` at `z` inside the collar (a convex piece at `z`);
  CENTRE is CENTRE-HALF twice; STRADDLE is the shadow at a crossing of two circles.
- **G5. The last four spend six in one sentence** — "every label is the label of a piece of `x` or of a piece of
  `y`" (`ClosePair.exists_label_eq`). From that sentence as a hypothesis all four hold at any label type.
  FORCED-PIECES then holds for any two finite families of pieces at `x` and `y` (`exists_inner_outer_of_cover`) and
  reads neither the cover clause of a decomposition nor the distinctness of the labels at one point; LONE and FOUR
  read the cover clause at the member with three pieces.
- **G6. The quadrant lemma** (`exists_onSide_of_cover`): for every choice of a side `σ` of `S(x)` and a side `τ` of
  `S(y)` there is a piece of `x` on the closed side `σ` of `S(w)` or a piece of `y` on the closed side `τ` of `S(w)`.
  FORCED-PIECES is its consequence by logic alone. **Under it, with no cover hypothesis at all**
  (`ae_onSide_of_label`, found by the pass on the model, § 3.3): near `w`, almost every point on the side `σ` of
  `S(x)` that carries the label of a piece of `x` has that piece on the closed side `σ` of `S(w)`. At seven labels
  this still holds, and says what the seventh label must fill.
- **G7. C124-BOTH's first clause, finer**: if `x` is full then `y` separates at `w`
  (`ClosePair.separatesAt_right_of_isFull`).
- **G8** (found after the message; for the report). **`a ≠ b` is idle in C124-CENTRE and C124-STRADDLE**: both hold
  for a pair "tight for `(a, a)`" (a disc about `z` of one label), where they say the shadow of that disc. The
  definition keeps `a ≠ b`, as the list's does.

**The step that is not routine** — C124-BOTH's second clause for the list's sector points: § 2.4.

### 2.4 The sector clause: the coordinator's ruling, and what the θ-lemma needs

For a sector point as the list defines it (three arcs from `x` to the rim; the three components of the cut disc are
the pieces), "the edge of two pieces contains an initial part of one of the three arcs" is the θ-curve fact: each of
three arcs from the centre of a disc to its rim borders exactly two of the three complementary components, and every
two components share one. Jordan-grade; not in Mathlib. The list's remark "a sector point is full" needs the same
fact.

**The ruling** (the coordinator, received between 15:52 and 16:00 UTC, nothing in it from the fenced files): take
(b) — state the second clause for what it consumes, a decomposition each of whose edges contains an arc from the
point (`ThreePiece.HasArcEdges`), and state "the list's sector point is such a decomposition" as its own theorem over
the one leaf, in a module of its own, not planned further in this job; the bridge is owed as a kernel job, not
waived. Done: `closePair_both_saved` (`Plane/ClosePair`) takes `HasArcEdges` and reads nothing of `Plane/SectorPoint`;
`ThreePiece.IsSector.hasArcEdges` is the leaf; `closePair_both_saved_of_isSector` is the clause in the list's words.
**Which models have arc edges by construction**: `sectorPoint` (its edges are radii: `sectorPoint_hasArcEdges`) and
the planned witness of `exists_closePair_full` (its edges are arcs of unit circles); `petalPoint` does not (it is not
full).

**What the θ-lemma needs from `Plane/PlaneTopology`, as I see it** (a sketch, one mind, not attempted):
1. *The piece at a rim arc.* The three far ends cut the rim into three open arcs. A rim point off the far ends has a
   half-disc neighbourhood missing the (compact) arcs, so the pieces near each open rim arc are one piece; elementary.
2. *The three are different.* A path in one piece between points near two different rim arcs, closed up by two radial
   segments, is a continuum in the closed disc joining rim points that interleave with the far ends of two of the
   arcs, so it meets their union: `inter_nonempty_of_interleaved` (two continua in a closed disc joining interleaved
   points of its circle meet). So the three pieces are the pieces at the three rim arcs.
3. *Each arc borders its two neighbours.* For a point `t` of the arc `J_m` and the piece `Π` at a rim arc ending at
   `J_m`'s far end: if a disc about `t` missed `Π`, the part of `J_m` beyond `t` together with that disc would let a
   continuum pass from the other neighbour to the third piece's rim arc without meeting the two arcs that separate
   them — the same crossing lemma, with `isPreconnected_frontier_connectedComponentIn` (the frontier of a
   complementary component of a closed preconnected set is preconnected) to keep the frontier of `Π` in one piece
   along `J_m`. This is the step I have not made precise.
4. Not in that module, as far as its header says: that an arc has empty interior in the plane (needed to know every
   point of an arc is a limit of pieces; near `x` it follows from `null_diff`), and a statement that the union of
   three arcs and the outside of the disc is closed and preconnected (elementary).
My estimate: several hundred lines, a job with its own planner. It is not short from what the module holds.

### 2.5 No statement is empty: the models, and what they cost

- SHADOW-OPEN, TYPE, CENTRE-HALF, CENTRE, STRADDLE: `tightModel` on `tightModelDom` satisfies every hypothesis of
  each at once (`isWeakColouringOn_tightModel`, `isTight_tightModel`; three spec examples run the theorems on it).
- FORCED-PIECES and LONE: `exists_closePair_not_separatesAt` — a weak six-colouring with a close complementary pair
  and a common unit point in the set at which the second member does not separate. **The witness I planned** (three
  discs of radius `δ` about `x`, `y`, `w`, with `|x − y| ≠ 1` so that unit pairs join only the disc about `w` to the
  other two): near `w`, the label `a` inside `S(x)` and `b` outside it; at `x`, a petal toward `w` (label `a`: the
  points `x + s ν`, `0 < s < δ/2`, `⟨ν, w − x⟩ > 2δ`), a sector away from `w` (label `b`), the rest (label `c`,
  connected around the petal); at `y`, an ordinary three-sector point with no inner piece at `w` (labels `d`, `e`,
  `f`, none used near `w`). Properness is two crude inequalities (`|z − t| < 1` for `z` inside `S(x)` near `w` and `t`
  in the petal; `> 1` for `z` outside and `t` in the back sector).
- BOTH and FOUR: `exists_closePair_full` — both members arc-edged, each with one piece of each kind. **The witness I
  planned**: the unit square `x = 0`, `w = 1`, `y = 1 − i`. Near `w` the four regions cut by `S(x)`, `S(y)` carry
  `a` (inside both), `d` (outside `S(x)`, inside `S(y)`), `b` (outside both), `e` (inside `S(x)`, outside `S(y)`). At
  `x`: `c` inside `S(i)`; `a` inside `S(1)` and outside `S(i)`; `b` outside both. At `y`: `f` inside `S(−i)`; `d`
  inside `S(1)` and outside `S(−i)`; `e` outside both. Four checks, by hand, one mind: `a` against `a` is the duality
  of the two lenses of the unit square (for `|t − 1| < 1`, `|t + i| < 1`, `|z| < 1`, `|z − (1 − i)| < 1`: in
  coordinates centred at the square's centre and turned by `π/4`, `|z − t|² < 1 − |ζ₁|(√2 − 2|τ₁|) − |τ₂|(√2 − 2|ζ₂|)
  ≤ 1`), with a crude bound on the cusp of `a` outside `S(−i)`; the other three are of the same kind (boundary cases
  computed: `1 ± 2σφ` to second order). **This witness is the expensive leaf of the module** (§ 3.2).
- The control on six: `exists_closePair_seven_not_separatesAt` — with seven colours and the seventh label on the
  whole disc about `w`, two ordinary three-sector points with no inner piece at `w`: neither separates. So
  FORCED-PIECES is false at seven as it stands, as its not-claimed line says.

## Stage 3 — SAVED (FS124-K2): the plan per leaf, the three passes, phase 1 closed (blind)

The skeleton after the passes and the ruling: six modules, 134 leaves carrying a `sorry` (25 + 42 + 29 + 32 + 3 + 3;
a decomposition given as data counts once), six leaves proved (§ 3.6). Build under the slot, exit 0: `build: OK — 477 of
477 batches, 7 module(s) rebuilt, 6 module(s) with warnings, 9m6s`; every warning is `declaration uses sorry` (the
full log replays each module's warnings once per dependent, so its 712 lines are 25, 42, 29, 32, 3 and 3 distinct
declarations: `data/fs124/k2/logs/build-2-skeleton.log`, `build-2-skeleton-full.log`). `tools/check_architecture.py`:
PASS.

### 3.1 The routes, in one paragraph each (mine, found blind)

**SHADOW-OPEN.** The set `T` of pairs `(z, θ)` with `z ∈ U`, `c z = i`, `z + e θ ∈ W` is null for Lebesgue measure on
`ℂ × ℝ`: such a pair is monochromatic for `U` (`aeProperOn_iff_volume`), or its far end is a point of `W` off the
label `i`, and those pairs are the preimage of a null set under `q ↦ motionMul q (1, 0)`, which preserves the measure
(`measurePreserving_motionMul_right`, first module). So for almost every `z` the slice `{θ | (z, θ) ∈ T}` is null
(`Measure.measure_ae_null_of_prod_null`: no measurable set asked). For `z` in the shadow with `z ∈ U`, `c z = i` the
slice is `{θ | z + e θ ∈ W}`: open (`W` is) and non-empty (`exists_angle_of_norm_eq_one`), so of positive measure. The
shadow is open as `sphere 0 1 + W`.

**TYPE.** A preconnected set with a point strictly inside and one strictly outside the unit circle about `z` has a
point on it (`preconnected_dist_lt_or_gt`, `Plane/DensityPoints`). If the piece `P` at `x` has a point `y₀` strictly on
the other side `σ.flip` of `S(w)`, the same holds for `S(z)`, `z` near `w` (an open condition on `z`); if moreover `z`
is on the side `σ` of `S(x)`, then `x` is on the side `σ` of `S(z)` and so is a point of `P` near `x`. So `S(z)` meets
`P`: `z` is in the shadow of `P`, where the label is almost nowhere.

**CENTRE-HALF, CENTRE.** The disc of radius `r ≤ min(ρ, 1)/2` tangent to `S(q)` at `z` on the side `σ` is an open
convex subset of the collar with `z` in its closure: a piece at `z`, strictly on the side `σ` of `S(q)`, hence not on
the closed side `σ.flip`. Its type, read at `w := q`: its label is almost nowhere on the side `σ.flip` of `S(z)` near
`q`. CENTRE is the two sides.

**STRADDLE.** `S(p)` and `S(q)` cross at `z`, so `S(p)` has a point near `z` strictly inside `S(q)` and one strictly
outside (`CrossAt.exists_mem_sphere_region`: an intermediate value along the convex set `ball z ρ ∩ ball q 1` between
two explicit points; the outside from the inside at the antipode of `q`). So `p` is in the shadow of each collar; the
shadows are open; intersect.

**The geometry.** For unit vectors `u`, `v` and signs `s`, `t`: `‖u + ε(su + tv)‖² − 1 = 2ε(1 + st⟪u, v⟫)(s + ε)`
(proved). With `|⟪u, v⟫| < 1` (proved: `u ≠ ±v`) and `0 < ε < 1` its sign is `s`: the point `z + ε(±(z − p) ± (z − q))`
lies in the chosen one of the four regions.

**FORCED-PIECES.** `ae_onSide_of_label`: near `w`, almost every point on the side `σ` of `S(x)` carrying the label of
a piece of `x` has that piece on the closed side `σ` of `S(w)` (TYPE for each piece and side, finitely many radii).
With the cover sentence, a region `(σ, τ)` with no piece of `x` on the closed side `σ` and no piece of `y` on the
closed side `τ` would be null; it has positive measure. A pair of which neither member separates leaves such a region.

**LONE.** `y` does not separate: a closed side `τ₀` of `S(w)` holds no piece of `y`. Then on the side `τ₀` of `S(y)`
near `w` every label is a label of `x`, by sides of `S(x)` (`ae_label_left_of_forall_not_onSide`); both sides have
positive measure there, so `x` has an inner piece `i₀` and an outer piece `j₀`. If the third piece were inner too, the
outside of `S(x)` on that side of `S(y)` would carry the label of `j₀` alone, while the cover gives the whole outside
of `S(w)` near `x` to `j₀`; take `w′ ≠ w` on `S(x)` near `w` on that side of `S(y)`: CENTRE-HALF at the centre `x` with
the far end `w′` takes the label of `j₀` off the inside of `S(w′)` near `x`, and the region outside `S(w)` and inside
`S(w′)` has positive measure at `x` (the circles about `w`, `w′` cross there) — contradiction
(`ThreePiece.exists_ne_not_onSide_of_ae_side`); the same with the sides exchanged if it were outer. So it is crossing.
The side clause is then the labels of `i₀`, `j₀`. For the last clause the same `w′` is the far end of a pair `(x, w′)`
tight for the two labels: CENTRE confines the inner piece to `B̄(w′, 1)` and the outer piece to the complement of
`B(w′, 1)` near `x` (an open set almost every point of which has a label and not that label is empty), and
`S(w) ∩ S(w′)` is `{x}` near `x`.

**BOTH.** First clause: if `y` did not separate, LONE's last clause would make the edge of the inner and the outer
piece of `x` the point `x` alone near `x`; `x` is full. Second clause (arc-edged members): both separate; the edge of
the inner and the outer piece lies on `S(w)` and contains an arc from the point; an injective path from `x` on a
circle contains an arc of the circle from `x` (the argument of `(γ u − w)/(x − w)` is continuous and injective near
`u = 0`, so monotone, so it covers an interval `[0, θ₀]` or `[θ₀, 0]`).

**FOUR.** A crossing piece's label is almost nowhere near `w` (TYPE at both sides; the circle is null), so only the
four labels can be present. If the inner label of `x` were absent near `w`, the inside of `S(x)` near `w` would carry
the inner label of `y` inside `S(y)` and its outer label outside: the last clause of LONE for `y` (the roles of the
two circles exchanged) would contradict the fullness of `y`. Likewise for the other three.

### 3.2 The leaves

*Size is lines of proof. Every Mathlib name was `#check`ed at this pin against this worktree's build
(`data/fs124/k2/lean/checks1.lean`, `checks2.lean`) or is used in a probe that elaborates (`Probe1.lean`,
`Probe2.lean`). Each file's order is a valid order of proof.*

**`Plane/CircleCrossing`** (25 leaves, about 150 lines)

| leaf | route | size |
|---|---|---|
| `mem_region_inside`, `_outside`, `flip_flip`, `mem_region_comm`, `isOpen_region` | `simp [CircleSide.region]` (`mem_ball`, `mem_closedBall`, `not_le`, `dist_comm`); `cases σ <;> rfl`; `isOpen_ball`, `isClosed_closedBall.isOpen_compl` (the last two as in `Probe2`) | 1–3 each |
| `mem_region_iff`, `disjoint_region_flip`, `mem_region_or_of_dist_ne` | `cases σ`; `simp [sign]`; `Set.disjoint_left`; `lt_or_gt_of_ne` | 2–4 each |
| `ball_antipode_subset_outside` | `dist q (2 * z - q) = 2` (`dist_eq_norm`, the difference is `2 • (z − q)`); `dist_triangle` | 8 |
| `CrossAt.symm`, `CrossAt.antipode`, `crossAt_of_dist_lt_two` | fields; `add_comm`; if `x + y = 2 w` then `dist x y = 2` | 2, 8, 6 |
| `CrossAt.abs_inner_lt_one` | `abs_real_inner_lt_one` at `z − p`, `z − q` (norms from `dist_eq_norm`; `≠` from `ne`, `ne_antipode`) | 6 |
| `CrossAt.quadPt_mem_region_left` | `mem_region_iff`; `dist_eq_norm`, the difference is `u + ε • (s • u + t • v)`; `norm_sq_quadrant`; then `0 < s (‖·‖ − 1)` from `0 < s (‖·‖² − 1) = 2ε(1 + st r)(1 + sε)` (`cases σ`, `cases τ`, `nlinarith` on a goal carrying only `ε`, `r`, the norm) | 15 |
| `CrossAt.quadPt_mem_region_right` | `quadPt p q z σ τ ε = quadPt q p z τ σ ε` (`add_comm`), `h.symm` | 4 |
| `dist_quadPt_le` | `norm_smul`, `norm_add_le`, the two radii of norm `1` | 6 |
| `CrossAt.exists_mem_quadrant` | `ε := min (ρ / 4) (1 / 2)`; the three above | 6 |
| `CrossAt.volume_quadrant_pos` | the set is open and non-empty: `IsOpen.measure_pos` | 4 |
| `CrossAt.exists_mem_sphere_region` | inside: `((convex_ball z ρ).inter (convex_ball q 1)).isPreconnected.intermediate_value` between the quadrant points (inside, inside) and (outside, inside) for `fun y => dist y p`; outside: the inside case of `h.antipode` and `ball_antipode_subset_outside` | 18 |
| `exists_ball_inter_spheres_subset` | `p₂ := w + w' − x`; if `p₂ ≠ x`: `η := dist x p₂` and `EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two Complex.finrank_real_complex`; if `p₂ = x` (tangent): `parallelogram_law_with_norm` gives `t = x`, `η := 1` | 20 |
| `exists_convex_subset_region` | `D := ball (z + (σ.sign * r) • (z − q)) r`, `r := min ρ 1 / 2`; `convex_ball`; `closure_ball`; the centre is at distance `1 + σ.sign r` from `q` | 18 |
| `exists_dist_ne_of_isOpen` | `Measure.addHaar_sphere volume w r` against `IsOpen.measure_pos` | 6 |
| `crossAt_zero_one_add_I`, two examples | `norm_num`, `Complex.ext_iff`, `dist_eq_norm` | 3–6 each |

**`Plane/OnePiece`** (42 leaves, about 230 lines)

| leaf | route | size |
|---|---|---|
| `isOpen_unitShadow`, `unitShadow_mono`, `mem_unitShadow_iff_exists_e` | `unitShadow W = sphere 0 1 + W` (as inside `isClosed_unitShadow`, `Plane/CoverExamples`), `IsOpen.add_left`; `exists_angle_of_norm_eq_one` | 6, 1, 6 |
| `shadow_open` | `⟨hU.inter (isOpen_unitShadow hW), hc.aeProperOn.ae_unitShadow_ne hW hWU hi⟩` | 1 |
| `eq_empty_of_isOpen_of_ae` | `W` is null (`measure_mono_null` into the two exceptional sets) and open: `IsOpen.measure_pos` | 6 |
| `not_innerAt_iff`, `not_outerAt_iff`, `crossingAt_iff`, `innerAt_or_outerAt_or_crossingAt` | `not_subset`, `Set.not_disjoint_iff`; `by_cases` | 2–3 each |
| `OnSide.subset_region`, `onSide_of_subset_region` | `IsOpen.subset_interior_iff`, `interior_closedBall`; `interior_compl`, `closure_ball` | 8, 4 |
| `not_innerAt_and_outerAt` | `P ⊆ sphere w 1`; `exists_dist_ne_of_isOpen` | 5 |
| `InnerAt.closure_inter_closure_subset` | `closure_minimal` twice (`isClosed_closedBall`, `isOpen_ball.isClosed_compl`) | 6 |
| `IsPieceAt.nonempty`, `.isConnected`, `.ae_unitShadow_ne` | terms | 1 each |
| `IsPieceAt.disjoint`, `.inter_eq_empty` | `eq_empty_of_isOpen_of_ae` on the open intersection | 6, 4 |
| `IsPieceAt.ae_ne_of_crossingAt` | `ae_ne_region` at both sides, the least radius; almost every point is off the circle (`Measure.addHaar_sphere`), hence on a side (`mem_region_or_of_dist_ne`) | 12 |
| `IsPieceAt.innerAt_self` | by contradiction: `ae_ne_region` at `w := x`, `σ := inside`; `inter_eq_empty` with `V := ball x (min η 1)`; `mem_closure_iff` | 8 |
| `piece_type` | `IsPieceAt.mk`, `ae_ne_region` at `σ := outside` (from `not_outerAt_iff`) and `σ := inside` (from `not_innerAt_iff`); `mem_region_outside`, `mem_region_inside` | 8 |
| `AeProperOn.ae_ne_of_ae_region` | `exists_convex_subset_region`; the disc is a piece at `z` (`Convex.isPreconnected`); `not_onSide_iff` with a point of it; `ae_ne_region` at `w := q`, side `σ.flip` | 12 |
| `centre_half` | the two sides | 6 |
| `IsTightWith.mem`, `.mono`, `isOpen_innerCollar`, `isOpen_outerCollar`, `.ae_innerCollar`, `.ae_outerCollar` | terms; `ball_subset_ball`; `filter_upwards` | 1–5 each |
| `isTight_of_ae_of_isOpen` | `Metric.isOpen_iff` for a disc about `z` inside `V` | 6 |
| `IsTight.ae_ne_centre`, `tight_centre` | `ae_ne_of_ae_region` at the two sides, the least radius | 10, 1 |
| `IsTight.ae_ne_straddle`, `tight_straddle` | `CrossAt p q z`; `exists_mem_sphere_region` at each side with radius `ρ`; `p` in `U ∩ unitShadow` of each collar, open; `Metric.isOpen_iff`; `ae_unitShadow_ne` twice | 18, 1 |
| `isOpen_tightModelDom`, `measurable_tightModel` | `isOpen_ball.union`; `Measurable.ite` on `isOpen_ball.measurableSet` | 1, 8 |
| `isWeakColouringOn_tightModel` | `aeProperOn_of_proper`: nine pairs of discs — the same disc holds no unit pair; the discs about `0` and `1 + i` are more than `1` apart (`‖1 + I‖² = 2 > 1.2²`); the disc about `1` has labels `0`, `1` against `2` | 30 |
| `isTight_tightModel` | `ρ := 1/10`; the two clauses hold at every point (`if_pos`), `Filter.Eventually.of_forall` | 12 |
| four examples | the theorems on the model; `norm_num` | 3–8 each |

**`Plane/ThreePiece`** (29 leaves, about 330 lines)

| leaf | route | size |
|---|---|---|
| `HasUnitArcFrom.mem`, `.mem_closure_diff` | `t = 0`, `e 0 = 1`; `Metric.mem_closure_iff` with `t` small, `norm_e_sub_e_le` (`Plane/Chord`), `e (s t) ≠ 1` for `0 < t < 1` | 3, 15 |
| `isPieceAt`, `mem`, `isConnected_piece`, `disjoint_piece`, `mem_edge`, `edge_comm`, `edge_subset_sphere`, `OneOfEach.separatesAt` | terms (`mem_of_mem_nhds`, `IsPieceAt.disjoint`, `inter_comm`, `InnerAt.closure_inter_closure_subset`) | 1–2 each |
| `ae_mem_piece` | `null_diff`, `ae_iff`, `measure_mono_null` | 5 |
| `ae_label_of_forall_onSide` | `filter_upwards [D.ae_mem_piece, ae_all_iff.2 D.ae_label]`; a piece other than `j` lies in `σ.region w` (`OnSide.subset_region`), disjoint from `σ.flip.region w` | 10 |
| `not_separatesAt_iff` | logic: `push Not`, `cases τ` | 10 |
| `OneOfEach.eq_of_innerAt`, `.eq_of_outerAt` | `σ` is onto: `i = σ k`, `fin_cases k`; `not_innerAt_and_outerAt`; crossing is not inner | 8 each |
| `HasArcEdges.isFull` | `Metric.mem_closure_iff`; continuity of `γ` at `0` gives `t ≠ 0` with `γ t` near `x`; `γ t ≠ x` by injectivity | 15 |
| `hasUnitArcFrom_of_arc_subset_sphere` | `φ u := (γ u − w)/(x − w)` has norm `1`, `φ 0 = 1`; on an interval `[0, u₀]` where `φ` stays in `Complex.slitPlane`, `Complex.arg ∘ φ` is continuous (`Complex.continuousAt_arg`) and injective, so strictly monotone or antitone (`ContinuousOn.strictMonoOn_of_injOn_Icc'`) and onto the interval between `0` and its value at `u₀` (`intermediate_value_Icc`); `Complex.norm_mul_exp_arg_mul_I` turns the argument back into `e (s t)` | 45 |
| `measurable_sectorCol`, `measurable_petalCol`, `isWeakColouringOn_ball_quarter` | `Measurable.ite`, `measurableSet_lt`, `Complex.measurable_re`/`_im`; `aeProperOn_of_proper` (two points of a disc of radius `1/4` are less than `1` apart) | 8, 8, 6 |
| `sectorPoint` (nine fields) | `ball_mem_nhds`; `fin_cases i`; open: `isOpen_lt`; preconnected: each sector is an intersection of two open half-planes and a disc, `Convex.isPreconnected`; closure: the points `t d`; labels: at every point, `if_pos`/`if_neg`; `null_diff`: the complement lies on three lines, each null (`Measure.addHaar_affineSubspace`, or the kernel of a non-zero real-linear functional) | 60 |
| `sectorPoint_hasArcEdges` | for each pair the radius `t ↦ (t / 8) • d`, `d ∈ {1, i, −1 − i}`, in the closure of both adjacent sectors; `edge_comm` halves the cases | 40 |
| `petalPoint` (nine fields) | as above; the sea is preconnected as the union of two wedges and two caps, each convex, chained by `IsPreconnected.union` at three explicit common points | 80 |
| `petalPoint_edge`, `petalPoint_not_isFull` | `closure_minimal` into `{|im| ≤ re}` and `{|im| ≤ −re}` (`isClosed_le`); then `closure ∅` | 12, 4 |
| four examples | `norm_num`; explicit points | 4–8 each |

**`Plane/ClosePair`** (32 leaves, about 480 lines)

| leaf | route | size |
|---|---|---|
| `mem_presentAt_iff`, `not_mem_presentAt_of_ae_ne`, `not_mem_presentAt_iff`, `mem_presentAt_of_ae_eq` | `essSupport` unfolded; `measure_mono_null`; `ae_iff`; `measure_mono_ae` | 1, 5, 8, 6 |
| `presentAt_nonempty` | otherwise finitely many null classes cover `U ∩ ball w r`, open and non-empty (`measure_iUnion_null`, `Finite.exists_min`) | 15 |
| `IsCommonUnitPoint.symm`, `ClosePair.crossAt` | terms (`crossAt_of_dist_lt_two`) | 1 each |
| `exists_isCommonUnitPoint` | the two points `m ± h · i (y − x)/‖y − x‖`, `m` the midpoint, `h² = 1 − ‖y − x‖²/4`; exactly two by `EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two`. Backs the list's sentence only; no statement of the nine reads it | 35 |
| `ClosePair.exists_label_eq` | `Sum.elim C.left.label C.right.label : Fin 3 ⊕ Fin 3 → Fin 6` is injective, hence onto (`Function.Injective.bijective_of_nat_card_le`) | 12 |
| `ae_onSide_of_label` | per piece and side a radius (`IsPieceAt.ae_ne_region` when the piece is not on the side, `1` otherwise); the least over the finite family (`Finite.exists_min`, or `1` for an empty family); `Filter.eventually_all` | 25 |
| `exists_onSide_of_cover` | by contradiction: the region is null by `ae_onSide_of_label` for `x` and for `y` and the cover; `CrossAt.volume_quadrant_pos` | 18 |
| `exists_inner_outer_of_cover` | logic over the four instances | 12 |
| `ae_label_left_of_forall_not_onSide` | `ae_onSide_of_label` for `x` and `y`; the cover; a label of `y` is excluded by `hτ` | 15 |
| `exists_isTight_of_ae_side` | `w'` from `CrossAt.exists_mem_sphere_region τ` at a radius inside `η`, `ρ` and `U`; `w' ≠ w` (`w` is on no side of `S(y)`); `isTight_of_ae_of_isOpen` with `V := ball w r ∩ τ.region y` | 20 |
| `IsTight.closure_inter_closure_eq` | `IsTight.ae_ne_centre`; `IsPieceAt.inter_eq_empty` on `ball x η ∩ outside.region w'` and on `ball x η ∩ inside.region w'`; `IsOpen.inter_closure`, `closure_minimal`; `exists_ball_inter_spheres_subset` | 30 |
| `ThreePiece.exists_second_unit_point_of_ae_side`, `.not_isFull_of_ae_side` | the two above (the labels differ: an inner and an outer piece are different pieces); `Metric.mem_closure_iff` on the edge | 12, 10 |
| `ThreePiece.exists_ne_not_onSide_of_ae_side` | § 3.1, LONE: `ae_label_of_forall_onSide`; a point `w'` as above; `AeProperOn.ae_ne_of_ae_region` at the centre `x`; `crossAt_of_dist_lt_two` for `w`, `w'` at `x`; `CrossAt.volume_quadrant_pos` | 40 |
| `ClosePair.separatesAt_or` | `exists_inner_outer_of_cover` at the two decompositions' pieces | 3 |
| `ClosePair.lone_of_cover` | § 3.3's five children, in order | 45 |
| `ClosePair.separatesAt_right_of_isFull` | by contradiction through `lone_of_cover` | 12 |
| `ClosePair.label_mem_presentAt_of_isFull_right` | per side `s` of `S(x)`: `not_mem_presentAt_iff`; `ae_onSide_of_label` for both members; `OneOfEach.eq_of_innerAt`/`_outerAt`; `ThreePiece.not_isFull_of_ae_side` at `y` with the circles exchanged (`CrossAt.symm`) | 40 |
| `ClosePair.presentAt_eq` | `⊆`: the cover, `σ` onto, `IsPieceAt.ae_ne_of_crossingAt`, `not_mem_presentAt_of_ae_ne`; `⊇`: the lemma above for the pair and for `C.symm` | 30 |
| `ClosePair.ncard_inner_outer` | four different labels; `Set.ncard_insert_of_notMem`, `Set.ncard_singleton` | 15 |
| `closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`, `closePair_four` | the general statement at `hcover := C.exists_label_eq`, `hc.aeProperOn`; `edge_subset_sphere` | 2–6 each |
| `closePair_both_saved` | `HasArcEdges.isFull`; `closePair_both_separate`; the arc of the inner–outer edge lies on `sphere w 1`; `hasUnitArcFrom_of_arc_subset_sphere` | 12 |
| three examples | `norm_num`; a constant colouring | 4–8 each |

**`Plane/ClosePairModel`** (3 leaves; the witnesses of § 2.5)

| leaf | what is hard | size |
|---|---|---|
| `exists_closePair_seven_not_separatesAt` | two translated copies of `sectorPoint`'s construction with no inner piece; the label `6` on the disc about `w` | about 120 |
| `exists_closePair_not_separatesAt` | the petal at `x` and its sea (connected as a union of convex sets); two crude distance inequalities | about 250 |
| `exists_closePair_full` | four distance inequalities, sharp along the shared edges (the lens duality, then a cusp); two non-convex pieces at each member (connected by segments toward a quadrant); six arcs of unit circles as edges | 500 to 700 |

**`Plane/SectorPoint`** (3 leaves)

| leaf | status |
|---|---|
| `ThreePiece.IsSector.hasArcEdges` | **not planned here** — the θ-lemma, owed as a kernel job of its own (§ 2.4) |
| `sectorPoint_isSector` | the three radii as `C(unitInterval, ℂ)`; three disjoint open convex sets filling a set are its components (`IsPreconnected.subset_connectedComponentIn`, and a component cannot meet two of them) — about 80 |
| `exists_closePair_sector` | the unit-square witness again, its pieces as the components of a disc cut along three arcs of unit circles — about 150 beyond `exists_closePair_full` |

**What is hard, in order.** (1) The θ-lemma — out of this plan. (2) `exists_closePair_full`: the one leaf where a
real inequality must be found, not transcribed; state each of its four inequalities as a small real-variable lemma
carrying only its own hypotheses (`LEAN.md` on `nlinarith`). (3) The three long compositions
`ThreePiece.exists_ne_not_onSide_of_ae_side`, `ClosePair.label_mem_presentAt_of_isFull_right`,
`ClosePair.lone_of_cover`: nothing deep, but six or seven almost-everywhere facts and two circles' sides to keep
straight; each is cut into the children named above. (4) `hasUnitArcFrom_of_arc_subset_sphere`: the continuity of the
argument. (5) `petalPoint`: connectedness of the sea.

**The module's size**: about 1,200 lines of proof for the four statement modules, about 900 to 1,100 for the three
models, about 230 for the two planned leaves of `Plane/SectorPoint`. § 5 measures the rate.

### 3.3 The pass on the model (`debruijn-domain-modeling`, run fresh)

What it changed. *"Does the representation earn the next theorem for free?"* — the first draft's quadrant lemma took
the cover sentence and a finite label type, and could not state what happens at seven labels. The lemma under it
needs neither: **near `w`, almost every point on the side `σ` of `S(x)` that carries the label of a piece of `x` has
that piece on the closed side `σ` of `S(w)`** (`ae_onSide_of_label`: one point, finitely many pieces, no cover). The
cover sentence then enters at exactly one place per theorem, and the finite type that matters is the family of
pieces, not the labels. A free corollary of the type of a piece, named because it is the known shape "a tile has
diameter at most 1": `IsPieceAt.innerAt_self`.

What it kept, with the reason. "Almost every point of `W` has the label `i`" stays `∀ᵐ z, z ∈ W → c z = i`: it is
`W ≤ᵐ[volume] c ⁻¹' {i}` by definition, every consumer filters on it, and a named predicate would be an API with one
fact in it. The side-uniform form (`CircleSide`, `OnSide σ`) is the image of the argument — every proof here is one
proof at the two sides, and C124-TYPE is a duality between the two circles, which only a variable side can say; its
cost is two `Iff.rfl` bridges (`onSide_inside`, `onSide_outside`) and one lemma (`not_onSide_iff`), so no proof
unfolds the `match`. `ThreePiece` stays at three pieces: the generality of FORCED-PIECES is carried by families of
`IsPieceAt` at no cost, and no ugliness asks for a decomposition indexed by a general type. `OneOfEach` by a
permutation: the object is a bijection between pieces and kinds, and it hands the conclusions the names of the inner
and the outer piece. Seams checked: a piece at `x` read at `w = x` (the corollary above); a non-open `N`; `x = w` in
`HasUnitArcFrom` (excluded where it is used: `dist w x = 1`); a decomposition's labels equal across the pair (excluded
by `label_ne`); an arc of positive measure in a sector point (excluded near `x` by `null_diff`).

### 3.4 The pass on the obligations (`debruijn-obligation-modeling`, run fresh)

No induction anywhere. Every global claim is finitely many almost-everywhere facts taken at once and one open
non-empty set of positive measure. The statements that changed shape so that each case is short:

- **LONE** is cut into named children: `ThreePiece.not_separatesAt_iff` (the empty side `τ₀`),
  `ae_label_left_of_forall_not_onSide` (that side of `S(y)` belongs to `x`), `CrossAt.volume_quadrant_pos` (an inner
  and an outer piece exist), `ThreePiece.exists_ne_not_onSide_of_ae_side` (the third piece is crossing — stated
  positively: *some other piece is not on the side*, in place of the first draft's negated universal),
  `ThreePiece.exists_second_unit_point_of_ae_side` (the last clause).
- **BOTH's first clause and FOUR share one child**: `ThreePiece.not_isFull_of_ae_side` — a side of the other circle
  filled by this member's inner label inside and outer label outside defeats its fullness. FOUR's "each of the four
  is present" is `ClosePair.label_mem_presentAt_of_isFull_right`, used for the pair and for the pair in the other
  order; `not_mem_presentAt_iff` was added for it.
- **The partition**: everything is proved; the spec examples and the models are the tests; nothing is assumed. The
  one leaf not planned (`ThreePiece.IsSector.hasArcEdges`) is in a module no other module imports.

Mutations tried on paper, each breaking the statement as it should: SHADOW-OPEN without `W ⊆ U` (colour everything
outside `U` with `i`); TYPE without preconnectedness (two discs, one strictly inside `S(w)` and far from `x`, `x` in
the closure of the other); TYPE without `x ∈ closure P`; CENTRE-HALF with `|q − z| > 1` (the inner collar can be
empty, and the conclusion then says a whole disc about `q` avoids `a`); STRADDLE at the antipode `p = 2z − q` (`S(p)`
touches `S(q)` from outside, meets the outer collar only: `a` is not excluded); FORCED-PIECES at `|x − y| = 2` (the
region inside both circles is empty near `w`); FORCED-PIECES at seven labels (the control,
`exists_closePair_seven_not_separatesAt`); LONE without the cover clause `null_diff` (the outside of `S(w)` near `x`
need not belong to the one outer piece); BOTH with one member not full, FOUR without fullness (the witness of
`exists_closePair_not_separatesAt`: three labels present). A hypothesis no proof touches: `a ≠ b` in a tight pair
(G8); it stays in the definition as in the list's, and where a tight pair is built the labels are those of two
different pieces.

### 3.5 The pass on the surface (`debruijn-experience-modeling`, run fresh)

Three consumers and what each reaches for:

- **A later module holding a weak colouring and an open set of one label** writes `hc.aeProperOn.ae_unitShadow_ne hW
  hWU hi`; holding a piece, `hP.ae_ne_region hU hc hw hσ` with `hσ` from `not_innerAt_iff.mpr` or
  `not_outerAt_iff.mpr` (the bridges `onSide_inside`, `onSide_outside` are `simp` lemmas and hold by `Iff.rfl`).
- **A close-pair consumer** holds `C`, `hw : w ∈ U`, `hwu : IsCommonUnitPoint x y w`. The first draft took two
  distance hypotheses in the claims and the bundled one in the general statements; now every statement takes `hwu`
  (the words "w a common unit point of the pair"), built by `⟨hwx, hwy⟩`, turned over by `IsCommonUnitPoint.symm`
  with `C.symm`.
- **A reader of the claims** finds each under a claim-keyed name with a stem that says its object: `shadow_open`,
  `piece_type`, `centre_half`, `tight_centre`, `tight_straddle`, `closePair_forced_pieces`, `closePair_lone`,
  `closePair_both_separate`, `closePair_both_saved` (`closePair_both_saved_of_isSector`), `closePair_four`. The first
  draft's `centre`, `straddle`, `lone`, `four` named nothing in a namespace of several thousand declarations.

Distances are written with the point on the circle first and the centre second (`dist w x = 1`: `w` on `S(x)`), as
`sphere`-membership is; a claim's hypothesis is written as its words write it (`dist q z = 1` for a tight pair). The
`simp` set gains `mem_region_inside`, `mem_region_outside`, `flip_inside`, `flip_outside`, `flip_flip`,
`onSide_inside`, `onSide_outside`: each rewrites toward the constructor-free form, and nothing else is tagged.
Docstrings assert only what a declaration backs: the witnesses described in `Plane/ClosePairModel`'s header are
marked "planned" (the statements are existence statements, and the implementer may choose another witness).

### 3.6 Leaves proved in phase 1, and the probes

`abs_real_inner_lt_one`, `norm_sq_quadrant` (`Plane/CircleCrossing`); `AeProperOn.ae_unitShadow_ne`,
`mem_unitShadow_of_isPreconnected`, `not_onSide_iff`, `IsPieceAt.ae_ne_region` (`Plane/OnePiece`); and the `rfl`
facts `flip_inside`, `flip_outside`, `onSide_inside`, `onSide_outside`. `IsPieceAt.ae_ne_region` rests on two
leaves of `Plane/CircleCrossing` that are still `sorry` (`isOpen_region`, `mem_region_comm`; both are proved in
`data/fs124/k2/lean/Probe2.lean` under `probe_` names): not yet a theorem. Probes: `data/fs124/k2/lean/Probe1.lean`
(the shadow, the quadrant identity, the inner-product bound) and `Probe2.lean` (the type of a piece); both elaborate
against this worktree's build with `lean` — iteration, not evidence.

### 3.7 For the landing (the implementer's job and the coordinator's files)

- **Nothing with a `sorry` reaches `main`**: `Plane/SectorPoint` holds the unplanned leaf, so it stays on a branch
  until the θ-lemma's job; the other five modules do not import it and can land without it. `ARCHITECTURE.md`'s six
  rows say "a skeleton on branch `fs124-wk2`"; the landing rewrites them.
- **`scripts/Axioms.lean`** (not touched by this job): every record here is expected CLEAN — no declared outside
  theorem is used by any of the six modules.
- **`scripts/Assumptions.lean`**: no entry expected. `hcover` is a condition on the theorem's own decompositions,
  discharged at `Fin 6` by `ClosePair.exists_label_eq`; `HasArcEdges` in `closePair_both_saved` is a property of the
  decomposition, by the coordinator's ruling, with the bridge from the list's sector point owed by name
  (`ThreePiece.IsSector.hasArcEdges`). The landing says so in the report: a reader counting assumptions should find
  the owed bridge there.
- **Vacuity.** Binders: `c : ℂ → Fin 6` with `IsWeakColouringOn U c` at a free `U`; `C : ClosePair U c x y`, witnessed
  by the three existence theorems. No statement here is emptied by a declared import (a weak six-colouring of a small
  open set exists with no hypothesis).
- **Names**: none of the declarations is declared on `main` or on this branch's base (searched before typing;
  `collar` exists in `Plane/Woodall/Basic` and is not reused; `unitShadow`, `essSupport` are the library's).
