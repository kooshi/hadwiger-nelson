# FS116-V6 — a blind second mind on FS116-Y4-EMPTY (claim list § 15)

*Job FS116-V6 (Ephodos, verification form), launched 2026-10-03 by Keryx. Brief: `data/fs116/briefs/FS116-V6-verify.md`, with
`plans/STANDING-RULES.md`. Record of one verification of one statement. Working files: `data/fs116/v6/`; tools: `tools/fs116_v6_*.py`.*

## Stage 1 — the readback and the registered expectation

### 1.1 The quotation check (standing rule 3)

The brief quotes one statement. Checked by script (exact string comparison of the brief's quoted line against the line of
`data/fs116/claims.md` § 15 that opens `- **FS116-Y4-EMPTY**`): **identical, 417 characters each.** No mismatch to report.

The statement, verbatim (`data/fs116/claims.md` § 15):

> - **FS116-Y4-EMPTY** *(proposed at round 4)*: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1
> about a vertex p of at least four colours has a ring carrying no arc of Γ *Not claimed:* anything for rings carrying an arc of Γ
> that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs); anything in the Siamese or
> non-simple class; anything at k ≥ 7

§ 15's own note: the proposing record's *not claimed* line ended with a parenthetical after "anything at k ≥ 7", naming a step of the
argument, withheld until the close. So the *not claimed* line I hold is incomplete by one parenthetical, by design.

### 1.2 The readback — the statement restated, and the readings I adopt

Setting words: § 0 of the list (valid fragment, Siamese, Γ and tiles, ring, simple), with `data/fs114/claims.md` § 0 where § 0 does
not restate.

**Restated.** Let `R > 1`, let `U ⊃ B̄(p, R)` be open, and let a map of `U` bounded by segments and circular arcs carry a six-colouring
of its tiles (the components of `U ∖ Γ`) with no two interior points of one colour at distance exactly 1. Suppose no two distinct tiles
of one colour are Siamese, every tile is simple (§ 0), and `p` is a vertex at which at least four colours meet. Then `Γ ∩ ω(p)`
contains an arc. Equivalently: in that class, `Γ ∩ ω(p)` is never finite.

**Readings, each stated so the author can correct it.**
- *R-RAD.* "On a closed disc of radius above 1": the statement fails as soon as **one** `R > 1` carries such a fragment; a fragment
  on a larger disc restricts to one on every smaller disc, so "for every `R > 1`" and "for some `R > 1`" give the same statement.
- *R-SIAM.* § 0's Siamese (de Grey: "tiles that lie entirely within each other's annulus of exclusion"). Two distinct tiles of one
  colour are connected open sets, so the set of distances between their interior points is an interval; validity keeps 1 out of it,
  so either every cross-distance is below 1 or every one is above 1. I read *Siamese* as the first case and *non-Siamese* as "every
  two distinct tiles of one colour have all cross-distances at least 1 (between closures)" — the form § 13's notation paragraph states.
- *R-ARC.* "A ring carrying no arc of Γ": `Γ ∩ ω(p)` contains no non-degenerate arc; by local finiteness on the compact `ω(p) ⊂ U`,
  equivalently `Γ ∩ ω(p)` is finite (§ 14's *Γ-free*).
- *R-TILE.* A tile has diameter at most 1 (a connected open set of diameter above 1 holds two points at distance exactly 1).

### 1.3 Given (recorded before any verdict)

- The statement and its *not claimed* line, less the withheld parenthetical.
- The whole of `data/fs116/claims.md`, including §§ 10–14: statements proposed by the proof side (N1, N2, N3, S1) and by the
  **construction side's round 3 (FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS, -STARFORCE) with that record's setting words (§ 14)** —
  the same side that proposed this statement at round 4. Those statements describe the structure of exactly this class (six change
  points, one tip per hub, the tips' cones, the forced star at radius `√3`), so **they are route-shaped information about the first
  mind's side, given, not brought.** Their arguments were not given.
- `data/fs114/claims.md` in full; `plans/FS114-derivation.md` header and § 3 (entries' statements, *uses only*, *not claimed*,
  model and minds lines; no argument records opened).
- `CLAUDE.md` and the grokkings (preloaded at launch; G83, G84, G86 bear on the class).
- My own prior knowledge of this project's vocabulary from those files; nothing else about FS-116's work.

**Timing, stated exactly.** I read the brief, the standing rules, both claim lists and § 3 of the FS-114 derivation file, and then
reasoned about the configuration for some time **before** writing the prediction below. In that reasoning I derived the germ cones at a
change point, met an adjacency constraint on outer tiles at neighbouring hubs, and sketched a candidate configuration with a
five-colour hub. **The prediction below is therefore informed, not naive, and was written after a candidate counterexample had
occurred to me.** It is registered now, before any construction is written down or checked, and before any derivation is filed.

**Fence log.** Between 12:05 (launch) and 17:25 UTC (exact minute not logged at the time): a directory listing (`ls plans/ | grep verification`) printed the *file names* `plans/FS121-DB1-…`,
`-V2-` … `-V5-verification.md`. Names only; no content was printed or read. Logged for completeness.

### 1.4 The registered expectation

- **Predicted verdict: refuted — 0.6** (derived 0.3; gap 0.1).
- **Likeliest break:** a hub (change point of the ring) carrying **two** outer tiles, hence five colours, at radius just above 1. At
  that radius the hub's own unit circle is visible only on a 120° arc, which can be covered by an edge of `p`'s tile along it; so a
  five-colour hub costs nothing locally. A short argument that assumes each hub carries a single outer colour would then prove the
  statement only at a radius where the hubs' rings are seen.
- **If the statement holds**, I expect the argument to run through the six hubs' outer colours and an adjacency rule between
  neighbouring hubs, and to need every hub to carry exactly four colours.
- **The controls (§ 9).** The class's hypotheses: the strip's midline vertices and the disk's corners carry (Q) arcs on their rings,
  and FS114-Y2-BOWTIE's ring carries the lenses' caps (arcs of `ω(p)`); none is in the class, so none can refute. At `k = 7`, R7; at
  `k = 9`, SQ9 (whose `r(45°)`, `r(225°)` carry one colour, § 12) — the statement claims nothing there; I will say where six is spent.

### Would have searched here

- (none yet)

### Theorems this phase proved

- None at stage 1.

*(The stage-1 `verification:` block — the prediction, registered at commit `5ddd2c1d` — is carried forward, updated, at the end of stage 2; its registered `predicted:` line is unchanged.)*

## Stage 1 — SAVED

## Stage 2 — derivation, attack, verdict

*Written 2026-10-03 from 17:38 UTC. Nothing fenced was opened. The derivation below is my own; the attack's first move was to build
the stage-1 candidate counterexample, and it failed at the step that became lemma V6-HUG.*

### 2.1 Notation

`p = 0`; `e(θ)` the unit vector at angle `θ` (degrees); `r(θ) = p + e(θ)`; `ω(z)`, `B(z)`, `B̄(z)` the unit circle, open and closed unit
discs about `z`. For a tile `T`, `cl T` its closure. A tile of `p` is a tile whose closure holds `p`; a **tip** at a point `y` is a tile of
`p` whose closure holds `y` (§ 13's word). `P` is the set of `p`'s colours. Six colours throughout unless said.

### 2.2 The derivation — the class is empty

**V6-DIAM.** A tile has diameter at most 1; so a tile whose closure holds `z` lies in `B̄(z)`. *(A connected open set holding two points
more than 1 apart holds two at distance exactly 1: fix one, and the distance to it takes every value in between.)*

**V6-E1.** An interior point `x` of a tile of colour `c` is at distance `≠ 1` from every point `z` of the closure of a tile `T` of colour `c`.
*(If `|x − z| = 1`, take `B(x, δ)` inside the first tile and an interior point `t` of `T` with `|t − z| < δ/2`; then `|x − t| ∈ (1 − δ/2, 1 + δ/2)`
and the unit circle about `t` meets `B(x, δ)` in interior points of colour `c` at distance exactly 1 from `t`.)*

**V6-DICH.** For two distinct tiles `S, T` of one colour, the distances between their interior points form an interval (the product of two
connected sets is connected) that misses 1: all below 1 (Siamese) or all above 1. So **in a non-Siamese fragment, a tile of colour `c` having
an interior point within distance `< 1` of a point of `cl T`, `T` of colour `c`, is `T` itself**; in particular a point lies in the closure
of at most one tile of each colour.

**V6-RING** *(six spent, first time)*. By R-ARC, `Γ ∩ ω(p)` is finite. A point of `ω(p) ∖ Γ` is interior to a tile whose colour is absent at
`p` (V6-E1 with `z = p`). Two points of `ω(p) ∖ Γ` at angular distance 60° are at distance exactly 1, so carry different colours. Hence at
least two colours are absent at `p`; with six colours and at least four at `p`, **exactly two, `X` and `X̄`, are absent, `p` has exactly four
colours, and (V6-DICH) exactly four tiles `T_c`, `c ∈ P`**, one per colour; and the ring's colour `κ` off `Γ` satisfies
`κ(θ + 60°) ≠ κ(θ)`, so `κ(θ + 120°) = κ(θ)`.

**V6-WIN.** The change points (points of `Γ ∩ ω(p)` with different colours on the two sides) form a set invariant under the rotation `σ` by 60°
(`κ(ψ + 60° ± ε) = ¬κ(ψ ± ε)` for small `ε`), so each half-open 60° window holds the same number `m` of them; `κ` differs at the two ends of
such a window, so `m` is odd.

**V6-GERM.** Let `y = r(ψ)` be a change point, `X` the colour just counter-clockwise of `y` and `X̄` just clockwise, `u = r(ψ + 60°)`,
`v = r(ψ − 60°)`. By V6-RING the ring is `X` just clockwise of `u` and of `v`, and `X̄` just counter-clockwise of each. **There is a
neighbourhood `N` of `y` in which interior points of `X`-tiles lie in `B̄(u) ∖ B(v)` and interior points of `X̄`-tiles in `B̄(v) ∖ B(u)`.**
*Proof for `X` and `B̄(u)` (the other three alike, with the chord `2 sin((60° ± θ)/2)` below or above 1).* The germ `{r(ψ + 60° − θ) : 0 < θ < δ}`
is off `Γ`, in `X`-tiles. Put `f_z(θ) = |z − r(ψ + 60° − θ)|`. Then `f_y(θ) = 2 sin((60° − θ)/2) < 1`; fix `θ₁ = δ/2` and `c = 1 − f_y(θ₁)`. For
`|z − y| < c`, `f_z(θ₁) < 1`; if also `f_z(0) = |z − u| > 1`, some `θ ∈ (0, θ₁)` has `f_z(θ) = 1`, and V6-E1 forbids `z` to be an interior point of
an `X`-tile. ∎ (This is § 11's FS116-N1-GERM-R, reached here by my own route.)

**V6-TIP** *(six spent, second time)*. **Every change point `y` has a tip, and every tip at `y` lies in `B̄(y)`.** With `u + v = y` (for
`p = 0`), a point `z = y + w` in `B(u) ∩ B(v)` satisfies `2w·(y − u) + |w|² < 0` and `2w·(y − v) + |w|² < 0`; adding, `2w·y + 2|w|² < 0`, so
`|z|² = 1 + 2w·y + |w|² < 1 − |w|²`: **`B(u) ∩ B(v) ⊂ B(p)`.** Points of `N ∩ B(u) ∩ B(v)` (the directions `ψ + (150°, 210°)` at `y`) off `Γ` are
neither `X` nor `X̄` (V6-GERM); with six colours their colour `c` is in `P`; they are within `< 1` of `p ∈ cl T_c`, so their tile is `T_c`
(V6-DICH). These points accumulate at `y`, and finitely many tiles meet a small disc about `y`, so some `T_c` has `y` in its closure.
Every tip at `y` lies in `B̄(y)` by V6-DIAM.

**V6-HUBS.** **`m = 1`: the change points are `y_k = r(ψ₀ + 60°k)`, six of them; a tile of `p` tips at most two, and two only if
consecutive.** A tile's tipped change points are pairwise within distance 1 (V6-DIAM), so within a closed 60° arc, which holds at most `m + 1`
of the `6m`; four tiles tip all of them (V6-TIP), so `4(m + 1) ≥ 6m`, `m ≤ 2`, and `m` is odd. Consecutive hubs are 1 apart, the others `√3`
or 2. Rotate so `ψ₀ = 0`.

**V6-ANTI.** **A tile tipping `y_k` and a tile tipping `y_{k+3}` share no edge at `p`.** Their closures lie in `B̄(y_k) ∩ B̄(y_{k+3}) = {p}`.

**V6-HUG.** **No tile `T` of `p` tips both `y_0` and `y_1` while being the only tip at each.** *Proof.* `T ⊂ B̄(y_1)`, so its sector at `y_0`
lies in `[30°, 210°]` (the closed half-plane toward `y_1 − y_0 = e(120°)`); as the only tip it fills the tip sector `(150°, 210°)` (V6-TIP), so
its sector ends at exactly `210°`. Let `R⁻` be the tile whose sector at `y_0` follows `T`'s counter-clockwise. Its points near `y_0` in the
directions `210° + η` lie in `B(p) ∩ B(y_5)` and outside `B̄(y_1)`: not `X` (`X` avoids `B(v) = B(y_5)` near `y_0`, V6-GERM); not a colour of
`P`, or `R⁻` would be a tile of `p` (V6-DICH) with `y_0` in its closure, a second tip; so `X̄` (six colours). The common edge of `T` and `R⁻` at
`y_0` lies in `cl T ∩ cl R⁻ ⊂ B̄(y_1) ∩ (ℝ² ∖ B(y_1))` near `y_0` (V6-GERM: `X̄` avoids `B(u) = B(y_1)`), that is on `ω(y_1)`: so
**`cl R⁻ ⊃ {b(t) = y_1 + e(300° − t) : 0 ≤ t ≤ t₀}`**, the arc of `ω(y_1)` from `y_0` toward `p`. At `y_1`, the same with the roles turned:
`T ⊂ B̄(y_0)` puts its sector in `[210°, 30°]`; it fills `(210°, 270°)`, so starts at `210°`; the tile `R⁺` before it clockwise is in
`B(p) ∩ B(y_2) ∖ B̄(y_0)` there, which is the ccw colour of `y_1`, `κ(60°+) = ¬κ(0°+) = X̄`; and **`cl R⁺ ⊃ {a(s) = y_0 + e(120° + s) : 0 ≤ s ≤ s₀}`**.
`R⁻` is the only `X̄`-tile at `y_0` (V6-DICH), so it holds the ring just clockwise of `y_0`; likewise `R⁺` holds the ring just
counter-clockwise of `y_1`; two such ring points are more than 1 apart, so `R⁻ ≠ R⁺` and they have interior points more than 1 apart. But
$$|a(s) − b(t)|^2 − 1 = −8 \sin\tfrac{s}{2}\,\sin\tfrac{t}{2}\,\cos\tfrac{s+t}{2} < 0 \quad (0 < s, t \le 60°)$$
(control `v6-hug`), so they also have interior points less than 1 apart: two distinct `X̄`-tiles with interior distances on both sides of 1,
against validity. ∎ *(Validity alone kills it here; non-Siamese was used only for the uniqueness of `R⁻`, `R⁺` and of the tip.)*

**V6-COUNT.** Let `t_h` be the number of tips at hub `h`, `S = {h : t_h ≥ 2}`, `s = |S|`, and `M` the number of tiles of `p` tipping two hubs
("double"). Counting incidences, `Σ_h t_h ≤ 2M + (4 − M) = M + 4`, and `Σ_h t_h = (6 − s) + Σ_S t_h`, so `Σ_S t_h ≤ M + s − 2`. By V6-HUG each
double tile has a hub in `S`, so `M ≤ Σ_S t_h`; hence `s ≥ 2`. And `Σ_S t_h ≥ 2s` gives `M ≥ s + 2 ≥ 4`: so `M = 4`, `s = 2`, each hub of `S` has
exactly two tips, and every tip at a hub of `S` is a double tile. The four double tiles' hub pairs are four distinct edges of the hexagon
`y_0 … y_5` (a repeated pair leaves two double tiles with no hub in `S`) covering every hub, with degrees `2, 2, 1, 1, 1, 1`. The two missing
edges are disjoint (a shared vertex would be uncovered); the four remaining edges form two paths, and a path of one edge has both ends of degree
1, against V6-HUG; so both paths have two edges and **the two hubs of `S` are antipodal**, `y_k` and `y_{k+3}`, each tipped by two of the four
tiles. In the cyclic order of the four sectors at `p` (one sector per tile: *simple*), each tile shares an edge with two others; of the four
pairs (tipper of `y_k`, tipper of `y_{k+3}`) at most two are opposite in the 4-cycle, so at least two share an edge at `p`, against V6-ANTI. ∎

**Conclusion (V6-EMPTY).** No non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex of at least
four colours has a ring carrying no arc of `Γ`. **The statement is TRUE, as stated, by this route.**

**Uses only.** Validity (V6-DIAM, V6-E1); non-Siamese (one tile per colour at `p`; the tip sector filled by tiles of `p`; one `X̄`-tile at a
hub); simple (one sector per tile at `p`, so the four tiles form a 4-cycle of shared edges — V6-COUNT's last step only); six colours (V6-RING:
exactly two absent colours; V6-TIP and V6-HUG: the only colours besides `X`, `X̄` are `p`'s); a ring with finitely many points of `Γ`; and the
fragment on a neighbourhood of `B̄(p, 1)` only — **it reads radius 1**, and since an open set containing `B̄(p, 1)` contains `B̄(p, 1 + ε)`,
"radius above 1" and "radius 1" name the same class. No input of the list's §§ 2, 8, 10–14 is used: V6-GERM re-derives § 11's GERM-R on my
own route, and nothing rests on FS116-Y3-SIX or -TIPS.

**Where six is spent** (the killing test, `data/fs114/claims.md` § 6): at V6-RING (with `k` colours `k − 4` may be absent, and the ring's
two-colour alternation is lost) and at V6-TIP / V6-HUG (a colour absent at `p` and not on the ring could fill a tip sector, so hubs need no
tips and the count collapses). The hexagonal 7-colouring has no vertex of four colours; at `k = 9`, SQ9 is in the class but for the colour
count and its ring carries no arc of `Γ` (control `v6-sq9`): its ring carries five colours, so V6-RING fails there first.

**Where it fails on the controls of § 9** (`data/fs114/claims.md` § 6's C-BEYOND rule): the capped strip's midline vertices and the disk's
corners carry (Q) arcs on their rings, and FS114-Y2-BOWTIE's ring carries its lenses' caps; each fails the hypothesis at V6-RING (the ring
is not finite in `Γ`) and V6-GERM (the germs at their change points lie on (Q) arcs — § 10's note on the strip's `P₂`). None is in the class,
so none can refute it; the argument is a local exclusion of a class they are not in and spends no plane beyond `B̄(p, 1)`.

### 2.3 The attack

1. **The stage-1 candidate, built and killed.** I built the configuration I had registered as the likeliest break: the star
   `δ = (90°, 150°, 270°, −30°)` with `T1 = Reul(p, y_0, y_1)` cut at the chord, `T2 = −T1`, `T3` from `p` to `y_2` (edges along `ω(y_0)` to
   `w_1 = y_0 + e(150°)`, segments `w_1 y_2`, `y_2 w_3`, `w_3 = y_4 + e(90°)`, back along `ω(y_4)`), `T4 = −T3`, ring tiles `X = 5`, `X̄ = 6`
   hugging `T1`'s and `T2`'s Reuleaux sides, outer tiles `y_0: 2, 3`, `y_1: 2`, `y_2: 4`, `y_3: 1, 4`, `y_4: 1`, `y_5: 3` (two five-colour hubs,
   which the adjacency rule below forced), cut off at the regular 12-gon of inradius `(1 + √3)/2`. It **fails**: the `X̄` ring tile over
   `(60°, 120°)` holds `w_1` and the one over `(300°, 360°)` holds `y_1 + e(270°)`, and these are `√3 − 1 ≈ 0.732` apart (V6-HUG at `s = t = 30°`:
   `1 − 8 sin²15° cos 30° = 4 − 2√3`). The failure is not repairable in that family: generalised, it is V6-HUG, and with V6-COUNT and V6-ANTI the
   whole class dies. **My registered likeliest break does not hold.** Not a retraction of a committed verdict; a prediction missed.
2. **The adjacency rule met on the way** (kept as a lemma, not needed by the proof). Outer tiles of one colour at adjacent hubs, each
   hugging the lens arc beyond its hub (`ω(y_1)` beyond `y_0`, `ω(y_0)` beyond `y_1`), are within `< 1`: the same identity with both arcs run
   outward (`a = y_1 + e(−60° + s)`, `b = y_0 + e(120° − t)`). It is why a single outer colour per hub is impossible on the forced colours of
   `y_2`, `y_5` (§ 12's NBTIP) and why a construction needs five-colour hubs — which V6-HUG then kills from the inside.
3. **Smallest and degenerate cases**, each covered: `m ≥ 3` change points per window (V6-HUBS); cusps at `p` (V6-ANTI needs only that
   consecutive sectors share an edge, true for zero-angle sectors); hubs with three or more tips and tiles of `p` tipping nothing (V6-COUNT's
   inequalities); `p` with five colours (V6-RING); a tip touching `y` only outside the tip sector (counted as a tip in V6-COUNT; V6-HUG needs only
   "the only tip").
4. **Each hypothesis removed in turn.** *Six colours:* at `k = 9` the conclusion fails — SQ9 (`v6-sq9`: valid, non-Siamese, four colours at
   `p`, twelve points of `Γ` on the ring, five ring colours), already named by the *not claimed* line, so it confirms that line. *Non-Siamese*
   and *simple*: used where 2.2 says; whether the conclusion survives without them I did not decide (both are outside the claim). *Radius:*
   nothing beyond `B̄(p, 1)` is read; the statement holds at radius 1, the same class.
5. **Where the attack succeeds:** at the colour count, `k = 9` (exact control), and nowhere inside the claim. I found no statement inside the
   claim's class that fails.

### 2.4 Consequences for other statements of the list (for the coordinator; not verdicts on them)

- **§§ 12 and 14's FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE** are stated on exactly this class (non-Siamese, simple, six
  colours, a ring carrying no arc of `Γ`, radius above 1 or at least `√3`). If V6-EMPTY holds they are true **vacuously** — thin truths about an
  empty class; and Y3-TIPS's labelling (`T1` alone at `y_0` and `y_1`, `T2` alone at `y_3` and `y_4`) is excluded directly by V6-HUG.
- FS114-N7-3T's N7-HUB and FS114-N6-NOQ's N6-RING60, stated for rings free of (Q) arcs after the bends, are vacuous on the `Γ`-free part of
  their class and keep content only on rings carrying (R2) arcs — the part the *not claimed* line leaves open.

### Would have searched here (stage 2)

- Would have handed the stage-1 candidate to a segment-and-arc checker and then swept its free parameters (`δ_i`, the split points `w_1`,
  `w_3`, the outer-tile cuts); instead located its failure by hand at one pair of tiles and generalised the failure into V6-HUG.
- Would have enumerated tip assignments (4 tiles, 6 hubs) by program; the list's § 9 bans enumerating ring types, so V6-COUNT is a hand count.

### Theorems this phase proved

- **V6-EMPTY** — FS116-Y4-EMPTY as stated (the class is empty; it reads radius 1). [hand; one mind, blind, the same model] — § 2.2.
- **V6-HUG** — a tile of `p` tipping two adjacent hubs cannot be the only tip at both. [hand; the identity checked symbolically by `v6-hug`] — § 2.2.
- **V6-COUNT** — with V6-HUG, the tips force two antipodal doubly-tipped hubs and four double tiles. [hand] — § 2.2.
- **V6-ANTI** — tippers of antipodal hubs share no edge at `p`. [hand] — § 2.2.
- **V6-HUBS** — exactly six change points, 60° apart, each with a tip (`m = 1`). [hand] — § 2.2 (FS116-Y3-SIX's first clause, by my route).
- **V6-ADJ** — outer tiles of one colour at adjacent hubs cannot both hug the lens arcs beyond their hubs. [hand] — § 2.3 item 2.

verification: FS116-Y4-EMPTY
  statement: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no arc of Γ
  given: the statement; the whole frozen list data/fs116/claims.md, including the construction side's round-3 statements
    FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS, -STARFORCE and their setting words (§ 14) — route-shaped, given; data/fs114/claims.md;
    plans/FS114-derivation.md header and § 3 statements; CLAUDE.md; the grokkings. No argument, sketch or verdict of the first mind.
    The prediction was written after some minutes of my own reasoning (§ 1.3)
  committed: 2026-10-03 — the stage-2 commit of this record; the prediction at 5ddd2c1d
  predicted: refuted — 0.6 — likeliest break: a hub with two outer tiles (five colours) at radius just above 1
  verdict: derived
  method: tip counting at the six hubs — V6-HUBS, the hugging identity V6-HUG, the antipodal tangency V6-ANTI and the count V6-COUNT; the
    first mind's route unknown to me (its record fenced); its side's round-3 labels (§ 14) were given but not used
  attack: § 2.3
  divergences: none — the comparison opens at stage 3, after this commit
  counterexamples: none — searched: the five-colour-hub star built in § 2.3 item 1 (dies at V6-HUG), m ≥ 3 change points, cusps at p,
    multiple tips; SQ9 at k = 9 meets every other hypothesis and fails the conclusion, as the not claimed line already says (anything at k ≥ 7)
  minds: 1 — blind, the same model (Opus 5.5): blind to the first mind's argument and verdict; given its side's round-3 statements
  grade: hand

control: v6-hug
  of: FS116-Y4-EMPTY — lemma V6-HUG's identity: the two hugging arcs inward from y_0 and y_1 come within 1, on the grid s, t in 1..60 degrees
  run: python3 ../tools/fs116_v6_hug.py inward
  expect: identity holds; below 1: 3600 of 3600
  fault: python3 ../tools/fs116_v6_hug.py outward

control: v6-sq9
  of: FS116-Y4-EMPTY — the k = 9 control: SQ9 meets every hypothesis but six colours, its ring carries no arc of Γ, and five colours
  run: python3 ../tools/fs116_v6_sq9.py 3
  expect: period 3: 9 colours; least same-colour squared gap 4 half-units^2 (valid and non-Siamese: True); colours at p: 4; Gamma on the ring: 12 points; ring colours: 5; ring colours of p: 0
  fault: python3 ../tools/fs116_v6_sq9.py 2

## Stage 2 — SAVED
