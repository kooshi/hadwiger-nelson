# FS132-E3 — card 1 of FS-132: the two six-colour arguments read against the extraction's data

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E3-card-one-readings.md`. Plan: `plans/FS132-six-by-the-nerve.md`.
The first deriver's record: `plans/FS132-E1-derivation.md` (E0–E5, C132-CONFINE). Scripts and outputs: `data/fs132/e3/`. `M` is
the release's manuscript, `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`
(read, never written).*

## Theorems this phase proved

- **C132-M-ORBIT** — no weak measurable six-colouring carries four exclusion sets through a point for a cycle of four labels
  together with one essential change point of the outside pair's state whose six-fold orbit is free of palettes without an outside
  label — [hand], one mind, kernel pending; § Stage 3, entry and § Argument — the orbit form.
- **C132-M-EXCL** — the same with the ring hypothesis almost everywhere: a centre carrying the four exclusion sets is not binary
  for the outside pair — [derived] from it, one mind; § Argument — the ring form.
- **C132-M-EMPTY** — the existence form's NO as the claim list names it: no extracted centre with a four-cycle has palettes
  almost everywhere containing an outside label — [derived], one mind; § Argument — the fixed form. It reads clauses (1) and (3)
  of the data and nothing else of it.
- **C132-RUN-EMPTY** — the reading: **stalls at V6-HUBS** (GAP at that step: the tile as one connected piece of diameter at most
  1 between two hubs); nine of the route's eleven steps restate and are derived, V6-HUBS and the count of V6-COUNT are replaced
  by a count on the four exclusion sets (C132-M-ORBIT's step M6), and the statement the route was for is derived. § The route,
  step by step.

## Stage 1 — SAVED: the readback

**The job.** Decide, for FS116-V6's route to the empty ring and for the route to FS114-CV-EXISTS, whether each step restates and
is derived for an arbitrary weak measurable six-colouring from the extraction's data (E0–E5), C132-CONFINE and the release's
count-free statements — or name the first step that cannot and what it reads. Each restated step must leave this project's
positives alive and say where the hexagonal seven-colouring escapes.

**Quotation check** (standing rule 3): `data/fs132/e3/readback.py` looks for every quoted line of the brief in its source —
`quotations=14 lines_matched=14 lines_mismatched=0` (`data/fs132/e3/readback.out`); with one character of each line changed it
reports fourteen mismatches. No finding about the brief.

**Read, and how far.** In full: the brief, the standing rules, the plan, the claim list with both dated lines, the first
deriver's record, the stub; `M/angular.tex` (§ 8, whole); `M/palettes.tex` ll. 1–640 (Definition 5.1, Lemma 5.2 with its proof,
Cor. 5.4, Lemma 5.5 with its proof, the opening of Prop. 5.6); `M/transitions.tex` ll. 1–80 and 150–345 (Definition 6.1, Lemma
6.2's statement, Lemmas 6.3 and 6.4 with proofs, Theorem 6.5's statement and its four-cycle opening); `plans/FS116-V6-verification.md`
§§ 1.2–2.3; the entries FS129-SR3-EMPTY-NS and -QFREE-NS; `Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean` (module
docstring, `v6_anti`, `GammaFreeRing.changePoint_gap`, `v6_hubs`, `v6_hug`, `v6_count`, `exists_ne_mem_closure_inter_of_split`,
`emptyNS`); `plans/FS131-L8A-landing.md` draft 7 (the errata); `LEDGER.md` rows 137, 138, 145, 148, 149, 150 whole;
`plans/EXT-OAI2-reading.md` § 4.2 whole, §§ 3.3 and 4.3 in part. Not read: `M/interfaces.tex` (the first deriver's subject);
`RUNNING.md` beyond the rule quoted in the standing rules (my checks are short scripts with planted faults).

**Predictions.** A slip, said plainly: the brief asks for a prediction per reading registered before deriving, and for
C132-RUN-EMPTY I registered none — I read V6 § 2.2 against the data, expected a stall at the steps that read non-Siamese (my
working expectation then, reconstructed and so worth less: *stalls* 0.75, *derived* 0.20, *refuted* 0.05), and found the
argument below while locating the stall. Registered now, before reading its inputs: **C132-RUN-CV** — *stalls at* the
terminal modification 0.85, *derived* 0.10, *refuted* 0.05; **C132-DIAG** holds 0.80; **C132-RADIUS** holds as posed 0.85 (not
expected to be reached).

## Stage 2 — SAVED: recognition on C132-RUN-EMPTY

*`ephodos-recognition`, invoked fresh — after the argument had been found, not before it (the order the workflow asks for is the
other; said as a slip). The stall read: "a result proved only at instances" (the non-Siamese map class) and "a known theorem
that almost applies" (V6's route, whose hypothesis "a tile" fails as the object is described).*

**For the stranger — someone who works on measurable colourings of the plane avoiding one distance.** Six measurable classes
partition a neighbourhood of the closed unit disc about a point `p`, and almost no unit pair lies in one class. Four of the
classes, taken in a cyclic order, come with *exclusion sets*: for each consecutive pair a compact set through `p` such that
neither class of the pair has a point of its essential support nearer than 1 to one point of the set and farther than 1 from
another. In almost every direction, the circles of radius near 1 about centres near `p` carry, with positive weight, one of the
two remaining classes. *Unknown:* can this happen? **This is a binary centre** — the release's own word (`M/palettes.tex:314–318`:
"Call a center `x` *binary for* `{i_+, i_-}` if `P_x(e) ∩ {i_+, i_-} ≠ ∅` for almost every `e ∈ S`") — **carrying four
two-colour exclusions.** What that field holds about binary centres: the selection from the pair alternates under the 60°
rotation (Cor. 5.4); two binary centres for one pair are an absolute distance apart (Lemma 5.5); at a triangle centre of a
five-colouring the selection is constant on six sectors (Lemmas 8.6, 8.7).

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| a tile: a connected open set of diameter at most 1 | **splits** | consumed in V6 at three places; only one consequence is used by the argument below — "an exclusion set of a class present inside the unit disc near `y` lies in the closed unit disc about `y`" (M4), which the data give; the rest (two hubs of one tile are within 1; the interval of distances between two tiles) accompanies: the argument runs without it |
| non-Siamese | accompanies | C132-M-ORBIT's argument runs without it |
| simple; sectors; the cyclic order of tiles at `p` | **splits** | consumed only as "consecutive classes of the cycle share an exclusion set through `p`" — hypothesis (a) |
| `Γ ∩ ω(p)` finite | accompanies | derived, not assumed (M8) |
| six colours | determines | consumed at M2 and M9; at nine colours SQ9's lattice vertex has every other hypothesis (FS116-V6's control `v6-sq9`, not rerun) |
| `e(ψ) + e(ψ + 120°) = e(ψ + 60°)` | determines | consumed at M6; control `three-axes` (its fault forgets the relation and 28 tip patterns appear) |
| the sign of the straddle identity | determines | consumed at M8 and M9; control `hug-shift` (its fault takes the other side and every pair fails) |
| connectedness of the exclusion sets; their limiting directions; clauses (4), (5); isolation of the centre | accompany | never consumed (the argument reads `p ∈ K_j ≠ {p}` and clause (3)) |
| clause (3) | determines by consumption | consumed at M4; no object without it was exhibited — a candidate, said so |

**Homes.** (1) *The release's binary-centre calculus* (§ 5.3, § 8.4) — adopted: Cor. 5.4 and the palette transfer apply with
nothing changed; the case "non-Siamese" stops being special; it predicts a neighbour, derived here: the statement is local to
one six-fold orbit of ring directions (C132-M-ORBIT), which is a pruning rule for rings with (Q) arcs. (2) *This project's ring
calculus* (FS-116, G91) — the costume: its proofs speak of tiles; kept as the source of nine steps and of the straddle identity.
(3) *Lebesgue density on the line* — supplies M8's lemma. **The transfer** is V6's route with one changed step named: V6-HUBS
(a tile's diameter) is replaced by M6 (four exclusion sets against three hub axes), and the hypothesis R-ARC by M8.
**The class**: any weak measurable six-colouring with hypothesis (a); the map classes of rows 148–149 are instances once a map
vertex is shown to carry (a) (not derived here).

## Stage 3 — SAVED: C132-RUN-EMPTY, and the statement it was for

### The entries

derivation: C132-M-ORBIT
  statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
  uses only: weak properness in its measure form; Definition 5.1 (every trace's positive coordinates lie in the palette); Lemma 5.2 assertion (1) read locally (for almost every pair of unit vectors (e, v) with p + e + v in U, c(p + e + v) ∉ P_p(e) ∪ P_p(v)) and Cor. 5.4 (P_p(f) ∩ P_p(Rf) = ∅ for almost every f) — both read in `M/palettes.tex` ll. 118–308 and taken at six labels on the reading's word that their proofs spend no count (`plans/EXT-OAI2-reading.md` § 4.2 rows 2–3; I read both proofs and found no count in them; one mind); of the sets K_j only that p ∈ K_j, K_j ≠ {p}, and the exclusion — E0 as a point, E1 as four labels in a cycle, clause (1) as "K_j is not {p}", clause (3) in C132-CONFINE's first form; the parallelogram law; e(ψ) + e(ψ + 2π/3) = e(ψ + π/3); the unit-pair relation between points near two ring points π/3 apart (M7); Lebesgue density on the line (M8); six labels, at M2 and at M9. It reads nothing of clause (2) (limiting directions), clause (4), clause (5), connectedness of the K_j, isolation of p among cyclic centres, Lemma 6.2, Lemma 8.1, or any tile, sector, arc or finiteness
  not claimed: anything when the palettes near one of the six directions ψ + kπ/3 hold no outside label on a set of positive measure (rings with (Q) arcs at the orbit: FS-124); that a six-colouring with hypothesis (a) exists; that a point whose transition graph contains a four-cycle carries the sets K_j (that is the extraction's, under its hypothesis on the centres); anything at seven labels or more (M2 and M9 spend six); anything about a cycle of three, five or six labels; any value of χ(ℝ²); that a map's four-colour vertex carries the sets K_j (the edge exclusion for maps is row 134's base, not re-derived here)
  argument: § Argument — the orbit form
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence). The hypotheses other than (i)–(ii) are met, as maps, at the held fragments' four-colour vertices (the strip's P0 and P1, the Y2 bowtie's centre: four tiles in cyclic order whose common edges carry the two-colour exclusion — taken from row 134's base and `[SokolovVoronov2025]` Props. 1–2, not re-derived); there (i) fails at every change point: at least two of its four germs at ±60° lie on (Q) arcs (control `positives-escape`). At nine labels SQ9's lattice vertex meets every hypothesis but the count (FS116-V6's control `v6-sq9`, not rerun)
  prior art: partly: the palette calculus is `[OAIMath2026]` §§ 5.1–5.3; steps M1–M5 and M9 are FS116-V6's V6-RING, -GERM, -TIP, -DIAM, -ANTI and -HUG restated in measure (in-house; row 148); M6 and M8 and the statement are not in the release (its § 8 treats the four-cycle only with one outside label); the search for them in print is owed — the plan's §PA of 2026-10-07 found no six-colour form of the release's §§ 5–8, and this job's two queries failed (§ Prior art, this job)
  handoff: de Bruijn — the statement as written, over the release's palettes at `Fin 6` (`Palettes.lean`, `palette_transport_param`, `palette_sixty_disjoint`, each already at every k): hypotheses a weak colouring on an open set containing the closed unit disc, four compact sets through p with the support exclusion, the two-clause ring hypothesis; conclusion False. Leaves in the order of the argument: the chart Z and (⋆); tips exist; confinement; one tip per hub; the three-axes count (finite, 64 cases); the unit-pair relation with its sign; the step lemma; the kill. Read the formal statement back against this one, clause (ii) above all

derivation: C132-M-EXCL
  statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
  uses only: C132-M-ORBIT; Cor. 5.4 once more, to see that a ring whose palettes almost everywhere hold an outside label has an essential change point
  not claimed: what C132-M-ORBIT does not claim; that the centre is binary for no pair at all (only for the pair outside the cycle)
  argument: § Argument — the ring form
  verdict: derived
  grade: derived from: C132-M-ORBIT
  minds: 1
  model: none can exist (a non-existence); the model line of C132-M-ORBIT
  prior art: partly: as C132-M-ORBIT; in the map class and for non-Siamese fragments this is row 149's statement (FS129-SR3-QFREE-NS), proved there through FS-112's bends
  handoff: de Bruijn — as C132-M-ORBIT's corollary; the formal statement to read back is this one

derivation: C132-M-EMPTY
  statement: no weak measurable six-colouring of an open set containing a closed disc of radius above 1 about a point p has, at p, the data of an extracted centre with a cycle of four labels (C132-EXT-DISC's conclusion at p with ℓ = 4: the labels i_0, i_1, i_2, i_3 and the sets K_0, K_1, K_2, K_3 with its clauses (1) to (5)) together with palettes P_p(e) that for almost every unit vector e contain a label outside the cycle
  uses only: C132-M-EXCL with a_j = i_j; of the data, clauses (1) and (3)
  not claimed: what C132-M-EXCL does not claim; that the extraction ever returns ℓ = 4; anything at a centre whose ring is not of that kind
  argument: § Argument — the fixed form
  verdict: derived
  grade: derived from: C132-M-EXCL
  minds: 1
  model: none can exist (a non-existence); the model line of C132-M-ORBIT
  prior art: partly: as C132-M-EXCL
  handoff: none — subsumed by C132-M-EXCL, which crosses

derivation: C132-RUN-EMPTY
  statement: each step of the route FS116-V6 § 2.2 (`plans/FS116-V6-verification.md`: V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP, V6-HUBS, V6-ANTI, V6-HUG, V6-COUNT, read with FS129-SR3-EMPTY-NS's sector form of the last) has a restatement under the dictionary, true of every weak measurable six-colouring of an open set containing a closed disc of radius above 1 about an extracted centre `p` with `ℓ = 4` whose palettes almost everywhere contain a label outside the cycle, derived from the data, the toolkit and that ring hypothesis alone; and the restated steps end in a contradiction — so that no such colouring exists (**C132-M-EMPTY**, the existence form's NO, named here so that it can be derived by another route)
  uses only: § The route, step by step — V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP, V6-ANTI and V6-HUG each have a restatement derived inside C132-M-ORBIT's argument; V6-HUBS has none; V6-COUNT's count consumes V6-HUBS and has none, its last step has one
  not claimed: that C132-M-EMPTY is open or false — it is derived (the entry above), by the nine restated steps with M6 in place of V6-HUBS and of the count; that no restatement of V6-HUBS could ever be derived on its own (after C132-M-EMPTY every statement about the class holds vacuously; the stall is of V6-HUBS's argument, which reads a tile)
  argument: § The route, step by step
  verdict: stalls at: V6-HUBS — "a tile of p tips at most two [change points], and two only if consecutive", whose argument is "a tile's tipped change points are pairwise within distance 1 (V6-DIAM)": the dictionary's left-hand term is the tile as one connected piece of diameter at most 1 holding two hubs in its closure ("the same tile"); the data confine a label's exclusion sets, not the label
  grade: hand
  minds: 1
  model: the configuration the data leave where V6-HUBS stood — a label that is the tip at three consecutive hubs (pattern A of M6) — is not excluded by confinement alone: its two exclusion sets lie within 30° of the middle hub's direction, inside all three closed unit discs
  prior art: owed — the reading is this project's; nothing to search
  handoff: none — a reading; what crosses is C132-M-EXCL

control: hug-shift
  of: C132-M-ORBIT — step M7: the unit-pair relation between points near two ring points 60° apart, the sign of its shift, and the pairs step M9 uses
  run: python3 ../data/fs132/e3/hug_shift.py
  expect: ratio-min=1.1614 ratio-max=1.2411 limit=1.1547 nonpositive=0 bad-pairs=0 axis-below-1e-30=True
  fault: python3 ../data/fs132/e3/hug_shift.py --fault

control: three-axes
  of: C132-M-ORBIT — step M6: every tip pattern on six hubs that is consistent with the three axes has two adjacent hubs of equal tip
  run: python3 ../data/fs132/e3/tau_count.py
  expect: sign-consistent=36 of 64; kind-A=12 kind-B=24; with no adjacent equal tips=0
  fault: python3 ../data/fs132/e3/tau_count.py --fault

control: positives-escape
  of: C132-M-ORBIT — the positives: at every change point of the held fragments' four-colour vertices a germ of the orbit lies on a (Q) arc, so hypothesis (i) fails there
  run: python3 ../data/fs132/e3/positives_check.py
  expect: rings=4 change-points=8 all-four-germs-off-Q=0 least-germs-on-Q=2
  fault: python3 ../data/fs132/e3/positives_check.py --fault

### Argument — the orbit form

*Setting.* Translate so `p = 0`. `e(θ)` is the unit vector at angle `θ` (radians), `S` the unit circle, `R` the rotation by
`π/3`. Write `a` for an *inner* label (one of `a_0, …, a_3`), `A_a` for its class, and call `X`, `Y` the *outside* labels. `K_{j−1}`
and `K_j` are the two *sets of* `a_j`. Suppose `ψ`, `δ` with (i) and (ii) exist; put `ψ_k = ψ + kπ/3` and `y_k = e(ψ_k)`, the
**hubs**. "Almost every" is for Lebesgue measure on the line, the plane, or the three-dimensional space of unit pairs `(z, u)`.

**M0. The toolkit, as read.** (T1) Every trace's positive coordinates lie in the palette almost everywhere
(`M/palettes.tex:104–117`). (T2) Lemma 5.2 (1): for almost every `(e, v) ∈ S × S`, `c(e + v) ∉ P_0(e) ∪ P_0(v)` (`:121–125`).
Its proof (`:140–203`) takes samplings `(y_n, r_n) → (0, 1)`, uses properness between the typical points `y_n + r_n e` and
`y_n + r_n e + v`, and passes to the limit by a change of variables off the parallel pairs; it is label by label, and local:
restricted to an open set of pairs whose sums stay in `U` it reads the colouring only there. (T3) Cor. 5.4:
`P_0(f) ∩ P_0(Rf) = ∅` for almost every `f` (`:296–308`), from (T2)'s third assertion with `f = Rf + R^{−1}f`; the points
involved lie on the unit circle, inside `U`. *Read, not reworked. No count in either proof.*

**M1. The state (V6-RING, restated).** Let `I_k = (ψ_k − δ, ψ_k + δ)`. For almost every `θ ∈ I_k` the palettes at `θ` and at
`θ + π/3 ∈ I_{k+1}` both hold an outside label (i) and are disjoint (T3); so each holds exactly one. This defines
`s : ⋃ I_k → {X, Y}` almost everywhere, with `s(θ + π/3) ≠ s(θ)`, hence `s(θ + 2π/3) = s(θ)`. By (ii) and this alternation, for
every `k` and every `η > 0` both values of `s` have positive measure in `(ψ_k − η, ψ_k + η)`: each `ψ_k` is an *essential change
point*. *Reads: the ring hypothesis, T3. Count: none.*

**M2. The chart, and what lies near a hub (V6-E1 and V6-GERM, restated).** For `|d| < d_0` put
`Z(α, d) = e(α) + e(α − 2π/3 − d)`. Then `|Z| = 2 cos(π/3 + d/2)` — below 1 exactly when `d > 0` — and
`arg Z = α − π/3 − d/2`; `Z` is a diffeomorphism of `(ℝ/2π) × (−d_0, d_0)` onto an annulus about the unit circle; and `e(α)`,
`e(α − 2π/3 − d)` are the two points of `S` at distance 1 from `Z(α, d)`. The points `Z(α, d)` with `α` near `ψ_{k+1}` and `d`
near 0 are the points near `y_k`; write `N_k(κ)` for those with `|α − ψ_{k+1}| < κ`, `|d| < κ`. By (T2) with
`(e, v) = (e(α), e(α − 2π/3 − d))` — a non-parallel pair, on which the sum map is this chart — and by M1, for `κ ≤ δ/2`:

> (⋆) for almost every `(α, d)` with `Z(α, d) ∈ N_k(κ)`: `c(Z(α, d)) ∉ {s(α), s(α − d)}`

(`s(α − 2π/3 − d) = s(α − d)` almost everywhere, M1). Put `W_k(κ) = {Z(α, d) ∈ N_k(κ) : d > 0, s(α) ≠ s(α − d)}`. It lies in
the open unit disc, and by (⋆) almost every point of it carries an inner label — **six is spent here, the first time**: a
label that is neither `X` nor `Y` is one of four. *Reads: T2, M1. In the map: the two unit circles about the ring points 60°
on either side of `y`, and the region `B(u) ∩ B(v)` between them.*

**M3. Every hub has a tip (V6-TIP, restated).** `W_k(κ)` has positive measure for every `κ > 0`: otherwise `s(α) = s(α − d)`
for almost every `α` within `κ` of `ψ_{k+1}` and `0 < d < κ`, so `s(x) = s(y)` for almost every pair `x < y` in
`(ψ_{k+1} − κ/2, ψ_{k+1} + κ/2)`, and `s` is almost everywhere constant there, against M1. So some inner label has positive
measure in `W_k(κ)` for every `κ`. Define

> `Tip(k) = { inner a : y_k lies in the closure of H_a ∩ B(0, 1) }`.

It is non-empty. *Reads: M1, M2.*

**M4. Confinement (V6-DIAM and V6-DICH, in the form the data allow).** Let `a ∈ Tip(k)` and let `K` be a set of `a`. Take
`z_n ∈ H_a`, `|z_n| < 1`, `z_n → y_k`. `z_n ∉ Δ(K)` and `0 ∈ K` is nearer than 1 to `z_n`, so no point of `K` is farther than 1:
`K ⊂ B̄(z_n, 1)` (C132-CONFINE's first clause), and in the limit **`K ⊂ B̄(y_k, 1)`**. For `q ∈ K`, `q ≠ 0`:
`|q − y_k|² ≤ 1` gives `|q|² ≤ 2 q·e(ψ_k)`, so `q·e(ψ_k) > 0`. *Reads: `p ∈ K`, clause (3). In the map: "a tile whose closure
holds `z` lies in `B̄(z)`"; here it is the label's two exclusion sets that lie there, not the label.*

**M5. One tip at each hub, opposite at antipodes (V6-ANTI, restated, and more).** `B̄(y_k, 1) ∩ B̄(y_{k+3}, 1) = {0}`
(`y_{k+3} = −y_k`; `|q − y|² + |q + y|² = 2|q|² + 2`). So a set of a label of `Tip(k)` is no set of a label of `Tip(k + 3)`: it
would be `{0}`, and each `K_j` holds another point. If `Tip(k)` held two labels, their sets would be at least three of the four,
and a label of `Tip(k + 3)` — there is one, M3 — would have a set among them. Hence **`Tip(k) = {a_{τ(k)}}` is one label, and
`τ(k + 3) = τ(k) + 2`**: antipodal hubs are tipped by opposite labels of the cycle. And for an inner `a ∉ Tip(k)` there is `κ`
with `A_a` null in `B(0, 1) ∩ N_k(κ)`. Fix `κ_*` serving all six hubs: almost every point of `B(0, 1) ∩ N_k(κ_*)` carries
`a_{τ(k)}`, `X` or `Y`, and almost every point of `W_k(κ_*)` carries `a_{τ(k)}`. *Reads: `K_j ≠ {p}` (clause (1)), M3, M4. In
the map: "a tile tipping `y_k` and a tile tipping `y_{k+3}` share no edge at `p`"; that each hub has one tip is not a step of
V6, where two antipodal hubs carry two tips each until the last line.*

**M6. Three axes (in place of V6-HUBS and of V6-COUNT's count).** For `k = 0, 1, 2` and each `j`: `K_j ⊂ B̄(y_k, 1)` when `j` is
`τ(k) − 1` or `τ(k)`, and otherwise `K_j ⊂ B̄(y_{k+3}, 1)` (it is then a set of `a_{τ(k)+2}`, the tip at `y_{k+3}`). Pick
`q_j ∈ K_j`, `q_j ≠ 0`; by M4 the sign `σ_{jk}` of `q_j·e(ψ_k)` is `+` in the first case and `−` in the second, never 0. Since
`e(ψ_1) = e(ψ_0) + e(ψ_2)`, no vector has signs `(+, −, +)` or `(−, +, −)` against the three axes. **Then `τ(k) = τ(k + 1)`
for some `k` modulo 6.** *Proof.* Suppose not; write `t_k = τ(k)`, so `t_1 ≠ t_0`, `t_2 ≠ t_1`, and `t_2 ≠ t_0 + 2` (that is
`τ(2) ≠ τ(3)`). Set `j` is `+` at axis `k` when `t_k ∈ {j, j + 1}`. If `t_2 = t_0`: sets `t_0` and `t_0 − 1` are `+` at axes 0
and 2, so both are `+` at axis 1, which forces `t_1 = t_0`. If `t_2 = t_0 + 1`: set `t_0` is `+` at axes 0 and 2, so
`t_1 ∈ {t_0, t_0 + 1} = {t_0, t_2}`. If `t_2 = t_0 − 1`: set `t_2` is `+` at axes 0 and 2, so `t_1 ∈ {t_2, t_0}`. Each
contradicts the supposition. ∎ (Control `three-axes`: of the 64 patterns 36 are sign-consistent and none of them has all adjacent
tips different; they are of two kinds, 12 and 24 — **A**: two opposite labels, each the tip at three consecutive hubs; **B**: two opposite
labels each the tip at two consecutive hubs, the other two at one hub each.) Re-index so that `τ(0) = τ(1)`, and write `a` for
that label. *Reads: M4, M5. Six: not here.*

**M7. The unit-pair relation between two adjacent hubs (the straddle identity of V6-HUG).** Let `z = Z(α, d)` near `y_0` and
`z′ = Z(α′, d′)` near `y_1`, `d, d′ ≥ 0`. With `r = 2cos(π/3 + d/2)`, `r′ = 2cos(π/3 + d′/2)` and
`g = α′ − α − π/3 + (d − d′)/2` (the angle from `z` to `z′` is `π/3 + g`),

> `|z − z′| = 1` ⟺ `cos(π/3 + g) = (r² + r′² − 1)/(2 r r′)`.

The right side is smooth and equals `1/2` at `d = d′ = 0`, so near 0 this reads `g = G(d, d′)`, `G` smooth: `|z − z′| = 1`
holds on `α′ = α + π/3 + d′ + ε(d, d′)`, `ε := G − (d + d′)/2`, independent of `α`. On the axes: for `d′ = 0`, `z′` is the ring
point at distance 1 from `z`, which is `e(α)`, so `α′ = α + π/3` and `ε(d, 0) = 0`; for `d = 0`, `z = e(α − π/3)` is the ring
point `e(α′ − 2π/3 − d′)` at distance 1 from `z′`, so `ε(0, d′) = 0`. Hence `ε = d d′ h(d, d′)` with `h` smooth, and expanding
to second order (`1 − r = (√3/2)d + d²/8 + …`) `h(0, 0) = 2/√3`. So there is `κ_1 ≤ κ_*/3` with

> `0 < ε(d, d′) ≤ min(d, d′)/16` and `|∇ε| ≤ 1/32` for `0 < d, d′ < κ_1`.

(Control `hug-shift`: `ε/(d d′) ∈ [1.161, 1.241]` on a grid of 144 points, tending to `2/√3 ≈ 1.1547`.) The map
`Φ : (α, d, d′) ↦ (z, z′ − z)` is a local diffeomorphism into the space of unit pairs: `(α, d) ↦ z` is the chart, and for
fixed `z` the point `z′` moves along the unit circle about `z` with `|z′| = 2cos(π/3 + d′/2)` strictly decreasing in `d′`. So
null sets and sets of positive measure correspond. In these coordinates, by M1 (the second line shifts both arguments by `−π/3`,
which flips both values):

> `z ∈ W_0` ⟺ `s(α − d) ≠ s(α)`;  `z′ ∈ W_1` ⟺ `s(α′ − d′) ≠ s(α′)` ⟺ `s(α + ε) ≠ s(α + ε + d′)`.

*Reads: plane geometry only. This is `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) < 0` of row 148, as a shift.*

**M8. Every essential change point is a step (in place of R-ARC's "`Γ ∩ ω(p)` is finite").** Almost every point of `W_0(κ_1)`
and of `W_1(κ_1)` carries `a` (M5, M6). Properness and `Φ` give: for almost every `(α, d, d′)` with `|α − ψ_1| < κ_1` and
`0 < d, d′ < κ_1`,

> (†) not both `s(α − d) ≠ s(α)` and `s(α + ε) ≠ s(α + ε + d′)`, `ε = ε(d, d′)`.

**Lemma S.** *If (†) holds almost everywhere, `s` is almost everywhere equal, on `J = (ψ_1 − κ_1/4, ψ_1 + κ_1/4)`, to a
function with at most one jump.* *Proof.* Pass to the coordinates `u = α − d`, `v = α`, `w = α + ε + d′` (a diffeomorphism:
`∂w/∂d′ = 1 + ∂ε/∂d′ > 0`), and write `g_{u,w}(v) = v + ε`, an increasing `C¹` map with `g′ ≥ 7/8`
(`g′ = 1 + ε_d − ε_{d′}(1 + ε_d)/(1 + ε_{d′})`, since `w − v = d′ + ε` with `u`, `w` fixed) and
`0 < g(v) − v ≤ min(v − u, w − v)/16`. (†) says: for almost every `u < v < w`, not both `s(u) ≠ s(v)` and
`s(g_{u,w}(v)) ≠ s(w)`. Suppose the conclusion fails. Then there are Lebesgue density points `a_* < b < c_*` in `J` of the
level sets of `s` with `s(a_*) = s(c_*) ≠ s(b)`; say `s(b) = Y` (the other case is the same with the names exchanged). Let
`m(ρ)` be the proportion of `{s = Y}` in `(b − ρ, b + ρ)`; `m(ρ) → 1`. Let `ρ_1 ≤ min(b − a_*, c_* − b)` be the largest radius
with `m ≥ 3/4` on `(0, ρ_1]`. If `ρ_1 = min(b − a_*, c_* − b)`, put `u_0 = a_*`, `w_0 = c_*`, `ρ = ρ_1/2`. If it is smaller,
`m(ρ_1) = 3/4`, so `{s = X}` has a density point `x_*` within `ρ_1` of `b`; put `ρ = |b − x_*|/2` and take `x_*` for `u_0` or
`w_0` according to its side, and `c_*` or `a_*` for the other. In every case `u_0 < w_0` are density points of `{s = X}`,
`I = (b − ρ, b + ρ) ⊂ (u_0, w_0)`, `{s = Y}` fills at least `3/4` of `I`, and one of `u_0`, `w_0` is within `3ρ` of every
point of `I`, so `g(v) − v ≤ 3ρ/16` on `I` — and at most `ρ/4` for `(u, w)` in a neighbourhood `𝒩` of `(u_0, w_0)`. For such
`(u, w)`: `{s = Y} ∩ I` has measure at least `(3/2)ρ`, its image under `g` at least `(21/16)ρ`, and both lie in an interval
of length `(9/4)ρ`; so they overlap in measure at least `(9/16)ρ`, and `{v ∈ I : s(v) = Y, s(g(v)) = Y}` has positive measure.
The pairs `(u, w) ∈ 𝒩` with `s(u) = s(w) = X` have positive measure (density points). On the resulting set of triples, of
positive measure, `s(u) ≠ s(v)` and `s(g(v)) ≠ s(w)`: against (†). ∎

By M1, `s` is not almost everywhere constant near `ψ_1`, so **`s` is a step at `ψ_1`**: for some `κ_2 ≤ κ_1/4`, `s = V` almost
everywhere on `(ψ_1 − κ_2, ψ_1)` and `s = V′` on `(ψ_1, ψ_1 + κ_2)`, `{V, V′} = {X, Y}`. *Reads: M5, M6, M7, properness.
Six: through M5's use of M2. In the map this is a hypothesis (the ring carries no arc of `Γ`, and maps are locally finite); here
it is a consequence, and nothing is assumed of the ring beyond (i) and (ii).*

**M9. The kill (V6-HUG, restated; with M2 for V6-GERM).** Let `κ_3 ≤ κ_2/32`.
(a) *`A_a` is null on `V_0 = {Z(α, d) : ψ_1 − κ_3 < α < ψ_1, 0 < d < κ_3}`* — the points near `y_0` inside the unit disc about
`p` and outside the closed unit disc about `y_1`. For such a point put `h = ψ_1 − α`; for every `d′ ∈ (h, 16h)`,
`ε(d, d′) ≤ d′/16 < h < d′ + ε`, so `α + ε < ψ_1 < α + ε + d′` and `z′ ∈ W_1` (M7, M8): an interval of unit partners in
`W_1`, almost all of colour `a`. A positive measure of such `z` in `A_a` would give a positive measure of unit pairs in `A_a`.
(b) By M5 almost every point of `V_0` carries `a`, `X` or `Y`; by (a) not `a`; by (⋆) not `s(α) = s(α − d) = V`. So **`V_0` is
almost everywhere `V′`** — six spent, the second time.
(c) *`A_a` is null on `V_1 = {Z(β + π/3, d′) : ψ_1 < β − d′, β < ψ_1 + κ_3, 0 < d′ < κ_3}`* — the points near `y_1` inside the
unit disc about `p` and outside the closed unit disc about `y_0`: with `h′ = β − d′ − ψ_1` and any `d ∈ (h′, 16h′)`, the
partner `z = Z(α, d)`, `α = β − d′ − ε(d, d′)`, has `α > ψ_1` (as `ε ≤ d/16 < h′`) and `α − d < ψ_1`, so `z ∈ W_0`. By (⋆) at
`y_1`, the excluded outside label is `s(β + π/3) = s(β − d′ + π/3)`, the flip of `V′`, which is `V`. So **`V_1` is almost
everywhere `V′`**.
(d) The set `{(α, d, d′) : 0 < d, d′ < κ_3/2, ψ_1 − ε(d, d′) < α < ψ_1}` is open and non-empty, because `ε > 0`. On it
`z = Z(α, d) ∈ V_0`, and `z′ = Z(α + π/3 + d′ + ε, d′) ∈ V_1` (its `β − d′` is `α + ε > ψ_1`), and `|z − z′| = 1`. By `Φ` this is
a set of unit pairs of positive measure whose two points both carry `V′` almost everywhere. That contradicts properness. ∎

### Argument — the ring form

Let `U`, `p`, `c`, the labels and the `K_j` be as in C132-M-ORBIT and suppose almost every palette `P_p(e)` holds `X` or `Y`.
Then (i) holds for every `ψ` and `δ`. As in M1, almost every palette holds exactly one outside label, `s(e)`, and
`s(Re) ≠ s(e)` almost everywhere; so `s` is not almost everywhere constant on the circle. The set of `θ` near which `s` is
almost everywhere constant is open; were it the whole circle, `s` would be almost everywhere constant by connectedness. So some
`ψ` has both values of `s` of positive measure in every neighbourhood: (ii). C132-M-ORBIT forbids it. ∎

### Argument — the fixed form

An open set containing a closed disc of radius above 1 about `p` contains the closed unit disc about `p`. The data of an
extracted centre with `ℓ = 4` include four distinct labels `i_0, …, i_3` and compact sets `K_j ∋ p` meeting `∂B(p, ρ)`, `ρ > 0`
(clause (1): so `K_j ≠ {p}`), with `H_{i_j} ∩ Δ(K_j) = H_{i_{j+1}} ∩ Δ(K_j) = ∅` (clause (3)). With six labels, the labels
outside the cycle are two. C132-M-EXCL applies with `a_j = i_j`. ∎

### The route, step by step

*Each row: the step as FS116-V6 § 2.2 has it (its bold sentence, or its first, quoted); the restatement under the dictionary;
what the restatement reads; where it is derived. "Data" is E0–E5 of the first deriver's list.*

| step | the map statement | restated | reads | verdict |
|---|---|---|---|---|
| V6-DIAM | "A tile has diameter at most 1; so a tile whose closure holds `z` lies in `B̄(z)`." | for `z ∈ H_a`, `a` a label of the cycle, each set `K` of `a` lies in `B̄(z, 1)` or misses `B(z, 1)`; it lies in `B̄(z, 1)` when `|z − p| < 1`, and when `z` is a limit of such points | E0, E4 (clause (3)); C132-CONFINE | **derived** (M4). Weaker than the map statement in a named way: it confines the label's two exclusion sets, not the label |
| V6-E1 | "An interior point `x` of a tile of colour `c` is at distance `≠ 1` from every point `z` of the closure of a tile `T` of colour `c`." | for almost every pair of unit vectors `(e, v)`, `c(p + e + v) ∉ P_p(e) ∪ P_p(v)`; and almost no unit pair lies in one class | the toolkit (Lemma 5.2 (1)); properness | **derived** (M0, M2's (⋆)). The literal form "a density-one point of class `c` is at distance `≠ 1` from every point of `H_c`" is not claimed and not needed: every use of V6-E1 in the route is a use of (⋆) |
| V6-DICH | "in a non-Siamese fragment, a tile of colour `c` having an interior point within distance `< 1` of a point of `cl T`, `T` of colour `c`, is `T` itself" | first sentence (the distances between two tiles of one colour miss 1): C132-CONFINE's dichotomy. Second sentence: **no counterpart** (the dictionary assumes none for non-Siamese) | E4 | first sentence **derived**; the second is the class hypothesis, used in the route at V6-RING (four tiles: here `ℓ = 4` is given), V6-TIP (here M4 does its work), V6-HUBS (not replaced: the stall) and V6-HUG (not needed: M5 gives the one tip) |
| V6-RING | "exactly two, `X` and `X̄`, are absent, `p` has exactly four colours … `κ(θ + 60°) ≠ κ(θ)`, so `κ(θ + 120°) = κ(θ)`" | almost every palette holds exactly one outside label `s(e)`; `s(Re) ≠ s(e)`, `s(R²e) = s(e)` | the ring hypothesis; Cor. 5.4 | **derived** (M1). Its opening "By R-ARC, `Γ ∩ ω(p)` is finite" is a hypothesis of the map class; here it is a conclusion (M8), reached after M2–M7 |
| V6-WIN | "The change points … form a set invariant under the rotation `σ` by 60° … so `m` is odd." | the essential change points of `s` are a non-empty closed set invariant under `R`; each is a step (M8), so they are finitely many | M1, M8 | **derived**; the parity of `m` is not used |
| V6-GERM | "There is a neighbourhood `N` of `y` in which interior points of `X`-tiles lie in `B̄(u) ∖ B(v)` and interior points of `X̄`-tiles in `B̄(v) ∖ B(u)`." | (⋆): near a hub, `c(Z(α, d))` is neither `s(α)` nor `s(α − d)` | Lemma 5.2 (1), M1 | **derived** (M2); no step at `u`, `v` is needed for it |
| V6-TIP | "Every change point `y` has a tip, and every tip at `y` lies in `B̄(y)`." | `Tip(k) ≠ ∅` at every hub; for `a ∈ Tip(k)` both sets of `a` lie in `B̄(y_k, 1)` | (⋆), six labels; clause (3) | **derived** (M3, M4). The dictionary's "tip" (a label with `y ∈ H_c`) is too wide — it also holds of a label present only outside the unit disc about `p`; the term that carries the step is `y ∈ cl(H_c ∩ B(p, 1))` |
| **V6-HUBS** | "`m = 1`: the change points are `y_k = r(ψ₀ + 60°k)`, six of them; a tile of `p` tips at most two, and two only if consecutive." | "a label of the cycle is the tip at at most two hubs of an orbit, and at two only if they are adjacent"; "the essential change points are one orbit" | "a tile's tipped change points are pairwise within distance 1 (V6-DIAM)": **the tile as one connected piece** | **no derived restatement — the stall.** What the data give instead: a label's tipped hubs lie in an open half-circle (M4), and one label tips each hub (M5); pattern A of M6 (a label at three consecutive hubs) meets both. `m = 1` is not derived and not used: the argument runs at one orbit |
| V6-ANTI | "A tile tipping `y_k` and a tile tipping `y_{k+3}` share no edge at `p`." | the tips at `y_k` and `y_{k+3}` share no exclusion set; so they are opposite labels | clause (1) (`K_j ≠ {p}`), M4 | **derived** (M5) |
| V6-HUG | "No tile `T` of `p` tips both `y_0` and `y_1` while being the only tip at each." | no label is the tip at two adjacent hubs (the tip at a hub is one label, M5) | (⋆), M5, M7, M8; six labels; properness | **derived** (M9). The map proof's "two tiles with interior distances on both sides of 1" becomes a set of unit pairs of positive measure between the two flanking regions; no connectedness is read |
| V6-COUNT | the count (`M = 4`, `s = 2`, two antipodal hubs with two tips each); then "at least two share an edge at `p`, against V6-ANTI" | the count consumes V6-HUBS's "consecutive only": **no restatement**. Its last step: adjacent labels share a set (the cycle), against M5 | — | the count **replaced by M6**; the last step **derived** (inside M5) |

**The verdict, read against the claim's grammar.** The first step, in the route's order, with no derived restatement is
**V6-HUBS**; the left-hand term it reads is *a tile of `p`* as one connected piece of diameter at most 1 with two hubs in its
closure — the dictionary's "same tile", for which the measurable side has confinement of the label's exclusion sets and nothing
of the label. **That step is not needed.** The data confine each of the four exclusion sets to one side of each of three axes
through `p`; the 60° relation among the axes leaves two patterns of tips; both have two adjacent hubs with one tip; and V6-HUG's
restatement kills that. So the reading's statement ends where it was meant to: **C132-M-EMPTY is derived**, with
nine of eleven steps restated, one replaced, one (the count) dissolved.

**What a map supplied at the stall, and why the measurable side does not miss it.** In the non-Siamese map class, pattern A dies
by V6-DIAM (hubs two apart are `√3` apart) and pattern B by V6-HUG; V6-COUNT sorts the patterns by counting tiles. On the
measurable side there is no tile to count, and G86 says a count could not see Siamese pairs anyway; M6 counts exclusion sets,
which are four whatever the class.

### The two checks

**The positives.** Row 138's fragments and row 148's, read as measurable colourings of their discs: at the strip's P0 and P1,
the disk's corner and the Y2 bowtie's centre the ring carries (Q) arcs (four, four, four, two), on which the palette is a pair
of the vertex's own colours, so the ring hypothesis of C132-M-EXCL fails; and at each of their eight change points at least two
of the four germs at ±60° lie on (Q) arcs, so hypothesis (i) of C132-M-ORBIT fails too (control `positives-escape`, over
FS116-N1's float survey; outputs kept in `data/fs132/e3/n1_ring_summary.out`, `n1_ring_germ.out`). Row 148's six-colour vertex has
no outside label. Step by step: M1 needs the ring hypothesis and is silent there; M2's (⋆), M4 and M7 are true of every
colouring; M3, M5, M6, M8, M9 are statements about hubs of an orbit meeting (i), of which the positives have none. Nothing held
is excluded. *What the orbit form does forbid, in the map's words:* a change point of a four-colour vertex's ring such that
near each of the six ring points 60°·k from it the ring carries no (Q) arc — in the non-Siamese class and outside it. The Lean
library holds no fragment with two adjacent change points of this kind either (`plans/FS131-L8A-landing.md` draft 8, "two
change points 60° apart … held by no fragment").

**The hexagonal seven-colouring.** It escapes twice. It has no centre with a cycle of four labels (its cyclic centres are its
vertices, each a triangle: the first deriver's control `hex7-model`), so hypothesis (a) is not met at any point. And seven is
one label too many at exactly the two places six is spent: at M2 a seventh label may fill `W_k`, so hubs need no tips (V6's own
"where six is spent"); at M9 it may fill the flanking regions `V_0`, `V_1`. M1, (⋆), M4, M5's first sentence, M6's geometry, M7
and Lemma S hold at every number of labels.

### What this bears on, not entered (for the coordinator)

- **FS-123 (the Siamese class).** C132-M-EXCL has no Siamese clause. For a valid six-coloured fragment in which four tiles of
  four colours at `p` meet in a cycle (each consecutive pair sharing an edge at `p`) and the ring carries no (Q) arc, it gives
  the exclusion with Siamese pairs allowed — **given** that a map's edge carries the two-colour exclusion in the form of clause
  (3) and that a map's palette is its ring read two-sidedly. Both are standard here (row 134's base; the reading § 3.3) and
  neither was derived by this job. Not covered: a vertex whose tiles around `p` contain no such cycle (colours `0, 1, 0, 2, 0, 3`
  about `p`, possible only with Siamese pairs), where the transition graph at `p` is a tree.
- **Row 149.** The same remark gives FS129-SR3-QFREE-NS by a route with no bends (the palette reads a non-(Q) ring arc as it
  stands). A second route to a one-mind row, itself one mind.
- **FS-124 (the (Q) ring).** C132-M-ORBIT is a pruning rule there: every essential change point of the outside state has a
  set of positive measure of palettes without an outside label within any `δ` of some point of its 60°-orbit.
- **The road to seven.** With C132-M-EMPTY the open statements at six are, in the measurable vocabulary: the hypothesis on the
  centres for the extraction; a centre that is not a triangle (card 3); four-cycle centres whose ring is not binary; five- and
  six-cycles. The map step is not on the road to the binary four-cycle's exclusion.

### Prior art, this job

Two queries, 2026-10-07 about 05:30 UTC, both failed: the arXiv API (`all:"chromatic number of the plane"`, newest first) answered 301 and then
nothing within 30 s; the zbMATH Open API (`("measurable coloring" | "measurable colouring" | "measurable chromatic number") & plane &
py:2024-2026`) answered 503, as it did for the first deriver. **A prior-art debt**, with the plan's: the statements of this record
were not searched for in print. The release is three days old; the plan's §PA found no six-colour form of its §§ 5–8.

## Stage 4 — (not yet saved)
