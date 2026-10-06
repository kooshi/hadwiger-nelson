# FS131-KA1 — the outward collar bend planned (`bend_away_part`): the record

*de Bruijn, the planner, on branch `fs131-w5a` (at `78eba0b4` when the job began). Brief: `data/fs131/briefs/FS131-KA1-bend-away.md` (on
`main`'s tree). Working files: `data/fs131/ka/`. Tools: `tools/fs131_ka_*.py`.*

## Theorems this phase proved

See the last saved stage's list (kept current at each stage).

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
