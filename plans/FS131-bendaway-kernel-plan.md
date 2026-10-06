# FS131-KA1 — the outward collar bend planned (`bend_away_part`): the record

*de Bruijn, the planner, on branch `fs131-w5a` (at `78eba0b4` when the job began). Brief: `data/fs131/briefs/FS131-KA1-bend-away.md` (on
`main`'s tree). Working files: `data/fs131/ka/`. Tools: `tools/fs131_ka_*.py`.*

## Theorems this phase proved

Six kernel-checked lemmas and four theorems proved from open children: the list is at the end of Stage 3 ("Theorems this phase proved
(the list the head of this record points to)").

## Stage 1 — SAVED (FS131-KA1): the readback, the as-given build, what I plan and what I may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ka_quotes.py` (IA1's checker copied under this job's prefix) on the brief: **19 quotations, 0 failures**, exit 0
(`data/fs131/ka/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ka/quotes-selftest.txt`: "19 quotations, 1 failures", "SELF-TEST: FIRED (good)"). No mismatch.

### 1.2 Read for this job

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building.
- `BendStep.lean` whole (341 lines); IA1's record `plans/FS131-arcstep-implementation.md` whole (Stages 1–4); inventory items 433–434, 437–438.
- The toward bend's modules: `RadialPush.lean` l. 1–260 and 692–825 in full and the rest by statement; `CollarMap.lean` l. 1–250 in full and
  the rest by statement, with `CollarFit.map`, `map_lens`, `map_agreesOff`, `map_valid`'s routes; `Pushforward.lean` by statement (its header in
  full); `BendCollar.lean` l. 239–605 in full (the collar's choice: `collarK_thin`, `exists_lens_clear`, `branch_transversal`,
  `branch_tangent`, `exists_end_free`, `exists_collar_free`, `exists_collarFit`) and the rest by statement.
- `UnitArc.lean`: `cutArcs` and its lemmas, `toward_clear`, `away_clear`, `away_lens_clear`'s head, `r2Contacts`, `bend_away_whole`'s statement
  and opening, the `n2_env_*` statements, `isoFrag`.
- `plans/FS131-E5-derivation.md` Stage 4 whole (§§ 4.1–4.4) and §§ 2.4–2.5; `plans/FS112-N-proof.md`'s rows N2-AWAY and N2-TAN (the two quoted
  rows; stage N2-3's prose **not read beyond them** — E5's Stage 4 restates the argument with the exact threshold, and I re-derived the
  clearance from it, § 2.3).
- `fs131-w4ba` at `71cca146`: `bend_away`'s statement and docstring (`git show`); it adds no lemma about `r2Contacts` beyond this branch.
- **Not read**: `plans/FS131-collar-kernel-plan.md` and `plans/FS131-collar-C-implementation.md` beyond what the four modules' docstrings quote
  of them (the modules are the plan as landed; budget).
- Definitions read at their sources: `ArcMap`, `Γ`, `interiorPts`, `region`, `coloursAt`, `Valid`, `IsPlaneMap` (`Plane/ArcMap`); `OnRingArc`,
  `innerColours`, `outerColours`, `IsRingArc` (`Plane/LocalMap`); `HasDegree`, `HasRepeatedColour`, `hornSet`, `IsHorn`, `radiusTwoArc`, `IsR2Arc`,
  `AgreesOff`, `RingArcsWithin` (`ValidMap/Basic`); `LocalStep` (`Limit`); `HasHornCount` (`OpenMove`); `IsSectorChart`, `isSectorChart_of`
  (`LocalStructure`); `Near`, `exists_near`, `germArc` (`Surgery`); `Near.sector_eq_hornSet_iff`, `Near.hasHornCount_chart` (`OpenMove`).

### 1.3 The as-given build (`78eba0b4`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1789 modules already up to date, nothing built,
3 modules with warnings, exit 0** (`build/gate/build/20261006T051724Z-1269351.log`; driver log `data/fs131/ka/build0.log`). The five warnings
are `declaration uses 'sorry'`: `BendStep` l. 285 (`CollarFit.map_hornCount_le`), l. 307 (`bend_away_part`); `Procedure` l. 795, l. 812;
`Terminal` l. 3592 — IA1's Stage 4 state.

### 1.4 What I am planning, and what I may change

**Planning**: the proof of `bend_away_part` (`BendStep.lean` l. 307) — on a valid plane map, the away bend of a constant-sided unit arc whose
inner colour is absent at the centre, everywhere but on its radius-2 contacts, as the image of the map under a homeomorphism supported in a
collar — laid out as named children with `sorry`; and the second open child `CollarFit.map_hornCount_le` (l. 285).

- **May**: `BendStep.lean` (the two open children's proofs; `bend_away_part`'s statement only after a message to Keryx — except the horn
  clause, pre-ruled, item 438 (b)); new modules upstream of `BendStep`, with `Proofs.lean` and `ARCHITECTURE.md`; **new declarations only** in
  `RadialPush`, `CollarMap`, `Pushforward`, `BendCollar`, `UnitArc`; a block "FS131-KA1" in `scripts/Axioms.lean` above `=== PURCHASED ===`;
  this record; `tools/fs131_ka_*.py`; `data/fs131/ka/`; the report.
- **May not**: any landed statement or definition; `Procedure.lean`, `Terminal.lean`, the move modules, `main`; a merge; the gate. No `axiom`,
  no `native_decide`.

## Stage 1 — SAVED (FS131-KA1)

## Stage 2 — SAVED (FS131-KA1): the statement attacked — no clause is false; the horn clause weakened (pre-ruled); what the proof needs that the docstring did not say

Grade of everything in this stage: **[hand], one mind (mine), with E5's Stage 4 for the end case** — no kernel check yet. The clauses are
numbered in the order of `bend_away_part`'s conclusion (`BendStep.lean` l. 310–325).

### 2.1 Point (i) — R1 at an interior pinch point: holds; the worry is void

*The worry* (item 433): at an isolated radius-2 contact `g ∈ (θ₁, θ₂)` two lenses meet at `x = r(g)`, "and unit arcs about other centres may
pass through". *They do not, in `F` or in `M`.* In `F`: `hfree` at `g` gives `r > 0` with `F.Γ ∩ ball x r ⊆ sphere P 1`; a unit arc about
`Q ≠ P` through `x` would put a non-degenerate arc of `ω(Q)` into `ω(P)`, and two unit circles meet in at most two points
(`Arc.finite_inter_sphere_or_eq_circ`, as in `radiusTwoArc_disjoint_openArc`). In `M`: near `x`, `M.Γ = h(F.Γ)` lies on the two lens circles
(radius `R > 1`, tangent to `ω(P)` at `x`) and on `ω(P)`; a unit circle about `Q ≠ P` meets each in finitely many points. About `P` itself: an
`M`-ring arc with `x` as an interior angle would hold points `r(g ± s)` of a bent gap, which are interior points of `M` (colour `c`). So no
`M`-ring arc has a pinch point as an interior angle, and one with `x` as an end angle has its interior angles off the collar, where `M = F`.
**In the construction planned below a pinch point is an end of each adjacent gap, and R1 at an end is the toward bend's argument unchanged**
(`CollarFit.sides_end`, `exists_one_side`: near an end the collar's crescent lies on one side of `ω(Q)`, `Q ≠ P`, and both its halves keep
their colours and keep the end in their closures; `CollarFit.map_R1`). Nothing new is needed at a pinch.

### 2.2 Point (ii) — the horn clause: weakened to the arc step's form (pre-ruled, inventory item 438 (b))

`(∀ z j, M.HasHornCount (h z) j ↔ F.HasHornCount z j)` becomes **`(∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j')`** — the clause
`exists_arcStep` states and `CollarFit.map_hornCount_le` proves for the toward bend, at the same point `x` in both maps, so one assembly reads
both bends through one clause. The iff through `h` is also true by hand (both counts are `0` at the moved points), but nothing reads it, it
costs two more facts (`F`'s count at interior points and on the open arc), and the weak form composes over the gaps as well as the iff does.

### 2.3 Point (iii) — every other clause, against N2-AWAY, N2-TAN and E5's end case

**The construction the plan takes** (it differs from the docstring's in one way: the gaps are bent one after another, each by the mirror of
the toward collar bend applied to the map the previous bends produced; the docstring composes the pushes on `F`). A *subdivision*
`θ₁ = b₀ < … < b_m = θ₂` with each open piece `(b_i, b_{i+1})` wholly in `C₂ = {θ : P + 2e(θ) ∈ closure (region c)}` or wholly off it (§ 2.4).
A piece in `C₂` is left alone. A piece `(a, b)` off `C₂` — a *gap* — is bent by the radial push about `P` across the collar
`collarK P a b (1 − τ) (1 + τ)` (the toward bend's collar, the same set) sending `ω(P)` to the lens curve `t = outerProf a b (1 + τ/2) θ`:
the two circles of radius `R = 1 + τ/2 > 1` that enclose `ω(P)` and touch it at `r(a)` and `r(b)`. The lens `{1 ≤ t < outerProf}` takes the
inner colour `c`.

| clause | true? | why (the hand argument; "mirror" = the toward bend's proof with the lens outside) |
|---|---|---|
| 1 `M.Valid` | yes | per gap: `M.region c = F.region c ∪ lens`, the other classes shrink or stay. (a) lens–lens: two points of an outward lens, or of two lenses over one arc of at most 60°, are closer than `1` — **not** the toward bend's reason (there the lens is inside `B̄(P, 1)`); here `|z₁ − z₂| ≤ (t₁ − 1) + (t₂ − 1) + 2 sin(Δ/2)` with `t_i − 1 ≤ (R − 1)u_i²` (`tangRad_sub_one_le`) and `2 sin(Δ/2) ≤ 1 − (√3/π)(u₁ + u₂)` for `Δ ≤ π/3 − u₁ − u₂`, so it holds for `R − 1 ≤ 1/8`. (b) lens against `F.region c`: § 2.5. |
| 2, 3 `K` compact, within `ε` | yes | `K` = the union of the gaps' collars; `isCompact_polarSet_Icc`, `collarK_thin` |
| 4 `F.Γ ∩ K ⊆ α` | yes | per gap `exists_collar_free` **as it stands** (the collar is the toward bend's; a gap is a ring arc — a sub-arc; `hfree` restricts; `exists_end_free` holds at any point of the domain, so at a gap end interior to `α` too) |
| 5 `LocalStep F M K` | yes | per gap, IA1's W1, W2 on `cutArcs` and the lens arcs inside `K`; over the gaps, `LocalStep` composes on the union (checked clause by clause, § 3) |
| 6, 7, 8 `h` off `K`, `K` into itself, `Γ` off `α°` fixed | yes | mirror (`pushHomeo_eq_self`, `homeo_mem_collarK`, `homeo_fix_Γ`); they compose |
| 9, 10, 11, 12 interior points, colours, degrees, repeated colours carried | yes | generic for the image of a map under a homeomorphism (`pushforward_*`, `pushforward_hasDegree`) — no geometry |
| 13 horn | yes, in the weak form | § 2.2, § 2.6 |
| 14 `RingArcsWithin` | yes | mirror: the lens curve has radius `R ≠ 1` |
| 15 R1 | yes | § 2.1; mirror of `map_R1` |
| 16 R2 | yes | mirror of `map_R2`; an arc disjoint from `α°` is disjoint from each gap |
| 17 fixed, or interior of colour `c` | yes | a gap angle: the lens holds `t = 1`; another angle: `r(θ) ∈ Γ` off every gap's open arc, fixed |
| 18 what is left on `ω(P)` is in contact intervals | yes | an `M`-arc of `ω(P)` through `r(θ)` misses the bent gaps, so all but finitely many (the subdivision points) of its angles in `(θ₁, θ₂)` are in `C₂`, and `C₂` is closed |

**E5's end case, read against the collar form.** The lens circle at a gap end `A = r(a)` is E5's `β` with `κ = 1/R ∈ (0, 1)`; it lies on `P`'s
side of the tangent line at `A` (Claim E's hypothesis), so the far class beyond the end is never within `1` of the lens — at an end of the
arc *and* at a gap end interior to `α`, where "beyond" is the neighbouring piece (a contact interval hugging the radius-2 circle, or another
gap). E5's threshold `κ > κ_Y/(1 − κ_Y)` reads `R < ρ_Y − 1` for a far tile bounded on the gap side by a germ of radius of curvature
`ρ_Y > 2` at `q_A`; since `R = 1 + τ/2`, it is "`τ` small". The brief's reading — the lens between `ω(P)` and the unit circle about the
contact — is necessary and **not sufficient**: a far tile bounded by the tangent line at `q_A` forces the lens under the tangent line at `A`,
one bounded by a circle of radius `ρ_Y` under the circle `Σ_Y` of radius `ρ_Y − 1`. E5's § 4.2 has this; the docstring's "(at a contact end
the lens must lie between `ω(P)` and the unit circle about the contact, FS112-ISO)" understates it. No clause changes.

### 2.4 What the proof needs that the docstring does not say (each true by hand; none changes the statement)

- **N-a. The gaps are finitely many — this is where `hP` is used, and it needs a chart argument.** `[θ₁, θ₂] ∖ C₂` could have infinitely many
  components off the domain (inventory items 290–291). On the domain: at each `w₀ = P + 2e(θ₀)`, `θ₀ ∈ [θ₁, θ₂]`, and each side inside the
  arc's range, the open crescent between the radius-2 circle and a slightly larger circle tangent to it at `w₀` is free of `Γ` (the
  radius-2 form of `exists_end_free`: a germ across the tangent leaves the crescent, one along it has its curvature pinned), connected, so of
  one colour `j`; the radius-2 points next to `w₀` on that side are contacts iff `j = c` (inside the radius-2 circle and on it the class is
  absent near them: `ne1_region` against the inner side of the arc, `r2_notMem_region`). So `C₂` is locally all-or-none on each side, and a
  finite subdivision exists by compactness. **No hand derivation of this was on file beyond one line** (IA1: "`C₂` is a finite union of points
  and intervals on a plane map (`Arc.finite_inter_sphere_two_or_subset`)"; E5: "by `hdom` and local finiteness … (I4n's route item (1); N2-TAN)");
  the argument above is mine, hand, one mind. It is a routine local-structure step, not new mathematics, so I plan it rather than send it to a
  deriver; it is the child `r2_side_dichotomy`.
- **N-b. E5's § 4.2 premise comes from the same dichotomy**: in the "none" case the crescent holds no point of `c`, which is "the far class on
  the gap side lies beyond `Γ_Y`" with `ρ_Y` the crescent's outer radius. One lemma serves N-a and the clearance.
- **N-c. "Far" does the work E5 assigns to "outside `B(P, 2)`"**: a far point (at distance `≥ 1` from every point of the closed gap arc) whose
  angle is in the gap's range is at distance `≥ 2` from `P`. The inner colour need not fill a neighbourhood inside `ω(P)` near an end of the
  arc (an inner horn there leaves it only a cusp), so the fact cannot be had from the inner side; it is had from "far".
- **N-d. Lens–lens** (clause 1's (a) above): a new real inequality; the toward bend's `dist_lt_one_of_mem_polarSet` does not cover it.
- **N-e. The horn count at the lens's corner and at an end** (§ 2.6): the toward bend's degree proof avoided every chart; the horn count
  cannot (it is metric).

### 2.5 Clause 1's (b): the gap's lens is clear for `c` (the mirror of `exists_lens_clear`, with E5's two lemmas)

For a gap `(a, b)` (no contact at an interior angle), `z = P + t e(φ)` in the open lens, `y ∈ F.region c` with `|y − z| = 1`: by `n2_sign` on the
gap `y` is *near* (closer than `1` to every interior point of the gap arc) or *far*. Near: `y ∈ B̄(r(a), 1) ∩ B̄(r(b), 1)`, off `B(P, r)` (`hin`),
so `|y − z| < 1` for a thin lens (`n2_env_near_away`, as it stands). Far: `y` is within `r` of the radius-2 arc over the gap (`n2_env_away`, as
it stands); the arc minus small discs about its two ends is compact and misses `closure (region c)` (the gap), so for small `r` the point `y`
is within `η` of an end `w = P + 2e(a)` (say). In the frame at `A = r(a)`: if `y` is beyond the end, `|y − z| > |y − A| ≥ 1` (**Claim E**, no
smallness); if on the gap side, `|y − P| ≥ 2` (N-c), so by the dichotomy's "none" case `|y − O| ≥ ρ₀` for the crescent's outer circle
`∂B(O, ρ₀)`, `ρ₀ > 2`, and `|z − O| < ρ₀ − 1` once `R ≤ ρ₀ − 1` (**END-CAP**, the triangle inequality), so `|y − z| > 1`. The "all" case
cannot occur at a gap's end on the gap's side. `bend_away_whole`'s hypothesis `Disjoint (radiusTwoArc …) (closure (region c))` is the
special case with no contact at either end.

### 2.6 The horn clause, for both bends (`CollarFit.map_hornCount_le` and the gap's)

By the place of `x`: off the collar the maps agree near `x` (a ball form of `hasHornCount_iff_of_agreesOff`, which sits in `Procedure`,
downstream); in the collar and not an end, `x` is interior in `M` (count `0`) or on the lens curve, where `Γ_M` lies on two circles that are
not tangent at `x`, so no two germs share a direction (count `0`); at an end, `M`'s chart is `F`'s with one germ's curvature moved from `±1`
to `±1/R` inside a crescent `F.Γ` misses, so the germs keep their order and their directions, and the count — the number of consecutive
germs with one direction (`Near.sector_eq_hornSet_iff`) — is the same. Children H1–H4, § 3.

### 2.7 Sent to Keryx (one message, at this stage)

No clause false; the horn clause in the weak form; IA1's W1 and W2 are needed inside `bend_away_part`'s own `LocalStep` clause, so I state them
upstream (`LocalStep` for a cut-and-two-arcs map) and FS131-IA2 should not restate them; the clause family is otherwise unchanged.

## Stage 2 — SAVED (FS131-KA1)

## Stage 3 — SAVED (FS131-KA1): the skeleton, the plan per child, the two modeling passes, the inhabitant, the handoff

### 3.0 The statement as it now stands, and the two weakenings (both pre-ruled)

`bend_away_part` (`BendStep.lean`) keeps IA1's hypotheses and clauses, with two clauses weakened, each under a ruling that needs no round
trip:
- **the horn clause** (item 438 (b)): `(∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j')`;
- **the last clause** (item 444, Keryx's message of this job: the arc step's interface `ArcBend` on `fs131-w5y` reads "only the contact at
  the angle itself"): `(∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) → P + 2 * e θ ∈ closure (F.region c))`, in place of the non-degenerate
  interval of `r2Contacts`. Why I took it: the interval costs angle arithmetic at the junctions that no reader uses; the pointwise form
  is one accumulation argument.
Kept though `ArcBend` does not read them, because the construction gives them free: `IsCompact K`, `∀ z ∈ K, h z ∈ K`, and both
directions of the interior-points, degree and repeated-colour clauses (`pushforward_*`).
**`bend_away_part` is proved** from the children below (no `sorry` in its own proof).

### 3.1 The modules (all new but `BendStep`; `Proofs.lean` and `ARCHITECTURE.md` rows in the same commit)

```
RadialPush ── LensOut ──┐
CollarMap ──────────────┴─ CollarMapOut ──┐
Limit, UnitArc, OpenMove ── BendAway ── R2Cap (also BendCollar) ──┼─ BendGap ── BendStep
OpenMove, Pushforward ── HornChart ───────┘
```

| module | lane | holds |
|---|---|---|
| `Plane/ValidMap/BendAway` | D | `AwayBend` (the clause package), `R2Subdiv`, `LocalStep.union` (proved), `LocalStep.of_cutArcs`, the composition children |
| `Plane/ValidMap/LensOut` | G | the outward push, the outward lens and its arcs, `dist_lt_one_of_thin`, `claim_e` and `end_cap` (proved) |
| `Plane/ValidMap/CollarMapOut` | G | `CollarFitOut`, its homeomorphism and map, `map_Γ`, `map_lens`, `map_agreesOff`, `map_valid` |
| `Plane/ValidMap/R2Cap` | C | the radius-2 crescent, the all-or-none dichotomy, the subdivision |
| `Plane/ValidMap/HornChart` | H | horn counts: at a chart (proved), where maps agree, at interior points, on two circles, under a germ swap |
| `Plane/ValidMap/BendGap` | C | the lens clear, the collar's existence, R1/R2/no new unit arc/local step/horn, `CollarFitOut.awayBend`, `bend_away_gap` |
| `Plane/ValidMap/BendStep` | — | `bend_away_subdiv` (the induction, proved from children), `bend_away_part` (proved from children), `CollarFit.map_hornCount_le` (open) |

**Proved in this job** (no `sorry`, on the standard three or fewer): `R2Subdiv.lt`, `LocalStep.union`, `claim_e`, `end_cap`,
`IsSectorChart.hasHornCount`, `collarOutArcs_locallyFinite`; and, **from open children** (so through `sorryAx` until they land),
`bend_away_gap`, `bend_away_subdiv`, `bend_away_part`, `CollarFitOut.pushOutProfiles`.

### 3.2 Reused as it stands, generalizes, new

- **Reused as it stands** (the collar set is the toward bend's `collarK P a b (1 − τ) (1 + τ)`): `exists_collar_free`, `exists_end_free`,
  `collarK_thin`, `collarK_frame`, `crescent_Y`, `side_core`, `branch_transversal`, `branch_tangent` (on halved variables at radius 2),
  `isCompact_polarSet_Icc`; `radialMap`, `push1` and all its lemmas, `continuous_radialMap_push1`, `radialMap_radialMap`; `tangRad` and its
  lemmas for any `R > 1/2` (`tangRad_spec`, `lt_tangRad_iff`, `one_lt_tangRad`, `tangRad_lt_tangRad`, `tangRad_sub_one_le`,
  `polar_tangentCircle`, `germ_tangentCircle`, `eq_of_tangentCircle`, `norm_tangRad_sub_one_le`); `lensProf` (inner profile), `outerProf`
  (now also the lens profile); `cutArcs` and its lemmas; **all of `Pushforward`** (interior points, colours, `coloursAt`, degrees and
  repeated colours carried by any homeomorphism — clauses 9–12 cost nothing); `n2_sign`, `n2_env_away`, `n2_env_near_away`; `isR2Arc_of_fixed`
  (IA1: question (5) applies verbatim to the away bend).
- **Mirrored by copy with the lens outside** (the toward lemma's proof is the template; statement in the skeleton): `PushProfiles` →
  `PushOutProfiles`; `pushHomeo` and its access lemmas → `pushOutHomeo…`; `pushProfiles_collar`; `collarArcs_carrier` (with `tangRad_anti`,
  `tangentArc_image` for `R ≥ 1`); all of `CollarMap` (`mem_interiorPts`, `kin_subset`, `kout_subset`, `homeo_*`, `collarArcs_*`, `map_*`);
  `BendCollar`'s `exists_one_side`, `sides_end`, `sides_eq`, `map_R1`, `map_R2`, `map_R3`, `map_ringArcsWithin`, `homeo_mem_collarK`,
  `isClosed_collarK`.
- **Would generalize to both directions — a tidy move, not now**: the collar-only lemmas (`mem_interiorPts`, `kin_subset`, `kout_subset`,
  `exists_one_side`, `isClosed_collarK`) read `ring`, `short`, `sub_dom`, `free` and the radii `R'`, `R''` only; a base structure
  `CollarBase` with `CollarFit.toBase` and `CollarFitOut.toBase` would state them once. Not done now: no landed statement may change, so
  the toward copies would stay and the base would add a third layer; at wave 5's final sync it is a mechanical merge (domain pass, § 3.5).
  Likewise `PushProfiles`/`PushOutProfiles` → one structure with `a < m, m' < b`.
- **New** (no toward counterpart): `dist_lt_one_of_thin`; `claim_e`, `end_cap`; `exists_r2_crescent_free`, `r2_side_dichotomy`,
  `exists_r2Subdiv`, `R2Subdiv.of_local`; `exists_lensOut_clear`; `AwayBend` and its composition (`idle`, `next`, `join`,
  `contact_of_onRingArc`); `LocalStep.union`, `LocalStep.of_cutArcs`; all of `HornChart`.

### 3.3 The plan per child

Sizes: S (under an hour), M (a few hours), H (a session's main work). Every lemma named is confirmed by `#check` against this branch
(`data/fs131/ka/KAChecks.lean` → `KAChecks.out`, 71 names, exit 0), except the mirrors' own new helpers.

**Lane D — `BendAway`** (no geometry beyond angles)
- **D1 `AwayBend.idle`** — S. `LocalStep.refl`, `isCompact_empty`, `Homeomorph.refl_apply`; `rest` is `∅` by `hC`. `valid` is `hF`.
- **D2 `AwayBend.next`** — S–M. Ring arc: `hb.r2` at `F`'s sub-arc `(b, c₂)` (an inline `⟨hbc, (ringArc_subset_ringArc …).trans hA.2.1, …⟩`;
  `IsRingArc.mono` sits in `Procedure`, downstream), disjointness of `r((b, c₂))` and `r((a, b))` by `polar_inj_window` (both inside an
  interval of length `≤ π/3`, `l60_le`). `c ∉ M.coloursAt P`: `hb.colours P` with `hb.fix_off` (`P ∉ K`: `hb.thick`, `ε ≤ 1/2`,
  `dist P (ringPt P θ) = 1`). `Γ_M` free near `r(θ)`, `θ ∈ (b, c₂)`: `r(θ) ∉ K` (`hb.free`, injectivity), `K` closed (`hb.compact`), and off
  `K` a point is in `M.Γ` iff in `F.Γ` (`hb.step.agreesOff`, pointwise). Contacts: `hb.colours` and `hb.fix_off` at `P + 2e(θ) ∉ K`
  (distance `≥ 1` from the arc). What is hard: nothing; four small facts.
- **D3 `AwayBend.join`** — M (about twenty fields; each two to ten lines). Checked by hand field by field: `valid` `h2.valid`; `compact`
  `.union`; `thick` each collar's arc is a sub-arc (`thickening_mono` on sets: `Metric.thickening_subset_of_subset`); `free`: a point of
  `F.Γ ∩ K₂` off `K₁` is in `M₁.Γ` (pointwise `agreesOff`), so on `r([b, c₂])`; `ring_K` union; `step` `LocalStep.union`; `fix_off`,
  `maps` (if `h₁ z ∉ K₂` it is fixed); `fix_Γ`: `h₁ z = z`, and `z ∈ M₁.Γ` by `h1.interior` (not interior, in the domain); `interior`,
  `colours`, `degree`, `repeated`: compose (`Homeomorph.trans_apply`); `horn`: twice; `within`, `r1`: transitive; `r2`: a set disjoint from
  `r((a, c₂))` is disjoint from both pieces; `bent`: for `θ < b`, fixed-then-fixed (`r(θ) ∈ M₁.Γ ∩ K₂` would put `θ` in `[b, c₂]`) or
  `r(θ) ∈ M₁.region c` and `r(θ) ∉ K₂` (`h2.ring_K`), so in `M₂.region c`; `θ = b` fixed twice; `θ > b`: `h₁` fixes `r(θ)` and `h2.bent`.
  `rest`: inside the union of the two pieces' sets and `{b}` (`h1.next`'s contact clause carries `F`'s contacts to `M₁`). What is hard:
  bookkeeping only; the fields `ring_K`, `interior`, `rest` exist to make it local.
- **D4 `AwayBend.contact_of_onRingArc`** — S–M. `OnRingArc` gives `t ∈ [a₀, b₀]`, `e t = e θ` (`e_eq_e_iff`), a sequence `t_m → t` in
  `[a₀, b₀] ∖ {t}`; `θ_m = θ + (t_m − t)` is eventually in `(θ₁, θ₂)`, `r(θ_m) ∈ M.Γ`, so not in `M.region c`; by `hb.rest` all but finitely
  many `θ_m` are contacts; `closure` is closed and `θ ↦ P + 2e(θ)` continuous.
- **D5 `LocalStep.of_cutArcs`** — S–M (IA1's W1 and W2; FS131-IA2 holds the same statement on `fs131-w5y` and may land the proof first).
  `keep`: for `circ P 1 θa θb` missing `K`, `m := ⌊(θa − θ₂)/(2π)⌋`, `Int.floor_le`, `Int.lt_floor_add_one`; if `θb > θ₁ + 2π(m+1)` the
  parameter intervals overlap and the arc meets `r([θ₁, θ₂]) ⊆ K`. `new`: `cutArcs_subset`; `cutLo ≠ θa` or `cutHi ≠ θb` puts `r(θ₂)` or
  `r(θ₁)` on the arc.
- **D6 `R2Subdiv.of_local`** — S–M. `lebesgue_number_lemma_of_metric` on `Icc a b` with the cover `ball x (δ_x/2)`-style; `n` by
  `exists_nat_gt`; induction on `j ≤ n` for `R2Subdiv C a (a + j (b − a)/n)`.

**Lane G — `LensOut`, `CollarMapOut`** (mirrors, and one new inequality)
- **G1 `pushOutHomeo` and its three access lemmas** — S–M. Route in the docstring; the dummy middle profile `(a + 1)/2` is the one idea.
- **G2 `pushOutProfiles_collar`** — S (mirror of `pushProfiles_collar`, 45 lines).
- **G3 `collarOutArcs_carrier`** — M (the longest mirror: `tangRad_mono` for `R ≥ 1` in place of `tangRad_anti`; `tangentArc_image`;
  `collarArcs_carrier`'s 85 lines with `min` for `max`). What is hard: at `R > 1` the tangent circle's centre is beyond `P`, so the germ arc's
  chord parameter still runs on the "upper side", but each inequality's direction must be re-derived, not flipped by rote.
- **G4 `dist_lt_one_of_thin`** — S–M. `dist_eq_norm`, the triangle inequality through `P + e φ_i`, `‖e φ₁ − e φ₂‖ = 2 sin((φ₂ − φ₁)/2)`
  (or `norm_e_sub_e_le` plus a sharper bound), `Real.sin_le_sin_of_le_of_le_pi_div_two`, `Real.mul_le_sin`; state each real inequality as a
  small lemma (`LEAN.md` § Searching: `nlinarith` in a large context).
- **G5 `homeo_image_dom`, `collarOutArcs_nondegenerate`, `collarOutArcs_Γ`, `map_Γ`** — M together (mirrors of `CollarMap` l. 219–375).
- **G6 `map_lens`, `map_agreesOff`** — S–M (with the mirrors of `kin_subset`, `kout_subset`: here the **inner** collar is stretched over
  the lens, so `map_lens` reads `kin_subset` and the arc's points go to the lens curve).
- **G7 `map_valid`** — S–M: `CollarFit.map_valid`'s proof with `dist_lt_one_of_thin` at `κ = R − 1` (`tangRad_sub_one_le`, `R ≤ 9/8`).

**Lane C — `R2Cap`, `BendGap`** (charts and the new clearance)
- **C1 `exists_r2_crescent_free`** — M. `exists_end_free`'s 110 lines with the frame at `P + 2e(θ_E)`; `branch_transversal` unchanged,
  `branch_tangent` at `(X/2, Y/2, s/2, 2κ)`; the conclusion `dist z P = 2` from `4Y + N = 0`.
- **C2 `r2_side_dichotomy`** — M–H. The open half-crescent `{σX > 0, 4Y + N > 0, 4(1 + τ)Y + N < 0, N < ρ²}` in the frame: connected (a
  continuous image of a box, as `kin_subset`'s `hS`), in the domain, free of `Γ` (C1), so `F.col` is constant on it
  (`IsPreconnected.constant`, `continuousOn_col`). If the colour is `c`: every radius-2 point next to `w₀` on that side is in its closure.
  If not: for `θ` next to `θ₀` (an interior angle of the arc) a ball about `P + 2e(θ)` misses the class — outside the radius-2 circle it
  lies in the crescent; inside or on the circle, a point `y = P + s e(θ')`, `1 < s ≤ 2`, of that ball is at distance exactly `1` from
  `x = P + (s − 1)e(θ')`, which lies in `closure (region c)`: `innerColours P (r θ) = {c}` gives a ball about `r(θ)` whose interior points
  inside `ω(P)` all have colour `c` (as in `IsRingArc.free_of_isClean`), `x` is in that ball and is a limit of interior points inside
  `ω(P)` (interior points are dense in the domain — find or mint; for `s = 2`, `x = r(θ')` is in the closure by the inner colour itself),
  so `ne1_region` excludes `y`. No `hfree` is read. Then the cap: a point of the class in the closed crescent, at distance `≥ 2` from `P`,
  is in the open crescent or on the circle, both excluded. What is hard: the frame bookkeeping, stating the half-crescent so that its
  connectedness is one line, and the density fact.
- **C3 `exists_r2Subdiv`** — M. `R2Subdiv.of_local`; at `x`, `δ` from C2 on both sides (`hdom` gives `hw`); an interval `(u, v)` within `δ`
  of `x` is `.contact`/`.gap` if `x ∉ (u, v)`, else the `join` of `(u, x)` and `(x, v)`.
- **C4 `exists_lensOut_clear`** — **H, the new mathematics** (§ 2.5 is its hand proof). Children to mint: (a) the far point is within `η` of
  an end (`n2_env_away` at `r = min(d₀, η/2)`, `d₀` from `IsCompact.exists_thickening_subset_open`-style separation of the compact middle
  of `R₂` from `closure (region c)`); (b) at an end, beyond: `claim_e` on the frame coordinates (`z₁ < 1` from `lt_tangRad_iff` — the lens
  is strictly inside the end's circle; `p₁ > 0` from `η < 1`); (c) at an end, gap side: `dist y P ≥ 2` (far, and the angle of `y` in the
  gap's range for small `η`), C2's "none" case (the "all" case contradicts `hgap`), `end_cap` with `O = P + (2 − ρ₀)e(a)`,
  `C = P + (1 − R)e(a)`, `R = 1 + τ/2 ≤ ρ₀ − 1`; (d) near: `n2_env_near_away` as in `away_clear`. The profile bounds: `outerProf − 1 ≤
  (τ/2) min(φ − a, b − φ)² ≤ τ min(…)` (`tangRad_sub_one_le`).
- **C5 `exists_collarFitOut`** — S: `exists_collarFit`'s 18 lines with `exists_lensOut_clear`, `R = 1 + τ/2`, `τ ≤ 1/4`.
- **C6 `map_ringArcsWithin`, `map_R1`, `map_R2`** — M (mirrors; the longest copies, about 400 lines of `BendCollar` l. 836–1275, with the
  mirrors of `exists_one_side`, `sides_end`, `sides_eq`, `map_R3`). At an end the lens's cusp lies on `P`'s side of the tangent line, so
  for `Q = P + 2e(θ_E)` it is outside `ω(Q)`: `side_core` already covers it (the collar is the same set).
- **C7 `map_localStep`** — S: `LocalStep.of_cutArcs`, `map_agreesOff` weakened to the collar, `collarOutArcs_carrier`.
- **C8 `CollarFitOut.map_hornCount_le`** and **`CollarFit.map_hornCount_le`** (§ 4) — M each, after lane H.
- **C9 `CollarFitOut.awayBend`** — M: the assembly, field by field (its docstring lists each source).

**Lane H — `HornChart`** — § 4.

### 3.4 The obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh)

- **(a) `bend_away_subdiv`.** Space: the derivations of `R2Subdiv C a b`; the induction is its recursor. The statement is *strengthened by
  generalizing the map*: the hypothesis runs over every valid plane map carrying the arc whose contact set is the fixed `C`, because the
  second half is bent in the first half's output. The fixed `C` is the invariant the maps share (`AwayBend.next`'s fourth conjunct
  restores it). With that statement the `join` case is twelve lines and the proof is in the file. Measure: the derivation's size.
- **(b) `AwayBend.join`.** Each field a local obligation; mutation audit by hand: without `ring_K`, `bent` fails to compose (a bent point
  of the first piece could sit in the second collar); without `interior`, `fix_Γ` does (the fixed point must be shown in `Γ_{M₁}`); `rest`
  must be *finite*, not empty (the junction angle is unbent and may be no contact); `ε ≤ 1/2` is read exactly where contacts of `M₁` are
  compared with `F`'s. `rest` also has teeth: the idle bend over a gap is **not** an `AwayBend` (its `rest` is the whole open interval).
- **(c) `exists_r2Subdiv`.** Local obligation: near each angle, every sub-interval is subdivided (C2 on both sides); global by a Lebesgue
  number, isolated as `R2Subdiv.of_local` so that the compactness argument reads no map. Measure for `of_local`: `j ≤ n`.
- **(d) `exists_lensOut_clear`.** Prove/assume partition: assumed — `hin`, `hgap`, `hdom` (each load-bearing: without `hin` the class
  meets every disc about `P`; without `hgap` the lens over a contact interval is at distance `1` from the class; without `hdom` no chart at
  the ends). The far case is localized to an end by compactness, and at an end to one of two exact inequalities with no smallness left in
  them (`claim_e`, `end_cap`); the only "small" choices are `η` (C2's), `r`, and `τ ≤ 2(ρ₀ − 2)`.
- **(e) the horn count at an end.** The count is `#{i | β i = nextβ i}` (`IsSectorChart.hasHornCount`), a function of the germs'
  directions and their order; the swap keeps both. Two obligations: the chart of `F` has the germ `(β₀, κ₀)` (its branch is in `Γ`, and
  `IsSectorChart.branches` lists `Γ`'s branches), and the swapped germs satisfy `isSectorChart_of`'s hypotheses (`Sorted` by `hbetween`).
- **Partition for the milestone**: *prove* every child above; *test* the spec examples (`R2Subdiv` at three sets, `claim_e` and `end_cap`
  at numbers, `lensOutSet`, the bent map's arcs); *assume* `hfree` (the step has it from cleanness, `IsRingArc.free_of_isClean`), `hin`, `hP`.

### 3.5 The domain-modeling pass (`debruijn-domain-modeling`, invoked fresh)

- **`AwayBend` as a `Prop` structure** indexed by `(F, M, h, K, P, a, b, c, ε)`: every index is read by `join` or by the final projection;
  `c'` is not an index (no field reads it). The next lemma states in its vocabulary (`join`, `next`, the toward bend as an instance with
  the gaining colour in `c`'s place and `rest` empty by R3). Adversarial member: the idle bend over a gap — excluded by `rest`.
- **`R2Subdiv` as an inductive predicate** rather than a list of cut points: the induction wanted (bend a piece, then the rest in the new
  map) is its recursor; superfluous cut points are admitted and harmless (a pinch at a non-contact angle: degree `2`, two colours, on no
  unit arc; counted by `rest`, which is why `rest` is "finite").
- **`CollarFitOut` standalone**, not a shared base: the "N copies modulo naming" smell is real (six fields shared with `CollarFit`), and
  the base structure is the right end state; it is deferred because the landed `CollarFit` cannot change in this job (§ 3.2).
- **The collar set is not mirrored at all** — the one structural finding of the pass: the toward and away bends differ only in which of
  the three profiles `1` is pushed to, so everything about `collarK` and `Γ` is shared as it stands.
- **Unsampled members checked by hand**: `C₂ = ∅` (one gap: N2-AWAY in collar form); `C₂ ⊇ (θ₁, θ₂)` (the idle bend; the statement is
  then trivially true, `M = F`); an isolated contact at an end of the arc (E5's case); an isolated interior contact (two gaps, a pinch);
  an arc of exactly `60°` (`dist_lt_one_of_thin` is strict because `u + v > 0`); `ε > 1/2` (the proof bends within `min ε (1/2)`).

### 3.6 The handoff: two implementers, split by file

| | implementer 1 (lanes G and D) | implementer 2 (lanes C and H) |
|---|---|---|
| files | `LensOut.lean`, `CollarMapOut.lean`, `BendAway.lean` | `R2Cap.lean`, `HornChart.lean`, `BendGap.lean`, and `BendStep.lean`'s `CollarFit.map_hornCount_le` |
| reads of the other's | — | `CollarMapOut`'s and `LensOut`'s **statements** (in the skeleton as `sorry`), so no waiting |
| order | G1, G2, G4 (independent), G3, G5–G7; then D1–D6 | H1, H2, C1 (independent); H3, H4, C2, C3; C4; C5–C9 |
| first two leaves to re-price from | G1, G4 | C1, H3 |

Neither may change a statement; a statement change comes back to the planner through Keryx. Each new helper is a new declaration in
the lane's own file; a `private` helper of `BendCollar`/`CollarMap` needed by a mirror is re-proved in the mirror's file or made public by
a new declaration there (ruling 421 (c)). `tools/fs131_ka_stmt.py --base <the skeleton's commit>` is the statement check for both (extend
`EDITABLE` to the six new files and move the base). **Price**: H overall — about two sessions each, the toward bend's two sessions
doubled by the new clearance (C4), the radius-2 charts (C1–C3) and the horn lane, which the toward bend never paid for; re-price after the
first two leaves of each lane (`LEAN.md`: a kernel leaf priced from a plan's table is priced high).

### 3.7 The build and the receipts

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`, the worktree's `./scripts/build.sh`): **OK — 459 of 459 batches, exit 0, no warning other
  than `declaration uses 'sorry'`** (`build/gate/build/20261006T060103Z-1476282.log`; driver log `data/fs131/ka/build2.log`; the first
  build of the skeleton, before rulings 444's edit, also OK: `build1.log`). **39 distinct `sorry` warnings**
  (`data/fs131/ka/sorry-warnings.txt`): `BendAway` 6, `LensOut` 7, `CollarMapOut` 7, `R2Cap` 3, `HornChart` 4, `BendGap` 8, `BendStep` 1
  (`CollarFit.map_hornCount_le`) — **36 open children** — and, not this job's, `Procedure` 2, `Terminal` 1. `bend_away_part` carries no
  `sorry` of its own any more. Iteration before it under `lake env lean` (never evidence): two errors of mine, both read and fixed
  (`AgreesOff`'s direction in `LocalStep.union`; an implicit argument of `Near.hasHornCount_chart`).
- **Axioms** against that build's oleans (`data/fs131/ka/KAAxioms.lean` → `KAAxioms.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`,
  exit 0; IR1's `tools/fs131_ir_axsum.py`, `KAAxioms-summary.txt`, PASS): **47 records — 7 on the standard three or fewer (the six
  proved here and `bend_toward_collar`), 40 through `sorryAx`, exactly the expected ones, 0 other.** *Slip of my own, caught by the
  summarizer*: I had listed `CollarFitOut.pushOutProfiles` as proved; it is proved **from** the open `pushOutProfiles_collar`, and the first
  run failed naming it. **Control**: with `bend_away_gap` left off the expectation list the summarizer exits 1 naming the first
  unexpected record (`KAAxioms-control.txt`).
- **Statements**: `tools/fs131_ka_stmt.py` (base `78eba0b4`): **0 failures over 1,789 base files**; the one allowed change is
  `bend_away_part` (rulings 438 (b), 444); one new declaration in `BendStep` (`bend_away_subdiv`); six new files
  (`data/fs131/ka/stmt.txt`). `--self-test`: five plants — a changed hypothesis of `isR2Arc_of_fixed`, `r2_notMem_region` renamed, an edit
  to `BendCollar`, an `axiom` and a `native_decide` in a new file — **each FIRED**, the unplanted run PASS (`stmt-selftest.txt`). No new
  `axiom`, no `native_decide`. `RadialPush`, `CollarMap`, `Pushforward`, `BendCollar`, `UnitArc` are untouched (no new declaration was
  needed in them).
- **The map**: six rows added to `ARCHITECTURE.md`, `BendStep`'s row updated; `tools/check_architecture.py` PASS
  (`data/fs131/ka/arch-stage3.txt`).
- **Receipt**: a block "FS131-KA1" of 44 records in `scripts/Axioms.lean`, above `=== PURCHASED ===` (six proved, 38 open or proved from
  open children: the gate fails on them until they land, as it should). I ran no gate, merged nothing, touched nothing on `main` or in
  `Procedure.lean`, and left no process running.
- **Lemma names**: 71 confirmed by `#check` (`data/fs131/ka/KAChecks.out`, exit 0).

### 3.8 Not done, and why

- `CollarFit.map_hornCount_le` is planned (§ 4), not proved: it is not short.
- The inhabitant is planned (§ 5), not built.
- `plans/FS131-collar-kernel-plan.md` and `plans/FS131-collar-C-implementation.md` were not read beyond what the four modules quote
  (budget); `plans/FS112-N-proof.md`'s stage N2-3 beyond its two quoted rows likewise. The clearance (§ 2.5) is therefore **my derivation
  with E5's two lemmas, not a reading of N2-3's**; a deriver or the kernel is its second check.
- **A wart in my own skeleton, left for a word**: `AwayBend.idle` takes `hA` and `hε`, which its proof will not read (the idle bend needs
  only `hF` and `hC`). Removing them changes that child's statement and `bend_away_subdiv`'s one call; I did not spend a third build on it.

## Theorems this phase proved (the list the head of this record points to)

Kernel-checked, on `[propext, Classical.choice, Quot.sound]` or fewer (`data/fs131/ka/KAAxioms.out`), namespace `HadwigerNelson.Plane`:
- `R2Subdiv.lt` (`ValidMap/BendAway`) — a subdivided interval has positive length.
- `ArcMap.LocalStep.union` (`ValidMap/BendAway`) — two local steps in a row are a local step on the union.
- `claim_e`, `end_cap` (`ValidMap/LensOut`) — FS131-E5's Claim E and END-CAP (`e5-claim-e`, `e5-end-cap`), now **[kernel]**.
- `ArcMap.IsSectorChart.hasHornCount` (`ValidMap/HornChart`) — the horn count at any sector chart with a germ is its number of cusps.
- `ArcMap.collarOutArcs_locallyFinite` (`ValidMap/CollarMapOut`).

Proved **from open children** (through `sorryAx`; not results yet): `ArcMap.bend_away_part`, `ArcMap.bend_away_subdiv`,
`ArcMap.bend_away_gap`, `ArcMap.CollarFitOut.pushOutProfiles`. At **[hand]**, one mind: the statement attack of Stage 2 (no clause of
`bend_away_part` false; the five needs of § 2.4).

## Stage 3 — SAVED (FS131-KA1)

## 4 The second open child: `CollarFit.map_hornCount_le` (planned with the away bend's, not proved)

It is not short — it needs a chart at the lens's corner and at the ends, which the toward bend's degree proof avoided by carrying sector
counts through the homeomorphism — so it is planned, over four children shared with the away bend (`HornChart`):

| child | statement (in the skeleton) | route | size |
|---|---|---|---|
| H0 `IsSectorChart.hasHornCount` | the count at any chart with a germ is `#{i | β i = nextβ i}` | **proved**: the chart extended to `Near` data as `exists_near` does, then `Near.hasHornCount_chart` | — |
| H1 `hasHornCount_iff_of_agree` | equal counts where the interior points agree on a ball | `hasDegree_iff_of_agree`'s proof with the horn predicate on the sectors; sectors read interior points only | S |
| H2 `hasHornCount_zero_of_mem_interiorPts` | `0` at an interior point | `exists_hasHornCount`'s first case (`Procedure`, downstream — its nine lines are copied; flag below) | S |
| H3 `hasHornCount_zero_of_two_spheres` | `0` where `Γ` near `x` lies on two circles not tangent at `x` | `exists_near`; a cusp index gives two germs of one direction `β`; branch points `x + s e(β + arcsin(κ s/2))` lie on one of the circles for each `s`, so (letting `s → 0`) `e β` is tangent to a circle through `x`; if tangent to one only, both branches lie on it for small `s` and coincide (`eq_of_tangentCircle`'s argument) against `Near.hdisj`; tangent to both is excluded by `hnt` | M |
| H4 `hasHornCount_iff_of_germ_swap` | the count is kept when one germ's curvature moves inside a cusp `Γ` misses | `localSectors` for `F` at `x`; the germ `(β₀, κ₀)` is in the chart (its branch is in `Γ`; `IsSectorChart.branches`); the germs with `κ₀'` there are `Sorted` (`hbetween`) and satisfy `isSectorChart_of` for `M` (`hM`); H0 twice | M–H |

**`CollarFit.map_hornCount_le` from them** (and `CollarFitOut.map_hornCount_le` the same way): `x ∉ collarK` — H1 with
`map_agreesOff` on a ball off the closed lens (`isClosed_closedLens`), `j' = j`; `x ∈ collarK`, not an end — `j' = 0`: `x` interior in the
bent map (H2) or on the lens curve, where `Γ_M` near `x` lies on the two circles of radius `R` about `P + (1 − R)e(θ₁)` and
`P + (1 − R)e(θ₂)` (`map_Γ`; `F.Γ` is closed in the domain and `x ∉ F.Γ`), which are not tangent (equal radii, centres `≤ |1 − R|` apart)
(H3); `x` an end — H4 with `β₀ = θ₁ + π/2`, `κ₀ = 1`, `κ₀' = 1/R` (at `θ₂`: `θ₂ − π/2`, `−1`, `−1/R`), `hM` from `map_Γ` and the two
germ arcs' carriers near the end, `hbetween` from `free` (a branch of that direction with curvature between lies in the collar's
crescent off `ω(P)`: the converse inclusion of `collarK_frame` near the end, to be minted). Price: M once lane H is in.

**Flags** (held for the coordinator): `exists_hasHornCount`, `hasHornCount_iff_of_agreesOff`, `IsRingArc.mono` and
`eventually_ball_subset_compl` sit in `Procedure`, downstream of every bend module; H1 and H2 are stated in a different (ball) form so no
statement is doubled, but the final sync may prefer to move those four upstream.

## 5 The inhabitant: `awayModel`, a plane map meeting every hypothesis of `bend_away_part` at once, with a contact interval (planned)

No plane map on file carries a ring arc (`sevenBrickMap` has none: `sevenBrick_not_isRingArc`), so the inhabitant is a new object. **Its
plan** (hand, one mind; every number checked by hand below):

- **The object.** `awayModel : ArcMap 8` over `sevenBrickMap` (`Plane/SVMap`, bricks `(0.8c + 0.4r, +0.8) × (0.6r, 0.6r + 0.6)`), with
  `P = −3/5 + (3/10)i`, the new colour `7`, and two new arcs: `Arc.circ P 1 (−arcsin(3/10)) (arcsin(3/10))` and
  `Arc.circ P 2 (−arcsin(3/20)) (arcsin(3/20))`. Colour: `7` on `T₁ ∩ B(P, 1)` and on `T₂ ∖ B̄(P, 2)`, where `T₁ = brickCell 0 0`,
  `T₂ = brickCell 1 0`; the brick's colour (cast into `Fin 8`) elsewhere.
- **The arcs cross their bricks wall to wall.** `ω(P)` meets `T₁ = (0, 0.8) × (0, 0.6)` where `0.3 + sin θ ∈ (0, 0.6)`, `|θ| <
  arcsin(0.3) ≈ 17.5°`, with abscissa `−0.6 + cos θ ∈ (0.35, 0.4]`; the radius-2 circle meets `T₂ = (0.8, 1.6) × (0, 0.6)` where
  `|θ| < arcsin(0.15) ≈ 8.6°`, abscissa in `(1.37, 1.4]`.
- **The hypotheses.** *Valid*: the brick classes only lose points; the class of `7` has two pieces, each inside one brick (diameter
  `< 1`), and for `x` in the first, `y` in the second, `|x − y| ≥ |y − P| − |x − P| > 1`. *Plane map*: `sevenBrickMap`'s domain. *Ring
  arc* `r([−arcsin(3/10), arcsin(3/10)])` of `ω(P)`, inner colour `7`, outer colour `T₁`'s; `35° ≤ 60°`. *`7 ∉ coloursAt P`*: `P` is
  interior to `brickCell (−1) 0`. *`hfree`*: the open arc is interior to `T₁`.
- **What it exercises.** `C₂ = [−arcsin(3/20), arcsin(3/20)]`, a contact **interval** strictly inside the arc's angles: two gaps (each
  with one end the arc's end, a non-contact, and one end a contact where the class is bounded by `T₂`'s horizontal wall, transversal to
  the radius-2 circle — E5's case (b)), and a contact piece whose points stay on `ω(P)`, so the last clause's premise holds there. Not
  exercised: an isolated contact (`isoFrag`'s shape); a second model, or `awayModel` with `T₂` replaced by a brick meeting the circle at
  a corner, would do it.
- **Lean cost**: M–H, one session — `isoFrag` (`UnitArc` l. 4139–4300) is the pattern for a map coloured by an `if` with one circular arc,
  and `BrickMap` has the cells, their closures and the interior points. It belongs to the models' lane (FS131-KM1) or to implementer 2
  after C4; `bend_away_part`'s, `bend_away_subdiv`'s, `bend_away_gap`'s, `r2_side_dichotomy`'s, `exists_r2Subdiv`'s and
  `exists_lensOut_clear`'s docstrings name it as owed.
