# FS107-R — competitor R of FS-107: prove stability (can vanishing holes save a colour?)

*Job FS107-R, de Bruijn (Opus 5.5), 2026-09-27. Brief: `data/fs107/briefs/R107-stability.md`, with `SHARED-107-competition.md` and
`STANDING-RULES.md`. Advisor: FS107-A2 (Poros). Object labels per lemma: **on SEQ**, **on LIM**, **on both** (`data/fs107/claims.md` § Objects).*

## Theorems this phase proved

*(filled stage by stage; one line each: statement, grade, minds, address)*

- none yet (stage 1 is set-up).

## Would-have-searched-here log (standing rule 3)

- (none yet)

## Fence log (SHARED § Fences; standing rule 13)

- **Fence touch, disclosed at once:** my first shell command (`ls -la data/fs107/briefs/ data/fs107/ data/fs107/reports/`) listed the fenced
  directory `data/fs107/reports/`. It showed one filename, `FS107-P.md` (2211 bytes, 02:25), which I did not open. The parent listing of
  `data/fs107/` also showed the directory names `fs107-a`, `fs107-p`; I did not list or open `data/fs107/fs107-a/`. Nothing about routes or content
  was seen. No other fenced path has been opened, listed or grepped.

---

## Stage 1 — SAVED: quotation check, restatements, the five killing-test objects, the advisor's question

### 1.1 Files read from disk (in this order)

`SHARED-107-competition.md`, `STANDING-RULES.md`, `R107-stability.md` (all in full); `CLAUDE.md` § The aim, § Counter-priors, G82 (from disk at
`1755adf4`; G21, G51, G71, G79 from the loaded copy, which § The aim shows is stale in places — the aim text on disk was used); `data/fs107/claims.md`
in full; `LEDGER.md` rows 129–132; `plans/FS107-stability.md` §G part 3 (X1–X19), §PA, §IQ, §5.3; `plans/FS106-TQ-derivation.md` §§3.1–3.3, §4 in
full; `plans/POROS-2026-09-27-fs106-close-and-fs107.md` §§3.2–3.3, §3.7 (A2's FS-106 record — the claim list's cited source, not fenced);
`plans/FS106-TS-derivation.md` rows C-T-BIKE, C-T-ANN, C-T-IND, C-T-PIG, C-T-KILL, C-AE-MAP6 (by grep); `[Voronov2023]` §§2–6 in full
(`~/source/library/pdf/arXiv-2304.10163-voronov.pdf`, by `pdftotext -layout`).

### 1.2 Quotation check (standing rule 5)

| quotation (where it appears) | source checked | result |
|---|---|---|
| claim R, "for some `R` and `δ₀ > 0` and every `ε > 0`, every partial six-colouring of `U_R(0)` … leaves at least `δ₀\|U_R\|` uncovered." (R brief; claims §1) | A2's record l. 439–440 | **verbatim** (A2's own "Written out:" of TQ §4.5 item 2, not a TQ quotation — the claim list attributes it correctly to A2 §3.3) |
| "The exact disc equivalent is 'for some radius `R`'" (claims §1) | TQ §4.5 item 2 | verbatim up to TQ's bold on "for some" |
| TQ §4.5 item 5, "a mechanism forcing holes of `ε`-independent total measure — … for every band `ε ≪ ρ₀`." (claims §1) | TQ §4.5 item 5; A2 l. 443 | verbatim |
| R-S's reading, "**Hadwiger–Nelson's measurable form is "Voronov's argument on regular colourings, robust to a free colour of vanishing density".**" (claims §1) | TQ l. 527 (§5.2) | present at TQ §5.2 |
| R′ (C-VOID), both forms (claims §1) | FS107-A's card and second message — **source fenced for me** (`plans/POROS-2026-09-27-fs107-stability.md`) | **not checkable; worked as the claim list states it** |
| R″, "improve TQ-EPS2's `ε²` to `ε`, where hitting-form arguments are allowed and TQ-HIT's strips show `ε` is the most they can give." (claims §1) | A2 l. 527–528 (§3.7) | verbatim |
| "The only gap on this object is the hole gap." (claims § Objects) | A2 l. 428 | verbatim (bold in the source) |
| "The direction W relies on is the easy one." (claims §1) | A2 l. 455 | verbatim |
| K-HIT's close statement, "Strips of width 2ε at spacing 2 (density ε) …" (claims §2) | not re-opened in `plans/FS106-derivation.md`; TQ §4.4 has the **original** form "strips of width `2ε` centred on the lines `y ∈ ℤ/2`. Its density is `4ε`" | both forms hold (a closed interval of length 2 contains a point of `2ℤ`, so spacing 2 also meets every unit circle); I use the close's |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (SHARED; rules 4) | `CLAUDE.md` Frontier item 23 | verbatim |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." (SHARED; rules 3) | `CLAUDE.md` § Publication | verbatim |
| Kooshi, counter-priors: "From here on out, you may doubt … you will surprise yourself." (rules 0) | `CLAUDE.md` § Counter-priors (disk) | verbatim |
| "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" (rules 3) | `CLAUDE.md` § Toolchain | verbatim |

No paraphrase found that empties a claim. One attribution note: claim R's text is A2's written-out form, and TQ's item 2 quotes only "for some radius R".

### 1.3 The statements I work, restated in my own words beside the quotations

- **R (claim R, C-Q-STAB in disc form), quoted above.** *Mine:* there is one fixed disc size `R` and one fixed fraction `δ₀ > 0` such that, however
  thin the forbidden band `[1 − ε, 1 + ε]` is made, six colour classes that avoid the band inside the disc can never cover more than `1 − δ₀` of the
  disc. By H-EQ (row 131) this is exactly `χ_m⁰(ℝ²) ≥ 7`; with MR, `χ(ℝ²) = 7`. **Object: both** — and I record now (§1.5) that R on SEQ and R on LIM
  are one statement, so the choice of object is a choice of *proof vocabulary*, never of *question*.
- **R′ (C-VOID), quoted in claims §1.** *Mine:* not only is a fixed fraction missing, it is missing in *whole round pieces*: there are fixed sizes
  `ρ₀ < R₀` such that every disc of radius `R₀` contains a completely uncoloured disc of radius `ρ₀`, for every band. R′ ⟹ R (take `R = R₀`,
  `δ₀ = ρ₀²/R₀²`), not conversely. **Object: both.**
- **R″ (the rung), quoted above.** *Mine:* show the missing fraction is at least a constant times `ε` (not merely `ε²/(6+ε)²`). Hitting-form arguments
  are allowed, since strips of width `≍ ε` show `ε` is their ceiling. Not decisive: a bound that tends to 0 decides nothing (H-EQ).

### 1.4 The five killing tests' objects, written down concretely

| # | test | the object, concretely | what "passing" means for an argument of mine |
|---|---|---|---|
| 1 | **Parts calibration** | `[Parts2020c]`'s tight six-tiling `T` (17-gon tiles with wavy sides, Siamese pairs; type-A rhombic voids at degree-4 vertices, type-B arrowhead voids at degree-3 vertices; `δ₆ = 1/6992.1655504123 = 1.430172·10⁻⁴`; rhombus half-diagonals `l = 0.0133`, `r = 0.0055`; TQ §4.3, §4.5(6)) — **taken on Parts's word, [external]**. Eroded by `κ` (`τ_κ = {x : B(x, κ) ⊆ τ}`, TQ-ERODE): slack `ε < 2κ`, uncovered density `δ₆ + O(κ)`, every coloured point of chromaticity 1 | the argument must force **at most** `δ₆ + O(ε)`; forcing more is a bug |
| 2 | **seven-colour control** | regular hexagons of side `s`, coloured by the 7 cosets of the index-7 (Σ7) sublattice of the centre lattice; tile diameter `2s`, same-colour separation `√7·s`; band-proper iff `2s ≤ 1 − ε` and `√7 s ≥ 1 + ε` (e.g. `s = 0.45`, any `ε ≤ 0.1`); read as a partial six-colouring, one class is the hole, density `1/7` | the argument must **fail** on the 7-colouring and name the step where six is spent (a step that uses `6 < 7`, never only class densities: K-INT) |
| 3 | **strip test** | `W_ε = {(x, y) : dist(y, 2ℤ) ≤ ε}` (width `2ε`, spacing 2, density `ε`; FS106-HIT): every unit circle and every bicycle meets it in positive length; every point of its centre lines is `ε ≥ ε/2` from the complement, so it is an effective hole | if every step goes through with the holes replaced by `W_ε`, the argument is of hitting form and **capped at `O(ε)`** |
| 4 | **normalisation** | the bound is `\|H ∩ U_R\| / \|U_R\|` — uncovered area over disc area | never "monochromatic pairs over band measure" (PD-EQ's count is a different quantity) |
| 5 | **pinhole test** | the holes replaced by one disc `B(j, cε)` (`c ≥ 1/2`, so it is effective) at each junction `j` (D-JUNC) or each certificate of the argument; with `N` junctions per unit area the hole density is `≍ Nε²` | if every step survives, the argument is **capped at `O(ε²)`** (A8b's order) unless it also forces `N ≳ ε⁻²` |

### 1.5 Two observations that set my object choice (one mind, [derived]; stated here so the advisor and V can attack them early)

- **O1 (on both) — R-Q and R-S are the same question, not two routes to it.** By TQ-SUP (row 131), `µ₆⁰ = lim_ε µ₆(ε) = lim_ε µ₆^per(ε)`. So "every SEQ
  family keeps holes `≥ δ₀`" is literally "`µ₆⁰ < 1`", which is "no tight a.e.-proper six-colouring covers the plane" (LIM). A SEQ proof is a proof
  on LIM and conversely; what differs is the vocabulary a proof may use (on SEQ: a band `ε > 0`, grid boundaries, no index swaps; on LIM: density
  topology, no band). *Consequence for my programme:* a SEQ argument that uses the band only at scale `ε` must, in the limit, turn into a tight-world
  argument — so its every step must survive in the tight world, or be quantitative in `ε` in a way that does not vanish.
- **O2 (on LIM; restates TS, not new) — Voronov's circle machinery is empty in the tight world.** At exact distance a unit circle is 2-colourable
  (alternating half-open arcs of `π/3`; TS's C-AE-MAP6 row says so), and Voronov's bicycle index loses its only band step (TS's C-T-BIKE (ii)). So every
  Voronov step that needs three colours on a circle, or a swap-free index, is paid for **at scale `ε`**, and a free colour on holes of size `≍ ε` at
  the few places where the tight pattern meets the band can pay it. This is why the pinhole cap `O(ε²)` bites every circle-and-bicycle argument
  anchored at boundedly many junctions per unit area (K-AD (a)). **So a proof of R must hold in the tight world as well** (O1), which no step of
  Voronov does. My stage 2 therefore looks for an argument whose tight-world form is *true*, not for a sharper Voronov.

### 1.6 The advisor's question — my answer (sent to FS107-A2 by SendMessage, verbatim below)

> FS107-R's one message (registered). **Step I expect to fail first: break table row 3, "W: a parameter shrinking the vertex voids."** Why: (1)
> W's Route II limit must be tight, a.e.-proper, and neither polygonal nor a nice map (K-TIGHT, K-REG). So a family whose members stay of bounded
> combinatorial type per unit area — tile boundaries converging locally to a finite polygonal map as the voids shrink — has a polygonal a.e.-proper
> six-colouring as its limit, excluded by FS106-AE-POLY except its `d = 2` case. Shrinking Parts-type vertex voids inside a fixed combinatorial type
> therefore cannot work: the driving parameter must drive the number of junctions or the boundary complexity per unit area to infinity, not only the
> void size to zero. (2) With unbounded junction density `N`, each effective junction void costs `≳ ε²` (HOLE-t), so W needs `N·ε² → 0` while
> junctions multiply; I expect the voids at junctions of complementary type within distance 2 (K-C6) to stop shrinking before that balance is met.
> **Evidence I would accept that I am wrong:** an explicit family with a driving parameter, members given by formula and exactly checked,
> band-properness derived for every parameter value, whose largest junction-void inradius tends to 0 while the uncovered density tends to 0 (that
> refutes my expectation outright); or, weaker, a family whose largest void inradius tends to 0 at bounded coverage loss — that refutes C-VOID and my
> part (2), and I would retract (2) on it. Part (1) is a direct consequence of K-REG and I would retract it only on a defect found in
> FS106-AE-POLY.

## Stage 1 — SAVED

---

## Stage 2 — SAVED: the argument's shape, tested first (X1); where its pigeonhole lives (X2); integrality (X4)

### 2.0 Retraction 1 (free, counted by the advisor; card "is-a-bounded-complexity-limit-excluded")

From §1.6 part (1) I retract "Shrinking Parts-type vertex voids inside a fixed combinatorial type therefore cannot work." FS106-AE-NICE
(`plans/FS106-derivation.md` l. 115) needs faces "of diameter < 1" and same-colour faces "at distance > 1"; a tight limit of slack members has
same-colour faces at distance `≥ 1` or Siamese pairs, which is the relaxation l. 117 leaves a GAP with C-AE-Q2. Parts's tiles have curved sides, so a
bounded-type family of that kind has a C-AE-Q2 limit, not an excluded one. **What survives:** families whose limit is a locally finite *polygonal* map
are out (FS106-AE-POLY, bar `d = 2`); curved bounded families are live, decided by FS106-AE-Q2's [G1]–[G4]. Part (2) stands.

### 2.1 The shape: sort Voronov's certificates by their tight form, and keep only the ones that survive it

*(Stage 3 §3.4 withdraws this table's bicycle row, its circle row's cost as a statement about the plane, and §2.2's bicycle column. Kept here as saved.)*

By O1 (§1.5) a proof of R must hold in the tight world too. So I sort the certificates `[Voronov2023]`'s proof ends in by what happens to each at exact
distance, and by what a *local repair* (a change of the colouring inside discs of radius `ρ` about boundedly many points per unit area — A8b's
kind) does to it on SEQ:

| certificate (where Voronov uses it) | tight form | on SEQ: what breaks it, and its cost per certificate |
|---|---|---|
| **circle**: `T₁(x)` about a trichromatic `x` needs three colours (Props. 3.1–3.3) | **escapable**: at exact distance a unit circle is 2-colourable (alternating half-open arcs of `π/3`; TS, C-AE-MAP6 row) | a free colour on six arcs of angle `2η`, `η > ε/√3`, at the arc ends: with arcs `[kπ/3 + η, (k+1)π/3 − η]` alternating two colours, pairs inside one arc have angle `≤ π/3 − 2η` (chord below the band) and pairs in arcs `k, k + 2` angle `≥ π/3 + 2η` (chord above it). Cost `≍ ε²` per junction (checked by hand here, one mind) |
| **bicycle** on a same-type pair `u, v`, `1 < \|u − v\| < 2` (Thm 1.2; Lemma 6.1 **branch (i)**) | **escapable as a graph**: the index's only band step is to exclude a simultaneous swap (TS, C-T-BIKE (ii)). In a planar tight colouring the swap is a same-multicolour bichromatic unit pair, excluded at Jordan interfaces (TS's C-T-L1 / C-T-L1a) | a swap made legal on SEQ: Lemma SW (§3.3) prices it at `≥ ε·s` when the two boundaries are regular at scale `s` (the tangent configuration), and at `≍ s²` otherwise. A repair that makes the colouring irregular near the two swap points at scale `≍ ε` pays `≍ ε²` ([reading], §3.4) |
| **complementary pair**: two trichromatic points with disjoint multicolours `< 2 + 2ε` apart (Prop. 2.2; ends Lemma 6.1 **branch (ii)**) | **false** at fat junctions (TS's C-T-TAN, stated on LIM) | Lemma CP (§3.2): uncovered area `≥ (cs − 2r)(cs′ − 2r′)` near each point at distance 1 from both, with `s, s′` the cone scales and `r, r′` the void radii. **A repair inside `B(x, ρ) ∪ B(x′, ρ)` moves this by `O(ρ·s)` only** (it changes `r` to `ρ`): no local repair breaks it |

**The argument's shape (R-Q, on SEQ; the limit steps on LIM):** run `[Voronov2023]` Lemma 6.1 on a SEQ member, with junctions (D-JUNC) in place of
trichromatic points. Branch (ii) ends at a complementary pair and costs `≍ s²` by Lemma CP, where `s` is the cone scale. Branch (i) ends at a bicycle,
which costs `ε·s` at best. **So the `ε`-independent content of Voronov's proof sits entirely in branch (ii) and in the cone scale `s`.** A stability
proof along this shape needs (a) every branch to end at a complementary pair, and (b) a lower bound on `s` over a set of positive measure. (b) is a
**regularity estimate** in De Giorgi's sense: the scale down to which the classes look like cones or half-planes. That is link 6 of § The aim, made
concrete (§3.4).

### 2.2 The five killing tests, run on the shape before any proof is written (X1)

| test | Lemma CP (branch (ii)'s certificate) | the bicycle (branch (i)) | verdict |
|---|---|---|---|
| 1 Parts calibration | a true lemma cannot over-force. Its prediction for `[Parts2020c]`: no fat complementary pair within `(η, 2 − η)` at cone scale `s` with `c²s² > δ₆`, which fits Parts's report that "vertices in which three or more colored tiles converge are disadvantageous" (TQ §4.5(6)(b)). Checkable on his tiling after the ban (it is [external]) | Parts's voids at every vertex are the local repairs of the circle and bicycle rows | passes; a prediction registered (P1, §3.5) |
| 2 seven-colour control | the forced region `Q` sees all of `T ∪ T′`, and `\|T ∪ T′\| = 6` is every colour. With seven, `Q` takes the seventh: **six is spent at `3 + 3 = 6`** | six is spent at "the circle about a type-`{a,b,c}` junction uses the other three", and the bicycle needs four `> 3` | passes: the step is named |
| 3 strip test | holes replaced by `W_ε`: `Q` is a 2-dimensional region of area `≍ s²` at distance 1 from both junctions, and `W_ε` does not contain it | a strip of width `2ε` along the boundary at a swap point is exactly Lemma SW's price, so the bicycle **survives** strips | CP: **not** of hitting form. Bicycle: of hitting form, **capped at `O(ε)`** |
| 4 normalisation | the bound is `\|Q\|`, an area | the bound is an area | passes |
| 5 pinhole test | one `ε`-disc at each junction, or at the point `w` of `Q`, leaves `Q ∖ B(w, ε)` coloured and forbidden six times: a contradiction. So the step **does not** survive pinholes | a pinhole at a swap point does not separate the two colour-`a` half-discs (Lemma SW), but a repair that degrades both boundaries at scale `ε` does | CP: **not** capped at `ε²`. Bicycle: capped at `ε²` against a repair at scale `ε` |

### 2.3 Where the pigeonhole lives (X2), and why the free colour cannot absorb it

- **Where.** In the **junction types at the holes**: by K-PIX every junction is a component of the uncovered set (D-JUNC), and Voronov's
  pigeonhole is Lemma 6.1's count of types in `U₁(x)` — the 10 types `{a,b,c}, {d,e,p}, {d,f,p}, {e,f,p}`, then one more. It is **not** in the limit,
  and not averaged.
- **Carrier.** Bounded: the junction `x`, its circle, the inner junctions, and the region `Q` at distance 1 from two of them, all inside `U₃`
  (G17: a sub-rung compulsion with a small carrier).
- **Why the free colour cannot absorb branch (ii).** The forced set `Q` is 2-dimensional, of area `≍ ss′`, and sits at distance `≈ 1` from both
  junctions. Absorbing it means leaving `Q` uncovered, which is the counted cost. The one alternative is to change the colouring near the junctions
  at scale `s` itself — cusps, bowties, a tangent interface: K-TAN's exceptional set — which lowers the cone scale. So the free colour can absorb only
  by degrading regularity at the junction's own scale, never by a small void (G40's "spare colour" is the hole, and here the hole is the bill).
- **Branch (i) is absorbed** at `ε·s` (strip) or `ε²` (local degradation): the bicycle is where Voronov's six stops being robust.

### 2.4 Integrality (X4) and rank (X6)

- Six enters at `|T ∪ T′| = 6` (CP) and at "the other three colours" (circle, bicycle). A one-class or fractional argument cannot see either: CP
  needs the six classes to be **disjoint** and to fill cones about two junctions at once (K-INT is respected).
- On SEQ a Voronov index along grid-transverse traces has finitely many changes, so FS106-IND's finiteness hypothesis is automatic (A2 §3.2).
  Q2 and AE-FA are not used.

## Stage 2 — SAVED

---

## Stage 3 — SAVED: three lemmas, a named obstruction, and the reduction they leave

Notation: `H` is the uncovered set; "band-proper" is D-MU's condition on LIM and "no monochromatic pair at any distance in `[1 − ε, 1 + ε]`" on SEQ;
`A_ε(z) = {q : \|q − z\| ∈ [1 − ε, 1 + ε]}`; `e_ψ = (cos ψ, sin ψ)`.

### 3.1 Lemma SAT (on both) — WLOG the holes are exactly the six-sighted set, and it is open  [hand, one mind]

*Statement.* Call a band-proper family `C₁, …, C₆` **saturated** if no band-proper family contains it (up to null sets) with a strictly larger union.
Saturated families exist above every family (Zorn: a chain's union, taken along a countable cofinal sequence of measures, is band-proper by Fubini).
For a saturated family, with `g_j(z) = \|A_ε(z) ∩ C_j\|` (a continuous function, being `1_{C_j} ∗ 1_{A_ε(0)}`):
**`H = {z : g_j(z) > 0 for all six j}` up to a null set.** In particular `H` is a.e. an **open** set, and a.e. coloured point sees at most five colours
on its band annulus.

*Proof.* (⊇) A.e. `z ∈ C_j` has `g_j(z) = 0`, since otherwise the monochromatic band pairs of `C_j` have positive `Leb ⊗ Leb` measure (Fubini). So
a.e. point with all six `g_j > 0` is uncovered. (⊆) Let `V_j = H ∩ {g_j = 0}` (measurable). If `\|V_j\| > 0`, pick a ball `B` of diameter `< 1 − ε`
with `\|V_j ∩ B\| > 0` and put `C_j′ = C_j ∪ (V_j ∩ B)`. Pairs inside `B` are shorter than the band. For `z ∈ V_j`, `A_ε(z) ∩ C_j` is null, so the new
monochromatic band pairs are null by Fubini. The union grew: this contradicts saturation. ∎

*What it gives.* R becomes "`\|{z ∈ U_R : g_1(z), …, g_6(z) > 0}\| ≥ δ₀\|U_R\|` for saturated families", a statement about an **open** set defined by six
continuous functions. W's checker can compute the same set on a member: any hole point that sees five colours or fewer can be coloured for free. A
normal form for **partial** colourings, beside FS-103's D-NF for full ones. Not found in print (not searched beyond the planner's §PA; G21 — a
negative about my query).

### 3.2 Lemma CP (on both) — complementary fat junctions within distance 2 cost area independent of `ε`  [hand, one mind; the cone case of TS's C-T-TAN, quantified]

*Definitions.* For a closed arc `I ⊂ S¹` of positive length and `0 < r < s`, the truncated cone `K(x, I; r, s) = {x + ρe_ψ : ψ ∈ I, r ≤ ρ ≤ s}`. A
**fat junction of type `T = {a, b, c}` at `x`, scales `r < s`,** is three arcs `I_a, I_b, I_c` with `K(x, I_j; r, s) ⊆ C_j` (on LIM: up to a null
set). Nothing is assumed inside `B(x, r)`: the void, a repair, anything. It **blocks direction `θ` on side `σ ∈ {±}` with margin `µ ∈ (0, π/2)`** if each
`I_j` meets the open arc of half-width `π/2 − µ` about `θ` (`σ = +`) or about `θ + π` (`σ = −`).

*Claim 1 (the chord).* Let `s ≤ sin(µ/2)`, `t₁ = s·sin(µ/2)/3`, `2r < t₁`. If `z = x + (1 + t)e_φ` with `\|φ − θ\| ≤ µ/2` and `σt ∈ [2r, t₁]`, then
`T₁(z)` meets every cone `K(x, I_j; r, s)`, `j ∈ T`.

*Proof.* Take `ψ` with `\|ψ − φ\| ≤ π/2 − µ/2` (`σ = +`) or `\|ψ − φ − π\| ≤ π/2 − µ/2` (`σ = −`), so that `c := \|cos(ψ − φ)\| ≥ sin(µ/2)`.
- `σ = +` (`t > 0`, `\|x − z\| = 1 + t`). The ray `x + ρe_ψ` meets `T₁(z)` when `(1 + t)² c² ≥ 2t + t²`, which holds since `c² ≥ sin²(µ/2) ≥ 3t`. The
  nearer meeting point is at `ρ = (2t + t²)/((1 + t)c + √(1 − (1 + t)²(1 − c²)))`. The denominator lies in `[c, 2 + t]`, so `t ≤ ρ ≤ 3t/sin(µ/2) ≤ s`,
  and `ρ ≥ 2r > r`.
- `σ = −` (`t = −τ < 0`, `\|x − z\| = 1 − τ`). Every ray meets `T₁(z)` once, at `ρ = (2τ − τ²)/((1 − τ)c + √((1 − τ)²c² + 2τ − τ²))`. The
  denominator lies in `[2(1 − τ)c, 2]`, so `τ(1 − τ/2) ≤ ρ ≤ 2τ/sin(µ/2) ≤ s`; and `ρ > r`.

The admissible `ψ` cover the open arc of half-width `π/2 − µ` about `θ` (or `θ + π`), since `\|φ − θ\| ≤ µ/2`. Each `I_j` meets that arc, so `T₁(z)`
contains a point of `K(x, I_j; r, s) ⊆ C_j`. ∎

*Claim 2 (the region).* Let `x` (type `T`) and `x′` (type `T′`, `T ∩ T′ = ∅`) be fat junctions with scales `r < s`, `r′ < s′`, both at most
`s₀(µ, η)`. Let `\|x − x′\| = D ∈ [η, 2 − η]` and `\|w − x\| = \|w − x′\| = 1`. Suppose `x` blocks `θ = dir(w − x)` on side `σ` and `x′` blocks
`θ′ = dir(w − x′)` on side `σ′`, both with margin `µ`, and `2r < t₁`, `2r′ < t₁′`. Then
**`\|H ∩ B(w, µ/4)\| ≥ (t₁ − 2r)(t₁′ − 2r′)`, with `t₁ = s·sin(µ/2)/3` and `t₁′ = s′·sin(µ/2)/3`.** On LIM, where `H` is null, such a configuration does not
occur.

*Proof.* `F(z) = (\|z − x\| − 1, \|z − x′\| − 1)` is a local diffeomorphism at `w`, with `\|det DF\| = \|sin ω\|`, where `ω` is the angle between `z − x`
and `z − x′`. At `w`, `sin ω = D√(1 − D²/4) ≥ η/2` (for `η ≤ 1`). For `s, s′ ≤ s₀ = µη²/100` (constants not optimised), the preimage `Q` of the box `σ[2r, t₁] × σ′[2r′, t₁′]`
near `w` lies in `B(w, µ/4)`. So each `z ∈ Q` has `dir(z − x)` within `µ/2` of `θ`, and `dir(z − x′)` within `µ/2` of `θ′`. By Claim 1, `T₁(z)` meets all
six classes, and `1 ∈ [1 − ε, 1 + ε]`, so `z ∉ C_j` for every `j`.
- On LIM: for a.e. `z ∈ Q`, `T₁(z)` meets each cone in positive length, because `I_j` meets an open arc in a sub-arc of positive length, and the
  null exceptions are null on a.e. circle (Fubini). So a.e.-properness gives the same conclusion.
- Then `\|Q\| = ∫_box dτ dτ′/\|sin ω\| ≥ (t₁ − 2r)(t₁′ − 2r′)`. ∎

*Its three properties* (why it is the right certificate):
- **(scale)** The cost is `≍ ss′`. It is independent of `ε`, and depends on the cone scale only.
- **(repair-robust)** Change the colouring inside `B(x, ρ) ∪ B(x′, ρ′)`, anywhere else away from the cones, or anywhere away from `Q`. The
  hypotheses still hold with `r, r′` replaced by `ρ, ρ′`, and the bound moves by `O(ρs′ + ρ′s)`. **No local repair at scale `≪ s` breaks it**, which is
  what A8b's `O(ε²)` repairs do to every other Voronov certificate.
- **(disc)** `Q` is a curvilinear parallelogram of side widths `t₁ − 2r`, `t₁′ − 2r′` at angle `ω`. It contains a fully uncovered disc of radius
  `≥ ½ sin ω·min(t₁ − 2r, t₁′ − 2r′)`: CP yields C-VOID's discs, not only area.

### 3.3 Lemma SW (on SEQ) — a same-multicolour unit pair at a flat tangent interface costs exactly order `ε·s`  [hand, one mind; both bounds]

*Statement.* Let `\|p − q\| = 1`, `e = q − p`, `ε ≤ s/2`, `s ≤ 1/10`. For each `v ⊥ e` with `\|v\| ≤ s/2`, suppose one half-segment
`S_p(v) ∈ {p + v + [−s/2, 0]e, p + v + [0, s/2]e}` lies in `C_a ∪ H`, and one half-segment `S_q(v)` about `q` likewise. The choice of halves is
the same for every `v`. This is "colour `a` on one side of a flat `{a, ·}`-boundary through `p`, and through `q`, the boundaries perpendicular to
`pq`": the tangent interface, the one configuration C-T-L1a leaves a swap in the tight world. Then:
- **(lower)** `\|H ∩ (B(p, s) ∪ B(q, s))\| ≥ ε·s`.
- **(upper, for colour `a` only)** When the `a`-sides face apart, removing a strip of width `ε⁺` along one boundary (area `≈ εs`) leaves no
  monochromatic band pair between the two `a`-regions. **It does not legalise the swap:** the other colour `b` then occupies the two half-discs that
  face *each other*. There, `\|P − Q′\|² ≈ 1 + 2(α′ − α) + \|v − v′\|²` takes the value 1 on a 2-dimensional family, a tight violation. Separating
  them needs strips of total width `≳ s²/2 + ε`, so *[sketch, one mind]* the swap costs `≳ εs + s³` at a flat interface of scale `s`.

*Proof.*
- (lower) Points `p + v + αe` and `q + v + α′e` are exactly `\|1 + α′ − α\|` apart, so a band pair on the line is `\|α′ − α\| ≤ ε`. Let
  `X, Y` be the `α`'s of `C_a`-points on `S_p(v)` and `S_q(v)`. They must satisfy `\|α′ − α\| > ε` for all `α ∈ X`, `α′ ∈ Y`. In each of the
  facing cases this forces the uncovered part of `S_p(v) ∪ S_q(v)` to have length `> ε`:
  - apart: `inf Y − sup X > ε`;
  - together: likewise, reversed;
  - same side: `X, Y` are `ε`-separated inside one interval of length `s/2`, so the holes are `≥ s/2 + ε`.
  Integrating over `\|v\| ≤ s/2` gives `≥ εs`.
- (upper) With the `a`-sides facing apart and `α′ ≥ ε⁺` after the strip, every pair between the two `a`-regions is at distance
  `√((1 + α′ − α)² + \|v′ − v\|²) ≥ 1 + α′ − α > 1 + ε`. ∎

### 3.4 The named obstruction, and the reduction that is left

**Correction to §2.1–§2.2, made before this stage was committed (self-audit, G21; my second retraction, free).** As drafted, this section held a
"Theorem OB": branch (i) is of hitting form, so every bicycle argument is capped at `O(ε)`. Its premises were two:
- "the swap's only tight form is the tangent interface". **False:** TS's C-T-L1 **excludes** the swap outright at Jordan interfaces in D-NF. C-T-L1a
  shows the boundary is an arc of `ω(y)`, and TS-U then empties the side cones.
- "an `ε`-strip legalises it". **False:** it legalises colour `a` only (§3.3).

§2.1's bicycle row and §2.2's bicycle column ("survives strips … capped at `O(ε)`"; "a repair … at scale `ε`") are withdrawn with it, and so is the
circle row's "cost `≍ ε²` per junction" **as a statement about the plane**. It holds for the one-dimensional circle. About a fat junction, the forbidden
region is S–V's deformed annulus of width `≍ s`, whose three-colouring with a band is TS's [G2] gap, and I have not priced it. What stands: Lemma CP's
column; Lemma SW's lower bound.

**What stands — Theorem OB′ (on SEQ) [hand for CP and SW, one mind; the swap's `s³` a sketch].** Of `[Voronov2023]`'s certificates:
- the **complementary pair** (Prop. 2.2; Lemma 6.1 branch (ii)) is proved **repair-robust**, at cost `≥ (t₁ − 2r)(t₁′ − 2r′) ≍ ss′` (Lemma CP);
- the **swap** that a bicycle (branch (i)) needs costs `≥ εs` (Lemma SW) and, by the sketch, `≳ s³`. So it is tight-false at scale `s` as well,
  consistent with C-T-L1.

Each certificate's cost is a **positive power of the local regularity scale `s`**. The one certificate whose cost vanishes with `ε` at fixed `s` is
the thin circle, which the plane never presents alone.

**The obstruction that is proved (a result about arguments, [hand, one mind]):** *an argument that reads, at a swap, only the pairs of one colour is
capped at `O(ε·s)` per swap (Lemma SW is sharp for one colour), so it is of hitting form.* Stability must read both colours at a swap, as C-T-L1 does.

So the step where six must be re-spent robustly is still **Lemma 6.1 branch (i)**. It is now priced, not closed: robust if and only if the swap's
two-colour cost is scale-invariant (`≳ s³`, the sketch), and if the circle rows' deformed annuli are too.

**Reading RR — the reduction (one mind; with its killing test).** R, and R′ with it, follows from two statements, each open:
- **(A) branch (ii) is forced.** For some `R, η, µ` and every band-proper partial six-colouring with holes `< δ` in `U_R`: `U_R` contains a
  complementary pair of junctions at distance in `[η, 2 − η]`, blocking toward a point at distance 1 from both.
- **(B) a regularity scale.** Those junctions are fat at a scale `s ≥ s₀`, with voids `r ≤ s·sin(µ/2)/12`.

Given (A) and (B), Lemma CP gives `\|H ∩ U_{R+1}\| ≥ (s₀ sin(µ/2)/6)²`: R, and a C-VOID disc.
- (A) fails for Voronov's own case analysis as stated, which has branch (i). Two ways on, either sufficing with (B):
  - **(A″)** price branch (i) instead: prove the swap's two-colour cost `≳ s^k` (the §3.3 sketch says `k = 3`), and price the deformed annulus
    (TS [G2]) likewise;
  - or re-route it, **"bicycle-free Voronov"**: re-route the same-type branch so that
  it too ends at a complementary pair. A first handle: in the overlap of the two deformed annuli about same-type junctions `u, v`, any junction of the
  three complementary colours is complementary to `u` at distance `≈ 1`, so it is priced by CP. The index relations of the bicycle then have to come
  from how colour boundaries cross that overlap, **at the annulus's scale, not at `ε`'s**.
- (B) is link 6 of § The aim ("the gap to regular classes is quantitative"), made concrete as a **cone-scale lower bound**. W's only escape from a
  forced complementary pair is to push the cone scale to 0 at every such pair: cusps, bowties, tangency (K-TAN's exceptional set) at every scale.
- *Killing test:* a proof of R that uses neither a complementary pair nor a scale lower bound; or a W family with holes `→ 0` whose junctions keep a
  cone scale bounded below. The second would make (B) true and (A) false, and the reading would die.

### 3.5 Predictions registered (G21 instruments, scored at the close)

- **P1:** `[Parts2020c]`'s tiling has no complementary pair of fat junctions at distance in `[η, 2 − η]` with `(t₁ − 2r)(t₁′ − 2r′) > δ₆`
  (probability 0.9). Checkable exactly from his coordinates, when held; it is [external] now. Failing it refutes Parts's `δ₆` or my Lemma CP.
- **P2:** every W family with holes `→ 0` has cone scale `→ 0` at its complementary pairs within `[η, 2 − η]` (or has none there) (0.95; forced by
  CP, so it is a check on W's families, never a finding).
- **P3:** "bicycle-free Voronov" (A) is FALSE as a universal statement, and a W-type construction avoids complementary pairs at every scale (0.6).
  Registered so that the counter-priors do not turn my hope into a grade.

### 3.6 Would-have-searched-here (added this stage)

- C-T-BIKE: the offset scan over `(φ, ψ)` for TS's shared-colour arc ansatz (`T₁(u)` in `{1, 2}`, `T₁(v)` in `{1, 3}`, alternating `π/3` arcs). Instead I
  worked two windows by hand at `d = 1.9`. With the colour-1 arc of `T₁(u)` at `[−30°, 30°)`, the branch gap `min(α + β) − max(α − β)` is 58.4°; shifted
  by 9° it is 59.3°; the ansatz needs `> 60°`. So the **pure `π/3`-arc ansatz fails narrowly there** (hand arithmetic, not a claim about C-T-BIKE: general
  tight 2-colourings of a circle are `E ∪ (E′ + 60°) ∪ …` for any `E ⊂ [0, 60°)`, and I did not use that freedom). I stopped rather than scan.

## Stage 3 — SAVED
