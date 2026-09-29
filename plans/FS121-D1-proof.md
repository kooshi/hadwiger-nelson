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

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have searched for a saturated fragment with a three-colour (R2) centre (a finder over tile arrangements about a point). Did not; the
  recognition below derives what such a centre must carry first (the erosion corner), and any construction is by formula.

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
