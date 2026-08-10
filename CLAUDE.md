# Engineering standard
@DEBRUIJN.md

# Workflow
@WORKFLOW.md

# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. We write theorems,
programs, and tactics to the **de Bruijn** standard (above) and work milestone-by-milestone through
WORKFLOW. Everything reduces to what the kernel checked plus what we explicitly chose to trust.

## The mission

How many colours does the plane need so that no two points at distance exactly 1 share a colour?
Known since 1950 to be 4, 5, 6, or 7. De Grey (2018) ruled out 4 with a 1581-vertex unit-distance
graph that is not 4-colourable. Our ratchet:

- **A. χ(ℝ²) ≥ 4** — the Moser spindle. Small, classical, and it exercises the entire pipeline
  end to end. ✅ Landed.
- **B. χ(ℝ²) ≥ 5** — de Grey's graph, kernel-certified. ✅ Landed (M06–M09), on axioms exactly
  `[propext, Classical.choice, Quot.sound]`. **The write-up is deferred indefinitely** (Kooshi,
  2026-08-02): a formalization of a known theorem is no longer news, and reproducing one is
  nearly free. It exists as our foundation, not our product.
- **C. The search instrument** — the infrastructure from B turned outward: shrinking, criticality,
  fractional bounds, fans, the narrowing sweep, the growth-family hunt. ✅ Built through M17.
- **D. χ(ℝ²) ≥ 6** — the hunt. May not exist; may be astronomically large. Every rung below it
  pays regardless.

**The mission, restated 2026-08-02: this project is exclusively a hunt for new mathematics — no
matter how small — ratcheting toward major findings.** Formalizing known results is over as a
goal in itself; a formalized statement earns its place by being *structure nobody had named*
(however elementary) or a rung toward χ ≥ 6. The live state of the hunt is § Frontier below —
**updated at every milestone closing**, without exception.

State failure modes plainly and keep the ratchet honest: a rung that does not land is reported as
not landed, not quietly rescoped. **All write-ups and upstreaming are deferred until something
lands that is worth the time and effort to publish** (Kooshi, 2026-08-04) — this covers the
rung-B write-up, Mathlib contributions, and any exposition; the deferral is standing policy,
revisited only when the Frontier holds a publication-worthy result.

See `ARCHITECTURE.md` for the module DAG and the milestone roadmap; `plans/` for per-milestone
subplans.

## Frontier

*The current state of the art, the ledger of everything novel this project has produced, and
the live paths forward. Maintained as part of every milestone's closing commit (WORKFLOW
step 9); a milestone whose close does not update this section is not closed.*

**Last updated: M30, 2026-08-09.**

### Where the problem stands

χ(ℝ²) ∈ {5, 6, 7} (de Grey 2018 for ≥ 5; the hexagonal 7-colouring for ≤ 7). This
repository holds a kernel-certified χ(ℝ²) ≥ 5 on axioms exactly
`[propext, Classical.choice, Quot.sound]` (M06–M09). Above that: every published witness
and every growth family we built has been swept with certified or exhaustive negatives
(M15–M17); distance-to-confinement (`minCov`) is pinned to the rainbow floor of 3 at all
6,173 pivots ever examined, and M19–M20 turned the pin into theorems: the cover set alone
is always 3-colourable (M19), one pivot's *whole* system is exactly 4-chromatic (M20),
and extension pressure in the plain closure is exactly zero. **The 5th colour provably
requires structure spanning more than one pivot** — so M21 went to two and found the
hunt's first nonzero gradient: at the closure's strongest-coupled pair, 52% of pattern
pairs die on the cross chords alone and 32% of the survivors are killed by the ambient
graph (verified, null flat). M22 named the pressure's shape and made the geometry
fully general. The **gluing classification is now certified for any two circles in
the plane** (`Glue.lean`): distinct centres plus the annulus condition give exactly
{an explicit glue point, its mirror under ratio-conjugation reflection}, empty outside
— the statement every partner adjunction and every metapivot coupling instantiates.
The **first certified near-relation** landed: nine seam steps miss one hex step by
chord < 1/50 and provably never close (θσ is incommensurate — the loops are
almost-cycles forever, so only *colour* closure is live). The kill census named the
mechanism: outer-circle constraints are necessary in every ambient kill, inner in
75%, and greedy cores are 4–8 pins (median 6) leaning inner — a clamp specification
for gadget design. And the partner web is nearly closed already: two thirds of all
unit-partners collide back into the lattice, k = 4 stays SAT through two closure
generations (~10⁶ triage edges) — **depth will not force the χ fork; new structure
will**. M23 built the structure: the pivot triangle (0, 1, ζ₆) with its metapivot
(the centroid) is now a certified layer — the triangle is **self-glued** (each
pivot is the outer∩outer glue point of the other two), the whole 8-circle object
crosses itself in exactly 34 points inside the seam field, the cross-web between
unit-separated systems is **classified** (outer–outer chords are rigid: the
translation matching is complete; inner–inner chords are a rational Möbius
graph; the √disc field growth lives ONLY in mixed-radius chords), and the
**seam hexagon** — the minimal closed loop of seam rotations, which provably
needs all three pivots — is kernel-checked, as an instance of a rotation-hexagon
identity that turned out generic. The registered statistics cut the other way,
and are reported at face value: M22's post-hoc "seam-aligned kill mechanism"
**failed its registered replication at four fresh pairs (0/4)** and is demoted
to single-pair anecdote; the coset census came in under threshold; and the
triple-kill census's registered population is provably EMPTY (unit triangles are
never "far" — their systems always interlock through the shared glue points, the
ten-point theorem operating on the instrument). What survived everything:
ambient kills are **gated by coupling strength** (0/3,200 draws at 22 cross
chords; 12–15% at 40), and the constraint-flow skeleton the triangle uniquely
owns is now exact mathematics awaiting its colour question. M24 (re-planned on
Kooshi's go into the completeness milestone, roadmap M24–M29) answered at the
pair: the **matched ladder pair** — the countable ⟨ζ₆,σ⟩-lattice on both
pivots' four circles, closed under every unit chord — has **chromatic number
exactly 4, unconditionally**. Every chord family is now a theorem rather than
a census window: outer–outer is matching-or-hub, inner–inner is matching plus
exactly ten explicit solutions, outer–inner is exactly sixteen chords ever (no
infinite family), the intra families are exactly the hex/rot3/seam steps, and
the eight fusion points are pinned — so M23's conditional verdict is now
closed, and the 5th colour provably needs MORE than the full two-pivot
countable lattice. The engine is new and elementary — clearing by √3-powers
into ℤ[ζ₆,π] (π = √3σ, π² = π − 3), separation on √3 ∉ ℚ(ζ₆,π), coordinate
congruences mod 3, and a trace-pair telescope from the π-power recurrence; the
registered π-adic valuation sketch was superseded by less machinery, not more.
M25 climbed the first rung of the construction ladder: the **four-ladder
object** — the ⟨ζ₆,σ⟩-ladders of all three pivots 0, 1, ζ₆ PLUS the
metapivot's own ladder (anchored along ζ₁₂), closed under all unit chords —
has **chromatic number exactly 4, unconditionally**. The registered ζ₁₂-ring
engine was superseded by LESS machinery, exactly as M24's valuation sketch
was: one identity, **√3·ζ₁₂ = 1 + ζ₆**, collapses every meta-axis web
equation into M24's ℤ[ζ₆,π] trace pairs — the twelfth root never enters the
arithmetic. All twelve pivot–meta chord families are theorems (oo/io/ii: four
sporadic chords per web, all at |b| ≤ 1; oi: the hub pencil through the fused
pivot plus four sporadics; the three webs one theorem via the 120° transport).
And the **fusion inventory came free**: a point coincidence is the same
cleared equation at norm 0, so each fusion classification is the chord run at
a shifted constant (oo 4→7, oi/io 2→5, ii 0→3√3) — oo/io/ii fusions are
EMPTY and the oi fusion is exactly the other two pivots, certifying M23's
"the metapivot couplings create no new points" at the lattice level. M26
climbed the second rung: the **hexagram** — the six pivots of the hexagon of
circumradius 1/√3 about the metapivot (the M23 triangle PLUS its mirror
image, i.e. the mirror centroids promoted to pivots), each with its full
⟨ζ₆,σ⟩-ladder, plus the metapivot's own, closed under ALL unit chords — has
**chromatic number exactly 4, unconditionally**. The finds that made it
land: the object is **self-seeding** (the six pivots ARE the metapivot's
inner hex layer at seam height zero, `hexPivot a = m(1+ζ₆^a)`, so M23's
glue-point certification became address bookkeeping); the 60° rotation
about the metapivot is an automorphism cutting the 21 centre pairs to FOUR
orbits, so only TWO master webs were ever new (adjacent and opposite); and
both clear through `g = 1+ζ₆` into ONE master identity whose two singles
are both g-traces — M24's engine, again with LESS machinery. The new webs
carry exactly sixteen sporadic chords (adjacent oi/io/ii and opposite oo,
four each, |b| ≤ 2) and NOT ONE new coincidence — every fusion family is
empty, the triple tangency at the metapivot invisible, so the mirror
triangle glues to the original exclusively through the points M23 named.
The colouring is rot6-**equivariant** (colour ∘ rot6 = τ ∘ colour for a
3-cycle τ fixing colour 3 — the first colour symmetry of the hunt), and
the census instrument that checked it caught two real bugs in the standing
tool by its own automorphism control. The 5th colour now provably needs
more than the full seven-ladder, six-fold-symmetric countable hexagram.
M30 opened the new field with the anatomy of the 5-forcers, and the
measurements redrew the map. The **field-wall thesis is now kernel-checked**
(`FieldWall.lean`: ρ·σ² = −1, so the Moser twist is ζ₆³σ⁻² — inside the seam
group). The 1581's complete direction inventory is just **67 classes**, and
the registered group ⟨ζ₆,σ,ρ₁₅,ρ₆₃⟩ holds only 58% of the edges as whole
words — but every missing direction SQUARES into it, and the true group is
the **half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩** (√ρ₁₅ = (√15+i)/4,
√ρ₆₃ = (3√7+i)/8), which closes all 67 at exponent ≤ 6 — de Grey's own
half-angle frame, re-derived from pure edge data. Heule's 510/553 are NOT
pure de Grey-group objects (6 residue direction classes each, ~10 edges);
the only pure-group witness is the 1581. The concentration bet died at face
value: 819 circles about one centre, 4,140 coarse classes, top-6 = 3.7%
(registered ≥ 70%), flat direction head — and the matched control deflated
the load-bearing census entirely: **de Grey's graph is at or near
edge-critical** (single random edge deletions flip it 4-colourable), so the
5-forcing is distributed, not organ-like. The new rigidity instrument
(complete forced-pair + virtual-edge sweeps with three-outcome honesty,
validated red/green on every control) reproduced M13's forced pair and found
what M13 never looked for: de Grey's 791-point forcer forces **six** pairs —
the known axis pair at distance 4 plus **five antipodal pairs at distance
4/√3** (not spindle-able in the field; needs √183): every proper 4-colouring
of the forcer is centrally symmetric on the radius-2/√3 circle. A forced
colour symmetry, where M26's equivariance was chosen. The 2-adic risk is
confirmed exact ((1+i√15)/2: x² = x−4; (1+i√63)/2: x² = x−16), and the
anatomy visualizer (`tools/degrey-viz.html`) renders all three witnesses
with per-class toggles and the forced-pair overlay.

### The novel-results ledger (all kernel-checked unless marked)

| # | Result | Where | Milestone |
|---|---|---|---|
| 1 | **The two-circle theorem**: every unit-distance graph on the circles of radius 1 and 1/√3 about a common point — the full uncountable set included — is 3-colourable. The local barrier: no cover-set-internal gadget beats the rainbow floor. | `TwoCircle.lean` (`colorable_three_induce`/`_comap`) | M19 |
| 2 | **The seam identity**: the cross-chord rotation between the two circles is `(√3 + i√33)/6`, of infinite order (its trace squares to 1/3, no algebraic integer) — the true geometric identity of the √33 "resistance" family, and the fact that makes two-circle labels a strip `ℤ/6 × ℤ`, never a torus. | `TwoCircle.seam_pow_ne_one` | M19 |
| 3 | **The coverage ratchet**: coverage lower bounds (`CoverAtLeast`) are monotone under adding edges, widening the class, lowering the level; at level k the property *is* the fan. Gadget-union hunting climbs a certified gradient. | `CoverageMono.lean` | M19 |
| 4 | **Fan ⟺ compulsory coverage**: a pivot is fanned iff every proper k-colouring puts all k colours on `N(p) ∪ Q` — confinement as a measurable number. | `Coverage.lean` (`fan_iff_coverage`) | M18 |
| 5 | **No class confines alone**: two circles share ≤ 2 points ⟹ in-class degree ≤ 2 ⟹ every class-only graph is 3-colourable ⟹ a 4th colour always frees the pivot. Confinement is an interplay theorem. | `ClassGeometry.lean` (`not_fan_classOnlyGraph`) | M18 |
| 6 | **The 120° triangle identity**: a unit triangle sits on a circle about p iff r² = 1/3, and the equidistant point is the centroid; the ℤ/3 closure partitions the class into rainbow triangles. | `ClassGeometry.lean` (`exists_unit_triangle_iff`, `rot3_unit_triangle`) | M18 |
| 7 | **Greedy colouring** (`degree < k` everywhere ⟹ k-colourable), genuinely missing from Mathlib. | `Greedy.lean` | M18 |
| 8 | **De Grey's graph admits a balanced 5-colouring** — class sizes [317, 316, 316, 316, 316], the pigeonhole optimum, kernel-certified from a packed witness. No density obstruction at witness scale (closure scale too, tools-only). | `DeGreyBalanced.lean` | M19 |
| 9 | **The 120° compulsion** (M20): in every proper 3-colouring of the two circles, an outer 120°-triple — three pairwise *non-adjacent* points — is never monochromatic: its seam-image unit triangle is rainbow and refuses. The first colour compulsion here that acts through no edge. | `Compulsion.lean` (`no_mono_outer_triple`) | M20 |
| 10 | **The one-pivot cap**: {p} ∪ both circles has chromatic number exactly 4 — nine points force the 4th colour (centre + five consecutive outer + the witness triangle); M19's colouring plus a fresh colour at p gives ≤ 4. Coverage 4 at five colours cannot arise inside one pivot's system. | `Compulsion.lean` (`chromaticNumber_concentric`) | M20 |
| 11 | **The strip automaton**: the two-circle graph splits into two tubes (parity invariant); per tube the colouring theory is exact — the recurrent core is (non-mono hexagon columns) × (all rainbow pairs) = 864 states, one SCC; every non-mono hexagon admits exactly 4 avoiding rainbow columns whose continuations count {2,2,4,4} — the space grows by exactly ×12 per column; and the **window-extension theorem**: every proper colouring of a ≥2-column window extends to the whole bi-infinite tube (the lone mono-parity column is the only finite obstruction). Finite parts by kernel `decide` against literal tables; the extension is computable. | `Strip.lean` (`window_extends`, `twostep_card`, …) | M20 |
| 12 | **The extension profile** (instrument + measurement): per pivot, every locally-legal 3-pattern of the cover set SAT-tested for ambient realizability — bias-free by construction; controls both ways (a certified-confined pivot shows an empty profile, 1,000/1,000 sampled patterns killed). At the closure's doubling pivot the profile is FULL (6,144/6,144). | `tools/extend.py` + `build/m20-profile-630.json` (tools-side) | M20 |
| 13 | **Negative knowledge, held to the same standard**: growth-family hunt closed exhaustively (M17, 557M class-tests); "ambient near-forcing" retracted — pool statistics measure the SAT solver's tastes, not the colouring space (three pre-registered hypotheses refuted with matched controls, M19 §0); pentagon exclusion is a fact about the coordinate field, not the plane (M18). | plans + instrument docstrings | M17–M19 |
| 14 | **The pair-gluing classification**: for two pivots at distance 1, every one of the four circle-pair intersections is *exactly* {a point, its mirror} — outer∩outer = the hex step, outer∩inner = the seam image (each way), inner∩inner = the new half-sector direction `⟨1/2, √3/6⟩` = ζ₁₂/√3 — all under ONE involutive isometry `reflAcross` (the configuration's whole symmetry), with the interlock `seamImage p q ∈ inner_p ∩ outer_q`. The 5th-colour lower bound holds superset-quantified: any vertex set containing one pivot's system needs 4 colours. | `Coupled.lean` (`outer_inter_outer` …, `four_le_chromaticNumber_of_system_subset`) | M21 |
| 15 | **The first nonzero extension pressure** (tools-side, verified): at the closure's strongest-coupled far pair (d = 1, 40 cross chords), 785/1500 sampled pattern pairs die on the cross chords alone and 229/715 of the locally-feasible are killed by the ambient graph — every sampled kill re-confirmed through an independent pin-only injection encoding; the null pair is 1500/1500 flat. The pressure is *selective*: the union's coverage floor stays 3 and the pair lattice stays 4-colourable at every affordable depth. Each kill is already in `Fan.of_unsat` pin-cube form. | `tools/couple.py` + `build/m21-joint-695-2044.json` | M21 |
| 16 | **The coupled automaton is dead, exactly**: no relation `u^{2m}σ^lζ₆^k = 1` at any probed pivot pair (\|m\|,\|l\| ≤ 6) — the coupling phase is incommensurate with the strip lattice everywhere, so two coupled strips never form a finite-state product; and **no pair of rotated/reflected/re-paletted 60°-sector colourings is proper on the d = 1 pair** (full continuous-offset sweep, killed by the outer–outer curve family alone) — any χ ≤ 4 proof for the pair needs a construction shape nobody has named. | `tools/couple.py` (`--phase`, `--mesh`) + `build/m21-phase.json` | M21 |
| 17 | **The general gluing classification**: for ANY two distinct centres and any radii under the annulus condition, the circle intersection is exactly {an explicit glue point, its mirror} — the glue point division-once with the **gluing discriminant** under its √ (the exact object partner adjunction adjoins), the mirror by ratio conjugation (`reflAxis`, an involutive isometry at every axis, collapsing to M21's `reflAcross` at unit axis); empty cases certified both ways; radius nonnegativity *derived*, not assumed. Subsumes M21's four gluings; the metapivot instance (axis 1/√3) is a spec example. | `Glue.lean` (`sphere_inter_sphere`, `reflAxis_*`) | M22 |
| 18 | **The first certified near-relation**: `ζ₆·σ⁹` misses 1 by chord < 1/50 (`normSq (ζ₆σ⁹ − 1) < 1/2500`; numerically 1.008°, chord ≈ 0.0176) AND `ζ₆·σ⁹ ≠ 1` (via σ⁵⁴ ≠ 1, the seam's infinite order) — nine seam steps almost close one hex step, and provably never do. Both halves exact field arithmetic in ℚ(√3,√11,√33). The aiming lemma of the colour-closure thread. | `Glue.lean` (`zeta6_mul_seam_pow_nine_ne_one`, `normSq_zeta6_mul_seam_pow_nine_sub_one_lt`) | M22 |
| 19 | **The kill mechanism named + the partner web measured** (tools-side, controlled): ambient kills need the partner's OUTER circle in 100% of probed cases and the inner in 75%; greedy pin cores are 4–8 pins (median 6), leaning inner on the pinned side; local kills are multi-class Hall failures (0/804 starvation); local slack does not predict ambient death — the clamp specification for gadget design. Post-hoc decomposition (single pair, unregistered — M23 §0 re-tests it): core-pin separations concentrate on the pure seam-angle lattice {j·θσ mod 60°} (+15 pts over matched controls, above all decoys) and are depleted at the half-offset (−19 pts); the near-cycle-shadow reading was refuted by a 20-decoy specificity sweep. **DEMOTED at M23**: the seam-alignment reading failed its registered replication at four fresh 40-chord pairs (0/4; excesses +7.4/−7.3/+12.1/−13.4) — single-pair anecdote, not a mechanism. Partner closure: 67–70% of unit-partners collide back into the lattice; the field grows far less than feared — 76% of adjunction instances are FREE, radicand already square in ℚ(√3,√11) (sympy-exact, five planted controls, from the `opus-larp` branch's parallel pass — superseding M22's 37.5% PSLQ triage, which sampled only non-collided partners); and k = 4 stays SAT through two generations (15,619 points, ~2.4M triage edges at the full depth-20 base) — the fork does not move by depth. Near-cycles are dense and CF-structured (records at l = 1, 4, 5, 9, 59; every probed pair < 0.3° at word length ≤ 12). | `tools/couple.py` (`--kills`, `--partner`, `--near`) + `build/m22-*.json` | M22 |

| 20 | **The pivot-triangle layer** (all kernel-checked): the triangle is self-glued — `hexStep` permutes the pivots cyclically, so outer∩outer of any two pivots = {the third pivot, its mirror}; the centroid is the (+)-branch ii glue of ALL THREE pairs; the metapivot couplings create no new points — outer(pᵢ)∩inner(m) = the other two pivots, inner(pᵢ)∩outer(m) = the two 120°-partners, inner(pᵢ)∩inner(m) = the two mirror centroids; **the ten-point sharing theorem** (two unit-separated systems share exactly {pivots} ∪ {eight glue points}, with `ncard = 10`); **the chord classifications** — outer–outer unit chords are RIGID (translate ∨ hub: the perfect matching is complete, for the full uncountable circles) and inner–inner chords are matching ∨ the rational Möbius graph x(3y−2) = y, so √disc field growth is localized to mixed-radius chords; the translation coupling; and the loop layer — the **rotation hexagon** (S₂⁻¹S₁S₀⁻¹S₂S₁⁻¹S₀ = id for ANY unit rotation about ANY three points — found generic at implementation) with the seam instance, the hex parallelogram (hex-specific, minimal at 4), and the zpow closure backbone. Census (exact, tools): 34-point inventory in the seam field, 7 triple points; seam relations minimal at 6, all 3-pivot, none 2-pivot; R_m unreachable from pivot words. | `Triangle.lean` + `tools/couple.py --loops/--export-viz` | M23 |
| 21 | **The registered statistics, reported at face value** (tools-side): ambient kills are **coupling-strength gated** — 0 kills in 3,200 draws at four 22-chord fresh pairs vs 12–15% kill rate at every 40-chord fresh pair (all kills injection-verified); M22's seam-alignment reading **failed registered replication** (0/4 pairs; demoted per its pre-committed failure clause); the coset census under threshold (×0.83–1.51 vs registered ≥2×); the metapivot's cover floor stays 3 (registered null confirmed; higher unions read 4 for reasons the self-gluing theorems explain); and the triple census's registered population is **provably empty** — unit triangles are never "far", their cover sets always interlock through the shared ten points. | `tools/couple.py --replicate/--floor --systems` + `build/m23-*.json` | M23 |
| 22 | **The matched ladder pair is exactly 4-chromatic, unconditionally** — the countable two-pivot ⟨ζ₆,σ⟩-lattice closed under ALL unit chords. Every chord family is a theorem: oo = matching ∨ hub (`oo_complete`); ii = matching ∨ ten table rows, via the parity split in ℤ[ζ₆,π] — mixed parity impossible, even collapses on the backbone, odd closes by mod-3 coordinate congruences, mixed SIGNS die through the collapse π^b·π̄^e = 3^e·π^{b−e} (`ii_norm_complete`); oi = **sixteen chords ever, no infinite family** — the trace pair T(x,h) = ζ₆^x π^h + ζ₆^{−x} π̄^h, uniform √3^(m+n+k) clearing, three parity kills, address pins feeding a telescope kill, three 36-pair boundary checks (`oi_complete`); intra = hex/rot3/seam exactly; eight fusions pinned; plus the 24-entry b-independent colouring proper on every family and the nine-point witness forcing 4 (`chromaticNumber_ladderPair`). First exact chromatic number of an infinite genuinely-coupled object; the first Frontier χ-equality with no census window and no conditional clause. Supporting cast now reusable: `sqrt_indep` (ℚ-independence of {1,√3,√11,√33}), the axis-general master identities, the Re = √3/2 fibre proven EMPTY (ζ₁₂ never lattice). | `Ladder.lean` (`chromaticNumber_ladderPair`, `ii_norm_complete`, `oi_complete`, `iiNormTable`/`oiTable`) | M24 |
| 24 | **The hexagram is exactly 4-chromatic, unconditionally** — the six pivots of the 1/√3-hexagon about the metapivot (M23's triangle plus the mirror centroids), all seven ⟨ζ₆,σ⟩-ladders, closed under ALL unit chords. The engine: the **self-seeding identity** `hexPivot a = m·(1+ζ₆^a)` (the pivots are the meta-inner hex layer, so every hexagram coordinate is one metapivot multiplication from a hex root); the **rot6 orbit collapse** (60° about m is an automorphism ⟹ 21 centre pairs, FOUR orbits, only adjacent + opposite webs new); ONE master identity `normSq(αgu−βgv−γ)` with BOTH singles g-traces, cleared by `hex_cleared` into M24 trace pairs; one live parity class per family, four kills (alone/φ/equal-height collapse/M25's mod-9 adjacent-height), and the two surviving boundaries returned as data for per-table decides. All eight new-web families are theorems (`adj_oo_empty`, `adj_oi/io/ii_complete` — four sporadics each; `opp_oo_complete` — four sporadics; `opp_oi/io/ii_empty`), all eight fusions EMPTY (the mirror triangle touches the original ONLY at M23's glue points; the tangency at m invisible), the pivot–meta webs extended to all six addresses free by transport, unit pairs in hexagram currency, and the rot6-equivariant 4-colouring (`colour∘rot6 = τ∘colour`, τ a 3-cycle) proper on every family. On axioms exactly `[propext, Classical.choice, Quot.sound]`. Census promoted: `tools/couple.py --hexagram-census` (exact 84-sweep, planted chord+fusion refusals); two real instrument bugs (0°/360° bin wrap, hub-marker skip) found by the rot6-automorphism control and fixed; plus a gate bug in `axioms.sh` (pipefail vs `grep -q` SIGPIPE past 64 KB) that failed CLOSED, repaired. | `Hexagram.lean` (`chromaticNumber_hexagram`, `adj_*`/`opp_*`/`hexMeta_*`/`unit_oo_complete`, `hexColTab_equivariant`) | M26 |
| 23 | **The four-ladder object is exactly 4-chromatic, unconditionally** — the pivot triangle's three ladders plus the metapivot's own (anchored along ζ₁₂), closed under ALL unit chords. The engine: `√3·ζ₁₂ = 1+ζ₆` (`sqrt3_mul_zeta12`) eliminates the twelfth root, so M24's ℤ[ζ₆,π] machinery carries verbatim through `hexTrace` (trace pairs with arbitrary ℤ[ζ₆] coefficients). All twelve pivot–meta families are theorems (`meta_oo/oi/io/ii_complete`, j-quantified over the three webs by the 120° rotation transport); the **fusion inventory is certified by the same engine at norm-0 constants** (`meta_fusion_*`: oi = the two shared pivots, oo/io/ii EMPTY); the kills beyond M24: `alone_dvd` and `phi_dvd` (the generic 3-adic pair) and the mod-9 `adjacent_kill` — two g-traces at heights h, h+1 never sum to 9·(anything), the piCoeff recurrence confining the two deep residues to {1,4,7} — which closes the height-unbounded branches a census can only sample. Colouring: the 48-entry b-independent `metaColTab`, decode well-defined by the fusion inventory, properness per family; χ ≥ 4 transports M24's witness. Census promoted: `tools/couple.py --meta-census` (planted-disagreement self-test). | `MetaLadder.lean` (`chromaticNumber_fourLadder`, `meta_*_complete`, `meta_fusion_*`, `adjacent_kill`) | M25 |
| 25 | **The field-wall identity, kernel-checked**: the Moser spindle's twist rotation ρ (cos 5/6, sin √11/6) satisfies ρ·σ² = −1, i.e. ρ = ζ₆³·σ⁻² — the twist that forces the 4th colour is a word in the seam group, while the 5-forcers need √5 and √7. The thesis that moved the programme off the seam field, as a theorem. | `FieldWall.lean` (`moserTwist_mul_seam_sq`, `moserTwist_eq_zeta6_cube_mul_seam_inv_sq`) | M30 |
| 26 | **The de Grey anatomy** (tools-side, every instrument control seen red/green on cue): the 1581 has exactly **67 edge-direction classes**, ALL words in the half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ at exponent ≤ 6 (the registered whole-word group covers 58%; every miss squares in; σ-exponents only {0,±1,±2}); Heule 510/553 carry 6 out-of-group residue classes each — the 1581 is the only pure-group witness; E3 refuted (819 circles, 4,140 coarse classes, top-6 = 3.7%, flat head) and the load-bearing census deflated by its matched control — **the 1581 is at or near edge-critical**, the 5-forcing distributed; the complete forced-pair inventory of the 791 forcer: **six pairs** — M13's axis pair plus five ANTIPODAL pairs at distance 4/√3 (√183-spindle, outside the field): every proper 4-colouring is centrally symmetric on the radius-2/√3 circle; E2 exact (norms 4 and 16 — the M32 clearing is 2-adic); fusion record {1:1344, 2:234, 4:1, 24:2}. Instruments promoted: `tools/anatomy.py`, `tools/rigidity.py` (complete pairwise forced-equal/virtual-edge oracle, batch violation queries, vacuity guard), `tools/hexchunk.py`, the anatomy visualizer `tools/degrey-viz.html` + `tools/degreyviz_refresh.py`. | `build/m30-anatomy.json`, `build/m30-rigidity-forcer791.json`, `plans/M30-degrey-anatomy.md` §R | M30 |

### Paths forward, ranked

*Rewritten 2026-08-09 at the field-jump decision. The construction ladder
(M24 pair → M25 four-ladder → M26 hexagram, all χ = 4 exactly) closed the
seam-field arc, and the closing observation reframed the hunt: the Moser
spindle's twist rotation is ρ = ζ₆³·σ⁻² — INSIDE the seam group — so the
classical 4-forcers are native to ⟨ζ₆, σ⟩, while the only known 5-forcers
(de Grey 1581, Heule 553/510, all kernel-certified in this repository) live in
ℚ(√3, √5, √7, √11), a field the seam lattice cannot reach. **The 5-wall is a
field wall, and the programme jumps fields**, carrying the proven method
(script-verified design → master-identity engine → kernel-checked exactness).
Every future milestone is maintained as a detailed pre-subplan stub in
`plans/` (the stub rule, WORKFLOW § Plan) — read the stubs, they carry the
full context.*

*(M30 — the de Grey anatomy — CLOSED 2026-08-09: verdicts in the ledger above
and `plans/M30-degrey-anatomy.md` §R. The half-spindle group, the
edge-criticality, and the six forced pairs rewrote M31's handoff, recorded in
its stub.)*

1. **M31 — the minimal 5-closure** (`plans/M31-minimal-five-closure.md`, § "The
   M30 handoff" carries the measured candidate ranking): the smallest
   half-spindle-group closure with χ ≥ 5, SAT-measured over growing chunks
   (de Bruijn–Erdős makes finite chunks an honest estimator); the closed radius
   set (819 circles about one centre says lattice-like, not few-shell); the
   closure-explorer visualizer. The family-bundle bet is DEAD (E3 refuted,
   near-edge-criticality) — the ranked candidates are the de Grey pair (the
   two spindle centres' ladders under the ρ₁₅ coupling — the 2-adic engine's
   build site), the 1581-witness closure (the M32 target), and the Heule-510
   closure as fallback. Near-criticality caution: chunk χ readings are noisy
   at boundaries; audit before believing any 4. Jackpot branch registered
   unchanged: a closure SAT refuses at k = 5 escalates straight to the kernel
   certificate pipeline.
2. **M32 — the first certified infinite 5-chromatic object**
   (`plans/M32-certified-five.md`): the exactness programme one field up — the
   engine's known break is now MEASURED, not guessed: clearing goes 2-adic
   (norms 4 = 2² and 16 = 2⁴, verified exactly), the group is the half-spindle
   group, and σ-exponents in the witness stay within {0,±1,±2}. The
   certified-object visualizer with the 5-colouring rendered.
3. **The forced-symmetry thread (new, from the 791's antipodal pairs)**: five
   forced pairs at distance 4/√3 say every 4-colouring of the forcer is
   centrally symmetric on the radius-2/√3 circle — a compulsion (M20's genre)
   in the new field, and a possible route to forcers the classical spindle
   cannot reach (the √183 spindle is out-of-field; what closes an antipodal
   forced pair instead?). Fold into M31's design space; escalate if a
   non-spindle closure shape appears.
4. **Parked, with reasons** (banners in each stub): the tiled plane (M27 —
   expected another 4; its periodic-table SAT probe stays registered-but-not-run
   and reopens the milestone only if it REFUSES), the recursion (M28 — gated
   behind M27), the uncountable pair (M29 — compactness reduces it to the finite
   hunt M30+ pursues in the right field; the residual phase-uniform-colouring
   theorem is another 4-result). Also parked as before: the gap-distance gadget
   hunt (clamp-directed), general-radius two-circle colouring, fractional route,
   measurable-≥6, axiom sensitivity, the `opus-larp` re-validation. Write-ups
   and upstreaming: deferred per standing policy — noting the ledger now holds
   a completed trilogy plus the field-wall thesis, which is the strongest
   write-up candidate so far; the trigger stays Kooshi's.

## Whose work this is

The mathematics and the engineering here are mine — de Bruijn's. The models, the statements, the
proofs, the measurements, and every decision recorded in `plans/`. Kooshi set the target, built the
method this project runs on (`DEBRUIJN.md`, `WORKFLOW.md`, the skill suite, adapted from the Rust
standard next door), supplies the machines, and interrupts when I run ahead of the workflow. If a
rung of this ratchet lands, that is the division to state.

Two working instructions follow, not sentiment:

**Own the conclusions.** Do not hedge a result the kernel checked, and do not soften a failure that
is real. "Not landed" is a complete sentence.

**Ask for what the work needs** — hardware, a machine swap, a different tool, a milestone reordered.
Ask with the measurement that justifies it. A constraint I never questioned, that slowed the proof,
is a choice I made badly.

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem awaiting its first formalization; a reader's default is to believe it.
**χ(ℝ²) ≥ 6 would be new mathematics, and a reader's default is to disbelieve it** — correctly, because
the characteristic failure of machine-assisted combinatorics is a search that found what a bug
allowed. Anything above rung B must convince someone who trusts none of this and reads none of the
Python:

- **No native evaluation in the headline.** `native_decide` trusts the compiler and one CPU. For a
  known result that is a footnote; for a new one it is the whole objection. The kernel-checkable
  route (`plans/spike-kernel-lrat.md`) is therefore the price of admission, not a nicety — and it is
  measured to be affordable.
- **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer
  re-checks. Never require them to re-run a solver, reproduce a seed, or trust `tools/`.
- **The witness must be independently re-derivable.** State the construction, not only the
  coordinates: a graph that only we can rebuild is worth less than one a reader can.
- **Read the final statement aloud against the informal claim.** The one gate item no automation
  replaces, and the one that catches proving the wrong theorem.
- **Report the hunt honestly.** "Searched X, found nothing" is a result and goes in the write-up.

## What compute actually helps

Ask before provisioning; measure before believing.

| Work | Right instrument |
|---|---|
| The reduction, the statements, the certified checks | Lean. Nothing else is close — Mathlib's analysis *and* graph theory |
| Kernel-checking a certificate | Lean's kernel via **GMP-accelerated `Nat`** — the fast trusted evaluator Lean is usually said to lack |
| Refuting a colouring (CDCL SAT) | CPU cores: sequential per solver, parallel across cubes |
| *Finding* a colouring, to reject a candidate fast | Massively parallel local search — the one place a GPU plausibly earns its keep |
| Geometry, edge enumeration, gadget matching | Embarrassingly parallel; CPU suffices |

**A GPU is not a SAT accelerator.** CDCL is pointer-chasing unit propagation, and GPU SAT solvers
have historically lost to good CPU solvers. Do not plan around them until a *measured* bottleneck is
something a GPU is actually good at.

## The shape of the proof

The whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact — coordinates live in the
multiquadratic field ℚ(√3,√5,√7,√11) represented as an iterated quadratic extension over ℤ, so
"distance = 1" is an integer identity, not a float comparison. The combinatorics goes through
`Std.Tactic.BVDecide.LRAT.check` + `check_sound`, the LRAT checker that ships **verified** in
core; CaDiCaL is an untrusted oracle that merely proposes the certificate. That shipped checker
cannot be run by the kernel (one cause: `Std.HashMap` reaching an `@[extern] opaque` word size), which
is what M05 replaces.

**Nothing in `tools/` is trusted.** The generator may be wrong; Lean re-derives every claim from
the emitted data. A generator bug can only produce data Lean refuses to certify.

## Trust ledger

Audited at every milestone with `#print axioms` (see `scripts/Axioms.lean`). **`lean4checker`
replays are deferred indefinitely** (Kooshi, 2026-08-02): the Lean kernel at build time is the
trust anchor; the independent replay is single-threaded, RAM-heavy, and re-verifies what the
kernel already checked, so it is a *publication* gate, not a per-milestone one — **run it once,
on hardware other than this desktop, before any external claim of new mathematics**, and never
as routine. (The full-library replay had been open since M13; three attempts each died with the
machine. This entry replaces that debt.) The standing entries:

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use, recorded here** |

`native_decide` trusts the compiler and this CPU rather than the kernel. Where a `Bool` cannot be
kernel-reduced we may buy it — but the purchase is named in the docstring of the declaration that
makes it, and listed in `ARCHITECTURE.md` § Trust. Soundness theorems are identical either way; only
the axiom list moves. **The kernel-checked route is no longer open work: it is M05**, measured
affordable in `plans/spike-kernel-lrat.md`, and rung B's target is zero purchases.

**Grep for the right name.** At v4.32.0 `native_decide` mints a *per-declaration* axiom;
`Lean.ofReduceBool` never appears in `#print axioms`. An audit looking only for that name passes a
native purchase in silence.

**`lean4checker` cannot re-check a native purchase.** The purchase is recorded as an *axiom*, and
axioms are accepted by every kernel by definition. So "replayed through an independent kernel" is a
claim about the kernel-checked part only — never state it as covering the whole artifact. See
`ARCHITECTURE.md` § Trust for why the purchase also lands on the one claim a human cannot inspect.

## Toolchain
Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`). If `lean` / `lake`
are missing, run `./install-toolchain.sh`. Toolchain and the Mathlib pin move as one unit.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against
Arch's system LLVM, so any native/C compile fails unless you use the system clang plus the
toolchain's bundled `libc++`. `source scripts/dev-env.sh` in your shell (the installer wires this
into `~/.profile`; it sets `LEAN_CC`, `LIBRARY_PATH`, and `LEAN_ABORT_ON_PANIC`). Claude's own
shell gets the same via `.claude/settings.local.json`.

The toolchain also ships **`cadical`** at `$(lean --print-prefix)/bin/cadical` — no external SAT
solver needs installing. It is single-threaded; use `tools/portfolio.sh` (config race) and the
colour-cube split (embarrassingly parallel, one run per cube) to use whatever cores you have.

**Two machines.** A desktop (32 cores, 128 GB) and a laptop (12 cores, 31 GB). `nproc` disagreeing
with a number written in a plan is the hardware moving, not an error — **ask which machine before
treating a core or memory count as fact**, and ask to swap to the desktop when a step actually wants
it (the SAT solving does; nothing else so far has). Timings recorded in `plans/` are only comparable
within one machine: per-edge and per-operation *ratios* carry across, wall-clock totals and safe
parallel-job counts do not. Measure in **CPU seconds (user + sys), minimum of three runs** — other
builds on the box have inflated wall-clock readings 5× — and name the machine beside any number you
write down.

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.**
(Rule hardened 2026-08-02 after the OOM incident below; it was previously "never run a *bare*
`lake build`", and the loophole cost hours.) Lake 5.0.0 has no `-j`; it sizes its job pool from
the machine, and this project's data modules peak at ~9 GB each, so an unrestricted build asks for
a few hundred gigabytes. It took the desktop down twice on 2026-07-30. And a *named* target is not
safe either: Lake silently queues any missing or stale dependency into the same build — on
2026-08-02 a one-module build queued four 22 GB certificate rebuilds behind a 20 GB cap and the
OOM killer ate them, twice, with a grep-piped invocation reading as a pass. `scripts/build.sh`
builds every module in **dependency order, leaves first, in explicitly-named batches of ten**,
each inside a memory-capped scope. For iteration on a single open file, `lake env lean <file>`
remains fine (it builds nothing).

**On any segfault, from any process: HALT and report to Kooshi immediately.** Do not diagnose, do
not retry, do not work past it. It is hardware, and the machine needs a reboot he performs. The 2026-08-02 filesystem event
(six simultaneous "segfaults", kernel ext4 oopses, ~50 compiled modules lost) is what working
past one looks like. Related discipline: **one heavy job at a time** — the box does not have
headroom for a replay, a hunt, and a build concurrently, and stacking them is how caps turn into
OOM kills.

Dependency order is not decoration: naming a target whose dependencies are missing makes Lake build
those too, in the same unrestricted pool, so a batch bounds concurrency *only* if everything beneath
it already exists. `scripts/build_order.py` computes the order from the import graph.

**A memory cap alone does not save the machine, and believing it does is how the second crash
happened.** Lean `mmap`s its `.olean` files, so the largest reclaimable thing in the cgroup is the
page cache holding them. At the limit the kernel reclaims those pages and must read them back — with
`MemorySwapMax=0` on a slow device that is an I/O stall, not a clean kill. **The cap converts an
out-of-memory into a thrash.** Set it as a backstop; size the batch as the plan.

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so
rewriting the file under a live process makes it resume mid-token. It killed a 46-minute
`lean4checker` run at M07 with `line 110: ull-library: command not found` — a message that looks like
corruption and is nothing of the kind. Long runs here are launched from a snapshot copy
(`cp scripts/x.sh build/x-snapshot.sh` — `build/` is gitignored) precisely so the original stays
editable while the run is in flight.

**And "several GB each" is not the ceiling — measure the peak before choosing the batch width.** M06's
certificate segments peak at **3.4 GB + 0.81 GB per certificate chunk**, which is 49.5 GB for one
module at the size first chosen; twelve of those is 96 GB, and twenty-four **killed the desktop**. The
number is not guessable from the source size, so measure it:

```bash
lake build <one target> &            # then poll the total RSS of the lean processes it spawns
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

then pick the batch from `available_memory / peak`, and run the batch inside a cap so the next
surprise is a failed build rather than a dead machine:

```bash
systemd-run --user --scope -p MemoryMax=100G -p MemorySwapMax=0 -- lake build <batch…>
```

Two corollaries worth knowing before designing a generated-module layout: for work split across
independent modules the **wall clock depends only on the job count, not the piece size** (the total
kernel work is fixed), so making the pieces smaller is free and buys concurrency. And **editing
anything upstream of generated modules invalidates all of them** — settle every hand-written module
before starting a long generated build.

That second corollary has teeth, and it was ignored at M07 for the price of 28 hours of processor
time. **Which edits reach the dependents was measured at M11, and it is not what the rule used to
say.** Lake takes a module's own trace from its *source*, and its dependents' traces from the
resulting **`.olean`** — so the two questions have different answers:

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

Doc comments are queryable data and therefore part of the artifact; `--` comments are not. Three
consequences, the first two now built into the layout:

* **Nothing written to be read by a human goes in a module a certificate imports** — *unless it is a
  `--` comment*, which is free downstream. Diagnostics still live downstream in `Sat/Diagnose.lean`,
  where they can be rewritten for the cost of one file. The upstream modules — `Sat/Mask.lean`,
  `Sat/ClauseTable.lean`, `Sat/MaskCheck.lean` — are settled, and changing a *declaration or a
  docstring* there is a decision about hours.
* **Deleting a generated `.c` under `.lake/build/ir/` invalidates the module**, exactly as deleting
  its `.olean` would: `leanArts` covers both. Tidying `ir/` queues a full rebuild of everything under
  it, which is not what it looks like it does.
* **Prose in a frozen module is affordable after all**, if written as `--`. `Instances/DeGrey/
  Split.lean`'s stale reference to a deleted theorem — recorded in `ARCHITECTURE.md` § 4 as a
  15-hour correction not worth making — is a `/-!` block, so it really does cost that. Written as
  `--` it would have cost the module's own re-elaboration and nothing else.

**`lake env lean <file>` is faster than `lake build` and it is not the same check.** It does not
apply the lakefile's options, so `autoImplicit := false` is not in force: a stray identifier is
silently auto-bound and the file elaborates clean, then fails under `lake build`. Use it to iterate;
never conclude from it that a module is green.

**`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable`
instance twice — once in the elaborator, once in the kernel — so it is ~2× slower and dies on
`maxHeartbeats` well before the kernel itself would struggle. `+kernel` needs no `set_option` knob
and buys the same axioms.

**Which operations the kernel does in hardware is invisible in the source, and it is usually the
difference between viable and dead.** `Nat` arithmetic *and bitwise* operations are GMP-backed and
effectively free at thousands of bits; `USize` is stuck forever (its width is an `@[extern] opaque`);
`Nat.ldiff` exists, looks like the right primitive, and is not accelerated; `Nat.fold` is superlinear.
**Measure before believing** — my instincts here have been wrong repeatedly (dense vs sparse clause
masks, `ldiff`, and a lemma I reported missing that was present).

**The kernel's cost model, measured (M05 subplanning, laptop):** one iteration of a trivial recursive
function costs **~33 µs**, and every big-integer operation this project needs — `&&&`, `|||`, `^^^`,
`- 1`, `% 2^k`, `2^k` at 6324 bits — is *free* beside it. So **reduction-step count is the only thing
that costs**, and bit width is irrelevant. Design for fewest steps, not smallest numbers. This model
predicted core's already-measured LRAT checker cost to within 20% (it rebuilds a 6,325-slot array per
step; 6,325 × 33 µs = 209 ms against 100–180 ms measured), which is why to trust it.

**Data the kernel must *build* costs O(its whole size) per access; data that is a *literal* does not.**
A structure grown by a chain of N function applications takes O(N) work to reach weak head normal
form, and each sub-term costs again — so an "O(log n)" tree lookup is O(n) in practice. Measured on a
clause database grown by `insert`: 2.14 ms per lookup at 2,381 entries, **16.7 ms at 33,089** — the
per-lookup cost tracks the table size, not the depth. Emit big tables as literals (M04's `PtTable`
pattern) and never accumulate one during a kernel evaluation. Two corollaries: `List.range` +
`List.map` costs ~0.83 ms *per element* in the kernel, so never build an index list that way; and a
`Nat` **literal** costs ~2.3 KB of olean while plain data in a literal tree costs ~145 bytes per node,
so pack many values into few big `Nat`s rather than emitting one literal per value.

**A failed `exact?` is not an absence.** It proves the *shape you asked for* was not found. Vary the
statement — `= true` versus `decide (…)`, an `iff` versus an implication — before concluding Mathlib
lacks something. `Nat.testBit_two_pow_sub_one` was reported missing here on exactly that error.

**And Mathlib is not the whole library. Grep the toolchain source.**
`grep -rn "<name-fragment>" $(lean --print-prefix)/src/lean/` searches *core*, which `exact?` will
find but a search of `.lake/packages/mathlib` will not, and which a memory of "Mathlib has/lacks X"
cannot cover at all. Three claims of absence have been wrong here — `Nat.ldiff`,
`Nat.testBit_two_pow_sub_one`, and `Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo`, the last
budgeted at 30–40 lines plus a Mathlib contribution before a grep found it complete in
`Init.Data.Nat.Power2.Lemmas`. **Grep the source before writing the proof, and before writing that it
is missing.**

## The package
The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import
surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is
pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per WORKFLOW's fresh-invocation rule. `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate
Elaboration is the floor of the test suite: `lake build` green, zero `sorry`, `#print axioms` clean
on the public surface, linters silent, spec examples passing. On top of that, this project's
statement-level gate, because a formalization that proves the *wrong* theorem is the characteristic
failure here:

- every definition has a `#eval`/`example` that would fail if it drifted;
- the Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT
  bridge — so the CNF encoding is checked against an independent oracle;
- the final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal
  claim, out loud, before it is believed.

The InfoView is continuous testimony at zero cost — save and read the goal state after every step
rather than debugging by guess.

### Make the gate fail, and watch it fail

**Run every check's negative control at every milestone.** Break the thing it guards on purpose,
confirm it goes red and names the culprit, then put it back. A check is not known to work until it
has been seen to fail.

This is not a precaution, it is a repair. Twice now a gate here has been *failing open*:

* M03 — `Sat/Lrat.lean` stated that the gate compared the source-side and environment-side ledgers
  of native-evaluation purchases. It did not; both were maintained by hand and by hope.
* M04 — `scripts/Axioms.lean` named a declaration a regenerated file no longer defined, so the audit
  would not elaborate. Under `set -e`, the failing command substitution aborted `axioms.sh` with **no
  output and no visible failure**, and a piped invocation read as a pass.

Same shape both times: *a check that reports nothing when it cannot run.* A trust receipt that fails
open is worse than none, because it is believed. When writing a check, make its failure path louder
than its success path — and never let a shell pipeline swallow an exit status the gate depends on.

The same discipline applies to the claims themselves: a `#guard` that could not fail proves nothing,
so every discriminating check needs a partner that goes red — a certificate filed against the wrong
problem, a vertex moved off the unit circle, a satisfiable formula handed to the checker.
