# Job LX — record (consolidation and library run, 2026-09-27)

*de Bruijn, Opus 5.5. Brief: `data/consolidation-2026-09-27/briefs/LX-johnson1982-and-q4.md`. HEAD at launch: 17d20647.*

## Stage 1 — SAVED — the ℚ⁴ law (blind)

### Files opened during stage 1 (the fence log)

1. `data/consolidation-2026-09-27/briefs/STANDING-RULES.md`, and `ls` of `data/consolidation-2026-09-27/briefs/` (file names only).
2. `data/consolidation-2026-09-27/briefs/LX-johnson1982-and-q4.md`.
3. `CLAUDE.md` — lines 74–138 (§ The aim, § Counter-priors), read from disk with `sed`; a `grep -n` for three section headings.
4. `~/source/library/geombinatorics/geombinatorics-v09-n2-1999-10.pdf` (Zaks 1999) — 40-dpi thumbnails of sheets 1, 5, 10, 15, 20, 30 to
   find the pages; sheets 29–32 at 170 dpi, split into pages: **pp. 90–95 read in full** (p. 89, the left half of sheet 29, rendered, not viewed).
5. `~/source/library/geombinatorics/geombinatorics-v09-n3-2000-01.pdf` (`[BendaPerles2000]`) — 30-dpi thumbnails of sheets 10–12; sheets 8–15 at
   190 dpi: **pp. 113, 114, 115, 117–126 read**; p. 116 (the box metric, § 1) rendered, not viewed; p. 112 (another paper) not viewed.
6. `~/source/library/pdf/johnson-2006-coloring-rational-points-forbid-distance-one-geombinatorics-16-1-209-218.pdf` (`[Johnson2006]`) — all six
   sheets rendered; **pp. 209, 211, 212, 217, 218 viewed** (pp. 210, 213–216 not viewed).
7. `LEDGER.md` — `grep` for row 57's line number, then row 57 itself (line 101).
8. `BIBLIOGRAPHY.md` — one `grep` for `Johnson1989|Johnson1990|Jungreis|"Two colorings of a dense"` (output cut at 300 characters: the
   `[Johnson1987]`, `[Johnson1990]`, `[Chow1993]`, `[JungreisReidWitte1990]` rows and one library row); then, after checking with `grep -c` that
   neither names Zaks, lines 140 (`[Johnson1990]`) and 143 (`[Chow1993]`) in full. No row naming Zaks was opened.
9. `~/source/library/papers/1-s2.0-0012365X9090033E-main.pdf` (`[Johnson1990]`) — `pdftotext -layout` into my scratch; lines 40–95 and 185–252.
10. `git log`, `git status --short` (names only).
11. **One slip, reported:** my first render wrote five thumbnails into the session's shared scratchpad root, and the `ls` that followed listed
    that directory — the names of other agents' scratch files (for example `j2006`, `lv`). I opened none of them; all my working files
    were moved to a private subdirectory `lx-own/` and nothing else there was read.
12. My own files: this record, `data/consolidation-2026-09-27/lx/q4_checks.py`.

### The sources, verbatim

**Zaks 1999** (*On Odd Integral Distances Rational Graph in four-dimensions*, Geombinatorics IX(2) pp. 90–95; image scan, clearly legible):
- p. 91: *"The following four points A = (1/2, 0, 0, 1/2), B = (1/2, 0, 0, −1/2), C = (0, 1/2, 1/2, 0) and D = (0, 1/2, −1/2, 0) are at mutual
  unit distance, hence they must have distinct colors, say, φ(A) = 1, φ(B) = 2, φ(C) = 3 and φ(B) = 4. The point E = (−1/2, 0, 0, −1/2) is at
  unit distance from the points B, C and D, therefore φ(E) = φ(A). Thus, the points A and E, which are at distance √2, have the same
  φ–color."* (The second "φ(B)" is a misprint for φ(D).)
- p. 92: *"Lemma 1: In every proper four coloring of Q⁴(1), every two rational points at distance √2 have the same color."* Proof: translate
  the configuration, then *"Consider the reflection h of Q⁴ with respect to the hyperplane which is the perpendicular bisector of the segment
  VW₄."* (Its line *"φ(U) = φ(f(E)) = φ(W)"* means φ(W₄).)
- p. 92: *"Lemma 2: In every proper four coloring of Q⁴(1), every two rational points at distance 2 have the same color."* First proof:
  *"Consider the four points A = (0, 0, 0, 0), B = (1, 0, 0, 0), C = (2, 0, 0, 0) and D = (0, 1, 0, 0)."* — D is a misprint for (1, 1, 0, 0), as
  `[Johnson2006]` p. 212 says; checked: the printed D is at squared distances 1 and 5 from A and C, the corrected one at 2 and 2.
- p. 93: *"Theorem 3: In every proper four coloring of Q⁴(1), every two rational points at odd distance have different colors, hence
  χ (Q⁴(odd)) = 4."*
- p. 94: *"It follows, as in [11], that in every proper four coloring of Q⁴(odd), every color class is dense in the space. This result also
  follows from the Lemma 2, since the connected components of the graph Q⁴(√2) are monochromatic in every proper four coloring of Q⁴(1),
  and each one of them is everywhere dense."*

**`[BendaPerles2000]`** (Geombinatorics IX(3) pp. 113–126; image scan of typeset text):
- p. 119: *"So let us denote by Hⁿ the points of Qⁿ connected to (0, . . . , 0)"*.
- p. 122: *"The case of Q⁴. The graph has chromatic number 4 and is disconnected, the index of H⁴ in Q⁴ is infinite."*
- p. 124: *"Let us denote by D the points of H⁴ with odd denominators, i.e. those of type tᵢ for some i ≤ 4."* … *"Because E is the only coset
  of D in H⁴ ([H⁴ : D] = 2) we colored the whole H⁴ and therefore the whole G₁(Q⁴)."* … *"H⁴ consists of the following points (a)
  a,b,c,d/e e odd (b) a,b,c,d/2e a, b, c, d and e odd"*.
- So Benda–Perles's `H⁴` is the component of the origin and their `D` the odd-denominator subgroup of index 2 in it.

**`[Johnson2006]`** p. 212 — **the question, verbatim:** *"But I believe the following is still open: For which d > 0 does there exist a
4-coloring of ℚ⁴ which forbids both distances 1 and d?"* Further on the page: *"So, we have two distances, 2 and √2, which a fortiori cannot
be forbidden by a proper 4-coloring of G(ℚ⁴, 1), and perhaps the methods of proof in [24] will generate more such distances, since Zaks also
proves (Theorem 3 in [24]) that every proper 4-coloring of G(ℚ⁴, 1) is also a proper 4-coloring of G(ℚ⁴, 2k + 1), k = 1, 2, 3, . . . So
perhaps all the distances 4k+2 and √(4k + 2), k = 1, 2, . . . cannot be forbidden by a proper 4-coloring of G(ℚ⁴, 1). But we leave this
question for another day."* ([24] is Zaks 1999, p. 218.) And p. 211: *"And, there is a 4-coloring of ℚ⁴ which simultaneously forbids all of
those very same distances."* — the distances *"√(p/q), p, q odd positive integers"*, citing its [12] = `[Johnson1990]`.

**`[Johnson1990]`** p. 192 (text layer): *"Theorem 3. There is a four-coloring of Q4 which forbids the distances K."*, with (p. 191, its (4))
`K = {√(p/q); p and q are odd positive integers}`.

### Notation for the derivation

`ℚ⁴` = the rational quaternions `x = x₀ + x₁i + x₂j + x₃k`; `N(x) = Σ xᵢ² = x x̄`, so `|x − y|² = N(x − y)` and `N(xy) = N(x)N(y)`.
`S = {u : N(u) = 1}`, the rational unit vectors. `w(x) = v₂(N(x))`, `w(0) = +∞`. `R = {w ≥ 0}`, `P = {w ≥ 1}`. `H` = the Hurwitz order
`ℤ⁴ ∪ (ℤ⁴ + ½(1,1,1,1))`.

### The derivation

**L1 — `w` is a valuation.** `w(xy) = w(x) + w(y)` from `N(xy) = N(x)N(y)`, and `w(x⁻¹) = −w(x)` with `x⁻¹ = x̄/N(x) ∈ ℚ⁴`. For the
ultrametric inequality it suffices, writing `x + y = x(1 + z)` with `z = x⁻¹y` and `w(x) ≤ w(y)`, to show `w(z) ≥ 0 ⟹ w(1 + z) ≥ 0`. Now
`N(1 + z) = 1 + 2z₀ + N(z)`, so what is needed is `2z₀ ∈ ℤ₍₂₎`. Let `m = −minᵢ v₂(zᵢ)`; if `m ≤ 0` every `zᵢ ∈ ℤ₍₂₎`. If `m ≥ 1`, then
`4ᵐN(z) = Σ (2ᵐzᵢ)²` is a sum of four squares of 2-adic integers, `k ≥ 1` of them units; it must be divisible by `4ᵐ ≥ 4`. An odd square is
`1 (mod 8)` and an even one `0` or `4 (mod 8)`, so divisibility by 4 forces `k = 4`, and then the sum is `4 (mod 8)`, so `m = 1` and every
`2zᵢ` is a 2-adic unit. Either way `2z₀ ∈ ℤ₍₂₎`. ∎ The same computation shows **`R = H ⊗ ℤ₍₂₎`** (every coordinate in `ℤ₍₂₎`, or every
coordinate in `½ + ℤ₍₂₎`): Benda–Perles's types (a) and (b), p. 124. `R` is a ring, `P` a two-sided ideal.

**L2 — `|R/P| = 4`.** Let `L = ℤ₍₂₎⁴`. For `x ∈ L`, `N(x) ≡ Σxᵢ (mod 2)`, so `P ∩ L = {Σxᵢ even}`, index 2 in `L`; an element of `R \ L` has
`N = (Σ aᵢ²)/(4e²)` with every `aᵢ` odd, `Σaᵢ² ≡ 4 (mod 8)`, so `w = 0` and `P ⊆ L`. With `[R : L] = 2`, `|R/P| = 4`.

**L3 — the component of the origin is `R`.** The component of 0 in the Cayley graph `Cay(ℚ⁴, S)` is the group `⟨S⟩`. `⟨S⟩ ⊆ R` since
`S ⊆ R`. Conversely `⟨S⟩` is a ring (it is the ℤ-span of the multiplicatively closed `S ∋ 1`) and contains the 24 Hurwitz units, so it contains
`H`. For an odd prime `p`, `2p − 1 ≡ 1 (mod 4)` is not of the form `4ᵃ(8b + 7)`, so (Legendre) `2p − 1 = b² + c² + d²`, and
`u = ((p−1) + bi + cj + dk)/p` has `N(u) = ((p−1)² + 2p − 1)/p² = 1`. Then `u + ū = 2 − 2/p ∈ ⟨S⟩`, so `2/p ∈ ⟨S⟩` and
`1/p = ((p+1)/2)(2/p) − 1 ∈ ⟨S⟩`. So `⟨S⟩ ⊇ ℤ₍₂₎·H = R`. **`⟨S⟩ = R`** — Benda–Perles's `H⁴` (p. 124–125 prove the same by coordinates and
Lionnet's theorem); the components of the unit-distance graph are the cosets of `R`.

**L4 — the gadget.** `0, 1, v = ½(1+i+j+k), a = ½(1+i+j−k), b = ½(1+i−j+k)`: all ten pairs are at distance 1 except `{a, b}`, with
`a − b = j − k`, `N = 2`. In a proper 4-colouring, `0, 1, v` take three colours and `a, b` are both adjacent to all three, so `c(a) = c(b)`.
(Zaks's p. 91 configuration is the same shape.) Translations, and right multiplication `x ↦ xu` by `u ∈ S`, are automorphisms; for
`N(δ) = N(δ′)`, `δ′ = δ·(δ⁻¹δ′)` with `δ⁻¹δ′ ∈ S`. Hence **every pair at squared distance 2 is forced equal** (Zaks's Lemma 1).

**L5 — the forced-equal set is exactly `P`.** Let `F = {δ : every proper 4-colouring has c(x) = c(x + δ) for all x}`. It is a subgroup, and by
L4 contains every `δ` with `N(δ) = 2`. For `x ∈ P`, `x = r(1 + i)` with `r = x(1+i)⁻¹ ∈ R` (`w(r) = w(x) − 1 ≥ 0`); by L3, `r = Σ nₖuₖ`
with `uₖ ∈ S`, and each `uₖ(1+i)` has norm 2, so `x ∈ F`. So `P ⊆ F`. Conversely, the **residue colouring** — fix a transversal `T` of
`ℚ⁴/R` and colour `t + r` (`t ∈ T`, `r ∈ R`) by `r mod P ∈ R/P` (4 values) — is proper (a unit difference lies in `R \ P`) and separates
every pair with difference in `R \ P`; and pairs in different `R`-cosets lie in different components (L3), so recolouring one coset by a
permutation of the four colours makes them equal or different at will. So `F ⊆ P`, and **`F = P`**.

**L6 — forced different.** Let `c` be proper and `x − y ∈ R \ P`. By L5, `c` is constant on the `P`-cosets inside `x + R`, of which there are
four (L2); the unit tetrahedron `x, x+1, x+v, x+a` has pairwise differences in `S ⊆ R \ P`, so it meets all four, and `c` is injective on
them. So `c(x) ≠ c(y)`.

**Verdicts on the three clauses.** The three conditions `w ≥ 1`, `w = 0`, `w < 0` partition the pairs, and "forced equal", "forced
different", "free" are mutually exclusive (proper 4-colourings exist), so the one-way implications of L5, L6 and the recolouring in L5 give
all three equivalences.

| clause | verdict | proof |
|---|---|---|
| forced to one colour ⟺ `v₂(\|x − y\|²) ≥ 1` | **TRUE** [hand] | L5 (⟸ by L4 and L3; ⟹ by the residue colouring) |
| forced to different colours ⟺ `v₂(\|x − y\|²) = 0` | **TRUE** [hand] | L6 and L2 (⟸); ⟹ by the other two clauses |
| free ⟺ `v₂(\|x − y\|²) < 0` | **TRUE** [hand] | L3: different components, recoloured independently |

Also, as a restatement: **every proper 4-colouring of the unit-distance graph on `ℚ⁴` is, on each component `x₀ + R`, the reduction
`x ↦ (x − x₀) mod P` followed by a bijection `R/P → {colours}`.** Zaks's Lemmas 1–2 and Theorem 3 are its instances `N = 2, 4, (2k+1)²`;
the density of every colour class (Zaks 1999 p. 94; `[Johnson1990]`'s closing Problem, answered per `[Johnson2006]` p. 212 by Zaks's
Aequationes paper) follows because a colour class contains a coset of `P ⊇ 2ℤ₍₂₎⁴`.

**On the stated inputs.** The derivation needs only Zaks's Lemma 1 (or the equivalent gadget L4) and the component `H⁴ = R` (Benda–Perles
pp. 123–125, or L3); Zaks's Lemma 2 and Theorem 3 are consequences, not inputs. `[H⁴ : D] = 2` (Benda–Perles's `D` = odd denominators) is
the step `[R : L] = 2` inside L2.

**The corollary.** Take `d > 0`.
- If `d² ∉ ℚ`, no two points of `ℚ⁴` are at distance `d`, and any 4-colouring forbidding 1 forbids `d`.
- If `d² ∈ ℚ>0`, `d` is realized (Lagrange). **`v₂(d²) = 0`:** the residue colouring forbids 1 and `d` (a difference of norm `d²` lies in
  `R \ P`) — this half is `[Johnson1990]` Theorem 3. **`v₂(d²) ≥ 1`:** pairs at distance `d` are forced equal (clause 1), so no colouring
  forbidding 1 forbids `d`. **`v₂(d²) = −m < 0`:** pick `q ∈ ℚ⁴` with `N(q) = d²` (Lagrange); `φ(x) = qx` multiplies every squared distance by
  `d²`, so if `c` forbids `d` then `c∘φ` is a proper 4-colouring of the unit-distance graph, and by clause 1 `c(φ(0)) = c(φ(y))` whenever
  `w(y) ≥ 1`; take `y = q⁻¹u` with `u ∈ S`: `w(y) = m ≥ 1` and `φ(y) = u`, so `c(0) = c(u)` at distance 1 — `c` does not forbid 1.
  (At `m = 1` the image of the gadget L4 under `φ` is a `K₅`: nine `d`-edges and one unit edge.)

| item | verdict |
|---|---|
| the corollary as worded: *"a four-colouring of ℚ⁴ forbidding both 1 and d exists iff d² = p/q with p and q odd"* | **TRUE for every `d` realized in `ℚ⁴` (⟺ `d² ∈ ℚ`); FALSE as literally worded for `d² ∉ ℚ`** — e.g. `d = 2^{1/4}`: no pair is at that distance, so a colouring exists, yet `d² = √2` is not `p/q`. The repair is Johnson's own hypothesis on p. 211–212 for the two-colour theorem, *"a distance actually realized"*. |
| does it answer `[Johnson2006]` p. 212's question as posed? | **Yes, with that one scope line.** The full answer to *"For which d > 0 …"*: exactly the `d` with `d² ∉ ℚ` (vacuously) and the `d = √(p/q)`, `p, q` odd positive. Its "if" half was in print (`[Johnson1990]` Thm 3, quoted by `[Johnson2006]` p. 211 itself); the "only if" half — the four-colour strong converse on `ℚ⁴`, the analogue of Jungreis–Reid–Witte's two-colour one — is what p. 212 calls open. It confirms and extends Johnson's closing guess: `4k + 2` (`v₂ = 2`) and `√(4k+2)` (`v₂ = 1`) cannot be forbidden, and neither can any realized `d` with `v₂(d²) ≠ 0`. |

**Exact checks** (`data/consolidation-2026-09-27/lx/q4_checks.py`, exit 0, seconds; no search): the gadget's nine unit edges and `N(a − b) = 2`
(a planted off-circle point fails; `(½,−½,½,½)` is *not* a fault — it is a third apex on the same circle, which my first plant missed);
Zaks's A–E distances; Zaks's printed D wrong and Johnson's correction right; Zaks's p. 92 matrix `MMᵀ = 2I`; `w` multiplicative and
ultrametric on a sample, and `w(z) ≥ 0 ⟹ 2z₀ ∈ ℤ₍₂₎`; four classes of `R/P` on a Hurwitz sample, met by the unit tetrahedron; the `1/p`
identity for every odd prime `p < 400`; `N(qx) = N(q)N(x)`.

### Theorems this phase proved

| id | statement | grade | proof |
|---|---|---|---|
| LX-T1 | `w = v₂∘N` is a valuation on the rational quaternions; `{w ≥ 0} = H ⊗ ℤ₍₂₎` | [hand]; classical (the 2-adic valuation of Hamilton's quaternion division algebra over ℚ₂), coordinates as in `[BendaPerles2000]` p. 123 | L1 |
| LX-T2 | `\|R/P\| = 4` | [hand] | L2 |
| LX-T3 | the component of 0 in the unit-distance graph on `ℚ⁴` is `⟨S⟩ = R` | [hand]; `[BendaPerles2000]` pp. 123–125 (their `H⁴`) | L3 (ring route: `1/p` from a unit quaternion's trace) |
| LX-T4 | the forced-equal subgroup at four colours is `F = P = {w ≥ 1}` | [hand]; its `N = 2` generator is Zaks's Lemma 1 | L4, L5 |
| LX-T5 | the ℚ⁴ compulsion law: forced equal ⟺ `v₂(\|x−y\|²) ≥ 1`, forced different ⟺ `= 0`, free ⟺ `< 0`; every proper 4-colouring is, per component, a bijection of the residue map to `R/P ≅ 𝔽₄` | [hand], one mind (this one), blind to the first | L5, L6 |
| LX-T6 | for `d > 0` with `d² ∈ ℚ`: a 4-colouring of `ℚ⁴` forbidding 1 and `d` exists ⟺ `v₂(d²) = 0` ⟺ `d = √(p/q)`, `p, q` odd; for `d² ∉ ℚ` it always exists | [hand]; the ⟸ half is `[Johnson1990]` Thm 3 | the corollary above |

### Drafts for the owner (not applied; the files are not mine)

1. **`LEDGER.md` row 57**, wording: old *"`A` the Hurwitz order localized away from 2"*; new *"`A` the Hurwitz order localized at 2 (odd
   denominators inverted)"* — "localized away from 2" conventionally means inverting 2, the opposite set; the intended `A` is `R` above.
2. **`CLAUDE.md` G54's reading** (*"a full-rank forced group appears where a lattice is integral at a prime whose target is Hoffman-tight at
   `k` and no other prime's quotient has a gap"*) gains a confirming instance, noncommutative: `ℚ⁴` at four colours, one prime (2), target
   `R/P`'s Cayley graph `K₄` (Hoffman-tight: `λ_min = −1 = −3/3`), `F = P` of full rank. For `plans/GROKKING-INSTANCES.md` §G54, if the owner agrees.
3. **`BIBLIOGRAPHY.md`**, reading status: `[BendaPerles2000]` pp. 113–115 and 117–126 read by LX (2026-09-27), the ℚ⁴ section (pp. 122–125)
   in full; p. 116 not viewed. Zaks 1999 pp. 90–95 read in full by LX, with its three misprints (p. 91 "φ(B) = 4" for φ(D); p. 92 "φ(W)"
   for φ(W₄); p. 92 D = (0,1,0,0) for (1,1,0,0), the last already noted by `[Johnson2006]` p. 212). I did not open the Zaks rows, so the owner
   should merge these against them.
