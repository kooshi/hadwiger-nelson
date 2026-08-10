# M29 — The uncountable two-pivot system (HORIZON STUB)

> **DEMOTED 2026-08-09** (Kooshi's direction, the field-jump session). Not
> deleted — demoted. Reason: the de Bruijn-Erdos compactness theorem (our axiom base includes choice) reduces it to: does the CONTINUUM pair contain a FINITE 5-chromatic subgraph? The finite hunt is subsumed by the de Grey-field programme (M30+), which hunts where finite 5-forcers provably exist. The residual question (a phase-uniform 4-colouring of the full continuum pair) is another 4-result in the 4-field.
>
> The live roadmap is `CLAUDE.md` § Frontier / paths forward and the
> `plans/M30`+ stubs (the de Grey field programme).


*Recorded 2026-08-08. Kooshi's hypothesis: χ(uncountable pair system) =
χ(countable matched ladder pair) — "worth proving rather than dismissing on a
whim." The path below is the current best sketch; slot flexible (could run
any time after M24).*

## The object

`Coupled.pairSystem` proper: the two pivots + ALL (uncountably many) points of
the four circles. Known: χ ≥ 4. The M21 fork. The hypothesis: χ = 4 iff the
countable ladder object's χ = 4 (M24).

## The path (four steps, sketched 2026-08-08)

1. **Compactness (de Bruijn–Erdős)**: χ(uncountable) ≤ 4 ⟺ every FINITE
   subgraph is 4-colourable. Availability in Mathlib to be checked at subplan;
   if absent, provable by Zorn/Tychonoff — standard, real Lean work. (We run
   on Classical.choice anyway.)
2. **Finite subsets touch finitely many ladders**: the system partitions into
   ladder-cosets ψ (intra-system components — a completeness fact already);
   a finite subgraph lives in finitely many matched ladder-pairs wired by the
   FOREIGN maps (the Möbius and quadratic branch maps, finitely many fixed
   algebraic maps sending coset ψ to cosets f_i(ψ)).
3. **Parametrized completeness — "the infinite sporadic chords" classified**:
   the chords between ladder-pair(ψ) and ladder-pair(ψ′) are the lattice
   solutions of the SAME norm-form equations carrying an offset parameter
   δ = ψ′ − ψ (e.g. the ii form becomes (√3·e^{iδ}u − 1)(√3·e^{−iδ}v − 1)
   -type). Two claims to prove: (a) for every δ the solution set is FINITE
   and classified; (b) the RESONANT δ (nonempty solution set) form a countable,
   explicitly-described family — each resonance an algebraic condition. The
   anchor coset δ = 0 (M24's twelve sporadics + glue structure) is the most
   resonant member, not an exception.
4. **The extension lemma**: a generic finite configuration is a FOREST of
   ladder-pairs glued sparsely by foreign chords → colour each component with
   the M24 pattern composed with a palette permutation, chosen greedily along
   the forest (needs: the pattern family's palette freedom exceeds the
   per-link conflict count — a finite combinatorial lemma). Resonant loops
   (foreign words returning to a coset) are the genuinely coupled finite
   cases — handled by the census + SAT machinery per resonance class, made
   finite by step 3b.

## Honesty clause

The path doubles as a hunt: if some finite resonant configuration needs 5
colours, the hypothesis is FALSE and that configuration is a finding — the
first 5-forcing structure in the family. Either outcome is reportable.

## Evidence in hand

M24's norm forms (the δ = 0 case); the ladder-coset decomposition (intra
completeness = components are ladders); the foreign-web structure (M22
partner census: ≤ 4 partners per point, exactly one always the translate,
one always the far pivot — the foreign maps are few and explicit).
