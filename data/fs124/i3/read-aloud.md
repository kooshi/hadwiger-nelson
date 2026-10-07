### Read aloud: each claim's theorem against the claim list's words, and against its *not claimed* line

Four readings hold for all five theorems and are said once.
1. **The class.** The list's weak six-colouring is "a measurable map `c` from `U` to `k` labels"; the theorems take the
   first module's `IsWeakColouringOn U c` with `c : ℂ → Fin 6` — a total measurable `c`, proper at almost every unit pair
   of `U`, read on `U` alone — and `hU : IsOpen U` (the class is defined on an open set). That reading is the first
   module's; nothing here adds to it. No proof reads measurability (`hc.aeProperOn` only).
2. **The definitions are the planner's**, each read against the list's "Definitions, stated once" in its record (§ 2.1)
   and confirmed there by the coordinator where a reading was chosen (`N` any neighbourhood inside `U`, not asked
   open; `presentAt` through `essSupport (U ∩ c ⁻¹' {i})`). I read them again as the kernel prints them
   (`data/fs124/i3/claim-sigs.txt`: `#print` of the structures and definitions the five statements name).
3. **"Almost every"** is `∀ᵐ z` for plane Lebesgue measure on `ℂ`; `|a − b|` is `dist a b`; `B(p, r)` is `ball p r`,
   `B̄(p, r)` is `closedBall p r`, `S(p)` is `sphere p 1`; "inside `S(p)`" is `dist z p < 1`, "outside" is `1 < dist z p`,
   and "a side of `S(y)`" is `τ.region y` for `τ : CircleSide` (`ball y 1` or `(closedBall y 1)ᶜ`).
4. **The setting** of all four: "c a weak six-colouring of U" — `hU`, `hc`; "(x, y) a close complementary pair of
   three-piece points, each with a decomposition" — `C : ClosePair U c x y`, whose fields are the two decompositions
   (`left : ThreePiece U c x`, `right : ThreePiece U c y`), `ne : x ≠ y` and `dist_lt : dist x y < 2` ("0 < |x − y| < 2"),
   and `label_ne : ∀ i j, left.label i ≠ right.label j`, which with each decomposition's `label_injective` is "whose six
   labels are distinct"; "w a common unit point of the pair lying in U" — `hwu : IsCommonUnitPoint x y w` (`dist w x = 1
   ∧ dist w y = 1`) and `hw : w ∈ U`.

**C124-FORCED-PIECES** — `closePair_forced_pieces`.

> **C124-FORCED-PIECES** — statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).
> — source: data/fs124/claims-K2.md

The setting: reading 4. "Then x or y separates at w" — the disjunction, its left member about `C.left` and its right
about `C.right`. "one of its pieces lies in the closed unit disc about w" — `InnerAt (C.left.piece i) w`, which is
`C.left.piece i ⊆ closedBall w 1`. "and another is disjoint from the open unit disc about w" — `OuterAt (C.left.piece j)
w`, which is `Disjoint (C.left.piece j) (ball w 1)`. "the edge of those two pieces lies on S(w)" — `C.left.edge i j ⊆
sphere w 1`, the edge being `closure (piece i) ∩ closure (piece j) ∩ nbhd`. Every clause has its conjunct; no hypothesis
is added. **One word of the claim is not a conjunct: "another".** The statement does not say `i ≠ j`; it follows, since a
piece is a non-empty open set and no such set is both inner and outer (`not_innerAt_and_outerAt`) — the helper
`ThreePiece.HasArcEdges.saves_of_separatesAt` derives it so. A consumer that wants `i ≠ j` has it in one line.

> *Not claimed (C124-FORCED-PIECES):* that a weak six-colouring has a three-piece point, or a close complementary pair; which member separates, or that both do (C124-BOTH needs full members; in fragment S1 one does not); that the edge of the two pieces is more than the member itself (at a bowtie it is not); anything with seven labels (C124-FORCED-SEVEN)
> — source: data/fs124/claims-K2.md

Existence: `C` is a hypothesis. Which member, or both: a disjunction. That the edge is more than the point: the
conclusion is an inclusion in the circle, nothing else. Seven labels: `c : ℂ → Fin 6`; under it `ClosePair.separatesAt_or`
holds at any label type from the hypothesis "every label is the label of a piece of `x` or of `y`", which seven labels
do not satisfy. The theorem claims none of the four.

**C124-LONE** — `closePair_lone`.

> **C124-LONE** — statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.
> — source: data/fs124/claims-K2.md

"suppose y does not separate at w" — `hy : ¬ C.right.SeparatesAt w`, `SeparatesAt` being "an inner and an outer piece".
"Then x has exactly one inner piece, one outer piece and one crossing piece at w" — `∃ σ : Equiv.Perm (Fin 3),
C.left.OneOfEach w σ`: the piece `σ 0` inner, `σ 1` outer, `σ 2` crossing (`CrossingAt`: neither inner nor outer).
*Exactly* one of each: `σ` is a bijection of the three pieces, and the inner piece is the only inner one, the outer the
only outer one (`ThreePiece.OneOfEach.eq_of_innerAt`, `eq_of_outerAt`, proved in this job). "with labels a and b for
the inner and the outer one" — `C.left.label (σ 0)`, `C.left.label (σ 1)`. "there are a side of S(y) and η > 0" —
`∃ τ : CircleSide, ∃ η > 0`. "such that almost every point of B(w, η) on that side has the label a if it lies inside
S(x)" — `∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)`. "and the label b if it lies
outside S(x)" — the same with `1 < dist z x` and `C.left.label (σ 1)`. "and there are a point w′ ≠ w of S(x) and η′ > 0"
— `∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0`. "such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1)" —
`C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1`. "the outer piece is disjoint from B(w, 1) ∪
B(w′, 1)" — `Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1)`. "and their closures meet at x only" —
`closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x}`: read, as the sentence has it, inside
`B(x, η′)`. Every clause has its conjunct; no hypothesis is added.

> *Not claimed (C124-LONE):* that a weak six-colouring has a three-piece point, or a close complementary pair; that such a configuration is impossible — it is fragment S1's (C124-LONE-EXISTS); anything about the edges of the crossing piece (one of them may lie on S(w)); that (x, w′) is tight on both sides of S(y)
> — source: data/fs124/claims-K2.md

Existence: `C` and `hy` are hypotheses. Impossibility: the conclusion is not `False`. The crossing piece's edges: no
conjunct names `edge`. Tightness on both sides: the conclusion names one side `τ`; the proof passes through a pair
`(x, w')` tight on a disc about `w'` inside that one side (`exists_isTight_of_ae_side`), and the statement does not
export it. The theorem claims none of the four.

**C124-BOTH** — `closePair_both_separate` (first clause) and `closePair_both_saved` (second clause, **for arc-edged
decompositions**).

> **C124-BOTH** — statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.
> — source: data/fs124/claims-K2.md

"if x and y are full" — `hfx : C.left.IsFull`, `hfy : C.right.IsFull`, `IsFull` being `∀ i j, i ≠ j → x ∈ closure
(D.edge i j \ {x})`: "for every two of its pieces x is a limit of points other than x of their edge". "both separate at
w" — `C.left.SeparatesAt w ∧ C.right.SeparatesAt w`. The first clause is the theorem, clause for clause.

**The second clause is not proved in the list's words, and this job does not say it is.** "If they are sector points" —
the theorem takes instead `hax : C.left.HasArcEdges`, `hay : C.right.HasArcEdges`: every edge contains an injective
continuous image of `[0, 1]` that starts at the point. That is what the clause reads of a sector point, by the
coordinator's ruling recorded in the planner's § 2.4; that the list's sector point *is* arc-edged is the θ-curve fact,
the leaf `ThreePiece.IsSector.hasArcEdges` of `Plane/SectorPoint`, **still `sorry` on this branch and owed as a kernel
job of its own**. "each has an edge that contains an arc of S(w) with an end at the member" — `C.left.Saves w ∧
C.right.Saves w`, `Saves w` being `∃ i j, i ≠ j ∧ HasUnitArcFrom (D.edge i j) w x` and `HasUnitArcFrom E w x` being: for
a turning sense `s = ±1` and some `δ > 0` the points `w + (x − w) e(s t)`, `0 ≤ t ≤ δ`, are in `E` — the arc of the unit
circle about `w` from `x`, turning by up to `δ`. "no common unit point … is saved by one member alone" — both conjuncts
hold. So: for arc-edged members every clause has its conjunct; for the list's sector points the clause is
`closePair_both_saved_of_isSector`, which prints `sorryAx` (the audit's fourth control).

> *Not claimed (C124-BOTH):* that a weak six-colouring has a full three-piece point, or a close complementary pair; that exactly one edge of each member lies on S(w) (T2, the kept model: two at one member); anything when a member is not full (S1: one member saves alone)
> — source: data/fs124/claims-K2.md

Existence: hypotheses. Exactly one edge: `Saves` is an existence. A member that is not full: fullness (or arc edges,
which give it: `ThreePiece.HasArcEdges.isFull`) is a hypothesis of both theorems. Neither claims any of the three.
**Finer than the claim, and in the file**: each member's fullness makes the *other* member separate
(`ClosePair.separatesAt_right_of_isFull`, the planner's G7), and one arc-edged member that separates saves by itself
(`ThreePiece.HasArcEdges.saves_of_separatesAt`).

**C124-FOUR** — `closePair_four`.

> **C124-FOUR** — statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.
> — source: data/fs124/claims-K2.md

"let x and y be full" — `hfx`, `hfy`. "each with exactly one inner piece, one outer piece and one crossing piece at w" —
`hσ : C.left.OneOfEach w σ`, `hτ : C.right.OneOfEach w τ`. "Then exactly four labels are present at w: those of the two
inner and the two outer pieces" — `presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0),
C.right.label (τ 1)} ∧ (presentAt U c w).ncard = 4`: the set of labels present is the set of those four, and it has four
elements. "present" — `presentAt U c w = {i | w ∈ essSupport (U ∩ c ⁻¹' {i})}`: every disc about `w` meets the class of
`i` in `U` in positive measure. Every clause has its conjunct; no hypothesis is added.

> *Not claimed (C124-FOUR):* that a weak six-colouring has a full three-piece point, or a close complementary pair; which label fills which of the four regions, or that each region carries one label; anything when a member has two inner or two outer pieces (T2: five labels allowed, four present)
> — source: data/fs124/claims-K2.md

Existence: hypotheses. Which label fills which region, or one label per region: the conclusion is the set of labels
present at `w` and its size. Two inner or two outer pieces: `hσ`, `hτ` are hypotheses. The theorem claims none.

**What the read-aloud found.**
- No clause of C124-FORCED-PIECES, C124-LONE, C124-FOUR or of C124-BOTH's first clause is missing, none is added, and no
  theorem claims an item of its *not claimed* line.
- **C124-BOTH's second clause is proved for arc-edged decompositions only.** In the list's words, for sector points, it
  rests on one leaf that is not proved (`ThreePiece.IsSector.hasArcEdges`). This is the planner's and the coordinator's
  recorded position, not a finding of mine; I repeat it because a reader of "the four claims are proved" would otherwise
  be told more than the kernel holds.
- **The four claims' hypotheses have no inhabitant in the kernel yet.** Each docstring names its model in
  `Plane/ClosePairModel` (`exists_closePair_not_separatesAt`, `exists_closePair_full`), and both are `sorry` on this
  branch — the third job's. Until they land, "not vacuous" is the planner's two sampled witnesses ([measured]: floats,
  its § 4.4), not a theorem. What this job does put in the kernel is the two models of *one* member: `sectorPoint`
  (arc-edged, hence full) and `petalPoint` (not full), each a decomposition of a weak colouring of a disc.
- "another" in C124-FORCED-PIECES is a consequence, not a conjunct (above).
