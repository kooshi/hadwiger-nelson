# FS121-D4 — the singular set: C121-REGJ (Ephodos, derivation job, round 3)

*Ephodos (Opus 5.5), job FS121-D4, brief `data/fs121/briefs/FS121-D4-regj.md` with `plans/STANDING-RULES.md` as part of it. Claim:
`data/fs121/claims.md` § 4, C121-REGJ (frozen 2026-09-29 05:41 UTC). Plan: `plans/FS121-map-step.md`. I write only this record,
`data/fs121/d4/`, `tools/fs121_d4_*.py` and `data/fs121/reports/FS121-D4.md`. Entries use my identity's grammar: `hand` is [hand],
`derived from` is [derived], `computed over` is [tools]; verdict `derived` is TRUE, `gap:` is GAP, `refuted:` is FALSE. Started
2026-09-29 07:18 UTC; stopped at 07:42 UTC by an account halt before any commit; resumed 2026-10-03 14:36 UTC (the coordinator's
message). Nothing was lost but the record itself, which is written fresh from the stopped session's notes.*

**Words used below** (this record's, not the list's). A **piece** of colour `c` is a path-connected set of points of density 1 of `S_c`
(FS111-M-HULL2's word). A **region** of colour `c` is a connected component of the interior of `S̃_c` (an open set). `∂_e S_c = A*_c ∖ S̃_c`
(`data/fs111/claims.md` § 0) is the essential boundary of `c`; **saturated** means every point of `∂_e S_c` is a `c`-contact point (some point of
`supp S_c` at distance exactly 1), for every `c` (FS-111's definition, quoted in the claim list § 0). `T₁(w)` is the unit circle about `w`.

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, minds, address)*

- FS121-D4-QT — the brief's quotation and the record's seven definitions are verbatim (10 of 10) — [tools], one mind — § 1.1.
- FS121-D4-FACE — a same-colour box of lateral half-width ρ straight ahead of a flat side, across a gap g < ρ²/2, leaves the side's point no
  contact: in a saturated colouring the colour has density 1 there — [hand], one mind — § 2.1.
- FS121-D4-GRID — C121-REGJ holds on every grid colouring with countable breakpoint sets, at every k — [derived] from FACE, one mind — § 2.2.
- FS121-D4-HOLE — a region with a hole has its hole's whole boundary in Σ — [derived] from FS111-M-PINCH, one mind — § 2.3.
- FS121-D4-LINE — the line analogue of C121-REGJ is false with two colours — [hand], with an exact check, one mind — § 2.4.
- FS121-D4-TINY16 — saturated sixteen-colourings with regions of every small diameter — [tools] exact at ε = 1/10, [hand] for every ε, one
  mind — § 2.5.
- FS121-D4-FALL — C121-REGJ restricts to measurable fall colourings, so a fall colouring with a non-locally-finite Σ (e.g. a Cantor pinch) refutes
  it — [derived] from FS121-D3-FALLSAT, one mind — § 3.2.
- C121-REGJ — GAP at LAT (lateral extent at an accumulation) — § 3.3.

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have searched for a saturated colouring with an accumulating singular set (a finder over periodic rectangle colourings with a
  refined cell near a point). Did not; the recognition derives what any such colouring must carry first, and every object below is given by formula.
- *Note:* the ban ran to 2026-10-01, and this job resumed on 2026-10-03. The brief and its standing rules are "unchanged" (the coordinator's
  message), and no step of this job needs a search, so I keep the log and run none.

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript, no `chats-bak/`, no auto-memory beyond the index the harness showed at launch.
I read `data/fs116/claims.md` (headings and § 10's two statements, to check the brief's pointer), a frozen claim list, not a record of a
blind job. I write nothing where FS121-V3, FS121-V4 or FS116-V3 read: only the four paths above.

## Slips

- **Stage 1:** I built `tools/fs121_d4_quotes.py` before reading `RUNNING.md` § Make the gate fail (standing rule 7 asks for the reading first),
  the opening job's slip repeated. I read it straight after and checked the tool against it: a missing quote exits 1, an unreadable source or an
  empty input exits 2, and the plant (the first quote altered by one character) is reported missing.

## Stage 1 — SAVED: the readback, and the recognition

### 1.1 Readback of the brief

The brief's one verbatim quotation is C121-REGJ, a block quote "— source: data/fs121/claims.md § 4". I checked it, its last sentence and
heading, and every definition this record quotes, with `tools/fs121_d4_quotes.py` (whitespace normalised, nothing else): input
`data/fs121/d4/quotes-brief.tsv`, output `data/fs121/d4/quotes-brief.out`, **10 of 10 found, exit 0**, re-run on resuming (no input changed:
`git log` shows no commit to the claim list or `plans/FS111-derivation.md` since the stop). The plant fires:
`python3 tools/fs121_d4_quotes.py data/fs121/d4/quotes-brief.tsv --plant` reports one missing and exits 0.

- **No mismatch.** Two reading notes, not mismatches. (1) The brief's sentence on the plan's handle ("what every end carries bounds the ends in
  a bounded set; M-EXTREME's two points of Σ per region") is a paraphrase, outside quotation marks; the plan's § 4.2 D4 row reads, verbatim,
  "REG-J′'s universal form: what every end carries bounds the ends in a bounded set. Uses C121-ENDS (every end is a point of Σ of ≥ 3 colours),
  SATPIN's partners on `ω(z)`, M-EXTREME's two points of Σ per region", and the plan's own stage-5 correction strikes its C121-ENDS clause as
  circular — the brief already omits it. (2) The brief says FS-116's RING-GERM and RING-TWIST-C "hold at two minds (`data/fs116/claims.md` § 10)";
  § 10 holds both statements, and a claim list carries no grades, so the "two minds" is the brief's report and not checkable there. I use neither.
derivation: FS121-D4-QT
  statement: the brief's quotation of C121-REGJ, its last sentence and section heading, and the seven definitions this record quotes, occur
    verbatim in their sources (10 of 10, whitespace normalised)
  uses only: string comparison after collapsing runs of whitespace
  not claimed: that a paraphrase outside quotation marks is faithful (the plan's handle, read separately above)
  argument: § 1.1 Readback of the brief
  verdict: derived
  grade: computed over: the 10 rows of data/fs121/d4/quotes-brief.tsv
  minds: 1
  model: row 1, C121-REGJ in data/fs121/claims.md § 4
  prior art: known — a bookkeeping check, not mathematics
  handoff: none — a readback

control: FS121-D4-QT-RUN
  of: FS121-D4-QT — all ten quotations found; with the first quote altered by one character the checker reports it missing
  run: python3 ../tools/fs121_d4_quotes.py ../data/fs121/d4/quotes-brief.tsv | tail -1
  expect: quotes: 10  found: 10  missing: 0
  fault: python3 ../tools/fs121_d4_quotes.py ../data/fs121/d4/quotes-brief.tsv --plant | tail -2 | head -1

- **My claim, restated beside the quotation.** C121-REGJ, verbatim: "in every honest saturated colouring in D-NF, with any number of colours, the
  singular set Σ is locally finite and each point of Σ meets finitely many interface arcs." It may not rest on C121-ENDS, C121-OUT, C121-PER or
  C121-LRA-LINE. I owe one entry with its verdict, its colour count and its inhabitants, an entry for every lemma, and the report.

### 1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall.** No derivation has been attempted: the claim is posed universal at every `k`, with three inhabitants (R7, SQ9, HEX9) and no
refuting object held. Its shape is the plan's own: a wall that describes a counterexample (the stub's existence form), with the structural form
asking what every end carries. The plan's handle — M-EXTREME's two singular points per region — counts Σ per region, so it bounds Σ only if
regions are counted; nothing held counts them.

**For a stranger** (a geometer who works on sets avoiding one distance, and on parallel curves): *Partition the plane, up to a null set, into
finitely many measurable classes so that no class contains a positive-measure set of pairs at distance exactly 1. Call the partition saturated if
every point where a class has positive upper density but not density 1 lies at distance exactly 1 from a point of that class's support. Off a
"singular set" — the boundary points where more than two classes meet, or a class is locally disconnected, or a class has density 0 but is
present — each boundary is a curve squeezed between two tangent unit discs, one of each class. Is the singular set locally finite?*

**Features, sorted** (the receipt in brackets):
- *No monochromatic unit pair* — **determines** [every step below consumes it, through FS111-C-HULL's first clause: a piece meets no unit
  circle about a point of its own colour's density set].
- *Saturation* — **determines**, split: consumed only as "a boundary point of a class has a point of that class's support at distance exactly 1"
  [the facing lemma of stage 2 consumes exactly this at one point].
- *Finiteness of `k`* — **determines**; *the value of `k`* — **accompanies** [the grid argument of stage 2 uses a pigeonhole on finitely many
  colours, and never their number; with infinitely many colours the product construction of stage 2 accumulates freely].
- *The dimension two — the curvature of the unit circle, read as lateral extent* — **determines**, and this is the recognition's finding [the
  analogue on the line, the unit graph `x ~ x ± 1`, whose "unit circle" is two points, is FALSE with two colours (stage 2, FS121-D4-LINE); in the
  plane the obstruction that bounds ends needs a same-colour piece with lateral extent `ρ` facing a flat side across a gap `g < ρ²/2`
  (FS121-D4-FACE)].
- *Honesty* — **accompanies** the facing lemma (it needs one colour at one point only) and **determines** where M-PINCH is used (the hole lemma).
- *The colour count per region (M-EXTREME's two points)* — **accompanies** [regions can be arbitrarily small in a saturated colouring, by formula
  at `k = 16` (stage 2, FS121-D4-TINY16), so a per-region count bounds nothing per unit area].
- *The complexity bound, measurability's details* — **accompany** (no step reads them).

**Homes, each with its test:**
1. **Free-boundary regularity of optimal partitions** (Caffarelli–Lin; spectral minimal partitions in the plane, whose singular set is locally
   finite). Dictionary: class ↔ cell; saturation ↔ optimality; Σ ↔ the singular set. *Killed* as a theorem home: its proofs run on monotonicity
   formulas for an energy, and the dictionary line "first variation" is blank here (the opening killed it on the same line).
2. **Totally separable packings** (the Fejes Tóths, 1973; Bezdek): a packing in which every two bodies are separated by a line meeting no body.
   Dictionary: below the unit scale, properness and saturation say that the unit circles through a piece's boundary points (nearly lines at small
   scale) cut no piece of the same colour — a separability condition. *Test:* it predicts a neighbour: **separable families accumulate freely**
   (tiny squares in a grid), so no argument that reads only a neighbourhood of radius below 1/2 can prove local finiteness — any proof is
   non-local, through the partners at distance 1. Kept as the reason the argument must be non-local; not a theorem home.
3. **Parallel curves and the ladder** (the opening's home): a flat side's partner is its unit translate along the normal. *Test:* the old proofs
   apply (the facing lemma is the ladder's first rung read against a second piece), and it **predicts** the lateral-extent obstruction: the unit
   circles about the partners curve back by `t²/2` at lateral offset `t`, so a same-colour piece in front at gap `g` is crossed once its lateral
   half-width exceeds `√(2g)`. **Adopted as the working home.**
4. **One-dimensional dynamics** (`x ↦ x + 1` on the line; skew products with colour shifts): the line analogue. *Test:* its proofs apply verbatim
   and give the opposite answer — FALSE — which sorts the dimension as a determiner. Kept as the calibration.

**The recognition sentence:** *a saturated colouring's ladder translates every flat side by one unit along its normal, and the unit circle's
curvature turns a same-colour piece of lateral half-width `ρ` lying in front of that side, at a gap below `ρ²/2`, into a positive measure of
monochromatic unit pairs; so what bounds the ends in a bounded set is the finite colour count read through lateral extent — a pigeonhole on
pieces with width — and what escapes it is accumulation of pieces that shrink in every direction.*

**It differs from the plan's handle.** The plan's § 4.2 aims at a per-region count (M-EXTREME). The recognition says the bound is a count of
colours against lateral extent, and that per-region counts bound nothing per unit area (TINY16). Reported to Keryx.

**What it predicts, to be derived at stage 2:** (a) the facing lemma, universal; (b) TRUE on colourings constant on the cells of a grid, by (a)
and a pigeonhole; (c) FALSE on the line; (d) regions as small as wished at a fixed `k`; (e) a region with a hole has its whole shore singular
(the same ladder read inward, where the curvature has no room) — so islands accumulating in one sea are excluded unless every shore is singular.

## Stage 1 — SAVED

## Stage 2 — SAVED: five lemmas, no REG-J′ — the facing lemma, the grid class, holes, the line, small regions

*Setting for every entry: `f` a measurable colouring of the plane with finitely many colours, a.e.-proper (proper at `Leb ⊗ σ`-almost every edge);
where a lemma needs more it says so. None uses C121-ENDS, C121-OUT, C121-PER, C121-LRA-LINE or REG-J′. The one fact used throughout is
FS111-C-HULL's first clause in the form of FS111-M-PINCH's Step 1: if `P` is a piece of colour `c` and `y ∈ supp S_c`, then `P ⊆ B̄(y, 1)` or
`P ∩ B(y, 1) = ∅`. And the Fubini fact: if an open set `U` with `|S_c ∩ U| > 0` is such that `T₁(w)` meets an open set `H`, a.e. inside `S_c`, in
an arc of length at least `ℓ > 0` for every `w ∈ U`, then `f` has a positive `Leb ⊗ σ`-measure of edges inside `S_c` (for each direction the edges
landing in `H ∖ S_c` form a translate of a null set), which a.e.-properness forbids.*

### 2.1 The facing lemma (FS121-D4-FACE)

*Argument.* Coordinates: `x` the origin, `e = (1, 0)`; a point is `(s, t)`. Let `H = {(−s, t) : 0 < s < ε, |t| < ε}` and
`A′ = {(s, t) : g < s < g + ε′, |t| < ρ}` lie a.e. in `S_c`, with `g > 0` and `2g < ρ²`.
*Step 1: the only possible `c`-contact of `x` is `e`.* Let `y = u` with `|u| = 1`, `u ≠ e`, and `y ∈ supp S_c`. If `u = −e`, `T₁(y)` holds the
points `(−(1 − cos φ), sin φ)`, in `H` for small `φ ≠ 0`; if `u ≠ ±e`, `T₁(y)` crosses the axis `s = 0` transversally at `x`, so an arc of it lies in
`H`. In both cases, by continuity, `T₁(w)` meets `H` in an arc of length bounded below for `w` in a ball about `y`, which has positive `c`-measure:
the Fubini fact gives a contradiction.
*Step 2: `e ∉ supp S_c`.* For `w = (1 − a, b)` with `0 < a < ε/2`, `|b| < ε/2`, the point of `T₁(w)` at angle `π` is `(−a, b) ∈ H`, and an open arc
about it stays in `H`. For `w = (1 + a′, b)` with `0 ≤ a′ < g`, `|b| < r`, the points `(1 + a′ − cos φ, b − sin φ)` of `T₁(w)` have first coordinate
in `(g, g + ε′)` exactly when `cos φ ∈ (1 + a′ − g − ε′, 1 + a′ − g)`, an open interval inside `(1 − g − ε′, 1)`, on which `|sin φ| < √(2(g + ε′))`; so
they lie in `A′` once `r + √(2(g + ε′)) < ρ`, which holds for small `r` after shrinking `ε′` (a sub-box of `A′` is still a.e. in `S_c`), because
`√(2g) < ρ`. So `T₁(w)` meets `H ∪ A′` in an arc of positive length for every `w` in `B(e, r′) ∖ {s = 1}`, `r′ = min(ε/2, r, g)`, and the Fubini fact
makes `S_c ∩ B(e, r′)` null: `e ∉ supp S_c`. With Step 1, `x` is no `c`-contact point. Finally `c` has upper density at least `1/2` at `x` (from `H`),
so in a saturated colouring `x ∉ ∂_e S_c` forces `x ∈ S̃_c`. ∎

*What it is, in the home's words.* The first rung of `x`'s ladder is the unit translate `x + e` (Step 1, the opening's tangent partner, here with no
(H1), (H2)); the unit circles about the points just beyond that rung curve back by `t²/2` at lateral offset `t` and so reach any same-colour box
lying across the gap `g` at lateral half-width `√(2g)`. Lateral extent is the whole content: on the line the same configuration is harmless
(§ 2.4).

derivation: FS121-D4-FACE
  statement: in an a.e.-proper measurable colouring, let x be a point, e a unit vector and e⊥ a unit vector orthogonal to it; if the open half-box
    {x − s e + t e⊥ : 0 < s < ε, |t| < ε} and the open box {x + s e + t e⊥ : g < s < g + ε′, |t| < ρ} both lie almost everywhere in one class S_c,
    with ε, ε′ > 0 and 0 < 2g < ρ², then no point of supp S_c is at distance exactly 1 from x; so in a saturated colouring the colour c has
    density 1 at x
  uses only: a.e.-properness, through Fubini on Leb ⊗ σ; the unit circle's curvature (its sagitta at lateral offset t is 1 − √(1 − t²) < t² for
    |t| < 1); saturation only in the last clause, at the one point x
  not claimed: the same with a curved near side (a tangent unit disc in place of the half-box admits the in-contact x − e); the same without the
    lateral margin (2g ≥ ρ² is not covered); anything at an x where c has density 1; honesty, D-NF, REG-J′ (none is used)
  argument: § 2.1 The facing lemma (FS121-D4-FACE)
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at the midpoint x of a vertical edge between columns: the half-box lies in the left square; the nearest same-colour square straight
    ahead begins at gap g = 1 with ρ = 1/4, so 2g ≥ ρ² and the lemma is silent, as it must be (SQ9 is saturated); with that square moved to gap
    g < 1/32 the hypotheses would hold and the edge point would lose its contact, so no saturated colouring has that configuration
  prior art: owed
  handoff: de Bruijn — a short measure-theoretic lemma (Fubini on Leb ⊗ σ, one trigonometric bound); it crosses with the measurable chain (FS-113)

### 2.2 The grid class (FS121-D4-GRID)

*The class* (this record's). A **grid colouring** with `k` colours: closed countable sets `B_x, B_y ⊂ ℝ`; on each open cell `I × J` (`I` a component
of `ℝ ∖ B_x`, `J` of `ℝ ∖ B_y`) the colour is a.e. constant; two cells sharing an edge of positive length have different colours. SQ9 is one
(`B_x = B_y = ½ℤ`); so is TINY16 (§ 2.5).

*Argument.* Let `f` be an honest saturated a.e.-proper grid colouring. Suppose `B_x` has an accumulation point `x*`. A countable closed set is
scattered, so its isolated points are dense in it, and infinitely many isolated points `p` of `B_x` lie within `δ` of `x*`, for every `δ > 0`. Each
has a gap `G⁻(p)` ending at it and a gap `G⁺(p)` starting at it. Fix a gap `J = (y₀ − λ, y₀ + λ)` of `B_y` and put `ρ = λ/2`, `δ = ρ²/8`. Among the
infinitely many cells `G⁻(p) × J`, `|p − x*| < δ`, infinitely many have one colour `c` (pigeonhole on `k` colours). Take two, at `p < p′`. Then
`G⁻(p′) = (q, p′)` with `q ≥ p`, and `q ≠ p`, since `G⁻(p′) = G⁺(p)` would make the cells at `p` adjacent and of one colour; so `g = q − p` lies in
`(0, 2δ)` and `2g < ρ²`. At `x = (p, y₀)`, `e = (1, 0)`: the half-box lies in `G⁻(p) × J`, the box `{g < s < g + ε′, |t| < ρ}` in `G⁻(p′) × J`, both
of colour `c`; and the cell `G⁺(p) × J` to the right of `x` has a colour other than `c`, so `c` has density `1/2` at `x`, not 1. FS121-D4-FACE gives
a contradiction. So `B_x`, and likewise `B_y`, is locally finite. Then off `B_x × B_y` every essential boundary point lies inside one edge, where
two cells — two colours, each one open rectangle — fill a small ball, so (H1) and (H2) hold, no colour has density 0 at a point of its support, and
the point is not in Σ. So `Σ ⊆ B_x × B_y`, locally finite, and each of its points meets at most four edges. ∎

derivation: FS121-D4-GRID
  statement: in every honest saturated a.e.-proper grid colouring with finitely many colours — closed countable sets B_x, B_y ⊂ ℝ, a.e. one
    colour on each open cell I × J of ℝ ∖ B_x by ℝ ∖ B_y, cells sharing an edge of positive length coloured differently — B_x and B_y are locally
    finite, so the singular set Σ is locally finite and each point of Σ meets at most four interface arcs
  uses only: FS121-D4-FACE; the pigeonhole on finitely many colours; isolated points are dense in a countable closed subset of ℝ; the adjacency rule
    (it supplies both the gap g > 0 and the density 1/2 at x)
  not claimed: B_x or B_y uncountable (a Cantor set of breakpoints: GAP there — at a gap's end c may have density 1 from the far side, where the facing
    lemma is silent); grid colourings in which adjacent cells may share a colour; any bound on the number of breakpoints per unit length
  argument: § 2.2 The grid class (FS121-D4-GRID)
  verdict: derived
  grade: derived from: FS121-D4-FACE
  minds: 1
  model: k = 9: SQ9 (B_x = B_y = ½ℤ, locally finite); k = 16: TINY16, cells of side 1/10 (§ 2.5, exact)
  prior art: owed
  handoff: none — a class result that sorts the determiners; it crosses with FS121-D4-FACE if the class is wanted in Lean

### 2.3 Holes (FS121-D4-HOLE)

*Argument.* Let `f` be honest, saturated, in D-NF; `D` a region of colour `β` (a component of `int S̃_β`); `K` a bounded component of `ℝ² ∖ cl D`.
By FS111-M-HULL2 a piece has diameter at most 1, so `diam D ≤ 1`; every point of `K` lies in the convex hull of `cl D` (a line separating it from
`cl D` bounds an unbounded connected set missing `cl D`), so `diam K ≤ 1`. Let `x ∈ ∂K`; then `x ∈ ∂D` (`∂K ⊆ cl D`, and `x ∈ D` would put a ball
about `x` inside `D`). Suppose `x ∉ Σ`.
(a) `x ∉ int S̃_β`, else a ball about `x` lies in `int S̃_β`, meets `D`, and so lies in `D`. Hence every ball about `x` has positive non-`β` measure
(a ball a.e. inside `S_β` consists of density points of `β`), and some colour `j ≠ β` has `x ∈ supp S_j`.
(b) `β` and `j` have positive upper density at `x`: a colour present at `x` with density 0 makes `x` a cusp, a point of Σ. So `x ∈ ∂_e S_β`, and
(H1), (H2) hold at `x` with the colours `β` and `j`: a ball `N`, connected open sets `P_β`, `P_j` a.e. equal to `S_β ∩ N`, `S_j ∩ N`.
(c) `P_β` is an open connected subset of `S̃_β` meeting `D` (in positive measure), so `P_β ⊆ D`. `P_j ∩ D` is open and null, so empty, and
`P_j ∩ cl D = ∅`: `P_j` lies in one component of `ℝ² ∖ cl D`. `K ∩ N` is open, non-empty, misses `D ⊇ P_β`, so lies a.e. in `P_j`: `P_j ⊆ K`.
(d) FS111-M-PINCH at `x`. *Tangent:* `B(y_β, 1) ∩ N ⊆ S_j` a.e., so `D ∩ N` misses the open disc and `D ⊄ B̄(y_β, 1)`; by C-HULL's first clause
`D ∩ B(y_β, 1) = ∅`, hence `cl D ∩ B(y_β, 1) = ∅`. The disc is connected, misses `cl D`, and meets `P_j` (it is a.e. in `S_j` near `x`), so it lies in
`K`: `diam K ≥ 2`, a contradiction. *Split, `β` inside `T₁(y)`:* `D ∩ N ⊆ B̄(y, 1)`, so `D ⊆ B̄(y, 1)` and `K ⊆ conv(cl D) ⊆ B̄(y, 1)`; but `K ∩ N` is
a non-empty open set a.e. in `S_j ∩ N = N ∖ B̄(y, 1)`: a contradiction. *Split, `β` outside:* `D ∩ B(y, 1) = ∅` as in the tangent case, and
`B(y, 1) ∩ N = S_j ∩ N` a.e. meets `P_j ⊆ K`, so `B(y, 1) ⊆ K`: `diam K ≥ 2`, a contradiction. So `x ∈ Σ`. ∎
`K` is bounded, open and non-empty, so `∂K` contains a non-degenerate continuum (the boundary of the unbounded component of `ℝ² ∖ cl K`): Σ is
uncountable there.

derivation: FS121-D4-HOLE
  statement: in an honest saturated colouring in D-NF, if a region D (a component of the interior of the density set of one colour) has a bounded
    complementary component K of its closure, then every point of ∂K lies in Σ; so Σ contains a non-degenerate continuum, and a colouring whose Σ is
    locally finite has no region with a hole
  uses only: FS111-M-PINCH at a point off Σ (both types); FS111-C-HULL's first clause for D at the contact; FS111-M-HULL2 (diam D ≤ 1); that a bounded
    complementary component lies in the convex hull; the definition of Σ (cusps and (H1), (H2) failures)
  not claimed: that a region with a hole exists or not in any saturated colouring (none is held); anything about unbounded complementary components;
    REG-J′ (unused)
  argument: § 2.3 Holes (FS121-D4-HOLE)
  verdict: derived
  grade: derived from: FS111-M-PINCH
  minds: 1
  model: none held of the hypothesis — no held saturated colouring (R7, SQ9, HEX9, TINY16) has a region with a hole; the statement is a no-go for
    islands whose shore holds a point off Σ, the configuration a point accumulation of islands in one sea would need
  prior art: owed
  handoff: none — a structural no-go between open statements; it crosses with FS111-M-PINCH

### 2.4 The line (FS121-D4-LINE)

*The analogue* (this record's): on `ℝ` with the unit graph `x ~ x ± 1`, a measurable `f : ℝ → {0, 1}`; `∂_e`, saturation, (H1), (H2) and Σ read with
intervals in place of balls.
*Argument.* Let `f(x) = (⌊x⌋ + v(x − ⌊x⌋)) mod 2` for any measurable `v : [0, 1) → {0, 1}`. Then `f(x + 1) = 1 − f(x)` for every `x`: proper at every
unit pair. So `S_1 = S_0 + 1`, `supp S_1 = supp S_0 + 1`, and both are 2-periodic. If `x ∈ ∂_e S_j`, then `j` has positive upper density at `x` and not
density 1, so `1 − j` has positive upper density at `x` and `x ∈ supp S_{1−j} = supp S_j + 1`: the point `x − 1 ∈ supp S_j` is at distance exactly 1.
Every such `f` is honest and saturated, whatever `v`. Take `v(t) = ⌊1/s(t)⌋ mod 2` with `s(t)` the distance from `t` to `Z₀ = {0} ∪ {1/n : n ≥ 1}`
(`v = 0` on `Z₀`): `v` changes at `1/n ± 1/k` for all large `k`, so each point of `Z₀ + ℤ` meets infinitely many interface points, both colours have
upper density `1/2` there and each is locally disconnected, (H2) fails, and Σ ⊇ `Z₀ + ℤ`, which accumulates at every integer. ∎ Checked exactly
(`tools/fs121_d4_tiny16.py`): `f(x + 1) = 1 − f(x)` at 11,760 rational points near the breakpoints, and a colour change of `f` at every one of the
3,899 points `1/2 − 1/k`, `101 ≤ k < 4000`.

derivation: FS121-D4-LINE
  statement: on the real line with the unit graph x ~ x ± 1, every colouring f(x) = (⌊x⌋ + v(x − ⌊x⌋)) mod 2 with v measurable is proper at every
    unit pair, honest and saturated; with v(t) = ⌊1/dist(t, Z₀)⌋ mod 2, Z₀ = {0} ∪ {1/n}, its singular set contains Z₀ + ℤ and is not locally finite
    — the line analogue of C121-REGJ is false with two colours
  uses only: f(x + 1) = 1 − f(x); the definitions of ∂_e S_j, saturation and Σ read on intervals
  not claimed: anything in the plane (the plane's unit circle is a curve, and FS121-D4-FACE is what the line lacks); that the analogue on a circle of
    length 5/2 (FS121-D3-SWAP1D's setting) behaves alike
  argument: § 2.4 The line (FS121-D4-LINE)
  verdict: derived
  grade: hand
  minds: 1
  model: v as stated; the exact check of § 2.4
  prior art: owed
  handoff: none — a calibration that sorts the dimension as a determiner

control: FS121-D4-LINE-EXACT
  of: FS121-D4-LINE — the identity f(x + 1) = 1 − f(x) and the colour changes at 1/2 − 1/k hold exactly; without the ⌊x⌋ shift the identity fails
  run: python3 ../tools/fs121_d4_tiny16.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d4_tiny16.py --plant noshift 2>&1 | tail -1

### 2.5 Small regions (FS121-D4-TINY16)

*The object.* `P_ε`, a partition of the line: breakpoints `m`, `m + ε`, `m + 1/2` (`m ∈ ℤ`), gaps indexed `i ∈ ℤ` in order, three per unit, gap `i`
coloured `i mod 4`. TINY16 is the product: cell (gap `i`) × (gap `j`) coloured `(i mod 4, j mod 4)`, sixteen colours.
*Argument.* Translating by 1 adds 3 to a gap's index, so the gap `i + 4` begins exactly 1 to the right of gap `i`'s end, and same-coloured gaps lie in
one gap or at distance at least 1: same-coloured cells have coordinate differences each `< 1/2` or `≥ 1`, never a distance in `(1/√2, 1)`, so unit
pairs inside a class are null. A vertical edge at the end `q` of gap `i` has the colour of gap `i` again in the closure of the cell starting at `q + 1`
(gap `i + 4`), and the colour of gap `i + 1` in the cell ending at `q − 1` (gap `i − 3`); horizontal edges alike; each corner reaches each incident
colour by one of its four unit translates. So TINY16 is honest, saturated, a.e.-proper, a grid colouring, and its cells (gap `0`) × (gap `0`) have
diameter `ε√2`, for every `ε ∈ (0, 1/2)`. ∎ Checked exactly at `ε = 1/10` over the window `[−3, 7]²`, which holds every cell within distance 2 of the
fundamental domain `[0, 4)²`: 2,912 same-colour pairs with `dmin < 2`, none with `dmin < 1 < dmax`; 288 edges and 144 corners, every contact present
(`data/fs121/d4/tiny16.out`).

derivation: FS121-D4-TINY16
  statement: for every ε in (0, 1/2) the product of two copies of the partition of the line at m, m + ε, m + 1/2 (m ∈ ℤ), gaps coloured by their index
    mod 4, is an honest saturated a.e.-proper sixteen-colouring of the plane whose cells include squares of side ε; so a saturated colouring with a
    fixed number of colours can have regions of every small diameter, and no count of singular points per region bounds Σ per unit area
  uses only: translation by 1 shifts the gap index by 3, so same-coloured gaps are 4 apart in index and at least 1 apart in position; the contacts at
    unit translates along the normals
  not claimed: that sixteen is least for small regions; any accumulation (every grid colouring with countable breakpoints has none, FS121-D4-GRID)
  argument: § 2.5 Small regions (FS121-D4-TINY16)
  verdict: derived
  grade: computed over: ε = 1/10, the window [−3, 7]² of the 4ℤ²-periodic colouring, exact rationals; the hand argument for every ε
  minds: 1
  model: TINY16 at ε = 1/10 itself
  prior art: owed
  handoff: none — a control object, exact and periodic

control: FS121-D4-TINY16-EXACT
  of: FS121-D4-TINY16 — every same-colour pair proper and every contact present; with the gaps coloured mod 3 the properness check fails
  run: python3 ../tools/fs121_d4_tiny16.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d4_tiny16.py --plant mod3 2>&1 | tail -1

## Stage 2 — SAVED

## Stage 3 — SAVED: C121-REGJ — GAP at lateral extent (LAT); the reduction to fall colourings; the verdict

### 3.1 What the lemmas leave

The claim fails only if some bounded set holds infinitely many points of Σ, or a point of Σ met by infinitely many interface arcs. Every shape of
that failure examined here is an accumulation of pieces: with finitely many colours, infinitely many regions near a point include infinitely many of
one colour `c`, pairwise "near" (FS111-M-HULL2). A Σ that is wild in measure with no regions about it (a class with empty interior) is not examined.
Stage 2 decides three shapes of it:
- **pieces with lateral extent facing across small gaps** — impossible (FS121-D4-FACE), which decides every grid colouring with countable
  breakpoints (FS121-D4-GRID);
- **islands in one sea** — impossible unless every shore is singular, and then Σ already holds a continuum (FS121-D4-HOLE);
- **anything on the line** — possible with two colours (FS121-D4-LINE): the plane's unit circle, through its curvature, is what any proof uses.

What none of them reaches is an accumulation in which, at every point where `c` lacks density 1, no flat side of a `c`-piece faces another `c`-piece
whose lateral half-width exceeds `√(2g)` across its gap `g`. Pieces that shrink in every direction faster than the square root of their mutual gaps
do this: `c`-pieces of diameter `r_n` at mutual gaps `g_n ≫ r_n²` accumulating at a point, the sea between them cut into several regions (HOLE
forbids one). Regions that small are possible at a fixed `k` (FS121-D4-TINY16); their accumulation is neither built nor excluded. Two further
residues sit beside it, each a not-claimed line of stage 2: a Cantor set of breakpoints where `c` has density 1 at the ends of its pieces (GRID),
and a curved near side whose contact is the in-contact `x − e` (FACE).

**The named step, LAT** (this record's): *at every accumulation point of Σ or of the interface arcs of an honest saturated colouring in D-NF, some colour has
two pieces in FS121-D4-FACE's position — a half-box at a point `x` where the colour lacks density 1, and a box of lateral half-width `ρ` straight
ahead across a gap `g` with `2g < ρ²`.* LAT with FS121-D4-FACE gives C121-REGJ: an accumulation of arcs would put such a pair at a point of `∂_e S_c`
with no contact. LAT is false on the line (FS121-D4-LINE), true on grids (FS121-D4-GRID), and is where the dimension two has to be spent.

*Three attempts on LAT, each stalled at the same place.* (1) **Pigeonhole on pieces, as on grids.** It needs the pieces to share one row, so that the
box ahead has the row's height as lateral extent; off a grid, same-colour pieces near the accumulation may sit at lateral offsets of their own size,
and FACE's lateral margin `√(2g)` is then not met. (2) **Shrink to the accumulation point and blow up.** Below the unit scale the constraints are a
separability condition (§ 1.2, home 2), which accumulating families satisfy; the obstruction lives at distance 1, where the blow-up sees nothing.
(3) **Count ends per region** (the plan's handle). FS111-M-EXTREME gives each region two points of Σ, but regions can be as small as wished
(FS121-D4-TINY16), so a count per region bounds nothing per unit area. All three stop at the same relation: *lateral extent against gap* — the
one relation no home holds. The provisional drop: LAT goes to a fresh mind with the sorted features of § 1.2 and stage 2's three shapes.

### 3.2 The reduction to fall colourings (FS121-D4-FALL)

FS121-D3-FALLSAT, verbatim: "every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null
unit pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated a.e.-proper
k-colouring". So C121-REGJ restricts to every measurable idomatic partition, and **a measurable fall colouring with a non-locally-finite singular set,
at any number of colours, refutes C121-REGJ**, with saturation free. In particular a regular maximal partition containing an HC-type Cantor pinch
(FS111-M3-HC, FS111-M4-LADDER: the pinch set `Z` lies in Σ) would refute it: C121-REGJ implies that FS-120's pinch never sits in a fall colouring.
FS111-M4-HC excludes HC_K from every partition whose ladder is ordinary through three rungs; partitions whose ladder stops being ordinary sooner are
FS-120's open question.

derivation: FS121-D4-FALL
  statement: if C121-REGJ holds, then every measurable idomatic partition of the plane into finitely many maximal unit-avoiding sets has a locally
    finite singular set with finitely many interface arcs at each of its points; so a measurable fall colouring at any k whose singular set is not
    locally finite — for instance a regular maximal partition containing a Cantor pinch of FS111-M3-HC's type — refutes C121-REGJ
  uses only: FS121-D3-FALLSAT (one mind)
  not claimed: that such a fall colouring exists; the converse (a saturated colouring need not be idomatic, FS121-D3-SWAP1D)
  argument: § 3.2 The reduction to fall colourings (FS121-D4-FALL)
  verdict: derived
  grade: derived from: FS121-D3-FALLSAT
  minds: 1
  model: k = 7: R7, a regular maximal partition (FS111-VMW-R7-MAX) with Σ the lattice
  prior art: known — a corollary of FS121-D3-FALLSAT
  handoff: none — a routing remark: it puts FS-120's pinch on C121-REGJ's path

### 3.3 The verdict

derivation: C121-REGJ
  statement: in every honest saturated colouring in D-NF, with any number of colours, the singular set Σ is locally finite and each point of Σ meets finitely many interface arcs.
  argument: § 3.1 What the lemmas leave
  verdict: gap: LAT — at every accumulation point of Σ or of interface arcs some colour has two pieces in FS121-D4-FACE's position (a half-box at a point
    where it lacks density 1, a same-colour box of lateral half-width ρ straight ahead across a gap g with 2g < ρ²); LAT with FS121-D4-FACE gives the
    claim; LAT holds on grid colourings with countable breakpoints (FS121-D4-GRID) and its line analogue fails (FS121-D4-LINE); open where same-colour
    pieces shrink in every direction faster than the square root of their gaps

*Colours:* every `k`; the GAP is colour-generic (no step reads `k` but the pigeonhole). *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9; `k = 16`,
TINY16 (this record, exact), each with locally finite Σ. *No counterexample is held at any `k`, and none was searched for.* The claim restricts to
measurable fall colourings (FS121-D4-FALL), which is where a refutation is cheapest to look for: saturation comes free there.

**For the coordinator.** (1) The recognition differs from the plan's handle (§ 1.2): the bound on ends is the colour count read through lateral
extent, not a count per region, and per-region counts are idle by TINY16. (2) LAT is the claim's content stated where the dimension is spent; it is
not the claim renamed — it is false on the line, where the claim's analogue is false too, and true on grids — but its open case (point-like
accumulation) is most of the claim, and I report it as the GAP, not as progress toward TRUE. (3) FS-120's pinch lies on this claim's path
(FS121-D4-FALL).

## Stage 3 — SAVED
