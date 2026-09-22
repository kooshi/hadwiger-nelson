# M63 phase H4 — the derivation file: reducing and gauging the `ρ₆₃` arena (FS-71 batch 4d)

*Filed 2026-09-23 by the batch-4d implementer (FS-71, the theorem audit). Home for theorems proved in
`plans/M63-phaseH4-*.md` — the material behind ledger row 64's completion (`χ(ρ₆₃ arena) = 5` exactly, not
merely `≥ 5`) and the classical-reducibility, superset-neutrality and gauge measurements the seed names
("H4's sweep: '0 forced pairs … ' (G31) — measured, not a theorem; H4's 'reduce the platform' and
'family-keeping' derivations, if any"). Ids `M63H4-T1`… Enumeration in `data/fs71/batch-4d.md`.*

## The theorems

**M63H4-T1 — `χ(ρ₆₃ arena) = 5` exactly: the upper half, by an explicit additive homomorphism. [tools; the
phase H4 implementer, 2026-09-12]** The `ρ₆₃` arena (51,133 vertices, 544,530 edges, ledger row 64) admits a
proper five-colouring: all **96** admissible additive homomorphisms `φ` of the arena's direction lattice
(complete enumeration of `5⁸ = 390,625` maps to `ℤ/5` on the eight basis directions, `0` failures on every
unit vector) are proper five-colourings of the complete edge list — re-verified directly, **0 monochromatic
edges in 52,274,880 checks**, with a planted negative control (repainting one vertex to a neighbour's colour
produces 14 monochromatic edges) confirming the check discriminates. Every one of the 96 has the identical
colour-class multiset `(10182, 10182, 10225, 10272, 10272)`. So `χ(ρ₆₃ arena) = 5`: `≥ 5` is `M63H2-T11`
(already filed, batch 4c), `≤ 5` is this witness — a one-line certificate (`φ` on eight basis vectors) rather
than a 51,133-entry table, needing no solver. *Proof:* `plans/M63-phaseH4-familykeeping.md` §R6. **A second,
independent construction reaches the same fact by a different route**, worth recording as a control: `plans/
M63-phaseH4-sweep.md` §4 builds a proper 4-colouring `f` of the base (Theorem B, centre pinned), sets the
copy's colour to `f(v)+1`, and repairs 2 clashing edges by hand, verified proper on all 544,530 edges — CaDiCaL
itself could not find a five-colouring monolithically in 300 s, twice. *Proof verdict:* closes. *Rests on it:*
ledger row 64 (proposed correction: its text currently reads "the upper half an explicit colouring verified
proper on all 544,530 edges" without naming `χ = 5` as exact and without this address — an edit is proposed
in the batch report, applied by the owner); the sweep of `M63H4-T2`'s and G31's measurements, which need
`χ(arena) = 5` to be non-vacuous (G30 failure mode 7 — `Forces G 5 p q` is vacuously true for every pair if
`G` has no proper 5-colouring at all, and this witness is exactly what rules that out). *Prior art:* the
5-colourability of a specific finite graph is ours; the additive-homomorphism method (a lattice
character composed with reduction mod 5) is the same device Theorem A/B already use at other primes (row 52,
kernel); nearest held: none specific; zbMATH: not queried separately — the object is unique to this
repository. *Kernel:* declined — an explicit finite colouring, checkable in principle but not built as a Lean
declaration; a natural instance if `ρ₆₃`'s coordinates are ever brought into `Instances/` (`M63H2-T9`'s same
note).

**M63H4-T2 — The superset-neutrality theorem: a `D`-reducible deletion cannot change the achievable interface pattern set. [hand; the phase H4 implementer, 2026-09-12]** Let `I` be an interface (vertex set) of a graph
`G`, `S` a deleted set with `S ∩ I = ∅`, `A = V ∖ S`, and `P(H)` the set of patterns proper four-colourings of
`H` present on `I ∩ V(H)`. **If `Extends G A 4` holds (`Absorb.lean`), then `P(G) = P(G − S)`.** *Proof:*
`plans/M63-phaseH4-freecensus.md` §2, ending "∎". `P(G) ⊆ P(G−S)`: any proper four-colouring `C` of `G`
restricts to a proper four-colouring of `G[A] = G−S` via `restrictColoring` (`Absorb.lean`), and since
`I ⊆ A` the restriction agrees with `C` on `I` — this half needs no hypothesis and is `M63H3-T3`'s
monotonicity theorem restated. `P(G−S) ⊆ P(G)`: exactly the unfolding of `Extends G A 4 = ∀ c :
(G.induce A).Coloring (Fin 4), ∃ C : G.Coloring (Fin 4), ∀ a : A, C a = c a` — given `c` proper on `G−S`, the
`C` it supplies agrees with `c` on `A ⊇ I`, so `c|I = C|I ∈ P(G)`. *Proof verdict:* closes. **Two
qualifications carried as scope, not separate claims:** the deletion must be certified against the graph *as
it currently stands* under iterated peeling (`ExtensionOrder`'s `cons`, already the shape `Absorb.lean`
builds), not against the original graph's degrees — the degree-≤3 case is safe either way, but a general
`Extends` certificate can be destroyed by a co-deleted vertex; and if `S` touches the interface, pattern
equality is meaningless (the two pattern sets live on different vertex sets). *Rests on it:* the phase's
finding that the free-deletion census on `ρ₆₃` is **empty** (§1, below, in "readings"), so the theorem has no
instances on this object — "a theorem with no instances on this object" (the source's own phrase); a caution,
measured rather than argued, that phase H3's `n=2` arena's 4-core peel does **not** qualify (it removes 120 of
241 interface vertices, all 60 circle points, so it destroys the coupling the interface formulation is built
from — sound for deciding four-colourability alone, unsound for preserving the interface-pattern reading).
*Prior art:* the restriction half is elementary graph theory, already `Absorb.lean`'s `restrictColoring`; the
"if `Extends`, deletion is superset-neutral for interface patterns" combination is ours as stated; nearest
held: none specific (the classical D-reducibility literature, `M63H4-T3`, states extension but not this
pattern-preservation corollary); zbMATH: `ab:"precoloring extension" & ab:"pattern"` (1 hit, unrelated —
combinatorial design pattern extension). *Kernel:* declined — the restriction half is already kernel
(`restrictColoring`); the `Extends`-based converse inclusion is a direct unfolding of the existing definition
and would be a short addition to `Absorb.lean` if wanted.

**M63H4-T3 — The recognition: `Absorb.lean`'s absorption IS classical D-reducibility, and its exact boundary on a unit-distance graph is degree ≤ 4 excluding Gallai trees. [hand, prior art; the phase H4 implementer, 2026-09-12]** Written on a general graph with ring `R = N(S) ∖ S`, D-reducibility ("every proper
four-colouring of the ring extends into the configuration `S`") **is `Extends G (V∖S) 4` verbatim**, so
`extends_of_extensionOrder` and the 4-core peel are the degeneracy corner of the classical reducibility
machine (`[Steinberger2010]`, tracing to Appel–Haken and Robertson–Sanders–Seymour–Thomas). **Singleton
case, a two-line theorem, not a measurement:** any graph on `≥ 4` vertices has a surjective proper
four-colouring (split a colour class in two), so `{v}` is D-reducible **iff `deg(v) ≤ 3`** — the 4-core peel
is not an approximation to singleton D-reducibility, it *is* singleton D-reducibility. **The sharp general
boundary (Borodin 1977; Erdős–Rubin–Taylor 1979, independently, cited via `[Steinberger2010]`):** a connected
graph is degree-choosable iff it is not a Gallai tree (every block a complete graph or an odd cycle); applied
to absorption, every free-by-degree deletion at four colours needs a connected piece all of whose vertices
have degree `≤ 4` **and which is not a Gallai tree** — degree `≤ 3` alone (the greedy bound) is the *only*
case degree information alone can buy past that. **Applied here:** `ρ₆₃`'s minimum degree is 6, so the sharp
theorem gives zero with two full degrees of margin (not an artefact of stopping the peel early); and a claim
that `[Parts2020a]`'s base (minimum degree 4) would benefit is **refuted by measurement** — its 18–24
degree-≤4 vertices are pairwise **non-adjacent**, so every candidate piece is a single vertex, and a single
vertex **is** a Gallai tree (controls: `C₄` correctly not a Gallai tree; `K₃`, `P₃`, `K₁` correctly are), so
the reusable screen is "do the degree-≤4 vertices touch each other in a piece containing an even cycle?", not
"minimum degree ≤ 4" — zero on both objects this project holds. *Proof:* `plans/M63-phaseH4-freecensus.md`
§10.1–§10.2(a,b), `plans/M63-phaseH4-reduce-the-platform.md` §10. *Proof verdict:* closes. *Rests on it:*
`M63H4-T4`'s exact non-existence bound; the decision to retire the classical-reducibility direction for
`ρ₆₃` entirely (§10.4). **What is theirs and what is ours, stated in the discipline's own vocabulary
(the audit's per-theorem procedure):** D-reducibility, the Appel–Haken/RSST/Steinberger machine, and the
Borodin/Erdős–Rubin–Taylor degree-choosability theorem are **classical, [Steinberger2010]'s and its
predecessors'**; the *recognition* that `Absorb.lean`'s `Extends` already is D-reducibility, the singleton
two-line theorem, and the application of the degree-choosability boundary to a unit-distance graph
(measuring `ρ₆₃`'s and Parts's own base's minimum degree against it) are ours. *Prior art:* `[Steinberger2010]`
(An unavoidable set of D-reducible configurations, Trans. AMS 2010) for the machine and its ring-size
economics; Borodin (1977) and Erdős–Rubin–Taylor (1979) for degree-choosability, cited via `[Steinberger2010]`
(neither paper independently confirmed here — a check owed if this direction is revisited); nearest held:
`[Steinberger2010]`, `BIBLIOGRAPHY.md` (already carries this row and role, verified present — no edit
needed); zbMATH: `ab:"D-reducible"` (7 hits, the classical four-colour-theorem literature, none about
non-planar or unit-distance graphs), `ab:"Gallai tree" & ab:"degree-choosable"` (3 hits, the classical
list-colouring literature). *Kernel:* declined — the recognition and the singleton theorem are short and
could be formalised (`{v}`-D-reducibility iff `deg ≤ 3` is a two-line consequence of existing `Absorb.lean`
lemmas); not pursued, since the direction is retired for the object at hand.

**M63H4-T4 — No D-reducible configuration of ≤ 27 vertices exists anywhere in the `ρ₆₃` arena — an exact closure, not a search. [hand + tools; the phase H4 implementer, 2026-09-12]** From `M63H4-T3`(b), any
D-reducible `S` with `|S| ≤ m` has every member `v ∈ S` satisfying `deg(v) ≤ m + 2` (since
`|N(v) ∩ S| ≥ deg(v) − 3` and `deg_S(v) ≤ m − 1`). Peel the graph to the fixed point of "delete `v` when
`|N(v) ∩ C| < deg(v) − 3`", started from `C = {v : deg(v) ≤ m+2}`: every admissible `S` of size `≤ m` survives
this peel, so an **empty fixed point is a proof of non-existence**, not a failed search. Measured exactly on
the `ρ₆₃` arena: at `m = 14` (the classical Appel–Haken/RSST ring-size ceiling), `m = 20`, and `m = 27`, the
closure is empty (16,428 of 51,133 candidates survive the initial degree filter at `m=14`, all eliminated by
the closure); at `m = 28` (the smallest size the necessary condition permits at all) 51,132 of 51,133 vertices
survive. **So no configuration of 27 or fewer vertices exists anywhere in the arena**, against classical
rings of size `≤ 14` (Appel–Haken, RSST) or `≤ 16` (Steinberger); the smallest admissible non-singleton ring
measured is **77** (at `|S|=7`, the closed neighbourhood `N[v]`), where a ring of 14 has `199,291` colourings
up to permutation and a ring of 77 has `≈ 2×10³⁵` — at `[Steinberger2010]`'s own stated four-fold-per-ring-unit
cost scaling, about `4⁶¹ ≈ 5×10³⁶` times "a few minutes". *Proof:* `plans/M63-phaseH4-freecensus.md` §10.2(c,d).
*Proof verdict:* closes. *Rests on it:* the retirement of the classical-reducibility direction for `ρ₆₃`
(§10.4); `M63H4-T3`'s degree boundary. *Prior art:* the peel-to-a-fixed-point-as-a-non-existence-proof
technique is elementary (a monotone deletion rule whose surviving set contains every admissible configuration);
the cost-scaling comparison uses `[Steinberger2010]`'s own stated constant; nearest held: `[Steinberger2010]`;
zbMATH: `ab:"unavoidable set" & ab:"reducible" & ab:"ring size"` (1 hit, `[Steinberger2010]` itself). *Kernel:*
declined — an exact combinatorial closure computation on a 51,133-vertex graph, `decide`-grade in principle,
not pursued.

## Readings and measurements that were called theorems

- **The free-deletion census: ZERO** (`plans/M63-phaseH4-freecensus.md` §1). Every degree-≤3 vertex is
  measured, not merely bounded: `ρ₆₃`'s minimum degree is 6, so `M63H4-T3`(a)'s theorem gives an empty set
  by inspection, and this is the measurement recording that fact on the actual object (0 of 51,133), not a
  new theorem.
- **The compulsion sweep — G31's extension: "0 forced pairs of 1,307,266,278 and 0 virtual edges of
  1,306,721,748"** (`plans/M63-phaseH4-sweep.md` §8, §8.1; `CLAUDE.md` G31). Certified by 4,480 exhibited
  proper five-colourings, no solver UNSAT anywhere (the survivor set is a superset by construction, so no
  positive compulsion could hide). Explicitly a measurement extending G31's already-filed reading ("existing
  witnesses hold nothing to extract") to a produced, purpose-built object in an unsealed field; not a new
  theorem, already the subject of the already-graded G31 grokking entry.
- **The critical-vertex screen applies as a theorem (already kernel, row 48) and is inert here, for a
  flattering reason** (`plans/M63-phaseH4-sweep.md` §2; `plans/M63-phaseH4-reduce-the-platform.md` §15/§16).
  `encard_criticalSet_le_two_of_forces` and `criticalSet_subset_union_neighborSet_of_separated` are already
  kernel and already attributed to row 48/G31 (batch 3a); measured here that `ρ₆₃`'s maximum cross-degree of
  any single vertex is 1 (against de Grey's 1581, whose entire coupling sits on one cut vertex plus one
  edge), so the screen cannot fire — a measurement about this object, not a new theorem.
- **`γ̄ ~ n^0.485` (the gauge's growth law) and "the arena's additive family factors the same way its
  refutation does"** (`plans/M63-phaseH4-reduce-the-platform.md` §15, `plans/M63-phaseH4-familykeeping.md`
  §R). A two-point power-law fit on `γ̄` (1,118.0 / 1,380.0 / 1,700.0 at three arena sizes, giving exponents
  0.475 and 0.495) and an observation that a `k`-colour additive family decomposes into base-colouring pairs
  at every `k` — neither stated as a general theorem in the source, and the growth-law reading is explicitly
  **withdrawn once** already in the source (the first reading, "growing makes the gauge worse," corrected by
  Kooshi the same evening to "the gauge is extensive and must be normalised" — the corrected `n^0.485` reading
  is what stands, still a measurement). Not filed.
- **"The circle's multiplier kills `k=4` and is harmless at `k=5`"** (`plans/M63-phaseH4-reduce-the-platform.md`
  §15): a one-line observation that `t ≡ 0 (mod 4)` kills only groups of order 4 (`M63H3-T4`'s mechanism),
  not a separately argued fact about order-5 groups. Not filed.
- **"Family-keeping" itself, and the 96/24/48² arithmetic** (`plans/M63-phaseH4-familykeeping.md` §R1–R4): a
  complete enumeration (`5⁸ = 390,625` maps) establishing `ℚ(√3,√7,√11)` keeps a nonzero additive-homomorphism
  family under the arena construction (96 homomorphisms, flat from radius 4.0 to 5.0) — the finding "there
  are TWO fields both 6-open and family-keeping, ours at half the degree of the other" is a comparison, not a
  new theorem beyond the enumeration itself, which is a computed fact (already implicitly the basis of
  `M63H4-T1`'s witness).

## Conjectures surfaced, not claimed

- **What would revive the classical-reducibility direction** (`plans/M63-phaseH4-freecensus.md` §10.4): an
  object whose degree-≤4 vertices form a connected non-Gallai-tree piece, or one with a genuine small
  separator (a ring `≤ 16` cutting off more than one vertex). `ρ₆₃` has neither, by measurement; not
  constructed or sought further here.
- **Whether `γ` (the Kempe-gauge) is exactly the quantity G42 needs or an over-estimate of it**
  (`plans/M63-phaseH4-reduce-the-platform.md` §15): "the open question, and it decides the direction" — left
  open in the source, not resolved.

## Prior art re-attributed

- **D-reducibility, its classical machine, and the ring-size economics (`M63H4-T3`, `M63H4-T4`)** are
  `[Steinberger2010]`, tracing to Appel–Haken and Robertson–Sanders–Seymour–Thomas; the row already carries
  this role in `BIBLIOGRAPHY.md` (verified present, quoted at length — no edit needed).
- **Degree-choosability's Gallai-tree characterisation** is Borodin (1977) and Erdős–Rubin–Taylor (1979),
  cited here only via `[Steinberger2010]`'s report of it — **neither original paper is held or independently
  confirmed**; flagged as a check owed if this direction is ever revisited (not urgent, since the direction is
  retired for the object at hand and `BIBLIOGRAPHY.md`'s `[Steinberger2010]` row already carries the
  attribution honestly, crediting Borodin/ERT by name).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M63H4-T1 | declined — an explicit finite colouring, checkable but not built as a Lean declaration |
| M63H4-T2 | declined — the restriction half is kernel (`restrictColoring`); the `Extends` half unfolds an existing definition |
| M63H4-T3 | declined — a short recognition and a two-line theorem, not pursued since the direction is retired |
| M63H4-T4 | declined — an exact `decide`-grade closure on 51,133 vertices, not pursued |
