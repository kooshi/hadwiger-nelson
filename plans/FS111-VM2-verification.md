# FS111-VM2 — the blind verifier of FS-111's round 2 (FS111-M2)

*Job FS111-VM2 (de Bruijn, Opus 5.5), opened 2026-09-28 09:48 UTC. Brief: `data/fs111/briefs/VM2-111-verify.md`, with
`data/fs111/briefs/STANDING-RULES.md` (rule 0 read first). Blind to `plans/FS111-M2-regularity.md`, `data/fs111/fs111-m2/`, `tools/fs111_m2_*` and
`data/fs111/reports/` until stage 1 is committed. Working files: `data/fs111/fs111-vm2/`. Tools: `tools/fs111_vm2_*.py`. Notation: `data/fs111/claims.md`
§0 (D-NF, `S̃_j`, `P(x)`, `A*_j`, `∂_e S_j`, free, contact) and round 1's (`plans/FS111-M-regularity.md`: admissible and maximal covers, `F_j = supp A_j`,
M-SATC, M-HULL1/2, M-PINCH, M-C11, Σ, REG-J′).*

## Theorems this phase proved

*(statement, grade, count of minds, address; "one mind" = this verifier, blind to M2's record at stage 1)*

- **VM2-INT** — in an admissible cover with `A_j = F_j` a.e., `int F_j` contains no pair of points at distance exactly 1. [hand, one mind] §1.4
- **VM2-FACE** — if a maximal `k`-cover has classes with `A_j = F_j` a.e. and `⋃_j ∂F_j` is a locally finite plane graph, then colouring each face of
  that graph by a class whose interior contains it, erasing edges between equal colours and degree-2 vertices, and filling vertex-free islands, gives a
  map-type colouring (S–V Conditions 2–4) with at most `k` colours, a.e.-proper (D-AEMAP). [derived, one mind] §1.4. Inhabitant at `k = 7`: DISC7
  (exact: every vertex keeps exactly 3 boundaries for all 8 lens choices), and R7.
- **VM2-EQ5** — given FS106-AE-MAP6, the conditional statement "if a tight a.e.-proper five-colouring exists, some maximal five-cover has regular classes
  whose boundaries form a locally finite plane graph" is **equivalent** to `χ_m⁰(ℝ²) ≥ 6` (⟸ by vacuity). [derived, one mind] §1.4
- **VM2-PAR** — in an honest saturated colouring with REG-J′, at every (tangent) interface point `x` off Σ, `y_a(x) = x + n_b(x)`, the colour `a` has
  density 0 on the near side of the unit parallel of the interface near `y_a(x)`, and that parallel is itself an interface (colour `a` beyond, another
  colour before). [hand, one mind] §1.5
- **VM2-RAD** — under the same hypotheses every interface has radius of curvature in `{1, 2, 3, …} ∪ {∞}` almost everywhere, and a chain of inner
  parallels of an arc of radius `R` ends at a unit arc about the arc's centre `O`, which lies in Σ. [hand, one mind] §1.5
- **VM2-FIN** — hence, off Σ, each interface is locally a finite chain of segments and circular arcs of any bounded set of radii. [hand, one mind] §1.5
  **Its stage-1 proof is withdrawn at stage 2 (§2.3 D6):** a segment can leave a circle tangentially at any point, so switch points are not confined
  to finitely many tangency points. Replaced by **VM2-FIN′** (stage 2).
- **VM2-FIN′** (stage 2) — under REG-J′, the points of an interface with radius of curvature `n` form locally finitely many intervals: the `n`-th inner
  parallel (taken on the side of the centre of the component the gap starts from) maps each gap between them to an interface curve starting at that
  component's centre, one of finitely many terminal centres in Σ; distinct gaps give distinct curves (the parallel map is injective on one side), so
  infinitely many gaps would put infinitely many interface arcs at one point of Σ, against REG-J′'s second clause. By induction on `n` (the radii
  `< n` are already finitely many intervals, so near any point the gaps carry radii `> n` or segments, and every parallel up to the `n`-th is regular).
  [hand, one mind] §2.3 D6
- **VM2-DISCK7-ORIENT** (stage 2) — K (support `1/2 + sin³(3θ)/200`) placed at M2 §1.6's hex7 centres `m(√3/2, 0) + n(√3/4, 3/4)` leaves the
  tiling vertex `c + (0, 1/2)` outside all three adjacent copies (`h = 99/200` in each of its three directions) and at distance `≥ 1` from every other
  centre: **the seven classes do not cover the plane** in that orientation. [tools exact + hand, one mind] §2.3 D1, `disck7_m2orient.out`
- **VM2-DISC7-EXACT** (stage 2) — M2's DISC7 (circumscribed discs of radius `1/2`) checked by exact bounds (not samples): cover, same-colour separation,
  maximality, lenses, exclusive centres, self-parallel, curvature exactly 2, and the face colouring's degree 3 at every vertex. [tools exact, one mind]
  §2.3 D2, `disc7_discs.out`
- **VM2-LAD-CTL** — the controls satisfy M2-INTRAD's conclusions, exactly: SQ9 (48 of 48 edge-sides carry the unit-parallel ladder), HEX9 (76 of 76),
  R7 (432 of 432 arcs of kind both, radius 1), the strip of row 136 (16 of 16 vertical edge-sides, 26 of 26 arcs of kind both, radius 1). [tools exact,
  one mind] §1.3, `tools/fs111_vm2_intrad.py`
- **VM2-STRIP-MID** — the strip of row 136 is **not saturated** on its midline: at the midpoint of every edge `A_j | B_j` both side colours are free (no
  tile of either colour at distance exactly 1). [tools exact, one mind] §1.3
- **VM2-DISC7** — DISC7 rebuilt from its formula: constant width 1 (identically), strictly convex with radius of curvature in `[37/100, 63/100]` (both
  attained), non-circular, passes through every hexagon vertex (so covers the plane), same-colour bodies more than 1 apart, every point within `≤ 1`
  of every colour (so a **maximal** admissible seven-cover), neighbouring bodies overlap in lenses, every centre exclusive, self-parallel
  (`x(t + π) = x(t) − u(t)`), curvature in `[100/63, 100/37]`. [hand + tools exact (sympy), one mind; four plants, each firing for its own reason] §1.3
- **VM2-SEL** — in a saturated colouring, if `A ⊇ S_j` a.e. has null unit pairs, no point of `∂_e S_j` lies in `int Ã`; so `S_j` is null or full on each
  component of `int Ã`. With a regular maximal cover whose every component has an exclusive point, a saturated selection forces the cover to be a
  partition; DISC7 has none. [hand, one mind; over Federer 4.5.11] §1.6
- **VM2-HULLC** — in a maximal cover with `A_j = F_j` a.e., every component of `int F_j` lies inside or outside every unit circle centred at a point of
  `F_j`, and has an exterior ball of radius **1** at every boundary point. [hand, one mind] §1.7

## Would-have-searched-here log (standing rule 3)

- Stage 1: would have searched for a regular maximal five-cover numerically (the hypothesis of M2-REDUCE-C) → did not; derived that its conditional form
  is equivalent to `χ_m⁰(ℝ²) ≥ 6` given FS106-AE-MAP6 (VM2-EQ5), which says what finding one would mean.
- Stage 1: would have Monte-Carlo-sampled DISC7's properness and coverage → exact bounds from the support function's Fourier coefficients (rationals),
  every check by formula (`tools/fs111_vm2_disc7.py`).
- Stage 1: would have searched for a saturated colouring with an interface of non-integer radius (to refute M2-INTRAD) → derived the parallel lemma and
  the radius chain instead, and checked the four controls exactly.
- Stage 2: would have searched numerically for the uncovered region of DISCK7 at M2's orientation → located it by formula (the tiling vertex in the
  directions `π/2 + (0, 2π/3, 4π/3)`, `h = 99/200` in all three) and checked it exactly.

## Fence log (standing rule 13)

- Start-up: `git log --oneline -5` printed one commit beyond the start-up snapshot, `6281937e` ("FS-114: the bowtie exclusion at root 3 verified;
  FS-111's round-2 verifier launched"): the subject only, nothing opened.
- `ls data/fs111/` printed the **name** `fs111-m2` (fenced until stage 1); not opened, not listed. `ls tools/` was filtered to `fs111_vmw|fs112_y` and
  showed no `fs111_m2_*` name.
- Opened before stage 1's commit: the brief, the standing rules, `CLAUDE.md` (§ The aim, § Counter-priors, G82, G21, G24 on disk), `data/fs111/claims.md`,
  `data/fs106/claims.md` §0, §1, §3–§5 and its corrections, `plans/FS106-derivation.md` ll. 40–130, `plans/FS106-V-verification.md` V3 stage 1 (the
  record AE-MAP6 points to), `plans/FS106-TS-derivation.md` l. 240 (row C-AE-MAP6), `plans/FS111-M-regularity.md` in full, `plans/FS111-W-wild.md`
  stage 2, `plans/FS111-VMW-verification.md` in full, `plans/FS111-V0-verification.md` §2.1, §2.8–§2.10, `plans/CONSOLIDATION-2026-09-27.md` l. 75, and
  `tools/fs112_y_check.py` (imported, not edited). No transcript, `chats-bak/` file, foreign scratchpad file, `plans/FS111-close-inventory.md`, other
  brief or FS-114 file was opened.
- Stage 1 committed and pushed at `00fd646f`. Stage 2 then opened: `plans/FS111-M2-regularity.md` in full; `tools/fs111_m2_disck7.py` and
  `data/fs111/fs111-m2/disck7.out`; the listing of `data/fs111/fs111-m2/` and of `data/fs111/reports/`, and `data/fs111/reports/FS111-M2.md`. Not opened:
  `tools/fs111_m2_covers.py`, `covers.out` (their results are quoted from M2 §2.4), and everything fenced always.

## Stage 1 — SAVED: quotation check, blind verdicts on items 1–6, exact tools

### 1.1 Quotation check (standing rule 5)

Checked by exact substring search on whitespace-joined text.

| quotation | source | result |
|---|---|---|
| the six statements in the brief | `plans/FS111-M2-regularity.md` (fenced) | **deferred to stage 2** (the source is fenced until this stage is committed) |
| "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim |
| "A proven theorem about why its impossible is also valid. All novel knowledge is a success" | `CLAUDE.md` § Where the problem stands, item 23 | verbatim |
| "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | `CLAUDE.md` § Toolchain | verbatim |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |
| "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress." | `plans/CONSOLIDATION-2026-09-27.md` item 20 | verbatim |
| FS106-AE-MAP6, "No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper, modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5" | `plans/FS106-derivation.md` l. 121 | verbatim (a prefix) |

### 1.2 Readings fixed before any check

- **Cover, maximal, `F_j`:** round 1's M-SATC: an admissible cover is `(A_1, …, A_k)` measurable, covering a.e., each with `Leb ⊗ σ`-null unit pairs;
  maximal under a.e. inclusion; `F_j = supp A_j`.
- **Regular class (R-REG):** `A_j = F_j` up to a null set and `∂F_j` a locally finite union of Jordan arcs of zero area (then `F_j = cl int F_j`, since
  `F_j = supp A_j`). Where a verdict needs less or more, it says so.
  (The weaker, purely topological reading — `F_j = cl int F_j` with such a boundary, `A_j` merely of support `F_j` — is noted at §1.4 (O2).)
- **REG-J′-C_k:** read in its conditional form, like REG-J′_k: *if a tight a.e.-proper `k`-colouring exists, some maximal `k`-cover has regular
  classes whose boundaries form a locally finite plane graph* (the unconditional form is FALSE at `k = 5` given FS106-AE-MAP6, by VM2-FACE).
- **Cover form of REG-A** (item 5): the universal form, *every regular maximal `k`-cover with a locally finite arrangement has segment-and-arc
  boundaries*; its existence form is TRUE at seven (R7 is a regular maximal cover, VMW-R7-COVER) and cannot be what item 5 refutes.
- **"interface point"** (item 4): a point of `∂_e S_j` for the class being enlarged; the broader reading (any interface point) is checked too.
- **LRA** (items 2–3): a point at which interface pieces of unbounded radius (and segments between them) accumulate; ¬LRA excludes it.

### 1.3 The tools (exact; plants beside faithful twins)

- **`tools/fs111_vm2_disc7.py`** — DISC7 by formula, `h(t) = 1/2 + sin³(3t)/200` at the centres of hex7 (circumradius `1/2`, vertices in directions
  `kπ/3`), colour `(m + 5n) mod 7` (kernel spanned by `(2, 1)`, `(−1, 3)`). Output `data/fs111/fs111-vm2/disc7.out`: **ALL PASS** —
  - W: `h(t) + h(t + π) − 1 ≡ 0`; CV: `ρ = h + h″ = 1/2 − (3/100) sin 3t + (1/10) sin 9t ≥ 37/100` (exact from the Fourier coefficients; the float guard
    reads `min ρ = 0.37`, `max ρ = 0.63`, both attained where `sin 3t = ∓1`); NC; VX: `h(kπ/3) = 1/2`, `h′(kπ/3) = 0`, so every hexagon vertex is the
    boundary point `(1/2)u(kπ/3)` and the hexagon lies in `K` (the bodies cover the plane); `99/200 ≤ h ≤ 101/200`;
  - SEP: same-colour centres `√21/2` apart, `21/4 > (201/100)²`; MAX: covering radius² `7/4 ≤ (299/200)²`, so every point is within `≤ 1` of every
    colour, and (constant width: `maxdist ≥ dist + 1`) at distance exactly 1 from it — adding any positive-measure set outside `F_j` creates non-null unit
    pairs, so the cover is **maximal**; LNS: `min h > √3/4` (lenses around every edge); EXC: `3/4 > (101/200)²` (each centre exclusive); FAR: second
    neighbours `3/2 > 101/100` apart; PAR: `x(t + π) − (x(t) − u(t)) ≡ 0` (the unit parallel of `∂K` is `∂K`); KAP: curvature in `[100/63, 100/37]`;
  - FACE: at a hexagon vertex the three tangent lines are distinct, the six sectors read `{2,3}, {2}, {1,2}, {1}, {1,3}, {3}`, and for all 8 lens
    choices the merged face colouring keeps exactly 3 boundaries at the vertex.
  - Plants (`disc7_plants.out`): `amp` (amplitude 1/40) → CV and KAP fail (`ρ ≥ −3/20`, guard `min ρ = −0.15`); `rot` (`cos³`) → VX fails, and the
    tiling vertex seen in directions `π/3 + (0, 2π/3, 4π/3)` has `h = 99/200` in all three: **uncovered**; `width` (`sin²`) → W and PAR fail; `lat4` (cosets
    of `2L`) → SEP fails (`d_c² = 3`).
- **`tools/fs111_vm2_intrad.py`** — M2-INTRAD's conclusions on the controls, edge by edge (FS112-Y's field tower imported, not edited). Output
  `data/fs111/fs111-vm2/intrad.out`: SQ9 48/48 edge-sides carry the ladder (the unit parallel covered by edges, the partner colour beyond, another
  colour before); HEX9 76/76; R7 432/432 arcs of kind both (centre in the closures of both side colours), radius 1; the strip 16/16 vertical edge-sides
  with the ladder, 26/26 arcs of kind both, radius 1, and **its 6 midline edge-sides (`A_j | B_j`) without a ladder, each at a point unsaturated for
  that colour** (exact point test: no tile of the colour at distance exactly 1) — VM2-STRIP-MID; INTRAD is silent there (its hypothesis fails). No edge
  fails at a saturated point.
  - Plants (`intrad_plants.out`): `sq16` → 0/48 ladders, all midpoints unsaturated; `hex16` → 0/76; `r8` → 0/432 kind both; `swap` (FS112-Y's plant, an
    improper strip) → 5 arcs not of kind both, and two ladders missing at points whose "contacts" are the plant's own improper pairs (B0–C1, B2–C2).

### 1.4 Item 1 — M2-REDUCE-C: **TRUE under R-REG** (with one step the statement leaves implicit), over FS106-AE-MAP6's grade; the reduction is an equivalence (VM2-EQ5) [derived, one mind]

**VM2-INT.** If `p, q ∈ int F_j`, `|p − q| = 1`, then `B(p, r), B(q, r) ⊆ F_j` for small `r`, `A_j` has full measure in both (R-REG), and the unit pairs
between two full discs of radius `r` at distance 1 have `Leb ⊗ σ` measure `≍ r³ > 0` — against admissibility. ∎

**VM2-FACE**, step by step (`G = ⋃_j ∂F_j`, a locally finite plane graph; faces = components of `ℝ² ∖ G`):
1. `⋃_j F_j = ℝ²` (a closed set containing almost every point).
2. A face `Φ` meets no `∂F_j`, so for each `j` it lies in `int F_j` or in `ℝ² ∖ F_j`; by 1, in `int F_j` for at least one `j`. Colour `Φ` by such a `j`
   (the free choice: overlaps give several).
3. Every edge `e` of `G` lies in some `∂F_i` with `int F_i` on one side and `ℝ² ∖ F_i` on the other (no `∂F_i` has a dangling arc or an isolated point,
   since `F_i = cl int F_i`), so the two faces at `e` differ: no bridges.
4. Erase every edge whose two faces share a colour. Around a vertex the cyclic colour sequence changes colour 0 or ≥ 2 times, so no vertex is left with
   degree 1; erase degree-2 vertices into their boundaries. An erased edge `e` between two faces of colour `j` is not in `∂F_j` (else one side is outside
   `F_j`), and its relative interior misses `∂F_j` (edges of a plane graph meet only at vertices), so it lies in `int F_j`; so does an erased vertex all of
   whose faces have colour `j`. **Every region point of colour `j` lies in `int F_j`.**
5. A boundary component that is a closed curve with no vertex left bounds an island: recolour it with its surrounding colour — V0-CLEAN's island fill
   (Townsend's simplification (a)), which keeps D-AEMAP. **This step is not in M2-REDUCE-C's statement and is needed** for S–V Condition 2
   ("Boundaries are Jordan curves terminating at vertices … Every vertex is an endpoint of at least three boundaries").
6. By VM2-INT and V0-CLOSE, no two region points of one colour are at distance 1 (D-AEMAP); regions are connected, open and unit-free, so of diameter
   `≤ 1`; boundaries are bounded finite unions of edges; Condition 3 from local finiteness; colours `≤ k`. ∎

So REG-J′-C_k ⟹ REG-I_k (whose own hypothesis, tightness, is not used). At `k = 5`: if `χ_m⁰(ℝ²) ≤ 5`, V0-RESCALE gives a tight a.e.-proper
five-colouring, REG-J′-C₅ a regular maximal five-cover, VM2-FACE an a.e.-proper map-type five-colouring, against FS106-AE-MAP6. Hence `χ_m⁰(ℝ²) ≥ 6`,
and given MR (row 130) `χ(ℝ²) ≥ 6`. The colour count is used only at FS106-AE-MAP6, and no honest saturation is used — as stated. **The step to check
hardest, answered:** the face colouring of a maximal cover's arrangement *is* in FS106-AE-MAP6's class once equal-coloured faces are merged and
islands filled (steps 4–5); the overlaps of a cover cost nothing, because a face is coloured only by a class whose interior contains it, and the merged
points stay interior to that class (step 4). FS106-AE-MAP6's hypotheses are Conditions 2–4, D-AEMAP and five colours — all met; its own residuals
(Townsend's (c) filled by Woodall's steps 2, 3, 5; the vertex-existence step V3 noted) are inherited unchanged.

*Inhabitants at `k = 7`:* DISC7 (FACE: the merged map is a curved hexagonal map, every vertex of degree 3, for every lens choice) and R7 (a regular maximal
partition, VMW-R7-COVER; its face colouring is R7 itself).

**Observations the owner should weigh** (none is a defect of the statement):
- **(O1) VM2-EQ5: the reduction is an equivalence.** Given FS106-AE-MAP6, REG-J′-C₅ (conditional form) ⟹ `χ_m⁰ ≥ 6`, and `χ_m⁰ ≥ 6` ⟹ REG-J′-C₅
  vacuously. So "`χ(ℝ²) ≥ 6` given MR is one regularity statement away" is literally true, and that statement is `χ_m⁰(ℝ²) ≥ 6` itself in regularity
  clothing — C-REG-EQ's caution ("REG's top rung at `k` is not a smaller statement than the answer at `k`") applies to it word for word. What the
  reduction buys is a *form*: the colouring may be replaced by a maximal cover (Zorn, M-SATC) before any regularity is asked, and no honest saturation
  is needed. It does not make the five-colour question smaller.
- **(O2) Under the purely topological reading of "regular"** (`F_j = cl int F_j` with a locally finite boundary graph, `A_j` merely of support `F_j`),
  step 6 needs "`int F_j` contains no unit pair", i.e. `A_j ⊇ int F_j` a.e.; by maximality this is equivalent to the same statement, and I have not
  proved that the interior of the support of a set with null unit pairs is unit-free. **GAP at that step under that reading** (not a counterexample: I
  know none). Under R-REG it is VM2-INT.
- **(O3)** The island fill (step 5) should be named in the statement or its proof.

### 1.5 Item 2 — M2-INTRAD: **TRUE** [hand, one mind]; the controls agree exactly (VM2-LAD-CTL)

*Setting:* an honest saturated colouring with REG-J′ (Σ locally finite, finitely many interface arcs at each of its points); off Σ, (H1), (H2) hold and
M-PINCH/M-C11 apply (round 1; two to three minds on the common form, VMW D2).

**VM2-PAR.** Let `x` be a (tangent) point of an interface `Γ` between `a` (side `−n_b`) and `b`, with `P_a` the connected `a`-piece near `x`. M-PINCH's
(tangent) case makes the two contacts exactly `y_a = x + n_b(x)` and `y_b = x − n_b(x)` (any other `a`-contact would give a second disc tangent at `x`).
(i) Every point of the parallel `Γ₁ = {x′ + n_b(x′)}` near `y_a` is an `a`-contact, so lies in `supp S_a`. (ii) A point `z` on the near side of `Γ₁`
(between `Γ` and `Γ₁`, close to `y_a`) has points of `P_a` at distance `< 1` (near `x`) and `> 1` (deep in `a`, e.g. `x − t n_b`), so M-HULL1 forbids
`z ∈ A*_a`: **`a` has density 0 on the near side.** (iii) At a point of `Γ₁` off Σ (all but finitely many), (H1), (H2) hold with `a` and some `c`; the
near side is `c`, `Γ₁ ⊆ ∂` of the `a`-piece, and M-C11 makes that boundary one `C^{1,1}` curve, so it is `Γ₁`. **`Γ₁` is an interface (`a` beyond,
`c ≠ a` before).** The same on the other side with `b`. ∎ (Straight `Γ`: W-LADDER.)

**VM2-RAD.** At an a.e. point of `Γ` with radius of curvature `ρ` (M-C11: `ρ ≥ 1`), the parallel on the concave side has radius `ρ − 1` at the
corresponding point (plane parallel curves), and it is an interface (VM2-PAR), so again `ρ − 1 ≥ 1` a.e. or the parallel is a unit arc's degenerate
inner parallel. Iterating (each step maps positive arc length to positive arc length while `ρ − k > 0`), `ρ − ⌊ρ⌋ ∈ (0, 1)` on a set of positive length
would put curvature `> 1` on an interface at a positive-length set off Σ: excluded. So `ρ ∈ ℤ_{≥ 1} ∪ {∞}` a.e., and the chain of an arc of radius `R`
ends, after `R − 1` steps, at a unit arc about the arc's centre `O` — (split), or (tangent) with its inner contacts all at `O`. **`O ∈ Σ`:** the colour
whose contacts sit at `O` has its piece at `O` inside the polar cone of the arc's directions, a cone of angle `< π` for an arc of positive
length (M-HULL2 between the colour's piece at `O` and its pieces along the arc, all cross distances on one side of 1 — M-POLAR's argument); so `O`
is a corner (W-NOBEND: no two-colour corner off Σ), a cusp or a point of three colours. ∎

**VM2-FIN.** Arcs of radius `≤ R` near a bounded set `B` have centres in `Σ ∩ (B + B̄(0, R))`, a finite set, so they lie on finitely many circles;
segments tangent-join them. A `C¹` switch between two such circles, or between a circle and a segment, happens only at a common tangency point — finitely
many; an embedded interface arc uses each piece between them at most once. So off Σ each interface is locally a finite chain of segments and arcs of
radius `≤ R` (a segment adjacent to an arc is tangent to its circle at the switch; two segments meeting `C¹` are one segment), and only radii tending to
`∞` (with segments between) can accumulate — LRA, as the claim says it does not exclude. ∎

*Controls* (§1.3): SQ9, HEX9 — every edge of type (tangent) with the ladder on both sides; R7 — every arc (split), radius 1, so the parallel clause is
vacuous at `k = 7` there; the strip — its vertical edges carry ladders, its arcs are of kind both and radius 1, and its midline is not saturated
(VM2-STRIP-MID), so the strip is a fragment on which INTRAD is tested only off the midline. No control has an arc of radius `≥ 2`: INTRAD's content
beyond radius 1 is uninhabited among the objects held (an honest statement of what the controls can see, G21).

### 1.6 Item 3 — M2-REDUCE-A: **TRUE** [derived, one mind], over M-REDUCE-I and VM2-PAR/RAD/FIN; the same equivalence caution as (O1)

REG-J′_k already asserts that a saturated colouring exists, so "honest C-SAT-T_k ∧" is implied (harmless). With it, M-REDUCE-I (two minds, VMW D4) makes
the saturated colouring a map-type colouring whose boundaries are its interface arcs; VM2-FIN with ¬LRA makes each bounded boundary a finite union of
segments and circular arcs (integer radii, unit arcs allowed): a segment-and-arc map, a.e.-proper — REG-A_k. At six, C-SEVEN-M (with V0-RESCALE) and
Q-NO give `χ_m⁰(ℝ²) ≥ 7`; Q-NO includes FS-114's NO, which is open, and the map produced needs exactly that half (its arcs may have radius 1). Given
Q-NO, REG-A₆ ⟺ `χ_m⁰ ≥ 7` (C-REG-EQ), so "honest saturation ∧ REG-J′₆ ∧ ¬LRA" is implied by seven vacuously and implies it with Q-NO.

### 1.7 Item 4 — M2-SELCOMP: **TRUE** with "interface point" read as a point of `∂_e S_j` (the broader reading FALSE, trivially); M2-NOSEL **TRUE** [hand, one mind]

**VM2-SEL.** Let `g` be saturated, `A ⊇ S_j` a.e. with null unit pairs, `x ∈ ∂_e S_j ∩ int Ã`. Saturation gives `y ∈ cl S̃_j`, `|x − y| = 1`; `A` has full
measure in `B(x, r)` and `S_j ⊆ A` has positive measure near `y`, so the unit pairs of `A` between `B(x, r)` and a neighbourhood of `y` are non-null —
against admissibility. On a component `W` of `int Ã`, if `0 < |S_j ∩ W| < |W|` the measure-theoretic boundary of `S_j` in `W` is non-empty (Federer 4.5.11:
positive `H¹` measure), and its points are in `∂_e S_j ∩ W`: impossible. So `S_j` is null or full on `W`. With `A = A_j` of a regular maximal cover
(`int Ã_j = int F_j`), a saturated selection takes whole components; a component with an exclusive point must be taken; if every component has one,
all are taken and the cover must be a partition. A regular maximal **partition** is saturated: an essential boundary point `x` of `S_j = A_j` is not in
`int F_j`, so M-SATC (ii) gives a contact in `F_j = cl S̃_j`. ∎ *Broader reading:* SQ9 used as a ten-colouring (colour 10 unused, `S₁₀ = ∅`) is saturated,
and a small disc about an interface point of two other colours is a unit-avoiding enlargement of `S₁₀` with that point in its interior — FALSE, but only
by this degenerate example; the class reading is the one the rest of the claim uses.

**M2-NOSEL.** DISC7's classes are regular (closed bodies, `A_j = F_j`), the components of `int F_j` are the open bodies, and each has an exclusive point
(EXC: its centre), so a saturated selection would take every body whole and colour each lens twice. None exists. ∎ [hand + tools exact, one mind]

### 1.8 Item 5 — M2-DISCK7: **TRUE** as rebuilt (VM2-DISC7) [hand + tools exact, one mind]; "the cover form of REG-A is FALSE at seven" TRUE of the universal form only

Every property the claim names is checked by formula (§1.3). The body is smooth (a trigonometric polynomial support), non-circular, of constant width 1;
its translates at hex7's centres, coloured by the index-7 lattice, are a **regular maximal seven-cover**; the arrangement is locally finite (only first
neighbours meet, each pair of translates of a strictly convex curve crossing at most twice — here exactly at the two shared hexagon vertices; every
vertex of degree 6). Its class boundaries are non-circular: the **universal** cover form of REG-A fails at seven, while the existence form holds there
(R7). **Self-parallel** is exact (PAR), so on the cover route (VM2-FACE) the maps a NO at six must exclude include boundaries that are their own unit
parallels and are not arcs (NO-PAR) — a correct reading of what DISC7 shows.

### 1.9 Item 6 — M2-HULLC: **TRUE**, with two corrections; one clause elided in the brief, not checked [hand, one mind]

- *Inside or outside each unit circle centred in the class:* for `y ∈ F_j` with `d̄_j(y) > 0`, M-HULL1 (under R-REG a component `C` of `int F_j` lies in
  `S̃_j`); for `y` of density 0 (a cusp), through density points `q_n → y`: `C ⊆ B̄(y, 1)` or `C ∩ B(y, 1) = ∅`, strict because `C` is open. TRUE.
- *Exterior ball:* at `x ∈ ∂C` (not in `int F_j`), M-SATC (ii) gives `y ∈ F_j`, `|x − y| = 1`; if `C ∩ B̄(y, 1) = ∅`, `B(y, 1)` is an exterior ball; if
  `C ⊆ B(y, 1)`, every ball tangent at `x` outside `B̄(y, 1)` is. **Radius 1 holds per component** (the claim's `1/2` is true and not sharp). VM2-HULLC.
- *Semiconcave with constant 1 where the boundary is a graph:* M-COVER-SC (round 1), as stated.
- *Finite perimeter:* `∂C` lies in the boundary of the union of the exterior unit balls, an open parallel set of radius 1, whose boundary has locally
  finite length (the classical parallel-set fact); `C` is bounded (diameter `≤ 1`). TRUE over that fact.
- *Pinch set:* where only two classes are present and they do not overlap, the cover is locally an honest two-colouring saturated on both sides
  (M-SATC), and M-PINCH/M-C11's proofs apply verbatim. TRUE under that reading of "pinch set" (M2's definition is read at stage 2).
- *"Semiconvexity FAILS on covers (DISC7: curvature 2)":* the failure is TRUE — **but DISC7's curvature is not 2**: it ranges exactly over
  `[100/63, 100/37] ≈ [1.587, 2.703]` (KAP; attained), never `≤ 1`. "Curvature 2" is the unperturbed disc's.
- *"near any point the class is carved by the unit circles about its own points …"* — elided in the brief; not checked until the full text is read.

### 1.10 Verdict table (blind)

| item | claim | verdict | grade, minds |
|---|---|---|---|
| 1 | M2-REDUCE-C | **TRUE under R-REG** (island fill needed, O3); GAP at "`int F_j` unit-free" under the topological reading (O2); an equivalence given AE-MAP6 (O1) | [derived], one mind; over FS106-AE-MAP6 |
| 2 | M2-INTRAD | **TRUE** (VM2-PAR, RAD, FIN); controls exact | [hand + tools exact], one mind |
| 3 | M2-REDUCE-A | **TRUE** (C-SAT-T conjunct redundant); equivalence caution | [derived], one mind |
| 4 | M2-SELCOMP | **TRUE** (class reading); the broad reading FALSE by a degenerate example | [hand], one mind; over Federer 4.5.11 |
| 4 | M2-NOSEL | **TRUE** | [hand + exact], one mind |
| 5 | M2-DISCK7 | **TRUE** (universal cover form of REG-A refuted at seven) | [hand + tools exact], one mind |
| 6 | M2-HULLC | **TRUE**, corrections: exterior radius 1 per component; DISC7's curvature `[100/63, 100/37]`, not 2; one clause unchecked | [hand + exact], one mind |

## Stage 1 — SAVED

## Stage 2 — SAVED: reconciliation with M2 (`plans/FS111-M2-regularity.md`), read only after `00fd646f`

### 2.1 The deferred quotations (standing rule 5)

All seven quoted statements of the brief (items 1–6, with M2-NOSEL) are **verbatim** in M2's "Theorems this phase proved" (exact substring check on
whitespace-joined text; item 6's "…" elides "(near components through their open spindle hulls, far ones through their unit neighbourhoods), so its
boundary lies on unit parallels (outer and far) of its own components"; M2-NOSEL's quotation is a prefix — the line continues ": selecting from a given
maximal cover is not a colour-generic route to honest saturation").

### 2.2 My readings against M2's definitions

- **"Regular"** — M2 §1.5: `|F ∖ A| = 0` and `|∂F| = 0` (MUA-REG). That is my R-REG (§1.2). My (O2) is M2's own caution: "M2-FIX needs `int F ⊆ Ã`. For a
  general MUA set this is not proved", with a one-dimensional example of a maximal set whose support has holes. **Agreement; two minds** (M2-INT and
  M2-FIX; VM2-INT). M2-INT is the stronger form (no point of `int Ã` at distance 1 from `cl Ã`).
- **REG-J′-C_k** — conditional, as I read it (§1.2). M2 §2.3 states my (O1) itself: "At `k = 5`, given FS106-AE-MAP6 and stage 3's M2-REDUCE-C, it is
  equivalent to `χ_m⁰(ℝ²) ≥ 6` … so it is not a smaller statement", and §3.2 "M2-REDUCE-C moves no value". **Agreement; two minds on VM2-EQ5.**
- **DISC7 is not DISCK7.** DISC7 (M2 §1.6) is the cover by the **circumscribed discs** of hex7's hexagons (radius `1/2`); DISCK7 (M2 §4.2) is the cover by
  the constant-width bodies. I read the brief's "DISC7" in items 4 and 6 as DISCK7's cover — **my error** (D2 below).

### 2.3 Divergences, with addresses

| # | claim | M2 | VM2 (blind, stage 1) | kind | settled |
|---|---|---|---|---|---|
| **D1** | M2-DISCK7 | K at "hex7's colour-`a` centres (§1.6)", §1.6's lattice `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)`; its tool checks "the regular hexagon of circumradius `1/2` (vertices at angles `60k` degrees)" | rebuilt with the hexagon vertices at `kπ/3` (neighbour centres at `30° + 60k`) — TRUE | **truth (of the object as the record specifies it)** | **§1.6's lattice has hexagon vertices at `30° + 60k`**, where `h(90°) = h(210°) = h(330°) = 99/200 < 1/2`: the tiling vertex `c + (0, 1/2)` is outside all three adjacent copies, and every other centre is `≥ 1` from it, so a neighbourhood of every such vertex is uncovered — **not a cover, hence not a maximal cover** (VM2-DISCK7-ORIENT, exact, `disck7_m2orient.out`; it is my stage-1 plant `rot`). M2's tool checked the other orientation, so its PASS was about a different object than the record specifies (a tool–record mismatch, G21's generator-image rule). **Corrected statement:** "… at hex7's colour lattice, oriented so that the hexagons' vertices lie in the directions where `sin 3θ = 0` (equivalently, support `1/2 + cos³(3θ)/200` at §1.6's lattice) …" — **TRUE** [hand + tools exact, two minds: M2's hand argument and body checks, VM2's exact rebuild]. Every consequence M2 draws (REG-J′-C₇ inhabited with non-circular boundaries; the universal cover form of REG-A FALSE at seven; NO-PAR; no saturated selection) holds for the corrected object |
| **D2** | M2-HULLC's "(DISC7: curvature 2)"; M2-NOSEL | DISC7 = circumscribed discs | read DISC7 as DISCK7; "curvature is not 2 but `[100/63, 100/37]`" | reading (mine) | **Mine withdrawn:** DISC7's class boundaries are circles of radius `1/2`, curvature exactly 2 (exact, `disc7_discs.out`); `[100/63, 100/37]` is DISCK7's range. M2-NOSEL holds for both covers (every centre exclusive in each). M2's DISC7 check was a 2,173-point exact grid (a sample, the proof by hand, M2 §2.4); `tools/fs111_vm2_disc7.py --object disc7` decides every point by rational bounds (VM2-DISC7-EXACT): **the grade of M2-DISC7 rises to [hand + tools exact], two minds** |
| **D3** | REG-J′-C_k (the hypothesis of M2-REDUCE-C) | §2.3 defines MUA-FIN as "`⋃_j ∂F_j` is, in every bounded set, a finite union of Jordan arcs"; §3.2 and the theorem line say "finitely many Jordan arcs meeting only at endpoints" / "a locally finite plane graph" | read the theorem line (plane graph) | **statement** | M2-REDUCE-C is proved (and TRUE, §1.4) with the plane-graph clause. §2.3's MUA-FIN omits "meeting only at endpoints": two classes' boundaries may then meet in infinitely many points (a Cantor set), the arrangement may have infinitely many faces in a bounded set, and the face colouring can fail Condition 3 (the least-index colouring M2 uses makes the colour-2 regions the components of `int F_2 ∖ F_1`). So **§3.3's route summary "some maximal five-cover satisfies MUA-REG and MUA-FIN" is MISSTATED**; add "meeting only at endpoints" to MUA-FIN. No counterexample is known; the clause is what the proof uses |
| **D4** | M2-REDUCE-C, proof step (2) | checks D-AEMAP on faces; step (3) then erases edges and degree-2 vertices | VM2-FACE step 4: an erased edge between two faces of colour `j` lies in `int F_j`, and so does an erased vertex | exposition | The erased edges and vertices become region points after step (3); M2 does not say they lie in `int F_j`. They do (VM2-FACE step 4), so D-AEMAP holds on the merged regions. **M2-REDUCE-C TRUE, two minds** (M2; VM2 blind), over FS106-AE-MAP6's grade |
| **D5** | M2-REDUCE-C, the island fill | step (3), "as V0-CLEAN" | (O3): not in the statement, needed | none | M2's proof contains it. Agreement |
| **D6** | M2-INTRAD (iii), "finitely many of each radius locally" | step (3): `f = |γ − p|² − n²`, "`f″ = 2(1 − nκ(1 + o(1)))` … `f″ < 0` only on `⋃_{k<n} E_k`", then convexity between points of `E_{n,p}` | VM2-FIN: switch points are tangency points of finitely many circles and lines | **proof, both** | **Mine is flawed** (a segment leaves a circle tangentially at any of its points) — withdrawn. **M2's is an outline with a gap:** exactly, `f″ = 2(1 − κ·⟨p − γ, n⟩)`, and on `E_n ∖ E_{n,p}` (radius `n` about another centre `p′`) `f″ = −2⟨p − p′, n⟩/n` has either sign, so "`f″ < 0` only on `⋃_{k<n} E_k`" omits those pieces, and the `o(1)` is not uniform. **The conclusion is TRUE by VM2-FIN′** (the `n`-th parallel, on the side of the centre the gap starts from, carries each gap to an interface curve starting at one of finitely many centres in Σ; REG-J′'s "finitely many interface arcs at each point of Σ" allows only finitely many gaps). (i)–(ii): **agree, two minds, different routes for step (1)** (M2: `J⁺ ⊆ cl P_a ∖ P_a` from I-D1 and (H2); VM2: the near side of `J⁺` has `a`-density 0 by M-HULL1). Statement TRUE; grade [hand], two minds on (i)–(ii), one complete argument for (iii) |
| **D7** | M2-REDUCE-A | "REG-A_k ⟸ honest C-SAT-T_k ∧ REG-J′_k ∧ ¬LRA" | TRUE; the C-SAT-T conjunct is implied by REG-J′_k | none (redundancy) | TRUE, two minds, over M2-INTRAD (with D6's repair of (iii)) and M-REDUCE-I |
| **D8** | M2-SELCOMP | the proof states `∂_e S_a ∩ int Ã = ∅` | TRUE with "interface point" = point of `∂_e S_j` of the enlarged class; the broader wording FALSE by a degenerate example | statement (wording) | The theorem line's "no interface point lies in `int Ã`" should read "no interface point **of the class**". TRUE, two minds (M2 via M2-INT; VM2 by the same contact argument), over Federer 4.5.11 |
| **D9** | M2-HULLC | the elided clause "so its boundary lies on unit parallels (outer and far) of its own components"; §2.1 (iv) derives it only "If `F_x` has finitely many components `K_1, …, K_m`" | not checked (elided in the brief) | **statement** | The carving "`int F ∩ B(x, r) = B(x, r) ∖ ⋃_{p ∈ F_x} T₁(p)`" is unconditional (F3); the unit-parallel description needs `F_x` to have finitely many components — **the theorem line drops that hypothesis** (MISSTATED; corrected by restoring it). "Radius `1/2`" is TRUE and not sharp (radius 1 per component, VM2-HULLC; M2 uses `1/2` for (iii)'s parallel-set argument). "Curvature 2": right (D2). Otherwise TRUE, two minds |
| **D10** | M2-DISC7's maximality | "for `1/2 < |z − c| < 3/2` the circle `T₁(z)` crosses the disc" | the same by the constant-width bound `maxdist ≥ dist + 1` | none | Agreement |

### 2.4 Corrections to my stage 1 (made here, not in §1)

- §1.9, "DISC7's curvature is not 2": **withdrawn** (D2). DISCK7's curvature is `[100/63, 100/37]`; DISC7's is 2.
- §1.8 and VM2-DISC7: my rebuild is of the **corrected** orientation; M2's record places K differently (D1). The stage-1 verdict "M2-DISCK7 TRUE as
  rebuilt" stands for my object; for the object as M2 §1.6 + §4.2 specify it, **not a cover** (VM2-DISCK7-ORIENT).
- §1.5 VM2-FIN: its proof **withdrawn** (D6); VM2-FIN′ replaces it.
- §1.7 M2-NOSEL: stands for DISC7 (discs) and for DISCK7 (corrected orientation).

### 2.5 Final verdicts

| item | claim | verdict | grade, minds |
|---|---|---|---|
| 1 | M2-REDUCE-C | **TRUE** (theorem line's plane-graph hypothesis; merged points in `int F_j`, D4; island fill); an equivalence at five given AE-MAP6 (both minds say so); §3.3's summary with §2.3's MUA-FIN MISSTATED (D3) | [derived], two minds (M2; VM2 blind), over FS106-AE-MAP6 |
| 2 | M2-INTRAD | **TRUE**; (iii)'s proof repaired (VM2-FIN′) | [hand], two minds on (i)–(ii), one complete argument for (iii) |
| 3 | M2-REDUCE-A | **TRUE** | [derived], two minds |
| 4 | M2-SELCOMP | **TRUE** with "interface point of the class" (D8) | [hand], two minds; over Federer 4.5.11 |
| 4 | M2-NOSEL | **TRUE** (DISC7; also DISCK7 corrected) | [hand + tools exact], two minds |
| 5 | M2-DISCK7 | **MISSTATED**: FALSE for the object as the record places it (not a cover, VM2-DISCK7-ORIENT); TRUE with the orientation fixed (VM2-DISC7) | [hand + tools exact], two minds on the corrected object |
| 6 | M2-HULLC | **TRUE** with the dropped hypothesis of (iv) restored (D9); radius 1 per component | [hand], two minds; finite perimeter over a classical fact |

### 2.6 Proposed for the close (I edit none of these files)

- **M2-DISCK7's statement:** add the orientation ("hexagon vertices in the directions where `sin 3θ = 0`", or `cos³` at §1.6's lattice), and fix
  `tools/fs111_m2_disck7.py`'s HEX check to the lattice the record uses (M2's tool; not edited here). `plans/GROKKING-INSTANCES.md` §G21: *a check must
  build the object the record specifies* — M2's containment check verified a hexagon rotated 30° from §1.6's, and passed.
- **MUA-FIN** (M2 §2.3): add "meeting only at endpoints"; §3.3's route summary with it.
- **M2-HULLC's theorem line:** restore "(where `F_x` has finitely many components)" before "so its boundary lies on unit parallels".
- **M2-SELCOMP's theorem line:** "no interface point **of the class** lies in `int Ã`".
- **M2-INTRAD (iii):** replace step (3)'s convexity argument by VM2-FIN′ (or repair its sign analysis on `E_n ∖ E_{n,p}`).
- **Grades for the ledger row:** M2-REDUCE-C, M2-REDUCE-A, M2-SELCOMP, M2-NOSEL, M2-HULLC two minds; M2-INTRAD two on (i)–(ii); M2-DISC7 [hand + tools
  exact], two minds; M2-DISCK7 corrected, two minds.
- **VM2-STRIP-MID** for `LEDGER.md` row 136's note: the strip is tight but not saturated on its midline (exact).
- **The owner's framing** ("if it holds, `χ(ℝ²) ≥ 6` given MR is one regularity statement away"): literally true, and the statement (REG-J′-C₅ with
  the plane-graph clause) is equivalent to `χ_m⁰(ℝ²) ≥ 6` given AE-MAP6 — the gain is its *form* (a maximal cover, free by Zorn; no honest saturation),
  not its size. The colour-generic rung smaller than the answer is M2's MUA-FIN-P (with the clause of D3).

## Stage 2 — SAVED
