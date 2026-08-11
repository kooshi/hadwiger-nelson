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
rung-B write-up, Mathlib contributions, and any exposition; the deferral is standing policy.
**The trigger, sharpened (Kooshi, 2026-08-10, on the literature check that found the field
converging):** mathematics everywhere is accelerating and nothing minor will get read — so the
publication bar is exactly two events: *maybe* our own certified 5-chromatic object, if what it
reveals is interesting enough (his call at that point); *definitely* χ(ℝ²) ≥ 6 or its
refutation. Nothing below that bar is written up, however novel the rung.

See `ARCHITECTURE.md` for the module DAG and the milestone roadmap; `plans/` for per-milestone
subplans.

## Frontier

*The current state of the art, the ledger of everything novel this project has produced, and
the live paths forward. Maintained as part of every milestone's closing commit (WORKFLOW
step 9); a milestone whose close does not update this section is not closed. The
UNDERSTANDING the results add up to — the mechanistic picture we build on — lives in the
sibling section § Grokkings below, under the same maintenance rule.*

**Last updated: M33, 2026-08-10.**

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
M31 opened the coupling theory one field up, and the theory arrived BEFORE
the instruments: the **quadrature law**, derived a priori in the registered
subplan and then verified at 26 exact censuses with zero violations — a
detuned copy of seam-field material couples to its base ONLY along
anchor-collinear pairs (full spindles) or anchor-perpendicular pairs (half
spindles) on one explicit radius conic, and detunes mixing the √15- and
√7-families couple nowhere at all. The measured consequences: the mitotic
hexagram (the certified organ plus one detuned copy, every anchor ×
generator at B ≤ 2) is χ = 4 throughout with coupling ≤ 12 chords — G6's
single-detune causal candidacy is dead; the de Grey pair couples through
exactly 6 seam chords (four of them through the seam-conjugate point
(1/√3)·σ̄ that Heule's coordinates carry) plus the one predicted (2,2)
centre spindle chord; the conic's solutions include the **conjugate-ring
channel** — ℚ(√33)-conjugate rings at (17∓√33)/6 coupling through ρ₁₅ —
the first mechanism connecting the witnesses' ring spectra to the coupling
web; and the certified hexagram holds hex-ray material at exact distance 2
from its pivots, the same Eisenstein 1+1 step de Grey's fabric spindles on.
The witness-closure measurements: gen-1 half-spindle closure of the 1581 =
24,065 points, 123,134 unit chords, 11,016 rings about the origin (P6's
band missed low — the object is even more lattice-like than 819 suggested),
k = 5 SAT in 1.14 s (no jackpot), and the k = 4 frontier — plain AND
gen-1-enriched balls — 4-colours everything through 1,200-committed scale
in seconds: **enrichment does not shrink the forcing; the 5-mechanism is
irreducibly global at this order** (the registered failure clause fired as
a finding, the third independent measurement of G10). And the rigidity
postscript: Heule-510 minus its centre is 4-colourable with ZERO forced
pairs and ZERO virtual edges, settled completely in 6 seconds — one vertex
below criticality there is NO pairwise rigidity shadow at all.
M32 ran the designed-forcer probe and took the kill engine to the kernel.
The **stacking law** was derived a priori and confirmed at every census
point: same-anchor stacks never escape the single-word law's thinness;
same-word stacks at DIFFERENT anchors open a translation channel that is
O(n)-wide exactly at unit anchor separation (the arithmetic reason de
Grey's construction has two centres) — and our triangle pivots provide
unit anchor pairs natively; the pivot↔metapivot separation 1/√3 is
provably sterile (the admissible-length discriminant picks up √59). The
census hit every prediction: 132-chord exact translation matchings at unit
anchors, zero at 1/√3, chirality-pair channel exactly empty. And then the
FLAT verdict, all the way down: the matching is 1-regular — **width
without degree carries no colour pressure** — and even the triangle stack
(three copies at the three unit-separated pivots, whose three matchings
compose into 26 forced-rainbow unit triangles spanning the copies — the
hunt's first designed triple-order cross structure) reads zero forced
pairs, zero virtual edges, zero coverage movement, zero compelled
triples, χ = 4 everywhere. The irreducibly-global finding now extends to
designed one-family objects (fourth independent measurement); the design
thread closed honestly and M33 is Route A. The Lean ascent landed beyond
its registration: `Quadrature.lean` (zero sorry) holds the 2-adic
engine's first theorems — `sqrt5_indep` by a division-free mod-5 descent
(one 625-tuple ZMod-5 kernel decide + strong induction on the ℓ¹-norm),
the `sqrt15_split` workhorse, `sqrt_indep₈`, the geometric
`quadrature_rho15` (M31's law G12, ρ₁₅ instance: a unit chord against a
detuned copy forces the collinear pin AND the conic), and the distance-2
pair's tangency anchor — with every linear_combination witness
sympy-derived and verified to zero residual before Lean stated it, all
landing first try. The distance-2 pair web is measured complete in a deep
window (14 address chords, no height growth, = M31's 6 genuine + 8
through the single fusion), its completeness the first M33 engine target.
The coverage/triple meters and the stack machinery joined the standing
instrument suite; the closure explorer gained the stacks tab.

M33 ran the mechanism hunt and the golden question got its first real
answers. The a priori criticality factorization (fan(G−v, N(v)) ⟺
χ(G) ≥ 5 at any vertex — two sentences, derived before any query)
re-aimed the sweep: the 4-onset is a criticality echo, measured exactly
so at all three centres probed (510's fan at the last ring in 9 s; the
1581's second centre by direct UNSAT; its origin capped honestly and
closed by the factorization + the kernel χ ≥ 5). The live structure is
below the top rung, and it is SMALL: the 3-cover core — the minimal
ambient web forcing three colours onto Heule-510's 36-point circle — is
**49 vertices = the circle + 13 interior points** on three named shells
((7−√33)/6, the inner circle 1/3, (9−√33)/6), 1-minimal with every
necessity witness held. And the class-avoidance instrument (one SAT call
per (region, pattern class), the disjunctive query the instance meters
were provably blind to) found the pigeonhole: **the seam fabric cannot
stay clean at distance 2** — every proper 4-colouring of the certified
hexagram chunk at seam depth B = 2 (378 pts), of de Grey's bare fabric
stage past r² = 2 − √33/9, of Heule-510 past the GLUE SHELL r² = 5/3,
and of the 1581 past the same fabric radius (identical onset to nine
decimals — the spindles neither create nor move it) makes some
distance-2 pair monochromatic. Distance 2 is the ρ₁₅ spindle distance
(4·2² − 1 = 15): the pigeonhole lives in the seam field, its kill lives
one field up — G15's two-act anatomy measured, with Act One shrunk to a
**122-vertex 1-minimal core** (de Grey's L was 121) in 12 near-rot6
shells about the metapivot, confirmed in two independent encodings. The
√3 story inverted honestly: mono-√3-triples (de Grey's paper class) and
√3-pairs are CLEAN on every object at every sub-full radius — except
√3-pairs on the FULL 1581, onset at the √21-shell (33−3√21)/8 where the
second spindle system's material arrives: the assembly creates that
pigeonhole and Heule's SAT-shrinking discarded it while keeping d = 2.
Controls: the 791's six forced pairs, the M20 skeleton (the kernel
theorem reproduced by instrument), the id-shuffle, the planted gadgets —
all red/green; one instrument fix mid-milestone (first-occurrence
palette breaking, registered §0i before reruns). The P12 gate is OPEN:
next is Act One as a kernel theorem (LRAT on the 122-core, a CNF a
fraction of the 1581's size over an object whose geometry M26 already
certified).

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
| 27 | **The quadrature law + the closure measurements** (tools-side; the law derived a priori in the registered subplan, then verified at 26 exact censuses, zero violations): a detuned copy R·X of seam material couples to X only along anchor-collinear pairs (R = s·W, W an even half-spindle word) or anchor-perpendicular pairs (W odd) on the conic t²+r²∓2·{Re,Im}(W)(±tr) = 1; mixed-family detunes couple NOWHERE. Measured instances: the (2,2) spindle diagonal (the hexagram holds hex-ray material at exact distance 2 from its pivots), the (2/3,2/3) perpendicular diagonal, the **conjugate-ring channel** (17∓√33)/6 ↔ (17±√33)/6 at t·r = 8/3. Verdicts: mitotic hexagram χ = 4 everywhere (G6's single-detune causal bet dead); de Grey pair = 6 seam chords + the predicted centre spindle chord, χ = 4; 1581 gen-1 closure (24,065 pts, 123,134 chords, 11,016 rings) k = 5 SAT in 1.14 s; the k = 4 frontier with full gen-1 enrichment 4-colours everything below the witness scale — **the 5-mechanism is irreducibly global at this order** (third independent measurement); Heule-510 minus its centre: zero forced pairs, zero virtual edges, settled — no rigidity shadow one vertex below criticality. Instruments: `tools/closure.py` (the law enforced at find time, planted-failure self-tests), the closure explorer `tools/closure-viz.html` + refresh. | `build/m31-*.json`, `plans/M31-minimal-five-closure.md` §R | M31 |
| 28 | **The 2-adic kill engine, kernel-checked** — the first Lean theorems one field up: `sqrt5_indep` (a vanishing A + √5·B over the {1,√3,√11,√33} basis has all eight ℚ-coefficients zero) proven DIVISION-FREE by squaring to A² = 5B², reading four equations through M24's `sqrt_indep`, and killing the integer system by **mod-5 descent** — one kernel `decide` over (ZMod 5)⁴ (625 tuples, the house mod-p congruence style) plus strong induction on the ℓ¹-norm; the √7 analogue is a numeral change. On top: `sqrt15_split` (the workhorse every 2-adic clearing cites), `sqrt_indep₈` (the flat eight-term independence), **`quadrature_rho15`** — M31's quadrature law (G12), ρ₁₅ instance, as a theorem: a unit chord between seam-coordinate points and a ρ₁₅-detune forces Im(u·v̄) = 0 AND |u|²+|v|²−(7/4)·Re(u·v̄) = 1 — and `pair_tangency` (the unit circles about 0 and 2 meet exactly at the midpoint). Method note: every linear_combination witness was sympy-derived by polynomial reduction over the radical ideal and verified to zero residual BEFORE being stated — the M26 script-first discipline applied to proof terms; all landed first try. | `Quadrature.lean` (`sqrt5_indep`, `sqrt15_split`, `sqrt_indep₈`, `quadrature_rho15`, `pair_tangency`) | M32 |
| 29 | **The stacking law + the flat designed-forcer verdict** (tools-side; the law derived a priori in §0a, then confirmed at every census point): same-anchor stacks reduce to the single-word law forever (the relative detune is the spec quotient — detunes form a group); same-word different-anchor stacks couple through a difference pin (w = u−v collinear with the twisted anchor axis, |w| on a quadratic) whose w = 0 root at UNIT anchor separation is an O(n) **translation matching** — measured: 132 exact matching chords at the triangle's unit pivots, ZERO at the √59-sterile 1/√3 separation, chirality channel exactly empty. The verdict: matchings are 1-regular, **width without degree does not force** — the triangle stack's 26 spanning forced-rainbow unit triangles (the first designed triple-order cross structure) still read zero forced pairs, zero virtual edges, zero coverage movement, zero compelled triples, χ = 4 everywhere; the 5-mechanism's irreducible globality extends to designed one-family objects (fourth measurement). Base-rate finding: pivot-circle min-cover rises 2 → 3 from B = 1 to B = 2 (ambient coverage pressure builds with depth) while the metapivot circle stays at 2. New instruments: the coverage/triple meters (palette-WLOG single SAT calls, free vacuity guard), the stack census with class-routed certificates. | `tools/rigidity.py` (meters), `tools/closure.py` (stacks), `build/m32-*.json`, `plans/M32-certified-five.md` §R | M32 |
| 26 | **The de Grey anatomy** (tools-side, every instrument control seen red/green on cue): the 1581 has exactly **67 edge-direction classes**, ALL words in the half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ at exponent ≤ 6 (the registered whole-word group covers 58%; every miss squares in; σ-exponents only {0,±1,±2}); Heule 510/553 carry 6 out-of-group residue classes each — the 1581 is the only pure-group witness; E3 refuted (819 circles, 4,140 coarse classes, top-6 = 3.7%, flat head) and the load-bearing census deflated by its matched control — **the 1581 is at or near edge-critical**, the 5-forcing distributed; the complete forced-pair inventory of the 791 forcer: **six pairs** — M13's axis pair plus five ANTIPODAL pairs at distance 4/√3 (√183-spindle, outside the field): every proper 4-colouring is centrally symmetric on the radius-2/√3 circle; E2 exact (norms 4 and 16 — the M32 clearing is 2-adic); fusion record {1:1344, 2:234, 4:1, 24:2}; E4 refuted both halves — the 4-chromatic hexagram chunk's colour space is > 10⁴ up to rot6 × palette with ZERO forced pairs (settled exactly), and the 1581's 5-colouring space is likewise pairwise-floppy (0 forced, 0 virtual, settled) — rigidity in both fields lives only at the forcing level k−1, never above. Instruments promoted: `tools/anatomy.py`, `tools/rigidity.py` (complete pairwise forced-equal/virtual-edge oracle, batch violation queries, vacuity guard), `tools/hexchunk.py`, the anatomy visualizer `tools/degrey-viz.html` + `tools/degreyviz_refresh.py`. | `build/m30-anatomy.json`, `build/m30-rigidity-forcer791.json`, `plans/M30-degrey-anatomy.md` §R | M30 |

| 30 | **The mechanism hunt's first harvest** (tools-side, every claim double-encoded or theorem-closed): (a) the criticality factorization A1 (χ(G) ≥ k+1 at a vertex ⟺ the fan on its circle, when G−v is k-colourable) — derived a priori, validated at three centres, and used to CLOSE a capped solver row by mathematics; (b) **the d = 2 pigeonhole**: avoid-all-mono-d2-pairs is UNSAT on the certified hexagram chunk at B = 2, on the bare de Grey fabric and the 1581 at the IDENTICAL onset 2 − √33/9, and on Heule-510 at the glue shell 5/3 — fabric-borne, depth-switched (clean at B ≤ 1), at exactly the ρ₁₅ spindle distance; Act One's 1-minimal carrier = **122 vertices / 12 shells** with per-member necessity witnesses; (c) **the 3-cover core**: 36-circle + **13 interior points** on (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6 delivers min-cover 3 at Heule-510's centre; (d) the √3-pair pigeonhole exists ONLY in the assembled 1581 (onset at the √21 shell — cross-system material), not in the fabric, not in shrunk 510; (e) the class-avoidance instrument (arity-generic mono-avoidance, base-SAT guard as control flow, five honest verdicts, first-occurrence breaking, binary re-encode promotion ladder, 1-minimal shrink engine) with the 791/M20-skeleton/planted controls all red/green. | `tools/mechanism.py`, `tools/rigidity.py` (class_avoid), `build/m33-*.json`, the explorer's M33 pane, `plans/M33-mechanism-hunt.md` §R | M33 |

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

*(M30 CLOSED 2026-08-09; M31 CLOSED 2026-08-10; M32 CLOSED 2026-08-10 —
the probe phase fired its FLAT clause exactly as registered and the Lean
ascent landed the kill engine kernel-checked. RE-RANKED the same day, on
Kooshi's direction at the close: "I want to be able to confidently point to
the reason why 5 colorings are forced." M33 is the MECHANISM HUNT; the
certification programme is the standing fallback.)*

1. **M34 — Act One as a kernel theorem, and the union question**
   (M33's P12 gate fired OPEN; stub to be written at M34 subplanning).
   The three rungs, in order: (a) **kernel-certify the 122-core's
   pigeonhole** — "every proper 4-colouring of this 122-vertex subset of
   the certified hexagram has a monochromatic distance-2 pair" via the
   M05 LRAT pipeline (a CNF ~1/50th the 1581's, over geometry M26
   already certified) — the first kernel-certified DISJUNCTIVE
   compulsion, M20's genre at class level; (b) the kill-per-placement
   theory: a ρ₁₅ spindle on each of the core's d2 placements (the A3
   width budget — 135 instances at B = 2; transport collapses congruent
   placements, the M26 genre); (c) the union question — the research:
   does fabric ∪ kills force 5, and what is the least such union? The
   pair-web completeness (build/m32-pairweb.json) stays the Lean warm-up.
2. **The certification programme** — standing fallback unchanged
   (`plans/M33-witness-closure.md`), now with a SECOND candidate object:
   if the union lands, its closure is a far smaller certification target
   than the 1581's.
3. **The designed-forcer thread — CLOSED at M32's flat checkpoint**; reopen
   only with a degree-≥ 2 cross-pressure mechanism and fresh registered
   predictions. G15 now says what was missing: kills without a pigeonhole.
4. **The forced-symmetry thread** — folded into the mechanism hunt's phase 2
   as its positive control (the 791's forced central symmetry is an
   already-measured class-level compulsion), no longer a separate item.
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

## Grokkings — the working theory of the 5th colour

*The Frontier records what is proven and what to try next; this section records
what we UNDERSTAND — the mechanistic picture the results add up to, which is
what we actually build on. Born 2026-08-09 (Kooshi's naming), the night the M30
anatomy and three of his visualizer observations assembled into one picture.
Discipline: every entry carries an epistemic status — **[kernel]** (the kernel
checked it), **[measured]** (tools-side, exact arithmetic or a controlled
instrument, with its address), **[reading]** (an interpretation — believed,
falsifiable, its killing test named). A reading is never silently promoted; a
grokking that dies is demoted with its refutation recorded, never deleted.
Updated whenever understanding moves — the same closing rule as the Frontier.
"All known 5-forcers" below means the three witnesses certified in this
repository (de Grey 1581, Heule 553/510). Unimported and untested: Parts' 509
(arXiv:2010.12665, the vertex-count record), Heule's 529 (arXiv:1907.00929),
Voronov et al.'s 64,513 (2021, Moser-spindle-free), and Haugland's 2,131
(arXiv:2608.04542, 2026-08 — Moser-spindle-free, HEPTAGON-fabric, float+SAT
verified only). The scope clauses below matter because of the last one.*

**The theory in one paragraph.** A 5-forcer, as far as anyone has built one, is
seam-field geometry pushed over a wall by angular detuning: a small vocabulary
of seam shells (~30–44 exact radii, every one in ℚ(√33)) about one or two
rotation centres, angularly organized by words in the half-spindle group
⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩, with the 5th colour forced by copies detuned 0.6°–3.6°
off exact crystal symmetry — near enough to interlock, far enough to clash.
Its colour rigidity is invisible at the pair level and lives in compelled
patterns of triple order and above. None of this is visible in the brute-force
artifacts; it took exact anatomy plus a human eye on the rendered picture.

* **G1 — The field wall.** The Moser twist is a seam-group word — ρ·σ² = −1,
  ρ = ζ₆³σ⁻² **[kernel: `FieldWall.lean`]** — and the seam group's countable
  closures are exactly 4-chromatic **[kernel: M24–M26]**; the 5-forcers need
  √5 and √7. The 4/5 boundary is a field boundary. *Reading on top: 4 is what
  ⟨ζ₆,σ⟩ can force, and it forces it everywhere; 5 begins one field up.*
* **G2 — The construction grammar of the picture.** Rings about a point ⟺ that
  point was a rotation centre of the construction (orbits about a centre lie on
  circles about it — invariance, not coincidence). De Grey's two ring-hearts
  are his two spindle centres (the two 24-word fused vertices); Heule's is his
  one. **[measured]** Corollary grammar: mirror-defects = chirality of a
  rotated copy; "mitosis" = a system and its detuned twin.
* **G3 — Radially seam, angularly detuned.** Every exact radius of Heule
  510/553 about the centre, and of each de Grey half about its own centre,
  lies in ℚ(√33) — zero √5/√7 content in ANY ring, all three witnesses
  **[measured: M31 stub, commits `dc97389`, `e721fb2`]**. Rotations preserve
  radii, so fabric ⊗ rotated-copies puts all new-field content in the angles.
  *Falsifier: a 5-forcer with a non-seam shell (test Parts 509 on import).
  SCOPE CORRECTION (2026-08-10): the falsifier has likely part-fired —
  Haugland's 2,131 (arXiv:2608.04542) builds a 5-chromatic graph on a
  HEPTAGONAL fabric (1/sin(2kπ/7) radii — a cubic field, not our tower), so
  the seam vocabulary is the hexagonal fabric's instantiation, not a law of
  5-forcers. The mechanism-level grokking survives strengthened: radially
  crystal, angularly detuned — per fabric. Pending: his verification is
  floats + uncertified SAT; the claim is unconfirmed by our standards.*
* **G4 — One shell vocabulary.** 25 of de Grey's 29 per-centre rings are
  Heule-510 rings; 12 rings are exactly the certified hexagram's; the named
  members are old friends — 1/3, 1, 4/3 (the forced-pair radius), 5/3 =
  |1 + σ/√3|² (the glue radius, whose conjugate lands ON the unit ring: the
  M21/M22 seam interlock, visible in published coordinates), 3, 4, and ±√33
  conjugate pairs. Every known 5-forcer stands on one ~30–44-value seam shell
  inventory. **[measured]**
* **G5 — The ownership factorization.** De Grey's 819-circle one-centre mess
  factors completely: two congruent 29-ring single-centre systems sharing
  exactly one point (the second spindle's pivot), spectra identical
  ring-for-ring; copy tags, mirror defect, and ring ownership are three views
  of one decomposition. **[measured]** *Reading: de Grey = two Heule-style
  systems glued by one twist.*
* **G6 — The hexagram is the 5-forcers' central organ.** Heule 510's centre
  carries exactly six two-circle pivot systems at exactly 1/√3 in a hexagon —
  M26's certified skeleton — plus seam-conjugate ring pivots at (1/√3)·σ̄
  exactly; 553 carries the unit-pivot triangle (M23's configuration) plus the
  ring. **[measured]** *Containment is NOT causation (the 1581 is
  near-edge-critical, so deletion cannot localize); the causal test is the
  mitotic-hexagram closure's SAT χ — M31's opening move. CAUSAL TEST RUN
  (M31, 2026-08-10): the mitotic hexagram — the certified chunk plus ONE
  new-field detuned copy, every anchor × generator variant at B ≤ 2 — is
  χ = 4 throughout, with coupling counts ≤ 12, all law-pinned (G12). The
  organ reading survives only as anatomy: the hexagram is the fabric the
  witnesses stand on, not a seed that one detune promotes to a 5-forcer.*
* **G7 — Detuning is the mechanism ("mitosis").** Every forcing rotation ever
  used is a small detune off an exact crystal angle: ρ₁₅ 1.045° off 30°, ρ₆₃
  0.638° off 15°, Moser 3.557° off 30°, σ 1.779° off 75° **[measured, exact]**.
  *Reading: exact symmetry adds no colour constraint (the copy reuses the
  base's pattern); the detune forces the clash while preserving interlock — a
  spindle is a forcer mid-division. Falsifier: a 5-forcer whose overlay is
  exactly symmetric, or detunes far outside the band; the "forcing band"
  question is registered at M31. INDEPENDENT SUPPORT (2026-08-10): Haugland
  (arXiv:2608.04542) builds his Moser-free 5-forcer with an explicit detuning
  parameter θ ≈ 0.4236 breaking his 7-fold symmetry "just enough", and his
  pipeline is literally our instrument currency — a virtual edge at √3
  (G₁, 740 vertices, forced-distinct pair), assembled into a forced-EQUAL
  pair at distance 2 (G₂), closed by the spindle at distance 2 — whose
  rotation matrix is OUR ρ₁₅ = (7+i√15)/8, appearing in a heptagon paper
  because the spindle radicand depends only on the forced pair's distance.*
* **G11 — The Moser subgraph is not necessary for 5** (external landscape,
  2026-08-10): Voronov et al. (2021, 64,513 vertices) and now Haugland
  (2,131) give Moser-spindle-free 5-chromatic graphs. No tension with G1 —
  G1 places the Moser TWIST inside the seam group; it never claimed the
  subgraph necessary — and Haugland's route (engineer a forced pair at a
  spindle-able distance, then spindle) is the general form our G9 antipodal
  pairs are the first exotic instance of: the design question is not "embed
  the classical gadget" but "land a forced pair at a friendly distance"
  (4d² − 1 square in the fabric's field). *His 2,131 is verified by floats +
  uncertified SAT only — kernel-certifying it would need cubic-field
  machinery (cos 2π/7) beyond our multiquadratic tower; noted as a possible
  future insertion, Kooshi's call.*
* **G8 — The true group is the half-spindle group** ⟨ζ₁₂, σ, √ρ₁₅ = (√15+i)/4,
  √ρ₆₃ = (3√7+i)/8⟩: it closes all 67 of the 1581's directions at exponent
  ≤ 6; the whole-word subgroup covers 58% and every miss squares in;
  σ-exponents stay in {0,±1,±2} **[measured]**. Heule's witnesses carry a
  6-class, ~10-edge residue outside even this group — SAT-shrinking scars; the
  1581 is the only pure-group witness. **[measured]**
* **G9 — Rigidity lives only at the forcing level.** The 791 forcer at 4
  colours: exactly six forced pairs — the axis pair at distance 4 and five
  ANTIPODAL pairs at 4/√3, i.e. forced central symmetry on that circle, and a
  compulsion the classical spindle cannot exploit (closing it needs √183,
  outside the field). The hexagram chunk at 4 and the 1581 at 5: pairwise
  FLOPPY — zero forced pairs, zero virtual edges, settled exactly.
  **[measured: `build/m30-rigidity-*.json`]** *Deduction: a geometric χ ≥ 5
  argument must live at triple order or higher — de Grey's own informal
  argument is triple-shaped, and M20's `no_mono_outer_triple` is the formal
  genre. Falsifier: a triple-level scan of the fabric finding nothing
  compelled either.*
* **G10 — The forcing is distributed, not organ-like.** Single random edge
  deletions make the 1581 4-colourable (two edges PROVEN critical end-to-end:
  Python-verified colourings after deletion + the kernel-certified refusal of
  the whole); no small family carries the forcing (E3 refuted in every
  currency tried). **[measured; "at or near edge-critical" is sampled — the
  exhaustive 7,877-edge sweep is ~a day of CPU, unrun]** *Consequence:
  "minimal" must mean least GEOMETRY (fewest shells × smallest angular word
  set whose compulsion cascade closes), not fewest vertices — fewest-vertices
  is a SAT-shrinking artifact wearing scars. THIRD MEASUREMENT (M31): even
  ENRICHING sub-witness chunks with the full gen-1 closure material (16,365
  vertices, 67,568 edges at the 1200-committed radius) leaves them
  4-colourable in seconds — the 5-mechanism is irreducibly global at this
  order; no closure shortcut below the whole witness exists at gen-1.
  FOURTH MEASUREMENT (M32): DESIGNED one-family stacks — including the
  triangle stack whose three translation matchings compose into 26
  forced-rainbow unit triangles spanning three detuned copies — carry zero
  compulsion of any order probed (pair, triple, coverage) at ~1,500
  vertices; the globality holds for designed objects too.*
* **G13 — The centre transition (the fan ladder)** (Kooshi's observation,
  2026-08-10, verified exactly the same night): the recurring mechanism of
  the colour steps is CONFINEMENT AT A CENTRE — the fan/coverage condition
  M18 formalized (`fan_iff_coverage`). The ladder: **3→4** — the two circles
  alone are 3-colourable **[kernel: M19]** and adding the centre forces the
  4th (the rainbow floor) **[kernel: M20]**; **4 without a centre** — the
  certified hexagram's meta-centre is BLIND (not a vertex; χ = 4 anyway):
  the 4-forcing routes through the PIVOT centres, which the self-seeding
  identity makes vertices for free — the crystal provides its own centres
  **[kernel: M26]**; **4→5** — Heule-510's centre is confined at four BY THE
  AMBIENT WEB: every proper 4-colouring of 510 − v0 covers v0's unit circle
  (36 points) with all 4 colours (one symmetric SAT ask, UNSAT 10.1 s,
  controls green), so v0 transitions to the 5th **[measured, 2026-08-10]**.
  Its own two-circle system provably CANNOT deliver that confinement
  (class-only graphs are 3-colourable, a 4th colour frees the pivot —
  **[kernel: M18]**; centre + circles caps at exactly 4 — **[kernel: M20]**)
  — so the centre's 5-transition is 100% ambient-delivered, and the inner
  circle participates through NO edge to the centre (1/√3 is not a unit) —
  M20's "compulsion acting through no edge" genre, one field up. Caveat
  measured honestly: fan-ness alone does not single out the centre — the
  degree-4 peripheral vertex 139 is ALSO fanned (its four neighbours forced
  rainbow in every 4-colouring, UNSAT 29.5 s, and no 4 plane points are
  pairwise unit-distant, so that rainbow is ambient-forced too) —
  vertex-criticality worn locally; the 5-forcing is a TAPESTRY of coverage
  compulsions (G10 again). What distinguishes the centre: its fan is the
  certified two-circle object in its coverage-4 state — the one compulsion
  whose isolated theory we own end-to-end. *Consequence for the instrument
  gap: coverage compulsion is a k-set property, structurally invisible to
  the pairwise rigidity sweep — P7's zero forced pairs and today's
  fanned-everywhere are the same fact seen from two orders. The
  coverage-order query (restrict N(v) to k−1 colours, one SAT call by
  palette symmetry) is the missing instrument, and it is CHEAP — built at
  M32 (`min_cover`/`coverage_query`, tools/rigidity.py); the hunt it
  enables is M33's golden question (G15). Falsifier
  for the ladder reading: a 5-forcer whose centres are all UN-fanned after
  deletion — then the 5-compulsion lives entirely off-centre.*
* **G12 — The quadrature law** (M31, derived a priori in the registered
  subplan, then verified at 26 exact censuses, zero violations): a detuned
  copy R·X of seam-field material X couples to X **only** along
  anchor-collinear pairs (R = s·W with W an even half-spindle word — a full
  spindle: Re(W) ∈ ℚ) or anchor-perpendicular pairs (W odd: Im(W) ∈ ℚ), with
  the radii on one explicit conic (t² + r² − 2·Re(W)(±tr) = 1, resp.
  + 2·Im(W)); words mixing √ρ₁₅- and √ρ₆₃-content couple NOWHERE. Proof
  shape: the 16-basis splits into four radical blocks K, √15·K, √7·K, √105·K
  and the chord equation must vanish per block. **[the ρ₁₅ instance is now
  KERNEL-CHECKED: `Quadrature.quadrature_rho15` (M32) — the pin and the
  conic as a theorem over explicit seam coordinates, resting on
  `sqrt5_indep`'s mod-5 descent; the ρ₆₃ instance remains measured-only, a
  numeral change away]** Measured instances:
  the (2,2) spindle diagonal, the (2/3, 2/3) perpendicular diagonal, and the
  **conjugate-ring channel** — rings at (17∓√33)/6 and (17±√33)/6 coupling
  through ρ₁₅ with t·r = 8/3: the first mechanism connecting the witnesses'
  ℚ(√33)-conjugate ring spectra (G4) to the coupling web. *Consequence,
  sharpening G7: a single detune's colour pressure is ONE CONIC of chords —
  thin by law — so 5-forcers cannot be built from chord soup; the forced-pair
  pipeline (de Grey's 791-forcer, Haugland's G₁/G₂) is not a design choice
  but the only channel wide enough. Falsifier: any census chord violating its
  pin — the instrument (tools/closure.py) aborts on one, naming P1.*
* **G14 — The stacking law, and width without degree** (M32, derived a
  priori in §0a, confirmed at every census point): a STACK's copy↔copy
  coupling is decided by the anchors — same anchor reduces to the
  single-word law at the relative detune forever (detunes form a group;
  the class is the spec quotient), while same-word copies at different
  anchors couple through a pin on the DIFFERENCE w = u − v, whose w = 0
  root at unit anchor separation is an O(n) **translation matching** — the
  arithmetic reason de Grey's construction has two spindle centres, and
  our triangle pivots supply unit anchor pairs natively. Confirmed exact:
  132-chord matchings at unit anchors (full and half words alike), ZERO at
  the √59-sterile 1/√3 separation, the chirality channel empty.
  **[measured + derivation; the census-confirmed §0a instances]** *The
  verdict on top, at face value: a matching is 1-regular — width without
  degree carries no colour pressure — and even composed matchings (the
  triangle stack's 26 spanning forced-rainbow triangles, genuine
  triple-order cross structure) are absorbed by the fabric's floppiness.
  Colour pressure needs degree-≥ 2 cross structure per point, which
  one-family stacks at probe scale provably do not create. Falsifier for
  the reading: a stack shape whose meters move — any reopening of the
  design thread registers its predictions first (M33 stub, parked list).*
* **G15 — The two-act anatomy, and the golden question** (2026-08-10, the
  M32 close discussion; Kooshi's re-aim: "I want to be able to confidently
  point to the reason why 5 colorings are forced"): every known 5-forcing
  argument factors as **pigeonhole × kill** — a DISJUNCTIVE class-level
  compulsion ("every 4-colouring of this fabric puts some forbidden pattern
  SOMEWHERE"; de Grey's informal mono-triple argument is the exemplar)
  composed with a thin, law-governed kill web refuting each placement (the
  half that is now kernel-checked: G12/G14). The disjunction explains the
  globality readings and M32's flat stacks: kills without a pigeonhole
  force nothing — and instance meters are structurally blind to the class
  (M32's stacks SAT on a fabric that M33 later showed FIRES the d2 class:
  the compulsion was there; the meters could not see it and the 1-regular
  matchings could not exploit a disjunction). **PROMOTED at M33 from
  [reading] to [measured] in its pigeonhole half**: the avoidance
  instrument found the class compulsion on four objects, and its Act-One
  carrier is SMALL — the 122-vertex 1-minimal core (G16). The neither-act
  falsifier branches registered in the stub did not fire; what remains
  [reading] is the ASSEMBLY claim — that pigeonhole × kill is not merely
  how known forcers are built but how χ ≥ 5 must be argued — tested by
  M34's union question.*

* **G16 — The distance-2 pigeonhole law** (M33, 2026-08-10; the
  instrument's discovery, found by a CONTROL and confirmed everywhere):
  **the hexagonal seam fabric cannot 4-colour without a monochromatic
  distance-2 pair** once it has (i) seam DEPTH ≥ 2 (the certified chunk:
  clean at B ≤ 1, fired at B = 2 — depth switches it, not radius) or
  (ii) radial extent past a fabric shell (bare de Grey fabric and the
  full 1581: onset r² = 2 − √33/9, IDENTICAL to nine decimals — the
  spindles neither create nor move it; Heule-510: onset at the glue
  shell 5/3). Distance 2 is exactly the ρ₁₅ spindle distance
  (4·2² − 1 = 15): **the pigeonhole is seam-native; every kill of it
  needs √15 — the field wall (G1) is exactly the wall between the two
  acts.** Act One's 1-minimal carrier: 122 vertices (de Grey's L: 121),
  12 near-rot6 shells about the metapivot, every member's necessity
  witnessed, both encodings agree. **[measured: build/m33-*.json, the
  explorer's M33 pane]** *Consequences: the design grammar for 5-forcers
  is "kill every d2 placement over a deep-enough seam region" — de
  Grey's and Haugland's pipelines are both instances; and the √3-pair
  pigeonhole is an ASSEMBLY product (only the full 1581 carries it,
  onset at the √21 shell where cross-system material enters — Heule's
  shrinking discarded it). Falsifiers: any validated 4-colouring of a
  named fired region avoiding all d2 pairs (would break both encodings
  at once = instrument catastrophe); a fabric-depth-2 seam region of
  comparable extent that stays clean; external — whether Haugland's
  heptagon fabric pigeonholes at ITS spindle distance (2, via the same
  ρ₁₅) is the cross-fabric test, unrun.*
* **G17 — Globality lives only at the top rung** (M33's resolution of
  the G10/G15 tension): the 4-onset (the fan = χ ≥ 5 itself, by the A1
  factorization) arrives exactly at the last vertex — measured at three
  centres, and provable from vertex-criticality in two lines — while
  EVERY sub-rung compulsion measured has a small carrier: min-cover 3
  at 49 = 36 + 13 (the interior web on (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6),
  the d2 pigeonhole at 122. G10's four globality measurements were all
  measurements OF THE TOP RUNG; the mechanism was never global — it was
  disjunctive, and the ladder below the top is made of small, nameable,
  certifiable objects. **[measured]** *The golden question's answer so
  far: the 3rd colour is delivered by a 13-point interior web; the leap
  to the 4th is the witness-wide composition of class pigeonholes with
  field-crossing kills — the object M34 tries to build minimally.*

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
