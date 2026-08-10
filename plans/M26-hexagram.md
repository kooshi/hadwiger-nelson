# M26 — The hexagram: 6 pivots + metapivot, unconditionally

*Stub recorded 2026-08-08 (Kooshi's construction, corrected geometry); subplan
opened 2026-08-09 on Kooshi's go. §0 predictions are registered BEFORE the
experiments run — the commit of this section predates every instrument result
below it.*

## Scope

The **6+1 system**: the pivot hexagon of circumradius 1/√3 about the metapivot
m = (1+ζ₆)/3 — the M23 triangle T₁ = {0, 1, ζ₆} PLUS its point-reflection
through m, T₂ = {q₀, q₁, q₂} = {2m, 2m−1, 2m−ζ₆} (the mirror centroids,
already certified as the inner∩inner(m) glue points,
`Triangle.inner_inter_metaInner`). Seven ladders (six pivots + the metapivot,
each an M24 `outerPt`/`innerPt` family); all cross-webs classified; the
complete chord and fusion inventory; the colouring theorem
`chromaticNumber_hexagram`.

## §0 Registrations — predictions BEFORE instruments

### §0.1 E1 — The frame: coordinates, the ℤ/6 action, and the two new webs

Hand-derived at subplan opening; the instruments confirm or kill each line.

* **P1.1 (self-seeding, exact).** The T₂ pivots lie in ℚ(ζ₆):
  `q₀ = 2(1+ζ₆)/3`, `q₁ = (2ζ₆−1)/3 = i/√3`, `q₂ = (2−ζ₆)/3 = m̄`.
  The **meta-inner hex layer at height 0 IS the pivot hexagon**:
  `innerPt m metaAnchor (a, 0)` for a = 0..5 equals
  `q₀, ζ₆, q₁, 0, q₂, 1` in that address order (T₁ at odd addresses 1, 3, 5 —
  the M25 hub layer — T₂ at even addresses 0, 2, 4). So the six pivots are
  already vertices of M25's `fourLadder`, and the six unit pivot pairs are
  exactly the rot3 intra-chords of the meta-inner ladder. The promotion adds
  centres, not points.
* **P1.2 (the ℤ/6 action).** `rot6 z := m + ζ₆·(z − m)` cycles the pivots
  `q₀ → ζ₆ → q₁ → 0 → q₂ → 1 → q₀` (meta-inner address a ↦ a+1), satisfies
  `rot6² = ` M25's 120° `metaRot`, fixes the meta ladder up to address shift
  +1, and — with ALL six pivot ladders anchored at direction 1 (partner v+1) —
  carries every ladder family to a ladder family with hex-address shift +1
  (M25's `outerPt_hexRot` absorbing the rotated anchor).
* **P1.3 (four pair-orbits, two new masters).** The 21 centre pairs fall into
  exactly four ⟨rot6⟩-orbits: **unit** (6 pairs, rep (0,1) — M24's master),
  **pivot–meta** (6 pairs, rep (0,m) — M25's master), **adjacent** (6 pairs,
  rep (0,q₂), separation s = m̄, 3s = ḡ), **opposite** (3 pairs both
  orientations, rep (0,q₀), s = 2m, 3s = 2g). M26 proves TWO new master webs
  and transports everything else; the six unit webs come from M24's pair via
  rot6-powers (M25 did three of them at 120°), the six pivot–meta webs extend
  M25's `j : Fin 3` quantifier to `Fin 6`.
* **P1.4 (the eight new master forms, exact — signs in the (0→partner)
  orientation, `Tr(z) := z + z̄`, w₁ the 0-ladder word, w₂ the partner word,
  both anchors direction 1).** Derived by hand from
  `|s + ρ₂w₂ − ρ₁w₁|² ∈ {1, 0}` and 2Re(s·w̄) = (1/3)Tr(g·w) per g-factor:

  | family | cleared master (chord) | fusion constant |
  |---|---|---|
  | adj oo | `Tr(gw₁) − Tr(gw₂) + 3Tr(w₂w̄₁) = 4` | `= 7` |
  | adj oi | `√3Tr(gw₁) − Tr(gw₂) + 3Tr(w₂w̄₁) = 2√3` | `= 5√3` |
  | adj io | `Tr(gw₁) − √3Tr(gw₂) + 3Tr(w₂w̄₁) = 2√3` | `= 5√3` |
  | adj ii | `Tr(gw₁) − Tr(gw₂) + √3Tr(w₂w̄₁) = 0` | `= 3√3` |
  | opp oo | `2Tr(gw₁) − 2Tr(gw₂) + 3Tr(w₂w̄₁) = 7` | `= 10` |
  | opp oi | `2√3Tr(gw₁) − 2Tr(gw₂) + 3Tr(w₂w̄₁) = 5√3` | `= 8√3` |
  | opp io | `2Tr(gw₁) − 2√3Tr(gw₂) + 3Tr(w₂w̄₁) = 5√3` | `= 8√3` |
  | opp ii | `2Tr(gw₁) − 2Tr(gw₂) + √3Tr(w₂w̄₁) = 3√3` | `= 6√3` |

  (Adjacent uses `2Re(s·w̄₂) = (1/3)Tr(g·(ζ₆⁻¹w₂))`-type shifts since
  3s = ḡ = ζ₆⁻¹g — the ḡ-trace is a g-trace at a shifted address via M25's
  `g_shift`; the table rows above absorb that shift into w₂'s address. Exact
  signs and address conventions are what instrument D2 pins; the GENUS —
  which terms carry √3, the κ values, the doubling on the opposite web — is
  the registered claim.) Note the κ-echo: adjacent κ ∈ {4,7}/{2,5}/{0,3} —
  exactly M25's meta-web constants (same |s|², same radii) — while opposite
  doubles the g-coefficients and shifts κ to {7,10}/{5,8}/{3,6}.
* **P1.5 (no infinite families in the new webs).** Neither new web has a
  matching branch (no unit torsion `w₂ = ζ₆^k w₁` makes the master constant)
  nor a hub pencil: the mutual-membership points of adjacent pairs
  (0 ∈ inner(q₂), q₂ ∈ inner(0)) sit at ζ₁₂-fibre directions, which are
  **never lattice words** (M24's empty `Re = √3/2` fibre), and the opposite
  distance 2/√3 lies on no circle pair. All eight new chord families are
  finite sporadic lists. Contrast: the pivot–meta oi hub pencil (infinite)
  remains, now at all six pivots.

### §0.2 E2 — The engine transfers whole (the research risk, small this time)

* **P2.1 (no new ring input).** Every new master clears by √3-powers into
  M24/M25's ℤ[ζ₆,π] trace pairs (`hexTrace` with arbitrary ℤ[ζ₆]
  coefficients); ζ₁₂ never enters the arithmetic (the T₂ coordinates are in
  ℚ(ζ₆) — P1.1). The coefficient tables: adjacent = `gE`/`gF` at shifted
  addresses (ḡ = ζ₆⁻¹g), opposite = doubled (`2gE`/`2gF`). The kill toolkit
  carries: φ(2g) = 2φ(g) = 0, 3 ∤ 2gE wherever 3 ∤ gE, `alone_dvd`/`phi_dvd`
  verbatim, the pin kills at the same two-stage (mod √3, mod 3) ladder.
* **P2.2 (the mod-9 rescans).** `adjacent_kill`'s 36-pair mod-9 scan must be
  RE-RUN for each new (coefficient-table, κ) combination before its Lean
  decide is stated — the carry-forward's warning made binding. Prediction:
  all height-unbounded branches close under the existing kill genus (mod √3
  parity, mod 3 rows, mod 9 adjacent-heights); **failure clause**: a family
  whose endgame does not close under the toolkit plus realizable-address
  boundary decides is reported NOT LANDED, the χ theorem stated conditional
  on exactly that family, the milestone re-scoped openly.
* **P2.3 (sporadic windows).** All new-web sporadics live at |b| ≤ 1
  (medium confidence — the M24/M25 precedent; the census decides, no count
  prior registered).
* **P2.4 (the tangency is invisible — scope deletion).** The opposite-ii
  fusion (the triple tangency at m) is EMPTY at the lattice level: m is never
  a lattice word of any family (ζ₁₂ fibre), so the tangency kill is the
  ordinary fusion-κ run at `6√3` — **the `sphere_inter_sphere` tangency
  degeneracy is NOT needed** for the headline and leaves M26's scope. More
  generally, m ∉ hexagram: the object does not contain its own centre.

### §0.3 E3 — The census bed

* **P3.1 (instrument + controls).** `build/m26-census.py`: the exact
  quartic-field census extended to all 14 families (7 anchors × 2 circles),
  B = 30 with a growth check. Controls, all must pass before any new number
  is believed: the six unit-pair webs reproduce M24's PROVEN tables
  (transported addresses); the six pivot–meta webs reproduce M25's tables
  (the three T₂ webs as exact address shifts of the masters); a planted
  disagreement is refused by name. Promotion into
  `tools/couple.py --hexagram-census` happens at implementation, with the
  self-test carrying planted chord AND fusion disagreements (M25 discipline).
* **P3.2 (the fusion inventory).** Registered: the complete lattice-level
  fusion (coincidence) inventory of the hexagram is — the six pivots, each a
  TRIPLE point (meta-inner at its hex address, and the outer points of its
  two second-neighbour pivots — the rot6 transport of M25's
  `meta_fusion_oi`), PLUS M24's eight pair-fusion points transported to all
  six unit pairs, and NOTHING else: all eight new-web fusion families
  (adjacent ×4, opposite ×4) are EMPTY. (Medium on the "nothing else";
  the emptiness of the eight is high — the κ-shifted spines at P1.4's fusion
  constants.)
* **P3.3 (the loop census, the stub's ask made binding).** With 7 centres,
  pure-seam relations of length 4 exist — the pivot parallelogram: hexagon
  edges (0,1) and (q₀,q₁) are parallel with equal difference
  (0 − 1 = q₁ − q₀ = −1), so
  `S₀ ∘ S₁⁻¹ ∘ S_{q₁} ∘ S_{q₀}⁻¹ = id` (seam rotations compose to
  translations `t·(p−q)` which cancel on parallel edges). Length 4 is
  impossible at the triangle (M23: minimal 6, no parallel edge pairs). The
  census confirms the witness and reports the new minimum.

### §0.4 E4 — The colouring probe and the fork

* **P4.1 (the table, symmetry-first).** The b-independent colour probe runs
  on the fusion-deduped collapsed classes (M24/M25 method), **trying the
  rot6-equivariant solution first**: a colour permutation τ ∈ S₄ with
  `colour(rot6 z) = τ(colour z)` — τ a 3-cycle is the natural candidate
  (τ⁶ = id, fixed-point-free on the hex cycle it must break). If the
  symmetric probe is SAT, the properness burden collapses to the four
  orbit-representative webs plus intra; if UNSAT-symmetric but SAT-free, the
  free table ships and properness runs the full case bash (fallback, more
  decides, no new mathematics). Registered: symmetric SAT at medium
  confidence, free SAT at medium-high.
* **P4.2 (the fork, pre-committed).** If k = 4 is UNSAT at census depth and
  the kill is injection-verified, the milestone pivots to certifying the
  5-forcing — that outcome is the MORE valuable one and is taken without
  re-asking. k = 3 UNSAT is the control (the M24 witness sits inside).
* **P4.3 (the bounds).** χ ≥ 4 is free: `fourLadder ⊆ hexagram` (the first
  four anchors), M25's lower bound transports by subset monotonicity. χ ≤ 4
  is the table; the headline is `chromaticNumber_hexagram = 4`.

### §0.5 Instrument specs (run AFTER this section commits)

| # | instrument | checks |
|---|---|---|
| D1 | `build/m26-design.py` | P1.1 coordinates + hex-layer identity; P1.2 rot6 action + address shifts; P1.3 orbit table |
| D2 | same | P1.4: all eight masters verified symbolically (exact ℚ(√3,√11)-arithmetic), fusion constants, exact sign/address conventions fixed |
| D3 | same | ground truth: exact solve of each new family over \|b\|,\|d\| ≤ 8, all 36 address pairs, chord + fusion κ; sporadic tables extracted; P1.5/P2.3 checked |
| D4 | same | the m25-design2 discipline: the PLANNED Lean case tree (parity split, alone/φ/pin kills, mod-9 rescans P2.2, realizable-address boundary decides) replayed exhaustively against D3's ground truth — every decide pre-verified before Lean states it |
| D5 | `build/m26-census.py` | P3.1 full-object census + controls; P3.2 fusion inventory; point/edge counts |
| D6 | `build/m26-color.py` | P4.1 probe (symmetric-first), P4.2 controls (k=3 UNSAT, injection-verified if the fork fires) |
| D7 | `build/m26-loops.py` (or `couple.py --loops` if it parameterizes) | P3.3 length-4 witness + new minimum |

### §0 results — recorded 2026-08-09 (`build/m26-design.py --self-test`,
`build/m26-census.py --self-test`, `build/m26-color.py`, `build/m26-loops.py`;
all verdicts exact; every instrument carries a planted-failure self-test)

**E1 — geometry all confirmed; the master-form registration had one
orientation slip, caught by the instrument.** P1.1 exact (the meta-inner hex
layer IS the pivot hexagon, addresses as registered). P1.2 exact (rot6 cycles
pivots at address +1, `rot6² = metaRot`, ladders transport with shift +1).
P1.3 exact (four orbits: 6 unit / 6 adjacent / 6 meta at 1/√3 / 3 opposite).
P1.4: the four ADJACENT masters verified exactly as registered; the four
OPPOSITE masters as registered FAILED — the opposite separation `2m = (2/3)g`
is unconjugated (the adjacent `m̄ = ḡ/3` is what makes `Tr(g·w)` come out
right), so the opposite singles are **`Tr(g·w̄)` — g-traces at the reflected
address** (M25's `gTrace_clear_neg` currency). With that correction all eight
identities verify exactly, constants exactly as registered (κ-echo confirmed:
adjacent {4,7}/{2√3,5√3}/{0,3√3}; opposite {7,10}/{5√3,8√3}/{3√3,6√3}).
P1.5 confirmed: no matching branch, no hub pencil, no growth in the
8 < |b| ≤ 12 shell.

**E3 — the ground truth is SPARSER than every prior: sixteen new chords
total.** Per-family (frame (0,q₂) adjacent, (0,q₀) opposite):
* adj oo: **EMPTY**. adj oi: `{(2,±2,4,±1), (3,±2,1,±1)}`. adj io:
  `{(1,±1,5,±2), (4,±1,0,±2)}`. adj ii: `{(0,±1,2,±1), (5,±1,3,±1)}`.
* opp oo: `{(3,±2,1,±2), (4,±2,0,±2)}`. opp oi, io, ii: **EMPTY**.
* All eight fusion families EMPTY (P3.2 ✓ — the tangency at m is invisible,
  P2.4 ✓: m is never a lattice point of any of the 14 families).
* **P2.3 REFUTED at face value**: the sporadics live at |b| ≤ 2, not ≤ 1
  (six of the eight nonempty rows have a height-2 side).
* Parity signatures: adj oi (b,d) ≡ (0,1), io (1,0), ii (1,1), opp oo (0,0)
  mod 2 — one live parity class per family, as the clearing predicts.

**E3 census (B = 30, growth-checked by C2).** 5,124 labelled points, 5,082
distinct, 21,546 labelled chords with hub pencils expanded, 16,698 edges on
distinct points. Controls: the M25 8-family restriction reproduces its
points exactly; **the rot6 relabelling is verified to be an automorphism of
the ENTIRE exact edge set and of the fusion partition** — the transport
claim at census scale in one check. The fusion inventory is EXACTLY P3.2's
registration: six triple points (each pivot = its meta-inner address ∩ the
outer ladders of its two second-neighbours), the M24 pair-fusion pattern on
every unit pair (2 oi + 2 io + 1 oo beyond the triples), nothing else — and
**nine hub pencils** (the three T₁ unit hubs, the three T₂ unit hubs
transported, and the three NEW meta-inner→T₂-outer hubs `Mi(0,0)=q₀` etc.).
Two instrument bugs found and fixed by the controls, recorded honestly:
(1) the M25-inherited census finder had a **0°/360° bin-wrap bug** — a
candidate at exactly 0° from the second centre could round to bin 3600000
and miss bin 0; M25's recorded 9,048-edge count was undercounted by 3 such
seam chords (Lean theorems unaffected — the census was cross-check, not
authority; the corrected hub-unexpanded restriction count is 9,051);
(2) hub pencils were represented as markers and silently skipped by the
edge builders (M25's colour probe inherited this too — benign there, since
Lean's properness carried the hub disjunct explicitly). Both caught by the
rot6-automorphism control refusing to pass — the check working exactly as
designed.

**E4 — the fork does not fire; the symmetric branch lands.** k = 3 UNSAT
(control ✓), k = 4 SAT, b-collapsed classes: 84 → 54 after fusion merges,
186 collapsed edges, no self-loop, free 4-table SAT. **The rot6-equivariant
probe: SAT for exactly the eight 3-cycles of S₄** (all order-1/2 τ UNSAT).
The extracted table at τ = (0→1→2→0, 3 fixed) re-verifies proper against
the full labelled edge set independently of the solver (0 bad edges);
recorded in `build/m26-color-equivariant.json` and destined for the
skeleton's literal. Properness in Lean therefore runs on ORBIT
REPRESENTATIVES + the equivariance decide, not on all 21 webs.

**D7 — the length-4 prediction lands, corrected in orientation.** The
registered witness word had the inverse pair swapped (its two translations
add instead of cancel); the corrected witness
`S₀ ∘ S₁⁻¹ ∘ S_{q₀} ∘ S_{q₁}⁻¹ = id` verifies exactly (edge-vector
cancellation `(0−1) + (q₀−q₁) = 0`), length ≤ 3 is impossible (σ, σ², σ³ ≠ 1
exact, mixed length-2 words are nonzero translations), and the hexagram owns
**12 length-4 pure-seam relations** — one per pair of parallel pivot
differences, a class that is empty at the triangle (M23 minimum 6, now 4).

## §1 Scope (post-§0 shape)

1. **The object** (`Proofs/HadwigerNelson/Hexagram.lean`, imports
   `MetaLadder`, namespace `Hexagram`): the self-seeding fact P1.1 is the
   DEFINITION — `hexPivot (a : ZMod 6) : ℂ := innerPt metaPivot metaAnchor a 0`,
   so the six pivots carry their rot6-cyclic addressing intrinsically
   (a = 3 is pivot 0, a = 5 is pivot 1, a = 1 is ζ₆; even addresses are T₂).
   Anchors are direction-1: `(hexPivot a, hexPivot a + 1)`. `hexagram : Set ℂ`
   = the six pivot ladders (outer+inner) ∪ the M25 meta ladder. Value lemmas
   pin the six coordinates; `fourLadder ⊆ hexagram` gives χ ≥ 4 by M25's
   witness through subset monotonicity.
2. **Transport** (§T): `rot6 z = m + ζ₆(z − m)`, the pivot 6-cycle
   `rot6 (hexPivot a) = hexPivot (a+1)`, `rot6 ∘ rot6 = metaRot`
   (tying into M25's kit), isometry + injectivity, and the four family
   transports (pivot outer/inner, meta outer/inner) at address shift +1.
3. **The adjacent master web** (§A, frame `(hexPivot 3, hexPivot 4)` =
   (0, q₂), 3s = ḡ): oo EMPTY; oi/io/ii = the three 4-row tables (D3);
   all four fusions EMPTY. Masters per P1.4 as corrected — singles
   `Tr(g·w)`, cross `3·Tr(w₂w̄₁)` (√3-weighted per family).
4. **The opposite master web** (§O, frame `(hexPivot 3, hexPivot 0)` =
   (0, q₀), 3s = 2g): oo = the 4-row table; oi/io/ii EMPTY; all four
   fusions EMPTY. Masters carry doubled g-coefficients at REFLECTED
   addresses (`Tr(g·w̄)` — the §0 correction).
5. **The webs, a-quantified** (§W): every completeness/fusion theorem stated
   over `a : ZMod 6` and proven master + rot6-transport (M25's j-quantifier
   pattern at period 6): pivot–meta (extends M25's `Fin 3` statements to all
   six, hub pencil included; oi fusion = the two second-neighbour pivots
   `hexPivot (a±2)`), unit pairs `(a, a+2)` (M24's pair theorems
   re-addressed — M25's §C.1 kit), adjacent `(a, a+1)`, opposite `(a, a+3)`.
6. **The colouring** (§C): `hexColTab` — the τ-equivariant literal from
   `build/m26-color-equivariant.json` (τ = the 3-cycle fixing colour 3);
   the equivariance decide `colTab(rot6-image) = τ(colTab)`; decode over the
   14 families with fusion agreement (the six triple points + the unit-pair
   octets + nine hub pencils); properness per ORBIT-REPRESENTATIVE web,
   transported by equivariance; `chromaticNumber_hexagram = 4`.
7. **Census promotion** (implementation gate, M25 discipline):
   `tools/couple.py --hexagram-census` with planted chord AND fusion
   disagreements in the self-test; the wrap-bug fix and hub expansion ported
   to the promoted instrument (they live only in `build/m26-census.py` today).

MetaLadder's private engine (`web_master`/`web_master_eq`/`web_master_rev`,
`hexTrace_rows_const`, `adjacent_kill`/`adjacent_mod9`, the pin-kill trio,
`metaRot_inj`, the re-addressing lemmas) gets **promoted to public** in
`MetaLadder.lean` at the experience pass (the carry-forward's
recommendation) — the cost is one re-elaboration of `MetaLadder` and
`Proofs.lean`, no generated dependents.

Skeleton: `Proofs/HadwigerNelson/Hexagram.lean`, **50 obligations** (`sorry`
leaves) after the domain pass, elaborates clean with zero errors; the spec
examples (table reads, adjacency-table membership decides) pass at
elaboration.  Three value facts already proven at skeleton time
(`hexPivot_three` = M25's hub fact verbatim; the four membership intros).
NOT yet imported by `Proofs.lean` (added at implementation).

### Domain-modeling pass (2026-08-09, fresh invocation)

Confirmed after deliberate stress: `hexPivot`-as-the-hex-layer (the definition
IS registered prediction P1.1, and every transport proof becomes uniform in
`a` where an explicit-coordinates definition would cost six `fin_cases`
computations each); the asymmetric `6 + meta` union (the meta ladder's
difference — its ζ₁₂ anchor, its being FIXED by rot6 — is intrinsic, and a
uniform `Fin 7` index would thread an anchor-direction function through every
consumer); the `(a − 3)` shift; the joint-existential 4-branch decode, whose
payoff is ONE read lemma uniform in `a` per branch vs M25's eight.

Two deltas applied:
* **Hole**: `opp_io_empty` and `opp_fusion_io` were missing from §O (census
  says both empty; both derive from their oi mirrors at `a + 3` by
  `dist_comm`/`.symm`, one line each, but the statements belong in the API).
* **Routing correction to §1.6**: properness does NOT route through a
  pointwise `hexColor (rot6 z) = τ(hexColor z)` transport — the a-quantified
  completeness theorems already cover all six webs each, so properness is
  M25's per-family-pair decide pattern with a `∀ a` added (6× bigger decides,
  still trivial).  The two τ-equivariance decides stay as named structural
  facts (they are why the table exists, and M27's tiling extension seeds from
  them) but carry no downstream weight in this milestone.

### Already settled at subplan (four-part rows)

| choice | alternative | why | confidence |
|---|---|---|---|
| Pivots indexed by the meta-inner address (`hexPivot : ZMod 6`, definition = the hex layer) | `Fin 7` anchor list extending M25's `Fin 4` verbatim | the rot6 transport becomes `a ↦ a+1` with no case split, and P1.1 turns from a theorem into a definition; M25-compat needs only three value lemmas | high |
| Two new master webs + rot6 transport for all 21 | per-web proofs | the census automorphism check confirms exact transport; 2 masters vs 8 new webs of arithmetic | high |
| τ-equivariant colour table (3-cycle), properness on orbit reps | free table + full 21-web case bash | equivariant SAT verified + table re-verified proper on the full exact edge set; cuts the properness decides ~6× | high |
| Opposite-web masters in `Tr(g·w̄)` (reflected-address) currency | conjugating the OBJECT's addresses to make them `Tr(g·w)` | the reflected form is what the instrument verified and `gTrace_clear_neg` already speaks it | high |
| The `sphere_inter_sphere` tangency degeneracy dropped from scope | proving the circle-level tangency statement | the lattice-level fusion is EMPTY (P2.4 verified), so the headline never consumes it | high |
| Census standalone in `build/` at subplan; promotion at implementation | extend `tools/couple.py` now | M25 precedent: the subplan needed tables, not surface; promotion belongs with the gate's control discipline | high |

### Implementation §I.0 — the verified design (2026-08-09, `build/m26-design2.py`,
`m26-branch.py`, `m26-tree.py`, `m26-kill.py`; all exact, all green)

The design came out **simpler and more uniform than the obligation pass assumed** —
one master shape, one case tree, eight instances.

* **The master, hand-derived and exactly verified.** With `3·hexPivot a = g·(1+ζ₆^a)`
  (so `hexPivot a = m(1+ζ₆^a)`, the self-seeding identity as arithmetic), scaling the
  difference by `√3·ζ₆/ζ₁₂` (adjacent) or `√3/ζ₁₂` (opposite) puts EVERY new-web
  chord/fusion equation in the single shape
  `normSq(α·g·u − β·g·v − γ) = R` with α, β, γ real, whose expansion is
  `3α² + 3β² + γ² − αγ·gTr(u) + βγ·gTr(v) − 3αβ·uTr(u v̄)` — **one master lemma,
  simpler than M25's** (M25 had one g-trace and one unit word; here both singles
  are g-traces, and the cross term is the unit trace).  The opposite web's
  address shift is `−1` (its `Tr(g·w̄)` form is `gTr` at the shifted address by
  `g_shift`), the adjacent web's is `0`.  Constants exactly as registered.
* **Parity: exactly one live class per family** (verified against ground truth).
  The three dead classes each isolate ONE trace against a rational constant —
  killed by `g_pin_kill`/`g_zero_ne_kappa` (g-traces), `u_pin_kill_dvd`/
  `hex_zero_height_ne` (unit trace).  Live classes: oo (b,d both even), oi
  (even, odd), io (odd, even), ii (both odd) — for both axes.
* **The live class splits on the SIGN of (b, d)**, which fixes the height
  bookkeeping: same sign ⟹ `K = |m−n|`, `t = min(m,n)`; opposite ⟹ `K = m+n`,
  `t = 0`.  Four kills cover everything:
  | branch | kill |
  |---|---|
  | opposite signs (unit trace at the 3-adic bottom) | **φ**: `phi_g_dvd` twice + `phi_dvd` ⟹ `3 ∣ hexE − hexF`, false |
  | one g-trace strictly lowest | **alone**: `alone_dvd` ⟹ `3 ∣ gE ∧ 3 ∣ gF`, false |
  | same sign, EQUAL heights (oo, ii) | **equal**: linearity + `gE(x+3) = −gE(x)` collapses the two g-traces to ONE at coefficients `(ΔE, ΔF)`; `hexTrace_pin` ⟹ `ΔF = 0` and `ΔE·(2P+Q) = N`; `3^v ∣ ΔE` with `|ΔE| ≤ 4` forces `ΔE = 0` for `v ≥ 2`, and then `κ = 3W` (oo) / `κ = W` (ii) fails on the height-0 unit table |
  | same sign, ADJACENT heights (oi, io) | **adjacent**: M25's `adjacent_kill` verbatim, after the `+3` address shift that turns the difference into a sum (`e = (n+1)/2 ≥ 2` and `h = n ≥ 3`) |
  The residual boundaries are exactly four per axis-family, at the minimal
  heights (oo: h = 0, 2; ii: h = 1, 3; oi: n = 1; io: m = 1).
* **The boundary decides reproduce ground truth EXACTLY under the realizability
  relation** `y₃ = ±(x₁ − x₂)` (sign by `b`'s sign) — unconstrained they admit
  10 spurious triples at adj-ii and 4 at opp-ii where the truth is 4 and 0.  The
  M25 lesson, re-earned before Lean saw it.
* Cross-checks: the integer-row solver reproduces the exact-field ground truth
  for all 16 (family, κ) pairs over |b|,|d| ≤ 7, and finds nothing new out to 24.

## Implementation status — 2026-08-09, CLOSED

**M26 is closed: `Hexagram.chromaticNumber_hexagram = 4`, zero sorry, on axioms
exactly `[propext, Classical.choice, Quot.sound]`.** The full gate ran green:
`./scripts/build.sh` OK (162/162), zero-sorry scan clean, `./scripts/axioms.sh`
OK (415 clean declarations incl. all 38 M26 public theorems, 5 declared
purchases unchanged), `lake lint` passed, all five registered mutation audits
red-on-cue (dropped adjIITable row → forward decide + reverse certificates;
shift a−3→a−2 → transport type-mismatch; flipped colour entry → equivariance +
properness decides; inverse τ → the equivariance decide names the false
proposition; dropped hub disjunct → the M25 derivation breaks), and the census
was promoted (`tools/couple.py --hexagram-census`, exact 84-sweep agreement,
planted chord AND fusion refusals in `--self-test`; the 0°/360° bin-wrap fix
applied to the shared angle-bin core). One extra gate find, reported at face
value: `scripts/axioms.sh`'s banner check raced `pipefail` against `grep -q`'s
SIGPIPE once the receipt outgrew the 64 KB pipe buffer — it failed CLOSED on a
clean audit (a false alarm, not a false pass) and is fixed with here-strings.

Two structural decisions made at completion (2nd sweep), beyond the recipe:
`oo_shape` was restructured from "False given refutation hypotheses" to a
CLASSIFICATION returning the two surviving boundaries as data (the committed
form could not serve `opp_oo`'s four sporadics, which live in the `hbnd`
boundary); and the io families take `oi_shape` at negated `C` with the roles
swapped (`uTr_neg`), so no fourth shape lemma exists. Every decide, boundary
row, reverse certificate and colour agreement was verified by
`build/m26-shapes.py` (planted-failure self-test) BEFORE Lean stated it — and
every one passed in Lean on the first or second try.

The status below is the mid-implementation record, kept for the history.

**Landed and proven (18 obligations closed plus the whole engine):**
* **§0/§H the object** — `hexPivot a = m·(1 + ζ₆^a)` (the self-seeding identity
  as arithmetic), all six pivot coordinates, `hexPivot_sub`, and all five
  distance families from one lemma (`dist_hexPivot`).
* **§T the transport spine** — `rot6`, isometry, injectivity, `rot6² = metaRot`,
  the pivot 6-cycle, the four family transports at address `+1`, and the four
  ITERATED transports (`rot6^[k]`) plus iterated isometry/injectivity, which are
  what make every a-quantified wrapper one uniform proof instead of six cases.
* **§E the engine, complete and generic**:
  `hex_master` (the M26 master identity — verified first try), the four
  radius-parameterized bridges (`bridge_adj`, `fusion_adj`, `bridge_opp`,
  `fusion_opp` — 4 lemmas covering all 16 family/direction combinations),
  `hex_cleared` (the uniform clearing), `hexTrace_intMul` (linearity), the
  `+3` negation shift on the g-tables, the scaled coefficient facts, the three
  bottom kills (`kill_alone_one`, `kill_alone_two`, `kill_phi`) on the integer
  rows, the two tie kills (`kill_equal` — the equal-heights collapse;
  `kill_adjacent` — M25's mod-9 refutation with the unit coefficient stripped
  via `pow_dvd_of_not_dvd`), the rational-value readers (`g_rational`,
  `u_rational`, `u_pin_two`), and **`live_tie`** — the live-class trichotomy
  that collapses the alone/φ case bash to a single lemma for all eight families.
* **`oo_shape`** — the first family classification, COMPLETE: all four parity
  classes closed, parameterized over `C ∈ {1, 2}` so it serves BOTH the
  adjacent and opposite oo families.

**Remaining (the 32 obligations), in dependency order:**
1. Three more shape lemmas on the `oo_shape` template — `ii_shape` (live parity
   odd/odd, equal-height tie, final check `κ = W`), `oi_shape` and `io_shape`
   (live parity mixed, ADJACENT-height tie closed by `kill_adjacent` for
   `n ≥ 3` plus the `n = 1` boundary decide that carries the four sporadic
   chords).
2. The eight completeness theorems and eight fusion theorems at the master
   frames, from the bridges plus the shape lemmas.
3. The a-quantified wrappers (§A/§O/§W) via the iterated transports, the
   `hexMeta_*` extensions of M25's `Fin 3` theorems to `ZMod 6`, `unit_oo`,
   and `fourLadder_subset_hexagram`.
4. The colouring layer (§C) — the equivariance decides, the four uniform read
   lemmas, properness, and `chromaticNumber_hexagram`.
5. Gate (build, axioms, lint, the five registered mutation audits), the census
   promotion into `tools/couple.py` (with the wrap-bug fix), and the close.

### The continuation recipe (written at the checkpoint, 2026-08-09)

Everything below is derived and script-verified; it is what the next session
needs and is NOT recoverable from the Lean file alone.

**1. The eight families in `hex_cleared` currency.**  Each family's master reads
`C₁·√3^{e₁}·gTr X b + C₂·√3^{e₂}·gTr Y d + C₃·√3^{e₃}·uTr (X−Y) (b−d) = κ·√3^{e₄}`:

| family | C₁ | e₁ | C₂ | e₂ | C₃ | e₃ | e₄ | κ chord | κ fusion | X, Y |
|---|---|---|---|---|---|---|---|---|---|---|
| adj oo | 1 | 0 | −1 | 0 | 3 | 0 | 0 | 4 | 7 | x, y |
| adj oi | 1 | 1 | −1 | 0 | 3 | 0 | 1 | 2 | 5 | x, y |
| adj io | 1 | 0 | −1 | 1 | 3 | 0 | 1 | 2 | 5 | x, y |
| adj ii | 1 | 0 | −1 | 0 | 1 | 1 | 1 | 0 | 3 | x, y |
| opp oo | 2 | 0 | −2 | 0 | 3 | 0 | 0 | 7 | 10 | x−1, y−1 |
| opp oi | 2 | 1 | −2 | 0 | 3 | 0 | 1 | 5 | 8 | x−1, y−1 |
| opp io | 2 | 0 | −2 | 1 | 3 | 0 | 1 | 5 | 8 | x−1, y−1 |
| opp ii | 2 | 0 | −2 | 0 | 1 | 1 | 1 | 3 | 6 | x−1, y−1 |

**2. How each master is derived** (the step from the bridge to the table above).
`bridge_adj r₁ r₂` gives `normSq(r₁·g·w₁ − r₂·g·w₂ − 1) = R` with `R = 3` (chord)
or `0` (fusion), and `bridge_opp` the same with the constant `2` and the `−1`
address shift.  Feeding that to `hex_master` (α = r₁, β = r₂, γ = 1 or 2) yields
`(3r₁² + 3r₂² + γ² − R) − r₁γ·gTr₁ + r₂γ·gTr₂ − 3r₁r₂·uTr = 0`, and the radii
`r ∈ {1, √3/3}` give `r² ∈ {1, 1/3}`.  Multiplying through by `√3` where a radius
appears an odd number of times produces exactly the table.  The κ values follow
as `7−R`, `5−R`, `5−R`, `3−R` (adjacent oo/oi/io/ii) and `10−R`, `8−R`, `8−R`,
`6−R` (opposite).

**3. The three remaining shape lemmas, as deltas from the proven `oo_shape`.**
* **`ii_shape`** — nearly a copy.  Live parity (odd, odd) instead of (even, even);
  `C₃ = 1, e₃ = 1, e₄ = 1` so the unit term clears as `3^t` (not `3^{t+1}`) and
  the whole equation is divided by `√3` once; the tie is again at EQUAL heights
  so `kill_equal` applies verbatim; the final check becomes **`κ = W`** (the
  height-zero unit value) rather than `κ = 3W`, and it holds because
  `W ∈ {±1, ±2}` never equals `κ ∈ {0, 3, 6}`.  The dead classes swap roles:
  (even,even) pins the UNIT trace, (even,odd) and (odd,even) pin a `g`-trace.
* **`oi_shape` / `io_shape`** — the genuinely different ones.  Live parity
  (even, odd) resp. (odd, even); the tie is at **ADJACENT** heights (`m = n+1`
  resp. `n = m+1`), so `kill_equal` does NOT apply.  Instead: `kill_adjacent`
  closes every case with `n ≥ 3` (its `e = (n+1)/2 ≥ 2` and `h = n ≥ 3`
  hypotheses are exactly met), and `n = 1` is the boundary that CARRIES THE FOUR
  SPORADIC CHORDS.  So these two lemmas must NOT conclude `False`: they conclude
  the boundary data (`|b| = 2, |d| = 1` and the surviving address pairs), and the
  family wrapper finishes with a `decide` over the realizable addresses.  Use the
  `+3` address shift (`gE_shift_three`) to turn the coefficient difference into
  the sum `kill_adjacent` expects.
* All four `opp_*` families are the `adj_*` proofs with `C = 2` and the addresses
  read at `x−1, y−1`; `oo_shape` already takes `C` as a parameter, and the other
  three should be written the same way from the start.

**4. The boundary decides must use the realizability relation.**  For the
equal-height tie (`b = d`): the unit address is `Z = X − Y` when `b > 0` and
`Z = Y − X` when `b < 0`.  Free quantification over `(X, Y, Z)` admits 10 spurious
triples at adj-ii and 4 at opp-ii where the truth is 4 and 0 — verified.  The
same discipline applies at the oi/io boundary.

**5. The colour data is already in the Lean file and is the VERIFIED table.**
`hexColTab`, `hexMetaColTab` and `tau` in `Hexagram.lean` were transcribed from
the equivariant probe's solution and re-verified proper against all 16,698 exact
edges (0 bad edges).  Row `a` is the pivot's meta-inner address, column `x` the
hex address.  `build/m26-color-equivariant.json` is gitignored — the Lean file is
now the durable copy.

**6. The design scripts (gitignored, regenerable from this plan).**
`m26-design.py` (D1–D4: coordinates, rot6, orbits, the eight masters, ground
truth, the mod-9 rescans), `m26-census.py` (D5: the 14-family exact census with
the rot6-automorphism control — carries the bin-wrap and hub-expansion FIXES that
`tools/couple.py` still lacks), `m26-color.py` (D6), `m26-loops.py` (D7),
`m26-design2.py` / `m26-branch.py` / `m26-tree.py` / `m26-kill.py` (the case-tree
verification: masters in Lean currency, parity classes, the branch map, the four
kills, and the boundary decides against ground truth).  All were green with
planted-failure self-tests.

**7. Immediate next action.**  Write `ii_shape` by copying `oo_shape` and applying
the deltas in (3); it closes `adj_ii` (κ ∈ {0,3}) and `opp_ii` (κ ∈ {3,6}).

### Obligation-modeling pass (2026-08-09, fresh invocation) — the proof spines

**Partition.** Prove: everything below.  Test: the table/equivariance/properness
/agreement decides, every one pre-verified by the `m26-design2` replay (exact
Lean-shaped tree vs ground truth) BEFORE Lean states it — the first
implementation step, per M25 precedent.  Assume: nothing (all statements
closed).

**Layer 1 — values and distances (11 obligations, LOW risk).**
`dist_hexPivot_anchor` is generic (`dist z (z+1) = 1`, no coordinates).  The
six value lemmas: unfold `innerPt`, `word_k0`, then one `linear_combination`
each through `sqrt3_mul_zeta12` (e.g. a = 5: `3m = 1+ζ₆`, `√3ζ₆⁵ζ₁₂ = 2−ζ₆`,
sum 3).  The four distance families share one spine: factor
`hexPivot (a+k) − hexPivot a = (√3/3)·ζ₆^a·(ζ₆^k − 1)·ζ₁₂`, `norm_mul`, one
normSq computation per k (‖ζ₆²−1‖ = √3, ‖ζ₆−1‖ = 1, ‖ζ₆³−1‖ = 2).

**Layer 2 — the rot6 spine (8, LOW).**  `dist_metaRot`'s pattern verbatim;
the family transports are `word_succ` + ring (the anchor partner is `+1`, so
`outerPt` is `hexPivot a + word x b` — no direction factor anywhere).

**Layer 3 — the two new master webs (19, the core).**  Per family, M25's
five-step spine: bridge (scale by 3 or 3√3 → `normSq (…) = 9` — `bridge_gen`
genus, re-derived locally or promoted), master κ-identity
(`linear_combination` certificates, shapes script-verified at D2), clearing
into `hexTrace` heights {b, d, d−b} (uniform √3-power, parity split — one
live parity class per family, measured), case analysis (alone/φ/pin kills,
`adjacent_mod9` rescans — verified for BOTH coefficient scales, 2 being
invertible mod 9 — boundary decides at REALIZABLE addresses only), and the
← direction as 16 per-row norm certificates (rows at |b| ≤ 2 use `σ^{±2}`
word values).  The opposite web's reflected addresses reduce by
`word_conj` to address negation (`Tr(g·w̄₂) = gTr (−y) (−d)`) — M25's
negative-height clearing speaks it natively; the doubled coefficients pass
through every kill (φ(2g) = 0, 3 ∤ 2gE, mod-9 scans re-verified).  The
**failure clause stays registered**: a family whose endgame does not close
under the toolkit is reported NOT LANDED, χ stated conditional, open rescope.

**The wrapper spine (a-quantification) — improved over M25.**  NOT
`fin_cases a` (6 cases × ~19 wrappers ≈ 650 boilerplate lines).  Instead:
four private ITERATED transport lemmas
(`rot6^[k] (outerPt (hexPivot a) … x b) = outerPt (hexPivot (a+k)) … (x+k) b`,
induction on k over the step lemmas) plus iterated isometry; each wrapper is
then ONE uniform proof: lift `k := (a − 3).val`, substitute `a = 3 + k`,
rewrite by the iter lemmas, apply the master, ~15 lines.  `hexMeta_*` masters
are M25's PUBLIC `meta_*_complete`/`meta_fusion_*` at `j = 0` — no promotion
needed for those.  `unit_oo_complete` = M24's axis-general `oo_complete` +
two re-addressings (`q' − q = ζ₆^{a+3}`, `q − q' = ζ₆^a` — the skeleton RHS
verified to match exactly under them).  `fourLadder_subset_hexagram`: anchor
0/1/2/3 ↦ pivot families a = 3, 5, 1 and the meta family, via the value
lemmas.

**Layer 4 — the colouring (11, MEDIUM).**  The two equivariance decides are
Bool×36 table reads.  FOUR uniform read lemmas (the joint decode's payoff):
each proof cases on which earlier dite branch fires; the witness
classification is exactly the fusion inventory (within-branch: `word_inj`,
the empty adj/opp fusions, M24's unit-pair `fusion_oo`/`fusion_ii`
re-addressed; cross-branch: `hexMeta_fusion_oi` for the six triple points,
M24's `fusion_oi`/`fusion_io` for the seam octets) + table-agreement decides
(a-quantified, ~12 checks each, pre-verified — the probe's union-find
enforced them by construction).  `hexColor_valid`: `mem_hexagram_cases` on
both ends → 4×4 branch matrix → pivot×pivot splits on `a' − a` (`fin_cases`
on the DIFFERENCE, 6 values, routing intra/adj/unit/opp) → per-family
a-quantified table decides.  χ-assembly is M25's verbatim (`Colorable.mk`,
`of_hom` through `fourLadder_subset_hexagram`).

**Mutation audits (registered now, run at the gate).**  Trap caught at
design: `a − 3 = a + 3` in `ZMod 6`, so "flip the shift sign" is NOT a
mutation.  The five registered:
1. delete row `(0, 1, 2, 1)` from `adjIITable` → the ← certificate or the
   properness decide must go red;
2. `hexMeta_oo_complete`'s shift `a − 3` → `a − 2` → the wrapper transport
   breaks;
3. flip `hexColTab false 3 0` from 0 to 1 → a properness or agreement decide
   goes red;
4. `tau` → the inverse 3-cycle `![2, 0, 1, 3]` → `hexColTab_equivariant`
   goes red;
5. delete the hub disjunct `(y = a ∧ d = 0)` from `hexMeta_oi_complete` →
   its derivation from M25's theorem breaks.

### Experience-modeling pass (2026-08-09, fresh invocation) — the consumer surface

Consumers walked: M27 (the tiled plane — the primary downstream), this
milestone's own properness layer, the census-tool users.

* **The MetaLadder promotion, resolved by need enumeration** (first
  implementation step, one commit, cost = MetaLadder + `Proofs.lean`
  re-elaboration only): promote `hexTrace_rows_const`, `adjacent_kill`,
  `adjacent_mod9`, `g_pin_kill`, `u_pin_kill_dvd`, `u_pin_one`,
  `g_zero_ne_kappa`, `gTr_zero`, `uTr_zero`, `bridge_gen` (with its normSq
  helpers if the new bridges want them).  NOT promoted: `web_master`/
  `web_master_eq`/`web_master_rev` (M25-frame-specific coefficient pattern —
  M26 writes its own script-verified masters), `metaRot_inj` (superseded by
  `rot6_inj`), the `outer1_swap`-family re-addressings (M26 derives its own
  from the public `outerPt_hexRot`).
* **Names**: `adj_`/`opp_` web prefixes KEPT — spelling out `adjacent_` would
  collide in connotation with `adjacent_kill`, where "adjacent" means
  HEIGHTS.  `tau` stays (namespaced, and the plan's own vocabulary).  The
  module doc gains one address-convention line ("pivots indexed by meta-inner
  address; the origin pivot is a = 3; classifications read at shift a − 3") —
  the `a − 3` placement itself re-examined and kept: moving the constant into
  the definition would desync every M25 citation (its hub lives at address 3)
  and the self-seeding definition is the mathematical content.
* **Visibility**: the iterated-transport lemmas PRIVATE (the per-step
  transports are the API; the iteration rebuilds in five lines if M27 wants
  it); the four uniform read lemmas (`hexColor_outer` etc.) PUBLIC — "the
  decode returns the table on every family" is consumer-grade, and their
  docstrings state the fusion-agreement guarantee.  Zero `@[simp]` tags,
  house precedent.
* **Census promotion sharpened — a cross-tool finding**: the 0°/360°
  bin-wrap bug lives in the shared angle-bin core `tools/couple.py`'s
  `--meta-census` was promoted FROM, so implementation must (1) patch the
  existing tool path, (2) re-run its planted-disagreement self-test (check
  10b), and only then (3) add `--hexagram-census` with planted chord AND
  fusion disagreements, hub pencils reported as pencils plus expanded edge
  counts (matching the Lean hub disjuncts).

## M25 carry-forward (recorded at the M25 close, 2026-08-09)

What the M26 subplan can take as settled, and where the tooling lives:

* **The engine transfers whole.** `√3·ζ₁₂ = 1 + ζ₆` (`MetaLadder.sqrt3_mul_zeta12`)
  eliminated the twelfth root from every 1/√3-axis equation; the mirror-centroid
  axes are again ζ₁₂-coset directions at 1/√3 (and 2/√3 = 2·(1/√3) for the
  opposite pairs), so the same clearing applies. The expected master shape stays
  `κ − Tr(g·w₁) − μ·Tr(g·W) + λ·Tr(V) = 0` with new (κ, μ, λ) per radius pair —
  re-derive by the `build/m25-design2.py` pattern (exact tree vs exact ground
  truth over a window) BEFORE writing Lean; every M25 decide passed first try
  because of that discipline, and the one decide that was false as first stated
  (a boundary quantified over unrealizable addresses) was caught by it… by the
  kernel; the script check is what would have caught it earlier. Constrain
  boundary decides to REALIZABLE addresses (x₃ and y are functions of A, c and
  the seam signs — quantifying them freely can make a true kill undecidable).
* **The fusion-κ trick is anchor-generic**: a coincidence classification is the
  chord classification at normSq = 0, i.e. the same κ-parameterized spine at a
  shifted constant (M25: oo 4→7, oi/io 2→5, ii 0→3√3). Plan M26's decode
  well-definedness as κ-instances from the start, not as a separate enumeration.
* **`adjacent_kill` / `adjacent_mod9`** (two g-traces at heights h, h+1 never
  sum to 9·anything; residues pinned to {1,4,7} mod 9) closes height-unbounded
  endgame branches; it is address-table-generic over the gE/gF tables and
  should port to whatever coefficient tables the mirror-centroid webs produce
  (re-verify the 36-pair scan for the NEW tables first).
* **Public vs private in `MetaLadder.lean`**: public — `hexTrace`,
  `hexTrace_coords`, `inRing_hexTrace`, `gTr`/`uTr`, `gTrace_clear`/`uTrace_clear`,
  `gAddr`/`uAddr`, `hexTrace_rows`, `hexTrace_add`, `hexTrace_zero_height`,
  `hexTrace_eq_zero`, `hexTrace_pin`, `not_three_dvd_pin`, `alone_dvd`, `phi_dvd`,
  `phi_g_dvd`, `gE`/`gF` + their table facts, the bridges and fusion bridges, the
  four completeness and four fusion theorems, the transports. Private (re-derive
  locally per the house §0 pattern, or promote at the M26 experience pass) —
  `hexTrace_rows_const` (the κ-row extractor), `adjacent_kill`/`adjacent_mod9`,
  `web_master`/`web_master_eq`/`web_master_rev`, the per-family masters and
  cleared lemmas, the pin-kill wrappers (`g_pin_kill`, `u_pin_kill_dvd`,
  `u_pin_one`, `g_zero_ne_kappa`), `metaRot_inj`, the re-addressing lemmas
  (`outer0_to02` etc). Promoting `hexTrace_rows_const`, `adjacent_kill` and the
  pin-kill trio to public is probably the right M26 experience-pass call.
* **Lean idioms that cost time in M25** (all recorded in the session memory too):
  `Eq.trans` chains instead of `rw … at hspec` when the hypothesis mentions an
  `Exists.choose` whose ∃-type contains the rewritten term;
  `linear_combination (norm := (push_cast; ring)) h` whenever `h` carries
  compound casts; keep pow-atoms syntactically identical for `omega` (no
  `norm_num at` on them); multiline `.trans` continuations must indent past the
  `have` column.
* **The M26-specific new work** (updated by §0 above): the 2/√3-axis and
  adjacent-axis derivations (the tangency case DELETED from scope per P2.4),
  the 7-centre loop census with the registered length-4 parallelogram
  prediction (P3.3), and the D₆ symmetry decision — RESOLVED at registration:
  ℤ/6 rotation transport (rot6), reflections unnecessary (P1.2/P1.3).
