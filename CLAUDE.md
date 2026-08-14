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
- **The upper end, for completeness** — χ(ℝ²) ≤ 7, the classical hexagonal/brick
  colouring, kernel-certified at M36; with rung B the repository holds the whole
  classical interval **5 ≤ χ(ℝ²) ≤ 7** on the standard three axioms. Not new
  mathematics — it exists because the certificate machinery is the promotion path
  for any future periodic avoider, and an avoider at five colours IS the open
  upper-bound problem.
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

**Last updated: M45, 2026-08-13.**

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

M34 took Act One to the kernel, and the two-act theory produced its
first designed 5-chromatic object. The general layer
(`Pigeonhole.lean`): the **bridge** — a class-avoidance refutation IS
ordinary non-colourability of the pair-augmented edge list, so the
entire certified SAT chain applies verbatim, zero new trusted code; the
**transmuter** — the five-vertex forcing inside the nine-core (centre's
rainbow triangle + hub ⟹ hub forced to the transfer rim's colour,
decided at 4⁵ with all nine hypotheses certified load-bearing by one
mutation-audit decide), whose forced transfer crosses plane distance
exactly 2, the ρ₁₅ spindle distance — the √3 pigeonhole manufactures
d = 2 forced pairs inside its own gadget; and **A1 unconditional**
(`not_colorable_iff_covers`: χ(G) > k ⟺ every k-colouring of G − v
covers N(v) — the modeling pass found the colourability hypothesis was
interpretation, not mathematics). The carriers are kernel theorems:
`core9_pigeonhole` (two transmuters composed through one rim–rim edge,
no search; geometry at denom 512; the six pairs kernel-certified as ALL
√3-pairs among the nine) and `core122_pigeonhole` (a 12,578-line pinned
LRAT on the augmented list, replayed across 16 segments in minutes;
geometry at denom 12 in the seam sub-basis; the forty pairs
kernel-complete over 14,884 checks) — with the plane corollaries: **no
proper 4-colouring of the plane avoids monochromatic pairs at distance
√3, nor at distance 2** — the compulsions classical/Haugland-adjacent,
the 1-minimal carriers and the kernel formalizations ours. All on
axioms exactly `[propext, Classical.choice, Quot.sound]`. The census:
the forty d2 instances fall into **FIVE congruence classes** under the
exact order-12 dihedral group about the metapivot (which preserves the
chunk exactly), every endpoint on named shells — five kill theorems
price the width budget. And the union: the 9-core plus six 791-forcer
kill chains (forced-equal at 4/√3 + one unit edge each) —
**4,749 vertices, χ ≥ 5 by composition**: monolithic CDCL capped at
3600 s (a composition is invisible to clause learning), while the six
"which pair goes mono" cubes — cover soundness carried by the KERNEL
pigeonhole — each refuted in ~800 s. The two-act assembly reading (G15's
last [reading] half) is measured TRUE at the pair level; the union's
exact geometry (the chain rotations pick up √23) is the priced deferral,
and the certified-union milestone now has a measured shape. Lessons
banked: the M06-era `degrey_graph.json` and the standing loader are
different vertex orders (the forced-equal control caught the mix — a
union SAT verdict explained, not believed); palette symmetry costs
6.5–35× solver time, re-measured twice.

M35 ran the two-sided 6-programme, and both sides returned their honest
verdicts. Phase 1 — the k = 5 class-avoidance sweep, the question no one
had asked: **NO pattern class fires at five colours on any object we
hold** — 52 clean over 7 objects (both Heule witnesses, the 1581 at both
centres, the fabric, the certified chunk, the bare lattice) × 8 classes
(every vocabulary pair distance + the √3 triple), fan rows at min-cover 2
everywhere, the bare triangular lattice clean at k = 4 for distance-2
pairs (G16's pigeonhole confirmed fabric-borne — the coset obstruction,
proved by HNF enumeration in §0a, does not bind free colourings). The
6-hunt's Act One does not exist on today's objects: nothing we hold is
5-tight anywhere below its whole-witness top rung. Phase 2 — the
registered subplan corrected the stub's semantics before running (any
k = 5 avoider for ANY class subsumes χ(ℝ²) ≤ 5, so the avoider hunt at
k = 5 IS the open upper-bound hunt; a k = 6 avoider bounds only
SEVEN-forcers): the brick prober (rectangular torus tables, exact
closed-hull interval arithmetic, the SAT probe and the Lean certificate
checking the same finite object) ran ~2,800 registered rows with the
k = 4 mass-red control green throughout, and found that **the row-brick
family cannot 7- or 8-colour the plane at any probed shape** — squares,
long bricks, fine slabs alike; row-aligned cells cannot interlock the way
the hexagonal 7-colouring's tiles do; the family's probed threshold is
exactly 9, and the pixel-resolution question (32×32 at 1/8) capped
undecided. The kernel harvest: **`mono_pair_of_clique`** (the counting
face of the M34 bridge — no refutation anywhere); **the hex-shell
pigeonhole** (the closed first shell of the triangular lattice is a K7 of
the {1, √3, 2}-distance graph: every proper ≤ 6-colouring of the plane
has a mono pair at √3 or 2 — **χ(ℝ²; {1,√3,2}) ≥ 7**, elementary and
presumably folklore, ours the formalization and the 6-programme seed
framing); and **`Brick.lean` + `Instances/Nine.lean`: χ(ℝ²) ≤ 9,
kernel-checked** — the repository's FIRST certified upper bound, the
classical interval now bounded kernel-side at BOTH ends ([5, 9]; the
classical ≤ 7 needs polygonal cells, priced), with the avoidance surface
live (a certified 9-colouring avoiding √(3/2) — the exact consumer any
future k ≤ 6 avoider find instantiates same-day). All on axioms exactly
`[propext, Classical.choice, Quot.sound]`; instruments banked: the 3-bit
k = 5 re-encode, the clique-triviality guard, the k-threaded sweep
machinery, the prober with its catastrophe banner.

M36 closed the classical interval, and the shape of the milestone was decided
before any instrument ran. The registered stub had planned a hexagon module —
a new cell family, a rounding function, a ℚ(√3) ordered layer, ~300 lines —
because M35 had measured that no BRICK colouring passes the certificate at
seven colours. Working the arithmetic by hand for §0a found the real
obstruction, and it was not the tile family: it was **one comparison inside
M35's own certificate**. Cells are half-open, so the realizable difference
vectors at an offset form an OPEN box; a realized squared distance is
therefore strictly below the interval's upper end and strictly above its lower
end whenever that end is positive, and a sound certificate may accept an
offset whose interval merely TOUCHES a guard. M35's check demanded strict
separation — sound, but one comparison stronger than the truth. And the
classical brick seven-colouring is **boundary-tight by force**: the
self-offset demands `w² + h² ≤ 1` and the coset offset (1,2) — translation
exactly (2w, 2h), closed gap exactly (w, h) — demands `w² + h² ≥ 1`, so the
cell diagonal is EXACTLY the unit distance and no strictly-separating
certificate can accept any member. M35 §0j had additionally filtered its grid
by `diag² < 1`, deleting the solutions a second time. Relaxing one `≤` (and
parsing guard positivity into the certificate, without which `guards = [0]`
would make the relaxation unsound) landed **`χ(ℝ²) ≤ 7` kernel-checked** on a
`7 × 7` table of `4/5 × 3/5` half-open cells sheared `2/5` — the 3–4–5
triangle — coloured by the norm-7 coset map `(i + 3j) mod 7`, whose kernel is
ζ₆-stable hence the ideal `(−3 + ζ₆)`, so norm multiplicativity separates the
colour classes in two lines. **The classical interval `5 ≤ χ(ℝ²) ≤ 7` is now
kernel-checked at both ends** (`Instances/Interval.lean`), on axioms exactly
`[propext, Classical.choice, Quot.sound]`; neither end is new mathematics and
the module says so — ours is the certificate, the boundary-tight soundness
that makes any zero-margin colouring certifiable at all, and the correction of
a measurement's reading. The instruments agreed at every point: the design
script's offset census found 0 straddles with the tight rows exactly where
predicted, 3.8M exact unit-distance pairs found no monochromatic pair, the
prober produced its **first `k = 7` SAT ever** (the certified row as a positive
control, plus a second solution at shear `w/3` that the search found and the
kernel then accepted — the promotion pipe exercised end to end), and the
`k = 4` mass red held in all 298 rows, which is now the empirical guard on the
relaxation itself. The re-asked questions: `k = 6` refused in 1,394 rows and
`k = 5` in 1,394 — no brick colouring of the plane below seven at any probed
shape. Two findings beyond the registration: the certificate passes **exactly
at the two ideal coefficients** `c = 3` and `c = 5` (the roots of `x² − x + 1`
in `𝔽₇`) and never at the other five, so a SAT search knowing nothing about
`ℤ[ζ₆]` reproduced the algebra; and boundary-tightness is **not** a property of
the cell — a `k = 8` rectangle find sits tight at interior offsets `(0, ±1)`
and `(±2, ±3)` while its own diagonal is slack, which refuted half of the
registered §0j prediction and widened where the correction reaches.

M37 asked the next question a limitation theorem should ask — can any natural
FAMILY of colourings beat seven? — and closed the most natural family there
is. Colour each point of the plane by which class its **nearest lattice
point** falls into: that is exactly what the classical hexagonal
seven-colouring is, and what every "Voronoi + coset" scheme ever proposed is.
**No such colouring uses six colours or fewer — at any scale, for any
sublattice, under any tie-breaking — and seven is attained, so the coset
chromatic number of the plane is exactly seven** (`Coset.lean`, both halves
kernel-checked). The proof is four sweeps and two arithmetic facts, all on the
integral form `Q(a,b) = a²+ab+b²`, with no radical outside the embedding's own
definition: the **inscribed disc** (a point within `p/2` of a lattice point
rounds to it whatever the tie-breaking — one Cauchy–Schwarz off the Gram
identity, whose leftover square is what makes the form definite); the **deep
hole** `p(1+ζ₆)/3`, whose ray rounds to the origin because `a + b ≤ Q` is the
identity `2(Q−a−b) = (a+b)² + (a−1)² + (b−1)² − 2`, giving a same-coloured pair
of diameter `2p/√3` and hence `4p² ≤ 3`; the **collinear sweep**, which kills
kernel norms 1 and 3 through a gap lemma (a step shorter than the window hits
every window of width `2p`); and the **corner sweep**, which closes the seams
the collinear sweep leaves at norm exactly 4, where its windows only TOUCH and
the unit distance hides at `1/p = 3, 5, 7, …`. Then the arithmetic: 2, 5 and 6
are not of the form `a²+ab+b²`, so every nonzero kernel vector has norm ≥ 7;
and the closed first shell's 21 pairwise differences have norms in `{1,3,4}`,
all below that gap — the SAME seven-point object as M35's hex-shell K₇, met
from the other side. Sharpness is the classical colouring itself: the norm-7
ideal `(−3+ζ₆)` at scale `6/7`, with the covering radius (`p/√3`, so cells
have diameter under 1) and the ideal's minimum (`√7·p`, so same-coloured cells
stay clear of 1) — and the properness arithmetic stays rational throughout
(`(p/√3)² = 12/49 < 1/4` and `2 < √(36/7)`). **Consequence for the hunt: a
six-colouring of the plane, if one exists, is not a lattice colouring** — the
gap between coset and arbitrary colourings is exactly where it would have to
live, and the homomorphism hypothesis is load-bearing (drop it and an
arbitrary nearest-point colouring is a colouring of an annulus graph on the
lattice, whose chromatic number at fine scales is the plane's own open
question). The general-lattice case is open and priced: the crude
Hermite-plus-covering chain gives `k ≥ 6` for every planar lattice and `k ≥ 9`
for the square one, and closing `k = 6` needs a near-equality rigidity
argument from reduction theory.

M38 removed the hypothesis M37's own grokking had flagged. With the coset
map gone the object is the **constraint graph on the lattice** — join two
addresses when their cells hold a pair of points one unit apart — and the
theorem becomes a statement about that graph's clique: for scales
`p ∈ (1/2, 1)` its constraint set is exactly the first three shells
`Q ∈ {1, 3, 4}`, so the closed first shell is a **7-clique** and seven colours
are forced with no algebra whatsoever. **Any colouring of the plane that is
constant on the nearest-point cells of a triangular lattice at scale above
half the unit distance needs at least seven colours** — arbitrary labels, no
homomorphism (`seven_le_card_of_cell_constant`), and exactly seven at
`p = 6/7` (`cell_chromatic_eq_seven`). The window is binding at the
nearest-neighbour shell, confirmed exactly, with the planted red firing at
`p = 1/2` and below. **The boundary is the finding**: below it the constraint
graph becomes a thin annulus graph on a fine lattice, whose chromatic number
is the plane's own open question — so *any six-colouring of the plane has
colour classes finer than half the unit distance in every lattice's cells*,
which is precisely the regime M36's pixel probes were capped undecided in.

M39 turned M38's viewpoint on the open half of the problem. For every scale
`p` the constraint graph `G(p)` has the property that **a proper colouring of
it IS a proper colouring of the plane**, so `χ(ℝ²) ≤ χ(G(p))` — and M38's
theorem says `χ(G(p)) = 7` on the classical window, which is the hexagonal
seven-colouring recovered as a graph-colouring fact. Below that window nobody
had looked, because the family was invisible until the constraint reading. The
census, on an EXACT criterion (necessary as well as sufficient — G21 applied
before the fact rather than after), found the requirement is **not monotone in
the scale**: seven in the classical window, **eight just below it**, seven
again near `p ≈ 0.46`, then the clique collapsing as the cells shrink. Both turns are theorems, not census rows —
`Coset.seven_le_card_fine` proves the return to seven on `3/8 < p < 2/5` via
the **`√3`-scaled copy of the same shell** (the index-3 sublattice, pairwise
norms `{3,9,12}`), so the shell reappears at every scaled copy of the lattice;
and the rise is
`Coset.eight_le_card_of_cell_constant`: for `1/2 < p < 3/5` any cell-constant
colouring needs at least EIGHT colours, via the `3 × 3` address block with one
corner dropped, whose pairwise differences all have norm in `{1,3,4,7}`. And the ball refutations — finite patches, no
periodicity assumed — settle the spectrum outright: `≥ 7` in the classical
window, **`≥ 9` in the band just below it** (two colours worse, stronger than
the 8-clique theorem), `≥ 8` at `p = 1/3`, `≥ 7` at `p = 0.4` and `1/4`, and
**exactly 7 at both `p = 6/13` and `p = 1/6`** — the latter seven times finer
than the classical scale, so good scales recur all the way down. **So the classical scale is a local optimum and
refining the cells costs colours**
— "make the cells smaller" is not a route to six. The campaign found no
six-colouring at any of twelve scales on tori to 24 × 24 (reported as
period-bounded, never as `χ(G) > 6`), a seven-colouring at `p = 6/13` below the
classical window (so the good scales are not one interval), and — the control
that changed a reading, and went further than retracting it — the fine-scale
seven-refusals are period-bounded: at `p = 1/4` the bigger tori return UNKNOWN
at cap, at `p = 1/3` they return a genuine UNSAT to period 30, and **at
`p = 1/7` a seven-colouring SATs on a 24 × 24 torus**. The tentative "finer is
worse" reading was not merely unsupported but wrong; the oscillation runs all
the way down, good scales (`0.67–0.86`, `6/13`, `1/7`) interleaved with bad
ones (`0.5–0.6`, `1/3`).

M40 was the structure hunt Kooshi asked for ("anything that looks suspiciously
organized"), and the anomalies were already sitting in M39's own data, unread. The
family is piecewise-constant in the scale — one fixed graph per BAND between rational
`T²` thresholds, keyed by point-group class (distinct classes share a norm with
different thresholds, first at 49) — and the corrected census rewrites the spectrum:
M39's clique search was box- and cap-clipped, and the true story is **χ = 9 exactly on
the bad band** (a sheared 3×3 block is a 9-clique — the "≥ 9, stronger than the
8-clique" mystery was a bigger clique), **χ = 12 exactly on `p ∈ (0.4804, 0.5)`** (a
12-point trapezoid clique + the index-12 coset colouring; the local pessimum just below
the classical scale is TWELVE), and §0e's "scaled-shell route exhausted at M ∈ {1,3}"
was FALSE under the exact criterion (the M = 4 shell owns the band `(0.3273, 1/3)` — a
G21 instance inside a G21-aware milestone). Then the finding: **below the classical
window the family forces ≥ 7 everywhere probed, outright (balls, no periodicity), down
to `p = 0.2236`, while the clique number collapses to 3–5.** The gap objects are
canonical, vertex-transitive, and finitely checkable: **G\*** (the band
`(0.4330, 0.4804)`, norms {3,4,7,9}) has **ω = 4 and χ = 7**, its seven-forcing
shrinking to a **23-vertex 1-minimal core** (centre + full norm-1 and norm-4 hexagons +
partial norm-3/norm-7 shells, near-rot6 symmetry broken — the same motif as de Grey's
122-core); the **deep pocket** `(1/3, 0.3464)` has **ω = 4 and χ ≥ 8 outright** (a
91-vertex ball refuses seven; 53-vertex core); and the bands flanking `p = 1/6` have
**ω = 3 — the plane's own clique number — with χ = 7 exactly**, a gap of FOUR. The
mechanism is invisible to every standard relaxation: certified Hoffman brackets collapse
to ≈ 4.1 exactly where the cliques collapse, and the fractional relaxation reaches only
χ_f ≤ 48/7 at G\* (α(12×12) = 21) — the step to seven is integrality. And the classical
mechanism is provably unavailable: **all eight index-7 sublattices contain an edge of
G\*** (same at the 1/6 and 1/7 bands), so no coset seven-colouring exists below the
window — the SAT witnesses there have non-uniform classes and trivial stabilizers. The
family is a finite-per-band mirror of Hadwiger–Nelson's own pathology (ω = 3, every
relaxation low, χ high), and **the sharpest open scale is `p = 1/7`** (ω = 3, balls to
225 six-colour, tori refuse six to period 36): the six-hunt's from-above target list is
now concrete. Explorer published (`build/m40-spectrum.html`); kernel promotion of the
12-clique window, the M = 4 shell window, the coset-impossibility, and χ(G\*) = 7 is
priced and stubbed as M42.

M41 ran the k = 5 gradient hunt in one day — subplanned and executed on the laptop,
every phase parallel — and the theory moved on three fronts while every gradient meter
read zero. **The autopsy (G26)**: all five of M40's clique-free forcer cores FACTOR as
pigeonhole × kill — Act One is always a mono pair forced onto a small NON-EDGE class
(the hex-shell counting argument surviving the clique's death), the fractional
relaxation always collapses (130/23, 501/74, ≈ 4.838 against χ = 7/8/7 — gap 2.16 at
the ω = 3 core, the programme's extreme) — so **the 6-forcer reduces to ONE k = 5
forced-distinct gadget at √3 or 2** (`hexShell_pigeonhole` is Act One in the kernel
already; nine gadget copies on the shell close χ ≥ 6 by the M34 composition genre).
**The Galois orbit (G27)**: the 1581 is fixed identically by the field flip
√3,√5,√11 ↦ −·− — a hidden **Klein four-group of non-geometric automorphisms** on a
graph with NO plane self-isometry — and the orbit's four isometry classes mint **three
new 5-chromatic witnesses** (one isospectral twin; W^[3] solver-verified end to end:
7,877 edges re-derived, k = 4 UNSAT 3,005 s); **P9 exact: de Grey's 791-forcer IS the
witness's centrosymmetric core**, so M30's forced central symmetry is substrate
symmetry at criticality; the witness is **half-crystal** (787/1581 rot6-invariant);
Heule-510 has no √7 content. **The flat verdicts, all settled exactly**: m1 (forced
pairs + virtual edges at k = 5) is ZERO on twelve composed objects — eight crystal
unions through six copies, three witness–conjugate hetero-dimers (interfaces to 1,101
shared vertices), the four-witness family union; gen-2 closure = **284,873 points,
1,477,824 edges** (32% fusion — the group is folding), whole object k = 5 SAT in
343 s; and **the reduction's gadget question, asked directly for the first time: 0
virtual edges in 40 targeted asks** at exact √3/2 pairs on gen-2. The only nonzero
readings anywhere: two solver-effort signals (hetero-dimers 10×; gen-2 ×300 at ×12
size). Instruments banked: `tools/gradient.py` (overlap census, union builder with
from-scratch edge derivation, autopsy driver, Galois conjugator, non-geometric
equivariance queries). The jackpot clause never fired; the flat clause is banked as
the k = 5 extension of G10/G17 to composed matter.

M42 took the gap atlas to the kernel, same day. The four headline pieces of M40 are
now theorems on axioms exactly `[propext, Classical.choice, Quot.sound]`, in two
sittings: the engine plus three windows in the morning (`Coset.lean` §GapBands —
`exists_unit_pair_ivt`/`exists_unit_pair_corner`, the exact-hexagon reach
`Q + 2·holeF + 4/3` whose corner values ARE the D1 band boundaries;
**`seven_le_card_shell4`** — the M = 4 scaled shell forces seven on
`3/28 < p² < 1/9`, the window M39 §0e had wrongly priced as exhausted;
**`twelve_le_card_of_cell_constant`** — TWELVE colours on `3/13 < p² < 1/4`, the
local pessimum below the classical scale; **`no_coset_seven_on_gap`** — no nonzero
homomorphism to `ℤ/7` is proper on the G\* band, by a 14-candidate kernel-vector
decide, so the classical coset mechanism is structurally dead below the window), and
the crown in the afternoon: **χ(G\*) ≥ 7 via the 23-vertex core, kernel-checked**
(`Instances/Core23/`). The core's graph is **derived, not transcribed** — 23 addresses
plus one norm-{3,4,7,9} filter produce the 143 edges, so the refuted CNF, the pinned
clause table, and the corollary's geometry all reduce to the same data — and the
refusal is the M05 LRAT chain at six colours (219 derived clauses, 2 segments,
kernel-replayed in seconds; the registered decide route died honestly on an instance-
synthesis wall and P4's fallback fired as written). With the red control
**`core23_colorable_seven`** (a verified 7-colouring using all seven colours) the core
is **χ = 7 exactly with ω = 4, kernel side** — the programme's first certified
`χ ≥ ω + 3` object — and **`Coset.seven_le_card_gap`** carries it to the plane: any
cell-constant colouring at a G\*-band scale needs SEVEN colours, the count routed
through the core's refutation because no 7-clique exists to count against. The
gap law (G24) is now kernel-checked in its forcing half at four windows; what remains
measured-only is the deep pocket's χ ≥ 8 and the fine-tail ω story. Palette pin
re-measured at k = 6: 240 vs 38,528 LRAT lines, 160×.

M43 went to the sharpest open scale and closed it — and the campaign's most important
finding is not the closure but what the autopsy could not find. **χ(G(p)) = 7 exactly on
both bands flanking `p = 1/7`**, the last scale in the family where six colours were
undecided in either direction. The coarse flank (`T² ∈ (139/3, 49)`, never probed by any
earlier milestone — M39/M40's "p = 1/7" rows all attach to the FINE flank's graph) refuses
six **outright**: nine independent ball radii, minimum `R* = 9` at 301 vertices, the
refusal re-confirmed by the deleted-centre encoding with different symmetry breaking and no
pin; the fine flank follows by edge-set inclusion, and M39's 24 × 24 seven-colouring
descends to both, so seven is exact on both. Neither flank admits a periodic six-colouring
of index ≤ 96 (**7,624 period lattices each**, exhaustive over Hermite normal forms, zero
unknown, mass-red control green). The censuses extended the ≥ 7 floor over ten more bands
between `p = 0.2236` and `1/7` and nine in the deep tail down to `p ≈ 0.109`, with ω = 3
everywhere below `T² ≈ 64/3` — twelve deep-tail bands are recorded as honest unknowns at
cap, not as refusals. **The autopsy is the finding: the 1/7 seven-forcing does NOT factor
as pigeonhole × kill.** Act One is free by counting (the closed shell's seven addresses
have all 21 mutual offsets at norms {1,3,4}, none of them edges at this scale, so six
colours force a repeat) — but Act Two does not exist: forcing such a pair to share a colour
stays satisfiable on the R = 8 stage's 241 vertices, *more material than the 160-vertex
core that refutes outright*, and the same at every small non-edge class (norms 1,3,4,7,9,12,
all decided in under a second). **Zero virtual edges at k = 6** — the from-above echo of
M41's flat table from below, and the falsifier G26 registered and never found in five
cores. The compulsion is not pair-mediated; it is global over 160 vertices, which is what
"integrality-carried" had asserted and is now measured as an absence rather than inferred
from a relaxation gap (the certified Hoffman bracket at the flank reads **3.56 against the
truth 7** — below even G\*'s 4.09). The registered literature check delivered the
milestone's reframing: **Voronov (arXiv:2304.10163) has PROVEN Exoo's conjecture** — every
closed interval `[1−ε, 1+ε]` of forbidden distances needs ≥ 7 colours at arbitrary ε > 0 —
and a two-line gap argument over the finitely many offset windows near 1 turns that into
**χ(G(p)) ≥ 7 for the entire cell family, every band, all the way down** (conditional on an
external preprint we have not verified). So the from-above door is closed twice over, G24's
"why is every band ≥ 7" has a conditional answer, and by compactness every band owns a
finite refuting ball — ours are the exact, finite, kernel-promotable certificates of a fact
the continuum proof does not produce. Kernel promotion is **priced and deliberately
declined**: the search is cheap (462 s monolithic; cube-and-conquer works and needs no new
Lean machinery) but the certificate is M06-scale — one medium cube logs **798,002 LRAT
lines, sixty-three times the entire 122-core certificate** — for a statement that is
conditionally implied by published work, is not a rung toward six, and sits below the
publication bar. The registered same-day promotion clause is reported UNMET with its
measurement.

M45 asked, on a calibrated bed, the question four campaigns had never asked — *at what order does a
colour compulsion live?* — and the answer came back as a **correction to this project's own record**.
The kernel layer landed first and reframed the question before any instrument ran: a compulsion is
**a partial colouring that does not extend**, the **arity floor** is the least number of vertices at
which local properness stops implying global extendability, and — the derivation that mattered — **a
vertex with `k` distinct neighbours makes the rainbow pattern on them unrealizable, so the arity
floor is at most `k` with no hypotheses at all**. Since every object here has minimum degree far
above its colour count, *the four flat pair campaigns were asking an arity-2 question on objects
where a compulsion of arity ≤ k was guaranteed to exist.* Then the measurement. M43 had recorded
**"zero virtual edges at k = 6"** on the fine-tail core and concluded its forcing does not factor as
pigeonhole × kill; its ask was **six questions** — force colour(0,0) = colour(d) at the six smallest
non-edge classes — on the R = 8 ball. Re-run on **the identical stage**, M43's six asks **reproduce
exactly** (6 realizable, 0 compelled) — and that same stage carries **seven virtual edges** at offset
norms 27, 28, 31, classes the sweep never touched, each decided in 7.5–15 s and **each confirmed in
three independent encodings** with every control green. On the *critical* stage (the 1-minimal core
less one vertex, one vertex short of refusing) the complete sweep of all 9,636 non-adjacent pairs
finds **51** virtual edges, 0 forced pairs, 11 undecided at cap. The two effects separate cleanly:
**coverage is primary** (six asks against thousands), criticality secondary (51 against 7 on
identical pairs). **G28's pair-mediated half is refuted — Act Two exists — and "the forcing does not
factor" was a measurement of a six-element acceptance set, not of the object.** Three genuine
arity-3 compulsions were also confirmed (all sub-pairs verified free, two encodings each), and a
fourth candidate that turned out to be a virtual edge in disguise is recorded as such and is now a
planted control in the instrument. The milestone's remaining phases — the exhaustive ladder on the
kernel-certified 23-core, the fan-shrink upper bracket, the randomized-order re-shrink — are **not
run** and are reported as not run.

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

| 31 | **Act One as kernel theorems + the composed 5-forcer** (M34): the **pigeonhole bridge** (`mono_pair_of_not_colorable_append` / the iff — class avoidance IS colourability of the pair-augmented edge list, so the certified SAT chain applies verbatim); the **transmuter** (five-vertex forcing, 4⁵ decide, nine-way mutation audit; its forced transfer crosses distance exactly 2 = the ρ₁₅ spindle distance); **A1 unconditional** (`not_colorable_iff_covers`: χ(G) > k ⟺ every k-colouring of G − v covers N(v) — the fan query as a theorem, no side condition); **`core9_pigeonhole`** + **`core9_plane`** (every proper 4-colouring of the plane has a mono √3-pair — nine-point 1-minimal carrier, two transmuters + one edge, geometry denom 512, pair list kernel-complete); **`core122_pigeonhole`** + **`core122_plane`** (every proper 4-colouring of the plane has a mono distance-2 pair — 122-point carrier on the certified hexagram's seam lattice, pinned LRAT of 7,892 derived clauses replayed by the kernel, geometry denom 12, forty pairs kernel-complete over 14,884 checks); `UDCert.PairsAt` + `pairsAt_sound` (class-distance certification at any √r). All on axioms exactly `[propext, Classical.choice, Quot.sound]`. Tools-side, controls red/green throughout: the census (forty d2 instances = FIVE dihedral classes, endpoints on named shells) and the **composed union** — 9-core + six 791-forcer chains, 4,749 vertices, χ ≥ 5 by kernel-covered cubes (six UNSATs at ~800 s) where the monolithic solve capped at 3600 s. | `Pigeonhole.lean`, `PairDist.lean`, `Instances/Core9.lean`, `Instances/Core122{,/}`, `build/m34-*.json` | M34 |
| 32 | **The two-sided 6-programme's first pass** (M35): kernel side — `mono_pair_of_clique` (the counting face of the M34 bridge: a (k+1)-clique of the augmented graph forces a mono class pair with NO refutation certificate anywhere); the **hex-shell pigeonhole** (`HexShell.lean`: the closed first shell of the triangular lattice — a point and its six unit neighbours — is a K7 of the {1,√3,2}-distance graph; `hexShell_pigeonhole` k-generic below seven; plane corollaries at five and six colours: **every proper ≤ 6-colouring of the plane has a mono pair at √3 or 2, i.e. χ(ℝ²;{1,√3,2}) ≥ 7** — compulsion folklore, formalization ours); the **brick certificate machinery** (`Brick.lean`, zero sorry: `Brick.sound` — closed-hull offset-window soundness over the whole plane, window computed inside the check; `colorable` demanding properness structurally; `avoids` with the corrected avoider semantics; `colorQ` the computable twin) and **`plane_colorable_nine`: χ(ℝ²) ≤ 9 kernel-checked** — the first certified upper bound, the interval [5, 9] now kernel-side at both ends, plus a certified 9-colouring avoiding √(3/2) (`Brick.avoids` live). Tools-side, controls red/green throughout: the **k = 5 class sweep, all-clean** (52/4/0 over 7 objects × 8 classes — the first class-level k = 5 measurement anywhere; fans at min-cover 2; the sweep-halt rule never armed); the bare lattice clean at k = 4 d2 (the §0a HNF coset obstruction — no index-4 coset colouring avoids {1,2}, three of five index-5 sublattices avoid {1,2} while none avoids {1,√3} — does not bind free colourings); the **row-brick interlock finding** (~2,800 rows: no 7- or 8-colouring at any probed shape — squares, long bricks, fine slabs; threshold exactly 9; pixel squares capped undecided); instruments banked (3-bit re-encode, clique-triviality guard, k-threading, the prober + catastrophe banner). | `Pigeonhole.lean` (`mono_pair_of_clique`), `Instances/HexShell.lean`, `Brick.lean`, `Instances/Nine.lean`, `build/m35-*.json`, `plans/M35-k5-transfer.md` §R | M35 |
| 30 | **The mechanism hunt's first harvest** (tools-side, every claim double-encoded or theorem-closed): (a) the criticality factorization A1 (χ(G) ≥ k+1 at a vertex ⟺ the fan on its circle, when G−v is k-colourable) — derived a priori, validated at three centres, and used to CLOSE a capped solver row by mathematics; (b) **the d = 2 pigeonhole**: avoid-all-mono-d2-pairs is UNSAT on the certified hexagram chunk at B = 2, on the bare de Grey fabric and the 1581 at the IDENTICAL onset 2 − √33/9, and on Heule-510 at the glue shell 5/3 — fabric-borne, depth-switched (clean at B ≤ 1), at exactly the ρ₁₅ spindle distance; Act One's 1-minimal carrier = **122 vertices / 12 shells** with per-member necessity witnesses; (c) **the 3-cover core**: 36-circle + **13 interior points** on (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6 delivers min-cover 3 at Heule-510's centre; (d) the √3-pair pigeonhole exists ONLY in the assembled 1581 (onset at the √21 shell — cross-system material), not in the fabric, not in shrunk 510 — and its 1-minimal core is **NINE vertices**: two √3-triangles with their unit circumcentres (M18's `exists_unit_triangle_iff` object), a hub, and one rim–rim edge — hand-proved in two cases, `decide`-scale for M34; (e) the class-avoidance instrument (arity-generic mono-avoidance, base-SAT guard as control flow, five honest verdicts, first-occurrence breaking, binary re-encode promotion ladder, 1-minimal shrink engine) with the 791/M20-skeleton/planted controls all red/green. | `tools/mechanism.py`, `tools/rigidity.py` (class_avoid), `build/m33-*.json`, the explorer's M33 pane, `plans/M33-mechanism-hunt.md` §R | M33 |

| 33 | **The classical interval, kernel-checked at both ends** (M36): the **boundary-tight sharpening** — half-open cells make the realizable difference set an OPEN box, so a realized squared distance is strictly below `hiAt` and strictly above a positive `loAt`; `Brick.check` accepts `q ≤ loAt ∨ hiAt ≤ q` (the exact miss condition, not a sufficient one) and PARSES guard positivity in (`check_pos`), without which `guards = [0]` would be accepted and `sound` would deny a point its own colour. Consumers got simpler, not harder: `sound` keeps its signature and `avoids` LOSES its nonnegativity argument. **`plane_colorable_seven` / `chromaticNumber_plane_le_seven`: χ(ℝ²) ≤ 7** on a 7 × 7 torus of `4/5 × 3/5` half-open cells, shear `2/5` — the 3–4–5 triangle, cell diagonal exactly 1 — coloured `(i + 3j) mod 7`, the norm-7 ideal `(−3 + ζ₆)` of ℤ[ζ₆] (ζ₆-stable kernel ⟹ ideal ⟹ same-colour centres separated by norm multiplicativity, no lattice census); and **`chromaticNumber_plane_interval`: 5 ≤ χ(ℝ²) ≤ 7**, the classical statement of Hadwiger–Nelson, both ends kernel-side on axioms exactly the standard three. The colouring is classical (Isbell; half-open brick variants folklore) and no novelty is claimed for it — ours is the certificate, the sharpening, and the correction. Controls: two boundary-tightness pins (`hiAt 0 0 = 1`, `loAt 1 2 = 1`), six mutations refusing (two shapes, shear 0, two non-ideal coefficients, the flat table), the degenerate guard refused, seven `colorQ` samples. Tools-side, every claim on a third code path: the design script's census (0 straddles, tight rows exactly as predicted, 3.8M exact unit pairs with no mono pair), the prober's **first k = 7 SAT** (control + a searched second solution at shear `w/3`, promoted through the kernel), the `k = 4` mass red held in 298 rows, `k = 6` and `k = 5` refused in 1,394 rows each, and the certificate passing **exactly at the two ideal coefficients** `c ∈ {3, 5}` across a 7 × 5 census. | `Brick.lean` (`check_pos`, `sq_lt_of_abs_lt`/`lt_sq_of_abs_lt`/`le_sq_of_abs_lt`, `sound`), `Instances/Seven.lean`, `Instances/Interval.lean`, `build/m36-*.json`, `plans/M36-seven-coloring.md` §R | M36 |

| 34 | **The coset bound: the coset chromatic number of the plane is exactly seven** (M37): `Coset.seven_le_card` — every proper nearest-point coset colouring of the plane (triangular lattice, ANY scale, ANY sublattice, ANY tie-breaking) uses at least seven colours, via `Coset.seven_values` (the seven lattice points of the closed first shell get seven distinct colours); and `Coset.exists_proper_coset_colouring` — the norm-7 ideal `(−3+ζ₆)` at scale `6/7` is such a colouring with exactly seven, so the bound is attained (`Coset.coset_chromatic_eq_seven`). The engine, entirely on the integral form `a²+ab+b²`: the inscribed disc + Gram identity, the deep hole (`4p² ≤ 3` from its own diameter), the collinear sweep with a gap lemma (kills kernel norms 1 and 3), the corner sweep (closes the norm-4 seams at `1/p` odd, where the collinear windows only touch), the Loeschian gap (2, 5, 6 are not norms ⟹ kernel norm ≥ 7), and the shell's difference table `{1,3,4}`. Sharpness adds the covering radius (`p/√3`) and the ideal's minimum (`√7 p`), with all properness arithmetic rational. **A six-colouring of the plane, if one exists, is not a lattice colouring.** Attribution: the optimality statement is folklore-adjacent and no novelty is claimed for the construction; ours is the proof shape, the formalization, and the packaging as a limitation theorem for the upper-bound hunt. | `Coset.lean`, `build/m37-design.py`, `plans/M37-coset-bound.md` §R | M37 |

| 35 | **The coarse-cell bound: the homomorphism removed** (M38): `Coset.seven_labels_of_cell_constant` — for `1/2 < p < 1`, ANY colouring constant on the nearest-point cells of the triangular lattice at scale `p`, with **no algebraic relation between the labels**, gives the seven closed-shell addresses seven pairwise distinct labels; `seven_le_card_of_cell_constant` counts them; `cell_chromatic_eq_seven` pairs that with M37's witness at `p = 6/7`. The mechanism is a change of viewpoint rather than a new computation: the constraint graph's edge set on that window is exactly `Q ∈ {1,3,4}` (each condition `(1−p)² < p²Q < (1+p)²`, radical-free), so the closed first shell is a 7-clique and M37's Loeschian gap is replaced by the clique. The sweep was refactored into its honest form — `exists_unit_pair`, which PRODUCES the unit pair from two addresses and a direction with no mention of colour, and of which M37's is an instance. Window confirmed exactly `(1/2, 1)` with the planted red firing at and below `1/2` (`build/m38-design.py`, 5,997 rows agreeing between the radical and radical-free forms). | `Coset.lean`, `build/m38-design.py`, `plans/M38-cell-bound.md` §R | M38 |

| 38 | **The gradient hunt's harvest: the reduction, the hidden symmetry, and the flat table** (M41, tools-side on exact arithmetic; laptop, one day): (a) **the autopsy dictionary** — all five clique-free cores factor as pigeonhole × kill with Act One a mono pair on a small non-edge class and χ_f certified exactly (130/23, 501/74, ≈ 4.83796 bracket-tight over 235,154 maximal independent sets) — G15-universality 5/5 in the finite lab, and **the 6-forcer reduction**: one k = 5 forced-distinct gadget at √3 or 2 + nine shell copies = χ(ℝ²) ≥ 6; (b) **the hidden Klein four-group** — the 1581 fixed identically by flip[3,5,11] (involution, 29 fixed points, edges preserved exactly), no plane self-isometry, orbit = 4 isometry classes ⟹ **three new 5-chromatic witnesses** (W^[5] isospectral; W^[3] verified by direct k = 4 UNSAT), **P9: the 791-forcer = V ∩ −V exactly**, the witness half-crystal (787 rot6-core), Heule-510 √7-free; (c) **the flat table** — m1 zero and settled on twelve composed objects; gen-2 = 284,873 pts / 1,477,824 edges, k = 5 SAT 343 s; **0/40 virtual edges at exact √3/2 pairs** (the reduction's first direct measurement); only nonzero: two solver-effort signals. | `tools/gradient.py`, `build/m41-*.json`, `plans/M41-k5-gradient.md` §R | M41 |

| 39 | **The gap atlas, kernel side: χ = 7 with ω = 4, and the coset mechanism dead below the window** (M42, same day as M41; all on axioms exactly the standard three): the sweep engine's existence forms — `Coset.exists_unit_pair_ivt` and **`exists_unit_pair_corner`** (pushing along a deep hole sweeps the realizable norm from `Q` to `Q + 2·holeF + 4/3` — the exact-hexagon window beyond M38's inscribed disc, whose corner reaches ARE the D1 band boundaries: norm 4 needs `p² > 3/28` exactly, norm 1 `p² > 3/13` exactly), with `norm_one_hole`/`norm_four_hole` classifiers; **`seven_le_card_shell4`** (the doubled shell forces seven on `3/28 < p² < 1/9` — the M = 4 window M39 §0e priced as exhausted, a G21 instance corrected in the kernel); **`twelve_le_card_of_cell_constant`** (TWELVE on `3/13 < p² < 1/4` via the sheared trapezoid, the local pessimum below the classical scale); **`no_coset_seven_on_gap`** + `exists_kernel_vector` (every nonzero hom `ℤ×ℤ →+ ℤ/7` kills a vector of norm {3,4,7,9} — a 14-candidate decide — so no coset seven-colouring exists on the G\* band); and the crown, **`core23_not_colorable_six`** (`Instances/Core23/`): the 23-address G\* core — graph DERIVED from the addresses by the norm filter, 143 edges, never transcribed — refuses six colours through the M05 LRAT chain (219 derived clauses, 2 segments; the Gadget palette closure over the 4-clique ports; the emitter chain's second non-4 instance), with red control **`core23_colorable_seven`** (verified 7-colouring, seventh colour used) pinning **χ(core) = 7 exactly at ω = 4 — the first kernel-checked `χ ≥ ω + 3` of the programme** — and plane corollary **`Coset.seven_le_card_gap`**: any cell-constant colouring at `3/16 < p² < 3/13` uses at least seven colours, the count routed through the refutation because no clique can carry it. Registered decide route (P4) died on a Lean instance-synthesis wall (staged DFS-shaped ∀, 5,391 nodes, unification failure in the Decidable resolvers at depth ≥ 4) and the fallback fired as registered. Controls: three planted mutations seen red (corrupted colouring refused, wrong pin pattern refuses to bridge, clique gadgets alone leave exactly the one survivor the certificate kills); palette pin at k = 6 re-measured 160× (240 vs 38,528 LRAT lines). | `Coset.lean` §GapBands, `Instances/Core23/{Edges,Cnf/*}.lean`, `Instances/Core23.lean`, `plans/M42-gap-kernel.md` §R | M42 |

| 37 | **The gap atlas: below the classical window the cell family forces seven-plus without cliques** (M40, tools-side on exact arithmetic; kernel promotion stubbed as M42): the family `G(p)` is **one fixed graph per band** between rational `T²` thresholds keyed by point-group offset class (distinct classes share a norm with different thresholds, first at norm 49 — planted check green); the corrected exhaustive census — M39's was box- and cap-clipped — gives **χ = 9 exactly** on `p ∈ (1/2, 0.6547)` (the sheared 3×3 block 9-clique + k = 9 SAT), **χ = 12 exactly** on `p ∈ (0.4804, 1/2)` (the 12-point trapezoid clique + the index-12 coset colouring), and the **M = 4 scaled shell** as a real 7-clique band on `(0.3273, 1/3)` (M39 §0e's exhaustion claim was derived with the inscribed-disc sufficient window — a G21 instance); **every band down to `p = 0.2236` is ≥ 7 outright** (ball refutations, no periodicity) while ω collapses to 3–5: **G\*** (`(0.4330, 0.4804)`, norms {3,4,7,9}) has ω = 4, χ = 7, and a **23-vertex 1-minimal core** with every necessity witness held; the **deep pocket** (`(1/3, 0.3464)`) has ω = 4, **χ ≥ 8 outright** (91-vertex k = 7 refusal; 53-vertex core); the `p = 1/6` flank bands have **ω = 3 with χ = 7** (gap FOUR, re-proven without the boundary class — every integer T is a threshold scale, so M39's integer rows were closed-criterion graphs); **no coset seven-colouring exists on G\* or the 1/6/1/7 bands** (all eight index-7 sublattices contain an edge, explicit witnesses) — the witnesses found are non-uniform with trivial stabilizers; certified Hoffman brackets collapse to ≈ 4.1 at the gap bands (truth 7–8) and α(G\*, 12×12) = 21 gives χ_f ≤ 48/7 — the seven-forcing is integrality-carried; **the sharpest open scale is `p = 1/7`**. Instruments banked: class-keyed band decomposition, exhaustive clique search, batched 1-minimal shrink with necessity certificates, colouring-anatomy (stabilizer/coset tests), exact torus α (Sinz counter), certified spectral brackets. Explorer `build/m40-spectrum.html`. | `tools/celllat.py` (M40 suite), `build/m40-chiomega.json`, `plans/M40-chi-omega-hunt.md` §R | M40 |

| 40 | **The fine tail closed, and a forcing that does not factor** (M43, tools-side on exact arithmetic; laptop, one day): **χ(G(p)) = 7 exactly on both bands flanking `p = 1/7`** — the coarse flank `T² ∈ (139/3, 49)` (11 edge classes, degree 114, **never probed before**: every earlier "p = 1/7" row keys to the FINE flank) refuses six OUTRIGHT at nine radii, minimum `R* = 9` / 301 vertices, double-encoded (the deleted-centre A1 form, unpinned, agrees), with the fine flank following by inclusion and M39's 24 × 24 seven descending to both; **no periodic six-colouring of index ≤ 96 on either flank** (7,624 Hermite-normal-form period lattices each, zero unknown, mass-red green). Nineteen further bands floored ≥ 7 outright (ten between `p = 0.2236` and `1/7`, nine in the deep tail to `p ≈ 0.109`), ω = 3 throughout below `T² ≈ 64/3`, twelve deep-tail bands honestly unknown at cap. **The autopsy: the forcing does NOT factor as pigeonhole × kill** — Act One free by counting (7 shell cells, mutual norms {1,3,4}, all non-edges), Act Two absent (every forced-equality at every small non-edge class SAT on 241 vertices, more material than the 160-vertex 1-minimal core; **zero virtual edges at k = 6**) — G26's registered falsifier, found; the certified Hoffman bracket reads 3.56 against truth 7. The **160-vertex core** (2,978 edges, 24 orbits, centre-ful, edges re-derived two independent ways, every necessity witness held) is the family's largest named carrier. Promotion priced and declined with numbers (one medium cube = 798,002 LRAT lines = 63× the whole 122-core certificate). Conditional on **Voronov's proof of the Exoo conjecture** (arXiv:2304.10163, external, unverified here): **χ(G(p)) ≥ 7 for the whole family at every scale**, by a gap argument over the offset windows near 1 — so the from-above six-door is shut on both our own certificate and the literature's. | `tools/celllat.py` (M43 suite: `ball43`, `hnf_colour`, `skew_sweep`, `m43_census`, `transfers43`, `band_of`/`canonical_T`), `build/m43-finetail.json`, `plans/M43-fine-tail.md` §R | M43 |

| 41 | **The limit lemma, and the first explicit points on the ν curve** (M44). **Kernel** (`Limit.lean`, `Instances/LimitSpec.lean`, axioms exactly the standard three): a finite graph drawable inside one fixed **compact** region with every edge's length within `ε` of 1, **for every `ε > 0`**, can be drawn there with edges of length exactly 1 (`exists_unitDistance_drawing_of_approx`), so it forces the space's unit-distance chromatic number — and in the form the measurement consumes, **the graph may DIFFER at each tolerance** and only its vertex count is fixed (`add_one_le_chromaticNumber_unitDistance_of_bounded_family`, by pigeonhole over the finitely many graphs on `Fin N`), with the plane instance `seven_le_chromaticNumber_plane_of_bounded_family`. Stated for `[MetricSpace V]`, not ℂ, because compactness is all the argument uses. Attribution: the compactness argument is one any specialist would produce and no novelty is claimed for it; ours is the formalization and the programme it licenses. Three models ship with it because the statement is a `∀ ε` — an exact one, a genuinely approximate one, and a **red that is a proven theorem** (`collapsed_drawing_satisfies_one_tolerance`: at a single tolerance the hypothesis is free for ANY graph — collapse every vertex to one point — so a single-`ε` version would prove `χ(ℝ²) ≥ k+1` for every `k`). **Tools**: the **unit-distance defect** meter (`tools/embed.py` — least over drawings of the max edge-length deviation from 1; zero iff the graph is a unit-distance graph; the programme's first CONTINUOUS distance-to-target gauge, every previous meter being binary and flat), reporting bounds **certified in exact rational arithmetic** on a stored rational drawing and re-checked by independent code (`tools/verify_defect.py`, sharing no code, deciding `|√q − 1| ≤ c ⟺ (1−c)² ≤ q ≤ (1+c)²` with no square root at all; planted corruption caught on 21 edges). **The curve**: `ν(0.2792) ≤ 23`, `ν(0.2291) ≤ 66`, `ν(0.1706) ≤ 117`, `ν(0.1494) ≤ 160` — the first explicit points anywhere, upper bounds only, growing as `ε^(−2.9)`. **The minimal refuting ball is physically scale-invariant**: `R*` derived by exhaustive parallel scan (not chosen), physical radius **1.02–1.38 unit distances** across a 3.16× span of scale, all five bands decided minimal. | `Proofs/HadwigerNelson/Limit.lean`, `Instances/LimitSpec.lean`, `tools/{embed,verify_defect,m44}.py`, `build/m44-{dial,interval}.json`, `plans/M44-epsilon-dial.md` §R | M44 |

| 42 | **The arity floor, and the correction it found** (M45). **Kernel** (`Arity.lean`, `Instances/AritySpec.lean`, axioms exactly the standard three): a **compulsion** is a *partial colouring that does not extend* — `m` distinct vertices, properly coloured among themselves, wearing a pattern no proper `k`-colouring induces — and the **arity floor** `arityFloor G k : ℕ∞` is the least such `m`. Phrased through the repository's existing `Pattern.SamePattern`, so it **contains** the four neighbouring notions rather than becoming a fifth: `compels_two_eq`/`compels_two_ne` say arity 2 *is* `Separated`/`Forces`, with `Separated.compels`/`Forces.compels` the constructors a caller travels; `Fan` is a disjunction of compulsions; M20's `no_mono_outer_triple` was an arity-3 compulsion all along. Two things fall out free: **`arityFloor G k = 0 ↔ ¬ G.Colorable k`** — the base-satisfiability guard every instrument carries by hand, here a *value* rather than a side condition — and **`arityFloor_le_of_degree`: the floor is at most `k`, unconditionally**, because `k` distinct neighbours can never be rainbow. That last one is the milestone's transferable sentence: *every object this repository holds has minimum degree far above its colour count, so four campaigns of pair meters reading zero were asking below a bound that was always available.* `realizes_iff_extends` (palette-free ⟺ naive extension, via `Equiv.extendSubtype`) makes the campaign's two encodings provably the same query. Spec: the smallest graph whose first compulsion is at arity 3 — 5 vertices, 5 edges, 3 colours, a 4-cycle with a pendant — with `arityFloor = 3` proved both ways, the lower direction routed entirely through the public API, and the positive instance *is* `compels_rainbow_of_neighbors` applied verbatim; plus a planted negative (`⊤`) and the vacuity self-report (`0`). **Tools**: `tools/arity.py`, whose verdict function structurally refuses the three misreadings — it returns `undetermined-subtuples` rather than a verdict when the 2-subset evidence is missing, its enum contains no "clean" so a cap can never read as a negative, and stages carry edge-list **fingerprints** so "same object?" is a comparison. **The measurement, which corrected a minted grokking**: on M43's own stage its six anchored asks reproduce exactly (6 realizable), and the same stage carries **7 virtual edges** at offset norms 27/28/31 — **triple-encoded**, controls green, 7.5–15 s each; the critical stage (core minus one vertex) carries **51** over a complete 9,636-pair sweep. Coverage primary, criticality secondary; **G28's "zero virtual edges at k = 6" refuted on the stage that produced it.** | `Proofs/HadwigerNelson/Arity.lean`, `Instances/AritySpec.lean`, `tools/{arity,m45}.py`, `plans/M45-arity-floor.md` §R | M45 |

| 36 | **The scale is not monotone, and the classical one is a local optimum** (M39; ω-values and the §0e shell-exhaustion claim corrected at M40 — see row 37): `Coset.eight_le_card_of_cell_constant` and `Coset.seven_le_card_fine` — for `1/2 < p < 3/5` any colouring constant on the triangular lattice's cells needs at least EIGHT colours, via an 8-clique of the constraint graph (the `3 × 3` address block minus a corner, pairwise norms `{1,3,4,7}`), and at least SEVEN again for `3/8 < p < 2/5` via the `√3`-scaled copy of the shell (the index-3 sublattice, pairwise norms `{3,9,12}`) — so the shell reappears at every scaled copy of the lattice and the oscillation seven → eight → seven is kernel-checked at three windows. Since the classical seven-colouring lives at `p ∈ (0.671, 0.866]`, **shrinking the cells past the classical scale costs a colour** — refining is not a route to six. Tools-side (`tools/celllat.py`, exact rational edge criterion, necessary AND sufficient, green control reproducing M38): the clique census across scales (7 → 8 → 7 → 4 → 3 → 2), no six-colouring at twelve scales on tori to 24 × 24 (period-bounded), a seven-colouring at `p = 6/13` below the classical window on three tori, `k = 8` also refusing in the bad band (so ≥ 9 at those periods), the `k = 4` mass red green throughout, and the torus-size control that retracted a tempting reading — the fine-scale refusals are period-bounded and the 24 × 24 row is UNKNOWN at cap. | `Coset.lean`, `tools/celllat.py`, `build/m39-*.json`, `plans/M39-constraint-graph.md` §R | M39 |

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

*(M35 CLOSED 2026-08-11 — both phases returned honest verdicts: no k = 5
class compulsion exists on today's objects, and the upper-bound machine is
built with χ ≤ 9 as its first certified instance. The ranking below is the
close's recommendation; Kooshi picks.)*

*(M36 CLOSED 2026-08-11 — χ(ℝ²) ≤ 7 landed in the kernel, and NOT by the
route the stub registered: the hexagon module was superseded before it was
written by a one-comparison sharpening of M35's own brick certificate. The
classical interval 5 ≤ χ(ℝ²) ≤ 7 is now kernel-checked at both ends. G20 is
demoted with its refutation recorded; G21 is minted. The ranking below is the
close's recommendation; Kooshi picks.)*

*(M37 CLOSED 2026-08-12, under the autonomy authorization — the coset
chromatic number of the plane is exactly seven, so no lattice colouring can
witness χ ≤ 6; G22 minted.)*

*(M40 CLOSED 2026-08-12, on Kooshi's "look for anything suspiciously organized" and
his go for subplanning + implementation. The re-rank below reflects his stated aim —
back into the push to 6, from either direction — with M41 stubbed at his direction.)*

*(M41 CLOSED 2026-08-12, same day it was subplanned — laptop, all cores. The
harvest is ledger row 38 / G26 / G27; every registered probe answered, jackpot
never fired, flat clause banked. The alternation now points above.)*

*(M42 CLOSED 2026-08-12, the same day again — laptop. The gap atlas's four
headline pieces are kernel theorems: ledger row 39; G24 promoted in its
forcing half. The certificate template for any fine-tail refutation is now
built and measured — an LRAT chain at any k, minutes end to end — which is
exactly what path 1 consumes.)*

*(M43 CLOSED 2026-08-12, the same day again — laptop, 12 cores. The 1/7 flanks are
χ = 7 exactly, the fine tail is floored ≥ 7 wherever a verdict landed, the forcing is
measured NOT to factor (G28 minted, G26 demoted to its objects), and the literature
check found the from-above direction closed by a proven theorem. **The from-above route
is finished as a source of new mathematics** — that is the ranking's headline, and the
alternation now points, without a counterweight, below.)*

*(RE-RANKED 2026-08-13, on Kooshi's "go over everything; what pattern caused it; what path
haven't we considered" — no milestone closed, no result landed, and the Frontier's
state-of-the-art narrative and ledger above are UNCHANGED. What changed is the reading of
what we already hold. **M43 retired the cell family after evaluating it as a DOOR (can a
six-colouring walk through? no, provably not). It is also a DIAL, and nobody turned it.**
A colouring constant on cells of scale p forbids not the single distance 1 but a closed
INTERVAL around 1 whose width shrinks with p — M43's own bridge to Voronov — so the family
is a one-parameter deformation whose far end is the classical seven-colouring and whose
LIMIT, as the cells shrink to points and the constancy constraint evaporates, is the
unit-distance problem itself. The answer is seven at every setting of the dial; it may be
five or six only exactly at the limit. That reframes the open problem as a discontinuity at
the endpoint of a function known constant on the whole open ray, and it comes with a
derivable bridge and a measurable quantity — G29, minted below. Kooshi's standing correction
to the methodological entry is folded into G30: measurement is where the patterns come from;
the failure mode is promoting an inductive reading, not making the measurement.)*

*(M44 CLOSED 2026-08-13 — desktop. The limit lemma is kernel-checked (ledger row 41), G29 is
promoted in its lemma half, and the dial's first turn produced a NEGATIVE that the framing made
askable: the cell family cannot supply a bounded-size family either, because its witnesses'
defect and size are locked to one parameter and pull opposite ways. **The family is closed in
both directions now** — no six-colouring (M43) and no seven-forcing witness (M44). Four of six
registered predictions met, two missed and reported as missed. The ranking below is re-ordered
on that close; M45 goes to the front.)*

*(M45 LANDED ITS DECISIVE PART 2026-08-13 — desktop, same day as M44. The arity floor is
kernel-checked (ledger row 42) and the campaign refuted G28's pair-mediated half **on the stage that
produced it**, with M43's own six asks reproducing exactly beside seven triple-encoded compulsions
the six never reached. G21 gains its second instance and its general form: a sweep's negative is a
statement about its enumeration. Three of the milestone's phases are NOT run and are listed as
path 2. The re-rank below is forced by the finding rather than chosen: the identical
too-few-questions shape sits, unexamined, on the one question this project exists to answer.)*

1. **M48 — the complete √3/2 virtual-edge sweep at five colours** (`plans/M48-sqrt3-complete-sweep.md`) — **RECOMMENDED NEXT, and it is
   the direct route to χ(ℝ²) ≥ 6.** This is what M45's finding demands, and the case is arithmetic
   rather than intuition. G26's reduction says a **single** finite unit-distance graph forcing two
   points at distance √3 or 2 to differ in every proper 5-colouring closes χ(ℝ²) ≥ 6 — the rest of
   that composition is already kernel-checked. M41 asked exactly that question and reported
   **"0 virtual edges in 40 targeted asks"**. *Forty.* M43's analogous six asks have just been shown
   to miss seven compulsions that were sitting on the same stage and cost eight seconds apiece to
   find. **The same instrument, the same failure mode, one field up, on the question the whole
   project exists to answer.** The sweep is targeted but *complete*: only pairs at exactly √3 or 2
   matter, so the population is thousands rather than the million all pairs would be, and
   observe-then-confirm (M45's design, measured: 400 harvested colourings cut 9,636 pairs to 811
   candidates in 2.4 s) makes it affordable on the witnesses and both closure generations. Failure
   clause up front: a flat *complete* sweep is a genuinely different and much stronger statement
   than a flat sample, and it would be worth having. A hit is χ(ℝ²) ≥ 6 and everything stops.
2. **M45's unrun phases** (`plans/M45-arity-floor.md` §R7) — the exhaustive arity ladder on the
   kernel-certified 23-vertex core, the fan-shrink upper bracket (which would turn `arityFloor ≤ k`
   into a measured number), the randomized-order re-shrink that decides whether orbit concentration
   is real or procedural, and double-encoding the remaining 44 pair compulsions. All designed, all
   cheap, none run. Ranked below path 1 only because path 1 aims at the target and this does not.
3. **The from-below gadget hunt** (`plans/M44-from-below-gadget.md`) — unchanged in substance;
   still the only route to χ(ℝ²) ≥ 6, still carrying M44's two corrections (the registered target
   is stronger than the theorem needs; the hetero-dimer effort curve is the probe with a dial).
   **M44 adds a scoring instrument it did not have**: any candidate object now gets a defect
   number, so "how close is this to being a unit-distance graph" is a measurement rather than a
   question — and `tools/verify_defect.py` makes the answer independently checkable.
4. **M46 — the description instrument** (`plans/M46-colouring-automaton.md`) — unchanged.
5. **M47 — the three-distance plane** (`plans/M47-multidistance.md`) — unchanged; blocking
   literature gate first.
6. **The ε-dial's unrun tail** (`plans/M44-epsilon-dial.md` §R8) — the ladder below `p ≈ 0.109`
   was NOT run and is reported as not run. Given M44's own finding it cannot change the verdict
   on the family: it would add points to a curve whose slope is established and whose source is
   closed. Low value, explicitly not recommended.
7. **~~M44 — the ε-dial~~ — CLOSED 2026-08-13** (`plans/M44-epsilon-dial.md` §R). Ledger row
   41; G29 promoted in its lemma half. Kept here, not deleted, because the *stub's* prediction
   is worth remembering against the outcome: it read the recorded cores as showing a physical
   radius pinned near 1.3–1.7 and flagged that as an anthology needing a comparability phase.
   The comparability phase ran, with the ball radius derived rather than chosen, and the
   invariance **survived** at 1.02–1.38 across a 3.16× span of scale.
8. **The certified union** (`plans/M35-certified-union.md`) — parked: consolidation with
   bounded novelty; reopens on a find or the write-up trigger's "maybe" clause.
9. **The certification programme** — standing fallback unchanged
   (`plans/M33-witness-closure.md`).
10. **The 1/7 core's kernel certificate** — priced and DECLINED at M43 (M06-scale, ~10⁷ LRAT
   lines for a statement conditionally implied by published work). The M42 template stays
   proven and ready for a target that earns it; this is not one. Reopens only if the
   certificate machinery itself becomes the product, or if M46 §4 finds that an automaton
   emptiness certificate is a different and cheaper price.
11. **Carried forward unchanged** — the hexagon cell module stays priced and unneeded (M36
    superseded it before it was written); the instrument audit stays parked. The line an older
    ranking carried — *"the cell family is closed as a research direction: further scales cost
    solver time and cannot produce a six"* — is now **fully vindicated in substance and was
    still wrong in its reasoning**: the family is closed, but M44 showed the second half of the
    closure (no bounded-size family, hence no seven-forcing witness either) was a question
    nobody had asked, and asking it needed the dial framing rather than the door framing.

### The open structural question (minted 2026-08-11, the M34 close discussion)

> **Is a pigeonhole necessary?** Every known χ ≥ 5 argument factors as
> pigeonhole × kill (G15, constructive half now measured) — but must
> EVERY 6-forcer carry a class pigeonhole from an ENUMERABLE family?
> Today's only necessity theorem is A1 (a vertex-critical 6-forcer fires
> the fan class at k = 5 at every vertex — kernel, colour-generic), and
> there the statement is vacuous at the top rung: "no fan-pigeonhole
> anywhere" merely restates the upper bound. The useful form — a SMALL,
> EARLY compulsion from a family a sweep can enumerate, forced on every
> 6-forcer — is open, is exactly G15's universality half, and is the
> missing piece that would turn M35's classification map into a proof
> route for χ(ℝ²) ≤ 5 (which may of course be false — nothing known
> excludes χ = 6 or 7). What would move it: a necessity proof for ANY
> enumerable family below the fan; or a 6-forcer-candidate anatomy
> violating the factorization. The M33 enumeration subtlety stands as a
> warning: the fan compulsion A1 guarantees lives on a circle about a
> DELETED vertex — a class family enumerated over present vertices
> misses it.
4. **The designed-forcer thread — reopened in spirit by the union** (M34
   built the first designed 5-chromatic object — by composition, not by
   stacking; M32's flat verdict on width-without-degree stands).
5. **The forced-symmetry thread** — folded into the mechanism hunt's phase 2
   as its positive control (the 791's forced central symmetry is an
   already-measured class-level compulsion), no longer a separate item.
6. **Parked, with reasons** (banners in each stub): the tiled plane (M27 —
   expected another 4; its periodic-table SAT probe stays registered-but-not-run
   and reopens the milestone only if it REFUSES), the recursion (M28 — gated
   behind M27), the uncountable pair (M29 — compactness reduces it to the finite
   hunt M30+ pursues in the right field; the residual phase-uniform-colouring
   theorem is another 4-result). Also parked as before: the gap-distance gadget
   hunt (clamp-directed), general-radius two-circle colouring, fractional route,
   measurable-≥6, axiom sensitivity, the `opus-larp` re-validation. Write-ups
   and upstreaming: deferred per standing policy — noting the ledger now holds
   a completed trilogy plus the field-wall thesis, which is the strongest
   write-up candidate so far; the trigger stays Kooshi's. **At that trigger,
   adopt the zeta-23 artifact shape (Kooshi, 2026-08-10): a tiny trusted
   `comparator/` surface (ChallengeDeps + Challenge statements with sorry)
   over the whole edifice as untrusted Solution, verified by
   `leanprover/comparator` (statement AST-equivalence + axiom whitelist +
   kernel replay; its optional nanoda run can serve as the deferred
   independent-kernel publication gate).**

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
  M34's union question. **TESTED at M34, and the constructive half is
  [measured]**: the 9-core pigeonhole (kernel) × six 791-forcer kill
  chains composed to a 4,749-vertex χ ≥ 5 union, confirmed through
  kernel-covered cubes — pigeonhole × kill DOES assemble to a 5-forcer,
  by design, from measured parts. What remains [reading] is only the
  universality direction (that every χ ≥ 5 argument must factor this
  way).*

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
  witnessed, both encodings agree. The √3-pair sibling in the 1581
  concentrates all the way to NINE vertices (two √3-triangles + unit
  circumcentres + hub + one edge, hand-proved) — pigeonholes are cheap;
  the kills (virtual-edge gadgets, ~740 vertices each in Haugland's G₁)
  are the construction's entire cost. **[measured: build/m33-*.json, the
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
  ρ₁₅) is the cross-fabric test, unrun. AMENDED at M34: both carriers
  are now **[kernel]** (`core9_pigeonhole`, `core122_pigeonhole`, with
  plane corollaries and kernel-complete pair lists), and the gadget
  anatomy sharpened twice — the **organizing-distance law** (a mono-d
  class concentrates iff its equilateral d-triangle has UNIT
  circumradius, i.e. d/√3 = 1 ⟺ d = √3: the unique pair class whose
  triangles buy a common unit neighbour — why the √3 core is 9 and the
  d2 core is 122), and the **transmuter link** (inside the 9-core, the
  forced colour transfer hub = rim crosses plane distance exactly 2 —
  the √3 pigeonhole MANUFACTURES forced-equal d = 2 pairs; the two
  pigeonholes are one mechanism seen at two arities).*
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
* **G18 — Composition sees what search cannot** (M34, the union
  measurement): the 4,749-vertex union (9-core pigeonhole × six
  791-forcer kill chains) is χ ≥ 5 by a one-page composition — and
  monolithic CDCL, handed the whole formula, CAPPED at 3600 s, while
  the six cubes covered by the KERNEL pigeonhole each refuted in
  ~800 s. Clause learning does not discover a disjunctive factoring;
  handing the solver the factoring (cubes = the pigeonhole's cases) is
  the difference between unknown and done. **[measured]** *Consequences:
  A5's no-monolithic-SAT architecture is not a preference but a
  necessity at composed scale — certify components, compose in the
  kernel; and the palette factor (6.5× on the union cubes, 35× on the
  122 CNF, re-measured) says pinned formulas + kernel-side symmetry
  closure (the Gadget layer) are the standing shape for every future
  certificate. Falsifier: a solver config that cracks the monolithic
  union in minutes — then this is a tuning anecdote, not a law.*

* **G19 — The 6-hunt's missing ingredient is 5-tight fabric.** M35's
  sweep — the first class-level k = 5 measurement anywhere — read CLEAN at
  every (object, class, radius): no pattern class is compelled at five
  colours on any witness, closure chunk, fabric stage, or lattice ball we
  hold; fan rows sit at min-cover 2 of 5. The k = 4 story had tight fabric
  everywhere because the seam fabric IS exactly-4-chromatic material
  (M33's pigeonholes fired on it); the k = 5 analogue — regions whose
  5-colour space is tight enough to carry a class compulsion — does not
  exist in today's inventory: **the 6-hunt's Act One has no stage until
  someone builds 5-tight fabric**, and composition of 5-forcers (the M34
  union genre) is the only known constructive route. The corrected
  two-sided semantics stand with it (M35 §0a C1): an avoider at k rules a
  mechanism out AT k only — the k = 5 avoider hunt IS the open
  upper-bound hunt (any find proves χ(ℝ²) ≤ 5), and k = 6 avoiders bound
  seven-forcers, not six. **[measured: build/m35-sweep.json; the
  instrument is standing and k-generic]** *Falsifier: any object whose
  k = 5 class sweep fires — the sweep-halt rule is armed in the campaign
  driver.*
* **G20 — DEMOTED at M36; what it measured survives, what it read was
  false.** As minted (M35): row-aligned brick colourings cannot 7- or
  8-colour the plane at any probed shape — ~2,800 registered rows, mass
  red green throughout — so interlock is load-bearing and the hexagonal
  tiles' overlap in y is the mechanism. **The rows stand exactly as
  measured. The reading is refuted**: `Instances/Seven.lean` is a
  row-aligned brick 7-colouring of the plane, kernel-checked (M36). The
  refusals were produced by two coupled choices, each registered in
  advance and each reasonable at the time — a certificate demanding
  STRICT separation (`q < lo ∨ hi < q`), which is one comparison stronger
  than soundness needs for half-open cells, and a grid filtered to
  `diag² < 1`, which is exactly the condition that strict rule needed.
  The brick seven-colouring is boundary-tight by force (cell diagonal
  exactly 1), so it was excluded twice over. Neither choice was a bug and
  the arithmetic was never wrong; the inference from "our test refused"
  to "the family cannot" was the error. **[measured, reading refuted:
  build/m36-periodic.json — the same family, corrected check, k = 7 SAT
  including the kernel-certified row]** *What survives as fact: no brick
  colouring passes a POSITIVE-MARGIN certificate at seven, because none
  exists — every member of the family is boundary-tight. And the family
  still cannot reach six: k = 6 refused in 1,394 rows under the corrected
  check.*
* **G22 — Where a six-colouring cannot live.** The upper-bound side of the
  interval now has a map with one region blacked out. Every *lattice*
  colouring — colour by the class of the nearest lattice point, which is what
  the classical seven-colouring is and what every proposed construction has
  been — needs exactly seven colours, no more and no fewer **[kernel: M37]**.
  So the search for `χ(ℝ²) ≤ 6` cannot be a search over lattices, scales, or
  sublattices: it must leave the coset family entirely. What the proof says is
  *why*: the cells cannot be big (their own deep holes make a same-coloured
  pair of diameter `2p/√3`, forcing `4p² ≤ 3`) and the colour classes cannot be
  close (a kernel vector shorter than twice the cell reach is caught by its own
  multiples), and between those two walls the lattice's arithmetic admits
  nothing below norm 7 — because 5 and 6 are not of the form `a²+ab+b²`. **The
  bound is number-theoretic, not geometric**: the same two walls over a
  different lattice give a different threshold (the square lattice needs nine,
  by the same argument with sums of two squares in place of the Loeschian
  numbers). *Reading on top, believed and falsifiable: a six-colouring, if one
  exists, must have colour classes that are not unions of cells of any lattice
  — which is consistent with G20's correction (the brick seven-colouring is
  boundary-tight, and every known witness sits on some crystal), and suggests
  the upper-bound hunt should look at aperiodic or non-cell constructions.
  Falsifier: any six-colouring of the plane whatsoever; short of that, a
  general-lattice proof would extend the blacked-out region from the triangular
  lattice to all of them — the crude chain already gives `k ≥ 6` everywhere and
  the missing piece is the `k = 6` rigidity case.* **SHARPENED at M38**: the
  coset hypothesis is not needed above `p = 1/2`. There the constraint graph's
  first shell is a 7-clique, so *any* cell-constant colouring — arbitrary
  labels — needs seven **[kernel: M38]**. The blacked-out region is therefore
  not "lattice colourings" but "cell-constant colourings at coarse scale", and
  what remains is the FINE regime: a six-colouring must have classes finer than
  half the unit distance in every lattice's cells. *That is a much sharper
  address than G22 first gave, and it coincides with where M36's pixel-brick
  probes ran out of solver: the open region is the same one from two
  independent directions.*
* **G23 — The good scales are isolated, and refining is not a route down.**
  A colouring constant on a lattice's cells is exactly a colouring of that
  lattice's constraint graph, so the whole cell family is one parametrized
  family of graph-colouring problems, indexed by the scale. Measured across
  that parameter, the requirement is **not monotone**: seven in the classical
  window, **eight just below it** (kernel: the 8-clique theorem), seven again
  near `p ≈ 0.46`, with the clique number then collapsing while the graph
  itself grows denser — and the oscillation persists into the fine regime,
  where `p = 1/3` genuinely refuses seven to period 30 while `p = 1/7` admits
  it on a 24 × 24 torus. **[kernel + measured: M39]** *Consequence: the intuition
  "smaller cells approximate the plane better, so they should do at least as
  well" is FALSE — the classical scale is a local optimum and its neighbours
  are strictly worse. Any hunt for a six-colouring in this family must jump to
  isolated good scales rather than refine, and the fine regime (where the tori
  needed to express a colouring outrun the solver) is the only part still
  open. Falsifier: a six-colouring of any `G(p)`, which would be `χ(ℝ²) ≤ 6`;
  short of that, a patch-based refutation would upgrade the period-bounded
  refusals into statements about `χ(G(p))` itself.*
* **G24 — The gap law: below the classical window, seven is forced without cliques,
  and the family is a finite mirror of the plane's own pathology.** (M40.) On every
  band from the classical window down to `p = 0.2236`, plus the `1/6` flanks, the cell
  family needs ≥ 7 colours OUTRIGHT (ball refutations, no periodicity) — while ω
  collapses to 3–5, the certified Hoffman/spectral bound collapses to ≈ 4.1, and the
  fractional relaxation stalls at 48/7 on G\*. The forcing is **integrality, carried by
  small near-symmetric cores** (23 vertices at G\*; 53 at the deep pocket; broken-rot6
  orbit structure — the de Grey 122-core motif reappearing in a different universe).
  And the classical mechanism is provably absent: **no index-7 sublattice coset
  colouring exists below the window** — the sevens there are non-homomorphic, with
  non-uniform classes and trivial stabilizers. So `ω = 3, all relaxations low, χ = 7`
  is not a peculiarity of the continuum plane: the discrete cell family reproduces it
  at every fine scale, in objects the kernel can check whole. **[measured: exact
  arithmetic + exhaustive cliques + SAT — PROMOTED at M42 in its forcing half: the
  12-window, the M = 4 shell window, the coset-impossibility, and χ(G\*) = 7 at ω = 4
  via the 23-core are now kernel theorems (ledger row 39); the deep pocket's χ ≥ 8 and
  the fine-tail ω collapse remain measured-only]**
  *Consequences: the from-above six-hunt now has a concrete, ranked target list — the
  open scales start at `p = 1/7` (ω = 3, six undecided to period 36, balls to 225
  six-colour) and everything below `p = 0.2236` except the 1/6 flanks; and the
  23-vertex G\* core is the smallest known carrier of a "χ > ω + 2" forcing in this
  family — the right first object for a mechanism theory of clique-free forcing, the
  same question the plane's χ ≥ 5 poses at k = 4. Falsifiers: a six-colouring of any
  band (χ(ℝ²) ≤ 6, the standing jackpot clause); or a relaxation that DOES see the
  gap — any polynomial certificate matching the ball refutations would be a new
  lower-bound instrument for the whole programme.*
  **EXTENDED and CONDITIONALLY EXPLAINED at M43**: the ≥ 7 floor now runs unbroken from
  the classical window to `p ≈ 0.109` wherever a verdict landed (19 further bands
  outright; **χ = 7 exactly at both 1/7 flanks**, the last undecided scale), the Hoffman
  collapse deepens to 3.56 at 1/7 — and the mechanism has an external explanation:
  **conditional on Voronov's proof of the Exoo conjecture (arXiv:2304.10163 — ≥ 7 colours
  for every forbidden-distance interval `[1−ε, 1+ε]`, any ε > 0), χ(G(p)) ≥ 7 for the
  ENTIRE family at every scale.** The derivation is two lines: a six-colouring of `G(p)`
  with `p < √3/2` would be a plane colouring avoiding a whole closed interval around 1
  (intra-cell distances stay below 1; the finitely many cross-cell offset windows near 1
  are closed sets missing 1, so a positive gap exists), which that theorem forbids. So the
  band-by-band sevens are not a coincidence of scales but a shadow of an interval theorem —
  and by de Bruijn–Erdős compactness EVERY band owns a finite refuting ball, making our
  refutations certificates of a guaranteed fact rather than discoveries of a contingent one.
  *The conditionality is real and stays flagged: [Vor2023] is an external preprint this
  project has not verified. The unconditional content remains ours, band by band.*
* **G28 — REFUTED IN ITS PAIR-MEDIATED HALF at M45 (2026-08-13); what it measured was a
  six-element acceptance set, not the object.** The re-measurement, on **the identical stage**
  (the R = 8 ball, 241 vertices, fingerprint `9d9599be0db64677`): M43's own six anchored asks
  **reproduce exactly** — 6 realizable, 0 compelled — and that same stage carries **seven virtual
  edges** at offset norms **27, 28, 31**, classes the six-ask sweep never touched. Each is decided
  in **7.5–15 s** and **each is confirmed in three independent encodings** (forward-order breaking,
  reversed-order breaking, colour-pinned with no breaking) with every control green, so this was
  never a solver-budget question — the questions were not asked. On the *critical* stage (the
  1-minimal core less its highest-degree vertex, one vertex short of refusing) the **complete**
  sweep of all 9,636 non-adjacent pairs finds **51** virtual edges, 0 forced pairs, 11 undecided at
  cap. Coverage is the primary effect (six asks against thousands); stage criticality is secondary
  (51 against 7 on identical pairs). **So Act Two DOES exist at the fine tail**, "the forcing does
  not factor as pigeonhole × kill" is withdrawn, and the inference from it — that the compulsion is
  "global over ~160 vertices by exclusion" — loses its support. **[measured: M45, triple-encoded,
  `plans/M45-arity-floor.md` §R1]** *What survives: the counting half of Act One (the closed
  shell's seven addresses at norms {1,3,4} are non-edges at that scale, so six colours force a
  repeat) is untouched, and G26's universality reading — demoted at M43 on G28's strength — should
  now be read as never having had a falsifier here. What killed it is G21, and the entry below is
  the general form.* Original text, kept because a demoted grokking is never deleted:
  **The fine-tail forcing does not factor: pigeonhole × kill is NOT universal.**
  (M43, the 1/7 autopsy; the falsifier G26 registered and never found in five cores.) At
  the coarse 1/7 flank Act One is *free* — the closed shell's seven addresses have all 21
  mutual offsets at norms {1,3,4}, none of them edges at that scale, so six colours force
  a repeat with no argument at all — and **Act Two does not exist**: forcing any such pair
  to share a colour remains satisfiable on 241 vertices, *more material than the
  160-vertex core that refutes six outright*, and the same holds at every small non-edge
  class (norms 1, 3, 4, 7, 9, 12, each decided in under a second). Equivalently there are
  **zero virtual edges at k = 6** on the largest colourable stage — the from-above mirror
  of M41's 0/40 flat verdict from below. **[measured: `build/m43-finetail.json`,
  `kind: factorization-autopsy`; scope — balls centred on the pair up to 241 vertices, the
  six smallest non-edge classes]** *Consequences. (a) G26's universality reading is
  demoted to a statement about the objects it was measured on: five cores factored, the
  sixth does not, and the sixth is the one with the plane's own clique number at the
  finest scale examined. (b) "Integrality-carried" (G24) now has a positive measurement
  behind it rather than an inference from a relaxation gap: the compulsion is not
  pair-mediated at any arity a pair meter can see, so it is global over ~160 vertices by
  exclusion, not by default. (c) The certification consequence is direct and was the
  milestone's practical verdict — no small gadget exists to certify, so the certificate
  cost tracks the whole object (one cube of the split proof logs 63× the entire 122-core
  certificate). Falsifiers: a kill gadget at a class or region not swept — a non-ball
  region, a larger class, or a forced-equality between cells at an EDGE-adjacent
  configuration; or a factorization at a different fine band, which would make 1/7 the
  exception rather than the fine tail's rule.*
* **G25 — The forcing ladder is recursive, and the levels read like protein
  structure.** (2026-08-12; seeded by Kooshi's peer's analogy; the full pass is
  `plans/SHAPES-OF-SIX.md`, the standing shape-space both directions cite.) The
  measured mechanism at each jump: χ ≥ 4 is HOLONOMY of deterministic rainbow-clique
  propagation (at k = ω every triangle is rainbow — zero local entropy — and the
  Moser twist returns the information shifted); χ ≥ 5 is a disjunctive regional
  PIGEONHOLE over exactly-4-with-depth fabric, whose kills are the previous level's
  forcer applied to the forced pair one field up. **Each level's kill is the previous
  level's forcer** — so the default 6-forcer has 5-forcer-grade kills (~10⁵–10⁶
  vertices, certified-composition-only, G18), UNLESS a shortcut shape fires
  (forced-equivariance kills with no new field; or the from-above lab's un-named
  integrality mechanism transplanted). Protein mapping where it is exact: secondary =
  k-rigid motifs (rhombus chains as α-helices), tertiary = one folded witness
  (edge-criticality IS marginal stability, G10), quaternary = the conjectured
  6-forcer as a DETUNED OLIGOMER of 5-chromatic domains whose compulsion lives in
  interface conformation algebra (the M20 strip automaton is the method precedent);
  where it lies: proteins have one energy scale, we have a field ladder (G1).
  **[reading — falsifiers per shape in SHAPES-OF-SIX §3: menus total ⟹ Shape A
  starves; gen-2/3 clean at depth ⟹ Shape B demoted; no equivariance compulsion at
  k = 5 anywhere ⟹ Shape C demoted; the 23-core autopsy finding a known genre ⟹
  Shape D deflates; any of them firing ⟹ the 6-hunt has its Act One.]***
* **G26 — The autopsy dictionary: pigeonhole × kill is 5-for-5 universal in the
  finite lab, and the 6-forcer reduces to one gadget.** (M41 phase 0, 2026-08-12.)
  Every 1-minimal clique-free forcer core of the cell family (23, 28, 53, 66, 117
  vertices — gap-3 and gap-4, coarse and fine, with and without centres) FACTORS:
  Act One is always a mono pair forced onto a small **non-edge class** (norm 1
  first — the closed hex shell's 7-cells-vs-6-colours counting argument surviving
  the clique's death: the norm-3/4 pairs stay edges, so the forced repeat lands on
  exactly the class that stopped being an edge), and the ambient web kills every
  placement. The fractional relaxation always sits far below the truth:
  χ_f = 130/23 at the 23-core (χ = 7), 501/74 at the 53-core (χ = 8), ≈ 4.83796
  bracket-tight at the 117-core (χ = 7 — **gap 2.16, ratio 1.45, the programme's
  extreme, on the object with the plane's own clique number**). **[measured: exact
  LP certificates verified in rational arithmetic; class-avoidance sweeps with the
  M33 deleted-vertex fan classes in the vocabulary]** *The plane-side consequence,
  sharp: the kernel already holds Act One at five colours
  (`hexShell_pigeonhole` — every 5-colouring of the closed hex shell has a mono
  pair at √3 or 2), so* ***a 6-forcer needs exactly one thing: a finite
  unit-distance graph forcing two points at distance √3 or 2 to receive different
  colours in every proper 5-colouring*** *— nine copies on the shell then close
  χ(ℝ²) ≥ 6 by the M34 composition genre. The from-below hunt is a hunt for that
  single gadget; the m1 virtual-edge meters are its exact detector. Falsifier for
  the reduction: none needed (it is a theorem-shaped composition); falsifier for
  the universality reading: a core that refuses to factor — none found in five.*
* **G27 — The witnesses have hidden arithmetic symmetry, and the Galois orbit mints
  free witnesses.** (M41 phases 4/5, 2026-08-12; every claim an exact computation
  with planted controls.) The half-spindle field tower's Galois group acts on
  witnesses; on de Grey's 1581: **the flip √3,√5,√11 ↦ −√3,−√5,−√11 fixes the
  vertex set identically**, giving a **non-geometric involutive automorphism** τ
  (29 fixed points, 776 two-cycles, maps the 7,877 edges to themselves exactly)
  while the graph has NO nontrivial plane self-isometry; with mirror∘flip[5,7] and
  mirror∘flip[3,7,11] the hidden automorphism group is a **Klein four-group**. The
  orbit has exactly **4 isometry classes: the 1581 + three genuinely new
  5-chromatic witnesses** (W^[3], W^[5], W^[3,5]; W^[5] an isospectral twin —
  centroid spectrum equal, congruence excluded by the exhaustive ring-heart
  argument). **P9: the 791-point forcer IS V ∩ −V** — the centrosymmetric core of
  the witness, exactly — so M30's forced central symmetry is substrate symmetry
  surfacing at criticality; and the witness is **half-crystal** (787 of 1581
  vertices fully rot6-invariant about the origin pivot — the detuned-oligomer
  signature inside one object). Heule-510 has **no √7 content** (it lives in
  ℚ(√3,√5,√11)). Hetero-dimers V ∪ W^σ share up to 1,101 vertices — new composed
  matter. **[measured]** *Readings on top: forced equivariance under NON-geometric
  automorphisms is a compulsion vocabulary nobody had (built, controlled, not
  forced on today's floppy objects — re-ask wherever m1 structure ever appears);
  and the only nonzero k = 5 reading of the whole campaign is the dimers' 10×
  solver-effort excess (single-sample, signal not claim). Falsifiers: an explicit
  isometry between W and any [3]-coset conjugate (would collapse the free-witness
  count); a second-sample effort measurement reading flat.*
* **G21 — A search run against a sufficient-but-not-necessary check
  measures the check, not the world.** The general form of G20's death,
  and the reason it is minted rather than left as a footnote: this
  project runs registered searches constantly, and every one of them
  inherits the sharpness of its acceptance criterion. When a sweep
  refuses, the first question is not "what does this say about the
  objects" but "is my acceptance test the exact condition, or a
  sufficient one?" — because a conservative test converts a *finding*
  into a *measurement of my own instrument*, silently and with the
  registered-prediction discipline fully satisfied. M35's phase 2 was
  registered, controlled, mass-red-guarded, honestly reported, and its
  negative measured a comparison operator. **[measured: the M35 → M36
  pair, where the identical grid returns different verdicts under a
  criterion changed from sufficient to exact]** *Consequences already
  applied: `tools/periodic.py`'s schema line now states which caveat
  survives (the shape grid) and which is gone (the certificate); the
  standing rule for every future sweep is to state, at registration,
  whether its acceptance test is necessary as well as sufficient — and
  if it is only sufficient, to say what a refusal therefore cannot mean.
  Falsifier: none needed — this is a methodological invariant, and it
  fails only by being ignored.*
  **SECOND INSTANCE, and it cost a grokking (M45, 2026-08-13).** The rule generalizes from the
  acceptance *test* to the acceptance *set*. M43 asked six questions — one per class, each anchored
  at the origin — and wrote the answer as "zero virtual edges at k = 6", a statement about the
  object. The artifact's scope line was honest (*"six smallest classes"*); the summary sentence was
  not, and the summary is what became G28. Re-asked as 9,636 questions **on the same stage**, the
  object has seven, at classes the six never reached. **The generalized rule: a sweep's negative is
  a statement about its enumeration, and the enumeration belongs in the same breath as the verdict
  — in the headline, not only in the scope line.** Two design consequences now built into
  `tools/arity.py`: a verdict function that returns `undetermined-subtuples` rather than any verdict
  when the evidence that would qualify it is missing, and a verdict enum containing no word that
  means "clean" at all.
* **G29 — The cell family is not a door, it is a dial, and the open problem is the
  discontinuity at its endpoint.** (Minted 2026-08-13, on a re-reading of M39–M43 with no
  new measurement.) A colouring constant on the cells of a triangular grid at scale `p`
  forbids not the single distance 1 but a closed INTERVAL around 1, of half-width `δ(p) > 0`
  that shrinks with `p` — this is exactly M43's own bridge to Voronov, with the width made
  explicit and computable (`δ(p) = min dist(1, I_v)` over the offset windows `I_v` that miss
  1). So `G(p)` is a **one-parameter deformation**: at the coarse end the classical
  seven-colouring, and as `p → 0` the cells shrink to points, the constancy constraint
  evaporates, and **the limit is the unit-distance problem itself.** Along that whole
  deformation the answer is pinned at SEVEN — proven band by band by us, and (conditional on
  [Vor2023]) at every scale — while every structural invariant collapses underneath it
  (ω 7 → 3, the certified spectral bracket to 3.56, the fractional bound stalling below 5).
  Therefore `χ(ℝ²) < 7` is the claim that a function known constant on an entire open ray is
  **discontinuous exactly at the endpoint**, and all the information about the plane's own
  answer lives in the approach. The quantitative handle, derived and not yet measured: let
  `N(p)` be the size of a vertex-critical non-6-colourable subgraph of `G(p)`. **If `N(p)`
  stays bounded along any sequence `p → 0` then `χ(ℝ²) ≥ 7`** — take cell centres, pass to a
  subsequence (a critical graph is connected with min degree ≥ 6, so bounded count gives
  bounded diameter for free), every edge's length is `1 ± O(p) → 1`, and any two indices that
  collide in the limit were non-adjacent so the limit is a contraction, which cannot LOWER
  the chromatic number. Contrapositive: **the divergence of `N(p)` is a necessary condition
  for `χ(ℝ²) ≤ 6`** — the exact quantitative obstruction between the proven interval theorem
  and the open point theorem. **[PROMOTED at M44: the limit lemma is now **[kernel]** —
  `add_one_le_chromaticNumber_unitDistance_of_bounded_family`, on axioms exactly the standard
  three — and the dial has been turned. The deformation and the pinning stay **[measured]**
  (M39–M43).]** **AND THE DIAL'S FIRST TURN CLOSED THE FAMILY IN ITS SECOND DIRECTION.** The
  measurement: each certified core's unit-distance defect, against its size. The gain over the
  free cell-centre drawing SHRINKS as the cores get finer (1.91× at 23 vertices, 1.13× at 117 and
  160) — the dense fine cores are so over-constrained that the cell-centre drawing is already
  nearly optimal — so within this family the defect is pinned at `≈ 2p/√3 ∝ p` while the size
  grows like `p^(−1.75)`. The two are locked to one parameter and pull opposite ways, so **the
  cell family cannot supply a bounded-size family as `ε → 0` either**, and by the limit lemma it
  cannot yield `χ(ℝ²) ≥ 7` any more than it could yield a six-colouring. *The family is now closed
  in both directions, and the honest epistemic content of the measurement is narrow: `ν` upper
  bounds that grow are consistent with `ν` bounded and with `ν` divergent alike, so the numbers do
  not bear on which of 5, 6, 7 is true. What they give is the first explicit points on `ν`, a
  baseline any future construction must beat, and a sharpened target — a source of
  non-6-colourable graphs whose DEFECT falls faster than their SIZE grows.* One positive
  structural find survived the confound check: with the ball radius DERIVED rather than chosen,
  the minimal refuting configuration is **physically scale-invariant at 1.02–1.38 unit
  distances** across a 3.16× span of scale. *Why it was missed: M43 evaluated the family on one criterion — can a
  six-colouring live here? — got a clean and correct no, and retired the instrument without
  asking what the PARAMETER was doing. The Voronov connection, treated at that close as the
  direction's tombstone, is what makes the dial meaningful: it is the statement that the
  function is constant on the ray. Falsifiers: the limit lemma failing on careful writing
  (most likely at the collision/contraction step); or `N(p)` proving to be dominated by
  shrink quality rather than by mathematics, which is G21 and which is why the milestone's
  comparability phase runs before its ladder.*
* **G30 — Measurement generates; induction kills. The failure is never the measuring — it
  is promoting an inductive reading without a derivation or a registered replication behind
  it.** (Minted 2026-08-13, from sorting the whole record by how each claim was reached;
  stated in this form on Kooshi's correction, which is the load-bearing half: *"the
  interesting patterns that become intuited and derived show up first from measurement, so
  it's a catch-22."*) Sorted by provenance, the record is close to a clean dichotomy.
  **Derived from structure first, then measured — survived, every one**, several becoming
  kernel theorems: the quadrature law (26 exact censuses, zero violations), the stacking law,
  the criticality factorization A1, M36's boundary-tight sharpening (worked by hand in §0a
  before any code), M42's exact-hexagon reach whose corner values ARE the band boundaries,
  M25's `√3·ζ₁₂ = 1+ζ₆`, G26's reduction. **Measured first, then interpreted — died, every
  one**, mostly refuted by our own later work: the seam-alignment kill mechanism (0/4 on
  registered replication), the concentration bet, the coset census, the triple-kill
  population (provably empty), G20's brick-interlock reading (refuted by our own M36
  theorem), G26's universality (refuted by G28), M39's "finer is worse", M39 §0e's
  shell-exhaustion claim, M43's P8 core-shape prediction, M31's P6 band prediction.
  Roughly 7-for-7 against 0-for-10. **[measured: the project's own record]** *The rule this
  yields is NOT "measure less" — every derivation above began life as a pattern somebody
  noticed in a measurement, and the quadrature and stacking laws were derived precisely
  because earlier censuses had shown where to look. The rule is about what a measurement
  BUYS: it buys a candidate pattern, never a conclusion, and the conclusion is bought
  separately by a derivation or by a pre-registered replication on fresh objects. Two design
  consequences already applied: prefer measurements that turn a DIAL (a parameter whose
  behaviour is informative in both directions — G29's ladder, the hetero-dimer effort curve
  against overlap) over searches that hunt for a POSITIVE (whose null result is
  uninterpretable and has now come back flat four times); and prefer CALIBRATED test beds —
  ask the new question on an object whose answer is already certified, so a zero reading
  bounds the instrument instead of being mistaken for a fact about the world
  (`plans/M45-arity-floor.md` is that pattern made into a milestone). Falsifier: none needed;
  like G21 this is a methodological invariant and it fails only by being ignored — but the
  tally is falsifiable and should be re-sorted at every tenth milestone.*

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
