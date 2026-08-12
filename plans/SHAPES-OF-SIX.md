# The Shapes of Six — the standing shape-space for a χ(ℝ²) ≥ 6 witness

*A domain-modeling pass (2026-08-12, on Kooshi's direction, seeded by his peer's
protein-folding analogy) over everything both directions of the hunt have measured.
This is a STANDING DOCUMENT, not a milestone: the from-below stubs (M41+) and the
from-above campaigns cite it; a shape that loses its kill test is demoted here with
its refutation recorded, never deleted. Epistemic discipline as in § Grokkings:
[kernel] / [measured] / [reading], every reading with its falsifier named.*

---

## 1. The ladder, characterized intrinsically (what actually jumps at each jump)

Strip the history and state each forcing level by its mechanism. Every χ ≥ k+1
argument we hold or know of factors as SUBSTRATE (material whose k-colouring space is
understood) × COMPULSION (a property every k-colouring of the substrate has) × KILL
(gadgetry refuting each realization) × CLOSURE (the finite composition). What varies
down the ladder:

**χ ≥ 4 (Moser; k = 3).** At k = ω = 3 every triangle is RAINBOW, so triangulated
material transmits colour information losslessly: the rhombus (two triangles on a
shared edge) forces its tips EQUAL — deterministic propagation, zero local entropy.
The forcer is a *holonomy* argument: run two rigid propagation channels around a loop
whose twist returns the information shifted (ρ = ζ₆³σ⁻² — inside the seam field,
[kernel: FieldWall]). Substrate = single cliques; compulsion = deterministic
(zero-freedom); kill = the twist; closure = one loop, 7 vertices.

**χ ≥ 5 (de Grey; k = 4).** The 4th colour gives every triangle slack — deterministic
propagation DIES. What replaces it [measured, M33/M34]: over exactly-4-chromatic seam
fabric with DEPTH ≥ 2, every 4-colouring places a mono-√3 or mono-d2 pair SOMEWHERE —
a disjunctive, region-level pigeonhole (nothing forced anywhere in particular; the
total freedom is insufficient globally). Each placement is then killed by a spindle —
which is exactly the LEVEL-BELOW forcer applied to the forced pair, one field up
(√15). Substrate = one folded fabric region (its tightness = being exactly-4 with
depth); compulsion = disjunctive pair-class; kill = 3→4-style holonomy at the forced
distance; closure = the whole witness (distributed, edge-critical, G10/G17).

**The recursion this exposes [reading, load-bearing]:** *each level's KILL is the
previous level's FORCER.* The 3→4 kill (the twist on a forced-equal pair) is the
2→3-level rainbow-clique structure closed in a loop; the 4→5 kill (the ρ₁₅ spindle on
a forced-mono pair) is the 3→4 forcer at a new distance. **So the default expectation
for 5→6: its kills are themselves pigeonhole × kill assemblies — each "virtual edge
at five colours" costs a 5-forcer-grade object.** Haugland's 4→5 kills cost ~740
vertices each; if 5→6 kills cost ~10³–10⁴ and a compulsion needs ~10² placements
killed, the artifact is ~10⁵–10⁶ vertices — buildable ONLY as a certified composition
(G18), never as a monolith. *Falsifier: any kill mechanism cheaper than the recursion
(see Shapes C and D below — both are candidate shortcuts).*

## 2. The protein-folding analogy, tested (where it is exact, where it lies)

The peer's levels map with surprising precision:

| protein level | forcing level | the correspondence |
|---|---|---|
| primary (the chain) | the point set + unit edges | raw material; the field data is the "sequence" |
| secondary (α-helix, β-sheet: local motifs from local bonds) | k = 3-rigid motifs: triangles, rhombus chains (1-D rigid propagation), triangulated patches (2-D sheets) | local constraints fully determine local structure — zero-entropy regions |
| tertiary (one domain's global fold; hydrophobic core; marginal stability) | the 5-forcer: one folded fabric region with long-range spindle contacts; the pigeonhole region is the squeezed core; **edge-criticality = marginal stability** (remove one contact and it unfolds — G10, measured) | the compulsion is a property of ONE domain's whole conformational space |
| quaternary (multi-domain assembly via interfaces; often near-symmetric oligomers) | the CONJECTURED 6-forcer: no single domain is 5-tight (G19, measured — the k = 5 sweep read clean on everything including the witnesses), so the compulsion must live in INTERFACES between assembled 5-chromatic domains | the residual 5-colour freedom of each copy is a "conformation"; interfaces constrain neighbouring conformations; frustration of the assembly is the forcing |

Where the analogy is EXACT and earns its keep: (i) level n is built from level n−1's
products — that is our measured recursion; (ii) marginal stability ↔ criticality at
both measured levels; (iii) quaternary assemblies are near-symmetric — and G7
[measured] says exact symmetry adds NO colour constraint (the copy reuses the base's
pattern) while detuning forces the clash: the quaternary forcer is a **detuned
oligomer**, and M40's broken-rot6 cores show the same signature in the finite lab.

Where it LIES if pushed: proteins minimize soft energies (thermodynamics; one force
scale); colouring is a hard-constraint CSP with a FIELD LADDER (each level's twist has
so far demanded new radicals — G1). The analogy generates hypotheses; the field
arithmetic disposes.

## 3. The shape inventory (each with its kill test; ranked by current credence)

**Shape A — the conformation-automaton forcer (quaternary, operationalized).**
Copies X₁…Xₙ of a 5-chromatic domain at crystal translations with wholesale overlap.
The right objects are not colourings but MENUS: for an interface I (shared point
set), M(X, I) = the set of colourings of I extendable to a proper 5-colouring of X;
for a copy with two interfaces, the RELATION R ⊆ M × M of jointly-extendable pairs.
A union of two copies is 5-colourable iff menus intersect; a cyclic assembly is
5-colourable iff the composed relation has a fixed point. **A closed loop of
translations whose composed relation is EMPTY is a 6-forcer.** The exact precedent is
the M20 strip automaton (864 states, transfer relation, window-extension theorem) —
the method one level up. M21's "coupled automaton is dead" killed the CONTINUOUS-phase
product at k = 4; crystal translations are discrete and commensurate by construction,
so that obstruction does not apply. *Kill tests: (i) the 2-copy tiling's menus
disjoint ⟹ jackpot immediately (χ ≥ 6); (ii) menus/relations too large to enumerate ⟹
retreat to menu MOMENTS (forced pairs, forced-equal pairs, coverage across the
interface — the standing meters, k-generic) and to loop-targeted SAT; (iii) if every
affordable interface yields a TOTAL relation (every conformation pair compatible),
the shape starves and is demoted.* Instrument note: this sharpens M41's tiling probe
from "ask SAT per union" to "measure the interface algebra, then AIM the loop."

**Shape B — the deep-closure forcer (tertiary one level up: 5-tight fabric = depth).**
The k = 4 pigeonhole was INVISIBLE at seam depth B ≤ 1 and fired at B = 2 (Q-i1,
measured) — depth switched it on, not radius. The direct analogue: the k = 5
compulsion is invisible at closure generation ≤ 1 (measured clean, M31/M35) and could
switch on at generation ≥ 2 of the half-spindle closure — 5-tight fabric might exist
as DEPTH, unprobed. This gives M41's gen-2 probe a registered theory reason, not a
blind ask. One measured hint pointing the same way: the d = 2 class at k = 5 was the
solver's HARDEST avoidance everywhere (102 s / 600 s-cap outliers on the witnesses
while every other cell closed in under a second — M35 §R, a solver-effort signal, not
a compulsion). *Kill test: gen-2 (and an affordable gen-3 chunk) class sweep at
k = 5 — clean at real depth demotes the shape; any firing names Act One of the
6-forcer immediately.*

**Shape C — the forced-symmetry forcer (the possible shortcut past the recursion).**
Act One = forced EQUIVARIANCE rather than a forced pattern: every k-colouring of the
substrate commutes with an isometry g on a region (the measured prototype at k = 4:
the 791 forcer's five antipodal pairs — every 4-colouring is centrally symmetric on
the 2/√3 circle, and the classical spindle CANNOT exploit it, √183). Act Two = an
equivariance-breaking gadget: a g-invariant structure admitting no g-equivariant
colouring (parity/odd-orbit obstructions — combinatorial, potentially NO new field:
this is the shape that would break the field-ladder pattern and come in far below the
recursion's cost estimate). *Kill tests: (i) M41's forced-equivariance sweep at k = 5
on composed objects — nothing forced anywhere demotes the shape; (ii) exhibit even
one toy equivariance-breaking gadget in the plane (a design exercise, cheap) — if
none exists at any k, the Act Two half is fantasy and the shape dies.*

**Shape D — the transplanted-integrality forcer (the from-above gift).**
M40's finite lab holds clique-free forcers we can analyze COMPLETELY: the 23-vertex
G\* core forces 7 with ω = 4; the 1/6-flank bands force 7 with ω = 3 — the plane's own
clique number — via integrality (fractional stalls at 48/7), carried by
broken-near-symmetric cores, with the homomorphic mechanism provably absent. Nobody
has NAMED that mechanism. The move: autopsy the 23-core totally (its full colouring
space, its fractional certificate, whether IT factors as pigeonhole × kill — the
golden question G15's universality clause, tested in a decidable universe), extract
the abstract forcing pattern, then hunt unit-distance realizations of the same
pattern at k = 5. *Kill tests: (i) the autopsy finds a known genre in disguise (odd
wheel / Kneser quotient) — value drops to a dictionary entry; (ii) the pattern
provably needs edge densities unit-distance geometry cannot supply — transplant dies;
(iii) if the 23-core does NOT factor as two acts, G15's universality is
counterexampled and THIS document's Shape E widens.*

**Shape E — the null shape (the honest default).** Whatever the mechanism, the
recursion's cost model says the artifact is ~10⁵–10⁶ vertices and exists only as a
certified composition: pigeonhole theorems + transported kill certificates + kernel
assembly (the M34 union architecture at scale). Not a mechanism hypothesis — a
statement that the composition/certification machinery is on the critical path FOR
EVERY SHAPE, which is why the certified-union work is strategic even while parked.

**Explicitly open:** a 6-forcer that is none of these — in particular one violating
the pigeonhole × kill factorization entirely. G15's universality half is [reading];
Shape D's autopsy is the cheapest place a counterexample could surface.

## 4. What the two directions now do for each other (the alternation, sharpened)

The from-above family is the hunt's **model organism**: finite, decidable,
vertex-transitive, exhibiting the exact pathology (χ ≫ ω, all relaxations low,
broken-symmetry cores, no homomorphic colourings) that the plane exhibits at the
5→6 wall — but where every mechanism question CLOSES. The from-below hunt supplies
the substrate question (what is 5-tight fabric?) that the model organism's mechanism
dictionary must eventually answer. Alternation is therefore not just risk-hedging:
each side's next milestone consumes the other's last product. The schedule this
implies: M41 (below: probes for Shapes A/B/C + the Shape-D autopsy as its phase 0)
→ M42 (above: kernel promotion, hardening the lab) → the fine-tail campaign (above:
p = 1/7, plus the mechanism dictionary aimed at it) → M43 (below: whichever shape
survived M41, escalated) — strict alternation, shapes re-ranked at every close in
THIS file.
