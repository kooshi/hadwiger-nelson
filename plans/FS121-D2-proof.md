# FS121-D2 — large-radius accumulation (C121-NOLRA) (Ephodos, derivation job, round 2)

*Ephodos (Opus 5.5), job FS121-D2, brief `data/fs121/briefs/FS121-D2-nolra.md` with `plans/STANDING-RULES.md` as part of it. Claim:
`data/fs121/claims.md` § 3 (frozen 2026-09-29 05:41 UTC). Plan: `plans/FS121-map-step.md`. I write only this record, `data/fs121/d2/`,
`tools/fs121_d2_*.py` and `data/fs121/reports/FS121-D2.md`. Entries use my identity's grammar; `hand` is [hand], `derived from` is [derived],
`computed over` is [tools]; verdict `derived` is TRUE, `gap:` is GAP. **Words used below** (this record's, not the list's): a *piece* is a
maximal circular arc or segment of an interface curve (FS111-M2-INTRAD (iii)'s "chain of segments and circular arcs"); a *junction* is a point
of an interface arc, off Σ, where two pieces meet; the *window* of a circular arc is the angle it subtends at its centre; a *radius-r arc* is a
maximal arc of one circle of radius r contained in the closure of the interface set; the *rung* of a piece γ (radius n, centre z) at level k,
`1 ≤ k ≤ n − 1`, is its parallel at distance k toward z (FS111-M2-INTRAD step (2)), an arc of radius n − k about z over γ's window.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, minds, address)*

- FS121-D2-INCURVED — LRA gives tangent-type interface arcs of finite radius ≥ 2 (a colouring with LRA inhabits C121-CURVED's class, cusps
  allowed) — [hand], one mind, elementary — § 1.3.
- FS121-D2-EXT — a rung (level 1 ≤ k ≤ n − 2, or any outward level) cannot follow its own circle past the normal line of a junction off Σ; cusps
  allowed — [hand], one mind — § 2.1.
- FS121-D2-THIN — LRA gives, for every r ≥ 2, infinitely many maximal radius-r interface arcs with windows tending to 0 (each LRA piece a thin pencil)
  — [derived] from FS121-D2-EXT, one mind — § 2.2.
- FS121-D2-SYM — ¬LRA wherever the radius-r arcs, for some r ≥ 2, have windows bounded below; in particular for every doubly periodic (cocompactly
  symmetric) colouring, at every k — [derived] from FS121-D2-THIN, one mind — § 2.3.
- FS121-D2-PERFIN — a doubly periodic honest saturated REG-J′ colouring carries finitely many radii (C121-PER's periodic clause without "satisfying
  ¬LRA") — [derived] from FS121-D2-SYM, one mind — § 2.3.
- C121-NOLRA — GAP at thin pencils in colourings without a cocompact symmetry (the periodic case decided by FS121-D2-SYM) — § 3.2.

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have searched for a saturated colouring with a curved interface whose pieces accumulate (a finder over piecewise-circular
  fronts with prescribed ladders). Did not; the recognition below asks what every LRA configuration must carry first.
- Stage 2: would have run a finder over thin pencils (curved pencils with windows tending to 0, with band subdivisions). Did not; derived what LRA
  forces (FS121-D2-THIN) and where it is excluded (FS121-D2-SYM).
- Stage 3: would have run a finder for an aperiodic saturated colouring with thin pencils. Did not; the open step is named for a derivation.

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript, no `chats-bak/`, no auto-memory beyond the index the harness showed at launch. I
write nothing where FS121-DB1 or FS116-V1 read: only the four paths above.

## Slips

- *(none)*

## Stage 1 — SAVED: the readback, and the recognition

### 1.1 Readback of the brief

Every quotation in the brief, and the plan sentences its paraphrases rest on, checked verbatim by `tools/fs121_d2_quotes.py` (whitespace
normalised, nothing else; a missing source, an empty file or a malformed row is a failure), input `data/fs121/d2/quotes-brief.tsv`, output
`data/fs121/d2/quotes-brief.out`: **8 of 8 found, exit 0**. The plant (the first quote altered by one character) is reported missing and fires
(`data/fs121/d2/quotes-brief-plant.out`, exit 0 as a fired plant). I read `RUNNING.md` § Make the gate fail before building the tool.
- C121-NOLRA and its *Not claimed* line (`data/fs121/claims.md` § 3): found.
- The brief's "the plan's P2 (0.3) says what follows …" paraphrases `plans/FS121-map-step.md` § 4.4 P2, found there verbatim (row 3); it matches.
- The brief's "row 134's N4 (curvature monotonicity along the shadow map) and a density count on the pencils' ends" paraphrases the plan's § 4.2
  D2 row, found verbatim (row 4); it matches.
- The brief's "such an accumulation, if it happens at one point, happens along the whole normal line through it at unit spacing, in both
  directions" paraphrases C121-LRA-LINE (row 5), and matches.
- The definitions the claim rests on: LRA (the list's § 0 and its source `plans/FS111-M2-regularity.md` § 4.1, rows 6 and 8) and ¬LRA (row 7): found.

**No mismatch.** **My claim, restated beside the quotation.** C121-NOLRA: in every honest saturated colouring in D-NF satisfying REG-J′ (Σ locally
finite, finitely many interface arcs at each point of Σ), any number of colours, no point is an accumulation point of interface pieces whose radii of
curvature tend to infinity. Verdict owed: TRUE, FALSE with a colouring by formula checked exactly, GAP at a named step, or MISSTATED; with its colour
count (every `k`) and its inhabitants (R7 at `k = 7`; SQ9 and HEX9 at `k = 9`; none has LRA).

### 1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall.** FS-111 left LRA open (`plans/FS111-M2-regularity.md` § 4.1: "*Not proved:* that only finitely many `n` occur near a point"); the opening
reduced it to a bi-infinite line (C121-LRA-LINE, one mind). Its shape is "a wall that describes a counterexample": the wall says what an LRA colouring
carries (a line of flat accumulation points), and no held colouring carries it. The cue (G79) is to ask what every LRA configuration must carry that an
actual colouring can be tested against — the example invariant.

**For a stranger** (a differential geometer who works on fronts, their parallels and their evolutes): *Take a partition of the plane into finitely
many measurable classes, none containing two points at distance exactly 1, whose class boundaries away from a locally finite set Σ are `C^{1,1}`
curves with the property that the unit parallel of each boundary curve, on either side, is again a boundary curve wherever it avoids Σ and the curve's
own focal points. Such a boundary curve is piecewise circular with integer radii: each circular piece of radius n is the outermost of n concentric
parallel pieces whose innermost is a unit arc about the piece's centre of curvature. Can the radii of the pieces of one boundary curve tend to
infinity at a point?*

**Features, sorted** (receipts in brackets):
- no monochromatic unit pair — *determines*, consumed only through FS111-M-PINCH: at a point off Σ the interface is one `C^{1,1}` curve (FS111-M-C11),
  and a tangent-type arc's unit parallels are interfaces off Σ (FS111-M2-INTRAD step (1));
- saturation and honesty — *determine*, split: consumed only through the two consequences just named;
- REG-J′ — *determines*, split: consumed as "Σ is locally finite" (so the junctions near the accumulation point are off Σ, and a chain toward a
  centre is interrupted at finitely many normals) and through FS111-M2-INTRAD (ii) (radius-r arcs are finitely many near any point);
- "radii tend to infinity" — *determines*, split: consumed only through "the pieces' windows `L_i/n_i` tend to 0" (the pieces lie in one interface
  arc of finite length); receipt: the variation control of § 2.4, whose fault bounds the radii and removes it;
- the number of colours `k` — *accompanies* (no step reads it; the argument of stage 2 runs at every `k`);
- cusps (a colour of density 0 at a point of its support) — *accompanies* the stage-2 lemmas: my first form of FS121-D2-EXT needed cusp-freeness (a
  horn at a junction image `P_ℓ`, `1 ≤ ℓ`), and the argument that runs puts the contradiction at level 0, the junction point itself, which is off Σ by
  REG-J′; so the lemmas hold with cusps allowed;
- the bi-infinite line of C121-LRA-LINE — *accompanies* this route (no step of stage 2 uses it);
- where the pieces' ends sit (the focal points `z_i`, points of Σ with at least three colours by C121-ENDS) — *accompanies* the count: they run off to
  distance `n_i`, so no count in a bounded set sees them (home 3 below);
- symmetry of the colouring (a cocompact group of isometries) — *determines* the class where the claim is decided (stage 2).

**Homes, each with its dictionary and its test:**
1. **Fronts, parallels and evolutes** (`[FukunagaTakahashi2014]` "Evolutes of fronts in the Euclidean plane", Zbl 1308.53005, listing only;
   Porteous's *Geometric differentiation*, listing only — query d01 below). Dictionary: rung at level k ↔ the front's parallel at distance k; the
   chain's end ↔ the focal point, a vertex of the evolute; a junction ↔ a jump of curvature, whose normal line carries a vertex of the evolute
   polygon; beyond a focal point the parallel front has a cusp and a swallowtail. *Tests:* the old proofs apply (FS111-M2-INTRAD step (2) *is* the
   parallel formula `ρ ↦ ρ − 1`); the exceptions vanish (a split unit arc and an (R2) arc are both the last rung before a focal point); **it predicts a
   neighbour**: parallel fronts share normals, so every rung of a piece has the piece's own angular window — *window transport* — and a piece of
   window `W` makes, at every radius it passes through, an arc of window `W`. **Adopted as the working home.** Its changed step: a front's parallel is a
   set; here a rung is an interface only off Σ and cannot follow the front around its swallowtail (FS121-D2-EXT, stage 2).
2. **Row 134's N4, curvature monotonicity along the shadow map** (the plan's first handle). *Test:* **killed.** N4 forbids a bi-infinite chain of
   *curved* points along a normal line because `1/λ ↦ 1/λ + 1` cannot stay outside `(−1, 1)` for every integer step; along an LRA line every point is
   flat (curvature 0 at each `x₀ + kν`, the limit of radii `n_i ∓ k → ∞`), and 0 is the recursion's fixed point, so N4 holds identically there; piece by
   piece, N4 is FS111-M2-INTRAD's descent, which every LRA piece satisfies (each chain ends at radius 1). Nothing in the recursion sees LRA.
3. **A density count on the pencils' ends in a bounded set** (the plan's second handle). *Test:* **killed as stated.** Each LRA piece's chain ends at
   its focal point `z_i`, at distance `n_i` from the accumulation point; by FS111-M2-INTRAD (iii) a bounded set meets finitely many arcs of each bounded
   radius, and every bounded set meets finitely many of the `z_i`. A count of ends per bounded set is finite in every LRA configuration. **Re-aimed:**
   count up to congruence instead of per bounded set — home 4.
4. **Finite local complexity** (tiling theory: finitely many patches of each size up to translation; query d02, 5 hits, none bearing on arcs or
   colourings of the plane). Dictionary: radius-r interface arcs ↔ tiles of one kind; an arc's window ↔ a tile's shape parameter; LRA ↔ infinitely many
   shapes. *Test:* with window transport, the old argument applies at once — finitely many shapes of radius-r arcs up to congruence bound their
   windows below, and LRA needs windows tending to 0 at every radius (FS121-D2-THIN). **It predicts a neighbour:** every doubly periodic honest
   saturated REG-J′ colouring satisfies ¬LRA, so C121-PER's periodic clause does not need its hypothesis "satisfying ¬LRA". **Adopted for the symmetric
   class.** Its changed step: FLC is an axiom of a tiling; here the finiteness of radius-r arcs meeting a compact fundamental domain is FS111-M2-INTRAD
   (ii)'s local finiteness.
5. **C121-CURVED's class** (a relation between the list's claims, not a home). Every LRA piece of radius at least 2 is a tangent-type interface arc of
   finite radius (FS111-M-C11 (iii)). So a colouring with LRA inhabits C121-CURVED's class (with cusps allowed), and ¬LRA follows from the universal form
   "no honest saturated REG-J′ colouring has a tangent-type interface arc of finite radius", which D1 left GAP (C121-CURVED). A refuter of C121-NOLRA is at
   least as hard to build as C121-CURVED's inhabitant.

**The recognition sentence:** *LRA is infinite local complexity of a front: the pieces accumulating at a point are fronts whose windows `L_i/n_i`
tend to 0, every rung of a piece keeps its window, and the colouring cannot carry a rung round its focal point along the same circle — so LRA puts, at
every radius `r ≥ 2`, radius-r interface arcs of arbitrarily small angle into the colouring, and ¬LRA holds wherever the arcs of one radius come in
finitely many shapes.* **It differs from the plan** (§ 4.2, D2 row): both named handles are killed as stated (homes 2, 3); the count survives only
re-aimed modulo congruence, and the open step is not the bi-infinite line (not used) but arcs of vanishing window. Reported to Keryx.

**Prior art for this stage's objects** (`tools/fs121_d2_zb.py`: zbMATH Open API; positive control `an:0933.52003` → 1 and a nonsense title → 0, else
exit 2; `--plant` swaps the control's id and exits 2, run and seen, `data/fs121/d2/zb-plant.out`). Queries `data/fs121/d2/zb-queries.tsv`, output
`data/fs121/d2/zb-run.out`, run 2026-09-29: d01 evolute/focal set/caustic × parallel curve/unit distance/colo* (14 hits: fronts and their evolutes in
differential geometry — Fukunaga–Takahashi 2014, Teramoto 2025, Porteous — none about colourings); d02 finite local complexity × curvature/circular
arc/colouring/unit distance (5, none bearing); d03 chromatic number of the plane/unit distance graph/measurable chromatic × curvature/evolute/parallel
curve/arc* (4: `[SokolovVoronov2025]`, held; Haugland 2026; Malen 2015; a textbook — none bearing); d04 piecewise circular/circular arcs/biarc ×
accumulat*/infinitely many × curvature/radii (1, a record with no licensed text). **Not found in print:** window transport, FS121-D2-EXT and the
symmetric-class result. The object class (saturated measurable colourings) has no print (the plan's gate, § 2.2).

*Would have searched here:* none this stage beyond the log above.

### 1.3 Home 5 as an entry (the containment)

*Argument.* Let pieces `γ_i` of radii `n_i → ∞` accumulate at a point. All but finitely many have `n_i ≥ 2`. A point of an interface arc off Σ of the
(split) type makes the whole local interface one unit arc (FS111-M-C11 (iii)), so a piece of radius at least 2 is of the (tangent) type at each of its
points. So each such `γ_i` is a tangent-type interface arc of finite radius, which is C121-CURVED's object (with "no colour of density 0" dropped). ∎

derivation: FS121-D2-INCURVED
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces whose radii tend to infinity accumulate at a point, then
    the colouring has tangent-type interface arcs of finite radius at least 2, infinitely many of them
  uses only: FS111-M-C11 (iii) (a split point makes the whole local interface one unit arc); that all but finitely many of the pieces have radius at
    least 2; no colour count
  not claimed: the converse (a curved tangent interface without LRA); that such a colouring is cusp-free (C121-CURVED's class also asks no colour of
    density 0 at any point)
  argument: § 1.3 Home 5 as an entry (the containment)
  verdict: derived
  grade: hand
  minds: 1
  model: none held at any k — no held colouring has LRA or a curved tangent interface (C121-CURVED, GAP; G21); the statement is a containment of
    two uninhabited classes
  prior art: new — “(evolute | focal set | caustic) & (parallel curve | unit distance | colo*)” (14), “(chromatic number of the plane | unit
    distance graph | measurable chromatic) & (curvature | evolute | parallel curve | arc*)” (4), none bearing
  handoff: none — a relation between two claims of the list, not a statement a proof consumes

## Stage 1 — SAVED

## Stage 2 — SAVED: the rung extension lemma, window transport, and ¬LRA for symmetric colourings

*Setting for every entry of this stage: `f` an honest saturated colouring in D-NF satisfying REG-J′; any `k`; cusps allowed (no entry here uses
FS111-W-NOREP). Notation: the header's words.*

### 2.1 A rung cannot follow its own circle past a junction (FS121-D2-EXT)

*Setting.* Let `a` be a junction, off Σ, of an interface arc `J`, where `J` passes from a circular piece `γ` (radius `n ≥ 3`, centre `z`) to a piece
`γ′` that does not lie on `γ`'s circle. Let `L` be the normal line of `J` at `a`; it passes through `z`. Put `ν = (z − a)/n` and `P_k = a + kν`.

*A remark used below.* Under REG-J′ a bounded set meets finitely many interface arcs (FS111-M-REDUCE-I's proof), each closed with its ends in Σ, so
the closure of the interface set is the union of the interface arcs, and a point of it off Σ lies on an interface arc.

*Argument.* Fix `k` with `1 ≤ k ≤ n − 2`, and suppose an arc `C` of the circle `∂B(z, n − k)`, on `γ′`'s side of `L` with an end at `P_k`, lies in the
closure of the interface set. Σ is locally finite, so shrinking `C` about `P_k` leaves a sub-arc `C₀` whose points other than `P_k` are interface points
off Σ; at each of them (H1) and (H2) hold, the interface is locally one `C^{1,1}` curve (FS111-M-C11), and it contains `C₀` near that point, so it is the
circle there. `C₀` has radius `n − k ≥ 2`, so it is of the (tangent) type at every point (FS111-M-C11 (iii): a (split) point makes the whole local
interface one unit arc). By FS111-M2-INTRAD step (1), on the side away from `z`, the unit parallel of `C₀` — the arc of `∂B(z, n − k + 1)` over the
same directions from `z`, with an end at `P_{k−1}` — is an interface at its points off Σ; it has radius at least 3, so (tangent) type again. Shrinking
about `P_{k−1}` to avoid Σ and repeating `k` times gives an arc `C_k` of `∂B(z, n)` over directions from `z` starting at the direction of `a`: an arc
with an end at `a`, on `γ′`'s side of `L`, whose points near `a` other than `a` are interface points. But `a ∉ Σ`: FS111-M-PINCH's hypotheses hold at
`a`, and FS111-M-C11 gives a neighbourhood `N′` of `a` in which the interface set is the single curve `J`, which on `γ′`'s side of `L` is `γ′`. The
circle `∂B(z, n)` and `γ′` (a circle or a line) are distinct curves through `a` with a common tangent there, so near `a` they meet only at `a` (control
FS121-D2-EXT-CORE). So the points of `C_k` near `a` are interface points of `N′` off `J`: a contradiction. ∎

*What it says.* In the language of fronts (home 1), beyond a focal point the parallel front turns back in a cusp; the colouring cannot carry a rung
along its own circle past the junction normal, because the unit parallels of that continuation would put a second interface curve through the
junction itself, where the colouring has only one. The contradiction sits at level 0, at a point off Σ, so no cusp-freeness is needed (§ 1.2's sort).
The same argument, with FS111-M2-INTRAD step (1) toward `z`, forbids the outward rungs of `γ` (radii `n + t`, `t ≥ 1`) from following their circles past
`L` too: their parallels toward `z` reach `∂B(z, n)` near `a` after `t` steps, every intermediate radius being at least `n ≥ 3`.

derivation: FS121-D2-EXT
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, let a be a point of an interface arc, not in Σ, at which the arc passes from a
    circular piece γ of radius n ≥ 3 and centre z to a piece not on γ's circle, and let L be the normal line at a; then for every integer k with
    1 ≤ k ≤ n − 2, and for every integer k ≤ −1, no arc of the circle ∂B(z, n − k) that lies on the far side of L from γ and has an end on L lies in
    the closure of the interface set
  uses only: FS111-M2-INTRAD step (1) on either side (the unit parallel of a tangent-type arc is an interface off Σ), iterated |k| times, every radius
    met being at least 2; FS111-M-C11 and its clause (iii) (one C^{1,1} interface curve near a point off Σ; radius at least 2 means the tangent type);
    REG-J′ (Σ locally finite); that two distinct circles, or a circle and a line, tangent at a point meet only there near it; no colour count; no
    cusp-freeness
  not claimed: anything about a continuation past L along another curve (a different circle or a segment); anything when a is a point of Σ; the unit
    rung, n − k = 1, whose (split) type has no required outward parallel
  argument: § 2.1 A rung cannot follow its own circle past a junction (FS121-D2-EXT)
  verdict: derived
  grade: hand
  minds: 1
  model: none held at any k — no held colouring has a junction inside an interface arc (R7's interfaces are single unit arcs, SQ9's and HEX9's
    single segments); the statement is about the class LRA would inhabit (G21)
  prior art: new — “(evolute | focal set | caustic) & (parallel curve | unit distance | colo*)” (14), “(piecewise circular | circular arcs | biarc*)
    & (accumulat* | infinitely many) & (curvature | radii)” (1), none bearing
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and FS111-M2-INTRAD: the statement with its not-claimed line; its geometric core is
    elementary

control: FS121-D2-EXT-CORE
  of: FS121-D2-EXT — its last step, exact: a circle of radius n tangent at a to a different circle (radius m, either side) or to a line meets it only
    at a, for n in 2..12 and m in 1..12; the plant adds the excluded case, a neighbour on γ's own circle
  run: python3 ../tools/fs121_d2_geom.py ext
  expect: 0
  fault: python3 ../tools/fs121_d2_geom.py ext --plant

### 2.2 Window transport, and LRA makes thin arcs at every radius (FS121-D2-THIN)

*Argument.* Let pieces `γ_i` (radius `n_i`, centre `z_i`, window `W_i`, length `L_i = n_i W_i`) accumulate at a point `x₀`. By FS111-M2-INTRAD (iii)
arcs of each bounded radius are finitely many near `x₀`, so `n_i → ∞`; pass to a subsequence of distinct radii. A bounded set meets finitely many
interface arcs (REG-J′, FS111-M-REDUCE-I's proof), so infinitely many `γ_i` lie on one interface arc `J` of finite length `Λ`, and `W_i ≤ Λ/n_i → 0`.
Σ is locally finite, so all but finitely many `γ_i` have both ends at junctions off Σ, and none of those is on a neighbour's circle (the pieces are
maximal). Fix `r ≥ 2` and take `i` with `n_i ≥ r + 1`. *Window transport:* by FS111-M2-INTRAD step (2), the rung of `γ_i` at level `k = n_i − r` is an arc
`R_i` of `∂B(z_i, r)` over exactly `γ_i`'s directions from `z_i` (parallel curves share normals: control FS121-D2-TRANSPORT), and it is an interface
at its points off Σ except along the finitely many normals of `γ_i` that meet Σ in the bounded pencil (each point of Σ other than `z_i` lies on at most
one normal of `γ_i`), where the chain resumes on either side; so `R_i` lies in the closure of the interface set, and it lies in one radius-r arc `A_i`.
Both ends of `R_i` lie on the normal lines `L` of `γ_i`'s two junctions, at the points `P_k`; `A_i` beyond an end of `R_i` would be an arc of
`∂B(z_i, r)` on the far side of that `L` from `γ_i`, with an end on `L`, in the closure of the interface set — excluded by FS121-D2-EXT, since
`1 ≤ k = n_i − r ≤ n_i − 2`. So `A_i = R_i`: a radius-r arc of window exactly `W_i`. The centres `z_i` are distinct (distinct radii, pieces within
distance 1 of each other), so the `A_i` are distinct arcs, with windows tending to 0. ∎ With FS121-D2-EXT's outward clause the same holds at every radius
`r > n_i` (the outward rungs, of window `W_i` too): each LRA piece carries a *thin pencil*, maximal arcs of window `W_i` at every radius `r ≥ 2`,
bounded by the normal lines of its two junctions, along which every rung ends on its own circle.

derivation: FS121-D2-THIN
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces whose radii tend to infinity accumulate at a point, then
    for every integer r ≥ 2 the colouring has infinitely many radius-r arcs — maximal arcs of circles of radius r contained in the closure of the
    interface set — whose angular windows tend to 0
  uses only: FS111-M2-INTRAD step (2) (the chain toward a centre, interrupted only along normals through Σ) and (iii) (finitely many arcs of each
    bounded radius near a point); REG-J′ (finitely many interface arcs in a bounded set; Σ locally finite); that parallel curves share normals;
    FS121-D2-EXT at each piece's two junctions; no colour count; no cusp-freeness
  not claimed: that the thin arcs lie in a bounded set (the radius-r arc of γ_i lies at distance about n_i − r from the accumulation point); the
    converse (thin arcs without LRA); anything at r = 1
  argument: § 2.2 Window transport, and LRA makes thin arcs at every radius (FS121-D2-THIN)
  verdict: derived
  grade: derived from: FS121-D2-EXT
  minds: 1
  model: none held at any k — no held colouring has LRA (the statement is a necessary condition on the class C121-NOLRA forbids; G21)
  prior art: new — “(finite local complexity | local complexity) & (curvature | circular arc | colouring | coloring | unit distance)” (5), “(evolute
    | focal set | caustic) & (parallel curve | unit distance | colo*)” (14), none bearing
  handoff: none — a necessary condition on an uninhabited class; it crosses to de Bruijn with FS121-D2-SYM

control: FS121-D2-TRANSPORT
  of: FS121-D2-THIN — window transport, exact: the rung at level k of a piece of radius n (n in 2..9, 1 ≤ k ≤ n − 1) subtends at the centre the
    angle the piece subtends, on 45 pairs of Pythagorean directions; the plant moves the rung toward a shifted centre
  run: python3 ../tools/fs121_d2_geom.py transport
  expect: 0
  fault: python3 ../tools/fs121_d2_geom.py transport --plant

### 2.3 ¬LRA where arcs of one radius come in finitely many shapes (FS121-D2-SYM, FS121-D2-PERFIN)

*Argument (SYM).* If for some `r ≥ 2` every radius-r arc of `f` has window at least `w₀ > 0`, FS121-D2-THIN excludes LRA. Let a group `G` of isometries
of the plane, each mapping the partition to itself up to a permutation of the colours, have a compact set `K` with `G·K = ℝ²` (for a doubly periodic
colouring, a closed fundamental parallelogram). Interfaces, Σ and radius-r arcs are defined by the metric and by densities, so `G` permutes the radius-r
arcs and preserves their windows. A radius-r arc minus finitely many points consists of points of the interface of radius of curvature `r`; by
FS111-M2-INTRAD (ii) those form, near any point, finitely many circular arcs, and distinct maximal arcs contain distinct ones; covering `K` by finitely
many such neighbourhoods, finitely many radius-r arcs meet `K`. Every radius-r arc is a `G`-image of one of them, so the windows take finitely many
values, all positive: they are bounded below, and ¬LRA holds. ∎

*Argument (PERFIN).* In a doubly periodic `f`, a closed fundamental parallelogram meets finitely many interface arcs (REG-J′). An interface arc with
infinitely many pieces has, being compact, pieces accumulating at some point, and by FS111-M2-INTRAD (iii) their radii tend to infinity: LRA, which
FS121-D2-SYM excludes. So each of the finitely many arcs has finitely many pieces, and the interfaces carry finitely many radii of curvature. ∎ This is
C121-PER's hypothesis: its clause "in particular a doubly periodic one satisfying ¬LRA" holds without "satisfying ¬LRA".

derivation: FS121-D2-SYM
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, if for some integer r ≥ 2 the angular windows of
    its radius-r arcs are bounded below by a positive constant — in particular if it is invariant under a group of isometries of the plane, each
    mapping the partition to itself up to a permutation of the colours, with a compact set whose images cover the plane, such as a doubly periodic
    colouring — then ¬LRA holds
  uses only: FS121-D2-THIN; FS111-M2-INTRAD (ii) (radius-r arcs finitely many near any point) over a compact set; that interfaces, Σ and windows are
    invariant under isometries and colour permutations; no colour count; no cusp-freeness
  not claimed: ¬LRA without such a bound (C121-NOLRA's open step, § 3); that a tight colouring can be taken symmetric; anything from a bound at r = 1
  argument: § 2.3 ¬LRA where arcs of one radius come in finitely many shapes (FS121-D2-SYM, FS121-D2-PERFIN)
  verdict: derived
  grade: derived from: FS121-D2-THIN
  minds: 1
  model: k = 7: R7, doubly periodic, whose interfaces are unit arcs, so for every r ≥ 2 there is no radius-r arc and the bound holds vacuously; ¬LRA
    holds; k = 9: SQ9 and HEX9 alike (segments only)
  prior art: new — “(finite local complexity | local complexity) & (curvature | circular arc | colouring | coloring | unit distance)” (5), “(chromatic
    number of the plane | unit distance graph | measurable chromatic) & (curvature | evolute | parallel curve | arc*)” (4), none bearing
  handoff: de Bruijn — queued behind FS111-M2-INTRAD and the measurable chain (FS-113): the periodic case of ¬LRA, which the honest route's periodic
    reading (FS121-O1-PER) consumes

derivation: FS121-D2-PERFIN
  statement: in a doubly periodic honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, the interfaces carry only finitely
    many radii of curvature
  uses only: FS121-D2-SYM; REG-J′ (finitely many interface arcs meet a compact set); FS111-M2-INTRAD (iii); compactness of an interface arc
  not claimed: anything for colourings that are not periodic; that a tight colouring can be taken periodic
  argument: § 2.3 ¬LRA where arcs of one radius come in finitely many shapes (FS121-D2-SYM, FS121-D2-PERFIN)
  verdict: derived
  grade: derived from: FS121-D2-SYM
  minds: 1
  model: k = 7: R7 (one radius, 1); k = 9: SQ9 and HEX9 (radius infinite only)
  prior art: partly: C121-PER (data/fs121/claims.md § 2) states the conclusion "in particular" for "a doubly periodic one satisfying ¬LRA"; the
    periodic case without ¬LRA not found — “(finite local complexity | local complexity) & (curvature | circular arc | colouring | coloring | unit
    distance)” (5)
  handoff: none — it removes a hypothesis from C121-PER's periodic clause; it crosses with FS121-D2-SYM

*Would have searched here:* a finder over thin pencils (a family of curved pencils with windows tending to 0, with their band subdivisions) — did not;
the stage derived what LRA forces (FS121-D2-THIN) and the class where it is excluded (FS121-D2-SYM).

## Stage 2 — SAVED

## Stage 3 — SAVED: C121-NOLRA — the verdict, and the three attempts on its open step

### 3.1 Where the claim stands

- **Decided on the symmetric class:** at every `k`, an honest saturated REG-J′ colouring invariant under a cocompact group of isometries (each
  preserving or permuting the colours) — every doubly periodic one — has no LRA (FS121-D2-SYM), and carries finitely many radii (FS121-D2-PERFIN).
- **Reduced elsewhere:** LRA forces thin pencils — for every `r ≥ 2`, infinitely many maximal radius-r interface arcs whose windows tend to 0, each the
  rung of an LRA piece bounded by the normal lines of its two junctions (FS121-D2-THIN, FS121-D2-EXT) — and a colouring with LRA inhabits C121-CURVED's
  class with cusps allowed (FS121-D2-INCURVED). So ¬LRA follows from a positive lower bound, for one `r ≥ 2`, on the windows of radius-r arcs, and also from
  the universal negation of C121-CURVED's class.
- **Not used:** C121-LRA-LINE (the bi-infinite line), FS121-O1-OUT beyond FS111-M2-INTRAD step (1), C121-ENDS, FS111-W-NOREP. The results hold with
  cusps.

### 3.2 The three attempts on the open step

*The step:* a lower bound on the windows of the radius-r arcs of an aperiodic colouring — for this claim, "no sequence of thin pencils".

1. **Tile diameters** (FS111-M-HULL2: a path-connected piece of a class has diameter at most 1). They bound tiles from above only. A thin pencil's arc
   of radius `R` has length `R·W_i`; it is cut by points of Σ into interface arcs of diameter at most 1, which REG-J′ allows. No lower bound on `W_i`.
2. **The junction normals** (home 1's column). At a junction between pieces of radii `m < n` on the same side, the larger piece's rungs at levels
   `m ≤ k < n` reach the normal line at `P_k` with no partner beyond (the smaller piece has focused at `z_m = P_m`). By FS121-D2-EXT none follows its own
   circle; by the same argument none continues straight or curving away from `J` with radius at least 2 (its unit parallels toward `J` would reach the
   junction point off Σ as a second curve). Read as a sketch, not entered: each such rung ends at a point of Σ on the normal or curves back toward `J` with the centre of its
   chain on the normal. Either way the forced points of Σ lie at distance at least `m` from `J`, finitely many in each bounded set: consistent with
   REG-J′, no contradiction.
3. **A limit.** Translate the centres of the thin pencils to the origin and pass to a weak-* limit colouring (G82: a limit of colourings is a colouring).
   The thin pencils collapse to a ray. But saturation, honesty and REG-J′ are not known to pass to such limits, so the collapsed pencil contradicts
   nothing held.

The plan's two handles were killed at stage 1 (§ 1.2, homes 2 and 3): N4 holds identically along an LRA line (curvature 0 is the shadow map's fixed
point), and a count of chain ends per bounded set is finite in every LRA configuration. The count, re-aimed modulo congruence, is what decided the
symmetric class.

derivation: C121-NOLRA
  statement: in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, ¬LRA holds.
  argument: § 3.2 The three attempts on the open step
  verdict: gap: excluding thin pencils in colourings without a cocompact symmetry — LRA at a point gives, for every r ≥ 2, infinitely many maximal
    radius-r interface arcs with windows tending to 0 (FS121-D2-THIN), and a positive lower bound on those windows for one r ≥ 2 excludes LRA
    (FS121-D2-SYM, which decides every doubly periodic colouring at every k); no argument here bounds the windows of an aperiodic colouring's radius-r
    arcs from below; colours: every k; inhabitants: k = 7, R7; k = 9, SQ9 and HEX9 (none has LRA, each doubly periodic); no colouring with LRA held

### 3.3 The prediction, scored; the invention signal; what leaves the lane

- **P2** (`plans/FS121-map-step.md` § 4.4): "¬LRA derived under REG-J′ within D2 (C121-NOLRA TRUE) — 0.3". **Not met**: GAP (Brier `0.09`). What it
  decides: "If not, the LRA line goes to FS-115 as its question restated (bi-infinite, not a ray)". **What goes to FS-115 is sharper than the line:** thin
  pencils in aperiodic colourings (FS121-D2-THIN), with the periodic case closed (FS121-D2-SYM). The line (C121-LRA-LINE) is not needed for either.
- **The invention signal (G87):** read for in every source of this job. None found: G85's "What escapes is radii → ∞" and FS111-M2-INTRAD's "consistent
  with REG-J′'s local finiteness" are consistent with FS121-D2-SYM (local finiteness per bounded set allows LRA; local finiteness modulo a cocompact
  symmetry does not). Nothing held says both LRA and its negation.
- **For C121-PER (the claim list, O1's entry FS121-O1-PER):** its clause "in particular a doubly periodic one satisfying ¬LRA" holds without "satisfying
  ¬LRA" (FS121-D2-PERFIN). A strengthening, not a defect.
- **For D1's line (C121-CURVED):** a colouring with LRA inhabits C121-CURVED's class with cusps allowed (FS121-D2-INCURVED), so an obstruction to curved
  tangent interfaces at every `k` decides C121-NOLRA too; and FS121-D2-EXT holds without cusp-freeness, so it may serve C121-CURVED's transverse question.
- **Handoff to de Bruijn:** FS121-D2-EXT and FS121-D2-SYM, queued behind FS111-M-PINCH, FS111-M-C11, FS111-M2-INTRAD and the measurable chain (FS-113).
- **Bibliography row proposed:** `[FukunagaTakahashi2014]` T. Fukunaga, M. Takahashi, *Evolutes of fronts in the Euclidean plane*, J. Singul. 10
  (2014) (Zbl 1308.53005). Listing only (zbMATH query d01). Role: the vocabulary of home 1 (parallels, evolutes and cusps of fronts). Read: not read.

*Would have searched here:* a finder for an aperiodic saturated colouring with thin pencils — did not; the step is named for a derivation.

## Stage 3 — SAVED
