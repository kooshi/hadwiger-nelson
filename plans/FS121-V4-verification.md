# FS121-V4 — a blind second mind on the cover route's lemmas (FS-121's list § 7.2)

*Job FS121-V4 (Ephodos in its verification form, Opus 5.5), opened 2026-09-29 07:18 UTC. Brief: `data/fs121/briefs/FS121-V4-verify.md`, with
`plans/STANDING-RULES.md`. Five statements, fixed in `data/fs121/claims.md` § 7.2 (frozen by Keryx 2026-09-29 07:06 UTC). Blind to every path the
brief's § Fences names until the verdicts on all five are committed. Working files: `data/fs121/v4/`. Tools: `tools/fs121_v4_*.py`. Every address
and control in this record resolves from `plans/`.*

## Theorems this phase proved

*(statement, grade, count of minds, address; "one mind" = this verifier, blind to the cover route's proof record until stage 2 is committed)*

- Stage 1 proves nothing: it is the readback and the registered expectations.
- **C121-C1-BOUND** — TRUE as stated (both halves; the "if" half unconditional). [hand, over PG1, PG2, SEP cited unread; two minds, blind, the same
  model — the count as filed at stage 2] § Derivation of C121-C1-BOUND
- **V4-LF** — in a locally finite map colouring every bounded set meets finitely many faces. [hand over PG1 and SEP, one mind] same section; after stage 3, not
  needed for BOUND (the entry's perturbation argument uses no local finiteness), kept as a lemma about plane graphs
- **V4-SWITCH** — in a locally finite map colouring, for every `x ∈ F_i` and every component `K` of `F_i`, `d_K(x) ≥ 1` or `D_K(x) ≤ 1`.
  [hand, one mind] same section
- **V4-DIAM** — every component of `F_i` in a locally finite map colouring has diameter at most 1. [hand, one mind] same section
- **C121-C1-GMAP** — TRUE as stated; (ii)'s "if" half is vacuous and C121-NOPAR is idle there; R7 is Grundy-bound under every order (from
  FS111-VMW-R7-MAX). [hand; two minds, blind, the same model] § Derivation of C121-C1-GMAP
- **C121-C1-SAT** — TRUE as stated, with both side colours bound at every point of every separating edge. [hand; two minds, blind, the same model]
  § Derivation of C121-C1-SAT
- **C121-C1-COVMAP** — TRUE as stated; an arc point is unbound exactly when its disc's colour lies between the colours of an opposite pair of
  neighbours (V4-EDGE), and the colour of rank 4 always does (V4-MID, parity); exact over all 5040 orders, at least 5 unbound edge types in each.
  [hand + tools exact in ℚ(√3); two minds, blind, the same model] § Derivation of C121-C1-COVMAP, `tools/fs121_v4_covmap.py`
- **C121-C1-FLAT** — TRUE as stated, witnessed by `L_k` the lines through `P_k` and `U_k` the parallels at distance `k` of `(t, t⁴)`; `Y_k(X) =
  X⁴ + 8kX⁶ + O(X⁸)`. [hand + tools symbolic in `k`; two minds, blind, the same model] § Derivation of C121-C1-FLAT, `tools/fs121_v4_flat.py`
- **The tight hexagonal seven-colouring's edge midpoints are bound by neither side colour** (the farthest point of its own hexagon `√13/4` away, the
  nearest same-colour hexagon more than 1 away). [hand, one mind] § Attack on C121-C1-GMAP — the list's "in no `𝒫_7`", re-derived

## Would-have-searched-here log (standing rule 5)

- Stage 1: nothing searched, nothing would have been.
- Stage 2: would have searched the 5040 orders of the seven colours for one under which every separating edge of DISC7's merged map is bound →
  derived the parity lemma V4-MID first; the enumeration of all 5040 orders is then an exact control over the finite set the statement itself fixes,
  not a search for a witness.
- Stage 2: would have sampled germs numerically for FLAT → a closed-form family, checked symbolically with `k` free.

## Fence log (standing rule 8)

- No fenced path read, opened or printed by a search, through stage 2's commit (0dde4982, 2026-09-29 07:41 UTC).
- 2026-09-29 07:42 UTC, after that commit, as the brief's § After your verdicts allows: `grep -n '^#' plans/FS121-C1-proof.md` printed the record's
  headings, then I read §§ 2.1–2.5 (lines 134–302) and nothing else. The headings of the still-fenced remainder were printed with them: "1.1 Readback
  of the brief", "1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)", "1.3 The proposed statements", "Stage 2 — SAVED: the lemmas,
  and the verdicts on C121-NOPAR and C121-NOPAR-C5", "2.6 The verdicts", "2.7 The invention signal (G87)". Headings only: they carry no verdict, and
  my five verdicts were committed before they were seen. I did not read §§ 1.x, 2.6, 2.7.
- The job stopped at 07:42 UTC on 2026-09-29 (an account halt) and resumed on 2026-10-03 at 14:36 UTC at the coordinator's message; before
  resuming I checked that `plans/FS121-C1-proof.md` has no commit after 2026-09-29 02:16 (`git log --format` on the path, subjects only), so §§ 2.1–2.5
  are the text I read. The brief's § Fences says "until your verdicts on all three statements are committed"; the
  brief carries five statements and its § After your verdicts says "all five": I read the fence as closed until all five verdicts are committed (the
  stricter reading). A slip in the brief, reported to the coordinator.

## Stage 1 — SAVED: the readback, what was given, and the registered expectations

### 1.1 Files read, in order (2026-09-29, 07:18–07:29 UTC)

1. `data/fs121/briefs/FS121-V4-verify.md` (the brief, in full).
2. `plans/STANDING-RULES.md` (in full); the head of `.claude/agents/ephodos-verifier.md` (my identity, loaded at launch).
3. `data/fs121/claims.md` (in full: §§ 0–7, including the statements other jobs work).
4. `plans/FS111-derivation.md`, the entries FS111-M-R7, FS111-VMW-R7-MAX, FS111-VMW-R7-PPLUS, FS111-M-R7-FORCE, FS111-W-SQ9, FS111-W-HEX9,
   FS111-W-KB-DIR, FS111-W-LADDER, FS111-W-HEXSAT, FS111-M2-DISC7 (lines 340–420, 640–720, 875–915): the control objects' definitions.
5. `plans/FS110-derivation.md` lines 60–100: FS110-N4-SHADOW (the maps `f`, `f̃`) and FS110-N4-FIN.
6. `plans/FS111-M-regularity.md` § 2.1 (the reading of "at distance exactly 1 from the support") and its section list.
7. `data/fs106/claims.md` D-NF (lines 39–52); `data/fs111/claims.md` line 37 (essential closure, essential boundary).
8. `plans/FS111-M2-regularity.md` § 1.6 (DISC7, the hex7 centres and colours) and § 3.2 (M2-REDUCE-C, whose step (1) is the merged map).
9. `plans/FS111-VM2-verification.md` lines 1–60 and the gate's `example-verification.md` (the record's form).

### 1.2 The readback (standing rule 3)

`tools/fs121_v4_quotes.py` compares each quotation in the brief with `data/fs121/claims.md`, whitespace normalised: **5 of 5 verbatim**
(`data/fs121/v4/quotes.out`); with one character planted in the first quotation it reports the miss and exits 1.

derivation: fs121-v4-readback
  statement: each of the five statements quoted in data/fs121/briefs/FS121-V4-verify.md occurs verbatim, up to whitespace, in data/fs121/claims.md
  uses only: string containment after collapsing whitespace
  not claimed: that the claim list's statements say what their authors meant; anything about their truth
  argument: § 1.2 The readback (standing rule 3)
  verdict: derived
  grade: computed over: the 5 quotations of the brief, {BOUND, GMAP, SAT, COVMAP, FLAT}
  minds: 1
  model: C121-C1-BOUND, the first quotation
  prior art: known: not applicable — a bookkeeping check
  handoff: none — a readback

control: fs121-v4-quotes
  of: fs121-v4-readback — the five quotations, verbatim
  run: python3 ../tools/fs121_v4_quotes.py ../data/fs121/briefs/FS121-V4-verify.md ../data/fs121/claims.md | tail -1
  expect: quotations: 5  verbatim: 5
  fault: python3 ../tools/fs121_v4_quotes.py ../data/fs121/briefs/FS121-V4-verify.md ../data/fs121/claims.md --plant | tail -1

**The five statements, restated as fixed** (verbatim from `data/fs121/claims.md` § 7.2; each `verification:` block at stage 2 quotes its
statement line character for character):

> - **C121-C1-BOUND** (this addendum): in a locally finite map colouring, a point `x` of `F_i ∖ S_i` is `i`-bound if and only if it lies on the outer unit
>   parallel or on the far level of a connected component of `F_i`.
>   *Not claimed:* which of the two levels, or that the component is unique. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9.

> - **C121-C1-GMAP** (this addendum): (i) for every `k`, a Grundy-bound `k`-colouring that is a.e. equal to a locally finite map colouring makes that map
>   colouring a member of `𝒫_k` under the order `1 < 2 < … < k`; (ii) G-FIN₆ and C121-NOPAR together imply `χ_m⁰(ℝ²) ≥ 7`, and given C121-NOPAR, G-FIN₆
>   holds if and only if `χ_m⁰(ℝ²) ≥ 7`.
>   *Not claimed:* G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring. *Inhabitants of (i):* `k = 7`, R7 (every class a MUA
>   set).

> - **C121-C1-SAT** (this addendum): for every `k`, a locally finite map colouring with `k` colours whose edges are finite chains of segments and circular
>   arcs, and whose classes form an honest saturated colouring, is a member of `𝒫_k` under every total order of its colours; so C121-NOPAR implies that no
>   honest saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs.
>   *Not claimed:* the converse (a member of `𝒫_k` need not be saturated). *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9.

> - **C121-C1-COVMAP** (this addendum): under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that
>   order, of a disc containing them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in `𝒫_7` under no order.
>   *Not claimed:* anything about other maximal covers, or about DISC7's classes themselves (each disc is its own far level). *Colours:* seven, a
>   statement about one object.

> - **C121-C1-FLAT** (this addendum): there are germs `L_k`, `U_k` at `P_k`, for every `k ∈ ℤ`, with `U_k > L_k` on both sides of `P_k`, every one of
>   curvature 0 at `P_k`, such that for every `k`: `L_k` is the unit parallel toward `P_k` of `L_{k+1}`, and `U_k` is the unit parallel toward `P_k` of
>   `U_{k−1}`. (So the relations `plans/FS110-derivation.md` states on circular arcs as "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤
>   f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`", read on germs with `L_k` below the parallel of `L_{k+1}` and `U_k` above the parallel of `U_{k−1}`, hold with
>   equality for every `k`, and `λ_k = υ_k = 0`.)
>   *Not claimed:* that any locally finite map colouring realises these germs; anything about the other steps of row 134's chain on smooth boundaries.
>   *Colours:* none (a statement about germs of curves).

— source: `data/fs121/claims.md` § 7.2 Lemmas (every `k`); definitions § 7.0 and § 0; held inputs § 1.

**Terms, and the reading I take.** One term is written two ways in the list, and its own "i.e." fixes it:
- **Bound** (§ 7.0): "a point `x` is **`j`-bound** when it is at distance exactly 1 from `F_j`, i.e. the unit circle `T₁(x)` about `x` meets `F_j`."
  Read as the set distance `d(x, F_j) = 1`, no point of `F_i` could be `i`-bound, so C121-C1-BOUND's "if" direction would fail at every point of every
  far level; read as the "i.e." clause, it is FS-111's established sense (`plans/FS111-M-regularity.md` § 2.1: "saturated" means "every essential
  boundary point is at distance exactly 1 from the support of each colour", where the point lies in that support). **I take the "i.e." reading
  throughout:** `x` is `j`-bound iff `T₁(x) ∩ F_j ≠ ∅`. The same reading for the Grundy clause ("at distance exactly 1 from the support of A_i") and for
  saturation. No question to the author: the definition fixes it; the wording is reported as a wording divergence if the first derivation leans on
  the other sense.
- **Essential boundary** (`data/fs111/claims.md` § 0): `∂_e S_j = {x : d̄_j(x) > 0} ∖ S̃_j`; every notion in "honest saturated" (densities, `P(x)`,
  supports) depends only on the classes up to null sets.
- **The merged map** (§ 7.0): the arrangement of DISC7's boundary circles, each face coloured by the least colour, in the chosen order, of a disc
  containing it — M2-REDUCE-C's step (1), without its step (3) clean-up. DISC7's centres and colours: `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)`, colour
  `(m + 3n) mod 7` (`plans/FS111-M2-regularity.md` § 1.6).

### 1.3 What was given (the cut)

**Given before any verdict:** the five statements with their *not claimed* lines; the claim list's definitions (§§ 0, 7.0) and held inputs (§ 1),
with their grades; the claim list's other statements (§§ 2–7.1, including C121-NOPAR and the vacuity rule); the brief's framing ("Its cover route was
opened tonight and its NO stated"; "the five lemmas below relate that NO to the answer and to FS-116's question"; "Two are about objects given by
formula (DISC7's merged map; germs of curves)"; in § Fences, "FS-111's W-NOREP proof, which the first statement strengthens", and that two of the
five were passed to FS-116 as inputs); the held control objects' entries (R7, SQ9, HEX9, DISC7) and FS-110's N4-SHADOW and N4-FIN (§ 1.1). **Not
given:** any verdict, sketch, route or confidence of the cover route's author; nothing of FS121-C1's record or data. I held no prior knowledge of
these five lemmas; the objects' prior-art status is the held entries'.

**How informed the predictions are.** They were written at 07:29 UTC, after about eleven minutes of reading the definitions, during which a route for
each statement came to mind unbidden (for BOUND a connectedness argument on the components of `F_i`; for COVMAP a parity count over each disc's three
pairs of opposite neighbours; for FLAT a family of parallel curves). They are **informed, not naive**, and the sketches in my head count as mine, not
as given. No derivation was written before this commit.

### 1.4 The registered expectations (written before any derivation)

| statement | expected verdict | probability | the likeliest break |
|---|---|---|---|
| C121-C1-BOUND | derived | 0.85 | the "only if" direction: a component of `F_i` that reaches both inside and outside `T₁(x)`; the argument needs every component to be a chain of face closures, which needs faces to be locally finite — wild Jordan edges could break that |
| C121-C1-GMAP | derived | 0.85 | (i) rests on BOUND's "only if"; (ii)'s biconditional may be vacuous in one direction, or "six-colouring" may exclude colourings using fewer colours |
| C121-C1-SAT | derived | 0.80 | edge points where one side has density 0 (a cusp, or a corner of a chain): saturation says nothing there, and only a closure argument can reach them; "every total order" needs both colours bound, not just the smaller |
| C121-C1-COVMAP | derived | 0.85 | an order under which every edge point is bound by its smaller colour — i.e. an order with no colour lying between the colours of two opposite neighbours; or a merged-map edge that is not where I expect |
| C121-C1-FLAT | derived | 0.85 | whether the unit parallels stay `C^∞` graph germs with curvature exactly 0 for every `k ∈ ℤ` simultaneously, and whether the order `U_k > L_k` survives on both sides at every level |

Each prediction is scored at stage 2 against the committed verdict (the gate prints the Brier score).

## Stage 2 — SAVED: the five derivations, the attacks, and the verdicts

*Written 07:29–07:41 UTC (corrected at stage 3: the first text of this line gave a guessed end time, 03:20; the commit is 02:41), before any fenced path was opened. Each derivation is this mind's own, from the statement and the definitions of
§ 1.2. Notation: a locally finite map colouring `M` has graph `Γ`, faces (components of `ℝ² ∖ Γ`), `S_j` the union of the faces of colour `j`,
`F_j = cl S_j`; `j`-bound means `T₁(x) ∩ F_j ≠ ∅` (§ 1.2). "Level" means the outer unit parallel `{d_K = 1}` or the far level `{D_K = 1}` of a
component `K`.*

### Plane-graph facts used, cited

- **PG1** (classical; e.g. Mohar–Thomassen, *Graphs on Surfaces*, § 2.1 — recalled, not read): the complement of a finite plane graph (finitely many
  Jordan arcs meeting only at endpoints) has finitely many components.
- **PG2** (the same source, recalled, not read): an interior point of an edge of a plane graph lies in the closure of at most two faces, the faces on
  the edge's two sides, and these are the same two faces at every interior point of the edge.
- **SEP** (classical, the crossing lemma for a closed topological quadrilateral; e.g. Newman, *Elements of the Topology of Plane Sets of Points*,
  ch. V — recalled, not read): a closed set that separates two opposite sides of a closed quadrilateral contains a continuum meeting the other two
  sides.

### Derivation of C121-C1-BOUND

**The "if" direction.** Let `K` be a component of `F_i` (closed: components of a closed set are closed). If `d_K(x) = 1`, the distance to the closed
set `K` is attained, so some `p ∈ K ⊆ F_i` has `|x − p| = 1`. If `D_K(x) = 1`, then `K ⊆ B̄(x, 1)` is compact and the supremum is attained, so again
some `p ∈ K` has `|x − p| = 1`. Either way `T₁(x)` meets `F_i`: `x` is `i`-bound. (No hypothesis on `x` or on `M` is used.)

**Lemma V4-LF (faces are locally finite).** In a locally finite map colouring every bounded set meets only finitely many faces.
*Proof.* Let `B = B(y, r)`, `B₂ = B(y, 2r)`, and `G` the finite plane graph of the arcs of `Γ` meeting `cl B₂` (with any isolated vertices there);
`Γ ∩ cl B₂ ⊆ G`. A face contained in `B₂` has its frontier in `Γ ∩ cl B₂ ⊆ G`, so it is open and closed in `ℝ² ∖ G`, a component of it: finitely
many by PG1. Suppose infinitely many faces meet `B`; then infinitely many meet `B` and leave `B₂`, and each (open, connected) contains a path crossing
the closed annulus `A = cl B₂ ∖ B` from its inner to its outer circle; the crossings of distinct faces are disjoint. Choose more than `N′` of them, where
`N′` exceeds `(number of vertices of G) + (number of arcs of G)·(1 + 1/ε)`, `ε` a modulus of uniform continuity of the arcs of `G` for the distance
`r`. Cyclically consecutive crossings bound disjoint quadrilaterals in `A`; in each, a path from one crossing to the other avoiding `Γ` would join two
distinct faces, so `Γ ∩ A ⊆ G` separates the two crossings, and by SEP contains a continuum `Z` joining the inner circle to the outer, `diam Z ≥ r`.
The continua of different quadrilaterals are disjoint (each lies in `Γ`, so off the crossings, which lie in faces). At most `#V(G)` of them contain a vertex of `G`; each of the others is a connected subset of
the interior of one arc, hence a sub-arc of diameter `≥ r`, and one arc holds at most `1 + 1/ε` disjoint such sub-arcs. So there are at most `N′`
continua, a contradiction. ∎

**Lemma V4-SWITCH (no component straddles the unit circle of a point of `F_i`).** In a locally finite map colouring, for every `x ∈ F_i` and every
component `K` of `F_i`: `d_K(x) ≥ 1` or `D_K(x) ≤ 1`.
*Proof.* Suppose `d_K(x) < 1 < D_K(x)`: pick `y, z ∈ K` and `η > 0` with `|y − x| < 1 − 2η`, `|z − x| > 1 + 2η`. The set `Q₀ = S_i ∩ B(x, η)` is open
and non-empty (`x ∈ cl S_i`), so it has positive measure. Call `q ∈ Q₀` *bad* if `q ∈ T₁(v)` for a vertex `v` of `Γ` in `B̄(x, 2)`, or if some edge of
`Γ` meeting `B̄(x, 2)` contains a non-degenerate arc of `T₁(q)`. For one Jordan arc `e`, the `q` whose unit circle has a non-degenerate arc inside `e`
are countably many: two distinct unit circles share at most two points, so the corresponding sub-arcs of `e` are images of parameter intervals with
disjoint interiors. Finitely many vertices and edges meet `B̄(x, 2)`, so the bad set is a finite union of circles and a countable set: null. Fix a good
`q ∈ Q₀`. Now `|y − q| < 1 − η` and `|z − q| > 1 + η`.
(1) `S_i ∩ T₁(q) = ∅`: `q ∈ S_i`, and no two points of faces of colour `i` are at distance 1. So `S_i = V_in ⊔ V_out` with `V_in = S_i ∩ B(q, 1)`,
`V_out = S_i ∖ B̄(q, 1)`, and `F_i = cl V_in ∪ cl V_out`.
(2) `y ∈ cl V_in` (every point of `S_i` near `y` lies in `B(q, 1)`), and `z ∈ cl V_out`. `K` is connected and covered by the two closed sets
`cl V_in ∩ K`, `cl V_out ∩ K`, both non-empty; so some `w ∈ K` lies in both, and then `|w − q| = 1`.
(3) `w ∈ Γ`: `w ∉ S_i` by (1), and `w` lies in no face of another colour (such a face is open and misses `cl S_i`). By V4-LF finitely many faces meet
`B(w, ρ₀)`; since `V_in` and `V_out` meet every `B(w, ρ)`, some face `φ ⊆ V_in` and some face `ψ ⊆ V_out` have `w` in their closures, and `φ ≠ ψ`
(a face is connected and misses `T₁(q)`, so it lies wholly inside or wholly outside).
(4) `w` is not a vertex, since `q` is good. So `w` is an interior point of exactly one edge `e`, and by PG2 `φ` and `ψ` are the only faces whose
closures contain `w`; the finitely many other faces near `w` are at positive distance, so for small `ρ`, `B(w, ρ) ∖ e ⊆ φ ∪ ψ`. No point of `φ ∪ ψ`
lies on `T₁(q)`, so the non-degenerate arc `T₁(q) ∩ B(w, ρ)` lies in `e` — and `q` is bad. Contradiction. ∎

**The "only if" direction.** Let `x ∈ F_i ∖ S_i` be `i`-bound: `|x − p| = 1` for some `p ∈ F_i`; let `K` be the component of `F_i` containing `p`.
Then `d_K(x) ≤ 1 ≤ D_K(x)`, and by V4-SWITCH `d_K(x) ≥ 1` or `D_K(x) ≤ 1`: so `d_K(x) = 1` (outer unit parallel of `K`) or `D_K(x) = 1` (far
level of `K`). ∎

**Corollary V4-DIAM.** Every component of `F_i` has diameter at most 1 (V4-SWITCH with `x ∈ K`: `d_K(x) = 0`, so `D_K(x) ≤ 1`).

*Uses only:* (a) no two points of `S_i` at distance exactly 1; (b) `x ∈ cl S_i`; (c) local finiteness of `Γ`, through V4-LF and PG2 at the switch
point. *Not used:* `x ∉ S_i` (for `x ∈ S_i` both sides are false, so the restriction costs nothing); that `Γ` is null; any other colour.
*Model:* SQ9 (control `fs121-v4-sq9`: 164 exact edge points of the base square, each bound by both colours and each on a level, 328 of 328).

#### Attack on C121-C1-BOUND

- **Smallest cases.** One colour-`i` face `φ` with `F_i = cl φ`: `x ∈ ∂φ` is bound iff `D_{cl φ}(x) = 1`, the far level. SQ9's squares: an edge point
  of a square is on no level of its own square (`D ≤ √2/2`) and on the outer unit parallel of the facing same-colour square (`d = 1` exactly); R7's
  Reuleaux triangles: every boundary point is on its own far level (constant width 1).
- **Each hypothesis removed.** *Properness (no unit pairs in `S_i`)*: with the squares shrunk to side `12/25` (same colouring, same-colour gap
  `24/25`), every sampled edge point is bound through a square its unit circle crosses and lies on no level — 0 of 328 agree (control
  `fs121-v4-sq9`'s fault). The hypothesis is used, and this is **where the attack succeeds**. *`x ∈ F_i`*: in SQ9 the centre `(5/4, 1/4)` of square
  `(2, 0)` (colour `(2, 0)`) has `d = 3/4 < 1 < √26/4 = D` to the colour-`(0, 0)` square `(0, 0)`, so it is `(0, 0)`-bound and on no level of that
  square; its other colour-`(0, 0)` squares are at distance `≥ 5/4` or within `D < 1`. So the "only if" fails off `F_i`: the hypothesis `x ∈ F_i`
  is used (it enters V4-SWITCH through `Q₀ ≠ ∅`). *Local finiteness*: not decided without it — the proof uses it at the switch point (V4-LF, PG2),
  and I found neither a proof without it nor a counterexample.
- **The converse** (the "if" half) is unconditional (above).
- **Wording.** The definition's "at distance exactly 1 from `F_j`" read as set distance would make the "if" half false at every far-level point
  (such a point lies in `F_i`, at set distance 0); the "i.e." clause fixes the reading, and I derived under it (§ 1.2).

### Derivation of C121-C1-GMAP

**(i).** Let `(A_1, …, A_k)` be Grundy-bound and `A_j = S_j` a.e. for each `j`, `M` a locally finite map colouring. For a measurable set, `supp`
depends only on its null-set class, and for `S_j`, a union of open faces, `supp S_j = cl S_j = F_j` (a point of the closure has every ball meeting
the open set `S_j` in a non-empty open set; a point off the closure has a ball missing it). So `supp A_j = F_j`. Let `e` separate colours `i < m`
and `x ∈ e`: `x` lies in the closure of a face of colour `m` (PG2: that face is a side of `e` at every interior point, and endpoints are limits of
interior points), so `x ∈ F_m = supp A_m`, and the Grundy clause gives `T₁(x) ∩ supp A_i ≠ ∅`: `x` is `i`-bound. Likewise `x ∈ F_i`, and `x ∈ Γ`,
so `x ∉ S_i`. By C121-C1-BOUND's "only if" `x` is on a level of a component of `F_i`. Every point of every separating edge is covered: `M ∈ 𝒫_k`
under `1 < 2 < … < k`. ∎
*Uses only:* the Grundy clause and BOUND's "only if". *Not used:* that `A_1` is a MUA set or that the `A_m` are maximal (the § 7.0 definition of
Grundy-bound carries only the clause, so nothing idle).
*Inhabitant.* R7 is Grundy-bound under every order: at every point of `supp A_m` no other colour has density 1 (interior points of a tile have
density 1 for their own colour only; the lattice points carry three 120° Reuleaux sectors and three cusps; arc points 1/2 and 1/2), so
FS111-VMW-R7-MAX ("for every point x and every colour j with x ∉ S̃_j, some point of cl S̃_j is at distance exactly 1 from x", hand, one mind) gives
every clause. So (i)'s hypothesis class is inhabited at `k = 7`, as the statement says.

**(ii).** *First clause.* Suppose G-FIN₆ and C121-NOPAR, and `χ_m⁰(ℝ²) ≤ 6`: a measurable `k`-colouring proper at almost every unit pair exists
with `k ≤ 6`; read into `[6]` (or, if a six-colouring must use six non-null classes, split one class by a line — each part keeps null unit pairs),
it is an a.e.-proper measurable six-colouring. G-FIN₆ gives a Grundy-bound six-colouring a.e. equal, class by class, to a locally finite map
colouring `M`; by (i) `M ∈ 𝒫_6`, against C121-NOPAR. So `χ_m⁰(ℝ²) ≥ 7`. *Second clause.* Given C121-NOPAR: "G-FIN₆ ⟹ `χ_m⁰ ≥ 7`" is the first
clause; conversely, if `χ_m⁰(ℝ²) ≥ 7` no a.e.-proper measurable six-colouring exists, so G-FIN₆'s antecedent is false and G-FIN₆ holds. ∎
*Uses only:* (i), the definition of `χ_m⁰` (row 130's), and, for the "if", nothing but vacuity — C121-NOPAR is idle there.

#### Attack on C121-C1-GMAP

- **(i), each hypothesis removed.** *The Grundy clause*: the tight hexagonal seven-colouring is a locally finite map colouring whose edge midpoints
  are bound by neither side colour (its hexagon's farthest point from an edge midpoint is `√13/4 < 1` away, the nearest other same-colour hexagon
  more than `2.29 − 0.94 > 1`), so it lies in no `𝒫_7`: without the clause (i) fails — **where the attack succeeds**. *Class-by-class a.e.
  equality*: with a relabelling allowed, the conclusion holds under the relabelled order and not under `1 < … < k` in general; G-FIN₆'s
  parenthetical fixes the labels, and (i) is read that way.
- **(ii).** The biconditional has one vacuous half: G-FIN₆ holds trivially when `χ_m⁰(ℝ²) ≥ 7`. So its content is that, given C121-NOPAR, G-FIN₆
  is the answer restated (as `CLAUDE.md` § Where the problem stands says of each route's third statement). Without C121-NOPAR the "only if" is not
  a theorem: G-FIN₆ then says only that a Grundy-bound map six-colouring exists when a six-colouring does, which contradicts nothing held.
- **"Six-colouring".** Both readings (at most six colours; exactly six non-null classes) give (ii) — above.

### Derivation of C121-C1-SAT

Let `M` be a locally finite map colouring with `k` colours, edges finite chains of segments and circular arcs, whose classes form an honest
saturated colouring. Fix any total order, an edge `e` separating `i` and `m`, and a point `x` interior to one of `e`'s finitely many pieces. Near `x`,
`Γ` is that smooth piece alone (other edges, and the other pieces of `e`, are compact sets missing `x`), which splits a small disc into two sides;
by PG2 the sides are the two faces `e` bounds, of colours `i` and `m`. A segment or circular arc through `x` gives each side density `1/2` at `x`, so
`x ∉ S̃_j` for every `j`, `x ∈ ∂_e S_i`, and `P(x) = {i, m}`. Saturation: `T₁(x)` meets `supp S_i = F_i` and `supp S_m = F_m` — `x` is `i`-bound and
`m`-bound. The set `B_j = {x : T₁(x) ∩ F_j ≠ ∅}` is closed (if `x_n → x` with `p_n ∈ F_j ∩ T₁(x_n)`, the `p_n` are bounded; a limit point `p ∈ F_j`
has `|x − p| = 1`), and the interior points of the pieces are dense in `e`; so every point of `e` is `i`-bound and `m`-bound. Every point of `e` lies
in `F_i ∖ S_i` and in `F_m ∖ S_m`, so by C121-C1-BOUND's "only if" it is on a level of a component of `F_i` and on one of `F_m` — of the smaller
colour's, whichever it is. So `M ∈ 𝒫_k` under every total order. ∎
**The "so" clause.** If an honest saturated six-colouring `f` has `f⁻¹(j) = S_j` a.e. for such an `M`, then `M`'s classes form an honest saturated
colouring: every notion in saturation (`S̃_j`, `d̄_j`, `P(x)`, `∂_e S_j`, `supp`) depends only on the classes up to null sets, `M`'s classes are
disjoint and `Γ` is null (colour it anyhow for one colour per point), and `M` is a.e.-proper (no unit pairs among face points). So `M ∈ 𝒫_6`,
against C121-NOPAR. ∎
*Uses only:* saturation at points where both sides have positive density; the closedness of `B_j`; BOUND's "only if". The chain hypothesis enters
once, to put a dense set of points on each edge where both side densities are positive; any edges with that property would do, but I hold no honest
saturated map colouring outside the stated class, so I report no thin truth (by FS111-M2-INTRAD, under REG-J′, honest saturated interfaces are such
chains anyway).

#### Attack on C121-C1-SAT

- **Smallest case, exactly.** SQ9: 164 edge points of the base square, every one bound by both colours (control `fs121-v4-sq9`), so SQ9 is in `𝒫_9`
  under every order at those points, as the inhabitant line says.
- **Saturation removed.** The tight hexagonal seven-colouring: tight, not saturated, and its edge midpoints are bound by neither side (above): it
  lies in no `𝒫_7` — the hypothesis is used, and **the attack succeeds** there ("tight" in place of "saturated" is false).
- **Density-zero edge points.** At a corner or a cusp of a chain, one side may have density 0 and saturation says nothing about that colour; the
  closedness of `B_j` carries the binding there from the smooth points. This was the registered likeliest break, and it does not break.
- **"Every total order".** Needs both colours bound at every edge point, which saturation gives; an argument that bound only the smaller colour would
  prove membership under one order only.
- **The converse** (not claimed): not examined.

### Derivation of C121-C1-COVMAP

*The object* (§ 1.2): discs `D_c = B̄(c(m, n), 1/2)`, `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)`, colour `(m + 3n) mod 7`. Neighbouring centres are
`√3/2` apart; each disc's boundary circle is cut by the six hexagon vertices on it into six 60° arcs, the arc facing the neighbour in direction `v`
lying inside the open disc of that neighbour; same-colour centres are `√21/2 ≈ 2.29` apart; no point lies in three open discs. The six neighbours of a
disc of colour `ℓ` have colours `ℓ ± 1, ℓ ± 3, ℓ ± 2`, opposite neighbours having colours `ℓ + s` and `ℓ − s`: the three **opposite pairs** partition
the six other colours.

*The merged map* under an order `<`: a lens `D_d ∩ D_c` (neighbours) is coloured `min(d, c)`; a point of one disc only by that disc's colour. It is a
locally finite map colouring: `Γ` is the union of the circles; a face of colour `j` lies in an open disc of colour `j` (diameter < 1) and different
discs of one colour are more than `1.29` apart.

**Lemma V4-EDGE.** Let `D_d` have neighbours `c` (direction `v`) and `c′` (direction `−v`), and `x` a relative-interior point of the arc `α` of `∂D_d`
inside `D_c`. (a) If `d < c`, `α` is an edge of the merged map separating `d` (the lens, inside `D_d`) and `c` (outside `D_d`, inside `D_c` only).
(b) `x` is never `c`-bound. (c) `x` is `d`-bound iff `d < c′`.
*Proof.* (a) Near `x` only `D_d` and `D_c` contain points. (b) `|x − c| < 1/2`, so every point of `D_c` is within `|x − c| + 1/2 < 1` of `x`; every
other colour-`c` centre is at least `√21/2 − 1/2 > 3/2` from `x` (exactly: control `fs121-v4-covmap`, item (c)), so `T₁(x)` misses every
colour-`c` disc, and `F_c` lies in their union. (c) The only point of `D_d` at distance 1 from `x ∈ ∂D_d` is the antipode `x′ = 2c_d − x`; every other
colour-`d` centre is more than `3/2` from `x`. `x′` is a relative-interior point of the arc of `∂D_d` inside `D_{c′}` and lies in no third disc; near
`x′` every point is in `D_{c′}`, coloured `min(d, c′)` inside `D_d` and `c′` outside. So `x′ ∈ F_d` iff `d < c′`. ∎

**Lemma V4-MID (the parity count).** Under every total order of the seven colours, the colour `d` of rank 4 has an opposite pair `(c′, c)` with
`c′ < d < c`. *Proof.* Three colours lie below `d` and three above; the three opposite pairs of a colour-`d` disc partition the six; three is odd, so
the colours below `d` cannot be a union of pairs, and some pair has one colour below and one above. ∎

**The statement.** Fix an order; take `d` of rank 4 and its straddling pair `c′ < d < c` (V4-MID). By V4-EDGE (a) the arc of `∂D_d` inside `D_c` is
an edge separating `d` and `c`; by (b) and (c) each of its relative-interior points is bound by neither. The smaller colour `d` is not bound there,
so by C121-C1-BOUND's "if" half (contrapositive) the point is on no level of any component of `F_d`, and the merged map is not in `𝒫_7` under this
order. ∎
*Exact control* (`tools/fs121_v4_covmap.py`, arithmetic in `ℚ(√3)`, no floating point): the geometry (a)–(d) at the six arc midpoints of the base
disc over every centre with `|m|, |n| ≤ 8` — ALL PASS; over all 5040 orders, every one has an edge point bound by neither colour, the least number of
unbound (colour, direction) edge types in any order being 5; the rank-4 colour is straddled under every order. Plants: DISC7's classes themselves
(each disc its own far level) give 0 of 5040; the arc midpoint moved to a hexagon vertex fails the geometry.
*Uses only:* the hexagonal seven-colouring's neighbour structure (every colour once among the six neighbours, opposite pairs `ℓ ± s`), the disc
radius `1/2`, same-colour separation `√21/2`, and BOUND's trivial half.

#### Attack on C121-C1-COVMAP

- **Where it succeeds.** The colour of rank 1 is below both colours of every opposite pair, so every edge it bounds is `d`-bound (`d < c′`); likewise
  rank 7 bounds no separating edge as the smaller colour. So "every separating edge has an unbound point" is false, and so is "some unbound edge in
  every colour": the unbound edges live at the middle ranks (at least 5 of the 42 edge types in every order, exactly).
- **DISC7's classes themselves** (the *not claimed* line): every arc point is bound by its own disc — the cover plant — 0 of 5040 orders have an
  unbound point. This confirms the *not claimed* line; it is not a counterexample.
- **The order quantifier.** No order escapes: V4-MID by parity, and the exhaustive count agrees.

### Derivation of C121-C1-FLAT

*The witness.* In the chain's frame (`a = (1, 0)`, `n = (0, 1)`, `P_k = (0, k)`): `p(t) = (t, t⁴)`, `ν(t)` its unit normal with positive
`n`-component, and for every `k ∈ ℤ`
- `L_k`: the germ at `P_k` of the line `{(t, k)}`;
- `U_k`: the germ at `P_k` of `q_k(t) = p(t) + kν(t)`.

*Why it works.* (1) `q_k′ = (1 − kκ(t))·p′`, `κ` the curvature of `p` (Frenet: `ν′ = −κ|p′|T`), and `κ(0) = 0`, so near `t = 0` the factor is
positive: `q_k` is a regular curve through `q_k(0) = P_k` with unit tangent `T(t)` and the same unit normal `ν(t)` (positive `n`-component). Hence
`q_{k−1}(t) + ν(t) = q_k(t)`: **`U_k` is the unit parallel toward `P_k` of `U_{k−1}`**, for every `k` (the definition's `{p + ν(p)}` applied to
`U_{k−1}`, whose normal at the parameter `t` is `ν(t)`). The lines satisfy `L_k = L_{k+1} − n`: **`L_k` is the unit parallel toward `P_k` of
`L_{k+1}`**. (2) `q_k′(0) = a`, so near `P_k` the curve `U_k` is the graph of a real-analytic (so `C^∞`) function `Y_k` with `Y_k(0) = Y_k′(0) = 0`
(inverse function theorem on `X_k(t) = t − 4kt³ + O(t⁹)`). (3) `Y_k(t) = t⁴ + k(1/s(t) − 1) = t⁴ − 8kt⁶ + O(t¹²)`, `s = √(1 + 16t⁶)`: positive for
small `t ≠ 0` of either sign, and `X_k(t) ≠ 0 ⟺ t ≠ 0` near 0; so **`U_k > L_k` on both sides of `P_k`**. As a graph `Y_k(X) = X⁴ + 8kX⁶ + O(X⁸)`.
(4) The curvature of `U_k` at `P_k` is `κ(0)/(1 − kκ(0)) = 0`, and each `L_k` is a line: **every germ has curvature 0 at `P_k`**. ∎
The parenthesis follows: the curvatures are `λ_k = υ_k = 0`, and `f(0) = 0 = f̃(0)` (`f(λ) = λ/(1 + λ)`, `f̃(υ) = υ/(1 − υ)`, FS110-N4-SHADOW), so
the relations hold with equality.
*Symbolic control* (`tools/fs121_v4_flat.py`, sympy, `k` a free symbol — every `k` at once): (1) `q_k′ × p′ ≡ 0`; (2) `q_k′(0) = (1, 0)`; (3)
`q_k(0) = P_k`; (4) `Y_k(t) = t⁴ − 8kt⁶ + O(t⁸)`; (5) curvature 0 at `P_k`; (6) `Y_k(X) = X⁴ + 8kX⁶ + O(X⁸)` — ALL PASS. Plants: `p = (t, t³)` fails
(4) (the lowest term `t³` changes sign: not above on both sides); `p = (t, t²)` fails (2), (4) and (5).
*Uses only:* that parallel curves share normals and that offsets of a curve whose curvature vanishes at a point are regular near it; any `C^∞`
graph germ with `Y(0) = Y′(0) = Y″(0) = 0` and `Y > 0` off 0, taken with its own parallels, would do.

#### Attack on C121-C1-FLAT

- **Where it succeeds: strictness at second order.** Asked with the curvatures strictly ordered (`λ_k < υ_k`), no family exists: that is
  FS110-N4-FIN as held (hand, two minds). And asked with circular-arc germs (N4-FIN's own objects): curvature 0 makes every germ a segment through
  `P_k` with tangent `a`, so `U_k = L_k` and the strict order fails. The statement lives exactly in the gap between these two: germs that agree to
  second order and differ at fourth.
- **One window for every `k`.** Not claimed, and false for this witness: the offset at distance `k` has a cusp where `kκ(t) = 1`, and
  `κ(t) = 12t² + O(t⁸)`, so for `k → +∞` the cusp parameter tends to 0 (like `(12k)^{−1/2}`) and the window on which `U_k` is a graph shrinks. The
  germ statement needs no common window; a reader who wants one cannot have it from this witness. Whether every witness shares this I did not decide
  (one of `L_0`, `U_0` must bend near `P_0`, else both are the same segment, but I did not track the cusp's `X`-coordinate in general).

### The verdicts

Every block below was written before any fenced path was opened; `committed:` is this stage's commit date (its hash is added at stage 3).
`minds: 2` counts the cover route's author and this mind, independent on information (the fence) and on the criterion (statements fixed, predictions
registered at stage 1), **not** on prior: blind, the same model (Opus 5.5). The method axis is read at stage 3.

verification: C121-C1-BOUND
  statement: in a locally finite map colouring, a point `x` of `F_i ∖ S_i` is `i`-bound if and only if it lies on the outer unit parallel or on the
    far level of a connected component of `F_i`.
  given: the statement with its not claimed line; the frozen claim list's §§ 0–7 (definitions, held inputs, the other statements); the brief's
    framing, quoted in § 1.3; the held control objects' entries; nothing from the cover route's author
  committed: 2026-09-29, commit 0dde4982
  predicted: derived — 0.85 — likeliest break: the only-if half, at a component reaching both inside and outside the unit circle; faces must be locally
    finite for the argument
  verdict: derived
  method: a switch-point argument — a component straddling `T₁(q)` for a generic `q ∈ S_i` near `x` must touch it at a point where `T₁(q)` runs
    inside an edge, which a generic `q` avoids (V4-SWITCH), over the local finiteness of faces (V4-LF, proved here from PG1 and SEP); the first
    derivation argues by perturbation (a point of an open face near `x` and a point of `F_i` on its unit circle, moved together onto a face pair at
    distance 1), with no local finiteness
  attack: § Attack on C121-C1-BOUND
  divergences: § Divergences on C121-C1-BOUND
  counterexamples: none — attacked with properness removed (SQ9 shrunk to side 12/25: bound, on no level) and with `x ∈ F_i` removed (the centre of
    an SQ9 square of another colour: bound, on no level); both remove a hypothesis, so neither refutes; local finiteness removed: not decided by this
    mind — decided at stage 3 by reading the entry's argument, which does not use it (given, not brought)
  minds: 2 — blind to: the cover route's proof record and data until commit 0dde4982; method: a different route (switch point over V4-LF against the
    entry's perturbation); the same model (Opus 5.5)
  grade: hand

verification: C121-C1-GMAP
  statement: (i) for every `k`, a Grundy-bound `k`-colouring that is a.e. equal to a locally finite map colouring makes that map colouring a member of
    `𝒫_k` under the order `1 < 2 < … < k`; (ii) G-FIN₆ and C121-NOPAR together imply `χ_m⁰(ℝ²) ≥ 7`, and given C121-NOPAR, G-FIN₆ holds if and only
    if `χ_m⁰(ℝ²) ≥ 7`.
  given: the statement with its not claimed line; the frozen claim list's §§ 0–7 (definitions, held inputs, the other statements); the brief's
    framing, quoted in § 1.3; the held control objects' entries; nothing from the cover route's author
  committed: 2026-09-29, commit 0dde4982
  predicted: derived — 0.85 — likeliest break: (i) inherits BOUND's only-if half; (ii) may be vacuous in one direction, or a six-colouring may be
    read as using six non-null classes
  verdict: derived
  method: (i) the support of a union of open faces is its closure, the Grundy clause makes every separating edge point bound by the smaller colour,
    and BOUND's only-if half places it on a level; (ii) by contradiction through (i), the if half by vacuity; the first derivation runs the same
    route
  attack: § Attack on C121-C1-GMAP
  divergences: § Divergences on C121-C1-GMAP
  counterexamples: none — attacked with the Grundy clause removed (the tight hexagonal seven-colouring: in no 𝒫_7) and with relabelling allowed;
    (ii)'s if half is vacuous (a finding about content, not a counterexample)
  minds: 2 — blind to: the cover route's proof record and data until commit 0dde4982; method: the same route as the entry, so one mind on that axis;
    the same model (Opus 5.5)
  grade: hand

verification: C121-C1-SAT
  statement: for every `k`, a locally finite map colouring with `k` colours whose edges are finite chains of segments and circular arcs, and whose
    classes form an honest saturated colouring, is a member of `𝒫_k` under every total order of its colours; so C121-NOPAR implies that no honest
    saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs.
  given: the statement with its not claimed line; the frozen claim list's §§ 0–7 (definitions, held inputs, the other statements); the brief's
    framing, quoted in § 1.3; the held control objects' entries; nothing from the cover route's author
  committed: 2026-09-29, commit 0dde4982
  predicted: derived — 0.80 — likeliest break: edge points where one side has density 0, where saturation is silent; every order needs both colours
    bound
  verdict: derived
  method: saturation at the interior points of the smooth pieces binds both side colours, the bound set is closed so the binding reaches every edge
    point, and BOUND's only-if half places each on a level of both colours; the so clause by null-set invariance of saturation; the first derivation
    runs the same route
  attack: § Attack on C121-C1-SAT
  divergences: § Divergences on C121-C1-SAT
  counterexamples: none — attacked with saturation removed (the tight hexagonal seven-colouring: in no 𝒫_7) and at density-zero edge points (closed
    by the closedness of the bound set); exact on SQ9, 164 of 164 edge points bound by both colours
  minds: 2 — blind to: the cover route's proof record and data until commit 0dde4982; method: the same route as the entry, so one mind on that axis;
    the same model (Opus 5.5)
  grade: hand

verification: C121-C1-COVMAP
  statement: under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that order, of a disc
    containing them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in `𝒫_7` under no order.
  given: the statement with its not claimed line; the frozen claim list's §§ 0–7 (definitions, held inputs, the other statements); the brief's
    framing, quoted in § 1.3; the held control objects' entries, DISC7's formula (FS111-M2 § 1.6); nothing from the cover route's author
  committed: 2026-09-29, commit 0dde4982
  predicted: derived — 0.85 — likeliest break: an order under which no colour lies between the colours of two opposite neighbours
  verdict: derived
  method: an arc point of `∂D_d` inside `D_c` is bound by `d` only through its antipode, which lies in the lens with the opposite neighbour `c′`, so it
    is unbound exactly when `c′ < d < c`; the colour of rank 4 always has such a pair by parity (V4-MID); exact control over all 5040 orders in
    `ℚ(√3)`; the first derivation takes the colour of rank 2 (its least-coloured neighbour's opposite is above it), the same mechanism
  attack: § Attack on C121-C1-COVMAP
  divergences: § Divergences on C121-C1-COVMAP
  counterexamples: none — all 5040 orders checked exactly, each with an unbound edge point (at least 5 unbound edge types each); DISC7's own classes
    (every point bound) confirm the not claimed line
  minds: 2 — blind to: the cover route's proof record and data until commit 0dde4982; method: a different choice of colour (rank 4 by parity against
    rank 2) over the same mechanism, and an independently written exact tool on a congruent copy of the object; the same model (Opus 5.5)
  grade: hand

verification: C121-C1-FLAT
  statement: there are germs `L_k`, `U_k` at `P_k`, for every `k ∈ ℤ`, with `U_k > L_k` on both sides of `P_k`, every one of curvature 0 at `P_k`,
    such that for every `k`: `L_k` is the unit parallel toward `P_k` of `L_{k+1}`, and `U_k` is the unit parallel toward `P_k` of `U_{k−1}`. (So the
    relations `plans/FS110-derivation.md` states on circular arcs as "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and
    `f̃(υ_{k−1}) ≤ υ_k`", read on germs with `L_k` below the parallel of `L_{k+1}` and `U_k` above the parallel of `U_{k−1}`, hold with equality for
    every `k`, and `λ_k = υ_k = 0`.)
  given: the statement with its not claimed line; the frozen claim list's §§ 0–7 (definitions, held inputs, the other statements); the brief's
    framing, quoted in § 1.3; FS110-N4-SHADOW and FS110-N4-FIN as held; nothing from the cover route's author
  committed: 2026-09-29, commit 0dde4982
  predicted: derived — 0.85 — likeliest break: whether the parallels stay smooth graph germs with curvature exactly 0 at every level at once, with the
    order kept on both sides
  verdict: derived
  method: an explicit witness — `L_k` the lines through `P_k`, `U_k` the parallels at distance `k` of the quartic `(t, t⁴)`; parallel curves share
    normals, so each relation is an identity in the parameter; symbolic control with `k` free; the first derivation chose the same witness
  attack: § Attack on C121-C1-FLAT
  divergences: § Divergences on C121-C1-FLAT
  counterexamples: none — the neighbours fail as expected: strict curvature order (FS110-N4-FIN) and circular-arc germs (then `U_k = L_k`); the
    witness has no common window for all `k` (not claimed)
  minds: 2 — blind to: the cover route's proof record and data until commit 0dde4982; method: the same witness, chosen by both (one mind on that
    axis; the composition closed exactly here, through `X⁶` there); the same model (Opus 5.5)
  grade: hand

control: fs121-v4-covmap
  of: C121-C1-COVMAP — the merged map's geometry at the base disc and all 5040 orders, exact in Q(√3); fault: DISC7's classes themselves
  run: python3 ../tools/fs121_v4_covmap.py | tail -1
  expect: orders with an edge point bound by neither colour: 5040 of 5040; geometry: ALL PASS; plant = None
  fault: python3 ../tools/fs121_v4_covmap.py --plant cover | tail -1

control: fs121-v4-covmap-geometry
  of: C121-C1-COVMAP — the geometry items (a)–(d); fault: the arc midpoint moved to a hexagon vertex
  run: python3 ../tools/fs121_v4_covmap.py | tail -1
  expect: orders with an edge point bound by neither colour: 5040 of 5040; geometry: ALL PASS; plant = None
  fault: python3 ../tools/fs121_v4_covmap.py --plant vertex | tail -1

control: fs121-v4-flat
  of: C121-C1-FLAT — the witness family, symbolic in k; fault: the quartic replaced by a cubic (order fails on one side)
  run: python3 ../tools/fs121_v4_flat.py | tail -1
  expect: ALL PASS (plant = None)
  fault: python3 ../tools/fs121_v4_flat.py --plant cubic | tail -1

control: fs121-v4-flat-curvature
  of: C121-C1-FLAT — the witness family, symbolic in k; fault: the quartic replaced by a parabola (curvature 2 at P_0)
  run: python3 ../tools/fs121_v4_flat.py | tail -1
  expect: ALL PASS (plant = None)
  fault: python3 ../tools/fs121_v4_flat.py --plant parabola | tail -1

control: fs121-v4-sq9
  of: C121-C1-BOUND and C121-C1-SAT — SQ9's edge points, exact; fault: squares shrunk to side 12/25 (unit pairs), where the only-if half fails
  run: python3 ../tools/fs121_v4_sq9.py | tail -1
  expect: edge points 164; bound by both colours 164; bound <=> on a level 328 of 328; ALL PASS (plant = None)
  fault: python3 ../tools/fs121_v4_sq9.py --plant slack | tail -1

### The predictions, scored

All five registered at stage 1 as *derived*, at 0.85, 0.85, 0.80, 0.85, 0.85; all five met. Each named break was examined and did not break:
BOUND's only-if half needed the local finiteness of faces, which holds (V4-LF); SAT's density-zero points are reached by closedness; COVMAP's
orders cannot all avoid a straddle (parity); FLAT's germs are smooth graphs at every level. A calibration note against myself: five of five met at
0.80–0.85 is what an informed prediction looks like (§ 1.3 says routes had come to mind); it is weak evidence of calibration.

## Stage 3 — SAVED: the comparison with the cover route's proof record (§§ 2.1–2.5)

*Opened 2026-09-29 07:42 UTC, after the verdicts' commit 0dde4982; written 2026-10-03 from 14:36 UTC, after the stop the fence log records. The
first derivation is `plans/FS121-C1-proof.md` §§ 2.1–2.5 (FS121-C1, one mind, the same model). Every row below is classed; no row is of truth: the two
minds agree that all five statements are true as stated.*

#### Divergences on C121-C1-BOUND

| # | item | this route | the entry | class | resolution |
|---|---|---|---|---|---|
| 1 | the "only if" half | a switch point: for a generic `q ∈ S_i` near `x`, a component straddling `T₁(q)` touches it at a point where `T₁(q)` runs inside an edge (V4-SWITCH), over the local finiteness of faces (V4-LF, from PG1 and SEP) and PG2 | perturbation: `z` in an open face near `x`, `p ∈ C ∩ T₁(z)`; `p_n ∈ S_i → p` and `z_n = p_n + (z − p_n)/‖z − p_n‖ → z` give a face pair at distance exactly 1 | route | both stand; the entry's is two lines and uses no local finiteness. This route missed the perturbation — a point of `cl S_i` at distance 1 from a point of the open set `S_i` moves with it onto a pair of face points at distance 1 — and so built machinery the statement does not need |
| 2 | local finiteness | used (V4-LF, PG2); my attack: "removed: not decided" | "no local finiteness beyond `F_i = cl S_i`" | route | the entry's argument decides my open item: the "only if" half holds in any colouring whose classes are open sets with no unit pairs, so the statement's "locally finite" is idle for it. Found by reading — given, not brought; not counted as this mind's finding |
| 3 | the model line | R7 at `x = (1, √3 − 1)`: for the up colour, the far level of the up tile itself (constant width 1, its vertex `(1, √3)` at distance 1); for the down colour, the **outer unit parallel** of the same-colour down tile whose cusp is `(1, √3)` — that tile lies in `y ≥ √3`, so `d = 1` at the cusp alone and `D ≥ ‖x − (1/2, 3√3/2)‖ > 1` | "it is bound by both and lies on the far level of the component holding the centre", citing "FS111-VMW-R7-PPLUS's 432 of 432 arcs of kind both" | wording | true of the up colour only; for the down colour the level is the outer unit parallel. The count 432 of 432 is FS111-VM2-LAD-CTL's (`plans/FS111-VM2-verification.md`), not FS111-VMW-R7-PPLUS's (one named point and 69 samples). Reported to the author; the statement and its verdict are untouched |
| 4 | the statement's text | the frozen list's, with its backticks | the same words without backticks | wording | formatting only; a joint gate run would compare the two strings (not run here: it would print the still-fenced § 2.6) |

#### Divergences on C121-C1-GMAP

| # | item | this route | the entry | class | resolution |
|---|---|---|---|---|---|
| 1 | (i) | `supp` of a union of open faces is its closure; the Grundy clause binds every separating edge point by the smaller colour; BOUND's "only if" | the same three steps | route | the same route: no evidence on the method axis, and the `minds:` line says so |
| 2 | (ii), "six-colouring" | both readings worked: at most six colours, or six non-null classes (split one class by a line) | "if an a.e.-proper measurable six-colouring exists", the first reading implicitly | wording | (ii) holds under both; nothing to change |
| 3 | (i)'s inhabitant R7 | Grundy-bound in every order because no colour has density 1 at a point of another colour's support, so FS111-VMW-R7-MAX's "x ∉ S̃_j" clause covers every point of every support | "every class a MUA set (FS111-VMW-R7-MAX), so it is Grundy-bound in every order" | route | agree; this route writes out the step from "x ∉ S̃_j" to "every point of `supp A_m`" that the entry leaves implicit |

#### Divergences on C121-C1-SAT

| # | item | this route | the entry | class | resolution |
|---|---|---|---|---|---|
| 1 | the argument | densities 1/2 at interior points of the smooth pieces, saturation binds both colours, the bound set is closed, BOUND's "only if" | the same, the bound set closed as "a closed set plus a compact one" | route | the same route: one mind on the method axis |
| 2 | the entry's "What it says" | not derived here | "C121-NOPAR implies the honest route's NO … The cover route's NO is not an alternative to the honest route's: it contains it", over FS111-M2-REDUCE-A | wording | outside the five statements and not verified by this record; flagged so that no reader counts it as checked by two minds |
| 3 | the edge hypothesis | enters only through a dense set of edge points with both side densities positive | its *not claimed* adds "anything for edges that are not finite chains" | wording | consistent; no change |

#### Divergences on C121-C1-COVMAP

| # | item | this route | the entry | class | resolution |
|---|---|---|---|---|---|
| 1 | which colour carries the unbound edge | the colour of rank 4: three colours below it and three above, and its three opposite pairs partition the six, so one pair straddles it (V4-MID, parity) | the colour `c` of rank 2: its least-coloured neighbour `ℓ` has an opposite neighbour `d ∉ {ℓ, c}`, so `ℓ < c < d` | route | both valid, over one mechanism (the antipode lies in the lens of a lower colour); the entry's is constructive and shorter; this route adds that every order has at least 5 unbound edge types |
| 2 | coordinates | FS111-M2 § 1.6's: `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)`, colour `(m + 3n) mod 7` | `m u + n w`, `u = (3/4, √3/4)`, `w = (0, √3/2)`, colour `(m − 2n) mod 7` | wording | the same object up to a rotation and a relabelling: both are lattices of spacing `√3/2` at 60°; the entry's colour kernel holds `(2, 1)` and `(3, −2)`, both of norm `√21/2` at 60°; opposite pairs are `c ± 1, c ± 2, c ± 3` in both; the quantifier over every order makes the labels immaterial. The claim list names FS111-M2's DISC7; the entry's tool runs on a congruent copy, which carries every claim over |
| 3 | the exact controls | `tools/fs121_v4_covmap.py`: geometry over `max(‖m‖, ‖n‖) ≤ 8`, 5040 of 5040; plants: the cover's classes (0 of 5040) and a hexagon vertex (geometry fails) | `tools/fs121_c1_disc7.py`: 42 (least, second) pairs, 5040 of 5040; plant `--cover`, 0 of 5040 | route | two tools written apart, by the same model, agree on every count they share |

#### Divergences on C121-C1-FLAT

| # | item | this route | the entry | class | resolution |
|---|---|---|---|---|---|
| 1 | the witness | `L_k` the lines through `P_k`; `U_k` the parallels at distance `k` of `(t, t⁴)` | the same family | route | the same first choice by both minds: no evidence on the method axis, and the `minds:` line says so |
| 2 | the parallel relation | exact: `q_k′ = (1 − kκ)p′`, so the curves share normals and `q_{k−1} + ν = q_k` is an identity in `t`, symbolic in `k` | "parallels compose along shared normal lines, checked through `X⁶`" | route | both stand; this route closes the composition as an identity, the entry checks it as a series to order 6 with the same reason in words |
| 3 | smoothness | each `U_k` is a real-analytic graph near `P_k` (inverse function theorem on `X_k(t)`) | not discussed | route | the germ definition asks for `C^∞`; supplied here |
| 4 | the statement line | the frozen statement with its parenthetical "(So the relations … `λ_k = υ_k = 0`.)" | the entry's `statement:` line ends at "the unit parallel toward P_k of U_{k−1}", the parenthetical dropped (its content is in the prose, "N4-FIN's flank relations hold with equality") | wording | the parenthetical holds (all curvatures 0, `f(0) = f̃(0) = 0`); the entry's recorded statement is narrower than the frozen one by a consequence; the author restores it so the statement is quoted verbatim |
| 5 | windows | for this witness no common window serves every `k` (the offset at distance `k` has a cusp where `kκ(t) = 1`) | not discussed | route | an addition, not a disagreement; the germ statement asks for no common window |
| 6 | the plants | a cubic germ (order fails on one side), a parabola (curvature 2) | a circle-like germ `y = x²/20`, whose chain leaves `(−1, 1)` at `k = 9` (N4-FIN's mechanism) | route | different faults, each firing for its own reason |

### The count, audited

- **Information.** Before commit 0dde4982 this mind saw the claim list, the brief, the held entries named in § 1.1, and nothing of FS121-C1's record
  or data (fence log). The predictions were informed by my own unwritten route sketches (§ 1.3), not by anything given.
- **Prior and method.** Both minds are Opus 5.5. On the method axis: BOUND — different routes; COVMAP — a different choice over one mechanism, and
  separately written tools; GMAP, SAT, FLAT — the same route or the same witness, so one mind on that axis.
- **The criterion, fixed first.** The statements were frozen before either derivation reached me; the predictions were committed at stage 1 (3fe35d6c)
  before any derivation was written.
- **The statement, attacked.** Each attack located where it succeeds (properness and `x ∈ F_i` for BOUND; the Grundy clause for GMAP; saturation for
  SAT; the extreme ranks for COVMAP; strict curvature order and circular arcs for FLAT).
- **Retractions: 0.** No verdict withdrawn; one open item of my attack (BOUND without local finiteness) closed by reading the entry, recorded as given.
- **What the verification could not supply.** Whether these are the statements the cover route needs is a question for a reader of intent; in
  particular, whether C121-C1-COVMAP's merged map (with no clean-up step) is the map the cover route would in fact produce is the author's framing,
  not checked here.
