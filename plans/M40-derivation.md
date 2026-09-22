# M40 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer. Enumeration: `plans/M40-chi-omega-hunt.md` read in full (§0a
D1–D9, §0f A1–A5, §R, "Instrument notes", "What was NOT done"). Grades are `CLAUDE.md` § Notation's. This is the
richest milestone in the batch: nine hand derivations (D1–D9) precede any instrument run, most confirmed, one
(D2) superseded within the same milestone, one (D8) explicitly flagged by its own author as unchecked against the
literature — the check this audit performs below.*

## The theorems

**M40-T1 — The band structure of the constraint graph. [hand; the M40 implementer; confirmed exactly by `--bands`]**
For the scaled constraint graph `G(p)` (M39), an offset `d`'s edge-membership interval `[min_H Q(d+·), max_H Q(d+·)]`
depends only on `d`'s **dihedral orbit** (not merely its norm: two offsets of the same norm but different point-group
class can have different thresholds — first at norm 49, `(7,0)` vs `(3,5)`), so **`G(p)` is one fixed graph on each
open interval between consecutive orbit thresholds** ("a band"), and every census/SAT/ball claim is therefore a
claim about a band, never a point — boundary scales are tie-break-sensitive and excluded. *Proof:* `plans/M40-chi-
omega-hunt.md` §0a D1 (the coarse threshold table, exact rational arithmetic) and §0f A1 (the norm-49 class split,
planted as a check: `(7,0)` has `min = 36`, `(3,5)` a different threshold — confirmed green, §R "P2 CONFIRMED").
*Proof verdict:* closes (an elementary consequence of the convexity criterion M39-T1 establishes, applied orbit-by-
orbit rather than norm-by-norm; the planted check found no counterexample). *Rests on it:* every band claim in this
milestone and in M42/M43 (rows 39, 40); the artifact schema `(band_id, T)` (§0f A3). *Prior art:* the mechanism
(a piecewise-constant Cayley-graph family under exact rational thresholds, refined by point-group orbit rather than
by norm alone) was not searched as a named result; the underlying convexity fact is M39-T1's. zbMATH: `ab:"distance
graph" & ab:"clique number" & ab:"chromatic number"` (0 hits, 2026-09-22), `ab:"Cayley graph" & ab:"lattice" &
ab:"threshold"` (0 hits). Nearest held key: none on point. *Kernel:* declined — no module states the general
orbit-keyed threshold fact; the specific bands that reached the kernel (M42, row 39) are separate hand constructions.

**M40-T2 — The clique number of `G(p)` is exactly 3 for every `p ≤ 1/7`. [hand; the M40 implementer, D5 refined by
A2; confirmed]** For `p ≤ 1/7` (equivalently `T ≥ 7`), `ω(G(p)) = 3`. *Proof:* `1 − ζ₆` is a unit of the Eisenstein
integers, so for any edge offset `u` the equilateral triangle `{0, u, ζ₆·u}` has all three side vectors associates
of `u` — same dihedral orbit, hence all three sides are edges: **every band with any edge at all contains a
triangle**, giving `ω ≥ 3` for free (§0f A2, sharpening D5's original Loeschian-density argument, which needed the
`T > 6.73` threshold below). The matching upper bound `ω ≤ 3` is D5's four-point argument: any edge has
`|d| ∈ [T − 2/√3, T + 2/√3]` (necessary, from the difference-body bound), so a clique's pairwise distances lie
within ratio `(T+2/√3)/(T−2/√3)`, which drops below `√2` once `T > (2/√3)(3+2√2) ≈ 6.7302`; and **no four points of
the plane are pairwise within distance ratio `< √2`** (any four points contain a triangle with an angle `≥ 90°`: in
convex position some quadrilateral angle is `≥ π/2`; with one point interior to the other three, the three angles at
it sum to `2π` so one is `≥ 2π/3 > π/2`; either way the law of cosines gives `c² ≥ a² + b² ≥ 2·min²`, ratio `≥ √2`).
*Proof verdict:* closes (both halves are short, complete elementary-geometry arguments; A2's unit-vector triangle
trick is a genuine sharpening — it removes D5's dependence on Loeschian density entirely, needing only "some edge
exists"). *Rests on it:* row 37's "ω falls to 3–5" and the fine-tail claims of row 40 (M43); D3's `ω(G*) = 4` is a
*different* band (`T² ∈ (13/3,16/3)`, `T ≈ 2.13 < 7`) and is not an instance of this theorem. *Prior art:* the
no-four-points-within-ratio-`√2` fact is elementary and almost certainly folklore (a special case of results on the
"distance ratio" or "spread" of finite point sets), not searched as a named citation; the application via Eisenstein
units to guarantee a triangle on any nonempty band is project-specific. zbMATH: `ab:"four points" & ab:"distance
ratio"` (0 hits, 2026-09-22), `ti:"clique number" & ab:"Eisenstein"` (0 hits). Nearest held key: none on point.
*Kernel:* declined — not consumed by any later Lean module; the fine-tail's `ω = 3` bound is used only as a
[tools]-grade census fact, never as a kernel hypothesis.

**M40-T3 — The torus-wrap Hoffman bound for `G(p)`. [hand; the M40 implementer; used throughout §R, not separately
re-verified beyond the adaptive-interval brackets]** `G(p)` is a Cayley graph on `ℤ²` with connection set `S` (a
band's edge offsets), so its "spectrum" is the range of the trigonometric polynomial `λ(θ) = Σ_{s∈S} cos(2π s·θ)`,
`θ ∈ [0,1)²`, of degree `d = |S|` at `θ = 0`. **Any upper Banach density `δ` of an independent set of `G(p)` obeys
`δ ≤ −λ_min/(d − λ_min)`**, hence every proper `k`-colouring (having a class of density `≥ 1/k`) forces
`k ≥ 1 + d/(−λ_min)`. *Proof:* `plans/M40-chi-omega-hunt.md` §0a D6 plus §0f A4's soundness notes: an independent set
of density `δ` wraps onto the `m`-torus quotient with `O(m)` boundary repairs (need `m ≥ 3·max|s|` so the wrapped
connection set stays simple), the torus's own Hoffman ratio bound applies there exactly (finite vertex-transitive
graph), and `m → ∞` gives the limit since `x ↦ x/(d+x)` is monotone (so a continuous bracket on `λ_min` upper-bounds
every finite torus's own ratio, i.e. torus spectra `⊆` the continuous range). *Proof verdict:* closes (the wrap
argument is a standard Følner/amenability-style limit — boundary is `O(m)` against area `Θ(m²)` — applied to a
textbook spectral graph theory bound; no step is unusual, but none of it is written down as a citable theorem
anywhere the audit found). *Rests on it:* the certified Hoffman brackets reported in §R (P7: classical 5.04, bad
band 5.96, 12-band 6.10, G* 4.09, deep pocket 4.18) — used only as a *diagnostic* (showing the spectral bound cannot
explain the seven-forcing below the 12-band), never as a proved lower bound on any `χ(G(p))` in this milestone (no
`χ ≥` claim in §R cites a Hoffman number). *Prior art:* the finite-graph Hoffman/ratio bound is `[Hoffman1970]`
(already held, row 67's key); the infinite-Cayley-graph limit via torus wrapping is a standard amenability argument
(Følner sequences on `ℤ²`), not searched as a single citable source for this exact form. zbMATH: `ab:"Hoffman bound"
& ab:"amenable" & ab:"lattice"` (0 hits, 2026-09-22), `ab:"independence ratio" & ab:"Cayley graph" & ab:"torus"`
(0 hits). Nearest held key: `[Hoffman1970]` (finite case only). *Kernel:* declined — "no kernel claim from ANY
numeric spectral value this milestone" (§0d, the milestone's own standing rule); the bound is diagnostic-only.

**M40-T4 — No coset seven-colouring below the classical window, on any of three checked bands. [cert; the M40
implementer, exhaustive finite check with explicit witnesses]** On the band `G*` (`T² ∈ (13/3,16/3)`) and,
separately, on the closed `T = 6` and `T = 7` bands, the extracted seven-colouring (from a torus SAT solve) has
**trivial stabilizer** (no torus translation even permutes its seven colour classes) and **every one of the eight
index-7 sublattices of the Eisenstein lattice contains at least one edge of the graph** (each with an explicit
witness offset), so **no coset colouring by any norm-7 ideal, nor by any other index-7 sublattice, is proper on that
band** — the classical hexagonal mechanism is structurally unavailable there, and every seven-colouring achieved is
non-homomorphic. *Proof:* `plans/M40-chi-omega-hunt.md` §R "P8 CONFIRMED and strengthened to a theorem-shaped fact"
— an exhaustive finite check over the eight index-7 sublattices of `ℤ[ζ₆]`, each tested against the extracted
colouring's edge set, with the witnessing edge recorded per sublattice (`build/m40-chiomega.json`). *Proof verdict:*
closes (exhaustive over a finite, explicitly enumerable set — the eight sublattices — with a witness for each; this
is the seed's headlined target and the row's own words call it "an exact finite computation, cert-grade").
*Rests on it:* row 37's headline sentence; the kernel promotion at M42 (`Coset.no_coset_seven_on_gap`, row 39)
formalizes the `G*` band case only — the closed `T = 6` and `T = 7` instances of this same fact were never
kernelised. *Prior art:* the fact that a specific extracted colouring is non-coset is project-specific (it answers
M39's own P5 question, "genuinely non-coset seven-colourings would be a finding in their own right," §0a D9); no
literature search found an analogous "no coset colouring of this index exists on this sub-window" result. zbMATH:
`ab:"coset coloring" & ab:"sublattice" & ab:"chromatic"` (0 hits, 2026-09-22), `ti:"triangular lattice" &
ab:"index 7"` (0 hits). Nearest held key: none on point. *Kernel:* **G* band is kernel**
(`Coset.no_coset_seven_on_gap`, row 39, M42); the closed `T = 6` and `T = 7` instances of the same claim are
declined — no consumer named beyond the
narrative sentence in row 37.

**M40-T5 — The interval-distance bridge. [hand; the M40 implementer; explicitly flagged unchecked against the
literature, checked here]** A `G(p)`-edge's two lattice points sit within covering radius `p/√3` of a genuine
unit-distance pair, so their scaled distance lies in `[1 − 2p/√3, 1 + 2p/√3]`; hence any colouring of the plane
avoiding every distance in that interval restricts to a proper `G(p)`-colouring on the lattice, giving
**`χ_{[1−ε,1+ε]}(ℝ²) ≥ χ(G(p))` at `ε = 2p/√3`** — every band theorem is simultaneously a lower bound for the
interval-forbidden-distance chromatic number (the genre `[Exoo2005]` opens). *Proof:* `plans/M40-chi-omega-hunt.md`
§0a D8, a one-paragraph covering-radius argument; elementary and complete. *Proof verdict:* closes. *Rests on it:*
nothing downstream — the milestone's own "What was NOT done" records that "the interval-distance bridge (D8)
consequences were not priced against literature... no novelty claim is made for them," and this audit closes that
open item: **every numeric consequence drawn from D8 in this milestone is dominated by an already-held theorem**.
`[Voronov2023]` (held, read 2026-09-08, already the load-bearing citation of M43/row 40's own conditional) Theorem
1.1 proves `χ_{[1−ε,1+ε]}(ℝ²) ≥ 7` **unconditionally, for every `ε > 0` and every 2-dimensional norm** — strictly
stronger than every band consequence D8 draws here (`≥ 10` at `ε ≈ 0.567`, `≥ 7` at `ε = 1/(3√3) ≈ 0.1925`, both
`≤ 7`). So the bridge *mechanism* (cell bands ⟹ interval-distance bounds via a covering-radius argument) is a
distinct, correct derivation, but as **used** in this milestone it supplies no lower bound that `[Voronov2023]` does
not already give more cheaply and more generally — a finding this audit records rather than a novelty claim.
*Prior art:* **partly — the mechanism is a hand derivation, plausibly independent of the literature in its
technique (covering radius of a Voronoi cell, rather than Voronov's topological argument on the unit circle), but
every consequence drawn is subsumed by `[Voronov2023]` Thm 1.1, already held**; `[Exoo2005]`, `[Parts2023]`,
`[ChybowskaSokol2022]` (all held, § "the interval-distance genre" — see `BIBLIOGRAPHY.md`) study the same
`χ_{[1,b]}` / `χ_{[1−ε,1+ε]}` objects from the upper-bound and exact-value side, and none was cross-checked against
D8's specific technique. zbMATH: `ab:"forbidden distance" & ab:"interval" & ab:"lower bound" & ab:"chromatic"`
(0 hits, 2026-09-22) — confirms `[Voronov2023]` (arXiv, not yet zbMATH-indexed) is the operative prior art rather
than anything this query would surface. *Kernel:* declined — dominated by a held external theorem, no independent
numeric content to certify.

## Readings and measurements that were called theorems

- **D2, the 10-clique (superseded within the same milestone).** §0a D2 hand-derives (checked "exhaustively by hand"
  over 45 pairs) that the ten points of the side-3 address triangle form a clique on the band `T² ∈ (4, 13/3)`,
  giving `χ(G(p)) ≥ 10` there. **The exact value is higher**: the corrected exhaustive census (§R) finds `ω = 12`
  on that band (a 12-point trapezoid) with `χ = 12` exactly (`k = 12` SAT), so D2's "= 10" guess (registered as P1)
  was an undercount — the `≥ 10` direction is correct but not tight, and not filed separately: row 37's "12 on
  (0.4804, 1/2)" already carries the sharp [tools] value.
- **D3, the `G*` headline (`ω = 4`, `χ = 7`).** Already correctly captured by row 37 ("G* = (0.4330, 0.4804) has
  ω = 4, χ = 7"); the exact fractional-chromatic-number certificates at the associated cores (23-core, 53-core,
  117-core) belong to M41 (row 38), not here — see `plans/M41-derivation.md`.
- **D7, the fractional discriminator.** `χ_f(\text{vertex-transitive } G) = n/α(G)` is standard fractional graph
  theory (Scheinerman–Ullman-type folklore), not searched as a citation here; its application (`χ_f(G(p)) ≤
  N/α(\text{torus})` via the torus being a homomorphic image) gives the measured `α(G*, 12×12) = 21`, hence
  `χ_f(G*) ≤ 48/7 ≈ 6.857` (§R P6) — a [tools] measurement (an exact SAT/totalizer computation on one named finite
  graph), correctly quantified; not restated as a theorem.
- The whole "corrected spectrum" band table (§R) and the core anatomy (23/28/53/66/117 vertices, orbit counts) are
  [tools] measurements, already the content of row 37 or (for the cores) row 38.

## Conjectures surfaced, not claimed

(none beyond D2's superseded numeric guess, recorded above with its correction, not as an unproved conjecture)

## Prior art re-attributed

- **M40-T5's consequences → `[Voronov2023]`.** The bibliography row for `[Voronov2023]` already states its Theorem
  1.1 correctly and already carries M40/M43's dependency; no change to `BIBLIOGRAPHY.md` is needed beyond noting
  here (this audit's finding) that D8's own consequences are dominated by it.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M40-T1 | declined — no consumer beyond the artifact schema |
| M40-T2 | declined — used only as a [tools]-grade census fact downstream |
| M40-T3 | declined — diagnostic-only, per the milestone's own standing rule (§0d) |
| M40-T4 | kernel on the `G*` band (`Coset.no_coset_seven_on_gap`, M42); declined on the `T = 6`/`T = 7` instances |
| M40-T5 | declined — dominated by `[Voronov2023]` Thm 1.1 |
