# FS121-D1 — the (R2) end of a curved ladder: C121-R2-FOUR and C121-CURVED (Ephodos, derivation job, round 1)

*Ephodos (Opus 5.5), job FS121-D1, brief `data/fs121/briefs/FS121-D1-r2-ends.md` with `plans/STANDING-RULES.md` as part of it. Claims:
`data/fs121/claims.md` § 2 (frozen 2026-09-29 05:41 UTC). Plan: `plans/FS121-map-step.md`. I write only this record, `data/fs121/d1/`,
`tools/fs121_d1_*.py` and `data/fs121/reports/FS121-D1.md`. Entries use my identity's grammar; `hand` is [hand], `derived from` is [derived],
`computed over` is [tools]; verdict `derived` is TRUE, `gap:` is GAP. **Class words used below** (this record's, not the list's): *cusp-free* — no
colour has density 0 at any point of its support (C121-CURVED's "no colour of density 0 at any point"); a *partner curve* of a tangent-type interface
`I` between `a` and `b` (normal `ν` into `b`) is `I + ν`, the unit parallel on `b`'s side, which carries `a` on its far side (FS111-M-PINCH,
FS111-M2-INTRAD step (1)); its *preimage* is `I`.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, minds, address)*

- FS121-D1-XCORNER — the inner unit parallels of a convex corner's edges meet at distance 1/sin(θ/2), cot(θ/2) along each — [hand], one mind, elementary — § 1.3.
- FS121-D1-VT — vertex transport: beyond a partner curve the colour pattern is the preimage's, pointwise; no arc ends on its far side at the image of
  an interior point of the preimage (cusp-free class) — [hand] over FS111-W-NOREP (one mind), one mind — § 2.1.
- FS121-D1-EROSION — at a convex corner of angle θ < π with straight tile edges, one edge is at most cot(θ/2) long, or both have a vertex at cot(θ/2) —
  [derived], one mind — § 2.2.
- FS121-D1-FIRSTORDER — at a three-colour (R2) centre every SATPIN constraint on ω(z) is implied by M-HALF; the r|s edge points into −Q — [hand], one
  mind — § 2.3.
- FS121-D1-R2SMOOTH — a smooth end of an (R2) arc puts q's edge on the away cone's boundary, as the inner parallel of the continuation — [derived], one
  mind — § 2.4.
- FS121-D1-RUNG2 — an (R2) window has 2 sin(ℓ/2) ≤ 1, and 4 sin(ℓ/2) ≤ 1 when cusp-free (ℓ < 29°) — [derived], one mind — § 2.4.
- FS121-D1-R2CORNER — smooth-straight (R2) ends: q's tile has a bend or colour change within tan(ℓ/2) ≤ 1/√15 of the ends — [derived], one mind — § 2.5.
- C121-R2-FOUR — GAP at the band structure of the corner (no three-colour (R2) end built or excluded) — § 2.6. Its open step sharpened at § 3.4.
- FS121-D1-PENCILWIN — every curved tangent pencil (cusp-free, single inner arc) has window 4 sin(ℓ/2) ≤ 1 — [derived], one mind — § 3.1.
- FS121-D1-DOUBLE — two interleaved pencils about z and z + he give a radially saturated three-colour structure beyond C₁, by formula — [hand], one
  mind — § 3.2.
- C121-CURVED — GAP at the transverse subdivision (no inhabitant, no obstruction) — § 3.3.

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have searched for a saturated fragment with a three-colour (R2) centre (a finder over tile arrangements about a point). Did not; the
  recognition below derives what such a centre must carry first (the erosion corner), and any construction is by formula.
- Stage 2: would have run a finder for the band structure of the corner (non-concentric interfaces in the disc sector and band 1 over the window, with
  z's colours fixed at q, r, s). Did not; derived FS121-D1-FIRSTORDER, -EROSION and -R2CORNER, and named the band structure as the GAP.
- Stage 3: would have run a finder for a transverse subdivision of the offset-pencil sub-bands. Did not; built the radial structure by formula
  (FS121-D1-DOUBLE) and named the transverse subdivision as the GAP.

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript, no `chats-bak/`, no auto-memory beyond the index the harness showed at launch. I write
nothing where FS121-DB1 or FS116-V1 read: only the four paths above.

## Slips

- *(none)*

## Stage 1 — SAVED: the readback, and the recognition

### 1.1 Readback of the brief

Every quotation in the brief, checked verbatim by `tools/fs121_d1_quotes.py` (whitespace normalised, nothing else; a missing source is a failure),
input `data/fs121/d1/quotes-brief.tsv`, output `data/fs121/d1/quotes-brief.out`: **5 of 5 found, exit 0**. The plant (the first quote altered by one
character) is reported missing and fires (`data/fs121/d1/quotes-brief-plant.out`, exit 0 as a fired plant).
- C121-R2-FOUR, its *not claimed* line, C121-CURVED and its *not claimed* line (`data/fs121/claims.md` § 2): found.
- The brief's "FS121-O1 noted that its argument never uses the four-colour hypothesis" is a paraphrase, not a quotation; its source is the plan's
  "Its argument reads M-PINCH at edge interior points and never uses the four-colour count" (`plans/FS121-map-step.md` § Stage 4), found there verbatim
  (row 5 of the TSV). It is **not** in `plans/FS116-local-exclusion.md`, which the brief's sentence sits beside: a reading note, not a mismatch.
- The brief's § Why this job paraphrases the plan's § 3.2–3.4 without quotation marks; read against the source, it matches.

**No mismatch.** One finding about the claims, for Keryx (statement scope, not a mismatch): C121-ENDS's "at least three **distinct** colours when no
colour at z has density 0" (and so C121-R2-FOUR's count) rests on FS111-W-NOREP, whose hypothesis is a map **without cusps** — H-DEN at the contacts it
reads, points at distance 1 from `z` (`plans/FS111-W-wild.md` § 2.1, § 2.3) — not only "no colour has density 0 at `z`". Every lemma of this job is
stated in the cusp-free class, where NOREP applies at every point.

**My claims, restated beside the quotations.** C121-R2-FOUR: in every honest saturated REG-J′ colouring, any `k`, a centre `z` of an (R2) arc ending a
chain of unit parallels, with no colour of density 0 at `z`, carries at least four colours. C121-CURVED: for some `k ≥ 7`, an honest saturated REG-J′
colouring, cusp-free, with a tangent-type interface arc of finite radius. Verdicts owed: TRUE, FALSE with a formula object checked exactly, GAP at a
named step, or MISSTATED; each with its colour count and its inhabitant or "none held".

### 1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall.** The opening's card stopped at the (R2) branch: ENDS gives the (R2) centre three colours — `q` in the away cone of width `π − ℓ`, and two
more because the facing cone of width `π + ℓ` exceeds `π` (FS111-M-HALF) — and nothing gives the fourth. Its shape is "a wall that describes a
counterexample": no held colouring has an (R2) arc (C121-PER), so the refuting class is described and uninhabited. The cue (G79) is to ask what every
actual (R2) end carries.

**For a stranger** (a convex geometer who works on parallel sets and erosions): *Partition the plane into finitely many measurable classes, no class
holding two points at distance exactly 1 (a.e.), such that every boundary point is at distance exactly 1 from each of its own classes. Then a
two-class boundary is a curve with two tangent unit discs, and away from the few points where three classes meet, its unit parallel on either side is
again a boundary curve, carrying the class of the other side beyond it. Let `Q` be a tile of class `q` with a convex corner `z` of angle
`θ ≤ π − ℓ`; over a window `W` of normal directions at `z`, of width `ℓ`, the unit level set of `dist(·, Q)` is a boundary arc `J₁` with class `p`
between it and `z`, and `z` itself does not touch `p`. How many classes meet at `z`?*

**Features, sorted** (receipt in brackets):
- no monochromatic unit pair — *determines* (every step of M-PINCH consumes it);
- saturation — *determines*, only through its consequence "a tangent-type interface's unit parallels are interfaces carrying the other side's class
  beyond" (M-PINCH; INTRAD step (1)); the split type contributes nothing here, since its centre carries both classes;
- the colour count `k` — *accompanies* (no lemma below reads it; SQ9, HEX9 at `k = 9` and R7 at `k = 7` satisfy each);
- the outward pencil beyond rung 2 — *accompanies* the count at `z` (only `J₁`, its partner at radius 2 and the partners of `z`'s edges are read);
- `ℓ` — *determines*: it sets the facing cone `π + ℓ > π` (the third colour) and, through the `p`-tile beyond rung 2, is bounded (§ 2);
- `p ∉ P(z)` — *determines*: it separates (R2) from (Q), where FS112-N3-NOBOTH gives four;
- cusp-freeness — *determines* through FS111-W-NOREP (distinct colours at a vertex; and every lemma below);
- the types of `z`'s edges (SATPIN's dichotomy) — *unsorted* at the start; **sorted by the recognition**: what determines is not where the edges'
  partners sit on `ω(z)` (the plan's aim, § 4.2 D1 row) but where the **partner curves** of the `q`-tile's two edges meet, at distance
  `1/sin(θ/2)` from `z`.

**Homes, each with its test:**
1. **Parallel sets, normal cones and erosion of a convex body** (Steiner, Federer's reach; morphology's erosion `Q ⊖ B(0,1)`). Dictionary: `J₁` ↔ the
   unit level set of `dist(·, Q_z)` over the normal cone `N(Q_z, z)`; FS112-U1's cone for `q` ↔ `W ⊆ N(Q_z, z)`; the pencil ↔ the integer level sets;
   the partner curves of `Q_z`'s edges on `Q_z`'s side ↔ the inner unit parallels, whose meeting point is the corner of the erosion. *Tests:* the old
   proofs apply (U1 is the normal-cone inclusion, verbatim); it **predicts a neighbour**: the inner parallels of the corner's two edges meet at
   `X = z + u(bisector)/sin(θ/2)`, at distance `cot(θ/2)` along each from its foot (exact, `tools/fs121_d1_erosion.py`). **Adopted as the working
   home.** Its one changed step: a convex body's erosion is a set; here each inner parallel carries a colour on its far side, and two of them may cross
   only where both change colour (FS121-D1-VT, § 2).
2. **Wavefronts** (Huygens, the eikonal equation, the grassfire transform): the ladder is a unit-step front, the (R2) end a point source at a corner.
   *Test:* no theorem about colours; it restates home 1 dynamically. Kept as language.
3. **FS-112's vertex calculus** (U1, NOBOTH, SATPIN): the own home. *Test:* NOBOTH's step reads both side colours at the centre; at an (R2) centre the
   inner colour is absent, so its step does not transfer (the changed step would be the inner colour's cone, which is empty). It yields three, not four.
4. **Planar maps and Euler counting.** *Killed:* a count does not see the metric, and every constraint here is a distance (G86).

**The recognition sentence:** *an (R2) centre is a convex corner of the `q`-tile whose normal cone contains the arc's window; the pencil is the family of
integer level sets of the distance to that tile; and what the corner carries is read where the inner unit parallels of the tile's two edges — the
partner curves carrying the neighbouring colours — meet, at the erosion corner.* **It differs from the plan's aim** (partners on `ω(z)`, first order at
`z`): the constraint lives at distance `1/sin(θ/2)` from `z`. Reported to Keryx.

**For C121-CURVED** (the same stranger): *is there such a partition with a pencil of concentric boundary arcs of radii `n, n + 1, …` over a fixed window?*
Sorted: periodicity *determines, negatively* (C121-PER: none periodic); `k` *accompanies*; the colour rule along rungs *determines* — in home 1's words,
each rung is the partner curve of both its neighbours, so the colour pattern just inside rung `k` equals the pattern just outside rung `k + 1`, pointwise
along the radial normals (§ 3). Homes tested: aperiodic tilings with a radial centre (Penrose-type, pinwheel) — *killed*: none has a boundary family at
unit spacing about a corner; the flat ladder SQ9 bent round a corner — *the working picture*: its flat parts are SQ9, its corner part needs band
interfaces that no concentric circle can supply (INTRAD: a concentric arc of radius `n + 1/2` descends to curvature 2).

### 1.3 The home's predicted neighbour, as an entry (elementary; the lemmas that use it are stage 2's)

*Argument.* Put `z = 0`, the edges along `u(φ₁)` and `u(φ₂)`, `φ₂ = φ₁ + θ`, `0 < θ < π`. The unit normals into the corner are `n₁ = u(φ₁ + π/2)`,
`n₂ = u(φ₂ − π/2)`; the parallel lines are `n_i + t·u(φ_i)`. The point `X = u((φ₁ + φ₂)/2)/sin(θ/2)` has component `1` along each `n_i` (the angle
between `u((φ₁+φ₂)/2)` and `n_i` is `π/2 − θ/2`) and component `cot(θ/2)` along each `u(φ_i)`; so it lies on both lines, at parameter `cot(θ/2)`. ∎

derivation: FS121-D1-XCORNER
  statement: for a convex corner at z of angle θ in (0, π) with straight edges, the two lines parallel to the edges at distance 1 on the corner's side
    meet at a point X with |X − z| = 1/sin(θ/2), at distance cot(θ/2) along each line from the foot of the perpendicular from z
  uses only: elementary trigonometry
  not claimed: anything about colours (that is FS121-D1-VT and FS121-D1-EROSION, stage 2)
  argument: § 1.3 The home's predicted neighbour, as an entry (elementary; the lemmas that use it are stage 2's)
  verdict: derived
  grade: hand
  minds: 1
  model: θ = π/2 at z = 0 with edges along the positive axes: the lines y = 1 and x = 1 meet at X = (1, 1), |X| = √2 = 1/sin(π/4), one unit from
    each foot
  prior art: known — elementary; the erosion of a convex cone by a unit disc is a cone with apex at this X (classical, recalled, not read)
  handoff: none — elementary trigonometry; it crosses with FS121-D1-EROSION if that is formalized

control: FS121-D1-XCORNER-EXACT
  of: FS121-D1-XCORNER — the meeting point at 60 angle pairs to 60 digits, and the lemma's conclusion on one tile of SQ9 and of HEX9 (no two partner
    segments of a tile cross at interior points); the plant enlarges the hexagon's side past cot(π/3), where adjacent partner segments cross
  run: python3 ../tools/fs121_d1_erosion.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d1_erosion.py --plant hexbig 2>&1 | tail -1

## Stage 1 — SAVED

## Stage 2 — SAVED: C121-R2-FOUR — GAP at the band structure of the corner; five lemmas on the way

*Setting for every entry of this stage: `f` an honest saturated colouring in D-NF satisfying REG-J′, **cusp-free** (the header's word); any `k`.
Notation at an (R2) arc `J₁ ⊂ ω(z)`: window `W = [α₀, α₁]` of width `ℓ`, ends `A_i = z + u(α_i)`, inner colour `p` (not carried at `z`), outer colour `q`
(carried at `z`); the away cone `C_a = [α₁ + π/2, α₀ + 3π/2]` of width `π − ℓ` holds `q`'s sector `Q` (FS112-U1). Three colours at `z` means `q` and
two more, `r` and `s`; by FS111-W-NOREP each has one sector: `Q = [φ₁, φ₂]`, then counter-clockwise `S = [φ₂, φ₃]`, `R = [φ₃, φ₁ + 2π]`, with edges
`e_rq` at `φ₁`, `e_qs` at `φ₂`, `e_sr` at `φ₃`.*

### 2.1 Vertex transport along partner curves (FS121-D1-VT)

*Argument.* Let `I` be a tangent-type interface arc between `a` and `b`, `ν` the unit normal into `b`, and suppose `I` is not a unit arc curving toward
`b` (its curvature toward `b` is `< 1`: FS111-M-C11 bounds it by 1, FS111-M2-INTRAD makes radii integers, and radius 1 toward `b` is the focal case).
Then `x ↦ x + ν(x)` is a `C¹` immersion (speed `1 − κ_b > 0`), its image `L` is the unit parallel on `b`'s side, and (i) by FS111-M-PINCH (tangent)
with M-HULL1, `x + ν(x) ∈ supp S_a` with `a`'s material there lying beyond `L`, on the side away from `I`; by FS111-M2-INTRAD step (1), `L` is an interface
at its points off `Σ`, with `a` on that far side. (ii) Let `Y` be the image of an interior point `x₀` of `I`. Shrinking about `x₀`, `L` near `Y` is a `C¹`
curve all of whose points but `Y` are off `Σ` (REG-J′: `Σ` locally finite), with `a` on its far side. By REG-J′ finitely many arcs end at `Y`, each with
an end tangent (FS111-M-C11); cusp-freeness gives every sector at `Y` positive angle (a sector of angle 0 between tangent arcs is a colour of density 0
at a point of its support). The two sectors on `L`'s far side adjacent to `L`'s two rays both have colour `a`; an arc ending at `Y` inside the far side
would make them two sectors of `a` at `Y`, which FS111-W-NOREP excludes (cusp-free gives its H-DEN; REG-J′ gives H2 at arc points near `Y`). ∎ So
**the colour pattern just beyond a partner curve is its preimage's far-side pattern, carried pointwise along the normals, vertices included** — the
flat ladder's rule `β_{k+1} = τ_{k−1}` (FS111-W-LADDER) made pointwise and curved.

derivation: FS121-D1-VT
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b that is
    not a unit arc curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point of I,
    no interface arc ends at Y from the far side of L
  uses only: FS111-M-PINCH's tangent partners with M-HULL1; FS111-M2-INTRAD step (1) (the parallel is an interface off Σ); REG-J′'s local finiteness
    and FS111-M-C11's end tangents; FS111-W-NOREP, whose H-DEN and H2 the cusp-free class and REG-J′ supply; no colour count
  not claimed: anything at the image of an endpoint of I (the far-side colour may change there); anything when I is a unit arc curving toward b (L is
    a point, the (Q) or (R2) end); anything with cusps (NOREP's hypothesis)
  argument: § 2.1 Vertex transport along partner curves (FS121-D1-VT)
  verdict: derived
  grade: hand
  minds: 1
  model: k = 9: SQ9 — each edge of side 1/2 is a tangent interface, its partner is the edge of the square one unit along the normal (FS111-W-LADDER,
    VM2-LAD-CTL 48 of 48), and arcs meet that partner's far side only at its two ends, the images of the edge's ends; HEX9 alike
  prior art: partly: FS111-W-LADDER's colour rule β_{k+1} = τ_{k−1} (plans/FS111-W-wild.md § 2.4) is the flat case along one normal line; the plan's
    query “(parallel curve | parallel curves | equidistant*) & (unit distance | colo*)” (21, plans/FS121-map-step.md § 2.2) returned nothing bearing
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and FS111-W-NOREP: the statement with its not-unit-arc clause and the cusp-free class

### 2.2 The erosion corner (FS121-D1-EROSION)

*Argument.* Let a colour `q` have at `z` a sector of angle `θ ∈ (0, π)` whose two edges begin with straight pieces `e₁ = [z, z + L₁u(φ₁)]`,
`e₂ = [z, z + L₂u(φ₂)]`, `φ₂ = φ₁ + θ`, each the maximal straight segment from `z` along which the boundary of `q`'s tile runs with `q` on the sector's
side (the colour on the other side may change at vertices of `e_i`). A straight interface is of tangent type (FS111-M-C11 (iii)), not a unit arc, so
FS121-D1-VT applies to each interface arc of `e_i`, with `b = q`: the partner line `Λ_i = e_i + n_i` (`n_i` the unit normal into the sector) carries,
beyond it, the non-`q` colour of `e_i` at the preimage point. By FS121-D1-XCORNER, `Λ₁` and `Λ₂` meet at `X`, the image of the point `x_i ∈ e_i` at
distance `cot(θ/2)` from `z`, and cross there transversally (`θ ∉ πℤ`). Suppose `L₁, L₂ > cot(θ/2)`. Then each `Λ_i` is a straight line through `X`
whose two rays near `X` are images of points of `e_i` on both sides of `x_i`, hence interface arcs (off `Σ` near `X`). If `x₁` were an interior point of an
interface arc of `e₁`, FS121-D1-VT would forbid an interface arc ending at `X` from `Λ₁`'s far side — but one of `Λ₂`'s two rays lies there. So `x₁` is a
vertex of `e₁` (a point of `Σ`), and by the same argument with the indices exchanged, `x₂` is a vertex of `e₂`. ∎ *Check on the controls:* SQ9
(`θ = π/2`, sides `1/2 ≤ cot(π/4) = 1`) and HEX9 (`θ = 2π/3`, sides `1/(2√3) ≤ cot(π/3)`) meet it, and no two partner segments of their tiles cross at
interior points; a hexagon of side `3/5` would (control FS121-D1-XCORNER-EXACT, whose plant is exactly that).

derivation: FS121-D1-EROSION
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its
    edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two pieces
    has a point of Σ at distance cot(θ/2) from z
  uses only: FS121-D1-VT on each interface arc of the two pieces; FS121-D1-XCORNER for the meeting point; FS111-M-C11 (iii) (a straight interface is of
    tangent type); no colour count
  not claimed: anything for curved edges (their partner curves cross elsewhere, and FS121-D1-VT still forbids the crossing at images of interior points);
    anything at θ ≥ π; anything with cusps
  argument: § 2.2 The erosion corner (FS121-D1-EROSION)
  verdict: derived
  grade: derived from: FS121-D1-VT, FS121-D1-XCORNER
  minds: 1
  model: k = 9: SQ9 at a grid point (θ = π/2, both pieces of length 1/2 ≤ 1) and HEX9 at a vertex (θ = 2π/3, both of length 1/(2√3) ≤ 1/√3); exact in
    ../tools/fs121_d1_erosion.py
  prior art: partly: the erosion of a convex cone by the unit disc is classical (recalled, not read); its reading as a bound on a saturated tile's edges is
    not in the plan's gate (plans/FS121-map-step.md § 2.2); this lemma's own search not run
  handoff: de Bruijn — with FS121-D1-VT, queued behind the measurable chain

### 2.3 The first order at a three-colour (R2) centre (FS121-D1-FIRSTORDER)

*Argument.* By FS111-M-HALF, `R` and `S` have width at most `π`: `φ₃ ≤ φ₂ + π` and `φ₃ ≥ φ₁ + π`, so `e_sr` points into `Q + π`, the antipodal cone of
`q`'s sector. By FS116-O1-SATPIN's argument (which reads FS111-M-PINCH at edge-interior points and never the colour count), each of `z`'s three edges is
(split), with its centre at one of the two points of `ω(z)` on its normal carrying both side colours, or (tangent), with those two normal points carrying
the side colours crosswise. The points of `ω(z)` over `W°` carry only `p` and `q` (the relative interior of `J₁`), so the partners or centres that must
carry `r` or `s` have to avoid `W°`. They do, in every case: `e_sr`'s normal points lie in `(Q + π) ± π/2 ⊆ [α₁ + π, α₀ + 2π] ∪ [α₁, α₀ + π]`, which
misses `W° = (α₀, α₁)` since `ℓ < π`; `e_rq`'s lie at `φ₁ ± π/2` with `φ₁ ≥ α₁ + π/2`, so `φ₁ + π/2 ∈ [α₁ + π, α₀ + 2π]` and `φ₁ − π/2 ≥ α₁`; `e_qs`'s
at `φ₂ ± π/2` with `φ₂ ≤ α₀ − π/2`, symmetrically. The POLAR constraints (FS111-M-POLAR) these partners place on `R`, `S`, `Q` are the half-planes on the
far side of each edge, which a sector of width `≤ π` bounded by that edge already satisfies. ∎ **The plan's first-order aim — "SATPIN's dichotomy at every
edge at `z`, whose partners on `ω(z)` must avoid `J₁`'s window" (`plans/FS121-map-step.md` § 4.2) — decides nothing: M-HALF implies all of it.**

derivation: FS121-D1-FIRSTORDER
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, at a centre z of an (R2) arc carrying three colours q, r, s, the edge
    between r and s points into the antipodal cone of q's sector, and every partner point and split centre on ω(z) that the three edges at z require lies
    off the relative interior of the (R2) arc, whatever the edges' types
  uses only: FS111-M-HALF (widths ≤ π); FS112-U1 (q's sector in the away cone); FS116-O1-SATPIN's argument, without its four-colour hypothesis; that the
    relative interior of the (R2) arc carries p and q alone; FS111-W-NOREP (one sector per colour); no colour count
  not claimed: that a three-colour (R2) centre exists; any constraint from points of ω(z) outside the arc, or from farther than distance 1
  argument: § 2.3 The first order at a three-colour (R2) centre (FS121-D1-FIRSTORDER)
  verdict: derived
  grade: hand
  minds: 1
  model: none held at any k — no held colouring has an (R2) arc (C121-PER); the statement is about the uninhabited class the claim names (G21)
  prior art: partly: FS116-O1-SATPIN (plans/FS116-local-exclusion.md § 4.1) is the dichotomy it reads; its three-colour reading not in print (the plan's gate)
  handoff: none — a no-go for a route (the first-order aim), not a statement any later proof consumes

### 2.4 Smooth ends and the window (FS121-D1-R2SMOOTH, FS121-D1-RUNG2)

*R2SMOOTH.* Let `A₁ ∉ Σ`. Near `A₁` only `p` and `q` occur, (H1) and (H2) hold, and the connected `p | q` interface through `A₁` is of one type (FS116-O1-SATPIN's
open-and-closed argument: split points are open by M-C11 (iii) and closed by the limit of centres); `J₁` is tangent, so the continuation `C₁` beyond `A₁`
is tangent, `C^{1,1}` through `A₁` with tangent `u(α₁ + π/2)` there. Its curvature toward `p` is `< 1` near `A₁` (a unit arc toward `p` tangent to `J₁` at
`A₁` is `ω(z)` itself, and radii are integers, INTRAD), so its `q`-partner `c(x) = x + ν_p(x)` is a `C¹` curve with `c(A₁) = z`, leaving `z` in direction
`α₁ + π/2`, with `q` beyond it (FS121-D1-VT (i)). So the sector at `z` on `c`'s far side, the directions just past `α₁ + π/2`, is `q`'s; with FS112-U1 and
NOREP, `Q`'s clockwise edge is `c` and `φ₁ = α₁ + π/2`. ∎

*RUNG2.* The relative interior of `J₁` meets no point of `Σ`, so the `q`-layer just outside `J₁` and the `p`-layer just inside are path-connected subsets
of `S̃_q`, `S̃_p`, whose diameters tend to `2 sin(ℓ/2)`; FS111-M-HULL2 bounds each by 1. By FS111-M-PINCH the `p`-contacts of `J₁`'s points fill the
radius-2 arc over `W` with `p` beyond, and by FS121-D1-VT (with `I = J₁`, `a = p`, `b = q`) no arc ends on that arc's far side over `W°`: the `p`-layer beyond
it is path-connected, of diameter tending to `4 sin(ℓ/2)`. ∎

derivation: FS121-D1-R2SMOOTH
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if an end A₁ = z + u(α₁) of an (R2) arc about z is not a point of Σ,
    then the edge of q's sector at z on that side has direction α₁ + π/2 — the boundary of the away cone — and is the unit parallel, on the inner side, of
    the arc's tangent-type continuation beyond A₁
  uses only: FS116-O1-SATPIN's open-and-closed argument (one type along a connected interface); FS111-M-C11; FS111-M2-INTRAD (integer radii);
    FS121-D1-VT (i); FS112-U1; FS111-W-NOREP; no colour count
  not claimed: that the continuation is straight; anything when A₁ is a point of Σ; that an (R2) arc exists
  argument: § 2.4 Smooth ends and the window (FS121-D1-R2SMOOTH, FS121-D1-RUNG2)
  verdict: derived
  grade: derived from: FS121-D1-VT
  minds: 1
  model: none held at any k — no held colouring has an (R2) arc (C121-PER; G21)
  prior art: partly: the plan's gate (plans/FS121-map-step.md § 2.2) covers the object class; this lemma's own search not run
  handoff: none — a lemma about an uninhabited class, consumed only by FS121-D1-R2CORNER; it crosses with it

derivation: FS121-D1-RUNG2
  statement: the window ℓ of an (R2) arc in an honest saturated colouring in D-NF satisfying REG-J′ satisfies 2 sin(ℓ/2) ≤ 1; if the colouring is
    cusp-free, 4 sin(ℓ/2) ≤ 1, so ℓ ≤ 2 arcsin(1/4) < 29°
  uses only: FS111-M-HULL2 (a path-connected subset of S̃_j has diameter ≤ 1); FS111-M-PINCH's partners at radius 2; FS121-D1-VT for the cusp-free clause;
    no colour count
  not claimed: any bound on the windows of (Q) ends (their outer layer's tile structure differs); any lower bound on ℓ
  argument: § 2.4 Smooth ends and the window (FS121-D1-R2SMOOTH, FS121-D1-RUNG2)
  verdict: derived
  grade: derived from: FS121-D1-VT
  minds: 1
  model: none held at any k — no held colouring has an (R2) arc (G21); the bound 4 sin(ℓ/2) ≤ 1 is the diameter of the p-tile the (R2) definition names
  prior art: partly: FS-112's (R2) definition names "an inner-colour tile along the radius-2 circle over the whole arc" (plans/FS112-derivation.md,
    header); the bound not in the plan's gate; this lemma's own search not run
  handoff: none — a bound on an uninhabited object, consumed by FS121-D1-R2CORNER

### 2.5 The (R2) corner (FS121-D1-R2CORNER)

*Argument.* With both ends off `Σ`, FS121-D1-R2SMOOTH puts `Q`'s edges at `α₁ + π/2` and `α₀ − π/2`, so `θ = π − ℓ` and `cot(θ/2) = tan(ℓ/2)`, and makes
the edges the inner parallels `Π₁, Π₀` of the continuations `C₁, C₀`. Where `C_i` is straight near `A_i`, `Π_i` is straight near `z`, and by FS121-D1-VT (i)
`q` lies beyond `Π_i` at the image of every point of `C_i` whose outer colour is `q`, with no arc ending there on that side: the maximal straight piece of
`q`'s tile boundary along `Π_i` runs until `C_i` bends or changes its outer colour. FS121-D1-EROSION with `θ = π − ℓ` and FS121-D1-RUNG2 give the bound. ∎

derivation: FS121-D1-R2CORNER
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, at an (R2) arc about z with window ℓ whose ends are not points of Σ and
    whose continuations beyond both ends begin straight, q's sector at z is the whole away cone, and within distance tan(ℓ/2) ≤ 1/√15 of the ends A₀, A₁,
    measured along the continuations, one continuation bends or changes its outer colour, or each of q's two edges at z has a point of Σ at distance
    tan(ℓ/2) from z
  uses only: FS121-D1-R2SMOOTH; FS121-D1-VT (i); FS121-D1-EROSION at θ = π − ℓ; FS121-D1-RUNG2 (tan(arcsin(1/4)) = 1/√15); no colour count, and not the
    number of colours at z
  not claimed: that an (R2) arc exists; anything when an end lies in Σ or a continuation begins curved; any fourth colour at z
  argument: § 2.5 The (R2) corner (FS121-D1-R2CORNER)
  verdict: derived
  grade: derived from: FS121-D1-R2SMOOTH, FS121-D1-EROSION, FS121-D1-RUNG2
  minds: 1
  model: none held at any k — no held colouring has an (R2) arc (C121-PER; G21)
  prior art: partly: the plan's gate (plans/FS121-map-step.md § 2.2) covers the object class; this lemma's own search not run
  handoff: none — a necessary condition on an uninhabited object; it crosses to de Bruijn only with a decision of the (R2) branch

### 2.6 C121-R2-FOUR — the verdict, and the three attempts

*The three attempts on the one step — "a fourth colour at a cusp-free three-colour (R2) centre":*
1. **At `z`, to first order** (the plan's aim): FS121-D1-FIRSTORDER — every constraint SATPIN places on `ω(z)` is implied by M-HALF. Nothing forces a
   fourth colour there.
2. **At the erosion corner** of `q`'s tile (the recognition's home): FS121-D1-EROSION and -R2CORNER — `q`'s tile is small, with a vertex or a bend
   within `1/√15` of `z` in the smooth-straight case; the bound reads `q`'s tile, not the number of colours at `z`, and gives no fourth colour.
3. **Along the normals** (the flat ladder bent round the corner): across the straight strips beside `q`'s edges the three-colour pattern
   `… p | q | r | p | q | r …` with interface spacings `h` and `1 − h` is consistent (it is SQ9's one-dimensional pattern); in the corner, the disc sector
   over `W` and band 1 over `W`, the `r | p` and `q | r` interfaces at radii `h` and `1 + h` cannot be concentric (FS111-M2-INTRAD: a concentric arc of radius
   `h < 1` has curvature above 1), so the corner needs non-concentric band interfaces, which every attempt here leaves unconstructed and unexcluded.

**Verdict: GAP**, at the step named in the entry. The claim's hypothesis "at which no colour has density 0" is narrower than FS111-W-NOREP's cusp-free
class, which the count of *distinct* colours at `z` already uses through C121-ENDS (§ 1.1): a correction owed to the claim's scope, not to its truth.

derivation: C121-R2-FOUR
  statement: in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, every centre z of an (R2) arc that ends a chain of unit parallels, at which no colour has density 0, carries at least four colours
  argument: § 2.6 C121-R2-FOUR — the verdict, and the three attempts
  verdict: gap: excluding a cusp-free three-colour (R2) centre — q in the away cone, two colours r and s filling the facing cone of width π + ℓ with their
    common edge in the antipodal cone of q's sector (FS121-D1-FIRSTORDER), ℓ ≤ 2 arcsin(1/4) (FS121-D1-RUNG2), and in the smooth-straight case a vertex or
    bend of q's tile within 1/√15 of z (FS121-D1-R2CORNER); the open step is the band structure of the disc sector and of band 1 over the window, whose
    interfaces cannot be concentric (FS111-M2-INTRAD); no three-colour (R2) end is built, none is excluded

## Stage 2 — SAVED

## Stage 3 — SAVED: C121-CURVED — GAP at the transverse subdivision; the radial structure built by formula

### 3.1 The window of every curved pencil (FS121-D1-PENCILWIN)

*Argument.* Let a tangent-type arc of radius `n ≥ 2` about `z` descend (FS111-M2-INTRAD) to a chain ending at a single unit arc `J₁` over its window.
The rungs of radius `≥ 2` share one window `W`: each rung's inward parallel over its window is the next rung (INTRAD step (1)) and each rung's outward
parallel is the previous one's (C121-OUT), so the windows are nested both ways. Rung 2 is tangent and `J₁` is its inward parallel, so FS121-D1-VT (i),
with `I` = rung 2, puts rung 2's outer colour beyond `J₁`, inside it: rung 2's outer colour equals `J₁`'s inner colour `p` at every normal over `W°`,
whether `J₁` is (Q) or (R2). An arc ending on rung 2's outer side at an interior point would bound two sectors of `p` there, which FS111-W-NOREP excludes; so
the `p`-layer beyond rung 2 is path-connected, and FS111-M-HULL2 bounds its diameter, which tends to `4 sin(ℓ/2)`. ∎

derivation: FS121-D1-PENCILWIN
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, a tangent-type interface arc of finite radius n ≥ 2 about z whose
    chain of unit parallels ends at a single unit arc lies in a pencil whose rungs of radius at least 2 share one window, of angular width ℓ with
    4 sin(ℓ/2) ≤ 1
  uses only: FS111-M2-INTRAD step (1) and C121-OUT (the windows nest both ways); FS121-D1-VT (i); FS111-W-NOREP; FS111-M-HULL2; no colour count
  not claimed: any bound when the chain's inner end is broken by points of Σ into several unit arcs; that such a pencil exists (C121-CURVED)
  argument: § 3.1 The window of every curved pencil (FS121-D1-PENCILWIN)
  verdict: derived
  grade: derived from: FS121-D1-VT
  minds: 1
  model: none held at any k — no held colouring has a curved tangent interface (C121-OUT; G21)
  prior art: partly: the plan's gate (plans/FS121-map-step.md § 2.2) covers the object class; this lemma's own search not run
  handoff: none — a necessary condition on an uninhabited object; it crosses with C121-OUT if a curved inhabitant or an obstruction lands

### 3.2 The radial structure, by formula: two interleaved pencils (FS121-D1-DOUBLE)

*The object.* Fix `z`, a unit vector `e` and `h ∈ (0, 1)`; put `z′ = z + he`, `C_j = ∂B(z, j)`, `C′_j = ∂B(z′, j)`, and let `K` be the cone of directions
within `60°` of `e` from `z`. On a ray from `z` in direction `φ`, `c = cos(φ − e)`, `C′_j` sits at radius `ρ′_j = hc + (j² − h²(1 − c²))^{1/2}`, and
`j < ρ′_j < j + 1` for `j ≥ 1` inside `K`: `ρ′_j ≤ hc + j < j + 1`; and, with `s² = 1 − c²`, `j − (j² − h²s²)^{1/2} = h²s²/(j + (j² − h²s²)^{1/2}) ≤ h²s²/(1 + c) = h²(1 − c) < hc` because `(1 − h²s²)^{1/2} ≥ c` and `c ≥ 1/2`. So in `K`, beyond `C₁`, the circles
interleave: `C₁ < C′₁ < C₂ < C′₂ < …`. Colour the sub-band between `C_j` and `C′_j` with `A_j` and the one between `C′_j` and `C_{j+1}` with `B_j`, cycling
three colours `q, r, p` as `A₁ = q`, `B₁ = r`, `A₂ = p`, `B₂ = q`, `A₃ = r`, … (so `A_{j+1} = B_{j−1}`, `B_{j+1} = A_j`, with `B₀ = p`, the colour just
inside `C₁`).
*What holds.* (i) Two distinct sub-bands of one colour are separated by a pair of concentric circles at distance exactly 1 — `A_j` lies inside `C′_j` and
`B_{j+1}` outside `C′_{j+1}`; `B_j` inside `C_{j+1}` and `A_{j+2}` outside `C_{j+2}` — so no pair of their points is at distance 1 off those circles.
(ii) At each `x ∈ C_j`, `x ± (x − z)/|x − z|` lie on `C_{j±1}` and carry, beyond them, the colours M-PINCH's tangent type asks: the outer colour `A_j` just
inside `C_{j−1}` (`A_j = B_{j−2}`), the inner colour `B_{j−1}` just outside `C_{j+1}` (`A_{j+1} = B_{j−1}`); at `x ∈ C′_j` the same with `z′` (`B_{j+1} = A_j`).
Every rung is a tangent-type arc of integer radius about its own centre, and each band's intermediate interface is a rung of the other pencil — the
non-concentric band interfaces FS111-M2-INTRAD demands (§ 2.6, attempt 3), supplied. ∎
*What does not hold.* Each sub-band is a strip of width `< 1` and length about `jℓ`, so it holds monochromatic unit pairs within itself once its length
exceeds 1: it must be cut into tiles of diameter `≤ 1`, and by FS121-D1-VT every cut's end on a rung's far side is transported, along that rung's own
family of normals, to a vertex two sub-bands inward. The innermost part — the disc about `z` inside `C₁` and the point `z′`, which must carry `q` at `z`,
`r` at `z′` and keep `p` off `z` — is not given by the formula.

derivation: FS121-D1-DOUBLE
  statement: for a point z, a unit vector e and h in (0, 1), within the cone of directions at most 60° from e and beyond ∂B(z, 1), the circles ∂B(z, j) and
    ∂B(z + he, j), j ≥ 1, interleave, and the three-colouring of the sub-bands between them cycling as A₁ = q, B₁ = r, A₂ = p, … has no two points of one
    colour in distinct sub-bands at distance 1 off the circles, and meets FS111-M-PINCH's tangent partners at every point of every circle along the normals
    of the circle's own family
  uses only: the parallel-circle distances (points inside ∂B(c, j) and outside ∂B(c, j + 1) are at distance ≥ 1, with equality only on the circles); the
    colour rules A_{j+1} = B_{j−1}, B_{j+1} = A_j; elementary estimates for the interleaving
  not claimed: a colouring of the plane; tiles of diameter ≤ 1 (each sub-band has monochromatic unit pairs within itself once longer than 1); saturation at
    any transverse cut; anything inside ∂B(z, 1) or outside the cone; that a curved pencil must be completed this way
  argument: § 3.2 The radial structure, by formula: two interleaved pencils (FS121-D1-DOUBLE)
  verdict: derived
  grade: hand
  minds: 1
  model: h = 1/2, e = (0, 1), z = 0: on the axis the circles sit at 1, 3/2, 2, 5/2, …, SQ9's one-dimensional pattern (spacings 1/2) bent round z
  prior art: partly: SQ9's pattern along one axis (plans/FS111-W-wild.md § 1.5) is its flat case; the bent, two-centred form is not in the plan's gate
    (plans/FS121-map-step.md § 2.2); this object's own search not run
  handoff: none — a partial construction toward C121-CURVED, not a statement a proof consumes

### 3.3 C121-CURVED — the verdict

**GAP.** No inhabitant is built and no obstruction derived. What an inhabitant must carry, at every `k`, cusp-free: aperiodicity (C121-PER); a pencil of
window `ℓ ≤ 2 arcsin(1/4)` (FS121-D1-PENCILWIN) running to infinity (C121-OUT); non-concentric band interfaces (FS111-M2-INTRAD), which a second, offset
pencil supplies radially (FS121-D1-DOUBLE); and a transverse subdivision of every sub-band into tiles of diameter `≤ 1` whose vertices are transported rung
to rung along each family's normals (FS121-D1-VT), ending at an inner structure about `z` and `z′`. **Would have searched here:** a finder for that
transverse subdivision; did not.

derivation: C121-CURVED
  statement: for some k ≥ 7 there is an honest saturated colouring in D-NF satisfying REG-J′, with no colour of density 0 at any point, that has a tangent-type interface arc of finite radius.
  argument: § 3.3 C121-CURVED — the verdict
  verdict: gap: the transverse subdivision — cutting the sub-bands of a curved pencil (with FS121-D1-DOUBLE's offset pencil as its band interfaces) into
    tiles of diameter at most 1, every cut's ends transported rung to rung along each family's normals (FS121-D1-VT), and closing the inner disc about the
    two centres; neither a colouring of the plane by formula nor an obstruction at any k ≥ 7

### 3.4 Correction to stage 2 (2026-09-29, found at stage 3)

§ 2.6's attempt 3 and the C121-R2-FOUR entry's verdict said the corner's band interfaces "cannot be concentric" and are "unconstructed". FS121-D1-DOUBLE
constructs them radially, by a second pencil about `z′ = z + he`, whose innermost rung `C′₁` is a unit arc about `z′`. So the open step of C121-R2-FOUR is
sharper than stage 2 stated: not the band interfaces, but the transverse subdivision and the inner disc about `z` and `z′` with `z`'s colours held at three.
The entry's verdict is amended below it by this paragraph; its stage-2 text stands as written.

## Stage 3 — SAVED
