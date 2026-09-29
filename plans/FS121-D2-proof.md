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

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have searched for a saturated colouring with a curved interface whose pieces accumulate (a finder over piecewise-circular
  fronts with prescribed ladders). Did not; the recognition below asks what every LRA configuration must carry first.

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
